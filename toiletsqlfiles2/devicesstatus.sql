WITH
    DEVICE_INFOS AS (
        SELECT DISTINCT
            ON (DEVICES.DEVICE_TOKEN) DEVICES.DEVICE_TOKEN,
            DEVICES.DEVICE_NAME,
            DEVICE_TYPES.DEVICE_TYPE_NAME,
            DEVICES.DEVICE_TYPE_ID,
            TOILET_INFOS.TOILET_INFO_ID,
            TOILET_INFOS.TOILET_NAME,
            TOILET_INFOS.TOILET_TYPE_ID
        FROM
            DEVICES
            JOIN DEVICE_PAIRS ON DEVICE_PAIRS.DEVICE_ID = DEVICES.DEVICE_ID
            JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID = DEVICES.DEVICE_TYPE_ID
            JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID
        WHERE
            TOILET_INFOS.LOCATION_ID = '98998a6b-4be1-4ff4-5dd1-8a8e914943ee'
    )
SELECT DISTINCT
    ON (DEVICE_TOKEN, timestamp) EXTRACT(
        HOUR
        FROM timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'GMT+8'
    ) AS hour,
    EXTRACT(
        MINUTE
        FROM timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'GMT+8'
    ) AS minute,
    timestamp,
    COUNT(device_token) AS count,
    device_token
    -- device_name,
    -- device_type_id,
    -- DEVICE_INFOS.toilet_info_id,
    -- DEVICE_INFOS.TOILET_NAME,
    -- DEVICE_INFOS.TOILET_TYPE_ID
FROM DEVICE_INFOS
    LEFT JOIN (
        SELECT *
        FROM misc_action_data
        WHERE
            DATE (
                timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'GMT+8'
            ) = DATE (
                CURRENT_TIMESTAMP AT TIME ZONE 'UTC' AT TIME ZONE 'GMT+8'
            )
    ) Q1 USING (DEVICE_TOKEN)
GROUP BY
    Q1.timestamp,
    device_token
    -- device_name,
    -- device_type_id,
    -- DEVICE_INFOS.toilet_info_id,
    -- device_infos.toilet_name,
    -- device_infos.toilet_type_id
ORDER BY timestamp DESC


select * from misc_action_data


select * from misc_action_data 
where device_token = '62' 
and DATE (
    timestamp AT TIME ZONE 'UTC' AT TIME ZONE 'GMT+8'
) = DATE (
    CURRENT_TIMESTAMP AT TIME ZONE 'UTC' AT TIME ZONE 'GMT+8'
)
order by timestamp desc



select * from misc_action_data where device_token = 'FP_KPKT_02' 
-- order by timestamp desc limit 10

--226, 611 tak ada dalam miscaction_data
-- 226, 231