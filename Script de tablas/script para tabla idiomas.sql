delete from dv_idiomas_190411 where ano_estudio='ano_estudio';
alter table dv_idiomas_190411 alter column id type integer using id::integer;
alter table dv_idiomas_190411 alter column ano_estudio type integer using ano_estudio::integer;
delete from dv_idiomas_190411 where dni not in (select dni from dv_personas_190411);
