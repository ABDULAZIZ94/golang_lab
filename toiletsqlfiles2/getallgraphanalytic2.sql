(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1739) 

[2024-07-29 08:07:55]  [3.53ms]   SELECT DEVICES.DEVICE_NAME,DEVICES.DEVICE_ID,DEVICES.DEVICE_TOKEN, TOILET_INFOS.TOILET_NAME AS Identifier ,DEVICE_TYPES.DEVICE_TYPE_NAME as Namespace, DEVICE_TYPES.DEVICE_TYPE_ID AS NAMESPACE_ID , TOILET_INFOS.TOILET_TYPE_ID FROM DEVICE_PAIRS JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID = DEVICES.DEVICE_TYPE_ID JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID WHERE TOILET_INFOS.TOILET_INFO_ID = '5654c008-dbcc-4656-5601-0a0c50652213'   
[10 rows affected or returned ] 
2024/07/29 08:07:55 HERE  7 DAY


(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1888) 

[2024-07-29 08:07:56]  [22.07ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS)  SELECT uplinkTS::text,COALESCE(BIN_FULL, '0')::text AS BIN_FULL, COALESCE(BUSUK, '0')::text AS BUSUK, COALESCE(URINAL_CLOG, '0')::text AS URINAL_CLOG, COALESCE(SANITARY_BIN_FULL, '0')::text AS SANITARY_BIN_FULL, COALESCE(PIPE_LEAK, '0')::text AS PIPE_LEAK, COALESCE(SLIPPERY, '0')::text AS SLIPPERY, COALESCE(OUT_TISSUE, '0')::text AS OUT_TISSUE, COALESCE(REFRESH_TOILET, '0')::text AS REFRESH_TOILET, COALESCE(OUT_SOAP, '0')::text AS OUT_SOAP, COALESCE(CLOGGED_TOILET, '0')::text AS CLOGGED_TOILET FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN BUTTON_ID = 1 THEN 1 END) AS REFRESH_TOILET, COUNT(CASE WHEN BUTTON_ID = 2 THEN 1 END) AS OUT_TISSUE, COUNT(CASE WHEN BUTTON_ID = 3 THEN 1 END) AS BIN_FULL, COUNT(CASE WHEN BUTTON_ID = 4 THEN 1 END) AS OUT_SOAP, COUNT(CASE WHEN BUTTON_ID = 5 THEN 1  END) AS BUSUK, COUNT(CASE WHEN BUTTON_ID = 6 THEN 1 END) AS CLOGGED_TOILET, COUNT(CASE WHEN BUTTON_ID = 7 THEN 1 END) AS URINAL_CLOG, COUNT(CASE WHEN BUTTON_ID = 8 THEN 1 END) AS SLIPPERY, COUNT(CASE WHEN BUTTON_ID = 9 THEN 1 END) AS SANITARY_BIN_FULL, COUNT(CASE WHEN BUTTON_ID = 10 THEN 1 END) AS PIPE_LEAK FROM feedback_panel_data WHERE feedback_panel_data.TOILET_TYPE_ID = 1 AND feedback_panel_data.DEVICE_TOKEN = '4' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 


(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1943) 

[2024-07-29 08:07:56]  [3.91ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS)  SELECT uplinkTS::text,COALESCE(TOTAL_MALE,0) AS TOTAL_MALE, COALESCE(TOTAL_FEMALE,0) AS TOTAL_FEMALE FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', CHECK_IN_TS) AS uplinkTS, COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 1 THEN 1 END) TOTAL_MALE, COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 2 THEN 1 END) TOTAL_FEMALE FROM CLEANER_REPORTS WHERE CLEANER_REPORTS.LOCATION_ID = ( SELECT location_id from toilet_infos where toilet_info_id = '5654c008-dbcc-4656-5601-0a0c50652213') GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC   
[4 rows affected or returned ] 


(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1981) 

