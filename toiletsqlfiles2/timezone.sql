

--timestamp with time zone
SELECT *
FROM generate_series(
        '2024-08-01 00:00:00'::timestamptz AT TIME ZONE 'America/New_York', '2024-08-01 23:00:00'::timestamptz AT TIME ZONE 'America/New_York', '1 hour'::interval
    ) AS series (ts);

-- timestamp without time zone
SELECT *
FROM generate_series(
        '2008-03-01 00:00'::timestamp, '2008-03-04 12:00', '10 hours'
    );