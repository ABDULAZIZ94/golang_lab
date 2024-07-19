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