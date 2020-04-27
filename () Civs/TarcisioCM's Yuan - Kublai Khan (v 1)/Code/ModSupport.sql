
CREATE TABLE IF NOT EXISTS 
JFD_GlobalUserSettings (
	Type 				text 			default null,
	Value 				integer 		default 1);

INSERT INTO Policies
		(Type,					Description)
VALUES	('POLICY_TAR_YUAN_GHS',	'TXT_KEY_DECISIONS_TAR_GUANG_HUI_SI'),
		('POLICY_TAR_CHAO',		'TXT_KEY_DECISIONS_TAR_CHAO');
		
INSERT INTO Policy_HurryModifiers
		(PolicyType,			HurryType,		HurryCostModifier)
VALUES	('POLICY_TAR_CHAO',		'HURRY_GOLD',	-25);

INSERT INTO BuildingClasses
		(Type,										DefaultBuilding,						Description)
VALUES	('BUILDINGCLASS_TAR_YUAN_GHS_SPECIALISTS',	'BUILDING_TAR_YUAN_GHS_SPECIALISTS',	'TXT_KEY_DECISIONS_TAR_GUANG_HUI_SI'),
		('BUILDINGCLASS_TAR_YUAN_GHS_HOSPITAL',		'BUILDING_TAR_YUAN_GHS_HOSPITAL',		'TXT_KEY_DECISIONS_TAR_GUANG_HUI_SI'),
		('BUILDINGCLASS_TAR_YUAN_CHAO_MINT_NEG',	'BUILDING_TAR_YUAN_CHAO_MINT_NEG',		'TXT_KEY_DECISIONS_TAR_CHAO');
		
INSERT INTO Buildings
		(Type,									BuildingClass,								Description,							Cost,	FaithCost,	GreatWorkCount,	PrereqTech,	IconAtlas,		PortraitIndex,	NeverCapture,	NukeImmune)
VALUES	('BUILDING_TAR_YUAN_GHS_HOSPITAL',		'BUILDINGCLASS_TAR_YUAN_GHS_HOSPITAL',		'TXT_KEY_DECISIONS_TAR_GUANG_HUI_SI',	-1,		-1,			-1,				NULL,		'BW_ATLAS_1',	13,				1,				1),
		('BUILDING_TAR_YUAN_GHS_SPECIALISTS',	'BUILDINGCLASS_TAR_YUAN_GHS_SPECIALISTS',	'TXT_KEY_DECISIONS_TAR_GUANG_HUI_SI',	-1,		-1,			-1,				NULL,		'BW_ATLAS_1',	13,				1,				1), -- Hm I suppose a query would've been better wouldn't it
		('BUILDING_TAR_YUAN_CHAO_MINT_NEG',		'BUILDINGCLASS_TAR_YUAN_CHAO_MINT_NEG',		'TXT_KEY_DECISIONS_TAR_CHAO',			-1,		-1,			-1,				NULL,		'BW_ATLAS_1',	13,				1,				1);
		
UPDATE Buildings
SET FreeBuildingThisCity = 'BUILDINGCLASS_HOSPITAL'
WHERE Type = 'BUILDING_TAR_YUAN_GHS_HOSPITAL';

INSERT INTO Building_SpecialistYieldChanges
		(BuildingType,							SpecialistType,			YieldType,		Yield)
VALUES	('BUILDING_TAR_YUAN_GHS_SPECIALISTS',	'SPECIALIST_SCIENTIST',	'YIELD_FOOD',	1);

INSERT INTO Building_SpecialistYieldChanges
		(BuildingType,							SpecialistType,				YieldType,		Yield)
SELECT	'BUILDING_TAR_YUAN_GHS_SPECIALISTS',	'SPECIALIST_JFD_DOCTOR',	'YIELD_FOOD',	1
WHERE EXISTS (SELECT Type FROM Specialists WHERE Type = 'SPECIALIST_JFD_DOCTOR');

UPDATE Building_SpecialistYieldChanges
SET YieldType = 'YIELD_JFD_HEALTH'
WHERE BuildingType = 'BUILDING_TAR_YUAN_GHS_SPECIALISTS'
AND EXISTS (SELECT Type FROM Yields WHERE Type = 'YIELD_JFD_HEALTH');

INSERT INTO Building_ResourceYieldChanges
		(BuildingType,							ResourceType,				YieldType,		Yield)
SELECT	'BUILDING_TAR_YUAN_CHAO_MINT_NEG',		ResourceType,				YieldType,		Yield * -1
FROM Building_ResourceYieldChanges WHERE BuildingType = 'BUILDING_MINT';

