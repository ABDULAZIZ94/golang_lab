

SELECT * FROM public.user_reactions
ORDER BY timestamp DESC 

select * from reactions

select * from complaints

select ur.timestamp,  r.react_name, co.complaint_name
from user_reactions ur
join reactions r on ur.reaction_id = r.react_id
join complaints co on ur.complaint = co.complaint_id
