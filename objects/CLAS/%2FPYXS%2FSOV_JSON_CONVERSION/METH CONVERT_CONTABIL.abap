METHOD convert_contabil.

  DATA(rv_json) = json.

  REPLACE ALL OCCURRENCES OF '"KNW_SCTB_I200"'            IN rv_json WITH '"knwSctbI200"'.
  REPLACE ALL OCCURRENCES OF '"KNW0500"'    IN rv_json WITH '"knw0500"'.
  REPLACE ALL OCCURRENCES OF '"KNW_SCTB_I250"' IN rv_json WITH '"knwSctbI250"'.
  REPLACE ALL OCCURRENCES OF '"OBJETOS"' IN rv_json WITH '"objetos"'.

  REPLACE ALL OCCURRENCES OF ' "' IN rv_json WITH '"'.

  ret = rv_json.



ENDMETHOD.