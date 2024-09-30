
select * from panic_btn_data order by timestamp DESC

delete from panic_btn_data where timestamp > now()

select * from panic_btn_data where device_token = '1000' order by timestamp desc

insert into panic_btn_data (device_token, panic_button, timestamp) values ('1000', false, CURRENT_TIMESTAMP) 

SELECT COUNT(CASE WHEN panic_button = TRUE AND prev_state = FALSE THEN 1 END) AS PANICBTN_PUSHED
FROM (SELECT panic_button, timestamp, LAG(panic_button, 1) OVER (ORDER BY id) AS prev_state
FROM panic_btn_data where device_token = '1000' AND timestamp BETWEEN TO_TIMESTAMP('2024-09-25 23:00:00','YYYY-MM-DD HH24:MI:SS')
AND TO_TIMESTAMP('2024-09-26 14:00:00','YYYY-MM-DD HH24:MI:SS'))S1

-- test integrate
WITH
    DEVICE_LIST AS (
        SELECT
            DEVICES.DEVICE_NAME,
            DEVICES.DEVICE_ID,
            DEVICES.DEVICE_TOKEN,
            TOILET_INFOS.TOILET_NAME AS IDENTIFIER,
            TOILET_INFOS.TOILET_INFO_ID AS IDENTIFIER_ID,
            DEVICE_TYPES.DEVICE_TYPE_NAME AS NAMESPACE,
            DEVICE_TYPES.DEVICE_TYPE_ID AS NAMESPACE_ID,
            TOILET_TYPES.TOILET_TYPE_ID
        FROM
            DEVICE_PAIRS
            JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID
            JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID = DEVICES.DEVICE_TYPE_ID
            JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID
            JOIN TOILET_TYPES ON TOILET_TYPES.TOILET_TYPE_ID = TOILET_INFOS.TOILET_TYPE_ID
        WHERE
            DEVICES.TENANT_ID = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'
    )
SELECT COUNT(CASE WHEN panic_button = TRUE AND prev_state = FALSE THEN 1 END) AS PANICBTN_PUSHED
FROM (SELECT panic_button, timestamp, LAG(panic_button, 1) OVER (ORDER BY id) AS prev_state
FROM panic_btn_data where device_token in (select device_token from device_list where namespace_id = '11') AND timestamp BETWEEN TO_TIMESTAMP('2024-09-25 23:00:00','YYYY-MM-DD HH24:MI:SS')
AND TO_TIMESTAMP('2024-09-26 14:00:00','YYYY-MM-DD HH24:MI:SS'))S1

-- detailed
WITH
    DEVICE_LIST AS (
        SELECT
            DEVICES.DEVICE_NAME,
            DEVICES.DEVICE_ID,
            DEVICES.DEVICE_TOKEN,
            TOILET_INFOS.TOILET_NAME AS IDENTIFIER,
            TOILET_INFOS.TOILET_INFO_ID AS IDENTIFIER_ID,
            DEVICE_TYPES.DEVICE_TYPE_NAME AS NAMESPACE,
            DEVICE_TYPES.DEVICE_TYPE_ID AS NAMESPACE_ID,
            TOILET_TYPES.TOILET_TYPE_ID
        FROM
            DEVICE_PAIRS
            JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID
            JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID = DEVICES.DEVICE_TYPE_ID
            JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID
            JOIN TOILET_TYPES ON TOILET_TYPES.TOILET_TYPE_ID = TOILET_INFOS.TOILET_TYPE_ID
        WHERE
            DEVICES.TENANT_ID = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'
    )
select device_token from device_list where namespace_id = '11'