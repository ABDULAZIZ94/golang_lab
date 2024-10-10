
-- active connection

select * from public.locations

-- env agg
CREATE MATERIALIZED VIEW env_agg as
    SELECT 
        env_data_id,
        timestamp ,
        date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') AS timestamp_hourly,
        date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') AS timestamp_daily,
        date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') AS timestamp_monthly,
        date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') AS timestamp_yearly,
        CAST(avg(iaq) OVER (PARTITION BY date_trunc('minute', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) AS int) AS avg_iaq_minutely,
        CAST(avg(iaq) OVER (PARTITION BY date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) AS int) AS avg_iaq_hourly,
        CAST(avg(iaq) OVER (PARTITION BY date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) AS int) AS avg_iaq_daily,
        CAST(avg(iaq) OVER (PARTITION BY date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) AS int) AS avg_iaq_monthly,
        CAST(avg(iaq) OVER (PARTITION BY date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) AS int) AS avg_iaq_yearly,
        CAST(avg(temperature) OVER (PARTITION BY date_trunc('minute', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) AS int) AS avg_temperature_minutely,
        CAST(avg(temperature) OVER (PARTITION BY date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) AS int) AS avg_temperature_hourly,
        CAST(avg(temperature) OVER (PARTITION BY date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) AS int) AS avg_temperature_daily,
        CAST(avg(temperature) OVER (PARTITION BY date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) AS int) AS avg_temperature_monthly,
        CAST(avg(temperature) OVER (PARTITION BY date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) AS int) AS avg_temperature_yearly,
        CAST(avg(humidity) OVER (PARTITION BY date_trunc('minute', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) AS int) AS avg_humidity_minutely,
        CAST(avg(humidity) OVER (PARTITION BY date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) AS int) AS avg_humidity_hourly,
        CAST(avg(humidity) OVER (PARTITION BY date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) AS int) AS avg_humidity_daily,
        CAST(avg(humidity) OVER (PARTITION BY date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) AS int) AS avg_humidity_monthly,
        CAST(avg(humidity) OVER (PARTITION BY date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) AS int) AS avg_humidity_yearly,
        CAST(avg(lux) OVER (PARTITION BY date_trunc('minute', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) AS int) AS avg_lux_minutely,
        CAST(avg(lux) OVER (PARTITION BY date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) AS int) AS avg_lux_hourly,
        CAST(avg(lux) OVER (PARTITION BY date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) AS int) AS avg_lux_daily,
        CAST(avg(lux) OVER (PARTITION BY date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) AS int) AS avg_lux_monthly,
        CAST(avg(lux) OVER (PARTITION BY date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) AS int) AS avg_lux_yearly,
        device_token
    FROM 
        enviroment_data
    WHERE
        timestamp < current_timestamp - INTERVAL '2 DAY'
WITH DATA;


CREATE MATERIALIZED VIEW overview_env_agg as
    SELECT 
        env_data_id,
        timestamp,
        date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') AS timestamp_hourly,
        date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') AS timestamp_daily,
        date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') AS timestamp_monthly,
        date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') AS timestamp_yearly,
        CAST(avg(iaq) OVER (PARTITION BY date_trunc('minute', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) AS int) AS avg_iaq_minutely,
        CAST(avg(iaq) OVER (PARTITION BY date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) AS int) AS avg_iaq_hourly,
        CAST(avg(iaq) OVER (PARTITION BY date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) AS int) AS avg_iaq_daily,
        CAST(avg(iaq) OVER (PARTITION BY date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) AS int) AS avg_iaq_monthly,
        CAST(avg(iaq) OVER (PARTITION BY date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) AS int) AS avg_iaq_yearly,
        CAST(avg(temperature) OVER (PARTITION BY date_trunc('minute', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) AS int) AS avg_temperature_minutely,
        CAST(avg(temperature) OVER (PARTITION BY date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) AS int) AS avg_temperature_hourly,
        CAST(avg(temperature) OVER (PARTITION BY date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) AS int) AS avg_temperature_daily,
        CAST(avg(temperature) OVER (PARTITION BY date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) AS int) AS avg_temperature_monthly,
        CAST(avg(temperature) OVER (PARTITION BY date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) AS int) AS avg_temperature_yearly,
        CAST(avg(humidity) OVER (PARTITION BY date_trunc('minute', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) AS int) AS avg_humidity_minutely,
        CAST(avg(humidity) OVER (PARTITION BY date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) AS int) AS avg_humidity_hourly,
        CAST(avg(humidity) OVER (PARTITION BY date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) AS int) AS avg_humidity_daily,
        CAST(avg(humidity) OVER (PARTITION BY date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) AS int) AS avg_humidity_monthly,
        CAST(avg(humidity) OVER (PARTITION BY date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) AS int) AS avg_humidity_yearly,
        CAST(avg(lux) OVER (PARTITION BY date_trunc('minute', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) AS int) AS avg_lux_minutely,
        CAST(avg(lux) OVER (PARTITION BY date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) AS int) AS avg_lux_hourly,
        CAST(avg(lux) OVER (PARTITION BY date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) AS int) AS avg_lux_daily,
        CAST(avg(lux) OVER (PARTITION BY date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) AS int) AS avg_lux_monthly,
        CAST(avg(lux) OVER (PARTITION BY date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) AS int) AS avg_lux_yearly,
        device_token
    FROM 
        enviroment_data
    WHERE
        timestamp > current_timestamp - INTERVAL '2 DAY'
WITH DATA;

DROP INDEX env_agg_idx

CREATE UNIQUE INDEX env_agg_idx ON env_agg (uplinkts, device_token);

REFRESH MATERIALIZED VIEW CONCURRENTLY env_agg

REFRESH MATERIALIZED VIEW CONCURRENTLY overview_env_agg

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

DROP MATERIALIZED VIEW IF EXISTS overview_env_agg

DROP VIEW IF EXISTS env_agg

REFRESH MATERIALIZED VIEW env_agg

REFRESH MATERIALIZED VIEW overview_env_agg

select * from env_agg order by uplinkts desc limit 10

CREATE UNIQUE INDEX env_agg_idx ON env_agg (env_data_id, timestamp DESC);

CREATE UNIQUE INDEX overview_env_agg_idx ON overview_env_agg (env_data_id, timestamp DESC);

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
    WHERE 
        timestamp < current_timestamp - INTERVAL '2 DAY'
        order by timestamp desc
    ),
    occ_entrance as (
        SELECT
            id,
            timestamp,
            date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') as timestamp_hourly,
            date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') as timestamp_daily,
            date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') as timestamp_monthly,
            date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') as timestamp_yearly,
            device_token,
            occupied,
            prev_occupied,
            sum(case when occupied = true and prev_occupied = false then 1 else 0 end) over ( partition by date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token ) as sum_hourly,
            sum(case when occupied = true and prev_occupied = false then 1 else 0 end) over ( partition by date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') , device_token) as sum_daily,
            sum(case when occupied = true and prev_occupied = false then 1 else 0 end) over ( partition by date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as sum_monthly,
            sum(case when occupied = true and prev_occupied = false then 1 else 0 end) over ( partition by date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as sum_yearly
            FROM occ_lag
    )
select * from occ_entrance
WITH
    DATA;



CREATE MATERIALIZED VIEW IF NOT EXISTS overview_occupancy_agg AS
with 
    occ_lag as (SELECT
        id,
        timestamp,
        device_token,
        occupied,
        lag (occupied, 1) over (order by id) as prev_occupied
        FROM occupancy_data
        WHERE 
            timestamp > current_timestamp - INTERVAL '2 DAY'
        order by timestamp desc
    ),
    occ_entrance as (
        SELECT
            id,
            timestamp,
            date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') as timestamp_hourly,
            date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') as timestamp_daily,
            date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') as timestamp_monthly,
            date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') as timestamp_yearly,
            device_token,
            occupied,
            prev_occupied,
            sum(case when occupied = true and prev_occupied = false then 1 else 0 end) over ( partition by date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token ) as sum_hourly,
            sum(case when occupied = true and prev_occupied = false then 1 else 0 end) over ( partition by date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') , device_token) as sum_daily,
            sum(case when occupied = true and prev_occupied = false then 1 else 0 end) over ( partition by date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as sum_monthly,
            sum(case when occupied = true and prev_occupied = false then 1 else 0 end) over ( partition by date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as sum_yearly
            FROM occ_lag
    )
select * from occ_entrance
WITH
    DATA;

select * from occupancy_data

select * from occupancy_agg

select * from overview_occupancy_agg

REFRESH MATERIALIZED VIEW CONCURRENTLY occupancy_agg;

DROP MATERIALIZED VIEW IF EXISTS occupancy_agg

DROP MATERIALIZED VIEW IF EXISTS overview_occupancy_agg

DROP INDEX IF EXISTS occupancy_lag_idx3;

CREATE UNIQUE INDEX overview_occupancy_agg_idx3 ON overview_occupancy_agg (
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
    toilet_infos.toilet_name,
    toilet_infos.toilet_info_id,
    toilet_infos.toilet_type_id,
    device_types.device_type_name,
    device_types.device_type_id , 
    -- device_pairs.toilet_info_id,
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
    toilet_name,
    toilet_info_id,
    device_type_name,
    device_type_id,
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

CREATE MATERIALIZED VIEW IF NOT EXISTS counter_data_agg AS
with 
    counter_lag as (
        select
            counter_data_id,
            timestamp, 
            device_token, 
            people_in
        from counter_data
        where
            timestamp < current_timestamp - INTERVAL '2 DAY'
    ),
    counter_agg as (
        select
            counter_data_id,
            timestamp,
            date_trunc('hour',timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') as timestamp_hourly,
            date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') as timestamp_day,
            date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') as timestamp_monthly,
            date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') as timestamp_year,
            device_token,
            sum(case when people_in = '1' then 1 else 0 end) over (partition by timestamp, device_token) as enter,
            sum(case when people_in = '1' then 1 else 0 end) over (partition by date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as enter_hourly,
            sum(case when people_in = '1' then 1 else 0 end) over (partition by date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as enter_day,
            sum(case when people_in = '1' then 1 else 0 end) over (partition by date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as enter_month,
            sum(case when people_in = '1' then 1 else 0 end) over (partition by date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as enter_year
        from
            counter_lag
    )
select * from counter_agg
WITH
    DATA;


CREATE MATERIALIZED VIEW IF NOT EXISTS overview_counter_data_agg AS
with 
    counter_lag as (
        select
            counter_data_id,
            timestamp, 
            device_token, 
            people_in
        from counter_data
        where
            timestamp > current_timestamp - INTERVAL '2 DAY'
    ),
    counter_agg as (
        select
            counter_data_id,
            timestamp,
            date_trunc('hour',timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') as timestamp_hourly,
            date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') as timestamp_day,
            date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') as timestamp_monthly,
            date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') as timestamp_year,
            device_token,
            sum(case when people_in = '1' then 1 else 0 end) over (partition by timestamp, device_token) as enter,
            sum(case when people_in = '1' then 1 else 0 end) over (partition by date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as enter_hourly,
            sum(case when people_in = '1' then 1 else 0 end) over (partition by date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as enter_day,
            sum(case when people_in = '1' then 1 else 0 end) over (partition by date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as enter_month,
            sum(case when people_in = '1' then 1 else 0 end) over (partition by date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as enter_year
        from
            counter_lag
    )
select * from counter_agg
WITH
    DATA;

select * from counter_data_agg

select * from counter_data limit 1

CREATE UNIQUE INDEX counter_data_agg_idx4 ON counter_data_agg (
    counter_data_id,
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


CREATE UNIQUE INDEX overview_counter_data_agg_idx4 ON overview_counter_data_agg (
    counter_data_id,
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

DROP MATERIALIZED VIEW IF EXISTS counter_data_agg

select * from counter_data limit 10

select * from overview_counter_data_agg

select * from counter_data limit 1

DROP INDEX IF EXISTS overview_counter_data_agg_idx3;

REFRESH MATERIALIZED VIEW CONCURRENTLY overview_counter_data_agg;

DROP MATERIALIZED VIEW IF EXISTS overview_counter_data_agg

-- panic_btn data
select * from panic_btn_data limit 1

CREATE MATERIALIZED VIEW IF NOT EXISTS panic_btn_agg AS
    SELECT
        id,
        device_token,
        panic_button,
        timestamp,
        date_trunc('minute', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_minutely,
        date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_hourly,
        date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_daily,
        date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_monthly,
        date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_yearly,
        sum (case when panic_button = true then 1 else 0 end) over (PARTITION BY date_trunc('minute', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as total_panic_button_minutely,
        sum (case when panic_button = true then 1 else 0 end) over (PARTITION BY date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as total_panic_button_hourly,
        sum (case when panic_button = true then 1 else 0 end) over (PARTITION BY date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as total_panic_button_daily,
        sum (case when panic_button = true then 1 else 0 end) over (PARTITION BY date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as total_panic_button_monthly,
        sum (case when panic_button = true then 1 else 0 end) over (PARTITION BY date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as total_panic_button_yearly
        from panic_btn_data
        WHERE
            timestamp < current_timestamp - INTERVAL '2 DAY'
WITH DATA;


CREATE MATERIALIZED VIEW IF NOT EXISTS overview_panic_btn_agg AS
    SELECT
        id,
        device_token,
        panic_button,
        timestamp,
        date_trunc('minute', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_minutely,
        date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_hourly,
        date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_daily,
        date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_monthly,
        date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_yearly,
        sum (case when panic_button = true then 1 else 0 end) over (PARTITION BY date_trunc('minute', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as total_panic_button_minutely,
        sum (case when panic_button = true then 1 else 0 end) over (PARTITION BY date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as total_panic_button_hourly,
        sum (case when panic_button = true then 1 else 0 end) over (PARTITION BY date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as total_panic_button_daily,
        sum (case when panic_button = true then 1 else 0 end) over (PARTITION BY date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as total_panic_button_monthly,
        sum (case when panic_button = true then 1 else 0 end) over (PARTITION BY date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as total_panic_button_yearly
        from panic_btn_data
        WHERE
            timestamp > current_timestamp - INTERVAL '2 DAY'
WITH DATA;

DROP MATERIALIZED VIEW IF EXISTS overview_panic_btn_agg

DROP MATERIALIZED VIEW IF EXISTS panic_btn_agg

REFRESH MATERIALIZED VIEW CONCURRENTLY overview_panic_btn_agg

REFRESH MATERIALIZED VIEW CONCURRENTLY panic_btn_agg

CREATE UNIQUE INDEX panic_btn_agg_idx3 ON panic_btn_agg (
    id,
    device_token,
    panic_button,
    timestamp,
    timestamp_minutely,
    timestamp_hourly,
    timestamp_daily,
    timestamp_monthly,
    timestamp_yearly,
    total_panic_button_minutely,
    total_panic_button_hourly,
    total_panic_button_daily,
    total_panic_button_monthly,
    total_panic_button_yearly
);


-- freshener data
select * from fragrance_data

CREATE MATERIALIZED VIEW IF NOT EXISTS fragrance_data_agg AS
    SELECT
        id,
        device_token,
        fragrance_on,
        timestamp,
        date_trunc('minute', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_minutely,
        date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_hourly,
        date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_daily,
        date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_monthly,
        date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_yearly,
        sum (case when fragrance_on = true then 1 else 0 end) over (PARTITION BY date_trunc('minute', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as total_fragrance_minutely,
        sum (case when fragrance_on = true then 1 else 0 end) over (PARTITION BY date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as total_fragrance_hourly,
        sum (case when fragrance_on = true then 1 else 0 end) over (PARTITION BY date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as total_fragrance_daily,
        sum (case when fragrance_on = true then 1 else 0 end) over (PARTITION BY date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as total_fragrance_monthly,
        sum (case when fragrance_on = true then 1 else 0 end) over (PARTITION BY date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as total_fragrance_yearly
    from fragrance_data
    WHERE
        timestamp < current_timestamp - INTERVAL '2 DAY'
WITH DATA;

CREATE MATERIALIZED VIEW IF NOT EXISTS overview_fragrance_data_agg AS
    SELECT
        id,
        device_token,
        fragrance_on,
        timestamp,
        date_trunc('minute', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_minutely,
        date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_hourly,
        date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_daily,
        date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_monthly,
        date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_yearly,
        sum (case when fragrance_on = true then 1 else 0 end) over (PARTITION BY date_trunc('minute', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as total_fragrance_minutely,
        sum (case when fragrance_on = true then 1 else 0 end) over (PARTITION BY date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as total_fragrance_hourly,
        sum (case when fragrance_on = true then 1 else 0 end) over (PARTITION BY date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as total_fragrance_daily,
        sum (case when fragrance_on = true then 1 else 0 end) over (PARTITION BY date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as total_fragrance_monthly,
        sum (case when fragrance_on = true then 1 else 0 end) over (PARTITION BY date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as total_fragrance_yearly
    from fragrance_data
    WHERE 
        timestamp > current_timestamp - INTERVAL '2 DAY'
WITH DATA;

DROP MATERIALIZED VIEW IF EXISTS overview_fragrance_data_agg

DROP MATERIALIZED VIEW IF EXISTS fragrance_data_agg

REFRESH MATERIALIZED VIEW CONCURRENTLY overview_fragrance_data_agg

REFRESH MATERIALIZED VIEW CONCURRENTLY fragrance_data_agg

CREATE UNIQUE INDEX fragrance_data_agg_idx3 ON fragrance_data_agg (
    id,
    device_token,
    fragrance_on,
    timestamp,
    timestamp_minutely,
    timestamp_hourly,
    timestamp_daily,
    timestamp_monthly,
    timestamp_yearly,
    total_fragrance_minutely,
    total_fragrance_hourly,
    total_fragrance_daily,
    total_fragrance_monthly,
    total_fragrance_yearly
);

CREATE UNIQUE INDEX overview_fragrance_data_agg_idx3 ON overview_fragrance_data_agg (
    id,
    device_token,
    fragrance_on,
    timestamp,
    timestamp_minutely,
    timestamp_hourly,
    timestamp_daily,
    timestamp_monthly,
    timestamp_yearly,
    total_fragrance_minutely,
    total_fragrance_hourly,
    total_fragrance_daily,
    total_fragrance_monthly,
    total_fragrance_yearly
);

-- ammonia data
select * from ammonia_data

CREATE MATERIALIZED VIEW IF NOT EXISTS ammonia_data_agg AS
    SELECT
        id,
        device_token,
        ammonia_level,
        timestamp,
        date_trunc('minute', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_minutely,
        date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_hourly,
        date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_daily,
        date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_monthly,
        date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_yearly,
        avg (ammonia_level) over (PARTITION BY date_trunc('minute', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as avg_fragrance_minutely,
        avg (ammonia_level) over (PARTITION BY date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as avg_fragrance_hourly,
        avg (ammonia_level) over (PARTITION BY date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as avg_fragrance_daily,
        avg (ammonia_level) over (PARTITION BY date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as avg_fragrance_monthly,
        avg (ammonia_level) over (PARTITION BY date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as avg_fragrance_yearly
    from ammonia_data
    WHERE 
        timestamp < current_timestamp - INTERVAL '2 DAY'
WITH DATA;

CREATE MATERIALIZED VIEW IF NOT EXISTS overview_ammonia_data_agg AS
    SELECT
        id,
        device_token,
        ammonia_level,
        timestamp,
        date_trunc('minute', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_minutely,
        date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_hourly,
        date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_daily,
        date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_monthly,
        date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_yearly,
        avg (ammonia_level) over (PARTITION BY date_trunc('minute', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as avg_fragrance_minutely,
        avg (ammonia_level) over (PARTITION BY date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as avg_fragrance_hourly,
        avg (ammonia_level) over (PARTITION BY date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as avg_fragrance_daily,
        avg (ammonia_level) over (PARTITION BY date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as avg_fragrance_monthly,
        avg (ammonia_level) over (PARTITION BY date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as avg_fragrance_yearly
    from ammonia_data
    WHERE 
        timestamp > current_timestamp - INTERVAL '2 DAY'
WITH DATA;


DROP MATERIALIZED VIEW IF EXISTS overview_ammonia_data_agg

DROP MATERIALIZED VIEW IF EXISTS ammonia_data_agg

REFRESH MATERIALIZED VIEW CONCURRENTLY ammonia_data_agg;

REFRESH MATERIALIZED VIEW CONCURRENTLY overview_ammonia_data_agg;

CREATE UNIQUE INDEX ammonia_data_idx3 ON ammonia_data_agg (
    id,
    device_token,
    ammonia_level,
    timestamp,
    timestamp_minutely,
    timestamp_hourly,
    timestamp_daily,
    timestamp_monthly,
    timestamp_yearly,
    avg_fragrance_minutely,
    avg_fragrance_hourly,
    avg_fragrance_daily,
    avg_fragrance_monthly,
    avg_fragrance_yearly
);

CREATE UNIQUE INDEX overview_ammonia_data_idx3 ON overview_ammonia_data_agg (
        id,
        device_token,
        ammonia_level,
        timestamp,
        timestamp_minutely,
        timestamp_hourly,
        timestamp_daily,
        timestamp_monthly,
        timestamp_yearly,
        avg_fragrance_minutely,
        avg_fragrance_hourly,
        avg_fragrance_daily,
        avg_fragrance_monthly,
        avg_fragrance_yearly
);

-- cleaner report agg
select * from cleaner_reports limit 1

CREATE MATERIALIZED VIEW IF NOT EXISTS cleaner_reports_agg AS
    SELECT  
        cleaner_report_id,
        location_id,
        toilet_type_id,
        cubical_id,
        check_in_ts,
        date_trunc('minute', created_at) created_at_minutely,
        date_trunc('hour', created_at) created_at_hourly,
        date_trunc('day', created_at) created_at_daily,
        date_trunc('month', created_at) created_at_monthly,
        date_trunc('year', created_at) created_at_yearly,
        sum (case when freshen_up_state = '1' then 1 else 0 end) over (PARTITION BY date_trunc('minute', created_at), location_id, toilet_type_id) as total_freshen_minutely,
        sum (case when freshen_up_state = '1' then 1 else 0 end) over (PARTITION BY date_trunc('hour', created_at), location_id, toilet_type_id) as total_freshen_hourly,
        sum (case when freshen_up_state = '1' then 1 else 0 end) over (PARTITION BY date_trunc('day', created_at), location_id, toilet_type_id) as total_freshen_daily,
        sum (case when freshen_up_state = '1' then 1 else 0 end) over (PARTITION BY date_trunc('month', created_at), location_id, toilet_type_id) as total_freshen_monthly,
        sum (case when freshen_up_state = '1' then 1 else 0 end) over (PARTITION BY date_trunc('year', created_at), location_id, toilet_type_id) as total_freshen_yearly,
        sum (case when auto_clean_state = '1' then 1 else 0 end) over (PARTITION BY date_trunc('minute', created_at), location_id, toilet_type_id) as total_auto_clean_minutely,
        sum (case when auto_clean_state = '1' then 1 else 0 end) over (PARTITION BY date_trunc('hour', created_at), location_id, toilet_type_id) as total_auto_clean_hourly,
        sum (case when auto_clean_state = '1' then 1 else 0 end) over (PARTITION BY date_trunc('day', created_at), location_id, toilet_type_id) as total_auto_clean_daily,
        sum (case when auto_clean_state = '1' then 1 else 0 end) over (PARTITION BY date_trunc('month', created_at), location_id, toilet_type_id) as total_auto_clean_monthly,
        sum (case when auto_clean_state = '1' then 1 else 0 end) over (PARTITION BY date_trunc('year', created_at), location_id, toilet_type_id) as total_auto_clean_yearly,
        freshen_up_state,
        auto_clean_state,
        tenant_id
    from cleaner_reports
    where 
        created_at < current_timestamp - INTERVAL '2 DAY'
WITH DATA;


CREATE MATERIALIZED VIEW IF NOT EXISTS overview_cleaner_reports_agg AS
    SELECT  
        cleaner_report_id,
        location_id,
        toilet_type_id,
        cubical_id,
        check_in_ts,
        date_trunc('minute', created_at) created_at_minutely,
        date_trunc('hour', created_at) created_at_hourly,
        date_trunc('day', created_at) created_at_daily,
        date_trunc('month', created_at) created_at_monthly,
        date_trunc('year', created_at) created_at_yearly,
        sum (case when freshen_up_state = '1' then 1 else 0 end) over (PARTITION BY date_trunc('minute', created_at), location_id, toilet_type_id) as total_freshen_minutely,
        sum (case when freshen_up_state = '1' then 1 else 0 end) over (PARTITION BY date_trunc('hour', created_at), location_id, toilet_type_id) as total_freshen_hourly,
        sum (case when freshen_up_state = '1' then 1 else 0 end) over (PARTITION BY date_trunc('day', created_at), location_id, toilet_type_id) as total_freshen_daily,
        sum (case when freshen_up_state = '1' then 1 else 0 end) over (PARTITION BY date_trunc('month', created_at), location_id, toilet_type_id) as total_freshen_monthly,
        sum (case when freshen_up_state = '1' then 1 else 0 end) over (PARTITION BY date_trunc('year', created_at), location_id, toilet_type_id) as total_freshen_yearly,
        sum (case when auto_clean_state = '1' then 1 else 0 end) over (PARTITION BY date_trunc('minute', created_at), location_id, toilet_type_id) as total_auto_clean_minutely,
        sum (case when auto_clean_state = '1' then 1 else 0 end) over (PARTITION BY date_trunc('hour', created_at), location_id, toilet_type_id) as total_auto_clean_hourly,
        sum (case when auto_clean_state = '1' then 1 else 0 end) over (PARTITION BY date_trunc('day', created_at), location_id, toilet_type_id) as total_auto_clean_daily,
        sum (case when auto_clean_state = '1' then 1 else 0 end) over (PARTITION BY date_trunc('month', created_at), location_id, toilet_type_id) as total_auto_clean_monthly,
        sum (case when auto_clean_state = '1' then 1 else 0 end) over (PARTITION BY date_trunc('year', created_at), location_id, toilet_type_id) as total_auto_clean_yearly,
        freshen_up_state,
        auto_clean_state,
        tenant_id
    from cleaner_reports
    where 
        created_at > current_timestamp - INTERVAL '2 DAY'
WITH DATA;


DROP MATERIALIZED VIEW IF EXISTS cleaner_reports_agg

DROP MATERIALIZED VIEW IF EXISTS overview_cleaner_reports_agg

REFRESH MATERIALIZED VIEW CONCURRENTLY cleaner_reports_agg;

CREATE UNIQUE INDEX cleaner_reports_agg_idx3 ON cleaner_reports_agg (
    cleaner_report_id,
    location_id,
    toilet_type_id,
    cubical_id,
    check_in_ts,
    created_at_minutely,
    created_at_hourly,
    created_at_daily,
    created_at_monthly,
    created_at_yearly,
    total_freshen_minutely,
    total_freshen_hourly,
    total_freshen_daily,
    total_freshen_monthly,
    total_freshen_yearly,
    total_auto_clean_minutely,
    total_auto_clean_hourly,
    total_auto_clean_daily,
    total_auto_clean_monthly,
    total_auto_clean_yearly,
    freshen_up_state,
    auto_clean_state,
    tenant_id
);

CREATE UNIQUE INDEX overview_cleaner_reports_agg_idx3 ON overview_cleaner_reports_agg (
    cleaner_report_id,
    location_id,
    toilet_type_id,
    cubical_id,
    check_in_ts,
    created_at_minutely,
    created_at_hourly,
    created_at_daily,
    created_at_monthly,
    created_at_yearly,
    total_freshen_minutely,
    total_freshen_hourly,
    total_freshen_daily,
    total_freshen_monthly,
    total_freshen_yearly,
    total_auto_clean_minutely,
    total_auto_clean_hourly,
    total_auto_clean_daily,
    total_auto_clean_monthly,
    total_auto_clean_yearly,
    freshen_up_state,
    auto_clean_state,
    tenant_id
);

select * from cleaner_reports_agg

-- feedback panel agg

select * from feedback_panel_data limit 1

CREATE MATERIALIZED VIEW IF NOT EXISTS feedback_panel_agg AS

WITH DATA;

-- fp sensor agg
select * from fp_sensor_data limit 1

CREATE MATERIALIZED VIEW IF NOT EXISTS fp_sensor_agg AS
    select
        fpr_sensor_data_id,
        created_at,
        date_trunc('minute', created_at) created_at_minutely,
        date_trunc('hour', created_at) created_at_hourly,
        date_trunc('day', created_at) created_at_daily,
        date_trunc('month', created_at) created_at_monthly,
        date_trunc('year', created_at) created_at_yearly,
        avg (temperature) over (PARTITION BY date_trunc('minute', created_at), device_token) as temp_avg_minutely,
        avg (temperature) over (PARTITION BY date_trunc('hour', created_at), device_token) as temp_avg_hourly,
        avg (temperature) over (PARTITION BY date_trunc('day', created_at), device_token) as temp_avg_daily,
        avg (temperature) over (PARTITION BY date_trunc('month', created_at), device_token) as temp_avg_monthly,
        avg (temperature) over (PARTITION BY date_trunc('year', created_at), device_token) as temp_avg_yearly,
        avg (humidity) over (PARTITION BY date_trunc('minute', created_at), device_token) as humidity_avg_minutely,
        avg (humidity) over (PARTITION BY date_trunc('hour', created_at), device_token) as humidity_avg_hourly,
        avg (humidity) over (PARTITION BY date_trunc('day', created_at), device_token) as humidity_avg_daily,
        avg (humidity) over (PARTITION BY date_trunc('month', created_at), device_token) as humidity_avg_monthly,
        avg (humidity) over (PARTITION BY date_trunc('year', created_at), device_token) as humidity_avg_yearly,
        avg (rssi) over (PARTITION BY date_trunc('minute', created_at), device_token) as rssi_avg_minutely,
        avg (rssi) over (PARTITION BY date_trunc('hour', created_at), device_token) as rssi_avg_hourly,
        avg (rssi) over (PARTITION BY date_trunc('day', created_at), device_token) as rssi_avg_daily,
        avg (rssi) over (PARTITION BY date_trunc('month', created_at), device_token) as rssi_avg_monthly,
        avg (rssi) over (PARTITION BY date_trunc('year', created_at), device_token) as rssi_avg_yearly,
        avg (cpu_temp) over (PARTITION BY date_trunc('minute', created_at), device_token) as ct_avg_minutely,
        avg (cpu_temp) over (PARTITION BY date_trunc('hour', created_at), device_token) as ct_avg_hourly,
        avg (cpu_temp) over (PARTITION BY date_trunc('day', created_at), device_token) as ct_avg_daily,
        avg (cpu_temp) over (PARTITION BY date_trunc('month', created_at), device_token) as ct_avg_monthly,
        avg (cpu_temp) over (PARTITION BY date_trunc('year', created_at), device_token) as ct_avg_yearly,
        device_token
    from fp_sensor_data
    where 
        deleted_at is null 
        and created_at < current_timestamp - INTERVAL '2 DAY'
    order by created_at desc, device_token
WITH DATA;


CREATE MATERIALIZED VIEW IF NOT EXISTS overview_fp_sensor_agg AS
    select
        fpr_sensor_data_id,
        created_at,
        date_trunc('minute', created_at) created_at_minutely,
        date_trunc('hour', created_at) created_at_hourly,
        date_trunc('day', created_at) created_at_daily,
        date_trunc('month', created_at) created_at_monthly,
        date_trunc('year', created_at) created_at_yearly,
        avg (temperature) over (PARTITION BY date_trunc('minute', created_at), device_token) as temp_avg_minutely,
        avg (temperature) over (PARTITION BY date_trunc('hour', created_at), device_token) as temp_avg_hourly,
        avg (temperature) over (PARTITION BY date_trunc('day', created_at), device_token) as temp_avg_daily,
        avg (temperature) over (PARTITION BY date_trunc('month', created_at), device_token) as temp_avg_monthly,
        avg (temperature) over (PARTITION BY date_trunc('year', created_at), device_token) as temp_avg_yearly,
        avg (humidity) over (PARTITION BY date_trunc('minute', created_at), device_token) as humidity_avg_minutely,
        avg (humidity) over (PARTITION BY date_trunc('hour', created_at), device_token) as humidity_avg_hourly,
        avg (humidity) over (PARTITION BY date_trunc('day', created_at), device_token) as humidity_avg_daily,
        avg (humidity) over (PARTITION BY date_trunc('month', created_at), device_token) as humidity_avg_monthly,
        avg (humidity) over (PARTITION BY date_trunc('year', created_at), device_token) as humidity_avg_yearly,
        avg (rssi) over (PARTITION BY date_trunc('minute', created_at), device_token) as rssi_avg_minutely,
        avg (rssi) over (PARTITION BY date_trunc('hour', created_at), device_token) as rssi_avg_hourly,
        avg (rssi) over (PARTITION BY date_trunc('day', created_at), device_token) as rssi_avg_daily,
        avg (rssi) over (PARTITION BY date_trunc('month', created_at), device_token) as rssi_avg_monthly,
        avg (rssi) over (PARTITION BY date_trunc('year', created_at), device_token) as rssi_avg_yearly,
        avg (cpu_temp) over (PARTITION BY date_trunc('minute', created_at), device_token) as ct_avg_minutely,
        avg (cpu_temp) over (PARTITION BY date_trunc('hour', created_at), device_token) as ct_avg_hourly,
        avg (cpu_temp) over (PARTITION BY date_trunc('day', created_at), device_token) as ct_avg_daily,
        avg (cpu_temp) over (PARTITION BY date_trunc('month', created_at), device_token) as ct_avg_monthly,
        avg (cpu_temp) over (PARTITION BY date_trunc('year', created_at), device_token) as ct_avg_yearly,
        device_token
    from fp_sensor_data
    where 
        deleted_at is null 
        and created_at > current_timestamp - INTERVAL '2 DAY'
    order by created_at desc, device_token
WITH DATA;

select * from fp_sensor_agg

DROP MATERIALIZED VIEW IF EXISTS overview_fp_sensor_agg

DROP MATERIALIZED VIEW IF EXISTS fp_sensor_agg

DROP INDEX fp_sensor_agg_idx3

REFRESH MATERIALIZED VIEW CONCURRENTLY fp_sensor_agg;

REFRESH MATERIALIZED VIEW CONCURRENTLY overview_fp_sensor_agg;

CREATE UNIQUE INDEX overviewfp_sensor_agg_idx3 ON overview_fp_sensor_agg (
    fpr_sensor_data_id,
    created_at,
    created_at_minutely,
    created_at_hourly,
    created_at_daily,
    created_at_monthly,
    created_at_yearly,
    temp_avg_minutely,
    temp_avg_hourly,
    temp_avg_daily,
    temp_avg_monthly,
    temp_avg_yearly,
    humidity_avg_minutely,
    humidity_avg_hourly,
    humidity_avg_daily,
    humidity_avg_monthly,
    humidity_avg_yearly,
    rssi_avg_minutely,
    rssi_avg_hourly,
    rssi_avg_daily,
    rssi_avg_monthly,
    rssi_avg_yearly,
    ct_avg_minutely,
    ct_avg_hourly,
    ct_avg_daily,
    ct_avg_monthly,
    ct_avg_yearly
);

CREATE UNIQUE INDEX fp_sensor_agg_idx3 ON fp_sensor_agg (
    fpr_sensor_data_id,
    created_at,
    created_at_minutely,
    created_at_hourly,
    created_at_daily,
    created_at_monthly,
    created_at_yearly,
    temp_avg_minutely,
    temp_avg_hourly,
    temp_avg_daily,
    temp_avg_monthly,
    temp_avg_yearly,
    humidity_avg_minutely,
    humidity_avg_hourly,
    humidity_avg_daily,
    humidity_avg_monthly,
    humidity_avg_yearly,
    rssi_avg_minutely,
    rssi_avg_hourly,
    rssi_avg_daily,
    rssi_avg_monthly,
    rssi_avg_yearly,
    ct_avg_minutely,
    ct_avg_hourly,
    ct_avg_daily,
    ct_avg_monthly,
    ct_avg_yearly
);

-- misc acion data agg
select * from misc_action_data limit 1

CREATE MATERIALIZED VIEW IF NOT EXISTS misc_action_agg AS
    select
        timestamp,
        date_trunc('minute', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_minutely,
        date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_hourly,
        date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_daily,
        date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_monthly,
        date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_yearly,
        sum (case when status = '1' then 1 else 0 end) over (PARTITION BY date_trunc('minute', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as total_minutely,
        sum (case when status = '1' then 1 else 0 end) over (PARTITION BY date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as total_hourly,
        sum (case when status = '1' then 1 else 0 end) over (PARTITION BY date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as total_daily,
        sum (case when status = '1' then 1 else 0 end) over (PARTITION BY date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as total_monthly,
        sum (case when status = '1' then 1 else 0 end) over (PARTITION BY date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as total_yearly,
        misc_data_id,
        device_token,
        toilet_info_id,
        namespace,
        status
    from misc_action_data
    where 
        timestamp < current_timestamp - INTERVAL '2 DAY'
WITH DATA;


CREATE MATERIALIZED VIEW IF NOT EXISTS overview_misc_action_agg AS
    select
        timestamp,
        date_trunc('minute', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_minutely,
        date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_hourly,
        date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_daily,
        date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_monthly,
        date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_yearly,
        sum (case when status = '1' then 1 else 0 end) over (PARTITION BY date_trunc('minute', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as total_minutely,
        sum (case when status = '1' then 1 else 0 end) over (PARTITION BY date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as total_hourly,
        sum (case when status = '1' then 1 else 0 end) over (PARTITION BY date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as total_daily,
        sum (case when status = '1' then 1 else 0 end) over (PARTITION BY date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as total_monthly,
        sum (case when status = '1' then 1 else 0 end) over (PARTITION BY date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), device_token) as total_yearly,
        misc_data_id,
        device_token,
        toilet_info_id,
        namespace,
        status
    from misc_action_data
    where 
        timestamp > current_timestamp - INTERVAL '2 DAY'
WITH DATA;

select namespace,* from misc_action_agg where namespace

DROP MATERIALIZED VIEW IF EXISTS misc_action_agg

REFRESH MATERIALIZED VIEW CONCURRENTLY misc_action_agg;

CREATE UNIQUE INDEX misc_action_agg_idx3 ON misc_action_agg (
    timestamp,
    timestamp_hourly,
    timestamp_daily,
    timestamp_monthly,
    timestamp_yearly,
    total_minutely,
    total_hourly,
    total_daily,
    total_monthly,
    total_yearly,
    misc_data_id,
    device_token,
    toilet_info_id,
    namespace,
    status
);


CREATE UNIQUE INDEX overview_misc_action_agg_idx3 ON overview_misc_action_agg (
    timestamp,
    timestamp_hourly,
    timestamp_daily,
    timestamp_monthly,
    timestamp_yearly,
    total_minutely,
    total_hourly,
    total_daily,
    total_monthly,
    total_yearly,
    misc_data_id,
    device_token,
    toilet_info_id,
    namespace,
    status
);

-- truncate dates
select date_trunc('hour', timestamp) as timestamp, toilet_type, reaction, complaint, toilet_id, score 
from user_reactions

-- using windows function to create needed column so a view is suitable for many queries
CREATE MATERIALIZED VIEW IF NOT EXISTS user_reaction_agg AS
    select 
        timestamp, 
        date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_hourly, 
        date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_daily,
        date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_monthly,
        date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_yearly,
        reaction,
        complaint,
        toilet_id, 
        count(reaction) over (partition by date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'),reaction) as total_reaction_by_type_hourly,
        count(reaction) over (partition by date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), reaction) as total_reaction_by_type_daily,
        count(reaction) over (partition by date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), reaction) as total_reaction_by_type_monthly,
        count(reaction) over (partition by date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), reaction) as total_reaction_by_type_yearly,
        count(reaction) over (partition by date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') ) as total_reaction_by_type_hourly_all,
        count(reaction) over (partition by date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') ) as total_reaction_by_type_daily_all,
        count(reaction) over (partition by date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') ) as total_reaction_by_type_monthly_all,
        count(reaction) over (partition by date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') ) as total_reaction_by_type_yearly_all,
        count(complaint) over (partition by date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'),complaint) as total_complaint_by_type_hourly,
        count(complaint) over (partition by date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), complaint) as total_complaint_by_type_daily,
        count(complaint) over (partition by date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), complaint) as total_complaint_by_type_monthly,
        count(complaint) over (partition by date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), complaint) as total_complaint_by_type_yearly,
        count(complaint) over (partition by date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') ) as total_complaint_by_type_hourly_all,
        count(complaint) over (partition by date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') ) as total_complaint_by_type_daily_all,
        count(complaint) over (partition by date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') ) as total_complaint_by_type_monthly_all,
        count(complaint) over (partition by date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') ) as total_complaint_by_type_yearly_all
    from 
        user_reactions
    where
        timestamp < current_timestamp - INTERVAL '2 DAY'
    group by timestamp, reaction, complaint, toilet_id
    order by timestamp desc, reaction
WITH DATA;


CREATE MATERIALIZED VIEW IF NOT EXISTS overview_user_reaction_agg AS
    select 
        timestamp, 
        date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_hourly, 
        date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_daily,
        date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_monthly,
        date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') timestamp_yearly,
        reaction,
        complaint,
        toilet_id,
    count(reaction) over (partition by date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'),reaction) as total_reaction_by_type_hourly,
    count(reaction) over (partition by date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), reaction) as total_reaction_by_type_daily,
    count(reaction) over (partition by date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), reaction) as total_reaction_by_type_monthly,
    count(reaction) over (partition by date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), reaction) as total_reaction_by_type_yearly,
    count(reaction) over (partition by date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') ) as total_reaction_by_type_hourly_all,
    count(reaction) over (partition by date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') ) as total_reaction_by_type_daily_all,
    count(reaction) over (partition by date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') ) as total_reaction_by_type_monthly_all,
    count(reaction) over (partition by date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') ) as total_reaction_by_type_yearly_all,
    count(complaint) over (partition by date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'),complaint) as total_complaint_by_type_hourly,
    count(complaint) over (partition by date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), complaint) as total_complaint_by_type_daily,
    count(complaint) over (partition by date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), complaint) as total_complaint_by_type_monthly,
    count(complaint) over (partition by date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), complaint) as total_complaint_by_type_yearly,
    count(complaint) over (partition by date_trunc('hour', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') ) as total_complaint_by_type_hourly_all,
    count(complaint) over (partition by date_trunc('day', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') ) as total_complaint_by_type_daily_all,
    count(complaint) over (partition by date_trunc('month', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') ) as total_complaint_by_type_monthly_all,
    count(complaint) over (partition by date_trunc('year', timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') ) as total_complaint_by_type_yearly_all
    from 
        user_reactions
    where
        timestamp > current_timestamp - INTERVAL '2 DAY'
    group by timestamp, reaction, complaint, toilet_id
    order by timestamp desc, reaction
WITH DATA;

select * from user_reaction_agg

DROP MATERIALIZED VIEW IF EXISTS overview_user_reaction_agg

DROP MATERIALIZED VIEW IF EXISTS user_reaction_agg

REFRESH MATERIALIZED VIEW CONCURRENTLY user_reaction_agg;

CREATE UNIQUE INDEX user_reaction_agg_idx3 ON user_reaction_agg (
    timestamp,
    timestamp_hourly,
    timestamp_daily,
    timestamp_monthly,
    timestamp_yearly,
    reaction,
    complaint,
    toilet_id,
    total_reaction_by_type_hourly,
    total_reaction_by_type_daily,
    total_reaction_by_type_monthly,
    total_reaction_by_type_yearly,
    total_reaction_by_type_hourly_all,
    total_reaction_by_type_daily_all,
    total_reaction_by_type_monthly_all,
    total_reaction_by_type_yearly_all
);


CREATE UNIQUE INDEX overview_user_reaction_agg_idx3 ON overview_user_reaction_agg (
    timestamp,
    timestamp_hourly,
    timestamp_daily,
    timestamp_monthly,
    timestamp_yearly,
    reaction,
    complaint,
    toilet_id,
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





-- money agg
CREATE MATERIALIZED VIEW IF NOT EXISTS overview_money_agg AS
    select 
        created_at, 
        date_trunc('hour', created_at AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') created_at_hourly, 
        date_trunc('day', created_at AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') created_at_daily,
        date_trunc('month', created_at AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') created_at_monthly,
        date_trunc('year', created_at AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') created_at_yearly,
        sum(ammount) over (partition by date_trunc('hour', created_at AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'),ammount) as total_ammount_by_type_hourly,
        sum(ammount) over (partition by date_trunc('day', created_at AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), ammount) as total_ammount_by_type_daily,
        sum(ammount) over (partition by date_trunc('month', created_at AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), ammount) as total_ammount_by_type_monthly,
        sum(ammount) over (partition by date_trunc('year', created_at AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), ammount) as total_ammount_by_type_yearly,
        tenant_id
    from 
        money_data
    where
        created_at > current_timestamp - INTERVAL '2 DAY'
    group by created_at, tenant_id
    order by created_at desc
WITH DATA;



CREATE MATERIALIZED VIEW IF NOT EXISTS money_agg AS
    select 
        created_at, 
        date_trunc('hour', created_at AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') created_at_hourly, 
        date_trunc('day', created_at AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') created_at_daily,
        date_trunc('month', created_at AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') created_at_monthly,
        date_trunc('year', created_at AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur') created_at_yearly,
        sum(ammount) over (partition by date_trunc('hour', created_at AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'),ammount) as total_ammount_by_type_hourly,
        sum(ammount) over (partition by date_trunc('day', created_at AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), ammount) as total_ammount_by_type_daily,
        sum(ammount) over (partition by date_trunc('month', created_at AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), ammount) as total_ammount_by_type_monthly,
        sum(ammount) over (partition by date_trunc('year', created_at AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kuala_Lumpur'), ammount) as total_ammount_by_type_yearly,
        tenant_id
    from 
        money_data
    where
        created_at > current_timestamp - INTERVAL '2 DAY'
    group by created_at, tenant_id
    order by created_at desc
WITH DATA;