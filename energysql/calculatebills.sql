
select id, tariff_id from buildings where tenant_id = 'e6daf318-6516-4350-6b56-ae0a44b7e5d7'

select * from public.buildings where tenant_id = 'e6daf318-6516-4350-6b56-ae0a44b7e5d7'

select * from public.meter_pairs

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


-- 
select kilowatt, rm, sequence from rm_per_kilowatts where tariff_id = 'bb464c97-eb17-4d9b-52d4-eaf8733fe895' order by sequence 

--
select meter_token, * from meters join meter_pairs on meter_pairs.meter_id = meters.id 

select meter_token from meters join meter_pairs on meter_pairs.meter_id = meters.id where building_id = 'ad91d7df-15f2-4b38-7a33-1fbbce2fa482'


-- total meter online per total meters
with meter_lists as (
    select meter_token from meters where tenant_id = 'e6daf318-6516-4350-6b56-ae0a44b7e5d7'
)
select ops_meters_up, ops_meters_total 
from
    (select count(id) as ops_meters_total from meters where meter_token in
        (select meter_token from meter_lists)
      )Q1 
cross join
    (select count(id) as ops_meters_up from meters where meter_token in 
    ( select meter_token from meter_lists )
     and is_online = true)Q2


-- total energy consumed by load

select * from meters

with meter_lists as (
    select meter_token, meter_name from meters where tenant_id = 'e6daf318-6516-4350-6b56-ae0a44b7e5d7'
)
select distinct meter_name
from  meter_lists
left join 
(select meter_token from data_payloads 
where timestamp between date_trunc('month', current_timestamp) and current_timestamp
order by power_consumption desc limit 5 )Q1 using(meter_token)


select * from public.data_payloads
order by timestamp desc limit 5

select current_timestamp

select date_trunc('month', current_timestamp)