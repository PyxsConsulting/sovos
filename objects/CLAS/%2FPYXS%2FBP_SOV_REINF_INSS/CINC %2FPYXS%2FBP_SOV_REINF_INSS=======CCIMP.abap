CLASS lhc_SOV_REINF_INSS DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR /pyxs/sov_reinf_inss RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE /pyxs/sov_reinf_inss.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE /pyxs/sov_reinf_inss.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE /pyxs/sov_reinf_inss.

    METHODS read FOR READ
      IMPORTING keys FOR READ /pyxs/sov_reinf_inss RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK /pyxs/sov_reinf_inss.

    METHODS sendintegration FOR MODIFY
      IMPORTING keys FOR ACTION /pyxs/sov_reinf_inss~sendintegration RESULT res.

ENDCLASS.

CLASS lcl_process DEFINITION FRIENDS lhc_SOV_REINF_INSS.

  PUBLIC SECTION.
    CLASS-METHODS: main.

    TYPES:
      BEGIN OF ty_sel,
        companycode TYPE i_companycode-companycode,
        plant       TYPE i_plant-plant,
        anomes      TYPE string,
        document    TYPE i_br_nfdocument-br_notafiscal,
      END OF ty_sel,

      BEGIN OF ty_tax_item,
        companycode                    TYPE i_journalentry-companycode,
        accountingdocument             TYPE i_journalentry-accountingdocument,
        fiscalyear                     TYPE i_journalentry-fiscalyear,
        accountingdocumentitem         TYPE i_withholdingtaxitem-accountingdocumentitem,
        withholdingtaxtype             TYPE i_withholdingtaxitem-withholdingtaxtype,
        withholdingtaxcode             TYPE i_withholdingtaxitem-withholdingtaxcode,
        withholdingtaxbaseamtincocode  TYPE i_withholdingtaxitem-whldgtaxbaseamtincocodecrcy,
        withholdingtaxamtintransaccrcy TYPE i_withholdingtaxitem-whldgtaxamtintransaccrcy,
        clearingdate                   TYPE i_withholdingtaxitem-clearingdate,
        clearingaccountingdocument     TYPE i_withholdingtaxitem-clearingaccountingdocument,
        withholdingtaxpercent          TYPE i_withholdingtaxitem-withholdingtaxpercent,
        referencedocumenttype          TYPE i_journalentry-referencedocumenttype,
        originalreferencedocument      TYPE i_br_nfitem-br_nfsourcedocumentnumber,
        netduedate                     TYPE i_journalentryitem-netduedate,
      END OF ty_tax_item,

      BEGIN OF ty_wit_data,
        companycode                   TYPE i_withholdingtaxitem-companycode,
        accountingdocument            TYPE i_withholdingtaxitem-accountingdocument,
        fiscalyear                    TYPE i_withholdingtaxitem-fiscalyear,
        accountingdocumentitem        TYPE i_withholdingtaxitem-accountingdocumentitem,
        withholdingtaxtype            TYPE i_withholdingtaxitem-withholdingtaxtype,
        withholdingtaxcode            TYPE i_withholdingtaxitem-withholdingtaxcode,
        whldgtaxbaseamtincocodecrcy   TYPE i_withholdingtaxitem-whldgtaxbaseamtincocodecrcy,
        whldgtaxamtintransaccrcy      TYPE i_withholdingtaxitem-whldgtaxamtintransaccrcy,
        clearingdate                  TYPE i_withholdingtaxitem-clearingdate,
        clearingaccountingdocument    TYPE i_withholdingtaxitem-clearingaccountingdocument,
        withholdingtaxpercent         TYPE i_withholdingtaxitem-withholdingtaxpercent,
        referencedocumenttype         TYPE i_journalentry-referencedocumenttype,
        originalreferencedocument     TYPE i_br_nfitem-br_nfsourcedocumentnumber,
        netduedate                    TYPE i_journalentryitem-netduedate,
      END OF ty_wit_data,

      ty_t_wit_data TYPE STANDARD TABLE OF ty_wit_data WITH NON-UNIQUE DEFAULT KEY,

      BEGIN OF ty_nf_data,
        br_notafiscal                TYPE i_br_nfitem-br_notafiscal,
        br_notafiscalitem            TYPE i_br_nfitem-br_notafiscalitem,
        br_nfsourcedocumenttype      TYPE i_br_nfitem-br_nfsourcedocumenttype,
        br_nfsourcedocumentnumber    TYPE i_br_nfitem-br_nfsourcedocumentnumber,
        br_nfsourcedocumentitem      TYPE i_br_nfitem-br_nfsourcedocumentitem,
        br_nftype                    TYPE i_br_nfdocument-br_nftype,
        br_nfdirection               TYPE i_br_nfdocument-br_nfdirection,
        br_nfpostingdate               TYPE i_br_nfdocument-br_nfpostingdate,
        br_nfmodel                   TYPE i_br_nfdocument-br_nfmodel,
        br_nfseries                  TYPE i_br_nfdocument-br_nfseries,
        br_nfsubseries               TYPE i_br_nfdocument-br_nfsubseries,
        br_nfnumber                  TYPE i_br_nfdocument-br_nfnumber,
        businessplace                TYPE i_br_nfdocument-businessplace,
        br_nfpartnerfunction         TYPE i_br_nfdocument-br_nfpartnerfunction,
        br_nfpartner                 TYPE i_br_nfdocument-br_nfpartner,
        br_nfpartnertype             TYPE i_br_nfdocument-br_nfpartnertype,
        br_nfiscanceled              TYPE i_br_nfdocument-br_nfiscanceled,
        br_nfsnumber                 TYPE i_br_nfdocument-br_nfsnumber,
        br_isnfe                     TYPE i_br_nfdocument-br_isnfe,
        br_nfenumber                 TYPE i_br_nfdocument-br_nfenumber,
        br_nfhasserviceitem          TYPE i_br_nfdocument-br_nfhasserviceitem,
        br_nfissuedby                TYPE i_br_nfdocument-br_nfissuedby,
        br_nfsituationcode           TYPE i_br_nfdocument-br_nfsituationcode,
        br_taxtype                   TYPE i_br_nftax-br_taxtype,
        br_nfitembaseamount          TYPE i_br_nftax-br_nfitembaseamount,
        br_nfitemtaxrate             TYPE i_br_nftax-br_nfitemtaxrate,
        br_nfitemtaxamount           TYPE i_br_nftax-br_nfitemtaxamount,
        br_nfitemwhldgcollectioncode TYPE i_br_nftax-br_nfitemwhldgcollectioncode,
        taxgroup                     TYPE i_br_nftax-taxgroup,
        br_businessplacecnpj         TYPE i_br_nfdocument-br_businessplacecnpj,
        br_nfpartnercnpj             TYPE i_br_nfdocument-br_nfpartnercnpj,
        br_nfpartnername1            TYPE i_br_nfdocument-br_nfpartnername1,
        br_lc116servicecode          TYPE i_br_nfitem-br_lc116servicecode,
        br_nftotalamount             TYPE i_br_nfdocument-br_nftotalamount,
        BR_EFDREINFServiceCode       TYPE i_br_nfitem-BR_EFDREINFServiceCode,
        material                     TYPE i_br_nfitem-Material,
      END OF ty_nf_data,

      ty_t_nf_data TYPE STANDARD TABLE OF ty_nf_data WITH NON-UNIQUE DEFAULT KEY,

      "*----------------------------------------------------------------------
      "* KNW_R2010 – header (flat structure, all strings)
      "*----------------------------------------------------------------------
      BEGIN OF ty_knw_r2010,
        cd_empresa           TYPE string,
        cd_filial            TYPE string,
        id_referencia        TYPE string,
        dm_retificacao       TYPE string,
        dt_apuracao          TYPE string,
        dm_inscricao_obra    TYPE string,
        nr_inscricao_obra    TYPE string,
        dm_obra              TYPE string,
        nr_cnpj_prestador    TYPE string,
        vl_total_bruto       TYPE string,
        vl_total_base        TYPE string,
        vl_total_retencao    TYPE string,
        vl_tot_retencao_adic TYPE string,
        vl_tot_ret_nao_efet  TYPE string,
        vl_tot_ret_nefe_adic TYPE string,
        dm_cprb              TYPE string,
      END OF ty_knw_r2010,

      "*----------------------------------------------------------------------
      "* KNW_R2010_NOTA – one per NF (flat structure, all strings)
      "*----------------------------------------------------------------------
      BEGIN OF ty_knw_r2010_nota,
        cd_empresa    TYPE string,
        cd_filial     TYPE string,
        id_referencia TYPE string,
        nr_item_nota  TYPE string,
        nr_serie      TYPE string,
        nr_documento  TYPE string,
        dt_emissao    TYPE string,
        vl_bruto      TYPE string,
        ds_observacao TYPE string,
      END OF ty_knw_r2010_nota,

      "*----------------------------------------------------------------------
      "* KNW_R2010_SERVICO – one per service line (flat structure, all strings)
      "*----------------------------------------------------------------------
      BEGIN OF ty_knw_r2010_servico,
        cd_empresa       TYPE string,
        cd_filial        TYPE string,
        id_referencia    TYPE string,
        nr_item_nota     TYPE string,
        nr_item_servico  TYPE string,
        cd_tipo_servico  TYPE string,
        vl_base_retencao TYPE string,
        vl_retencao      TYPE string,
      END OF ty_knw_r2010_servico,

      "*----------------------------------------------------------------------
      "* Root payload: one flat object per POST call
      "* Each instance = 1 header + 1 nota + 1 servico
      "*----------------------------------------------------------------------
      BEGIN OF ty_root_r2010,
        knwReinfR2010            TYPE ty_knw_r2010,
        knwReinfR2010NotaList    TYPE TABLE OF ty_knw_r2010_nota WITH DEFAULT KEY,
        knwReinfR2010ServicoList TYPE TABLE OF ty_knw_r2010_servico WITH DEFAULT KEY,
      END OF ty_root_r2010,

      ty_t_root_r2010 TYPE STANDARD TABLE OF ty_root_r2010 WITH NON-UNIQUE DEFAULT KEY,
      tt_r2010_objects TYPE STANDARD TABLE OF ty_root_r2010 WITH DEFAULT KEY,

      BEGIN OF ty_companycode,
        companycode     TYPE i_companycode-companycode,
        companycodename TYPE i_companycode-companycodename,
      END OF ty_companycode.

    CLASS-DATA:
      sel           TYPE ty_sel,
      data_sys      TYPE d,
      hora_sys      TYPE t,
      gv_proc       TYPE string,
      gs_company    TYPE ty_companycode,
      gs_branch_sov TYPE /pyxs/sov_branch,
      gt_data       TYPE ty_t_wit_data,
      gt_objects    TYPE tt_r2010_objects,
      gt_nfs        TYPE ty_t_nf_data,
      mt_nature     TYPE TABLE OF /pyxs/sov_natren,
      mt_cdreinf     TYPE TABLE OF /pyxs/sov_cdrei2,
      mt_irf_types  TYPE TABLE OF /pyxs/sov_taxtype_irf,
      gt_root       TYPE ty_t_root_r2010.        " replaces ls_root / lt_root

  PRIVATE SECTION.
    CLASS-METHODS:
      read_db,
      build_objects,
      send_integration,

      format_amount
        IMPORTING iv_value        TYPE any
        RETURNING VALUE(rv_value) TYPE string,

      escape_json
        IMPORTING iv_str         TYPE string
        RETURNING VALUE(rv_str)  TYPE string,

      format_date_yyyymmdd
        IMPORTING iv_date        TYPE d
        RETURNING VALUE(rv_date) TYPE string,

      get_period_limits
        IMPORTING iv_anomes      TYPE string
        EXPORTING ev_first_day   TYPE d
                  ev_last_day    TYPE d,

      build_r2010_json
        IMPORTING is_r2010       TYPE ty_knw_r2010
        RETURNING VALUE(rv_json) TYPE string,

      build_nota_json
        IMPORTING is_nota        TYPE ty_knw_r2010_nota
        RETURNING VALUE(rv_json) TYPE string,

      build_servico_json
        IMPORTING is_serv        TYPE ty_knw_r2010_servico
        RETURNING VALUE(rv_json) TYPE string,

      build_payload_json
        IMPORTING is_obj         TYPE ty_root_r2010
        RETURNING VALUE(rv_json) TYPE string.

