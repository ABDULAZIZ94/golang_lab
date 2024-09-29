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
    ammonia_level,
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