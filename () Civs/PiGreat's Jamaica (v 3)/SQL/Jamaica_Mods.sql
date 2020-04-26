------------------------------------------------------------
-- JFD_GlobalUserSettings
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
JFD_GlobalUserSettings (
	Type 				text 			default null,
	Value 				integer 		default 1);

--==========================================================================================================================
-- GEDEMON YNAEMP
--==========================================================================================================================
-- Civilizations_YagemStartPosition (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
		(Type,							X,	Y)
VALUES	('CIVILIZATION_PI_JAMAICA',	153,  46);

------------------------------------------------------------	
-- Civilizations_YahemStartPosition (Earth Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
		(Type,							X,	Y)
VALUES	('CIVILIZATION_PI_JAMAICA',	29,	42);

------------------------------------------------------------	
-- Civilizations_CordiformStartPosition (Earth Standard)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
		(Type,							X,	Y)
VALUES	('CIVILIZATION_PI_JAMAICA',	10,	24);

------------------------------------------------------------
-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
		(Type,							X,	Y)
VALUES	('CIVILIZATION_PI_JAMAICA',	24,	32);

------------------------------------------------------------	
-- Civilizations_AmericasStartPosition (Americas)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AmericasStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AmericasStartPosition
		(Type,							X,	Y)
VALUES	('CIVILIZATION_PI_JAMAICA',	45, 42);

------------------------------------------------------------	
-- Civilizations_CaribbeanStartPosition (Caribbean)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CaribbeanStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CaribbeanStartPosition
		(Type,							X,	Y)
VALUES	('CIVILIZATION_PI_JAMAICA',	54, 31);

--==========================================================================================================================
-- JFD's CULTURAL DIVERSITY (31a31d1c-b9d7-45e1-842c-23232d66cd47)
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
        (CivilizationType,            CultureType, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
VALUES ('CIVILIZATION_PI_JAMAICA',    'JFD_Colonial', 'JFD_ColonialLatin', 'JFD_Colonial', 'AS2D_SOUND_JFD_AMERICAN');

--===========================================
--TOMATEKH'S HISTORICAL RELIGIONS COMPLETE
--===========================================

INSERT INTO Civilization_Religions 
		(CivilizationType, 			ReligionType)
VALUES		('CIVILIZATION_PI_JAMAICA', 		'RELIGION_PROTESTANTISM');

UPDATE Civilization_Religions SET ReligionType = 
	( CASE WHEN EXISTS(SELECT Type FROM Religions WHERE Type="RELIGION_PROTESTANT_BAPTIST" )
		THEN "RELIGION_PROTESTANT_BAPTIST"
		ELSE "RELIGION_PROTESTANTISM" END
	) WHERE CivilizationType = "CIVILIZATION_PI_JAMAICA";

--==========================================================	
-- COLONIES 
--==========================================================	
-- Civilization_JFD_ColonialCityNames
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_ColonialCityNames (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	ColonyName 									text										default null,
	LinguisticType								text										default	null,
	CultureType									text										default	null);
	
/*
Linguistic Types:
JFD_Germanic, JFD_Latinate, JFD_Tai_Khmer, JFD_Austronesian, JFD_Arabic, JFD_Slavic, JFD_Mesopotamian, JFD_Mesoamerican, JFD_Oriental,
JFD_Finno_Ugric, JFD_Semitic, JFD_Hellenic, JFD_Bantu, JFD_Songhay, JFD_Indo_Iranian, JFD_Altaic, JFD_Celtic, JFD_NorthAmerican, JFD_Quechumaran
*/
INSERT INTO Civilization_JFD_ColonialCityNames
		(CivilizationType, 						ColonyName,								LinguisticType)
VALUES	('CIVILIZATION_PI_JAMAICA', 			null,									'JFD_NorthAmerican'),
		('CIVILIZATION_PI_JAMAICA', 			'TXT_KEY_COLONY_NAME_PI_JAMAICA_01',	null),
		('CIVILIZATION_PI_JAMAICA', 			'TXT_KEY_COLONY_NAME_PI_JAMAICA_02',	null),
		('CIVILIZATION_PI_JAMAICA', 			'TXT_KEY_COLONY_NAME_PI_JAMAICA_03',	null),
		('CIVILIZATION_PI_JAMAICA', 			'TXT_KEY_COLONY_NAME_PI_JAMAICA_04',	null),
		('CIVILIZATION_PI_JAMAICA', 			'TXT_KEY_COLONY_NAME_PI_JAMAICA_05',	null);

------------------------------------------------------------		
-- Flavors
------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_DECOLONIZATION');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------	
--A value of 0-10 may be set. This value determines the proclivity a civ has toward annexing a colony, where 0 means never, and 10 means as soon as possible.
INSERT INTO Leader_Flavors
		(LeaderType,			FlavorType,						Flavor)
VALUES	('LEADER_PI_MARCUS_GARVEY',	'FLAVOR_JFD_DECOLONIZATION',	7);

--==========================================================	
-- SLAVERY 
--==========================================================	
-- Flavors
------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_SLAVERY');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------	
--A value of 0-10 may be set. This value determines the proclivity a civ has toward enslaving a captured city and toward spending Slavery on Units.
INSERT INTO Leader_Flavors
		(LeaderType,			FlavorType,					Flavor)
VALUES	('LEADER_PI_MARCUS_GARVEY',	'FLAVOR_JFD_SLAVERY',		0);

--==========================================================================================================================
-- JFD's EXPLORATION CONTINUED EXPANDED (6676902b-b907-45f1-8db5-32dcb2135eee)
--==========================================================================================================================
--PROMOTION_JFD_SNOW_IMMUNITY, PROMOTION_JFD_DESERT_IMMUNITY, PROMOTION_JFD_DISEASE_IMMUNITY, PROMOTION_JFD_JUNGLE_IMMUNITY, PROMOTION_JFD_SCUVRY_IMMUNITY
INSERT INTO Unit_FreePromotions
		(UnitType, 					PromotionType)
SELECT	'UNIT_PI_JAMAICA_MAROON_REBEL',		'PROMOTION_JFD_JUNGLE_IMMUNITY'
WHERE EXISTS (SELECT Type FROM UnitPromotions WHERE Type = 'PROMOTION_JFD_JUNGLE_IMMUNITY');

--==========================================================================================================================	
-- JFD's AND POUAKAI's MERCENARIES (a19351c5-c0b3-4b07-8695-4affaa199949)
--==========================================================================================================================
-- Flavors
------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_MERCENARY');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------	
--A value of 0-10 may be set. This value determines the likelihood that a leader will take out Mercenary Contracts (provided they have the funds).
--A value of 10 means this civilization will always take a Contract if available. A value of 0 means this civilization will never take out a contract.
INSERT INTO Leader_Flavors
		(LeaderType,				FlavorType,					Flavor)
VALUES	('LEADER_PI_MARCUS_GARVEY',		'FLAVOR_JFD_MERCENARY',		5);

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
VALUES	('LEADER_PI_MARCUS_GARVEY',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',		0),
		('LEADER_PI_MARCUS_GARVEY',	'FLAVOR_JFD_STATE_RELIGION',			5);

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
		(CivilizationType,				CurrencyType)
SELECT	'CIVILIZATION_PI_JAMAICA',	CurrencyType
FROM Civilization_JFD_Currencies WHERE CivilizationType = 'CIVILIZATION_AMERICA';

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
		(CivilizationType,				LegislatureName, 											OfficeTitle, 														GovernmentType, 			Weight)
VALUES	('CIVILIZATION_PI_JAMAICA',	'TXT_KEY_JFD_LEGISLATURE_NAME_CIVILIZATION_PI_JAMAICA', 	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_PI_JAMAICA', 	'GOVERNMENT_JFD_REPUBLIC', 	70);

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
        (CivilizationType,                    DefaultTitle,                                    UniqueTitle)
SELECT 'CIVILIZATION_PI_JAMAICA', DefaultTitle, UniqueTitle FROM Civilization_JFD_Titles WHERE CivilizationType = 'CIVILIZATION_ENGLAND';

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
		(PrivyCouncillorType,				CivilizationType,							UniqueName)
VALUES	('COUNCILLOR_JFD_CHANCELLOR',		'CIVILIZATION_PI_JAMAICA',				'TXT_KEY_COUNCILLOR_JFD_CHANCELLOR_DESC_PI_JAMAICA'),
		('COUNCILLOR_JFD_CHAPLAIN',			'CIVILIZATION_PI_JAMAICA',				'TXT_KEY_COUNCILLOR_JFD_CHAPLAIN_DESC_PI_JAMAICA'),
		('COUNCILLOR_JFD_MARSHAL',			'CIVILIZATION_PI_JAMAICA',				'TXT_KEY_COUNCILLOR_JFD_MARSHAL_DESC_PI_JAMAICA'),
		('COUNCILLOR_JFD_HERALD',			'CIVILIZATION_PI_JAMAICA',				'TXT_KEY_COUNCILLOR_JFD_HERALD_DESC_PI_JAMAICA'),
		('COUNCILLOR_JFD_STEWARD',			'CIVILIZATION_PI_JAMAICA',				'TXT_KEY_COUNCILLOR_JFD_STEWARD_DESC_PI_JAMAICA');

------------------------------------------------------------
-- Civilization_JFD_Politics
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Politics (
	CivilizationType  					text 		REFERENCES Civilizations(Type) 					default null,
	PoliticsType  						text 														default null,
	UniqueName							text														default	null);

--This lists all the unique names for a civ's political parties.
--Political Parties are as follows:
----FACTION_JFD_NATIONALIST
----FACTION_JFD_POPULARIST
----PARTY_JFD_BURGHERS
----PARTY_JFD_CLERGY
----PARTY_JFD_NOBILITY
----PARTY_JFD_REVOLUTIONARY
----PARTY_JFD_CONSERVATIVE
----PARTY_JFD_LIBERAL
----PARTY_JFD_REACTIONARY
----PARTY_JFD_SOCIALIST
----PARTY_JFD_COMMUNIST
----PARTY_JFD_FASCIST
----PARTY_JFD_LIBERTARIAN
INSERT INTO Civilization_JFD_Politics
		(CivilizationType,					PoliticsType, 				UniqueName)
VALUES	('CIVILIZATION_PI_JAMAICA',		'PARTY_JFD_CONSERVATIVE',	'TXT_KEY_JFD_PARTY_JFD_CONSERVATIVE_PI_JAMAICA'),
        ('CIVILIZATION_PI_JAMAICA',		'PARTY_JFD_LIBERAL',	'TXT_KEY_JFD_PARTY_JFD_LIBERAL_PI_JAMAICA'),
		('CIVILIZATION_PI_JAMAICA',		'PARTY_JFD_NATIONALIST',	'TXT_KEY_JFD_PARTY_JFD_NATIONALIST_PI_JAMAICA');

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
VALUES	('LEADER_PI_MARCUS_GARVEY',	'FLAVOR_JFD_REFORM_GOVERNMENT',		5),
		('LEADER_PI_MARCUS_GARVEY',	'FLAVOR_JFD_REFORM_LEGAL',			4),
		('LEADER_PI_MARCUS_GARVEY',	'FLAVOR_JFD_REFORM_CULTURE',		3),
		('LEADER_PI_MARCUS_GARVEY',	'FLAVOR_JFD_REFORM_ECONOMIC',		5),
		('LEADER_PI_MARCUS_GARVEY',	'FLAVOR_JFD_REFORM_FOREIGN',		5),
		('LEADER_PI_MARCUS_GARVEY',	'FLAVOR_JFD_REFORM_INDUSTRY',		3),
		('LEADER_PI_MARCUS_GARVEY',	'FLAVOR_JFD_REFORM_MILITARY',		2),
		('LEADER_PI_MARCUS_GARVEY',	'FLAVOR_JFD_REFORM_RELIGION',		5);

--------------------------------------------
-- Events and Decisions
--------------------------------------------
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);

INSERT INTO DecisionsAddin_Support
        (FileName)
VALUES    ('Jamaica_Decisions.lua');
