-- Active: 1720683458566@@127.0.0.1@5432@smarttoilet
SELECT *
FROM toilet_infos

SELECT *
FROM toilet_infos
WHERE
    toilet_info_id = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984'

--  tenant id perbadanan putrajaya  59944171-3a4a-460d-5897-8bb38c524d54

-- location mbk, zoo teruntum kuantan 57fd94bb-d029-4aa7-7d77-ea8b3f19a330, 
-- location mbk , taman bandar kuantan da7a998b-94fc-4376-789f-029a93f25f10
SELECT *
FROM toilet_infos
WHERE
    tenant_id = '59944171-3a4a-460d-5897-8bb38c524d54'

SELECT *
FROM toilet_infos
WHERE
    tenant_id = 'f8be7a6d-679c-4319-6906-d172ebf7c17e'

-- basic table
SELECT * FROM devices

SELECT * FROM device_types

SELECT * FROM device_pairs

SELECT *
FROM device_pairs
WHERE
    toilet_info_id = 'f8be7a6d-679c-4319-6906-d172ebf7c17e'

SELECT * FROM toilet_infos
-- new table
SELECT * FROM fragrance_data

SELECT * FROM ammonia_data

SELECT * FROM smells_data

SELECT * FROM smoke_data

SELECT * FROM occupancy_data
-- majlis kuantan
-- tenant id :f8be7a6d-679c-4319-6906-d172ebf7c17e, toilet_info_id: 0a38e4d1-f9b9-4cb2-648f-20e0ac269984
-- gateway_id : a91b5fe2-dd09-4d67-4a71-5a0b033f23c4, device_pair_id, 7e69638d-b002-4718-67e2-2191052cea97

-- get list of devices in this identifier
SELECT
    DEVICES.DEVICE_NAME,
    DEVICES.DEVICE_ID,
    DEVICES.DEVICE_TOKEN,
    TOILET_INFOS.TOILET_NAME AS Identifier,
    DEVICE_TYPES.DEVICE_TYPE_NAME as Namespace,
    gateway_id
FROM
    DEVICE_PAIRS
    JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID
    JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID = DEVICES.DEVICE_TYPE_ID
    JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID
WHERE
    DEVICE_PAIRS.TOILET_INFO_ID = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984'
-- get list of devices in this identifier
SELECT DEVICES.DEVICE_NAME, DEVICES.DEVICE_ID, DEVICES.DEVICE_TOKEN, TOILET_INFOS.TOILET_NAME AS Identifier, DEVICE_TYPES.DEVICE_TYPE_NAME as Namespace
FROM
    DEVICE_PAIRS
    JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID
    JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID = DEVICES.DEVICE_TYPE_ID
    JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID
WHERE
    DEVICE_PAIRS.TOILET_INFO_ID = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984'

-- gateway id = 'a91b5fe2-dd09-4d67-4a71-5a0b033f23c4'

-- DESCRIBE tables
select
    column_name,
    data_type,
    character_maximum_length,
    column_default,
    is_nullable
from INFORMATION_SCHEMA.COLUMNS
where
    table_name = 'devices';

select
    column_name,
    data_type,
    character_maximum_length,
    column_default,
    is_nullable
from INFORMATION_SCHEMA.COLUMNS
where
    table_name = 'device_types';

-- add device types

INSERT INTO
    device_types (
        "device_type_id",
        "device_type_name"
    )
VALUES (10, 'SMOKE_ALARM')

INSERT INTO
    device_types (
        "device_type_id",
        "device_type_name"
    )
VALUES (11, 'PANIC_BUTTON')

INSERT INTO
    device_types (
        "device_type_id",
        "device_type_name"
    )
VALUES (12, 'OCCUPANCY')

INSERT INTO
    device_types (
        "device_type_id",
        "device_type_name"
    )
VALUES (13, 'AMMONIA_SENSOR')
-- add device

SET TIMEZONE = 'Asia/Kuala_Lumpur';

SELECT NOW()::timestamp;

-- rand 740032bd-00a7-4d0b-4d66-3c7b7d0d1d6d
-- 8f88b1ef-0e5c-4766-b4c8-797aa946ef36
-- 31e25e7d-5a89-4c47-bb7a-88d1b8e85a5d
-- e7c90ba9-fc49-4883-8b2f-64eabedbc502
-- 4ff2e71b-0b08-4c92-a909-d351c21b592d
-- d0b00e9d-6b4a-4ee8-b124-4e5e39cf4039
-- a1c5f3b7-8d2e-4a9b-b8c1-7f9e2d0a5c81
-- f7e2b9d4-3a1c-5b8d-a3f6-9e0c2d7f4a2b
-- 1b3d5f9a-7c8e-2d4f-e6b9-0a1c3f8e2d5f

-- smoke alarm
INSERT INTO
    devices (
        "device_id",
        "tenant_id",
        "device_name",
        "device_token",
        "latitude",
        "longitude",
        "device_type_id",
        "created_at",
        "updated_at",
        "deleted_at"
)VALUES (
        '8f88b1ef-0e5c-4766-b4c8-797aa946ef36',
        'f8be7a6d-679c-4319-6906-d172ebf7c17e',
        'SMOKE_ALARM_MALE',
        '69',
        1,
        1,
        '10',
        current_timestamp,
        current_timestamp,
        NULL
    )

INSERT INTO
    devices (
        "device_id",
        "tenant_id",
        "device_name",
        "device_token",
        "latitude",
        "longitude",
        "device_type_id",
        "created_at",
        "updated_at",
        "deleted_at"
)VALUES ( 
        '31e25e7d-5a89-4c47-bb7a-88d1b8e85a5d',
        'f8be7a6d-679c-4319-6906-d172ebf7c17e',
        'SMOKE_ALARM_FEMALE',
        '70',
        1,
        1,
        '10',
        current_timestamp,
        current_timestamp,
        NULL
    )

