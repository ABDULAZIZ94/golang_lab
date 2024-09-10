

select * from public.buildings

update public.buildings set carbon_formula_id = '0fa2d0f9-6f67-4746-6199-8eb1eec53b24'

--
SELECT "addresses"."id","addresses"."street","addresses"."poscode","addresses"."district","addresses"."state","addresses"."tenant_id","addresses"."building_id","addresses"."created_at","addresses"."updated_at","addresses"."deleted_at" FROM "addresses" join buildings on addresses.building_id = buildings.id  WHERE Buildings.tenant_id='e6daf318-6516-4350-6b56-ae0a44b7e5d7' AND "addresses"."deleted_at" IS NULL

-- building address
SELECT "addresses"."id", "addresses"."street", "addresses"."poscode", "addresses"."district", "addresses"."state", "addresses"."tenant_id", "addresses"."building_id", "addresses"."created_at", "addresses"."updated_at", "addresses"."deleted_at"
FROM "addresses"
    join buildings on addresses.building_id = buildings.id
WHERE
    buildings.tenant_id = 'e6daf318-6516-4350-6b56-ae0a44b7e5d7'
    AND "addresses"."deleted_at" IS NULL