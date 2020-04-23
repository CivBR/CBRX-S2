--==========================================================================================================================
-- USER SETTINGS (THIS IS NEEDED IN MOST CASES)
--==========================================================================================================================
-- JFD_GlobalUserSettings
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
JFD_GlobalUserSettings (
	Type 				text 			default null,
	Value 				integer 		default 1);
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
     
INSERT OR REPLACE INTO Leader_SharedTraits
            (LeaderType,		TraitOne,                  TraitTwo)
SELECT      'LEADER_THP_MANDUKHAI',	'POLICY_AGGRESSIVE_X',		'POLICY_IMPERIALISTIC_X'
WHERE EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');
------------------------------	
-- Leaders
------------------------------	
UPDATE Leaders 
SET Description = 'Mandukhai [ICON_WAR][ICON_CITY_STATE]'
WHERE Type = 'LEADER_THP_MANDUKHAI'
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
--------------------------------------------------------------------------------------------------------------------------
UPDATE Civilizations 
SET ArtStyleSuffix = '_MONGOL'
WHERE Type = 'CIVILIZATION_THP_NORTHYUAN'
AND EXISTS (SELECT * FROM Civilizations WHERE ArtStyleSuffix = '_MONGOL');
--==========================================================================================================================
-- GEDEMON's YNAEMP (+JFD's v23-25)
--==========================================================================================================================
-----------------------------------
-- Civilizations_YagemStartPosition
-----------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
	(Type,				X,	Y)
SELECT	'CIVILIZATION_THP_NORTHYUAN',	X,	Y
FROM Civilizations_YagemStartPosition WHERE Type = 'CIVILIZATION_MONGOL';
-----------------------------------
-- Civilizations_YahemStartPosition
-----------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
	(Type,				X,	Y)
SELECT	'CIVILIZATION_THP_NORTHYUAN',	X,	Y
FROM Civilizations_YahemStartPosition WHERE Type = 'CIVILIZATION_MONGOL';
-----------------------------------
-- Civilizations_CordiformStartPosition
-----------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
	(Type,				X,	Y)
SELECT	'CIVILIZATION_THP_NORTHYUAN',	X,	Y
FROM Civilizations_CordiformStartPosition WHERE Type = 'CIVILIZATION_MONGOL';
-----------------------------------
-- Civilizations_GreatestEarthStartPosition
-----------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
	(Type,				X,	Y)
SELECT	'CIVILIZATION_THP_NORTHYUAN',	X,	Y
FROM Civilizations_GreatestEarthStartPosition WHERE Type = 'CIVILIZATION_MONGOL';
-----------------------------------
-- Civilizations_EastAsiaStartPosition
-----------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_EastAsiaStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EastAsiaStartPosition
	(Type,				X,	Y)
SELECT	'CIVILIZATION_THP_NORTHYUAN',	X,	Y
FROM Civilizations_EastAsiaStartPosition WHERE Type = 'CIVILIZATION_MONGOL';
-----------------------------------
-- Civilizations_NorthEastAsiaStartPosition
-----------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_NorthEastAsiaStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthEastAsiaStartPosition
	(Type,				X,	Y)
SELECT	'CIVILIZATION_THP_NORTHYUAN',	X,	Y
FROM Civilizations_NorthEastAsiaStartPosition WHERE Type = 'CIVILIZATION_MONGOL';
-----------------------------------
-- Civilizations_AsiaStartPosition
-----------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_AsiaStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AsiaStartPosition
	(Type,				X,	Y)
SELECT	'CIVILIZATION_THP_NORTHYUAN',	X,	Y
FROM Civilizations_AsiaStartPosition WHERE Type = 'CIVILIZATION_MONGOL';
-----------------------------------
-- Civilizations_AsiaSmallStartPosition
-----------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_AsiaSmallStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AsiaSmallStartPosition
	(Type,				X,	Y)
SELECT	'CIVILIZATION_THP_NORTHYUAN',	X,	Y
FROM Civilizations_AsiaSmallStartPosition WHERE Type = 'CIVILIZATION_MONGOL';
-----------------------------------
-- Civilizations_AsiaSteppeGiantStartPosition
-----------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_AsiaSteppeGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AsiaSteppeGiantStartPosition
	(Type,				X,	Y)
