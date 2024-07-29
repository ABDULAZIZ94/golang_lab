-- generate timestamp
WITH GENTIME AS (
    SELECT uplinkTS  
    FROM generate_series(date_trunc('HOUR', TO_TIMESTAMP('2024-06-01 16:00:00', 'YYYY-MM-DD HH24:MI:SS')),
    -- date_trunc('HOUR', TO_TIMESTAMP('  endDate   16:00:00', 'YYYY-MM-DD HH24:MI:SS')  interval '23' HOUR)  
    date_trunc('HOUR', TO_TIMESTAMP('2024-06-10 15:00:00', 'YYYY-MM-DD HH24:MI:SS')),
    interval '1' HOUR) uplinkTS)

-- generate timestamp based on date and interval
WITH GENTIME AS (
	SELECT uplinkTS  
    FROM generate_series(date_trunc('HOUR', TO_TIMESTAMP('  2024-06-01  16:00:00', 'YYYY-MM-DD HH24:MI:SS')),
    date_trunc('HOUR', TO_TIMESTAMP('  2024-06-10  ', 'YYYY-MM-DD HH24:MI:SS')),  
    interval '1' HOUR) uplinkTS)
-- parse counter
SELECT uplinkTS::text, 
    COALESCE(BIN_FULL, '0')::text AS BIN_FULL,  
    COALESCE(BUSUK, '0')::text AS BUSUK,  
    COALESCE(URINAL_CLOG, '0')::text AS URINAL_CLOG,  
    COALESCE(SANITARY_BIN_FULL, '0')::text AS SANITARY_BIN_FULL,  
    COALESCE(PIPE_LEAK, '0')::text AS PIPE_LEAK,  
    COALESCE(SLIPPERY, '0')::text AS SLIPPERY,  
    COALESCE(OUT_TISSUE, '0')::text AS OUT_TISSUE,  
    COALESCE(REFRESH_TOILET, '0')::text AS REFRESH_TOILET,  
    COALESCE(OUT_SOAP, '0')::text AS OUT_SOAP,  
    COALESCE(CLOGGED_TOILET, '0')::text AS CLOGGED_TOILET  
    FROM GENTIME  
    LEFT JOIN  
        (SELECT date_trunc('  agg  ', timestamp) AS uplinkTS,  
        COUNT(CASE WHEN BUTTON_ID = 1 THEN 1 END) AS REFRESH_TOILET,  
        COUNT(CASE WHEN BUTTON_ID = 2 THEN 1 END) AS OUT_TISSUE,  
        COUNT(CASE WHEN BUTTON_ID = 3 THEN 1 END) AS BIN_FULL,  
        COUNT(CASE WHEN BUTTON_ID = 4 THEN 1 END) AS OUT_SOAP,  
        COUNT(CASE WHEN BUTTON_ID = 5 THEN 1  END) AS BUSUK,  
        COUNT(CASE WHEN BUTTON_ID = 6 THEN 1 END) AS CLOGGED_TOILET,  
        COUNT(CASE WHEN BUTTON_ID = 7 THEN 1 END) AS URINAL_CLOG,  
        COUNT(CASE WHEN BUTTON_ID = 8 THEN 1 END) AS SLIPPERY,  
        COUNT(CASE WHEN BUTTON_ID = 9 THEN 1 END) AS SANITARY_BIN_FULL,  
        COUNT(CASE WHEN BUTTON_ID = 10 THEN 1 END) AS PIPE_LEAK  
        FROM feedback_panel_data  
        -- JOIN DEVICES ON DEVICES.DEVICE_TOKEN = FEEDBACK_PANEL_DATA.DEVICE_TOKEN  
        -- JOIN DEVICE_PAIRS ON DEVICE_PAIRS.DEVICE_ID = DEVICES.DEVICE_ID  
        -- JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID  
        -- WHERE device_token = '  deviceInfo.DeviceToken  '  
        WHERE feedback_panel_data.TOILET_TYPE_ID = 1
        AND feedback_panel_data.DEVICE_TOKEN = '13'
        GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC


SELECT * FROM generate_series(2,4);

SELECT * FROM generate_series('2008-03-01 00:00'::timestamp,
                              '2008-03-04 12:00', '10 hours');

SELECT * FROM generate_series('2008-03-01 00:00'::timestamp,
                              '2008-03-04 12:00',interval '10 hours');

WITH GENTIME AS (
	SELECT uplinkTS FROM generate_series('2008-03-01 00:00'::timestamp,
                              '2008-03-04 12:00',
                              interval '10 hours') uplinkTS)

-- original
WITH GENTIME as (SELECT uplinkTS  
			FROM generate_series(date_trunc('  agg  ', TO_TIMESTAMP('  startDate  ', 'YYYY-MM-DD HH24:MI:SS')),  
			date_trunc('  agg  ', TO_TIMESTAMP('  endDate  ', 'YYYY-MM-DD HH24:MI:SS')),  
			interval '  interval  ') uplinkTS) 


-- try SQL
WITH GENTIME AS
    ( SELECT uplinkTS
     FROM generate_series(date_trunc('HOUR', TO_TIMESTAMP('2024-06-01 16:00:00', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('HOUR', TO_TIMESTAMP('2024-06-10 15:00:00', 'YYYY-MM-DD HH24:MI:SS')), interval '1' HOUR) uplinkTS)
SELECT uplinkTS::text,
       COALESCE(BIN_FULL, '0')::text AS BIN_FULL,
       COALESCE(BUSUK, '0')::text AS BUSUK,
       COALESCE(URINAL_CLOG, '0')::text AS URINAL_CLOG,
       COALESCE(SANITARY_BIN_FULL, '0')::text AS SANITARY_BIN_FULL,
       COALESCE(PIPE_LEAK, '0')::text AS PIPE_LEAK,
       COALESCE(SLIPPERY, '0')::text AS SLIPPERY,
       COALESCE(OUT_TISSUE, '0')::text AS OUT_TISSUE,
       COALESCE(REFRESH_TOILET, '0')::text AS REFRESH_TOILET,
       COALESCE(OUT_SOAP, '0')::text AS OUT_SOAP,
       COALESCE(CLOGGED_TOILET, '0')::text AS CLOGGED_TOILET
FROM GENTIME

WITH GENTIME AS
    ( SELECT uplinkTS
     FROM generate_series(date_trunc('HOUR', TO_TIMESTAMP('2024-06-01 16:00:00', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('HOUR', TO_TIMESTAMP('2024-06-10 15:00:00', 'YYYY-MM-DD HH24:MI:SS')), interval '1' HOUR) uplinkTS)
