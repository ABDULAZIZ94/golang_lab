-- Active: 1722832765629@@alpha.vectolabs.com@9998@smarttoilet-staging
-- create device aliases table

create table device_aliases(
    Id serial,
    DeviceId string,
    Alias varchar(255)
)

select * from device_aliases

select * from devices where tenant_id ='589ee2f0-75e1-4cd0-5c74-78a4df1288fd' and device_name like '%OCCUPANCY%'

insert into device_aliases("device_id", "alias") values('2ef47079-00e6-473c-72e0-0580149bbb5d','OCCUPANCY_FEMALE_F4')

insert into device_aliases("device_id", "alias") values('f28f7d40-4aee-414a-584a-f770d266183e','OCCUPANCY_FEMALE_F3')

insert into device_aliases("device_id", "alias") values('24c3bd7b-af82-4e14-5178-f8b6c90af869','OCCUPANCY_FEMALE_F2')

insert into device_aliases("device_id", "alias") values('e4ebb57f-7321-4d53-696f-bd30ffbe67be','OCCUPANCY_FEMALE_F1')


-- second
insert into device_aliases("device_id", "alias") values('3c64d02c-abfb-4b57-5dfe-116d163ecee3','OCCUPANCY_MALE_M1')

insert into device_aliases("device_id", "alias") values('c7c36586-a4ef-4f43-7d65-fa5d64eeee05','OCCUPANCY_MALE_M2')

insert into device_aliases("device_id", "alias") values('3648c6aa-6fb1-405a-6209-7408a38eb6fa','OCCUPANCY_MALE_M3')

insert into device_aliases("device_id", "alias") values('c5eca81d-fe64-47f6-491b-4d2f7225cb51','OCCUPANCY_MALE_M4')

--- list of toilets
36f74ec4-cdb0-4271-6c2d-2baa48d6e583  --112
9388096c-784d-49c8-784c-1868b1233165  --118
a97891e5-14df-4f95-7d1e-4ee601581df2 -- none


select * from occupancy_data where device_token ='112' and
    timestamp BETWEEN to_timestamp(
        '2024-08-12 00:00:00',
        'YYYY-MM-DD HH24:MI:SS'
    ) AND to_timestamp(
        '2024-08-12 23:59:59',
        'YYYY-MM-DD HH24:MI:SS'
    )
order by timestamp limit 10

-- device alias
WITH
    DEVICE_LIST AS (
        select dp.device_pair_id, d.device_name, d.device_token, d.device_id
        from
            device_pairs as dp
            join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
            join devices as d on dp.device_id = d.device_id
        where
            dp.toilet_info_id = '9388096c-784d-49c8-784c-1868b1233165'
            and d.device_type_id = 12
    )
select 
    od.occupied as occupancy, 
    right(Q2.alias, 2) as cubical_name, 
    Q1.cubical_counter, 
    dl.device_name
from
    occupancy_data od
    join device_list dl on dl.device_token = od.device_token
    left join (
        select COALESCE(
                sum(
                    CASE
                        WHEN occupied = TRUE
                        AND prev_occupied = FALSE THEN 1
                        ELSE 0
                    END
                ), 0
            ) as cubical_counter, device_token
        from (
                select *, lag(occupied, 1) over (
                        order by id
                    ) prev_occupied
                from occupancy_data
            ) SQ1
        where
            timestamp BETWEEN to_timestamp(
                '2024-08-01 00:00:00',
                'YYYY-MM-DD HH24:MI:SS'
            ) AND to_timestamp(
                '2024-08-12 23:59:59',
                'YYYY-MM-DD HH24:MI:SS'
            )
        group by
            device_token
    ) Q1 on Q1.device_token = dl.device_token
    left join (
        select distinct
            device_id,
            alias
        from device_aliases
    ) Q2 using (device_id)
order by timestamp desc
limit 1