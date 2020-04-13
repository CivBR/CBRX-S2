--==========================================================================================================================
-- MASTER TABLES
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS COMMUNITY (Type TEXT, Value INTEGER);
CREATE TABLE IF NOT EXISTS Civilization_JFD_ColonialCityNames(CivilizationType text, ColonyName text, LinguisticType text);
CREATE TABLE IF NOT EXISTS Civilization_JFD_Governments(CivilizationType text, CultureType text, LegislatureName text, OfficeTitle text, GovernmentType text, Weight integer);
CREATE TABLE IF NOT EXISTS Civilizations_YnAEMP(CivilizationType, MapPrefix, X, Y, CapitalName, AltX, AltY, AltCapitalName);
CREATE TABLE IF NOT EXISTS Civilizations_YnAEMPRequestedResources(CivilizationType, MapPrefix, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4, Req5, Yield5, Req6, Yield6);
CREATE TABLE IF NOT EXISTS JFD_Civilopedia_HideFromPedia(Type text);
CREATE TABLE IF NOT EXISTS JFD_GlobalUserSettings(Type text, Value integer default 1);
CREATE TABLE IF NOT EXISTS MinorCivilizations_YnAEMP(MinorCivType, MapPrefix, X, Y, CapitalName, AltX, AltY, AltCapitalName);
--==========================================================================================================================
-- CIVILOPEDIA
--==========================================================================================================================
------------------------------------------------------------------------------------------------------------------------
-- JFD_Civilopedia_HideFromPedia
------------------------------------------------------------------------------------------------------------------------
INSERT INTO JFD_Civilopedia_HideFromPedia
		(Type)
VALUES	('PROMOTION_JFD_TRIHEMIOLIA_INACTIVE');
--==========================================================================================================================
-- LEADERS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- Flavors
--------------------------------------------------------------------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_DECOLONIZATION'),
		('FLAVOR_JFD_MERCENARY'),
		('FLAVOR_JFD_REFORM_GOVERNMENT'),
		('FLAVOR_JFD_REFORM_LAW'),
		('FLAVOR_JFD_REFORM_DIPLOMACY'),
		('FLAVOR_JFD_REFORM_EDUCATION'),
		('FLAVOR_JFD_REFORM_ECONOMY'),
		('FLAVOR_JFD_REFORM_INDUSTRY'),
		('FLAVOR_JFD_REFORM_MILITARY'),
		('FLAVOR_JFD_REFORM_RELIGION'),
		('FLAVOR_JFD_REFORM_SOCIETY'),
		('FLAVOR_JFD_REFORM_WELFARE'),
		('FLAVOR_JFD_RELIGIOUS_INTOLERANCE'),
		('FLAVOR_JFD_SLAVERY'),
		('FLAVOR_JFD_STATE_RELIGION');
--------------------------------------------------------------------------------------------------------------------------
-- Leader_Flavors
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Leader_Flavors
		(LeaderType,					FlavorType,							Flavor)
