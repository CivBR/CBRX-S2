--==========================================================================================================================
-- DecisionsAddin_Support
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('MHA_Decisions.lua');
--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================
-- Buildings: Invisible
------------------------------	
INSERT INTO Buildings
			(Type, 												BuildingClass, 											Description,													GreatWorkCount,	Cost,	FaithCost,	PrereqTech, 	NeverCapture)
VALUES		('BUILDING_DECISIONS_MHA_DOGTRAVOIS_1', 			'BUILDINGCLASS_DECISIONS_MHA_DOGTRAVOIS_1',				'TXT_KEY_DECISIONS_MHA_DOGTRAVOIS',					-1, 			-1,   		-1,		null,			1),
			('BUILDING_DECISIONS_MHA_DOGTRAVOIS_2', 			'BUILDINGCLASS_DECISIONS_MHA_DOGTRAVOIS_2',				'TXT_KEY_DECISIONS_MHA_DOGTRAVOIS',					-1, 			-1,   		-1,		null,			1);

UPDATE Buildings
SET	NumTradeRouteBonus = 3
WHERE Type = 'BUILDING_DECISIONS_MHA_DOGTRAVOIS_1';

INSERT INTO BuildingClasses 
			(Type, 			DefaultBuilding,	Description)
SELECT 		BuildingClass,	Type,				Description
FROM Buildings WHERE (Type IN ('BUILDING_DECISIONS_MHA_DOGTRAVOIS_1', 'BUILDING_DECISIONS_MHA_DOGTRAVOIS_2'));
------------------------------
-- Unit_ProductionModifierBuildings
------------------------------	
INSERT INTO Unit_ProductionModifierBuildings 	
		(BuildingType, 							UnitType,			ProductionModifier)
VALUES	('BUILDING_DECISIONS_MHA_DOGTRAVOIS_2',	'UNIT_CARAVAN',		33),
		('BUILDING_DECISIONS_MHA_DOGTRAVOIS_2',	'UNIT_CARGO_SHIP',	33);
--==========================================================================================================================	
-- Policies
--==========================================================================================================================
INSERT INTO Policies 
		(Type, 												Description)
VALUES	('POLICY_DECISIONS_MHA_GOOSE_SOCIETY', 				'TXT_KEY_MHA_GOOSE_SOCIETY_DESC'),
		('POLICY_DECISIONS_MHA_BULL_SOCIETY', 				'TXT_KEY_MHA_BULL_SOCIETY_DESC'),
		('POLICY_DECISIONS_MHA_STONE_HAMMER_SOCIETY', 		'TXT_KEY_MHA_STONE_HAMMER_SOCIETY_DESC'),
		('POLICY_DECISIONS_MHA_SKUNK_SOCIETY', 				'TXT_KEY_MHA_SKUNK_SOCIETY_DESC');

INSERT INTO Policies
		(Type, 												Description) 
SELECT 	'POLICY_DECISIONS_MHA_WHITE_BUFFALO_COW_SOCIETY', 	'TXT_KEY_MHA_WHITE_BUFFALO_COW_SOCIETY_DESC'
WHERE EXISTS (SELECT * FROM CustomModOptions WHERE Name = 'API_UNIFIED_YIELDS' AND Value = 1);

INSERT INTO Policies
		(Type, 												Description) 
SELECT 	'POLICY_DECISIONS_MHA_BLACK_MOUTH_SOCIETY', 	'TXT_KEY_MHA_BLACK_MOUTH_SOCIETY_DESC'
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_CRIMES_CORE' AND Value = 1);
------------------------------
-- Policy_SpecialistExtraYields
------------------------------
INSERT INTO Policy_SpecialistExtraYields 
			(PolicyType, 									YieldType, 					Yield)
VALUES		('POLICY_DECISIONS_MHA_GOOSE_SOCIETY', 			'YIELD_FOOD', 				1),
			('POLICY_DECISIONS_MHA_BULL_SOCIETY', 			'YIELD_SCIENCE', 			1),
			('POLICY_DECISIONS_MHA_STONE_HAMMER_SOCIETY', 	'YIELD_PRODUCTION', 		1),
			('POLICY_DECISIONS_MHA_SKUNK_SOCIETY', 			'YIELD_GOLD', 				2);

UPDATE Policy_SpecialistExtraYields
SET YieldType = 'YIELD_CULTURE'
WHERE PolicyType = 'POLICY_DECISIONS_MHA_BULL_SOCIETY'
AND EXISTS (SELECT * FROM CustomModOptions WHERE Name = 'API_UNIFIED_YIELDS' AND Value = 1);

INSERT INTO Policy_SpecialistExtraYields
		(PolicyType, 										YieldType, 					Yield)
SELECT 	'POLICY_DECISIONS_MHA_WHITE_BUFFALO_COW_SOCIETY', 	'YIELD_FAITH',				2
WHERE EXISTS (SELECT * FROM CustomModOptions WHERE Name = 'API_UNIFIED_YIELDS' AND Value = 1);

INSERT INTO Policy_SpecialistExtraYields
		(PolicyType, 										YieldType, 					Yield)
