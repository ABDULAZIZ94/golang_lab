SELECT devices.*,device_type_name FROM DEVICES 
JOIN device_types on device_types.device_type_id = devices.device_type_id 
WHERE 1=1
-- DEVICE_ID

--check if device available / has record in devices table
SELECT device_token
FROM devices
where device_token = '13'

select * from devices

select * from device_pairs

select * from device_types

