class-pool .
*"* class pool for class /PYXS/BP_SOV_ITENS_PRODUZ_LOG

*"* local type definitions
include /PYXS/BP_SOV_ITENS_PRODUZ_LOG=ccdef.

*"* class /PYXS/BP_SOV_ITENS_PRODUZ_LOG definition
*"* public declarations
  include /PYXS/BP_SOV_ITENS_PRODUZ_LOG=cu.
*"* protected declarations
  include /PYXS/BP_SOV_ITENS_PRODUZ_LOG=co.
*"* private declarations
  include /PYXS/BP_SOV_ITENS_PRODUZ_LOG=ci.
endclass. "/PYXS/BP_SOV_ITENS_PRODUZ_LOG definition

*"* macro definitions
include /PYXS/BP_SOV_ITENS_PRODUZ_LOG=ccmac.
*"* local class implementation
include /PYXS/BP_SOV_ITENS_PRODUZ_LOG=ccimp.

*"* test class
include /PYXS/BP_SOV_ITENS_PRODUZ_LOG=ccau.

class /PYXS/BP_SOV_ITENS_PRODUZ_LOG implementation.
*"* method's implementations
  include methods.
endclass. "/PYXS/BP_SOV_ITENS_PRODUZ_LOG implementation
