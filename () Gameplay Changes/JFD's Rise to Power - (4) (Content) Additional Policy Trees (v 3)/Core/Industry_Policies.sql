--=======================================================================================================================
-- GAME DEFINES
--=======================================================================================================================
------------------------------------------------------------------------------------------------------------------------
-- BuildingClasses
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO BuildingClasses
		(Type, 							DefaultBuilding, 			Description)
SELECT	'BUILDINGCLASS_JFD_INDUSTRY', 	'BUILDING_JFD_INDUSTRY',    'TXT_KEY_BUILDING_JFD_INDUSTRY'
WHERE NOT EXISTS (SELECT Name FROM CustomModOptions WHERE Name = 'API_UNIFIED_YIELDS' AND Value = 1);
--==========================================================================================================================
-- POLICY BRANCHES
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- PolicyBranchTypes
-------------------------------------------------------------------------------------------------------------------------
INSERT INTO PolicyBranchTypes
		(Type,							Description,								 Help,											Title,							EraPrereq,			FreePolicy,					FreeFinishingPolicy)
VALUES	('POLICY_BRANCH_JFD_INDUSTRY',	'TXT_KEY_POLICY_BRANCH_JFD_INDUSTRY',		 'TXT_KEY_POLICY_BRANCH_JFD_INDUSTRY_HELP',		'TXT_KEY_JFD_INDUSTRY_TITLE',	'ERA_INDUSTRIAL',	'POLICY_JFD_INDUSTRY',	'POLICY_JFD_INDUSTRY_FINISHER');

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
		(Type,									IncludesOneShotFreeUnits,	PolicyBranchType,					Description,									Help,												Civilopedia,										GridX, GridY,	IconAtlas,						IconAtlasAchieved,				PortraitIndex)
VALUES	('POLICY_JFD_INDUSTRY',					0,							null,								'TXT_KEY_POLICY_BRANCH_JFD_INDUSTRY',			'TXT_KEY_POLICY_BRANCH_JFD_INDUSTRY_HELP',			'TXT_KEY_POLICY_BRANCH_JFD_INDUSTRY_TEXT',			0,		0,		'POLICY_ATLAS',					'POLICY_A_ATLAS',				0),
		('POLICY_JFD_INDUSTRY_FINISHER',		0,							null,								'TXT_KEY_POLICY_BRANCH_JFD_INDUSTRY',			null,												null,												0,		0,		'POLICY_ATLAS',					'POLICY_A_ATLAS',				0),
		('POLICY_JFD_AGE_OF_SYNERGY',			0,							'POLICY_BRANCH_JFD_INDUSTRY',		'TXT_KEY_POLICY_JFD_AGE_OF_SYNERGY',			'TXT_KEY_POLICY_JFD_AGE_OF_SYNERGY_HELP',			'TXT_KEY_POLICY_JFD_AGE_OF_SYNERGY_TEXT',			2,		3,		'JFD_INDUSTRY_POLICY_ATLAS',	'JFD_INDUSTRY_POLICY_A_ATLAS',	4),
		('POLICY_JFD_APPLIED_SCIENCE',			0,							'POLICY_BRANCH_JFD_INDUSTRY',		'TXT_KEY_POLICY_JFD_APPLIED_SCIENCE',			'TXT_KEY_POLICY_JFD_APPLIED_SCIENCE_HELP',			'TXT_KEY_POLICY_JFD_APPLIED_SCIENCE_TEXT',			2,		1,		'JFD_INDUSTRY_POLICY_ATLAS',	'JFD_INDUSTRY_POLICY_A_ATLAS',	2),
		('POLICY_JFD_INDUSTRIAL_ENGINEERING',	1,							'POLICY_BRANCH_JFD_INDUSTRY',		'TXT_KEY_POLICY_JFD_INDUSTRIAL_ENGINEERING',	'TXT_KEY_POLICY_JFD_INDUSTRIAL_ENGINEERING_HELP',	'TXT_KEY_POLICY_JFD_INDUSTRIAL_ENGINEERING_TEXT',	5,		2,		'JFD_INDUSTRY_POLICY_ATLAS',	'JFD_INDUSTRY_POLICY_A_ATLAS',	0),
		('POLICY_JFD_MASS_PRODUCTION',			0,							'POLICY_BRANCH_JFD_INDUSTRY',		'TXT_KEY_POLICY_JFD_MASS_PRODUCTION',			'TXT_KEY_POLICY_JFD_MASS_PRODUCTION_HELP',			'TXT_KEY_POLICY_JFD_MASS_PRODUCTION_TEXT',			4,		1,		'JFD_INDUSTRY_POLICY_ATLAS',	'JFD_INDUSTRY_POLICY_A_ATLAS',	1),
		('POLICY_JFD_RESOURCE_MANAGEMENT',		0,							'POLICY_BRANCH_JFD_INDUSTRY',		'TXT_KEY_POLICY_JFD_RESOURCE_MANAGEMENT',		'TXT_KEY_POLICY_JFD_RESOURCE_MANAGEMENT_HELP',		'TXT_KEY_POLICY_JFD_RESOURCE_MANAGEMENT_TEXT',		3,		2,		'JFD_INDUSTRY_POLICY_ATLAS',	'JFD_INDUSTRY_POLICY_A_ATLAS',	3);
