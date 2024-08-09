-- Active: 1722832765629@@alpha.vectolabs.com@9998@smarttoilet-staging

-- subquery return more than 1 row
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
SELECT
    -- LAST_UPDATE,
    -- LAST_CLEAN_TIMESTAMP,
    -- LAST_AUTOCLEAN_ACTIVE_TIMESTAMP,
    -- AVG_CLEANER_RESPONSE_TIME,
    COALESCE(TTLTRAFFIC, '0') AS TOTAL_COUNTER,
    -- COALESCE(TOTAL_COUNTER_LAST_CLEAN, '0') AS TOTAL_COUNTER_LAST_CLEAN,
    -- TOTAL_AUTOCLEAN_CNT,
    -- IAQ,
    -- TMP,
    -- LUX,
    BIN_FULL,
    BUSUK,
    URINAL_CLOG,
    SANITARY_BIN_FULL,
    PIPE_LEAK,
    PIPE_LEAK
    SLIPPERY,
    OUT_TISSUE,
    REFRESH_TOILET,
    OUT_SOAP
    -- CLOGGED_TOILET
    -- COALESCE(AMMONIA_LEVEL, 0.0) AS AMMONIA_LEVEL,
    -- COALESCE(SMOKE_SENSOR, FALSE) AS SMOKE_SENSOR,
    -- COALESCE(PANICBTN_STATUS, FALSE) AS PANICBTN_STATUS,
    -- COALESCE(TOTAL_VIOLATION, 0) AS TOTAL_VIOLATION,
    -- COALESCE(PANICBTN_PUSHED, 0) AS PANICBTN_PUSHED
