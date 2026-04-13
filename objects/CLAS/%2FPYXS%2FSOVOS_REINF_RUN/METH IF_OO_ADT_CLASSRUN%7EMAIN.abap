METHOD if_oo_adt_classrun~main.

*    DATA lv_notafiscal TYPE i_br_nfdocument-br_notafiscal VALUE '0000000047'.
*
*    DATA lo_builder TYPE REF TO /PYXS/SOVOS_REINF_4020BUILDER.
*
*    CREATE OBJECT lo_builder
*      EXPORTING
*        iv_br_notafiscal = lv_notafiscal.
*
*    TRY.
*    DATA(lv_r1000) = lo_builder->build_r1000( ).
*    out->write( '===== R1000 =====' ).
*    out->write( lv_r1000 ).
*  CATCH cx_root INTO DATA(lx1).
*    out->write( lx1->get_text( ) ).
*ENDTRY.
*
*TRY.
*    DATA(lv_r2010) = lo_builder->build_r2010( ).
*    out->write( '===== R2010 =====' ).
*    out->write( lv_r2010 ).
*  CATCH cx_root INTO DATA(lx2).
*    out->write( lx2->get_text( ) ).
*ENDTRY.
*
*TRY.
*    DATA(lv_r4020) = lo_builder->build_r4020( ).
*    out->write( '===== R4020 =====' ).
*    out->write( lv_r4020 ).
*  CATCH cx_root INTO DATA(lx3).
*    out->write( lx3->get_text( ) ).
*ENDTRY.


  ENDMETHOD.