ENDCLASS.

"=============================================================================
CLASS lhc_sov_reinf_inss IMPLEMENTATION.

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

    lcl_process=>data_sys = cl_abap_context_info=>get_system_date( ).
    lcl_process=>hora_sys = cl_abap_context_info=>get_system_time( ).

    lcl_process=>sel-companycode = key-%param-CompanyCode.
    lcl_process=>sel-plant       = key-%param-BusinessPlace.
    lcl_process=>sel-anomes      = key-%param-AnoMes.
    lcl_process=>sel-document    = key-%param-BrNotafiscal.

    IF lcl_process=>sel-companycode IS INITIAL OR lcl_process=>sel-plant IS INITIAL.
      APPEND VALUE #( %action-sendintegration = if_abap_behv=>mk-on ) TO failed-/pyxs/sov_reinf_inss.
      APPEND VALUE #(
        %msg = new_message_with_text(
          severity = if_abap_behv_message=>severity-error
          text     = 'Empresa e Local de Negócio são obrigatórios' )
        %action-sendintegration = if_abap_behv=>mk-on
      ) TO reported-/pyxs/sov_reinf_inss.
    ENDIF.

    CHECK failed-/pyxs/sov_reinf_inss IS INITIAL.

    lcl_process=>read_db( ).
    lcl_process=>build_objects( ).
    lcl_process=>send_integration( ).

    APPEND INITIAL LINE TO reported-/pyxs/sov_reinf_inss ASSIGNING FIELD-SYMBOL(<fs>).
    <fs>-%cid = key-%cid.
    <fs>-%msg = new_message_with_text(
                  severity = if_abap_behv_message=>severity-information
                  text     = 'Processamento solicitado' ).

    res = VALUE #( FOR log IN /pyxs/bp_sov_reinf_inss=>lt_log (
        %cid   = key-%cid
        %param = VALUE #( %data = VALUE #(
            id      = log-id
            retorno = log-retorno
            evento  = log-evento
            AnoMes  = log-ano_mes
            time    = log-time ) )
    ) ).

  ENDMETHOD.

