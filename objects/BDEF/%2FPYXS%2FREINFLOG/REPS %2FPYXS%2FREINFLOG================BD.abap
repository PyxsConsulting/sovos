unmanaged implementation in class /pyxs/bp_reinflog unique;
strict ( 2 );

define behavior for /PYXS/ReinfLog //alias <alias_name>
//persistent table /pyxs/sov_reinf
lock master
authorization master ( instance )
//etag master <field_name>
{
  internal create;
  internal update;
  internal delete;
  field ( readonly ) AnoMes, Partner, Evento;
  mapping for /pyxs/sov_reinf
  {
   AnoMes = ano_mes;
   Evento = evento;
   Partner = partner;
   Resultado = resultado;
   Retorno = retorno;
  }
  static action SendIntegration parameter /PYXS/SOVOS_REINFParameter result [1] $self;
}