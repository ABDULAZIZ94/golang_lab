-- Active: 1722832765629@@alpha.vectolabs.com@9998@smarttoilet-staging


select * from enviroment_data 

delete from enviroment_data where timestamp > now()

select * from enviroment_data where device_token ='222'

-- iaq graph
select iaq, date_trunc('HOUR', timestamp)
from enviroment_data where timestamp between to_timestamp('2024-08-15 07:00:00','YYYY-MM-DD HH24:MI:SS') 
and to_timestamp('2024-08-15 18:00:00','YYYY-MM-DD HH24:MI:SS') and device_token = '105'

-- lux graph
select ]('HOUR', timestamp)
from enviroment_data where timestamp between to_timestamp('2024-08-15 07:00:00','YYYY-MM-DD HH24:MI:SS') 
and to_timestamp('2024-08-15 18:00:00','YYYY-MM-DD HH24:MI:SS') and device_token = '105'

-- humidity graph
select humidity, date_trunc('HOUR', timestamp)
from enviroment_data where timestamp between to_timestamp('2024-08-15 07:00:00','YYYY-MM-DD HH24:MI:SS') 
and to_timestamp('2024-08-15 18:00:00','YYYY-MM-DD HH24:MI:SS') and device_token = '105'


-- temperature graph
select temperature, date_trunc('HOUR', timestamp)
from enviroment_data where timestamp between to_timestamp('2024-08-15 07:00:00','YYYY-MM-DD HH24:MI:SS') 
and to_timestamp('2024-08-15 18:00:00','YYYY-MM-DD HH24:MI:SS') and device_token = '105'


select * from enviroment_data where iaq between 1 and 5 order by timestamp desc



select * from enviroment_data where iaq > 5 order by timestamp desc


select * from enviroment_data where device_token = '105' order by timestamp desc limit 10


select * from enviroment_data where device_token = '105' 
and timestamp between to_timestamp('2024-08-20 23:00:00','YYYY-MM-DD HH24:MI:SS')
and to_timestamp( '2024-08-21 11:00:0', 'YYYY-MM-DD HH24:MI:SS' )
order by timestamp desc limit 10




----

