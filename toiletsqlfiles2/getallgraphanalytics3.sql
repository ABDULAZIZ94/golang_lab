r in check access level context.Background.WithValue(type *http.contextKey, val <not Stringer>).WithValue(type *http.contextKey, val 172.17.0.9:7772).WithCancel.WithCancel.WithValue(type *chi.contextKey, val <not Stringer>).WithValue(type *gate.contextKey, val <not Stringer>).WithValue(type *gate.contextKey, val <not Stringer>)
jwtauth: token of the Claims: &{eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySUQiOiIxNmI2ZjcyOC1lMTc5LTRkOWItNTJmNi04MjBlNjQwNzNmMGQiLCJUZW5hbnRJRCI6Ijk5MmM3MTIzLTZlYjMtNDVlZS01NWNhLTcxZjE2NmY2MGY1MyIsIkVtYWlsIjoiQVpJWkBNQUlMLkNPTSIsIlVzZXJUeXBlIjoiVEVOQU5UIiwiQWNjZXNzTGV2ZWwiOiJBRE1JTiIsIlVzZXJUeXBlSUQiOjIsIkFjY2Vzc0xldmVsSUQiOjIsIkJyYW5jaFN0YXRlSUQiOjAsIkJyYW5jaERpc3RyaWN0SUQiOjAsIkFsbEFjY2VzcyI6ZmFsc2UsImV4cCI6MTcyMjQ4MTYyMCwiaWF0IjoxNzIyMjIyNDIwLCJpc3MiOiJWZWN0b2xhYnMtZW5kIn0.SActcORgGHK6HQj87f2maDciPFSOh9n3F0aiyJZtENU 0xc000010b10 map[alg:HS256 typ:JWT] map[AccessLevel:ADMIN AccessLevelID:2 AllAccess:false BranchDistrictID:0 BranchStateID:0 Email:AZIZ@MAIL.COM TenantID:992c7123-6eb3-45ee-55ca-71f166f60f53 UserID:16b6f728-e179-4d9b-52f6-820e64073f0d UserType:TENANT UserTypeID:2 exp:1.72248162e+09 iat:1.72222242e+09 iss:Vectolabs-end] SActcORgGHK6HQj87f2maDciPFSOh9n3F0aiyJZtENU true}, context: context.Background.WithValue(type *http.contextKey, val <not Stringer>).WithValue(type *http.contextKey, val 172.17.0.9:7772).WithCancel.WithCancel.WithValue(type *chi.contextKey, val <not Stringer>).WithValue(type *gate.contextKey, val <not Stringer>).WithValue(type *gate.contextKey, val <not Stringer>)
jwtauth.Get data: &{map[AccessLevel:ADMIN AccessLevelID:2 AllAccess:false BranchDistrictID:0 BranchStateID:0 Email:AZIZ@MAIL.COM TenantID:992c7123-6eb3-45ee-55ca-71f166f60f53 UserID:16b6f728-e179-4d9b-52f6-820e64073f0d UserType:TENANT UserTypeID:2 exp:1722481620 iat:1722222420 iss:Vectolabs-end]} claims:[123 34 65 99 99 101 115 115 76 101 118 101 108 34 58 34 65 68 77 73 78 34 44 34 65 99 99 101 115 115 76 101 118 101 108 73 68 34 58 50 44 34 65 108 108 65 99 99 101 115 115 34 58 102 97 108 115 101 44 34 66 114 97 110 99 104 68 105 115 116 114 105 99 116 73 68 34 58 48 44 34 66 114 97 110 99 104 83 116 97 116 101 73 68 34 58 48 44 34 69 109 97 105 108 34 58 34 65 90 73 90 64 77 65 73 76 46 67 79 77 34 44 34 84 101 110 97 110 116 73 68 34 58 34 57 57 50 99 55 49 50 51 45 54 101 98 51 45 52 53 101 101 45 53 53 99 97 45 55 49 102 49 54 54 102 54 48 102 53 51 34 44 34 85 115 101 114 73 68 34 58 34 49 54 98 54 102 55 50 56 45 101 49 55 57 45 52 100 57 98 45 53 50 102 54 45 56 50 48 101 54 52 48 55 51 102 48 100 34 44 34 85 115 101 114 84 121 112 101 34 58 34 84 69 78 65 78 84 34 44 34 85 115 101 114 84 121 112 101 73 68 34 58 50 44 34 101 120 112 34 58 49 55 50 50 52 56 49 54 50 48 44 34 105 97 116 34 58 49 55 50 50 50 50 50 52 50 48 44 34 105 115 115 34 58 34 86 101 99 116 111 108 97 98 115 45 101 110 100 34 125]
misc.CheckAccessLevel access_info: {"StateID":0,"UserTypeID":2,"AccessLevelID":2,"TenantID":"992c7123-6eb3-45ee-55ca-71f166f60f53","UserID":"16b6f728-e179-4d9b-52f6-820e64073f0d","DistrictID":0,"AccessFlag":false,"UserType":"TENANT","AccessLevel":"ADMIN"}


