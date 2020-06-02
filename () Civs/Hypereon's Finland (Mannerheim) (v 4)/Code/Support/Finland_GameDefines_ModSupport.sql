--=======================================================================================================================
-- BINGLES CIV IV TRAITS
--=======================================================================================================================
-- Leader_SharedTraits
------------------------------	
CREATE TABLE IF NOT EXISTS 
    Leader_SharedTraits (
    LeaderType          text    REFERENCES Leaders(Type)        default null,
    TraitOne            text    REFERENCES Policies(Type)       default null,
    TraitTwo            text    REFERENCES Policies(Type)       default null);
     
INSERT INTO Leader_SharedTraits
       (LeaderType,				TraitOne,				TraitTwo)
VALUES ('LEADER_MANNERHEIM',	'POLICY_PROTECTIVE_X',	'POLICY_SPIRITUAL_X');
------------------------------	
-- Leaders
------------------------------	
UPDATE Leaders 
SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X')
	THEN 'Mannerheim [ICON_STRENGTH][ICON_PEACE]'
	ELSE 'TXT_KEY_LEADER_MANNERHEIM' END) 
WHERE Type = 'LEADER_MANNERHEIM';
--==========================================================================================================================
-- GEDEMON R.E.D.
--==========================================================================================================================
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_SWEDEN')
	THEN '_SWEDEN'
	ELSE ArtStyleSuffix END) 
