-- Active: 1722832765629@@alpha.vectolabs.com@9998@smarttoilet-staging
-- alter table
alter table cleaner_reports add column cubical_alias_id int

ALTER TABLE cleaner_reports RENAME COLUMN cubical_alias_id TO device_aliases

ALTER TABLE cleaner_reports RENAME COLUMN device_aliases TO cubical_tag

ALTER TABLE cleaner_reports RENAME COLUMN cubical_tag TO cubical_id


DELETE FROM cleaner_reports WHERE created_at > NOW() 

SELECT * FROM cleaner_reports
WHERE
    created_at > NOW() - interval '2 hour'

-- DELETE FROM cleaner_reports WHERE created_at > NOW() - interval '1 hour'

ALTER TABLE cleaner_reports
ALTER COLUMN cubical_tag 
TYPE text;

-- check table

select * from devices

select * from device_types

select * from cleaner_reports order by created_at desc limit 10

delete from cleaner_reports where creatd_at > NOW()

-- kemaman tenant 589ee2f0-75e1-4cd0-5c74-78a4df1288fd 
select * from cleaner_reports where tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd' order by created_at desc limit 10

select * from cleaner_reports where auto_clean_state = '1' order by created_at asc

--cleaner user id 7a1c3658-d58b-46ca-6935-6a0835477b69 
select * from users where user_id ='4b079dad-b330-44ff-78e2-be8fa66c8f3f'

select * from users


select * from cleaner_reports where auto_clean_state = '1' order by created_at asc

-- count how may auto cleans
select distinct tenant_id, count(tenant_id) from
(select *
from cleaner_reports
where
    auto_clean_state = '1'
order by created_at) Q1
group BY tenant_id

select * from tenants

select * from device_aliases


select * from cleaner_reports order by created_at desc limit 1

select * from cleaner_reports where cleaner_report_id = ''

-- Insert into cleaner_reports 

select * from toilet_infos

select * from cleaner_reports

select * from cleaner_reports where created_at between now() and now()+ interval '5 minute'

select * from cleaner_reports where created_at between now() and now()+ interval '5 minute' and auto_clean_state ='1'

SELECT *
FROM cleaner_reports
WHERE
    created_at BETWEEN NOW() - INTERVAL '5 minute' AND NOW();

select ti.toilet_info_id, auto_clean_state 
from cleaner_reports cr
join toilet_infos ti on ti.location_id = cr.location_id and ti.toilet_type_id = cr.toilet_type_id


--
insert into
    cleaner_reports (
        cleaner_report_id,
        tenant_id,
        location_id,
        toilet_type_id,
        check_in_ts,
        check_out_ts,
        duration,
        auto_clean_state,
        created_at,
        updated_at,
        cubical_id
    )
VALUES (
        uuid_generate_v4 (),
        '589ee2f0-75e1-4cd0-5c74-78a4df1288fd',
        '964cd0a5-8620-4a24-67af-578da8c3b6df',
        '2',
        NOW(),
        NOW() + interval '15 secs',
        15,
        '1',
        NOW(),
        NOW() + interval '15 secs',
        NULL
    )




    --
    WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('DAY', TO_TIMESTAMP('2024-08-20 07:00:00', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('DAY', TO_TIMESTAMP('2024-08-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')), interval '1 DAY') uplinkTS)  SELECT uplinkTS::text, COALESCE(TOTAL,0) AS TOTAL FROM GENTIME LEFT JOIN (SELECT date_trunc('DAY', CHECK_IN_TS) AS uplinkTS, COUNT(CLEANER_REPORT_ID) AS TOTAL FROM CLEANER_REPORTS WHERE CLEANER_REPORTS.tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd' ANd created_at between to_timestamp('2024-08-20 07:00:00', YYYY-MM-DD HH24:MI:SS') and to_timestamp('2024-08-20 18:00:00', YYYY-MM-DD HH24:MI:SS') GROUP BY uplinkTS) second_query USING (uplinkTS) order by uplinkTS 

-- update cleaner records

select * from cleaner_reports limit 1

-- update cleaner_reports
-- set task_completed = ["clean toilet", "refill soap", "wipe toilet mirror"],
-- remarks = "smart-toilet santai bersih dan selesa. "
-- where
--     tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'

UPDATE cleaner_reports
SET
    task_completed = ARRAY[
        'clean toilet',
        'refill soap',
        'wipe toilet mirror'
    ],
    remarks = 'smart-toilet santai bersih dan selesa.'
WHERE
    tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd';




-- test query
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
            TOILET_INFOS.TOILET_INFO_ID = '3194cc8d-31f9-4441-504d-c45758ed9559'
            AND TOILET_INFOS.LOCATION_ID = '2a83bc9b-0dba-451e-7760-a29bfc3db337'
    )
