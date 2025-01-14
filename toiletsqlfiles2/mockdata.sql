-- Active: 1723732721360@@alpha.vectolabs.com@9998@smarttoilet-staging


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

-- create random functions 
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


CREATE OR REPLACE FUNCTION rand_13() RETURNS INT AS $$
BEGIN
   RETURN floor(random() * (4-1))+1::INT;
END;
$$ LANGUAGE plpgsql;

select rand_13 ()

drop Function rand_13 ()

CREATE OR REPLACE FUNCTION rand_12() RETURNS INT AS $$
BEGIN
   RETURN floor(random() * (2))+1::INT;
END;
$$ LANGUAGE plpgsql;

drop Function rand_12()

CREATE OR REPLACE FUNCTION rand_14() RETURNS INT AS $$
BEGIN
   RETURN floor(random() * (5-1)+1)::INT;
END;
$$ LANGUAGE plpgsql;

select rand_14()

drop Function rand_14 ()

-- rand 1 - 5
CREATE OR REPLACE FUNCTION rand_15() RETURNS INT AS $$
BEGIN
   RETURN floor(random() * (6-1)+1)::INT;
END;
$$ LANGUAGE plpgsql;

select rand_15 ()

drop Function rand_15 ()

CREATE OR REPLACE FUNCTION rand_fp() RETURNS INT AS $$
BEGIN
   RETURN floor(random() * (12-1))+1::INT;
END;
$$ LANGUAGE plpgsql;

select rand_fp()

