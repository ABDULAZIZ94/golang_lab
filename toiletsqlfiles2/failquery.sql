-- Active: 1723732721360@@alpha.vectolabs.com@9998
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
    ),
    GENTIME as (
        SELECT uplinkTS
        FROM generate_series(
                date_trunc(
                    'HOUR', TO_TIMESTAMP(
                        '2024-08-14 07:00:00', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), date_trunc(
                    'HOUR', TO_TIMESTAMP(
                        '2024-08-14 18:00:00', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), interval '1' HOUR
            ) uplinkTS
    )
SELECT
    COALESCE(TotalCollection, 0) as TOTAL_COLLECTION,
    COALESCE(TotalTraffic, 0) as TOTAL_TRAFFIC,
    UplinkTS as uplinkTS
from GENTIME G
    LEFT JOIN (
        select distinct
            UplinkTS, sum(RM) as TotalCollection
        from (
                select date_trunc('HOUR', created_at) as UplinkTS, ammount as RM
                from money_data md
                where
                    md.tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'
            ) S1
        group by
            UplinkTS, RM
    ) Q1 USING (UplinkTS)
    LEFT JOIN (
        select date_trunc('HOUR', timestamp) as UplinkTS, count(people_in) as TotalTraffic
        from counter_data
        group by
            UplinkTS
    ) Q2 using (UplinkTS)



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
            DEVICE_PAIRS.TOILET_INFO_ID = '9388096c-784d-49c8-784c-1868b1233165'
    )
SELECT
    COALESCE(Q1.TTLTRAFFIC, '0') AS TOTAL_COUNTER,
    Q9.LAST_COUNTER_TS AS LAST_COUNTER_CNT_TIMESTAMP,
    Q2.IAQ AS ODOUR_LEVEL,
    Q7.TOTAL_FRAGRANCE
FROM (
        SELECT SUM(people_in) AS TTLTRAFFIC
        FROM COUNTER_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = COUNTER_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 2
            AND EXTRACT(
                HOUR
                FROM timestamp
            ) >= 7
            AND EXTRACT(
                HOUR
                FROM timestamp
            ) <= 18
            AND timestamp BETWEEN TO_TIMESTAMP(
                '2024-08-16 07:00:00', 'YYYY-MM-DD HH24:MI:SS'
            ) AND TO_TIMESTAMP(
                '2024-08-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q1
    CROSS JOIN (
        SELECT IAQ
        FROM
            ENVIROMENT_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = ENVIROMENT_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 3
            AND EXTRACT(
                HOUR
                FROM timestamp
            ) >= 7
            AND EXTRACT(
                HOUR
                FROM timestamp
            ) <= 18
            AND timestamp BETWEEN TO_TIMESTAMP(
                '2024-08-16 07:00:00', 'YYYY-MM-DD HH24:MI:SS'
            ) AND TO_TIMESTAMP(
                '2024-08-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS'
            )
        ORDER BY timestamp DESC
        LIMIT 1
    ) Q2
    CROSS JOIN (
        SELECT COUNT(*) AS TOTAL_FRAGRANCE
        FROM
            MISC_ACTION_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = MISC_ACTION_DATA.DEVICE_TOKEN
        WHERE
            MISC_ACTION_DATA.NAMESPACE = 'FRESHENER'
            AND EXTRACT(
                HOUR
                FROM timestamp
            ) >= 7
            AND EXTRACT(
                HOUR
                FROM timestamp
            ) <= 18
            AND timestamp BETWEEN TO_TIMESTAMP(
                '2024-08-16 07:00:00', 'YYYY-MM-DD HH24:MI:SS'
            ) AND TO_TIMESTAMP(
                '2024-08-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q7
    LEFT JOIN (
        SELECT timestamp AS LAST_COUNTER_TS
        FROM COUNTER_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = COUNTER_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 2
            AND EXTRACT(
                HOUR
                FROM timestamp
            ) >= 7
            AND EXTRACT(
                HOUR
                FROM timestamp
            ) <= 18
            AND timestamp BETWEEN TO_TIMESTAMP(
                '2024-08-16 07:00:00', 'YYYY-MM-DD HH24:MI:SS'
            ) AND TO_TIMESTAMP(
                '2024-08-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS'
            )
        ORDER BY timestamp DESC
        LIMIT 1
    ) Q9 ON TRUE;



    --
    WITH DEVICE_LIST AS (
        SELECT DEVICES.DEVICE_NAME,DEVICES.DEVICE_ID,DEVICES.DEVICE_TOKEN,
        TOILET_INFOS.TOILET_NAME AS IDENTIFIER,TOILET_INFOS.TOILET_INFO_ID AS IDENTIFIER_ID,
        DEVICE_TYPES.DEVICE_TYPE_NAME AS NAMESPACE,DEVICE_TYPES.DEVICE_TYPE_ID AS NAMESPACE_ID,
         TOILET_TYPES.TOILET_TYPE_ID 
         FROM DEVICE_PAIRS JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID 
         JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID = DEVICES.DEVICE_TYPE_ID 
         JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID 
         JOIN TOILET_TYPES ON TOILET_TYPES.TOILET_TYPE_ID = TOILET_INFOS.TOILET_TYPE_ID 
         WHERE DEVICE_PAIRS.TOILET_INFO_ID = 'a97891e5-14df-4f95-7d1e-4ee601581df2')
SELECT COALESCE(TTLTRAFFIC ,'0') AS TOTAL_COUNTER, 
LAST_COUNTER_TS AS LAST_COUNTER_CNT_TIMESTAMP,
IAQ AS ODOUR_LEVEL, 
TOTAL_FRAGRANCE  
FROM 
(SELECT SUM(people_in) AS TTLTRAFFIC 
FROM COUNTER_DATA 
JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = COUNTER_DATA.DEVICE_TOKEN 
WHERE DEVICE_LIST.NAMESPACE_ID = 2 
and EXTRACT(HOUR FROM timestamp) >= 7 AND EXTRACT(HOUR FROM timestamp) <= 18 
and timestamp between to_timestamp('2024-08-16 07:00:00','YYYY-MM-DD HH24:MI:SS') 
and to_timestamp('2024-08-16 18:00:00','YYYY-MM-DD HH24:MI:SS') )Q1
CROSS JOIN (SELECT IAQ FROM ENVIROMENT_DATA JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = ENVIROMENT_DATA.DEVICE_TOKEN WHERE DEVICE_LIST.NAMESPACE_ID = 3 and EXTRACT(HOUR FROM timestamp) >= 7 AND EXTRACT(HOUR FROM timestamp) <= 18 and timestamp between to_timestamp('2024-08-16 07:00:00','YYYY-MM-DD HH24:MI:SS') and to_timestamp('2024-08-16 18:00:00','YYYY-MM-DD HH24:MI:SS') ORDER BY TIMESTAMP DESC LIMIT 1) Q2 CROSS JOIN (SELECT COUNT(*) AS TOTAL_FRAGRANCE FROM MISC_ACTION_DATA JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = MISC_ACTION_DATA.DEVICE_TOKEN WHERE MISC_ACTION_DATA.NAMESPACE = 'FRESHENER' and EXTRACT(HOUR FROM timestamp) >= 7 AND EXTRACT(HOUR FROM timestamp) <= 18 and timestamp between to_timestamp('2024-08-16 07:00:00','YYYY-MM-DD HH24:MI:SS') and to_timestamp('2024-08-16 18:00:00','YYYY-MM-DD HH24:MI:SS') ) Q7 LEFT JOIN (SELECT timestamp AS LAST_COUNTER_TS FROM COUNTER_DATA JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = COUNTER_DATA.DEVICE_TOKEN WHERE DEVICE_LIST.NAMESPACE_ID = 2 and EXTRACT(HOUR FROM timestamp) >= 7 AND EXTRACT(HOUR FROM timestamp) <= 18 and timestamp between to_timestamp('2024-08-16 07:00:00','YYYY-MM-DD HH24:MI:SS') and to_timestamp('2024-08-16 18:00:00','YYYY-MM-DD HH24:MI:SS') ORDER BY timestamp desc LIMIT 1) Q9 ON TRUE


--
WITH
    DEVICE_LIST AS (
        select dp.device_pair_id, d.device_name, d.device_token, d.device_id
        from
            device_pairs as dp
            join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
            join devices as d on dp.device_id = d.device_id
        where
            dp.toilet_info_id = 'a97891e5-14df-4f95-7d1e-4ee601581df2'
            and d.device_type_id = 12
    )
select od.occupied as occupancy, right(dl.device_name, 2) as cubical_name, Q1.cubical_counter, dl.device_name
from
occupancy_data od
join device_list dl on dl.device_token = od.device_token
left join (
    select COALESCE(
            sum(
                CASE
                    WHEN occupied = TRUE
                    AND prev_occupied = FALSE THEN 1
                    ELSE 0
                END
            ), 0
        ) as cubical_counter, device_token
    from (
            select *, lag(occupied, 1) over (
                    order by id
                ) prev_occupied
            from occupancy_data
        ) SQ1
    where
        timestamp BETWEEN to_timestamp(
            '2024-08-16 00:00:00',
            'YYYY-MM-DD HH24:MI:SS'
        ) AND to_timestamp(
            '2024-08-16 23:59:59',
            'YYYY-MM-DD HH24:MI:SS'
        )
    group by
        device_token
) Q1 on Q1.device_token = dl.device_token
-- LEFT JOIN
-- (SELECT CASE
--         WHEN cr.auto_clean_state = '1' THEN true
--         else false
--     end as AUTOCLEANING
-- FROM
--     CLEANER_REPORTS cr
--     join device_cubical_pairs dcp on cr.cubical_id = dcp.cubical_id
-- where
--     EXTRACT(
--         HOUR
--         FROM cr.created_at
--     ) >= 7
--     AND EXTRACT(
--         HOUR
--         FROM cr.created_at
--     ) <= 18
--     and dcp.device_id IN (
--         select device_id
--         from device_list
--     )
--     and cr.created_at between TO_TIMESTAMP(
--         '2024-07-01 07:00:00',
--         'YYYY-MM-DD HH24:MI:SS'
--     ) and TO_TIMESTAMP(
--         '2024-09-30 18:00:00',
--         'YYYY-MM-DD HH24:MI:SS'
--     )order by cr.created_at
-- )Q2 ON TRUE
order by timestamp
limit 4

-- order by timestamp desc limit 4


-- query failed
select
    cp.cubical_pair_id as CUBICAL_PAIR_ID,
    cp.cubical_id as CUBICAL_ID,
    cp.toilet_info_id as TOILET_INFO_ID,
    d.device_token as DEVICE_TOKE,
    d.device_id as DEVICE_ID,
    ci.cubical_name as CUBICAL_NAME,
    d.device_name as DEVICE_NAME
from
    cubical_pairs cp
    join cubical_infos ci on ci.cubical_id = cp.cubical_id
    join device_cubical_pairs dcp on dcp.cubical_id = cp.cubical_id
    join devices d on d.device_id = dcp.device_id
where
    cp.toilet_info_id = 'a97891e5-14df-4f95-7d1e-4ee601581df2'

-- cubical pair
select cp.cubical_pair_id as CUBICAL_PAIR_ID,
cp.cubical_id as CUBICAL_ID,
cp.toilet_info_id as TOILET_INFO_ID,
d.device_token as DEVICE_TOKE,
d.device_id as DEVICE_ID,
ci.cubical_name as CUBICAL_NAME,
d.device_name as DEVICE_NAME
from
    cubical_pairs cp
    join cubical_infos ci on ci.cubical_id = cp.cubical_id
    join device_cubical_pairs dcp on dcp.cubical_id = cp.cubical_id
    join devices d on d.device_id = dcp.device_id
where
    cp.toilet_info_id = 'a97891e5-14df-4f95-7d1e-4ee601581df2'