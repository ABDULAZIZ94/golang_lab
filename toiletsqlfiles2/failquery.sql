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