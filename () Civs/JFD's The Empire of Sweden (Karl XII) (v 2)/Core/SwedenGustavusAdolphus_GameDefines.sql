--=======================================================================================================================
-- MASTER TABLES
--=======================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CustomModOptions(Name Text, Value INTEGER, Class INTEGER, DbUpdates INTEGER);
CREATE TABLE IF NOT EXISTS JFD_GlobalUserSettings (Type text, Value integer default 1);
--=======================================================================================================================	
-- UNITS
--=======================================================================================================================
------------------------------------------------------------------------------------------------------------------------	
-- UnitPromotions
------------------------------------------------------------------------------------------------------------------------
INSERT OR REPLACE INTO UnitPromotions 
		(Type, 								LostWithUpgrade,	Description, 							Help, 										Sound, 				CannotBeChosen, PortraitIndex,  IconAtlas, 			PediaType, 			PediaEntry)
VALUES	('PROMOTION_JFD_REGAL_SHIP_1',		1,					'TXT_KEY_PROMOTION_JFD_REGAL_SHIP_1',	'TXT_KEY_PROMOTION_JFD_REGAL_SHIP_1_HELP',	'AS2D_IF_LEVELUP',	1, 				32, 			'PROMOTION_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_REGAL_SHIP_1'),
		('PROMOTION_JFD_REGAL_SHIP_2',		0,					'TXT_KEY_PROMOTION_JFD_REGAL_SHIP_2',	'TXT_KEY_PROMOTION_JFD_REGAL_SHIP_2_HELP',	'AS2D_IF_LEVELUP',	1, 				59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_REGAL_SHIP_2');
------------------------------------------------------------------------------------------------------------------------	
-- UnitPromotion_Terrains
------------------------------------------------------------------------------------------------------------------------
DELETE FROM UnitPromotions_Terrains WHERE PromotionType = 'PROMOTION_JFD_REGAL_SHIP_2';
INSERT INTO UnitPromotions_Terrains
		(PromotionType,					TerrainType,	  Attack,  Defense)
VALUES	('PROMOTION_JFD_REGAL_SHIP_2',	'TERRAIN_COAST',  20,	   20);
------------------------------------------------------------------------------------------------------------------------
-- Units
------------------------------------------------------------------------------------------------------------------------	
INSERT OR REPLACE INTO Units 	
		(Type, 					Class, PrereqTech, Combat, RangedCombat, Cost, Moves, HurryCostModifier, Range, CombatClass, Domain, DefaultUnitAI, MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, Mechanized, AdvancedStartCost, MinAreaSize, XPValueAttack, XPValueDefense, MoveRate, Description, 					  Help, 								Strategy, 								 Civilopedia, 							UnitArtInfo, 					UnitFlagAtlas,									 UnitFlagIconOffset,	IconAtlas,									PortraitIndex)
SELECT	'UNIT_JFD_REGAL_SHIP',	Class, PrereqTech, Combat, RangedCombat, Cost, Moves, HurryCostModifier, Range, CombatClass, Domain, DefaultUnitAI, MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, Mechanized, AdvancedStartCost, MinAreaSize, XPValueAttack, XPValueDefense, MoveRate, 'TXT_KEY_UNIT_JFD_REGAL_SHIP',	  'TXT_KEY_UNIT_JFD_REGAL_SHIP_HELP', 	'TXT_KEY_UNIT_JFD_REGAL_SHIP_STRATEGY',  'TXT_KEY_UNIT_JFD_REGAL_SHIP_TEXT',	'ART_DEF_UNIT_JFD_REGAL_SHIP',	'JFD_SWEDEN_GUSTAVUS_ADOLPHUS_UNIT_FLAG_ATLAS',  0,						'JFD_SWEDEN_GUSTAVUS_ADOLPHUS_ICON_ATLAS',	0
FROM Units WHERE Type = 'UNIT_FRIGATE';
------------------------------------------------------------------------------------------------------------------------		
-- Unit_AITypes
------------------------------------------------------------------------------------------------------------------------
DELETE FROM Unit_AITypes WHERE UnitType = 'UNIT_JFD_REGAL_SHIP';		
INSERT INTO Unit_AITypes 	
		(UnitType, 				UnitAIType)
SELECT	'UNIT_JFD_REGAL_SHIP', 	UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_FRIGATE';
------------------------------------------------------------------------------------------------------------------------	
-- Unit_ClassUpgrades
------------------------------------------------------------------------------------------------------------------------	
DELETE FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_JFD_REGAL_SHIP';
INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 				UnitClassType)
SELECT	'UNIT_JFD_REGAL_SHIP',	UnitClassType
FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_FRIGATE';	
------------------------------------------------------------------------------------------------------------------------	
-- Unit_Flavors
------------------------------------------------------------------------------------------------------------------------	
DELETE FROM Unit_Flavors WHERE UnitType = 'UNIT_JFD_REGAL_SHIP';	
INSERT INTO Unit_Flavors 	
		(UnitType, 				FlavorType, Flavor)
