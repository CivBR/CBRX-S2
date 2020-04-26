--==========================================================================================================================
-- Units
--==========================================================================================================================
INSERT INTO Units
(Type, 										Class, Cost, Range, PrereqTech, Combat, RangedCombat,	Moves, FaithCost,	RequiresFaithPurchaseEnabled, CombatClass, MilitarySupport, MilitaryProduction, Domain, Pillage, IgnoreBuildingDefense, ObsoleteTech, GoodyHutUpgradeUnitClass, XPValueAttack, XPValueDefense, Conscription,  DefaultUnitAI, Description, 						Civilopedia, 							Help, 									Strategy,									AdvancedStartCost,	UnitArtInfo, 					  UnitFlagIconOffset,	UnitFlagAtlas,						PortraitIndex, 	IconAtlas)
SELECT		('UNIT_SENSHI_RABONA'),		Class, Cost, Range+1, PrereqTech, Combat, 24,	Moves, FaithCost,	RequiresFaithPurchaseEnabled, CombatClass, MilitarySupport, MilitaryProduction,	Domain, Pillage, IgnoreBuildingDefense, ObsoleteTech, GoodyHutUpgradeUnitClass, XPValueAttack, XPValueDefense, Conscription,  DefaultUnitAI, ('TXT_KEY_UNIT_SENSHI_RABONA'),	('TXT_KEY_CIV5_UNIT_SENSHI_RABONA_TEXT'), 	('TXT_KEY_UNIT_SENSHI_RABONA_HELP'), 	('TXT_KEY_UNIT_SENSHI_RABONA_STRATEGY'),	AdvancedStartCost, 	('ART_DEF_UNIT_SENSHI_RABONA'),  0,					('SENSHI_RABONA_FLAG'),	2, 				('SENSHI_PERUBOLIVIA_ATLAS')
FROM Units WHERE (Type = 'UNIT_GATLINGGUN');
--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================
INSERT INTO UnitGameplay2DScripts
(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT		('UNIT_SENSHI_RABONA'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_RIFLEMAN');
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes
(UnitType, 					UnitAIType)
SELECT		('UNIT_SENSHI_RABONA'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_GATLINGGUN');
--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================
INSERT INTO Unit_ClassUpgrades
(UnitType, 					UnitClassType)
SELECT		('UNIT_SENSHI_RABONA'), 	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_GATLINGGUN');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors
(UnitType, 					FlavorType, Flavor)
SELECT		'UNIT_SENSHI_RABONA', 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_GATLINGGUN');
--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 								PromotionType)
VALUES		('UNIT_SENSHI_RABONA', 		'PROMOTION_INDIRECT_FIRE'),
			('UNIT_SENSHI_RABONA', 		'PROMOTION_SENSHI_RABONA');

INSERT INTO Unit_FreePromotions
			(UnitType, 					PromotionType)
SELECT		'UNIT_SENSHI_RABONA',		PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_GATLINGGUN');
--==========================================================================================================================
--==========================================================================================================================
