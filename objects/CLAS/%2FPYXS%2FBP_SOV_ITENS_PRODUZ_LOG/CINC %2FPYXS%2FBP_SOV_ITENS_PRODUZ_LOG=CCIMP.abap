*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations


CLASS lhc_SOV_ITENS_PRODUZ_LOG DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR /pyxs/SOV_ITENS_PRODUZ_LOG RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE /pyxs/SOV_ITENS_PRODUZ_LOG.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE /pyxs/SOV_ITENS_PRODUZ_LOG.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE /pyxs/SOV_ITENS_PRODUZ_LOG.

    METHODS read FOR READ
      IMPORTING keys FOR READ /pyxs/SOV_ITENS_PRODUZ_LOG RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK /pyxs/SOV_ITENS_PRODUZ_LOG.

    METHODS sendintegration FOR MODIFY
      IMPORTING keys FOR ACTION /pyxs/SOV_ITENS_PRODUZ_LOG~sendintegration RESULT res.


ENDCLASS.


CLASS lcl_process DEFINITION FRIENDS lhc_SOV_ITENS_PRODUZ_LOG.
  PUBLIC SECTION.
    CLASS-METHODS: main.

    TYPES:
      "----------------------------------------------------------------------
      " knwK230 – Itens produzidos / movimentações de produção
      "----------------------------------------------------------------------
      BEGIN OF ty_knwk230,
        cod_empresa        TYPE p LENGTH 15 DECIMALS 2,
        cod_filial         TYPE p LENGTH 15 DECIMALS 2,
        cod_grupoempresa   TYPE string,
        dt_periodo         TYPE string,
        cd_produto_servico TYPE string,
        dt_inicio_op       TYPE string,
        dt_final_op        TYPE string,
        nr_doc_op          TYPE string,
        qtde_acabada       TYPE p LENGTH 15 DECIMALS 2,
      END OF ty_knwk230,

      "----------------------------------------------------------------------
      " knw0190 – Unidades de medida
      "----------------------------------------------------------------------
      BEGIN OF ty_knw0190,
        cod_empresa   TYPE p LENGTH 15 DECIMALS 2,
        cod_filial    TYPE p LENGTH 15 DECIMALS 2,
        dt_inicial    TYPE string,
        dt_importacao TYPE string,
        ds_unidade    TYPE string,
        ds_descricao  TYPE string,
      END OF ty_knw0190,

      "----------------------------------------------------------------------
      " knw0200 – Cadastro de produtos/serviços
      "----------------------------------------------------------------------
      BEGIN OF ty_knw0200,
        dt_inicial        TYPE string,
        dt_importacao     TYPE string,
        cod_empresa       TYPE p LENGTH 15 DECIMALS 2,
        cod_filial        TYPE p LENGTH 15 DECIMALS 2,
        cd_produto_serv   TYPE string,
        ds_produto_serv   TYPE string,
        unidade           TYPE string,
        aliq_icms         TYPE p LENGTH 15 DECIMALS 2,
        perc_red_ba_icms  TYPE p LENGTH 15 DECIMALS 2,
        cd_ncm            TYPE string,
        cd_genero         TYPE string,
        dm_tipo_item      TYPE string,
        cd_barra          TYPE string,
        dm_origem_produto TYPE string,
        aliq_pis          TYPE p LENGTH 15 DECIMALS 2,
        aliq_cofins       TYPE p LENGTH 15 DECIMALS 2,
      END OF ty_knw0200,

      "----------------------------------------------------------------------
      " Estrutura de resultado da seleção principal
      "----------------------------------------------------------------------
      BEGIN OF ty_movimento,
        materialdocumentyear  TYPE i_materialdocumentitem_2-materialdocumentyear,
        materialdocument      TYPE i_materialdocumentitem_2-materialdocument,
        materialdocumentitem  TYPE i_materialdocumentitem_2-materialdocumentitem,
        manufacturingorder    TYPE i_materialdocumentitem_2-manufacturingorder,
        material              TYPE i_materialdocumentitem_2-material,
        plant                 TYPE i_materialdocumentitem_2-plant,
        goodsmovementtype     TYPE i_materialdocumentitem_2-goodsmovementtype,
        debitcreditcode       TYPE i_materialdocumentitem_2-debitcreditcode,
        quantityinbaseunit    TYPE i_materialdocumentitem_2-quantityinbaseunit,
        materialbaseunit      TYPE i_materialdocumentitem_2-materialbaseunit,
        postingdate           TYPE i_materialdocumentitem_2-postingdate,
        documentdate          TYPE i_materialdocumentitem_2-documentdate,
        mfgorderplannedstartdate TYPE i_manufacturingorder-mfgorderplannedstartdate,
        mfgorderscheduledstartdate TYPE i_manufacturingorder-mfgorderscheduledstartdate,
      END OF ty_movimento,

      ty_t_movimentos TYPE STANDARD TABLE OF ty_movimento WITH NON-UNIQUE DEFAULT KEY,

      BEGIN OF ty_estornos,
        materialdocumentyear  TYPE i_materialdocumentitem_2-materialdocumentyear,
        materialdocument      TYPE i_materialdocumentitem_2-materialdocument,
        materialdocumentitem  TYPE i_materialdocumentitem_2-materialdocumentitem,
        manufacturingorder    TYPE i_materialdocumentitem_2-manufacturingorder,
        material              TYPE i_materialdocumentitem_2-material,
        plant                 TYPE i_materialdocumentitem_2-plant,
        goodsmovementtype     TYPE i_materialdocumentitem_2-goodsmovementtype,
        debitcreditcode       TYPE i_materialdocumentitem_2-debitcreditcode,
        quantityinbaseunit    TYPE i_materialdocumentitem_2-quantityinbaseunit,
        materialbaseunit      TYPE i_materialdocumentitem_2-materialbaseunit,
        postingdate           TYPE i_materialdocumentitem_2-postingdate,
        documentdate          TYPE i_materialdocumentitem_2-documentdate,
        mfgorderplannedstartdate TYPE i_manufacturingorder-mfgorderplannedstartdate,
        mfgorderscheduledstartdate TYPE i_manufacturingorder-mfgorderscheduledstartdate,
        reversedmaterialdocumentyear TYPE i_materialdocumentitem_2-reversedmaterialdocumentyear,
        reversedmaterialdocument TYPE i_materialdocumentitem_2-reversedmaterialdocument,
        reversedmaterialdocumentitem TYPE i_materialdocumentitem_2-reversedmaterialdocumentitem,
      END OF ty_estornos,

      ty_t_estornos TYPE STANDARD TABLE OF ty_estornos WITH NON-UNIQUE DEFAULT KEY,

      "----------------------------------------------------------------------
      " Parâmetros de seleção
      "----------------------------------------------------------------------
      BEGIN OF ty_sel,
        companycode     TYPE i_companycode-companycode,
        plant           TYPE i_plant-plant,
        anomes          TYPE string,
        extractionorlog TYPE c LENGTH 3,
      END OF ty_sel,

      "----------------------------------------------------------------------
      " Dados enriquecidos do produto (join complementar)
      "----------------------------------------------------------------------
      BEGIN OF ty_product_data,
        product            TYPE i_product-product,
        producttype        TYPE i_product-producttype,
        baseunit           TYPE i_product-baseunit,
        productstandardid TYPE i_product-productstandardid,
        productdescription TYPE i_productdescription-productdescription,
        "ncminternationalcode TYPE i_product-ncminternationalcode,
      END OF ty_product_data,

      ty_t_product_data TYPE STANDARD TABLE OF ty_product_data WITH NON-UNIQUE DEFAULT KEY,

      "----------------------------------------------------------------------
      " Objeto completo enviado por linha de movimento
      "----------------------------------------------------------------------

      BEGIN OF ty_knwk235_json,
        dt_IMPORTACAO       TYPE string,
        cod_empresa         TYPE p LENGTH 15 DECIMALS 2,
        cod_filial          TYPE p LENGTH 15 DECIMALS 2,
        cod_GRUPOEMPRESA    TYPE string,
        nr_SEQUENCIA        TYPE string,
        dt_PERIODO          TYPE string,
        qtde                TYPE p LENGTH 15 DECIMALS 2,
        cd_PROD_SERV_INSUMO TYPE string,
        nr_DOC_OP           TYPE string,
        dt_SAIDA            TYPE string,
      END OF ty_knwk235_json,

    "! Item de insumo consumido (K235 + 0200 + 0190 do insumo)
      BEGIN OF ty_item_consumido,
        knwK235               TYPE ty_knwk235_json,
        knw0200produtoinsumo TYPE ty_knw0200,
        knw0190produtoinsumo TYPE ty_knw0190,
      END OF ty_item_consumido,
      tt_itens_consumidos TYPE STANDARD TABLE OF ty_item_consumido WITH EMPTY KEY,

      BEGIN OF ty_objetos,
        knwk230 TYPE ty_knwk230,
        knw0200 TYPE ty_knw0200,
        knw0190 TYPE ty_knw0190,
        integr_itens_consum_list          TYPE tt_itens_consumidos,
        "integr_consum_espec_padr_list   TYPE string_table, " sempre vazio no payload exemplo
      END OF ty_objetos,

      BEGIN OF ty_main,
        objetos TYPE STANDARD TABLE OF ty_objetos WITH NON-UNIQUE DEFAULT KEY,
      END OF ty_main,

      ty_t_main TYPE ty_main,

      BEGIN OF ty_companycode,
        companycode     TYPE i_companycode-companycode,
        companycodename TYPE i_companycode-companycodename,
      END OF ty_companycode.


    TYPES:
      BEGIN OF ty_item_consumido_json,
        knwK235              TYPE ty_knwk235_json,
        knw0200ProdutoInsumo TYPE ty_knw0200,
        knw0190ProdutoInsumo TYPE ty_knw0190,
      END OF ty_item_consumido_json.

    TYPES:
      tt_item_consumido_json TYPE STANDARD TABLE OF ty_item_consumido_json WITH EMPTY KEY.

    TYPES:
      BEGIN OF ty_objeto_json,
        knwK230                       TYPE ty_knwk230,
        knw0200                       TYPE ty_knw0200,
        knw0190                       TYPE ty_knw0190,
        integracaoItensConsumidosList TYPE tt_item_consumido_json,
      END OF ty_objeto_json.

    TYPES:
      tt_objeto_json TYPE STANDARD TABLE OF ty_objeto_json WITH EMPTY KEY.

    TYPES:
      BEGIN OF ty_root_json,
        objetos TYPE tt_objeto_json,
      END OF ty_root_json.

    CLASS-DATA:
      sel           TYPE ty_sel,
      data          TYPE d,
      hora          TYPE t,
      t_out         TYPE TABLE OF ty_t_main,
      gv_proc       TYPE string,
      gs_company    TYPE ty_companycode,
      s_branch_sov  TYPE /pyxs/sov_branch,
      gt_movimentos TYPE ty_t_movimentos,
      gt_estorno    TYPE ty_t_estornos,
      gt_products   TYPE ty_t_product_data.

  PRIVATE SECTION.
    CLASS-METHODS:
      read_db,
      new_out,
      send_integration,

      format_date
        IMPORTING
          iv_date        TYPE d
          iv_with_time   TYPE abap_bool DEFAULT abap_true
        RETURNING
          VALUE(rv_date) TYPE string,
      get_period_limits
        IMPORTING
          iv_anomes      TYPE string
        EXPORTING
          ev_first_day   TYPE d
          ev_last_day    TYPE d.

      CLASS-METHODS:
  build_integration_json
    IMPORTING is_main        TYPE ty_main
    RETURNING VALUE(rv_json) TYPE string,

  build_k230
    IMPORTING is_k230        TYPE ty_knwk230
    RETURNING VALUE(rv_json) TYPE string,

  build_k235
    IMPORTING is_k235        TYPE ty_knwk235_json   " reaproveitando o tipo
              iv_seq         TYPE i
    RETURNING VALUE(rv_json) TYPE string,

  build_0200
    IMPORTING is_0200        TYPE ty_knw0200
    RETURNING VALUE(rv_json) TYPE string,

  build_0190
    IMPORTING is_0190        TYPE ty_knw0190
    RETURNING VALUE(rv_json) TYPE string,

  format_decimal
    IMPORTING iv_value       TYPE p
    RETURNING VALUE(rv_str)  TYPE string,

  escape_json
    IMPORTING iv_str         TYPE string
    RETURNING VALUE(rv_str)  TYPE string.

