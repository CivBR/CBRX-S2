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
            (LeaderType,             TraitOne,                  TraitTwo)
VALUES      ('LEADER_JFD_LENIN',	 'POLICY_CHARISMATIC_X',	'POLICY_INDUSTRIOUS_X');
------------------------------	
-- Leaders
------------------------------	
UPDATE Leaders 
SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X' )
	THEN 'Lenin [ICON_HAPPINESS_1][ICON_PRODUCTION]'
	ELSE 'TXT_KEY_LEADER_JFD_LENIN' END) 
WHERE Type = 'LEADER_JFD_LENIN';

CREATE TRIGGER CivIVTraitsSovietUnionLenin
AFTER INSERT ON Leaders WHEN 'LEADER_JFD_LENIN' = NEW.Type
BEGIN
	UPDATE Leaders 
	SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X' )
		THEN 'Lenin [ICON_HAPPINESS_1][ICON_PRODUCTION]]'
		ELSE 'TXT_KEY_LEADER_JFD_LENIN' END) 
	WHERE Type = 'LEADER_JFD_LENIN';
END;	
--==========================================================================================================================
-- BrutalSamurai's Ethnic Units/Gedemon's R.E.D.
--==========================================================================================================================
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_RUSSIA' )
	THEN '_RUSSIA'
	ELSE '_EURO' END) 
WHERE Type = 'CIVILIZATION_JFD_USSR_LENIN';
--==========================================================================================================================
-- Gedemon's YnAEMP
--==========================================================================================================================
-- Civilizations_YagemStartPosition
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
			(Type,									X,		Y)
VALUES		('CIVILIZATION_JFD_USSR_LENIN',			38,		72);
------------------------------------------------------------	
-- Civilizations_YahemStartPosition
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
			(Type,									X,		Y)
VALUES		('CIVILIZATION_JFD_USSR_LENIN',			75,		63);
------------------------------------------------------------	
-- Civilizations_CordiformStartPosition 
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
			(Type,									X,		Y)
VALUES		('CIVILIZATION_JFD_USSR_LENIN',			45,		36);
------------------------------------------------------------	
-- Civilizations_GreatestEarthStartPosition 
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
			(Type,									X,		Y)
VALUES		('CIVILIZATION_JFD_USSR_LENIN',			63,		56);
------------------------------------------------------------	
-- Civilizations_EuroGiantStartPosition 
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroGiantStartPosition
		(Type,										X,		Y)
VALUES	('CIVILIZATION_JFD_USSR_LENIN',				122,	84);
------------------------------------------------------------	
-- Civilizations_EuroLargeStartPosition 
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroLargeStartPosition
			(Type,									X,		Y)
VALUES		('CIVILIZATION_JFD_USSR_LENIN',			60,		53);
------------------------------------------------------------	
-- Civilizations_NorthAtlanticStartPosition 
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthAtlanticStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthAtlanticStartPosition
			(Type,									X,		Y)
VALUES		('CIVILIZATION_JFD_USSR_LENIN',			103,	46);
------------------------------------------------------------	
-- Civilizations_AmericasStartPosition 
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AmericasStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AmericasStartPosition
			(Type,									X,		Y)
SELECT		('CIVILIZATION_JFD_USSR_LENIN'),		X,		Y
FROM Civilizations_AmericasStartPosition WHERE Type = 'CIVILIZATION_RUSSIA';
------------------------------------------------------------	
-- Civilizations_NorthWestEuropeStartPosition 
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthWestEuropeStartPosition(Type, X, Y, AltX, AltY);
DELETE FROM Civilizations_NorthWestEuropeStartPosition WHERE Type = 'CIVILIZATION_RUSSIA';
INSERT INTO Civilizations_NorthWestEuropeStartPosition
			(Type,									X,		Y)
