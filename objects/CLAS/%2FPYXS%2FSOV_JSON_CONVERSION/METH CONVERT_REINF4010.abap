  METHOD convert_reinf4010.

  DATA(rv_json) = json.

  " Root nodes
  REPLACE ALL OCCURRENCES OF '"knwreinfr4010"'                   IN rv_json WITH '"knwReinfR4010"'.
  REPLACE ALL OCCURRENCES OF '"knwreinfr4010rendlist"'           IN rv_json WITH '"knwReinfR4010RendList"'.
  REPLACE ALL OCCURRENCES OF '"knwreinfr4010pgtolist"'           IN rv_json WITH '"knwReinfR4010PgtoList"'.
  REPLACE ALL OCCURRENCES OF '"knwreinfr4010pgtoextlist"'        IN rv_json WITH '"knwReinfR4010PgtoExtList"'.
  REPLACE ALL OCCURRENCES OF '"knwreinfr4010rendisentolist"'     IN rv_json WITH '"knwReinfR4010RendIsentoList"'.
  REPLACE ALL OCCURRENCES OF '"knwreinfr4010dedlist"'            IN rv_json WITH '"knwReinfR4010DedList"'.
  REPLACE ALL OCCURRENCES OF '"knwreinfr4010benpendedlist"'      IN rv_json WITH '"knwReinfR4010BenefPensaoDedList"'.
  REPLACE ALL OCCURRENCES OF '"knwreinfr4010procretlist"'        IN rv_json WITH '"knwReinfR4010ProcRetList"'.
  REPLACE ALL OCCURRENCES OF '"knwreinfr4010dedsusplist"'        IN rv_json WITH '"knwReinfR4010DedSuspList"'.
  REPLACE ALL OCCURRENCES OF '"knwreinfr4010benpendedsusplist"'  IN rv_json WITH '"knwReinfR4010BenefPensaoDedSuspList"'.
  REPLACE ALL OCCURRENCES OF '"knwreinfr4010rralist"'            IN rv_json WITH '"knwReinfR4010RraList"'.
  REPLACE ALL OCCURRENCES OF '"knwreinfr4010rraadvlist"'         IN rv_json WITH '"knwReinfR4010RraAdvList"'.
  REPLACE ALL OCCURRENCES OF '"knwreinfr4010procjudlist"'        IN rv_json WITH '"knwReinfR4010ProcJudList"'.
  REPLACE ALL OCCURRENCES OF '"knwreinfr4010procjudadvlist"'     IN rv_json WITH '"knwReinfR4010ProcJudAdvList"'.
  REPLACE ALL OCCURRENCES OF '"knwreinfr4010opersaudelist"'      IN rv_json WITH '"knwReinfR4010OperSaudeList"'.
  REPLACE ALL OCCURRENCES OF '"knwreinfr4010dependesaudelist"'   IN rv_json WITH '"knwReinfR4010DependeSaudeList"'.
  REPLACE ALL OCCURRENCES OF '"knwreinfr4010reemblist"'          IN rv_json WITH '"knwReinfR4010ReembList"'.
  REPLACE ALL OCCURRENCES OF '"knwreinfr4010reembdependelist"'   IN rv_json WITH '"knwReinfR4010ReembDependeList"'.
  REPLACE ALL OCCURRENCES OF '"knwreinfr4010dependentelist"'     IN rv_json WITH '"knwReinfR4010DependenteList"'.

  " Common fields / knwReinfR4010
  REPLACE ALL OCCURRENCES OF '"cd_empresa"'                  IN rv_json WITH '"CD_EMPRESA"'.
  REPLACE ALL OCCURRENCES OF '"cd_filial"'                   IN rv_json WITH '"CD_FILIAL"'.
  REPLACE ALL OCCURRENCES OF '"id_referencia"'               IN rv_json WITH '"ID_REFERENCIA"'.
  REPLACE ALL OCCURRENCES OF '"dm_retificacao"'              IN rv_json WITH '"DM_RETIFICACAO"'.
  REPLACE ALL OCCURRENCES OF '"dt_apuracao"'                 IN rv_json WITH '"DT_APURACAO"'.
  REPLACE ALL OCCURRENCES OF '"nr_nat_jur"'                  IN rv_json WITH '"NR_NAT_JUR"'.
  REPLACE ALL OCCURRENCES OF '"dm_inscricao_estab"'          IN rv_json WITH '"DM_INSCRICAO_ESTAB"'.
  REPLACE ALL OCCURRENCES OF '"nr_inscricao_estab"'          IN rv_json WITH '"NR_INSCRICAO_ESTAB"'.
  REPLACE ALL OCCURRENCES OF '"nr_cnpj_benef"'               IN rv_json WITH '"NR_CNPJ_BENEF"'.
  REPLACE ALL OCCURRENCES OF '"nm_benef"'                    IN rv_json WITH '"NM_BENEF"'.
  REPLACE ALL OCCURRENCES OF '"cd_evt_adic"'                 IN rv_json WITH '"CD_EVT_ADIC"'.

  " Rend
  REPLACE ALL OCCURRENCES OF '"nr_item_rend"'                IN rv_json WITH '"NR_ITEM_REND"'.
  REPLACE ALL OCCURRENCES OF '"cd_nat_rend"'                 IN rv_json WITH '"CD_NAT_REND"'.
  REPLACE ALL OCCURRENCES OF '"ds_observacao"'               IN rv_json WITH '"DS_OBSERVACAO"'.

  " Pgto
  REPLACE ALL OCCURRENCES OF '"nr_item_pgto"'                IN rv_json WITH '"NR_ITEM_PGTO"'.
  REPLACE ALL OCCURRENCES OF '"dt_fato_gerador"'             IN rv_json WITH '"DT_FATO_GERADOR"'.
  REPLACE ALL OCCURRENCES OF '"dt_comp_rendimento"'          IN rv_json WITH '"DT_COMP_RENDIMENTO"'.
  REPLACE ALL OCCURRENCES OF '"dm_dec_terc"'                 IN rv_json WITH '"DM_DEC_TERC"'.
  REPLACE ALL OCCURRENCES OF '"vl_rend_bruto"'               IN rv_json WITH '"VL_REND_BRUTO"'.
  REPLACE ALL OCCURRENCES OF '"vl_rend_trib"'                IN rv_json WITH '"VL_REND_TRIB"'.
  REPLACE ALL OCCURRENCES OF '"vl_ir"'                       IN rv_json WITH '"VL_IR"'.
  REPLACE ALL OCCURRENCES OF '"dm_ind_rra"'                  IN rv_json WITH '"DM_IND_RRA"'.
  REPLACE ALL OCCURRENCES OF '"dm_fci_scp"'                  IN rv_json WITH '"DM_FCI_SCP"'.
  REPLACE ALL OCCURRENCES OF '"nr_inscricao_fci_scp"'        IN rv_json WITH '"NR_INSCRICAO_FCI_SCP"'.
  REPLACE ALL OCCURRENCES OF '"vl_perc_scp"'                 IN rv_json WITH '"VL_PERC_SCP"'.
  REPLACE ALL OCCURRENCES OF '"dm_indic_judicial"'           IN rv_json WITH '"DM_INDIC_JUDICIAL"'.
  REPLACE ALL OCCURRENCES OF '"cd_pais_resid_ext"'           IN rv_json WITH '"CD_PAIS_RESID_EXT"'.
  REPLACE ALL OCCURRENCES OF '"dt_escr_cont"'                IN rv_json WITH '"DT_ESCR_CONT"'.
  REPLACE ALL OCCURRENCES OF '"ds_observ"'                   IN rv_json WITH '"DS_OBSERV"'.

  " PgtoExt
  REPLACE ALL OCCURRENCES OF '"dm_nfi"'                      IN rv_json WITH '"DM_NFI"'.
  REPLACE ALL OCCURRENCES OF '"nr_identificao_nfi"'          IN rv_json WITH '"NR_IDENTIFICAO_NFI"'.
  REPLACE ALL OCCURRENCES OF '"cd_forma_trib"'               IN rv_json WITH '"CD_FORMA_TRIB"'.
  REPLACE ALL OCCURRENCES OF '"ds_logradouro"'               IN rv_json WITH '"DS_LOGRADOURO"'.
  REPLACE ALL OCCURRENCES OF '"nr_logradouro"'               IN rv_json WITH '"NR_LOGRADOURO"'.
  REPLACE ALL OCCURRENCES OF '"ds_complemento"'              IN rv_json WITH '"DS_COMPLEMENTO"'.
  REPLACE ALL OCCURRENCES OF '"ds_bairro"'                   IN rv_json WITH '"DS_BAIRRO"'.
  REPLACE ALL OCCURRENCES OF '"ds_cidade"'                   IN rv_json WITH '"DS_CIDADE"'.
  REPLACE ALL OCCURRENCES OF '"ds_estado"'                   IN rv_json WITH '"DS_ESTADO"'.
  REPLACE ALL OCCURRENCES OF '"cd_postal"'                   IN rv_json WITH '"CD_POSTAL"'.
  REPLACE ALL OCCURRENCES OF '"nr_telefone"'                 IN rv_json WITH '"NR_TELEFONE"'.

  " RendIsento
  REPLACE ALL OCCURRENCES OF '"nr_item_rend_isento"'         IN rv_json WITH '"NR_ITEM_REND_ISENTO"'.
  REPLACE ALL OCCURRENCES OF '"dm_tipo_isencao"'             IN rv_json WITH '"DM_TIPO_ISENCAO"'.
  REPLACE ALL OCCURRENCES OF '"vl_isento"'                   IN rv_json WITH '"VL_ISENTO"'.

  " Ded / BenefPensaoDed
  REPLACE ALL OCCURRENCES OF '"nr_item_ded"'                 IN rv_json WITH '"NR_ITEM_DED"'.
  REPLACE ALL OCCURRENCES OF '"dm_tipo_ded"'                 IN rv_json WITH '"DM_TIPO_DED"'.
  REPLACE ALL OCCURRENCES OF '"vl_deducao"'                  IN rv_json WITH '"VL_DEDUCAO"'.
  REPLACE ALL OCCURRENCES OF '"dm_info_ent"'                 IN rv_json WITH '"DM_INFO_ENT"'.
  REPLACE ALL OCCURRENCES OF '"nr_item_benef_pensao_ded"'    IN rv_json WITH '"NR_ITEM_BENEF_PENSAO_DED"'.
  REPLACE ALL OCCURRENCES OF '"nr_cpf"'                      IN rv_json WITH '"NR_CPF"'.
  REPLACE ALL OCCURRENCES OF '"vl_dependencia"'              IN rv_json WITH '"VL_DEPENDENCIA"'.

  " ProcRet / DedSusp / BenefPensaoDedSusp
  REPLACE ALL OCCURRENCES OF '"nr_item_proc_ret"'            IN rv_json WITH '"NR_ITEM_PROC_RET"'.
  REPLACE ALL OCCURRENCES OF '"dm_tipo_proc_ret"'            IN rv_json WITH '"DM_TIPO_PROC_RET"'.
  REPLACE ALL OCCURRENCES OF '"nr_proc_ret"'                 IN rv_json WITH '"NR_PROC_RET"'.
  REPLACE ALL OCCURRENCES OF '"vl_nao_retencao"'             IN rv_json WITH '"VL_NAO_RETENCAO"'.
  REPLACE ALL OCCURRENCES OF '"vl_deposito_jud"'             IN rv_json WITH '"VL_DEPOSITO_JUD"'.
  REPLACE ALL OCCURRENCES OF '"nr_item_ded_susp"'            IN rv_json WITH '"NR_ITEM_DED_SUSP"'.
  REPLACE ALL OCCURRENCES OF '"vl_deducao_susp"'             IN rv_json WITH '"VL_DEDUCAO_SUSP"'.
  REPLACE ALL OCCURRENCES OF '"nr_item_benef_ded_susp"'      IN rv_json WITH '"NR_ITEM_BENEF_DED_SUSP"'.
  REPLACE ALL OCCURRENCES OF '"vl_dependencia_susp"'         IN rv_json WITH '"VL_DEPENDENCIA_SUSP"'.

  " Rra / RraAdv
  REPLACE ALL OCCURRENCES OF '"nr_item_rra"'                 IN rv_json WITH '"NR_ITEM_RRA"'.
  REPLACE ALL OCCURRENCES OF '"dm_tipo_processo"'            IN rv_json WITH '"DM_TIPO_PROCESSO"'.
  REPLACE ALL OCCURRENCES OF '"nr_processo"'                 IN rv_json WITH '"NR_PROCESSO"'.
  REPLACE ALL OCCURRENCES OF '"dm_origem_rec"'               IN rv_json WITH '"DM_ORIGEM_REC"'.
  REPLACE ALL OCCURRENCES OF '"ds_rra"'                      IN rv_json WITH '"DS_RRA"'.
  REPLACE ALL OCCURRENCES OF '"nr_qtde_meses_rra"'           IN rv_json WITH '"NR_QTDE_MESES_RRA"'.
  REPLACE ALL OCCURRENCES OF '"nr_cnpj_origem"'              IN rv_json WITH '"NR_CNPJ_ORIGEM"'.
  REPLACE ALL OCCURRENCES OF '"vl_desp_custas"'              IN rv_json WITH '"VL_DESP_CUSTAS"'.
  REPLACE ALL OCCURRENCES OF '"vl_desp_adv"'                 IN rv_json WITH '"VL_DESP_ADV"'.
  REPLACE ALL OCCURRENCES OF '"nr_item_adv"'                 IN rv_json WITH '"NR_ITEM_ADV"'.
  REPLACE ALL OCCURRENCES OF '"dm_tipo_adv"'                 IN rv_json WITH '"DM_TIPO_ADV"'.
  REPLACE ALL OCCURRENCES OF '"nr_inscricao_adv"'            IN rv_json WITH '"NR_INSCRICAO_ADV"'.
  REPLACE ALL OCCURRENCES OF '"vl_adv"'                      IN rv_json WITH '"VL_ADV"'.

  " ProcJud / ProcJudAdv
  REPLACE ALL OCCURRENCES OF '"nr_item_proc_jud"'            IN rv_json WITH '"NR_ITEM_PROC_JUD"'.
  REPLACE ALL OCCURRENCES OF '"dm_origem"'                   IN rv_json WITH '"DM_ORIGEM"'.
  REPLACE ALL OCCURRENCES OF '"ds_descricao"'                IN rv_json WITH '"DS_DESCRICAO"'.

  " OperSaude / DependeSaude / Reemb / ReembDepende
  REPLACE ALL OCCURRENCES OF '"nr_item_oper_saude"'          IN rv_json WITH '"NR_ITEM_OPER_SAUDE"'.
  REPLACE ALL OCCURRENCES OF '"nr_inscricao"'                IN rv_json WITH '"NR_INSCRICAO"'.
  REPLACE ALL OCCURRENCES OF '"cd_ans"'                      IN rv_json WITH '"CD_ANS"'.
  REPLACE ALL OCCURRENCES OF '"vl_saude"'                    IN rv_json WITH '"VL_SAUDE"'.
  REPLACE ALL OCCURRENCES OF '"nr_item_depende"'             IN rv_json WITH '"NR_ITEM_DEPENDE"'.
  REPLACE ALL OCCURRENCES OF '"nr_item_reemb"'               IN rv_json WITH '"NR_ITEM_REEMB"'.
  REPLACE ALL OCCURRENCES OF '"dm_tipo_inscricao"'           IN rv_json WITH '"DM_TIPO_INSCRICAO"'.
  REPLACE ALL OCCURRENCES OF '"vl_reembolso"'                IN rv_json WITH '"VL_REEMBOLSO"'.
  REPLACE ALL OCCURRENCES OF '"nr_item_reemb_depende"'       IN rv_json WITH '"NR_ITEM_REEMB_DEPENDE"'.

  " Dependente
  REPLACE ALL OCCURRENCES OF '"dm_relacao"'                  IN rv_json WITH '"DM_RELACAO"'.
  REPLACE ALL OCCURRENCES OF '"ds_dependente"'               IN rv_json WITH '"DS_DEPENDENTE"'.
  REPLACE ALL OCCURRENCES OF ' "'           IN rv_json WITH '"'.


  REPLACE ALL OCCURRENCES OF '"' IN rv_json WITH '\"'.

  CONCATENATE '{"objetos":["' rv_json '"]}'
  INTO ret.

ENDMETHOD.