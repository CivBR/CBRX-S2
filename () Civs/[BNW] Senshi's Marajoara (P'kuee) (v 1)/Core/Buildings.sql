--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================	
-- Buildings
------------------------------	
INSERT INTO Buildings 	
		(Type, 						BuildingClass,	FreeStartEra,	Cost,	GoldMaintenance,	FoodKept,	ExtraCityHitPoints,	PrereqTech,	Description,								Civilopedia,								Help,											Strategy,							ArtDefineTag,	SpecialistType,	SpecialistCount,	MinAreaSize,	ConquestProb,	HurryCostModifier,		IconAtlas,				PortraitIndex)
SELECT	('BUILDING_SENSHI_TESO'),	BuildingClass,	FreeStartEra,	Cost,	0,					2,			5,					PrereqTech,	('TXT_KEY_BUILDING_SENSHI_TESO'),	('TXT_KEY_CIV5_BUILDING_SENSHI_TESO_TEXT'),	('TXT_KEY_BUILDING_SENSHI_TESO_HELP'),	('TXT_KEY_BUILDING_SENSHI_TESO_STRATEGY'),	ArtDefineTag,	SpecialistType,	SpecialistCount,	MinAreaSize,	0,				HurryCostModifier,		'SENSHI_MARAJO_ATLAS',	3
FROM Buildings WHERE (Type = 'BUILDING_SHRINE');
------------------------------	
-- Building_Flavors
------------------------------		
INSERT INTO Building_Flavors 	
		(BuildingType, 					FlavorType,			Flavor)
SELECT	('BUILDING_SENSHI_TESO'),	FlavorType,			Flavor
FROM Building_Flavors WHERE (BuildingType = 'BUILDING_SHRINE');
------------------------------	
-- Building_YieldChanges
------------------------------		
INSERT INTO Building_YieldChanges 	
		(BuildingType, 					YieldType,		Yield)
SELECT	('BUILDING_SENSHI_TESO'),	YieldType,		Yield
FROM Building_YieldChanges WHERE (BuildingType = 'BUILDING_SHRINE');


INSERT INTO BuildingClasses 	
		(Type, 						 		DefaultBuilding, 				Description)
VALUES	('BUILDINGCLASS_SENSHI_TESO_INFINITE', 		'BUILDING_SENSHI_TESO_INFINITE',	'TXT_KEY_BUILDING_SENSHI_TESO');

INSERT INTO Buildings 	
		(Type, 						BuildingClass,	Cost,	FaithCost, GreatWorkCount, GoldMaintenance,	FoodKept,	ExtraCityHitPoints,	PrereqTech,	Description,								Civilopedia,								Help,											Strategy,							ArtDefineTag,	SpecialistType,	SpecialistCount,	MinAreaSize,	ConquestProb,	HurryCostModifier,		IconAtlas,				PortraitIndex)
SELECT	('BUILDING_SENSHI_TESO_INFINITE'),	('BUILDINGCLASS_SENSHI_TESO_INFINITE'),	-1,	-1, -1, 0,					2,			5,					null,	('TXT_KEY_BUILDING_SENSHI_TESO'),	('TXT_KEY_CIV5_BUILDING_SENSHI_TESO_TEXT'),	('TXT_KEY_BUILDING_SENSHI_TESO_HELP'),	('TXT_KEY_BUILDING_SENSHI_TESO_STRATEGY'),	ArtDefineTag,	SpecialistType,	SpecialistCount,	MinAreaSize,	0,				HurryCostModifier,		'SENSHI_MARAJO_ATLAS',	3
FROM Buildings WHERE (Type = 'BUILDING_SHRINE');
	
INSERT INTO Building_YieldChanges 	
		(BuildingType, 						YieldType,		Yield)
SELECT	('BUILDING_SENSHI_TESO_INFINITE'),	YieldType,		Yield
FROM Building_YieldChanges WHERE (BuildingType = 'BUILDING_SHRINE');


INSERT INTO BuildingClasses
(Type, DefaultBuilding, Description)
SELECT 'BUILDINGCLASS_SENSHI_TESO_'||e.Type, 'BUILDING_SENSHI_TESO_'||e.Type, 'TXT_KEY_BUILDING_SENSHI_TESO'
FROM Eras WHERE NOT (Type = 'ERA_ANCIENT');

