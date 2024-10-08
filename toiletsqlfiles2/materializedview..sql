

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
CREATE MATERIALIZED VIEW IF NOT EXISTS occupancy_lag AS
SELECT
    id,
    timestamp,
    device_token,
    occupied,
    lag (occupied, 1) over (order by id) as prev_occupied
FROM occupancy_data
where timestamp > to_timestamp('2024-09-01 00:00:00', 'YYYY-MM-DD  HH24:MI:SS')
GROUP BY
    timestamp,
    device_token,
    occupied,
    id
WITH
    DATA;

select * from occupancy_data

select * from occupancy_lag

REFRESH MATERIALIZED VIEW CONCURRENTLY occupancy_lag;

DROP MATERIALIZED VIEW IF EXISTS occupancy_lag

DROP INDEX IF EXISTS occupancy_lag_idx3;

CREATE UNIQUE INDEX occupancy_lag_idx3 ON occupancy_lag(
    id,
    timestamp,
    device_token,
    occupied,
    prev_occupied
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
select distinct
    timestamp,
    device_token,
    sum(case when people_in = '1' then 1 else 0 end)as total_enter
from
    (select date_trunc('hour', counter_data.timestamp) as timestamp, device_token, people_in from counter_data
    where timestamp > current_timestamp - INTERVAL '2 DAY'
    )S1
group by device_token, timestamp
WITH
    DATA;

select * from overview_counter_data_agg

CREATE UNIQUE INDEX overview_counter_data_agg_idx3 ON overview_counter_data_agg (
    timestamp,
    device_token,
    total_enter
);

DROP INDEX IF EXISTS overview_counter_data_agg_idx3;

REFRESH MATERIALIZED VIEW CONCURRENTLY overview_counter_data_agg;

DROP MATERIALIZED VIEW IF EXISTS overview_counter_data_agg

-- cleaner report agg

select * from cleaner_reports limit 10

-- feedback panel agg

-- fp sensor agg

-- misc acion data agg

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
count(reaction) over (partition by date_trunc('hour', timestamp) order by reaction) as total_reaction_by_type_hourly,
count(reaction) over (partition by date_trunc('day', timestamp) order by reaction) as total_reaction_by_type_daily,
count(reaction) over (partition by date_trunc('month', timestamp) order by reaction) as total_reaction_by_type_monthly,
count(reaction) over (partition by date_trunc('year', timestamp) order by reaction) as total_reaction_by_type_yearly,
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