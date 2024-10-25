-- Active: 1722832765629@@alpha.vectolabs.com@9998@smarttoilet-staging

-- ppj tenant id 59944171-3a4a-460d-5897-8bb38c524d54 

select * from public.devices

SELECT CLEANER_ID FROM CLEANER_AND_TENANTS WHERE TENANT_ID = (SELECT TENANT_ID FROM DEVICES WHERE DEVICE_TOKEN = '222')  

-- details
new location B13

location_id = 587339bc-5d2f-4f5b-4e85-53aab5f8cefc 

new toilet_id
---------------------------

toilet_male = 1e4a1133-d081-4479-702e-78b0684570cf 

toilet_female = 7a48f840-db75-41f2-69a5-69339074f504 

toilet_oku 6de1c976-57c5-4cfb-4dd1-c65f1fb39029 

gateways
------------

gateway id = d1438e09-c31b-418e-56ea-56acb1604881 

gateway_token = B13_GATEWAY_01

gateway id = 35e1a1ab-7186-4625-71dd-020e8a7120b8 

gateway_token = B13_GATEWAY_02

feedback_panels
------------------

device_id: f6e0e3eb-7b83-4024-63c8-9debd870fa1f 

device_name FEEDBACK_PANEL_B13_1

device_token:8

device_id: b63bba7c-fe60-46cf-730d-e6b84f7fbbf9 

device_name FEEDBACK_PANEL_B13_2

device_token:9


url yang saufi minta
-------------------

SELECT * FROM public.devices

SELECT * FROM public.devices where device_token = '103'

select location_name, toilet_name, device_name 
from device_pairs 
join devices on devices.device_id = device_pairs.device_id
join toilet_infos on toilet_infos.toilet_info_id = device_pairs.toilet_info_id
join locations on toilet_infos.location_id = locations.location_id
where devices.device_token = '300'



SELECT * FROM public.devices
LEFT JOIN DEVICE_PAIRS using(device_id)
LEFT JOIN TOILET_INFOS USING(toilet_info_id)
LEFT JOIN LOCATIONS USING (location_id)
where device_name like '%BLO%' LIMIT 100


select * from locations

 
{{localhost}}:7772/api/v1/telemetry/overview/advanced/ppj/{locationID}
 
{{localhost}}:7772/api/v1/telemetry/overview/ppj/{toiletId}
 
{{localhost}}:7772/api/v1/telemetry/ graph/analytic/ppj/{toiletTypeID}/{startDate}/{endDate}/{agg}


select * from device_pairs where device_id ='f7b6dfff-1303-466f-6d72-67444827671b'

-- occupancy details
SELECT *
FROM public.devices
where
    device_name like '%%'
order by REGEXP_REPLACE(
        device_token, '[^0-9]', '', 'g'
    )::int


SELECT *
FROM public.device_cubical_pairs
where
    device_id in (
        'c55a8c99-ae16-4d85-698f-8deb63444384',
        '19556ffe-8bba-429e-674a-b517b75891ca',
        'bfce706a-0c84-48f8-514c-c5a6b7983a06',
        '72f1d686-2dcc-4e2a-42f1-c270e8bbddf3'
    )
ORDER BY device_cubical_pair_id ASC

-- new location B13 
-- location_id = 587339bc-5d2f-4f5b-4e85-53aab5f8cefc 

-- gateway 1 B13_GATEWAY_01 d1438e09-c31b-418e-56ea-56acb1604881 
-- gateway 2 B13_GATEWAY_02  35e1a1ab-7186-4625-71dd-020e8a7120b8 
select * from device_pairs 
join toilet_infos on toilet_infos.toilet_info_id = device_pairs.toilet_info_id
where toilet_infos.location_id = '587339bc-5d2f-4f5b-4e85-53aab5f8cefc'

select * from public.devices 
-- where device_type_id = 7
order by REGEXP_REPLACE(device_token, '[^0-9]', '', 'g')::int

select * from device_pairs where device_id = 'f6e0e3eb-7b83-4024-63c8-9debd870fa1f'

