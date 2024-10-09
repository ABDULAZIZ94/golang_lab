

url yang saufi minta
-------------------

 
{{localhost}}:7772/api/v1/telemetry/overview/advanced/ppj/{locationID}
 
{{localhost}}:7772/api/v1/telemetry/overview/ppj/{toiletId}
 
{{localhost}}:7772/api/v1/telemetry/ graph/analytic/ppj/{toiletTypeID}/{startDate}/{endDate}/{agg}

--

new location B13 
location_id = 587339bc-5d2f-4f5b-4e85-53aab5f8cefc 
 
new toilet_id
---------------------------
toilet_male = 1e4a1133-d081-4479-702e-78b0684570cf
toilet_female = 7a48f840-db75-41f2-69a5-69339074f504
toilet_oku 6de1c976-57c5-4cfb-4dd1-c65f1fb39029





select * from public.devices

select * from locations

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


-- laman view
{"error":false,"message":"Location created . ID: 9945f766-738f-4de4-5b51-ac878029af56"}




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
