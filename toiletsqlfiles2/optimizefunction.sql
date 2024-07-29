-- Active: 1722069307805@@157.230.253.116@5432@smarttoilet

select * from users

PREPARE get_users_by_name (text) AS SELECT * FROM users WHERE user_name = $1;
EXECUTE get_users_by_name('abdaziz');
EXECUTE get_users_by_name('john');

select * from users where user_name = 'john'


select *
from pg_indexes
where tablename = 'users'


CREATE INDEX IF NOT EXISTS user_name_index
ON users(user_name, password);