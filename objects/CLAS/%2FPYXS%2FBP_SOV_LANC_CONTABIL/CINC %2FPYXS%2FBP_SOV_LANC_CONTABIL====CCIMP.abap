CLASS lhc_SOV_LANC_CONTABIL DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR /pyxs/sov_lanc_contabil RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE /pyxs/sov_lanc_contabil.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE /pyxs/sov_lanc_contabil.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE /pyxs/sov_lanc_contabil.

    METHODS read FOR READ
      IMPORTING keys FOR READ /pyxs/sov_lanc_contabil RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK /pyxs/sov_lanc_contabil.

    METHODS sendintegration FOR MODIFY
      IMPORTING keys FOR ACTION /pyxs/sov_lanc_contabil~sendintegration RESULT result.

ENDCLASS.

CLASS lcl_process DEFINITION FRIENDS lhc_SOV_LANC_CONTABIL.

  PUBLIC SECTION.

  TYPES: BEGIN OF ty_sel,
         companycode         TYPE c LENGTH 4,
         branch              TYPE c LENGTH 4,
         ledger              TYPE c LENGTH 2,
         fiscalyear          TYPE c LENGTH 4,
         accountingdocument  TYPE c LENGTH 10,
         postingstartdate    TYPE d,
         postingenddate      TYPE d,
       END OF ty_sel.

TYPES: BEGIN OF ty_knw_sctb_i200,
         nr_lancamento     TYPE string,
         dt_lancamento     TYPE string,
         vl_lancamento     TYPE string,
         dm_lancamento     TYPE string,
         vl_lancamento_mf  TYPE string,
         cod_empresa       TYPE string,
         cod_filial        TYPE string,
       END OF ty_knw_sctb_i200.

TYPES: BEGIN OF ty_knw_sctb_i250,
         nr_lancamento     TYPE string,
         vl_lancamento     TYPE string,
         vl_lancamento_mf  TYPE string,
         ds_historico      TYPE string,
         dm_debito_credito TYPE string,
         cod_empresa       TYPE string,
         cod_filial        TYPE string,
         cd_plano_conta    TYPE string,
       END OF ty_knw_sctb_i250.

TYPES: BEGIN OF ty_knw0500,
         dt_inicial       TYPE string,
         dm_tipo_conta    TYPE string,
         ds_plano_conta   TYPE string,
         dm_nivel         TYPE string,
         dt_importacao    TYPE string,
         id_ordem         TYPE string,
         cod_empresa      TYPE string,
         cod_filial       TYPE string,
         cd_plano_conta   TYPE string,
       END OF ty_knw0500.


TYPES: BEGIN OF ty_data,
        hdr TYPE i_journalentry,
        itm TYPE i_journalentryitem,
        cpn TYPE i_companycode,
        glaccountname        TYPE i_glaccounttextincompanycode-glaccountname,
      END OF ty_data.

TYPES: BEGIN OF ty_knw_sctb_i250_list,
         knw0500     TYPE ty_knw0500,
         knw_sctb_i250 TYPE ty_knw_sctb_i250,
       END OF ty_knw_sctb_i250_list.

TYPES: BEGIN OF ty_object,
         knw_sctb_i200     TYPE ty_knw_sctb_i200,
         knw_sctb_i250_list TYPE STANDARD TABLE OF ty_knw_sctb_i250_list WITH NON-UNIQUE DEFAULT KEY,
       END OF ty_object.

TYPES: BEGIN OF ty_root,
         objetos     TYPE STANDARD TABLE OF ty_object WITH NON-UNIQUE DEFAULT KEY,
       END OF ty_root.

TYPES:
    ty_branch TYPE c LENGTH 4.

    CLASS-DATA:
          s_branch_sov  TYPE /pyxs/sov_branch,
          gt_out        TYPE TABLE OF ty_root,
          businessplace TYPE i_br_businessplace,
          sel           TYPE ty_sel,
          t_data        TYPE TABLE OF ty_data,
          gv_proc       TYPE string.

  PRIVATE SECTION.
    CLASS-METHODS:
      read_db,
      build_objects,
      send_integration.

ENDCLASS.

