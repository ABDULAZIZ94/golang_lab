-- Active: 1722425575568@@alpha.vectolabs.com@9998@smarttoilet

-- get device metadata
-- get all devices velong to mbk
SELECT DEVICES.DEVICE_NAME,DEVICES.DEVICE_ID,DEVICES.DEVICE_TOKEN,  
TOILET_INFOS.TOILET_NAME AS Identifier ,DEVICE_TYPES.DEVICE_TYPE_NAME as Namespace,  
DEVICE_TYPES.DEVICE_TYPE_ID AS NAMESPACE_ID , TOILET_INFOS.TOILET_TYPE_ID  
FROM DEVICE_PAIRS  
JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID  
JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID = DEVICES.DEVICE_TYPE_ID  
JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID  
WHERE TOILET_INFOS.TOILET_INFO_ID IN (
    SELECT toilet_info_id
    FROM TOILET_INFOS 
    WHERE tenant_id = 'f8be7a6d-679c-4319-6906-d172ebf7c17e'
)


-- compare
SELECT DEVICES.DEVICE_NAME,DEVICES.DEVICE_ID,DEVICES.DEVICE_TOKEN,  
TOILET_INFOS.TOILET_NAME AS Identifier ,DEVICE_TYPES.DEVICE_TYPE_NAME as Namespace,  
DEVICE_TYPES.DEVICE_TYPE_ID AS NAMESPACE_ID , TOILET_INFOS.TOILET_TYPE_ID  
FROM DEVICE_PAIRS  
JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID  
JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID = DEVICES.DEVICE_TYPE_ID  
JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID  
WHERE toilet_infos.tenant_id = 'f8be7a6d-679c-4319-6906-d172ebf7c17e'


select * from devices

-- sum all data according to device_type_id aka namespace_id
-- make sure apply time interval

-- sum all trafic
-- sum all environment

select * from toilet_infos

select * from device_pairs

