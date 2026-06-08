METHOD send_integration.

  " -----------------------------------------------------------------------
  " Inner structure that matches the target JSON shape for ONE beneficiary:
  "   { knwReinfR4020:{...}, reinfR4020PgtoList:[...],
  "     knwReinfR4020InfoPgtoList:[...], knwReinfR4020InfoPgtoRetList:[...] }
  " -----------------------------------------------------------------------
  TYPES: BEGIN OF ty_inner,
           knw_reinf_r4020                 TYPE ty_knw_r4020,
           reinf_r4020_pgto_list           TYPE TABLE OF ty_pgto           WITH DEFAULT KEY,
           knw_reinf_r4020_info_pgto_list  TYPE TABLE OF ty_info_pgto      WITH DEFAULT KEY,
           knw_reinf_r4020_info_pgto_ret TYPE TABLE OF ty_info_pgto_ret WITH DEFAULT KEY,
         END OF ty_inner.

  TYPES: BEGIN OF ty_objetos,
           objetos TYPE TABLE OF string WITH DEFAULT KEY,
         END OF ty_objetos.

  DATA: lv_proc      TYPE string,
        lv_sucesso   TYPE abap_boolean,
        lo_ret       TYPE REF TO data.

  IF ls_root IS INITIAL.
    RETURN.
  ENDIF.

  " Build one escaped-JSON string per beneficiary and collect into objetos
  DATA(ls_out) = VALUE ty_objetos( ).

  LOOP AT ls_root-knw_r4020 INTO DATA(ls_hdr).

    DATA(lv_id_ref) = ls_hdr-id_referencia.