INSERT INTO Buildings
(Type,                                 BuildingClass,       Cost, Espionage, EspionageModifier, SpecialistType, SpecialistCount, GoldMaintenance, PrereqTech,    Description,            Help,                                     Civilopedia,      Strategy,      ArtDefineTag, MinAreaSize, NeverCapture, Espionage, EspionageModifier, HurryCostModifier, PortraitIndex, IconAtlas)
SELECT 'BUILDING_SENSHI_TESO_'||e.Type,    'BUILDINGCLASS_SENSHI_TESO_'||e.Type, b.Cost, b.Espionage, b.EspionageModifier, b.SpecialistType, b.SpecialistCount, b.GoldMaintenance,  b.PrereqTech,   b.Description,  b.Help,    b.Civilopedia,    b.Strategy,    b.ArtDefineTag, b.MinAreaSize, b.NeverCapture, b.Espionage, b.EspionageModifier, b.HurryCostModifier, b.PortraitIndex, b.IconAtlas
FROM Eras e, Buildings b WHERE (b.Type = 'BUILDING_SENSHI_TESO') AND NOT (e.Type = 'ERA_ANCIENT');

INSERT INTO Building_Flavors
(BuildingType, FlavorType, Flavor)
SELECT 'BUILDING_SENSHI_TESO_'||e.Type, b.FlavorType, b.Flavor
FROM Eras e, Building_Flavors b WHERE (b.BuildingType = 'BUILDING_SENSHI_TESO') AND NOT (e.Type = 'ERA_ANCIENT');

INSERT INTO Building_YieldChanges
(BuildingType, YieldType, Yield)
SELECT 'BUILDING_SENSHI_TESO_'||e.Type, b.YieldType, b.Yield
FROM Eras e, Building_YieldChanges b WHERE (b.BuildingType = 'BUILDING_SENSHI_TESO') AND NOT (e.Type = 'ERA_ANCIENT');

-- beginning of trigger; keep the rest of this file together
CREATE TRIGGER IF NOT EXISTS Senshi_NewEraTesoInsert
AFTER INSERT ON Eras
BEGIN
INSERT INTO BuildingClasses
(Type,	DefaultBuilding,	Description)
VALUES ('BUILDINGCLASS_SENSHI_TESO_'||NEW.Type, 'BUILDING_SENSHI_TESO_'||NEW.Type, 'TXT_KEY_BUILDING_SENSHI_TESO');

INSERT INTO Buildings
(Type,                                 BuildingClass,       Cost, Espionage, EspionageModifier, SpecialistType, SpecialistCount, GoldMaintenance, PrereqTech,    Description,            Help,                                     Civilopedia,      Strategy,      ArtDefineTag, MinAreaSize, NeverCapture, Espionage, EspionageModifier, HurryCostModifier, PortraitIndex, IconAtlas)
SELECT 'BUILDING_SENSHI_TESO_'||NEW.Type,    'BUILDINGCLASS_SENSHI_TESO_'||NEW.Type, Cost, Espionage, EspionageModifier, SpecialistType, SpecialistCount, GoldMaintenance,  PrereqTech,   Description,  Help,    Civilopedia,    Strategy,    ArtDefineTag, MinAreaSize, NeverCapture, Espionage, EspionageModifier, HurryCostModifier, PortaitIndex, IconAtlas
FROM Buildings WHERE (Type = 'BUILDING_SENSHI_TESO');

INSERT INTO Building_Flavors
(BuildingType, FlavorType, Flavor)
SELECT 'BUILDING_SENSHI_TESO_'||NEW.Type, FlavorType, Flavor
FROM Building_Flavors WHERE (BuildingType = 'BUILDING_SENSHI_TESO');

INSERT INTO Building_YieldChanges
(BuildingType, YieldType, Yield)
SELECT 'BUILDING_SENSHI_TESO_'||NEW.Type, YieldType, Yield
FROM Building_YieldChanges WHERE (BuildingType = 'BUILDING_SENSHI_TESO');
END;
