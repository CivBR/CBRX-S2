--==========================================================================================================================
-- WHOWARD's DLL / COMMUNITY PATCH
--==========================================================================================================================
-- CustomModOptions
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CustomModOptions(Name, Value);
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
-- GEDEMON's YNAEMP (+JFD's v23)
--==========================================================================================================================
/*	Tables (example below; replace Civilizations with MinorCivilizations where appropriate):
  
	Yagem
	Yahem
	GreatestEarth 
	EuroLarge
	EuroGiant
	EastAsia	
	Apennine
	BritishIsles
	NorthEastAsia
	Aegean
	NorthAtlantic
	Pacific
	SouthPacific
	NorthWestEurope
	Caribbean
	Asia
	Mediterranean
	Mesopotamia
	AfricaLarge
	NileValley
	Americas
*/
--===================================
-- Yagem (Earth Giant)
--===================================
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
		(Type,						X,			Y)
VALUES	('CIVILIZATION_MC_MHA',		139,		71);
-------------------------------------
-- RequestedResource
-------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource
		(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_MC_MHA',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE Type = 'CIVILIZATION_SHOSHONE';
--===================================
-- Yahem (Earth Huge)
--===================================
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
		(Type,						X,			Y)
VALUES	('CIVILIZATION_MC_MHA',		21,			59);
-------------------------------------
-- RequestedResource
-------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_YahemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YahemRequestedResource
		(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_MC_MHA',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE Type = 'CIVILIZATION_SHOSHONE';
--===================================
-- GreatestEarth
--===================================
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
		(Type,						X,			Y)
VALUES	('CIVILIZATION_MC_MHA',		9,			51);
-------------------------------------
-- RequestedResource
-------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_GreatestEarthRequestedResource
		(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_MC_MHA',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_GreatestEarthRequestedResource WHERE Type = 'CIVILIZATION_SHOSHONE';
--===================================
-- Americas
--===================================
CREATE TABLE IF NOT EXISTS Civilizations_AmericasStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AmericasStartPosition
		(Type,						X,			Y)
VALUES	('CIVILIZATION_MC_MHA',		37,			59);
-------------------------------------
-- RequestedResource
-------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_AmericasRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AmericasRequestedResource
		(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_MC_MHA',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AmericasRequestedResource WHERE Type = 'CIVILIZATION_SHOSHONE';
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
        (LeaderType,			TraitOne,               TraitTwo)
VALUES  ('LEADER_MC_FOURBEARS', 	'POLICY_EXPANSIVE_X',	'POLICY_FINANCIAL_X');
------------------------------	
-- Leaders
------------------------------	
UPDATE Leaders 
SET Description = 'Four Bears [ICON_FOOD][ICON_TRADE]'
WHERE Type = 'LEADER_MC_FOURBEARS'
AND EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');
--=======================================================================================================================	
-- Historical Religions Support
--=======================================================================================================================	
UPDATE Civilization_Religions 
SET ReligionType = ( CASE WHEN EXISTS(SELECT Type FROM Religions WHERE Type = 'RELIGION_WAKAN_TANKA' )
		THEN 'RELIGION_WAKAN_TANKA'
		ELSE 'RELIGION_PROTESTANTISM' END) 
WHERE CivilizationType = 'CIVILIZATION_MC_MHA';
--==========================================================================================================================
-- GEDEMON R.E.D.
--==========================================================================================================================
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET ArtStyleSuffix = '_IROQUOIS'
WHERE Type = 'CIVILIZATION_MC_MHA'
AND EXISTS (SELECT * FROM Civilizations WHERE ArtStyleSuffix = '_IROQUOIS');
--==========================================================================================================================
-- HAZEL MAP LABELS
--==========================================================================================================================
-- ML_CivCultures
------------------------------	
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
		(CivType,					CultureType,			CultureEra)
VALUES	('CIVILIZATION_MC_MHA',		'FIRST_AMERICANS',		'ANY');	
--==========================================================================================================================
-- JFD's CITIES IN DEVELOPMENT (10e9728f-d61c-4317-be4f-7d52d6bae6f4)
--==========================================================================================================================
-- BuildingClass_ConstructionAudio
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS
Building_ConstructionAudio (
    BuildingType                                text    REFERENCES Buildings(Type)              default null,
    ConstructionAudio                           text											default null);
	
INSERT INTO Building_ConstructionAudio 
		(BuildingType, 				ConstructionAudio)
SELECT	'BUILDING_MC_EARTHLODGE',	'AS2D_BUILDING_JFD_LONGHOUSE'
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_MISC_CIV_BUILDING_SOUNDS' AND Value = 1);
------------------------------------------------------------
-- Civilization_JFD_ColonialCityNames
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_ColonialCityNames (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	ColonyName 									text										default null,
	LinguisticType								text										default	null,
	CultureType									text										default	null);

INSERT INTO Civilization_JFD_ColonialCityNames
		(CivilizationType, 						ColonyName,								LinguisticType)
VALUES	('CIVILIZATION_MC_MHA', 				null,									'JFD_NorthAmerican');
--==========================================================================================================================
-- JFD's CHARTERED VENTURES (34c6919a-fcb5-44cf-8a76-78380dbc39ab)
--==========================================================================================================================
-- Civilization_JFD_Currencies
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Currencies (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 	default null,
	CurrencyType	  				text 		  								default null);

INSERT INTO Civilization_JFD_Currencies
		(CivilizationType,					CurrencyType)
SELECT	'CIVILIZATION_MC_MHA',				CurrencyType
FROM Civilization_JFD_Currencies WHERE CivilizationType = 'CIVILIZATION_SHOSHONE';
--==========================================================================================================================
-- JFD's CULTURAL DIVERSITY (31a31d1c-b9d7-45e1-842c-23232d66cd47)
--==========================================================================================================================
-- Civilization_JFD_CultureTypes
-------------------------------------	
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
		(CivilizationType,			ArtDefineTag, CultureType, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT	'CIVILIZATION_MC_MHA',		ArtDefineTag, CultureType, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_SHOSHONE';

UPDATE Civilizations 
SET SoundtrackTag = 'JFD_TribalAmerican'
WHERE Type = 'CIVILIZATION_MC_MHA'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_TribalAmerican');
--==========================================================================================================================	
-- JFD's AND POUAKAI's MERCENARIES (a19351c5-c0b3-4b07-8695-4affaa199949)
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
		(LeaderType,				FlavorType,					Flavor)
VALUES	('LEADER_MC_FOURBEARS',	'FLAVOR_JFD_MERCENARY',		6);
--==========================================================================================================================	
-- JFD's PIETY (eea66053-7579-481a-bb8d-2f3959b59974)
--==========================================================================================================================	
-- Flavors
------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_RELIGIOUS_INTOLERANCE');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------	
INSERT INTO Leader_Flavors
		(LeaderType,			FlavorType,								Flavor)
VALUES	('LEADER_MC_FOURBEARS',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',		3);
--==========================================================================================================================	
-- JFD's SOVEREIGNTY (d99bf7aa-51ac-4bef-bd88-d765b28e260e)
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
		(CivilizationType,          LegislatureName, OfficeTitle, GovernmentType, Weight)
SELECT  ('CIVILIZATION_MC_MHA'), 	LegislatureName, OfficeTitle, GovernmentType, Weight
FROM Civilization_JFD_Governments WHERE CivilizationType = 'CIVILIZATION_SHOSHONE';
------------------------------------------------------------	
-- Civilization_JFD_HeadsOfGovernment	
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 	
	Civilization_JFD_HeadsOfGovernment (	
	CivilizationType  				text 		REFERENCES Civilizations(Type) 					default null,
	CultureType						text 		 												default null,
	HeadOfGovernmentName			text 		 												default null);

INSERT INTO Civilization_JFD_HeadsOfGovernment
		(CivilizationType,		HeadOfGovernmentName)
VALUES  ('CIVILIZATION_MC_MHA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_MHA_1'),
		('CIVILIZATION_MC_MHA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_MHA_2'),
		('CIVILIZATION_MC_MHA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_MHA_3'),
		('CIVILIZATION_MC_MHA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_MHA_4'),
		('CIVILIZATION_MC_MHA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_MHA_5'),
		('CIVILIZATION_MC_MHA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_MHA_6'),
		('CIVILIZATION_MC_MHA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_MHA_7'),
		('CIVILIZATION_MC_MHA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_MHA_8'),
		('CIVILIZATION_MC_MHA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_MHA_9'),
		('CIVILIZATION_MC_MHA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_MHA_10'),
		('CIVILIZATION_MC_MHA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_MHA_11'),
		('CIVILIZATION_MC_MHA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_MHA_12'),
		('CIVILIZATION_MC_MHA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_MHA_13'),
		('CIVILIZATION_MC_MHA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_MHA_14'),
		('CIVILIZATION_MC_MHA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_MHA_15');

INSERT INTO Language_en_US 
		(Tag, 															Text) 
VALUES	('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_MHA_1',	'Bloody Knife'),
		('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_MHA_2',	'Buffalo Bird Woman'),
		('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_MHA_3',	'Bull Neck'),
		('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_MHA_4',	'Black Fox'),
		('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_MHA_5',	'Bear''s Teeth'),
		('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_MHA_6',	'Bear''s Belly'),
		('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_MHA_7',	'White Shield'),
		('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_MHA_8',	'Road Maker'),
		('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_MHA_9',	'Charging Eagle'),
		('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_MHA_10',	'Crows Flies High'),
		('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_MHA_11',	'Gray Eyes'),
		('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_MHA_12',	'Poor Wolf'),
		('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_MHA_13',	'Big White'),
		('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_MHA_14',	'Alyce Spotted Bear'),
		('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_MHA_15',	'Wolf Chief');

------------------------------------------------------------
-- Flavors
------------------------------------------------------------    
INSERT OR REPLACE INTO Flavors 
		(Type)
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
INSERT INTO Leader_Flavors
		(LeaderType,					FlavorType,	Flavor)
SELECT  ('LEADER_MC_FOURBEARS'), 		FlavorType, Flavor
FROM Leader_Flavors WHERE FlavorType IN (
	'FLAVOR_JFD_REFORM_GOVERNMENT', 
	'FLAVOR_JFD_REFORM_CULTURE', 
	'FLAVOR_JFD_REFORM_ECONOMIC',
	'FLAVOR_JFD_REFORM_FOREIGN',
	'FLAVOR_JFD_REFORM_INDUSTRY',
	'FLAVOR_JFD_REFORM_MILITARY',
	'FLAVOR_JFD_REFORM_RELIGION',
) AND LeaderType = 'LEADER_POCATELLO';
--==========================================================================================================================
-- RYOGA's UNIQUE CULTURAL INFLUENCE
--==========================================================================================================================
INSERT OR REPLACE INTO Language_en_US (Tag, Text)
VALUES(
		'TXT_KEY_GENERIC_MC_MHA_INFLUENTIAL_ON_AI_1',
		'Our people are now forming societies and living in earth lodges. I worry the rest of the world will also succumb to the influence of your culture.'
	);
--==========================================================================================================================
-- SUKRITACT EVENTS
--==========================================================================================================================
-- Events_CulturalDevelopments
------------------------------
CREATE TABLE IF NOT EXISTS 
Events_CulturalDevelopments(
	CivilizationType		text  REFERENCES Civilizations(Type)	default null,
	CultureType				text									default null,
	Description				text									default null);

INSERT INTO Events_CulturalDevelopments 
		(Description,							CivilizationType,			CultureType)
VALUES	('TXT_KEY_EVENT_CULDEV_MC_MHA_01',		'CIVILIZATION_MC_MHA',		'JFD_TribalAmerican');

INSERT INTO Language_en_US 
		(Tag, 									Text) 
VALUES	('TXT_KEY_EVENT_CULDEV_MC_MHA_01',		'Tchungkee, a sport played by rolling disc-shaped stones across the ground and throwing spears at them, has become popular in {1_City}.');
--==========================================================================================================================
--==========================================================================================================================