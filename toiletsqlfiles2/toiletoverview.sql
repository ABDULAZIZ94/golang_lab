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
            dp.toilet_info_id = '36f74ec4-cdb0-4271-6c2d-2baa48d6e583'
)
SELECT 
    COALESCE(TRAFFIC_COUNT_TODAY,0), 
    COALESCE(FRAGRANCE_SPRAY_ACTIVATED,0), 
    COALESCE(CURRENT_LUX,0)
    COALESCE(CURRENT_IAQ,0), 
    COALESCE(TOTAL_CLEANED_TODAY,0),
    COALESCE(LAST_CLEAN_TIMESTAMP,0),
    COALESCE(CURRENT_HUMIDITY,0)
FROM



-- subqueries    select count(case when people_in = 1 then 1 end) as TRAFFIC_COUNT_TODAY
from counter_data where device_token in (select device_token from DEVICE_LIST ) and timestamp between TO_TIMESTAMP( '2024-08-14 07:00:00', 'YYYY-MM-DD HH24:MI:SS' ) and 
TO_TIMESTAMP( '2024-08-14 18:00:00', 'YYYY-MM-DD HH24:MI:SS' )


-- Q2
select * from fragrance_data order by timestamp desc


select CASE WHEN fragrance_on = true then 'ON' else 'OFF' END as fragrance_status from fragrance_data order by timestamp desc limit 10

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

