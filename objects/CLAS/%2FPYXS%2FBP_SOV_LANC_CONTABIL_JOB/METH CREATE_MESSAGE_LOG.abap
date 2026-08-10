  METHOD create_message_log.
    TRY.
        CHECK go_log IS BOUND.

        DATA(lo_message) = cl_bali_free_text_setter=>create(
                              severity = severity
                              text = text ).

        go_log->add_item( item = lo_message ).
      CATCH cx_bali_runtime.
        IF sy-subrc IS INITIAL.
        ENDIF.
    ENDTRY.

  ENDMETHOD.