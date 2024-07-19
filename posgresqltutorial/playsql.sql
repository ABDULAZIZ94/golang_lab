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

CREATE TABLE IF NOT EXISTS address (
    id SERIAL PRIMARY KEY,
    street VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50),
    postal_code VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS family (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    relation VARCHAR(50) NOT NULL,
    age INT
);

CREATE TABLE IF NOT EXISTS jobs (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    company VARCHAR(100) NOT NULL,
    salary DECIMAL(10, 2)
);





SELECT * FROM users




