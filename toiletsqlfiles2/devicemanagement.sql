SELECT devices.*,device_type_name FROM DEVICES 
JOIN device_types on device_types.device_type_id = devices.device_type_id 
WHERE 1=1
-- DEVICE_ID

--check if device available / has record in devices table
SELECT device_token
FROM devices
where device_token = '13'

select * from public.devices

select * from device_pairs

select * from device_types

alter table devices add primary key (device_id)


select * from devices Where device_token = 'KEMAMAN_GATEWAY_01' AND device_type_id = 1

select * from public.devices where device_id='0e94682a-9647-4e8a-7df4-ca20e0069405'


-- yang pair gateway kemaman -- 0e94682a-9647-4e8a-7df4-ca20e0069405 
select * from device_pairs where gateway_id  = '0e94682a-9647-4e8a-7df4-ca20e0069405'