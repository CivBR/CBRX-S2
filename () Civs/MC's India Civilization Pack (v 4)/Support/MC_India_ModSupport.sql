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
 
INSERT OR REPLACE INTO Leader_SharedTraits
			(LeaderType,									          TraitOne,					 TraitTwo)
SELECT		('LEADER_MC_ASHOKA'),		            ('POLICY_AGGRESSIVE_X'),	  ('POLICY_SPIRITUAL_X')
WHERE EXISTS (SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');
    
INSERT OR REPLACE INTO Leader_SharedTraits
			(LeaderType,									          TraitOne,					 TraitTwo)
SELECT		('LEADER_MC_RAJA_RAJA_I'),		            ('POLICY_SEAFARING_X'),	  ('POLICY_DIPLOMATIC_X')
WHERE EXISTS (SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');

INSERT OR REPLACE INTO Leader_SharedTraits
			(LeaderType,									          TraitOne,					 TraitTwo)
SELECT		('LEADER_MC_SHIVAJI'),		            ('POLICY_AGGRESSIVE_X'),	  ('POLICY_PROTECTIVE_X')
WHERE EXISTS (SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');

INSERT OR REPLACE INTO Leader_SharedTraits
			(LeaderType,									          TraitOne,					 TraitTwo)
SELECT		('LEADER_MC_AKBAR'),		            ('POLICY_PHILOSOPHICAL_X'),	  ('POLICY_INDUSTRIOUS_X')
WHERE EXISTS (SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');
 
------------------------------  
-- Leaders
------------------------------  
UPDATE Leaders
SET Description = (CASE WHEN EXISTS(SELECT * FROM Policies WHERE TYPE = 'POLICY_PHILOSOPHICAL_X' )
THEN 'Ashoka [ICON_WAR][ICON_PEACE]'
ELSE 'TXT_KEY_LEADER_MC_ASHOKA_DESC' END)
WHERE TYPE = 'LEADER_MC_ASHOKA';
 
UPDATE Leaders
SET Description = (CASE WHEN EXISTS(SELECT * FROM Policies WHERE TYPE = 'POLICY_PHILOSOPHICAL_X' )
THEN 'Raja Raja I [ICON_MOVES][ICON_INFLUENCE]'
ELSE 'TXT_KEY_LEADER_MC_RAJA_RAJA_I_DESC' END)
WHERE TYPE = 'LEADER_MC_RAJA_RAJA_I';
 
UPDATE Leaders
SET Description = (CASE WHEN EXISTS(SELECT * FROM Policies WHERE TYPE = 'POLICY_PHILOSOPHICAL_X' )
THEN 'Shivaji [ICON_WAR][ICON_STRENGTH]'
ELSE 'TXT_KEY_LEADER_MC_SHIVAJI_DESC' END)
WHERE TYPE = 'LEADER_MC_SHIVAJI';
 
UPDATE Leaders
SET Description = (CASE WHEN EXISTS(SELECT * FROM Policies WHERE TYPE = 'POLICY_PHILOSOPHICAL_X' )
THEN 'Akbar [ICON_GREAT_PEOPLE][ICON_PRODUCTION]'
ELSE 'TXT_KEY_LEADER_MC_AKBAR_DESC' END)
WHERE TYPE = 'LEADER_MC_AKBAR';
--==========================================================================================================================
-- ENLIGHTENMENT ERA
--==========================================================================================================================
------------------------------
-- Units
------------------------------
-- Sepoy
INSERT OR REPLACE INTO Units    
        (TYPE,                      Class, PrereqTech, Combat,  Cost,   FaithCost,  RequiresFaithPurchaseEnabled, Moves, CombatClass, DOMAIN, DefaultUnitAI, Description,                           Civilopedia,                                        Strategy,                                       Help,                                   MilitarySupport, MilitaryProduction, Pillage, IgnoreBuildingDefense, AdvancedStartCost, CombatLimit, ObsoleteTech, XPValueDefense, GoodyHutUpgradeUnitClass, UnitArtInfo,                       UnitFlagIconOffset, UnitFlagAtlas,                  PortraitIndex,  IconAtlas)
SELECT  'UNIT_MC_MARATHAN_SEPOY',   Class, PrereqTech, 2,       145,    FaithCost,  RequiresFaithPurchaseEnabled, Moves, CombatClass, DOMAIN, DefaultUnitAI, 'TXT_KEY_UNIT_MC_MARATHAN_SEPOY',      'TXT_KEY_UNIT_MC_MARATHAN_SEPOY_CIVILOPEDIA',       'TXT_KEY_UNIT_MC_MARATHAN_SEPOY_STRATEGY',      'TXT_KEY_UNIT_MC_MARATHAN_SEPOY_HELP',  MilitarySupport, MilitaryProduction, Pillage, IgnoreBuildingDefense, AdvancedStartCost, CombatLimit, ObsoleteTech, XPValueDefense, GoodyHutUpgradeUnitClass, 'ART_DEF_UNIT_MC_MARATHAN_SEPOY',  0,                  'MC_MARATHAN_SEPOY_FLAG',       9,              'MC_INDIA_ATLAS'
FROM Units WHERE TYPE = 'UNIT_EE_LINE_INFANTRY'
AND EXISTS (SELECT * FROM Technologies WHERE TYPE = 'TECH_EE_FLINTLOCK');
 
-- Kadatpadai
INSERT OR REPLACE INTO Units    
        (TYPE,                      Class, PrereqTech, Combat,  Cost,   FaithCost,  RequiresFaithPurchaseEnabled, Moves, CombatClass, DOMAIN, DefaultUnitAI, Description,                           Civilopedia,                                    Strategy,                                       Help,                                   MilitarySupport, MilitaryProduction, Pillage, IgnoreBuildingDefense, AdvancedStartCost, CombatLimit, ObsoleteTech, XPValueDefense, GoodyHutUpgradeUnitClass, UnitArtInfo,                           UnitFlagIconOffset, UnitFlagAtlas,                  PortraitIndex,  IconAtlas)
SELECT  'UNIT_MC_CHOLA_KADATPADI',  Class, PrereqTech, Combat,  Cost,   FaithCost,  RequiresFaithPurchaseEnabled, Moves, CombatClass, DOMAIN, DefaultUnitAI, 'TXT_KEY_UNIT_MC_CHOLA_KADATPADI',     'TXT_KEY_UNIT_MC_CHOLA_KADATPADI_CIVILOPEDIA',  'TXT_KEY_UNIT_MC_CHOLA_KADATPADI_STRATEGY',     'TXT_KEY_UNIT_MC_CHOLA_KADATPADI_HELP', MilitarySupport, MilitaryProduction, Pillage, IgnoreBuildingDefense, AdvancedStartCost, CombatLimit, ObsoleteTech, XPValueDefense, GoodyHutUpgradeUnitClass, 'ART_DEF_UNIT_MC_CHOLA_KADATPADAI',    0,                  'MC_CHOLA_KADATPADAI_FLAG',     10,             'MC_INDIA_ATLAS'
FROM Units WHERE TYPE = 'UNIT_EE_GALLEON'
AND EXISTS (SELECT * FROM Technologies WHERE TYPE = 'TECH_EE_FLINTLOCK');
------------------------------
-- Unit_ClassUpgrades
------------------------------
UPDATE Unit_ClassUpgrades
SET UnitClassType = 'UNITCLASS_EE_UHLAN'
WHERE UnitType ='UNIT_MC_MARATHAN_PINDARI'
AND EXISTS (SELECT * FROM Units WHERE Class = 'UNITCLASS_EE_CARRACK');
 
UPDATE Unit_ClassUpgrades
SET UnitClassType = 'UNITCLASS_EE_SHIP_OF_THE_LINE'
WHERE UnitType ='UNIT_MC_CHOLA_KADATPADAI'
AND EXISTS (SELECT * FROM Units WHERE Class = 'UNITCLASS_EE_CARRACK');
 
--==========================================================================================================================
-- JFD USER SETTINGS
--==========================================================================================================================
-- JFD_GlobalUserSettings
-------------------------------------
CREATE TABLE IF NOT EXISTS
JFD_GlobalUserSettings (
    TYPE                                            text                                        DEFAULT NULL,
    VALUE                                           INTEGER                                     DEFAULT 1);
--==========================================================================================================================
-- Events & Decisions
--==========================================================================================================================
-- DecisionsAddin_Support
------------------------------
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('MC_India_Decisions.lua');
 
INSERT INTO Policies
        (TYPE,                                          Description)
VALUES  ('POLICY_DECISIONS_MC_GREAT_LIVING_TEMPLES',    'TXT_KEY_DECISIONS_MC_CHOLA_GREAT_LIVING_TEMPLES');
--------------------------------------------------------------------------------------------------------------------------
-- Policy_BuildingClassYieldChanges
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_BuildingClassYieldChanges
        (PolicyType,                                    BuildingClassType,              YieldType,          YieldChange)
VALUES  ('POLICY_DECISIONS_MC_GREAT_LIVING_TEMPLES',    'BUILDINGCLASS_TEMPLE',         'YIELD_CULTURE',    1),
        ('POLICY_DECISIONS_MC_GREAT_LIVING_TEMPLES',    'BUILDINGCLASS_TEMPLE',         'YIELD_FAITH',      1),
        ('POLICY_DECISIONS_MC_GREAT_LIVING_TEMPLES',    'BUILDINGCLASS_GRAND_TEMPLE',   'YIELD_CULTURE',    2),
        ('POLICY_DECISIONS_MC_GREAT_LIVING_TEMPLES',    'BUILDINGCLASS_GRAND_TEMPLE',   'YIELD_FAITH',      2);
--------------------------------------------------------------------------------------------------------------------------
-- Policy_BuildingClassHappiness
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_BuildingClassHappiness
        (PolicyType,                                    BuildingClassType,              Happiness)
VALUES  ('POLICY_DECISIONS_MC_GREAT_LIVING_TEMPLES',    'BUILDINGCLASS_TEMPLE',         1),
        ('POLICY_DECISIONS_MC_GREAT_LIVING_TEMPLES',    'BUILDINGCLASS_GRAND_TEMPLE',   2);
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
        (CivilizationType,              ArtDefineTag, CultureType, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT  'CIVILIZATION_MC_MARATHA',      ArtDefineTag, CultureType, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_INDIA';

INSERT INTO Civilization_JFD_CultureTypes
        (CivilizationType,              ArtDefineTag, CultureType, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT  'CIVILIZATION_MC_MAURYA',       ArtDefineTag, CultureType, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_INDIA';

INSERT INTO Civilization_JFD_CultureTypes
        (CivilizationType,              ArtDefineTag, CultureType, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT  'CIVILIZATION_MC_CHOLA',        ArtDefineTag, CultureType, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_INDIA';
 
INSERT INTO Civilization_JFD_CultureTypes
        (CivilizationType,              ArtDefineTag, CultureType, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT  'CIVILIZATION_MC_MUGHAL',       ArtDefineTag, CultureType, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_ARABIA';
------------------------------  
-- Civilizations
------------------------------  
UPDATE Civilizations
SET SoundtrackTag = 'JFD_Islamic'
WHERE TYPE = 'CIVILIZATION_MC_MUGHAL'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Islamic')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE TYPE = 'JFD_CULDIV_SOUNDTRACK_ADDON' AND VALUE = 1);
 
UPDATE Civilizations
SET SoundtrackTag = 'JFD_Bharata'
WHERE TYPE = 'CIVILIZATION_MC_MARATHA'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Bharata')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE TYPE = 'JFD_CULDIV_SOUNDTRACK_ADDON' AND VALUE = 1);
 
UPDATE Civilizations
SET SoundtrackTag = 'JFD_Bharata'
WHERE TYPE = 'CIVILIZATION_MC_MAURYA'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Bharata')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE TYPE = 'JFD_CULDIV_SOUNDTRACK_ADDON' AND VALUE = 1);
 
UPDATE Civilizations
SET SoundtrackTag = 'JFD_Bharata'
WHERE TYPE = 'CIVILIZATION_MC_CHOLA'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Bharata')
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
            (CivilizationType,                      ColonyName,                             LinguisticType)
VALUES      ('CIVILIZATION_MC_MUGHAL',              NULL,                                   'JFD_Indo_Iranian'),
            ('CIVILIZATION_MC_MARATHA',             NULL,                                   'JFD_Indo_Iranian'),
            ('CIVILIZATION_MC_MAURYA',              NULL,                                   'JFD_Indo_Iranian'),
            ('CIVILIZATION_MC_CHOLA',               NULL,                                   'JFD_Indo_Iranian');
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
        (LeaderType,                FlavorType,             Flavor)
VALUES  ('LEADER_MC_RAJA_RAJA_I',   'FLAVOR_JFD_SLAVERY',   4),
        ('LEADER_MC_SHIVAJI',       'FLAVOR_JFD_SLAVERY',   7),
        ('LEADER_MC_AKBAR',         'FLAVOR_JFD_SLAVERY',   5),
        ('LEADER_MC_ASHOKA',        'FLAVOR_JFD_SLAVERY',   6);
--==========================================================================================================================
-- TOMATEKH HISTORICAL RELIGIONS
--==========================================================================================================================

--==========================================================================================================================
-- HAZEL MAP LABELS
--==========================================================================================================================
-- ML_CivCultures
------------------------------  
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
            (CivType,                       CultureType,    CultureEra)
VALUES      ('CIVILIZATION_MC_MUGHAL',      'INDIAN',       'ANY'),
            ('CIVILIZATION_MC_MARATHA',     'INDIAN',       'ANY'),
            ('CIVILIZATION_MC_MAURYA',      'INDIAN',       'ANY'),
            ('CIVILIZATION_MC_CHOLA',       'INDIAN',       'ANY');
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
        (LeaderType,                    FlavorType,                 Flavor)
VALUES  ('LEADER_MC_SHIVAJI',           'FLAVOR_JFD_MERCENARY',     7),
        ('LEADER_MC_AKBAR',             'FLAVOR_JFD_MERCENARY',     5),
        ('LEADER_MC_RAJA_RAJA_I',       'FLAVOR_JFD_MERCENARY',     3),
        ('LEADER_MC_ASHOKA',            'FLAVOR_JFD_MERCENARY',     5);
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
            (LeaderType,                  FlavorType,                             Flavor)
VALUES      ('LEADER_MC_SHIVAJI',        'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',     3),
            ('LEADER_MC_RAJA_RAJA_I',    'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',     3),
            ('LEADER_MC_AKBAR',          'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',     3),
            ('LEADER_MC_ASHOKA',         'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',     7);
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
--        (CivilizationType,                  CurrencyType)
--VALUES    ( 'CIVILIZATION_MC_SERBIA',         'CURRENCY_JFD_DINAR');
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
        (CivilizationType,          LegislatureName, OfficeTitle, GovernmentType, Weight)
SELECT  'CIVILIZATION_MC_MUGHAL',   LegislatureName, OfficeTitle, GovernmentType, Weight
FROM Civilization_JFD_Governments WHERE CivilizationType = 'CIVILIZATION_INDIA';

INSERT INTO Civilization_JFD_Governments
        (CivilizationType,          LegislatureName, OfficeTitle, GovernmentType, Weight)
SELECT  'CIVILIZATION_MC_MARATHA',  LegislatureName, OfficeTitle, GovernmentType, Weight
FROM Civilization_JFD_Governments WHERE CivilizationType = 'CIVILIZATION_INDIA';

INSERT INTO Civilization_JFD_Governments
        (CivilizationType,          LegislatureName, OfficeTitle, GovernmentType, Weight)
SELECT  'CIVILIZATION_MC_MAURYA',   LegislatureName, OfficeTitle, GovernmentType, Weight
FROM Civilization_JFD_Governments WHERE CivilizationType = 'CIVILIZATION_INDIA';

INSERT INTO Civilization_JFD_Governments
        (CivilizationType,          LegislatureName, OfficeTitle, GovernmentType, Weight)
SELECT  'CIVILIZATION_MC_CHOLA',    LegislatureName, OfficeTitle, GovernmentType, Weight
FROM Civilization_JFD_Governments WHERE CivilizationType = 'CIVILIZATION_INDIA';
------------------------------------------------------------
-- Civilization_JFD_Politics
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS
    Civilization_JFD_Politics (
    CivilizationType                    text        REFERENCES Civilizations(TYPE)                  DEFAULT NULL,
    PoliticsType                        text                                                        DEFAULT NULL,
    UniqueName                          text                                                        DEFAULT NULL);
 
INSERT INTO Civilization_JFD_Politics
        (CivilizationType,           PoliticsType, UniqueName)
SELECT  ('CIVILIZATION_MC_MAURYA'),  PoliticsType, UniqueName
FROM Civilization_JFD_Politics WHERE CivilizationType = 'CIVILIZATION_INDIA';

INSERT INTO Civilization_JFD_Politics
        (CivilizationType,           PoliticsType, UniqueName)
SELECT  ('CIVILIZATION_MC_CHOLA'),   PoliticsType, UniqueName
FROM Civilization_JFD_Politics WHERE CivilizationType = 'CIVILIZATION_INDIA';

INSERT INTO Civilization_JFD_Politics
        (CivilizationType,           PoliticsType, UniqueName)
SELECT  ('CIVILIZATION_MC_MUGHAL'),  PoliticsType, UniqueName
FROM Civilization_JFD_Politics WHERE CivilizationType = 'CIVILIZATION_INDIA';

INSERT INTO Civilization_JFD_Politics
        (CivilizationType,           PoliticsType, UniqueName)
SELECT  ('CIVILIZATION_MC_MARATHA'), PoliticsType, UniqueName
FROM Civilization_JFD_Politics WHERE CivilizationType = 'CIVILIZATION_INDIA';
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
        ('FLAVOR_JFD_REFORM_LEGAL'),
        ('FLAVOR_JFD_REFORM_MILITARY'),
        ('FLAVOR_JFD_REFORM_RELIGION');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------    
--Each flavour corresponds to one of the seven Reform Categories, and how likely a civ is to take a reform in either the Right, Centre, or Left column.
--A value of 1-3 will favour Left Reforms. A value of 4-6 will value Centre Reforms. A value of 7-10 will value Right Reforms. The strength of the value will determine how soon a Leader will implement that Reform.
INSERT OR REPLACE INTO Leader_Flavors
        (LeaderType,                FlavorType,                         Flavor)
VALUES  ('LEADER_MC_RAJA_RAJA_I',   'FLAVOR_JFD_REFORM_GOVERNMENT',     6),
        ('LEADER_MC_RAJA_RAJA_I',   'FLAVOR_JFD_REFORM_CULTURE',        5),
        ('LEADER_MC_RAJA_RAJA_I',   'FLAVOR_JFD_REFORM_ECONOMIC',       4),
        ('LEADER_MC_RAJA_RAJA_I',   'FLAVOR_JFD_REFORM_FOREIGN',        5),
        ('LEADER_MC_RAJA_RAJA_I',   'FLAVOR_JFD_REFORM_INDUSTRY',       5),
        ('LEADER_MC_RAJA_RAJA_I',   'FLAVOR_JFD_REFORM_LEGAL',          5),
        ('LEADER_MC_RAJA_RAJA_I',   'FLAVOR_JFD_REFORM_MILITARY',       7),
        ('LEADER_MC_RAJA_RAJA_I',   'FLAVOR_JFD_REFORM_RELIGION',       6),
        ('LEADER_MC_SHIVAJI',       'FLAVOR_JFD_REFORM_GOVERNMENT',     6),
        ('LEADER_MC_SHIVAJI',       'FLAVOR_JFD_REFORM_CULTURE',        5),
        ('LEADER_MC_SHIVAJI',       'FLAVOR_JFD_REFORM_ECONOMIC',       4),
        ('LEADER_MC_SHIVAJI',       'FLAVOR_JFD_REFORM_FOREIGN',        5),
        ('LEADER_MC_SHIVAJI',       'FLAVOR_JFD_REFORM_INDUSTRY',       5),
        ('LEADER_MC_SHIVAJI',       'FLAVOR_JFD_REFORM_LEGAL',          5),
        ('LEADER_MC_SHIVAJI',       'FLAVOR_JFD_REFORM_MILITARY',       7),
        ('LEADER_MC_AKBAR',         'FLAVOR_JFD_REFORM_RELIGION',       6),
        ('LEADER_MC_AKBAR',         'FLAVOR_JFD_REFORM_GOVERNMENT',     6),
        ('LEADER_MC_AKBAR',         'FLAVOR_JFD_REFORM_CULTURE',        5),
        ('LEADER_MC_AKBAR',         'FLAVOR_JFD_REFORM_ECONOMIC',       4),
        ('LEADER_MC_AKBAR',         'FLAVOR_JFD_REFORM_FOREIGN',        5),
        ('LEADER_MC_AKBAR',         'FLAVOR_JFD_REFORM_INDUSTRY',       5),
        ('LEADER_MC_AKBAR',         'FLAVOR_JFD_REFORM_LEGAL',          5),
        ('LEADER_MC_AKBAR',         'FLAVOR_JFD_REFORM_MILITARY',       7),
        ('LEADER_MC_AKBAR',         'FLAVOR_JFD_REFORM_RELIGION',       6),
        ('LEADER_MC_ASHOKA',        'FLAVOR_JFD_REFORM_GOVERNMENT',     6),
        ('LEADER_MC_ASHOKA',        'FLAVOR_JFD_REFORM_CULTURE',        5),
        ('LEADER_MC_ASHOKA',        'FLAVOR_JFD_REFORM_ECONOMIC',       4),
        ('LEADER_MC_ASHOKA',        'FLAVOR_JFD_REFORM_FOREIGN',        5),
        ('LEADER_MC_ASHOKA',        'FLAVOR_JFD_REFORM_INDUSTRY',       5),
        ('LEADER_MC_ASHOKA',        'FLAVOR_JFD_REFORM_LEGAL',          5),
        ('LEADER_MC_ASHOKA',        'FLAVOR_JFD_REFORM_MILITARY',       7),
        ('LEADER_MC_ASHOKA',        'FLAVOR_JFD_REFORM_RELIGION',       6);
--==========================================================================================================================
-- R.E.D. / Ethnic Units
--==========================================================================================================================
-- Civilizations
------------------------------  
UPDATE Civilizations
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_POLYNESIA')
    THEN '_INDIA'
    ELSE '_AFRI' END)
WHERE TYPE IN ('CIVILIZATION_MC_MUGHAL', 'CIVILIZATION_MC_MARATHA', 'CIVILIZATION_MC_CHOLA', 'CIVILIZATION_MC_MAURYA');
--==========================================================================================================================
-- YnAEMP v24
--==========================================================================================================================
-- Civilizations_YagemStartPosition (Earth Giant)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(TYPE, X, Y, AltX, AltY);
INSERT OR REPLACE INTO Civilizations_YagemStartPosition
            (TYPE,                          X,      Y)
VALUES      ('CIVILIZATION_MC_CHOLA',       61,     37),
            ('CIVILIZATION_MC_MARATHA',     58,     42),
            ('CIVILIZATION_MC_MAURYA',      65,     50),
            ('CIVILIZATION_MC_MUGHAL',      61,     51),
            ('CIVILIZATION_INDIA',          68,     48);
------------------------------------------------------------    
-- Civilizations_YahemStartPosition (Earth Huge)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(TYPE, X, Y, AltX, AltY);
INSERT OR REPLACE INTO Civilizations_YahemStartPosition
            (TYPE,                          X,      Y)
VALUES      ('CIVILIZATION_MC_CHOLA',       90,     37),
            ('CIVILIZATION_MC_MARATHA',     88,     41),
            ('CIVILIZATION_MC_MAURYA',      93,     46),
            ('CIVILIZATION_MC_MUGHAL',      89,     47),
            ('CIVILIZATION_INDIA',          95,     42);
------------------------------------------------------------    
-- Civilizations_CordiformStartPosition (Earth Standard)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(TYPE, X, Y, AltX, AltY);
INSERT OR REPLACE INTO Civilizations_CordiformStartPosition
            (TYPE,                          X,      Y)
VALUES      ('CIVILIZATION_MC_CHOLA',       60,     18),
            ('CIVILIZATION_MC_MARATHA',     57,     20),
            ('CIVILIZATION_MC_MAURYA',      58,     23),
            ('CIVILIZATION_MC_MUGHAL',      56,     23),
            ('CIVILIZATION_INDIA',          59,     23);
------------------------------------------------------------    
-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(TYPE, X, Y, AltX, AltY);
INSERT OR REPLACE INTO Civilizations_GreatestEarthStartPosition
            (TYPE,                          X,      Y)
VALUES      ('CIVILIZATION_MC_CHOLA',       77,     33),
            ('CIVILIZATION_MC_MARATHA',     74,     35),
            ('CIVILIZATION_MC_MAURYA',      78,     39),
            ('CIVILIZATION_MC_MUGHAL',      75,     39),
            ('CIVILIZATION_INDIA',          80,     38);
------------------------------------------------------------    
-- Civilizations_AfriAsiaAustStartPosition (Africa, Asia, Oceania Huge)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_AfriAsiaAustStartPosition(TYPE, X, Y, AltX, AltY);
INSERT OR REPLACE INTO Civilizations_AfriAsiaAustStartPosition
            (TYPE,                          X,      Y)
VALUES      ('CIVILIZATION_MC_CHOLA',       77,     44),
            ('CIVILIZATION_MC_MARATHA',     72,     50),
            ('CIVILIZATION_MC_MAURYA',      80,     58),
            ('CIVILIZATION_MC_MUGHAL',      76,     50),
            ('CIVILIZATION_INDIA',          84,     54);
------------------------------------------------------------    
-- Civilizations_AsiaStartPosition (Asia Large)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_AsiaStartPosition(TYPE, X, Y, AltX, AltY);
INSERT OR REPLACE INTO Civilizations_AsiaStartPosition
            (TYPE,                          X,      Y)
VALUES      ('CIVILIZATION_MC_CHOLA',       30,     17),
            ('CIVILIZATION_MC_MARATHA',     23,     26),
            ('CIVILIZATION_MC_MAURYA',      35,     35),
            ('CIVILIZATION_MC_MUGHAL',      27,     37),
            ('CIVILIZATION_INDIA',          38,     31);
------------------------------------------------------------    
-- Civilizations_EastAsiaStartPosition (Asia South-East Large Blank)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_EastAsiaStartPosition(TYPE, X, Y, AltX, AltY);
INSERT OR REPLACE INTO Civilizations_EastAsiaStartPosition
            (TYPE,                          X,      Y)
VALUES      ('CIVILIZATION_MC_CHOLA',       2,      31),
            ('CIVILIZATION_MC_MAURYA',      8,      48),
            ('CIVILIZATION_INDIA',          10,     43);
------------------------------------------------------------    
-- Civilizations_IndiaGiantStartPosition (India Giant)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_IndiaGiantStartPosition(TYPE, X, Y, AltX, AltY);
INSERT OR REPLACE INTO Civilizations_IndiaGiantStartPosition
            (TYPE,                          X,      Y)
VALUES      ('CIVILIZATION_MC_CHOLA',       54,     27),
            ('CIVILIZATION_MC_MARATHA',     32,     50),
            ('CIVILIZATION_MC_MAURYA',      76,     85),
            ('CIVILIZATION_MC_MUGHAL',      44,     88),
            ('CIVILIZATION_INDIA',          81,     67);
------------------------------------------------------------    
-- Civilizations_IndianOceanStartPosition (Indian Ocean Large)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_IndianOceanStartPosition(TYPE, X, Y, AltX, AltY);
INSERT OR REPLACE INTO Civilizations_IndianOceanStartPosition
            (TYPE,                          X,      Y)
VALUES      ('CIVILIZATION_MC_CHOLA',       51,     50),
            ('CIVILIZATION_MC_MARATHA',     45,     58),
            ('CIVILIZATION_MC_MAURYA',      54,     65),
            ('CIVILIZATION_MC_MUGHAL',      47,     67),
            ('CIVILIZATION_INDIA',          57,     62);
------------------------------------------------------------    
-- Civilizations_SouthAsiaHugeStartPosition (Asia South Huge)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_SouthAsiaHugeStartPosition(TYPE, X, Y, AltX, AltY);
INSERT OR REPLACE INTO Civilizations_SouthAsiaHugeStartPosition
            (TYPE,                          X,      Y)
VALUES      ('CIVILIZATION_MC_CHOLA',       54,     19),
            ('CIVILIZATION_MC_MARATHA',     33,     31),
            ('CIVILIZATION_MC_MAURYA',      55,     59),
            ('CIVILIZATION_MC_MUGHAL',      34,     65),
            ('CIVILIZATION_INDIA',          68,     54);
--==========================================================================================================================
--==========================================================================================================================