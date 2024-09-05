

select * from meters

select * from meters
left join datapayloads on datapayloads.metertoken = meters.meter_token
where meters.id = '33f0d10e-a8f3-4765-7fa2-c35dcbed04e7'

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