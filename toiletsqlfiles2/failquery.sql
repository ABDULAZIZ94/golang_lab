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





-- each cubical
select
    COALESCE(cubical_counter, 0) as CUBICAL_COUNTER,
    COALESCE(occupied, false) as OCCUPANCY,
    COALESCE(AUTOCLEANINGPROCESS, false) as AUTOCLEANING
from devices d
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
                select occupied, lag(occupied, 1) over (
                        order by id
                    ) prev_occupied,
                    device_token
                from occupancy_data
                where
                    timestamp BETWEEN to_timestamp(
                        '2024-08-19 00:00:00', 'YYYY-MM-DD HH24:MI:SS'
                    ) AND to_timestamp(
                        '2024-08-19 23:59:59', 'YYYY-MM-DD HH24:MI:SS'
                    )
                    and device_token = '118'
            ) S1
        group by device_token
    ) Q1 using (device_token)
    left join (
        select occupied, device_token
        from occupancy_data
        where
            device_token = '118'
        order by timestamp
        limit 1
    ) Q2 USING (device_token)
    left join (
        SELECT
            CASE
                WHEN cr.auto_clean_state = '1' THEN true
                else false
            end as AUTOCLEANINGPROCESS, dcp.device_id
        FROM
            CLEANER_REPORTS cr
            join device_cubical_pairs dcp on cr.cubical_id = dcp.cubical_id
        where
            EXTRACT(
                HOUR
                FROM cr.created_at
            ) >= 7
            AND EXTRACT(
                HOUR
                FROM cr.created_at
            ) <= 18
            and dcp.device_id = '3c64d02c-abfb-4b57-5dfe-116d163ecee3'
            and cr.created_at between TO_TIMESTAMP(
                '2024-08-19 07:00:00', 'YYYY-MM-DD HH24:MI:SS'
            ) and TO_TIMESTAMP(
                '2024-08-19 18:00:00', 'YYYY-MM-DD HH24:MI:SS'
            )
        order by cr.created_at desc
        limit 1
    ) Q3 using (device_id)
where
    d.device_token = '118'




--
select
    occupied,
    lag(occupied, 1) over (
        order by id
    ) prev_occupied,
    device_token
from occupancy_data
where
    timestamp BETWEEN to_timestamp(
        '2024-08-19 00:00:00',
        'YYYY-MM-DD HH24:MI:SS'
    ) AND to_timestamp(
        '2024-08-19 23:59:59',
        'YYYY-MM-DD HH24:MI:SS'
    )
    and device_token = '118'
group by
    device_token,
    id



select * from occupancy_data



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
            DEVICES.TENANT_ID = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'
    ),
    TOILET_LIST as (
        SELECT ti.toilet_info_id
        FROM toilet_infos ti
        where
            tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'
    )
SELECT
    COALESCE(TOTAL_VIOLATION, 0) AS TOTAL_VIOLATION,
    COALESCE(CURRENT_AMMONIA_LEVEL, 0.0) AS CURRENT_AMMONIALEVEL,
    AMMONIA_HIGHLOW,
    COALESCE(PANICBTN_PUSHED, 0) AS TOTAL_PANICBTNPUSHED,
    AVG_CLEANER_RESPONSE_TIME,
    LAST_CLEAN_TIMESTAMP,
    LAST_AUTOCLEAN_ACTIVE_TIMESTAMP,
    TOTAL_COLLECTIONS
FROM (
        SELECT
            CHECK_OUT_TS AS LAST_CLEAN_TIMESTAMP
        FROM CLEANER_REPORTS
        WHERE
            CLEANER_REPORTS.TENANT_ID = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'
        ORDER BY CHECK_OUT_TS DESC
        LIMIT 1
    ) Q1
    CROSS JOIN (
        SELECT AVG(DURATION) AS AVG_CLEANER_RESPONSE_TIME
        FROM CLEANER_REPORTS
        WHERE
            CLEANER_REPORTS.TENANT_ID = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'
    ) Q2
    CROSS JOIN (
        SELECT
            CHECK_OUT_TS AS LAST_AUTOCLEAN_ACTIVE_TIMESTAMP
        FROM CLEANER_REPORTS
        WHERE
            CLEANER_REPORTS.TENANT_ID = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'
            AND AUTO_CLEAN_STATE = '1'
        ORDER BY CHECK_OUT_TS DESC
        LIMIT 1
    ) Q3
    LEFT JOIN (
        SELECT
            AVG(ammonia_level) AS CURRENT_AMMONIA_LEVEL, (
                CASE
                    WHEN ammonia_level > 1 then 'HIGH'
                    ELSE 'LOW'
                END
            ) as AMMONIA_HIGHLOW
        FROM ammonia_data
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = ammonia_data.DEVICE_TOKEN
        GROUP BY
            ammonia_data.device_token,
            ammonia_data.timestamp
        ORDER BY timestamp DESC
        LIMIT 1
    ) Q10 ON 1 = 1
    LEFT JOIN (
        SELECT COUNT(id) AS TOTAL_VIOLATION
        FROM violation_data
            JOIN device_list ON device_list.device_id = violation_data.device_id
        WHERE
            created_at BETWEEN TO_TIMESTAMP(
                '2024-08-14 07:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) AND TO_TIMESTAMP(
                '2024-08-14 18:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q4 ON 1 = 1
    LEFT JOIN (
        SELECT COUNT(
                CASE
                    WHEN panic_button = TRUE
                    AND prev_state = FALSE THEN 1
                END
            ) AS PANICBTN_PUSHED
        FROM (
                SELECT panic_button, timestamp, LAG(panic_button, 1) OVER (
                        ORDER BY id
                    ) AS prev_state
                FROM panic_btn_data
            ) S1
        WHERE
            timestamp BETWEEN TO_TIMESTAMP(
                '2024-08-14 07:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) AND TO_TIMESTAMP(
                '2024-08-14 18:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q5 ON 1 = 1
    LEFT JOIN (
        select sum(ammount) as TOTAL_COLLECTIONS
        from money_data
        where
            created_at BETWEEN TO_TIMESTAMP(
                '2024-08-14 07:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) AND TO_TIMESTAMP(
                '2024-08-14 18:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q6 ON 1 = 1