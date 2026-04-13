  METHOD format_date.

    IF iv_date IS INITIAL.
      rv_date = ''.
      RETURN.
    ENDIF.
    IF iv_with_time IS INITIAL.
      rv_date = |{ iv_date+6(2) }{ iv_date+4(2) }{ iv_date(4) }|.
    ELSE.
      rv_date = |{ iv_date+6(2) }{ iv_date+4(2) }{ iv_date(4) }T00:00:00+03:00|.
    ENDIF.

  ENDMETHOD.