--panic btn
INSERT INTO
    devices (
        "device_id",
        "tenant_id",
        "device_name",
        "device_token",
        "latitude",
        "longitude",
        "device_type_id",
        "created_at",
        "updated_at",
        "deleted_at"
    )
VALUES (
        'e7c90ba9-fc49-4883-8b2f-64eabedbc502',
        'f8be7a6d-679c-4319-6906-d172ebf7c17e',
        'PANIC_BTN_MALE',
        '71',
        1,
        1,
        '11',
        current_timestamp,
        current_timestamp,
        NULL
    )

INSERT INTO
    devices (
        "device_id",
        "tenant_id",
        "device_name",
        "device_token",
        "latitude",
        "longitude",
        "device_type_id",
        "created_at",
        "updated_at",
        "deleted_at"
    )
VALUES (
        '4ff2e71b-0b08-4c92-a909-d351c21b592d',
        'f8be7a6d-679c-4319-6906-d172ebf7c17e',
        'PANIC_BTN_FEMALE',
        '72',
        1,
        1,
        '11',
        current_timestamp,
        current_timestamp,
        NULL
    )

INSERT INTO
    devices (
        "device_id",
        "tenant_id",
        "device_name",
        "device_token",
        "latitude",
        "longitude",
        "device_type_id",
        "created_at",
        "updated_at",
        "deleted_at"
    )
VALUES (
        'd0b00e9d-6b4a-4ee8-b124-4e5e39cf4039',
        'f8be7a6d-679c-4319-6906-d172ebf7c17e',
        'OCCUPANCY_MALE',
        '73',
        1,
        1,
        '12',
        current_timestamp,
        current_timestamp,
        NULL
    )

INSERT INTO
    devices (
        "device_id",
        "tenant_id",
        "device_name",
        "device_token",
        "latitude",
        "longitude",
        "device_type_id",
        "created_at",
        "updated_at",
        "deleted_at"
)VALUES (
        'a1c5f3b7-8d2e-4a9b-b8c1-7f9e2d0a5c81',
        'f8be7a6d-679c-4319-6906-d172ebf7c17e',
        'OCCUPANCY_FEMALE',
        '74',
        1,
        1,
        '12',
        current_timestamp,
        current_timestamp,
        NULL
    )

-- add ammonia sensor
INSERT INTO
    devices (
        "device_id",
        "tenant_id",
        "device_name",
        "device_token",
        "latitude",
        "longitude",
        "device_type_id",
        "created_at",
        "updated_at",
        "deleted_at"
    )
VALUES (
        'f7e2b9d4-3a1c-5b8d-a3f6-9e0c2d7f4a2b',
        'f8be7a6d-679c-4319-6906-d172ebf7c17e',
        'AMMONIA_SENSOR_MALE',
        '75',
        1,
        1,
        '13',
        current_timestamp,
        current_timestamp,
        NULL
    )

INSERT INTO
    devices (
        "device_id",
        "tenant_id",
        "device_name",
        "device_token",
        "latitude",
        "longitude",
        "device_type_id",
        "created_at",
        "updated_at",
        "deleted_at"
    )
VALUES (
        '1b3d5f9a-7c8e-2d4f-e6b9-0a1c3f8e2d5f',
        'f8be7a6d-679c-4319-6906-d172ebf7c17e',
        'AMMONIA_SENSOR_FEMALE',
        '76',
        1,
        1,
        '13',
        current_timestamp,
        current_timestamp,
        NULL
    )
-- add toilet infos

-- pair ids
7e69638d-b002-4718-67e2-2191052cea97
44f3a783-99a6-4f1a-43a4-349402e8a18c
c8f3d7b2-82e5-4c6f-2f85-3d4b0501c7c3
67ea8b59-1e7b-4985-1d18-39d4d76f8f5d
80a2e2d6-917f-4eb0-8d1b-125d8f6a4487
b789f9e2-4bb1-4cf6-9497-13a24d48b8f1
9f87703e-1a24-4a56-9d56-5d6b745dcf7d
a92c4a1f-5b98-48b0-bf6c-8a7b5b4e2b95
f5700e7d-1d47-4c5c-b5a4-74b61d497843
3b2e0f6c-2b49-4c1f-9203-14c9d295a92d

-- create pair
INSERT INTO
    device_pairs (
        "device_pair_id",
        "gateway_id",
        "device_id",
        "toilet_info_id",
        "created_at",
        "updated_at",
        "deleted_at"
    )
VALUES (
        '44f3a783-99a6-4f1a-43a4-349402e8a18c',
        'a91b5fe2-dd09-4d67-4a71-5a0b033f23c4',
        '8f88b1ef-0e5c-4766-b4c8-797aa946ef36',
        '0a38e4d1-f9b9-4cb2-648f-20e0ac269984',
        current_timestamp,
        current_timestamp,
        NULL
    )

-- check if device belong to tenant
SELECT *
FROM devices
WHERE
    device_id = '31e25e7d-5a89-4c47-bb7a-88d1b8e85a5d'
    AND tenant_id = 'f8be7a6d-679c-4319-6906-d172ebf7c17e'

SELECT * FROM devices WHERE device_id = "" AND tenant_id = ""

SELECT *
FROM devices
WHERE
    device_id = '31e25e7d-5a89-4c47-bb7a-88d1b8e85a5d'
    
-- broken sql query
SELECT device_token, device_type_id
FROM "devices"
WHERE
    "devices"."deleted_at" IS NULL
    AND (
        (
            device_id = '31e25e7d-5a89-4c47-bb7a-88d1b8e85a5d'
            AND tenant_id = ''
        )
    )