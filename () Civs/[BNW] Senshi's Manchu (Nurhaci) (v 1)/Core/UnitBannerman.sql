--==========================================================================================================================
-- Units
--==========================================================================================================================
INSERT INTO Units
(Type, 												Class, Cost, Range, PrereqTech, Combat, RangedCombat, Moves, FaithCost,	RequiresFaithPurchaseEnabled, CombatClass, MilitarySupport, MilitaryProduction, Domain, Pillage, IgnoreBuildingDefense, ObsoleteTech, GoodyHutUpgradeUnitClass, XPValueAttack, XPValueDefense, Conscription,  DefaultUnitAI, Description, 						Civilopedia, 							Help, 									Strategy,									AdvancedStartCost,	UnitArtInfo, 					  UnitFlagIconOffset,	UnitFlagAtlas,						PortraitIndex, 	IconAtlas)
SELECT		('UNIT_SENSHI_BANNERMAN'),		Class, 175, 2, PrereqTech, 20, 25, Moves, FaithCost, RequiresFaithPurchaseEnabled, ('UNITCOMBAT_ARCHER'), MilitarySupport, MilitaryProduction,	Domain, Pillage, IgnoreBuildingDefense, ObsoleteTech, GoodyHutUpgradeUnitClass, XPValueAttack, XPValueDefense, Conscription,  ('UNITAI_RANGED'), ('TXT_KEY_UNIT_SENSHI_BANNERMAN'),	('TXT_KEY_CIV5_UNIT_SENSHI_BANNERMAN_TEXT'), 	('TXT_KEY_UNIT_SENSHI_BANNERMAN_HELP'), 	('TXT_KEY_UNIT_SENSHI_BANNERMAN_STRATEGY'),	AdvancedStartCost, 	('ART_DEF_UNIT_SENSHI_BANNERMAN'),  0,					('SENSHI_BANNERMAN_FLAG'),	2, 				('SENSHI_MANCHU_ATLAS')
FROM Units WHERE (Type = 'UNIT_LANCER');
--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================
INSERT INTO UnitGameplay2DScripts
(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT		('UNIT_SENSHI_BANNERMAN'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_MONGOLIAN_KESHIK');
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes
(UnitType, 					UnitAIType)
SELECT		('UNIT_SENSHI_BANNERMAN'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_MONGOLIAN_KESHIK');
--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================
INSERT INTO Unit_ClassUpgrades
(UnitType, 					UnitClassType)
SELECT		('UNIT_SENSHI_BANNERMAN'), 	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_LANCER');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors
(UnitType, 					FlavorType, Flavor)
SELECT		'UNIT_SENSHI_BANNERMAN', 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_MONGOLIAN_KESHIK');
--==========================================================================================================================
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================
INSERT INTO Unit_ResourceQuantityRequirements
			(UnitType, 							ResourceType)
VALUES		('UNIT_SENSHI_BANNERMAN', 	'RESOURCE_HORSE');
--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 								PromotionType)
VALUES		('UNIT_SENSHI_BANNERMAN', 		'PROMOTION_ONLY_DEFENSIVE'),
			('UNIT_SENSHI_BANNERMAN', 		'PROMOTION_INDIRECT_FIRE');

INSERT INTO Unit_FreePromotions
			(UnitType, 					PromotionType)
SELECT		'UNIT_SENSHI_BANNERMAN',		PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_LANCER');
--==========================================================================================================================
--==========================================================================================================================
