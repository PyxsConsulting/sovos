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
      END OF ty_data.

TYPES: BEGIN OF ty_knw_sctb_i250_list,
         knw0500     TYPE ty_knw0500,
         knw_sctb_i250 TYPE ty_knw_sctb_i250,
       END OF ty_knw_sctb_i250_list.

TYPES: BEGIN OF ty_object,
         knw_sctb_i200     TYPE ty_knw_sctb_i200,
         knw_sctb_i250_list TYPE STANDARD TABLE OF ty_knw_sctb_i250_list WITH NON-UNIQUE DEFAULT KEY,
       END OF ty_object.

TYPES:
    ty_branch TYPE c LENGTH 4.

    CLASS-DATA:
          gt_out        TYPE TABLE OF ty_object,
          businessplace TYPE i_br_businessplace,
          sel           TYPE ty_sel,
          t_data        TYPE TABLE OF ty_data.

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

    SELECT hdr~*, itm~*, cpn~*
      FROM i_journalentry WITH PRIVILEGED ACCESS AS hdr
      INNER JOIN i_journalentryitem WITH PRIVILEGED ACCESS AS itm
          ON hdr~companycode = itm~companycode
          AND hdr~accountingdocument = itm~accountingdocument
          AND hdr~fiscalyear = itm~fiscalyear
      INNER JOIN i_companycode WITH PRIVILEGED ACCESS AS cpn
          ON cpn~companycode = hdr~companycode
      WHERE hdr~companycode = @sel-companycode
        AND hdr~postingdate IN @lr_postingdates
        AND hdr~accountingdocument = @sel-accountingdocument
        AND hdr~fiscalyear = @sel-fiscalyear
        "AND hdr~accountingdocumenttype = @sel-
        AND hdr~accountingdocumentcategory NOT IN ('D','S','V','W','Z','M')
        "AND itm~glaccount = @sel-
        AND itm~sourceledger = @sel-ledger
        "AND hdr~Branch = @sel-branch
*        AND hdr~AccountingDocumentCategory IN @open
        INTO TABLE @t_data.

    IF sy-subrc IS INITIAL.
      SELECT SINGLE *
          FROM i_addlcompanycodeinformation WITH PRIVILEGED ACCESS
          WHERE companycode = @sel-companycode
            AND companycodeparametertype = 'J_1BBR'
          INTO @DATA(ls_addlcompanycodeinformation).

      DATA(lv_branch) = CONV ty_branch( ls_addlcompanycodeinformation-companycodeparametervalue ).

      SELECT SINGLE *
        FROM i_br_businessplace WITH PRIVILEGED ACCESS
        WHERE companycode = @sel-companycode
          AND branch      = @lv_branch
        INTO @businessplace.
    ENDIF.

    ENDMETHOD.


    METHOD  build_objects.
    ENDMETHOD.


    METHOD  send_integration.
    ENDMETHOD.

ENDCLASS.