(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1739) 
[2024-07-29 08:23:23]  [103.26ms]   SELECT DEVICES.DEVICE_NAME,DEVICES.DEVICE_ID,DEVICES.DEVICE_TOKEN, TOILET_INFOS.TOILET_NAME AS Identifier ,DEVICE_TYPES.DEVICE_TYPE_NAME as Namespace, DEVICE_TYPES.DEVICE_TYPE_ID AS NAMESPACE_ID , TOILET_INFOS.TOILET_TYPE_ID FROM DEVICE_PAIRS JOIN DEVICES ON DEVICES.DEVICE_ID = DEVICE_PAIRS.DEVICE_ID JOIN DEVICE_TYPES ON DEVICE_TYPES.DEVICE_TYPE_ID = DEVICES.DEVICE_TYPE_ID JOIN TOILET_INFOS ON TOILET_INFOS.TOILET_INFO_ID = DEVICE_PAIRS.TOILET_INFO_ID WHERE TOILET_INFOS.TOILET_INFO_ID = '5654c008-dbcc-4656-5601-0a0c50652213'   
[10 rows affected or returned ] 
2024/07/29 08:23:23 HERE  7 DAY

(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1888) 
[2024-07-29 08:23:23]  [248.60ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS)  SELECT uplinkTS::text,COALESCE(BIN_FULL, '0')::text AS BIN_FULL, COALESCE(BUSUK, '0')::text AS BUSUK, COALESCE(URINAL_CLOG, '0')::text AS URINAL_CLOG, COALESCE(SANITARY_BIN_FULL, '0')::text AS SANITARY_BIN_FULL, COALESCE(PIPE_LEAK, '0')::text AS PIPE_LEAK, COALESCE(SLIPPERY, '0')::text AS SLIPPERY, COALESCE(OUT_TISSUE, '0')::text AS OUT_TISSUE, COALESCE(REFRESH_TOILET, '0')::text AS REFRESH_TOILET, COALESCE(OUT_SOAP, '0')::text AS OUT_SOAP, COALESCE(CLOGGED_TOILET, '0')::text AS CLOGGED_TOILET FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN BUTTON_ID = 1 THEN 1 END) AS REFRESH_TOILET, COUNT(CASE WHEN BUTTON_ID = 2 THEN 1 END) AS OUT_TISSUE, COUNT(CASE WHEN BUTTON_ID = 3 THEN 1 END) AS BIN_FULL, COUNT(CASE WHEN BUTTON_ID = 4 THEN 1 END) AS OUT_SOAP, COUNT(CASE WHEN BUTTON_ID = 5 THEN 1  END) AS BUSUK, COUNT(CASE WHEN BUTTON_ID = 6 THEN 1 END) AS CLOGGED_TOILET, COUNT(CASE WHEN BUTTON_ID = 7 THEN 1 END) AS URINAL_CLOG, COUNT(CASE WHEN BUTTON_ID = 8 THEN 1 END) AS SLIPPERY, COUNT(CASE WHEN BUTTON_ID = 9 THEN 1 END) AS SANITARY_BIN_FULL, COUNT(CASE WHEN BUTTON_ID = 10 THEN 1 END) AS PIPE_LEAK FROM feedback_panel_data WHERE feedback_panel_data.TOILET_TYPE_ID = 1 AND feedback_panel_data.DEVICE_TOKEN = '4' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 

