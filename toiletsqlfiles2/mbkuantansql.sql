-- Active: 1722832765629@@alpha.vectolabs.com@9998@smarttoilet-staging


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

-- devices list on that toilet mbk, zoo teruntum, male
select dp.*,
        dp.device_pair_id,
       dp.toilet_info_id,
       ti.toilet_name,
       d.device_name,
       d.device_token
from device_pairs as dp
join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
join devices as d on dp.device_id = d.device_id
where dp.toilet_info_id = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984'

 

-- devices list on that toilet mbk, zoo teruntum, female
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
       d.device_name,
       d.device_token,
       d.device_id
from device_pairs as dp
join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
join devices as d on dp.device_id = d.device_id
where dp.toilet_info_id = '5654c008-dbcc-4656-5601-0a0c50652213'

-- list devices on that toilet, mkb, taman bandar kuantan, female
select dp.device_pair_id,
       dp.toilet_info_id,
       ti.toilet_name,
       d.device_name,
       d.device_id,
       d.device_token
from device_pairs as dp
join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
join devices as d on dp.device_id = d.device_id
where dp.toilet_info_id = '9eca5dcc-7946-4367-60a5-d7bd09b1e16a'


-- correcting devices belongs to zoo teruntum male
update device_pairs
set
    toilet_info_id = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984'
where
    device_id in (
        select device_id
        from devices
        where
            device_token in (
                '1','45','47','66','26'
            )
    )

-- correcting device_pairs, zoo teruntum female
update device_pairs
set
    toilet_info_id = '2a9fbea0-4dca-4af6-457b-348bf682cb54'
where
    device_id in (
        select device_id
        from devices
        where
            device_token in ('1','46','27','65','48')
    )


-- correcting device pair taman bandar male
update device_pairs
set
    toilet_info_id = '5654c008-dbcc-4656-5601-0a0c50652213'
where
    device_id in (
        select device_id
        from devices
        where
            device_token in ('4','28','400','402','68')
    )

-- correcting device pair taman bandar female
update device_pairs
set
    toilet_info_id = '9eca5dcc-7946-4367-60a5-d7bd09b1e16a'
where
    device_id in (
        select device_id
        from devices
        where
            device_token in ('4', '29', '401', '403', '67')
    )

-- coorecting feedback panel
-- feedback panel from zoo teruntum male to female
update device_pairs
set
    toilet_info_id = '2a9fbea0-4dca-4af6-457b-348bf682cb54'
where
    device_pair_id = '7e69638d-b002-4718-67e2-2191052cea97'


-- feedback panel for male big
update device_pairs
set
    toilet_info_id = '5654c008-dbcc-4656-5601-0a0c50652213'
where
    device_pair_id = 'c5ffe817-d31a-48e7-7e2a-f7b2429f885d'




--delete occupancy pair
delete from device_pairs where device_pair_id in
(
'b6cf87c7-6d4b-44ed-79e2-bb137c9d8433',
'e6f82480-a68d-4663-5b61-01755b852984',
'6e77d9d9-ac7d-4a2a-7034-9892468281a6',
'4a1e11a6-9031-4872-5b2e-3afbcbe98d5f',
'8de16463-ee87-4c9d-7dcb-4daa3e054519',
'df6e6db5-ff3f-43c8-52c9-68ffa18b3d79',
'3a09c0d3-bd65-44f5-6b14-f7424910568b',
'ba0ae54b-7982-4154-5398-29eb401d371c'
) 

delete from device_pairs where device_pair_id in
(
'9a6ee98c-0c57-4978-512f-f1b34543b5f2',
'fbb431a6-1aa4-4b8b-6e9d-1872a237f861',
'79b67b4a-41da-412d-7bb8-7e174b872f12',
'df543bb6-81e2-476e-7a31-17ed9c17a705',
'7971da62-c9fc-451a-6bbd-a1da8b32a1a1',
'a0a8ac79-b408-4516-7132-43fe2d16f465',
'f7ec55da-f0e0-4dc9-7ca0-342cefc7c1f7')

delete from device_pairs
where
    device_token not in (
        '1', '45', '47', '66', '26'
    )
    and toilet_info_id = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984'

