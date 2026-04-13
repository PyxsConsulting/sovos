unmanaged implementation in class /pyxs/bp_sovos_fiscaldocuments unique;
strict ( 2 );

define behavior for /PYXS/SOVOS_FiscalDocuments //alias <alias_name>
//late numbering
lock master
authorization master ( instance )
//etag master <field_name>
{
  internal create;
  internal update;
  internal delete;
  field ( readonly ) Timedate, BrNotafiscal, Id;

  static action SendIntegration deep parameter /PYXS/A_FiscalDocuments result [0..*] $self;


}