--==========================================================================================================================
-- BUILDINGS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- BuildingClasses
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO BuildingClasses 
		(Type, 								  DefaultBuilding, 					Description, 							MaxGlobalInstances,  MaxPlayerInstances)
VALUES	('BUILDINGCLASS_JFD_MT_RUSHMORE',	  'BUILDING_JFD_MT_RUSHMORE',		'TXT_KEY_BUILDING_JFD_MT_RUSHMORE', 	1,					 -1);
--------------------------------------------------------------------------------------------------------------------------
-- Civilization_BuildingClassOverrides
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Civilization_BuildingClassOverrides 
		(BuildingClassType, 					CivilizationType, 			BuildingType)
VALUES	('BUILDINGCLASS_JFD_MT_RUSHMORE',		'CIVILIZATION_BARBARIAN', 	null),
		('BUILDINGCLASS_JFD_MT_RUSHMORE',		'CIVILIZATION_MINOR', 		null);
--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- Buildings
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Buildings 						
		(Type, 								BuildingClass, 						Cost, 	NearbyMountainRequired,	TechEnhancedTourism,	EnhancedYieldTech,	HappinessPerCity,	GlobalPopulationchange,	PrereqTech, 		MaxStartEra, 	SpecialistType,			GreatPeopleRateChange,  PolicyBranchType,					Description, 							Help, 								 		Civilopedia, 						 		Quote,  									NukeImmune, HurryCostModifier,  MinAreaSize,	ConquestProb, 	ArtDefineTag,	IconAtlas, 						PortraitIndex, 	WonderSplashAudio,							WonderSplashImage, 			 WonderSplashAnchor)
VALUES	('BUILDING_JFD_MT_RUSHMORE',		'BUILDINGCLASS_JFD_MT_RUSHMORE',	750,	1,						4,						'TECH_FLIGHT',		1,					1,						'TECH_DYNAMITE',	'ERA_MODERN', 	'SPECIALIST_ENGINEER',	2,						'POLICY_BRANCH_JFD_CONSERVATION',	'TXT_KEY_BUILDING_JFD_MT_RUSHMORE',		'TXT_KEY_WONDER_JFD_MT_RUSHMORE_HELP',		'TXT_KEY_WONDER_JFD_MT_RUSHMORE_PEDIA',		'TXT_KEY_WONDER_JFD_MT_RUSHMORE_QUOTE',		1,			-1,					-1,				100,			null,			'JFD_CONSERVATION_WONDER_ATLAS',	0,				'AS2D_WONDER_SPEECH_JFD_MT_RUSHMORE',		'Wonder_MtRushmore.dds',	 'C,B');
--------------------------------------------------------------------------------------------------------------------------
-- Policy_BuildingClassProductionModifiers
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_BuildingClassProductionModifiers
		(PolicyType,			BuildingClassType,	ProductionModifier)
SELECT	'POLICY_JFD_INDUSTRY',	Type,				10
FROM BuildingClasses WHERE DefaultBuilding IN (SELECT BuildingType FROM Building_ResourceQuantityRequirements WHERE Cost > 0);
--------------------------------------------------------------------------------------------------------------------------
-- Building_YieldChanges
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Building_YieldChanges 
		(BuildingType, 						YieldType,				Yield)
VALUES	('BUILDING_JFD_MT_RUSHMORE', 		'YIELD_CULTURE',		1);
--------------------------------------------------------------------------------------------------------------------------
-- Building_Flavors
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Building_Flavors 
		(BuildingType, 						FlavorType,				Flavor)
VALUES	('BUILDING_JFD_MT_RUSHMORE',		'FLAVOR_WONDER',		20),
		('BUILDING_JFD_MT_RUSHMORE',		'FLAVOR_GREAT_PEOPLE',	10),
		('BUILDING_JFD_MT_RUSHMORE',		'FLAVOR_CULTURE',		10),
		('BUILDING_JFD_MT_RUSHMORE',		'FLAVOR_HAPPINESS',		15),
		('BUILDING_JFD_MT_RUSHMORE',		'FLAVOR_GROWTH',		10);
--==========================================================================================================================
--==========================================================================================================================


