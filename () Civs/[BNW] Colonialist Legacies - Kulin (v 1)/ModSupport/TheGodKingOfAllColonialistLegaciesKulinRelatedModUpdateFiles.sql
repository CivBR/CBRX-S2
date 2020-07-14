--==========================================================================================================================
-- HAZEL MAP LABELS
--==========================================================================================================================
-- ML_CivCultures
------------------------------ 
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
                (CivType,                                                               CultureType,            CultureEra)
VALUES  ('CIVILIZATION_CL_KULIN',       'TP_AUSTRALIAN',        'ANY');
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
VALUES ('LEADER_CL_BARAK',      'POLICY_PHILOSOPHICAL_X',       'POLICY_CREATIVE_X');
------------------------------ 
-- Leaders
------------------------------ 
UPDATE Leaders
SET Description = (CASE WHEN EXISTS(SELECT TYPE FROM Policies WHERE TYPE = 'POLICY_PHILOSOPHICAL_X')
        THEN 'William Barak [ICON_GREAT_PEOPLE][ICON_CULTURE]'
        ELSE 'TXT_KEY_LEADER_CL_BARAK' END)
WHERE TYPE = 'LEADER_CL_BARAK';
 
--==========================================================================================================================
-- Historical Religions
--==========================================================================================================================
 
--==========================================================================================================================
-- GEDEMON's YNAEMP (+JFD's v23)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
                        (TYPE,                                                                          X,              Y,              AltX,   AltY)
VALUES          ('CIVILIZATION_CL_KULIN',                               100,             9,             NULL,   NULL);
 
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
                (TYPE,                                                  X,              Y)
VALUES  ('CIVILIZATION_CL_KULIN',               117,            10);
 
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
                (TYPE,                                                  X,              Y)