ENDCLASS.

"=============================================================================
CLASS lsc_SOV_REINF_INSS DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.
    METHODS finalize          REDEFINITION.
    METHODS check_before_save REDEFINITION.
    METHODS save              REDEFINITION.
    METHODS cleanup           REDEFINITION.
    METHODS cleanup_finalize  REDEFINITION.
ENDCLASS.

CLASS lsc_SOV_REINF_INSS IMPLEMENTATION.
  METHOD finalize.
  ENDMETHOD.
  METHOD check_before_save.
  ENDMETHOD.
  METHOD save.
    MODIFY /pyxs/sov_reinss FROM TABLE @/pyxs/bp_sov_reinf_inss=>lt_log.
    CLEAR /pyxs/bp_sov_reinf_inss=>lt_log.
  ENDMETHOD.
  METHOD cleanup.
    CLEAR /pyxs/bp_sov_reinf_inss=>lt_log.
  ENDMETHOD.
  METHOD cleanup_finalize.
    CLEAR /pyxs/bp_sov_reinf_inss=>lt_log.
  ENDMETHOD.
ENDCLASS.

"=============================================================================
CLASS lcl_process IMPLEMENTATION.

  "*------------------------------------------------------------------------
  "* format_amount
  "*------------------------------------------------------------------------
  METHOD format_amount.
    DATA(lv_value) = CONV decfloat34( iv_value ).
    IF lv_value IS INITIAL.
      rv_value = '0.00'.
      RETURN.
    ENDIF.
    rv_value = |{ lv_value DECIMALS = 2 SIGN = LEFT }|.
    REPLACE ALL OCCURRENCES OF ',' IN rv_value WITH '.'.
  ENDMETHOD.

  "*------------------------------------------------------------------------
  "* escape_json
  "*------------------------------------------------------------------------
  METHOD escape_json.
    rv_str = iv_str.
    REPLACE ALL OCCURRENCES OF `\`                              IN rv_str WITH `\\`.
    REPLACE ALL OCCURRENCES OF `"`                              IN rv_str WITH `\"`.
    REPLACE ALL OCCURRENCES OF cl_abap_char_utilities=>cr_lf   IN rv_str WITH `\n`.
    REPLACE ALL OCCURRENCES OF cl_abap_char_utilities=>newline  IN rv_str WITH `\n`.
    REPLACE ALL OCCURRENCES OF cl_abap_char_utilities=>horizontal_tab IN rv_str WITH `\t`.
  ENDMETHOD.

  "*------------------------------------------------------------------------
  "* format_date_yyyymmdd  →  DDMMYYYY
  "*------------------------------------------------------------------------
  METHOD format_date_yyyymmdd.
    IF iv_date IS INITIAL.
      rv_date = ''.
      RETURN.
    ENDIF.
    rv_date = |{ iv_date+6(2) }{ iv_date+4(2) }{ iv_date+0(4) }|.
  ENDMETHOD.

  "*------------------------------------------------------------------------
  "* get_period_limits
  "*------------------------------------------------------------------------
  METHOD get_period_limits.
    DATA: lv_year       TYPE n LENGTH 4,
          lv_month      TYPE n LENGTH 2,
          lv_next_first TYPE d.

    lv_year  = iv_anomes(4).
    lv_month = iv_anomes+4(2).
    ev_first_day = |{ lv_year }{ lv_month }01|.

    IF lv_month = 12.
      lv_next_first = |{ lv_year + 1 }0101|.
    ELSE.
      lv_month += 1.
      lv_next_first = |{ lv_year }{ lv_month }01|.
    ENDIF.
    ev_last_day = lv_next_first - 1.
  ENDMETHOD.

  "*------------------------------------------------------------------------
  "* read_db
  "*------------------------------------------------------------------------
  METHOD read_db.

       TYPES: BEGIN OF ty_oreftab,
         originalreferencedocument TYPE i_journalentry-originalreferencedocument,
       END OF ty_oreftab.

    SELECT SINGLE *
      FROM /pyxs/sov_branch
      WHERE company_code = @sel-companycode
        AND branch       = @sel-plant
      INTO @gs_branch_sov.

    DATA: lr_irf_types  TYPE RANGE OF i_withholdingtaxitem-withholdingtaxtype,
          lr_daterange  TYPE RANGE OF i_journalentryitem-clearingdate.

    "DATA: lv_year       TYPE i,
          "lv_month      TYPE i.

    DATA: lv_date_f TYPE datum,
          lv_date_t TYPE datum,
          lr_anomes TYPE RANGE OF datum,
          r_docnum  TYPE RANGE OF i_br_nfdocument-br_notafiscal,
          ls_anomes LIKE LINE OF lr_anomes.

       DATA lt_oreftab TYPE SORTED TABLE OF ty_oreftab
                        WITH UNIQUE KEY originalreferencedocument.

    lv_date_f = |{ sel-anomes }01|.

    "lv_year  = CONV i( sel-anomes(4) ).
    "lv_month = CONV i( sel-anomes+4(2) ).

    " Build last day of month using month-end logic
    lv_date_t = lv_date_f.
    lv_date_t+6(2) = '01'.         " Set day to 01
    ADD 1 TO lv_date_t+4(2).       " Add 1 month
    IF lv_date_t+4(2) = 13.        " Handle December → January
      lv_date_t+4(2) = '01'.
      ADD 1 TO lv_date_t(4).        " Bump year
    ENDIF.
    SUBTRACT 1 FROM lv_date_t.     " Go back 1 day = last day of month

    APPEND VALUE #( sign = 'I' option = 'BT' low = lv_date_f high = lv_date_t ) TO lr_daterange.

    SELECT * FROM /pyxs/sov_taxtype_irf INTO TABLE @mt_irf_types.
    SELECT * FROM /pyxs/sov_natren       INTO TABLE @mt_nature.
    SELECT * FROM /pyxs/sov_cdrei2    INTO TABLE @mt_cdreinf.

    LOOP AT mt_irf_types INTO DATA(ls_irf_type).
      CHECK ls_irf_type-imposto = 'INSS'.
      IF ls_irf_type-Usardatapagto = abap_true.
        APPEND VALUE #( sign = 'I' option = 'EQ' low = ls_irf_type-categoriairf ) TO lr_irf_types.
      ENDIF.
    ENDLOOP.

    CHECK lr_irf_types IS NOT INITIAL.

    SELECT wit~companycode, wit~accountingdocument, wit~fiscalyear, wit~accountingdocumentitem,
           wit~withholdingtaxtype, wit~withholdingtaxcode, wit~whldgtaxbaseamtincocodecrcy,
           wit~whldgtaxamtintransaccrcy, joi~clearingdate, wit~clearingaccountingdocument,
           wit~withholdingtaxpercent, jo~referencedocumenttype, jo~originalreferencedocument, joi~netduedate
      FROM i_withholdingtaxitem AS wit
      INNER JOIN i_journalentry AS jo
        ON wit~companycode         = jo~companycode
       AND wit~accountingdocument  = jo~accountingdocument
       AND wit~fiscalyear          = jo~fiscalyear
      INNER JOIN i_journalentryitem AS joi
        ON wit~companycode         = joi~companycode
       AND wit~accountingdocument  = joi~accountingdocument
       AND wit~fiscalyear          = joi~fiscalyear
       AND wit~accountingdocumentitem = joi~accountingdocumentitem
      WHERE wit~whldgtaxbaseamtincocodecrcy <> 0
        AND joi~clearingdate   IN @lr_daterange
        AND wit~companycode     = @sel-companycode
        AND joi~ledger          = '0L'
        AND wit~withholdingtaxtype IN @lr_irf_types
      INTO TABLE @gt_data.

    CHECK gt_data IS NOT INITIAL.


    IF sel-document IS NOT INITIAL.
      APPEND VALUE #( sign = 'I' option = 'EQ' low = sel-document ) TO r_docnum.
    ENDIF.

    SELECT nfi~br_notafiscal, nfi~br_notafiscalitem, nfi~br_nfsourcedocumenttype,
           nfi~br_nfsourcedocumentnumber,                              "#EC CI_NO_TRANSFORM
           nfi~br_nfsourcedocumentitem, nf~br_nftype, nf~br_nfdirection,
           nf~br_nfpostingdate, nf~br_nfmodel, nf~br_nfseries, nf~br_nfsubseries,
           nf~br_nfnumber, nf~businessplace, nf~br_nfpartnerfunction,
           nf~br_nfpartner, nf~br_nfpartnertype, nf~br_nfiscanceled,
           nf~br_nfsnumber, nf~br_isnfe, nf~br_nfenumber, nf~br_nfhasserviceitem,
           nf~br_nfissuedby, nf~br_nfsituationcode,
           nft~br_taxtype, nft~br_nfitembaseamount, nft~br_nfitemtaxrate,
           nft~br_nfitemtaxamount, nft~br_nfitemwhldgcollectioncode, nft~taxgroup,
           nf~br_businessplacecnpj, nf~br_nfpartnercnpj, nf~br_nfpartnername1,
           nfi~br_lc116servicecode, nf~br_nftotalamount,
           nfi~BR_EFDREINFServiceCode,
           nfi~material
      FROM i_br_nfitem AS nfi
      INNER JOIN i_br_nfdocument AS nf
        ON nf~br_notafiscal = nfi~br_notafiscal
      INNER JOIN i_br_nftax AS nft
        ON nf~br_notafiscal       = nft~br_notafiscal
       AND nfi~br_notafiscalitem  = nft~br_notafiscalitem
      FOR ALL ENTRIES IN @gt_data
      WHERE nfi~br_nfsourcedocumentnumber = @gt_data-originalreferencedocument
        AND nf~businessplace              = @sel-plant
        AND nf~br_notafiscal             IN @r_docnum
        "não pegar estornos e notas canceladas
        and nf~BR_NFIsCanceled NE 'X'
        and nf~br_nftype NE 'A1'
      INTO TABLE @gt_nfs.


    CLEAR lr_irf_types.
    LOOP AT mt_irf_types INTO ls_irf_type.
      CHECK ls_irf_type-imposto = 'INSS'.
      IF ls_irf_type-Usardatapagto = abap_false.
        APPEND VALUE #( sign = 'I' option = 'EQ' low = ls_irf_type-categoriairf ) TO lr_irf_types.
      ENDIF.
    ENDLOOP.

    IF lr_irf_types IS NOT INITIAL.

        SELECT nfi~br_notafiscal, nfi~br_notafiscalitem, nfi~br_nfsourcedocumenttype,
           nfi~br_nfsourcedocumentnumber,                              "#EC CI_NO_TRANSFORM
           nfi~br_nfsourcedocumentitem, nf~br_nftype, nf~br_nfdirection,
           nf~br_nfpostingdate, nf~br_nfmodel, nf~br_nfseries, nf~br_nfsubseries,
           nf~br_nfnumber, nf~businessplace, nf~br_nfpartnerfunction,
           nf~br_nfpartner, nf~br_nfpartnertype, nf~br_nfiscanceled,
           nf~br_nfsnumber, nf~br_isnfe, nf~br_nfenumber, nf~br_nfhasserviceitem,
           nf~br_nfissuedby, nf~br_nfsituationcode,
           nft~br_taxtype, nft~br_nfitembaseamount, nft~br_nfitemtaxrate,
           nft~br_nfitemtaxamount, nft~br_nfitemwhldgcollectioncode, nft~taxgroup,
           nf~br_businessplacecnpj, nf~br_nfpartnercnpj, nf~br_nfpartnername1,
           nfi~br_lc116servicecode, nf~br_nftotalamount,
           nfi~BR_EFDREINFServiceCode,
           nfi~material
         FROM i_br_nfitem AS nfi
         INNER JOIN i_br_nfdocument AS nf
                 ON nf~br_notafiscal = nfi~br_notafiscal
         INNER JOIN i_br_nftax AS nft
                 ON nf~br_notafiscal = nft~br_notafiscal
                AND nfi~br_notafiscalitem = nft~br_notafiscalitem
             WHERE nf~br_nfpostingdate IN @lr_daterange
               "AND nfi~br_nfsourcedocumentnumber  = @lt_data_it-originalreferencedocument
               AND nf~businessplace               = @sel-plant
               AND nf~br_notafiscal               IN @r_docnum
               "AND nft~br_nfitemhaswithholdingtax = 'X'
               "não pegar estornos e notas canceladas
               and nf~BR_NFIsCanceled NE 'X'
               and nf~br_nftype NE 'A1'
         APPENDING TABLE @gt_nfs.

           LOOP AT gt_nfs INTO DATA(ls_nfs_aux).
             INSERT VALUE ty_oreftab(
                      originalreferencedocument = ls_nfs_aux-br_nfsourcedocumentnumber )
               INTO TABLE lt_oreftab.
           ENDLOOP.

          SELECT wit~companycode, wit~accountingdocument, wit~fiscalyear, wit~accountingdocumentitem,
           wit~withholdingtaxtype, wit~withholdingtaxcode, wit~whldgtaxbaseamtincocodecrcy,
           wit~whldgtaxamtintransaccrcy, joi~clearingdate, wit~clearingaccountingdocument,
           wit~withholdingtaxpercent, jo~referencedocumenttype, jo~originalreferencedocument, joi~netduedate
           FROM i_withholdingtaxitem AS wit
           INNER JOIN i_journalentry AS jo
           ON wit~companycode = jo~companycode
           AND wit~accountingdocument = jo~accountingdocument
           AND wit~fiscalyear = jo~fiscalyear
           INNER JOIN i_journalentryitem AS joi
           ON wit~companycode = joi~companycode
           AND wit~accountingdocument = joi~accountingdocument
           AND wit~fiscalyear = joi~fiscalyear
           AND wit~accountingdocumentitem = joi~accountingdocumentitem
           FOR ALL ENTRIES IN @lt_oreftab
           WHERE wit~whldgtaxbaseamtincocodecrcy <> 0
             AND jo~originalreferencedocument = @lt_oreftab-originalreferencedocument
             "AND jo~postingdate IN @sel-creation
             AND wit~companycode = @sel-companycode
             AND joi~ledger      = '0L'
             AND wit~withholdingtaxtype IN @lr_irf_types
           APPENDING TABLE @gt_data.


    ENDIF.


    SORT gt_data BY companycode accountingdocument fiscalyear accountingdocumentitem.

  ENDMETHOD.

  "*------------------------------------------------------------------------
  "* build_objects
  "* One ty_root_r2010 record is built per (wit_data line × nf_data match).
  "* Totals on the header are accumulated per unique id_r2010 via gt_root.
  "*------------------------------------------------------------------------
  METHOD build_objects.

  TYPES: BEGIN OF ty_item_counter,
         id_referencia TYPE string,
         counter       TYPE i,
       END OF ty_item_counter.

  DATA: gt_item_counter TYPE HASHED TABLE OF ty_item_counter
                        WITH UNIQUE KEY id_referencia.

  LOOP AT gt_data INTO DATA(ls_data).

    READ TABLE gt_nfs
      WITH KEY br_nfsourcedocumentnumber = ls_data-originalreferencedocument
      INTO DATA(ls_nfs).

    CHECK sy-subrc = 0.

