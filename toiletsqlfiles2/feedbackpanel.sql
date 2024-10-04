
select * from feedback_panels

select * from feedback_panel_data 

select * from feedback_panel_data where timestamp between to_timestamp(
    '2024-07-13 07:00:00',
    'YYYY-MM-DD HH24:MI:SS'
)
and to_timestamp(
    '2024-07-13 18:00:00',
    'YYYY-MM-DD HH24:MI:SS'
)

-- full feedback panel
select COUNT(CASE WHEN BUTTON_ID = 1 THEN 1 END) AS REFRESH_TOILET, 
    COUNT(CASE WHEN BUTTON_ID = 2 THEN 1 END) AS OUT_TISSUE,  
    COUNT(CASE WHEN BUTTON_ID = 3 THEN 1 END) AS BIN_FULL,  
    COUNT(CASE WHEN BUTTON_ID = 4 THEN 1 END) AS OUT_SOAP,  
    COUNT(CASE WHEN BUTTON_ID = 5 THEN 1  END) AS BUSUK,  
    COUNT(CASE WHEN BUTTON_ID = 6 THEN 1 END) AS CLOGGED_TOILET,  
    COUNT(CASE WHEN BUTTON_ID = 7 THEN 1 END) AS URINAL_CLOG,  
    COUNT(CASE WHEN BUTTON_ID = 8 THEN 1 END) AS SLIPPERY,  
    COUNT(CASE WHEN BUTTON_ID = 9 THEN 1 END) AS SANITARY_BIN_FULL,  
    COUNT(CASE WHEN BUTTON_ID = 10 THEN 1 END) AS PIPE_LEAK 
