

-- gatewa id
d1438e09-c31b-418e-56ea-56acb1604881 


select * from device_types

select * from devices



--oku counter
e0efefe2 -6190 -4758 -5556 - b4cb209c5dea

--female counter
0c06e097-7619-43de-412e-95c71bfd4afe 

-- male counter
d11a2d04-7883-4337-6cad-f75cd9f73405 

new location B13 
location_id = 587339bc-5d2f-4f5b-4e85-53aab5f8cefc 
 
new toilet_id
---------------------------
toilet_male = 1e4a1133-d081-4479-702e-78b0684570cf
toilet_female = 7a48f840-db75-41f2-69a5-69339074f504
toilet_oku = 6de1c976-57c5-4cfb-4dd1-c65f1fb39029




SELECT DEVICES.DEVICE_NAME, DEVICES.DEVICE_ID, DEVICES.DEVICE_TOKEN, TOILET_INFOS.TOILET_NAME AS Identifier, DEVICE_TYPES.DEVICE_TYPE_NAME as Namespace,DEVICE_PAIRS.TOILET_INFO_ID
FROM
    DEVICE_PAIRS
    JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID
    JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID = DEVICES.DEVICE_TYPE_ID
    JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID
-- WHERE
--     DEVICE_PAIRS.TOILET_INFO_ID = '587339bc-5d2f-4f5b-4e85-53aab5f8cefc'


select * from toilet_infos

select * from locations