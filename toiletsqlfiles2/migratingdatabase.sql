-- Active: 1722832765629@@alpha.vectolabs.com@9998@smarttoilet-staging

-- enable extension
CREATE EXTENSION dblink;


 -- migrate devices
INSERT INTO devices (
    device_id ,
    tenant_id ,
    device_name ,
    device_token ,
    latitude,
    longitude ,
    device_type_id ,
    created_at ,
    updated_at ,
    deleted_at 
)
-- check devices differences
SELECT rt.*
FROM devices lt
    RIGHT JOIN (
        SELECT *
        FROM dblink (
                'host=alpha.vectolabs.com port=9998 dbname=smarttoilet user=postgres password=VectoLabs)1', 'SELECT * from devices'
            ) AS remote_table (device_id text, tenant_id text, device_name text, device_token text, latitude numeric, longitude numeric, 
            device_type_id integer, created_at timestamptz, updated_at timestamptz, deleted_at timestamptz)
    ) rt ON lt.device_id = rt.device_id
WHERE
    lt.device_id IS NULL;


-- migrate toilet infos


SELECT rt.*
FROM toilet_infos lt
    RIGHT JOIN (
        SELECT *
        FROM dblink (
                'host=alpha.vectolabs.com port=9998 dbname=smarttoilet user=postgres password=VectoLabs)1', 'SELECT * from toilet_infos'
            ) AS remote_table (
                toilet_info_id text, toilet_name text, toilet_type_id integer, tenant_id text, created_at timestamptz, updated_at timestamptz,
                 deleted_at timestamptz, fan_status text, display_status text, occupied_status text, location_id text, blower_status text, toilet_index text
            )
    ) rt ON lt.toilet_info_id = rt.toilet_info_id
WHERE
    lt.toilet_info_id IS NULL;


-- migrate tenants
SELECT rt.*
FROM tenants lt
    RIGHT JOIN (
        SELECT *
        FROM dblink (
                'host=alpha.vectolabs.com port=9998 dbname=smarttoilet user=postgres password=VectoLabs)1', 'SELECT * from tenants'
            ) AS remote_table (
                tenant_id text, tenant_name text, address text, business_reg_no text, created_at timestamptz,
                 updated_at timestamptz, deleted_at timestamptz, phone_no text
            )
    ) rt ON lt.tenant_id = rt.tenant_id
WHERE
    lt.tenant_id IS NULL;


-- migrate users
SELECT rt.*
FROM users lt
    RIGHT JOIN (
        SELECT *
        FROM dblink (
                'host=alpha.vectolabs.com port=9998 dbname=smarttoilet user=postgres password=VectoLabs)1', 'SELECT * from users'
            ) AS remote_table (
                user_id text, tenant_id text, user_name text, password text, phone_no text, email text, user_type_id integer, access_level_id integer,
                all_access text, get_notify text, created_at timestamptz, updated_at timestamptz, deleted_at timestamptz
            )
    ) rt ON lt.tenant_id = rt.tenant_id
WHERE
    lt.user_id IS NULL;


SELECT version();

-- migrate user reactions
INSERT INTO
    user_reactions (
        reaction_id,
        toilet_type,
        reaction,
        complaint,
        timestamp,
        toilet_id,
        score
    )


SELECT rt.*
FROM user_reactions lt
    RIGHT JOIN (
        SELECT *
        FROM dblink (
                'host=alpha.vectolabs.com port=9998 dbname=smarttoilet user=postgres password=VectoLabs)1', 'SELECT * from user_reactions'
            ) AS remote_table (
                reaction_id text, toilet_type text, reaction text, complaint text, timestamp timestamptz, toilet_id text, score integer
            )
    ) rt ON lt.reaction_id = rt.reaction_id
WHERE
    lt.reaction_id IS NULL;


-- migrate misc action data
INSERT INTO
    misc_action_data (
        misc_data_id,
        device_token,
        toilet_info_id,
        namespace,
        status,
        timestamp
    )
SELECT rt.*
FROM misc_action_data lt
    RIGHT JOIN (
        SELECT *
        FROM dblink (
                'host=alpha.vectolabs.com port=9998 dbname=smarttoilet user=postgres password=VectoLabs)1', 'SELECT * from misc_action_data'
            ) AS remote_table (
                misc_data_id text, device_token text, toilet_info_id text, namespace text, status text, timestamp timestamptz
            )
    ) rt ON lt.misc_data_id = rt.misc_data_id
WHERE
    lt.misc_data_id IS NULL;


-- migrate fp sensor data
INSERT INTO
    fp_sensor_data (
        fpr_sensor_data_id,
        device_token,
        temperature,
        humidity,
        created_at,
        updated_at,
        deleted_at,
        rssi,
        cpu_temp
    )
