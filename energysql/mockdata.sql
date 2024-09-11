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

