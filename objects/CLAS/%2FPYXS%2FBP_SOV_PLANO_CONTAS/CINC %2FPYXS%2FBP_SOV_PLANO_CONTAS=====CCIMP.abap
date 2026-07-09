CLASS lhc_SOV_PLANO_CONTAS DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR /pyxs/sov_plano_contas RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE /pyxs/sov_plano_contas.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE /pyxs/sov_plano_contas.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE /pyxs/sov_plano_contas.

    METHODS read FOR READ
      IMPORTING keys FOR READ /pyxs/sov_plano_contas RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK /pyxs/sov_plano_contas.

ENDCLASS.

CLASS lhc_SOV_PLANO_CONTAS IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD create.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_SOV_PLANO_CONTAS DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_SOV_PLANO_CONTAS IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.