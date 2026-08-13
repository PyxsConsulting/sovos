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

  DATA(lv_root_id) =
    |{ ls_nfs-br_nfpostingdate(6) }{ ls_nfs-br_nfpartner }|.
  IF ls_irf_type-Usardatapagto.
    lv_root_id = |{ ls_data-clearingdate(6) }{ ls_nfs-br_nfpartner }|.
  ENDIF.

  READ TABLE gt_objects ASSIGNING FIELD-SYMBOL(<root>)
    WITH KEY knwReinfR4020-id_referencia = lv_root_id.

  IF sy-subrc <> 0.
    APPEND INITIAL LINE TO gt_objects ASSIGNING <root>.
    <root>-knwReinfR4020-cd_empresa         = gs_branch_sov-sov_company.
    <root>-knwReinfR4020-cd_filial          = gs_branch_sov-sov_branch.
    <root>-knwReinfR4020-id_referencia      = lv_root_id.
    <root>-knwReinfR4020-id_evento          = lv_root_id.
    <root>-knwReinfR4020-dm_retificacao     = '1'.
    DATA(lv_dt_apura) = |{ ls_nfs-br_nfpostingdate+6(2) }{ ls_nfs-br_nfpostingdate+4(2) }{ ls_nfs-br_nfpostingdate(4) }|.
    IF ls_irf_type-Usardatapagto.
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
    <info>-id_referencia    = lv_root_id.
    "<info>-id_referencia    = lv_info_key.
    <info>-id_seq_pagto     = <pgto>-id_seq_pagto.
    <info>-id_seq_info_pgto = lv_seq_info.
    <info>-dt_fato_gerador  = format_date( iv_date = ls_nfs-br_nfissuedate ).
    IF ls_irf_type-Usardatapagto.
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
***
***    TYPES: BEGIN OF ty_id_seq_pagto,
***             id                  TYPE c LENGTH 100,
***             id_seq_pagto        TYPE int4,
***             id_seq_info_pgto    TYPE int4,
***             last_accounting_doc TYPE c LENGTH 10,  " ajuste o length conforme o tipo de accountingdocument
***           END OF ty_id_seq_pagto.
***
***    TYPES: BEGIN OF ty_seq_pagto,
***             id_1    TYPE string,
***             seq     TYPE i,
***           END OF ty_seq_pagto.
***
***    TYPES: BEGIN OF ty_seq_info_pgto,
***             id_2    TYPE string,
***             seq     TYPE i,
***           END OF ty_seq_info_pgto.
***
***    DATA: gt_seq_pagto    TYPE STANDARD TABLE OF ty_seq_pagto    WITH KEY id_1,
***          gt_seq_info_pgto TYPE STANDARD TABLE OF ty_seq_info_pgto WITH KEY id_2.
***
***    DATA: lv_prev_partner TYPE i_br_nfdocument-br_nfpartner.
***    DATA: ls_knw_r4020         TYPE ty_knw_r4020,
***          ls_knw_pgto          TYPE  ty_pgto,
***          ls_knw_info_pgto     TYPE  ty_info_pgto,
***          ls_knw_info_pgto_ret TYPE  ty_info_pgto_ret.
***
***
***    DATA: lt_id_seq_pagto TYPE TABLE OF ty_id_seq_pagto.
***
***    LOOP AT gt_data INTO DATA(ls_data).
***
***      LOOP AT gt_nfs INTO DATA(ls_nfs)
***                WHERE br_nfsourcedocumentnumber =  ls_data-originalreferencedocument
***                AND taxgroup IN conv_with_stx( witht = ls_data-withholdingtaxtype ).
***      READ TABLE gt_nfs WITH KEY br_nfsourcedocumentnumber =  ls_data-originalreferencedocument INTO DATA(ls_nfs).
***      CHECK sy-subrc = 0.
***
***      IF ls_nfs-br_lc116servicecode IS INITIAL.
***        CLEAR ls_root.
***        RETURN.
***      ENDIF.
***
***      DATA(lv_natureza) = get_nat_ren( |{ ls_nfs-br_lc116servicecode }| ).
***
***      DATA(lv_id_pagamentos) = |{ ls_data-clearingdate(6) }{ ls_nfs-br_nfpartner }|.
***      DATA(lv_id_itens_pagto) = |{ ls_data-clearingdate(6) }{ ls_nfs-br_nfpartner }{ lv_natureza }|.
***
***      READ TABLE gt_seq_pagto WITH KEY id_1 = lv_id_pagamentos ASSIGNING FIELD-SYMBOL(<ls_seq_pagto>).
***      IF sy-subrc = 0.
***        <ls_seq_pagto>-seq += 1.
***      ELSE.
***        INSERT VALUE #( id_1 = lv_id_pagamentos seq = 1 ) INTO TABLE gt_seq_pagto ASSIGNING <ls_seq_pagto>.
***      ENDIF.
***
***      DATA(lv_id_seq_pagto) = <ls_seq_pagto>-seq.
***
***      READ TABLE gt_seq_info_pgto WITH KEY id_2 = lv_id_itens_pagto ASSIGNING FIELD-SYMBOL(<ls_seq_info_pgto>).
***      IF sy-subrc = 0.
***        <ls_seq_info_pgto>-seq += 1.
***      ELSE.
***        INSERT VALUE #( id_2 = lv_id_itens_pagto seq = 1 ) INTO TABLE gt_seq_info_pgto ASSIGNING <ls_seq_info_pgto>.
***      ENDIF.
***
***      DATA(lv_id_seq_info_pgto) = <ls_seq_info_pgto>-seq.
*****
*****      DATA(lv_seq_key)     = ls_nfs-br_nfpartner.
*****      DATA(lv_doc_key)     = |{ ls_nfs-br_nfpartner }{ ls_data-accountingdocument }|.
*****
*****      " Verifica se esse accountingdocument já foi registrado para esse partner
*****      READ TABLE lt_id_seq_pagto ASSIGNING FIELD-SYMBOL(<ls_id_seq_pagto>) WITH KEY id = lv_doc_key.
*****
*****      IF sy-subrc IS INITIAL.
*****        " Mesmo partner + mesmo doc: reutiliza o sequencial já atribuído
*****        DATA(lv_id_seq_pagto)     = <ls_id_seq_pagto>-id_seq_pagto.
*****        DATA(lv_id_seq_info_pgto) = <ls_id_seq_pagto>-id_seq_info_pgto.
*****      ELSE.
*****        " Novo doc para esse partner: conta quantos docs esse partner já tem
*****        DATA(lv_count) = REDUCE int4(
*****          INIT n = 0
*****          FOR ls_seq IN lt_id_seq_pagto
*****          WHERE ( id CS lv_seq_key )
*****          NEXT n = n + 1
*****        ).
*****
*****        lv_id_seq_pagto     = lv_count + 1.
*****        lv_id_seq_info_pgto = lv_count + 1.
*****
*****        APPEND VALUE ty_id_seq_pagto(
*****          id               = lv_doc_key
*****          id_seq_pagto     = lv_id_seq_pagto
*****          id_seq_info_pgto = lv_id_seq_info_pgto
*****        ) TO lt_id_seq_pagto.
*****      ENDIF.
***
***      DATA(lv_id) = |{ ls_data-clearingdate(6) }{  ls_nfs-br_nfpartner }|.
***      READ TABLE ls_root-knw_r4020 ASSIGNING FIELD-SYMBOL(<ls_knw_r4020>) WITH KEY id_referencia = lv_id.
***      IF sy-subrc IS NOT INITIAL.
***        APPEND INITIAL LINE TO ls_root-knw_r4020 ASSIGNING <ls_knw_r4020>.
***        <ls_knw_r4020>-cd_empresa         = gs_branch_sov-sov_company.
***        <ls_knw_r4020>-cd_filial          = gs_branch_sov-sov_branch.
***        <ls_knw_r4020>-id_referencia      = lv_id. "|{ ls_data-clearingdate(6) }{ ls_nfs-br_nfpartner }|.
***        <ls_knw_r4020>-id_evento          = <ls_knw_r4020>-id_referencia. "A definir
***        <ls_knw_r4020>-dm_retificacao     = '1'.
***        <ls_knw_r4020>-dt_apuracao        = ls_data-clearingdate.
***        <ls_knw_r4020>-nr_inscricao_estab = ls_nfs-br_businessplacecnpj.
***        <ls_knw_r4020>-nr_cnpj_benef      = ls_nfs-br_nfpartnercnpj.
***        <ls_knw_r4020>-nm_benef           = ls_nfs-br_nfpartnername1.
***        <ls_knw_r4020>-ide_evt_adic       = ''.
***      ENDIF.
***
***      "DATA(lv_natureza) = get_nat_ren( |{ ls_nfs-br_lc116servicecode }| ). "Tratar erro se não existir (Barrar todo processo)
***      lv_id = |{ lv_id }{ lv_natureza }|. "colocar a br_notafiscal nesse ID vai quebrar por nf tbm
***      READ TABLE ls_root-knw_reinf_r4020_pgto ASSIGNING FIELD-SYMBOL(<knw_reinf_r4020_pgt>) WITH KEY id_referencia = lv_id.
***      IF sy-subrc IS NOT INITIAL.
***        APPEND INITIAL LINE TO ls_root-knw_reinf_r4020_pgto ASSIGNING <knw_reinf_r4020_pgt>.
***      ENDIF.
***      <knw_reinf_r4020_pgt>-cd_empresa    = gs_branch_sov-sov_company.
***      <knw_reinf_r4020_pgt>-cd_filial     = gs_branch_sov-sov_branch.
***      <knw_reinf_r4020_pgt>-id_referencia = lv_id.
***      <knw_reinf_r4020_pgt>-id_seq_pagto  = lv_id_seq_pagto. "Incrementar para cada pagamento do mesmo parceiro + ano/mes (linha 528)
***      <knw_reinf_r4020_pgt>-nr_nat_rend   = get_nat_ren( |{ ls_nfs-br_lc116servicecode }| ).
***      <knw_reinf_r4020_pgt>-ds_observacao = ''."ms_doc-br_nfobservationtext.
***
***      lv_id = |{ lv_id }{ ls_data-accountingdocument }|. "colocar a br_notafiscal nesse ID vai quebrar por nf tbm
***
***      READ TABLE ls_root-knw_reinf_r4020_info_pgto ASSIGNING FIELD-SYMBOL(<knw_reinf_r4020_info_pgto>)
***      WITH KEY id_referencia = lv_id.
***      IF sy-subrc IS NOT INITIAL.
***        APPEND INITIAL LINE TO ls_root-knw_reinf_r4020_info_pgto ASSIGNING <knw_reinf_r4020_info_pgto>.
***      ENDIF.
***      <knw_reinf_r4020_info_pgto>-cd_empresa       = gs_branch_sov-sov_company.
***      <knw_reinf_r4020_info_pgto>-cd_filial        = gs_branch_sov-sov_branch.
***      <knw_reinf_r4020_info_pgto>-id_referencia    = lv_id.
***      <knw_reinf_r4020_info_pgto>-id_seq_pagto     = <knw_reinf_r4020_pgt>-id_seq_pagto.
***      <knw_reinf_r4020_info_pgto>-id_seq_info_pgto = lv_id_seq_info_pgto. "Incrementar para cada pagamento do mesmo parceiro + anomes + natureza rendimento
***      <knw_reinf_r4020_info_pgto>-dt_fato_gerador  = format_date( iv_date = ls_data-clearingdate ).
***      <knw_reinf_r4020_info_pgto>-vl_bruto         = format_amount( iv_value = ls_nfs-br_nftotalamount ).
***      <knw_reinf_r4020_info_pgto>-ds_observ        = |Doc contábil { ls_data-accountingdocument }|.
***      <knw_reinf_r4020_info_pgto>-dm_fci_scp       = ''.
***      <knw_reinf_r4020_info_pgto>-nr_insc_fci_scp  = ''.
***      <knw_reinf_r4020_info_pgto>-nr_perc_scp      = ''.
***      <knw_reinf_r4020_info_pgto>-dm_jud           = ''.
***      <knw_reinf_r4020_info_pgto>-cd_pais_resid    = ''. "Abrir quando nao for Brasil (Código Bacen)
***      <knw_reinf_r4020_info_pgto>-dt_escr_cont     = ''.
***
***      READ TABLE ls_root-knw_reinf_r4020_info_pgto_ret ASSIGNING FIELD-SYMBOL(<r4020_info_pgto_ret>) WITH KEY id_referencia = lv_id.
***      IF sy-subrc IS NOT INITIAL.
***        APPEND INITIAL LINE TO ls_root-knw_reinf_r4020_info_pgto_ret ASSIGNING <r4020_info_pgto_ret>.
***      ENDIF.
***      <r4020_info_pgto_ret>-cd_empresa       = gs_branch_sov-sov_company.
***      <r4020_info_pgto_ret>-cd_filial        = gs_branch_sov-sov_branch.
***      <r4020_info_pgto_ret>-id_referencia    = lv_id.
***      <r4020_info_pgto_ret>-id_seq_pagto     = <knw_reinf_r4020_info_pgto>-id_seq_pagto.
***      <r4020_info_pgto_ret>-id_seq_info_pgto = <knw_reinf_r4020_info_pgto>-id_seq_info_pgto.
***
***      READ TABLE mt_irf_types WITH KEY categoriairf = ls_data-withholdingtaxtype INTO DATA(ls_irf_type).
***      CASE ls_irf_type-imposto.
***        WHEN 'IR'.
***          <r4020_info_pgto_ret>-vl_ir             += abs( ls_data-withholdingtaxamtintransaccrcy ).
***          <r4020_info_pgto_ret>-vl_base_ir        = abs( ls_data-withholdingtaxbaseamtincocode ).
***        WHEN 'CSLL'.
***          <r4020_info_pgto_ret>-vl_csll           += abs( ls_data-withholdingtaxamtintransaccrcy ).
***          <r4020_info_pgto_ret>-vl_base_csll      = abs( ls_data-withholdingtaxbaseamtincocode ).
***        WHEN 'COFINS' .
***          <r4020_info_pgto_ret>-vl_cofins         += abs( ls_data-withholdingtaxamtintransaccrcy ).
***          <r4020_info_pgto_ret>-vl_base_cofins    = abs( ls_data-withholdingtaxbaseamtincocode ).
***        WHEN 'PIS'.
***          <r4020_info_pgto_ret>-vl_pis_pasep      += abs( ls_data-withholdingtaxamtintransaccrcy ).
***          <r4020_info_pgto_ret>-vl_base_pis_pasep = abs( ls_data-withholdingtaxbaseamtincocode ).
***        WHEN 'PCC'.
***          <r4020_info_pgto_ret>-vl_agreg          += abs( ls_data-withholdingtaxamtintransaccrcy ).
***          <r4020_info_pgto_ret>-vl_base_agreg     = abs( ls_data-withholdingtaxbaseamtincocode ).
***      ENDCASE.
***      CASE ls_nfs-taxgroup.
***        WHEN 'IRRF' OR 'WHIR' OR 'WAIR'. "Imposto de Renda
***          <r4020_info_pgto_ret>-vl_ir             = ls_nfs-br_nfitemtaxamount.
***          <r4020_info_pgto_ret>-vl_base_ir        = ls_nfs-br_nfitembaseamount.
***        WHEN 'WACS' OR 'WHCS'. "CSLL'.
***          <r4020_info_pgto_ret>-vl_csll           = ls_nfs-br_nfitemtaxamount.
***          <r4020_info_pgto_ret>-vl_base_csll      = ls_nfs-br_nfitembaseamount.
***        WHEN 'COFI' OR 'WHCO' OR 'WACO'. .
***          <r4020_info_pgto_ret>-vl_cofins         = ls_nfs-br_nfitemtaxamount.
***          <r4020_info_pgto_ret>-vl_base_cofins    = ls_nfs-br_nfitembaseamount.
***        WHEN 'PIS' OR 'WHPI' OR 'WAPI'.
***          <r4020_info_pgto_ret>-vl_pis_pasep      = ls_nfs-br_nfitemtaxamount.
***          <r4020_info_pgto_ret>-vl_base_pis_pasep = ls_nfs-br_nfitembaseamount.
***        WHEN 'WAT' OR 'WHT'.
***          <r4020_info_pgto_ret>-vl_agreg          = ls_nfs-br_nfitemtaxamount.
***          <r4020_info_pgto_ret>-vl_base_agreg     = ls_nfs-br_nfitembaseamount.
***      ENDCASE.
***
***    ENDLOOP.
***
***      "KNW_REINF_R4020_INFO_PGTO_EXT, abrir quando for fornecedor estrangeiro (por doc contábil)
***
***    ENDLOOP.
***
  ENDMETHOD.