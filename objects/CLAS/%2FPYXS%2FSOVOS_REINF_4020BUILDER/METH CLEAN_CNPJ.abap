  METHOD clean_cnpj.

    rv_cnpj = ''.

    IF iv_cnpj IS INITIAL.
      RETURN.
    ENDIF.

    DATA(lv_cnpj) = CONV string( iv_cnpj ).

    REPLACE ALL OCCURRENCES OF REGEX '[^0-9]' IN lv_cnpj WITH ''.

    rv_cnpj = lv_cnpj.

  ENDMETHOD.