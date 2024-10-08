-- Active: 1722832765629@@alpha.vectolabs.com@9998@smarttoilet-staging

-- getoverview advance data 
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
            DEVICE_PAIRS.TOILET_INFO_ID = '5654c008-dbcc-4656-5601-0a0c50652213'
    )
SELECT
    LAST_UPDATE as timestamp,
    COALESCE(TTLTRAFFIC, '0') AS TOTAL_COUNTER,
    LAST_COUNTER_TS AS LAST_COUNTER_CNT_TIMESTAMP,
    IAQ AS ODOUR_LEVEL,
    TMP,
    LUX,
    FAN_STATUS,
    BLOWER_STATUS,
    OCCUPIED_STATUS,
    DISPLAY_STATUS,
    TOILET_NAME,
    TOILET_TYPE_ID,
    TOTAL_FRAGRANCE,
    TOTAL_AUTOCLEAN,
    TOTAL_COMPLAINT
FROM (
        SELECT SUM(people_in) AS TTLTRAFFIC
        FROM COUNTER_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = COUNTER_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 2
            AND (TIMESTAMP) >= TO_TIMESTAMP(
                '2024-07-22 16:00:00', 'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q1
    CROSS JOIN (
        SELECT
            TIMESTAMP AS LAST_UPDATE, LUX, TEMPERATURE AS TMP, IAQ
        FROM
            ENVIROMENT_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = ENVIROMENT_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 3
        ORDER BY TIMESTAMP DESC
        LIMIT 1
    ) Q2
    CROSS JOIN (
        SELECT COUNT(*) AS TOTAL_COMPLAINT
        FROM
            FEEDBACK_PANEL_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = FEEDBACK_PANEL_DATA.DEVICE_TOKEN
            JOIN DEVICE_PAIRS ON DEVICE_PAIRS.DEVICE_ID = DEVICE_LIST.DEVICE_ID
            JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID
        WHERE (TIMESTAMP) >= TO_TIMESTAMP(
                '2024-07-22 16:00:00', 'YYYY-MM-DD HH24:MI:SS'
            )
            AND DEVICE_LIST.TOILET_TYPE_ID = FEEDBACK_PANEL_DATA.TOILET_TYPE_ID
    ) Q5
    CROSS JOIN (
        SELECT
            FAN_STATUS, BLOWER_STATUS, OCCUPIED_STATUS, DISPLAY_STATUS, TOILET_NAME, TOILET_TYPE_ID
        FROM TOILET_INFOS
        WHERE
            TOILET_INFOS.TOILET_INFO_ID = '5654c008-dbcc-4656-5601-0a0c50652213'
    ) Q6
    CROSS JOIN (
        SELECT COUNT(*) AS TOTAL_FRAGRANCE
        FROM
            MISC_ACTION_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = MISC_ACTION_DATA.DEVICE_TOKEN
        WHERE
            MISC_ACTION_DATA.NAMESPACE = 'FRESHENER'
    ) Q7
    CROSS JOIN (
        SELECT COUNT(
                CASE
                    WHEN AUTO_CLEAN_STATE = '1' THEN 1
                END
            ) AS TOTAL_AUTOCLEAN
        FROM CLEANER_REPORTS
        WHERE
            CLEANER_REPORTS.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFO_ID = '5654c008-dbcc-4656-5601-0a0c50652213'
            )
    ) Q8
    LEFT JOIN (
        SELECT timestamp AS LAST_COUNTER_TS
        FROM COUNTER_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = COUNTER_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 2
        ORDER BY timestamp desc
        LIMIT 1
    ) Q9 ON TRUE


-- taman bandar overeview advandce data
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
            DEVICE_PAIRS.TOILET_INFO_ID = '2a9fbea0-4dca-4af6-457b-348bf682cb54'
    )
SELECT
    LAST_UPDATE as timestamp,
    COALESCE(TTLTRAFFIC, '0') AS TOTAL_COUNTER,
    LAST_COUNTER_TS AS LAST_COUNTER_CNT_TIMESTAMP,
    IAQ AS ODOUR_LEVEL,
    TMP,
    LUX,
    FAN_STATUS,
    BLOWER_STATUS,
    OCCUPIED_STATUS,
    DISPLAY_STATUS,
    TOILET_NAME,
    TOILET_TYPE_ID,
    TOTAL_FRAGRANCE,
    TOTAL_AUTOCLEAN,
    TOTAL_COMPLAINT
