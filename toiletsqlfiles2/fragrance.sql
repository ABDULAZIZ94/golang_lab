

select * from fragrance_data

SELECT COUNT(misc_data_id) AS TOTAL_FRAGRANCE 
FROM MISC_ACTION_DATA

select * FROM MISC_ACTION_DATA

-- kemaman 107,106
select * from fragrance_data where device_token = '107'
and EXTRACT(HOUR FROM timestamp) >= 7 AND EXTRACT(HOUR FROM timestamp) <= 18

-- total fragrance
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
            TOILET_INFOS.TOILET_INFO_ID = '36f74ec4-cdb0-4271-6c2d-2baa48d6e583'
    )
SELECT
    COALESCE(TRAFFIC_COUNT_TODAY, 0) as TRAFFIC_COUNT_TODAY,
    COALESCE(
        TOTAL_FRAGRANCE_SPRAY_ACTIVATED,
        0
    ) as TOTAL_FRAGRANCE_SPRAY_ACTIVATED,
    LAST_FRAGRANCE_SPRAY_ACTIVATED,
    COALESCE(CURRENT_LUX, 0) as CURRENT_LUX,
    COALESCE(CURRENT_IAQ, 0) as CURRENT_IAQ,
    COALESCE(TOTAL_CLEANED_TODAY, 0) as TOTAL_CLEANED_TODAY,
    LAST_CLEAN_TIMESTAMP,
    COALESCE(CURRENT_HUMIDITY, 0) as CURRENT_HUMIDITY
FROM (
        select count(people_in) as TRAFFIC_COUNT_TODAY
        from counter_data
        where
            device_token in (
                select device_token
                from DEVICE_LIST
            )
            and timestamp between TO_TIMESTAMP(
                '2024-08-14 07:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and TO_TIMESTAMP(
                '2024-08-14 18:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q1
    LEFT JOIN (
        select
            timestamp as LAST_FRAGRANCE_SPRAY_ACTIVATED
        from fragrance_data
        order by timestamp desc
        limit 1
    ) Q2 ON 1 = 1
    LEFT JOIN (
        select
            iaq as CURRENT_IAQ,
            lux as CURRENT_LUX,
            humidity as CURRENT_HUMIDITY
        from enviroment_data
        where
            device_token in (
                select device_token
                from DEVICE_LIST
            )
        order by timestamp desc
        limit 1
    ) Q3 ON 1 = 1
    LEFT JOIN (
        select count(cleaner_report_id) as TOTAL_CLEANED_TODAY
        from cleaner_reports
        where
            check_in_ts between TO_TIMESTAMP(
                '2024-08-14 07:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and TO_TIMESTAMP(
                '2024-08-14 18:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q4 ON 1 = 1
    LEFT JOIN (
        select
            created_at as LAST_CLEAN_TIMESTAMP
        from cleaner_reports
        where
            auto_clean_state = '0'
            and check_in_ts between TO_TIMESTAMP(
                '2024-08-14 07:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and TO_TIMESTAMP(
                '2024-08-14 18:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
        order by created_at
        limit 1
    ) Q5 ON 1 = 1
    LEFT JOIN (
        select
            count(
                case
                    when fragrance_on = true then 1
                end
            ) as TOTAL_FRAGRANCE_SPRAY_ACTIVATED
        from fragrance_data
        where
            EXTRACT(
                HOUR
                FROM timestamp
            ) >= 7
            AND EXTRACT(
                HOUR
                FROM timestamp
            ) <= 18
            and device_token in ('116')
            and timestamp between TO_TIMESTAMP(
                '2024-08-01 07:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and TO_TIMESTAMP(
                '2024-08-14 18:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q6 ON 1 = 1