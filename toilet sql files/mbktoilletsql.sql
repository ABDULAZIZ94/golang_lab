-- Active: 1720683458566@@127.0.0.1@5432@smarttoilet
SELECT * FROM toilet_infos WHERE toilet_info_id = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984'

-- basic table
SELECT * FROM devices

SELECT * FROM device_types

SELECT * FROM device_pairs

SELECT * FROM device_pairs WHERE toilet_info_id = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984'

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
SELECT DEVICES.DEVICE_NAME,DEVICES.DEVICE_ID,DEVICES.DEVICE_TOKEN,  
TOILET_INFOS.TOILET_NAME AS Identifier ,DEVICE_TYPES.DEVICE_TYPE_NAME as Namespace, gateway_id
FROM DEVICE_PAIRS  
JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID  
JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID = DEVICES.DEVICE_TYPE_ID  
JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID  
WHERE DEVICE_PAIRS.TOILET_INFO_ID = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984'

-- get list of devices in this identifier
SELECT DEVICES.DEVICE_NAME,DEVICES.DEVICE_ID,DEVICES.DEVICE_TOKEN,  
TOILET_INFOS.TOILET_NAME AS Identifier ,DEVICE_TYPES.DEVICE_TYPE_NAME as Namespace  
FROM DEVICE_PAIRS  
JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID  
JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID = DEVICES.DEVICE_TYPE_ID  
JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID  
WHERE DEVICE_PAIRS.TOILET_INFO_ID = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984'


-- gateway id = 'a91b5fe2-dd09-4d67-4a71-5a0b033f23c4'

-- DESCRIBE tables
select column_name, data_type, character_maximum_length, column_default, is_nullable
from INFORMATION_SCHEMA.COLUMNS where table_name = 'devices';

select column_name, data_type, character_maximum_length, column_default, is_nullable
from INFORMATION_SCHEMA.COLUMNS where table_name = 'device_types';

-- add device types

INSERT INTO device_types ("device_type_id", "device_type_name") VALUES (10, 'SMOKE_ALARM')

INSERT INTO device_types ("device_type_id", "device_type_name") VALUES (11, 'PANIC_BUTTON')

INSERT INTO device_types ("device_type_id", "device_type_name") VALUES (12, 'OCCUPANCY')

INSERT INTO device_types ("device_type_id", "device_type_name") VALUES (13, 'AMMONIA_SENSOR')

-- add device 

SET TIMEZONE='Asia/Kuala_Lumpur';

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
INSERT INTO devices ("device_id", "tenant_id", "device_name", "device_token", "latitude", "longitude", "device_type_id", "created_at", "updated_at", "deleted_at")
VALUES('8f88b1ef-0e5c-4766-b4c8-797aa946ef36', 'f8be7a6d-679c-4319-6906-d172ebf7c17e', 'SMOKE_ALARM_MALE', '69', 1, 1, '10', current_timestamp, current_timestamp, NULL)

INSERT INTO devices ("device_id", "tenant_id", "device_name", "device_token", "latitude", "longitude", "device_type_id", "created_at", "updated_at", "deleted_at")
VALUES('31e25e7d-5a89-4c47-bb7a-88d1b8e85a5d', 'f8be7a6d-679c-4319-6906-d172ebf7c17e', 'SMOKE_ALARM_FEMALE', '70', 1, 1, '10', current_timestamp, current_timestamp, NULL)

--panic btn
INSERT INTO devices ("device_id", "tenant_id", "device_name", "device_token", "latitude", "longitude", "device_type_id", "created_at", "updated_at", "deleted_at")
VALUES('e7c90ba9-fc49-4883-8b2f-64eabedbc502', 'f8be7a6d-679c-4319-6906-d172ebf7c17e', 'PANIC_BTN_MALE', '71', 1, 1, '11', current_timestamp, current_timestamp, NULL)

INSERT INTO devices ("device_id", "tenant_id", "device_name", "device_token", "latitude", "longitude", "device_type_id", "created_at", "updated_at", "deleted_at")
VALUES('4ff2e71b-0b08-4c92-a909-d351c21b592d', 'f8be7a6d-679c-4319-6906-d172ebf7c17e', 'PANIC_BTN_FEMALE', '72', 1, 1, '11', current_timestamp, current_timestamp, NULL)

INSERT INTO devices ("device_id", "tenant_id", "device_name", "device_token", "latitude", "longitude", "device_type_id", "created_at", "updated_at", "deleted_at")
VALUES('d0b00e9d-6b4a-4ee8-b124-4e5e39cf4039', 'f8be7a6d-679c-4319-6906-d172ebf7c17e', 'OCCUPANCY_MALE', '73', 1, 1, '12', current_timestamp, current_timestamp, NULL)

INSERT INTO devices ("device_id", "tenant_id", "device_name", "device_token", "latitude", "longitude", "device_type_id", "created_at", "updated_at", "deleted_at")
VALUES('a1c5f3b7-8d2e-4a9b-b8c1-7f9e2d0a5c81', 'f8be7a6d-679c-4319-6906-d172ebf7c17e', 'OCCUPANCY_FEMALE', '74', 1, 1, '12', current_timestamp, current_timestamp, NULL)

-- add ammonia sensor
INSERT INTO devices ("device_id", "tenant_id", "device_name", "device_token", "latitude", "longitude", "device_type_id", "created_at", "updated_at", "deleted_at")
VALUES('f7e2b9d4-3a1c-5b8d-a3f6-9e0c2d7f4a2b', 'f8be7a6d-679c-4319-6906-d172ebf7c17e', 'AMMONIA_SENSOR_MALE', '75', 1, 1, '13', current_timestamp, current_timestamp, NULL)

INSERT INTO devices ("device_id", "tenant_id", "device_name", "device_token", "latitude", "longitude", "device_type_id", "created_at", "updated_at", "deleted_at")
VALUES('1b3d5f9a-7c8e-2d4f-e6b9-0a1c3f8e2d5f', 'f8be7a6d-679c-4319-6906-d172ebf7c17e', 'AMMONIA_SENSOR_FEMALE', '76', 1, 1, '13', current_timestamp, current_timestamp, NULL)

-- add toilet infos

-- create pair
INSERT INTO device_pairs("device_pair_id", "gateway_id", "device_id", "toilet_info_id", "created_at", "updated_at", "deleted_at")
VALUES('','a91b5fe2-dd09-4d67-4a71-5a0b033f23c4','','',current_timestamp, current_timestamp, NULL)