(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1943) 
[2024-07-29 08:23:23]  [54.14ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS)  SELECT uplinkTS::text,COALESCE(TOTAL_MALE,0) AS TOTAL_MALE, COALESCE(TOTAL_FEMALE,0) AS TOTAL_FEMALE FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', CHECK_IN_TS) AS uplinkTS, COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 1 THEN 1 END) TOTAL_MALE, COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 2 THEN 1 END) TOTAL_FEMALE FROM CLEANER_REPORTS WHERE CLEANER_REPORTS.LOCATION_ID = ( SELECT location_id from toilet_infos where toilet_info_id = '5654c008-dbcc-4656-5601-0a0c50652213') GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC   
[4 rows affected or returned ] 

(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1981) 
[2024-07-29 08:23:23]  [12.93ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS) SELECT uplinkTS::text, COALESCE(smelly_toilet, 0) AS smelly_toilet, COALESCE(out_of_supplies, 0) AS out_of_supplies, COALESCE(wet_floor, 0) AS wet_floor, COALESCE(plumbing_issues, 0) AS plumbing_issues FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN ur.complaint = '1' THEN 1 END) AS smelly_toilet, COUNT(CASE WHEN ur.complaint = '2' THEN 1 END) AS out_of_supplies, COUNT(CASE WHEN ur.complaint = '3' THEN 1 END) AS wet_floor, COUNT(CASE WHEN ur.complaint = '4' THEN 1 END) AS plumbing_issues FROM user_reactions ur LEFT JOIN complaints c ON c.complaint_id = ur.complaint WHERE toilet_id = '5654c008-dbcc-4656-5601-0a0c50652213' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 

(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:2018) 
[2024-07-29 08:23:23]  [9.14ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS) SELECT uplinkTS::text, COALESCE(happy, 0) AS happy, COALESCE(satisfied, 0) AS satisfied, COALESCE(not_satisfied, 0) AS not_satisfied, COALESCE(not_happy, 0) AS not_happy FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN ur.reaction = '1' THEN 1 END) AS happy, COUNT(CASE WHEN ur.reaction = '2' THEN 1 END) AS satisfied, COUNT(CASE WHEN ur.reaction = '3' THEN 1 END) AS not_satisfied, COUNT(CASE WHEN ur.reaction = '4' THEN 1 END) AS not_happy FROM user_reactions ur WHERE toilet_id = '5654c008-dbcc-4656-5601-0a0c50652213' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 

(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1838) 
[2024-07-29 08:23:25]  [1719.49ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS)  SELECT uplinkTS::text,COALESCE(lux, '0')::text AS lux, COALESCE(humidity, '0')::text AS humidity, COALESCE(temperature, '0')::text AS temperature, COALESCE(iaq, '0')::text AS iaq FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, AVG(lux::decimal) as lux,AVG(humidity::decimal) as humidity, AVG(temperature::decimal) as temperature,AVG(iaq::decimal) as iaq FROM enviroment_data WHERE device_token = '28' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 

(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1943) 
[2024-07-29 08:23:25]  [10.98ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS)  SELECT uplinkTS::text,COALESCE(TOTAL_MALE,0) AS TOTAL_MALE, COALESCE(TOTAL_FEMALE,0) AS TOTAL_FEMALE FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', CHECK_IN_TS) AS uplinkTS, COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 1 THEN 1 END) TOTAL_MALE, COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 2 THEN 1 END) TOTAL_FEMALE FROM CLEANER_REPORTS WHERE CLEANER_REPORTS.LOCATION_ID = ( SELECT location_id from toilet_infos where toilet_info_id = '5654c008-dbcc-4656-5601-0a0c50652213') GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC   
[4 rows affected or returned ] 

(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1981) 
[2024-07-29 08:23:25]  [15.84ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS) SELECT uplinkTS::text, COALESCE(smelly_toilet, 0) AS smelly_toilet, COALESCE(out_of_supplies, 0) AS out_of_supplies, COALESCE(wet_floor, 0) AS wet_floor, COALESCE(plumbing_issues, 0) AS plumbing_issues FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN ur.complaint = '1' THEN 1 END) AS smelly_toilet, COUNT(CASE WHEN ur.complaint = '2' THEN 1 END) AS out_of_supplies, COUNT(CASE WHEN ur.complaint = '3' THEN 1 END) AS wet_floor, COUNT(CASE WHEN ur.complaint = '4' THEN 1 END) AS plumbing_issues FROM user_reactions ur LEFT JOIN complaints c ON c.complaint_id = ur.complaint WHERE toilet_id = '5654c008-dbcc-4656-5601-0a0c50652213' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 

