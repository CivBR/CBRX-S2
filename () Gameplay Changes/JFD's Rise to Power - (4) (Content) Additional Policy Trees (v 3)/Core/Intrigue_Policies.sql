--=======================================================================================================================
-- GAME DEFINES
--=======================================================================================================================
------------------------------------------------------------------------------------------------------------------------
-- BuildingClasses
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO BuildingClasses
		(Type, 										DefaultBuilding, 								Description)
VALUES	('BUILDINGCLASS_JFD_INTRIGUE',				'BUILDING_JFD_INTRIGUE',						'TXT_KEY_BUILDING_JFD_INTRIGUE'),
		('BUILDINGCLASS_JFD_INTRIGUE_DELEGATES',	'BUILDING_JFD_DIPLOMATIC_CABALS_DELEGATE',		'TXT_KEY_BUILDING_JFD_INTRIGUE_DELEGATES');
--==========================================================================================================================
-- POLICY BRANCHES
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- PolicyBranchTypes
-------------------------------------------------------------------------------------------------------------------------
INSERT INTO PolicyBranchTypes
		(Type,							Description,							 Help,											Title,							EraPrereq,			FreePolicy,				FreeFinishingPolicy)
VALUES	('POLICY_BRANCH_JFD_INTRIGUE',	'TXT_KEY_POLICY_BRANCH_JFD_INTRIGUE',	 'TXT_KEY_POLICY_BRANCH_JFD_INTRIGUE_HELP',		'TXT_KEY_JFD_INTRIGUE_TITLE',	'ERA_RENAISSANCE',	'POLICY_JFD_INTRIGUE',	'POLICY_JFD_INTRIGUE_FINISHER');
--==========================================================================================================================		
-- POLICIES
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- Policies
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policies
		(Type,								RevealAllCapitals,	RiggingElectionModifier,	StealTechFasterModifier,	CatchSpiesModifier,	BuildingGoldMaintenanceMod,	PolicyBranchType,				Description,								Help,											Civilopedia,									GridX, GridY,	IconAtlas,						IconAtlasAchieved,				PortraitIndex)
VALUES	('POLICY_JFD_INTRIGUE',				0,					0,							0,							0,					0,							null,							'TXT_KEY_POLICY_BRANCH_JFD_INTRIGUE',		'TXT_KEY_POLICY_BRANCH_JFD_INTRIGUE_HELP',		'TXT_KEY_POLICY_BRANCH_JFD_INTRIGUE_TEXT',		0,		0,		'POLICY_ATLAS',					'POLICY_A_ATLAS',				0),
		('POLICY_JFD_INTRIGUE_FINISHER',	1,					0,							0,							0,					0,							null,							'TXT_KEY_POLICY_BRANCH_JFD_INTRIGUE',		null,											null,											0,		0,		'POLICY_ATLAS',					'POLICY_A_ATLAS',				0),
		('POLICY_JFD_CABINET_NOIR',			0,					0,							0,							0,					0,							'POLICY_BRANCH_JFD_INTRIGUE',	'TXT_KEY_POLICY_JFD_CABINET_NOIR',			'TXT_KEY_POLICY_JFD_CABINET_NOIR_HELP',			'TXT_KEY_POLICY_JFD_CABINET_NOIR_TEXT',			1,		2,		'JFD_INTRIGUE_POLICY_ATLAS',	'JFD_INTRIGUE_POLICY_A_ATLAS',	1),
		('POLICY_JFD_CLOAK_AND_DAGGER',		0,					10,							10,							10,					0,							'POLICY_BRANCH_JFD_INTRIGUE',	'TXT_KEY_POLICY_JFD_CLOAK_AND_DAGGER',		'TXT_KEY_POLICY_JFD_CLOAK_AND_DAGGER_HELP',		'TXT_KEY_POLICY_JFD_CLOAK_AND_DAGGER_TEXT',		3,		1,		'JFD_INTRIGUE_POLICY_ATLAS',	'JFD_INTRIGUE_POLICY_A_ATLAS',	0),
		('POLICY_JFD_DIPLOMATIC_CABALS',	0,					0,							0,							0,					0,							'POLICY_BRANCH_JFD_INTRIGUE',	'TXT_KEY_POLICY_JFD_DIPLOMATIC_CABALS',		'TXT_KEY_POLICY_JFD_DIPLOMATIC_CABALS_HELP',	'TXT_KEY_POLICY_JFD_DIPLOMATIC_CABALS_TEXT',	5,		2,		'JFD_INTRIGUE_POLICY_ATLAS',	'JFD_INTRIGUE_POLICY_A_ATLAS',	3),
		('POLICY_JFD_INTELLIGENCE_NETWORK',	0,					0,							0,							0,					0,							'POLICY_BRANCH_JFD_INTRIGUE',	'TXT_KEY_POLICY_JFD_INTELLIGENCE_NETWORK',	'TXT_KEY_POLICY_JFD_INTELLIGENCE_NETWORK_HELP',	'TXT_KEY_POLICY_JFD_INTELLIGENCE_NETWORK_TEXT',	3,		2,		'JFD_INTRIGUE_POLICY_ATLAS',	'JFD_INTRIGUE_POLICY_A_ATLAS',	2),
		('POLICY_JFD_POLICE_PREFECTURES',	0,					0,							0,							0,					-15,						'POLICY_BRANCH_JFD_INTRIGUE',	'TXT_KEY_POLICY_JFD_POLICE_PREFECTURES',	'TXT_KEY_POLICY_JFD_POLICE_PREFECTURES_HELP',	'TXT_KEY_POLICY_JFD_POLICE_PREFECTURES_TEXT',	1,		1,		'JFD_INTRIGUE_POLICY_ATLAS',	'JFD_INTRIGUE_POLICY_A_ATLAS',	4);
