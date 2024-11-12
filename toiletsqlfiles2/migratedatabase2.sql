-- Active: 1722832765629@@alpha.vectolabs.com@9998@smarttoilet


-- migrate mqtt users staging to prod
INSERT INTO
    mqtt_users (
        id,
        username,
        password_hash,
        salt,
        is_superuser,
        created,
        plaintext,
        tenant_id
    )
SELECT rt.*
FROM mqtt_users lt
    RIGHT JOIN (
        SELECT *
        FROM dblink (
                'host=alpha.vectolabs.com port=9998 dbname=smarttoilet-staging user=postgres password=VectoLabs)1', 'SELECT * from mqtt_users'
            ) AS remote_table (
                id integer, username text, password_hash text, salt text, is_superuser boolean, created timestamptz, plaintext text, tenant_id text
            )
    ) rt ON lt.id = rt.id
    OR lt.username = rt.username
WHERE
    lt.id IS NULL;