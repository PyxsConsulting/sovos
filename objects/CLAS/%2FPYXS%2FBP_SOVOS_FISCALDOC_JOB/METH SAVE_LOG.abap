  METHOD save_log.

    CHECK go_log IS BOUND.

    TRY.
        "Save the log into the database
        cl_bali_log_db=>get_instance( )->save_log( log = go_log assign_to_current_appl_job = abap_true ).
        COMMIT WORK.
      CATCH  cx_bali_runtime.
        IF sy-subrc IS INITIAL.
        ENDIF.
    ENDTRY.

  ENDMETHOD.