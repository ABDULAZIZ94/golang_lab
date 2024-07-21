-- Active: 1721143226972@@127.0.0.1@5432@pgtutorial

CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age INT,
    email VARCHAR(100) UNIQUE
);

INSERT INTO users (name, age, email) VALUES
('Alice', 30, 'alice@example.com'),
('Bob', 35, 'bob@example.com'),
('Charlie', 25, 'charlie@example.com');

-- Generate 100 mock users randomly
DO $$
DECLARE
    i INT := 1;
BEGIN
    WHILE i <= 100 LOOP
        INSERT INTO users (name, age, email)
        VALUES (
            (SELECT md5(random()::text)),
            floor(random() * 80 + 18),
            (SELECT md5(random()::text) || '@example.com')
        );
        i := i + 1;
    END LOOP;
END $$;

-- create 3 tables
CREATE TABLE IF NOT EXISTS address (
    id SERIAL PRIMARY KEY,
    street VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50),
    postal_code VARCHAR(20) NOT NULL
);

-- populate address table with random data
DO $$
DECLARE
    i INT := 1;
BEGIN
    WHILE i <= 100 LOOP
        INSERT INTO address (street, city, state, postal_code)
        VALUES (
            (SELECT md5(random()::text)),
            (SELECT md5(random()::text)),
            (SELECT md5(random()::text)),
            (SELECT substring(md5(random()::text) from 1 for 20))
        );
        i := i + 1;
    END LOOP;
END $$;

CREATE TABLE IF NOT EXISTS family (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    relation VARCHAR(50) NOT NULL,
    age INT
);

-- populate family table with random data
DO $$
DECLARE
    i INT := 1;
BEGIN
    WHILE i <= 100 LOOP
        INSERT INTO family (name, relation, age)
        VALUES (
            (SELECT md5(random()::text)),
            (SELECT md5(random()::text)),
            floor(random() * 80 + 18)
        );
        i := i + 1;
    END LOOP;
END $$;

CREATE TABLE IF NOT EXISTS jobs (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    company VARCHAR(100) NOT NULL,
    salary DECIMAL(10, 2)
);

-- populate jobs table with random data
DO $$
DECLARE
    i INT := 1;
BEGIN
    WHILE i <= 100 LOOP
        INSERT INTO jobs (title, company, salary)
        VALUES (
            (SELECT md5(random()::text)),
            (SELECT md5(random()::text)),
            floor(random() * 1000000)
        );
        i := i + 1;
    END LOOP;
END $$;

-- using join
SELECT u.name, u.age, j.title, j.company, a.street, a.city
FROM users u
JOIN jobs j ON u.id = j.id
JOIN address a ON u.id = a.id;

--using cte (coomon table expression)
WITH
    user_jobs AS (
        SELECT u.name, u.age, j.title, j.company
        FROM users u
            JOIN jobs j ON u.id = j.id
    ),
    user_address AS (
        SELECT u.name, u.age, a.street, a.city
        FROM users u
            JOIN address a ON u.id = a.id
    )
SELECT uj.name, uj.age, uj.title, uj.company, ua.street, ua.city
FROM user_jobs uj
    JOIN user_address ua ON uj.name = ua.name;
SELECT * FROM users

-- add new column
ALTER TABLE orders ADD COLUMN IF NOT EXISTS city_id (id);

-- add new column with constraint
ALTER TABLE orders ADD CONSTRAINT fk_city_id FOREIGN KEY (city_id) REFERENCES city (id);

-- drop constraint
ALTER TABLE table_name DROP CONSTRAINT foreign_key_name;

ALTER TABLE sportspeople DROP CONSTRAINT fk_sport_id;

select random()*(100-0)

select random()::text

select md5(random()::text)


-- create function
CREATE OR REPLACE FUNCTION aziz_func (p1 int, p2 int)
returns int 
language plpgsql as 
$$
BEGIN
    RETURN p1 * p2;
END;
$$ ;

select aziz_func(2, 5) as aziz_times


-- example 2 craete user function
create function get_film_count(len_from int, len_to int) 
returns int 
language plpgsql as 
$$
declare
   film_count integer;
begin
   select count(*)
   into film_count
   from film
   where length between len_from and len_to;

   return film_count;
