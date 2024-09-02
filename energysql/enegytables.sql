-- Active: 1722832765629@@alpha.vectolabs.com@9998@energy-staging

-- This script assumes you're using a PostgreSQL database.
DO $$
DECLARE
    rec RECORD;
    q text;
BEGIN
    -- Loop through all tables in the current schema
    FOR rec IN
        SELECT table_name
        FROM information_schema.tables
        WHERE table_schema = 'public'  -- Adjust schema as needed
          AND table_type = 'BASE TABLE'
    LOOP
        --  q := format('UPDATE %I SET created_at = CURRENT_TIMESTAMP WHERE created_at IS NULL', rec.table_name);
        
        -- EXECUTE q;

        RAISE NOTICE 'UPDATE % SET created_at = CURRENT_TIMESTAMP WHERE created_at IS NULL;', rec.table_name;
    END LOOP;
END $$;


SELECT table_name
FROM information_schema.tables
WHERE
    table_schema = 'public' -- Adjust schema as needed
    AND table_type = 'BASE TABLE'

SELECT *
FROM information_schema.tables



-- manual
UPDATE demos SET created_at = CURRENT_TIMESTAMP WHERE created_at IS NULL;
UPDATE tenants SET created_at = CURRENT_TIMESTAMP WHERE created_at IS NULL;
UPDATE user_types SET created_at = CURRENT_TIMESTAMP WHERE created_at IS NULL;
UPDATE access_levels SET created_at = CURRENT_TIMESTAMP WHERE created_at IS NULL;
UPDATE states SET created_at = CURRENT_TIMESTAMP WHERE created_at IS NULL;
UPDATE users SET created_at = CURRENT_TIMESTAMP WHERE created_at IS NULL;
UPDATE user_and_contractors SET created_at = CURRENT_TIMESTAMP WHERE created_at IS NULL;
UPDATE contractors SET created_at = CURRENT_TIMESTAMP WHERE created_at IS NULL;
UPDATE event_logs SET created_at = CURRENT_TIMESTAMP WHERE created_at IS NULL;
UPDATE logs_types SET created_at = CURRENT_TIMESTAMP WHERE created_at IS NULL;
UPDATE addresses SET created_at = CURRENT_TIMESTAMP WHERE created_at IS NULL;
UPDATE districts SET created_at = CURRENT_TIMESTAMP WHERE created_at IS NULL;
UPDATE buildings SET created_at = CURRENT_TIMESTAMP WHERE created_at IS NULL;
UPDATE rm_per_kilowatts SET created_at = CURRENT_TIMESTAMP WHERE created_at IS NULL;
UPDATE meters SET created_at = CURRENT_TIMESTAMP WHERE created_at IS NULL;
UPDATE tariffs SET created_at = CURRENT_TIMESTAMP WHERE created_at IS NULL;
UPDATE meter_pairs SET created_at = CURRENT_TIMESTAMP WHERE created_at IS NULL;
UPDATE distributed_boards SET created_at = CURRENT_TIMESTAMP WHERE created_at IS NULL;
UPDATE building_meter_pairs SET created_at = CURRENT_TIMESTAMP WHERE created_at IS NULL;
UPDATE floors SET created_at = CURRENT_TIMESTAMP WHERE created_at IS NULL;
UPDATE meter_distributed_board_pairs SET created_at = CURRENT_TIMESTAMP WHERE created_at IS NULL;


-- cehck tables

select * from tariffs

select * from public.meters

select * from public.buildings

select * from public.distributed_boards

select * from public.meter_pairs