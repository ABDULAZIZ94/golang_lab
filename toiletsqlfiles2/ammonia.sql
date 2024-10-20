-- 
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
            DEVICE_PAIRS.TOILET_INFO_ID = '9388096c-784d-49c8-784c-1868b1233165'
    )
WITH
    GENTIME as (
        SELECT uplinkTS
        FROM generate_series(
                date_trunc(
                    'HOUR', TO_TIMESTAMP(
                        '2024-08-13 07:00:00', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), date_trunc(
                    'HOUR', TO_TIMESTAMP(
                        '2024-08-13 18:00:00', 'YYYY-MM-DD HH24:MI:SS'
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




--- 
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
    TOILET_LIST as (
        SELECT ti.toilet_info_id
        FROM toilet_infos ti
        where
            tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'
    )
SELECT
    COALESCE(TOTAL_VIOLATION, 0) AS TOTAL_VIOLATION,
    COALESCE(CURRENT_AMMONIA_LEVEL, 0.0) AS CURRENT_AMMONIALEVEL,
    COALESCE(PANICBTN_PUSHED, 0) AS TOTAL_PANICBTNPUSHED,
    AVG_CLEANER_RESPONSE_TIME,
    LAST_CLEAN_TIMESTAMP,
    LAST_AUTOCLEAN_ACTIVE_TIMESTAMP,
    TOTAL_COLLECTIONS
FROM (
        SELECT
            CHECK_OUT_TS AS LAST_CLEAN_TIMESTAMP
        FROM CLEANER_REPORTS
        WHERE
            CLEANER_REPORTS.TENANT_ID = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'
        ORDER BY CHECK_OUT_TS DESC
        LIMIT 1
    ) Q1
    CROSS JOIN (
        SELECT AVG(DURATION) AS AVG_CLEANER_RESPONSE_TIME
        FROM CLEANER_REPORTS
        WHERE
            CLEANER_REPORTS.TENANT_ID = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'
    ) Q2
    CROSS JOIN (
        SELECT
            CHECK_OUT_TS AS LAST_AUTOCLEAN_ACTIVE_TIMESTAMP
        FROM CLEANER_REPORTS
        WHERE
            CLEANER_REPORTS.TENANT_ID = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'
            AND AUTO_CLEAN_STATE = '1'
        ORDER BY CHECK_OUT_TS DESC
        LIMIT 1
    ) Q3
    LEFT JOIN (
        SELECT AVG(ammonia_level) AS CURRENT_AMMONIA_LEVEL
        FROM ammonia_data
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = ammonia_data.DEVICE_TOKEN
        GROUP BY
            ammonia_data.device_token,
            ammonia_data.timestamp
        ORDER BY timestamp DESC
        LIMIT 1
    ) Q10 ON 1 = 1
    LEFT JOIN (
        SELECT COUNT(id) AS TOTAL_VIOLATION
        FROM violation_data
            JOIN device_list ON device_list.device_id = violation_data.device_id
        WHERE
            created_at BETWEEN TO_TIMESTAMP(
                '2024-08-14 07:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) AND TO_TIMESTAMP(
                '2024-08-14 18:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q4 ON 1 = 1
    LEFT JOIN (
        SELECT COUNT(
                CASE
                    WHEN panic_button = TRUE
                    AND prev_state = FALSE THEN 1
                END
            ) AS PANICBTN_PUSHED
        FROM (
                SELECT panic_button, timestamp, LAG(panic_button, 1) OVER (
                        ORDER BY id
                    ) AS prev_state
                FROM panic_btn_data
            ) S1
        WHERE
            timestamp BETWEEN TO_TIMESTAMP(
                '2024-08-14 07:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) AND TO_TIMESTAMP(
                '2024-08-14 18:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q5 ON 1 = 1
    LEFT JOIN (
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
    ) Q6 ON 1 = 1


select * from ammonia_data where ammonia_level != 0

select * from ammonia_data
where timestamp > NOW() - interval '2 YEAR'
order by timestamp desc

select * from ammonia_data
where timestamp > NOW() - interval '1 YEAR'


delete from ammonia_data where device_token not in ('70','71')


delete from ammonia_data where timestamp < NOW() - interval '1 YEAR'


select * from ammonia_data order by timestamp desc