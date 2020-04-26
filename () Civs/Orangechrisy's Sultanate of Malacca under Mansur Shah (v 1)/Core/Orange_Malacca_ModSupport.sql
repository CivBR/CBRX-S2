--==========================================================================================================================
-- STANDARD MOD SUPPORT
--==========================================================================================================================
--As of June 9 2019, the standard mod support structure has changed. Please see immediately below for the new standard featured 
--in my civ mods and see https://drive.google.com/file/d/1uzqjOHiPOXmQHWMCSsuCKiImA6fQXB_X/view?usp=sharing for the old support structure.

--The following mod supports have been dropped:
---JFDLC Titles; to be replaced with Culture-specific Titles.
---JFDLC Inventions; to be replaced with Culture-wide preferences.
---JFDLC Construction Audios. These will remain defaulted to Building Class.
---Decisions; to be replaced with Culture-specific Decisions.
---Map Labels, Civ IV Traits, R.E.D., and Ethnic Units; to be replaced with Culture-wide supports.

--The following mod supports have been preserved:
---Cultural Diversity. This is the most important one to support (at a minimum, the Culture Type) because other supports will draw from it.
---YnAEMP v25. Recommend only bother with AltXY/AltCapital when your civ's Capital is the exact same as another's (e.g. Byzantium and Constantinople).
---JFDLC Leader Flavours.
---Colony names (where applicable). Linguistic type should be omitted.

--Please note these are the STANDARD mod supports, that is, they are supported by every custom civ.
--This list does not include mod support for mods like Enlightenment Era. The support required for these are case-sensitive.

--Please also note that I maintain NO GUARANTEES that the old support structures for my mods will remain valid. 
--If you choose to support things like JFDLC Titles, they may not function with the latest version of the JFDLC mod that uses them.
--It is HIGHLY RECOMMENDED you leave support to me (that is, to CulDiv) and follow only this template for JFDLC supports.
--Former methods for supporting JFDLC Titles and Inventions are particularly at risk of becoming obsolete. Construction audios less so.
--Supporting anything not JFDLC-related is up to however you see fit.
--==========================================================================================================================
-- REFERENCES
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
--Below is a list of Mod IDs added as standard references to my custom civs.

--IMPORTANT! If you include the Master Support File as a template, DO NOT include this section. 
--These references are to be added as REFERENCES in the Properties > Associations page of your mod.
/*--Always included:
<Mod id="d1b6328c-ff44-4b0d-aad7-c657f83610cd" minversion="0" maxversion="999" title="Community Patch" />
<Mod id="31a31d1c-b9d7-45e1-842c-23232d66cd47" minversion="0" maxversion="999" title="JFD's Cultural Diversity (Core)" />
<Mod id="36e88483-48fe-4545-b85f-bafc50dde315" minversion="0" maxversion="999" title="Yet (not) Another Earth Maps Pack" />

--(Commonly) Included as needed:
<Mod id="8c101299-95c5-4b28-b7ed-4e0f774857ef" minversion="0" maxversion="999" title="Historical Religions" />
<Mod id="6010e6f6-918e-48b8-9332-d60783bd8fb5" minversion="0" maxversion="999" title="Historical Religions Complete" />
<Mod id="ce8aa614-7ef7-4a45-a179-5329869e8d6d" minversion="0" maxversion="999" title="Pouakai's Enlightenment Era" />*/
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
--------------------------------------------------------------------------------------------------------------------------
--==========================================================================================================================
-- GEDEMON YNAEMP
--==========================================================================================================================
-- Civilizations_YnAEMP
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Civilizations_YnAEMP
		(CivilizationType,			MapPrefix,		X,		Y,		AltX,	AltY)
		-- v23/24
