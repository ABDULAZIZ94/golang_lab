-- Active: 1722832765629@@alpha.vectolabs.com@9998@smarttoilet-staging
# device token in order

select * from locations -- 2a83bc9b-0dba-451e-7760-a29bfc3db337 

select * from public.toilet_infos

--check contractor tenant pair
SELECT * FROM "contractor_and_tenants"  WHERE tenant_id = '2291ed0a-0ef0-4114-72d1-f61313eb40c0' AND contractor_id = '2291ed0a-0ef0-4114-72d1-f61313eb40c0'

SELECT *
FROM "contractor_and_tenants"
WHERE (
        tenant_id = '2291ed0a-0ef0-4114-72d1-f61313eb40c0'
        AND contractor_id = '2291ed0a-0ef0-4114-72d1-f61313eb40c0'
    )

-- kpkt 
select * from users

SELECT *
FROM public."contractor_and_tenants"
WHERE (
        tenant_id = '984bbf11-868c-43e8-6c5e-d9a0151fefc6'
        -- AND contractor_id = '984bbf11-868c-43e8-6c5e-d9a0151fefc6'
    )


select * from tenants where tenant_id = '984bbf11-868c-43e8-6c5e-d9a0151fefc6'

-- kpkt cleaner id a816fad3-9fe0-4c94-517f-d2545741d82e 
select * from cleaner_and_tenants where tenant_id = '984bbf11-868c-43e8-6c5e-d9a0151fefc6'

select * from cleaner_and_tenants where contractor_id = '984bbf11-868c-43e8-6c5e-d9a0151fefc6'

-- table cleaner and tenants

--checking before pairing
SELECT *
FROM "contractor_and_tenants"
WHERE (
        tenant_id = '984bbf11-868c-43e8-6c5e-d9a0151fefc6'
        AND contractor_id = '984bbf11-868c-43e8-6c5e-d9a0151fefc6'
    )

select * from users

select * from users where user_id in(
    '7a1c3658-d58b-46ca-6935-6a0835477b69',
    'f9ddee64-932d-473b-4452-c803475c5071',
    '352cf1bc-c016-4fbe-7d86-a8c8422611e7',
    'b0b44b8c-b3a8-409c-5215-0ef1ec94e03b',
    'ca47cf09-e64f-4aa7-59cc-5f1c2d2b8f74',
    '73787930-ad1f-4f11-5b12-39d6b82ef9bc',
    '3955b814-2ebe-46f1-48b0-b72314b329b3',
    '92ff589a-b777-4e5c-79d8-6424fc565e8c',
    'fde98591-e015-45c5-6cb1-24a918b0e056',
    'b4af7840-ae84-450d-7661-19041a880fd0',
    '950390ca-19cc-492c-4bf5-c04d40b6656e',
    '4b079dad-b330-44ff-78e2-be8fa66c8f3f',
    'a3cd69de-be57-4516-4e9b-7e0281cad3ec',
    '6dba5d88-84d3-4e0c-7c15-4682f71fb569',
    '6e146de9-2353-4c64-48e6-fa1c158bc56f',
    '8bc335d3-283e-46af-4141-487fe7b5edae',
    'b4798aa4-9f31-429c-5796-777d5ba767ae',
    'c09d268e-de54-4582-4b5e-acba3ade9b4a'
)

SELECT 
    locations.*,
    toilet_infos.*,
    -- contractor_and_tenants.*,
ARRAY_AGG(
        TOILET_INFOS.TOILET_NAME || ':' || TOILET_INFOS.TOILET_INFO_ID
        ORDER BY TOILET_INFOS.CREATED_AT DESC
    ) AS TOILET_LIST
FROM
    locations
    JOIN toilet_infos ON toilet_infos.location_id = LOCATIONS.location_id
    JOIN contractor_and_tenants ON contractor_and_tenants.tenant_id = LOCATIONS.tenant_id
    JOIN CLEANER_AND_TENANTS ON CLEANER_AND_TENANTS.TENANT_ID = LOCATIONS.TENANT_ID