***    IF ls_nfs-br_lc116servicecode IS INITIAL.
***      CONTINUE.
***    ENDIF.

  READ TABLE mt_irf_types
    WITH KEY categoriairf = ls_data-withholdingtaxtype
    INTO DATA(ls_irf_type).

    DATA(lv_root_id) =
      |{ ls_nfs-br_nfpostingdate(6) }{ ls_nfs-br_nfpartner }{ ls_nfs-br_nfnumber }|.

    IF ls_irf_type-Usardatapagto = abap_true.
      lv_root_id = |{ ls_data-clearingdate(6) }{ ls_nfs-br_nfpartner }{ ls_nfs-br_nfnumber }|.
    ENDIF.

    READ TABLE gt_objects ASSIGNING FIELD-SYMBOL(<root>)
      WITH KEY knwReinfR2010-id_referencia = lv_root_id.

    IF sy-subrc <> 0.
      APPEND INITIAL LINE TO gt_objects ASSIGNING <root>.
      <root>-knwReinfR2010-cd_empresa          = gs_branch_sov-sov_company.
      <root>-knwReinfR2010-cd_filial           = gs_branch_sov-sov_branch.
      <root>-knwReinfR2010-id_referencia       = lv_root_id.
      <root>-knwReinfR2010-dm_retificacao      = '1'.
      <root>-knwReinfR2010-dt_apuracao         = format_date_yyyymmdd( ls_nfs-br_nfpostingdate ).
      IF ls_irf_type-Usardatapagto = abap_true.
        <root>-knwReinfR2010-dt_apuracao         = format_date_yyyymmdd( ls_data-clearingdate ).
      ENDIF.
      <root>-knwReinfR2010-dm_inscricao_obra   = '1'.
      <root>-knwReinfR2010-nr_inscricao_obra   = ls_nfs-br_businessplacecnpj.
      <root>-knwReinfR2010-dm_obra             = '0'.
      <root>-knwReinfR2010-nr_cnpj_prestador   = ls_nfs-br_nfpartnercnpj.
      <root>-knwReinfR2010-vl_total_bruto      = '0'.
      <root>-knwReinfR2010-vl_total_base       = '0'.
      <root>-knwReinfR2010-vl_total_retencao   = '0'.
      <root>-knwReinfR2010-vl_tot_retencao_adic  = '0'.
      <root>-knwReinfR2010-vl_tot_ret_nao_efet   = '0'.
      <root>-knwReinfR2010-vl_tot_ret_nefe_adic  = '0'.
      <root>-knwReinfR2010-dm_cprb             = '0'.
    ENDIF.

    " Accumulate totals on the root header
    <root>-knwReinfR2010-vl_total_bruto =
      abs( ls_nfs-br_nftotalamount ).
    <root>-knwReinfR2010-vl_total_base =
      abs( ls_data-whldgtaxbaseamtincocodecrcy ).
    <root>-knwReinfR2010-vl_total_retencao +=
      abs( ls_data-whldgtaxamtintransaccrcy ).

    READ TABLE gt_item_counter ASSIGNING FIELD-SYMBOL(<counter>)
      WITH TABLE KEY id_referencia = lv_root_id.

    DATA lv_nr_item_nota TYPE i.

    IF sy-subrc = 0.
      <counter>-counter += 1.
      lv_nr_item_nota = <counter>-counter.
    ELSE.
      INSERT VALUE #(
        id_referencia = lv_root_id
        counter       = 1
      ) INTO TABLE gt_item_counter
      ASSIGNING <counter>.

      lv_nr_item_nota = 1.
    ENDIF.


    READ TABLE <root>-knwReinfR2010NotaList
      ASSIGNING FIELD-SYMBOL(<nota>)
      WITH KEY id_referencia = lv_root_id.

    IF sy-subrc <> 0.
        APPEND INITIAL LINE TO
          <root>-knwReinfR2010NotaList
          ASSIGNING <nota>.

        <nota>-cd_empresa     = gs_branch_sov-sov_company.
        <nota>-cd_filial      = gs_branch_sov-sov_branch.
        <nota>-id_referencia  = lv_root_id.
        <nota>-nr_item_nota   = lv_nr_item_nota.
        <nota>-nr_serie       = ls_nfs-br_nfseries.
        <nota>-nr_documento   = ls_nfs-br_nfnumber.
        <nota>-dt_emissao     = format_date_yyyymmdd( iv_date = ls_nfs-br_nfpostingdate ).
        IF ls_irf_type-Usardatapagto = abap_true.
          <root>-knwReinfR2010-dt_apuracao         = format_date_yyyymmdd( ls_data-clearingdate ).
        ENDIF.
        <nota>-vl_bruto       = format_amount( iv_value = ls_nfs-br_nftotalamount ).
        <nota>-ds_observacao  = ''.
          "|Doc contábil { ls_data-accountingdocument }|.
        IF <nota>-nr_serie IS INITIAL OR <nota>-nr_serie = ' '.
          <nota>-nr_serie = '000'.
        ENDIF.
    ENDIF.

    READ TABLE <root>-knwReinfR2010ServicoList
      ASSIGNING FIELD-SYMBOL(<serv>)
      WITH KEY id_referencia = lv_root_id.

    IF sy-subrc <> 0.


        APPEND INITIAL LINE TO
          <root>-knwReinfR2010ServicoList
          ASSIGNING <serv>.

        <serv>-cd_empresa        = gs_branch_sov-sov_company.
        <serv>-cd_filial         = gs_branch_sov-sov_branch.
        <serv>-id_referencia     = lv_root_id.
        <serv>-nr_item_nota      = lv_nr_item_nota.
        <serv>-nr_item_servico   = 1.
        <serv>-cd_tipo_servico   = ls_nfs-BR_EFDREINFServiceCode.
        <serv>-vl_base_retencao  = '0'.
        <serv>-vl_retencao       += '0'.

        READ TABLE mt_cdreinf
          INTO DATA(ls_cdreinf)
          WITH KEY material = ls_nfs-material.
        IF sy-subrc = '0'.
          <serv>-cd_tipo_servico = ls_cdreinf-codreinf.
        ENDIF.
    ENDIF.

    <serv>-vl_base_retencao =  abs( ls_data-whldgtaxbaseamtincocodecrcy ).
    <serv>-vl_retencao      += abs( ls_data-whldgtaxamtintransaccrcy ).

  ENDLOOP.