WITH
    LOCATIONS_INVOLVED as (
        select location_id, tenant_id
        from locations
        where
            location_id = '2a83bc9b-0dba-451e-7760-a29bfc3db337'
    ),
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
            TOILET_INFOS.LOCATION_ID = '2a83bc9b-0dba-451e-7760-a29bfc3db337'
    ),
    TOILET_LIST AS (
        SELECT toilet_info_id
        FROM toilet_infos
        WHERE
            location_id = '2a83bc9b-0dba-451e-7760-a29bfc3db337'
    ),
    PANIC_BTN_DATA AS (
        SELECT
            panic_button,
            timestamp,
            LAG(panic_button, 1) OVER (
                ORDER BY id
            ) AS prev_state,
            DEVICE_LIST.DEVICE_TOKEN
        FROM panic_btn_data
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = panic_btn_data.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = '11'
            AND timestamp BETWEEN TO_TIMESTAMP(
                '2024-11-11 00:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) AND TO_TIMESTAMP(
                '2024-11-12 15:59:59',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ),
    AMMONIA_DATA AS (
        SELECT
            ammonia_level,
            (
                CASE
                    WHEN ammonia_level = 0 THEN 'LOW'
                    WHEN ammonia_level IS NULL THEN 'LOW'
                    WHEN ammonia_level > 1 THEN 'HIGH'
                    ELSE 'LOW'
                END
            ) AS AMMONIA_HIGHLOW,
            DEVICE_LIST.DEVICE_TOKEN
        FROM ammonia_data
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = ammonia_data.DEVICE_TOKEN
        WHERE
            timestamp > CURRENT_TIMESTAMP - INTERVAL '1 hour'
        ORDER BY timestamp DESC
        LIMIT 1
    ),
    VIOLATION_DATA AS (
        SELECT COUNT(id) AS TOTAL_VIOLATION
        FROM violation_data
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = violation_data.device_token
        WHERE
            created_at BETWEEN TO_TIMESTAMP(
                '2024-11-11 00:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) AND TO_TIMESTAMP(
                '2024-11-12 15:59:59',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ),
    PANIC_BTN_PUSHED AS (
        SELECT COUNT(
                CASE
                    WHEN panic_button = TRUE
                    AND prev_state = FALSE THEN 1
                END
            ) AS PANICBTN_PUSHED
        FROM PANIC_BTN_DATA
    ),
    MONEY_DATA AS (
        SELECT SUM(ammount) AS TOTAL_COLLECTIONS
        FROM money_data
        WHERE
            created_at BETWEEN TO_TIMESTAMP(
                '2024-11-11 00:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) AND TO_TIMESTAMP(
                '2024-11-12 15:59:59',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ),
    CLEANER_DATA AS (
        SELECT
            CHECK_OUT_TS AS LAST_CLEAN_TIMESTAMP
        FROM cleaner_reports
        WHERE
            cleaner_reports.location_id = '2a83bc9b-0dba-451e-7760-a29bfc3db337'
            -- AND CHECK_OUT_TS > CURRENT_TIMESTAMP - INTERVAL '1 hour'
        ORDER BY CHECK_OUT_TS DESC
        LIMIT 1
    ),
    CLEANER_RESPONSE_TIME AS (
        SELECT AVG(duration) AS AVG_CLEANER_RESPONSE_TIME
        FROM cleaner_reports
        WHERE
            cleaner_reports.location_id = '2a83bc9b-0dba-451e-7760-a29bfc3db337'
            AND check_in_ts BETWEEN TO_TIMESTAMP(
                '2024-11-11 00:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) AND TO_TIMESTAMP(
                '2024-11-12 15:59:59',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ),
    LAST_AUTOCLEAN AS (
        SELECT
            CHECK_OUT_TS AS LAST_AUTOCLEAN_ACTIVE_TIMESTAMP
        FROM cleaner_reports
        WHERE
            cleaner_reports.location_id = '2a83bc9b-0dba-451e-7760-a29bfc3db337'
            AND AUTO_CLEAN_STATE = '1'
        ORDER BY CHECK_OUT_TS DESC
        LIMIT 1
    )
SELECT
    TENANT_ID,
    COALESCE(
        VIOLATION_DATA.TOTAL_VIOLATION,
        0
    ) AS TOTAL_VIOLATION,
    COALESCE(
        AMMONIA_DATA.ammonia_level,
        0.0
    ) AS CURRENT_AMMONIALEVEL,
    COALESCE(
        AMMONIA_DATA.AMMONIA_HIGHLOW,
        'LOW'
    ) AS AMMONIA_HIGHLOW,
    COALESCE(
        PANIC_BTN_PUSHED.PANICBTN_PUSHED,
        0
    ) AS TOTAL_PANICBTNPUSHED,
    COALESCE(
        CLEANER_RESPONSE_TIME.AVG_CLEANER_RESPONSE_TIME,
        0
    ),
    COALESCE(
        CLEANER_DATA.LAST_CLEAN_TIMESTAMP,
        '2000-01-01 00:00:00'::timestamp
    ) AS LAST_CLEAN_TIMESTAMP,
    COALESCE(
        LAST_AUTOCLEAN.LAST_AUTOCLEAN_ACTIVE_TIMESTAMP,
        '2000-01-01 00:00:00'::timestamp
    ) AS LAST_AUTOCLEAN_ACTIVE_TIMESTAMP,
    COALESCE(
        MONEY_DATA.TOTAL_COLLECTIONS,
        0
    ) AS TOTAL_COLLECTIONS
FROM
    LOCATIONS_INVOLVED
    LEFT JOIN CLEANER_DATA ON 1 = 1
    LEFT JOIN CLEANER_RESPONSE_TIME ON 1 = 1 -- Use appropriate condition to match rows
    LEFT JOIN LAST_AUTOCLEAN ON 1 = 1 -- Use appropriate condition to match rows
    LEFT JOIN AMMONIA_DATA ON 1 = 1 -- Use appropriate condition to match rows
    LEFT JOIN VIOLATION_DATA ON 1 = 1 -- Use appropriate condition to match rows
    LEFT JOIN PANIC_BTN_PUSHED ON 1 = 1 -- Use appropriate condition to match rows
    LEFT JOIN MONEY_DATA ON 1 = 1 -- Use appropriate condition to match rows  
