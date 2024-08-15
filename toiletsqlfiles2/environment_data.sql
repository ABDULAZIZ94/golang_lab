-- Active: 1723732721360@@alpha.vectolabs.com@9998@smarttoilet-staging


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
