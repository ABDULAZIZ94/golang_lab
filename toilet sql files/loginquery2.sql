SELECT users.*, user_types.user_type_name,access_levels.access_level_name  
FROM USERS  
JOIN user_types ON user_types.user_type_id = users.user_type_id  
JOIN access_levels ON access_levels.access_level_id = users.access_level_id  
WHERE USERS.EMAIL = 'AZIZ2@MAIL.COM'