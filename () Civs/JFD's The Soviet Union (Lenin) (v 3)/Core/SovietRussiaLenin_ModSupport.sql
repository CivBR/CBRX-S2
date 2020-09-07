--=======================================================================================================================
-- CIVILIZATIONS
--=======================================================================================================================
------------------------------------------------------------------------------------------------------------------------	
-- Civilization_JFD_ColonialCityNames
------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilization_JFD_ColonialCityNames(CivilizationType, ColonyName, LinguisticType);
INSERT INTO Civilization_JFD_ColonialCityNames 
		(CivilizationType, 						ColonyName, LinguisticType)
SELECT	'CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN',	ColonyName, LinguisticType
FROM Civilization_JFD_ColonialCityNames WHERE CivilizationType = 'CIVILIZATION_RUSSIA';
------------------------------------------------------------------------------------------------------------------------
-- Civilizations_YnAEMP
------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YnAEMP(CivilizationType, MapPrefix, X, Y, CapitalName, AltX, AltY, AltCapitalName);
INSERT INTO Civilizations_YnAEMP
		(CivilizationType,							MapPrefix,				X,		Y,		AltX,	AltY,	AltCapitalName)
VALUES	-- ('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN',	'AfriAsiaAust',			31,     74,		null,	null,	null),
		-- ('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 'AfricaLarge',			0,		0,		null,	null,	null),
		-- ('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN',	'AfriSouthEuro',		36,		68,		null,	null,	null),
		-- ('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 'Americas',				0,		0,		null,	null,	null),
		-- ('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 'Asia',					0,		0,		null,	null,	null),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN',	'Cordiform',			45,		36,		null,	null,	null),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN',	'EarthMk3',				32,		76,		null,	null,	null),
		-- ('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN','EastAsia',				0,		0,		null,	null,	null),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN',	'EuroLargeNew',			59,		64,		null,	null,	null),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN',	'GreatestEarth',		63,		56,		null,	null,	null),
		-- ('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 'IndianOcean',			0,		0,		null,	null,	null),
		-- ('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN',	'Mediterranean',		46,		39,		null,	null,	null),
		-- ('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 'Mesopotamia',			68,		35,		null,	null,	null),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN',	'NorthAtlantic',		103,	46,		null,	null,	null),
		-- ('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 'NorthEastAsia',		0,		0,		null,	null,	null),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN',	'NorthWestEurope',		52,		44,		null,	null,	null),
		-- ('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN',	'Orient',				14,		68,		null,	null,	null),
		-- ('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 'SouthPacific',			0,		0,		null,	null,	null),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN',	'Yagem',				38,		72,		null,	null,	null),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN',	'Yahem',				75,		63,		null,	null,	null);
------------------------------------------------------------------------------------------------------------------------	
-- Civilizations_YnAEMPRequestedResources
------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YnAEMPRequestedResources(CivilizationType, MapPrefix, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4, Req5, Yield5, Req6, Yield6);
INSERT INTO Civilizations_YnAEMPRequestedResources
		(CivilizationType,						MapPrefix, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4, Req5, Yield5, Req6, Yield6)
SELECT	'CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN',	MapPrefix, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4, Req5, Yield5, Req6, Yield6
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_RUSSIA';
------------------------------------------------------------------------------------------------------------------------
-- Civilization_JFD_CultureTypes
------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilization_JFD_CultureTypes(CivilizationType, CultureType, SubCultureType, ArtDefineTag, DecisionsTag, DefeatScreenEarlyTag, DefeatScreenMidTag, DefeatScreenLateTag, IdealsTag, SplashScreenTag,	SoundtrackTag, UnitDialogueTag);
INSERT INTO Civilization_JFD_CultureTypes
		(CivilizationType,						ArtDefineTag, CultureType,				  SubCultureType,	DecisionsTag,		DefeatScreenEarlyTag,				  DefeatScreenMidTag,				  DefeatScreenLateTag,					IdealsTag,			SplashScreenTag,	SoundtrackTag,		 UnitDialogueTag)
SELECT	'CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN',	ArtDefineTag, 'CULTURE_JFD_TOTALITARIAN', null,				'JFD_Totalitarian', 'DefeatScreenEarlyTotalitarian.dds',  'DefeatScreenMidTotalitarian.dds',  'DefeatScreenLateTotalitarian.dds',	'JFD_Totalitarian', 'JFD_Totalitarian', 'JFD_Totalitarian',  UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_RUSSIA';
	
UPDATE Civilizations 
SET SoundtrackTag = (SELECT SoundtrackTag FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN')
WHERE Type = 'CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN';
------------------------------------------------------------------------------------------------------------------------	
-- Civilization_JFD_Governments
------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilization_JFD_Governments(CivilizationType, GovernmentType, Weight);
INSERT INTO Civilization_JFD_Governments
		(CivilizationType, 							GovernmentType,					 Weight)
VALUES	('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN',	'GOVERNMENT_JFD_TOTALITARIAN',	 60),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN',	'GOVERNMENT_JFD_REPUBLIC',		 80);
--=======================================================================================================================
--=======================================================================================================================