-- insert baru
INSERT INTO public.device_pairs (
    device_pair_id, gateway_id, device_id, toilet_info_id, created_at, updated_at, deleted_at
) VALUES
-- ('7e69638d-b002-4718-67e2-2191052cea97', 'a91b5fe2-dd09-4d67-4a71-5a0b033f23c4', 'ab2130e4-6ae2-4d14-79f1-1511c5b98cd6', '0a38e4d1-f9b9-4cb2-648f-20e0ac269984', '2023-03-07 08:09:06.219965+00', '2023-03-07 08:09:06.219965+00', NULL),
('d5746715-fda7-4118-500b-140258727511', 'a91b5fe2-dd09-4d67-4a71-5a0b033f23c4', '1ee4c311-e787-4207-66a5-b0e57169fa6c', '0a38e4d1-f9b9-4cb2-648f-20e0ac269984', '2023-03-07 18:42:07.358031+00', '2023-03-07 18:42:07.358031+00', NULL),
('d5d8db49-c5a4-4778-7efa-1d768cf9cf44', 'a91b5fe2-dd09-4d67-4a71-5a0b033f23c4', 'f87ad953-6a18-4129-4ea2-0b6fc726cb8f', '0a38e4d1-f9b9-4cb2-648f-20e0ac269984', '2023-03-09 06:08:09.13296+00', '2023-03-09 06:08:09.13296+00', NULL),
('db51a6c1-0f1c-4e7a-5422-2cf305e3412d', 'a91b5fe2-dd09-4d67-4a71-5a0b033f23c4', '16358a99-cca2-47be-67b7-16d805e146be', '0a38e4d1-f9b9-4cb2-648f-20e0ac269984', '2023-03-07 18:33:57.508274+00', '2023-03-07 18:33:57.508274+00', NULL),
('e6dedfed-d576-4529-7a6f-d8669e964e11', 'a91b5fe2-dd09-4d67-4a71-5a0b033f23c4', 'fe94c0dc-1c56-47dd-531d-b20938277915', '0a38e4d1-f9b9-4cb2-648f-20e0ac269984', '2023-03-07 18:33:57.505252+00', '2023-03-07 18:33:57.505252+00', NULL);

commit;
-- check duplicate
select * from device_pairs where device_pair_id in (
    '7e69638d-b002-4718-67e2-2191052cea97',
    'd5746715-fda7-4118-500b-140258727511',
    'd5d8db49-c5a4-4778-7efa-1d768cf9cf44',
    'db51a6c1-0f1c-4e7a-5422-2cf305e3412d',
    'e6dedfed-d576-4529-7a6f-d8669e964e11'
)

-- pair yang salah
7ee4ed69-55d6-4e97-44a6-e7574727348a
08aa77ac-50a3-4c3b-4b6a-f31e7ba867da
37c32c5f-7706-4ef7-7c6f-2d1d04622db5
9c051cfa-0eb9-47b3-4b78-b40f007f64b8

68aba9d4-b09d-4e4b-6e6f-69222ca280f2
0d06d2d9-0cff-4e3c-46d6-c4bccd1fc4b8
1a264bf4-2a6d-4947-5390-caa4c37dc61c

-- delete pairing yang salah
delete from device_pairs where device_pair_id in ('4a1e11a6-9031-4872-5b2e-3afbcbe98d5f','6e77d9d9-ac7d-4a2a-7034-9892468281a6', 'e6f82480-a68d-4663-5b61-01755b852984', 'b6cf87c7-6d4b-44ed-79e2-bb137c9d8433')

delete from device_pairs where device_pair_id in ('f7ec55da-f0e0-4dc9-7ca0-342cefc7c1f7', '79b67b4a-41da-412d-7bb8-7e174b872f12', '7971da62-c9fc-451a-6bbd-a1da8b32a1a1', '9a6ee98c-0c57-4978-512f-f1b34543b5f2')


-- gateway its location, and toilet name.
select p.device_pair_id,i.toilet_info_id, i.toilet_name, d.device_name, l.location_name, l.location_id
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