VALUES		('CIVILIZATION_JFD_USSR_LENIN',			56,		27);
------------------------------------------------------------	
-- Civilizations_YagemRequestedResource 
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource
			(Type, 									Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_JFD_USSR_LENIN'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE Type = 'CIVILIZATION_RUSSIA';
------------------------------------------------------------	
-- Civilizations_YahemRequestedResource 
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YahemRequestedResource
			(Type, 									Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_JFD_USSR_LENIN'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE Type = 'CIVILIZATION_RUSSIA';
------------------------------------------------------------	
-- Civilizations_GreatestEarthRequestedResource 
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_GreatestEarthRequestedResource
			(Type, 									Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_JFD_USSR_LENIN'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_GreatestEarthRequestedResource WHERE Type = 'CIVILIZATION_RUSSIA';
------------------------------------------------------------	
-- Civilizations_EuroLargeRequestedResource 
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroGiantRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_EuroGiantRequestedResource
			(Type, 									Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_JFD_USSR_LENIN'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_EuroGiantRequestedResource WHERE Type = 'CIVILIZATION_RUSSIA';
------------------------------------------------------------	
-- Civilizations_EuroLargeRequestedResource 
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_EuroLargeRequestedResource
			(Type, 									Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_JFD_USSR_LENIN'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_EuroLargeRequestedResource WHERE Type = 'CIVILIZATION_RUSSIA';
------------------------------------------------------------	
-- Civilizations_AmericasRequestedResource 
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AmericasRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AmericasRequestedResource
			(Type, 									Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_JFD_USSR_LENIN'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AmericasRequestedResource WHERE Type = 'CIVILIZATION_RUSSIA';
------------------------------------------------------------	
-- Civilizations_NorthAtlanticRequestedResource 
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthAtlanticRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_NorthAtlanticRequestedResource
			(Type, 									Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_JFD_USSR_LENIN'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_NorthAtlanticRequestedResource WHERE Type = 'CIVILIZATION_RUSSIA';
------------------------------------------------------------	
-- Civilizations_NorthWestEuropeRequestedResource 
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthWestEuropeRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_NorthWestEuropeRequestedResource
			(Type, 									Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_JFD_USSR_LENIN'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_NorthWestEuropeRequestedResource WHERE Type = 'CIVILIZATION_RUSSIA';
--==========================================================================================================================
-- Hazel's Map Labels
--==========================================================================================================================
-- ML_CivCultures
------------------------------	
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
			(CivType,							CultureType,	CultureEra)
VALUES		('CIVILIZATION_JFD_USSR_LENIN',		'SLAVIC',		'ANY');
--==========================================================================================================================
-- JFD's Cultural Diversity
--==========================================================================================================================
-- Civilization_JFD_CultureTypes
------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	CultureType 								text										default null,
	SplashScreenTag								text										default	null,
	SoundtrackTag								text										default	null);

INSERT OR REPLACE INTO Civilization_JFD_CultureTypes
			(CivilizationType,				CultureType,		SplashScreenTag,	SoundtrackTag)
VALUES		('CIVILIZATION_JFD_USSR_LENIN',	'JFD_Totalitarian',	'JFD_Totalitarian',	'JFD_Totalitarian');
------------------------------	
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET SoundtrackTag = (CASE WHEN EXISTS(SELECT SoundtrackTag FROM Civilizations WHERE SoundtrackTag = 'JFD_Totalitarian' )
	THEN 'JFD_Totalitarian'
	ELSE 'Russia' END) 
WHERE Type = 'CIVILIZATION_JFD_USSR_LENIN';
--==========================================================================================================================
-- JFD's Exploration Continued Expanded
-- Buildings
------------------------------	
CREATE TABLE IF NOT EXISTS 
JFD_GlobalUserSettings (
	Type 											text 									default null,
	Value 											integer 								default 0);

UPDATE Buildings
SET Help = 'TXT_KEY_BUILDING_JFD_LENIN_COMMISSARIAT_LOYALTY_HELP'
WHERE Type = 'BUILDING_JFD_LENIN_COMMISSARIAT' 
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_COLONY_LOYALTY' AND Value = 1);
------------------------------	
-- Civilization_JFD_ColonialCityNames
------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_ColonialCityNames (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	ColonyName 									text										default null,
	LinguisticType								text										default	null,
	CultureType									text										default	null);

INSERT OR REPLACE INTO Civilization_JFD_ColonialCityNames
			(CivilizationType, 					ColonyName,								LinguisticType)
VALUES		('CIVILIZATION_JFD_USSR_LENIN',		null,									'JFD_Slavic');
------------------------------	
-- Civilization_JFD_RevolutionaryCivilizationsToSpawn
------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_RevolutionaryCivilizationsToSpawn (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	RevolutionaryCivilizationType 				text 	REFERENCES Civilizations(Type) 		default null);
	
INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,					RevolutionaryCivilizationType)
VALUES		('CIVILIZATION_RUSSIA',				'CIVILIZATION_JFD_USSR_LENIN'),
			('CIVILIZATION_JFD_USSR_LENIN',		'CIVILIZATION_RUSSIA');

INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,					RevolutionaryCivilizationType)
SELECT		('CIVILIZATION_JFD_USSR_LENIN'),	('CIVILIZATION_JFD_PETRINE_RUSSIA')
WHERE EXISTS (SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_JFD_PETRINE_RUSSIA');

INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,					RevolutionaryCivilizationType)
SELECT		('CIVILIZATION_JFD_USSR_LENIN'),	('CIVILIZATION_JFD_USSR_STALIN')
WHERE EXISTS (SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_JFD_USSR_STALIN');

INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,					RevolutionaryCivilizationType)
SELECT		('CIVILIZATION_JFD_USSR_LENIN'),	('CIVILIZATION_JFD_NICHOLAS_RUSSIA')
WHERE EXISTS (SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_JFD_NICHOLAS_RUSSIA');

INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,					RevolutionaryCivilizationType)
SELECT		('CIVILIZATION_JFD_USSR_LENIN'),	('CIVILIZATION_JFD_MUSCOVY')
WHERE EXISTS (SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_JFD_MUSCOVY');

INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,					RevolutionaryCivilizationType)
SELECT		('CIVILIZATION_JFD_USSR_LENIN'),	('CIVILIZATION_JFD_NOVGOROD')
WHERE EXISTS (SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_JFD_NOVGOROD');

INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,					RevolutionaryCivilizationType)
SELECT		('CIVILIZATION_JFD_USSR_LENIN'),	('CIVILIZATION_JFD_PUTIN_RUSSIA')
WHERE EXISTS (SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_JFD_PUTIN_RUSSIA');
--==========================================================================================================================	
-- JFD's Piety & Prestige
--==========================================================================================================================			
-- Flavors
------------------------------	
INSERT OR REPLACE INTO Flavors 
			(Type)
VALUES		('FLAVOR_JFD_RELIGIOUS_INTOLERANCE');
------------------------------
-- Leader_Flavors
------------------------------
INSERT INTO Leader_Flavors
			(LeaderType,			FlavorType,								Flavor)
VALUES		('LEADER_JFD_LENIN',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',		0);
--==========================================================================================================================
-- Sukritact's Decisions
--==========================================================================================================================
-- DecisionsAddin_Support
------------------------------
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('JFD_USSRLeninDecisions.lua');
------------------------------
-- Policies
------------------------------
INSERT INTO Policies
			(Type,									Description)
VALUES		('POLICY_JFD_SOVIET_LENIN_PRODNALOG',	'TXT_KEY_DECISIONS_JFD_USSR_LENIN_PRODNALOG');
------------------------------
-- Policy_ImprovementYieldChanges
------------------------------
INSERT INTO Policy_ImprovementYieldChanges
			(PolicyType,							ImprovementType,		YieldType,		Yield)
VALUES		('POLICY_JFD_SOVIET_LENIN_PRODNALOG',	'IMPROVEMENT_FARM',		'YIELD_GOLD',	1);
------------------------------
-- Buildings
------------------------------
INSERT INTO Buildings 	
			(Type, 						 								BuildingClass, 						NeverCapture,	NukeImmune, GreatWorkCount, Cost, FaithCost, Espionage, Description, 														Help,																	ExtraSpies,	GlobalEspionageModifier,	PortraitIndex,	IconAtlas)
VALUES		('BUILDING_JFD_COMMISSARIAT_LENIN_FOR_INTERNAL_AFFAIRS', 	'BUILDINGCLASS_JFD_USSR_LENIN', 	1,				1,			-1,				-1,   -1, 		 1, 		 'TXT_KEY_BUILDING_JFD_COMMISSARIAT_LENIN_FOR_INTERNAL_AFFAIRS', 	'TXT_KEY_BUILDING_JFD_COMMISSARIAT_LENIN_FOR_INTERNAL_AFFAIRS_HELP',	1,			-33,						2,				'JFD_USSR_LENIN_ATLAS');
--==========================================================================================================================
-- Sukritact's Events
--==========================================================================================================================
-- EventsAddin_Support
------------------------------
CREATE TABLE IF NOT EXISTS EventsAddin_Support(FileName);
INSERT INTO EventsAddin_Support (FileName) VALUES ('JFD_USSRLeninEvents.lua');
--==========================================================================================================================
--==========================================================================================================================