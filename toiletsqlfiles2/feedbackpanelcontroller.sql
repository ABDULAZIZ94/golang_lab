SELECT cleaner_rfids.*
FROM cleaner_rfids
WHERE rfid_number = '01175B1C0859'

SELECT * from users

UPDATE cleaner_rfids
SET last_action = 'checkin', last_seen = '2024-05-01'
WHERE rfid_number = '01175B1C0859'

-- first query get user reaction count
SELECT COUNT(reaction), reactions.react_name
FROM user_reactions
JOIN reactions ON reactions.react_id = user_reactions.reaction
JOIN toilet_infos on toilet_infos.toilet_info_id = user_reactions.toilet_id
JOIN locations on locations.location_id = toilet_infos.location_id
WHERE user_reactions.timestamp::DATE AT TIME ZONE 'ASIA/KUALA_LUMPUR' = NOW()::DATE AT TIME ZONE 'ASIA/KUALA_LUMPUR'
AND locations.location_id = '98998a6b-4be1-4ff4-5dd1-8a8e914943ee'
GROUP BY reactions.react_name

SELECT COUNT(reaction), reactions.react_name
FROM user_reactions
JOIN reactions ON reactions.react_id = user_reactions.reaction
JOIN toilet_infos on toilet_infos.toilet_info_id = user_reactions.toilet_id
JOIN locations on locations.location_id = toilet_infos.location_id
-- WHERE user_reactions.timestamp::DATE AT TIME ZONE 'ASIA/KUALA_LUMPUR' = NOW()::DATE AT TIME ZONE 'ASIA/KUALA_LUMPUR'
-- AND locations.location_id = '98998a6b-4be1-4ff4-5dd1-8a8e914943ee'
GROUP BY reactions.react_name

-- query 2 most complain
SELECT COUNT(complaint) AS CC, complaints.complaint_name as common_complaints
FROM user_reactions
JOIN complaints ON complaints.complaint_id = user_reactions.complaint
JOIN reactions ON reactions.react_id = user_reactions.reaction
JOIN toilet_infos on toilet_infos.toilet_info_id = user_reactions.toilet_id
JOIN locations on locations.location_id = toilet_infos.location_id
-- WHERE user_reactions.timestamp::DATE AT TIME ZONE 'ASIA/KUALA_LUMPUR' = NOW()::DATE AT TIME ZONE 'ASIA/KUALA_LUMPUR'
-- AND locations.location_id = '57fd94bb-d029-4aa7-7d77-ea8b3f19a330'
GROUP BY complaints.complaint_name
ORDER BY CC DESC
LIMIT 1

-- how many clean duration
SELECT COUNT(cleaner_report_id) as times_cleaned, SUM(duration) as clean_duration
FROM cleaner_reports
WHERE cleaner_user_id = '7a1c3658-d58b-46ca-6935-6a0835477b69'
-- AND cleaner_reports.created_at::DATE AT TIME ZONE 'ASIA/KUALA_LUMPUR' = NOW()::DATE AT TIME ZONE 'ASIA/KUALA_LUMPUR'
-- AND location_id = '98998a6b-4be1-4ff4-5dd1-8a8e914943ee'
-- GROUP BY NOW()::DATE

-- how many clean duration
SELECT COUNT(cleaner_report_id) as times_cleaned, SUM(duration) as clean_duration
FROM cleaner_reports
WHERE cleaner_user_id = '7a1c3658-d58b-46ca-6935-6a0835477b69'
AND cleaner_reports.created_at::DATE AT TIME ZONE 'ASIA/KUALA_LUMPUR' = NOW()::DATE AT TIME ZONE 'ASIA/KUALA_LUMPUR'
AND location_id = '98998a6b-4be1-4ff4-5dd1-8a8e914943ee'
GROUP BY NOW()::DATE

-- how many clean duration
SELECT COUNT(cleaner_report_id) as times_cleaned, SUM(duration) as clean_duration
FROM cleaner_reports
WHERE cleaner_user_id = '73787930-ad1f-4f11-5b12-39d6b82ef9bc'
-- AND cleaner_reports.created_at::DATE AT TIME ZONE 'ASIA/KUALA_LUMPUR' = NOW()::DATE AT TIME ZONE 'ASIA/KUALA_LUMPUR'
-- AND location_id = '98998a6b-4be1-4ff4-5dd1-8a8e914943ee'
-- GROUP BY NOW()::DATE

DELETE FROM notification_data
WHERE EXISTS (
    SELECT 1
    FROM devices
    JOIN locations ON locations.tenant_id = devices.tenant_id
    WHERE 
        devices.device_token = notification_data.device_token
        AND locations.location_id = '98998a6b-4be1-4ff4-5dd1-8a8e914943ee'
) AND namespace = 'FP_COMPLAINT' 
    AND "timestamp" <= '2024-06-12'