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
            (LeaderType,		TraitOne,			TraitTwo)
SELECT      'LEADER_THP_SIAD_BARRE',	'POLICY_FINANCIAL_X',		'POLICY_SEAFARING_X'
WHERE EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');
------------------------------	
-- Leaders
------------------------------	
UPDATE Leaders 
SET Description = 'Mohamed Siad Barre [ICON_GOLD][ICON_GREAT_EXPLORER]'
WHERE Type = 'LEADER_THP_SIAD_BARRE'
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
SET ArtStyleSuffix = '_ETHIOPIA'
WHERE Type = 'CIVILIZATION_THP_SOMALIA'
AND EXISTS (SELECT * FROM Civilizations WHERE ArtStyleSuffix = '_ETHIOPIA');
--==========================================================================================================================
-- GEDEMON's YNAEMP (+JFD's v23-25)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_YnAEMP(CivilizationType, MapPrefix, X, Y, CapitalName, AltX, AltY, AltCapitalName);
CREATE TABLE IF NOT EXISTS MinorCivilizations_YnAEMP(CivilizationType, MapPrefix, X, Y, CapitalName, AltX, AltY, AltCapitalName);

INSERT INTO Civilizations_YnAEMP
	(CivilizationType,		MapPrefix,	X, Y, CapitalName, AltX, AltY, AltCapitalName)
SELECT	'CIVILIZATION_THP_SOMALIA',	MapPrefix,	X, Y, CapitalName, AltX, AltY, AltCapitalName
FROM MinorCivilizations_YnAEMP WHERE CivilizationType = 'MINOR_CIV_MOGADISHU';

DELETE FROM MinorCivilizations_YnAEMP WHERE CivilizationType IN ('MINOR_CIV_MOGADISHU');

-- Credit to DarthKyofu for finding the TSLs for Aden
INSERT INTO MinorCivilizations_YnAEMP
	(MinorCivType,	MapPrefix,		X,	Y)
VALUES	('MINOR_CIV_MOGADISHU',	'AfriAsiaAust',		60,	28),
	('MINOR_CIV_MOGADISHU',	'AfriGiant',		51,	15),
	('MINOR_CIV_MOGADISHU',	'AfriSouthEuro',	18,	53),
	('MINOR_CIV_MOGADISHU',	'Yagem',		40,	37),
	('MINOR_CIV_MOGADISHU',	'Yahem',		77,	39),
	('MINOR_CIV_MOGADISHU',	'GreatestEarth',	67,	30),
	('MINOR_CIV_MOGADISHU',	'Cordiform',		51,	14),
	('MINOR_CIV_MOGADISHU',	'IndianOcean',		18,	53),
	('MINOR_CIV_MOGADISHU',	'MediterraneanHuge',	125,	17),
	('MINOR_CIV_MOGADISHU',	'EarthMk3',		43,	35);