end;
$$;


-- create function
select * from users limit 10

select * from users where id=1

select * from users fetch first 10 row only;

CREATE OR REPLACE FUNCTION aziz_age() returns int language plpgsql as 
$$
DECLARE
    total_age int;
BEGIN
    select sum(age) 
    into total_age
    from users 
    fetch first 10 row only;
    update users
    set age=999
    where id =1;
    RETURN total_age;
END;
$$ ;


 select aziz_age()

 SELECT EXTRACT(QUARTER FROM TIMESTAMP '2020-12-31 13:30:15');


-- current date time quarter , 3rd quarter
 SELECT EXTRACT(QUARTER FROM TIMESTAMP '2023-07-20 13:30:15');

--  ##When specifying Column Names
-- Insert into tableName (col1, col2) values (value,value),(value,value),(value,value);

-- ## when not specifying Column Names
-- Insert into tableName  values (value,value),(value,value),(value,value);

SELECT CAST ('2020-01-01' AS DATE);

SELECT CAST ('01-OCT-2020' AS DATE);

--error
SELECT CAST ('10C' AS INTEGER);

-- boolean casting
SELECT CAST('true' AS BOOLEAN),
       CAST('false' as BOOLEAN),
       CAST('T' as BOOLEAN),
       CAST('F' as BOOLEAN);


-- testing if
DO $$
DECLARE
  a integer := 10;
  b integer := 20;
BEGIN
  IF a > b THEN
    RAISE NOTICE 'a is greater than b';
  END IF;

  IF a < b THEN
    RAISE NOTICE 'a is less than b';
  END IF;

  IF a = b THEN
    RAISE NOTICE 'a is equal to b';
  END IF;
END $$;

-- if example 2
DO $$
DECLARE
   a integer := 10;
   b integer := 10;
BEGIN
  IF a > b THEN
     RAISE NOTICE 'a is greater than b';
  ELSIF a < b THEN
     RAISE NOTICE 'a is less than b';
  ELSE
     RAISE NOTICE 'a is equal to b';
  END IF;
END $$;

-- test loop
do $$
declare
  n integer:= 6;
  cnt integer := 1 ;
begin
loop
 exit when cnt = n ;
 raise notice '%', cnt;
 cnt := cnt + 1 ;
end loop;
end; $$;


-- while
do $$
declare
    add integer := 0;
begin
while add <10 loop
    raise notice 'Out addition count %', add;
    add := add+1;
end loop;
end;
$$;



--while 2
do $$
declare
    add integer := 10;
begin
while add > 0 loop
    raise notice 'Out addition count %',add;
    add := add-1;
end loop;
end;
$$;


--continue / skip iteration
do $$
declare
  cnt int = 0;
begin
 loop
 -- increment of cnt
    cnt = cnt + 1;
 -- exit the loop if cnt > 10
 exit when cnt > 10;
 -- skip the iteration if cnt is an odd number
 continue when mod(cnt,2) = 1;
 -- print out the cnt
 raise notice '%', cnt;
 end loop;
end;
$$;


-- create table
CREATE TABLE BankStatements (
    customer_id serial PRIMARY KEY,
    full_name VARCHAR NOT NULL,
    balance INT
);

-- insert data
INSERT INTO BankStatements (
    customer_id ,
    full_name,
    balance
)
VALUES
    (1, 'Sekhar rao', 1000),
    (2, 'Abishek Yadav', 500),
    (3, 'Srinivas Goud', 1000);

--check data
select * from bankstatements;;


-- transactions
-- begin and commit
BEGIN;
    UPDATE BankStatements
        SET balance = balance - 500
        WHERE 
        customer_id = 1;
    SELECT customer_id, full_name, balance
        FROM BankStatements;
    UPDATE BankStatements
        SET balance = balance + 500
        WHERE 
        customer_id = 2;
COMMIT;
    SELECT customer_id, full_name, balance 
    FROM BankStatements;


--transaction
-- begin and rollback
BEGIN;


DELETE
FROM BankStatements
WHERE customer_id = 1;


SELECT customer_id,
       full_name,
       balance
FROM BankStatements;


ROLLBACK;


SELECT customer_id,
       full_name,
       balance
FROM BankStatements;


