

select * from device_pairs

alter table device_pairs add column cubical_id text

-- list of cubicals
select * from cubical_infos

-- cubical and toilet pair
select * from cubical_pairs

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


-- uuid_generate_v4 ()

-- cubical and device pairs
select * from device_cubical_pairs

-- ini menjadi aka ok
INSERT INTO DEVICE_CUBICAL_PAIRS ("device_cubical_pair_id", "cubical_id", "device_id")
VALUES (uuid_generate_v4 (), '881ac292-f7ba-42ed-61be-7ea9e5368d89','3c64d02c-abfb-4b57-5dfe-116d163ecee3')

-- mcm fail
INSERT INTO DEVICE_CUBICAL_PAIRS ("device_cubical_pair_id", "cubical_id", "device_id") VALUES
    (uuid_generate_v4 (), 'e34a8f65-9524-4a6a-55d5-153217239201','4cd91fb8-54ef-46e8-4472-4c1b9a3a42bc'),
    (uuid_generate_v4 (), 'f064a7ee-6568-41fe-4110-19c3d7ea6718','d861a427-4aa2-46ce-5fa7-92961c81b61d'),
    (uuid_generate_v4 (), 'a26a1af6-3ffa-4cbd-5185-125cc2b94e31','c1297d5a-243a-4c4a-5839-e60d93718132'),
    (uuid_generate_v4 (), '6a9237e9-9933-4fa2-7f8a-a53978d7271c','4234509e-0749-4e04-7342-87ed4cb42e7d'),
    (uuid_generate_v4 (), '2512c06f-bf57-45e1-7a7b-5e0935dbbe8d','88c5fbc6-8bbc-473a-78f5-4a8a5d070a16'),
    (uuid_generate_v4 (), '214a2dcf-7b6e-4e98-5f77-2103dcecf0e7','ef4a97a5-cabd-4214-797e-7b050140d818'),
    (uuid_generate_v4 (), '057ba462-c2e6-4d12-69e5-7f2ffac5927f','7b53a36c-a016-4ddb-766c-177e0f9b7d9a')
    
-- oocupany m1, m4, m2, m3
3c64d02c-abfb-4b57-5dfe-116d163ecee3
745447eb-05b3-4bfe-4a04-451343e4e655
daea6ed6-bd21-48a1-4012-be978ed24009
55009f31-2114-4bff-5946-4aaa378f791a


-- ocupancy f1,f2,f3,f4
e4ebb57f-7321-4d53-696f-bd30ffbe67be
226d111c-5c5b-49b9-5eb8-20f26e4e8149
99b5c48c-2ecd-4e69-52bf-e477f666625b
55586213-c7af-4279-6aff-b8d02c1e173c


-- -- m
-- c1297d5a-243a-4c4a-5839-e60d93718132  --4
-- 4cd91fb8-54ef-46e8-4472-4c1b9a3a42bc --2
-- d861a427-4aa2-46ce-5fa7-92961c81b61d --3

-- --f
-- 4234509e-0749-4e04-7342-87ed4cb42e7d --1
-- 88c5fbc6-8bbc-473a-78f5-4a8a5d070a16
-- ef4a97a5-cabd-4214-797e-7b050140d818
-- 7b53a36c-a016-4ddb-766c-177e0f9b7d9a


-- cubical m
881ac292-f7ba-42ed-61be-7ea9e5368d89 --1
e34a8f65-9524-4a6a-55d5-153217239201 --2
f064a7ee-6568-41fe-4110-19c3d7ea6718-- 3
a26a1af6-3ffa-4cbd-5185-125cc2b94e31 --4

-- cubical f
6a9237e9-9933-4fa2-7f8a-a53978d7271c --1
2512c06f-bf57-45e1-7a7b-5e0935dbbe8d
214a2dcf-7b6e-4e98-5f77-2103dcecf0e7
057ba462-c2e6-4d12-69e5-7f2ffac5927f


-- get list of device for a cubical
select d.device_id, dcp.device_cubical_pair_id
from device_cubical_pairs dcp
join devices d on d.device_id = dcp.device_id
where dcp.cubical_id = '881ac292-f7ba-42ed-61be-7ea9e5368d89'


-- get device token
select d.device_token
from device_cubical_pairs dcp
join devices d on d.device_id = dcp.device_id
where dcp.cubical_id = '881ac292-f7ba-42ed-61be-7ea9e5368d89'

