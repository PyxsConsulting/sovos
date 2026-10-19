CLASS lhc_SOV_GEN_PARAMETERS DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR /pyxs/sov_gen_parameters RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations FOR /pyxs/sov_gen_parameters RESULT result.

    METHODS setDescr FOR DETERMINE ON MODIFY
      IMPORTING keys FOR /pyxs/sov_gen_parameters~setDescr.

ENDCLASS.

CLASS lhc_SOV_GEN_PARAMETERS IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD setDescr.

    DATA lt_update TYPE TABLE FOR UPDATE /pyxs/sov_gen_parameters.

    READ ENTITIES OF /pyxs/sov_gen_parameters IN LOCAL MODE
      ENTITY /pyxs/sov_gen_parameters
        FIELDS ( Pcode )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_params).

    LOOP AT lt_params INTO DATA(ls_param).

      SELECT SINGLE text
        FROM /pyxs/sov_gen_param_vh
        WHERE value_low = @ls_param-Pcode
        INTO @DATA(lv_text).

      IF sy-subrc <> 0.
        CLEAR lv_text.
      ENDIF.

      APPEND VALUE #( %tky           = ls_param-%tky
                      Descr          = lv_text
                      %control-Descr = if_abap_behv=>mk-on ) TO lt_update.

    ENDLOOP.

    MODIFY ENTITIES OF /pyxs/sov_gen_parameters IN LOCAL MODE
      ENTITY /pyxs/sov_gen_parameters
        UPDATE FROM lt_update.

  ENDMETHOD.

ENDCLASS.