-- Active: 1720683458566@@127.0.0.1@5432@smarttoilet
--GENERATE TIMESTAMP BASED ON DATE AND INTERVAL
WITH GENTIME as (
    SELECT uplinkTS  
    FROM generate_series(
        date_trunc('WEEK', TO_TIMESTAMP('2024-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),  
        date_trunc('WEEK', TO_TIMESTAMP('2024-01-01 23:59:59', 'YYYY-MM-DD HH24:MI:SS')),  
        interval '1 WEEK'
        ) uplinkTS
) 
SELECT uplinkTS FROM GENTIME;

WITH GENTIME AS (
    SELECT uplinkTS
    FROM generate_series(
        date_trunc('week', TO_TIMESTAMP('2024-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),
        date_trunc('week', TO_TIMESTAMP('2024-01-01 23:59:59', 'YYYY-MM-DD HH24:MI:SS')),
        interval '1 week'
    ) AS uplinkTS
)
SELECT uplinkTS FROM GENTIME;

WITH GENTIME AS (
    SELECT generate_series(
        date_trunc('week', TO_TIMESTAMP('2024-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),
        date_trunc('week', TO_TIMESTAMP('2024-12-01 23:59:59', 'YYYY-MM-DD HH24:MI:SS')),
        interval '1 week'
    ) AS uplinkTS
)
SELECT uplinkTS FROM GENTIME;

-- list counter
SELECT DEVICES.DEVICE_NAME,DEVICES.DEVICE_ID,DEVICES.DEVICE_TOKEN,  
TOILET_INFOS.TOILET_NAME AS Identifier ,DEVICE_TYPES.DEVICE_TYPE_NAME as Namespace,  
DEVICE_TYPES.DEVICE_TYPE_ID AS NAMESPACE_ID , TOILET_INFOS.TOILET_TYPE_ID  
FROM DEVICE_PAIRS  
JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID  
JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID = DEVICES.DEVICE_TYPE_ID  
JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID  
WHERE TOILET_INFOS.TOILET_INFO_ID = '5654c008-dbcc-4656-5601-0a0c50652213' AND  DEVICE_TYPES.DEVICE_TYPE_ID =2

--list device

SELECT DEVICES.DEVICE_NAME,DEVICES.DEVICE_ID,DEVICES.DEVICE_TOKEN,  
TOILET_INFOS.TOILET_NAME AS Identifier ,DEVICE_TYPES.DEVICE_TYPE_NAME as Namespace,  
DEVICE_TYPES.DEVICE_TYPE_ID AS NAMESPACE_ID , TOILET_INFOS.TOILET_TYPE_ID  
FROM DEVICE_PAIRS  
JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID  
JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID = DEVICES.DEVICE_TYPE_ID  
JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID  
WHERE TOILET_INFOS.TOILET_INFO_ID = '5654c008-dbcc-4656-5601-0a0c50652213' 

-- list ammonia sensor
-- bandar kuantan male

SELECT DEVICES.DEVICE_NAME,DEVICES.DEVICE_ID,DEVICES.DEVICE_TOKEN,  
TOILET_INFOS.TOILET_NAME AS Identifier ,DEVICE_TYPES.DEVICE_TYPE_NAME as Namespace,  
DEVICE_TYPES.DEVICE_TYPE_ID AS NAMESPACE_ID , TOILET_INFOS.TOILET_TYPE_ID  
FROM DEVICE_PAIRS  
JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID  
JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID = DEVICES.DEVICE_TYPE_ID  
JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID  
WHERE TOILET_INFOS.TOILET_INFO_ID = '5654c008-dbcc-4656-5601-0a0c50652213' AND  DEVICE_TYPES.DEVICE_TYPE_ID =13

---bandar kuantan female
-- 9eca5dcc-7946-4367-60a5-d7bd09b1e16a

SELECT DEVICES.DEVICE_NAME,DEVICES.DEVICE_ID,DEVICES.DEVICE_TOKEN,  
TOILET_INFOS.TOILET_NAME AS Identifier ,DEVICE_TYPES.DEVICE_TYPE_NAME as Namespace,  
DEVICE_TYPES.DEVICE_TYPE_ID AS NAMESPACE_ID , TOILET_INFOS.TOILET_TYPE_ID  
FROM DEVICE_PAIRS  
JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID  
JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID = DEVICES.DEVICE_TYPE_ID  
JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID  
WHERE TOILET_INFOS.TOILET_INFO_ID = '9eca5dcc-7946-4367-60a5-d7bd09b1e16a' AND  DEVICE_TYPES.DEVICE_TYPE_ID =13

--- test query
WITH GENTIME AS (
    SELECT generate_series(
        date_trunc('week', TO_TIMESTAMP('2024-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),
        date_trunc('week', TO_TIMESTAMP('2024-12-01 23:59:59', 'YYYY-MM-DD HH24:MI:SS')),
        interval '1 week'
    ) AS uplinkTS
)
SELECT uplinkTS::text, 
    COALESCE(people_in, '0')::text AS people_in, 
    COALESCE(people_out, '0')::text AS people_out  
FROM GENTIME  
LEFT JOIN  
    (SELECT date_trunc('WEEK', timestamp) AS uplinkTS,  
    sum(people_in) AS people_in,sum(people_out) AS people_out  
    FROM counter_data  
    WHERE device_token = '13'  
    GROUP BY uplinkTS) second_query USING (uplinkTS) 
ORDER BY uplinkTS ASC


select * from counter_data

select * from ammonia_data order by timestamp desc limit 100


SELECT DISTINCT uplinkTS, avg(ammonia_level) as ammonia_level
FROM
    (SELECT date_trunc('HOUR', timestamp) AS uplinkTS, ammonia_level
    FROM ammonia_data  
    WHERE device_token = '79'  
    GROUP BY uplinkTS, ammonia_level)
GROUP BY uplinkTS


-- test combine

WITH GENTIME AS (
    SELECT generate_series(
        date_trunc('HOUR', TO_TIMESTAMP('2024-07-23 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),
        date_trunc('HOUR', TO_TIMESTAMP('2024-07-23 23:59:59', 'YYYY-MM-DD HH24:MI:SS')),
        interval '1 HOUR'
    ) AS uplinkTS
)
SELECT DISTINCT uplinkTS::text, avg(ammonia_level) as ammonia_level
FROM
    (SELECT date_trunc('HOUR', timestamp) AS uplinkTS, ammonia_level
    FROM ammonia_data  
    WHERE device_token = '79'  
    GROUP BY uplinkTS, ammonia_level)
GROUP BY uplinkTS

-- fail query
WITH
    GENTIME as (
        SELECT uplinkTS
        FROM generate_series(
                date_trunc(
                    'HOUR', TO_TIMESTAMP(
                        '2024-07-22', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), date_trunc(
                    'HOUR', TO_TIMESTAMP(
                        '2024-07-24', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), interval '1 HOUR'
            ) uplinkTS
    )
SELECT DISTINCT
    uplinkTS,
    avg(ammonia_level) as ammonia_level
FROM (
        SELECT
            date_trunc('HOUR', timestamp) AS uplinkTS, ammonia_level
        FROM ammonia_data
        WHERE
            device_token = '79'
        GROUP BY
            uplinkTS, ammonia_level
    )
GROUP BY
    uplinkTS

select * from ammonia_data