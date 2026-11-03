  METHOD build_r4020_new.

LOOP AT gt_data INTO DATA(ls_data).

  READ TABLE gt_nfs
    WITH KEY br_nfsourcedocumentnumber = ls_data-originalreferencedocument
    INTO DATA(ls_nfs).

  CHECK sy-subrc = 0.

  IF ls_nfs-br_lc116servicecode IS INITIAL.
    "CLEAR gt_objects.
    CONTINUE.
  ENDIF.

  DATA(lv_natureza) = get_nat_ren(
    |{ ls_nfs-br_lc116servicecode }|
  ).

  IF lv_natureza IS INITIAL.
    CONTINUE.
  ENDIF.

  READ TABLE mt_irf_types
    WITH KEY categoriairf = ls_data-withholdingtaxtype
    INTO DATA(ls_irf_type).

  IF ls_irf_type IS INITIAL.
    CONTINUE.
  ENDIF.

  IF ls_data-clearingdate IS INITIAL.
    CONTINUE.
  ENDIF.

  READ TABLE gt_params TRANSPORTING NO FIELDS WITH KEY pcode  = 'REINF_MULT'
                                                               active = abap_true.
  IF sy-subrc IS NOT INITIAL.
    gs_branch_sov-sov_company = '1'.
    gs_branch_sov-sov_branch = '1'.
  ENDIF.

