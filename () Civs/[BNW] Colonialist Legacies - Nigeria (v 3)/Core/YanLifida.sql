--=======================================================================================================================
-- BUILDINGCLASSES
--=======================================================================================================================
-- BuildingClasses
------------------------------	
INSERT INTO BuildingClasses
		(Type, 								DefaultBuilding, 			Description)
VALUES	('BUILDINGCLASS_CL_YAN_LIFIDA', 	'BUILDING_CL_YAN_LIFIDA',	'TXT_KEY_BUILDING_BUILDING_CL_YAN_LIFIDA');
--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================	
-- Buildings
------------------------------	
INSERT INTO Buildings		
		(Type, 						BuildingClass, 			  			Cost, 	FaithCost,	GreatWorkCount,	Description, 								Help,											NeverCapture)
VALUES	('BUILDING_CL_YAN_LIFIDA',  'BUILDINGCLASS_CL_YAN_LIFIDA', 		-1, 	-1,			-1,				'TXT_KEY_BUILDING_BUILDING_CL_YAN_LIFIDA', 	'TXT_KEY_BUILDING_BUILDING_CL_YAN_LIFIDA_HELP',	1);
------------------------------
-- Building_YieldModifiers
------------------------------
INSERT INTO Building_YieldModifiers
		(BuildingType,				YieldType,		Yield)
VALUES	('BUILDING_CL_YAN_LIFIDA',	'YIELD_FOOD',	5);
--==========================================================================================================================
-- Units
--==========================================================================================================================
INSERT INTO Units
(Type, 												Class, Cost, Range, PrereqTech, Combat, RangedCombat, Moves, FaithCost,	RequiresFaithPurchaseEnabled, CombatClass, MilitarySupport, MilitaryProduction, Domain, Pillage, IgnoreBuildingDefense, ObsoleteTech, GoodyHutUpgradeUnitClass, XPValueAttack, XPValueDefense, Conscription,  DefaultUnitAI, Description, 						Civilopedia, 							Help, 									Strategy,									AdvancedStartCost,	UnitArtInfo, 					  UnitFlagIconOffset,	UnitFlagAtlas,						PortraitIndex, 	IconAtlas)
SELECT		('UNIT_CL_YAN_LIFIDA'),		Class, 135, Range, PrereqTech, Combat, RangedCombat, Moves, FaithCost, RequiresFaithPurchaseEnabled, CombatClass, MilitarySupport, MilitaryProduction,	Domain, Pillage, IgnoreBuildingDefense, ObsoleteTech, GoodyHutUpgradeUnitClass, XPValueAttack, XPValueDefense, Conscription,  DefaultUnitAI, ('TXT_KEY_UNIT_CL_YAN_LIFIDA'),	('TXT_KEY_UNIT_CIV5_CL_YAN_LIFIDA_TEXT'), 	('TXT_KEY_UNIT_CL_YAN_LIFIDA_HELP'), 	('TXT_KEY_UNIT_CL_YAN_LIFIDA_STRATEGY'),	AdvancedStartCost, 	('ART_DEF_UNIT_CL_YAN_LIFIDA'),  0,					('CL_UNIT_FLAG_YAN_LIFIDA_ATLAS'),	3, 				('CL_NIGERIA_ATLAS')
FROM Units WHERE (Type = 'UNIT_KNIGHT');
--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================
INSERT INTO UnitGameplay2DScripts
(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT		('UNIT_CL_YAN_LIFIDA'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_KNIGHT');
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes
(UnitType, 					UnitAIType)
SELECT		('UNIT_CL_YAN_LIFIDA'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_KNIGHT');
--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================
INSERT INTO Unit_ClassUpgrades
(UnitType, 					UnitClassType)
SELECT		('UNIT_CL_YAN_LIFIDA'), 	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_KNIGHT');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors
(UnitType, 					FlavorType, Flavor)
SELECT		'UNIT_CL_YAN_LIFIDA', 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_KNIGHT');
--==========================================================================================================================
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================
INSERT INTO Unit_ResourceQuantityRequirements
			(UnitType, 							ResourceType)
VALUES		('UNIT_CL_YAN_LIFIDA', 	'RESOURCE_HORSE');
--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 								PromotionType)
VALUES		('UNIT_CL_YAN_LIFIDA', 		'PROMOTION_COVER_1'),
			('UNIT_CL_YAN_LIFIDA', 		'PROMOTION_CL_KANAJEJI');

INSERT INTO Unit_FreePromotions
			(UnitType, 					PromotionType)
SELECT		'UNIT_CL_YAN_LIFIDA',		PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_KNIGHT');
--==========================================================================================================================
--==========================================================================================================================
