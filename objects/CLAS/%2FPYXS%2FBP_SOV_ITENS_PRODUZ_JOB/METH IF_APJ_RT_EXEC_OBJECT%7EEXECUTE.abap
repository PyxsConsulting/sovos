    METHOD if_apj_rt_exec_object~execute.

      DATA: lt_sendintegration TYPE TABLE FOR ACTION IMPORT /pyxs/sovos_inventorylog~sendintegration.

      TRY.
          go_log = cl_bali_log=>create_with_header(
            cl_bali_header_setter=>create(
              object    = '/PYXS/SOVOS_TAX_FISC'
              subobject = '/PYXS/SOVOS_ITMPRD' ) ).
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

          WHEN 'ANOMES'.
            <fs_sendintegration>-%param-AnoMes = ls_parameter-low.

        ENDCASE.
      ENDLOOP.

      MODIFY ENTITIES OF /pyxs/sovos_inventorylog
        ENTITY /pyxs/sovos_inventorylog
        EXECUTE sendintegration
        FROM lt_sendintegration
        RESULT   DATA(lt_result)
        FAILED   DATA(lt_failed)
        REPORTED DATA(lt_reported).

      LOOP AT lt_result INTO DATA(ls_result).
        create_message_log(
          severity = if_bali_constants=>c_severity_default
          text     = CONV #( |Execução concluída para Ano/Mes { ls_result-%param-Anomes }| ) ).
      ENDLOOP.

      LOOP AT lt_reported-/pyxs/sovos_inventorylog INTO DATA(ls_reported).
        create_message_log(
          severity = if_bali_constants=>c_severity_default
          text     = CONV #( ls_reported-%msg->if_message~get_longtext( ) ) ).
      ENDLOOP.

      save_log( ).

    ENDMETHOD.