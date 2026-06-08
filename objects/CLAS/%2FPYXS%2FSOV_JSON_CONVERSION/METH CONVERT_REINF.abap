  METHOD convert_reinf.

      DATA(lv_json) = json.

      " --- Envelope ---
      REPLACE ALL OCCURRENCES OF '"OBJETOS"'                         IN lv_json WITH '"objetos"'.

      " --- Root object keys (ty_inner fields) ---
      REPLACE ALL OCCURRENCES OF '"knwReinfR4020"'                   IN lv_json WITH '"knwReinfR4020"'.   " already correct from pretty_name L
      REPLACE ALL OCCURRENCES OF '"reinfR4020PgtoList"'              IN lv_json WITH '"reinfR4020PgtoList"'.
      REPLACE ALL OCCURRENCES OF '"knwReinfR4020InfoPgtoList"'       IN lv_json WITH '"knwReinfR4020InfoPgtoList"'.
      REPLACE ALL OCCURRENCES OF '"knwReinfR4020InfoPgtoRet"'        IN lv_json WITH '"knwReinfR4020InfoPgtoRetList"'.

      " --- Field names inside knwReinfR4020 (ty_knw_r4020) ---
      REPLACE ALL OCCURRENCES OF '"cdEmpresa"'                       IN lv_json WITH '"CD_EMPRESA"'.
      REPLACE ALL OCCURRENCES OF '"cdFilial"'                        IN lv_json WITH '"CD_FILIAL"'.
      REPLACE ALL OCCURRENCES OF '"idReferencia"'                    IN lv_json WITH '"ID_REFERENCIA"'.
      REPLACE ALL OCCURRENCES OF '"idEvento"'                        IN lv_json WITH '"ID_EVENTO"'.
      REPLACE ALL OCCURRENCES OF '"dmRetificacao"'                   IN lv_json WITH '"DM_RETIFICACAO"'.
      REPLACE ALL OCCURRENCES OF '"nrRecibo"'                        IN lv_json WITH '"NR_RECIBO"'.
      REPLACE ALL OCCURRENCES OF '"dtApuracao"'                      IN lv_json WITH '"DT_APURACAO"'.
      REPLACE ALL OCCURRENCES OF '"nrNatJur"'                        IN lv_json WITH '"NR_NAT_JUR"'.
      REPLACE ALL OCCURRENCES OF '"dmInscricaoEstab"'                IN lv_json WITH '"DM_INSCRICAO_ESTAB"'.
      REPLACE ALL OCCURRENCES OF '"nrInscricaoEstab"'                IN lv_json WITH '"NR_INSCRICAO_ESTAB"'.
      REPLACE ALL OCCURRENCES OF '"nrCnpjBenef"'                     IN lv_json WITH '"NR_CNPJ_BENEF"'.
      REPLACE ALL OCCURRENCES OF '"nmBenef"'                         IN lv_json WITH '"NM_BENEF"'.
      REPLACE ALL OCCURRENCES OF '"dmIsencaoImun"'                   IN lv_json WITH '"DM_ISENCAO_IMUN"'.
      REPLACE ALL OCCURRENCES OF '"ideEvtAdic"'                      IN lv_json WITH '"IDE_EVT_ADIC"'.

      " --- Field names inside reinfR4020PgtoList (ty_pgto) ---
      " CD_EMPRESA, CD_FILIAL, ID_REFERENCIA already replaced above
      REPLACE ALL OCCURRENCES OF '"idSeqPagto"'                      IN lv_json WITH '"ID_SEQ_PAGTO"'.
      REPLACE ALL OCCURRENCES OF '"nrNatRend"'                       IN lv_json WITH '"NR_NAT_REND"'.
      REPLACE ALL OCCURRENCES OF '"dsObservacao"'                     IN lv_json WITH '"DS_OBSERVACAO"'.

      " --- Field names inside knwReinfR4020InfoPgtoList (ty_info_pgto) ---
      " CD_EMPRESA, CD_FILIAL, ID_REFERENCIA, ID_SEQ_PAGTO already replaced above
      REPLACE ALL OCCURRENCES OF '"idSeqInfoPgto"'                   IN lv_json WITH '"ID_SEQ_INFO_PAGTO"'.
      REPLACE ALL OCCURRENCES OF '"dtFatoGerador"'                   IN lv_json WITH '"DT_FATO_GERADOR"'.
      REPLACE ALL OCCURRENCES OF '"vlBruto"'                         IN lv_json WITH '"VL_BRUTO"'.
      REPLACE ALL OCCURRENCES OF '"dsObserv"'                        IN lv_json WITH '"DS_OBSERV"'.
      REPLACE ALL OCCURRENCES OF '"dmFciScp"'                        IN lv_json WITH '"DM_FCI_SCP"'.
      REPLACE ALL OCCURRENCES OF '"nrInscFciScp"'                    IN lv_json WITH '"NR_INSC_FCI_SCP"'.
      REPLACE ALL OCCURRENCES OF '"nrPercScp"'                       IN lv_json WITH '"NR_PERC_SCP"'.
      REPLACE ALL OCCURRENCES OF '"dmJud"'                           IN lv_json WITH '"DM_JUD"'.
      REPLACE ALL OCCURRENCES OF '"cdPaisResid"'                     IN lv_json WITH '"CD_PAIS_RESID"'.
      REPLACE ALL OCCURRENCES OF '"dtEscrCont"'                      IN lv_json WITH '"DT_ESCR_CONT"'.

      " --- Field names inside knwReinfR4020InfoPgtoRetList (ty_info_pgto_ret) ---
      " CD_EMPRESA, CD_FILIAL, ID_REFERENCIA, ID_SEQ_PAGTO, ID_SEQ_INFO_PAGTO already replaced above
      REPLACE ALL OCCURRENCES OF '"vlBaseIr"'                        IN lv_json WITH '"VL_BASE_IR"'.
      REPLACE ALL OCCURRENCES OF '"vlIr"'                            IN lv_json WITH '"VL_IR"'.
      REPLACE ALL OCCURRENCES OF '"vlBaseCsll"'                      IN lv_json WITH '"VL_BASE_CSLL"'.
      REPLACE ALL OCCURRENCES OF '"vlCsll"'                          IN lv_json WITH '"VL_CSLL"'.
      REPLACE ALL OCCURRENCES OF '"vlBaseCofins"'                    IN lv_json WITH '"VL_BASE_COFINS"'.
      REPLACE ALL OCCURRENCES OF '"vlCofins"'                        IN lv_json WITH '"VL_COFINS"'.
      REPLACE ALL OCCURRENCES OF '"vlBasePisPasep"'                  IN lv_json WITH '"VL_BASE_PIS_PASEP"'.
      REPLACE ALL OCCURRENCES OF '"vlPisPasep"'                      IN lv_json WITH '"VL_PIS_PASEP"'.
      REPLACE ALL OCCURRENCES OF '"vlBaseAgreg"'                     IN lv_json WITH '"VL_BASE_AGREG"'.
      REPLACE ALL OCCURRENCES OF '"vlAgreg"'                         IN lv_json WITH '"VL_AGREG"'.

      " --- Strip empty/zero fields the API rejects (optional but clean) ---
      " Remove blank string values for optional fields
      REPLACE ALL OCCURRENCES OF ',"NR_RECIBO":""'                   IN lv_json WITH ''.
      REPLACE ALL OCCURRENCES OF ',"NR_NAT_JUR":""'                  IN lv_json WITH ''.
      REPLACE ALL OCCURRENCES OF ',"IDE_EVT_ADIC":""'                IN lv_json WITH ''.
      REPLACE ALL OCCURRENCES OF ',"DM_FCI_SCP":""'                  IN lv_json WITH ''.
      REPLACE ALL OCCURRENCES OF ',"NR_INSC_FCI_SCP":""'             IN lv_json WITH ''.
      REPLACE ALL OCCURRENCES OF ',"NR_PERC_SCP":""'                 IN lv_json WITH ''.
      REPLACE ALL OCCURRENCES OF ',"DM_JUD":""'                      IN lv_json WITH ''.
      REPLACE ALL OCCURRENCES OF ',"CD_PAIS_RESID":""'               IN lv_json WITH ''.
      REPLACE ALL OCCURRENCES OF ',"DT_ESCR_CONT":""'                IN lv_json WITH ''.
      REPLACE ALL OCCURRENCES OF ',"DS_OBSERVACAO":""'               IN lv_json WITH ''.

      ret = lv_json.

  ENDMETHOD.