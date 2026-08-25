class-pool .
*"* class pool for class /PYXS/BP_SOV_ACCTYPE

*"* local type definitions
include /PYXS/BP_SOV_ACCTYPE==========ccdef.

*"* class /PYXS/BP_SOV_ACCTYPE definition
*"* public declarations
  include /PYXS/BP_SOV_ACCTYPE==========cu.
*"* protected declarations
  include /PYXS/BP_SOV_ACCTYPE==========co.
*"* private declarations
  include /PYXS/BP_SOV_ACCTYPE==========ci.
endclass. "/PYXS/BP_SOV_ACCTYPE definition

*"* macro definitions
include /PYXS/BP_SOV_ACCTYPE==========ccmac.
*"* local class implementation
include /PYXS/BP_SOV_ACCTYPE==========ccimp.

*"* test class
include /PYXS/BP_SOV_ACCTYPE==========ccau.

class /PYXS/BP_SOV_ACCTYPE implementation.
*"* method's implementations
  include methods.
endclass. "/PYXS/BP_SOV_ACCTYPE implementation
