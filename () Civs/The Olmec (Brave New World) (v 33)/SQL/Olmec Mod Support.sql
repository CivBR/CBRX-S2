INSERT INTO IconTextureAtlases 
		(Atlas, 						  IconSize, 	                  Filename, 	IconsPerRow, 	IconsPerColumn)
VALUES	('OLMEC_PROMOTION_ATLAS_MOD', 		   256, 	   'OlmecPromotion256.dds',				  2, 				 1),
		('OLMEC_PROMOTION_ATLAS_MOD', 			64, 	    'OlmecPromotion64.dds',				  2, 				 1),
		('OLMEC_PROMOTION_ATLAS_MOD', 			45, 	    'OlmecPromotion45.dds',				  2, 				 1),
		('OLMEC_PROMOTION_ATLAS_MOD', 			32, 	    'OlmecPromotion32.dds',				  2, 				 1);

--Decisions
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('LeugiOlmecDecisions.lua');

CREATE TABLE IF NOT EXISTS EventsAddin_Support(FileName);
INSERT INTO EventsAddin_Support (FileName) VALUES ('LeugiOlmecEvents.lua');

--Cultural Developments
CREATE TABLE IF NOT EXISTS 
Events_CulturalDevelopments(
	CivilizationType		text  REFERENCES Civilizations(Type)	default null,
	CultureType				text									default null,
	Description				text									default null);

INSERT INTO Events_CulturalDevelopments 
			(Description,								                      CivilizationType,						   CultureType)
VALUES		('TXT_KEY_EVENT_CULDEV_TOMATEKH_OLMEC_01',			    'CIVILIZATION_LEUGI_OLMEC',					'JFD_Mesoamerican');

--Ethnic Units
UPDATE Civilizations SET ArtStyleSuffix = 
	( CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = "_MAYA")
		THEN "_MAYA"
		ELSE "_AMER" END
	) WHERE Type = "CIVILIZATION_LEUGI_OLMEC";

--Map Labels
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
			(CivType,									  CultureType,	CultureEra)
VALUES		('CIVILIZATION_LEUGI_OLMEC',       'MOD_TP_MESO_AMERICAN',	  'MODERN');

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
            (LeaderType,									       FlavorType,    Flavor)
VALUES      ('LEADER_LEUGI_U_KIX_CHAN',    'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',         8);

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
SELECT  ('CIVILIZATION_LEUGI_OLMEC'), LegislatureName, OfficeTitle, GovernmentType, Weight
FROM Civilization_JFD_Governments WHERE CivilizationType = 'CIVILIZATION_MAYA';

INSERT INTO Civilization_JFD_HeadsOfGovernment
        (CivilizationType,          HeadOfGovernmentName)
SELECT  ('CIVILIZATION_LEUGI_OLMEC'), HeadOfGovernmentName
FROM Civilization_JFD_HeadsOfGovernment WHERE CivilizationType = 'CIVILIZATION_MAYA';

INSERT INTO Civilization_JFD_Titles
        (CivilizationType,          DefaultTitle,   UniqueTitle)
SELECT  ('CIVILIZATION_LEUGI_OLMEC'), DefaultTitle,   UniqueTitle
FROM Civilization_JFD_Titles WHERE CivilizationType = 'CIVILIZATION_MAYA';

INSERT INTO Civilization_JFD_Politics
        (CivilizationType,          PoliticsType, UniqueName)
SELECT  ('CIVILIZATION_LEUGI_OLMEC'), PoliticsType, UniqueName
FROM Civilization_JFD_Politics WHERE CivilizationType = 'CIVILIZATION_MAYA';

INSERT INTO Civilization_JFD_Currencies
        (CivilizationType,                  CurrencyType)
SELECT  'CIVILIZATION_LEUGI_OLMEC', CurrencyType
FROM Civilization_JFD_Currencies WHERE CivilizationType = 'CIVILIZATION_MAYA';  

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
        (LeaderType,							           FlavorType,                         Flavor)