SELECT	'UNIT_JFD_REGAL_SHIP', 	FlavorType, Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_FRIGATE';
------------------------------------------------------------------------------------------------------------------------	
-- Unit_FreePromotions
------------------------------------------------------------------------------------------------------------------------	
DELETE FROM Unit_FreePromotions WHERE UnitType = 'UNIT_JFD_REGAL_SHIP';
INSERT INTO Unit_FreePromotions 	
		(UnitType, 				PromotionType)
SELECT	'UNIT_JFD_REGAL_SHIP', 	PromotionType
FROM Unit_FreePromotions WHERE UnitType = 'UNIT_FRIGATE';	

INSERT INTO Unit_FreePromotions
		(UnitType, 				PromotionType)
VALUES	('UNIT_JFD_REGAL_SHIP', 'PROMOTION_JFD_REGAL_SHIP_1'),
		('UNIT_JFD_REGAL_SHIP', 'PROMOTION_JFD_REGAL_SHIP_2');	
------------------------------------------------------------------------------------------------------------------------	
-- Unit_ResourceQuantityRequirements
------------------------------------------------------------------------------------------------------------------------
DELETE FROM Unit_ResourceQuantityRequirements WHERE UnitType = 'UNIT_JFD_REGAL_SHIP';	
INSERT INTO Unit_ResourceQuantityRequirements 	
		(UnitType, 				ResourceType, Cost)
SELECT	'UNIT_JFD_REGAL_SHIP', 	ResourceType, Cost
FROM Unit_ResourceQuantityRequirements WHERE UnitType = 'UNIT_FRIGATE';
------------------------------------------------------------------------------------------------------------------------	
-- UnitGameplay2DScripts
------------------------------------------------------------------------------------------------------------------------	
DELETE FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_JFD_REGAL_SHIP';	
INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 				SelectionSound,	FirstSelectionSound)
SELECT	'UNIT_JFD_REGAL_SHIP', 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_FRIGATE';
--=======================================================================================================================	
-- CIVILIZATIONS
--=======================================================================================================================	
------------------------------------------------------------------------------------------------------------------------	
-- Civilizations 
------------------------------------------------------------------------------------------------------------------------
UPDATE Civilizations
SET IconAtlas = 'JFD_SWEDEN_KARL_XII_ICON_ATLAS', AlphaIconAtlas = 'JFD_SWEDEN_KARL_XII_ALPHA_ATLAS', PortraitIndex = 0
WHERE Type = 'CIVILIZATION_SWEDEN';
------------------------------------------------------------------------------------------------------------------------	
-- Civilization_UnitClassOverrides 
------------------------------------------------------------------------------------------------------------------------	
DELETE FROM Civilization_UnitClassOverrides WHERE CivilizationType = 'CIVILIZATION_SWEDEN' AND UnitType = 'UNIT_SWEDISH_CAROLEAN';	
DELETE FROM Civilization_UnitClassOverrides WHERE CivilizationType = 'CIVILIZATION_SWEDEN' AND UnitType = 'UNIT_JFD_REGAL_SHIP';	
INSERT INTO Civilization_UnitClassOverrides 
		(CivilizationType, 		UnitClassType, 			UnitType)
VALUES	('CIVILIZATION_SWEDEN',	'UNITCLASS_FRIGATE',	'UNIT_JFD_REGAL_SHIP');
------------------------------------------------------------------------------------------------------------------------	
-- Civilization_Start_Along_Ocean 
------------------------------------------------------------------------------------------------------------------------	
DELETE FROM Civilization_Start_Along_Ocean WHERE CivilizationType = 'CIVILIZATION_SWEDEN';	
INSERT INTO Civilization_Start_Along_Ocean
		(CivilizationType, 		StartAlongOcean)
VALUES	('CIVILIZATION_SWEDEN', 1);
--=======================================================================================================================
--=======================================================================================================================