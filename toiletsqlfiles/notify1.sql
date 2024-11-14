SELECT "all_access", "get_notify" FROM "users"  WHERE (user_id = '28bab937-50a1-4a4b-6480-02451465ff17')



-- notification data
select * from notification_data 
where device_token 
= '10003'
-- in ('4050', '230', '108', '318', '319', '73','615','4051','231','109', '320','321','616','4052','232','110','322','617','10001','10002','10003')
order by timestamp desc 
-- limit 100

-- feedback panel tak masuk ke notify

-- current query
SELECT NOTIFICATION_DATA.NOTIFY_ID, TIMESTAMP, NOTIFICATION_DATA.FREQUENCY, 
-- NOTIFICATION_DATA.TOILET_TYPE_ID, 
-- FEEDBACK_PANELS.button_name as task_name,
message,
 to_char(TIMESTAMP, 'YYYY-MM-DD') AS DATE, to_char(TIMESTAMP, 'HH24:MI:SS') AS TIME
FROM
    "notification_data"
    -- JOIN FEEDBACK_PANELS ON FEEDBACK_PANELS.BUTTON_ID = NOTIFICATION_DATA.BUTTON_ID
    JOIN DEVICES ON DEVICES.DEVICE_TOKEN = NOTIFICATION_DATA.DEVICE_TOKEN
    -- JOIN TOILET_TYPES ON TOILET_TYPES.TOILET_TYPE_ID = NOTIFICATION_DATA.TOILET_TYPE_ID
WHERE (
        NOTIFICATION_DATA.ACTION_STATUS = '0'
        AND NOTIFICATION_DATA.DEVICE_TOKEN = '617'
    )
ORDER BY NOTIFICATION_DATA.TIMESTAMP desc


-- feedback panel type
--
SELECT *
FROM public.locations
-- WHERE
--     location_id = '2a83bc9b-0dba-451e-7760-a29bfc3db337'



-- complain smelly toilet
vt_commmand: %v, %v FRESHENER~ON 379456c3-9b7e-4bb4-7c92-8212fa6ed997
vt_commmand: %v, %v EXHAUST_FAN~ON 379456c3-9b7e-4bb4-7c92-8212fa6ed997


-- complaint slippery toilet
vt_commmand: %v, %v AIR_BLOWER~ON 379456c3-9b7e-4bb4-7c92-8212fa6ed997 -- blower mamang tiada di local db.