SELECT 	'POLICY_DECISIONS_MHA_BLACK_MOUTH_SOCIETY', 		'YIELD_JFD_CRIME',			-1
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_CRIMES_CORE' AND Value = 1);
--==========================================================================================================================
-- Language_en_US
--==========================================================================================================================
INSERT INTO Language_en_US (Tag, Text)
VALUES
	(
		'TXT_KEY_DECISIONS_MHA_DOGTRAVOIS',
		'Introduce Dog Travois'
	),
	(
		'TXT_KEY_DECISIONS_MHA_DOGTRAVOIS_DESC',
		'The average Arikara family owns between 30 and 40 dogs for companionship, hunting, and sentry purposes. The more astute amongst us have remarked that they theoretically could be used for transport purposes as well. Pointing this fact out and introducing dog travois to the populace seems a cost effective way to invigorate trade within the nation.[NEWLINE]
		[NEWLINE]Requirement/Restrictions:
		[NEWLINE][ICON_BULLET]Player must be the Three Affiliated Tribes[NEWLINE][ICON_BULLET]Requires at least 1 Earth Lodge
		[NEWLINE][ICON_BULLET]An Earth Lodge must be built in all Cities where they may be built
		[NEWLINE][ICON_BULLET]May only be enacted once per game
		[NEWLINE]Costs:
		[NEWLINE][ICON_BULLET]1 [ICON_MAGISTRATES] Magistrates
		[NEWLINE][ICON_BULLET]{1_Gold} [ICON_GOLD] Gold
		[NEWLINE]Rewards:
		[NEWLINE][ICON_BULLET]+33% [ICON_PRODUCTION] Production towards Trade Units[NEWLINE][ICON_BULLET]3 Extra [ICON_SWAP] Trade Slots'
	),
	(
		'TXT_KEY_DECISIONS_MHA_DOGTRAVOIS_ENACTED_DESC',
		'The average Arikara family owns between 30 and 40 dogs for companionship, hunting, and sentry purposes. The more astute amongst us have remarked that they theoretically could be used for transport purposes as well. Pointing this fact out and introducing dog travois to the populace seems a cost effective way to invigorate trade within the nation.[NEWLINE]
		[NEWLINE]Rewards:
		[NEWLINE][ICON_BULLET]+33% [ICON_PRODUCTION] Production towards Trade Units[NEWLINE][ICON_BULLET]3 Extra [ICON_SWAP] Trade Slots'
	),
	(
		'TXT_KEY_DECISIONS_MHA_SOCIETIES',
		'Establish a Society'
	),
	(
		'TXT_KEY_DECISIONS_MHA_SOCIETIES_DESC',
		'Men''s and Women''s Societies are a central part of our culture, binding our people together in mutual obligation while also providing care, identity, and community. Additionally, these societies provide various social services for their communities. We should establish a new society to support our burgeoning nation.[NEWLINE]
		[NEWLINE]Requirement/Restrictions:
		[NEWLINE][ICON_BULLET]Player must be the Three Affiliated Tribes[NEWLINE][ICON_BULLET]Must have a total [ICON_CITIZEN] population of {1_Pop} or more 
		[NEWLINE][ICON_BULLET]May only be enacted 3 times per game
		[NEWLINE]Costs:
		[NEWLINE][ICON_BULLET]1 [ICON_MAGISTRATES] Magistrates
		[NEWLINE]Rewards:
		[NEWLINE][ICON_BULLET]A Society may be established. The following Societies are available. Established Societies are highlighted in green:
		[NEWLINE]------------
		{2_SocietyList}'
	),
	(
		'TXT_KEY_DECISIONS_MHA_SOCIETIES_ENACTED_DESC',
		'Men''s and Women''s Societies are a central part of our culture, binding our people together in mutual obligation while also providing care, identity, and community. Additionally, these societies provide various social services for their communities. We should establish a new society to support our burgeoning nation.[NEWLINE]
		[NEWLINE]Rewards:
		[NEWLINE][ICON_BULLET]A Society may be established. The following Societies are available. Established Societies are highlighted in green:
		[NEWLINE]------------
		{1_SocietyList}'
	),
	(
		'TXT_KEY_MHA_GOOSE_SOCIETY_DESC',
		'Goose Society: +1 [ICON_FOOD] Food from every Specialist'
	),
	(
		'TXT_KEY_MHA_BULL_SOCIETY_DESC',
		'Bull Society: +1 [ICON_RESEARCH] Science from every Specialist'
	),
	(
		'TXT_KEY_MHA_STONE_HAMMER_SOCIETY_DESC',
		'Stone Hammer Society: +1 [ICON_PRODUCTION] Production from every Specialist'
	),
	(
		'TXT_KEY_MHA_SKUNK_SOCIETY_DESC',
		'Skunk Society: +2 [ICON_GOLD] Gold from every Specialist'
	),
	(
		'TXT_KEY_MHA_WHITE_BUFFALO_COW_SOCIETY_DESC',
		'White Buffalo Cow Society: +2 [ICON_PEACE] Faith from every Specialist'
	),
	(
		'TXT_KEY_MHA_BLACK_MOUTH_SOCIETY_DESC',
		'Black Mouth Society: -1 [ICON_JFD_CRIME_BLACK] Crime from every Specialist'
	),
	(
		'TXT_KEY_MHA_CHOOSE_SOCIETY_BUTTON_TT',
		'Choose a Society to Establish'
	),
	(
		'TXT_KEY_MHA_CHOOSE_SOCIETY_BUTTON',
		'Establish the {1_Society}'
	),
	(
		'TXT_KEY_MHA_CHOOSE_SOCIETY_BUTTON_1',
		'Establish'
	);

INSERT OR REPLACE INTO Language_en_US (Tag, Text)
SELECT	'TXT_KEY_MHA_BULL_SOCIETY_DESC',
		'Bull Society: +1 [ICON_CULTURE] Culture from every Specialist'
WHERE EXISTS (SELECT * FROM CustomModOptions WHERE Name = 'API_UNIFIED_YIELDS' AND Value = 1);
--==========================================================================================================================
--==========================================================================================================================