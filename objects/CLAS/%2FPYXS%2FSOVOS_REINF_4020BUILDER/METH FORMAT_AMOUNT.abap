  METHOD format_amount.

    DATA(lv_value) = CONV decfloat34( iv_value ).

    IF lv_value IS INITIAL.
      rv_value = '0.00'.
      RETURN.
    ENDIF.

    rv_value = |{ lv_value DECIMALS = 2 SIGN = LEFT }|.

    REPLACE ALL OCCURRENCES OF ',' IN rv_value WITH '.'.


  ENDMETHOD.