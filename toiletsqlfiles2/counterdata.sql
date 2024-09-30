
select * from counter_data

delete from counter_data where timestamp > now()

-- kemaman 103, 104
select * from counter_data where device_token = '103'

select * from counter_data where device_token = '103'  and timestamp between TO_TIMESTAMP( '2024-08-14 07:00:00', 'YYYY-MM-DD HH24:MI:SS' ) and 
TO_TIMESTAMP( '2024-08-14 18:00:00', 'YYYY-MM-DD HH24:MI:SS' )

select 
count(case when people_in = 1 then 1 end) as total_traffic
from counter_data where device_token = '103' and timestamp between TO_TIMESTAMP( '2024-08-14 07:00:00', 'YYYY-MM-DD HH24:MI:SS' ) and 
TO_TIMESTAMP( '2024-08-14 18:00:00', 'YYYY-MM-DD HH24:MI:SS' )

select 
count(case when people_in =1 then 1 end) as total_traffic
from counter_data where device_token = '104' and timestamp between TO_TIMESTAMP( '2024-08-14 07:00:00', 'YYYY-MM-DD HH24:MI:SS' ) and 
TO_TIMESTAMP( '2024-08-14 18:00:00', 'YYYY-MM-DD HH24:MI:SS' )

-- male female counter datas
select Q1.male, Q2.female , sum (Q1.male + Q2.female) as total from
(select 
count(case when people_in = 1 then 1 end) as male
from counter_data where device_token = '103' and timestamp between TO_TIMESTAMP( '2024-08-14 07:00:00', 'YYYY-MM-DD HH24:MI:SS' ) and 
TO_TIMESTAMP( '2024-08-14 18:00:00', 'YYYY-MM-DD HH24:MI:SS' ))Q1
join
(select 
count(case when people_in =1 then 1 end) as female
from counter_data where device_token = '104' and timestamp between TO_TIMESTAMP( '2024-08-14 07:00:00', 'YYYY-MM-DD HH24:MI:SS' ) and 
TO_TIMESTAMP( '2024-08-14 18:00:00', 'YYYY-MM-DD HH24:MI:SS' ))Q2 on 1=1
group by Q1.male, Q2.female

-- male, female,oku devices
with male_devices as (select dp.device_pair_id, dp.toilet_info_id, ti.toilet_name, d.device_name, d.device_token, d.device_id
    from
    device_pairs as dp
    join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
    join devices as d on dp.device_id = d.device_id
    where
    dp.toilet_info_id = '9388096c-784d-49c8-784c-1868b1233165'),
    female_devices as (select dp.device_pair_id, dp.toilet_info_id, ti.toilet_name, d.device_name, d.device_token, d.device_id
    from
    device_pairs as dp
    join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
    join devices as d on dp.device_id = d.device_id
    where
    dp.toilet_info_id = '36f74ec4-cdb0-4271-6c2d-2baa48d6e583')
select Q1.male, Q2.female , sum (Q1.male + Q2.female) as total from
(select 
count(case when people_in = 1 then 1 end) as male
from counter_data where device_token in (select device_token from male_devices) and timestamp between TO_TIMESTAMP( '2024-08-14 07:00:00', 'YYYY-MM-DD HH24:MI:SS' ) and 
TO_TIMESTAMP( '2024-08-14 18:00:00', 'YYYY-MM-DD HH24:MI:SS' ))Q1
join
(select 
count(case when people_in =1 then 1 end) as female
from counter_data where device_token in ( select device_token from female_devices ) and timestamp between TO_TIMESTAMP( '2024-08-14 07:00:00', 'YYYY-MM-DD HH24:MI:SS' ) and 
TO_TIMESTAMP( '2024-08-14 18:00:00', 'YYYY-MM-DD HH24:MI:SS' ))Q2 on 1=1
group by Q1.male, Q2.female


-- all male female oku devices
-- male devices
with male_devices as (select dp.device_pair_id, dp.toilet_info_id, ti.toilet_name, d.device_name, d.device_token, d.device_id
    from
    device_pairs as dp
    join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
    join devices as d on dp.device_id = d.device_id
    where
    dp.toilet_info_id in (select toilet_info_id from toilet_infos where tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'  and toilet_type_id =1)),
female_devices as (select dp.device_pair_id, dp.toilet_info_id, ti.toilet_name, d.device_name, d.device_token, d.device_id
from
device_pairs as dp
join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
join devices as d on dp.device_id = d.device_id
where dp.toilet_info_id in (select toilet_info_id from toilet_infos where tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'  and toilet_type_id =2))
    select Q1.male, Q2.female , sum (Q1.male + Q2.female) as total from
    (select 
    count(case when people_in = 1 then 1 end) as male
    from counter_data where device_token in (select device_token from male_devices) and timestamp between TO_TIMESTAMP( '2024-08-14 07:00:00', 'YYYY-MM-DD HH24:MI:SS' ) and 
    TO_TIMESTAMP( '2024-08-14 18:00:00', 'YYYY-MM-DD HH24:MI:SS' ))Q1
    join
    (select 
    count(case when people_in =1 then 1 end) as female
    from counter_data where device_token in ( select device_token from female_devices ) and timestamp between TO_TIMESTAMP( '2024-08-14 07:00:00', 'YYYY-MM-DD HH24:MI:SS' ) and 
    TO_TIMESTAMP( '2024-08-14 18:00:00', 'YYYY-MM-DD HH24:MI:SS' ))Q2 on 1=1
    group by Q1.male, Q2.female

--
select toilet_info_id from toilet_infos where tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'  and toilet_type_id =1