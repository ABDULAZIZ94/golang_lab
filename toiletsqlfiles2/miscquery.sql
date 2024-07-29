SELECT DISTINCT namespace,
                count(misc_data_id)
FROM public.misc_action_data
group by namespace