-- Active: 1722832765629@@alpha.vectolabs.com@9998@smarttoilet-staging


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
INSERT INTO DEVICE_CUBICAL_PAIRS (device_cubical_pair_id, cubical_id, device_id)
VALUES (uuid_generate_v4 (), '881ac292-f7ba-42ed-61be-7ea9e5368d89','3c64d02c-abfb-4b57-5dfe-116d163ecee3')

-- mcm fail
INSERT INTO DEVICE_CUBICAL_PAIRS (device_cubical_pair_id, cubical_id, device_id) VALUES
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


-- guna ini
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

-- combine all
SELECT 
COALESCE(TRAFIC_COUNT_TODAY, 0) AS TRAFIC_COUNT_TODAY,
COALESCE(TOTAL_AUTO_CLEAN_ACTIVATED_TODAY,0) AS TOTAL_AUTO_CLEAN_ACTIVATED_TODAY,
LAST_AUTO_CLEAN_ACTIVATED, 
COALESCE(TOTAL_CLEAN_TODAY,0) AS TOTAL_CLEAN_TODAY, 
LAST_CLEAN
FROM 
(select count(case when occupied=true and prev_occupied =false then 1 end ) as TRAFIC_COUNT_TODAY from
(select occupied ,
LAG(occupied, 1) OVER (ORDER BY id) AS prev_occupied,
 date_trunc('HOUR', timestamp) as uplinkts from occupancy_data
where device_token in ('118') and 
EXTRACT(HOUR FROM timestamp) >= 7 AND EXTRACT(HOUR FROM timestamp) <= 18
    AND timestamp between TO_TIMESTAMP('2024-08-14 07:00:00','YYYY-MM-DD HH24:MI:SS') 
    and TO_TIMESTAMP('2024-08-14 18:00:00','YYYY-MM-DD HH24:MI:SS'))S1)Q1
LEFT JOIN
(select count(cleaner_report_id) as TOTAL_AUTO_CLEAN_ACTIVATED_TODAY
from cleaner_reports where auto_clean_state = '1' and cubical_id ='3c64d02c-abfb-4b57-5dfe-116d163ecee3' and
EXTRACT(HOUR FROM created_at) >= 7 AND EXTRACT(HOUR FROM created_at) <= 18
    AND created_at between TO_TIMESTAMP('2024-08-16 07:00:00','YYYY-MM-DD HH24:MI:SS') 
    and TO_TIMESTAMP('2024-08-16 18:00:00','YYYY-MM-DD HH24:MI:SS'))Q3 ON 1=1
LEFT JOIN
(select created_at as LAST_AUTO_CLEAN_ACTIVATED from cleaner_reports where auto_clean_state = '1' and cubical_id ='3c64d02c-abfb-4b57-5dfe-116d163ecee3' and
EXTRACT(HOUR FROM created_at) >= 7 AND EXTRACT(HOUR FROM created_at) <= 18
    AND created_at between TO_TIMESTAMP('2024-08-16 07:00:00','YYYY-MM-DD HH24:MI:SS') 
    and TO_TIMESTAMP('2024-08-16 18:00:00','YYYY-MM-DD HH24:MI:SS') order by created_at desc limit 1)Q4 ON 1=1
LEFT JOIN
(select count(cleaner_report_id) as TOTAL_CLEAN_TODAY
from cleaner_reports where auto_clean_state = '0' and cubical_id ='3c64d02c-abfb-4b57-5dfe-116d163ecee3' and
EXTRACT(HOUR FROM created_at) >= 7 AND EXTRACT(HOUR FROM created_at) <= 18
    AND created_at between TO_TIMESTAMP('2024-08-16 07:00:00','YYYY-MM-DD HH24:MI:SS') 
    and TO_TIMESTAMP('2024-08-16 18:00:00','YYYY-MM-DD HH24:MI:SS'))Q5 ON 1=1
LEFT JOIN
(select created_at as LAST_CLEAN  from cleaner_reports where auto_clean_state = '0' and cubical_id ='3c64d02c-abfb-4b57-5dfe-116d163ecee3' and
EXTRACT(HOUR FROM created_at) >= 7 AND EXTRACT(HOUR FROM created_at) <= 18
    AND created_at between TO_TIMESTAMP('2024-08-16 07:00:00','YYYY-MM-DD HH24:MI:SS') 
    and TO_TIMESTAMP('2024-08-16 18:00:00','YYYY-MM-DD HH24:MI:SS') order by created_at desc limit 1)Q6 ON 1=1


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
select count(cleaner_report_id) as total_clean_today
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



    -- fail query
