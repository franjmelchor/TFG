
SELECT * from "NivelEstudioPadres_2017_18";

delete from "NivelEstudioPadres_2017_18" where curso LIKE '%curso%';
alter table "NivelEstudioPadres_2017_18" alter column cod_plan type integer using cod_plan::integer;
alter table "NivelEstudioPadres_2017_18" alter column cod_centro type integer using cod_centro::integer;
delete from "NivelEstudioPadres_2017_18" where dni not in (select distinct dni from dv_uex_190401_filtrado_personas)
