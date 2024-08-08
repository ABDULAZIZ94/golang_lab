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

CREATE OR REPLACE FUNCTION rand_lux() RETURNS INT AS $$
BEGIN
   RETURN floor(random() * 1000)::INT;
END;
$$ LANGUAGE plpgsql;

SELECT rand_b();
SELECT rand_10();

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
            date_trunc('second', TO_TIMESTAMP('2023-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),
            date_trunc('second', TO_TIMESTAMP('2023-01-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS')),
            INTERVAL '15 seconds'
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


-- generate mock occupancy data
DO $$
DECLARE
    rec RECORD; 
    al BOOLEAN;
BEGIN
    -- Note: Assume rand_ammonia() is a valid function that returns an integer
    FOR rec IN
        SELECT generate_series(
            date_trunc('second', TO_TIMESTAMP('2023-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),
            date_trunc('second', TO_TIMESTAMP('2025-12-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS')),
            INTERVAL '15 seconds'
        ) AS uplinkTS
    LOOP
        al := rand_b();  -- Variable assignment with :=
        INSERT INTO occupancy_data ("device_token", "occupied", "timestamp")
        VALUES ('113', al, rec.uplinkTS);
        RAISE NOTICE 'device: 118, occupied: %, timestamp: %', al, rec.uplinkTS;
    END LOOP;
END $$;

select * from occupancy_data


CREATE SEQUENCE occupancy_data_seq;

ALTER TABLE my_table ALTER COLUMN id SET NOT NULL;

ALTER TABLE my_table ALTER COLUMN id SET NOT NULL;

SELECT setval('occupancy_data_seq', (SELECT MAX(id) FROM ammonia_data));



-- generate mock environmental data
DO $$
DECLARE
    rec RECORD; 
    al BOOLEAN;
BEGIN
    FOR rec IN
        SELECT generate_series(
            date_trunc('second', TO_TIMESTAMP('2023-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),
            date_trunc('second', TO_TIMESTAMP('2025-12-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS')),
            INTERVAL '15 seconds'
        ) AS uplinkTS
    LOOP
        al := rand_b();  -- Variable assignment with :=
        INSERT INTO enviroment_data ("device_token", "occupied", "timestamp")
        VALUES ('113', al, rec.uplinkTS);
        RAISE NOTICE 'device: 118, occupied: %, timestamp: %', al, rec.uplinkTS;
    END LOOP;
END $$;


select uuid_generate_v4()

--uuid
-- SELECT uuid_in(overlay(overlay(md5(random()::text || ':' || random()::text) placing '4' from 13) placing to_hex(floor(random()*(11-8+1) + 8)::int)::text from 17)::cstring);

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

select * from enviroment_data