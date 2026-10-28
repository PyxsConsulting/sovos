CLASS /pyxs/sovos_reinf_4020builder DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES: ty_reinf TYPE STANDARD TABLE OF /pyxs/sov_reinf WITH DEFAULT KEY.

    TYPES: BEGIN OF ty_sel,
             company  TYPE i_br_businessplace-companycode,
             branch   TYPE i_br_businessplace-branch,
             creation TYPE RANGE OF i_br_nfdocument-creationdate,
             category TYPE RANGE OF i_br_nfdocument-br_nfdocumenttype,
             document TYPE RANGE OF i_br_nfdocument-br_notafiscal,
             docdate  TYPE RANGE OF i_br_nfdocument-br_nfissuedate,
             pstdate  TYPE RANGE OF i_br_nfdocument-br_nfpostingdate,
             dsaient  TYPE RANGE OF i_br_nfdocument-br_nfarrivalordeparturedate,
             changed  TYPE RANGE OF i_br_nfdocument-lastchangedate,
             partner  TYPE RANGE OF i_br_nfdocument-br_nfpartner,
           END OF ty_sel.

    DATA:
      mv_br_notafiscal TYPE i_br_nfdocument-br_notafiscal,
      mt_doc           TYPE TABLE OF i_br_nfdocument,
      mt_itm           TYPE TABLE OF i_br_nfitem,
      mt_tax           TYPE TABLE OF i_br_nftax,
      mt_nature        TYPE TABLE OF /pyxs/sov_natren,
      gs_branch_sov    TYPE /pyxs/sov_branch,
      gs_branch_main TYPE i_addlcompanycodeinformation,
      sel              TYPE ty_sel,
      mt_ret           TYPE ty_reinf,
      mt_irf_types     TYPE TABLE OF /pyxs/sov_taxtype_irf.
    TYPES            ty_amount TYPE p LENGTH 16 DECIMALS 2.

    TYPES: BEGIN OF ty_r1000,
             cd_empresa             TYPE string,
             cd_filial              TYPE string,
             cd_operacao            TYPE string,
             dt_inicio_validade     TYPE string,
             dm_inscricao           TYPE string,
             nr_inscricao           TYPE string,
             cd_class_tributaria    TYPE string,
             dm_inscrituracao       TYPE string,
             dm_desoneracao         TYPE string,
             dm_isencao             TYPE string,
             dm_situacao            TYPE string,
             nm_contato             TYPE string,
             nr_cpf_contato         TYPE string,
             nr_telefone_fixo       TYPE string,
             nr_telefone_movel      TYPE string,
             ds_email               TYPE string,
             dm_efr                 TYPE string,
             nr_cnpj_efr            TYPE string,
             nm_razao_social        TYPE string,
             nm_fantasia            TYPE string,
             nr_inscricao_estadual  TYPE string,
             nr_inscricao_municipal TYPE string,
             nr_suframa             TYPE string,
             ds_endereco            TYPE string,
             nr_endereco            TYPE string,
             ds_endereco_compl      TYPE string,
             nr_cep                 TYPE string,
             ds_bairro              TYPE string,
             nr_telefone            TYPE string,
             nr_fax                 TYPE string,
             email                  TYPE string,
             cd_municipio           TYPE string,
             nr_nire                TYPE string,
             dm_regime_especial     TYPE string,
             dm_natureza_pj         TYPE string,
             dm_atividade           TYPE string,
             dm_centralizacao       TYPE string,
             id_referencia          TYPE string,
           END OF ty_r1000.


    TYPES: BEGIN OF ty_knw_r4020,


             cd_empresa         TYPE string,
             cd_filial          TYPE string,
             id_referencia      TYPE string,
             id_evento          TYPE string,
             dm_retificacao     TYPE string,
             nr_recibo          TYPE string,
             dt_apuracao        TYPE string,
             nr_nat_jur         TYPE string,
             dm_inscricao_estab TYPE string,
             nr_inscricao_estab TYPE string,
             nr_cnpj_benef      TYPE string,
             nm_benef           TYPE string,
             dm_isencao_imun    TYPE string,
             ide_evt_adic       TYPE string,
           END OF ty_knw_r4020.

    TYPES: BEGIN OF ty_pgto,
             cd_empresa    TYPE string,
             cd_filial     TYPE string,
             id_referencia TYPE string,
             id_seq_pagto  TYPE string,
             nr_nat_rend   TYPE string,
             ds_observacao TYPE string,
           END OF ty_pgto.

    TYPES: BEGIN OF ty_info_pgto,
             cd_empresa       TYPE string,
             cd_filial        TYPE string,
             id_referencia    TYPE string,
             id_seq_pagto     TYPE string,
             id_seq_info_pgto TYPE string,
             dt_fato_gerador  TYPE string,
             vl_bruto         TYPE string,
             ds_observ        TYPE string,
             dm_fci_scp       TYPE string,
             nr_insc_fci_scp  TYPE string,
             nr_perc_scp      TYPE string,
             dm_jud           TYPE string,
             cd_pais_resid    TYPE string,
             dt_escr_cont     TYPE string,
           END OF ty_info_pgto.

    TYPES: BEGIN OF ty_info_pgto_ret,
             cd_empresa        TYPE string,
             cd_filial         TYPE string,
             id_referencia     TYPE string,
             id_seq_pagto      TYPE string,
             id_seq_info_pgto  TYPE string,
             vl_base_ir        TYPE string,
             vl_ir             TYPE string,
             vl_base_csll      TYPE string,
             vl_csll           TYPE string,
             vl_base_cofins    TYPE string,
             vl_cofins         TYPE string,
             vl_base_pis_pasep TYPE string,
             vl_pis_pasep      TYPE string,
             vl_base_agreg     TYPE string,
             vl_agreg          TYPE string,
           END OF ty_info_pgto_ret.

    TYPES: BEGIN OF ty_root_r4020,
             knwReinfR4020                 TYPE ty_knw_r4020,
             reinfR4020PgtoList            TYPE TABLE OF ty_pgto WITH DEFAULT KEY,
             knwReinfR4020InfoPgtoList     TYPE TABLE OF ty_info_pgto WITH DEFAULT KEY,
             knwReinfR4020InfoPgtoRetList  TYPE TABLE OF ty_info_pgto_ret WITH DEFAULT KEY,
           END OF ty_root_r4020.
