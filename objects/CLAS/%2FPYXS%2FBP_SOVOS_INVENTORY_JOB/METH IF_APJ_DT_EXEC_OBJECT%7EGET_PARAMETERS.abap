    METHOD if_apj_dt_exec_object~get_parameters.

      et_parameter_def = VALUE #(
        ( selname = 'COMPANY'   kind = 'P'  datatype = 'C'  length = 4   component_type = 'BUKRS'       param_text = 'Empresa'            mandatory_ind = 'X'  changeable_ind = 'X' )
        ( selname = 'BRANCH'    kind = 'P'  datatype = 'C'  length = 4   component_type = 'J_1BBRANC_'  param_text = 'Local de Negócio'   mandatory_ind = 'X'  changeable_ind = 'X' )
        ( selname = 'MATERIAL'  kind = 'P'  datatype = 'C'  length = 18  component_type = 'MATNR'       param_text = 'Material De'        mandatory_ind = ''   changeable_ind = 'X' )
        ( selname = 'ANOMES'    kind = 'P'  datatype = 'C'  length = 6   component_type = 'CHAR6'       param_text = 'Ano/Mês De'         mandatory_ind = ''   changeable_ind = 'X' )
      ).

    ENDMETHOD.