WHERE
    contractor_and_tenants.CONTRACTOR_ID = '2291ed0a-0ef0-4114-72d1-f61313eb40c0' -- not kpkt tenant id, preset contractor
    AND CLEANER_AND_TENANTS.CLEANER_ID = 'a816fad3-9fe0-4c94-517f-d2545741d82e' -- user id
GROUP BY
    LOCATIONS.LOCATION_ID, 
    toilet_infos.toilet_info_id
    -- contractor_and_tenants.pair_id 

-- check di contractor and tenants
SELECT *
FROM "contractor_and_tenants"
WHERE (
        tenant_id = '2291ed0a-0ef0-4114-72d1-f61313eb40c0'
        AND contractor_id = '2291ed0a-0ef0-4114-72d1-f61313eb40c0'
    )

select * from locations  --2a83bc9b-0dba-451e-7760-a29bfc3db337  kpkt

-- occupancy details


SELECT *
FROM public.devices
where
    device_name like '%%'
    -- and device_type_id = '7'
order by REGEXP_REPLACE(
        device_token, '[^0-9]', '', 'g'
    )::int

select * from public.devices where device_token IN (
    '4050',
    '4051'
)

# feedback panel
{"error":false,"message":"Device created . ID: 00b632fd-72e1-4f59-51d7-4d86e605c731"} -- male
{"error":false,"message":"Device created . ID: 4150b396-d125-411e-40f7-91b209c6aba0"} -- female
{"error":false,"message":"Device created . ID: 26ee0aa4-b351-46e4-5c95-c401b5de8477"} --oku


# kpkt

select * from tenants  -- 984bbf11-868c-43e8-6c5e-d9a0151fefc6 

select * from locations -- 2a83bc9b-0dba-451e-7760-a29bfc3db337 

select * from public.users where tenant_id ='984bbf11-868c-43e8-6c5e-d9a0151fefc6'

{"error":false,"message":"Device created . ID: 205cb674-f32e-463d-725b-d3965cd8a541"} -- kpkt_gateway_01
{"error":false,"message":"Device created . ID: 90f48065-ae2d-4952-6851-c09f088097b7"} -- kpkt_gateway_02
{"error":false,"message":"Device created . ID: e00848d7-4e1b-41a8-4525-cc9194df82ca"} -- kpkt_gateway_03

select * from public.device_pairs where device_id in (
    -- '2ee3148d-56af-42eb-7c9d-fed73be3a314',
    -- '0ed9e984-83ea-4a02-4f51-cad08ce692fc',
    -- '75fb2632-d616-4108-4619-4013fdc4d8b0'
    -- 'd4c4a614-dbbc-423e-7dee-472ca602d471',
    -- '2128e434-5fbc-4cda-4759-95eba64bd61b',
    -- '033d9091-cf9f-4d03-61bd-ec7e2a844411',
    -- '44b7c154-7bd1-4083-7e47-18e503fd3d29'
    'fde75e65-af87-4176-7a16-1db6a8cfd4bf',
    '3e7de029-f6f5-4938-5f5f-882c076687f3'
)

#
{"error":false,"message":"Tenant created , ID: 984bbf11-868c-43e8-6c5e-d9a0151fefc6"}


select * from public.device_pairs where device_id ='c9331db4-cb9e-4961-47c0-f6735e7ad0c8'

select *
from public.device_pairs
where
    device_id = 'aed7b940-6686-4767-5398-2eb342f21544'

select * from locations

select *
from tenants
where
    tenant_id = '984bbf11-868c-43e8-6c5e-d9a0151fefc6'


-- new location kpkt
{"error":false,"message":"Location created . ID: 2a83bc9b-0dba-451e-7760-a29bfc3db337"}

-- toilet male kpkt
{"error":false,"message":"Toilet info created ID: 050c7c1d-13fc-48b3-6a4c-e15dfe02a688"}

-- toilet female kpkt
{"error":false,"message":"Toilet info created ID: 3194cc8d-31f9-4441-504d-c45758ed9559"}

select * from public.devices where device_id in('8a88b9a8-d2b9-4d28-7ee5-a46372b12b7d', 'd515d563-bb47-4da1-7dab-7d9fc735cbda')

-- list devices in kpkt
select *
from
    device_pairs
    join devices on devices.device_id = device_pairs.device_id
    join toilet_infos on toilet_infos.toilet_info_id = device_pairs.toilet_info_id
