-- Active: 1722832765629@@alpha.vectolabs.com@9998@energy-staging

# meter constraint
alter table building_meter_pairs
add constraint building_meter_pairs_meters_constraint
foreign key(meter_id)
references meters(id);

# db consraint
alter table building_meter_pairs
add constraint building_meter_pairs_buildings_constraint 
foreign key (building_id) references buildings(id);

