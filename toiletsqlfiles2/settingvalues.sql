-- Active: 1722401907309@@157.230.253.116@5432@smarttoilet

select * from users

select * from setting_values where entity_id = 'f8be7a6d-679c-4319-6906-d172ebf7c17e'


-- update
UPDATE "setting_values"
SET
    "active_actuator_on_cnt" = '10',
    "active_actuator_on_cnt_state" = '1',
    "active_actuator_on_odour_lvl" = '10',
    "active_actuator_on_odour_state" = '1',
    "active_freg_odour_level" = '1',
    "active_freg_on_cnt" = '10',
    "active_freg_stat" = '1',
    "cleaner_response_ts" = '10',
    "cleaner_response_ts_notify_state" = '1',
    "height_limit" = 100,
    "music_url" = 'https://',
    "notify_cleaner_total_user" = '10',
    "notify_cleaner_total_user_state" = '1',
    "notify_freg_spray_cnt" = '1',
    "notify_on_freg_level" = '1',
    "notify_on_freg_level_state" = '1',
    "notify_on_lux_state" = '1',
    "notify_on_lux_thres" = '10',
    "notify_on_odour_state" = '1',
    "notify_on_odour_thres" = '10',
    "notify_start_ts" = '08:00',
    "notify_stop_ts" = '17:00',
    "updated_at" = '2024-08-01 17:03:12'
WHERE
    "setting_values"."deleted_at" IS NULL
    AND (
        (
            entity_id = 'f8be7a6d-679c-4319-6906-d172ebf7c17e'
        )
    )

