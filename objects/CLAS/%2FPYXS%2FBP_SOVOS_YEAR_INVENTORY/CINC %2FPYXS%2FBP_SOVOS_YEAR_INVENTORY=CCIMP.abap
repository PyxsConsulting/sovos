CLASS lhc_sovos_year_inventory DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR /pyxs/sovos_year_inventory RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE /pyxs/sovos_year_inventory.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE /pyxs/sovos_year_inventory.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE /pyxs/sovos_year_inventory.

    METHODS read FOR READ
      IMPORTING keys FOR READ /pyxs/sovos_year_inventory RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK /pyxs/sovos_year_inventory.

    METHODS sendintegration FOR MODIFY
      IMPORTING keys FOR ACTION /pyxs/sovos_year_inventory~sendintegration RESULT res.

ENDCLASS.


CLASS lcl_process DEFINITION FRIENDS lhc_sovos_year_inventory.
  PUBLIC SECTION.
    CLASS-METHODS: main,
      build_cnpj
        IMPORTING
                  input         TYPE string
        RETURNING VALUE(output) TYPE string.
    TYPES:
      BEGIN OF ty_knwh030,
        cod_empresa     TYPE p LENGTH 15 DECIMALS 2,
        cod_filial      TYPE p LENGTH 15 DECIMALS 2,
        id_usuario_imp  TYPE string,
        cd_produto_serv TYPE string,
        dm_sit_estoque  TYPE string,
        cd_pessoa_propr TYPE string,
        vl_icms_op      TYPE p LENGTH 15 DECIMALS 2,
        vl_bc_icms_st   TYPE p LENGTH 15 DECIMALS 2,
        vl_icms_st      TYPE p LENGTH 15 DECIMALS 2,
        vl_fcp          TYPE p LENGTH 15 DECIMALS 2,
        dt_inventario   TYPE string,
      END OF ty_knwh030,


      BEGIN OF ty_knwh020list,
        cod_empresa      TYPE p LENGTH 15 DECIMALS 2,
        cod_filial       TYPE p LENGTH 15 DECIMALS 2,
        id_usuario_imp   TYPE string,
        cd_produto_serv  TYPE string,
        vl_bc_icms       TYPE p LENGTH 15 DECIMALS 2,
        vl_icms          TYPE p LENGTH 15 DECIMALS 2,
        dm_sit_estoque   TYPE string,
        cd_pessoa_propr  TYPE string,
        cd_sit_trib_icms TYPE string,
        dt_inventario    TYPE string,
      END OF ty_knwh020list,


      BEGIN OF ty_knw0500,
        cod_empresa     TYPE p LENGTH 15 DECIMALS 2,
        cod_filial      TYPE p LENGTH 15 DECIMALS 2,
        id_usuario_imp  TYPE string,
        cd_plano_conta  TYPE string,
        dt_inicial      TYPE string,
        dm_tipo_conta   TYPE string,
        cd_plan_cta_tot TYPE string,
        ds_plano_conta  TYPE string,
        dm_natureza     TYPE string,
        dm_nivel        TYPE string,
        dt_importacao   TYPE string,
        dm_geral_aux    TYPE string,
        id_ordem        TYPE p LENGTH 15 DECIMALS 2,
        cd_reduzida     TYPE string,
      END OF ty_knw0500,


      BEGIN OF ty_knw0190,
        cod_empresa    TYPE p LENGTH 15 DECIMALS 2,
        cod_filial     TYPE p LENGTH 15 DECIMALS 2,
        id_usuario_imp TYPE string,
        dt_inicial     TYPE string,
        dt_importacao  TYPE string,
        ds_unidade     TYPE string,
        ds_descricao   TYPE string,
      END OF ty_knw0190,


      BEGIN OF ty_knw0220,
        cod_empresa    TYPE p LENGTH 15 DECIMALS 2,
        cod_filial     TYPE p LENGTH 15 DECIMALS 2,
        id_usuario_imp TYPE string,
        cd_prod_serv   TYPE string,
        un_convertida  TYPE string,
        vl_fator_conv  TYPE p LENGTH 15 DECIMALS 2,
      END OF ty_knw0220,


      BEGIN OF ty_integracaosfunidadeconversa,
        knw0220 TYPE ty_knw0220,
        knw0190 TYPE ty_knw0190,
      END OF ty_integracaosfunidadeconversa,


      BEGIN OF ty_knw0200,
        cod_empresa          TYPE p LENGTH 15 DECIMALS 2,
        cod_filial           TYPE p LENGTH 15 DECIMALS 2,
        id_usuario_imp       TYPE string,
        cd_plano_conta       TYPE string,
        dt_inicial           TYPE string,
        dt_importacao        TYPE string,
        cd_produto_serv      TYPE string,
        ds_produto_serv      TYPE string,
        unidade              TYPE string,
        cd_sit_tributar_icms TYPE string,
        aliq_icms            TYPE p LENGTH 15 DECIMALS 2,
        perc_red_ba_icms     TYPE p LENGTH 15 DECIMALS 2,
        dm_produto_venda     TYPE string,
        cd_lst               TYPE string,
        cd_ncm               TYPE string,
        cd_genero            TYPE string,
        dm_tipo_item         TYPE string,
        cd_331_ex_ipi        TYPE string,
        cd_barra             TYPE string,
        nr_cest              TYPE string,
        dm_origem_produto    TYPE string,
        cd_centro_custo      TYPE string,
        cd_sit_trib_ipi      TYPE string,
        cd_sit_trib_pis      TYPE string,
        cd_sit_trib_cofins   TYPE string,
        cd_nat_operacao      TYPE string,
        aliq_pis             TYPE p LENGTH 15 DECIMALS 2,
        aliq_cofins          TYPE p LENGTH 15 DECIMALS 2,
      END OF ty_knw0200,


      BEGIN OF ty_knw0150,
        cod_empresa          TYPE p LENGTH 15 DECIMALS 2,
        cod_filial           TYPE p LENGTH 15 DECIMALS 2,
        id_usuario_imp       TYPE string,
        dt_inicial           TYPE string,
        dt_importacao        TYPE string,
        cd_pessoa            TYPE string,
        nm_razao_social      TYPE string,
        ds_endereco          TYPE string,
        ds_bairro            TYPE string,
        nr_cep               TYPE string,
        nr_cnpj_cpf          TYPE string,
        nr_inscr_est         TYPE string,
        nr_inscr_munic       TYPE string,
        nr_cei               TYPE string,
        nr_inscr_subst       TYPE string,
        cd_suframa           TYPE string,
        nr_numero            TYPE string,
        ds_complemento       TYPE string,
        nr_cep_cp            TYPE string,
        nr_cp                TYPE string,
        nr_fone              TYPE string,
        nr_fax               TYPE string,
        dm_relacionado       TYPE string,
        dt_ini_rel           TYPE string,
        dt_fin_rel           TYPE string,
        nr_nit               TYPE string,
        cd_cnae              TYPE string,
        nr_categoria         TYPE string,
        cd_municipio         TYPE string,
        cd_pais              TYPE string,
        ds_email             TYPE string,
        dm_natureza_empresa  TYPE string,
        dm_regime_tributario TYPE string,
        nm_tp_logradouro     TYPE string,
        nm_titulo_logradouro TYPE string,
        dm_contribuinte      TYPE string,
      END OF ty_knw0150,


      BEGIN OF ty_knwh010,
        cod_empresa     TYPE p LENGTH 15 DECIMALS 2,
        cod_filial      TYPE p LENGTH 15 DECIMALS 2,
        id_usuario_imp  TYPE string,
        cd_plano_conta  TYPE string,
        ds_complementar TYPE string,
        cd_produto_serv TYPE string,
        unidade         TYPE string,
        vl_total        TYPE p LENGTH 15 DECIMALS 2,
        qtde            TYPE p LENGTH 15 DECIMALS 2,
        dm_sit_estoque  TYPE string,
        cd_pessoa_propr TYPE string,
        vl_total_ir     TYPE p LENGTH 15 DECIMALS 2,
        dt_inventario   TYPE string,
        vl_unitario     TYPE p LENGTH 15 DECIMALS 2,
      END OF ty_knwh010,

      BEGIN OF ty_knwk200,
        cod_empresa        TYPE string,
        cod_filial         TYPE string,
        cd_pessoa          TYPE string,
        cd_produto_servico TYPE c LENGTH 40,
        dm_estoque         TYPE string,
        dt_est_final       TYPE string,
        qtde               TYPE string,
      END OF ty_knwk200,



      BEGIN OF ty_objetos,
        knwk200                        TYPE ty_knwk200,
        knwh010                        TYPE ty_knwh010,
        knw0150                        TYPE ty_knw0150,
        knw0190                        TYPE ty_knw0190,
        knw0200                        TYPE ty_knw0200,
        integracaosfunidadeconversaoli TYPE STANDARD TABLE OF ty_integracaosfunidadeconversa WITH NON-UNIQUE DEFAULT KEY,
        knw0500                        TYPE ty_knw0500,
        knwh020list                    TYPE STANDARD TABLE OF ty_knwh020list WITH NON-UNIQUE DEFAULT KEY,
        knwh030                        TYPE ty_knwh030,
      END OF ty_objetos,


      BEGIN OF ty_main,
        objetos TYPE STANDARD TABLE OF ty_objetos WITH NON-UNIQUE DEFAULT KEY,
      END OF ty_main,

      ty_t_main TYPE ty_main,

      BEGIN OF ty_ibge,
        countrycode       TYPE c LENGTH 3,
        br_bcbcountrycode TYPE c LENGTH 5,
      END OF ty_ibge,

      BEGIN OF ty_tax_type,
        br_taxtype                     TYPE c LENGTH 4,
        br_taxgroup                    TYPE c LENGTH 4,
        br_icmspartilhasubdivisioncode TYPE c LENGTH 3,
      END OF ty_tax_type,

      BEGIN OF ty_stock_value2,
        stock                 TYPE i_inventoryamtbyfsclperd,
        product               TYPE i_product,
        productdescription    TYPE i_productdescription,
        unitofmeasuretext     TYPE i_unitofmeasuretext,
        productplantbasic     TYPE i_productplantbasic,
        productvaluationbasic TYPE i_productvaluationbasic,
        supplier              TYPE i_supplier,
        plant                 TYPE i_plant,
        referenceproducttype  TYPE i_producttype-referenceproducttype,
        unitofmeasure_e       TYPE i_unitofmeasure-unitofmeasure_e,
        unitofmeasurename     TYPE i_unitofmeasuretext-unitofmeasurename,
      END OF ty_stock_value2,

      BEGIN OF ty_companycode,
        companycode     TYPE i_companycode-companycode,
        companycodename TYPE i_companycode-companycodename,
      END OF ty_companycode,

      BEGIN OF ty_accounts,
        product   TYPE i_journalentryitem-product,
        glaccount TYPE i_journalentryitem-glaccount,
      END OF ty_accounts,

      ty_t_accounts TYPE TABLE OF ty_accounts WITH DEFAULT KEY,

      ty_c          TYPE c LENGTH 50,

      BEGIN OF ty_sel,
        companycode     TYPE i_companycode-companycode,
        ledger          TYPE i_ledger-ledger,
        businessplace   TYPE i_plant-plant,
        fiscalyear      TYPE i_inventoryamtbyfsclperd-fiscalyear,
        fiscalperiod    TYPE i_inventoryamtbyfsclperd-fiscalperiod,
        product         TYPE RANGE OF i_product-product,
        extractionorlog TYPE c LENGTH 3,
        timestamp       TYPE RANGE OF timestamp,
      END OF ty_sel,

      BEGIN OF ty_nfitem,
        nf                   TYPE i_br_nfitem,
        product              TYPE i_product-product,
        producttype          TYPE i_product-producttype,
        baseunit             TYPE i_product-baseunit,
        plant                TYPE c LENGTH 4,
        iscoproduct          TYPE c LENGTH 1,
        referenceproducttype TYPE i_producttype-referenceproducttype,
        unitofmeasureisocode TYPE i_unitofmeasure-unitofmeasureisocode,
        unitofmeasure_e      TYPE i_unitofmeasure-unitofmeasure_e,
        unitofmeasurename    TYPE i_unitofmeasuretext-unitofmeasurename,
        glaccountname        TYPE i_glaccounttextincompanycode-glaccountname,
        chartofaccounts      TYPE i_glaccount-chartofaccounts,
      END OF ty_nfitem,

      BEGIN OF ty_docs_act,
        doc TYPE i_br_nfdocument,
        act TYPE i_br_nfeactive,
      END OF ty_docs_act,

      BEGIN OF ty_grouped,
         material                    TYPE i_inventoryamtbyfsclperd-material,
         valuationquantity           TYPE i_inventoryamtbyfsclperd-valuationquantity,
         amountincompanycodecurrency TYPE i_inventoryamtbyfsclperd-amountincompanycodecurrency,
         movingaverageprice          TYPE i_productvaluationbasic-movingaverageprice,
         unitofmeasure               TYPE i_inventoryamtbyfsclperd-unitofmeasure,
         product                     TYPE i_product-product,
         productdescription          TYPE i_productdescription-productdescription,
         consumptiontaxctrlcode      TYPE i_productplantbasic-consumptiontaxctrlcode,
         productorigintype           TYPE i_productvaluationbasic-productorigintype,
         unitofmeasure_e             TYPE i_unitofmeasuretext-unitofmeasure_e,
         unitofmeasurename           TYPE i_unitofmeasuretext-unitofmeasurename,
         referenceproducttype        TYPE i_producttype-referenceproducttype,
         iscoproduct                 TYPE i_productplantbasic-IsCoProduct,
       END OF ty_grouped.

    CLASS-DATA: sel          TYPE ty_sel,
                data         TYPE d,
                hora         TYPE t,
                t_out        TYPE TABLE OF ty_t_main,
                t_ibge       TYPE TABLE OF ty_ibge,
                t_tax_type   TYPE TABLE OF ty_tax_type,
                gv_proc      TYPE string,
                gs_company   TYPE ty_companycode,
                gt_accounts  TYPE ty_t_accounts,
                s_branch_sov TYPE /pyxs/sov_branch,
                "gt_sel2      TYPE TABLE OF ty_stock_value2,
                gt_sel2 TYPE TABLE OF ty_grouped,
                t_nfitem     TYPE TABLE OF ty_nfitem,
                t_nfdocs     TYPE TABLE OF ty_docs_act.


  PRIVATE SECTION.


    CLASS-METHODS: read_db,

      new_out,
      get_ibge_state
        IMPORTING
          p_bland             TYPE clike
        RETURNING
          VALUE(p_cod_estado) TYPE /pyxs/sov_nf_branch-uf,
      normalize
        IMPORTING
                  p_str             TYPE clike
        RETURNING VALUE(normalized) TYPE string,
      send_integration,
      get_ibge_country
        IMPORTING
                  p_country   TYPE clike
        RETURNING VALUE(ibge) TYPE string,
      popu,
      format_date
        IMPORTING
          iv_date        TYPE d
          iv_with_time   TYPE abap_bool DEFAULT abap_true
        RETURNING
          VALUE(rv_date) TYPE string.