--------------------------------------------------------------------------------------------------------------------------
-- Buildings
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Buildings 	
		(Type, 						 				BuildingClass, 								ExtraLeagueVotes,	NoOccupiedUnhappiness,	GreatWorkCount, Cost, FaithCost, PrereqTech, NeverCapture,	Description, 										Help)
VALUES	('BUILDING_JFD_CABINET_NOIR_OCCUPATION', 	'BUILDINGCLASS_JFD_INTRIGUE', 				0,					1,						-1, 			-1,   -1, 		 null, 		 1,				'TXT_KEY_BUILDING_JFD_CABINET_NOIR_OCCUPATION',		'TXT_KEY_BUILDING_JFD_CABINET_NOIR_OCCUPATION_HELP'),
		('BUILDING_JFD_DIPLOMATIC_CABALS_DELEGATE', 'BUILDINGCLASS_JFD_INTRIGUE_DELEGATES', 	1,					0,						-1, 			-1,   -1, 		 null, 		 1,				'TXT_KEY_BUILDING_JFD_DIPLOMATIC_CABALS_DELEGATE',	'TXT_KEY_BUILDING_JFD_DIPLOMATIC_CABALS_DELEGATE_HELP');

INSERT INTO Buildings 	
		(Type, 						 				BuildingClass, 					ExtraSpies,	GreatWorkCount, Cost, FaithCost, PrereqTech, NeverCapture,	Description, 									Help)
SELECT	'BUILDING_JFD_INTRIGUE_FINISHER_SPY',		'BUILDINGCLASS_JFD_INTRIGUE', 	1,			-1, 			-1,   -1, 		 null, 		 1,				'TXT_KEY_BUILDING_JFD_INTRIGUE_FINISHER_SPY',	'TXT_KEY_BUILDING_JFD_INTRIGUE_FINISHER_SPY_HELP'
WHERE NOT EXISTS (SELECT Name FROM CustomModOptions WHERE Name = 'COMMUNITY_PATCH' AND Value = 1);
--------------------------------------------------------------------------------------------------------------------------
-- Policy_BuildingClassHappiness
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_BuildingClassHappiness
		(PolicyType,						BuildingClassType,			Happiness)
