SELECT DISTINCT ON (DEVICES.DEVICE_ID) DEVICES.DEVICE_ID,DEVICE_PAIRS.GATEWAY_ID,DEVICES.DEVICE_TOKEN,DEVICES.DEVICE_NAME 
FROM DEVICES
JOIN DEVICE_PAIRS ON DEVICE_PAIRS.DEVICE_ID = DEVICES.DEVICE_ID
JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID
WHERE TOILET_INFOS.LOCATION_ID = '98998a6b-4be1-4ff4-5dd1-8a8e914943ee' AND DEVICES.DEVICE_TYPE_ID = 2



-- Select(distinct on (NOTIFICATION_DATA.NOTIFY_ID) NOTIFICATION_DATA.NOTIFY_ID,DEVICE_PAIRS.GATEWAY_ID,TOILET_INFOS.TOILET_INFO_ID,NOTIFICATION_DATA.FREQUENCY,NOTIFICATION_DATA.TOILET_TYPE_ID,FEEDBACK_PANELS.button_name as task_name,to_char(TIMESTAMP, 'YYYY-MM-DD')AS DATE , to_char(TIMESTAMP, 'HH24:MI:SS')  AS TIME
Select NOTIFICATION_DATA.NOTIFY_ID, TIMESTAMP, NOTIFICATION_DATA.FREQUENCY, NOTIFICATION_DATA.TOILET_TYPE_ID,
 to_char(TIMESTAMP, 'YYYY-MM-DD')AS DATE , to_char(TIMESTAMP, 'HH24:MI:SS')  AS TIME, FEEDBACK_PANELS.button_name as task_name
FROM NOTIFICATION_DATA
JOIN FEEDBACK_PANELS ON FEEDBACK_PANELS.BUTTON_ID = NOTIFICATION_DATA.BUTTON_ID
JOIN DEVICES ON DEVICES.DEVICE_TOKEN = NOTIFICATION_DATA.DEVICE_TOKEN
-- (JOIN DEVICE_PAIRS ON DEVICE_PAIRS.DEVICE_ID = DEVICES.DEVICE_ID
-- (JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID
-- (JOIN LOCATIONS ON LOCATIONS.LOCATION_ID = TOILET_INFOS.LOCATION_ID
JOIN TOILET_TYPES ON TOILET_TYPES.TOILET_TYPE_ID = NOTIFICATION_DATA.TOILET_TYPE_ID
-- Where(LOCATIONS.LOCATION_ID = ? AND NOTIFICATION_DATA.ACTION_STATUS = '0' AND TOILET_TYPES.TOILET_TYPE_ID IN (1,2),
-- 	locationID
Where NOTIFICATION_DATA.ACTION_STATUS = '0' AND NOTIFICATION_DATA.DEVICE_TOKEN = '53'
ORDER BY NOTIFICATION_DATA.TIMESTAMP DESC



-- Select(distinct on (NOTIFICATION_DATA.NOTIFY_ID) NOTIFICATION_DATA.NOTIFY_ID,DEVICE_PAIRS.GATEWAY_ID,TOILET_INFOS.TOILET_INFO_ID,NOTIFICATION_DATA.FREQUENCY,NOTIFICATION_DATA.TOILET_TYPE_ID,FEEDBACK_PANELS.button_name as task_name,to_char(TIMESTAMP, 'YYYY-MM-DD')AS DATE , to_char(TIMESTAMP, 'HH24:MI:SS')  AS TIME
SELECT NOTIFICATION_DATA.NOTIFY_ID, TIMESTAMP, NOTIFICATION_DATA.FREQUENCY, NOTIFICATION_DATA.TOILET_TYPE_ID, 
FEEDBACK_PANELS.button_name as task_name,to_char(TIMESTAMP, 'YYYY-MM-DD')AS DATE , 
to_char(TIMESTAMP, 'HH24:MI:SS')  AS TIME
FROM NOTIFICATION_DATA
JOIN FEEDBACK_PANELS ON FEEDBACK_PANELS.BUTTON_ID = NOTIFICATION_DATA.BUTTON_ID
JOIN DEVICES ON DEVICES.DEVICE_TOKEN = NOTIFICATION_DATA.DEVICE_TOKEN
-- (JOIN DEVICE_PAIRS ON DEVICE_PAIRS.DEVICE_ID = DEVICES.DEVICE_ID
-- (JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID
-- (JOIN LOCATIONS ON LOCATIONS.LOCATION_ID = TOILET_INFOS.LOCATION_ID
JOIN TOILET_TYPES ON TOILET_TYPES.TOILET_TYPE_ID = NOTIFICATION_DATA.TOILET_TYPE_ID
-- Where(LOCATIONS.LOCATION_ID = ? AND NOTIFICATION_DATA.ACTION_STATUS = '0' AND TOILET_TYPES.TOILET_TYPE_ID IN (1,2),
-- 	locationID
WHERE NOTIFICATION_DATA.ACTION_STATUS = '0' AND NOTIFICATION_DATA.DEVICE_TOKEN = '2'
ORDER BY NOTIFICATION_DATA.TIMESTAMP DESC

SELECT locations.*,    
ARRAY_AGG(TOILET_INFOS.TOILET_INDEX ||':'|| TOILET_INFOS.TOILET_INFO_ID  
ORDER BY TOILET_INFOS.CREATED_AT DESC) AS TOILET_LIST  
FROM locations  
JOIN toilet_infos ON toilet_infos.location_id = LOCATIONS.location_id  
JOIN contractor_and_tenants ON contractor_and_tenants.tenant_id = LOCATIONS.tenant_id  
JOIN CLEANER_AND_TENANTS ON CLEANER_AND_TENANTS.TENANT_ID = LOCATIONS.TENANT_ID  
WHERE contractor_and_tenants.CONTRACTOR_ID = '2291ed0a-0ef0-4114-72d1-f61313eb40c0'  
    AND CLEANER_AND_TENANTS.CLEANER_ID = 'f9ddee64-932d-473b-4452-c803475c5071'
GROUP BY LOCATIONS.LOCATION_ID

SELECT * FROM locations

-- get cleaner task
Select cleaner_reports.cleaner_report_id , *,USERS.user_name as cleaner_name
FROM cleaner_reports
JOIN USERS ON USERS.USER_ID = CLEANER_REPORTS.CLEANER_USER_ID
JOIN LOCATIONS ON LOCATIONS.LOCATION_ID = cleaner_reports.LOCATION_ID
JOIN TOILET_TYPES ON TOILET_TYPES.TOILET_TYPE_ID = cleaner_reports.TOILET_TYPE_ID
Where LOCATIONS.LOCATION_ID = '59a30f96-fec0-4dee-5ded-882e9e25195a' AND TOILET_TYPES.TOILET_TYPE_ID IN (1,2)
    AND DATE(cleaner_reports.CREATED_AT) >= '2024-01-01' AND DATE(cleaner_reports.CREATED_AT) <= '2024-05-05'
ORDER BY cleaner_reports.CREATED_AT DESC