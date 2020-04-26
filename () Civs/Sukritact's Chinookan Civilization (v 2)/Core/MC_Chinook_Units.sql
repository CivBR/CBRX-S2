--==========================================================================================================================
-- Units
--==========================================================================================================================	
INSERT INTO Units 	
			(Class, 	Type, 						PrereqTech, Cost,	Special, Moves, CivilianAttackPriority, Domain, DefaultUnitAI, Description, 						Civilopedia, 								Strategy, 										Help, 										MilitarySupport,	MilitaryProduction, Pillage,	IgnoreBuildingDefense, AdvancedStartCost, ObsoleteTech,	WorkRate, XPValueAttack, XPValueDefense, GoodyHutUpgradeUnitClass, UnitArtInfo, 							MoveRate, UnitFlagIconOffset,	UnitFlagAtlas,				PortraitIndex, 	IconAtlas)
SELECT		Class, 		('UNIT_MC_CHINOOK_WHALER'), PrereqTech, 30,		Special, Moves, CivilianAttackPriority, Domain, DefaultUnitAI, ('TXT_KEY_UNIT_MC_CHINOOK_WHALER'), 	('TXT_KEY_CIV5_MC_CHINOOK_WHALER_TEXT'), 	('TXT_KEY_UNIT_MC_CHINOOK_WHALER_STRATEGY'), 	('TXT_KEY_UNIT_HELP_MC_CHINOOK_WHALER'),	MilitarySupport,	MilitaryProduction,	Pillage,	IgnoreBuildingDefense, AdvancedStartCost, ObsoleteTech, WorkRate, XPValueAttack, XPValueDefense, GoodyHutUpgradeUnitClass, ('ART_DEF_UNIT_MC_CHINOOK_WHALER'),		MoveRate, 0,					('MC_CHINOOK_WHALER_FLAG'),	2, 				('MC_CHINOOK_ATLAS')
FROM Units WHERE (Type = 'UNIT_WORKBOAT');

UPDATE Units
SET	
	Range			= 	(SELECT Range FROM Units WHERE Type = 'UNIT_GALLEASS'), 
	CombatClass 	= 	(SELECT CombatClass FROM Units WHERE Type = 'UNIT_GALLEASS'), 
	DefaultUnitAI 	= 	(SELECT DefaultUnitAI FROM Units WHERE Type = 'UNIT_GALLEASS'),
	XPValueAttack 	= 	(SELECT XPValueAttack FROM Units WHERE Type = 'UNIT_GALLEASS'), 
	XPValueDefense 	= 	(SELECT XPValueDefense FROM Units WHERE Type = 'UNIT_GALLEASS'),
	CombatLimit 	= 	(SELECT CombatLimit FROM Units WHERE Type = 'UNIT_GALLEASS'), 
	Combat 			= 	4,
	RangedCombat	=	7
WHERE Type = 'UNIT_MC_CHINOOK_WHALER';                                                                    
--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================	
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 						SelectionSound, FirstSelectionSound)
SELECT		('UNIT_MC_CHINOOK_WHALER'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_WORKBOAT');
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================	
INSERT INTO Unit_AITypes 	
			(UnitType, 						UnitAIType)
SELECT		('UNIT_MC_CHINOOK_WHALER'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_GALLEASS');
--==========================================================================================================================
-- Unit_Builds
--==========================================================================================================================
INSERT INTO Unit_Builds 	
			(UnitType, 						BuildType)
VALUES		('UNIT_MC_CHINOOK_WHALER', 		'BUILD_REPAIR'),
			('UNIT_MC_CHINOOK_WHALER', 		'BUILD_FISHING_BOATS_NO_KILL');	
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================	
INSERT INTO Unit_Flavors 	
			(UnitType, 						FlavorType, Flavor)
SELECT		('UNIT_MC_CHINOOK_WHALER'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_GALLEASS');

INSERT OR REPLACE INTO Unit_Flavors 	
			(UnitType, 						FlavorType, Flavor)
SELECT		('UNIT_MC_CHINOOK_WHALER'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_WORKBOAT');	
--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================	
INSERT INTO Unit_FreePromotions 	
			(UnitType, 					PromotionType)
SELECT		('UNIT_MC_CHINOOK_WHALER'),	PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_GALLEASS');

INSERT INTO Unit_FreePromotions 	
			(UnitType, 					PromotionType)
VALUES		('UNIT_MC_CHINOOK_WHALER',	'PROMOTION_OCEAN_IMPASSABLE_UNTIL_ASTRONOMY'),
			('UNIT_MC_CHINOOK_WHALER',	'PROMOTION_WITHDRAW_BEFORE_MELEE'),
			('UNIT_MC_CHINOOK_WHALER',	'PROMOTION_MC_CHINOOK_WHALER');

DELETE FROM Unit_FreePromotions
WHERE UnitType = 'UNIT_MC_CHINOOK_WHALER' AND PromotionType = 'PROMOTION_OCEAN_IMPASSABLE';
--==========================================================================================================================	
--==========================================================================================================================	