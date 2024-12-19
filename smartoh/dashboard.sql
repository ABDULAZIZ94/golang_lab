-- abnomal workgroup
SET SESSION sql_mode = REPLACE ( @@sql_mode, 'ONLY_FULL_GROUP_BY', '' );

select 
    -- * 
    distinct (
        CASE
            WHEN normal_left = "1"
            AND normal_right = "1" THEN "Normal"
            ELSE "Abnormal"
        END
    ) AS result,
    `departments`.`name`,
    count(*) as count
from
    `exam_audiogram_report`
    inner join `exams` on `exam_id` = `exams`.`id`
    inner join `employees` on `employee_id` = `employees`.`id`
    inner join `departments` on `employees`.`department_id` = `departments`.`id`
    inner join `clinics` on `exams`.`clinic_id` = `clinics`.`id`
where
    `departments`.`name` is not null
    and `exams`.`clinic_id` = 4
    and `examtype_id` = '3'
    and (
        CASE
            WHEN normal_left = "1"
            AND normal_right = "1" THEN "Normal"
            ELSE "Abnormal"
        END
    ) = 'Abnormal'
group by
    `departments`.`name`
    `result`
-- limit 10
