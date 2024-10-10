
-- ppj tenant id 59944171-3a4a-460d-5897-8bb38c524d54 

url yang saufi minta
-------------------


SELECT * FROM public.devices where device_name like '%OCC%' LIMIT 100

select * from locations

 
{{localhost}}:7772/api/v1/telemetry/overview/advanced/ppj/{locationID}
 
{{localhost}}:7772/api/v1/telemetry/overview/ppj/{toiletId}
 
{{localhost}}:7772/api/v1/telemetry/ graph/analytic/ppj/{toiletTypeID}/{startDate}/{endDate}/{agg}

--

new location B13 
location_id = 587339bc-5d2f-4f5b-4e85-53aab5f8cefc 

select * from device_pairs 
join toilet_infos on toilet_infos.toilet_info_id = device_pairs.toilet_info_id
where toilet_infos.location_id = '587339bc-5d2f-4f5b-4e85-53aab5f8cefc'

select * from public.devices order by REGEXP_REPLACE(device_token, '[^0-9]', '', 'g')::int


-- device_id 8 feedback panel f6e0e3eb-7b83-4024-63c8-9debd870fa1f 
select * from device_pairs where device_id = 'f6e0e3eb-7b83-4024-63c8-9debd870fa1f'

select * from device_pairs where gateway_id = 'f6e0e3eb-7b83-4024-63c8-9debd870fa1f'


-- eg kemaman
{"error":false,"message":"Device paring success . ID: f6e0e3eb-7b83-4024-63c8-9debd870fa1f, d1438e09-c31b-418e-56ea-56acb1604881"}

select * from device_pairs where device_id = 'a5e938c2-744a-4755-6fd2-150a235e1050'

select * from device_pairs where gateway_id = 'a5e938c2-744a-4755-6fd2-150a235e1050'


-- b13 ip
b13 - 192.168.1.64 (1) b13- 192.168.1. 225 (2) 


new toilet_id
---------------------------
toilet_male = 1e4a1133-d081-4479-702e-78b0684570cf
toilet_female = 7a48f840-db75-41f2-69a5-69339074f504
toilet_oku 6de1c976-57c5-4cfb-4dd1-c65f1fb39029

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
select dp.device_pair_id, dp.gateway_id, dp.toilet_info_id, ti.toilet_name, d.device_name, d.device_token, d.device_id
from
    device_pairs as dp
    join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
    join devices as d on dp.device_id = d.device_id
    join locations as l on l.location_id = ti.location_id
where
    l.location_id = '587339bc-5d2f-4f5b-4e85-53aab5f8cefc'


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




-- all saujana hijau toilet 
-- saujana hijau location id 98998a6b-4be1-4ff4-5dd1-8a8e914943ee 


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