select * from public.device_pairs where gateway_id = 'd1438e09-c31b-418e-56ea-56acb1604881' --bind to gateway 1

select * from public.device_pairs where gateway_id = '35e1a1ab-7186-4625-71dd-020e8a7120b8'  -- bind to gateway 2





-- device_id 8 feedback panel f6e0e3eb-7b83-4024-63c8-9debd870fa1f 

select * from device_pairs

select * from device_pairs where device_id = 'f6e0e3eb-7b83-4024-63c8-9debd870fa1f'


select * from public.device_pairs where gateway_id = 'f6e0e3eb-7b83-4024-63c8-9debd870fa1f'


-- feedback panel 2 device_token 9 device id b63bba7c-fe60-46cf-730d-e6b84f7fbbf9 
{"error":false,"message":"Device paring success . ID: b63bba7c-fe60-46cf-730d-e6b84f7fbbf9, 35e1a1ab-7186-4625-71dd-020e8a7120b8"}
{"error":false,"message":"Device paring success . ID: f6e0e3eb-7b83-4024-63c8-9debd870fa1f, d1438e09-c31b-418e-56ea-56acb1604881"}


-- b13 ip

select * from public.devices where device_id ='72f1d686-2dcc-4e2a-42f1-c270e8bbddf3'

select * from public.locations

b13 - 192.168.1.64 (1) b13- 192.168.1. 225 (2) 

63f35b10-dc90-4802-6091-49f8474e3e09  --blower male
f1eccef2-0941-4e9e-5cca-8ac9f484c61d  --env male

ef7c85ff-8d6e-4226-5a6f-2ff6d0257bce  -- blower female
c7d18e5f-a504-40be-55f3-29cd34644045  --env female

cubical_pair_id f1af1225-4a8a-4c38-7250-a29246955860  , letak cubical_id dia 87358af4-3917-40dc-582e-42dc05296dba 

select * from public.device_cubical_pairs

-- manage b13 cubical
SELECT
    cubical_nick_name,
    cubical_name,
    cubical_id,
    device_name,
    device_id,
    device_token,
    device_type_id,
    toilet_name,
    device_cubical_pair_id
FROM
    cubical_infos
    left join cubical_pairs using (cubical_id)
    left join device_cubical_pairs using (cubical_id)
    left join toilet_infos using (toilet_info_id)
    left join devices using (device_id)
where
    toilet_infos.location_id = '587339bc-5d2f-4f5b-4e85-53aab5f8cefc'



{"error":false,"message":"Device created . ID: 7fbb2af4-c911-4fc7-6a22-8e651d316a65"} --occ m1

{"error":false,"message":"Device created . ID: 1114deeb-b2df-4c50-5ca3-92088532320a"} -- occ m2

{"error":false,"message":"Device created . ID: e2f719cb-bb74-4dca-776a-14f1077d062e"} --occ m3

{"error":false,"message":"Device created . ID: 81d738d5-c81d-411a-53cc-224d723a59b9"} -- occ m4

{"error":false,"message":"Device created . ID: 2cc2ec77-860b-4971-51fc-23d245652287"} -- occ f1

{"error":false,"message":"Device created . ID: ea27ea67-7147-4de3-462c-9f52cadf97a4"} -- occ f2

{"error":false,"message":"Device created . ID: 4686506e-6e98-42eb-4f54-99bb184313c3"} -- occ f3

{"error":false,"message":"Device created . ID: 3980aab1-1a39-4ac0-4049-83efb130a22f"} -- occ f4

{"error":false,"message":"Device created . ID: 2128e434-5fbc-4cda-4759-95eba64bd61b"} -- ammonia


{"error":false,"message":"Device created . ID: 5fb623c4-8c16-467c-4cda-ef43e2013624"} -- freshener male

{"error":false,"message":"Device created . ID: ab4bd26b-b455-445a-7027-bbf36584ec57"} -- freshener female


select * from public.devices


env male
{"error":false,"message":"Device created . ID: ef7c85ff-8d6e-4226-5a6f-2ff6d0257bce"}


