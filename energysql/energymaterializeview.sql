with
    building_lists as (
        select id
        from buildings
        where
            tenant_id = '2737d55e-eb74-41e5-6809-3a9efe8767ce'
    ),
    meter_lists as (
        select meter_token, co2_kg_per_kwh
        from
            meters
            join meter_pairs on meter_pairs.meter_id = meters.id
            join buildings on buildings.id = meter_pairs.building_id
            join carbon_emmisions on carbon_emmisions.id = buildings.carbon_emmision_id
        where
            buildings.id in (
                select id
                from building_lists
            )
    ),
    day_lists as (
        SELECT distinct
            EXTRACT(
                DAY
                FROM today
            ) as today,
            EXTRACT(
                MONTH
                FROM today
            ) as month
        FROM generate_series(
                date_trunc(
                    'DAY', TO_TIMESTAMP(
                        '2024-08-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), date_trunc(
                    'DAY', TO_TIMESTAMP(
                        '2024-09-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), INTERVAL '1 DAY'
            ) AS TODAY
        order by today asc
    ),
    this_month_consumption as (
        select
            EXTRACT(
                DAY
                FROM timestamp
            ) as today,
            sum(power_consumption) as daily_power_consumption_this_month
        from data_payloads
        where
            timestamp between to_timestamp(
                '2024-09-01 00:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and to_timestamp(
                '2024-09-30 00:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
            and meter_token in (
                select meter_token
                from meter_lists
            )
        group by
            today
        order by today
    ),
    prev_month_consumption as (
        select
            EXTRACT(
                DAY
                FROM timestamp
            ) as today,
            sum(power_consumption) as daily_power_consumption_prev_month
        from data_payloads
        where
            timestamp between to_timestamp(
                '2024-08-01 00:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and to_timestamp(
                '2024-08-30 00:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
            and meter_token in (
                select meter_token
                from meter_lists
            )
        group by
            today
        order by today
    ),
    this_months_emmisions as (
        select
            EXTRACT(
                DAY
                FROM timestamp
            ) as today,
            sum(power_consumption) * co2_kg_per_kwh as daily_power_consumption_this_month_e
        from meter_lists
            join data_payloads on data_payloads.meter_token = meter_lists.meter_token
        where
            timestamp between to_timestamp(
                '2024-09-01 00:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and to_timestamp(
                '2024-09-30 00:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
        group by
            today,
            co2_kg_per_kwh
        order by today
    ),
    prev_months_emmisions as (
        select
            EXTRACT(
                DAY
                FROM timestamp
            ) as today,
            sum(power_consumption) * co2_kg_per_kwh as daily_power_consumption_prev_month_e
        from meter_lists
            join data_payloads on data_payloads.meter_token = meter_lists.meter_token
        where
            timestamp between to_timestamp(
                '2024-08-01 00:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and to_timestamp(
                '2024-08-30 00:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
        group by
            today,
            co2_kg_per_kwh
        order by today
    )
select
    today,
    month,
    COALESCE(
        daily_power_consumption_this_month,
        0
    ) as daily_power_consumption_this_month,
    COALESCE(
        daily_power_consumption_prev_month,
        0
    ) as daily_power_consumption_prev_month,
    COALESCE(
        daily_power_consumption_this_month_e,
        0
    ) as daily_power_consumption_this_month_e,
    COALESCE(
        daily_power_consumption_prev_month_e,
        0
    ) as daily_power_consumption_prev_month_e
from
    day_lists
    left join this_month_consumption using (today)
    left join prev_month_consumption using (today)
    left join this_months_emmisions using (today)
    left join prev_months_emmisions using (today)
order by today, month


-- materialized view data payloads monthly
CREATE MATERIALIZED VIEW IF NOT EXISTS data_payloads_monthly AS
select
    timestamp,
    sum(power_consumption) as power_consumption,
    sum(power_consumption) * co2_kg_per_kwh as daily_power_consumption_this_month_e,
    Q1.meter_token
    from (
        select date_trunc('DAY', timestamp) as timestamp, power_consumption, meter_token from data_payloads
    )Q1 
    join meters on meters.meter_token = Q1.meter_token
    join meter_pairs on meter_pairs.meter_id = meters.id
    join buildings on buildings.id = meter_pairs.building_id
    join carbon_emmisions on carbon_emmisions.id = buildings.carbon_emmision_id
    group by timestamp, Q1.meter_token, co2_kg_per_kwh
WITH DATA

select date_trunc('DAY', timestamp) as timestamp, power_consumption, meter_token from data_payloads

REFRESH MATERIALIZED VIEW data_payloads_monthly

select * from  data_payloads_monthly

REFRESH MATERIALIZED VIEW CONCURRENTLY data_payloads_monthly



-- data 
CREATE MATERIALIZED VIEW IF NOT EXISTS meter_co2 AS
select meter_token, co2_kg_per_kwh
from
    meters
    join meter_pairs on meter_pairs.meter_id = meters.id
    join buildings on buildings.id = meter_pairs.building_id
    join carbon_emmisions on carbon_emmisions.id = buildings.carbon_emmision_id
WITH DATA

select * from meter_co2