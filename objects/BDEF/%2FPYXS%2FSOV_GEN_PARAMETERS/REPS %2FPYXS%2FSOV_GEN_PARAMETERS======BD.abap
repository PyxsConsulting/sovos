managed implementation in class /pyxs/bp_sov_gen_parameters unique;
strict ( 2 );
with draft;

define behavior for /PYXS/SOV_GEN_PARAMETERS //alias <alias_name>
persistent table /pyxs/sov_params
draft table /pyxs/sov_para_d
lock master
total etag Active
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

  field ( readonly : update ) Pcode;
  field ( readonly ) Descr;

  determination setDescr on modify { create; field Pcode; }

  mapping for /pyxs/sov_params
    {
      Pcode = pcode;
      Descr = descr;
      Value = value;
      Active = active;
    }
}