b13 toilet_id
---------------------------
toilet_male = 1e4a1133-d081-4479-702e-78b0684570cf
toilet_female = 7a48f840-db75-41f2-69a5-69339074f504

select * from public.toilet_infos where toilet_info_id = '6de1c976-57c5-4cfb-4dd1-c65f1fb39029'

--m1 
{"error":false,"message":"Cubical info created ID: af3cf2b6-bf8f-49d8-5546-3f97b2ff16c5"}
-- m2 
{"error":false,"message":"Cubical info created ID: a8acedbc-6209-4fcb-5bfd-5f68082ed81d"}
-- m3
{"error":false,"message":"Cubical info created ID: 602b555d-ed3f-4a39-4f7c-4acc2a46d29d"}
-- m4
{"error":false,"message":"Cubical info created ID: aac094fe-cc74-44b8-787a-862172e38c23"}


-- male pair
{"error":false,"message":"Cubical paring success . ID: af3cf2b6-bf8f-49d8-5546-3f97b2ff16c5, a8acedbc-6209-4fcb-5bfd-5f68082ed81d, 602b555d-ed3f-4a39-4f7c-4acc2a46d29d, aac094fe-cc74-44b8-787a-862172e38c23, 1e4a1133-d081-4479-702e-78b0684570cf"}


-- f1
{"error":false,"message":"Cubical info created ID: 3800a87c-4449-4829-67fc-643bf3be715d"}

--f2 
{"error":false,"message":"Cubical info created ID: 43ed76a7-03d7-481d-75d7-e6ecd7b4b139"}

-- f3
{"error":false,"message":"Cubical info created ID: 428cbd93-d02d-45eb-6d83-60834a900a72"}

-- f4
{"error":false,"message":"Cubical info created ID: 87358af4-3917-40dc-582e-42dc05296dba"}


-- pair female
{"error":false,"message":"Cubical paring success . ID: 3800a87c-4449-4829-67fc-643bf3be715d, 43ed76a7-03d7-481d-75d7-e6ecd7b4b139, 428cbd93-d02d-45eb-6d83-60834a900a72, 87358af4-3917-40dc-582e-42dc05296dba, 7a48f840-db75-41f2-69a5-69339074f504"}


-- list user ppj
select user_name, email, users.tenant_id, tenant_name
from public.users
join public.tenants on tenants.tenant_id = users.tenant_id
where tenants.tenant_id = '59944171-3a4a-460d-5897-8bb38c524d54'

select * from public.users

select * from public.devices

select * from toilet_infos limit 1

select * from locations

select * from public.device_pairs

select * from tenants

-- all b13 devices
----------------------------------------------------------
-- gateway male d1438e09-c31b-418e-56ea-56acb1604881 
-- gateway female 35e1a1ab-7186-4625-71dd-020e8a7120b8 

-- env male f1eccef2-0941-4e9e-5cca-8ac9f484c61d
--env female c7d18e5f-a504-40be-55f3-29cd34644045

-- toilet male 1e4a1133-d081-4479-702e-78b0684570cf 
-- toilet female 7a48f840-db75-41f2-69a5-69339074f504 

select * from locations

select 0 as total_count_today

-- check paired
select * from public.devices 
-- join device_pairs on device_pairs.device_id = devices.device_id
where device_token in ('226', '227')

-- b13 env
{"error":false,"message":"Device created . ID: f1eccef2-0941-4e9e-5cca-8ac9f484c61d"} --male
{"error":false,"message":"Device created . ID: c7d18e5f-a504-40be-55f3-29cd34644045"} --female
{"error":false,"message":"Device created . ID: 251a4e83-8955-47fc-529a-28329d8a3b41"} --oku

-- laman perdana
{"error":false,"message":"Location created . ID: 9945f766-738f-4de4-5b51-ac878029af56"}

-- laman perdana

{"error":false,"message":"Device created . ID: f834362d-9302-44b3-4698-6b506d0b9d5c"} -- male
{"error":false,"message":"Device created . ID: d509b6fb-ef7a-4010-47cd-26e444074af6"} -- female
{"error":false,"message":"Device created . ID: d509b6fb-ef7a-4010-47cd-26e444074af6"} -- oku


