--=======================================================================================================================
-- GAME DEFINES
--=======================================================================================================================
------------------------------------------------------------------------------------------------------------------------
-- BuildingClasses
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO BuildingClasses
		(Type, 								DefaultBuilding, 				Description)
SELECT	'BUILDINGCLASS_JFD_CONSERVATION', 	'BUILDING_JFD_CONSERVATION',    'TXT_KEY_BUILDING_JFD_CONSERVATION'
WHERE NOT EXISTS (SELECT Name FROM CustomModOptions WHERE Name = 'API_UNIFIED_YIELDS' AND Value = 1);
--==========================================================================================================================
-- POLICY BRANCHES
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- PolicyBranchTypes
-------------------------------------------------------------------------------------------------------------------------
INSERT INTO PolicyBranchTypes
		(Type,								Description,								 Help,											Title,								EraPrereq,			FreePolicy,					FreeFinishingPolicy)
VALUES	('POLICY_BRANCH_JFD_CONSERVATION',	'TXT_KEY_POLICY_BRANCH_JFD_CONSERVATION',	 'TXT_KEY_POLICY_BRANCH_JFD_CONSERVATION_HELP',	'TXT_KEY_JFD_CONSERVATION_TITLE',	'ERA_INDUSTRIAL',	'POLICY_JFD_CONSERVATION',	'POLICY_JFD_CONSERVATION_FINISHER');

--UPDATE PolicyBranchTypes
--SET EraPrereq = 'ERA_ENLIGHTENMENT'
--WHERE Type = 'POLICY_BRANCH_JFD_INDUSTRY'
--AND EXISTS (SELECT Type FROM Eras WHERE Type = 'ERA_ENLIGHTENMENT');
--==========================================================================================================================		
-- POLICIES
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- Policies
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policies
		(Type,									PolicyBranchType,					FreeFoodBox,	Description,									Help,												Civilopedia,										GridX, GridY,	IconAtlas,							IconAtlasAchieved,					PortraitIndex)
VALUES	('POLICY_JFD_CONSERVATION',				null,								10,				'TXT_KEY_POLICY_BRANCH_JFD_CONSERVATION',		'TXT_KEY_POLICY_BRANCH_JFD_CONSERVATION_HELP',		'TXT_KEY_POLICY_BRANCH_JFD_CONSERVATION_TEXT',		0,		0,		'POLICY_ATLAS',						'POLICY_A_ATLAS',					0),
		('POLICY_JFD_CONSERVATION_FINISHER',	null,								0,				'TXT_KEY_POLICY_BRANCH_JFD_CONSERVATION',		null,												null,												0,		0,		'POLICY_ATLAS',						'POLICY_A_ATLAS',					0),
		('POLICY_JFD_CULTURAL_HERITAGE',		'POLICY_BRANCH_JFD_CONSERVATION',	0,				'TXT_KEY_POLICY_JFD_CULTURAL_HERITAGE',			'TXT_KEY_POLICY_JFD_CULTURAL_HERITAGE_HELP',		'TXT_KEY_POLICY_JFD_CULTURAL_HERITAGE_TEXT',		5,		1,		'JFD_CONSERVATION_POLICY_ATLAS',	'JFD_CONSERVATION_POLICY_A_ATLAS',	1),
		('POLICY_JFD_GREEN_ENERGY',				'POLICY_BRANCH_JFD_CONSERVATION',	0,				'TXT_KEY_POLICY_JFD_GREEN_ENERGY',				'TXT_KEY_POLICY_JFD_GREEN_ENERGY_HELP',				'TXT_KEY_POLICY_JFD_GREEN_ENERGY_TEXT',				2,		3,		'JFD_CONSERVATION_POLICY_ATLAS',	'JFD_CONSERVATION_POLICY_A_ATLAS',	4),
		('POLICY_JFD_NATIONAL_TRUST',			'POLICY_BRANCH_JFD_CONSERVATION',	0,				'TXT_KEY_POLICY_JFD_NATIONAL_TRUST',			'TXT_KEY_POLICY_JFD_NATIONAL_TRUST_HELP',			'TXT_KEY_POLICY_JFD_NATIONAL_TRUST_TEXT',			4,		3,		'JFD_CONSERVATION_POLICY_ATLAS',	'JFD_CONSERVATION_POLICY_A_ATLAS',	2),
		('POLICY_JFD_REFORESTATION',			'POLICY_BRANCH_JFD_CONSERVATION',	0,				'TXT_KEY_POLICY_JFD_REFORESTATION',				'TXT_KEY_POLICY_JFD_REFORESTATION_HELP',			'TXT_KEY_POLICY_JFD_REFORESTATION_TEXT',			2,		1,		'JFD_CONSERVATION_POLICY_ATLAS',	'JFD_CONSERVATION_POLICY_A_ATLAS',	0),
		('POLICY_JFD_SUSTAINABILITY',			'POLICY_BRANCH_JFD_CONSERVATION',	0,				'TXT_KEY_POLICY_JFD_SUSTAINABILITY',			'TXT_KEY_POLICY_JFD_SUSTAINABILITY_HELP',			'TXT_KEY_POLICY_JFD_SUSTAINABILITY_TEXT',			3,		2,		'JFD_CONSERVATION_POLICY_ATLAS',	'JFD_CONSERVATION_POLICY_A_ATLAS',	3);		

