CREATE MATERIALIZED VIEW IF NOT EXISTS standard_view_devices AS


WITH
    DEVICE_LIST AS (
        SELECT
            DEVICE_TOKEN,
            NAMESPACE_ID
        FROM    
            standard_view_devices
        WHERE
            TOILET_INFO_ID = '36f74ec4-cdb0-4271-6c2d-2baa48d6e583' AND NAMESPACE_ID = '3'
    ),
    GENTIME as (
        SELECT uplinkTS
        FROM generate_series(
                date_trunc(
                    'HOUR', TO_TIMESTAMP(
                        '2024-10-02 23:00:00', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), date_trunc(
                    'HOUR', TO_TIMESTAMP(
                        '2024-10-03 16:00:00', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), interval '1' HOUR
            ) uplinkTS
        where
            EXTRACT(
                HOUR
                FROM uplinkTS
            ) >= 23
            AND EXTRACT(
                HOUR
                FROM uplinkTS
            ) <= 0
            or EXTRACT(
                HOUR
                FROM uplinkTS
            ) >= 0
            AND EXTRACT(
                HOUR
                FROM uplinkTS
            ) <= 10
    ),
    data_res as (
        select iaq, uplinkts
        from gentime
        left join env_agg using(uplinkts)
        order by gentime.uplinkts
        
    )
select iaq, uplinkts
from data_res