ENDCLASS.

CLASS lhc_sovos_year_inventory IMPLEMENTATION.

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

  METHOD sendintegration.

    DATA(key) = keys[ 1 ].
    DATA(lv_param) = keys[ 1 ]-%param.

    lcl_process=>data = cl_abap_context_info=>get_system_date( ).
    lcl_process=>hora = cl_abap_context_info=>get_system_time( ).

    "-----------------------------------------------------------------------
    " Validação: Company e Branch obrigatórios
    "-----------------------------------------------------------------------
    lcl_process=>sel-companycode = keys[ 1 ]-%param-company.
    lcl_process=>sel-businessplace = keys[ 1 ]-%param-branch.
    lcl_process=>sel-fiscalperiod = keys[ 1 ]-%param-anomes+4.
    lcl_process=>sel-fiscalyear = keys[ 1 ]-%param-anomes(4).

    "lcl_process=>sel-branch = keys[ 1 ]-%param-branch.


    IF lcl_process=>sel-companycode IS INITIAL." OR lcl_process=>sel-branch IS INITIAL.
      APPEND VALUE #( %action-sendintegration = if_abap_behv=>mk-on
      ) TO failed-/pyxs/sovos_year_inventory.
      APPEND VALUE #(
        %msg = new_message_with_text(
          severity = if_abap_behv_message=>severity-error
          text     = 'Empresa e Local de Negócio são obrigatórios' )
        %action-sendintegration = if_abap_behv=>mk-on
      ) TO reported-/pyxs/sovos_year_inventory.
    ENDIF.


    CHECK failed-/pyxs/sovos_year_inventory IS INITIAL.

    lcl_process=>read_db(  ).
    IF lcl_process=>gt_sel2 IS INITIAL.
      APPEND INITIAL LINE TO /pyxs/bp_sovos_year_inventory=>lt_log ASSIGNING FIELD-SYMBOL(<log>).
      GET TIME STAMP FIELD DATA(time).
      <log>-timedate = time.
      <log>-anomes = keys[ 1 ]-%param-anomes.
      <log>-id = 1.

      "READ TABLE t_nfdocs INTO DATA(ls_nf) WITH KEY doc-br_nfenumber = ls_doc-objetos[ 1 ]-knwc100-nr_documento.
      <log>-response = 'Cenário de comunicação não encontrado'.
      <log>-returncode = '999'.
      <log>-returnreason = 'Erro de configuração'.
    ELSE.
      lcl_process=>new_out(  ).
      lcl_process=>send_integration( ).
    ENDIF.
    APPEND INITIAL LINE TO reported-/pyxs/sovos_year_inventory ASSIGNING FIELD-SYMBOL(<fs>).
    <fs>-%cid = key-%cid.
    <fs>-%msg = new_message_with_text(
                  severity = if_abap_behv_message=>severity-information
                  text     = 'Processamento solicitado'
                ).

    res = VALUE #( FOR log IN /pyxs/bp_sovos_year_inventory=>lt_log (
        %cid =  key-%cid
        %param = VALUE #( %data = VALUE
            #(
            material = log-material
            id = log-id
            response = log-response
            returncode = log-returncode
            returnreason = log-returnreason
            timedate = log-timedate
             ) )
        )  ).
  ENDMETHOD.

ENDCLASS.

CLASS lsc_sovos_year_inventory DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_sovos_year_inventory IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.

    MODIFY /pyxs/sov_yr_inv FROM TABLE
    @/pyxs/bp_sovos_year_inventory=>lt_log.
    CLEAR /pyxs/bp_sovos_year_inventory=>lt_log.

  ENDMETHOD.

  METHOD cleanup.
    CLEAR /pyxs/bp_sovos_year_inventory=>lt_log.
  ENDMETHOD.

  METHOD cleanup_finalize.
    CLEAR /pyxs/bp_sovos_year_inventory=>lt_log.
  ENDMETHOD.

ENDCLASS.


