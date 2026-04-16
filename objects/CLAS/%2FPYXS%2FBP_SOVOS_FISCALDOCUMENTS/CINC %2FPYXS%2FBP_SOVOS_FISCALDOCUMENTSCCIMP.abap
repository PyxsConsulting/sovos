


CLASS lhc_sovos_fiscaldocuments DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR /pyxs/sovos_fiscaldocuments RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE /pyxs/sovos_fiscaldocuments.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE /pyxs/sovos_fiscaldocuments.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE /pyxs/sovos_fiscaldocuments.

    METHODS read FOR READ
      IMPORTING keys FOR READ /pyxs/sovos_fiscaldocuments RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK /pyxs/sovos_fiscaldocuments.

    METHODS sendintegration FOR MODIFY
      IMPORTING keys FOR ACTION /pyxs/sovos_fiscaldocuments~sendintegration
      RESULT    res  .


ENDCLASS.

CLASS lsc_sovos_fiscaldocuments DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_sovos_fiscaldocuments IMPLEMENTATION.


  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
    MODIFY /pyxs/sov_nf_log FROM TABLE @/pyxs/bp_sovos_fiscaldocuments=>lt_log.
    CLEAR /pyxs/bp_sovos_fiscaldocuments=>lt_log.
  ENDMETHOD.

  METHOD cleanup.
    CLEAR /pyxs/bp_sovos_fiscaldocuments=>lt_log.
  ENDMETHOD.

  METHOD cleanup_finalize.
    CLEAR /pyxs/bp_sovos_fiscaldocuments=>lt_log.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_process_srv DEFINITION.
  PUBLIC SECTION.
    TYPES:
      BEGIN OF ty_knwscretencaolist,
        dt_emissao           TYPE string,
        aliq_iss             TYPE string,
        dt_pagamento         TYPE string,
        vl_base_inss         TYPE p LENGTH 15 DECIMALS 2,
        vl_reten_inss        TYPE p LENGTH 15 DECIMALS 2,
        vl_base_iss          TYPE string,
        vl_reten_iss         TYPE string,
        aliq_irrf            TYPE p LENGTH 15 DECIMALS 2,
        aliq_inss            TYPE p LENGTH 15 DECIMALS 2,
        dt_vencimento_csll   TYPE string,
        dt_vencimento_pis    TYPE string,
        dt_vencimento_cofins TYPE string,
        dt_vencimento_pcc    TYPE string,
        aliq_csll            TYPE p LENGTH 15 DECIMALS 2,
        dt_vencimento_inss   TYPE string,
        dt_vencimento_iss    TYPE string,
        vl_pagamento         TYPE p LENGTH 15 DECIMALS 2,
        cd_ret_pis           TYPE string,
        cd_ret_cofins        TYPE string,
        cd_ret_csll          TYPE string,
        vl_csll              TYPE p LENGTH 15 DECIMALS 2,
        vl_bc_ret_pis        TYPE p LENGTH 15 DECIMALS 2,
        vl_bc_ret_cofins     TYPE p LENGTH 15 DECIMALS 2,
        vl_bc_ret_csll       TYPE p LENGTH 15 DECIMALS 2,
        cd_ret_pcc           TYPE string,
        vl_ret_pcc           TYPE p LENGTH 15 DECIMALS 2,
        vl_bc_ret_pcc        TYPE p LENGTH 15 DECIMALS 2,
        aliq_pcc             TYPE p LENGTH 15 DECIMALS 2,
        vl_retencao_irrf     TYPE p LENGTH 15 DECIMALS 2,
        dt_vencimento_irrf   TYPE string,
        dm_emitente          TYPE p LENGTH 15 DECIMALS 2,
        nr_documento         TYPE string,
        cod_empresa          TYPE string,
        cod_filial           TYPE string,
        cd_pessoa_remet_dest TYPE string,
        id_usuario_imp       TYPE string,
        vl_bc_irrf           TYPE p LENGTH 15 DECIMALS 2,
        nr_item              TYPE string,
        aliq_pis             TYPE p LENGTH 15 DECIMALS 2,
        aliq_cofins          TYPE p LENGTH 15 DECIMALS 2,
        vl_parcela           TYPE p LENGTH 15 DECIMALS 2,
        nr_parcela           TYPE p LENGTH 15 DECIMALS 2,
        vl_pis               TYPE p LENGTH 15 DECIMALS 2,
        vl_cofins            TYPE p LENGTH 15 DECIMALS 2,
      END OF ty_knwscretencaolist,


      BEGIN OF ty_knw0190,
        dt_inicial    TYPE string,
        dt_importacao TYPE string,
        cod_empresa   TYPE string,
        cod_filial    TYPE string,
        ds_unidade    TYPE string,
        ds_descricao  TYPE string,
      END OF ty_knw0190,


      BEGIN OF ty_knw0200,
        dt_inicial       TYPE string,
        dt_importacao    TYPE string,
        cod_empresa      TYPE string,
        cod_filial       TYPE string,
        cd_produto_serv  TYPE string,
        ds_produto_serv  TYPE string,
        unidade          TYPE string,
        aliq_icms        TYPE p LENGTH 15 DECIMALS 2,
        perc_red_ba_icms TYPE p LENGTH 15 DECIMALS 2,
        cd_lst           TYPE string,
        dm_tipo_item     TYPE string,
        aliq_pis         TYPE p LENGTH 15 DECIMALS 2,
        aliq_cofins      TYPE p LENGTH 15 DECIMALS 2,
      END OF ty_knw0200,


      BEGIN OF ty_knwa170,
        nr_serie             TYPE string,
        dt_emissao           TYPE string,
        vl_bc_iss            TYPE p LENGTH 15 DECIMALS 2,
        aliq_iss             TYPE p LENGTH 15 DECIMALS 2,
        vl_iss               TYPE p LENGTH 15 DECIMALS 2,
        vl_isentas_iss       TYPE p LENGTH 15 DECIMALS 2,
        dt_execucao          TYPE string,
        dm_tipo_documento    TYPE string,
        dm_tributacao        TYPE string,
        vl_deducao           TYPE p LENGTH 15 DECIMALS 2,
        dm_iss_retido        TYPE string,
        dm_tipo_nfts         TYPE string,
        vl_bc_iss_ret        TYPE string,
        vl_iss_ret           TYPE string,
        vl_bc_inss           TYPE p LENGTH 15 DECIMALS 2,
        dm_emitente          TYPE string,
        nr_documento         TYPE string,
        vl_desconto          TYPE string,
        cod_empresa          TYPE string,
        cod_filial           TYPE string,
        cd_pessoa_remet_dest TYPE string,
        cd_plano_conta       TYPE string,
        vl_servico           TYPE string,
        nr_item              TYPE string,
        cd_lst               TYPE string,
        cd_prod_serv         TYPE string,
        cd_sit_trib_pis      TYPE string,
        cd_sit_trib_cofins   TYPE string,
        aliq_pis             TYPE string,
        aliq_cofins          TYPE string,
        vl_bc_pis            TYPE string,
        vl_pis               TYPE string,
        vl_bc_cofins         TYPE string,
        vl_cofins            TYPE string,
      END OF ty_knwa170,


      BEGIN OF ty_integracaonotafiscalservico,
        knwa170 TYPE ty_knwa170,
        knw0200 TYPE ty_knw0200,
        knw0190 TYPE ty_knw0190,
      END OF ty_integracaonotafiscalservico,


      BEGIN OF ty_knw0450,
        cod_empresa      TYPE string,
        cod_filial       TYPE string,
        dt_inicial       TYPE string,
        dt_importacao    TYPE string,
        cod_grupoempresa TYPE string,
        dt_movimento     TYPE string,
      END OF ty_knw0450,


      BEGIN OF ty_knwa110saida,
        dt_emissao           TYPE string,
        dt_execucao          TYPE string,
        cd_compl_fiscal      TYPE string,
        dm_emitente          TYPE p LENGTH 15 DECIMALS 2,
        nr_documento         TYPE string,
        cod_empresa          TYPE string,
        cod_filial           TYPE string,
        cd_pessoa_remet_dest TYPE string,
      END OF ty_knwa110saida,


      BEGIN OF ty_integracaonotafiscal,
        knwa110saida TYPE ty_knwa110saida,
        knw0450      TYPE ty_knw0450,
      END OF ty_integracaonotafiscal,


      BEGIN OF ty_knwa100,
        nr_serie               TYPE string,
        dt_emissao             TYPE string,
        dt_vencimento          TYPE string,
        aliq_iss               TYPE p LENGTH 15 DECIMALS 2,
        dt_execucao            TYPE string,
        dt_escrituracao        TYPE string,
        dm_cancelamento        TYPE string,
        dt_pagamento           TYPE string,
        cd_fiscal_prest        TYPE string,
        dm_pgto                TYPE string,
        cd_municipio_prestacao TYPE string,
        vl_documento           TYPE string,
        vl_tot_subc            TYPE p LENGTH 15 DECIMALS 2,
        vl_material_proprio    TYPE p LENGTH 15 DECIMALS 2,
        vl_material_terceiro   TYPE p LENGTH 15 DECIMALS 2,
        vl_outras_despesas     TYPE p LENGTH 15 DECIMALS 2,
        vl_pis_retido          TYPE p LENGTH 15 DECIMALS 2,
        vl_cofins_retido       TYPE p LENGTH 15 DECIMALS 2,
        nr_parcela_mensal      TYPE p LENGTH 15 DECIMALS 2,
        cd_cosif               TYPE p LENGTH 15 DECIMALS 2,
        vl_base_inss           TYPE p LENGTH 15 DECIMALS 2,
        vl_reten_inss          TYPE p LENGTH 15 DECIMALS 2,
        vl_base_iss            TYPE p LENGTH 15 DECIMALS 2,
        vl_reten_iss           TYPE string,
        aliq_irrf              TYPE p LENGTH 15 DECIMALS 2,
        aliq_inss              TYPE p LENGTH 15 DECIMALS 2,
        vl_base_irrf           TYPE p LENGTH 15 DECIMALS 2,
        vl_reten_irrf          TYPE p LENGTH 15 DECIMALS 2,
        dm_emitente            TYPE string,
        nr_documento           TYPE string,
        vl_desconto            TYPE string,
        cod_empresa            TYPE string,
        cod_filial             TYPE string,
        cd_pessoa_remet_dest   TYPE string,
        cd_centro_custo        TYPE string,
      END OF ty_knwa100,


      BEGIN OF ty_knw0600,
        cod_empresa     TYPE string,
        cod_filial      TYPE string,
        dt_inicial      TYPE string,
        cd_centro_custo TYPE string,
        ds_centro_custo TYPE string,
      END OF ty_knw0600,


      BEGIN OF ty_knw0500,
        dt_inicial      TYPE string,
        dm_tipo_conta   TYPE string,
        cd_plan_cta_tot TYPE string,
        ds_plano_conta  TYPE string,
        dm_natureza     TYPE string,
        dm_nivel        TYPE string,
        dt_importacao   TYPE string,
        id_ordem        TYPE p LENGTH 15 DECIMALS 2,
        cod_empresa     TYPE string,
        cod_filial      TYPE string,
        cd_plano_conta  TYPE string,
      END OF ty_knw0500,


      BEGIN OF ty_knw0150,
        dt_inicial      TYPE string,
        dt_importacao   TYPE string,
        cod_empresa     TYPE string,
        cod_filial      TYPE string,
        cd_pessoa       TYPE string,
        ds_endereco     TYPE string,
        nm_razao_social TYPE string,
        nr_numero       TYPE string,
        nr_fone         TYPE string,
        dt_ini_rel      TYPE string,
        dt_fin_rel      TYPE string,
        cd_municipio    TYPE string,
        cd_pais         TYPE string,
        ds_email        TYPE string,
        ds_bairro       TYPE string,
        nr_cep          TYPE string,
        nr_cnpj_cpf     TYPE string,
        nr_inscr_munic  TYPE string,
        dm_contribuinte TYPE string,
      END OF ty_knw0150,


      BEGIN OF ty_objetos,
        knw0150                     TYPE ty_knw0150,
        knw0500                     TYPE ty_knw0500,
        knw0600                     TYPE ty_knw0600,
        knwa100                     TYPE ty_knwa100,
        integracaonotafiscalservico TYPE STANDARD TABLE OF ty_integracaonotafiscalservico WITH NON-UNIQUE DEFAULT KEY,
        knwscretencaolist           TYPE STANDARD TABLE OF ty_knwscretencaolist WITH NON-UNIQUE DEFAULT KEY,
      END OF ty_objetos,


      BEGIN OF ty_main,
        docnum  TYPE string,
        objetos TYPE STANDARD TABLE OF ty_objetos WITH NON-UNIQUE DEFAULT KEY,
      END OF ty_main.

ENDCLASS.

CLASS lcl_process_srv IMPLEMENTATION.

ENDCLASS.

