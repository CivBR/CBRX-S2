--Decisions
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('MississippiTomatekhDecisions.lua');

CREATE TABLE IF NOT EXISTS EventsAddin_Support(FileName);
INSERT INTO EventsAddin_Support (FileName) VALUES ('MississippiTomatekhEvents.lua');

--Ethnic Units
UPDATE Civilizations SET ArtStyleSuffix = 
	( CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = "_IROQUOIS")
		THEN "_IROQUOIS"
		ELSE "_AMER" END
	) WHERE Type = "CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH";

--Map Labels
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
			(CivType,							                  CultureType,	CultureEra)
VALUES		('CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH',		'FIRST_AMERICANS',		 'ANY');

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
            (LeaderType,									                       FlavorType,    Flavor)
VALUES      ('LEADER_MISSISSIPPI_MOD_TOMATEKH',            'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',         4);

--Prestige
CREATE TABLE IF NOT EXISTS 
    Civilization_JFD_Governments (
    CivilizationType                text        REFERENCES Civilizations(Type)                  default null,
    CultureType                     text                                                        default null,
    LegislatureName                 text                                                        default null,
    OfficeTitle                     text                                                        default null,
    GovernmentType                  text                                                        default null,
    Weight                          integer                                                     default 0);

CREATE TABLE IF NOT EXISTS  
    Civilization_JFD_HeadsOfGovernment (    
    CivilizationType                text        REFERENCES Civilizations(Type)                  default null,
    CultureType                     text                                                        default null,
    HeadOfGovernmentName            text                                                        default null);

CREATE TABLE IF NOT EXISTS 
    Civilization_JFD_Titles (
    CivilizationType                text        REFERENCES Civilizations(Type)                  default null,
    CultureType                     text                                                        default null,
    ReligionType                    text        REFERENCES Religions(Type)                      default null,
    DefaultTitle                    text                                                        default null,
    UniqueTitle                     text                                                        default null,
    UseAdjective                    boolean                                                     default 0); 

CREATE TABLE IF NOT EXISTS 
    Civilization_JFD_Politics (
    CivilizationType                    text        REFERENCES Civilizations(Type)                  default null,
    PoliticsType                        text                                                        default null,
    UniqueName                          text                                                        default null);

CREATE TABLE IF NOT EXISTS 
    Civilization_JFD_Currencies (
    CivilizationType                text        REFERENCES Civilizations(Type)  default null,
    CurrencyType                    text                                        default null);

INSERT INTO Civilization_JFD_Governments
        (CivilizationType,          LegislatureName, OfficeTitle, GovernmentType, Weight)
SELECT  ('CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH'), LegislatureName, OfficeTitle, GovernmentType, Weight
FROM Civilization_JFD_Governments WHERE CivilizationType = 'CIVILIZATION_IROQUOIS';

INSERT INTO Civilization_JFD_HeadsOfGovernment
        (CivilizationType,          HeadOfGovernmentName)
SELECT  ('CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH'), HeadOfGovernmentName
FROM Civilization_JFD_HeadsOfGovernment WHERE CivilizationType = 'CIVILIZATION_IROQUOIS';

INSERT INTO Civilization_JFD_Titles
        (CivilizationType,          DefaultTitle,   UniqueTitle)
SELECT  ('CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH'), DefaultTitle,   UniqueTitle
FROM Civilization_JFD_Titles WHERE CivilizationType = 'CIVILIZATION_IROQUOIS';

INSERT INTO Civilization_JFD_Politics
        (CivilizationType,          PoliticsType, UniqueName)
SELECT  ('CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH'), PoliticsType, UniqueName
FROM Civilization_JFD_Politics WHERE CivilizationType = 'CIVILIZATION_IROQUOIS';

INSERT INTO Civilization_JFD_Currencies
        (CivilizationType,                  CurrencyType)
SELECT  'CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH', CurrencyType
FROM Civilization_JFD_Currencies WHERE CivilizationType = 'CIVILIZATION_IROQUOIS';  

INSERT OR REPLACE INTO Flavors 
        (Type)
