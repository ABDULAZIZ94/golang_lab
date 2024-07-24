-- Active: 1720683458566@@127.0.0.1@5432@smarttoilet

-- to add new sensor needs:
-- add device type
-- add to devices
-- pair device
-- create it own table

-- usefull information
--  tenant id perbadanan putrajaya  59944171-3a4a-460d-5897-8bb38c524d54
-- location mbk, zoo teruntum kuantan 57fd94bb-d029-4aa7-7d77-ea8b3f19a330,
-- location mbk , taman bandar kuantan da7a998b-94fc-4376-789f-029a93f25f10

-- majlis kuantan
-------------------------------------------------------------------------------------------------------------------------
-- tenant id :f8be7a6d-679c-4319-6906-d172ebf7c17e, 
-- toilet_info_id: 0a38e4d1-f9b9-4cb2-648f-20e0ac269984 : toilet male_
-- toilet_info_id: 9eca5dcc-7946-4367-60a5-d7bd09b1e16a : toilet female

-- gateway_id : a91b5fe2-dd09-4d67-4a71-5a0b033f23c4, device_pair_id, 7e69638d-b002-4718-67e2-2191052cea97

-- checking tables
-- 9eca5dcc-7946-4367-60a5-d7bd09b1e16a TOILET FEMALE Majlis Bandaraya Kuantan Taman Bandar Kuantan
-- 5654c008-dbcc-4656-5601-0a0c50652213 TOILET MALE Majlis Bandaraya Kuantan Taman Bandar Kuantan
-- 0a38e4d1-f9b9-4cb2-648f-20e0ac269984 TOILET MALE Majlis Bandaraya Kuantan Zoo Teruntum Kuantan
-- 2a9fbea0-4dca-4af6-457b-348bf682cb54 TOILET FEMALE Majlis Bandaraya Kuantan Zoo Teruntum Kuantan

select * from toilet_infos

select * from tenants

select * from locations

--list devices and its ammonia_data 
select d.device_token, avg(ad.ammonia_level)
from devices d
join ammonia_data ad on d.device_token = ad.device_token
group by d.device_token
order by d.device_token

-- list toilet for mbk with its locations
select ti.toilet_info_id, ti.toilet_name, te.tenant_name, loc.location_name
from toilet_infos ti
join tenants te on ti.tenant_id = te.tenant_id
join locations loc on ti.location_id = loc.location_id
where ti.tenant_id = 'f8be7a6d-679c-4319-6906-d172ebf7c17e'
order by loc.location_name



SELECT * FROM devices

SELECT * FROM device_types

SELECT * FROM device_pairs

SELECT * FROM toilet_infos

SELECT * FROM toilet_infos

SELECT * FROM fragrance_data

SELECT * FROM ammonia_data

SELECT * FROM smells_data

SELECT * FROM smoke_data

SELECT * FROM occupancy_data

SELECT * FROM tenants

select * from occupancy_data

-- list gateways used for pairing and number of devices attached to the gateway
select gateway_id, COUNT(device_pair_id) as total_atached_devices from device_pairs group by gateway_id

-- list of device and its tenant name
select devices.device_id, devices.device_name, devices.tenant_id, tenants.tenant_name 
from devices
join tenants on devices.tenant_id = tenants.tenant_id

-- list of gateway with numbers of devices atached on  it and tenant name
-- select
--     gateway_id,
--     COUNT(device_pair_id) as total_atached_devices
-- from device_pairs
-- join devices_details on device_pairs.device_id = device_details.device_id
--     (select devices.device_id, devices.device_name, devices.tenant_id, tenants.tenant_name
--     from devices
--         join tenants on devices.tenant_id = tenants.tenant_id) as devices_details
-- group by gateway_id

