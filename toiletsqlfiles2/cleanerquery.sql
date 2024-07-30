
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