(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:2018) 
[2024-07-29 08:23:25]  [8.34ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS) SELECT uplinkTS::text, COALESCE(happy, 0) AS happy, COALESCE(satisfied, 0) AS satisfied, COALESCE(not_satisfied, 0) AS not_satisfied, COALESCE(not_happy, 0) AS not_happy FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN ur.reaction = '1' THEN 1 END) AS happy, COUNT(CASE WHEN ur.reaction = '2' THEN 1 END) AS satisfied, COUNT(CASE WHEN ur.reaction = '3' THEN 1 END) AS not_satisfied, COUNT(CASE WHEN ur.reaction = '4' THEN 1 END) AS not_happy FROM user_reactions ur WHERE toilet_id = '5654c008-dbcc-4656-5601-0a0c50652213' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 

(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1943) 
[2024-07-29 08:23:25]  [13.77ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS)  SELECT uplinkTS::text,COALESCE(TOTAL_MALE,0) AS TOTAL_MALE, COALESCE(TOTAL_FEMALE,0) AS TOTAL_FEMALE FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', CHECK_IN_TS) AS uplinkTS, COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 1 THEN 1 END) TOTAL_MALE, COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 2 THEN 1 END) TOTAL_FEMALE FROM CLEANER_REPORTS WHERE CLEANER_REPORTS.LOCATION_ID = ( SELECT location_id from toilet_infos where toilet_info_id = '5654c008-dbcc-4656-5601-0a0c50652213') GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC   
[4 rows affected or returned ] 

(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1981) 
[2024-07-29 08:23:25]  [12.79ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS) SELECT uplinkTS::text, COALESCE(smelly_toilet, 0) AS smelly_toilet, COALESCE(out_of_supplies, 0) AS out_of_supplies, COALESCE(wet_floor, 0) AS wet_floor, COALESCE(plumbing_issues, 0) AS plumbing_issues FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN ur.complaint = '1' THEN 1 END) AS smelly_toilet, COUNT(CASE WHEN ur.complaint = '2' THEN 1 END) AS out_of_supplies, COUNT(CASE WHEN ur.complaint = '3' THEN 1 END) AS wet_floor, COUNT(CASE WHEN ur.complaint = '4' THEN 1 END) AS plumbing_issues FROM user_reactions ur LEFT JOIN complaints c ON c.complaint_id = ur.complaint WHERE toilet_id = '5654c008-dbcc-4656-5601-0a0c50652213' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 

(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:2018) 
[2024-07-29 08:23:25]  [14.26ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS) SELECT uplinkTS::text, COALESCE(happy, 0) AS happy, COALESCE(satisfied, 0) AS satisfied, COALESCE(not_satisfied, 0) AS not_satisfied, COALESCE(not_happy, 0) AS not_happy FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN ur.reaction = '1' THEN 1 END) AS happy, COUNT(CASE WHEN ur.reaction = '2' THEN 1 END) AS satisfied, COUNT(CASE WHEN ur.reaction = '3' THEN 1 END) AS not_satisfied, COUNT(CASE WHEN ur.reaction = '4' THEN 1 END) AS not_happy FROM user_reactions ur WHERE toilet_id = '5654c008-dbcc-4656-5601-0a0c50652213' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 

(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1943) 
[2024-07-29 08:23:25]  [10.46ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS)  SELECT uplinkTS::text,COALESCE(TOTAL_MALE,0) AS TOTAL_MALE, COALESCE(TOTAL_FEMALE,0) AS TOTAL_FEMALE FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', CHECK_IN_TS) AS uplinkTS, COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 1 THEN 1 END) TOTAL_MALE, COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 2 THEN 1 END) TOTAL_FEMALE FROM CLEANER_REPORTS WHERE CLEANER_REPORTS.LOCATION_ID = ( SELECT location_id from toilet_infos where toilet_info_id = '5654c008-dbcc-4656-5601-0a0c50652213') GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC   
[4 rows affected or returned ] 