CLASS lcl_process IMPLEMENTATION.

  METHOD build_cnpj.

    CONSTANTS: lc_alpha TYPE string VALUE 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.

    TYPES: tt_weights TYPE STANDARD TABLE OF i WITH DEFAULT KEY.

    DATA: lv_clean    TYPE string,
          lv_char     TYPE c LENGTH 1,
          lv_valor    TYPE i,
          lv_pos      TYPE i,
          lv_find     TYPE i,
          digsum      TYPE p,
          digrest     TYPE p,
          first       TYPE i,
          second      TYPE i,
          lt_weights1 TYPE tt_weights,
          lt_weights2 TYPE tt_weights.

    " 1. Limpar separadores
    DATA(lv_input) = input.
    REPLACE ALL OCCURRENCES OF '.' IN lv_input WITH ''.
    REPLACE ALL OCCURRENCES OF '/' IN lv_input WITH ''.
    REPLACE ALL OCCURRENCES OF '-' IN lv_input WITH ''.
    CONDENSE lv_input NO-GAPS.

    " Validar: deve ter exatamente 12 caracteres
    IF strlen( lv_input ) <> 12.
      output = ''.
      RETURN.
    ENDIF.

    lv_clean = lv_input.

    " Pesos do 1º DV: 5,4,3,2,9,8,7,6,5,4,3,2
    APPEND 5 TO lt_weights1.
    APPEND 4 TO lt_weights1.
    APPEND 3 TO lt_weights1.
    APPEND 2 TO lt_weights1.
    APPEND 9 TO lt_weights1.
    APPEND 8 TO lt_weights1.
    APPEND 7 TO lt_weights1.
    APPEND 6 TO lt_weights1.
    APPEND 5 TO lt_weights1.
    APPEND 4 TO lt_weights1.
    APPEND 3 TO lt_weights1.
    APPEND 2 TO lt_weights1.

    " Pesos do 2º DV: 6,5,4,3,2,9,8,7,6,5,4,3,2
    APPEND 6 TO lt_weights2.
    APPEND 5 TO lt_weights2.
    APPEND 4 TO lt_weights2.
    APPEND 3 TO lt_weights2.
    APPEND 2 TO lt_weights2.
    APPEND 9 TO lt_weights2.
    APPEND 8 TO lt_weights2.
    APPEND 7 TO lt_weights2.
    APPEND 6 TO lt_weights2.
    APPEND 5 TO lt_weights2.
    APPEND 4 TO lt_weights2.
    APPEND 3 TO lt_weights2.
    APPEND 2 TO lt_weights2.

    " -------------------------------------------------------
    " Conversão char -> valor para DV conforme tabela SERPRO
    " Fórmula: ASCII do char - 48
    "   '0'(48)-48=0 ... '9'(57)-48=9
    "   'A'(65)-48=17 ... 'Z'(90)-48=42
    " -------------------------------------------------------

    " --- Cálculo do 1º DV ---
    digsum = 0.
    LOOP AT lt_weights1 INTO DATA(lv_w1).
      lv_pos  = sy-tabix - 1.
      lv_char = lv_clean+lv_pos(1).

      FIND lv_char IN lc_alpha MATCH OFFSET lv_find.
      IF sy-subrc = 0.
        lv_valor = lv_find + 17.   " A=17, B=18 ... Z=42  (ASCII 65 - 48 = 17)
      ELSE.
        lv_valor = lv_char - '0'.  " '0'=0 ... '9'=9
      ENDIF.

      digsum = digsum + ( lv_valor * lv_w1 ).
    ENDLOOP.

    digrest = digsum MOD 11.
    IF digrest <= 1.
      first = 0.
    ELSE.
      first = 11 - digrest.
    ENDIF.

    " --- Cálculo do 2º DV (12 chars + 1º DV na posição 13) ---
    digsum = 0.
    LOOP AT lt_weights2 INTO DATA(lv_w2).
      lv_pos = sy-tabix - 1.

      IF lv_pos < 12.
        lv_char = lv_clean+lv_pos(1).
        FIND lv_char IN lc_alpha MATCH OFFSET lv_find.
        IF sy-subrc = 0.
          lv_valor = lv_find + 17.  " Letra
        ELSE.
          lv_valor = lv_char - '0'. " Dígito
        ENDIF.
      ELSE.
        lv_valor = first.            " Posição 13 = 1º DV já calculado
      ENDIF.

      digsum = digsum + ( lv_valor * lv_w2 ).
    ENDLOOP.

    digrest = digsum MOD 11.
    IF digrest <= 1.
      second = 0.
    ELSE.
      second = 11 - digrest.
    ENDIF.

    " --- Montar saída formatada XX.XXX.XXX/XXXX-DV1DV2 ---
    output = lv_clean+0(2)
          && lv_clean+2(3)
          && lv_clean+5(3)
          && lv_clean+8(4)
          && first
          && second.

  ENDMETHOD.

  METHOD normalize.
    normalized = p_str.
    TRANSLATE: normalized USING '. ',
               normalized USING '- ',
               normalized USING '/ '.
    CONDENSE normalized NO-GAPS.
  ENDMETHOD.

  METHOD send_integration.
    DATA: lo_ret     TYPE REF TO data,
          lv_sucesso TYPE abap_boolean.

    LOOP AT t_out INTO DATA(ls_doc).

      DATA(json_out) = /ui2/cl_json=>serialize(
        EXPORTING
          data             = ls_doc
          compress         = abap_true
*        name             =
           pretty_name      = /ui2/cl_json=>pretty_mode-none
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

      IF lt_ca IS INITIAL.
        APPEND INITIAL LINE TO /pyxs/bp_sovos_year_inventory=>lt_log ASSIGNING FIELD-SYMBOL(<log>).
        GET TIME STAMP FIELD DATA(time).
        <log>-timedate = time.
        <log>-anomes = |{ sel-fiscalyear }{ sel-fiscalperiod+1 }|.
        "READ TABLE t_nfdocs INTO DATA(ls_nf) WITH KEY doc-br_nfenumber = ls_doc-objetos[ 1 ]-knwc100-nr_documento.
        <log>-material = ls_doc-objetos[ 1 ]-knwh010-cd_produto_serv.
        <log>-response = 'Cenário de comunicação não encontrado'.
        <log>-returncode = '999'.
        <log>-returnreason = 'Erro de configuração'.

        EXIT.
      ENDIF.

      " take the first one
      READ TABLE lt_ca INTO DATA(lo_ca) INDEX 1.

      " get destination based to Communication Arrangement
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
*            i_offset = 0
*            i_length = -1
*          RECEIVING
*            r_value  =
          ).

          lo_request->set_uri_path(
            EXPORTING
*              i_uri_path = '/api/knw/v2/estoqueEscriturado'
              i_uri_path = 'api/knw/v2/inventario'
*              multivalue = 0
*            RECEIVING
*              r_value    =
          ).

          "lo_request->set_header_field( i_name = 'X-Cnpj'  i_value = gv_branch_cnpj ).

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
        APPEND INITIAL LINE TO /pyxs/bp_sovos_year_inventory=>lt_log ASSIGNING <log>.
        <log>-timedate = time.
        "READ TABLE t_nfdocs INTO ls_nf WITH KEY doc-br_nfenumber = ls_doc-objetos[ 1 ]-knwc100-nr_documento.
        <log>-material = ls_doc-objetos[ 1 ]-knwh010-cd_produto_serv.
        <log>-response = |Erro no serviço: { gv_proc }|.
        <log>-returncode = lv_ret-code.
        <log>-returnreason = lv_ret-reason.

      ELSE.

        LOOP AT lo_ret->('MENSAGENS')->* ASSIGNING FIELD-SYMBOL(<lv_msg>).
          APPEND INITIAL LINE TO /pyxs/bp_sovos_year_inventory=>lt_log ASSIGNING <log>.
          <log>-id = sy-tabix.
          <log>-timedate = time.
          "READ TABLE t_nfdocs INTO ls_nf WITH KEY doc-br_nfenumber = ls_doc-objetos[ 1 ]-knwc100-nr_documento.
          <log>-material = ls_doc-objetos[ 1 ]-knwh010-cd_produto_serv.
          <log>-response = <lv_msg>->*.
          <log>-returncode = lv_ret-code.
          <log>-returnreason = lv_ret-reason.
        ENDLOOP.
      ENDIF.


    ENDLOOP.

  ENDMETHOD.


  METHOD get_ibge_state.
    CONSTANTS:
      gc_ro_uf   TYPE c LENGTH 3 VALUE 'RO',
      gc_ro1_uf  TYPE c LENGTH 3 VALUE 'RO1',
      gc_ro_ibge TYPE c LENGTH 3 VALUE '11',
      gc_ac_uf   TYPE c LENGTH 3 VALUE 'AC',
      gc_ac1_uf  TYPE c LENGTH 3 VALUE 'AC1',
      gc_ac_ibge TYPE c LENGTH 3 VALUE '12',
      gc_am_uf   TYPE c LENGTH 3 VALUE 'AM',
      gc_am1_uf  TYPE c LENGTH 3 VALUE 'AM1',
      gc_zf_uf   TYPE c LENGTH 3 VALUE 'ZF',
      gc_am_ibge TYPE c LENGTH 3 VALUE '13',
      gc_rr_uf   TYPE c LENGTH 3 VALUE 'RR',
      gc_rr1_uf  TYPE c LENGTH 3 VALUE 'RR',
      gc_rr_ibge TYPE c LENGTH 3 VALUE '14',
      gc_pa_uf   TYPE c LENGTH 3 VALUE 'PA',
      gc_pa_ibge TYPE c LENGTH 3 VALUE '15',
      gc_ap_uf   TYPE c LENGTH 3 VALUE 'AP',
      gc_ap1_uf  TYPE c LENGTH 3 VALUE 'AP1',
      gc_ap_ibge TYPE c LENGTH 3 VALUE '16',
      gc_to_uf   TYPE c LENGTH 3 VALUE 'TO',
      gc_to_ibge TYPE c LENGTH 3 VALUE '17',
      gc_ma_uf   TYPE c LENGTH 3 VALUE 'MA',
      gc_ma_ibge TYPE c LENGTH 3 VALUE '21',
      gc_pi_uf   TYPE c LENGTH 3 VALUE 'PI',
      gc_pi_ibge TYPE c LENGTH 3 VALUE '22',
      gc_ce_uf   TYPE c LENGTH 3 VALUE 'CE',
      gc_ce_ibge TYPE c LENGTH 3 VALUE '23',
      gc_rn_uf   TYPE c LENGTH 3 VALUE 'RN',
      gc_rn_ibge TYPE c LENGTH 3 VALUE '24',
      gc_pb_uf   TYPE c LENGTH 3 VALUE 'PB',
      gc_pb_ibge TYPE c LENGTH 3 VALUE '25',
      gc_pe_uf   TYPE c LENGTH 3 VALUE 'PE',
      gc_pe_ibge TYPE c LENGTH 3 VALUE '26',
      gc_al_uf   TYPE c LENGTH 3 VALUE 'AL',
      gc_al_ibge TYPE c LENGTH 3 VALUE '27',
      gc_se_uf   TYPE c LENGTH 3 VALUE 'SE',
      gc_se_ibge TYPE c LENGTH 3 VALUE '28',
      gc_ba_uf   TYPE c LENGTH 3 VALUE 'BA',
      gc_ba_ibge TYPE c LENGTH 3 VALUE '29',
      gc_mg_uf   TYPE c LENGTH 3 VALUE 'MG',
      gc_mg_ibge TYPE c LENGTH 3 VALUE '31',
      gc_es_uf   TYPE c LENGTH 3 VALUE 'ES',
      gc_es_ibge TYPE c LENGTH 3 VALUE '32',
      gc_rj_uf   TYPE c LENGTH 3 VALUE 'RJ',
      gc_rj_ibge TYPE c LENGTH 3 VALUE '33',
      gc_sp_uf   TYPE c LENGTH 3 VALUE 'SP',
      gc_sp_ibge TYPE c LENGTH 3 VALUE '35',
      gc_pr_uf   TYPE c LENGTH 3 VALUE 'PR',
      gc_pr_ibge TYPE c LENGTH 3 VALUE '41',
      gc_sc_uf   TYPE c LENGTH 3 VALUE 'SC',
      gc_sc_ibge TYPE c LENGTH 3 VALUE '42',
      gc_rs_uf   TYPE c LENGTH 3 VALUE 'RS',
      gc_rs_ibge TYPE c LENGTH 3 VALUE '43',
      gc_ms_uf   TYPE c LENGTH 3 VALUE 'MS',
      gc_ms_ibge TYPE c LENGTH 3 VALUE '50',
      gc_mt_uf   TYPE c LENGTH 3 VALUE 'MT',
      gc_mt_ibge TYPE c LENGTH 3 VALUE '51',
      gc_go_uf   TYPE c LENGTH 3 VALUE 'GO',
      gc_go_ibge TYPE c LENGTH 3 VALUE '52',
      gc_df_uf   TYPE c LENGTH 3 VALUE 'DF',
      gc_df_ibge TYPE c LENGTH 3 VALUE '53',
      gc_xe_uf   TYPE c LENGTH 3 VALUE 'XE', "Comércio ext.-UE
      gc_xx_uf   TYPE c LENGTH 3 VALUE 'XX', "Comércio exterior
      gc_ex_ibge TYPE c LENGTH 3 VALUE '99'.

    CASE p_bland.
        "Região Norte
      WHEN gc_ro_uf OR gc_ro1_uf.
        p_cod_estado = gc_ro_ibge.
      WHEN gc_ac_uf OR gc_ac1_uf.
        p_cod_estado = gc_ac_ibge.
      WHEN gc_am_uf OR gc_am1_uf OR gc_zf_uf.
        p_cod_estado = gc_am_ibge.
      WHEN gc_rr_uf OR gc_rr1_uf.
        p_cod_estado = gc_rr_ibge.
      WHEN gc_pa_uf.
        p_cod_estado = gc_pa_ibge.
      WHEN gc_ap_uf OR gc_ap1_uf.
        p_cod_estado = gc_ap_ibge.
      WHEN gc_to_uf.
        p_cod_estado = gc_to_ibge.

        "Região Nordeste
      WHEN gc_ma_uf.
        p_cod_estado = gc_ma_ibge.
      WHEN gc_pi_uf.
        p_cod_estado = gc_pi_ibge.
      WHEN gc_ce_uf.
        p_cod_estado = gc_ce_ibge.
      WHEN gc_rn_uf.
        p_cod_estado = gc_rn_ibge.
      WHEN gc_pb_uf.
        p_cod_estado = gc_pb_ibge.
      WHEN gc_pe_uf.
        p_cod_estado = gc_pe_ibge.
      WHEN gc_al_uf.
        p_cod_estado = gc_al_ibge.
      WHEN gc_se_uf.
        p_cod_estado = gc_se_ibge.
      WHEN gc_ba_uf.
        p_cod_estado = gc_ba_ibge.

        "Região Sudeste
      WHEN gc_mg_uf.
        p_cod_estado = gc_mg_ibge.
      WHEN gc_es_uf.
        p_cod_estado = gc_es_ibge.
      WHEN gc_rj_uf.
        p_cod_estado = gc_rj_ibge.
      WHEN gc_sp_uf.
        p_cod_estado = gc_sp_ibge.

        "Região Sul
      WHEN gc_pr_uf.
        p_cod_estado = gc_pr_ibge.
      WHEN gc_sc_uf.
        p_cod_estado = gc_sc_ibge.
      WHEN gc_rs_uf.
        p_cod_estado = gc_rs_ibge.

        "Região Centro-Oeste
      WHEN gc_ms_uf.
        p_cod_estado = gc_ms_ibge.
      WHEN gc_mt_uf.
        p_cod_estado = gc_mt_ibge.
      WHEN gc_go_uf.
        p_cod_estado = gc_go_ibge.
      WHEN gc_df_uf.
        p_cod_estado = gc_df_ibge.

        "Comércio Exterior
      WHEN gc_xe_uf OR gc_xx_uf.
        p_cod_estado = gc_ex_ibge.

      WHEN OTHERS.
        CLEAR: p_cod_estado.
    ENDCASE.
  ENDMETHOD.

  METHOD get_ibge_country.

    IF t_ibge IS INITIAL.
      t_ibge = VALUE #(
        ( countrycode = 'AD' br_bcbcountrycode = '00370'  )
        ( countrycode = 'AE' br_bcbcountrycode = '02445'  )
        ( countrycode = 'AF' br_bcbcountrycode = '00132'  )
        ( countrycode = 'AG' br_bcbcountrycode = '00434'  )
        ( countrycode = 'AI' br_bcbcountrycode = '00418'  )
        ( countrycode = 'AL' br_bcbcountrycode = '00175'  )
        ( countrycode = 'AM' br_bcbcountrycode = '00647'  )
        ( countrycode = 'AO' br_bcbcountrycode = '00400'  )
        ( countrycode = 'AQ' br_bcbcountrycode = '00420'  )
        ( countrycode = 'AR' br_bcbcountrycode = '00639'  )
        ( countrycode = 'AS' br_bcbcountrycode = '06912'  )
        ( countrycode = 'AT' br_bcbcountrycode = '00728'  )
        ( countrycode = 'AU' br_bcbcountrycode = '00698'  )
        ( countrycode = 'AW' br_bcbcountrycode = '00655'  )
        ( countrycode = 'AX' br_bcbcountrycode = '00153'  )
        ( countrycode = 'AZ' br_bcbcountrycode = '00736'  )
        ( countrycode = 'BA' br_bcbcountrycode = '00981'  )
        ( countrycode = 'BB' br_bcbcountrycode = '00833'  )
        ( countrycode = 'BD' br_bcbcountrycode = '00817'  )
        ( countrycode = 'BE' br_bcbcountrycode = '00876'  )
        ( countrycode = 'BF' br_bcbcountrycode = '00310'  )
        ( countrycode = 'BG' br_bcbcountrycode = '01112'  )
        ( countrycode = 'BH' br_bcbcountrycode = '00809'  )
        ( countrycode = 'BI' br_bcbcountrycode = '01155'  )
        ( countrycode = 'BJ' br_bcbcountrycode = '02291'  )
        ( countrycode = 'BL' br_bcbcountrycode = '06939'  )
        ( countrycode = 'BM' br_bcbcountrycode = '00906'  )
        ( countrycode = 'BN' br_bcbcountrycode = '01082'  )
        ( countrycode = 'BO' br_bcbcountrycode = '00973'  )
        ( countrycode = 'BQ' br_bcbcountrycode = '00990'  )
        ( countrycode = 'BR' br_bcbcountrycode = '01058'  )
        ( countrycode = 'BS' br_bcbcountrycode = '00779'  )
        ( countrycode = 'BT' br_bcbcountrycode = '01198'  )
        ( countrycode = 'BV' br_bcbcountrycode = '01023'  )
        ( countrycode = 'BW' br_bcbcountrycode = '01015'  )
        ( countrycode = 'BY' br_bcbcountrycode = '00850'  )
        ( countrycode = 'BZ' br_bcbcountrycode = '00884'  )
        ( countrycode = 'CA' br_bcbcountrycode = '01490'  )
        ( countrycode = 'CC' br_bcbcountrycode = '01651'  )
        ( countrycode = 'CD' br_bcbcountrycode = '08885'  )
        ( countrycode = 'CF' br_bcbcountrycode = '06408'  )
        ( countrycode = 'CG' br_bcbcountrycode = '01775'  )
        ( countrycode = 'CH' br_bcbcountrycode = '07676'  )
        ( countrycode = 'CI' br_bcbcountrycode = '01937'  )
        ( countrycode = 'CK' br_bcbcountrycode = '01830'  )
        ( countrycode = 'CL' br_bcbcountrycode = '01589'  )
        ( countrycode = 'CM' br_bcbcountrycode = '01457'  )
        ( countrycode = 'CN' br_bcbcountrycode = '01600'  )
        ( countrycode = 'CO' br_bcbcountrycode = '01694'  )
        ( countrycode = 'CR' br_bcbcountrycode = '01961'  )
        ( countrycode = 'CU' br_bcbcountrycode = '01996'  )
        ( countrycode = 'CV' br_bcbcountrycode = '01279'  )
        ( countrycode = 'CW' br_bcbcountrycode = '02003'  )
        ( countrycode = 'CY' br_bcbcountrycode = '01635'  )
        ( countrycode = 'CZ' br_bcbcountrycode = '07919'  )
        ( countrycode = 'DE' br_bcbcountrycode = '00230'  )
        ( countrycode = 'DJ' br_bcbcountrycode = '07838'  )
        ( countrycode = 'DK' br_bcbcountrycode = '02321'  )
        ( countrycode = 'DM' br_bcbcountrycode = '02356'  )
        ( countrycode = 'DO' br_bcbcountrycode = '06475'  )
        ( countrycode = 'DZ' br_bcbcountrycode = '00590'  )
        ( countrycode = 'EC' br_bcbcountrycode = '02399'  )
        ( countrycode = 'EE' br_bcbcountrycode = '02518'  )
        ( countrycode = 'EG' br_bcbcountrycode = '02402'  )
        ( countrycode = 'EH' br_bcbcountrycode = '06858'  )
        ( countrycode = 'ER' br_bcbcountrycode = '02437'  )
        ( countrycode = 'ES' br_bcbcountrycode = '02453'  )
        ( countrycode = 'ET' br_bcbcountrycode = '02534'  )
        ( countrycode = 'FI' br_bcbcountrycode = '02712'  )
        ( countrycode = 'FJ' br_bcbcountrycode = '08702'  )
        ( countrycode = 'FK' br_bcbcountrycode = '02550'  )
        ( countrycode = 'FM' br_bcbcountrycode = '04995'  )
        ( countrycode = 'FO' br_bcbcountrycode = '02593'  )
        ( countrycode = 'FR' br_bcbcountrycode = '02755'  )
        ( countrycode = 'GA' br_bcbcountrycode = '02810'  )
        ( countrycode = 'GB' br_bcbcountrycode = '06289'  )
        ( countrycode = 'GD' br_bcbcountrycode = '02976'  )
        ( countrycode = 'GE' br_bcbcountrycode = '02917'  )
        ( countrycode = 'GF' br_bcbcountrycode = '03255'  )
        ( countrycode = 'GG' br_bcbcountrycode = '03212'  )
        ( countrycode = 'GH' br_bcbcountrycode = '02895'  )
        ( countrycode = 'GI' br_bcbcountrycode = '02933'  )
        ( countrycode = 'GL' br_bcbcountrycode = '03050'  )
        ( countrycode = 'GM' br_bcbcountrycode = '02852'  )
        ( countrycode = 'GN' br_bcbcountrycode = '03298'  )
        ( countrycode = 'GP' br_bcbcountrycode = '03093'  )
        ( countrycode = 'GQ' br_bcbcountrycode = '03310'  )
        ( countrycode = 'GR' br_bcbcountrycode = '03018'  )
        ( countrycode = 'GS' br_bcbcountrycode = '02925'  )
        ( countrycode = 'GT' br_bcbcountrycode = '03174'  )
        ( countrycode = 'GU' br_bcbcountrycode = '03131'  )
        ( countrycode = 'GW' br_bcbcountrycode = '03344'  )
        ( countrycode = 'GY' br_bcbcountrycode = '03379'  )
        ( countrycode = 'HK' br_bcbcountrycode = '03514'  )
        ( countrycode = 'HM' br_bcbcountrycode = '03433'  )
        ( countrycode = 'HN' br_bcbcountrycode = '03450'  )
        ( countrycode = 'HR' br_bcbcountrycode = '01953'  )
        ( countrycode = 'HT' br_bcbcountrycode = '03417'  )
        ( countrycode = 'HU' br_bcbcountrycode = '03557'  )
        ( countrycode = 'ID' br_bcbcountrycode = '03654'  )
        ( countrycode = 'IE' br_bcbcountrycode = '03751'  )
        ( countrycode = 'IL' br_bcbcountrycode = '03832'  )
        ( countrycode = 'IM' br_bcbcountrycode = '03595'  )
        ( countrycode = 'IN' br_bcbcountrycode = '03611'  )
        ( countrycode = 'IO' br_bcbcountrycode = '07820'  )
        ( countrycode = 'IQ' br_bcbcountrycode = '03697'  )
        ( countrycode = 'IR' br_bcbcountrycode = '03727'  )
        ( countrycode = 'IS' br_bcbcountrycode = '03794'  )
        ( countrycode = 'IT' br_bcbcountrycode = '03867'  )
        ( countrycode = 'JE' br_bcbcountrycode = '03930'  )
        ( countrycode = 'JM' br_bcbcountrycode = '03913'  )
        ( countrycode = 'JO' br_bcbcountrycode = '04030'  )
        ( countrycode = 'JP' br_bcbcountrycode = '03999'  )
        ( countrycode = 'KE' br_bcbcountrycode = '06238'  )
        ( countrycode = 'KG' br_bcbcountrycode = '06254'  )
        ( countrycode = 'KH' br_bcbcountrycode = '01414'  )
        ( countrycode = 'KI' br_bcbcountrycode = '04111'  )
        ( countrycode = 'KM' br_bcbcountrycode = '01732'  )
        ( countrycode = 'KN' br_bcbcountrycode = '06955'  )
        ( countrycode = 'KP' br_bcbcountrycode = '01872'  )
        ( countrycode = 'KR' br_bcbcountrycode = '01902'  )
        ( countrycode = 'KW' br_bcbcountrycode = '01988'  )
        ( countrycode = 'KY' br_bcbcountrycode = '01376'  )
        ( countrycode = 'KZ' br_bcbcountrycode = '01538'  )
        ( countrycode = 'LA' br_bcbcountrycode = '04200'  )
        ( countrycode = 'LC' br_bcbcountrycode = '07153'  )
        ( countrycode = 'LI' br_bcbcountrycode = '04405'  )
        ( countrycode = 'LK' br_bcbcountrycode = '07501'  )
        ( countrycode = 'LR' br_bcbcountrycode = '04340'  )
        ( countrycode = 'LS' br_bcbcountrycode = '04260'  )
        ( countrycode = 'LT' br_bcbcountrycode = '04421'  )
        ( countrycode = 'LU' br_bcbcountrycode = '04456'  )
        ( countrycode = 'LV' br_bcbcountrycode = '04278'  )
        ( countrycode = 'LY' br_bcbcountrycode = '04383'  )
        ( countrycode = 'MA' br_bcbcountrycode = '04740'  )
        ( countrycode = 'MC' br_bcbcountrycode = '04952'  )
        ( countrycode = 'MD' br_bcbcountrycode = '04944'  )
        ( countrycode = 'ME' br_bcbcountrycode = '04985'  )
        ( countrycode = 'MF' br_bcbcountrycode = '06980'  )
        ( countrycode = 'MG' br_bcbcountrycode = '04502'  )
        ( countrycode = 'MH' br_bcbcountrycode = '04766'  )
        ( countrycode = 'MK' br_bcbcountrycode = '04499'  )
        ( countrycode = 'ML' br_bcbcountrycode = '04642'  )
        ( countrycode = 'MM' br_bcbcountrycode = '00930'  )
        ( countrycode = 'MN' br_bcbcountrycode = '04979'  )
        ( countrycode = 'MO' br_bcbcountrycode = '04472'  )
        ( countrycode = 'MP' br_bcbcountrycode = '04723'  )
        ( countrycode = 'MQ' br_bcbcountrycode = '04774'  )
        ( countrycode = 'MR' br_bcbcountrycode = '04880'  )
        ( countrycode = 'MS' br_bcbcountrycode = '05010'  )
        ( countrycode = 'MT' br_bcbcountrycode = '04677'  )
        ( countrycode = 'MV' br_bcbcountrycode = '04618'  )
        ( countrycode = 'MW' br_bcbcountrycode = '04588'  )
        ( countrycode = 'MX' br_bcbcountrycode = '04936'  )
        ( countrycode = 'MY' br_bcbcountrycode = '04553'  )
        ( countrycode = 'MZ' br_bcbcountrycode = '05053'  )
        ( countrycode = 'NC' br_bcbcountrycode = '05428'  )
        ( countrycode = 'NE' br_bcbcountrycode = '05258'  )
        ( countrycode = 'NF' br_bcbcountrycode = '05355'  )
        ( countrycode = 'NG' br_bcbcountrycode = '05282'  )
        ( countrycode = 'NI' br_bcbcountrycode = '05215'  )
        ( countrycode = 'NL' br_bcbcountrycode = '05738'  )
        ( countrycode = 'NO' br_bcbcountrycode = '05380'  )
        ( countrycode = 'NP' br_bcbcountrycode = '05177'  )
        ( countrycode = 'NR' br_bcbcountrycode = '05088'  )
        ( countrycode = 'NU' br_bcbcountrycode = '05312'  )
        ( countrycode = 'NZ' br_bcbcountrycode = '05487'  )
        ( countrycode = 'OM' br_bcbcountrycode = '05568'  )
        ( countrycode = 'PA' br_bcbcountrycode = '05800'  )
        ( countrycode = 'PE' br_bcbcountrycode = '05894'  )
        ( countrycode = 'PF' br_bcbcountrycode = '05991'  )
        ( countrycode = 'PG' br_bcbcountrycode = '05452'  )
        ( countrycode = 'PH' br_bcbcountrycode = '02674'  )
        ( countrycode = 'PK' br_bcbcountrycode = '05762'  )
        ( countrycode = 'PL' br_bcbcountrycode = '06033'  )
        ( countrycode = 'PM' br_bcbcountrycode = '07005'  )
        ( countrycode = 'PN' br_bcbcountrycode = '05932'  )
        ( countrycode = 'PR' br_bcbcountrycode = '06114'  )
        ( countrycode = 'PT' br_bcbcountrycode = '06076'  )
        ( countrycode = 'PW' br_bcbcountrycode = '05754'  )
        ( countrycode = 'PY' br_bcbcountrycode = '05860'  )
        ( countrycode = 'QA' br_bcbcountrycode = '01546'  )
        ( countrycode = 'RE' br_bcbcountrycode = '06602'  )
        ( countrycode = 'RO' br_bcbcountrycode = '06700'  )
        ( countrycode = 'RS' br_bcbcountrycode = '07370'  )
        ( countrycode = 'RU' br_bcbcountrycode = '06769'  )
        ( countrycode = 'RW' br_bcbcountrycode = '06750'  )
        ( countrycode = 'SA' br_bcbcountrycode = '00531'  )
        ( countrycode = 'SB' br_bcbcountrycode = '06777'  )
        ( countrycode = 'SC' br_bcbcountrycode = '07315'  )
        ( countrycode = 'SD' br_bcbcountrycode = '07595'  )
        ( countrycode = 'SE' br_bcbcountrycode = '07641'  )
        ( countrycode = 'SG' br_bcbcountrycode = '07412'  )
        ( countrycode = 'SH' br_bcbcountrycode = '07102'  )
        ( countrycode = 'SI' br_bcbcountrycode = '02461'  )
        ( countrycode = 'SJ' br_bcbcountrycode = '07552'  )
        ( countrycode = 'SK' br_bcbcountrycode = '02470'  )
        ( countrycode = 'SL' br_bcbcountrycode = '07358'  )
        ( countrycode = 'SM' br_bcbcountrycode = '06971'  )
        ( countrycode = 'SN' br_bcbcountrycode = '07285'  )
        ( countrycode = 'SO' br_bcbcountrycode = '07480'  )
        ( countrycode = 'SR' br_bcbcountrycode = '07706'  )
        ( countrycode = 'ST' br_bcbcountrycode = '07200'  )
        ( countrycode = 'SV' br_bcbcountrycode = '06874'  )
        ( countrycode = 'SX' br_bcbcountrycode = '06998'  )
        ( countrycode = 'SY' br_bcbcountrycode = '07447'  )
        ( countrycode = 'SZ' br_bcbcountrycode = '07544'  )
        ( countrycode = 'TC' br_bcbcountrycode = '08230'  )
        ( countrycode = 'TD' br_bcbcountrycode = '07889'  )
        ( countrycode = 'TF' br_bcbcountrycode = '07811'  )
        ( countrycode = 'TG' br_bcbcountrycode = '08001'  )
        ( countrycode = 'TH' br_bcbcountrycode = '07765'  )
        ( countrycode = 'TJ' br_bcbcountrycode = '07722'  )
        ( countrycode = 'TK' br_bcbcountrycode = '08052'  )
        ( countrycode = 'TL' br_bcbcountrycode = '07951'  )
        ( countrycode = 'TM' br_bcbcountrycode = '08249'  )
        ( countrycode = 'TN' br_bcbcountrycode = '08206'  )
        ( countrycode = 'TO' br_bcbcountrycode = '08109'  )
        ( countrycode = 'TR' br_bcbcountrycode = '08273'  )
        ( countrycode = 'TT' br_bcbcountrycode = '08150'  )
        ( countrycode = 'TV' br_bcbcountrycode = '08281'  )
        ( countrycode = 'TW' br_bcbcountrycode = '01619'  )
        ( countrycode = 'TZ' br_bcbcountrycode = '07803'  )
        ( countrycode = 'UA' br_bcbcountrycode = '08311'  )
        ( countrycode = 'UG' br_bcbcountrycode = '08338'  )
        ( countrycode = 'UM' br_bcbcountrycode = '04855'  )
        ( countrycode = 'US' br_bcbcountrycode = '02496'  )
        ( countrycode = 'UY' br_bcbcountrycode = '08451'  )
        ( countrycode = 'UZ' br_bcbcountrycode = '08478'  )
        ( countrycode = 'VA' br_bcbcountrycode = '08486'  )
        ( countrycode = 'VC' br_bcbcountrycode = '07056'  )
        ( countrycode = 'VE' br_bcbcountrycode = '08508'  )
        ( countrycode = 'VG' br_bcbcountrycode = '08630'  )
        ( countrycode = 'VI' br_bcbcountrycode = '08664'  )
        ( countrycode = 'VN' br_bcbcountrycode = '08583'  )
        ( countrycode = 'VU' br_bcbcountrycode = '05517'  )
        ( countrycode = 'WF' br_bcbcountrycode = '08753'  )
        ( countrycode = 'WS' br_bcbcountrycode = '06904'  )
        ( countrycode = 'YE' br_bcbcountrycode = '03573'  )
        ( countrycode = 'YT' br_bcbcountrycode = '04898'  )
        ( countrycode = 'ZA' br_bcbcountrycode = '07560'  )
        ( countrycode = 'ZM' br_bcbcountrycode = '08907'  )
        ( countrycode = 'ZW' br_bcbcountrycode = '06653'  )
         ).
    ENDIF.
    READ TABLE t_ibge WITH KEY countrycode = p_country INTO DATA(ls_ibge).
    IF sy-subrc IS INITIAL.
      ibge = ls_ibge-br_bcbcountrycode.
    ENDIF.
  ENDMETHOD.
  METHOD format_date.

    IF iv_date IS INITIAL.
      rv_date = ''.
      RETURN.
    ENDIF.
    IF iv_with_time IS INITIAL.
      rv_date = |{ iv_date+6(2) }{ iv_date+4(2) }{ iv_date(4) }|.
    ELSE.
      rv_date = |{ iv_date+6(2) }{ iv_date+4(2) }{ iv_date(4) }T00:00:00+03:00|.
    ENDIF.

  ENDMETHOD.

  METHOD new_out.

    DATA: ls_out    TYPE ty_main,
          ls_objeto TYPE ty_objetos,
          lv_now    TYPE string,
          lv_dt_ini TYPE string.

    DATA(lv_date) = cl_abap_context_info=>get_system_date( ).
    DATA(lv_time) = cl_abap_context_info=>get_system_time( ).

    lv_now = |{ lv_date+0(4) }-{ lv_date+4(2) }-{ lv_date+6(2) }|
           & |T{ lv_time+0(2) }:{ lv_time+2(2) }:{ lv_time+4(2) }.000Z|.

    DATA(lv_fiscal_date) = |{ sel-fiscalyear }{ sel-fiscalperiod+0(2) }01|.
    lv_dt_ini = |{ lv_fiscal_date+0(4) }-{ lv_fiscal_date+4(2) }-{ lv_fiscal_date+6(2) }|
              & |T03:00:00.000Z|.

    DATA lv_year   TYPE i.
    DATA lv_month  TYPE i.
    lv_year  = CONV i( sel-fiscalyear ).
    lv_month = CONV i( sel-fiscalperiod+1(2) ).
    DATA lv_next_month_first  TYPE d.
    IF lv_month = 12.
      lv_next_month_first = |{ lv_year + 1 }0101|.
    ELSE.
      DATA lv_next_month  TYPE n LENGTH 2.
      lv_next_month = lv_month + 1.
      lv_next_month_first = |{ lv_year }{ lv_next_month }01|.
    ENDIF.
    DATA lv_last_day  TYPE d.
    lv_last_day = lv_next_month_first - 1.
    lv_dt_ini = |{ lv_last_day DATE = ISO }T03:00:00.000Z|.

    LOOP AT gt_sel2 INTO DATA(ls_data).
      CLEAR: ls_out, ls_objeto.


      " ─── KNWH010 ───
      ls_objeto-knwh010-cod_empresa     = CONV i( s_branch_sov-sov_company ).
      ls_objeto-knwh010-cod_filial      = CONV i( s_branch_sov-sov_branch ).
      ls_objeto-knwh010-id_usuario_imp  = sy-uname.
      ls_objeto-knwh010-cd_produto_serv = ls_data-product.
      ls_objeto-knwh010-unidade         = ls_data-unitofmeasure_e.
      ls_objeto-knwh010-vl_total        = ls_data-amountincompanycodecurrency. "vl_total.
      ls_objeto-knwh010-qtde            = ls_data-valuationquantity.
      ls_objeto-knwh010-vl_unitario     = ls_data-movingaverageprice. "standardprice.
      ls_objeto-knwh010-dt_inventario   = lv_dt_ini.
      ls_objeto-knwh010-dm_sit_estoque  = 0.
      ls_objeto-knwh010-vl_total_ir     = ls_data-amountincompanycodecurrency. " ls_data-productvaluationbasic-standardprice.

      " ─── KNW0190 ───

      ls_objeto-knw0190-cod_empresa    = CONV i( s_branch_sov-sov_company ).
      ls_objeto-knw0190-cod_filial     = CONV i( s_branch_sov-sov_branch ).
      "ls_objeto-knw0190-id_usuario_imp = sy-uname.
      ls_objeto-knw0190-dt_inicial     = '1900-01-01T00:00:00+03:00'.
      "ls_objeto-knw0190-dt_importacao  = '1900-01-01T00:00:00+03:00'.
      ls_objeto-knw0190-ds_unidade     = ls_data-unitofmeasure_e.
      ls_objeto-knw0190-ds_descricao   = ls_data-unitofmeasurename.

      " ─── KNW0200 ───

      ls_objeto-knw0200-dt_inicial         = '1900-01-01T00:00:00+03:00'.
      ls_objeto-knw0200-cod_empresa        = CONV i( s_branch_sov-sov_company ).
      ls_objeto-knw0200-cod_filial         = CONV i( s_branch_sov-sov_branch ).
      ls_objeto-knw0200-cd_produto_serv    = ls_data-product.
      ls_objeto-knw0200-ds_produto_serv    = ls_data-productdescription.
      ls_objeto-knw0200-unidade            = ls_data-unitofmeasure_e.
      "<item>-knw0200-dm_tipo_item       = '09'.
      ls_objeto-knw0200-cd_ncm             = normalize( p_str = ls_data-consumptiontaxctrlcode ).
      ls_objeto-knw0200-dm_origem_produto  = ls_data-productorigintype.
      "ls_objeto-knw0200-nr_cest            =
      CASE ls_data-referenceproducttype.
        WHEN 'HAWA'.
          ls_objeto-knw0200-dm_tipo_item = '00'.
        WHEN 'ROH'.
          ls_objeto-knw0200-dm_tipo_item = '01'.
        WHEN 'VERP' OR 'LEIH'.
          ls_objeto-knw0200-dm_tipo_item = '02'.
        WHEN 'PROC' OR 'HALB'.
          ls_objeto-knw0200-dm_tipo_item = '03'.
        WHEN 'FERT'.
          IF ls_data-iscoproduct IS INITIAL.
            ls_objeto-knw0200-dm_tipo_item = '04'.
          ELSE.
            ls_objeto-knw0200-dm_tipo_item = '05'.
          ENDIF.
        WHEN 'HIBE'.
          ls_objeto-knw0200-dm_tipo_item = '06'.
        WHEN 'NLAG'.
          ls_objeto-knw0200-dm_tipo_item = '07'.
        WHEN 'DIEN' OR 'LEIS' OR 'SERV'.
          ls_objeto-knw0200-dm_tipo_item = '09'.
        WHEN OTHERS.
          ls_objeto-knw0200-dm_tipo_item = '99'.
      ENDCASE.

      READ TABLE t_nfitem INTO DATA(ls_nfitem) WITH KEY nf-material = ls_data-product.
      IF sy-subrc = 0.
        READ TABLE t_nfdocs INTO DATA(p_nfdoc) WITH KEY doc-br_notafiscal = ls_nfitem-nf-br_notafiscal.
        IF sy-subrc = 0.
          IF p_nfdoc-doc-br_nfismunicipal <> 'X' AND p_nfdoc-doc-br_nfhasserviceitem <> 'X'.
            IF ls_nfitem-nf-ncmcode IS NOT INITIAL.
              ls_objeto-knw0200-cd_ncm             = normalize( p_str = ls_nfitem-nf-ncmcode ).
            ENDIF.
            IF ls_nfitem-nf-br_materialorigin IS NOT INITIAL.
              ls_objeto-knw0200-dm_origem_produto  = ls_nfitem-nf-br_materialorigin.
            ENDIF.
            IF ls_nfitem-nf-br_icmsstlegalclassfctn IS NOT INITIAL.
              ls_objeto-knw0200-nr_cest            = ls_nfitem-nf-br_icmsstlegalclassfctn.
            ENDIF.
          ELSEIF p_nfdoc-doc-br_nfismunicipal = 'X' OR p_nfdoc-doc-br_nfhasserviceitem = 'X'.
            ls_objeto-knw0200-dm_tipo_item = '09'.
          ENDIF.
        ENDIF.
      ENDIF.

      APPEND ls_objeto TO ls_out-objetos.
      APPEND ls_out TO t_out.

    ENDLOOP.

    "APPEND ls_out TO t_out.
