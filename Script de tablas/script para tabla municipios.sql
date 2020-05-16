delete from municipios_180919 where comunidad like '%comunidad%'
alter table municipios_180919 alter column latitud type numeric using latitud::numeric;
alter table municipios_180919 alter column longitud type numeric using longitud::numeric;
alter table municipios_180919 alter column altitud type numeric using altitud::numeric;
alter table municipios_180919 alter column habitantes type integer using habitantes::integer;
alter table municipios_180919 alter column prov_cod type integer using prov_cod::integer;
alter table municipios_180919 alter column loc_cod type integer using loc_cod::integer;
alter table municipios_180919 alter column codigo_completo type integer using codigo_completo::integer;