--------------------------------------------------------------------------------------------------------------------------
-- Buildings
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Buildings 	
		(Type, 						 				BuildingClass, 					GreatWorkCount, Cost, FaithCost, PrereqTech, NeverCapture,	Description, 										Help)
SELECT	'BUILDING_JFD_RESOURCE_MANAGEMENT_GOLD', 	'BUILDINGCLASS_JFD_INDUSTRY', 	-1, 			-1,   -1, 		 null, 		 1,				'TXT_KEY_BUILDING_JFD_RESOURCE_MANAGEMENT_GOLD',	'TXT_KEY_BUILDING_JFD_RESOURCE_MANAGEMENT_GOLD_HELP'
WHERE NOT EXISTS (SELECT Name FROM CustomModOptions WHERE Name = 'API_UNIFIED_YIELDS' AND Value = 1);
------------------------------------------------------------------------------------------------------------------------	
-- Building_ResourceYieldChanges
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Building_ResourceYieldChanges 
		(BuildingType, 								ResourceType,	YieldType,		Yield)
SELECT	'BUILDING_JFD_RESOURCE_MANAGEMENT_GOLD',	Type,			'YIELD_GOLD',   1
FROM Resources WHERE ResourceClassType IN ('RESOURCECLASS_MODERN', 'RESOURCECLASS_RUSH') AND NOT Type IN ('RESOURCE_ARTIFACTS', 'RESOURCE_HIDDEN_ARTIFACTS')
AND NOT EXISTS (SELECT Name FROM CustomModOptions WHERE Name = 'API_UNIFIED_YIELDS' AND Value = 1);
--------------------------------------------------------------------------------------------------------------------------
-- Policy_BuildingClassProductionModifiers
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_BuildingClassProductionModifiers
		(PolicyType,				BuildingClassType,	ProductionModifier)
SELECT	'POLICY_JFD_INDUSTRY',		Type,				10
FROM BuildingClasses WHERE DefaultBuilding IN (SELECT BuildingType FROM Building_ResourceQuantityRequirements WHERE Cost > 0);
--------------------------------------------------------------------------------------------------------------------------
-- Policy_BuildingClassYieldChanges
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_BuildingClassYieldChanges
		(PolicyType,					BuildingClassType,			YieldType,			  YieldChange)
VALUES	('POLICY_JFD_MASS_PRODUCTION',	'BUILDINGCLASS_FACTORY',	'YIELD_PRODUCTION',	  2),
		('POLICY_JFD_MASS_PRODUCTION',	'BUILDINGCLASS_WORKSHOP',	'YIELD_PRODUCTION',	  2);

