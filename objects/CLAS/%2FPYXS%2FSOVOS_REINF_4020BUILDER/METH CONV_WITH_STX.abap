  METHOD conv_with_stx.
*    CASE witht.
*      WHEN 'CA' OR 'CP'. "Cofins
*        group = 'WHCO'.
*      WHEN 'IC' OR 'ID' OR 'IR' OR 'RA' OR 'RF' OR 'RP'. "Imposto de Renda
*        group = 'IRRF'.
*      WHEN 'IW' OR 'IS' . "ISS
*        group = 'ISSS'.
*      WHEN 'NS' OR 'NA' OR 'IJ' OR 'IN' OR 'IM'. "INSS
*        group = 'INSS'.
*      WHEN 'PA' OR 'PP'. "Pis
*        group = 'WHPI'.
*      WHEN 'SA' OR 'SP'. "CSLL
*        group = 'WACS'.
*      WHEN 'GA' OR 'GP'. "PCC
*        group = 'WHT'.
*    ENDCASE.

    CASE witht.
        "Federais Normal
      WHEN 'PP'.  group = VALUE #( ( sign = 'I' option = 'EQ' low = 'WHPI' ) ) . "Pis
      WHEN 'CP'.  group = VALUE #( ( sign = 'I' option = 'EQ' low = 'WHCO' ) ). "Cofins
      WHEN 'SP'.  group = VALUE #( ( sign = 'I' option = 'EQ' low = 'WHCS' ) ). "CSLL
      WHEN 'GP'.  group = VALUE #( ( sign = 'I' option = 'EQ' low = 'WHT' ) ).  "PCC
      WHEN 'RP'.  group = VALUE #( ( sign = 'I' option = 'EQ' low = 'WHIR' ) ). "IR
      WHEN 'RF'.  group = VALUE #( ( sign = 'I' option = 'EQ' low = 'WHIR' ) ). "IR

        "Federais Acumulado
      WHEN 'PA'.  group = VALUE #( ( sign = 'I' option = 'EQ' low = 'WAPI' ) ). "Pis
      WHEN 'CA'.  group = VALUE #( ( sign = 'I' option = 'EQ' low = 'WACO' ) ). "Cofins
      WHEN 'SA'.  group = VALUE #( ( sign = 'I' option = 'EQ' low = 'WACS' ) ). "CSLL
      WHEN 'GA'.  group = VALUE #( ( sign = 'I' option = 'EQ' low = 'WAT' ) ).  "PCC
      WHEN 'RA'.  group = VALUE #( ( sign = 'I' option = 'EQ' low = 'WAIR' ) ). "IR

        "INSS
      WHEN 'NS' OR 'NA' OR 'IJ' OR 'IN' OR 'IM'. "INSS
        group = VALUE #( ( sign = 'I' option = 'EQ' low = 'INSS' ) ).

        "ISS
      WHEN 'IW'.
        group = VALUE #( ( sign = 'I' option = 'EQ' low = 'ISSS' )
                         ( sign = 'I' option = 'EQ' low = 'ISSP' ) ).
    ENDCASE.
  ENDMETHOD.