where
    toilet_infos.location_id = '2a83bc9b-0dba-451e-7760-a29bfc3db337'
    -- and device_type_id = '7'


-- list toilet in kpkt -- 3 gateway
select * from public.toilet_infos where location_id = '2a83bc9b-0dba-451e-7760-a29bfc3db337'

-- add oku toilet
050c7c1d-13fc-48b3-6a4c-e15dfe02a688  --male kpkt
379456c3-9b7e-4bb4-7c92-8212fa6ed997 -- oku kpkt
3194cc8d-31f9-4441-504d-c45758ed9559  -- female kpkt

-- list cubicle in kpkt
select * from cubical_infos
left join cubical_pairs using(cubical_id)
left join toilet_infos using(toilet_info_id)
left join device_cubical_pairs using(cubical_id)
left join devices using(device_id)
where toilet_infos.location_id = '2a83bc9b-0dba-451e-7760-a29bfc3db337'


-- 318 , pair 9a5a94b1-3dde-4660-6ffd-b5e8d32b1f31 , m1 19d95404-00b4-4a2d-4b85-cf56b15e5807 , dev_id e3b92a7a-dbba-4883-4f9d-0415cc764cf1 
-- 319 , pair 5aab0a3c-da55-442b-6ac5-7b328640fae9 , m2 cc77608d-79d8-491c-54c9-6fa62f4c8e8a , dev_id 5c5f41f5-9b5d-4945-72e8-d24aac1dfc57 

select * from public.device_cubical_pairs where device_cubical_pair_id in ('9a5a94b1-3dde-4660-6ffd-b5e8d32b1f31', '5aab0a3c-da55-442b-6ac5-7b328640fae9')

select * from public.cubical_pairs

-- manage unpaired cubicle
select * from public.cubical_infos where cubical_id in (
    'eb993fb2-f732-48f4-7941-aedb08d6e9bd',
    'cc77608d-79d8-491c-54c9-6fa62f4c8e8a',
    '1543e26a-6f99-4076-69ed-81bfed019c57',
    'c909bf67-7530-4d2b-7c23-f982c3d78a97',
    '586b94c9-5ca4-46fa-7628-1c01cb4f2460',
    '19d95404-00b4-4a2d-4b85-cf56b15e5807',
    '57febf1d-3a65-467e-5174-45db69dd49fe',
    '6d015246-13a1-4cf7-4219-70fc824f3dfe',
    'b839ad7c-348f-4cb3-5d41-3f1738d7a76a',
    'f856559d-3a07-48cf-5311-505e6b3b2dc4',
    '1bc095d3-5ebf-4c47-6f95-041901a03b46',
    'acf993f9-6ea5-4274-429e-114d0905f130',
    '40af79d3-a44e-4677-4b10-607d389f65f5',
    '9c7fc863-7a74-408a-53d9-039d37f9d85b',
    'edd6a42a-7c17-4da7-45bd-0467c50ed73f'
)


eb993fb2-f732-48f4-7941-aedb08d6e9bd -- f1
9c7fc863-7a74-408a-53d9-039d37f9d85b -- f2
19d95404-00b4-4a2d-4b85-cf56b15e5807 -- m1
cc77608d-79d8-491c-54c9-6fa62f4c8e8a -- m2


-- sensor counter,
{"error":false,"message":"Device created . ID: ada9a3d3-abb6-43a7-61fe-2f07856d6ccf"} -- counter male 110
{"error":false,"message":"Device created . ID: 544acae6-dd5c-4e1b-5e71-3b671d930ba5"} -- counter female 111
{"error":false,"message":"Device created . ID: 2ee3148d-56af-42eb-7c9d-fed73be3a314"} -- counter oku 112

-- env, 
{"error":false,"message":"Device created . ID: 8a88b9a8-d2b9-4d28-7ee5-a46372b12b7d"} -- env male 231
{"error":false,"message":"Device created . ID: d515d563-bb47-4da1-7dab-7d9fc735cbda"} -- env female 232
{"error":false,"message":"Device created . ID: 0ed9e984-83ea-4a02-4f51-cad08ce692fc"} -- env oku 233