CLASS lcl_process DEFINITION FRIENDS lhc_sovos_fiscaldocuments.
  PUBLIC SECTION.
    CLASS-METHODS: main,
      build_cnpj
        IMPORTING
                  input         TYPE string
        RETURNING VALUE(output) TYPE string.
    TYPES:
      BEGIN OF ty_knwd100,
        id_empresa              TYPE p LENGTH 15 DECIMALS 2,
        dm_emitente             TYPE string,
        dt_importacao           TYPE string,
        nr_documento            TYPE string,
        dt_entrada              TYPE string,
        vl_icms                 TYPE p LENGTH 15 DECIMALS 2,
        nr_serie                TYPE string,
        dt_aquisicao_prestacao  TYPE string,
        nr_chave_acesso_cte     TYPE string,
        vl_total_documento      TYPE string,
        vl_total_desconto       TYPE p LENGTH 15 DECIMALS 2,
        vl_total_prest_servico  TYPE p LENGTH 15 DECIMALS 2,
        vl_nao_trbutado         TYPE p LENGTH 15 DECIMALS 2,
        dt_emissao              TYPE string,
        vl_base_calculo_icms    TYPE p LENGTH 15 DECIMALS 2,
        nr_chave_acesso_cte_ref TYPE string,
      END OF ty_knwd100,


      BEGIN OF ty_integracaoconhecimentotrans,
        knwd100 TYPE ty_knwd100,
      END OF ty_integracaoconhecimentotrans,


      BEGIN OF ty_knwd700,
        dt_importacao     TYPE string,
        cod_empresa       TYPE string,
        cod_filial        TYPE string,
        id_usuario_imp    TYPE string,
        vl_servico        TYPE string,
        nr_subserie       TYPE string,
        vl_servico_nt     TYPE string,
        vl_terceiros      TYPE string,
        vl_desp_acessoria TYPE string,
        vl_deducoes       TYPE string,
        dm_tipo_assinante TYPE string,
        cd_conta_contabil TYPE string,
        dm_fin_doce       TYPE string,
        dm_tip_fat        TYPE string,
        cd_modelo_ref     TYPE string,
        nr_chv_doce_ref   TYPE string,
        hash_doc_ref      TYPE string,
        ser_doc_ref       TYPE string,
        num_doc_ref       TYPE string,
        mes_doc_ref       TYPE string,
        dm_ind_prepago    TYPE string,
        dm_ind_receita    TYPE string,
      END OF ty_knwd700,


      BEGIN OF ty_knw0500,
        dt_inicial      TYPE string,
        dm_tipo_conta   TYPE string,
        cd_plan_cta_tot TYPE string,
        ds_plano_conta  TYPE string,
        dm_natureza     TYPE string,
        dm_nivel        TYPE string,
        dt_importacao   TYPE string,
        id_ordem        TYPE p LENGTH 15 DECIMALS 2,
        cod_empresa     TYPE string,
        cod_filial      TYPE string,
        cd_plano_conta  TYPE string,
      END OF ty_knw0500,


      BEGIN OF ty_knw0400,
        dt_inicial       TYPE string,
        dt_importacao    TYPE string,
        cod_empresa      TYPE string,
        cod_filial       TYPE string,
        cod_grupoempresa TYPE string,
        dt_movimento     TYPE string,
        cd_fiscal        TYPE string,
        ds_cd_fiscal     TYPE string,
      END OF ty_knw0400,


      BEGIN OF ty_knw0200,
        cd_plano_conta       TYPE string,
        dt_inicial           TYPE string,
        dt_importacao        TYPE string,
        cod_empresa          TYPE string,
        cod_filial           TYPE string,
        id_usuario_imp       TYPE string,
        chave_registro       TYPE string,
        cd_produto_serv      TYPE string,
        ds_produto_serv      TYPE string,
        unidade              TYPE string,
        cd_sit_tributar_icms TYPE string,
        aliq_icms            TYPE p LENGTH 15 DECIMALS 2,
        perc_red_ba_icms     TYPE p LENGTH 15 DECIMALS 2,
        dm_produto_venda     TYPE string,
        cd_lst               TYPE string,
        cd_ncm               TYPE string,
        cd_genero            TYPE string,
        dm_tipo_item         TYPE string,
        cd_331_ex_ipi        TYPE string,
        cd_barra             TYPE string,
        nr_cest              TYPE string,
        dm_origem_produto    TYPE string,
        cd_centro_custo      TYPE string,
        cd_sit_trib_ipi      TYPE string,
        cd_sit_trib_pis      TYPE string,
        cd_sit_trib_cofins   TYPE string,
        cd_nat_operacao      TYPE string,
        aliq_pis             TYPE p LENGTH 15 DECIMALS 2,
        aliq_cofins          TYPE p LENGTH 15 DECIMALS 2,
      END OF ty_knw0200,


      BEGIN OF ty_knw0190,
        dt_inicial     TYPE string,
        dt_importacao  TYPE string,
        cod_empresa    TYPE string,
        cod_filial     TYPE string,
        id_usuario_imp TYPE string,
        chave_registro TYPE string,
        ds_unidade     TYPE string,
        ds_descricao   TYPE string,
      END OF ty_knw0190,


      BEGIN OF ty_knwc170,
        vl_ii                TYPE string,
        vl_total_item        TYPE string,
        vl_desc_item         TYPE string,
        vl_contabil          TYPE string,
        dm_mov_fisica        TYPE string,
        cd_fiscal_oper       TYPE string,
        vl_ba_calc_icms      TYPE string,
        vl_icms_isento       TYPE string,
        vl_icms_outro        TYPE string,
        vl_icms_observ       TYPE string,
        vl_ba_calc_subs      TYPE string,
        aliq_icms_sub        TYPE string,
        dm_apur_ipi          TYPE string,
        cd_enq_ipi           TYPE string,
        vl_ba_calc_ipi       TYPE string,
        aliq_ipi             TYPE string,
        vl_ipi_isento        TYPE string,
        vl_ipi_outro         TYPE string,
        vl_ipi_observ        TYPE string,
        vl_ba_calc_pis       TYPE string,
        qtde_ba_calc_pis     TYPE string,
        vl_aliq_pis          TYPE string,
        vl_pis_subst         TYPE string,
        aliq_cof             TYPE string,
        dm_emitente          TYPE string,
        dm_entrada_saida     TYPE string,
        serie_subserie       TYPE string,
        nr_documento         TYPE string,
        dt_emissao_doc       TYPE string,
        vl_frete             TYPE string,
        vl_seguro            TYPE string,
        vl_outras_desp       TYPE string,
        vl_ipi               TYPE string,
        vl_icms_substit      TYPE string,
        cod_empresa          TYPE string,
        cod_filial           TYPE string,
        cd_plano_conta       TYPE string,
        cd_pessoa_rem_dest   TYPE string,
        cd_produto_serv      TYPE string,
        unidade              TYPE string,
        aliq_icms            TYPE string,
        nr_item              TYPE string,
        vl_icms              TYPE string,
        cd_sit_trib_ipi      TYPE string,
        cd_sit_trib_pis      TYPE string,
        cd_sit_trib_cofins   TYPE string,
        aliq_pis             TYPE string,
        vl_pis               TYPE string,
        qtde                 TYPE string,
        vl_unitario          TYPE string,
        cd_sit_trib_icms     TYPE string,
        vl_ba_calc_cof       TYPE string,
        qtde_ba_calc_cofins  TYPE string,
        vl_aliq_cofins       TYPE string,
        vl_cof               TYPE string,
        vl_cofins_subst      TYPE string,
        nr_cfi               TYPE string,
        vl_red_bc_icms       TYPE string,
        vl_bc_icms_uf_dest   TYPE string,
        aliq_icms_fcp        TYPE string,
        aliq_icms_dest       TYPE string,
        aliq_icms_inter      TYPE string,
        aliq_icms_inter_part TYPE string,
        vl_icms_fcp_dest     TYPE string,
        vl_icms_dest         TYPE string,
        vl_icms_rem          TYPE string,
        vl_bc_fcp_op         TYPE string,
        aliq_fcp_op          TYPE string,
        vl_fcp_op            TYPE string,
        vl_bc_fcp_st         TYPE string,
        aliq_fcp_st          TYPE string,
        vl_fcp_st            TYPE string,
        vl_bc_fcp_ret        TYPE string,
        aliq_fcp_ret         TYPE string,
        vl_fcp_ret           TYPE string,
        vl_abatimento_nt     TYPE string,
        vl_bc_iss            TYPE string,
        aliq_iss             TYPE string,
        vl_iss               TYPE string,
        vl_isentas_iss       TYPE string,
        vl_ded_bc_iss        TYPE string,
        vl_bc_iss_rt         TYPE string,
        vl_iss_rt            TYPE string,
        qtd_volume_total     TYPE string,
      END OF ty_knwc170,

      BEGIN OF ty_knwc180,
        dm_emitente                TYPE string,
        dm_entrada_saida           TYPE string,
        serie_subserie             TYPE string,
        nr_documento               TYPE string,
        dt_emissao_doc             TYPE string,
        cod_empresa                TYPE string,
        cod_filial                 TYPE string,
        id_usuario_imp             TYPE string,
        cd_pessoa_rem_dest         TYPE string,
        nr_item                    TYPE p LENGTH 15 DECIMALS 2,
        dm_resp_ret_ent            TYPE string,
        qtde_item_ent              TYPE p LENGTH 15 DECIMALS 2,
        cd_unidade_ent             TYPE string,
        vl_unitario_ent            TYPE p LENGTH 15 DECIMALS 2,
        vl_unitario_icms_ent       TYPE p LENGTH 15 DECIMALS 2,
        vl_unit_bc_icms_st_ent     TYPE p LENGTH 15 DECIMALS 2,
        vl_unitario_icms_st_ent    TYPE p LENGTH 15 DECIMALS 2,
        vl_unitario_fcp_st_ent     TYPE p LENGTH 15 DECIMALS 2,
        dm_da_ent                  TYPE string,
        nr_da_ent                  TYPE string,
        cd_mot_ret_sai             TYPE string,
        qtde_item_sai              TYPE p LENGTH 15 DECIMALS 2,
        cd_unidade_sai             TYPE string,
        vl_unitario_sai            TYPE p LENGTH 15 DECIMALS 2,
        vl_unitario_icms_sai       TYPE p LENGTH 15 DECIMALS 2,
        vl_unitario_icms_op_sai    TYPE p LENGTH 15 DECIMALS 2,
        vl_unit_bc_icms_st_est_sai TYPE p LENGTH 15 DECIMALS 2,
        vl_unit_icms_st_est_sai    TYPE p LENGTH 15 DECIMALS 2,
        vl_unit_fcp_icms_st_sai    TYPE p LENGTH 15 DECIMALS 2,
        vl_unit_icms_st_rest_sai   TYPE p LENGTH 15 DECIMALS 2,
        vl_unit_fcp_st_rest_sai    TYPE p LENGTH 15 DECIMALS 2,
        vl_unit_icms_st_compl_sai  TYPE p LENGTH 15 DECIMALS 2,
        vl_unit_fcp_st_compl_sai   TYPE p LENGTH 15 DECIMALS 2,
      END OF ty_knwc180,


      BEGIN OF ty_knwc176list,
        dm_emitente                  TYPE string,
        dm_entrada_saida             TYPE string,
        serie_subserie               TYPE string,
        nr_documento                 TYPE string,
        dt_emissao_doc               TYPE string,
        cod_empresa                  TYPE string,
        cod_filial                   TYPE string,
        id_usuario_imp               TYPE string,
        cd_pessoa_rem_dest           TYPE string,
        nr_item                      TYPE p LENGTH 15 DECIMALS 2,
        cd_mod_doc_ult               TYPE string,
        nr_doc_ult_ent               TYPE p LENGTH 15 DECIMALS 2,
        ser_sub_doc_ult              TYPE string,
        dt_ultima_ent                TYPE string,
        cd_pessoa_ult                TYPE string,
        qtde_ult_ent                 TYPE p LENGTH 15 DECIMALS 2,
        vl_unit_ult_ent              TYPE p LENGTH 15 DECIMALS 2,
        vl_unit_bc_subs              TYPE p LENGTH 15 DECIMALS 2,
        chave_nfe_ult_e              TYPE string,
        num_item_ult_e               TYPE p LENGTH 15 DECIMALS 2,
        vl_unit_bc_icms_ult_e        TYPE p LENGTH 15 DECIMALS 2,
        aliq_icms_ult_e              TYPE p LENGTH 15 DECIMALS 2,
        vl_unit_limite_bc_icms_ult_e TYPE p LENGTH 15 DECIMALS 2,
        vl_unit_icms_ult_e           TYPE p LENGTH 15 DECIMALS 2,
        aliq_st_ult_e                TYPE p LENGTH 15 DECIMALS 2,
        vl_unit_res                  TYPE p LENGTH 15 DECIMALS 2,
        cd_resp_ret                  TYPE string,
        cd_mot_res                   TYPE string,
        chave_nfe_ret                TYPE string,
        cd_part_nfe_ret              TYPE string,
        ser_nfe_ret                  TYPE string,
        num_nfe_ret                  TYPE p LENGTH 15 DECIMALS 2,
        item_nfe_ret                 TYPE p LENGTH 15 DECIMALS 2,
        cd_da                        TYPE string,
        nr_da                        TYPE string,
        vl_unit_res_fcp_st           TYPE p LENGTH 15 DECIMALS 2,
      END OF ty_knwc176list,


      BEGIN OF ty_knwc175list,
        dm_tipo_oper       TYPE string,
        dm_emitente        TYPE string,
        dm_entrada_saida   TYPE string,
        serie_subserie     TYPE string,
        nr_documento       TYPE string,
        dt_emissao_doc     TYPE string,
        cod_empresa        TYPE string,
        cod_filial         TYPE string,
        id_usuario_imp     TYPE string,
        cd_pessoa_rem_dest TYPE string,
        nr_item            TYPE p LENGTH 15 DECIMALS 2,
        nr_cnpj_conces     TYPE string,
        ds_uf_conces       TYPE string,
        nr_chassis         TYPE string,
      END OF ty_knwc175list,


      BEGIN OF ty_knwc173list,
        dt_validade        TYPE string,
        dm_emitente        TYPE string,
        dm_entrada_saida   TYPE string,
        serie_subserie     TYPE string,
        nr_documento       TYPE string,
        dt_emissao_doc     TYPE string,
        cod_empresa        TYPE string,
        cod_filial         TYPE string,
        id_usuario_imp     TYPE string,
        cd_pessoa_rem_dest TYPE string,
        nr_item            TYPE p LENGTH 15 DECIMALS 2,
        lote_medicam       TYPE string,
        vl_preco           TYPE p LENGTH 15 DECIMALS 2,
        dt_fabricacao      TYPE string,
        qtde_item          TYPE p LENGTH 15 DECIMALS 2,
        dm_referencia      TYPE string,
        dm_tipo_prod       TYPE string,
        vl_preco_tab       TYPE p LENGTH 15 DECIMALS 2,
      END OF ty_knwc173list,


      BEGIN OF ty_knwc171list,
        nr_tanque          TYPE string,
        dm_emitente        TYPE string,
        dm_entrada_saida   TYPE string,
        serie_subserie     TYPE string,
        nr_documento       TYPE string,
        dt_emissao_doc     TYPE string,
        cod_empresa        TYPE string,
        cod_filial         TYPE string,
        id_usuario_imp     TYPE string,
        cd_pessoa_rem_dest TYPE string,
        nr_item            TYPE p LENGTH 15 DECIMALS 2,
        qtde               TYPE p LENGTH 15 DECIMALS 2,
      END OF ty_knwc171list,

      BEGIN OF ty_knw0220,
        cod_empresa    TYPE string,
        cod_filial     TYPE string,
        id_usuario_imp TYPE string,
        chave_registro TYPE string,
        cd_prod_serv   TYPE string,
        un_convertida  TYPE string,
        vl_fator_conv  TYPE p LENGTH 15 DECIMALS 2,
      END OF ty_knw0220,


      BEGIN OF ty_integracaosfunidadeconversa,
        knw0220 TYPE ty_knw0220,
        knw0190 TYPE ty_knw0190,
      END OF ty_integracaosfunidadeconversa,


      BEGIN OF ty_notafiscalitemlist,
        knwc170              TYPE ty_knwc170,
        knw0190              TYPE ty_knw0190,
        knw0200              TYPE ty_knw0200,
        unidadeconversaolist TYPE STANDARD TABLE OF ty_integracaosfunidadeconversa WITH NON-UNIQUE DEFAULT KEY,
        knw0400              TYPE ty_knw0400,
        knw0500              TYPE ty_knw0500,
        nwc171list           TYPE STANDARD TABLE OF ty_knwc171list WITH NON-UNIQUE DEFAULT KEY,
        knwc173list          TYPE STANDARD TABLE OF ty_knwc173list WITH NON-UNIQUE DEFAULT KEY,
        knwc175list          TYPE STANDARD TABLE OF ty_knwc175list WITH NON-UNIQUE DEFAULT KEY,
        knwc176list          TYPE STANDARD TABLE OF ty_knwc176list WITH NON-UNIQUE DEFAULT KEY,
        knwc180              TYPE ty_knwc180,
      END OF ty_notafiscalitemlist,


      BEGIN OF ty_knw0150,
        dt_inicial           TYPE string,
        dt_importacao        TYPE string,
        cod_empresa          TYPE string,
        cod_filial           TYPE string,
        id_usuario_imp       TYPE string,
        chave_registro       TYPE string,
        cd_pessoa            TYPE string,
        nm_razao_social      TYPE string,
        ds_endereco          TYPE string,
        ds_bairro            TYPE string,
        nr_cep               TYPE string,
        nr_cnpj_cpf          TYPE string,
        nr_inscr_est         TYPE string,
        nr_inscr_munic       TYPE string,
        nr_cei               TYPE string,
        nr_inscr_subst       TYPE string,
        cd_suframa           TYPE string,
        nr_numero            TYPE string,
        ds_complemento       TYPE string,
        nr_cep_cp            TYPE string,
        nr_cp                TYPE string,
        nr_fone              TYPE string,
        nr_fax               TYPE string,
        dm_relacionado       TYPE string,
        dt_ini_rel           TYPE string,
        dt_fin_rel           TYPE string,
        nr_nit               TYPE string,
        cd_cnae              TYPE string,
        nr_categoria         TYPE string,
        cd_municipio         TYPE string,
        cd_pais              TYPE string,
        ds_email             TYPE string,
        dm_natureza_empresa  TYPE string,
        dm_regime_tributario TYPE string,
        nm_tp_logradouro     TYPE string,
        nm_titulo_logradouro TYPE string,
        dm_contribuinte      TYPE string,
      END OF ty_knw0150,


      BEGIN OF ty_knwc100,
        dm_emitente            TYPE string,
        dm_entrada_saida       TYPE string,
        serie_subserie         TYPE string,
        nr_documento           TYPE string,
        dt_emissao_doc         TYPE string,
        dt_entrada             TYPE string,
        vl_total_mercad        TYPE p LENGTH 15 DECIMALS 2,
        vl_desconto            TYPE string,
        vl_frete               TYPE string,
        vl_seguro              TYPE string,
        vl_outras_desp         TYPE string,
        vl_ipi                 TYPE string,
        vl_icms_substit        TYPE string,
        vl_tot_n_fiscal        TYPE string,
        nr_insc_est_sub        TYPE string,
        dm_tipo_fatura         TYPE string,
        ds_observacao          TYPE string,
        cod_empresa            TYPE string,
        cod_filial             TYPE string,
        cd_modelo_doc          TYPE string,
        cd_pessoa_remet_dest   TYPE string,
        dm_modal_frete         TYPE string,
        cd_sit_documento       TYPE string,
        nr_chave_eletr         TYPE string,
        vl_abat_n_trib         TYPE string,
        nr_referencia          TYPE string,
        ds_ade                 TYPE string,
        cod_mun_orig           TYPE string,
        cod_mun_des            TYPE string,
        nr_cnpj_cpf_venda_cons TYPE string,
        ds_natureza            TYPE string,
        ds_uf_dest_emit        TYPE string,
        ds_ressarcimento       TYPE string,
        id_usuario_imp         TYPE string,
        vl_serv_nt             TYPE string,
        vl_bc_irrf             TYPE string,
        vl_irrf                TYPE string,
        vl_bc_prev             TYPE string,
        vl_prev                TYPE string,
        cd_mun_serv_prest      TYPE string,
        vl_material_terc       TYPE string,
        vl_sub_empr            TYPE string,
        dm_finalidade          TYPE string,
        dm_destinatario        TYPE string,
        chave_registro         TYPE string,
        vl_servico1            TYPE string,
      END OF ty_knwc100,

      BEGIN OF ty_knwc111,
        dm_emitente        TYPE string,
        dm_entrada_saida   TYPE string,
        serie_subserie     TYPE string,
        nr_documento       TYPE string,
        dt_emissao_doc     TYPE string,
        cod_empresa        TYPE string,
        cod_filial         TYPE string,
        id_usuario_imp     TYPE string,
        chave_registro     TYPE string,
        cd_pessoa_rem_dest TYPE string,
        nr_item            TYPE p LENGTH 15 DECIMALS 2,
        nr_processo        TYPE string,
        dm_processo        TYPE string,
      END OF ty_knwc111,

      BEGIN OF ty_knwc120,
        dm_emitente        TYPE string,
        dm_entrada_saida   TYPE string,
        serie_subserie     TYPE string,
        nr_documento       TYPE string,
        dt_emissao_doc     TYPE string,
        vl_ipi             TYPE p LENGTH 15 DECIMALS 2,
        cod_empresa        TYPE string,
        cod_filial         TYPE string,
        id_usuario_imp     TYPE string,
        chave_registro     TYPE string,
        vl_bc_icms         TYPE p LENGTH 15 DECIMALS 2,
        vl_icms            TYPE p LENGTH 15 DECIMALS 2,
        cd_pessoa_rem_dest TYPE string,
        vl_pis             TYPE p LENGTH 15 DECIMALS 2,
        vl_cofins          TYPE p LENGTH 15 DECIMALS 2,
        dt_registro        TYPE string,
        nr_di              TYPE string,
        dm_importacao      TYPE string,
        nr_acdraw          TYPE string,
        dt_desembaraco     TYPE string,
        vl_cif             TYPE p LENGTH 15 DECIMALS 2,
        vl_desp_aduan      TYPE p LENGTH 15 DECIMALS 2,
        vl_desp_ad_icms    TYPE p LENGTH 15 DECIMALS 2,
        vl_iof             TYPE p LENGTH 15 DECIMALS 2,
        vl_ii              TYPE p LENGTH 15 DECIMALS 2,
        vl_bc_ipi          TYPE p LENGTH 15 DECIMALS 2,
      END OF ty_knwc120,

      BEGIN OF ty_knwc140,
        dm_emitente        TYPE string,
        dm_entrada_saida   TYPE string,
        serie_subserie     TYPE string,
        nr_documento       TYPE string,
        dt_emissao_doc     TYPE string,
        cod_empresa        TYPE string,
        cod_filial         TYPE string,
        id_usuario_imp     TYPE string,
        chave_registro     TYPE string,
        ds_complementar    TYPE string,
        cd_pessoa_rem_dest TYPE string,
        dm_emitente_titulo TYPE string,
        dm_titulo          TYPE string,
        nr_titulo          TYPE string,
        qtde_parcela       TYPE p LENGTH 15 DECIMALS 2,
        vl_titulo          TYPE p LENGTH 15 DECIMALS 2,
      END OF ty_knwc140,

      BEGIN OF ty_knwc141,
        dm_emitente        TYPE string,
        dm_entrada_saida   TYPE string,
        serie_subserie     TYPE string,
        nr_documento       TYPE string,
        dt_emissao_doc     TYPE string,
        cod_empresa        TYPE string,
        cod_filial         TYPE string,
        id_usuario_imp     TYPE string,
        chave_registro     TYPE string,
        cd_pessoa_rem_dest TYPE string,
        vl_parcela         TYPE p LENGTH 15 DECIMALS 2,
        nr_parcela         TYPE p LENGTH 15 DECIMALS 2,
        dt_vencimento      TYPE string,
      END OF ty_knwc141,

      BEGIN OF ty_knwc197,
        dm_emitente        TYPE string,
        dm_entrada_saida   TYPE string,
        serie_subserie     TYPE string,
        nr_documento       TYPE string,
        dt_emissao_doc     TYPE string,
        cod_empresa        TYPE string,
        cod_filial         TYPE string,
        id_usuario_imp     TYPE string,
        chave_registro     TYPE string,
        aliq_icms          TYPE p LENGTH 15 DECIMALS 2,
        ds_complementar    TYPE string,
        cd_ref_53          TYPE string,
        cd_prod_serv       TYPE string,
        vl_bc_icms         TYPE p LENGTH 15 DECIMALS 2,
        vl_icms            TYPE p LENGTH 15 DECIMALS 2,
        vl_icms_outras     TYPE p LENGTH 15 DECIMALS 2,
        cd_pessoa_rem_dest TYPE string,
        nr_item            TYPE p LENGTH 15 DECIMALS 2,
      END OF ty_knwc197,





      BEGIN OF ty_integracaonotafiscalajustel,
        knw0190 TYPE ty_knw0190,
        knw0200 TYPE ty_knw0200,
        knwc197 TYPE ty_knwc197,
      END OF ty_integracaonotafiscalajustel,


      BEGIN OF ty_knw0460,
        dt_inicial       TYPE string,
        dt_importacao    TYPE string,
        cod_empresa      TYPE string,
        cod_filial       TYPE string,
        id_usuario_imp   TYPE string,
        chave_registro   TYPE string,
        cod_grupoempresa TYPE string,
        dt_movimento     TYPE string,
        cd_obs           TYPE string,
        ds_obs           TYPE string,
        id               TYPE string,
      END OF ty_knw0460,


      BEGIN OF ty_knwc195,
        dm_emitente        TYPE string,
        dm_entrada_saida   TYPE string,
        serie_subserie     TYPE string,
        nr_documento       TYPE string,
        dt_emissao_doc     TYPE string,
        cod_empresa        TYPE string,
        cod_filial         TYPE string,
        id_usuario_imp     TYPE string,
        chave_registro     TYPE string,
        cd_0460            TYPE string,
        ds_complementar    TYPE string,
        cd_pessoa_rem_dest TYPE string,
        nr_item            TYPE p LENGTH 15 DECIMALS 2,
      END OF ty_knwc195,


      BEGIN OF ty_notafiscalobservacaolancame,
        knwc195                        TYPE ty_knwc195,
        knw0460                        TYPE ty_knw0460,
        integracaonotafiscalajustelist TYPE STANDARD TABLE OF ty_integracaonotafiscalajustel WITH NON-UNIQUE DEFAULT KEY,
      END OF ty_notafiscalobservacaolancame,


      BEGIN OF ty_objetos,
        knwc100                     TYPE ty_knwc100,
        knw0150destinatario         TYPE ty_knw0150,
        knw0150emitente             TYPE ty_knw0150,
        knw0150transportador        TYPE ty_knw0150,
        "notaFiscalInfComplementarList TYPE STANDARD TABLE OF ty_notaFiscalInfComplementarLi WITH NON-UNIQUE DEFAULT KEY,
        knwc111                     TYPE ty_knwc111,
        knwc120                     TYPE ty_knwc120,
        knwc140                     TYPE ty_knwc140,
        knwc141                     TYPE STANDARD TABLE OF ty_knwc141 WITH NON-UNIQUE DEFAULT KEY,
        notafiscalitemlist          TYPE STANDARD TABLE OF ty_notafiscalitemlist WITH NON-UNIQUE DEFAULT KEY,
        obslancamentofiscallist     TYPE STANDARD TABLE OF ty_notafiscalobservacaolancame WITH NON-UNIQUE DEFAULT KEY,
        knwd700                     TYPE ty_knwd700,
        integracaoconhecimentotrans TYPE ty_integracaoconhecimentotrans,
        dm_ressarcimento            TYPE string,
      END OF ty_objetos,


      BEGIN OF ty_main,
        docnum  TYPE string,
        objetos TYPE STANDARD TABLE OF ty_objetos WITH NON-UNIQUE DEFAULT KEY,
      END OF ty_main,

      ty_t_main TYPE ty_main,
      BEGIN OF ty_docs,
        docunm TYPE i_br_nfdocument-br_notafiscal,
      END OF ty_docs,
      BEGIN OF ty_bkpf,
        companycode               TYPE i_journalentry-companycode,
        fiscalyear                TYPE i_journalentry-fiscalyear,
        accountingdocument        TYPE i_journalentry-accountingdocument,
        originalreferencedocument TYPE i_journalentry-originalreferencedocument,
      END OF ty_bkpf,
      BEGIN OF ty_bseg,
        companycode                TYPE i_glaccountlineitemrawdata-companycode,
        fiscalyear                 TYPE i_glaccountlineitemrawdata-fiscalyear,
        accountingdocument         TYPE i_glaccountlineitemrawdata-accountingdocument,
        accountingdocumentitem     TYPE i_glaccountlineitemrawdata-accountingdocumentitem,
        ledgergllineitem           TYPE i_glaccountlineitemrawdata-ledgergllineitem,
        financialaccounttype       TYPE i_glaccountlineitemrawdata-financialaccounttype,
        controllingdebitcreditcode TYPE i_glaccountlineitemrawdata-controllingdebitcreditcode,
        netduedate                 TYPE i_glaccountlineitemrawdata-netduedate,
        invoicereference           TYPE i_glaccountlineitemrawdata-invoicereference,
      END OF ty_bseg,
      BEGIN OF ty_withtax,
        companycode                 TYPE i_withholdingtaxitem-companycode,
        fiscalyear                  TYPE i_withholdingtaxitem-fiscalyear,
        accountingdocument          TYPE i_withholdingtaxitem-accountingdocument,
        accountingdocumentitem      TYPE i_withholdingtaxitem-accountingdocumentitem,
        withholdingtaxtype          TYPE i_withholdingtaxitem-withholdingtaxtype,
        withholdingtaxcode          TYPE i_withholdingtaxitem-withholdingtaxcode,
        whldgtaxbaseamtincocodecrcy TYPE i_withholdingtaxitem-whldgtaxbaseamtincocodecrcy,
        whldgtaxamtincocodecrcy     TYPE i_withholdingtaxitem-whldgtaxamtincocodecrcy,
        withholdingtaxpercent       TYPE i_withholdingtaxitem-withholdingtaxpercent,
        clearingaccountingdocument  TYPE i_withholdingtaxitem-clearingaccountingdocument,
        clearingdate                TYPE i_withholdingtaxitem-clearingdate,
      END OF ty_withtax,

      tty_docs   TYPE STANDARD TABLE OF ty_docs,
      tty_branch TYPE STANDARD TABLE OF i_br_businessplace-branch,
      BEGIN OF ty_sel,
        company  TYPE i_br_businessplace-companycode,
        branch   TYPE i_br_businessplace-branch,
        creation TYPE RANGE OF i_br_nfdocument-creationdate,
        posting  TYPE RANGE OF i_br_nfdocument-br_nfpostingdate,
        nftype   TYPE RANGE OF i_br_nfdocument-br_nftype,
        document TYPE RANGE OF i_br_nfdocument-br_notafiscal,
        docdate  TYPE RANGE OF i_br_nfdocument-br_nfissuedate,
        pstdate  TYPE RANGE OF i_br_nfdocument-br_nfpostingdate,
        dsaient  TYPE RANGE OF i_br_nfdocument-br_nfarrivalordeparturedate,
        changed  TYPE RANGE OF i_br_nfdocument-lastchangedate,
      END OF ty_sel,
      BEGIN OF ty_nfitem,
        nf                   TYPE i_br_nfitem,
        product              TYPE i_product-product,
        producttype          TYPE i_product-producttype,
        baseunit             TYPE i_product-baseunit,
        plant                TYPE c LENGTH 4,
        iscoproduct          TYPE c LENGTH 1,
        referenceproducttype TYPE i_producttype-referenceproducttype,
        unitofmeasureisocode TYPE i_unitofmeasure-unitofmeasureisocode,
        unitofmeasure_e      TYPE i_unitofmeasure-unitofmeasure_e,
        unitofmeasurename    TYPE i_unitofmeasuretext-unitofmeasurename,
        glaccountname        TYPE i_glaccounttextincompanycode-glaccountname,
        chartofaccounts      TYPE i_glaccount-chartofaccounts,
      END OF ty_nfitem,
      BEGIN OF ty_ibge,
        countrycode       TYPE c LENGTH 3,
        br_bcbcountrycode TYPE c LENGTH 5,
      END OF ty_ibge,
      BEGIN OF ty_tax_type,
        br_taxtype                     TYPE c LENGTH 4,
        br_taxgroup                    TYPE c LENGTH 4,
        br_icmspartilhasubdivisioncode TYPE c LENGTH 3,
      END OF ty_tax_type,
      BEGIN OF ty_meta,
        id   TYPE string,
        uri  TYPE string,
        type TYPE string,
      END OF ty_meta,
      BEGIN OF ty_u,
        uri TYPE string,
      END OF ty_u,
      BEGIN OF ty_to,
        __deferred TYPE ty_u,
      END OF ty_to,

      BEGIN OF ty_add_imp,
        br_notafiscal                 TYPE string,
        br_notafiscalitem             TYPE string,
        br_nfimportdocument           TYPE string,
        br_nfaddition                 TYPE string,
        br_nfitemsequencenumber       TYPE string,
        br_nfforeignmanufacturer      TYPE string,
        br_nfadditionitemdiscountamt  TYPE p LENGTH 16 DECIMALS 2,
        br_nfdrawbackconcession       TYPE string,
        br_nfimportdrawbackconcession TYPE string,
        salesdocumentcurrency         TYPE string,
        to_br_nfdoc                   TYPE ty_to,
        to_br_nfitem                  TYPE ty_to,
      END OF ty_add_imp,

      BEGIN OF ty_res,
        __metadata TYPE ty_meta.
        INCLUDE TYPE ty_add_imp.
    TYPES:END OF ty_res,

    BEGIN OF ty_results_imp,
      results TYPE STANDARD TABLE OF ty_res WITH NON-UNIQUE DEFAULT KEY,
    END OF ty_results_imp,
    BEGIN OF ty_json_imp,
      d TYPE ty_results_imp,
    END OF ty_json_imp,

    BEGIN OF ty_docs_act,
      doc TYPE i_br_nfdocument,
      act TYPE i_br_nfeactive,
    END OF ty_docs_act.


  PRIVATE SECTION.
    TYPES: BEGIN OF ty_nfs,
             nota          TYPE string,
             serie         TYPE string,
             cnpj          TYPE string,
             br_notafiscal TYPE i_br_nfdocument-br_notafiscal,
           END OF ty_nfs.

    CONSTANTS: gc_icms         TYPE c LENGTH 10 VALUE 'ICMS',
               gc_icms_st      TYPE c LENGTH 10 VALUE 'ST',
               gc_ipi          TYPE c LENGTH 10 VALUE 'IPI',
               gc_pis          TYPE c LENGTH 10 VALUE 'PIS',
               gc_pis_imp      TYPE c LENGTH 10 VALUE 'PIS_IMP',
               gc_cofins       TYPE c LENGTH 10 VALUE 'COFI',
               gc_cofins_imp   TYPE c LENGTH 10 VALUE 'COFINS_IMP',
               gc_issqn        TYPE c LENGTH 10 VALUE 'ISSQN',
               gc_icms_difal   TYPE c LENGTH 10 VALUE 'ICMS-DIFAL',
               gc_icms_fcp     TYPE c LENGTH 10 VALUE 'ICMS-FCP',
               gc_icms_fcp_st  TYPE c LENGTH 10 VALUE 'ICMS-FCPST',
               gc_icms_fcp_rt  TYPE c LENGTH 10 VALUE 'ICMS-FCPRT',
               gc_zona_franca  TYPE c LENGTH 10 VALUE 'ZONAFRANCA',
               gc_icms_origem  TYPE c LENGTH 10 VALUE 'ICMS-ORIG',
               gc_icms_destino TYPE c LENGTH 10 VALUE 'ICMS-DEST',
               gc_icms_snac    TYPE c LENGTH 10 VALUE 'ICMS-SNAC',
               gc_irf          TYPE c LENGTH 10 VALUE 'IRF',
               gc_csll         TYPE c LENGTH 10 VALUE 'CSLL',
               gc_ir           TYPE c LENGTH 10 VALUE 'IR',
               gc_ii           TYPE c LENGTH 10 VALUE 'II',
               gc_inss         TYPE c LENGTH 10 VALUE 'INSS'.

    CLASS-DATA: t_nfdocs           TYPE TABLE OF ty_docs_act,
                t_customers        TYPE TABLE OF i_customer,
                t_vendors          TYPE TABLE OF i_supplier,
                t_nfitem           TYPE TABLE OF ty_nfitem,
                t_nftax            TYPE TABLE OF i_br_nftax,
                t_nftax_itm        TYPE TABLE OF i_br_nftax,
                t_texts            TYPE TABLE OF i_br_nftexts,
                "lt_refmes TYPE TABLE OF I_BR_NFREFERENCEMESSAGE,
                t_imp_di           TYPE TABLE OF i_br_nfimportdocument,
                t_exp_di           TYPE TABLE OF i_br_nfexportdocument,
                t_branch           TYPE TABLE OF /pyxs/sov_nf_branch,
                "lt_ftx    TYPE TABLE OF YY1_GLAccount,
                "lt_imp_adi TYPE TABLE OF I_BR_NFADDITIONIMPORTDOC,
                "lt_pharma TYPE TABLE OF I_BR_NFPHARMACEUTICAL.
                t_active           TYPE TABLE OF i_br_nfeactive,
                t_active_ref       TYPE TABLE OF i_br_nfeactive,
                t_bkpf             TYPE TABLE OF ty_bkpf,
                t_bseg             TYPE TABLE OF ty_bseg,
                t_withtax          TYPE TABLE OF ty_withtax,
                t_region           TYPE TABLE OF i_regiontext,
                t_country          TYPE TABLE OF i_countrytext,
                t_partner          TYPE TABLE OF i_br_nfpartner,
                t_units            TYPE TABLE OF i_unitofmeasuretext,
                sel                TYPE ty_sel,
                data               TYPE d,
                hora               TYPE t,
                gv_faedt           TYPE d,
                gv_cod_serv        TYPE c LENGTH 16,
                gv_vlr_base_prev   TYPE i_br_nftax-br_nfitembaseamount,
                gv_vlr_prev        TYPE i_br_nftax-br_nfitemtaxamount,
                gv_aliq_retencao   TYPE i_br_nftax-br_nfitemtaxamount,
                gv_item            TYPE i,
                gv_cnpj            TYPE i_br_nfdocument-br_businessplacecnpj,
                gv_proc            TYPE string,
                t_out              TYPE TABLE OF ty_main,
                t_out_e            TYPE TABLE OF ty_main,
                t_out_srv          TYPE TABLE OF lcl_process_srv=>ty_main,
                t_nfs              TYPE TABLE OF ty_nfs,
                t_ibge             TYPE TABLE OF ty_ibge,
                t_tax_type         TYPE TABLE OF ty_tax_type,
                t_ret_imp          TYPE ty_json_imp,
                t_add_imp          TYPE TABLE OF ty_add_imp,
                s_branch_sov       TYPE /pyxs/sov_branch,
                gv_icmscontributor TYPE c,
                gv_branch_cnpj     TYPE string,
                gs_comapany_code   TYPE i_companycode.

    CLASS-METHODS: read_nf_db,

      new_out,
      nfse_out,
      get_ibge_state
        IMPORTING
          p_bland             TYPE clike
        RETURNING
          VALUE(p_cod_estado) TYPE /pyxs/sov_nf_branch-uf,
      normalize
        IMPORTING
                  p_str             TYPE clike
        RETURNING VALUE(normalized) TYPE string,
      send_integration,
      get_ibge_country
        IMPORTING
                  p_country   TYPE clike
        RETURNING VALUE(ibge) TYPE string,
      popu.

