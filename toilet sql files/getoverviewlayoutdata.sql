-- get list of devices in this identifier
SELECT DEVICES.DEVICE_NAME,DEVICES.DEVICE_ID,DEVICES.DEVICE_TOKEN,  
		TOILET_INFOS.TOILET_NAME AS Identifier ,DEVICE_TYPES.DEVICE_TYPE_NAME as  Namespace  
FROM DEVICE_PAIRS  
JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID  
JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID = DEVICES.DEVICE_TYPE_ID  
JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID  
WHERE DEVICE_PAIRS.TOILET_INFO_ID = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984'

-- ADDITIONAL DATA FOR NEW FP
SELECT COUNT(CASE WHEN ur.reaction = '1' THEN 1 END) AS happy,  
COUNT(CASE WHEN ur.reaction = '2' THEN 1 END) AS satisfied,  
COUNT(CASE WHEN ur.reaction = '3' THEN 1 END) AS not_satisfied,  
COUNT(CASE WHEN ur.reaction = '4' THEN 1 END) AS not_happy,  
COUNT(CASE WHEN ur.complaint = '1' THEN 1 END) AS smelly_toilet, 
COUNT(CASE WHEN ur.complaint = '2' THEN 1 END) AS out_of_supplies,  
COUNT(CASE WHEN ur.complaint = '3' THEN 1 END) AS wet_floor,  
COUNT(CASE WHEN ur.complaint = '4' THEN 1 END) AS plumbing_issues  
FROM  
user_reactions ur  
LEFT JOIN  
reactions r ON r.react_id = ur.reaction  
LEFT JOIN  
complaints c ON c.complaint_id = ur.complaint  
WHERE ur.toilet_id = '5654c008-dbcc-4656-5601-0a0c50652213'  
AND (TIMESTAMP) >= TO_TIMESTAMP('  2024-07-01   16:00:00','YYYY-MM-DD HH24:MI:SS')

-- temporary fix mbk cleaner issue from male toiles 
SELECT LOCATION_ID FROM TOILET_INFOS
WHERE TOILET_INFO_ID ='0a38e4d1-f9b9-4cb2-648f-20e0ac269984'
