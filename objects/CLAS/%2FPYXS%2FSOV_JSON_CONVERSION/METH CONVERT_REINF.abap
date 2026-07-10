  METHOD convert_reinf.

  DATA(rv_json) = json.

  " Root nodes
  REPLACE ALL OCCURRENCES OF '"knwreinfr4020"'             IN rv_json WITH '"knwReinfR4020"'.
  REPLACE ALL OCCURRENCES OF '"reinfr4020pgtolist"'        IN rv_json WITH '"reinfR4020PgtoList"'.
  REPLACE ALL OCCURRENCES OF '"knwreinfr4020infopgtolist"' IN rv_json WITH '"knwReinfR4020InfoPgtoList"'.
  REPLACE ALL OCCURRENCES OF '"knwreinfr4020infopgtoretlist"' IN rv_json WITH '"knwReinfR4020InfoPgtoRetList"'.

  " Common fields
  REPLACE ALL OCCURRENCES OF '"cd_empresa"'         IN rv_json WITH '"CD_EMPRESA"'.
  REPLACE ALL OCCURRENCES OF '"cd_filial"'          IN rv_json WITH '"CD_FILIAL"'.
  REPLACE ALL OCCURRENCES OF '"id_referencia"'      IN rv_json WITH '"ID_REFERENCIA"'.
  REPLACE ALL OCCURRENCES OF '"id_evento"'          IN rv_json WITH '"ID_EVENTO"'.
  REPLACE ALL OCCURRENCES OF '"dm_retificacao"'     IN rv_json WITH '"DM_RETIFICACAO"'.
  REPLACE ALL OCCURRENCES OF '"dt_apuracao"'        IN rv_json WITH '"DT_APURACAO"'.
  REPLACE ALL OCCURRENCES OF '"dm_inscricao_estab"' IN rv_json WITH '"DM_INSCRICAO_ESTAB"'.
  REPLACE ALL OCCURRENCES OF '"nr_inscricao_estab"' IN rv_json WITH '"NR_INSCRICAO_ESTAB"'.
  REPLACE ALL OCCURRENCES OF '"nr_cnpj_benef"'      IN rv_json WITH '"NR_CNPJ_BENEF"'.
  REPLACE ALL OCCURRENCES OF '"nm_benef"'           IN rv_json WITH '"NM_BENEF"'.
  REPLACE ALL OCCURRENCES OF '"dm_isencao_imun"'    IN rv_json WITH '"DM_ISENCAO_IMUN"'.

  " Pgto
  REPLACE ALL OCCURRENCES OF '"id_seq_pagto"'       IN rv_json WITH '"ID_SEQ_PAGTO"'.
  REPLACE ALL OCCURRENCES OF '"nr_nat_rend"'        IN rv_json WITH '"NR_NAT_REND"'.

  " InfoPgto
  REPLACE ALL OCCURRENCES OF '"id_seq_info_pgto"'   IN rv_json WITH '"ID_SEQ_INFO_PAGTO"'.
  REPLACE ALL OCCURRENCES OF '"dt_fato_gerador"'    IN rv_json WITH '"DT_FATO_GERADOR"'.
  REPLACE ALL OCCURRENCES OF '"vl_bruto"'           IN rv_json WITH '"VL_BRUTO"'.
  REPLACE ALL OCCURRENCES OF '"ds_observ"'          IN rv_json WITH '"DS_OBSERV"'.
  REPLACE ALL OCCURRENCES OF '"dm_jud"'             IN rv_json WITH '"DM_JUD"'.

  " Retencoes
  REPLACE ALL OCCURRENCES OF '"vl_base_ir"'         IN rv_json WITH '"VL_BASE_IR"'.
  REPLACE ALL OCCURRENCES OF '"vl_ir"'              IN rv_json WITH '"VL_IR"'.
  REPLACE ALL OCCURRENCES OF '"vl_base_csll"'       IN rv_json WITH '"VL_BASE_CSLL"'.
  REPLACE ALL OCCURRENCES OF '"vl_csll"'            IN rv_json WITH '"VL_CSLL"'.
  REPLACE ALL OCCURRENCES OF '"vl_base_cofins"'     IN rv_json WITH '"VL_BASE_COFINS"'.
  REPLACE ALL OCCURRENCES OF '"vl_cofins"'          IN rv_json WITH '"VL_COFINS"'.
  REPLACE ALL OCCURRENCES OF '"vl_base_pis_pasep"'  IN rv_json WITH '"VL_BASE_PIS_PASEP"'.
  REPLACE ALL OCCURRENCES OF '"vl_pis_pasep"'       IN rv_json WITH '"VL_PIS_PASEP"'.
  REPLACE ALL OCCURRENCES OF '"vl_base_agreg"'      IN rv_json WITH '"VL_BASE_AGREG"'.
  REPLACE ALL OCCURRENCES OF '"vl_agreg"'           IN rv_json WITH '"VL_AGREG"'.
  REPLACE ALL OCCURRENCES OF ' "'           IN rv_json WITH '"'.


  REPLACE ALL OCCURRENCES OF '"' IN rv_json WITH '\"'.

  CONCATENATE '{"objetos":["' rv_json '"]}'
  INTO ret.

ENDMETHOD.