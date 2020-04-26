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
        (LeaderType,            TraitOne,               TraitTwo)
SELECT  'LEADER_UC_SOLANO',		'POLICY_AGGRESSIVE_X',	 'POLICY_IMPERIALISTIC_X'
WHERE EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');
------------------------------	
-- Leaders
------------------------------	
UPDATE Leaders 
SET Description = 'Solano Lopez [ICON_WAR][ICON_CITY_STATE]'
WHERE Type = 'LEADER_UC_SOLANO'
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
SET ArtStyleSuffix = '_PARAGUAY'
WHERE Type = 'CIVILIZATION_UC_PARAGUAY'
AND EXISTS (SELECT * FROM Civilizations WHERE ArtStyleSuffix = '_BRAZIL');
--==========================================================================================================================
-- GEDEMON YNAEMP
--==========================================================================================================================
-- Civilizations_YagemStartPosition (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
		(Type,							X,	Y)
VALUES	('CIVILIZATION_UC_PARAGUAY',	161,	21);
------------------------------------------------------------	
-- Civilizations_YahemStartPosition (Earth Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
		(Type,							X,	Y)
VALUES	('CIVILIZATION_UC_PARAGUAY',	37,	20);
------------------------------------------------------------	
-- Civilizations_CordiformStartPosition (Earth Standard)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
		(Type,							X,	Y)
VALUES	('CIVILIZATION_UC_PARAGUAY',	17,	10);
------------------------------------------------------------	
-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
		(Type,							X,	Y)
VALUES	('CIVILIZATION_UC_PARAGUAY',	28,	12);
------------------------------------------------------------	
-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
		(Type,							X,	Y)
VALUES	('CIVILIZATION_UC_PARAGUAY',	28,	12);
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_SouthAmericaGiantStartPosition (South America Giant)
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_SouthAmericaGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_SouthAmericaGiantStartPosition
		(Type,									X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_UC_PARAGUAY',					68,		73,		null,	null);
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AmericasGiantStartPosition (Americas Giant)
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_AmericasGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AmericasGiantStartPosition
		(Type,									X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_UC_PARAGUAY',				97,		40,		null,	null);
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_SouthAmericaCentralHugeStartPosition (South & Central America Huge)
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_SouthAmericaCentralHugeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_SouthAmericaCentralHugeStartPosition
		(Type,									X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_UC_PARAGUAY',					65,		44,		null,	null);
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_SouthAmericaCentralGiantStartPosition (South & Central America Giant)
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_SouthAmericaCentralGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_SouthAmericaCentralGiantStartPosition
		(Type,									X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_UC_PARAGUAY',					87,		60,	null,	null);
--==========================================================================================================================
-- HAZEL MAP LABELS
--==========================================================================================================================
-- ML_CivCultures
------------------------------	
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
		(CivType,						CultureType,	CultureEra)
SELECT	'CIVILIZATION_UC_PARAGUAY',	CultureType,	CultureEra
FROM ML_CivCultures WHERE CivType = 'CIVILIZATION_BRAZIL';
--==========================================================================================================================
-- JFD USER SETTINGS
--==========================================================================================================================
-- JFD_GlobalUserSettings
-------------------------------------
CREATE TABLE IF NOT EXISTS 
JFD_GlobalUserSettings (
	Type 											text 										default null,
	Value 											integer 									default 1);
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
		(LeaderType,			FlavorType,						Flavor)
VALUES	('LEADER_UC_SOLANO',		'FLAVOR_JFD_DECOLONIZATION',	3);
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
		(LeaderType,			FlavorType,				Flavor)
VALUES	('LEADER_UC_SOLANO',		'FLAVOR_JFD_SLAVERY',	7);
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
		(CivilizationType,				ArtDefineTag, CultureType,	DefeatScreenEarlyTag,			  DefeatScreenMidTag,				DefeatScreenLateTag,				IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT	'CIVILIZATION_UC_PARAGUAY',	'JFD_Totalitarian', 'JFD_Totalitarian',	null, null,	null,	'JFD_Totalitarian', 'JFD_Totalitarian', 'JFD_Totalitarian', 'AS2D_SOUND_SPANISH_';
------------------------------	
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET SoundtrackTag = 'JFD_Totalitarian'
WHERE Type = 'CIVILIZATION_UC_PARAGUAY'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Totalitarian')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CULDIV_SOUNDTRACK_ADDON' AND Value = 1);
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
		(LeaderType,			FlavorType,								Flavor)
VALUES	('LEADER_UC_SOLANO',		'FLAVOR_JFD_MERCENARY',					7);
--====================================	
-- JFD PIETY
--====================================	
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
		(LeaderType,			FlavorType,								Flavor)
VALUES	('LEADER_UC_SOLANO',		'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',		7),
		('LEADER_UC_SOLANO',		'FLAVOR_JFD_STATE_RELIGION',			7);
--====================================	
-- JFD SOVEREIGNTY
--====================================	
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
		(CivilizationType,				LegislatureName,											OfficeTitle,														GovernmentType,				Weight)
SELECT	'CIVILIZATION_UC_PARAGUAY',	'TXT_KEY_JFD_LEGISLATURE_NAME_CIVILIZATION_UC_PARAGUAY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_PARAGUAY',	'GOVERNMENT_JFD_DICTATORSHIP',	100
FROM Civilization_JFD_Governments WHERE CivilizationType = 'CIVILIZATION_BRAZIL';
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
VALUES  ('CIVILIZATION_UC_PARAGUAY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_PARAGUAY_1'),
        ('CIVILIZATION_UC_PARAGUAY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_PARAGUAY_2'),
        ('CIVILIZATION_UC_PARAGUAY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_PARAGUAY_3'),
        ('CIVILIZATION_UC_PARAGUAY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_PARAGUAY_4'),
        ('CIVILIZATION_UC_PARAGUAY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_PARAGUAY_5'),
        ('CIVILIZATION_UC_PARAGUAY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_PARAGUAY_6'),
        ('CIVILIZATION_UC_PARAGUAY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_PARAGUAY_7'),
        ('CIVILIZATION_UC_PARAGUAY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_PARAGUAY_8'),
        ('CIVILIZATION_UC_PARAGUAY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_PARAGUAY_9'),
        ('CIVILIZATION_UC_PARAGUAY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_PARAGUAY_10'),
        ('CIVILIZATION_UC_PARAGUAY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_PARAGUAY_11'),
        ('CIVILIZATION_UC_PARAGUAY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_PARAGUAY_12'),
        ('CIVILIZATION_UC_PARAGUAY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_PARAGUAY_13'),
        ('CIVILIZATION_UC_PARAGUAY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_PARAGUAY_14'),
        ('CIVILIZATION_UC_PARAGUAY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_PARAGUAY_15'),
        ('CIVILIZATION_UC_PARAGUAY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_PARAGUAY_16'),
        ('CIVILIZATION_UC_PARAGUAY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_PARAGUAY_17'),
        ('CIVILIZATION_UC_PARAGUAY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_PARAGUAY_18'),
        ('CIVILIZATION_UC_PARAGUAY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_PARAGUAY_19'),
        ('CIVILIZATION_UC_PARAGUAY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_PARAGUAY_20'),
        ('CIVILIZATION_UC_PARAGUAY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_PARAGUAY_21');
------------------------------------------------------------
-- Civilization_JFD_Titles
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Titles (
	CivilizationType  					text 		REFERENCES Civilizations(Type) 				default null,
	CultureType							text 		 											default null,
	ReligionType						text 		REFERENCES Religions(Type) 					default null,
	DefaultTitle						text 		 											default null,
	UniqueTitle							text 		 											default null,
	UseAdjective						boolean													default 0);	
	
INSERT INTO Civilization_JFD_Titles
		(CivilizationType,				DefaultTitle,											UniqueTitle,															UseAdjective)
VALUES	('CIVILIZATION_UC_PARAGUAY',	'TXT_KEY_GOVERNMENT_JFD_DICTATORSHIP_TITLE_GOVERNMENT',	'TXT_KEY_GOVERNMENT_JFD_DICTATORSHIP_TITLE_GOVERNMENT_UC_PARAGUAY',	0),	
		('CIVILIZATION_UC_PARAGUAY',	'TXT_KEY_GOVERNMENT_JFD_DICTATORSHIP_TITLE_LEADER',		'TXT_KEY_GOVERNMENT_JFD_DICTATORSHIP_TITLE_LEADER_UC_PARAGUAY',		0);
------------------------------------------------------------
-- Civilization_JFD_Politics
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Politics (
	CivilizationType  					text 		REFERENCES Civilizations(Type) 				default null,
	PoliticsType  						text 													default null,
	UniqueName							text													default	null);

INSERT INTO Civilization_JFD_Politics
		(CivilizationType,				UniqueName,												PoliticsType)
VALUES	('CIVILIZATION_UC_PARAGUAY',	'TXT_KEY_JFD_ASSEMBLY_JFD_MILITARY_UC_PARAGUAY',		'ASSEMBLY_JFD_MILITARY'),
		('CIVILIZATION_UC_PARAGUAY',	'TXT_KEY_JFD_FACTION_JFD_NATIONALIST_UC_PARAGUAY',	'FACTION_JFD_NATIONALIST'),
		('CIVILIZATION_UC_PARAGUAY',	'TXT_KEY_JFD_FACTION_JFD_POPULARIST_UC_PARAGUAY',		'FACTION_JFD_POPULARIST'),
		('CIVILIZATION_UC_PARAGUAY',	'TXT_KEY_JFD_PARTY_JFD_REVOLUTIONARY_UC_PARAGUAY',	'FACTION_JFD_REVOLUTIONARY'),
		('CIVILIZATION_UC_PARAGUAY',	'TXT_KEY_JFD_PARTY_JFD_BURGHERS_UC_PARAGUAY',			'PARTY_JFD_BURGHERS'),
		('CIVILIZATION_UC_PARAGUAY',	'TXT_KEY_JFD_PARTY_JFD_CLERGY_UC_PARAGUAY',			'PARTY_JFD_CLERGY'),
		('CIVILIZATION_UC_PARAGUAY',	'TXT_KEY_JFD_PARTY_JFD_COMMUNIST_UC_PARAGUAY',		'PARTY_JFD_COMMUNIST'),
		('CIVILIZATION_UC_PARAGUAY',	'TXT_KEY_JFD_PARTY_JFD_CONSERVATIVE_UC_PARAGUAY',		'PARTY_JFD_CONSERVATIVE'),
		('CIVILIZATION_UC_PARAGUAY',	'TXT_KEY_JFD_PARTY_JFD_FASCIST_UC_PARAGUAY',			'PARTY_JFD_FASCIST'),
		('CIVILIZATION_UC_PARAGUAY',	'TXT_KEY_JFD_PARTY_JFD_LIBERAL_UC_PARAGUAY',			'PARTY_JFD_LIBERAL'),
		('CIVILIZATION_UC_PARAGUAY',	'TXT_KEY_JFD_PARTY_JFD_LIBERTARIAN_UC_PARAGUAY',		'PARTY_JFD_LIBERTARIAN'),
		('CIVILIZATION_UC_PARAGUAY',	'TXT_KEY_JFD_PARTY_JFD_NOBILITY_UC_PARAGUAY',			'PARTY_JFD_NOBILITY'),
		('CIVILIZATION_UC_PARAGUAY',	'TXT_KEY_JFD_PARTY_JFD_REACTIONARY_UC_PARAGUAY',		'PARTY_JFD_REACTIONARY'),
		('CIVILIZATION_UC_PARAGUAY',	'TXT_KEY_JFD_PARTY_JFD_REVOLUTIONARY_UC_PARAGUAY',	'PARTY_JFD_REVOLUTIONARY'),
		('CIVILIZATION_UC_PARAGUAY',	'TXT_KEY_JFD_PARTY_JFD_SOCIALIST_UC_PARAGUAY',		'PARTY_JFD_SOCIALIST');
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
		(LeaderType,			FlavorType,							Flavor)
VALUES	('LEADER_UC_SOLANO',		'FLAVOR_JFD_REFORM_GOVERNMENT',		8),
		('LEADER_UC_SOLANO',		'FLAVOR_JFD_REFORM_LEGAL',			8),
		('LEADER_UC_SOLANO',		'FLAVOR_JFD_REFORM_CULTURE',		10),
		('LEADER_UC_SOLANO',		'FLAVOR_JFD_REFORM_ECONOMIC',		7),
		('LEADER_UC_SOLANO',		'FLAVOR_JFD_REFORM_FOREIGN',		7),
		('LEADER_UC_SOLANO',		'FLAVOR_JFD_REFORM_INDUSTRY',		7),
		('LEADER_UC_SOLANO',		'FLAVOR_JFD_REFORM_MILITARY',		10),
		('LEADER_UC_SOLANO',		'FLAVOR_JFD_REFORM_RELIGION',		8);
--------------------------------------------------------------------------------------------------------------------------
-- Leader_JFD_Reforms
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Leader_JFD_Reforms (
	LeaderType  					text 	REFERENCES Leaders(Type) 	default	null,
	ReformType						text								default	null);
	
INSERT INTO Leader_JFD_Reforms
		(LeaderType,			ReformType)
VALUES	('LEADER_UC_SOLANO',		'REFORM_JFD_LEGISLATURE_D_MILITARY'),
		('LEADER_UC_SOLANO',		'REFORM_JFD_POWER_HARD'),
		('LEADER_UC_SOLANO',		'REFORM_JFD_CONFLICT_OFFENSE');
--==========================================================================================================================
-- SUKRITACT DECISIONS
--==========================================================================================================================
-- DecisionsAddin_Support
------------------------------
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('SolanoDecisions.lua');
--==========================================================================================================================
--==========================================================================================================================
