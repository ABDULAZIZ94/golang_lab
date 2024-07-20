-- Active: 1721143226972@@127.0.0.1@5432@sakilla
CREATE TABLE colors (
    id SERIAL PRIMARY KEY,
    bcolor VARCHAR,
    fcolor VARCHAR
);

INSERT INTO
    colors (bcolor, fcolor)
VALUES ('red', 'red'),
    ('red', 'red'),
    ('red', NULL),
    (NULL, 'red'),
    (NULL, NULL),
    ('green', 'green'),
    ('blue', 'blue'),
    ('blue', 'blue');

SELECT id, bcolor, fcolor FROM colors;

-- example select distinct
SELECT DISTINCT bcolor FROM colors ORDER BY bcolor;

SELECT DISTINCT rental_rate FROM film ORDER BY rental_rate;

-- delete 
CREATE DATABASE company;
CREATE TABLE employee (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR (255) NOT NULL,
    last_name VARCHAR (255) NOT NULL,
    manager_id INT,
    FOREIGN KEY (manager_id) 
    REFERENCES employee (employee_id) 
    ON DELETE CASCADE
);
INSERT INTO employee (
    employee_id,
    first_name,
    last_name,
    manager_id
)
VALUES
    (1, 'Sandeep', 'Jain', NULL),
    (2, 'Abhishek ', 'Kelenia', 1),
    (3, 'Harsh', 'Aggarwal', 1),
    (4, 'Raju', 'Kumar', 2),
    (5, 'Nikhil', 'Aggarwal', 2),
    (6, 'Anshul', 'Aggarwal', 2),
    (7, 'Virat', 'Kohli', 3),
    (8, 'Rohit', 'Sharma', 3);

select * from employee;