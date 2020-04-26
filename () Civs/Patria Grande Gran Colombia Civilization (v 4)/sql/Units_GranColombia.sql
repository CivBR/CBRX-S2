--==========================================================================================================================	
-- UNITS
--==========================================================================================================================
-- Unit Classes
--------------------------------
INSERT INTO UnitClasses
		(Type,								Description,					DefaultUnit)
VALUES	('UNITCLASS_PG_UPGRADE_LIBERTADOR',	'TXT_KEY_UNIT_PG_LIBERTADOR',	'UNIT_PG_UPGRADE_LIBERTADOR');

--------------------------------
-- Civilization_UnitClassOverrides 
--------------------------------		
INSERT INTO Civilization_UnitClassOverrides 
		(CivilizationType, 				UnitClassType, 				UnitType)
VALUES	('CIVILIZATION_PG_GRANCOLOMBIA', 	'UNITCLASS_LANCER',			'UNIT_PG_LLANERO'),
		('CIVILIZATION_PG_GRANCOLOMBIA',	'UNITCLASS_GREAT_GENERAL',	'UNIT_PG_LIBERTADOR');

-- Units
--------------------------------
INSERT INTO Units 	
			(Type, 				PrereqTech, Class, Combat,	RangedCombat,	CombatClass, Cost,  FaithCost, RequiresFaithPurchaseEnabled, Moves, Range,	Domain, DefaultUnitAI, Description, 				Civilopedia, 						Strategy, 							Help, 								Pillage, MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, Mechanized, AdvancedStartCost, RangedCombatLimit, CombatLimit, XPValueDefense, ObsoleteTech, GoodyHutUpgradeUnitClass, UnitArtInfo, 				UnitFlagIconOffset,	UnitFlagAtlas,						PortraitIndex, 	IconAtlas,				MoveRate)
SELECT		'UNIT_PG_LLANERO',	PrereqTech, Class, Combat,	RangedCombat,	CombatClass, Cost,	FaithCost, RequiresFaithPurchaseEnabled, Moves, Range,	Domain, DefaultUnitAI, 'TXT_KEY_UNIT_PG_LLANERO',	'TXT_KEY_UNIT_PG_LLANERO_TEXT', 	'TXT_KEY_UNIT_PG_LLANERO_STRATEGY',	'TXT_KEY_UNIT_PG_LLANERO_HELP',		Pillage, MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, Mechanized, AdvancedStartCost, RangedCombatLimit, CombatLimit, XPValueDefense, ObsoleteTech, GoodyHutUpgradeUnitClass, 'ART_DEF_UNIT_PG_LLANERO',	0,					'PG_GRANCOLOMBIA_LLANERO_FLAG_ATLAS',	4, 				'PG_GRANCOLOMBIA_ATLAS',	MoveRate
FROM Units WHERE (Type = 'UNIT_LANCER');

INSERT INTO Units 	
			(Type, 					PrereqTech, Class, Combat,	RangedCombat,	CombatClass, Cost,  FaithCost, RequiresFaithPurchaseEnabled, Moves, Range,	Domain, DefaultUnitAI, Description, 					Civilopedia, 						Strategy, 								Help, 									Pillage, MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, Mechanized, AdvancedStartCost, RangedCombatLimit, CombatLimit, XPValueDefense, ObsoleteTech, GoodyHutUpgradeUnitClass, UnitArtInfo, 					UnitFlagIconOffset,	UnitFlagAtlas,							PortraitIndex, 	IconAtlas,				MoveRate,		GoldenAgeTurns,	WorkRate,	DontShowYields,	CivilianAttackPriority,		Special)
