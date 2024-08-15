

SELECT * FROM public.user_reactions
ORDER BY timestamp DESC 

select * from reactions

select * from complaints

select ur.reaction_id, ur.timestamp,  r.react_name, co.complaint_name
from user_reactions ur
join reactions r on ur.reaction = r.react_id
join complaints co on ur.complaint = co.complaint_id


select ur.reaction_id, ur.timestamp
from user_reactions ur
join 

SELECT * FROM public.user_reactions where reaction ='1' ORDER BY timestamp DESC

select count(reaction_id) as totalcomplaint from user_reactions where complaint IS NOT NULL 

select count(case when complaint = '1' then 1 end) as happy,
count(case when complaint = '2' then 1 end) as satisfied,
count(case when complaint = '3' then 1 end) as notsatisfied,
count(case when complaint = '4' then 1 end) as nothappy
from user_reactions
where
    complaint IS NOT NULL

-- test query
select sum(happy+satisfied+notsatisfied+nothappy) as total_reactions, happy, satisfied, notsatisfied,nothappy from
(select count(case when complaint = '1' then 1 end) as happy,
count(case when complaint = '2' then 1 end) as satisfied,
count(case when complaint = '3' then 1 end) as notsatisfied,
count(case when complaint = '4' then 1 end) as nothappy
from user_reactions)Q1
group by Q1.happy, Q1.satisfied, Q1.notsatisfied, Q1.nothappy 

TO_TIMESTAMP('2024-08-14 18:00:00','YYYY-MM-DD HH24:MI:SS')

-- user reactions
select sum(happy+satisfied+notsatisfied+nothappy) as total_reactions, happy, satisfied, notsatisfied,nothappy from
(select count(case when reaction = '1' then 1 end) as happy,
count(case when reaction = '2' then 1 end) as satisfied,
count(case when reaction = '3' then 1 end) as notsatisfied,
count(case when reaction = '4' then 1 end) as nothappy
from user_reactions where timestamp between TO_TIMESTAMP( '2024-08-14 07:00:00', 'YYYY-MM-DD HH24:MI:SS' ) and 
TO_TIMESTAMP( '2024-08-14 18:00:00', 'YYYY-MM-DD HH24:MI:SS' ) and toilet_id in ('36f74ec4-cdb0-4271-6c2d-2baa48d6e583',
'9388096c-784d-49c8-784c-1868b1233165','a97891e5-14df-4f95-7d1e-4ee601581df2'))Q1
group by Q1.happy, Q1.satisfied, Q1.notsatisfied, Q1.nothappy 

-- user complaints
select sum(SMELLY_TOILET+OUTOF_SUPPLY+WET_FLOOR+PLUMBING_ISSUES) as TOTAL, SMELLY_TOILET, OUTOF_SUPPLY, WET_FLOOR, PLUMBING_ISSUES from
(select count(case when complaint = '1' then 1 end) as SMELLY_TOILET,
count(case when complaint = '2' then 1 end) as OUTOF_SUPPLY,
count(case when complaint = '3' then 1 end) as WET_FLOOR,
count(case when complaint = '4' then 1 end) as PLUMBING_ISSUES
from user_reactions where timestamp between TO_TIMESTAMP( '2024-08-14 07:00:00', 'YYYY-MM-DD HH24:MI:SS' ) and 
TO_TIMESTAMP( '2024-08-14 18:00:00', 'YYYY-MM-DD HH24:MI:SS' ) and toilet_id in ('36f74ec4-cdb0-4271-6c2d-2baa48d6e583',
'9388096c-784d-49c8-784c-1868b1233165','a97891e5-14df-4f95-7d1e-4ee601581df2'))Q1
group by Q1.SMELLY_TOILET, Q1.OUTOF_SUPPLY, Q1.WET_FLOOR, Q1.PLUMBING_ISSUES 




-- user reactions X months for a year

select count(case when complaint = '1' then 1 end) as SMELLY_TOILET,
count(case when complaint = '2' then 1 end) as OUTOF_SUPPLY,
count(case when complaint = '3' then 1 end) as WET_FLOOR,
count(case when complaint = '4' then 1 end) as PLUMBING_ISSUES,
date_trunc('MONTH', timestamp) as ts
from user_reactions
where (timestamp) between to_timestamp('2024-01-01 07:00:00','YYYY-MM-DD HH24:MI:SS') 
and to_timestamp('2024-12-30 18:00:00','YYYY-MM-DD HH24:MI:SS') and toilet_id = '36f74ec4-cdb0-4271-6c2d-2baa48d6e583'
group by ts


select count(case when complaint = '1' then 1 end) as SMELLY_TOILET,
count(case when complaint = '2' then 1 end) as OUTOF_SUPPLY,
count(case when complaint = '3' then 1 end) as WET_FLOOR,
count(case when complaint = '4' then 1 end) as PLUMBING_ISSUES,
date_trunc('MONTH', timestamp) as ts
from user_reactions
where (timestamp) between to_timestamp('2024-01-01 07:00:00','YYYY-MM-DD HH24:MI:SS') 
and to_timestamp('2024-12-30 18:00:00','YYYY-MM-DD HH24:MI:SS') and toilet_id IN ('36f74ec4-cdb0-4271-6c2d-2baa48d6e583')
group by ts


-- user complaints graph
select count(reaction_id) as TOTAL_COMPLAINT, date_trunc('HOUR',timestamp) as uplinkts from user_reactions 
where EXTRACT(HOUR FROM timestamp) >= 7 AND EXTRACT(HOUR FROM timestamp) <= 18 and
(timestamp) between to_timestamp('2024-08-01 07:00:00','YYYY-MM-DD HH24:MI:SS') 
and to_timestamp('2024-08-30 18:00:00','YYYY-MM-DD HH24:MI:SS') and 
toilet_id IN ('36f74ec4-cdb0-4271-6c2d-2baa48d6e583') group by ts