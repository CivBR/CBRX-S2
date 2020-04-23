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
		('FLAVOR_JFD_REFORM_CULTURE'),
		('FLAVOR_JFD_REFORM_ECONOMY'),
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
		(LeaderType,			FlavorType,							 Flavor)
VALUES	('LEADER_SENSHI_LAWTILIWADLIN',	'FLAVOR_JFD_DECOLONIZATION',		 0),
		('LEADER_SENSHI_LAWTILIWADLIN',	'FLAVOR_JFD_MERCENARY',				 6),
		('LEADER_SENSHI_LAWTILIWADLIN',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',	 4),
		('LEADER_SENSHI_LAWTILIWADLIN',	'FLAVOR_JFD_REFORM_GOVERNMENT',		 8),
		('LEADER_SENSHI_LAWTILIWADLIN',	'FLAVOR_JFD_REFORM_LAW',			 8),
		('LEADER_SENSHI_LAWTILIWADLIN',	'FLAVOR_JFD_REFORM_CULTURE',		 7),
		('LEADER_SENSHI_LAWTILIWADLIN',	'FLAVOR_JFD_REFORM_ECONOMY',		 5),
		('LEADER_SENSHI_LAWTILIWADLIN',	'FLAVOR_JFD_REFORM_EDUCATION',		 4),
		('LEADER_SENSHI_LAWTILIWADLIN',	'FLAVOR_JFD_REFORM_FOREIGN',		 9),
		('LEADER_SENSHI_LAWTILIWADLIN',	'FLAVOR_JFD_REFORM_INDUSTRY',		 7),
		('LEADER_SENSHI_LAWTILIWADLIN',	'FLAVOR_JFD_REFORM_MILITARY',		 9),
		('LEADER_SENSHI_LAWTILIWADLIN',	'FLAVOR_JFD_REFORM_RELIGION',		 5),
		('LEADER_SENSHI_LAWTILIWADLIN',	'FLAVOR_JFD_SLAVERY',				 4),
		('LEADER_SENSHI_LAWTILIWADLIN',	'FLAVOR_JFD_STATE_RELIGION',		 2);
--==========================================================================================================================
-- CIVILIZATIONS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_JFD_Governments
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Civilization_JFD_Governments
		(CivilizationType,					GovernmentType,				 Weight)
VALUES  ('CIVILIZATION_SENSHI_CHUKCHI',		'GOVERNMENT_JFD_MONARCHY',	 60);
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_YnAEMP
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Civilizations_YnAEMP
		(CivilizationType,					MapPrefix,				X,		Y,		AltX,	AltY,	AltCapitalName)
VALUES	('CIVILIZATION_SENSHI_CHUKCHI',		'Cordiform',			40,		49,		null,	null,	null),
		('CIVILIZATION_SENSHI_CHUKCHI',		'EarthMk3',				105,	88,		null,	null,	null),
		('CIVILIZATION_SENSHI_CHUKCHI',		'Yagem',				107,	83,		null,	null,	null),
		('CIVILIZATION_SENSHI_CHUKCHI',		'Yahem',				124,	69,		null,	null,	null);
--------------------------------------------------------------------------------------------------------------------------	
-- Civilizations_YnAEMPRequestedResources
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Civilizations_YnAEMPRequestedResources
		(CivilizationType,				MapPrefix, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4, Req5, Yield5, Req6, Yield6)
SELECT	'CIVILIZATION_SENSHI_CHUKCHI',	MapPrefix, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4, Req5, Yield5, Req6, Yield6
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_MONGOL';
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
		(CivilizationType,				ArtDefineTag, CultureType,					SubCultureType, DecisionsTag,		DefeatScreenEarlyTag, DefeatScreenMidTag, DefeatScreenLateTag, IdealsTag,			SplashScreenTag,	SoundtrackTag,		UnitDialogueTag)
SELECT	'CIVILIZATION_SENSHI_CHUKCHI',	'_JFD_POLAR', 'CULTURE_JFD_POLAR',	SubCultureType, 'JFD_Polar', DefeatScreenEarlyTag, DefeatScreenMidTag, DefeatScreenLateTag, 'JFD_Polar', 'JFD_Polar',	'JFD_Polar', UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_MONGOL';

UPDATE Civilizations 
SET SoundtrackTag = 'JFD_Polar'
WHERE Type = 'CIVILIZATION_SENSHI_CHUKCHI'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Polar')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CULDIV_SOUNDTRACK_ADDON' AND Value = 1);
--==========================================================================================================================
--==========================================================================================================================