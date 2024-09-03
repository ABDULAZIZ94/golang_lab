
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