unmanaged implementation in class /pyxs/bp_sov_reinf_inss unique;
strict ( 2 );

define behavior for /PYXS/SOV_REINF_INSS //alias <alias_name>
//persistent table /pyxs/sov_reinss
lock master
authorization master ( instance )
//etag master <field_name>
{
  internal create;
  internal update;
  internal delete;
  field ( readonly ) AnoMes, Partner, Evento;
  mapping for /pyxs/sov_reinss
  {
   AnoMes = ano_mes;
   Evento = evento;
   Partner = partner;
   Resultado = resultado;
   Retorno = retorno;
  }
  static action SendIntegration parameter /PYXS/SOV_REINF_INSS_PARAMS result [1] $self;
}