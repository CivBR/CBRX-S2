--=======================================================================================================================
-- BINGLES CIV IV TRAITS
--=======================================================================================================================
-- Leader_SharedTraits
------------------------------  
CREATE TABLE IF NOT EXISTS
    Leader_SharedTraits (
    LeaderType          text    REFERENCES Leaders(TYPE)        DEFAULT NULL,
    TraitOne            text    REFERENCES Policies(TYPE)       DEFAULT NULL,
    TraitTwo            text    REFERENCES Policies(TYPE)       DEFAULT NULL);
     
INSERT INTO Leader_SharedTraits
        (LeaderType,                TraitOne,               TraitTwo)
SELECT  'LEADER_MC_TIN_HINAN',        'POLICY_PROTECTIVE_X',   'POLICY_DIPLOMATIC_X'
WHERE EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');
------------------------------  
-- Leaders
------------------------------  
UPDATE Leaders
SET Description = 'Carol I [ICON_STRENGTH][ICON_INFLUENCE]'
WHERE TYPE = 'LEADER_MC_TIN_HINAN'
AND EXISTS (SELECT * FROM Policies WHERE TYPE = 'POLICY_PHILOSOPHICAL_X');

--==========================================================================================================================
-- JFD USER SETTINGS
--==========================================================================================================================
-- JFD_GlobalUserSettings
-------------------------------------
CREATE TABLE IF NOT EXISTS 
JFD_GlobalUserSettings (
	Type 											text 										default null,
	Value 											integer 									default 1);

--==========================================================================================================================
-- Events & Decisions
--==========================================================================================================================
-- DecisionsAddin_Support
------------------------------
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('MC_Tuareg_Decisions.lua');

------------------------------
-- Policies
------------------------------ 
INSERT INTO Policies    
        (TYPE,                      Description)
VALUES  ('POLICY_MC_TUAREG_OIL',   'POLICY_MC_TUAREG_OIL');

------------------------------
-- Policy_ImprovementYieldChanges
------------------------------
INSERT INTO Policy_ImprovementYieldChanges
		(PolicyType,				ImprovementType,		YieldType,		Yield)
VALUES	('POLICY_MC_TUAREG_OIL',	'IMPROVEMENT_WELL',		'YIELD_GOLD',	2);
--==========================================================================================================================
-- ENLIGHTENMENT ERA
--==========================================================================================================================
-- Units
------------------------------------------------------------
INSERT OR REPLACE INTO Units 	
		(Type, 							Class, PrereqTech, Combat, RangedCombat, Cost, Range, FaithCost,	RequiresFaithPurchaseEnabled, Moves, CombatClass, Domain, DefaultUnitAI, Description, 								Civilopedia, 									Strategy, 											Help, 										MilitarySupport, MilitaryProduction, Pillage, IgnoreBuildingDefense, AdvancedStartCost, CombatLimit, ObsoleteTech, XPValueDefense, GoodyHutUpgradeUnitClass, UnitArtInfo, 						UnitFlagIconOffset, UnitFlagAtlas,					PortraitIndex, 	IconAtlas)