select d.device_token
from
    device_cubical_pairs dcp
    join devices d on d.device_id = dcp.device_id
where
    dcp.cubical_id = '3c64d02c-abfb-4b57-5dfe-116d163ecee3'

select * from device_cubical_pairs



-- lumsum fail
WITH
    DEVICE_LIST AS (
        select d.device_token, d.device_type_id
        from
            device_cubical_pairs dcp
            join devices d on d.device_id = dcp.device_id
        where
            dcp.cubical_id = '881ac292-f7ba-42ed-61be-7ea9e5368d89'
    )
SELECT
    COALESCE(TRAFIC_COUNT_TODAY, 0) AS TRAFIC_COUNT_TODAY,
    COALESCE(
        TOTAL_AUTO_CLEAN_ACTIVATED_TODAY,
        0
    ) AS TOTAL_AUTO_CLEAN_ACTIVATED_TODAY,
    LAST_AUTO_CLEAN_ACTIVATED,
    COALESCE(TOTAL_CLEAN_TODAY, 0) AS TOTAL_CLEAN_TODAY,
    LAST_CLEAN
FROM (
        select count(
                case
                    when occupied = true
                    and prev_occupied = false then 1
                end
            ) as TRAFIC_COUNT_TODAY
        from (
                select
                    occupied, LAG(occupied, 1) OVER (
                        ORDER BY id
                    ) AS prev_occupied, date_trunc('HOUR', timestamp) as uplinkts
                from occupancy_data
                where
                    device_token in (
                        select device_token
                        from device_list
                        where
                            device_type_id = 12
                    )
                    and EXTRACT(
                        HOUR
                        FROM timestamp
                    ) >= 7
                    AND EXTRACT(
                        HOUR
                        FROM timestamp
                    ) <= 18
                    AND timestamp between TO_TIMESTAMP(
                        '2024-08-16 07:00:00', 'YYYY-MM-DD HH24:MI:SS'
                    ) and TO_TIMESTAMP(
                        '2024-08-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS'
                    )
            ) S1
    ) Q1
    LEFT JOIN (
        select
            count(cleaner_report_id) as TOTAL_AUTO_CLEAN_ACTIVATED_TODAY
        from cleaner_reports
        where
            auto_clean_state = '1'
            and cubical_id = '881ac292-f7ba-42ed-61be-7ea9e5368d89'
            and EXTRACT(
                HOUR
                FROM created_at
            ) >= 7
            AND EXTRACT(
                HOUR
                FROM created_at
            ) <= 18
            AND created_at between TO_TIMESTAMP(
                '2024-08-16 07:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and TO_TIMESTAMP(
                '2024-08-16 18:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q3 ON 1 = 1
    LEFT JOIN (
        select
            created_at as LAST_AUTO_CLEAN_ACTIVATED
        from cleaner_reports
        where
            auto_clean_state = '1'
            and cubical_id = '881ac292-f7ba-42ed-61be-7ea9e5368d89'
            and EXTRACT(
                HOUR
                FROM created_at
            ) >= 7
            AND EXTRACT(
                HOUR
                FROM created_at
            ) <= 18
            AND created_at between TO_TIMESTAMP(
                '2024-08-16 07:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and TO_TIMESTAMP(
                '2024-08-16 18:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
        order by created_at desc
        limit 1
    ) Q4 ON 1 = 1
    LEFT JOIN (
        select count(cleaner_report_id) as TOTAL_CLEAN_TODAY
        from cleaner_reports
        where
            auto_clean_state = '0'
            and cubical_id = '881ac292-f7ba-42ed-61be-7ea9e5368d89'
            and EXTRACT(
                HOUR
                FROM created_at
            ) >= 7
            AND EXTRACT(
                HOUR
                FROM created_at
            ) <= 18
            AND created_at between TO_TIMESTAMP(
                '2024-08-16 07:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and TO_TIMESTAMP(
                '2024-08-16 18:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q5 ON 1 = 1
    LEFT JOIN (
        select created_at as LAST_CLEAN
        from cleaner_reports
        where
            auto_clean_state = '0'
            and cubical_id = '881ac292-f7ba-42ed-61be-7ea9e5368d89'
            and EXTRACT(
                HOUR
                FROM created_at
            ) >= 7
            AND EXTRACT(
                HOUR
                FROM created_at
            ) <= 18
            AND created_at between TO_TIMESTAMP(
                '2024-08-16 07:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and TO_TIMESTAMP(
                '2024-08-16 18:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
        order by created_at desc
        limit 1
    ) Q6 ON 1 = 1


-- test query male_01
WITH DEVICE_LIST AS ( select 
    -- dp.device_pair_id, d.device_name, 
    d.device_token, d.device_id 
    from device_pairs as dp  
    join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id 
    join devices as d on dp.device_id = d.device_id  
    where dp.toilet_info_id = '9388096c-784d-49c8-784c-1868b1233165'  
    and d.device_type_id = 12)
select od.occupied as occupancy, 
right(dl.device_name, 2) as cubical_name, 
Q1.cubical_counter, 
dl.device_name,
AUTOCLEANINGPROCESS
from occupancy_data od  
join device_list dl on dl.device_token = od.device_token 
left join
    (select COALESCE(sum(CASE WHEN occupied = TRUE AND prev_occupied = FALSE THEN 1 ELSE 0 END),0) as cubical_counter, 
    device_token  from 
        (select * , lag(occupied, 1) over( order by id )prev_occupied 
        from occupancy_data) SQ1  
    where timestamp BETWEEN to_timestamp('2024-08-16 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
    AND to_timestamp('2024-08-16 23:59:59', 'YYYY-MM-DD HH24:MI:SS')
    and device_token ='118'  
    group by device_token ) 
    Q1 on Q1.device_token = dl.device_token  
    -- order by timestamp desc limit 4 
LEFT JOIN 
    (SELECT CASE WHEN cr.auto_clean_state = '1' THEN true else false end as AUTOCLEANINGPROCESS, dcp.device_id
    FROM CLEANER_REPORTS  cr join device_cubical_pairs dcp on cr.cubical_id = dcp.cubical_id  
    where EXTRACT(HOUR FROM cr.created_at) >= 7 AND EXTRACT(HOUR FROM cr.created_at) <= 18 and 
    dcp.device_id IN (select device_id from device_list) and  
    cr.created_at between TO_TIMESTAMP('2024-07-01 07:00:00', 'YYYY-MM-DD HH24:MI:SS') and 
    TO_TIMESTAMP('2024-09-30 18:00:00', 'YYYY-MM-DD HH24:MI:SS')  
    order by cr.created_at limit 1)Q2 ON TRUE






-- test query
WITH DEVICE_LIST AS ( select 
    -- dp.device_pair_id, d.device_name, 
    d.device_token, d.device_id 
    from device_pairs as dp  
    join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id 
    join devices as d on dp.device_id = d.device_id  
    where dp.toilet_info_id = '9388096c-784d-49c8-784c-1868b1233165'  
    and d.device_type_id = 12)
select 
    AUTOCLEANINGPROCESS,
    cubical_name,
    device_id
from device_list
    -- select od.occupied as occupancy, Q1.cubical_counter, dl.device_name
left join
    (SELECT 
    CASE WHEN cr.auto_clean_state = '1' THEN true else false end as AUTOCLEANINGPROCESS, 
    ci.cubical_name,
    dcp.device_id
    FROM CLEANER_REPORTS  cr 
    join device_cubical_pairs dcp on cr.cubical_id = dcp.cubical_id
    join cubical_infos ci on ci.cubical_id = dcp.cubical_id
    where EXTRACT(HOUR FROM cr.created_at) >= 7 AND EXTRACT(HOUR FROM cr.created_at) <= 18 and 
    dcp.device_id IN (select device_id from device_list) and  
    cr.created_at between TO_TIMESTAMP('2024-07-01 07:00:00', 'YYYY-MM-DD HH24:MI:SS') and 
    TO_TIMESTAMP('2024-09-30 18:00:00', 'YYYY-MM-DD HH24:MI:SS')  
    order by cr.created_at )Q2 using (device_id)


--device_id
55009f31-2114-4bff-5946-4aaa378f791a --121
daea6ed6-bd21-48a1-4012-be978ed24009 --120
745447eb-05b3-4bfe-4a04-451343e4e655 --125
3c64d02c-abfb-4b57-5dfe-116d163ecee3 --118 -- true

select * from cleaner_reports 

select * from device_cubical_pairs dcp
join cubical_infos ci on ci.cubical_id = dcp.cubical_id

select dcp.device_id, cr.cleaner_report_id, cr.created_at
from cleaner_reports cr
join device_cubical_pairs dcp on dcp.cubical_id = cr.cubical_id

-- check how many cubical already has auto clean data
select distinct dcp.device_id, count(cr.cleaner_report_id)
from
cleaner_reports cr
join device_cubical_pairs dcp on dcp.cubical_id = cr.cubical_id
group by dcp.device_id


select distinct cr.cubical_id
FROM
CLEANER_REPORTS cr
join device_cubical_pairs dcp on cr.cubical_id = dcp.cubical_id
join cubical_infos ci on ci.cubical_id = dcp.cubical_id



WITH
    DEVICE_LIST AS (
        select
            -- dp.device_pair_id, d.device_name, 
            d.device_token, d.device_id
        from
            device_pairs as dp
            join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
            join devices as d on dp.device_id = d.device_id
        where
            dp.toilet_info_id = '9388096c-784d-49c8-784c-1868b1233165'
            and d.device_type_id = 12
    )
select device_id, AUTOCLEANINGPROCESS
FROM
device_list
left join
(SELECT  
CASE WHEN cr.auto_clean_state = '1' THEN true else false end as AUTOCLEANINGPROCESS, 
ci.cubical_name,
dcp.device_id
FROM CLEANER_REPORTS  cr 
join device_cubical_pairs dcp on cr.cubical_id = dcp.cubical_id
join cubical_infos ci on ci.cubical_id = dcp.cubical_id
where EXTRACT(HOUR FROM cr.created_at) >= 7 AND EXTRACT(HOUR FROM cr.created_at) <= 18 and 
dcp.device_id IN (select device_id from device_list) and  
cr.created_at between TO_TIMESTAMP('2024-07-01 07:00:00', 'YYYY-MM-DD HH24:MI:SS') and 
TO_TIMESTAMP('2025-09-30 18:00:00', 'YYYY-MM-DD HH24:MI:SS')  
order by cr.created_at)Q1 
using(device_id)
-- group by device_id


-- query to get cubical pairs
select cp.cubical_pair_id, cp.cubical_id, cp.toilet_info_id, d.device_token, d.device_id, ci.cubical_name, d.device_name
from cubical_pairs cp
join cubical_infos ci on ci.cubical_id = cp.cubical_id
join device_cubical_pairs dcp on dcp.cubical_id = cp.cubical_id
join devices d on d.device_id = dcp.device_id
where cp.toilet_info_id = '9388096c-784d-49c8-784c-1868b1233165'



select cubical_counter, 
occupied
from
(select COALESCE(sum(CASE WHEN occupied = TRUE AND prev_occupied = FALSE THEN 1 ELSE 0 END),0) as cubical_counter, 
device_token  from 
    (select * , lag(occupied, 1) over( order by id )prev_occupied 
    from occupancy_data) SQ1  
where timestamp BETWEEN to_timestamp('2024-08-16 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
AND to_timestamp('2024-08-16 23:59:59', 'YYYY-MM-DD HH24:MI:SS')
and device_token = '118'  
group by device_token) Q1 
left join 
(select occupied, device_token from occupancy_data where device_token = '118' order by timestamp limit 1)Q2 USING(device_token)



SELECT CASE WHEN cr.auto_clean_state = '1' THEN true else false end as AUTOCLEANINGPROCESS
-- ci.cubical_name,
-- dcp.device_id,
-- cr.created_at
FROM CLEANER_REPORTS  cr 
join device_cubical_pairs dcp on cr.cubical_id = dcp.cubical_id
-- join cubical_infos ci on ci.cubical_id = dcp.cubical_id
where EXTRACT(HOUR FROM cr.created_at) >= 7 AND EXTRACT(HOUR FROM cr.created_at) <= 18 and 
dcp.device_id ='3c64d02c-abfb-4b57-5dfe-116d163ecee3' and  
cr.created_at between TO_TIMESTAMP('2024-07-01 07:00:00', 'YYYY-MM-DD HH24:MI:SS') and 
TO_TIMESTAMP('2025-09-30 18:00:00', 'YYYY-MM-DD HH24:MI:SS')  
order by cr.created_at desc limit 1




-- try combine
select cubical_counter, 
occupied,
AUTOCLEANINGPROCESS
from
devices d
left join
(select COALESCE(sum(CASE WHEN occupied = TRUE AND prev_occupied = FALSE THEN 1 ELSE 0 END),0) as cubical_counter, 
device_token  from 
    (select * , lag(occupied, 1) over( order by id )prev_occupied 
    from occupancy_data) SQ1  
where timestamp BETWEEN to_timestamp('2024-08-16 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
AND to_timestamp('2024-08-16 23:59:59', 'YYYY-MM-DD HH24:MI:SS')
and device_token = '118'  
group by device_token) Q1 using(device_token)
left join 
(select occupied, device_token from occupancy_data where device_token = '118' order by timestamp limit 1)Q2 USING(device_token)
left join
(SELECT CASE WHEN cr.auto_clean_state = '1' THEN true else false end as AUTOCLEANINGPROCESS, dcp.device_id
FROM CLEANER_REPORTS  cr 
join device_cubical_pairs dcp on cr.cubical_id = dcp.cubical_id
where EXTRACT(HOUR FROM cr.created_at) >= 7 AND EXTRACT(HOUR FROM cr.created_at) <= 18 and 
dcp.device_id ='3c64d02c-abfb-4b57-5dfe-116d163ecee3' and  
cr.created_at between TO_TIMESTAMP('2024-07-01 07:00:00', 'YYYY-MM-DD HH24:MI:SS') and 
TO_TIMESTAMP('2025-09-30 18:00:00', 'YYYY-MM-DD HH24:MI:SS')  
order by cr.created_at desc limit 1) Q3 using(device_id)
where d.device_token = '118'




--
elect cp.cubical_pair_id as CUBICAL_PAIR_ID,
cp.cubical_id as CUBICAL_ID,
cp.toilet_info_id as TOILET_INFO_ID,
d.device_token as DEVICE_TOKE,
d.device_id as DEVICE_ID,
ci.cubical_name as CUBICAL_NAME,
d.device_name as DEVICE_NAMEfrom cubical_pairs cp
join cubical_infos ci on ci.cubical_id = cp.cubical_id
join device_cubical_pairs dcp on dcp.cubical_id = cp.cubical_id
join devices d on d.device_id = dcp.device_id
where
    cp.toilet_info_id = '9388096c-784d-49c8-784c-1868b1233165'






select d.device_id, dcp.device_cubical_pair_id, d.device_token,
from
    device_cubical_pairs dcp
    join devices d on d.device_id = dcp.device_id
where
    dcp.cubical_id = '881ac292-f7ba-42ed-61be-7ea9e5368d89'


select * from cleaner_reports 

select *
from cleaner_reports where cubical_id = '881ac292-f7ba-42ed-61be-7ea9e5368d89' order by created_at desc limit 1

select 
    (case when auto_clean_state = '1' then true  else false end) as auto_clean_state,
    (case when freshen_up_state = '1' then true  else false end) as freshen_up_state
from cleaner_reports where cubical_id = '881ac292-f7ba-42ed-61be-7ea9e5368d89' order by created_at desc limit 1


-- activate autoclean
insert into manual_device_activations ("cubical_id", "duration", "start_active_time", "end_active_time") values
('881ac292-f7ba-42ed-61be-7ea9e5368d89', 3, NOW(), NOW()+ interval '3 secs')


select * from manual_device_activations

-- insert 
insert into cleaner_reports("tenant_id","location_id","toilet_type_id","check_in_ts","check_out_ts",
"duration","auto_clean_state","created_at", "updated_at", "cubical_id") VALUES


insert into
    cleaner_reports (
        "cleaner_report_id",
        "tenant_id",
        -- "location_id",
        -- "toilet_type_id",
        "check_in_ts",
        "check_out_ts",
        "duration",
        "auto_clean_state",
        "created_at",
        "updated_at",
        "cubical_id"
    )
VALUES
(
    uuid_generate_v4 (),
    '589ee2f0-75e1-4cd0-5c74-78a4df1288fd',
    NOW(),
    NOW()+interval '15 secs',
    15,
    '1',
    NOW(),
    NOW() + interval '15 secs',
    '881ac292-f7ba-42ed-61be-7ea9e5368d89'
)



select toilet_type_id, location_id
from cubical_infos ci
join cubical_pairs cp on ci.cubical_id = cp.cubical_id
join toilet_infos ti on ti.toilet_info_id = cp.toilet_info_id
where ci.cubical_id = '36f74ec4-cdb0-4271-6c2d-2baa48d6e583'




-- cubical list
select ci.cubical_id, ci.cubical_name, ci.cubical_nick_name
from
    cubical_infos ci
    join cubical_pairs cp on ci.cubical_id = cp.cubical_id
where
    cp.toilet_info_id = '36f74ec4-cdb0-4271-6c2d-2baa48d6e583'


--
select * from cubical_infos

--
select ci.cubical_id, ci.cubical_name, ci.cubical_nick_name, cp.toilet_info_id
from
    cubical_infos ci
    join cubical_pairs cp on ci.cubical_id = cp.cubical_id


select * from manual_device_activations where  limit 1  