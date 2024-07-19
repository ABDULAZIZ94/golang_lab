SELECT devices.*,device_type_name FROM DEVICES 
JOIN device_types on device_types.device_type_id = devices.device_type_id 
WHERE 1=1
-- DEVICE_ID

--check device available
SELECT device_token
FROM devices
where device_token = '13'

