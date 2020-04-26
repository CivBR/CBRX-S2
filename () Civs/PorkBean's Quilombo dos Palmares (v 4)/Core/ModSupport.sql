--------------------------------------------------------------------------------------------------------------------------
--==========================================================================================================================
-- MASTER TABLES
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
--Below are the tables required for standard mod support.

CREATE TABLE IF NOT EXISTS COMMUNITY (Type TEXT, Value INTEGER);
CREATE TABLE IF NOT EXISTS Civilization_JFD_ColonialCityNames(CivilizationType text, ColonyName text, LinguisticType text);
CREATE TABLE IF NOT EXISTS Civilization_JFD_Governments(CivilizationType text, CultureType text, LegislatureName text, OfficeTitle text, GovernmentType text, Weight integer);
CREATE TABLE IF NOT EXISTS Civilizations_YnAEMP(CivilizationType, MapPrefix, X, Y, CapitalName, AltX, AltY, AltCapitalName);
CREATE TABLE IF NOT EXISTS Civilizations_YnAEMPRequestedResources(CivilizationType, MapPrefix, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4, Req5, Yield5, Req6, Yield6);
CREATE TABLE IF NOT EXISTS MinorCivilizations_YnAEMP(MinorCivType, MapPrefix, X, Y, CapitalName, AltX, AltY, AltCapitalName);
CREATE TABLE IF NOT EXISTS JFD_Civilopedia_HideFromPedia(Type text);
CREATE TABLE IF NOT EXISTS JFD_GlobalUserSettings(Type text, Value integer default 1);
--=======================================================================================================================
-- BINGLES CIV IV TRAITS
--=======================================================================================================================
--List of traits: https://forums.civfanatics.com/threads/civ-iv-traits-in-civ-v.530701/
------------------------------
-- Leader_SharedTraits
------------------------------	
CREATE TABLE IF NOT EXISTS 
    Leader_SharedTraits (
    LeaderType          text    REFERENCES Leaders(Type)        default null,
    TraitOne            text    REFERENCES Policies(Type)       default null,
    TraitTwo            text    REFERENCES Policies(Type)       default null);
     
INSERT INTO Leader_SharedTraits
        (LeaderType,            TraitOne,                TraitTwo)
SELECT  'LEADER_PB_ZUMBI',		'POLICY_CREATIVE_X',	 'POLICY_INDUSTRIOUS_X'
WHERE EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');
------------------------------	
-- Leaders
------------------------------	
UPDATE Leaders 
SET Description = 'Zumbi [ICON_CULTURE][ICON_PRODUCTION]'
WHERE Type = 'LEADER_PB_ZUMBI'
AND EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');
--------------------------------------------------------------------------------------------------------------------------
--==========================================================================================================================
-- GEDEMON's YNAEMP (+JFD's v23 / 24 / 25)
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Civilizations_YnAEMP
		(CivilizationType,				MapPrefix,			X,	Y,		AltX,	AltY,	AltCapitalName)
VALUES	('CIVILIZATION_PB_PALMARES',	'GreatestEarth',	33,	18,		null,	null,	null),
		('CIVILIZATION_PB_PALMARES',	'EarthMk3',	168,	33,		null,	null,	null),
		('CIVILIZATION_PB_PALMARES',	'AtlanticGiant',	70,	14,		null,	null,	null),
		('CIVILIZATION_PB_PALMARES',	'Yagem',	172,	30,		null,	null,	null),
		('CIVILIZATION_PB_PALMARES',	'SouthAmericaCentralGiant',	123,	85,		null,	null,	null),
		('CIVILIZATION_PB_PALMARES',	'SouthAmericaCentralHuge',	93,	63,		null,	null,	null),
		('CIVILIZATION_PB_PALMARES',	'AmericasGiant',	125,	58,		null,	null,	null),
		('CIVILIZATION_PB_PALMARES',	'SouthAmericaLarge',	79,	62,		null,	null,	null),
		('CIVILIZATION_PB_PALMARES',	'SouthAmericaGiant',	116,	101,		null,	null,	null),
		('CIVILIZATION_PB_PALMARES',	'Americas',	60,	28,		null,	null,	null),
		('CIVILIZATION_PB_PALMARES',	'Cordiform',	21,	14,		null,	null,	null),
		('CIVILIZATION_PB_PALMARES',	'Yahem',	43,	28,		null,	null,	null);