SELECT		'UNIT_PG_LIBERTADOR',	PrereqTech, Class, Combat,	RangedCombat,	CombatClass, Cost,	FaithCost, RequiresFaithPurchaseEnabled, Moves, Range,	Domain, DefaultUnitAI, 'TXT_KEY_UNIT_PG_LIBERTADOR',	'TXT_KEY_UNIT_PG_LIBERTADOR_TEXT', 	'TXT_KEY_UNIT_PG_LIBERTADOR_STRATEGY',	'TXT_KEY_UNIT_PG_LIBERTADOR_HELP',		Pillage, MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, Mechanized, AdvancedStartCost, RangedCombatLimit, CombatLimit, XPValueDefense, ObsoleteTech, GoodyHutUpgradeUnitClass, 'ART_DEF_UNIT_PG_LIBERTADOR',	0,					'PG_GRANCOLOMBIA_LIBERTADOR_FLAG_ATLAS',	5, 				'PG_GRANCOLOMBIA_ATLAS',	MoveRate,		8,							WorkRate,	DontShowYields,	CivilianAttackPriority,		Special
FROM Units WHERE (Type = 'UNIT_GREAT_GENERAL');

INSERT INTO Units 	
			(Type, 							PrereqTech, Class, Combat,	RangedCombat,	CombatClass, Cost,  FaithCost, RequiresFaithPurchaseEnabled, Moves, Range,	Domain, DefaultUnitAI, Description, 					Civilopedia, 						Strategy, 								Help, 									Pillage, MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, Mechanized, AdvancedStartCost, RangedCombatLimit, CombatLimit, XPValueDefense, ObsoleteTech, GoodyHutUpgradeUnitClass, UnitArtInfo, 					UnitFlagIconOffset,	UnitFlagAtlas,							PortraitIndex, 	IconAtlas,				MoveRate,		GoldenAgeTurns,	WorkRate,	DontShowYields,	CivilianAttackPriority,		Special)
SELECT		'UNIT_PG_UPGRADE_LIBERTADOR',	PrereqTech, Class, Combat,	RangedCombat,	CombatClass, Cost,	FaithCost, RequiresFaithPurchaseEnabled, Moves, Range,	Domain, DefaultUnitAI, 'TXT_KEY_UNIT_PG_LIBERTADOR',	'TXT_KEY_UNIT_PG_LIBERTADOR_TEXT', 	'TXT_KEY_UNIT_PG_LIBERTADOR_STRATEGY',	'TXT_KEY_UNIT_PG_LIBERTADOR_HELP',		Pillage, MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, Mechanized, AdvancedStartCost, RangedCombatLimit, CombatLimit, XPValueDefense, ObsoleteTech, GoodyHutUpgradeUnitClass, 'ART_DEF_UNIT_PG_LIBERTADOR',	0,					'PG_GRANCOLOMBIA_LIBERTADOR_FLAG_ATLAS',	5, 				'PG_GRANCOLOMBIA_ATLAS',	MoveRate,		8,							WorkRate,	DontShowYields,	CivilianAttackPriority,		Special
FROM Units WHERE (Type = 'UNIT_GREAT_GENERAL');


--------------------------------
-- UnitGameplay2DScripts
--------------------------------
INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT	'UNIT_PG_LLANERO', 		SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_LANCER';	

--------------------------------
-- Unit_ResourceQuantityRequirements
--------------------------------
INSERT INTO Unit_ResourceQuantityRequirements 	
		(UnitType, 				ResourceType)
SELECT	'UNIT_PG_LLANERO', 		ResourceType
FROM Unit_ResourceQuantityRequirements WHERE UnitType = 'UNIT_LANCER';

--------------------------------
-- Unit_AITypes
--------------------------------
INSERT INTO Unit_AITypes 	
		(UnitType, 				UnitAIType)
SELECT	'UNIT_PG_LLANERO', 		UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_LANCER';

INSERT INTO Unit_AITypes 	
		(UnitType, 				UnitAIType)
SELECT	'UNIT_PG_LIBERTADOR', 	UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_GREAT_GENERAL';

INSERT INTO Unit_AITypes 	
		(UnitType, 						UnitAIType)
