SELECT DEVICES.DEVICE_NAME,DEVICES.DEVICE_ID,DEVICES.DEVICE_TOKEN,  
TOILET_INFOS.TOILET_NAME AS Identifier ,DEVICE_TYPES.DEVICE_TYPE_NAME as Namespace,  
DEVICE_TYPES.DEVICE_TYPE_ID AS NAMESPACE_ID , TOILET_INFOS.TOILET_TYPE_ID  
FROM DEVICE_PAIRS  
JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID  
JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID = DEVICES.DEVICE_TYPE_ID  
JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID  
WHERE TOILET_INFOS.TOILET_INFO_ID IN (
    SELECT toilet_info_id
    FROM TOILET_INFOS 
    WHERE tenant_id = 'f8be7a6d-679c-4319-6906-d172ebf7c17e'
)

-- sum all data according to device_type_id aka namespace_id
-- make sure apply time interval

-- sum all trafic
-- sum all environment

select * from toilet_infos

-- generate timestamp interval
SELECT uplinkTS  
FROM generate_series(date_trunc('HOUR', TO_TIMESTAMP('2024-07-22 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),  
date_trunc('HOUR', TO_TIMESTAMP('2024-07-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),  
interval '1 HOUR') uplinkTS


WITH GENTIME as (SELECT uplinkTS  
    FROM generate_series(date_trunc('HOUR', TO_TIMESTAMP('2024-07-22 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),  
    date_trunc('HOUR', TO_TIMESTAMP('2024-07-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),  
    interval '1 HOUR') uplinkTS)



-- pakai namespace