CLASS lhc_SOV_LANC_CONTABIL IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD create.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD SendIntegration.

    DATA(key) = keys[ 1 ].

    lcl_process=>sel-accountingdocument = key-%param-accountingdocument.
    lcl_process=>sel-branch             = key-%param-branch.
    lcl_process=>sel-companycode        = key-%param-companycode.
    lcl_process=>sel-fiscalyear         = key-%param-fiscalyear.
    lcl_process=>sel-ledger             = key-%param-ledger.
    lcl_process=>sel-postingstartdate   = key-%param-postingstartdate.
    lcl_process=>sel-postingenddate     = key-%param-postingenddate.

    IF lcl_process=>sel-companycode IS INITIAL OR lcl_process=>sel-branch IS INITIAL.
      APPEND VALUE #( %action-sendintegration = if_abap_behv=>mk-on ) TO failed-/pyxs/sov_lanc_contabil.
      APPEND VALUE #(
        %msg = new_message_with_text(
          severity = if_abap_behv_message=>severity-error
          text     = 'Empresa e Local de Negócio são obrigatórios' )
        %action-sendintegration = if_abap_behv=>mk-on
      ) TO reported-/pyxs/sov_lanc_contabil.
    ENDIF.

    CHECK failed-/pyxs/sov_lanc_contabil IS INITIAL.

    lcl_process=>read_db( ).
    lcl_process=>build_objects( ).
    lcl_process=>send_integration( ).

    APPEND INITIAL LINE TO reported-/pyxs/sov_lanc_contabil ASSIGNING FIELD-SYMBOL(<fs>).
    <fs>-%cid = key-%cid.
    <fs>-%msg = new_message_with_text(
                  severity = if_abap_behv_message=>severity-information
                  text     = 'Processamento solicitado' ).

    result = VALUE #(
      FOR log IN /pyxs/bp_sov_lanc_contabil=>lt_log (
        %cid = key-%cid
        %param = VALUE #(
          %data = VALUE #(
            timedate     = log-timedate
            lancamento   = log-lancamento
            id           = log-id
            returncode   = log-returncode
            returnreason = log-returnreason
            response     = log-response
          )
        )
      )
    ).

  ENDMETHOD.

ENDCLASS.

CLASS lsc_SOV_LANC_CONTABIL DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_SOV_LANC_CONTABIL IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
    MODIFY /pyxs/sov_conlog FROM TABLE @/pyxs/bp_sov_lanc_contabil=>lt_log.
    CLEAR /pyxs/bp_sov_lanc_contabil=>lt_log.
  ENDMETHOD.

  METHOD cleanup.
    CLEAR /pyxs/bp_sov_lanc_contabil=>lt_log.
  ENDMETHOD.

  METHOD cleanup_finalize.
    CLEAR /pyxs/bp_sov_lanc_contabil=>lt_log.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_process IMPLEMENTATION.

    METHOD  read_db.

    DATA lr_postingdates TYPE RANGE OF i_journalentry-postingdate.

    lr_postingdates = VALUE #(
      (
        sign   = 'I'
        option = 'BT'
        low    = lcl_process=>sel-postingstartdate
        high   = lcl_process=>sel-postingenddate
      )
    ).

    SELECT hdr~*, itm~*, cpn~*,
    i_glaccount~\_text[ language = 'P' ]-glaccountname
      FROM i_journalentry WITH PRIVILEGED ACCESS AS hdr
      INNER JOIN i_journalentryitem WITH PRIVILEGED ACCESS AS itm
          ON hdr~companycode = itm~companycode
          AND hdr~accountingdocument = itm~accountingdocument
          AND hdr~fiscalyear = itm~fiscalyear
      INNER JOIN i_companycode WITH PRIVILEGED ACCESS AS cpn
          ON cpn~companycode = hdr~companycode
      LEFT JOIN i_glaccount
      ON i_glaccount~glaccount = itm~glaccount
      AND i_glaccount~companycode = @sel-companycode
      WHERE hdr~companycode = @sel-companycode
        AND hdr~postingdate IN @lr_postingdates
        AND hdr~accountingdocument = @sel-accountingdocument
        AND hdr~fiscalyear = @sel-fiscalyear
        "AND hdr~accountingdocumenttype = @sel-
        AND hdr~accountingdocumentcategory NOT IN ('D','S','V','W','Z','M')
        "AND itm~glaccount = @sel-
        AND itm~sourceledger = @sel-ledger
        AND hdr~Branch = @sel-branch