SELECT	'UNIT_PG_UPGRADE_LIBERTADOR', 	UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_GREAT_GENERAL';


--------------------------------
-- Builds
--------------------------------
INSERT INTO Unit_Builds
		(UnitType,				BuildType)
SELECT	'UNIT_PG_LIBERTADOR',	BuildType
FROM Unit_Builds WHERE UnitType = 'UNIT_GREAT_GENERAL';

--------------------------------
-- Unit_ClassUpgrades
--------------------------------	
INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 				UnitClassType)
SELECT	'UNIT_PG_LLANERO', 		UnitClassType
FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_LANCER';


--INSERT INTO Unit_ClassUpgrades 	
--		(UnitType, 		UnitClassType)
--SELECT	Type,			'UNITCLASS_PG_UPGRADE_LIBERTADOR'
--FROM Units WHERE MoveRate = 'GREAT_PERSON';

--------------------------------
-- Unit_Flavors
--------------------------------
INSERT INTO Unit_Flavors 	
		(UnitType, 				FlavorType, Flavor)
SELECT	'UNIT_PG_LLANERO', 		FlavorType, Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_LANCER';

--------------------------------
-- Unit_FreePromotions
--------------------------------
INSERT INTO Unit_FreePromotions 	
		(UnitType, 			PromotionType)
SELECT	'UNIT_PG_LLANERO', 	PromotionType
FROM Unit_FreePromotions WHERE UnitType = 'UNIT_LANCER';

INSERT INTO Unit_FreePromotions 	
		(UnitType, 						PromotionType)
SELECT	'UNIT_PG_LIBERTADOR',			PromotionType
FROM Unit_FreePromotions WHERE UnitType = 'UNIT_GREAT_GENERAL';

INSERT INTO Unit_FreePromotions 	
		(UnitType, 							PromotionType)
SELECT	'UNIT_PG_UPGRADE_LIBERTADOR',		PromotionType
FROM Unit_FreePromotions WHERE UnitType = 'UNIT_GREAT_GENERAL';


INSERT OR REPLACE INTO Unit_FreePromotions 	
		(UnitType, 						PromotionType)
VALUES	('UNIT_PG_LLANERO', 			'PROMOTION_PG_LLANERO'),
		('UNIT_PG_LIBERTADOR',			'PROMOTION_PG_LIBERATIONIST'),
		('UNIT_PG_UPGRADE_LIBERTADOR',	'PROMOTION_PG_LIBERATIONIST');

-------------------------------
-- Unit_UniqueNames
-------------------------------
INSERT INTO Unit_UniqueNames
		(UnitType,				UniqueName)
