

select * from money_data

-- alter money_data add column tenant_id text
ALTER TABLE money_data ADD COLUMN tenant_id TEXT; 

insert into money_data("is_debit", "is_credit", "ammount", "description", "created_at", "updated_at","deleted_at","tenant_id")
values (true, false, 2.0, 'person in', '2024-08-14 09:00:00', '2024-08-14 09:00:00', null, '589ee2f0-75e1-4cd0-5c74-78a4df1288fd')


select sum(ammount) from money_data where created_at BETWEEN TO_TIMESTAMP(
    '2024-08-14 07:00:00',
    'YYYY-MM-DD HH24:MI:SS'
) AND TO_TIMESTAMP(
    '2024-08-14 18:00:00',
    'YYYY-MM-DD HH24:MI:SS'
)


select sum(ammount) from money_data
-- money

WITH
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
    ),
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
    )
SELECT
COALESCE(TotalCollection,0), 
COALESCE(TotalTraffic, 0),  
UplinkTS
from
GENTIME G
LEFT JOIN
    (select distinct UplinkTS, sum(RM) as TotalCollection from
        (select date_trunc('HOUR', created_at) as UplinkTS, ammount as RM from
        money_data md where md.tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd')S1
        group by UplinkTS, RM)
    Q1 USING (UplinkTS)
LEFT JOIN 
(
    select  date_trunc('HOUR', timestamp) as UplinkTS, count(people_in) as TotalTraffic from counter_data
    group by UplinkTS
)Q2 using (UplinkTS)


-- test
select  date_trunc('HOUR', timestamp) as UplinkTS, count(people_in) from counter_data
group by UplinkTS

-- count not sum
select date_trunc('HOUR', created_at) as UplinkTS, count(ammount) as RM from
money_data md where md.tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd'
group by UplinkTS