[2024-07-29 08:07:56]  [7.54ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS) SELECT uplinkTS::text, COALESCE(smelly_toilet, 0) AS smelly_toilet, COALESCE(out_of_supplies, 0) AS out_of_supplies, COALESCE(wet_floor, 0) AS wet_floor, COALESCE(plumbing_issues, 0) AS plumbing_issues FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN ur.complaint = '1' THEN 1 END) AS smelly_toilet, COUNT(CASE WHEN ur.complaint = '2' THEN 1 END) AS out_of_supplies, COUNT(CASE WHEN ur.complaint = '3' THEN 1 END) AS wet_floor, COUNT(CASE WHEN ur.complaint = '4' THEN 1 END) AS plumbing_issues FROM user_reactions ur LEFT JOIN complaints c ON c.complaint_id = ur.complaint WHERE toilet_id = '5654c008-dbcc-4656-5601-0a0c50652213' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 


(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:2018) 

[2024-07-29 08:07:56]  [2.77ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS) SELECT uplinkTS::text, COALESCE(happy, 0) AS happy, COALESCE(satisfied, 0) AS satisfied, COALESCE(not_satisfied, 0) AS not_satisfied, COALESCE(not_happy, 0) AS not_happy FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN ur.reaction = '1' THEN 1 END) AS happy, COUNT(CASE WHEN ur.reaction = '2' THEN 1 END) AS satisfied, COUNT(CASE WHEN ur.reaction = '3' THEN 1 END) AS not_satisfied, COUNT(CASE WHEN ur.reaction = '4' THEN 1 END) AS not_happy FROM user_reactions ur WHERE toilet_id = '5654c008-dbcc-4656-5601-0a0c50652213' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 


(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1838) 

[2024-07-29 08:07:57]  [1291.18ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS)  SELECT uplinkTS::text,COALESCE(lux, '0')::text AS lux, COALESCE(humidity, '0')::text AS humidity, COALESCE(temperature, '0')::text AS temperature, COALESCE(iaq, '0')::text AS iaq FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, AVG(lux::decimal) as lux,AVG(humidity::decimal) as humidity, AVG(temperature::decimal) as temperature,AVG(iaq::decimal) as iaq FROM enviroment_data WHERE device_token = '28' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 
s

(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1943) 

[2024-07-29 08:07:57]  [7.65ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS)  SELECT uplinkTS::text,COALESCE(TOTAL_MALE,0) AS TOTAL_MALE, COALESCE(TOTAL_FEMALE,0) AS TOTAL_FEMALE FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', CHECK_IN_TS) AS uplinkTS, COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 1 THEN 1 END) TOTAL_MALE, COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 2 THEN 1 END) TOTAL_FEMALE FROM CLEANER_REPORTS WHERE CLEANER_REPORTS.LOCATION_ID = ( SELECT location_id from toilet_infos where toilet_info_id = '5654c008-dbcc-4656-5601-0a0c50652213') GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC   
[4 rows affected or returned ] 


(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1981) 

[2024-07-29 08:07:57]  [2.20ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS) SELECT uplinkTS::text, COALESCE(smelly_toilet, 0) AS smelly_toilet, COALESCE(out_of_supplies, 0) AS out_of_supplies, COALESCE(wet_floor, 0) AS wet_floor, COALESCE(plumbing_issues, 0) AS plumbing_issues FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN ur.complaint = '1' THEN 1 END) AS smelly_toilet, COUNT(CASE WHEN ur.complaint = '2' THEN 1 END) AS out_of_supplies, COUNT(CASE WHEN ur.complaint = '3' THEN 1 END) AS wet_floor, COUNT(CASE WHEN ur.complaint = '4' THEN 1 END) AS plumbing_issues FROM user_reactions ur LEFT JOIN complaints c ON c.complaint_id = ur.complaint WHERE toilet_id = '5654c008-dbcc-4656-5601-0a0c50652213' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 


(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:2018) 

[2024-07-29 08:07:57]  [3.77ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS) SELECT uplinkTS::text, COALESCE(happy, 0) AS happy, COALESCE(satisfied, 0) AS satisfied, COALESCE(not_satisfied, 0) AS not_satisfied, COALESCE(not_happy, 0) AS not_happy FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN ur.reaction = '1' THEN 1 END) AS happy, COUNT(CASE WHEN ur.reaction = '2' THEN 1 END) AS satisfied, COUNT(CASE WHEN ur.reaction = '3' THEN 1 END) AS not_satisfied, COUNT(CASE WHEN ur.reaction = '4' THEN 1 END) AS not_happy FROM user_reactions ur WHERE toilet_id = '5654c008-dbcc-4656-5601-0a0c50652213' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 


