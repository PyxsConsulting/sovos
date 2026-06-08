METHOD build_r4020_new.

  TYPES: BEGIN OF ty_seq_pagto,
           id_1 TYPE string,
           seq  TYPE i,
         END OF ty_seq_pagto.

  TYPES: BEGIN OF ty_seq_info_pgto,
           id_2 TYPE string,
           seq  TYPE i,
         END OF ty_seq_info_pgto.

  DATA: gt_seq_pagto     TYPE STANDARD TABLE OF ty_seq_pagto    WITH KEY id_1,
        gt_seq_info_pgto TYPE STANDARD TABLE OF ty_seq_info_pgto WITH KEY id_2.

  DATA: ls_knw_r4020         TYPE ty_knw_r4020,
        ls_knw_pgto          TYPE ty_pgto,
        ls_knw_info_pgto     TYPE ty_info_pgto,
        ls_knw_info_pgto_ret TYPE ty_info_pgto_ret.

  LOOP AT gt_data INTO DATA(ls_data).

    READ TABLE gt_nfs WITH KEY br_nfsourcedocumentnumber = ls_data-originalreferencedocument INTO DATA(ls_nfs).
    CHECK sy-subrc = 0.

    IF ls_nfs-br_lc116servicecode IS INITIAL.
      CLEAR ls_root.
      RETURN.
    ENDIF.

    DATA(lv_natureza) = get_nat_ren( |{ ls_nfs-br_lc116servicecode }| ).

    DATA(lv_id_pagamentos)  = |{ ls_data-clearingdate(6) }{ ls_nfs-br_nfpartner }|.
    DATA(lv_id_itens_pagto) = |{ ls_data-clearingdate(6) }{ ls_nfs-br_nfpartner }{ lv_natureza }|.

    READ TABLE gt_seq_pagto WITH KEY id_1 = lv_id_pagamentos ASSIGNING FIELD-SYMBOL(<ls_seq_pagto>).
    IF sy-subrc = 0.
      <ls_seq_pagto>-seq += 1.
    ELSE.
      INSERT VALUE #( id_1 = lv_id_pagamentos seq = 1 ) INTO TABLE gt_seq_pagto ASSIGNING <ls_seq_pagto>.
    ENDIF.
    DATA(lv_id_seq_pagto) = <ls_seq_pagto>-seq.

    READ TABLE gt_seq_info_pgto WITH KEY id_2 = lv_id_itens_pagto ASSIGNING FIELD-SYMBOL(<ls_seq_info_pgto>).
    IF sy-subrc = 0.
      <ls_seq_info_pgto>-seq += 1.
    ELSE.
      INSERT VALUE #( id_2 = lv_id_itens_pagto seq = 1 ) INTO TABLE gt_seq_info_pgto ASSIGNING <ls_seq_info_pgto>.
    ENDIF.
    DATA(lv_id_seq_info_pgto) = <ls_seq_info_pgto>-seq.

    " --- knw_r4020 (one per beneficiary/period) ---
    DATA(lv_id) = lv_id_pagamentos.
    READ TABLE ls_root-knw_r4020 ASSIGNING FIELD-SYMBOL(<ls_knw_r4020>) WITH KEY id_referencia = lv_id.
    IF sy-subrc IS NOT INITIAL.
      APPEND INITIAL LINE TO ls_root-knw_r4020 ASSIGNING <ls_knw_r4020>.
      <ls_knw_r4020>-cd_empresa         = gs_branch_sov-sov_company.
      <ls_knw_r4020>-cd_filial          = gs_branch_sov-sov_branch.
      <ls_knw_r4020>-id_referencia      = lv_id.
      <ls_knw_r4020>-id_evento          = lv_id.
      <ls_knw_r4020>-dm_retificacao     = '1'.
      <ls_knw_r4020>-dt_apuracao        = format_date( iv_date = ls_data-clearingdate ).
      <ls_knw_r4020>-nr_inscricao_estab = clean_cnpj( CONV string( ls_nfs-br_businessplacecnpj ) ).
      <ls_knw_r4020>-nr_cnpj_benef      = clean_cnpj( CONV string( ls_nfs-br_nfpartnercnpj ) ).
      <ls_knw_r4020>-nm_benef           = ls_nfs-br_nfpartnername1.
      <ls_knw_r4020>-dm_inscricao_estab = '1'.
      <ls_knw_r4020>-ide_evt_adic       = ''.
    ENDIF.

    " --- knw_reinf_r4020_pgto (one per beneficiary/period/natureza) ---
    DATA(lv_id_pgto) = |{ lv_id }{ lv_natureza }|.
    READ TABLE ls_root-knw_reinf_r4020_pgto ASSIGNING FIELD-SYMBOL(<knw_reinf_r4020_pgt>) WITH KEY id_referencia = lv_id_pgto.
    IF sy-subrc IS NOT INITIAL.
      APPEND INITIAL LINE TO ls_root-knw_reinf_r4020_pgto ASSIGNING <knw_reinf_r4020_pgt>.
      <knw_reinf_r4020_pgt>-cd_empresa    = gs_branch_sov-sov_company.
      <knw_reinf_r4020_pgt>-cd_filial     = gs_branch_sov-sov_branch.
      <knw_reinf_r4020_pgt>-id_referencia = lv_id.          " same as knw_r4020
      <knw_reinf_r4020_pgt>-id_seq_pagto  = |{ lv_id_seq_pagto }|.
      <knw_reinf_r4020_pgt>-nr_nat_rend   = lv_natureza.
      <knw_reinf_r4020_pgt>-ds_observacao = ''.
    ENDIF.

    " --- knw_reinf_r4020_info_pgto (one per accounting document) ---
    DATA(lv_id_info) = |{ lv_id_pgto }{ ls_data-accountingdocument }|.
    READ TABLE ls_root-knw_reinf_r4020_info_pgto ASSIGNING FIELD-SYMBOL(<knw_reinf_r4020_info_pgto>) WITH KEY id_referencia = lv_id_info.
    IF sy-subrc IS NOT INITIAL.
      APPEND INITIAL LINE TO ls_root-knw_reinf_r4020_info_pgto ASSIGNING <knw_reinf_r4020_info_pgto>.
    ENDIF.
    <knw_reinf_r4020_info_pgto>-cd_empresa       = gs_branch_sov-sov_company.
    <knw_reinf_r4020_info_pgto>-cd_filial        = gs_branch_sov-sov_branch.
    <knw_reinf_r4020_info_pgto>-id_referencia    = lv_id.   " same as knw_r4020
    <knw_reinf_r4020_info_pgto>-id_seq_pagto     = |{ lv_id_seq_pagto }|.
    <knw_reinf_r4020_info_pgto>-id_seq_info_pgto = |{ lv_id_seq_info_pgto }|.
    <knw_reinf_r4020_info_pgto>-dt_fato_gerador  = format_date( iv_date = ls_data-clearingdate ).
    <knw_reinf_r4020_info_pgto>-vl_bruto         = format_amount( iv_value = ls_nfs-br_nftotalamount ).
    <knw_reinf_r4020_info_pgto>-ds_observ        = |Doc contábil { ls_data-accountingdocument }|.
    <knw_reinf_r4020_info_pgto>-dm_fci_scp       = ''.
    <knw_reinf_r4020_info_pgto>-nr_insc_fci_scp  = ''.
    <knw_reinf_r4020_info_pgto>-nr_perc_scp      = ''.
    <knw_reinf_r4020_info_pgto>-dm_jud           = 'N'.
    <knw_reinf_r4020_info_pgto>-cd_pais_resid    = ''.
    <knw_reinf_r4020_info_pgto>-dt_escr_cont     = ''.

    " --- knw_reinf_r4020_info_pgto_ret (one per accounting document) ---
    READ TABLE ls_root-knw_reinf_r4020_info_pgto_ret ASSIGNING FIELD-SYMBOL(<r4020_info_pgto_ret>) WITH KEY id_referencia = lv_id_info.
    IF sy-subrc IS NOT INITIAL.
      APPEND INITIAL LINE TO ls_root-knw_reinf_r4020_info_pgto_ret ASSIGNING <r4020_info_pgto_ret>.
      <r4020_info_pgto_ret>-cd_empresa       = gs_branch_sov-sov_company.
      <r4020_info_pgto_ret>-cd_filial        = gs_branch_sov-sov_branch.
      <r4020_info_pgto_ret>-id_referencia    = lv_id.        " same as knw_r4020
      <r4020_info_pgto_ret>-id_seq_pagto     = |{ lv_id_seq_pagto }|.
      <r4020_info_pgto_ret>-id_seq_info_pgto = |{ lv_id_seq_info_pgto }|.
      " initialize all tax fields to '0'
      <r4020_info_pgto_ret>-vl_base_ir        = '0'.
      <r4020_info_pgto_ret>-vl_ir             = '0'.
      <r4020_info_pgto_ret>-vl_base_csll      = '0'.
      <r4020_info_pgto_ret>-vl_csll           = '0'.
      <r4020_info_pgto_ret>-vl_base_cofins    = '0'.
      <r4020_info_pgto_ret>-vl_cofins         = '0'.
      <r4020_info_pgto_ret>-vl_base_pis_pasep = '0'.
      <r4020_info_pgto_ret>-vl_pis_pasep      = '0'.
      <r4020_info_pgto_ret>-vl_base_agreg     = '0'.
      <r4020_info_pgto_ret>-vl_agreg          = '0'.
    ENDIF.

    " accumulate tax amounts
    READ TABLE mt_irf_types WITH KEY categoriairf = ls_data-withholdingtaxtype INTO DATA(ls_irf_type).
    DATA(lv_tax_amt)  = format_amount( iv_value = abs( ls_data-withholdingtaxamtintransaccrcy ) ).
    DATA(lv_base_amt) = format_amount( iv_value = abs( ls_data-withholdingtaxbaseamtincocode ) ).
    CASE ls_irf_type-imposto.
      WHEN 'IR'.
        <r4020_info_pgto_ret>-vl_ir      = format_amount( iv_value = abs( ls_data-withholdingtaxamtintransaccrcy )
                                             + CONV decfloat34( <r4020_info_pgto_ret>-vl_ir ) ).
        <r4020_info_pgto_ret>-vl_base_ir = lv_base_amt.
      WHEN 'CSLL'.
        <r4020_info_pgto_ret>-vl_csll      = format_amount( iv_value = abs( ls_data-withholdingtaxamtintransaccrcy )
                                               + CONV decfloat34( <r4020_info_pgto_ret>-vl_csll ) ).
        <r4020_info_pgto_ret>-vl_base_csll = lv_base_amt.
      WHEN 'COFINS'.
        <r4020_info_pgto_ret>-vl_cofins      = format_amount( iv_value = abs( ls_data-withholdingtaxamtintransaccrcy )
                                                 + CONV decfloat34( <r4020_info_pgto_ret>-vl_cofins ) ).
        <r4020_info_pgto_ret>-vl_base_cofins = lv_base_amt.
      WHEN 'PIS'.
        <r4020_info_pgto_ret>-vl_pis_pasep      = format_amount( iv_value = abs( ls_data-withholdingtaxamtintransaccrcy )
                                                    + CONV decfloat34( <r4020_info_pgto_ret>-vl_pis_pasep ) ).
        <r4020_info_pgto_ret>-vl_base_pis_pasep = lv_base_amt.
      WHEN 'PCC'.
        <r4020_info_pgto_ret>-vl_agreg      = format_amount( iv_value = abs( ls_data-withholdingtaxamtintransaccrcy )
                                               + CONV decfloat34( <r4020_info_pgto_ret>-vl_agreg ) ).
        <r4020_info_pgto_ret>-vl_base_agreg = lv_base_amt.
    ENDCASE.

  ENDLOOP.

ENDMETHOD.