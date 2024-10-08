

-- env agg
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

REFRESH MATERIALIZED VIEW env_agg

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

-- occupanct data agg

-- occupancy lag
CREATE MATERIALIZED VIEW IF NOT EXISTS occupancy_agg AS
with 
    occ_lag as (SELECT
        id,
        timestamp,
        device_token,
        occupied,
        lag (occupied, 1) over (order by id) as prev_occupied
        FROM occupancy_data
        -- where 
        -- timestamp between to_timestamp('2024-05-01 00:00:00', 'YYYY-MM-DD  HH24:MI:SS') 
        -- and to_timestamp( '2024-09-02 00:00:00', 'YYYY-MM-DD HH24:MI:SS' ) and
        -- device_token = '113'
        order by timestamp desc
    ),
    occ_entrance as (
        SELECT
            id,
            timestamp,
            date_trunc('hour', timestamp) as timestamp_hourly,
            date_trunc('day', timestamp) as timestamp_daily,
            date_trunc('month', timestamp) as timestamp_monthly,
            date_trunc('year', timestamp) as timestamp_yearly,
            device_token,
            occupied,
            prev_occupied,
            sum(case when occupied = true and prev_occupied = false then 1 else 0 end) over ( partition by date_trunc('hour', timestamp), device_token ) as sum_hourly,
            sum(case when occupied = true and prev_occupied = false then 1 else 0 end) over ( partition by date_trunc('day', timestamp) , device_token) as sum_daily,
            sum(case when occupied = true and prev_occupied = false then 1 else 0 end) over ( partition by date_trunc('month', timestamp), device_token) as sum_monthly,
            sum(case when occupied = true and prev_occupied = false then 1 else 0 end) over ( partition by date_trunc('year', timestamp), device_token) as sum_yearly
            FROM occ_lag
    )
select * from occ_entrance
WITH
    DATA;

select * from occupancy_data

select * from occupancy_agg

REFRESH MATERIALIZED VIEW CONCURRENTLY occupancy_agg;

DROP MATERIALIZED VIEW IF EXISTS occupancy_lag

DROP INDEX IF EXISTS occupancy_lag_idx3;

CREATE UNIQUE INDEX occupancy_agg_idx3 ON occupancy_agg(
    id,
    timestamp,
    timestamp_hourly,
    timestamp_daily,
    timestamp_monthly,
    timestamp_yearly,
    device_token,
    occupied,
    prev_occupied,
    sum_hourly,
    sum_daily,
    sum_monthly,
    sum_yearly
);    

--  standard view device
CREATE MATERIALIZED VIEW IF NOT EXISTS standard_view_devices AS
select 
    devices.device_id, 
    devices.device_token, 
    device_types.device_type_id as namespace_id, 
    device_pairs.toilet_info_id
from
    device_pairs
    join devices on devices.device_id = device_pairs.device_id
    join device_types on device_types.device_type_id = devices.device_type_id
    join toilet_infos on toilet_infos.toilet_info_id = device_pairs.toilet_info_id
    join toilet_types on toilet_types.toilet_type_id = toilet_infos.toilet_type_id
WITH DATA;

select * from standard_view_devices

CREATE UNIQUE INDEX standard_view_devices_idx3 ON standard_view_devices (device_id, device_token, namespace_id, toilet_info_id);

DROP INDEX IF EXISTS standard_view_devices_idx3;

REFRESH MATERIALIZED VIEW CONCURRENTLY standard_view_devices;

DROP MATERIALIZED VIEW IF EXISTS standard_view_devices


-- devices analytic all
CREATE MATERIALIZED VIEW IF NOT EXISTS analytics_devices AS
select
    devices.device_name,
    devices.device_id, 
    devices.device_token,
    toilet_infos.toilet_name as identifier,
    toilet_infos.toilet_info_id as identifier_id,
    device_types.device_type_name as namespace,
    device_types.device_type_id as namespace_id, 
    device_pairs.toilet_info_id,
    devices.tenant_id
from
    device_pairs
    join devices on devices.device_id = device_pairs.device_id
    join device_types on device_types.device_type_id = devices.device_type_id
    join toilet_infos on toilet_infos.toilet_info_id = device_pairs.toilet_info_id
    join toilet_types on toilet_types.toilet_type_id = toilet_infos.toilet_type_id
WITH
    DATA;

select * from analytics_devices

CREATE UNIQUE INDEX analytics_devices_idx3 ON analytics_devices (
device_name,
device_id,
device_token,
identifier,
identifier_id,
namespace,
namespace_id,
toilet_info_id,
tenant_id
);

DROP INDEX IF EXISTS analytics_devices_idx3;

REFRESH MATERIALIZED VIEW CONCURRENTLY analytics_devices;

DROP MATERIALIZED VIEW IF EXISTS analytics_devices

-- cubical materialize view
CREATE MATERIALIZED VIEW IF NOT EXISTS overview_cubical_devices AS
    select devices.device_token, 
        devices.device_type_id,
        device_cubical_pairs.cubical_id
    from device_cubical_pairs
    join devices on devices.device_id = device_cubical_pairs.device_id 
WITH
    DATA;


