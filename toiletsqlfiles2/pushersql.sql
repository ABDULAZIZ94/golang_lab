SELECT CLEANER_ID  
FROM CLEANER_AND_TENANTS  
WHERE TENANT_ID = (SELECT TENANT_ID FROM DEVICES  
    WHERE DEVICE_TOKEN = '27')

SELECT button_name FROM feedback_panels WHERE button_id = 12