**********************************************************************
* R4010 - Beneficiário pessoa física (BR_NFPartnerIsNaturalPerson = 'X')
* R4020 segue abaixo somente quando BR_NFPartnerIsNaturalPerson IS INITIAL
**********************************************************************
  IF ls_nfs-br_nfpartnerisnaturalperson = abap_true.

    DATA(lv_root_id_4010) =
      |R4010{ ls_nfs-br_nfpostingdate(6) }{ ls_nfs-br_nfpartner }|.
    IF ls_irf_type-Usardatapagto = abap_true.
      lv_root_id_4010 = |R4010{ ls_data-clearingdate(6) }{ ls_nfs-br_nfpartner }|.
    ENDIF.

    READ TABLE gt_objects4010 ASSIGNING FIELD-SYMBOL(<root4010>)
      WITH KEY knwReinfR4010-id_referencia = lv_root_id_4010.

    IF sy-subrc <> 0.
      APPEND INITIAL LINE TO gt_objects4010 ASSIGNING <root4010>.
      <root4010>-knwReinfR4010-cd_empresa         = gs_branch_sov-sov_company.
      <root4010>-knwReinfR4010-cd_filial          = gs_branch_sov-sov_branch.
      <root4010>-knwReinfR4010-id_referencia      = lv_root_id_4010.
      <root4010>-knwReinfR4010-dm_retificacao     = '1'.
      DATA(lv_dt_apura_4010) = |{ ls_nfs-br_nfpostingdate+6(2) }{ ls_nfs-br_nfpostingdate+4(2) }{ ls_nfs-br_nfpostingdate(4) }|.
      IF ls_irf_type-Usardatapagto = abap_true.
        lv_dt_apura_4010 = |{ ls_data-clearingdate+6(2) }{ ls_data-clearingdate+4(2) }{ ls_data-clearingdate(4) }|.
      ENDIF.
      <root4010>-knwReinfR4010-dt_apuracao        = lv_dt_apura_4010.
      <root4010>-knwReinfR4010-dm_inscricao_estab = '1'.
      <root4010>-knwReinfR4010-nr_inscricao_estab = ls_nfs-br_businessplacecnpj.
      <root4010>-knwReinfR4010-nr_cnpj_benef      = ls_nfs-br_nfpartnercpf.
      <root4010>-knwReinfR4010-nm_benef           = ls_nfs-br_nfpartnername1.
      <root4010>-knwReinfR4010-cd_evt_adic        = ''.
    ENDIF.

    DATA(lv_rend_key_4010) =
      |{ lv_root_id_4010 }{ lv_natureza }|.

    READ TABLE <root4010>-knwReinfR4010RendList
      ASSIGNING FIELD-SYMBOL(<rend4010>)
      WITH KEY ds_observacao = lv_rend_key_4010.

    IF sy-subrc <> 0.

      DATA(lv_item_rend_4010) =
        lines( <root4010>-knwReinfR4010RendList ) + 1.

      APPEND INITIAL LINE TO
        <root4010>-knwReinfR4010RendList
        ASSIGNING <rend4010>.

      <rend4010>-cd_empresa    = gs_branch_sov-sov_company.
      <rend4010>-cd_filial     = gs_branch_sov-sov_branch.
      <rend4010>-id_referencia = lv_root_id_4010.
      <rend4010>-nr_item_rend  = lv_item_rend_4010.
      <rend4010>-cd_nat_rend   = lv_natureza.
      <rend4010>-ds_observacao = lv_rend_key_4010.

    ENDIF.

    DATA(lv_pgto_key_4010) =
      |{ lv_rend_key_4010 }{ ls_nfs-br_nfsnumber }|.

    READ TABLE <root4010>-knwReinfR4010PgtoList
      ASSIGNING FIELD-SYMBOL(<pgto4010>)
      WITH KEY ds_observ = lv_pgto_key_4010.

    IF sy-subrc <> 0.

      DATA(lv_item_pgto_4010) = 1.

      LOOP AT <root4010>-knwReinfR4010PgtoList
        ASSIGNING FIELD-SYMBOL(<tmp_pgto4010>)
        WHERE id_referencia = lv_root_id_4010
          AND nr_item_rend  = <rend4010>-nr_item_rend.

        lv_item_pgto_4010 = lv_item_pgto_4010 + 1.

      ENDLOOP.

      APPEND INITIAL LINE TO
        <root4010>-knwReinfR4010PgtoList
        ASSIGNING <pgto4010>.

      <pgto4010>-cd_empresa      = gs_branch_sov-sov_company.
      <pgto4010>-cd_filial       = gs_branch_sov-sov_branch.
      <pgto4010>-id_referencia   = lv_root_id_4010.
      <pgto4010>-nr_item_rend    = <rend4010>-nr_item_rend.
      <pgto4010>-nr_item_pgto    = lv_item_pgto_4010.
      <pgto4010>-dt_fato_gerador = format_date( iv_date = ls_nfs-br_nfissuedate ).
      IF ls_irf_type-Usardatapagto = abap_true.
        <pgto4010>-dt_fato_gerador = format_date( iv_date = ls_data-clearingdate ).
      ENDIF.
      <pgto4010>-vl_rend_bruto        = format_amount( iv_value = ls_nfs-br_nftotalamount ).
      <pgto4010>-ds_observ            = lv_pgto_key_4010.
      <pgto4010>-dt_comp_rendimento   = ''.
      <pgto4010>-dm_dec_terc          = ''.
      <pgto4010>-dm_ind_rra           = ''.
      <pgto4010>-dm_fci_scp           = ''.
      <pgto4010>-nr_inscricao_fci_scp = ''.
      <pgto4010>-vl_perc_scp          = ''.
      <pgto4010>-dm_indic_judicial    = ''.
      <pgto4010>-cd_pais_resid_ext    = ''.
      <pgto4010>-dt_escr_cont         = ''.
    ENDIF.

    IF <pgto4010>-vl_ir IS INITIAL.
      <pgto4010>-vl_ir = '0'.
    ENDIF.
    IF <pgto4010>-vl_rend_trib IS INITIAL.
      <pgto4010>-vl_rend_trib = '0'.
    ENDIF.

    " R4010 possui somente retenção de IR
    CASE ls_irf_type-imposto.

      WHEN 'IR'.

        <pgto4010>-vl_ir +=
          abs( ls_data-withholdingtaxamtintransaccrcy ).

        <pgto4010>-vl_rend_trib =
          abs( ls_data-withholdingtaxbaseamtincocode ).

    ENDCASE.

    CONTINUE.

  ENDIF.

  DATA(lv_root_id) =
    |R4020{ ls_nfs-br_nfpostingdate(6) }{ ls_nfs-br_nfpartner }|.
  IF ls_irf_type-Usardatapagto = abap_true.
    lv_root_id = |R4020{ ls_data-clearingdate(6) }{ ls_nfs-br_nfpartner }|.
  ENDIF.

  READ TABLE gt_objects ASSIGNING FIELD-SYMBOL(<root>)
    WITH KEY knwReinfR4020-id_referencia = lv_root_id.

  IF sy-subrc <> 0.
    APPEND INITIAL LINE TO gt_objects ASSIGNING <root>.
    <root>-knwReinfR4020-cd_empresa         = gs_branch_sov-sov_company.
    <root>-knwReinfR4020-cd_filial          = gs_branch_sov-sov_branch.
    "<root>-knwReinfR4020-cd_empresa         = gs_branch_main-CompanyCode.
    "<root>-knwReinfR4020-cd_filial           = gs_branch_main-CompanyCodeParameterValue.
    <root>-knwReinfR4020-id_referencia      = lv_root_id.
    "<root>-knwReinfR4020-id_evento          = lv_root_id.
    <root>-knwReinfR4020-dm_retificacao     = '1'.
    DATA(lv_dt_apura) = |{ ls_nfs-br_nfpostingdate+6(2) }{ ls_nfs-br_nfpostingdate+4(2) }{ ls_nfs-br_nfpostingdate(4) }|.
    IF ls_irf_type-Usardatapagto = abap_true.
      lv_dt_apura = |{ ls_data-clearingdate+6(2) }{ ls_data-clearingdate+4(2) }{ ls_data-clearingdate(4) }|.
    ENDIF.
    <root>-knwReinfR4020-dt_apuracao        = lv_dt_apura.
    <root>-knwReinfR4020-dm_inscricao_estab     = '1'.
    <root>-knwReinfR4020-nr_inscricao_estab = ls_nfs-br_businessplacecnpj.
    <root>-knwReinfR4020-nr_cnpj_benef      = ls_nfs-br_nfpartnercnpj.
    <root>-knwReinfR4020-nm_benef           = ls_nfs-br_nfpartnername1.
    <root>-knwReinfR4020-ide_evt_adic       = ''.
  ENDIF.

  DATA(lv_pgto_key) =
    |{ lv_root_id }{ lv_natureza }|.

  READ TABLE <root>-reinfR4020PgtoList
    ASSIGNING FIELD-SYMBOL(<pgto>)
    WITH KEY ds_observacao = lv_pgto_key.

  IF sy-subrc <> 0.

    DATA(lv_seq_pagto) =
      lines( <root>-reinfR4020PgtoList ) + 1.

    APPEND INITIAL LINE TO
      <root>-reinfR4020PgtoList
      ASSIGNING <pgto>.

    <pgto>-cd_empresa    = gs_branch_sov-sov_company.
    <pgto>-cd_filial     = gs_branch_sov-sov_branch.
    "<pgto>-cd_empresa          = gs_branch_main-CompanyCode.
    "<pgto>-cd_filial        = gs_branch_main-CompanyCodeParameterValue.
    <pgto>-id_referencia = lv_root_id.
    "<pgto>-id_referencia = lv_pgto_key.
    <pgto>-id_seq_pagto  = lv_seq_pagto.
    <pgto>-nr_nat_rend   = lv_natureza.
    <pgto>-ds_observacao = lv_pgto_key.

  ENDIF.

  DATA(lv_info_key) =
    |{ lv_pgto_key }{ ls_nfs-br_nfsnumber }|.
    "|{ lv_pgto_key }{ ls_data-accountingdocument }|.
    "|{ lv_pgto_key }{ ls_nfs-br_nfsnumber }|.

  READ TABLE <root>-knwReinfR4020InfoPgtoList
    ASSIGNING FIELD-SYMBOL(<info>)
    WITH KEY ds_observ = lv_info_key.

  IF sy-subrc <> 0.

    DATA(lv_seq_info) = 1.

    LOOP AT <root>-knwReinfR4020InfoPgtoList
      ASSIGNING FIELD-SYMBOL(<tmp_info>)
      WHERE id_referencia = lv_root_id
        AND id_seq_pagto = <pgto>-id_seq_pagto.

      lv_seq_info = lv_seq_info + 1.

    ENDLOOP.

    APPEND INITIAL LINE TO
      <root>-knwReinfR4020InfoPgtoList
      ASSIGNING <info>.

    <info>-cd_empresa       = gs_branch_sov-sov_company.
    <info>-cd_filial        = gs_branch_sov-sov_branch.
    "<info>-cd_empresa          = gs_branch_main-CompanyCode.
    "<info>-cd_filial           = gs_branch_main-CompanyCodeParameterValue.
    <info>-id_referencia    = lv_root_id.
    "<info>-id_referencia    = lv_info_key.
    <info>-id_seq_pagto     = <pgto>-id_seq_pagto.
    <info>-id_seq_info_pgto = lv_seq_info.
    <info>-dt_fato_gerador  = format_date( iv_date = ls_nfs-br_nfissuedate ).
    IF ls_irf_type-Usardatapagto = abap_true.
      <info>-dt_fato_gerador  = format_date( iv_date = ls_data-clearingdate ).
    ENDIF.
    <info>-vl_bruto = format_amount( iv_value = ls_nfs-br_nftotalamount ).
    "<info>-ds_observ = |Doc contábil { ls_data-accountingdocument }|.
    <info>-ds_observ = lv_info_key.
    <info>-dm_fci_scp      = ''.
    <info>-nr_insc_fci_scp = ''.
    <info>-nr_perc_scp     = ''.
    <info>-dm_jud          = ''.
    <info>-cd_pais_resid   = ''.
    <info>-dt_escr_cont    = ''.
  ENDIF.

  READ TABLE <root>-knwReinfR4020InfoPgtoRetList
    ASSIGNING FIELD-SYMBOL(<ret>)
    WITH KEY id_referencia = lv_root_id
             id_seq_pagto = <info>-id_seq_pagto
             id_seq_info_pgto =  <info>-id_seq_info_pgto.

  IF sy-subrc <> 0.

    APPEND INITIAL LINE TO
      <root>-knwReinfR4020InfoPgtoRetList
      ASSIGNING <ret>.

    <ret>-cd_empresa        = gs_branch_sov-sov_company.
    <ret>-cd_filial         = gs_branch_sov-sov_branch.
    "<ret>-cd_empresa          = gs_branch_main-CompanyCode.
    "<ret>-cd_filial        = gs_branch_main-CompanyCodeParameterValue.
    <ret>-id_referencia     = lv_root_id.
    "<ret>-id_referencia     = lv_info_key.
    <ret>-id_seq_pagto      = <info>-id_seq_pagto.
    <ret>-id_seq_info_pgto  = <info>-id_seq_info_pgto.
  ENDIF.

    IF <ret>-vl_ir IS INITIAL.
      <ret>-vl_ir = '0'.
    ENDIF.
    IF <ret>-vl_base_ir IS INITIAL.
      <ret>-vl_base_ir = '0'.
    ENDIF.
    IF <ret>-vl_csll IS INITIAL.
      <ret>-vl_csll = '0'.
    ENDIF.
    IF <ret>-vl_base_csll IS INITIAL.
      <ret>-vl_base_csll = '0'.
    ENDIF.
    IF <ret>-vl_cofins IS INITIAL.
      <ret>-vl_cofins = '0'.
    ENDIF.
    IF <ret>-vl_base_cofins IS INITIAL.
      <ret>-vl_base_cofins = '0'.
    ENDIF.
    IF <ret>-vl_pis_pasep IS INITIAL.
      <ret>-vl_pis_pasep = '0'.
    ENDIF.
    IF <ret>-vl_base_pis_pasep IS INITIAL.
      <ret>-vl_base_pis_pasep = '0'.
    ENDIF.
    IF <ret>-vl_agreg IS INITIAL.
      <ret>-vl_agreg = '0'.
    ENDIF.
    IF <ret>-vl_base_agreg IS INITIAL.
      <ret>-vl_base_agreg = '0'.
    ENDIF.

  CASE ls_irf_type-imposto.

    WHEN 'IR'.

      <ret>-vl_ir +=
        abs( ls_data-withholdingtaxamtintransaccrcy ).

      <ret>-vl_base_ir =
        abs( ls_data-withholdingtaxbaseamtincocode ).

    WHEN 'CSLL'.

      <ret>-vl_csll +=
        abs( ls_data-withholdingtaxamtintransaccrcy ).

      <ret>-vl_base_csll =
        abs( ls_data-withholdingtaxbaseamtincocode ).

    WHEN 'COFINS'.

      <ret>-vl_cofins +=
        abs( ls_data-withholdingtaxamtintransaccrcy ).

      <ret>-vl_base_cofins =
        abs( ls_data-withholdingtaxbaseamtincocode ).

    WHEN 'PIS'.

      <ret>-vl_pis_pasep +=
        abs( ls_data-withholdingtaxamtintransaccrcy ).

      <ret>-vl_base_pis_pasep =
        abs( ls_data-withholdingtaxbaseamtincocode ).

    WHEN 'PCC'.

      <ret>-vl_agreg +=
        abs( ls_data-withholdingtaxamtintransaccrcy ).

      <ret>-vl_base_agreg =
        abs( ls_data-withholdingtaxbaseamtincocode ).

  ENDCASE.

ENDLOOP.
  ENDMETHOD.