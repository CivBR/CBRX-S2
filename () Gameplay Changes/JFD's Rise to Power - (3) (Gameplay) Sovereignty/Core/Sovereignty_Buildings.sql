--==========================================================================================================================
-- BUILDINGS
--==========================================================================================================================
------------------------------------------------------------------------------------------------------------------------
-- BuildingClasses
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO BuildingClasses 
		(Type,									DefaultBuilding,					Description,								MaxPlayerInstances,		MaxGlobalInstances)
VALUES	('BUILDINGCLASS_JFD_CHANCERY', 			'BUILDING_JFD_CHANCERY',			'TXT_KEY_BUILDING_JFD_CHANCERY',			-1,						-1),
		('BUILDINGCLASS_JFD_HIGH_COURT',		'BUILDING_JFD_HIGH_COURT',			'TXT_KEY_BUILDING_JFD_HIGH_COURT',			-1,						-1),
		('BUILDINGCLASS_JFD_MAGISTRATE_COURT',	'BUILDING_JFD_MAGISTRATE_COURT',	'TXT_KEY_BUILDING_JFD_MAGISTRATE_COURT',	-1,						-1);

INSERT INTO BuildingClasses 
		(Type,									DefaultBuilding,					Description,								MaxPlayerInstances,		MaxGlobalInstances)
VALUES	('BUILDINGCLASS_JFD_COURT_CHANCERY',	'BUILDING_JFD_COURT_CHANCERY',		'TXT_KEY_BUILDING_JFD_COURT_CHANCERY', 		1,						-1),
		('BUILDINGCLASS_JFD_SUPREME_COURT',		'BUILDING_JFD_SUPREME_COURT',		'TXT_KEY_BUILDING_JFD_SUPREME_COURT',		1,						-1);

UPDATE BuildingClasses
SET MaxPlayerInstances = -1
WHERE Type = 'BUILDINGCLASS_DECISIONS_NATIONALCOURT';
--------------------------------------------------------------------------------------------------------------------------
-- Buildings
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Buildings
		(Type, 								Cost, 	SovereigntyChangeAllCities,		FaithCost, 	GoldMaintenance,	Espionage,	EspionageModifier,	PrereqTech,					BuildingClass, 							Description, 								Help,											Strategy,											Civilopedia,									MinAreaSize,	HurryCostModifier,	NumCityCostMod,	ConquestProb,	NukeImmune, NeverCapture,	IconAtlas,							PortraitIndex)
VALUES	('BUILDING_JFD_CHANCERY',			160,	0,								-1,			2,					0,			0,					'TECH_JFD_NOBILITY',		'BUILDINGCLASS_JFD_CHANCERY',			'TXT_KEY_BUILDING_JFD_CHANCERY',			'TXT_KEY_BUILDING_JFD_CHANCERY_HELP',			'TXT_KEY_BUILDING_JFD_CHANCERY_STRATEGY',			'TXT_KEY_BUILDING_JFD_CHANCERY_TEXT',			-1,				25,					0,				30,				0,			0,				'TECH_ATLAS_1',						47),
		('BUILDING_JFD_HIGH_COURT',			160,	15,								-1,			2,					0,			0,					'TECH_JFD_JURISPRUDENCE',	'BUILDINGCLASS_JFD_HIGH_COURT',			'TXT_KEY_BUILDING_JFD_HIGH_COURT',			'TXT_KEY_BUILDING_JFD_HIGH_COURT_HELP',			'TXT_KEY_BUILDING_JFD_HIGH_COURT_STRATEGY',			'TXT_KEY_BUILDING_JFD_HIGH_COURT_TEXT',			-1,				25,					0,				30,				0,			0,				'JFD_SOVEREIGNTY_BUILDING_ATLAS',	1),
		('BUILDING_JFD_MAGISTRATE_COURT',	80,		10,								-1,			1,					0,			0,					'TECH_JFD_CODE_OF_LAWS',	'BUILDINGCLASS_JFD_MAGISTRATE_COURT',	'TXT_KEY_BUILDING_JFD_MAGISTRATE_COURT',	'TXT_KEY_BUILDING_JFD_MAGISTRATE_COURT_HELP',	'TXT_KEY_BUILDING_JFD_MAGISTRATE_COURT_STRATEGY',	'TXT_KEY_BUILDING_JFD_MAGISTRATE_COURT_TEXT',	-1,				25,					0,				30,				0,			0,				'JFD_SOVEREIGNTY_BUILDING_ATLAS',	0);
		
UPDATE Buildings
SET PrereqTech = 'TECH_JFD_JURISPRUDENCE'
WHERE BuildingClass = 'BUILDINGCLASS_CONSTABLE';

