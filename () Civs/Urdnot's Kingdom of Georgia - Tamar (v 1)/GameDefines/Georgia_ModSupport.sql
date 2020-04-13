--=======================================================================================================================
-- BINGLES CIV IV TRAITS
--=======================================================================================================================
-- Leader_SharedTraits
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 
    Leader_SharedTraits (
    LeaderType          text    REFERENCES Leaders(Type)        default null,
    TraitOne            text    REFERENCES Policies(Type)       default null,
    TraitTwo            text    REFERENCES Policies(Type)       default null);
     
INSERT INTO Leader_SharedTraits
        (LeaderType,        TraitOne,				TraitTwo)
SELECT  'LEADER_US_TAMAR',  'POLICY_DEFENSIVE_X',	'POLICY_SPIRITUAL_X'
WHERE EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');
--------------------------------------------------------------------------------------------------------------------------	
-- Leaders
--------------------------------------------------------------------------------------------------------------------------	
UPDATE Leaders 
SET Description = 'Eleanor [ICON_STRENGTH][ICON_FAITH]'
WHERE Type = 'LEADER_US_TAMAR'
AND EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');
--==========================================================================================================================
-- GAZEBO COMMUNITY PATCH
--==========================================================================================================================
-- COMMUNITY
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS COMMUNITY (Type TEXT, Value INTEGER);
--==========================================================================================================================
-- GEDEMON R.E.D.
--==========================================================================================================================
-- Civilizations
--------------------------------------------------------------------------------------------------------------------------	
UPDATE Civilizations 
SET ArtStyleSuffix = '_BYZANTIUM'
WHERE Type = 'CIVILIZATION_US_GEORGIA'
AND EXISTS (SELECT * FROM Civilizations WHERE ArtStyleSuffix = '_BYZANTIUM');
--==========================================================================================================================
-- GEDEMON YNAEMP
--==========================================================================================================================
-- Civilizations_YnAEMP
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YnAEMP(CivilizationType, MapPrefix, X, Y, CapitalName, AltX, AltY, AltCapitalName);
INSERT INTO Civilizations_YnAEMP
		(CivilizationType,						MapPrefix, 			 X,   Y,	AltX,	AltY,	AltCapitalName)
VALUES	('CIVILIZATION_JFD_GREATER_ARMENIA',	'Cordiform', 		 50,  26,	null,	null,	null),
		('CIVILIZATION_JFD_GREATER_ARMENIA',	'GreatestEarth', 	 64,  46,	null,	null,	null),
		('CIVILIZATION_JFD_GREATER_ARMENIA',	'EuroLarge', 		 70,  32,	null,	null,	null),
		('CIVILIZATION_JFD_GREATER_ARMENIA',	'Yagem', 			 42,  60,	null,	null,	null),
		('CIVILIZATION_JFD_GREATER_ARMENIA',	'Yahem', 			 76,  54,	null,	null,	null),
		('CIVILIZATION_JFD_GREATER_ARMENIA',	'EuroGiant', 		 147, 40,	null,	null,	null),
		('CIVILIZATION_JFD_GREATER_ARMENIA',	'AfriAsiaAust', 	 54,  79,	null,	null,	null),
		('CIVILIZATION_JFD_GREATER_ARMENIA',	'AfriSouthEuro', 	 65,  73,	null,	null,	null),
		('CIVILIZATION_JFD_GREATER_ARMENIA',	'EuroLargeNew', 	 67,  33,	null,	null,	null),
		('CIVILIZATION_JFD_GREATER_ARMENIA',	'Caucasus', 	 	 105, 42,	null,	null,	null),
		('CIVILIZATION_JFD_GREATER_ARMENIA',	'EarthMk3', 		 42,  58,	null,	null,	null),
		('CIVILIZATION_JFD_GREATER_ARMENIA',	'MediterraneanHuge', 82,  68,	null,	null,	null);
--------------------------------------------------------------------------------------------------------------------------	
-- Civilizations_YnAEMPRequestedResources
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YnAEMPRequestedResources(CivilizationType, MapPrefix, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4, Req5, Yield5, Req6, Yield6);
INSERT INTO Civilizations_YnAEMPRequestedResources
		(CivilizationType,			MapPrefix, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4, Req5, Yield5, Req6, Yield6)