VALUES  ('LEADER_LEUGI_U_KIX_CHAN',    'FLAVOR_JFD_REFORM_GOVERNMENT',                              8),
        ('LEADER_LEUGI_U_KIX_CHAN',       'FLAVOR_JFD_REFORM_CULTURE',                              5),
        ('LEADER_LEUGI_U_KIX_CHAN',      'FLAVOR_JFD_REFORM_ECONOMIC',                              2),
        ('LEADER_LEUGI_U_KIX_CHAN',       'FLAVOR_JFD_REFORM_FOREIGN',                              2),
        ('LEADER_LEUGI_U_KIX_CHAN',      'FLAVOR_JFD_REFORM_INDUSTRY',                              5),
        ('LEADER_LEUGI_U_KIX_CHAN',      'FLAVOR_JFD_REFORM_RELIGION',                              8);

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
SELECT  ('CIVILIZATION_LEUGI_OLMEC'),  CultureType, ArtDefineTag, DefeatScreenEarlyTag, DefeatScreenMidTag, DefeatScreenLateTag, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_MAYA';

UPDATE Civilizations 
SET SoundtrackTag = 'JFD_Mesoamerican'
WHERE Type = 'CIVILIZATION_LEUGI_OLMEC'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Mesoamerican')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CULDIV_SOUNDTRACK_ADDON' AND Value = 1);

--Mercenaries 
INSERT OR REPLACE INTO Flavors 
        (Type)
VALUES  ('FLAVOR_JFD_MERCENARY');

INSERT INTO Leader_Flavors
        (LeaderType,									 FlavorType,                 Flavor)
VALUES  ('LEADER_LEUGI_U_KIX_CHAN',          'FLAVOR_JFD_MERCENARY',                      4);

--Civ IV Traits
CREATE TABLE IF NOT EXISTS 
    Leader_SharedTraits (
    LeaderType          text    REFERENCES Leaders(Type)        default null,
    TraitOne            text    REFERENCES Policies(Type)       default null,
    TraitTwo            text    REFERENCES Policies(Type)       default null);
     
INSERT OR REPLACE INTO Leader_SharedTraits
			(LeaderType,									          TraitOne,					    TraitTwo)
SELECT		('LEADER_LEUGI_U_KIX_CHAN'),	            ('POLICY_INVENTIVE_X'),	   ('POLICY_PHILOSOPHICAL_X')
WHERE EXISTS (SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');

UPDATE Leaders 
SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X' )
	THEN 'TXT_KEY_OLMEC_LEADER_CIV_IV_TRAITS'
	ELSE 'TXT_KEY_LEADER_LEUGI_U_KIX_CHAN_DESC' END) 
WHERE Type = 'LEADER_LEUGI_U_KIX_CHAN';

CREATE TRIGGER CivIVTraitsLeugiOlmec
AFTER INSERT ON Leaders WHEN 'LEADER_LEUGI_U_KIX_CHAN' = NEW.Type
BEGIN
	UPDATE Leaders 
	SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X' )
		THEN 'TXT_KEY_OLMEC_LEADER_CIV_IV_TRAITS'
		ELSE 'TXT_KEY_LEADER_LEUGI_U_KIX_CHAN_DESC' END) 
	WHERE Type = 'LEADER_LEUGI_U_KIX_CHAN';
END;	

--ExCE
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_ColonialCityNames (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	ColonyName 									text										default null,
	LinguisticType								text										default	null,
	CultureType									text										default	null);

INSERT OR REPLACE INTO Civilization_JFD_ColonialCityNames
			(CivilizationType, 						ColonyName,								    LinguisticType)
VALUES		('CIVILIZATION_LEUGI_OLMEC', 			null,									'JFD_Mesoamerican');

CREATE TABLE IF NOT EXISTS 
Civilization_JFD_RevolutionaryCivilizationsToSpawn (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	RevolutionaryCivilizationType 				text 	REFERENCES Civilizations(Type) 		default null);
	
INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,				RevolutionaryCivilizationType)
VALUES		('CIVILIZATION_LEUGI_OLMEC',	         'CIVILIZATION_AZTEC'),
			('CIVILIZATION_LEUGI_OLMEC',	          'CIVILIZATION_MAYA');

--Other
INSERT INTO Unit_Builds
		   (UnitType,											   BuildType)
SELECT	   ('UNIT_JFD_GREAT_DIGNITARY'),	   ('BUILD_LEUGI_COLOSSAL_HEADS')
WHERE EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_JFD_GREAT_DIGNITARY');

INSERT INTO Unit_Builds
		   (UnitType,											    BuildType)
SELECT	   ('UNIT_JFD_GREAT_MAGISTRATE'),	    ('BUILD_LEUGI_COLOSSAL_HEADS')
WHERE EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_JFD_GREAT_MAGISTRATE');

INSERT INTO Unit_Builds
		   (UnitType,											    BuildType)
SELECT	   ('UNIT_POVERTY_POINT_MOD'),	    ('BUILD_LEUGI_COLOSSAL_HEADS')
WHERE EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_POVERTY_POINT_MOD');

INSERT INTO Unit_Builds
		   (UnitType,											    BuildType)
SELECT	   ('UNIT_TOMATEKH_SPY'),	    ('BUILD_LEUGI_COLOSSAL_HEADS')
WHERE EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_TOMATEKH_SPY');

CREATE TRIGGER GreatDignitaryHead
AFTER INSERT ON Units WHEN 'UNIT_JFD_GREAT_DIGNITARY' = NEW.Type
BEGIN
	INSERT INTO Unit_Builds
			   (UnitType,											   BuildType)
	SELECT	   ('UNIT_JFD_GREAT_DIGNITARY'),	   ('BUILD_LEUGI_COLOSSAL_HEADS')
	WHERE EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_JFD_GREAT_DIGNITARY');
END;

CREATE TRIGGER GreatMagistrateHead
AFTER INSERT ON Units WHEN 'UNIT_JFD_GREAT_MAGISTRATE' = NEW.Type
BEGIN
	INSERT INTO Unit_Builds
			   (UnitType,											    BuildType)
	SELECT	   ('UNIT_JFD_GREAT_MAGISTRATE'),	    ('BUILD_LEUGI_COLOSSAL_HEADS')
	WHERE EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_JFD_GREAT_MAGISTRATE');
END;

CREATE TRIGGER GreatPPHead
AFTER INSERT ON Units WHEN 'UNIT_POVERTY_POINT_MOD' = NEW.Type
BEGIN
	INSERT INTO Unit_Builds
			   (UnitType,											    BuildType)
	SELECT	   ('UNIT_POVERTY_POINT_MOD'),	    ('BUILD_LEUGI_COLOSSAL_HEADS')
	WHERE EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_POVERTY_POINT_MOD');
END;

CREATE TRIGGER GreatSpyHead
AFTER INSERT ON Units WHEN 'UNIT_TOMATEKH_SPY' = NEW.Type
BEGIN
	INSERT INTO Unit_Builds
			   (UnitType,											    BuildType)
	SELECT	   ('UNIT_TOMATEKH_SPY'),	    ('BUILD_LEUGI_COLOSSAL_HEADS')
	WHERE EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_TOMATEKH_SPY');
END;

--Doctor
INSERT INTO Unit_Builds
		   (UnitType,											BuildType)
SELECT	   ('UNIT_JFD_GREAT_DOCTOR'),	    ('BUILD_LEUGI_COLOSSAL_HEADS')
WHERE EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_JFD_GREAT_DOCTOR');

INSERT INTO Improvements 
		(Type,												      Description,                            Civilopedia,									     Help,		  GraphicalOnly,	      BuildableOnResources,         PillageGold,        CreatedByGreatPerson,                                   ArtDefineTag,			   PortraitIndex,			     IconAtlas)
