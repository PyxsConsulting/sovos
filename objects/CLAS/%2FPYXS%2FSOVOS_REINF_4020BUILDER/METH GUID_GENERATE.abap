  METHOD guid_generate.

    " Substitui o id_referencia de cada objeto (header + listas filhas)
    " por um GUID único. R4020 e R4010 processados separadamente.
    DATA lv_guid TYPE string.

    CLEAR gt_guid_map.

**********************************************************************
* R4020
**********************************************************************
    LOOP AT gt_objects ASSIGNING FIELD-SYMBOL(<root>).

      TRY.
          lv_guid = cl_system_uuid=>create_uuid_c32_static( ).
        CATCH cx_uuid_error.
          CONTINUE.
      ENDTRY.

      INSERT VALUE #( guid          = lv_guid
                      id_referencia = <root>-knwReinfR4020-id_referencia ) INTO TABLE gt_guid_map.

      <root>-knwReinfR4020-id_referencia = lv_guid.

      LOOP AT <root>-reinfR4020PgtoList ASSIGNING FIELD-SYMBOL(<pgto>).
        <pgto>-id_referencia = lv_guid.
      ENDLOOP.

      LOOP AT <root>-knwReinfR4020InfoPgtoList ASSIGNING FIELD-SYMBOL(<info>).
        <info>-id_referencia = lv_guid.
      ENDLOOP.

      LOOP AT <root>-knwReinfR4020InfoPgtoRetList ASSIGNING FIELD-SYMBOL(<ret>).
        <ret>-id_referencia = lv_guid.
      ENDLOOP.

    ENDLOOP.

**********************************************************************
* R4010
**********************************************************************
    LOOP AT gt_objects4010 ASSIGNING FIELD-SYMBOL(<root4010>).

      TRY.
          lv_guid = cl_system_uuid=>create_uuid_c32_static( ).
        CATCH cx_uuid_error.
          CONTINUE.
      ENDTRY.

      INSERT VALUE #( guid          = lv_guid
                      id_referencia = <root4010>-knwReinfR4010-id_referencia ) INTO TABLE gt_guid_map.

      <root4010>-knwReinfR4010-id_referencia = lv_guid.

      LOOP AT <root4010>-knwReinfR4010RendList ASSIGNING FIELD-SYMBOL(<rend>).
        <rend>-id_referencia = lv_guid.
      ENDLOOP.

      LOOP AT <root4010>-knwReinfR4010PgtoList ASSIGNING FIELD-SYMBOL(<pgto4010>).
        <pgto4010>-id_referencia = lv_guid.
      ENDLOOP.

      LOOP AT <root4010>-knwReinfR4010PgtoExtList ASSIGNING FIELD-SYMBOL(<pgtoext>).
        <pgtoext>-id_referencia = lv_guid.
      ENDLOOP.

      LOOP AT <root4010>-knwReinfR4010RendIsentoList ASSIGNING FIELD-SYMBOL(<rendisento>).
        <rendisento>-id_referencia = lv_guid.
      ENDLOOP.

      LOOP AT <root4010>-knwReinfR4010DedList ASSIGNING FIELD-SYMBOL(<ded>).
        <ded>-id_referencia = lv_guid.
      ENDLOOP.

      LOOP AT <root4010>-knwReinfR4010BenPenDedList ASSIGNING FIELD-SYMBOL(<benpended>).
        <benpended>-id_referencia = lv_guid.
      ENDLOOP.

      LOOP AT <root4010>-knwReinfR4010ProcRetList ASSIGNING FIELD-SYMBOL(<procret>).
        <procret>-id_referencia = lv_guid.
      ENDLOOP.

      LOOP AT <root4010>-knwReinfR4010DedSuspList ASSIGNING FIELD-SYMBOL(<dedsusp>).
        <dedsusp>-id_referencia = lv_guid.
      ENDLOOP.

      LOOP AT <root4010>-knwReinfR4010BenPenDedSuspList ASSIGNING FIELD-SYMBOL(<benpendedsusp>).
        <benpendedsusp>-id_referencia = lv_guid.
      ENDLOOP.

      LOOP AT <root4010>-knwReinfR4010RraList ASSIGNING FIELD-SYMBOL(<rra>).
        <rra>-id_referencia = lv_guid.
      ENDLOOP.

      LOOP AT <root4010>-knwReinfR4010RraAdvList ASSIGNING FIELD-SYMBOL(<rraadv>).
        <rraadv>-id_referencia = lv_guid.
      ENDLOOP.

      LOOP AT <root4010>-knwReinfR4010ProcJudList ASSIGNING FIELD-SYMBOL(<procjud>).
        <procjud>-id_referencia = lv_guid.
      ENDLOOP.

      LOOP AT <root4010>-knwReinfR4010ProcJudAdvList ASSIGNING FIELD-SYMBOL(<procjudadv>).
        <procjudadv>-id_referencia = lv_guid.
      ENDLOOP.

      LOOP AT <root4010>-knwReinfR4010OperSaudeList ASSIGNING FIELD-SYMBOL(<opersaude>).
        <opersaude>-id_referencia = lv_guid.
      ENDLOOP.

      LOOP AT <root4010>-knwReinfR4010DependeSaudeList ASSIGNING FIELD-SYMBOL(<dependesaude>).
        <dependesaude>-id_referencia = lv_guid.
      ENDLOOP.

      LOOP AT <root4010>-knwReinfR4010ReembList ASSIGNING FIELD-SYMBOL(<reemb>).
        <reemb>-id_referencia = lv_guid.
      ENDLOOP.

      LOOP AT <root4010>-knwReinfR4010ReembDependeList ASSIGNING FIELD-SYMBOL(<reembdepende>).
        <reembdepende>-id_referencia = lv_guid.
      ENDLOOP.

      LOOP AT <root4010>-knwReinfR4010DependenteList ASSIGNING FIELD-SYMBOL(<dependente>).
        <dependente>-id_referencia = lv_guid.
      ENDLOOP.

    ENDLOOP.

  ENDMETHOD.