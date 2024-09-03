
select * from tenants

select * from meters

select * from event_logs

select * from log_types

select * from public.meter_pairs

# try query
select * from event_logs
join log_types on log_types.id = event_logs.log_type
join meters on meters.meter_token = event_logs.meter_token
left join meter_pairs on meter_pairs.meter_id = meters.id
left join buildings on buildings.id = meter_pairs.building_id
left join floors on floors.building_id = buildings.id
left join distributed_boards on distributed_boards.id = meter_pairs.distributed_board_id
where event_logs.meter_token = 'm01'

# event log
select timestamp, logs_details, building_name, f_loor_name, board_name
from
    event_logs
    join log_types on log_types.id = event_logs.log_type
    join meters on meters.meter_token = event_logs.meter_token
    left join meter_pairs on meter_pairs.meter_id = meters.id
    left join buildings on buildings.id = meter_pairs.building_id
    left join floors on floors.building_id = buildings.id
    left join distributed_boards on distributed_boards.id = meter_pairs.distributed_board_id
where
    event_logs.meter_token = 'm01'


# event log
select
    date(TIMESTAMP) as event_date,
    timestamp::time as event_time,
    logs_details as log_type,
    building_name,
    f_loor_name,
    board_name
from
    event_logs
    join log_types on log_types.id = event_logs.log_type
    join meters on meters.meter_token = event_logs.meter_token
    left join meter_pairs on meter_pairs.meter_id = meters.id
    left join buildings on buildings.id = meter_pairs.building_id
    left join floors on floors.building_id = buildings.id
    left join distributed_boards on distributed_boards.id = meter_pairs.distributed_board_id
where
    event_logs.meter_token = 'm01'
limit 10
offset 50