from feedback_panel_data where (timestamp) between to_timestamp('2024-08-13 07:00:00', 'YYYY-MM-DD HH24:MI:SS') and to_timestamp('2024-08-13 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
and device_token in ('117', '108')


-- make date tuncate and numerical
select distinct ts, 
COUNT(REFRESH_TOILET) AS REFRESH_TOILET, 
    COUNT(OUT_TISSUE) AS OUT_TISSUE,  
    COUNT(BIN_FULL) AS BIN_FULL,  
    COUNT(OUT_SOAP) AS OUT_SOAP,  
    COUNT(BUSUK) AS BUSUK,  
    COUNT(CLOGGED_TOILET) AS CLOGGED_TOILET,  
    COUNT(URINAL_CLOG) AS URINAL_CLOG,  
    COUNT(SLIPPERY) AS SLIPPERY,  
    COUNT(SANITARY_BIN_FULL) AS SANITARY_BIN_FULL,  
    COUNT(PIPE_LEAK) AS PIPE_LEAK 
FROM
(select CASE WHEN BUTTON_ID = 1 THEN 1 ELSE 0 END AS REFRESH_TOILET, 
    CASE WHEN BUTTON_ID = 2 THEN 1 ELSE 0 END AS OUT_TISSUE,  
    CASE WHEN BUTTON_ID = 3 THEN 1 ELSE 0 END AS BIN_FULL,  
    CASE WHEN BUTTON_ID = 4 THEN 1 ELSE 0 END AS OUT_SOAP,  
    CASE WHEN BUTTON_ID = 5 THEN 1  ELSE 0 END AS BUSUK,  
    CASE WHEN BUTTON_ID = 6 THEN 1 ELSE 0 END AS CLOGGED_TOILET,  
    CASE WHEN BUTTON_ID = 7 THEN 1 ELSE 0 END AS URINAL_CLOG,  
    CASE WHEN BUTTON_ID = 8 THEN 1 ELSE 0 END AS SLIPPERY,  
    CASE WHEN BUTTON_ID = 9 THEN 1 ELSE 0 END AS SANITARY_BIN_FULL,  
    CASE WHEN BUTTON_ID = 10 THEN 1 ELSE 0 END AS PIPE_LEAK ,
    date_trunc('Hour', timestamp) as ts
from feedback_panel_data where device_token In ('1','2') and
(timestamp) between to_timestamp('2024-07-01 07:00:00', 'YYYY-MM-DD HH24:MI:SS') and to_timestamp('2024-07-13 18:00:00', 'YYYY-MM-DD HH24:MI:SS'))S1
group by S1.ts


-- make date tuncate and numerical, combine c
-- old complainttypemonthly
select ts, SUM(OUT_TISSUE + OUT_SOAP) AS OUTOFSUPPLY,
    SLIPPERY,
    SMELLY,
    PLUMBING_ISSUES
from (
    select distinct ts, 
        -- SUM(OUT_TISSUE + OUT_SOAP) AS OUTOFSUPPLY,
        COUNT(REFRESH_TOILET) AS REFRESH_TOILET, 
        COUNT(OUT_TISSUE) AS OUT_TISSUE,  
        COUNT(BIN_FULL) AS BIN_FULL,  
        COUNT(OUT_SOAP) AS OUT_SOAP,  
        COUNT(BUSUK) AS SMELLY,  
        COUNT(CLOGGED_TOILET) AS CLOGGED_TOILET,  
        COUNT(URINAL_CLOG) AS URINAL_CLOG,  
        COUNT(SLIPPERY) AS SLIPPERY,  
        COUNT(SANITARY_BIN_FULL) AS SANITARY_BIN_FULL,  
        COUNT(PIPE_LEAK) AS PLUMBING_ISSUES
    FROM
    (select CASE WHEN BUTTON_ID = 1 THEN 1 ELSE 0 END AS REFRESH_TOILET, 
        CASE WHEN BUTTON_ID = 2 THEN 1 ELSE 0 END AS OUT_TISSUE,  
        CASE WHEN BUTTON_ID = 3 THEN 1 ELSE 0 END AS BIN_FULL,  
        CASE WHEN BUTTON_ID = 4 THEN 1 ELSE 0 END AS OUT_SOAP,  
        CASE WHEN BUTTON_ID = 5 THEN 1  ELSE 0 END AS BUSUK,  
        CASE WHEN BUTTON_ID = 6 THEN 1 ELSE 0 END AS CLOGGED_TOILET,  
        CASE WHEN BUTTON_ID = 7 THEN 1 ELSE 0 END AS URINAL_CLOG,  
        CASE WHEN BUTTON_ID = 8 THEN 1 ELSE 0 END AS SLIPPERY,  
        CASE WHEN BUTTON_ID = 9 THEN 1 ELSE 0 END AS SANITARY_BIN_FULL,  
        CASE WHEN BUTTON_ID = 10 THEN 1 ELSE 0 END AS PIPE_LEAK ,
        date_trunc('Hour', timestamp) as ts
    from feedback_panel_data where device_token In ('1','2') and
    (timestamp) between to_timestamp('2024-07-01 07:00:00', 'YYYY-MM-DD HH24:MI:SS') and to_timestamp('2024-07-13 18:00:00', 'YYYY-MM-DD HH24:MI:SS'))S1
    group by S1.ts
) Q1 group by Q1.ts, Q1.slippery, Q1.smelly, Q1.plumbing_issues


SELECT SUM(100 - 10) ;


-- error
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
select
    ts,
    SUM(OUT_TISSUE + OUT_SOAP) AS OUTOFSUPPLY,
    WETFLOOR,
    SMELLY,
    PLUMBING_ISSUES
from (
        
            select distinct
                ts, COUNT(REFRESH_TOILET) AS REFRESH_TOILET, COUNT(OUT_TISSUE) AS OUT_TISSUE, COUNT(BIN_FULL) AS BIN_FULL, COUNT(OUT_SOAP) AS OUT_SOAP, COUNT(BUSUK) AS SMELLY, COUNT(CLOGGED_TOILET) AS CLOGGED_TOILET, COUNT(URINAL_CLOG) AS URINAL_CLOG, COUNT(SLIPPERY) AS WETFLOOR, COUNT(SANITARY_BIN_FULL) AS SANITARY_BIN_FULL, COUNT(PIPE_LEAK) AS PLUMBING_ISSUES
            FROM (
                    select
                        CASE
                            WHEN BUTTON_ID = 1 THEN 1
                            ELSE 0
                        END AS REFRESH_TOILET, CASE
                            WHEN BUTTON_ID = 2 THEN 1
                            ELSE 0
                        END AS OUT_TISSUE, CASE
                            WHEN BUTTON_ID = 3 THEN 1
                            ELSE 0
                        END AS BIN_FULL, CASE
                            WHEN BUTTON_ID = 4 THEN 1
                            ELSE 0
                        END AS OUT_SOAP, CASE
                            WHEN BUTTON_ID = 5 THEN 1
                            ELSE 0
                        END AS BUSUK, CASE
                            WHEN BUTTON_ID = 6 THEN 1
                            ELSE 0
                        END AS CLOGGED_TOILET, CASE
                            WHEN BUTTON_ID = 7 THEN 1
                            ELSE 0
                        END AS URINAL_CLOG, CASE
                            WHEN BUTTON_ID = 8 THEN 1
                            ELSE 0
                        END AS SLIPPERY, CASE
                            WHEN BUTTON_ID = 9 THEN 1
                            ELSE 0
                        END AS SANITARY_BIN_FULL, CASE
                            WHEN BUTTON_ID = 10 THEN 1
                            ELSE 0
                        END AS PIPE_LEAK, date_trunc('Hour', timestamp) as ts
                    from feedback_panel_data
                    where (timestamp)
                       between to_timestamp(
                            '2024-08-13 07:00:00', 'YYYY-MM-DD HH24:MI:SS'
                        ) and to_timestamp(
                            '2024-08-01 18:00:00', 'YYYY-MM-DD HH24:MI:SS'
                        )
                        and device_token IN (
                            select device_token
                            from DEVICE_LIST
                        )
                ) S1
            group by
                S1.ts
    ) Q1
group by
    Q1.ts,
    Q1.WETFLOOR,
    Q1.smelly,
    Q1.PLUMBING_ISSUES

    -- WETFLOOR, SMELLY, 

-- fix error
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
select
    ts,
    SUM(OUT_TISSUE + OUT_SOAP) AS OUTOFSUPPLY,
    WETFLOOR,
    SMELLY,
    PLUMBING_ISSUES
from (
        select distinct
            ts, COUNT(REFRESH_TOILET) AS REFRESH_TOILET, COUNT(OUT_TISSUE) AS OUT_TISSUE, COUNT(BIN_FULL) AS BIN_FULL, COUNT(OUT_SOAP) AS OUT_SOAP, COUNT(BUSUK) AS SMELLY, COUNT(CLOGGED_TOILET) AS CLOGGED_TOILET, COUNT(URINAL_CLOG) AS URINAL_CLOG, COUNT(SLIPPERY) AS WETFLOOR, COUNT(SANITARY_BIN_FULL) AS SANITARY_BIN_FULL, COUNT(PIPE_LEAK) AS PLUMBING_ISSUES
        FROM (
                select
                    CASE
                        WHEN BUTTON_ID = 1 THEN 1
                        ELSE 0
                    END AS REFRESH_TOILET, CASE
                        WHEN BUTTON_ID = 2 THEN 1
                        ELSE 0
                    END AS OUT_TISSUE, CASE
                        WHEN BUTTON_ID = 3 THEN 1
                        ELSE 0
                    END AS BIN_FULL, CASE
                        WHEN BUTTON_ID = 4 THEN 1
                        ELSE 0
                    END AS OUT_SOAP, CASE
                        WHEN BUTTON_ID = 5 THEN 1
                        ELSE 0
                    END AS BUSUK, CASE
                        WHEN BUTTON_ID = 6 THEN 1
                        ELSE 0
                    END AS CLOGGED_TOILET, CASE
                        WHEN BUTTON_ID = 7 THEN 1
                        ELSE 0
                    END AS URINAL_CLOG, CASE
                        WHEN BUTTON_ID = 8 THEN 1
                        ELSE 0
                    END AS SLIPPERY, CASE
                        WHEN BUTTON_ID = 9 THEN 1
                        ELSE 0
                    END AS SANITARY_BIN_FULL, CASE
                        WHEN BUTTON_ID = 10 THEN 1
                        ELSE 0
                    END AS PIPE_LEAK, date_trunc('Hour', timestamp) as ts
                from feedback_panel_data
                where (timestamp) between to_timestamp(
                        '2024-08-13 07:00:00', 'YYYY-MM-DD HH24:MI:SS'
                    ) and to_timestamp(
                        '2024-08-13 18:00:00', 'YYYY-MM-DD HH24:MI:SS'
                    )
            
            and device_token IN (
                select device_token
                from DEVICE_LIST
            )) S1 
        group by
            S1.ts
    ) Q1
group by
    Q1.ts,
    Q1.WETFLOOR,
    Q1.smelly,
    Q1.PLUMBING_ISSUES


--recreate query
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
    )
