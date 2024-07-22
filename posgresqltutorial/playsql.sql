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

--plsql block
DO $$
<<first_block>>
DECLARE
  counter integer := 0;
BEGIN
   counter := counter + 1;
   RAISE NOTICE 'The current value of counter is %', counter;
END first_block $$;

-- generate random uuid
select gen_random_uuid()

-- plsql block and subblock
DO $$
<<outer_block>>
DECLARE
  counter integer := 0;
BEGIN
   counter := counter + 1;
   RAISE NOTICE 'The current value of counter is %', counter;

   DECLARE
       counter integer := 0;
   BEGIN
       counter := counter + 10;
       RAISE NOTICE 'The current value of counter in the subblock is %', counter;
       RAISE NOTICE 'The current value of counter in the outer block is %', outer_block.counter;
   END;

   RAISE NOTICE 'The current value of counter in the outer block is %', counter;

END outer_block $$;


-- basic variable
do $$
declare
    counter integer :=1;
    first_name varchar(50) := 'abd';
    last_name varchar(50) :='aziz';
    payment numeric(11,2):= 20.5;
begin
    raise notice '% % % has paid RM % ', counter, first_name, last_name, payment;
end $$;


-- table for stored procedure
drop table if exists accounts;

create table accounts (
    id int generated by default as identity,
    name varchar(100) not null,
    balance dec(15, 2) not null,
    primary key(id)
);

insert into accounts(name, balance) values('Raju', 10000);

insert into accounts(name, balance)
values('Nikhil', 10000);

select * from accounts;

create or replace procedure transfer(
   sender int,
   receiver int, 
   amount dec
)
language plpgsql    
as $$
begin
    -- subtracting the amount from the sender's account 
    update accounts 
    set balance = balance - amount 
    where id = sender;

    -- adding the amount to the receiver's account
    update accounts 
    set balance = balance + amount 
    where id = receiver;

    commit;
end;
$$;

-- test stored procedure
call transfer(1, 2, 1000);
SELECT * FROM accounts;


-- create table for testing trigger
CREATE TABLE COMPANY(
   ID INT PRIMARY KEY NOT NULL,
   NAME TEXT NOT NULL,
   AGE INT NOT NULL,
   ADDRESS CHAR(50),
   SALARY REAL
);

CREATE TABLE AUDIT(
   EMP_ID INT NOT NULL,
   ENTRY_DATE TEXT NOT NULL
);

-- create trigger
CREATE OR REPLACE FUNCTION auditlog() RETURNS TRIGGER AS $$
BEGIN
   INSERT INTO AUDIT(EMP_ID, ENTRY_DATE) VALUES (NEW.ID, current_timestamp);
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- bind trigger
CREATE TRIGGER example_trigger AFTER
INSERT ON COMPANY
FOR EACH ROW EXECUTE FUNCTION auditlog();

-- insert data and verify that trigegr working
INSERT INTO COMPANY (ID, NAME, AGE, ADDRESS, SALARY)
VALUES (1, 'Raju', 25, 'New-Delhi', 33000.00 );

SELECT * FROM COMPANY;

select * from audit


-- windows function
CREATE TABLE product_groups (
	group_id serial PRIMARY KEY,
	group_name VARCHAR (255) NOT NULL
);

CREATE TABLE products (
	product_id serial PRIMARY KEY,
	product_name VARCHAR (255) NOT NULL,
	price DECIMAL (11, 2),
	group_id INT NOT NULL,
	FOREIGN KEY (group_id) REFERENCES product_groups (group_id)
);

INSERT INTO product_groups (group_name)
VALUES
	('Smartphone'),
	('Laptop'),
	('Tablet');

INSERT INTO products (product_name, group_id,price)
VALUES
	('Microsoft Lumia', 1, 200),
	('HTC One', 1, 400),
	('Nexus', 1, 500),
	('iPhone', 1, 900),
	('HP Elite', 2, 1200),
	('Lenovo Thinkpad', 2, 700),
	('Sony VAIO', 2, 700),
	('Dell Vostro', 2, 800),
	('iPad', 3, 700),
	('Kindle Fire', 3, 150),
	('Samsung Galaxy Tab', 3, 200);

