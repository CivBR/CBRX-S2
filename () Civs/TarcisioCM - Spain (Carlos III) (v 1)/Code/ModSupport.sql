--==========================================================================================================================
--This SQL file handles most of the mod support.
--==========================================================================================================================
--==========================================================================================================================
-- Sukritact's Decisions
--==========================================================================================================================
-- DecisionsAddin_Support
------------------------------
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('tcmBourbonSpainDecisions.lua');
--==========================================================================================================================
-- Sukritact's Events
--==========================================================================================================================
-- EventsAddin_Support
------------------------------
CREATE TABLE IF NOT EXISTS EventsAddin_Support(FileName);
INSERT INTO EventsAddin_Support (FileName) VALUES ('tcmBourbonSpainEvents.lua');
--==========================================================================================================================
INSERT INTO Policies
                (Type,              				Description,										CultureFromKills)
VALUES          ('POLICY_TCM_BOURBON_INTENDANCY',   'TXT_KEY_DECISIONS_TCM_BOURBON_SPAIN_INTENDANCIES', -1),
				('POLICY_TCM_BOURBON_PACTE',		'TXT_KEY_DECISIONS_TCM_BOURBON_SPAIN_PACT',			100);

INSERT INTO Policy_SpecialistExtraYields
                (PolicyType,              			YieldType,		Yield)
VALUES          ('POLICY_TCM_BOURBON_INTENDANCY',  'YIELD_GOLD',	2);

INSERT INTO Policy_UnitCombatProductionModifiers
                (PolicyType,          				 UnitCombatType,    	   ProductionModifier)
VALUES          ('POLICY_TCM_BOURBON_INTENDANCY',   'UNITCOMBAT_NAVALMELEE',   20),
				('POLICY_TCM_BOURBON_INTENDANCY',   'UNITCOMBAT_NAVALRANGED',  20),
				('POLICY_TCM_BOURBON_INTENDANCY',   'UNITCOMBAT_SUBMARINE',    20),
				('POLICY_TCM_BOURBON_INTENDANCY',   'UNITCOMBAT_CARRIER',      20);

INSERT INTO Policy_FreePromotions
                (PolicyType,          				PromotionType)
VALUES          ('POLICY_TCM_BOURBON_INTENDANCY',   'PROMOTION_TCM_BOURBON_PACT');
--==========================================================================================================================
-- Bingle's Civ IV Traits
--==========================================================================================================================
-- Leader_SharedTraits
------------------------------	
CREATE TABLE IF NOT EXISTS 
    Leader_SharedTraits (
    LeaderType          text    REFERENCES Leaders(Type)        default null,
    TraitOne            text    REFERENCES Policies(Type)       default null,
    TraitTwo            text    REFERENCES Policies(Type)       default null);
      
INSERT INTO Leader_SharedTraits
        (LeaderType,             TraitOne,                   TraitTwo)
VALUES  ('LEADER_TCM_CHARLES_III', 'POLICY_CHARISMATIC_X',   'POLICY_MERCANTILE_X');
------------------------------  
-- Leaders
------------------------------  
UPDATE Leaders 
SET Description = 'Carlos III [ICON_HAPPINESS_1][ICON_GOLD]'
WHERE Type = 'LEADER_TCM_CHARLES_III'
AND EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');
--==========================================================================================================================
-- GEDEMON R.E.D.
--==========================================================================================================================
-- Civilizations
------------------------------  
UPDATE Civilizations 
SET ArtStyleSuffix = '_SPAIN'
WHERE Type = 'CIVILIZATION_TCM_BOURBON_SPAIN'
AND EXISTS (SELECT * FROM Civilizations WHERE ArtStyleSuffix = '_SPAIN');


