

-- each query
with device_list as (select d.device_token, d.device_type_id
from
    device_pairs as dp
    join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
    join devices as d on dp.device_id = d.device_id
where
    dp.toilet_info_id = '9388096c-784d-49c8-784c-1868b1233165'
    and device_type_id in(11, 10))
select panic_button, smoke_sensor, p_ts, s_ts
from device_list
join
(select panic_button,timestamp as p_ts from panic_btn_data where device_token=
 (select device_token from device_list where device_type_id = 11 limit 1) order by timestamp desc limit 1)Q1 ON TRUE
--  using (device_token)
join
(select smoke_sensor, timestamp as s_ts from smoke_data where device_token=
(select device_token from device_list where device_type_id = 10 limit 1) order by timestamp desc limit 1)Q2 ON TRUE
-- using(device_token)
limit 1



-- fail
with device_list as (select dp.device_pair_id, dp.toilet_info_id, ti.toilet_name, d.device_name, d.device_token, d.device_id, d.device_type_id
from
    device_pairs as dp
    join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
    join devices as d on dp.device_id = d.device_id
where
    dp.toilet_info_id = '9388096c-784d-49c8-784c-1868b1233165')
select panic_button, smoke_sensor from
(select panic_button from panic_btn_data 
 where device_token = (select device_token from device_list where device_type_id = 11 limit 1) order by timestamp desc)Q1
cross join
(select smoke_sensor from smoke_data where device_token=(select device_token from device_list where device_type_id = 10 limit 1) order by timestamp desc)Q2