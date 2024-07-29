
-- check db sizes
SELECT pg_database_size('postgres')

SELECT pg_database_size('smarttoilet')

SELECT pg_size_pretty(pg_database_size('smarttoilet'));

SELECT pg_size_pretty( pg_total_relation_size('ammonia_data') );