ENDMETHOD.

  "*------------------------------------------------------------------------
  "* JSON builders
  "*------------------------------------------------------------------------
  METHOD build_r2010_json.
***    rv_json =
***      |\{| &&
***      |"CD_EMPRESA":"{ escape_json( is_r2010-cd_empresa ) }",| &&
***      |"CD_FILIAL":"{ escape_json( is_r2010-cd_filial ) }",| &&
***      |"ID_REFERENCIA":"{ escape_json( is_r2010-id_referencia ) }",| &&
***      |"DM_RETIFICACAO":"{ escape_json( is_r2010-dm_retificacao ) }",| &&
***      |"DT_APURACAO":"{ escape_json( is_r2010-dt_apuracao ) }",| &&
***      |"DM_INSCRICAO_OBRA":"{ escape_json( is_r2010-dm_inscricao_obra ) }",| &&
***      |"NR_INSCRICAO_OBRA":"{ escape_json( is_r2010-nr_inscricao_obra ) }",| &&
***      |"DM_OBRA":"{ escape_json( is_r2010-dm_obra ) }",| &&
***      |"NR_CNPJ_PRESTADOR":"{ escape_json( is_r2010-nr_cnpj_prestador ) }",| &&
***      |"VL_TOTAL_BRUTO":"{ escape_json( is_r2010-vl_total_bruto ) }",| &&
***      |"VL_TOTAL_BASE":"{ escape_json( is_r2010-vl_total_base ) }",| &&
***      |"VL_TOTAL_RETENCAO":"{ escape_json( is_r2010-vl_total_retencao ) }",| &&
***      |"VL_TOT_RETENCAO_ADIC":"{ escape_json( is_r2010-vl_tot_retencao_adic ) }",| &&
***      |"VL_TOT_RET_NAO_EFET":"{ escape_json( is_r2010-vl_tot_ret_nao_efet ) }",| &&
***      |"VL_TOT_RET_NEFE_ADIC":"{ escape_json( is_r2010-vl_tot_ret_nefe_adic ) }",| &&
***      |"DM_CPRB":"{ escape_json( is_r2010-dm_cprb ) }"| &&
***      |\}|.
  ENDMETHOD.

  METHOD build_nota_json.
