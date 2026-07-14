CLASS lhc_SOV_PLANO_CONTAS DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR /pyxs/sov_plano_contas RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE /pyxs/sov_plano_contas.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE /pyxs/sov_plano_contas.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE /pyxs/sov_plano_contas.

    METHODS read FOR READ
      IMPORTING keys FOR READ /pyxs/sov_plano_contas RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK /pyxs/sov_plano_contas.

    METHODS sendintegration FOR MODIFY
      IMPORTING keys FOR ACTION /pyxs/sov_plano_contas~sendintegration RESULT result.


ENDCLASS.


CLASS lcl_process DEFINITION FRIENDS lhc_SOV_PLANO_CONTAS.

  PUBLIC SECTION.

TYPES: BEGIN OF ty_sel,
         companycode         TYPE c LENGTH 4,
         branch              TYPE c LENGTH 4,
         accounthierarchy    TYPE c LENGTH 4,
         glaccount           TYPE c LENGTH 10,
         chartofaccounts     TYPE c LENGTH 4,
         ignorefirstnode     TYPE abap_bool,
         validitystartdate   TYPE d,
         validityenddate     TYPE d,
       END OF ty_sel.

TYPES: BEGIN OF ty_knw0600,
         cod_empresa        TYPE string,
         cod_filial         TYPE string,
         id_usuario_imp     TYPE string,
         dt_inicial         TYPE string,
         cd_centro_custo    TYPE string,
         ds_centro_custo    TYPE string,
       END OF ty_knw0600.

TYPES: BEGIN OF ty_knw_sctb_i051,
         cod_empresa        TYPE string,
         cod_filial         TYPE string,
         id_usuario_imp     TYPE string,
         cd_plano_conta     TYPE string,
         cd_centro_custo    TYPE string,
         cd_plano_conta_ref TYPE string,
       END OF ty_knw_sctb_i051.

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
             hierarchynode         TYPE i_glaccounthierarchynode-hierarchynode,
             companycode           TYPE i_companycode-companycode,
             companycodename       TYPE i_companycode-companycodename,
             hierarchynodelevel    TYPE i_glaccounthierarchynode-hierarchynodelevel,
             hierarchynodesequence TYPE i_glaccounthierarchynode-hierarchynodesequence,
             hierarchynodetext     TYPE string, " assuming _Text is a string field
             glaccount             TYPE i_glaccounthierarchynode-glaccount,
             glaccountlongname     TYPE string, " assuming _GLAccountInChartOfAccounts_Text is a string field
             glaccounthierarchy    TYPE i_glaccounthierarchynode-glaccounthierarchy,
             parentnode            TYPE i_glaccounthierarchynode-parentnode,
             validityenddate       TYPE d,
             validitystartdate     TYPE d,
             hierarchyversion      TYPE i_glaccounthierarchynode-hierarchyversion,
             chartofaccounts       TYPE i_glaccounthierarchynode-chartofaccounts,
             chartofaccountsname   TYPE i_chartofaccountstext-chartofaccountsname,
             sequencenumber        TYPE i_glaccounthierarchynode-sequencenumber,
             nodetype              TYPE i_glaccounthierarchynode-nodetype,
             signisinverted        TYPE i_glaccounthierarchynode-signisinverted,
             hierarchynodeval      TYPE i_glaccounthierarchynode-hierarchynodeval,
             glaccountgroup        TYPE i_glaccountinchartofaccounts-glaccountgroup,
             alternativeglaccount  TYPE i_glaccountincompanycode-alternativeglaccount,
           END OF ty_data.

TYPES: BEGIN OF ty_knw_sctb_i051_list,
         knw0600     TYPE ty_knw0600,
         knw_sctb_i051 TYPE ty_knw_sctb_i051,
       END OF ty_knw_sctb_i051_list.

TYPES: BEGIN OF ty_object,
         knw0500     TYPE ty_knw0500,
         knw_sctb_i051_list TYPE STANDARD TABLE OF ty_knw_sctb_i051_list WITH NON-UNIQUE DEFAULT KEY,
       END OF ty_object.

TYPES: BEGIN OF ty_root,
         objetos     TYPE STANDARD TABLE OF ty_object WITH NON-UNIQUE DEFAULT KEY,
       END OF ty_root.

TYPES:
    ty_branch TYPE c LENGTH 4.

    CLASS-DATA:
          s_branch_sov  TYPE /pyxs/sov_branch,
          gt_out        TYPE TABLE OF ty_root,
          sel           TYPE ty_sel,
          t_data        TYPE TABLE OF ty_data,
          gv_proc       TYPE string.

  PRIVATE SECTION.
    CLASS-METHODS:
      read_db,
      build_objects,
      send_integration.

ENDCLASS.