{"error":false,"message":"Device created . ID: 688ec9b7-eca5-42c4-4e0e-e730906742b3"}

-- ammonia 73
44b7c154-7bd1-4083-7e47-18e503fd3d29 

select * from devices where device_id  = '44b7c154-7bd1-4083-7e47-18e503fd3d29'

select * from public.devices where device_token= '233'

select * from public.devices where device_id IN (
    '205cb674-f32e-463d-725b-d3965cd8a541',
    '90f48065-ae2d-4952-6851-c09f088097b7',
    'e00848d7-4e1b-41a8-4525-cc9194df82ca',
    'ada9a3d3-abb6-43a7-61fe-2f07856d6ccf',
    '544acae6-dd5c-4e1b-5e71-3b671d930ba5',
    '2ee3148d-56af-42eb-7c9d-fed73be3a314',
    'c9331db4-cb9e-4961-47c0-f6735e7ad0c8',
    'e5a8b2a2-790c-4631-6d72-e5b7b85ce448',
    'd28e5449-86b3-4ffc-5bd6-a5ef9aca9e26',
    '75fb2632-d616-4108-4619-4013fdc4d8b0',
    'e3b92a7a-dbba-4883-4f9d-0415cc764cf1',
    '5c5f41f5-9b5d-4945-72e8-d24aac1dfc57',
    'ada9a3d3-abb6-43a7-61fe-2f07856d6ccf',
    '0ed9e984-83ea-4a02-4f51-cad08ce692fc',
    '544acae6-dd5c-4e1b-5e71-3b671d930ba5',
    '947ca54c-3e11-4bbd-6f0c-ad0c0738a0d5',
    '8971c6c9-687e-4c23-55e5-399a784d8fe9',
    '8a88b9a8-d2b9-4d28-7ee5-a46372b12b7d',
    'd515d563-bb47-4da1-7dab-7d9fc735cbda',
    '2ee3148d-56af-42eb-7c9d-fed73be3a314'
)

select * from device_pairs where device_id = '0ed9e984-83ea-4a02-4f51-cad08ce692fc'

-- fragrance, 
{"error":false,"message":"Device created . ID: e5a8b2a2-790c-4631-6d72-e5b7b85ce448"} -- freshener male 615
{"error":false,"message":"Device created . ID: d28e5449-86b3-4ffc-5bd6-a5ef9aca9e26"} -- freshener female 616
{"error":false,"message":"Device created . ID: 75fb2632-d616-4108-4619-4013fdc4d8b0"} -- freshener oku 617

-- occupancy
{"error":false,"message":"Device created . ID: e3b92a7a-dbba-4883-4f9d-0415cc764cf1"} -- occupancy male 1
{"error":false,"message":"Device created . ID: 5c5f41f5-9b5d-4945-72e8-d24aac1dfc57"} -- occupancy male 2

{"error":false,"message":"Device created . ID: 947ca54c-3e11-4bbd-6f0c-ad0c0738a0d5"} -- occupancy female 1
{"error":false,"message":"Device created . ID: 8971c6c9-687e-4c23-55e5-399a784d8fe9"} -- occupancy female 2

-- oku
{"error":false,"message":"Device created . ID: c9331db4-cb9e-4961-47c0-f6735e7ad0c8"} -- occ oku
{"error":false,"message":"Device created . ID: 1d2bc797-f30a-4454-4c66-48ef9141a9b3"}


-- add cubical
eb993fb2-f732-48f4-7941-aedb08d6e9bd  -- f1
9c7fc863-7a74-408a-53d9-039d37f9d85b  -- f2

19d95404-00b4-4a2d-4b85-cf56b15e5807  --m1
cc77608d-79d8-491c-54c9-6fa62f4c8e8a  --m2

-- pair cubical


select * from enviroment_data where device_token = '232'

select * from counter_data where device_token = '109'
-- and timestamp > current_timestamp - interval '1 hour'