-- toilet male
{"error":false,"message":"Toilet info created ID: b26430b7-eb8a-473d-424a-1f47799d421d"}

-- toilet female
{"error":false,"message":"Toilet info created ID: 30935d4a-bcea-48e0-73c6-346f6c8dad6b"}

-- toilet oku
 {"error":false,"message":"Toilet info created ID: 68e9a02d-a33f-4f58-728c-6953f874f597"}




-- pair
-- male counter
{"error":false,"message":"Device paring success . ID: 11ee53f7-0983-41c6-55c1-24cdb5b46b9e, b63bba7c-fe60-46cf-730d-e6b84f7fbbf9"}
-- female counter
{"error":false,"message":"Device paring success . ID: d37e9802-2363-4076-5404-d3768ef22e51, b63bba7c-fe60-46cf-730d-e6b84f7fbbf9"}
--- oku counter
{"error":false,"message":"Device paring success . ID: 253cc90f-d484-42be-6332-5a867ff8546c, b63bba7c-fe60-46cf-730d-e6b84f7fbbf9"}


-- all b13 toilet

select * from toilet_infos 
where location_id = '587339bc-5d2f-4f5b-4e85-53aab5f8cefc'

-- all devices on b13
select
    device_pair_id,
    gateway_id,
    device_id,
    device_token,
    device_name,
    location_name,
    toilet_name,
    toilet_info_id
from
    locations
    left join toilet_infos using (location_id)
    left join device_pairs using (toilet_info_id)
    left join devices using (device_id)
where
    location_id = '587339bc-5d2f-4f5b-4e85-53aab5f8cefc'

-- data x masuk db
select * from enviroment_data where device_token in ('226','227')


SELECT CLEANER_ID FROM CLEANER_AND_TENANTS WHERE TENANT_ID = (SELECT TENANT_ID FROM DEVICES WHERE DEVICE_TOKEN = '226') 


select * from enviroment_data
where timestamp > current_timestamp - interval '1 HOUR'
order by timestamp desc

-- all saujana hijau toilet 
-- saujana hijau location id 98998a6b-4be1-4ff4-5dd1-8a8e914943ee 

-- manage saujana hijau cubical
SELECT cubical_nick_name, cubical_name, cubical_id, device_name, device_id, device_token, device_type_id, toilet_name, device_cubical_pair_id
FROM cubical_infos
left join cubical_pairs using(cubical_id)
left join device_cubical_pairs using(cubical_id)
left join toilet_infos using(toilet_info_id)
left join devices using(device_id)
where toilet_infos.location_id = '98998a6b-4be1-4ff4-5dd1-8a8e914943ee'

select * from public.device_cubical_pairs

ded9f0f3-395d-47da-76a3-ed28637a3472 
-- check specific toilet
select *
from toilet_infos
left join locations using(location_id)
where toilet_infos.toilet_info_id = 'f6cb76e9-1cb0-4c6d-5db2-536e7d0fa4ea'

-- check specific cubicle
select * 
from cubical_pairs
join cubical_infos on cubical_infos.cubical_id = cubical_pairs.cubical_id
join toilet_infos on toilet_infos.toilet_info_id = cubical_pairs.toilet_info_id
where cubical_pairs.cubical_id ='2007bdc4-dba7-4638-5a5e-fd41deb46842'

{"error":false,"message":"Device created . ID: a54306dc-ed36-4be8-50b5-ff02c319b461"} --15
{"error":false,"message":"Device created . ID: 2051d7e5-1ecd-48bf-43a4-9e506c54dcc1"} --16


select * from public.devices

select * from public.devices where device_id = 'a54306dc-ed36-4be8-50b5-ff02c319b461' 

select * from public.devices where device_token = ''

-- list devices for saujana hijau
select device_pair_id, gateway_id, device_id, device_token,device_name, location_name, toilet_name, toilet_info_id 
from locations
left join toilet_infos using(location_id)
left join device_pairs using(toilet_info_id)
left join devices using(device_id)
where location_id = '98998a6b-4be1-4ff4-5dd1-8a8e914943ee'

