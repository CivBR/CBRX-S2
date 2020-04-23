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
-- BUILDINGS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- JFD_Civilopedia_HideFromPedia
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO JFD_Civilopedia_HideFromPedia 		
		(Type)
VALUES	('BUILDING_JFD_THART_1'),
		('BUILDING_JFD_THART_2');
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
--------------------------------------------------------------------------------------------------------------------------
-- Leader_Flavors
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Leader_Flavors
		(LeaderType,		FlavorType,							Flavor)
VALUES	('LEADER_JFD_LAOS',	'FLAVOR_JFD_DECOLONIZATION',		0),
		('LEADER_JFD_LAOS',	'FLAVOR_JFD_MERCENARY',				8),
		('LEADER_JFD_LAOS',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',	6),
		('LEADER_JFD_LAOS',	'FLAVOR_JFD_REFORM_GOVERNMENT',		5),
		('LEADER_JFD_LAOS',	'FLAVOR_JFD_REFORM_LEGAL',			5),
		('LEADER_JFD_LAOS',	'FLAVOR_JFD_REFORM_CULTURE',		8),
		('LEADER_JFD_LAOS',	'FLAVOR_JFD_REFORM_ECONOMIC',		5),
		('LEADER_JFD_LAOS',	'FLAVOR_JFD_REFORM_EDUCATION',		5),
		('LEADER_JFD_LAOS',	'FLAVOR_JFD_REFORM_FOREIGN',		8),
		('LEADER_JFD_LAOS',	'FLAVOR_JFD_REFORM_INDUSTRY',		5),
		('LEADER_JFD_LAOS',	'FLAVOR_JFD_REFORM_MILITARY',		8),
		('LEADER_JFD_LAOS',	'FLAVOR_JFD_REFORM_RELIGION',		7),
		('LEADER_JFD_LAOS',	'FLAVOR_JFD_SLAVERY',				0),
		('LEADER_JFD_LAOS',	'FLAVOR_JFD_STATE_RELIGION',		9);
--==========================================================================================================================
-- CIVILIZATIONS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_JFD_Governments
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Civilization_JFD_Governments
		(CivilizationType,			GovernmentType,				Weight)
VALUES  ('CIVILIZATION_JFD_LAOS',	'GOVERNMENT_JFD_MONARCHY',	80);
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_YnAEMP
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Civilizations_YnAEMP
		(CivilizationType,			MapPrefix,				X,		Y)
VALUES	('CIVILIZATION_JFD_LAOS',	'AfriAsiaAust',			95,		52),
		('CIVILIZATION_JFD_LAOS',	'Asia',					55,		28),
		('CIVILIZATION_JFD_LAOS',	'AsiaSmall',			9,		12),
		('CIVILIZATION_JFD_LAOS',	'Cordiform',			63,		25),
		('CIVILIZATION_JFD_LAOS',	'EarthMk3',				80,		46),
		('CIVILIZATION_JFD_LAOS',	'EastAsia',				24,		41),
		('CIVILIZATION_JFD_LAOS',	'GreatestEarth',		83,		39),
		('CIVILIZATION_JFD_LAOS',	'IndianOcean',			73,		57),
		('CIVILIZATION_JFD_LAOS',	'Pacific',				24,		44),
		('CIVILIZATION_JFD_LAOS',	'Yagem',				75,		46),
		('CIVILIZATION_JFD_LAOS',	'Yahem',				101,	40);
--------------------------------------------------------------------------------------------------------------------------	
-- Civilizations_YnAEMPRequestedResources
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Civilizations_YnAEMPRequestedResources
		(CivilizationType,			MapPrefix, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4, Req5, Yield5, Req6, Yield6)
SELECT	'CIVILIZATION_JFD_LAOS',	MapPrefix, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4, Req5, Yield5, Req6, Yield6
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_SIAM';
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
		(CivilizationType,			ArtDefineTag, CultureType, SubCultureType, DecisionsTag, DefeatScreenEarlyTag, DefeatScreenMidTag, DefeatScreenLateTag, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT	'CIVILIZATION_JFD_LAOS',	ArtDefineTag, CultureType, SubCultureType, DecisionsTag, DefeatScreenEarlyTag, DefeatScreenMidTag, DefeatScreenLateTag, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_SIAM';
	
UPDATE Civilizations 
SET SoundtrackTag = 'JFD_Mandala'
WHERE Type = 'CIVILIZATION_JFD_LAOS'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Mandala')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CULDIV_SOUNDTRACK_ADDON' AND Value = 1);
--==========================================================================================================================
--==========================================================================================================================