UPDATE Policies
SET Help = 'TXT_KEY_POLICY_JFD_GREEN_ENERGY_HELP_WIND_FARM'
WHERE Type = 'POLICY_JFD_GREEN_ENERGY' 
AND EXISTS (SELECT Type FROM BuildingClasses WHERE Type = 'BUILDINGCLASS_JFD_WIND_FARM');

UPDATE Policies
SET Help = 'TXT_KEY_POLICY_JFD_NATIONAL_TRUST_HELP_CP'
WHERE Type = 'POLICY_JFD_NATIONAL_TRUST' 
AND EXISTS (SELECT Type FROM Yields WHERE Type = 'YIELD_TOURISM');
--------------------------------------------------------------------------------------------------------------------------
-- Buildings
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Buildings 		
		(Type, 						 			BuildingClass, 						GreatWorkCount, Cost, FaithCost, PrereqTech, NeverCapture,	Description, 									Help)
SELECT	'BUILDING_JFD_NATIONAL_TRUST_CULTURE', 	'BUILDINGCLASS_JFD_CONSERVATION', 	-1, 			-1,   -1, 		 null, 		 1,				'TXT_KEY_BUILDING_JFD_NATIONAL_TRUST_CULTURE',	'TXT_KEY_BUILDING_JFD_NATIONAL_TRUST_CULTURE_HELP'
WHERE NOT EXISTS (SELECT Name FROM CustomModOptions WHERE Name = 'API_UNIFIED_YIELDS' AND Value = 1);

INSERT INTO Buildings 	
		(Type, 									BuildingClass, 						GreatWorkCount, Cost, FaithCost, PrereqTech, NeverCapture,	Description, 									Help)
SELECT	'BUILDING_JFD_SUSTAINABILITY_YIELDS', 	'BUILDINGCLASS_JFD_CONSERVATION', 	-1, 			-1,   -1, 		 null, 		 1,				'TXT_KEY_BUILDING_JFD_SUSTAINABILITY_YIELDS',	'TXT_KEY_BUILDING_JFD_SUSTAINABILITY_YIELDS_HELP'
WHERE NOT EXISTS (SELECT Name FROM CustomModOptions WHERE Name = 'API_UNIFIED_YIELDS' AND Value = 1);
------------------------------------------------------------------------------------------------------------------------	
-- Building_FeatureYieldChanges
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Building_FeatureYieldChanges 
		(BuildingType, 							FeatureType,	YieldType,			Yield)
SELECT	'BUILDING_JFD_NATIONAL_TRUST_CULTURE',	Type,			'YIELD_CULTURE',	1
FROM Features WHERE NaturalWonder = 1
AND NOT EXISTS (SELECT Name FROM CustomModOptions WHERE Name = 'API_UNIFIED_YIELDS' AND Value = 1);
------------------------------------------------------------------------------------------------------------------------	
-- Building_ResourceYieldChanges
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Building_ResourceYieldChanges 
		(BuildingType, 							ResourceType,	YieldType,	Yield)