FROM 
    (SELECT SUM(people_in) AS TTLTRAFFIC
    FROM COUNTER_DATA
        JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = COUNTER_DATA.DEVICE_TOKEN
    WHERE
        DEVICE_LIST.NAMESPACE_ID = 2
        AND (TIMESTAMP) >= TO_TIMESTAMP (
            '2024-07-30 16:00:00',
            'YYYY-MM-DD HH24:MI:SS'
        )
    ) Q1
    -- CROSS JOIN (
    --     SELECT
    --         TIMESTAMP AS LAST_UPDATE,
    --         LUX,
    --         TEMPERATURE AS TMP,
    --         IAQ
    --     FROM
    --         ENVIROMENT_DATA
    --         JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = ENVIROMENT_DATA.DEVICE_TOKEN
    --     WHERE
    --         DEVICE_LIST.NAMESPACE_ID = 3
    --     ORDER BY TIMESTAMP DESC
    --     LIMIT 1
    -- ) Q2
    -- CROSS JOIN (
    --     SELECT
    --         CHECK_OUT_TS as LAST_CLEAN_TIMESTAMP
    --     FROM CLEANER_REPORTS
    --     WHERE
    --         cleaner_reports.TOILET_TYPE_ID = (
    --             SELECT TOILET_TYPE_ID
    --             FROM TOILET_INFOS
    --             WHERE
    --                 TOILET_INFO_ID = '9388096c-784d-49c8-784c-1868b1233165'
    --         )
    --     order by CHECK_OUT_TS desc
    --     limit 1
    -- ) Q3
    -- CROSS JOIN (
    --     SELECT AVG(DURATION) AS AVG_CLEANER_RESPONSE_TIME
    --     FROM CLEANER_REPORTS
    --     WHERE
    --         cleaner_reports.TOILET_TYPE_ID = (
    --             SELECT TOILET_TYPE_ID
    --             FROM TOILET_INFOS
    --             WHERE
    --                 TOILET_INFO_ID = '9388096c-784d-49c8-784c-1868b1233165'
    --         )
    -- ) Q4
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
        WHERE (TIMESTAMP) BETWEEN TO_TIMESTAMP (
                '2023-07-01 00:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) AND TO_TIMESTAMP  (
                '2024-07-30 23:59:59',
                'YYYY-MM-DD HH24:MI:SS'
            )
            AND FEEDBACK_PANEL_DATA.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFOS.TOILET_INFO_ID = '9388096c-784d-49c8-784c-1868b1233165'
            )
            AND DEVICE_TOKEN = (
                SELECT DEVICE_TOKEN
                FROM DEVICE_LIST
                WHERE
                    DEVICE_LIST.NAMESPACE_ID = 7
            )
    ) Q5
    -- CROSS JOIN (
    --     SELECT COUNT(
    --             CASE
    --                 WHEN AUTO_CLEAN_STATE = '1' THEN 1
    --             END
    --         ) AS TOTAL_AUTOCLEAN_CNT
    --     FROM CLEANER_REPORTS
    --     WHERE
    --         CLEANER_REPORTS.TOILET_TYPE_ID = (
    --             SELECT TOILET_TYPE_ID
    --             FROM TOILET_INFOS
    --             WHERE
    --                 TOILET_INFO_ID = '9388096c-784d-49c8-784c-1868b1233165'
    --         )
    --         AND CLEANER_REPORTS.CREATED_AT BETWEEN TO_TIMESTAMP (
    --             '2023-07-01 00:00:00',
    --             'YYYY-MM-DD HH24:MI:SS'
    --         ) AND TO_TIMESTAMP  (
    --             '2024-07-30 23:59:59',
    --             'YYYY-MM-DD HH24:MI:SS'
    --         )
    -- ) Q6
    -- CROSS JOIN (
    --     SELECT SUM(PEOPLE_IN) AS TOTAL_COUNTER_LAST_CLEAN
    --     FROM COUNTER_DATA
    --         JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = COUNTER_DATA.DEVICE_TOKEN
    --     WHERE
    --         DEVICE_LIST.NAMESPACE_ID = 2
    --         AND (TIMESTAMP) >= (
    --             SELECT CHECK_OUT_TS
    --             FROM CLEANER_REPORTS
    --             WHERE
    --                 CLEANER_REPORTS.TOILET_TYPE_ID = (
    --                     SELECT TOILET_TYPE_ID
    --                     FROM TOILET_INFOS
    --                     WHERE
    --                         TOILET_INFO_ID = '9388096c-784d-49c8-784c-1868b1233165'
    --                 )
    --             order by CHECK_OUT_TS desc
    --             limit 1
    --         )
    -- ) Q7
    -- CROSS JOIN (
    --     SELECT
    --         CHECK_OUT_TS as LAST_AUTOCLEAN_ACTIVE_TIMESTAMP
    --     FROM CLEANER_REPORTS
    --     WHERE
    --         cleaner_reports.TOILET_TYPE_ID = (
    --             SELECT TOILET_TYPE_ID
    --             FROM TOILET_INFOS
    --             WHERE
    --                 TOILET_INFO_ID = '9388096c-784d-49c8-784c-1868b1233165'
    --         )
    --         AND AUTO_CLEAN_STATE = '1'
    --     order by CHECK_OUT_TS desc
    --     limit 1
    -- ) Q8
    -- LEFT JOIN (
    --     SELECT avg(ammonia_level) as AMMONIA_LEVEL
    --     FROM ammonia_data
    --         JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = ammonia_data.DEVICE_TOKEN
    --     WHERE
    --         timestamp BETWEEN TO_TIMESTAMP (
    --             '2023-07-01 00:00:00',
    --             'YYYY-MM-DD HH24:MI:SS'
    --         ) AND TO_TIMESTAMP  (
    --             '2024-07-30 23:59:59',
    --             'YYYY-MM-DD HH24:MI:SS'
    --         )
    --     GROUP BY
    --         ammonia_data.device_token
    -- ) Q10 ON 1 = 1
    -- LEFT JOIN (
    --     SELECT SMOKE_SENSOR as SMOKE_SENSOR
    --     FROM SMOKE_DATA
    --         JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = SMOKE_DATA.DEVICE_TOKEN
    --     WHERE
    --         TIMESTAMP BETWEEN TO_TIMESTAMP (
    --             '2023-07-01 00:00:00',
    --             'YYYY-MM-DD HH24:MI:SS'
    --         ) AND TO_TIMESTAMP  (
    --             '2024-07-30 23:59:59',
    --             'YYYY-MM-DD HH24:MI:SS'
    --         )
    --     ORDER BY TIMESTAMP DESC
    --     LIMIT 1
    -- ) Q11 ON 1 = 1
    -- LEFT JOIN (
    --     SELECT PANIC_BUTTON as PANICBTN_STATUS
    --     FROM PANIC_BTN_DATA
    --         JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = PANIC_BTN_DATA.DEVICE_TOKEN
    --     WHERE
    --         TIMESTAMP BETWEEN TO_TIMESTAMP (
    --             '2023-07-01 00:00:00',
    --             'YYYY-MM-DD HH24:MI:SS'
    --         ) AND TO_TIMESTAMP  (
    --             '2024-07-30 23:59:59',
    --             'YYYY-MM-DD HH24:MI:SS'
    --         )
    --     ORDER BY TIMESTAMP DESC
    --     LIMIT 1
    -- ) Q12 ON 1 = 1
    -- LEFT JOIN (
    --     select count(id) as TOTAL_VIOLATION
    --     from violation_data
    --     where
    --         created_at BETWEEN TO_TIMESTAMP (
    --             '2023-07-01 00:00:00',
    --             'YYYY-MM-DD HH24:MI:SS'
    --         ) AND TO_TIMESTAMP  (
    --             '2024-07-30 23:59:59',
    --             'YYYY-MM-DD HH24:MI:SS'
    --         )
    -- ) Q13 ON 1 = 1
    -- LEFT JOIN (
    --     select count(
    --             CASE
    --                 WHEN panic_button = TRUE
    --                 AND prev_state = FALSE THEN 1
    --             END
    --         ) as PANICBTN_PUSHED
    --     from (
    --             SELECT panic_button, timestamp, LAG(panic_button, 1) OVER (
    --                     ORDER BY id
    --                 ) prev_state
    --             from panic_btn_data
    --         ) S1
    --     where
    --         timestamp BETWEEN TO_TIMESTAMP (
    --             '2023-07-01 00:00:00',
    --             'YYYY-MM-DD HH24:MI:SS'
    --         ) AND TO_TIMESTAMP  (
    --             '2024-07-30 23:59:59',
    --             'YYYY-MM-DD HH24:MI:SS'
    --         )
    -- ) Q14 ON 1 = 1





    -- list devices