ENDCLASS.

CLASS lcl_process IMPLEMENTATION.

  METHOD build_cnpj.

    CONSTANTS: lc_alpha TYPE string VALUE 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.

    TYPES: tt_weights TYPE STANDARD TABLE OF i WITH DEFAULT KEY.

    DATA: lv_clean    TYPE string,
          lv_char     TYPE c LENGTH 1,
          lv_valor    TYPE i,
          lv_pos      TYPE i,
          lv_find     TYPE i,
          digsum      TYPE p,
          digrest     TYPE p,
          first       TYPE i,
          second      TYPE i,
          lt_weights1 TYPE tt_weights,
          lt_weights2 TYPE tt_weights.

    " 1. Limpar separadores
    DATA(lv_input) = input.
    REPLACE ALL OCCURRENCES OF '.' IN lv_input WITH ''.
    REPLACE ALL OCCURRENCES OF '/' IN lv_input WITH ''.
    REPLACE ALL OCCURRENCES OF '-' IN lv_input WITH ''.
    CONDENSE lv_input NO-GAPS.

    " Validar: deve ter exatamente 12 caracteres
    IF strlen( lv_input ) <> 12.
      output = ''.
      RETURN.
    ENDIF.

    lv_clean = lv_input.

    " Pesos do 1º DV: 5,4,3,2,9,8,7,6,5,4,3,2
    APPEND 5 TO lt_weights1.
    APPEND 4 TO lt_weights1.
    APPEND 3 TO lt_weights1.
    APPEND 2 TO lt_weights1.
    APPEND 9 TO lt_weights1.
    APPEND 8 TO lt_weights1.
    APPEND 7 TO lt_weights1.
    APPEND 6 TO lt_weights1.
    APPEND 5 TO lt_weights1.
    APPEND 4 TO lt_weights1.
    APPEND 3 TO lt_weights1.
    APPEND 2 TO lt_weights1.

    " Pesos do 2º DV: 6,5,4,3,2,9,8,7,6,5,4,3,2
    APPEND 6 TO lt_weights2.
    APPEND 5 TO lt_weights2.
    APPEND 4 TO lt_weights2.
    APPEND 3 TO lt_weights2.
    APPEND 2 TO lt_weights2.
    APPEND 9 TO lt_weights2.
    APPEND 8 TO lt_weights2.
    APPEND 7 TO lt_weights2.
    APPEND 6 TO lt_weights2.
    APPEND 5 TO lt_weights2.
    APPEND 4 TO lt_weights2.
    APPEND 3 TO lt_weights2.
    APPEND 2 TO lt_weights2.

    " -------------------------------------------------------
    " Conversão char -> valor para DV conforme tabela SERPRO
    " Fórmula: ASCII do char - 48
    "   '0'(48)-48=0 ... '9'(57)-48=9
    "   'A'(65)-48=17 ... 'Z'(90)-48=42
    " -------------------------------------------------------

    " --- Cálculo do 1º DV ---
    digsum = 0.
    LOOP AT lt_weights1 INTO DATA(lv_w1).
      lv_pos  = sy-tabix - 1.
      lv_char = lv_clean+lv_pos(1).

      FIND lv_char IN lc_alpha MATCH OFFSET lv_find.
      IF sy-subrc = 0.
        lv_valor = lv_find + 17.   " A=17, B=18 ... Z=42  (ASCII 65 - 48 = 17)
      ELSE.
        lv_valor = lv_char - '0'.  " '0'=0 ... '9'=9
      ENDIF.

      digsum = digsum + ( lv_valor * lv_w1 ).
    ENDLOOP.

    digrest = digsum MOD 11.
    IF digrest <= 1.
      first = 0.
    ELSE.
      first = 11 - digrest.
    ENDIF.

    " --- Cálculo do 2º DV (12 chars + 1º DV na posição 13) ---
    digsum = 0.
    LOOP AT lt_weights2 INTO DATA(lv_w2).
      lv_pos = sy-tabix - 1.

      IF lv_pos < 12.
        lv_char = lv_clean+lv_pos(1).
        FIND lv_char IN lc_alpha MATCH OFFSET lv_find.
        IF sy-subrc = 0.
          lv_valor = lv_find + 17.  " Letra
        ELSE.
          lv_valor = lv_char - '0'. " Dígito
        ENDIF.
      ELSE.
        lv_valor = first.            " Posição 13 = 1º DV já calculado
      ENDIF.

      digsum = digsum + ( lv_valor * lv_w2 ).
    ENDLOOP.

    digrest = digsum MOD 11.
    IF digrest <= 1.
      second = 0.
    ELSE.
      second = 11 - digrest.
    ENDIF.

    " --- Montar saída formatada XX.XXX.XXX/XXXX-DV1DV2 ---
    output = lv_clean+0(2)
          && lv_clean+2(3)
          && lv_clean+5(3)
          && lv_clean+8(4)
          && first
          && second.

  ENDMETHOD.

  METHOD send_integration.
    DATA: lo_ret     TYPE REF TO data,
          lv_sucesso TYPE abap_boolean.

    LOOP AT t_out INTO DATA(ls_doc).

      DATA(lv_docnum) = ls_doc-docnum.
      CLEAR ls_doc-docnum.

      DATA(json_out) = /ui2/cl_json=>serialize(
        EXPORTING
          data             = ls_doc
          compress         = abap_true
*        name             =
           pretty_name      = /ui2/cl_json=>pretty_mode-none
*        type_descr       =
           assoc_arrays     = abap_false
*        ts_as_iso8601    =
*        expand_includes  =
           assoc_arrays_opt = abap_false
*        numc_as_string   =
*        name_mappings    =
*        conversion_exits =
*        format_output    =
*        hex_as_base64    =
*      RECEIVING
*        r_json           =
      ).

      json_out = /pyxs/sov_json_conversion=>convert_sovos( json_out ).
      DATA: lr_cscn TYPE if_com_scenario_factory=>ty_query-cscn_id_range.

      " find CA by scenario
      lr_cscn = VALUE #( ( sign = 'I' option = 'EQ' low = '/PYXS/SOVOS' ) ).
      DATA(lo_factory) = cl_com_arrangement_factory=>create_instance( ).
      lo_factory->query_ca(
        EXPORTING
          is_query           = VALUE #( cscn_id_range = lr_cscn )
        IMPORTING
          et_com_arrangement = DATA(lt_ca) ).

      IF lt_ca IS INITIAL.
        APPEND INITIAL LINE TO /pyxs/bp_sovos_fiscaldocuments=>lt_log ASSIGNING FIELD-SYMBOL(<log>).
        GET TIME STAMP FIELD DATA(time).
        READ TABLE t_nfs INTO DATA(ls_not) INDEX 1.
        <log>-timedate = time.
        "READ TABLE t_nfdocs INTO DATA(ls_nf) WITH KEY doc-br_nfenumber = ls_doc-objetos[ 1 ]-knwc100-nr_documento.
        <log>-br_notafiscal = lv_docnum. "ls_nf-doc-br_notafiscal .
        <log>-response = 'Cenário de comunicação não encontrado'.
        <log>-returncode = '999'.
        <log>-returnreason = 'Erro de configuração'.

        EXIT.
      ENDIF.

      " take the first one
      READ TABLE lt_ca INTO DATA(lo_ca) INDEX 1.

      " get destination based to Communication Arrangement
      TRY.
          DATA(lo_dest) = cl_http_destination_provider=>create_by_comm_arrangement(
              comm_scenario  = '/PYXS/SOVOS'
              service_id     = '/PYXS/TCO_SOVOS_REST'
              comm_system_id = lo_ca->get_comm_system_id( ) ).

          DATA(lo_http_client) = cl_web_http_client_manager=>create_by_http_destination( lo_dest ).

          " execute the request
          DATA(lo_request) = lo_http_client->get_http_request( ).
          lo_request->set_text(
            EXPORTING
              i_text   = json_out
*            i_offset = 0
*            i_length = -1
*          RECEIVING
*            r_value  =
          ).

          lo_request->set_uri_path(
            EXPORTING
              i_uri_path = '/api/knw/v2/notaFiscalProprias'
*              multivalue = 0
*            RECEIVING
*              r_value    =
          ).

          lo_request->set_header_field( i_name = 'X-Cnpj'  i_value = gv_branch_cnpj ).

          DATA(lo_response) = lo_http_client->execute( if_web_http_client=>post ).
          DATA(lv_ret) = lo_response->get_status( ).
          CLEAR lo_ret.
          IF lv_ret-code = '200'.
            DATA(lv_msg) = lo_response->get_text( ).
            IF lv_msg IS INITIAL.
              gv_proc = 'Successfully processed'(002).
            ELSE.
              gv_proc = lv_msg.
              /ui2/cl_json=>deserialize(
                 EXPORTING
                   json             = gv_proc
*                  jsonx            =
*                  jsonx_cp         = `UTF-8`
*                  pretty_name      =
*                  assoc_arrays     =
*                  assoc_arrays_opt =
*                  name_mappings    =
*                  conversion_exits =
*                  hex_as_base64    =
*                  gen_optimize     =
                CHANGING
                  data             = lo_ret
              ).
              lv_sucesso = lo_ret->('SUCESSO')->*.
              IF lv_sucesso = abap_true.
                gv_proc = 'Successfully processed'(002).
              ELSE.
                lv_ret-code = 400.
              ENDIF.
            ENDIF.
          ELSE.
            gv_proc = lo_response->get_text( ). "|{ 'Error'(003) }: { lv_ret-reason }|.
          ENDIF.

        CATCH cx_web_message_error.


        CATCH cx_http_dest_provider_error.
          IF sy-subrc <> 0.
          ENDIF.

        CATCH cx_web_http_client_error.
          IF sy-subrc <> 0.
          ENDIF.
      ENDTRY.
      GET TIME STAMP FIELD time.
      READ TABLE t_nfs INTO ls_not INDEX 1.

      IF lo_ret IS INITIAL.
        APPEND INITIAL LINE TO /pyxs/bp_sovos_fiscaldocuments=>lt_log ASSIGNING <log>.
        <log>-timedate = time.
        "READ TABLE t_nfdocs INTO ls_nf WITH KEY doc-br_nfenumber = ls_doc-objetos[ 1 ]-knwc100-nr_documento.
        <log>-br_notafiscal =  lv_docnum. "ls_nf-doc-br_notafiscal .
        <log>-response = |Erro no serviço: { gv_proc }|.
        <log>-returncode = lv_ret-code.
        <log>-returnreason = lv_ret-reason.

      ELSE.

        LOOP AT lo_ret->('MENSAGENS')->* ASSIGNING FIELD-SYMBOL(<lv_msg>).
          APPEND INITIAL LINE TO /pyxs/bp_sovos_fiscaldocuments=>lt_log ASSIGNING <log>.
          <log>-id = sy-tabix.
          <log>-timedate = time.
          "READ TABLE t_nfdocs INTO ls_nf WITH KEY doc-br_nfenumber = ls_doc-objetos[ 1 ]-knwc100-nr_documento.
          <log>-br_notafiscal  = lv_docnum. "ls_nf-doc-br_notafiscal .
          <log>-response = <lv_msg>->*.
          <log>-returncode = lv_ret-code.
          <log>-returnreason = lv_ret-reason.
        ENDLOOP.
      ENDIF.


    ENDLOOP.

    LOOP AT t_out_e INTO ls_doc.
*      CLEAR lt_doc[].
*      APPEND ls_doc TO lt_doc.

      lv_docnum = ls_doc-docnum.
      CLEAR ls_doc-docnum.

      json_out = /ui2/cl_json=>serialize(
        EXPORTING
          data             = ls_doc
          compress         = abap_true
*        name             =
           pretty_name      = /ui2/cl_json=>pretty_mode-none
*        type_descr       =
           assoc_arrays     = abap_false
*        ts_as_iso8601    =
*        expand_includes  =
           assoc_arrays_opt = abap_false
*        numc_as_string   =
*        name_mappings    =
*        conversion_exits =
*        format_output    =
*        hex_as_base64    =
*      RECEIVING
*        r_json           =
      ).

      json_out = /pyxs/sov_json_conversion=>convert_sovos( json_out ).

      " find CA by scenario
      lr_cscn = VALUE #( ( sign = 'I' option = 'EQ' low = '/PYXS/SOVOS' ) ).
      lo_factory = cl_com_arrangement_factory=>create_instance( ).
      lo_factory->query_ca(
        EXPORTING
          is_query           = VALUE #( cscn_id_range = lr_cscn )
        IMPORTING
          et_com_arrangement = lt_ca ).

      IF lt_ca IS INITIAL.
        APPEND INITIAL LINE TO /pyxs/bp_sovos_fiscaldocuments=>lt_log ASSIGNING <log>.
        GET TIME STAMP FIELD DATA(time).
        "READ TABLE t_nfdocs INTO ls_nf WITH KEY doc-br_nfenumber = ls_doc-objetos[ 1 ]-knwc100-nr_documento.
        <log>-br_notafiscal = lv_docnum. "ls_nf-doc-br_notafiscal .
        <log>-timedate = time.
        <log>-response = 'Cenário de comunicação não encontrado'.
        <log>-returncode = '999'.
        <log>-returnreason = 'Erro de configuração'.

        EXIT.
      ENDIF.

      " take the first one
      READ TABLE lt_ca INTO lo_ca INDEX 1.

      " get destination based to Communication Arrangement
      TRY.
          lo_dest = cl_http_destination_provider=>create_by_comm_arrangement(
              comm_scenario  = '/PYXS/SOVOS'
              service_id     = '/PYXS/TCO_SOVOS_REST'
              comm_system_id = lo_ca->get_comm_system_id( ) ).

          lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_dest ).

          " execute the request
          lo_request = lo_http_client->get_http_request( ).
          lo_request->set_text(
            EXPORTING
              i_text   = json_out
*            i_offset = 0
*            i_length = -1
*          RECEIVING
*            r_value  =
          ).

          lo_request->set_uri_path(
            EXPORTING
              i_uri_path = '/api/knw/v2/notaFiscalTerceiros'
*              multivalue = 0
*            RECEIVING
*              r_value    =
          ).


          lo_request->set_header_field( i_name = 'X-Cnpj'  i_value = gv_branch_cnpj ).

          lo_response = lo_http_client->execute( if_web_http_client=>post ).
          lv_ret = lo_response->get_status( ).
          CLEAR lo_ret.
          IF lv_ret-code = '200'.
            lv_msg = lo_response->get_text( ).
            IF lv_msg IS INITIAL.
              gv_proc = 'Successfully processed'(002).
            ELSE.
              gv_proc = lv_msg.
              /ui2/cl_json=>deserialize(
                 EXPORTING
                   json             = gv_proc
*                  jsonx            =
*                  jsonx_cp         = `UTF-8`
*                  pretty_name      =
*                  assoc_arrays     =
*                  assoc_arrays_opt =
*                  name_mappings    =
*                  conversion_exits =
*                  hex_as_base64    =
*                  gen_optimize     =
                CHANGING
                  data             = lo_ret
              ).
              lv_sucesso = lo_ret->('SUCESSO')->*.
              IF lv_sucesso = abap_true.
                gv_proc = 'Successfully processed'(002).
              ELSE.
                lv_ret-code = 400.
              ENDIF.
            ENDIF.
          ELSE.
            gv_proc = lo_response->get_text( ). "|{ 'Error'(003) }: { lv_ret-reason }|.
          ENDIF.

        CATCH cx_web_message_error.


        CATCH cx_http_dest_provider_error.
          IF sy-subrc <> 0.
          ENDIF.

        CATCH cx_web_http_client_error.
          IF sy-subrc <> 0.
          ENDIF.
      ENDTRY.
      GET TIME STAMP FIELD time.
      READ TABLE t_nfs INTO ls_not INDEX 1.

      IF lo_ret IS INITIAL.
        APPEND INITIAL LINE TO /pyxs/bp_sovos_fiscaldocuments=>lt_log ASSIGNING <log>.
        <log>-timedate = time.
        "READ TABLE t_nfdocs INTO ls_nf WITH KEY doc-br_nfenumber = ls_doc-objetos[ 1 ]-knwc100-nr_documento.
        <log>-br_notafiscal = lv_docnum. "ls_nf-doc-br_notafiscal .
        <log>-response = |Erro no serviço: { gv_proc }|.
        <log>-returncode = lv_ret-code.
        <log>-returnreason = lv_ret-reason.

      ELSE.

        LOOP AT lo_ret->('MENSAGENS')->* ASSIGNING <lv_msg>.
          APPEND INITIAL LINE TO /pyxs/bp_sovos_fiscaldocuments=>lt_log ASSIGNING <log>.
          <log>-id = sy-tabix.
          <log>-timedate = time.
          "READ TABLE t_nfdocs INTO ls_nf WITH KEY doc-br_nfenumber = ls_doc-objetos[ 1 ]-knwc100-nr_documento.
          <log>-br_notafiscal = lv_docnum. "ls_nf-doc-br_notafiscal .
          <log>-response = <lv_msg>->*.
          <log>-returncode = lv_ret-code.
          <log>-returnreason = lv_ret-reason.
        ENDLOOP.
      ENDIF.


    ENDLOOP.
    LOOP AT t_out_srv INTO DATA(ls_doc_srv).
