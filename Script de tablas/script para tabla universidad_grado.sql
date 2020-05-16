alter table dv_personas_190411_con_estudios_grado add column duracion_studio int;

update dv_personas_190411_con_estudios_grado p
set duracion_studio = (select duracion_studio
					  from dv_uex_190401_filtrado_personas
					  where dni = p.dni
					  order by fecha_inicio
					  limit 1);
update dv_personas_190411_con_estudios_grado p
set duracion_studio = (duracion_studio - 4)
where (SELECT titulacion
	  from dv_uex_190401_filtrado_personas
	  where dni = p.dni
	  order by fecha_inicio
	  limit 1) NOT like '%PCEO%';
update dv_personas_190411_con_estudios_grado p
set duracion_studio = (duracion_studio - 6)
where (SELECT titulacion
	  from dv_uex_190401_filtrado_personas
	  where dni = p.dni
	  order by fecha_inicio
	  limit 1) like '%PCEO%';	  