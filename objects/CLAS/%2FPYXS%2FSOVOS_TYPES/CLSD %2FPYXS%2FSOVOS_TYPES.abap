class-pool .
*"* class pool for class /PYXS/SOVOS_TYPES

*"* local type definitions
include /PYXS/SOVOS_TYPES=============ccdef.

*"* class /PYXS/SOVOS_TYPES definition
*"* public declarations
  include /PYXS/SOVOS_TYPES=============cu.
*"* protected declarations
  include /PYXS/SOVOS_TYPES=============co.
*"* private declarations
  include /PYXS/SOVOS_TYPES=============ci.
endclass. "/PYXS/SOVOS_TYPES definition

*"* macro definitions
include /PYXS/SOVOS_TYPES=============ccmac.
*"* local class implementation
include /PYXS/SOVOS_TYPES=============ccimp.

*"* test class
include /PYXS/SOVOS_TYPES=============ccau.

class /PYXS/SOVOS_TYPES implementation.
*"* method's implementations
  include methods.
endclass. "/PYXS/SOVOS_TYPES implementation
