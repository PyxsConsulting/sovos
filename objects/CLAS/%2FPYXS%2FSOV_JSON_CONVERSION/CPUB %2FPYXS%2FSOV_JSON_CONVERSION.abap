CLASS /pyxs/sov_json_conversion DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS:
      convert_json
        IMPORTING
          json       TYPE string
        RETURNING
          VALUE(ret) TYPE string,

      convert_sovos
        IMPORTING
          json       TYPE string
        RETURNING
          VALUE(ret) TYPE string,
      add_integer_mask IMPORTING e_string        TYPE string
                       RETURNING VALUE(r_string) TYPE string,
      add_number_dec_mask IMPORTING e_string        TYPE string
                          RETURNING VALUE(r_string) TYPE string,
      last_day_of_months
        IMPORTING day_in                   TYPE datum
        RETURNING VALUE(last_day_of_month) TYPE datum.