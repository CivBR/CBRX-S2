--==========================================================================================================================
-- Units
--==========================================================================================================================
INSERT INTO Units
(Type, 										Class, Cost, Range, PrereqTech, Combat, RangedCombat, Moves, NoMaintenance, FaithCost,	RequiresFaithPurchaseEnabled, CombatClass, MilitarySupport, MilitaryProduction, Domain, Pillage, IgnoreBuildingDefense, ObsoleteTech, GoodyHutUpgradeUnitClass, XPValueAttack, XPValueDefense, Conscription,  DefaultUnitAI, Description, 						Civilopedia, 							Help, 									Strategy,									AdvancedStartCost,	UnitArtInfo, 					  UnitFlagIconOffset,	UnitFlagAtlas,						PortraitIndex, 	IconAtlas)
SELECT		('UNIT_SENSHI_JAHAZI'),		Class, Cost, Range, PrereqTech, 18, RangedCombat, Moves+1, 1, FaithCost,	RequiresFaithPurchaseEnabled, CombatClass, MilitarySupport, MilitaryProduction,	Domain, Pillage, IgnoreBuildingDefense, ObsoleteTech, GoodyHutUpgradeUnitClass, XPValueAttack, XPValueDefense, Conscription,  DefaultUnitAI, ('TXT_KEY_UNIT_SENSHI_JAHAZI'),	('TXT_KEY_CIV5_UNIT_SENSHI_JAHAZI_TEXT'), 	('TXT_KEY_UNIT_SENSHI_JAHAZI_HELP'), 	('TXT_KEY_UNIT_SENSHI_JAHAZI_STRATEGY'),	AdvancedStartCost, 	('ART_DEF_UNIT_SENSHI_JAHAZI'),  0,					('SENSHI_JAHAZI_FLAG'),	2, 				('SENSHI_ZANZIBAR_ATLAS')
FROM Units WHERE (Type = 'UNIT_CARAVEL');
--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================
INSERT INTO UnitGameplay2DScripts
(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT		('UNIT_SENSHI_JAHAZI'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_CARAVEL');
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes
(UnitType, 					UnitAIType)
SELECT		('UNIT_SENSHI_JAHAZI'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_CARAVEL');
--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================
INSERT INTO Unit_ClassUpgrades
(UnitType, 					UnitClassType)
SELECT		('UNIT_SENSHI_JAHAZI'), 	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_CARAVEL');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors
(UnitType, 					FlavorType, Flavor)
SELECT		'UNIT_SENSHI_JAHAZI', 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_CARAVEL');
--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions
			(UnitType, 					PromotionType)
SELECT		'UNIT_SENSHI_JAHAZI',		PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_CARAVEL');
--==========================================================================================================================
--==========================================================================================================================
