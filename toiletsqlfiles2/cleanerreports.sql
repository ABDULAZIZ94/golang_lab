-- alter table
alter table cleaner_reports add column cubical_alias_id int

ALTER TABLE cleaner_reports RENAME COLUMN cubical_alias_id TO device_aliases

ALTER TABLE cleaner_reports RENAME COLUMN device_aliases TO cubical_tag

ALTER TABLE cleaner_reports RENAME COLUMN cubical_tag TO cubical_id



ALTER TABLE cleaner_reports
ALTER COLUMN cubical_tag 
TYPE text;

-- check table

select * from devices

select * from device_types

select * from cleaner_reports order by created_at desc limit 10

select * from cleaner_reports where tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd' order by created_at desc limit 10

select * from cleaner_reports where auto_clean_state = '1' order by created_at asc

--cleaner user id 7a1c3658-d58b-46ca-6935-6a0835477b69 
select * from users where user_id ='4b079dad-b330-44ff-78e2-be8fa66c8f3f'

select * from users


select * from cleaner_reports where auto_clean_state = '1' order by created_at asc

-- count how may auto cleans
select distinct tenant_id, count(tenant_id) from
(select *
from cleaner_reports
where
    auto_clean_state = '1'
order by created_at) Q1
group BY tenant_id

select * from tenants

select * from device_aliases


select * from cleaner_reports order by created_at desc limit 1

select * from cleaner_reports where cleaner_report_id = ''

-- Insert into cleaner_reports 

select * from toilet_infos

select * from cleaner_reports

select * from cleaner_reports where created_at between now() and now()+ interval '5 minute'

select * from cleaner_reports where created_at between now() and now()+ interval '5 minute' and auto_clean_state ='1'

SELECT *
FROM cleaner_reports
WHERE
    created_at BETWEEN NOW() - INTERVAL '5 minute' AND NOW();

select ti.toilet_info_id, auto_clean_state 
from cleaner_reports cr
join toilet_infos ti on ti.location_id = cr.location_id and ti.toilet_type_id = cr.toilet_type_id


--
insert into
    cleaner_reports (
        cleaner_report_id,
        tenant_id,
        location_id,
        toilet_type_id,
        check_in_ts,
        check_out_ts,
        duration,
        auto_clean_state,
        created_at,
        updated_at,
        cubical_id
    )
VALUES (
        uuid_generate_v4 (),
        '589ee2f0-75e1-4cd0-5c74-78a4df1288fd',
        '964cd0a5-8620-4a24-67af-578da8c3b6df',
        '2',
        NOW(),
        NOW() + interval '15 secs',
        15,
        '1',
        NOW(),
        NOW() + interval '15 secs',
        NULL
    )




    --
    WITH GENTIME as (SELECT uplinkTS FROM generate_series(date_trunc('DAY', TO_TIMESTAMP('2024-08-20 07:00:00', 'YYYY-MM-DD HH24:MI:SS')), date_trunc('DAY', TO_TIMESTAMP('2024-08-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')), interval '1 DAY') uplinkTS)  SELECT uplinkTS::text, COALESCE(TOTAL,0) AS TOTAL FROM GENTIME LEFT JOIN (SELECT date_trunc('DAY', CHECK_IN_TS) AS uplinkTS, COUNT(CLEANER_REPORT_ID) AS TOTAL FROM CLEANER_REPORTS WHERE CLEANER_REPORTS.tenant_id = '589ee2f0-75e1-4cd0-5c74-78a4df1288fd' ANd created_at between to_timestamp('2024-08-20 07:00:00', YYYY-MM-DD HH24:MI:SS') and to_timestamp('2024-08-20 18:00:00', YYYY-MM-DD HH24:MI:SS') GROUP BY uplinkTS) second_query USING (uplinkTS) order by uplinkTS 