CREATE TRIGGER Tar_Yuan_JFD_Specialist_Added
AFTER INSERT ON Specialists
WHEN NEW.Type = 'SPECIALIST_JFD_DOCTOR'
BEGIN
	INSERT INTO Building_SpecialistYieldChanges
			(BuildingType,							SpecialistType,	YieldType,																														Yield)
	VALUES	('BUILDING_TAR_YUAN_GHS_SPECIALISTS',	NEW.Type,		(CASE WHEN EXISTS (SELECT Type FROM Yields WHERE Type = 'YIELD_JFD_HEALTH') THEN 'YIELD_JFD_HEALTH' ELSE 'YIELD_FOOD' END),	1);
END;


CREATE TRIGGER Tar_Yuan_JFD_Yield_Added
AFTER INSERT ON Yields
WHEN NEW.Type = 'YIELD_JFD_HEALTH'
BEGIN
	UPDATE Building_SpecialistYieldChanges
	SET YieldType = NEW.Type
	WHERE BuildingType = 'BUILDING_TAR_YUAN_GHS_SPECIALISTS';
END;

-- Fukin rip Policy_SpecialistExtraYields tbh

CREATE TRIGGER Tar_Yuan_Mint_Resource_Added
AFTER INSERT ON Building_ResourceYieldChanges
WHEN NEW.BuildingType = 'BUILDING_MINT'
BEGIN
	INSERT INTO Building_ResourceYieldChanges
			(BuildingType,							ResourceType,				YieldType,		Yield)
	VALUES	('BUILDING_TAR_YUAN_CHAO_MINT_NEG',		NEW.ResourceType,			NEW.YieldType,	NEW.Yield * -1);
END;

CREATE TABLE IF NOT EXISTS DecisionsAddin_Support (
	FileName text default null
);

INSERT INTO DecisionsAddin_Support
		(FileName)
VALUES	('YuanDecisions.lua');

UPDATE Civilizations 
SET ArtStyleSuffix = '_MONGOL'
WHERE Type = 'CIVILIZATION_TAR_YUAN'
AND EXISTS (SELECT * FROM Civilizations WHERE ArtStyleSuffix = '_MONGOL');

CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes(
	CivilizationType 					text 			default null,
	CultureType 						text			default null,
	SubCultureType 						text			default null,
	ArtDefineTag						text			default	null,
	DecisionsTag						text			default null,
	DefeatScreenEarlyTag				text			default	null,
	DefeatScreenMidTag					text			default	null,
	DefeatScreenLateTag					text			default	null,
	IdealsTag							text			default	null,
	SplashScreenTag						text			default	null,
	SoundtrackTag						text			default	null,
	UnitDialogueTag						text			default null);
	