SELECT rt.*
FROM fp_sensor_data lt
    RIGHT JOIN (
        SELECT *
        FROM dblink (
                'host=alpha.vectolabs.com port=9998 dbname=smarttoilet user=postgres password=VectoLabs)1', 'SELECT * from fp_sensor_data'
            ) AS remote_table (
                fpr_sensor_data_id text, device_token text, temperature numeric, humidity numeric, created_at timestamptz, updated_at timestamptz, deleted_at timestamptz,
                rssi numeric, cpu_temp numeric
            )
    ) rt ON lt.fpr_sensor_data_id = rt.fpr_sensor_data_id
WHERE
    lt.fpr_sensor_data_id IS NULL;


-- migrate feedback panel data
INSERT INTO
    feedback_panel_data (
        fp_data_id,
        device_token,
        button_id,
        timestamp,
        toilet_type_id
    )
SELECT rt.*
FROM feedback_panel_data lt
    RIGHT JOIN (
        SELECT *
        FROM dblink (
                'host=alpha.vectolabs.com port=9998 dbname=smarttoilet user=postgres password=VectoLabs)1', 'SELECT * from feedback_panel_data'
            ) AS remote_table (
                fp_data_id text, device_token text, button_id numeric, timestamp timestamptz, toilet_type_id integer
            )
    ) rt ON lt.fp_data_id = rt.fp_data_id
WHERE
    lt.fp_data_id IS NULL;


-- migrate feedback panel settings
SELECT rt.*
FROM feedback_panel_settings lt
    RIGHT JOIN (
        SELECT *
        FROM dblink (
                'host=alpha.vectolabs.com port=9998 dbname=smarttoilet user=postgres password=VectoLabs)1', 'SELECT * from feedback_panel_settings'
            ) AS remote_table (
                fp_entry_set_id text, fp_set_id text, button_id integer, notify_user_state text, activate_on_feed_state text, notify_user_cnt text
            )
    ) rt ON lt.fp_entry_set_id = rt.fp_entry_set_id
WHERE
    lt.fp_entry_set_id IS NULL;

-- migrate enviroment data
INSERT INTO
    enviroment_data (
        env_data_id,
        device_token,
        iaq,
        temperature,
        humidity,
        lux,
        timestamp
    )
SELECT rt.*
FROM
    enviroment_data lt
    RIGHT JOIN (
        SELECT *
        FROM dblink (
                'host=alpha.vectolabs.com port=9998 dbname=smarttoilet user=postgres password=VectoLabs)1', 'SELECT * from enviroment_data'
            ) AS remote_table (
                env_data_id text, device_token text, iaq numeric, temperature numeric, humidity numeric, lux numeric, timestamp timestamptz
            )
    ) rt ON lt.env_data_id = rt.env_data_id
WHERE
    lt.env_data_id IS NULL;


-- migrate counter data
INSERT INTO
    counter_data (
        counter_data_id,
        device_token,
        people_in,
        people_out,
        timestamp
    )
SELECT rt.*
FROM counter_data lt
    RIGHT JOIN (
        SELECT *
        FROM dblink (
                'host=alpha.vectolabs.com port=9998 dbname=smarttoilet user=postgres password=VectoLabs)1', 'SELECT * from counter_data'
            ) AS remote_table (
                counter_data_id text, device_token text, people_in numeric, people_out numeric, timestamp timestamptz
            )
    ) rt ON lt.counter_data_id = rt.counter_data_id
WHERE
    lt.counter_data_id IS NULL;


-- migrate cleaner reports
INSERT INTO
    cleaner_reports (
        cleaner_report_id,
        tenant_id,
        cleaner_user_id,
        location_id,
        toilet_type_id,
        task_completed,
        notify_id,
        check_in_ts,
        check_out_ts,
        duration,
        auto_clean_state,
        freshen_up_state,
        door_lock_state,
        remarks,
        created_at,
        updated_at,
        deleted_at,
        feedback_panel_id
    )
SELECT rt.*
FROM cleaner_reports lt
    RIGHT JOIN (
        SELECT *
        FROM dblink (
                'host=alpha.vectolabs.com port=9998 dbname=smarttoilet user=postgres password=VectoLabs)1', 'SELECT * from cleaner_reports'
            ) AS remote_table (
                cleaner_report_id text, tenant_id text, cleaner_user_id text, location_id text, toilet_type_id integer, task_completed text[],
                notify_id text[], check_in_ts timestamptz, check_out_ts timestamptz, duration numeric, auto_clean_state text, freshen_up_state text,
                door_lock_state text, remarks text, created_at timestamptz, updated_at timestamptz, deleted_at timestamptz, feedback_panel_id text
            )
    ) rt ON lt.cleaner_report_id = rt.cleaner_report_id
WHERE
    lt.cleaner_report_id IS NULL;


