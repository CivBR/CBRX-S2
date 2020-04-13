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
SELECT  'LEADER_MC_BALDWIN',       'POLICY_AGGRESSIVE_X',   'POLICY_SPIRITUAL_X'
WHERE EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');
------------------------------  
-- Leaders
------------------------------  
UPDATE Leaders
SET Description = 'Baldwin III [ICON_WAR][ICON_PEACE]'
WHERE TYPE = 'LEADER_MC_BALDWIN'
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
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('MC_Jerusalem_Decisions.lua');

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
        (CivilizationType,				ArtDefineTag, CultureType, IdealsTag, SplashScreenTag,		SoundtrackTag, UnitDialogueTag)
SELECT  'CIVILIZATION_MC_JERUSALEM',	ArtDefineTag, CultureType, IdealsTag, 'JFD_SouthernPapal',	'JFD_SouthernPapal', 'AS2D_SOUND_JFD_FRENCH';
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_VENICE';
------------------------------  
-- Civilizations
------------------------------  
UPDATE Civilizations
SET SoundtrackTag = 'JFD_SouthernPapal'
WHERE TYPE = 'CIVILIZATION_MC_JERUSALEM'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_SouthernPapal')
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
        (CivilizationType,            LinguisticType)
VALUES  ('CIVILIZATION_MC_JERUSALEM',    'JFD_Latinate');
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
VALUES  ('LEADER_MC_BALDWIN',   'FLAVOR_JFD_SLAVERY',       7);
--==========================================================================================================================
-- TOMATEKH HISTORICAL RELIGIONS
--==========================================================================================================================
-- Civilization_Religions
------------------------------
--UPDATE Civilization_Religions
--SET ReligionType = 'RELIGION_SLAVINISM'
--WHERE CivilizationType = 'CIVILIZATION_MC_JERUSALEM'
--AND EXISTS (SELECT * FROM Religions WHERE Type = 'RELIGION_SLAVINISM');
--==========================================================================================================================
-- HAZEL MAP LABELS
--==========================================================================================================================
-- ML_CivCultures
------------------------------  
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
        (CivType,                       CultureType,        CultureEra)
VALUES  ('CIVILIZATION_MC_JERUSALEM',      'EUROPEAN',         'ANCIENT');
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
VALUES  ('LEADER_MC_BALDWIN',   'FLAVOR_JFD_MERCENARY',     4);
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
VALUES  ('LEADER_MC_BALDWIN',   'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',     8);
--==========================================================  
-- JFD's RtP: Prosperity
--==========================================================
-- Civilization_JFD_Currencies
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS
    Civilization_JFD_Currencies (
    CivilizationType                text        REFERENCES Civilizations(TYPE)  DEFAULT NULL,
    CurrencyType                    text                                        DEFAULT NULL);
 
INSERT INTO Civilization_JFD_Currencies
        (CivilizationType,                  CurrencyType)
VALUES	( 'CIVILIZATION_MC_JERUSALEM',         'CURRENCY_JFD_DINAR');
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
SELECT  'CIVILIZATION_MC_JERUSALEM', LegislatureName, OfficeTitle, GovernmentType, Weight
FROM Civilization_JFD_Governments WHERE CivilizationType = 'CIVILIZATION_FRANCE';
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
SELECT  ('CIVILIZATION_MC_JERUSALEM'), PoliticsType, UniqueName
FROM Civilization_JFD_Politics WHERE CivilizationType = 'CIVILIZATION_FRANCE';
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
VALUES  ('LEADER_MC_BALDWIN',    'FLAVOR_JFD_REFORM_GOVERNMENT',     6),
        ('LEADER_MC_BALDWIN',    'FLAVOR_JFD_REFORM_CULTURE',        5),
        ('LEADER_MC_BALDWIN',    'FLAVOR_JFD_REFORM_ECONOMIC',       4),
        ('LEADER_MC_BALDWIN',    'FLAVOR_JFD_REFORM_FOREIGN',        5),
        ('LEADER_MC_BALDWIN',    'FLAVOR_JFD_REFORM_INDUSTRY',       5),
        ('LEADER_MC_BALDWIN',    'FLAVOR_JFD_REFORM_LEGAL',       	 5),
        ('LEADER_MC_BALDWIN',    'FLAVOR_JFD_REFORM_MILITARY',       7),
        ('LEADER_MC_BALDWIN',    'FLAVOR_JFD_REFORM_RELIGION',       6);