*
*    " Adicionar ao output final
*    APPEND ls_out TO t_out.
*      " knwH010
*      ls_objeto-knwh010-cod_empresa     = ls_data-companhia-codigocia.
*      ls_objeto-knwh010-cod_filial      = ls_data-estabelecimentofiscal-codigo.
*      ls_objeto-knwh010-id_usuario_imp  = sy-uname.
*      ls_objeto-knwh010-cd_plano_conta  = ls_data-codigocontacontabil.
*      ls_objeto-knwh010-ds_complementar = ''. " Ajustar se houver complemento
*      ls_objeto-knwh010-cd_produto_serv = ls_data-item-codigo.
*      ls_objeto-knwh010-unidade         = ls_data-unidademedida-codigo.
*      ls_objeto-knwh010-vl_total        = ls_data-valoritem.
*      ls_objeto-knwh010-qtde            = ls_data-quantidade.
*      ls_objeto-knwh010-vl_unitario     = ls_data-valorunitario.
*      ls_objeto-knwh010-dt_inventario   = lv_inventory_date.
*      ls_objeto-knwh010-dm_sit_estoque  = ls_data-indicadorpropriedade.
*      ls_objeto-knwh010-cd_pessoa_propr = ls_data-controles-lifnr.
*      ls_objeto-knwh010-vl_total_ir     = 0. " Ajustar se houver valor IR
*
*                                                            " knw0150
*      IF ls_data-controles-lifnr IS NOT INITIAL.
*        ls_objeto-knw0150-cod_empresa    = ls_data-companhia-codigocia.
*        ls_objeto-knw0150-cod_filial     = ls_data-estabelecimentofiscal-codigo.
*        ls_objeto-knw0150-id_usuario_imp = sy-uname.
*        ls_objeto-knw0150-dt_inicial     = lv_inventory_date.
*        ls_objeto-knw0150-dt_importacao  = lv_inventory_date.
*        ls_objeto-knw0150-cd_pessoa      = ls_data-controles-lifnr.
*        " Demais campos devem vir de tabelas de fornecedor - ajustar conforme necessário
*        ls_objeto-knw0150-nm_razao_social = ''. " Buscar da master data
*        ls_objeto-knw0150-nr_cnpj_cpf     = ''. " Buscar da master data
*      ENDIF.
*
*      "  knw0190
*      ls_objeto-knw0190-cod_empresa    = ls_data-unidademedida-companhia-codigocia.
*      ls_objeto-knw0190-cod_filial     = ls_data-estabelecimentofiscal-codigo.
*      ls_objeto-knw0190-id_usuario_imp = sy-uname.
*      ls_objeto-knw0190-dt_inicial     = lv_inventory_date.
*      ls_objeto-knw0190-dt_importacao  = lv_inventory_date.
*      ls_objeto-knw0190-ds_unidade     = ls_data-item-unidademedidaestoque-codigo.
*      ls_objeto-knw0190-ds_descricao   = ls_data-item-unidademedidaestoque-descricao.
*
*                                                            " knw0200
*      ls_objeto-knw0200-cod_empresa          = ls_data-item-companhia-codigocia.
*      ls_objeto-knw0200-cod_filial           = ls_data-estabelecimentofiscal-codigo.
*      ls_objeto-knw0200-id_usuario_imp       = sy-uname.
*      ls_objeto-knw0200-cd_plano_conta       = ls_data-codigocontacontabil.
*      ls_objeto-knw0200-dt_inicial           = lv_inventory_date.
*      ls_objeto-knw0200-dt_importacao        = lv_inventory_date.
*      ls_objeto-knw0200-cd_produto_serv      = ls_data-item-codigo.
*      ls_objeto-knw0200-ds_produto_serv      = ls_data-item-descricao.
*      ls_objeto-knw0200-unidade              = ls_data-item-unidademedidaestoque-codigo.
*      ls_objeto-knw0200-cd_ncm               = ls_data-item-codigoclassificacaofiscal.
*      ls_objeto-knw0200-dm_tipo_item         = ls_data-item-tipoitem-codigo.
*      " Campos tributários devem vir de configuração fiscal
*      ls_objeto-knw0200-cd_sit_tributar_icms = ''. " Buscar da config fiscal
*      ls_objeto-knw0200-aliq_icms            = 0.
*      ls_objeto-knw0200-perc_red_ba_icms     = 0.
*      ls_objeto-knw0200-dm_produto_venda     = ''. " Ajustar
*      ls_objeto-knw0200-cd_lst               = ''. " Ajustar
*      ls_objeto-knw0200-cd_genero            = ''. " Ajustar
*      ls_objeto-knw0200-cd_331_ex_ipi        = ''. " Ajustar
*      ls_objeto-knw0200-cd_barra             = ''. " Ajustar
*      ls_objeto-knw0200-nr_cest              = ''. " Ajustar
*      ls_objeto-knw0200-dm_origem_produto    = ''. " Ajustar (0-9)
*      ls_objeto-knw0200-cd_centro_custo      = ''. " Ajustar
*      ls_objeto-knw0200-cd_sit_trib_ipi      = ''. " Ajustar
*      ls_objeto-knw0200-cd_sit_trib_pis      = ''. " Ajustar
*      ls_objeto-knw0200-cd_sit_trib_cofins   = ''. " Ajustar
*      ls_objeto-knw0200-cd_nat_operacao      = ''. " Ajustar
*      ls_objeto-knw0200-aliq_pis             = 0.
*      ls_objeto-knw0200-aliq_cofins          = 0.
*
*      " ========== knw0500 - Plano de contas ==========
*      ls_objeto-knw0500-cod_empresa     = ls_data-companhia-codigocia.
*      ls_objeto-knw0500-cod_filial      = ls_data-estabelecimentofiscal-codigo.
*      ls_objeto-knw0500-id_usuario_imp  = sy-uname.
*      ls_objeto-knw0500-cd_plano_conta  = ls_data-codigocontacontabil.
*      ls_objeto-knw0500-dt_inicial      = lv_inventory_date.
*      ls_objeto-knw0500-dt_importacao   = lv_inventory_date.
*      " Campos do plano de contas devem vir da master data - ajustar
*      ls_objeto-knw0500-dm_tipo_conta   = 'A'. " Analítica/Sintética
*      ls_objeto-knw0500-cd_plan_cta_tot = ''. " Conta totalizadora
*      ls_objeto-knw0500-ds_plano_conta  = ''. " Descrição da conta
*      ls_objeto-knw0500-dm_natureza     = '01'. " 01-Ativo, 02-Passivo, etc
*      ls_objeto-knw0500-dm_nivel        = ''. " Nível da conta
*      ls_objeto-knw0500-dm_geral_aux    = 'G'. " Geral ou Auxiliar
*      ls_objeto-knw0500-id_ordem        = 0.
*      ls_objeto-knw0500-cd_reduzida     = ''.
*
*      " knwH020List
*
*
*      " knwH030
*      ls_objeto-knwh030-cod_empresa     = ls_data-companhia-codigocia.
*      ls_objeto-knwh030-cod_filial      = ls_data-estabelecimentofiscal-codigo.
*      ls_objeto-knwh030-id_usuario_imp  = sy-uname.
*      ls_objeto-knwh030-cd_produto_serv = ls_data-item-codigo.
*      ls_objeto-knwh030-dt_inventario   = lv_inventory_date.
*      ls_objeto-knwh030-dm_sit_estoque  = ls_data-indicadorpropriedade.
*      ls_objeto-knwh030-cd_pessoa_propr = ls_data-controles-lifnr.
*      ls_objeto-knwh030-vl_icms_op      = 0. " Ajustar se houver
*      ls_objeto-knwh030-vl_bc_icms_st   = 0. " Ajustar se houver
*      ls_objeto-knwh030-vl_icms_st      = 0. " Ajustar se houver
*      ls_objeto-knwh030-vl_fcp          = 0. " Ajustar se houver
*
*      " Adicionar objeto ao array
*      APPEND ls_objeto TO ls_out-objetos.
  ENDMETHOD.

  METHOD read_db.

    DATA: lr_products TYPE RANGE OF i_journalentryitem-product.
    " Transform ANOMES (MMYYYY) to date range
    DATA: lv_month  TYPE c LENGTH 2,
          lv_year   TYPE c LENGTH 4,
          lv_date_f TYPE datum,
          lv_date_t TYPE datum,
          lr_anomes TYPE RANGE OF datum,
          r_docnum  TYPE RANGE OF i_br_nfdocument-br_notafiscal,
          ls_anomes LIKE LINE OF lr_anomes.

    " Extract month and year from MMYYYY
    lv_month = sel-fiscalperiod+1(2).   " First 2 chars = MM
    lv_year  = sel-fiscalyear.    " Last 4 chars  = YYYY

    " Build first day of month: YYYYMM01
    lv_date_f = lv_year && lv_month && '01'.

    " Build last day of month using month-end logic
    lv_date_t = lv_date_f.
    lv_date_t+6(2) = '01'.         " Set day to 01
    ADD 1 TO lv_date_t+4(2).       " Add 1 month
    IF lv_date_t+4(2) = 13.        " Handle December → January
      lv_date_t+4(2) = '01'.
      ADD 1 TO lv_date_t(4).        " Bump year
    ENDIF.
    SUBTRACT 1 FROM lv_date_t.     " Go back 1 day = last day of month

    " Build range entry
    ls_anomes-sign   = 'I'.
    ls_anomes-option = 'BT'.
    ls_anomes-low    = lv_date_f.  " e.g. 20250101
    ls_anomes-high   = lv_date_t.  " e.g. 20250131
    APPEND ls_anomes TO lr_anomes.

    " Use in SELECT
    SELECT doc~*, act~*
      FROM i_br_nfdocument AS doc
      LEFT JOIN i_br_nfeactive AS act
        ON doc~br_notafiscal = act~br_notafiscal
      WHERE doc~companycode                    = @sel-companycode
        AND doc~businessplace                  = @sel-businessplace
        "AND doc~creationdate                   IN @sel-creation
        AND doc~br_nfpostingdate               IN @lr_anomes
        "AND doc~br_nftype                      IN @sel-nftype
        "AND doc~br_notafiscal                  IN @sel-document
        "AND doc~br_nfissuedate                 IN @sel-docdate
        "AND doc~br_nfpostingdate               IN @lr_anomes
        "AND doc~br_nfarrivalordeparturedate    IN @sel-dsaient
        "AND doc~lastchangedate                 IN @sel-changed
      INTO TABLE @t_nfdocs.

    LOOP AT t_nfdocs INTO DATA(ls_nf).
      APPEND VALUE #( sign = 'I' option = 'EQ' low = ls_nf-doc-br_notafiscal ) TO r_docnum.
    ENDLOOP.

    SELECT nf~*, a~product, a~producttype, a~baseunit,
            c~plant, c~iscoproduct,
            a~\_producttype-referenceproducttype,
            nf~\_baseunit-unitofmeasureisocode, nf~\_baseunit-unitofmeasure_e, nf~\_baseunit\_text[ language = 'P' ]-unitofmeasurename,
            i_glaccount~\_text[ language = 'P' ]-glaccountname, i_glaccount~chartofaccounts
      FROM i_br_nfitem AS nf
      LEFT OUTER JOIN i_product AS a
      ON nf~material = a~product
      LEFT OUTER JOIN i_productplantbasic AS c
      ON a~product = c~product
      AND c~plant = nf~plant
      LEFT OUTER JOIN i_productvaluationbasic AS val
      ON val~valuationarea = nf~plant
      AND val~product = a~product
      AND val~valuationarea = ''
      LEFT OUTER JOIN i_glaccount
      ON i_glaccount~glaccount = nf~glaccount
      AND i_glaccount~companycode = @sel-companycode
      WHERE nf~br_notafiscal IN @r_docnum
      INTO TABLE @t_nfitem. "J_BNFLIN

    SELECT SINGLE *
      FROM /pyxs/sov_branch
    WHERE company_code = @sel-companycode
      AND branch = @sel-businessplace
      INTO @s_branch_sov.

    select    stock~material,
         sum( stock~valuationquantity ) as val,
         sum( stock~amountincompanycodecurrency ) as amountincompanycodecurrency,
         max( productvaluationbasic~movingaverageprice ) as movingaverageprice,
         max( stock~unitofmeasure ) as un,
         max( product~product ) as product,
         max( productdescription~productdescription ) as productdescription,
         max( productplantbasic~consumptiontaxctrlcode ) as consumptiontaxctrlcode,
         max( productvaluationbasic~productorigintype ) as productorigintype,
         max( product~\_baseunitofmeasure-unitofmeasure_e ) as unitofmeasure_e,
         max( product~\_baseunitofmeasure\_text[ language = 'P' ]-unitofmeasurename ) as unitofmeasurename,
         max( product~\_producttype-referenceproducttype ) as referenceproducttype,
         max( productplantbasic~iscoproduct ) as iscoproduct
          from i_inventoryamtbyfsclperd(
           p_fiscalperiod = @sel-fiscalperiod,
           p_fiscalyear   = @sel-fiscalyear ) as stock
    INNER JOIN i_product AS product
      ON   stock~material = product~product
    INNER JOIN i_productdescription AS productdescription
      ON  stock~material = productdescription~product
      AND productdescription~language = 'P'
    INNER JOIN i_unitofmeasuretext AS unitofmeasuretext
      ON  stock~unitofmeasure         = unitofmeasuretext~unitofmeasure
      AND unitofmeasuretext~language  = 'P'
    INNER JOIN i_productplantbasic AS productplantbasic
      ON  stock~material       = productplantbasic~product
      AND stock~valuationarea  = productplantbasic~plant
    INNER JOIN i_productvaluationbasic AS productvaluationbasic
      ON  stock~material      = productvaluationbasic~product AND
          stock~valuationarea = productvaluationbasic~valuationarea
    INNER JOIN i_plant AS plant
      ON  stock~valuationarea = plant~valuationarea
    LEFT JOIN i_supplier AS supplier
      ON stock~supplier = supplier~supplier
    WHERE stock~companycode  = @sel-companycode
        AND stock~material     IN @sel-product
        AND plant~businessplace = @sel-businessplace
        AND productvaluationbasic~valuationtype = ''
        AND stock~ledger = '0L'
      group by stock~material
      INTO TABLE @gt_sel2.

    SELECT SINGLE companycode, companycodename
      FROM i_companycode
     WHERE companycode = @sel-companycode
      INTO @gs_company.

    LOOP AT gt_sel2 INTO DATA(ls_product).
      APPEND VALUE #( sign = 'I' option = 'EQ' low = ls_product-material ) TO lr_products.
    ENDLOOP.

    IF lr_products IS NOT INITIAL.
      SELECT DISTINCT product, glaccount FROM i_journalentryitem
        WHERE ledger    = @sel-ledger
        AND companycode = @sel-companycode
        AND product     IN @lr_products
        AND transactiontypedetermination = 'BSX'
        INTO TABLE @gt_accounts.
    ENDIF.


  ENDMETHOD.

  METHOD popu.
    t_tax_type =
      VALUE #(
  ( br_taxtype = 'CCOP' br_taxgroup = 'ICOP' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'CCOX' br_taxgroup = '' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'CIC0' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'CIC1' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'CIC2' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'CIC3' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'CICA' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'CIDC' br_taxgroup = 'ICOP' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'CIDF' br_taxgroup = 'ICOP' br_icmspartilhasubdivisioncode = '004'  )
  ( br_taxtype = 'CIFC' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = '004'  )
  ( br_taxtype = 'CIIC' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'CISF' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = '004'  )
  ( br_taxtype = 'CIST' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'COF0' br_taxgroup = 'COFI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'COFD' br_taxgroup = 'COFI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'COFT' br_taxgroup = 'COFI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'CST1' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'CST2' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'CST3' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'FCP1' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = '004'  )
  ( br_taxtype = 'FCP2' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = '004'  )
  ( br_taxtype = 'FCP5' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = '004'  )
  ( br_taxtype = 'FCP6' br_taxgroup = '' br_icmspartilhasubdivisioncode = '004'  )
  ( br_taxtype = 'FCPI' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = '004'  )
  ( br_taxtype = 'FCPO' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = '004'  )
  ( br_taxtype = 'FPS1' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = '004'  )
  ( br_taxtype = 'FPS2' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = '004'  )
  ( br_taxtype = 'FPS5' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = '004'  )
  ( br_taxtype = 'FPS6' br_taxgroup = '' br_icmspartilhasubdivisioncode = '004'  )
  ( br_taxtype = 'FPSI' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = '004'  )
  ( br_taxtype = 'FPSO' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = '004'  )
  ( br_taxtype = 'IC1C' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IC1O' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICAM' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICAP' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = '001'  )
  ( br_taxtype = 'ICBP' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICCP' br_taxgroup = 'ICOP' br_icmspartilhasubdivisioncode = '004'  )
  ( br_taxtype = 'ICCX' br_taxgroup = '' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICEM' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICEP' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = '002'  )
  ( br_taxtype = 'ICFO' br_taxgroup = '' br_icmspartilhasubdivisioncode = '004'  )
  ( br_taxtype = 'ICFP' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = '004'  )
  ( br_taxtype = 'ICM0' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICM1' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICM2' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICM3' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICM4' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICM5' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = '005'  )
  ( br_taxtype = 'ICM6' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = '006'  )
  ( br_taxtype = 'ICM7' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = '005'  )
  ( br_taxtype = 'ICM8' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = '006'  )
  ( br_taxtype = 'ICMF' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICML' br_taxgroup = '' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICMM' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICMN' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICMP' br_taxgroup = '' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICMT' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICMU' br_taxgroup = '' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICMV' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICMX' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICN3' br_taxgroup = 'COFI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICO1' br_taxgroup = 'ICOP' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICO3' br_taxgroup = 'ICOP' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICO4' br_taxgroup = '' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICOA' br_taxgroup = 'COFI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICOC' br_taxgroup = 'COFI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICOF' br_taxgroup = 'COFI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICOG' br_taxgroup = 'COFI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICOH' br_taxgroup = 'COFI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICON' br_taxgroup = 'COFI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICOO' br_taxgroup = 'COFI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICOP' br_taxgroup = 'ICOP' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICOQ' br_taxgroup = 'WACO' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICOR' br_taxgroup = 'COFI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICOS' br_taxgroup = 'COFI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICOT' br_taxgroup = 'ICOP' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICOU' br_taxgroup = 'COFI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICOV' br_taxgroup = 'COFI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICOW' br_taxgroup = 'WHCO' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICOX' br_taxgroup = '' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICOZ' br_taxgroup = '' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICS1' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICS2' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICS3' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICS4' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICS5' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICS6' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICS7' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICS9' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICSC' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = '004'  )
  ( br_taxtype = 'ICSE' br_taxgroup = '' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICSF' br_taxgroup = 'COFI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICSM' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICSO' br_taxgroup = '' br_icmspartilhasubdivisioncode = '004'  )
  ( br_taxtype = 'ICSP' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = '003'  )
  ( br_taxtype = 'ICSQ' br_taxgroup = 'WACS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICST' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICSW' br_taxgroup = 'WHCS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICSZ' br_taxgroup = '' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICTP' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICW3' br_taxgroup = 'WHCO' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICW5' br_taxgroup = 'WACO' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICZF' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICZG' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICZT' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IFR1' br_taxgroup = 'ICFR' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IFR3' br_taxgroup = 'ICFR' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IFS1' br_taxgroup = 'ICFS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IFS3' br_taxgroup = 'ICFS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IGEQ' br_taxgroup = 'WAT' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IGEW' br_taxgroup = 'WHT' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IGEZ' br_taxgroup = '' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IGW3' br_taxgroup = 'WHT' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IGW5' br_taxgroup = 'WAT' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'II01' br_taxgroup = 'II' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IIRQ' br_taxgroup = 'WAIR' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IIRW' br_taxgroup = 'WHIR' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IIRZ' br_taxgroup = '' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'INS3' br_taxgroup = 'CPRB' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'INSS' br_taxgroup = '' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'INSW' br_taxgroup = 'INSS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'INSX' br_taxgroup = '' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'INWI' br_taxgroup = 'INSS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'INWO' br_taxgroup = 'INSS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IP1C' br_taxgroup = 'IPI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IP1O' br_taxgroup = 'IPI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPI0' br_taxgroup = 'IPI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPI1' br_taxgroup = 'IPI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPI2' br_taxgroup = 'IPI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPI3' br_taxgroup = 'IPI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPI4' br_taxgroup = 'IPI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPI5' br_taxgroup = 'IPI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPIA' br_taxgroup = 'IPI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPIB' br_taxgroup = 'IPI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPIC' br_taxgroup = 'PIS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPIN' br_taxgroup = 'IPI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPIS' br_taxgroup = 'PIS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPIU' br_taxgroup = '' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPIX' br_taxgroup = 'IPI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPS3' br_taxgroup = 'PIS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPSA' br_taxgroup = 'PIS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPSF' br_taxgroup = 'PIS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPSG' br_taxgroup = 'PIS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPSH' br_taxgroup = 'PIS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPSN' br_taxgroup = 'PIS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPSO' br_taxgroup = 'PIS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPSQ' br_taxgroup = 'WAPI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPSS' br_taxgroup = 'PIS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPSU' br_taxgroup = 'PIS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPSV' br_taxgroup = 'PIS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPSW' br_taxgroup = 'WHPI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPSZ' br_taxgroup = '' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPW3' br_taxgroup = 'WHPI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPW5' br_taxgroup = 'WAPI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IRD1' br_taxgroup = 'RBIC' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IRD2' br_taxgroup = 'RBIC' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IRD3' br_taxgroup = 'RBST' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IRD4' br_taxgroup = 'RBST' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IRD5' br_taxgroup = 'RBIC' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IRD6' br_taxgroup = 'RBST' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IRRW' br_taxgroup = 'IRRF' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IRW3' br_taxgroup = 'WHIR' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IRW5' br_taxgroup = 'WAIR' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IRWI' br_taxgroup = 'WHIR' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IRWO' br_taxgroup = 'WHIR' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IS1C' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IS1O' br_taxgroup = '' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ISA3' br_taxgroup = 'ISSP' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ISB3' br_taxgroup = 'ISSP' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ISE3' br_taxgroup = 'ISSS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ISF3' br_taxgroup = 'ISSS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ISS2' br_taxgroup = 'ISS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ISS3' br_taxgroup = 'ISS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ISSA' br_taxgroup = 'ISSP' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ISSB' br_taxgroup = 'ISSP' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ISSE' br_taxgroup = 'ISSS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ISSF' br_taxgroup = 'ISSS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ISSG' br_taxgroup = 'ISSP' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ISSO' br_taxgroup = 'ISS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ISUP' br_taxgroup = 'COFI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ISW3' br_taxgroup = 'WHCS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ISW5' br_taxgroup = 'WACS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IT1C' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IT1O' br_taxgroup = '' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'PIS0' br_taxgroup = 'PIS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'TCOS' br_taxgroup = 'COFI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'TPIS' br_taxgroup = 'PIS' br_icmspartilhasubdivisioncode = ''  )
   ).
  ENDMETHOD.

  METHOD main.

    lcl_process=>data = cl_abap_context_info=>get_system_date( ).
    lcl_process=>hora = cl_abap_context_info=>get_system_time( ).

    lcl_process=>read_db(  ).
    lcl_process=>new_out(  ).
    lcl_process=>send_integration( ).

  ENDMETHOD.


ENDCLASS.