SELECT	'UNIT_MC_TUAREG_IMAJAGHAN', 	Class, PrereqTech, Combat, RangedCombat, Cost, Range, FaithCost,	RequiresFaithPurchaseEnabled, Moves, CombatClass, Domain, DefaultUnitAI, 'TXT_KEY_UNIT_MC_TUAREG_IMAJAGHAN', 		'TXT_KEY_UNIT_MC_TUAREG_IMAJAGHAN_PEDIA', 		'TXT_KEY_UNIT_MC_TUAREG_IMAJAGHAN_STRATEGY', 		'TXT_KEY_UNIT_MC_TUAREG_IMAJAGHAN_HELP_EE',	MilitarySupport, MilitaryProduction, Pillage, IgnoreBuildingDefense, AdvancedStartCost, CombatLimit, ObsoleteTech, XPValueDefense, GoodyHutUpgradeUnitClass, 'ART_DEF_UNIT_TUAREG_IMAJAGHAN',	0,					'MC_TUAREG_IMAJAGHAN_FLAG',		2, 				'MC_TUAREG_ATLAS'
FROM Units WHERE Type = 'UNIT_EE_SKIRMISHER'
AND EXISTS (SELECT * FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');
------------------------------------------------------------
-- Unit_ClassUpgrades
------------------------------------------------------------
DELETE FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_MC_TUAREG_IMAJAGHAN'
AND EXISTS (SELECT * FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');
INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 					UnitClassType)
SELECT	'UNIT_MC_TUAREG_IMAJAGHAN',		 UnitClassType
FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_EE_SKIRMISHER'
AND EXISTS (SELECT * FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');
------------------------------------------------------------
-- Civilization_UnitClassOverrides
------------------------------------------------------------
UPDATE Civilization_UnitClassOverrides
SET UnitClassType = 'UNITCLASS_EE_SKIRMISHER'
WHERE CivilizationType = 'CIVILIZATION_MC_TUAREG' AND UnitType = 'UNIT_MC_TUAREG_IMAJAGHAN'
AND EXISTS (SELECT * FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');	
--==========================================================================================================================
-- JFD CULTURAL DIVERSITY
--==========================================================================================================================
-- Civilization_JFD_CultureTypes
------------------------------  
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes(
	CivilizationType 							text 	REFERENCES Civilizations(Type) 			default null,
	CultureType 								text											default null,
	ArtDefineTag								text											default	null,
	DefeatScreenEarlyTag						text											default	null,
	DefeatScreenMidTag							text											default	null,
	DefeatScreenLateTag							text											default	null,
	IdealsTag									text											default	null,
	SplashScreenTag								text											default	null,
	SoundtrackTag								text											default	null,
	UnitDialogueTag								text											default null);
     
INSERT INTO Civilization_JFD_CultureTypes
        (CivilizationType,           ArtDefineTag, CultureType, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT  'CIVILIZATION_MC_TUAREG',   ArtDefineTag, CultureType, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_RUSSIA';
------------------------------  
-- Civilizations
------------------------------  
UPDATE Civilizations
SET SoundtrackTag = 'JFD_Eastern'
WHERE TYPE = 'CIVILIZATION_MC_TUAREG'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Eastern')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE TYPE = 'JFD_CULDIV_SOUNDTRACK_ADDON' AND VALUE = 1);

--==========================================================================================================================
-- JFD's Cities in Development
--==========================================================================================================================
-- Civilization_JFD_ColonialCityNames
------------------------------  
CREATE TABLE IF NOT EXISTS
Civilization_JFD_ColonialCityNames (
    CivilizationType                            text    REFERENCES Civilizations(TYPE)      DEFAULT NULL,
    ColonyName                                  text                                        DEFAULT NULL,
    LinguisticType                              text                                        DEFAULT NULL,
    CultureType                                 text                                        DEFAULT NULL);
 
INSERT OR REPLACE INTO Civilization_JFD_ColonialCityNames
        (CivilizationType,             LinguisticType)
VALUES  ('CIVILIZATION_MC_TUAREG',    'JFD_Slavic');
--==========================================================  
-- JFD's CiD: Slavery
--==========================================================    
-- Flavors
------------------------------------------------------------    
INSERT OR REPLACE INTO Flavors
        (TYPE)
VALUES  ('FLAVOR_JFD_SLAVERY');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------    
--A value of 0-10 may be set. This value determines the proclivity a civ has toward enslaving a captured city and toward spending Slavery on Units.
INSERT INTO Leader_Flavors
        (LeaderType,            FlavorType,                 Flavor)
VALUES  ('LEADER_MC_TIN_HINAN',   'FLAVOR_JFD_SLAVERY',       4);
--==========================================================================================================================
-- TOMATEKH HISTORICAL RELIGIONS
--==========================================================================================================================
-- Civilization_Religions
------------------------------
--UPDATE Civilization_Religions
--SET ReligionType = 'RELIGION_SLAVINISM'
--WHERE CivilizationType = 'CIVILIZATION_MC_TUAREG'
--AND EXISTS (SELECT * FROM Religions WHERE Type = 'RELIGION_SLAVINISM');
--==========================================================================================================================
-- HAZEL MAP LABELS
--==========================================================================================================================
-- ML_CivCultures
------------------------------  
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
        (CivType,                       CultureType,        CultureEra)
VALUES  ('CIVILIZATION_MC_TUAREG',      'EUROPEAN',         'ANCIENT');
--==========================================================================================================================  
-- JFD's and Pouakai's MERCENARIES
--==========================================================================================================================
-- Flavors
------------------------------------------------------------    
INSERT OR REPLACE INTO Flavors
        (TYPE)
VALUES  ('FLAVOR_JFD_MERCENARY');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------    
--A value of 1-10 may be set. This value determines the likelihood that a leader will take out Mercenary Contracts (provided they have the funds).
--A value of 10 means this civilization will always take a Contract if available. A value of 0 means this civilization will never take out a contract.
INSERT OR REPLACE INTO Leader_Flavors
        (LeaderType,            FlavorType,                 Flavor)
VALUES  ('LEADER_MC_TIN_HINAN',   'FLAVOR_JFD_MERCENARY',     5);
--==========================================================================================================================    
-- JFD's Rise to Power
--==========================================================================================================================
--==========================================================  
-- JFD's RtP: Piety
--==========================================================
-- Flavors
------------------------------------------------------------    
INSERT OR REPLACE INTO Flavors
        (TYPE)
VALUES  ('FLAVOR_JFD_RELIGIOUS_INTOLERANCE');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------    
--A value of 1-12 may be set. This value determines the diplomatic penalty/bonus with civilizations of a different/same state religion
--A value higher than 9 means this civilization will never secularise. A value of 0 means this civilization has no interest in State Religion.
INSERT INTO Leader_Flavors
        (LeaderType,            FlavorType,                             Flavor)
VALUES  ('LEADER_MC_TIN_HINAN',   'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',     6);
--==========================================================  
-- JFD's RtP: Prosperity
--==========================================================
-- Civilization_JFD_Currencies
------------------------------------------------------------
--CREATE TABLE IF NOT EXISTS
--    Civilization_JFD_Currencies (
--    CivilizationType                text        REFERENCES Civilizations(TYPE)  DEFAULT NULL,
--    CurrencyType                    text                                        DEFAULT NULL);
-- 
--INSERT INTO Civilization_JFD_Currencies
--        (CivilizationType,                   CurrencyType)
--VALUES	( 'CIVILIZATION_MC_TUAREG',         'CURRENCY_JFD_DINAR');
--==========================================================  
-- JFD's RtP: Sovereignty
--==========================================================
------------------------------------------------------------    
-- Civilization_JFD_Governments
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS
    Civilization_JFD_Governments (
    CivilizationType                text        REFERENCES Civilizations(TYPE)                  DEFAULT NULL,
    CultureType                     text                                                        DEFAULT NULL,
    LegislatureName                 text                                                        DEFAULT NULL,
    OfficeTitle                     text                                                        DEFAULT NULL,
    GovernmentType                  text                                                        DEFAULT NULL,
    Weight                          INTEGER                                                     DEFAULT 0);
 
INSERT INTO Civilization_JFD_Governments
        (CivilizationType,        LegislatureName, OfficeTitle, GovernmentType, Weight)
SELECT  'CIVILIZATION_MC_TUAREG', LegislatureName, OfficeTitle, GovernmentType, Weight
FROM Civilization_JFD_Governments WHERE CivilizationType = 'CIVILIZATION_RUSSIA';
------------------------------------------------------------
-- Civilization_JFD_Politics
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS
    Civilization_JFD_Politics (
    CivilizationType                    text        REFERENCES Civilizations(TYPE)                  DEFAULT NULL,
    PoliticsType                        text                                                        DEFAULT NULL,
    UniqueName                          text                                                        DEFAULT NULL);
 
INSERT INTO Civilization_JFD_Politics
        (CivilizationType,          PoliticsType, UniqueName)
SELECT  ('CIVILIZATION_MC_TUAREG'), PoliticsType, UniqueName
FROM Civilization_JFD_Politics WHERE CivilizationType = 'CIVILIZATION_RUSSIA';
------------------------------------------------------------
-- Flavors
------------------------------------------------------------    
INSERT OR REPLACE INTO Flavors
        (TYPE)
VALUES  ('FLAVOR_JFD_REFORM_GOVERNMENT'),
        ('FLAVOR_JFD_REFORM_CULTURE'),
        ('FLAVOR_JFD_REFORM_ECONOMIC'),
        ('FLAVOR_JFD_REFORM_FOREIGN'),
        ('FLAVOR_JFD_REFORM_INDUSTRY'),
        ('FLAVOR_JFD_REFORM_MILITARY'),
        ('FLAVOR_JFD_REFORM_RELIGION');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------    
--Each flavour corresponds to one of the seven Reform Categories, and how likely a civ is to take a reform in either the Right, Centre, or Left column.
--A value of 1-3 will favour Left Reforms. A value of 4-6 will value Centre Reforms. A value of 7-10 will value Right Reforms. The strength of the value will determine how soon a Leader will implement that Reform.
INSERT OR REPLACE INTO Leader_Flavors
        (LeaderType,         	 FlavorType,                         Flavor)
VALUES  ('LEADER_MC_TIN_HINAN',    'FLAVOR_JFD_REFORM_GOVERNMENT',     6),
        ('LEADER_MC_TIN_HINAN',    'FLAVOR_JFD_REFORM_CULTURE',        5),
        ('LEADER_MC_TIN_HINAN',    'FLAVOR_JFD_REFORM_ECONOMIC',       4),
        ('LEADER_MC_TIN_HINAN',    'FLAVOR_JFD_REFORM_FOREIGN',        5),
        ('LEADER_MC_TIN_HINAN',    'FLAVOR_JFD_REFORM_INDUSTRY',       5),
        ('LEADER_MC_TIN_HINAN',    'FLAVOR_JFD_REFORM_LEGAL',       	 5),
        ('LEADER_MC_TIN_HINAN',    'FLAVOR_JFD_REFORM_MILITARY',       7),
        ('LEADER_MC_TIN_HINAN',    'FLAVOR_JFD_REFORM_RELIGION',       6);
--==========================================================================================================================
-- R.E.D. / Ethnic Units
--==========================================================================================================================
-- Civilizations
------------------------------  
UPDATE Civilizations
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_RUSSIA' )
    THEN '_RUSSIA'
    ELSE '_EURO' END)
WHERE TYPE = 'CIVILIZATION_MC_TUAREG';
--==========================================================================================================================
-- YnAEMP v24
--==========================================================================================================================
-- Civilizations_YagemStartPosition (Earth Giant)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
        (TYPE,                          X,  Y)
VALUES  ('CIVILIZATION_MC_TUAREG',     30, 63);
 
CREATE TABLE IF NOT EXISTS MinorCiv_YagemStartPosition(TYPE, X, Y, AltX, AltY);
UPDATE MinorCiv_YagemStartPosition
SET X = 32, Y = 66
WHERE Type = 'MINOR_CIV_BUCHAREST';
------------------------------------------------------------    
-- Civilizations_YahemStartPosition (Earth Huge)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
        (TYPE,                          X,  Y)
VALUES  ('CIVILIZATION_MC_TUAREG',     68, 57);

CREATE TABLE IF NOT EXISTS MinorCiv_YahemStartPosition(TYPE, X, Y, AltX, AltY);
UPDATE MinorCiv_YahemStartPosition
SET X = 69, Y = 58
WHERE Type = 'MINOR_CIV_BUCHAREST';
------------------------------------------------------------    
-- Civilizations_CordiformStartPosition (Earth Standard)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
        (TYPE,                          X,  Y)
VALUES  ('CIVILIZATION_MC_TUAREG',     43, 28);

CREATE TABLE IF NOT EXISTS MinorCiv_CordiformStartPosition(TYPE, X, Y, AltX, AltY);
UPDATE MinorCiv_CordiformStartPosition
SET X = 44, Y = 29
WHERE Type = 'MINOR_CIV_BUCHAREST';
------------------------------------------------------------    
-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
        (TYPE,                          X,  Y)
VALUES  ('CIVILIZATION_MC_TUAREG',     55, 48);

CREATE TABLE IF NOT EXISTS MinorCiv_GreatestEarthStartPosition(TYPE, X, Y, AltX, AltY);
UPDATE MinorCiv_GreatestEarthStartPosition
SET X = 58, Y = 50
WHERE Type = 'MINOR_CIV_BUCHAREST';
------------------------------------------------------------    
-- Civilizations_EuroLargeStartPosition (Europe Large)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroLargeStartPosition
        (TYPE,                          X,  Y)
VALUES  ('CIVILIZATION_MC_TUAREG',     50, 37);

CREATE TABLE IF NOT EXISTS MinorCiv_EuroLargeStartPosition(TYPE, X, Y, AltX, AltY);
UPDATE MinorCiv_EuroLargeStartPosition
SET X = 52, Y = 42
WHERE Type = 'MINOR_CIV_BUCHAREST';
------------------------------------------------------------    
-- Civilizations_EuroGiantStartPosition (Europe Giant)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_EuroGiantStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroGiantStartPosition
        (TYPE,                          X,   Y)
VALUES  ('CIVILIZATION_MC_TUAREG',     101, 44);

CREATE TABLE IF NOT EXISTS MinorCiv_EuroGiantStartPosition(TYPE, X, Y, AltX, AltY);
UPDATE MinorCiv_EuroGiantStartPosition
SET X = 104, Y = 59
WHERE Type = 'MINOR_CIV_BUCHAREST';
------------------------------------------------------------    
-- Civilizations_MediterraneanStartPosition (Mediterranean)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_MediterraneanStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_MediterraneanStartPosition
        (TYPE,                          X,  Y)
VALUES  ('CIVILIZATION_MC_TUAREG',     72, 52);

CREATE TABLE IF NOT EXISTS MinorCiv_MediterraneanStartPosition(TYPE, X, Y, AltX, AltY);
UPDATE MinorCiv_MediterraneanStartPosition
SET X = 67, Y = 61
WHERE Type = 'MINOR_CIV_BUCHAREST';
------------------------------------------------------------    
-- Civilizations_EuroLargeNewStartPosition (Europe (Greatest) Large)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeNewStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroLargeNewStartPosition
        (TYPE,                          X,  Y)
VALUES  ('CIVILIZATION_MC_TUAREG',     54, 29);

CREATE TABLE IF NOT EXISTS MinorCiv_EuroLargeNewStartPosition(TYPE, X, Y, AltX, AltY);
UPDATE MinorCiv_EuroLargeNewStartPosition
SET X = 56, Y = 37
WHERE Type = 'MINOR_CIV_BUCHAREST';
------------------------------------------------------------    
-- Civilizations_EuroEasternStartPosition (Eastern Europe)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_EuroEasternStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroEasternStartPosition
        (TYPE,                          X,  Y)
VALUES  ('CIVILIZATION_MC_TUAREG',     45, 6);

CREATE TABLE IF NOT EXISTS MinorCiv_EuroEasternStartPosition(TYPE, X, Y, AltX, AltY);
UPDATE MinorCiv_EuroEasternStartPosition
SET X = 47, Y = 19
WHERE Type = 'MINOR_CIV_BUCHAREST';
--==========================================================================================================================
--==========================================================================================================================