SELECT	'BUILDING_JFD_SUSTAINABILITY_YIELDS',	ResourceType,	YieldType,  1
FROM Resource_YieldChanges WHERE ResourceType IN (SELECT Type FROM Resources WHERE ResourceClassType = 'RESOURCECLASS_BONUS')
AND NOT EXISTS (SELECT Name FROM CustomModOptions WHERE Name = 'API_UNIFIED_YIELDS' AND Value = 1);
--------------------------------------------------------------------------------------------------------------------------
-- Policy_BuildingClassCultureChanges
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_BuildingClassCultureChanges
		(PolicyType,						BuildingClassType,			CultureChange)
VALUES	('POLICY_JFD_CULTURAL_HERITAGE',	'BUILDINGCLASS_MONUMENT',	2);

INSERT INTO Policy_BuildingClassCultureChanges
		(PolicyType,						BuildingClassType,			CultureChange)
SELECT	'POLICY_JFD_NATIONAL_TRUST',		Type,						1
FROM BuildingClasses WHERE MaxGlobalInstances == 1 OR MaxPlayerInstances == 1;
--------------------------------------------------------------------------------------------------------------------------
-- Policy_BuildingClassYieldChanges
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_BuildingClassYieldChanges
		(PolicyType,						BuildingClassType,			YieldType,		  YieldChange)
SELECT	'POLICY_JFD_NATIONAL_TRUST',		Type,						'YIELD_TOURISM',  1
FROM BuildingClasses WHERE (MaxGlobalInstances == 1 OR MaxPlayerInstances == 1)
AND EXISTS (SELECT Type FROM Yields WHERE Type = 'YIELD_TOURISM');
--------------------------------------------------------------------------------------------------------------------------
-- Policy_BuildingClassTourismModifiers
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_BuildingClassTourismModifiers
		(PolicyType,						BuildingClassType,			TourismModifier)
VALUES	('POLICY_JFD_CULTURAL_HERITAGE',	'BUILDINGCLASS_MONUMENT',	10);
--------------------------------------------------------------------------------------------------------------------------
-- Policy_BuildingClassHappiness
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_BuildingClassHappiness
		(PolicyType,						BuildingClassType,					Happiness)
VALUES	('POLICY_JFD_CULTURAL_HERITAGE',	'BUILDINGCLASS_RECYCLING_CENTER',	1);
--------------------------------------------------------------------------------------------------------------------------
-- Policy_BuildingClassProductionModifiers
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_BuildingClassProductionModifiers
		(PolicyType,						BuildingClassType,	ProductionModifier)
SELECT	'POLICY_JFD_GREEN_ENERGY',			Type,				10
FROM BuildingClasses WHERE Type IN ('BUILDINGCLASS_HYDRO_PLANT', 'BUILDINGCLASS_JFD_WIND_FARM', 'BUILDINGCLASS_SOLAR_PLANT', 'BUILDINGCLASS_NUCLEAR_PLANT');
--------------------------------------------------------------------------------------------------------------------------
-- Policy_BuildingClassYieldModifiers
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_BuildingClassYieldModifiers
		(PolicyType,						BuildingClassType,	YieldType,		YieldMod)
SELECT	'POLICY_JFD_GREEN_ENERGY',			Type,				'YIELD_FOOD',	5
FROM BuildingClasses WHERE Type IN ('BUILDINGCLASS_HYDRO_PLANT', 'BUILDINGCLASS_JFD_WIND_FARM', 'BUILDINGCLASS_SOLAR_PLANT', 'BUILDINGCLASS_NUCLEAR_PLANT');
--------------------------------------------------------------------------------------------------------------------------
-- Policy_ImprovementYieldChanges
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_ImprovementYieldChanges
		(PolicyType,						ImprovementType,			YieldType,		  Yield)
VALUES	('POLICY_JFD_REFORESTATION',		'IMPROVEMENT_CAMP',			'YIELD_FOOD',	  1),
		('POLICY_JFD_REFORESTATION',		'IMPROVEMENT_LUMBERMILL',	'YIELD_FOOD',	  1);
--------------------------------------------------------------------------------------------------------------------------
-- Policy_FeatureYieldChanges
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Policy_FeatureYieldChanges(PolicyType, FeatureType, YieldType, Yield);
INSERT INTO Policy_FeatureYieldChanges
		(PolicyType,						FeatureType,			YieldType,			Yield)
SELECT	'POLICY_JFD_SUSTAINABILITY',		Type,					'YIELD_CULTURE',	1
FROM Features WHERE NaturalWonder = 1;

INSERT INTO Policy_FeatureYieldChanges
		(PolicyType,						FeatureType,			YieldType,			Yield)
