--==========================================================================================================================
-- HAZEL MAP LABELS
--==========================================================================================================================
-- ML_CivCultures
------------------------------
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
        (CivType,                                           CultureType,            CultureEra)
VALUES  ('CIVILIZATION_DENEFIRSTNATION',    'TP_CANADIAN',        'ANY');
--=======================================================================================================================
-- BINGLES CIV IV TRAITS
--=======================================================================================================================
-- Leader_SharedTraits
------------------------------
CREATE TABLE IF NOT EXISTS
    Leader_SharedTraits (
    LeaderType          text    REFERENCES Leaders(TYPE)        DEFAULT NULL,
    TraitOne            text    REFERENCES Policies(TYPE)       DEFAULT NULL,
    TraitTwo            text    REFERENCES Policies(TYPE)       DEFAULT NULL);
     
INSERT INTO Leader_SharedTraits
       (LeaderType,                             TraitOne,                               TraitTwo)
VALUES ('LEADER_DENETHANADELTHUR',  'POLICY_SPIRITUAL_X',   'POLICY_PHILOSOPHICAL_X');
------------------------------
-- Leaders
------------------------------
UPDATE Leaders
SET Description = (CASE WHEN EXISTS(SELECT TYPE FROM Policies WHERE TYPE = 'POLICY_PHILOSOPHICAL_X')
        THEN 'Thanadelthur [ICON_PEACE][ICON_GREAT_PEOPLE]'
        ELSE 'TXT_KEY_LEADER_DENETHANADELTHUR' END)
WHERE TYPE = 'LEADER_DENETHANADELTHUR';
 
--==========================================================================================================================
-- GEDEMON's YNAEMP (+JFD's v24)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
                        (TYPE,                                                                          X,              Y,              AltX,   AltY)
VALUES          ('CIVILIZATION_DENEFIRSTNATION',                            135,             79,             NULL,   NULL);
 
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
                (TYPE,                                                  X,              Y)
VALUES  ('CIVILIZATION_DENEFIRSTNATION',            19,            65);
 
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
                (TYPE,                                                  X,              Y)
VALUES  ('CIVILIZATION_DENEFIRSTNATION',            17,             42);

CREATE TABLE IF NOT EXISTS Civilizations_AmericasStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_AmericasStartPosition
                (TYPE,                                                  X,              Y)
VALUES  ('CIVILIZATION_DENEFIRSTNATION',            35,             68);

CREATE TABLE IF NOT EXISTS Civilizations_AmericasGiantStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_AmericasGiantStartPosition
                (TYPE,                                                  X,              Y)
VALUES  ('CIVILIZATION_DENEFIRSTNATION',            34,             146);

CREATE TABLE IF NOT EXISTS Civilizations_NorthAmericaGiantStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthAmericaGiantStartPosition
                (TYPE,                                                  X,              Y)
VALUES  ('CIVILIZATION_DENEFIRSTNATION',            47,             91);

CREATE TABLE IF NOT EXISTS Civilizations_NorthAmericaHugeStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthAmericaHugeStartPosition
                (TYPE,                                                  X,              Y)
VALUES  ('CIVILIZATION_DENEFIRSTNATION',            55,             61);
 