-- generate timestamp interval
SELECT uplinkTS  
FROM generate_series(date_trunc('HOUR', TO_TIMESTAMP('2024-07-22 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),  
date_trunc('HOUR', TO_TIMESTAMP('2024-07-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),  
interval '1 HOUR') uplinkTS


WITH GENTIME as (SELECT uplinkTS  
FROM generate_series(date_trunc('HOUR', TO_TIMESTAMP('2024-07-22 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),  
date_trunc('HOUR', TO_TIMESTAMP('2024-07-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),  
interval '1 HOUR') uplinkTS)
select * from GENTIME

-- pakai namespace

-- GetAllGraphAnalytic

-- if namespace id = 2

WITH GENTIME as (SELECT uplinkTS  
FROM generate_series(date_trunc('HOUR', TO_TIMESTAMP('2024-07-22 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),  
date_trunc('HOUR', TO_TIMESTAMP('2024-07-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),  
interval '1 HOUR') uplinkTS)
    SELECT uplinkTS::text, COALESCE(people_in, '0')::text AS people_in, 
    COALESCE(people_out, '0')::text AS people_out  
    FROM GENTIME  
    LEFT JOIN  
    (SELECT date_trunc('HOUR', timestamp) AS uplinkTS,  
    sum(people_in) AS people_in,sum(people_out) AS people_out  
    FROM counter_data  
    WHERE device_token = '2c6d8394-62e5-48a4-4144-d418952449bb'  
    GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC



-- if namespace = 3
WITH GENTIME as (SELECT uplinkTS  
FROM generate_series(date_trunc('HOUR', TO_TIMESTAMP('2024-07-02 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),  
date_trunc('HOUR', TO_TIMESTAMP('2024-07-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS')),  
interval '1 HOUR') uplinkTS)
    SELECT uplinkTS::text, 
    COALESCE(lux, '0')::text AS lux,  
    COALESCE(humidity, '0')::text AS humidity,  
    COALESCE(temperature, '0')::text AS temperature,  
    COALESCE(iaq, '0')::text AS iaq  
    FROM GENTIME  
    LEFT JOIN  
    (SELECT date_trunc('HOUR', timestamp) AS uplinkTS,  
    AVG(lux::decimal) as lux,AVG(humidity::decimal) as humidity,  
    AVG(temperature::decimal) as temperature,AVG(iaq::decimal) as iaq  
    FROM enviroment_data  
    WHERE device_token = 'f16c8aa6-fd8e-4cf5-60a2-bb6175ef4d41'  
    GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC




-- namespace = 7
WITH GENTIME as (SELECT uplinkTS  
FROM generate_series(date_trunc('HOUR', TO_TIMESTAMP('2024-07-22 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),  
date_trunc('HOUR', TO_TIMESTAMP('2024-07-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),  
interval '1 HOUR') uplinkTS)
    SELECT uplinkTS::text, 
    COALESCE(BIN_FULL, '0')::text AS BIN_FULL,  
    COALESCE(BUSUK, '0')::text AS BUSUK,  
    COALESCE(URINAL_CLOG, '0')::text AS URINAL_CLOG,  
    COALESCE(SANITARY_BIN_FULL, '0')::text AS SANITARY_BIN_FULL,  
    COALESCE(PIPE_LEAK, '0')::text AS PIPE_LEAK,  
    COALESCE(SLIPPERY, '0')::text AS SLIPPERY,  
    COALESCE(OUT_TISSUE, '0')::text AS OUT_TISSUE,  
    COALESCE(REFRESH_TOILET, '0')::text AS REFRESH_TOILET,  
    COALESCE(OUT_SOAP, '0')::text AS OUT_SOAP,  
    COALESCE(CLOGGED_TOILET, '0')::text AS CLOGGED_TOILET  
    FROM GENTIME  
    LEFT JOIN  
    (SELECT date_trunc('HOUR', timestamp) AS uplinkTS,  
    COUNT(CASE WHEN BUTTON_ID = 1 THEN 1 END) AS REFRESH_TOILET,  
    COUNT(CASE WHEN BUTTON_ID = 2 THEN 1 END) AS OUT_TISSUE,  
    COUNT(CASE WHEN BUTTON_ID = 3 THEN 1 END) AS BIN_FULL,  
    COUNT(CASE WHEN BUTTON_ID = 4 THEN 1 END) AS OUT_SOAP,  
    COUNT(CASE WHEN BUTTON_ID = 5 THEN 1  END) AS BUSUK,  
    COUNT(CASE WHEN BUTTON_ID = 6 THEN 1 END) AS CLOGGED_TOILET,  
    COUNT(CASE WHEN BUTTON_ID = 7 THEN 1 END) AS URINAL_CLOG,  
    COUNT(CASE WHEN BUTTON_ID = 8 THEN 1 END) AS SLIPPERY,  
    COUNT(CASE WHEN BUTTON_ID = 9 THEN 1 END) AS SANITARY_BIN_FULL,  
    COUNT(CASE WHEN BUTTON_ID = 10 THEN 1 END) AS PIPE_LEAK  
    FROM feedback_panel_data  
    -- // JOIN DEVICES ON DEVICES.DEVICE_TOKEN = FEEDBACK_PANEL_DATA.DEVICE_TOKEN  
    -- // JOIN DEVICE_PAIRS ON DEVICE_PAIRS.DEVICE_ID = DEVICES.DEVICE_ID  
    -- // JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID  
    -- // WHERE device_token = 'ab2130e4-6ae2-4d14-79f1-1511c5b98cd6'  
    WHERE feedback_panel_data.TOILET_TYPE_ID = '3'
    AND feedback_panel_data.DEVICE_TOKEN = ''
    GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC


-- anmespace 13
WITH GENTIME as (SELECT uplinkTS  
FROM generate_series(date_trunc('HOUR', TO_TIMESTAMP('2024-07-02 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),  
date_trunc('HOUR', TO_TIMESTAMP('2024-07-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),  
interval '1 HOUR') uplinkTS)
    SELECT DISTINCT uplinkTS, avg(ammonia_level) as ammonia_level  
    FROM  
    (SELECT date_trunc('HOUR', timestamp) AS uplinkTS, ammonia_level  
    FROM ammonia_data   
    WHERE device_token = '78'   
    GROUP BY uplinkTS, ammonia_level) 
    GROUP BY uplinkTS



select * 
from ammonia_data 
-- join devices on devices.device_token = ammonia_data.device_token
where ammonia_data.TIMESTAMP > TO_TIMESTAMP('2024-07-29 00:00:00', 'YYYY-MM-DD HH24:MI:SS') 
and ammonia_data.device_token = '78'  


-- cleaning frequency

WITH GENTIME as (SELECT uplinkTS  
FROM generate_series(date_trunc('HOUR', TO_TIMESTAMP('2024-07-02 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),  
date_trunc('HOUR', TO_TIMESTAMP('2024-07-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),  
interval '1 HOUR') uplinkTS)
    SELECT uplinkTS::text, 
    COALESCE(TOTAL_MALE,0) AS TOTAL_MALE,  
    COALESCE(TOTAL_FEMALE,0) AS TOTAL_FEMALE  
    FROM GENTIME  
    LEFT JOIN  
    (SELECT date_trunc('HOUR', CHECK_IN_TS) AS uplinkTS,  
    COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 1 THEN 1 END) TOTAL_MALE,  
    COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 2 THEN 1 END) TOTAL_FEMALE  
    FROM CLEANER_REPORTS  
    WHERE CLEANER_REPORTS.LOCATION_ID IN (  
    SELECT location_id from toilet_infos where toilet_info_id IN ( SELECT toilet_info_id FROM TOILET_INFOS WHERE tenant_id = 'f8be7a6d-679c-4319-6906-d172ebf7c17e') ) 
    GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC 

-- locations list for mbk
SELECT location_id from toilet_infos where toilet_info_id IN ( SELECT toilet_info_id FROM TOILET_INFOS WHERE tenant_id = 'f8be7a6d-679c-4319-6906-d172ebf7c17e')

-- cleaner frequency each toilet
WITH GENTIME as (SELECT uplinkTS  
FROM generate_series(date_trunc('HOUR', TO_TIMESTAMP('2024-07-02 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),  
date_trunc('HOUR', TO_TIMESTAMP('2024-07-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),  
interval '1 HOUR') uplinkTS)
    SELECT uplinkTS::text, 
    COALESCE(TOTAL_MALE,0) AS TOTAL_MALE,  
    COALESCE(TOTAL_FEMALE,0) AS TOTAL_FEMALE  
    FROM GENTIME  
    LEFT JOIN  
    (SELECT date_trunc('HOUR', CHECK_IN_TS) AS uplinkTS,  
    COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 1 THEN 1 END) TOTAL_MALE,  
    COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 2 THEN 1 END) TOTAL_FEMALE  
    FROM CLEANER_REPORTS  
    WHERE CLEANER_REPORTS.LOCATION_ID = '57fd94bb-d029-4aa7-7d77-ea8b3f19a330'
    GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC 


select date_trunc('HOUR', CHECK_IN_TS) AS uplinkTS , * 
from cleaner_reports 
where check_in_ts between  TO_TIMESTAMP('2024-07-02 00:00:00', 'YYYY-MM-DD HH24:MI:SS') and  TO_TIMESTAMP('2024-07-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS')



-- additional data for new fp
-- compaint type []
WITH GENTIME as (SELECT uplinkTS  
FROM generate_series(date_trunc('HOUR', TO_TIMESTAMP('2024-07-02 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),  
date_trunc('HOUR', TO_TIMESTAMP('2024-07-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),  
interval '1 HOUR') uplinkTS)
    SELECT uplinkTS::text,  
    COALESCE(smelly_toilet, 0) AS smelly_toilet,  
    COALESCE(out_of_supplies, 0) AS out_of_supplies,  
    COALESCE(wet_floor, 0) AS wet_floor,  
    COALESCE(plumbing_issues, 0) AS plumbing_issues  
    FROM  GENTIME  
    LEFT JOIN  
    (SELECT date_trunc('HOUR', timestamp) AS uplinkTS,  
    COUNT(CASE WHEN ur.complaint = '1' THEN 1 END) AS smelly_toilet,  
    COUNT(CASE WHEN ur.complaint = '2' THEN 1 END) AS out_of_supplies,  
    COUNT(CASE WHEN ur.complaint = '3' THEN 1 END) AS wet_floor,  
    COUNT(CASE WHEN ur.complaint = '4' THEN 1 END) AS plumbing_issues  
    FROM user_reactions ur  
    LEFT JOIN complaints c ON c.complaint_id = ur.complaint  
    WHERE toilet_id IN ( SELECT toilet_info_id FROM TOILET_INFOS WHERE tenant_id = 'f8be7a6d-679c-4319-6906-d172ebf7c17e')  
    GROUP BY uplinkTS)  
    second_query USING (uplinkTS)  
    ORDER BY uplinkTS ASC


-- supporting query
SELECT toilet_info_id FROM TOILET_INFOS WHERE tenant_id = 'f8be7a6d-679c-4319-6906-d172ebf7c17e'

-- 

-- user reaction type
WITH GENTIME as (SELECT uplinkTS  
FROM generate_series(date_trunc('HOUR', TO_TIMESTAMP('2024-07-02 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),  
date_trunc('HOUR', TO_TIMESTAMP('2024-07-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),  
interval '1 HOUR') uplinkTS)
    SELECT uplinkTS::text,  
    COALESCE(smelly_toilet, 0) AS smelly_toilet,  
    COALESCE(out_of_supplies, 0) AS out_of_supplies,  
    COALESCE(wet_floor, 0) AS wet_floor,  
    COALESCE(plumbing_issues, 0) AS plumbing_issues  
    FROM  GENTIME  
    LEFT JOIN  
    (SELECT date_trunc('HOUR', timestamp) AS uplinkTS,  
    COUNT(CASE WHEN ur.complaint = '1' THEN 1 END) AS smelly_toilet,  
    COUNT(CASE WHEN ur.complaint = '2' THEN 1 END) AS out_of_supplies,  
    COUNT(CASE WHEN ur.complaint = '3' THEN 1 END) AS wet_floor,  
    COUNT(CASE WHEN ur.complaint = '4' THEN 1 END) AS plumbing_issues  
    FROM user_reactions ur  
    LEFT JOIN complaints c ON c.complaint_id = ur.complaint  
    WHERE toilet_id = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984'
    GROUP BY uplinkTS)  
    second_query USING (uplinkTS)  
    ORDER BY uplinkTS ASC



select * from user_reactions


-- cleaning performance

WITH GENTIME as (SELECT uplinkTS  
FROM generate_series(date_trunc('DAY', TO_TIMESTAMP('2024-07-02 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),  
date_trunc('DAY', TO_TIMESTAMP('2024-07-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),  
interval '1 DAY') uplinkTS)
    SELECT uplinkTS::text, 
    COALESCE(TOTAL_TIME_MALE,0) AS TOTAL_TIME_MALE,  
    COALESCE(TOTAL_TIME_FEMALE,0) AS TOTAL_TIME_FEMALE,  
    COALESCE(TOTAL_TIME,0) AS TOTAL_TIME  
    FROM GENTIME  
    LEFT JOIN  
    (SELECT date_trunc('DAY', CHECK_IN_TS) AS uplinkTS,  
    AVG(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 1 THEN duration END) TOTAL_TIME_MALE,  
    AVG(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 2 THEN duration END) TOTAL_TIME_FEMALE,  
    AVG(DURATION) TOTAL_TIME  
    FROM CLEANER_REPORTS  
    WHERE CLEANER_REPORTS.LOCATION_ID IN (  
    SELECT location_id from toilet_infos where toilet_info_id IN ( SELECT toilet_info_id FROM TOILET_INFOS WHERE tenant_id = 'f8be7a6d-679c-4319-6906-d172ebf7c17e'))  
    GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC


WITH GENTIME as (SELECT uplinkTS  
FROM generate_series(date_trunc('HOUR', TO_TIMESTAMP('2024-07-02 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),  
date_trunc('HOUR', TO_TIMESTAMP('2024-07-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),  
interval '1 HOUR') uplinkTS)
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
    WHERE CLEANER_REPORTS.LOCATION_ID IN (  
    SELECT location_id from toilet_infos where toilet_info_id IN ( SELECT toilet_info_id FROM TOILET_INFOS WHERE tenant_id = 'f8be7a6d-679c-4319-6906-d172ebf7c17e'))  
    GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC


select * from cleaner_reports
where check_in_ts between  TO_TIMESTAMP('2024-07-02 00:00:00', 'YYYY-MM-DD HH24:MI:SS') and TO_TIMESTAMP('2024-07-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS')


-- distinc  trunct check in ts
select DISTINCT trunc_check_in_ts, count(trunc_check_in_ts) from
    (select date_trunc('HOUR', check_in_ts ) as  trunc_check_in_ts, * from cleaner_reports
    where check_in_ts between  TO_TIMESTAMP('2024-07-02 00:00:00', 'YYYY-MM-DD HH24:MI:SS') and TO_TIMESTAMP('2024-07-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS'))
group by trunc_check_in_ts


-- cleaner reports
select date_trunc('HOUR', check_in_ts ) as  trunc_check_in_ts, 
* from cleaner_reports
where check_in_ts between  TO_TIMESTAMP('2024-07-02 00:00:00', 'YYYY-MM-DD HH24:MI:SS') and TO_TIMESTAMP('2024-07-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS')

-- gentime_f2
create or replace function gentime_f2(start_ts timestamp with time zone, end_ts timestamp with time zone, trunc_s text, interval_s interval)
returns TABLE(uplinkTS TIMESTAMP WITH TIME ZONE)
as $$
begin
    SET timezone = 'Asia/Kuala_Lumpur';
    return query
        SELECT generate_series(date_trunc(trunc_s, start_ts), 
        date_trunc(trunc_s, end_ts),
        interval_s::interval) as uplinkTS;
end;
$$ language PLPGSQL;



-- fail req
SELECT
    DEVICES.DEVICE_NAME,
    DEVICES.DEVICE_ID,
    DEVICES.DEVICE_TOKEN,
    TOILET_INFOS.TOILET_NAME AS Identifier,
    DEVICE_TYPES.DEVICE_TYPE_NAME as Namespace,
    DEVICE_TYPES.DEVICE_TYPE_ID AS NAMESPACE_ID,
    TOILET_INFOS.TOILET_TYPE_ID,
    TOILET_INFOS.TOILET_INFO_ID
FROM
    DEVICE_PAIRS
    JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID
    JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID = DEVICES.DEVICE_TYPE_ID
    JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID
WHERE
    TOILET_INFOS.TOILET_INFO_ID IN (
        SELECT toilet_info_id , *
        FROM TOILET_INFOS
        WHERE
            tenant_id = '992c7123-6eb3-45ee-55ca-71f166f60f53'
    )


--q0
SELECT DEVICES.DEVICE_NAME,
DEVICES.DEVICE_ID,
DEVICES.DEVICE_TOKEN,
TOILET_INFOS.TOILET_NAME AS Identifier,
DEVICE_TYPES.DEVICE_TYPE_NAME as Namespace,
DEVICE_TYPES.DEVICE_TYPE_ID AS NAMESPACE_ID,
TOILET_INFOS.TOILET_TYPE_ID
FROM
    DEVICE_PAIRS
    JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID
    JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID = DEVICES.DEVICE_TYPE_ID
    JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID
WHERE
    TOILET_INFOS.TOILET_INFO_ID IN (
        SELECT toilet_info_id
        FROM TOILET_INFOS
        WHERE
            tenant_id = 'f8be7a6d-679c-4319-6906-d172ebf7c17e'
    )


-- q1 celaner report
WITH
    GENTIME as (
        SELECT uplinkTS
        FROM generate_series(
                date_trunc(
                    'DAY', TO_TIMESTAMP(
                        '2024-07-02', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), date_trunc(
                    'DAY', TO_TIMESTAMP(
                        '2024-07-30', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), interval '1 DAY'
            ) uplinkTS
    )
SELECT
    uplinkTS::text,
    COALESCE(TOTAL_MALE, 0) AS TOTAL_MALE,
    COALESCE(TOTAL_FEMALE, 0) AS TOTAL_FEMALE
FROM GENTIME
    LEFT JOIN (
        SELECT
            date_trunc('DAY', CHECK_IN_TS) AS uplinkTS, COUNT(
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
            CLEANER_REPORTS.LOCATION_ID IN (
                SELECT location_id
                from toilet_infos
                where
                    toilet_info_id IN (
                        SELECT toilet_info_id
                        FROM TOILET_INFOS
                        WHERE
                            tenant_id = 'f8be7a6d-679c-4319-6906-d172ebf7c17e'
                    )
            )
        GROUP BY
            uplinkTS
    ) second_query USING (uplinkTS)
ORDER BY uplinkTS ASC


-- q2 user reactions

WITH
    GENTIME as (
        SELECT uplinkTS
        FROM generate_series(
                date_trunc(
                    'DAY', TO_TIMESTAMP(
                        '2024-07-02', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), date_trunc(
                    'DAY', TO_TIMESTAMP(
                        '2024-07-30', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), interval '1 DAY'
            ) uplinkTS
    )
SELECT
    uplinkTS::text,
    COALESCE(smelly_toilet, 0) AS smelly_toilet,
    COALESCE(out_of_supplies, 0) AS out_of_supplies,
    COALESCE(wet_floor, 0) AS wet_floor,
    COALESCE(plumbing_issues, 0) AS plumbing_issues
FROM GENTIME
    LEFT JOIN (
        SELECT
            date_trunc('DAY', timestamp) AS uplinkTS, COUNT(
                CASE
                    WHEN ur.complaint = '1' THEN 1
                END
            ) AS smelly_toilet, COUNT(
                CASE
                    WHEN ur.complaint = '2' THEN 1
                END
            ) AS out_of_supplies, COUNT(
                CASE
                    WHEN ur.complaint = '3' THEN 1
                END
            ) AS wet_floor, COUNT(
                CASE
                    WHEN ur.complaint = '4' THEN 1
                END
            ) AS plumbing_issues
        FROM
            user_reactions ur
            LEFT JOIN complaints c ON c.complaint_id = ur.complaint
        WHERE
            toilet_id IN (
                SELECT toilet_info_id
                FROM TOILET_INFOS
                WHERE
                    tenant_id = 'f8be7a6d-679c-4319-6906-d172ebf7c17e'
            )
        GROUP BY
            uplinkTS
    ) second_query USING (uplinkTS)
ORDER BY uplinkTS ASC


-- q3 usser reactions
WITH
    GENTIME as (
        SELECT uplinkTS
        FROM generate_series(
                date_trunc(
                    'DAY', TO_TIMESTAMP(
                        '2024-07-02', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), date_trunc(
                    'DAY', TO_TIMESTAMP(
                        '2024-07-30', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), interval '1 DAY'
            ) uplinkTS
    )
SELECT
    uplinkTS::text,
    COALESCE(happy, 0) AS happy,
    COALESCE(satisfied, 0) AS satisfied,
    COALESCE(not_satisfied, 0) AS not_satisfied,
    COALESCE(not_happy, 0) AS not_happy
FROM GENTIME
    LEFT JOIN (
        SELECT
            date_trunc('DAY', timestamp) AS uplinkTS, COUNT(
                CASE
                    WHEN ur.reaction = '1' THEN 1
                END
            ) AS happy, COUNT(
                CASE
                    WHEN ur.reaction = '2' THEN 1
                END
            ) AS satisfied, COUNT(
                CASE
                    WHEN ur.reaction = '3' THEN 1
                END
            ) AS not_satisfied, COUNT(
                CASE
                    WHEN ur.reaction = '4' THEN 1
                END
            ) AS not_happy
        FROM user_reactions ur
        WHERE
            toilet_id IN (
                SELECT toilet_info_id
                FROM TOILET_INFOS
                WHERE
                    tenant_id = 'f8be7a6d-679c-4319-6906-d172ebf7c17e'
            )
        GROUP BY
            uplinkTS
    ) second_query USING (uplinkTS)
ORDER BY uplinkTS ASC


-- q4 env data

WITH
    GENTIME as (
        SELECT uplinkTS
        FROM generate_series(
                date_trunc(
                    'DAY', TO_TIMESTAMP(
                        '2024-07-02', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), date_trunc(
                    'DAY', TO_TIMESTAMP(
                        '2024-07-30', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), interval '1 DAY'
            ) uplinkTS
    )
SELECT
    uplinkTS::text,
    COALESCE(lux, '0')::text AS lux,
    COALESCE(humidity, '0')::text AS humidity,
    COALESCE(temperature, '0')::text AS temperature,
    COALESCE(iaq, '0')::text AS iaq
FROM GENTIME
    LEFT JOIN (
        SELECT
            date_trunc('DAY', timestamp) AS uplinkTS, AVG(lux::decimal) as lux, AVG(humidity::decimal) as humidity, AVG(temperature::decimal) as temperature, AVG(iaq::decimal) as iaq
        FROM enviroment_data
        WHERE
            device_token = '27'
        GROUP BY
            uplinkTS
    ) second_query USING (uplinkTS)
ORDER BY uplinkTS ASC


-- q5 cleaner reports
WITH
    GENTIME as (
        SELECT uplinkTS
        FROM generate_series(
                date_trunc(
                    'DAY', TO_TIMESTAMP(
                        '2024-07-02', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), date_trunc(
                    'DAY', TO_TIMESTAMP(
                        '2024-07-30', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), interval '1 DAY'
            ) uplinkTS
    )
SELECT
    uplinkTS::text,
    COALESCE(TOTAL_MALE, 0) AS TOTAL_MALE,
    COALESCE(TOTAL_FEMALE, 0) AS TOTAL_FEMALE
FROM GENTIME
    LEFT JOIN (
        SELECT
            date_trunc('DAY', CHECK_IN_TS) AS uplinkTS, COUNT(
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
            CLEANER_REPORTS.LOCATION_ID IN (
                SELECT location_id
                from toilet_infos
                where
                    toilet_info_id IN (
                        SELECT toilet_info_id
                        FROM TOILET_INFOS
                        WHERE
                            tenant_id = 'f8be7a6d-679c-4319-6906-d172ebf7c17e'
                    )
            )
        GROUP BY
            uplinkTS
    ) second_query USING (uplinkTS)
ORDER BY uplinkTS ASC

 
-- q6 user reactions

WITH
    GENTIME as (
        SELECT uplinkTS
        FROM generate_series(
                date_trunc(
                    'DAY', TO_TIMESTAMP(
                        '2024-07-02', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), date_trunc(
                    'DAY', TO_TIMESTAMP(
                        '2024-07-30', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), interval '1 DAY'
            ) uplinkTS
    )
SELECT
    uplinkTS::text,
    COALESCE(smelly_toilet, 0) AS smelly_toilet,
    COALESCE(out_of_supplies, 0) AS out_of_supplies,
    COALESCE(wet_floor, 0) AS wet_floor,
    COALESCE(plumbing_issues, 0) AS plumbing_issues
FROM GENTIME
    LEFT JOIN (
        SELECT
            date_trunc('DAY', timestamp) AS uplinkTS, COUNT(
                CASE
                    WHEN ur.complaint = '1' THEN 1
                END
            ) AS smelly_toilet, COUNT(
                CASE
                    WHEN ur.complaint = '2' THEN 1
                END
            ) AS out_of_supplies, COUNT(
                CASE
                    WHEN ur.complaint = '3' THEN 1
                END
            ) AS wet_floor, COUNT(
                CASE
                    WHEN ur.complaint = '4' THEN 1
                END
            ) AS plumbing_issues
        FROM
            user_reactions ur
            LEFT JOIN complaints c ON c.complaint_id = ur.complaint
        WHERE
            toilet_id IN (
                SELECT toilet_info_id
                FROM TOILET_INFOS
                WHERE
                    tenant_id = 'f8be7a6d-679c-4319-6906-d172ebf7c17e'
            )
        GROUP BY
            uplinkTS
    ) second_query USING (uplinkTS)
ORDER BY uplinkTS ASC


-- q7 user reactions
WITH
    GENTIME as (
        SELECT uplinkTS
        FROM generate_series(
                date_trunc(
                    'DAY', TO_TIMESTAMP(
                        '2024-07-02', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), date_trunc(
                    'DAY', TO_TIMESTAMP(
                        '2024-07-30', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), interval '1 DAY'
            ) uplinkTS
    )
SELECT
    uplinkTS::text,
    COALESCE(happy, 0) AS happy,
    COALESCE(satisfied, 0) AS satisfied,
    COALESCE(not_satisfied, 0) AS not_satisfied,
    COALESCE(not_happy, 0) AS not_happy
FROM GENTIME
    LEFT JOIN (
        SELECT
            date_trunc('DAY', timestamp) AS uplinkTS, COUNT(
                CASE
                    WHEN ur.reaction = '1' THEN 1
                END
            ) AS happy, COUNT(
                CASE
                    WHEN ur.reaction = '2' THEN 1
                END
            ) AS satisfied, COUNT(
                CASE
                    WHEN ur.reaction = '3' THEN 1
                END
            ) AS not_satisfied, COUNT(
                CASE
                    WHEN ur.reaction = '4' THEN 1
                END
            ) AS not_happy
        FROM user_reactions ur
        WHERE
            toilet_id IN (
                SELECT toilet_info_id
                FROM TOILET_INFOS
                WHERE
                    tenant_id = 'f8be7a6d-679c-4319-6906-d172ebf7c17e'
            )
        GROUP BY
            uplinkTS
    ) second_query USING (uplinkTS)
ORDER BY uplinkTS ASC


-- q ammonia query
WITH
    GENTIME as (
        SELECT uplinkTS
        FROM generate_series(
                date_trunc(
                    'DAY', TO_TIMESTAMP(
                        '2024-07-02', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), date_trunc(
                    'DAY', TO_TIMESTAMP(
                        '2024-07-30', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), interval '1 DAY'
            ) uplinkTS
    )
SELECT DISTINCT
    uplinkTS,
    avg(ammonia_level) as ammonia_level
FROM (
        SELECT date_trunc('DAY', timestamp) AS uplinkTS, ammonia_level
        FROM ammonia_data
        WHERE
            device_token = '95'
        GROUP BY
            uplinkTS, ammonia_level
    )
GROUP BY
    uplinkTS

-- q ammonia live
WITH
    GENTIME as (
        SELECT uplinkTS
        FROM generate_series(
                date_trunc(
                    'WEEK', TO_TIMESTAMP(
                        '2024-07-01', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), date_trunc(
                    'WEEK', TO_TIMESTAMP(
                        '2024-07-23', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), interval '7 DAY'
            ) uplinkTS
    )
SELECT DISTINCT
    uplinkTS,
    avg(ammonia_level) as ammonia_level
FROM (
        SELECT date_trunc('WEEK', timestamp) AS uplinkTS, ammonia_level
        FROM ammonia_data
        WHERE
            device_token = '95'
        GROUP BY
            uplinkTS, ammonia_level
    )
GROUP BY
    uplinkTS

-- q ammonia cloud
WITH
    GENTIME as (
        SELECT uplinkTS
        FROM generate_series(
                date_trunc(
                    'WEEK', TO_TIMESTAMP(
                        '2024-07-01', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), date_trunc(
                    'WEEK', TO_TIMESTAMP(
                        '2024-07-23', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), interval '7 DAY'
            ) uplinkTS
    )
SELECT DISTINCT
    uplinkTS,
    avg(ammonia_level) as ammonia_level
FROM (
        SELECT date_trunc('WEEK', timestamp) AS uplinkTS, ammonia_level
        FROM ammonia_data
        WHERE
            device_token = '95'
        GROUP BY
            uplinkTS, ammonia_level
    )
GROUP BY
    uplinkTS

-- gentime table
WITH
    GENTIME as (
        SELECT uplinkTS
        FROM generate_series(
                date_trunc(
                    'DAY', TO_TIMESTAMP(
                        '2024-07-02 00:00:00', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), date_trunc(
                    'DAY', TO_TIMESTAMP(
                        ' 2024 -07 -30 23:59:59', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), interval ' 1 DAY '
            ) uplinkTS
    )
    select * from gentime

-- device list table belong to mbk
-- bad query since generate duplicate
WITH DEVICE_LIST as (
    SELECT
        DEVICES.DEVICE_NAME,
        DEVICES.DEVICE_ID,
        DEVICES.DEVICE_TOKEN,
        TOILET_INFOS.TOILET_NAME AS Identifier,
        DEVICE_TYPES.DEVICE_TYPE_NAME as Namespace,
        DEVICE_TYPES.DEVICE_TYPE_ID AS NAMESPACE_ID,
        TOILET_INFOS.TOILET_TYPE_ID
    FROM
        DEVICE_PAIRS
        JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID
        JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID = DEVICES.DEVICE_TYPE_ID
        JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID
    WHERE
        TOILET_INFOS.TOILET_INFO_ID IN (
            SELECT toilet_info_id
            FROM TOILET_INFOS
            WHERE
                tenant_id = 'f8be7a6d-679c-4319-6906-d172ebf7c17e'
        )
)
select distinct device_token, count(device_token) from device_list
group by device_token

-- test duplicate, no duplicate
select DISTINCT  Q1.device_token, count(Q1.device_token) from
(select dp.device_pair_id, dp.toilet_info_id, ti.toilet_name, d.device_name, d.device_token
from
    device_pairs as dp
    join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
    join devices as d on dp.device_id = d.device_id
where
    ti.TOILET_INFO_ID IN (
    SELECT toilet_info_id FROM TOILET_INFOS
    WHERE tenant_id = 'f8be7a6d-679c-4319-6906-d172ebf7c17e')) Q1
group by Q1.device_token

--2nd test
select DISTINCT
    Q1.device_pair_id,
    count(Q1.device_pair_id)
from (
        select dp.device_pair_id, dp.toilet_info_id, ti.toilet_name, d.device_name, d.device_token
        from
            device_pairs as dp
            join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
            join devices as d on dp.device_id = d.device_id
        where
            ti.TOILET_INFO_ID IN (
                SELECT toilet_info_id
                FROM TOILET_INFOS
                WHERE
                    tenant_id = 'f8be7a6d-679c-4319-6906-d172ebf7c17e'
            )
    ) Q1
group by
    Q1.device_token,
    Q1.device_pair_id

-- check duplicate pairs

With 
    multipair as (
        select DISTINCT device_id, count (device_id) as c
        from (select * from device_pairs) Q1 
        group by device_id)
select * from device_pairs 
join devices on device_pairs.device_id = devices.device_id
join toilet_infos on device_pairs.toilet_info_id = toilet_infos.toilet_info_id
join locations on locations.location_id = toilet_infos.location_id
where devices.device_id in(
    select device_id from multipair where c > 1
) order by device_pairs.device_id


-- specific check duplicate
With
    multipair as (
        select DISTINCT
            device_id,
            count(device_id) as c
        from (
                select *
                from device_pairs
            ) Q1
        group by
            device_id
    )
select device_pairs.device_pair_id, devices.device_id,devices.device_name, devices.device_token ,toilet_infos.toilet_name, locations.location_name
from
    device_pairs
    join devices on device_pairs.device_id = devices.device_id
    join toilet_infos on device_pairs.toilet_info_id = toilet_infos.toilet_info_id
    join locations on locations.location_id = toilet_infos.location_id
where
    devices.device_id in (
        select device_id
        from multipair
        where
            c > 1
    )
order by device_pairs.device_id


-- device lists for mbk
select dp.device_pair_id, dp.toilet_info_id, ti.toilet_name, d.device_name, d.device_token
from
    device_pairs as dp
    join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
    join devices as d on dp.device_id = d.device_id
where
    ti.TOILET_INFO_ID IN (
        SELECT toilet_info_id
        FROM TOILET_INFOS
        WHERE
            tenant_id = 'f8be7a6d-679c-4319-6906-d172ebf7c17e'
    )) Q1

-- list devices on that toilet, mkb, taman bandar kuantan, female
select dp.device_pair_id, dp.toilet_info_id, ti.toilet_name, d.device_name
from
    device_pairs as dp
    join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
    join devices as d on dp.device_id = d.device_id
where
    dp.toilet_info_id = '9eca5dcc-7946-4367-60a5-d7bd09b1e16a'

-- solving lux zero
WITH
    GENTIME as (
        SELECT uplinkTS
        FROM generate_series(
                date_trunc(
                    'DAY', TO_TIMESTAMP(
                        '2024-07-02', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), date_trunc(
                    'DAY', TO_TIMESTAMP(
                        '2024-07-30', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), interval '1 DAY'
            ) uplinkTS
    )
SELECT
    uplinkTS::text,
    COALESCE(lux, '0')::text AS lux,
    COALESCE(humidity, '0')::text AS humidity,
    COALESCE(temperature, '0')::text AS temperature,
    COALESCE(iaq, '0')::text AS iaq
FROM GENTIME
    LEFT JOIN (
        SELECT
            date_trunc('DAY', timestamp) AS uplinkTS, AVG(lux::decimal) as lux, AVG(humidity::decimal) as humidity, AVG(temperature::decimal) as temperature, AVG(iaq::decimal) as iaq
        FROM enviroment_data
        WHERE
            device_token = '201'
        GROUP BY
            uplinkTS
    ) second_query USING (uplinkTS)
ORDER BY uplinkTS ASC



-- check environment_data
SELECT
    timestamp AS uplinkTS,
    AVG(lux::decimal) as lux,
    AVG(humidity::decimal) as humidity,
    AVG(temperature::decimal) as temperature,
    AVG(iaq::decimal) as iaq
FROM enviroment_data
WHERE
    device_token = '201'
GROUP BY
    uplinkTS



--- check enviroment device 201
select timestamp, * from enviroment_data
where device_token = '201'
order by timestamp DESC


-- check environemt device and its total data

select distinct device_token , count(device_token)
from
(select * from enviroment_data) Q1
group by device_token


-- environemnt data and its toilet
select distinct
    Q1.device_token,
    count(Q1.device_token),
    tenants.tenant_name
from (
        select *
        from enviroment_data
    ) Q1
left join devices on devices.device_token = Q1.device_token
left join tenants on devices.tenant_id = tenants.tenant_id
group by
    Q1.device_token, tenants.tenant_name


select * from tenants


-- environment device 27
WITH
    GENTIME as (
        SELECT uplinkTS
        FROM generate_series(
                date_trunc(
                    'DAY', TO_TIMESTAMP(
                        '2024-07-02', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), date_trunc(
                    'DAY', TO_TIMESTAMP(
                        '2024-07-30', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), interval '1 DAY'
            ) uplinkTS
    )
SELECT
    uplinkTS::text,
    COALESCE(lux, '0')::text AS lux,
    COALESCE(humidity, '0')::text AS humidity,
    COALESCE(temperature, '0')::text AS temperature,
    COALESCE(iaq, '0')::text AS iaq
FROM GENTIME
    LEFT JOIN (
        SELECT
            date_trunc('DAY', timestamp) AS uplinkTS, AVG(lux::decimal) as lux, AVG(humidity::decimal) as humidity, AVG(temperature::decimal) as temperature, AVG(iaq::decimal) as iaq
        FROM enviroment_data
        WHERE
            device_token = '27'
        GROUP BY
            uplinkTS
    ) second_query USING (uplinkTS)
ORDER BY uplinkTS ASC


-- line 2275
WITH
    GENTIME as (
        SELECT uplinkTS
        FROM generate_series(
                date_trunc(
                    'DAY', TO_TIMESTAMP(
                        '2024-07-02', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), date_trunc(
                    'DAY', TO_TIMESTAMP(
                        '2024-07-30', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), interval '1 DAY'
            ) uplinkTS
    )
SELECT
    uplinkTS::text,
    COALESCE(lux, '0')::text AS lux,
    COALESCE(humidity, '0')::text AS humidity,
    COALESCE(temperature, '0')::text AS temperature,
    COALESCE(iaq, '0')::text AS iaq
FROM GENTIME
    LEFT JOIN (
        SELECT
            date_trunc('DAY', timestamp) AS uplinkTS, AVG(lux::decimal) as lux, AVG(humidity::decimal) as humidity, AVG(temperature::decimal) as temperature, AVG(iaq::decimal) as iaq
        FROM enviroment_data
        WHERE
            device_token = '27'
        GROUP BY
            uplinkTS
    ) second_query USING (uplinkTS)
ORDER BY uplinkTS ASC




-- checking available device types

SELECT DISTINCT Q1.NAMESPACE_ID FROM
(SELECT
DEVICES.DEVICE_NAME,
DEVICES.DEVICE_ID,
DEVICES.DEVICE_TOKEN,
TOILET_INFOS.TOILET_NAME AS Identifier,
DEVICE_TYPES.DEVICE_TYPE_NAME as Namespace,
DEVICE_TYPES.DEVICE_TYPE_ID AS NAMESPACE_ID,
TOILET_INFOS.TOILET_TYPE_ID
FROM
DEVICE_PAIRS
JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID
JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID = DEVICES.DEVICE_TYPE_ID
JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID
WHERE
TOILET_INFOS.TOILET_INFO_ID IN (
    SELECT toilet_info_id
    FROM TOILET_INFOS
    WHERE
        tenant_id = 'f8be7a6d-679c-4319-6906-d172ebf7c17e'
))Q1
GROUP BY Q1.NAMESPACE_ID



-- env query

WITH
    GENTIME as (
        SELECT uplinkTS
        FROM generate_series(
                date_trunc(
                    'DAY', TO_TIMESTAMP(
                        '2024-07-02 00:00:00', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), date_trunc(
                    'DAY', TO_TIMESTAMP(
                        ' 2024 -07 -30 23:59:59', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), interval ' 1 DAY '
            ) uplinkTS
    ),
    DEVICE_LIST as (
        SELECT
            DEVICES.DEVICE_NAME,
            DEVICES.DEVICE_ID,
            DEVICES.DEVICE_TOKEN,
            TOILET_INFOS.TOILET_NAME AS Identifier,
            DEVICE_TYPES.DEVICE_TYPE_NAME as Namespace,
            DEVICE_TYPES.DEVICE_TYPE_ID AS NAMESPACE_ID,
            TOILET_INFOS.TOILET_TYPE_ID
        FROM
            DEVICE_PAIRS
            JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID
            JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID = DEVICES.DEVICE_TYPE_ID
            JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID
        WHERE
            TOILET_INFOS.TOILET_INFO_ID IN (
                SELECT toilet_info_id
                FROM TOILET_INFOS
                WHERE
                    tenant_id = 'f8be7a6d-679c-4319-6906-d172ebf7c17e'
            )
    )
 SELECT
    uplinkTS::text,
    COALESCE(lux, '0')::text AS lux,
    COALESCE(humidity, '0')::text AS humidity,
    COALESCE(temperature, '0')::text AS temperature,
    COALESCE(iaq, '0')::text AS iaq
FROM GENTIME
    LEFT JOIN (
        SELECT
            date_trunc('DAY', timestamp) AS uplinkTS, AVG(lux::decimal) as lux, 
            AVG(humidity::decimal) as humidity, AVG(temperature::decimal) as temperature, 
            AVG(iaq::decimal) as iaq
        FROM enviroment_data
        WHERE
            device_token IN(
                select device_token from DEVICE_LIST
            )
        GROUP BY
            uplinkTS
    ) second_query USING (uplinkTS)
ORDER BY uplinkTS ASC

-- check average per agg from env sensor installed
select distinct ts, avg(iaq) as avg_iaq, avg(temperature) as avg_temp, avg(humidity), avg(lux) as avg_lux
from
(
    select date_trunc('HOUR', timestamp) as ts, iaq, temperature, humidity, lux
    from enviroment_data
)Q1
group by ts


-- check if 200 above is logic lux data
select * from enviroment_data where lux > 200
order by timestamp asc

-- more complex
select device_token, count(timestamp) 
from (
    select * from enviroment_data where lux > 200 order by timestamp asc
) Q1
group by device_token

-- check advanced
select Q1.device_token, count(Q1.timestamp)
from (
        select *
        from enviroment_data
        where
            lux > 200
        order by timestamp asc
    ) Q1
    join (
        select *
        from enviroment_data
        where
            lux > 200
        order by timestamp asc
    ) Q2 on Q1.device_token = Q2.device_token
group by
    Q1.device_token

-- checking basic tables
select * from user_reactions order by timestamp asc limit 10

select * from reactions

select * from complaints

select DISTINCT ts, 
    count(case when reaction = '1' then 1 END) as happy,
    count( case when reaction = '2' then 1 END ) as satisfied,
    count( case when reaction = '3' then 1 END ) as not_satisfied,
    count( case when reaction = '4' then 1 END ) as not_happy
FROM
(select date_trunc('MONTH',timestamp)as ts, reaction, complaint from user_reactions) Q1
group by ts
order by ts


-- check when feedback panel installed
select t.tenant_name,d.created_at, * from devices d 
join tenants t on t.tenant_id = d.tenant_id 
where d.device_type_id = 7



-- namespace 2
WITH
    GENTIME as (
        SELECT uplinkTS
        FROM generate_series(
                date_trunc(
                    'DAY', TO_TIMESTAMP(
                        '2024-07-02 00:00:00', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), date_trunc(
                    'DAY', TO_TIMESTAMP(
                        ' 2024 -07 -30 23:59:59', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), interval ' 1 DAY '
            ) uplinkTS
    ),
    DEVICE_LIST as (
        SELECT
            DEVICES.DEVICE_NAME,
            DEVICES.DEVICE_ID,
            DEVICES.DEVICE_TOKEN,
            TOILET_INFOS.TOILET_NAME AS Identifier,
            DEVICE_TYPES.DEVICE_TYPE_NAME as Namespace,
            DEVICE_TYPES.DEVICE_TYPE_ID AS NAMESPACE_ID,
            TOILET_INFOS.TOILET_TYPE_ID
        FROM
            DEVICE_PAIRS
            JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID
            JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID = DEVICES.DEVICE_TYPE_ID
            JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID
        WHERE
            TOILET_INFOS.TOILET_INFO_ID IN (
                SELECT toilet_info_id
                FROM TOILET_INFOS
                WHERE
                    tenant_id = 'f8be7a6d-679c-4319-6906-d172ebf7c17e'
            )
    )
    SELECT uplinkTS::text, COALESCE(people_in, '0')::text AS people_in, 
    COALESCE(people_out, '0')::text AS people_out  
    FROM GENTIME  
    LEFT JOIN  
    (SELECT date_trunc('DAY', timestamp) AS uplinkTS,  
    sum(people_in) AS people_in,sum(people_out) AS people_out  
    FROM counter_data  
    WHERE device_token IN (select device_token from DEVICE_LIST)  
    GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC


WITH DEVICE_LIST as (
    SELECT
        DEVICES.DEVICE_NAME,
        DEVICES.DEVICE_ID,
        DEVICES.DEVICE_TOKEN,
        TOILET_INFOS.TOILET_NAME AS Identifier,
        DEVICE_TYPES.DEVICE_TYPE_NAME as Namespace,
        DEVICE_TYPES.DEVICE_TYPE_ID AS NAMESPACE_ID,
        TOILET_INFOS.TOILET_TYPE_ID
    FROM
        DEVICE_PAIRS
        JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID
        JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID = DEVICES.DEVICE_TYPE_ID
        JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID
    WHERE
        TOILET_INFOS.TOILET_INFO_ID IN (
            SELECT toilet_info_id
            FROM TOILET_INFOS
            WHERE
                tenant_id = 'f8be7a6d-679c-4319-6906-d172ebf7c17e'
        )
)
select device_list.device_token, device_list.namespace_id from device_list 
/* where device_list.namespace_id = '2' */

select * from counter_data
where counter_data.device_token IN
    (select device_list.device_token from device_list)


select * from counter_data