
select * from data_payloads

update data_payloads set color = 'RED1' where color = 'RED'

update data_payloads set color = 'YELLOW1' where color = 'YELLOW'

update data_payloads set color = 'BLUE1' where color = 'BLUE'


select from data_payloads
join meters on meters.meter_token = data_payloads.meter_token
left join 
select * from crosstab($$ select * from loads $$) as cross_laod(attr text, val text)


CREATE EXTENSION tablefunc;


SELECT *
FROM "meter_output_colors"
WHERE
    "meter_output_colors"."deleted_at" IS NULL