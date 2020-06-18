alter table dv_personas_190411 alter column id type integer using id::integer;
alter table dv_personas_190411 alter column dias_trabajados type smallint using dias_trabajados::smallint;
alter table dv_personas_190411 alter column num_estudios type smallint using num_estudios::smallint;
alter table dv_personas_190411 alter column edad type smallint using edad::smallint;
alter table dv_personas_190411 alter column fnac type date using fnac::date;
UPDATE dv_personas_190411 set sexo = 'H' WHERE sexo = 'Hombre'
UPDATE dv_personas_190411 set sexo = 'M' WHERE sexo = 'Mujer'
alter table dv_personas_190411 alter column sexo type char using sexo::char;
alter table dv_personas_190411 add column idiomas bool;
alter table dv_personas_190411 add column erasmus bool;

alter table dv_personas_190411 add column num_erasmus smallint;

DELETE FROM dv_personas_190411 WHERE DNI NOT IN (SELECT DISTINCT DNI FROM dv_uex_190401_filtrado_personas);
UPDATE dv_personas_190411 P SET NUM_ESTUDIOS = (SELECT num_estudios
									from students_190401_filtrado_personas
									where dni = p.dni
									limit 1);
ALTER TABLE dv_personas_190411 ADD COLUMN num_idiomas smallint;
update dv_personas_190411 p set num_erasmus = (select count(*)
											  from dv_erasmus_180108_2005a2012_filtrado_persona
											  where dni=p.dni);
update dv_personas_190411 p set num_idiomas = (select count(*)
											  from dv_idiomas_190411
											  where dni=p.dni);
update dv_personas_190411 set idiomas = true where num_idiomas > 0;
update dv_personas_190411 set idiomas = false where num_idiomas = 0;

update dv_personas_190411 set erasmus = true where num_erasmus > 0;
update dv_personas_190411 set erasmus = false where num_erasmus = 0;

alter table dv_personas_190411 add column total smallint;
update dv_personas_190411 set total = 1;
alter table  dv_personas_190411 add column periodo_días_inicio_trabajar integer;

alter table dv_personas_190411 add column tto_pcto_dias_trabajados numeric;
update dv_personas_190411 p set tto_pcto_dias_trabajados = ((dias_trabajados * 100) / 
														 ('2018-01-23') - 
														(SELECT fecha_fin
														  from dv_uex_190401_filtrado_personas
														  where dni = p.dni
														  order by fecha_fin
														  limit 1)
														   );														  
update dv_personas_190411 p
set periodo_días_inicio_trabajar =  DATE_PART ('day',(SELECT fecha_inicio 
													  FROM dv_historial_contratos_190411
													  WHERE dni = p.dni and fecha_inicio > (SELECT fecha_fin
																						   FROM dv_uex_190401_filtrado_personas
																						   WHERE dni = p.dni
																						   order by fecha_inicio
																						   limit 1)
													  order by fecha_inicio
													  limit 1)) - DATE_PART ('day',(SELECT fecha_fin
																				   FROM dv_uex_190401_filtrado_personas
																				   WHERE dni = p.dni
																				   order by fecha_inicio
																				   limit 1));

alter table dv_personas_190411 add column dias_trabajados_fin_titulacion integer;
alter table dv_personas_190411 add column fecha_fin_primer_estudio DATE;
update dv_personas_190411 p set fecha_fin_primer_estudio = (select fecha_fin
														   from dv_uex_190401_filtrado_personas
														   where dni = p.dni
														   order by fecha_fin
														   LIMIT 1);
update dv_personas_190411 p set dias_trabajados_fin_titulacion = (SELECT SUM (duracion_contrato_dias)
																 FROM dv_historial_contratos_190411_dni
																 where dni = p.dni  and fecha_inicio >= p.fecha_fin_primer_estudio );
												
update dv_personas_190411 p set tto_pcto_dias_trabajados = ((dias_trabajados_fin_titulacion * 100) / 
														 ('2018-01-23') - 
														(SELECT fecha_fin
														  from dv_uex_190401_filtrado_personas
														  where dni = p.dni
														  order by fecha_fin
														  limit 1)
														   );	
update dv_personas_190411 p set tto_pcto_dias_trabajados = ((dias_trabajados_fin_titulacion * 100) / 
														 (('2018-03-31') - (fecha_fin_primer_estudio)));
alter table dv_personas_190411 add column nivel_estudio_padre text;
alter table dv_personas_190411 add column nivel_estudio_madre text;
update dv_personas_190411 p set nivel_estudio_padre= (select nivel_estudio_padre
													 from "NivelEstudioPadres_2017_18"
													 where dni = p.dni
													 limit 1);
													 
update dv_personas_190411 p set nivel_estudio_madre= (select nivel_estudio_madre
													 from "NivelEstudioPadres_2017_18"
													 where dni = p.dni
													 limit 1);
alter table dv_personas_190411 add column edad_fin_primera_titulacion integer;
update dv_personas_190411 set edad_fin_primera_titulacion = DATE_PART('year', fecha_fin_primer_estudio::DATE) - DATE_PART('year', fnac::DATE);
update dv_personas_190411 p set dias_trabajados_sin_solap = (SELECT SUM (duracion_contrato_dias)
																 FROM dv_historial_contratos_190411_dni
																 where dni = p.dni);
alter table "dv_personas_190411_con_Estudios" add column tipo_acceso text;
alter table "dv_personas_190411_con_Estudios" add column orden_preinscripcion int;

UPDATE "dv_personas_190411_con_Estudios" p set tipo_acceso = (SELECT tipo_acceso
															 from dv_uex_190401_filtrado_personas
															 where dni = p.dni 
															 order by fecha_inicio
															 limit 1);
UPDATE "dv_personas_190411_con_Estudios" p set orden_preinscripcion = (SELECT orden_preinscripcion
															 from dv_uex_190401_filtrado_personas
															 where dni = p.dni 
															 order by fecha_inicio
															 limit 1);															 
alter table "dv_personas_190411_con_Estudios" add column tipo_erasmus text;
UPDATE "dv_personas_190411_con_Estudios" set tipo_erasmus = 'Ninguno';

update "dv_personas_190411_con_Estudios" p 
set tipo_erasmus = (SELECT tipo_movilidad
				   FROM dv_erasmus_180108_2005a2012_filtrado_persona
				   WHERE dni = p.dni
				   limit 1);
				   
update "dv_personas_190411_con_Estudios"
set tipo_erasmus = 'Ninguno' where tipo_erasmus is null;	


ALTER TABLE "dv_personas_190411_con_Estudios" 
add column rama_acad text;

ALTER TABLE "dv_personas_190411_con_Estudios" 
add column master BOOLEAN;

ALTER TABLE "dv_personas_190411_con_Estudios" 
add column doctorado BOOLEAN;

update "dv_personas_190411_con_Estudios" p 
set rama_acad = (SELECT rama_acad
				   FROM dv_uex_190401_filtrado_personas
				   WHERE dni = p.dni
				   limit 1);
				  
update "dv_personas_190411_con_Estudios" 
set doctorado = false;

update "dv_personas_190411_con_Estudios" 
set master = false;

update "dv_personas_190411_con_Estudios" 
set master = true
where dni in (select dni
			 from dv_uex_190401_filtrado_personas
			 where tipo_studio = 'Máster Universitario');
			 
update "dv_personas_190411_con_Estudios" 
set doctorado = true
where dni in (select dni
			 from dv_uex_190401_filtrado_personas
			 where tipo_studio = 'Doctorado');														 
															 