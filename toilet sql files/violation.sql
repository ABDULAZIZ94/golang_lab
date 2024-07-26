-- Active: 1720683458566@@127.0.0.1@5432@smarttoilet
select *
from violation_data
limit 10
offset 130

select * from device_pairs

select * from locations

select * from toilet_infos

select * from violation_data order by id desc

-- taman bandar da7a998b-94fc-4376-789f-029a93f25f10
select vd.*
from violation_data vd
join device_pairs dp on dp.device_id = vd.device_id 
Where toilet_info_id in (
    select ti.toilet_info_id
    from locations loc
    join toilet_infos ti on ti.location_id =loc.location_id
    where loc.location_id = 'da7a998b-94fc-4376-789f-029a93f25f10'
)
ORDER BY id DESC
limit 10
offset 130

-- individual column
select 
    vd.id, COALESCE(vd.violation,'0')::text as violation, COALESCE(vd.video_url,'0')::text as video_url,
    COALESCE(vd.device_id,'0')::text as device_id, COALESCE(vd.created_at, timestamp '2000-01-01 00:00:00') as created_at
    , COALESCE(vd.updated_at, timestamp '2000-01-01 00:00:00') as updated_at, COALESCE(vd.deleted_at, timestamp '2000-01-01 00:00:00') as deleted_at
from violation_data vd
join device_pairs dp on dp.device_id = vd.device_id 
Where toilet_info_id in (
    select ti.toilet_info_id
    from locations loc
    join toilet_infos ti on ti.location_id =loc.location_id
    where loc.location_id = 'da7a998b-94fc-4376-789f-029a93f25f10'
)
ORDER BY id DESC
-- limit 10
-- offset 130


select vd.*
from
    violation_data vd
    join device_pairs dp on dp.device_id = vd.device_id
Where
    toilet_info_id in (
        select ti.toilet_info_id
        from
            locations loc
            join toilet_infos ti on ti.location_id = loc.location_id
        where
            loc.location_id = 'da7a998b-94fc-4376-789f-029a93f25f10'
    )
ORDER BY id DESC
-- limit 25
-- offset 23





DO $$
DECLARE
    i INT := 1;
BEGIN
    WHILE i <= 100 LOOP
        INSERT INTO violation_data("id","created_at", "updated_at","deleted_at", "violation", "video_url", "device_id")
        VALUES (i,current_timestamp, current_timestamp, current_timestamp, md5(random()::text),md5(random()::text), md5(random()::text));
        i := i +1;
        END LOOP;
END $$;

DO $$
DECLARE
    i INT := 1;
BEGIN
    WHILE i <= 100 LOOP
        INSERT INTO violation_data("created_at", "updated_at","deleted_at", "violation", "video_url", "device_id")
        VALUES (current_timestamp, current_timestamp, current_timestamp, 'Hop over gate', md5(random()::text), '84ae4e2a-b8d7-446f-4bd8-ad658a724ee3');
        i := i +1;
        END LOOP;
END $$;

-- add new device type security_camera

select * from devices

select * from device_types

INSERT INTO
    device_types (
        "device_type_id",
        "device_type_name"
    )
VALUES (14, 'SECURITY_CAMERA')



-- calculate 

select count(id) as total_violation
from violation_data 
where created_at BETWEEN to_timestamp('2024-07-24 00:00:00', 'YYYY-MM-DD HH24:MI:SS') 
    and to_timestamp('2024-07-24 23:59:59', 'YYYY-MM-DD HH24:MI:SS') 






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
            DEVICE_PAIRS.TOILET_INFO_ID = '9eca5dcc-7946-4367-60a5-d7bd09b1e16a'
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
    PANICBTN_STATUS,
    TOTAL_VIOLATION
