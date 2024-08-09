-- Active: 1722832765629@@alpha.vectolabs.com@9998@smarttoilet-staging

-- list toilet belong to putrajaya
select *
from toilet_infos
where
    tenant_id = '59944171-3a4a-460d-5897-8bb38c524d54'

-- devices list on that toilet male small
select dp.device_pair_id, dp.toilet_info_id, ti.toilet_name, d.device_name, d.device_token
from
    device_pairs as dp
    join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
    join devices as d on dp.device_id = d.device_id
where
    dp.toilet_info_id = 'e3b73d18-9fc2-405f-5685-bb21bb73e6c4'

-- devices list on that toilet male big
select dp.device_pair_id, dp.toilet_info_id, ti.toilet_name, d.device_name, d.device_token
from
    device_pairs as dp
    join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
    join devices as d on dp.device_id = d.device_id
where
    dp.toilet_info_id = 'f6cb76e9-1cb0-4c6d-5db2-536e7d0fa4ea'


-- devices list on that toilet female big
select dp.device_pair_id, dp.toilet_info_id, ti.toilet_name, d.device_name, d.device_token
from
    device_pairs as dp
    join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
    join devices as d on dp.device_id = d.device_id
where
    dp.toilet_info_id = '23acd373-4a29-427d-40b7-94d348e4f423'


-- devices list on that toilet female small
select dp.device_pair_id, dp.toilet_info_id, ti.toilet_name, d.device_name, d.device_token
from
    device_pairs as dp
    join toilet_infos as ti on dp.toilet_info_id = ti.toilet_info_id
    join devices as d on dp.device_id = d.device_id
where
    dp.toilet_info_id = '1a30dea0-03c9-41d6-5918-b15807c3661f'


-- correcting devices belongs to putrajaya
update device_pairs
set
    toilet_info_id = 'f6cb76e9-1cb0-4c6d-5db2-536e7d0fa4ea'
where
    device_id in (
        select d.device_id
        from devices d
            join device_pairs dp on d.device_id = dp.device_id
        where
            d.tenant_id = '59944171-3a4a-460d-5897-8bb38c524d54'
    )

-- correcting device pairs, purajaya male small
select * from device_pairs

update device_pairs
set
    toilet_info_id = 'e3b73d18-9fc2-405f-5685-bb21bb73e6c4'
where
    device_id in (
        select device_id from devices where device_token in ('22', '11', '41', '61', '2', '51')
    )


-- correcting device_pairs, female big
update device_pairs
set
    toilet_info_id = '23acd373-4a29-427d-40b7-94d348e4f423'
where
    device_id in (
        select device_id
        from devices
        where
            device_token in ('44','64','14','25','3')
    )

-- correcting device pair female small
update device_pairs
set
    toilet_info_id = '1a30dea0-03c9-41d6-5918-b15807c3661f'
where
    device_id in (
        select device_id
        from devices
        where
            device_token in ('13','24','63','43','3')
    )

-- feedback panel from female small to female big
update device_pairs set toilet_info_id = '23acd373-4a29-427d-40b7-94d348e4f423' 
where device_pair_id = '8806fb9b-65c0-4945-6162-ed1a4942452b'

-- feedback panel for male big
update device_pairs set toilet_info_id = 'f6cb76e9-1cb0-4c6d-5db2-536e7d0fa4ea'
where device_pair_id = '5234d66c-6ab3-46e4-41ca-2757352b6bef'

SELECT * from devices where
tenant_id = '59944171-3a4a-460d-5897-8bb38c524d54'

-- correct putrajaya
select d.device_name, d.device_token, dp.toilet_info_id
from devices d
    join device_pairs dp on d.device_id = dp.device_id
where
    d.tenant_id = '59944171-3a4a-460d-5897-8bb38c524d54'