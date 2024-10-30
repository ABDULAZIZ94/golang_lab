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