**********************************************************************
* R4010 - Pagamentos/créditos a beneficiário pessoa física
**********************************************************************
    TYPES: BEGIN OF ty_knw_r4010,
             cd_empresa         TYPE string,
             cd_filial          TYPE string,
             id_referencia      TYPE string,
             dm_retificacao     TYPE string,
             dt_apuracao        TYPE string,
             nr_nat_jur         TYPE string,
             dm_inscricao_estab TYPE string,
             nr_inscricao_estab TYPE string,
             nr_cnpj_benef      TYPE string,
             nm_benef           TYPE string,
             cd_evt_adic        TYPE string,
           END OF ty_knw_r4010.

    TYPES: BEGIN OF ty_rend_4010,
             cd_empresa    TYPE string,
             cd_filial     TYPE string,
             id_referencia TYPE string,
             nr_item_rend  TYPE string,
             cd_nat_rend   TYPE string,
             ds_observacao TYPE string,
           END OF ty_rend_4010.

    TYPES: BEGIN OF ty_pgto_4010,
             cd_empresa           TYPE string,
             cd_filial            TYPE string,
             id_referencia        TYPE string,
             nr_item_rend         TYPE string,
             nr_item_pgto         TYPE string,
             dt_fato_gerador      TYPE string,
             dt_comp_rendimento   TYPE string,
             dm_dec_terc          TYPE string,
             vl_rend_bruto        TYPE string,
             vl_rend_trib         TYPE string,
             vl_ir                TYPE string,
             dm_ind_rra           TYPE string,
             dm_fci_scp           TYPE string,
             nr_inscricao_fci_scp TYPE string,
             vl_perc_scp          TYPE string,
             dm_indic_judicial    TYPE string,
             cd_pais_resid_ext    TYPE string,
             dt_escr_cont         TYPE string,
             ds_observ            TYPE string,
           END OF ty_pgto_4010.

    TYPES: BEGIN OF ty_pgto_ext_4010,
             cd_empresa         TYPE string,
             cd_filial          TYPE string,
             id_referencia      TYPE string,
             nr_item_rend       TYPE string,
             nr_item_pgto       TYPE string,
             dm_nfi             TYPE string,
             nr_identificao_nfi TYPE string,
             cd_forma_trib      TYPE string,
             ds_logradouro      TYPE string,
             nr_logradouro      TYPE string,
             ds_complemento     TYPE string,
             ds_bairro          TYPE string,
             ds_cidade          TYPE string,
             ds_estado          TYPE string,
             cd_postal          TYPE string,
             nr_telefone        TYPE string,
           END OF ty_pgto_ext_4010.

    TYPES: BEGIN OF ty_rend_isento_4010,
             cd_empresa          TYPE string,
             cd_filial           TYPE string,
             id_referencia       TYPE string,
             nr_item_rend        TYPE string,
             nr_item_pgto        TYPE string,
             nr_item_rend_isento TYPE string,
             dm_tipo_isencao     TYPE string,
             vl_isento           TYPE string,
           END OF ty_rend_isento_4010.

    TYPES: BEGIN OF ty_ded_4010,
             cd_empresa    TYPE string,
             cd_filial     TYPE string,
             id_referencia TYPE string,
             nr_item_rend  TYPE string,
             nr_item_pgto  TYPE string,
             nr_item_ded   TYPE string,
             dm_tipo_ded   TYPE string,
             vl_deducao    TYPE string,
             dm_info_ent   TYPE string,
           END OF ty_ded_4010.

    TYPES: BEGIN OF ty_benef_pensao_ded_4010,
             cd_empresa               TYPE string,
             cd_filial                TYPE string,
             id_referencia            TYPE string,
             nr_item_rend             TYPE string,
             nr_item_pgto             TYPE string,
             nr_item_ded              TYPE string,
             nr_item_benef_pensao_ded TYPE string,
             nr_cpf                   TYPE string,
             vl_dependencia           TYPE string,
           END OF ty_benef_pensao_ded_4010.

    TYPES: BEGIN OF ty_proc_ret_4010,
             cd_empresa       TYPE string,
             cd_filial        TYPE string,
             id_referencia    TYPE string,
             nr_item_rend     TYPE string,
             nr_item_pgto     TYPE string,
             nr_item_proc_ret TYPE string,
             dm_tipo_proc_ret TYPE string,
             nr_proc_ret      TYPE string,
             vl_nao_retencao  TYPE string,
             vl_deposito_jud  TYPE string,
           END OF ty_proc_ret_4010.

    TYPES: BEGIN OF ty_ded_susp_4010,
             cd_empresa       TYPE string,
             cd_filial        TYPE string,
             id_referencia    TYPE string,
             nr_item_rend     TYPE string,
             nr_item_pgto     TYPE string,
             nr_item_proc_ret TYPE string,
             nr_item_ded_susp TYPE string,
             dm_tipo_ded      TYPE string,
             vl_deducao_susp  TYPE string,
           END OF ty_ded_susp_4010.

    TYPES: BEGIN OF ty_benef_pensao_dsusp_4010,
             cd_empresa             TYPE string,
             cd_filial              TYPE string,
             id_referencia          TYPE string,
             nr_item_rend           TYPE string,
             nr_item_pgto           TYPE string,
             nr_item_proc_ret       TYPE string,
             nr_item_ded_susp       TYPE string,
             nr_item_benef_ded_susp TYPE string,
             nr_cpf                 TYPE string,
             vl_dependencia_susp    TYPE string,
           END OF ty_benef_pensao_dsusp_4010.

    TYPES: BEGIN OF ty_rra_4010,
             cd_empresa        TYPE string,
             cd_filial         TYPE string,
             id_referencia     TYPE string,
             nr_item_rend      TYPE string,
             nr_item_pgto      TYPE string,
             nr_item_rra       TYPE string,
             dm_tipo_processo  TYPE string,
             nr_processo       TYPE string,
             dm_origem_rec     TYPE string,
             ds_rra            TYPE string,
             nr_qtde_meses_rra TYPE string,
             nr_cnpj_origem    TYPE string,
             vl_desp_custas    TYPE string,
             vl_desp_adv       TYPE string,
           END OF ty_rra_4010.

    TYPES: BEGIN OF ty_rra_adv_4010,
             cd_empresa       TYPE string,
             cd_filial        TYPE string,
             id_referencia    TYPE string,
             nr_item_rend     TYPE string,
             nr_item_pgto     TYPE string,
             nr_item_rra      TYPE string,
             nr_item_adv      TYPE string,
             dm_tipo_adv      TYPE string,
             nr_inscricao_adv TYPE string,
             vl_adv           TYPE string,
           END OF ty_rra_adv_4010.

    TYPES: BEGIN OF ty_proc_jud_4010,
             cd_empresa       TYPE string,
             cd_filial        TYPE string,
             id_referencia    TYPE string,
             nr_item_rend     TYPE string,
             nr_item_pgto     TYPE string,
             nr_item_proc_jud TYPE string,
             nr_processo      TYPE string,
             dm_origem        TYPE string,
             nr_cnpj_origem   TYPE string,
             ds_descricao     TYPE string,
             vl_desp_custas   TYPE string,
             vl_desp_adv      TYPE string,
           END OF ty_proc_jud_4010.

    TYPES: BEGIN OF ty_proc_jud_adv_4010,
             cd_empresa       TYPE string,
             cd_filial        TYPE string,
             id_referencia    TYPE string,
             nr_item_rend     TYPE string,
             nr_item_pgto     TYPE string,
             nr_item_proc_jud TYPE string,
             nr_item_adv      TYPE string,
             dm_tipo_adv      TYPE string,
             nr_inscricao_adv TYPE string,
             vl_adv           TYPE string,
           END OF ty_proc_jud_adv_4010.

    TYPES: BEGIN OF ty_oper_saude_4010,
             cd_empresa         TYPE string,
             cd_filial          TYPE string,
             id_referencia      TYPE string,
             nr_item_oper_saude TYPE string,
             nr_inscricao       TYPE string,
             cd_ans             TYPE string,
             vl_saude           TYPE string,
           END OF ty_oper_saude_4010.

    TYPES: BEGIN OF ty_depende_saude_4010,
             cd_empresa         TYPE string,
             cd_filial          TYPE string,
             id_referencia      TYPE string,
             nr_item_oper_saude TYPE string,
             nr_item_depende    TYPE string,
             nr_cpf             TYPE string,
             vl_saude           TYPE string,
           END OF ty_depende_saude_4010.

    TYPES: BEGIN OF ty_reemb_4010,
             cd_empresa         TYPE string,
             cd_filial          TYPE string,
             id_referencia      TYPE string,
             nr_item_oper_saude TYPE string,
             nr_item_reemb      TYPE string,
             dm_tipo_inscricao  TYPE string,
             nr_inscricao       TYPE string,
             vl_reembolso       TYPE string,
           END OF ty_reemb_4010.

    TYPES: BEGIN OF ty_reemb_depende_4010,
             cd_empresa            TYPE string,
             cd_filial             TYPE string,
             id_referencia         TYPE string,
             nr_item_oper_saude    TYPE string,
             nr_item_depende       TYPE string,
             nr_item_reemb_depende TYPE string,
             dm_tipo_inscricao     TYPE string,
             nr_inscricao          TYPE string,
             vl_reembolso          TYPE string,
           END OF ty_reemb_depende_4010.

    TYPES: BEGIN OF ty_dependente_4010,
             cd_empresa      TYPE string,
             cd_filial       TYPE string,
             id_referencia   TYPE string,
             nr_item_depende TYPE string,
             nr_cpf          TYPE string,
             dm_relacao      TYPE string,
             ds_dependente   TYPE string,
           END OF ty_dependente_4010.

    " Nomes de componente limitados a 30 caracteres: BenPenDedList / BenPenDedSuspList
    " são convertidos para BenefPensaoDedList / BenefPensaoDedSuspList no convert_reinf4010
    TYPES: BEGIN OF ty_root_r4010,
             knwReinfR4010                  TYPE ty_knw_r4010,
             knwReinfR4010RendList          TYPE TABLE OF ty_rend_4010 WITH DEFAULT KEY,
             knwReinfR4010PgtoList          TYPE TABLE OF ty_pgto_4010 WITH DEFAULT KEY,
             knwReinfR4010PgtoExtList       TYPE TABLE OF ty_pgto_ext_4010 WITH DEFAULT KEY,
             knwReinfR4010RendIsentoList    TYPE TABLE OF ty_rend_isento_4010 WITH DEFAULT KEY,
             knwReinfR4010DedList           TYPE TABLE OF ty_ded_4010 WITH DEFAULT KEY,
             knwReinfR4010BenPenDedList     TYPE TABLE OF ty_benef_pensao_ded_4010 WITH DEFAULT KEY,
             knwReinfR4010ProcRetList       TYPE TABLE OF ty_proc_ret_4010 WITH DEFAULT KEY,
             knwReinfR4010DedSuspList       TYPE TABLE OF ty_ded_susp_4010 WITH DEFAULT KEY,
             knwReinfR4010BenPenDedSuspList TYPE TABLE OF ty_benef_pensao_dsusp_4010 WITH DEFAULT KEY,
             knwReinfR4010RraList           TYPE TABLE OF ty_rra_4010 WITH DEFAULT KEY,
             knwReinfR4010RraAdvList        TYPE TABLE OF ty_rra_adv_4010 WITH DEFAULT KEY,
             knwReinfR4010ProcJudList       TYPE TABLE OF ty_proc_jud_4010 WITH DEFAULT KEY,
             knwReinfR4010ProcJudAdvList    TYPE TABLE OF ty_proc_jud_adv_4010 WITH DEFAULT KEY,
             knwReinfR4010OperSaudeList     TYPE TABLE OF ty_oper_saude_4010 WITH DEFAULT KEY,
             knwReinfR4010DependeSaudeList  TYPE TABLE OF ty_depende_saude_4010 WITH DEFAULT KEY,
             knwReinfR4010ReembList         TYPE TABLE OF ty_reemb_4010 WITH DEFAULT KEY,
             knwReinfR4010ReembDependeList  TYPE TABLE OF ty_reemb_depende_4010 WITH DEFAULT KEY,
             knwReinfR4010DependenteList    TYPE TABLE OF ty_dependente_4010 WITH DEFAULT KEY,
           END OF ty_root_r4010.

    TYPES: tt_r4010_objects TYPE STANDARD TABLE OF ty_root_r4010 WITH DEFAULT KEY.