" Collect pgto rows that belong to this beneficiary
    DATA lt_pgto TYPE TABLE OF ty_pgto WITH DEFAULT KEY.
    LOOP AT ls_root-knw_reinf_r4020_pgto INTO DATA(ls_pgto) WHERE id_referencia = lv_id_ref.
      APPEND ls_pgto TO lt_pgto.
    ENDLOOP.

    " Collect info_pgto rows
    DATA lt_info TYPE TABLE OF ty_info_pgto WITH DEFAULT KEY.
    LOOP AT ls_root-knw_reinf_r4020_info_pgto INTO DATA(ls_info) WHERE id_referencia = lv_id_ref.
      APPEND ls_info TO lt_info.
    ENDLOOP.

    " Collect info_pgto_ret rows
    DATA lt_ret TYPE TABLE OF ty_info_pgto_ret WITH DEFAULT KEY.
    LOOP AT ls_root-knw_reinf_r4020_info_pgto_ret INTO DATA(ls_ret) WHERE id_referencia = lv_id_ref.
      APPEND ls_ret TO lt_ret.
    ENDLOOP.

    " Compose inner structure
    DATA(ls_inner) = VALUE ty_inner(
      knw_reinf_r4020                    = ls_hdr
      reinf_r4020_pgto_list              = lt_pgto
      knw_reinf_r4020_info_pgto_list     = lt_info
      knw_reinf_r4020_info_pgto_ret = lt_ret ).

    " Serialize inner structure to JSON (compact, camelCase via pretty_name = 'L')
    DATA(lv_inner_json) = /ui2/cl_json=>serialize(
      EXPORTING
        data             = ls_inner
        compress         = abap_true
        pretty_name      = 'L'
        assoc_arrays     = abap_false
        assoc_arrays_opt = abap_false ).

    " Apply your existing field-name conversion (uppercase keys etc.)
    lv_inner_json = /pyxs/sov_json_conversion=>convert_reinf( lv_inner_json ).

    " Escape the JSON string so it becomes a JSON string value
    REPLACE ALL OCCURRENCES OF `\` IN lv_inner_json WITH `\\`.
    REPLACE ALL OCCURRENCES OF `"` IN lv_inner_json WITH `\"`.

    " Add as a string entry in objetos
    APPEND lv_inner_json TO ls_out-objetos.

  ENDLOOP.

  " Wrap everything: {"objetos":["...", "..."]}
  DATA(lv_json_out) = /ui2/cl_json=>serialize(
    EXPORTING
      data             = ls_out
      compress         = abap_true
      pretty_name      = 'L'
      assoc_arrays     = abap_false
      assoc_arrays_opt = abap_false ).

  " --- HTTP call (unchanged logic) ---
  DATA: lr_cscn TYPE if_com_scenario_factory=>ty_query-cscn_id_range.
  lr_cscn = VALUE #( ( sign = 'I' option = 'EQ' low = '/PYXS/SOVOS' ) ).
  DATA(lo_factory) = cl_com_arrangement_factory=>create_instance( ).
  lo_factory->query_ca(
    EXPORTING
      is_query           = VALUE #( cscn_id_range = lr_cscn )
    IMPORTING
      et_com_arrangement = DATA(lt_ca) ).

  IF lt_ca IS INITIAL.
    APPEND INITIAL LINE TO /pyxs/bp_reinflog=>lt_log ASSIGNING FIELD-SYMBOL(<log>).
    GET TIME STAMP FIELD DATA(time).
    <log>-ano_mes    = me->sel-creation[ 1 ]-low.
    <log>-time       = time.
    <log>-evento     = '4000'.
    <log>-partner    = ''.
    <log>-resultado  = '999'.
    <log>-retorno    = 'Cenário de comunicação não encontrado'.
    RETURN.
  ENDIF.

  READ TABLE lt_ca INTO DATA(lo_ca) INDEX 1.

  TRY.
      DATA(lo_dest) = cl_http_destination_provider=>create_by_comm_arrangement(
          comm_scenario  = '/PYXS/SOVOS'
          service_id     = '/PYXS/SOV_REINF2_REST'
          comm_system_id = lo_ca->get_comm_system_id( ) ).

      DATA(lo_http_client) = cl_web_http_client_manager=>create_by_http_destination( lo_dest ).
      DATA(lo_request) = lo_http_client->get_http_request( ).

      lo_request->set_text( i_text = lv_json_out ).
      lo_request->set_uri_path( i_uri_path = '/R4020' ).

      DATA(lo_response) = lo_http_client->execute( if_web_http_client=>post ).
      DATA(lv_ret_status) = lo_response->get_status( ).

      IF lv_ret_status-code = '200'.
        DATA(lv_msg) = lo_response->get_text( ).
        IF lv_msg IS INITIAL.
          lv_proc = 'Successfully processed'(002).
        ELSE.
          lv_proc = lv_msg.
          /ui2/cl_json=>deserialize(
            EXPORTING json = lv_proc
            CHANGING  data = lo_ret ).
          lv_sucesso = lo_ret->('SUCESSO')->*.
          IF lv_sucesso = abap_true.
            lv_proc = 'Successfully processed'(002).
          ELSE.
            lv_ret_status-code = 400.
          ENDIF.
        ENDIF.
      ELSE.
        lv_proc = lo_response->get_text( ).
      ENDIF.

    CATCH cx_web_message_error cx_http_dest_provider_error cx_web_http_client_error.
      " silently caught; status/log handled below
  ENDTRY.

  GET TIME STAMP FIELD time.

  IF lo_ret IS INITIAL.
    APPEND INITIAL LINE TO /pyxs/bp_reinflog=>lt_log ASSIGNING <log>.
    <log>-time      = time.
    READ TABLE ls_root-knw_r4020 INTO DATA(ls_nf) INDEX 1.
    <log>-ano_mes   = me->sel-creation[ 1 ]-low.
    <log>-evento    = '4000'.
    <log>-partner   = ls_nf-id_referencia+6.
    <log>-resultado = COND #( WHEN lv_ret_status IS INITIAL THEN '999' ELSE lv_ret_status-code ).
    <log>-retorno   = COND #( WHEN lv_proc IS NOT INITIAL       THEN lv_proc
                              WHEN lv_ret_status IS NOT INITIAL THEN lv_ret_status-reason
                              ELSE 'Erro no serviço' ).
  ELSE.
    LOOP AT lo_ret->('MENSAGENS')->* ASSIGNING FIELD-SYMBOL(<lv_msg>).
      APPEND INITIAL LINE TO /pyxs/bp_reinflog=>lt_log ASSIGNING <log>.
      <log>-id        = sy-tabix.
      <log>-time      = time.
      READ TABLE ls_root-knw_r4020 INTO ls_nf INDEX 1.
      <log>-ano_mes   = me->sel-creation[ 1 ]-low.
      <log>-evento    = '4000'.
      <log>-partner   = ls_nf-id_referencia+6.
      <log>-resultado = lv_ret_status-code.
      <log>-retorno   = lv_ret_status-reason.
    ENDLOOP.
  ENDIF.

ENDMETHOD.