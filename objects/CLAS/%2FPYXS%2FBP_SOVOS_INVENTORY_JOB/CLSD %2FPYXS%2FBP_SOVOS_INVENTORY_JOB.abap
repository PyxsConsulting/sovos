class-pool .
*"* class pool for class /PYXS/BP_SOVOS_INVENTORY_JOB

*"* local type definitions
include /PYXS/BP_SOVOS_INVENTORY_JOB==ccdef.

*"* class /PYXS/BP_SOVOS_INVENTORY_JOB definition
*"* public declarations
  include /PYXS/BP_SOVOS_INVENTORY_JOB==cu.
*"* protected declarations
  include /PYXS/BP_SOVOS_INVENTORY_JOB==co.
*"* private declarations
  include /PYXS/BP_SOVOS_INVENTORY_JOB==ci.
endclass. "/PYXS/BP_SOVOS_INVENTORY_JOB definition

*"* macro definitions
include /PYXS/BP_SOVOS_INVENTORY_JOB==ccmac.
*"* local class implementation
include /PYXS/BP_SOVOS_INVENTORY_JOB==ccimp.

*"* test class
include /PYXS/BP_SOVOS_INVENTORY_JOB==ccau.

class /PYXS/BP_SOVOS_INVENTORY_JOB implementation.
*"* method's implementations
  include methods.
endclass. "/PYXS/BP_SOVOS_INVENTORY_JOB implementation
