  METHOD build_r1000.

    DATA ls_r1000 TYPE ty_r1000.
    DATA: lv_prev_partner TYPE i_br_nfdocument-br_nfpartner.

    LOOP AT mt_doc INTO DATA(ms_doc).
      IF lv_prev_partner IS INITIAL.
        lv_prev_partner = ms_doc-br_nfpartner.
      ELSEIF lv_prev_partner <> ms_doc-br_nfpartner.
        APPEND ls_r1000 TO gt_r1000.
      ENDIF.

      ls_r1000-cd_empresa      = ms_doc-companycode.
      ls_r1000-cd_filial       = ms_doc-businessplace.
      ls_r1000-nr_inscricao = clean_cnpj( CONV string( ms_doc-br_businessplacecnpj ) ).
      ls_r1000-nm_razao_social = ''.
      ls_r1000-nm_fantasia     = ''.
      ls_r1000-id_referencia   = ms_doc-br_nfpostingdate(6) && ms_doc-br_nfpartner.

      ls_r1000-cd_operacao         = 'INCLUSAO'.
      ls_r1000-dm_inscricao        = '1'.
      ls_r1000-dm_inscrituracao    = '1'.
      ls_r1000-dm_desoneracao      = '0'.
      ls_r1000-dm_isencao          = '0'.
      ls_r1000-dm_situacao         = '0'.
      ls_r1000-dm_efr              = 'N'.

      ls_r1000-dt_inicio_validade = format_date( ms_doc-br_nfissuedate ).

    ENDLOOP.

  ENDMETHOD.