SELECT
    DEVICES.DEVICE_NAME,
    DEVICES.DEVICE_ID,
    DEVICES.DEVICE_TOKEN,
    DEVICES.TENANT_ID,
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
    DEVICE_PAIRS.TOILET_INFO_ID = '9388096c-784d-49c8-784c-1868b1233165'



-- tenant yang terlibat
select tenant_name, tenant_id, count(tenant_id) from
(SELECT
    DEVICES.DEVICE_NAME,
    DEVICES.DEVICE_ID,
    DEVICES.DEVICE_TOKEN,
    DEVICES.TENANT_ID,
    TOILET_INFOS.TOILET_NAME AS IDENTIFIER,
    TOILET_INFOS.TOILET_INFO_ID AS IDENTIFIER_ID,
    DEVICE_TYPES.DEVICE_TYPE_NAME AS NAMESPACE,
    DEVICE_TYPES.DEVICE_TYPE_ID AS NAMESPACE_ID,
    TOILET_TYPES.TOILET_TYPE_ID,
    TENANTS.TENANT_NAME
FROM
    DEVICE_PAIRS
    JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID
    JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID = DEVICES.DEVICE_TYPE_ID
    JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID
    JOIN TOILET_TYPES ON TOILET_TYPES.TOILET_TYPE_ID = TOILET_INFOS.TOILET_TYPE_ID
    JOIN TENANTS ON DEVICEs.TENANT_ID = TENANTS.TENANT_ID
WHERE
    DEVICE_PAIRS.TOILET_INFO_ID = '9388096c-784d-49c8-784c-1868b1233165')Q1
GROUP BY tenant_id, tenant_name