***    rv_json =
***      |\{| &&
***      |"CD_EMPRESA":"{ escape_json( is_nota-cd_empresa ) }",| &&
***      |"CD_FILIAL":"{ escape_json( is_nota-cd_filial ) }",| &&
***      |"ID_REFERENCIA":"{ escape_json( is_nota-id_referencia ) }",| &&
***      |"NR_ITEM_NOTA":"{ escape_json( is_nota-nr_item_nota ) }",| &&
***      |"NR_SERIE":"{ escape_json( is_nota-nr_serie ) }",| &&
***      |"NR_DOCUMENTO":"{ escape_json( is_nota-nr_documento ) }",| &&
***      |"DT_EMISSAO":"{ escape_json( is_nota-dt_emissao ) }",| &&
***      |"VL_BRUTO":"{ escape_json( is_nota-vl_bruto ) }",| &&
***      |"DS_OBSERVACAO":"{ escape_json( is_nota-ds_observacao ) }"| &&
***      |\}|.
  ENDMETHOD.

  METHOD build_servico_json.
***    rv_json =
***      |\{| &&
***      |"CD_EMPRESA":"{ escape_json( is_serv-cd_empresa ) }",| &&
***      |"CD_FILIAL":"{ escape_json( is_serv-cd_filial ) }",| &&
***      |"ID_REFERENCIA":"{ escape_json( is_serv-id_referencia ) }",| &&
***      |"NR_ITEM_NOTA":"{ escape_json( is_serv-nr_item_nota ) }",| &&
***      |"NR_ITEM_SERVICO":"{ escape_json( is_serv-nr_item_servico ) }",| &&
***      |"CD_TIPO_SERVICO":"{ escape_json( is_serv-cd_tipo_servico ) }",| &&
***      |"VL_BASE_RETENCAO":"{ escape_json( is_serv-vl_base_retencao ) }",| &&
***      |"VL_RETENCAO":"{ escape_json( is_serv-vl_retencao ) }"| &&
***      |\}|.
  ENDMETHOD.

  METHOD build_payload_json.