--CapitalName and AltCapitalName set a custom City Name on settlement at XY/AltXY coordinates, if needed. Should be TXT_KEY that refers to a string defined elsewhere.
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_YagemRequestedResource
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Civilizations_YnAEMPRequestedResources
		(CivilizationType, 			 MapPrefix, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_PB_PALMARES', MapPrefix, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_BRAZIL';
--==========================================================================================================================
-- JFDLC
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- LEADER FLAVOURS
--------------------------------------------------------------------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_DECOLONIZATION'), --0-10. Determines likelihood for annexing a colony, where 0 means never, and 10 means as soon as possible.
		('FLAVOR_JFD_MERCENARY'), --0-10. Determines likelihood of taking out Mercenary Contracts, where 0 means never, and 10 means as soon as possible.
		('FLAVOR_JFD_REFORM_GOVERNMENT'), --0-10. Determines Reform preference; corresponding to Left>Centre>Right/Liberal to Authoritarian continuum. 1-4=Left, 5-6=Centre, 7-10=Right. For government issues.
		('FLAVOR_JFD_REFORM_LEGAL'), --same as above for legal issues. 
		('FLAVOR_JFD_REFORM_CULTURE'), --same as above for cultural issues.
		('FLAVOR_JFD_REFORM_ECONOMIC'), --same as above for economic issues. 
		('FLAVOR_JFD_REFORM_EDUCATION'), --same as above for educational issues.
		('FLAVOR_JFD_REFORM_FOREIGN'), --same as above for diplomatic/international issues.
		('FLAVOR_JFD_REFORM_INDUSTRY'), --same as above for industrial/labour issues.
		('FLAVOR_JFD_REFORM_MILITARY'), --same as above for military issues.
		('FLAVOR_JFD_REFORM_RELIGION'), --same as above for religious issues.
		('FLAVOR_JFD_RELIGIOUS_INTOLERANCE'), --0-12. Determines the diplomatic penalty/bonus with leaders of a different/same state religion
		('FLAVOR_JFD_SLAVERY'), --0-10. Determines likelihood of enslaving Cities and spending Shackles on Slave Units, where 0 means never, and 10 as much as possible.
		('FLAVOR_JFD_STATE_RELIGION'); --0-12. Determines chance to adopt a State Religion, where 0 means never. 9+ also means this leader will never secularize.

INSERT INTO Leader_Flavors
		(LeaderType,				FlavorType,							 Flavor)
VALUES	('LEADER_PB_ZUMBI',	'FLAVOR_JFD_DECOLONIZATION',		 7),
		('LEADER_PB_ZUMBI',	'FLAVOR_JFD_MERCENARY',				 6),
		('LEADER_PB_ZUMBI',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',	 4),
		('LEADER_PB_ZUMBI',	'FLAVOR_JFD_REFORM_GOVERNMENT',		 4), --Scale of Liberal to Authoritarian.
		('LEADER_PB_ZUMBI',	'FLAVOR_JFD_REFORM_LEGAL',			 3), 	
		('LEADER_PB_ZUMBI',	'FLAVOR_JFD_REFORM_CULTURE',		 2),
		('LEADER_PB_ZUMBI',	'FLAVOR_JFD_REFORM_ECONOMIC',		 5),
		('LEADER_PB_ZUMBI',	'FLAVOR_JFD_REFORM_EDUCATION',	 	 5),
		('LEADER_PB_ZUMBI',	'FLAVOR_JFD_REFORM_FOREIGN',		 8),
		('LEADER_PB_ZUMBI',	'FLAVOR_JFD_REFORM_INDUSTRY',		 3),
		('LEADER_PB_ZUMBI',	'FLAVOR_JFD_REFORM_MILITARY',		 7),
		('LEADER_PB_ZUMBI',	'FLAVOR_JFD_REFORM_RELIGION',		 3),
		('LEADER_PB_ZUMBI',	'FLAVOR_JFD_SLAVERY',				 3),
		('LEADER_PB_ZUMBI',	'FLAVOR_JFD_STATE_RELIGION',		 3);
		
--Note that the following values will be used if none are specified:
--FLAVOR_JFD_DECOLONIZATION == FLAVOR_EXPANSION
--FLAVOR_JFD_MERCENARY == FLAVOR_OFFENSE
--FLAVOR_JFD_REFORM_GOVERNMENT == FLAVOR_GROWTH
--FLAVOR_JFD_REFORM_LEGAL == FLAVOR_HAPPINESS
--FLAVOR_JFD_REFORM_CULTURE == FLAVOR_CULTURE
--FLAVOR_JFD_REFORM_ECONOMIC == FLAVOR_GOLD
--FLAVOR_JFD_REFORM_EDUCATION == FLAVOR_SCIENCE
--FLAVOR_JFD_REFORM_FOREIGN == FLAVOR_DIPLOMACY
--FLAVOR_JFD_REFORM_INDUSTRY == FLAVOR_PRODUCTION
--FLAVOR_JFD_REFORM_MILITARY == FLAVOR_OFFENSE
--FLAVOR_JFD_REFORM_RELIGION == FLAVOR_RELIGION
--FLAVOR_JFD_RELIGIOUS_INTOLERANCE == FLAVOR_RELIGION
--FLAVOR_JFD_SLAVERY == FLAVOR_OFFENSE
--FLAVOR_JFD_STATE_RELIGION == FLAVOR_RELIGION
--------------------------------------------------------------------------------------------------------------------------
-- JFD'S CULTURAL DIVERSITY (31a31d1c-b9d7-45e1-842c-23232d66cd47)
--------------------------------------------------------------------------------------------------------------------------	
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

--This is an example of support which copies all attributes from an existing civ. 
--For the most part, this is probably all you'll need; just change 'CIVILIZATION_PB_PALMARES' to the tag of your custom civ. 
INSERT INTO Civilization_JFD_CultureTypes
		(CivilizationType,				ArtDefineTag, CultureType, SubCultureType, DecisionsTag, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT	'CIVILIZATION_PB_PALMARES',	ArtDefineTag, 'CULTURE_JFD_BANTU', SubCultureType, DecisionsTag, IdealsTag, 'JFD_WestAfrican', SoundtrackTag, 'AS2D_SOUND_JFD_LATINO'
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_BRAZIL';

UPDATE Civilizations 
SET SoundtrackTag = 'JFD_WestAfrican'
WHERE Type = 'CIVILIZATION_PB_PALMARES'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_WestAfrican');