--==========================================================================================================================
-- R.E.D. / Ethnic Units
--==========================================================================================================================
-- Civilizations
------------------------------  
UPDATE Civilizations
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_RUSSIA' )
    THEN '_FRANCE'
    ELSE '_EURO' END)
WHERE TYPE = 'CIVILIZATION_MC_JERUSALEM';
--==========================================================================================================================
-- YnAEMP v24
--==========================================================================================================================
-- Civilizations_YagemStartPosition (Earth Giant)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
        (TYPE,                          X,  Y)
VALUES  ('CIVILIZATION_MC_JERUSALEM',   36, 50);
 
CREATE TABLE IF NOT EXISTS MinorCiv_YagemStartPosition(TYPE, X, Y, AltX, AltY);
UPDATE MinorCiv_YagemStartPosition
SET X = 37, Y = 54
WHERE Type = 'MINOR_CIV_JERUSALEM';
------------------------------------------------------------    
-- Civilizations_YahemStartPosition (Earth Huge)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
        (TYPE,                          X,  Y)
VALUES  ('CIVILIZATION_MC_JERUSALEM',   72, 48);

CREATE TABLE IF NOT EXISTS MinorCiv_YahemStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO MinorCiv_YahemStartPosition
        (TYPE,                         X,  Y)
VALUES  ('MINOR_CIV_JERUSALEM',		   72, 51);

------------------------------------------------------------    
-- Civilizations_CordiformStartPosition (Earth Standard)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
        (TYPE,                          X,  Y)
VALUES  ('CIVILIZATION_MC_JERUSALEM',   46, 19);

CREATE TABLE IF NOT EXISTS MinorCiv_CordiformStartPosition(TYPE, X, Y, AltX, AltY);
UPDATE MinorCiv_CordiformStartPosition
SET X = 47, Y = 22
WHERE Type = 'MINOR_CIV_JERUSALEM';
------------------------------------------------------------    
-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
        (TYPE,                          X,  Y)
VALUES  ('CIVILIZATION_MC_JERUSALEM',   62, 37);

CREATE TABLE IF NOT EXISTS MinorCiv_GreatestEarthStartPosition(TYPE, X, Y, AltX, AltY);
UPDATE MinorCiv_GreatestEarthStartPosition
SET X = 63, Y = 41
WHERE Type = 'MINOR_CIV_JERUSALEM';
------------------------------------------------------------    
-- Civilizations_AfriAsiaAustStartPosition (Africa, Asia & Australia)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_AfriAsiaAustStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_AfriAsiaAustStartPosition
        (TYPE,                          X,  Y)
VALUES  ('CIVILIZATION_MC_JERUSALEM',   46, 66);

CREATE TABLE IF NOT EXISTS MinorCiv_AfriAsiaAustStartPosition(TYPE, X, Y, AltX, AltY);
UPDATE MinorCiv_AfriAsiaAustStartPosition
SET X = 45, Y = 69
WHERE Type = 'MINOR_CIV_JERUSALEM';
------------------------------------------------------------    
-- Civilizations_AfriGiantStartPosition (Europe Giant)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_AfriGiantStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_AfriGiantStartPosition
        (TYPE,                          X,  Y)
VALUES  ('CIVILIZATION_MC_JERUSALEM',   96, 125);

CREATE TABLE IF NOT EXISTS MinorCiv_AfriGiantStartPosition(TYPE, X, Y, AltX, AltY);
UPDATE MinorCiv_AfriGiantStartPosition
SET X = 100, Y = 135
WHERE Type = 'MINOR_CIV_JERUSALEM';
------------------------------------------------------------    
-- Civilizations_AfriSouthEuroStartPosition (Africa and Southern Europe)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_AfriSouthEuroStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_AfriSouthEuroStartPosition
        (TYPE,                          X,  Y)
VALUES  ('CIVILIZATION_MC_JERUSALEM',   57, 59);

