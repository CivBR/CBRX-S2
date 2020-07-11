--==========================================================================================================================
-- USER SETTINGS (THIS IS NEEDED IN MOST CASES)
--==========================================================================================================================
-- JFD_GlobalUserSettings
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS
	JFD_GlobalUserSettings (
    Type                text            default null,
    Value               integer         default 1);
--=========================================================================================================================
-- BINGLES CIV IV TRAITS
--=========================================================================================================================
-- Leader_SharedTraits
------------------------------	
CREATE TABLE IF NOT EXISTS 
    Leader_SharedTraits (
    LeaderType          text    REFERENCES Leaders(Type)        default null,
    TraitOne            text    REFERENCES Policies(Type)       default null,
    TraitTwo            text    REFERENCES Policies(Type)       default null);
     
INSERT INTO Leader_SharedTraits
        (LeaderType,					TraitOne,				TraitTwo)
SELECT  'LEADER_JWW_ANTONIO_CANALES',	'POLICY_AGGRESSIVE_X',	'POLICY_EXPANSIVE_X'
WHERE EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');
------------------------------	
-- Leaders
------------------------------	
UPDATE Leaders 
SET Description = 'Antonio Canales Rosillo [ICON_WAR][ICON_FOOD]'
WHERE Type = 'LEADER_JWW_ANTONIO_CANALES'
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
SET ArtStyleSuffix = '_SPAIN'
WHERE Type = 'CIVILIZATION_JWW_RIO_GRANDE'
AND EXISTS (SELECT * FROM Civilizations WHERE ArtStyleSuffix = '_SPAIN');
--==========================================================================================================================
-- GEDEMON's YnAEMP (+JFD's v23 and v24)
--==========================================================================================================================
-- Civilizations_YagemStartPosition (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT OR REPLACE INTO Civilizations_YagemStartPosition
		(Type,								X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_JWW_RIO_GRANDE',		139,	55,		null,	null);
------------------------------------------------------------	
-- Civilizations_YahemStartPosition (Earth Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT OR REPLACE INTO Civilizations_YahemStartPosition
		(Type,								X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_JWW_RIO_GRANDE',		20,		49,		null,	null);
------------------------------------------------------------	
-- Civilizations_CordiformStartPosition (Earth Standard)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT OR REPLACE INTO Civilizations_CordiformStartPosition
		(Type,								X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_JWW_RIO_GRANDE',		6,		31,		null,	null);
------------------------------------------------------------	
-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT OR REPLACE INTO Civilizations_GreatestEarthStartPosition
		(Type,								X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_JWW_RIO_GRANDE',		11,		39,		null,	null);
------------------------------------------------------------	
-- Civilizations_EarthMk3StartPosition (Mk3 Earth)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EarthMk3StartPosition(Type, X, Y, AltX, AltY);
INSERT OR REPLACE INTO Civilizations_EarthMk3StartPosition
		(Type,								X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_JWW_RIO_GRANDE',		134,	58,		null,	null);
------------------------------------------------------------	
-- Civilizations_AmericasStartPosition (Americas)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AmericasStartPosition(Type, X, Y, AltX, AltY);
INSERT OR REPLACE INTO Civilizations_AmericasStartPosition
		(Type,								X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_JWW_RIO_GRANDE',		36,		48,		null,	null);
------------------------------------------------------------	
-- Civilizations_AmericasGiantStartPosition (Americas Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AmericasGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT OR REPLACE INTO Civilizations_AmericasGiantStartPosition
		(Type,								X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_JWW_RIO_GRANDE',		44,		104,	null,	null);
------------------------------------------------------------	
-- Civilizations_AtlanticGiantStartPosition (Atlantic Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AtlanticGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT OR REPLACE INTO Civilizations_AtlanticGiantStartPosition
		(Type,								X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_JWW_RIO_GRANDE',		39,		70,		null,	null);
------------------------------------------------------------	
-- Civilizations_CaribbeanStartPosition (Caribbean)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CaribbeanStartPosition(Type, X, Y, AltX, AltY);
INSERT OR REPLACE INTO Civilizations_CaribbeanStartPosition
		(Type,								X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_JWW_RIO_GRANDE',		6,		62,		null,	null);
------------------------------------------------------------	
-- Civilizations_NorthAmericaGiantStartPosition (North America Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthAmericaGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT OR REPLACE INTO Civilizations_NorthAmericaGiantStartPosition
		(Type,								X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_JWW_RIO_GRANDE',		65,		35,		null,	null);
------------------------------------------------------------	
-- Civilizations_NorthAmericaHugeStartPosition (North America Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthAmericaHugeStartPosition(Type, X, Y, AltX, AltY);
INSERT OR REPLACE INTO Civilizations_NorthAmericaHugeStartPosition
		(Type,								X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_JWW_RIO_GRANDE',		62,		25,		null,	null);
--==========================================================================================================================
-- Hazel's Map Labels
--==========================================================================================================================
-- ML_CivCultures
------------------------------	
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
		(CivType,							CultureType,			CultureEra)
SELECT	'CIVILIZATION_JWW_RIO_GRANDE',	CultureType,			CultureEra
FROM ML_CivCultures WHERE CivType = 'CIVILIZATION_SPAIN';
--==========================================================================================================================
-- JFD's CULTURAL DIVERSITY
--==========================================================================================================================
-- Civilization_JFD_CultureTypes
-------------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes(
	CivilizationType 					text 			default null,
	CultureType 						text			default null,
	SubCultureType 						text			default null,
	ArtDefineTag						text			default	null,
	DecisionsTag						text			default null,
	DefeatScreenEarlyTag				text			default	null,
	DefeatScreenMidTag					text			default	null,
	DefeatScreenLateTag					text			default	null,
	IdealsTag							text			default	null,
	SplashScreenTag						text			default	null,
	SoundtrackTag						text			default	null,
	UnitDialogueTag						text			default null);

INSERT INTO Civilization_JFD_CultureTypes
		(CivilizationType,					ArtDefineTag,		CultureType,				IdealsTag,			SplashScreenTag,	SoundtrackTag)
VALUES	('CIVILIZATION_JWW_RIO_GRANDE',		'JFD_WESTERN',		'CULTURE_JFD_WESTERN',		'JFD_Western',		'JFD_Western',		'JFD_Western');
--==========================================================	
-- COLONIES 
--==========================================================	
-- Civilization_JFD_ColonialCityNames
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_ColonialCityNames (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	ColonyName 									text										default null,
	LinguisticType								text										default	null,
	CultureType									text										default	null);
	
INSERT INTO Civilization_JFD_ColonialCityNames
		(CivilizationType,				LinguisticType, ColonyName)
SELECT	'CIVILIZATION_JWW_RIO_GRANDE',	LinguisticType, ColonyName
FROM Civilization_JFD_ColonialCityNames WHERE CivilizationType = 'CIVILIZATION_SPAIN';
--==========================================================	
-- PROVINCES 
--==========================================================	
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
		(CivilizationType,				DefaultTitle, UniqueTitle, UseAdjective)
SELECT	'CIVILIZATION_JWW_RIO_GRANDE',	DefaultTitle, UniqueTitle, UseAdjective
FROM Civilization_JFD_ProvinceTitles WHERE CivilizationType = 'CIVILIZATION_SPAIN';
--==========================================================	
-- SLAVERY 
--==========================================================	
-- Flavors
------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_SLAVERY');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------	
INSERT INTO Leader_Flavors
		(LeaderType,						FlavorType,					Flavor)
VALUES	('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_JFD_SLAVERY',			2);
--===========================================	
-- MERCENARIES
--===========================================
-- Flavors
------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_MERCENARY');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------
INSERT INTO Leader_Flavors
		(LeaderType,							FlavorType,					Flavor)
VALUES	('LEADER_JWW_ANTONIO_CANALES',		'FLAVOR_JFD_MERCENARY',		7);
--==========================================================	
-- SOVEREIGNTY
--==========================================================
------------------------------------------------------------
-- Civilization_JFD_Politics
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Politics (
	CivilizationType  					text 		REFERENCES Civilizations(Type) 					default null,
	PoliticsType  						text 														default null,
	UniqueName							text														default	null);

INSERT INTO Civilization_JFD_Politics
		(CivilizationType,					PoliticsType, UniqueName)
SELECT	'CIVILIZATION_JWW_RIO_GRANDE',	PoliticsType, UniqueName
FROM Civilization_JFD_Politics WHERE CivilizationType = 'CIVILIZATION_SPAIN';
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
		(LeaderType,						FlavorType,							Flavor)
VALUES	('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_JFD_REFORM_GOVERNMENT',		6),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_JFD_REFORM_LEGAL',			4),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_JFD_REFORM_CULTURE',		6),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_JFD_REFORM_ECONOMIC',		3),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_JFD_REFORM_FOREIGN',		9),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_JFD_REFORM_INDUSTRY',		2),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_JFD_REFORM_MILITARY',		9),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_JFD_REFORM_RELIGION',		2);
--==========================================================================================================================
-- ADDITIONAL ACIEVEMENTS
--==========================================================================================================================
-- AdditionalAchievements_Mods
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	AdditionalAchievements_Mods (
	ID  					integer 		PRIMARY KEY							AUTOINCREMENT,
	Type					text												default	null,
	ModName					text												default null,
	ModID					text												default	null,	
	Authors					text												default	null);

INSERT INTO AdditionalAchievements_Mods
		(Type,						ModName,								ModID,									Authors)
VALUES	('MOD_JWW_RIO_GRANDE',		'TXT_KEY_MOD_JWW_RIO_GRANDE_NAME',		'TXT_KEY_MOD_JWW_RIO_GRANDE_MODID',		'TXT_KEY_MOD_JWW_RIO_GRANDE_AUTHORS');
--------------------------------------------------------------------------------------------------------------------------
-- Achievopedia_Tabs
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Achievopedia_Tabs (
	ID  					integer 		PRIMARY KEY							AUTOINCREMENT,
	Type					text												default	null,
	Header					text												default null,
	Description				text												default	null);

INSERT OR REPLACE INTO Achievopedia_Tabs
		(Type,						Header,								Description)
VALUES	('TAB_JWW_CIVS',			'TXT_KEY_TAB_JWW_CIVS_HEADER',		'TXT_KEY_TAB_JWW_CIVS_DESCRIPTION');
--------------------------------------------------------------------------------------------------------------------------
-- AdditionalAchievements
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	AdditionalAchievements (
	ID  					integer 		PRIMARY KEY							AUTOINCREMENT,
	Type					text												default	null,
	Achievopedia			text												default null,
	Header					text												default	null,	
	IconAtlas				text												default	null,	
	PortraitIndex			integer												default	0,
	ModType					text												default	null,	
	ModVersion				integer												default	0,
	Unlocked				boolean												default	0,
	LockedIconAtlas			text												default	'CIV_COLOR_ATLAS',
	LockedPortraitIndex		integer												default	23,
	UnlockSound				text												default	'AS2D_INTERFACE_ANCIENT_RUINS',
	PopupDuration			integer												default	-1,
	Hidden					boolean												default	0,
	HiddenBorder			boolean												default	0,
	RequiredCivWin			text												default	null,
	RequiredCivLoss			text												default	null,
	RequiredCivKill			text												default	null);

INSERT INTO AdditionalAchievements
		(Type,							Header,											Achievopedia,								ModType,				ModVersion,		RequiredCivWin,						IconAtlas,					PortraitIndex)
VALUES	('AA_JWW_RIO_GRANDE_SPECIAL',	'TXT_KEY_AA_JWW_RIO_GRANDE_SPECIAL_HEADER',		'TXT_KEY_AA_JWW_RIO_GRANDE_SPECIAL_TEXT',	'MOD_JWW_RIO_GRANDE',	1,				null,								'RIOGRANDE_COLOR_ATLAS',	1),
		('AA_JWW_RIO_GRANDE_VICTORY',	'TXT_KEY_AA_JWW_RIO_GRANDE_VICTORY_HEADER',		'TXT_KEY_AA_JWW_RIO_GRANDE_VICTORY_TEXT',	'MOD_JWW_RIO_GRANDE',	1,				'CIVILIZATION_JWW_RIO_GRANDE',		'RIOGRANDE_COLOR_ATLAS',	2);
--------------------------------------------------------------------------------------------------------------------------
-- AdditionalAchievements_Tabs
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	AdditionalAchievements_Tabs (
	AchievementType			text												default	null,
	TabType					text												default	null);

INSERT OR REPLACE INTO AdditionalAchievements_Tabs
		(AchievementType,				TabType)
VALUES	('AA_JWW_RIO_GRANDE_SPECIAL',	'TAB_JWW_CIVS'),
		('AA_JWW_RIO_GRANDE_VICTORY',	'TAB_JWW_CIVS');

--==========================================================================================================================
-- HISTORICAL RELIGIONS
--==========================================================================================================================

UPDATE Civilization_Religions 
SET ReligionType = 'RELIGION_CATHOLICISM'
WHERE CivilizationType = 'CIVILIZATION_JWW_RIO_GRANDE'
AND EXISTS (SELECT * FROM Religions WHERE Type = 'RELIGION_CATHOLICISM');

--==========================================================================================================================
-- UNIQUE CULTURAL INFLUENCE
--==========================================================================================================================

INSERT INTO Diplomacy_Responses
		(LeaderType,					ResponseType,					Response,														Bias)
VALUES	('LEADER_JWW_ANTONIO_CANALES',	'RESPONSE_INFLUENTIAL_ON_AI',	'TXT_KEY_LEADER_JWW_ANTONIO_CANALES_INFLUENTIAL_ON_AI%',		1),
		('LEADER_JWW_ANTONIO_CANALES',	'RESPONSE_INFLUENTIAL_ON_HUMAN','TXT_KEY_LEADER_JWW_ANTONIO_CANALES_INFLUENTIAL_ON_HUMAN%',		1);

--==========================================================================================================================
-- EVENTS AND DECISIONS
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('RioGrande_Decisions.lua');

INSERT INTO BuildingClasses
		(Type, 											DefaultBuilding, 						Description)
VALUES	('BUILDINGCLASS_JWW_RG_NEWSPAPER_DUMMY', 		'BUILDING_JWW_RG_NEWSPAPER_DUMMY', 		'TXT_KEY_BUILDING_JWW_RG_NEWSPAPER_DUMMY');

INSERT INTO Buildings      
        (Type,                              BuildingClass,                          Cost,  FaithCost, GreatWorkCount,   NeverCapture,	UnmoddedHappiness,	Description)
VALUES  ('BUILDING_JWW_RG_NEWSPAPER_DUMMY',	'BUILDINGCLASS_JWW_RG_NEWSPAPER_DUMMY',	-1,    -1,        -1,               1,				15,					'TXT_KEY_BUILDING_JWW_RG_NEWSPAPER_DUMMY');

