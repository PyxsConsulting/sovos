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
        br_nfissuedate               TYPE i_br_nfdocument-br_nfissuedate,
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
        knw_r2010         TYPE ty_knw_r2010,
        knw_r2010_nota    TYPE ty_knw_r2010_nota,
        knw_r2010_servico TYPE ty_knw_r2010_servico,
      END OF ty_root_r2010,

      ty_t_root_r2010 TYPE STANDARD TABLE OF ty_root_r2010 WITH NON-UNIQUE DEFAULT KEY,

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
      gt_nfs        TYPE ty_t_nf_data,
      mt_nature     TYPE TABLE OF /pyxs/sov_natren,
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

    SELECT SINGLE *
      FROM /pyxs/sov_branch
      WHERE company_code = @sel-companycode
        AND branch       = @sel-plant
      INTO @gs_branch_sov.

    SELECT SINGLE companycode, companycodename
      FROM i_companycode
      WHERE companycode = @sel-companycode
      INTO @gs_company.

    DATA: lr_irf_types  TYPE RANGE OF i_withholdingtaxitem-withholdingtaxtype,
          lr_daterange  TYPE RANGE OF i_journalentryitem-clearingdate,
          lv_first_day  TYPE d,
          lv_last_day   TYPE d,
          lv_next_month TYPE d.

    lv_first_day = |{ sel-anomes }01|.

    DATA(lv_year)  = CONV i( sel-anomes(4) ).
    DATA(lv_month) = CONV i( sel-anomes+4(2) ).

    IF lv_month = 12.
      lv_year  += 1.
      lv_month  = 1.
    ELSE.
      lv_month += 1.
    ENDIF.

    lv_next_month = |{ lv_year WIDTH = 4 PAD = '0' }{ lv_month WIDTH = 2 PAD = '0' }01|.
    lv_last_day   = lv_next_month - 1.

    APPEND VALUE #( sign = 'I' option = 'BT' low = lv_first_day high = lv_last_day ) TO lr_daterange.

    SELECT * FROM /pyxs/sov_taxtype_irf INTO TABLE @mt_irf_types.
    SELECT * FROM /pyxs/sov_natren       INTO TABLE @mt_nature.

    LOOP AT mt_irf_types INTO DATA(ls_irf_type).
      CHECK ls_irf_type-imposto <> 'INSS'.
      APPEND VALUE #( sign = 'I' option = 'EQ' low = ls_irf_type-categoriairf ) TO lr_irf_types.
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

    SELECT nfi~br_notafiscal, nfi~br_notafiscalitem, nfi~br_nfsourcedocumenttype,
           nfi~br_nfsourcedocumentnumber,                              "#EC CI_NO_TRANSFORM
           nfi~br_nfsourcedocumentitem, nf~br_nftype, nf~br_nfdirection,
           nf~br_nfissuedate, nf~br_nfmodel, nf~br_nfseries, nf~br_nfsubseries,
           nf~br_nfnumber, nf~businessplace, nf~br_nfpartnerfunction,
           nf~br_nfpartner, nf~br_nfpartnertype, nf~br_nfiscanceled,
           nf~br_nfsnumber, nf~br_isnfe, nf~br_nfenumber, nf~br_nfhasserviceitem,
           nf~br_nfissuedby, nf~br_nfsituationcode,
           nft~br_taxtype, nft~br_nfitembaseamount, nft~br_nfitemtaxrate,
           nft~br_nfitemtaxamount, nft~br_nfitemwhldgcollectioncode, nft~taxgroup,
           nf~br_businessplacecnpj, nf~br_nfpartnercnpj, nf~br_nfpartnername1,
           nfi~br_lc116servicecode, nf~br_nftotalamount
      FROM i_br_nfitem AS nfi
      INNER JOIN i_br_nfdocument AS nf
        ON nf~br_notafiscal = nfi~br_notafiscal
      INNER JOIN i_br_nftax AS nft
        ON nf~br_notafiscal       = nft~br_notafiscal
       AND nfi~br_notafiscalitem  = nft~br_notafiscalitem
      FOR ALL ENTRIES IN @gt_data
      WHERE nfi~br_nfsourcedocumentnumber = @gt_data-originalreferencedocument
        AND nf~businessplace              = @sel-plant
      INTO TABLE @gt_nfs.

    SORT gt_data BY companycode accountingdocument fiscalyear accountingdocumentitem.

  ENDMETHOD.

  "*------------------------------------------------------------------------
  "* build_objects
  "* One ty_root_r2010 record is built per (wit_data line × nf_data match).
  "* Totals on the header are accumulated per unique id_r2010 via gt_root.
  "*------------------------------------------------------------------------
  METHOD build_objects.

    TYPES: BEGIN OF ty_seq_nota,
             id  TYPE string,
             seq TYPE i,
           END OF ty_seq_nota,
           BEGIN OF ty_seq_servico,
             id  TYPE string,
             seq TYPE i,
           END OF ty_seq_servico.

    DATA: gt_seq_nota    TYPE STANDARD TABLE OF ty_seq_nota    WITH KEY id,
          gt_seq_servico TYPE STANDARD TABLE OF ty_seq_servico WITH KEY id.

    CLEAR gt_root.

    LOOP AT gt_data INTO DATA(ls_data).

      READ TABLE gt_nfs WITH KEY br_nfsourcedocumentnumber = ls_data-originalreferencedocument
                        INTO DATA(ls_nfs).
      CHECK sy-subrc = 0.

      " Resolve service type via mt_nature
      READ TABLE mt_nature INTO DATA(ls_nat) WITH KEY lc116 = ls_nfs-br_lc116servicecode.
      CHECK sy-subrc = 0.   " skip if no nature found (no RETURN — just skip this line)

      DATA(lv_cd_tipo_servico) = ls_nat-nat_res.

      " ── grouping keys ─────────────────────────────────────────────────
      DATA(lv_id_r2010)  = |{ ls_data-clearingdate(6) }{ ls_nfs-br_nfpartner }|.
      DATA(lv_id_nota)   = |{ lv_id_r2010 }{ ls_nfs-br_nfnumber }{ ls_nfs-br_nfseries }|.
      DATA(lv_id_servico) = |{ lv_id_nota }{ lv_cd_tipo_servico }|.

      " ── NR_ITEM_NOTA sequencer ────────────────────────────────────────
      READ TABLE gt_seq_nota WITH KEY id = lv_id_nota ASSIGNING FIELD-SYMBOL(<seq_nota>).
      IF sy-subrc <> 0.
        DATA(lv_count_nota) = REDUCE i(
          INIT n = 0
          FOR ls_sn IN gt_seq_nota WHERE ( id CS lv_id_r2010 )
          NEXT n = n + 1 ).
        INSERT VALUE #( id = lv_id_nota seq = lv_count_nota + 1 )
          INTO TABLE gt_seq_nota ASSIGNING <seq_nota>.
      ENDIF.
      DATA(lv_nr_item_nota) = |{ <seq_nota>-seq }|.

      " ── NR_ITEM_SERVICO sequencer ─────────────────────────────────────
      READ TABLE gt_seq_servico WITH KEY id = lv_id_servico ASSIGNING FIELD-SYMBOL(<seq_serv>).
      IF sy-subrc <> 0.
        DATA(lv_count_serv) = REDUCE i(
          INIT n = 0
          FOR ls_ss IN gt_seq_servico WHERE ( id CS lv_id_nota )
          NEXT n = n + 1 ).
        INSERT VALUE #( id = lv_id_servico seq = lv_count_serv + 1 )
          INTO TABLE gt_seq_servico ASSIGNING <seq_serv>.
      ENDIF.
      DATA(lv_nr_item_servico) = |{ <seq_serv>-seq }|.

      " ── amounts for this line (packed arithmetic before string conv) ──
      DATA(lv_base) = abs( ls_data-whldgtaxbaseamtincocodecrcy ).
      DATA(lv_ret)  = abs( ls_data-whldgtaxamtintransaccrcy ).
      DATA(lv_bruto) = abs( ls_nfs-br_nftotalamount ).

      " ── look for an existing root record for this service line ────────
      READ TABLE gt_root ASSIGNING FIELD-SYMBOL(<ls_root>)
           WITH KEY knw_r2010-id_referencia         = lv_id_r2010
                    knw_r2010_nota-id_referencia     = lv_id_nota
                    knw_r2010_servico-id_referencia  = lv_id_servico.

      IF sy-subrc <> 0.
        " ── new combination: build a fresh root record ─────────────────
        DATA(ls_new_root) = VALUE ty_root_r2010(
          knw_r2010 = VALUE #(
            cd_empresa           = gs_branch_sov-sov_company
            cd_filial            = gs_branch_sov-sov_branch
            id_referencia        = lv_id_r2010
            dm_retificacao       = '1'
            dt_apuracao          = format_date_yyyymmdd( ls_data-clearingdate )
            dm_inscricao_obra    = ' '
            nr_inscricao_obra    = ' '
            dm_obra              = '0'
            nr_cnpj_prestador    = ls_nfs-br_nfpartnercnpj
            vl_total_bruto       = format_amount( lv_bruto )
            vl_total_base        = format_amount( lv_base )
            vl_total_retencao    = format_amount( lv_ret )
            vl_tot_retencao_adic = '0.00'
            vl_tot_ret_nao_efet  = '0.00'
            vl_tot_ret_nefe_adic = '0.00'
            dm_cprb              = '0' )
          knw_r2010_nota = VALUE #(
            cd_empresa    = gs_branch_sov-sov_company
            cd_filial     = gs_branch_sov-sov_branch
            id_referencia = lv_id_nota
            nr_item_nota  = lv_nr_item_nota
            nr_serie      = ls_nfs-br_nfseries
            nr_documento  = ls_nfs-br_nfnumber
            dt_emissao    = format_date_yyyymmdd( ls_nfs-br_nfissuedate )
            vl_bruto      = format_amount( lv_bruto )
            ds_observacao = |Doc contábil { ls_data-accountingdocument }| )
          knw_r2010_servico = VALUE #(
            cd_empresa       = gs_branch_sov-sov_company
            cd_filial        = gs_branch_sov-sov_branch
            id_referencia    = lv_id_servico
            nr_item_nota     = lv_nr_item_nota
            nr_item_servico  = lv_nr_item_servico
            cd_tipo_servico  = lv_cd_tipo_servico
            vl_base_retencao = format_amount( lv_base )
            vl_retencao      = format_amount( lv_ret ) )
        ).
        APPEND ls_new_root TO gt_root ASSIGNING <ls_root>.

      ELSE.
        " ── existing record: accumulate numeric totals on the header ────
        " Re-compute as packed, add, then re-format as string
        DATA(lv_acc_bruto) = CONV decfloat34( <ls_root>-knw_r2010-vl_total_bruto ) + lv_bruto.
        DATA(lv_acc_base)  = CONV decfloat34( <ls_root>-knw_r2010-vl_total_base  ) + lv_base.
        DATA(lv_acc_ret)   = CONV decfloat34( <ls_root>-knw_r2010-vl_total_retencao ) + lv_ret.

        <ls_root>-knw_r2010-vl_total_bruto    = format_amount( lv_acc_bruto ).
        <ls_root>-knw_r2010-vl_total_base     = format_amount( lv_acc_base ).
        <ls_root>-knw_r2010-vl_total_retencao = format_amount( lv_acc_ret ).

        " Accumulate service amounts too
        DATA(lv_acc_srv_base) = CONV decfloat34( <ls_root>-knw_r2010_servico-vl_base_retencao ) + lv_base.
        DATA(lv_acc_srv_ret)  = CONV decfloat34( <ls_root>-knw_r2010_servico-vl_retencao      ) + lv_ret.

        <ls_root>-knw_r2010_servico-vl_base_retencao = format_amount( lv_acc_srv_base ).
        <ls_root>-knw_r2010_servico-vl_retencao      = format_amount( lv_acc_srv_ret ).
      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  "*------------------------------------------------------------------------
  "* JSON builders
  "*------------------------------------------------------------------------
  METHOD build_r2010_json.
    rv_json =
      |\{| &&
      |"CD_EMPRESA":"{ escape_json( is_r2010-cd_empresa ) }",| &&
      |"CD_FILIAL":"{ escape_json( is_r2010-cd_filial ) }",| &&
      |"ID_REFERENCIA":"{ escape_json( is_r2010-id_referencia ) }",| &&
      |"DM_RETIFICACAO":"{ escape_json( is_r2010-dm_retificacao ) }",| &&
      |"DT_APURACAO":"{ escape_json( is_r2010-dt_apuracao ) }",| &&
      |"DM_INSCRICAO_OBRA":"{ escape_json( is_r2010-dm_inscricao_obra ) }",| &&
      |"NR_INSCRICAO_OBRA":"{ escape_json( is_r2010-nr_inscricao_obra ) }",| &&
      |"DM_OBRA":"{ escape_json( is_r2010-dm_obra ) }",| &&
      |"NR_CNPJ_PRESTADOR":"{ escape_json( is_r2010-nr_cnpj_prestador ) }",| &&
      |"VL_TOTAL_BRUTO":"{ escape_json( is_r2010-vl_total_bruto ) }",| &&
      |"VL_TOTAL_BASE":"{ escape_json( is_r2010-vl_total_base ) }",| &&
      |"VL_TOTAL_RETENCAO":"{ escape_json( is_r2010-vl_total_retencao ) }",| &&
      |"VL_TOT_RETENCAO_ADIC":"{ escape_json( is_r2010-vl_tot_retencao_adic ) }",| &&
      |"VL_TOT_RET_NAO_EFET":"{ escape_json( is_r2010-vl_tot_ret_nao_efet ) }",| &&
      |"VL_TOT_RET_NEFE_ADIC":"{ escape_json( is_r2010-vl_tot_ret_nefe_adic ) }",| &&
      |"DM_CPRB":"{ escape_json( is_r2010-dm_cprb ) }"| &&
      |\}|.
  ENDMETHOD.

  METHOD build_nota_json.
    rv_json =
      |\{| &&
      |"CD_EMPRESA":"{ escape_json( is_nota-cd_empresa ) }",| &&
      |"CD_FILIAL":"{ escape_json( is_nota-cd_filial ) }",| &&
      |"ID_REFERENCIA":"{ escape_json( is_nota-id_referencia ) }",| &&
      |"NR_ITEM_NOTA":"{ escape_json( is_nota-nr_item_nota ) }",| &&
      |"NR_SERIE":"{ escape_json( is_nota-nr_serie ) }",| &&
      |"NR_DOCUMENTO":"{ escape_json( is_nota-nr_documento ) }",| &&
      |"DT_EMISSAO":"{ escape_json( is_nota-dt_emissao ) }",| &&
      |"VL_BRUTO":"{ escape_json( is_nota-vl_bruto ) }",| &&
      |"DS_OBSERVACAO":"{ escape_json( is_nota-ds_observacao ) }"| &&
      |\}|.
  ENDMETHOD.

  METHOD build_servico_json.
    rv_json =
      |\{| &&
      |"CD_EMPRESA":"{ escape_json( is_serv-cd_empresa ) }",| &&
      |"CD_FILIAL":"{ escape_json( is_serv-cd_filial ) }",| &&
      |"ID_REFERENCIA":"{ escape_json( is_serv-id_referencia ) }",| &&
      |"NR_ITEM_NOTA":"{ escape_json( is_serv-nr_item_nota ) }",| &&
      |"NR_ITEM_SERVICO":"{ escape_json( is_serv-nr_item_servico ) }",| &&
      |"CD_TIPO_SERVICO":"{ escape_json( is_serv-cd_tipo_servico ) }",| &&
      |"VL_BASE_RETENCAO":"{ escape_json( is_serv-vl_base_retencao ) }",| &&
      |"VL_RETENCAO":"{ escape_json( is_serv-vl_retencao ) }"| &&
      |\}|.
  ENDMETHOD.

  METHOD build_payload_json.
    rv_json =
      |\{| &&
      |"KNW_R2010":{ build_r2010_json( is_obj-knw_r2010 ) },| &&
      |"KNW_R2010_NOTA":{ build_nota_json( is_obj-knw_r2010_nota ) },| &&
      |"KNW_R2010_SERVICO":{ build_servico_json( is_obj-knw_r2010_servico ) }| &&
      |\}|.
  ENDMETHOD.

  "*------------------------------------------------------------------------
  "* send_integration – POST each payload to Sovos
  "*------------------------------------------------------------------------
  METHOD send_integration.

    DATA: lo_ret     TYPE REF TO data,
          lv_sucesso TYPE abap_boolean.

    LOOP AT gt_root INTO DATA(ls_root).

      DATA(lv_json) = build_payload_json( ls_root ).
      lv_json = /pyxs/sov_json_conversion=>convert_sovos( lv_json ).

      DATA lr_cscn TYPE if_com_scenario_factory=>ty_query-cscn_id_range.
      lr_cscn = VALUE #( ( sign = 'I' option = 'EQ' low = '/PYXS/SOVOS' ) ).

      DATA(lo_factory) = cl_com_arrangement_factory=>create_instance( ).
      lo_factory->query_ca(
        EXPORTING is_query           = VALUE #( cscn_id_range = lr_cscn )
        IMPORTING et_com_arrangement = DATA(lt_ca) ).

      IF lt_ca IS INITIAL.
        GET TIME STAMP FIELD DATA(ts).
        APPEND VALUE #(
          time    = ts
          ano_mes = sel-anomes
          retorno = 'Cenário de comunicação não encontrado'
        ) TO /pyxs/bp_sov_reinf_inss=>lt_log.
        EXIT.
      ENDIF.

      READ TABLE lt_ca INTO DATA(lo_ca) INDEX 1.

      TRY.
          DATA(lo_dest) = cl_http_destination_provider=>create_by_comm_arrangement(
            comm_scenario  = '/PYXS/SOVOS'
            service_id     = '/PYXS/SOV_REINF2_REST'
            comm_system_id = lo_ca->get_comm_system_id( ) ).

          DATA(lo_http_client) = cl_web_http_client_manager=>create_by_http_destination( lo_dest ).
          DATA(lo_request)     = lo_http_client->get_http_request( ).
          lo_request->set_text( i_text = lv_json ).
          lo_request->set_uri_path( i_uri_path = '/R2010' ).

          DATA(lo_response) = lo_http_client->execute( if_web_http_client=>post ).
          DATA(lv_ret)      = lo_response->get_status( ).
          CLEAR lo_ret.

          IF lv_ret-code = '200'.
            DATA(lv_msg) = lo_response->get_text( ).
            IF lv_msg IS INITIAL.
              gv_proc = 'Successfully processed'(002).
            ELSE.
              gv_proc = lv_msg.
              /ui2/cl_json=>deserialize( EXPORTING json = gv_proc CHANGING data = lo_ret ).
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

        CATCH cx_web_message_error cx_http_dest_provider_error cx_web_http_client_error.
      ENDTRY.

      GET TIME STAMP FIELD ts.

      IF lo_ret IS INITIAL.
        APPEND VALUE #(
          time    = ts
          ano_mes = sel-anomes
          retorno = |Erro no serviço: { gv_proc }|
          evento  = lv_ret-code
          resultado = lv_ret-reason
        ) TO /pyxs/bp_sov_reinf_inss=>lt_log.
      ELSE.
        LOOP AT lo_ret->('MENSAGENS')->* ASSIGNING FIELD-SYMBOL(<lv_msg_line>).
          APPEND VALUE #(
            time    = ts
            ano_mes = sel-anomes
            retorno = |Erro no serviço: { gv_proc }|
            evento  = lv_ret-code
            resultado = lv_ret-reason
          ) TO /pyxs/bp_sov_reinf_inss=>lt_log.
        ENDLOOP.
      ENDIF.

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

