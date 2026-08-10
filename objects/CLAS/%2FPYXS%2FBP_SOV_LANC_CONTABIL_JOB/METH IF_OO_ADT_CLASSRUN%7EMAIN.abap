  METHOD if_oo_adt_classrun~main.

    DATA lt_par TYPE if_apj_dt_exec_object=>tt_templ_val.

    lt_par = VALUE #( ( selname = 'COMPANY'     low = '1410' )
                      ( selname = 'BRANCH'      low = '1410' )
                      ( selname = 'FISCALYEAR'  low = '2026' )
                      ( selname = 'POSTFROM'    low = '20260101' )
                      ( selname = 'POSTTO'      low = '20260630' ) ).

    TRY.
        if_apj_rt_exec_object~execute( EXPORTING it_parameters = lt_par ).
      CATCH cx_apj_rt_content.
    ENDTRY.
  ENDMETHOD.