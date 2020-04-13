
INSERT OR REPLACE INTO BuildingClasses
		(Type,												Description,	DefaultBuilding)
SELECT	'BUILDINGCLASS_SENSHI_ZANZIBAR_UB_DUMMY_'||Type,	Description,	'BUILDING_SENSHI_ZANZIBAR_UB_DUMMY_'||Type
FROM Resources WHERE Happiness > 0;

INSERT OR REPLACE INTO Buildings
		(BuildingClass,										Description,	Type,											Cost,	FaithCost,	GreatWorkCount,	PrereqTech,	NukeImmune,	NeverCapture,	IconAtlas,	PortraitIndex)
SELECT	'BUILDINGCLASS_SENSHI_ZANZIBAR_UB_DUMMY_'||Type,	Description,	'BUILDING_SENSHI_ZANZIBAR_UB_DUMMY_'||Type,		-1,		-1,			-1,				NULL,		1,			1,				IconAtlas,	PortraitIndex
FROM Resources WHERE Happiness > 0;

INSERT OR REPLACE INTO Building_ResourceYieldChanges
		(BuildingType,								ResourceType,	YieldType,			Yield)
SELECT	'BUILDING_SENSHI_ZANZIBAR_UB_DUMMY_'||Type,	Type,			'YIELD_PRODUCTION',	1
FROM Resources WHERE Happiness > 0;

CREATE TRIGGER IF NOT EXISTS C15_Senshi_Zanzibar_NewResource
AFTER INSERT ON Resources
WHEN NEW.Happiness > 0
BEGIN
	INSERT OR REPLACE INTO BuildingClasses
			(Type,													Description,		DefaultBuilding)
	VALUES	('BUILDINGCLASS_SENSHI_ZANZIBAR_UB_DUMMY_'||NEW.Type,	NEW.Description,	'BUILDING_SENSHI_ZANZIBAR_UB_DUMMY_'||NEW.Type);
	
	INSERT OR REPLACE INTO Buildings
			(BuildingClass,											Description,		Type,												Cost,	FaithCost,	GreatWorkCount,	PrereqTech,	NukeImmune,	NeverCapture,	IconAtlas,		PortraitIndex)
	VALUES	('BUILDINGCLASS_SENSHI_ZANZIBAR_UB_DUMMY_'||NEW.Type,	NEW.Description,	'BUILDING_SENSHI_ZANZIBAR_UB_DUMMY_'||NEW.Type,		-1,		-1,			-1,				NULL,		1,			1,				NEW.IconAtlas,	NEW.PortraitIndex);
END;

CREATE TRIGGER IF NOT EXISTS C15_Senshi_Zanzibar_NewResourceUpdate
AFTER UPDATE ON Resources
WHEN NEW.Happiness > 0 AND OLD.Happiness = 0
BEGIN
	INSERT OR REPLACE INTO BuildingClasses
			(Type,													Description,		DefaultBuilding)
	VALUES	('BUILDINGCLASS_SENSHI_ZANZIBAR_UB_DUMMY_'||NEW.Type,	NEW.Description,	'BUILDING_SENSHI_ZANZIBAR_UB_DUMMY_'||NEW.Type);
	
	INSERT OR REPLACE INTO Buildings
			(BuildingClass,											Description,		Type,												Cost,	FaithCost,	GreatWorkCount,	PrereqTech,	NukeImmune,	NeverCapture,	IconAtlas,		PortraitIndex)
	VALUES	('BUILDINGCLASS_SENSHI_ZANZIBAR_UB_DUMMY_'||NEW.Type,	NEW.Description,	'BUILDING_SENSHI_ZANZIBAR_UB_DUMMY_'||NEW.Type,		-1,		-1,			-1,				NULL,		1,			1,				NEW.IconAtlas,	NEW.PortraitIndex);
END;

-- Delete shouldn't be necessary

INSERT INTO BuildingClasses 	
		(Type, 						 		DefaultBuilding, 				Description)
VALUES	('BUILDINGCLASS_SENSHI_ZANZIBAR', 		'BUILDING_SENSHI_ZANZIBAR_HAPPINESS',	'TXT_KEY_TRAIT_SENSHI_ZANZIBAR_SHORT');

INSERT INTO Buildings 		
		(Type, 						 			BuildingClass, 					SpecialistCount, SpecialistType,		UnmoddedHappiness, PrereqTech, Cost, FaithCost, GreatWorkCount,	GoldMaintenance, MinAreaSize,	NeverCapture,	Description, 									Help, 												Strategy,										Civilopedia, 							ArtDefineTag, PortraitIndex, IconAtlas)
VALUES	('BUILDING_SENSHI_ZANZIBAR_HAPPINESS', 			'BUILDINGCLASS_SENSHI_ZANZIBAR',	0,				 null,					1,						null,		 -1,   -1,		  -1,				0,				 0,				1,				'TXT_KEY_TRAIT_SENSHI_ZANZIBAR_SHORT',			'TXT_KEY_TRAIT_SENSHI_ZANZIBAR',			null,											null,									null,		  0, 			 'SENSHI_ZANZIBAR_ATLAS'),
		('BUILDING_SENSHI_ZANZIBAR_SCIENCE', 			'BUILDINGCLASS_SENSHI_ZANZIBAR',	0,				 null,					0,						null,		 -1,   -1,		  -1,				0,				 0,				1,				'TXT_KEY_TRAIT_SENSHI_ZANZIBAR_SHORT',			'TXT_KEY_TRAIT_SENSHI_ZANZIBAR',			null,											null,									null,		  0, 			 'SENSHI_ZANZIBAR_ATLAS'),
		('BUILDING_SENSHI_ZANZIBAR_SCIENCEMOD', 			'BUILDINGCLASS_SENSHI_ZANZIBAR',	0,				 null,					0,						null,		 -1,   -1,		  -1,				0,				 0,				1,				'TXT_KEY_TRAIT_SENSHI_ZANZIBAR_SHORT',			'TXT_KEY_TRAIT_SENSHI_ZANZIBAR',			null,											null,									null,		  0, 			 'SENSHI_ZANZIBAR_ATLAS');

INSERT INTO Building_YieldChanges 	
		(BuildingType, 						 	YieldType, 	Yield)
VALUES	('BUILDING_SENSHI_ZANZIBAR_SCIENCE', 	'YIELD_SCIENCE',	1);

INSERT INTO Building_YieldModifiers 	
		(BuildingType, 						 	YieldType, 	Yield)
VALUES	('BUILDING_SENSHI_ZANZIBAR_SCIENCEMOD', 	'YIELD_SCIENCE',	5);