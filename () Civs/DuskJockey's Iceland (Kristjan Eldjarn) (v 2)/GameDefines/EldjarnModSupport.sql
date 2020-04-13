--==========================================================================================================================
-- MASTER TABLES
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
--Below are the tables required for standard mod support.

CREATE TABLE IF NOT EXISTS COMMUNITY (Type TEXT, Value INTEGER);
CREATE TABLE IF NOT EXISTS Civilization_JFD_ColonialCityNames(CivilizationType text, ColonyName text, LinguisticType text);
CREATE TABLE IF NOT EXISTS Civilization_JFD_Governments(CivilizationType text, CultureType text, LegislatureName text, OfficeTitle text, GovernmentType text, Weight integer);
CREATE TABLE IF NOT EXISTS Civilizations_YnAEMP(CivilizationType, MapPrefix, X, Y, CapitalName, AltX, AltY, AltCapitalName);
CREATE TABLE IF NOT EXISTS Civilizations_YnAEMPRequestedResources(CivilizationType, MapPrefix, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4, Req5, Yield5, Req6, Yield6);
CREATE TABLE IF NOT EXISTS MinorCivilizations_YnAEMP(MinorCivType, MapPrefix, X, Y, CapitalName, AltX, AltY, AltCapitalName);
CREATE TABLE IF NOT EXISTS JFD_Civilopedia_HideFromPedia(Type text);
CREATE TABLE IF NOT EXISTS JFD_GlobalUserSettings(Type text, Value integer default 1);
--------------------------------------------------------------------------------------------------------------------------
--==========================================================================================================================
-- GEDEMON's YNAEMP (+JFD's v23 / 24 / 25)
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Civilizations_YnAEMP
		(CivilizationType,			MapPrefix,	 			X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_DJ_ICELAND',	'AtlanticGiant',		129,	89,		null,	null),
		('CIVILIZATION_DJ_ICELAND',	'EarthMk3',				2,		89,		null,	null),
		('CIVILIZATION_DJ_ICELAND',	'EuroGiant',			3,		114,	null,	null),
		('CIVILIZATION_DJ_ICELAND',	'EuroLargeNew',			3,		70,		null,	null),
		('CIVILIZATION_DJ_ICELAND',	'GreatestEarth',		31,		62,		null,	null),
		('CIVILIZATION_DJ_ICELAND',	'NorthAtlantic',		61,		49,		null,	null),
		('CIVILIZATION_DJ_ICELAND',	'NorthWestEurope',		2,		60,		null,	null);
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_YagemRequestedResource
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Civilizations_YnAEMPRequestedResources
		(CivilizationType, 			MapPrefix, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_DJ_ICELAND',	MapPrefix, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_DENMARK';
--==========================================================================================================================
-- JFDLC
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- CIVILOPEDIA
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO JFD_Civilopedia_HideFromPedia
		(Type)
VALUES	('IMPROVEMENT_DJ_ICELAND_FISHING_BOATS'),
		('IMPROVEMENT_DJ_ICELAND_OFFSHORE_PLATFORM'),
		('BUILDING_DJ_ICELAND_CULTURE'),
		('UNIT_DJ_ICELAND_WORKBOAT');

UPDATE Civilizations
SET DerivativeCiv = 'CIVILIZATION_DJ_ICELAND'
WHERE Type = 'CIVILIZATION_JFD_ICELAND';
--------------------------------------------------------------------------------------------------------------------------
-- LEADER FLAVOURS
--------------------------------------------------------------------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_DECOLONIZATION'), --0-10. Determines likelihood for annexing a colony, where 0 means never, and 10 means as soon as possible.
		('FLAVOR_JFD_MERCENARY'), --0-10. Determines likelihood of taking out Mercenary Contracts, where 0 means never, and 10 means as soon as possible.
		('FLAVOR_JFD_REFORM_GOVERNMENT'), --0-10. Determines Reform preference; corresponding to Left>Centre>Right/Liberal to Authoritarian continuum. 1-4=Left, 5-6=Centre, 7-10=Right. For government issues.
		('FLAVOR_JFD_REFORM_LEGAL'), --same as above for legal issues. 
		('FLAVOR_JFD_REFORM_CULTURE'), --same as above for cultural issues.
		('FLAVOR_JFD_REFORM_ECONOMIC'), --same as above for economic issues. 
		('FLAVOR_JFD_REFORM_EDUCATION'), --same as above for educational issues.
		('FLAVOR_JFD_REFORM_FOREIGN'), --same as above for diplomatic/international issues.
		('FLAVOR_JFD_REFORM_INDUSTRY'), --same as above for industrial/labour issues.
		('FLAVOR_JFD_REFORM_MILITARY'), --same as above for military issues.
		('FLAVOR_JFD_REFORM_RELIGION'), --same as above for religious issues.
		('FLAVOR_JFD_RELIGIOUS_INTOLERANCE'), --0-12. Determines the diplomatic penalty/bonus with leaders of a different/same state religion
		('FLAVOR_JFD_SLAVERY'), --0-10. Determines likelihood of enslaving Cities and spending Shackles on Slave Units, where 0 means never, and 10 as much as possible.
		('FLAVOR_JFD_STATE_RELIGION'); --0-12. Determines chance to adopt a State Religion, where 0 means never. 9+ also means this leader will never secularize.

INSERT INTO Leader_Flavors
		(LeaderType,			FlavorType,								Flavor)
VALUES	('LEADER_DJ_ELDJARN',	'FLAVOR_JFD_DECOLONIZATION',			9),
		('LEADER_DJ_ELDJARN',	'FLAVOR_JFD_MERCENARY',					5),
		('LEADER_DJ_ELDJARN',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',		5),
		('LEADER_DJ_ELDJARN',	'FLAVOR_JFD_REFORM_GOVERNMENT',			8),
		('LEADER_DJ_ELDJARN',	'FLAVOR_JFD_REFORM_LEGAL',				6),
		('LEADER_DJ_ELDJARN',	'FLAVOR_JFD_REFORM_CULTURE',			7),
		('LEADER_DJ_ELDJARN',	'FLAVOR_JFD_REFORM_ECONOMIC',			6),
		('LEADER_DJ_ELDJARN',	'FLAVOR_JFD_REFORM_FOREIGN',			6),
		('LEADER_DJ_ELDJARN',	'FLAVOR_JFD_REFORM_INDUSTRY',			7),
		('LEADER_DJ_ELDJARN',	'FLAVOR_JFD_REFORM_MILITARY',			4),
		('LEADER_DJ_ELDJARN',	'FLAVOR_JFD_REFORM_RELIGION',			4),
		('LEADER_DJ_ELDJARN',	'FLAVOR_JFD_SLAVERY',					1),
		('LEADER_DJ_ELDJARN',	'FLAVOR_JFD_STATE_RELIGION',			2);
--------------------------------------------------------------------------------------------------------------------------
-- JFD'S CULTURAL DIVERSITY (31a31d1c-b9d7-45e1-842c-23232d66cd47)
--------------------------------------------------------------------------------------------------------------------------	
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
		(CivilizationType,			CultureType, SubCultureType,	ArtDefineTag,	DecisionsTag, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT	'CIVILIZATION_DJ_ICELAND',	CultureType, SubCultureType,	ArtDefineTag,	DecisionsTag, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_DENMARK';

UPDATE Civilizations 
SET SoundtrackTag = 'JFD_Northern'
WHERE Type = 'CIVILIZATION_DJ_ICELAND'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Northern');
--------------------------------------------------------------------------------------------------------------------------
-- MinorCivilization_JFD_CultureTypes
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 
MinorCivilization_JFD_CultureTypes (
	MinorCivilizationType 			text 	REFERENCES MinorCivilizations(Type) default null,
	CultureType 					text										default null);
--------------------------------------------------------------------------------------------------------------------------
-- AdditionalAchievements
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	AdditionalAchievements (
	ID					integer 	PRIMARY KEY		AUTOINCREMENT,
	Type				text					default	null,
	Achievopedia		text					default null,
	Header				text					default	null,	
	IconAtlas			text					default	null,	
	PortraitIndex		integer					default	0,
	ModType				text					default	null,	
	ModVersion			integer					default	0,
	Unlocked			boolean					default	0,
	LockedIconAtlas		text					default	'CIV_COLOR_ATLAS',
	LockedPortraitIndex	integer					default	23,
	UnlockSound			text					default	'AS2D_INTERFACE_ANCIENT_RUINS',
	PopupDuration		integer					default	-1,
	Hidden				boolean					default	0,
	HiddenBorder		boolean					default	0,
	RequiredCivWin		text					default	null,
	RequiredCivLoss		text					default	null,
	RequiredCivKill		text					default	null);

INSERT INTO AdditionalAchievements
		(Type,						Header,									Achievopedia,							ModType,			ModVersion,		RequiredCivWin,				IconAtlas,			PortraitIndex)
VALUES	('AA_DJ_ICELAND_SPECIAL',	'TXT_KEY_AA_DJ_ICELAND_SPECIAL_HEADER',	'TXT_KEY_AA_DJ_ICELAND_SPECIAL_TEXT',	'MOD_DJ_ICELAND',	1,				null,						'DJ_ICELAND_CIV_ATLAS',	0),
		('AA_DJ_ICELAND_VICTORY',	'TXT_KEY_AA_DJ_ICELAND_VICTORY_HEADER',	'TXT_KEY_AA_DJ_ICELAND_VICTORY_TEXT',	'MOD_DJ_ICELAND',	1,				'CIVILIZATION_DJ_ICELAND',	'DJ_ICELAND_CIV_ATLAS',	0);