select p.device_pair_id, p.gateway_id,i.toilet_info_id, i.toilet_name, d.device_name, l.location_name, d.device_token
from device_pairs p
join toilet_infos i on i.toilet_info_id = p.toilet_info_id 
join locations l on i.location_id = l.location_id
join devices d on d.device_id = p.device_id
where i.tenant_id = 'f8be7a6d-679c-4319-6906-d172ebf7c17e' 
order by location_name, device_token, p.gateway_id, toilet_name, device_name


-- list all devices from all toilet belong to mbk, with its pair_id , check i gateway idss

select p.device_pair_id, p.gateway_id, i.toilet_info_id, i.toilet_name, d.device_name, l.location_name, d.device_token, d.device_type_id
from
    device_pairs p
    join toilet_infos i on i.toilet_info_id = p.toilet_info_id
    join locations l on i.location_id = l.location_id
    join devices d on d.device_id = p.device_id
where
    i.tenant_id = 'f8be7a6d-679c-4319-6906-d172ebf7c17e'
order by
    location_name,
    device_token,
    p.gateway_id,
    toilet_name,
    device_name

select distinct location_name, count(location_name) from
(select p.device_pair_id, p.gateway_id, i.toilet_info_id, i.toilet_name, d.device_name, l.location_name, d.device_token
from
    device_pairs p
    join toilet_infos i on i.toilet_info_id = p.toilet_info_id
    join locations l on i.location_id = l.location_id
    join devices d on d.device_id = p.device_id
where
    i.tenant_id = 'f8be7a6d-679c-4319-6906-d172ebf7c17e'
order by
    location_name,
    device_token,
    p.gateway_id,
    toilet_name,
    device_name) Q1
group by location_name

-- device pair conflict
-- 8f2e5997-7ac3-4369-688b-671aae4459b5

select * from toilet_types

select * from locations


-- list devices that not paired
 select d.device_token, d.device_name, d.device_type_id, dp.device_pair_id, d.device_id, ti.toilet_name, loc.location_name
 from devices d
 left join device_pairs dp on dp.device_id = d.device_id 
 left join toilet_infos ti on dp.toilet_info_id = ti.toilet_info_id
 left join locations loc on ti.location_id = loc.location_id


 select * from device_pairs

 select * from devices


 -- list gateway that not used for pairing
SELECT * FROM
-- list gateway
(select d.device_name, d.device_id from devices d
where device_type_id = 1)Q0
left join
-- paired gateway and total device paired and location name
(select DISTINCT dp.gateway_id as device_id, d.device_name, count(device_pair_id) as paired_device, loc.location_name
from device_pairs dp  
join devices d on d.device_id = dp.gateway_id
join toilet_infos ti on ti.toilet_info_id = dp.toilet_info_id
join locations loc on ti.location_id = loc.location_id
where d.device_type_id = 1
group by dp.gateway_id, d.device_name, loc.location_name) Q1 using(device_id)

--rename database
ALTER DATABASE smarttoilet RENAME TO smarttoilet2;


-- generate violation types tables

create table if not exists violation_types (
    id serial, 
    violation_types varchar(255), 
    violation_descriptions varchar(255),
    primary key(id)
)


select * from violation_types

insert into violation_types("violation_types","violation_descriptions")
values('Hop over the gate','a person broke the toilet rules by hop over the gate so the person can go to the toilet for free'),
('Under the gate','a person broke the toilet rules by under the gate so the person can go to the toilet for free')

select * from violation_types


create or replace function random_name()
returns text
language plpgsql
as
$$
declare 
    i1 int =  floor(random() * 14 + 1)::int;
    i2 int =  floor(random() * 8 + 1)::int;
    f_name text[] = ARRAY['ali', 'kasim', 'kadri', 'latif', 'halim', 'karim', 'malik', 'kuddus', 'salam', 'mukmin', 'aziz','jabar','kabir','ghafar'];
    l_name text[] = ARRAY['salim', 'kasyif', 'syukri', 'hamzah' ,'alif', 'bung','tamim', 'thalhah'];
    r_name text;
begin
    select f_name[i1] || ' bin ' || l_name[i2]
    into r_name;

    return r_name;
end;
$$;

select random_name()

select gen_random_uuid()