INSERT INTO Policy_BuildingClassYieldChanges
		(PolicyType,					BuildingClassType,	YieldType,			YieldChange)
SELECT	'POLICY_JFD_AGE_OF_SYNERGY',	BuildingClass,		'YIELD_PRODUCTION',	1
FROM Buildings WHERE Type IN (SELECT BuildingType FROM Building_ResourceQuantityRequirements WHERE Cost > 0);

INSERT INTO Policy_BuildingClassYieldChanges
		(PolicyType,					BuildingClassType,	YieldType,			YieldChange)
SELECT	'POLICY_JFD_AGE_OF_SYNERGY',	BuildingClass,		'YIELD_SCIENCE',	1
FROM Buildings WHERE Type IN (SELECT BuildingType FROM Building_ResourceQuantityRequirements WHERE Cost > 0);
--------------------------------------------------------------------------------------------------------------------------
-- Policy_BuildingClassYieldModifiers
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_BuildingClassYieldModifiers
		(PolicyType,					BuildingClassType,			YieldType,			  YieldMod)
VALUES	('POLICY_JFD_MASS_PRODUCTION',	'BUILDINGCLASS_FACTORY',	'YIELD_PRODUCTION',	  5),
		('POLICY_JFD_MASS_PRODUCTION',	'BUILDINGCLASS_WORKSHOP',	'YIELD_PRODUCTION',	  5);
--------------------------------------------------------------------------------------------------------------------------
-- Policy_ImprovementYieldChanges
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_ImprovementYieldChanges
		(PolicyType,						ImprovementType,			YieldType,			  Yield)
VALUES	('POLICY_JFD_INDUSTRY_FINISHER',	'IMPROVEMENT_ACADEMY',		'YIELD_SCIENCE',	  2),
		('POLICY_JFD_INDUSTRY_FINISHER',	'IMPROVEMENT_MANUFACTORY',	'YIELD_PRODUCTION',	  2);
--------------------------------------------------------------------------------------------------------------------------
-- Policy_ResourceYieldChanges
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Policy_ResourceYieldChanges(PolicyType, ResourceType, YieldType, Yield);
INSERT INTO Policy_ResourceYieldChanges
		(PolicyType,						ResourceType,		YieldType,		Yield)
SELECT	'POLICY_JFD_RESOURCE_MANAGEMENT',	Type,				'YIELD_GOLD',	1
FROM Resources WHERE ResourceClassType IN ('RESOURCECLASS_MODERN', 'RESOURCECLASS_RUSH') AND NOT Type IN ('RESOURCE_ARTIFACTS', 'RESOURCE_HIDDEN_ARTIFACTS');
--------------------------------------------------------------------------------------------------------------------------
-- Policy_UnitClassProductionModifiers
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Policy_UnitClassProductionModifiers(PolicyType, UnitClassType, ProductionModifier);
INSERT INTO Policy_UnitClassProductionModifiers
		(PolicyType,					UnitClassType,		ProductionModifier)
SELECT	'POLICY_JFD_INDUSTRY',		Type,				10
FROM UnitClasses WHERE DefaultUnit IN (SELECT UnitType FROM Unit_ResourceQuantityRequirements WHERE Cost > 0);
--------------------------------------------------------------------------------------------------------------------------
-- Policy_UnitCombatProductionModifiers
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_UnitCombatProductionModifiers
		(PolicyType,				UnitCombatType,		ProductionModifier)
SELECT	'POLICY_JFD_INDUSTRY',		Type,				10
FROM UnitCombatInfos WHERE Type IN ('UNITCOMBAT_MOUNTED', 'UNITCOMBAT_ARMOR', 'UNITCOMBAT_FIGHTER', 'UNITCOMBAT_BOMBER', 'UNITCOMBAT_HELICOPTER', 'UNITCOMBAT_SIEGE', 'UNITCOMBAT_NAVALMELEE', 'UNITCOMBAT_NAVALRANGED');
--------------------------------------------------------------------------------------------------------------------------
-- Policy_FreeUnitClasses
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_FreeUnitClasses
		(PolicyType,							UnitClassType,			Count)
