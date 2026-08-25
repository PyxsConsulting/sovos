managed implementation in class /pyxs/bp_sov_acctype unique;
strict ( 2 );
with draft;

define behavior for /PYXS/SOV_ACCTYPE //alias <alias_name>
persistent table /pyxs/sov_acctyp
draft table /pyxs/sov_acct_d
lock master
total etag Accprefix
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
  {}

  field ( readonly : update ) Accprefix;

  mapping for /pyxs/sov_acctyp
    {
      Accprefix = accprefix;
      Codigoacc = codigoacc;
    }
}