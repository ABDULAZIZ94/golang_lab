-- Active: 1722832765629@@alpha.vectolabs.com@9998@smarttoilet-staging


-- get list of devices in this identifier
SELECT DEVICES.DEVICE_NAME,DEVICES.DEVICE_ID,DEVICES.DEVICE_TOKEN,  
		TOILET_INFOS.TOILET_NAME AS Identifier ,DEVICE_TYPES.DEVICE_TYPE_NAME as  Namespace  
FROM DEVICE_PAIRS  
JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID  
JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID = DEVICES.DEVICE_TYPE_ID  
JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID  
WHERE DEVICE_PAIRS.TOILET_INFO_ID = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984'

-- total user reaction for all toilet
-- ADDITIONAL DATA FOR NEW FP
SELECT
    COUNT(
        CASE
            WHEN ur.reaction = '1' THEN 1
        END
    ) AS happy,
    COUNT(
        CASE
            WHEN ur.reaction = '2' THEN 1
        END
    ) AS satisfied,
    COUNT(
        CASE
            WHEN ur.reaction = '3' THEN 1
        END
    ) AS not_satisfied,
    COUNT(
        CASE
            WHEN ur.reaction = '4' THEN 1
        END
    ) AS not_happy,
    COUNT(
        CASE
            WHEN ur.complaint = '1' THEN 1
        END
    ) AS smelly_toilet,
    COUNT(
        CASE
            WHEN ur.complaint = '2' THEN 1
        END
    ) AS out_of_supplies,
    COUNT(
        CASE
            WHEN ur.complaint = '3' THEN 1
        END
    ) AS wet_floor,
    COUNT(
        CASE
            WHEN ur.complaint = '4' THEN 1
        END
    ) AS plumbing_issues
FROM user_reactions ur

select * from user_reactions


-- user reaction towards a toilet identified by toilet id
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

select * from locations

select * from toilet_infos

SELECT ti.LOCATION_ID, loc.location_name
FROM TOILET_INFOS as ti
JOIN LOCATIONS as loc
    ON  ti.location_id = loc. location_id
WHERE
    TOILET_INFO_ID = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984'

