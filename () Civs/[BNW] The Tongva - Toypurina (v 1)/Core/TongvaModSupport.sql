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
       (LeaderType,				TraitOne,				TraitTwo)
SELECT  'LEADER_SAS_TOYPURINA',	'POLICY_DIPLOMATIC_X',	'POLICY_SEAFARING_X'
WHERE EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');
------------------------------	
-- Leaders
------------------------------	
UPDATE Leaders 
SET Description = 'Toypurina [ICON_INFLUENCE][ICON_GREAT_EXPLORER]'
WHERE Type = 'LEADER_SAS_TOYPURINA'
AND EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');
--==========================================================================================================================
-- GAZEBO COMMUNITY PATCH
--==========================================================================================================================
-- COMMUNITY
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS COMMUNITY (Type TEXT, Value INTEGER);
--==========================================================================================================================
-- GEDEMON R.E.D.
--==========================================================================================================================
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET ArtStyleSuffix = '_IROQUOIS'
WHERE Type = 'CIVILIZATION_SAS_TONGVA'
AND EXISTS (SELECT * FROM Civilizations WHERE ArtStyleSuffix = '_IROQUOIS');
--==========================================================================================================================
--==========================================================================================================================
-- HAZEL MAP LABELS
--==========================================================================================================================
-- ML_CivCultures
------------------------------	
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
		(CivType, 					CultureType, CultureEra)
SELECT	'CIVILIZATION_SAS_TONGVA',	CultureType, 	 CultureEra
FROM ML_CivCultures WHERE CivType = 'CIVILIZATION_SHOSHONE';
--==========================================================================================================================
-- JFD USER SETTINGS
--==========================================================================================================================
-- JFD_GlobalUserSettings
-------------------------------------
CREATE TABLE IF NOT EXISTS 
JFD_GlobalUserSettings (
	Type 							text 		default null,
	Value 							integer 	default 1);
--==========================================================================================================================
-- JFD CIVILOPEDIA
--==========================================================================================================================
-- JFD_Civilopedia_HideFromPedia
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
JFD_Civilopedia_HideFromPedia (Type text default null);
--==========================================================================================================================
-- JFD CITIES IN DEVELOPMENT
--==========================================================================================================================
--====================================	
-- JFD COLONIES
--====================================	
-- Civilization_JFD_ColonialCityNames
------------------------------	
CREATE TABLE IF NOT EXISTS
Civilization_JFD_ColonialCityNames (
        CivilizationType                                                        text    REFERENCES Civilizations(TYPE)          DEFAULT NULL,
        ColonyName                                                                      text                                                                            DEFAULT NULL,
        LinguisticType                                                          text                                                                            DEFAULT NULL,
        CultureType                                                                     text                                                                            DEFAULT NULL);
 
INSERT INTO Civilization_JFD_ColonialCityNames
                (CivilizationType,                                              ColonyName,                                                             LinguisticType)
VALUES          ('CIVILIZATION_SAS_TONGVA',                      NULL,                                                                   'JFD_NorthAmerican');
------------------------------------------------------------
-- Flavors
------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_DECOLONIZATION');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------
INSERT INTO Leader_Flavors
		(LeaderType,					FlavorType,						Flavor)
VALUES	('LEADER_SAS_TOYPURINA',		'FLAVOR_JFD_DECOLONIZATION',	6);
--====================================
-- JFD PROVINCES 
--====================================
-- Civilization_JFD_ProvinceTitles
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_ProvinceTitles (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 				default null,
	ReligionType  					text 		REFERENCES Religions(Type) 					default null,
	DefaultTitle					text 		 											default null,
	UniqueTitle						text 		 											default null,
	UseAdjective					boolean													default 0);	

INSERT INTO Civilization_JFD_ProvinceTitles
		(CivilizationType,			DefaultTitle, UniqueTitle)
