
INSERT INTO Buildings
		(Type,					BuildingClass,		MaxStartEra,		Cost,	GoldMaintenance,	PrereqTech,	Description,	Civilopedia,	Strategy,	ArtDefineTag,	MinAreaSize,	ConquestProb,	HurryCostModifier,	IconAtlas,	PortraitIndex,	FreeStartEra)
SELECT	'BUILDING_MUSICTEMPLE',	BuildingClass,		MaxStartEra,		Cost,	GoldMaintenance,	PrereqTech,	Description,	Civilopedia,	Strategy,	ArtDefineTag,	MinAreaSize,	ConquestProb,	HurryCostModifier,	IconAtlas,	PortraitIndex,	FreeStartEra
FROM Buildings WHERE Type = 'BUILDING_TEMPLE';

INSERT INTO Buildings
		(Type,					BuildingClass,		MaxStartEra,		Cost,	GoldMaintenance,	PrereqTech,	Description,	Civilopedia,	Strategy,	ArtDefineTag,	MinAreaSize,	ConquestProb,	HurryCostModifier,	IconAtlas,	PortraitIndex)
SELECT	'BUILDING_MUSICSHRINE',	BuildingClass,		MaxStartEra,		Cost,	GoldMaintenance,	PrereqTech,	Description,	Civilopedia,	Strategy,	ArtDefineTag,	MinAreaSize,	ConquestProb,	HurryCostModifier,	IconAtlas,	PortraitIndex
FROM Buildings WHERE Type = 'BUILDING_SHRINE';

UPDATE Buildings SET GreatWorkSlotType = 'GREAT_WORK_SLOT_MUSIC', GreatWorkCount = 1 WHERE Type IN ('BUILDING_MUSICSHRINE', 'BUILDING_MUSICTEMPLE');

INSERT INTO Building_ClassesNeededInCity
		(BuildingType,			BuildingClassType)
SELECT	'BUILDING_MUSICTEMPLE',	BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_TEMPLE';

INSERT INTO Building_Flavors
		(BuildingType,			FlavorType,		Flavor)
SELECT	'BUILDING_MUSICTEMPLE',	FlavorType,		Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_TEMPLE';

INSERT INTO Building_Flavors
		(BuildingType,			FlavorType,		Flavor)
SELECT	'BUILDING_MUSICSHRINE',	FlavorType,		Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_SHRINE';

INSERT INTO Building_YieldChanges
		(BuildingType,			YieldType,		Yield)
SELECT	'BUILDING_MUSICTEMPLE',	YieldType,		Yield
FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_TEMPLE';

INSERT INTO Building_YieldChanges
		(BuildingType,			YieldType,		Yield)
SELECT	'BUILDING_MUSICSHRINE',	YieldType,		Yield
FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_SHRINE';

INSERT INTO BuildingClasses
		(Type,											DefaultBuilding,					Description)
VALUES	('BUILDINGCLASS_C15_DENE_POWWOW_COUNTER',		'BUILDING_C15_DENE_POWWOW_COUNTER',	'TXT_KEY_C15_DENE_POWWOW_COUNTER');

INSERT INTO Buildings
		(Type,									BuildingClass,								Description,						Cost,	FaithCost,	GreatWorkCount,		PrereqTech,		NeverCapture,	NukeImmune,		PortraitIndex,	IconAtlas)
VALUES	('BUILDING_C15_DENE_POWWOW_COUNTER',	'BUILDINGCLASS_C15_DENE_POWWOW_COUNTER',	'TXT_KEY_C15_DENE_POWWOW_COUNTER',	-1,		-1,			-1,					NULL,			1,				1,				19,				'BW_ATLAS_1');

INSERT INTO Language_en_US
		(Tag,								Text)
VALUES	('TXT_KEY_C15_DENE_POWWOW_COUNTER',	'Dene Pow Wow Turn Counter');