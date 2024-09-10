
select id, tariff_id from buildings where tenant_id = 'e6daf318-6516-4350-6b56-ae0a44b7e5d7'

select * from public.buildings where tenant_id = 'e6daf318-6516-4350-6b56-ae0a44b7e5d7'

select * from buildings

select * from public.tariffs

select * from public.rm_per_kilowatts

select * from public.rm_per_kilowatts where tariff_id = 'bb464c97-eb17-4d9b-52d4-eaf8733fe895'

-- tariff id bb464c97-eb17-4d9b-52d4-eaf8733fe895 

-- list meter , its token that need to calculate based on buildings
select meter_token from meters 
join meter_pairs on meter_pairs.meter_id = meters.id
where building_id = '7ab33a3f-0fb4-4d2c-a098-8dc877963664' 

select meter_token from meters 
where building_id in

select * from data_payloads where meter_token = 'm01' order by timestamp desc limit 1

select * from data_payloads where meter_token = 'm01' 
and timestamp > date_trunc('month', current_timestamp)
order by timestamp asc limit 1

select date_trunc('month', current_timestamp)


-- combined query
select initial_reading, final_reading, sum(final_reading - initial_reading) as consumed from
(select meter_token, power_consumption as final_reading from data_payloads where meter_token = 'm01' order by timestamp desc limit 1 )Q1
left join
(select meter_token, power_consumption as initial_reading from data_payloads where meter_token = 'm01' 
and timestamp > date_trunc('month', current_timestamp)
order by timestamp asc limit 1)Q2 using (meter_token)
group by initial_reading, final_reading