FROM (
        SELECT SUM(people_in) AS TTLTRAFFIC
        FROM COUNTER_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = COUNTER_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 2
            AND (TIMESTAMP) >= TO_TIMESTAMP(
                '2024-07-23 16:00:00',
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
        WHERE (TIMESTAMP) >= TO_TIMESTAMP(
                '2024-07-23 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
            AND FEEDBACK_PANEL_DATA.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFOS.TOILET_INFO_ID = '9eca5dcc-7946-4367-60a5-d7bd09b1e16a'
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
                    TOILET_INFO_ID = '9eca5dcc-7946-4367-60a5-d7bd09b1e16a'
            )
            AND CLEANER_REPORTS.CREATED_AT >= TO_TIMESTAMP(
                '2024-07-23 16:00:00',
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
                            TOILET_INFO_ID = '9eca5dcc-7946-4367-60a5-d7bd09b1e16a'
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
                    TOILET_INFO_ID = '9eca5dcc-7946-4367-60a5-d7bd09b1e16a'
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
            timestamp BETWEEN TO_TIMESTAMP(
                '2024-07-23 00:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) AND TO_TIMESTAMP(
                '2024-07-24 23:59:59',
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
            TIMESTAMP > TO_TIMESTAMP(
                '2024-07-23 00:00:01',
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
            TIMESTAMP > TO_TIMESTAMP(
                '2024-07-23 00:00:01',
                'YYYY-MM-DD HH24:MI:SS'
            )
        ORDER BY TIMESTAMP DESC
        LIMIT 1
    ) Q12 ON 1 = 1
    LEFT JOIN (
        select count(id) as TOTAL_VIOLATION
        from violation_data
        where
            created_at BETWEEN to_timestamp(
                '2024-07-23 00:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and to_timestamp(
                '2024-07-23 23:59:59',
                'YYYY-MM-DD HH24:MI:SS'
            )  
    )Q13 ON 1 = 1




select * from panic_btn_data

    -- panic button activated today
select count(
    CASE WHEN panic_button = TRUE AND prev_state = FALSE THEN 1 END
) as PANICBTN_PUSHED
from (
    SELECT panic_button, 
    timestamp,
    LAG(panic_button, 1) OVER (
            ORDER BY id
        ) prev_state
    from panic_btn_data
)
where timestamp BETWEEN to_timestamp('2024-07-24 00:00:00', 'YYYY-MM-DD HH24:MI:SS') 
    and to_timestamp('2024-07-24 23:59:59', 'YYYY-MM-DD HH24:MI:SS') 



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
    AMMONIA_LEVEL,
    SMOKE_SENSOR,
    PANICBTN_STATUS,
    TOTAL_VIOLATION,
    PANICBTN_PUSHED
FROM (
        SELECT SUM(people_in) AS TTLTRAFFIC
        FROM COUNTER_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = COUNTER_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 2
            AND (TIMESTAMP) >= TO_TIMESTAMP(
                '2024-07-23 16:00:00',
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
                '2024-07-23 16:00:00',
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
                '2024-07-23 16:00:00',
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
        SELECT avg(ammonia_level) as AMMONIA_LEVEL
        FROM ammonia_data
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = ammonia_data.DEVICE_TOKEN
        WHERE
            timestamp BETWEEN TO_TIMESTAMP(
                '2024-07-23 00:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) AND TO_TIMESTAMP(
                '2024-07-24 23:59:59',
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
            TIMESTAMP > TO_TIMESTAMP(
                '2024-07-23 00:00:01',
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
            TIMESTAMP > TO_TIMESTAMP(
                '2024-07-23 00:00:01',
                'YYYY-MM-DD HH24:MI:SS'
            )
        ORDER BY TIMESTAMP DESC
        LIMIT 1
    ) Q12 ON 1 = 1
    LEFT JOIN (
        select count(id) as TOTAL_VIOLATION
        from violation_data
        where
            created_at BETWEEN to_timestamp(
                '2024-07-24 00:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and to_timestamp(
                '2024-07-24 23:59:59',
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
            timestamp BETWEEN to_timestamp(
                '2024-07-24 00:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and to_timestamp(
                '2024-07-24 23:59:59',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q14 ON 1=1

-- modify violation data

select * from violation_data

alter table violation_data rename column "violation_id" to "violation_type_id"

ALTER TABLE violation_data ALTER COLUMN "violation_id" TYPE integer USING "violation_id"::integer;

UPDATE violation_data SET "violation_id" = '1' where "violation_id" = 'Hop over gate'


select * from violation_type