-- migrate mqtt users
INSERT INTO
    mqtt_users (
        id,
        username,
        password_hash,
        salt,
        is_superuser,
        created,
        plaintext,
        tenant_id
    )
SELECT rt.*
FROM mqtt_users lt
    RIGHT JOIN (
        SELECT *
        FROM dblink (
                'host=alpha.vectolabs.com port=9998 dbname=smarttoilet user=postgres password=VectoLabs)1', 'SELECT * from mqtt_users'
            ) AS remote_table (
                id integer, username text, password_hash text, salt text, is_superuser boolean, created timestamptz, 
                plaintext text , tenant_id text
            )
    ) rt ON lt.id = rt.id OR lt.username = rt.username 
WHERE
    lt.id IS NULL;


-- migrate mqtt acl
SELECT rt.*
FROM mqtt_acls lt
    RIGHT JOIN (
        SELECT *
        FROM dblink (
                'host=alpha.vectolabs.com port=9998 dbname=smarttoilet user=postgres password=VectoLabs)1', 'SELECT * from mqtt_acls'
            ) AS remote_table (
                id integer, ipaddress varchar, username varchar, clientid varchar, action action, permission permission, topic varchar, tenant_id text
            )
    ) rt ON lt.id = rt.id
    OR lt.username = rt.username
WHERE
    lt.id IS NULL;


-- migrate cleaner_and_tenants
INSERT INTO
    contractor_and_tenants (
        pair_id,
        tenant_id,
        contractor_id
    )
SELECT rt.*
FROM contractor_and_tenants lt
    RIGHT JOIN (
        SELECT *
        FROM dblink (
                'host=alpha.vectolabs.com port=9998 dbname=smarttoilet user=postgres password=VectoLabs)1', 'SELECT * from contractor_and_tenants'
            ) AS remote_table (
                pair_id text, tenant_id text, contractor_id text
            )
    ) rt ON lt.pair_id = rt.pair_id
WHERE
    lt.pair_id IS NULL;


-- migrate contractors
INSERT INTO
    contractors (
        contractor_id,
        contractor_name
    )
SELECT rt.*
FROM
    contractors lt
    RIGHT JOIN (
        SELECT *
        FROM dblink (
                'host=alpha.vectolabs.com port=9998 dbname=smarttoilet user=postgres password=VectoLabs)1', 'SELECT * from contractors'
            ) AS remote_table (
                contractor_id text, contractor_name text
            )
    ) rt ON lt.contractor_id = rt.contractor_id
WHERE
    lt.contractor_id IS NULL;


-- migrate cubical infos -- not exists
SELECT rt.*
FROM cubical_infos lt
    RIGHT JOIN (
        SELECT *
        FROM dblink (
                'host=alpha.vectolabs.com port=9998 dbname=smarttoilet user=postgres password=VectoLabs)1', 'SELECT * from cubical_infos'
            ) AS remote_table (
                cubical_id text, cubical_name text, cubical_nick_name text, cubicle_id text, cubicle_name text, cubicle_nick_name text
            )
    ) rt ON lt.cubical_id = rt.cubical_id
WHERE
    lt.cubical_id IS NULL;


-- migrate device_pairs
INSERT INTO
    device_pairs (
        device_pair_id,
        gateway_id,
        device_id,
        toilet_info_id,
        created_at,
        updated_at,
        deleted_at
    )
SELECT rt.*
FROM device_pairs lt
    RIGHT JOIN (
        SELECT *
        FROM dblink (
                'host=alpha.vectolabs.com port=9998 dbname=smarttoilet user=postgres password=VectoLabs)1', 'SELECT * from device_pairs'
            ) AS remote_table (
                device_pair_id text, gateway_id text, device_id text, toilet_info_id text, created_at timestamptz,
                 updated_at timestamptz, deleted_at timestamptz
            )
    ) rt ON lt.device_pair_id = rt.device_pair_id
WHERE
    lt.device_pair_id IS NULL;


-- migrate device types
INSERT INTO
    device_types (
        device_type_id,
        device_type_name
    )
SELECT rt.*
FROM device_types lt
    RIGHT JOIN (
        SELECT *
        FROM dblink (
                'host=alpha.vectolabs.com port=9998 dbname=smarttoilet user=postgres password=VectoLabs)1', 'SELECT * from device_types'
            ) AS remote_table (
                device_type_id integer, device_type_name text
            )
    ) rt ON lt.device_type_id = rt.device_type_id
WHERE
    lt.device_type_id IS NULL;


-- migrate feedback_panels
SELECT rt.*
FROM feedback_panels lt
    RIGHT JOIN (
        SELECT *
        FROM dblink (
                'host=alpha.vectolabs.com port=9998 dbname=smarttoilet user=postgres password=VectoLabs)1', 'SELECT * from feedback_panels'
            ) AS remote_table (
                button_id integer, button_name text
            )
    ) rt ON lt.button_id = rt.button_id
