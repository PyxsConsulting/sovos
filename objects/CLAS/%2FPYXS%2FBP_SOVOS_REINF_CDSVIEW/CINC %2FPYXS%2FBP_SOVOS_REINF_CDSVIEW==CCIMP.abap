*CLASS lhc_SOVOS_REINF_CDSVIEW DEFINITION INHERITING FROM cl_abap_behavior_handler.
*  PRIVATE SECTION.
*
*    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
*      IMPORTING keys REQUEST requested_authorizations FOR /pyxs/sovos_reinf_cdsview RESULT result.
*
*    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
*      IMPORTING REQUEST requested_authorizations FOR /pyxs/sovos_reinf_cdsview RESULT result.
*
*    METHODS create FOR MODIFY
*      IMPORTING entities FOR CREATE /pyxs/sovos_reinf_cdsview.
*
*    METHODS update FOR MODIFY
*      IMPORTING entities FOR UPDATE /pyxs/sovos_reinf_cdsview.
*
*    METHODS delete FOR MODIFY
*      IMPORTING keys FOR DELETE /pyxs/sovos_reinf_cdsview.
*
*    METHODS read FOR READ
*      IMPORTING keys FOR READ /pyxs/sovos_reinf_cdsview RESULT result.
*
*    METHODS lock FOR LOCK
*      IMPORTING keys FOR LOCK /pyxs/sovos_reinf_cdsview.
*
*    METHODS gerarReinf FOR MODIFY
*      IMPORTING keys FOR ACTION /pyxs/sovos_reinf_cdsview~gerarReinf RESULT result.
*
*ENDCLASS.
*
*CLASS lhc_SOVOS_REINF_CDSVIEW IMPLEMENTATION.
*
*  METHOD get_instance_authorizations.
*  ENDMETHOD.
*
*  METHOD get_global_authorizations.
*  ENDMETHOD.
*
*  METHOD create.
*  ENDMETHOD.
*
*  METHOD update.
*  ENDMETHOD.
*
*  METHOD delete.
*  ENDMETHOD.
*
*  METHOD read.
*  ENDMETHOD.
*
*  METHOD lock.
*  ENDMETHOD.
*
*  METHOD gerarReinf.
*
*
*  DATA lv_timestamp TYPE timestampl.
*  DATA lv_max    TYPE n LENGTH 10.
*  DATA lv_new_id TYPE n LENGTH 10.
*  DATA lv_json TYPE string.
*
*  lv_timestamp = cl_abap_context_info=>get_system_time( ).
*
*  READ ENTITIES OF /PYXS/SOVOS_REINF_CDSVIEW
*    IN LOCAL MODE
*    ENTITY /PYXS/SOVOS_REINF_CDSVIEW
*    ALL FIELDS
*    WITH CORRESPONDING #( keys )
*    RESULT DATA(lt_docs).
*
*  LOOP AT lt_docs INTO DATA(ls_doc).
*
*    TRY.
*
*        SELECT MAX( log_id )
*          FROM zreinf_log
*          INTO @lv_max.
*
*        IF lv_max IS INITIAL.
*          lv_new_id = '0000000001'.
*        ELSE.
*          lv_new_id = lv_max + 1.
*        ENDIF.
*
*        DATA(lo_builder) = NEW /PYXS/SOVOS_REINF_4020BUILDER(
*                              iv_br_notafiscal = ls_doc-BR_NotaFiscal ).
*
*        lv_json = lo_builder->build_r1000( ).
*
*        DATA(ls_log) = VALUE zreinf_log(
*        client        = sy-mandt
*        log_id        = lv_new_id
*        br_notafiscal = ls_doc-BR_NotaFiscal
*        evento        = 'R1000'
*        status        = 'GERADO'
*        json_payload  = lv_json
*        message       = ''
*        created_at    = sy-datum
*        created_time  = sy-uzeit
*        created_by    = sy-uname ).
*
*        INSERT zreinf_log FROM @ls_log.
*
*        lv_new_id = lv_new_id + 1.
*
*        " ================= R2010 =================
*        lv_json = lo_builder->build_r2010( ).
*
*        ls_log-log_id       = lv_new_id.
*        ls_log-evento       = 'R2010'.
*        ls_log-json_payload = lv_json.
*
*        INSERT zreinf_log FROM @ls_log.
*
*        lv_new_id = lv_new_id + 1.
*
*        " ================= R4020 =================
*        lv_json = lo_builder->build_r4020( ).
*
*        ls_log-log_id       = lv_new_id.
*        ls_log-evento       = 'R4020'.
*        ls_log-json_payload = lv_json.
*
*        INSERT zreinf_log FROM @ls_log.
*
*      CATCH cx_root INTO DATA(lx_error).
*
*        DATA(ls_log_error) = VALUE zreinf_log(
*          client        = sy-mandt
*          log_id        = lv_new_id
*          br_notafiscal = ls_doc-BR_NotaFiscal
*          evento        = 'ERRO'
*          status        = 'ERRO'
*          json_payload  = ''
*          message       = lx_error->get_text( )
*          created_at    = lv_timestamp
*          created_by    = sy-uname ).
*
*        INSERT zreinf_log FROM @ls_log_error.
*
*    ENDTRY.
*
*  ENDLOOP.
*
*ENDMETHOD.
*
*ENDCLASS.
*
*CLASS lsc_/PYXS/SOVOS_REINF_CDSVIEW DEFINITION INHERITING FROM cl_abap_behavior_saver.
*  PROTECTED SECTION.
*
*    METHODS finalize REDEFINITION.
*
*    METHODS check_before_save REDEFINITION.
*
*    METHODS save REDEFINITION.
*
*    METHODS cleanup REDEFINITION.
*
*    METHODS cleanup_finalize REDEFINITION.
*
*ENDCLASS.
*  ENDMETHOD.
*
*ENDCLASS.
*
*CLASS lsc_SOVOS_REINF_CDSVIEW DEFINITION INHERITING FROM cl_abap_behavior_saver.
*  PROTECTED SECTION.
*
*    METHODS finalize REDEFINITION.
*
*    METHODS check_before_save REDEFINITION.
*
*    METHODS save REDEFINITION.
*
*    METHODS cleanup REDEFINITION.
*
*    METHODS cleanup_finalize REDEFINITION.
*
*ENDCLASS.
*
*CLASS lsc_SOVOS_REINF_CDSVIEW IMPLEMENTATION.
*
*  METHOD finalize.
*  ENDMETHOD.
*
*  METHOD check_before_save.
*  ENDMETHOD.
*
*  METHOD save.
*  ENDMETHOD.
*
*  METHOD cleanup.
*  ENDMETHOD.
*
*  METHOD cleanup_finalize.
*  ENDMETHOD.
*
*ENDCLASS.