SELECT	'CIVILIZATION_US_GEORGIA',	MapPrefix, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4, Req5, Yield5, Req6, Yield6
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_BYZANTIUM';
--==========================================================================================================================
-- HAZEL MAP LABELS
--==========================================================================================================================
-- ML_CivCultures
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
		(CivType, 					CultureType, CultureEra)
SELECT	'CIVILIZATION_US_GEORGIA',	CultureType, CultureEra
FROM ML_CivCultures WHERE CivType = 'CIVILIZATION_BYZANTIUM';
--==========================================================================================================================
-- JFD USER SETTINGS
--==========================================================================================================================
-- JFD_GlobalUserSettings
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
JFD_GlobalUserSettings (
	Type 	text 	  default null,
	Value 	integer   default 1);
--==========================================================================================================================
-- JFDLC
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- Flavors
--------------------------------------------------------------------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_DECOLONIZATION'),
		('FLAVOR_JFD_MERCENARY'),
		('FLAVOR_JFD_REFORM_GOVERNMENT'),
		('FLAVOR_JFD_REFORM_LEGAL'),
		('FLAVOR_JFD_REFORM_CULTURE'),
		('FLAVOR_JFD_REFORM_ECONOMIC'),
		('FLAVOR_JFD_REFORM_FOREIGN'),
		('FLAVOR_JFD_REFORM_INDUSTRY'),
		('FLAVOR_JFD_REFORM_MILITARY'),
		('FLAVOR_JFD_REFORM_RELIGION'),
		('FLAVOR_JFD_RELIGIOUS_INTOLERANCE'),
		('FLAVOR_JFD_SLAVERY'),
		('FLAVOR_JFD_STATE_RELIGION');
--------------------------------------------------------------------------------------------------------------------------
-- Leader_Flavors
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Leader_Flavors
		(LeaderType,		FlavorType,								Flavor)