-- basic foreign key constrains
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS contacts;

CREATE TABLE customers(
   customer_id INT GENERATED ALWAYS AS IDENTITY,
   customer_name VARCHAR(255) NOT NULL,
   PRIMARY KEY(customer_id)
);

CREATE TABLE contacts(
   contact_id INT GENERATED ALWAYS AS IDENTITY,
   customer_id INT,
   contact_name VARCHAR(255) NOT NULL,
   phone VARCHAR(15),
   email VARCHAR(100),
   PRIMARY KEY(contact_id),
   CONSTRAINT fk_customer
      FOREIGN KEY(customer_id) 
      REFERENCES customers(customer_id)
);

-- no action example
INSERT INTO customers(customer_name)
VALUES('GeeksforGeeks org'),
      ('Dolphin LLC');       
       
INSERT INTO contacts(customer_id, contact_name, phone, email)
VALUES (1, 'Raju kumar', '(408)-111-1234', 'raju.kumar@geeksforgeeks.org'),
               (1, 'Raju kumar', '(408)-111-1235', 'raju.kumar@bluebird.dev'),
               (2, 'Nikhil Aggarwal', '(408)-222-1234', 'nikhil.aggarwalt@geeksforgeeks.org');

select * from customers;
select * from contacts;


-- foreign key set null example
DROP TABLE IF EXISTS contacts;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers(
   customer_id INT GENERATED ALWAYS AS IDENTITY,
   customer_name VARCHAR(255) NOT NULL,
   PRIMARY KEY(customer_id)
);

CREATE TABLE contacts(
   contact_id INT GENERATED ALWAYS AS IDENTITY,
   customer_id INT,
   contact_name VARCHAR(255) NOT NULL,
   phone VARCHAR(15),
   email VARCHAR(100),
   PRIMARY KEY(contact_id),
   CONSTRAINT fk_customer
      FOREIGN KEY(customer_id) 
      REFERENCES customers(customer_id)
      ON DELETE SET NULL
);

INSERT INTO customers(customer_name)
VALUES('GeeksforGeeks org'),
      ('Dolphin LLC');       
       
INSERT INTO contacts(customer_id, contact_name, phone, email)
VALUES(1, 'Raju Kumar', '(408)-111-1234', 'raju.kumar@geeksforgeeks.org'),
      (1, 'Raju Kumar', '(408)-111-1235', 'raju.kumar@bluebird.dev'),
      (2, 'Nikhil Aggarwal', '(408)-222-1234', 'nikhil.aggarwal@geeksforgeeks.org');


DELETE
FROM customers
WHERE customer_id = 1;

select * from customers;
select * from contacts;


-- self join
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


SELECT e.first_name || ' ' || e.last_name employee,
       m .first_name || ' ' || m .last_name manager
FROM employee e
INNER JOIN employee m ON m .employee_id = e.manager_id
ORDER BY manager;

-- create schema example
CREATE SCHEMA IF NOT EXISTS marketing;

-- check schema
SELECT *
FROM pg_catalog.pg_namespace
ORDER BY nspname;

-- select * from information_schema -- not works

-- show databases; --not works

-- test schema
create schema if not exists geeksforgeeks

ALTER SCHEMA geeksforgeeks RENAME TO gfg;

--fail
-- language psql;
--  \du;

-- list users and role
SELECT usename AS role_name,
       CASE
           WHEN usesuper
                AND usecreatedb THEN CAST('superuser, create database' AS pg_catalog.text)
           WHEN usesuper THEN CAST('superuser' AS pg_catalog.text)
           WHEN usecreatedb THEN CAST('create database' AS pg_catalog.text)
           ELSE CAST('' AS pg_catalog.text)
       END role_attributes
FROM pg_catalog.pg_user
ORDER BY role_name desc;

-- list users and role

SELECT * FROM pg_catalog.pg_user;

-- create superuser
CREATE ROLE abdaziz SUPERUSER;

CREATE ROLE abdaziz SUPERUSER LOGIN PASSWORD 'aziz1234';

CREATE ROLE abdaziz2 LOGIN PASSWORD 'aziz1234';

ALTER ROLE abdaziz2 SUPERUSER;

ALTER ROLE abdaziz LOGIN PASSWORD 'aziz1234';
