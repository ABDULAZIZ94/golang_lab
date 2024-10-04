

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