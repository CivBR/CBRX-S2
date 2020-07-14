--==========================================================================================================================
-- USER SETTINGS (THIS IS NEEDED IN MOST CASES)
--==========================================================================================================================
-- JFD_GlobalUserSettings
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
JFD_GlobalUserSettings (
    Type                text            default null,
    Value               integer         default 1);
--==========================================================================================================================
-- BrutalSamurai's Ethnic Units/Gedemon's R.E.D.
--==========================================================================================================================
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_PERSIA' )
	THEN '_PERSIA'
	ELSE '_ASIA' END) 
WHERE Type = 'CIVILIZATION_JWW_UZBEKISTAN';
--==========================================================================================================================
-- Hazel's Map Labels
--==========================================================================================================================
-- ML_CivCultures
------------------------------	
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
		(CivType,								CultureType,	CultureEra)
VALUES	('CIVILIZATION_JWW_UZBEKISTAN',			'ARABIAN',		'ANY');
--==========================================================================================================================
-- Gedemon's YnAEMP
--==========================================================================================================================
-- Civilizations_YagemStartPosition (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
		(Type,									X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_JWW_UZBEKISTAN',			52,	    63,		null,	null);
------------------------------------------------------------	
-- Civilizations_YahemStartPosition (Earth Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
		(Type,									X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_JWW_UZBEKISTAN',			82,		54,		null,	null);
------------------------------------------------------------	
-- Civilizations_CordiformStartPosition (Earth Standard)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
		(Type,									X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_JWW_UZBEKISTAN',			52,		33,		null,	null);
------------------------------------------------------------	
-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
		(Type,									X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_JWW_UZBEKISTAN',			72,		46,		null,	null);
------------------------------------------------------------	
-- Civilizations_EarthMk3StartPosition (Mk3 Earth)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EarthMk3StartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EarthMk3StartPosition
		(Type,									X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_JWW_UZBEKISTAN',			60,		63,		null,	null);
------------------------------------------------------------	
-- Civilizations_AsiaStartPosition (Asia)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AsiaStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AsiaStartPosition
		(Type,									X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_JWW_UZBEKISTAN',			11,	    61,		null,	null);
------------------------------------------------------------	
-- Civilizations_CentralAsiaStartPosition (Central Asia)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CentralAsiaStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CentralAsiaStartPosition
		(Type,									X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_JWW_UZBEKISTAN',			86,	    70,		null,	null);
------------------------------------------------------------	
-- Civilizations_AsiaSteppeGiantStartPosition (Asia Steppe Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AsiaSteppeGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AsiaSteppeGiantStartPosition
		(Type,									X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_JWW_UZBEKISTAN',			57,	    24,		null,	null);
------------------------------------------------------------	
-- Civilizations_AfriAsiaAustStartPosition  (AfriAsiaAust)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AfriAsiaAustStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AfriAsiaAustStartPosition
		(Type,									X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_JWW_UZBEKISTAN',			77,	    71,		null,	null);
------------------------------------------------------------	
-- Civilizations_OrientStartPosition  (Orient)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_OrientStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_OrientStartPosition
		(Type,									X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_JWW_UZBEKISTAN',			92,	    67,		null,	null);

DELETE FROM MinorCivilizations_YnAEMP WHERE MinorCivType = 'MINOR_CIV_SAMARKAND';
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
        (LeaderType,           			TraitOne,					TraitTwo)
VALUES	('LEADER_JWW_ISLAM_KARIMOV',	'POLICY_SPIRITUAL_X',		'POLICY_FINANCIAL_X');
------------------------------	
-- Leaders
------------------------------	
UPDATE Leaders 
SET Description = 'Islam Karimov [ICON_PEACE][ICON_TRADE]'
WHERE Type = 'LEADER_JWW_ISLAM_KARIMOV'
AND EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');
--==========================================================================================================================
-- Community Patch        
--==========================================================================================================================
-- COMMUNITY
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS COMMUNITY (Type TEXT, Value INTEGER);
--==========================================================================================================================
-- JFD's Cultural Diversity
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
        (CivilizationType,				ArtDefineTag, CultureType, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT  ('CIVILIZATION_JWW_UZBEKISTAN'),	ArtDefineTag, CultureType, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_PERSIA';
--==========================================================================================================================
-- JFD's Cities in Development
--==========================================================================================================================
-- BuildingClass_ConstructionAudio
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS
BuildingClass_ConstructionAudio (
    BuildingClassType                           text    REFERENCES BuildingClasses(Type)        default null,
    ConstructionAudio                           text                                            default null);

--The following will override any entries for the above.
CREATE TABLE IF NOT EXISTS
Building_ConstructionAudio (
    BuildingType                                text    REFERENCES Buildings(Type)              default null,
    ConstructionAudio                           text                                            default null);
------------------------------------------------------------
-- Civilization_JFD_ColonialCityNames
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_ColonialCityNames (
    CivilizationType                            text    REFERENCES Civilizations(Type)      default null,
    ColonyName                                  text                                        default null,
    LinguisticType                              text                                        default null,
    CultureType                                 text                                        default null);
/*
JFD_Germanic, JFD_Latinate, JFD_Tai_Khmer, JFD_Austronesian, JFD_Arabic, JFD_Slavic, JFD_Mesopotamian, JFD_Mesoamerican, JFD_Oriental,
JFD_Finno_Ugric, JFD_Semitic, JFD_Hellenic, JFD_Bantu, JFD_Songhay, JFD_Indo_Iranian, JFD_Altaic, JFD_Celtic, JFD_NorthAmerican, JFD_Quechumaran
*/
INSERT INTO Civilization_JFD_ColonialCityNames
        (CivilizationType,                  ColonyName,                             LinguisticType)
SELECT	'CIVILIZATION_JWW_UZBEKISTAN',		ColonyName,                             LinguisticType
FROM Civilization_JFD_ColonialCityNames WHERE CivilizationType = 'CIVILIZATION_PERSIA';
------------------------------------------------------------		
-- Flavors
------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_DECOLONIZATION');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------	
INSERT INTO Leader_Flavors
		(LeaderType,					FlavorType,						Flavor)
VALUES	('LEADER_JWW_ISLAM_KARIMOV',		'FLAVOR_JFD_DECOLONIZATION',	5);
--==========================================================	
-- Provinces 
--==========================================================	
-- Civilization_JFD_ProvinceTitles
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_ProvinceTitles (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 					default null,
	ReligionType  					text 		REFERENCES Religions(Type) 						default null, -- ignore this
	DefaultTitle					text 		 												default null,
	UniqueTitle						text 		 												default null,
	UseAdjective					boolean														default 0);	
	
INSERT INTO Civilization_JFD_ProvinceTitles
		(CivilizationType,					DefaultTitle, UniqueTitle, UseAdjective)
SELECT	'CIVILIZATION_JWW_UZBEKISTAN',		DefaultTitle, UniqueTitle, UseAdjective
FROM Civilization_JFD_ProvinceTitles WHERE CivilizationType = 'CIVILIZATION_PERSIA';
--==========================================================================================================================    
-- JFD's Cities in Development (Slavery)
--==========================================================================================================================    
-- Flavors
------------------------------------------------------------
INSERT OR REPLACE INTO Flavors 
        (Type)
VALUES  ('FLAVOR_JFD_SLAVERY');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------  
INSERT INTO Leader_Flavors
        (LeaderType,            		FlavorType,                 Flavor)
VALUES  ('LEADER_JWW_ISLAM_KARIMOV',		'FLAVOR_JFD_SLAVERY',       10);  
--==========================================================================================================================    
-- JFD's Sovereignty
--==========================================================================================================================
-- Civilization_JFD_Governments
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
    Civilization_JFD_Governments (
    CivilizationType                text        REFERENCES Civilizations(Type)                  default null,
    CultureType                     text                                                        default null,
    LegislatureName                 text                                                        default null,
    OfficeTitle                     text                                                        default null,
    GovernmentType                  text                                                        default null,
    Weight                          integer                                                     default 0);
 
INSERT INTO Civilization_JFD_Governments
        (CivilizationType,				LegislatureName,										OfficeTitle,	GovernmentType,				Weight)
VALUES  ('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_JFD_LEGISLATURE_CIVILIZATION_JWW_UZBEKISTAN',	null,			'GOVERNMENT_JFD_REPUBLIC',  90);
------------------------------------------------------------    
-- Civilization_JFD_HeadsOfGovernment   
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS  
    Civilization_JFD_HeadsOfGovernment (    
    CivilizationType                text        REFERENCES Civilizations(Type)                  default null,
    CultureType                     text                                                        default null,
    HeadOfGovernmentName            text                                                        default null);
 
INSERT INTO Civilization_JFD_HeadsOfGovernment
        (CivilizationType,				HeadOfGovernmentName)
VALUES  ('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JWW_UZBEKISTAN_1'),
        ('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JWW_UZBEKISTAN_2'),
        ('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JWW_UZBEKISTAN_3'),
        ('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JWW_UZBEKISTAN_4'),
        ('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JWW_UZBEKISTAN_5'),
        ('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JWW_UZBEKISTAN_6'),
        ('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JWW_UZBEKISTAN_7'),
        ('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JWW_UZBEKISTAN_8'),
        ('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JWW_UZBEKISTAN_9'),
        ('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JWW_UZBEKISTAN_10'),
        ('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JWW_UZBEKISTAN_11'),
        ('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JWW_UZBEKISTAN_12'),
        ('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JWW_UZBEKISTAN_13'),
        ('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JWW_UZBEKISTAN_14'),
        ('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JWW_UZBEKISTAN_15'),
        ('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JWW_UZBEKISTAN_16'),
        ('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JWW_UZBEKISTAN_17'),
        ('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JWW_UZBEKISTAN_18'),
        ('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JWW_UZBEKISTAN_19'),
        ('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JWW_UZBEKISTAN_20'),
        ('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JWW_UZBEKISTAN_21'),
        ('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JWW_UZBEKISTAN_22'),
        ('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JWW_UZBEKISTAN_23'),
        ('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JWW_UZBEKISTAN_24'),
        ('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JWW_UZBEKISTAN_25');
------------------------------------------------------------
-- Civilization_JFD_Titles
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
    Civilization_JFD_Titles (
    CivilizationType                text        REFERENCES Civilizations(Type)                  default null,
    CultureType                     text                                                        default null,
    ReligionType                    text        REFERENCES Religions(Type)                      default null,
    DefaultTitle                    text                                                        default null,
    UniqueTitle                     text                                                        default null,
    UseAdjective                    boolean                                                     default 0); 
 ------------------------------------------------------------
-- JFD_PrivyCouncillor_UniqueNames
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	JFD_PrivyCouncillor_UniqueNames (
	PrivyCouncillorType  				text 										 	default null,
	PolicyType  						text 	REFERENCES Policies(Type) 				default null,
	CivilizationType					text	REFERENCES Civilizations(Type) 			default	null,
	CultureType							text											default	null,
	GovernmentType  					text 	 										default null,
	ReligionType						text	REFERENCES Religions(Type) 				default	null,
	UniqueName							text											default	null);
------------------------------------------------------------
-- Civilization_JFD_Politics
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Politics (
	CivilizationType  					text 		REFERENCES Civilizations(Type) 					default null,
	PoliticsType  						text 														default null,
	UniqueName							text														default	null);
------------------------------------------------------------
-- Flavors
------------------------------------------------------------    
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_REFORM_GOVERNMENT'),
		('FLAVOR_JFD_REFORM_LEGAL'),
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
        (LeaderType,					FlavorType,                         Flavor)
VALUES  ('LEADER_JWW_ISLAM_KARIMOV',		'FLAVOR_JFD_REFORM_GOVERNMENT',     5),
		('LEADER_JWW_ISLAM_KARIMOV',		'FLAVOR_JFD_REFORM_LEGAL',			4),
        ('LEADER_JWW_ISLAM_KARIMOV',		'FLAVOR_JFD_REFORM_CULTURE',        2),
        ('LEADER_JWW_ISLAM_KARIMOV',		'FLAVOR_JFD_REFORM_ECONOMIC',       2),
        ('LEADER_JWW_ISLAM_KARIMOV',		'FLAVOR_JFD_REFORM_FOREIGN',        6),
        ('LEADER_JWW_ISLAM_KARIMOV',		'FLAVOR_JFD_REFORM_INDUSTRY',       3),
        ('LEADER_JWW_ISLAM_KARIMOV',		'FLAVOR_JFD_REFORM_MILITARY',       6),
        ('LEADER_JWW_ISLAM_KARIMOV',		'FLAVOR_JFD_REFORM_RELIGION',       7);
--------------------------------------------------------------------------------------------------------------------------
-- Leader_JFD_Reforms
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Leader_JFD_Reforms (
	LeaderType  												text 	REFERENCES Leaders(Type) 				default	null,
	ReformType													text											default	null);
--==========================================================================================================================    
-- JFD's AND POUAKAI's Mercenaries
--==========================================================================================================================
-- Flavors
------------------------------------------------------------    
INSERT OR REPLACE INTO Flavors 
        (Type)
VALUES  ('FLAVOR_JFD_MERCENARY');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------    
--A value of 0-10 may be set. This value determines the likelihood that a leader will take out Mercenary Contracts (provided they have the funds).
--A value of 10 means this civilization will always take a Contract if available. A value of 0 means this civilization will never take out a contract.
INSERT INTO Leader_Flavors
        (LeaderType,					FlavorType,					Flavor)
VALUES  ('LEADER_JWW_ISLAM_KARIMOV',		'FLAVOR_JFD_MERCENARY',		4);
--==========================================================================================================================    
-- JFD's Piety
--==========================================================================================================================    
-- Flavors
------------------------------------------------------------    
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_RELIGIOUS_INTOLERANCE'),
		('FLAVOR_JFD_STATE_RELIGION');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------    
--A value of 1-12 may be set. This value determines the diplomatic penalty/bonus with civilizations of a different/same state religion
--A value higher than 9 means this civilization will never secularise. A value of 0 means this civilization has no interest in State Religion.
INSERT INTO Leader_Flavors
        (LeaderType,					FlavorType,                             Flavor)
VALUES  ('LEADER_JWW_ISLAM_KARIMOV',		'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',     5),
		('LEADER_JWW_ISLAM_KARIMOV',		'FLAVOR_JFD_STATE_RELIGION',			7);
--==========================================================================================================================
-- JFD's Rise to power (Prosperity)
--==========================================================================================================================
-- Civilization_JFD_Currencies
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
    Civilization_JFD_Currencies (
    CivilizationType                text        REFERENCES Civilizations(Type)  default null,
    CurrencyType                    text                                        default null);
 
INSERT INTO Civilization_JFD_Currencies
        (CivilizationType,                  CurrencyType)
SELECT  ('CIVILIZATION_JWW_UZBEKISTAN'),		CurrencyType
FROM Civilization_JFD_Currencies WHERE CivilizationType = 'CIVILIZATION_PERSIA'; 
--==========================================================================================================================
-- Additional Achievements
--==========================================================================================================================
-- AdditionalAchievements_Mods
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	AdditionalAchievements_Mods (
	ID  					integer 		PRIMARY KEY							AUTOINCREMENT,
	Type					text												default	null,
	ModName					text												default null,
	ModID					text												default	null,	
	Authors					text												default	null);

INSERT INTO AdditionalAchievements_Mods
		(Type,					ModName,							ModID,								Authors)
VALUES	('MOD_JWW_UZBEKISTAN',	'TXT_KEY_MOD_JWW_UZBEKISTAN_NAME',	'TXT_KEY_MOD_JWW_UZBEKISTAN_MODID',	'TXT_KEY_MOD_JWW_UZBEKISTAN_AUTHORS');
--------------------------------------------------------------------------------------------------------------------------
-- Achievopedia_Tabs
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Achievopedia_Tabs (
	ID  					integer 		PRIMARY KEY							AUTOINCREMENT,
	Type					text												default	null,
	Header					text												default null,
	Description				text												default	null);

INSERT OR REPLACE INTO Achievopedia_Tabs
		(Type,						Header,								Description)
VALUES	('TAB_JWW_CIVS',			'TXT_KEY_TAB_JWW_CIVS_HEADER',		'TXT_KEY_TAB_JWW_CIVS_DESCRIPTION');
--------------------------------------------------------------------------------------------------------------------------
-- AdditionalAchievements
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	AdditionalAchievements (
	ID  					integer 		PRIMARY KEY							AUTOINCREMENT,
	Type					text												default	null,
	Achievopedia			text												default null,
	Header					text												default	null,	
	IconAtlas				text												default	null,	
	PortraitIndex			integer												default	0,
	ModType					text												default	null,	
	ModVersion				integer												default	0,
	Unlocked				boolean												default	0,
	LockedIconAtlas			text												default	'CIV_COLOR_ATLAS',
	LockedPortraitIndex		integer												default	23,
	UnlockSound				text												default	'AS2D_INTERFACE_ANCIENT_RUINS',
	PopupDuration			integer												default	-1,
	Hidden					boolean												default	0,
	HiddenBorder			boolean												default	0,
	RequiredCivWin			text												default	null,
	RequiredCivLoss			text												default	null,
	RequiredCivKill			text												default	null);

INSERT INTO AdditionalAchievements
		(Type,							Header,										Achievopedia,								ModType,				ModVersion,		RequiredCivWin,						IconAtlas,				PortraitIndex)
VALUES	('AA_JWW_UZBEKISTAN_VICTORY',	'TXT_KEY_AA_JWW_UZBEKISTAN_VICTORY_HEADER',	'TXT_KEY_AA_JWW_UZBEKISTAN_VICTORY_TEXT',	'MOD_JWW_UZBEKISTAN',	1,				'CIVILIZATION_JWW_UZBEKISTAN',		'JWW_UZBEK_COLOR_ATLAS',	1);
--------------------------------------------------------------------------------------------------------------------------
-- AdditionalAchievements_Tabs
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	AdditionalAchievements_Tabs (
	AchievementType			text												default	null,
	TabType					text												default	null);

INSERT OR REPLACE INTO AdditionalAchievements_Tabs
		(AchievementType,				TabType)
VALUES	('AA_JWW_UZBEKISTAN_VICTORY',	'TAB_JWW_CIVS');
--==========================================================================================================================
-- HISTORICAL RELIGIONS
--==========================================================================================================================

--==========================================================================================================================
-- CULTURAL INFLUENCE
--==========================================================================================================================

INSERT INTO Diplomacy_Responses
		(LeaderType,				ResponseType,						Response,												Bias)
VALUES	('LEADER_JWW_SANTA_ANNA',	'RESPONSE_INFLUENTIAL_ON_AI',		'TXT_KEY_LEADER_JWW_ISLAM_KARIMOV_INFLUENTIAL_ON_AI%',		500),
		('LEADER_JWW_SANTA_ANNA',	'RESPONSE_INFLUENTIAL_ON_HUMAN',	'TXT_KEY_LEADER_JWW_ISLAM_KARIMOV_INFLUENTIAL_ON_HUMAN%',	500);
--==========================================================================================================================        
--==========================================================================================================================
