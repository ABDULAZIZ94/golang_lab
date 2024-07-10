SELECT * FROM devices Where device_token = 'GATEWAY002'  AND device_type_id = 1;

SELECT * FROM devices;

Select * FROM setting_values
JOIN DEVICES ON DEVICES.TENANT_ID = SETTING_VALUES.ENTITY_ID
Where DEVICES.DEVICE_TOKEN = 'GATEWAY002';