-- fail
with
    start_end as (
        select to_timestamp(
                '2024-11-11 16:00:00', 'YYYY-MM-DD HH24:MI:SS'
            ) as start_date, to_timestamp(
                '2024-11-12 15:59:59', 'YYYY-MM-DD HH24:MI:SS'
            ) as end_date
    ),
    device_list as (
        select toilet_infos.toilet_info_id, devices.device_token, device_types.device_type_id as namespace_id
        from
            device_pairs
            join devices on devices.device_id = device_pairs.device_id
            join device_types on device_types.device_type_id = devices.device_type_id
            join toilet_infos on toilet_infos.toilet_info_id = device_pairs.toilet_info_id
            join toilet_types on toilet_types.toilet_type_id = toilet_infos.toilet_type_id
        where
            device_pairs.toilet_info_id = '379456c3-9b7e-4bb4-7c92-8212fa6ed997'
    )


select  *
from fragrance_data
    -- join device_list using (device_token)
where
    fragrance_data.fragrance_on = true
    and device_token = '617'
    -- and (
    --     timestamp::time >= '16:00:00'
    --     OR (
    --         timestamp::time >= '00:00:00'
    --         AND timestamp::time <= '15:59:59'
    --     )
    -- )
    -- and timestamp between (
    --     select start_date
    --     from start_end
    -- ) and (
    --     select end_date
    --     from start_end
    -- )


select
    coalesce(ttltraffic, '0') as total_counter,
    last_counter_ts as last_counter_cnt_timestamp,
    iaq as odour_level,
    total_fragrance
from (
        select device_list.toilet_info_id
        from device_list
        limit 1
    ) as Q0
    left join (
        select sum(people_in) as ttltraffic
        from counter_data
            join device_list using (device_token)
        where
            device_list.namespace_id = 2
            and (
                timestamp::time >= '16:00:00'
                OR (
                    timestamp::time >= '00:00:00'
                    AND timestamp::time <= '15:59:59'
                )
            )
            and timestamp between (
                select start_date
                from start_end
            ) and (
                select end_date
                from start_end
            )
    ) as Q1 ON TRUE
    left join (
        select iaq
        from enviroment_data
            join device_list using (device_token)
        where
            device_list.namespace_id = 3
            and (
                timestamp::time >= '16:00:00'
                OR (
                    timestamp::time >= '00:00:00'
                    AND timestamp::time <= '15:59:59'
                )
            )
            and timestamp between (
                select start_date
                from start_end
            ) and (
                select end_date
                from start_end
            )
        order by timestamp desc
        limit 1
    ) as Q2 ON TRUE
    left join (
        select count(id) as total_fragrance
        from fragrance_data
            join device_list using (device_token)
        where
            fragrance_data.fragrance_on = true
            and (
                timestamp::time >= '16:00:00'
                OR (
                    timestamp::time >= '00:00:00'
                    AND timestamp::time <= '15:59:59'
                )
            )
            and timestamp between (
                select start_date
                from start_end
            ) and (
                select end_date
                from start_end
            )
    ) as Q7 ON TRUE
    left join (
        select timestamp as last_counter_ts
        from counter_data
            join device_list using (device_token)
        where
            device_list.namespace_id = 2
            and (
                timestamp::time >= '16:00:00'
                OR (
                    timestamp::time >= '00:00:00'
                    AND timestamp::time <= '15:59:59'
                )
            )
            and timestamp between (
                select start_date
                from start_end
            ) and (
                select end_date
                from start_end
            )
        order by timestamp desc
        limit 1
    ) as Q9 ON TRUE

(timestamp::time >= '16:00:00' OR ( timestamp::time >= '00:00:00' AND timestamp::time <= '15:59:59'))


-- (cr.created_at::time >= '23:00:00' OR ( cr.created_at::time >= '00:00:00' AND cr.created_at::time <= '11:00:00')

(cr.created_at::time >= '16:00:00' OR ( cr.created_at::time >= '00:00:00' AND cr.created_at::time <= '15:59:59')



-- sqlite
select * from health_check_logs where device_id = 232;


select * from raw_data_logs where raw_data like '%02690601%'

-- fragrance
select count(raw_data) from raw_data_logs where raw_data like 'VT_RECEIVED=%02690601%'; --121


-- counter
select count(raw_data)
from raw_data_logs
where
    raw_data like 'VT_RECEIVED=%006E010001%'; --18

'VT_RECEIVED=%02690601%';
-