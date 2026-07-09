unmanaged implementation in class /pyxs/bp_sov_plano_contas unique;
strict ( 2 );

define behavior for /PYXS/SOV_PLANO_CONTAS //alias <alias_name>
//persistent table /pyxs/sov_placon
lock master
authorization master ( instance )
//etag master <field_name>
{
  internal create;
  internal update;
  internal delete;
  field ( readonly ) Timedate, Chartofacc, Id;

  static action SendIntegration deep parameter /PYXS/A_PLANO_CONTAS result [0..*] $self;

}