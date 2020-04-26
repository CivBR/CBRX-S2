--=======================================================================================================================
-- SUKRITACT'S EVENTS AND DECISIONS
--=======================================================================================================================
--Decisions
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('Decisions_GranColombia.lua');
--Events
CREATE TABLE IF NOT EXISTS EventsAddin_Support(FileName);
INSERT INTO EventsAddin_Support (FileName) VALUES ('LatinAmericanEvents.lua');

--=======================================================================================================================
-- Tomatekh's Historical Religions
--=======================================================================================================================

--=======================================================================================================================
-- Enlightenment Era
--=======================================================================================================================

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
VALUES  ('LEADER_PG_BOLIVAR',	'POLICY_IMPERIALISTIC_X',	'POLICY_PHILOSOPHICAL_X');
------------------------------	
-- Leaders
------------------------------	
UPDATE Leaders 
SET Description = 'Simon Bolivar [ICON_CITY_STATE][ICON_GREAT_PEOPLE]'
WHERE Type = 'LEADER_PG_BOLIVAR'
AND EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');

--==========================================================================================================================
-- GEDEMON R.E.D.
--==========================================================================================================================
-- Civilizations
------------------------------	

UPDATE Civilizations 
SET ArtStyleSuffix = '_INCA'
WHERE Type = 'CIVILIZATION_PG_GRANCOLOMBIA'
AND EXISTS (SELECT * FROM Civilizations WHERE ArtStyleSuffix = '_INCA');

--==========================================================================================================================
-- GEDEMON YNAEMP
--==========================================================================================================================
-- Civilizations_YagemStartPosition (Earth Giant)
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
		(Type,							X,	 Y)
VALUES	('CIVILIZATION_PG_GRANCOLOMBIA',	153, 37);

CREATE TABLE IF NOT EXISTS MinorCiv_YagemStartPosition(Type, X, Y, AltX, AltY);
DELETE FROM MinorCiv_YagemStartPosition WHERE Type IN ('MINOR_CIV_BOGOTA');
DELETE FROM MinorCiv_YagemStartPosition WHERE Type IN ('MINOR_CIV_PANAMA_CITY');
INSERT INTO MinorCiv_YagemStartPosition
		(Type,						 X,	  Y)
VALUES	('MINOR_CIV_BOGOTA',		149, 35), -- Quito
		('MINOR_CIV_PANAMA_CITY',	161, 49); -- San Juan

------------------------------------------------------------
-- Civilizations_YahemStartPosition (Earth Huge)
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
		(Type,							X,	 Y)
VALUES	('CIVILIZATION_PG_GRANCOLOMBIA',	31,  36);

CREATE TABLE IF NOT EXISTS MinorCiv_YahemStartPosition(Type, X, Y, AltX, AltY);
DELETE FROM MinorCiv_YahemStartPosition WHERE Type IN ('MINOR_CIV_BOGOTA');
DELETE FROM MinorCiv_YahemStartPosition WHERE Type IN ('MINOR_CIV_PANAMA_CITY');
INSERT INTO MinorCiv_YahemStartPosition
		(Type,						X,	 Y)
VALUES	('MINOR_CIV_BOGOTA',		27, 33), -- Quito
		('MINOR_CIV_PANAMA_CITY',	32, 43); -- San Juan

------------------------------------------------------------
-- Civilizations_CordiformStartPosition (Earth Standard)
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
		(Type,							 X,	 Y)
VALUES	('CIVILIZATION_PG_GRANCOLOMBIA',	 14, 18);

CREATE TABLE IF NOT EXISTS MinorCiv_CordiformStartPosition(Type, X, Y, AltX, AltY);
DELETE FROM MinorCiv_CordiformStartPosition WHERE Type IN ('MINOR_CIV_BOGOTA');
DELETE FROM MinorCiv_CordiformStartPosition WHERE Type IN ('MINOR_CIV_PANAMA_CITY');
INSERT INTO MinorCiv_CordiformStartPosition
		(Type,						X,	 Y)
VALUES	('MINOR_CIV_BOGOTA',		10, 17), -- Quito
		('MINOR_CIV_PANAMA_CITY',	14, 24); -- San Juan

