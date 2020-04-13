--==========================================================================================================================
-- Units
--==========================================================================================================================
INSERT INTO Units
(Type, 												Class, Cost, Range, AirInterceptRange, PrereqTech, Combat, RangedCombat, Moves, MoveRate, Immobile, FaithCost,	RequiresFaithPurchaseEnabled, CombatClass, MilitarySupport, MilitaryProduction, Special, Domain, Pillage, CombatLimit, RangedCombatLimit, IgnoreBuildingDefense, Mechanized, AirUnitCap, ObsoleteTech, GoodyHutUpgradeUnitClass, XPValueAttack, XPValueDefense, Conscription,  DefaultUnitAI, Description, 						Civilopedia, 							Help, 									Strategy,									AdvancedStartCost,	UnitArtInfo, 					  UnitFlagIconOffset,	UnitFlagAtlas,						PortraitIndex, 	IconAtlas)
SELECT		('UNIT_CL_UGBOELU'),		Class, Cost, Range, AirInterceptRange, PrereqTech, Combat, RangedCombat, Moves, MoveRate, Immobile, FaithCost, RequiresFaithPurchaseEnabled, CombatClass, MilitarySupport, MilitaryProduction, Special,	Domain, Pillage, CombatLimit, RangedCombatLimit, IgnoreBuildingDefense, Mechanized, AirUnitCap, ObsoleteTech, GoodyHutUpgradeUnitClass, XPValueAttack, XPValueDefense, Conscription,  DefaultUnitAI, ('TXT_KEY_UNIT_CL_UGBOELU'),	('TXT_KEY_UNIT_CIV5_CL_UGBOELU_TEXT'), 	('TXT_KEY_UNIT_CL_UGBOELU_HELP'), 	('TXT_KEY_UNIT_CL_UGBOELU_STRATEGY'),	AdvancedStartCost, 	('ART_DEF_UNIT_CL_UGBOELU'),  0,					('CL_UNIT_FLAG_UGBOELU_ATLAS'),	2, 				('CL_NIGERIA_ATLAS')
FROM Units WHERE (Type = 'UNIT_FIGHTER');
--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================
INSERT INTO UnitGameplay2DScripts
(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT		('UNIT_CL_UGBOELU'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_FIGHTER');
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes
(UnitType, 					UnitAIType)
SELECT		('UNIT_CL_UGBOELU'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_FIGHTER');
--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================
INSERT INTO Unit_ClassUpgrades
(UnitType, 					UnitClassType)
SELECT		('UNIT_CL_UGBOELU'), 	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_FIGHTER');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors
(UnitType, 					FlavorType, Flavor)
SELECT		'UNIT_CL_UGBOELU', 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_FIGHTER');
--==========================================================================================================================
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================
INSERT INTO Unit_ResourceQuantityRequirements
			(UnitType, 							ResourceType)
VALUES		('UNIT_CL_UGBOELU', 	'RESOURCE_OIL');
--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 								PromotionType)
VALUES		('UNIT_CL_UGBOELU', 		'PROMOTION_BOMBARDMENT_1');

INSERT INTO Unit_FreePromotions
			(UnitType, 					PromotionType)
SELECT		'UNIT_CL_UGBOELU',		PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_FIGHTER');
--==========================================================================================================================
--==========================================================================================================================