(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1943) 
[2024-07-29 08:07:57]  [2.14ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS)  SELECT uplinkTS::text,COALESCE(TOTAL_MALE,0) AS TOTAL_MALE, COALESCE(TOTAL_FEMALE,0) AS TOTAL_FEMALE FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', CHECK_IN_TS) AS uplinkTS, COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 1 THEN 1 END) TOTAL_MALE, COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 2 THEN 1 END) TOTAL_FEMALE FROM CLEANER_REPORTS WHERE CLEANER_REPORTS.LOCATION_ID = ( SELECT location_id from toilet_infos where toilet_info_id = '5654c008-dbcc-4656-5601-0a0c50652213') GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC   
[4 rows affected or returned ] 


(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1981) 

[2024-07-29 08:07:57]  [7.65ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS) SELECT uplinkTS::text, COALESCE(smelly_toilet, 0) AS smelly_toilet, COALESCE(out_of_supplies, 0) AS out_of_supplies, COALESCE(wet_floor, 0) AS wet_floor, COALESCE(plumbing_issues, 0) AS plumbing_issues FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN ur.complaint = '1' THEN 1 END) AS smelly_toilet, COUNT(CASE WHEN ur.complaint = '2' THEN 1 END) AS out_of_supplies, COUNT(CASE WHEN ur.complaint = '3' THEN 1 END) AS wet_floor, COUNT(CASE WHEN ur.complaint = '4' THEN 1 END) AS plumbing_issues FROM user_reactions ur LEFT JOIN complaints c ON c.complaint_id = ur.complaint WHERE toilet_id = '5654c008-dbcc-4656-5601-0a0c50652213' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 


(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:2018) 

[2024-07-29 08:07:57]  [5.94ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS) SELECT uplinkTS::text, COALESCE(happy, 0) AS happy, COALESCE(satisfied, 0) AS satisfied, COALESCE(not_satisfied, 0) AS not_satisfied, COALESCE(not_happy, 0) AS not_happy FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN ur.reaction = '1' THEN 1 END) AS happy, COUNT(CASE WHEN ur.reaction = '2' THEN 1 END) AS satisfied, COUNT(CASE WHEN ur.reaction = '3' THEN 1 END) AS not_satisfied, COUNT(CASE WHEN ur.reaction = '4' THEN 1 END) AS not_happy FROM user_reactions ur WHERE toilet_id = '5654c008-dbcc-4656-5601-0a0c50652213' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 


(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1943) 

[2024-07-29 08:07:57]  [5.86ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS)  SELECT uplinkTS::text,COALESCE(TOTAL_MALE,0) AS TOTAL_MALE, COALESCE(TOTAL_FEMALE,0) AS TOTAL_FEMALE FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', CHECK_IN_TS) AS uplinkTS, COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 1 THEN 1 END) TOTAL_MALE, COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 2 THEN 1 END) TOTAL_FEMALE FROM CLEANER_REPORTS WHERE CLEANER_REPORTS.LOCATION_ID = ( SELECT location_id from toilet_infos where toilet_info_id = '5654c008-dbcc-4656-5601-0a0c50652213') GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC   
[4 rows affected or returned ] 


(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1981) 

[2024-07-29 08:07:57]  [2.13ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS) SELECT uplinkTS::text, COALESCE(smelly_toilet, 0) AS smelly_toilet, COALESCE(out_of_supplies, 0) AS out_of_supplies, COALESCE(wet_floor, 0) AS wet_floor, COALESCE(plumbing_issues, 0) AS plumbing_issues FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN ur.complaint = '1' THEN 1 END) AS smelly_toilet, COUNT(CASE WHEN ur.complaint = '2' THEN 1 END) AS out_of_supplies, COUNT(CASE WHEN ur.complaint = '3' THEN 1 END) AS wet_floor, COUNT(CASE WHEN ur.complaint = '4' THEN 1 END) AS plumbing_issues FROM user_reactions ur LEFT JOIN complaints c ON c.complaint_id = ur.complaint WHERE toilet_id = '5654c008-dbcc-4656-5601-0a0c50652213' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 


