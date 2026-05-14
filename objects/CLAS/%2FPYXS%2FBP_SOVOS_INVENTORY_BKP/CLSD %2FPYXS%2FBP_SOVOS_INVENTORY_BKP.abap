class-pool .
*"* class pool for class /PYXS/BP_SOVOS_INVENTORY_BKP

*"* local type definitions
include /PYXS/BP_SOVOS_INVENTORY_BKP==ccdef.

*"* class /PYXS/BP_SOVOS_INVENTORY_BKP definition
*"* public declarations
  include /PYXS/BP_SOVOS_INVENTORY_BKP==cu.
*"* protected declarations
  include /PYXS/BP_SOVOS_INVENTORY_BKP==co.
*"* private declarations
  include /PYXS/BP_SOVOS_INVENTORY_BKP==ci.
endclass. "/PYXS/BP_SOVOS_INVENTORY_BKP definition

*"* macro definitions
include /PYXS/BP_SOVOS_INVENTORY_BKP==ccmac.
*"* local class implementation
include /PYXS/BP_SOVOS_INVENTORY_BKP==ccimp.

*"* test class
include /PYXS/BP_SOVOS_INVENTORY_BKP==ccau.

class /PYXS/BP_SOVOS_INVENTORY_BKP implementation.
*"* method's implementations
  include methods.
endclass. "/PYXS/BP_SOVOS_INVENTORY_BKP implementation