-- test use aggregate function
SELECT
	AVG (price)
FROM
	products;


-- inner join
SELECT
	group_name,
	AVG (price)
FROM
	products
INNER JOIN product_groups USING (group_id)
GROUP BY
	group_name;


-- use partition
-- in this query avg works as window function
SELECT
	product_name,
	price,
	group_name,
	AVG (price) OVER (
	   PARTITION BY group_name
	)
FROM
	products
	INNER JOIN 
		product_groups USING (group_id);


-- use row number
SELECT
	product_name,
	group_name,
	price,
	ROW_NUMBER () OVER (
		PARTITION BY group_name
		ORDER BY
			price
	)
FROM
	products
INNER JOIN product_groups USING (group_id);


-- rank
SELECT
	product_name,
	group_name,
  price,
	RANK () OVER (
		PARTITION BY group_name
		ORDER BY
			price
	)
FROM
	products
INNER JOIN product_groups USING (group_id);


-- dense rank
SELECT
	product_name,
	group_name,
	price,
	DENSE_RANK () OVER (
		PARTITION BY group_name
		ORDER BY
			price
	)
FROM
	products
INNER JOIN product_groups USING (group_id);


-- first value
SELECT
	product_name,
	group_name,
	price,
	FIRST_VALUE (price) OVER (
		PARTITION BY group_name
		ORDER BY
			price
	) AS lowest_price_per_group
FROM
	products
INNER JOIN product_groups USING (group_id);


-- last value
SELECT
	product_name,
	group_name,
	price,
	LAST_VALUE (price) OVER (
		PARTITION BY group_name
		ORDER BY
			price RANGE BETWEEN UNBOUNDED PRECEDING
		AND UNBOUNDED FOLLOWING
	) AS highest_price_per_group
FROM
	products
INNER JOIN product_groups USING (group_id);


-- lag, access previous row
SELECT
	product_name,
	group_name,
	price,
	LAG (price, 1) OVER (
		PARTITION BY group_name
		ORDER BY
			price
	) AS prev_price,
	price - LAG (price, 1) OVER (
		PARTITION BY group_name
		ORDER BY
			price
	) AS cur_prev_diff
FROM
	products
INNER JOIN product_groups USING (group_id);


--lead accest next row
SELECT
	product_name,
	group_name,
	price,
	LEAD (price, 1) OVER (
		PARTITION BY group_name
		ORDER BY
			price
	) AS next_price,
	price - LEAD (price, 1) OVER (
		PARTITION BY group_name
		ORDER BY
			price
	) AS cur_next_diff
FROM
	products
INNER JOIN product_groups USING (group_id);


-- cume_dist example
CREATE TABLE sales_stats(
    name VARCHAR(100) NOT NULL,
    year SMALLINT NOT NULL CHECK (year > 0),
    amount DECIMAL(10,2) CHECK (amount >= 0),
    PRIMARY KEY (name,year)
);


INSERT INTO 
    sales_stats(name, year, amount)
VALUES
    ('John Doe',2018,120000),
    ('Jane Doe',2018,110000),
    ('Jack Daniel',2018,150000),
    ('Yin Yang',2018,30000),
    ('Stephane Heady',2018,200000),
    ('John Doe',2019,150000),
    ('Jane Doe',2019,130000),
    ('Jack Daniel',2019,180000),
    ('Yin Yang',2019,25000),
    ('Stephane Heady',2019,270000);


-- using cume_dist() over a result set example
SELECT 
    name,
    year, 
    amount,
    CUME_DIST() OVER (
        ORDER BY amount
    ) 
FROM 
    sales_stats
WHERE 
    year = 2018;


-- cume_dist over partition
SELECT 
    name,
	year,
	amount,
    CUME_DIST() OVER (
		PARTITION BY year
        ORDER BY amount
    )
