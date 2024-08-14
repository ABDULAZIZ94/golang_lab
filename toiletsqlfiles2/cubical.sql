

select * from device_pairs

alter table device_pairs add column cubical_id text

select * from cubical_infos

-- get list of toilets
Select toilet_infos.*, toilet_types.toilet_type_name
from toilet_infos
JOIN toilet_types ON toilet_types.toilet_type_id = toilet_infos.toilet_type_id
where toilet_infos.tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'


-- get list of devices on each toilet
Select device_pairs.*,devices.device_id ,devices.device_name , devices.device_token,device_types.device_type_name as device_type,device_types.device_type_id
from device_pairs
JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID
JOIN device_types ON device_types.device_type_id = devices.device_type_id
Where device_pairs.toilet_info_id = '9388096c-784d-49c8-784c-1868b1233165' --kemaman male -- v.ToiletInfoID


select ci.cubical_id, ci.cubical_name from cubical_infos ci
join cubical_pairs cp on ci.cubical_id = cp.cubical_id
where cp.toilet_info_id = '9388096c-784d-49c8-784c-1868b1233165' --kemaman male


-- uuid_generate_v4 ()

select * from device_cubical_pairs

INSERT INTO DEVICE_CUBICAL_PAIRS ("device_cubical_pair_id", "cubical_id", "device_id")
VALUES (uuid_generate_v4 (), '881ac292-f7ba-42ed-61be-7ea9e5368d89','3c64d02c-abfb-4b57-5dfe-116d163ecee3')

INSERT INTO DEVICE_CUBICAL_PAIRS ("device_cubical_pair_id", "cubical_id", "device_id") VALUES
    (uuid_generate_v4 (), 'e34a8f65-9524-4a6a-55d5-153217239201','4cd91fb8-54ef-46e8-4472-4c1b9a3a42bc'),
    (uuid_generate_v4 (), 'f064a7ee-6568-41fe-4110-19c3d7ea6718','d861a427-4aa2-46ce-5fa7-92961c81b61d'),
    (uuid_generate_v4 (), 'a26a1af6-3ffa-4cbd-5185-125cc2b94e31','c1297d5a-243a-4c4a-5839-e60d93718132'),
    (uuid_generate_v4 (), '6a9237e9-9933-4fa2-7f8a-a53978d7271c','4234509e-0749-4e04-7342-87ed4cb42e7d'),
    (uuid_generate_v4 (), '2512c06f-bf57-45e1-7a7b-5e0935dbbe8d','88c5fbc6-8bbc-473a-78f5-4a8a5d070a16'),
    (uuid_generate_v4 (), '214a2dcf-7b6e-4e98-5f77-2103dcecf0e7','ef4a97a5-cabd-4214-797e-7b050140d818'),
    (uuid_generate_v4 (), '057ba462-c2e6-4d12-69e5-7f2ffac5927f','7b53a36c-a016-4ddb-766c-177e0f9b7d9a')
    

-- m
c1297d5a-243a-4c4a-5839-e60d93718132  --4
4cd91fb8-54ef-46e8-4472-4c1b9a3a42bc --2
d861a427-4aa2-46ce-5fa7-92961c81b61d --3

--f
4234509e-0749-4e04-7342-87ed4cb42e7d --1
88c5fbc6-8bbc-473a-78f5-4a8a5d070a16
ef4a97a5-cabd-4214-797e-7b050140d818
7b53a36c-a016-4ddb-766c-177e0f9b7d9a


-- cubical m
881ac292-f7ba-42ed-61be-7ea9e5368d89 --1
e34a8f65-9524-4a6a-55d5-153217239201
f064a7ee-6568-41fe-4110-19c3d7ea6718
a26a1af6-3ffa-4cbd-5185-125cc2b94e31

-- cubical f
6a9237e9-9933-4fa2-7f8a-a53978d7271c --1
2512c06f-bf57-45e1-7a7b-5e0935dbbe8d
214a2dcf-7b6e-4e98-5f77-2103dcecf0e7
057ba462-c2e6-4d12-69e5-7f2ffac5927f

