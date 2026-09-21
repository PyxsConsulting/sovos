INTERFACE /pyxs/sov_fiscal_badinterf
  PUBLIC .

  INTERFACES if_badi_interface .

  TYPES:

    ty_t_out TYPE TABLE OF /pyxs/sovos_types=>ty_main,
    company  TYPE i_br_businessplace-companycode,
    branch   TYPE i_br_businessplace-branch,
    creation TYPE RANGE OF i_br_nfdocument-creationdate,
    posting  TYPE RANGE OF i_br_nfdocument-br_nfpostingdate,
    document TYPE RANGE OF i_br_nfdocument-br_notafiscal,
    nftype   TYPE RANGE OF i_br_nfdocument-br_nftype.

  METHODS before_process
    IMPORTING

      iv_company       TYPE company   OPTIONAL
      iv_branch        TYPE branch    OPTIONAL
      iv_document      TYPE document  OPTIONAL
      iv_creation      TYPE creation  OPTIONAL
      iv_posting       TYPE posting   OPTIONAL
      iv_nftype        TYPE nftype    OPTIONAL

    CHANGING
      t_out TYPE ty_t_out.

ENDINTERFACE.