-------------------------------------
-- Civilizations_YagemRequestedResource (Earth Giant)
-------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(TYPE, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource
                (TYPE,                                                  Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT  ('CIVILIZATION_DENEFIRSTNATION'),   Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE TYPE = 'CIVILIZATION_SWEDEN';

--==========================================================================================================================
-- JFD CIVILOPEDIA
--==========================================================================================================================
-- JFD_Civilopedia_HideFromPedia
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
JFD_Civilopedia_HideFromPedia (Type text default null);

INSERT INTO JFD_Civilopedia_HideFromPedia
		(Type)
VALUES	('BUILDING_MUSICTEMPLE'),
		('BUILDING_MUSICSHRINE');

--==========================================================================================================================
-- JFD's CULTURAL DIVERSITY
--==========================================================================================================================
-- Civilization_JFD_CultureTypes
-------------------------------------  
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes(
	CivilizationType 							text 	REFERENCES Civilizations(Type) 			default null,
	CultureType 								text											default null,
	ArtDefineTag								text											default	null,
	DefeatScreenEarlyTag						text											default	null,
	DefeatScreenMidTag							text											default	null,
	DefeatScreenLateTag							text											default	null,
	IdealsTag									text											default	null,
	SplashScreenTag								text											default	null,
	SoundtrackTag								text											default	null,
	UnitDialogueTag								text											default null);

INSERT INTO Civilization_JFD_CultureTypes
        (CivilizationType,						ArtDefineTag,	CultureType,	IdealsTag,		SplashScreenTag,	SoundtrackTag,	UnitDialogueTag)
VALUES  ('CIVILIZATION_DENEFIRSTNATION',        'JFD_Polar',    'JFD_Polar',	'JFD_Polar',	'JFD_Polar',	    'JFD_Polar',	'AS2D_SOUND_JFD_NATIVE_AMERICAN');
 
 
--==========================================================================================================================
-- JFD's EXPLORATION CONTINUED EXPANDED
--==========================================================================================================================
-- Civilization_JFD_ColonialCityNames
------------------------------------------------------------  
CREATE TABLE IF NOT EXISTS
Civilization_JFD_ColonialCityNames (
        CivilizationType                                                        text    REFERENCES Civilizations(TYPE)          DEFAULT NULL,
        ColonyName                                                                      text                                                                            DEFAULT NULL,
        LinguisticType                                                          text                                                                            DEFAULT NULL,
        CultureType                                                                     text                                                                            DEFAULT NULL);
 
INSERT INTO Civilization_JFD_ColonialCityNames
                (CivilizationType,                                              ColonyName,                                                             LinguisticType)
VALUES          ('CIVILIZATION_DENEFIRSTNATION',                       NULL,                                                                   'JFD_NorthAmerican');
 
/*INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
                (CivilizationType,                                              RevolutionaryCivilizationType)
SELECT  ('CIVILIZATION_DENEFIRSTNATION),      ('CIVILIZATION_CLINUIT')
WHERE EXISTS (SELECT TYPE FROM Civilizations WHERE TYPE = 'CIVILIZATION_CLINUIT')*/
 
INSERT INTO Unit_FreePromotions
               (UnitType,                              PromotionType)
SELECT  ('UNIT_DENEDRUMMER'),  ('PROMOTION_JFD_SNOW_IMMUNITY')
WHERE EXISTS (SELECT TYPE FROM UnitPromotions WHERE TYPE = 'PROMOTION_JFD_SNOW_IMMUNITY');
--==========================================================================================================================  
-- JFD's AND Pouakai's MERCENARIES
--==========================================================================================================================
-- Flavors
------------------------------------------------------------  
INSERT OR REPLACE INTO Flavors
               (TYPE)
VALUES  ('FLAVOR_JFD_MERCENARY');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------  
INSERT INTO Leader_Flavors
               (LeaderType,                            FlavorType,                                     Flavor)
VALUES  ('LEADER_DENETHANADELTHUR', 'FLAVOR_JFD_MERCENARY',         4);
--==========================================================================================================================  
-- JFD's PIETY
--==========================================================================================================================  
-- Flavors
------------------------------------------------------------  
INSERT OR REPLACE INTO Flavors
                (TYPE)
VALUES  ('FLAVOR_JFD_RELIGIOUS_INTOLERANCE');
------------------------------------------------------------
-- Leader_Flavors
 
INSERT INTO Leader_Flavors
                (LeaderType,                    FlavorType,                                                             Flavor)
VALUES  ('LEADER_DENETHANADELTHUR', 'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',             4);
--==========================================================================================================================  
-- JFD's SOVEREIGNTY
--==========================================================================================================================
------------------------------------------------------------
-- Flavors
------------------------------------------------------------  
INSERT OR REPLACE INTO Flavors
                (TYPE)
VALUES  ('FLAVOR_JFD_REFORM_GOVERNMENT'),
                ('FLAVOR_JFD_REFORM_CULTURE'),
                ('FLAVOR_JFD_REFORM_ECONOMIC'),
                ('FLAVOR_JFD_REFORM_FOREIGN'),
                ('FLAVOR_JFD_REFORM_INDUSTRY'),
                ('FLAVOR_JFD_REFORM_MILITARY'),
                ('FLAVOR_JFD_REFORM_RELIGION');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------  
--Each flavour corresponds to one of the seven Reform Categories, and how likely a civ is to take a reform in either the Right, Centre, or Left column.
--A value of 1-3 will favour Left Reforms. A value of 4-6 will value Centre Reforms. A value of 7-10 will value Right Reforms. The strength of the value will determine how soon a Leader will implement that Reform.
INSERT INTO Leader_Flavors
                (LeaderType,              FlavorType,                                                     Flavor)
VALUES  		('LEADER_DENETHANADELTHUR', 'FLAVOR_JFD_REFORM_GOVERNMENT',         2),
                ('LEADER_DENETHANADELTHUR', 'FLAVOR_JFD_REFORM_CULTURE',            5),
                ('LEADER_DENETHANADELTHUR', 'FLAVOR_JFD_REFORM_ECONOMIC',           5),
                ('LEADER_DENETHANADELTHUR', 'FLAVOR_JFD_REFORM_FOREIGN',            7),
                ('LEADER_DENETHANADELTHUR', 'FLAVOR_JFD_REFORM_INDUSTRY',           5),
                ('LEADER_DENETHANADELTHUR', 'FLAVOR_JFD_REFORM_RELIGION',           4);
--==========================================================================================================================          
--==========================================================================================================================
-- Historical Religions
--==========================================================================================================================