VALUES	('UNIT_PG_LIBERTADOR',	'TXT_KEY_PG_LIBERTADOR_NAME_00'),
		('UNIT_PG_LIBERTADOR',	'TXT_KEY_PG_LIBERTADOR_NAME_01'),
		('UNIT_PG_LIBERTADOR',	'TXT_KEY_PG_LIBERTADOR_NAME_02'),
		('UNIT_PG_LIBERTADOR',	'TXT_KEY_PG_LIBERTADOR_NAME_03'),
		('UNIT_PG_LIBERTADOR',	'TXT_KEY_PG_LIBERTADOR_NAME_04'),
		('UNIT_PG_LIBERTADOR',	'TXT_KEY_PG_LIBERTADOR_NAME_05'),
		('UNIT_PG_LIBERTADOR',	'TXT_KEY_PG_LIBERTADOR_NAME_06'),
		('UNIT_PG_LIBERTADOR',	'TXT_KEY_PG_LIBERTADOR_NAME_07'),
		('UNIT_PG_LIBERTADOR',	'TXT_KEY_PG_LIBERTADOR_NAME_08'),
		('UNIT_PG_LIBERTADOR',	'TXT_KEY_PG_LIBERTADOR_NAME_09'),
		('UNIT_PG_LIBERTADOR',	'TXT_KEY_PG_LIBERTADOR_NAME_10'),
		('UNIT_PG_LIBERTADOR',	'TXT_KEY_PG_LIBERTADOR_NAME_11'),
		('UNIT_PG_LIBERTADOR',	'TXT_KEY_PG_LIBERTADOR_NAME_12'),
		('UNIT_PG_LIBERTADOR',	'TXT_KEY_PG_LIBERTADOR_NAME_13'),
		('UNIT_PG_LIBERTADOR',	'TXT_KEY_PG_LIBERTADOR_NAME_14'),
		('UNIT_PG_LIBERTADOR',	'TXT_KEY_PG_LIBERTADOR_NAME_15'),
		('UNIT_PG_LIBERTADOR',	'TXT_KEY_PG_LIBERTADOR_NAME_16'),
		('UNIT_PG_LIBERTADOR',	'TXT_KEY_PG_LIBERTADOR_NAME_17'),
		('UNIT_PG_LIBERTADOR',	'TXT_KEY_PG_LIBERTADOR_NAME_18'),
		('UNIT_PG_LIBERTADOR',	'TXT_KEY_PG_LIBERTADOR_NAME_19'),
		('UNIT_PG_LIBERTADOR',	'TXT_KEY_PG_LIBERTADOR_NAME_20'),
		('UNIT_PG_LIBERTADOR',	'TXT_KEY_PG_LIBERTADOR_NAME_21'),
		('UNIT_PG_LIBERTADOR',	'TXT_KEY_PG_LIBERTADOR_NAME_22'),
		('UNIT_PG_LIBERTADOR',	'TXT_KEY_PG_LIBERTADOR_NAME_23'),
		('UNIT_PG_LIBERTADOR',	'TXT_KEY_PG_LIBERTADOR_NAME_24'),
		('UNIT_PG_LIBERTADOR',	'TXT_KEY_PG_LIBERTADOR_NAME_25');



--==========================================================================================================================	
-- PROMOTIONS
--==========================================================================================================================	
-- UnitPromotions
------------------------------
INSERT INTO UnitPromotions 
		(Type, 							Description,	 						Help, 										Sound, 				CannotBeChosen, PortraitIndex, 	IconAtlas, 						PediaType, 			PediaEntry,								LostWithUpgrade,	OpenAttack,	OpenDefense,	GreatGeneralReceivesMovement,	Sapper)
VALUES	('PROMOTION_PG_LLANERO',		'TXT_KEY_PROMOTION_PG_LLANERO',			'TXT_KEY_PROMOTION_PG_LLANERO_HELP',	 	'AS2D_IF_LEVELUP', 	1, 				4,				'EXPANSION2_PROMOTION_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_PG_LLANERO',			0,					10,			10,				1,								0),
		('PROMOTION_PG_LIBERATIONIST',	'TXT_KEY_PROMOTION_PG_LIBERATIONIST',	'TXT_KEY_PROMOTION_PG_LIBERATIONIST_HELP', 	'AS2D_IF_LEVELUP', 	1, 				8, 				'EXPANSION2_PROMOTION_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_PG_LIBERATIONIST',	1,					0,			0,				0,								1);

------------------------------
-- Missions
------------------------------
INSERT OR REPLACE INTO Missions	
		(Type, 						Time,	OrderPriority,	Visible,	Description, 						Help, 								DisabledHelp, 									EntityEventType,			IconAtlas,					IconIndex)
VALUES	('MISSION_PG_RECRUIT', 		25,		199,			1,			'TXT_KEY_MISSION_PG_RECRUIT', 		'TXT_KEY_MISSION_PG_RECRUIT_HELP', 	'TXT_KEY_MISSION_PG_RECRUIT_DISABLED_HELP', 	'ENTITY_EVENT_GREAT_EVENT',	'LIBERTADOR_ACTION_ATLAS',	0);
