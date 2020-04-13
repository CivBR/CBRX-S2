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
        (LeaderType,            TraitOne,					TraitTwo)
VALUES  ('LEADER_UC_HERMANN', 	'POLICY_SPIRITUAL_X',		'POLICY_AGGRESSIVE_X');
------------------------------	
-- Leaders
------------------------------	
UPDATE Leaders 
SET Description = 'Hermann [ICON_PEACE][ICON_WAR]'
WHERE Type = 'LEADER_UC_HERMANN'
AND EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_SPIRITUAL_X');
--==========================================================================================================================
-- Sukritact's Events
--==========================================================================================================================
-- EventsAddin_Support
------------------------------
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('TeutonDecisions.lua');
--==========================================================================================================================
-- BrutalSamurai's Ethnic Units/Gedemon's R.E.D.
--==========================================================================================================================
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_GERMANY' )
	THEN '_GERMANY'
	ELSE '_EUROPE' END) 
WHERE Type = 'CIVILIZATION_UC_TEUTONS';
--==========================================================================================================================
-- GEDEMON YNAEMP
--==========================================================================================================================
-- Civilizations_YagemStartPosition (Earth Giant)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
			(Type,								X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_UC_TEUTONS',	27,		71,		null,	null);
--==========================================================================================================================
-- Civilizations_YahemStartPosition (Earth Huge)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
			(Type,								X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_UC_TEUTONS',	65,		62,		null,	null);
--==========================================================================================================================
-- Civilizations_CordiformStartPosition (Earth Standard)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
			(Type,								X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_UC_TEUTONS',	40,		34,		null,	null);
--==========================================================================================================================
-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
			(Type,								X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_UC_TEUTONS',	54,		56,		null,	null);
--==========================================================================================================================
-- Civilizations_EuroGiantStartPosition
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_EuroGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroGiantStartPosition
			(Type,								X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_UC_TEUTONS',	86,	74,		null,	null);
--==========================================================================================================================
-- Civilizations_EuroLargeStartPosition
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroLargeStartPosition
			(Type,								X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_UC_TEUTONS',	42,		51,		null,	null);
--==========================================================================================================================
-- Civilizations_YagemRequestedResource (Earth Giant)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource
			(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_UC_TEUTONS'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE Type = 'CIVILIZATION_GERMANY';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_EuroEasternStartPosition (Eastern Europe)
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_EuroEasternStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroEasternStartPosition
		(Type,									X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_UC_TEUTONS',					19,		42,		null,	null);
--==========================================================================================================================
-- Civilizations_YahemRequestedResource
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_YahemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YahemRequestedResource
			(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_UC_TEUTONS'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE Type = 'CIVILIZATION_GERMANY';
--==========================================================================================================================
-- Civilizations_GreatestEarthRequestedResource 
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_GreatestEarthRequestedResource
			(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_UC_TEUTONS'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_GreatestEarthRequestedResource WHERE Type = 'CIVILIZATION_GERMANY';
------------------------------------------------------------	
-- Civilizations_EuroLargeRequestedResource (Europe Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroGiantRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_EuroGiantRequestedResource
			(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_UC_TEUTONS'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_EuroGiantRequestedResource WHERE (Type = 'CIVILIZATION_GERMANY');
------------------------------------------------------------	
-- Civilizations_EuroLargeRequestedResource (Europe Large)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_EuroLargeRequestedResource
			(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_UC_TEUTONS'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_EuroLargeRequestedResource WHERE (Type = 'CIVILIZATION_GERMANY');
--==========================================================================================================================
-- Hazel's Map Labels
--==========================================================================================================================
-- ML_CivCultures
------------------------------	
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
			(CivType,							CultureType,		CultureEra)
VALUES		('CIVILIZATION_UC_TEUTONS',	'CENTRALEUROPE ',		'ANY');
--==========================================================================================================================
-- JFD USER SETTINGS
--==========================================================================================================================
-- JFD_GlobalUserSettings
-------------------------------------
CREATE TABLE IF NOT EXISTS 
JFD_GlobalUserSettings (
	Type 											text 										default null,
	Value 											integer 									default 1);
--==========================================================================================================
--==========================================================================================================================
-- JFD's Cultural Diversity
--==========================================================================================================================
-- Civilization_JFD_CultureTypes
------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	CultureType 								text										default null,
	SplashScreenTag								text										default	null,
	SoundtrackTag								text										default	null,
	UnitDialogueTag                             text                                        default null);

INSERT INTO Civilization_JFD_CultureTypes
		(CivilizationType,					ArtDefineTag, CultureType, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT	('CIVILIZATION_UC_TEUTONS'),	ArtDefineTag, CultureType, SplashScreenTag, SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_GERMANY';
------------------------------	
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET SoundtrackTag = 'JFD_Central'
WHERE Type = 'CIVILIZATION_UC_TEUTONS'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Central')
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
			(CivilizationType, 					ColonyName,		LinguisticType)
VALUES		('CIVILIZATION_UC_TEUTONS',	null,			'JFD_Central');
--==========================================================================================================================	
-- JFD's Piety & Prestige
--==========================================================================================================================	
UPDATE Unit_FreePromotions
SET PromotionType = 'PROMOTION_UC_TEUTON_PIETY'
WHERE UnitType = 'UNIT_UC_TEUTON' AND PromotionType = 'PROMOTION_UC_TEUTON_1' AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_RTP_PIETY_CORE' AND Value = 1); 

------------------------------------------------------------
-- Traits
------------------------------------------------------------	
UPDATE Traits
SET Description = 'TXT_KEY_TRAIT_UC_TEUTON_PIETY'
WHERE Type = 'TRAIT_UC_TEUTON'
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_RTP_PIETY_CORE' AND Value = 1);

--====================================	
-- Units
------------------------------------------------------------	
UPDATE Units
SET Help = 'TXT_KEY_UNIT_HELP_UC_TEUTON_PIETY', Strategy = 'TXT_KEY_UNIT_UC_TEUTON_STRATEGY_PIETY'
WHERE Type = 'UNIT_UC_TEUTON'
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_RTP_PIETY_CORE' AND Value = 1);

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
			(LeaderType,			FlavorType,								Flavor)
VALUES		('LEADER_UC_HERMANN',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',		10);
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
		(CivilizationType,						CurrencyType)
SELECT	'CIVILIZATION_UC_TEUTONS',	CurrencyType
FROM Civilization_JFD_Currencies WHERE CivilizationType = 'CIVILIZATION_GERMANY';
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
		(CivilizationType,						LegislatureName, OfficeTitle, GovernmentType, Weight)
SELECT	'CIVILIZATION_UC_TEUTONS',	LegislatureName, OfficeTitle, GovernmentType, Weight
FROM Civilization_JFD_Governments WHERE CivilizationType = 'CIVILIZATION_GERMANY';
------------------------------------------------------------	
-- Civilization_JFD_HeadsOfGovernment	
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 	
	Civilization_JFD_HeadsOfGovernment (	
	CivilizationType  				text 		REFERENCES Civilizations(Type) 					default null,
	CultureType						text 		 												default null,
	HeadOfGovernmentName			text 		 												default null);

INSERT INTO Civilization_JFD_HeadsOfGovernment
        (CivilizationType,      					HeadOfGovernmentName)
VALUES  ('CIVILIZATION_UC_TEUTONS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_1'),
        ('CIVILIZATION_UC_TEUTONS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_2'),
        ('CIVILIZATION_UC_TEUTONS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_3'),
        ('CIVILIZATION_UC_TEUTONS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_4'),
        ('CIVILIZATION_UC_TEUTONS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_5'),
        ('CIVILIZATION_UC_TEUTONS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_6'),
        ('CIVILIZATION_UC_TEUTONS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_7'),
        ('CIVILIZATION_UC_TEUTONS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_8'),
        ('CIVILIZATION_UC_TEUTONS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_9'),
        ('CIVILIZATION_UC_TEUTONS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_10'),
        ('CIVILIZATION_UC_TEUTONS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_11'),
        ('CIVILIZATION_UC_TEUTONS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_12'),
        ('CIVILIZATION_UC_TEUTONS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_13'),
        ('CIVILIZATION_UC_TEUTONS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_14'),
        ('CIVILIZATION_UC_TEUTONS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_15'),
        ('CIVILIZATION_UC_TEUTONS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_16'),
        ('CIVILIZATION_UC_TEUTONS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_17'),
        ('CIVILIZATION_UC_TEUTONS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_18'),
        ('CIVILIZATION_UC_TEUTONS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_19'),
        ('CIVILIZATION_UC_TEUTONS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_20'),
        ('CIVILIZATION_UC_TEUTONS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_21'),
        ('CIVILIZATION_UC_TEUTONS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_22'),
        ('CIVILIZATION_UC_TEUTONS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_23'),
        ('CIVILIZATION_UC_TEUTONS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_24'),
        ('CIVILIZATION_UC_TEUTONS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_25');
--====================================
-- JFD PROVINCES 
--====================================
-- Civilization_JFD_ProvinceTitles
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_ProvinceTitles (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 					default null,
	ReligionType  					text 		REFERENCES Religions(Type) 						default null,
	DefaultTitle					text 		 												default null,
	UniqueTitle						text 		 												default null,
	UseAdjective					boolean														default 0);	

INSERT INTO Civilization_JFD_ProvinceTitles
		(CivilizationType,						DefaultTitle, UniqueTitle, UseAdjective)
SELECT	'CIVILIZATION_UC_HERMANN',	DefaultTitle, UniqueTitle, UseAdjective
FROM Civilization_JFD_ProvinceTitles WHERE CivilizationType = 'CIVILIZATION_GERMANY';
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
		(LeaderType,				FlavorType,				Flavor)
VALUES	('LEADER_UC_HERMANN',	'FLAVOR_JFD_SLAVERY',	7);
------------------------------------------------------------
-- Civilization_JFD_Politics
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Politics (
	CivilizationType  					text 		REFERENCES Civilizations(Type) 					default null,
	PoliticsType  						text 														default null,
	UniqueName							text														default	null);

INSERT INTO Civilization_JFD_Politics
		(CivilizationType,						PoliticsType, UniqueName)
SELECT	'CIVILIZATION_UC_TEUTONS',	PoliticsType, UniqueName
FROM Civilization_JFD_Politics WHERE CivilizationType = 'CIVILIZATION_GERMANY';
------------------------------------------------------------			
-- Flavors
------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_REFORM_GOVERNMENT'),
		('FLAVOR_JFD_REFORM_CULTURE'),
		('FLAVOR_JFD_REFORM_ECONOMIC'),
		('FLAVOR_JFD_REFORM_FOREIGN'),
		('FLAVOR_JFD_REFORM_LEGAL'),
		('FLAVOR_JFD_REFORM_INDUSTRY'),
		('FLAVOR_JFD_REFORM_MILITARY'),
		('FLAVOR_JFD_REFORM_RELIGION');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------
INSERT INTO Leader_Flavors
		(LeaderType,					FlavorType,							 Flavor)
VALUES	('LEADER_UC_HERMANN',	'FLAVOR_JFD_REFORM_GOVERNMENT',		 10),
		('LEADER_UC_HERMANN',	'FLAVOR_JFD_REFORM_CULTURE',		 10),
		('LEADER_UC_HERMANN',	'FLAVOR_JFD_REFORM_ECONOMIC',		 7),
		('LEADER_UC_HERMANN',	'FLAVOR_JFD_REFORM_FOREIGN',		 10),
		('LEADER_UC_HERMANN',	'FLAVOR_JFD_REFORM_INDUSTRY',		 7),
		('LEADER_UC_HERMANN',	'FLAVOR_JFD_REFORM_LEGAL',			 10),
		('LEADER_UC_HERMANN',	'FLAVOR_JFD_REFORM_MILITARY',		 10),
		('LEADER_UC_HERMANN',	'FLAVOR_JFD_REFORM_RELIGION',		 10);
--==========================================================================================================================    
-- JFD's and Pouakai's MERCENARIES
--==========================================================================================================================
-- Flavors
------------------------------------------------------------    
INSERT OR REPLACE INTO Flavors 
			(Type)
VALUES		('FLAVOR_JFD_MERCENARY');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------    
INSERT INTO Leader_Flavors
			(LeaderType,			FlavorType,					Flavor)
VALUES		('LEADER_UC_HERMANN',	'FLAVOR_JFD_MERCENARY',		6);
--Language_en_US

insert into Language_en_US (Tag, Text)
values 

('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_1', 'Gerhard von Malberg'),
('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_2', 'Heinrich von Hohenlohe'),
('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_3', 'Poppo von Osterna'),
('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_4', 'Anno von Sangershausen'),
('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_5', 'Hartmann von Heldrungen'),
('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_6', 'Konrad von Feuchtwangen'),
('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_7', 'Siegfried von Feuchtwangen'),
('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_8', 'Karl von Trier'),
('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_9', 'Werner von Orseln'),
('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_10', 'Dietrich von Altenburg'),
('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_11', 'Heinrich Dusemer'),
('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_12', 'Winrich von Kniprode'),
('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_13', 'Konrad von Wallenrode'),
('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_14', 'Ulrich von Jungingen'),
('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_15', 'Michael Kuchmeister von Sternberg'),
('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_16', 'Paul von Rusdorf'),
('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_17', 'Konrad von Erlichshausen'),
('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_18', 'Heinrich Reffle von Richtenberg'),
('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_19', 'Martin Truchsess von Wetzhausen'),
('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_20', 'Johann von Tiefen'),
('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_21', 'Albert of Brandenburg-Ansbach'),
('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_22', 'Heinrich Walpot von Bassenheim'),
('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_23', 'Heinrich von Tunna'),
('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_24', 'Ludolf Konig'),
('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_TEUTONS_25', 'Luther von Braunschweig');