------------------------------------------------------------
-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
		(Type,								X,	Y)
VALUES	('CIVILIZATION_PG_GRANCOLOMBIA',	23, 23);

CREATE TABLE IF NOT EXISTS MinorCiv_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
DELETE FROM MinorCiv_GreatestEarthStartPosition WHERE Type IN ('MINOR_CIV_BOGOTA');
DELETE FROM MinorCiv_GreatestEarthStartPosition WHERE Type IN ('MINOR_CIV_PANAMA_CITY');
INSERT INTO MinorCiv_GreatestEarthStartPosition
		(Type,				 X,	 Y)
VALUES	('MINOR_CIV_BOGOTA',		20, 20), -- Quito
		('MINOR_CIV_PANAMA_CITY',	29, 32); -- San Juan


------------------------------------------------------------	
-- Civilizations_YagemRequestedResource (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource
		(Type, 							Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_PG_RIODELAPLATA',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE Type = 'CIVILIZATION_INCA';
------------------------------------------------------------	
-- Civilizations_YahemRequestedResource (Earth Large)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YahemRequestedResource
		(Type, 							Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_PG_RIODELAPLATA',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE Type = 'CIVILIZATION_INCA';
------------------------------------------------------------	
-- Civilizations_GreatestEarthRequestedResource (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_GreatestEarthRequestedResource
		(Type, 							Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_PG_RIODELAPLATA',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_GreatestEarthRequestedResource WHERE Type = 'CIVILIZATION_INCA';

--==========================================================================================================================
-- JFD CULTURAL DIVERSITY
--==========================================================================================================================
-- Civilization_JFD_CultureTypes
------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes(
	CivilizationType 							text 											default null,
	CultureType 								text											default null,
	ArtDefineTag								text											default	null,
	DefeatScreenEarlyTag						text											default	null,
	DefeatScreenMidTag							text											default	null,
	DefeatScreenLateTag							text											default	null,
	IdealsTag									text											default	null,
	SplashScreenTag								text											default	null,
	SoundtrackTag								text											default	null,
	UnitDialogueTag								text											default null);

INSERT OR REPLACE INTO Civilization_JFD_CultureTypes
		(CivilizationType,					ArtDefineTag,		CultureType,				DefeatScreenEarlyTag,			DefeatScreenMidTag,				DefeatScreenLateTag,				IdealsTag,			SplashScreenTag,		SoundtrackTag,			UnitDialogueTag)
VALUES	('CIVILIZATION_PG_GRANCOLOMBIA',	'_JFD_WESTERN',		'CULTURE_JFD_COLONIAL',		'DefeatScreenEarlyAndean.dds',	'DefeatScreenMidAndean.dds',	'DefeatScreenLateBrazil.dds',		'JFD_Colonial',		'JFD_ColonialLatin',	'Brazil',				'AS2D_SOUND_JFD_LATINO');

------------------------------	
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET SoundtrackTag = 'JFD_ColonialLatin'
WHERE Type = 'CIVILIZATION_PG_GRANCOLOMBIA'
AND EXISTS (SELECT * FROM Audio_Sounds WHERE SoundID = 'SND_JFD_COLONIALLATIN_PEACE_01');

--==========================================================================================================================
-- JFD CITIES IN DEVELOPMENT
--==========================================================================================================================
--====================================	
-- JFD COLONIES
--====================================	
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
		(LeaderType,				FlavorType,					Flavor)
VALUES	('LEADER_PG_BOLIVAR',	'FLAVOR_JFD_DECOLONIZATION',	10);
--====================================	
-- JFD DEVELOPMENT
--====================================	
--====================================
-- JFD PROVINCES 
--====================================
-- Civilization_JFD_ProvinceTitles
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_ProvinceTitles (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 					default null,
	ReligionType  					text 		REFERENCES Religions(Type) 						default null,
	DefaultTitle					text 		 												default null,
	UniqueTitle						text 		 												default null,
	UseAdjective					boolean														default 0);	

INSERT INTO Civilization_JFD_ProvinceTitles
		(CivilizationType,				DefaultTitle,								UniqueTitle)
VALUES	('CIVILIZATION_PG_GRANCOLOMBIA',		'TXT_KEY_PROVINCE_JFD_BARONY_DESC',			'TXT_KEY_PROVINCE_JFD_BARONY_DESC_PG_GRANCOLOMBIA'),
		('CIVILIZATION_PG_GRANCOLOMBIA',		'TXT_KEY_PROVINCE_JFD_BARONY_DESC_RULER',	'TXT_KEY_PROVINCE_JFD_BARONY_DESC_RULER_PG_GRANCOLOMBIA'),
		('CIVILIZATION_PG_GRANCOLOMBIA',		'TXT_KEY_PROVINCE_JFD_COUNTY_DESC',			'TXT_KEY_PROVINCE_JFD_COUNTY_DESC_PG_GRANCOLOMBIA'),
		('CIVILIZATION_PG_GRANCOLOMBIA',		'TXT_KEY_PROVINCE_JFD_COUNTY_DESC_RULER',	'TXT_KEY_PROVINCE_JFD_COUNTY_DESC_RULER_PG_GRANCOLOMBIA'),
		('CIVILIZATION_PG_GRANCOLOMBIA',		'TXT_KEY_PROVINCE_JFD_DUCHY_DESC',			'TXT_KEY_PROVINCE_JFD_DUCHY_DESC_PG_GRANCOLOMBIA'),
		('CIVILIZATION_PG_GRANCOLOMBIA',		'TXT_KEY_PROVINCE_JFD_DUCHY_DESC_RULER',	'TXT_KEY_PROVINCE_JFD_DUCHY_DESC_RULER_PG_GRANCOLOMBIA'),
		('CIVILIZATION_PG_GRANCOLOMBIA',		'TXT_KEY_PROVINCE_JFD_COLONY_DESC',			'TXT_KEY_PROVINCE_JFD_COLONY_DESC_PG_GRANCOLOMBIA'),
		('CIVILIZATION_PG_GRANCOLOMBIA',		'TXT_KEY_PROVINCE_JFD_COLONY_DESC_RULER',	'TXT_KEY_PROVINCE_JFD_COLONY_DESC_RULER_PG_GRANCOLOMBIA');

--====================================	
-- JFD SLAVERY
--====================================	
-- Flavors
------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_SLAVERY');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------
INSERT INTO Leader_Flavors
		(LeaderType,			FlavorType,				Flavor)
VALUES	('LEADER_PG_BOLIVAR',	'FLAVOR_JFD_SLAVERY',	0);

--==========================================================================================================================	
-- JFD AND POUAKAI MERCENARIES
--==========================================================================================================================
------------------------------------------------------------
-- Flavors
------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_MERCENARY');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------	
INSERT INTO Leader_Flavors
		(LeaderType,			FlavorType,				Flavor)
VALUES	('LEADER_PG_BOLIVAR',	'FLAVOR_JFD_MERCENARY',	 8);

UPDATE Traits
SET Description = 'TXT_KEY_TRAIT_PG_GRANCOLOMBIA_RTP'
WHERE Type = 'TRAIT_PG_GRANCOLOMBIA' 
AND EXISTS (SELECT * FROM Units WHERE Type = 'UNIT_JFD_GREAT_SCOUT'); 

--==========================================================================================================================	
-- JFD's RISE TO POWER (eea66053-7579-481a-bb8d-2f3959b59974)
--==========================================================================================================================	
-- PIETY
--==========================================================	
-- Flavors
------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_RELIGIOUS_INTOLERANCE'),
		('FLAVOR_JFD_STATE_RELIGION');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------	
--Religous Intolerance: A value of 0-12 may be set. This value determines the diplomatic penalty/bonus with civilizations of a different/same state religion
--State Religion: A value of 0-12 may be set. This value determines the chance to adopt a State Religion. A value higher than 9 means this civilization will never secularise. A value of 0 means this civilization has no interest in State Religion.
INSERT INTO Leader_Flavors
		(LeaderType,			FlavorType,								Flavor)
VALUES	('LEADER_PG_BOLIVAR',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',		1),
		('LEADER_PG_BOLIVAR',	'FLAVOR_JFD_STATE_RELIGION',			1);
--==========================================================	
-- PROSPERITY
--==========================================================
-- Civilization_JFD_Currencies
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Currencies (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 	default null,
	CurrencyType	  				text 		  								default null);

INSERT INTO Civilization_JFD_Currencies
		(CivilizationType,		CurrencyType)
SELECT	'CIVILIZATION_PG_GRANCOLOMBIA',	CurrencyType
FROM Civilization_JFD_Currencies WHERE CivilizationType = 'CIVILIZATION_BRAZIL';	
--==========================================================	
-- SOVEREIGNTY
--==========================================================
-- Civilization_JFD_Governments
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Governments (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 					default null,
	CultureType	  					text 		 												default null,
	LegislatureName					text														default	null,
	OfficeTitle						text														default	null,
	GovernmentType					text														default	null,
	Weight							integer														default	0);

--This table determines a variety of things relating to your Government.
--The LegislatureName refers to the name of your Legislature (e.g. the Imperial Diet). 
--The OfficeTitle refers to the title of your Head of Government (e.g. Vizier. Default is Prime Minister)
--GovernmentType and Weight prefer to a Government preference (GOVERNMENT_JFD_MONARCHY or GOVERNMENT_JFD_REPUBLIC or GOVERNMENT_JFD_THEOCRACY or GOVERNMENT_JFD_DICTATORSHIP) and how strong that preference is.
INSERT INTO Civilization_JFD_Governments
		(CivilizationType,				LegislatureName, 												OfficeTitle, 									GovernmentType, 				Weight)
VALUES	('CIVILIZATION_PG_GRANCOLOMBIA','TXT_KEY_JFD_LEGISLATURE_NAME_CIVILIZATION_PG_GRANCOLOMBIA', 	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_PG_GRANCOLOMBIA', 	'GOVERNMENT_JFD_DICTATORSHIP', 	100);
------------------------------------------------------------	
-- Civilization_JFD_HeadsOfGovernment	
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 	
	Civilization_JFD_HeadsOfGovernment (	
	CivilizationType  				text 		REFERENCES Civilizations(Type) 					default null,
	CultureType						text 		 												default null,
	HeadOfGovernmentName			text 		 												default null);

--These are the Heads of your Government, which are randomly chosen when a new Legislature is formed.
--The standard number for each civ is 25. However, you may leave this table empty and your civ will call
--from a cultural list (so long as you have Cultural Diversity support).
INSERT INTO Civilization_JFD_HeadsOfGovernment
        (CivilizationType,      			HeadOfGovernmentName)
VALUES  ('CIVILIZATION_PG_GRANCOLOMBIA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_PG_GRANCOLOMBIA_1'),
		('CIVILIZATION_PG_GRANCOLOMBIA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_PG_GRANCOLOMBIA_2'),
		('CIVILIZATION_PG_GRANCOLOMBIA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_PG_GRANCOLOMBIA_3');

------------------------------------------------------------
-- Civilization_JFD_Titles
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Titles (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 					default null,
	CultureType						text 		 												default null,
	ReligionType					text 		REFERENCES Religions(Type) 						default null,
	DefaultTitle					text 		 												default null,
	UniqueTitle						text 		 												default null,
	UseAdjective					boolean														default 0);	

--This lists all the unique titles that a civilization should use instead of a standard one. If left blank, a culture-specific title will be used instead (if CulDiv support).
--The default titles are as follows:
----TXT_KEY_GOVERNMENT_JFD_TRIBE_TITLE_GOVERNMENT (Tribe)
----TXT_KEY_GOVERNMENT_JFD_TRIBE_TITLE_LEADER (Chief/Chieftess)
----TXT_KEY_GOVERNMENT_JFD_PRINCIPALITY_TITLE_LEADER (Grand Prince)
----TXT_KEY_GOVERNMENT_JFD_PRINCIPALITY_TITLE_GOVERNMENT (Grand Principality)
----TXT_KEY_GOVERNMENT_JFD_MONARCHY_TITLE_LEADER (King/Queen)
----TXT_KEY_GOVERNMENT_JFD_MONARCHY_TITLE_GOVERNMENT (Kingdom)
----TXT_KEY_GOVERNMENT_JFD_EMPIRE_TITLE_LEADER (Emperor/Empress)
----TXT_KEY_GOVERNMENT_JFD_EMPIRE_TITLE_GOVERNMENT (Empire)
----TXT_KEY_GOVERNMENT_JFD_COMMONWEALTH_TITLE_GOVERNMENT (Commonwealth)
----TXT_KEY_GOVERNMENT_JFD_REPUBLIC_TITLE_LEADER (Consul)
----TXT_KEY_GOVERNMENT_JFD_REPUBLIC_TITLE_LEADER_LATE (President)
----TXT_KEY_GOVERNMENT_JFD_REPUBLIC_TITLE_GOVERNMENT (Republic)
----TXT_KEY_GOVERNMENT_JFD_DICTATORSHIP_TITLE_LEADER (Dictator)
----TXT_KEY_GOVERNMENT_JFD_FEDERATION_TITLE_GOVERNMENT (Federation)

--For 'LEADER' titles, just include the title in the text, e.g. "Pharoah."  You MUST affix _FEMININE to the end of all text strings. e.g. in the example below, you must have TXT_KEY_GOVERNMENT_JFD_TRIBE_TITLE_LEADER_EGYPT but also TXT_KEY_GOVERNMENT_JFD_TRIBE_TITLE_LEADER_EGYPT_FEMININE in your text file.
--For 'GOVERNMENT' titles, include a placeholder for your civ's short description, e.g. "Kingdom of {1_CivName}"
--Use 'UseAdjective' when you want the 'GOVERNMENT' title to read (e.g.): "{1_CivAdj} Kingdom" instead of "Kingdom of {1_CivName}"
INSERT INTO Civilization_JFD_Titles
		(CivilizationType,					DefaultTitle,											UniqueTitle,																UseAdjective)
VALUES	('CIVILIZATION_PG_GRANCOLOMBIA',	'TXT_KEY_GOVERNMENT_JFD_TRIBE_TITLE_GOVERNMENT',		'TXT_KEY_GOVERNMENT_JFD_TRIBE_TITLE_GOVERNMENT_PG_GRANCOLOMBIA',			1),
		('CIVILIZATION_PG_GRANCOLOMBIA',	'TXT_KEY_GOVERNMENT_JFD_TRIBE_TITLE_LEADER',			'TXT_KEY_GOVERNMENT_JFD_TRIBE_TITLE_LEADER_PG_GRANCOLOMBIA',				0),
		('CIVILIZATION_PG_GRANCOLOMBIA',	'TXT_KEY_GOVERNMENT_JFD_PRINCIPALITY_TITLE_GOVERNMENT',	'TXT_KEY_GOVERNMENT_JFD_PRINCIPALITY_TITLE_GOVERNMENT_PG_GRANCOLOMBIA',		1),
		('CIVILIZATION_PG_GRANCOLOMBIA',	'TXT_KEY_GOVERNMENT_JFD_PRINCIPALITY_TITLE_LEADER',		'TXT_KEY_GOVERNMENT_JFD_PRINCIPALITY_TITLE_LEADER_PG_GRANCOLOMBIA',			0),
		('CIVILIZATION_PG_GRANCOLOMBIA',	'TXT_KEY_GOVERNMENT_JFD_MONARCHY_TITLE_GOVERNMENT',		'TXT_KEY_GOVERNMENT_JFD_MONARCHY_TITLE_GOVERNMENT_PG_GRANCOLOMBIA',			0),
		('CIVILIZATION_PG_GRANCOLOMBIA',	'TXT_KEY_GOVERNMENT_JFD_MONARCHY_TITLE_LEADER',			'TXT_KEY_GOVERNMENT_JFD_MONARCHY_TITLE_LEADER_PG_GRANCOLOMBIA',				0),
		('CIVILIZATION_PG_GRANCOLOMBIA',	'TXT_KEY_GOVERNMENT_JFD_EMPIRE_TITLE_GOVERNMENT',		'TXT_KEY_GOVERNMENT_JFD_EMPIRE_TITLE_GOVERNMENT_PG_GRANCOLOMBIA',			0),
		('CIVILIZATION_PG_GRANCOLOMBIA',	'TXT_KEY_GOVERNMENT_JFD_EMPIRE_TITLE_LEADER',			'TXT_KEY_GOVERNMENT_JFD_EMPIRE_TITLE_LEADER_PG_GRANCOLOMBIA',				0),
		('CIVILIZATION_PG_GRANCOLOMBIA',	'TXT_KEY_GOVERNMENT_JFD_COMMONWEALTH_TITLE_GOVERNMENT',	'TXT_KEY_GOVERNMENT_JFD_COMMONWEALTH_TITLE_GOVERNMENT_PG_GRANCOLOMBIA',		0),
		('CIVILIZATION_PG_GRANCOLOMBIA',	'TXT_KEY_GOVERNMENT_JFD_REPUBLIC_TITLE_GOVERNMENT',		'TXT_KEY_GOVERNMENT_JFD_REPUBLIC_TITLE_GOVERNMENT_PG_GRANCOLOMBIA',			0),
		('CIVILIZATION_PG_GRANCOLOMBIA',	'TXT_KEY_GOVERNMENT_JFD_REPUBLIC_TITLE_LEADER',			'TXT_KEY_GOVERNMENT_JFD_REPUBLIC_TITLE_LEADER_PG_GRANCOLOMBIA',				0),
		('CIVILIZATION_PG_GRANCOLOMBIA',	'TXT_KEY_GOVERNMENT_JFD_REPUBLIC_TITLE_LEADER_LATE',	'TXT_KEY_GOVERNMENT_JFD_REPUBLIC_TITLE_LEADER_LATE_PG_GRANCOLOMBIA',		0),
		('CIVILIZATION_PG_GRANCOLOMBIA',	'TXT_KEY_GOVERNMENT_JFD_DICTATORSHIP_TITLE_LEADER',		'TXT_KEY_GOVERNMENT_JFD_DICTATORSHIP_TITLE_LEADER_PG_GRANCOLOMBIA',			0),
		('CIVILIZATION_PG_GRANCOLOMBIA',	'TXT_KEY_GOVERNMENT_JFD_FEDERATION_TITLE_GOVERNMENT',	'TXT_KEY_GOVERNMENT_JFD_FEDERATION_TITLE_GOVERNMENT_PG_GRANCOLOMBIA',		0);	
		
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
--A value of 1-4 will favour Left Reforms. A value of 5-6 will value Centre Reforms. A value of 7-10 will value Right Reforms. The strength of the value will determine how soon a Leader will implement that Reform.
INSERT INTO Leader_Flavors
		(LeaderType,			FlavorType,							Flavor)
VALUES	('LEADER_PG_BOLIVAR',	'FLAVOR_JFD_REFORM_GOVERNMENT',		8),
		('LEADER_PG_BOLIVAR',	'FLAVOR_JFD_REFORM_LEGAL',			8),
		('LEADER_PG_BOLIVAR',	'FLAVOR_JFD_REFORM_CULTURE',		8),
		('LEADER_PG_BOLIVAR',	'FLAVOR_JFD_REFORM_ECONOMIC',		3),
		('LEADER_PG_BOLIVAR',	'FLAVOR_JFD_REFORM_FOREIGN',		5),
		('LEADER_PG_BOLIVAR',	'FLAVOR_JFD_REFORM_INDUSTRY',		5),
		('LEADER_PG_BOLIVAR',	'FLAVOR_JFD_REFORM_MILITARY',		9),
		('LEADER_PG_BOLIVAR',	'FLAVOR_JFD_REFORM_RELIGION',		1);

--==========================================================================================================================
-- JFD's EXPLORATION CONTINUED EXPANDED (6676902b-b907-45f1-8db5-32dcb2135eee)
--==========================================================================================================================

--==========================================================================================================================
-- LEUGI'S PANEM ET CIRCENSES (27744840-51d5-48b3-89d8-bc595ba27b7e)
--==========================================================================================================================

--==========================================================================================================================		
--==========================================================================================================================		