-----------------------------------------
-- Civilizations_YnAEMPRequestedResources
-----------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_YnAEMPRequestedResources(CivilizationType, MapPrefix, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YnAEMPRequestedResources
	(CivilizationType, 	 	MapPrefix, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_THP_SOMALIA',	MapPrefix, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_ETHIOPIA';
--==========================================================================================================================
-- HAZEL MAP LABELS
--==========================================================================================================================
-- ML_CivCultures
------------------------------	
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
	(CivType,			CultureType, CultureEra)
SELECT	'CIVILIZATION_THP_SOMALIA',	CultureType, CultureEra
FROM ML_CivCultures WHERE CivType = 'CIVILIZATION_ARABIA';
--==========================================================================================================================
-- JFDLC
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- CIVILOPEDIA
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS JFD_Civilopedia_HideFromPedia(Type);
INSERT INTO JFD_Civilopedia_HideFromPedia
		(Type)
VALUES	('BUILDING_THP_SOMALIA_TRADE_MARKER'),
	('BUILDING_THP_SOMALIA_ROUTE_SLOT');

UPDATE Civilizations
SET DerivativeCiv = 'CIVILIZATION_THP_SOMALIA'
WHERE Type = 'CIVILIZATION_BOB_SOMALIA' AND EXISTS (SELECT * FROM Civilizations WHERE Type = 'CIVILIZATION_BOB_SOMALIA');
--------------------------------------------------------------------------------------------------------------------------
-- LEADER FLAVOURS
--------------------------------------------------------------------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_DECOLONIZATION'),
	('FLAVOR_JFD_MERCENARY'),
	('FLAVOR_JFD_REFORM_GOVERNMENT'),
	('FLAVOR_JFD_REFORM_LEGAL'),
	('FLAVOR_JFD_REFORM_CULTURE'),
	('FLAVOR_JFD_REFORM_ECONOMIC'),
	('FLAVOR_JFD_REFORM_EDUCATION'),
	('FLAVOR_JFD_REFORM_FOREIGN'),
	('FLAVOR_JFD_REFORM_INDUSTRY'),
	('FLAVOR_JFD_REFORM_MILITARY'),
	('FLAVOR_JFD_REFORM_RELIGION'),
	('FLAVOR_JFD_RELIGIOUS_INTOLERANCE'),
	('FLAVOR_JFD_SLAVERY'),
	('FLAVOR_JFD_STATE_RELIGION');

INSERT INTO Leader_Flavors
	(LeaderType,			FlavorType,				 Flavor)
VALUES	('LEADER_THP_SIAD_BARRE',	'FLAVOR_JFD_DECOLONIZATION',		 7),
	('LEADER_THP_SIAD_BARRE',	'FLAVOR_JFD_MERCENARY',			 8),
	('LEADER_THP_SIAD_BARRE',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',	 6),
	('LEADER_THP_SIAD_BARRE',	'FLAVOR_JFD_REFORM_GOVERNMENT',		 7), --Scale of Liberal to Authoritarian.
	('LEADER_THP_SIAD_BARRE',	'FLAVOR_JFD_REFORM_LEGAL',		 9), 	
	('LEADER_THP_SIAD_BARRE',	'FLAVOR_JFD_REFORM_CULTURE',		 8),
	('LEADER_THP_SIAD_BARRE',	'FLAVOR_JFD_REFORM_ECONOMIC',		 2),
	('LEADER_THP_SIAD_BARRE',	'FLAVOR_JFD_REFORM_EDUCATION',	 	 3),
	('LEADER_THP_SIAD_BARRE',	'FLAVOR_JFD_REFORM_FOREIGN',		 7),
	('LEADER_THP_SIAD_BARRE',	'FLAVOR_JFD_REFORM_INDUSTRY',		 2),
	('LEADER_THP_SIAD_BARRE',	'FLAVOR_JFD_REFORM_MILITARY',		 8),
	('LEADER_THP_SIAD_BARRE',	'FLAVOR_JFD_REFORM_RELIGION',		 6),
	('LEADER_THP_SIAD_BARRE',	'FLAVOR_JFD_SLAVERY',			 6),
	('LEADER_THP_SIAD_BARRE',	'FLAVOR_JFD_STATE_RELIGION',		 2);
--------------------------------------------------------------------------------------------------------------------------
-- JFD'S CULTURAL DIVERSITY (31a31d1c-b9d7-45e1-842c-23232d66cd47)
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes(
	CivilizationType 		text 			default null,
	CultureType 			text			default null,
	SubCultureType 			text			default null,
	ArtDefineTag			text			default	null,
	DecisionsTag			text			default null,
	DefeatScreenEarlyTag		text			default	null,
	DefeatScreenMidTag		text			default	null,
	DefeatScreenLateTag		text			default	null,
	IdealsTag			text			default	null,
	SplashScreenTag			text			default	null,
	SoundtrackTag			text			default	null,
	UnitDialogueTag			text			default null);

INSERT INTO Civilization_JFD_CultureTypes
	(CivilizationType,		ArtDefineTag, CultureType, SubCultureType, DecisionsTag, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT	'CIVILIZATION_THP_SOMALIA',	'JFD_Bantu',  CultureType, SubCultureType, DecisionsTag, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_ARABIA';

UPDATE Civilizations 
SET SoundtrackTag = 'JFD_Islamic'
WHERE Type = 'CIVILIZATION_THP_SOMALIA'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Islamic');
--==========================================================================================================================
-- TOMATEKH'S HISTORICAL RELIGIONS COMPLETE
--==========================================================================================================================
-- N/A: Islam defaults to Sunni with HR
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
VALUES	('MOD_THP_SOMALIA', 'TXT_KEY_MOD_THP_SOMALIA_NAME', 'TXT_KEY_MOD_THP_SOMALIA_ID_STEAM', 'TXT_KEY_MOD_THP_SOMALIA_AUTHORS');
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
VALUES	('AA_THP_SOMALIA_SPECIAL',	'TXT_KEY_AA_THP_SOMALIA_SPECIAL_HEADER',	'TXT_KEY_AA_THP_SOMALIA_SPECIAL_TEXT',	'MOD_THP_SOMALIA',	1,				null,				'THP_SOMALIA_ATLAS',	0),
		('AA_THP_SOMALIA_VICTORY',	'TXT_KEY_AA_THP_SOMALIA_VICTORY_HEADER',	'TXT_KEY_AA_THP_SOMALIA_VICTORY_TEXT',	'MOD_THP_SOMALIA',	1,				'CIVILIZATION_THP_SOMALIA',	'THP_SOMALIA_ATLAS',	0);
--==========================================================================================================================
--==========================================================================================================================