(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1981) 
[2024-07-29 08:23:25]  [25.05ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS) SELECT uplinkTS::text, COALESCE(smelly_toilet, 0) AS smelly_toilet, COALESCE(out_of_supplies, 0) AS out_of_supplies, COALESCE(wet_floor, 0) AS wet_floor, COALESCE(plumbing_issues, 0) AS plumbing_issues FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN ur.complaint = '1' THEN 1 END) AS smelly_toilet, COUNT(CASE WHEN ur.complaint = '2' THEN 1 END) AS out_of_supplies, COUNT(CASE WHEN ur.complaint = '3' THEN 1 END) AS wet_floor, COUNT(CASE WHEN ur.complaint = '4' THEN 1 END) AS plumbing_issues FROM user_reactions ur LEFT JOIN complaints c ON c.complaint_id = ur.complaint WHERE toilet_id = '5654c008-dbcc-4656-5601-0a0c50652213' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 

(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:2018) 
[2024-07-29 08:23:25]  [4.91ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS) SELECT uplinkTS::text, COALESCE(happy, 0) AS happy, COALESCE(satisfied, 0) AS satisfied, COALESCE(not_satisfied, 0) AS not_satisfied, COALESCE(not_happy, 0) AS not_happy FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN ur.reaction = '1' THEN 1 END) AS happy, COUNT(CASE WHEN ur.reaction = '2' THEN 1 END) AS satisfied, COUNT(CASE WHEN ur.reaction = '3' THEN 1 END) AS not_satisfied, COUNT(CASE WHEN ur.reaction = '4' THEN 1 END) AS not_happy FROM user_reactions ur WHERE toilet_id = '5654c008-dbcc-4656-5601-0a0c50652213' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 

(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1943) 
[2024-07-29 08:23:25]  [8.75ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS)  SELECT uplinkTS::text,COALESCE(TOTAL_MALE,0) AS TOTAL_MALE, COALESCE(TOTAL_FEMALE,0) AS TOTAL_FEMALE FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', CHECK_IN_TS) AS uplinkTS, COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 1 THEN 1 END) TOTAL_MALE, COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 2 THEN 1 END) TOTAL_FEMALE FROM CLEANER_REPORTS WHERE CLEANER_REPORTS.LOCATION_ID = ( SELECT location_id from toilet_infos where toilet_info_id = '5654c008-dbcc-4656-5601-0a0c50652213') GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC   
[4 rows affected or returned ] 

(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1981) 
[2024-07-29 08:23:25]  [13.95ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS) SELECT uplinkTS::text, COALESCE(smelly_toilet, 0) AS smelly_toilet, COALESCE(out_of_supplies, 0) AS out_of_supplies, COALESCE(wet_floor, 0) AS wet_floor, COALESCE(plumbing_issues, 0) AS plumbing_issues FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN ur.complaint = '1' THEN 1 END) AS smelly_toilet, COUNT(CASE WHEN ur.complaint = '2' THEN 1 END) AS out_of_supplies, COUNT(CASE WHEN ur.complaint = '3' THEN 1 END) AS wet_floor, COUNT(CASE WHEN ur.complaint = '4' THEN 1 END) AS plumbing_issues FROM user_reactions ur LEFT JOIN complaints c ON c.complaint_id = ur.complaint WHERE toilet_id = '5654c008-dbcc-4656-5601-0a0c50652213' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 

(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:2018) 
[2024-07-29 08:23:25]  [5.19ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS) SELECT uplinkTS::text, COALESCE(happy, 0) AS happy, COALESCE(satisfied, 0) AS satisfied, COALESCE(not_satisfied, 0) AS not_satisfied, COALESCE(not_happy, 0) AS not_happy FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN ur.reaction = '1' THEN 1 END) AS happy, COUNT(CASE WHEN ur.reaction = '2' THEN 1 END) AS satisfied, COUNT(CASE WHEN ur.reaction = '3' THEN 1 END) AS not_satisfied, COUNT(CASE WHEN ur.reaction = '4' THEN 1 END) AS not_happy FROM user_reactions ur WHERE toilet_id = '5654c008-dbcc-4656-5601-0a0c50652213' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 

(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1943) 
[2024-07-29 08:23:25]  [7.65ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS)  SELECT uplinkTS::text,COALESCE(TOTAL_MALE,0) AS TOTAL_MALE, COALESCE(TOTAL_FEMALE,0) AS TOTAL_FEMALE FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', CHECK_IN_TS) AS uplinkTS, COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 1 THEN 1 END) TOTAL_MALE, COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 2 THEN 1 END) TOTAL_FEMALE FROM CLEANER_REPORTS WHERE CLEANER_REPORTS.LOCATION_ID = ( SELECT location_id from toilet_infos where toilet_info_id = '5654c008-dbcc-4656-5601-0a0c50652213') GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC   
[4 rows affected or returned ] 

