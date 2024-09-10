
SELECT "addresses"."id", "addresses"."street", "addresses"."poscode", "addresses"."district", 
"addresses"."state", "addresses"."tenant_id", "addresses"."building_id", "addresses"."created_at", 
"addresses"."updated_at", "addresses"."deleted_at"
FROM "addresses"
    join buildings on addresses.building_id = buildings.id
WHERE
    Buildings.tenant_id = 'e6daf318-6516-4350-6b56-ae0a44b7e5d7'
    AND "addresses"."deleted_at" IS NULL

--
select * from public.addresses

select * from public.buildings