***    rv_json =
***      |\{| &&
***      |"KNW_R2010":{ build_r2010_json( is_obj-knwreinfr2010 ) },| &&
***      |"KNW_R2010_NOTA":{ build_nota_json( is_obj-knwreinfr2010notalist ) },| &&
***      |"KNW_R2010_SERVICO":{ build_servico_json( is_obj-knwreinfr2010servicolist ) }| &&
***      |\}|.
  ENDMETHOD.

  "*------------------------------------------------------------------------
  "* send_integration – POST each payload to Sovos
  "*------------------------------------------------------------------------
  METHOD send_integration.

  TYPES: BEGIN OF ty_payload,
         objetos TYPE tt_r2010_objects,
       END OF ty_payload.

  DATA ls_payload TYPE ty_payload.

        DATA: gv_proc          TYPE string.
        DATA: lo_ret           TYPE REF TO data,
              lv_sucesso       TYPE abap_boolean,
              objects          TYPE tt_r2010_objects,
              lv_utf8_xstring  TYPE xstring,
              lv_gzip_xstring  TYPE xstring,
              lv_base64        TYPE string,
              ls_root          TYPE ty_root_r2010.

  LOOP AT gt_objects INTO ls_root.
  APPEND ls_root TO objects.
  ls_payload-objetos = objects.
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

    json_out = /pyxs/sov_json_conversion=>convert_reinf2010( json_out ).

    lv_utf8_xstring = cl_abap_conv_codepage=>create_out( codepage = 'UTF-8' )->convert( source = json_out ).
    cl_abap_gzip=>compress_binary_with_header(
      EXPORTING
        raw_in = lv_utf8_xstring
      IMPORTING
        gzip_out = lv_gzip_xstring ).
    lv_base64 = cl_web_http_utility=>encode_x_base64( lv_gzip_xstring ).
    CONCATENATE '{"nr_licenca": "00000","dados": "' lv_base64 '"}'
    INTO json_out. "o valor nr_licenca deve ser setado na integração

    DATA: lr_cscn TYPE if_com_scenario_factory=>ty_query-cscn_id_range.

    " find CA by scenario
    "lr_cscn = VALUE #( ( sign = 'I' option = 'EQ' low = '/PYXS/SOVOS_REINF' ) ).
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
      <log>-ano_mes = sel-anomes.
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
            "comm_scenario  = '/PYXS/SOVOS_REINF'
            "service_id     = '/PYXS/SOVOS_REINF_REST'
              comm_scenario  = '/PYXS/SOVOS'
              service_id     = '/PYXS/SOV_REINF2_REST'
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
            i_uri_path = 'R2010'
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