(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:2018) 

[2024-07-29 08:07:57]  [2.13ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS) SELECT uplinkTS::text, COALESCE(happy, 0) AS happy, COALESCE(satisfied, 0) AS satisfied, COALESCE(not_satisfied, 0) AS not_satisfied, COALESCE(not_happy, 0) AS not_happy FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN ur.reaction = '1' THEN 1 END) AS happy, COUNT(CASE WHEN ur.reaction = '2' THEN 1 END) AS satisfied, COUNT(CASE WHEN ur.reaction = '3' THEN 1 END) AS not_satisfied, COUNT(CASE WHEN ur.reaction = '4' THEN 1 END) AS not_happy FROM user_reactions ur WHERE toilet_id = '5654c008-dbcc-4656-5601-0a0c50652213' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 


(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1943) 

[2024-07-29 08:07:57]  [3.58ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS)  SELECT uplinkTS::text,COALESCE(TOTAL_MALE,0) AS TOTAL_MALE, COALESCE(TOTAL_FEMALE,0) AS TOTAL_FEMALE FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', CHECK_IN_TS) AS uplinkTS, COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 1 THEN 1 END) TOTAL_MALE, COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 2 THEN 1 END) TOTAL_FEMALE FROM CLEANER_REPORTS WHERE CLEANER_REPORTS.LOCATION_ID = ( SELECT location_id from toilet_infos where toilet_info_id = '5654c008-dbcc-4656-5601-0a0c50652213') GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC   
[4 rows affected or returned ] 


(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1981) 

[2024-07-29 08:07:57]  [9.77ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS) SELECT uplinkTS::text, COALESCE(smelly_toilet, 0) AS smelly_toilet, COALESCE(out_of_supplies, 0) AS out_of_supplies, COALESCE(wet_floor, 0) AS wet_floor, COALESCE(plumbing_issues, 0) AS plumbing_issues FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN ur.complaint = '1' THEN 1 END) AS smelly_toilet, COUNT(CASE WHEN ur.complaint = '2' THEN 1 END) AS out_of_supplies, COUNT(CASE WHEN ur.complaint = '3' THEN 1 END) AS wet_floor, COUNT(CASE WHEN ur.complaint = '4' THEN 1 END) AS plumbing_issues FROM user_reactions ur LEFT JOIN complaints c ON c.complaint_id = ur.complaint WHERE toilet_id = '5654c008-dbcc-4656-5601-0a0c50652213' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 


(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:2018) 

[2024-07-29 08:07:57]  [2.77ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS) SELECT uplinkTS::text, COALESCE(happy, 0) AS happy, COALESCE(satisfied, 0) AS satisfied, COALESCE(not_satisfied, 0) AS not_satisfied, COALESCE(not_happy, 0) AS not_happy FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN ur.reaction = '1' THEN 1 END) AS happy, COUNT(CASE WHEN ur.reaction = '2' THEN 1 END) AS satisfied, COUNT(CASE WHEN ur.reaction = '3' THEN 1 END) AS not_satisfied, COUNT(CASE WHEN ur.reaction = '4' THEN 1 END) AS not_happy FROM user_reactions ur WHERE toilet_id = '5654c008-dbcc-4656-5601-0a0c50652213' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 


(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1943) 

[2024-07-29 08:07:57]  [1.95ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS)  SELECT uplinkTS::text,COALESCE(TOTAL_MALE,0) AS TOTAL_MALE, COALESCE(TOTAL_FEMALE,0) AS TOTAL_FEMALE FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', CHECK_IN_TS) AS uplinkTS, COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 1 THEN 1 END) TOTAL_MALE, COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 2 THEN 1 END) TOTAL_FEMALE FROM CLEANER_REPORTS WHERE CLEANER_REPORTS.LOCATION_ID = ( SELECT location_id from toilet_infos where toilet_info_id = '5654c008-dbcc-4656-5601-0a0c50652213') GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC   
[4 rows affected or returned ] 


