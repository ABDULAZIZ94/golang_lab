36f74ec4-cdb0-4271-6c2d-2baa48d6e583 --female
9388096c-784d-49c8-784c-1868b1233165 -- male
a97891e5-14df-4f95-7d1e-4ee601581df2 -- oku

-- full query
WITH
    DEVICE_LIST AS (
        select dp.device_pair_id, d.device_name, d.device_token, d.device_id
        from
            device_pairs as dp
            join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
            join devices as d on dp.device_id = d.device_id
        where
            dp.toilet_info_id = '36f74ec4-cdb0-4271-6c2d-2baa48d6e583')
SELECT 
    COALESCE(TRAFFIC_COUNT_TODAY,0) as TRAFFIC_COUNT_TODAY,
    COALESCE(TOTAL_FRAGRANCE_SPRAY_ACTIVATED,0) as TOTAL_FRAGRANCE_SPRAY_ACTIVATED,
    LAST_FRAGRANCE_SPRAY_ACTIVATED,
    COALESCE(CURRENT_LUX,0) as CURRENT_LUX,
    COALESCE(CURRENT_IAQ,0) as CURRENT_IAQ, 
    COALESCE(TOTAL_CLEANED_TODAY,0) as TOTAL_CLEANED_TODAY,
    LAST_CLEAN_TIMESTAMP,
    COALESCE(CURRENT_HUMIDITY,0) as CURRENT_HUMIDITY
FROM
(select count(people_in) as TRAFFIC_COUNT_TODAY from counter_data where device_token in (select device_token from DEVICE_LIST ) and timestamp between TO_TIMESTAMP( '2024-08-14 07:00:00', 'YYYY-MM-DD HH24:MI:SS' ) and 
TO_TIMESTAMP( '2024-08-14 18:00:00', 'YYYY-MM-DD HH24:MI:SS' ))Q1
LEFT JOIN
(select timestamp as LAST_FRAGRANCE_SPRAY_ACTIVATED from fragrance_data order by timestamp desc limit 1)Q2 ON 1=1
LEFT JOIN
(select iaq as CURRENT_IAQ, lux as CURRENT_LUX, humidity as CURRENT_HUMIDITY from enviroment_data where device_token 
in ( select device_token from DEVICE_LIST ) order by timestamp desc limit 1)Q3 ON 1=1
LEFT JOIN
(select count(cleaner_report_id) as TOTAL_CLEANED_TODAY from cleaner_reports where check_in_ts between 
TO_TIMESTAMP( '2024-08-14 07:00:00', 'YYYY-MM-DD HH24:MI:SS' ) and TO_TIMESTAMP( '2024-08-14 18:00:00', 'YYYY-MM-DD HH24:MI:SS'))Q4 ON 1=1
LEFT JOIN
(select created_at as LAST_CLEAN_TIMESTAMP from cleaner_reports where auto_clean_state ='0' and check_in_ts between 
TO_TIMESTAMP( '2024-08-14 07:00:00', 'YYYY-MM-DD HH24:MI:SS' ) and TO_TIMESTAMP( '2024-08-14 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
order by created_at limit 1) Q5 ON 1=1
LEFT JOIN
(select count(case when fragrance_on = true then 1 end) as TOTAL_FRAGRANCE_SPRAY_ACTIVATED from fragrance_data where timestamp between 
TO_TIMESTAMP( '2024-08-01 07:00:00', 'YYYY-MM-DD HH24:MI:SS' ) and TO_TIMESTAMP( '2024-08-14 18:00:00', 'YYYY-MM-DD HH24:MI:SS')) Q6 ON 1=1


-- Q1 subqueries    select count(case when people_in = 1 then 1 end) as TRAFFIC_COUNT_TODAY
select count(people_in) as TRAFFIC_COUNT_TODAY
from counter_data where device_token in (select device_token from DEVICE_LIST ) and timestamp between TO_TIMESTAMP( '2024-08-14 07:00:00', 'YYYY-MM-DD HH24:MI:SS' ) and 
TO_TIMESTAMP( '2024-08-14 18:00:00', 'YYYY-MM-DD HH24:MI:SS' )


-- Q2
select * from fragrance_data order by timestamp desc

select count(case when fragrance_on = true then 1 end) as TOTAL_FRAGRANCE_SPRAY_ACTIVATED from fragrance_data where timestamp between 
TO_TIMESTAMP( '2024-08-01 07:00:00', 'YYYY-MM-DD HH24:MI:SS' ) and TO_TIMESTAMP( '2024-08-14 18:00:00', 'YYYY-MM-DD HH24:MI:SS')

select timestamp from fragrance_data order by timestamp desc limit 1

-- Q3 , Q4 ,Q7
select iaq, temperature, humidity, lux from enviroment_data

select iaq as CURRENT_IAQ, lux as CURRENT_LUX from enviroment_data order by timestamp desc limit 1

 select iaq as CURRENT_IAQ, lux as CURRENT_LUX, humidity as CURRENT_HUMIDITY from enviroment_data where device_token in ( select device_token from DEVICE_LIST ) order by timestamp desc limit 1

-- Q5
select count(cleaner_report_id) as TOTAL_CLEAN_TODAY from cleaner_reports where check_in_ts between 
TO_TIMESTAMP( '2024-08-14 07:00:00', 'YYYY-MM-DD HH24:MI:SS' ) and TO_TIMESTAMP( '2024-08-14 18:00:00', 'YYYY-MM-DD HH24:MI:SS')

-- Q6
select * from cleaner_reports

select created_at as LAST_CLEAN_TIMESTAMP from cleaner_reports where auto_clean_state ='0' and check_in_ts between 
TO_TIMESTAMP( '2024-08-14 07:00:00', 'YYYY-MM-DD HH24:MI:SS' ) and TO_TIMESTAMP( '2024-08-14 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
order by created_at limit 1

select *  from cleaner_reports where check_in_ts between 
TO_TIMESTAMP( '2024-08-14 07:00:00', 'YYYY-MM-DD HH24:MI:SS' ) and TO_TIMESTAMP( '2024-08-14 18:00:00', 'YYYY-MM-DD HH24:MI:SS')

-- test query
WITH
    DEVICE_LIST AS (
        select dp.device_pair_id, d.device_name, d.device_token, d.device_id
        from
            device_pairs as dp
            join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
            join devices as d on dp.device_id = d.device_id
        where
            dp.toilet_info_id = '36f74ec4-cdb0-4271-6c2d-2baa48d6e583'
    )
select iaq as CURRENT_IAQ, lux as CURRENT_LUX, humidity as CURRENT_HUMIDITY from enviroment_data where device_token in ( select device_token from DEVICE_LIST ) order by timestamp desc limit 1