select uuid_generate_v4()


SELECT * FROM public.users
where user_name like 'aziz'
ORDER BY user_id ASC 

SELECT * FROM public.users

-- insert device types to device_types table
INSERT INTO DEVICE_TYPES("device_type_id", "device_type_name") 
VALUES (10, 'SMOKE_ALARM'), (11, 'PANIC_BUTTON'), (12, 'OCCUPANCY'), (13, 'AMMONIA_SENSOR'), (14, 'SECURITY_CAMERA')

--list devices
SELECT * FROM public.devices
ORDER BY device_token, device_id ASC 

-- list counter data desc
SELECT * FROM public.counter_data
ORDER BY timestamp DESC limit 100 


select distinct device_token
from
(select * from ammonia_data)Q1


update ammonia_data
set device_token = '95'
where device_token = '76'



select * from tenants


select * from ammonia_data where device_token = '95' and ammonia_level = 1

/* feedbackpanel 1-12 */
/* userreactins 1-4 */
/* complains 1-4 */
/* settings */


-- check duplicate device token
select Q1.device_token, count(Q1.device_token) as n_occurance
from
(select * from devices) Q1
group by Q1.

select * from devices


select * from devices where device_name LIKE '%FEED%'

select * from devices where device_name LIKE 'FEED'


-- where the panel deployed?
-- 1 feedback panel for 2 toilet

select d.device_id, d.device_name, d.created_at, l.location_name, ti.toilet_name, d.device_type_id
from devices d 
join device_pairs dp on dp.device_id = d.device_id
join toilet_infos ti on ti.toilet_info_id = dp.toilet_info_id
join locations l on l.location_id = ti.location_id 
where device_name LIKE '%FEED%'


-- alter table
ALTER TABLE ammonia_data
ALTER COLUMN created_at TYPE timestamp,
ALTER COLUMN updated_at TYPE timestamp,
ALTER COLUMN deleted_at TYPE timestamp;

/* \d+ ammonia_data */
select
    column_name,
    data_type,
    character_maximum_length,
    column_default,
    is_nullable
from INFORMATION_SCHEMA.COLUMNS
where
    table_name = 'ammonia_data';

select * from ammonia_data


ALTER TABLE ammonia_data ALTER COLUMN "timestamp" TYPE timestamp;


-- 931
WITH
    DEVICE_LIST AS (
        SELECT
            DEVICES.DEVICE_NAME,
            DEVICES.DEVICE_ID,
            DEVICES.DEVICE_TOKEN,
            TOILET_INFOS.TOILET_NAME AS IDENTIFIER,
            TOILET_INFOS.TOILET_INFO_ID AS IDENTIFIER_ID,
            DEVICE_TYPES.DEVICE_TYPE_NAME AS NAMESPACE,
            DEVICE_TYPES.DEVICE_TYPE_ID AS NAMESPACE_ID,
            TOILET_TYPES.TOILET_TYPE_ID
        FROM
            DEVICE_PAIRS
            JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID
            JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID = DEVICES.DEVICE_TYPE_ID
            JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID
            JOIN TOILET_TYPES ON TOILET_TYPES.TOILET_TYPE_ID = TOILET_INFOS.TOILET_TYPE_ID
        WHERE
            DEVICE_PAIRS.TOILET_INFO_ID = '5654c008-dbcc-4656-5601-0a0c50652213'
    )
SELECT
    LAST_UPDATE,
    LAST_CLEAN_TIMESTAMP,
    LAST_AUTOCLEAN_ACTIVE_TIMESTAMP,
    AVG_CLEANER_RESPONSE_TIME,
    COALESCE(TTLTRAFFIC, '0') AS TOTAL_COUNTER,
    COALESCE(TOTAL_COUNTER_LAST_CLEAN, '0') AS TOTAL_COUNTER_LAST_CLEAN,
    TOTAL_AUTOCLEAN_CNT,
    IAQ,
    TMP,
    LUX,
    BIN_FULL,
    BUSUK,
    URINAL_CLOG,
    SANITARY_BIN_FULL,
    PIPE_LEAK,
    PIPE_LEAK,
    SLIPPERY,
    OUT_TISSUE,
    REFRESH_TOILET,
    OUT_SOAP,
    CLOGGED_TOILET,
    COALESCE(AMMONIA_LEVEL, 0.0) AS AMMONIA_LEVEL,
    COALESCE(SMOKE_SENSOR, FALSE) AS SMOKE_SENSOR,
    COALESCE(PANICBTN_STATUS, FALSE) AS PANICBTN_STATUS,
    COALESCE(TOTAL_VIOLATION, 0) AS TOTAL_VIOLATION,
    COALESCE(PANICBTN_PUSHED, 0) AS PANICBTN_PUSHED
