  METHOD build_r4020_new.

    TYPES: BEGIN OF ty_id_seq_pagto,
             id                  TYPE c LENGTH 100,
             id_seq_pagto        TYPE int4,
             id_seq_info_pgto    TYPE int4,
             last_accounting_doc TYPE c LENGTH 10,  " ajuste o length conforme o tipo de accountingdocument
           END OF ty_id_seq_pagto.

    DATA: lv_prev_partner TYPE i_br_nfdocument-br_nfpartner.
    DATA: ls_knw_r4020         TYPE ty_knw_r4020,
          ls_knw_pgto          TYPE  ty_pgto,
          ls_knw_info_pgto     TYPE  ty_info_pgto,
          ls_knw_info_pgto_ret TYPE  ty_info_pgto_ret.

    DATA: lt_id_seq_pagto TYPE TABLE OF ty_id_seq_pagto.

    LOOP AT gt_data INTO DATA(ls_data).
      LOOP AT gt_nfs INTO DATA(ls_nfs)
                WHERE br_nfsourcedocumentnumber =  ls_data-originalreferencedocument
                AND taxgroup IN conv_with_stx( witht = ls_data-withholdingtaxtype ).


        DATA(lv_seq_key)     = ls_nfs-br_nfpartner.
        DATA(lv_doc_key)     = |{ ls_nfs-br_nfpartner }{ ls_data-accountingdocument }|.

        " Verifica se esse accountingdocument já foi registrado para esse partner
        READ TABLE lt_id_seq_pagto ASSIGNING FIELD-SYMBOL(<ls_id_seq_pagto>)
          WITH KEY id = lv_doc_key.

        IF sy-subrc IS INITIAL.
          " Mesmo partner + mesmo doc: reutiliza o sequencial já atribuído
          DATA(lv_id_seq_pagto)     = <ls_id_seq_pagto>-id_seq_pagto.
          DATA(lv_id_seq_info_pgto) = <ls_id_seq_pagto>-id_seq_info_pgto.
        ELSE.
          " Novo doc para esse partner: conta quantos docs esse partner já tem
          DATA(lv_count) = REDUCE int4(
            INIT n = 0
            FOR ls_seq IN lt_id_seq_pagto
            WHERE ( id CS lv_seq_key )
            NEXT n = n + 1
          ).

          lv_id_seq_pagto     = lv_count + 1.
          lv_id_seq_info_pgto = lv_count + 1.

          APPEND VALUE ty_id_seq_pagto(
            id               = lv_doc_key
            id_seq_pagto     = lv_id_seq_pagto
            id_seq_info_pgto = lv_id_seq_info_pgto
          ) TO lt_id_seq_pagto.
        ENDIF.

        DATA(lv_id) = |{ ls_data-clearingdate(6) }{  ls_nfs-br_nfpartner }|.
        READ TABLE ls_root-knw_r4020 ASSIGNING FIELD-SYMBOL(<ls_knw_r4020>) WITH KEY id_referencia = lv_id.
        IF sy-subrc IS NOT INITIAL.
          APPEND INITIAL LINE TO ls_root-knw_r4020 ASSIGNING <ls_knw_r4020>.
          <ls_knw_r4020>-cd_empresa         = gs_branch_sov-sov_company.
          <ls_knw_r4020>-cd_filial          = gs_branch_sov-sov_branch.
          <ls_knw_r4020>-id_referencia      = |{ ls_data-clearingdate(6) }{ ls_nfs-br_nfpartner }|.
          <ls_knw_r4020>-id_evento          = '1'.
          <ls_knw_r4020>-dm_retificacao     = '1'.
          <ls_knw_r4020>-dt_apuracao        = ls_data-clearingdate.
          <ls_knw_r4020>-nr_inscricao_estab = ls_nfs-br_businessplacecnpj.
          <ls_knw_r4020>-nr_cnpj_benef      = ls_nfs-br_nfpartnercnpj.
          <ls_knw_r4020>-nm_benef           = ls_nfs-br_nfpartnername1.
          <ls_knw_r4020>-ide_evt_adic       = ''.
        ENDIF.

        DATA(lv_natureza) = get_nat_ren( |{ ls_nfs-br_lc116servicecode }| ).
        lv_id = |{ lv_id }{ lv_natureza }|. "colocar a br_notafiscal nesse ID vai quebrar por nf tbm
        READ TABLE ls_root-knw_reinf_r4020_pgto ASSIGNING FIELD-SYMBOL(<knw_reinf_r4020_pgt>) WITH KEY id_referencia = lv_id.
        IF sy-subrc IS NOT INITIAL.
          APPEND INITIAL LINE TO ls_root-knw_reinf_r4020_pgto ASSIGNING <knw_reinf_r4020_pgt>.
        ENDIF.
        <knw_reinf_r4020_pgt>-cd_empresa    = gs_branch_sov-sov_company.
        <knw_reinf_r4020_pgt>-cd_filial     = gs_branch_sov-sov_branch.
        <knw_reinf_r4020_pgt>-id_referencia = lv_id.
        <knw_reinf_r4020_pgt>-id_seq_pagto  = lv_id_seq_pagto.
        <knw_reinf_r4020_pgt>-nr_nat_rend   = get_nat_ren( |{ ls_nfs-br_lc116servicecode }| ).
        <knw_reinf_r4020_pgt>-ds_observacao = ''."ms_doc-br_nfobservationtext.

        lv_id = |{ lv_id }{ ls_data-accountingdocument }|. "colocar a br_notafiscal nesse ID vai quebrar por nf tbm

        READ TABLE ls_root-knw_reinf_r4020_info_pgto ASSIGNING FIELD-SYMBOL(<knw_reinf_r4020_info_pgto>)
        WITH KEY id_referencia = lv_id.
        IF sy-subrc IS NOT INITIAL.
          APPEND INITIAL LINE TO ls_root-knw_reinf_r4020_info_pgto ASSIGNING <knw_reinf_r4020_info_pgto>.
        ENDIF.
        <knw_reinf_r4020_info_pgto>-cd_empresa       = gs_branch_sov-sov_company.
        <knw_reinf_r4020_info_pgto>-cd_filial        = gs_branch_sov-sov_branch.
        <knw_reinf_r4020_info_pgto>-id_referencia    = lv_id.
        <knw_reinf_r4020_info_pgto>-id_seq_pagto     = <knw_reinf_r4020_pgt>-id_seq_pagto.
        <knw_reinf_r4020_info_pgto>-id_seq_info_pgto = lv_id_seq_info_pgto.
        <knw_reinf_r4020_info_pgto>-dt_fato_gerador  = format_date( iv_date = ls_data-clearingdate ).
        <knw_reinf_r4020_info_pgto>-vl_bruto         = format_amount( iv_value = ls_nfs-br_nfitemtaxamount ).
        <knw_reinf_r4020_info_pgto>-ds_observ        = ''. "ls_nfs-br_nfobservationtext.
        <knw_reinf_r4020_info_pgto>-dm_fci_scp       = ''.
        <knw_reinf_r4020_info_pgto>-nr_insc_fci_scp  = ''.
        <knw_reinf_r4020_info_pgto>-nr_perc_scp      = ''.
        <knw_reinf_r4020_info_pgto>-dm_jud           = 'S'.
        <knw_reinf_r4020_info_pgto>-cd_pais_resid    = '1058'.
        <knw_reinf_r4020_info_pgto>-dt_escr_cont     = format_date( iv_date = ls_nfs-br_nfissuedate ).

        READ TABLE ls_root-knw_reinf_r4020_info_pgto_ret ASSIGNING FIELD-SYMBOL(<r4020_info_pgto_ret>) WITH KEY id_referencia = lv_id.
        IF sy-subrc IS NOT INITIAL.
          APPEND INITIAL LINE TO ls_root-knw_reinf_r4020_info_pgto_ret ASSIGNING <r4020_info_pgto_ret>.
        ENDIF.
        <r4020_info_pgto_ret>-cd_empresa       = gs_branch_sov-sov_company.
        <r4020_info_pgto_ret>-cd_filial        = gs_branch_sov-sov_branch.
        <r4020_info_pgto_ret>-id_referencia    = lv_id.
        <r4020_info_pgto_ret>-id_seq_pagto     = <knw_reinf_r4020_info_pgto>-id_seq_pagto.
        <r4020_info_pgto_ret>-id_seq_info_pgto = <knw_reinf_r4020_info_pgto>-id_seq_info_pgto.

        CASE ls_nfs-taxgroup.
          WHEN 'IRRF' OR 'WHIR' OR 'WAIR'. "Imposto de Renda
            <r4020_info_pgto_ret>-vl_ir             = ls_nfs-br_nfitemtaxamount.
            <r4020_info_pgto_ret>-vl_base_ir        = ls_nfs-br_nfitembaseamount.
          WHEN 'WACS' OR 'WHCS'. "CSLL'.
            <r4020_info_pgto_ret>-vl_csll           = ls_nfs-br_nfitemtaxamount.
            <r4020_info_pgto_ret>-vl_base_csll      = ls_nfs-br_nfitembaseamount.
          WHEN 'COFI' OR 'WHCO' OR 'WACO'. .
            <r4020_info_pgto_ret>-vl_cofins         = ls_nfs-br_nfitemtaxamount.
            <r4020_info_pgto_ret>-vl_base_cofins    = ls_nfs-br_nfitembaseamount.
          WHEN 'PIS' OR 'WHPI' OR 'WAPI'.
            <r4020_info_pgto_ret>-vl_pis_pasep      = ls_nfs-br_nfitemtaxamount.
            <r4020_info_pgto_ret>-vl_base_pis_pasep = ls_nfs-br_nfitembaseamount.
          WHEN 'WAT' OR 'WHT'.
            <r4020_info_pgto_ret>-vl_agreg          = ls_nfs-br_nfitemtaxamount.
            <r4020_info_pgto_ret>-vl_base_agreg     = ls_nfs-br_nfitembaseamount.
        ENDCASE.

      ENDLOOP.
    ENDLOOP.

  ENDMETHOD.