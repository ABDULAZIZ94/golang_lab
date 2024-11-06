-- Active: 1722832765629@@alpha.vectolabs.com@9998@energy-staging

# check tables

select * from public.addresses

select * from public.users

select * from public.tenants

select * from tariffs

select * from public.meters

select * from public.buildings

select * from public.distributed_boards

select * from public.meter_pairs

select * from public.event_logs

select 
    count( case when log_type=3 then 1 end) overvolt,
    count( case when log_type = 1 then 1 end ) undervolt
from public.event_logs

# event long analyaze
delete from public.event_logs where timestamp=NULL

delete from public.event_logs where date_time < to_timestamp('2024-08-30 00:00:00','YYYY-MM-DD HH24:MI:SS')

delete from public.event_logs where metertoken IS NULL


select * from enertraces order by timestamp desc limit 10


UPDATE "loads"
SET
    "updated_at" = '2024-10-17 23:58:05.973'
WHERE
    id = 'fadbe8c3-e90b-41e0-6e3b-ba6731c5adb1'
    AND "loads"."deleted_at" IS NULL





UPDATE "loads"
SET
    "id" = 'fadbe8c3-e90b-41e0-6e3b-ba6731c5adb1',
    "is_three_phase" = false,
    "load_name" = 'Fridge Updated Ver4',
    "load_token" = 'Load_2',
    "phase_color" = 'Red',
    "phase_color_valid" = true,
    "load_threshold_min" = 300,
    "load_threshold_max" = 200,
    "operation_start_hour" = '2000-01-01 08:00:00',
    "operation_end_hour" = '2000-01-01 21:00:00',
    "updated_at" = '2024-10-29 18:55:59.213'
WHERE
    id = 'fadbe8c3-e90b-41e0-6e3b-ba6731c5adb1'
    AND "loads"."deleted_at" IS NULL



update enertraces set load_token = 'Load_9' where load_number = 9




SELECT DISTINCT
    COALESCE(AVG(VOLTAGE), 0) AS TODAY_VOLTAGE,
    COALESCE(AVG(CURRENT_LOAD), 0) AS TODAY_CURRENT,
    COALESCE(AVG(TOTAL_IMPORT_ENERGY), 0) AS TODAY_POWER_CONSUMPTION,
    date_trunc('HOUR', TIMESTAMP) AS UPLINKTS
FROM ENERTRACES
    LEFT JOIN LOADS USING (LOAD_TOKEN)
WHERE
    TIMESTAMP BETWEEN (
        CURRENT_TIMESTAMP - INTERVAL '1 DAY'
    ) AND CURRENT_TIMESTAMP AND  id = 'cfcd93fd-50db-47c3-4577-441f2e8ff90e'
GROUP BY
    UPLINKTS
order by UPLINKTS



{ "Voltage_Data": {"Frequency":"42482B8F","Voltage_THD_1":"3FE7AE14","Voltage_THD_2":"3FB851EC","Voltage_THD_3":"3FA7AE14","Voltage_1":"436F5943","Voltage_2":"436F0BED","Voltage_3":"436FF1B3"}}


-- fail query

SELECT DISTINCT
    COALESCE(AVG(VOLTAGE), 0) AS TODAY_VOLTAGE,
    COALESCE(AVG(CURRENT_LOAD), 0) AS TODAY_CURRENT,
    COALESCE(AVG(TOTAL_IMPORT_ENERGY), 0) AS TODAY_POWER_CONSUMPTION,
    date_trunc(
        'HOUR',
        TIMESTAMP AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'
    ) AS UPLINKTS
FROM ENERTRACES
    LEFT JOIN LOADS USING (LOAD_TOKEN)
WHERE
    TIMESTAMP AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur' BETWEEN (
        CURRENT_TIMESTAMP AT TIME ZONE 'Asia/Kuala_Lumpur' - INTERVAL '1 DAY'
    ) AND CURRENT_TIMESTAMP  AT TIME ZONE 'Asia/Kuala_Lumpur'
    AND id = '7d836977-943e-41a5-68b5-ac3c1a7ba9ec'
GROUP BY
    UPLINKTS
order by UPLINKTS



-- check data
select  
date_trunc(
    'HOUR',
    TIMESTAMP AT TIME ZONE 'Asia/Kuala_Lumpur'
) AS UPLINKTS, timestamp, *
from enertraces 
left join loads using(load_token) 
where 
TIMESTAMP AT TIME ZONE 'Asia/Kuala_Lumpur' BETWEEN (
    CURRENT_TIMESTAMP AT TIME ZONE 'Asia/Kuala_Lumpur' - INTERVAL '1 DAY'
) AND CURRENT_TIMESTAMP  AT TIME ZONE 'Asia/Kuala_Lumpur' and
id = '7d836977-943e-41a5-68b5-ac3c1a7ba9ec'
order by timestamp desc
limit 10 


SELECT DISTINCT ON (load_token) *
FROM "whatsapp_notifications"
WHERE
    sent = false
    AND type = 'overload'
ORDER BY load_token,timestamp DESC