

select * from device_pairs

alter table device_pairs add column cubical_id text


-- get list of toilets
Select toilet_infos.*, toilet_types.toilet_type_name
from toilet_infos
JOIN toilet_types ON toilet_types.toilet_type_id = toilet_infos.toilet_type_id
where toilet_infos.tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'


-- get list of devices on each toilet
Select device_pairs.*,devices.device_id ,devices.device_name , devices.device_token,device_types.device_type_name as device_type,device_types.device_type_id
from device_pairs
JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID
JOIN device_types ON device_types.device_type_id = devices.device_type_id
Where device_pairs.toilet_info_id = '9388096c-784d-49c8-784c-1868b1233165' --kemaman male -- v.ToiletInfoID


select ci.cubical_id, ci.cubical_name from cubical_infos ci
join cubical_pairs cp on ci.cubical_id = cp.cubical_id
where cp.toilet_info_id = '9388096c-784d-49c8-784c-1868b1233165' --kemaman male