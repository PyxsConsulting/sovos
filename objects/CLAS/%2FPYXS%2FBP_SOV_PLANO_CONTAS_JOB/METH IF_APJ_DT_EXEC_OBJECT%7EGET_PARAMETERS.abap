  METHOD if_apj_dt_exec_object~get_parameters.

    et_parameter_def = VALUE #(
      ( selname = 'COMPANY'           kind = 'P'  datatype = 'C'  length = 4   component_type = 'BUKRS'       param_text = 'Empresa'                mandatory_ind = 'X'  changeable_ind = 'X' )
      ( selname = 'BRANCH'            kind = 'P'  datatype = 'C'  length = 4   component_type = 'J_1BBRANC_'  param_text = 'Local de Negócio'       mandatory_ind = 'X'  changeable_ind = 'X' )
      ( selname = 'CHARTOFACC'        kind = 'P'  datatype = 'C'  length = 4   component_type = 'CHAR4'       param_text = 'Plano de Contas'        mandatory_ind = ''   changeable_ind = 'X' )
      ( selname = 'GLACCOUNT'         kind = 'P'  datatype = 'C'  length = 10  component_type = 'CHAR10'      param_text = 'Conta Razão'            mandatory_ind = ''   changeable_ind = 'X' )
      ( selname = 'ACCTHIER'          kind = 'P'  datatype = 'C'  length = 4   component_type = 'CHAR4'       param_text = 'Hierarquia de Contas'   mandatory_ind = ''   changeable_ind = 'X' )
      ( selname = 'IGNOREFIRST'       kind = 'P'  datatype = 'C'  length = 1   component_type = 'ABAP_BOOL'   param_text = 'Ignorar Primeiro Nó'    mandatory_ind = ''   changeable_ind = 'X' )
      ( selname = 'VALIDFROM'         kind = 'P'  datatype = 'D'  length = 8   component_type = 'DATS'        param_text = 'Validade Inicial'       mandatory_ind = ''   changeable_ind = 'X' )
      ( selname = 'VALIDTO'           kind = 'P'  datatype = 'D'  length = 8   component_type = 'DATS'        param_text = 'Validade Final'         mandatory_ind = ''   changeable_ind = 'X' )
    ).

  ENDMETHOD.