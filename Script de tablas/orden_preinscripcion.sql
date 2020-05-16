select distinct orden_preinscripcion from dv_uex_190401_filtrado_personas;
select distinct tipo_studio from dv_uex_190401_filtrado_personas;
select count (*) from dv_uex_190401_filtrado_personas where  tipo_studio like '%Grado%';
select count (*) from dv_uex_190401_filtrado_personas where orden_preinscripcion like '%No disponible%' and tipo_studio like '%Grado%';