SELECT
    COALESCE(TRAFFIC_COUNT_TODAY, 0) as TRAFFIC_COUNT_TODAY,
    COALESCE(
        TOTAL_FRAGRANCE_SPRAY_ACTIVATED,
        0
    ) as TOTAL_FRAGRANCE_SPRAY_ACTIVATED,
    LAST_FRAGRANCE_SPRAY_ACTIVATED,
    CURRENT_LUX,
    COALESCE(CURRENT_IAQ, 0) as CURRENT_IAQ,
    COALESCE(TOTAL_CLEANED_TODAY, 0) as TOTAL_CLEANED_TODAY,
    LAST_CLEAN_TIMESTAMP,
    COALESCE(CURRENT_HUMIDITY, 0) as CURRENT_HUMIDITY,
    COALESCE(CURRENT_TEMPERATURE, 0) as CURRENT_TEMPERATURE
FROM (
        select sum(people_in) as TRAFFIC_COUNT_TODAY
        from (
                select people_in, timestamp
                from counter_data
                where
                    device_token in (
                        select device_token
                        from DEVICE_LIST
                        where
                            namespace_id = 2
                    )
            ) s1
        where
            timestamp between TO_TIMESTAMP(
                '2024-11-11 23:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and TO_TIMESTAMP(
                '2024-11-12 11:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q1
    LEFT JOIN (
        select
            timestamp as LAST_FRAGRANCE_SPRAY_ACTIVATED
        from fragrance_data
        where
            device_token in (
                select device_token
                from DEVICE_LIST
                where
                    namespace_id = 5
            )
        order by timestamp desc
        limit 1
    ) Q2 ON 1 = 1
    LEFT JOIN (
        select
            iaq as CURRENT_IAQ,
            (
                CASE
                    WHEN lux > 1.5 THEN 'BRIGHT'
                    ELSE 'DARK'
                END
            ) as CURRENT_LUX,
            humidity as CURRENT_HUMIDITY,
            temperature as CURRENT_TEMPERATURE
        from enviroment_data
        where
            device_token in (
                select device_token
                from DEVICE_LIST
                where
                    namespace_id = 3
            )
            AND (
                timestamp::time >= '23:00:00'
                OR (
                    timestamp::time >= '00:00:00'
                    AND timestamp::time <= '11:00:00'
                )
            )
            AND timestamp between TO_TIMESTAMP(
                '2024-11-11 23:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and TO_TIMESTAMP(
                '2024-11-12 11:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
        order by timestamp desc
        limit 1
    ) Q3 ON 1 = 1
    LEFT JOIN (
        select count(cleaner_report_id) as TOTAL_CLEANED_TODAY
        from cleaner_reports
        where (
                check_in_ts::time >= '23:00:00'
                OR (
                    check_in_ts::time >= '00:00:00'
                    AND check_in_ts::time <= '11:00:00'
                )
            )
            and check_in_ts between TO_TIMESTAMP(
                '2024-11-11 23:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and TO_TIMESTAMP(
                '2024-11-12 11:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q4 ON 1 = 1
    LEFT JOIN (
        select
            created_at as LAST_CLEAN_TIMESTAMP
        from cleaner_reports
        where (
                check_in_ts::time >= '23:00:00'
                OR (
                    check_in_ts::time >= '00:00:00'
                    AND check_in_ts::time <= '11:00:00'
                )
            )
            -- and (auto_clean_state = '0' or auto_clean_state is null)
            and check_in_ts between TO_TIMESTAMP(
                '2024-11-11 23:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and TO_TIMESTAMP(
                '2024-11-12 11:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
        order by created_at
        limit 1
    ) Q5 ON 1 = 1
    LEFT JOIN (
        select
            count(id) as TOTAL_FRAGRANCE_SPRAY_ACTIVATED
        from fragrance_data
        where
            fragrance_on = true
            AND device_token in (
                select device_token
                from device_list
                where
                    namespace_id = 5
            )
            AND (
                timestamp::time >= '23:00:00'
                OR (
                    timestamp::time >= '00:00:00'
                    AND timestamp::time <= '11:00:00'
                )
            )
            AND timestamp between TO_TIMESTAMP(
                '2024-11-11 23:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and TO_TIMESTAMP(
                '2024-11-12 11:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q6 ON 1 = 1 [
        1 rows affected
        or returned
    ]




    --
 SELECT locations.*, ARRAY_AGG(
        TOILET_INFOS.TOILET_INDEX || ':' || TOILET_INFOS.TOILET_INFO_ID
        ORDER BY TOILET_INFOS.CREATED_AT DESC
    ) AS TOILET_LIST
FROM
    locations
    JOIN toilet_infos ON toilet_infos.location_id = LOCATIONS.location_id
    JOIN contractor_and_tenants ON contractor_and_tenants.tenant_id = LOCATIONS.tenant_id
    JOIN CLEANER_AND_TENANTS ON CLEANER_AND_TENANTS.TENANT_ID = LOCATIONS.TENANT_ID
WHERE
    contractor_and_tenants.CONTRACTOR_ID = '2291ed0a-0ef0-4114-72d1-f61313eb40c0'
    AND CLEANER_AND_TENANTS.CLEANER_ID = 'a816fad3-9fe0-4c94-517f-d2545741d82e'
GROUP BY
    LOCATIONS.LOCATION_ID

--
WITH LOCATIONS_INVOLVED as (
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
        -- AND CREATED_AT > CURRENT_TIMESTAMP - INTERVAL '1 hour'
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



--- toilet
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
            TOILET_INFOS.TOILET_INFO_ID = '3194cc8d-31f9-4441-504d-c45758ed9559'
            AND TOILET_INFOS.LOCATION_ID = '2a83bc9b-0dba-451e-7760-a29bfc3db337'
    )
SELECT
    COALESCE(TRAFFIC_COUNT_TODAY, 0) as TRAFFIC_COUNT_TODAY,
    COALESCE(
        TOTAL_FRAGRANCE_SPRAY_ACTIVATED,
        0
    ) as TOTAL_FRAGRANCE_SPRAY_ACTIVATED,
    LAST_FRAGRANCE_SPRAY_ACTIVATED,
    CURRENT_LUX,
    COALESCE(CURRENT_IAQ, 0) as CURRENT_IAQ,
    COALESCE(TOTAL_CLEANED_TODAY, 0) as TOTAL_CLEANED_TODAY,
    LAST_CLEAN_TIMESTAMP,
    COALESCE(CURRENT_HUMIDITY, 0) as CURRENT_HUMIDITY,
    COALESCE(CURRENT_TEMPERATURE, 0) as CURRENT_TEMPERATURE
FROM (
        select sum(people_in) as TRAFFIC_COUNT_TODAY
        from (
                select people_in, timestamp
                from counter_data
                where
                    device_token in (
                        select device_token
                        from DEVICE_LIST
                        where
                            namespace_id = 2
                    )
            ) s1
        where
            timestamp between TO_TIMESTAMP(
                '2024-11-11 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and TO_TIMESTAMP(
                '2024-11-12 15:59:59',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q1
    LEFT JOIN (
        select
            timestamp as LAST_FRAGRANCE_SPRAY_ACTIVATED
        from fragrance_data
        where
            device_token in (
                select device_token
                from DEVICE_LIST
                where
                    namespace_id = 5
            )
        order by timestamp desc
        limit 1
    ) Q2 ON 1 = 1
    LEFT JOIN (
        select
            iaq AS CURRENT_IAQ,
            (
                CASE
                    WHEN lux > 1000 THEN 'BRIGHT'
                    WHEN lux > 400 THEN 'NORMAL'
                    WHEN lux > 200 THEN 'DIM'
                    ELSE 'DARK'
                END
            ) AS CURRENT_LUX,
            humidity AS CURRENT_HUMIDITY,
            temperature as CURRENT_TEMPERATURE
        from enviroment_data
        where
            device_token in (
                select device_token
                from DEVICE_LIST
                where
                    namespace_id = 3
            )
            AND (
                timestamp::time >= '16:00:00'
                OR (
                    timestamp::time >= '00:00:00'
                    AND timestamp::time <= '15:59:59'
                )
            )
            AND timestamp between TO_TIMESTAMP(
                '2024-11-11 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and TO_TIMESTAMP(
                '2024-11-12 15:59:59',
                'YYYY-MM-DD HH24:MI:SS'
            )
        order by timestamp desc
        limit 1
    ) Q3 ON 1 = 1
    LEFT JOIN (
        select count(cleaner_report_id) as TOTAL_CLEANED_TODAY
        from cleaner_reports
        where
            check_in_ts between TO_TIMESTAMP(
                '2024-11-11 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and TO_TIMESTAMP(
                '2024-11-12 15:59:59',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q4 ON 1 = 1
    LEFT JOIN (
        select
            created_at as LAST_CLEAN_TIMESTAMP
        from cleaner_reports
        where
            location_id = '2a83bc9b-0dba-451e-7760-a29bfc3db337'
            and toilet_type_id = '1'
            and check_in_ts between TO_TIMESTAMP(
                '2024-11-12 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and TO_TIMESTAMP(
                '2024-11-13 15:59:59',
                'YYYY-MM-DD HH24:MI:SS'
            )
        order by created_at desc
        limit 1
    ) Q5 ON 1 = 1
    LEFT JOIN (
        select
            count(id) as TOTAL_FRAGRANCE_SPRAY_ACTIVATED
        from fragrance_data
        where
            fragrance_on = true
            AND device_token in (
                select device_token
                from device_list
                where
                    namespace_id = 5
            )
            AND (
                timestamp::time >= '16:00:00'
                OR (
                    timestamp::time >= '00:00:00'
                    AND timestamp::time <= '15:59:59'
                )
            )
            AND timestamp between TO_TIMESTAMP(
                '2024-11-11 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and TO_TIMESTAMP(
                '2024-11-12 15:59:59',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q6 ON 1 = 1



select * from public.cleaner_reports where location_id ='2a83bc9b-0dba-451e-7760-a29bfc3db337' order by check_out_ts desc limit 1



SELECT TOILET_TYPE_ID::int FROM TOILET_INFOS WHERE TOILET_INFO_ID = '3194cc8d-31f9-4441-504d-c45758ed9559' LIMIT 1




 WITH DEVICE_LIST AS (
        SELECT 
                DEVICES.DEVICE_NAME, DEVICES.DEVICE_ID, DEVICES.DEVICE_TOKEN,
                TOILET_INFOS.TOILET_NAME AS IDENTIFIER, TOILET_INFOS.TOILET_INFO_ID AS IDENTIFIER_ID,
                DEVICE_TYPES.DEVICE_TYPE_NAME AS NAMESPACE, DEVICE_TYPES.DEVICE_TYPE_ID AS NAMESPACE_ID,
                TOILET_TYPES.TOILET_TYPE_ID 
        FROM DEVICE_PAIRS 
        JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID 
        JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID = DEVICES.DEVICE_TYPE_ID 
        JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID 
        JOIN TOILET_TYPES ON TOILET_TYPES.TOILET_TYPE_ID = TOILET_INFOS.TOILET_TYPE_ID 
        WHERE TOILET_INFOS.LOCATION_ID = '2a83bc9b-0dba-451e-7760-a29bfc3db337' 
        AND TOILET_INFOS.LOCATION_ID = '2a83bc9b-0dba-451e-7760-a29bfc3db337' ) , 
        GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('HOUR', TO_TIMESTAMP('2024-11-11 16:00:00', 'YYYY-MM-DD HH24:MI:SS')), 
        date_trunc('HOUR', TO_TIMESTAMP('2024-11-12 15:59:59', 'YYYY-MM-DD HH24:MI:SS')), interval '1 HOUR') uplinkTS where  
        ((uplinkTS::time >= '16:00:00'  OR (uplinkTS::time >= '00:00:00' AND uplinkTS::time <= '15:59:59') ) ))
        SELECT COALESCE(TotalCollection,0) as TOTAL_COLLECTION, COALESCE(TotalTraffic, 0)as TOTAL_TRAFFIC, 
        UplinkTS as uplinkTS from GENTIME G LEFT JOIN 
        (select distinct UplinkTS, sum(RM) as TotalCollection from (select date_trunc('HOUR', created_at) as UplinkTS, ammount as RM from money_data md 
        where md.tenant_id = '984bbf11-868c-43e8-6c5e-d9a0151fefc6' AND created_at between to_timestamp('2024-11-11 16:00:00' ,'YYYY-MM-DD HH24:MI:SS') AND
         to_timestamp('2024-11-12 15:59:59' ,'YYYY-MM-DD HH24:MI:SS') )S1 group by UplinkTS, RM) Q1 USING (UplinkTS) LEFT JOIN ( select  date_trunc('HOUR', timestamp) as
          UplinkTS, sum(people_in) as TotalTraffic from counter_data where device_token in (select device_token from device_list where namespace_id = 2) and timestamp between
           to_timestamp('2024-11-11 16:00:00' ,'YYYY-MM-DD HH24:MI:SS') AND to_timestamp('2024-11-12 15:59:59' ,'YYYY-MM-DD HH24:MI:SS') group by UplinkTS )Q2 using (UplinkTS) order by UplinkTS  
