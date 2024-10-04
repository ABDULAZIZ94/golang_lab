

CREATE EXTENSION dblink;

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

-- check differences
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