select * from public.toilet_infos where toilet_info_id in ('23acd373-4a29-427d-40b7-94d348e4f423','f6cb76e9-1cb0-4c6d-5db2-536e7d0fa4ea')

-- device cubile pair
{"error":false,"message":"Device Cubical paring success . ID: af3cf2b6-bf8f-49d8-5546-3f97b2ff16c5 with c55a8c99-ae16-4d85-698f-8deb63444384"} -- m1
{"error":false,"message":"Device Cubical paring success . ID: a8acedbc-6209-4fcb-5bfd-5f68082ed81d with 19556ffe-8bba-429e-674a-b517b75891ca"} -- m2
{"error":false,"message":"Device Cubical paring success . ID: 602b555d-ed3f-4a39-4f7c-4acc2a46d29d with bfce706a-0c84-48f8-514c-c5a6b7983a06"} -- m3
{"error":false,"message":"Device Cubical paring success . ID: 602b555d-ed3f-4a39-4f7c-4acc2a46d29d with bfce706a-0c84-48f8-514c-c5a6b7983a06"} -- m4


select *
from public.toilet_infos
where
    location_id = '98998a6b-4be1-4ff4-5dd1-8a8e914943ee'

-- female 23acd373-4a29-427d-40b7-94d348e4f423 
--- male f6cb76e9-1cb0-4c6d-5db2-536e7d0fa4ea 

-- female big
{"error":false,"message":"Cubical info created ID: 25a25532-a743-4857-70f5-5e9dcb3b06ee"}

--female small
{"error":false,"message":"Cubical info created ID: 637f3112-8af8-48ec-7524-07720a810117"}

-- male small
{"error":false,"message":"Cubical info created ID: 2007bdc4-dba7-4638-5a5e-fd41deb46842"}

-- male big
{"error":false,"message":"Cubical info created ID: 4fcb51b0-cf20-4bd3-780c-3f52028c3e58"}


-- del e3b73d18-9fc2-405f-5685-bb21bb73e6c4 , 1a30dea0-03c9-41d6-5918-b15807c3661f 

select * from device_pairs
----------------------------------------------------------------------------------------------------------------------------
-- laman perdana  9945f766-738f-4de4-5b51-ac878029af56
select * from public.locations

-- list toilet for laman perdana
-- b26430b7-eb8a-473d-424a-1f47799d421d male
-- 30935d4a-bcea-48e0-73c6-346f6c8dad6b female

-- paired gateway_01 male_toilet
select * from public.device_pairs 
left join devices using (device_id)
where gateway_id = '93f04ea4-de81-4c9d-716f-8bc95e3ebb7b'

-- paired gateway_02 female_toilet
select * from public.device_pairs 
left join devices using(device_id)
where gateway_id = '0d517343-5eb7-4d56-7c0b-9cdf17920168'


-- occupancy devices
{"error":false,"message":"Device created . ID: 91e4b4fd-cbdf-4d2e-4261-8a54b2e720bf"} -- occ m1
{"error":false,"message":"Device created . ID: c5d6285c-6851-4904-5c6c-f6d4185b1950"} -- occ m2
{"error":false,"message":"Device created . ID: 104d82f4-738b-4660-7f92-31a7e6ed50a0"} -- occ m3
-- {"error":false,"message":"Device created . ID: 8190ebaf-5b9c-4e4c-65ce-7aeb682f7c28"} -- occ m4
{"error":false,"message":"Device created . ID: 42d6e1a1-8f03-4f3c-61f6-bedd64f63328"} -- m4


{"error":false,"message":"Device created . ID: 5bf5bc9c-769b-46ec-6146-b1f8db451b1c"} -- occ f1
{"error":false,"message":"Device created . ID: e4dec6d6-7b54-4782-4f25-d586af34d702"} -- occ f2
{"error":false,"message":"Device created . ID: b4efc5d4-6f6a-4091-5496-1f266da0bef0"} -- occ f3
{"error":false,"message":"Device created . ID: d11378df-b8b4-4110-5f43-09338422bc27"} -- occ f4
{"error":false,"message":"Device created . ID: 2cec46eb-5200-46dc-50db-17fc2d3cd917"} -- occ f5
{"error":false,"message":"Device created . ID: 9aa53d78-6fce-46ea-40c2-871efc4ee886"} -- occ f6


