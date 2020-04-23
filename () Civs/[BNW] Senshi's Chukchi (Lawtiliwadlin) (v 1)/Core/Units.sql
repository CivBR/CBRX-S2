--==========================================================================================================================
-- Units
--==========================================================================================================================
INSERT INTO Units
(Type, 										Class, Cost, Range, PrereqTech, Combat,	RangedCombat, Moves, FaithCost,	RequiresFaithPurchaseEnabled, CombatClass, MilitarySupport, MilitaryProduction, Domain, Pillage, IgnoreBuildingDefense, ObsoleteTech, GoodyHutUpgradeUnitClass, XPValueAttack, XPValueDefense, Conscription,  DefaultUnitAI, Description, 						Civilopedia, 							Help, 									Strategy,									AdvancedStartCost,	UnitArtInfo, 					  UnitFlagIconOffset,	UnitFlagAtlas,						PortraitIndex, 	IconAtlas)
SELECT		('UNIT_SENSHI_CHULTENNIN'),		Class, Cost, Range, PrereqTech, Combat, RangedCombat, Moves, FaithCost,	RequiresFaithPurchaseEnabled, CombatClass, MilitarySupport, MilitaryProduction,	Domain, Pillage, IgnoreBuildingDefense, ObsoleteTech, GoodyHutUpgradeUnitClass, XPValueAttack, XPValueDefense, Conscription,  DefaultUnitAI, ('TXT_KEY_UNIT_SENSHI_CHULTENNIN'),	('TXT_KEY_CIV5_UNIT_SENSHI_CHULTENNIN_TEXT'), 	('TXT_KEY_UNIT_SENSHI_CHULTENNIN_HELP'), 	('TXT_KEY_UNIT_SENSHI_CHULTENNIN_STRATEGY'),	AdvancedStartCost, 	('ART_DEF_UNIT_SENSHI_CHULTENNIN'),  0,					('SENSHI_CHULTENNIN_FLAG'),	2, 				('SENSHI_CHUKCHI_ATLAS')
FROM Units WHERE (Type = 'UNIT_COMPOSITE_BOWMAN');
--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================
INSERT INTO UnitGameplay2DScripts
(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT		('UNIT_SENSHI_CHULTENNIN'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_COMPOSITE_BOWMAN');
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes
(UnitType, 					UnitAIType)
SELECT		('UNIT_SENSHI_CHULTENNIN'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_COMPOSITE_BOWMAN');
--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================
INSERT INTO Unit_ClassUpgrades
(UnitType, 					UnitClassType)
SELECT		('UNIT_SENSHI_CHULTENNIN'), 	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_COMPOSITE_BOWMAN');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors
(UnitType, 					FlavorType, Flavor)
SELECT		'UNIT_SENSHI_CHULTENNIN', 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_COMPOSITE_BOWMAN');

--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 								PromotionType)
VALUES		('UNIT_SENSHI_CHULTENNIN', 		'PROMOTION_SENSHI_CHULTENNIN');

INSERT INTO Unit_FreePromotions
			(UnitType, 					PromotionType)
SELECT		'UNIT_SENSHI_CHULTENNIN',		PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_COMPOSITE_BOWMAN');
--==========================================================================================================================
--==========================================================================================================================
