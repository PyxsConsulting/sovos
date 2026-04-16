managed implementation in class /pyxs/bp_sovos_naturezarendime unique;
strict ( 2 );
with draft;
define behavior for /PYXS/SOVOS_NaturezaRendimento //alias <alias_name>
persistent table /pyxs/sov_natren
draft table /pyxs/sov_natr_d
lock master total etag Lc116
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

  field ( readonly : update ) Lc116;
  mapping for /pyxs/sov_natren
    {
      Lc116              = lc116;
      NaturezaRendimento = nat_res;
    }
}