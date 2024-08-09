-- Active: 1722832765629@@alpha.vectolabs.com@9998@smarttoilet-staging


-- functions

CREATE OR REPLACE FUNCTION gentime_f() RETURNS TABLE(uplinkTS TIMESTAMP WITH TIME ZONE) AS $$
BEGIN
    -- PERFORM set_config('timezone', 'Asia/Kuala_Lumpur', true);
    RETURN QUERY
    SELECT generate_series(
        date_trunc('second', TO_TIMESTAMP('2023-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),
        date_trunc('second', TO_TIMESTAMP('2023-12-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS')),
        INTERVAL '15 second'
    ) AS uplinkTS;
END;
$$ LANGUAGE plpgsql;

drop function gentime_f()

select gentime_f()

{"cputemp":60.8,"deviceToken":1,"humidity":39,"namespace":"FP_SENSOR","rssi":"14","temperature":41.25668,"timestamp":1723097707}

{"namespace":"PING","status":"1","timestamp":1723097724,"devicetoken":"3","identifierID":"1a30dea0-03c9-41d6-5918-b15807c3661f"}

{"namespace":"COUNTER","namespaceID":0,"in":0,"out":0,"timestamp":1723097783}


-- CREATE OR REPLACE FUNCTION random_on() 
-- RETURNS BOOLEAN AS $$
-- BEGIN 
--    RETURN floor(random() * 1 - 0)::BOOLEAN;
-- END;
-- $$ LANGUAGE plpgsql;

SELECT generate_series(
        date_trunc('second', TO_TIMESTAMP('2023-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),
        date_trunc('second', TO_TIMESTAMP('2023-01-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS')),
        INTERVAL '15 second'
) AS uplinkTS

CREATE OR REPLACE FUNCTION rand_b() RETURNS BOOLEAN AS $$
BEGIN
   RETURN random() > 0.5;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION rand_10() RETURNS INT AS $$
BEGIN
   RETURN floor(random() * 2)::INT;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION rand_10() RETURNS INT AS $$
BEGIN
   RETURN floor(random() * 2)::INT;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION rand_12() RETURNS INT AS $$
BEGIN
   RETURN floor(random() * (2))+1::INT;
END;
$$ LANGUAGE plpgsql;

drop Function rand_12()

CREATE OR REPLACE FUNCTION rand_ammonia() RETURNS INT AS $$
BEGIN
   RETURN floor(random() * 255)::INT;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION rand_iaq() RETURNS INT AS $$
BEGIN
   RETURN floor(random() * 85)::INT;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION rand_temp() RETURNS INT AS $$
BEGIN
   RETURN floor(random() * (40-24))+24::INT;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION rand_humidity() RETURNS INT AS $$
BEGIN
   RETURN floor(random() * (90-70))+70::INT;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION rand_lux() RETURNS INT AS $$
BEGIN
   RETURN floor(random() * 1000)::INT;
END;
$$ LANGUAGE plpgsql;

SELECT rand_b();
SELECT rand_10();
SELECT rand_12 ();

select rand_humidity()

SELECT rand_ammonia();

SELECT rand_temp();

SELECT rand_lux();


SELECT substring(md5(random()::text) from 1 for 20)

-- select gen_random_uuid();

-- select random_on()

-- select floor(random() * 2)::INT

-- generate mock ammonia data
DO $$
DECLARE
    rec RECORD; 
    al INT;
BEGIN
    -- Note: Assume rand_ammonia() is a valid function that returns an integer
    FOR rec IN
        SELECT generate_series(
            date_trunc('hour', TO_TIMESTAMP('2023-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),
            date_trunc('hour', TO_TIMESTAMP('2025-01-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS')),
            INTERVAL '6 hour'
        ) AS uplinkTS
    LOOP
        al := rand_ammonia();  -- Variable assignment with :=
        INSERT INTO ammonia_data ("device_token", "ammonia_level", "timestamp")
        VALUES ('113', al, rec.uplinkTS);
        RAISE NOTICE 'device: 113, ammonia: %, timestamp: %', al, rec.uplinkTS;
    END LOOP;
END $$;




CREATE SEQUENCE ammonia_data_seq;

ALTER TABLE my_table ALTER COLUMN id SET NOT NULL;

ALTER TABLE my_table ALTER COLUMN id SET NOT NULL;

SELECT setval('ammonia_data_seq', (SELECT MAX(id) FROM ammonia_data));


-- generate mock env data
-- DO $$
-- DECLARE
--     rec RECORD; 
--     al BOOLEAN;
-- BEGIN
--     -- Note: Assume rand_ammonia() is a valid function that returns an integer
--     FOR rec IN
--         SELECT generate_series(
--             date_trunc('second', TO_TIMESTAMP('2023-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),
--             date_trunc('second', TO_TIMESTAMP('2025-12-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS')),
--             INTERVAL '15 seconds'
--         ) AS uplinkTS
--     LOOP
--         -- Variable assignment with :=
--         env_id := uuid_generate_v4();
--         device_token := '';
--         iaq := rand_iaq();
--         temperature := rand_temp();
--         humidity := rand_humidity();
--         lux := rand_lux();
--         INSERT INTO occupancy_data ("device_token", "occupied", "timestamp")
--         VALUES ('113', al, rec.uplinkTS);
--         RAISE NOTICE 'device: 118, occupied: %, timestamp: %', al, rec.uplinkTS;
--     END LOOP;
-- END $$;

select * from occupancy_data


CREATE SEQUENCE occupancy_data_seq;

ALTER TABLE my_table ALTER COLUMN id SET NOT NULL;

ALTER TABLE my_table ALTER COLUMN id SET NOT NULL;

SELECT setval('occupancy_data_seq', (SELECT MAX(id) FROM ammonia_data));



-- generate mock environmental data
DO $$
DECLARE
    rec RECORD; 
    env_id text;
    device_token text;
    iaq int;
    temperature int;
    humidity int;
    lux int;
BEGIN
    FOR rec IN
        SELECT generate_series(
            date_trunc('hour', TO_TIMESTAMP('2023-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),
            date_trunc('hour', TO_TIMESTAMP('2025-12-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS')),
            INTERVAL '5 hour'
        ) AS uplinkTS
    LOOP
        env_id := uuid_generate_v4();
        device_token := '105';
        iaq := rand_iaq();
        temperature := rand_temp();
        humidity := rand_humidity();
        lux := rand_lux();
        INSERT INTO enviroment_data ("env_data_id", "device_token", "iaq", "temperature", "humidity", "lux", "timestamp")
        VALUES (env_id, device_token, iaq, temperature, humidity, lux, rec.uplinkTS);
        RAISE NOTICE 'env_id: %, device: %, iaq: %, temp: %, humidity: %, lux:%, timestamp: %',
         env_id, device_token, iaq, temperature, humidity, lux, rec.uplinkTS;
        env_id := uuid_generate_v4();
        device_token := '115';
        iaq := rand_iaq();
        temperature := rand_temp();
        humidity := rand_humidity();
        lux := rand_lux();
        INSERT INTO enviroment_data ("env_data_id", "device_token", "iaq", "temperature", "humidity", "lux", "timestamp")
        VALUES (env_id, device_token, iaq, temperature, humidity, lux, rec.uplinkTS);
        RAISE NOTICE 'env_id: %, device: %, iaq: %, temp: %, humidity: %, lux:%, timestamp: %',
         env_id, device_token, iaq, temperature, humidity, lux, rec.uplinkTS;
    END LOOP;
END $$;


select uuid_generate_v4()

--uuid
-- SELECT uuid_in(overlay(overlay(md5(random()::text || ':' || random()::text) placing '4' from 13) placing to_hex(floor(random()*(11-8+1) + 8)::int)::text from 17)::cstring);

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

select * from enviroment_data where device_token = '105' and device_token = '115'

-- 36f74ec4-cdb0-4271-6c2d-2baa48d6e583 
SELECT DEVICES.DEVICE_NAME, DEVICES.DEVICE_ID, DEVICES.DEVICE_TOKEN, TOILET_INFOS.TOILET_NAME AS Identifier, DEVICE_TYPES.DEVICE_TYPE_NAME as Namespace
FROM
    DEVICE_PAIRS
    JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID
    JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID = DEVICES.DEVICE_TYPE_ID
    JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID
WHERE
    DEVICE_PAIRS.TOILET_INFO_ID = '9388096c-784d-49c8-784c-1868b1233165'


WITH
    GENTIME as (
        SELECT uplinkTS
        FROM generate_series(
                date_trunc(
                    'HOUR', TO_TIMESTAMP(
                        '2024-07-22 00:00:00', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), date_trunc(
                    'HOUR', TO_TIMESTAMP(
                        '2024-07-24 23:59:59', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), interval '1 HOUR'
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
            CLEANER_REPORTS.LOCATION_ID = (
                SELECT location_id
                from toilet_infos
                where
                    toilet_info_id = '9388096c-784d-49c8-784c-1868b1233165'
            )
        GROUP BY
            uplinkTS
    ) second_query USING (uplinkTS)
ORDER BY uplinkTS ASC



-- panic btn data
select * from panic_btn_data

select * from panic_btn_data where device_token = '111'

CREATE SEQUENCE panic_btn_seq;
SELECT setval(
        'panic_btn_seq', (
            SELECT MAX(id)
            FROM ammonia_data
        )
    );
-- generate mock panic btn data
DO $$
DECLARE
    rec RECORD; 
    al BOOLEAN;
BEGIN
    -- Note: Assume rand_ammonia() is a valid function that returns an integer
    FOR rec IN
        SELECT generate_series(
            date_trunc('hour', TO_TIMESTAMP('2023-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),
            date_trunc('hour', TO_TIMESTAMP('2025-01-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS')),
            INTERVAL '6 hour'
        ) AS uplinkTS
    LOOP
        al := rand_b();  -- Variable assignment with :=
        INSERT INTO panic_btn_data ("device_token", "panic_button", "timestamp")
        VALUES ('111', al, rec.uplinkTS);
        RAISE NOTICE 'device: 111, panic_button: %, timestamp: %', al, rec.uplinkTS;
    END LOOP;
END $$;



CREATE SEQUENCE violation_id_seq;

SELECT setval(
        'violation_id_seq', (
            SELECT MAX(id)
            FROM ammonia_data
        )
    );

-- generate mock violation data
DO $$
DECLARE
    rec RECORD; 
    al int;
    deviceid text;
BEGIN
    FOR rec IN
        SELECT generate_series(
            date_trunc('hour', TO_TIMESTAMP('2023-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),
            date_trunc('hour', TO_TIMESTAMP('2025-01-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS')),
            INTERVAL '6 hour'
        ) AS uplinkTS
    LOOP
        al := rand_12();
        deviceid = 'd06ce291-d7de-46de-68c0-560e10f69dc2';  -- Variable assignment with :=
        INSERT INTO violation_data("created_at", "updated_at","deleted_at", "violation_type_id", "video_url", "device_id")
        VALUES (current_timestamp, current_timestamp, current_timestamp, al, md5(random()::text), deviceid);
        RAISE NOTICE 'device: %, violation_type: %, timestamp: %',deviceid, al, rec.uplinkTS;
    END LOOP;
END $$;



--
select * from smoke_data

CREATE SEQUENCE smoke_data_seq;

nextval('smoke_data_seq'::regclass)

SELECT setval(
        'smoke_data_seq', (
            SELECT MAX(id)
            FROM ammonia_data
        )
    );
-- generate mock smoke data
DO $$
DECLARE
    rec RECORD; 
    al BOOLEAN;
BEGIN
    -- Note: Assume rand_ammonia() is a valid function that returns an integer
    FOR rec IN
        SELECT generate_series(
            date_trunc('hour', TO_TIMESTAMP('2023-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),
            date_trunc('hour', TO_TIMESTAMP('2025-01-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS')),
            INTERVAL '6 hour'
        ) AS uplinkTS
    LOOP
        al := rand_b();  -- Variable assignment with :=
        INSERT INTO smoke_data ("device_token", "smoke_sensor", "timestamp")
        VALUES ('110', al, rec.uplinkTS);
        RAISE NOTICE 'device: 110, smoke: %, timestamp: %', al, rec.uplinkTS;
    END LOOP;
END $$;