-- get overview card data
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
    SELECT LAST_UPDATE,LAST_CLEAN_TIMESTAMP,LAST_AUTOCLEAN_ACTIVE_TIMESTAMP,AVG_CLEANER_RESPONSE_TIME, 
    COALESCE(TTLTRAFFIC ,'0') AS TOTAL_COUNTER,COALESCE(TOTAL_COUNTER_LAST_CLEAN ,'0') AS TOTAL_COUNTER_LAST_CLEAN,TOTAL_AUTOCLEAN_CNT,  
    -- COALESCE(HOURS::text, '0') AS HOURS,  
    IAQ,TMP,LUX , 
    BIN_FULL,BUSUK,URINAL_CLOG,SANITARY_BIN_FULL,PIPE_LEAK,  
    PIPE_LEAK,SLIPPERY,OUT_TISSUE,REFRESH_TOILET,OUT_SOAP,CLOGGED_TOILET  
    FROM  
    (SELECT SUM(people_in) AS TTLTRAFFIC  
    FROM COUNTER_DATA  
    JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = COUNTER_DATA.DEVICE_TOKEN  
    -- WHERE DEVICE_LIST.NAMESPACE_ID = 2 AND DATE(TIMESTAMP) = DATE(NOW())) Q1  
    WHERE DEVICE_LIST.NAMESPACE_ID = 2 AND (TIMESTAMP) >= TO_TIMESTAMP('  2024-07-01   16:00:00','YYYY-MM-DD HH24:MI:SS')) Q1  
    CROSS JOIN  
    (SELECT TIMESTAMP AS LAST_UPDATE,LUX,TEMPERATURE AS TMP,IAQ  
    FROM ENVIROMENT_DATA  
    JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = ENVIROMENT_DATA.DEVICE_TOKEN  
    WHERE DEVICE_LIST.NAMESPACE_ID = 3  
    ORDER BY TIMESTAMP DESC LIMIT 1) Q2  
    CROSS JOIN  
    (SELECT CHECK_OUT_TS as LAST_CLEAN_TIMESTAMP  
    FROM CLEANER_REPORTS  
    WHERE cleaner_reports.TOILET_TYPE_ID = (SELECT TOILET_TYPE_ID FROM TOILET_INFOS WHERE TOILET_INFO_ID = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984' ) order by CHECK_OUT_TS desc limit 1) Q3  
    CROSS JOIN  
    (SELECT AVG(DURATION) AS AVG_CLEANER_RESPONSE_TIME  
    FROM CLEANER_REPORTS  
    WHERE cleaner_reports.TOILET_TYPE_ID = (SELECT TOILET_TYPE_ID FROM TOILET_INFOS WHERE TOILET_INFO_ID = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984')) Q4  
    -- CROSS JOIN  
    -- (SELECT(SELECT ROUND((EXTRACT(EPOCH FROM NOW() - CHECK_OUT_TS::TIMESTAMP) / 3600)::decimal,0) AS HOURS  
    -- FROM cleaner_reports  
    -- WHERE cleaner_reports.TOILET_TYPE_ID = (SELECT TOILET_TYPE_ID FROM TOILET_INFOS WHERE TOILET_INFO_ID = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984' order by CHECK_OUT_TS desc limit 1 ) ) AS HOURS) Q3  
    CROSS JOIN  
    (SELECT COUNT(CASE WHEN BUTTON_ID = 1 THEN 1 END) AS REFRESH_TOILET,  
    COUNT(CASE WHEN BUTTON_ID = 2 THEN 1 END) AS OUT_TISSUE,  
    COUNT(CASE WHEN BUTTON_ID = 3 THEN 1 END) AS BIN_FULL,  
    COUNT(CASE WHEN BUTTON_ID = 4 THEN 1 END) AS OUT_SOAP,  
    COUNT(CASE WHEN BUTTON_ID = 5 THEN 1  END) AS BUSUK,  
    COUNT(CASE WHEN BUTTON_ID = 6 THEN 1 END) AS CLOGGED_TOILET,  
    COUNT(CASE WHEN BUTTON_ID = 7 THEN 1 END) AS URINAL_CLOG,  
    COUNT(CASE WHEN BUTTON_ID = 8 THEN 1 END) AS SLIPPERY,  
    COUNT(CASE WHEN BUTTON_ID = 9 THEN 1 END) AS SANITARY_BIN_FULL,  
    COUNT(CASE WHEN BUTTON_ID = 10 THEN 1 END) AS PIPE_LEAK  
    FROM FEEDBACK_PANEL_DATA  
    -- JOIN DEVICES ON DEVICES.DEVICE_TOKEN = FEEDBACK_PANEL_DATA.DEVICE_TOKEN  
    -- JOIN DEVICE_PAIRS ON DEVICE_PAIRS.DEVICE_ID = DEVICES.DEVICE_ID  
    -- JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID  
    WHERE (TIMESTAMP) >= TO_TIMESTAMP('  2024-07-01   16:00:00','YYYY-MM-DD HH24:MI:SS') AND   
    FEEDBACK_PANEL_DATA.TOILET_TYPE_ID = (SELECT TOILET_TYPE_ID FROM TOILET_INFOS  
    WHERE TOILET_INFOS.TOILET_INFO_ID = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984')  
    AND DEVICE_TOKEN = (SELECT DEVICE_TOKEN FROM DEVICE_LIST WHERE DEVICE_LIST.NAMESPACE_ID = 7)) Q5  
    CROSS JOIN  
    (SELECT COUNT(CASE WHEN AUTO_CLEAN_STATE = '1' THEN 1 END) AS TOTAL_AUTOCLEAN_CNT  
    FROM CLEANER_REPORTS  
    WHERE CLEANER_REPORTS.TOILET_TYPE_ID = (SELECT TOILET_TYPE_ID FROM TOILET_INFOS  
    WHERE TOILET_INFO_ID = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984') AND CLEANER_REPORTS.CREATED_AT >= TO_TIMESTAMP('  2024-07-01   16:00:00','YYYY-MM-DD HH24:MI:SS')) Q6  
    CROSS JOIN  
    (SELECT SUM(PEOPLE_IN) AS TOTAL_COUNTER_LAST_CLEAN  
    FROM COUNTER_DATA  
    JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = COUNTER_DATA.DEVICE_TOKEN  
    WHERE DEVICE_LIST.NAMESPACE_ID = 2  
    AND (TIMESTAMP) >= (SELECT CHECK_OUT_TS FROM CLEANER_REPORTS  
    WHERE CLEANER_REPORTS.TOILET_TYPE_ID = (SELECT TOILET_TYPE_ID FROM TOILET_INFOS WHERE TOILET_INFO_ID = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984' ) order by CHECK_OUT_TS desc limit 1)) Q7  
    CROSS JOIN  
    (SELECT CHECK_OUT_TS as LAST_AUTOCLEAN_ACTIVE_TIMESTAMP  
    FROM CLEANER_REPORTS  
    WHERE cleaner_reports.TOILET_TYPE_ID = (SELECT TOILET_TYPE_ID FROM TOILET_INFOS WHERE TOILET_INFO_ID = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984' )  
    AND AUTO_CLEAN_STATE = '1'  
    order by CHECK_OUT_TS desc limit 1) Q8 

-- time stamp interval / timestamp gen query
SELECT uplinkTS  
FROM generate_series(date_trunc('HOUR', TO_TIMESTAMP('  2024-06-01   16:00:00', 'YYYY-MM-DD HH24:MI:SS')),
-- date_trunc('HOUR', TO_TIMESTAMP('  endDate   16:00:00', 'YYYY-MM-DD HH24:MI:SS')  interval '23' HOUR)  
date_trunc('HOUR', TO_TIMESTAMP('  2024-06-10   15:00:00', 'YYYY-MM-DD HH24:MI:SS')),
interval '1' HOUR) uplinkTS

-- get cleaner graph
WITH GENTIME AS (
    SELECT uplinkTS  
    FROM generate_series(date_trunc('HOUR', TO_TIMESTAMP('  2024-06-01   16:00:00', 'YYYY-MM-DD HH24:MI:SS')),
    -- date_trunc('HOUR', TO_TIMESTAMP('  endDate   16:00:00', 'YYYY-MM-DD HH24:MI:SS')  interval '23' HOUR)  
    date_trunc('HOUR', TO_TIMESTAMP('  2024-06-10   15:00:00', 'YYYY-MM-DD HH24:MI:SS')),
    interval '1' HOUR) uplinkTS)
SELECT uplinkTS::text, 
    COALESCE(TOTAL_MALE,0) AS TOTAL_MALE,  
    COALESCE(TOTAL_FEMALE,0) AS TOTAL_FEMALE  
    FROM GENTIME  
LEFT JOIN  
(SELECT date_trunc('HOUR', CHECK_IN_TS) AS uplinkTS,  
    COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 1 THEN 1 END) TOTAL_MALE,  
    COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 2 THEN 1 END) TOTAL_FEMALE  
    FROM CLEANER_REPORTS  
    WHERE CLEANER_REPORTS.LOCATION_ID = (  
SELECT location_id from toilet_infos where toilet_info_id = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984')  
    GROUP BY uplinkTS) second_query USING (uplinkTS)


-- time stamp interval / timestamp gen query
SELECT uplinkTS  
FROM generate_series(date_trunc('HOUR', TO_TIMESTAMP('  2024-06-01   16:00:00', 'YYYY-MM-DD HH24:MI:SS')),
-- date_trunc('HOUR', TO_TIMESTAMP('  endDate   16:00:00', 'YYYY-MM-DD HH24:MI:SS')  interval '23' HOUR)  
date_trunc('HOUR', TO_TIMESTAMP('  2024-06-10   15:00:00', 'YYYY-MM-DD HH24:MI:SS')),
interval '1' HOUR) uplinkTS
-- cleaning performance
SELECT uplinkTS::text, 
    COALESCE(TOTAL_TIME_MALE,0) AS TOTAL_TIME_MALE,  
    COALESCE(TOTAL_TIME_FEMALE,0) AS TOTAL_TIME_FEMALE,  
    COALESCE(TOTAL_TIME,0) AS TOTAL_TIME  
    FROM GENTIME  
    LEFT JOIN  
    (SELECT date_trunc('HOUR', CHECK_IN_TS) AS uplinkTS,  
    AVG(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 1 THEN duration END) TOTAL_TIME_MALE,  
    AVG(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 2 THEN duration END) TOTAL_TIME_FEMALE,  
    AVG(DURATION) TOTAL_TIME  
    FROM CLEANER_REPORTS  
    WHERE CLEANER_REPORTS.LOCATION_ID = (  
    SELECT location_id from toilet_infos where toilet_info_id = ?)  
    GROUP BY uplinkTS) second_query USING (uplinkTS)


    -- failed sql, worked
    -- 5654c008-dbcc-4656-5601-0a0c50652213: taman bandar kuantan male
WITH
    DEVICE_LIST AS (
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
            DEVICE_PAIRS.TOILET_INFO_ID = '5654c008-dbcc-4656-5601-0a0c50652213'
    )
SELECT
    LAST_UPDATE,
    LAST_CLEAN_TIMESTAMP,
    LAST_AUTOCLEAN_ACTIVE_TIMESTAMP,
    AVG_CLEANER_RESPONSE_TIME,
    COALESCE(TTLTRAFFIC, '0') AS TOTAL_COUNTER,
    COALESCE(TOTAL_COUNTER_LAST_CLEAN, '0') AS TOTAL_COUNTER_LAST_CLEAN,
    TOTAL_AUTOCLEAN_CNT,
    IAQ,
    TMP,
    LUX,
    BIN_FULL,
    BUSUK,
    URINAL_CLOG,
    SANITARY_BIN_FULL,
    PIPE_LEAK,
    PIPE_LEAK,
    SLIPPERY,
    OUT_TISSUE,
    REFRESH_TOILET,
    OUT_SOAP,
    CLOGGED_TOILET AMMONIA_LVL
    FROM (
        SELECT SUM(people_in) AS TTLTRAFFIC
        FROM COUNTER_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = COUNTER_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 2
            AND (TIMESTAMP) >= TO_TIMESTAMP (
                '2024-07-21 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q1
    CROSS JOIN (
        SELECT
            TIMESTAMP AS LAST_UPDATE,
            LUX,
            TEMPERATURE AS TMP,
            IAQ
        FROM
            ENVIROMENT_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = ENVIROMENT_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 3
        ORDER BY TIMESTAMP DESC
        LIMIT 1
    ) Q2
    CROSS JOIN (
        SELECT
            CHECK_OUT_TS as LAST_CLEAN_TIMESTAMP
        FROM CLEANER_REPORTS
        WHERE
            cleaner_reports.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFO_ID = '5654c008-dbcc-4656-5601-0a0c50652213'
            )
        order by CHECK_OUT_TS desc
        limit 1
    ) Q3
    CROSS JOIN (
        SELECT AVG(DURATION) AS AVG_CLEANER_RESPONSE_TIME
        FROM CLEANER_REPORTS
        WHERE
            cleaner_reports.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFO_ID = '5654c008-dbcc-4656-5601-0a0c50652213'
            )
    ) Q4
    CROSS JOIN (
        SELECT
            COUNT(
                CASE
                    WHEN BUTTON_ID = 1 THEN 1
                END
            ) AS REFRESH_TOILET,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 2 THEN 1
                END
            ) AS OUT_TISSUE,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 3 THEN 1
                END
            ) AS BIN_FULL,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 4 THEN 1
                END
            ) AS OUT_SOAP,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 5 THEN 1
                END
            ) AS BUSUK,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 6 THEN 1
                END
            ) AS CLOGGED_TOILET,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 7 THEN 1
                END
            ) AS URINAL_CLOG,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 8 THEN 1
                END
            ) AS SLIPPERY,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 9 THEN 1
                END
            ) AS SANITARY_BIN_FULL,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 10 THEN 1
                END
            ) AS PIPE_LEAK
        FROM FEEDBACK_PANEL_DATA
        WHERE (TIMESTAMP) >= TO_TIMESTAMP (
                '2024-07-21 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
            AND FEEDBACK_PANEL_DATA.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFOS.TOILET_INFO_ID = '5654c008-dbcc-4656-5601-0a0c50652213'
            )
            AND DEVICE_TOKEN = (
                SELECT DEVICE_TOKEN
                FROM DEVICE_LIST
                WHERE
                    DEVICE_LIST.NAMESPACE_ID = 7
            )
    ) Q5
    CROSS JOIN (
        SELECT COUNT(
                CASE
                    WHEN AUTO_CLEAN_STATE = '1' THEN 1
                END
            ) AS TOTAL_AUTOCLEAN_CNT
        FROM CLEANER_REPORTS
        WHERE
            CLEANER_REPORTS.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFO_ID = '5654c008-dbcc-4656-5601-0a0c50652213'
            )
            AND CLEANER_REPORTS.CREATED_AT >= TO_TIMESTAMP (
                '2024-07-21 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q6
    CROSS JOIN (
        SELECT SUM(PEOPLE_IN) AS TOTAL_COUNTER_LAST_CLEAN
        FROM COUNTER_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = COUNTER_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 2
            AND (TIMESTAMP) >= (
                SELECT CHECK_OUT_TS
                FROM CLEANER_REPORTS
                WHERE
                    CLEANER_REPORTS.TOILET_TYPE_ID = (
                        SELECT TOILET_TYPE_ID
                        FROM TOILET_INFOS
                        WHERE
                            TOILET_INFO_ID = '5654c008-dbcc-4656-5601-0a0c50652213'
                    )
                order by CHECK_OUT_TS desc
                limit 1
            )
    ) Q7
    CROSS JOIN (
        SELECT
            CHECK_OUT_TS as LAST_AUTOCLEAN_ACTIVE_TIMESTAMP
        FROM CLEANER_REPORTS
        WHERE
            cleaner_reports.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFO_ID = '5654c008-dbcc-4656-5601-0a0c50652213'
            )
            AND AUTO_CLEAN_STATE = '1'
        order by CHECK_OUT_TS desc
        limit 1
    ) Q8
    LEFT JOIN (
        SELECT
            avg(ammonia_level) as AMMONIA_LVL
            FROM ammonia_data
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = ammonia_data.DEVICE_TOKEN
            WHERE timestamp BETWEEN TO_TIMESTAMP (
                '2024-07-19 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) AND TO_TIMESTAMP  (
                '2024-07-21 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
        GROUP BY
            ammonia_data.device_token
    ) Q10 ON 1=1


-- test left join
    LEFT JOIN (
        SELECT
            avg(ammonia_level) as AMMONIA_LVL
            FROM ammonia_data
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = ammonia_data.DEVICE_TOKEN
            WHERE timestamp BETWEEN TO_TIMESTAMP (
                '2024-07-21 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) AND TO_TIMESTAMP  (
                '2024-07-21 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
        GROUP BY
            ammonia_data.device_token
    ) Q10

        SELECT
            device_token, avg(ammonia_level) as AMMONIA_LVL
            FROM ammonia_data
            WHERE timestamp BETWEEN TO_TIMESTAMP (
                '2024-07-2 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) AND TO_TIMESTAMP  (
                '2024-07-25 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) AND device_token ='77'
        GROUP BY
            ammonia_data.device_token

            
-- test just ammonia data
-- taman bandar kuantan male. 5654c008-dbcc-4656-5601-0a0c50652213
-- zoo teruntum kuantan. female  2a9fbea0-4dca-4af6-457b-348bf682cb54 ammonia device_token = 78

WITH
    DEVICE_LIST AS (
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
            DEVICE_PAIRS.TOILET_INFO_ID = '2a9fbea0-4dca-4af6-457b-348bf682cb54'
    )
SELECT
ammonia_data.device_token, avg(ammonia_level) as AMMONIA_LVL
FROM ammonia_data
JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = ammonia_data.DEVICE_TOKEN
WHERE timestamp BETWEEN TO_TIMESTAMP (
    '2024-07-22 00:00:00',
    'YYYY-MM-DD HH24:MI:SS'
) AND TO_TIMESTAMP  (
    '2024-07-22 23:59:59',
    'YYYY-MM-DD HH24:MI:SS'
)
GROUP BY
ammonia_data.device_token

-- check devices list
-- taman bandar kuantan male: 5654c008-dbcc-4656-5601-0a0c50652213
SELECT
    DEVICES.DEVICE_NAME,
    DEVICES.DEVICE_ID,
    DEVICES.DEVICE_TOKEN,
    TOILET_INFOS.TOILET_NAME AS IDENTIFIER,
    TOILET_INFOS.TOILET_INFO_ID AS IDENTIFIER_ID,
    DEVICE_TYPES.DEVICE_TYPE_NAME AS NAMESPACE,
    DEVICE_TYPES.DEVICE_TYPE_ID AS NAMESPACE_ID,
    TOILET_TYPES.TOILET_TYPE_ID,
    DEVICE_PAIRS.DEVICE_PAIR_ID
FROM
    DEVICE_PAIRS
    JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID
    JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID = DEVICES.DEVICE_TYPE_ID
    JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID
    JOIN TOILET_TYPES ON TOILET_TYPES.TOILET_TYPE_ID = TOILET_INFOS.TOILET_TYPE_ID
WHERE
    DEVICE_PAIRS.TOILET_INFO_ID = '5654c008-dbcc-4656-5601-0a0c50652213'


-- zoo teruntum kuantan male
 WITH
    DEVICE_LIST AS (
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
    )
SELECT
    LAST_UPDATE,
    LAST_CLEAN_TIMESTAMP,
    LAST_AUTOCLEAN_ACTIVE_TIMESTAMP,
    AVG_CLEANER_RESPONSE_TIME,
    COALESCE(TTLTRAFFIC, '0') AS TOTAL_COUNTER,
    COALESCE(TOTAL_COUNTER_LAST_CLEAN, '0') AS TOTAL_COUNTER_LAST_CLEAN,
    TOTAL_AUTOCLEAN_CNT,
    IAQ,
    TMP,
    LUX,
    BIN_FULL,
    BUSUK,
    URINAL_CLOG,
    SANITARY_BIN_FULL,
    PIPE_LEAK,
    PIPE_LEAK,
    SLIPPERY,
    OUT_TISSUE,
    REFRESH_TOILET,
    OUT_SOAP,
    CLOGGED_TOILET,
    AMMONIA_LVL
FROM (
        SELECT SUM(people_in) AS TTLTRAFFIC
        FROM COUNTER_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = COUNTER_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 2
            AND (TIMESTAMP) >= TO_TIMESTAMP(
                '2024-07-21 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q1
    CROSS JOIN (
        SELECT
            TIMESTAMP AS LAST_UPDATE,
            LUX,
            TEMPERATURE AS TMP,
            IAQ
        FROM
            ENVIROMENT_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = ENVIROMENT_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 3
        ORDER BY TIMESTAMP DESC
        LIMIT 1
    ) Q2
    CROSS JOIN (
        SELECT
            CHECK_OUT_TS as LAST_CLEAN_TIMESTAMP
        FROM CLEANER_REPORTS
        WHERE
            cleaner_reports.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFO_ID = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984'
            )
        order by CHECK_OUT_TS desc
        limit 1
    ) Q3
    CROSS JOIN (
        SELECT AVG(DURATION) AS AVG_CLEANER_RESPONSE_TIME
        FROM CLEANER_REPORTS
        WHERE
            cleaner_reports.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFO_ID = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984'
            )
    ) Q4
    CROSS JOIN (
        SELECT
            COUNT(
                CASE
                    WHEN BUTTON_ID = 1 THEN 1
                END
            ) AS REFRESH_TOILET,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 2 THEN 1
                END
            ) AS OUT_TISSUE,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 3 THEN 1
                END
            ) AS BIN_FULL,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 4 THEN 1
                END
            ) AS OUT_SOAP,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 5 THEN 1
                END
            ) AS BUSUK,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 6 THEN 1
                END
            ) AS CLOGGED_TOILET,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 7 THEN 1
                END
            ) AS URINAL_CLOG,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 8 THEN 1
                END
            ) AS SLIPPERY,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 9 THEN 1
                END
            ) AS SANITARY_BIN_FULL,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 10 THEN 1
                END
            ) AS PIPE_LEAK
        FROM FEEDBACK_PANEL_DATA
        WHERE (TIMESTAMP) >= TO_TIMESTAMP(
                '2024-07-21 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
            AND FEEDBACK_PANEL_DATA.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFOS.TOILET_INFO_ID = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984'
            )
            AND DEVICE_TOKEN = (
                SELECT DEVICE_TOKEN
                FROM DEVICE_LIST
                WHERE
                    DEVICE_LIST.NAMESPACE_ID = 7
            )
    ) Q5
    CROSS JOIN (
        SELECT COUNT(
                CASE
                    WHEN AUTO_CLEAN_STATE = '1' THEN 1
                END
            ) AS TOTAL_AUTOCLEAN_CNT
        FROM CLEANER_REPORTS
        WHERE
            CLEANER_REPORTS.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFO_ID = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984'
            )
            AND CLEANER_REPORTS.CREATED_AT >= TO_TIMESTAMP(
                '2024-07-21 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q6
    CROSS JOIN (
        SELECT SUM(PEOPLE_IN) AS TOTAL_COUNTER_LAST_CLEAN
        FROM COUNTER_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = COUNTER_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 2
            AND (TIMESTAMP) >= (
                SELECT CHECK_OUT_TS
                FROM CLEANER_REPORTS
                WHERE
                    CLEANER_REPORTS.TOILET_TYPE_ID = (
                        SELECT TOILET_TYPE_ID
                        FROM TOILET_INFOS
                        WHERE
                            TOILET_INFO_ID = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984'
                    )
                order by CHECK_OUT_TS desc
                limit 1
            )
    ) Q7
    CROSS JOIN (
        SELECT
            CHECK_OUT_TS as LAST_AUTOCLEAN_ACTIVE_TIMESTAMP
        FROM CLEANER_REPORTS
        WHERE
            cleaner_reports.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFO_ID = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984'
            )
            AND AUTO_CLEAN_STATE = '1'
        order by CHECK_OUT_TS desc
        limit 1
    ) Q8
    LEFT JOIN (
    SELECT avg(ammonia_level) as AMMONIA_LVL
    FROM ammonia_data
        JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = ammonia_data.DEVICE_TOKEN
    WHERE
        timestamp BETWEEN TO_TIMESTAMP(
            '2024-07-2 16:00:00',
            'YYYY-MM-DD HH24:MI:SS'
        ) AND TO_TIMESTAMP  (
            '2024-07-25 16:00:00',
            'YYYY-MM-DD HH24:MI:SS'
        )
    GROUP BY
        ammonia_data.device_token
    ) Q10 ON 1=1;
    -- CROSS JOIN (
    --     SELECT avg(ammonia_level) as AMMONIA_LVL
    --     FROM ammonia_data
    --         JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = ammonia_data.DEVICE_TOKEN
    --     WHERE
    --         timestamp BETWEEN TO_TIMESTAMP(
    --             '2024-07-2 16:00:00',
    --             'YYYY-MM-DD HH24:MI:SS'
    --         ) AND TO_TIMESTAMP  (
    --             '2024-07-25 16:00:00',
    --             'YYYY-MM-DD HH24:MI:SS'
    --         )
    --     GROUP BY
    --         ammonia_data.device_token
    -- ) Q10 ;


