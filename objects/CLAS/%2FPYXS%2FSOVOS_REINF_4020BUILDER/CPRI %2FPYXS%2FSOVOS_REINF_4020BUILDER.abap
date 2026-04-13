  PRIVATE SECTION.

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
           END OF ty_sel.

    DATA:
      mv_br_notafiscal TYPE i_br_nfdocument-br_notafiscal,
      mt_doc           TYPE TABLE OF i_br_nfdocument,
      mt_itm           TYPE TABLE OF i_br_nfitem,
      mt_tax           TYPE TABLE OF i_br_nftax,
      sel              TYPE ty_sel,
      mt_ret           TYPE ty_reinf.
    TYPES ty_amount TYPE p LENGTH 16 DECIMALS 2.





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
           END OF ty_info_pgto_ret.

    TYPES: BEGIN OF ty_root_r4020,
             knw_r4020                     TYPE TABLE OF ty_knw_r4020 WITH DEFAULT KEY,
             knw_reinf_r4020_pgto          TYPE TABLE OF ty_pgto WITH DEFAULT KEY,
             knw_reinf_r4020_info_pgto     TYPE TABLE OF ty_info_pgto WITH DEFAULT KEY,
             knw_reinf_r4020_info_pgto_ret TYPE TABLE OF ty_info_pgto_ret WITH DEFAULT KEY,
           END OF ty_root_r4020.

    DATA gt_r1000 TYPE TABLE OF ty_r1000.
    DATA ls_root TYPE ty_root_r4020.

    METHODS serialize_json
      IMPORTING is_data        TYPE any
      RETURNING VALUE(rv_json) TYPE string.

    METHODS send_integration.