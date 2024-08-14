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
select * from users where user_id ='7a1c3658-d58b-46ca-6935-6a0835477b69 '

select * from users


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




-- Insert into cleaner_reports 