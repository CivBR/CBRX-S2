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
            (LeaderType,				TraitOne,                  TraitTwo)
SELECT      'LEADER_THP_TJILPI',	'POLICY_EXPANSIVE_X',		'POLICY_SPIRITUAL_X'
WHERE EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');
------------------------------	
-- Leaders
------------------------------	
UPDATE Leaders 
SET Description = 'Tjilpi [ICON_FOOD][ICON_PEACE]'
WHERE Type = 'LEADER_THP_TJILPI'
AND EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');
--==========================================================================================================================
-- GAZEBO COMMUNITY PATCH
--==========================================================================================================================
-- COMMUNITY
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS COMMUNITY (Type TEXT, Value INTEGER);
--==========================================================================================================================
-- GEDEMON's YNAEMP (+JFD's v23 / 24)
--==========================================================================================================================
/*
v25
    Australia (Australia_Large.Civ5Map)
    EarthMk3 (Earth_Mk3_Giant.Civ5Map)
*/

-----------------------------------
-- Civilizations_YagemStartPosition
-----------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
	(Type,				X,		Y)
VALUES	('CIVILIZATION_THP_ANANGU',	93,		16);
-----------------------------------
-- Civilizations_YahemStartPosition
-----------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
	(Type,				X,		Y)
VALUES	('CIVILIZATION_THP_ANANGU',	113,		16);
-----------------------------------
-- Civilizations_CordiformStartPosition
-----------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
	(Type,				X,		Y)
VALUES	('CIVILIZATION_THP_ANANGU',	73,		10);
-----------------------------------
-- Civilizations_GreatestEarthStartPosition
-----------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
	(Type,				X,		Y)
VALUES	('CIVILIZATION_THP_ANANGU',	96,		14);
-----------------------------------
-- Civilizations_PacificStartPosition
-----------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_PacificStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_PacificStartPosition
	(Type,				X,		Y)
VALUES	('CIVILIZATION_THP_ANANGU',	41,		12);
-----------------------------------
-- Civilizations_AfriAsiaAustStartPosition
-----------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_AfriAsiaAustStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AfriAsiaAustStartPosition
	(Type,				X,		Y)
VALUES	('CIVILIZATION_THP_ANANGU',	113,		14);
-----------------------------------
-- Civilizations_AustralasiaStartPosition
-----------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_AustralasiaStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AustralasiaStartPosition
	(Type,				X,		Y)
VALUES	('CIVILIZATION_THP_ANANGU',	51,		39);
-----------------------------------
-- Civilizations_IndianOceanStartPosition
-----------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_IndianOceanStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_IndianOceanStartPosition
	(Type,				X,		Y)
VALUES	('CIVILIZATION_THP_ANANGU',	93,		11);
-----------------------------------
-- Civilizations_SouthPacificGiantStartPosition
-----------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_SouthPacificGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_SouthPacificGiantStartPosition
	(Type,				X,		Y)
VALUES	('CIVILIZATION_THP_ANANGU',	2,		32);
-----------------------------------
-- Civilizations_AustraliaStartPosition
-----------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_AustraliaStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AustraliaStartPosition
	(Type,				X,		Y)
VALUES	('CIVILIZATION_THP_ANANGU',	38,		44);
-----------------------------------
-- Civilizations_EarthMk3StartPosition
-----------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_EarthMk3StartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EarthMk3StartPosition
	(Type,				X,		Y)
