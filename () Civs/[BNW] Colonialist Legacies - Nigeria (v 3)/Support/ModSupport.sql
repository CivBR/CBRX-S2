--=======================================================================================================================
-- BINGLES CIV IV TRAITS
--=======================================================================================================================
-- Leader_SharedTraits
------------------------------	
CREATE TABLE IF NOT EXISTS 
    Leader_SharedTraits (
    LeaderType          text    REFERENCES Leaders(Type)        default null,
    TraitOne            text    REFERENCES Policies(Type)       default null,
    TraitTwo            text    REFERENCES Policies(Type)       default null);
     
INSERT INTO Leader_SharedTraits
        (LeaderType,				TraitOne,               TraitTwo)
VALUES  ('LEADER_CL_AWOLOWO', 	'POLICY_EXPANSIVE_X',	'POLICY_PHILOSOPHICAL_X');
------------------------------	
-- Leaders
------------------------------	
UPDATE Leaders 
SET Description = 'Awolowo [ICON_FOOD][ICON_GREAT_PEOPLE]'
WHERE Type = 'LEADER_CL_AWOLOWO'
AND EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');
--==========================================================================================================================
-- GEDEMON R.E.D.
--==========================================================================================================================
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET ArtStyleSuffix = '_ETHIOPIA'
WHERE Type = 'CIVILIZATION_CL_NIGERIA'
AND EXISTS (SELECT * FROM Civilizations WHERE ArtStyleSuffix = '_ETHIOPIA');
--==========================================================================================================================
-- GEDEMON YNAEMP
--==========================================================================================================================
-- Civilizations_YagemStartPosition (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
		(Type,							X,	Y)
VALUES	('CIVILIZATION_CL_NIGERIA',	17,	34);
------------------------------------------------------------	
-- Civilizations_YahemStartPosition (Earth Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
		(Type,							X,	Y)
VALUES	('CIVILIZATION_CL_NIGERIA',		59,	35);
------------------------------------------------------------	
-- Civilizations_CordiformStartPosition (Earth Standard)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
		(Type,							X,	Y)
VALUES	('CIVILIZATION_CL_NIGERIA',	34,	13);
------------------------------------------------------------	
-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
		(Type,							X,	Y)
VALUES	('CIVILIZATION_CL_NIGERIA',	48, 21);
------------------------------------------------------------	
-- Civilizations_AfricaStartPosition (Africa)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AfricaLargeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AfricaLargeStartPosition
		(Type,							X,	Y)
VALUES	('CIVILIZATION_CL_NIGERIA',	19, 43);
--------------------------------------------------
------------------------------------------------------------	
-- Civilizations_YagemRequestedResource (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource
		(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_CL_NIGERIA',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';
------------------------------------------------------------	
-- Civilizations_YahemRequestedResource (Earth Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YahemRequestedResource
		(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_CL_NIGERIA',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';
------------------------------------------------------------	
-- Civilizations_GreatestEarthRequestedResource (Earth Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_GreatestEarthRequestedResource
		(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_CL_NIGERIA',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_GreatestEarthRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';
--==========================================================================================================================
-- HAZEL MAP LABELS
--==========================================================================================================================
-- ML_CivCultures
------------------------------	
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
		(CivType,						CultureType,				CultureEra)
VALUES	('CIVILIZATION_CL_NIGERIA',	'MOD_AFRICAN',	'ANY');

--==========================================================================================================================
-- Historical Religions
--==========================================================================================================================
 
--==========================================================================================================================
-- JFD USER SETTINGS
--==========================================================================================================================
-- JFD_GlobalUserSettings
-------------------------------------
CREATE TABLE IF NOT EXISTS 
JFD_GlobalUserSettings (
	Type 											text 										default null,
	Value 											integer 									default 1);
------------------------------
-- Civilization_JFD_ColonialCityNames
------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_ColonialCityNames (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	ColonyName 									text										default null,
	LinguisticType								text										default	null,
	CultureType									text										default	null);

INSERT INTO Civilization_JFD_ColonialCityNames
		(CivilizationType,			LinguisticType, ColonyName)
SELECT	'CIVILIZATION_CL_NIGERIA',	LinguisticType, ColonyName
FROM Civilization_JFD_ColonialCityNames WHERE CivilizationType = 'CIVILIZATION_ETHIOPIA';
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
	IdealsTag									text											default	null,
	SplashScreenTag								text											default	null,
	SoundtrackTag								text											default	null,
	UnitDialogueTag								text											default null);

INSERT INTO Civilization_JFD_CultureTypes
		(CivilizationType,			ArtDefineTag, CultureType,	 IdealsTag,		SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT	'CIVILIZATION_CL_NIGERIA',	ArtDefineTag, CultureType, IdealsTag,	SplashScreenTag,	 SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_SONGHAI';
------------------------------	
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET SoundtrackTag = 'JFD_WestAfrican'
WHERE Type = 'CIVILIZATION_CL_NIGERIA'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_WestAfrican')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CULDIV_SOUNDTRACK_ADDON' AND Value = 1);
--==========================================================================================================================	
-- JFD AND POUAKAI MERCENARIES
--==========================================================================================================================
-- Flavors
------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_MERCENARY');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------	
INSERT INTO Leader_Flavors
		(LeaderType,						FlavorType,					Flavor)
VALUES	('LEADER_CL_AWOLOWO',	'FLAVOR_JFD_MERCENARY',		4);
--==========================================================================================================================	
-- JFD PIETY & SOVEREIGNTY
--==========================================================================================================================	
-- Civilization_JFD_Governments
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Governments (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 					default null,
	CultureType	  					text 		 												default null,
	LegislatureName					text														default	null,
	OfficeTitle						text														default	null,
	GovernmentType					text														default	null,
	Weight							integer														default	0);

INSERT INTO Civilization_JFD_Governments
		(CivilizationType,			LegislatureName,											OfficeTitle,														GovernmentType,				Weight)
SELECT	'CIVILIZATION_CL_NIGERIA',	'TXT_KEY_JFD_LEGISLATURE_NAME_CIVILIZATION_CL_NIGERIA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_CL_NIGERIA',	'GOVERNMENT_JFD_REPUBLIC',	80
FROM Civilization_JFD_Governments WHERE CivilizationType = 'CIVILIZATION_SONGHAI';
------------------------------------------------------------	
-- Civilization_JFD_HeadsOfGovernment	
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 	
	Civilization_JFD_HeadsOfGovernment (	
	CivilizationType  				text 		REFERENCES Civilizations(Type) 					default null,
	CultureType						text 		 												default null,
	HeadOfGovernmentName			text 		 												default null);

INSERT INTO Civilization_JFD_HeadsOfGovernment
        (CivilizationType,      		HeadOfGovernmentName)
VALUES  ('CIVILIZATION_CL_NIGERIA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_CL_NIGERIA_1'),
        ('CIVILIZATION_CL_NIGERIA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_CL_NIGERIA_2'),
        ('CIVILIZATION_CL_NIGERIA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_CL_NIGERIA_3'),
        ('CIVILIZATION_CL_NIGERIA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_CL_NIGERIA_4'),
        ('CIVILIZATION_CL_NIGERIA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_CL_NIGERIA_5'),
        ('CIVILIZATION_CL_NIGERIA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_CL_NIGERIA_6'),
        ('CIVILIZATION_CL_NIGERIA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_CL_NIGERIA_7'),
        ('CIVILIZATION_CL_NIGERIA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_CL_NIGERIA_8'),
        ('CIVILIZATION_CL_NIGERIA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_CL_NIGERIA_9'),
        ('CIVILIZATION_CL_NIGERIA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_CL_NIGERIA_10'),
        ('CIVILIZATION_CL_NIGERIA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_CL_NIGERIA_11'),
        ('CIVILIZATION_CL_NIGERIA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_CL_NIGERIA_12'),
        ('CIVILIZATION_CL_NIGERIA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_CL_NIGERIA_13'),
        ('CIVILIZATION_CL_NIGERIA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_CL_NIGERIA_14'),
        ('CIVILIZATION_CL_NIGERIA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_CL_NIGERIA_15'),
        ('CIVILIZATION_CL_NIGERIA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_CL_NIGERIA_16');
------------------------------------------------------------			
-- Flavors
------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_REFORM_GOVERNMENT'),
		('FLAVOR_JFD_REFORM_CULTURE'),
		('FLAVOR_JFD_REFORM_ECONOMIC'),
		('FLAVOR_JFD_REFORM_FOREIGN'),
		('FLAVOR_JFD_REFORM_INDUSTRY'),
		('FLAVOR_JFD_REFORM_MILITARY'),
		('FLAVOR_JFD_REFORM_RELIGION'),
		('FLAVOR_JFD_RELIGIOUS_INTOLERANCE');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------
INSERT INTO Leader_Flavors
		(LeaderType,				FlavorType,							Flavor)
VALUES	('LEADER_CL_AWOLOWO',	'FLAVOR_JFD_REFORM_GOVERNMENT',		2),
		('LEADER_CL_AWOLOWO',	'FLAVOR_JFD_REFORM_CULTURE',		2),
		('LEADER_CL_AWOLOWO',	'FLAVOR_JFD_REFORM_ECONOMIC',		5),
		('LEADER_CL_AWOLOWO',	'FLAVOR_JFD_REFORM_FOREIGN',		7),
		('LEADER_CL_AWOLOWO',	'FLAVOR_JFD_REFORM_INDUSTRY',		7),
		('LEADER_CL_AWOLOWO',	'FLAVOR_JFD_REFORM_MILITARY',		6),
		('LEADER_CL_AWOLOWO',	'FLAVOR_JFD_REFORM_RELIGION',		3),
		('LEADER_CL_AWOLOWO',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',	0);
--==========================================================================================================================
-- JFD PROSPERITY
--==========================================================================================================================
-- Civilization_JFD_Currencies
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Currencies (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 	default null,
	CurrencyType	  				text 		  								default null);

INSERT INTO Civilization_JFD_Currencies	
		(CivilizationType,			CurrencyType)
SELECT	'CIVILIZATION_CL_NIGERIA',	CurrencyType
FROM Civilization_JFD_Currencies WHERE CivilizationType = 'CIVILIZATION_SONGHAI';
--==========================================================================================================================
--==========================================================================================================================