-- list devices in zooteruntum, male
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


-- failed query 2, works. no comma in golang
WITH
    DEVICE_LIST AS (
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
    )
SELECT
    LAST_UPDATE,
    LAST_CLEAN_TIMESTAMP,
    LAST_AUTOCLEAN_ACTIVE_TIMESTAMP,
    AVG_CLEANER_RESPONSE_TIME,
    COALESCE(TTLTRAFFIC, '0') AS TOTAL_COUNTER,
    COALESCE(TOTAL_COUNTER_LAST_CLEAN, '0') AS TOTAL_COUNTER_LAST_CLEAN,
    TOTAL_AUTOCLEAN_CNT,
    IAQ,
    TMP,
    LUX,
    BIN_FULL,
    BUSUK,
    URINAL_CLOG,
    SANITARY_BIN_FULL,
    PIPE_LEAK,
    PIPE_LEAK,
    SLIPPERY,
    OUT_TISSUE,
    REFRESH_TOILET,
    OUT_SOAP,
    CLOGGED_TOILET,
    AMMONIA_LVL,
    SMOKE_SENSOR,
    PANIC_BTN_STATUS
FROM (
        SELECT SUM(people_in) AS TTLTRAFFIC
        FROM COUNTER_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = COUNTER_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 2
            AND (TIMESTAMP) >= TO_TIMESTAMP(
                '2024-07-21 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q1
    CROSS JOIN (
        SELECT
            TIMESTAMP AS LAST_UPDATE,
            LUX,
            TEMPERATURE AS TMP,
            IAQ
        FROM
            ENVIROMENT_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = ENVIROMENT_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 3
        ORDER BY TIMESTAMP DESC
        LIMIT 1
    ) Q2
    CROSS JOIN (
        SELECT
            CHECK_OUT_TS as LAST_CLEAN_TIMESTAMP
        FROM CLEANER_REPORTS
        WHERE
            cleaner_reports.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFO_ID = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984'
            )
        order by CHECK_OUT_TS desc
        limit 1
    ) Q3
    CROSS JOIN (
        SELECT AVG(DURATION) AS AVG_CLEANER_RESPONSE_TIME
        FROM CLEANER_REPORTS
        WHERE
            cleaner_reports.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFO_ID = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984'
            )
    ) Q4
    CROSS JOIN (
        SELECT
            COUNT(
                CASE
                    WHEN BUTTON_ID = 1 THEN 1
                END
            ) AS REFRESH_TOILET,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 2 THEN 1
                END
            ) AS OUT_TISSUE,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 3 THEN 1
                END
            ) AS BIN_FULL,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 4 THEN 1
                END
            ) AS OUT_SOAP,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 5 THEN 1
                END
            ) AS BUSUK,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 6 THEN 1
                END
            ) AS CLOGGED_TOILET,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 7 THEN 1
                END
            ) AS URINAL_CLOG,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 8 THEN 1
                END
            ) AS SLIPPERY,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 9 THEN 1
                END
            ) AS SANITARY_BIN_FULL,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 10 THEN 1
                END
            ) AS PIPE_LEAK
        FROM FEEDBACK_PANEL_DATA
        WHERE (TIMESTAMP) >= TO_TIMESTAMP(
                '2024-07-21 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
            AND FEEDBACK_PANEL_DATA.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFOS.TOILET_INFO_ID = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984'
            )
            AND DEVICE_TOKEN = (
                SELECT DEVICE_TOKEN
                FROM DEVICE_LIST
                WHERE
                    DEVICE_LIST.NAMESPACE_ID = 7
            )
    ) Q5
    CROSS JOIN (
        SELECT COUNT(
                CASE
                    WHEN AUTO_CLEAN_STATE = '1' THEN 1
                END
            ) AS TOTAL_AUTOCLEAN_CNT
        FROM CLEANER_REPORTS
        WHERE
            CLEANER_REPORTS.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFO_ID = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984'
            )
            AND CLEANER_REPORTS.CREATED_AT >= TO_TIMESTAMP(
                '2024-07-21 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q6
    CROSS JOIN (
        SELECT SUM(PEOPLE_IN) AS TOTAL_COUNTER_LAST_CLEAN
        FROM COUNTER_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = COUNTER_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 2
            AND (TIMESTAMP) >= (
                SELECT CHECK_OUT_TS
                FROM CLEANER_REPORTS
                WHERE
                    CLEANER_REPORTS.TOILET_TYPE_ID = (
                        SELECT TOILET_TYPE_ID
                        FROM TOILET_INFOS
                        WHERE
                            TOILET_INFO_ID = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984'
                    )
                order by CHECK_OUT_TS desc
                limit 1
            )
    ) Q7
    CROSS JOIN (
        SELECT
            CHECK_OUT_TS as LAST_AUTOCLEAN_ACTIVE_TIMESTAMP
        FROM CLEANER_REPORTS
        WHERE
            cleaner_reports.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFO_ID = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984'
            )
            AND AUTO_CLEAN_STATE = '1'
        order by CHECK_OUT_TS desc
        limit 1
    ) Q8
    LEFT JOIN (
        SELECT avg(ammonia_level) as AMMONIA_LVL
        FROM ammonia_data
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = ammonia_data.DEVICE_TOKEN
        WHERE
            timestamp BETWEEN TO_TIMESTAMP(
                '2024-07-21 00:00:01',
                'YYYY-MM-DD HH24:MI:SS'
            ) AND TO_TIMESTAMP(
                '2024-07-22 23:59:59',
                'YYYY-MM-DD HH24:MI:SS'
            )
        GROUP BY
            ammonia_data.device_token
    ) Q10 ON 1 = 1
    LEFT JOIN (
        SELECT SMOKE_SENSOR
        FROM SMOKE_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = SMOKE_DATA.DEVICE_TOKEN
        WHERE TIMESTAMP > TO_TIMESTAMP(
                '2024-07-21 00:00:01',
                'YYYY-MM-DD HH24:MI:SS')
        LIMIT 1
    )Q11 ON 1=1
    LEFT JOIN(
        SELECT PANIC_BUTTON AS PANIC_BTN_STATUS
        FROM PANIC_BTN_DATA
        JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = PANIC_BTN_DATA.DEVICE_TOKEN
        WHERE
        TIMESTAMP > TO_TIMESTAMP(
            '2024-07-21 00:00:01',
            'YYYY-MM-DD HH24:MI:SS'
        )
        ORDER BY TIMESTAMP DESC
        LIMIT 1
    )
    Q12 ON 1=1





    -- test smoke sensor