VALUES	('CIVILIZATION_THP_ANANGU',	99,		17);
-------------------------------------
-- Civilizations_YagemRequestedResource (Earth Giant)
-------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource
		(Type, 			Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_THP_ANANGU',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE Type = 'CIVILIZATION_INDONESIA';
--==========================================================================================================================
-- JFD's CITIES IN DEVELOPMENT (10e9728f-d61c-4317-be4f-7d52d6bae6f4)
--==========================================================================================================================
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
		(CivilizationType, 		ColonyName,		LinguisticType)
VALUES	('CIVILIZATION_THP_ANANGU', 		null,			'JFD_Austronesian');
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
VALUES	('LEADER_THP_TJILPI',	'FLAVOR_JFD_DECOLONIZATION',	10);
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
SELECT	'CIVILIZATION_THP_ANANGU',	DefaultTitle, UniqueTitle, UseAdjective
FROM Civilization_JFD_ProvinceTitles WHERE CivilizationType = 'CIVILIZATION_POLYNESIA';
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
VALUES	('LEADER_THP_TJILPI',	'FLAVOR_JFD_SLAVERY',		3);
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
	(CivilizationType,		ArtDefineTag,  CultureType, 		IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT	'CIVILIZATION_THP_ANANGU',	ArtDefineTag, 'CULTURE_JFD_ABORIGINAL', 'JFD_Aboriginal', 'JFD_Aboriginal', 'JFD_Aboriginal', UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_POLYNESIA';
--==========================================================================================================================
-- JFD's EXPLORATION CONTINUED EXPANDED (6676902b-b907-45f1-8db5-32dcb2135eee)
--==========================================================================================================================
INSERT INTO Unit_FreePromotions
		(UnitType, 		PromotionType)
SELECT	'UNIT_THP_WARMALA',		'PROMOTION_JFD_DESERT_IMMUNITY'
WHERE EXISTS (SELECT Type FROM UnitPromotions WHERE Type = 'PROMOTION_JFD_DESERT_IMMUNITY');
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
VALUES	('LEADER_THP_TJILPI',		'FLAVOR_JFD_MERCENARY',		4);
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
		(LeaderType,	FlavorType,				Flavor)
VALUES	('LEADER_THP_TJILPI',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',	3),
	('LEADER_THP_TJILPI',	'FLAVOR_JFD_STATE_RELIGION',		7);
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
		(CivilizationType,	CurrencyType)
SELECT	'CIVILIZATION_THP_ANANGU',	CurrencyType
FROM Civilization_JFD_Currencies WHERE CivilizationType = 'CIVILIZATION_POLYNESIA';
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
		(CivilizationType, 	InventionType, 			InventionPreference)
VALUES 	('CIVILIZATION_THP_ANANGU', 	'INVENTION_JFD_DOCTRINE',	'DOCTRINE_JFD_ENVIRONMENTALISM');	
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
SELECT	'CIVILIZATION_THP_ANANGU',	LegislatureName, 	OfficeTitle, 	'GOVERNMENT_JFD_THEOCRACY', 	80
FROM Civilization_JFD_Governments WHERE CivilizationType = 'CIVILIZATION_POLYNESIA';
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
	(LeaderType,			FlavorType,				Flavor)
VALUES	('LEADER_THP_TJILPI',		'FLAVOR_JFD_REFORM_GOVERNMENT',		2),
		('LEADER_THP_TJILPI',	'FLAVOR_JFD_REFORM_LEGAL',		7),
		('LEADER_THP_TJILPI',	'FLAVOR_JFD_REFORM_CULTURE',		5),
		('LEADER_THP_TJILPI',	'FLAVOR_JFD_REFORM_ECONOMIC',		2),
		('LEADER_THP_TJILPI',	'FLAVOR_JFD_REFORM_FOREIGN',		9),
		('LEADER_THP_TJILPI',	'FLAVOR_JFD_REFORM_INDUSTRY',		4),
		('LEADER_THP_TJILPI',	'FLAVOR_JFD_REFORM_MILITARY',		2),
		('LEADER_THP_TJILPI',	'FLAVOR_JFD_REFORM_RELIGION',		8);

--==========================================================================================================================
-- TOMATEKH'S HISTORICAL RELIGIONS COMPLETE
--==========================================================================================================================

--==========================================================================================================================
-- EVENTS AND DECISIONS
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);

INSERT INTO DecisionsAddin_Support (FileName) VALUES ('Anangu_Decisions.lua');
------------------
-- BuildingClasses
------------------
INSERT INTO BuildingClasses
	(Type,					DefaultBuilding,		Description)
VALUES	('BUILDINGCLASS_THP_ANANGU_ULURU',	'BUILDING_THP_ANANGU_ULURU',	'TXT_KEY_DECISIONS_THP_ANANGU_ULURU');
------------
-- Buildings
------------
INSERT INTO Buildings
(Type,                                  BuildingClass,				SpecialistCount, GreatWorkCount, Cost, FaithCost,         Description,                         Help,                                  			NeverCapture)
VALUES    ('BUILDING_THP_ANANGU_ULURU',	'BUILDINGCLASS_THP_ANANGU_ULURU',	0,               -1,             -1,   -1,               'TXT_KEY_DECISIONS_THP_ANANGU_ULURU',    'TXT_KEY_DECISIONS_THP_ANANGU_ULURU_ENACTED_DESC',	1);
-------------------------------
-- Building_TerrainYieldChanges
-------------------------------
INSERT INTO Building_TerrainYieldChanges
	(BuildingType,			TerrainType,		YieldType,		Yield)
VALUES	('BUILDING_THP_ANANGU_ULURU',	'TERRAIN_MOUNTAIN',	'YIELD_CULTURE',	1),
	('BUILDING_THP_ANANGU_ULURU',	'TERRAIN_MOUNTAIN',	'YIELD_FAITH',		1);
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
VALUES	('MOD_THP_ANANGU', 'TXT_KEY_MOD_THP_ANANGU_NAME', 'TXT_KEY_MOD_THP_ANANGU_ID_STEAM', 'TXT_KEY_MOD_THP_ANANGU_AUTHORS');
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
VALUES	('AA_THP_ANANGU_SPECIAL',	'TXT_KEY_AA_THP_ANANGU_SPECIAL_HEADER',	'TXT_KEY_AA_THP_ANANGU_SPECIAL_TEXT',	'MOD_THP_ANANGU',	1,				null,				'THP_ANANGU_ATLAS',	0),
		('AA_THP_ANANGU_VICTORY',	'TXT_KEY_AA_THP_ANANGU_VICTORY_HEADER',	'TXT_KEY_AA_THP_ANANGU_VICTORY_TEXT',	'MOD_THP_ANANGU',	1,				'CIVILIZATION_THP_ANANGU',	'THP_ANANGU_ATLAS',	0);
--==========================================================================================================================
--==========================================================================================================================