ENDCLASS.


CLASS lhc_SOV_ITENS_PRODUZ_LOG IMPLEMENTATION.

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

    lcl_process=>data = cl_abap_context_info=>get_system_date( ).
    lcl_process=>hora = cl_abap_context_info=>get_system_time( ).

    "-----------------------------------------------------------------------
    " Validação: Company, Plant e Anomes obrigatórios
    "-----------------------------------------------------------------------
    lcl_process=>sel-companycode = keys[ 1 ]-%param-company.
    lcl_process=>sel-plant       = keys[ 1 ]-%param-branch.
    lcl_process=>sel-anomes      = keys[ 1 ]-%param-anomes.

    IF lcl_process=>sel-companycode IS INITIAL OR lcl_process=>sel-plant IS INITIAL.
      APPEND VALUE #( %action-sendintegration = if_abap_behv=>mk-on
      ) TO failed-/pyxs/SOV_ITENS_PRODUZ_LOG.
      APPEND VALUE #(
        %msg = new_message_with_text(
          severity = if_abap_behv_message=>severity-error
          text     = 'Empresa e Local de Negócio são obrigatórios' )
        %action-sendintegration = if_abap_behv=>mk-on
      ) TO reported-/pyxs/SOV_ITENS_PRODUZ_LOG.
    ENDIF.

    CHECK failed-/pyxs/SOV_ITENS_PRODUZ_LOG IS INITIAL.

    lcl_process=>read_db( ).


      lcl_process=>new_out( ).
      lcl_process=>send_integration( ).