SELECT	'CIVILIZATION_SAS_TONGVA',	DefaultTitle, UniqueTitle
FROM Civilization_JFD_ProvinceTitles WHERE CivilizationType = 'CIVILIZATION_SHOSHONE';
--====================================	
-- JFD SLAVERY
--====================================	
-- Flavors
------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_SLAVERY');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------
INSERT INTO Leader_Flavors
		(LeaderType,		FlavorType,				Flavor)
VALUES	('LEADER_SAS_TOYPURINA',	'FLAVOR_JFD_SLAVERY',	0);
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
		(CivilizationType,				ArtDefineTag, 			CultureType, 			IdealsTag, 				SplashScreenTag, 		SoundtrackTag)
VALUES	('CIVILIZATION_SAS_TONGVA',	'JFD_TribalAmerican',	'JFD_TribalAmerican',	'JFD_TribalAmerican',	'JFD_TribalAmerican',	'JFD_TribalAmerican');

UPDATE Civilization_JFD_CultureTypes
SET ArtDefineTag = 'JFD_Pacific', CultureType = 'JFD_Pacific', IdealsTag = 'JFD_Pacific', SplashScreenTag = 'JFD_Pacific', SoundtrackTag = 'JFD_Pacific'
WHERE CivilizationType = 'CIVILIZATION_SAS_TONGVA' AND EXISTS (SELECT * FROM JFD_CultureTypes WHERE Type = 'JFD_Pacific');

UPDATE Civilizations 
SET SoundtrackTag = 'JFD_TribalAmerican'
WHERE Type = 'CIVILIZATION_SAS_TONGVA'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_TribalAmerican');

UPDATE Civilizations 
SET SoundtrackTag = 'JFD_Pacific'
WHERE Type = 'CIVILIZATION_SAS_TONGVA'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Pacific');
--==========================================================================================================================
-- JFD RISE TO POWER
--==========================================================================================================================
--====================================	
-- JFD AND POUAKAI MERCENARIES
--====================================
-- Flavors
------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_MERCENARY');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------	
INSERT INTO Leader_Flavors
		(LeaderType,		 FlavorType,			Flavor)
VALUES	('LEADER_SAS_TOYPURINA',	'FLAVOR_JFD_MERCENARY',	5);
--====================================	
-- JFD PIETY
--====================================	
------------------------------------------------------------
-- Flavors
------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_RELIGIOUS_INTOLERANCE'),
		('FLAVOR_JFD_STATE_RELIGION');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------
INSERT INTO Leader_Flavors
		(LeaderType,		FlavorType,								Flavor)
