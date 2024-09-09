-- Active: 1722832765629@@alpha.vectolabs.com@9998@energy-staging


select * from meters

select * from meters
left join datapayloads on datapayloads.metertoken = meters.meter_token
where meters.id = '33f0d10e-a8f3-4765-7fa2-c35dcbed04e7'

select power_consumption from data_payloads where meter_token = 'm01' and color='RED' order by timestamp limit 1

select * from data_payloads where meter_token = 'm01'

select 
-- id,
    meter_token,
    -- color,
    avg(current) as avg_current,
    avg(active_power) as avg_active_power,
    avg(reactive_power) as avg_reactive_power,
    avg(frequency) as avg_frequency,
    avg(power_factor) as avg_power_factor,
    avg(phase_angle) as avg_phase_angle,
    avg(vthd) as avg_vthd,
    avg(athd) as avg_athd,
    avg(apparant_power) as avg_apparant_power,
    date_trunc('HOUR',timestamp) as uplinkts
from data_payloads where meter_token = 'm01' and timestamp 
between TO_TIMESTAMP( '2024-09-04 00:00:00', 'YYYY-MM-DD HH24:MI:SS') and
TO_TIMESTAMP( '2024-09-05 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
group by meter_token, uplinkts

-- red
select 
-- id,
    meter_token,
    color,
    avg(current) as avg_current,
    avg(active_power) as avg_active_power,
    avg(reactive_power) as avg_reactive_power,
    avg(frequency) as avg_frequency,
    avg(power_factor) as avg_power_factor,
    avg(phase_angle) as avg_phase_angle,
    avg(vthd) as avg_vthd,
    avg(athd) as avg_athd,
    avg(apparant_power) as avg_apparant_power,
    date_trunc('HOUR',timestamp) as uplinkts
from data_payloads 
where meter_token = 'm01' 
and color = 'RED'
and timestamp 
between TO_TIMESTAMP( '2024-09-04 00:00:00', 'YYYY-MM-DD HH24:MI:SS') and
TO_TIMESTAMP( '2024-09-05 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
group by meter_token, color, uplinkts

-- timestamp
--GENERATE TIMESTAMP BASED ON DATE AND INTERVAL
WITH GENTIME as (
    SELECT uplinkTS  
    FROM generate_series(
        date_trunc('HOUR', TO_TIMESTAMP('2024-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),  
        date_trunc('HOUR', TO_TIMESTAMP('2024-01-02 23:59:59', 'YYYY-MM-DD HH24:MI:SS')),  
        interval '1 HOUR'
        ) uplinkTS
) 
SELECT uplinkTS FROM GENTIME;


-- home graph query
WITH GENTIME as (
    SELECT uplinkTS  
    FROM generate_series(
        date_trunc('HOUR', TO_TIMESTAMP('2024-09-04 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),  
        date_trunc('HOUR', TO_TIMESTAMP('2024-09-05 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),  
        interval '1 HOUR'
        ) uplinkTS
)
select * 
from GENTIME
left join
(
    select
    meter_token,
    -- color,
    avg(current) as avg_current,
    avg(active_power) as avg_active_power,
    avg(reactive_power) as avg_reactive_power,
    avg(frequency) as avg_frequency,
    avg(power_factor) as avg_power_factor,
    avg(phase_angle) as avg_phase_angle,
    avg(vthd) as avg_vthd,
    avg(athd) as avg_athd,
    avg(apparant_power) as avg_apparant_power,
    date_trunc('HOUR', timestamp) as uplinkTS
    from public.data_payloads
    where
        meter_token = 'm01'
        -- and color = 'RED'
        and timestamp between TO_TIMESTAMP(
            '2024-09-04 00:00:00',
            'YYYY-MM-DD HH24:MI:SS'
        ) and TO_TIMESTAMP(
            '2024-09-05 00:00:00',
            'YYYY-MM-DD HH24:MI:SS'
        )
    group by
        meter_token,
        color,
        uplinkts
)Q1 using(uplinkTS)
order by uplinkTS

-- home data
select 
    meter_token, voltage, current, power_factor, frequency, 
    is_online
from
(select 
meter_token,
vthd as voltage,
current,
power_factor,
frequency 
from data_payloads
where meter_token = 'm02'
order by timestamp limit 1)Q1
left join
    (
        select
            meter_token, 
            is_online 
        from meters 
        where meter_token = 'm02' 
        order by created_at desc limit 1
    )Q2 using (meter_token)


-- eventlogs
select * from event_logs

select * from log_types

select * from meter_pairs

select * from public.addresses

select * from public.buildings

select * from meter_pairs
join meters on meter_pairs.meter_id = meters.id

select  log_types.logs_details as Title, Timestamp, buildings.id
from event_logs
join log_types on log_types.id = event_logs.log_type
join meters on meters.meter_token = event_logs.meter_token
join meter_pairs on meter_pairs.meter_id = meters.id
join buildings on buildings.id = meter_pairs.building_id
where event_logs.meter_token = 'm01'
-- join addresses on addresses.building_id = buildings.id


select * from states

select * from districts

select street, poscode, district_name, state_name
from meters
join meter_pairs on meter_pairs.meter_id = meters.id
join buildings on meter_pairs.building_id = buildings.id
join addresses on addresses.building_id = buildings.id
join states on states.state_id = addresses.state
join districts on districts.id = addresses.district
where meters.meter_token = 'm01'

-- fail query
WITH
    GENTIME as (
        SELECT uplinkTS
        FROM generate_series(
                date_trunc(
                    'HOUR', TO_TIMESTAMP(
                        '2024-09-04 00:00:00', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), date_trunc(
                    'HOUR', TO_TIMESTAMP(
                        '2024-09-05 00:00:00', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), interval '1 HOUR'
            ) uplinkTS
    )
select *
from GENTIME
    left join (
        select
            meter_token, avg(current) as avg_current, avg(active_power) as avg_active_power, avg(reactive_power) as avg_reactive_power, avg(frequency) as avg_frequency, avg(power_factor) as avg_power_factor, avg(phase_angle) as avg_phase_angle, avg(vthd) as avg_vthd, avg(athd) as avg_athd, avg(apparant_power) as avg_apparant_power, date_trunc('HOUR', timestamp) as uplinkTS
        from public.data_payloads
        where
            meter_token = 'm01'
            and timestamp between TO_TIMESTAMP(
                '2024-09-04 00:00:00', 'YYYY-MM-DD HH24:MI:SS'
            ) and TO_TIMESTAMP(
                '2024-09-05 00:00:00', 'YYYY-MM-DD HH24:MI:SS'
            )
        group by
            meter_token, color, uplinkts
    ) Q1 using (uplinkTS)
order by uplinkTS


-- home controller power factor not exist
WITH
    GENTIME as (
        SELECT uplinkTS
        FROM generate_series(
                date_trunc(
                    'HOUR', TO_TIMESTAMP(
                        '2024-09-04 00:00:00', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), date_trunc(
                    'HOUR', TO_TIMESTAMP(
                        '2024-09-05 00:00:00', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), interval '1 HOUR'
            ) uplinkTS
    )
select
    meter_token,
    COALESCE(avg_voltage, 0) as avg_voltage,
    COALESCE(avg_current, 0) as avg_current,
    COALESCE(avg_power_consumption, 0) as avg_power_consumption,
    COALESCE(avg_power_factor, 0) as avg_power_factor,
    COALESCE(frequency, 0) as avg_frequency,
    COALESCE(vthd, 0) as avg_vthd,
    COALESCE(athd, 0) as avg_athd,
    GENTIME.uplinkTS
from GENTIME
    left join (
        select
            meter_token, avg(voltage) as avg_voltage, avg(current) as avg_current, avg(power_consumption) as avg_power_consumption, avg(power_factor) as avg_power_factor, avg(frequency) as avg_frequency, avg(vthd) as avg_vthd, avg(athd) as avg_athd, date_trunc('HOUR', timestamp) as uplinkTS
        from public.data_payloads
        where
            meter_token = 'm01'
            and timestamp between TO_TIMESTAMP(
                '2024-09-04 00:00:00', 'YYYY-MM-DD HH24:MI:SS'
            ) and TO_TIMESTAMP(
                '2024-09-05 00:00:00', 'YYYY-MM-DD HH24:MI:SS'
            )
        group by
            meter_token, color, uplinkts
    ) Q1 using (uplinkTS)
order by uplinkTS


-- 
WITH
    GENTIME as (
        SELECT uplinkTS
        FROM generate_series(
                date_trunc(
                    'HOUR', TO_TIMESTAMP(
                        '2024-09-05 00:00:00', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), date_trunc(
                    'HOUR', TO_TIMESTAMP(
                        '2024-09-06 23:59:59', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), interval '1 HOUR'
            ) uplinkTS
    )
select
    meter_token,
    COALESCE(avg_voltage, 0) as avg_voltage,
    COALESCE(avg_current, 0) as avg_current,
    COALESCE(avg_power_consumption, 0) as avg_power_consumption,
    COALESCE(avg_power_factor, 0) as avg_power_factor,
    COALESCE(avg_frequency, 0) as avg_frequency,
    COALESCE(avg_vthd, 0) as avg_vthd,
    COALESCE(avg_athd, 0) as avg_athd,
    GENTIME.uplinkTS
from GENTIME
    left join (
        select
            meter_token, avg(voltage) as avg_voltage, avg(current) as avg_current, avg(power_consumption) as avg_power_consumption, avg(power_factor) as avg_power_factor, avg(frequency) as avg_frequency, avg(vthd) as avg_vthd, avg(athd) as avg_athd, date_trunc('HOUR', timestamp) as uplinkTS
        from public.data_payloads
        where
            meter_token = 'm01'
            and timestamp between TO_TIMESTAMP(
                '2024-09-04 00:00:00', 'YYYY-MM-DD HH24:MI:SS'
            ) and TO_TIMESTAMP(
                '2024-09-05 00:00:00', 'YYYY-MM-DD HH24:MI:SS'
            )
        group by
            meter_token, color, uplinkts
    ) Q1 using (uplinkTS)
order by uplinkTS


-- update
update data_payloads set voltage = 1000.0 where voltage IS NULL

update data_payloads set power_consumption = 1000.0 where power_consumption IS NULL


select * from data_payloads 
where meter_token = 'm01'
order by timestamp desc limit 1


select * from data_payloads where voltage is null

-- add energy consumption to home hourly res
select
    meter_token,
    voltage,
    current,
    power_factor,
    frequency,
    is_online,
    power_consumption as energy_consumption
from (
        select
            meter_token, vthd as voltage, current, power_factor, power_consumption, frequency
        from data_payloads
        where
            meter_token = 'm01'
        order by timestamp desc
        limit 1
    ) Q1
    left join (
        select meter_token, is_online
        from meters
        where
            meter_token = 'm01'
        order by created_at desc
        limit 1
    ) Q2 using (meter_token)

-- calculate current energy bill

select tariff_id from buildings where buildings.id = '7ab33a3f-0fb4-4d2c-a098-8dc877963664'

select * from rm_per_kilowatts where tariff_id = 'bb464c97-eb17-4d9b-52d4-eaf8733fe895' order by sequence

select meter_token from meters where tenant_id = 'e6daf318-6516-4350-6b56-ae0a44b7e5d7'

select power_consumption from data_payloads order by timestamp desc limit 1


select rm, sequence 
from buildings
left join tariffs on tariffs.id = buildings.tariff_id
left join 

WITH BUILDING_LISTS AS(
    select id from buildings where tenant_id = 'e6daf318-6516-4350-6b56-ae0a44b7e5d7'
)
select current_energy_bills
from
(
    select 
)Q1