-- cubical ids
{"error":false,"message":"Cubical info created ID: 260a79c2-0e3b-4666-66ae-da91a16e8974"} -- m1
{"error":false,"message":"Cubical info created ID: d305cd18-af2b-4a4d-5f34-1b19a59bc2ae"} -- m2
{"error":false,"message":"Cubical info created ID: a3b74d22-b7bf-4210-6dde-8fd7f31ab19b"} -- m3
{"error":false,"message":"Cubical info created ID: 586b94c9-5ca4-46fa-7628-1c01cb4f2460"} -- m4 

{"error":false,"message":"Cubical info created ID: c4e8c4a2-9c4d-4c12-7231-f5226665407e"} -- f1
{"error":false,"message":"Cubical info created ID: 115ae3bc-01e6-4027-6c90-17fcb5b08f4d"} -- f2
{"error":false,"message":"Cubical info created ID: 2d5593a7-15f3-45a5-6535-2d1e8cbc4d5b"} -- f3
{"error":false,"message":"Cubical info created ID: 6c00b3f5-cc3c-418e-66c7-7f753f3c4274"} -- f4
{"error":false,"message":"Cubical info created ID: b207568e-df9c-4acb-6e9f-c581c44210fc"} -- f5
{"error":false,"message":"Cubical info created ID: 1543e26a-6f99-4076-69ed-81bfed019c57"} -- f6 


-- manage occupancy sensor
select * from public.devices
where device_id in ('91e4b4fd-cbdf-4d2e-4261-8a54b2e720bf',
'c5d6285c-6851-4904-5c6c-f6d4185b1950',
'104d82f4-738b-4660-7f92-31a7e6ed50a0',
'42d6e1a1-8f03-4f3c-61f6-bedd64f63328',
'5bf5bc9c-769b-46ec-6146-b1f8db451b1c',
'e4dec6d6-7b54-4782-4f25-d586af34d702',
'b4efc5d4-6f6a-4091-5496-1f266da0bef0',
'd11378df-b8b4-4110-5f43-09338422bc27',
'2cec46eb-5200-46dc-50db-17fc2d3cd917',
'9aa53d78-6fce-46ea-40c2-871efc4ee886',
'11ee53f7-0983-41c6-55c1-24cdb5b46b9e', --counter
'f834362d-9302-44b3-4698-6b506d0b9d5c', -- env
'9a8b80ac-675c-47b2-5719-a9a81e0ea67a', --fp
'd37e9802-2363-4076-5404-d3768ef22e51', --counter
'd509b6fb-ef7a-4010-47cd-26e444074af6', --env
'a0e4bc77-0132-4c06-4a01-eef64e36690c' --fp
)

-- {"error":false,"message":"Device created . ID: 8190ebaf-5b9c-4e4c-65ce-7aeb682f7c28"} -- occ m4

select * from device_pairs where device_id = '42d6e1a1-8f03-4f3c-61f6-bedd64f63328'


{"error":false,"message":"Device created . ID: 5bf5bc9c-769b-46ec-6146-b1f8db451b1c"} -- occ f1
{"error":false,"message":"Device created . ID: e4dec6d6-7b54-4782-4f25-d586af34d702"} -- occ f2
{"error":false,"message":"Device created . ID: b4efc5d4-6f6a-4091-5496-1f266da0bef0"} -- occ f3
{"error":false,"message":"Device created . ID: d11378df-b8b4-4110-5f43-09338422bc27"} -- occ f4
{"error":false,"message":"Device created . ID: 2cec46eb-5200-46dc-50db-17fc2d3cd917"} -- occ f5


select * from devices where device_id in (
    '91e4b4fd-cbdf-4d2e-4261-8a54b2e720bf'
)

