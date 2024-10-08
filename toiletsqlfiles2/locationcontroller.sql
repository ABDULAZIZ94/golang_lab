-- Active: 1722832765629@@alpha.vectolabs.com@9998@smarttoilet-staging

SELECT AVG(USER_REACTIONS.SCORE) AS SCORE,  
LOCATIONS.* ,  
AVG(ENVIROMENT_DATA.IAQ) AS IAQ  
FROM LOCATIONS  
LEFT JOIN TOILET_INFOS ON TOILET_INFOS.LOCATION_ID = LOCATIONS.LOCATION_ID  
LEFT JOIN USER_REACTIONS ON USER_REACTIONS.TOILET_ID = TOILET_INFOS.toilet_info_id  
LEFT JOIN DEVICE_PAIRS ON DEVICE_PAIRS.TOILET_INFO_ID = TOILET_INFOS.TOILET_INFO_ID  
LEFT JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID  
LEFT JOIN ENVIROMENT_DATA on ENVIROMENT_DATA.DEVICE_TOKEN = DEVICES.DEVICE_TOKEN  
WHERE (DATE(ENVIROMENT_DATA.TIMESTAMP) AT TIME ZONE 'UTC' AT TIME ZONE 'ASIA/KUALA_LUMPUR' = CURRENT_DATE AT TIME ZONE 'UTC' AT TIME ZONE 'ASIA/KUALA_LUMPUR'  
-- OR DATE(ENVIROMENT_DATA.TIMESTAMP) IS NULL) AND LOCATIONS.TENANT_ID =''
OR DATE(ENVIROMENT_DATA.TIMESTAMP) IS NULL) AND 1=1
GROUP BY LOCATIONS.LOCATION_ID


-- check list of locations
SELECT * FROM public.locations

select * from counter_data


select * from user_reactions


--
select
    sum(
        HAPPY + SATISFIED + NOT_SATISFIED + NOT_HAPPY
    ) as TOTAL,
    HAPPY,
    SATISFIED,
    NOT_SATISFIED,
    NOT_HAPPY
from (
        select
            count(
                case
                    when reaction = '1' then 1
                end
            ) as HAPPY, count(
                case
                    when reaction = '2' then 1
                end
            ) as SATISFIED, count(
                case
                    when reaction = '3' then 1
                end
            ) as NOT_SATISFIED, count(
                case
                    when reaction = '4' then 1
                end
            ) as NOT_HAPPY
        from user_reactions
        where
            timestamp between TO_TIMESTAMP(
                '2024-10-06 23:00:00', 'YYYY-MM-DD HH24:MI:SS'
            ) and TO_TIMESTAMP(
                '2024-10-07 16:00:00', 'YYYY-MM-DD HH24:MI:SS'
            )
            and toilet_id = 'a97891e5-14df-4f95-7d1e-4ee601581df2'
    ) Q1
group by
    Q1.HAPPY,
    Q1.SATISFIED,
    Q1.NOT_SATISFIED,
    Q1.NOT_HAPPY




select * from user_reactions where toilet_id = 'a97891e5-14df-4f95-7d1e-4ee601581df2' order by timestamp desc limit 10


--
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
            TOILET_INFOS.TOILET_INFO_ID = 'a97891e5-14df-4f95-7d1e-4ee601581df2'
    ),
    GENTIME as (
        SELECT uplinkTS
        FROM generate_series(
                date_trunc(
                    'HOUR', TO_TIMESTAMP(
                        '2024-10-06 23:00:00', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), date_trunc(
                    'HOUR', TO_TIMESTAMP(
                        '2024-10-07 16:00:00', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), interval '1 HOUR'
            ) uplinkTS
    )
select TOTAL_COMPLAINT, uplinkts
from gentime
    left join (
        select count(reaction_id) as TOTAL_COMPLAINT, date_trunc('HOUR', timestamp) as uplinkts
        from user_reactions
        where
            EXTRACT(
                HOUR
                FROM timestamp
            ) >= 23
            or EXTRACT(
                HOUR
                FROM timestamp
            ) >= 0
            AND EXTRACT(
                HOUR
                FROM timestamp
            ) <= 16
            and (timestamp) between to_timestamp(
                '2024-10-06 23:00:00', 'YYYY-MM-DD HH24:MI:SS'
            ) and to_timestamp(
                '2024-10-07 16:00:00', 'YYYY-MM-DD HH24:MI:SS'
            )
            and toilet_id = 'a97891e5-14df-4f95-7d1e-4ee601581df2'
        group by
            uplinkts
    ) Q1 using (uplinkts)
order by uplinkts

select * from user_reactions where toilet_id = 'a97891e5-14df-4f95-7d1e-4ee601581df2' order by timestamp desc limit 10


--
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
            TOILET_INFOS.TOILET_INFO_ID = 'a97891e5-14df-4f95-7d1e-4ee601581df2'
    ),
    GENTIME as (
        SELECT uplinkTS
        FROM generate_series(
                date_trunc(
                    'HOUR', TO_TIMESTAMP(
                        '2024-10-06 23:00:00', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), date_trunc(
                    'HOUR', TO_TIMESTAMP(
                        '2024-10-07 16:00:00', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), interval '1 HOUR'
            ) uplinkTS
    )
select TOTAL_COMPLAINT, uplinkts
from gentime
    left join (
        select sum(
                case
                    when complaint = '1'
                    or complaint = '2'
                    or complaint = '3'
                    or complaint = '4' then 1
                end
            ) as TOTAL_COMPLAINT, date_trunc('HOUR', timestamp) as uplinkts
        from user_reactions
        where
            -- EXTRACT(
            --     HOUR
            --     FROM timestamp
            -- ) >= 23
            -- or EXTRACT(
            --     HOUR
            --     FROM timestamp
            -- ) >= 0
            -- AND EXTRACT(
            --     HOUR
            --     FROM timestamp
            -- ) <= 16
            -- and 
            (timestamp) between to_timestamp(
                '2024-10-06 23:00:00', 'YYYY-MM-DD HH24:MI:SS'
            ) and to_timestamp(
                '2024-10-07 16:00:00', 'YYYY-MM-DD HH24:MI:SS'
            )
            and toilet_id = 'a97891e5-14df-4f95-7d1e-4ee601581df2'
        group by
            uplinkts
    ) Q1 using (uplinkts)
order by uplinkts


select toilet_type_id


select toilet_infos.toilet_type_id  from device_pairs
join devices on devices.device_id = device_pairs.device_id
join toilet_infos on toilet_infos.toilet_info_id = device_pairs.toilet_info_id
where devices.device_token = '222'


select devices.device_token  from device_pairs
join devices on devices.device_id = device_pairs.device_id
join toilet_infos on toilet_infos.toilet_info_id = device_pairs.toilet_info_id
where devices.device_type_id = '10' and toilet_infos.toilet_type_id = '1'


select * from device_types


select * from devices