drop Function rand_fp ()

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
            date_trunc('hour', TO_TIMESTAMP('2025-12-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS')),
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
            date_trunc('minute', TO_TIMESTAMP('2024-08-20 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),
            date_trunc('minute', TO_TIMESTAMP('2025-03-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS')),
            INTERVAL '5 minute'
        ) AS uplinkTS
    LOOP
        env_id := uuid_generate_v4();
        device_token := '127';
        iaq := rand_iaq();
        temperature := rand_temp();
        humidity := rand_humidity();
        lux := rand_lux();
        INSERT INTO enviroment_data ("env_data_id", "device_token", "iaq", "temperature", "humidity", "lux", "timestamp")
        VALUES (env_id, device_token, iaq, temperature, humidity, lux, rec.uplinkTS);
        RAISE NOTICE 'env_id: %, device: %, iaq: %, temp: %, humidity: %, lux:%, timestamp: %',
         env_id, device_token, iaq, temperature, humidity, lux, rec.uplinkTS;
        -- env_id := uuid_generate_v4();
        -- device_token := '115';
        -- iaq := rand_iaq();
        -- temperature := rand_temp();
        -- humidity := rand_humidity();
        -- lux := rand_lux();
        -- INSERT INTO enviroment_data ("env_data_id", "device_token", "iaq", "temperature", "humidity", "lux", "timestamp")
        -- VALUES (env_id, device_token, iaq, temperature, humidity, lux, rec.uplinkTS);
        -- RAISE NOTICE 'env_id: %, device: %, iaq: %, temp: %, humidity: %, lux:%, timestamp: %',
        --  env_id, device_token, iaq, temperature, humidity, lux, rec.uplinkTS;
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
            date_trunc('hour', TO_TIMESTAMP('2024-01-14 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),
            date_trunc('hour', TO_TIMESTAMP('2024-08-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS')),
            INTERVAL '1 hour'
        ) AS uplinkTS
    LOOP
        al := rand_b();  -- Variable assignment with :=
        INSERT INTO panic_btn_data ("device_token", "panic_button", "timestamp")
        VALUES ('130', al, rec.uplinkTS);
        RAISE NOTICE 'device: 130, panic_button: %, timestamp: %', al, rec.uplinkTS;
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
        deviceid = 'bfacd822-e2ee-4a0b-4042-58f0ada3bb48';  -- Variable assignment with :=
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
            date_trunc('minute', TO_TIMESTAMP('2024-07-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),
            date_trunc('minute', TO_TIMESTAMP('2024-12-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS')),
            INTERVAL '5 minute'
        ) AS uplinkTS
    LOOP
        al := rand_b();  -- Variable assignment with :=
        INSERT INTO smoke_data ("device_token", "smoke_sensor", "timestamp")
        VALUES ('128', al, rec.uplinkTS);
        RAISE NOTICE 'device: 128, smoke: %, timestamp: %', al, rec.uplinkTS;
    END LOOP;
END $$;


-- generate mock ppeople counter

select * from counter_data

DO $$
DECLARE
    rec RECORD; 
    ind int;
    outd int;
    ind2 int;
    outd2 int;
    device_t text;
    device_t2 text;
    uuid1 text;
    uuid2 text;
BEGIN
    -- Note: Assume rand_ammonia() is a valid function that returns an integer
    FOR rec IN
        SELECT generate_series(
            date_trunc('minute', TO_TIMESTAMP('2024-08-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),
            date_trunc('minute', TO_TIMESTAMP('2024-08-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS')),
            INTERVAL '1 minute'
        ) AS uplinkTS
    LOOP
        ind := rand_10();
        outd := rand_10 ();
        ind2:= rand_10 ();
        outd2 := rand_10 ();
        uuid1 := uuid_generate_v4 ();
        uuid2 := uuid_generate_v4 ();
        device_t = '118';
        device_t2 = '104';
        
        INSERT INTO counter_data ("counter_data_id", "device_token", "people_in","people_out", "timestamp")
        VALUES (uuid1, device_t,ind, outd, rec.uplinkTS);
        RAISE NOTICE 'uuid: %v, device: %, in: %, out:%, timestamp: %', uuid1, device_t, ind, outd, rec.uplinkTS;
        
        INSERT INTO counter_data ("counter_data_id", "device_token", "people_in","people_out", "timestamp")
        VALUES (uuid2, device_t2,ind, outd, rec.uplinkTS);
        RAISE NOTICE 'uuid: %v, device: %, in: %, out:%, timestamp: %', uuid2, device_t2, ind2, outd2, rec.uplinkTS;
    END LOOP;
END $$;



CREATE SEQUENCE occupancy_data_seq;

nextval('occupancy_data_seq'::regclass)

SELECT * FROM public.occupancy_data ORDER BY id ASC


-- generate mock occupancy data
select * from occupancy_data

DO $$
DECLARE
    rec RECORD; 
    occupied BOOLEAN;
    -- outd int;
    -- ind2 int;
    -- outd2 int;
    device_t text;
    -- device_t2 text;
    -- uuid1 text;
    -- uuid2 text;
BEGIN
    -- Note: Assume rand_ammonia() is a valid function that returns an integer
    FOR rec IN
        SELECT generate_series(
            date_trunc('minute', TO_TIMESTAMP('2024-07-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),
            date_trunc('minute', TO_TIMESTAMP('2024-12-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS')),
            INTERVAL '3 minute'
        ) AS uplinkTS
    LOOP
        occupied := rand_b();
        -- outd := rand_10 ();
        -- ind2:= rand_10 ();
        -- outd2 := rand_10 ();
        -- uuid1 := uuid_generate_v4 ();
        -- uuid2 := uuid_generate_v4 ();
        device_t = '126';
        -- device_t2 = '104';
        
        INSERT INTO occupancy_data ("device_token", "occupied", "timestamp")
        VALUES (device_t, occupied, rec.uplinkTS);
        RAISE NOTICE 'device: %, occupied: %, timestamp: %', device_t, occupied, rec.uplinkTS;
        

    END LOOP;
END $$;


-- mock data auto clean data

-- m4-m1, f4-f1
a26a1af6-3ffa-4cbd-5185-125cc2b94e31
f064a7ee-6568-41fe-4110-19c3d7ea6718
e34a8f65-9524-4a6a-55d5-153217239201
881ac292-f7ba-42ed-61be-7ea9e5368d89

057ba462-c2e6-4d12-69e5-7f2ffac5927f
214a2dcf-7b6e-4e98-5f77-2103dcecf0e7
2512c06f-bf57-45e1-7a7b-5e0935dbbe8d
6a9237e9-9933-4fa2-7f8a-a53978d7271c

DO $$
DECLARE
    rec RECORD; 
    occupied BOOLEAN;
    crid text;
    tenant_id text;
    loc_id text;
    toilet_tid int;
    autoclean int;
    cubical_id text;
    cleanerid text;
BEGIN
    -- Note: Assume rand_ammonia() is a valid function that returns an integer
    FOR rec IN
        SELECT generate_series(
            date_trunc('hour', TO_TIMESTAMP('2024-08-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),
            date_trunc('hour', TO_TIMESTAMP('2024-09-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS')),
            INTERVAL '4 hour'
        ) AS uplinkTS
    LOOP
        occupied := rand_b();
        crid := uuid_generate_v4 ();
        -- m1 3c64d02c-abfb-4b57-5dfe-116d163ecee3 device id, salah
        cubical_id = '6a9237e9-9933-4fa2-7f8a-a53978d7271c'; --pastikan cubical id bukan device id 
        tenant_id := '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'; --mbkemaman
        loc_id := '964cd0a5-8620-4a24-67af-578da8c3b6df'; -- kemaman
        toilet_tid := 1;
        autoclean := rand_10();
        cleanerid := '4b079dad-b330-44ff-78e2-be8fa66c8f3f';

        INSERT INTO cleaner_reports ("cleaner_report_id", "tenant_id", "cleaner_user_id", "location_id", "toilet_type_id", "check_in_ts","check_out_ts","duration","auto_clean_state","created_at","updated_at", "cubical_id")
        VALUES (crid, tenant_id, cleanerid, loc_id, toilet_tid, rec.uplinkTS, rec.uplinkTS, 1.0, autoclean, rec.uplinkTS, rec.uplinkTS, cubical_id);
        RAISE NOTICE '% % % % % % % % % % ',
        crid, tenant_id, loc_id, toilet_tid, rec.uplinkTS, rec.uplinkTS, 1.0, autoclean, rec.uplinkTS, rec.uplinkTS;
        

    END LOOP;
END $$;



-- mock feedback panel data
DO $$
DECLARE
    rec RECORD; 
    fbdataid text;
    fp_token text; --107
BEGIN
    -- Note: Assume rand_ammonia() is a valid function that returns an integer
    FOR rec IN
        SELECT generate_series(
            date_trunc('second', TO_TIMESTAMP('2024-08-13 07:00:00', 'YYYY-MM-DD HH24:MI:SS')),
            date_trunc('second', TO_TIMESTAMP('2024-08-23 17:59:59', 'YYYY-MM-DD HH24:MI:SS')),
            INTERVAL '45 second'
        ) AS uplinkTS
    LOOP

        fbdataid := uuid_generate_v4 ();
        fp_token := '108'; --108 , 117

        INSERT INTO feedback_panel_data("fp_data_id","device_token","button_id","timestamp", "toilet_type_id")
        VALUES (fbdataid, fp_token, rand_fp(), rec.uplinkTS, rand_12());
        RAISE NOTICE '% % % % % ',
        fbdataid, fp_token, rand_fp (), rec.uplinkTS, rand_12 ();
        

    END LOOP;
END $$;


select * from devices where device_type_id = 7

select * from device_types

select * from feedback_panels



-- mock user reaction data
DO $$
DECLARE
    rec RECORD; 
    reid UUID;
    tt INT;
    r INT;
    co INT;
    ti TEXT[] := ARRAY['36f74ec4-cdb0-4271-6c2d-2baa48d6e583','9388096c-784d-49c8-784c-1868b1233165','a97891e5-14df-4f95-7d1e-4ee601581df2'];
    tir INT;
    s INT;
BEGIN
    -- Note: Assume rand_12(), rand_14(), and rand_15() are valid functions that return integers
    FOR rec IN
        SELECT generate_series(
            date_trunc('minute', TO_TIMESTAMP('2024-01-01 07:00:00', 'YYYY-MM-DD HH24:MI:SS')),
            date_trunc('minute', TO_TIMESTAMP('2025-08-15 17:59:59', 'YYYY-MM-DD HH24:MI:SS')),
            INTERVAL '45 minute'
        ) AS uplinkTS
    LOOP
        reid := uuid_generate_v4();  -- Ensure uuid-ossp extension is enabled
        tt := rand_12();            -- Assuming rand_12() returns an integer
        r := rand_14();            -- Assuming rand_14() returns an integer
        co := rand_14();           -- Assuming rand_14() returns an integer
        tir := rand_13();          -- Assuming rand_12() returns an integer
        s := rand_15();           -- Assuming rand_15() returns an integer

        INSERT INTO user_reactions(reaction_id, toilet_type, reaction, complaint, timestamp, toilet_id, score)
        VALUES (reid, tt, r, co, rec.uplinkTS, ti[tir], s);

        RAISE NOTICE '% % % % % % %', reid, tt, r, co, rec.uplinkTS, ti[tir], s;
    END LOOP;
END $$;


-- mock fragrance data
DO $$
DECLARE
    rec RECORD; 
    dtoken text;
    fg_on boolean;
    fg_dur int;

BEGIN
    -- Note: Assume rand_12(), rand_14(), and rand_15() are valid functions that return integers
    FOR rec IN
        SELECT generate_series(
            date_trunc('minute', TO_TIMESTAMP('2024-08-01 07:00:00', 'YYYY-MM-DD HH24:MI:SS')),
            date_trunc('minute', TO_TIMESTAMP('2024-12-15 17:59:59', 'YYYY-MM-DD HH24:MI:SS')),
            INTERVAL '45 minute'
        ) AS uplinkTS
    LOOP
        dtoken = '131';
        fg_on = rand_b();
        fg_dur = rand_14();

        INSERT INTO fragrance_data("device_token", "fragrance_on", "fragrance_duration", "timestamp")
        VALUES (dtoken, fg_on, fg_dur, rec.uplinkTS);

        RAISE NOTICE '% % % %',dtoken, fg_on, fg_dur, rec.uplinkTS;
    END LOOP;
END $$;



--

select * fragrance_data