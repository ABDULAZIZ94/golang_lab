-- Active: 1720683458566@@127.0.0.1@5432@smarttoilet
select *
from violation_data
limit 10
offset 130



DO $$
DECLARE
    i INT := 1;
BEGIN
    WHILE i <= 100 LOOP
        INSERT INTO violation_data("id","created_at", "updated_at","deleted_at", "violation", "video_url", "device_id")
        VALUES (i,current_timestamp, current_timestamp, current_timestamp, md5(random()::text),md5(random()::text), md5(random()::text));
        i := i +1;
        END LOOP;
END $$;

DO $$
DECLARE
    i INT := 1;
BEGIN
    WHILE i <= 100 LOOP
        INSERT INTO violation_data("created_at", "updated_at","deleted_at", "violation", "video_url", "device_id")
        VALUES (current_timestamp, current_timestamp, current_timestamp, 'Hop over gate', md5(random()::text), '84ae4e2a-b8d7-446f-4bd8-ad658a724ee3');
        i := i +1;
        END LOOP;
END $$;

-- add new device type security_camera

select * from devices

select * from device_types

INSERT INTO
    device_types (
        "device_type_id",
        "device_type_name"
    )
VALUES (14, 'SECURITY_CAMERA')