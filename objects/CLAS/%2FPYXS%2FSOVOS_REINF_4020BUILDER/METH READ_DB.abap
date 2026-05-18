  METHOD read_db.

    DATA: lr_irf_types TYPE RANGE OF i_withholdingtaxitem-withholdingtaxtype,
          lt_data_it   TYPE TABLE OF ty_tax_item.

    SELECT * FROM /pyxs/sov_taxtype_irf INTO TABLE @mt_irf_types.
    SELECT * FROM /pyxs/sov_natren INTO TABLE @mt_nature.

    LOOP AT mt_irf_types INTO DATA(ls_irf_type).
      CHECK ls_irf_type-imposto <> 'IR'.
      APPEND VALUE #( sign = 'I' option = 'EQ' low = ls_irf_type-categoriairf ) TO lr_irf_types.
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
              nf~br_nfpartnername1, nfi~br_lc116servicecode, nf~br_nftotalamount
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
               "AND nf~br_notafiscal               IN @sel-br_notafiscal
               "AND nft~br_nfitemhaswithholdingtax = 'X'
         INTO TABLE @gt_nfs.
      ENDIF.
    ENDIF.

    CLEAR lr_irf_types.
    LOOP AT mt_irf_types INTO ls_irf_type.
      CHECK ls_irf_type-imposto = 'IR'.
      APPEND VALUE #( sign = 'I' option = 'EQ' low = ls_irf_type-categoriairf ) TO lr_irf_types.
    ENDLOOP.

    IF lr_irf_types IS NOT INITIAL.

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
       WHERE wit~whldgtaxbaseamtincocodecrcy <> 0
         AND jo~postingdate IN @sel-creation
         AND wit~companycode = @sel-company
         AND joi~ledger      = '0L'
         AND wit~withholdingtaxtype IN @lr_irf_types
       INTO TABLE @lt_data_it.

      IF lt_data_it IS NOT INITIAL.

        APPEND LINES OF lt_data_it TO gt_data.

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
*     ON jo~OriginalReferenceDocument = nfi~BR_NFSourceDocumentNumber
         INNER JOIN i_br_nfdocument AS nf
                 ON nf~br_notafiscal = nfi~br_notafiscal
         INNER JOIN i_br_nftax AS nft
                 ON nf~br_notafiscal = nft~br_notafiscal
                AND nfi~br_notafiscalitem = nft~br_notafiscalitem
                FOR ALL ENTRIES IN @lt_data_it
             WHERE nfi~br_nfsourcedocumentnumber  = @lt_data_it-originalreferencedocument
               AND nf~businessplace               = @sel-branch
               AND nf~br_nfpartner                IN @sel-partner
               "AND nf~br_notafiscal               IN @sel-br_notafiscal
               "AND nft~br_nfitemhaswithholdingtax = 'X'
         APPENDING TABLE @gt_nfs.
      ENDIF.

    ENDIF.

    SORT gt_data BY companycode accountingdocument fiscalyear accountingdocumentitem.

  ENDMETHOD.