select
    ts AS UplinkTs,
    SUM(OUT_TISSUE + OUT_SOAP) AS OUT_OF_SUPPLY,
    WET_FLOOR,
    SMELLY,
    PLUMBING_ISSUES
from (
        select distinct
            ts, COUNT(REFRESH_TOILET) AS REFRESH_TOILET, COUNT(OUT_TISSUE) AS OUT_TISSUE, COUNT(BIN_FULL) AS BIN_FULL, COUNT(OUT_SOAP) AS OUT_SOAP, COUNT(BUSUK) AS SMELLY, COUNT(CLOGGED_TOILET) AS CLOGGED_TOILET, COUNT(URINAL_CLOG) AS URINAL_CLOG, COUNT(SLIPPERY) AS WET_FLOOR, COUNT(SANITARY_BIN_FULL) AS SANITARY_BIN_FULL, COUNT(PIPE_LEAK) AS PLUMBING_ISSUES
        FROM (
                select
                    CASE
                        WHEN BUTTON_ID = 1 THEN 1
                        ELSE 0
                    END AS REFRESH_TOILET, CASE
                        WHEN BUTTON_ID = 2 THEN 1
                        ELSE 0
                    END AS OUT_TISSUE, CASE
                        WHEN BUTTON_ID = 3 THEN 1
                        ELSE 0
                    END AS BIN_FULL, CASE
                        WHEN BUTTON_ID = 4 THEN 1
                        ELSE 0
                    END AS OUT_SOAP, CASE
                        WHEN BUTTON_ID = 5 THEN 1
                        ELSE 0
                    END AS BUSUK, CASE
                        WHEN BUTTON_ID = 6 THEN 1
                        ELSE 0
                    END AS CLOGGED_TOILET, CASE
                        WHEN BUTTON_ID = 7 THEN 1
                        ELSE 0
                    END AS URINAL_CLOG, CASE
                        WHEN BUTTON_ID = 8 THEN 1
                        ELSE 0
                    END AS SLIPPERY, CASE
                        WHEN BUTTON_ID = 9 THEN 1
                        ELSE 0
                    END AS SANITARY_BIN_FULL, CASE
                        WHEN BUTTON_ID = 10 THEN 1
                        ELSE 0
                    END AS PIPE_LEAK, date_trunc('Hour', timestamp) as ts
                from feedback_panel_data
                where (timestamp) between to_timestamp(
                        '2024-08-14 07:00:00', 'YYYY-MM-DD HH24:MI:SS'
                    ) and to_timestamp(
                        '2024-08-14 18:00:00', 'YYYY-MM-DD HH24:MI:SS'
                    )
                    and device_token IN (
                        select device_token
                        from DEVICE_LIST
                    )
            ) S1
        group by
            S1.ts
    ) Q1
