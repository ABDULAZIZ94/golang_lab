-- Active: 1722832765629@@alpha.vectolabs.com@9998@smarttoilet-staging

COMMIT;
select * from tenants

-- kemaman 964cd0a5-8620-4a24-67af-578da8c3b6df 

select * from public.devices

select * from public.tenants

-- tenant putrajaya 59944171-3a4a-460d-5897-8bb38c524d54 
select * from public.toilet_infos where toilet_info_id in ('1e4a1133-d081-4479-702e-78b0684570cf', '7a48f840-db75-41f2-69a5-69339074f504','6de1c976-57c5-4cfb-4dd1-c65f1fb39029')

select * from public.locations

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
select dp.device_pair_id, dp.gateway_id, dp.toilet_info_id, ti.toilet_name, d.device_name, d.device_token, d.device_id
from
    device_pairs as dp
    join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
    join devices as d on dp.device_id = d.device_id
where
    d.tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'

-- list devices belong to kemaman toilet_male_01
select dp.device_pair_id, dp.gateway_id, dp.toilet_info_id, ti.toilet_name, d.device_name, d.device_token, d.device_id
from
    device_pairs as dp
    join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
    join devices as d on dp.device_id = d.device_id
where
    dp.toilet_info_id = '9388096c-784d-49c8-784c-1868b1233165'

-- check device with specific token
select * from public.devices where device_token  = '7'

select * from public.devices where device_token in ('30','32','33','70','608','4043','4044','4045','223','101',
'34','35','36','37','609','224','102','610')

SELECT * FROM public.devices where device_id = 'bff2b286-a044-4202-5881-ebe42125b2de'

-- list devices belong to kemaman toilet_female_01
select dp.gateway_id, dp.device_pair_id, dp.toilet_info_id, ti.toilet_name, d.device_name, d.device_token, d.device_id
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
select * from public.devices

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
select d.device_id, dp.device_pair_id, d.device_name, d.device_token, dp.toilet_info_id, d.tenant_id
from devices d
    left join device_pairs dp using (device_id)
-- where
--     d.tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'

delete from public.device_pairs where device_pair_id = '4faedfc3-f013-407a-55f8-b2296e94e258'

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

-- a5e938c2-744a-4755-6fd2-150a235e1050 
select * from public.devices

-- 9d733a91-e717-459c-5e99-74e50a007868 
select * from public.device_pairs 

-- update device token
SELECT * FROM public.devices 
where device_id in (
	'a4fa32a0-f2eb-4d2b-4bee-9f2b209cb1e5',
	'da6910ad-4f5c-471d-66bc-3843c03ca96a',
	'a5e938c2-744a-4755-6fd2-150a235e1050',
	'25a7d527-bbc6-4ef1-4adf-4c7ba9211e0c',
	'aed7b940-6686-4767-5398-2eb342f21544',
	'd4c4a614-dbbc-423e-7dee-472ca602d471',
	'89f0b6a5-07ae-45d6-47f9-c6563dcc4874',
	'd06ce291-d7de-46de-68c0-560e10f69dc2',
	'745447eb-05b3-4bfe-4a04-451343e4e655',
	'daea6ed6-bd21-48a1-4012-be978ed24009',
	'55009f31-2114-4bff-5946-4aaa378f791a',
	'26eab29f-372b-4796-5b2c-897119097f33',
	'bff2b286-a044-4202-5881-ebe42125b2de',
	'3c64d02c-abfb-4b57-5dfe-116d163ecee3'
)


select * from public.devices
where device_id in (
    '7ba03eae-1a91-4ae0-4a3c-e80ccff0c533',
    'd5d60be7-7b31-4bbd-6fc8-3ae10223b93f',
    'c815586b-5811-4ffa-632c-71589a1333fe',
    'bfacd822-e2ee-4a0b-4042-58f0ada3bb48',
    'f6e0e3eb-7b83-4024-63c8-9debd870fa1f',
    'e4ebb57f-7321-4d53-696f-bd30ffbe67be',
    '226d111c-5c5b-49b9-5eb8-20f26e4e8149',
    '99b5c48c-2ecd-4e69-52bf-e477f666625b',
    '55586213-c7af-4279-6aff-b8d02c1e173c'
)

-- to pair
eac80fc2-712b-407c-5de5-b332e04b42f5 
e82705af-4025-405f-7663-8fd8bd607131 
898459a6-8394-40e0-78da-cc196176049c 

