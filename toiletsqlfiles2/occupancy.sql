

CREATE UNIQUE INDEX index_name ON occupancy_data (id);

CREATE UNIQUE INDEX notify_idx ON notification_data (notify_id);

CREATE UNIQUE INDEX occupancy_idx ON occupancy_data (id);

CREATE UNIQUE INDEX smoke_idx ON smoke_data (id);

CREATE UNIQUE INDEX smoke_idx ON smoke_data (id);

CREATE UNIQUE INDEX reactions_idx ON reactions (react_id);


select * from occupancy_data where device_token = '30' order by timestamp desc limit 1

select * from occupancy_data where device_token = '30'
and extract(HOUR from occupancy_data.timestamp ) > 23 

-- window function
select
    occupied,
    lag(occupied, 1) over (
        order by id
    ) prev_occupied,
    device_token 
from occupancy_data
limit 10

select * from occupancy_data

DELETE FROM occupancy_data WHERE timestamp > NOW()

-- occupancy trigger function
CREATE OR REPLACE FUNCTION sum_occupancy_data( dt text)
RETURNS TRIGGER AS $$
DECLARE
    total_sum NUMERIC;
BEGIN
    -- Summing up data from 'data_table' ordered by the timestamp
    SELECT SUM(value_column)
    INTO total_sum
    FROM (
        SELECT value_column
        FROM data_table
        ORDER BY timestamp_column DESC
        LIMIT 1
    ) AS latest_data;

    -- Inserting the result into the summary_table
    INSERT INTO summary_table (sum_value, timestamp)
    VALUES (total_sum, NOW());

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trigger_sum_latest
AFTER INSERT ON data_table FOR EACH ROW
EXECUTE FUNCTION sum_latest_data ();