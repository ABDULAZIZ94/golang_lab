
select * from cleaner_reports

SELECT * FROM public.cleaner_reports
join users on cleaner_user_id = users.user_id
	where cleaner_reports.created_at >= TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')
ORDER BY cleaner_reports.created_at DESC LIMIT 100

-- total cleaner check in fot this month
select distinct cleaner_user_id, count (cleaner_user_id)
from
( SELECT * FROM public.cleaner_reports
join users on cleaner_user_id = users.user_id
	where cleaner_reports.created_at >= TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')
ORDER BY cleaner_reports.created_at DESC LIMIT 100 ) Q1
group by cleaner_user_id


-- total cleaner check in fot this month
select distinct cleaner_user_id, count (cleaner_user_id)
from
( SELECT * FROM public.cleaner_reports
    join users on cleaner_user_id = users.user_id
    where cleaner_reports.created_at between TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')
        and TO_TIMESTAMP('2024-07-30', 'YYYY-MM-DD HH24:MI:SS')
ORDER BY cleaner_reports.created_at DESC LIMIT 100 ) Q1
group by cleaner_user_id

-- total cleaner check in this month with its locations
-- total cleaner check in fot this month
select distinct cleaner_user_id, count (cleaner_user_id), Q1.location_name
from
( SELECT * FROM public.cleaner_reports
    join users on cleaner_user_id = users.user_id
    join locations on cleaner_reports.location_id = locations.location_id
    where cleaner_reports.created_at between TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')
        and TO_TIMESTAMP('2024-07-30', 'YYYY-MM-DD HH24:MI:SS')
ORDER BY cleaner_reports.created_at DESC LIMIT 100 ) Q1
group by cleaner_user_id, Q1.location_name

-- test query
select cleaner_report_id, ti.toilet_info_id
from cleaner_reports cr
join locations loc on cr.location_id = loc.location_id
join toilet_infos ti on ti.location_id = loc.location_id


select * from cleaner_reports

-- test query
select cleaner_report_id, ti.toilet_info_id
from cleaner_reports cr
join locations loc on cr.location_id = loc.location_id
join toilet_infos ti on ti.location_id = loc.location_id
where ti.toilet_info_id = ? and cerated_at between ()

-- test query
select sum(TOTAL_MALE + TOTAL_FEMALE) as FREQUENCY, uplinkTS from
(SELECT date_trunc('HOUR', CHECK_IN_TS) AS uplinkTS, 
COUNT(CASE WHEN cr.TOILET_TYPE_ID = 1 THEN 1 END) TOTAL_MALE, 
COUNT(CASE WHEN cr.TOILET_TYPE_ID = 2 THEN 1 END) TOTAL_FEMALE 
from cleaner_reports cr
join locations loc on cr.location_id = loc.location_id
join toilet_infos ti on ti.location_id = loc.location_id
where ti.toilet_info_id = '36f74ec4-cdb0-4271-6c2d-2baa48d6e583' and cr.created_at between 
TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS') and TO_TIMESTAMP('2024-07-30', 'YYYY-MM-DD HH24:MI:SS')
GROUP BY uplinkTS)Q1 GROUP BY uplinkTS


-- cleaner freq bagi male female
SELECT date_trunc('HOUR', CHECK_IN_TS) AS uplinkTS, 
COUNT(CASE WHEN cr.TOILET_TYPE_ID = 1 THEN 1 END) TOTAL_MALE, 
COUNT(CASE WHEN cr.TOILET_TYPE_ID = 2 THEN 1 END) TOTAL_FEMALE 
from cleaner_reports cr
join locations loc on cr.location_id = loc.location_id
join toilet_infos ti on ti.location_id = loc.location_id
where ti.toilet_info_id = '36f74ec4-cdb0-4271-6c2d-2baa48d6e583' and cr.created_at between 
TO_TIMESTAMP('2024-07-01 07:00:00', 'YYYY-MM-DD HH24:MI:SS') and TO_TIMESTAMP('2024-07-30 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
GROUP BY uplinkTS

-- cleaner response
SELECT date_trunc('HOUR', CHECK_IN_TS) AS uplinkTS, 
AVG(CASE WHEN cr.TOILET_TYPE_ID = 1 THEN duration END) TOTAL_TIME_MALE, 
AVG(CASE WHEN cr.TOILET_TYPE_ID = 2 THEN duration END) TOTAL_TIME_FEMALE, 
AVG(DURATION) TOTAL_TIME 
FROM CLEANER_REPORTS  cr
join locations loc on cr.location_id = loc.location_id
join toilet_infos ti on ti.location_id = loc.location_id
where ti.toilet_info_id = '36f74ec4-cdb0-4271-6c2d-2baa48d6e583' and cr.created_at between 
TO_TIMESTAMP('2024-07-01 07:00:00', 'YYYY-MM-DD HH24:MI:SS') and TO_TIMESTAMP('2024-07-30 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
GROUP BY uplinkTS

select * from cleaner_reports

-- toilet autoclean status
SELECT CASE WHEN cr.auto_clean_state = '1' THEN true else false end as AUTO_CLEAN_STATUS
FROM CLEANER_REPORTS  cr
join device_cubical_pairs dcp on cr.cubical_id = dcp.cubical_id 
where EXTRACT(HOUR FROM cr.created_at) >= 7 AND EXTRACT(HOUR FROM cr.created_at) <= 18 and dcp.device_id ='3c64d02c-abfb-4b57-5dfe-116d163ecee3' and
cr.created_at between TO_TIMESTAMP('2024-07-01 07:00:00', 'YYYY-MM-DD HH24:MI:SS') and TO_TIMESTAMP('2024-09-30 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
order by cr.created_at limit 1



SELECT
    CASE
        WHEN cr.cleaner_report_id IS NOT NULL THEN true
        WHEN cr.cleaner_report_id = '' THEN false
        ELSE false -- Covers the case where cleaner_report_id is neither NULL nor an empty string
    END as AUTO_CLEAN_STATUS
FROM CLEANER_REPORTS cr
WHERE
    cr.cubical_id = '3c64d02c-abfb-4b57-5dfe-116d163ecee3'
    AND cr.created_at BETWEEN TO_TIMESTAMP(
        '2024-07-01 07:00:00',
        'YYYY-MM-DD HH24:MI:SS'
    ) AND TO_TIMESTAMP(
        '2024-07-30 18:00:00',
        'YYYY-MM-DD HH24:MI:SS'
    )
    AND cr.auto_clean_state = '1'
ORDER BY cr.created_at
LIMIT 1;