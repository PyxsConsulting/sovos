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
         dm_natureza      TYPE string,
       END OF ty_knw0500,

           BEGIN OF ty_companhia,
             codigocia TYPE string,
           END OF ty_companhia,

           BEGIN OF ty_grupocontabil,
             companhia TYPE ty_companhia,
             codigo    TYPE string,
           END OF ty_grupocontabil,

           BEGIN OF ty_planocontasuperior,
             companhia     TYPE ty_companhia,
             grupocontabil TYPE ty_grupocontabil,
             codigo        TYPE string,
           END OF ty_planocontasuperior,

           BEGIN OF ty_companycode,
             companycode     TYPE i_companycode-companycode,
             companycodename TYPE i_companycode-companycodename,
           END OF ty_companycode,

           BEGIN OF ty_comp_2,
             codigocia TYPE string,
             descricao TYPE string,
           END OF ty_comp_2,

           BEGIN OF ty_main_2,
             companhia          TYPE ty_comp_2,
             codigo             TYPE string,
             descricao          TYPE string,
             dataefetividadede  TYPE string,
             dataefetividadeate TYPE string,
           END OF ty_main_2.

    TYPES: BEGIN OF ty_gl_account,
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
           END OF ty_gl_account.

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
          gs_out_obj    TYPE ty_root,
          sel           TYPE ty_sel,
          t_data        TYPE TABLE OF ty_data,
          gt_main2      TYPE TABLE OF ty_main_2,
          gv_grupo              TYPE string,
          ls_company            TYPE ty_companycode,
          gv_chartofaccounts    TYPE i_companycode-chartofaccounts,
          gv_date_from          TYPE string,
          gv_date_to            TYPE string,
          gv_date_start         TYPE string,
          gt_account_type       TYPE TABLE OF /pyxs/sov_acctyp,
          gv_proc       TYPE string,
          gs_planocontasuperior TYPE ty_planocontasuperior.

  PRIVATE SECTION.
    CLASS-METHODS:

      add_children_nodes IMPORTING i_main TYPE ty_gl_account,
      add_tree_node IMPORTING i_main TYPE ty_gl_account,
      add_final_node IMPORTING i_main TYPE ty_gl_account,
      process_node IMPORTING i_main TYPE ty_gl_account,
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

    DATA lr_glaccount TYPE RANGE OF i_glaccounthierarchynode-glaccount.
    DATA lr_accounthierarchy TYPE RANGE OF i_glaccounthierarchynode-glaccounthierarchy.

    IF sel-glaccount IS NOT INITIAL.
      lr_glaccount = VALUE #(
        ( sign   = 'I'
          option = 'EQ'
          low    = sel-glaccount ) ).
    ENDIF.
    IF sel-accounthierarchy IS NOT INITIAL.
      lr_accounthierarchy = VALUE #(
        ( sign   = 'I'
          option = 'EQ'
          low    = sel-accounthierarchy ) ).
    ENDIF.

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
          AND a~glaccounthierarchy IN @lr_accounthierarchy
          AND a~ChartOfAccounts = @sel-chartofaccounts
          AND a~GLAccount IN @lr_glaccount )
     ORDER BY hierarchynodelevel, hierarchynodesequence ASCENDING
      INTO TABLE @t_data.

    SELECT SINGLE *
      FROM /pyxs/sov_branch
    WHERE company_code = @sel-companycode
      AND branch = @sel-branch
      INTO @s_branch_sov.

    SELECT * FROM /pyxs/sov_acctyp ORDER BY accprefix DESCENDING INTO TABLE @gt_account_type.

    gv_date_start = sel-validitystartdate && '-01-01T00:00:00'.
    gv_date_from  = sel-validitystartdate && '-' && sel-validitystartdate+4(2) && '-' && sel-validitystartdate+6(2) && 'T00:00:00'.
    gv_date_to = '2199-12-31T00:00:00'.

    ENDMETHOD.

    METHOD  build_objects.

    LOOP AT t_data INTO DATA(ls_root).

      CHECK ls_root-chartofaccounts IS NOT INITIAL.
      APPEND INITIAL LINE TO gt_main2 ASSIGNING FIELD-SYMBOL(<grp>).
      <grp>-companhia-codigocia = s_branch_sov-sov_company.
      <grp>-companhia-descricao = s_branch_sov-sov_branch.
      <grp>-codigo = ls_root-chartofaccounts.
      <grp>-descricao = ls_root-chartofaccountsname.
      gv_grupo = <grp>-codigo.
      <grp>-dataefetividadede = gv_date_start.
      <grp>-dataefetividadeate = '2199-12-31T00:00:00'.
      gv_chartofaccounts = ls_root-chartofaccounts.
      EXIT.
    ENDLOOP.

    IF sel-ignorefirstnode = abap_true.
      DELETE t_data WHERE nodetype = 'R'.
      READ TABLE t_data INTO DATA(ls_main) INDEX 1.
      CHECK sy-subrc IS INITIAL.
    ENDIF.

    process_node( ls_main ).

    ENDMETHOD.

  METHOD process_node.
    CASE i_main-nodetype.
      WHEN 'R'. "root node
