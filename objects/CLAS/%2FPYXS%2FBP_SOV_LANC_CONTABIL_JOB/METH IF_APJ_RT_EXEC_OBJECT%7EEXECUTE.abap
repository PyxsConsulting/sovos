  METHOD if_apj_rt_exec_object~execute.

    DATA: lt_sendintegration TYPE TABLE FOR ACTION IMPORT /pyxs/sov_lanc_contabil~sendintegration.

    TRY.
        go_log = cl_bali_log=>create_with_header(
          cl_bali_header_setter=>create(
            object    = '/PYXS/SOVOS_TAX_FISC'
            subobject = '/PYXS/SOVOS_LANCTB' ) ).
      CATCH cx_bali_runtime INTO DATA(l_runtime_exception).
        CLEAR go_log.
    ENDTRY.

    APPEND INITIAL LINE TO lt_sendintegration ASSIGNING FIELD-SYMBOL(<fs_sendintegration>).
    <fs_sendintegration>-%cid = '1'.

    LOOP AT it_parameters INTO DATA(ls_parameter).
      CHECK ls_parameter-low IS NOT INITIAL.

      CASE ls_parameter-selname.

        WHEN 'COMPANY'.
          <fs_sendintegration>-%param-companycode = ls_parameter-low.

        WHEN 'BRANCH'.
          <fs_sendintegration>-%param-branch = ls_parameter-low.

        WHEN 'LEDGER'.
          <fs_sendintegration>-%param-ledger = ls_parameter-low.

        WHEN 'FISCALYEAR'.
          <fs_sendintegration>-%param-fiscalyear = ls_parameter-low.

        WHEN 'ACCDOC'.
          <fs_sendintegration>-%param-accountingdocument = ls_parameter-low.

        WHEN 'POSTFROM'.
          <fs_sendintegration>-%param-postingstartdate = ls_parameter-low.

        WHEN 'POSTTO'.
          <fs_sendintegration>-%param-postingenddate = ls_parameter-low.

      ENDCASE.
    ENDLOOP.

    MODIFY ENTITIES OF /pyxs/sov_lanc_contabil
      ENTITY /pyxs/sov_lanc_contabil
      EXECUTE sendintegration
      FROM lt_sendintegration
      RESULT   DATA(lt_result)
      FAILED   DATA(lt_failed)
      REPORTED DATA(lt_reported).

    LOOP AT lt_result INTO DATA(ls_result).
      create_message_log(
        severity = if_bali_constants=>c_severity_default
        text     = CONV #( |Execução concluída para lançamento { ls_result-%param-%data-lancamento }| ) ).
    ENDLOOP.

    LOOP AT lt_reported-/pyxs/sov_lanc_contabil INTO DATA(ls_reported).
      create_message_log(
        severity = if_bali_constants=>c_severity_default
        text     = CONV #( ls_reported-%msg->if_message~get_longtext( ) ) ).
    ENDLOOP.

    save_log( ).

  ENDMETHOD.