(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1981) 
[2024-07-29 08:23:25]  [6.48ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS) SELECT uplinkTS::text, COALESCE(smelly_toilet, 0) AS smelly_toilet, COALESCE(out_of_supplies, 0) AS out_of_supplies, COALESCE(wet_floor, 0) AS wet_floor, COALESCE(plumbing_issues, 0) AS plumbing_issues FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN ur.complaint = '1' THEN 1 END) AS smelly_toilet, COUNT(CASE WHEN ur.complaint = '2' THEN 1 END) AS out_of_supplies, COUNT(CASE WHEN ur.complaint = '3' THEN 1 END) AS wet_floor, COUNT(CASE WHEN ur.complaint = '4' THEN 1 END) AS plumbing_issues FROM user_reactions ur LEFT JOIN complaints c ON c.complaint_id = ur.complaint WHERE toilet_id = '5654c008-dbcc-4656-5601-0a0c50652213' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 

(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:2018) 
[2024-07-29 08:23:25]  [16.41ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS) SELECT uplinkTS::text, COALESCE(happy, 0) AS happy, COALESCE(satisfied, 0) AS satisfied, COALESCE(not_satisfied, 0) AS not_satisfied, COALESCE(not_happy, 0) AS not_happy FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN ur.reaction = '1' THEN 1 END) AS happy, COUNT(CASE WHEN ur.reaction = '2' THEN 1 END) AS satisfied, COUNT(CASE WHEN ur.reaction = '3' THEN 1 END) AS not_satisfied, COUNT(CASE WHEN ur.reaction = '4' THEN 1 END) AS not_happy FROM user_reactions ur WHERE toilet_id = '5654c008-dbcc-4656-5601-0a0c50652213' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 

(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1943) 
[2024-07-29 08:23:25]  [9.58ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS)  SELECT uplinkTS::text,COALESCE(TOTAL_MALE,0) AS TOTAL_MALE, COALESCE(TOTAL_FEMALE,0) AS TOTAL_FEMALE FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', CHECK_IN_TS) AS uplinkTS, COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 1 THEN 1 END) TOTAL_MALE, COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 2 THEN 1 END) TOTAL_FEMALE FROM CLEANER_REPORTS WHERE CLEANER_REPORTS.LOCATION_ID = ( SELECT location_id from toilet_infos where toilet_info_id = '5654c008-dbcc-4656-5601-0a0c50652213') GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC   
[4 rows affected or returned ] 

(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1981) 
[2024-07-29 08:23:25]  [7.20ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS) SELECT uplinkTS::text, COALESCE(smelly_toilet, 0) AS smelly_toilet, COALESCE(out_of_supplies, 0) AS out_of_supplies, COALESCE(wet_floor, 0) AS wet_floor, COALESCE(plumbing_issues, 0) AS plumbing_issues FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN ur.complaint = '1' THEN 1 END) AS smelly_toilet, COUNT(CASE WHEN ur.complaint = '2' THEN 1 END) AS out_of_supplies, COUNT(CASE WHEN ur.complaint = '3' THEN 1 END) AS wet_floor, COUNT(CASE WHEN ur.complaint = '4' THEN 1 END) AS plumbing_issues FROM user_reactions ur LEFT JOIN complaints c ON c.complaint_id = ur.complaint WHERE toilet_id = '5654c008-dbcc-4656-5601-0a0c50652213' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 

(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:2018) 
[2024-07-29 08:23:25]  [11.11ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS) SELECT uplinkTS::text, COALESCE(happy, 0) AS happy, COALESCE(satisfied, 0) AS satisfied, COALESCE(not_satisfied, 0) AS not_satisfied, COALESCE(not_happy, 0) AS not_happy FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN ur.reaction = '1' THEN 1 END) AS happy, COUNT(CASE WHEN ur.reaction = '2' THEN 1 END) AS satisfied, COUNT(CASE WHEN ur.reaction = '3' THEN 1 END) AS not_satisfied, COUNT(CASE WHEN ur.reaction = '4' THEN 1 END) AS not_happy FROM user_reactions ur WHERE toilet_id = '5654c008-dbcc-4656-5601-0a0c50652213' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 

