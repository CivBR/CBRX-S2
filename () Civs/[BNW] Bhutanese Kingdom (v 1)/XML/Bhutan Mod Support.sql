CREATE TABLE IF NOT EXISTS ML_CivCultures(ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
			(CivType,					CultureType,		   CultureEra)
VALUES		('CIVILIZATION_BHUTAN',		'EAST_ASIAN',				'ANY');
--==========================================================================================================================
--==========================================================================================================================
--==========================================================================================================================
--------------------------------	
-- Ethnic Units Support
--------------------------------	
UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_AZTEC' )
	THEN '_CHINA'
	ELSE '_ASIA' END) 
WHERE Type = 'CIVILIZATION_BHUTAN';
--==========================================================================================================================
--==========================================================================================================================	
-- Flavors
--==========================================================================================================================			
INSERT OR REPLACE INTO Flavors 
			(Type)
VALUES		('FLAVOR_JFD_RELIGIOUS_INTOLERANCE');

INSERT INTO Leader_Flavors
			(LeaderType,			FlavorType,								Flavor)
VALUES		('LEADER_WANGCHUCK',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',				5);
--==========================================================================================================================
-- JFD CULTURAL DIVERSITY
--==========================================================================================================================
-- Civilization_JFD_CultureTypes
------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes(
	CivilizationType 							text 	REFERENCES Civilizations(Type) 			default null,
	CultureType 								text											default null,
	ArtDefineTag								text											default	null,
	SplashScreenTag								text											default	null,
	SoundtrackTag								text											default	null,
	UnitDialogueTag								text											default null);

INSERT INTO Civilization_JFD_CultureTypes
		(CivilizationType,			ArtDefineTag, CultureType, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT	'CIVILIZATION_BHUTAN',	ArtDefineTag, CultureType, SplashScreenTag, SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_INDIA';
------------------------------	
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET SoundtrackTag = 'JFD_Bharata'
WHERE Type = 'CIVILIZATION_BHUTAN'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Bharata')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CULDIV_SOUNDTRACK_ADDON' AND Value = 1);
--==========================================================================================================================	
-- JFD AND POUAKAI MERCENARIES
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
		(LeaderType,				FlavorType,					Flavor)
VALUES	('LEADER_WANGCHUCK',	'FLAVOR_JFD_MERCENARY',		0);
--==========================================================================================================================
-- GEDEMON YNAEMP
--==========================================================================================================================
-- Civilizations_YagemStartPosition (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
		(Type,							X,	Y)
VALUES	('CIVILIZATION_BHUTAN',	71,	52);
------------------------------------------------------------	
-- Civilizations_YahemStartPosition (Earth Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
		(Type,							X,	Y)
VALUES	('CIVILIZATION_BHUTAN',	98,	48);
------------------------------------------------------------	
-- Civilizations_CordiformStartPosition (Earth Standard)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
		(Type,							X,	Y)
VALUES	('CIVILIZATION_BHUTAN',	57,	25);
------------------------------------------------------------	
-- Civilizations_GreatestEarthStartPosition (Earth Greatest) 
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
		(Type,							X,	Y)
VALUES	('CIVILIZATION_BHUTAN',	80,	40);
--==========================================================================================================================
-- Civilizations_AsiaStartPosition (Asia)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_AsiaStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AsiaStartPosition
			(Type,									X,		Y)
VALUES		('CIVILIZATION_BHUTAN',					37,		37);
--==========================================================================================================================
-- Civilizations_EastAsiaStartPosition (South-East Asia Large)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_EastAsiaStartPosition(Type, X, Y, AltX, AltY);
INSERT OR REPLACE INTO Civilizations_EastAsiaStartPosition
			(Type,									X,		Y)
VALUES		('CIVILIZATION_BHUTAN',			8,		51);