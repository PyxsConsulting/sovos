  METHOD send_integration.
    DATA: gv_proc            TYPE string.
    DATA: lo_ret     TYPE REF TO data,
          lv_sucesso TYPE abap_boolean.
*    DATA lt_doc TYPE TABLE OF zpyxssped_nf_out.
*      CLEAR lt_doc[].
*      APPEND ls_doc TO lt_doc.
    DATA(json_out) = /ui2/cl_json=>serialize(
      EXPORTING
        data             = ls_root
        compress         = abap_true
*        name             =
         pretty_name      = 'L'
*        type_descr       =
         assoc_arrays     = abap_false
*        ts_as_iso8601    =
*        expand_includes  =
         assoc_arrays_opt = abap_false
*        numc_as_string   =
*        name_mappings    =
*        conversion_exits =
*        format_output    =
*        hex_as_base64    =
*      RECEIVING
*        r_json           =
    ).

    json_out = /pyxs/sov_json_conversion=>convert_json( json_out ).
    DATA: lr_cscn TYPE if_com_scenario_factory=>ty_query-cscn_id_range.

    " find CA by scenario
    lr_cscn = VALUE #( ( sign = 'I' option = 'EQ' low = '/PYXS/SOVOS_REINF' ) ).
    DATA(lo_factory) = cl_com_arrangement_factory=>create_instance( ).
    lo_factory->query_ca(
      EXPORTING
        is_query           = VALUE #( cscn_id_range = lr_cscn )
      IMPORTING
        et_com_arrangement = DATA(lt_ca) ).

    IF lt_ca IS INITIAL.
      APPEND INITIAL LINE TO /pyxs/bp_reinflog=>lt_log ASSIGNING FIELD-SYMBOL(<log>).
      GET TIME STAMP FIELD DATA(time).
      <log>-ano_mes = me->sel-creation[ 1 ]-low.
      <log>-time = time.
      <log>-evento = '4000'.
      <log>-partner = ''.
      <log>-resultado = '999'.
      <log>-retorno = 'Cenário de comunicação não encontrado'.
      EXIT.
    ENDIF.

    " take the first one
    READ TABLE lt_ca INTO DATA(lo_ca) INDEX 1.

    " get destination based to Communication Arrangement
    TRY.
        DATA(lo_dest) = cl_http_destination_provider=>create_by_comm_arrangement(
            comm_scenario  = '/PYXS/SOVOS_REINF'
            service_id     = '/PYXS/SOVOS_REINF_REST'
            comm_system_id = lo_ca->get_comm_system_id( ) ).

        DATA(lo_http_client) = cl_web_http_client_manager=>create_by_http_destination( lo_dest ).

        " execute the request
        DATA(lo_request) = lo_http_client->get_http_request( ).
        lo_request->set_text(
          EXPORTING
            i_text   = json_out
*            i_offset = 0
*            i_length = -1
*          RECEIVING
*            r_value  =
        ).

        lo_request->set_uri_path(
          EXPORTING
            i_uri_path = '/R4020'
*              multivalue = 0
*            RECEIVING
*              r_value    =
        ).



        DATA(lo_response) = lo_http_client->execute( if_web_http_client=>post ).
        DATA(lv_ret) = lo_response->get_status( ).
        IF lv_ret-code = '200'.
          DATA(lv_msg) = lo_response->get_text( ).
          IF lv_msg IS INITIAL.
            gv_proc = 'Successfully processed'(002).
          ELSE.
            gv_proc = lv_msg.
            /ui2/cl_json=>deserialize(
               EXPORTING
                 json             = gv_proc
*                  jsonx            =
*                  jsonx_cp         = `UTF-8`
*                  pretty_name      =
*                  assoc_arrays     =
*                  assoc_arrays_opt =
*                  name_mappings    =
*                  conversion_exits =
*                  hex_as_base64    =
*                  gen_optimize     =
              CHANGING
                data             = lo_ret
            ).
            lv_sucesso = lo_ret->('SUCESSO')->*.
            IF lv_sucesso = abap_true.
              gv_proc = 'Successfully processed'(002).
            ELSE.
              lv_ret-code = 400.
            ENDIF.
          ENDIF.
        ELSE.
          gv_proc = lo_response->get_text( ). "|{ 'Error'(003) }: { lv_ret-reason }|.
        ENDIF.

      CATCH cx_web_message_error.


      CATCH cx_http_dest_provider_error.
        IF sy-subrc <> 0.
        ENDIF.

      CATCH cx_web_http_client_error.
        IF sy-subrc <> 0.
        ENDIF.
    ENDTRY.
    GET TIME STAMP FIELD time.

    IF lo_ret IS INITIAL.
      APPEND INITIAL LINE TO /pyxs/bp_reinflog=>lt_log ASSIGNING <log>.
      <log>-time = time.
      READ TABLE ls_root-knw_r4020 INTO DATA(ls_nf) INDEX 1.

      <log>-ano_mes = me->sel-creation[ 1 ]-low.
      <log>-evento = '4000'.
      <log>-partner = ls_nf-id_referencia+6.
      <log>-resultado = COND #( WHEN lv_ret IS INITIAL THEN '999' ELSE lv_ret-code ).
      <log>-retorno = COND #( WHEN gv_proc IS NOT INITIAL THEN gv_proc
                              WHEN lv_ret IS NOT INITIAL THEN lv_ret-reason
                              ELSE 'Erro no serviço' ).

    ELSE.

      LOOP AT lo_ret->('MENSAGENS')->* ASSIGNING FIELD-SYMBOL(<lv_msg>).
        APPEND INITIAL LINE TO /pyxs/bp_reinflog=>lt_log ASSIGNING <log>.
        <log>-id = sy-tabix.
        <log>-time = time.
        READ TABLE ls_root-knw_r4020 INTO ls_nf INDEX 1.

        <log>-ano_mes = me->sel-creation[ 1 ]-low.
        <log>-evento = '4000'.
        <log>-partner = ls_nf-id_referencia+6.
        <log>-resultado = lv_ret-code.
        <log>-retorno = lv_ret-reason.
      ENDLOOP.
    ENDIF.

  ENDMETHOD.