***    IF lcl_process=>gt_movimentos IS INITIAL.
***      APPEND INITIAL LINE TO /pyxs/bp_SOV_ITENS_PRODUZ_LOG=>lt_log ASSIGNING FIELD-SYMBOL(<log>).
***      GET TIME STAMP FIELD DATA(time).
***      <log>-timedate   = time.
***      <log>-anomes     = keys[ 1 ]-%param-anomes.
***      <log>-id         = 1.
***      <log>-response   = 'Nenhum movimento de produção encontrado para o período'.
***      <log>-returncode = '999'.
***      <log>-returnreason = 'Sem dados'.
***    ELSE.
***      lcl_process=>new_out( ).
***      lcl_process=>send_integration( ).
***    ENDIF.

    APPEND INITIAL LINE TO reported-/pyxs/SOV_ITENS_PRODUZ_LOG ASSIGNING FIELD-SYMBOL(<fs>).
    <fs>-%cid = key-%cid.
    <fs>-%msg = new_message_with_text(
                  severity = if_abap_behv_message=>severity-information
                  text     = 'Processamento solicitado'
                ).

    res = VALUE #( FOR log IN /pyxs/bp_SOV_ITENS_PRODUZ_LOG=>lt_log (
        %cid   = key-%cid
        %param = VALUE #( %data = VALUE
            #(
            id           = log-id
            response     = log-response
            returncode   = log-returncode
            returnreason = log-returnreason
            timedate     = log-timedate
             ) )
        ) ).

  ENDMETHOD.

ENDCLASS.


CLASS lsc_SOV_ITENS_PRODUZ_LOG DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize          REDEFINITION.
    METHODS check_before_save REDEFINITION.
    METHODS save              REDEFINITION.
    METHODS cleanup           REDEFINITION.
    METHODS cleanup_finalize  REDEFINITION.

ENDCLASS.

CLASS lsc_SOV_ITENS_PRODUZ_LOG IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
    MODIFY /pyxs/sov_prdlog FROM TABLE
      @/pyxs/bp_SOV_ITENS_PRODUZ_LOG=>lt_log.
    CLEAR /pyxs/bp_SOV_ITENS_PRODUZ_LOG=>lt_log.
  ENDMETHOD.

  METHOD cleanup.
    CLEAR /pyxs/bp_SOV_ITENS_PRODUZ_LOG=>lt_log.
  ENDMETHOD.

  METHOD cleanup_finalize.
    CLEAR /pyxs/bp_SOV_ITENS_PRODUZ_LOG=>lt_log.
  ENDMETHOD.

ENDCLASS.


CLASS lcl_process IMPLEMENTATION.



  METHOD format_decimal.
  " Converte packed para string JSON: 1.00 -> "1", 1.50 -> "1.5"
  rv_str = |{ iv_value NUMBER = RAW }|.

  IF rv_str CS '.'.
    DATA(lv_len) = strlen( rv_str ).
    WHILE lv_len > 1 AND substring( val = rv_str off = lv_len - 1 len = 1 ) = '0'.
      lv_len = lv_len - 1.
    ENDWHILE.
    IF substring( val = rv_str off = lv_len - 1 len = 1 ) = '.'.
      lv_len = lv_len - 1.
    ENDIF.
    rv_str = substring( val = rv_str len = lv_len ).
  ENDIF.

  IF rv_str IS INITIAL.
    rv_str = '0'.
  ENDIF.
ENDMETHOD.

METHOD escape_json.
  rv_str = iv_str.
  REPLACE ALL OCCURRENCES OF `\` IN rv_str WITH `\\`.
  REPLACE ALL OCCURRENCES OF `"` IN rv_str WITH `\"`.
  REPLACE ALL OCCURRENCES OF cl_abap_char_utilities=>cr_lf IN rv_str WITH `\n`.
  REPLACE ALL OCCURRENCES OF cl_abap_char_utilities=>newline IN rv_str WITH `\n`.
  REPLACE ALL OCCURRENCES OF cl_abap_char_utilities=>horizontal_tab IN rv_str WITH `\t`.
ENDMETHOD.

METHOD build_k230.
  rv_json =
    |\{| &&
      |"cod_EMPRESA":{ format_decimal( is_k230-cod_empresa ) },| &&
      |"cod_FILIAL":{ format_decimal( is_k230-cod_filial ) },| &&
      |"cod_GRUPOEMPRESA":"{ escape_json( is_k230-cod_grupoempresa ) }",| &&
      |"dt_PERIODO":"{ escape_json( is_k230-dt_periodo ) }",| &&
      |"cd_PRODUTO_SERVICO":"{ escape_json( is_k230-cd_produto_servico ) }",| &&
      |"dt_INICIO_OP":"{ escape_json( is_k230-dt_inicio_op ) }",| &&
      |"dt_FINAL_OP":"{ escape_json( is_k230-dt_final_op ) }",| &&
      |"nr_DOC_OP":"{ escape_json( is_k230-nr_doc_op ) }",| &&
      |"qtde_ACABADA":{ format_decimal( is_k230-qtde_acabada ) }| &&
    |\}|.
ENDMETHOD.

METHOD build_k235.
  " ATENÇÃO: K235 tem estrutura DIFERENTE do K230.
  " Mapeamento a partir de ty_knwk230 (reusado):
  "   nr_SEQUENCIA       <- iv_seq
  "   qtde               <- qtde_acabada
  "   cd_PROD_SERV_INSUMO<- cd_produto_servico
  "   dt_SAIDA           <- dt_inicio_op
  "   dt_IMPORTACAO      <- dt_periodo
  rv_json =
    |\{| &&
      |"dt_IMPORTACAO":"{ escape_json( is_k235-dt_importacao ) }",| &&
      |"cod_EMPRESA":{ format_decimal( is_k235-cod_empresa ) },| &&
      |"cod_FILIAL":{ format_decimal( is_k235-cod_filial ) },| &&
      |"cod_GRUPOEMPRESA":"{ escape_json( is_k235-cod_grupoempresa ) }",| &&
      |"nr_SEQUENCIA":"{ iv_seq }",| &&
      |"dt_PERIODO":"{ escape_json( is_k235-dt_periodo ) }",| &&
      |"qtde":{ format_decimal( is_k235-qtde ) },| &&
      |"cd_PROD_SERV_INSUMO":"{ escape_json( is_k235-cd_prod_serv_insumo ) }",| &&
      |"nr_DOC_OP":"{ escape_json( is_k235-nr_doc_op ) }",| &&
      |"dt_SAIDA":"{ escape_json( is_k235-dt_saida ) }"| &&
    |\}|.
ENDMETHOD.