select * from device_cubical_pairs
left join cubical_infos using (cubical_id)

select * from cubical_infos

select * from cubical_infos
right join cubical_pairs using(cubical_id)

-- delete from cubical_pairs where cubical_pair_id in(
--     'd0ac307f-f034-46da-787f-eb16df47295c',
--     '5c6ccdb7-37ec-46e3-64e6-a63e9694493e',
--     'e6a08b01-ca4f-49d7-7202-e885a9fae1af',
--     'bb7de31b-6d4e-4d5c-5078-7a4b4317691b',
--     '929a328b-0d79-4f8f-41ce-89c24269d7fc',
--     'ab652cc6-b72c-4442-646e-e43ebcb82d17',
--     'c2601b15-68e0-4e00-501e-686014e43881',
--     '8ae0e527-4161-4e04-767d-31f75165be68'
-- )

select *
from public.toilet_infos
where
    location_id = '9945f766-738f-4de4-5b51-ac878029af56'

-- list devices in laman perdana
select * from device_pairs
left join devices using (device_id)
left join toilet_infos using (toilet_info_id)
where location_id ='9945f766-738f-4de4-5b51-ac878029af56'


select * from devices where device_id ='93f04ea4-de81-4c9d-716f-8bc95e3ebb7b'

-- devices pair
-- feedback panel token = 9 , id = b63bba7c-fe60-46cf-730d-e6b84f7fbbf9 
{"error":false,"message":"Device created . ID: 93f04ea4-de81-4c9d-716f-8bc95e3ebb7b"} -- laman perdana gateway 01
{"error":false,"message":"Device created . ID: 0d517343-5eb7-4d56-7c0b-9cdf17920168"} -- laman perdana gateway 02

select * from devices where device_id in (
    '93f04ea4-de81-4c9d-716f-8bc95e3ebb7b',
    '0d517343-5eb7-4d56-7c0b-9cdf17920168'
)

-- new feedback panel
{"error":false,"message":"Device created . ID: 9a8b80ac-675c-47b2-5719-a9a81e0ea67a"} -- 01
{"error":false,"message":"Device created . ID: a0e4bc77-0132-4c06-4a01-eef64e36690c"} -- 02

select * from public.devices where device_id = 'b63bba7c-fe60-46cf-730d-e6b84f7fbbf9' -- device token 9

select * from device_pairs where device_id = 'b63bba7c-fe60-46cf-730d-e6b84f7fbbf9'

select * from public.device_pairs where device_pair_id in (
    '5f3814ab-61a4-4985-5c84-f4061c58cf2e',
    'fc597f17-c5cf-442c-4d35-6a67ac2ca879',
    'f132ad36-4324-40f3-4d43-3c9dc8c281f3'
)

select *
from
    device_pairs
    join devices on devices.device_id = device_pairs.device_id
    join toilet_infos on toilet_infos.toilet_info_id = device_pairs.toilet_info_id
where
    toilet_infos.location_id = '9945f766-738f-4de4-5b51-ac878029af56'

-- exhaust fan
{"error":false,"message":"Device created . ID: fde75e65-af87-4176-7a16-1db6a8cfd4bf"} -- 4050
{"error":false,"message":"Device created . ID: 3e7de029-f6f5-4938-5f5f-882c076687f3"} -- 4051

-- blower
{"error":false,"message":"Device created . ID: 25075ab8-3018-4186-4ee9-5807fe6f0aa4"} -- male 4048
{"error":false,"message":"Device created . ID: 09f26806-0520-4367-632b-7ed8b5d870be"} -- male 4049


3e7de029-f6f5-4938-5f5f-882c076687f3 -- 4051 exhaust fan
fde75e65-af87-4176-7a16-1db6a8cfd4bf -- 4050 exhaust fan
09f26806-0520-4367-632b-7ed8b5d870be -- 4049 blower female
25075ab8-3018-4186-4ee9-5807fe6f0aa4 -- 4048 blower male
EXHAUST_FAN_MALE

select * from public.device_pairs where device_id in('3e7de029-f6f5-4938-5f5f-882c076687f3', 'fde75e65-af87-4176-7a16-1db6a8cfd4bf')