INSERT INTO Buildings
		(Type,								BuildingClass,							PrereqTech,					NumBonusReformCapacity,		Cost,	Description,								  Help, 											 Strategy, 												Civilopedia,										NumCityCostMod,	NukeImmune, HurryCostModifier,  MinAreaSize,	NeverCapture,	IconAtlas, 							PortraitIndex)
VALUES	('BUILDING_JFD_COURT_CHANCERY',		'BUILDINGCLASS_JFD_COURT_CHANCERY',		'TECH_JFD_NOBILITY',		1,							125,	'TXT_KEY_BUILDING_JFD_GRAND_COURT_CHANCERY',  'TXT_KEY_BUILDING_JFD_GRAND_COURT_CHANCERY_HELP',	 'TXT_KEY_BUILDING_JFD_GRAND_COURT_CHANCERY_STRATEGY',	'TXT_KEY_BUILDING_JFD_GRAND_COURT_CHANCERY_TEXT',	30,				1,			-1,					-1,				1,				'TECH_ATLAS_1',						26),
		('BUILDING_JFD_SUPREME_COURT',		'BUILDINGCLASS_JFD_SUPREME_COURT',		'TECH_JFD_JURISPRUDENCE',	1,							125,	'TXT_KEY_BUILDING_JFD_SUPREME_COURT',		  'TXT_KEY_BUILDING_JFD_SUPREME_COURT_HELP', 		 'TXT_KEY_BUILDING_JFD_SUPREME_COURT_STRATEGY',			'TXT_KEY_BUILDING_JFD_SUPREME_COURT_TEXT',			30,				1,			-1,					-1,				1,				'JFD_SOVEREIGNTY_BUILDING_ATLAS',	2);
------------------------------------------------------------------------------------------------------------------------
-- Building_ClassesNeededInCity
------------------------------------------------------------------------------------------------------------------------
INSERT INTO Building_ClassesNeededInCity 
		(BuildingType, 						BuildingClassType)
VALUES	('BUILDING_JFD_COURT_CHANCERY', 	'BUILDINGCLASS_JFD_CHANCERY'),
		('BUILDING_JFD_HIGH_COURT', 		'BUILDINGCLASS_JFD_MAGISTRATE_COURT'),
		('BUILDING_JFD_SUPREME_COURT',		'BUILDINGCLASS_JFD_HIGH_COURT');
------------------------------------------------------------------------------------------------------------------------
-- Building_PrereqBuildingClasses
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Building_PrereqBuildingClasses 
		(BuildingType, 						BuildingClassType,					NumBuildingNeeded)
VALUES	('BUILDING_JFD_COURT_CHANCERY',		'BUILDINGCLASS_JFD_CHANCERY',		-1),
		('BUILDING_JFD_SUPREME_COURT',		'BUILDINGCLASS_JFD_HIGH_COURT',		-1);
------------------------------------------------------------------------------------------------------------------------
-- Building_JFD_SovereigntyMods
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Building_JFD_SovereigntyMods 
		(BuildingType, 						GovernmentCooldownCityMod)
VALUES	('BUILDING_JFD_CHANCERY',			-15),
		('BUILDING_JFD_COURT_CHANCERY',		-25);
------------------------------------------------------------------------------------------------------------------------
-- Building_Flavors
------------------------------------------------------------------------------------------------------------------------
INSERT INTO Building_Flavors 
		(BuildingType, 						FlavorType,						Flavor)
VALUES	('BUILDING_JFD_CHANCERY',			'FLAVOR_CULTURE',				40),
		('BUILDING_JFD_COURT_CHANCERY',		'FLAVOR_WONDER',				10),
		('BUILDING_JFD_COURT_CHANCERY',		'FLAVOR_GREAT_PEOPLE',			20),
		('BUILDING_JFD_COURT_CHANCERY',		'FLAVOR_CULTURE',				40),
		('BUILDING_JFD_COURT_CHANCERY',		'FLAVOR_GROWTH',				5),
		('BUILDING_JFD_HIGH_COURT',			'FLAVOR_PRODUCTION',			50),
		('BUILDING_JFD_MAGISTRATE_COURT',	'FLAVOR_CULTURE',				40),
		('BUILDING_JFD_SUPREME_COURT',		'FLAVOR_WONDER',				10),
		('BUILDING_JFD_SUPREME_COURT',		'FLAVOR_GREAT_PEOPLE',			20),
		('BUILDING_JFD_SUPREME_COURT',		'FLAVOR_CULTURE',				40);
--==========================================================================================================================
--==========================================================================================================================