(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1943) 
[2024-07-29 08:23:25]  [5.21ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS)  SELECT uplinkTS::text,COALESCE(TOTAL_MALE,0) AS TOTAL_MALE, COALESCE(TOTAL_FEMALE,0) AS TOTAL_FEMALE FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', CHECK_IN_TS) AS uplinkTS, COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 1 THEN 1 END) TOTAL_MALE, COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 2 THEN 1 END) TOTAL_FEMALE FROM CLEANER_REPORTS WHERE CLEANER_REPORTS.LOCATION_ID = ( SELECT location_id from toilet_infos where toilet_info_id = '5654c008-dbcc-4656-5601-0a0c50652213') GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC   
[4 rows affected or returned ] 

(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1981) 
[2024-07-29 08:23:25]  [11.02ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS) SELECT uplinkTS::text, COALESCE(smelly_toilet, 0) AS smelly_toilet, COALESCE(out_of_supplies, 0) AS out_of_supplies, COALESCE(wet_floor, 0) AS wet_floor, COALESCE(plumbing_issues, 0) AS plumbing_issues FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN ur.complaint = '1' THEN 1 END) AS smelly_toilet, COUNT(CASE WHEN ur.complaint = '2' THEN 1 END) AS out_of_supplies, COUNT(CASE WHEN ur.complaint = '3' THEN 1 END) AS wet_floor, COUNT(CASE WHEN ur.complaint = '4' THEN 1 END) AS plumbing_issues FROM user_reactions ur LEFT JOIN complaints c ON c.complaint_id = ur.complaint WHERE toilet_id = '5654c008-dbcc-4656-5601-0a0c50652213' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 

(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:2018) 
[2024-07-29 08:23:25]  [7.23ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS) SELECT uplinkTS::text, COALESCE(happy, 0) AS happy, COALESCE(satisfied, 0) AS satisfied, COALESCE(not_satisfied, 0) AS not_satisfied, COALESCE(not_happy, 0) AS not_happy FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN ur.reaction = '1' THEN 1 END) AS happy, COUNT(CASE WHEN ur.reaction = '2' THEN 1 END) AS satisfied, COUNT(CASE WHEN ur.reaction = '3' THEN 1 END) AS not_satisfied, COUNT(CASE WHEN ur.reaction = '4' THEN 1 END) AS not_happy FROM user_reactions ur WHERE toilet_id = '5654c008-dbcc-4656-5601-0a0c50652213' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 

(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1943) 
[2024-07-29 08:23:25]  [6.09ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS)  SELECT uplinkTS::text,COALESCE(TOTAL_MALE,0) AS TOTAL_MALE, COALESCE(TOTAL_FEMALE,0) AS TOTAL_FEMALE FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', CHECK_IN_TS) AS uplinkTS, COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 1 THEN 1 END) TOTAL_MALE, COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 2 THEN 1 END) TOTAL_FEMALE FROM CLEANER_REPORTS WHERE CLEANER_REPORTS.LOCATION_ID = ( SELECT location_id from toilet_infos where toilet_info_id = '5654c008-dbcc-4656-5601-0a0c50652213') GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC   
[4 rows affected or returned ] 

(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1981) 
[2024-07-29 08:23:25]  [9.27ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS) SELECT uplinkTS::text, COALESCE(smelly_toilet, 0) AS smelly_toilet, COALESCE(out_of_supplies, 0) AS out_of_supplies, COALESCE(wet_floor, 0) AS wet_floor, COALESCE(plumbing_issues, 0) AS plumbing_issues FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN ur.complaint = '1' THEN 1 END) AS smelly_toilet, COUNT(CASE WHEN ur.complaint = '2' THEN 1 END) AS out_of_supplies, COUNT(CASE WHEN ur.complaint = '3' THEN 1 END) AS wet_floor, COUNT(CASE WHEN ur.complaint = '4' THEN 1 END) AS plumbing_issues FROM user_reactions ur LEFT JOIN complaints c ON c.complaint_id = ur.complaint WHERE toilet_id = '5654c008-dbcc-4656-5601-0a0c50652213' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 

(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:2018) 
[2024-07-29 08:23:25]  [11.10ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS) SELECT uplinkTS::text, COALESCE(happy, 0) AS happy, COALESCE(satisfied, 0) AS satisfied, COALESCE(not_satisfied, 0) AS not_satisfied, COALESCE(not_happy, 0) AS not_happy FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN ur.reaction = '1' THEN 1 END) AS happy, COUNT(CASE WHEN ur.reaction = '2' THEN 1 END) AS satisfied, COUNT(CASE WHEN ur.reaction = '3' THEN 1 END) AS not_satisfied, COUNT(CASE WHEN ur.reaction = '4' THEN 1 END) AS not_happy FROM user_reactions ur WHERE toilet_id = '5654c008-dbcc-4656-5601-0a0c50652213' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 

