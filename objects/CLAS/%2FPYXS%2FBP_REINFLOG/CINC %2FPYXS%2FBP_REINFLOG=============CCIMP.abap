CLASS lsc_/pyxs/reinflog DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

    METHODS save REDEFINITION.

ENDCLASS.

CLASS lsc_/pyxs/reinflog IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

  METHOD save.

    MODIFY /pyxs/sov_reinf FROM TABLE @/pyxs/bp_reinflog=>lt_log.

  ENDMETHOD.

ENDCLASS.

CLASS lhc_reinflog DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR /pyxs/reinflog RESULT result.
    METHODS sendintegration FOR MODIFY
      IMPORTING keys FOR ACTION /pyxs/reinflog~sendintegration RESULT result.
    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE /pyxs/reinflog.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE /pyxs/reinflog.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE /pyxs/reinflog.

    METHODS read FOR READ
      IMPORTING keys FOR READ /pyxs/reinflog RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK /pyxs/reinflog.


    METHODS last_day_of_months
      IMPORTING day_in                   TYPE datum
      RETURNING VALUE(last_day_of_month) TYPE datum.


ENDCLASS.

CLASS lhc_reinflog IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.



  METHOD sendintegration.
    DATA: lv_begin TYPE datum,
          lv_end   TYPE datum.

    DATA(key) = keys[ 1 ].

    " ── Validação de campos obrigatórios ──────────────────────────────
    IF key-%param-comapnycode IS INITIAL
    OR key-%param-businessplace IS INITIAL
    OR key-%param-anomes IS INITIAL.

      APPEND INITIAL LINE TO failed-/pyxs/reinflog ASSIGNING FIELD-SYMBOL(<failed>).
      <failed>-%cid       = key-%cid.
      <failed>-%action-sendintegration = if_abap_behv=>mk-on.

      APPEND INITIAL LINE TO reported-/pyxs/reinflog ASSIGNING FIELD-SYMBOL(<reported>).
      <reported>-%cid     = key-%cid.
      <reported>-%action-sendintegration = if_abap_behv=>mk-on.
      <reported>-%msg = new_message(
                          id       = '/PYXS/SOVOS_REINF'
                          number   = '001'
                          severity = if_abap_behv_message=>severity-error
                          v1       = key-%param-comapnycode  " placeholders opcionais
                        ).

      RETURN.
    ENDIF.

    IF key-%param-anomes CA sy-abcde  " contém letras
    OR strlen( key-%param-anomes ) <> 6.
      APPEND INITIAL LINE TO failed-/pyxs/reinflog ASSIGNING <failed>.
      <failed>-%cid       = key-%cid.
      <failed>-%action-sendintegration = if_abap_behv=>mk-on.

      APPEND INITIAL LINE TO reported-/pyxs/reinflog ASSIGNING <reported>.
      <reported>-%cid     = key-%cid.
      <reported>-%action-sendintegration = if_abap_behv=>mk-on.
      <reported>-%msg = new_message(
                          id       = '/PYXS/SOVOS_REINF'
                          number   = '002'
                          severity = if_abap_behv_message=>severity-error
                        ).
      RETURN.
    ELSEIF key-%param-anomes(2) <> '20' OR key-%param-anomes+4(2) LT '01' OR key-%param-anomes+4(2) GT '12'.
      APPEND INITIAL LINE TO failed-/pyxs/reinflog ASSIGNING <failed>.
      <failed>-%cid       = key-%cid.
      <failed>-%action-sendintegration = if_abap_behv=>mk-on.

      APPEND INITIAL LINE TO reported-/pyxs/reinflog ASSIGNING <reported>.
      <reported>-%cid     = key-%cid.
      <reported>-%action-sendintegration = if_abap_behv=>mk-on.
      <reported>-%msg = new_message(
                          id       = '/PYXS/SOVOS_REINF'
                          number   = '002'
                          severity = if_abap_behv_message=>severity-error
                        ).
      RETURN.
    ENDIF.

    lv_begin = |{ key-%param-anomes }01|.

    lv_end = last_day_of_months( day_in = lv_begin ).

    DATA(lo_proc) = NEW /pyxs/sovos_reinf_4020builder(
*      iv_br_notafiscal  =
      iv_date_begin     = lv_begin
      iv_date_end       = lv_end
      iv_company_doce   = key-%param-comapnycode
      iv_business_place = key-%param-businessplace
    ).

    DATA(ls_reinf) = /pyxs/bp_reinflog=>lt_log[ 1 ].
    APPEND INITIAL LINE TO result ASSIGNING FIELD-SYMBOL(<res>).
    <res>-%param-anomes = ls_reinf-ano_mes.
    <res>-%param-evento = ls_reinf-evento.
    <res>-%param-id = ls_reinf-id.
    <res>-%param-partner = ls_reinf-partner.
    <res>-%param-resultado = ls_reinf-resultado.
    <res>-%param-retorno = ls_reinf-retorno.

    "/PYXS/BP_REINFLOG=>lt_log = lo_proc->get_return(  ).

  ENDMETHOD.

  METHOD last_day_of_months.

    DATA: januar(2)   VALUE '01',
          december(2) VALUE '12',
          lowdate(4)  VALUE '1800',
          frist(2)    VALUE '01'.
    DATA: BEGIN OF highdate,
            j(4) VALUE '9999',
            m(2) VALUE '12',
            t(2) VALUE '31',
          END OF highdate.
    DATA: BEGIN OF date,
            j(4) TYPE n,
            m(2) TYPE n,
            t(2) TYPE n,
          END OF date.
    DATA: zahl TYPE i.

    date = day_in.

    IF date-m LT januar OR date-m GT december.            "#EC PORTABLE
      last_day_of_month = 0.
    ENDIF.

    IF date-j LT lowdate.                                 "#EC PORTABLE
      last_day_of_month = 0.
    ENDIF.

    IF date-j EQ highdate-j AND                             "VNIK001140
       date-m EQ highdate-m.                                "VNIK001140
      last_day_of_month = highdate.                         "VNIK001140

    ELSE.                                                   "VNIK001140

      IF date-m EQ december.
        date-j += 1.
        date-m = frist.
      ELSE.
        date-m += 1.
      ENDIF.
* Erster des Folgemonats
      date-t = frist.
      last_day_of_month = date.
      last_day_of_month -= 1.

    ENDIF.
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