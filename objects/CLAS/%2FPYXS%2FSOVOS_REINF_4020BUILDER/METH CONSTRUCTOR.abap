  METHOD constructor.

    sel-company = iv_company_doce.
    sel-branch = iv_business_place.
    IF iv_date_begin IS NOT INITIAL AND iv_date_end IS INITIAL.
      sel-creation = VALUE #( ( sign = 'I' option = 'EQ' low = iv_date_begin high = iv_date_end ) ).
    ELSEIF iv_date_begin IS NOT INITIAL AND iv_date_end IS NOT INITIAL.
      sel-creation = VALUE #( ( sign = 'I' option = 'BT' low = iv_date_begin high = iv_date_end ) ).
    ENDIF.
    IF iv_br_notafiscal IS NOT INITIAL.
      sel-document = VALUE #( ( sign = 'I' option = 'EQ' low = iv_br_notafiscal ) ).
    ENDIF.

    mv_br_notafiscal = iv_br_notafiscal.


    SELECT *
      FROM i_br_nfdocument AS doc
      WHERE doc~companycode = @sel-company
        AND doc~businessplace = @sel-branch
        AND doc~creationdate IN @sel-creation
        AND doc~br_nfdocumenttype IN @sel-category
        AND doc~br_notafiscal IN @sel-document
        AND doc~br_nfissuedate IN @sel-docdate
        AND doc~br_nfpostingdate IN @sel-pstdate
        AND doc~br_nfarrivalordeparturedate IN @sel-dsaient
        AND doc~lastchangedate IN @sel-changed
        AND doc~br_nfhasserviceitem = 'X'
      INTO TABLE @mt_doc.

    IF mt_doc IS NOT INITIAL.
      SELECT *
        FROM i_br_nfitem AS itm
        FOR ALL ENTRIES IN @mt_doc
        WHERE itm~br_notafiscal = @mt_doc-br_notafiscal
        INTO TABLE @mt_itm.

      IF mt_itm IS NOT INITIAL.

        SELECT *
          FROM i_br_nftax AS tax
          FOR ALL ENTRIES IN @mt_itm
          WHERE tax~br_notafiscal = @mt_itm-br_notafiscal
            AND tax~br_notafiscalitem = @mt_itm-br_notafiscalitem
          INTO TABLE @mt_tax.

      ENDIF.

    ENDIF.

    SORT mt_doc BY br_nfpartner.

    build_r4020(  ).
    send_integration(  ).

  ENDMETHOD.