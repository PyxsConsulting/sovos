  METHOD if_apj_dt_exec_object~get_parameters.

    et_parameter_def = VALUE #(
      ( selname = 'COMPANY'  kind = 'P' datatype = 'C' length =  4  component_type = 'BUKRS'       param_text = 'Empresa'               mandatory_ind = 'X' changeable_ind = 'X' )
      ( selname = 'BRANCH'   kind = 'P' datatype = 'C' length =  4  component_type = 'J_1BBRANC_'  param_text = 'Local de Negócio'      mandatory_ind = 'X' changeable_ind = 'X' )
      ( selname = 'DOCUMENT' kind = 'P' datatype = 'C' length =  10 component_type = 'J_1BDOCNUM'  param_text = 'Docnum'                mandatory_ind = ''  changeable_ind = 'X' )
      ( selname = 'POS_LOW'  kind = 'P' datatype = 'D' length =  8  component_type = 'J_1BPSTDAT'  param_text = 'Data Lançamento De'    mandatory_ind = ''  changeable_ind = 'X' )
      ( selname = 'POS_HIGH' kind = 'P' datatype = 'D' length =  8  component_type = 'J_1BPSTDAT'  param_text = 'Data Lançamento Até'   mandatory_ind = ''  changeable_ind = 'X' )
      ( selname = 'CRE_LOW'  kind = 'P' datatype = 'D' length =  8  component_type = 'J_1BCREDAT'  param_text = 'Data Criação De'       mandatory_ind = ''  changeable_ind = 'X' )
      ( selname = 'CRE_HIGH' kind = 'P' datatype = 'D' length =  8  component_type = 'J_1BCREDAT'  param_text = 'Data Criação Até'      mandatory_ind = ''  changeable_ind = 'X' )
      ( selname = 'NFTYPE'   kind = 'P' datatype = 'C' length =  2  component_type = 'J_1BNFTYPE'  param_text = 'Categoria de NF'       mandatory_ind = ''  changeable_ind = 'X' )
    ).

  ENDMETHOD.