FROM (
        SELECT SUM(people_in) AS TTLTRAFFIC
        FROM COUNTER_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = COUNTER_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 2
            AND (TIMESTAMP) >= TO_TIMESTAMP(
                '2024-07-22 16:00:00', 'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q1
    CROSS JOIN (
        SELECT
            TIMESTAMP AS LAST_UPDATE, LUX, TEMPERATURE AS TMP, IAQ
        FROM
            ENVIROMENT_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = ENVIROMENT_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 3
        ORDER BY TIMESTAMP DESC
        LIMIT 1
    ) Q2
    CROSS JOIN (
        SELECT COUNT(*) AS TOTAL_COMPLAINT
        FROM
            FEEDBACK_PANEL_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = FEEDBACK_PANEL_DATA.DEVICE_TOKEN
            JOIN DEVICE_PAIRS ON DEVICE_PAIRS.DEVICE_ID = DEVICE_LIST.DEVICE_ID
            JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID
        WHERE (TIMESTAMP) >= TO_TIMESTAMP(
                '2024-07-22 16:00:00', 'YYYY-MM-DD HH24:MI:SS'
            )
            AND DEVICE_LIST.TOILET_TYPE_ID = FEEDBACK_PANEL_DATA.TOILET_TYPE_ID
    ) Q5
    CROSS JOIN (
        SELECT
            FAN_STATUS, BLOWER_STATUS, OCCUPIED_STATUS, DISPLAY_STATUS, TOILET_NAME, TOILET_TYPE_ID
        FROM TOILET_INFOS
        WHERE
            TOILET_INFOS.TOILET_INFO_ID = '2a9fbea0-4dca-4af6-457b-348bf682cb54'
    ) Q6
    CROSS JOIN (
        SELECT COUNT(*) AS TOTAL_FRAGRANCE
        FROM
            MISC_ACTION_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = MISC_ACTION_DATA.DEVICE_TOKEN
        WHERE
            MISC_ACTION_DATA.NAMESPACE = 'FRESHENER'
    ) Q7
    CROSS JOIN (
        SELECT COUNT(
                CASE
                    WHEN AUTO_CLEAN_STATE = '1' THEN 1
                END
            ) AS TOTAL_AUTOCLEAN
        FROM CLEANER_REPORTS
        WHERE
            CLEANER_REPORTS.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFO_ID = '2a9fbea0-4dca-4af6-457b-348bf682cb54'
            )
    ) Q8
    LEFT JOIN (
        SELECT timestamp AS LAST_COUNTER_TS
        FROM COUNTER_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = COUNTER_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 2
        ORDER BY timestamp desc
        LIMIT 1
    ) Q9 ON TRUE


-- get device list for each toilet and its statuss
SELECT DISTINCT
    ON (DEVICES.DEVICE_TOKEN) DEVICES.DEVICE_TOKEN,
    DEVICES.DEVICE_NAME,
    DEVICE_TYPES.DEVICE_TYPE_NAME,
    DEVICES.DEVICE_TYPE_ID
FROM
    "devices"
    LEFT JOIN DEVICE_PAIRS ON DEVICE_PAIRS.DEVICE_ID = DEVICES.DEVICE_ID
    LEFT JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID = DEVICES.DEVICE_TYPE_ID
WHERE (
        DEVICE_PAIRS.TOILET_INFO_ID = '2a9fbea0-4dca-4af6-457b-348bf682cb54'
    )
ORDER BY DEVICES.DEVICE_TOKEN

-- get device status from redis


--telemetry controller , get device lists
SELECT DISTINCT ON (DEVICES.DEVICE_TOKEN) DEVICES.DEVICE_TOKEN,DEVICES.DEVICE_NAME,DEVICE_TYPES.DEVICE_TYPE_NAME,DEVICES.DEVICE_TYPE_ID
FROM DEVICES
LEFT JOIN DEVICE_PAIRS ON DEVICE_PAIRS.DEVICE_ID = DEVICES.DEVICE_ID
LEFT JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID = DEVICES.DEVICE_TYPE_ID
WHERE DEVICE_PAIRS.TOILET_INFO_ID = '0a38e4d1-f9b9-4cb2-648f-20e0ac269984' 
ORDER BY DEVICES.DEVICE_TOKEN


-- get faile sql
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
            DEVICE_PAIRS.TOILET_INFO_ID = '2a9fbea0-4dca-4af6-457b-348bf682cb54'
    )
SELECT
    LAST_UPDATE as timestamp,
    COALESCE(TTLTRAFFIC, '0') AS TOTAL_COUNTER,
    LAST_COUNTER_TS AS LAST_COUNTER_CNT_TIMESTAMP,
    IAQ AS ODOUR_LEVEL,
    TMP,
    LUX,
    FAN_STATUS,
    BLOWER_STATUS,
    OCCUPIED_STATUS,
    DISPLAY_STATUS,
    TOILET_NAME,
    TOILET_TYPE_ID,
    TOTAL_FRAGRANCE,
    TOTAL_AUTOCLEAN,
    TOTAL_COMPLAINT,
    AMMONIA_LEVEL,
    SmokeSensor,
    PanicBtnStatus
