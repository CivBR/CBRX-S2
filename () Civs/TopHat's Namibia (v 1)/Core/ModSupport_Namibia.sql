--==========================================================================================================================
-- USER SETTINGS (THIS IS NEEDED IN MOST CASES)
--==========================================================================================================================
-- JFD_GlobalUserSettings
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
JFD_GlobalUserSettings (
	Type 				text 			default null,
	Value 				integer 		default 1);
--=======================================================================================================================
-- Bingle's Civ IV Traits
--=======================================================================================================================
-- Leader_SharedTraits
------------------------------
CREATE TABLE IF NOT EXISTS
Leader_SharedTraits (
LeaderType          text    REFERENCES Leaders(Type)        default null,
TraitOne            text    REFERENCES Policies(Type)       default null,
TraitTwo            text    REFERENCES Policies(Type)       default null);

INSERT OR REPLACE INTO Leader_SharedTraits
(LeaderType,                TraitOne,                  TraitTwo)
SELECT      'LEADER_THP_MORENGA',    'POLICY_INDUSTRIOUS_X',        'POLICY_PROTECTIVE_X'
WHERE EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');
------------------------------
-- Leaders
------------------------------
UPDATE Leaders
SET Description = 'Jacob Morenga [ICON_PRODUCTION][ICON_STRENGTH]'
WHERE Type = 'LEADER_THP_MORENGA'
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
SET ArtStyleSuffix = '_SONGHAI'
WHERE Type = 'CIVILIZATION_THP_NAMIBIA'
AND EXISTS (SELECT * FROM Civilizations WHERE ArtStyleSuffix = '_SONGHAI');
--==========================================================================================================================
-- GEDEMON's YNAEMP (+JFD's v23 / 24)
--==========================================================================================================================
-----------------------------------
-- Civilizations_YagemStartPosition
-----------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
	(Type,				X,	Y)
VALUES	('CIVILIZATION_THP_NAMIBIA',	26,	14);
-----------------------------------
-- Civilizations_YahemStartPosition
-----------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
	(Type,				X,	Y)
VALUES	('CIVILIZATION_THP_NAMIBIA',	66,	19);
-----------------------------------
-- Civilizations_CordiformStartPosition
-----------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
	(Type,				X,	Y)
VALUES	('CIVILIZATION_THP_NAMIBIA',	37,	5);
-----------------------------------
-- Civilizations_GreatestEarthStartPosition
-----------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
	(Type,				X,	Y)
VALUES	('CIVILIZATION_THP_NAMIBIA',	54,	8);
-----------------------------------
-- Civilizations_AfricaLargeStartPosition
-----------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_AfricaLargeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AfricaLargeStartPosition
	(Type,				X,	Y)
VALUES	('CIVILIZATION_THP_NAMIBIA',	32,	14);
-----------------------------------
-- Civilizations_AfriAsiaAustStartPosition
-----------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_AfriAsiaAustStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AfriAsiaAustStartPosition
	(Type,				X,	Y)
VALUES	('CIVILIZATION_THP_NAMIBIA',	31,	17);
-----------------------------------
-- Civilizations_AfriSouthEuroStartPosition
-----------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_AfriSouthEuroStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AfriSouthEuroStartPosition
	(Type,				X,	Y)
VALUES	('CIVILIZATION_THP_NAMIBIA',	39,	12);
-----------------------------------
-- Civilizations_AfriGiantStartPosition
-----------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_AfriGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AfriGiantStartPosition
	(Type,				X,	Y)
VALUES	('CIVILIZATION_THP_NAMIBIA',	69,	24);
-----------------------------------
-- Civilizations_EarthMk3StartPosition
-----------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_EarthMk3StartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EarthMk3StartPosition
	(Type,				X,	Y)
VALUES	('CIVILIZATION_THP_NAMIBIA',	27,	15);
-----------------------------------
-- Civilizations_SouthernAfricaStartPosition
-----------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_SouthernAfricaStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_SouthernAfricaStartPosition
	(Type,				X,	Y)
