
-- get list of devivices based on device_pairs table that paired to a toilet id
SELECT
    DEVICES.DEVICE_NAME,
    DEVICES.DEVICE_ID,
    DEVICES.DEVICE_TOKEN,
    TOILET_INFOS.TOILET_NAME AS IDENTIFIER,
    TOILET_INFOS.TOILET_INFO_ID AS IDENTIFIER_ID,
    DEVICE_TYPES.DEVICE_TYPE_NAME AS NAMESPACE,
    DEVICE_TYPES.DEVICE_TYPE_ID AS NAMESPACE_ID,
    TOILET_TYPES.TOILET_TYPE_ID
FROM
    DEVICE_PAIRS
    JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID
    JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID = DEVICES.DEVICE_TYPE_ID
    JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID
    JOIN TOILET_TYPES ON TOILET_TYPES.TOILET_TYPE_ID = TOILET_INFOS.TOILET_TYPE_ID
WHERE
    DEVICE_PAIRS.TOILET_INFO_ID = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984'

-- GET OVERVIEW CARD DATA
WITH DEVICE_LIST AS ( 
    SELECT DEVICES.DEVICE_NAME,DEVICES.DEVICE_ID,DEVICES.DEVICE_TOKEN, 
    TOILET_INFOS.TOILET_NAME AS IDENTIFIER,TOILET_INFOS.TOILET_INFO_ID AS IDENTIFIER_ID, 
    DEVICE_TYPES.DEVICE_TYPE_NAME AS NAMESPACE,DEVICE_TYPES.DEVICE_TYPE_ID AS NAMESPACE_ID,  
    TOILET_TYPES.TOILET_TYPE_ID  
    FROM DEVICE_PAIRS  
    JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID  
    JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID = DEVICES.DEVICE_TYPE_ID  
    JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID  
    JOIN TOILET_TYPES ON TOILET_TYPES.TOILET_TYPE_ID = TOILET_INFOS.TOILET_TYPE_ID  
    WHERE DEVICE_PAIRS.TOILET_INFO_ID = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984')
SELECT LAST_UPDATE as timestamp,COALESCE(TTLTRAFFIC ,'0') AS TOTAL_COUNTER,  
LAST_COUNTER_TS AS LAST_COUNTER_CNT_TIMESTAMP, 
-- COALESCE(HOURS::text, '0') AS HOURS,  
IAQ AS ODOUR_LEVEL,TMP,LUX , 
FAN_STATUS,BLOWER_STATUS,OCCUPIED_STATUS,DISPLAY_STATUS,TOILET_NAME,TOILET_TYPE_ID,   
TOTAL_FRAGRANCE , TOTAL_AUTOCLEAN ,TOTAL_COMPLAINT  
FROM  
	(SELECT SUM(people_in) AS TTLTRAFFIC  
	FROM COUNTER_DATA  
	JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = COUNTER_DATA.DEVICE_TOKEN  
	-- WHERE DEVICE_LIST.NAMESPACE_ID = 2 AND DATE(TIMESTAMP) = DATE(NOW())) Q1  
	WHERE DEVICE_LIST.NAMESPACE_ID = 2 AND (TIMESTAMP) >= TO_TIMESTAMP('  2024-06-01   16:00:00','YYYY-MM-DD HH24:MI:SS')) Q1  
CROSS JOIN  
	(SELECT TIMESTAMP AS LAST_UPDATE,LUX,TEMPERATURE AS TMP,IAQ  
	FROM ENVIROMENT_DATA  
	JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = ENVIROMENT_DATA.DEVICE_TOKEN  
	WHERE DEVICE_LIST.NAMESPACE_ID = 3  
	ORDER BY TIMESTAMP DESC LIMIT 1) Q2  
CROSS JOIN  
	(SELECT COUNT(*) AS TOTAL_COMPLAINT  
	FROM FEEDBACK_PANEL_DATA  
	JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = FEEDBACK_PANEL_DATA.DEVICE_TOKEN  
	JOIN DEVICE_PAIRS ON DEVICE_PAIRS.DEVICE_ID = DEVICE_LIST.DEVICE_ID  
	JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID  
	-- WHERE DATE(TIMESTAMP) = DATE(NOW()) AND   
	WHERE (TIMESTAMP) >= TO_TIMESTAMP('  2024-06-01   16:00:00','YYYY-MM-DD HH24:MI:SS') AND   
	-- TOILET_INFOS.TOILET_TYPE_ID = '  strconv.Itoa(v.ToiletTypeID)  ') Q5  
	DEVICE_LIST.TOILET_TYPE_ID = FEEDBACK_PANEL_DATA.TOILET_TYPE_ID) Q5  
CROSS JOIN  
	(SELECT FAN_STATUS,BLOWER_STATUS,OCCUPIED_STATUS,DISPLAY_STATUS,TOILET_NAME,TOILET_TYPE_ID  
	FROM TOILET_INFOS  
	WHERE TOILET_INFOS.TOILET_INFO_ID = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984') Q6  
CROSS JOIN  
	(SELECT COUNT(*) AS TOTAL_FRAGRANCE  
	FROM MISC_ACTION_DATA  
	JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = MISC_ACTION_DATA.DEVICE_TOKEN  
	WHERE MISC_ACTION_DATA.NAMESPACE = 'FRESHENER') Q7  
CROSS JOIN  
	(SELECT COUNT(CASE WHEN AUTO_CLEAN_STATE = '1' THEN 1 END) AS TOTAL_AUTOCLEAN  
	FROM CLEANER_REPORTS  
	WHERE CLEANER_REPORTS.TOILET_TYPE_ID = (SELECT TOILET_TYPE_ID FROM TOILET_INFOS  
	WHERE TOILET_INFO_ID = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984')) Q8  
LEFT JOIN  
	(SELECT timestamp AS LAST_COUNTER_TS  
	FROM COUNTER_DATA  
	JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = COUNTER_DATA.DEVICE_TOKEN  
	WHERE DEVICE_LIST.NAMESPACE_ID = 2  
	ORDER BY timestamp desc LIMIT 1) Q9 ON TRUE
	
	

SELECT DEVICES.DEVICE_NAME,DEVICES.DEVICE_ID,DEVICES.DEVICE_TOKEN, 
TOILET_INFOS.TOILET_NAME AS IDENTIFIER,TOILET_INFOS.TOILET_INFO_ID AS IDENTIFIER_ID, 
DEVICE_TYPES.DEVICE_TYPE_NAME AS NAMESPACE,DEVICE_TYPES.DEVICE_TYPE_ID AS NAMESPACE_ID,  
TOILET_TYPES.TOILET_TYPE_ID  
FROM DEVICE_PAIRS  
JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID  
JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID = DEVICES.DEVICE_TYPE_ID  
JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID  
JOIN TOILET_TYPES ON TOILET_TYPES.TOILET_TYPE_ID = TOILET_INFOS.TOILET_TYPE_ID  
WHERE DEVICE_PAIRS.TOILET_INFO_ID = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984'