SELECT	('IMPROVEMENT_LEUGI_DOCTOR_HEAD'),   ('TXT_KEY_LEUGI_COLOSSAL_HEADS'),	('TXT_KEY_LEUGI_COLOSSAL_HEADS_TEXT'),		('TXT_KEY_LEUGI_COLOSSAL_HEADS_HELP'),		            (1),                           (1),                (20),                         (1),   ('ART_DEF_IMPROVEMENT_OLMEC_COLOSSAL_HEADS'),                        (3),	    ('OLMEC_ATLAS_MOD')
WHERE EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_JFD_GREAT_DOCTOR');

INSERT INTO Improvement_Yields 
		(ImprovementType,							       YieldType,		       Yield)
SELECT	('IMPROVEMENT_LEUGI_DOCTOR_HEAD'),          ('YIELD_SCIENCE'),                (4)
WHERE EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_JFD_GREAT_DOCTOR');

INSERT INTO Improvement_Yields 
		(ImprovementType,							           YieldType,		       Yield)
SELECT	('IMPROVEMENT_LEUGI_DOCTOR_HEAD'),          ('YIELD_JFD_HEALTH'),                 (2)
WHERE EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_JFD_GREAT_DOCTOR');

INSERT INTO Policy_ImprovementYieldChanges 
		(PolicyType,                                  ImprovementType,					YieldType,		        Yield)
SELECT	('POLICY_NEW_DEAL'),		('IMPROVEMENT_LEUGI_DOCTOR_HEAD'),          ('YIELD_SCIENCE'),                 (2)
WHERE EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_JFD_GREAT_DOCTOR');

INSERT INTO Policy_ImprovementYieldChanges 
		(PolicyType,                                  ImprovementType,					   YieldType,		       Yield)
SELECT	('POLICY_NEW_DEAL'),		('IMPROVEMENT_LEUGI_DOCTOR_HEAD'),          ('YIELD_JFD_HEALTH'),                 (2)
WHERE EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_JFD_GREAT_DOCTOR');

INSERT INTO Trait_ImprovementYieldChanges 
		(TraitType,                                           ImprovementType,					YieldType,		        Yield)
SELECT	('TRAIT_SCHOLARS_JADE_HALL'),		('IMPROVEMENT_LEUGI_DOCTOR_HEAD'),          ('YIELD_SCIENCE'),                 (2)
WHERE EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_JFD_GREAT_DOCTOR');