METHOD build_0200.
  rv_json =
    |\{| &&
      |"DT_INICIAL":"{ escape_json( is_0200-dt_inicial ) }",| &&
      |"DT_IMPORTACAO":"{ escape_json( is_0200-dt_importacao ) }",| &&
      |"COD_EMPRESA":{ format_decimal( is_0200-cod_empresa ) },| &&
      |"COD_FILIAL":{ format_decimal( is_0200-cod_filial ) },| &&
      |"CD_PRODUTO_SERV":"{ escape_json( is_0200-cd_produto_serv ) }",| &&
      |"DS_PRODUTO_SERV":"{ escape_json( is_0200-ds_produto_serv ) }",| &&
      |"UNIDADE":"{ escape_json( is_0200-unidade ) }",| &&
      |"ALIQ_ICMS":{ format_decimal( is_0200-aliq_icms ) },| &&
      |"PERC_RED_BA_ICMS":{ format_decimal( is_0200-perc_red_ba_icms ) },| &&
      |"CD_NCM":"{ escape_json( is_0200-cd_ncm ) }",| &&
      |"CD_GENERO":"{ escape_json( is_0200-cd_genero ) }",| &&
      |"DM_TIPO_ITEM":"{ escape_json( is_0200-dm_tipo_item ) }",| &&
      |"CD_BARRA":"{ escape_json( is_0200-cd_barra ) }",| &&
      |"DM_ORIGEM_PRODUTO":"{ escape_json( is_0200-dm_origem_produto ) }",| &&
      |"ALIQ_PIS":{ format_decimal( is_0200-aliq_pis ) },| &&
      |"ALIQ_COFINS":{ format_decimal( is_0200-aliq_cofins ) }| &&
    |\}|.
ENDMETHOD.

METHOD build_0190.
  rv_json =
    |\{| &&
      |"DT_INICIAL":"{ escape_json( is_0190-dt_inicial ) }",| &&
      |"DT_IMPORTACAO":"{ escape_json( is_0190-dt_importacao ) }",| &&
      |"COD_EMPRESA":{ format_decimal( is_0190-cod_empresa ) },| &&
      |"COD_FILIAL":{ format_decimal( is_0190-cod_filial ) },| &&
      |"DS_UNIDADE":"{ escape_json( is_0190-ds_unidade ) }",| &&
      |"DS_DESCRICAO":"{ escape_json( is_0190-ds_descricao ) }"| &&
    |\}|.
ENDMETHOD.

METHOD build_integration_json.
  DATA: lv_objetos TYPE string,
        lv_itens   TYPE string,
        lv_seq     TYPE i.

  LOOP AT is_main-objetos INTO DATA(ls_obj).

    " Lista de insumos consumidos
    CLEAR lv_itens.
    lv_seq = 0.
    LOOP AT ls_obj-integr_itens_consum_list INTO DATA(ls_item).
      lv_seq = lv_seq + 1.

      DATA(lv_item_json) =
        |\{| &&
          |"knwK235":{ build_k235( is_k235 = ls_item-knwk235 iv_seq = lv_seq ) },| &&
          |"knw0200ProdutoInsumo":{ build_0200( ls_item-knw0200produtoinsumo ) },| &&
          |"knw0190ProdutoInsumo":{ build_0190( ls_item-knw0190produtoinsumo ) }| &&
        |\}|.

      IF lv_itens IS NOT INITIAL.
        lv_itens = lv_itens && `,`.
      ENDIF.
      lv_itens = lv_itens && lv_item_json.
    ENDLOOP.

    " Objeto raiz (K230 + 0200 + 0190 + lista)
    DATA(lv_obj_json) =
      |\{| &&
        |"knwK230":{ build_k230( ls_obj-knwk230 ) },| &&
        |"knw0200":{ build_0200( ls_obj-knw0200 ) },| &&
        |"knw0190":{ build_0190( ls_obj-knw0190 ) },| &&
        |"integracaoItensConsumidosList":[{ lv_itens }]| &&
      |\}|.

    IF lv_objetos IS NOT INITIAL.
      lv_objetos = lv_objetos && `,`.
    ENDIF.
    lv_objetos = lv_objetos && lv_obj_json.

  ENDLOOP.

  rv_json = |\{"objetos":[{ lv_objetos }]\}|.