group by
    Q1.ts,
    Q1.WET_FLOOR,
    Q1.smelly,
    Q1.PLUMBING_ISSUES



-- each complaint for every month for a year
-- graph complain yang salah
select distinct
    ts, COUNT(REFRESH_TOILET) AS REFRESH_TOILET, COUNT(OUT_TISSUE) AS OUT_TISSUE, COUNT(BIN_FULL) AS BIN_FULL, COUNT(OUT_SOAP) AS OUT_SOAP, COUNT(BUSUK) AS SMELLY, COUNT(CLOGGED_TOILET) AS CLOGGED_TOILET, COUNT(URINAL_CLOG) AS URINAL_CLOG, COUNT(SLIPPERY) AS WET_FLOOR, COUNT(SANITARY_BIN_FULL) AS SANITARY_BIN_FULL, COUNT(PIPE_LEAK) AS PLUMBING_ISSUES
FROM (
 select
    CASE
        WHEN BUTTON_ID = 1 THEN 1
        ELSE 0
    END AS REFRESH_TOILET,
    CASE
        WHEN BUTTON_ID = 2 THEN 1
        ELSE 0
    END AS OUT_TISSUE,
    CASE
        WHEN BUTTON_ID = 3 THEN 1
        ELSE 0
    END AS BIN_FULL,
    CASE
        WHEN BUTTON_ID = 4 THEN 1
        ELSE 0
    END AS OUT_SOAP,
    CASE
        WHEN BUTTON_ID = 5 THEN 1
        ELSE 0
    END AS BUSUK,
    CASE
        WHEN BUTTON_ID = 6 THEN 1
        ELSE 0
    END AS CLOGGED_TOILET,
    CASE
        WHEN BUTTON_ID = 7 THEN 1
        ELSE 0
    END AS URINAL_CLOG,
    CASE
        WHEN BUTTON_ID = 8 THEN 1
        ELSE 0
    END AS SLIPPERY,
    CASE
        WHEN BUTTON_ID = 9 THEN 1
        ELSE 0
    END AS SANITARY_BIN_FULL,
    CASE
        WHEN BUTTON_ID = 10 THEN 1
        ELSE 0
    END AS PIPE_LEAK,
    date_trunc('MONTH', timestamp) as ts
from feedback_panel_data
where (timestamp) between to_timestamp(
        '2024-01-01 07:00:00',
        'YYYY-MM-DD HH24:MI:SS'
    ) and to_timestamp(
        '2024-12-30 18:00:00',
        'YYYY-MM-DD HH24:MI:SS'
    )
) S1 group by S1.ts 


