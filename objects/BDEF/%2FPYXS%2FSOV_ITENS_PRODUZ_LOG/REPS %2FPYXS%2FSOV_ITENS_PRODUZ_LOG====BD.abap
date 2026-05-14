unmanaged implementation in class /pyxs/bp_sov_itens_produz_log unique;
strict ( 2 );

define behavior for /PYXS/SOV_ITENS_PRODUZ_LOG //alias <alias_name>
//late numbering
lock master
authorization master ( instance )
//etag master <field_name>
{
  internal create;
  internal update;
  internal delete;
  field ( readonly ) Plant, Timedate, Anomes, Id;

  static action SendIntegration deep parameter /PYXS/A_ITM_PRODUZ result [0..*] $self;
}