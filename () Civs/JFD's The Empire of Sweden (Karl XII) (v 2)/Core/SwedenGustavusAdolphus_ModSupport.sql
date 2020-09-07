--=======================================================================================================================	
-- UNITS
--=======================================================================================================================
------------------------------------------------------------------------------------------------------------------------
-- Units
------------------------------------------------------------------------------------------------------------------------	
INSERT OR REPLACE INTO Units 	
		(Type, 					Class, PrereqTech, Combat, RangedCombat, Cost, Moves, HurryCostModifier, Range, CombatClass, Domain, DefaultUnitAI, MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, Mechanized, AdvancedStartCost, MinAreaSize, XPValueAttack, XPValueDefense, MoveRate, Description, 						Help, 									Strategy, 									Civilopedia, 							UnitArtInfo, 					UnitFlagAtlas,									 UnitFlagIconOffset,	IconAtlas,									PortraitIndex)
SELECT	'UNIT_JFD_REGAL_SHIP',	Class, PrereqTech, Combat, RangedCombat, Cost, Moves, HurryCostModifier, Range, CombatClass, Domain, DefaultUnitAI, MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, Mechanized, AdvancedStartCost, MinAreaSize, XPValueAttack, XPValueDefense, MoveRate, 'TXT_KEY_UNIT_JFD_REGAL_SHIP',		'TXT_KEY_UNIT_JFD_REGAL_SHIP_HELP', 	'TXT_KEY_UNIT_JFD_REGAL_SHIP_STRATEGY_EE',  'TXT_KEY_UNIT_JFD_REGAL_SHIP_TEXT',		'ART_DEF_UNIT_JFD_REGAL_SHIP',	'JFD_SWEDEN_GUSTAVUS_ADOLPHUS_UNIT_FLAG_ATLAS',  0,						'JFD_SWEDEN_GUSTAVUS_ADOLPHUS_ICON_ATLAS',	0
FROM Units WHERE Type = 'UNIT_EE_GALLEON'
AND EXISTS (SELECT * FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');
------------------------------------------------------------------------------------------------------------------------		
-- Unit_AITypes
------------------------------------------------------------------------------------------------------------------------		
DELETE FROM Unit_AITypes WHERE UnitType = 'UNIT_JFD_REGAL_SHIP'
AND EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_EE_GALLEON');		
INSERT INTO Unit_AITypes 	
		(UnitType, 				UnitAIType)
SELECT	'UNIT_JFD_REGAL_SHIP', 	UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_EE_GALLEON'
AND EXISTS (SELECT * FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');
------------------------------------------------------------------------------------------------------------------------	
-- Unit_ClassUpgrades
------------------------------------------------------------------------------------------------------------------------		
DELETE FROM Unit_AITypes WHERE UnitType = 'UNIT_JFD_REGAL_SHIP'
AND EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_EE_GALLEON');		
INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 				UnitClassType)
SELECT	'UNIT_JFD_REGAL_SHIP',	UnitClassType
FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_EE_GALLEON'
AND EXISTS (SELECT * FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');	
------------------------------------------------------------------------------------------------------------------------	
-- Unit_Flavors
------------------------------------------------------------------------------------------------------------------------	
DELETE FROM Unit_Flavors WHERE UnitType = 'UNIT_JFD_REGAL_SHIP'
AND EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_EE_GALLEON');		
INSERT INTO Unit_Flavors 	
		(UnitType, 				FlavorType, Flavor)
SELECT	'UNIT_JFD_REGAL_SHIP', 	FlavorType, Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_EE_GALLEON'
AND EXISTS (SELECT * FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');
------------------------------------------------------------------------------------------------------------------------	
-- Unit_FreePromotions
------------------------------------------------------------------------------------------------------------------------		
DELETE FROM Unit_FreePromotions WHERE UnitType = 'UNIT_JFD_REGAL_SHIP'
AND EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_EE_GALLEON');		
INSERT INTO Unit_FreePromotions 	
		(UnitType, 				PromotionType)
SELECT	'UNIT_JFD_REGAL_SHIP', 	PromotionType
FROM Unit_FreePromotions WHERE UnitType = 'UNIT_EE_GALLEON'
AND EXISTS (SELECT * FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');
------------------------------------------------------------------------------------------------------------------------	
-- Unit_ResourceQuantityRequirements
------------------------------------------------------------------------------------------------------------------------	
DELETE FROM Unit_ResourceQuantityRequirements WHERE UnitType = 'UNIT_JFD_REGAL_SHIP'
AND EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_EE_GALLEON');		
INSERT INTO Unit_ResourceQuantityRequirements 	
		(UnitType, 				ResourceType, Cost)
SELECT	'UNIT_JFD_REGAL_SHIP', 	ResourceType, Cost
FROM Unit_ResourceQuantityRequirements WHERE UnitType = 'UNIT_EE_GALLEON'
AND EXISTS (SELECT * FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');
------------------------------------------------------------------------------------------------------------------------	
-- UnitGameplay2DScripts
------------------------------------------------------------------------------------------------------------------------		
DELETE FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_JFD_REGAL_SHIP'
AND EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_EE_GALLEON');		
INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 				SelectionSound,	FirstSelectionSound)
SELECT	'UNIT_JFD_REGAL_SHIP', 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_EE_GALLEON'
AND EXISTS (SELECT * FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');
--=======================================================================================================================	
-- CIVILIZATIONS
--=======================================================================================================================	
------------------------------------------------------------------------------------------------------------------------	
-- Civilization_UnitClassOverrides 
------------------------------------------------------------------------------------------------------------------------	
DELETE FROM Civilization_UnitClassOverrides WHERE CivilizationType = 'CIVILIZATION_SWEDEN' AND UnitType = 'UNIT_JFD_REGAL_SHIP'
AND EXISTS (SELECT * FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');	
INSERT INTO Civilization_UnitClassOverrides 
		(CivilizationType, 		UnitClassType, 			UnitType)
SELECT	'CIVILIZATION_SWEDEN',	'UNITCLASS_EE_GALLEON',	'UNIT_JFD_REGAL_SHIP'
WHERE EXISTS (SELECT * FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');
--=======================================================================================================================
--=======================================================================================================================