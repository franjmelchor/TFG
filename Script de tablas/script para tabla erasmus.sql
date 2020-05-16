alter table dv_erasmus_180108_2005a2012_filtrado_persona alter column anos_estudio_previo_erasmus type smallint using anos_estudio_previo_erasmus::smallint; 
alter table dv_erasmus_180108_2005a2012_filtrado_persona alter column estudios_num_creditos_ects type smallint using estudios_num_creditos_ects::smallint; 
alter table dv_erasmus_180108_2005a2012_filtrado_persona alter column practicas_num_creditos_ects type smallint using practicas_num_creditos_ects::smallint  ; 
update dv_erasmus_180108_2005a2012_filtrado_persona e
set estudios_beca = (select replace(dv_erasmus_180108_2005a2012_filtrado_persona.estudios_beca,',','.') 
								from dv_erasmus_180108_2005a2012_filtrado_persona where id = e.id);

update dv_erasmus_180108_2005a2012_filtrado_persona e
set estudios_duracion_meses = (select replace(dv_erasmus_180108_2005a2012_filtrado_persona.estudios_duracion_meses,',','.') 
								from dv_erasmus_180108_2005a2012_filtrado_persona where id = e.id);

update dv_erasmus_180108_2005a2012_filtrado_persona e
set practicas_beca = (select replace(dv_erasmus_180108_2005a2012_filtrado_persona.practicas_beca,',','.') 
								from dv_erasmus_180108_2005a2012_filtrado_persona where id = e.id);
								
alter table dv_erasmus_180108_2005a2012_filtrado_persona alter column estudios_beca type numeric using estudios_beca::numeric  ; 
alter table dv_erasmus_180108_2005a2012_filtrado_persona alter column estudios_duracion_meses type numeric using estudios_duracion_meses::numeric  ; 
alter table dv_erasmus_180108_2005a2012_filtrado_persona alter column practicas_beca type numeric using practicas_beca::numeric  ; 
alter table dv_erasmus_180108_2005a2012_filtrado_persona alter column id type integer using id::integer  ; 
alter table dv_erasmus_180108_2005a2012_filtrado_persona alter column edad type integer using edad::integer  ; 
alter table dv_erasmus_180108_2005a2012_filtrado_persona add column total smallint;
update dv_erasmus_180108_2005a2012_filtrado_persona set total = 1;
delete from dv_erasmus_180108_2005a2012_filtrado_persona where dni not in (select dni from dv_personas_190411);
update dv_erasmus_180108_2005a2012_filtrado_persona set sexo = 'H' where sexo = 'Masculino';
update dv_erasmus_180108_2005a2012_filtrado_persona set sexo = 'M' where sexo = 'Femenino';
alter table dv_erasmus_180108_2005a2012_filtrado_persona drop column institucion_origen;
alter table dv_erasmus_180108_2005a2012_filtrado_persona drop column erasmus_mundus;
alter table dv_erasmus_180108_2005a2012_filtrado_persona drop column eilc_smp_duracion;
update dv_erasmus_180108_2005a2012_filtrado_persona e
set practicas_duracion_meses = (select replace(dv_erasmus_180108_2005a2012_filtrado_persona.practicas_duracion_meses,',','.') 
								from dv_erasmus_180108_2005a2012_filtrado_persona where id = e.id);
alter table dv_erasmus_180108_2005a2012_filtrado_persona alter column practicas_duracion_meses type numeric using practicas_duracion_meses::numeric  ; 
