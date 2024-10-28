-- total complaint

WITH
    TOILET_LIST AS (
        SELECT ti.toilet_info_id
        FROM toilet_infos ti
        WHERE
            location_id = '9945f766-738f-4de4-5b51-ac878029af56'
    )
select
    sum(
        SMELLY_TOILET + OUTOF_SUPPLY + WET_FLOOR + PLUMBING_ISSUES
    ) as TOTAL,
    SMELLY_TOILET,
    OUTOF_SUPPLY,
    WET_FLOOR,
    PLUMBING_ISSUES
from (
        select
            count(
                case
                    when complaint = '1' then 1
                end
            ) as SMELLY_TOILET, count(
                case
                    when complaint = '2' then 1
                end
            ) as OUTOF_SUPPLY, count(
                case
                    when complaint = '3' then 1
                end
            ) as WET_FLOOR, count(
                case
                    when complaint = '4' then 1
                end
            ) as PLUMBING_ISSUES
        from user_reactions
        where
            timestamp between TO_TIMESTAMP(
                '2024-10-27 23:00:00', 'YYYY-MM-DD HH24:MI:SS'
            ) and TO_TIMESTAMP(
                '2024-10-28 11:00:00', 'YYYY-MM-DD HH24:MI:SS'
            )
            and toilet_id in (
                select toilet_info_id
                from toilet_list
            )
    ) Q1
group by
    Q1.SMELLY_TOILET,
    Q1.OUTOF_SUPPLY,
    Q1.WET_FLOOR,
    Q1.PLUMBING_ISSUES



-- total complaint count graph
WITH
    GENTIME as (
        SELECT uplinkTS
        FROM generate_series(
                date_trunc(
                    'HOUR', TO_TIMESTAMP(
                        '2024-10-27 23:00:00', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), date_trunc(
                    'HOUR', TO_TIMESTAMP(
                        '2024-10-28 11:00:00', 'YYYY-MM-DD HH24:MI:SS'
                    )
                ), interval '1 HOUR'
            ) uplinkTS
        where (
                (
                    uplinkTS::time >= '23:00:00'
                    AND uplinkTS::time <= '23:59:59'
                )
                OR (
                    uplinkTS::time >= '00:00:00'
                    AND uplinkTS::time <= '16:00:00'
                )
            )
    ),
    TOILET_LIST AS (
        SELECT ti.toilet_info_id
        FROM toilet_infos ti
        WHERE
            location_id = '9945f766-738f-4de4-5b51-ac878029af56'
    )
select TOTAL_COMPLAINT, uplinkts
from gentime
    left join (
        select count(case when complaint = '1' or complaint = '2' or complaint = '3' or complaint = '4' then 1 end ) 
        as TOTAL_COMPLAINT, date_trunc('HOUR', timestamp) as uplinkts
        from user_reactions
        where 
            (
                timestamp::time >= '23:00:00'
                OR (
                    timestamp::time >= '00:00:00'
                    AND timestamp::time <= '11:00:00'
                )
            )
            and (timestamp) between to_timestamp(
                '2024-10-27 23:00:00', 'YYYY-MM-DD HH24:MI:SS'
            ) and to_timestamp(
                '2024-10-28 11:00:00', 'YYYY-MM-DD HH24:MI:SS'
            )
            and toilet_id IN (
                select toilet_info_id
                from toilet_list
            )
        group by
            uplinkts
    ) Q1 using (uplinkts)
order by uplinkts