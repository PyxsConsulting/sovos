  METHOD build_r2010.

*    TYPES: BEGIN OF ty_knw_r2010,
*             cd_empresa           TYPE string,
*             cd_filial            TYPE string,
*             id_referencia        TYPE string,
*             dm_retificacao       TYPE string,
*             dt_apuracao          TYPE string,
*             dm_inscricao_obra    TYPE string,
*             nr_inscricao_obra    TYPE string,
*             dm_obra              TYPE string,
*             nr_cnpj_prestador    TYPE string,
*             vl_total_bruto       TYPE string,
*             vl_total_base        TYPE string,
*             vl_total_retencao    TYPE string,
*             vl_tot_retencao_adic TYPE string,
*             vl_tot_ret_nao_efet  TYPE string,
*             vl_tot_ret_nefe_adic TYPE string,
*             dm_cprb              TYPE string,
*           END OF ty_knw_r2010.
*
*    DATA ls_r2010 TYPE ty_knw_r2010.
*
*    ls_r2010-cd_empresa        = ms_doc-companycode.
*    ls_r2010-cd_filial         = ms_doc-businessplace.
*    ls_r2010-id_referencia     = mv_br_notafiscal.
*    ls_r2010-dm_retificacao    = '1'.
*    ls_r2010-dt_apuracao       = format_date( ms_doc-br_nfissuedate ).
*    ls_r2010-dm_inscricao_obra = '1'.
*    ls_r2010-nr_inscricao_obra = clean_cnpj( CONV string( ms_doc-br_businessplacecnpj ) ).
*    ls_r2010-dm_obra           = '0'.
*    ls_r2010-nr_cnpj_prestador = clean_cnpj( CONV string( ms_doc-br_nfpartnercnpj ) ).
*
*    ls_r2010-vl_total_bruto    = format_amount( ms_doc-br_nftotalamount ).
*    ls_r2010-vl_total_base     = format_amount( ms_doc-br_nftotalamount ).
*    ls_r2010-vl_total_retencao = '0.00'.
*    ls_r2010-vl_tot_retencao_adic = '0.00'.
*    ls_r2010-vl_tot_ret_nao_efet  = '0.00'.
*    ls_r2010-vl_tot_ret_nefe_adic = '0.00'.
*    ls_r2010-dm_cprb           = '0'.
*
*    rv_json = serialize_json( ls_r2010 ).

  ENDMETHOD.