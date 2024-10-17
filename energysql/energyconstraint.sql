-- Active: 1722832765629@@alpha.vectolabs.com@9998@energy-staging

# meter constraint
alter table building_meter_pairs
add constraint building_meter_pairs_meters_constraint
foreign key(meter_id)
references meters(id);

# db consraint
alter table building_meter_pairs
add constraint building_meter_pairs_buildings_constraint 
foreign key (building_id) references buildings(id);






with
    building_lists as (
        select id
        from buildings
        where
            tenant_id = 'e6daf318-6516-4350-6b56-ae0a44b7e5d7'
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
            date_trunc('DAY', TODAY) as today,
            date_trunc('MONTH', TODAY) as month
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
    ),
    this_month_consumption as (
        select
            date_trunc('DAY', timestamp) as today,
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
    ),
    prev_month_consumption as (
        select
            date_trunc('DAY', timestamp) as today,
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
    ),
    this_months_emmisions as (
        select
            date_trunc('DAY', timestamp) as today,
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
    ),
    prev_months_emmisions as (
        select
            date_trunc('DAY', timestamp) as today,
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
    )
select
    EXTRACT('DAY', today) as TODAY,
    EXTRACT('MONTH', month) as MONTH,
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