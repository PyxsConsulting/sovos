  METHOD if_apj_dt_exec_object~get_parameters.

    et_parameter_def = VALUE #(
      ( selname = 'COMPANY'     kind = 'P'  datatype = 'C'  length = 4   component_type = 'BUKRS'       param_text = 'Empresa'                mandatory_ind = 'X'  changeable_ind = 'X' )
      ( selname = 'BRANCH'      kind = 'P'  datatype = 'C'  length = 4   component_type = 'J_1BBRANC_'  param_text = 'Local de Negócio'       mandatory_ind = 'X'  changeable_ind = 'X' )
      ( selname = 'LEDGER'      kind = 'P'  datatype = 'C'  length = 2   component_type = 'CHAR2'       param_text = 'Ledger'                 mandatory_ind = ''   changeable_ind = 'X' )
      ( selname = 'FISCALYEAR'  kind = 'P'  datatype = 'C'  length = 4   component_type = 'GJAHR'       param_text = 'Exercício'              mandatory_ind = 'X'  changeable_ind = 'X' )
      ( selname = 'ACCDOC'      kind = 'P'  datatype = 'C'  length = 10  component_type = 'CHAR10'      param_text = 'Documento Contábil'     mandatory_ind = ''   changeable_ind = 'X' )
      ( selname = 'POSTFROM'    kind = 'P'  datatype = 'D'  length = 8   component_type = 'DATS'        param_text = 'Data Lançamento De'     mandatory_ind = 'X'  changeable_ind = 'X' )
      ( selname = 'POSTTO'      kind = 'P'  datatype = 'D'  length = 8   component_type = 'DATS'        param_text = 'Data Lançamento Até'    mandatory_ind = 'X'  changeable_ind = 'X' )
    ).

  ENDMETHOD.