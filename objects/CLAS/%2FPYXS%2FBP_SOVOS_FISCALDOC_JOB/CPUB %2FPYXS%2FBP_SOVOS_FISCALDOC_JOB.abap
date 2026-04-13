CLASS /pyxs/bp_sovos_fiscaldoc_job DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_apj_dt_exec_object.
    INTERFACES if_apj_rt_exec_object.
    INTERFACES if_oo_adt_classrun.

    DATA: go_log  TYPE REF TO if_bali_log.