VALUES	('CIVILIZATION_ORG_MALACCA',	'Yagem',		77,		32,		null,	null),
		('CIVILIZATION_ORG_MALACCA',	'Yahem',		100,	33,		null,	null),
		('CIVILIZATION_ORG_MALACCA',	'Cordiform',	63,		19,		null,	null),
		('CIVILIZATION_ORG_MALACCA',	'GreatestEarth', 83,	33,		null,	null),
		('CIVILIZATION_ORG_MALACCA',	'Asia',	        57,		1,		null,	null),
		('CIVILIZATION_ORG_MALACCA',	'AustralasiaGiant', 11,	99,		null,	null),
		('CIVILIZATION_ORG_MALACCA',	'EastAsia',     25,		22,		null,	null),
		('CIVILIZATION_ORG_MALACCA',	'IndianOcean',  71,	    41,		null,	null),
		('CIVILIZATION_ORG_MALACCA',	'Indonesia', 	24,  	35,		null,	null),
		('CIVILIZATION_ORG_MALACCA',	'Pacific',      23,	    33,		null,	null),
		('CIVILIZATION_ORG_MALACCA',	'AfriAsiaAust', 94,		37,		null,	null),
		('CIVILIZATION_ORG_MALACCA',	'SouthAsiaHuge', 112,	14,		null,	null),
		-- v25
		('CIVILIZATION_ORG_MALACCA',	'EarthMk3',		82,		33,		null,	null);
