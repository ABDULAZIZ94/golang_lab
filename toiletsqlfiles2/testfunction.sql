-- Active: 1722094393794@@157.230.253.116@5432@smarttoilet
-- fix
CREATE OR REPLACE FUNCTION gentime_f(
    start_ts TIMESTAMP,      -- Timestamp with time zone
    end_ts TIMESTAMP,        -- Timestamp with time zone
    trunc_s TEXT,             -- Text specifying truncation (e.g., 'hour', 'day')
    interval_s INTERVAL       -- Interval for generating the series
)
RETURNS TABLE(uplinkTS TIMESTAMP)  -- Ensure return type matches TIMESTAMP
AS $$
BEGIN
    RAISE NOTICE 'Start timestamp: %', start_ts;
    RAISE NOTICE 'End timestamp: %', end_ts;
    
    RETURN QUERY
    SELECT generate_series(
        date_trunc(trunc_s, start_ts), 
        date_trunc(trunc_s, end_ts),
        interval_s
    ) AS uplinkTS;
END;
$$ LANGUAGE plpgsql;


-- test function
CREATE OR REPLACE FUNCTION generate_intervals(p_interval INTERVAL) RETURNS TABLE(dates TIMESTAMP) AS $$
DECLARE
    v_start_date TIMESTAMP := CURRENT_TIMESTAMP;
BEGIN
    RETURN QUERY
    WITH RECURSIVE interval_series AS (
        SELECT v_start_date AS dates
        UNION ALL
        SELECT dates + p_interval
        FROM interval_series
        WHERE dates + p_interval < v_start_date + INTERVAL '100' * p_interval
    )
    SELECT *
    FROM interval_series
    LIMIT 100;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM generate_intervals('1 hour');


select current_timestamp



-- test function 1
CREATE OR REPLACE FUNCTION print_details(p_string TEXT, p_date DATE, p_num1 INTEGER, p_num2 INTEGER) RETURNS VOID AS $$
BEGIN
    -- Print the string
    RAISE NOTICE 'String: %', p_string;

    -- Print the date
    RAISE NOTICE 'Date: %', p_date;

    -- Print the sum of the two numbers
    RAISE NOTICE 'Sum: %', p_num1 + p_num2;
END;
$$ LANGUAGE plpgsql;


SELECT print_details('Hello, World!', '2024-07-27', 5, 10);



-- test function 2
CREATE OR REPLACE FUNCTION get_rain_data(start_date DATE, end_date DATE) RETURNS TABLE(date DATE, amount NUMERIC, location TEXT) AS $$
BEGIN
    RETURN QUERY
    SELECT date, amount, location
    FROM rain_data
    WHERE date BETWEEN start_date AND end_date
    ORDER BY date;
END;
$$ LANGUAGE plpgsql;


SELECT * FROM get_rain_data('2024-01-01', '2024-01-31');


-- rain data
CREATE TABLE rain_data (
    timestamp TIMESTAMP,
    amount NUMERIC,
    location TEXT
);


INSERT INTO rain_data (timestamp, amount, location) VALUES
('2024-07-20 10:00:00', 12.5, 'Location A'),
('2024-07-21 11:00:00', 5.0, 'Location B'),
('2024-07-22 12:00:00', 7.8, 'Location C'),
('2024-07-23 13:00:00', 3.2, 'Location D'),
('2024-07-24 14:00:00', 10.4, 'Location E'),
('2024-07-25 15:00:00', 9.1, 'Location F'),
('2024-07-26 16:00:00', 6.7, 'Location G'),
('2024-07-27 17:00:00', 8.3, 'Location H'),
('2024-07-28 18:00:00', 4.6, 'Location I'),
('2024-07-29 19:00:00', 11.0, 'Location J');


-- test function 
CREATE OR REPLACE FUNCTION get_film (p_pattern VARCHAR) RETURNS TABLE ( film_title VARCHAR, film_release_year INT) AS $$
BEGIN
    RETURN QUERY
SELECT
        title,
        CAST( release_year AS INTEGER)
    FROM
        film
    WHERE
        title ILIKE p_pattern ;
END; $$ LANGUAGE 'plpgsql';


SELECT *
FROM get_film ('Al%');


--test 


select user_id from users

CREATE OR REPLACE FUNCTION getusers() RETURNS TABLE(user_id text) AS $$
BEGIN
    RETURN QUERY
    SELECT user_id FROM users;
END;
$$ LANGUAGE plpgsql;



-- fix ambigous
CREATE OR REPLACE FUNCTION getusers() RETURNS TABLE(user_id text) AS $$
BEGIN
    RETURN QUERY
    SELECT users.user_id FROM users;
END;
$$ LANGUAGE plpgsql;






select getusers()


CREATE OR REPLACE FUNCTION raise_notice(notice_text TEXT) RETURNS INTEGER AS $$
BEGIN
    RAISE NOTICE 'notice is: %', notice_text;
    RETURN 1;
END;
$$ LANGUAGE plpgsql;



select raise_notice('labuuuuu')