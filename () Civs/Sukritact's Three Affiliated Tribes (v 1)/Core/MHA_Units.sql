--==========================================================================================================================
-- UNITS
--==========================================================================================================================
-- Units
--------------------------------
INSERT INTO Units 	
		(Type, 						Class,	PrereqTech,	Combat, FaithCost, RequiresFaithPurchaseEnabled, Cost,	Moves, 		CombatClass,		Domain, DefaultUnitAI, Description, 					Civilopedia, 							Strategy, 								Help, 								MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, XPValueAttack, XPValueDefense, Conscription,	UnitArtInfo,					UnitFlagAtlas, 				UnitFlagIconOffset, PortraitIndex,	IconAtlas)
SELECT	'UNIT_MC_BLACKMOUTH', 		Class,	PrereqTech, Combat, FaithCost, RequiresFaithPurchaseEnabled, Cost, 	Moves-2, 	'UNITCOMBAT_MELEE', Domain, DefaultUnitAI, 'TXT_KEY_UNIT_MC_BLACKMOUTH',	'TXT_KEY_CIV5_MC_BLACKMOUTH_TEXT',		'TXT_KEY_UNIT_MC_BLACKMOUTH_STRATEGY', 	'TXT_KEY_UNIT_MC_BLACKMOUTH_HELP',	MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, XPValueAttack, XPValueDefense, Conscription, 	'ART_DEF_UNIT_MC_BLACKMOUTH',	'MC_BLACKMOUTH_FLAG',		0,					3,				'MC_MHA_ATLAS'
FROM Units WHERE Type = 'UNIT_LANCER';
--------------------------------
-- UnitGameplay2DScripts
--------------------------------
INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 				SelectionSound, FirstSelectionSound)
SELECT	'UNIT_MC_BLACKMOUTH', 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_IROQUOIAN_MOHAWKWARRIOR';	
--------------------------------
-- Unit_AITypes
--------------------------------
INSERT INTO Unit_AITypes 	
		(UnitType, 				UnitAIType)
SELECT	'UNIT_MC_BLACKMOUTH', 	UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_LANCER';
--------------------------------
-- Unit_Flavors
--------------------------------
INSERT INTO Unit_Flavors 	
		(UnitType, 				FlavorType, Flavor)
SELECT	'UNIT_MC_BLACKMOUTH', 	FlavorType, Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_LANCER';
--------------------------------
-- Unit_FreePromotions
--------------------------------
INSERT INTO Unit_FreePromotions 	
		(UnitType, 				PromotionType)
SELECT	'UNIT_MC_BLACKMOUTH', 	PromotionType
FROM Unit_FreePromotions WHERE UnitType = 'UNIT_LANCER';

DELETE FROM Unit_FreePromotions WHERE UnitType = 'UNIT_MC_BLACKMOUTH' AND PromotionType = 'PROMOTION_NO_DEFENSIVE_BONUSES'; 

INSERT INTO Unit_FreePromotions
		(UnitType,				PromotionType)
VALUES	('UNIT_MC_BLACKMOUTH',	'PROMOTION_MC_BLACKMOUTH');
--------------------------------
-- Unit_ClassUpgrades
--------------------------------
INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 				UnitClassType)
SELECT	'UNIT_MC_BLACKMOUTH',		UnitClassType
FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_LANCER';
--==========================================================================================================================	
-- PROMOTIONS
--==========================================================================================================================	
-- UnitPromotions
------------------------------
INSERT INTO UnitPromotions 
		(Type, 							Description, 								Help, 													Sound, 				CannotBeChosen, LostWithUpgrade,	PortraitIndex,	IconAtlas, 			PediaType, 			PediaEntry)
VALUES	('PROMOTION_MC_BLACKMOUTH',		'TXT_KEY_PROMOTION_MC_BLACKMOUTH',			'TXT_KEY_PROMOTION_MC_BLACKMOUTH_HELP', 				'AS2D_IF_LEVELUP', 	1, 				0, 					59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_MC_BLACKMOUTH');
--==========================================================================================================================
--==========================================================================================================================