SELECT	'POLICY_JFD_SUSTAINABILITY',		Type,					'YIELD_TOURISM',	1
FROM Features WHERE NaturalWonder = 1
AND EXISTS (SELECT Type FROM Yields WHERE Type = 'YIELD_TOURISM');
--------------------------------------------------------------------------------------------------------------------------
-- Policy_ResourceYieldChanges
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Policy_ResourceYieldChanges(PolicyType, ResourceType, YieldType, Yield);
INSERT INTO Policy_ResourceYieldChanges
		(PolicyType,						ResourceType,			YieldType,	Yield)
SELECT	'POLICY_JFD_SUSTAINABILITY',		ResourceType,			YieldType,	1
FROM Resource_YieldChanges WHERE ResourceType IN (SELECT Type FROM Resources WHERE ResourceClassType = 'RESOURCECLASS_BONUS');
--------------------------------------------------------------------------------------------------------------------------
-- Policy_FreeBuilding
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Policy_FreeBuilding(PolicyType, BuildingClassType, Count);
INSERT INTO Policy_FreeBuilding
		(PolicyType,							BuildingClassType,					Count)
VALUES	('POLICY_JFD_CONSERVATION_FINISHER',	'BUILDINGCLASS_RECYCLING_CENTER',	2);
--------------------------------------------------------------------------------------------------------------------------
-- Policy_Flavors
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_Flavors
		(PolicyType,						FlavorType,				Flavor)
VALUES	('POLICY_JFD_CONSERVATION',			'FLAVOR_GROWTH',		20),
		('POLICY_JFD_CONSERVATION',			'FLAVOR_HAPPINESS',		10),
		('POLICY_JFD_CONSERVATION',			'FLAVOR_PRODUCTION',	10),
		('POLICY_JFD_CULTURAL_HERITAGE',	'FLAVOR_CULTURE',		20),
		('POLICY_JFD_GREEN_ENERGY',			'FLAVOR_PRODUCTION',	10),
		('POLICY_JFD_GREEN_ENERGY',			'FLAVOR_GROWTH',		20),
		('POLICY_JFD_NATIONAL_TRUST',		'FLAVOR_CULTURE',		20),
		('POLICY_JFD_REFORESTATION',		'FLAVOR_GROWTH',		10),
		('POLICY_JFD_SUSTAINABILITY',		'FLAVOR_GROWTH',		10),
		('POLICY_JFD_SUSTAINABILITY',		'FLAVOR_PRODUCTION',	10);
--------------------------------------------------------------------------------------------------------------------------
-- Policy_PrereqPolicies
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_PrereqPolicies
		(PolicyType,						PrereqPolicy)
VALUES	('POLICY_JFD_GREEN_ENERGY',			'POLICY_JFD_SUSTAINABILITY'),
		('POLICY_JFD_NATIONAL_TRUST',		'POLICY_JFD_CULTURAL_HERITAGE'),
		('POLICY_JFD_NATIONAL_TRUST',		'POLICY_JFD_SUSTAINABILITY'),
		('POLICY_JFD_SUSTAINABILITY',		'POLICY_JFD_REFORESTATION');
-------------------------------------------------------------------------------------------------------------------------
-- Policy_JFD_IdeologicalValues
-------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Policy_JFD_IdeologicalValues(PolicyType, IdeologicalValueType);
INSERT INTO Policy_JFD_IdeologicalValues
		(PolicyType,						 IdeologicalValueType)
VALUES	('POLICY_JFD_CONSERVATION',			'IDEOLOGICAL_VALUE_JFD_AUTHORITY'),
		('POLICY_JFD_CULTURAL_HERITAGE',	'IDEOLOGICAL_VALUE_JFD_AUTHORITY'),
		('POLICY_JFD_GREEN_ENERGY',			'IDEOLOGICAL_VALUE_JFD_EQUALITY'),
		('POLICY_JFD_NATIONAL_TRUST',		'IDEOLOGICAL_VALUE_JFD_AUTHORITY'),
		('POLICY_JFD_REFORESTATION',		'IDEOLOGICAL_VALUE_JFD_EQUALITY'),
		('POLICY_JFD_SUSTAINABILITY',		'IDEOLOGICAL_VALUE_JFD_EQUALITY');
--==========================================================================================================================
--==========================================================================================================================