CLASS lhc_SOV_PLANO_CONTAS IMPLEMENTATION.

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

    lcl_process=>sel-accounthierarchy   = key-%param-AccountHierarchy.
    lcl_process=>sel-branch             = key-%param-branch.
    lcl_process=>sel-companycode        = key-%param-companycode.
    lcl_process=>sel-chartofaccounts    = key-%param-ChartOfAccounts.
    lcl_process=>sel-glaccount          = key-%param-GlAccount.
    lcl_process=>sel-ignorefirstnode    = key-%param-IgnoreFirstNode.
    lcl_process=>sel-validityenddate    = key-%param-ValidityEndDate.
    lcl_process=>sel-validitystartdate  = key-%param-ValidityStartDate.

    IF lcl_process=>sel-companycode IS INITIAL OR lcl_process=>sel-branch IS INITIAL.
      APPEND VALUE #( %action-sendintegration = if_abap_behv=>mk-on ) TO failed-/pyxs/sov_plano_contas.
      APPEND VALUE #(
        %msg = new_message_with_text(
          severity = if_abap_behv_message=>severity-error
          text     = 'Empresa e Local de Negócio são obrigatórios' )
        %action-sendintegration = if_abap_behv=>mk-on
      ) TO reported-/pyxs/sov_plano_contas.
    ENDIF.

    CHECK failed-/pyxs/sov_plano_contas IS INITIAL.

    lcl_process=>read_db( ).
    lcl_process=>build_objects( ).
    lcl_process=>send_integration( ).

    APPEND INITIAL LINE TO reported-/pyxs/sov_plano_contas ASSIGNING FIELD-SYMBOL(<fs>).
    <fs>-%cid = key-%cid.
    <fs>-%msg = new_message_with_text(
                  severity = if_abap_behv_message=>severity-information
                  text     = 'Processamento solicitado' ).

    result = VALUE #(
      FOR log IN /pyxs/bp_sov_plano_contas=>lt_log (
        %cid = key-%cid
        %param = VALUE #(
          %data = VALUE #(
            timedate     = log-timedate
            Chartofacc   = log-chartofacc
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


CLASS lsc_SOV_PLANO_CONTAS DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_SOV_PLANO_CONTAS IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
    MODIFY /pyxs/sov_conlog FROM TABLE @/pyxs/bp_sov_plano_contas=>lt_log.
    CLEAR /pyxs/bp_sov_plano_contas=>lt_log.
  ENDMETHOD.

  METHOD cleanup.
    CLEAR /pyxs/bp_sov_plano_contas=>lt_log.
  ENDMETHOD.

  METHOD cleanup_finalize.
    CLEAR /pyxs/bp_sov_plano_contas=>lt_log.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_process IMPLEMENTATION.

    METHOD  read_db.

    SELECT a~hierarchynode,
           c~companycode,
           c~companycodename,
           a~hierarchynodelevel,
           a~hierarchynodesequence,
           a~\_text[ language = 'P' ]-hierarchynodetext,
           a~glaccount,
           a~\_glaccountinchartofaccounts\_text[ language = 'P' ]-glaccountlongname,
           a~glaccounthierarchy,
           a~parentnode,
           a~validityenddate,
           a~validitystartdate,
           a~hierarchyversion,
           a~chartofaccounts,
           a~\_chartofaccounts\_text[ language = 'P' ]-chartofaccountsname,
           a~sequencenumber,
           a~nodetype,
           a~signisinverted,
           a~hierarchynodeval,
           a~\_glaccountinchartofaccounts-glaccountgroup,
           d~alternativeglaccount
     FROM i_glaccounthierarchynode AS a
     LEFT OUTER JOIN  i_companycode AS c
      ON c~chartofaccounts = a~chartofaccounts
      AND c~companycode   = @sel-companycode
     LEFT OUTER JOIN i_glaccountincompanycode AS d
      ON  a~glaccount   = d~glaccount
      AND c~companycode = d~companycode
     WHERE a~glaccounthierarchy IN (
       SELECT glaccounthierarchy
         FROM i_glaccounthierarchynode AS a
        INNER JOIN i_companycode AS c
           ON a~chartofaccounts = c~chartofaccounts
        WHERE c~companycode = @sel-companycode
          AND a~glaccounthierarchy = @sel-accounthierarchy
          AND a~ChartOfAccounts = @sel-chartofaccounts
          AND a~GLAccount = @sel-glaccount )
     ORDER BY hierarchynodelevel, hierarchynodesequence ASCENDING
      INTO TABLE @t_data.

    SELECT SINGLE *
      FROM /pyxs/sov_branch
    WHERE company_code = @sel-companycode
      AND branch = @sel-branch
      INTO @s_branch_sov.

    ENDMETHOD.

    METHOD  build_objects.
    ENDMETHOD.

    METHOD  send_integration.
    ENDMETHOD.

ENDCLASS.