CREATE TABLE IF NOT EXISTS MinorCiv_AfriSouthEuroStartPosition(TYPE, X, Y, AltX, AltY);
UPDATE MinorCiv_AfriSouthEuroStartPosition
SET X = 58, Y = 65
WHERE Type = 'MINOR_CIV_JERUSALEM';
------------------------------------------------------------    
-- MinorCiv_CaucasusStartPosition (Caucasus Giant)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS MinorCiv_CaucasusStartPosition(TYPE, X, Y, AltX, AltY);
UPDATE MinorCiv_CaucasusStartPosition
SET X = 74, Y = 11
WHERE Type = 'MINOR_CIV_JERUSALEM';
------------------------------------------------------------    
-- Civilizations_EuroGiantStartPosition (Europe Giant)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_EuroGiantStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroGiantStartPosition
        (TYPE,                          X,   Y)
VALUES  ('CIVILIZATION_MC_JERUSALEM',   135, 6);

CREATE TABLE IF NOT EXISTS MinorCiv_EuroGiantStartPosition(TYPE, X, Y, AltX, AltY);
UPDATE MinorCiv_EuroGiantStartPosition
SET X = 135, Y = 20
WHERE Type = 'MINOR_CIV_JERUSALEM';
------------------------------------------------------------    
-- Civilizations_EuroLargeStartPosition (Europe Large)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroLargeStartPosition
        (TYPE,                          X,  Y)
VALUES  ('CIVILIZATION_MC_JERUSALEM',   60, 15);

CREATE TABLE IF NOT EXISTS MinorCiv_EuroLargeStartPosition(TYPE, X, Y, AltX, AltY);
UPDATE MinorCiv_EuroLargeStartPosition
SET X = 62, Y = 22
WHERE Type = 'MINOR_CIV_JERUSALEM';
------------------------------------------------------------    
-- Civilizations_EuroLargeNewStartPosition (Europe Large)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeNewStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroLargeNewStartPosition
        (TYPE,                          X,  Y)
VALUES  ('CIVILIZATION_MC_JERUSALEM',   69, 6);

CREATE TABLE IF NOT EXISTS MinorCiv_EuroLargeNewStartPosition(TYPE, X, Y, AltX, AltY);
UPDATE MinorCiv_EuroLargeNewStartPosition
SET X = 71, Y = 14
WHERE Type = 'MINOR_CIV_JERUSALEM';
------------------------------------------------------------    
-- Civilizations_MediterraneanStartPosition (Mediterranean)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_MediterraneanStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_MediterraneanStartPosition
        (TYPE,                          X,  Y)
VALUES  ('CIVILIZATION_MC_JERUSALEM',   91, 17);

CREATE TABLE IF NOT EXISTS MinorCiv_MediterraneanStartPosition(TYPE, X, Y, AltX, AltY);
UPDATE MinorCiv_MediterraneanStartPosition
SET X = 91, Y = 30
WHERE Type = 'MINOR_CIV_JERUSALEM';
------------------------------------------------------------    
-- Civilizations_MesopotamiaGiantStartPosition (Mesopotamia Giant)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_MesopotamiaGiantStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_MesopotamiaGiantStartPosition
        (TYPE,                          X,  Y)
VALUES  ('CIVILIZATION_MC_JERUSALEM',   63, 41);

CREATE TABLE IF NOT EXISTS MinorCiv_MesopotamiaGiantStartPosition(TYPE, X, Y, AltX, AltY);
UPDATE MinorCiv_MesopotamiaGiantStartPosition
SET X = 67, Y = 69
WHERE Type = 'MINOR_CIV_JERUSALEM';
------------------------------------------------------------    
-- Civilizations_MesopotamiaStartPosition (Mesopotamia Standard)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_MesopotamiaStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_MesopotamiaStartPosition
        (TYPE,                          X,  Y)
VALUES  ('CIVILIZATION_MC_JERUSALEM',   35, 16);

CREATE TABLE IF NOT EXISTS MinorCiv_MesopotamiaStartPosition(TYPE, X, Y, AltX, AltY);
UPDATE MinorCiv_MesopotamiaStartPosition
SET X = 31, Y = 35
WHERE Type = 'MINOR_CIV_JERUSALEM';
--==========================================================================================================================
--==========================================================================================================================