*        AND hdr~AccountingDocumentCategory IN @open
        INTO TABLE @t_data.

    SELECT SINGLE *
      FROM /pyxs/sov_branch
    WHERE company_code = @sel-companycode
      AND branch = @sel-branch
      INTO @s_branch_sov.

    ENDMETHOD.


    METHOD  build_objects.
    DATA:
          ls_out TYPE ty_object,
          ls_out_obj TYPE ty_root.
    DATA:
          lt_journalkeys TYPE STANDARD TABLE OF i_journalentryitem-accountingdocument,
          lv_key         TYPE i_journalentryitem-accountingdocument,
          lv_vl_lancto   TYPE p DECIMALS 2.

    FIELD-SYMBOLS: <ls_i250_list> TYPE ty_knw_sctb_i250_list.

    CLEAR: gt_out, ls_out_obj.

    " 1) monta lista de AccountingDocument únicos
    lt_journalkeys = VALUE #( FOR line IN t_data ( line-itm-accountingdocument ) ).

    SORT lt_journalkeys.
    DELETE ADJACENT DUPLICATES FROM lt_journalkeys.

    LOOP AT lt_journalkeys INTO lv_key.

      CLEAR: ls_out, lv_vl_lancto.

      LOOP AT t_data INTO DATA(ls_data) WHERE itm-accountingdocument = lv_key.

        " ---- knwSctbI200 (cabeçalho) ----
        ls_out-knw_sctb_i200-nr_lancamento    = ls_data-itm-accountingdocument.
        ls_out-knw_sctb_i200-dt_lancamento    = ls_data-itm-postingdate.

        IF ls_data-itm-debitcreditcode = 'H'.
          lv_vl_lancto += abs( ls_data-itm-amountincompanycodecurrency ).
        ENDIF.

        IF ls_data-itm-glrecordtype = '5'.
          ls_out-knw_sctb_i200-dm_lancamento = 'E'.
        ELSE.
          ls_out-knw_sctb_i200-dm_lancamento = 'N'.
        ENDIF.

        ls_out-knw_sctb_i200-vl_lancamento_mf = 0.
        ls_out-knw_sctb_i200-cod_empresa      = s_branch_sov-sov_company.
        ls_out-knw_sctb_i200-cod_filial       = s_branch_sov-sov_branch.

        " ---- knwSctbI250_list (item) ----
        APPEND INITIAL LINE TO ls_out-knw_sctb_i250_list ASSIGNING <ls_i250_list>.

        " knw0500
        <ls_i250_list>-knw0500-dt_inicial      = '1900-01-01T12:00:00+03:00'.
        <ls_i250_list>-knw0500-dm_tipo_conta   = 'A'.
        <ls_i250_list>-knw0500-ds_plano_conta  = ls_data-glaccountname.
        <ls_i250_list>-knw0500-cod_empresa     = s_branch_sov-sov_company.
        <ls_i250_list>-knw0500-cod_filial      = s_branch_sov-sov_branch.
        <ls_i250_list>-knw0500-cd_plano_conta  = ls_data-itm-glaccount.

        " knwSctbI250
        <ls_i250_list>-knw_sctb_i250-nr_lancamento    = ls_data-itm-accountingdocument.
        <ls_i250_list>-knw_sctb_i250-vl_lancamento    = abs( ls_data-itm-amountincompanycodecurrency ).
        <ls_i250_list>-knw_sctb_i250-vl_lancamento_mf = 0.
        <ls_i250_list>-knw_sctb_i250-ds_historico     = |Sequência: { ls_data-itm-ledgergllineitem }|.

        IF ls_data-itm-debitcreditcode = 'H'.
          <ls_i250_list>-knw_sctb_i250-dm_debito_credito = 'C'.
        ELSE.
          <ls_i250_list>-knw_sctb_i250-dm_debito_credito = 'D'.
        ENDIF.

        <ls_i250_list>-knw_sctb_i250-cod_empresa   = s_branch_sov-sov_company.
        <ls_i250_list>-knw_sctb_i250-cod_filial    = s_branch_sov-sov_branch.
        <ls_i250_list>-knw_sctb_i250-cd_plano_conta = ls_data-itm-glaccount.

      ENDLOOP.

      " VL_LANCAMENTO final do cabeçalho (soma só dos créditos)
      ls_out-knw_sctb_i200-vl_lancamento = lv_vl_lancto.

      APPEND ls_out TO ls_out_obj-objetos.

    ENDLOOP.
    APPEND ls_out_obj TO gt_out.

    ENDMETHOD.


    METHOD  send_integration.

    DATA: lo_ret     TYPE REF TO data,
          lv_sucesso TYPE abap_boolean.

    LOOP AT gt_out INTO DATA(ls_doc).

      DATA(json_out) = /ui2/cl_json=>serialize(
        EXPORTING
          data             = ls_doc
          compress         = abap_true
          pretty_name      = /ui2/cl_json=>pretty_mode-none
          assoc_arrays     = abap_false
          assoc_arrays_opt = abap_false
      ).

      json_out = /pyxs/sov_json_conversion=>convert_sovos( json_out ).
      DATA: lr_cscn TYPE if_com_scenario_factory=>ty_query-cscn_id_range.

      " find CA by scenario
      lr_cscn = VALUE #( ( sign = 'I' option = 'EQ' low = '/PYXS/SOVOS' ) ).
      DATA(lo_factory) = cl_com_arrangement_factory=>create_instance( ).
      lo_factory->query_ca(
        EXPORTING
          is_query           = VALUE #( cscn_id_range = lr_cscn )
        IMPORTING
          et_com_arrangement = DATA(lt_ca) ).

      READ TABLE lt_ca INTO DATA(lo_ca) INDEX 1.
      TRY.
          DATA(lo_dest) = cl_http_destination_provider=>create_by_comm_arrangement(
              comm_scenario  = '/PYXS/SOVOS'
              service_id     = '/PYXS/TCO_SOVOS_REST'
              comm_system_id = lo_ca->get_comm_system_id( ) ).

          DATA(lo_http_client) = cl_web_http_client_manager=>create_by_http_destination( lo_dest ).

          " execute the request
          DATA(lo_request) = lo_http_client->get_http_request( ).
          lo_request->set_text(
            EXPORTING
              i_text   = json_out
          ).

          lo_request->set_uri_path(
            EXPORTING
              i_uri_path = '/api/knw/v2/lancamentosContabeis'
          ).

          DATA(lo_response) = lo_http_client->execute( if_web_http_client=>post ).
          DATA(lv_ret) = lo_response->get_status( ).
          CLEAR lo_ret.
          IF lv_ret-code = '200'.
            DATA(lv_msg) = lo_response->get_text( ).
            IF lv_msg IS INITIAL.
              gv_proc = 'Successfully processed'(002).
            ELSE.
              gv_proc = lv_msg.
              /ui2/cl_json=>deserialize(
                 EXPORTING
                   json             = gv_proc
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

      GET TIME STAMP FIELD DATA(time).

      IF lo_ret IS INITIAL.
        APPEND INITIAL LINE TO /pyxs/bp_sov_lanc_contabil=>lt_log ASSIGNING FIELD-SYMBOL(<log>).
            <log>-timedate     = time.
            <log>-lancamento   = ls_doc-objetos[ 1 ]-knw_sctb_i200-nr_lancamento.
            <log>-id           = ls_doc-objetos[ 1 ]-knw_sctb_i200-dm_lancamento.
            <log>-returncode   = lv_ret-code.
            <log>-returnreason = lv_ret-reason.
            <log>-response     = gv_proc.
      ELSE.
        LOOP AT lo_ret->('MENSAGENS')->* ASSIGNING FIELD-SYMBOL(<lv_msg>).
          APPEND INITIAL LINE TO /pyxs/bp_sov_lanc_contabil=>lt_log ASSIGNING <log>.
            <log>-timedate     = time.
            <log>-lancamento   = ls_doc-objetos[ 1 ]-knw_sctb_i200-nr_lancamento.
            <log>-id           = ls_doc-objetos[ 1 ]-knw_sctb_i200-dm_lancamento.
            <log>-returncode   = lv_ret-code.
            <log>-returnreason = lv_ret-reason.
            <log>-response     = <lv_msg>->*.
        ENDLOOP.
      ENDIF.

    ENDLOOP.

    ENDMETHOD.

ENDCLASS.