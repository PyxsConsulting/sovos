class-pool .
*"* class pool for class /PYXS/BP_SOVOS_YEAR_INVEN_JOB

*"* local type definitions
include /PYXS/BP_SOVOS_YEAR_INVEN_JOB=ccdef.

*"* class /PYXS/BP_SOVOS_YEAR_INVEN_JOB definition
*"* public declarations
  include /PYXS/BP_SOVOS_YEAR_INVEN_JOB=cu.
*"* protected declarations
  include /PYXS/BP_SOVOS_YEAR_INVEN_JOB=co.
*"* private declarations
  include /PYXS/BP_SOVOS_YEAR_INVEN_JOB=ci.
endclass. "/PYXS/BP_SOVOS_YEAR_INVEN_JOB definition

*"* macro definitions
include /PYXS/BP_SOVOS_YEAR_INVEN_JOB=ccmac.
*"* local class implementation
include /PYXS/BP_SOVOS_YEAR_INVEN_JOB=ccimp.

*"* test class
include /PYXS/BP_SOVOS_YEAR_INVEN_JOB=ccau.

class /PYXS/BP_SOVOS_YEAR_INVEN_JOB implementation.
*"* method's implementations
  include methods.
endclass. "/PYXS/BP_SOVOS_YEAR_INVEN_JOB implementation