--==========================================================================================================================
-- Gedemon's YnAEMP
--==========================================================================================================================
-- Civilizations_YagemStartPosition (Earth Giant)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
			(Type,													X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_TCM_BOURBON_SPAIN',						9,		57,		null,	null);
--==========================================================================================================================
-- Civilizations_YahemStartPosition (Earth Huge)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
			(Type,													X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_TCM_BOURBON_SPAIN',						56,		54,		null,	null);
--==========================================================================================================================
-- Civilizations_CordiformStartPosition (Earth Standard)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
			(Type,													X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_TCM_BOURBON_SPAIN',						32,		24,		null,	null);
--==========================================================================================================================
-- Civilizations_EuroLargeStartPosition (Europe Large)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroLargeStartPosition
			(Type,													X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_TCM_BOURBON_SPAIN',						19,		29,		null,	null);
--==========================================================================================================================
-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
			(Type,													X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_TCM_BOURBON_SPAIN',						37,		38,		null,	null);
--==========================================================================================================================
-- Civilizations_NorthAtlanticStartPosition 
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_NorthAtlanticStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthAtlanticStartPosition
			(Type,													X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_TCM_BOURBON_SPAIN',						85,		9,		null,	null);
--==========================================================================================================================
-- Civilizations_AmericasStartPosition 
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_AmericasStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AmericasStartPosition
			(Type,													X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_TCM_BOURBON_SPAIN',						48,		43,		null,	null);
--==========================================================================================================================
-- Civilizations_CaribbeanStartPosition 
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_CaribbeanStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CaribbeanStartPosition
			(Type,													X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_TCM_BOURBON_SPAIN',						44,		55,		null,	null);
--==========================================================================================================================
-- Civilizations_MediterraneanStartPosition 
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_MediterraneanStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_MediterraneanStartPosition
			(Type,													X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_TCM_BOURBON_SPAIN',						10,		40,		null,	null);
--==========================================================================================================================
-- Civilizations_YagemRequestedResource (Earth Giant)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource
			(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_TCM_BOURBON_SPAIN'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE Type = 'CIVILIZATION_SPAIN';
--==========================================================================================================================
-- Civilizations_YahemRequestedResource (Earth Huge)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_YahemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YahemRequestedResource
			(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_TCM_BOURBON_SPAIN'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE Type = 'CIVILIZATION_SPAIN';
--==========================================================================================================================
-- Civilizations_EuroLargeRequestedResource (Europe Large)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_EuroLargeRequestedResource
			(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_TCM_BOURBON_SPAIN'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_EuroLargeRequestedResource WHERE Type = 'CIVILIZATION_SPAIN';
--==========================================================================================================================
-- Civilizations_GreatestEarthRequestedResource (Earth Greatest)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_GreatestEarthRequestedResource
			(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_TCM_BOURBON_SPAIN'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_GreatestEarthRequestedResource WHERE Type = 'CIVILIZATION_SPAIN';
--==========================================================================================================================
-- Hazel's Map Labels
--==========================================================================================================================
-- ML_CivCultures
------------------------------	
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
			(CivType,							CultureType,		CultureEra)
VALUES		('CIVILIZATION_TCM_BOURBON_SPAIN',	'EUROPEAN ',		'ANY');
--==========================================================================================================================
-- JFD USER SETTINGS
--==========================================================================================================================
-- JFD_GlobalUserSettings
-------------------------------------
CREATE TABLE IF NOT EXISTS 
JFD_GlobalUserSettings (
    Type                                            text                                        default null,
    Value                                           integer                                     default 1);
--==========================================================================================================================
-- JFD CULTURAL DIVERSITY
--==========================================================================================================================
-- Civilization_JFD_CultureTypes
------------------------------  
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes(
    CivilizationType                            text    REFERENCES Civilizations(Type)          default null,
    CultureType                                 text                                            default null,
    ArtDefineTag                                text                                            default null,
    SplashScreenTag                             text                                            default null,
    SoundtrackTag                               text                                            default null,
    UnitDialogueTag                             text                                            default null);
 
INSERT INTO Civilization_JFD_CultureTypes
        (CivilizationType,                  ArtDefineTag, CultureType, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT  'CIVILIZATION_TCM_BOURBON_SPAIN',   ArtDefineTag, CultureType, SplashScreenTag, SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_SPAIN';
------------------------------  
-- Civilizations
------------------------------  
UPDATE Civilizations 
SET SoundtrackTag = 'JFD_Western'
WHERE Type = 'CIVILIZATION_TCM_BOURBON_SPAIN'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Western')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CULDIV_SOUNDTRACK_ADDON' AND Value = 1);
--==========================================================================================================================
-- JFD's Exploration Continued Expanded
--==========================================================================================================================
-- Civilization_JFD_ColonialCityNames
------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_ColonialCityNames (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	ColonyName 									text										default null,
	LinguisticType								text										default	null,
	CultureType									text										default	null);

INSERT OR REPLACE INTO Civilization_JFD_ColonialCityNames
			(CivilizationType, 					ColonyName,									LinguisticType)
VALUES		('CIVILIZATION_TCM_BOURBON_SPAIN',	null,										'JFD_Latinate'),
			('CIVILIZATION_TCM_BOURBON_SPAIN',  'TXT_KEY_COLONY_NAME_TCM_BOURBON_SPAIN_01', null),
			('CIVILIZATION_TCM_BOURBON_SPAIN',  'TXT_KEY_COLONY_NAME_TCM_BOURBON_SPAIN_02', null),
			('CIVILIZATION_TCM_BOURBON_SPAIN',  'TXT_KEY_COLONY_NAME_TCM_BOURBON_SPAIN_03', null),
			('CIVILIZATION_TCM_BOURBON_SPAIN',  'TXT_KEY_COLONY_NAME_TCM_BOURBON_SPAIN_04', null),
			('CIVILIZATION_TCM_BOURBON_SPAIN',  'TXT_KEY_COLONY_NAME_TCM_BOURBON_SPAIN_05', null),
			('CIVILIZATION_TCM_BOURBON_SPAIN',  'TXT_KEY_COLONY_NAME_TCM_BOURBON_SPAIN_06', null),
			('CIVILIZATION_TCM_BOURBON_SPAIN',  'TXT_KEY_COLONY_NAME_TCM_BOURBON_SPAIN_07', null),
			('CIVILIZATION_TCM_BOURBON_SPAIN',  'TXT_KEY_COLONY_NAME_TCM_BOURBON_SPAIN_08', null),
			('CIVILIZATION_TCM_BOURBON_SPAIN',  'TXT_KEY_COLONY_NAME_TCM_BOURBON_SPAIN_09', null),
			('CIVILIZATION_TCM_BOURBON_SPAIN',  'TXT_KEY_COLONY_NAME_TCM_BOURBON_SPAIN_10', null),
			('CIVILIZATION_TCM_BOURBON_SPAIN',  'TXT_KEY_COLONY_NAME_TCM_BOURBON_SPAIN_11', null);
------------------------------	
-- Civilization_JFD_RevolutionaryCivilizationsToSpawn
------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_RevolutionaryCivilizationsToSpawn (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	RevolutionaryCivilizationType 				text 	REFERENCES Civilizations(Type) 		default null);
	
INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,					RevolutionaryCivilizationType)
VALUES		('CIVILIZATION_TCM_BOURBON_SPAIN',	'CIVILIZATION_SPAIN'),
			('CIVILIZATION_SPAIN',				'CIVILIZATION_TCM_BOURBON_SPAIN'),
			('CIVILIZATION_FRANCE',				'CIVILIZATION_TCM_BOURBON_SPAIN');
--==========================================================================================================================	
-- JFD's Piety & Prestige
--==========================================================================================================================			
------------------------------					
-- Flavors
------------------------------	
INSERT OR REPLACE INTO Flavors 
			(Type)
VALUES		('FLAVOR_JFD_RELIGIOUS_INTOLERANCE');
------------------------------
-- Leader_Flavors
------------------------------
INSERT INTO Leader_Flavors
			(LeaderType,				FlavorType,								Flavor)
VALUES		('LEADER_TCM_CHARLES_III',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',		3);
--==========================================================================================================================    
-- JFD's and Pouakai's MERCENARIES
--==========================================================================================================================
-- Flavors
------------------------------------------------------------    
INSERT OR REPLACE INTO Flavors 
        (Type)
VALUES  ('FLAVOR_JFD_MERCENARY');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------    
INSERT INTO Leader_Flavors
        (LeaderType,				 FlavorType,                 Flavor)
VALUES  ('LEADER_TCM_CHARLES_III',    'FLAVOR_JFD_MERCENARY',     5);
--==========================================================================================================================
-- POUAKAI ENLIGHTENMENT ERA
--==========================================================================================================================
-- Units
------------------------------  
UPDATE Units
SET PrereqTech = 'TECH_EE_FLINTLOCK', ObsoleteTech = 'TECH_RIFLING', Class = 'UNITCLASS_EE_LINE_INFANTRY', Combat = 30, Cost = 185, FaithCost = 370, Help = 'TXT_KEY_UNIT_HELP_TCM_WALLOON_GUARD_EE', GoodyHutUpgradeUnitClass = 'UNITCLASS_RIFLEMAN'
WHERE Type = 'UNIT_TCM_WALLOON_GUARD'
AND EXISTS (SELECT * FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');
------------------------------  
-- Unit_ClassUpgrades
------------------------------  
UPDATE Unit_ClassUpgrades
SET UnitClassType = 'UNITCLASS_RIFLEMAN'
WHERE UnitType = 'UNIT_TCM_WALLOON_GUARD'
AND EXISTS (SELECT * FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');
------------------------------  
-- Civilization_UnitClassOverrides
------------------------------
UPDATE Civilization_UnitClassOverrides
SET UnitClassType = 'UNITCLASS_EE_LINE_INFANTRY'
WHERE CivilizationType = 'CIVILIZATION_TCM_BOURBON_SPAIN' AND UnitType = 'UNIT_TCM_WALLOON_GUARD'
AND EXISTS (SELECT * FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');

------------------------------
-- Units
------------------------------  
UPDATE Units
SET ObsoleteTech = 'TECH_EE_ARMOUR_PLATING', Class = 'UNITCLASS_EE_SHIP_OF_THE_LINE', Combat = 42, Cost = 210, FaithCost = 420, Range = -1, RangedCombat = -1, Help = 'TXT_KEY_UNIT_HELP_TCM_SANTISIMA_TRINIDAD_EE', GoodyHutUpgradeUnitClass = 'UNITCLASS_IRONCLAD'
WHERE Type = 'UNIT_TCM_SANTISIMA_TRINIDAD'
AND EXISTS (SELECT * FROM Units WHERE Type = 'UNIT_EE_SHIP_OF_THE_LINE');
------------------------------  
-- Unit_ClassUpgrades
------------------------------  
UPDATE Unit_ClassUpgrades
SET UnitClassType = 'UNITCLASS_IRONCLAD'
WHERE UnitType = 'UNIT_TCM_SANTISIMA_TRINIDAD_UPGRADEABLE'
AND EXISTS (SELECT * FROM Units WHERE Type = 'UNIT_EE_SHIP_OF_THE_LINE');
------------------------------  
-- Civilization_UnitClassOverrides
------------------------------
UPDATE Civilization_UnitClassOverrides
SET UnitClassType = 'UNITCLASS_EE_SHIP_OF_THE_LINE'
WHERE CivilizationType = 'CIVILIZATION_TCM_BOURBON_SPAIN' AND UnitType = 'UNIT_TCM_SANTISIMA_TRINIDAD'
AND EXISTS (SELECT * FROM Units WHERE Type = 'UNIT_EE_SHIP_OF_THE_LINE');
------------------------------
DELETE FROM Unit_FreePromotions WHERE UnitType = 'UNIT_TCM_SANTISIMA_TRINIDAD'
AND EXISTS (SELECT * FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');

INSERT INTO Unit_FreePromotions 	
		(UnitType, 				PromotionType)
SELECT	'UNIT_TCM_SANTISIMA_TRINIDAD', 	PromotionType
FROM Unit_FreePromotions WHERE UnitType = 'UNIT_EE_SHIP_OF_THE_LINE'
AND EXISTS (SELECT * FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');

------------------------------
-- Units
------------------------------  
UPDATE Units
SET ObsoleteTech = 'TECH_EE_ARMOUR_PLATING', Class = 'UNITCLASS_EE_SHIP_OF_THE_LINE', Combat = 42, Cost = 210, FaithCost = -1, Range = -1, RangedCombat = -1, Help = 'TXT_KEY_UNIT_HELP_TCM_SANTISIMA_TRINIDAD_EE', GoodyHutUpgradeUnitClass = 'UNITCLASS_IRONCLAD'
WHERE Type = 'UNIT_TCM_SANTISIMA_TRINIDAD_UPGRADEABLE'
AND EXISTS (SELECT * FROM Units WHERE Type = 'UNIT_EE_SHIP_OF_THE_LINE');

DELETE FROM Unit_FreePromotions WHERE UnitType = 'UNIT_TCM_SANTISIMA_TRINIDAD_UPGRADEABLE'
AND EXISTS (SELECT * FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');

INSERT INTO Unit_FreePromotions 	
		(UnitType, 				PromotionType)
SELECT	'UNIT_TCM_SANTISIMA_TRINIDAD_UPGRADEABLE', 	PromotionType
FROM Unit_FreePromotions WHERE UnitType = 'UNIT_TCM_SANTISIMA_TRINIDAD_UPGRADEABLE'
AND EXISTS (SELECT * FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');
--
UPDATE Units
SET JFD_CannotBeMercenary = 1
WHERE Type = 'UNIT_TCM_SANTISIMA_TRINIDAD_UPGRADEABLE'
AND EXISTS (SELECT * FROM Units WHERE Type = 'UNIT_JFD_GAESATAE');

UPDATE Units
SET JFD_CannotBeMercenary = 1
WHERE Type = 'UNIT_TCM_SANTISIMA_TRINIDAD_HUGE_COST_1'
AND EXISTS (SELECT * FROM Units WHERE Type = 'UNIT_JFD_GAESATAE');

