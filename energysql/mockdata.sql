-- Active: 1722832765629@@alpha.vectolabs.com@9998@energy-staging

-- functions
-- activa uuid
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- function rand_str
CREATE OR REPLACE FUNCTION rand_str() RETURNS TEXT AS $$
BEGIN
   RETURN substring( md5(random()::text) from 1 for 20 );
END;
$$ LANGUAGE plpgsql;


select rand_str()

-- function rand bool
CREATE OR REPLACE FUNCTION rand_b() RETURNS BOOLEAN AS $$
BEGIN
   RETURN random() > 0.5;
END;
$$ LANGUAGE plpgsql;

-- function rand 0_360
CREATE OR REPLACE FUNCTION rand_0_360() RETURNS NUMERIC AS $$
BEGIN
   RETURN random() * (360-0)+0;
END;
$$ LANGUAGE plpgsql;

select rand_0_360 ()

drop Function rand_1_1000 ()

-- function rand 50_60
CREATE OR REPLACE FUNCTION rand_50_60() RETURNS NUMERIC AS $$
BEGIN
   RETURN random() * (60-50)+50;
END;
$$ LANGUAGE plpgsql;

select rand_50_60 ()

drop Function rand_1_1000 ()
-- function rand 1000_2000
CREATE OR REPLACE FUNCTION rand_1000_2000() RETURNS NUMERIC AS $$
BEGIN
   RETURN random() * (2000-1000)+1000;
END;
$$ LANGUAGE plpgsql;

select rand_1000_2000 ()

drop Function rand_1000_2000 ()

-- function rand 1_1000
CREATE OR REPLACE FUNCTION rand_1_1000() RETURNS NUMERIC AS $$
BEGIN
   RETURN random() * (1000-1)+1;
END;
$$ LANGUAGE plpgsql;

select rand_1_1000 ()

drop Function rand_1_1000 ()

-- function rand 14
CREATE OR REPLACE FUNCTION rand_14() RETURNS INT AS $$
BEGIN
   RETURN floor(random() * (5-1)+1)::INT;
END;
$$ LANGUAGE plpgsql;

select rand_14 ()

drop Function rand_14 ()


-- generate mock data

-- generate mock energy consuption

    EventLogId text `gorm:"primary_key;unique_index;"`
    DateTime   time.Time
    Title      text
    Place      text
    Address    text
    LogType    int
    Building   text
    Floor      text
    Db         text
    Comments   text


-- mock data energy monitoring
DO $$
DECLARE
    -- Rand_s text;
    rec RECORD; 
    EventLogId UUID; 
    -- DT  timestamptz
    Title      text;
    Place      text;
    Addr       text;
    LogType    int;
    Building   text;
    Floor      text;
    Db         text;
    Comments   text;

BEGIN
    -- Note: Assume rand_12(), rand_14(), and rand_15() are valid functions that return integers
    FOR rec IN
        SELECT generate_series(
            date_trunc('minute', TO_TIMESTAMP('2024-06-01 07:00:00', 'YYYY-MM-DD HH24:MI:SS')),
            date_trunc('minute', TO_TIMESTAMP('2025-08-15 17:59:59', 'YYYY-MM-DD HH24:MI:SS')),
            INTERVAL '45 minute'
        ) AS uplinkTS
    LOOP
        EventLogId := uuid_generate_v4();  -- Ensure uuid-ossp extension is enabled
        Title   :=   'Title '||rand_str();
        Place   :=   'Place '|| rand_str ();
        Addr     :=  'Addr '|| rand_str ();
        LogType  :=  rand_14();
        Building  := 'Building '|| rand_str ();
        Floor     := 'Floor '|| rand_str ();
        Db       :=  'DB '|| rand_str ();
        Comments  := 'Comments '|| rand_str ();

        INSERT INTO event_logs("event_log_id", "date_time", "title", "place", "address", "log_type", "building", "floor", "db", "comments")
        VALUES (EventLogId, rec.uplinkTS, Title, Place, Addr, LogType, Building, Floor,Db ,Comments);

        RAISE NOTICE '% % % % % % % % % %', EventLogId, rec.uplinkTS, Title, Place, Addr, LogType, Building, Floor,Db, Comments;
    END LOOP;
END $$;




-- test
DO $$
DECLARE
    my_variable TEXT := 'title 1';
    my_query TEXT;
BEGIN
    my_query := 'SELECT * FROM event_logs WHERE title = $1';
    EXECUTE my_query USING my_variable;
END $$;



-- mock data buildings
-- test
DO $$
DECLARE
    -- rid TEXT ;
    building_name TEXT;
    latitute NUMERIC;
    longitute NUMERIC;
    tarifid INT;
    area NUMERIC;
    count_lim INT;
