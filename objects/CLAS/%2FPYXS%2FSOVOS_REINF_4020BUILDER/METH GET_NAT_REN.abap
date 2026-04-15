  METHOD get_nat_ren.

    READ TABLE mt_nature INTO DATA(ls_nat) WITH KEY lc116 = iv_lc116.
    rv_natren = ls_nat-nat_res.

  ENDMETHOD.