*****CLASS lhc_SOV_REINF_INSS DEFINITION INHERITING FROM cl_abap_behavior_handler.
*****  PRIVATE SECTION.
*****
*****    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
*****      IMPORTING keys REQUEST requested_authorizations FOR /pyxs/sov_reinf_inss RESULT result.
*****
*****    METHODS create FOR MODIFY
*****      IMPORTING entities FOR CREATE /pyxs/sov_reinf_inss.
*****
*****    METHODS update FOR MODIFY
*****      IMPORTING entities FOR UPDATE /pyxs/sov_reinf_inss.
*****
*****    METHODS delete FOR MODIFY
*****      IMPORTING keys FOR DELETE /pyxs/sov_reinf_inss.
*****
*****    METHODS read FOR READ
*****      IMPORTING keys FOR READ /pyxs/sov_reinf_inss RESULT result.
*****
*****    METHODS lock FOR LOCK
*****      IMPORTING keys FOR LOCK /pyxs/sov_reinf_inss.
*****
*****    METHODS sendintegration FOR MODIFY
*****      IMPORTING keys FOR ACTION /pyxs/sov_reinf_inss~sendintegration RESULT res.
*****
*****ENDCLASS.
*****
*****CLASS lcl_process DEFINITION FRIENDS lhc_SOV_REINF_INSS.
*****
*****  PUBLIC SECTION.
*****    CLASS-METHODS: main.
*****
*****    TYPES:
*****      BEGIN OF ty_sel,
*****        companycode TYPE i_companycode-companycode,
*****        plant       TYPE i_plant-plant,         " business place
*****        anomes      TYPE string,                " YYYYMM
*****      END OF ty_sel,
*****
*****      BEGIN OF ty_tax_item,
*****             companycode                    TYPE i_journalentry-companycode,
*****             accountingdocument             TYPE i_journalentry-accountingdocument,
*****             fiscalyear                     TYPE i_journalentry-fiscalyear,
*****             accountingdocumentitem         TYPE i_withholdingtaxitem-accountingdocumentitem,
*****             withholdingtaxtype             TYPE i_withholdingtaxitem-withholdingtaxtype,
*****             withholdingtaxcode             TYPE i_withholdingtaxitem-withholdingtaxcode,
*****             withholdingtaxbaseamtincocode  TYPE i_withholdingtaxitem-whldgtaxbaseamtincocodecrcy,
*****             withholdingtaxamtintransaccrcy TYPE i_withholdingtaxitem-whldgtaxamtintransaccrcy,
*****             clearingdate                   TYPE i_withholdingtaxitem-clearingdate,
*****             clearingaccountingdocument     TYPE i_withholdingtaxitem-clearingaccountingdocument,
*****             withholdingtaxpercent          TYPE i_withholdingtaxitem-withholdingtaxpercent,
*****             referencedocumenttype          TYPE i_journalentry-referencedocumenttype,
*****             originalreferencedocument      TYPE i_br_nfitem-br_nfsourcedocumentnumber,
*****             netduedate                     TYPE i_journalentryitem-netduedate,
*****
*****           END OF ty_tax_item,
*****
*****      "*----------------------------------------------------------------------
*****      "* Raw withholding tax item + journal entry data
*****      "*----------------------------------------------------------------------
*****      BEGIN OF ty_wit_data,
*****        companycode                   TYPE i_withholdingtaxitem-companycode,
*****        accountingdocument            TYPE i_withholdingtaxitem-accountingdocument,
*****        fiscalyear                    TYPE i_withholdingtaxitem-fiscalyear,
*****        accountingdocumentitem        TYPE i_withholdingtaxitem-accountingdocumentitem,
*****        withholdingtaxtype            TYPE i_withholdingtaxitem-withholdingtaxtype,
*****        withholdingtaxcode            TYPE i_withholdingtaxitem-withholdingtaxcode,
*****        whldgtaxbaseamtincocodecrcy   TYPE i_withholdingtaxitem-whldgtaxbaseamtincocodecrcy,
*****        whldgtaxamtintransaccrcy      TYPE i_withholdingtaxitem-whldgtaxamtintransaccrcy,
*****        clearingdate                  TYPE i_withholdingtaxitem-clearingdate,
*****        clearingaccountingdocument    TYPE i_withholdingtaxitem-clearingaccountingdocument,
*****        withholdingtaxpercent         TYPE i_withholdingtaxitem-withholdingtaxpercent,
*****        referencedocumenttype         TYPE i_journalentry-referencedocumenttype,
*****        originalreferencedocument     TYPE i_br_nfitem-br_nfsourcedocumentnumber,
*****        netduedate                    TYPE i_journalentryitem-netduedate,
*****      END OF ty_wit_data,
*****
*****      ty_t_wit_data TYPE STANDARD TABLE OF ty_wit_data WITH NON-UNIQUE DEFAULT KEY,
*****
*****      "*----------------------------------------------------------------------
*****      "* NF document data
*****      "*----------------------------------------------------------------------
*****      BEGIN OF ty_nf_data,
*****        br_notafiscal                TYPE i_br_nfitem-br_notafiscal,
*****        br_notafiscalitem            TYPE i_br_nfitem-br_notafiscalitem,
*****        br_nfsourcedocumenttype      TYPE i_br_nfitem-br_nfsourcedocumenttype,
*****        br_nfsourcedocumentnumber    TYPE i_br_nfitem-br_nfsourcedocumentnumber,
*****        br_nfsourcedocumentitem      TYPE i_br_nfitem-br_nfsourcedocumentitem,
*****        br_nftype                    TYPE i_br_nfdocument-br_nftype,
*****        br_nfdirection               TYPE i_br_nfdocument-br_nfdirection,
*****        br_nfissuedate               TYPE i_br_nfdocument-br_nfissuedate,
*****        br_nfmodel                   TYPE i_br_nfdocument-br_nfmodel,
*****        br_nfseries                  TYPE i_br_nfdocument-br_nfseries,
*****        br_nfsubseries               TYPE i_br_nfdocument-br_nfsubseries,
*****        br_nfnumber                  TYPE i_br_nfdocument-br_nfnumber,
*****        businessplace                TYPE i_br_nfdocument-businessplace,
*****        br_nfpartnerfunction         TYPE i_br_nfdocument-br_nfpartnerfunction,
*****        br_nfpartner                 TYPE i_br_nfdocument-br_nfpartner,
*****        br_nfpartnertype             TYPE i_br_nfdocument-br_nfpartnertype,
*****        br_nfiscanceled              TYPE i_br_nfdocument-br_nfiscanceled,
*****        br_nfsnumber                 TYPE i_br_nfdocument-br_nfsnumber,
*****        br_isnfe                     TYPE i_br_nfdocument-br_isnfe,
*****        br_nfenumber                 TYPE i_br_nfdocument-br_nfenumber,
*****        br_nfhasserviceitem          TYPE i_br_nfdocument-br_nfhasserviceitem,
*****        br_nfissuedby                TYPE i_br_nfdocument-br_nfissuedby,
*****        br_nfsituationcode           TYPE i_br_nfdocument-br_nfsituationcode,
*****        br_taxtype                   TYPE i_br_nftax-br_taxtype,
*****        br_nfitembaseamount          TYPE i_br_nftax-br_nfitembaseamount,
*****        br_nfitemtaxrate             TYPE i_br_nftax-br_nfitemtaxrate,
*****        br_nfitemtaxamount           TYPE i_br_nftax-br_nfitemtaxamount,
*****        br_nfitemwhldgcollectioncode TYPE i_br_nftax-br_nfitemwhldgcollectioncode,
*****        taxgroup                     TYPE i_br_nftax-taxgroup,
*****        br_businessplacecnpj         TYPE i_br_nfdocument-br_businessplacecnpj,
*****        br_nfpartnercnpj             TYPE i_br_nfdocument-br_nfpartnercnpj,
*****        br_nfpartnername1            TYPE i_br_nfdocument-br_nfpartnername1,
*****        br_lc116servicecode          TYPE i_br_nfitem-br_lc116servicecode,
*****        br_nftotalamount             TYPE i_br_nfdocument-br_nftotalamount,
*****      END OF ty_nf_data,
*****      ty_t_nf_data TYPE STANDARD TABLE OF ty_nf_data WITH NON-UNIQUE DEFAULT KEY,
*****
*****      "*----------------------------------------------------------------------
*****      "* KNW_R2010 – header: one per NF document (aggregated)
*****      "*----------------------------------------------------------------------
*****      BEGIN OF ty_r2010,
*****        cd_empresa          TYPE string,
*****        cd_filial           TYPE string,
*****        id_referencia       TYPE string,
*****        dm_retificacao      TYPE string,
*****        dt_apuracao         TYPE string,
*****        dm_inscricao_obra   TYPE string,
*****        nr_inscricao_obra   TYPE string,
*****        dm_obra             TYPE string,
*****        nr_cnpj_prestador   TYPE string,
*****        vl_total_bruto      TYPE p LENGTH 15 DECIMALS 2,
*****        vl_total_base       TYPE p LENGTH 15 DECIMALS 2,
*****        vl_total_retencao   TYPE p LENGTH 15 DECIMALS 2,
*****        vl_tot_retencao_adic TYPE p LENGTH 15 DECIMALS 2,
*****        vl_tot_ret_nao_efet TYPE p LENGTH 15 DECIMALS 2,
*****        vl_tot_ret_nefe_adic TYPE p LENGTH 15 DECIMALS 2,
*****        dm_cprb             TYPE string,
*****      END OF ty_r2010,
*****
*****      "*----------------------------------------------------------------------
*****      "* KNW_R2010_NOTA – one per NF item
*****      "*----------------------------------------------------------------------
*****      BEGIN OF ty_r2010_nota,
*****        cd_empresa    TYPE string,
*****        cd_filial     TYPE string,
*****        id_referencia TYPE string,
*****        nr_item_nota  TYPE string,
*****        nr_serie      TYPE string,
*****        nr_documento  TYPE string,
*****        dt_emissao    TYPE string,
*****        vl_bruto      TYPE p LENGTH 15 DECIMALS 2,
*****        ds_observacao TYPE string,
*****      END OF ty_r2010_nota,
*****
*****      "*----------------------------------------------------------------------
*****      "* KNW_R2010_SERVICO – one per service/tax line inside an NF item
*****      "*----------------------------------------------------------------------
*****      BEGIN OF ty_r2010_servico,
*****        cd_empresa       TYPE string,
*****        cd_filial        TYPE string,
*****        id_referencia    TYPE string,
*****        nr_item_nota     TYPE string,
*****        nr_item_servico  TYPE string,
*****        cd_tipo_servico  TYPE string,
*****        vl_base_retencao TYPE p LENGTH 15 DECIMALS 2,
*****        vl_retencao      TYPE p LENGTH 15 DECIMALS 2,
*****      END OF ty_r2010_servico,
*****
*****      "*----------------------------------------------------------------------
*****      "* Complete payload object: 1 header + 1 nota + 1 serviço
*****      "*----------------------------------------------------------------------
*****      BEGIN OF ty_objeto,
*****        knw_r2010         TYPE ty_r2010,
*****        knw_r2010_nota    TYPE ty_r2010_nota,
*****        knw_r2010_servico TYPE ty_r2010_servico,
*****      END OF ty_objeto,
*****
*****
*****      ty_t_objetos TYPE STANDARD TABLE OF ty_objeto WITH NON-UNIQUE DEFAULT KEY,
*****
*****      BEGIN OF ty_companycode,
*****        companycode     TYPE i_companycode-companycode,
*****        companycodename TYPE i_companycode-companycodename,
*****      END OF ty_companycode.
*****      TYPES: BEGIN OF ty_knw_r2010,
*****             cd_empresa           TYPE string,
*****             cd_filial            TYPE string,
*****             id_referencia        TYPE string,
*****             dm_retificacao       TYPE string,
*****             dt_apuracao          TYPE string,
*****             dm_inscricao_obra    TYPE string,
*****             nr_inscricao_obra    TYPE string,
*****             dm_obra              TYPE string,
*****             nr_cnpj_prestador    TYPE string,
*****             vl_total_bruto       TYPE string,
*****             vl_total_base        TYPE string,
*****             vl_total_retencao    TYPE string,
*****             vl_tot_retencao_adic TYPE string,
*****             vl_tot_ret_nao_efet  TYPE string,
*****             vl_tot_ret_nefe_adic TYPE string,
*****             dm_cprb              TYPE string,
*****           END OF ty_knw_r2010.
*****
*****    TYPES: BEGIN OF ty_knw_r2010_nota,
*****             cd_empresa    TYPE string,
*****             cd_filial     TYPE string,
*****             id_referencia TYPE string,
*****             nr_item_nota  TYPE string,
*****             nr_serie      TYPE string,
*****             nr_documento  TYPE string,
*****             dt_emissao    TYPE string,
*****             vl_bruto      TYPE string,
*****             ds_observacao TYPE string,
*****           END OF ty_knw_r2010_nota.
*****
*****    TYPES: BEGIN OF ty_knw_r2010_servico,
*****             cd_empresa       TYPE string,
*****             cd_filial        TYPE string,
*****             id_referencia    TYPE string,
*****             nr_item_nota     TYPE string,
*****             nr_item_servico  TYPE string,
*****             cd_tipo_servico  TYPE string,
*****             vl_base_retencao TYPE string,
*****             vl_retencao      TYPE string,
*****           END OF ty_knw_r2010_servico.
*****
*****    TYPES: BEGIN OF ty_root_r2010,
*****             knw_r2010         TYPE TABLE OF ty_knw_r2010         WITH DEFAULT KEY,
*****             knw_r2010_nota    TYPE TABLE OF ty_knw_r2010_nota    WITH DEFAULT KEY,
*****             knw_r2010_servico TYPE TABLE OF ty_knw_r2010_servico WITH DEFAULT KEY,
*****           END OF ty_root_r2010.
*****
*****    CLASS-DATA:
*****      sel          TYPE ty_sel,
*****      data_sys     TYPE d,
*****      hora_sys     TYPE t,
*****      gv_proc      TYPE string,
*****      gs_company   TYPE ty_companycode,
*****      gs_branch_sov TYPE /pyxs/sov_branch,
*****      gt_data      TYPE ty_t_wit_data,
*****      gt_nfs       TYPE ty_t_nf_data,
*****      gt_objetos   TYPE ty_t_objetos,
*****      mt_nature        TYPE TABLE OF /pyxs/sov_natren,
*****      mt_irf_types     TYPE TABLE OF /pyxs/sov_taxtype_irf,
*****      ls_root TYPE ty_root_r2010,
*****      lt_root TYPE TABLE OF ty_root_r2010.
*****
*****  PRIVATE SECTION.
*****    CLASS-METHODS:
*****      read_db,
*****      build_objects,
*****      send_integration,
*****
*****      format_amount
*****        IMPORTING
*****          iv_value        TYPE any
*****        RETURNING
*****          VALUE(rv_value) TYPE string,
*****
*****      escape_json
*****        IMPORTING iv_str         TYPE string
*****        RETURNING VALUE(rv_str)  TYPE string,
*****
*****      format_date_yyyymmdd
*****        IMPORTING iv_date        TYPE d
*****        RETURNING VALUE(rv_date) TYPE string,
*****
*****      get_period_limits
*****        IMPORTING iv_anomes      TYPE string
*****        EXPORTING ev_first_day   TYPE d
*****                  ev_last_day    TYPE d,
*****
*****      build_r2010_json
*****        IMPORTING is_r2010       TYPE ty_knw_r2010
*****        RETURNING VALUE(rv_json) TYPE string,
*****
*****      build_nota_json
*****        IMPORTING is_nota        TYPE ty_knw_r2010_nota
*****        RETURNING VALUE(rv_json) TYPE string,
*****
*****      build_servico_json
*****        IMPORTING is_serv        TYPE ty_knw_r2010_servico
*****        RETURNING VALUE(rv_json) TYPE string,
*****
*****      build_payload_json
*****        IMPORTING is_obj         TYPE ty_root_r2010
*****        RETURNING VALUE(rv_json) TYPE string.
*****
*****
*****ENDCLASS.
*****
*****CLASS lhc_sov_reinf_inss IMPLEMENTATION.
*****
*****  METHOD get_instance_authorizations.
*****  ENDMETHOD.
*****
*****  METHOD create.
*****  ENDMETHOD.
*****
*****  METHOD update.
*****  ENDMETHOD.
*****
*****  METHOD delete.
*****  ENDMETHOD.
*****
*****  METHOD read.
*****  ENDMETHOD.
*****
*****  METHOD lock.
*****  ENDMETHOD.
*****
*****  METHOD sendintegration.
*****
*****    DATA(key) = keys[ 1 ].
*****
*****    lcl_process=>data_sys = cl_abap_context_info=>get_system_date( ).
*****    lcl_process=>hora_sys = cl_abap_context_info=>get_system_time( ).
*****
*****    "*--- Mandatory parameters -------------------------------------------
*****    lcl_process=>sel-companycode = keys[ 1 ]-%param-CompanyCode.
*****    lcl_process=>sel-plant       = keys[ 1 ]-%param-BusinessPlace.
*****    lcl_process=>sel-anomes      = keys[ 1 ]-%param-AnoMes.
*****
*****    IF lcl_process=>sel-companycode IS INITIAL OR lcl_process=>sel-plant IS INITIAL.
*****      APPEND VALUE #( %action-sendintegration = if_abap_behv=>mk-on
*****      ) TO failed-/pyxs/sov_reinf_inss.
*****      APPEND VALUE #(
*****        %msg = new_message_with_text(
*****          severity = if_abap_behv_message=>severity-error
*****          text     = 'Empresa e Local de Negócio são obrigatórios' )
*****        %action-sendintegration = if_abap_behv=>mk-on
*****      ) TO reported-/pyxs/sov_reinf_inss.
*****    ENDIF.
*****
*****    CHECK failed-/pyxs/sov_reinf_inss IS INITIAL.
*****
*****
*****    lcl_process=>read_db( ).
*****    lcl_process=>build_objects( ).
*****    lcl_process=>send_integration( ).
*****
*****    APPEND INITIAL LINE TO reported-/pyxs/sov_reinf_inss ASSIGNING FIELD-SYMBOL(<fs>).
*****    <fs>-%cid = key-%cid.
*****    <fs>-%msg = new_message_with_text(
*****                  severity = if_abap_behv_message=>severity-information
*****                  text     = 'Processamento solicitado'
*****                ).
*****
*****    res = VALUE #( FOR log IN /pyxs/bp_sov_reinf_inss=>lt_log (
*****        %cid   = key-%cid
*****        %param = VALUE #( %data = VALUE
*****            #(
*****            id           = log-id
*****            retorno     = log-retorno
*****            evento = log-evento
*****            AnoMes = log-ano_mes
*****            time = log-time
*****             ) )
*****        ) ).
*****
*****  ENDMETHOD.
*****
*****ENDCLASS.
*****
*****CLASS lsc_SOV_REINF_INSS DEFINITION INHERITING FROM cl_abap_behavior_saver.
*****  PROTECTED SECTION.
*****
*****    METHODS finalize          REDEFINITION.
*****    METHODS check_before_save REDEFINITION.
*****    METHODS save              REDEFINITION.
*****    METHODS cleanup           REDEFINITION.
*****    METHODS cleanup_finalize  REDEFINITION.
*****
*****ENDCLASS.
*****
*****CLASS lsc_SOV_REINF_INSS IMPLEMENTATION.
*****
*****  METHOD finalize.
*****  ENDMETHOD.
*****
*****  METHOD check_before_save.
*****  ENDMETHOD.
*****
*****  METHOD save.
*****    MODIFY /pyxs/sov_reinss FROM TABLE
*****      @/pyxs/bp_sov_reinf_inss=>lt_log.
*****    CLEAR /pyxs/bp_sov_reinf_inss=>lt_log.
*****  ENDMETHOD.
*****
*****  METHOD cleanup.
*****    CLEAR /pyxs/bp_sov_reinf_inss=>lt_log.
*****  ENDMETHOD.
*****
*****  METHOD cleanup_finalize.
*****    CLEAR /pyxs/bp_sov_reinf_inss=>lt_log.
*****  ENDMETHOD.
*****
*****ENDCLASS.
*****
*****
*****CLASS lcl_process IMPLEMENTATION.
*****
*****
*****  "*------------------------------------------------------------------------
*****  "* format_amount – packed → "10000.00" (always 2 decimal places)
*****  "*------------------------------------------------------------------------
*****
*****  METHOD format_amount.
*****
*****    DATA(lv_value) = CONV decfloat34( iv_value ).
*****
*****    IF lv_value IS INITIAL.
*****      rv_value = '0.00'.
*****      RETURN.
*****    ENDIF.
*****
*****    rv_value = |{ lv_value DECIMALS = 2 SIGN = LEFT }|.
*****
*****    REPLACE ALL OCCURRENCES OF ',' IN rv_value WITH '.'.
*****
*****
*****  ENDMETHOD.
*****
*****  "*------------------------------------------------------------------------
*****  "* escape_json
*****  "*------------------------------------------------------------------------
*****  METHOD escape_json.
*****    rv_str = iv_str.
*****    REPLACE ALL OCCURRENCES OF `\`  IN rv_str WITH `\\`.
*****    REPLACE ALL OCCURRENCES OF `"`  IN rv_str WITH `\"`.
*****    REPLACE ALL OCCURRENCES OF cl_abap_char_utilities=>cr_lf       IN rv_str WITH `\n`.
*****    REPLACE ALL OCCURRENCES OF cl_abap_char_utilities=>newline      IN rv_str WITH `\n`.
*****    REPLACE ALL OCCURRENCES OF cl_abap_char_utilities=>horizontal_tab IN rv_str WITH `\t`.
*****  ENDMETHOD.
*****
*****  "*------------------------------------------------------------------------
*****  "* format_date_yyyymmdd – TYPE d → "DDMMYYYY" (REINF date format)
*****  "*------------------------------------------------------------------------
*****  METHOD format_date_yyyymmdd.
*****    IF iv_date IS INITIAL.
*****      rv_date = ''.
*****      RETURN.
*****    ENDIF.
*****    " REINF expects DDMMYYYY
*****    rv_date = |{ iv_date+6(2) }{ iv_date+4(2) }{ iv_date+0(4) }|.
*****  ENDMETHOD.
*****
*****  "*------------------------------------------------------------------------
*****  "* get_period_limits
*****  "*------------------------------------------------------------------------
*****  METHOD get_period_limits.
*****    DATA: lv_year       TYPE n LENGTH 4,
*****          lv_month      TYPE n LENGTH 2,
*****          lv_next_month TYPE n LENGTH 2,
*****          lv_next_first TYPE d.
*****
*****    lv_year  = iv_anomes(4).
*****    lv_month = iv_anomes+4(2).
*****    ev_first_day = |{ lv_year }{ lv_month }01|.
*****
*****    IF lv_month = 12.
*****      lv_next_first = |{ lv_year + 1 }0101|.
*****    ELSE.
*****      lv_next_month = lv_month + 1.
*****      lv_next_first = |{ lv_year }{ lv_next_month }01|.
*****    ENDIF.
*****    ev_last_day = lv_next_first - 1.
*****  ENDMETHOD.
*****
*****  "*------------------------------------------------------------------------
*****  "* read_db – withholding tax items + NF documents
*****  "*------------------------------------------------------------------------
*****  METHOD read_db.
*****
*****    "*--- Sovos branch config --------------------------------------------
*****    SELECT SINGLE *
*****      FROM /pyxs/sov_branch
*****      WHERE company_code = @sel-companycode
*****        AND branch       = @sel-plant
*****      INTO @gs_branch_sov.
*****
*****    "*--- Company code ---------------------------------------------------
*****    SELECT SINGLE companycode, companycodename
*****      FROM i_companycode
*****      WHERE companycode = @sel-companycode
*****      INTO @gs_company.
*****
*****    DATA: lr_irf_types TYPE RANGE OF i_withholdingtaxitem-withholdingtaxtype,
*****          lt_data_it   TYPE TABLE OF ty_tax_item.
*****
*****    DATA lr_daterange TYPE RANGE OF i_journalentryitem-ClearingDate.
*****    DATA lv_first_day  TYPE d.
*****    DATA lv_last_day   TYPE d.
*****    DATA lv_next_month TYPE d.
*****        " First day of the month
*****    lv_first_day = |{ sel-anomes }01|.
*****
*****    DATA(lv_year)  = CONV i( sel-anomes(4) ).
*****    DATA(lv_month) = CONV i( sel-anomes+4(2) ).
*****
*****    IF lv_month = 12.
*****      lv_year  += 1.
*****      lv_month = 1.
*****    ELSE.
*****      lv_month += 1.
*****    ENDIF.
*****
*****    lv_next_month = |{ lv_year WIDTH = 4 PAD = '0' }{ lv_month WIDTH = 2 PAD = '0' }01|.
*****
*****    lv_last_day = lv_next_month - 1.
*****
*****    APPEND VALUE #(
*****      sign   = 'I'
*****      option = 'BT'
*****      low    = lv_first_day
*****      high   = lv_last_day
*****    ) TO lr_daterange.
*****
*****    SELECT * FROM /pyxs/sov_taxtype_irf INTO TABLE @mt_irf_types.
*****    SELECT * FROM /pyxs/sov_natren INTO TABLE @mt_nature.
*****
*****    LOOP AT mt_irf_types INTO DATA(ls_irf_type).
*****      CHECK ls_irf_type-imposto <> 'INSS'.
*****      APPEND VALUE #( sign = 'I' option = 'EQ' low = ls_irf_type-categoriairf ) TO lr_irf_types.
*****    ENDLOOP.
*****
*****    IF lr_irf_types IS NOT INITIAL.
*****
*****      SELECT wit~companycode, wit~accountingdocument, wit~fiscalyear, wit~accountingdocumentitem,
*****             wit~withholdingtaxtype, wit~withholdingtaxcode, wit~whldgtaxbaseamtincocodecrcy,
*****             wit~whldgtaxamtintransaccrcy, joi~clearingdate, wit~clearingaccountingdocument,
*****             wit~withholdingtaxpercent, jo~referencedocumenttype, jo~originalreferencedocument, joi~netduedate
*****       FROM i_withholdingtaxitem AS wit
*****       INNER JOIN i_journalentry AS jo
*****       ON wit~companycode = jo~companycode
*****       AND wit~accountingdocument = jo~accountingdocument
*****       AND wit~fiscalyear = jo~fiscalyear
*****       INNER JOIN i_journalentryitem AS joi
*****       ON wit~companycode = joi~companycode
*****       AND wit~accountingdocument = joi~accountingdocument
*****       AND wit~fiscalyear = joi~fiscalyear
*****       AND wit~accountingdocumentitem = joi~accountingdocumentitem
*****       WHERE wit~whldgtaxbaseamtincocodecrcy <> 0
*****         AND joi~clearingdate IN @lr_daterange
*****         AND wit~companycode = @sel-companycode
*****         AND joi~ledger      = '0L'
*****         AND wit~withholdingtaxtype IN @lr_irf_types
*****       INTO TABLE @gt_data.
*****
*****      IF gt_data IS NOT INITIAL.
*****        SELECT nfi~br_notafiscal, nfi~br_notafiscalitem, nfi~br_nfsourcedocumenttype, nfi~br_nfsourcedocumentnumber, "#EC CI_NO_TRANSFORM
*****              nfi~br_nfsourcedocumentitem, nf~br_nftype, nf~br_nfdirection, nf~br_nfissuedate, nf~br_nfmodel,
*****              nf~br_nfseries, nf~br_nfsubseries, nf~br_nfnumber, nf~businessplace,
*****              nf~br_nfpartnerfunction, nf~br_nfpartner, nf~br_nfpartnertype,
*****              nf~br_nfiscanceled, nf~br_nfsnumber, nf~br_isnfe, nf~br_nfenumber,
*****              nf~br_nfhasserviceitem, nf~br_nfissuedby, nf~br_nfsituationcode,
*****              nft~br_taxtype, nft~br_nfitembaseamount, nft~br_nfitemtaxrate,
*****              nft~br_nfitemtaxamount, nft~br_nfitemwhldgcollectioncode, nft~taxgroup, nf~br_businessplacecnpj, nf~br_nfpartnercnpj,
*****              nf~br_nfpartnername1, nfi~br_lc116servicecode, nf~br_nftotalamount
*****         FROM i_br_nfitem AS nfi
******     ON jo~OriginalReferenceDocument = nfi~BR_NFSourceDocumentNumber
*****         INNER JOIN i_br_nfdocument AS nf
*****                 ON nf~br_notafiscal = nfi~br_notafiscal
*****         INNER JOIN i_br_nftax AS nft
*****                 ON nf~br_notafiscal = nft~br_notafiscal
*****                AND nfi~br_notafiscalitem = nft~br_notafiscalitem
*****                FOR ALL ENTRIES IN @gt_data
*****             WHERE nfi~br_nfsourcedocumentnumber  = @gt_data-originalreferencedocument
*****               AND nf~businessplace               = @sel-plant
*****               "AND nf~br_nfpartner                IN @sel-
*****               "AND nf~br_notafiscal               IN @sel-br_notafiscal
*****               "AND nft~br_nfitemhaswithholdingtax = 'X'
*****         INTO TABLE @gt_nfs.
*****      ENDIF.
*****    ENDIF.
*****
*****    SORT gt_data BY companycode accountingdocument fiscalyear accountingdocumentitem.
*****
*****  ENDMETHOD.
*****
*****  "*------------------------------------------------------------------------
*****  "* build_objects – maps gt_data + gt_nfs into gt_objetos
*****  "*------------------------------------------------------------------------
*****  METHOD build_objects.
*****" =========================================================
*****    " Tipos para R2010
*****    " =========================================================
*****    TYPES: BEGIN OF ty_seq_nota,
*****             id  TYPE string,
*****             seq TYPE i,
*****           END OF ty_seq_nota.
*****
*****    TYPES: BEGIN OF ty_seq_servico,
*****             id  TYPE string,
*****             seq TYPE i,
*****           END OF ty_seq_servico.
*****
*****    DATA: gt_seq_nota    TYPE STANDARD TABLE OF ty_seq_nota    WITH KEY id,
*****          gt_seq_servico TYPE STANDARD TABLE OF ty_seq_servico WITH KEY id.
*****
*****    DATA: lv_prev_partner TYPE i_br_nfdocument-br_nfpartner.
*****
*****    LOOP AT gt_data INTO DATA(ls_data).
*****
*****      READ TABLE gt_nfs WITH KEY br_nfsourcedocumentnumber = ls_data-originalreferencedocument
*****                        INTO DATA(ls_nfs).
*****      CHECK sy-subrc = 0.
*****
*****      " Determina a natureza do rendimento via mt_nature
*****      READ TABLE mt_nature INTO DATA(ls_nat) WITH KEY lc116 = ls_nfs-br_lc116servicecode.
*****      IF sy-subrc <> 0.
*****        CLEAR ls_root.
*****        RETURN.
*****      ENDIF.
*****      DATA(lv_cd_tipo_servico) = ls_nat-nat_res.
*****
*****      " -------------------------------------------------------
*****      " Chaves de agrupamento
*****      " -------------------------------------------------------
*****      " R2010 agrupa por: filial/estabelecimento + CNPJ prestador + período
*****      DATA(lv_id_r2010) = |{ ls_data-clearingdate(6) }{ ls_nfs-br_nfpartner }|.
*****
*****      " Chave da nota: id_r2010 + número do documento fiscal
*****      DATA(lv_id_nota) = |{ lv_id_r2010 }{ ls_nfs-br_nfnumber }{ ls_nfs-br_nfseries }|.
*****
*****      " Chave do serviço: id_nota + tipo de serviço
*****      DATA(lv_id_servico) = |{ lv_id_nota }{ lv_cd_tipo_servico }|.
*****
*****      " -------------------------------------------------------
*****      " Sequencial NR_ITEM_NOTA dentro do mesmo R2010
*****      " -------------------------------------------------------
*****      READ TABLE gt_seq_nota WITH KEY id = lv_id_nota ASSIGNING FIELD-SYMBOL(<ls_seq_nota>).
*****      IF sy-subrc = 0.
*****        " Nota já registrada — reutiliza o sequencial
*****        DATA(lv_nr_item_nota) = <ls_seq_nota>-seq.
*****      ELSE.
*****        " Nova nota: conta quantas notas esse R2010 já tem
*****        DATA(lv_count_nota) = REDUCE i(
*****          INIT n = 0
*****          FOR ls_sn IN gt_seq_nota
*****          WHERE ( id CS lv_id_r2010 )
*****          NEXT n = n + 1
*****        ).
*****        lv_nr_item_nota = lv_count_nota + 1.
*****        INSERT VALUE #( id = lv_id_nota seq = lv_nr_item_nota ) INTO TABLE gt_seq_nota ASSIGNING <ls_seq_nota>.
*****      ENDIF.
*****
*****      " -------------------------------------------------------
*****      " Sequencial NR_ITEM_SERVICO dentro da mesma nota
*****      " -------------------------------------------------------
*****      READ TABLE gt_seq_servico WITH KEY id = lv_id_servico ASSIGNING FIELD-SYMBOL(<ls_seq_servico>).
*****      IF sy-subrc = 0.
*****        DATA(lv_nr_item_servico) = <ls_seq_servico>-seq.
*****      ELSE.
*****        DATA(lv_count_serv) = REDUCE i(
*****          INIT n = 0
*****          FOR ls_ss IN gt_seq_servico
*****          WHERE ( id CS lv_id_nota )
*****          NEXT n = n + 1
*****        ).
*****        lv_nr_item_servico = lv_count_serv + 1.
*****        INSERT VALUE #( id = lv_id_servico seq = lv_nr_item_servico ) INTO TABLE gt_seq_servico ASSIGNING <ls_seq_servico>.
*****      ENDIF.
*****
*****      " -------------------------------------------------------
*****      " KNW_R2010  (cabeçalho — um por CNPJ prestador/período)
*****      " -------------------------------------------------------
*****      READ TABLE ls_root-knw_r2010 ASSIGNING FIELD-SYMBOL(<ls_knw_r2010>)
*****           WITH KEY id_referencia = lv_id_r2010.
*****      IF sy-subrc IS NOT INITIAL.
*****        APPEND INITIAL LINE TO ls_root-knw_r2010 ASSIGNING <ls_knw_r2010>.
*****        <ls_knw_r2010>-cd_empresa          = gs_branch_sov-sov_company.
*****        <ls_knw_r2010>-cd_filial           = gs_branch_sov-sov_branch.
*****        <ls_knw_r2010>-id_referencia       = lv_id_r2010.
*****        <ls_knw_r2010>-dm_retificacao      = '1'.
*****        <ls_knw_r2010>-dt_apuracao         = ls_data-clearingdate.
*****        <ls_knw_r2010>-dm_inscricao_obra   = ' '.          " Ajustar conforme regra de negócio
*****        <ls_knw_r2010>-nr_inscricao_obra   = ' '. " CNPJ do estabelecimento contratante
*****        <ls_knw_r2010>-dm_obra             = '0'.          " 0 = Não é obra de construção civil
*****        <ls_knw_r2010>-nr_cnpj_prestador   = ls_nfs-br_nfpartnercnpj.
*****        " Totais acumulados — serão somados nos blocos abaixo
*****        <ls_knw_r2010>-vl_tot_ret_nao_efet = '0.00'.
*****        <ls_knw_r2010>-vl_tot_ret_nefe_adic = format_amount( iv_value = ls_nfs-br_nftotalamount ).
*****        <ls_knw_r2010>-dm_cprb             = '0'.
*****      ENDIF.
*****
*****      " -------------------------------------------------------
*****      " KNW_R2010_NOTA  (uma por NF dentro do R2010)
*****      " -------------------------------------------------------
*****      READ TABLE ls_root-knw_r2010_nota ASSIGNING FIELD-SYMBOL(<ls_knw_r2010_nota>)
*****           WITH KEY id_referencia = lv_id_nota.
*****      IF sy-subrc IS NOT INITIAL.
*****        APPEND INITIAL LINE TO ls_root-knw_r2010_nota ASSIGNING <ls_knw_r2010_nota>.
*****        <ls_knw_r2010_nota>-cd_empresa    = gs_branch_sov-sov_company.
*****        <ls_knw_r2010_nota>-cd_filial     = gs_branch_sov-sov_branch.
*****        <ls_knw_r2010_nota>-id_referencia = lv_id_nota.
*****        <ls_knw_r2010_nota>-nr_item_nota  = lv_nr_item_nota.
*****        <ls_knw_r2010_nota>-nr_serie      = ls_nfs-br_nfseries.
*****        <ls_knw_r2010_nota>-nr_documento  = ls_nfs-br_nfnumber.
*****        <ls_knw_r2010_nota>-dt_emissao    = ls_nfs-br_nfissuedate.
*****        <ls_knw_r2010_nota>-vl_bruto      = format_amount( iv_value = ls_nfs-br_nftotalamount ).
*****        <ls_knw_r2010_nota>-ds_observacao = |Doc contábil { ls_data-accountingdocument }|.
*****      ENDIF.
*****
*****      " -------------------------------------------------------
*****      " KNW_R2010_SERVICO  (um por tipo de serviço dentro da nota)
*****      " -------------------------------------------------------
*****      READ TABLE ls_root-knw_r2010_servico ASSIGNING FIELD-SYMBOL(<ls_knw_r2010_servico>)
*****           WITH KEY id_referencia = lv_id_servico.
*****      IF sy-subrc IS NOT INITIAL.
*****        APPEND INITIAL LINE TO ls_root-knw_r2010_servico ASSIGNING <ls_knw_r2010_servico>.
*****        <ls_knw_r2010_servico>-cd_empresa        = gs_branch_sov-sov_company.
*****        <ls_knw_r2010_servico>-cd_filial         = gs_branch_sov-sov_branch.
*****        <ls_knw_r2010_servico>-id_referencia     = lv_id_servico.
*****        <ls_knw_r2010_servico>-nr_item_nota      = lv_nr_item_nota.
*****        <ls_knw_r2010_servico>-nr_item_servico   = lv_nr_item_servico.
*****        <ls_knw_r2010_servico>-cd_tipo_servico   = lv_cd_tipo_servico.
*****        <ls_knw_r2010_servico>-vl_base_retencao  = format_amount( iv_value = abs( ls_data-whldgtaxbaseamtincocodecrcy ) ).
*****        <ls_knw_r2010_servico>-vl_retencao       = format_amount( iv_value = abs( ls_data-whldgtaxamtintransaccrcy ) ).
*****      ELSE.
*****        " Mesmo serviço, nova linha de imposto: acumula base e retenção
*****        <ls_knw_r2010_servico>-vl_base_retencao += abs( ls_data-whldgtaxbaseamtincocodecrcy ).
*****        <ls_knw_r2010_servico>-vl_retencao      += abs( ls_data-whldgtaxamtintransaccrcy ).
*****      ENDIF.
*****
*****      " -------------------------------------------------------
*****      " Acumula totais no cabeçalho R2010
*****      " (re-lê com ASSIGNING para garantir o ponteiro atualizado)
*****      " -------------------------------------------------------
*****      READ TABLE ls_root-knw_r2010 ASSIGNING <ls_knw_r2010>
*****           WITH KEY id_referencia = lv_id_r2010.
*****      IF sy-subrc = 0.
*****        <ls_knw_r2010>-vl_total_bruto     += abs( ls_nfs-br_nftotalamount ).
*****        <ls_knw_r2010>-vl_total_base      += abs( ls_data-whldgtaxbaseamtincocodecrcy ).
*****        <ls_knw_r2010>-vl_total_retencao  += abs( ls_data-whldgtaxamtintransaccrcy ).
*****        " vl_tot_retencao_adic: preencher se houver adicional de retenção na regra de negócio
*****        <ls_knw_r2010>-vl_tot_retencao_adic = '0.00'. " ajustar se necessário
*****      ENDIF.
*****
*****      IF ls_root IS NOT INITIAL.
*****        APPEND ls_root TO lt_root.
*****        CLEAR: ls_root.
*****      ENDIF.
*****
*****
*****    ENDLOOP.
*****
*****  ENDMETHOD.
*****
*****  "*------------------------------------------------------------------------
*****  "* JSON builders
*****  "*------------------------------------------------------------------------
*****  METHOD build_r2010_json.
*****    rv_json =
*****      |\{| &&
*****        |"CD_EMPRESA":"{ escape_json( is_r2010-cd_empresa ) }",| &&
*****        |"CD_FILIAL":"{ escape_json( is_r2010-cd_filial ) }",| &&
*****        |"ID_REFERENCIA":"{ escape_json( is_r2010-id_referencia ) }",| &&
*****        |"DM_RETIFICACAO":"{ escape_json( is_r2010-dm_retificacao ) }",| &&
*****        |"DT_APURACAO":"{ escape_json( is_r2010-dt_apuracao ) }",| &&
*****        |"DM_INSCRICAO_OBRA":"{ escape_json( is_r2010-dm_inscricao_obra ) }",| &&
*****        |"NR_INSCRICAO_OBRA":"{ escape_json( is_r2010-nr_inscricao_obra ) }",| &&
*****        |"DM_OBRA":"{ escape_json( is_r2010-dm_obra ) }",| &&
*****        |"NR_CNPJ_PRESTADOR":"{ escape_json( is_r2010-nr_cnpj_prestador ) }",| &&
*****        |"VL_TOTAL_BRUTO":"{ format_amount( is_r2010-vl_total_bruto ) }",| &&
*****        |"VL_TOTAL_BASE":"{ format_amount( is_r2010-vl_total_base ) }",| &&
*****        |"VL_TOTAL_RETENCAO":"{ format_amount( is_r2010-vl_total_retencao ) }",| &&
*****        |"VL_TOT_RETENCAO_ADIC":"{ format_amount( is_r2010-vl_tot_retencao_adic ) }",| &&
*****        |"VL_TOT_RET_NAO_EFET":"{ format_amount( is_r2010-vl_tot_ret_nao_efet ) }",| &&
*****        |"VL_TOT_RET_NEFE_ADIC":"{ format_amount( is_r2010-vl_tot_ret_nefe_adic ) }",| &&
*****        |"DM_CPRB":"{ escape_json( is_r2010-dm_cprb ) }"| &&
*****      |\}|.
*****  ENDMETHOD.
*****
*****  METHOD build_nota_json.
*****    rv_json =
*****      |\{| &&
*****        |"CD_EMPRESA":"{ escape_json( is_nota-cd_empresa ) }",| &&
*****        |"CD_FILIAL":"{ escape_json( is_nota-cd_filial ) }",| &&
*****        |"ID_REFERENCIA":"{ escape_json( is_nota-id_referencia ) }",| &&
*****        |"NR_ITEM_NOTA":"{ escape_json( is_nota-nr_item_nota ) }",| &&
*****        |"NR_SERIE":"{ escape_json( is_nota-nr_serie ) }",| &&
*****        |"NR_DOCUMENTO":"{ escape_json( is_nota-nr_documento ) }",| &&
*****        |"DT_EMISSAO":"{ escape_json( is_nota-dt_emissao ) }",| &&
*****        |"VL_BRUTO":"{ format_amount( is_nota-vl_bruto ) }",| &&
*****        |"DS_OBSERVACAO":"{ escape_json( is_nota-ds_observacao ) }"| &&
*****      |\}|.
*****  ENDMETHOD.
*****
*****  METHOD build_servico_json.
*****    rv_json =
*****      |\{| &&
*****        |"CD_EMPRESA":"{ escape_json( is_serv-cd_empresa ) }",| &&
*****        |"CD_FILIAL":"{ escape_json( is_serv-cd_filial ) }",| &&
*****        |"ID_REFERENCIA":"{ escape_json( is_serv-id_referencia ) }",| &&
*****        |"NR_ITEM_NOTA":"{ escape_json( is_serv-nr_item_nota ) }",| &&
*****        |"NR_ITEM_SERVICO":"{ escape_json( is_serv-nr_item_servico ) }",| &&
*****        |"CD_TIPO_SERVICO":"{ escape_json( is_serv-cd_tipo_servico ) }",| &&
*****        |"VL_BASE_RETENCAO":"{ format_amount( is_serv-vl_base_retencao ) }",| &&
*****        |"VL_RETENCAO":"{ format_amount( is_serv-vl_retencao ) }"| &&
*****      |\}|.
*****  ENDMETHOD.
*****
*****  METHOD build_payload_json.
*****    " Target structure (one flat object per call, matching the spec):
*****    " { "KNW_R2010": {...}, "KNW_R2010_NOTA": {...}, "KNW_R2010_SERVICO": {...} }
*****    rv_json =
*****      |\{| &&
*****        |"KNW_R2010":{ build_r2010_json( is_obj-knw_r2010 ) },| &&
*****        |"KNW_R2010_NOTA":{ build_nota_json( is_obj-knw_r2010_nota ) },| &&
*****        |"KNW_R2010_SERVICO":{ build_servico_json( is_obj-knw_r2010_servico ) }| &&
*****      |\}|.
*****  ENDMETHOD.
*****
*****  "*------------------------------------------------------------------------
*****  "* send_integration – POST each payload to Sovos
*****  "*------------------------------------------------------------------------
*****  METHOD send_integration.
*****
*****    DATA: lo_ret     TYPE REF TO data,
*****          lv_sucesso TYPE abap_boolean.
*****
*****    LOOP AT lt_root INTO DATA(ls_root).
*****
*****      DATA(lv_json) = build_payload_json( ls_root ).
*****
*****      " Apply any Sovos-specific JSON transformations
*****      lv_json = /pyxs/sov_json_conversion=>convert_sovos( lv_json ).
*****
*****      "*--- Resolve communication arrangement ----------------------------
*****      DATA lr_cscn TYPE if_com_scenario_factory=>ty_query-cscn_id_range.
*****      lr_cscn = VALUE #( ( sign = 'I' option = 'EQ' low = '/PYXS/SOVOS' ) ).
*****
*****      DATA(lo_factory) = cl_com_arrangement_factory=>create_instance( ).
*****      lo_factory->query_ca(
*****        EXPORTING
*****          is_query           = VALUE #( cscn_id_range = lr_cscn )
*****        IMPORTING
*****          et_com_arrangement = DATA(lt_ca) ).
*****
*****      IF lt_ca IS INITIAL.
*****        APPEND INITIAL LINE TO /pyxs/bp_sov_reinf_inss=>lt_log ASSIGNING FIELD-SYMBOL(<log>).
*****        GET TIME STAMP FIELD DATA(time).
*****        <log>-time     = time.
*****        <log>-ano_mes       = sel-anomes.
*****        <log>-retorno     = 'Cenário de comunicação não encontrado'.
*****        <log>-resultado   = '999'.
*****        EXIT.
*****      ENDIF.
*****
*****      READ TABLE lt_ca INTO DATA(lo_ca) INDEX 1.
*****
*****      TRY.
*****          DATA(lo_dest) = cl_http_destination_provider=>create_by_comm_arrangement(
*****              comm_scenario  = '/PYXS/SOVOS'
*****              service_id     = '/PYXS/SOV_REINF2_REST'
*****              comm_system_id = lo_ca->get_comm_system_id( ) ).
*****
*****          DATA(lo_http_client) = cl_web_http_client_manager=>create_by_http_destination( lo_dest ).
*****          DATA(lo_request)     = lo_http_client->get_http_request( ).
*****
*****          lo_request->set_text( i_text = lv_json ).
*****
*****          lo_request->set_uri_path( i_uri_path = 'R2010' ).
*****
*****          DATA(lo_response) = lo_http_client->execute( if_web_http_client=>post ).
*****          DATA(lv_ret)      = lo_response->get_status( ).
*****          CLEAR lo_ret.
*****
*****          IF lv_ret-code = '200'.
*****            DATA(lv_msg) = lo_response->get_text( ).
*****            IF lv_msg IS INITIAL.
*****              gv_proc = 'Successfully processed'(002).
*****            ELSE.
*****              gv_proc = lv_msg.
*****              /ui2/cl_json=>deserialize(
*****                EXPORTING json = gv_proc
*****                CHANGING  data = lo_ret ).
*****              lv_sucesso = lo_ret->('SUCESSO')->*.
*****              IF lv_sucesso = abap_true.
*****                gv_proc = 'Successfully processed'(002).
*****              ELSE.
*****                lv_ret-code = 400.
*****              ENDIF.
*****            ENDIF.
*****          ELSE.
*****            gv_proc = lo_response->get_text( ).
*****          ENDIF.
*****
*****        CATCH cx_web_message_error.
*****        CATCH cx_http_dest_provider_error.
*****        CATCH cx_web_http_client_error.
*****      ENDTRY.
*****
*****      GET TIME STAMP FIELD time.
*****
*****      IF lo_ret IS INITIAL.
*****        APPEND INITIAL LINE TO /pyxs/bp_sov_reinf_inss=>lt_log ASSIGNING <log>.
*****        <log>-time      = time.
*****        <log>-ano_mes       = sel-anomes.
*****        <log>-retorno     = |Erro no serviço: { gv_proc }|.
*****        <log>-evento   = lv_ret-code.
*****        <log>-resultado = lv_ret-reason.
*****      ELSE.
*****        LOOP AT lo_ret->('MENSAGENS')->* ASSIGNING FIELD-SYMBOL(<lv_msg>).
*****          APPEND INITIAL LINE TO /pyxs/bp_sov_reinf_inss=>lt_log ASSIGNING <log>.
*****        <log>-time      = time.
*****        <log>-ano_mes       = sel-anomes.
*****        <log>-retorno     = |Erro no serviço: { gv_proc }|.
*****        <log>-evento   = lv_ret-code.
*****        <log>-resultado = lv_ret-reason.
*****        ENDLOOP.
*****      ENDIF.
*****
*****    ENDLOOP.
*****
*****  ENDMETHOD.
*****
*****
*****  "*------------------------------------------------------------------------
*****  "* main – direct test entry point (no RAP)
*****  "*------------------------------------------------------------------------
*****  METHOD main.
*****    data_sys = cl_abap_context_info=>get_system_date( ).
*****    hora_sys = cl_abap_context_info=>get_system_time( ).
*****    read_db( ).
*****    build_objects( ).
*****    send_integration( ).
*****  ENDMETHOD.
*****
*****
*****ENDCLASS.