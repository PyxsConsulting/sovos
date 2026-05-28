unmanaged implementation in class /pyxs/bp_sovos_year_inventory unique;
strict ( 2 );

define behavior for /PYXS/SOVOS_YEAR_INVENTORY //alias <alias_name>
//persistent table /pyxs/sov_yr_inv
lock master
authorization master ( instance )
//etag master <field_name>
{
  internal create;
  internal update;
  internal delete;
  field ( readonly ) Timedate, Anomes, Id;

  static action SendIntegration deep parameter /PYXS/A_Inventory result [0..*] $self;
}