-- freshener
{"error":false,"message":"Device created . ID: e61b0e4b-3896-4a46-496e-ad424320b162"} --613
{"error":false,"message":"Device created . ID: 9832b9c0-75e3-46c1-7ba2-d1a2fcf0648a"} --614


-- ammonia sensors
{"error":false,"message":"Device created . ID: 033d9091-cf9f-4d03-61bd-ec7e2a844411"} --72


-- cubical pairs
{"error":false,"message":"Cubical info created ID: 1bc095d3-5ebf-4c47-6f95-041901a03b46"} -- m1
{"error":false,"message":"Cubical info created ID: edd6a42a-7c17-4da7-45bd-0467c50ed73f"} -- m2
{"error":false,"message":"Cubical info created ID: 6d015246-13a1-4cf7-4219-70fc824f3dfe"} -- m3

{"error":false,"message":"Cubical info created ID: acf993f9-6ea5-4274-429e-114d0905f130"} -- f1
{"error":false,"message":"Cubical info created ID: c909bf67-7530-4d2b-7c23-f982c3d78a97"} -- f2
{"error":false,"message":"Cubical info created ID: f856559d-3a07-48cf-5311-505e6b3b2dc4"} -- f3
{"error":false,"message":"Cubical info created ID: b839ad7c-348f-4cb3-5d41-3f1738d7a76a"} -- f4
{"error":false,"message":"Cubical info created ID: 40af79d3-a44e-4677-4b10-607d389f65f5"} -- f5



select* from public.device_pairs where device_id = '9832b9c0-75e3-46c1-7ba2-d1a2fcf0648a'

select *
from cubical_pairs
    join toilet_infos on toilet_infos.toilet_info_id = cubical_pairs.toilet_info_id

-- new device
{"error":false,"message":"Device created . ID: 07e4b54a-06d5-43c5-5df9-adc7df6e863b"}


{"error":false,"message":"Device created . ID: 07e4b54a-06d5-43c5-5df9-adc7df6e863b"} -- oku counter 109

{"error":false,"message":"Device created . ID: 11ee53f7-0983-41c6-55c1-24cdb5b46b9e"} -- male 106


{"error":false,"message":"Device created . ID: d37e9802-2363-4076-5404-d3768ef22e51"}
 -- female 107


{"error":false,"message":"Device created . ID: 253cc90f-d484-42be-6332-5a867ff8546c"} -- oku 108

-- feedback panel aka gateway
{"error":false,"message":"Device created . ID: b63bba7c-fe60-46cf-730d-e6b84f7fbbf9"}


-- feedbak panel male setting
{
    "Port6LP":"/dev/ttyAMA4",
    "BaudRate6LP": 115200,
    "PortFP":"/dev/ttyAMA1",
    "BaudRateFP": 115200,
    "PortRFID":"/dev/ttyAMA3",
    "BaudRateRFID":9600,
    "DeviceToken": "LAMAN_PERDANA_GATEWAY_01",
    "HostURL": "https://api-toilet-staging.vectolabs.com:7772",
    "Location": "9945f766-738f-4de4-5b51-ac878029af56",
    "FeedbackPanelId": "FP_LAMAN_PERDANA_01",
    "OfflineMqttServer":"127.0.0.1:1883",
    "DeviceMappings": {
        "4048": 1,
        "229": 2,
        "72": 3,
        "613": 4,
        "106":5,
	"308":6,
	"309":7,
	"310":8,
	"311":9
    }
}


# autostart
xrandr --output eDP-1 --rotate right
xinput set-prop "ILITEK ILITEK-TP" "Coordinate Transformation Matrix" 0 1 0 -1 0 1 0 0 1

chromium \
    --no-first-run \
    --disable-translate \
    --disable-infobars \
    --disable-suggestions-service \
    --disable-save-password-bubble \
    --start-maximized \
    --incognito \
    --pull-to-refresh=2 \
    --disable-pinch \
    --kiosk "http://localhost/" \
    --window-size=1080,1090 &

