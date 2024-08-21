-- Active: 1722832765629@@alpha.vectolabs.com@9998@energy-staging


select * from enviroment_data

-- iaq graph
select iaq, date_trunc('HOUR', timestamp)
from enviroment_data where timestamp between to_timestamp('2024-08-15 07:00:00','YYYY-MM-DD HH24:MI:SS') 
and to_timestamp('2024-08-15 18:00:00','YYYY-MM-DD HH24:MI:SS') and device_token = '105'

-- lux graph
select ]('HOUR', timestamp)
from enviroment_data where timestamp between to_timestamp('2024-08-15 07:00:00','YYYY-MM-DD HH24:MI:SS') 
and to_timestamp('2024-08-15 18:00:00','YYYY-MM-DD HH24:MI:SS') and device_token = '105'

-- humidity graph
select humidity, date_trunc('HOUR', timestamp)
from enviroment_data where timestamp between to_timestamp('2024-08-15 07:00:00','YYYY-MM-DD HH24:MI:SS') 
and to_timestamp('2024-08-15 18:00:00','YYYY-MM-DD HH24:MI:SS') and device_token = '105'


-- temperature graph
select temperature, date_trunc('HOUR', timestamp)
from enviroment_data where timestamp between to_timestamp('2024-08-15 07:00:00','YYYY-MM-DD HH24:MI:SS') 
and to_timestamp('2024-08-15 18:00:00','YYYY-MM-DD HH24:MI:SS') and device_token = '105'


select * from enviroment_data where iaq between 1 and 5 order by timestamp desc



select * from enviroment_data where iaq > 5 order by timestamp desc


select * from enviroment_data where device_token = '105' order by timestamp desc limit 10


select * from enviroment_data where device_token = '105' 
and timestamp between to_timestamp('2024-08-20 23:00:00','YYYY-MM-DD HH24:MI:SS')
and to_timestamp( '2024-08-21 11:00:0', 'YYYY-MM-DD HH24:MI:SS' )
order by timestamp desc limit 10


