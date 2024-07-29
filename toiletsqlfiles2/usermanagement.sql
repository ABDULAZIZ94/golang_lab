-- Active: 1721143226972@@127.0.0.1@5432@smarttoilet
SELECT users.*,user_types.user_type_name , access_levels.access_level_name  
FROM USERS  
JOIN user_types on user_types.user_type_id = users.user_type_id  
JOIN access_levels on access_levels.access_level_id = users.access_level_id WHERE 1=1


SELECT image_s3_path, user_id
FROM cleaner_rfids
-- WHERE user_id = ?


select * from user_types

SELECT * FROM cleaner_rfids

SELECT * FROM access_levels