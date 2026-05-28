class-pool .
*"* class pool for class /PYXS/BP_SOVOS_YEAR_INVENTORY

*"* local type definitions
include /PYXS/BP_SOVOS_YEAR_INVENTORY=ccdef.

*"* class /PYXS/BP_SOVOS_YEAR_INVENTORY definition
*"* public declarations
  include /PYXS/BP_SOVOS_YEAR_INVENTORY=cu.
*"* protected declarations
  include /PYXS/BP_SOVOS_YEAR_INVENTORY=co.
*"* private declarations
  include /PYXS/BP_SOVOS_YEAR_INVENTORY=ci.
endclass. "/PYXS/BP_SOVOS_YEAR_INVENTORY definition

*"* macro definitions
include /PYXS/BP_SOVOS_YEAR_INVENTORY=ccmac.
*"* local class implementation
include /PYXS/BP_SOVOS_YEAR_INVENTORY=ccimp.

*"* test class
include /PYXS/BP_SOVOS_YEAR_INVENTORY=ccau.

class /PYXS/BP_SOVOS_YEAR_INVENTORY implementation.
*"* method's implementations
  include methods.
endclass. "/PYXS/BP_SOVOS_YEAR_INVENTORY implementation