(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1981) 

[2024-07-29 08:07:57]  [3.59ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS) SELECT uplinkTS::text, COALESCE(smelly_toilet, 0) AS smelly_toilet, COALESCE(out_of_supplies, 0) AS out_of_supplies, COALESCE(wet_floor, 0) AS wet_floor, COALESCE(plumbing_issues, 0) AS plumbing_issues FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN ur.complaint = '1' THEN 1 END) AS smelly_toilet, COUNT(CASE WHEN ur.complaint = '2' THEN 1 END) AS out_of_supplies, COUNT(CASE WHEN ur.complaint = '3' THEN 1 END) AS wet_floor, COUNT(CASE WHEN ur.complaint = '4' THEN 1 END) AS plumbing_issues FROM user_reactions ur LEFT JOIN complaints c ON c.complaint_id = ur.complaint WHERE toilet_id = '5654c008-dbcc-4656-5601-0a0c50652213' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 


(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:2018) 

[2024-07-29 08:07:57]  [5.67ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS) SELECT uplinkTS::text, COALESCE(happy, 0) AS happy, COALESCE(satisfied, 0) AS satisfied, COALESCE(not_satisfied, 0) AS not_satisfied, COALESCE(not_happy, 0) AS not_happy FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN ur.reaction = '1' THEN 1 END) AS happy, COUNT(CASE WHEN ur.reaction = '2' THEN 1 END) AS satisfied, COUNT(CASE WHEN ur.reaction = '3' THEN 1 END) AS not_satisfied, COUNT(CASE WHEN ur.reaction = '4' THEN 1 END) AS not_happy FROM user_reactions ur WHERE toilet_id = '5654c008-dbcc-4656-5601-0a0c50652213' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 


(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1943) 

[2024-07-29 08:07:57]  [6.91ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS)  SELECT uplinkTS::text,COALESCE(TOTAL_MALE,0) AS TOTAL_MALE, COALESCE(TOTAL_FEMALE,0) AS TOTAL_FEMALE FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', CHECK_IN_TS) AS uplinkTS, COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 1 THEN 1 END) TOTAL_MALE, COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 2 THEN 1 END) TOTAL_FEMALE FROM CLEANER_REPORTS WHERE CLEANER_REPORTS.LOCATION_ID = ( SELECT location_id from toilet_infos where toilet_info_id = '5654c008-dbcc-4656-5601-0a0c50652213') GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC   
[4 rows affected or returned ] 


(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1981) 

[2024-07-29 08:07:57]  [3.00ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS) SELECT uplinkTS::text, COALESCE(smelly_toilet, 0) AS smelly_toilet, COALESCE(out_of_supplies, 0) AS out_of_supplies, COALESCE(wet_floor, 0) AS wet_floor, COALESCE(plumbing_issues, 0) AS plumbing_issues FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN ur.complaint = '1' THEN 1 END) AS smelly_toilet, COUNT(CASE WHEN ur.complaint = '2' THEN 1 END) AS out_of_supplies, COUNT(CASE WHEN ur.complaint = '3' THEN 1 END) AS wet_floor, COUNT(CASE WHEN ur.complaint = '4' THEN 1 END) AS plumbing_issues FROM user_reactions ur LEFT JOIN complaints c ON c.complaint_id = ur.complaint WHERE toilet_id = '5654c008-dbcc-4656-5601-0a0c50652213' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 


(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:2018) 

[2024-07-29 08:07:57]  [2.96ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS) SELECT uplinkTS::text, COALESCE(happy, 0) AS happy, COALESCE(satisfied, 0) AS satisfied, COALESCE(not_satisfied, 0) AS not_satisfied, COALESCE(not_happy, 0) AS not_happy FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN ur.reaction = '1' THEN 1 END) AS happy, COUNT(CASE WHEN ur.reaction = '2' THEN 1 END) AS satisfied, COUNT(CASE WHEN ur.reaction = '3' THEN 1 END) AS not_satisfied, COUNT(CASE WHEN ur.reaction = '4' THEN 1 END) AS not_happy FROM user_reactions ur WHERE toilet_id = '5654c008-dbcc-4656-5601-0a0c50652213' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 


