

SELECT DISTINCT namespace,
                count(misc_data_id)
FROM public.misc_action_data
group by namespace

select * from misc_action_data order by timestamp desc