
select * from user_reactions limit 10


-- last 5/8/2024
select * from user_reactions 
where complaint = '1'
order by timestamp desc limit 10

delete from user_reactions where timestamp > now()