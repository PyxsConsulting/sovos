  METHOD build_r4020.
    DATA: lv_prev_partner TYPE i_br_nfdocument-br_nfpartner.
    DATA: ls_knw_r4020         TYPE ty_knw_r4020,
          ls_knw_pgto          TYPE  ty_pgto,
          ls_knw_info_pgto     TYPE  ty_info_pgto,
          ls_knw_info_pgto_ret TYPE  ty_info_pgto_ret.

    LOOP AT mt_doc INTO DATA(ms_doc).

      ms_doc-companycode = gs_branch_sov-sov_company.
      ms_doc-businessplace = gs_branch_sov-sov_branch.

      READ TABLE ls_root-knw_r4020 INTO ls_knw_r4020 WITH KEY id_referencia = |{ ms_doc-br_nfpostingdate(6) }{  ms_doc-br_nfpartner }|.
      IF sy-subrc IS NOT INITIAL.
        ls_knw_r4020-cd_empresa         = ms_doc-companycode.
        ls_knw_r4020-cd_filial          = ms_doc-businessplace.
        ls_knw_r4020-id_referencia      = |{ ms_doc-br_nfpostingdate(6) }{  ms_doc-br_nfpartner }|.
        ls_knw_r4020-id_evento          = '1'.
        ls_knw_r4020-dm_retificacao     = '1'.
        ls_knw_r4020-dt_apuracao        = ms_doc-br_nfissuedate.
        ls_knw_r4020-nr_inscricao_estab = ms_doc-br_businessplacecnpj.
        ls_knw_r4020-nr_cnpj_benef      = ms_doc-br_nfpartnercnpj.
        ls_knw_r4020-nm_benef           = ms_doc-br_nfpartnername1.
        ls_knw_r4020-ide_evt_adic       = ms_doc-br_nfissuedate.
        APPEND ls_knw_r4020 TO ls_root-knw_r4020.

        DATA(lv_id) = |{ ms_doc-br_nfpostingdate(6) }{  ms_doc-br_nfpartner }|. "colocar a br_notafiscal nesse ID vai quebrar por nf tbm

        READ TABLE ls_root-knw_reinf_r4020_info_pgto ASSIGNING FIELD-SYMBOL(<tot>)
        WITH KEY id_referencia = lv_id.
        IF sy-subrc IS NOT INITIAL.
          APPEND INITIAL LINE TO ls_root-knw_reinf_r4020_info_pgto ASSIGNING <tot>.
          <tot>-cd_empresa       = ms_doc-companycode.
          <tot>-cd_filial        = ms_doc-businessplace.
          <tot>-id_referencia    = lv_id.
          <tot>-id_seq_pagto     = '1'.
          <tot>-id_seq_info_pgto = '1'.
          <tot>-dt_fato_gerador  = format_date( iv_date = ms_doc-br_nfissuedate ).
          <tot>-vl_bruto         = format_amount( iv_value = ms_doc-br_nftotalamount ).
          <tot>-ds_observ        = ms_doc-br_nfobservationtext.
          <tot>-dm_fci_scp       = '1'.
          <tot>-nr_insc_fci_scp  = '00000000000004'.
          <tot>-nr_perc_scp      = '25'.
          <tot>-dm_jud           = 'S'.
          <tot>-cd_pais_resid    = '057'.
          <tot>-dt_escr_cont     = format_date( iv_date = ms_doc-br_nfissuedate ).
        ELSE.

        ENDIF.
      ENDIF.

      LOOP AT mt_itm INTO DATA(ls_itm) WHERE br_notafiscal = ms_doc-br_notafiscal.
        READ TABLE ls_root-knw_reinf_r4020_pgto ASSIGNING FIELD-SYMBOL(<itm>) WITH KEY id_referencia = |{ ls_itm-br_lc116servicecode }{ ms_doc-br_nfpostingdate(6) }{  ms_doc-br_nfpartner }|.
        IF sy-subrc IS NOT INITIAL.
          APPEND INITIAL LINE TO ls_root-knw_reinf_r4020_pgto ASSIGNING <itm>.
          <itm>-cd_empresa    = ms_doc-companycode.
          <itm>-cd_filial     = ms_doc-businessplace.
          <itm>-id_referencia = |{ ls_itm-br_lc116servicecode }{ ms_doc-br_nfpostingdate(6) }{  ms_doc-br_nfpartner }|.
          <itm>-id_seq_pagto  = '1'.
          <itm>-nr_nat_rend   = get_nat_ren( |{ ls_itm-br_lc116servicecode }| ).
          <itm>-ds_observacao = ms_doc-br_nfobservationtext.
        ENDIF.

        LOOP AT mt_tax INTO DATA(ls_tax) WHERE br_notafiscal = ms_doc-br_notafiscal AND br_notafiscalitem = ls_itm-br_notafiscalitem.
          READ TABLE ls_root-knw_reinf_r4020_info_pgto_ret ASSIGNING FIELD-SYMBOL(<tax>) WITH KEY id_referencia = lv_id.
          IF sy-subrc IS NOT INITIAL.
            APPEND INITIAL LINE TO ls_root-knw_reinf_r4020_info_pgto_ret ASSIGNING <tax>.
            <tax>-cd_empresa       = ms_doc-companycode.
            <tax>-cd_filial        = ms_doc-businessplace.
            <tax>-id_referencia    = mv_br_notafiscal.
            <tax>-id_seq_pagto     = '1'.
            <tax>-id_seq_info_pgto = '1'.

            CASE ls_tax-taxgroup.
              WHEN 'IRRF' OR 'WHIR' OR 'WAIR'. "Imposto de Renda
                <tax>-vl_ir             = ls_tax-br_nfitemtaxamount.
                <tax>-vl_base_ir        = ls_tax-br_nfitembaseamount.
              WHEN 'WACS' OR 'WHCS'. "CSLL'.
                <tax>-vl_csll           = ls_tax-br_nfitemtaxamount.
                <tax>-vl_base_csll      = ls_tax-br_nfitembaseamount.
              WHEN 'COFI' OR 'WHCO' OR 'WACO'. .
                <tax>-vl_cofins         = ls_tax-br_nfitemtaxamount.
                <tax>-vl_base_cofins    = ls_tax-br_nfitembaseamount.
              WHEN 'PIS' OR 'WHPI' OR 'WAPI'.
                <tax>-vl_pis_pasep      = ls_tax-br_nfitemtaxamount.
                <tax>-vl_base_pis_pasep = ls_tax-br_nfitembaseamount.
              WHEN 'WAT' OR 'WHT'.
                <tax>-vl_agreg             = ls_tax-br_nfitemtaxamount.
                <tax>-vl_base_agreg        = ls_tax-br_nfitembaseamount.
            ENDCASE.
          ELSE.
            CASE ls_tax-taxgroup.
              WHEN 'IRRF' OR 'WHIR' OR 'WAIR'. "Imposto de Renda
                <tax>-vl_ir             += ls_tax-br_nfitemtaxamount.
                <tax>-vl_base_ir        += ls_tax-br_nfitembaseamount.
              WHEN 'WACS' OR 'WHCS'. "CSLL'.
                <tax>-vl_csll           += ls_tax-br_nfitemtaxamount.
                <tax>-vl_base_csll      += ls_tax-br_nfitembaseamount.
              WHEN 'COFI' OR 'WHCO' OR 'WACO'. .
                <tax>-vl_cofins         += ls_tax-br_nfitemtaxamount.
                <tax>-vl_base_cofins    += ls_tax-br_nfitembaseamount.
              WHEN 'PIS' OR 'WHPI' OR 'WAPI'.
                <tax>-vl_pis_pasep      += ls_tax-br_nfitemtaxamount.
                <tax>-vl_base_pis_pasep += ls_tax-br_nfitembaseamount.
              WHEN 'WAT' OR 'WHT'.
                <tax>-vl_agreg          += ls_tax-br_nfitemtaxamount.
                <tax>-vl_base_agreg     += ls_tax-br_nfitembaseamount.
            ENDCASE.
          ENDIF.

        ENDLOOP.
      ENDLOOP.
    ENDLOOP.

  ENDMETHOD.