FROM (
        SELECT SUM(people_in) AS TTLTRAFFIC
        FROM COUNTER_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = COUNTER_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 2
            AND (TIMESTAMP) >= TO_TIMESTAMP(
                '2024-08-01 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q1
    CROSS JOIN (
        SELECT
            TIMESTAMP AS LAST_UPDATE,
            LUX,
            TEMPERATURE AS TMP,
            IAQ
        FROM
            ENVIROMENT_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = ENVIROMENT_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 3
        ORDER BY TIMESTAMP DESC
        LIMIT 1
    ) Q2
    CROSS JOIN (
        SELECT
            CHECK_OUT_TS as LAST_CLEAN_TIMESTAMP
        FROM CLEANER_REPORTS
        WHERE
            cleaner_reports.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFO_ID = '5654c008-dbcc-4656-5601-0a0c50652213'
            )
        order by CHECK_OUT_TS desc
        limit 1
    ) Q3
    CROSS JOIN (
        SELECT AVG(DURATION) AS AVG_CLEANER_RESPONSE_TIME
        FROM CLEANER_REPORTS
        WHERE
            cleaner_reports.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFO_ID = '5654c008-dbcc-4656-5601-0a0c50652213'
            )
    ) Q4
    CROSS JOIN (
        SELECT
            COUNT(
                CASE
                    WHEN BUTTON_ID = 1 THEN 1
                END
            ) AS REFRESH_TOILET,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 2 THEN 1
                END
            ) AS OUT_TISSUE,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 3 THEN 1
                END
            ) AS BIN_FULL,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 4 THEN 1
                END
            ) AS OUT_SOAP,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 5 THEN 1
                END
            ) AS BUSUK,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 6 THEN 1
                END
            ) AS CLOGGED_TOILET,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 7 THEN 1
                END
            ) AS URINAL_CLOG,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 8 THEN 1
                END
            ) AS SLIPPERY,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 9 THEN 1
                END
            ) AS SANITARY_BIN_FULL,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 10 THEN 1
                END
            ) AS PIPE_LEAK
        FROM FEEDBACK_PANEL_DATA
        WHERE (TIMESTAMP) >= TO_TIMESTAMP(
                '2024-07-31 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
            AND FEEDBACK_PANEL_DATA.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFOS.TOILET_INFO_ID = '5654c008-dbcc-4656-5601-0a0c50652213'
            )
            AND DEVICE_TOKEN = (
                SELECT DEVICE_TOKEN
                FROM DEVICE_LIST
                WHERE
                    DEVICE_LIST.NAMESPACE_ID = 7
            )
    ) Q5
    CROSS JOIN (
        SELECT COUNT(
                CASE
                    WHEN AUTO_CLEAN_STATE = '1' THEN 1
                END
            ) AS TOTAL_AUTOCLEAN_CNT
        FROM CLEANER_REPORTS
        WHERE
            CLEANER_REPORTS.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFO_ID = '5654c008-dbcc-4656-5601-0a0c50652213'
            )
            AND CLEANER_REPORTS.CREATED_AT >= TO_TIMESTAMP(
                '2024-08-01 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q6
    CROSS JOIN (
        SELECT SUM(PEOPLE_IN) AS TOTAL_COUNTER_LAST_CLEAN
        FROM COUNTER_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = COUNTER_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 2
            AND (TIMESTAMP) >= (
                SELECT CHECK_OUT_TS
                FROM CLEANER_REPORTS
                WHERE
                    CLEANER_REPORTS.TOILET_TYPE_ID = (
                        SELECT TOILET_TYPE_ID
                        FROM TOILET_INFOS
                        WHERE
                            TOILET_INFO_ID = '5654c008-dbcc-4656-5601-0a0c50652213'
                    )
                order by CHECK_OUT_TS desc
                limit 1
            )
    ) Q7
    CROSS JOIN (
        SELECT
            CHECK_OUT_TS as LAST_AUTOCLEAN_ACTIVE_TIMESTAMP
        FROM CLEANER_REPORTS
        WHERE
            cleaner_reports.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFO_ID = '5654c008-dbcc-4656-5601-0a0c50652213'
            )
            AND AUTO_CLEAN_STATE = '1'
        order by CHECK_OUT_TS desc
        limit 1
    ) Q8
    LEFT JOIN (
        SELECT avg(ammonia_level) as AMMONIA_LEVEL
        FROM ammonia_data
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = ammonia_data.DEVICE_TOKEN
        WHERE
            timestamp BETWEEN TO_TIMESTAMP(
                '2024-08-01 00:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) AND TO_TIMESTAMP(
                '2024-08-01 23:59:59',
                'YYYY-MM-DD HH24:MI:SS'
            )
        GROUP BY
            ammonia_data.device_token
    ) Q10 ON 1 = 1
    LEFT JOIN (
        SELECT SMOKE_SENSOR as SMOKE_SENSOR
        FROM SMOKE_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = SMOKE_DATA.DEVICE_TOKEN
        WHERE
            TIMESTAMP > TO_TIMESTAMP(
                '2024-08-01 00:00:01',
                'YYYY-MM-DD HH24:MI:SS'
            )
        ORDER BY TIMESTAMP DESC
        LIMIT 1
    ) Q11 ON 1 = 1
    LEFT JOIN (
        SELECT PANIC_BUTTON as PANICBTN_STATUS
        FROM PANIC_BTN_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = PANIC_BTN_DATA.DEVICE_TOKEN
        WHERE
            TIMESTAMP > TO_TIMESTAMP(
                '2024-08-01 00:00:01',
                'YYYY-MM-DD HH24:MI:SS'
            )
        ORDER BY TIMESTAMP DESC
        LIMIT 1
    ) Q12 ON 1 = 1
    LEFT JOIN (
        select count(id) as TOTAL_VIOLATION
        from violation_data
        where
            created_at BETWEEN to_timestamp(
                '2024-08-01 00:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and to_timestamp(
                '2024-08-01 23:59:59',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q13 ON 1 = 1
    LEFT JOIN (
        select count(
                CASE
                    WHEN panic_button = TRUE
                    AND prev_state = FALSE THEN 1
                END
            ) as PANICBTN_PUSHED
        from (
                SELECT panic_button, timestamp, LAG(panic_button, 1) OVER (
                        ORDER BY id
                    ) prev_state
                from panic_btn_data
            )
        where
            timestamp BETWEEN to_timestamp(
                '2024-08-01 00:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and to_timestamp(
                '2024-08-01 23:59:59',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q14 ON 1 = 1



-- invalid memory address
 SELECT * FROM "devices"  WHERE "devices"."deleted_at" IS NULL AND ((tenant_id = 'f8be7a6d-679c-4319-6906-d172ebf7c17e' AND device_type_id = '1'))  


-- list all device unpaired
select * from devices where tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'
and device_name like '%_FEMALE%'


select * from devices where tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'
and device_type_id =1

SELECT * FROM public.toilet_infos


-- correct kuantan pahang
-- temporaty set to kuantan zooteruntum male 0a38e4d1-f9b9-4cb2-648f-20e0ac269984
select d.device_id, d.device_name, d.device_token, dp.toilet_info_id
from devices d
    join device_pairs dp on d.device_id = dp.device_id
where
    d.tenant_id = 'f8be7a6d-679c-4319-6906-d172ebf7c17e'

update device_pairs
set
    toilet_info_id = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984'
where
    device_id in (
        select d.device_id
        from devices d
            join device_pairs dp on d.device_id = dp.device_id
        where
            d.tenant_id = 'f8be7a6d-679c-4319-6906-d172ebf7c17e'
    )