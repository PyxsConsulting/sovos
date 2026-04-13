  METHOD if_apj_rt_exec_object~execute.

    DATA: lt_sendintegration TYPE TABLE FOR ACTION IMPORT /pyxs/p_sovos_fiscaldocuments~sendintegration.

    TRY.
        go_log = cl_bali_log=>create_with_header( cl_bali_header_setter=>create(
                  object = '/PYXS/SOVOS_TAX_FISC'
                  subobject = '/PYXS/SOVOS_NF' ) ).
      CATCH cx_bali_runtime INTO DATA(l_runtime_exception).
        CLEAR go_log.
    ENDTRY.

    APPEND INITIAL LINE TO lt_sendintegration ASSIGNING FIELD-SYMBOL(<fs_sendintegration>).
    <fs_sendintegration>-%cid = '1'.

    LOOP AT it_parameters INTO DATA(ls_parameter).
      CHECK ls_parameter-low IS NOT INITIAL.
      CASE ls_parameter-selname.
        WHEN 'COMPANY'.
          <fs_sendintegration>-%param-company = ls_parameter-low.
        WHEN 'BRANCH'.
          <fs_sendintegration>-%param-branch = ls_parameter-low.
        WHEN 'DOCUMENT'.
          <fs_sendintegration>-%param-document = ls_parameter-low.
        WHEN 'CRE_LOW'.
          <fs_sendintegration>-%param-creation_low = ls_parameter-low.
        WHEN 'CRE_HIGH'.
          <fs_sendintegration>-%param-creation_high = ls_parameter-low.
        WHEN 'POS_LOW'.
          <fs_sendintegration>-%param-posting_low = ls_parameter-low.
        WHEN 'POS_HIGH'.
          <fs_sendintegration>-%param-posting_high = ls_parameter-low.
        WHEN 'NFTYPE'.
          <fs_sendintegration>-%param-nftype = ls_parameter-low.
      ENDCASE.
    ENDLOOP.

    MODIFY ENTITIES OF /pyxs/p_sovos_fiscaldocuments
          ENTITY /pyxs/p_sovos_fiscaldocuments
        EXECUTE sendintegration
        FROM lt_sendintegration
      RESULT   DATA(lt_result)
      FAILED   DATA(lt_failed)
      REPORTED DATA(lt_reported).

    LOOP  AT lt_result  INTO DATA(ls_result).
      create_message_log(
        severity = if_bali_constants=>c_severity_default
        text     = CONV #( |Docnum { ls_result-%param-brnotafiscal } - Retorno: { ls_result-%param-response }| ) ).
    ENDLOOP.

    LOOP AT lt_reported-/pyxs/p_sovos_fiscaldocuments INTO DATA(ls_reported).
      create_message_log(
        severity = if_bali_constants=>c_severity_default
        text     = CONV #( ls_reported-%msg->if_message~get_longtext( ) ) ).
    ENDLOOP.
    save_log( ).

  ENDMETHOD.