***    IF lo_ret IS INITIAL.
***      APPEND INITIAL LINE TO /pyxs/bp_reinflog=>lt_log ASSIGNING <log>.
***      <log>-time = time.
***      READ TABLE ls_root-knwReinfR4020 INTO DATA(ls_nf) INDEX 1.
***
***      <log>-ano_mes = me->sel-creation[ 1 ]-low.
***      <log>-evento = '4000'.
***      <log>-partner = ls_nf-id_referencia+6.
***      <log>-resultado = COND #( WHEN lv_ret IS INITIAL THEN '999' ELSE lv_ret-code ).
***      <log>-retorno = COND #( WHEN gv_proc IS NOT INITIAL THEN gv_proc
***                              WHEN lv_ret IS NOT INITIAL THEN lv_ret-reason
***                              ELSE 'Erro no serviço' ).
***
***    ELSE.
***
***      LOOP AT lo_ret->('MENSAGENS')->* ASSIGNING FIELD-SYMBOL(<lv_msg>).
***        APPEND INITIAL LINE TO /pyxs/bp_reinflog=>lt_log ASSIGNING <log>.
***        <log>-id = sy-tabix.
***        <log>-time = time.
***        READ TABLE ls_root-knwReinfR4020 INTO ls_nf INDEX 1.
***
***        <log>-ano_mes = me->sel-creation[ 1 ]-low.
***        <log>-evento = '4000'.
***        <log>-partner = ls_nf-id_referencia+6.
***        <log>-resultado = lv_ret-code.
***        <log>-retorno = lv_ret-reason.
***      ENDLOOP.
***    ENDIF.
  ENDLOOP.
  ENDMETHOD.

  "*------------------------------------------------------------------------
  "* main
  "*------------------------------------------------------------------------
  METHOD main.
    data_sys = cl_abap_context_info=>get_system_date( ).
    hora_sys = cl_abap_context_info=>get_system_time( ).
    read_db( ).
    build_objects( ).
    send_integration( ).
  ENDMETHOD.

ENDCLASS.