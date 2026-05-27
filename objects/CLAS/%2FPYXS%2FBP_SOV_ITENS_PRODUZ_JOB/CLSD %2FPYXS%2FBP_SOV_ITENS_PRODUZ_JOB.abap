class-pool .
*"* class pool for class /PYXS/BP_SOV_ITENS_PRODUZ_JOB

*"* local type definitions
include /PYXS/BP_SOV_ITENS_PRODUZ_JOB=ccdef.

*"* class /PYXS/BP_SOV_ITENS_PRODUZ_JOB definition
*"* public declarations
  include /PYXS/BP_SOV_ITENS_PRODUZ_JOB=cu.
*"* protected declarations
  include /PYXS/BP_SOV_ITENS_PRODUZ_JOB=co.
*"* private declarations
  include /PYXS/BP_SOV_ITENS_PRODUZ_JOB=ci.
endclass. "/PYXS/BP_SOV_ITENS_PRODUZ_JOB definition

*"* macro definitions
include /PYXS/BP_SOV_ITENS_PRODUZ_JOB=ccmac.
*"* local class implementation
include /PYXS/BP_SOV_ITENS_PRODUZ_JOB=ccimp.

*"* test class
include /PYXS/BP_SOV_ITENS_PRODUZ_JOB=ccau.

class /PYXS/BP_SOV_ITENS_PRODUZ_JOB implementation.
*"* method's implementations
  include methods.
endclass. "/PYXS/BP_SOV_ITENS_PRODUZ_JOB implementation