VALUES  ('CIVILIZATION_CL_KULIN',               75,             7);
-------------------------------------
-- Civilizations_YagemRequestedResource (Earth Giant)
-------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(TYPE, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource
                (TYPE,                                                  Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT  ('CIVILIZATION_CL_KULIN'),      Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE TYPE = 'CIVILIZATION_IROQUOIS';
--==========================================================================================================================
-- JFD's CULTURAL DIVERSITY
--==========================================================================================================================
-- Civilization_JFD_CultureTypes
-------------------------------------  
CREATE TABLE IF NOT EXISTS
Civilization_JFD_CultureTypes(
        CivilizationType                                                        text    REFERENCES Civilizations(TYPE)                  DEFAULT NULL,
        CultureType                                                             text                                                                                    DEFAULT NULL,
        ArtDefineTag                                                            text                                                                                    DEFAULT NULL,
        SplashScreenTag                                                         text                                                                                    DEFAULT NULL,
        SoundtrackTag                                                           text                                                                                    DEFAULT NULL,
        UnitDialogueTag                                                         text                                                                                    DEFAULT NULL);
 
INSERT INTO Civilization_JFD_CultureTypes
                (CivilizationType,                                              CultureType,                    SplashScreenTag,                SoundtrackTag,          UnitDialogueTag)
VALUES  ('CIVILIZATION_CL_KULIN',   'JFD_Sahul',    'JFD_Sahul',    'JFD_Sahul',    'AS2D_SOUND_JFD_NATIVE_AMERICAN');
 
 
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
VALUES          ('CIVILIZATION_CL_KULIN',                       NULL,                                                                   'JFD_Austronesian');
 
INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
                (CivilizationType,                                              RevolutionaryCivilizationType)
SELECT  ('CIVILIZATION_CL_KULIN'),      ('CIVILIZATION_CL_AUSTRALIA')
WHERE EXISTS (SELECT TYPE FROM Civilizations WHERE TYPE = 'CIVILIZATION_CL_AUSTRALIA');
 
--==========================================================================================================================   
-- JFD's and Pouakai's MERCENARIES
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
VALUES  ('LEADER_CL_BARAK',     'FLAVOR_JFD_MERCENARY',         8);
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
VALUES  ('LEADER_CL_BARAK',     'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',             7);
--==========================================================================================================================   
-- JFD's SOVEREIGNTY
--==========================================================================================================================
-- Civilization_JFD_Governments
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS
        Civilization_JFD_Governments (
        CivilizationType                                text            REFERENCES Civilizations(TYPE)                                  DEFAULT NULL,
        CultureType                                             text                                                                                                            DEFAULT NULL,
        LegislatureName                                 text                                                                                                            DEFAULT NULL,
        OfficeTitle                                             text                                                                                                            DEFAULT NULL,
        GovernmentType                                  text                                                                                                            DEFAULT NULL,
        Weight                                                  INTEGER                                                                                                         DEFAULT 0);
 
INSERT INTO Civilization_JFD_Governments
                (CivilizationType,                                      LegislatureName,                                                                        OfficeTitle,                                                                                            GovernmentType,                         Weight)
VALUES  ('CIVILIZATION_CL_KULIN',       'TXT_KEY_JFD_LEGISLATURE_NAME_CIVILIZATION_CL_KULIN',   'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_CL_KULIN',   'GOVERNMENT_JFD_REPUBLIC',      70);
------------------------------------------------------------
-- Civilization_JFD_Titles
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS
        Civilization_JFD_Titles (
        CivilizationType                                text            REFERENCES Civilizations(TYPE)                                  DEFAULT NULL,
        CultureType                                             text                                                                                                            DEFAULT NULL,
        ReligionType                                    text            REFERENCES Religions(TYPE)                                              DEFAULT NULL,
        DefaultTitle                                    text                                                                                                            DEFAULT NULL,
        UniqueTitle                                             text                                                                                                            DEFAULT NULL,
        UseAdjective                                    BOOLEAN                                                                                                         DEFAULT 0);    
 
INSERT INTO Civilization_JFD_Titles
        (CivilizationType,                  DefaultTitle,                                   UniqueTitle)
VALUES  ('CIVILIZATION_CL_KULIN',   'TXT_KEY_GOVERNMENT_JFD_TRIBE_TITLE_LEADER',    'TXT_KEY_GOVERNMENT_JFD_TRIBE_TITLE_LEADER _KULIN');
------------------------------------------------------------   
-- Civilization_JFD_HeadsOfGovernment  
------------------------------------------------------------   
CREATE TABLE IF NOT EXISTS      
        Civilization_JFD_HeadsOfGovernment (   
        CivilizationType                                text            REFERENCES Civilizations(TYPE)                                  DEFAULT NULL,
        CultureType                                             text                                                                                                            DEFAULT NULL,
        HeadOfGovernmentName                    text                                                                                                            DEFAULT NULL);
 
 
INSERT INTO Civilization_JFD_HeadsOfGovernment
        (CivilizationType,                                      HeadOfGovernmentName)
VALUES  ('CIVILIZATION_CL_KULIN',               'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_KULIN_1'),
        ('CIVILIZATION_CL_KULIN',               'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_KULIN_2'),
        ('CIVILIZATION_CL_KULIN',               'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_KULIN_3'),
        ('CIVILIZATION_CL_KULIN',               'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_KULIN_4'),
        ('CIVILIZATION_CL_KULIN',               'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_KULIN_5'),
        ('CIVILIZATION_CL_KULIN',               'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_KULIN_6'),
        ('CIVILIZATION_CL_KULIN',               'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_KULIN_7'),
        ('CIVILIZATION_CL_KULIN',               'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_KULIN_8');
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
                (LeaderType,                    FlavorType,                                                     Flavor)
VALUES  ('LEADER_CL_BARAK',    'FLAVOR_JFD_REFORM_GOVERNMENT',         5),
                ('LEADER_CL_BARAK',     'FLAVOR_JFD_REFORM_CULTURE',            4),
                ('LEADER_CL_BARAK',     'FLAVOR_JFD_REFORM_ECONOMIC',           2),
                ('LEADER_CL_BARAK',     'FLAVOR_JFD_REFORM_FOREIGN',            1),
                ('LEADER_CL_BARAK',     'FLAVOR_JFD_REFORM_INDUSTRY',           4),
                ('LEADER_CL_BARAK',     'FLAVOR_JFD_REFORM_RELIGION',           8);
--==========================================================================================================================           
--==========================================================================================================================