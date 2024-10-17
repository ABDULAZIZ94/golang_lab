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



SELECT * FROM public.devices where device_name like '%COU%' LIMIT 100

select * from locations

 
{{localhost}}:7772/api/v1/telemetry/overview/advanced/ppj/{locationID}
 
{{localhost}}:7772/api/v1/telemetry/overview/ppj/{toiletId}
 
{{localhost}}:7772/api/v1/telemetry/ graph/analytic/ppj/{toiletTypeID}/{startDate}/{endDate}/{agg}




-- occupancy details
SELECT *
FROM public.devices
where
    device_name like '%OCCU%'
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

-- laman view
{"error":false,"message":"Location created . ID: 9945f766-738f-4de4-5b51-ac878029af56"}

-- laman view env

{"error":false,"message":"Device created . ID: f834362d-9302-44b3-4698-6b506d0b9d5c"} -- male
{"error":false,"message":"Device created . ID: d509b6fb-ef7a-4010-47cd-26e444074af6"} -- female
{"error":false,"message":"Device created . ID: d509b6fb-ef7a-4010-47cd-26e444074af6"} -- oku


-- toilet male
{"error":false,"message":"Toilet info created ID: b26430b7-eb8a-473d-424a-1f47799d421d"}

-- toilet female
{"error":false,"message":"Toilet info created ID: 30935d4a-bcea-48e0-73c6-346f6c8dad6b"}

-- toilet oku
 {"error":false,"message":"Toilet info created ID: 68e9a02d-a33f-4f58-728c-6953f874f597"}



 
-- laman view counter device 
--
{"error":false,"message":"Device created . ID: 11ee53f7-0983-41c6-55c1-24cdb5b46b9e"} -- male 106

{"error":false,"message":"Device created . ID: d37e9802-2363-4076-5404-d3768ef22e51"}
 -- female 107

{"error":false,"message":"Device created . ID: 253cc90f-d484-42be-6332-5a867ff8546c"} -- oku 108

-- feedback panel aka gateway
{"error":false,"message":"Device created . ID: b63bba7c-fe60-46cf-730d-e6b84f7fbbf9"}


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
{"error":false,"message":"Device Cubical paring success . ID: af3cf2b6-bf8f-49d8-5546-3f97b2ff16c5 with c55a8c99-ae16-4d85-698f-8deb63444384"} --m1
{"error":false,"message":"Device Cubical paring success . ID: a8acedbc-6209-4fcb-5bfd-5f68082ed81d with 19556ffe-8bba-429e-674a-b517b75891ca"} --m2
{"error":false,"message":"Device Cubical paring success . ID: 602b555d-ed3f-4a39-4f7c-4acc2a46d29d with bfce706a-0c84-48f8-514c-c5a6b7983a06"} -- m3
{"error":false,"message":"Device Cubical paring success . ID: 602b555d-ed3f-4a39-4f7c-4acc2a46d29d with bfce706a-0c84-48f8-514c-c5a6b7983a06"} --m4


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