VALUES	('POLICY_JFD_INDUSTRIAL_ENGINEERING',	'UNITCLASS_ENGINEER',	1);
--------------------------------------------------------------------------------------------------------------------------
-- Policy_Flavors
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_Flavors
		(PolicyType,							FlavorType,				Flavor)
VALUES	('POLICY_JFD_AGE_OF_SYNERGY',			'FLAVOR_SCIENCE',		20),
		('POLICY_JFD_AGE_OF_SYNERGY',			'FLAVOR_PRODUCTION',	10),
		('POLICY_JFD_APPLIED_SCIENCE',			'FLAVOR_CULTURE',		10),
		('POLICY_JFD_APPLIED_SCIENCE',			'FLAVOR_GREAT_PEOPLE',	10),
		('POLICY_JFD_APPLIED_SCIENCE',			'FLAVOR_SCIENCE',		10),
		('POLICY_JFD_APPLIED_SCIENCE',			'FLAVOR_PRODUCTION',	10),
		('POLICY_JFD_INDUSTRY',					'FLAVOR_PRODUCTION',	20),
		('POLICY_JFD_INDUSTRY',					'FLAVOR_SCIENCE',		10),
		('POLICY_JFD_INDUSTRY',					'FLAVOR_GREAT_PEOPLE',	5),
		('POLICY_JFD_INDUSTRIAL_ENGINEERING',	'FLAVOR_PRODUCTION',	10),
		('POLICY_JFD_INDUSTRIAL_ENGINEERING',	'FLAVOR_GREAT_PEOPLE',	10),
		('POLICY_JFD_MASS_PRODUCTION',			'FLAVOR_PRODUCTION',	20),
		('POLICY_JFD_RESOURCE_MANAGEMENT',		'FLAVOR_GOLD',			20);
--------------------------------------------------------------------------------------------------------------------------
-- Policy_PrereqPolicies
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_PrereqPolicies
		(PolicyType,							PrereqPolicy)
VALUES	('POLICY_JFD_AGE_OF_SYNERGY',			'POLICY_JFD_APPLIED_SCIENCE'),
		('POLICY_JFD_AGE_OF_SYNERGY',			'POLICY_JFD_RESOURCE_MANAGEMENT'),
		('POLICY_JFD_INDUSTRIAL_ENGINEERING',	'POLICY_JFD_MASS_PRODUCTION'),
		('POLICY_JFD_RESOURCE_MANAGEMENT',		'POLICY_JFD_MASS_PRODUCTION');
-------------------------------------------------------------------------------------------------------------------------
-- Policy_JFD_IdeologicalValues
-------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Policy_JFD_IdeologicalValues(PolicyType, IdeologicalValueType);
INSERT INTO Policy_JFD_IdeologicalValues
		(PolicyType,							 IdeologicalValueType)
VALUES	('POLICY_JFD_AGE_OF_SYNERGY',			'IDEOLOGICAL_VALUE_JFD_LIBERTY'),
		('POLICY_JFD_APPLIED_SCIENCE',			'IDEOLOGICAL_VALUE_JFD_LIBERTY'),
		('POLICY_JFD_INDUSTRY',					'IDEOLOGICAL_VALUE_JFD_LIBERTY'),
		('POLICY_JFD_INDUSTRIAL_ENGINEERING',	'IDEOLOGICAL_VALUE_JFD_LIBERTY'),
		('POLICY_JFD_MASS_PRODUCTION',			'IDEOLOGICAL_VALUE_JFD_EQUALITY'),
		('POLICY_JFD_RESOURCE_MANAGEMENT',		'IDEOLOGICAL_VALUE_JFD_EQUALITY');
--==========================================================================================================================
--==========================================================================================================================