(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1943) 

[2024-07-29 08:07:57]  [5.53ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS)  SELECT uplinkTS::text,COALESCE(TOTAL_MALE,0) AS TOTAL_MALE, COALESCE(TOTAL_FEMALE,0) AS TOTAL_FEMALE FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', CHECK_IN_TS) AS uplinkTS, COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 1 THEN 1 END) TOTAL_MALE, COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 2 THEN 1 END) TOTAL_FEMALE FROM CLEANER_REPORTS WHERE CLEANER_REPORTS.LOCATION_ID = ( SELECT location_id from toilet_infos where toilet_info_id = '5654c008-dbcc-4656-5601-0a0c50652213') GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC   
[4 rows affected or returned ] 


(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1981) 

[2024-07-29 08:07:57]  [3.77ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS) SELECT uplinkTS::text, COALESCE(smelly_toilet, 0) AS smelly_toilet, COALESCE(out_of_supplies, 0) AS out_of_supplies, COALESCE(wet_floor, 0) AS wet_floor, COALESCE(plumbing_issues, 0) AS plumbing_issues FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN ur.complaint = '1' THEN 1 END) AS smelly_toilet, COUNT(CASE WHEN ur.complaint = '2' THEN 1 END) AS out_of_supplies, COUNT(CASE WHEN ur.complaint = '3' THEN 1 END) AS wet_floor, COUNT(CASE WHEN ur.complaint = '4' THEN 1 END) AS plumbing_issues FROM user_reactions ur LEFT JOIN complaints c ON c.complaint_id = ur.complaint WHERE toilet_id = '5654c008-dbcc-4656-5601-0a0c50652213' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 


(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:2018) 

[2024-07-29 08:07:57]  [8.67ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS) SELECT uplinkTS::text, COALESCE(happy, 0) AS happy, COALESCE(satisfied, 0) AS satisfied, COALESCE(not_satisfied, 0) AS not_satisfied, COALESCE(not_happy, 0) AS not_happy FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN ur.reaction = '1' THEN 1 END) AS happy, COUNT(CASE WHEN ur.reaction = '2' THEN 1 END) AS satisfied, COUNT(CASE WHEN ur.reaction = '3' THEN 1 END) AS not_satisfied, COUNT(CASE WHEN ur.reaction = '4' THEN 1 END) AS not_happy FROM user_reactions ur WHERE toilet_id = '5654c008-dbcc-4656-5601-0a0c50652213' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 


(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1943) 

[2024-07-29 08:07:57]  [4.32ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS)  SELECT uplinkTS::text,COALESCE(TOTAL_MALE,0) AS TOTAL_MALE, COALESCE(TOTAL_FEMALE,0) AS TOTAL_FEMALE FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', CHECK_IN_TS) AS uplinkTS, COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 1 THEN 1 END) TOTAL_MALE, COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 2 THEN 1 END) TOTAL_FEMALE FROM CLEANER_REPORTS WHERE CLEANER_REPORTS.LOCATION_ID = ( SELECT location_id from toilet_infos where toilet_info_id = '5654c008-dbcc-4656-5601-0a0c50652213') GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC   
[4 rows affected or returned ] 


(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1981) 

[2024-07-29 08:07:57]  [3.13ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS) SELECT uplinkTS::text, COALESCE(smelly_toilet, 0) AS smelly_toilet, COALESCE(out_of_supplies, 0) AS out_of_supplies, COALESCE(wet_floor, 0) AS wet_floor, COALESCE(plumbing_issues, 0) AS plumbing_issues FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN ur.complaint = '1' THEN 1 END) AS smelly_toilet, COUNT(CASE WHEN ur.complaint = '2' THEN 1 END) AS out_of_supplies, COUNT(CASE WHEN ur.complaint = '3' THEN 1 END) AS wet_floor, COUNT(CASE WHEN ur.complaint = '4' THEN 1 END) AS plumbing_issues FROM user_reactions ur LEFT JOIN complaints c ON c.complaint_id = ur.complaint WHERE toilet_id = '5654c008-dbcc-4656-5601-0a0c50652213' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 