-- #2 list of gateway with numbers of devices atached on  it and tenant name
WITH gateway as (select
    gateway_id,
    COUNT(device_pair_id) as total_atached_devices
        from
    device_pairs
    group by gateway_id)
        select devices.device_id, devices.device_name, devices.tenant_id, tenants.tenant_name, gateway. total_atached_devices
        from devices
            join tenants on devices.tenant_id = tenants.tenant_id
            join gateway on devices.device_id = gateway.gateway_id
    

-- toilet info with its tenant name and total devices on it
select t.toilet_name, o.tenant_name, t.fan_status, t.display_status, t.occupied_status
from toilet_infos as t
join tenants as o 
    on t.tenant_id = o.tenant_id


-- when to update toilet infos?

-- select for each device the average ammonia level with a timestamp
select device_token, avg(ammonia_level) as avg_lvl
from ammonia_data
where
    TIMESTAMP BETWEEN make_timestamp(2024, 7, 20, 18, 0, 0) and make_timestamp(2024, 7, 20, 18, 30, 0)
group by device_token

-- #2 select for each device the average ammonia level with a timestamp
select device_token, avg(ammonia_level) as avg_lvl
from ammonia_data
where
    TIMESTAMP BETWEEN make_timestamp(2024, 7, 19, 18, 0, 0) and make_timestamp(2024, 7, 20, 18, 30, 0)
group by
    device_token

-- select toilet infos for specific toilet id
SELECT *
FROM toilet_infos
WHERE
    toilet_info_id = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984'

SELECT *
FROM toilet_infos
WHERE
    tenant_id = '59944171-3a4a-460d-5897-8bb38c524d54'

SELECT *
FROM toilet_infos
WHERE
    tenant_id = 'f8be7a6d-679c-4319-6906-d172ebf7c17e'


SELECT *
FROM device_pairs
WHERE
    toilet_info_id = 'f8be7a6d-679c-4319-6906-d172ebf7c17e'


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

-- rand like 740032bd-00a7-4d0b-4d66-3c7b7d0d1d6d
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

-- new device pair id

-- manually create pair
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

-- get average data per each devices
SELECT device_token, AVG(ammonia_level)
FROM public.ammonia_data
GROUP BY
    device_token

-- experiment sql
SELECT device_token, sum(
        CASE
            WHEN fragrance_on = TRUE THEN 1
            ELSE 0
        END
    )
FROM public.fragrance_data
GROUP BY
    device_token

SELECT * FROM fragrance_data

SELECT device_token, sum(id)
FROM fragrance_data
WHERE
    fragrance_on = FALSE
GROUP BY
    device_token

SELECT device_token, count(id)
FROM public.fragrance_data
GROUP BY
    device_token

SELECT * FROM panic_btn_data

SELECT device_token, count(
        CASE
            WHEN panic_button = TRUE THEN 1
            ELSE 0
        END
    )
FROM panic_btn_data
GROUP BY
    device_token

-- test query
SELECT * FROM public.devices ORDER BY device_token ASC

select * from toilet_infos

-- toilet female
select * from toilet_infos where toilet_info_id = '9eca5dcc-7946-4367-60a5-d7bd09b1e16a'

-- toilet male
select * from toilet_infos where toilet_info_id = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984'

select * from device_pairs

select *from devices

select dp.device_pair_id, dp.toilet_info_id, ti.toilet_name, d.device_name
from device_pairs as dp
join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
join devices as d on dp.device_id = d.device_id

-- devices list on that toilet mbk, zooteruntum, male
select dp.device_pair_id,
       dp.toilet_info_id,
       ti.toilet_name,
       d.device_name,
       d.device_token
from device_pairs as dp
join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
join devices as d on dp.device_id = d.device_id
where dp.toilet_info_id = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984'

-- devices list on that toilet mbk, zooteruntum, female
select dp.device_pair_id,
       dp.toilet_info_id,
       ti.toilet_name,
       d.device_name,
       d.device_token