FROM (
        SELECT SUM(people_in) AS TTLTRAFFIC
        FROM COUNTER_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = COUNTER_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 2
            AND (TIMESTAMP) >= TO_TIMESTAMP(
                '2024-07-22 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q1
    CROSS JOIN (
        SELECT
            TIMESTAMP AS LAST_UPDATE,
            LUX,
            TEMPERATURE AS TMP,
            IAQ
        FROM
            ENVIROMENT_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = ENVIROMENT_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 3
        ORDER BY TIMESTAMP DESC
        LIMIT 1
    ) Q2
    CROSS JOIN (
        SELECT COUNT(*) AS TOTAL_COMPLAINT
        FROM
            FEEDBACK_PANEL_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = FEEDBACK_PANEL_DATA.DEVICE_TOKEN
            JOIN DEVICE_PAIRS ON DEVICE_PAIRS.DEVICE_ID = DEVICE_LIST.DEVICE_ID
            JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID
        WHERE (TIMESTAMP) >= TO_TIMESTAMP(
                '2024-07-22 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
            AND DEVICE_LIST.TOILET_TYPE_ID = FEEDBACK_PANEL_DATA.TOILET_TYPE_ID
    ) Q5
    CROSS JOIN (
        SELECT
            FAN_STATUS,
            BLOWER_STATUS,
            OCCUPIED_STATUS,
            DISPLAY_STATUS,
            TOILET_NAME,
            TOILET_TYPE_ID
        FROM TOILET_INFOS
        WHERE
            TOILET_INFOS.TOILET_INFO_ID = '2a9fbea0-4dca-4af6-457b-348bf682cb54'
    ) Q6
    CROSS JOIN (
        SELECT COUNT(*) AS TOTAL_FRAGRANCE
        FROM
            MISC_ACTION_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = MISC_ACTION_DATA.DEVICE_TOKEN
        WHERE
            MISC_ACTION_DATA.NAMESPACE = 'FRESHENER'
    ) Q7
    CROSS JOIN (
        SELECT COUNT(
                CASE
                    WHEN AUTO_CLEAN_STATE = '1' THEN 1
                END
            ) AS TOTAL_AUTOCLEAN
        FROM CLEANER_REPORTS
        WHERE
            CLEANER_REPORTS.TOILET_TYPE_ID = (
                SELECT TOILET_TYPE_ID
                FROM TOILET_INFOS
                WHERE
                    TOILET_INFO_ID = '2a9fbea0-4dca-4af6-457b-348bf682cb54'
            )
    ) Q8
    LEFT JOIN (
        SELECT timestamp AS LAST_COUNTER_TS
        FROM COUNTER_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = COUNTER_DATA.DEVICE_TOKEN
        WHERE
            DEVICE_LIST.NAMESPACE_ID = 2
        ORDER BY timestamp desc
        LIMIT 1
    ) Q9 ON TRUE
    LEFT JOIN (
        SELECT avg(ammonia_level) as AMMONIA_LEVEL
        FROM ammonia_data
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = ammonia_data.DEVICE_TOKEN
        WHERE
            timestamp BETWEEN TO_TIMESTAMP(
                '2024-07-22 00:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) AND TO_TIMESTAMP(
                '2024-07-22 23:59:59',
                'YYYY-MM-DD HH24:MI:SS'
            )
        GROUP BY
            ammonia_data.device_token
    ) Q10 ON 1 = 1
    LEFT JOIN (
        SELECT SMOKE_SENSOR as SmokeSensor
        FROM SMOKE_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = SMOKE_DATA.DEVICE_TOKEN
        WHERE
            TIMESTAMP > TO_TIMESTAMP(
                '2024-07-22 00:00:01',
                'YYYY-MM-DD HH24:MI:SS'
            )
        ORDER BY TIMESTAMP DESC
        LIMIT 1
    ) Q11 ON 1 = 1
    LEFT JOIN (
        SELECT PANIC_BUTTON as PanicBtnStatus
        FROM PANIC_BTN_DATA
            JOIN DEVICE_LIST ON DEVICE_LIST.DEVICE_TOKEN = PANIC_BTN_DATA.DEVICE_TOKEN
        WHERE
            TIMESTAMP > TO_TIMESTAMP(
                '2024-07-22 00:00:01',
                'YYYY-MM-DD HH24:MI:SS'
            )
        ORDER BY TIMESTAMP DESC
        LIMIT 1
    ) Q12 ON 1 = 1



 --get all occuoancy sensor with its status for TOILET_INFO_ID = '2a9fbea0-4dca-4af6-457b-348bf682cb54'
 -- TENANT_ID, LOCATION_ID
SELECT * FROM TOILET_INFOS WHERE TOILET_INFO_ID = '2a9fbea0-4dca-4af6-457b-348bf682cb54' 

-- DEVICE_ID, TOILET_INFO_ID
SELECT * FROM DEVICE_PAIRS

SET FOREIGN_KEY_CHECKS = 0;

SET session_replication_role = 'replica';

SET session_replication_role = 'origin';

DISABLE TRIGGER ALL

	
ALTER TABLE DEVICES DISABLE TRIGGER ALL;

SET CONSTRAINTS ALL DEFERRED;

COMMIT;

-- DEVICE TOKEN
SELECT * FROM DEVICES

SELECT * FROM DEVICES


-- DATA
SELECT * FROM devices
where device_id ='4a841976-8eb5-4aba-6b20-246fb6552858'

UPDATE devices
SET device_type_id = 10
WHERE device_id = '4a841976-8eb5-4aba-6b20-246fb6552858';



-- 4a841976-8eb5-4aba-6b20-246fb6552858

SELECT D.DEVICE_ID, D.DEVICE_NAME, D.DEVICE_TOKEN, D.DEVICE_TYPE_ID
FROM DEVICES D
JOIN DEVICE_PAIRS DP ON DP.DEVICE_ID = D.DEVICE_ID
JOIN TOILET_INFOS TI ON TI.TOILET_INFO_ID = DP.TOILET_INFO_ID
WHERE TI.TOILET_INFO_ID =  '2a9fbea0-4dca-4af6-457b-348bf682cb54'
    AND D.DEVICE_TYPE_ID = '12'


update devices
set device_name = 'OCCUPANCY_MALE_M3'
where device_id = '3648c6aa-6fb1-405a-6209-7408a38eb6fa'


-- toilet_info_id = 9eca5dcc-7946-4367-60a5-d7bd09b1e16a , taman bandar

select * from occupancy_data where device_token in ('91', '92', '93', '94')
order by timestamp desc limit 100

WITH DEVICE_LIST AS (select dp.device_pair_id,
    --    dp.toilet_info_id,
    --    ti.toilet_name,
        d.device_id,
       d.device_name,
       d.device_token
from device_pairs as dp
join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
join devices as d on dp.device_id = d.device_id
where dp.toilet_info_id = '9eca5dcc-7946-4367-60a5-d7bd09b1e16a'
    and d.device_type_id =12)
select 
-- od.id, 
od.occupied as occupancy,
-- od.device_token , 
-- right(Q2.alias, 2) as cubical_name, 
Q1.cubical_counter, dl.device_name, dl.device_id
from occupancy_data od
join device_list dl on dl.device_token = od.device_token
left join(
    select COALESCE(sum(CASE WHEN occupied = TRUE AND prev_occupied = FALSE THEN 1 ELSE 0 END),0) as cubical_counter,
    device_token
    from (
        select * ,
        lag(occupied, 1) over(
            order by id
        )prev_occupied
        from occupancy_data
    )
    where timestamp BETWEEN to_timestamp('2024-07-23 00:00:00', 'YYYY-MM-DD HH24:MI:SS') 
    AND to_timestamp('2024-07-23 23:59:59', 'YYYY-MM-DD HH24:MI:SS')
    group by device_token
) Q1 on Q1.device_token = dl.device_token
left join 
(
    select distinct device_id, alias from device_aliases  order by alias desc
)Q2 using(device_id)
order by timestamp desc limit 4

-- next time create timestamp

select * from device_aliases

select * from occupancy_data

--fail query
WITH
    DEVICE_LIST AS (
        select dp.device_pair_id, d.device_name, d.device_token, d.device_id
        from
            device_pairs as dp
            join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
            join devices as d on dp.device_id = d.device_id
        where
            dp.toilet_info_id = '5654c008-dbcc-4656-5601-0a0c50652213'
            and d.device_type_id = 12
    )
select od.occupied as occupancy, 
right(Q2.alias, 2) as cubical_name, 
Q1.cubical_counter
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
            )
        where
            timestamp BETWEEN to_timestamp(
                '2024-07-23 00:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) AND to_timestamp(
                '2024-07-25 23:59:59',
                'YYYY-MM-DD HH24:MI:SS'
            )
        group by
            device_token
    ) Q1 on Q1.device_token = dl.device_token
    left join (
        select distinct
            device_id,
            alias
        from device_aliases
    ) Q2 using (device_id)
order by timestamp desc
limit 4


-- test 
WITH DEVICE_LIST AS (select dp.device_pair_id,
    --    dp.toilet_info_id,
    --    ti.toilet_name,
        d.device_id,
       d.device_name,
       d.device_token
from device_pairs as dp
join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
join devices as d on dp.device_id = d.device_id
where dp.toilet_info_id = '9eca5dcc-7946-4367-60a5-d7bd09b1e16a'
    and d.device_type_id =12)
select * from device_list
left join device_aliases using(device_id)

-- fail query
WITH
    DEVICE_LIST AS (
        select dp.device_pair_id, d.device_name, d.device_token
        from
            device_pairs as dp
            join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
            join devices as d on dp.device_id = d.device_id
        where
            dp.toilet_info_id = '5654c008-dbcc-4656-5601-0a0c50652213'
            and d.device_type_id = 12
    )
select od.occupied as occupancy, right(dl.device_name, 2) as cubical_name, Q1.cubical_counter
from
    occupancy_data od
    join device_list dl on dl.device_token = od.device_token
    left join (
        select COALESCE(
                sum(
                    CASE
                        WHEN occupied THEN 1
                        ELSE 0
                    END
                ), 0
            ) as cubical_counter, device_token
        from occupancy_data
        where
            timestamp BETWEEN to_timestamp(
                '2024-07-22 00:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) AND to_timestamp(
                '2024-07-22 23:59:59',
                'YYYY-MM-DD HH24:MI:SS'
            )
        group by
            device_token
    ) Q1 on Q1.device_token = dl.device_token
order by timestamp desc
limit 4

select DISTINCT ts , count(oc) from
(select date_trunc('HOUR', timestamp) as ts, CASE WHEN occupied = TRUE THEN 1 END as oc from occupancy_data where device_token = '113')Q1
group by ts

-- fail query
WITH
    DEVICE_LIST AS (
        select dp.device_pair_id, d.device_name, d.device_token
        from
            device_pairs as dp
            join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
            join devices as d on dp.device_id = d.device_id
        where
            dp.toilet_info_id = '5654c008-dbcc-4656-5601-0a0c50652213'
            and d.device_type_id = 12
    )
select od.occupied as occupancy, right(dl.device_name, 2) as cubical_name, Q1.cubical_counter
from
    occupancy_data od
    join device_list dl on dl.device_token = od.device_token
    left join (
        select
            COALESCE(
                sum(
                    CASE
                        WHEN occupied = TRUE
                        AND prev_occupied = FALSE THEN 1
                        ELSE 0
                    END
                ),
                0
            ) as cubical_counter,
            device_token
            from (
                select *, lag(occupied, 1) over (
                        order by id
                    ) prev_occupied
                from occupancy_data
            )
        where
            timestamp BETWEEN to_timestamp(
                '2024-07-24 00:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) AND to_timestamp(
                '2024-07-24 23:59:59',
                'YYYY-MM-DD HH24:MI:SS'
            )
        group by
            device_token
    ) Q1 on Q1.device_token = dl.device_token
order by timestamp desc
limit 4


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
                '2024-10-02 23:00:00', 'YYYY-MM-DD HH24:MI:SS'
            ) and TO_TIMESTAMP(
                '2024-10-03 16:00:00', 'YYYY-MM-DD HH24:MI:SS'
            )
            -- and toilet_id = '36f74ec4-cdb0-4271-6c2d-2baa48d6e583'
    ) Q1