VALUES	('LEADER_JFD_VANDALS_GENSERIC',	'FLAVOR_JFD_DECOLONIZATION',		2),
		('LEADER_JFD_VANDALS_GENSERIC',	'FLAVOR_JFD_MERCENARY',				4),
		('LEADER_JFD_VANDALS_GENSERIC',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',	4),
		('LEADER_JFD_VANDALS_GENSERIC',	'FLAVOR_JFD_REFORM_GOVERNMENT',		9),
		('LEADER_JFD_VANDALS_GENSERIC',	'FLAVOR_JFD_REFORM_LAW',			8),
		('LEADER_JFD_VANDALS_GENSERIC',	'FLAVOR_JFD_REFORM_DIPLOMACY',		8),
		('LEADER_JFD_VANDALS_GENSERIC',	'FLAVOR_JFD_REFORM_EDUCATION',		6),
		('LEADER_JFD_VANDALS_GENSERIC',	'FLAVOR_JFD_REFORM_ECONOMY',		6),
		('LEADER_JFD_VANDALS_GENSERIC',	'FLAVOR_JFD_REFORM_INDUSTRY',		7),
		('LEADER_JFD_VANDALS_GENSERIC',	'FLAVOR_JFD_REFORM_MILITARY',		9),
		('LEADER_JFD_VANDALS_GENSERIC',	'FLAVOR_JFD_REFORM_RELIGION',		6),
		('LEADER_JFD_VANDALS_GENSERIC',	'FLAVOR_JFD_REFORM_SOCIETY',		8),
		('LEADER_JFD_VANDALS_GENSERIC',	'FLAVOR_JFD_REFORM_WELFARE',		5),
		('LEADER_JFD_VANDALS_GENSERIC',	'FLAVOR_JFD_SLAVERY',				8),
		('LEADER_JFD_VANDALS_GENSERIC',	'FLAVOR_JFD_STATE_RELIGION',		4);
--==========================================================================================================================
-- CIVILIZATIONS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_YnAEMP
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Civilizations_YnAEMP
		(CivilizationType,						MapPrefix,				X,		Y)
VALUES	('CIVILIZATION_JFD_VANDALS_GENSERIC',	'AfriAsiaAust',			25,		69),
		('CIVILIZATION_JFD_VANDALS_GENSERIC',	'AfriSouthEuro',		33,		62),
		('CIVILIZATION_JFD_VANDALS_GENSERIC',	'AfriGiant',			61,		135),
		('CIVILIZATION_JFD_VANDALS_GENSERIC',	'AfricaLarge',			26,		72),
		('CIVILIZATION_JFD_VANDALS_GENSERIC',	'Apennine',				19,		7),
		('CIVILIZATION_JFD_VANDALS_GENSERIC',	'AtlanticGiant',		144,	36),
		('CIVILIZATION_JFD_VANDALS_GENSERIC',	'Cordiform',			39,		37),
		('CIVILIZATION_JFD_VANDALS_GENSERIC',	'EarthMk3',				19,		48),
		('CIVILIZATION_JFD_VANDALS_GENSERIC',	'EuroGiant',			59,		14),
		('CIVILIZATION_JFD_VANDALS_GENSERIC',	'EuroLargeNew',			35,		12),
		('CIVILIZATION_JFD_VANDALS_GENSERIC',	'EuroLarge',			32,		22),
		('CIVILIZATION_JFD_VANDALS_GENSERIC',	'GreatestEarth',		47,		35),
		('CIVILIZATION_JFD_VANDALS_GENSERIC',	'Mediterranean',		38,		26),
		('CIVILIZATION_JFD_VANDALS_GENSERIC',	'MediterraneanHuge',	39,		9),
		('CIVILIZATION_JFD_VANDALS_GENSERIC',	'NorthAtlantic',		99,		10),
		('CIVILIZATION_JFD_VANDALS_GENSERIC',	'WestAfrica',			72,		77),
		('CIVILIZATION_JFD_VANDALS_GENSERIC',	'Yagem',				34,		26),
		('CIVILIZATION_JFD_VANDALS_GENSERIC',	'Yahem',				58,		50);
--------------------------------------------------------------------------------------------------------------------------	
-- Civilizations_YnAEMPRequestedResources
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Civilizations_YnAEMPRequestedResources
		(CivilizationType,						MapPrefix, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4, Req5, Yield5, Req6, Yield6)
SELECT	'CIVILIZATION_JFD_VANDALS_GENSERIC',	MapPrefix, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4, Req5, Yield5, Req6, Yield6
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_CARTHAGE';
--------------------------------------------------------------------------------------------------------------------------
-- Civilization_JFD_CultureTypes
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_CultureTypes(
	CivilizationType 					text 		REFERENCES Civilizations(Type) 		default null,
	CultureType 						text											default null,
	SubCultureType 						text											default null,
	ArtDefineTag						text											default	null,
	DecisionsTag						text											default	null,
	DefeatScreenEarlyTag				text											default	null,
	DefeatScreenMidTag					text											default	null,
	DefeatScreenLateTag					text											default	null,
	IdealsTag							text											default	null,
	SplashScreenTag						text											default	null,
	SoundtrackTag						text											default	null,
	UnitDialogueTag						text											default null);

INSERT INTO Civilization_JFD_CultureTypes
		(CivilizationType,						ArtDefineTag, CultureType, SubCultureType, DecisionsTag, DefeatScreenEarlyTag,			 DefeatScreenMidTag,			DefeatScreenLateTag,			IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT	'CIVILIZATION_JFD_VANDALS_GENSERIC',	ArtDefineTag, CultureType, SubCultureType, DecisionsTag, 'DefeatScreenEarlyVandals.dds', 'DefeatScreenMidVandals.dds',	'DefeatScreenLateVandals.dds',	IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_DENMARK';
	
UPDATE Civilizations 
SET SoundtrackTag = 'JFD_Northern'
WHERE Type = 'CIVILIZATION_JFD_VANDALS_GENSERIC'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Northern')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CULDIV_SOUNDTRACK_ADDON' AND Value = 1);
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_JFD_Governments
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Civilization_JFD_Governments
		(CivilizationType, 						GovernmentType,				Weight)
VALUES	('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'GOVERNMENT_JFD_MONARCHY',	70);
--==========================================================================================================================
--==========================================================================================================================