BEGIN
    
        -- rid := uuid_generate_v4();
        building_name := rand_str();
        latitute := rand_14();
        longitute := rand_14 ();
        tarifid := rand_14 ();
        area := rand_14 ();
        count_lim := 100;
    while count_lim > 0 loop
        INSERT INTO buildings("building_name", "latitute", "longitute", "tarif_id", "area") VALUES
        (building_name, latitute, longitute, tarifid, area);
        RAISE NOTICE '% % % % % ', building_name, latitute, longitute, tarifid, area;
        count_lim := count_lim - 1 ;
    end loop;
END $$;


-- new mock payloads_data
DO $$
DECLARE
    rec RECORD;
    id TEXT;
    metertoken TEXT;
    color1 TEXT;
    color2 TEXT;
    color3 TEXT;
    current NUMERIC;
    active_power NUMERIC;
    reactive_power NUMERIC;
    apparant_power NUMERIC;
    frequency NUMERIC;
    power_factor NUMERIC;
    phase_angle NUMERIC;
    vthd NUMERIC;
    athd NUMERIC;
    timestamp TIMESTAMP WITH TIME ZONE;
    voltage NUMERIC;
    power_consumption NUMERIC;
BEGIN
power_consumption := 0;
    FOR rec IN
        SELECT generate_series(
            date_trunc('hour', TO_TIMESTAMP('2024-07-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')),
            date_trunc('hour', TO_TIMESTAMP('2024-12-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS')),
            INTERVAL '1 hour'
        ) AS uplinkTS

    LOOP
        --red
        id := uuid_generate_v4();
        metertoken := 'm01';
        color1 := 'RED';
        color2 := 'YELLOW';
        color3 := 'BLUE';
        current := rand_1000_2000();
        active_power := rand_1000_2000 ();
        reactive_power := rand_1000_2000 ();
        apparant_power := rand_1000_2000 ();
        frequency := rand_50_60();
        power_factor := rand_1_1000();
        phase_angle := rand_0_360();
        vthd := rand_1_1000();
        athd := rand_1_1000();
        timestamp := rec.uplinkTS;
        voltage := 1000;

        insert into data_payloads("id", "meter_token", "color", "current", "active_power", "reactive_power", "frequency", "power_factor", "phase_angle",
        "vthd", "athd", "timestamp", "apparant_power", "voltage", "power_consumption") values
        (id, metertoken, color1, current, active_power, reactive_power, frequency, power_factor, phase_angle, vthd,
        athd, timestamp, apparant_power, voltage, power_consumption);

        --yellow
        id := uuid_generate_v4();
        metertoken := 'm01';
        color1 := 'RED';
        color2 := 'YELLOW';
        color3 := 'BLUE';
        current := rand_1000_2000();
        active_power := rand_1000_2000 ();
        reactive_power := rand_1000_2000 ();
        apparant_power := rand_1000_2000 ();
        frequency := rand_50_60();
        power_factor := rand_1_1000();
        phase_angle := rand_0_360();
        vthd := rand_1_1000();
        athd := rand_1_1000();
        timestamp := rec.uplinkTS;
        voltage := 1000;
 
        insert into data_payloads("id", "meter_token", "color", "current", "active_power", "reactive_power", "frequency", "power_factor", "phase_angle",
        "vthd", "athd", "timestamp", "apparant_power", "voltage", "power_consumption") values
        (id, metertoken, color2, current, active_power, reactive_power, frequency, power_factor, phase_angle, vthd,
        athd, timestamp, apparant_power, voltage, power_consumption);

        -- blue
        id := uuid_generate_v4();
        metertoken := 'm01';
        color1 := 'RED';
        color2 := 'YELLOW';
        color3 := 'BLUE';
        current := rand_1000_2000();
        active_power := rand_1000_2000 ();
        reactive_power := rand_1000_2000 ();
        apparant_power := rand_1000_2000 ();
        frequency := rand_50_60();
        power_factor := rand_1_1000();
        phase_angle := rand_0_360();
        vthd := rand_1_1000();
        athd := rand_1_1000();
        timestamp := rec.uplinkTS;
        voltage := 1000;
    
        insert into data_payloads("id", "meter_token", "color", "current", "active_power", "reactive_power", "frequency", "power_factor", "phase_angle",
        "vthd", "athd", "timestamp", "apparant_power", "voltage", "power_consumption") values
        (id, metertoken, color3, current, active_power, reactive_power, frequency, power_factor, phase_angle, vthd,
        athd, timestamp, apparant_power, voltage, power_consumption);

        power_consumption := power_consumption + 1.1;
    END LOOP;
END $$;

delete from data_payloads where power_consumption = 0