WHERE Type = 'CIVILIZATION_FINNS';
--==========================================================================================================================
-- GEDEMON YNAEMP
--==========================================================================================================================
-- Civilizations_YagemStartPosition (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
		(Type,							X,		Y)
VALUES	('CIVILIZATION_FINNS',		30,		78);
------------------------------------------------------------	
-- Civilizations_YahemStartPosition (Earth Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
		(Type,							X,		Y)
VALUES	('CIVILIZATION_FINNS',		68,		67);
------------------------------------------------------------	
-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
		(Type,							X,		Y)
VALUES	('CIVILIZATION_FINNS',		56,		61);
------------------------------------------------------------	
-- Civilizations_CordiformStartPosition (Earth Cordiform)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
		(Type,							X,		Y)
VALUES	('CIVILIZATION_FINNS',		41,		39);
------------------------------------------------------------	
-- Civilizations_EuroGiantStartPosition (Europe Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroGiantStartPosition
		(Type,							X,		Y)
VALUES	('CIVILIZATION_FINNS',		109,	28); ----
------------------------------------------------------------	
-- Civilizations_EuroLargeStartPosition (Europe Large)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroLargeStartPosition
		(Type,							X,		Y)
VALUES	('CIVILIZATION_FINNS',		46,		64);
------------------------------------------------------------	
-- Civilizations_YagemRequestedResource (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource
		(Type, 							Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_JFD_TURKS'),		Req1, Yield1, Req2,	Yield2,	Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE (Type = 'CIVILIZATION_SWEDEN');
------------------------------------------------------------	
-- Civilizations_YahemRequestedResource (Earth Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YahemRequestedResource
		(Type, 							Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_JFD_TURKS'),		Req1, Yield1, Req2,	Yield2,	Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE (Type = 'CIVILIZATION_SWEDEN');
------------------------------------------------------------	
-- Civilizations_GreatestEarthRequestedResource (Earth Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_GreatestEarthRequestedResource
		(Type, 							Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_JFD_TURKS'),		Req1, Yield1, Req2,	Yield2,	Req3, Yield3, Req4, Yield4
FROM Civilizations_GreatestEarthRequestedResource WHERE (Type = 'CIVILIZATION_SWEDEN');
------------------------------------------------------------	
-- Civilizations_CordiformRequestedResource (Earth Cordiform)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CordiformRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_CordiformRequestedResource
		(Type, 							Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_JFD_TURKS'),		Req1, Yield1, Req2,	Yield2,	Req3, Yield3, Req4, Yield4
FROM Civilizations_CordiformRequestedResource WHERE (Type = 'CIVILIZATION_SWEDEN');
------------------------------------------------------------	
-- Civilizations_EuroGiantRequestedResource (Euro Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroGiantRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_EuroGiantRequestedResource
		(Type, 							Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_JFD_TURKS'),		Req1, Yield1, Req2,	Yield2,	Req3, Yield3, Req4, Yield4
FROM Civilizations_EuroGiantRequestedResource WHERE (Type = 'CIVILIZATION_SWEDEN');
------------------------------------------------------------	
-- Civilizations_EuroLargeRequestedResource (Euro Large)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_EuroLargeRequestedResource
		(Type, 							Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_JFD_TURKS'),		Req1, Yield1, Req2,	Yield2,	Req3, Yield3, Req4, Yield4
FROM Civilizations_EuroLargeRequestedResource WHERE (Type = 'CIVILIZATION_SWEDEN');
------------------------------------------------------------	
-- Civilizations_AegeanRequestedResource (Aegean)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AegeanRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AegeanRequestedResource
		(Type, 							Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_JFD_TURKS'),		Req1, Yield1, Req2,	Yield2,	Req3, Yield3, Req4, Yield4
FROM Civilizations_AegeanRequestedResource WHERE (Type = 'CIVILIZATION_SWEDEN');
------------------------------------------------------------	
-- Civilizations_MesopotamiaRequestedResource (Mesopotamia)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_MesopotamiaRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_MesopotamiaRequestedResource
		(Type, 							Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_JFD_TURKS'),		Req1, Yield1, Req2,	Yield2,	Req3, Yield3, Req4, Yield4
FROM Civilizations_MesopotamiaRequestedResource WHERE (Type = 'CIVILIZATION_SWEDEN');
------------------------------------------------------------	
-- Civilizations__MediterraneanRequestedResource (Mediterranean)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_MediterraneanRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_MediterraneanRequestedResource
		(Type, 							Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_JFD_TURKS'),		Req1, Yield1, Req2,	Yield2,	Req3, Yield3, Req4, Yield4
FROM Civilizations_MediterraneanRequestedResource WHERE (Type = 'CIVILIZATION_SWEDEN');
--==========================================================================================================================
-- JFD CULTURAL DIVERSITY
--==========================================================================================================================
-- Civilization_JFD_CultureTypes
------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes(
	CivilizationType 							text 	REFERENCES Civilizations(Type) 			default null,
	CultureType 								text											default null,
	SplashScreenTag								text											default	null,
	SoundtrackTag								text											default	null,
	ArtDefineTag								text											default	null);

INSERT INTO Civilization_JFD_CultureTypes
		(CivilizationType,			CultureType,	SplashScreenTag, SoundtrackTag,	 ArtDefineTag)
VALUES	('CIVILIZATION_FINNS',	'JFD_Northern',  'JFD_Northern',	 'JFD_Northern',	 'JFD_Northern');
------------------------------	
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET SoundtrackTag = (CASE WHEN EXISTS(SELECT SoundtrackTag FROM Civilizations WHERE SoundtrackTag = 'JFD_Northern')
	THEN 'JFD_Northern'
	ELSE 'Sweden' END) 
WHERE Type = 'CIVILIZATION_FINNS';
--==========================================================================================================================
-- JFD EXPLORATION CONTINUED EXPANDED
--==========================================================================================================================
------------------------------	
-- Civilization_JFD_RevolutionaryCivilizationsToSpawn
------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_RevolutionaryCivilizationsToSpawn (
	CivilizationType 						text 	REFERENCES Civilizations(Type) 		default null,
	RevolutionaryCivilizationType 			text 	REFERENCES Civilizations(Type) 		default null);
	
INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
		(CivilizationType,					RevolutionaryCivilizationType)
VALUES	('CIVILIZATION_SWEDEN',			'CIVILIZATION_FINNS'),
		('CIVILIZATION_RUSSIA',			'CIVILIZATION_FINNS'),
		('CIVILIZATION_FINNS',			'CIVILIZATION_SWEDEN');
--==========================================================================================================================	
-- JFD PIETY & PRESTIGE
--==========================================================================================================================			
-- Flavors
------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_RELIGIOUS_INTOLERANCE');
------------------------------
-- Leader_Flavors
------------------------------
INSERT INTO Leader_Flavors
		(LeaderType,			FlavorType,								Flavor)
VALUES	('LEADER_MANNERHEIM',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',		2);
--=========================================================================================================================
-- JFD AND POUAKAI'S MERCENARIES
--=========================================================================================================================
-- Flavors
--------------------------------------------------------------------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_MERCENARY');
--------------------------------------------------------------------------------------------------------------------------
-- Leader_Flavors
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Leader_Flavors
		(LeaderType,					FlavorType,					Flavor)
VALUES	--Vanilla
		('LEADER_MANNERHEIM',			'FLAVOR_JFD_MERCENARY',		4);