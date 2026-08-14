  METHOD read_db.

       TYPES: BEGIN OF ty_oreftab,
         originalreferencedocument TYPE i_journalentry-originalreferencedocument,
       END OF ty_oreftab.


       DATA: lr_irf_types TYPE RANGE OF i_withholdingtaxitem-withholdingtaxtype,
***          lt_data_it   TYPE TABLE OF ty_tax_item,
             lt_nfs_ir    TYPE TABLE OF ty_nf_item.

       DATA lt_oreftab TYPE SORTED TABLE OF ty_oreftab
                        WITH UNIQUE KEY originalreferencedocument.


    SELECT * FROM /pyxs/sov_taxtype_irf INTO TABLE @mt_irf_types.
    SELECT * FROM /pyxs/sov_natren INTO TABLE @mt_nature.

    SELECT SINGLE *
      FROM /pyxs/sov_branch
    WHERE company_code = @sel-company
      AND branch = @sel-branch
      INTO @gs_branch_sov.

    LOOP AT mt_irf_types INTO DATA(ls_irf_type).
      IF ls_irf_type-Usardatapagto = abap_true.
        APPEND VALUE #( sign = 'I' option = 'EQ' low = ls_irf_type-categoriairf ) TO lr_irf_types.
      ENDIF.
    ENDLOOP.

    IF lr_irf_types IS NOT INITIAL.

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
       WHERE wit~whldgtaxbaseamtincocodecrcy <> 0
         AND joi~clearingdate IN @sel-creation
         AND wit~companycode = @sel-company
         AND joi~ledger      = '0L'
         AND wit~withholdingtaxtype IN @lr_irf_types
       INTO TABLE @gt_data.

      IF gt_data IS NOT INITIAL.
        SELECT nfi~br_notafiscal, nfi~br_notafiscalitem, nfi~br_nfsourcedocumenttype, nfi~br_nfsourcedocumentnumber, "#EC CI_NO_TRANSFORM
              nfi~br_nfsourcedocumentitem, nf~br_nftype, nf~br_nfdirection, nf~br_nfissuedate, nf~br_nfmodel,
              nf~br_nfseries, nf~br_nfsubseries, nf~br_nfnumber, nf~businessplace,
              nf~br_nfpartnerfunction, nf~br_nfpartner, nf~br_nfpartnertype,
              nf~br_nfiscanceled, nf~br_nfsnumber, nf~br_isnfe, nf~br_nfenumber,
              nf~br_nfhasserviceitem, nf~br_nfissuedby, nf~br_nfsituationcode,
              nft~br_taxtype, nft~br_nfitembaseamount, nft~br_nfitemtaxrate,
              nft~br_nfitemtaxamount, nft~br_nfitemwhldgcollectioncode, nft~taxgroup, nf~br_businessplacecnpj, nf~br_nfpartnercnpj,
              nf~br_nfpartnername1, nfi~br_lc116servicecode, nf~br_nftotalamount, nf~br_nfpostingdate
         FROM i_br_nfitem AS nfi
*     ON jo~OriginalReferenceDocument = nfi~BR_NFSourceDocumentNumber
         INNER JOIN i_br_nfdocument AS nf
                 ON nf~br_notafiscal = nfi~br_notafiscal
         INNER JOIN i_br_nftax AS nft
                 ON nf~br_notafiscal = nft~br_notafiscal
                AND nfi~br_notafiscalitem = nft~br_notafiscalitem
                FOR ALL ENTRIES IN @gt_data
             WHERE nfi~br_nfsourcedocumentnumber  = @gt_data-originalreferencedocument
               AND nf~businessplace               = @sel-branch
               AND nf~br_nfpartner                IN @sel-partner
               AND nf~br_notafiscal               IN @sel-document
               "AND nft~br_nfitemhaswithholdingtax = 'X'
         INTO TABLE @gt_nfs.
      ENDIF.
    ENDIF.

    CLEAR lr_irf_types.
    LOOP AT mt_irf_types INTO ls_irf_type.
      IF ls_irf_type-Usardatapagto = abap_false.
        APPEND VALUE #( sign = 'I' option = 'EQ' low = ls_irf_type-categoriairf ) TO lr_irf_types.
      ENDIF.
    ENDLOOP.

    IF lr_irf_types IS NOT INITIAL.

        SELECT nfi~br_notafiscal, nfi~br_notafiscalitem, nfi~br_nfsourcedocumenttype, nfi~br_nfsourcedocumentnumber, "#EC CI_NO_TRANSFORM
              nfi~br_nfsourcedocumentitem, nf~br_nftype, nf~br_nfdirection, nf~br_nfissuedate, nf~br_nfmodel,
              nf~br_nfseries, nf~br_nfsubseries, nf~br_nfnumber, nf~businessplace,
              nf~br_nfpartnerfunction, nf~br_nfpartner, nf~br_nfpartnertype,
              nf~br_nfiscanceled, nf~br_nfsnumber, nf~br_isnfe, nf~br_nfenumber,
              nf~br_nfhasserviceitem, nf~br_nfissuedby, nf~br_nfsituationcode,
              nft~br_taxtype, nft~br_nfitembaseamount, nft~br_nfitemtaxrate,
              nft~br_nfitemtaxamount, nft~br_nfitemwhldgcollectioncode, nft~taxgroup, nf~br_businessplacecnpj, nf~br_nfpartnercnpj,
              nf~br_nfpartnername1, nfi~br_lc116servicecode, nf~br_nftotalamount
         FROM i_br_nfitem AS nfi
         INNER JOIN i_br_nfdocument AS nf
                 ON nf~br_notafiscal = nfi~br_notafiscal
         INNER JOIN i_br_nftax AS nft
                 ON nf~br_notafiscal = nft~br_notafiscal
                AND nfi~br_notafiscalitem = nft~br_notafiscalitem
             WHERE nf~br_nfpostingdate IN @sel-creation
               "AND nfi~br_nfsourcedocumentnumber  = @lt_data_it-originalreferencedocument
               AND nf~businessplace               = @sel-branch
               AND nf~br_nfpartner                IN @sel-partner
               AND nf~br_notafiscal               IN @sel-document
               "AND nft~br_nfitemhaswithholdingtax = 'X'
         APPENDING TABLE @gt_nfs.

           LOOP AT gt_nfs INTO DATA(ls_nfs_aux).
             INSERT VALUE ty_oreftab(
                      originalreferencedocument = ls_nfs_aux-br_nfsourcedocumentnumber )
               INTO TABLE lt_oreftab.
           ENDLOOP.

          SELECT wit~companycode, wit~accountingdocument, wit~fiscalyear, wit~accountingdocumentitem,
                 wit~withholdingtaxtype, wit~withholdingtaxcode, wit~whldgtaxbaseamtincocodecrcy,
                 wit~whldgtaxamtintransaccrcy, jo~postingdate AS clearingdate, wit~clearingaccountingdocument,
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
             AND wit~companycode = @sel-company
             AND joi~ledger      = '0L'
             AND wit~withholdingtaxtype IN @lr_irf_types
           APPENDING TABLE @gt_data.

***      IF lt_data_it IS NOT INITIAL.
***        APPEND LINES OF lt_data_it TO gt_data.
***      ENDIF.

    ENDIF.

    SORT gt_data BY companycode accountingdocument fiscalyear accountingdocumentitem.

  ENDMETHOD.