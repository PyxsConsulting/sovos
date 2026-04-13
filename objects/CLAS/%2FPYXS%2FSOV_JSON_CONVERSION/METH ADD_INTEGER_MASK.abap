  METHOD add_integer_mask.

    DATA(lv_int4) = CONV int4( e_string ).
    r_string = '#!@' && lv_int4 && '#!@'.

  ENDMETHOD.