ENDMETHOD.
  "--------------------------------------------------------------------------
  " format_date: converte TYPE d para string ISO 8601
  "--------------------------------------------------------------------------
  METHOD format_date.
    IF iv_date IS INITIAL.
      rv_date = ''.
      RETURN.
    ENDIF.
    IF iv_with_time IS INITIAL.
      rv_date = |{ iv_date+0(4) }-{ iv_date+4(2) }-{ iv_date+6(2) }|.
    ELSE.
      rv_date = |{ iv_date+0(4) }-{ iv_date+4(2) }-{ iv_date+6(2) }T00:00:00+03:00|.
    ENDIF.
  ENDMETHOD.

  "--------------------------------------------------------------------------
  " get_period_limits: calcula primeiro e último dia do mês (YYYYMM)
  "--------------------------------------------------------------------------
  METHOD get_period_limits.
    DATA: lv_year       TYPE n LENGTH 4,
          lv_month      TYPE n LENGTH 2,
          lv_next_month TYPE n LENGTH 2,
          lv_next_first TYPE d.

    lv_year  = iv_anomes(4).
    lv_month = iv_anomes+4(2).

    ev_first_day = |{ lv_year }{ lv_month }01|.

    IF lv_month = 12.
      lv_next_first = |{ lv_year + 1 }0101|.
    ELSE.
      lv_next_month = lv_month + 1.
      lv_next_first = |{ lv_year }{ lv_next_month }01|.
    ENDIF.
    ev_last_day = lv_next_first - 1.
  ENDMETHOD.

  "--------------------------------------------------------------------------
  " read_db: lê configuração da filial e movimentos de produção do período
  "--------------------------------------------------------------------------
  METHOD read_db.

    DATA: lv_first_day TYPE d,
          lv_last_day  TYPE d.

    "--- Constantes de tipo de movimento ---
    CONSTANTS:
      gc_mvt_101 TYPE i_materialdocumentitem_2-goodsmovementtype VALUE '101',
      gc_mvt_131 TYPE i_materialdocumentitem_2-goodsmovementtype VALUE '131',
      gc_mvt_261 TYPE i_materialdocumentitem_2-goodsmovementtype VALUE '261'.

    CONSTANTS: gc_mvt_102 TYPE i_materialdocumentitem_2-goodsmovementtype VALUE '102',
         gc_mvt_132 TYPE i_materialdocumentitem_2-goodsmovementtype VALUE '132',
         gc_mvt_262 TYPE i_materialdocumentitem_2-goodsmovementtype VALUE '262'.

    "--- Configuração da filial Sovos ---
    SELECT SINGLE *
      FROM /pyxs/sov_branch
      WHERE company_code = @sel-companycode
        AND branch       = @sel-plant
      INTO @s_branch_sov.

    "--- Calcular limites do período ---
    get_period_limits(
      EXPORTING iv_anomes    = sel-anomes
      IMPORTING ev_first_day = lv_first_day
                ev_last_day  = lv_last_day ).

    "--- Seleção principal: movimentos de produção ---
    SELECT
        item~materialdocumentyear,
        item~materialdocument,
        item~materialdocumentitem,
        item~manufacturingorder,
        item~material,
        item~plant,
        item~goodsmovementtype,
        item~debitcreditcode,
        item~quantityinbaseunit,
        item~materialbaseunit,
        item~postingdate,
        item~documentdate,
        mo~mfgorderplannedstartdate,
        mo~mfgorderscheduledstartdate
      FROM i_materialdocumentitem_2 AS item
      INNER JOIN i_manufacturingorder AS mo
        ON mo~manufacturingorder = item~manufacturingorder
        AND mo~manufacturingorder <> @space
      INNER JOIN i_materialdocumentheader_2 AS hdr
        ON  hdr~materialdocumentyear = item~materialdocumentyear
        AND hdr~materialdocument     = item~materialdocument
      WHERE item~plant         = @sel-companycode
        AND item~postingdate   BETWEEN @lv_first_day AND @lv_last_day
        AND item~goodsmovementtype IN ( @gc_mvt_101,
                                        @gc_mvt_131,
                                        @gc_mvt_261 )
      INTO TABLE @gt_movimentos.

    "--- Enriquecer com dados de produto (join complementar) ---
    IF gt_movimentos IS NOT INITIAL.
      DATA: lt_mat TYPE RANGE OF i_product-product.
      LOOP AT gt_movimentos INTO DATA(ls_mov).
        APPEND VALUE #( sign = 'I' option = 'EQ' low = ls_mov-material ) TO lt_mat.
      ENDLOOP.
      SORT lt_mat BY low.
      DELETE ADJACENT DUPLICATES FROM lt_mat COMPARING low.

      SELECT prod~product,
             prod~producttype,
             prod~baseunit,
             prod~productstandardid,
             "prod~ncminternationalcode,
             pdesc~productdescription
        FROM i_product AS prod
        INNER JOIN i_productdescription AS pdesc
          ON  pdesc~product  = prod~product
          AND pdesc~language = 'P'
        WHERE prod~product IN @lt_mat
        INTO TABLE @gt_products.

        "--- Montar range de documentos originais para join de estorno ---
      DATA lt_range_doc      TYPE RANGE OF i_materialdocumentitem_2-materialdocument.
      DATA lt_range_doc_year TYPE RANGE OF i_materialdocumentitem_2-materialdocumentyear.

      LOOP AT gt_movimentos INTO DATA(ls_mov_range).
        APPEND VALUE #( sign   = 'I'
                        option = 'EQ'
                        low    = ls_mov_range-materialdocument ) TO lt_range_doc.
        APPEND VALUE #( sign   = 'I'
                        option = 'EQ'
                        low    = ls_mov_range-materialdocumentyear ) TO lt_range_doc_year.
      ENDLOOP.

      SORT lt_range_doc      BY low.
      SORT lt_range_doc_year BY low.
      DELETE ADJACENT DUPLICATES FROM lt_range_doc      COMPARING low.
      DELETE ADJACENT DUPLICATES FROM lt_range_doc_year COMPARING low.

      SELECT
          estorno~materialdocumentyear,
          estorno~materialdocument,
          estorno~materialdocumentitem,
          estorno~manufacturingorder,
          estorno~material,
          estorno~plant,
          estorno~goodsmovementtype,
          estorno~debitcreditcode,
          estorno~quantityinbaseunit,
          estorno~materialbaseunit,
          estorno~postingdate,
          estorno~documentdate,
          mo~mfgorderplannedstartdate,
          mo~mfgorderscheduledstartdate,
          estorno~reversedmaterialdocumentyear,
          estorno~reversedmaterialdocument,
          estorno~reversedmaterialdocumentitem
        FROM i_materialdocumentitem_2 AS estorno
        INNER JOIN i_manufacturingorder AS mo
          ON mo~manufacturingorder = estorno~manufacturingorder
          AND mo~manufacturingorder <> @space
        WHERE estorno~plant                          = @sel-companycode
          AND estorno~goodsmovementtype             IN ( @gc_mvt_102,
                                                         @gc_mvt_132,
                                                         @gc_mvt_262 )
          AND estorno~reversedmaterialdocument      IN @lt_range_doc
          AND estorno~reversedmaterialdocumentyear  IN @lt_range_doc_year
        INTO TABLE @gt_estorno.

    ENDIF.

    "--- Company code ---
    SELECT SINGLE companycode, companycodename
      FROM i_companycode
      WHERE companycode = @sel-companycode
      INTO @gs_company.

  ENDMETHOD.

  "--------------------------------------------------------------------------
  " new_out: monta a estrutura de saída no formato knwK230 + knw0200 + knw0190
  "--------------------------------------------------------------------------
  METHOD new_out.

    DATA: ls_out    TYPE ty_main,
          ls_objeto TYPE ty_objetos,
          lv_now    TYPE string,
          lv_dt_ini TYPE string.

    DATA(lv_date) = cl_abap_context_info=>get_system_date( ).
    DATA(lv_time) = cl_abap_context_info=>get_system_time( ).

    lv_now = |{ lv_date+0(4) }-{ lv_date+4(2) }-{ lv_date+6(2) }|
           & |T{ lv_time+0(2) }:{ lv_time+2(2) }:{ lv_time+4(2) }.000Z|.

    "--- Calcular último dia do período para dt_periodo ---
    DATA: lv_first_day TYPE d,
          lv_last_day  TYPE d.
    get_period_limits(
      EXPORTING iv_anomes    = sel-anomes
      IMPORTING ev_first_day = lv_first_day
                ev_last_day  = lv_last_day ).
    lv_dt_ini = |{ lv_last_day DATE = ISO }T00:00:00.000Z|.

    CLEAR: t_out.

