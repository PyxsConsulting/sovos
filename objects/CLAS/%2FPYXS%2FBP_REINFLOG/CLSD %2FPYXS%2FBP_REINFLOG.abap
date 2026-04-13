class-pool .
*"* class pool for class /PYXS/BP_REINFLOG

*"* local type definitions
include /PYXS/BP_REINFLOG=============ccdef.

*"* class /PYXS/BP_REINFLOG definition
*"* public declarations
  include /PYXS/BP_REINFLOG=============cu.
*"* protected declarations
  include /PYXS/BP_REINFLOG=============co.
*"* private declarations
  include /PYXS/BP_REINFLOG=============ci.
endclass. "/PYXS/BP_REINFLOG definition

*"* macro definitions
include /PYXS/BP_REINFLOG=============ccmac.
*"* local class implementation
include /PYXS/BP_REINFLOG=============ccimp.

*"* test class
include /PYXS/BP_REINFLOG=============ccau.

class /PYXS/BP_REINFLOG implementation.
*"* method's implementations
  include methods.
endclass. "/PYXS/BP_REINFLOG implementation
