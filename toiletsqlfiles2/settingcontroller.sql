-- SELECT setting_values.* FROM setting_values where entity_id = 
SELECT setting_values.* FROM setting_values

SELECT feedback_panels.button_name,feedback_panel_settings.* FROM feedback_panel_settings 
JOIN  feedback_panels ON feedback_panels.button_id = feedback_panel_settings.button_id
-- where fp_set_id = ''
where 1=1
limit 10