FROM 
    sales_stats;


-- dense_rank()
CREATE TABLE dense_ranks ( c VARCHAR(10));

INSERT INTO dense_ranks(c)
VALUES('A'),('A'),('B'),('C'),('C'),('D'),('E');

SELECT c from dense_ranks;

SELECT
	c,
	DENSE_RANK() OVER (
		ORDER BY c
	) dense_rank_number
FROM
	dense_ranks;


-- dense rank over a result set
SELECT
	product_id,
	product_name,
	price,
	DENSE_RANK () OVER ( 
		ORDER BY price DESC
	) price_rank 
FROM
	products;


-- dense rank over partition
SELECT
	product_id,
	product_name,
	group_id,
	price,
	DENSE_RANK () OVER ( 
		PARTITION BY group_id
		ORDER BY price DESC
	) price_rank 
FROM
	products;


--dense_rank() with cte
WITH cte AS(
	SELECT
		product_id,
		product_name,
		group_id,
		price,
		DENSE_RANK () OVER ( 
			PARTITION BY group_id
			ORDER BY price DESC
		) price_rank 
	FROM
		products
) 
SELECT 
	product_id, 
	product_name, 
	price
FROM 
	cte
WHERE 
	price_rank = 1;


--lead
CREATE TABLE sales(
	year SMALLINT CHECK(year > 0),
	group_id INT NOT NULL,
	amount DECIMAL(10,2) NOT NULL,
	PRIMARY KEY(year,group_id)
);

INSERT INTO 
	sales(year, group_id, amount) 
VALUES
	(2018,1,1474),
	(2018,2,1787),
	(2018,3,1760),
	(2019,1,1915),
	(2019,2,1911),
	(2019,3,1118),
	(2020,1,1646),
	(2020,2,1975),
	(2020,3,1516);

SELECT * FROM sales;

SELECT 
	year, 
	SUM(amount)
FROM sales
GROUP BY year
ORDER BY year;


WITH cte AS (
	SELECT 
		year, 
		SUM(amount) amount
	FROM sales
	GROUP BY year
	ORDER BY year
) 
SELECT
	year, 
	amount,
	LEAD(amount,1) OVER (
		ORDER BY year
	) next_year_sales
FROM
	cte;

--cte 2
WITH cte AS (
	SELECT 
		year, 
		SUM(amount) amount
	FROM sales
	GROUP BY year
	ORDER BY year
), cte2 AS (
	SELECT
		year, 
		amount,
		LEAD(amount,1) OVER (
			ORDER BY year
		) next_year_sales
	FROM
		cte
)	
SELECT 
	year, 
	amount, 
	next_year_sales,  
	(next_year_sales - amount) variance
FROM 
	cte2;


-- ntile
SELECT 
	year,
	name,
	amount
FROM 
	actual_sales
ORDER BY 
	year, name;

CREATE TABLE actual_sales(
    name VARCHAR(100) NOT NULL,
    year SMALLINT NOT NULL CHECK (year > 0),
    amount DECIMAL(10,2) CHECK (amount >= 0),
    PRIMARY KEY (name,year)
);


INSERT INTO 
    actual_sales(name, year, amount)
VALUES
    ('John Doe',2018,120000),
    ('Jane Doe',2018,110000),
    ('Jack Daniel',2018,150000),
    ('Yin Yang',2018,30000),
    ('Stephane Heady',2018,200000),
    ('John Doe',2019,150000),
    ('Jane Doe',2019,130000),
    ('Jack Daniel',2019,180000),
    ('Yin Yang',2019,25000),
    ('Stephane Heady',2019,270000);



SELECT 
	name,
	amount,
	NTILE(3) OVER(
		ORDER BY amount
	)
FROM
	sales_stats
WHERE
	year = 2019;


-- ntile over partition
SELECT 
	name,
	amount,
	NTILE(3) OVER(
		PARTITION BY year
		ORDER BY amount
	)
FROM
	sales_stats;