-- test
select distinct
    ts,
    -- SUM(OUT_TISSUE + OUT_SOAP) AS OUTOF_SUPPLY,
    COUNT(REFRESH_TOILET) AS REFRESH_TOILET,
    COUNT(OUT_TISSUE) AS OUT_TISSUE,
    COUNT(BIN_FULL) AS BIN_FULL,
    COUNT(OUT_SOAP) AS OUT_SOAP,
    COUNT(BUSUK) AS SMELLY,
    COUNT(CLOGGED_TOILET) AS CLOGGED_TOILET,
    COUNT(URINAL_CLOG) AS URINAL_CLOG,
    COUNT(SLIPPERY) AS WET_FLOOR,
    COUNT(SANITARY_BIN_FULL) AS SANITARY_BIN_FULL,
    COUNT(PIPE_LEAK) AS PLUMBING_ISSUES
FROM (
        select
            CASE
                WHEN BUTTON_ID = 1 THEN 1
                ELSE 0
            END AS REFRESH_TOILET, CASE
                WHEN BUTTON_ID = 2 THEN 1
                ELSE 0
            END AS OUT_TISSUE, CASE
                WHEN BUTTON_ID = 3 THEN 1
                ELSE 0
            END AS BIN_FULL, CASE
                WHEN BUTTON_ID = 4 THEN 1
                ELSE 0
            END AS OUT_SOAP, CASE
                WHEN BUTTON_ID = 5 THEN 1
                ELSE 0
            END AS BUSUK, CASE
                WHEN BUTTON_ID = 6 THEN 1
                ELSE 0
            END AS CLOGGED_TOILET, CASE
                WHEN BUTTON_ID = 7 THEN 1
                ELSE 0
            END AS URINAL_CLOG, CASE
                WHEN BUTTON_ID = 8 THEN 1
                ELSE 0
            END AS SLIPPERY, CASE
                WHEN BUTTON_ID = 9 THEN 1
                ELSE 0
            END AS SANITARY_BIN_FULL, CASE
                WHEN BUTTON_ID = 10 THEN 1
                ELSE 0
            END AS PIPE_LEAK, date_trunc('MONTH', timestamp) as ts
        from feedback_panel_data
        where (timestamp) between to_timestamp(
                '2024-01-01 07:00:00', 'YYYY-MM-DD HH24:MI:SS'
            ) and to_timestamp(
                '2024-12-30 18:00:00', 'YYYY-MM-DD HH24:MI:SS'
            )
    ) S1 group by S1.ts 


