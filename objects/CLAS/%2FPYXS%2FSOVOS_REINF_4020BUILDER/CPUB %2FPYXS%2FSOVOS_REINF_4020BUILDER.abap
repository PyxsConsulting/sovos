CLASS /pyxs/sovos_reinf_4020builder DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: ty_reinf TYPE STANDARD TABLE OF /pyxs/sov_reinf WITH DEFAULT KEY.

    METHODS:
      constructor
        IMPORTING
          iv_br_notafiscal  TYPE i_br_nfdocument-br_notafiscal OPTIONAL
          iv_date_begin     TYPE d OPTIONAL
          iv_date_end       TYPE d OPTIONAL
          iv_company_doce   TYPE bukrs
          iv_business_place TYPE char4,

      build_r4020
        RETURNING VALUE(rv_json) TYPE string,

      build_r2010
        RETURNING VALUE(rv_json) TYPE string,

      build_r1000
        RETURNING VALUE(rv_json) TYPE string,

      format_date
        IMPORTING
          iv_date        TYPE d
          iv_with_time   TYPE abap_bool DEFAULT abap_false
        RETURNING
          VALUE(rv_date) TYPE string,

      clean_cnpj
        IMPORTING
          iv_cnpj        TYPE string
        RETURNING
          VALUE(rv_cnpj) TYPE string,

      format_amount
        IMPORTING
          iv_value        TYPE any
        RETURNING
          VALUE(rv_value) TYPE string,

      get_return
        RETURNING VALUE(et_process) TYPE ty_reinf.

