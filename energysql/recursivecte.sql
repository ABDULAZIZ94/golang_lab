
-- using recustive cte
WITH RECURSIVE
    number_series AS (
        -- Base case: start with 1
        SELECT 1 AS n
        UNION ALL
        -- Recursive case: add 1 to the previous number until it reaches 10
        SELECT n + 1
        FROM number_series
        WHERE
            n < 10
    )
SELECT n
FROM number_series;

-- looping throught actual rows
WITH RECURSIVE
    employee_hierarchy AS (
        -- Base case: select the top-level manager (with no supervisor)
        SELECT id, name, manager_id
        FROM employees
        WHERE
            manager_id IS NULL
        UNION ALL
        -- Recursive case: select employees reporting to the previous level
        SELECT e.id, e.name, e.manager_id
        FROM
            employees e
            JOIN employee_hierarchy h ON e.manager_id = h.id
    )
SELECT *
FROM employee_hierarchy;