WITH
    DEVICE_LIST AS (
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
    )
SELECT SMOKE_SENSOR, TIMESTAMP
FROM SMOKE_DATA
    JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = SMOKE_DATA.DEVICE_TOKEN
WHERE TIMESTAMP > TO_TIMESTAMP(
        '2024-07-21 00:00:01',
        'YYYY-MM-DD HH24:MI:SS')
ORDER BY TIMESTAMP DESC
LIMIT 3



-- find error 3
WITH
    DEVICE_LIST AS (
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
    )
SELECT
    LAST_UPDATE,
    LAST_CLEAN_TIMESTAMP,
    LAST_AUTOCLEAN_ACTIVE_TIMESTAMP,
    AVG_CLEANER_RESPONSE_TIME,
    COALESCE(TTLTRAFFIC, '0') AS TOTAL_COUNTER,
    COALESCE(TOTAL_COUNTER_LAST_CLEAN, '0') AS TOTAL_COUNTER_LAST_CLEAN,
    TOTAL_AUTOCLEAN_CNT,
    IAQ,
    TMP,
    LUX,
    BIN_FULL,
    BUSUK,
    URINAL_CLOG,
    SANITARY_BIN_FULL,
    PIPE_LEAK,
    PIPE_LEAK,
    SLIPPERY,
    OUT_TISSUE,
    REFRESH_TOILET,
    OUT_SOAP,
    CLOGGED_TOILET,
    AmmoniaLevel,
    SmokeSensor,
    PanicBtnStatus
FROM (
        SELECT SUM(people_in) AS TTLTRAFFIC
        FROM COUNTER_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = COUNTER_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 2
            AND (TIMESTAMP) >= TO_TIMESTAMP(
                '2024-07-22 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q1
    CROSS JOIN (
        SELECT
            TIMESTAMP AS LAST_UPDATE,
            LUX,
            TEMPERATURE AS TMP,
            IAQ
        FROM
            ENVIROMENT_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = ENVIROMENT_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 3
        ORDER BY TIMESTAMP DESC
        LIMIT 1
    ) Q2
    CROSS JOIN (
        SELECT
            CHECK_OUT_TS as LAST_CLEAN_TIMESTAMP
        FROM CLEANER_REPORTS
        WHERE
            cleaner_reports.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFO_ID = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984'
            )
        order by CHECK_OUT_TS desc
        limit 1
    ) Q3
    CROSS JOIN (
        SELECT AVG(DURATION) AS AVG_CLEANER_RESPONSE_TIME
        FROM CLEANER_REPORTS
        WHERE
            cleaner_reports.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFO_ID = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984'
            )
    ) Q4
    CROSS JOIN (
        SELECT
            COUNT(
                CASE
                    WHEN BUTTON_ID = 1 THEN 1
                END
            ) AS REFRESH_TOILET,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 2 THEN 1
                END
            ) AS OUT_TISSUE,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 3 THEN 1
                END
            ) AS BIN_FULL,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 4 THEN 1
                END
            ) AS OUT_SOAP,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 5 THEN 1
                END
            ) AS BUSUK,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 6 THEN 1
                END
            ) AS CLOGGED_TOILET,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 7 THEN 1
                END
            ) AS URINAL_CLOG,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 8 THEN 1
                END
            ) AS SLIPPERY,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 9 THEN 1
                END
            ) AS SANITARY_BIN_FULL,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 10 THEN 1
                END
            ) AS PIPE_LEAK
        FROM FEEDBACK_PANEL_DATA
        WHERE (TIMESTAMP) >= TO_TIMESTAMP(
                '2024-07-22 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
            AND FEEDBACK_PANEL_DATA.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFOS.TOILET_INFO_ID = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984'
            )
            AND DEVICE_TOKEN = (
                SELECT DEVICE_TOKEN
                FROM DEVICE_LIST
                WHERE
                    DEVICE_LIST.NAMESPACE_ID = 7
            )
    ) Q5
    CROSS JOIN (
        SELECT COUNT(
                CASE
                    WHEN AUTO_CLEAN_STATE = '1' THEN 1
                END
            ) AS TOTAL_AUTOCLEAN_CNT
        FROM CLEANER_REPORTS
        WHERE
            CLEANER_REPORTS.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFO_ID = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984'
            )
            AND CLEANER_REPORTS.CREATED_AT >= TO_TIMESTAMP(
                '2024-07-22 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q6
    CROSS JOIN (
        SELECT SUM(PEOPLE_IN) AS TOTAL_COUNTER_LAST_CLEAN
        FROM COUNTER_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = COUNTER_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 2
            AND (TIMESTAMP) >= (
                SELECT CHECK_OUT_TS
                FROM CLEANER_REPORTS
                WHERE
                    CLEANER_REPORTS.TOILET_TYPE_ID = (
                        SELECT TOILET_TYPE_ID
                        FROM TOILET_INFOS
                        WHERE
                            TOILET_INFO_ID = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984'
                    )
                order by CHECK_OUT_TS desc
                limit 1
            )
    ) Q7
    CROSS JOIN (
        SELECT
            CHECK_OUT_TS as LAST_AUTOCLEAN_ACTIVE_TIMESTAMP
        FROM CLEANER_REPORTS
        WHERE
            cleaner_reports.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFO_ID = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984'
            )
            AND AUTO_CLEAN_STATE = '1'
        order by CHECK_OUT_TS desc
        limit 1
    ) Q8
    LEFT JOIN (
        SELECT avg(ammonia_level) as AmmoniaLevel
        FROM ammonia_data
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = ammonia_data.DEVICE_TOKEN
        WHERE
            timestamp BETWEEN TO_TIMESTAMP(
                '2024-07-22 00:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) AND TO_TIMESTAMP(
                '2024-07-23 23:59:59',
                'YYYY-MM-DD HH24:MI:SS'
            )
        GROUP BY
            ammonia_data.device_token
    ) Q10 ON 1 = 1
    LEFT JOIN (
        SELECT SMOKE_SENSOR as SmokeSensor
        FROM SMOKE_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = SMOKE_DATA.DEVICE_TOKEN
        WHERE
            TIMESTAMP > TO_TIMESTAMP(
                '2024-07-22 00:00:01',
                'YYYY-MM-DD HH24:MI:SS'
            )
        ORDER BY TIMESTAMP DESC
        LIMIT 1
    ) Q11 ON 1 = 1
    LEFT JOIN (
        SELECT PANIC_BUTTON as PanicBtnStatus
        FROM PANIC_BTN_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = PANIC_BTN_DATA.DEVICE_TOKEN
        WHERE
            TIMESTAMP > TO_TIMESTAMP(
                '2024-07-22 00:00:01',
                'YYYY-MM-DD HH24:MI:SS'
            )
        ORDER BY TIMESTAMP DESC
        LIMIT 1
    ) Q12 ON 1 = 1




