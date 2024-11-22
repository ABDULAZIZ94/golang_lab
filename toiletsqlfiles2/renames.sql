

select * FROM public.TOILET_INFOS

UPDATE TOILET_INFOS SET toilet_name = 'MALE SMALL' WHERE toilet_index LIKE 'MALE_S%'


UPDATE TOILET_INFOS SET toilet_name = 'FEMALE BIG' WHERE toilet_index LIKE '%FEMALE_B%'

UPDATE TOILET_INFOS SET toilet_name = 'FEMALE' WHERE toilet_info_id IN (
    '3194cc8d-31f9-4441-504d-c45758ed9559',
    '25a25532-a743-4857-70f5-5e9dcb3b06ee', --fb
    '637f3112-8af8-48ec-7524-07720a810117', --fs
    '30935d4a-bcea-48e0-73c6-346f6c8dad6b',
    '7a48f840-db75-41f2-69a5-69339074f504',
    '9388096c-784d-49c8-784c-1868b1233165'
)

UPDATE TOILET_INFOS SET toilet_name = 'OKU' WHERE toilet_name LIKE '%OKU%'



select * from public.devices


UPDATE DEVICES SET device_name = 'GATEWAY' WHERE device_name LIKE '%GATEWAY%'

UPDATE DEVICES SET device_name = 'ENVIROMENT' WHERE device_name LIKE '%ENVIROMENT%'

UPDATE DEVICES SET device_name = 'WATERPUMP' WHERE device_name LIKE '%WATERPUMP%'

UPDATE DEVICES SET device_name = 'BLOWER' WHERE device_name LIKE '%BLOWER%'

UPDATE DEVICES SET device_name = 'WATERPUMP' WHERE device_name LIKE '%WATERPUMP%'

UPDATE DEVICES SET device_name = 'FAN' WHERE device_name LIKE '%FAN%'

UPDATE DEVICES SET device_name = 'FEEDBACK' WHERE device_name LIKE '%FEEDBACK%'

UPDATE DEVICES SET device_name = 'AMMONIA' WHERE device_name LIKE '%AMMONIA%'

UPDATE DEVICES SET device_name = 'BLOWER' WHERE device_name LIKE '%BLOWER%'

UPDATE DEVICES SET device_name = 'OCCUPANCY' WHERE device_name LIKE '%OCCUPANCY%'

UPDATE DEVICES SET device_name = 'COUNTER' WHERE device_name LIKE '%COUNTER%'

UPDATE DEVICES SET device_name = 'FRESHENER' WHERE device_name LIKE '%FRESHENER%'

UPDATE DEVICES SET device_name = 'FRAGRANCE' WHERE device_name LIKE '%FRAGRANCE%'

UPDATE DEVICES SET device_name = 'SMOKE' WHERE device_name LIKE '%SMOKE%'

UPDATE DEVICES SET device_name = 'ENVIROMENT' WHERE device_name LIKE '%ENVIROMENT%'




-- delete device pairs
select * from public.devices where device_token in ('15','16')


select * from public.device_pairs where device_id in (
    '2051d7e5-1ecd-48bf-43a4-9e506c54dcc1',
    'a54306dc-ed36-4be8-50b5-ff02c319b461'
)