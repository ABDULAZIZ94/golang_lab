-- Active: 1722832765629@@alpha.vectolabs.com@9998@smarttoilet-staging


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
