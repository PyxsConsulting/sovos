managed implementation in class /pyxs/bp_sovos_codigoreinf unique;
strict ( 2 );
with draft;
define behavior for /PYXS/SOVOS_CODIGOREINF //alias <alias_name>
persistent table /pyxs/sov_cdrein
draft table /pyxs/sov_cdre_d
lock master total etag material
authorization master ( instance )
//etag master <field_name>
{
  create ( authorization : global );
  update;
  delete;

  draft action Activate optimized;
  draft action Discard;
  draft action Edit;
  draft action Resume;
  draft determine action Prepare
  {
  }

  field ( readonly : update ) material;
  mapping for /pyxs/sov_cdrein
    {
      material = material;
      codreinf = codreinf;
    }
}