-- get overview card data
-- fail query
WITH
    DEVICE_LIST AS (
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
            DEVICE_PAIRS.TOILET_INFO_ID = '2a9fbea0-4dca-4af6-457b-348bf682cb54'
    )
SELECT
    LAST_UPDATE,
    LAST_CLEAN_TIMESTAMP,
    LAST_AUTOCLEAN_ACTIVE_TIMESTAMP,
    AVG_CLEANER_RESPONSE_TIME,
    COALESCE(TTLTRAFFIC, '0') AS TOTAL_COUNTER,
    COALESCE(TOTAL_COUNTER_LAST_CLEAN, '0') AS TOTAL_COUNTER_LAST_CLEAN,
    TOTAL_AUTOCLEAN_CNT,
    IAQ,
    TMP,
    LUX,
    BIN_FULL,
    BUSUK,
    URINAL_CLOG,
    SANITARY_BIN_FULL,
    PIPE_LEAK,
    PIPE_LEAK,
    SLIPPERY,
    OUT_TISSUE,
    REFRESH_TOILET,
    OUT_SOAP,
    CLOGGED_TOILET,
    -- COALESCE(AMMONIA_LEVEL, '0')::text AS AMMONIA_LEVEL,
    COALESCE(AMMONIA_LEVEL, '0')::double precision AS AMMONIA_LEVEL,
    -- COALESCE(SMOKE_SENSOR, FALSE) AS SMOKE_SENSOR,
    COALESCE(SMOKE_SENSOR, '0')::text AS SMOKE_SENSOR,
    COALESCE(NULL, TRUE, FALSE)::text AS PANICBTN_STATUS,
    -- COALESCE(PANICBTN_STATUS, '0')::text AS PANICBTN_STATUS,
    -- COALESCE(TOTAL_VIOLATION,0) AS TOTAL_VIOLATION,
    COALESCE(TOTAL_VIOLATION,'0')::text AS TOTAL_VIOLATION,
    -- COALESCE(PANICBTN_PUSHED, 0) AS PANICBTN_PUSHED
    COALESCE(PANICBTN_PUSHED, '0')::text AS PANICBTN_PUSHED