SELECT	'CIVILIZATION_THP_NORTHYUAN',	X,	Y
FROM Civilizations_AsiaSteppeGiantStartPosition WHERE Type = 'CIVILIZATION_MONGOL';
-----------------------------------
-- Civilizations_CentralAsiaStartPosition
-----------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_CentralAsiaStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CentralAsiaStartPosition
	(Type,				X,	Y)
SELECT	'CIVILIZATION_THP_NORTHYUAN',	X,	Y
FROM Civilizations_CentralAsiaStartPosition WHERE Type = 'CIVILIZATION_MONGOL';
-----------------------------------
-- Civilizations_AfriAsiaAustStartPosition
-----------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_AfriAsiaAustStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AfriAsiaAustStartPosition
	(Type,				X,	Y)
SELECT	'CIVILIZATION_THP_NORTHYUAN',	X,	Y
FROM Civilizations_AfriAsiaAustStartPosition WHERE Type = 'CIVILIZATION_MONGOL';
-----------------------------------
-- Civilizations_EarthMk3StartPosition
-----------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_EarthMk3StartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EarthMk3StartPosition
	(Type,				X,	Y)
SELECT	'CIVILIZATION_THP_NORTHYUAN',	X,	Y
FROM Civilizations_EarthMk3StartPosition WHERE Type = 'CIVILIZATION_MONGOL';
-------------------------------------
-- Civilizations_YagemRequestedResource (Earth Giant)
-------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource
		(Type, 			Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_THP_NORTHYUAN',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE Type = 'CIVILIZATION_MONGOL';
--==========================================================================================================================
-- JFD CIVILOPEDIA
--==========================================================================================================================
-- JFD_Civilopedia_HideFromPedia
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
JFD_Civilopedia_HideFromPedia (Type text default null);

INSERT INTO JFD_Civilopedia_HideFromPedia
		(Type)
VALUES	('PROMOTION_THP_HHP_POSTCOMBAT');

UPDATE Civilizations
SET DerivativeCiv = 'CIVILIZATION_MONGOL'
WHERE Type = 'CIVILIZATION_THP_NORTHYUAN';	
--==========================================================================================================================
-- JFD's CITIES IN DEVELOPMENT (10e9728f-d61c-4317-be4f-7d52d6bae6f4)
-- Please Note: it is NOT necessary to make any changes to this if you had supported Colony Names under the ExCE ID. 
-- You will only need to add support for Claims if you wish some of your Decisions to cost Dignitaries instead of Magistrates. Examples TBD.
--==========================================================================================================================
--==========================================================	
-- AMENITIES 
--==========================================================
-- Civilization_JFD_ClassNames
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_ClassNames (
	CivilizationType  		text 		REFERENCES Civilizations(Type) 		default null,
	ClassType  			text 							default null,
	UniqueClassName			text 		 					default null);		

INSERT INTO Civilization_JFD_ClassNames
	(CivilizationType, 			ClassType,			UniqueClassName)
VALUES	('CIVILIZATION_THP_NORTHYUAN', 		'CLASS_JFD_ELITE',		'TXT_KEY_CLASS_JFD_ELITE_NORTHYUAN'),
	('CIVILIZATION_THP_NORTHYUAN', 		'CLASS_JFD_PROFESSIONAL',	'TXT_KEY_CLASS_JFD_PROFESSIONAL_NORTHYUAN'),
	('CIVILIZATION_THP_NORTHYUAN', 		'CLASS_JFD_COMMON',		'TXT_KEY_CLASS_JFD_COMMON_NORTHYUAN');
--==========================================================	
-- COLONIES 
--==========================================================	
-- Civilization_JFD_ColonialCityNames
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_ColonialCityNames (
	CivilizationType 		text 	REFERENCES Civilizations(Type) 		default null,
	ColonyName 			text						default null,
	LinguisticType			text						default	null,
	CultureType			text						default	null);

INSERT INTO Civilization_JFD_ColonialCityNames
	(CivilizationType, 			ColonyName,		LinguisticType)
VALUES	('CIVILIZATION_THP_NORTHYUAN', 		null,			'JFD_Altaic');
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
		(LeaderType,		FlavorType,			Flavor)
VALUES	('LEADER_THP_MANDUKHAI',	'FLAVOR_JFD_DECOLONIZATION',	2);
--==========================================================	
-- PROVINCES 
--==========================================================	
-- Civilization_JFD_ProvinceTitles
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_ProvinceTitles (
	CivilizationType  			text 		REFERENCES Civilizations(Type)  default null,
	ReligionType  				text 		REFERENCES Religions(Type) 	default null, -- ignore this
	DefaultTitle				text 						default null,
	UniqueTitle				text 						default null,
	UseAdjective				boolean						default 0);	

INSERT INTO Civilization_JFD_ProvinceTitles
		(CivilizationType,	DefaultTitle, UniqueTitle, UseAdjective)
SELECT	'CIVILIZATION_THP_NORTHYUAN',	DefaultTitle, UniqueTitle, UseAdjective
FROM Civilization_JFD_ProvinceTitles WHERE CivilizationType = 'CIVILIZATION_MONGOL';
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
		(LeaderType,		FlavorType,		Flavor)
VALUES	('LEADER_THP_MANDUKHAI',	'FLAVOR_JFD_SLAVERY',	9);
--==========================================================================================================================
-- JFD's CULTURAL DIVERSITY (31a31d1c-b9d7-45e1-842c-23232d66cd47)
--==========================================================================================================================
-- Civilization_JFD_CultureTypes
-------------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes(
	CivilizationType 	text 	REFERENCES Civilizations(Type) 		default null,
	CultureType 		text						default null,
	ArtDefineTag		text						default	null,
	DefeatScreenEarlyTag	text						default	null,
	DefeatScreenMidTag	text						default	null,
	DefeatScreenLateTag	text						default	null,
	IdealsTag		text						default	null,
	SplashScreenTag		text						default	null,
	SoundtrackTag		text						default	null,
	UnitDialogueTag		text						default null);

INSERT INTO Civilization_JFD_CultureTypes
		(CivilizationType,	ArtDefineTag, CultureType, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT	'CIVILIZATION_THP_NORTHYUAN',	ArtDefineTag, CultureType, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_MONGOL';
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
		(LeaderType,		FlavorType,			Flavor)
VALUES	('LEADER_THP_MANDUKHAI',	'FLAVOR_JFD_MERCENARY',		6);
--==========================================================================================================================	
-- JFD's RISE TO POWER (eea66053-7579-481a-bb8d-2f3959b59974)
--==========================================================================================================================	
-- PIETY
--==========================================================	
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
		(LeaderType,		FlavorType,				Flavor)
VALUES	('LEADER_THP_MANDUKHAI',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',		4),
	('LEADER_THP_MANDUKHAI',	'FLAVOR_JFD_STATE_RELIGION',			4);
--==========================================================	
-- PROSPERITY
--==========================================================
-- Civilization_JFD_Currencies
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Currencies (
	CivilizationType  		text 		REFERENCES Civilizations(Type) 	default null,
	CurrencyType	  		text 		 				default null);

INSERT INTO Civilization_JFD_Currencies
		(CivilizationType,				CurrencyType)
SELECT	'CIVILIZATION_THP_NORTHYUAN',	CurrencyType
FROM Civilization_JFD_Currencies WHERE CivilizationType = 'CIVILIZATION_MONGOL';
--==========================================================	
-- INVENTIONS 
--==========================================================	
-- Civilization_JFD_Inventions
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Inventions (
	CivilizationType  		text 	REFERENCES Civilizations(Type) 				default null,
	InventionType  			text 		 						default null,
	InventionPreference		text 		 						default null);
	
INSERT INTO Civilization_JFD_Inventions
	(CivilizationType, 		InventionType, 			InventionPreference)
VALUES 	('CIVILIZATION_THP_NORTHYUAN',  'INVENTION_JFD_CURRENCY',	'CURRENCY_JFD_JIAOZI'),
	('CIVILIZATION_THP_NORTHYUAN', 	'INVENTION_JFD_DOCTRINE',	'DOCTRINE_JFD_MILITARISM'),
	('CIVILIZATION_THP_NORTHYUAN',	'INVENTION_JFD_SPORT',		'SPORT_JFD_HORSE_RACING');	
--==========================================================	
-- SOVEREIGNTY
--==========================================================
-- Civilization_JFD_Governments
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Governments (
	CivilizationType  		text 		REFERENCES Civilizations(Type) 	default null,
	CultureType	  		text 						default null,
	LegislatureName			text						default	null,
	OfficeTitle			text						default	null,
	GovernmentType			text						default	null,
	Weight				integer						default	0);

INSERT INTO Civilization_JFD_Governments
	(CivilizationType,		LegislatureName, 	OfficeTitle, 	GovernmentType, 		Weight)
SELECT	'CIVILIZATION_THP_NORTHYUAN',	LegislatureName, 	OfficeTitle, 	'GOVERNMENT_JFD_MONARCHY', 	100
FROM Civilization_JFD_Governments WHERE CivilizationType = 'CIVILIZATION_MONGOL';
------------------------------------------------------------	
-- Civilization_JFD_HeadsOfGovernment	
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 	
	Civilization_JFD_HeadsOfGovernment (	
	CivilizationType  			text 	REFERENCES Civilizations(Type) 	default null,
	CultureType				text 					default null,
	HeadOfGovernmentName			text 		 			default null);

INSERT INTO Civilization_JFD_HeadsOfGovernment
        (CivilizationType,      		HeadOfGovernmentName)
SELECT  'CIVILIZATION_THP_NORTHYUAN',		HeadOfGovernmentName
FROM Civilization_JFD_HeadsOfGovernment WHERE CivilizationType = 'CIVILIZATION_MONGOL';
------------------------------------------------------------
-- Civilization_JFD_Titles
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Titles (
	CivilizationType  		text 		REFERENCES Civilizations(Type) 	default null,
	CultureType			text 		 				default null,
	ReligionType			text 		REFERENCES Religions(Type) 	default null,
	DefaultTitle			text 		 				default null,
	UniqueTitle			text 		 				default null,
	UseAdjective			boolean						default 0);	

INSERT INTO Civilization_JFD_Titles
		(CivilizationType,		DefaultTitle,	UniqueTitle)
SELECT	'CIVILIZATION_THP_NORTHYUAN',		DefaultTitle,	UniqueTitle
FROM Civilization_JFD_Titles WHERE CivilizationType = 'CIVILIZATION_MONGOL';

INSERT OR REPLACE INTO Civilization_JFD_Titles
	(CivilizationType,		DefaultTitle,	UniqueTitle)
VALUES	('CIVILIZATION_THP_NORTHYUAN',	'TXT_KEY_GOVERNMENT_JFD_EMPIRE_TITLE_LEADER',	'TXT_KEY_GOVERNMENT_JFD_EMPIRE_TITLE_LEADER_NORTHYUAN'),
('CIVILIZATION_THP_NORTHYUAN',	'TXT_KEY_GOVERNMENT_JFD_MONARCHY_TITLE_LEADER',	'TXT_KEY_GOVERNMENT_JFD_MONARCHY_TITLE_LEADER_NORTHYUAN');
------------------------------------------------------------
-- JFD_PrivyCouncillor_UniqueNames
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	JFD_PrivyCouncillor_UniqueNames (
	PrivyCouncillorType  			text 					default null,
	PolicyType  				text 	REFERENCES Policies(Type) 	default null,
	CivilizationType			text	REFERENCES Civilizations(Type) 	default	null,
	CultureType				text					default	null,
	GovernmentType  			text 	 				default null,
	ReligionType				text	REFERENCES Religions(Type) 	default	null,
	UniqueName				text					default	null);

INSERT INTO JFD_PrivyCouncillor_UniqueNames	
		(PrivyCouncillorType,				CivilizationType,							UniqueName)
VALUES	('COUNCILLOR_JFD_CHANCELLOR',	'CIVILIZATION_THP_NORTHYUAN',	'TXT_KEY_COUNCILLOR_JFD_CHANCELLOR_DESC_THP_NORTHYUAN');
------------------------------------------------------------
-- Civilization_JFD_Politics
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Politics (
	CivilizationType  		text 		REFERENCES Civilizations(Type) 	default null,
	PoliticsType  			text 						default null,
	UniqueName			text						default	null);

INSERT INTO Civilization_JFD_Politics
	(CivilizationType,			PoliticsType, 	UniqueName)
SELECT	'CIVILIZATION_THP_NORTHYUAN',		PoliticsType,	UniqueName
FROM Civilization_JFD_Politics WHERE CivilizationType = 'CIVILIZATION_MONGOL';
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
		(LeaderType,		FlavorType,				Flavor)
VALUES	('LEADER_THP_MANDUKHAI',	'FLAVOR_JFD_REFORM_GOVERNMENT',		8),
	('LEADER_THP_MANDUKHAI',	'FLAVOR_JFD_REFORM_LEGAL',		5),
	('LEADER_THP_MANDUKHAI',	'FLAVOR_JFD_REFORM_CULTURE',		6),
	('LEADER_THP_MANDUKHAI',	'FLAVOR_JFD_REFORM_ECONOMIC',		3),
	('LEADER_THP_MANDUKHAI',	'FLAVOR_JFD_REFORM_FOREIGN',		5),
	('LEADER_THP_MANDUKHAI',	'FLAVOR_JFD_REFORM_INDUSTRY',		7),
	('LEADER_THP_MANDUKHAI',	'FLAVOR_JFD_REFORM_MILITARY',		10),
	('LEADER_THP_MANDUKHAI',	'FLAVOR_JFD_REFORM_RELIGION',		7);
--==========================================================================================================================
-- TOMATEKH'S HISTORICAL RELIGIONS COMPLETE
--==========================================================================================================================
-- Mandukhai came before the Buddhization(?) of the Mongols, so I'm sticking with Tengriism
--==========================================================================================================================
-- EVENTS AND DECISIONS
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);

INSERT INTO DecisionsAddin_Support (FileName) VALUES ('Mandukhai_Decisions.lua');
--==========================================================================================================================
-- TROLLER ADDITIONAL ACHIEVEMENTS
--==========================================================================================================================
-- AdditionalAchievements_Mods
------------------------------
CREATE TABLE IF NOT EXISTS 
	AdditionalAchievements_Mods (
	ID  				integer 	PRIMARY KEY		AUTOINCREMENT,
	Type				text					default	null,
	ModName				text					default null,
	ModID				text					default	null,	
	Authors				text					default	null);

INSERT INTO AdditionalAchievements_Mods
	(Type,		    ModName,			   ModID,			    Authors)
VALUES	('MOD_THP_NORTHYUAN', 'TXT_KEY_MOD_THP_NORTHYUAN_NAME', 'TXT_KEY_MOD_THP_NORTHYUAN_ID_STEAM', 'TXT_KEY_MOD_THP_NORTHYUAN_AUTHORS');
-------------------------
-- AdditionalAchievements
-------------------------
CREATE TABLE IF NOT EXISTS 
	AdditionalAchievements (
	ID  			integer 	PRIMARY KEY		AUTOINCREMENT,
	Type			text					default	null,
	Achievopedia		text					default null,
	Header			text					default	null,	
	IconAtlas		text					default	null,	
	PortraitIndex		integer					default	0,
	ModType			text					default	null,	
	ModVersion		integer					default	0,
	Unlocked		boolean					default	0,
	LockedIconAtlas		text					default	'CIV_COLOR_ATLAS',
	LockedPortraitIndex	integer					default	23,
	UnlockSound		text					default	'AS2D_INTERFACE_ANCIENT_RUINS',
	PopupDuration		integer					default	-1,
	Hidden			boolean					default	0,
	HiddenBorder		boolean					default	0,
	RequiredCivWin		text					default	null,
	RequiredCivLoss		text					default	null,
	RequiredCivKill		text					default	null);

INSERT INTO AdditionalAchievements
		(Type,			Header,			Achievopedia,		ModType,	ModVersion,		RequiredCivWin,				IconAtlas,		PortraitIndex)
VALUES	('AA_THP_NORTHYUAN_SPECIAL',	'TXT_KEY_AA_THP_NORTHYUAN_SPECIAL_HEADER',	'TXT_KEY_AA_THP_NORTHYUAN_SPECIAL_TEXT',	'MOD_THP_NORTHYUAN',	1,				null,				'THP_NORTHYUAN_ATLAS',	0),
		('AA_THP_NORTHYUAN_VICTORY',	'TXT_KEY_AA_THP_NORTHYUAN_VICTORY_HEADER',	'TXT_KEY_AA_THP_NORTHYUAN_VICTORY_TEXT',	'MOD_THP_NORTHYUAN',	1,				'CIVILIZATION_THP_NORTHYUAN',	'THP_NORTHYUAN_ATLAS',	0);
--==========================================================================================================================
--==========================================================================================================================