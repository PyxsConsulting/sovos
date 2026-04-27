unmanaged implementation in class /pyxs/bp_sovos_inventorylog unique;
strict ( 2 );

define behavior for /PYXS/SOVOS_InventoryLog //alias <alias_name>
//late numbering
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