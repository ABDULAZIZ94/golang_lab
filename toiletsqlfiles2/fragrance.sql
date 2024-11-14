-- Active: 1722832765629@@alpha.vectolabs.com@9998@smarttoilet-staging


select * from fragrance_data

select * from fragrance_data order by timestamp desc

delete from fragrance_data where timestamp > now()

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



select * from fragrance_data
order by timestamp desc

select sum(case when fragrance_on = true then 1 else 0 end) from fragrance_data
where current_timestamp > (current_timestamp - interval '1 DAY')
and device_token = '611'



select count(case when status = '1' then 1 end)/6 as total_fragrance
from misc_action_data
where misc_action_data.namespace = 'FRESHENER'
and device_token = '611'
and  (timestamp::time >= '23:00:00' OR ( timestamp::time >= '00:00:00' AND timestamp::time <= '11:00:00'))
and timestamp between (select start_date from start_end) and (select end_date from start_end)
and device_token = '611'



select * from misc_action_data
where namespace = 'FRESHENER'
and device_token = '611'
and  (timestamp::time >= '23:00:00' OR ( timestamp::time >= '00:00:00' AND timestamp::time <= '11:00:00'))
and timestamp  between to_timestamp('2024-10-18 23:00:00','YYYY-MM-DD HH24:MI:SS')
and to_timestamp('2024-10-20 11:00:00','YYYY-MM-DD HH24:MI:SS') 



select * from fragrance_data
where device_token = '611'
and  (timestamp::time >= '23:00:00' OR ( timestamp::time >= '00:00:00' AND timestamp::time <= '11:00:00'))
and timestamp  between to_timestamp('2024-10-18 23:00:00','YYYY-MM-DD HH24:MI:SS')
and to_timestamp('2024-10-20 11:00:00','YYYY-MM-DD HH24:MI:SS') 




select * from fragrance_data 
where fragrance_on = true
and device_token = '617'


delete from fragrance_data
where
    fragrance_on = true
    and device_token = '617'



select * from user_reactions 
where reaction_id = '291d62e9-bdb4-4343-7821-3e7d901502c0'

-- data masuk db