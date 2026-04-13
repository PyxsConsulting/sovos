  METHOD add_number_dec_mask.
    TYPES: ty_number TYPE p LENGTH 15 DECIMALS 2.

    DATA(lv_number) = CONV ty_number( e_string ).
    r_string = '#!@' && lv_number && '#!@'.

  ENDMETHOD.