VALUES  ('FLAVOR_JFD_REFORM_GOVERNMENT'),
        ('FLAVOR_JFD_REFORM_CULTURE'),
        ('FLAVOR_JFD_REFORM_ECONOMIC'),
        ('FLAVOR_JFD_REFORM_FOREIGN'),
        ('FLAVOR_JFD_REFORM_INDUSTRY'),
        ('FLAVOR_JFD_REFORM_MILITARY'),
        ('FLAVOR_JFD_REFORM_RELIGION');

INSERT INTO Leader_Flavors
        (LeaderType,							                          FlavorType,                         Flavor)
VALUES  ('LEADER_MISSISSIPPI_MOD_TOMATEKH',           'FLAVOR_JFD_REFORM_GOVERNMENT',                              6),
        ('LEADER_MISSISSIPPI_MOD_TOMATEKH',              'FLAVOR_JFD_REFORM_CULTURE',                              6),
        ('LEADER_MISSISSIPPI_MOD_TOMATEKH',             'FLAVOR_JFD_REFORM_ECONOMIC',                              3),
        ('LEADER_MISSISSIPPI_MOD_TOMATEKH',              'FLAVOR_JFD_REFORM_FOREIGN',                              6),
        ('LEADER_MISSISSIPPI_MOD_TOMATEKH',             'FLAVOR_JFD_REFORM_INDUSTRY',                              5),
        ('LEADER_MISSISSIPPI_MOD_TOMATEKH',             'FLAVOR_JFD_REFORM_RELIGION',                              5);

--Cultural Diversity
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes(
    CivilizationType                            text    REFERENCES Civilizations(Type)          default null,
    CultureType                                 text                                            default null,
    ArtDefineTag                                text                                            default null,
    DefeatScreenEarlyTag                        text                                            default null,
    DefeatScreenMidTag                          text                                            default null,
    DefeatScreenLateTag                         text                                            default null,
    IdealsTag                                   text                                            default null,
    SplashScreenTag                             text                                            default null,
    SoundtrackTag                               text                                            default null,
    UnitDialogueTag                             text                                            default null);
 
INSERT INTO Civilization_JFD_CultureTypes
        (CivilizationType, CultureType, ArtDefineTag, DefeatScreenEarlyTag, DefeatScreenMidTag, DefeatScreenLateTag, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT  ('CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH'),  CultureType, ArtDefineTag, DefeatScreenEarlyTag, DefeatScreenMidTag, DefeatScreenLateTag, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_IROQUOIS';

UPDATE Civilizations 
SET SoundtrackTag = 'JFD_Woodlands'
WHERE Type = 'CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Woodlands')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CULDIV_SOUNDTRACK_ADDON' AND Value = 1);

--Civ IV Traits
CREATE TABLE IF NOT EXISTS 
    Leader_SharedTraits (
    LeaderType          text    REFERENCES Leaders(Type)        default null,
    TraitOne            text    REFERENCES Policies(Type)       default null,
    TraitTwo            text    REFERENCES Policies(Type)       default null);
     
INSERT OR REPLACE INTO Leader_SharedTraits
			(LeaderType,									                           TraitOne,				   TraitTwo)
SELECT		('LEADER_MISSISSIPPI_MOD_TOMATEKH'),		                ('POLICY_PROTECTIVE_X'),	  ('POLICY_FINANCIAL_X')
WHERE EXISTS (SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');

UPDATE Leaders 
SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X' )
	THEN 'TXT_KEY_LEADER_MISSISSIPPI_MOD_TOMATEKH_DESC_MOD'
	ELSE 'TXT_KEY_LEADER_MISSISSIPPI_MOD_TOMATEKH_DESC' END) 
WHERE Type = 'LEADER_MISSISSIPPI_MOD_TOMATEKH';

CREATE TRIGGER CivIVTraitsMississippian
AFTER INSERT ON Leaders WHEN 'LEADER_MISSISSIPPI_MOD_TOMATEKH' = NEW.Type
BEGIN
	UPDATE Leaders 
	SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X' )
		THEN 'TXT_KEY_LEADER_MISSISSIPPI_MOD_TOMATEKH_DESC_MOD'
		ELSE 'TXT_KEY_LEADER_MISSISSIPPI_MOD_TOMATEKH_DESC' END) 
	WHERE Type = 'LEADER_MISSISSIPPI_MOD_TOMATEKH';
END;