*        add_tree_node( i_main ).
        add_children_nodes( i_main ).
      WHEN 'N'. "tree node
*        add_tree_node( i_main ).
        add_children_nodes( i_main ).
      WHEN 'L'. "GL account
        add_final_node( i_main ).
    ENDCASE.
  ENDMETHOD.

  METHOD add_children_nodes.

    LOOP AT t_data INTO DATA(ls_main) WHERE parentnode = i_main-hierarchynode.
      process_node( ls_main ).
    ENDLOOP.

  ENDMETHOD.

  METHOD add_tree_node.
  ENDMETHOD.

  METHOD add_final_node.
    TYPES ty_char10 TYPE c LENGTH 10.
    DATA:
          ls_out TYPE ty_object.

    DATA: lv_str TYPE i.

    DATA: lv_timestamp TYPE string.

    lv_timestamp = sy-datum(4) && '-' && sy-datum+4(2) && '-' && sy-datum+6(2) && 'T12:00:00+03:00'.

    ls_out-knw0500-cod_empresa = s_branch_sov-sov_company.
    ls_out-knw0500-cod_filial = s_branch_sov-sov_branch.
    ls_out-knw0500-dt_inicial = '1900-01-01T12:00:00+03:00'.
    ls_out-knw0500-dt_importacao = lv_timestamp.
    ls_out-knw0500-cd_plano_conta = i_main-glaccount.
    ls_out-knw0500-ds_plano_conta = i_main-glaccountlongname.
    ls_out-knw0500-dm_nivel = i_main-hierarchynodelevel - 1.
    ls_out-knw0500-dm_tipo_conta = 'A'.



    DATA(lv_account) = CONV ty_char10( i_main-glaccount ).
    SHIFT lv_account LEFT DELETING LEADING '0'.

    LOOP AT gt_account_type INTO DATA(ls_account_type).
      CLEAR lv_str.
      DATA(lv_prefix) = CONV ty_char10( ls_account_type-accprefix ).
      SHIFT lv_prefix LEFT DELETING LEADING '0'.
      lv_str = strlen( lv_prefix ).
      IF lv_account(lv_str) = lv_prefix.
        ls_out-knw0500-dm_natureza = ls_account_type-codigoacc.
        EXIT.
      ENDIF.
    ENDLOOP.
    IF ls_out-knw0500-dm_natureza IS INITIAL.
        CASE lv_account(1).
          WHEN '1'.
            ls_out-knw0500-dm_natureza = '1'.
          WHEN '2'.
            ls_out-knw0500-dm_natureza = '2'.
          WHEN '3'.
            ls_out-knw0500-dm_natureza = '3'.
          WHEN '4'.
            ls_out-knw0500-dm_natureza = '4'.
          WHEN '5'.
            ls_out-knw0500-dm_natureza = '5'.
          WHEN '6'.
            ls_out-knw0500-dm_natureza = '6'.
          WHEN '7'.
            ls_out-knw0500-dm_natureza = '7'.
          WHEN '8'.
            ls_out-knw0500-dm_natureza = '8'.
          WHEN OTHERS.
            ls_out-knw0500-dm_natureza = '9'.
        ENDCASE.
    ENDIF.

    APPEND ls_out TO gs_out_obj-objetos.

  ENDMETHOD.

    METHOD send_integration.

        DATA: lo_ret     TYPE REF TO data,
              lv_sucesso TYPE abap_boolean.

      APPEND gs_out_obj TO gt_out.

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
                  i_uri_path = '/api/knw/v2/planoconta'
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
            APPEND INITIAL LINE TO /pyxs/bp_sov_plano_contas=>lt_log ASSIGNING FIELD-SYMBOL(<log>).
                <log>-timedate     = time.
                <log>-chartofacc   = ls_doc-objetos[ 1 ]-knw0500-cd_plano_conta.
                <log>-id           = ls_doc-objetos[ 1 ]-knw0500-dm_nivel.
                <log>-returncode   = lv_ret-code.
                <log>-returnreason = lv_ret-reason.
                <log>-response     = gv_proc.
          ELSE.
            LOOP AT lo_ret->('MENSAGENS')->* ASSIGNING FIELD-SYMBOL(<lv_msg>).
              APPEND INITIAL LINE TO /pyxs/bp_sov_plano_contas=>lt_log ASSIGNING <log>.
                <log>-timedate     = time.
                <log>-chartofacc   = ls_doc-objetos[ 1 ]-knw0500-cd_plano_conta.
                <log>-id           = ls_doc-objetos[ 1 ]-knw0500-dm_nivel.
                <log>-returncode   = lv_ret-code.
                <log>-returnreason = lv_ret-reason.
                <log>-response     = <lv_msg>->*.
            ENDLOOP.
          ENDIF.

        ENDLOOP.



    ENDMETHOD.

ENDCLASS.