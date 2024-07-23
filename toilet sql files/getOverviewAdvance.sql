-- Active: 1720683458566@@127.0.0.1@5432@smarttoilet

-- getoverview advance data 
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
    LAST_UPDATE as timestamp,
    COALESCE(TTLTRAFFIC, '0') AS TOTAL_COUNTER,
    LAST_COUNTER_TS AS LAST_COUNTER_CNT_TIMESTAMP,
    IAQ AS ODOUR_LEVEL,
    TMP,
    LUX,
    FAN_STATUS,
    BLOWER_STATUS,
    OCCUPIED_STATUS,
    DISPLAY_STATUS,
    TOILET_NAME,
    TOILET_TYPE_ID,
    TOTAL_FRAGRANCE,
    TOTAL_AUTOCLEAN,
    TOTAL_COMPLAINT
FROM (
        SELECT SUM(people_in) AS TTLTRAFFIC
        FROM COUNTER_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = COUNTER_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 2
            AND (TIMESTAMP) >= TO_TIMESTAMP(
                '2024-07-22 16:00:00', 'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q1
    CROSS JOIN (
        SELECT
            TIMESTAMP AS LAST_UPDATE, LUX, TEMPERATURE AS TMP, IAQ
        FROM
            ENVIROMENT_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = ENVIROMENT_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 3
        ORDER BY TIMESTAMP DESC
        LIMIT 1
    ) Q2
    CROSS JOIN (
        SELECT COUNT(*) AS TOTAL_COMPLAINT
        FROM
            FEEDBACK_PANEL_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = FEEDBACK_PANEL_DATA.DEVICE_TOKEN
            JOIN DEVICE_PAIRS ON DEVICE_PAIRS.DEVICE_ID = DEVICE_LIST.DEVICE_ID
            JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID
        WHERE (TIMESTAMP) >= TO_TIMESTAMP(
                '2024-07-22 16:00:00', 'YYYY-MM-DD HH24:MI:SS'
            )
            AND DEVICE_LIST.TOILET_TYPE_ID = FEEDBACK_PANEL_DATA.TOILET_TYPE_ID
    ) Q5
    CROSS JOIN (
        SELECT
            FAN_STATUS, BLOWER_STATUS, OCCUPIED_STATUS, DISPLAY_STATUS, TOILET_NAME, TOILET_TYPE_ID
        FROM TOILET_INFOS
        WHERE
            TOILET_INFOS.TOILET_INFO_ID = '5654c008-dbcc-4656-5601-0a0c50652213'
    ) Q6
    CROSS JOIN (
        SELECT COUNT(*) AS TOTAL_FRAGRANCE
        FROM
            MISC_ACTION_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = MISC_ACTION_DATA.DEVICE_TOKEN
        WHERE
            MISC_ACTION_DATA.NAMESPACE = 'FRESHENER'
    ) Q7
    CROSS JOIN (
        SELECT COUNT(
                CASE
                    WHEN AUTO_CLEAN_STATE = '1' THEN 1
                END
            ) AS TOTAL_AUTOCLEAN
        FROM CLEANER_REPORTS
        WHERE
            CLEANER_REPORTS.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFO_ID = '5654c008-dbcc-4656-5601-0a0c50652213'
            )
    ) Q8
    LEFT JOIN (
        SELECT timestamp AS LAST_COUNTER_TS
        FROM COUNTER_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = COUNTER_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 2
        ORDER BY timestamp desc
        LIMIT 1
    ) Q9 ON TRUE


-- taman bandar overeview advandce data
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
    LAST_UPDATE as timestamp,
    COALESCE(TTLTRAFFIC, '0') AS TOTAL_COUNTER,
    LAST_COUNTER_TS AS LAST_COUNTER_CNT_TIMESTAMP,
    IAQ AS ODOUR_LEVEL,
    TMP,
    LUX,
    FAN_STATUS,
    BLOWER_STATUS,
    OCCUPIED_STATUS,
    DISPLAY_STATUS,
    TOILET_NAME,
    TOILET_TYPE_ID,
    TOTAL_FRAGRANCE,
    TOTAL_AUTOCLEAN,
    TOTAL_COMPLAINT
FROM (
        SELECT SUM(people_in) AS TTLTRAFFIC
        FROM COUNTER_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = COUNTER_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 2
            AND (TIMESTAMP) >= TO_TIMESTAMP(
                '2024-07-22 16:00:00', 'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q1
    CROSS JOIN (
        SELECT
            TIMESTAMP AS LAST_UPDATE, LUX, TEMPERATURE AS TMP, IAQ
        FROM
            ENVIROMENT_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = ENVIROMENT_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 3
        ORDER BY TIMESTAMP DESC
        LIMIT 1
    ) Q2
    CROSS JOIN (
        SELECT COUNT(*) AS TOTAL_COMPLAINT
        FROM
            FEEDBACK_PANEL_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = FEEDBACK_PANEL_DATA.DEVICE_TOKEN
            JOIN DEVICE_PAIRS ON DEVICE_PAIRS.DEVICE_ID = DEVICE_LIST.DEVICE_ID
            JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID
        WHERE (TIMESTAMP) >= TO_TIMESTAMP(
                '2024-07-22 16:00:00', 'YYYY-MM-DD HH24:MI:SS'
            )
            AND DEVICE_LIST.TOILET_TYPE_ID = FEEDBACK_PANEL_DATA.TOILET_TYPE_ID
    ) Q5
    CROSS JOIN (
        SELECT
            FAN_STATUS, BLOWER_STATUS, OCCUPIED_STATUS, DISPLAY_STATUS, TOILET_NAME, TOILET_TYPE_ID
        FROM TOILET_INFOS
        WHERE
            TOILET_INFOS.TOILET_INFO_ID = '2a9fbea0-4dca-4af6-457b-348bf682cb54'
    ) Q6
    CROSS JOIN (
        SELECT COUNT(*) AS TOTAL_FRAGRANCE
        FROM
            MISC_ACTION_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = MISC_ACTION_DATA.DEVICE_TOKEN
        WHERE
            MISC_ACTION_DATA.NAMESPACE = 'FRESHENER'
    ) Q7
    CROSS JOIN (
        SELECT COUNT(
                CASE
                    WHEN AUTO_CLEAN_STATE = '1' THEN 1
                END
            ) AS TOTAL_AUTOCLEAN
        FROM CLEANER_REPORTS
        WHERE
            CLEANER_REPORTS.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFO_ID = '2a9fbea0-4dca-4af6-457b-348bf682cb54'
            )
    ) Q8
    LEFT JOIN (
        SELECT timestamp AS LAST_COUNTER_TS
        FROM COUNTER_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = COUNTER_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 2
        ORDER BY timestamp desc
        LIMIT 1
    ) Q9 ON TRUE


-- get device list for each toilet and its statuss
SELECT DISTINCT
    ON (DEVICES.DEVICE_TOKEN) DEVICES.DEVICE_TOKEN,
    DEVICES.DEVICE_NAME,
    DEVICE_TYPES.DEVICE_TYPE_NAME,
    DEVICES.DEVICE_TYPE_ID
FROM
    "devices"
    LEFT JOIN DEVICE_PAIRS ON DEVICE_PAIRS.DEVICE_ID = DEVICES.DEVICE_ID
    LEFT JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID = DEVICES.DEVICE_TYPE_ID
WHERE (
        DEVICE_PAIRS.TOILET_INFO_ID = '2a9fbea0-4dca-4af6-457b-348bf682cb54'
    )
ORDER BY DEVICES.DEVICE_TOKEN

-- get device status from redis


--telemetry controller , get device lists
SELECT DISTINCT ON (DEVICES.DEVICE_TOKEN) DEVICES.DEVICE_TOKEN,DEVICES.DEVICE_NAME,DEVICE_TYPES.DEVICE_TYPE_NAME,DEVICES.DEVICE_TYPE_ID
FROM DEVICES
LEFT JOIN DEVICE_PAIRS ON DEVICE_PAIRS.DEVICE_ID = DEVICES.DEVICE_ID
LEFT JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID = DEVICES.DEVICE_TYPE_ID
WHERE DEVICE_PAIRS.TOILET_INFO_ID = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984' 
ORDER BY DEVICES.DEVICE_TOKEN


-- get faile sql
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
    LAST_UPDATE as timestamp,
    COALESCE(TTLTRAFFIC, '0') AS TOTAL_COUNTER,
    LAST_COUNTER_TS AS LAST_COUNTER_CNT_TIMESTAMP,
    IAQ AS ODOUR_LEVEL,
    TMP,
    LUX,
    FAN_STATUS,
    BLOWER_STATUS,
    OCCUPIED_STATUS,
    DISPLAY_STATUS,
    TOILET_NAME,
    TOILET_TYPE_ID,
    TOTAL_FRAGRANCE,
    TOTAL_AUTOCLEAN,
    TOTAL_COMPLAINT,
    AMMONIA_LEVEL,
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
        SELECT COUNT(*) AS TOTAL_COMPLAINT
        FROM
            FEEDBACK_PANEL_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = FEEDBACK_PANEL_DATA.DEVICE_TOKEN
            JOIN DEVICE_PAIRS ON DEVICE_PAIRS.DEVICE_ID = DEVICE_LIST.DEVICE_ID
            JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID
        WHERE (TIMESTAMP) >= TO_TIMESTAMP(
                '2024-07-22 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
            AND DEVICE_LIST.TOILET_TYPE_ID = FEEDBACK_PANEL_DATA.TOILET_TYPE_ID
    ) Q5
    CROSS JOIN (
        SELECT
            FAN_STATUS,
            BLOWER_STATUS,
            OCCUPIED_STATUS,
            DISPLAY_STATUS,
            TOILET_NAME,
            TOILET_TYPE_ID
        FROM TOILET_INFOS
        WHERE
            TOILET_INFOS.TOILET_INFO_ID = '2a9fbea0-4dca-4af6-457b-348bf682cb54'
    ) Q6
    CROSS JOIN (
        SELECT COUNT(*) AS TOTAL_FRAGRANCE
        FROM
            MISC_ACTION_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = MISC_ACTION_DATA.DEVICE_TOKEN
        WHERE
            MISC_ACTION_DATA.NAMESPACE = 'FRESHENER'
    ) Q7
    CROSS JOIN (
        SELECT COUNT(
                CASE
                    WHEN AUTO_CLEAN_STATE = '1' THEN 1
                END
            ) AS TOTAL_AUTOCLEAN
        FROM CLEANER_REPORTS
        WHERE
            CLEANER_REPORTS.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFO_ID = '2a9fbea0-4dca-4af6-457b-348bf682cb54'
            )
    ) Q8
    LEFT JOIN (
        SELECT timestamp AS LAST_COUNTER_TS
        FROM COUNTER_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = COUNTER_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 2
        ORDER BY timestamp desc
        LIMIT 1
    ) Q9 ON TRUE
    LEFT JOIN (
        SELECT avg(ammonia_level) as AMMONIA_LEVEL
        FROM ammonia_data
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = ammonia_data.DEVICE_TOKEN
        WHERE
            timestamp BETWEEN TO_TIMESTAMP(
                '2024-07-22 00:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) AND TO_TIMESTAMP(
                '2024-07-22 23:59:59',
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



 --get all occuoancy sensor with its status for TOILET_INFO_ID = '2a9fbea0-4dca-4af6-457b-348bf682cb54'
 -- TENANT_ID, LOCATION_ID
SELECT * FROM TOILET_INFOS WHERE TOILET_INFO_ID = '2a9fbea0-4dca-4af6-457b-348bf682cb54' 

-- DEVICE_ID, TOILET_INFO_ID
SELECT * FROM DEVICE_PAIRS

SET FOREIGN_KEY_CHECKS = 0;

SET session_replication_role = 'replica';

SET session_replication_role = 'origin';

DISABLE TRIGGER ALL

	
ALTER TABLE DEVICES DISABLE TRIGGER ALL;

SET CONSTRAINTS ALL DEFERRED;

COMMIT;

-- DEVICE TOKEN
SELECT * FROM DEVICES

SELECT * FROM DEVICES


-- DATA
SELECT * FROM devices
where device_id ='4a841976-8eb5-4aba-6b20-246fb6552858'

UPDATE devices
SET device_type_id = 10
WHERE device_id = '4a841976-8eb5-4aba-6b20-246fb6552858';



-- 4a841976-8eb5-4aba-6b20-246fb6552858

SELECT D.DEVICE_ID, D.DEVICE_NAME, D.DEVICE_TOKEN, D.DEVICE_TYPE_ID
FROM DEVICES D
JOIN DEVICE_PAIRS DP ON DP.DEVICE_ID = D.DEVICE_ID
JOIN TOILET_INFOS TI ON TI.TOILET_INFO_ID = DP.TOILET_INFO_ID
WHERE TI.TOILET_INFO_ID =  '2a9fbea0-4dca-4af6-457b-348bf682cb54'
    AND D.DEVICE_TYPE_ID = '12'


update devices
set device_name = 'OCCUPANCY_MALE_M3'
where device_id = '3648c6aa-6fb1-405a-6209-7408a38eb6fa'


-- toilet_info_id = 9eca5dcc-7946-4367-60a5-d7bd09b1e16a , taman bandar

select * from occupancy_data where device_token in ('91', '92', '93', '94')
order by timestamp desc limit 100

WITH DEVICE_LIST AS (select dp.device_pair_id,
    --    dp.toilet_info_id,
    --    ti.toilet_name,
       d.device_name,
       d.device_token
from device_pairs as dp
join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
join devices as d on dp.device_id = d.device_id
where dp.toilet_info_id = '9eca5dcc-7946-4367-60a5-d7bd09b1e16a'
    and d.device_type_id =12)
select 
-- od.id, 
od.occupied as occupancy,
-- od.device_token , 
right(dl.device_name, 2) as cubical_name, 
Q1.cubical_counter
from occupancy_data od
join device_list dl on dl.device_token = od.device_token
left join(
    select COALESCE(sum(CASE WHEN occupied THEN 1 ELSE 0 END),0) as cubical_counter,
    device_token
    from occupancy_data
    where timestamp BETWEEN to_timestamp('2024-07-23 00:00:00', 'YYYY-MM-DD HH24:MI:SS') 
    AND to_timestamp('2024-07-23 23:59:59', 'YYYY-MM-DD HH24:MI:SS')
    group by device_token
) Q1 on Q1.device_token = dl.device_token
order by timestamp desc limit 4



-- fail query
WITH
    DEVICE_LIST AS (
        select dp.device_pair_id, d.device_name, d.device_token
        from
            device_pairs as dp
            join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
            join devices as d on dp.device_id = d.device_id
        where
            dp.toilet_info_id = '5654c008-dbcc-4656-5601-0a0c50652213'
            and d.device_type_id = 12
    )
select od.occupied as occupancy, right(dl.device_name, 2) as cubical_name, Q1.cubical_counter
from
    occupancy_data od
    join device_list dl on dl.device_token = od.device_token
    left join (
        select COALESCE(
                sum(
                    CASE
                        WHEN occupied THEN 1
                        ELSE 0
                    END
                ), 0
            ) as cubical_counter, device_token
        from occupancy_data
        where
            timestamp BETWEEN to_timestamp(
                '2024-07-22 00:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) AND to_timestamp(
                '2024-07-22 23:59:59',
                'YYYY-MM-DD HH24:MI:SS'
            )
        group by
            device_token
    ) Q1 on Q1.device_token = dl.device_token
order by timestamp desc
limit 4

    