CREATE TRIGGER GreatDoctorHead
AFTER INSERT ON Units WHEN 'UNIT_JFD_GREAT_DOCTOR' = NEW.Type
BEGIN
	INSERT INTO Unit_Builds
			   (UnitType,											BuildType)
	SELECT	   ('UNIT_JFD_GREAT_DOCTOR'),	    ('BUILD_LEUGI_COLOSSAL_HEADS')
	WHERE EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_JFD_GREAT_DOCTOR');

	INSERT INTO Improvements 
			(Type,												      Description,                            Civilopedia,									     Help,		  GraphicalOnly,	      BuildableOnResources,         PillageGold,        CreatedByGreatPerson,                                   ArtDefineTag,			   PortraitIndex,			     IconAtlas)
	SELECT	('IMPROVEMENT_LEUGI_DOCTOR_HEAD'),   ('TXT_KEY_LEUGI_COLOSSAL_HEADS'),	('TXT_KEY_LEUGI_COLOSSAL_HEADS_TEXT'),		('TXT_KEY_LEUGI_COLOSSAL_HEADS_HELP'),		            (1),                           (1),                (20),                         (1),   ('ART_DEF_IMPROVEMENT_OLMEC_COLOSSAL_HEADS'),                        (3),	    ('OLMEC_ATLAS_MOD')
	WHERE EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_JFD_GREAT_DOCTOR');

	INSERT INTO Improvement_Yields 
			(ImprovementType,							       YieldType,		       Yield)
	SELECT	('IMPROVEMENT_LEUGI_DOCTOR_HEAD'),          ('YIELD_SCIENCE'),                (4)
	WHERE EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_JFD_GREAT_DOCTOR');

	INSERT INTO Improvement_Yields 
			(ImprovementType,							           YieldType,		       Yield)
	SELECT	('IMPROVEMENT_LEUGI_DOCTOR_HEAD'),          ('YIELD_JFD_HEALTH'),                 (2)
	WHERE EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_JFD_GREAT_DOCTOR');

	INSERT INTO Policy_ImprovementYieldChanges 
			(PolicyType,                                  ImprovementType,					YieldType,		        Yield)
	SELECT	('POLICY_NEW_DEAL'),		('IMPROVEMENT_LEUGI_DOCTOR_HEAD'),          ('YIELD_SCIENCE'),                 (2)
	WHERE EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_JFD_GREAT_DOCTOR');

	INSERT INTO Policy_ImprovementYieldChanges 
			(PolicyType,                                  ImprovementType,					   YieldType,		       Yield)
	SELECT	('POLICY_NEW_DEAL'),		('IMPROVEMENT_LEUGI_DOCTOR_HEAD'),          ('YIELD_JFD_HEALTH'),                 (2)
	WHERE EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_JFD_GREAT_DOCTOR');

	INSERT INTO Trait_ImprovementYieldChanges 
			(TraitType,                                           ImprovementType,					YieldType,		        Yield)
	SELECT	('TRAIT_SCHOLARS_JADE_HALL'),		('IMPROVEMENT_LEUGI_DOCTOR_HEAD'),          ('YIELD_SCIENCE'),                 (2)
	WHERE EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_JFD_GREAT_DOCTOR');
END;

--Entertainer
INSERT INTO Unit_Builds
		   (UnitType,											BuildType)
SELECT	   ('UNIT_ENTERTAINER'),	    ('BUILD_LEUGI_COLOSSAL_HEADS')
WHERE EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_ENTERTAINER');

INSERT INTO Improvements 
		(Type,												           Description,                           Civilopedia,									     Help,		  GraphicalOnly,	      BuildableOnResources,         PillageGold,        CreatedByGreatPerson,                                   ArtDefineTag,			   PortraitIndex,			     IconAtlas)
SELECT	('IMPROVEMENT_LEUGI_ENTERTAINER_HEAD'),   ('TXT_KEY_LEUGI_COLOSSAL_HEADS'),	('TXT_KEY_LEUGI_COLOSSAL_HEADS_TEXT'),		('TXT_KEY_LEUGI_COLOSSAL_HEADS_HELP'),		            (1),                           (1),                (20),                         (1),   ('ART_DEF_IMPROVEMENT_OLMEC_COLOSSAL_HEADS'),                        (3),	    ('OLMEC_ATLAS_MOD')
WHERE EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_ENTERTAINER');

INSERT INTO Improvement_Yields 
		(ImprovementType,							       YieldType,		       Yield)
SELECT	('IMPROVEMENT_LEUGI_ENTERTAINER_HEAD'),     ('YIELD_SCIENCE'),                (4)
WHERE EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_ENTERTAINER');

INSERT INTO Improvement_Yields 
		(ImprovementType,							          YieldType,		      Yield)
SELECT	('IMPROVEMENT_LEUGI_ENTERTAINER_HEAD'),       ('YIELD_TOURISM'),                 (2)
WHERE EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_ENTERTAINER');

INSERT INTO Policy_ImprovementYieldChanges 
		(PolicyType,                                       ImprovementType,					 YieldType,		         Yield)
SELECT	('POLICY_NEW_DEAL'),		('IMPROVEMENT_LEUGI_ENTERTAINER_HEAD'),          ('YIELD_SCIENCE'),                 (2)
WHERE EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_ENTERTAINER');