(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1943) 
[2024-07-29 08:23:25]  [5.63ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS)  SELECT uplinkTS::text,COALESCE(TOTAL_MALE,0) AS TOTAL_MALE, COALESCE(TOTAL_FEMALE,0) AS TOTAL_FEMALE FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', CHECK_IN_TS) AS uplinkTS, COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 1 THEN 1 END) TOTAL_MALE, COUNT(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 2 THEN 1 END) TOTAL_FEMALE FROM CLEANER_REPORTS WHERE CLEANER_REPORTS.LOCATION_ID = ( SELECT location_id from toilet_infos where toilet_info_id = '5654c008-dbcc-4656-5601-0a0c50652213') GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC   
[4 rows affected or returned ] 

(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:1981) 
[2024-07-29 08:23:26]  [12.94ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS) SELECT uplinkTS::text, COALESCE(smelly_toilet, 0) AS smelly_toilet, COALESCE(out_of_supplies, 0) AS out_of_supplies, COALESCE(wet_floor, 0) AS wet_floor, COALESCE(plumbing_issues, 0) AS plumbing_issues FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN ur.complaint = '1' THEN 1 END) AS smelly_toilet, COUNT(CASE WHEN ur.complaint = '2' THEN 1 END) AS out_of_supplies, COUNT(CASE WHEN ur.complaint = '3' THEN 1 END) AS wet_floor, COUNT(CASE WHEN ur.complaint = '4' THEN 1 END) AS plumbing_issues FROM user_reactions ur LEFT JOIN complaints c ON c.complaint_id = ur.complaint WHERE toilet_id = '5654c008-dbcc-4656-5601-0a0c50652213' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 

(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:2018) 
[2024-07-29 08:23:26]  [9.13ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS) SELECT uplinkTS::text, COALESCE(happy, 0) AS happy, COALESCE(satisfied, 0) AS satisfied, COALESCE(not_satisfied, 0) AS not_satisfied, COALESCE(not_happy, 0) AS not_happy FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', timestamp) AS uplinkTS, COUNT(CASE WHEN ur.reaction = '1' THEN 1 END) AS happy, COUNT(CASE WHEN ur.reaction = '2' THEN 1 END) AS satisfied, COUNT(CASE WHEN ur.reaction = '3' THEN 1 END) AS not_satisfied, COUNT(CASE WHEN ur.reaction = '4' THEN 1 END) AS not_happy FROM user_reactions ur WHERE toilet_id = '5654c008-dbcc-4656-5601-0a0c50652213' GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 

(/go/src/gitlab.com/smarttoilet-tele/pkg/controllers/TelemetryController.go:2052) 
[2024-07-29 08:23:26]  [11.13ms]   WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('WEEK', TO_TIMESTAMP('2024-07-01', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('WEEK', TO_TIMESTAMP('2024-07-23', 'YYYY-MM-DD HH24:MI:SS')), interval '7 DAY') uplinkTS)  SELECT uplinkTS::text,COALESCE(TOTAL_TIME_MALE,0) AS TOTAL_TIME_MALE, COALESCE(TOTAL_TIME_FEMALE,0) AS TOTAL_TIME_FEMALE, COALESCE(TOTAL_TIME,0) AS TOTAL_TIME FROM GENTIME LEFT JOIN (SELECT date_trunc('WEEK', CHECK_IN_TS) AS uplinkTS, AVG(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 1 THEN duration END) TOTAL_TIME_MALE, AVG(CASE WHEN CLEANER_REPORTS.TOILET_TYPE_ID = 2 THEN duration END) TOTAL_TIME_FEMALE, AVG(DURATION) TOTAL_TIME FROM CLEANER_REPORTS WHERE CLEANER_REPORTS.LOCATION_ID = ( SELECT location_id from toilet_infos where toilet_info_id = '5654c008-dbcc-4656-5601-0a0c50652213') GROUP BY uplinkTS) second_query USING (uplinkTS) ORDER BY uplinkTS ASC  
[4 rows affected or returned ] 