VALUES	('LEADER_SAS_TOYPURINA',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',		4),
		('LEADER_SAS_TOYPURINA',	'FLAVOR_JFD_STATE_RELIGION',			6);
--====================================
-- JFD PROSPERITY
--====================================
-- Civilization_JFD_Currencies
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Currencies (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 	default null,
	CurrencyType	  				text 		  								default null);

INSERT INTO Civilization_JFD_Currencies	
		(CivilizationType,			CurrencyType)
SELECT	'CIVILIZATION_SAS_TONGVA',	CurrencyType
FROM Civilization_JFD_Currencies WHERE CivilizationType = 'CIVILIZATION_SHOSHONE';
--====================================	
-- JFD SOVEREIGNTY
--====================================	
-- Civilization_JFD_Governments
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Governments (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 			default null,
	CultureType	  					text 		 										default null,
	LegislatureName					text												default	null,
	OfficeTitle						text												default	null,
	GovernmentType					text												default	null,
	Weight							integer												default	0);

INSERT INTO Civilization_JFD_Governments	
		(CivilizationType,			GovernmentType, 			Weight)
SELECT	'CIVILIZATION_SAS_TONGVA',	'GOVERNMENT_JFD_REPUBLIC',  80
FROM Civilization_JFD_Governments WHERE CivilizationType = 'CIVILIZATION_SHOSHONE';
------------------------------------------------------------	
-- Civilization_JFD_HeadsOfGovernment	
------------------------------------------------------------	
-- CREATE TABLE IF NOT EXISTS 	
	-- Civilization_JFD_HeadsOfGovernment (	
	-- CivilizationType  				text 		REFERENCES Civilizations(Type) 			default null,
	-- CultureType						text 		 										default null,
	-- HeadOfGovernmentName			text 		 										default null);

-- INSERT INTO Civilization_JFD_HeadsOfGovernment
        -- (CivilizationType,      	HeadOfGovernmentName)
-- VALUES  ('CIVILIZATION_SAS_TONGVA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SAS_TONGVA_1'),
        -- ('CIVILIZATION_SAS_TONGVA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SAS_TONGVA_2'),
        -- ('CIVILIZATION_SAS_TONGVA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SAS_TONGVA_3'),
        -- ('CIVILIZATION_SAS_TONGVA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SAS_TONGVA_4'),
        -- ('CIVILIZATION_SAS_TONGVA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SAS_TONGVA_5'),
        -- ('CIVILIZATION_SAS_TONGVA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SAS_TONGVA_6'),
        -- ('CIVILIZATION_SAS_TONGVA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SAS_TONGVA_7'),
        -- ('CIVILIZATION_SAS_TONGVA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SAS_TONGVA_8'),
        -- ('CIVILIZATION_SAS_TONGVA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SAS_TONGVA_9'),
        -- ('CIVILIZATION_SAS_TONGVA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SAS_TONGVA_10');
------------------------------------------------------------
-- Civilization_JFD_Titles
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Titles (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 			default null,
	CultureType						text 		 										default null,
	ReligionType					text 		REFERENCES Religions(Type) 				default null,
	DefaultTitle					text 		 										default null,
	UniqueTitle						text 		 										default null,
	UseAdjective					boolean												default 0);	
	
INSERT INTO Civilization_JFD_Titles
		(CivilizationType,			DefaultTitle,	UniqueTitle)
SELECT	'CIVILIZATION_SAS_TONGVA',	DefaultTitle,	UniqueTitle
FROM Civilization_JFD_Titles WHERE CivilizationType = 'CIVILIZATION_SHOSHONE';
------------------------------------------------------------
-- Civilization_JFD_Politics
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Politics (	
	CivilizationType  				text 	REFERENCES Civilizations(Type) 				default null,
	PoliticsType  					text 												default null,
	UniqueName						text												default	null);

INSERT INTO Civilization_JFD_Politics
		(CivilizationType,			PoliticsType, UniqueName)
SELECT	'CIVILIZATION_SAS_TONGVA',	PoliticsType, UniqueName
FROM Civilization_JFD_Politics WHERE CivilizationType = 'CIVILIZATION_SHOSHONE';
--------------------------------------------------------------------------------------------------------------------------
-- JFD_PrivyCouncillor_UniqueNames
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	JFD_PrivyCouncillor_UniqueNames (
	PrivyCouncillorType  			text 										 		default null,
	PolicyType  					text 	REFERENCES Policies(Type) 					default null,
	CivilizationType				text	REFERENCES Civilizations(Type) 				default	null,
	CultureType						text												default	null,
	GovernmentType  				text 	 											default null,
	ReligionType					text	REFERENCES Religions(Type) 					default	null,
	UniqueName						text												default	null);
		
INSERT INTO JFD_PrivyCouncillor_UniqueNames
		(CivilizationType,			PrivyCouncillorType, UniqueName)
SELECT	'CIVILIZATION_SAS_TONGVA',	PrivyCouncillorType, UniqueName
FROM JFD_PrivyCouncillor_UniqueNames WHERE CivilizationType = 'CIVILIZATION_SHOSHONE';
------------------------------------------------------------			
-- Flavors
------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_REFORM_GOVERNMENT'),
		('FLAVOR_JFD_REFORM_LEGAL'),
		('FLAVOR_JFD_REFORM_CULTURE'),
		('FLAVOR_JFD_REFORM_ECONOMIC'),
		('FLAVOR_JFD_REFORM_FOREIGN'),
		('FLAVOR_JFD_REFORM_INDUSTRY'),
		('FLAVOR_JFD_REFORM_MILITARY'),
		('FLAVOR_JFD_REFORM_RELIGION');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------
INSERT INTO Leader_Flavors
		(LeaderType,		FlavorType,							 Flavor)
VALUES	('LEADER_SAS_TOYPURINA',	'FLAVOR_JFD_REFORM_GOVERNMENT',		 3),
		('LEADER_SAS_TOYPURINA',	'FLAVOR_JFD_REFORM_LEGAL',			 2),
		('LEADER_SAS_TOYPURINA',	'FLAVOR_JFD_REFORM_CULTURE',		 3),
		('LEADER_SAS_TOYPURINA',	'FLAVOR_JFD_REFORM_ECONOMIC',		 7),
		('LEADER_SAS_TOYPURINA',	'FLAVOR_JFD_REFORM_FOREIGN',		 7),
		('LEADER_SAS_TOYPURINA',	'FLAVOR_JFD_REFORM_INDUSTRY',		 3),
		('LEADER_SAS_TOYPURINA',	'FLAVOR_JFD_REFORM_MILITARY',		 7),
		('LEADER_SAS_TOYPURINA',	'FLAVOR_JFD_REFORM_RELIGION',		 2);
--==========================================================================================================================
-- GEDEMON YNAEMP
--==========================================================================================================================
-- Civilizations_YagemStartPosition (Earth Giant)
------------------------------------------------------------	
INSERT INTO Civilizations_YnAEMP
        (CivilizationType,                MapPrefix,                X,    Y,        AltX,    AltY,    AltCapitalName)
VALUES    ('CIVILIZATION_SAS_TONGVA',        'Americas',                30,    52,        null,    null,    null),
        ('CIVILIZATION_SAS_TONGVA',        'AmericasGiant',        26,    112,    null,    null,    null),
        ('CIVILIZATION_SAS_TONGVA',        'AtlanticGiant',        26,    87,        null,    null,    null),
        ('CIVILIZATION_SAS_TONGVA',        'Cordiform',            7,    37,        null,    null,    null),
        ('CIVILIZATION_SAS_TONGVA',        'EarthMk3',              125,    62,        null,    null,    null),
        ('CIVILIZATION_SAS_TONGVA',        'GreatestEarth',        2,    44,        null,    null,    null),
        ('CIVILIZATION_SAS_TONGVA',        'NorthAmericaGiant',    39,    46,        null,    null,    null),
        ('CIVILIZATION_SAS_TONGVA',        'NorthAmericaHuge',        36,    37,        null,    null,    null),
        ('CIVILIZATION_SAS_TONGVA',        'Pacific',              103,    51,        null,    null,    null),
        ('CIVILIZATION_SAS_TONGVA',        'Yagem',              131,    60,        null,    null,    null),
        ('CIVILIZATION_SAS_TONGVA',        'Yahem',                14,    52,        null,    null,    null);
--------------------------------------------------------------------------------------------------------------------------
-- Leader_JFD_Reforms
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Leader_JFD_Reforms (
	LeaderType  					text 	REFERENCES Leaders(Type) 	default	null,
	ReformType						text								default	null);
--==========================================================================================================================
-- Historical Religions
--==========================================================================================================================
 
INSERT INTO Civilization_Religions
        (CivilizationType,                      ReligionType)
VALUES  ('CIVILIZATION_SAS_TONGVA',              'RELIGION_SGAANAANG');
 
UPDATE Civilization_Religions SET ReligionType =
        ( CASE WHEN EXISTS(SELECT TYPE FROM Religions WHERE TYPE="RELIGION_SGAANAANG" )
                THEN "RELIGION_SGAANAANG"
                ELSE "RELIGION_CATHOLICISM" END
        ) WHERE CivilizationType = "CIVILIZATION_SAS_TONGVA";
 
CREATE TRIGGER ColonialistLegaciesSalishReligion
AFTER INSERT ON Religions WHEN 'RELIGION_SGAANAANG' = NEW.TYPE
BEGIN
        UPDATE Civilization_Religions
        SET ReligionType = 'RELIGION_SGAANAANG'
        WHERE CivilizationType IN ('CIVILIZATION_SAS_TONGVA');
END;