-- oku
select * from public.devices
where device_id in (
    '0fd50558-be71-4870-568f-705c17d19cc7',
    '48a70814-62fb-4b59-7615-d29322ab6ff5',
    '56fb8123-1ec8-469b-6b3a-17f94e99efa6',
    '3d672712-57c3-431a-4840-01b1769c0354',
    '463ff62c-578c-4859-4c5c-78a992839dd1'
)

-- select devies for kemaman
SELECT *
FROM "devices"
WHERE (
        device_token = '23'
        and tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'
    )

-- list gateways
select d.device_name,d.device_token,  d.device_id
from devices d
where
    device_type_id = 1

-- gateway 2 // 93a7c9e9-8864-40e5-4197-0c06e4167d9d 

-- gateway 00 // 6be74626-459d-48db-4528-5c4c3f469a19 

-- gateway feedback panel

-- list gateway that not used for pairing
EXPLAIN SELECT * FROM
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


-- get tenant devtoken
select distinct device_token as gateway_token, devices.tenant_id from device_pairs 
join devices on devices.device_id = device_pairs.gateway_id
where toilet_info_id = '9388096c-784d-49c8-784c-1868b1233165'
limit 1

select * from devices

select * from toilet_infos

select * from cubical_pairs

select * from device_pairs

select * from toilet_infos

select devices.tenant_id,device_token from cubical_pairs 
join toilet_infos on toilet_infos.toilet_info_id = cubical_pairs.toilet_info_id
join device_pairs on device_pairs.toilet_info_id = toilet_infos.toilet_info_id
join devices on devices.device_id = device_pairs.gateway_id
where cubical_pairs.cubical_id = '2512c06f-bf57-45e1-7a7b-5e0935dbbe8d' limit 1


--
select devices.tenant_id, device_token as gateway_token
from
    cubical_pairs
    join toilet_infos on toilet_infos.toilet_info_id = cubical_pairs.toilet_info_id
    join device_pairs on device_pairs.toilet_info_id = toilet_infos.toilet_info_id
    join devices on devices.device_id = device_pairs.gateway_id
where
    cubical_pairs.cubical_id = '214a2dcf-7b6e-4e98-5f77-2103dcecf0e7'
limit 1



-- bulk update gateway pairing for toilet female, chnage gateway to gw2
update device_pairs set gateway_id = '0e94682a-9647-4e8a-7df4-ca20e0069405'
where device_pair_id in
(
'ae2d09ab-42c8-4683-580c-f1f19267060b',
'9d733a91-e717-459c-5e99-74e50a007868',
'f98b297e-3ded-42c0-6dbb-d778a0bca58d',
'25ad0fed-1b35-4fc6-70e7-eb22c4712a78',
'54d77890-b471-489d-5dab-f8b57a1f15ef',
'4234509e-0749-4e04-7342-87ed4cb42e7d',
'88c5fbc6-8bbc-473a-78f5-4a8a5d070a16',
'ef4a97a5-cabd-4214-797e-7b050140d818',
'7b53a36c-a016-4ddb-766c-177e0f9b7d9a',
'e14df1e4-98ef-467e-50ae-7e2adcf65bba',
'26f24b8b-c71c-4592-44ad-2cc077d511aa',
'99671583-84ec-492c-73e8-fd9000aa0470'
)


-- bulk update male to gateway 1
update device_pairs set gateway_id = ''
where device_pair_id in
(
cd8cb238-ba54-4fce-5e60-e0fc6019f2a6
4faedfc3-f013-407a-55f8-b2296e94e258
aba8f8d7-c000-48f3-5c24-7856ba12fc8b
64e9504e-f2ff-4ecc-6096-b841bc755fc2
3b8fd903-99f2-4703-6242-c1022bf96c1a
f203a40e-9383-4a38-5502-f55484a3e06a
7a70365c-5a04-4f48-4b07-1604399eb2b7
e24c9b97-e15c-402f-5d6a-bc3db54da4e8
0c756f5f-b23b-498a-614d-e24eea4000a9
35a5a7c1-141c-422d-4168-b216c16894af
f5b7e8f0-37eb-4b58-7b6c-917d44cc5431
c1297d5a-243a-4c4a-5839-e60d93718132
4cd91fb8-54ef-46e8-4472-4c1b9a3a42bc
d861a427-4aa2-46ce-5fa7-92961c81b61d
f5985585-11dd-4404-425a-43b23a0e60c6
)


-- bulk update oku to gw0


select * from devices

select * from toilet_infos

select * from device_pairs


select device_token
from devices d
left join device_pairs dp on dp.device_id = d.device_id
left join toilet_infos ti on ti.toilet_info_id = dp.toilet_info_id
where dp.toilet_info_id = 'a97891e5-14df-4f95-7d1e-4ee601581df2' and d.device_type_id = 11
limit 1