***    IF gt_movimentos IS INITIAL.
***    "mock data here, as the final result, lt_out should be an object with these values and structure:
***
***      CLEAR: ls_out, ls_objeto.
***
***      "----------------------------------------------------------
***      " MOCK K230
***      "----------------------------------------------------------
***      ls_objeto-knwk230-cod_empresa        = 1.
***      ls_objeto-knwk230-cod_filial         = 1.
***      ls_objeto-knwk230-cod_grupoempresa   = '<GRUPO_EMPRESA>'.
***      ls_objeto-knwk230-dt_periodo         = '2025-03-31T03:00:03'.
***      ls_objeto-knwk230-cd_produto_servico = 'PRODUTO_001'.
***      ls_objeto-knwk230-dt_inicio_op       = '2025-03-29T03:00:03'.
***      ls_objeto-knwk230-dt_final_op        = '2025-03-29T03:00:04'.
***      ls_objeto-knwk230-nr_doc_op          = 'DOC_001'.
***      ls_objeto-knwk230-qtde_acabada       = 8.
***
***      "----------------------------------------------------------
***      " MOCK 0200 PRODUTO
***      "----------------------------------------------------------
***      ls_objeto-knw0200-dt_inicial        = '2025-03-31T00:00:02'.
***      ls_objeto-knw0200-dt_importacao     = '2025-03-31T00:00:02'.
***      ls_objeto-knw0200-cod_empresa       = 1.
***      ls_objeto-knw0200-cod_filial        = 1.
***      ls_objeto-knw0200-cd_produto_serv   = 'PRODUTO_001'.
***      ls_objeto-knw0200-ds_produto_serv   = '<DESCRICAO_PRODUTO>'.
***      ls_objeto-knw0200-unidade           = 'UN'.
***      ls_objeto-knw0200-aliq_icms         = 0.
***      ls_objeto-knw0200-perc_red_ba_icms  = 0.
***      ls_objeto-knw0200-cd_ncm            = '00000000'.
***      ls_objeto-knw0200-cd_genero         = '00'.
***      ls_objeto-knw0200-dm_tipo_item      = '00'.
***      ls_objeto-knw0200-cd_barra          = 'SEM GTIN'.
***      ls_objeto-knw0200-dm_origem_produto = '0'.
***      ls_objeto-knw0200-aliq_pis          = 0.
***      ls_objeto-knw0200-aliq_cofins       = 0.
***
***      "----------------------------------------------------------
***      " MOCK 0190 PRODUTO
***      "----------------------------------------------------------
***      ls_objeto-knw0190-dt_inicial    = '2025-03-31T00:00:02'.
***      ls_objeto-knw0190-dt_importacao = '2025-03-31T00:00:02'.
***      ls_objeto-knw0190-cod_empresa   = 1.
***      ls_objeto-knw0190-cod_filial    = 1.
***      ls_objeto-knw0190-ds_unidade    = 'UN'.
***      ls_objeto-knw0190-ds_descricao  = '<DESCRICAO_UNIDADE>'.
***
***      "----------------------------------------------------------
***      " MOCK ITEM CONSUMIDO
***      "----------------------------------------------------------
***      DATA(ls_item_cons_mock) = VALUE ty_item_consumido(
***
***        knwk235 = VALUE #(
***          cod_empresa        = 1
***          cod_filial         = 1
***          cod_grupoempresa   = '<GRUPO_EMPRESA>'
***          dt_periodo         = '2025-03-31T00:00:02'
***          cd_produto_servico = 'INSUMO_001'
***          dt_inicio_op       = '2025-03-31T00:00:01'
***          dt_final_op        = '2025-03-31T00:00:01'
***          nr_doc_op          = 'DOC_001'
***          qtde_acabada       = 0
***        )
***
***        knw0200produtoinsumo = VALUE #(
***          dt_inicial        = '2025-03-31T00:00:02'
***          dt_importacao     = '2025-03-31T00:00:02'
***          cod_empresa       = 1
***          cod_filial        = 1
***          cd_produto_serv   = 'INSUMO_001'
***          ds_produto_serv   = '<DESCRICAO_INSUMO>'
***          unidade           = 'UN'
***          aliq_icms         = 0
***          perc_red_ba_icms  = 0
***          cd_ncm            = '00000000'
***          cd_genero         = '00'
***          dm_tipo_item      = '00'
***          cd_barra          = 'SEM GTIN'
***          dm_origem_produto = '0'
***          aliq_pis          = 0
***          aliq_cofins       = 0
***        )
***
***        knw0190produtoinsumo = VALUE #(
***          dt_inicial    = '2025-03-31T00:00:02'
***          dt_importacao = '2025-03-31T00:00:02'
***          cod_empresa   = 1
***          cod_filial    = 1
***          ds_unidade    = 'UN'
***          ds_descricao  = '<DESCRICAO_UNIDADE>'
***        )
***      ).
***
***      APPEND ls_item_cons_mock TO ls_objeto-integr_itens_consum_list.
***
***      APPEND ls_objeto TO ls_out-objetos.
***      APPEND ls_out TO t_out.
***    ENDIF.

    " Agrupar por (OP, material produzido) - cada produção gera um K230,
    " e os consumos da mesma OP entram como K235.

    " 1. Separar movimentos de produção (entrada produto acabado)
    DATA(lt_producao) = VALUE ty_t_movimentos(
      FOR mov IN gt_movimentos
      WHERE ( goodsmovementtype = '101' OR
              goodsmovementtype = '131' )
      ( mov ) ).

    " 2. Separar movimentos de consumo
    DATA(lt_consumo) = VALUE ty_t_movimentos(
      FOR mov IN gt_movimentos
      WHERE ( goodsmovementtype = '261' )
      ( mov ) ).


    LOOP AT lt_producao INTO DATA(ls_mov).

      CLEAR: ls_out, ls_objeto.

      "--- Buscar dados do produto ---
      READ TABLE gt_products INTO DATA(ls_prod)
        WITH KEY product = ls_mov-material.


      "--- knwK230 – movimento de produção ---
      ls_objeto-knwk230-cod_empresa        = CONV i( s_branch_sov-sov_company ).
      ls_objeto-knwk230-cod_filial         = CONV i( s_branch_sov-sov_branch ).
      ls_objeto-knwk230-cod_grupoempresa   = "<GRUPO_EMPRESA>".  " ajustar se houver campo grupo
      ls_objeto-knwk230-dt_periodo         = lv_dt_ini.
      ls_objeto-knwk230-cd_produto_servico = ls_mov-material.
      ls_objeto-knwk230-dt_inicio_op       = format_date( iv_date = ls_mov-postingdate ).
      ls_objeto-knwk230-dt_final_op        = format_date( iv_date = ls_mov-postingdate ). "puxa das tab join ordem de produção
      ls_objeto-knwk230-nr_doc_op          = ls_mov-manufacturingorder.
      ls_objeto-knwk230-qtde_acabada       = ls_mov-quantityinbaseunit.

      "Quantidade: positiva para recebimento (101/131), negativa para consumo (261)
***      IF ls_mov-goodsmovementtype = '261'.
***        ls_objeto-knwk230-qtde_acabada = ls_mov-quantityinbaseunit * -1.
***      ELSE.
***        ls_objeto-knwk230-qtde_acabada = ls_mov-quantityinbaseunit.
***      ENDIF.

      "--- Verificar e subtrair estorno correspondente (102/132) ---
      "estorno pela MIGO (estornando o material original)
      READ TABLE gt_estorno INTO DATA(ls_estorno)
        WITH KEY reversedmaterialdocument     = ls_mov-materialdocument
                 reversedmaterialdocumentyear = ls_mov-materialdocumentyear
                 materialdocumentitem         = ls_mov-materialdocumentitem.
      IF sy-subrc = 0.
        "Estorno sempre subtrai: para 101/131 o estorno reduz o saldo positivo
        ls_objeto-knwk230-qtde_acabada = ls_objeto-knwk230-qtde_acabada - ls_estorno-quantityinbaseunit.
      ENDIF.
      "estorno avulso? puxa pela ordem de produção + cod do material

      "--- knw0200 – cadastro do produto ---
      ls_objeto-knw0200-dt_inicial        = '1900-01-01T00:00:00+03:00'.
      ls_objeto-knw0200-dt_importacao     = '1900-01-01T00:00:00+03:00'.
      ls_objeto-knw0200-cod_empresa       = CONV i( s_branch_sov-sov_company ).
      ls_objeto-knw0200-cod_filial        = CONV i( s_branch_sov-sov_branch ).
      ls_objeto-knw0200-cd_produto_serv   = ls_mov-material.
      ls_objeto-knw0200-ds_produto_serv   = ls_prod-productdescription.
      ls_objeto-knw0200-unidade           = ls_mov-materialbaseunit.
      ls_objeto-knw0200-aliq_icms         = 0.
      ls_objeto-knw0200-perc_red_ba_icms  = 0.
      ls_objeto-knw0200-cd_ncm            = '00000000'.
