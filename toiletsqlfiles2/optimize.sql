

WITH
    DEVICE_LIST AS (
        select d.device_token, d.device_type_id
        from
            device_cubical_pairs dcp
            join devices d on d.device_id = dcp.device_id
        where
            dcp.cubical_id = '881ac292-f7ba-42ed-61be-7ea9e5368d89'
    ),
    GENTIME as (
        SELECT uplinkTS
        FROM generate_series(
                date_trunc(
                    'HOUR', TO_TIMESTAMP(
                        '2024-10-11 07:00:00', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), date_trunc(
                    'HOUR', TO_TIMESTAMP(
                        '2024-10-12 23:59:59', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), interval '1' HOUR
            ) uplinkTS
    )
select count(
        case
            when occupied = true
            and prev_occupied = false then 1
        end
    ) as USER, uplinkts
from gentime
    left join (
        select
            occupied, LAG(occupied, 1) OVER (
                ORDER BY id
            ) AS prev_occupied, date_trunc('HOUR', timestamp) as uplinkts
        from occupancy_data
        where
            (
                timestamp::time >= '23:00:00'
                AND timestamp::time <= '23:59:59'
            )
            OR (
                timestamp::time >= '00:00:00'
                AND timestamp::time <= '16:00:00'
            )
            AND timestamp between TO_TIMESTAMP(
                '2024-10-11 07:00:00', 'YYYY-MM-DD HH24:MI:SS'
            ) and TO_TIMESTAMP(
                '2024-10-12 23:59:59', 'YYYY-MM-DD HH24:MI:SS'
            )
            and device_token in (
                select device_token
                from device_list
                where
                    device_type_id = 12
            )
    ) S1 using (uplinkts)
group by
    uplinkts
order by uplinkts





--
WITH
    DEVICE_LIST AS (
        select d.device_token, d.device_type_id
        from
            device_cubical_pairs dcp
            join devices d on d.device_id = dcp.device_id
        where
            dcp.cubical_id = '881ac292-f7ba-42ed-61be-7ea9e5368d89'
    ),
    GENTIME as (
        SELECT uplinkTS
        FROM generate_series(
                date_trunc(
                    'HOUR', TO_TIMESTAMP(
                        '2024-10-11 07:00:00', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), date_trunc(
                    'HOUR', TO_TIMESTAMP(
                        '2024-10-12 23:59:59', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), interval '1' HOUR
            ) uplinkTS
    )
select SUM(COALESCE(ENTRANCE,0)) as USER, uplinkts
from gentime
    left join (
        select
            -- occupied, 
            CASE
                WHEN LAG(occupied, 1) OVER (
                    ORDER BY timestamp DESC
                ) = FALSE
                AND OCCUPIED = TRUE THEN 1
                ELSE 0
            END AS ENTRANCE, date_trunc('HOUR', timestamp) as uplinkts
        from occupancy_data
        where
            timestamp between TO_TIMESTAMP(
                '2024-10-11 07:00:00', 'YYYY-MM-DD HH24:MI:SS'
            ) and TO_TIMESTAMP(
                '2024-10-12 23:59:59', 'YYYY-MM-DD HH24:MI:SS'
            )
            AND DEVICE_TOKEN = '100'
            -- and device_token in (
            --     select device_token
            --     from device_list
            --     where
            --         device_type_id = 12
            -- )
            AND (
                (
                    timestamp::time >= '07:00:00'
                    AND timestamp::time <= '23:59:59'
                )
                OR (
                    timestamp::time >= '07:00:00'
                    AND timestamp::time <= '23:59:59'
                )
            )
    ) Q1 using (uplinkts)
group by
    uplinkts
    -- order by uplinkts