select sum(REFRESH_TOILET + OUT_TISSUE), Q1.ts from
(select
count(CASE
    WHEN BUTTON_ID = 1 THEN 1
    ELSE 0
END) AS REFRESH_TOILET,
count(
    CASE
        WHEN BUTTON_ID = 2 THEN 1
        ELSE 0
    END
) AS OUT_TISSUE,
date_trunc('MONTH', timestamp) as ts
from feedback_panel_data
where (timestamp) between to_timestamp(
    '2024-01-01 07:00:00',
    'YYYY-MM-DD HH24:MI:SS'
) and to_timestamp(
    '2024-12-30 18:00:00',
    'YYYY-MM-DD HH24:MI:SS'
)
group by ts)Q1
group by Q1.ts


select *
from feedback_panel_data
where (timestamp) between to_timestamp(
        '2024-08-14 07:00:00',
        'YYYY-MM-DD HH24:MI:SS'
    ) and to_timestamp(
        '2024-08-14 18:00:00',
        'YYYY-MM-DD HH24:MI:SS'
    )


select * from feedback_panel_data where (timestamp) between to_timestamp(
    '2024-08-14 07:00:00',
    'YYYY-MM-DD HH24:MI:SS'
) and to_timestamp(
    '2024-08-14 18:00:00',
    'YYYY-MM-DD HH24:MI:SS'
) and device_token = '108'


select * from feedback_panel_data where 

select fp_data_id, date_trunc('HOUR', timestamp)as ts  from feedback_panel_data

select count(fp_data_id)as total_complaint  from feedback_panel_data where device_token = '1'

select count(case when complaint = 0 then 0 else 1 end) as total_complaint, ts
from (
        select complaint, date_trunc('HOUR', timestamp) as ts
        from feedback_panel_data
        where
            device_token = '7' and
            timestamp between to_timestamp(
                '2024-10-01 23:00:00', 'YYYY-MM-DD HH24:MI:SS'
            ) and to_timestamp(
                '2024-10-02 09:00:00', 'YYYY-MM-DD HH24:MI:SS'
            )
    ) Q1
group by ts


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
    )
select count(fp_data_id) as total_complaints, ts as uplinkts from
(select fp_data_id, date_trunc('HOUR', timestamp) as ts from feedback_panel_data
where (timestamp) between to_timestamp(
        '2024-08-14 07:00:00',
        'YYYY-MM-DD HH24:MI:SS'
    ) and to_timestamp(
        '2024-08-14 18:00:00',
        'YYYY-MM-DD HH24:MI:SS'
    )
and device_token in (select distinct device_token from device_list ))Q1
group by ts


-- total feedback today