***      ls_objeto-knw0200-cd_ncm            = COND #( WHEN ls_prod-ncminternationalcode IS INITIAL
***                                                    THEN '00000000'
***                                                    ELSE ls_prod-ncminternationalcode ).
      ls_objeto-knw0200-cd_genero         = '00'.
      ls_objeto-knw0200-cd_barra          = 'SEM GTIN'.
      ls_objeto-knw0200-dm_origem_produto = '0'.
      ls_objeto-knw0200-aliq_pis          = 0.
      ls_objeto-knw0200-aliq_cofins       = 0.

      CASE ls_prod-producttype.
        WHEN 'HAWA'.
          ls_objeto-knw0200-dm_tipo_item = '00'.
        WHEN 'ROH'.
          ls_objeto-knw0200-dm_tipo_item = '01'.
        WHEN 'VERP' OR 'LEIH'.
          ls_objeto-knw0200-dm_tipo_item = '02'.
        WHEN 'PROC' OR 'HALB'.
          ls_objeto-knw0200-dm_tipo_item = '03'.
        WHEN 'FERT'.
          ls_objeto-knw0200-dm_tipo_item = '04'.
        WHEN 'HIBE'.
          ls_objeto-knw0200-dm_tipo_item = '06'.
        WHEN 'NLAG'.
          ls_objeto-knw0200-dm_tipo_item = '07'.
        WHEN 'DIEN' OR 'LEIS' OR 'SERV'.
          ls_objeto-knw0200-dm_tipo_item = '09'.
        WHEN OTHERS.
          ls_objeto-knw0200-dm_tipo_item = '99'.
      ENDCASE.

      "--- knw0190 – unidade de medida ---
      ls_objeto-knw0190-cod_empresa   = CONV i( s_branch_sov-sov_company ).
      ls_objeto-knw0190-cod_filial    = CONV i( s_branch_sov-sov_branch ).
      ls_objeto-knw0190-dt_inicial    = '1900-01-01T00:00:00+03:00'.
      ls_objeto-knw0190-dt_importacao = '1900-01-01T00:00:00+03:00'.
      ls_objeto-knw0190-ds_unidade    = ls_mov-materialbaseunit.
      ls_objeto-knw0190-ds_descricao  = ls_mov-materialbaseunit.   " descrição da UOM – enriquecer se necessário

      "--- K235: insumos consumidos da MESMA OP --------------------
      DATA(lv_seq) = 0.
      DATA lt_item_cons TYPE tt_itens_consumidos.

      LOOP AT lt_consumo INTO DATA(ls_cons)
           WHERE manufacturingorder = ls_mov-manufacturingorder.

        "--- Buscar dados do insumo
        READ TABLE gt_products INTO DATA(ls_prod_cons)
          WITH KEY product = ls_cons-material.

        lv_seq = lv_seq + 1.
        DATA ls_item_cons TYPE ty_item_consumido.
        "----------------------------------------------------------
        " K235 - consumo do insumo
        "----------------------------------------------------------ls_item_cons-knwK235-dt_importacao       = lv_dt_ini.
        ls_item_cons-knwK235-cod_empresa         = CONV i( s_branch_sov-sov_company ).
        ls_item_cons-knwK235-cod_filial          = CONV i( s_branch_sov-sov_branch ).
        ls_item_cons-knwK235-cod_grupoempresa    = '<GRUPO_EMPRESA>'.
        ls_item_cons-knwK235-dt_periodo          = lv_dt_ini.
        ls_item_cons-knwK235-qtde                = ls_cons-quantityinbaseunit.
        ls_item_cons-knwK235-cd_prod_serv_insumo = ls_cons-material.
        ls_item_cons-knwK235-nr_doc_op           = ls_cons-manufacturingorder.
        ls_item_cons-knwK235-dt_saida            = format_date( iv_date = ls_cons-postingdate ).

        "--- Verificar e subtrair estorno correspondente (262) ---
        READ TABLE gt_estorno INTO DATA(ls_estorno_cons)
          WITH KEY reversedmaterialdocument     = ls_cons-materialdocument
                   reversedmaterialdocumentyear = ls_cons-materialdocumentyear
                   materialdocumentitem         = ls_cons-materialdocumentitem.
        IF sy-subrc = 0.
          "Estorno do consumo devolve o material: soma de volta
          ls_item_cons-knwK235-qtde = ls_item_cons-knwK235-qtde - ls_estorno_cons-quantityinbaseunit.
        ENDIF.
        "----------------------------------------------------------
        " 0200 do insumo
        "----------------------------------------------------------
        ls_item_cons-knw0200produtoinsumo-dt_inicial        = '1900-01-01T00:00:00+03:00'.
        ls_item_cons-knw0200produtoinsumo-dt_importacao     = '1900-01-01T00:00:00+03:00'.
        ls_item_cons-knw0200produtoinsumo-cod_empresa       = CONV #( s_branch_sov-sov_company ).
        ls_item_cons-knw0200produtoinsumo-cod_filial        = CONV #( s_branch_sov-sov_branch ).
        ls_item_cons-knw0200produtoinsumo-cd_produto_serv   = ls_cons-material.
        ls_item_cons-knw0200produtoinsumo-ds_produto_serv   = ls_prod_cons-productdescription.
        ls_item_cons-knw0200produtoinsumo-unidade           = ls_cons-materialbaseunit.
        ls_item_cons-knw0200produtoinsumo-aliq_icms         = 0.
        ls_item_cons-knw0200produtoinsumo-perc_red_ba_icms  = 0.
        ls_item_cons-knw0200produtoinsumo-cd_ncm            = '00000000'.
        ls_item_cons-knw0200produtoinsumo-cd_genero         = '00'.
        ls_item_cons-knw0200produtoinsumo-cd_barra          = 'SEM GTIN'.
        ls_item_cons-knw0200produtoinsumo-dm_origem_produto = '0'.
        ls_item_cons-knw0200produtoinsumo-aliq_pis          = 0.
        ls_item_cons-knw0200produtoinsumo-aliq_cofins       = 0.

        CASE ls_prod_cons-producttype.
          WHEN 'HAWA'.
            ls_item_cons-knw0200produtoinsumo-dm_tipo_item = '00'.
          WHEN 'ROH'.
            ls_item_cons-knw0200produtoinsumo-dm_tipo_item = '01'.
          WHEN 'VERP' OR 'LEIH'.
            ls_item_cons-knw0200produtoinsumo-dm_tipo_item = '02'.
          WHEN 'PROC' OR 'HALB'.
            ls_item_cons-knw0200produtoinsumo-dm_tipo_item = '03'.
          WHEN 'FERT'.
            ls_item_cons-knw0200produtoinsumo-dm_tipo_item = '04'.
          WHEN 'HIBE'.
            ls_item_cons-knw0200produtoinsumo-dm_tipo_item = '06'.
          WHEN 'NLAG'.
            ls_item_cons-knw0200produtoinsumo-dm_tipo_item = '07'.
          WHEN 'DIEN' OR 'LEIS' OR 'SERV'.
            ls_item_cons-knw0200produtoinsumo-dm_tipo_item = '09'.
          WHEN OTHERS.
            ls_item_cons-knw0200produtoinsumo-dm_tipo_item = '99'.
        ENDCASE.

        "----------------------------------------------------------
        " 0190 do insumo
        "----------------------------------------------------------
        ls_item_cons-knw0190produtoinsumo-cod_empresa   = CONV #( s_branch_sov-sov_company ).
        ls_item_cons-knw0190produtoinsumo-cod_filial    = CONV #( s_branch_sov-sov_branch ).
        ls_item_cons-knw0190produtoinsumo-dt_inicial    = '1900-01-01T00:00:00+03:00'.
        ls_item_cons-knw0190produtoinsumo-dt_importacao = '1900-01-01T00:00:00+03:00'.
        ls_item_cons-knw0190produtoinsumo-ds_unidade    = ls_cons-materialbaseunit.
        ls_item_cons-knw0190produtoinsumo-ds_descricao  = ls_cons-materialbaseunit.

        APPEND ls_item_cons TO ls_objeto-integr_itens_consum_list.

      ENDLOOP.

      APPEND ls_objeto TO ls_out-objetos.
      APPEND ls_out TO t_out.

    ENDLOOP.

  ENDMETHOD.

  "--------------------------------------------------------------------------
  " send_integration: serializa e envia cada objeto para a API Sovos
  "--------------------------------------------------------------------------
  METHOD send_integration.

    DATA: lo_ret     TYPE REF TO data,
          lv_sucesso TYPE abap_boolean.

    LOOP AT t_out INTO DATA(ls_doc).

      DATA(json_out) = build_integration_json( ls_doc ).

      json_out = /pyxs/sov_json_conversion=>convert_sovos( json_out ).

      DATA: lr_cscn TYPE if_com_scenario_factory=>ty_query-cscn_id_range.
      lr_cscn = VALUE #( ( sign = 'I' option = 'EQ' low = '/PYXS/SOVOS' ) ).

      DATA(lo_factory) = cl_com_arrangement_factory=>create_instance( ).
      lo_factory->query_ca(
        EXPORTING
          is_query           = VALUE #( cscn_id_range = lr_cscn )
        IMPORTING
          et_com_arrangement = DATA(lt_ca) ).

      IF lt_ca IS INITIAL.
        APPEND INITIAL LINE TO /pyxs/bp_SOV_ITENS_PRODUZ_LOG=>lt_log ASSIGNING FIELD-SYMBOL(<log>).
        GET TIME STAMP FIELD DATA(time).
        <log>-timedate     = time.
        <log>-anomes       = sel-anomes.
        <log>-response     = 'Cenário de comunicação não encontrado'.
        <log>-returncode   = '999'.
        <log>-returnreason = 'Erro de configuração'.
        EXIT.
      ENDIF.

      READ TABLE lt_ca INTO DATA(lo_ca) INDEX 1.

      TRY.
          DATA(lo_dest) = cl_http_destination_provider=>create_by_comm_arrangement(
              comm_scenario  = '/PYXS/SOVOS'
              service_id     = '/PYXS/TCO_SOVOS_REST'
              comm_system_id = lo_ca->get_comm_system_id( ) ).

          DATA(lo_http_client) = cl_web_http_client_manager=>create_by_http_destination( lo_dest ).
          DATA(lo_request)     = lo_http_client->get_http_request( ).

          lo_request->set_text( i_text = json_out ).
          lo_request->set_uri_path( i_uri_path = 'api/knw/v2/blocoK/itensProduzidos' ).

          DATA(lo_response) = lo_http_client->execute( if_web_http_client=>post ).
          DATA(lv_ret)      = lo_response->get_status( ).
          CLEAR lo_ret.

          IF lv_ret-code = '200'.
            DATA(lv_msg) = lo_response->get_text( ).
            IF lv_msg IS INITIAL.
              gv_proc = 'Successfully processed'(002).
            ELSE.
              gv_proc = lv_msg.
              /ui2/cl_json=>deserialize(
                EXPORTING json = gv_proc
                CHANGING  data = lo_ret ).
              lv_sucesso = lo_ret->('SUCESSO')->*.
              IF lv_sucesso = abap_true.
                gv_proc = 'Successfully processed'(002).
              ELSE.
                lv_ret-code = 400.
              ENDIF.
            ENDIF.
          ELSE.
            gv_proc = lo_response->get_text( ).
          ENDIF.

        CATCH cx_web_message_error.
        CATCH cx_http_dest_provider_error.
        CATCH cx_web_http_client_error.
      ENDTRY.

      GET TIME STAMP FIELD time.

      IF lo_ret IS INITIAL.
        APPEND INITIAL LINE TO /pyxs/bp_SOV_ITENS_PRODUZ_LOG=>lt_log ASSIGNING <log>.
        <log>-timedate     = time.
        <log>-anomes       = sel-anomes.
        <log>-response     = |Erro no serviço: { gv_proc }|.
        <log>-returncode   = lv_ret-code.
        <log>-returnreason = lv_ret-reason.
      ELSE.
        LOOP AT lo_ret->('MENSAGENS')->* ASSIGNING FIELD-SYMBOL(<lv_msg>).
          APPEND INITIAL LINE TO /pyxs/bp_SOV_ITENS_PRODUZ_LOG=>lt_log ASSIGNING <log>.
          <log>-id           = sy-tabix.
          <log>-timedate     = time.
          <log>-anomes       = sel-anomes.
          <log>-response     = <lv_msg>->*.
          <log>-returncode   = lv_ret-code.
          <log>-returnreason = lv_ret-reason.
        ENDLOOP.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  "--------------------------------------------------------------------------
  " main: ponto de entrada para teste direto (sem RAP)
  "--------------------------------------------------------------------------
  METHOD main.
    lcl_process=>data = cl_abap_context_info=>get_system_date( ).
    lcl_process=>hora = cl_abap_context_info=>get_system_time( ).
    lcl_process=>read_db( ).
    lcl_process=>new_out( ).
    lcl_process=>send_integration( ).
  ENDMETHOD.

ENDCLASS.