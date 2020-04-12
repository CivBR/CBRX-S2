--==========================================================================================================================
-- BUILDINGS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- BuildingClasses
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO BuildingClasses 
		(Type, 								  DefaultBuilding, 					Description, 							MaxGlobalInstances,  MaxPlayerInstances)
VALUES	('BUILDINGCLASS_JFD_WHITE_TOWER',	  'BUILDING_JFD_WHITE_TOWER',		'TXT_KEY_BUILDING_JFD_WHITE_TOWER', 	1,					 -1);
--------------------------------------------------------------------------------------------------------------------------
-- Civilization_BuildingClassOverrides
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Civilization_BuildingClassOverrides 
		(BuildingClassType, 					CivilizationType, 			BuildingType)
VALUES	('BUILDINGCLASS_JFD_WHITE_TOWER',		'CIVILIZATION_BARBARIAN', 	null),
		('BUILDINGCLASS_JFD_WHITE_TOWER',		'CIVILIZATION_MINOR', 		null);
--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- Buildings
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Buildings 						
		(Type, 							BuildingClass, 						Cost, 	TechEnhancedTourism,	EnhancedYieldTech,	FreeBuildingThisCity,		PrereqTech, 		MaxStartEra, 		PolicyBranchType,				Description, 							Help, 								 		Civilopedia, 						 		Quote,  									NukeImmune, HurryCostModifier,  MinAreaSize,	ConquestProb, 	ArtDefineTag,	IconAtlas, 						PortraitIndex, 	WonderSplashAudio,							WonderSplashImage, 			 WonderSplashAnchor)
VALUES	('BUILDING_JFD_WHITE_TOWER',	'BUILDINGCLASS_JFD_WHITE_TOWER',	500,	4,						'TECH_ELECTRICITY',	'BUILDINGCLASS_CONSTABLE',	'TECH_BANKING',		'ERA_INDUSTRIAL', 	'POLICY_BRANCH_JFD_INTRIGUE',	'TXT_KEY_BUILDING_JFD_WHITE_TOWER',		'TXT_KEY_WONDER_JFD_WHITE_TOWER_HELP',		'TXT_KEY_WONDER_JFD_WHITE_TOWER_PEDIA',		'TXT_KEY_WONDER_JFD_WHITE_TOWER_QUOTE',		1,			-1,					-1,				100,			null,			'JFD_INTRIGUE_WONDER_ATLAS',	0,				'AS2D_WONDER_SPEECH_JFD_WHITE_TOWER',		'Wonder_WhiteTower.dds',	 'R,B');	
--------------------------------------------------------------------------------------------------------------------------
-- Building_YieldChanges
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Building_YieldChanges 
		(BuildingType, 					YieldType,				Yield)
VALUES	('BUILDING_JFD_WHITE_TOWER', 	'YIELD_CULTURE',		1);
--------------------------------------------------------------------------------------------------------------------------
-- Building_BuildingClassYieldChanges
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Building_BuildingClassYieldChanges 
		(BuildingType, 					BuildingClassType,				YieldType,			YieldChange)
VALUES	('BUILDING_JFD_WHITE_TOWER', 	'BUILDINGCLASS_CONSTABLE',		'YIELD_PRODUCTION',	1),
		('BUILDING_JFD_WHITE_TOWER', 	'BUILDINGCLASS_CONSTABLE',		'YIELD_GOLD',		1),
		('BUILDING_JFD_WHITE_TOWER', 	'BUILDINGCLASS_POLICE_STATION',	'YIELD_PRODUCTION',	1),
		('BUILDING_JFD_WHITE_TOWER', 	'BUILDINGCLASS_POLICE_STATION',	'YIELD_GOLD',		1);
--------------------------------------------------------------------------------------------------------------------------
-- Building_Flavors
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Building_Flavors 
		(BuildingType, 					FlavorType,				Flavor)
VALUES	('BUILDING_JFD_WHITE_TOWER',	'FLAVOR_WONDER',		20),
		('BUILDING_JFD_WHITE_TOWER',	'FLAVOR_GREAT_PEOPLE',	10);
--==========================================================================================================================
--==========================================================================================================================


