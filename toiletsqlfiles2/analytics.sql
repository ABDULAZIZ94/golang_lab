-- Active: 1720588692836@@alpha.vectolabs.com@9998@smarttoilet


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


--gentime function
create or replace function gentime_f(start_ts timestamp with time zone, end_ts timestamp with time zone, trunc_s text, interval_s interval)
returns TABLE(uplinkTS TIMESTAMP)
as $$
begin
    SET timezone = 'Asia/Kuala_Lumpur';
    return query
        SELECT uplinkTS
        FROM generate_series(date_trunc(trunc_s, to_timestamp(start_ts,'YYYY-MM-DD HH24:MI:SS')), 
        date_trunc(trunc_s, to_timestamp(end_ts, 'YYYY-MM-DD HH24:MI:SS')),
        interval_s::interval);
end;
$$ language PLPGSQL;

SET timezone = 'Asia/Kuala_Lumpur';

select gentime_f('2024-07-22 00:00:00'::text , '2024-07-27 23:59:59'::text , 'HOUR'::text, '1 HOUR'::interval)

select gentime_f('2024-07-22 00:00:00'::varchar , '2024-07-27 23:59:59'::text , 'HOUR', '1 HOUR')

select gentime_f('2024-07-22 00:00:00' , '2024-07-27 23:59:59' , 'HOUR'::text, '1 HOUR'::interval)

SELECT gentime_f(
    '2024-07-22 00:00:00'::timestamp,    -- First parameter: Start timestamp
    '2024-07-27 23:59:59'::timestamp,    -- Second parameter: End timestamp
    'HOUR'::text,                        -- Third parameter: Unit of time
    '1 HOUR'::text                       -- Fourth parameter: Interval
);


--gentime function 2
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

drop function gentime_f2;
-- SET timezone = 'Asia/Kuala_Lumpur';

-- select gentime_f('2024-07-22 00:00:00'::text , '2024-07-27 23:59:59'::text , 'HOUR'::text, '1 HOUR'::interval)

-- select gentime_f('2024-07-22 00:00:00'::varchar , '2024-07-27 23:59:59'::text , 'HOUR', '1 HOUR')

select gentime_f2('2024-07-22 00:00:00'::timestamptz , '2024-07-22 23:59:59'::timestamptz , 'HOUR'::text, '1 HOUR'::interval)

-- SELECT gentime_f(
--     '2024-07-22 00:00:00'::timestamp,    -- First parameter: Start timestamp
--     '2024-07-27 23:59:59'::timestamp,    -- Second parameter: End timestamp
--     'HOUR'::text,                        -- Third parameter: Unit of time
--     '1 HOUR'::text                       -- Fourth parameter: Interval
-- );

-- list proc
SELECT proname, nspname
FROM pg_proc
JOIN pg_namespace ON pg_proc.pronamespace = pg_namespace.oid
ORDER BY proname, nspname;

-- raw query
SELECT generate_series(
    date_trunc('week', TO_TIMESTAMP('2024-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),
    date_trunc('week', TO_TIMESTAMP('2024-12-01 23:59:59', 'YYYY-MM-DD HH24:MI:SS')),
    interval '1 week'
) AS uplinkTS


-- DROP FUNCTION IF EXISTS schema_name.function_name(args);

-- drop function if exists public.gentime_f(start_ts timestamp with time zone, end_ts timestamp with time zone, trunc_s text, interval_s interval);

-- list namespace
SELECT nspname
FROM pg_namespace
WHERE nspname NOT LIKE 'pg_%'
    AND nspname <> 'information_schema';


-- list proc
SELECT proname,
       nspname
FROM pg_proc
JOIN pg_namespace ON pg_proc.pronamespace = pg_namespace.oid
ORDER BY proname,
         nspname;


-- gentime f
create or replace function gentime_f() 
    returns table(uplinkTS TIMESTAMP) as $$
begin
    raise notice 'labuuuu';

    SET timezone = 'Asia/Kuala_Lumpur';
    return query
        SELECT generate_series( date_trunc('week', TO_TIMESTAMP('2024-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')), 
        date_trunc('week', TO_TIMESTAMP('2024-12-01 23:59:59', 'YYYY-MM-DD HH24:MI:SS')), interval '1 week') AS uplinkTS;
end;
$$ language PLPGSQL;


drop function gentime_f

select gentime_f()


 -- gentime f
-- CREATE OR REPLACE FUNCTION gentime_f() RETURNS TABLE(uplinkTS TIMESTAMP) AS $$
-- BEGIN
--     -- Set the timezone to 'Asia/Kuala_Lumpur'
--     PERFORM set_config('timezone', 'Asia/Kuala_Lumpur', true);

--     RETURN QUERY
--     SELECT generate_series(
--         date_trunc('week', TO_TIMESTAMP('2024-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),
--         date_trunc('week', TO_TIMESTAMP('2024-12-01 23:59:59', 'YYYY-MM-DD HH24:MI:SS')),
--         INTERVAL '1 week'
--     ) AS uplinkTS;
-- END;
-- $$ LANGUAGE plpgsql;


SELECT * FROM gentime_f();

SELECT gentime_f();

-- prepared statement

PREPARE gt(text) as select gentime_f();

execute gt('aaa')

-- test full
-- gentime f
-- working

CREATE OR REPLACE FUNCTION gentime_f() RETURNS TABLE(uplinkTS TIMESTAMP WITH TIME ZONE) AS $$
BEGIN
    -- PERFORM set_config('timezone', 'Asia/Kuala_Lumpur', true);
    RETURN QUERY
    SELECT generate_series(
        date_trunc('HOUR', TO_TIMESTAMP('2024-07-23 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),
        date_trunc('HOUR', TO_TIMESTAMP('2024-07-23 23:59:59', 'YYYY-MM-DD HH24:MI:SS')),
        INTERVAL '1 HOUR'
    ) AS uplinkTS;
END;
$$ LANGUAGE plpgsql;

drop function gentime_f()

