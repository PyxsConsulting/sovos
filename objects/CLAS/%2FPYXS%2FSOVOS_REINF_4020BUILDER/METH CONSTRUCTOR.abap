  METHOD constructor.

    sel-company = iv_company_doce.
    sel-branch = iv_business_place.
    sel-creation = VALUE #( ( sign = 'I' option = 'BT' low = iv_date_begin high = iv_date_end ) ).
    IF iv_br_notafiscal IS NOT INITIAL.
      sel-document = VALUE #( ( sign = 'I' option = 'EQ' low = iv_br_notafiscal ) ).
    ENDIF.

    mv_br_notafiscal = iv_br_notafiscal.


    read_db( sel ).
    build_r4020_new(  ).
    send_integration(  ).

  ENDMETHOD.