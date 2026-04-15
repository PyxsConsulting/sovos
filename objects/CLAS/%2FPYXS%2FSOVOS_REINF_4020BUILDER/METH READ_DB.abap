  METHOD read_db.

*    SELECT *
*      FROM i_br_nfdocument AS doc
*      WHERE doc~companycode = @sel-company
*        AND doc~businessplace = @sel-branch
*        AND doc~creationdate IN @sel-creation
*        AND doc~br_nfdocumenttype IN @sel-category
*        AND doc~br_notafiscal IN @sel-document
*        AND doc~br_nfissuedate IN @sel-docdate
*        AND doc~br_nfpostingdate IN @sel-pstdate
*        AND doc~br_nfarrivalordeparturedate IN @sel-dsaient
*        AND doc~lastchangedate IN @sel-changed
*        AND doc~br_nfhasserviceitem = 'X'
*      INTO TABLE @mt_doc.
*
*    IF mt_doc IS NOT INITIAL.
*      SELECT *
*        FROM i_br_nfitem AS itm
*        FOR ALL ENTRIES IN @mt_doc
*        WHERE itm~br_notafiscal = @mt_doc-br_notafiscal
*        INTO TABLE @mt_itm.
*
*      IF mt_itm IS NOT INITIAL.
*
*        SELECT *
*          FROM i_br_nftax AS tax
*          FOR ALL ENTRIES IN @mt_itm
*          WHERE tax~br_notafiscal = @mt_itm-br_notafiscal
*            AND tax~br_notafiscalitem = @mt_itm-br_notafiscalitem
*          INTO TABLE @mt_tax.
*
*      ENDIF.
*
*      SELECT * FROM /pyxs/sov_natren INTO TABLE @mt_nature.
*
*      SELECT SINGLE *
*        FROM /pyxs/sov_branch
*      WHERE company_code = @sel-company
*        AND branch = @sel-branch
*        INTO @gs_branch_sov.
*
*    ENDIF.
*
*    SORT mt_doc BY br_nfpartner.

    SELECT wit~companycode, wit~accountingdocument, wit~fiscalyear, wit~accountingdocumentitem,
           wit~withholdingtaxtype, wit~withholdingtaxcode, wit~whldgtaxbaseamtincocodecrcy,
           wit~whldgtaxamtintransaccrcy, wit~clearingdate, wit~clearingaccountingdocument,
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
       AND wit~clearingdate IN @sel-creation
       AND wit~companycode = @sel-company
       AND joi~ledger      = '0L'
     INTO TABLE @gt_data.

    SELECT nfi~br_notafiscal, nfi~br_notafiscalitem, nfi~br_nfsourcedocumenttype, nfi~br_nfsourcedocumentnumber, "#EC CI_NO_TRANSFORM
          nfi~br_nfsourcedocumentitem, nf~br_nftype, nf~br_nfdirection, nf~br_nfissuedate, nf~br_nfmodel,
          nf~br_nfseries, nf~br_nfsubseries, nf~br_nfnumber, nf~businessplace,
          nf~br_nfpartnerfunction, nf~br_nfpartner, nf~br_nfpartnertype,
          nf~br_nfiscanceled, nf~br_nfsnumber, nf~br_isnfe, nf~br_nfenumber,
          nf~br_nfhasserviceitem, nf~br_nfissuedby, nf~br_nfsituationcode,
          nft~br_taxtype, nft~br_nfitembaseamount, nft~br_nfitemtaxrate,
          nft~br_nfitemtaxamount, nft~br_nfitemwhldgcollectioncode, nft~taxgroup, nf~br_businessplacecnpj, nf~br_nfpartnercnpj,
          nf~br_nfpartnername1, nfi~br_lc116servicecode
     FROM i_br_nfitem AS nfi
*     ON jo~OriginalReferenceDocument = nfi~BR_NFSourceDocumentNumber
     INNER JOIN i_br_nfdocument AS nf
             ON nf~br_notafiscal = nfi~br_notafiscal
     INNER JOIN i_br_nftax AS nft
             ON nf~br_notafiscal = nft~br_notafiscal
            AND nfi~br_notafiscalitem = nft~br_notafiscalitem
            FOR ALL ENTRIES IN @gt_data
         WHERE nfi~br_nfsourcedocumentnumber  = @gt_data-originalreferencedocument
           "AND nf~br_notafiscal               IN @sel-br_notafiscal
           AND nft~br_nfitemhaswithholdingtax = 'X'
     INTO TABLE @gt_nfs.

  ENDMETHOD.