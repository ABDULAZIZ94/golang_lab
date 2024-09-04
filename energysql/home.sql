

select * from meters
left join datapayloads on datapayloads.metertoken = meters.meter_token
where meters.id = '33f0d10e-a8f3-4765-7fa2-c35dcbed04e7'