VALUES	('CIVILIZATION_THP_NAMIBIA',	54,	45);
-------------------------------------
-- Civilizations_YagemRequestedResource (Earth Giant)
-------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource
	(Type, 				Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_THP_NAMIBIA',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE Type = 'CIVILIZATION_MOROCCO';
--==========================================================================================================================
-- JFD's CITIES IN DEVELOPMENT
--==========================================================================================================================
--==========================================================	
-- COLONIES 
--==========================================================	
-- Civilization_JFD_ColonialCityNames
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_ColonialCityNames (
	CivilizationType 			text 	REFERENCES Civilizations(Type) 		default null,
	ColonyName 				text						default null,
	LinguisticType				text						default	null,
	CultureType				text						default	null);
	
INSERT INTO Civilization_JFD_ColonialCityNames
	(CivilizationType, 			ColonyName,		LinguisticType)
VALUES	('CIVILIZATION_THP_NAMIBIA', 		null,			'JFD_Bantu');
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
VALUES	('LEADER_THP_MORENGA',		'FLAVOR_JFD_DECOLONIZATION',	10);
--==========================================================	
-- PROVINCES 
--==========================================================	
-- Civilization_JFD_ProvinceTitles
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_ProvinceTitles (
	CivilizationType  		text 		REFERENCES Civilizations(Type) 		default null,
	ReligionType  			text 		REFERENCES Religions(Type)		default null, -- ignore this
	DefaultTitle			text 							default null,
	UniqueTitle			text 		 					default null,
	UseAdjective			boolean							default 0);

INSERT INTO Civilization_JFD_ProvinceTitles
	(CivilizationType,		DefaultTitle, UniqueTitle, UseAdjective)
SELECT	'CIVILIZATION_THP_NAMIBIA',	DefaultTitle, UniqueTitle, UseAdjective
FROM Civilization_JFD_ProvinceTitles WHERE CivilizationType = 'CIVILIZATION_GERMANY';	
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
		(LeaderType,		FlavorType,			Flavor)
VALUES	('LEADER_THP_MORENGA',		'FLAVOR_JFD_SLAVERY',		3);
--==========================================================================================================================
-- JFD's CULTURAL DIVERSITY
--==========================================================================================================================
-- Civilization_JFD_CultureTypes
-------------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes(
	CivilizationType 			text 	REFERENCES Civilizations(Type) 			default null,
	CultureType 				text							default null,
	ArtDefineTag				text							default	null,
	DefeatScreenEarlyTag			text							default	null,
	DefeatScreenMidTag			text							default	null,
	DefeatScreenLateTag			text							default	null,
	IdealsTag				text							default	null,
	SplashScreenTag				text							default	null,
	SoundtrackTag				text							default	null,
	UnitDialogueTag				text							default null);

INSERT INTO Civilization_JFD_CultureTypes
		(CivilizationType,	ArtDefineTag, CultureType, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT	'CIVILIZATION_THP_NAMIBIA',	ArtDefineTag, CultureType, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_ZULU';
--==========================================================================================================================
-- JFD's EXPLORATION CONTINUED EXPANDED
--==========================================================================================================================
INSERT INTO Unit_FreePromotions
		(UnitType, 		PromotionType)
SELECT	'UNIT_THP_OXRIDER',		'PROMOTION_JFD_DESERT_IMMUNITY'
WHERE EXISTS (SELECT Type FROM UnitPromotions WHERE Type = 'PROMOTION_JFD_DESERT_IMMUNITY');
--==========================================================================================================================	
-- JFD's AND POUAKAI's MERCENARIES
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
VALUES	('LEADER_THP_MORENGA',		'FLAVOR_JFD_MERCENARY',		6);
--==========================================================================================================================	
-- JFD's RISE TO POWER
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
VALUES	('LEADER_THP_MORENGA',		'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',	1),
	('LEADER_THP_MORENGA',		'FLAVOR_JFD_STATE_RELIGION',		2);
--==========================================================	
-- PROSPERITY
--==========================================================
-- Civilization_JFD_Currencies
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Currencies (
	CivilizationType  		text 		REFERENCES Civilizations(Type) 	default null,
	CurrencyType	  		text 						default null);

INSERT INTO Civilization_JFD_Currencies
	(CivilizationType,		CurrencyType)
SELECT	'CIVILIZATION_THP_NAMIBIA',	CurrencyType
FROM Civilization_JFD_Currencies WHERE CivilizationType = 'CIVILIZATION_ZULU';
--==========================================================	
-- INVENTIONS 
--==========================================================	
-- Civilization_JFD_Inventions
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Inventions (
	CivilizationType  		text 	REFERENCES Civilizations(Type) 		default null,
	InventionType  			text 		 				default null,
	InventionPreference		text 		 				default null);
	
INSERT INTO Civilization_JFD_Inventions
		(CivilizationType, 	 InventionType, 		 InventionPreference)
VALUES 	('CIVILIZATION_THP_NAMIBIA', 	'INVENTION_JFD_WRITING',	'WRITING_JFD_LATIN'),
	('CIVILIZATION_THP_NAMIBIA', 	'INVENTION_JFD_DOCTRINE',	'DOCTRINE_JFD_COMMUNISM');	
--==========================================================	
-- SOVEREIGNTY
--==========================================================
-- Civilization_JFD_Governments
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Governments (
	CivilizationType  		text 		REFERENCES Civilizations(Type) 		default null,
	CultureType	  		text 							default null,
	LegislatureName			text							default	null,
	OfficeTitle			text							default	null,
	GovernmentType			text							default	null,
	Weight				integer							default	0);

INSERT INTO Civilization_JFD_Governments
		(CivilizationType,	LegislatureName, 										 OfficeTitle, 									GovernmentType, 		Weight)
VALUES	('CIVILIZATION_THP_NAMIBIA',	'TXT_KEY_JFD_LEGISLATURE_NAME_CIVILIZATION_THP_NAMIBIA', 	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_THP_NAMIBIA', 	'GOVERNMENT_JFD_REPUBLIC', 	100);
------------------------------------------------------------	
-- Civilization_JFD_HeadsOfGovernment	
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 	
	Civilization_JFD_HeadsOfGovernment (	
	CivilizationType  			text 		REFERENCES Civilizations(Type)		default null,
	CultureType				text							default null,
	HeadOfGovernmentName			text 							default null);

INSERT INTO Civilization_JFD_HeadsOfGovernment
        (CivilizationType,      		HeadOfGovernmentName)
VALUES  ('CIVILIZATION_THP_NAMIBIA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_THP_NAMIBIA_1'),
	('CIVILIZATION_THP_NAMIBIA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_THP_NAMIBIA_2'),
	('CIVILIZATION_THP_NAMIBIA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_THP_NAMIBIA_3'),
	('CIVILIZATION_THP_NAMIBIA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_THP_NAMIBIA_4'),	('CIVILIZATION_THP_NAMIBIA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_THP_NAMIBIA_5'),	('CIVILIZATION_THP_NAMIBIA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_THP_NAMIBIA_6'),	('CIVILIZATION_THP_NAMIBIA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_THP_NAMIBIA_7'),	('CIVILIZATION_THP_NAMIBIA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_THP_NAMIBIA_8'),	('CIVILIZATION_THP_NAMIBIA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_THP_NAMIBIA_9'),	('CIVILIZATION_THP_NAMIBIA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_THP_NAMIBIA_10'),	('CIVILIZATION_THP_NAMIBIA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_THP_NAMIBIA_11'),	('CIVILIZATION_THP_NAMIBIA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_THP_NAMIBIA_12'),	('CIVILIZATION_THP_NAMIBIA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_THP_NAMIBIA_13'),
	('CIVILIZATION_THP_NAMIBIA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_THP_NAMIBIA_14'),
	('CIVILIZATION_THP_NAMIBIA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_THP_NAMIBIA_15'),
	('CIVILIZATION_THP_NAMIBIA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_THP_NAMIBIA_16'),
	('CIVILIZATION_THP_NAMIBIA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_THP_NAMIBIA_17'),
	('CIVILIZATION_THP_NAMIBIA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_THP_NAMIBIA_18'),
	('CIVILIZATION_THP_NAMIBIA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_THP_NAMIBIA_19'),
	('CIVILIZATION_THP_NAMIBIA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_THP_NAMIBIA_20'),
	('CIVILIZATION_THP_NAMIBIA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_THP_NAMIBIA_21'),
	('CIVILIZATION_THP_NAMIBIA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_THP_NAMIBIA_22'),
	('CIVILIZATION_THP_NAMIBIA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_THP_NAMIBIA_23'),
	('CIVILIZATION_THP_NAMIBIA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_THP_NAMIBIA_24'),
	('CIVILIZATION_THP_NAMIBIA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_THP_NAMIBIA_25');
------------------------------------------------------------
-- Civilization_JFD_Politics
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Politics (
	CivilizationType  		text 		REFERENCES Civilizations(Type) 		default null,
	PoliticsType  			text 							default null,
	UniqueName			text							default	null);

INSERT INTO Civilization_JFD_Politics
		(CivilizationType,		PoliticsType, 		UniqueName)
VALUES	('CIVILIZATION_THP_NAMIBIA',		'PARTY_JFD_CONSERVATIVE',	'TXT_KEY_JFD_PARTY_THP_NAMIBIA_CONSERVATIVE'),
	('CIVILIZATION_THP_NAMIBIA',		'PARTY_JFD_LIBERAL',		'TXT_KEY_JFD_PARTY_THP_NAMIBIA_LIBERAL'),
	('CIVILIZATION_THP_NAMIBIA',		'PARTY_JFD_SOCIALIST',		'TXT_KEY_JFD_PARTY_THP_NAMIBIA_SOCIALIST');
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
VALUES		('LEADER_THP_MORENGA',	'FLAVOR_JFD_REFORM_GOVERNMENT',		2),
		('LEADER_THP_MORENGA',	'FLAVOR_JFD_REFORM_LEGAL',		4),
		('LEADER_THP_MORENGA',	'FLAVOR_JFD_REFORM_CULTURE',		7),
		('LEADER_THP_MORENGA',	'FLAVOR_JFD_REFORM_ECONOMIC',		5),
		('LEADER_THP_MORENGA',	'FLAVOR_JFD_REFORM_FOREIGN',		6),
		('LEADER_THP_MORENGA',	'FLAVOR_JFD_REFORM_INDUSTRY',		3),
		('LEADER_THP_MORENGA',	'FLAVOR_JFD_REFORM_MILITARY',		8),
		('LEADER_THP_MORENGA',	'FLAVOR_JFD_REFORM_RELIGION',		4);
--=======================================================================================================================
-- TOMATEKH'S HISTORICAL RELIGIONS COMPLETE
--=======================================================================================================================
-- Protestantism becomes Lutheranism by default, so there's no need to implement this
--========================================================================================================================
-- TROLLER ADDITIONAL ACHIEVEMENTS
--========================================================================================================================
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
	(Type,			ModName,			ModID,				Authors)
VALUES	('MOD_THP_NAMIBIA', 'TXT_KEY_MOD_THP_NAMIBIA_NAME', 'TXT_KEY_MOD_THP_NAMIBIA_ID_STEAM', 'TXT_KEY_MOD_THP_NAMIBIA_AUTHORS');
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
VALUES	('AA_THP_NAMIBIA_SPECIAL',	'TXT_KEY_AA_THP_NAMIBIA_SPECIAL_HEADER',	'TXT_KEY_AA_THP_NAMIBIA_SPECIAL_TEXT',	'MOD_THP_NAMIBIA',	5,				null,					'THP_NAMIBIA_ATLAS',	0),
		('AA_THP_NAMIBIA_VICTORY',	'TXT_KEY_AA_THP_NAMIBIA_VICTORY_HEADER',	'TXT_KEY_AA_THP_NAMIBIA_VICTORY_TEXT',	'MOD_THP_NAMIBIA',	5,				'CIVILIZATION_THP_NAMIBIA',	 'THP_NAMIBIA_ATLAS',	0);
--========================================================================================================================
-- EVENTS AND DECISIONS
--========================================================================================================================
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);

INSERT INTO DecisionsAddin_Support (FileName) VALUES ('Namibia_Decisions.lua');

-----------
-- Policies
-----------
INSERT INTO Policies
	(Type,						Description)
VALUES	('POLICY_DECISIONS_THP_NAMIBIA_LANDREFORM',	'TXT_KEY_DECISIONS_THP_NAMIBIA_LANDREFORM_ENACTED_DESC'),
	('POLICY_DECISIONS_THP_NAMIBIA_CAPRIVI',	'TXT_KEY_DECISIONS_THP_NAMIBIA_CAPRIVI_ENACTED_DESC');
-----------------------------------
-- Policy_ImprovementCultureChanges
-----------------------------------
INSERT INTO Policy_ImprovementCultureChanges
	(PolicyType,					ImprovementType,	CultureChange)
VALUES	('POLICY_DECISIONS_THP_NAMIBIA_LANDREFORM',	'IMPROVEMENT_FARM',	1);
--------------------------------
-- Policy_BuildingClassHappiness
--------------------------------
INSERT INTO Policy_BuildingClassHappiness
	(PolicyType,					BuildingClassType,		Happiness)
VALUES	('POLICY_DECISIONS_THP_NAMIBIA_CAPRIVI',	'BUILDINGCLASS_COURTHOUSE',	3);

--==========================================================================================================================		
--==========================================================================================================================		
