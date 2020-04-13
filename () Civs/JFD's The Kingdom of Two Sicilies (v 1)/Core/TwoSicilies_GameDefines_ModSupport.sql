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
VALUES  ('LEADER_JFD_FERDINAND_I',	'POLICY_FINANCIAL_X',	'POLICY_SEAFARING_X');
------------------------------	
-- Leaders
------------------------------	
UPDATE Leaders 
SET Description = 'Ferdinand I [ICON_GOLD][ICON_GREAT_EXPLORER]'
WHERE Type = 'LEADER_JFD_FERDINAND_I'
AND EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');
--==========================================================================================================================
-- GAZEBO COMMUNITY PATCH
--==========================================================================================================================
-- COMMUNITY
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS COMMUNITY (Type TEXT, Value INTEGER);
------------------------------
-- Buildings
------------------------------	
UPDATE Buildings
SET Help = 'TXT_KEY_BUILDING_JFD_WINE_CELLAR_HELP_CBP', Strategy = 'TXT_KEY_BUILDING_JFD_WINE_CELLAR_STRATEGY_CBP'
WHERE Type = 'BUILDING_JFD_WINE_CELLAR' 
AND EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value = 1);
--==========================================================================================================================
-- GEDEMON R.E.D.
--==========================================================================================================================
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET ArtStyleSuffix = '_VENICE'
WHERE Type = 'CIVILIZATION_JFD_TWO_SICILIES'
AND EXISTS (SELECT * FROM Civilizations WHERE ArtStyleSuffix = '_VENICE');
--==========================================================================================================================
-- GEDEMON YNAEMP
--==========================================================================================================================
-- Civilizations_YagemStartPosition (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
		(Type,								X,		Y)
VALUES	('CIVILIZATION_JFD_TWO_SICILIES',	22,		57);
------------------------------------------------------------	
-- Civilizations_YahemStartPosition (Earth Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
		(Type,								X,		Y)
VALUES	('CIVILIZATION_JFD_TWO_SICILIES',	62,		53);
------------------------------------------------------------	
-- Civilizations_CordiformStartPosition (Earth Standard)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
		(Type,								X,		Y)
VALUES	('CIVILIZATION_JFD_TWO_SICILIES',	37,		23);
------------------------------------------------------------	
-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
		(Type,								X,		Y)
VALUES	('CIVILIZATION_JFD_TWO_SICILIES',	51,		41);
------------------------------------------------------------	
-- Civilizations_EuroGiantStartPosition (Europe Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroGiantStartPosition
		(Type,								X,		Y)
VALUES	('CIVILIZATION_JFD_TWO_SICILIES',	67,		31);
------------------------------------------------------------	
-- Civilizations_EuroLargeStartPosition (Europe Large)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroLargeStartPosition
		(Type,								X,		Y)
VALUES	('CIVILIZATION_JFD_TWO_SICILIES',	38,		30);
------------------------------------------------------------	
-- Civilizations_NorthAtlanticStartPosition (North Atlantic)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthAtlanticStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthAtlanticStartPosition
		(Type,								X,		Y)
VALUES	('CIVILIZATION_JFD_TWO_SICILIES',	101,	21);
------------------------------------------------------------	
-- Civilizations_ApennineStartPosition (Apennine)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_ApennineStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_ApennineStartPosition
		(Type,								X,		Y)
VALUES	('CIVILIZATION_JFD_TWO_SICILIES',	34,		27);
------------------------------------------------------------	
-- Civilizations_MediterraneanStartPosition (Mediterranean)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_MediterraneanStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_MediterraneanStartPosition
		(Type,								X,		Y)
VALUES	('CIVILIZATION_JFD_TWO_SICILIES',	46,		39);
------------------------------------------------------------	
-- Civilizations_YagemRequestedResource (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_TWO_SICILIES',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE Type = 'CIVILIZATION_VENICE';
------------------------------------------------------------	
-- Civilizations_YahemRequestedResource (Earth Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YahemRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_TWO_SICILIES',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE Type = 'CIVILIZATION_VENICE';
------------------------------------------------------------	
-- Civilizations_GreatestEarthRequestedResource (Earth Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_GreatestEarthRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_TWO_SICILIES',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_GreatestEarthRequestedResource WHERE Type = 'CIVILIZATION_VENICE';
------------------------------------------------------------	
-- Civilizations_EuroLargeRequestedResource (Europe Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroGiantRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_EuroGiantRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_TWO_SICILIES',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_EuroGiantRequestedResource WHERE Type = 'CIVILIZATION_VENICE';
------------------------------------------------------------	
-- Civilizations_EuroLargeRequestedResource (Europe Large)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_EuroLargeRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_TWO_SICILIES',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_EuroLargeRequestedResource WHERE Type = 'CIVILIZATION_VENICE';
------------------------------------------------------------	
-- Civilizations_ApennineRequestedResource (Apennine)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_ApennineRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_ApennineRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_TWO_SICILIES',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_ApennineRequestedResource WHERE Type = 'CIVILIZATION_VENICE';
------------------------------------------------------------	
-- Civilizations_MediterraneanRequestedResource (Mediterranean)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_MediterraneanRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_MediterraneanRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_TWO_SICILIES',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_MediterraneanRequestedResource WHERE Type = 'CIVILIZATION_VENICE';
--==========================================================================================================================
-- HAZEL MAP LABELS
--==========================================================================================================================
-- ML_CivCultures
------------------------------	
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
		(CivType,							CultureType,		CultureEra)
VALUES	('CIVILIZATION_JFD_TWO_SICILIES',	'MEDITERRANEAN',	'ANY');
--==========================================================================================================================
-- JFD USER SETTINGS
--==========================================================================================================================
-- JFD_GlobalUserSettings
-------------------------------------
CREATE TABLE IF NOT EXISTS 
JFD_GlobalUserSettings (
	Type 											text 										default null,
	Value 											integer 									default 1);
--==========================================================================================================================
-- JFD COLONIES
--==========================================================================================================================
-- Civilization_JFD_ColonialCityNames
------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_ColonialCityNames (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	ColonyName 									text										default null,
	LinguisticType								text										default	null,
	CultureType									text										default	null);

INSERT INTO Civilization_JFD_ColonialCityNames
		(CivilizationType,					LinguisticType)
SELECT	'CIVILIZATION_JFD_TWO_SICILIES',	LinguisticType
FROM Civilization_JFD_ColonialCityNames WHERE CivilizationType = 'CIVILIZATION_VENICE';
--==========================================================================================================================
-- JFD CITIES IN DEVELOPMENT
--==========================================================================================================================
--Building_ConstructionAudio
----------------------
CREATE TABLE IF NOT EXISTS
Building_ConstructionAudio (
    BuildingType                                text    REFERENCES Buildings(Type)              default null,
    ConstructionAudio                           text											default null);
	
INSERT INTO Building_ConstructionAudio
		(BuildingType, 					ConstructionAudio)
SELECT	'BUILDING_JFD_WINE_CELLAR',		'AS2D_BUILDING_JFD_WINE_CELLAR'
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_MISC_CIV_BUILDING_SOUNDS' AND Value = 1);
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
	IdealsTag									text											default	null,
	SplashScreenTag								text											default	null,
	SoundtrackTag								text											default	null,
	UnitDialogueTag								text											default null);

INSERT INTO Civilization_JFD_CultureTypes
		(CivilizationType,				 ArtDefineTag, CultureType, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT	'CIVILIZATION_JFD_TWO_SICILIES', ArtDefineTag, CultureType, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_VENICE';
------------------------------	
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET SoundtrackTag = 'JFD_Southern'
WHERE Type = 'CIVILIZATION_JFD_TWO_SICILIES'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Southern')
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
		(LeaderType,				FlavorType,				 Flavor)
VALUES	('LEADER_JFD_FERDINAND_I',	'FLAVOR_JFD_MERCENARY',	 8);
--==========================================================================================================================	
-- JFD PIETY
--==========================================================================================================================
-- Flavors
------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_RELIGIOUS_INTOLERANCE');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------
INSERT INTO Leader_Flavors
		(LeaderType,				FlavorType,							 Flavor)
VALUES	('LEADER_JFD_FERDINAND_I',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',	 6);
--==========================================================================================================================
-- JFD PROSPERITY
--==========================================================================================================================
-- Civilization_JFD_Currencies
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Currencies (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 	default null,
	CurrencyType	  				text 		  								default null);

INSERT INTO Civilization_JFD_Currencies
		(CivilizationType,					CurrencyType)
SELECT	'CIVILIZATION_JFD_TWO_SICILIES',	CurrencyType
FROM Civilization_JFD_Currencies WHERE CivilizationType = 'CIVILIZATION_VENICE';
--==========================================================================================================================	
-- JFD SOVEREIGNTY
--==========================================================================================================================
-- Civilization_JFD_Governments
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Governments (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 			default null,
	CultureType	  					text 		 										default null,
	LegislatureName					text												default	null,
	OfficeTitle						text												default	null,
	GovernmentType					text												default	null,
	Weight							integer												default	0);
	
INSERT INTO Civilization_JFD_Governments
		(CivilizationType,					LegislatureName, 											OfficeTitle,														GovernmentType,				Weight)
VALUES	('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_JFD_LEGISLATURE_NAME_CIVILIZATION_TWO_SICILIES',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_TWO_SICILIES',	'GOVERNMENT_JFD_MONARCHY',	90);
------------------------------------------------------------	
-- Civilization_JFD_HeadsOfGovernment	
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 	
	Civilization_JFD_HeadsOfGovernment (	
	CivilizationType  				text 		REFERENCES Civilizations(Type) 					default null,
	CultureType						text 		 												default null,
	HeadOfGovernmentName			text 		 												default null);

INSERT INTO Civilization_JFD_HeadsOfGovernment
        (CivilizationType,      			HeadOfGovernmentName)
VALUES  ('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TWO_SICILIES_1'),
        ('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TWO_SICILIES_2'),
        ('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TWO_SICILIES_3'),
        ('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TWO_SICILIES_4'),
        ('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TWO_SICILIES_5'),
        ('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TWO_SICILIES_6'),
        ('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TWO_SICILIES_7'),
        ('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TWO_SICILIES_8'),
        ('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TWO_SICILIES_9'),
        ('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TWO_SICILIES_10'),
        ('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TWO_SICILIES_11'),
        ('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TWO_SICILIES_12'),
        ('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TWO_SICILIES_13'),
        ('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TWO_SICILIES_14'),
        ('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TWO_SICILIES_15'),
        ('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TWO_SICILIES_16'),
        ('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TWO_SICILIES_17'),
        ('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TWO_SICILIES_18'),
        ('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TWO_SICILIES_19'),
        ('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TWO_SICILIES_20'),
        ('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TWO_SICILIES_21'),
        ('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TWO_SICILIES_22'),
        ('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TWO_SICILIES_23'),
        ('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TWO_SICILIES_24'),
        ('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TWO_SICILIES_25');
------------------------------------------------------------
-- Civilization_JFD_Politics
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Politics (
	CivilizationType  					text 		REFERENCES Civilizations(Type) 					default null,
	PoliticsType  						text 														default null,
	UniqueName							text														default	null);

INSERT INTO Civilization_JFD_Politics
		(CivilizationType,					PoliticsType,				UniqueName)
VALUES	('CIVILIZATION_JFD_TWO_SICILIES',	'PARTY_JFD_LIBERTARIAN',	'TXT_KEY_JFD_PARTY_JFD_LIBERTARIAN_TWO_SICILIES'),
		('CIVILIZATION_JFD_TWO_SICILIES',	'PARTY_JFD_NOBILITY',		'TXT_KEY_JFD_PARTY_JFD_NOBILITY_TWO_SICILIES'),
		('CIVILIZATION_JFD_TWO_SICILIES',	'PARTY_JFD_REVOLUTIONARY',	'TXT_KEY_JFD_PARTY_JFD_REVOLUTIONARY_TWO_SICILIES');
------------------------------------------------------------			
-- Flavors
------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_REFORM_GOVERNMENT'),
		('FLAVOR_JFD_REFORM_CULTURE'),
		('FLAVOR_JFD_REFORM_ECONOMIC'),
		('FLAVOR_JFD_REFORM_FOREIGN'),
		('FLAVOR_JFD_REFORM_INDUSTRY'),
		('FLAVOR_JFD_REFORM_MILITARY'),
		('FLAVOR_JFD_REFORM_RELIGION');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------
INSERT INTO Leader_Flavors
		(LeaderType,				FlavorType,							 Flavor)
VALUES	('LEADER_JFD_FERDINAND_I',	'FLAVOR_JFD_REFORM_GOVERNMENT',		 9),
		('LEADER_JFD_FERDINAND_I',	'FLAVOR_JFD_REFORM_CULTURE',		 6),
		('LEADER_JFD_FERDINAND_I',	'FLAVOR_JFD_REFORM_ECONOMIC',		 5),
		('LEADER_JFD_FERDINAND_I',	'FLAVOR_JFD_REFORM_FOREIGN',		 4),
		('LEADER_JFD_FERDINAND_I',	'FLAVOR_JFD_REFORM_INDUSTRY',		 4),
		('LEADER_JFD_FERDINAND_I',	'FLAVOR_JFD_REFORM_MILITARY',		 5),
		('LEADER_JFD_FERDINAND_I',	'FLAVOR_JFD_REFORM_RELIGION',		 7);
--==========================================================================================================================
-- POUAKAI ENLIGHTENMENT ERA
--==========================================================================================================================
-- Buildings
------------------------------	
INSERT OR REPLACE INTO Buildings 	
		(Type, 						Happiness, TradeRouteSeaDistanceModifier,	SpecialistCount, SpecialistType, BuildingClass, Cost, GoldMaintenance, PrereqTech, Description, 						Civilopedia, 							Help, 										Strategy,										ArtDefineTag, MinAreaSize, ConquestProb, HurryCostModifier, PortraitIndex, IconAtlas)
SELECT	'BUILDING_JFD_WINE_CELLAR',	Happiness, 30,								SpecialistCount, SpecialistType, BuildingClass, Cost, GoldMaintenance, PrereqTech, 'TXT_KEY_BUILDING_JFD_WINE_CELLAR', 'TXT_KEY_CIV5_JFD_WINE_CELLAR_TEXT', 	'TXT_KEY_BUILDING_JFD_WINE_CELLAR_HELP', 	'TXT_KEY_BUILDING_JFD_WINE_CELLAR_STRATEGY_EE', ArtDefineTag, MinAreaSize, ConquestProb, HurryCostModifier, 3, 			'JFD_TWO_SICILIES_ATLAS'
FROM Buildings WHERE Type = 'BUILDING_EE_MENAGERIE'
AND EXISTS (SELECT * FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');
------------------------------	
-- Building_ClassesNeededInCity
------------------------------		
DELETE FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_JFD_WINE_CELLAR'
AND EXISTS (SELECT * FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');
INSERT INTO Building_ClassesNeededInCity 	
		(BuildingType, 				BuildingClassType)
SELECT	'BUILDING_JFD_WINE_CELLAR',	BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_EE_MENAGERIE';
------------------------------	
-- Building_YieldChanges
------------------------------		
DELETE FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_EE_MENAGERIE'
AND EXISTS (SELECT * FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');
------------------------------
-- Civilization_BuildingClassOverrides
------------------------------	
UPDATE Civilization_BuildingClassOverrides
SET BuildingClassType = 'BUILDINGCLASS_EE_MENAGERIE'
WHERE CivilizationType = 'CIVILIZATION_JFD_TWO_SICILIES'
AND EXISTS (SELECT * FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');
--==========================================================================================================================
-- SUKRITACT DECISIONS
--==========================================================================================================================
-- DecisionsAddin_Support
------------------------------
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('JFD_TwoSicilies_Decisions.lua');
------------------------------	
-- UnitPromotions
------------------------------
INSERT INTO UnitPromotions 
		(Type, 									Description, 									Help, 												Sound, 				ExperiencePercent,	LostWithUpgrade,	CannotBeChosen, PortraitIndex,  IconAtlas, 			PediaType, 			PediaEntry)
VALUES	('PROMOTION_DECISIONS_JFD_NUNZIATELLA',	'TXT_KEY_PROMOTION_DECISIONS_JFD_NUNZIATELLA',	'TXT_KEY_PROMOTION_DECISIONS_JFD_NUNZIATELLA_HELP',	'AS2D_IF_LEVELUP',	30,					1,					1, 				59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_DECISIONS_JFD_NUNZIATELLA');
------------------------------	
-- UnitPromotions_UnitCombats
------------------------------
INSERT INTO UnitPromotions_UnitCombats
		(PromotionType,							UnitCombatType)
SELECT	'PROMOTION_DECISIONS_JFD_NUNZIATELLA',	Type
FROM UnitCombatInfos WHERE Type IN ('UNITCOMBAT_NAVALMELEE', 'UNITCOMBAT_NAVALRANGED', 'UNITCOMBAT_CARRIER', 'UNITCOMBAT_SUBMARINE');
------------------------------	
-- BuildingClasses
------------------------------	
INSERT INTO BuildingClasses 	
		(Type, 						 				DefaultBuilding, 						Description, 							MaxPlayerInstances)
VALUES	('BUILDINGCLASS_DECISIONS_JFD_NUNZIATELLA', 'BUILDING_DECISIONS_JFD_NUNZIATELLA',	'TXT_KEY_DECISIONS_JFD_NUNZIATELLA',	1);
------------------------------
-- Buildings
------------------------------
INSERT INTO Buildings			
		(Type, 									BuildingClass, 			  					TrainedFreePromotion,					Cost, 	FaithCost,	Help,										Description, 							Civilopedia,								IconAtlas,		PortraitIndex,	NukeImmune, ConquestProb)
VALUES	('BUILDING_DECISIONS_JFD_NUNZIATELLA',	'BUILDINGCLASS_DECISIONS_JFD_NUNZIATELLA',  'PROMOTION_DECISIONS_JFD_NUNZIATELLA',	-1, 	-1,			'TXT_KEY_DECISIONS_JFD_NUNZIATELLA_HELP',	'TXT_KEY_DECISIONS_JFD_NUNZIATELLA', 	'TXT_KEY_DECISIONS_JFD_NUNZIATELLA_PEDIA',	'BW_ATLAS_1',	6,				1,			100);
--==========================================================================================================================
-- SUKRITACT EVENTS
--==========================================================================================================================
-- EventsAddin_Support
------------------------------
CREATE TABLE IF NOT EXISTS EventsAddin_Support(FileName);
INSERT INTO EventsAddin_Support (FileName) VALUES ('JFD_TwoSicilies_Events.lua');
------------------------------------------------------------
-- Policy_JFD_OrganizedCrimeMods
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 
	Policy_JFD_OrganizedCrimeMods (
	PolicyType  			text 		REFERENCES Policies(Type) 				default null,
	OrganizedCrimeType		text 		REFERENCES JFD_OrganizedCrimes(Type) 	default null,
	ThresholdMod			integer												default 0);	

INSERT INTO Policy_JFD_OrganizedCrimeMods 
		(PolicyType,					ThresholdMod)
VALUES	('POLICY_EVENTS_JFD_MAFIA',		10);
------------------------------
-- Events_CulturalDevelopments
------------------------------
CREATE TABLE IF NOT EXISTS 
Events_CulturalDevelopments(
	CivilizationType		text  REFERENCES Civilizations(Type)	default null,
	CultureType				text									default null,
	Description				text									default null);

INSERT INTO Events_CulturalDevelopments 
		(Description,									CivilizationType,					CultureType)
VALUES	('TXT_KEY_EVENT_CULDEV_JFD_TWO_SICILIES_01',	'CIVILIZATION_JFD_TWO_SICILIES',	'JFD_Southern');
--==========================================================================================================================
--==========================================================================================================================