*      CLEAR lt_doc[].
*      APPEND ls_doc TO lt_doc.
      lv_docnum = ls_doc_srv-docnum.
      CLEAR ls_doc_srv-docnum.

      json_out = /ui2/cl_json=>serialize(
        EXPORTING
          data             = ls_doc_srv
          compress         = abap_true
*        name             =
           pretty_name      = /ui2/cl_json=>pretty_mode-none
*        type_descr       =
           assoc_arrays     = abap_false
*        ts_as_iso8601    =
*        expand_includes  =
           assoc_arrays_opt = abap_false
*        numc_as_string   =
*        name_mappings    =
*        conversion_exits =
*        format_output    =
*        hex_as_base64    =
*      RECEIVING
*        r_json           =
      ).

      json_out = /pyxs/sov_json_conversion=>convert_sovos( json_out ).

      " find CA by scenario
      lr_cscn = VALUE #( ( sign = 'I' option = 'EQ' low = '/PYXS/SOVOS' ) ).
      lo_factory = cl_com_arrangement_factory=>create_instance( ).
      lo_factory->query_ca(
        EXPORTING
          is_query           = VALUE #( cscn_id_range = lr_cscn )
        IMPORTING
          et_com_arrangement = lt_ca ).

      IF lt_ca IS INITIAL.
        APPEND INITIAL LINE TO /pyxs/bp_sovos_fiscaldocuments=>lt_log ASSIGNING <log>.
        GET TIME STAMP FIELD time.

        <log>-timedate = time.
        "READ TABLE t_nfdocs INTO ls_nf WITH KEY doc-br_nfenumber = ls_doc-objetos[ 1 ]-knwc100-nr_documento.
        <log>-br_notafiscal = lv_docnum. "ls_nf-doc-br_notafiscal .
        <log>-response = 'Cenário de comunicação não encontrado'.
        <log>-returncode = '999'.
        <log>-returnreason = 'Erro de configuração'.

        EXIT.
      ENDIF.

      " take the first one
      READ TABLE lt_ca INTO lo_ca INDEX 1.

      " get destination based to Communication Arrangement
      TRY.
          lo_dest = cl_http_destination_provider=>create_by_comm_arrangement(
              comm_scenario  = '/PYXS/SOVOS'
              service_id     = '/PYXS/TCO_SOVOS_REST'
              comm_system_id = lo_ca->get_comm_system_id( ) ).

          lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_dest ).

          " execute the request
          lo_request = lo_http_client->get_http_request( ).
          lo_request->set_text(
            EXPORTING
              i_text   = json_out
*            i_offset = 0
*            i_length = -1
*          RECEIVING
*            r_value  =
          ).

          lo_request->set_uri_path(
            EXPORTING
              i_uri_path = '/api/knw/v2/notaServico'
*              multivalue = 0
*            RECEIVING
*              r_value    =
          ).


          lo_request->set_header_field( i_name = 'X-Cnpj'  i_value = gv_branch_cnpj ).

          lo_response = lo_http_client->execute( if_web_http_client=>post ).
          lv_ret = lo_response->get_status( ).
          CLEAR lo_ret.
          IF lv_ret-code = '200'.
            lv_msg = lo_response->get_text( ).
            IF lv_msg IS INITIAL.
              gv_proc = 'Successfully processed'(002).
            ELSE.
              gv_proc = lv_msg.
              /ui2/cl_json=>deserialize(
                 EXPORTING
                   json             = gv_proc
*                  jsonx            =
*                  jsonx_cp         = `UTF-8`
*                  pretty_name      =
*                  assoc_arrays     =
*                  assoc_arrays_opt =
*                  name_mappings    =
*                  conversion_exits =
*                  hex_as_base64    =
*                  gen_optimize     =
                CHANGING
                  data             = lo_ret
              ).
              lv_sucesso = lo_ret->('SUCESSO')->*.
              IF lv_sucesso = abap_true.
                gv_proc = 'Successfully processed'(002).
              ELSE.
                lv_ret-code = 400.
              ENDIF.
            ENDIF.
          ELSE.
            gv_proc = lo_response->get_text( ). "|{ 'Error'(003) }: { lv_ret-reason }|.
          ENDIF.

        CATCH cx_web_message_error.


        CATCH cx_http_dest_provider_error.
          IF sy-subrc <> 0.
          ENDIF.

        CATCH cx_web_http_client_error.
          IF sy-subrc <> 0.
          ENDIF.
      ENDTRY.
      GET TIME STAMP FIELD time.

      IF lo_ret IS INITIAL.
        APPEND INITIAL LINE TO /pyxs/bp_sovos_fiscaldocuments=>lt_log ASSIGNING <log>.
        <log>-timedate = time.
        "READ TABLE t_nfdocs INTO ls_nf WITH KEY doc-br_nfenumber = ls_doc-objetos[ 1 ]-knwc100-nr_documento.
        <log>-br_notafiscal = lv_docnum. "ls_nf-doc-br_notafiscal .
        <log>-response = |Erro no serviço: { gv_proc }|.
        <log>-returncode = lv_ret-code.
        <log>-returnreason = lv_ret-reason.

      ELSE.

        LOOP AT lo_ret->('MENSAGENS')->* ASSIGNING <lv_msg>.
          APPEND INITIAL LINE TO /pyxs/bp_sovos_fiscaldocuments=>lt_log ASSIGNING <log>.
          <log>-id = sy-tabix.
          <log>-timedate = time.
          "READ TABLE t_nfdocs INTO ls_nf WITH KEY doc-br_nfenumber = ls_doc-objetos[ 1 ]-knwc100-nr_documento.
          <log>-br_notafiscal = lv_docnum. "ls_nf-doc-br_notafiscal .
          <log>-response = <lv_msg>->*.
          <log>-returncode = lv_ret-code.
          <log>-returnreason = lv_ret-reason.
        ENDLOOP.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD get_ibge_state.
    CONSTANTS:
      gc_ro_uf   TYPE c LENGTH 3 VALUE 'RO',
      gc_ro1_uf  TYPE c LENGTH 3 VALUE 'RO1',
      gc_ro_ibge TYPE c LENGTH 3 VALUE '11',
      gc_ac_uf   TYPE c LENGTH 3 VALUE 'AC',
      gc_ac1_uf  TYPE c LENGTH 3 VALUE 'AC1',
      gc_ac_ibge TYPE c LENGTH 3 VALUE '12',
      gc_am_uf   TYPE c LENGTH 3 VALUE 'AM',
      gc_am1_uf  TYPE c LENGTH 3 VALUE 'AM1',
      gc_zf_uf   TYPE c LENGTH 3 VALUE 'ZF',
      gc_am_ibge TYPE c LENGTH 3 VALUE '13',
      gc_rr_uf   TYPE c LENGTH 3 VALUE 'RR',
      gc_rr1_uf  TYPE c LENGTH 3 VALUE 'RR',
      gc_rr_ibge TYPE c LENGTH 3 VALUE '14',
      gc_pa_uf   TYPE c LENGTH 3 VALUE 'PA',
      gc_pa_ibge TYPE c LENGTH 3 VALUE '15',
      gc_ap_uf   TYPE c LENGTH 3 VALUE 'AP',
      gc_ap1_uf  TYPE c LENGTH 3 VALUE 'AP1',
      gc_ap_ibge TYPE c LENGTH 3 VALUE '16',
      gc_to_uf   TYPE c LENGTH 3 VALUE 'TO',
      gc_to_ibge TYPE c LENGTH 3 VALUE '17',
      gc_ma_uf   TYPE c LENGTH 3 VALUE 'MA',
      gc_ma_ibge TYPE c LENGTH 3 VALUE '21',
      gc_pi_uf   TYPE c LENGTH 3 VALUE 'PI',
      gc_pi_ibge TYPE c LENGTH 3 VALUE '22',
      gc_ce_uf   TYPE c LENGTH 3 VALUE 'CE',
      gc_ce_ibge TYPE c LENGTH 3 VALUE '23',
      gc_rn_uf   TYPE c LENGTH 3 VALUE 'RN',
      gc_rn_ibge TYPE c LENGTH 3 VALUE '24',
      gc_pb_uf   TYPE c LENGTH 3 VALUE 'PB',
      gc_pb_ibge TYPE c LENGTH 3 VALUE '25',
      gc_pe_uf   TYPE c LENGTH 3 VALUE 'PE',
      gc_pe_ibge TYPE c LENGTH 3 VALUE '26',
      gc_al_uf   TYPE c LENGTH 3 VALUE 'AL',
      gc_al_ibge TYPE c LENGTH 3 VALUE '27',
      gc_se_uf   TYPE c LENGTH 3 VALUE 'SE',
      gc_se_ibge TYPE c LENGTH 3 VALUE '28',
      gc_ba_uf   TYPE c LENGTH 3 VALUE 'BA',
      gc_ba_ibge TYPE c LENGTH 3 VALUE '29',
      gc_mg_uf   TYPE c LENGTH 3 VALUE 'MG',
      gc_mg_ibge TYPE c LENGTH 3 VALUE '31',
      gc_es_uf   TYPE c LENGTH 3 VALUE 'ES',
      gc_es_ibge TYPE c LENGTH 3 VALUE '32',
      gc_rj_uf   TYPE c LENGTH 3 VALUE 'RJ',
      gc_rj_ibge TYPE c LENGTH 3 VALUE '33',
      gc_sp_uf   TYPE c LENGTH 3 VALUE 'SP',
      gc_sp_ibge TYPE c LENGTH 3 VALUE '35',
      gc_pr_uf   TYPE c LENGTH 3 VALUE 'PR',
      gc_pr_ibge TYPE c LENGTH 3 VALUE '41',
      gc_sc_uf   TYPE c LENGTH 3 VALUE 'SC',
      gc_sc_ibge TYPE c LENGTH 3 VALUE '42',
      gc_rs_uf   TYPE c LENGTH 3 VALUE 'RS',
      gc_rs_ibge TYPE c LENGTH 3 VALUE '43',
      gc_ms_uf   TYPE c LENGTH 3 VALUE 'MS',
      gc_ms_ibge TYPE c LENGTH 3 VALUE '50',
      gc_mt_uf   TYPE c LENGTH 3 VALUE 'MT',
      gc_mt_ibge TYPE c LENGTH 3 VALUE '51',
      gc_go_uf   TYPE c LENGTH 3 VALUE 'GO',
      gc_go_ibge TYPE c LENGTH 3 VALUE '52',
      gc_df_uf   TYPE c LENGTH 3 VALUE 'DF',
      gc_df_ibge TYPE c LENGTH 3 VALUE '53',
      gc_xe_uf   TYPE c LENGTH 3 VALUE 'XE', "Comércio ext.-UE
      gc_xx_uf   TYPE c LENGTH 3 VALUE 'XX', "Comércio exterior
      gc_ex_ibge TYPE c LENGTH 3 VALUE '99'.

    CASE p_bland.
        "Região Norte
      WHEN gc_ro_uf OR gc_ro1_uf.
        p_cod_estado = gc_ro_ibge.
      WHEN gc_ac_uf OR gc_ac1_uf.
        p_cod_estado = gc_ac_ibge.
      WHEN gc_am_uf OR gc_am1_uf OR gc_zf_uf.
        p_cod_estado = gc_am_ibge.
      WHEN gc_rr_uf OR gc_rr1_uf.
        p_cod_estado = gc_rr_ibge.
      WHEN gc_pa_uf.
        p_cod_estado = gc_pa_ibge.
      WHEN gc_ap_uf OR gc_ap1_uf.
        p_cod_estado = gc_ap_ibge.
      WHEN gc_to_uf.
        p_cod_estado = gc_to_ibge.

        "Região Nordeste
      WHEN gc_ma_uf.
        p_cod_estado = gc_ma_ibge.
      WHEN gc_pi_uf.
        p_cod_estado = gc_pi_ibge.
      WHEN gc_ce_uf.
        p_cod_estado = gc_ce_ibge.
      WHEN gc_rn_uf.
        p_cod_estado = gc_rn_ibge.
      WHEN gc_pb_uf.
        p_cod_estado = gc_pb_ibge.
      WHEN gc_pe_uf.
        p_cod_estado = gc_pe_ibge.
      WHEN gc_al_uf.
        p_cod_estado = gc_al_ibge.
      WHEN gc_se_uf.
        p_cod_estado = gc_se_ibge.
      WHEN gc_ba_uf.
        p_cod_estado = gc_ba_ibge.

        "Região Sudeste
      WHEN gc_mg_uf.
        p_cod_estado = gc_mg_ibge.
      WHEN gc_es_uf.
        p_cod_estado = gc_es_ibge.
      WHEN gc_rj_uf.
        p_cod_estado = gc_rj_ibge.
      WHEN gc_sp_uf.
        p_cod_estado = gc_sp_ibge.

        "Região Sul
      WHEN gc_pr_uf.
        p_cod_estado = gc_pr_ibge.
      WHEN gc_sc_uf.
        p_cod_estado = gc_sc_ibge.
      WHEN gc_rs_uf.
        p_cod_estado = gc_rs_ibge.

        "Região Centro-Oeste
      WHEN gc_ms_uf.
        p_cod_estado = gc_ms_ibge.
      WHEN gc_mt_uf.
        p_cod_estado = gc_mt_ibge.
      WHEN gc_go_uf.
        p_cod_estado = gc_go_ibge.
      WHEN gc_df_uf.
        p_cod_estado = gc_df_ibge.

        "Comércio Exterior
      WHEN gc_xe_uf OR gc_xx_uf.
        p_cod_estado = gc_ex_ibge.

      WHEN OTHERS.
        CLEAR: p_cod_estado.
    ENDCASE.
  ENDMETHOD.

  METHOD get_ibge_country.

    IF t_ibge IS INITIAL.
      t_ibge = VALUE #(
        ( countrycode = 'AD' br_bcbcountrycode = '00370'  )
        ( countrycode = 'AE' br_bcbcountrycode = '02445'  )
        ( countrycode = 'AF' br_bcbcountrycode = '00132'  )
        ( countrycode = 'AG' br_bcbcountrycode = '00434'  )
        ( countrycode = 'AI' br_bcbcountrycode = '00418'  )
        ( countrycode = 'AL' br_bcbcountrycode = '00175'  )
        ( countrycode = 'AM' br_bcbcountrycode = '00647'  )
        ( countrycode = 'AO' br_bcbcountrycode = '00400'  )
        ( countrycode = 'AQ' br_bcbcountrycode = '00420'  )
        ( countrycode = 'AR' br_bcbcountrycode = '00639'  )
        ( countrycode = 'AS' br_bcbcountrycode = '06912'  )
        ( countrycode = 'AT' br_bcbcountrycode = '00728'  )
        ( countrycode = 'AU' br_bcbcountrycode = '00698'  )
        ( countrycode = 'AW' br_bcbcountrycode = '00655'  )
        ( countrycode = 'AX' br_bcbcountrycode = '00153'  )
        ( countrycode = 'AZ' br_bcbcountrycode = '00736'  )
        ( countrycode = 'BA' br_bcbcountrycode = '00981'  )
        ( countrycode = 'BB' br_bcbcountrycode = '00833'  )
        ( countrycode = 'BD' br_bcbcountrycode = '00817'  )
        ( countrycode = 'BE' br_bcbcountrycode = '00876'  )
        ( countrycode = 'BF' br_bcbcountrycode = '00310'  )
        ( countrycode = 'BG' br_bcbcountrycode = '01112'  )
        ( countrycode = 'BH' br_bcbcountrycode = '00809'  )
        ( countrycode = 'BI' br_bcbcountrycode = '01155'  )
        ( countrycode = 'BJ' br_bcbcountrycode = '02291'  )
        ( countrycode = 'BL' br_bcbcountrycode = '06939'  )
        ( countrycode = 'BM' br_bcbcountrycode = '00906'  )
        ( countrycode = 'BN' br_bcbcountrycode = '01082'  )
        ( countrycode = 'BO' br_bcbcountrycode = '00973'  )
        ( countrycode = 'BQ' br_bcbcountrycode = '00990'  )
        ( countrycode = 'BR' br_bcbcountrycode = '01058'  )
        ( countrycode = 'BS' br_bcbcountrycode = '00779'  )
        ( countrycode = 'BT' br_bcbcountrycode = '01198'  )
        ( countrycode = 'BV' br_bcbcountrycode = '01023'  )
        ( countrycode = 'BW' br_bcbcountrycode = '01015'  )
        ( countrycode = 'BY' br_bcbcountrycode = '00850'  )
        ( countrycode = 'BZ' br_bcbcountrycode = '00884'  )
        ( countrycode = 'CA' br_bcbcountrycode = '01490'  )
        ( countrycode = 'CC' br_bcbcountrycode = '01651'  )
        ( countrycode = 'CD' br_bcbcountrycode = '08885'  )
        ( countrycode = 'CF' br_bcbcountrycode = '06408'  )
        ( countrycode = 'CG' br_bcbcountrycode = '01775'  )
        ( countrycode = 'CH' br_bcbcountrycode = '07676'  )
        ( countrycode = 'CI' br_bcbcountrycode = '01937'  )
        ( countrycode = 'CK' br_bcbcountrycode = '01830'  )
        ( countrycode = 'CL' br_bcbcountrycode = '01589'  )
        ( countrycode = 'CM' br_bcbcountrycode = '01457'  )
        ( countrycode = 'CN' br_bcbcountrycode = '01600'  )
        ( countrycode = 'CO' br_bcbcountrycode = '01694'  )
        ( countrycode = 'CR' br_bcbcountrycode = '01961'  )
        ( countrycode = 'CU' br_bcbcountrycode = '01996'  )
        ( countrycode = 'CV' br_bcbcountrycode = '01279'  )
        ( countrycode = 'CW' br_bcbcountrycode = '02003'  )
        ( countrycode = 'CY' br_bcbcountrycode = '01635'  )
        ( countrycode = 'CZ' br_bcbcountrycode = '07919'  )
        ( countrycode = 'DE' br_bcbcountrycode = '00230'  )
        ( countrycode = 'DJ' br_bcbcountrycode = '07838'  )
        ( countrycode = 'DK' br_bcbcountrycode = '02321'  )
        ( countrycode = 'DM' br_bcbcountrycode = '02356'  )
        ( countrycode = 'DO' br_bcbcountrycode = '06475'  )
        ( countrycode = 'DZ' br_bcbcountrycode = '00590'  )
        ( countrycode = 'EC' br_bcbcountrycode = '02399'  )
        ( countrycode = 'EE' br_bcbcountrycode = '02518'  )
        ( countrycode = 'EG' br_bcbcountrycode = '02402'  )
        ( countrycode = 'EH' br_bcbcountrycode = '06858'  )
        ( countrycode = 'ER' br_bcbcountrycode = '02437'  )
        ( countrycode = 'ES' br_bcbcountrycode = '02453'  )
        ( countrycode = 'ET' br_bcbcountrycode = '02534'  )
        ( countrycode = 'FI' br_bcbcountrycode = '02712'  )
        ( countrycode = 'FJ' br_bcbcountrycode = '08702'  )
        ( countrycode = 'FK' br_bcbcountrycode = '02550'  )
        ( countrycode = 'FM' br_bcbcountrycode = '04995'  )
        ( countrycode = 'FO' br_bcbcountrycode = '02593'  )
        ( countrycode = 'FR' br_bcbcountrycode = '02755'  )
        ( countrycode = 'GA' br_bcbcountrycode = '02810'  )
        ( countrycode = 'GB' br_bcbcountrycode = '06289'  )
        ( countrycode = 'GD' br_bcbcountrycode = '02976'  )
        ( countrycode = 'GE' br_bcbcountrycode = '02917'  )
        ( countrycode = 'GF' br_bcbcountrycode = '03255'  )
        ( countrycode = 'GG' br_bcbcountrycode = '03212'  )
        ( countrycode = 'GH' br_bcbcountrycode = '02895'  )
        ( countrycode = 'GI' br_bcbcountrycode = '02933'  )
        ( countrycode = 'GL' br_bcbcountrycode = '03050'  )
        ( countrycode = 'GM' br_bcbcountrycode = '02852'  )
        ( countrycode = 'GN' br_bcbcountrycode = '03298'  )
        ( countrycode = 'GP' br_bcbcountrycode = '03093'  )
        ( countrycode = 'GQ' br_bcbcountrycode = '03310'  )
        ( countrycode = 'GR' br_bcbcountrycode = '03018'  )
        ( countrycode = 'GS' br_bcbcountrycode = '02925'  )
        ( countrycode = 'GT' br_bcbcountrycode = '03174'  )
        ( countrycode = 'GU' br_bcbcountrycode = '03131'  )
        ( countrycode = 'GW' br_bcbcountrycode = '03344'  )
        ( countrycode = 'GY' br_bcbcountrycode = '03379'  )
        ( countrycode = 'HK' br_bcbcountrycode = '03514'  )
        ( countrycode = 'HM' br_bcbcountrycode = '03433'  )
        ( countrycode = 'HN' br_bcbcountrycode = '03450'  )
        ( countrycode = 'HR' br_bcbcountrycode = '01953'  )
        ( countrycode = 'HT' br_bcbcountrycode = '03417'  )
        ( countrycode = 'HU' br_bcbcountrycode = '03557'  )
        ( countrycode = 'ID' br_bcbcountrycode = '03654'  )
        ( countrycode = 'IE' br_bcbcountrycode = '03751'  )
        ( countrycode = 'IL' br_bcbcountrycode = '03832'  )
        ( countrycode = 'IM' br_bcbcountrycode = '03595'  )
        ( countrycode = 'IN' br_bcbcountrycode = '03611'  )
        ( countrycode = 'IO' br_bcbcountrycode = '07820'  )
        ( countrycode = 'IQ' br_bcbcountrycode = '03697'  )
        ( countrycode = 'IR' br_bcbcountrycode = '03727'  )
        ( countrycode = 'IS' br_bcbcountrycode = '03794'  )
        ( countrycode = 'IT' br_bcbcountrycode = '03867'  )
        ( countrycode = 'JE' br_bcbcountrycode = '03930'  )
        ( countrycode = 'JM' br_bcbcountrycode = '03913'  )
        ( countrycode = 'JO' br_bcbcountrycode = '04030'  )
        ( countrycode = 'JP' br_bcbcountrycode = '03999'  )
        ( countrycode = 'KE' br_bcbcountrycode = '06238'  )
        ( countrycode = 'KG' br_bcbcountrycode = '06254'  )
        ( countrycode = 'KH' br_bcbcountrycode = '01414'  )
        ( countrycode = 'KI' br_bcbcountrycode = '04111'  )
        ( countrycode = 'KM' br_bcbcountrycode = '01732'  )
        ( countrycode = 'KN' br_bcbcountrycode = '06955'  )
        ( countrycode = 'KP' br_bcbcountrycode = '01872'  )
        ( countrycode = 'KR' br_bcbcountrycode = '01902'  )
        ( countrycode = 'KW' br_bcbcountrycode = '01988'  )
        ( countrycode = 'KY' br_bcbcountrycode = '01376'  )
        ( countrycode = 'KZ' br_bcbcountrycode = '01538'  )
        ( countrycode = 'LA' br_bcbcountrycode = '04200'  )
        ( countrycode = 'LC' br_bcbcountrycode = '07153'  )
        ( countrycode = 'LI' br_bcbcountrycode = '04405'  )
        ( countrycode = 'LK' br_bcbcountrycode = '07501'  )
        ( countrycode = 'LR' br_bcbcountrycode = '04340'  )
        ( countrycode = 'LS' br_bcbcountrycode = '04260'  )
        ( countrycode = 'LT' br_bcbcountrycode = '04421'  )
        ( countrycode = 'LU' br_bcbcountrycode = '04456'  )
        ( countrycode = 'LV' br_bcbcountrycode = '04278'  )
        ( countrycode = 'LY' br_bcbcountrycode = '04383'  )
        ( countrycode = 'MA' br_bcbcountrycode = '04740'  )
        ( countrycode = 'MC' br_bcbcountrycode = '04952'  )
        ( countrycode = 'MD' br_bcbcountrycode = '04944'  )
        ( countrycode = 'ME' br_bcbcountrycode = '04985'  )
        ( countrycode = 'MF' br_bcbcountrycode = '06980'  )
        ( countrycode = 'MG' br_bcbcountrycode = '04502'  )
        ( countrycode = 'MH' br_bcbcountrycode = '04766'  )
        ( countrycode = 'MK' br_bcbcountrycode = '04499'  )
        ( countrycode = 'ML' br_bcbcountrycode = '04642'  )
        ( countrycode = 'MM' br_bcbcountrycode = '00930'  )
        ( countrycode = 'MN' br_bcbcountrycode = '04979'  )
        ( countrycode = 'MO' br_bcbcountrycode = '04472'  )
        ( countrycode = 'MP' br_bcbcountrycode = '04723'  )
        ( countrycode = 'MQ' br_bcbcountrycode = '04774'  )
        ( countrycode = 'MR' br_bcbcountrycode = '04880'  )
        ( countrycode = 'MS' br_bcbcountrycode = '05010'  )
        ( countrycode = 'MT' br_bcbcountrycode = '04677'  )
        ( countrycode = 'MV' br_bcbcountrycode = '04618'  )
        ( countrycode = 'MW' br_bcbcountrycode = '04588'  )
        ( countrycode = 'MX' br_bcbcountrycode = '04936'  )
        ( countrycode = 'MY' br_bcbcountrycode = '04553'  )
        ( countrycode = 'MZ' br_bcbcountrycode = '05053'  )
        ( countrycode = 'NC' br_bcbcountrycode = '05428'  )
        ( countrycode = 'NE' br_bcbcountrycode = '05258'  )
        ( countrycode = 'NF' br_bcbcountrycode = '05355'  )
        ( countrycode = 'NG' br_bcbcountrycode = '05282'  )
        ( countrycode = 'NI' br_bcbcountrycode = '05215'  )
        ( countrycode = 'NL' br_bcbcountrycode = '05738'  )
        ( countrycode = 'NO' br_bcbcountrycode = '05380'  )
        ( countrycode = 'NP' br_bcbcountrycode = '05177'  )
        ( countrycode = 'NR' br_bcbcountrycode = '05088'  )
        ( countrycode = 'NU' br_bcbcountrycode = '05312'  )
        ( countrycode = 'NZ' br_bcbcountrycode = '05487'  )
        ( countrycode = 'OM' br_bcbcountrycode = '05568'  )
        ( countrycode = 'PA' br_bcbcountrycode = '05800'  )
        ( countrycode = 'PE' br_bcbcountrycode = '05894'  )
        ( countrycode = 'PF' br_bcbcountrycode = '05991'  )
        ( countrycode = 'PG' br_bcbcountrycode = '05452'  )
        ( countrycode = 'PH' br_bcbcountrycode = '02674'  )
        ( countrycode = 'PK' br_bcbcountrycode = '05762'  )
        ( countrycode = 'PL' br_bcbcountrycode = '06033'  )
        ( countrycode = 'PM' br_bcbcountrycode = '07005'  )
        ( countrycode = 'PN' br_bcbcountrycode = '05932'  )
        ( countrycode = 'PR' br_bcbcountrycode = '06114'  )
        ( countrycode = 'PT' br_bcbcountrycode = '06076'  )
        ( countrycode = 'PW' br_bcbcountrycode = '05754'  )
        ( countrycode = 'PY' br_bcbcountrycode = '05860'  )
        ( countrycode = 'QA' br_bcbcountrycode = '01546'  )
        ( countrycode = 'RE' br_bcbcountrycode = '06602'  )
        ( countrycode = 'RO' br_bcbcountrycode = '06700'  )
        ( countrycode = 'RS' br_bcbcountrycode = '07370'  )
        ( countrycode = 'RU' br_bcbcountrycode = '06769'  )
        ( countrycode = 'RW' br_bcbcountrycode = '06750'  )
        ( countrycode = 'SA' br_bcbcountrycode = '00531'  )
        ( countrycode = 'SB' br_bcbcountrycode = '06777'  )
        ( countrycode = 'SC' br_bcbcountrycode = '07315'  )
        ( countrycode = 'SD' br_bcbcountrycode = '07595'  )
        ( countrycode = 'SE' br_bcbcountrycode = '07641'  )
        ( countrycode = 'SG' br_bcbcountrycode = '07412'  )
        ( countrycode = 'SH' br_bcbcountrycode = '07102'  )
        ( countrycode = 'SI' br_bcbcountrycode = '02461'  )
        ( countrycode = 'SJ' br_bcbcountrycode = '07552'  )
        ( countrycode = 'SK' br_bcbcountrycode = '02470'  )
        ( countrycode = 'SL' br_bcbcountrycode = '07358'  )
        ( countrycode = 'SM' br_bcbcountrycode = '06971'  )
        ( countrycode = 'SN' br_bcbcountrycode = '07285'  )
        ( countrycode = 'SO' br_bcbcountrycode = '07480'  )
        ( countrycode = 'SR' br_bcbcountrycode = '07706'  )
        ( countrycode = 'ST' br_bcbcountrycode = '07200'  )
        ( countrycode = 'SV' br_bcbcountrycode = '06874'  )
        ( countrycode = 'SX' br_bcbcountrycode = '06998'  )
        ( countrycode = 'SY' br_bcbcountrycode = '07447'  )
        ( countrycode = 'SZ' br_bcbcountrycode = '07544'  )
        ( countrycode = 'TC' br_bcbcountrycode = '08230'  )
        ( countrycode = 'TD' br_bcbcountrycode = '07889'  )
        ( countrycode = 'TF' br_bcbcountrycode = '07811'  )
        ( countrycode = 'TG' br_bcbcountrycode = '08001'  )
        ( countrycode = 'TH' br_bcbcountrycode = '07765'  )
        ( countrycode = 'TJ' br_bcbcountrycode = '07722'  )
        ( countrycode = 'TK' br_bcbcountrycode = '08052'  )
        ( countrycode = 'TL' br_bcbcountrycode = '07951'  )
        ( countrycode = 'TM' br_bcbcountrycode = '08249'  )
        ( countrycode = 'TN' br_bcbcountrycode = '08206'  )
        ( countrycode = 'TO' br_bcbcountrycode = '08109'  )
        ( countrycode = 'TR' br_bcbcountrycode = '08273'  )
        ( countrycode = 'TT' br_bcbcountrycode = '08150'  )
        ( countrycode = 'TV' br_bcbcountrycode = '08281'  )
        ( countrycode = 'TW' br_bcbcountrycode = '01619'  )
        ( countrycode = 'TZ' br_bcbcountrycode = '07803'  )
        ( countrycode = 'UA' br_bcbcountrycode = '08311'  )
        ( countrycode = 'UG' br_bcbcountrycode = '08338'  )
        ( countrycode = 'UM' br_bcbcountrycode = '04855'  )
        ( countrycode = 'US' br_bcbcountrycode = '02496'  )
        ( countrycode = 'UY' br_bcbcountrycode = '08451'  )
        ( countrycode = 'UZ' br_bcbcountrycode = '08478'  )
        ( countrycode = 'VA' br_bcbcountrycode = '08486'  )
        ( countrycode = 'VC' br_bcbcountrycode = '07056'  )
        ( countrycode = 'VE' br_bcbcountrycode = '08508'  )
        ( countrycode = 'VG' br_bcbcountrycode = '08630'  )
        ( countrycode = 'VI' br_bcbcountrycode = '08664'  )
        ( countrycode = 'VN' br_bcbcountrycode = '08583'  )
        ( countrycode = 'VU' br_bcbcountrycode = '05517'  )
        ( countrycode = 'WF' br_bcbcountrycode = '08753'  )
        ( countrycode = 'WS' br_bcbcountrycode = '06904'  )
        ( countrycode = 'YE' br_bcbcountrycode = '03573'  )
        ( countrycode = 'YT' br_bcbcountrycode = '04898'  )
        ( countrycode = 'ZA' br_bcbcountrycode = '07560'  )
        ( countrycode = 'ZM' br_bcbcountrycode = '08907'  )
        ( countrycode = 'ZW' br_bcbcountrycode = '06653'  )
         ).
    ENDIF.
    READ TABLE t_ibge WITH KEY countrycode = p_country INTO DATA(ls_ibge).
    IF sy-subrc IS INITIAL.
      ibge = ls_ibge-br_bcbcountrycode.
    ENDIF.
  ENDMETHOD.
  METHOD new_out.
    DATA: lv_estorno TYPE c,
          "ls_out        TYPE /pyxs/cl_fiscal_documents=>ty_main,
          lv_docnum  TYPE i_br_nfdocument-br_notafiscal,
          "ls_retido     TYPE /pyxs/cl_fiscal_documents=>ty_impostosretidos,
          "ls_itm_out    TYPE /pyxs/cl_fiscal_documents=>ty_itens,
          "ls_importacao TYPE /pyxs/cl_fiscal_documents=>ty_importacoes,
          ls_objeto  TYPE ty_objetos,
          ls_main    TYPE ty_main,
          lv_es      TYPE abap_bool.
    DELETE t_nfdocs WHERE doc-br_nfdocumenttype = '5'.
    IF t_nfdocs[] IS INITIAL.
      gv_proc = 'Nenhum documento processado'.
    ENDIF.
    popu(  ).
    SORT t_nfdocs BY doc-br_nfdirection.
    LOOP AT t_nfdocs INTO DATA(p_nfdoc) WHERE doc-br_nfismunicipal <> 'X' AND doc-br_nfhasserviceitem <> 'X'.

      """"""""""""""""""""""""""""""""""""""""""""""""""""""""""
      " DE x PARA

      DATA(lv_sap_company_code) = p_nfdoc-doc-companycode.
      DATA(lv_sap_businessplace) = p_nfdoc-doc-businessplace.

      p_nfdoc-doc-companycode = s_branch_sov-sov_company.
      p_nfdoc-doc-businessplace = s_branch_sov-sov_branch.

      CLEAR: ls_objeto, ls_main.

      "--------------------------------------------------
      " C100 – Cabeçalho do documento
      "--------------------------------------------------
      CLEAR ls_objeto-knwc100.
      "ls_objeto-docnum = p_nfdoc-doc-br_notafiscal.

      ls_objeto-knwc100-dm_emitente        = COND #( WHEN p_nfdoc-doc-br_nfisincomingissdbycust = 'X'
                                                       OR p_nfdoc-doc-br_nfdirection = '2' OR p_nfdoc-doc-br_nfdirection = '4'
                                                          THEN '0' ELSE '1' ).
      ls_objeto-knwc100-dm_entrada_saida   = COND #( WHEN p_nfdoc-doc-br_nfdirection = '2' THEN 'S' ELSE 'E' ).
      ls_objeto-knwc100-serie_subserie     = p_nfdoc-doc-br_nfseries.
      ls_objeto-knwc100-nr_documento       = p_nfdoc-doc-br_nfenumber.

*      ls_objeto-knwc100-dt_emissao_doc     = |{ p_nfdoc-doc-br_nfissuedate(4) }-{ p_nfdoc-doc-br_nfissuedate+4(2) }-{ p_nfdoc-doc-br_nfissuedate+6 }T| &&
*      |{ p_nfdoc-doc-creationtime(2) }:{ p_nfdoc-doc-creationtime+2(2) }:{ p_nfdoc-doc-creationtime+4(2) }+03:00|.
*      ls_objeto-knwc100-dt_entrada         = |{ p_nfdoc-doc-br_nfpostingdate(4) }-{ p_nfdoc-doc-br_nfpostingdate+4(2) }-{ p_nfdoc-doc-br_nfpostingdate+6 }T| &&
*      |{ p_nfdoc-doc-creationtime(2) }:{ p_nfdoc-doc-creationtime+2(2) }:{ p_nfdoc-doc-creationtime+4(2) }+03:00|.
      ls_objeto-knwc100-dt_emissao_doc     = |{ p_nfdoc-doc-br_nfissuedate(4) }-{ p_nfdoc-doc-br_nfissuedate+4(2) }-{ p_nfdoc-doc-br_nfissuedate+6 }T00:00:00+03:00|.
      ls_objeto-knwc100-dt_entrada         = |{ p_nfdoc-doc-br_nfpostingdate(4) }-{ p_nfdoc-doc-br_nfpostingdate+4(2) }-{ p_nfdoc-doc-br_nfpostingdate+6 }T00:00:00+03:00|.

      ls_objeto-knwc100-cd_modelo_doc      = p_nfdoc-doc-br_nfmodel.
      ls_objeto-knwc100-nr_chave_eletr     = |{ p_nfdoc-act-region }{ p_nfdoc-act-br_nfeissueyear }{ p_nfdoc-act-br_nfeissuemonth }{ p_nfdoc-act-br_nfeaccesskeycnpjorcpf }| &&
      |{ p_nfdoc-act-br_nfemodel }{ p_nfdoc-act-br_nfeseries }{ p_nfdoc-act-br_nfenumber }{ p_nfdoc-act-br_nferandomnumber }{ p_nfdoc-act-br_nfecheckdigit }|.
      ls_objeto-knwc100-ds_natureza        = p_nfdoc-doc-br_nfoperationtypedesc.
      ls_objeto-knwc100-cod_empresa        = p_nfdoc-doc-companycode.
      ls_objeto-knwc100-cd_sit_documento        = COND #( WHEN p_nfdoc-doc-br_nfsituationcode IS NOT INITIAL
                                                           THEN p_nfdoc-doc-br_nfsituationcode
                                                           ELSE '00' ).
      ls_objeto-knwc100-cod_filial         = p_nfdoc-doc-businessplace.
      ls_objeto-knwc100-cd_pessoa_remet_dest         = p_nfdoc-doc-br_nfpartner.
      ls_objeto-knwc100-dm_modal_frete = p_nfdoc-doc-freightpayer.


      ls_objeto-knwc100-vl_total_mercad    = p_nfdoc-doc-br_nftotalamount.
      ls_objeto-knwc100-vl_tot_n_fiscal    = p_nfdoc-doc-br_nftotalamount.
      ls_objeto-knwc100-vl_desconto    = p_nfdoc-doc-br_nfdiscountamount.

      ls_objeto-knwc100-vl_bc_prev = '0.0'.
      ls_objeto-knwc100-vl_prev = '0.0'.
      ls_objeto-knwc100-dm_tipo_fatura = '2'.
      ls_objeto-knwc100-ds_uf_dest_emit = p_nfdoc-doc-br_nfpartnerregioncode.
      ls_objeto-knwc100-vl_serv_nt = '0.0'.
      ls_objeto-knwc100-vl_material_terc = '0.0'.
      ls_objeto-knwc100-vl_sub_empr = '0.0'.
      ls_objeto-knwc100-dm_finalidade = '1'.
      ls_objeto-knwc100-dm_destinatario = '1'.
      ls_objeto-knwc100-vl_servico1 = '0.0'.
      ls_objeto-knwc100-vl_abat_n_trib = '0.0'.


      "CASE p_nfdoc-doc-br_nfdirection.
      CASE ls_objeto-knwc100-dm_emitente.
        WHEN '1'. " entrada
          lv_es = 'X'.
*      "--------------------------------------------------
*      " Emitente – knw0150Emitente
*      "--------------------------------------------------
          CLEAR ls_objeto-knw0150emitente.

          "READ TABLE t_vendors INTO DATA(ls_vendor) WITH KEY supplier = p_nfdoc-doc-br_nfpartner.
          "DATA(ls_vendor) = VALUE #( t_vendors[ supplier = p_nfdoc-doc-br_nfpartner ] OPTIONAL ).

          ls_objeto-knw0150emitente-cod_empresa     = p_nfdoc-doc-companycode.
          ls_objeto-knw0150emitente-cod_filial      = p_nfdoc-doc-businessplace.
          ls_objeto-knw0150emitente-nm_razao_social = p_nfdoc-doc-br_nfpartnername1.
          ls_objeto-knw0150emitente-nr_cnpj_cpf     = COND #( WHEN p_nfdoc-doc-br_nfpartnercnpj IS NOT INITIAL THEN p_nfdoc-doc-br_nfpartnercnpj ELSE p_nfdoc-doc-br_nfpartnercpf ).
          ls_objeto-knw0150emitente-nr_inscr_est    = p_nfdoc-doc-br_nfpartnerstatetaxnumber. "ls_vendor-taxnumber3.
          ls_objeto-knw0150emitente-cd_municipio    = p_nfdoc-doc-br_nfpartnertaxjurisdiction+3. "ls_vendor-taxjurisdiction+3.
          ls_objeto-knw0150emitente-cd_pais         = get_ibge_country( p_nfdoc-doc-br_nfpartnercountrycode )."get_ibge_country( ls_vendor-country ).
          ls_objeto-knw0150emitente-cd_pessoa       = p_nfdoc-doc-br_nfpartner.
          ls_objeto-knw0150emitente-dt_inicial      = '1900-01-01T00:00:00+03:00'.
          ls_objeto-knw0150emitente-ds_endereco     = p_nfdoc-doc-br_nfpartnerstreetname. "ls_vendor-bpaddrstreetname.
          "ls_objeto-knw0150emitente-dm_contribuinte

          ls_objeto-knwc100-cod_mun_orig = p_nfdoc-doc-br_nfpartnertaxjurisdiction+3. "ls_vendor-taxjurisdiction+3.

*
*      "--------------------------------------------------
*      " Destinatário – knw0150Destinatario
*      "--------------------------------------------------

          "READ TABLE t_branch INTO DATA(ls_branch) WITH KEY cod_estab = s_branch_sov-branch cod_companhia = p_nfdoc-doc-companycode.
          DATA(ls_branch) = VALUE #( t_branch[ cod_estab = lv_sap_businessplace cod_companhia = lv_sap_company_code ] OPTIONAL ).

          CLEAR ls_objeto-knw0150destinatario.

          ls_objeto-knw0150destinatario-cod_empresa     = p_nfdoc-doc-companycode.
          ls_objeto-knw0150destinatario-cod_filial      = p_nfdoc-doc-businessplace.
          ls_objeto-knw0150destinatario-nm_razao_social = ls_branch-nome_fantasia.
          ls_objeto-knw0150destinatario-nr_cnpj_cpf     = p_nfdoc-doc-br_businessplacecnpj. "( |{ ls_branch-cnpj_raiz }{ ls_branch-cnpj_filial }| ).
          ls_objeto-knw0150destinatario-cd_municipio    = ls_branch-taxjurisdiction+3.
          ls_objeto-knw0150destinatario-cd_pais         = get_ibge_country( ls_branch-countrycode ).
          ls_objeto-knw0150destinatario-dt_inicial      = '1900-01-01T00:00:00+03:00'.
          ls_objeto-knw0150destinatario-cd_pessoa       = ls_branch-cod_estab.
          ls_objeto-knw0150destinatario-ds_endereco     = ls_branch-endereco.

          ls_objeto-knwc100-cod_mun_des = ls_branch-taxjurisdiction+3.


*          ls_objeto-knw0150destinatario-dm_regime_tributario = ls_branch-receiver_taxregime.


        WHEN '0'. " Saída

          CLEAR lv_es.

          "READ TABLE t_branch INTO ls_branch WITH KEY cod_estab = s_branch_sov-branch cod_companhia = p_nfdoc-doc-companycode.
          ls_branch = VALUE #( t_branch[ cod_estab = lv_sap_businessplace cod_companhia = lv_sap_company_code ] OPTIONAL ).

          CLEAR ls_objeto-knw0150destinatario.

          ls_objeto-knw0150emitente-cod_empresa = p_nfdoc-doc-companycode.
          ls_objeto-knw0150emitente-cod_filial  = p_nfdoc-doc-businessplace.
          ls_objeto-knw0150emitente-nm_razao_social = ls_branch-nome_fantasia.
          ls_objeto-knw0150emitente-nr_cnpj_cpf     = p_nfdoc-doc-br_businessplacecnpj. "build_cnpj( |{ ls_branch-cnpj_raiz }{ ls_branch-cnpj_filial }| ).
          ls_objeto-knw0150emitente-cd_municipio    = ls_branch-taxjurisdiction+3.
          ls_objeto-knw0150emitente-cd_pais         = get_ibge_country( ls_branch-countrycode ).
          ls_objeto-knw0150emitente-ds_endereco     = ls_branch-endereco.
          ls_objeto-knw0150emitente-dt_inicial      = '1900-01-01T00:00:00+03:00'.
          ls_objeto-knw0150emitente-cd_pessoa       = ls_branch-cod_estab.
          ls_objeto-knwc100-cod_mun_orig = ls_branch-taxjurisdiction+3.


          "DATA(ls_customer) = VALUE #( t_customers[ customer = p_nfdoc-doc-br_nfpartner ] OPTIONAL ).
          "READ TABLE t_customers INTO DATA(ls_customer) WITH KEY customer = p_nfdoc-doc-br_nfpartner.

          ls_objeto-knw0150destinatario-cod_empresa     = p_nfdoc-doc-companycode.
          ls_objeto-knw0150destinatario-cod_filial      = p_nfdoc-doc-businessplace.
          ls_objeto-knw0150destinatario-cd_pessoa       = p_nfdoc-doc-br_nfpartner.
          ls_objeto-knw0150destinatario-nm_razao_social = p_nfdoc-doc-br_nfpartnername1.
          ls_objeto-knw0150destinatario-nr_cnpj_cpf     = COND #( WHEN p_nfdoc-doc-br_nfpartnercnpj IS NOT INITIAL THEN p_nfdoc-doc-br_nfpartnercnpj ELSE p_nfdoc-doc-br_nfpartnercpf ).
          ls_objeto-knw0150destinatario-nr_inscr_est    = p_nfdoc-doc-br_nfpartnerstatetaxnumber."ls_customer-taxnumber3.
          ls_objeto-knw0150destinatario-ds_endereco     = p_nfdoc-doc-br_nfpartnerstreetname. "ls_customer-bpaddrstreetname.
          ls_objeto-knw0150destinatario-dt_inicial      = '1900-01-01T00:00:00+03:00'.

          ls_objeto-knw0150destinatario-cd_municipio    = p_nfdoc-doc-br_nfpartnertaxjurisdiction+3. "ls_customer-taxjurisdiction+3.
          ls_objeto-knw0150destinatario-cd_pais         = get_ibge_country( p_nfdoc-doc-br_nfpartnercountrycode ). "get_ibge_country( ls_customer-country ).
          ls_objeto-knwc100-cod_mun_des                 = p_nfdoc-doc-br_nfpartnertaxjurisdiction+3. "ls_customer-taxjurisdiction+3.
          IF ls_objeto-knw0150destinatario-cd_pais <> '01058'.
            ls_objeto-knw0150destinatario-cd_municipio = '9999999'.
            ls_objeto-knwc100-cod_mun_des = '9999999'.
            ls_objeto-knwc100-ds_uf_dest_emit = ls_branch-taxjurisdiction(2).
          ENDIF.


      ENDCASE.

*
*      "--------------------------------------------------
*      " Itens da nota – C170 + cadastros
*      "--------------------------------------------------
      CLEAR ls_objeto-notafiscalitemlist.

      LOOP AT t_nfitem INTO DATA(ls_nfitem)
           WHERE nf-br_notafiscal  = p_nfdoc-doc-br_notafiscal.

        APPEND INITIAL LINE TO ls_objeto-notafiscalitemlist ASSIGNING FIELD-SYMBOL(<item>).

        DO.
          ASSIGN COMPONENT sy-index OF STRUCTURE <item>-knwc170 TO FIELD-SYMBOL(<fs>).
          IF sy-subrc IS NOT INITIAL.
            EXIT.
          ENDIF.
          <fs> = '0.0'.
        ENDDO.
        "------------------------------
        " Totais da nota
        "------------------------------
        ls_objeto-knwc100-vl_frete += ls_nfitem-nf-br_nffreightamountwithtaxes.
        ls_objeto-knwc100-vl_seguro += ls_nfitem-nf-br_nfinsuranceamountwithtaxes.
        ls_objeto-knwc100-vl_outras_desp += ls_nfitem-nf-br_nfexpensesamountwithtaxes.
        ls_objeto-knwc100-vl_desconto    += abs( ls_nfitem-nf-br_nfdiscountamountwithtaxes ).

        "------------------------------
        " C170 – Item fiscal
        "------------------------------
        <item>-knwc170-nr_item          = ls_nfitem-nf-br_notafiscalitem.
        <item>-knwc170-nr_documento     = ls_objeto-knwc100-nr_documento.
        <item>-knwc170-serie_subserie     = ls_objeto-knwc100-serie_subserie .
        <item>-knwc170-dt_emissao_doc     = ls_objeto-knwc100-dt_emissao_doc .
        <item>-knwc170-cd_fiscal_oper   = ls_nfitem-nf-br_cfopcode.
        REPLACE ALL OCCURRENCES OF REGEX '[A-Z]' IN <item>-knwc170-cd_fiscal_oper WITH ''.

        <item>-knwc170-dm_entrada_saida   = ls_objeto-knwc100-dm_entrada_saida.

        <item>-knwc170-cod_empresa        = ls_objeto-knwc100-cod_empresa.
        <item>-knwc170-cod_filial         = ls_objeto-knwc100-cod_filial.
        <item>-knwc170-cd_pessoa_rem_dest = ls_objeto-knwc100-cd_pessoa_remet_dest.

        <item>-knwc170-cd_produto_serv  = ls_nfitem-nf-material.
        <item>-knwc170-unidade          = ls_nfitem-unitofmeasure_e. "ls_nfitem-nf-baseunit.
        <item>-knwc170-qtde             = ls_nfitem-nf-quantityinbaseunit.
        <item>-knwc170-vl_unitario      = ls_nfitem-nf-netpriceamount.


        <item>-knwc170-vl_total_item    = ls_nfitem-nf-netpriceamount * ls_nfitem-nf-quantityinbaseunit.
        <item>-knwc170-vl_desc_item     = ls_nfitem-nf-br_nfdiscountamountwithtaxes.
        <item>-knwc170-vl_contabil      = ls_nfitem-nf-br_nfvalueamountwithtaxes + ls_objeto-knwc100-vl_frete + ls_objeto-knwc100-vl_seguro + ls_objeto-knwc100-vl_outras_desp - ls_objeto-knwc100-vl_desconto + ls_nfitem-nf-br_nfexemptedicmswithtaxes.

        IF ls_nfitem-nf-br_materialorigin IS NOT INITIAL.
          <item>-knwc170-cd_sit_trib_icms   = ls_nfitem-nf-br_materialorigin && ls_nfitem-nf-br_icmstaxsituation.
        ELSE.
          IF ls_nfitem-nf-br_cfopcode(1) = '3' OR ls_nfitem-nf-br_cfopcode(1) = '7'.
            <item>-knwc170-cd_sit_trib_icms   = '1' && ls_nfitem-nf-br_icmstaxsituation.
          ELSE.
            <item>-knwc170-cd_sit_trib_icms   = '0' && ls_nfitem-nf-br_icmstaxsituation.
          ENDIF.
        ENDIF.
        "        IF strlen( <item>-knwc170-cd_sit_trib_icms ) > 2.
        "          DATA(lv_cst_len) = strlen( <item>-knwc170-cd_sit_trib_icms ) - 2.
        "          <item>-knwc170-cd_sit_trib_icms = <item>-knwc170-cd_sit_trib_icms+lv_cst_len(2).
        "        ENDIF.

        <item>-knwc170-cd_sit_trib_ipi = ls_nfitem-nf-br_ipitaxsituation.
        IF strlen( <item>-knwc170-cd_sit_trib_ipi ) > 2.
          DATA(lv_cst_len) = strlen( <item>-knwc170-cd_sit_trib_ipi ) - 2.
          <item>-knwc170-cd_sit_trib_ipi = <item>-knwc170-cd_sit_trib_ipi+lv_cst_len(2).
        ENDIF.

        <item>-knwc170-cd_sit_trib_pis    = ls_nfitem-nf-br_pistaxsituation. "'50'.
        IF strlen( <item>-knwc170-cd_sit_trib_pis ) > 2.
          lv_cst_len = strlen( <item>-knwc170-cd_sit_trib_pis ) - 2.
          <item>-knwc170-cd_sit_trib_pis = <item>-knwc170-cd_sit_trib_pis+lv_cst_len(2).
        ENDIF.

        <item>-knwc170-cd_sit_trib_cofins = ls_nfitem-nf-br_cofinstaxsituation. "'50'.
        IF strlen( <item>-knwc170-cd_sit_trib_cofins ) > 2.
          lv_cst_len = strlen( <item>-knwc170-cd_sit_trib_cofins ) - 2.
          <item>-knwc170-cd_sit_trib_cofins = <item>-knwc170-cd_sit_trib_cofins+lv_cst_len(2).
        ENDIF.

        <item>-knwc170-cd_enq_ipi         = ls_nfitem-nf-br_ipilegalclassification.

        LOOP AT t_nftax_itm INTO DATA(ls_tax_itm) WHERE br_notafiscal = ls_nfitem-nf-br_notafiscal
                                                AND br_notafiscalitem = ls_nfitem-nf-br_notafiscalitem.


          READ TABLE t_tax_type INTO DATA(ls_tax_type) WITH KEY br_taxtype = ls_tax_itm-br_taxtype.
          IF sy-subrc IS NOT INITIAL.
            CLEAR ls_tax_type.
          ENDIF.

          CHECK ls_tax_type-br_taxtype <> 'ISUP'. "Apenas para cálculo do custo, não compoe NF

          CASE ls_tax_itm-taxgroup.
            WHEN 'ICMS'.
              IF ls_tax_type-br_icmspartilhasubdivisioncode IS INITIAL.
                IF ls_tax_itm-br_nfitemtaxamount > 0.
                  IF ls_tax_itm-br_nfitembaseamount > 0.
                    <item>-knwc170-vl_ba_calc_icms  = ls_tax_itm-br_nfitembaseamount.
                    <item>-knwc170-vl_icms = ls_tax_itm-br_nfitemtaxamount.
                  ELSEIF ls_tax_itm-br_nfitemotherbaseamount > 0.
                    <item>-knwc170-vl_ba_calc_icms  = ls_tax_itm-br_nfitemotherbaseamount.
                    <item>-knwc170-vl_icms_outro = ls_tax_itm-br_nfitemtaxamount.
                  ELSE.
                    <item>-knwc170-vl_ba_calc_icms  = ls_tax_itm-br_nfitemexcludedbaseamount.
                    <item>-knwc170-vl_icms_isento = ls_tax_itm-br_nfitemtaxamount.
                  ENDIF.
                  <item>-knwc170-aliq_icms = ls_tax_itm-br_nfitemtaxrate.
*                <item>-knwc170-vl_icms_isento
*               <item>-knwc170-vl_icms_outro
*               <item>-knwc170-vl_icms_observ
                ENDIF.
              ELSEIF ls_tax_type-br_icmspartilhasubdivisioncode = '004'.
                "IF ls_tax_itm-br_nfitembaseamount > 0.
                "  <item>-knwc170-vl_bc_fcp_op  = ls_tax_itm-br_nfitembaseamount.
                "ELSEIF ls_tax_itm-br_nfitemotherbaseamount > 0.
                "  <item>-knwc170-vl_bc_fcp_op  = ls_tax_itm-br_nfitemotherbaseamount.
                "ELSE.
                "  <item>-knwc170-vl_bc_fcp_op  = ls_tax_itm-br_nfitemexcludedbaseamount.
                "ENDIF.
                "<item>-knwc170-aliq_fcp_op     = ls_tax_itm-br_nfitemtaxrate.
                "<item>-knwc170-vl_fcp_op     = ls_tax_itm-br_nfitemtaxamount.
                <item>-knwc170-vl_icms_fcp_dest = ls_tax_itm-br_nfitemtaxamount.
              ELSEIF ls_tax_type-br_icmspartilhasubdivisioncode = '001'.
                <item>-knwc170-vl_icms_dest    = ls_tax_itm-br_nfitemtaxamount.
                <item>-knwc170-aliq_icms_dest  = ls_tax_itm-br_nfitemtaxrate.
                IF ls_tax_itm-br_nfitembaseamount > 0.
                  <item>-knwc170-vl_bc_icms_uf_dest = ls_tax_itm-br_nfitembaseamount.
                ELSEIF ls_tax_itm-br_nfitemotherbaseamount > 0.
                  <item>-knwc170-vl_bc_icms_uf_dest = ls_tax_itm-br_nfitemotherbaseamount.
                ELSE.
                  <item>-knwc170-vl_bc_icms_uf_dest = ls_tax_itm-br_nfitemexcludedbaseamount.
                ENDIF.
              ELSEIF ls_tax_type-br_icmspartilhasubdivisioncode = '002'.
                <item>-knwc170-vl_icms_rem      = ls_tax_itm-br_nfitemtaxamount.
              ENDIF.
            WHEN  'ICST'.
              IF ls_tax_type-br_icmspartilhasubdivisioncode IS INITIAL.
                IF ls_tax_itm-br_nfitembaseamount > 0.
                  <item>-knwc170-vl_ba_calc_subs  = ls_tax_itm-br_nfitembaseamount.
                  <item>-knwc170-vl_icms_substit = ls_tax_itm-br_nfitemtaxamount.
                ELSEIF ls_tax_itm-br_nfitemotherbaseamount > 0.
                  <item>-knwc170-vl_ba_calc_subs  = ls_tax_itm-br_nfitemotherbaseamount.
                  <item>-knwc170-vl_icms_substit = ls_tax_itm-br_nfitemtaxamount.
                ELSE.
                  <item>-knwc170-vl_ba_calc_subs  = ls_tax_itm-br_nfitemexcludedbaseamount.
                  <item>-knwc170-vl_icms_substit = ls_tax_itm-br_nfitemtaxamount.
                ENDIF.
                <item>-knwc170-aliq_icms_sub = ls_tax_itm-br_nfitemtaxrate.
                <item>-knwc170-vl_contabil += ls_tax_itm-br_nfitemtaxamount.
              ELSEIF ls_tax_type-br_icmspartilhasubdivisioncode = '004'.
                <item>-knwc170-vl_fcp_st = ls_tax_itm-br_nfitemtaxamount.
                <item>-knwc170-aliq_fcp_st = ls_tax_itm-br_nfitemtaxrate.
                IF ls_tax_itm-br_nfitembaseamount > 0.
                  <item>-knwc170-vl_bc_fcp_st = ls_tax_itm-br_nfitembaseamount.
                ELSEIF ls_tax_itm-br_nfitemotherbaseamount > 0.
                  <item>-knwc170-vl_bc_fcp_st = ls_tax_itm-br_nfitemotherbaseamount.
                ELSE.
                  <item>-knwc170-vl_bc_fcp_st = ls_tax_itm-br_nfitemexcludedbaseamount.
                ENDIF.
              ENDIF.
            WHEN 'ICOP'.
              "c195 e c197

*              IF ls_branch-taxjurisdiction(2) = 'MG' OR ls_branch-taxjurisdiction(2) = 'SC'.
*
*                APPEND INITIAL LINE TO ls_objeto-obslancamentofiscallist ASSIGNING FIELD-SYMBOL(<obslancamentofiscallist>).
*                <obslancamentofiscallist>-knwc195-dm_entrada_saida = ls_objeto-knwc100-dm_entrada_saida.
*                <obslancamentofiscallist>-knwc195-serie_subserie = ls_objeto-knwc100-serie_subserie.
*                <obslancamentofiscallist>-knwc195-dm_emitente = ls_objeto-knwc100-dm_emitente.
*                <obslancamentofiscallist>-knwc195-nr_documento = ls_objeto-knwc100-nr_documento.
*                <obslancamentofiscallist>-knwc195-dt_emissao_doc = ls_objeto-knwc100-dt_emissao_doc.
*                <obslancamentofiscallist>-knwc195-cod_empresa = ls_objeto-knwc100-cod_empresa.
*                <obslancamentofiscallist>-knwc195-cod_filial = ls_objeto-knwc100-cod_filial.
*                <obslancamentofiscallist>-knwc195-id_usuario_imp = ''.
*                <obslancamentofiscallist>-knwc195-nr_item = ls_nfitem-nf-br_notafiscalitem.
*                <obslancamentofiscallist>-knwc195-cd_0460 = '000003'.
*                <obslancamentofiscallist>-knwc195-ds_complementar = 'DIFAL ST'.
*                <obslancamentofiscallist>-knwc195-cd_pessoa_rem_dest = ls_objeto-knwc100-cd_pessoa_remet_dest.
*
*                <obslancamentofiscallist>-knw0460-cod_empresa      = ls_objeto-knwc100-cod_empresa.
*                <obslancamentofiscallist>-knw0460-cod_filial       = ls_objeto-knwc100-cod_filial.
*                <obslancamentofiscallist>-knw0460-id               = <obslancamentofiscallist>-knwc195-cd_0460.
*                <obslancamentofiscallist>-knw0460-id_usuario_imp   = <obslancamentofiscallist>-knwc195-id_usuario_imp.
*                <obslancamentofiscallist>-knw0460-dt_inicial       = '1900-01-01T00:00:00+03:00'.
*                "<obslancamentofiscallist>-knw0460-dt_importacao    = ''.
*                <obslancamentofiscallist>-knw0460-cd_obs           = <obslancamentofiscallist>-knwc195-cd_0460.
*                <obslancamentofiscallist>-knw0460-ds_obs           = <obslancamentofiscallist>-knwc195-ds_complementar.
*                "<"obslancamentofiscallist>-knw0460-dt_movimento     = ''.
*                "<obslancamentofiscallist>-knw0460-cod_grupoempresa = ''.
*
*                APPEND INITIAL LINE TO <obslancamentofiscallist>-integracaonotafiscalajustelist ASSIGNING FIELD-SYMBOL(<integracaonotafiscal>).
*
*                <integracaonotafiscal>-knwc197-cod_empresa = ls_objeto-knwc100-cod_empresa.
*                <integracaonotafiscal>-knwc197-cod_filial = ls_objeto-knwc100-cod_filial.
*                <integracaonotafiscal>-knwc197-dm_entrada_saida = ls_objeto-knwc100-dm_entrada_saida.
*                <integracaonotafiscal>-knwc197-serie_subserie = ls_objeto-knwc100-serie_subserie.
*                <integracaonotafiscal>-knwc197-dm_emitente = ls_objeto-knwc100-dm_emitente.
*                <integracaonotafiscal>-knwc197-nr_documento = ls_objeto-knwc100-nr_documento.
*                <integracaonotafiscal>-knwc197-dt_emissao_doc = ls_objeto-knwc100-dt_emissao_doc.
*                <integracaonotafiscal>-knwc197-id_usuario_imp = <obslancamentofiscallist>-knwc195-id_usuario_imp.
*                <integracaonotafiscal>-knwc197-nr_item    =   ls_nfitem-nf-br_notafiscalitem.
*                <integracaonotafiscal>-knwc197-ds_complementar = <obslancamentofiscallist>-knwc195-ds_complementar.
*                <integracaonotafiscal>-knwc197-cd_pessoa_rem_dest = ls_objeto-knwc100-cd_pessoa_remet_dest.
*                <integracaonotafiscal>-knwc197-cd_ref_53 = ''.
*                <integracaonotafiscal>-knwc197-cd_prod_serv = ls_nfitem-nf-material.
*
*                IF ls_tax_itm-br_nfitemtaxamount > 0.
*                  <integracaonotafiscal>-knwc197-aliq_icms    = ls_tax_itm-br_nfitemtaxrate.
*                  IF ls_tax_itm-br_nfitembaseamount > 0.
*                    <integracaonotafiscal>-knwc197-vl_bc_icms   = ls_tax_itm-br_nfitembaseamount.
*                    <integracaonotafiscal>-knwc197-vl_icms    = ls_tax_itm-br_nfitemtaxamount.
*                  ELSEIF ls_tax_itm-br_nfitemotherbaseamount > 0.
*                    <integracaonotafiscal>-knwc197-vl_bc_icms   = ls_tax_itm-br_nfitemotherbaseamount.
*                    <integracaonotafiscal>-knwc197-vl_icms_outras    = ls_tax_itm-br_nfitemtaxamount.
*                  ENDIF.
*
*                ENDIF.
*
*                IF ls_branch-taxjurisdiction(2) = 'MG'.
*                  <integracaonotafiscal>-knwc197-cd_ref_53 = 'MG71110000'.
*                ELSEIF ls_branch-taxjurisdiction(2) = 'SC'.
*                  <integracaonotafiscal>-knwc197-cd_ref_53 = ''.
*                ENDIF.
*
*              ENDIF.

            WHEN 'IPI'.
              IF ls_tax_itm-br_nfitemtaxamount > 0.
                IF ls_tax_itm-br_nfitembaseamount > 0.
                  <item>-knwc170-vl_ba_calc_ipi  = ls_tax_itm-br_nfitembaseamount.
                  <item>-knwc170-vl_ipi = ls_tax_itm-br_nfitemtaxamount.
                ELSEIF ls_tax_itm-br_nfitemotherbaseamount > 0.
                  <item>-knwc170-vl_ba_calc_ipi  = ls_tax_itm-br_nfitemotherbaseamount.
                  <item>-knwc170-vl_ipi_outro = ls_tax_itm-br_nfitemtaxamount.
                ELSE.
                  <item>-knwc170-vl_ba_calc_ipi  = ls_tax_itm-br_nfitemexcludedbaseamount.
                  <item>-knwc170-vl_ipi_isento = ls_tax_itm-br_nfitemtaxamount.
                ENDIF.
                <item>-knwc170-aliq_ipi = ls_tax_itm-br_nfitemtaxrate.

                <item>-knwc170-vl_contabil += ls_tax_itm-br_nfitemtaxamount.
                <item>-knwc170-dm_apur_ipi = '0'.
              ENDIF.
*              IF ls_tax_itm-br_nfitemotherbaseamount IS NOT INITIAL.
*                ls_objeto-knwc100-vl_abat_n_trib += ls_tax_itm-br_nfitemtaxamount.
*              ENDIF.

*               <item>-knwc170-vl_ipi_outro
*               <item>-knwc170-vl_ipi_isento
*               <item>-knwc170-vl_ipi_observ

            WHEN 'PIS'.
              IF ls_tax_itm-br_nfitembaseamount > 0.
                <item>-knwc170-aliq_pis = ls_tax_itm-br_nfitemtaxrate.
                <item>-knwc170-vl_aliq_pis = ls_tax_itm-br_nfitemtaxrate.
                <item>-knwc170-vl_ba_calc_pis = ls_tax_itm-br_nfitembaseamount.
                <item>-knwc170-vl_pis = ls_tax_itm-br_nfitemtaxamount.
                "<item>-knwc170-qtde_ba_calc_pis = '0.000'.
              ENDIF.

            WHEN 'COFI'.
              IF ls_tax_itm-br_nfitembaseamount > 0.
                <item>-knwc170-aliq_cof = ls_tax_itm-br_nfitemtaxrate.
                <item>-knwc170-vl_aliq_cofins = ls_tax_itm-br_nfitemtaxrate.
                <item>-knwc170-vl_ba_calc_cof  = ls_tax_itm-br_nfitembaseamount.
                <item>-knwc170-vl_cof = ls_tax_itm-br_nfitemtaxamount.
              ENDIF.
*               <item>-knwc170-VL_COFINS_SUBST
*               <item>-knwc170-QTDE_BA_CALC_COFINS
*               <item>-knwc170-VL_ALIQ_COFINS

            WHEN 'IRRF'.
              ls_objeto-knwc100-vl_bc_irrf += ls_tax_itm-br_nfitembaseamount.
              ls_objeto-knwc100-vl_irrf += ls_tax_itm-br_nfitemtaxamount.
          ENDCASE.

          "Unidade de medida
          <item>-knw0190-cod_empresa        = ls_objeto-knwc100-cod_empresa.
          <item>-knw0190-cod_filial         = ls_objeto-knwc100-cod_filial.
          <item>-knw0190-ds_unidade         = ls_nfitem-unitofmeasure_e. "ls_nfitem-baseunit.
          <item>-knw0190-ds_descricao       = ls_nfitem-unitofmeasurename."ls_nfitem-unitofmeasure_e.
          <item>-knw0190-dt_inicial         = '1900-01-01T00:00:00+03:00'.

          " Material/Produto
          <item>-knw0200-cod_empresa        = ls_objeto-knwc100-cod_empresa.
          <item>-knw0200-cod_filial         = ls_objeto-knwc100-cod_filial.
          <item>-knw0200-cd_produto_serv    = ls_nfitem-nf-material.
          <item>-knw0200-ds_produto_serv    = ls_nfitem-nf-materialname.
          <item>-knw0200-unidade            = ls_nfitem-unitofmeasure_e. "ls_nfitem-baseunit.
          <item>-knw0200-dt_inicial         = '1900-01-01T00:00:00+03:00'.
          "<item>-knw0200-dm_tipo_item       = '09'.
          <item>-knw0200-cd_ncm             = normalize( p_str = ls_nfitem-nf-ncmcode ).
          <item>-knw0200-dm_origem_produto  = ls_nfitem-nf-br_materialorigin.
          <item>-knw0200-nr_cest            = ls_nfitem-nf-br_icmsstlegalclassfctn.
          CASE ls_nfitem-referenceproducttype.
            WHEN 'HAWA'.
              <item>-knw0200-dm_tipo_item = '00'.
            WHEN 'ROH'.
              <item>-knw0200-dm_tipo_item = '01'.
            WHEN 'VERP' OR 'LEIH'.
              <item>-knw0200-dm_tipo_item = '02'.
            WHEN 'PROC' OR 'HALB'.
              <item>-knw0200-dm_tipo_item = '03'.
            WHEN 'FERT'.
              IF ls_nfitem-iscoproduct IS INITIAL.
                <item>-knw0200-dm_tipo_item = '04'.
              ELSE.
                <item>-knw0200-dm_tipo_item = '05'.
              ENDIF.
            WHEN 'HIBE'.
              <item>-knw0200-dm_tipo_item = '06'.
            WHEN 'NLAG'.
              <item>-knw0200-dm_tipo_item = '07'.
            WHEN 'DIEN' OR 'LEIS' OR 'SERV'.
              <item>-knw0200-dm_tipo_item = '09'.
            WHEN OTHERS.
              <item>-knw0200-dm_tipo_item = '99'.
          ENDCASE.

          "CNAE?
          <item>-knw0400-cod_empresa  = ls_objeto-knwc100-cod_empresa.
          <item>-knw0400-cod_filial   = ls_objeto-knwc100-cod_filial.
          <item>-knw0400-cod_grupoempresa   = ls_nfitem-nf-br_efdreinfservicecode.
*          <item>-knw0400-dt_movimento   = |{ p_nfdoc-doc-br_nfpostingdate(4) }-{ p_nfdoc-doc-br_nfpostingdate+4(2) }-{ p_nfdoc-doc-br_nfpostingdate+6 }T| &&
*                                             |{ p_nfdoc-doc-creationtime(2) }:{ p_nfdoc-doc-creationtime+2(2) }:{ p_nfdoc-doc-creationtime+4(2) }+03:00|.
          <item>-knw0400-dt_movimento   = |{ p_nfdoc-doc-br_nfpostingdate(4) }-{ p_nfdoc-doc-br_nfpostingdate+4(2) }-{ p_nfdoc-doc-br_nfpostingdate+6 }T00:00:00+03:00|.

          <item>-knw0400-cd_fiscal      = ls_nfitem-nf-br_cfopcode. "ls_nfitem-nf-ncmcode.
          <item>-knw0400-ds_cd_fiscal   = p_nfdoc-doc-br_nfoperationtypedesc.
          <item>-knw0400-dt_inicial   = '1900-01-01T00:00:00+03:00'.

          "conta contabil
          <item>-knw0500-cod_empresa  = ls_objeto-knwc100-cod_empresa.
          <item>-knw0500-cod_filial   = ls_objeto-knwc100-cod_filial.
          <item>-knw0500-dm_tipo_conta = 'A'.
          "<item>-knw0500-cd_plano_conta = ls_nfitem-nf-glaccount.
          "<item>-knw0500-cd_plan_cta_tot = ls_nfitem-chartofaccounts.

          <item>-knw0500-cd_plano_conta = ls_nfitem-nf-glaccount.
          IF <item>-knw0500-cd_plano_conta IS INITIAL.
            <item>-knw0500-cd_plano_conta = '99999999'.
          ENDIF.

          <item>-knw0500-ds_plano_conta = ls_nfitem-glaccountname.
          IF <item>-knw0500-ds_plano_conta IS INITIAL.
            <item>-knw0500-ds_plano_conta = 'Sem Conta'.
          ENDIF.
          "<item>-knw0500-cd_plano_conta = ls_nfitem-nf-glaccount.
          <item>-knw0500-dt_inicial = '1900-01-01T00:00:00+03:00'.
*          IF <item>-knw0500-cd_plano_conta IS INITIAL.
*            <item>-knw0500-cd_plano_conta = gs_comapany_code-chartofaccounts.
*          ENDIF.

          "------------------------------
          " Totais da nota
          "------------------------------

          " está somando frete/seguro/... 2x por item
          "ls_objeto-knwc100-vl_frete += ls_nfitem-nf-br_nffreightamountwithtaxes.
          "ls_objeto-knwc100-vl_seguro += ls_nfitem-nf-br_nfinsuranceamountwithtaxes.
          "ls_objeto-knwc100-vl_outras_desp += ls_nfitem-nf-br_nfexpensesamountwithtaxes.
          ls_objeto-knwc100-vl_ipi += <item>-knwc170-vl_ipi.
          ls_objeto-knwc100-vl_icms_substit += <item>-knwc170-vl_icms_substit.

        ENDLOOP.



      ENDLOOP.

      "--------------------------------------------------
      " C120 – Totais de impostos por nota (sumarização dos itens)
      "--------------------------------------------------

      CLEAR ls_objeto-knwc120.
      READ TABLE t_imp_di WITH KEY br_notafiscal = p_nfdoc-doc-br_notafiscal TRANSPORTING NO FIELDS.
      IF sy-subrc IS INITIAL.
        LOOP AT t_imp_di INTO DATA(ls_imp_di) WHERE br_notafiscal = p_nfdoc-doc-br_notafiscal.

          ls_objeto-knwc120-dm_emitente        = ls_objeto-knwc100-dm_emitente.
          ls_objeto-knwc120-dm_entrada_saida   = ls_objeto-knwc100-dm_entrada_saida.
          ls_objeto-knwc120-serie_subserie     = ls_objeto-knwc100-serie_subserie.
          ls_objeto-knwc120-nr_documento       = ls_objeto-knwc100-nr_documento.
          ls_objeto-knwc120-dt_emissao_doc     = ls_objeto-knwc100-dt_emissao_doc.
          ls_objeto-knwc120-cod_empresa        = ls_objeto-knwc100-cod_empresa.
          ls_objeto-knwc120-cod_filial         = ls_objeto-knwc100-cod_filial.
          ls_objeto-knwc120-cd_pessoa_rem_dest = ls_objeto-knwc100-cd_pessoa_remet_dest.
          ls_objeto-knwc120-cd_pessoa_rem_dest = ls_objeto-knwc100-cd_pessoa_remet_dest.

          ls_objeto-knwc120-nr_di = ls_imp_di-br_nfimportdocument.
          IF ls_imp_di-br_nfcustomsclearancedate IS NOT INITIAL.
            ls_objeto-knwc120-dt_desembaraco = |{ ls_imp_di-br_nfcustomsclearancedate(4) }-{ ls_imp_di-br_nfcustomsclearancedate+4(2) }-{ ls_imp_di-br_nfcustomsclearancedate+6 }|.
          ENDIF.
          IF ls_imp_di-br_nfimportdocregistrationdate IS NOT INITIAL.
            ls_objeto-knwc120-dt_registro = |{ ls_imp_di-br_nfimportdocregistrationdate(4) }-{ ls_imp_di-br_nfimportdocregistrationdate+4(2) }-{ ls_imp_di-br_nfimportdocregistrationdate+6 }|.
          ENDIF.

          ls_objeto-knwc120-dm_importacao = ls_imp_di-br_nfimportdeclarationtype.
          ls_objeto-knwc120-chave_registro = ''.
          ls_objeto-knwc120-id_usuario_imp = ''.

        ENDLOOP.

        ls_objeto-knwc120-vl_bc_icms = '0.00'.
        ls_objeto-knwc120-vl_icms = '0.00'.
        ls_objeto-knwc120-vl_bc_ipi = '0.00'.
        ls_objeto-knwc120-vl_ipi = '0.00'.
        ls_objeto-knwc120-vl_pis = '0.00'.
        ls_objeto-knwc120-vl_cofins = '0.00'.

        LOOP AT ls_objeto-notafiscalitemlist ASSIGNING FIELD-SYMBOL(<itm_c120>).

          " ICMS – soma base e valor; alíquota pega do último item
          ls_objeto-knwc120-vl_bc_icms += CONV #( <itm_c120>-knwc170-vl_ba_calc_icms ).
          ls_objeto-knwc120-vl_icms    += CONV #( <itm_c120>-knwc170-vl_icms ).

          " IPI – soma base e valor
          ls_objeto-knwc120-vl_bc_ipi += CONV #( <itm_c120>-knwc170-vl_ba_calc_ipi ).
          ls_objeto-knwc120-vl_ipi    += CONV #( <itm_c120>-knwc170-vl_ipi ).

          " PIS – soma base e valor
          ls_objeto-knwc120-vl_pis += CONV #( <itm_c120>-knwc170-vl_pis ).

          " COFINS – soma base e valor
          ls_objeto-knwc120-vl_cofins += CONV #( <itm_c120>-knwc170-vl_cof ).

        ENDLOOP.

      ENDIF.

      APPEND ls_objeto TO ls_main-objetos.
      ls_main-docnum = p_nfdoc-doc-br_notafiscal.
      APPEND VALUE ty_nfs( nota = p_nfdoc-doc-br_nfenumber serie = p_nfdoc-doc-br_nfseries br_notafiscal = p_nfdoc-doc-br_notafiscal ) TO t_nfs.
      IF lv_es IS INITIAL.
        APPEND ls_main TO t_out.
      ELSE.
        APPEND ls_main TO t_out_e.
      ENDIF.

*
*      "--------------------------------------------------
*      " D700 – Serviços (quando aplicável)
*      "--------------------------------------------------
*      IF p_nfdoc-br_nfmodel = '69'.
*        CLEAR ls_objeto-knwd700.
*        ls_objeto-knwd700-vl_servico     = p_nfdoc-br_nftotalamount.
*        ls_objeto-knwd700-dm_tipo_assinante = 'N'.
*      ENDIF.
*
*      "--------------------------------------------------
*      " D100 – CT-e (quando aplicável)
*      "--------------------------------------------------
*      IF p_nfdoc-br_nfmodel = '57'.
*        CLEAR ls_objeto-integracaoconhecimentotrans.
*        ls_objeto-integracaoconhecimentotrans-knwd100-nr_documento =
*          p_nfdoc-br_nfnumber.
*        ls_objeto-integracaoconhecimentotrans-knwd100-nr_chave_acesso_cte =
*          p_nfdoc-br_nfeaccesskey.
*      ENDIF.
*
*      "--------------------------------------------------
*      " Adiciona documento completo ao output
*      "--------------------------------------------------
*      APPEND ls_objeto TO t_out-objetos.

    ENDLOOP.


  ENDMETHOD.
  METHOD read_nf_db.
    TYPES: BEGIN OF ty_docref,
             br_nfreferencedocument TYPE i_br_nfdocument-br_notafiscal,
           END OF ty_docref,
           BEGIN OF ty_awkey,
             br_nfsourcedocumentnumber TYPE i_journalentry-originalreferencedocument,
           END OF ty_awkey.

    DATA: lt_docref TYPE TABLE OF ty_docref,
          lt_awkey  TYPE TABLE OF  ty_awkey,
          r_docnum  TYPE RANGE OF i_br_nfdocument-br_notafiscal,
          lv_path   TYPE string.

    SELECT doc~*, act~*
      FROM i_br_nfdocument AS doc
      LEFT JOIN i_br_nfeactive AS act
      ON doc~br_notafiscal = act~br_notafiscal
      WHERE doc~companycode = @sel-company
        AND doc~businessplace = @sel-branch
        AND doc~creationdate IN @sel-creation
        AND doc~br_nfpostingdate IN @sel-posting
        AND doc~br_nftype IN @sel-nftype
        AND doc~br_notafiscal IN @sel-document
        AND doc~br_nfissuedate IN @sel-docdate
        AND doc~br_nfpostingdate IN @sel-pstdate
        AND doc~br_nfarrivalordeparturedate IN @sel-dsaient
        AND doc~lastchangedate IN @sel-changed
      INTO TABLE @t_nfdocs. "J_1BNFDOC/J_1BNFNAD

    IF t_nfdocs[] IS INITIAL.
      gv_proc = 'No Data for Selection'(001).
      EXIT.
    ENDIF.

    SELECT SINGLE *
      FROM /pyxs/sov_branch
    WHERE company_code = @sel-company
      AND branch = @sel-branch
      INTO @s_branch_sov.


    SELECT *
      FROM i_br_nfpartner
      FOR ALL ENTRIES IN @t_nfdocs
      WHERE br_notafiscal = @t_nfdocs-doc-br_notafiscal
      INTO TABLE @t_partner.

    SELECT * FROM i_customer
      FOR ALL ENTRIES IN @t_nfdocs
      WHERE  customer  = @t_nfdocs-doc-br_nfpartner
      INTO TABLE @t_customers.

    SELECT * FROM i_supplier
      FOR ALL ENTRIES IN @t_nfdocs
      WHERE  supplier  = @t_nfdocs-doc-br_nfpartner
      INTO TABLE @t_vendors.

    " SELECT * FROM I_BR_NFMessage INTO @DATA(ltmsg).

    LOOP AT t_nfdocs INTO DATA(ls_nf).
      APPEND VALUE #( sign = 'I' option = 'EQ' low = ls_nf-doc-br_notafiscal ) TO r_docnum.
    ENDLOOP.

    "MOVE-CORRESPONDING t_nfdocs TO lt_docref.
    "DELETE lt_docref WHERE BR_NFReferenceDocument IS INITIAL.

    SELECT *
      FROM /pyxs/sov_nf_branch
      FOR ALL ENTRIES IN @t_nfdocs
      WHERE cod_estab = @t_nfdocs-doc-businessplace
     INTO CORRESPONDING FIELDS OF TABLE @t_branch.

    SELECT *
      FROM i_br_nftax
       FOR ALL ENTRIES IN @t_nfdocs
      WHERE br_notafiscal = @t_nfdocs-doc-br_notafiscal
      INTO TABLE @t_nftax_itm. " J_1BNFSTX


    LOOP AT t_nftax_itm INTO DATA(ls_nftax).
      READ TABLE t_nftax ASSIGNING FIELD-SYMBOL(<tax>)
      WITH KEY
        br_notafiscal = ls_nftax-br_notafiscal
        br_taxtype = ls_nftax-br_taxtype
        taxgroup = ls_nftax-taxgroup.
      IF sy-subrc IS INITIAL.
        <tax>-br_nfitembaseamount += ls_nftax-br_nfitembaseamount.
        <tax>-br_nfitemtaxamount += ls_nftax-br_nfitemtaxamount.
      ELSE.
        APPEND ls_nftax TO t_nftax.
      ENDIF.
    ENDLOOP.

    SELECT *
      FROM i_br_nftexts
     FOR ALL ENTRIES IN @t_nfdocs
     WHERE  br_notafiscal = @t_nfdocs-doc-br_notafiscal
      INTO TABLE @t_texts.

    SELECT *
      FROM i_br_nfimportdocument
      FOR ALL ENTRIES IN @t_nfdocs
      WHERE br_notafiscal = @t_nfdocs-doc-br_notafiscal
      ORDER BY PRIMARY KEY
      INTO TABLE @t_imp_di. " J_1BNFIMPORT_DI

    SELECT *
      FROM i_br_nfexportdocument
      FOR ALL ENTRIES IN @t_nfdocs
      WHERE br_notafiscal = @t_nfdocs-doc-br_notafiscal
      INTO TABLE @t_exp_di. " J_1BNFEXPORT_DI

    SELECT *
      FROM i_br_nfeactive
      FOR ALL ENTRIES IN @t_nfdocs
      WHERE br_notafiscal = @t_nfdocs-doc-br_notafiscal
      INTO TABLE @t_active. " J_1BNFE_ACTIVE
    IF lt_docref[] IS NOT INITIAL.

      SELECT *                                "#EC CI_FAE_LINES_ENSURED
        FROM i_br_nfeactive
        FOR ALL ENTRIES IN @lt_docref
        WHERE br_notafiscal = @lt_docref-br_nfreferencedocument
        INTO TABLE @t_active_ref. " J_1BNFE_ACTIVE
    ENDIF.

    SELECT nf~*, a~product, a~producttype, a~baseunit,
            c~plant, c~iscoproduct,
            a~\_producttype-referenceproducttype,
            nf~\_baseunit-unitofmeasureisocode, nf~\_baseunit-unitofmeasure_e, nf~\_baseunit\_text[ language = 'P' ]-unitofmeasurename,
            i_glaccount~\_text[ language = 'P' ]-glaccountname, i_glaccount~chartofaccounts
      FROM i_br_nfitem AS nf
      LEFT OUTER JOIN i_product AS a
      ON nf~material = a~product
      LEFT OUTER JOIN i_productplantbasic AS c
      ON a~product = c~product
      AND c~plant = nf~plant
      LEFT OUTER JOIN i_productvaluationbasic AS val
      ON val~valuationarea = nf~plant
      AND val~product = a~product
      AND val~valuationarea = ''
      LEFT OUTER JOIN i_glaccount
      ON i_glaccount~glaccount = nf~glaccount
      AND i_glaccount~companycode = @sel-company
      WHERE nf~br_notafiscal IN @r_docnum
      INTO TABLE @t_nfitem. "J_BNFLIN

    "MOVE-CORRESPONDING t_nfitem TO lt_awkey.
    DATA: ls_awkey  TYPE ty_awkey.
    LOOP AT t_nfitem INTO DATA(ls_t_nfitem).
      ls_awkey-br_nfsourcedocumentnumber = ls_t_nfitem-nf-br_nfsourcedocumentnumber.
      APPEND ls_awkey TO lt_awkey.
    ENDLOOP.

    SORT lt_awkey.
    DELETE ADJACENT DUPLICATES FROM lt_awkey.
    DELETE lt_awkey WHERE br_nfsourcedocumentnumber = space.

    IF lt_awkey IS NOT INITIAL.

      SELECT companycode, fiscalyear, accountingdocument, originalreferencedocument "#EC CI_FAE_LINES_ENSURED
        FROM i_journalentry
        FOR ALL ENTRIES IN @lt_awkey
       WHERE originalreferencedocument = @lt_awkey-br_nfsourcedocumentnumber
         INTO TABLE @t_bkpf. " BKPF

      SELECT companycode, fiscalyear, accountingdocument, accountingdocumentitem, ledgergllineitem, financialaccounttype,
              controllingdebitcreditcode, netduedate, invoicereference
        FROM i_glaccountlineitemrawdata
        FOR ALL ENTRIES IN @t_bkpf
        WHERE companycode = @t_bkpf-companycode
          AND fiscalyear = @t_bkpf-fiscalyear
          AND accountingdocument = @t_bkpf-accountingdocument
          INTO TABLE @t_bseg. "BSEG

      SELECT companycode, fiscalyear, accountingdocument, accountingdocumentitem, withholdingtaxtype, "#EC CI_NO_TRANSFORM
              withholdingtaxcode, whldgtaxbaseamtincocodecrcy, whldgtaxamtincocodecrcy, withholdingtaxpercent,
              clearingaccountingdocument, clearingdate
        FROM i_withholdingtaxitem
         FOR ALL ENTRIES IN @t_bkpf
        WHERE companycode = @t_bkpf-companycode
          AND fiscalyear = @t_bkpf-fiscalyear
          AND accountingdocument = @t_bkpf-accountingdocument
          AND withholdingtaxcode <> ''
          INTO TABLE @t_withtax.

    ENDIF.


    SELECT *
      FROM i_regiontext
      WHERE language = 'P'
        AND country = 'BR'
      INTO TABLE @t_region.

    SELECT *
      FROM i_countrytext
     WHERE language = 'P'
     INTO TABLE @t_country.

    SELECT *                                       "#EC CI_NO_TRANSFORM
      FROM i_unitofmeasuretext
      FOR ALL ENTRIES IN @t_nfitem
     WHERE unitofmeasure = @t_nfitem-nf-baseunit
     AND language = 'P'
     INTO TABLE @t_units.

    SELECT SINGLE * FROM i_companycode WHERE companycode = @sel-company INTO @gs_comapany_code.
    "Branch CNPJ
    DATA(ls_branch) = VALUE #( t_branch[ cod_estab = sel-branch cod_companhia = sel-company ] OPTIONAL ).
    gv_branch_cnpj = build_cnpj( |{ ls_branch-cnpj_raiz }{ ls_branch-cnpj_filial }| ).
    "p_nfdoc-doc-companycode = s_branch_sov-sov_company.
    "p_nfdoc-doc-businessplace = s_branch_sov-sov_branch.

  ENDMETHOD.
  METHOD normalize.
    normalized = p_str.
    TRANSLATE: normalized USING '. ',
               normalized USING '- ',
               normalized USING '/ '.
    CONDENSE normalized NO-GAPS.
  ENDMETHOD.
  METHOD popu.
    t_tax_type =
      VALUE #(
  ( br_taxtype = 'CCOP' br_taxgroup = 'ICOP' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'CCOX' br_taxgroup = '' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'CIC0' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'CIC1' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'CIC2' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'CIC3' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'CICA' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'CIDC' br_taxgroup = 'ICOP' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'CIDF' br_taxgroup = 'ICOP' br_icmspartilhasubdivisioncode = '004'  )
  ( br_taxtype = 'CIFC' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = '004'  )
  ( br_taxtype = 'CIIC' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'CISF' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = '004'  )
  ( br_taxtype = 'CIST' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'COF0' br_taxgroup = 'COFI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'COFD' br_taxgroup = 'COFI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'COFT' br_taxgroup = 'COFI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'CST1' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'CST2' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'CST3' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'FCP1' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = '004'  )
  ( br_taxtype = 'FCP2' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = '004'  )
  ( br_taxtype = 'FCP5' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = '004'  )
  ( br_taxtype = 'FCP6' br_taxgroup = '' br_icmspartilhasubdivisioncode = '004'  )
  ( br_taxtype = 'FCPI' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = '004'  )
  ( br_taxtype = 'FCPO' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = '004'  )
  ( br_taxtype = 'FPS1' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = '004'  )
  ( br_taxtype = 'FPS2' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = '004'  )
  ( br_taxtype = 'FPS5' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = '004'  )
  ( br_taxtype = 'FPS6' br_taxgroup = '' br_icmspartilhasubdivisioncode = '004'  )
  ( br_taxtype = 'FPSI' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = '004'  )
  ( br_taxtype = 'FPSO' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = '004'  )
  ( br_taxtype = 'IC1C' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IC1O' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICAM' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICAP' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = '001'  )
  ( br_taxtype = 'ICBP' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICCP' br_taxgroup = 'ICOP' br_icmspartilhasubdivisioncode = '004'  )
  ( br_taxtype = 'ICCX' br_taxgroup = '' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICEM' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICEP' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = '002'  )
  ( br_taxtype = 'ICFO' br_taxgroup = '' br_icmspartilhasubdivisioncode = '004'  )
  ( br_taxtype = 'ICFP' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = '004'  )
  ( br_taxtype = 'ICM0' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICM1' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICM2' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICM3' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICM4' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICM5' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = '005'  )
  ( br_taxtype = 'ICM6' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = '006'  )
  ( br_taxtype = 'ICM7' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = '005'  )
  ( br_taxtype = 'ICM8' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = '006'  )
  ( br_taxtype = 'ICMF' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICML' br_taxgroup = '' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICMM' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICMN' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICMP' br_taxgroup = '' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICMT' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICMU' br_taxgroup = '' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICMV' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICMX' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICN3' br_taxgroup = 'COFI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICO1' br_taxgroup = 'ICOP' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICO3' br_taxgroup = 'ICOP' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICO4' br_taxgroup = '' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICOA' br_taxgroup = 'COFI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICOC' br_taxgroup = 'COFI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICOF' br_taxgroup = 'COFI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICOG' br_taxgroup = 'COFI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICOH' br_taxgroup = 'COFI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICON' br_taxgroup = 'COFI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICOO' br_taxgroup = 'COFI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICOP' br_taxgroup = 'ICOP' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICOQ' br_taxgroup = 'WACO' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICOR' br_taxgroup = 'COFI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICOS' br_taxgroup = 'COFI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICOT' br_taxgroup = 'ICOP' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICOU' br_taxgroup = 'COFI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICOV' br_taxgroup = 'COFI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICOW' br_taxgroup = 'WHCO' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICOX' br_taxgroup = '' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICOZ' br_taxgroup = '' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICS1' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICS2' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICS3' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICS4' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICS5' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICS6' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICS7' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICS9' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICSC' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = '004'  )
  ( br_taxtype = 'ICSE' br_taxgroup = '' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICSF' br_taxgroup = 'COFI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICSM' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICSO' br_taxgroup = '' br_icmspartilhasubdivisioncode = '004'  )
  ( br_taxtype = 'ICSP' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = '003'  )
  ( br_taxtype = 'ICSQ' br_taxgroup = 'WACS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICST' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICSW' br_taxgroup = 'WHCS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICSZ' br_taxgroup = '' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICTP' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICW3' br_taxgroup = 'WHCO' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICW5' br_taxgroup = 'WACO' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICZF' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICZG' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ICZT' br_taxgroup = 'ICMS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IFR1' br_taxgroup = 'ICFR' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IFR3' br_taxgroup = 'ICFR' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IFS1' br_taxgroup = 'ICFS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IFS3' br_taxgroup = 'ICFS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IGEQ' br_taxgroup = 'WAT' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IGEW' br_taxgroup = 'WHT' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IGEZ' br_taxgroup = '' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IGW3' br_taxgroup = 'WHT' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IGW5' br_taxgroup = 'WAT' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'II01' br_taxgroup = 'II' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IIRQ' br_taxgroup = 'WAIR' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IIRW' br_taxgroup = 'WHIR' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IIRZ' br_taxgroup = '' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'INS3' br_taxgroup = 'CPRB' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'INSS' br_taxgroup = '' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'INSW' br_taxgroup = 'INSS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'INSX' br_taxgroup = '' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'INWI' br_taxgroup = 'INSS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'INWO' br_taxgroup = 'INSS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IP1C' br_taxgroup = 'IPI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IP1O' br_taxgroup = 'IPI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPI0' br_taxgroup = 'IPI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPI1' br_taxgroup = 'IPI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPI2' br_taxgroup = 'IPI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPI3' br_taxgroup = 'IPI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPI4' br_taxgroup = 'IPI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPI5' br_taxgroup = 'IPI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPIA' br_taxgroup = 'IPI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPIB' br_taxgroup = 'IPI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPIC' br_taxgroup = 'PIS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPIN' br_taxgroup = 'IPI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPIS' br_taxgroup = 'PIS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPIU' br_taxgroup = '' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPIX' br_taxgroup = 'IPI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPS3' br_taxgroup = 'PIS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPSA' br_taxgroup = 'PIS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPSF' br_taxgroup = 'PIS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPSG' br_taxgroup = 'PIS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPSH' br_taxgroup = 'PIS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPSN' br_taxgroup = 'PIS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPSO' br_taxgroup = 'PIS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPSQ' br_taxgroup = 'WAPI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPSS' br_taxgroup = 'PIS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPSU' br_taxgroup = 'PIS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPSV' br_taxgroup = 'PIS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPSW' br_taxgroup = 'WHPI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPSZ' br_taxgroup = '' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPW3' br_taxgroup = 'WHPI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IPW5' br_taxgroup = 'WAPI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IRD1' br_taxgroup = 'RBIC' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IRD2' br_taxgroup = 'RBIC' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IRD3' br_taxgroup = 'RBST' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IRD4' br_taxgroup = 'RBST' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IRD5' br_taxgroup = 'RBIC' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IRD6' br_taxgroup = 'RBST' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IRRW' br_taxgroup = 'IRRF' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IRW3' br_taxgroup = 'WHIR' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IRW5' br_taxgroup = 'WAIR' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IRWI' br_taxgroup = 'WHIR' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IRWO' br_taxgroup = 'WHIR' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IS1C' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IS1O' br_taxgroup = '' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ISA3' br_taxgroup = 'ISSP' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ISB3' br_taxgroup = 'ISSP' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ISE3' br_taxgroup = 'ISSS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ISF3' br_taxgroup = 'ISSS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ISS2' br_taxgroup = 'ISS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ISS3' br_taxgroup = 'ISS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ISSA' br_taxgroup = 'ISSP' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ISSB' br_taxgroup = 'ISSP' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ISSE' br_taxgroup = 'ISSS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ISSF' br_taxgroup = 'ISSS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ISSG' br_taxgroup = 'ISSP' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ISSO' br_taxgroup = 'ISS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ISUP' br_taxgroup = 'COFI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ISW3' br_taxgroup = 'WHCS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'ISW5' br_taxgroup = 'WACS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IT1C' br_taxgroup = 'ICST' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'IT1O' br_taxgroup = '' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'PIS0' br_taxgroup = 'PIS' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'TCOS' br_taxgroup = 'COFI' br_icmspartilhasubdivisioncode = ''  )
  ( br_taxtype = 'TPIS' br_taxgroup = 'PIS' br_icmspartilhasubdivisioncode = ''  )
   ).
  ENDMETHOD.

  METHOD main.

    lcl_process=>data = cl_abap_context_info=>get_system_date( ).
    lcl_process=>hora = cl_abap_context_info=>get_system_time( ).

    sel-document = VALUE #( ( sign = 'I' option = 'EQ' low = 35 ) ).
    sel-company = '1410'.
    sel-branch = '1410'.
    lcl_process=>read_nf_db(  ).
    lcl_process=>new_out(  ).
    lcl_process=>send_integration( ).

  ENDMETHOD.



  METHOD nfse_out.
    DATA: lv_estorno TYPE c,
          "ls_out        TYPE /pyxs/cl_fiscal_documents=>ty_main,
          lv_docnum  TYPE i_br_nfdocument-br_notafiscal,
          "ls_retido     TYPE /pyxs/cl_fiscal_documents=>ty_impostosretidos,
          "ls_itm_out    TYPE /pyxs/cl_fiscal_documents=>ty_itens,
          "ls_importacao TYPE /pyxs/cl_fiscal_documents=>ty_importacoes,
          ls_objeto  TYPE lcl_process_srv=>ty_objetos,
          ls_main    TYPE lcl_process_srv=>ty_main.
    DELETE t_nfdocs WHERE doc-br_nfdocumenttype = '5'.
    IF t_nfdocs[] IS INITIAL.
      gv_proc = 'Nenhum documento processado'.
    ENDIF.
    popu(  ).
    LOOP AT t_nfdocs INTO DATA(p_nfdoc)  WHERE doc-br_nfismunicipal = 'X' OR doc-br_nfhasserviceitem = 'X'.

      """"""""""""""""""""""""""""""""""""""""""""""""""""""""""
      " DE x PARA
      p_nfdoc-doc-companycode = s_branch_sov-sov_company.
      p_nfdoc-doc-businessplace = s_branch_sov-sov_branch.

      CLEAR: ls_objeto, ls_main.

      "--------------------------------------------------
      " C100 – Cabeçalho do documento
      "--------------------------------------------------


      "" knw150 - ok ""
      "ls_objeto-docnum = p_nfdoc-doc-br_notafiscal.

      CLEAR ls_objeto-knw0150.
      ls_objeto-knw0150-dt_inicial      = '0001-01-01T00:00:00-02:00'.
      ls_objeto-knw0150-dt_importacao   = '0001-01-01T00:00:00-02:00'.
      ls_objeto-knw0150-cod_empresa     = p_nfdoc-doc-companycode.
      ls_objeto-knw0150-cod_filial      = p_nfdoc-doc-businessplace.
      ls_objeto-knw0150-cd_pessoa       = p_nfdoc-doc-br_nfpartner.
      ls_objeto-knw0150-nm_razao_social = p_nfdoc-doc-br_nfpartnername1.
      ls_objeto-knw0150-ds_endereco     = p_nfdoc-doc-br_nfpartnerstreetname.
      ls_objeto-knw0150-nr_numero       = p_nfdoc-doc-businesspartnerhousenumber.
      ls_objeto-knw0150-ds_bairro       = p_nfdoc-doc-br_nfpartnerdistrictname.

      ls_objeto-knw0150-nr_cep          = p_nfdoc-doc-br_nfpartnerpostalcode.
      REPLACE ALL OCCURRENCES OF '-' IN ls_objeto-knw0150-nr_cep WITH ''.

      ls_objeto-knw0150-cd_municipio    = p_nfdoc-doc-br_nfpartnertaxjurisdiction+3(7).
      ls_objeto-knw0150-cd_pais         = get_ibge_country( p_nfdoc-doc-br_nfpartnercountrycode ).
      ls_objeto-knw0150-nr_cnpj_cpf     = p_nfdoc-doc-br_nfpartnercnpj.
      ls_objeto-knw0150-nr_inscr_munic  = p_nfdoc-doc-br_nfpartnermunicipaltaxnumber.
      ls_objeto-knw0150-dm_contribuinte = '1'.


      ""knwa100 - ""

      CLEAR ls_objeto-knwa100.

      IF p_nfdoc-doc-br_nfenumber IS NOT INITIAL.
        ls_objeto-knwa100-nr_documento = p_nfdoc-doc-br_nfenumber.
        IF p_nfdoc-doc-br_nfseries IS INITIAL.
          ls_objeto-knwa100-nr_serie    = '000'.
        ELSE.
          ls_objeto-knwa100-nr_serie    = p_nfdoc-doc-br_nfseries.
        ENDIF.
      ELSE.
        IF p_nfdoc-doc-br_nfsnumber IS NOT INITIAL.
          TRY.
              ls_objeto-knwa100-nr_documento = p_nfdoc-doc-br_nfsnumber.
            CATCH cx_sy_conversion_no_number.
              ls_objeto-knwa100-nr_documento = p_nfdoc-doc-br_nfnumber.
          ENDTRY.
          CLEAR ls_objeto-knwa100-nr_serie.
        ELSE.
          ls_objeto-knwa100-nr_documento = p_nfdoc-doc-br_nfnumber.
        ENDIF.
      ENDIF.

      "ls_objeto-knwa100-nr_documento = p_nfdoc-doc-br_nfenumber.
      ls_objeto-knwa100-nr_serie     = p_nfdoc-doc-br_nfseries.


      " Datas
      ls_objeto-knwa100-dt_emissao =
        |{ p_nfdoc-doc-br_nfissuedate(4) }-{ p_nfdoc-doc-br_nfissuedate+4(2) }-{ p_nfdoc-doc-br_nfissuedate+6 }T00:00:00-03:00|.

      ls_objeto-knwa100-dt_execucao =
        |{ p_nfdoc-doc-br_nfpostingdate(4) }-{ p_nfdoc-doc-br_nfpostingdate+4(2) }-{ p_nfdoc-doc-br_nfpostingdate+6 }T00:00:00-03:00|.

      ls_objeto-knwa100-dt_escrituracao =
        |{ p_nfdoc-doc-br_nfpostingdate(4) }-{ p_nfdoc-doc-br_nfpostingdate+4(2) }-{ p_nfdoc-doc-br_nfpostingdate+6 }T00:00:00-03:00|.


      " Indicadores
      ls_objeto-knwa100-dm_emitente =
        COND #( WHEN p_nfdoc-doc-br_nfdirection = '2'
                THEN '1'
                ELSE '0' ).

      ls_objeto-knwa100-dm_pgto         = '9'.   " Outros
      ls_objeto-knwa100-dm_cancelamento = '00'.

      " Serviço / Prestação
      ls_objeto-knwa100-cd_fiscal_prest        = '901'.   " fixo inicial
      ls_objeto-knwa100-cd_municipio_prestacao = p_nfdoc-doc-br_nfpartnercityname.

      " Valores
      ls_objeto-knwa100-vl_documento = p_nfdoc-doc-br_nftotalamount.
      IF p_nfdoc-doc-br_nfdiscountamount > 0.
        ls_objeto-knwa100-vl_desconto  = p_nfdoc-doc-br_nfdiscountamount.
      ELSE.
        ls_objeto-knwa100-vl_desconto = '0.0'.
      ENDIF.

      ls_objeto-knwa100-vl_tot_subc          = '0.0'.
      ls_objeto-knwa100-vl_material_proprio  = '0.0'.
      ls_objeto-knwa100-vl_material_terceiro = '0.0'.
      ls_objeto-knwa100-vl_outras_despesas   = '0.0'.

      ls_objeto-knwa100-vl_base_iss  = '0.0'.
      ls_objeto-knwa100-aliq_iss     = '0.0'.
      ls_objeto-knwa100-vl_reten_iss = '0.0'.
      ls_objeto-knwa100-vl_base_inss = '0.0'.
      ls_objeto-knwa100-vl_reten_inss = '0.0'.
      ls_objeto-knwa100-vl_base_irrf = '0.0'.
      ls_objeto-knwa100-vl_reten_irrf = '0.0'.

      " Chaves organizacionais
      ls_objeto-knwa100-cod_empresa = p_nfdoc-doc-companycode.
      ls_objeto-knwa100-cod_filial  = p_nfdoc-doc-businessplace.

      ls_objeto-knwa100-cd_pessoa_remet_dest = p_nfdoc-doc-br_nfpartner.



      """""""""""""""""""""""""""""""""""PAREI AQUI """"""""""""""""""""

      "ls_objeto-knwc100-dm_emitente        = COND #( WHEN p_nfdoc-doc-br_nfdirection = '2' THEN '1' ELSE '0' ).
      "ls_objeto-knwc100-dm_entrada_saida   = COND #( WHEN p_nfdoc-doc-br_nfdirection = '2' THEN 'S' ELSE 'E' ).
      "ls_objeto-knwc100-serie_subserie     = p_nfdoc-doc-br_nfseries.
      "ls_objeto-knwc100-nr_documento       = p_nfdoc-doc-br_nfenumber.

      "ls_objeto-knwc100-dt_emissao_doc     = |{ p_nfdoc-doc-br_nfissuedate(4) }-{ p_nfdoc-doc-br_nfissuedate+4(2) }-{ p_nfdoc-doc-br_nfissuedate+6 }T| &&
      "|{ p_nfdoc-doc-creationtime(2) }:{ p_nfdoc-doc-creationtime+2(2) }:{ p_nfdoc-doc-creationtime+4(2) }+03:00|.
      "ls_objeto-knwc100-dt_entrada         = |{ p_nfdoc-doc-br_nfpostingdate(4) }-{ p_nfdoc-doc-br_nfpostingdate+4(2) }-{ p_nfdoc-doc-br_nfpostingdate+6 }T| &&
      "|{ p_nfdoc-doc-creationtime(2) }:{ p_nfdoc-doc-creationtime+2(2) }:{ p_nfdoc-doc-creationtime+4(2) }+03:00|.
      "ls_objeto-knwc100-cd_modelo_doc      = p_nfdoc-doc-br_nfmodel.
      "ls_objeto-knwc100-nr_chave_eletr     = |{ p_nfdoc-act-region }{ p_nfdoc-act-br_nfeissueyear }{ p_nfdoc-act-br_nfeissuemonth }{ p_nfdoc-act-br_nfeaccesskeycnpjorcpf }| &&
      "|{ p_nfdoc-act-br_nfemodel }{ p_nfdoc-act-br_nfeseries }{ p_nfdoc-act-br_nfenumber }{ p_nfdoc-act-br_nfenvironmenttype }{ p_nfdoc-act-br_nferandomnumber }{ p_nfdoc-act-br_nfecheckdigit }|.
      "ls_objeto-knwc100-ds_natureza        = p_nfdoc-doc-br_nfoperationtypedesc.
      "ls_objeto-knwc100-cod_empresa        = p_nfdoc-doc-companycode.
      "ls_objeto-knwc100-cd_sit_documento        = COND #( WHEN p_nfdoc-doc-br_nfsituationcode IS NOT INITIAL
      "                                                     THEN p_nfdoc-doc-br_nfsituationcode
      "                                                    ELSE '00' ).
      "ls_objeto-knwc100-cod_filial         = p_nfdoc-doc-businessplace.
      "ls_objeto-knwc100-cd_pessoa_remet_dest         = p_nfdoc-doc-br_nfpartner.


      "ls_objeto-knwc100-vl_total_mercad    = p_nfdoc-doc-br_nftotalamount.
      "ls_objeto-knwc100-vl_tot_n_fiscal    = p_nfdoc-doc-br_nftotalamount.
      "ls_objeto-knwc100-vl_desconto    = p_nfdoc-doc-br_nfdiscountamount.

      "ls_objeto-knwc100-vl_bc_prev = '0.0'.
      "ls_objeto-knwc100-vl_prev = '0.0'.
      "ls_objeto-knwc100-dm_tipo_fatura = '2'.
      "ls_objeto-knwc100-ds_uf_dest_emit = p_nfdoc-doc-br_nfpartnerregioncode.
      "ls_objeto-knwc100-vl_serv_nt = '0.0'.
      "ls_objeto-knwc100-vl_material_terc = '0.0'.
      "ls_objeto-knwc100-vl_sub_empr = '0.0'.
      "ls_objeto-knwc100-dm_finalidade = '1'.
      "ls_objeto-knwc100-dm_destinatario = '1'.
      "ls_objeto-knwc100-vl_servico1 = '0.0'.
      "ls_objeto-knwc100-vl_abat_n_trib = '0.0'.


*
*      "--------------------------------------------------
*      " Itens da nota – C170 + cadastros
*      "--------------------------------------------------
      CLEAR ls_objeto-integracaonotafiscalservico.

      LOOP AT t_nfitem INTO DATA(ls_nfitem)
           WHERE nf-br_notafiscal  = p_nfdoc-doc-br_notafiscal.

        ls_objeto-knwa100-cd_centro_custo      = ls_nfitem-nf-costcenter.
        ls_objeto-knw0500-cod_empresa  = ls_objeto-knwa100-cod_empresa.
        ls_objeto-knw0500-cod_filial   = ls_objeto-knwa100-cod_filial.
        ls_objeto-knw0500-dm_tipo_conta = 'A'.
        ls_objeto-knw0500-cd_plano_conta = ls_nfitem-nf-glaccount.
        ls_objeto-knw0500-cd_plan_cta_tot = ls_nfitem-chartofaccounts.
        ls_objeto-knw0500-ds_plano_conta = ls_nfitem-glaccountname.
        ls_objeto-knw0500-cd_plano_conta = ls_nfitem-nf-glaccount.
        ls_objeto-knw0500-dt_inicial = '1900-01-01T00:00:00+03:00'.

        APPEND INITIAL LINE TO ls_objeto-integracaonotafiscalservico ASSIGNING FIELD-SYMBOL(<item>).

        DO.
          ASSIGN COMPONENT sy-index OF STRUCTURE <item>-knwa170 TO FIELD-SYMBOL(<fs>).
          IF sy-subrc IS NOT INITIAL.
            EXIT.
          ENDIF.
          <fs> = '0.0'.
        ENDDO.

        "------------------------------
        " C170 – Item fiscal
        "------------------------------
        <item>-knwa170-cod_empresa        = ls_objeto-knwa100-cod_empresa.
        <item>-knwa170-cod_filial         = ls_objeto-knwa100-cod_filial.
        <item>-knwa170-nr_item          = ls_nfitem-nf-br_notafiscalitem.
        <item>-knwa170-nr_documento     = ls_objeto-knwa100-nr_documento.
        "<item>-knwa170-serie_subserie     = ls_objeto-knwa100-serie_subserie .
        <item>-knwa170-dt_emissao     = ls_objeto-knwa100-dt_emissao .
        <item>-knwa170-dt_execucao     = ls_objeto-knwa100-dt_execucao .
        <item>-knwa170-dm_emitente     = ls_objeto-knwa100-dm_emitente .
        <item>-knwa170-cd_pessoa_remet_dest     = ls_objeto-knwa100-cd_pessoa_remet_dest .
        <item>-knwa170-cd_plano_conta     = ls_nfitem-nf-glaccount.
        <item>-knwa170-cd_lst     = ls_nfitem-nf-br_lc116servicecode.
        <item>-knwa170-cd_prod_serv     = ls_nfitem-nf-material.


        <item>-knwa170-vl_servico = ls_nfitem-nf-br_nftotalamount.
        IF ls_nfitem-nf-br_nfdiscountamountwithtaxes > 0.
          <item>-knwa170-vl_desconto = ls_nfitem-nf-br_nfdiscountamountwithtaxes.
        ENDIF.


        <item>-knwa170-cd_sit_trib_pis = ls_nfitem-nf-br_pistaxsituation.
        <item>-knwa170-cd_sit_trib_cofins = ls_nfitem-nf-br_cofinstaxsituation.

        <item>-knwa170-dm_tipo_nfts = '2'.
        <item>-knwa170-dm_tipo_documento = '01'.
        <item>-knwa170-dm_tributacao = 'J'.

        LOOP AT t_nftax_itm INTO DATA(ls_tax_itm) WHERE br_notafiscal = ls_nfitem-nf-br_notafiscal
                                                AND br_notafiscalitem = ls_nfitem-nf-br_notafiscalitem.


          READ TABLE t_tax_type INTO DATA(ls_tax_type) WITH KEY br_taxtype = ls_tax_itm-br_taxtype.
          IF sy-subrc IS NOT INITIAL.
            CLEAR ls_tax_type.
          ENDIF.
          CASE ls_tax_itm-taxgroup.
            WHEN 'PIS'.
              IF ls_tax_itm-br_nfitembaseamount > 0.
                <item>-knwa170-aliq_pis = ls_tax_itm-br_nfitemtaxrate.
                <item>-knwa170-vl_pis = ls_tax_itm-br_nfitemtaxamount.
                <item>-knwa170-vl_bc_pis = ls_tax_itm-br_nfitembaseamount.
              ENDIF.
            WHEN 'COFI'.
              IF ls_tax_itm-br_nfitembaseamount > 0.
                <item>-knwa170-aliq_cofins = ls_tax_itm-br_nfitemtaxrate.
                <item>-knwa170-vl_cofins = ls_tax_itm-br_nfitemtaxamount.
                <item>-knwa170-vl_bc_cofins = ls_tax_itm-br_nfitembaseamount.
              ENDIF.
            WHEN 'ISSS' OR 'ISSP'.
              <item>-knwa170-dm_iss_retido = '2'.
              <item>-knwa170-aliq_iss = ls_tax_itm-br_nfitemtaxrate.
              <item>-knwa170-vl_iss = ls_tax_itm-br_nfitemtaxamount.
              <item>-knwa170-vl_bc_iss = ls_tax_itm-br_nfitembaseamount.
              IF ls_tax_itm-br_nfitemhaswithholdingtax IS NOT INITIAL.
                <item>-knwa170-dm_iss_retido = '1'.
                <item>-knwa170-vl_bc_iss_ret  =  ls_tax_itm-br_nfitembaseamount.
                <item>-knwa170-vl_iss_ret   = ls_tax_itm-br_nfitemtaxamount.
              ENDIF.
              ls_objeto-knwa100-vl_base_iss = ls_tax_itm-br_nfitembaseamount.
              ls_objeto-knwa100-aliq_iss = ls_tax_itm-br_nfitemtaxrate.
              ls_objeto-knwa100-vl_reten_iss = <item>-knwa170-vl_iss_ret.

              IF ls_tax_itm-br_nfitemtaxamount > 0.
                <item>-knwa170-dm_tributacao = 'T'.
              ELSE.
                <item>-knwa170-dm_tributacao = 'I'.
              ENDIF.

            WHEN 'IRRF' OR 'WHIR' OR 'WAIR'.
              ls_objeto-knwa100-vl_base_irrf = ls_tax_itm-br_nfitembaseamount.
              ls_objeto-knwa100-vl_reten_irrf = ls_tax_itm-br_nfitemtaxamount.
            WHEN 'INSS'.
              IF ls_tax_itm-br_nfitemtaxamount IS NOT INITIAL.
                IF ls_tax_itm-br_nfitemhaswithholdingtax IS NOT INITIAL.
                  ls_objeto-knwa100-vl_reten_inss = ls_tax_itm-br_nfitemtaxamount.
                ENDIF.
                ls_objeto-knwa100-vl_base_inss = ls_tax_itm-br_nfitembaseamount.
              ENDIF.
          ENDCASE.

          "Unidade de medida
          <item>-knw0190-cod_empresa        = ls_objeto-knwa100-cod_empresa.
          <item>-knw0190-cod_filial         = ls_objeto-knwa100-cod_filial.
          <item>-knw0190-ds_unidade         = ls_nfitem-baseunit.
          <item>-knw0190-ds_descricao         = ls_nfitem-unitofmeasure_e.
          <item>-knw0190-dt_inicial         = '1900-01-01T00:00:00+03:00'.

          " Material/Produto
          <item>-knw0200-cod_empresa        = ls_objeto-knwa100-cod_empresa.
          <item>-knw0200-cod_filial         = ls_objeto-knwa100-cod_filial.
          <item>-knw0200-cd_produto_serv  = ls_nfitem-nf-material.
          <item>-knw0200-ds_produto_serv = ls_nfitem-nf-materialname.
          <item>-knw0200-unidade = ls_nfitem-baseunit.
          <item>-knw0200-dt_inicial         = '1900-01-01T00:00:00+03:00'.
          <item>-knw0200-dm_tipo_item = '09'.

        ENDLOOP.
        APPEND ls_objeto TO ls_main-objetos.


      ENDLOOP.
      ls_main-docnum = p_nfdoc-doc-br_notafiscal.
      APPEND ls_main TO t_out_srv.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.

CLASS lhc_sovos_fiscaldocuments IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD create.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.


  METHOD sendintegration.

    DATA(key) = keys[ 1 ].
    DATA(lv_param) = keys[ 1 ]-%param.

    lcl_process=>data = cl_abap_context_info=>get_system_date( ).
    lcl_process=>hora = cl_abap_context_info=>get_system_time( ).

    "-----------------------------------------------------------------------
    " Validação: Company e Branch obrigatórios
    "-----------------------------------------------------------------------
    lcl_process=>sel-company = keys[ 1 ]-%param-company.
    lcl_process=>sel-branch = keys[ 1 ]-%param-branch.


    IF lcl_process=>sel-company IS INITIAL OR lcl_process=>sel-branch IS INITIAL.
      APPEND VALUE #( %action-sendintegration = if_abap_behv=>mk-on
      ) TO failed-/pyxs/sovos_fiscaldocuments.
      APPEND VALUE #(
        %msg = new_message_with_text(
          severity = if_abap_behv_message=>severity-error
          text     = 'Empresa e Local de Negócio são obrigatórios' )
        %action-sendintegration = if_abap_behv=>mk-on
      ) TO reported-/pyxs/sovos_fiscaldocuments.
    ENDIF.


    "-----------------------------------------------------------------------
    " Validação e montagem: Creation Date
    "-----------------------------------------------------------------------
    IF lv_param-creation_low IS NOT INITIAL OR lv_param-creation_high IS NOT INITIAL.

      " Só high preenchido sem low
      IF lv_param-creation_low IS INITIAL AND lv_param-creation_high IS NOT INITIAL.
        APPEND VALUE #( %action-sendintegration = if_abap_behv=>mk-on
        ) TO failed-/pyxs/sovos_fiscaldocuments.
        APPEND VALUE #(
          %msg = new_message( id       = '/PYXS/SOVOS_TAXFIS'   " sua message class
                              number   = '004'           " número da mensagem
                              severity = if_abap_behv_message=>severity-error
                              )
          %action-sendintegration = if_abap_behv=>mk-on
        ) TO reported-/pyxs/sovos_fiscaldocuments.
      ENDIF.

      " Low maior que High
      IF lv_param-creation_high IS NOT INITIAL AND
         lv_param-creation_low > lv_param-creation_high.
        APPEND VALUE #( %action-sendintegration = if_abap_behv=>mk-on
        ) TO failed-/pyxs/sovos_fiscaldocuments.
        APPEND VALUE #(
          %msg = new_message( id       = '/PYXS/SOVOS_TAXFIS'   " sua message class
                              number   = '003'           " número da mensagem
                              severity = if_abap_behv_message=>severity-error
                              )
          %action-sendintegration = if_abap_behv=>mk-on
        ) TO reported-/pyxs/sovos_fiscaldocuments.
      ENDIF.

      " Só low → EQ; ambos → BT
      IF lv_param-creation_high IS INITIAL.
        lcl_process=>sel-creation = VALUE #( ( sign = 'I' option = 'EQ'
                                               low  = lv_param-creation_low ) ).
      ELSE.
        lcl_process=>sel-creation = VALUE #( ( sign = 'I' option = 'BT'
                                               low  = lv_param-creation_low
                                               high = lv_param-creation_high ) ).
      ENDIF.

    ENDIF.

    "-----------------------------------------------------------------------
    " Validação e montagem: Posting Date
    "-----------------------------------------------------------------------
    IF lv_param-posting_low IS NOT INITIAL OR lv_param-posting_high IS NOT INITIAL.

      IF lv_param-posting_low IS INITIAL AND lv_param-posting_high IS NOT INITIAL.
        APPEND VALUE #( %action-sendintegration = if_abap_behv=>mk-on
        ) TO failed-/pyxs/sovos_fiscaldocuments.
        APPEND VALUE #(
          %msg = new_message( id       = '/PYXS/SOVOS_TAXFIS'   " sua message class
                              number   = '002'           " número da mensagem
                              severity = if_abap_behv_message=>severity-error
                              )
          %action-sendintegration = if_abap_behv=>mk-on
        ) TO reported-/pyxs/sovos_fiscaldocuments.
      ENDIF.

      IF lv_param-posting_high IS NOT INITIAL AND
         lv_param-posting_low > lv_param-posting_high.
        APPEND VALUE #( %action-sendintegration = if_abap_behv=>mk-on
        ) TO failed-/pyxs/sovos_fiscaldocuments.
        APPEND VALUE #(
          %msg = new_message( id       = '/PYXS/SOVOS_TAXFIS'   " sua message class
                              number   = '001'           " número da mensagem
                              severity = if_abap_behv_message=>severity-error
                              )
          %action-sendintegration = if_abap_behv=>mk-on
        ) TO reported-/pyxs/sovos_fiscaldocuments.
      ENDIF.

      IF lv_param-posting_high IS INITIAL.
        lcl_process=>sel-posting = VALUE #( ( sign = 'I' option = 'EQ'
                                              low  = lv_param-posting_low ) ).
      ELSE.
        lcl_process=>sel-posting = VALUE #( ( sign = 'I' option = 'BT'
                                              low  = lv_param-posting_low
                                              high = lv_param-posting_high ) ).
      ENDIF.

    ENDIF.

    "-----------------------------------------------------------------------
    " Document e NFType
    "-----------------------------------------------------------------------
    IF lv_param-document IS NOT INITIAL.
      lcl_process=>sel-document = VALUE #( ( sign = 'I' option = 'EQ'
                                             low = lv_param-document ) ).
    ENDIF.

    IF lv_param-nftype IS NOT INITIAL.
      lcl_process=>sel-nftype = VALUE #( ( sign = 'I' option = 'EQ'
                                           low = lv_param-nftype ) ).
    ENDIF.

    CHECK failed-/pyxs/sovos_fiscaldocuments IS INITIAL.

    lcl_process=>read_nf_db(  ).
    lcl_process=>new_out(  ).
    lcl_process=>nfse_out(  ).
    lcl_process=>send_integration( ).

    APPEND INITIAL LINE TO reported-/pyxs/sovos_fiscaldocuments ASSIGNING FIELD-SYMBOL(<fs>).
    <fs>-%cid = key-%cid.
    <fs>-%msg = new_message_with_text(
                  severity = if_abap_behv_message=>severity-information
                  text     = 'Processamento solicitado'
                ).

    res = VALUE #( FOR log IN /pyxs/bp_sovos_fiscaldocuments=>lt_log (
        %cid =  key-%cid
        %param = VALUE #( %data = VALUE
            #(
            brnotafiscal = log-br_notafiscal
            id = log-id
            response = log-response
            returncode = log-returncode
            returnreason = log-returnreason
            timedate = log-timedate
             ) )
        )  ).

  ENDMETHOD.



ENDCLASS.