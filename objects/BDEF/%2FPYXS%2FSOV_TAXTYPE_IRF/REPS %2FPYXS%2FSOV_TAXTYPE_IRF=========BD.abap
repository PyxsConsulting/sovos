managed implementation in class /pyxs/bp_sov_taxtype_irf unique;
strict ( 2 );
with draft;

define behavior for /PYXS/SOV_TAXTYPE_IRF //alias <alias_name>
persistent table /pyxs/sov_taxtyp
draft table /pyxs/sov_taxt_d
lock master
total etag CategoriaIrf
authorization master ( instance )
//etag master CategoriaIrf
{
  create ( authorization : global );
  update;
  delete;

  draft action Activate optimized;
  draft action Discard;
  draft action Edit;
  draft action Resume;
  draft determine action Prepare
  {}

  field ( readonly : update ) CategoriaIrf;

  mapping for /pyxs/sov_taxtyp
    {
      CategoriaIrf = categoriairf;
      Imposto = imposto;
    }

  validation validateCategoria on save { create; field CategoriaIrf; }

  validation validateImposto on save { field Imposto; }

}