WHERE
    lt.button_id IS NULL;


-- migrate locations
SELECT rt.*
FROM locations lt
    RIGHT JOIN (
        SELECT *
        FROM dblink (
                'host=alpha.vectolabs.com port=9998 dbname=smarttoilet user=postgres password=VectoLabs)1', 'SELECT * from locations'
            ) AS remote_table (
                location_id text, location_name text, latitude numeric, longitude numeric, tenant_id text, created_at timestamptz, updated_at timestamptz,
                deleted_at timestamptz, fp_type text, dev_mode text
            )
    ) rt ON lt.location_id = rt.location_id
WHERE
    lt.location_id IS NULL;

-- notification data
INSERT INTO
    notification_data (
        notify_id,
        device_token,
        frequency,
        toilet_type_id,
        button_id,
        message,
        action_status,
        timestamp,
        namespace,
        lux,
        iaq
    )
SELECT rt.*
FROM notification_data lt
    RIGHT JOIN (
        SELECT *
        FROM dblink (
                'host=alpha.vectolabs.com port=9998 dbname=smarttoilet user=postgres password=VectoLabs)1', 'SELECT * from notification_data'
            ) AS remote_table (
                notify_id text, device_token text, frequency integer, toilet_type_id integer, button_id integer, message text, action_status text, 
                timestamp timestamptz, namespace text, lux numeric, iaq numeric
            )
    ) rt ON lt.notify_id = rt.notify_id
WHERE
    lt.notify_id IS NULL;


-- setting values
SELECT rt.*
FROM setting_values lt
    RIGHT JOIN (
        SELECT *
        FROM dblink (
                'host=alpha.vectolabs.com port=9998 dbname=smarttoilet user=postgres password=VectoLabs)1', 'SELECT * from setting_values'
            ) AS remote_table (
                setting_id text, entity_id text, context text, active_freg_stat text, active_freg_on_cnt text, active_freg_odour_level text, 
                notify_cleaner_total_user text, notify_start_ts text, notify_stop_ts text, notify_freg_spray_cnt text, cleaner_response_ts text,
                notify_on_lux_thres text, notify_on_lux_state text, notify_on_odour_thres text, notify_on_odour_state text,
                fp_set_id text, created_at timestamptz, updated_at timestamptz,deleted_at timestamptz, active_actuator_on_cnt_state text, 
                active_actuator_cnt text, active_actuator_on_odour_state text,
                active_actuator_on_odour_lvl text, notify_on_freg_level text, notify_on_freg_level_state text, activate_actuator_run_time text,
                activate_waterjet_run_time text, activate_waterjet_state text,
                active_door_lock_run_time text,active_door_lock_time text, notify_cleaner_total_user_state text, cleaner_response_ts_notify_state text, 
                refresh_interval_in_sec text, offline_interval_in_in_sec text
            )
    ) rt ON lt.setting_id = rt.setting_id
WHERE
    lt.setting_id IS NULL;


-- sso providers
SELECT rt.*
FROM sso_providers lt
    RIGHT JOIN (
        SELECT *
        FROM dblink (
                'host=alpha.vectolabs.com port=9998 dbname=smarttoilet user=postgres password=VectoLabs)1', 'SELECT * from sso_providers'
            ) AS remote_table (
                provider_id text, client_endpoint text, client_id text, client_secrect text, tenant_id text, created_at timestamptz,
                updated_at timestamptz, deleted_at timestamptz, provider text, scopes text, application_id text, 
                redirect_url text, destination_url text
            )
    ) rt ON lt.provider_id = rt.provider_id
WHERE
    lt.provider_id IS NULL;


-- toilet_types
SELECT rt.*
FROM toilet_types lt
    RIGHT JOIN (
        SELECT *
        FROM dblink (
                'host=alpha.vectolabs.com port=9998 dbname=smarttoilet user=postgres password=VectoLabs)1', 'SELECT * from toilet_types'
            ) AS remote_table (
                toilet_type_id integer, toilet_type_name text
            )
    ) rt ON lt.toilet_type_id = rt.toilet_type_id
WHERE
    lt.toilet_type_id IS NULL;


-- user types
SELECT rt.*
FROM user_types lt
    RIGHT JOIN (
        SELECT *
        FROM dblink (
                'host=alpha.vectolabs.com port=9998 dbname=smarttoilet user=postgres password=VectoLabs)1', 'SELECT * from user_types'
            ) AS remote_table (
                user_type_id integer, user_type_name text, created_at timestamptz, updated_at timestamptz, deleted_at timestamptz
            )
    ) rt ON lt.user_type_id = rt.user_type_id
WHERE
    lt.user_type_id IS NULL;