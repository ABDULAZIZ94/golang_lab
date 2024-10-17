select dp.device_pair_id, dp.toilet_info_id, ti.toilet_name, d.device_name, d.device_token, d.device_id
from
    device_pairs as dp
    join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
    join devices as d on dp.device_id = d.device_id
where
    d.tenant_id = '59944171-3a4a-460d-5897-8bb38c524d54'AND 
    ti.location_id = '964cd0a5-8620-4a24-67af-578da8c3b6df'



select * from cleaner_reports


select current_timestamp as LAST_UPDATE