VALUES	('POLICY_JFD_CABINET_NOIR',			'BUILDINGCLASS_CONSTABLE',	1);
--------------------------------------------------------------------------------------------------------------------------
-- Policy_FreeBuilding
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Policy_FreeBuilding(PolicyType, BuildingClassType, Count);
INSERT INTO Policy_FreeBuilding
		(PolicyType,						BuildingClassType,			Count)
VALUES	('POLICY_JFD_INTRIGUE',				'BUILDINGCLASS_JFD_JAIL',	4);
--------------------------------------------------------------------------------------------------------------------------
-- Policy_Flavors
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_Flavors
		(PolicyType,						FlavorType,				Flavor)
VALUES	('POLICY_JFD_CABINET_NOIR',			'FLAVOR_EXPANSION',		10),
		('POLICY_JFD_CABINET_NOIR',			'FLAVOR_HAPPINESS',		20),
		('POLICY_JFD_CABINET_NOIR',			'FLAVOR_ESPIONAGE',		10),
		('POLICY_JFD_CLOAK_AND_DAGGER',		'FLAVOR_CULTURE',		10),
		('POLICY_JFD_CLOAK_AND_DAGGER',		'FLAVOR_GREAT_PEOPLE',	10),
		('POLICY_JFD_CLOAK_AND_DAGGER',		'FLAVOR_SCIENCE',		10),
		('POLICY_JFD_CLOAK_AND_DAGGER',		'FLAVOR_PRODUCTION',	10),
		('POLICY_JFD_DIPLOMATIC_CABALS',	'FLAVOR_DIPLOMACY',		20),
		('POLICY_JFD_INTELLIGENCE_NETWORK',	'FLAVOR_GREAT_PEOPLE',	20),
		('POLICY_JFD_INTRIGUE',				'FLAVOR_ESPIONAGE',		20),
		('POLICY_JFD_INTRIGUE',				'FLAVOR_GREAT_PEOPLE',	10),
		('POLICY_JFD_INTRIGUE',				'FLAVOR_GOLD',			5),
		('POLICY_JFD_INTRIGUE',				'FLAVOR_DIPLOMACY',		5),
		('POLICY_JFD_INTRIGUE',				'FLAVOR_PRODUCTION',	5),
		('POLICY_JFD_POLICE_PREFECTURES',	'FLAVOR_GOLD',			20);		
--------------------------------------------------------------------------------------------------------------------------
-- Policy_PrereqPolicies
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_PrereqPolicies
		(PolicyType,						PrereqPolicy)
VALUES	('POLICY_JFD_CABINET_NOIR',			'POLICY_JFD_POLICE_PREFECTURES'),
		('POLICY_JFD_DIPLOMATIC_CABALS',	'POLICY_JFD_CLOAK_AND_DAGGER'),
		('POLICY_JFD_INTELLIGENCE_NETWORK',	'POLICY_JFD_CLOAK_AND_DAGGER');
-------------------------------------------------------------------------------------------------------------------------
-- Policy_JFD_IdeologicalValues
-------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Policy_JFD_IdeologicalValues(PolicyType, IdeologicalValueType);
INSERT INTO Policy_JFD_IdeologicalValues
		(PolicyType,						 IdeologicalValueType)
VALUES	('POLICY_JFD_CABINET_NOIR',			'IDEOLOGICAL_VALUE_JFD_AUTHORITY'),
		('POLICY_JFD_CLOAK_AND_DAGGER',		'IDEOLOGICAL_VALUE_JFD_AUTHORITY'),
		('POLICY_JFD_DIPLOMATIC_CABALS',	'IDEOLOGICAL_VALUE_JFD_AUTHORITY'),
		('POLICY_JFD_INTELLIGENCE_NETWORK',	'IDEOLOGICAL_VALUE_JFD_LIBERTY'),
		('POLICY_JFD_INTRIGUE',				'IDEOLOGICAL_VALUE_JFD_LIBERTY'),
		('POLICY_JFD_POLICE_PREFECTURES',	'IDEOLOGICAL_VALUE_JFD_EQUALITY');
--==========================================================================================================================
--==========================================================================================================================