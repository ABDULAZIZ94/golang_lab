-- Active: 1722832765629@@alpha.vectolabs.com@9998@smarttoilet-staging

select * from users

PREPARE get_users_by_name (text) AS SELECT * FROM users WHERE user_name = $1;
EXECUTE get_users_by_name('abdaziz');
EXECUTE get_users_by_name('john');

select * from users where user_name = 'john'


select *
from pg_indexes
where tablename = 'users'


CREATE INDEX IF NOT EXISTS user_name_index
ON users(user_name, password);

CREATE INDEX IF NOT EXISTS occupancy_idx_2
ON occupancy_data(id, device_token, occupied, timestamp);


-- manual device activations index
CREATE INDEX IF NOT EXISTS manual_device_activations_idx_2 ON manual_device_activations (
    id,
    device_token,
    duration,
    start_active_time,
    end_active_time,
    toilet_info_id,
    cubicle_id
);


-- misc action data index
CREATE INDEX IF NOT EXISTS misc_action_data_idx2 ON misc_action_data (
    misc_data_id,
    device_token,
    toilet_info_id,
    namespace,
    status,
    timestamp
);

-- misc action data index
CREATE INDEX IF NOT EXISTS ammonia_data_idx2 ON ammonia_data (
    id,
    device_token,
    -- ammonia_level,
    timestamp
);

-- cleaner and tenants
CREATE INDEX IF NOT EXISTS cleaner_and_tenants_idx2 ON cleaner_and_tenants (
    pair_id,
    cleaner_id,
    tenant_id,
    contractor_id 
);

-- cleaner reports
CREATE INDEX IF NOT EXISTS cleaner_reports_idx2 ON cleaner_reports (
    -- cleaner_report_id,
    cleaner_user_id,
    location_id,
    toilet_type_id,
    -- task_completed,
    -- notify_id,
    check_in_ts,
    check_out_ts,
    -- duration,
    auto_clean_state,
    freshen_up_state,
    -- door_lock_state,
    -- remarks,
    created_at,
    updated_at,
    deleted_at,
    cubical_id
);

-- cleaner rfid
CREATE INDEX IF NOT EXISTS cleaner_rfids_idx2 ON cleaner_rfids (
    id,
    user_id,
    rfid_number,
    staff_id,
    created_at,
    updated_at,
    deleted_at
);

--contractors and tenants
CREATE INDEX IF NOT EXISTS contractor_and_tenants_idx2 ON contractor_and_tenants (
    pair_id,
    tenant_id,
    contractor_id
);

--counter_data
CREATE INDEX IF NOT EXISTS counter_data_idx2 ON counter_data (
    counter_data_id,
    device_token,
    people_in,
    people_out,
    timestamp
);


explain select * from ammonia_data

explain select * from devices order by device_id limit 1

explain select * from devices

select * from devices

select * from devices order by device_id limit 1

explain select * from ammonia_data
where timestamp > to_timestamp('2024-09-20 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
order by timestamp, id desc
limit 5

explain select * from ammonia_data
join devices on devices.device_token = ammonia_data.device_token
order by timestamp


-- check used index
SELECT
    relname AS table_name,
    indexrelname AS index_name,
    idx_scan AS index_scans
FROM pg_stat_user_indexes
-- WHERE
--     idx_scan > 0
ORDER BY index_scans DESC;

-- more details
SELECT
    *,
    relname AS table_name,
    indexrelname AS index_name,
    idx_scan AS index_scans
FROM pg_stat_user_indexes
WHERE
    idx_scan > 0
ORDER BY index_scans DESC;


-- guest when index created
SELECT index.relname AS index_name, index.relfilenode, to_char(
        pg_stat_activity.backend_start, 'YYYY-MM-DD HH24:MI:SS'
    ) AS creation_time
FROM pg_stat_activity, pg_class AS index
WHERE
    index.relkind like 'uix'
    AND index.oid = pg_stat_activity.pid
ORDER BY creation_time DESC;


explain select * from locations

explain select * from public.devices
join public.device_pairs on device_pairs.device_id = devices.device_id


explain select * from counter_data order by timestamp,counter_data_id desc

-- gentime

SELECT uplinkTS
FROM generate_series(
        date_trunc(
            'HOUR', TO_TIMESTAMP(
                '2024-09-29 23:00:00', 'YYYY-MM-DD HH24:MI:SS'
            )
        ), date_trunc(
            'HOUR', TO_TIMESTAMP(
                '2024-09-30 16:00:00', 'YYYY-MM-DD HH24:MI:SS'
            )
        ), interval '1' HOUR
    ) uplinkTS
    
-- string to array

SELECT unnest(string_to_array('token1,id1,token2,id2,token3,id3', ','));

select unnest(string_to_array('2024-09-30 00:00:00+00,
2024-09-31 01:00:00+00',','))as uplinkts;


-- fail query
GENTIME as (
    SELECT uplinkTS
    FROM generate_series(
            date_trunc(
                'HOUR', TO_TIMESTAMP(
                    '2024-09-29 23:00:00', 'YYYY-MM-DD HH24:MI:SS'
                )
            ), date_trunc(
                'HOUR', TO_TIMESTAMP(
                    '2024-09-30 16:00:00', 'YYYY-MM-DD HH24:MI:SS'
                )
            ), interval '1' HOUR
        ) uplinkTS
    where
        EXTRACT(
            HOUR
            FROM uplinkTS
        ) >= 23
        AND EXTRACT(
            HOUR
            FROM uplinkTS
        ) <= 0
        or EXTRACT(
            HOUR
            FROM uplinkTS
        ) >= 0
        AND EXTRACT(
            HOUR
            FROM uplinkTS
        ) <= 10
) 


-- database performance
CREATE EXTENSION pg_stat_statements;

SELECT pg_reload_conf();

SELECT * FROM pg_extension WHERE extname = 'pg_stat_statements';

SELECT 
    query,
    calls,
    total_time,
    min_time,
    max_time,
    mean_time,
    stddev_time,
    rows,
    shared_blks_read,
    shared_blks_written,
    local_blks_read,
    local_blks_written,
    temp_blks_written,
    blk_read_time,
    blk_write_time
FROM 
    pg_stat_statements
ORDER BY 
    total_time DESC
LIMIT 1;  -- Adjust the limit as necessary


select * from devices