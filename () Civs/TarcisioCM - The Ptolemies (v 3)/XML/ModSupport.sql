----------------------------------------------------------------------------------------------------------------
--
----------------------------------------------------------------------------------------------------------------

--YnAEMP
--Earth Giant
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
        (Type,                          X,  Y)
VALUES  ('CIVILIZATION_TCM_PTOLEMIES',    30, 49);
 
CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource
        (Type,                          Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT  ('CIVILIZATION_TCM_PTOLEMIES'), Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE Type = 'CIVILIZATION_EGYPT';
  
--Earth Huge
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
        (Type,                          X,  Y)
VALUES  ('CIVILIZATION_TCM_PTOLEMIES',    69, 47);
 
CREATE TABLE IF NOT EXISTS Civilizations_YahemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YahemRequestedResource
        (Type,                          Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT  ('CIVILIZATION_TCM_PTOLEMIES'), Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE Type = 'CIVILIZATION_EGYPT';
   
--Earth Standard
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
        (Type,                          X,  Y)
VALUES  ('CIVILIZATION_TCM_PTOLEMIES',    43, 19);
  
CREATE TABLE IF NOT EXISTS Civilizations_CordiformRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_CordiformRequestedResource
        (Type,                          Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT  ('CIVILIZATION_TCM_PTOLEMIES'), Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_CordiformRequestedResource WHERE Type = 'CIVILIZATION_EGYPT';
 
--Earth Greatest
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
        (Type,                          X,  Y)
VALUES  ('CIVILIZATION_TCM_PTOLEMIES',    57, 36);
 
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_GreatestEarthRequestedResource
        (Type,                          Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT  ('CIVILIZATION_TCM_PTOLEMIES'), Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_GreatestEarthRequestedResource WHERE Type = 'CIVILIZATION_EGYPT';
 
--Europe Large
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroLargeStartPosition
        (Type,                          X,  Y)
VALUES  ('CIVILIZATION_TCM_PTOLEMIES',     56, 15);
 
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_EuroLargeRequestedResource
        (Type,                          Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT  ('CIVILIZATION_TCM_PTOLEMIES'), Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_EuroLargeRequestedResource WHERE Type = 'CIVILIZATION_EGYPT';
 
--Africa Large
CREATE TABLE IF NOT EXISTS Civilizations_AfricaLargeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AfricaLargeStartPosition
        (Type,                          X,  Y)
VALUES  ('CIVILIZATION_TCM_PTOLEMIES',    39, 67);
 
CREATE TABLE IF NOT EXISTS Civilizations_AfricaLargeRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AfricaLargeRequestedResource
        (Type,                          Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT  ('CIVILIZATION_TCM_PTOLEMIES'), Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AfricaLargeRequestedResource WHERE Type = 'CIVILIZATION_EGYPT';
 
--Nile Valley 
CREATE TABLE IF NOT EXISTS Civilizations_NileValleyStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NileValleyStartPosition
        (Type,                          X,  Y)
VALUES  ('CIVILIZATION_TCM_PTOLEMIES',    15, 71);
 
CREATE TABLE IF NOT EXISTS Civilizations_NileValleyRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_NileValleyRequestedResource
        (Type,                          Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT  ('CIVILIZATION_TCM_PTOLEMIES'), Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_NileValleyRequestedResource WHERE Type = 'CIVILIZATION_EGYPT';
 
--Mediterranean
CREATE TABLE IF NOT EXISTS Civilizations_MediterraneanStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_MediterraneanStartPosition
        (Type,                              X,  Y)
VALUES  ('CIVILIZATION_TCM_PTOLEMIES',  80, 12);
 
CREATE TABLE IF NOT EXISTS Civilizations_MediterraneanRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_MediterraneanRequestedResource
        (Type,                              Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT  ('CIVILIZATION_TCM_PTOLEMIES'), Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_MediterraneanRequestedResource WHERE Type = 'CIVILIZATION_EGYPT';
 
--Mesopotamia   
CREATE TABLE IF NOT EXISTS Civilizations_MesopotamiaStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_MesopotamiaStartPosition
        (Type,                              X,  Y)
VALUES  ('CIVILIZATION_TCM_PTOLEMIES',  24, 11);
 
CREATE TABLE IF NOT EXISTS Civilizations_MesopotamiaRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_MesopotamiaRequestedResource
        (Type,                              Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT  ('CIVILIZATION_TCM_PTOLEMIES'), Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_MesopotamiaRequestedResource WHERE Type = 'CIVILIZATION_EGYPT';

----------------------------------------------------------------------------------------------------------------
--
----------------------------------------------------------------------------------------------------------------

--JFD
CREATE TABLE IF NOT EXISTS 
JFD_GlobalUserSettings (
    Type                                        text                                        default null,
    Value                                       integer                                     default 1);
 
--Piety
INSERT OR REPLACE INTO Flavors
            (Type)
VALUES      ('FLAVOR_JFD_RELIGIOUS_INTOLERANCE');
  
INSERT INTO Leader_Flavors
            (LeaderType,                          FlavorType,                                 Flavor)
VALUES      ('LEADER_TCM_PTOLEMY',    'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',         2);

--Cultural Diversity
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes(
	CivilizationType 							text 	REFERENCES Civilizations(Type) 			default null,
	CultureType 								text											default null,
	ArtDefineTag								text											default	null,
	SplashScreenTag								text											default	null,
	SoundtrackTag								text											default	null,
	UnitDialogueTag								text											default null);

INSERT INTO Civilization_JFD_CultureTypes
		(CivilizationType,					ArtDefineTag, CultureType, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT	('CIVILIZATION_TCM_PTOLEMIES'),	ArtDefineTag, CultureType, SplashScreenTag, SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_EGYPT';

UPDATE Civilizations 
SET SoundtrackTag = 'JFD_MesopotamicEgyptian'
WHERE Type = 'CIVILIZATION_TCM_PTOLEMIES'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Mediterranean')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CULDIV_SOUNDTRACK_ADDON' AND Value = 1);

--Ethnic Units
UPDATE Civilizations SET ArtStyleSuffix = 
	( CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = "_EGYPT")
		THEN "_EGYPT"
		ELSE "_AFRI" END
	) WHERE Type = "CIVILIZATION_TCM_PTOLEMIES";

--Historical Religions

--Civ IV Traits
CREATE TABLE IF NOT EXISTS 
    Leader_SharedTraits (
    LeaderType          text    REFERENCES Leaders(Type)        default null,
    TraitOne            text    REFERENCES Policies(Type)       default null,
    TraitTwo            text    REFERENCES Policies(Type)       default null);
     
INSERT OR REPLACE INTO Leader_SharedTraits
            (LeaderType,							 TraitOne,					 TraitTwo)
VALUES      ('LEADER_TCM_PTOLEMY',	                  'POLICY_IMPERIALISTIC_X',		'POLICY_MERCANTILE_X');

UPDATE Leaders 
SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X' )
	THEN 'Ptolemy I[ICON_CITY_STATE][ICON_GOLD]'
	ELSE 'TXT_KEY_LEADER_TCM_PTOLEMY' END) 
WHERE Type = 'LEADER_TCM_PTOLEMY';

CREATE TRIGGER CivIVTraitsPtolemy
AFTER INSERT ON Leaders WHEN 'LEADER_TCM_PTOLEMY' = NEW.Type
BEGIN
	UPDATE Leaders 
	SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X' )
		THEN 'Ptolemy I[ICON_CITY_STATE][ICON_GOLD]'
		ELSE 'TXT_KEY_LEADER_TCM_PTOLEMY' END) 
	WHERE Type = 'LEADER_TCM_PTOLEMY';
END;

--ExCE
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_ColonialCityNames (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	ColonyName 									text										default null,
	LinguisticType								text										default	null,
	CultureType									text										default	null);

INSERT OR REPLACE INTO Civilization_JFD_ColonialCityNames
			(CivilizationType, 						      ColonyName,						LinguisticType)
VALUES		('CIVILIZATION_TCM_PTOLEMIES', 		          null,							    'JFD_Mesopotamian'),
			('CIVILIZATION_TCM_PTOLEMIES', 		          null,								'JFD_Hellenic');
----------------------------------------------------------------------------------------------------------------
--
----------------------------------------------------------------------------------------------------------------

--Map Labels
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
			(CivType,						      CultureType,	    CultureEra)
VALUES		('CIVILIZATION_TCM_PTOLEMIES',		  'AFRICAN',	         'ANY'),
			('CIVILIZATION_TCM_PTOLEMIES',		  'ARABIAN',		  'MODERN');

--Mercenaries 
INSERT OR REPLACE INTO Flavors 
        (Type)
VALUES  ('FLAVOR_JFD_MERCENARY');

INSERT INTO Leader_Flavors
        (LeaderType,					    FlavorType,                 Flavor)
VALUES  ('LEADER_TCM_PTOLEMY',              'FLAVOR_JFD_MERCENARY',     7);

----------------------------------------------------------------------------------------------------------------
--
----------------------------------------------------------------------------------------------------------------

--==========================================================================================================================
-- Sukritact's Decisions
--==========================================================================================================================
-- DecisionsAddin_Support
------------------------------
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('PtolemyDecisions.lua');