**********************************************************************
    TYPES: BEGIN OF ty_tax_item,
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
           BEGIN OF ty_nf_item,
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
             br_nfpostingdate             TYPE i_br_nfdocument-br_nfpostingdate,
             br_nfpartnerisnaturalperson  TYPE i_br_nfdocument-br_nfpartnerisnaturalperson,
           END OF ty_nf_item,

           ty_r_tax_type TYPE RANGE OF i_br_nftax-taxgroup,
           tt_r4020_objects TYPE STANDARD TABLE OF ty_root_r4020 WITH DEFAULT KEY.

    DATA: gt_data    TYPE TABLE OF ty_tax_item,
          gt_data_ir TYPE TABLE OF ty_tax_item,
          gt_nfs     TYPE TABLE OF ty_nf_item,
          gt_nfs_ir  TYPE TABLE OF ty_nf_item.

*******************************************************************
    DATA    gt_r1000 TYPE TABLE OF ty_r1000.
    DATA ls_root TYPE ty_root_r4020.

    DATA: gt_objects       TYPE tt_r4020_objects.
    DATA: gt_objects4010   TYPE tt_r4010_objects.

    METHODS:
      constructor
        IMPORTING
          iv_br_notafiscal  TYPE i_br_nfdocument-br_notafiscal OPTIONAL
          iv_date_begin     TYPE d OPTIONAL
          iv_date_end       TYPE d OPTIONAL
          iv_company_doce   TYPE i_companycode-companycode
          iv_business_place TYPE i_br_businessplace-branch
          iv_partner        TYPE i_supplier-supplier OPTIONAL,

      read_db IMPORTING sel TYPE ty_sel,
      build_r4020
        RETURNING VALUE(rv_json) TYPE string,

      build_r4020_new
        RETURNING VALUE(rv_json) TYPE string,

      build_r2010
        RETURNING VALUE(rv_json) TYPE string,

      build_r1000
        RETURNING VALUE(rv_json) TYPE string,

      format_date
        IMPORTING
          iv_date        TYPE d
          iv_with_time   TYPE abap_bool DEFAULT abap_false
        RETURNING
          VALUE(rv_date) TYPE string,

      clean_cnpj
        IMPORTING
          iv_cnpj        TYPE string
        RETURNING
          VALUE(rv_cnpj) TYPE string,

      format_amount
        IMPORTING
          iv_value        TYPE any
        RETURNING
          VALUE(rv_value) TYPE string,

      get_nat_ren
        IMPORTING
                  iv_lc116         TYPE string
        RETURNING VALUE(rv_natren) TYPE string,

      get_return
        RETURNING VALUE(et_process) TYPE ty_reinf,

      conv_with_stx
        IMPORTING
                  witht        TYPE clike
        RETURNING VALUE(group) TYPE ty_r_tax_type."i_br_nftax-taxgroup,