select * from device_cubical_pairs dcp
join devices d on d.device_id =  dcp.device_id



-- SELECT * from devices where device_id = '4cd91fb8-54ef-46e8-4472-4c1b9a3a42bc'

SELECT TRAFIC_COUNT_TODAY, UNOCCUPIED, TOTAL_AUTO_CLEAN_ACTIVATED_TODAY,
LAST_AUTO_CLEAN_ACTIVATED, TOTAL_CLEAN_TODAY, LAST_CLEAN



-- 
select occupied ,
LAG(occupied, 1) OVER (
    ORDER BY id
) AS prev_occupied,
 date_trunc('HOUR', timestamp) as uplinkts 
 from occupancy_data
where device_token in ('118')
group by occupied,id, uplinkts

select *
from occupancy_data where device_token in ('118')


select occupied ,
LAG(occupied, 1) OVER (
    ORDER BY id
) AS prev_occupied,
 date_trunc('HOUR', timestamp) as uplinkts 
 from occupancy_data
where device_token in ('118') and 
EXTRACT(HOUR FROM timestamp) >= 7 AND EXTRACT(HOUR FROM timestamp) <= 18
    AND timestamp between TO_TIMESTAMP('2024-08-14 07:00:00','YYYY-MM-DD HH24:MI:SS') 
    and TO_TIMESTAMP('2024-08-14 18:00:00','YYYY-MM-DD HH24:MI:SS')
-- group by occupied,id, uplinkts

-- Q1
select count(case when occupied=true and prev_occupied =false then 1 end ) as TRAFIC_COUNT_TODAY from
(select occupied ,
LAG(occupied, 1) OVER (ORDER BY id) AS prev_occupied,
 date_trunc('HOUR', timestamp) as uplinkts from occupancy_data
where device_token in ('118') and 
EXTRACT(HOUR FROM timestamp) >= 7 AND EXTRACT(HOUR FROM timestamp) <= 18
    AND timestamp between TO_TIMESTAMP('2024-08-14 07:00:00','YYYY-MM-DD HH24:MI:SS') 
    and TO_TIMESTAMP('2024-08-14 18:00:00','YYYY-MM-DD HH24:MI:SS'))S1


select occupied as OCCUPIED,timestamp  from occupancy_data where device_token ='118' order by timestamp limit 1

-- Q4
select created_at as last_autoclean  from cleaner_reports where auto_clean_state = '1' and cubical_id ='3c64d02c-abfb-4b57-5dfe-116d163ecee3' and
EXTRACT(HOUR FROM created_at) >= 7 AND EXTRACT(HOUR FROM created_at) <= 18
    AND created_at between TO_TIMESTAMP('2024-08-16 07:00:00','YYYY-MM-DD HH24:MI:SS') 
    and TO_TIMESTAMP('2024-08-16 18:00:00','YYYY-MM-DD HH24:MI:SS') order by created_at desc limit 1

--Q6
select created_at as last_clean  from cleaner_reports where auto_clean_state = '0' and cubical_id ='3c64d02c-abfb-4b57-5dfe-116d163ecee3' and
EXTRACT(HOUR FROM created_at) >= 7 AND EXTRACT(HOUR FROM created_at) <= 18
    AND created_at between TO_TIMESTAMP('2024-08-16 07:00:00','YYYY-MM-DD HH24:MI:SS') 
    and TO_TIMESTAMP('2024-08-16 18:00:00','YYYY-MM-DD HH24:MI:SS') order by created_at desc limit 1

select * from cleaner_reports

-- current_timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'GMT+8'
-- current_timestamp , gmt

select 
CASE
    WHEN AGE (now() + INTERVAL '8 hours') >= INTERVAL '0 second'
    AND AGE (now() + INTERVAL '8 hours') <= INTERVAL '15 second' THEN TRUE
    ELSE FALSE
END AS autocleaning, 
now() + INTERVAL '8 hours' , 
created_at
from cleaner_reports where auto_clean_state = '1' and cubical_id ='3c64d02c-abfb-4b57-5dfe-116d163ecee3' and
EXTRACT(HOUR FROM created_at) >= 7 AND EXTRACT(HOUR FROM created_at) <= 18
    AND created_at between TO_TIMESTAMP('2024-08-16 07:00:00','YYYY-MM-DD HH24:MI:SS') 
    and TO_TIMESTAMP('2024-08-16 18:00:00','YYYY-MM-DD HH24:MI:SS') order by created_at desc limit 1