INSERT INTO Policy_ImprovementYieldChanges 
		(PolicyType,                                       ImprovementType,					 YieldType,		         Yield)
SELECT	('POLICY_NEW_DEAL'),		('IMPROVEMENT_LEUGI_ENTERTAINER_HEAD'),          ('YIELD_TOURISM'),                 (2)
WHERE EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_ENTERTAINER');

INSERT INTO Trait_ImprovementYieldChanges 
		(TraitType,                                                ImprovementType,					 YieldType,		         Yield)
SELECT	('TRAIT_SCHOLARS_JADE_HALL'),		('IMPROVEMENT_LEUGI_ENTERTAINER_HEAD'),          ('YIELD_SCIENCE'),                 (2)
WHERE EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_ENTERTAINER');

CREATE TRIGGER GreatEntertainerHead
AFTER INSERT ON Units WHEN 'UNIT_ENTERTAINER' = NEW.Type
BEGIN
	INSERT INTO Unit_Builds
			   (UnitType,											BuildType)
	SELECT	   ('UNIT_ENTERTAINER'),	    ('BUILD_LEUGI_COLOSSAL_HEADS')
	WHERE EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_ENTERTAINER');

	INSERT INTO Improvements 
			(Type,												           Description,                           Civilopedia,									     Help,		  GraphicalOnly,	      BuildableOnResources,         PillageGold,        CreatedByGreatPerson,                                   ArtDefineTag,			   PortraitIndex,			     IconAtlas)
	SELECT	('IMPROVEMENT_LEUGI_ENTERTAINER_HEAD'),   ('TXT_KEY_LEUGI_COLOSSAL_HEADS'),	('TXT_KEY_LEUGI_COLOSSAL_HEADS_TEXT'),		('TXT_KEY_LEUGI_COLOSSAL_HEADS_HELP'),		            (1),                           (1),                (20),                         (1),   ('ART_DEF_IMPROVEMENT_OLMEC_COLOSSAL_HEADS'),                        (3),	    ('OLMEC_ATLAS_MOD')
	WHERE EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_ENTERTAINER');

	INSERT INTO Improvement_Yields 
			(ImprovementType,							       YieldType,		       Yield)
	SELECT	('IMPROVEMENT_LEUGI_ENTERTAINER_HEAD'),     ('YIELD_SCIENCE'),                (4)
	WHERE EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_ENTERTAINER');

	INSERT INTO Improvement_Yields 
			(ImprovementType,							          YieldType,		      Yield)
	SELECT	('IMPROVEMENT_LEUGI_ENTERTAINER_HEAD'),       ('YIELD_TOURISM'),                 (2)
	WHERE EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_ENTERTAINER');

	INSERT INTO Policy_ImprovementYieldChanges 
			(PolicyType,                                       ImprovementType,					 YieldType,		         Yield)
	SELECT	('POLICY_NEW_DEAL'),		('IMPROVEMENT_LEUGI_ENTERTAINER_HEAD'),          ('YIELD_SCIENCE'),                 (2)
	WHERE EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_ENTERTAINER');

	INSERT INTO Policy_ImprovementYieldChanges 
			(PolicyType,                                       ImprovementType,					 YieldType,		         Yield)
	SELECT	('POLICY_NEW_DEAL'),		('IMPROVEMENT_LEUGI_ENTERTAINER_HEAD'),          ('YIELD_TOURISM'),                 (2)
	WHERE EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_ENTERTAINER');

	INSERT INTO Trait_ImprovementYieldChanges 
			(TraitType,                                                ImprovementType,					 YieldType,		         Yield)
	SELECT	('TRAIT_SCHOLARS_JADE_HALL'),		('IMPROVEMENT_LEUGI_ENTERTAINER_HEAD'),          ('YIELD_SCIENCE'),                 (2)
	WHERE EXISTS (SELECT Type FROM Units WHERE Type = 'UNIT_ENTERTAINER');
END;








