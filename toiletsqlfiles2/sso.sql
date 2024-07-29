
-- user login
SELECT users.*, user_types.user_type_name,access_levels.access_level_name   
FROM USERS   JOIN user_types ON user_types.user_type_id = users.user_type_id   
JOIN access_levels ON access_levels.access_level_id = users.access_level_id   
WHERE USERS.EMAIL = ? if strings.ToUpper(loginType) == CONTRACTOR 
 
  AND user_types.user_type_id = 4 } else if strings.ToUpper(loginType) == TENANT 
{ loginQuery = loginQuery   AND access_levels.access_level_id < 4 } else {