select * from overview_cubical_devices

REFRESH MATERIALIZED VIEW CONCURRENTLY overview_cubical_devices;

CREATE UNIQUE INDEX overview_cubical_devices_idx ON overview_cubical_devices (device_token, device_type_id, cubical_id);


-- 
select * from occupancy_data


-- counter data agg

select * from counter_data limit 10

CREATE MATERIALIZED VIEW IF NOT EXISTS overview_counter_data_agg AS
with 
    counter_lag as (
        timestamp, device_token, people_in
        from counter_data
        where
        timestamp > current_timestamp - INTERVAL '2 DAY'
    ),
    counter_agg(
        select
            timestamp,
            date_trunc('hour',timestamp) as timestamp_hourly,
            date_trunc('day', timestamp) as timestamp_day,
            date_trunc('month', timestamp) as timestamp_monthly,
            date_trunc('year', timestamp) as timestamp_year,
            device_token,
            sum(case when people_in = '1' then 1 else 0 end) over (partition by timestamp, device_token) as enter,
            sum(case when people_in = '1' then 1 else 0 end) over (partition by date_trunc('hour', timestamp), device_token) as enter_hourly,
            sum(case when people_in = '1' then 1 else 0 end) over (partition by date_trunc('day', timestamp), device_token) as enter_day,
            sum(case when people_in = '1' then 1 else 0 end) over (partition by date_trunc('month', timestamp), device_token) as enter_month,
            sum(case when people_in = '1' then 1 else 0 end) over (partition by date_trunc('year', timestamp), device_token) as enter_year,
        from
            counter_lag
    )
select * from counter_agg
WITH
    DATA;

select * from overview_counter_data_agg

CREATE UNIQUE INDEX overview_counter_data_agg_idx3 ON overview_counter_data_agg (
    timestamp,
    timestamp_hourly,
    timestamp_day,
    timestamp_monthly,
    timestamp_year,
    device_token,
    enter,
    enter_hourly,
    enter_day,
    enter_month,
    enter_year
);

DROP INDEX IF EXISTS overview_counter_data_agg_idx3;

REFRESH MATERIALIZED VIEW CONCURRENTLY overview_counter_data_agg;

DROP MATERIALIZED VIEW IF EXISTS overview_counter_data_agg

-- panic_btn data
select * from panic_btn_data

-- freshener data
select * from freshener_data

-- ammonia data
select * from ammonia_data

-- cleaner report agg
select * from cleaner_reports limit 10

-- feedback panel agg

select * from feedback_panel_data

-- fp sensor agg
select * from fp_sensor_data

-- misc acion data agg
select * from misc_action_data

-- user reactions agg
select * from user_reactions limit 10

-- truncate dates
select date_trunc('hour', timestamp) as timestamp, toilet_type, reaction, complaint, toilet_id, score 
from user_reactions

-- using windows function to create needed column so a view is suitable for many queries
CREATE MATERIALIZED VIEW IF NOT EXISTS user_reaction_agg AS
select 
    timestamp, 
    date_trunc('hour', timestamp) timestamp_hourly, 
    date_trunc('day', timestamp) timestamp_daily,
    date_trunc('month', timestamp) timestamp_monthly,
    date_trunc('year', timestamp) timestamp_yearly,
    reaction, 
count(reaction) over (partition by date_trunc('hour', timestamp),reaction) as total_reaction_by_type_hourly,
count(reaction) over (partition by date_trunc('day', timestamp), reaction) as total_reaction_by_type_daily,
count(reaction) over (partition by date_trunc('month', timestamp), reaction) as total_reaction_by_type_monthly,
count(reaction) over (partition by date_trunc('year', timestamp), reaction) as total_reaction_by_type_yearly,
count(reaction) over (partition by date_trunc('hour', timestamp) ) as total_reaction_by_type_hourly_all,
count(reaction) over (partition by date_trunc('day', timestamp) ) as total_reaction_by_type_daily_all,
count(reaction) over (partition by date_trunc('month', timestamp) ) as total_reaction_by_type_monthly_all,
count(reaction) over (partition by date_trunc('year', timestamp) ) as total_reaction_by_type_yearly_all
from 
    user_reactions
group by timestamp, reaction
order by timestamp desc, reaction
WITH DATA;

select * from user_reaction_agg


DROP MATERIALIZED VIEW IF EXISTS user_reaction_agg

REFRESH MATERIALIZED VIEW CONCURRENTLY user_reaction_agg;

CREATE UNIQUE INDEX user_reaction_agg_idx3 ON user_reaction_agg (
    timestamp,
    timestamp_hourly,
    timestamp_daily,
    timestamp_monthly,
    timestamp_yearly,
    reaction,
    total_reaction_by_type_hourly,
    total_reaction_by_type_daily,
    total_reaction_by_type_monthly,
    total_reaction_by_type_yearly,
    total_reaction_by_type_hourly_all,
    total_reaction_by_type_daily_all,
    total_reaction_by_type_monthly_all,
    total_reaction_by_type_yearly_all
);


select distinct timestamp_hourly, total_reaction_by_type_hourly, reaction from user_reaction_agg order by timestamp_hourly desc