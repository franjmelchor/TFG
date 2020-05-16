alter table students_190401_filtrado_personas add column duracion_studio smallint;
alter table students_190401_filtrado_personas add column edad_fin smallint;
alter table students_190401_filtrado_personas add column fecha_fin text;
alter table students_190401_filtrado_personas add column fecha_inicio text;
update students_190401_filtrado_personas set fecha_fin = curso_fin;
update students_190401_filtrado_personas set fecha_inicio = curso_inicio
update students_190401_filtrado_personas set fecha_inicio = substring(curso_inicio,1,4);
update students_190401_filtrado_personas set fecha_fin = substring(curso_fin,1,4);
update students_190401_filtrado_personas set fecha_inicio = (to_date(fecha_inicio,'YYY'));
update students_190401_filtrado_personas set fecha_inicio = (to_date(( substring(curso_inicio,1,4)),'YYY'));
alter table students_190401_filtrado_personas alter column fecha_inicio type date using fecha_inicio::date;
alter table students_190401_filtrado_personas alter column fecha_fin type date using fecha_fin::date;
update students_190401_filtrado_personas set fecha_inicio = fecha_inicio + interval '1 month' * 8;
update students_190401_filtrado_personas set fecha_fin = fecha_fin + interval '1 month' * 7;
alter table students_190401_filtrado_personas alter column fnac type date using fnac::date; 
update students_190401_filtrado_personas set edad_fin = DATE_PART('year', fecha_fin::date) - DATE_PART('year', fnac::date);
alter table students_190401_filtrado_personas drop column curso_fin;
alter table students_190401_filtrado_personas drop column curso_inicio;
update students_190401_filtrado_personas set duracion_studio = DATE_PART('year', fecha_fin::date) - DATE_PART('year', fecha_inicio::date);
update students_190401_filtrado_personas set duracion_studio = (duracion_studio + 1) where duracion_studio=0;
alter table students_190401_filtrado_personas alter column id type integer using id::integer; 
alter table students_190401_filtrado_personas alter column num_estudios type smallint using num_estudios::smallint; 
update students_190401_filtrado_personas set sexo = 'H' where sexo = 'Hombre';
update students_190401_filtrado_personas set sexo = 'M' where sexo = 'Mujer';
alter table students_190401_filtrado_personas alter column sexo type char using sexo::char; 
update students_190401_filtrado_personas set num_estudios = (num_estudios - 1) where dni in (select DISTINCT dni from students_190401_filtrado_personas
																						  where titulacion like '%PCEO%');
delete from students_190401_filtrado_personas where dni = 'ed7eff60a2a9812bc743d81398c8765ac658a707be84e5dfc3e74514b01fc069f706b7158cbbf6389d1768aebf69ba473ed6c508031ab830954b9cae6a298591';
update students_190401_filtrado_personas p set fnac = (select fnac
														from persons
														where dni=p.dni
													  limit 1);
alter table dv_uex_190401_filtrado_personas add column total smallint;
update dv_uex_190401_filtrado_personas set total = 1;
delete from dv_uex_190401_filtrado_personas where edad_fin < 20;