-- Q2 occupied, not occupied, autoclean
select (case when autocleaning = true then true else false end) as autocleaning,
( case when OCCUPIED = true and autocleaning = false then true else false end ) as occupancy,
( case when OCCUPIED = false and autocleaning = false then true else false end ) as notoccupied
-- OCCUPIED,
-- autocleaning
from
(select occupied as OCCUPIED,timestamp  from occupancy_data where device_token ='118' order by timestamp limit 1)Q1
-- (select false as occupied)Q1
left join
(select 
CASE
    WHEN AGE (now() + INTERVAL '8 hours') >= INTERVAL '0 second'
    AND AGE (now() + INTERVAL '8 hours') <= INTERVAL '15 second' THEN TRUE
    ELSE FALSE
END AS autocleaning, 
now() + INTERVAL '8 hours' , 
created_at
from cleaner_reports where auto_clean_state = '1' and cubical_id ='3c64d02c-abfb-4b57-5dfe-116d163ecee3' and
EXTRACT(HOUR FROM created_at) >= 7 AND EXTRACT(HOUR FROM created_at) <= 18
    AND created_at between TO_TIMESTAMP('2024-08-16 07:00:00','YYYY-MM-DD HH24:MI:SS') 
    and TO_TIMESTAMP('2024-08-16 18:00:00','YYYY-MM-DD HH24:MI:SS') order by created_at desc limit 1)Q2 ON 1=1



--Q3  total autoclean today
select count(cleaner_report_id) as total_autoclean_activated_today
from cleaner_reports where auto_clean_state = '1' and cubical_id ='3c64d02c-abfb-4b57-5dfe-116d163ecee3' and
EXTRACT(HOUR FROM created_at) >= 7 AND EXTRACT(HOUR FROM created_at) <= 18
    AND created_at between TO_TIMESTAMP('2024-08-16 07:00:00','YYYY-MM-DD HH24:MI:SS') 
    and TO_TIMESTAMP('2024-08-16 18:00:00','YYYY-MM-DD HH24:MI:SS')

-- Q5 total clean today, manual clean
select count(cleaner_report_id) as total_autoclean_activated_today
from cleaner_reports where auto_clean_state = '0' and cubical_id ='3c64d02c-abfb-4b57-5dfe-116d163ecee3' and
EXTRACT(HOUR FROM created_at) >= 7 AND EXTRACT(HOUR FROM created_at) <= 18
    AND created_at between TO_TIMESTAMP('2024-08-16 07:00:00','YYYY-MM-DD HH24:MI:SS') 
    and TO_TIMESTAMP('2024-08-16 18:00:00','YYYY-MM-DD HH24:MI:SS')



-- traffic today
select user, uplinks

select count(case when occupied = true and prev_occupied = false then 1 end) as user,uplinkts from
(select occupied, LAG(occupied, 1) OVER ( ORDER BY id ) AS prev_occupied, date_trunc('HOUR',timestamp) as uplinkts
from occupancy_data where EXTRACT(HOUR FROM timestamp) >= 7 AND EXTRACT(HOUR FROM timestamp) <= 18
    AND timestamp between TO_TIMESTAMP('2024-08-16 07:00:00','YYYY-MM-DD HH24:MI:SS') 
    and TO_TIMESTAMP('2024-08-16 18:00:00','YYYY-MM-DD HH24:MI:SS') and device_token ='118')S1 group by S1.uplinkts

-- autocleanactivated trend
select traffic, uplinkts

select count(cleaner_report_id)as traffic ,date_trunc('HOUR', created_at)as uplinkts from cleaner_reports where EXTRACT(HOUR FROM created_at) >= 7 AND EXTRACT(HOUR FROM created_at) <= 18
    AND auto_clean_state ='1' AND created_at between TO_TIMESTAMP('2024-08-16 07:00:00','YYYY-MM-DD HH24:MI:SS') 
    and TO_TIMESTAMP('2024-08-16 18:00:00','YYYY-MM-DD HH24:MI:SS') and cubical_id ='3c64d02c-abfb-4b57-5dfe-116d163ecee3'
    group by uplinkts