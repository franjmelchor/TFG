UPDATE  dv_historial_contratos_190411 set cod_tipo = 0 where cod_tipo LIKE '%GENERAL%';
UPDATE  dv_historial_contratos_190411 set cod_tipo = -1 where cod_tipo LIKE '%AUTONOMO%';

UPDATE  dv_historial_contratos_190411 set cno_cod = 0 where cod_tipo LIKE '%GENERAL%';
UPDATE  dv_historial_contratos_190411 set cno_cod = -1 where cod_tipo LIKE '%AUTONOMO%';

alter table dv_historial_contratos_190411 alter column cod_tipo type integer using cod_tipo::integer; 
alter table dv_historial_contratos_190411 alter column fecha_inicio type date using fecha_inicio::date; 

alter table dv_historial_contratos_190411 alter column fecha_fin type date using fecha_fin::date; 
alter table dv_historial_contratos_190411 alter column cno_cod type integer using cno_cod::integer; 
alter table dv_historial_contratos_190411 alter column actividad_economica_cod type integer using actividad_economica_cod::integer; 
alter table dv_historial_contratos_190411 alter column localidad_cod type integer using localidad_cod::integer; 
alter table dv_historial_contratos_190411 alter column id type integer using id::integer; 
alter table dv_historial_contratos_190411 alter column duracion_contrato_dias type integer using duracion_contrato_dias::integer; 
alter table dv_historial_contratos_190411 add column total integer;
update dv_historial_contratos_190411 set total = 1;
alter table dv_historial_contratos_190411 alter column estudios type boolean using estudios::boolean; 
alter table dv_historial_contratos_190411 alter column edad_inicio_contrato type smallint using edad_inicio_contrato::smallint; 

alter table dv_historial_contratos_190411 add column duracion_contrato_dias integer;

alter table dv_historial_contratos_190411 add column edad_inicio_contrato smallint;
update dv_historial_contratos_190411 c set edad_inicio_contrato = DATE_PART ('year',fecha_inicio::DATE) - DATE_PART ('year',(select fnac
																															from dv_personas_190411
																															where dni = c.dni)::DATE) ;
UPDATE dv_historial_contratos_190411 J
SET CNO_DESC = (SELECT CNO_DESC 
				FROM dv_historial_contratos_190411 C
			   	WHERE C.CNO_COD = J.CNO_COD AND CNO_DESC IS NOT NULL
			   	LIMIT 1)
WHERE CNO_DESC IS NULL;

update dv_historial_contratos_190411 set duracion_contrato_dias = 1 where duracion_contrato_dias = 0;