------------------------------------------------------------
-- Civilizations_YagemStartPosition (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_ORG_MALACCA',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_ORG_MALACCA' AND MapPrefix = 'Yagem';
------------------------------------------------------------	
-- Civilizations_YahemStartPosition (Earth Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_ORG_MALACCA',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_ORG_MALACCA' AND MapPrefix = 'Yahem';
------------------------------------------------------------	
-- Civilizations_CordiformStartPosition (Earth Standard)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_ORG_MALACCA',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_ORG_MALACCA' AND MapPrefix = 'Cordiform';
------------------------------------------------------------	
-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_ORG_MALACCA',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_ORG_MALACCA' AND MapPrefix = 'GreatestEarth';
------------------------------------------------------------	
-- Civilizations_AsiaStartPosition (Asia)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AsiaStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AsiaStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_ORG_MALACCA',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_ORG_MALACCA' AND MapPrefix = 'Asia';
------------------------------------------------------------	
-- Civilizations_AustralasiaGiantStartPosition (Australasia Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AustralasiaGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AustralasiaGiantStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_ORG_MALACCA',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_ORG_MALACCA' AND MapPrefix = 'AustralasiaGiant';
------------------------------------------------------------	
-- Civilizations_EastAsiaStartPosition (East Asia)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EastAsiaStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EastAsiaStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_ORG_MALACCA',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_ORG_MALACCA' AND MapPrefix = 'EastAsia';
------------------------------------------------------------	
-- Civilizations_IndianOceanStartPosition (Indian Ocean)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_IndianOceanStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_IndianOceanStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_ORG_MALACCA',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_ORG_MALACCA' AND MapPrefix = 'IndianOcean';
------------------------------------------------------------	
-- Civilizations_IndonesiaStartPosition (Apennine)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_IndonesiaStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_IndonesiaStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_ORG_MALACCA',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_ORG_MALACCA' AND MapPrefix = 'Indonesia';
------------------------------------------------------------	
-- Civilizations_PacificStartPosition (Mediterranean)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_PacificStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_PacificStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_ORG_MALACCA',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_ORG_MALACCA' AND MapPrefix = 'Pacific';
------------------------------------------------------------	
-- Civilizations_AfriAsiaAustStartPosition (AfriAsiaAust)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AfriAsiaAustStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AfriAsiaAustStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_ORG_MALACCA',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_ORG_MALACCA' AND MapPrefix = 'AfriAsiaAust';
------------------------------------------------------------	
-- Civilizations_SouthAsiaHugeStartPosition (South Asia Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_SouthAsiaHugeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_SouthAsiaHugeStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_ORG_MALACCA',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_ORG_MALACCA' AND MapPrefix = 'SouthAsiaHuge';
------------------------------------------------------------	
-- Civilizations_EarthMk3StartPosition (Earth Mk3)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EarthMk3StartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EarthMk3StartPosition (Type, X,	Y) SELECT 'CIVILIZATION_ORG_MALACCA',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_ORG_MALACCA' AND MapPrefix = 'EarthMk3';
------------------------------------------------------------	
-- Civilizations_YagemRequestedResource (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource
		(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_ORG_MALACCA',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE Type = 'CIVILIZATION_INDONESIA';
------------------------------------------------------------	
-- Civilizations_YahemRequestedResource (Earth Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YahemRequestedResource
		(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_ORG_MALACCA',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE Type = 'CIVILIZATION_INDONESIA';
------------------------------------------------------------	
-- Civilizations_GreatestEarthRequestedResource (Earth Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_GreatestEarthRequestedResource
		(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_ORG_MALACCA',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_GreatestEarthRequestedResource WHERE Type = 'CIVILIZATION_INDONESIA';
------------------------------------------------------------	
-- Civilizations_AsiaRequestedResource (Europe Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AsiaRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AsiaRequestedResource
		(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_ORG_MALACCA',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AsiaRequestedResource WHERE Type = 'CIVILIZATION_INDONESIA';
------------------------------------------------------------	
-- Civilizations_AustralasiaGiantRequestedResource (Europe Large)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AustralasiaGiantRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AustralasiaGiantRequestedResource
		(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_ORG_MALACCA',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AustralasiaGiantRequestedResource WHERE Type = 'CIVILIZATION_INDONESIA';
------------------------------------------------------------	
-- Civilizations_EastAsiaRequestedResource (Apennine)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EastAsiaRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_EastAsiaRequestedResource
		(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_ORG_MALACCA',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_EastAsiaRequestedResource WHERE Type = 'CIVILIZATION_INDONESIA';
------------------------------------------------------------	
-- Civilizations_IndianOceanRequestedResource (Mediterranean)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_IndianOceanRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_IndianOceanRequestedResource
		(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_ORG_MALACCA',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_IndianOceanRequestedResource WHERE Type = 'CIVILIZATION_INDONESIA';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_IndonesiaRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_IndonesiaRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_IndonesiaRequestedResource 
		(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_ORG_MALACCA',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_IndonesiaRequestedResource WHERE Type = 'CIVILIZATION_INDONESIA';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AfriAsiaAustRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AfriAsiaAustRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AfriAsiaAustRequestedResource 
		(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4) 
SELECT	'CIVILIZATION_ORG_MALACCA',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AfriAsiaAustRequestedResource WHERE Type = 'CIVILIZATION_INDONESIA';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_PacificRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_PacificRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_PacificRequestedResource 
		(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4) 
SELECT	'CIVILIZATION_ORG_MALACCA',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_PacificRequestedResource WHERE Type = 'CIVILIZATION_INDONESIA';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_SouthAsiaHugeRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_SouthAsiaHugeRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_SouthAsiaHugeRequestedResource 
		(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4) 
SELECT	'CIVILIZATION_ORG_MALACCA',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_SouthAsiaHugeRequestedResource WHERE Type = 'CIVILIZATION_INDONESIA';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_EarthMk3RequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EarthMk3RequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_EarthMk3RequestedResource 
		(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4) 
SELECT	'CIVILIZATION_ORG_MALACCA',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_EarthMk3RequestedResource WHERE Type = 'CIVILIZATION_INDONESIA';
--------------------------------------------------------------------------------------------------------------------------
-- MinorCivilizations_YnAEMP
--------------------------------------------------------------------------------------------------------------------------
--This table operates the same as Civilizations_YnAEMP, merely substitute CivilizationType for MinorCivType.
--==========================================================================================================================
-- JFDLC
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- CIVILOPEDIA
--------------------------------------------------------------------------------------------------------------------------
--Any items entered into this table will not show in the Civilopedia. There is no technical limitation as to what can be hidden (I think).
--Note that this mod's functonality requires either JFD's Rise to Power or JFD's Conflict Resolution Patch (no references necessary).
/*INSERT INTO JFD_Civilopedia_HideFromPedia
		(Type)
VALUES	('IMPROVEMENT_JFD_HATSHEPSUT_FRANKINCENSE'),
		('IMPROVEMENT_JFD_HATSHEPSUT_MYRRH');

--The Civilopedia can also support Leaders be linked under a shared Civilization (e.g. Napoleon and Louis are linked to the France article).
--To do this, specify the shared Civilization as the 'DerivativeCiv' for your Civilization.
UPDATE Civilizations
SET DerivativeCiv = 'CIVILIZATION_RUSSIA'
WHERE Type = 'CIVILIZATION_JFD_RUSSIA_PUTIN';	

--Thanks to Sukritact, you can also fill 'DerivativeCiv' with a text string, which will group this civ with others that also have this text string.
UPDATE Civilizations
SET DerivativeCiv = 'TXT_KEY_JFD_RUSSIA_MASTER_RACE'
WHERE Type = 'CIVILIZATION_JFD_RUSSIA_PUTIN';
*/
--------------------------------------------------------------------------------------------------------------------------	
-- COLONIES
--------------------------------------------------------------------------------------------------------------------------	
--Colony specific city names. Only recommended for Civilizations that historically had colonies, as CulDiv will handle the rest.
INSERT INTO Civilization_JFD_ColonialCityNames
		(CivilizationType, 				ColonyName)
VALUES	('CIVILIZATION_ORG_MALACCA', 	'TXT_KEY_COLONY_NAME_ORG_MALACCA_01'),
		('CIVILIZATION_ORG_MALACCA', 	'TXT_KEY_COLONY_NAME_ORG_MALACCA_02'),
		('CIVILIZATION_ORG_MALACCA', 	'TXT_KEY_COLONY_NAME_ORG_MALACCA_03'),
		('CIVILIZATION_ORG_MALACCA', 	'TXT_KEY_COLONY_NAME_ORG_MALACCA_04'),
		('CIVILIZATION_ORG_MALACCA', 	'TXT_KEY_COLONY_NAME_ORG_MALACCA_05');
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
		(LeaderType,			FlavorType,							 Flavor)
VALUES	('LEADER_ORG_MANSUR',	'FLAVOR_JFD_DECOLONIZATION',		 5),
		('LEADER_ORG_MANSUR',	'FLAVOR_JFD_MERCENARY',				 5),
		('LEADER_ORG_MANSUR',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',	 5),
		('LEADER_ORG_MANSUR',	'FLAVOR_JFD_REFORM_GOVERNMENT',		 6), 
		('LEADER_ORG_MANSUR',	'FLAVOR_JFD_REFORM_LEGAL',			 7), 	
		('LEADER_ORG_MANSUR',	'FLAVOR_JFD_REFORM_CULTURE',		 5),
		('LEADER_ORG_MANSUR',	'FLAVOR_JFD_REFORM_ECONOMIC',		 7),
		('LEADER_ORG_MANSUR',	'FLAVOR_JFD_REFORM_EDUCATION',	 	 4),
		('LEADER_ORG_MANSUR',	'FLAVOR_JFD_REFORM_FOREIGN',		 6),
		('LEADER_ORG_MANSUR',	'FLAVOR_JFD_REFORM_INDUSTRY',		 5),
		('LEADER_ORG_MANSUR',	'FLAVOR_JFD_REFORM_MILITARY',		 7),
		('LEADER_ORG_MANSUR',	'FLAVOR_JFD_REFORM_RELIGION',		 8),
		('LEADER_ORG_MANSUR',	'FLAVOR_JFD_SLAVERY',				 1),
		('LEADER_ORG_MANSUR',	'FLAVOR_JFD_STATE_RELIGION',		 7);
		
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
/*
CultureTypes:
  CULTURE_JFD_ABORIGINAL, CULTURE_JFD_ANDEAN, CULTURE_JFD_BANTU, CULTURE_JFD_BHARATA, CULTURE_JFD_CENTRAL, CULTURE_JFD_CLASSICAL, CULTURE_JFD_COLONIAL, CULTURE_JFD_EASTERN, CULTURE_JFD_EAST_INDIES, CULTURE_JFD_GREAT_PLAINS, CULTURE_JFD_HIMALAYAN, CULTURE_JFD_ISLAMIC, CULTURE_JFD_KATUJE, CULTURE_JFD_MANDALA, CULTURE_JFD_MESOAMERICAN, CULTURE_JFD_MESOPOTAMIC, CULTURE_JFD_NORTHERN, CULTURE_JFD_OCEANIC, CULTURE_JFD_ORIENTAL, CULTURE_JFD_PACIFIC, CULTURE_JFD_POLAR, CULTURE_JFD_SAHARAN, CULTURE_JFD_SEMITIC, CULTURE_JFD_STEPPE, CULTURE_JFD_SOUTHERN, CULTURE_JFD_TOTALITARIAN, CULTURE_JFD_WEST_AFRICAN, CULTURE_JFD_WESTERN, CULTURE_JFD_WOODLANDS

 SubCultureType:
  CULTURE_SUB_JFD_CLASSICAL_ROMAN, CULTURE_SUB_JFD_COLONIAL_LATIN, CULTURE_SUB_JFD_EASTERN_BYZANTINE, CULTURE_SUB_JFD_ISLAMIC_TURKIC, CULTURE_SUB_JFD_MESOPOTAMIC_EGYPTIAN, CULTURE_SUB_JFD_NORTHERN_CELTIC, CULTURE_SUB_JFD_ORIENTAL_JAPANESE, CULTURE_SUB_JFD_SEMITIC_ETHIOPIC, CULTURE_SUB_JFD_SOUTHERN_PAPAL, CULTURE_SUB_JFD_WESTERN_BRITISH
  
SplashScreenTags (As above, unless otherwise specified):
   As above in single word lower-case, e.g. CULTURE_JFD_CENTRAL = JFD_Central, CULTURE_JFD_WEST_AFRICAN = JFD_WestAfrican
   JFD_ClassicalRoman, JFD_ColonialLatin, JFD_NorthernCeltic, JFD_OrientalJapanese, JFD_SemiticEthiopic, JFD_SouthernPapal
  
SoundtrackTag (As above, unless otherwise specified):
  As above in single word lower-case, e.g. CULTURE_JFD_CENTRAL = JFD_Central, CULTURE_JFD_WEST_AFRICAN = JFD_WestAfrican
  JFD_ClassicalRoman, JFD_ColonialLatin, JFD_MesopotamicEgyptian, JFD_NorthernCeltic, JFD_OrientalJapanese, JFD_SemiticEthiopic, JFD_SouthernPapal
  
 UnitDialogueTag:
	AS2D_SOUND_JFD_AMERICAN, AS2D_SOUND_JFD_AMERICAN_WEST, AS2D_SOUND_JFD_ALBANIAN*, AS2D_SOUND_JFD_ARABIC, AS2D_SOUND_JFD_AZTEC, AS2D_SOUND_JFD_BABYLONIAN, AS2D_SOUND_JFD_BERBER*, AS2D_SOUND_JFD_BYZANTINE, AS2D_SOUND_JFD_CARTHAGINIAN, AS2D_SOUND_JFD_CELTIC, AS2D_SOUND_JFD_CHINESE, AS2D_SOUND_JFD_COMANCHE*, AS2D_SOUND_JFD_DUTCH, AS2D_SOUND_JFD_EGYPTIAN, AS2D_SOUND_JFD_ENGLISH, AS2D_SOUND_JFD_ETHIOPIAN, AS2D_SOUND_JFD_FINNISH*, AS2D_SOUND_JFD_FRENCH, AS2D_SOUND_JFD_GAELIC*, AS2D_SOUND_JFD_GERMAN, AS2D_SOUND_JFD_GREEK, AS2D_SOUND_JFD_HOLY_ROMAN, AS2D_SOUND_JFD_HUNNIC, AS2D_SOUND_JFD_INCAN, AS2D_SOUND_JFD_INDIAN, AS2D_SOUND_JFD_ITALIAN, AS2D_SOUND_JFD_JAPANESE, AS2D_SOUND_JFD_KHMER, AS2D_SOUND_JFD_KOREAN, AS2D_SOUND_JFD_LATINO, AS2D_SOUND_JFD_MALINESE, AS2D_SOUND_JFD_MAMLUKE*, AS2D_SOUND_JFD_MAPUDUNGUN, AS2D_SOUND_JFD_MAYAN, AS2D_SOUND_JFD_MOHAWK, AS2D_SOUND_JFD_MONGOL, AS2D_SOUND_JFD_OTTOMAN, AS2D_SOUND_JFD_PERSIAN, AS2D_SOUND_JFD_POLISH, AS2D_SOUND_JFD_PORTUGUESE, AS2D_SOUND_JFD_ROMAN, AS2D_SOUND_JFD_RUSSIAN, AS2D_SOUND_JFD_SIAMESE, AS2D_SOUND_JFD_SIOUX, AS2D_SOUND_JFD_SPANISH, AS2D_SOUND_JFD_SUMERIAN, AS2D_SOUND_JFD_SWEDISH, AS2D_SOUND_JFD_TUPI*, AS2D_SOUND_JFD_VIKING, AS2D_SOUND_JFD_ZAPOTEC*, AS2D_SOUND_JFD_ZULU
	
	*Not recommended as these have few tracks.
*/


INSERT INTO Civilization_JFD_CultureTypes
		(CivilizationType,			ArtDefineTag, CultureType, SubCultureType, 					 DecisionsTag, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT	'CIVILIZATION_ORG_MALACCA',	ArtDefineTag, CultureType, 'CULTURE_SUB_JFD_EAST_INDIES', DecisionsTag, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_INDONESIA';

UPDATE Civilizations 
SET SoundtrackTag = 'JFD_EastIndies'
WHERE Type = 'CIVILIZATION_ORG_MALACCA'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_EastIndies');
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
        (LeaderType,			TraitOne,				TraitTwo)
VALUES  ('LEADER_ORG_MANSUR',	'POLICY_MERCANTILE_X',	'POLICY_SEAFARING_X');
------------------------------	
-- Leaders
------------------------------	
UPDATE Leaders 
SET Description = 'MANSUR I [ICON_CONNECTED][ICON_GREAT_EXPLORER]'
WHERE Type = 'LEADER_ORG_MANSUR'
AND EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');
--==========================================================================================================================
-- BrutalSamurai's Ethnic Units/Gedemon's R.E.D.
--==========================================================================================================================
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET ArtStyleSuffix = '_INDONESIA'
WHERE Type = 'CIVILIZATION_ORG_MALACCA'
AND EXISTS (SELECT * FROM Civilizations WHERE ArtStyleSuffix = '_INDONESIA');
--==========================================================================================================================
-- HAZEL MAP LABELS
--==========================================================================================================================
--==========================================================================================================================
-- ML_CivCultures
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS ML_Cultures(ID INTEGER PRIMARY KEY AUTOINCREMENT, Type TEXT, 'Group' TEXT, Description TEXT, SuggestedCivs TEXT);
INSERT OR REPLACE INTO ML_Cultures
			(Type,				'Group')
VALUES		('MALAY', 	'CULTURE_GROUP_EAST_INDIES');

UPDATE ML_Cultures
SET Description = 'TXT_KEY_ML_CULTURE_' || Type,
	SuggestedCivs = 'TXT_KEY_ML_CULTURE_' || Type || '_SUGGESTEDCIVS'
WHERE Type = 'MALAY';
--------------------------------
-- LAKE
--------------------------------
CREATE TABLE IF NOT EXISTS ML_Labels_Dynamic (ID INTEGER PRIMARY KEY AUTOINCREMENT, Name TEXT, MainType TEXT default "FEATURE", SubType TEXT, CultureType TEXT);
INSERT OR REPLACE INTO ML_Labels_Dynamic
			(CultureType, 		MainType, 		SubType,			Name)
VALUES		('MALAY',		'FEATURE',	 	'LAKE',				'TXT_KEY_NAME_MALAY_LAKE_LINGGIU'),
			('MALAY',		'FEATURE',	 	'LAKE',				'TXT_KEY_NAME_MALAY_LAKE_KENYIR'),
			('MALAY',		'FEATURE',	 	'LAKE',				'TXT_KEY_NAME_MALAY_LAKE_TEMENGGOR'),
			('MALAY',		'FEATURE',	 	'LAKE',				'TXT_KEY_NAME_MALAY_LAKE_BERLIAN'),
			('MALAY',		'FEATURE',	 	'LAKE',				'TXT_KEY_NAME_MALAY_LAKE_SEMBRONG'),
			('MALAY',		'FEATURE',	 	'LAKE',				'TXT_KEY_NAME_MALAY_LAKE_BERA');
--------------------------------
-- OCEAN
--------------------------------
INSERT OR REPLACE INTO ML_Labels_Dynamic
			(CultureType, 		MainType, 		SubType,			Name)
VALUES		('MALAY',		'REGION',	 	'OCEAN',			'TXT_KEY_NAME_MALAY_OCEAN_ANDAMAN'),
			('MALAY',		'REGION',	 	'OCEAN',			'TXT_KEY_NAME_MALAY_OCEAN_MALACCASTRAIT'),
			('MALAY',		'REGION',	 	'OCEAN',			'TXT_KEY_NAME_MALAY_OCEAN_JAVA'),
			('MALAY',		'REGION',	 	'OCEAN',			'TXT_KEY_NAME_MALAY_OCEAN_CHINA'),
			('MALAY',		'REGION',	 	'OCEAN',			'TXT_KEY_NAME_MALAY_OCEAN_INDIA');
--------------------------------
-- REGION
--------------------------------
INSERT OR REPLACE INTO ML_Labels_Dynamic
			(CultureType, 		MainType, 		SubType,			Name)
VALUES		('MALAY',		'REGION',	 	'REGION',			'TXT_KEY_NAME_MALAY_REGION_MALACCA'),
			('MALAY',		'REGION',	 	'REGION',			'TXT_KEY_NAME_MALAY_REGION_PAHANG'),
			('MALAY',		'REGION',	 	'REGION',			'TXT_KEY_NAME_MALAY_REGION_JOHOR'),
			('MALAY',		'REGION',	 	'REGION',			'TXT_KEY_NAME_MALAY_REGION_PERAK'),
			('MALAY',		'REGION',	 	'REGION',			'TXT_KEY_NAME_MALAY_REGION_KELANTAN'),
			('MALAY',		'REGION',	 	'REGION',			'TXT_KEY_NAME_MALAY_REGION_TERENGGANO'),
			('MALAY',		'REGION',	 	'REGION',			'TXT_KEY_NAME_MALAY_REGION_PUTRAJAYA'),
			('MALAY',		'REGION',	 	'REGION',			'TXT_KEY_NAME_MALAY_REGION_NEGERI'),
			('MALAY',		'REGION',	 	'REGION',			'TXT_KEY_NAME_MALAY_REGION_SIBARI'),
			('MALAY',		'REGION',	 	'REGION',			'TXT_KEY_NAME_MALAY_REGION_RIAU'),
			('MALAY',		'REGION',	 	'REGION',			'TXT_KEY_NAME_MALAY_REGION_JAMBI'),
			('MALAY',		'REGION',	 	'REGION',			'TXT_KEY_NAME_MALAY_REGION_KEDAH'),
			('MALAY',		'REGION',	 	'REGION',			'TXT_KEY_NAME_MALAY_REGION_RIAUISLANDS'),
			('MALAY',		'REGION',	 	'REGION',			'TXT_KEY_NAME_MALAY_REGION_ARU');
--------------------------------
-- MOUNTAIN
--------------------------------
INSERT OR REPLACE INTO ML_Labels_Dynamic
			(CultureType, 		MainType, 		SubType,			Name)
VALUES		('MALAY',		'FEATURE',	 	'MOUNTAIN',			'TXT_KEY_NAME_MALAY_MOUNTAIN_TAHAN'),
			('MALAY',		'FEATURE',	 	'MOUNTAIN',			'TXT_KEY_NAME_MALAY_MOUNTAIN_KORBU'),
			('MALAY',		'FEATURE',	 	'MOUNTAIN',			'TXT_KEY_NAME_MALAY_MOUNTAIN_YONGBELAR'),
			('MALAY',		'FEATURE',	 	'MOUNTAIN',			'TXT_KEY_NAME_MALAY_MOUNTAIN_GAYONG'),
			('MALAY',		'FEATURE',	 	'MOUNTAIN',			'TXT_KEY_NAME_MALAY_MOUNTAIN_CHAMAH'),
			('MALAY',		'FEATURE',	 	'MOUNTAIN',			'TXT_KEY_NAME_MALAY_MOUNTAIN_YONGYAP'),
			('MALAY',		'FEATURE',	 	'MOUNTAIN',			'TXT_KEY_NAME_MALAY_MOUNTAIN_ULUSEPAT'),			
			('MALAY',		'FEATURE',	 	'MOUNTAIN',			'TXT_KEY_NAME_MALAY_MOUNTAIN_IRAU');
--------------------------------
-- FOREST
--------------------------------
INSERT OR REPLACE INTO ML_Labels_Dynamic
			(CultureType, 		MainType, 		SubType,			Name)
VALUES		('MALAY',		'FEATURE',	 	'FOREST',			'TXT_KEY_NAME_MALAY_FOREST_BEREMBUN'),
			('MALAY',		'FEATURE',	 	'FOREST',			'TXT_KEY_NAME_MALAY_FOREST_BELUM'),
			('MALAY',		'FEATURE',	 	'FOREST',			'TXT_KEY_NAME_MALAY_FOREST_ENDAUROMPIN'),
			('MALAY',		'FEATURE',	 	'FOREST',			'TXT_KEY_NAME_MALAY_FOREST_TAMANNEGARA');
--------------------------------
-- ISLAND
--------------------------------
INSERT OR REPLACE INTO ML_Labels_Dynamic
			(CultureType, 		MainType, 		SubType,			Name)
VALUES		('MALAY',		'REGION',	 	'ISLAND',			'TXT_KEY_NAME_MALAY_ISLAND_SINGAPURA'),
			('MALAY',		'REGION',	 	'ISLAND',			'TXT_KEY_NAME_MALAY_ISLAND_BINTAN'),
			('MALAY',		'REGION',	 	'ISLAND',			'TXT_KEY_NAME_MALAY_ISLAND_BATAM'),
			('MALAY',		'REGION',	 	'ISLAND',			'TXT_KEY_NAME_MALAY_ISLAND_RIAU'),
			('MALAY',		'REGION',	 	'ISLAND',			'TXT_KEY_NAME_MALAY_ISLAND_KARIMUNBESAR'),
			('MALAY',		'REGION',	 	'ISLAND',			'TXT_KEY_NAME_MALAY_ISLAND_KUNDUR'),
			('MALAY',		'REGION',	 	'ISLAND',			'TXT_KEY_NAME_MALAY_ISLAND_SUGI'),
			('MALAY',		'REGION',	 	'ISLAND',			'TXT_KEY_NAME_MALAY_ISLAND_RUPAT'),
			('MALAY',		'REGION',	 	'ISLAND',			'TXT_KEY_NAME_MALAY_ISLAND_PEDANG'),
			('MALAY',		'REGION',	 	'ISLAND',			'TXT_KEY_NAME_MALAY_ISLAND_LINGGA'),
			('MALAY',		'REGION',	 	'ISLAND',			'TXT_KEY_NAME_MALAY_ISLAND_SINGKEP');
--------------------------------
-- RIVER
--------------------------------
INSERT OR REPLACE INTO ML_Labels_Dynamic
			(CultureType, 		MainType, 		SubType,			Name)
VALUES		('MALAY',		'FEATURE',	 	'RIVER',			'TXT_KEY_NAME_MALAY_RIVER_MALACCA'),
			('MALAY',		'FEATURE',	 	'RIVER',			'TXT_KEY_NAME_MALAY_RIVER_KLANG'),
			('MALAY',		'FEATURE',	 	'RIVER',			'TXT_KEY_NAME_MALAY_RIVER_LANGAT'),
			('MALAY',		'FEATURE',	 	'RIVER',			'TXT_KEY_NAME_MALAY_RIVER_JOHOR'),
			('MALAY',		'FEATURE',	 	'RIVER',			'TXT_KEY_NAME_MALAY_RIVER_PAHANG'),
			('MALAY',		'FEATURE',	 	'RIVER',			'TXT_KEY_NAME_MALAY_RIVER_KELANTAN'),
			('MALAY',		'FEATURE',	 	'RIVER',			'TXT_KEY_NAME_MALAY_RIVER_KAMPAR'),
			('MALAY',		'FEATURE',	 	'RIVER',			'TXT_KEY_NAME_MALAY_RIVER_INDRAGIRI');
--==========================================================================================================================
-- ML_CivCultures
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS ML_CivCultures(CivType, CultureType, CultureEra);
INSERT OR REPLACE INTO ML_CivCultures
			(CivType,					CultureType,	CultureEra)
VALUES		('CIVILIZATION_ORG_MALACCA',	'MALAY',		'ANY');
--==========================================================================================================================		
--==========================================================================================================================		
