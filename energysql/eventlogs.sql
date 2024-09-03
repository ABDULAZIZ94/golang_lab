
select * from meters

select * from event_logs

select * from log_types

select * from public.meter_pairs

select * from event_logs
join log_types on log_types.id = event_logs.log_type
join meters on meters.meter_token = event_logs.meter_token
left join meter_pairs on meter_pairs.meter_id = meters.id
left join buildings on buildings.id = meter_pairs.building_id
left join floors on floors.building_id = buildings.id
where event_logs.meter_token = 'm01'