-- nth_value()
SELECT 
    product_id,
    product_name,
    price,
    NTH_VALUE(product_name, 2) 
    OVER(
        ORDER BY price DESC
        RANGE BETWEEN 
            UNBOUNDED PRECEDING AND 
            UNBOUNDED FOLLOWING
    )
FROM 
    products;


--nth_value() over partition
SELECT 
    product_id,
    product_name,
    price,
    group_id,
    NTH_VALUE(product_name, 2) 
    OVER(
        PARTITION BY group_id
        ORDER BY price DESC
        RANGE BETWEEN 
            UNBOUNDED PRECEDING AND 
            UNBOUNDED FOLLOWING
    )
FROM 
    products;

-- date trunc
SELECT DATE_TRUNC('hour', TIMESTAMP '2017-03-17 02:09:30');

SELECT DATE_TRUNC('month', rental_date) m,
       COUNT (rental_id)
FROM rental
GROUP BY m
ORDER BY m;


SELECT staff_id,
       date_trunc('year', rental_date) y,
       COUNT (rental_id) rental
FROM rental
GROUP BY staff_id,
         y
ORDER BY staff_id;


--generate series
SELECT generate_series(1,5);

SELECT generate_series(1,10,2);


SELECT *
FROM generate_series( '2024-03-29 00:00:00'::timestamp, '2024-03-29 23:00:00'::timestamp, '1 hour'::interval);


SET TIME ZONE 'UTC';

--1 day interval
SELECT *
FROM generate_series( '2024-11-02 00:00 -04:00'::timestamptz, '2024-11-05 00:00 -05:00'::timestamptz, '1 day'::interval, 'America/New_York');

SELECT floor(random()* (200-100+ 1) + 100) rand
FROM generate_series(1,5);


--generate test data
CREATE TABLE employees(
   id INT GENERATED ALWAYS AS IDENTITY,
   name VARCHAR(100) NOT NULL,
   age INT NOT NULL DEFAULT 0 CHECK (age >= 18 and age <=65)
);



INSERT INTO employees(name, age)
SELECT 'employee ' || n name,
       floor(random()* (65-18+ 1) + 18) age
FROM generate_series(1,100) n RETURNING *;


select * from employees


--create date table in analystics application
CREATE TABLE dates(
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    date DATE NOT NULL UNIQUE,
    month INT NOT NULL GENERATED ALWAYS AS (EXTRACT(month FROM date)) STORED,
    month_name VARCHAR(20) GENERATED ALWAYS AS (
        CASE EXTRACT(month FROM date)
            WHEN 1 THEN 'January'
            WHEN 2 THEN 'February'
            WHEN 3 THEN 'March'
            WHEN 4 THEN 'April'
            WHEN 5 THEN 'May'
            WHEN 6 THEN 'June'
            WHEN 7 THEN 'July'
            WHEN 8 THEN 'August'
            WHEN 9 THEN 'September'
            WHEN 10 THEN 'October'
            WHEN 11 THEN 'November'
            WHEN 12 THEN 'December'
        END
    ) STORED,
    quarter INT NOT NULL GENERATED ALWAYS AS ((EXTRACT(month FROM date) - 1) / 3 + 1) STORED,
    quarter_name CHAR(2) GENERATED ALWAYS AS (
        CASE 
            WHEN ((EXTRACT(month FROM date) - 1) / 3 + 1) = 1 THEN 'Q1'
            WHEN ((EXTRACT(month FROM date) - 1) / 3 + 1) = 2 THEN 'Q2'
            WHEN ((EXTRACT(month FROM date) - 1) / 3 + 1) = 3 THEN 'Q3'
            ELSE 'Q4'
        END
    ) STORED,
    year INT NOT NULL GENERATED ALWAYS AS (EXTRACT(year FROM date)) STORED
);


-- generate series dates
INSERT INTO dates(date)
SELECT * FROM generate_series(
    '2024-01-01'::date, 
    '2024-12-31'::date, 
    '1 day'::interval
)
RETURNING *;