VALUES	('LEADER_US_TAMAR',	'FLAVOR_JFD_DECOLONIZATION',			5),
		('LEADER_US_TAMAR',	'FLAVOR_JFD_MERCENARY',					5),
		('LEADER_US_TAMAR',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',		5),
		('LEADER_US_TAMAR',	'FLAVOR_JFD_REFORM_GOVERNMENT',			5),
		('LEADER_US_TAMAR',	'FLAVOR_JFD_REFORM_LEGAL',				5),
		('LEADER_US_TAMAR',	'FLAVOR_JFD_REFORM_CULTURE',			5),
		('LEADER_US_TAMAR',	'FLAVOR_JFD_REFORM_ECONOMIC',			5),
		('LEADER_US_TAMAR',	'FLAVOR_JFD_REFORM_FOREIGN',			5),
		('LEADER_US_TAMAR',	'FLAVOR_JFD_REFORM_INDUSTRY',			5),
		('LEADER_US_TAMAR',	'FLAVOR_JFD_REFORM_MILITARY',			5),
		('LEADER_US_TAMAR',	'FLAVOR_JFD_REFORM_RELIGION',			7),
		('LEADER_US_TAMAR',	'FLAVOR_JFD_SLAVERY',					5),
		('LEADER_US_TAMAR',	'FLAVOR_JFD_STATE_RELIGION',			8);
--====================================	
-- INVENTIONS 
--====================================	
-- Civilization_JFD_Inventions
--------------------------------------------------------------------------------------------------------------------------	
--==========================================================	
-- INVENTIONS 
--==========================================================	
-- Civilization_JFD_Inventions
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Inventions (
	CivilizationType  											text 	REFERENCES Civilizations(Type) 				default null,
	InventionType  												text 		 										default null,
	InventionPreference											text 		 										default null);
	
INSERT INTO Civilization_JFD_Inventions
		(CivilizationType, 				InventionType, 				InventionPreference)
VALUES 	('CIVILIZATION_US_GEORGIA', 	'INVENTION_JFD_WRITING',	'WRITING_JFD_CYRILLIC'),
		('CIVILIZATION_US_GEORGIA', 	'INVENTION_JFD_CURRENCY',	'CURRENCY_JFD_CROWN'),
		('CIVILIZATION_US_GEORGIA', 	'INVENTION_JFD_DOCTRINE',	'DOCTRINE_JFD_ROYALISM'),
		('CIVILIZATION_US_GEORGIA', 	'INVENTION_JFD_SPORT',		'SPORT_JFD_RUGBY'),
		('CIVILIZATION_US_GEORGIA', 	'INVENTION_JFD_SOCIETY',	'SOCIETY_JFD_JESUITS');
--==========================================================================================================================
-- JFD CITIES IN DEVELOPMENT
--==========================================================================================================================
-- Building_ConstructionAudio
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS
Building_ConstructionAudio (
    BuildingType						text		REFERENCES Buildings(Type)      default null,
    ConstructionAudio					text										default null);
	
INSERT INTO Building_ConstructionAudio
		(BuildingType, 			ConstructionAudio)
SELECT	'BUILDING_US_TSIKHE',	'AS2D_BUILDING_JFD_CASTLE'
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_MISC_CIV_BUILDING_SOUNDS' AND Value = 1);
--====================================	
-- JFD COLONIES
--====================================	
--------------------------------------------------------------------------------------------------------------------------
-- Civilization_JFD_ColonialCityNames
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_ColonialCityNames (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	ColonyName 									text										default null,
	LinguisticType								text										default	null);

INSERT INTO Civilization_JFD_ColonialCityNames
		(CivilizationType,			LinguisticType, ColonyName)
SELECT	'CIVILIZATION_US_GEORGIA',	LinguisticType, ColonyName
FROM Civilization_JFD_ColonialCityNames WHERE CivilizationType = 'CIVILIZATION_BYZANTIUM';
--====================================	
-- JFD DEVELOPMENT
--====================================	
--====================================
-- JFD PROVINCES 
--====================================
--------------------------------------------------------------------------------------------------------------------------
-- Civilization_JFD_ProvinceTitles
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_ProvinceTitles (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 					default null,
	ReligionType  					text 		REFERENCES Religions(Type) 						default null,
	DefaultTitle					text 		 												default null,
	UniqueTitle						text 		 												default null,
	UseAdjective					boolean														default 0);	

INSERT INTO Civilization_JFD_ProvinceTitles
		(CivilizationType,			DefaultTitle,	UniqueTitle)
SELECT	'CIVILIZATION_US_GEORGIA',	DefaultTitle,	UniqueTitle
FROM Civilization_JFD_ProvinceTitles WHERE CivilizationType = 'CIVILIZATION_BYZANTIUM';
--==========================================================================================================================
-- JFD CULTURAL DIVERSITY
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- Civilization_JFD_CultureTypes
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes(
	CivilizationType 				text 		REFERENCES Civilizations(Type) 					default null,
	CultureType 					text														default null,
	SubCultureType 					text														default null,
	ArtDefineTag					text														default	null,
	DecisionsTag					text														default	null,
	DefeatScreenEarlyTag			text														default	null,
	DefeatScreenMidTag				text														default	null,
	DefeatScreenLateTag				text														default	null,
	IdealsTag						text														default	null,
	SplashScreenTag					text														default	null,
	SoundtrackTag					text														default	null,
	UnitDialogueTag					text														default null);

INSERT INTO Civilization_JFD_CultureTypes
		(CivilizationType,			ArtDefineTag, CultureType, SubCultureType, DecisionsTag, DefeatScreenEarlyTag, DefeatScreenMidTag, DefeatScreenLateTag, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT	'CIVILIZATION_US_GEORGIA',	ArtDefineTag, CultureType, SubCultureType, DecisionsTag, DefeatScreenEarlyTag, DefeatScreenMidTag, DefeatScreenLateTag, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_BYZANTIUM';
--------------------------------------------------------------------------------------------------------------------------	
-- Civilizations
--------------------------------------------------------------------------------------------------------------------------	
UPDATE Civilizations 
SET SoundtrackTag = 'JFD_EasternByzantine'
WHERE Type = 'CIVILIZATION_US_GEORGIA'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_EasternByzantine')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CULDIV_SOUNDTRACK_ADDON' AND Value = 1);
--==========================================================================================================================
-- JFD RISE TO POWER
--==========================================================================================================================
--====================================	
-- JFD SOVEREIGNTY
--====================================	
--------------------------------------------------------------------------------------------------------------------------
-- Civilization_JFD_Governments
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Governments (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 					default null,
	LegislatureName					text														default	null,
	OfficeTitle						text														default	null,
	GovernmentType					text														default	null,
	Weight							integer														default	0);

INSERT INTO Civilization_JFD_Governments
		(CivilizationType,			GovernmentType,				Weight)
SELECT	'CIVILIZATION_US_GEORGIA',	'GOVERNMENT_JFD_MONARCHY',	70
FROM Civilization_JFD_Governments WHERE CivilizationType = 'CIVILIZATION_BYZANTIUM';
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

--This table handles all unique Privy Councillor titles. Note that Chaplain titles will override religion-specific ones.	
INSERT INTO JFD_PrivyCouncillor_UniqueNames	
		(PrivyCouncillorType,			CivilizationType,			UniqueName)
VALUES	('COUNCILLOR_JFD_CHANCELLOR',	'CIVILIZATION_US_GEORGIA',	'TXT_KEY_COUNCILLOR_JFD_CHANCELLOR_DESC_US_GEORGIA'),
		('COUNCILLOR_JFD_CHAPLAIN',		'CIVILIZATION_US_GEORGIA',	'TXT_KEY_COUNCILLOR_JFD_CHAPLAIN_DESC_US_GEORGIA'),
		('COUNCILLOR_JFD_MARSHAL',		'CIVILIZATION_US_GEORGIA',	'TXT_KEY_COUNCILLOR_JFD_MARSHAL_DESC_US_GEORGIA'),
		('COUNCILLOR_JFD_HERALD',		'CIVILIZATION_US_GEORGIA',	'TXT_KEY_COUNCILLOR_JFD_HERALD_DESC_US_GEORGIA'),
		('COUNCILLOR_JFD_STEWARD',		'CIVILIZATION_US_GEORGIA',	'TXT_KEY_COUNCILLOR_JFD_STEWARD_DESC_US_GEORGIA');
------------------------------------------------------------
-- Civilization_JFD_Politics
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Politics (
	CivilizationType  					text 		REFERENCES Civilizations(Type) 					default null,
	PoliticsType  						text 														default null,
	UniqueName							text														default	null);

INSERT INTO Civilization_JFD_Politics
		(CivilizationType,				PoliticsType, 				UniqueName)
VALUES	('CIVILIZATION_US_GEORGIA',		'FACTION_JFD_NATIONALIST',	'TXT_KEY_JFD_FACTION_JFD_NATIONALIST_US_GEORGIA'),
		('CIVILIZATION_US_GEORGIA',		'FACTION_JFD_POPULARIST',	'TXT_KEY_JFD_FACTION_JFD_POPULARIST_US_GEORGIA'),
		('CIVILIZATION_US_GEORGIA',		'PARTY_JFD_BURGHERS',		'TXT_KEY_JFD_PARTY_JFD_BURGHERS_US_GEORGIA'),
		('CIVILIZATION_US_GEORGIA',		'PARTY_JFD_CLERGY',			'TXT_KEY_JFD_PARTY_JFD_CLERGY_US_GEORGIA'),
		('CIVILIZATION_US_GEORGIA',		'PARTY_JFD_NOBILITY',		'TXT_KEY_JFD_PARTY_JFD_NOBILITY_US_GEORGIA'),
		('CIVILIZATION_US_GEORGIA',		'PARTY_JFD_REVOLUTIONARY',	'TXT_KEY_JFD_PARTY_JFD_REVOLUTIONARY_US_GEORGIA'),
		('CIVILIZATION_US_GEORGIA',		'PARTY_JFD_CONSERVATIVE',	'TXT_KEY_JFD_PARTY_JFD_CONSERVATIVE_US_GEORGIA'),
		('CIVILIZATION_US_GEORGIA',		'PARTY_PARTY_JFD_LIBERAL',	'TXT_KEY_JFD_PARTY_JFD_LIBERAL_US_GEORGIA'),
		('CIVILIZATION_US_GEORGIA',		'PARTY_JFD_REACTIONARY',	'TXT_KEY_JFD_PARTY_JFD_REACTIONARY_US_GEORGIA'),
		('CIVILIZATION_US_GEORGIA',		'PARTY_JFD_SOCIALIST',		'TXT_KEY_JFD_PARTY_JFD_SOCIALIST_US_GEORGIA'),
		('CIVILIZATION_US_GEORGIA',		'PARTY_JFD_COMMUNIST',		'TXT_KEY_JFD_PARTY_JFD_COMMUNIST_US_GEORGIA'),
		('CIVILIZATION_US_GEORGIA',		'PARTY_JFD_FASCIST',		'TXT_KEY_JFD_PARTY_JFD_FASCIST_US_GEORGIA'),
		('CIVILIZATION_US_GEORGIA',		'PARTY_JFD_LIBERTARIAN',	'TXT_KEY_JFD_PARTY_JFD_LIBERTARIAN_US_GEORGIA');
--==========================================================================================================================
-- SUKRITACT DECISIONS
--==========================================================================================================================
-- DecisionsAddin_Support
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('Georgia_Decisions.lua');
--------------------------------------------------------------------------------------------------------------------------
-- Policies
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policies
		(Type, 								Description)
VALUES	('POLICY_DECISIONS_US_GEORGIA_1', 	'TXT_KEY_DECISIONS_US_GEORGIA_1'),
		('POLICY_DECISIONS_US_GEORGIA_2', 	'TXT_KEY_DECISIONS_US_GEORGIA_2');
--------------------------------------------------------------------------------------------------------------------------
-- Policy_BuildingClassYieldChanges
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_BuildingClassYieldChanges
		(PolicyType, 						BuildingClassType, 				YieldType, 		YieldChange)
VALUES	('POLICY_DECISIONS_US_GEORGIA_1', 	'BUILDINGCLASS_COURTHOUSE',		'YIELD_GOLD',  	2);

INSERT INTO Policy_BuildingClassYieldChanges
		(PolicyType, 						BuildingClassType, 				YieldType, 						YieldChange)
SELECT	'POLICY_DECISIONS_US_GEORGIA_1', 	'BUILDINGCLASS_COURTHOUSE',		'YIELD_GREAT_GENERAL_POINTS',	1
WHERE EXISTS (SELECT Type FROM Yields WHERE Type = 'YIELD_GREAT_GENERAL_POINTS');
--------------------------------------------------------------------------------------------------------------------------
-- BuildingClasses
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO BuildingClasses 	
		(Type, 								DefaultBuilding, 				Description)
VALUES	('BUILDINGCLASS_US_GEORGIA_2',		'BUILDING_US_GEORGIA_2',		'TXT_KEY_BUILDING_US_GEORGIA_2');
--------------------------------------------------------------------------------------------------------------------------	
-- Buildings
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Buildings 	
		(Type, 						 	BuildingClass, 						GreatWorkCount, Cost,	FaithCost,	NeverCapture,	Description, 						Help)
VALUES	('BUILDING_US_GEORGIA_2', 		'BUILDINGCLASS_US_GEORGIA_2',		-1, 			-1,		-1, 		1,				'TXT_KEY_BUILDING_US_GEORGIA_2', 	'TXT_KEY_BUILDING_US_GEORGIA_2_HELP');
--------------------------------------------------------------------------------------------------------------------------	
-- Building_YieldChanges
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Building_YieldChanges
		(BuildingType, 					YieldType,		Yield)
VALUES	('BUILDING_US_GEORGIA_2',		'YIELD_FAITH', 	2),
		('BUILDING_US_GEORGIA_2',		'YIELD_GOLD', 	3);
--==========================================================================================================================
--==========================================================================================================================