group by
    Q1.HAPPY,
    Q1.SATISFIED,
    Q1.NOT_SATISFIED,
    Q1.NOT_HAPPY



--
WITH
    TOILET_LIST AS (
        SELECT ti.toilet_info_id
        FROM toilet_infos ti
        WHERE
            tenant_id = '59944171-3a4a-460d-5897-8bb38c524d54'
    )
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
                '2024-10-02 23:00:00', 'YYYY-MM-DD HH24:MI:SS'
            ) and TO_TIMESTAMP(
                '2024-10-03 16:00:00', 'YYYY-MM-DD HH24:MI:SS'
            )
            and toilet_id in (
                select toilet_info_id
                from toilet_list
            )
    ) Q1
group by
    Q1.HAPPY,
    Q1.SATISFIED,
    Q1.NOT_SATISFIED,
    Q1.NOT_HAPPY




    -- overview
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
        from 
        timestamp between TO_TIMESTAMP(
                '2024-10-07 23:00:00', 'YYYY-MM-DD HH24:MI:SS'
            ) and TO_TIMESTAMP(
                '2024-10-07 16:00:00', 'YYYY-MM-DD HH24:MI:SS'
            )
            and toilet_id = '36f74ec4-cdb0-4271-6c2d-2baa48d6e583'
    ) Q1
