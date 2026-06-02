    METHOD if_apj_dt_exec_object~get_parameters.

      et_parameter_def = VALUE #(
        ( selname = 'COMPANY'   kind = 'P'  datatype = 'C'  length = 4   component_type = 'CHAR4'       param_text = 'Empresa'            mandatory_ind = 'X'  changeable_ind = 'X' )
        ( selname = 'BRANCH'    kind = 'P'  datatype = 'C'  length = 4   component_type = 'CHAR4'  param_text = 'Local de Negócio'   mandatory_ind = 'X'  changeable_ind = 'X' )
        ( selname = 'ANOMES'    kind = 'P'  datatype = 'C'  length = 6   component_type = 'CHAR6'       param_text = 'Ano/Mês De'         mandatory_ind = ''   changeable_ind = 'X' )
        ( selname = 'PARTNER'  kind = 'P'  datatype = 'C'  length = 10  component_type = 'CHAR10'       param_text = 'Parceiro'        mandatory_ind = ''   changeable_ind = 'X' )
      ).

    ENDMETHOD.