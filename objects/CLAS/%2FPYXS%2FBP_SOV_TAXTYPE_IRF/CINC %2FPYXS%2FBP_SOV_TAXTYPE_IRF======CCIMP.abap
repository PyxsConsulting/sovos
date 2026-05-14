CLASS lhc_SOV_TAXTYPE_IRF DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR /pyxs/sov_taxtype_irf RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR /pyxs/sov_taxtype_irf RESULT result.

    METHODS validateimposto FOR VALIDATE ON SAVE
      IMPORTING keys FOR /pyxs/sov_taxtype_irf~validateimposto.

    METHODS validatecategoria FOR VALIDATE ON SAVE
      IMPORTING keys FOR /pyxs/sov_taxtype_irf~validatecategoria.

ENDCLASS.

CLASS lhc_SOV_TAXTYPE_IRF IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD validateImposto.

    LOOP AT keys INTO DATA(ls_key).
        IF ls_key-CategoriaIrf IS INITIAL.
          CONTINUE.
        ENDIF.

        READ ENTITIES OF /pyxs/sov_taxtype_irf IN LOCAL MODE
          ENTITY /pyxs/sov_taxtype_irf
          FIELDS ( Imposto )
          WITH CORRESPONDING #( keys )
          RESULT DATA(lt_data).

        IF sy-subrc <> 0.

          APPEND VALUE #(
            %tky = ls_key-%tky
          ) TO failed-/pyxs/sov_taxtype_irf.

          APPEND VALUE #(
            %tky = ls_key-%tky
            %msg = new_message(
                     id       = 'ZMSG'
                     number   = '001'
                     severity = if_abap_behv_message=>severity-error )
          ) TO reported-/pyxs/sov_taxtype_irf.

        ELSE.

            DATA(ls_imposto) = lt_data[ 1 ]-Imposto.
            SELECT SINGLE Imposto
              FROM /PYXS/ZI_TAX_VH
              WHERE Imposto = @ls_imposto
              INTO @DATA(lv_exists).

            IF sy-subrc <> 0.

              APPEND VALUE #(
                %tky = ls_key-%tky
              ) TO failed-/pyxs/sov_taxtype_irf.

              APPEND VALUE #(
                %tky = ls_key-%tky
                %msg = new_message(
                         id       = 'ZMSG'
                         number   = '001'
                         severity = if_abap_behv_message=>severity-error )
              ) TO reported-/pyxs/sov_taxtype_irf.

            ENDIF.
        ENDIF.
    ENDLOOP.

  ENDMETHOD.

METHOD validateCategoria.

  LOOP AT keys INTO DATA(ls_key).

    IF ls_key-CategoriaIrf IS INITIAL.
      CONTINUE.
    ENDIF.

    SELECT SINGLE @abap_true
      FROM /PYXS/ZI_WHT_CODE_VH
      WHERE WithholdingTaxCode = @ls_key-CategoriaIrf
      INTO @DATA(lv_exists).

    IF sy-subrc <> 0.

      APPEND VALUE #( %tky = ls_key-%tky ) TO failed-/pyxs/sov_taxtype_irf.

      APPEND VALUE #(
        %tky = ls_key-%tky
        %msg = new_message(
                 id       = 'ZMSG'
                 number   = '001'
                 severity = if_abap_behv_message=>severity-error
               )
      ) TO reported-/pyxs/sov_taxtype_irf.

    ENDIF.

  ENDLOOP.

ENDMETHOD.

ENDCLASS.