FROM (
        SELECT SUM(people_in) AS TTLTRAFFIC
        FROM COUNTER_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = COUNTER_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 2
            AND (TIMESTAMP) >= TO_TIMESTAMP (
                '2024-07-24 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q1
    CROSS JOIN (
        SELECT
            TIMESTAMP AS LAST_UPDATE,
            LUX,
            TEMPERATURE AS TMP,
            IAQ
        FROM
            ENVIROMENT_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = ENVIROMENT_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 3
        ORDER BY TIMESTAMP DESC
        LIMIT 1
    ) Q2
    CROSS JOIN (
        SELECT
            CHECK_OUT_TS as LAST_CLEAN_TIMESTAMP
        FROM CLEANER_REPORTS
        WHERE
            cleaner_reports.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFO_ID = '2a9fbea0-4dca-4af6-457b-348bf682cb54'
            )
        order by CHECK_OUT_TS desc
        limit 1
    ) Q3
    CROSS JOIN (
        SELECT AVG(DURATION) AS AVG_CLEANER_RESPONSE_TIME
        FROM CLEANER_REPORTS
        WHERE
            cleaner_reports.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFO_ID = '2a9fbea0-4dca-4af6-457b-348bf682cb54'
            )
    ) Q4
    CROSS JOIN (
        SELECT
            COUNT(
                CASE
                    WHEN BUTTON_ID = 1 THEN 1
                END
            ) AS REFRESH_TOILET,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 2 THEN 1
                END
            ) AS OUT_TISSUE,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 3 THEN 1
                END
            ) AS BIN_FULL,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 4 THEN 1
                END
            ) AS OUT_SOAP,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 5 THEN 1
                END
            ) AS BUSUK,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 6 THEN 1
                END
            ) AS CLOGGED_TOILET,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 7 THEN 1
                END
            ) AS URINAL_CLOG,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 8 THEN 1
                END
            ) AS SLIPPERY,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 9 THEN 1
                END
            ) AS SANITARY_BIN_FULL,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 10 THEN 1
                END
            ) AS PIPE_LEAK
        FROM FEEDBACK_PANEL_DATA
        WHERE (TIMESTAMP) >= TO_TIMESTAMP (
                '2024-07-24 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
            AND FEEDBACK_PANEL_DATA.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFOS.TOILET_INFO_ID = '2a9fbea0-4dca-4af6-457b-348bf682cb54'
            )
            AND DEVICE_TOKEN = (
                SELECT DEVICE_TOKEN
                FROM DEVICE_LIST
                WHERE
                    DEVICE_LIST.NAMESPACE_ID = 7
            )
    ) Q5
    CROSS JOIN (
        SELECT COUNT(
                CASE
                    WHEN AUTO_CLEAN_STATE = '1' THEN 1
                END
            ) AS TOTAL_AUTOCLEAN_CNT
        FROM CLEANER_REPORTS
        WHERE
            CLEANER_REPORTS.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFO_ID = '2a9fbea0-4dca-4af6-457b-348bf682cb54'
            )
            AND CLEANER_REPORTS.CREATED_AT >= TO_TIMESTAMP (
                '2024-07-24 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q6
    CROSS JOIN (
        SELECT SUM(PEOPLE_IN) AS TOTAL_COUNTER_LAST_CLEAN
        FROM COUNTER_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = COUNTER_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 2
            AND (TIMESTAMP) >= (
                SELECT CHECK_OUT_TS
                FROM CLEANER_REPORTS
                WHERE
                    CLEANER_REPORTS.TOILET_TYPE_ID = (
                        SELECT TOILET_TYPE_ID
                        FROM TOILET_INFOS
                        WHERE
                            TOILET_INFO_ID = '2a9fbea0-4dca-4af6-457b-348bf682cb54'
                    )
                order by CHECK_OUT_TS desc
                limit 1
            )
    ) Q7
    CROSS JOIN (
        SELECT
            CHECK_OUT_TS as LAST_AUTOCLEAN_ACTIVE_TIMESTAMP
        FROM CLEANER_REPORTS
        WHERE
            cleaner_reports.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFO_ID = '2a9fbea0-4dca-4af6-457b-348bf682cb54'
            )
            AND AUTO_CLEAN_STATE = '1'
        order by CHECK_OUT_TS desc
        limit 1
    ) Q8
    LEFT JOIN (
        SELECT avg(ammonia_level) as AMMONIA_LEVEL
        FROM ammonia_data
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = ammonia_data.DEVICE_TOKEN
        WHERE
            timestamp BETWEEN TO_TIMESTAMP (
                '2024-07-24 00:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) AND TO_TIMESTAMP  (
                '2024-07-25 23:59:59',
                'YYYY-MM-DD HH24:MI:SS'
            )
        GROUP BY
            ammonia_data.device_token
    ) Q10 ON 1 = 1
    LEFT JOIN (
        SELECT SMOKE_SENSOR as SMOKE_SENSOR
        FROM SMOKE_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = SMOKE_DATA.DEVICE_TOKEN
        WHERE
            TIMESTAMP > TO_TIMESTAMP (
                '2024-07-24 00:00:01',
                'YYYY-MM-DD HH24:MI:SS'
            )
        ORDER BY TIMESTAMP DESC
        LIMIT 1
    ) Q11 ON 1 = 1
    LEFT JOIN (
        SELECT PANIC_BUTTON as PANICBTN_STATUS
        FROM PANIC_BTN_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = PANIC_BTN_DATA.DEVICE_TOKEN
        WHERE
            TIMESTAMP > TO_TIMESTAMP (
                '2024-07-24 00:00:01',
                'YYYY-MM-DD HH24:MI:SS'
            )
        ORDER BY TIMESTAMP DESC
        LIMIT 1
    ) Q12 ON 1 = 1
    LEFT JOIN (
        select count(id) as TOTAL_VIOLATION
        from violation_data
        where
            created_at BETWEEN to_timestamp (
                '2024-07-25 00:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and to_timestamp  (
                '2024-07-25 23:59:59',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q13 ON 1 = 1
    LEFT JOIN (
        select count(
                CASE
                    WHEN panic_button = TRUE
                    AND prev_state = FALSE THEN 1
                END
            ) as PANICBTN_PUSHED
        from (
                SELECT panic_button, timestamp, LAG(panic_button, 1) OVER (
                        ORDER BY id
                    ) prev_state
                from panic_btn_data
            )
        where
            timestamp BETWEEN to_timestamp (
                '2024-07-25 00:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and to_timestamp  (
                '2024-07-25 23:59:59',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q14 ON 1 = 1


    -- fail query 1/8/2024 overview
    WITH
    DEVICE_LIST AS (
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
            DEVICE_PAIRS.TOILET_INFO_ID = '5654c008-dbcc-4656-5601-0a0c50652213'
    )
SELECT
    LAST_UPDATE,
    LAST_CLEAN_TIMESTAMP,
    LAST_AUTOCLEAN_ACTIVE_TIMESTAMP,
    AVG_CLEANER_RESPONSE_TIME,
    COALESCE(TTLTRAFFIC, '0') AS TOTAL_COUNTER,
    COALESCE(TOTAL_COUNTER_LAST_CLEAN, '0') AS TOTAL_COUNTER_LAST_CLEAN,
    TOTAL_AUTOCLEAN_CNT,
    IAQ,
    TMP,
    LUX,
    BIN_FULL,
    BUSUK,
    URINAL_CLOG,
    SANITARY_BIN_FULL,
    PIPE_LEAK,
    PIPE_LEAK,
    SLIPPERY,
    OUT_TISSUE,
    REFRESH_TOILET,
    OUT_SOAP,
    CLOGGED_TOILET,
    AMMONIA_LEVEL,
    SMOKE_SENSOR,
    PANICBTN_STATUS
FROM (
        SELECT SUM(people_in) AS TTLTRAFFIC
        FROM COUNTER_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = COUNTER_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 2
            AND (TIMESTAMP) >= TO_TIMESTAMP (
                '2024-08-01 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q1
    CROSS JOIN (
        SELECT
            TIMESTAMP AS LAST_UPDATE,
            LUX,
            TEMPERATURE AS TMP,
            IAQ
        FROM
            ENVIROMENT_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = ENVIROMENT_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 3
        ORDER BY TIMESTAMP DESC
        LIMIT 1
    ) Q2
    CROSS JOIN (
        SELECT
            CHECK_OUT_TS as LAST_CLEAN_TIMESTAMP
        FROM CLEANER_REPORTS
        WHERE
            cleaner_reports.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFO_ID = '5654c008-dbcc-4656-5601-0a0c50652213'
            )
        order by CHECK_OUT_TS desc
        limit 1
    ) Q3
    CROSS JOIN (
        SELECT AVG(DURATION) AS AVG_CLEANER_RESPONSE_TIME
        FROM CLEANER_REPORTS
        WHERE
            cleaner_reports.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFO_ID = '5654c008-dbcc-4656-5601-0a0c50652213'
            )
    ) Q4
    CROSS JOIN (
        SELECT
            COUNT(
                CASE
                    WHEN BUTTON_ID = 1 THEN 1
                END
            ) AS REFRESH_TOILET,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 2 THEN 1
                END
            ) AS OUT_TISSUE,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 3 THEN 1
                END
            ) AS BIN_FULL,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 4 THEN 1
                END
            ) AS OUT_SOAP,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 5 THEN 1
                END
            ) AS BUSUK,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 6 THEN 1
                END
            ) AS CLOGGED_TOILET,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 7 THEN 1
                END
            ) AS URINAL_CLOG,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 8 THEN 1
                END
            ) AS SLIPPERY,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 9 THEN 1
                END
            ) AS SANITARY_BIN_FULL,
            COUNT(
                CASE
                    WHEN BUTTON_ID = 10 THEN 1
                END
            ) AS PIPE_LEAK
        FROM FEEDBACK_PANEL_DATA
        WHERE (TIMESTAMP) >= TO_TIMESTAMP (
                '2024-07-31 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
            AND FEEDBACK_PANEL_DATA.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFOS.TOILET_INFO_ID = '5654c008-dbcc-4656-5601-0a0c50652213'
            )
            AND DEVICE_TOKEN = (
                SELECT DEVICE_TOKEN
                FROM DEVICE_LIST
                WHERE
                    DEVICE_LIST.NAMESPACE_ID = 7
            )
    ) Q5
    CROSS JOIN (
        SELECT COUNT(
                CASE
                    WHEN AUTO_CLEAN_STATE = '1' THEN 1
                END
            ) AS TOTAL_AUTOCLEAN_CNT
        FROM CLEANER_REPORTS
        WHERE
            CLEANER_REPORTS.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFO_ID = '5654c008-dbcc-4656-5601-0a0c50652213'
            )
            AND CLEANER_REPORTS.CREATED_AT >= TO_TIMESTAMP (
                '2024-08-01 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q6
    CROSS JOIN (
        SELECT SUM(PEOPLE_IN) AS TOTAL_COUNTER_LAST_CLEAN
        FROM COUNTER_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = COUNTER_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 2
            AND (TIMESTAMP) >= (
                SELECT CHECK_OUT_TS
                FROM CLEANER_REPORTS
                WHERE
                    CLEANER_REPORTS.TOILET_TYPE_ID = (
                        SELECT TOILET_TYPE_ID
                        FROM TOILET_INFOS
                        WHERE
                            TOILET_INFO_ID = '5654c008-dbcc-4656-5601-0a0c50652213'
                    )
                order by CHECK_OUT_TS desc
                limit 1
            )
    ) Q7
    CROSS JOIN (
        SELECT
            CHECK_OUT_TS as LAST_AUTOCLEAN_ACTIVE_TIMESTAMP
        FROM CLEANER_REPORTS
        WHERE
            cleaner_reports.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFO_ID = '5654c008-dbcc-4656-5601-0a0c50652213'
            )
            AND AUTO_CLEAN_STATE = '1'
        order by CHECK_OUT_TS desc
        limit 1
    ) Q8
    LEFT JOIN (
        SELECT avg(ammonia_level) as AMMONIA_LEVEL
        FROM ammonia_data
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = ammonia_data.DEVICE_TOKEN
        WHERE
            timestamp BETWEEN TO_TIMESTAMP (
                '2024-08-01 00:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) AND TO_TIMESTAMP  (
                '2024-08-01 23:59:59',
                'YYYY-MM-DD HH24:MI:SS'
            )
        GROUP BY
            ammonia_data.device_token
    ) Q10 ON 1 = 1
    LEFT JOIN (
        SELECT SMOKE_SENSOR as SMOKE_SENSOR
        FROM SMOKE_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = SMOKE_DATA.DEVICE_TOKEN
        WHERE
            TIMESTAMP > TO_TIMESTAMP (
                '2024-08-01 00:00:01',
                'YYYY-MM-DD HH24:MI:SS'
            )
        ORDER BY TIMESTAMP DESC
        LIMIT 1
    ) Q11 ON 1 = 1
    LEFT JOIN (
        SELECT PANIC_BUTTON as PANICBTN_STATUS
        FROM PANIC_BTN_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = PANIC_BTN_DATA.DEVICE_TOKEN
        WHERE
            TIMESTAMP > TO_TIMESTAMP (
                '2024-08-01 00:00:01',
                'YYYY-MM-DD HH24:MI:SS'
            )
        ORDER BY TIMESTAMP DESC
        LIMIT 1
    ) Q12 ON 1 = 1
    LEFT JOIN (
        select count(id) as TOTAL_VIOLATION
        from violation_data
        where
            created_at BETWEEN to_timestamp (
                '2024-08-01 00:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and to_timestamp  (
                '2024-08-01 23:59:59',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q13 ON 1 = 1
    LEFT JOIN (
        select count(
                CASE
                    WHEN panic_button = TRUE
                    AND prev_state = FALSE THEN 1
                END
            ) as PANICBTN_PUSHED
        from (
                SELECT panic_button, timestamp, LAG(panic_button, 1) OVER (
                        ORDER BY id
                    ) prev_state
                from panic_btn_data
            ) S1
        where
            timestamp BETWEEN to_timestamp (
                '2024-08-01 00:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and to_timestamp  (
                '2024-08-01 23:59:59',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q14 ON 1 = 1



-- overview data
 WITH DEVICE_LIST AS (
    SELECT DEVICES.DEVICE_NAME,DEVICES.DEVICE_ID,
    DEVICES.DEVICE_TOKEN,TOILET_INFOS.TOILET_NAME AS IDENTIFIER,
    TOILET_INFOS.TOILET_INFO_ID AS IDENTIFIER_ID,
    DEVICE_TYPES.DEVICE_TYPE_NAME AS NAMESPACE,
    DEVICE_TYPES.DEVICE_TYPE_ID AS NAMESPACE_ID, 
    TOILET_TYPES.TOILET_TYPE_ID 
    FROM DEVICE_PAIRS 
    JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID 
    JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID = DEVICES.DEVICE_TYPE_ID 
    JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID 
    JOIN TOILET_TYPES ON TOILET_TYPES.TOILET_TYPE_ID = TOILET_INFOS.TOILET_TYPE_ID 
    WHERE DEVICE_PAIRS.TOILET_INFO_ID = '36f74ec4-cdb0-4271-6c2d-2baa48d6e583')
SELECT 
    LAST_UPDATE,
    LAST_CLEAN_TIMESTAMP,
    LAST_AUTOCLEAN_ACTIVE_TIMESTAMP,
    AVG_CLEANER_RESPONSE_TIME,
    COALESCE(TTLTRAFFIC ,'0') AS TOTAL_COUNTER,
    COALESCE(TOTAL_COUNTER_LAST_CLEAN ,'0') AS TOTAL_COUNTER_LAST_CLEAN,
    TOTAL_AUTOCLEAN_CNT, 
    IAQ,
    TMP,
    LUX ,
    BIN_FULL,
    BUSUK,
    URINAL_CLOG,
    SANITARY_BIN_FULL,
    PIPE_LEAK, 
    PIPE_LEAK,
    SLIPPERY,
    OUT_TISSUE,
    REFRESH_TOILET,
    OUT_SOAP,
    CLOGGED_TOILET, 
    COALESCE(AMMONIA_LEVEL, 0.0) AS AMMONIA_LEVEL, 
    COALESCE(SMOKE_SENSOR, FALSE) AS SMOKE_SENSOR, 
    COALESCE(PANICBTN_STATUS, FALSE) AS PANICBTN_STATUS, 
    COALESCE(TOTAL_VIOLATION,0) AS TOTAL_VIOLATION, 
    COALESCE(PANICBTN_PUSHED, 0) AS PANICBTN_PUSHED 
FROM (SELECT SUM(people_in) AS TTLTRAFFIC 
    FROM COUNTER_DATA 
    JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = COUNTER_DATA.DEVICE_TOKEN 
    WHERE DEVICE_LIST.NAMESPACE_ID = 2 AND 
    (TIMESTAMP) BETWEEN TO_TIMESTAMP('2024-08-13 07:00:00','YYYY-MM-DD HH24:MI:SS') AND TO_TIMESTAMP('2024-08-13 18:00:00','YYYY-MM-DD HH24:MI:SS') )Q1
 CROSS JOIN 
    (SELECT TIMESTAMP AS LAST_UPDATE,LUX,TEMPERATURE AS TMP,IAQ 
    FROM ENVIROMENT_DATA JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = ENVIROMENT_DATA.DEVICE_TOKEN 
    WHERE DEVICE_LIST.NAMESPACE_ID = 3 ORDER BY TIMESTAMP DESC LIMIT 1) Q2 
 CROSS JOIN 
    (SELECT CHECK_OUT_TS as LAST_CLEAN_TIMESTAMP FROM CLEANER_REPORTS WHERE cleaner_reports.TOILET_TYPE_ID = (SELECT TOILET_TYPE_ID FROM TOILET_INFOS WHERE TOILET_INFO_ID = '36f74ec4-cdb0-4271-6c2d-2baa48d6e583' ) order by CHECK_OUT_TS desc limit 1) Q3 
CROSS JOIN (SELECT AVG(DURATION) AS AVG_CLEANER_RESPONSE_TIME 
    FROM CLEANER_REPORTS WHERE cleaner_reports.TOILET_TYPE_ID = (SELECT TOILET_TYPE_ID FROM TOILET_INFOS WHERE TOILET_INFO_ID = '36f74ec4-cdb0-4271-6c2d-2baa48d6e583')) Q4 
CROSS JOIN (SELECT COUNT(CASE WHEN BUTTON_ID = 1 THEN 1 END) AS REFRESH_TOILET, 
    COUNT(CASE WHEN BUTTON_ID = 2 THEN 1 END) AS OUT_TISSUE, 
    COUNT(CASE WHEN BUTTON_ID = 3 THEN 1 END) AS BIN_FULL, 
    COUNT(CASE WHEN BUTTON_ID = 4 THEN 1 END) AS OUT_SOAP, 
    COUNT(CASE WHEN BUTTON_ID = 5 THEN 1  END) AS BUSUK, 
    COUNT(CASE WHEN BUTTON_ID = 6 THEN 1 END) AS CLOGGED_TOILET, 
    COUNT(CASE WHEN BUTTON_ID = 7 THEN 1 END) AS URINAL_CLOG, 
    COUNT(CASE WHEN BUTTON_ID = 8 THEN 1 END) AS SLIPPERY, 
    COUNT(CASE WHEN BUTTON_ID = 9 THEN 1 END) AS SANITARY_BIN_FULL, 
    COUNT(CASE WHEN BUTTON_ID = 10 THEN 1 END) AS PIPE_LEAK 
    FROM FEEDBACK_PANEL_DATA WHERE (TIMESTAMP) >= TO_TIMESTAMP('2024-08-12 16:00:00','YYYY-MM-DD HH24:MI:SS') AND 
    FEEDBACK_PANEL_DATA.TOILET_TYPE_ID = (SELECT TOILET_TYPE_ID FROM TOILET_INFOS WHERE TOILET_INFOS.TOILET_INFO_ID = '36f74ec4-cdb0-4271-6c2d-2baa48d6e583') 
    AND DEVICE_TOKEN = (SELECT DEVICE_TOKEN FROM DEVICE_LIST WHERE DEVICE_LIST.NAMESPACE_ID = 7)) Q5 
CROSS JOIN (SELECT COUNT(CASE WHEN AUTO_CLEAN_STATE = '1' THEN 1 END) AS TOTAL_AUTOCLEAN_CNT FROM CLEANER_REPORTS WHERE CLEANER_REPORTS.TOILET_TYPE_ID = 
    (SELECT TOILET_TYPE_ID FROM TOILET_INFOS WHERE TOILET_INFO_ID = '36f74ec4-cdb0-4271-6c2d-2baa48d6e583') 
    AND CLEANER_REPORTS.CREATED_AT BETWEEN TO_TIMESTAMP('2024-08-13 07:00:00','YYYY-MM-DD HH24:MI:SS') AND TO_TIMESTAMP('2024-08-13 07:00:00','YYYY-MM-DD HH24:MI:SS') ) Q6 
CROSS JOIN (SELECT SUM(PEOPLE_IN) AS TOTAL_COUNTER_LAST_CLEAN FROM COUNTER_DATA JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = COUNTER_DATA.DEVICE_TOKEN WHERE DEVICE_LIST.NAMESPACE_ID = 2 AND (TIMESTAMP) >= 
    (SELECT CHECK_OUT_TS FROM CLEANER_REPORTS WHERE CLEANER_REPORTS.TOILET_TYPE_ID = (SELECT TOILET_TYPE_ID FROM TOILET_INFOS WHERE TOILET_INFO_ID = '36f74ec4-cdb0-4271-6c2d-2baa48d6e583' ) 
    order by CHECK_OUT_TS desc limit 1)) Q7 
CROSS JOIN (SELECT CHECK_OUT_TS as LAST_AUTOCLEAN_ACTIVE_TIMESTAMP FROM CLEANER_REPORTS WHERE cleaner_reports.TOILET_TYPE_ID = (SELECT TOILET_TYPE_ID FROM TOILET_INFOS WHERE TOILET_INFO_ID = '36f74ec4-cdb0-4271-6c2d-2baa48d6e583' ) AND AUTO_CLEAN_STATE = '1' order by CHECK_OUT_TS desc limit 1) Q8 LEFT JOIN (SELECT avg(ammonia_level) as AMMONIA_LEVEL FROM ammonia_data JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = ammonia_data.DEVICE_TOKEN WHERE timestamp BETWEEN TO_TIMESTAMP('2024-08-13 07:00:00','YYYY-MM-DD HH24:MI:SS') AND TO_TIMESTAMP('2024-08-13 18:00:00','YYYY-MM-DD HH24:MI:SS') GROUP BY ammonia_data.device_token ) Q10 ON 1=1 LEFT JOIN (SELECT SMOKE_SENSOR as SMOKE_SENSOR FROM SMOKE_DATA JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = SMOKE_DATA.DEVICE_TOKEN WHERE TIMESTAMP BETWEEN TO_TIMESTAMP ('2024-08-13 07:00:00','YYYY-MM-DD HH24:MI:SS') AND TO_TIMESTAMP ('2024-08-13 18:00:00','YYYY-MM-DD HH24:MI:SS') ORDER BY TIMESTAMP DESC LIMIT 1) Q11 ON 1=1 LEFT JOIN (SELECT PANIC_BUTTON as PANICBTN_STATUS FROM PANIC_BTN_DATA JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = PANIC_BTN_DATA.DEVICE_TOKEN WHERE TIMESTAMP BETWEEN TO_TIMESTAMP ('2024-08-13 07:00:00','YYYY-MM-DD HH24:MI:SS') AND TO_TIMESTAMP ('2024-08-13 18:00:00','YYYY-MM-DD HH24:MI:SS')
    ORDER BY TIMESTAMP DESC LIMIT 1) Q12 ON 1=1 LEFT JOIN (select count(id) as TOTAL_VIOLATION from violation_data where created_at BETWEEN to_timestamp('2024-08-13 07:00:00', 'YYYY-MM-DD HH24:MI:SS') and to_timestamp('2024-08-13 18:00:00', 'YYYY-MM-DD HH24:MI:SS') ) Q13 ON 1=1 LEFT JOIN (select count( CASE WHEN panic_button = TRUE AND prev_state = FALSE THEN 1 END ) as PANICBTN_PUSHED from (SELECT panic_button, timestamp, LAG(panic_button, 1) OVER ( ORDER BY id) prev_state from panic_btn_data) S1 where timestamp BETWEEN to_timestamp('2024-08-13 07:00:00', 'YYYY-MM-DD HH24:MI:SS') and to_timestamp('2024-08-13 18:00:00', 'YYYY-MM-DD HH24:MI:SS')) Q14 ON 1=1  


-- new overview query
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
WHERE DEVICES.TENANT_ID = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'),
TOILET_LIST as (SELECT ti.toilet_info_id  
FROM toilet_infos ti  
where tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd')
select * from toilet_list tl
join device_list dl on tl.toilet_info_id = dl.IDENTIFIER_ID

--
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
WHERE DEVICES.TENANT_ID = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'),
TOILET_LIST as (SELECT ti.toilet_info_id  
FROM toilet_infos ti  
where tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd')
SELECT
    COALESCE(TOTAL_VIOLATION, 0) AS TOTAL_VIOLATION,
    COALESCE(CURRENT_AMMONIA_LEVEL, 0.0) AS CURRENT_AMMONIA_LEVEL,
    COALESCE(PANICBTN_PUSHED, 0) AS PANICBTN_PUSHED,
    AVG_CLEANER_RESPONSE_TIME, --ok
    LAST_CLEAN_TIMESTAMP, -- ok
    LAST_AUTOCLEAN_ACTIVE_TIMESTAMP,
    TOTAL_COLLECTIONS
FROM
(
    SELECT CHECK_OUT_TS AS LAST_CLEAN_TIMESTAMP 
    FROM CLEANER_REPORTS 
    WHERE CLEANER_REPORTS.TENANT_ID = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'
    ORDER BY CHECK_OUT_TS DESC 
    LIMIT 1
) Q1 
CROSS JOIN 
(
    SELECT AVG(DURATION) AS AVG_CLEANER_RESPONSE_TIME 
    FROM CLEANER_REPORTS WHERE CLEANER_REPORTS.TENANT_ID = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'
) Q2 
CROSS JOIN 
(
    SELECT CHECK_OUT_TS AS LAST_AUTOCLEAN_ACTIVE_TIMESTAMP 
    FROM CLEANER_REPORTS 
    WHERE CLEANER_REPORTS.TENANT_ID = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'
    AND AUTO_CLEAN_STATE = '1' 
    ORDER BY CHECK_OUT_TS DESC 
    LIMIT 1
) Q3 
LEFT JOIN 
(
    SELECT AVG(ammonia_level) AS CURRENT_AMMONIA_LEVEL
    FROM ammonia_data JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = ammonia_data.DEVICE_TOKEN
    GROUP BY ammonia_data.device_token, timestamp
    ORDER BY timestamp desc LIMIT 1
) Q10 ON 1=1 
LEFT JOIN 
(
    SELECT COUNT(id) AS TOTAL_VIOLATION 
    FROM violation_data 
    JOIN device_list on device_list.device_id = violation_data.device_id
    WHERE created_at BETWEEN TO_TIMESTAMP('2024-08-14 07:00:00','YYYY-MM-DD HH24:MI:SS') 
    AND TO_TIMESTAMP('2024-08-14 18:00:00','YYYY-MM-DD HH24:MI:SS')
) Q4 ON 1=1 
LEFT JOIN 
(
    SELECT COUNT(CASE WHEN panic_button = TRUE AND prev_state = FALSE THEN 1 END) AS PANICBTN_PUSHED 
    FROM 
    (
        SELECT panic_button, timestamp, 
        LAG(panic_button, 1) OVER (ORDER BY id) AS prev_state 
        FROM panic_btn_data
    ) S1 
    WHERE timestamp BETWEEN TO_TIMESTAMP('2024-08-14 07:00:00','YYYY-MM-DD HH24:MI:SS') 
    AND TO_TIMESTAMP('2024-08-14 18:00:00','YYYY-MM-DD HH24:MI:SS')
) Q5 ON 1=1
LEFT JOIN
(
    select sum(ammount) as TOTAL_COLLECTIONS
    from money_data
    where
    created_at BETWEEN TO_TIMESTAMP(
        '2024-08-14 07:00:00',
        'YYYY-MM-DD HH24:MI:SS'
    ) AND TO_TIMESTAMP(
        '2024-08-14 18:00:00',
        'YYYY-MM-DD HH24:MI:SS'
    )
)Q6 ON 1=1
-- test

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
WHERE DEVICES.TENANT_ID = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd')
SELECT AVG(ammonia_level) AS AMMONIA_LEVEL
FROM ammonia_data
    JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = ammonia_data.DEVICE_TOKEN
GROUP BY
    ammonia_data.device_token, timestamp
ORDER BY timestamp desc
LIMIT 1

select * from toilet_infos



-- fail query

WITH
    GENTIME as (
        SELECT uplinkTS
        FROM generate_series(
                date_trunc(
                    'HOUR', TO_TIMESTAMP(
                        '2024-08-14 07:00:00', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), date_trunc(
                    'HOUR', TO_TIMESTAMP(
                        '2024-08-14 18:00:00', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), interval '1' HOUR
            ) uplinkTS
    )
SELECT
    uplinkTS::text,
    COALESCE(TOTAL_MALE, 0) AS TOTAL_MALE,
    COALESCE(TOTAL_FEMALE, 0) AS TOTAL_FEMALE
FROM GENTIME
    LEFT JOIN (
        SELECT
            date_trunc('HOUR', CHECK_IN_TS) AS uplinkTS, COUNT(
                CASE
                    WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 1 THEN 1
                END
            ) TOTAL_MALE, COUNT(
                CASE
                    WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 2 THEN 1
                END
            ) TOTAL_FEMALE
        FROM CLEANER_REPORTS
        WHERE tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'
        GROUP BY
            uplinkTS
    ) second_query USING (uplinkTS)


    --

WITH
GENTIME as (
    SELECT uplinkTS
    FROM generate_series(
            date_trunc(
                'HOUR', TO_TIMESTAMP(
                    '2024-08-14 07:00:00', 'YYYY-MM-DD HH24:MI:SS'
                )
            ), date_trunc(
                'HOUR', TO_TIMESTAMP(
                    '2024-08-14 18:00:00', 'YYYY-MM-DD HH24:MI:SS'
                )
            ), interval '1' HOUR
        ) uplinkTS
)
SELECT
    uplinkTS::text,
    COALESCE(TOTAL_MALE, 0) AS TOTAL_MALE,
    COALESCE(TOTAL_FEMALE, 0) AS TOTAL_FEMALE
FROM GENTIME
LEFT JOIN (
    SELECT
        date_trunc('HOUR', CHECK_IN_TS)AS uplinkTS,
        COUNT(
            CASE
                WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 1 THEN 1
            END
        ) TOTAL_MALE, COUNT(
            CASE
                WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 2 THEN 1
            END
        ) TOTAL_FEMALE
    FROM CLEANER_REPORTS
    WHERE
        CLEANER_REPORTS.tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'
    GROUP BY
        uplinkTS
) Q1 USING (uplinkTS)


-- ammonia lvl
WITH
    DEVICE_LIST AS (
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
            DEVICES.TENANT_ID = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'
    ),
    GENTIME as (
        SELECT uplinkTS
        FROM generate_series(
                date_trunc(
                    'HOUR', TO_TIMESTAMP(
                        '2024-08-14 07:00:00', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), date_trunc(
                    'HOUR', TO_TIMESTAMP(
                        '2024-08-14 18:00:00', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), interval '1' HOUR
            ) uplinkTS
    )
SELECT DISTINCT
    uplinkTS,
    avg(ammonia_level) as ammonia_level
FROM (
        SELECT date_trunc('HOUR', timestamp)::TIMESTAMP AS uplinkTS, ammonia_level
        FROM ammonia_data
        WHERE
            device_token IN (
                SELECT DEVICE_TOKEN
                FROM DEVICE_LIST
            )
        GROUP BY
            uplinkTS, ammonia_level
    ) Q1
    RIGHT JOIN GENTIME USING (uplinkTS)
GROUP BY
    uplinkTS


-- cleaner performance
WITH
    GENTIME as (
        SELECT uplinkTS
        FROM generate_series(
                date_trunc(
                    'HOUR', TO_TIMESTAMP(
                        '2024-08-14 07:00:00', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), date_trunc(
                    'HOUR', TO_TIMESTAMP(
                        '2024-08-14 18:00:00', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), interval '1' HOUR
            ) uplinkTS
    )
SELECT
    uplinkTS::text,
    COALESCE(TOTAL_TIME_MALE, 0) AS TOTAL_TIME_MALE,
    COALESCE(TOTAL_TIME_FEMALE, 0) AS TOTAL_TIME_FEMALE,
    COALESCE(TOTAL_TIME, 0) AS TOTAL_TIME
FROM GENTIME
    LEFT JOIN (
        SELECT
            date_trunc('HOUR', CHECK_IN_TS) AS uplinkTS, AVG(
                CASE
                    WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 1 THEN duration
                END
            ) TOTAL_TIME_MALE, AVG(
                CASE
                    WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 2 THEN duration
                END
            ) TOTAL_TIME_FEMALE, AVG(DURATION) TOTAL_TIME
        FROM CLEANER_REPORTS
        WHERE
            CLEANER_REPORTS.tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'
        GROUP BY
            uplinkTS
    ) second_query USING (uplinkTS)




    -- fail
    WITH
    GENTIME as (
        SELECT uplinkTS
        FROM generate_series(
                date_trunc(
                    'HOUR', TO_TIMESTAMP(
                        '2024-08-14 07:00:00', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), date_trunc(
                    'HOUR', TO_TIMESTAMP(
                        '2024-08-14 18:00:00', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), interval '1' HOUR
            ) uplinkTS
    )
SELECT COALESCE(TOTAL_MALE, 0) AS TOTAL_MALE, COALESCE(TOTAL_FEMALE, 0) AS TOTAL_FEMALE
FROM GENTIME
    LEFT JOIN (
        SELECT
            date_trunc('HOUR', CHECK_IN_TS) AS uplinkTS, COUNT(
                CASE
                    WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 1 THEN 1
                END
            ) TOTAL_MALE, COUNT(
                CASE
                    WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 2 THEN 1
                END
            ) TOTAL_FEMALE
        FROM CLEANER_REPORTS
        WHERE
            CLEANER_REPORTS.tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'
        GROUP BY
            uplinkTS
    ) second_query USING (uplinkTS)


    -- fail
WITH
    GENTIME as (
        SELECT uplinkTS
        FROM generate_series(
                date_trunc(
                    'HOUR', TO_TIMESTAMP(
                        '2024-08-14 07:00:00', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), date_trunc(
                    'HOUR', TO_TIMESTAMP(
                        '2024-08-14 18:00:00', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), interval '1' HOUR
            ) uplinkTS
    )
SELECT UplinkTS, COALESCE(TOTAL_MALE, 0) AS TOTAL_MALE, COALESCE(TOTAL_FEMALE, 0) AS TOTAL_FEMALE
FROM GENTIME
LEFT JOIN 
    (SELECT
        date_trunc('HOUR', CHECK_IN_TS) AS uplinkTS, COUNT(
            CASE
                WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 1 THEN 1
            END
        ) TOTAL_MALE, COUNT(
            CASE
                WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 2 THEN 1
            END
        ) TOTAL_FEMALE
    FROM CLEANER_REPORTS
    WHERE
        CLEANER_REPORTS.tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'
    GROUP BY
        uplinkTS
    )Q1 using (UplinkTs)