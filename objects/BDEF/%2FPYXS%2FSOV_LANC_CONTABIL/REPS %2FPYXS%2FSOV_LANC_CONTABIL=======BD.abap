unmanaged implementation in class /pyxs/bp_sov_lanc_contabil unique;
strict ( 2 );

define behavior for /PYXS/SOV_LANC_CONTABIL //alias <alias_name>
//persistent table /pyxs/sov_conlog
lock master
authorization master ( instance )
//etag master <field_name>
{
  internal create;
  internal update;
  internal delete;
  field ( readonly ) Timedate, Lancamento, Id;

  static action SendIntegration deep parameter /PYXS/A_LANC_CONTABIL result [0..*] $self;
}