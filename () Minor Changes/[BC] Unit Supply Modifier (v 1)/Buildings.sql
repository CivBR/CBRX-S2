INSERT INTO Buildings
		(Type,									BuildingClass,	Cost,	GoldMaintenance,MinAreaSize,	NeverCapture,	HurryCostModifier,	PortraitIndex,	IconAtlas)
SELECT ('BUILDING_LIME_PRODUCTION_DEBUFF_LAND', BuildingClass, 	-1, 	0, 				MinAreaSize, 	1, 				0, 					PortraitIndex, IconAtlas)
FROM Buildings WHERE Type = 'BUILDING_COURTHOUSE';
	
INSERT INTO Buildings
		(Type,									BuildingClass,	Cost,	GoldMaintenance,MinAreaSize,	NeverCapture,	HurryCostModifier,	PortraitIndex,	IconAtlas)
SELECT ('BUILDING_LIME_PRODUCTION_DEBUFF_SEA', BuildingClass, 	-1, 	0, 				MinAreaSize, 	1, 				0, 					PortraitIndex, IconAtlas)
FROM Buildings WHERE Type = 'BUILDING_COURTHOUSE';

INSERT INTO Building_DomainProductionModifiers
		(BuildingType, 								DomainType, 	Modifier)
VALUES 	('BUILDING_LIME_PRODUCTION_DEBUFF_LAND', 	'DOMAIN_LAND', 	-1),
		('BUILDING_LIME_PRODUCTION_DEBUFF_SEA', 	'DOMAIN_SEA', 	-1);