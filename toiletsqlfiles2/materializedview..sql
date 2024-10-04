-- Active: 1722832765629@@alpha.vectolabs.com@9998@smarttoilet-staging

select * from occupancy_data

CREATE MATERIALIZED VIEW env_agg as
    select 
    avg(iaq)::int as iaq,
    avg(temperature)::int as temperature,
    avg(humidity)::int as humidity,
    avg(lux)::int as lux,
    date_trunc('HOUR', timestamp) as uplinkts, device_token
    from enviroment_data
    group by uplinkts, device_token
WITH DATA

DROP INDEX env_agg_idx

CREATE UNIQUE INDEX env_agg_idx ON env_agg (uplinkts, device_token);

REFRESH MATERIALIZED VIEW CONCURRENTLY env_agg

CREATE MATERIALIZED VIEW IF NOT EXISTS env_agg as
select
    avg(iaq)::int as iaq,
    avg(temperature)::int as temperature,
    avg(humidity)::int as humidity,
    avg(lux)::int as lux,
    date_trunc('HOUR', timestamp) as uplinkts,
    device_token
from enviroment_data
group by
    uplinkts,
    device_token
WITH DATA;

select * from enviroment_data

DROP MATERIALIZED VIEW IF EXISTS env_agg

DROP VIEW IF EXISTS env_agg

REFRESH MATERIALIZED VIEW env_agg

select * from env_agg order by uplinkts desc limit 10

CREATE INDEX env_agg_idx ON env_agg (uplinkts DESC);

CREATE MATERIALIZED VIEW IF NOT EXISTS occupancy_agg AS
WITH
    occupancy_cte AS (
        SELECT
            date_trunc('hour', timestamp) AS truncated_time,
            device_token,
            occupied,
            LAG(occupied, 1) OVER (
                ORDER BY id
            ) AS prev_occupied
        FROM occupancy_data
    )
SELECT
    truncated_time,
    device_token,
    occupied,
    prev_occupied,
    SUM(
        CASE
            WHEN occupied = true
            AND prev_occupied = false THEN 1
            ELSE 0
        END
    ) AS new_person_enter
FROM occupancy_cte
GROUP BY
    truncated_time,
    device_token,
    occupied,
    prev_occupied
WITH
    NO DATA;


CREATE MATERIALIZED VIEW IF NOT EXISTS standard_view_devices AS
select devices.device_token, device_types.device_type_id as namespace_id, device_pairs.toilet_info_id
from
    device_pairs
    join devices on devices.device_id = device_pairs.device_id
    join device_types on device_types.device_type_id = devices.device_type_id
    join toilet_infos on toilet_infos.toilet_info_id = device_pairs.toilet_info_id
    join toilet_types on toilet_types.toilet_type_id = toilet_infos.toilet_type_id
WITH NO DATA;

select * from standard_view_devices

REFRESH MATERIALIZED VIEW standard_view_devices;

DROP MATERIALIZED VIEW IF EXISTS standart_view_devices

REFRESH MATERIALIZED VIEW occupancy_agg;

SELECT * FROM occupancy_agg;

EXPLAIN
SELECT *
FROM occupancy_agg
WHERE
    truncated_time > NOW() - INTERVAL '1 HOUR';

SELECT *
FROM occupancy_agg
WHERE
    truncated_time > NOW() - INTERVAL '12 HOUR';

CREATE INDEX occupancy_agg_idx3 ON occupancy_agg (truncated_time, device_token, new_person_enter);

select * from device_lists where toilet_info_id = '9388096c-784d-49c8-784c-1868b1233165' and namespace_id ='10'


with
        start_end as (select to_timestamp('2024-10-02 23:00:00', 'YYYY-MM-DD HH24:MI:SS') as start_date, to_timestamp('2024-10-03 16:00:00', 'YYYY-MM-DD HH24:MI:SS') as end_date),
        device_list as (
                select
                        standard_view_devices.device_token,
                        standard_view_devices.namespace_id,
                        standard_view_devices.toilet_info_id
                from standard_view_devices
                where
                        standard_view_devices.toilet_info_id = 'a97891e5-14df-4f95-7d1e-4ee601581df2'
        ) 
select sum(people_in) as ttltraffic
from counter_data
join device_list using (device_token)
where device_list.namespace_id = 2
-- and extract(hour from timestamp) >= 7 and extract(hour from timestamp) <= 18
and timestamp between (select start_date from start_end) and (select end_date from start_end)


select * from counter_data where device_token ='102' order by timestamp desc limit 3


    with
            start_end as (select to_timestamp('2024-10-02 23:00:00', 'YYYY-MM-DD HH24:MI:SS') as start_date, to_timestamp('2024-10-03 16:00:00', 'YYYY-MM-DD HH24:MI:SS') as end_date),
            device_list as (
                    select
                            standard_view_devices.device_token,
                            standard_view_devices.namespace_id,
                            standard_view_devices.toilet_info_id
                    from standard_view_devices
                    where
                            standard_view_devices.toilet_info_id = 'a97891e5-14df-4f95-7d1e-4ee601581df2'
            ) 
    select
            coalesce(ttltraffic, '0') as total_counter,
            last_counter_ts as last_counter_cnt_timestamp,
            iaq as odour_level,
            total_fragrance
            from
                    -- (select device_list.toilet_info_id from device_list limit 1) as Q0
                    -- cross join
                    (
                    select sum(people_in) as ttltraffic
                    from counter_data
                    join device_list using (device_token)
                    where device_list.namespace_id = 2
                    -- and extract(hour from timestamp) >= 7 and extract(hour from timestamp) <= 18
                    and timestamp between (select start_date from start_end) and (select end_date from start_end)
                    ) as Q1
                    cross join
                    (
                    select iaq
                    from enviroment_data
                    join device_list using (device_token)
                    where device_list.namespace_id = 3
                    -- and extract(hour from timestamp) >= 7 and extract(hour from timestamp) <= 18
                    and timestamp between (select start_date from start_end) and (select end_date from start_end)
                    order by timestamp desc limit 1
                    ) as Q2
                    cross join
                    (
                    select count(misc_data_id) as total_fragrance
                    from misc_action_data
                    join device_list using (device_token)
                    where misc_action_data.namespace = 'FRESHENER'
                    -- and extract(hour from timestamp) >= 7 and extract(hour from timestamp) <= 18
                    and timestamp between (select start_date from start_end) and (select end_date from start_end)
                    ) as Q7
                    left join
                    (
                            select timestamp as last_counter_ts
                            from counter_data
                            join device_list using (device_token)
                            where device_list.namespace_id = 2
                            -- and extract(hour from timestamp) >= 7 and extract(hour from timestamp) <= 18
                            and timestamp between (select start_date from start_end) and (select end_date from start_end)
                            order by timestamp desc limit 1
                    ) as Q9 ON TRUE
