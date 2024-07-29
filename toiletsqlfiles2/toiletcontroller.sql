SELECT device_pairs.*,devices.device_id ,devices.device_name , devices.device_token,device_types.device_type_name 
as device_type,device_types.device_type_id
FROM device_pairs
JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID
JOIN device_types ON device_types.device_type_id = devices.device_type_id
-- Where device_pairs.toilet_info_id = ''
Where 1=1

