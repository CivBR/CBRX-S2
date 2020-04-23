
CREATE TABLE IF NOT EXISTS 
JFD_GlobalUserSettings (
	Type 				text 			default null,
	Value 				integer 		default 1);

CREATE TABLE IF NOT EXISTS DecisionsAddin_Support (
	FileName text default null
);

INSERT INTO DecisionsAddin_Support
		(FileName)
VALUES	('C15_UncleHo_Decisions.lua');

CREATE TABLE IF NOT EXISTS Civilizations_YnAEMP(CivilizationType, MapPrefix, X, Y, CapitalName, AltX, AltY, AltCapitalName);
CREATE TABLE IF NOT EXISTS MinorCivilizations_YnAEMP(MinorCivType, MapPrefix, X, Y, CapitalName, AltX, AltY, AltCapitalName);

INSERT INTO Civilizations_YnAEMP
		(CivilizationType,			MapPrefix, X, Y, CapitalName, AltX, AltY, AltCapitalName)
SELECT	'CIVILIZATION_C15_NVIET',	MapPrefix, X, Y, CapitalName, AltX, AltY, AltCapitalName
FROM MinorCivilizations_YnAEMP WHERE MinorCivType = 'MINOR_CIV_HANOI';

-- I'd rather not tbh
DELETE FROM MinorCivilizations_YnAEMP WHERE MinorCivType = 'MINOR_CIV_HANOI';

-- V24 Stuff
-- Ugh go on then
-- Yeah actually nah fukoff and be happy with your v22

CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
CREATE TABLE IF NOT EXISTS MinorCiv_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_C15_NVIET',	X, Y 
FROM MinorCiv_CordiformStartPosition WHERE Type = 'MINOR_CIV_HANOI';
DELETE FROM MinorCiv_CordiformStartPosition WHERE Type = 'MINOR_CIV_HANOI';

CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
CREATE TABLE IF NOT EXISTS MinorCiv_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_C15_NVIET',	X, Y 
FROM MinorCiv_GreatestEarthStartPosition WHERE Type = 'MINOR_CIV_HANOI';
DELETE FROM MinorCiv_GreatestEarthStartPosition WHERE Type = 'MINOR_CIV_HANOI';

CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
CREATE TABLE IF NOT EXISTS MinorCiv_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_C15_NVIET',	X, Y 
FROM MinorCiv_YagemStartPosition WHERE Type = 'MINOR_CIV_HANOI';
DELETE FROM MinorCiv_YagemStartPosition WHERE Type = 'MINOR_CIV_HANOI';

CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
CREATE TABLE IF NOT EXISTS MinorCiv_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_C15_NVIET',	X, Y 
FROM MinorCiv_YahemStartPosition WHERE Type = 'MINOR_CIV_HANOI';
DELETE FROM MinorCiv_YahemStartPosition WHERE Type = 'MINOR_CIV_HANOI';


CREATE TRIGGER IF NOT EXISTS C15_VietnamYnAEMPTrigger
AFTER INSERT ON MinorCivilizations_YnAEMP
WHEN NEW.MinorCivType = 'MINOR_CIV_HANOI'
BEGIN
	INSERT INTO Civilizations_YnAEMP
			(CivilizationType,			MapPrefix, X, Y, CapitalName, AltX, AltY, AltCapitalName)
	VALUES	('CIVILIZATION_C15_NVIET',	NEW.MapPrefix, NEW.X, NEW.Y, NEW.CapitalName, NEW.AltX, NEW.AltY, NEW.AltCapitalName);
END;

UPDATE Civilizations 
SET ArtStyleSuffix = '_CHINA'
WHERE Type = 'CIVILIZATION_C15_NVIET'
AND EXISTS (SELECT * FROM Civilizations WHERE ArtStyleSuffix = '_CHINA');

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
VALUES	('LEADER_C15_HO',			'FLAVOR_JFD_DECOLONIZATION',		8),
		('LEADER_C15_HO',			'FLAVOR_JFD_SLAVERY',				0),
		('LEADER_C15_HO',			'FLAVOR_JFD_MERCENARY',				8),
		('LEADER_C15_HO',			'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',	7),
		('LEADER_C15_HO',			'FLAVOR_JFD_STATE_RELIGION',		7),
		('LEADER_C15_HO',			'FLAVOR_JFD_REFORM_GOVERNMENT',		3),
		('LEADER_C15_HO',			'FLAVOR_JFD_REFORM_LEGAL',			3),
		('LEADER_C15_HO',			'FLAVOR_JFD_REFORM_CULTURE',		3),
		('LEADER_C15_HO',			'FLAVOR_JFD_REFORM_ECONOMIC',		2),
		('LEADER_C15_HO',			'FLAVOR_JFD_REFORM_FOREIGN',		3),
		('LEADER_C15_HO',			'FLAVOR_JFD_REFORM_INDUSTRY',		3),
		('LEADER_C15_HO',			'FLAVOR_JFD_REFORM_MILITARY',		3),
		('LEADER_C15_HO',			'FLAVOR_JFD_REFORM_RELIGION',		3); -- Communism etc
		

CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Governments (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 					default null,
	CultureType	  					text 		 												default null,
	LegislatureName					text														default	null,
	OfficeTitle						text														default	null,
	GovernmentType					text														default	null,
	Weight							integer														default	0);

INSERT INTO Civilization_JFD_Governments
		(CivilizationType,				LegislatureName, 				OfficeTitle, 						GovernmentType, 			Weight)
VALUES	('CIVILIZATION_C15_NVIET',		'TXT_KEY_LEG_NAME_C15_NVIET', 	'TXT_KEY_HEAD_GVT_NAME_C15_NVIET', 	'GOVERNMENT_JFD_REPUBLIC', 	50);


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
		(CivilizationType,			CultureType,			UnitDialogueTag)
VALUES	('CIVILIZATION_C15_NVIET',	'CULTURE_JFD_MANDALA',	'AS2D_SOUND_JFD_KHMER');

UPDATE Civilizations 
SET SoundtrackTag = 'JFD_Mandala'
WHERE Type = 'CIVILIZATION_C15_NVIET'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Mandala');