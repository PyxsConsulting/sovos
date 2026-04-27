  METHOD last_day_of_months.

    DATA: januar(2)   VALUE '01',
          december(2) VALUE '12',
          lowdate(4)  VALUE '1800',
          frist(2)    VALUE '01'.
    DATA: BEGIN OF highdate,
            j(4) VALUE '9999',
            m(2) VALUE '12',
            t(2) VALUE '31',
          END OF highdate.
    DATA: BEGIN OF date,
            j(4) TYPE n,
            m(2) TYPE n,
            t(2) TYPE n,
          END OF date.
    DATA: zahl TYPE i.

    date = day_in.

    IF date-m LT januar OR date-m GT december.            "#EC PORTABLE
      last_day_of_month = 0.
    ENDIF.

    IF date-j LT lowdate.                                 "#EC PORTABLE
      last_day_of_month = 0.
    ENDIF.

    IF date-j EQ highdate-j AND                             "VNIK001140
       date-m EQ highdate-m.                                "VNIK001140
      last_day_of_month = highdate.                         "VNIK001140

    ELSE.                                                   "VNIK001140

      IF date-m EQ december.
        date-j += 1.
        date-m = frist.
      ELSE.
        date-m += 1.
      ENDIF.
* Erster des Folgemonats
      date-t = frist.
      last_day_of_month = date.
      last_day_of_month -= 1.

    ENDIF.
  ENDMETHOD.