from device_pairs as dp
join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
join devices as d on dp.device_id = d.device_id
where dp.toilet_info_id = '2a9fbea0-4dca-4af6-457b-348bf682cb54'


-- list devices on that toilet, mkb, taman bandar kuantan, male
select dp.device_pair_id,
       dp.toilet_info_id,
       ti.toilet_name,
       d.device_name
from device_pairs as dp
join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
join devices as d on dp.device_id = d.device_id
where dp.toilet_info_id = '5654c008-dbcc-4656-5601-0a0c50652213'

-- list devices on that toilet, mkb, taman bandar kuantan, female
select dp.device_pair_id,
       dp.toilet_info_id,
       ti.toilet_name,
       d.device_name
from device_pairs as dp
join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
join devices as d on dp.device_id = d.device_id
where dp.toilet_info_id = '9eca5dcc-7946-4367-60a5-d7bd09b1e16a'


-- pair yang salah
7ee4ed69-55d6-4e97-44a6-e7574727348a
08aa77ac-50a3-4c3b-4b6a-f31e7ba867da
37c32c5f-7706-4ef7-7c6f-2d1d04622db5
9c051cfa-0eb9-47b3-4b78-b40f007f64b8

68aba9d4-b09d-4e4b-6e6f-69222ca280f2
0d06d2d9-0cff-4e3c-46d6-c4bccd1fc4b8
1a264bf4-2a6d-4947-5390-caa4c37dc61c

-- delete pairing yang salah
delete from device_pairs where device_pair_id in ('7ee4ed69-55d6-4e97-44a6-e7574727348a','08aa77ac-50a3-4c3b-4b6a-f31e7ba867da', '37c32c5f-7706-4ef7-7c6f-2d1d04622db5', '9c051cfa-0eb9-47b3-4b78-b40f007f64b8')

delete from device_pairs where device_pair_id in ('68aba9d4-b09d-4e4b-6e6f-69222ca280f2','0d06d2d9-0cff-4e3c-46d6-c4bccd1fc4b8', '1a264bf4-2a6d-4947-5390-caa4c37dc61c')


-- gateway its location, and toilet name.
select p.device_pair_id,i.toilet_info_id, i.toilet_name, d.device_name, l.location_name
from device_pairs p
join toilet_infos i on i.toilet_info_id = p.toilet_info_id 
join locations l on i.location_id = l.location_id
join devices d on d.device_id = p.device_id
where i.tenant_id = 'f8be7a6d-679c-4319-6906-d172ebf7c17e' 
    and i.toilet_info_id='0a38e4d1-f9b9-4cb2-648f-20e0ac269984'
order by location_name, toilet_name, device_name

-- list all gateway
-- gateway tak di pair, device sahaja di pair ke gateway
select* 
from devices d
where device_type_id =1 and tenant_id='f8be7a6d-679c-4319-6906-d172ebf7c17e'

-- list toilet belong tp mbk
select * from toilet_infos
where tenant_id='f8be7a6d-679c-4319-6906-d172ebf7c17e'


select loc.location_name, loc.location_id,  ti.* 
from toilet_infos ti
join locations loc on loc.location_id = ti.location_id
where ti.tenant_id='f8be7a6d-679c-4319-6906-d172ebf7c17e'

select * from devices where device_type_id = 12

-- list all devices from all toilet belong to mbk, with its pair_id , check i gateway idss

select p.device_pair_id, p.gateway_id,i.toilet_info_id, i.toilet_name, d.device_name, l.location_name
from device_pairs p
join toilet_infos i on i.toilet_info_id = p.toilet_info_id 
join locations l on i.location_id = l.location_id
join devices d on d.device_id = p.device_id
where i.tenant_id = 'f8be7a6d-679c-4319-6906-d172ebf7c17e' 
order by p.gateway_id, location_name, toilet_name, device_name

-- device pair conflict
-- 8f2e5997-7ac3-4369-688b-671aae4459b5

select * from toilet_types

select * from locations