INSERT INTO Civilization_JFD_CultureTypes
		(CivilizationType,				ArtDefineTag, CultureType, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT	'CIVILIZATION_TAR_YUAN',	ArtDefineTag, CultureType, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_CHINA';

UPDATE Civilizations 
SET SoundtrackTag = 'JFD_Oriental'
WHERE Type = 'CIVILIZATION_TAR_YUAN'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Oriental');

INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_DECOLONIZATION'),
		('FLAVOR_JFD_SLAVERY'),
		('FLAVOR_JFD_MERCENARY'),
		('FLAVOR_JFD_RELIGIOUS_INTOLERANCE'),
		('FLAVOR_JFD_STATE_RELIGION'),
		('FLAVOR_JFD_REFORM_GOVERNMENT'),
		('FLAVOR_JFD_REFORM_LEGAL'),
		('FLAVOR_JFD_REFORM_CULTURE'),
		('FLAVOR_JFD_REFORM_ECONOMIC'),
		('FLAVOR_JFD_REFORM_FOREIGN'),
		('FLAVOR_JFD_REFORM_INDUSTRY'),
		('FLAVOR_JFD_REFORM_MILITARY'),
		('FLAVOR_JFD_REFORM_RELIGION');

INSERT INTO Leader_Flavors
		(LeaderType,				FlavorType,							Flavor)
VALUES	('LEADER_TAR_KUBLAI_KHAN',	'FLAVOR_JFD_DECOLONIZATION',		1),
		('LEADER_TAR_KUBLAI_KHAN',	'FLAVOR_JFD_SLAVERY',				6),
		('LEADER_TAR_KUBLAI_KHAN',	'FLAVOR_JFD_MERCENARY',				6),
		('LEADER_TAR_KUBLAI_KHAN',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',	4),
		('LEADER_TAR_KUBLAI_KHAN',	'FLAVOR_JFD_STATE_RELIGION',		9),
		('LEADER_TAR_KUBLAI_KHAN',	'FLAVOR_JFD_REFORM_GOVERNMENT',		7),
		('LEADER_TAR_KUBLAI_KHAN',	'FLAVOR_JFD_REFORM_LEGAL',			7),
		('LEADER_TAR_KUBLAI_KHAN',	'FLAVOR_JFD_REFORM_CULTURE',		7),
		('LEADER_TAR_KUBLAI_KHAN',	'FLAVOR_JFD_REFORM_ECONOMIC',		7),
		('LEADER_TAR_KUBLAI_KHAN',	'FLAVOR_JFD_REFORM_FOREIGN',		7),
		('LEADER_TAR_KUBLAI_KHAN',	'FLAVOR_JFD_REFORM_INDUSTRY',		7),
		('LEADER_TAR_KUBLAI_KHAN',	'FLAVOR_JFD_REFORM_MILITARY',		7),
		('LEADER_TAR_KUBLAI_KHAN',	'FLAVOR_JFD_REFORM_RELIGION',		7);
		
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Governments (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 					default null,
	CultureType	  					text 		 												default null,
	LegislatureName					text														default	null,
	OfficeTitle						text														default	null,
	GovernmentType					text														default	null,
	Weight							integer														default	0);

INSERT INTO Civilization_JFD_Governments
		(CivilizationType,				LegislatureName, 											OfficeTitle, 														GovernmentType, 			Weight)
VALUES	('CIVILIZATION_TAR_YUAN',		'TXT_KEY_JFD_LEGISLATURE_NAME_CIVILIZATION_JFD_SCOTLAND', 	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_SCOTLAND', 	'GOVERNMENT_JFD_MONARCHY', 	100);

CREATE TABLE IF NOT EXISTS Civilizations_YnAEMP(CivilizationType, MapPrefix, X, Y, CapitalName, AltX, AltY, AltCapitalName);

-- Stolen from v25 Files
INSERT OR REPLACE INTO Civilizations_YnAEMP
		(CivilizationType,			MapPrefix,			 			X, 		Y, 		CapitalName, 	AltX, 	AltY, 	AltCapitalName)
VALUES	('CIVILIZATION_TAR_YUAN',	'AfriAsiaAus',					106,	77,		null,			null,	null,	null),
		('CIVILIZATION_TAR_YUAN',	'AsiaSmall',					28,		40,		null,			null,	null,	null),
		('CIVILIZATION_TAR_YUAN',	'Asia',							67,		55,		null,			null,	null,	null),
		('CIVILIZATION_TAR_YUAN',	'AsiaSteppeGiant',				156,	20,		null,			null,	null,	null),
		('CIVILIZATION_TAR_YUAN',	'Cordiform',					60,		35,		null,			null,	null,	null),
		('CIVILIZATION_TAR_YUAN',	'GreatestEarth',				87,		54,		null,			null,	null,	null),
		('CIVILIZATION_TAR_YUAN',	'NorthEastAsia',				6,		40,		null,			null,	null,	null),
		('CIVILIZATION_TAR_YUAN',	'Pacific',						33,		59,		null,			null,	null,	null),
		('CIVILIZATION_TAR_YUAN',	'Yagem',						83,		65,		null,			null,	null,	null),
		('CIVILIZATION_TAR_YUAN',	'Yahem',						105,	52,		null,			null,	null,	null);

INSERT OR REPLACE INTO Civilizations_YnAEMP
		(CivilizationType,			MapPrefix, X, Y, CapitalName, AltX, AltY, AltCapitalName)
SELECT	'CIVILIZATION_TAR_YUAN',	MapPrefix, X, Y, CapitalName, AltX, AltY, AltCapitalName
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_CHINA';

-- Stolen from MSF
-- Just remember kids I'm allowed to copy and paste stuff because I'm a professional who knows what they're doing...

--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_CordiformStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_TAR_YUAN',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_TAR_YUAN' AND MapPrefix = 'Cordiform';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_GreatestEarthStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_TAR_YUAN',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_TAR_YUAN' AND MapPrefix = 'GreatestEarth';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_YagemStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_TAR_YUAN',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_TAR_YUAN' AND MapPrefix = 'Yagem';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_YahemStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_TAR_YUAN',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_TAR_YUAN' AND MapPrefix = 'Yahem';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AsiaStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AsiaStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AsiaStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_TAR_YUAN',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_TAR_YUAN' AND MapPrefix = 'Asia';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_PacificStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_PacificStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_PacificStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_TAR_YUAN',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_TAR_YUAN' AND MapPrefix = 'Pacific';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AfriAsiaAustStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AfriAsiaAustStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AfriAsiaAustStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_TAR_YUAN',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_TAR_YUAN' AND MapPrefix = 'AfriAsiaAust';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AsiaSmallStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AsiaSmallStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AsiaSmallStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_TAR_YUAN',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_TAR_YUAN' AND MapPrefix = 'AsiaSmall';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AsiaSteppeGiantStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AsiaSteppeGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AsiaSteppeGiantStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_TAR_YUAN',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_TAR_YUAN' AND MapPrefix = 'AsiaSteppeGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_NorthEastAsiaStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthEastAsiaStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthEastAsiaStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_TAR_YUAN',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_TAR_YUAN' AND MapPrefix = 'NorthEastAsia';