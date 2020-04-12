--==========================================================================================================================
-- BUILDINGS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- BuildingClasses
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO BuildingClasses 
		(Type, 								  DefaultBuilding, 					Description, 							MaxGlobalInstances,  MaxPlayerInstances)
VALUES	('BUILDINGCLASS_JFD_PANAMA_CANAL',	  'BUILDING_JFD_PANAMA_CANAL',		'TXT_KEY_BUILDING_JFD_PANAMA_CANAL', 	1,					 -1);
--------------------------------------------------------------------------------------------------------------------------
-- Civilization_BuildingClassOverrides
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Civilization_BuildingClassOverrides 
		(BuildingClassType, 					CivilizationType, 			BuildingType)
VALUES	('BUILDINGCLASS_JFD_PANAMA_CANAL',		'CIVILIZATION_BARBARIAN', 	null),
		('BUILDINGCLASS_JFD_PANAMA_CANAL',		'CIVILIZATION_MINOR', 		null);
--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- Buildings
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Buildings 						
		(Type, 								BuildingClass, 						CityConnectionTradeRouteModifier,	FreeBuildingThisCity,	Cost, 	PrereqTech, 		MaxStartEra, 		SpecialistType,			GreatPeopleRateChange,  Water,	PolicyBranchType,					Description, 							Help, 								 		Civilopedia, 						 		Quote,  									NukeImmune, HurryCostModifier,  MinAreaSize,	ConquestProb, 	ArtDefineTag,	IconAtlas, 		PortraitIndex, 	WonderSplashAudio,							WonderSplashImage, 				 WonderSplashAnchor)
VALUES	('BUILDING_JFD_PANAMA_CANAL',		'BUILDINGCLASS_JFD_PANAMA_CANAL',	20,									'BUILDINGCLASS_HARBOR',	1060,	'TECH_RAILROAD',	'ERA_POSTMODERN', 	'SPECIALIST_ENGINEER',	2,						1,		'POLICY_BRANCH_JFD_INDUSTRY',		'TXT_KEY_BUILDING_JFD_PANAMA_CANAL',	'TXT_KEY_WONDER_JFD_PANAMA_CANAL_HELP',		'TXT_KEY_WONDER_JFD_PANAMA_CANAL_PEDIA',	'TXT_KEY_WONDER_JFD_PANAMA_CANAL_QUOTE',	1,			-1,					-1,				100,			null,			'BW_ATLAS_2',	25,				'AS2D_WONDER_SPEECH_JFD_PANAMA_CANAL',		'WonderConceptPanamaCanal.dds',	 'C,B');	
--------------------------------------------------------------------------------------------------------------------------
-- Building_YieldChanges
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Building_YieldChanges 
		(BuildingType, 						YieldType,				Yield)
VALUES	('BUILDING_JFD_PANAMA_CANAL', 		'YIELD_CULTURE',		1),
		('BUILDING_JFD_PANAMA_CANAL', 		'YIELD_PRODUCTION',		2);
--------------------------------------------------------------------------------------------------------------------------
-- Building_BuildingClassYieldChanges
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Building_BuildingClassYieldChanges 
		(BuildingType, 						BuildingClassType,		 YieldType,		YieldChange)
VALUES	('BUILDING_JFD_PANAMA_CANAL', 		'BUILDINGCLASS_HARBOR',	 'YIELD_GOLD',	1);
--------------------------------------------------------------------------------------------------------------------------
-- Building_Flavors
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Building_Flavors 
		(BuildingType, 						FlavorType,				Flavor)
VALUES	('BUILDING_JFD_PANAMA_CANAL',		'FLAVOR_WONDER',		20),
		('BUILDING_JFD_PANAMA_CANAL',		'FLAVOR_GREAT_PEOPLE',	10),
		('BUILDING_JFD_PANAMA_CANAL',		'FLAVOR_GOLD',			20),
		('BUILDING_JFD_PANAMA_CANAL',		'FLAVOR_PRODUCTION',	10);
--==========================================================================================================================
--==========================================================================================================================


