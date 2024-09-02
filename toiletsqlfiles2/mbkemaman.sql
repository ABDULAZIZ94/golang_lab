-- Active: 1722832765629@@alpha.vectolabs.com@9998@smarttoilet-staging

COMMIT;
select * from tenants

-- kemaman 964cd0a5-8620-4a24-67af-578da8c3b6df 
select * from locations

select * from devices ORDER BY device_token desc

select * from devices where device_type_id = 12

select * from devices where device_id = 'bd8f2ba1-53e9-475b-7b92-78f127da9efb'

select * from devices where tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'

select * from devices where tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd' and device_name like '%*%'

select *
from devices
where
    tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'
 


update devices set device_name = 'OCCUPANCY_MALE_M3' where device_token = '121'

update devices set tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd' where device_token in ('120','121','122','123','124','125')

 update devices
 set device_name = 'FEEDBACK_PANEL_FEMALE'
 where device_id ='f6e0e3eb-7b83-4024-63c8-9debd870fa1f'


select * from toilet_infos where location_id='964cd0a5-8620-4a24-67af-578da8c3b6df'

 -- list kemaman toilets
SELECT *
FROM public.toilet_infos
where
    tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'
ORDER BY toilet_info_id ASC

-- list devices belong to kemaman 
select dp.device_pair_id, dp.toilet_info_id, ti.toilet_name, d.device_name, d.device_token, d.device_id
from
    device_pairs as dp
    join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
    join devices as d on dp.device_id = d.device_id
where
    d.tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'

-- list devices belong to kemaman toilet_male_01
select dp.device_pair_id, dp.toilet_info_id, ti.toilet_name, d.device_name, d.device_token, d.device_id
from
    device_pairs as dp
    join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
    join devices as d on dp.device_id = d.device_id
where
    dp.toilet_info_id = '9388096c-784d-49c8-784c-1868b1233165'


-- list devices belong to kemaman toilet_female_01
select dp.device_pair_id, dp.toilet_info_id, ti.toilet_name, d.device_name, d.device_token, d.device_id
from
    device_pairs as dp
    join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
    join devices as d on dp.device_id = d.device_id
where
    dp.toilet_info_id = '36f74ec4-cdb0-4271-6c2d-2baa48d6e583'

-- list devices belongs to oku kemaman a97891e5-14df-4f95-7d1e-4ee601581df2 
select dp.device_pair_id, dp.toilet_info_id, ti.toilet_name, d.device_name, d.device_token, d.device_id
from
    device_pairs as dp
    join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
    join devices as d on dp.device_id = d.device_id
where
    dp.toilet_info_id = 'a97891e5-14df-4f95-7d1e-4ee601581df2'

-- list devices belongs to mbkemaman
select dp.device_pair_id, dp.toilet_info_id, ti.toilet_name, d.device_name, d.device_token, d.device_id
from
    device_pairs as dp
    join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
    join devices as d on dp.device_id = d.device_id
where
    d.tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'

-- check double paired
-- no double paired
select DISTINCT device_id, count(device_id) from
(select dp.device_pair_id, dp.toilet_info_id, ti.toilet_name, d.device_name, d.device_token, d.device_id
from
    device_pairs as dp
    join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
    join devices as d on dp.device_id = d.device_id
where
    d.tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd')Q1
group by device_id


--
select * from devices

select * from device_pairs

SELECT *
FROM "toilet_infos"
WHERE
    "toilet_infos"."deleted_at" IS NULL
    AND (
        (
            location_id = '9388096c-784d-49c8-784c-1868b1233165'
        )
    )

-- check devices pairs
select d.device_id, dp.device_pair_id, d.device_name, d.device_token, dp.toilet_info_id
from devices d
    left join device_pairs dp using (device_id)
where
    d.tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'
-- devices for male 9388096c-784d-49c8-784c-1868b1233165
-- 36f74ec4-cdb0-4271-6c2d-2baa48d6e583 change to 9388096c-784d-49c8-784c-1868b1233165
select d.device_id, dp.device_pair_id, d.device_name, d.device_token, dp.toilet_info_id
from devices d
    left join device_pairs dp using (device_id)
where
    d.tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'
    and d.device_name like '%\_MALE%'

update device_pairs
set
    toilet_info_id = '9388096c-784d-49c8-784c-1868b1233165'
from (
        select d.device_id, dp.device_pair_id, d.device_name, d.device_token, dp.toilet_info_id
        from devices d
            left join device_pairs dp using (device_id)
        where
            d.tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'
            and d.device_name like '%\_MALE%'
    ) Q1
--devices for female
-- 36f74ec4-cdb0-4271-6c2d-2baa48d6e583
update device_pairs
set
    toilet_info_id = '36f74ec4-cdb0-4271-6c2d-2baa48d6e583'
where
    device_pair_id in (
        select dp.device_pair_id
        from devices d
            left join device_pairs dp using (device_id)
        where
            d.tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'
            and d.device_name like '%_FEMALE%'
    )

select d.device_id, dp.device_pair_id, d.device_name, d.device_token, dp.toilet_info_id
from devices d
    left join device_pairs dp using (device_id)
where
    d.tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'
    and d.device_name like '%_FEMALE%'

SELECT * FROM ammonia_data where device_token = '113'
-- set toilet info id to missed paired toilet and device
-- set to 36f74ec4-cdb0-4271-6c2d-2baa48d6e583

UPDATE device_pairs
SET
    toilet_info_id = '36f74ec4-cdb0-4271-6c2d-2baa48d6e583'
from (
        select d.device_id, dp.device_pair_id, d.device_name, d.device_token, dp.toilet_info_id
        from devices d
            left join device_pairs dp using (device_id)
        where
            d.tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'
            and toilet_info_id = '9388096c-784d-49c8-784c-1868b1233165'
            and device_name like '%\_FEMALE%'
    ) Q1
-- kemaman 964cd0a5-8620-4a24-67af-578da8c3b6df
select * from locations

-- location kemaman terengganu
SELECT LOCATION_ID
FROM TOILET_INFOS
WHERE
    TOILET_INFO_ID = '9388096c-784d-49c8-784c-1868b1233165'


-- set feedback panel to female
update device_pairs
set toilet_info_id = '36f74ec4-cdb0-4271-6c2d-2baa48d6e583'
where device_pair_id = '9d733a91-e717-459c-5e99-74e50a007868'


-- pairing
-- SELECT device_token ,  device_type_id FROM "devices"  WHERE "devices"."deleted_at" IS NULL AND ((device_id = '55009f31-2114-4bff-5946-4aaa378f791a' AND tenant_id = 'f8be7a6d-679c-4319-6906-d172ebf7c17e'))  



SELECT DEVICES.DEVICE_NAME,DEVICES.DEVICE_ID,DEVICES.DEVICE_TOKEN, 
TOILET_INFOS.TOILET_NAME AS IDENTIFIER,TOILET_INFOS.TOILET_INFO_ID AS IDENTIFIER_ID, 
DEVICE_TYPES.DEVICE_TYPE_NAME AS NAMESPACE,DEVICE_TYPES.DEVICE_TYPE_ID AS NAMESPACE_ID,  
TOILET_TYPES.TOILET_TYPE_ID  
FROM DEVICE_PAIRS  
JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID  
JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID = DEVICES.DEVICE_TYPE_ID  
JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID  
JOIN TOILET_TYPES ON TOILET_TYPES.TOILET_TYPE_ID = TOILET_INFOS.TOILET_TYPE_ID 
WHERE DEVICES.TENANT_ID = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'