group by
    Q1.HAPPY,
    Q1.SATISFIED,
    Q1.NOT_SATISFIED,
    Q1.NOT_HAPPY[
        0 rows affected
        or returned
    ]


--
 WITH DEVICE_LIST AS (SELECT DEVICES.DEVICE_NAME,DEVICES.DEVICE_ID,DEVICES.DEVICE_TOKEN,TOILET_INFOS.TOILET_NAME AS IDENTIFIER,TOILET_INFOS.TOILET_INFO_ID AS IDENTIFIER_ID,DEVICE_TYPES.DEVICE_TYPE_NAME 
 AS NAMESPACE,DEVICE_TYPES.DEVICE_TYPE_ID AS NAMESPACE_ID, TOILET_TYPES.TOILET_TYPE_ID FROM DEVICE_PAIRS JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID 
 = DEVICES.DEVICE_TYPE_ID JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID JOIN TOILET_TYPES ON TOILET_TYPES.TOILET_TYPE_ID = TOILET_INFOS.TOILET_TYPE_ID WHERE 
 TOILET_INFOS.TOILET_INFO_ID = '36f74ec4-cdb0-4271-6c2d-2baa48d6e583'), GENTIME as (SELECT uplinkTS FROM 
 generate_series(date_trunc('HOUR', TO_TIMESTAMP('2024-10-07 23:00:00', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('HOUR', TO_TIMESTAMP('2024-10-07 16:00:00', 'YYYY-MM-DD HH24:MI:SS')), interval '1 HOUR') 
 uplinkTS select iaq, uplinkts from gentime left join 
 (select avg(iaq)::int as iaq, date_trunc('HOUR', timestamp) as uplinkts from 
 enviroment_data where EXTRACT(HOUR FROM timestamp) >= 23  or EXTRACT(HOUR FROM timestamp) >= 0 AND EXTRACT(HOUR FROM timestamp) <= 16 and timestamp between to_timestamp('2024-10-07 23:00:00','YYYY-MM-DD HH24:MI:SS') and 
 to_timestamp('2024-10-07 16:00:00','YYYY-MM-DD HH24:MI:SS') and device_token IN (select device_token from device_list) group by uplinkts)Q1 using(uplinkts) order by uplinkts


-- 7767
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
        from user_reactions timestamp between TO_TIMESTAMP(
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
    Q1.NOT_HAPPY[
        0 rows affected
        or returned
    ]



    
    select * from fragrance_data where device_token = '610'
    AND fragrance_on = true

    AND timestamp between TO_TIMESTAMP(
    '2024-10-06 23:00:00',
    'YYYY-MM-DD HH24:MI:SS'
    ) and TO_TIMESTAMP(
    '2024-10-07 16:00:00',
    'YYYY-MM-DD HH24:MI:SS'
    )


    --
select count(
    case
        when fragrance_on = true then 1
    end
) as TOTAL_FRAGRANCE_SPRAY_ACTIVATED
from fragrance_data
where
    device_token in (
        '610'
    )
    and timestamp between TO_TIMESTAMP(
        '2024-10-06 23:00:00',
        'YYYY-MM-DD HH24:MI:SS'
    ) and TO_TIMESTAMP(
        '2024-10-07 16:00:00',
        'YYYY-MM-DD HH24:MI:SS'
    )



SELECT * FROM MISC_ACTION_DATA  WHERE DEVICE_TOKEN = '610' AND STATUS = '1' 
AND timestamp between TO_TIMESTAMP(
    '2024-10-06 23:00:00',
    'YYYY-MM-DD HH24:MI:SS'
) and TO_TIMESTAMP(
    '2024-10-07 16:00:00',
    'YYYY-MM-DD HH24:MI:SS'
)


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
    )
SELECT
    COALESCE(TRAFFIC_COUNT_TODAY, 0) as TRAFFIC_COUNT_TODAY,
    COALESCE(
        TOTAL_FRAGRANCE_SPRAY_ACTIVATED,
        0
    ) as TOTAL_FRAGRANCE_SPRAY_ACTIVATED,
    LAST_FRAGRANCE_SPRAY_ACTIVATED,
    CURRENT_LUX,
    COALESCE(CURRENT_IAQ, 0) as CURRENT_IAQ,
    COALESCE(TOTAL_CLEANED_TODAY, 0) as TOTAL_CLEANED_TODAY,
    LAST_CLEAN_TIMESTAMP,
    COALESCE(CURRENT_HUMIDITY, 0) as CURRENT_HUMIDITY,
    COALESCE(CURRENT_TEMPERATURE, 0) as CURRENT_TEMPERATURE
FROM (
        select count(people_in) as TRAFFIC_COUNT_TODAY
        from counter_data
        where
            device_token in (
                select device_token
                from DEVICE_LIST
                where
                    namespace_id = 2
            )
            and EXTRACT(
                HOUR
                FROM timestamp
            ) >= 7
            AND EXTRACT(
                HOUR
                FROM timestamp
            ) <= 18
            and timestamp between TO_TIMESTAMP(
                '2024-10-06 23:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and TO_TIMESTAMP(
                '2024-10-07 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q1
    LEFT JOIN (
        select
            timestamp as LAST_FRAGRANCE_SPRAY_ACTIVATED
        from fragrance_data
        where
            device_token in (
                select device_token
                from DEVICE_LIST
                where
                    namespace_id = 5
            )
        order by timestamp desc
        limit 1
    ) Q2 ON 1 = 1
    LEFT JOIN (
        select
            iaq as CURRENT_IAQ,
            (
                CASE
                    WHEN lux > 1.5 THEN 'BRIGHT'
                    ELSE 'DARK'
                END
            ) as CURRENT_LUX,
            humidity as CURRENT_HUMIDITY,
            temperature as CURRENT_TEMPERATURE
        from enviroment_data
        where
            device_token in (
                select device_token
                from DEVICE_LIST
                where
                    namespace_id = 3
            )
        order by timestamp desc
        limit 1
    ) Q3 ON 1 = 1
    LEFT JOIN (
        select count(cleaner_report_id) as TOTAL_CLEANED_TODAY
        from cleaner_reports
        where
            EXTRACT(
                HOUR
                FROM check_in_ts
            ) >= 7
            AND EXTRACT(
                HOUR
                FROM check_in_ts
            ) <= 18
            and check_in_ts between TO_TIMESTAMP(
                '2024-10-06 23:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and TO_TIMESTAMP(
                '2024-10-07 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q4 ON 1 = 1
    LEFT JOIN (
        select
            created_at as LAST_CLEAN_TIMESTAMP
        from cleaner_reports
        where
            EXTRACT(
                HOUR
                FROM check_in_ts
            ) >= 7
            AND EXTRACT(
                HOUR
                FROM check_in_ts
            ) <= 18
            and auto_clean_state = '0'
            and check_in_ts between TO_TIMESTAMP(
                '2024-10-06 23:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and TO_TIMESTAMP(
                '2024-10-07 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
        order by created_at
        limit 1
    ) Q5 ON 1 = 1
    LEFT JOIN (
        select
            count(
                case
                    when status = '1' then 1
                end
            ) as TOTAL_FRAGRANCE_SPRAY_ACTIVATED
        from misc_action_data
        where
            device_token in (
                select device_token
                from device_list
                where
                    namespace_id = 6
            )
            and status = '1'
            AND timestamp between TO_TIMESTAMP(
                '2024-10-06 23:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and TO_TIMESTAMP(
                '2024-10-07 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q6 ON 1 = 1



    --
WITH DEVICE_LIST AS (
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
)
select device_token, NAMESPACE_ID
from device_list



--
with
    start_end as (
        select to_timestamp(
                '2024-10-06 23:00:00', 'YYYY-MM-DD HH24:MI:SS'
            ) as start_date, to_timestamp(
                '2024-10-07 16:00:00', 'YYYY-MM-DD HH24:MI:SS'
            ) as end_date
    ),
    device_list as (
        select standard_view_devices.device_token, standard_view_devices.namespace_id, standard_view_devices.toilet_info_id
        from standard_view_devices
        where
            standard_view_devices.toilet_info_id = '9388096c-784d-49c8-784c-1868b1233165'
    )
select
    coalesce(ttltraffic, '0') as total_counter,
    last_counter_ts as last_counter_cnt_timestamp,
    iaq as odour_level,
    total_fragrance
from (
        select device_list.toilet_info_id
        from device_list
        limit 1
    ) as Q0
    LEFT join (
        select sum(people_in) as ttltraffic
        from counter_data
            join device_list using (device_token)
        where
            device_list.namespace_id = 2
            -- and extract(hour from timestamp) >= 7 and extract(hour from timestamp) <= 18
            and timestamp between (
                select start_date
                from start_end
            ) and (
                select end_date
                from start_end
            )
    ) as Q1 ON TRUE
    LEFT join (
        select iaq
        from enviroment_data
            join device_list using (device_token)
        where
            device_list.namespace_id = 3
            -- and extract(hour from timestamp) >= 7 and extract(hour from timestamp) <= 18
            and timestamp between (
                select start_date
                from start_end
            ) and (
                select end_date
                from start_end
            )
        order by timestamp desc
        limit 1
    ) as Q2 ON TRUE
    left join (
        select count(misc_data_id) / 8 as total_fragrance
        from misc_action_data
            join device_list using (device_token)
        where
            misc_action_data.namespace = 'FRESHENER'
            -- and extract(hour from timestamp) >= 7 and extract(hour from timestamp) <= 18
            and timestamp between (
                select start_date
                from start_end
            ) and (
                select end_date
                from start_end
            )
    ) as Q7 ON TRUE
    left join (
        select timestamp as last_counter_ts
        from counter_data
            join device_list using (device_token)
        where
            device_list.namespace_id = 2
            -- and extract(hour from timestamp) >= 7 and extract(hour from timestamp) <= 18
            and timestamp between (
                select start_date
                from start_end
            ) and (
                select end_date
                from start_end
            )
        order by timestamp desc
        limit 1
    ) as Q9 ON TRUE


    --
with  device_list as (
select standard_view_devices.device_token, standard_view_devices.namespace_id, standard_view_devices.toilet_info_id
from standard_view_devices
where
    standard_view_devices.toilet_info_id = '9388096c-784d-49c8-784c-1868b1233165'
),
start_end as (
    select to_timestamp(
            '2024-10-06 23:00:00', 'YYYY-MM-DD HH24:MI:SS'
        ) as start_date, to_timestamp(
            '2024-10-07 16:00:00', 'YYYY-MM-DD HH24:MI:SS'
        ) as end_date
)
select sum(people_in) as ttltraffic
from counter_data
    join device_list using (device_token)
where
    device_list.namespace_id = 2
    -- and extract(hour from timestamp) >= 7 and extract(hour from timestamp) <= 18
    and timestamp between (
        select start_date
        from start_end
    ) and (
        select end_date
        from start_end
    )


    --7762
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
    )
SELECT
    COALESCE(TRAFFIC_COUNT_TODAY, 0) as TRAFFIC_COUNT_TODAY,
    COALESCE(
        TOTAL_FRAGRANCE_SPRAY_ACTIVATED,
        0
    ) as TOTAL_FRAGRANCE_SPRAY_ACTIVATED,
    LAST_FRAGRANCE_SPRAY_ACTIVATED,
    CURRENT_LUX,
    COALESCE(CURRENT_IAQ, 0) as CURRENT_IAQ,
    COALESCE(TOTAL_CLEANED_TODAY, 0) as TOTAL_CLEANED_TODAY,
    LAST_CLEAN_TIMESTAMP,
    COALESCE(CURRENT_HUMIDITY, 0) as CURRENT_HUMIDITY,
    COALESCE(CURRENT_TEMPERATURE, 0) as CURRENT_TEMPERATURE
FROM (
        select count(people_in) as TRAFFIC_COUNT_TODAY
        from counter_data
        where
            device_token in (
                select device_token
                from DEVICE_LIST
                where
                    namespace_id = 2
            )
            and EXTRACT(
                HOUR
                FROM timestamp
            ) >= 7
            AND EXTRACT(
                HOUR
                FROM timestamp
            ) <= 18
            and timestamp between TO_TIMESTAMP(
                '2024-10-06 23:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and TO_TIMESTAMP(
                '2024-10-07 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q1
    LEFT JOIN (
        select
            timestamp as LAST_FRAGRANCE_SPRAY_ACTIVATED
        from fragrance_data
        where
            device_token in (
                select device_token
                from DEVICE_LIST
                where
                    namespace_id = 5
            )
        order by timestamp desc
        limit 1
    ) Q2 ON 1 = 1
    LEFT JOIN (
        select
            iaq as CURRENT_IAQ,
            (
                CASE
                    WHEN lux > 1.5 THEN 'BRIGHT'
                    ELSE 'DARK'
                END
            ) as CURRENT_LUX,
            humidity as CURRENT_HUMIDITY,
            temperature as CURRENT_TEMPERATURE
        from enviroment_data
        where
            device_token in (
                select device_token
                from DEVICE_LIST
                where
                    namespace_id = 3
            )
        order by timestamp desc
        limit 1
    ) Q3 ON 1 = 1
    LEFT JOIN (
        select count(cleaner_report_id) as TOTAL_CLEANED_TODAY
        from cleaner_reports
        where
            EXTRACT(
                HOUR
                FROM check_in_ts
            ) >= 7
            AND EXTRACT(
                HOUR
                FROM check_in_ts
            ) <= 18
            and check_in_ts between TO_TIMESTAMP(
                '2024-10-06 23:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and TO_TIMESTAMP(
                '2024-10-07 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q4 ON 1 = 1
    LEFT JOIN (
        select
            created_at as LAST_CLEAN_TIMESTAMP
        from cleaner_reports
        where
            EXTRACT(
                HOUR
                FROM check_in_ts
            ) >= 7
            AND EXTRACT(
                HOUR
                FROM check_in_ts
            ) <= 18
            and auto_clean_state = '0'
            and check_in_ts between TO_TIMESTAMP(
                '2024-10-06 23:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and TO_TIMESTAMP(
                '2024-10-07 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
        order by created_at
        limit 1
    ) Q5 ON 1 = 1
    LEFT JOIN (
        select
            count(
                case
                    when status = '1' then 1
                end
            ) / 8 as TOTAL_FRAGRANCE_SPRAY_ACTIVATED
        from misc_action_data
        where
            device_token in (
                select device_token
                from device_list
                where
                    namespace_id = 5
            )
            and status = '1'
            AND timestamp between TO_TIMESTAMP(
                '2024-10-06 23:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and TO_TIMESTAMP(
                '2024-10-07 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q6 ON 1 = 1



    select * from counter_data limit 1





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
    CURRENT_LUX,
    COALESCE(CURRENT_IAQ, 0) as CURRENT_IAQ,
    COALESCE(TOTAL_CLEANED_TODAY, 0) as TOTAL_CLEANED_TODAY,
    LAST_CLEAN_TIMESTAMP,
    COALESCE(CURRENT_HUMIDITY, 0) as CURRENT_HUMIDITY,
    COALESCE(CURRENT_TEMPERATURE, 0) as CURRENT_TEMPERATURE
FROM (
        select count(
                case
                    when people_in = 1
                    and people_in_prev = 0 then 1
                end
            ) as TRAFFIC_COUNT_TODAY
        from (
                select people_in, lag(people_in, 1) as people_in_prev
                from counter_data
                where
                    device_token in (
                        select device_token
                        from DEVICE_LIST
                        where
                            namespace_id = 2
                    ) 
            )s1
            and timestamp between TO_TIMESTAMP(
                '2024-10-06 23:00:00', 'YYYY-MM-DD HH24:MI:SS'
            ) and TO_TIMESTAMP(
                '2024-10-07 16:00:00', 'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q1
    LEFT JOIN (
        select
            timestamp as LAST_FRAGRANCE_SPRAY_ACTIVATED
        from fragrance_data
        where
            device_token in (
                select device_token
                from DEVICE_LIST
                where
                    namespace_id = 5
            )
        order by timestamp desc
        limit 1
    ) Q2 ON 1 = 1
    LEFT JOIN (
        select
            iaq as CURRENT_IAQ,
            (
                CASE
                    WHEN lux > 1.5 THEN 'BRIGHT'
                    ELSE 'DARK'
                END
            ) as CURRENT_LUX,
            humidity as CURRENT_HUMIDITY,
            temperature as CURRENT_TEMPERATURE
        from enviroment_data
        where
            device_token in (
                select device_token
                from DEVICE_LIST
                where
                    namespace_id = 3
            )
        order by timestamp desc
        limit 1
    ) Q3 ON 1 = 1
    LEFT JOIN (
        select count(cleaner_report_id) as TOTAL_CLEANED_TODAY
        from cleaner_reports
        where
            EXTRACT(
                HOUR
                FROM check_in_ts
            ) >= 7
            AND EXTRACT(
                HOUR
                FROM check_in_ts
            ) <= 18
            and check_in_ts between TO_TIMESTAMP(
                '2024-10-06 23:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and TO_TIMESTAMP(
                '2024-10-07 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q4 ON 1 = 1
    LEFT JOIN (
        select
            created_at as LAST_CLEAN_TIMESTAMP
        from cleaner_reports
        where
            EXTRACT(
                HOUR
                FROM check_in_ts
            ) >= 7
            AND EXTRACT(
                HOUR
                FROM check_in_ts
            ) <= 18
            and auto_clean_state = '0'
            and check_in_ts between TO_TIMESTAMP(
                '2024-10-06 23:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and TO_TIMESTAMP(
                '2024-10-07 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
        order by created_at
        limit 1
    ) Q5 ON 1 = 1
    LEFT JOIN (
        select
            count(
                case
                    when status = '1' then 1
                end
            ) / 8 as TOTAL_FRAGRANCE_SPRAY_ACTIVATED
        from misc_action_data
        where
            device_token in (
                select device_token
                from device_list
                where
                    namespace_id = 5
            )
            and status = '1'
            AND timestamp between TO_TIMESTAMP(
                '2024-10-06 23:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) and TO_TIMESTAMP(
                '2024-10-07 16:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q6 ON 1 = 1