(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:2018) 

[2024-07-29 08:07:57]  [2.58ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS) SELECT uplinkTS::text, COALESCE(happy, 0) AS happy, COALESCE(satisfied, 0) AS satisfied, COALESCE(not_satisfied, 0) AS not_satisfied, COALESCE(not_happy, 0) AS not_happy FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN ur.reaction = '1' THEN 1 END) AS happy, COUNT(CASE WHEN ur.reaction = '2' THEN 1 END) AS satisfied, COUNT(CASE WHEN ur.reaction = '3' THEN 1 END) AS not_satisfied, COUNT(CASE WHEN ur.reaction = '4' THEN 1 END) AS not_happy FROM user_reactions ur WHERE toilet_id = '5654c008-dbcc-4656-5601-0a0c50652213' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 


(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1943) 

[2024-07-29 08:07:57]  [4.74ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS)  SELECT uplinkTS::text,COALESCE(TOTAL_MALE,0) AS TOTAL_MALE, COALESCE(TOTAL_FEMALE,0) AS TOTAL_FEMALE FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', CHECK_IN_TS) AS uplinkTS, COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 1 THEN 1 END) TOTAL_MALE, COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 2 THEN 1 END) TOTAL_FEMALE FROM CLEANER_REPORTS WHERE CLEANER_REPORTS.LOCATION_ID = ( SELECT location_id from toilet_infos where toilet_info_id = '5654c008-dbcc-4656-5601-0a0c50652213') GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC   
[4 rows affected or returned ] 


(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1981) 

[2024-07-29 08:07:57]  [6.57ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS) SELECT uplinkTS::text, COALESCE(smelly_toilet, 0) AS smelly_toilet, COALESCE(out_of_supplies, 0) AS out_of_supplies, COALESCE(wet_floor, 0) AS wet_floor, COALESCE(plumbing_issues, 0) AS plumbing_issues FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN ur.complaint = '1' THEN 1 END) AS smelly_toilet, COUNT(CASE WHEN ur.complaint = '2' THEN 1 END) AS out_of_supplies, COUNT(CASE WHEN ur.complaint = '3' THEN 1 END) AS wet_floor, COUNT(CASE WHEN ur.complaint = '4' THEN 1 END) AS plumbing_issues FROM user_reactions ur LEFT JOIN complaints c ON c.complaint_id = ur.complaint WHERE toilet_id = '5654c008-dbcc-4656-5601-0a0c50652213' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 


(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:2018) 

[2024-07-29 08:07:57]  [7.29ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS) SELECT uplinkTS::text, COALESCE(happy, 0) AS happy, COALESCE(satisfied, 0) AS satisfied, COALESCE(not_satisfied, 0) AS not_satisfied, COALESCE(not_happy, 0) AS not_happy FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN ur.reaction = '1' THEN 1 END) AS happy, COUNT(CASE WHEN ur.reaction = '2' THEN 1 END) AS satisfied, COUNT(CASE WHEN ur.reaction = '3' THEN 1 END) AS not_satisfied, COUNT(CASE WHEN ur.reaction = '4' THEN 1 END) AS not_happy FROM user_reactions ur WHERE toilet_id = '5654c008-dbcc-4656-5601-0a0c50652213' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 


(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:2052) 

[2024-07-29 08:07:57]  [2.58ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS)  SELECT uplinkTS::text,COALESCE(TOTAL_TIME_MALE,0) AS TOTAL_TIME_MALE, COALESCE(TOTAL_TIME_FEMALE,0) AS TOTAL_TIME_FEMALE, COALESCE(TOTAL_TIME,0) AS TOTAL_TIME FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', CHECK_IN_TS) AS uplinkTS, AVG(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 1 THEN duration END) TOTAL_TIME_MALE, AVG(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 2 THEN duration END) TOTAL_TIME_FEMALE, AVG(DURATION) TOTAL_TIME FROM CLEANER_REPORTS WHERE CLEANER_REPORTS.LOCATION_ID = ( SELECT location_id from toilet_infos where toilet_info_id = '5654c008-dbcc-4656-5601-0a0c50652213') GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 
