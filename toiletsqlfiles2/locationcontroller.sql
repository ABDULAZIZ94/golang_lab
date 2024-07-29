-- Active: 1721143226972@@127.0.0.1@5432@smarttoilet

SELECT AVG(USER_REACTIONS.SCORE) AS SCORE,  
LOCATIONS.* ,  
AVG(ENVIROMENT_DATA.IAQ) AS IAQ  
FROM LOCATIONS  
LEFT JOIN TOILET_INFOS ON TOILET_INFOS.LOCATION_ID = LOCATIONS.LOCATION_ID  
LEFT JOIN USER_REACTIONS ON USER_REACTIONS.TOILET_ID = TOILET_INFOS.toilet_info_id  
LEFT JOIN DEVICE_PAIRS ON DEVICE_PAIRS.TOILET_INFO_ID = TOILET_INFOS.TOILET_INFO_ID  
LEFT JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID  
LEFT JOIN ENVIROMENT_DATA on ENVIROMENT_DATA.DEVICE_TOKEN = DEVICES.DEVICE_TOKEN  
WHERE (DATE(ENVIROMENT_DATA.TIMESTAMP) AT TIME ZONE 'UTC' AT TIME ZONE 'ASIA/KUALA_LUMPUR' = CURRENT_DATE AT TIME ZONE 'UTC' AT TIME ZONE 'ASIA/KUALA_LUMPUR'  
-- OR DATE(ENVIROMENT_DATA.TIMESTAMP) IS NULL) AND LOCATIONS.TENANT_ID =''
OR DATE(ENVIROMENT_DATA.TIMESTAMP) IS NULL) AND 1=1
GROUP BY LOCATIONS.LOCATION_ID


-- check list of locations
SELECT * FROM locations
