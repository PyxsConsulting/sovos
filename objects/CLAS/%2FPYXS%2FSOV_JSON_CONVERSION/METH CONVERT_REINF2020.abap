METHOD convert_reinf2020.

  DATA(rv_json) = json.

  " Root nodes
  REPLACE ALL OCCURRENCES OF '"knwreinfr2020"'                 IN rv_json WITH '"knwReinfR2020"'.
  REPLACE ALL OCCURRENCES OF '"knwreinfr2020notalist"'         IN rv_json WITH '"knwReinfR2020NotaList"'.
  REPLACE ALL OCCURRENCES OF '"knwreinfr2020servicolist"'      IN rv_json WITH '"knwReinfR2020ServicoList"'.
  REPLACE ALL OCCURRENCES OF '"knwreinfr2020processolist"'     IN rv_json WITH '"knwReinfR2020ProcessoList"'.
  REPLACE ALL OCCURRENCES OF '"knwreinfr2020processoadiclist"' IN rv_json WITH '"knwReinfR2020ProcessoAdicList"'.

  " Header
  REPLACE ALL OCCURRENCES OF '"cd_empresa"'             IN rv_json WITH '"CD_EMPRESA"'.
  REPLACE ALL OCCURRENCES OF '"cd_filial"'              IN rv_json WITH '"CD_FILIAL"'.
  REPLACE ALL OCCURRENCES OF '"id_referencia"'          IN rv_json WITH '"ID_REFERENCIA"'.
  REPLACE ALL OCCURRENCES OF '"id_evento"'              IN rv_json WITH '"ID_EVENTO"'.
  REPLACE ALL OCCURRENCES OF '"dm_retificacao"'         IN rv_json WITH '"DM_RETIFICACAO"'.
  REPLACE ALL OCCURRENCES OF '"dt_apuracao"'            IN rv_json WITH '"DT_APURACAO"'.
  REPLACE ALL OCCURRENCES OF '"dm_inscricao_prestador"' IN rv_json WITH '"DM_INSCRICAO_PRESTADOR"'.
  REPLACE ALL OCCURRENCES OF '"nr_inscricao_prestador"' IN rv_json WITH '"NR_INSCRICAO_PRESTADOR"'.
  REPLACE ALL OCCURRENCES OF '"dm_inscricao_tomador"'   IN rv_json WITH '"DM_INSCRICAO_TOMADOR"'.
  REPLACE ALL OCCURRENCES OF '"nr_inscricao_tomador"'   IN rv_json WITH '"NR_INSCRICAO_TOMADOR"'.
  REPLACE ALL OCCURRENCES OF '"dm_obra"'                IN rv_json WITH '"DM_OBRA"'.
  REPLACE ALL OCCURRENCES OF '"vl_total_bruto"'         IN rv_json WITH '"VL_TOTAL_BRUTO"'.
  REPLACE ALL OCCURRENCES OF '"vl_total_base"'          IN rv_json WITH '"VL_TOTAL_BASE"'.
  REPLACE ALL OCCURRENCES OF '"vl_total_retencao"'      IN rv_json WITH '"VL_TOTAL_RETENCAO"'.
  REPLACE ALL OCCURRENCES OF '"vl_tot_retencao_adic"'   IN rv_json WITH '"VL_TOT_RETENCAO_ADIC"'.
  REPLACE ALL OCCURRENCES OF '"vl_tot_ret_nao_efet"'    IN rv_json WITH '"VL_TOT_RET_NAO_EFET"'.
  REPLACE ALL OCCURRENCES OF '"vl_tot_ret_adic_n_efet"' IN rv_json WITH '"VL_TOT_RET_ADIC_N_EFET"'.

  " Nota
  REPLACE ALL OCCURRENCES OF '"nr_item_nota"'           IN rv_json WITH '"NR_ITEM_NOTA"'.
  REPLACE ALL OCCURRENCES OF '"nr_serie"'               IN rv_json WITH '"NR_SERIE"'.
  REPLACE ALL OCCURRENCES OF '"nr_documento"'           IN rv_json WITH '"NR_DOCUMENTO"'.
  REPLACE ALL OCCURRENCES OF '"dt_emissao"'             IN rv_json WITH '"DT_EMISSAO"'.
  REPLACE ALL OCCURRENCES OF '"vl_bruto"'               IN rv_json WITH '"VL_BRUTO"'.
  REPLACE ALL OCCURRENCES OF '"ds_observacao"'          IN rv_json WITH '"DS_OBSERVACAO"'.

  " Serviço
  REPLACE ALL OCCURRENCES OF '"nr_item_servico"'        IN rv_json WITH '"NR_ITEM_SERVICO"'.
  REPLACE ALL OCCURRENCES OF '"cd_tipo_servico"'        IN rv_json WITH '"CD_TIPO_SERVICO"'.
  REPLACE ALL OCCURRENCES OF '"vl_base_retencao"'       IN rv_json WITH '"VL_BASE_RETENCAO"'.
  REPLACE ALL OCCURRENCES OF '"vl_retencao"'            IN rv_json WITH '"VL_RETENCAO"'.
  REPLACE ALL OCCURRENCES OF '"vl_retencao_sub"'        IN rv_json WITH '"VL_RETENCAO_SUB"'.
  REPLACE ALL OCCURRENCES OF '"vl_retencao_nao_efet"'   IN rv_json WITH '"VL_RETENCAO_NAO_EFET"'.
  REPLACE ALL OCCURRENCES OF '"vl_servico_15"'          IN rv_json WITH '"VL_SERVICO_15"'.
  REPLACE ALL OCCURRENCES OF '"vl_servico_20"'          IN rv_json WITH '"VL_SERVICO_20"'.
  REPLACE ALL OCCURRENCES OF '"vl_servico_25"'          IN rv_json WITH '"VL_SERVICO_25"'.
  REPLACE ALL OCCURRENCES OF '"vl_adicional"'           IN rv_json WITH '"VL_ADICIONAL"'.
  REPLACE ALL OCCURRENCES OF '"vl_ret_adic_nao_efet"'   IN rv_json WITH '"VL_RET_ADIC_NAO_EFET"'.

  " Processo / Processo Adicional
  REPLACE ALL OCCURRENCES OF '"nr_item_processo"'       IN rv_json WITH '"NR_ITEM_PROCESSO"'.
  REPLACE ALL OCCURRENCES OF '"dm_processo"'            IN rv_json WITH '"DM_PROCESSO"'.
  REPLACE ALL OCCURRENCES OF '"nr_processo"'            IN rv_json WITH '"NR_PROCESSO"'.
  REPLACE ALL OCCURRENCES OF '"cd_suspensao"'           IN rv_json WITH '"CD_SUSPENSAO"'.

  REPLACE ALL OCCURRENCES OF ' "' IN rv_json WITH '"'.
  REPLACE ALL OCCURRENCES OF '"' IN rv_json WITH '\"'.


  CONCATENATE '{"objetos":["' rv_json '"]}' INTO ret.

ENDMETHOD.