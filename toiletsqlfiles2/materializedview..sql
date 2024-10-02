
select * from occupancy_data

CREATE MATERIALIZED VIEW IF NOT EXISTS occupancy_agg AS
WITH
    occupancy_cte AS (
        SELECT
            date_trunc('hour', timestamp) AS truncated_time,
            device_token,
            occupied,
            LAG(occupied, 1) OVER (
                ORDER BY id
            ) AS prev_occupied
        FROM occupancy_data
    )
SELECT
    truncated_time,
    device_token,
    occupied,
    prev_occupied,
    SUM(
        CASE
            WHEN occupied = true
            AND prev_occupied = false THEN 1
            ELSE 0
        END
    ) AS new_person_enter
FROM occupancy_cte
GROUP BY
    truncated_time,
    device_token,
    occupied,
    prev_occupied
WITH
    NO DATA;


REFRESH MATERIALIZED VIEW occupancy_agg;

SELECT * FROM occupancy_agg;

EXPLAIN
SELECT *
FROM occupancy_agg
WHERE
    truncated_time > NOW() - INTERVAL '1 HOUR';

SELECT *
FROM occupancy_agg
WHERE
    truncated_time > NOW() - INTERVAL '12 HOUR';

CREATE INDEX occupancy_agg_idx3 ON occupancy_agg (truncated_time, device_token, new_person_enter);