--ExCE
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_ColonialCityNames (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	ColonyName 									text										default null,
	LinguisticType								text										default	null,
	CultureType									text										default	null);

INSERT OR REPLACE INTO Civilization_JFD_ColonialCityNames
			(CivilizationType, 						ColonyName,								LinguisticType)
VALUES		('CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH', 			          null,		           'JFD_NorthAmerican');

CREATE TABLE IF NOT EXISTS 
Civilization_JFD_RevolutionaryCivilizationsToSpawn (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	RevolutionaryCivilizationType 				text 	REFERENCES Civilizations(Type) 		default null);
	
INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,						RevolutionaryCivilizationType)
VALUES		('CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH',			  'CIVILIZATION_IROQUOIS');

--Mercenaries 
INSERT OR REPLACE INTO Flavors 
        (Type)
VALUES  ('FLAVOR_JFD_MERCENARY');

INSERT INTO Leader_Flavors
        (LeaderType,									                  FlavorType,                 Flavor)
VALUES  ('LEADER_MISSISSIPPI_MOD_TOMATEKH',                   'FLAVOR_JFD_MERCENARY',                      6);

--Cultural Developments
CREATE TABLE IF NOT EXISTS 
Events_CulturalDevelopments(
	CivilizationType		text  REFERENCES Civilizations(Type)	default null,
	CultureType				text									default null,
	Description				text									default null);

INSERT INTO Events_CulturalDevelopments 
			(Description,								                                           CivilizationType,						                   CultureType)
VALUES		('TXT_KEY_EVENT_CULDEV_TOMATEKH_MISSISSIPPI_01',			    'CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH',					                              null);

-- Civilizations_YagemStartPosition (Earth Giant)
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
			(Type,												 X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH',		   146,	   64,	    null,	null);	

CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource
			(Type, 										Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH'),			Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE Type = 'CIVILIZATION_IROQUOIS';

-- Civilizations_YahemStartPosition (Earth Huge)
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
			(Type,												X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH',		   24,	   55,		null,	null);

CREATE TABLE IF NOT EXISTS Civilizations_YahemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YahemRequestedResource
			(Type, 										Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH'),			Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE Type = 'CIVILIZATION_IROQUOIS';

-- Civilizations_CordiformStartPosition (Earth Standard)
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
			(Type,												X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH',		   13,	   35,	    null,	null);	

CREATE TABLE IF NOT EXISTS Civilizations_CordiformRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_CordiformRequestedResource
			(Type, 										Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH'),			Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_CordiformRequestedResource WHERE Type = 'CIVILIZATION_IROQUOIS';

-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
			(Type,												X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH',		   14,	   46,		null,	null);

CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_GreatestEarthRequestedResource
			(Type, 										Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH'),			Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_GreatestEarthRequestedResource WHERE Type = 'CIVILIZATION_IROQUOIS';

-- Civilizations_AmericasStartPosition (Americas)
CREATE TABLE IF NOT EXISTS Civilizations_AmericasStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AmericasStartPosition
			(TYPE,												X,      Y,		AltX,	AltY)
VALUES		('CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH',		   41,	   54,		null,	null);

CREATE TABLE IF NOT EXISTS Civilizations_AmericasRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AmericasRequestedResource
			(Type, 										Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH'),			Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AmericasRequestedResource WHERE Type = 'CIVILIZATION_IROQUOIS';

--CiD
--INSERT INTO Improvement_Yields
--		(ImprovementType, 									YieldType,					Yield)
--SELECT	'IMPROVEMENT_MISSISSIPPIAN_PLATFORM_MOD',			'YIELD_JFD_DEVELOPMENT',	10
--WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_DEVELOPMENT_CORE' AND Value = 1);
--
--CREATE TRIGGER MississippiDevelopmentPlatform
--AFTER INSERT ON Buildings WHEN 'BUILDING_JFD_DEVELOPMENT_DEFICIT_CRIME' = NEW.TYPE
--BEGIN
--
--	INSERT INTO Improvement_Yields
--			(ImprovementType, 									YieldType,					Yield)
--	SELECT	'IMPROVEMENT_MISSISSIPPIAN_PLATFORM_MOD',			'YIELD_JFD_DEVELOPMENT',	10
--	WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_DEVELOPMENT_CORE' AND Value = 1);
--
--END;





