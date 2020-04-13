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
-- GEDEMON's YNAEMP (+JFD's v23 / 24 / 25)
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
/*
Map Prefixes:
   
v22
	Cordiform 
    GreatestEarth 
    EuroLarge 
    Yagem
    Yahem 
     
v23
    Aegean 
    AfricaLarge 
    Americas
    Apennine 
    Asia 
    Caribbean
    BritishIsles
    EastAsia 
    EuroGiant 
    Mediterranean 
    Mesopotamia
    NileValley 
    NorthAtlantic
    NorthEastAsia 
    NorthWestEurope
    Pacific
    SouthPacific 
v24
    Adriatic 
    AfriAsiaAust
    AfriGiant 
    AfriSouthEuro 
    AmericasGiant 
    AsiaSmall 
    AsiaSteppeGiant 
    AustralasiaGiant 
    Caucasus 
    CentralAsia
    EuroEastern 
    EuroLargeNew
    IndiaGiant 
    MesopotamiaGiant 
    NorthAmericaGiant 
    NorthAmericaHuge 
    NorthSeaEurope 
    ScotlandIrelandHuge 
    SouthAmericaGiant 
    SouthAmericaLarge 
    SouthAmericaCentralHuge 
    SouthAmericaCentralGiant 
    SouthAsiaHuge 
    SouthPacificGiant 
    WestAfrica 
    IndianOcean 
v25
    AtlanticGiant 
    Australia 
    CaribbeanHuge 
    CentralAfricaLarge 
    Denmark
    EarthMk3
    GermanyHuge	
    Iberia 
    India 
    Indonesia 
    JapanHuge 
    MediterraneanHuge 
    Netherlands
    NorthSeaGiant 
    Orient 
    RussiaLarge
    Patagonia 
    SeaOfJapan
    SouthernAfrica
    Texcoco
    Vietnam 
    Wales 
*/

INSERT INTO Civilizations_YnAEMP
		(CivilizationType,				MapPrefix,			X,	Y,		AltX,	AltY,	AltCapitalName)
VALUES	('CIVILIZATION_VANA_VOC',	'AfriAsiaAust',			97,	31,		108, 33, 'TXT_KEY_CITY_NAME_VANA_AMBON');
		('CIVILIZATION_VANA_VOC',	'AustralasiaGiant',		19,	77,		52,	85,	'TXT_KEY_CITY_NAME_VANA_AMBON');
		('CIVILIZATION_VANA_VOC',	'EarthMk3',				84,	25,		97,	30,	'TXT_KEY_CITY_NAME_VANA_AMBON');
		('CIVILIZATION_VANA_VOC',	'EastAsia',				30,	12,		52,	14,	'TXT_KEY_CITY_NAME_VANA_AMBON');
		('CIVILIZATION_VANA_VOC',	'GreatestEarth',		85,	24,		96,	24,	'TXT_KEY_CITY_NAME_VANA_HOLLANDIA');
		('CIVILIZATION_VANA_VOC',	'IndianOcean',			76,	31,		79,	37,	'TXT_KEY_CITY_NAME_VANA_PONTIANAK');
		('CIVILIZATION_VANA_VOC',	'Indonesia',			33,	12,		81,	19,	'TXT_KEY_CITY_NAME_VANA_AMBON');
		('CIVILIZATION_VANA_VOC',	'Yagem',				80,	26,		90,	30,	'TXT_KEY_CITY_NAME_VANA_AMBON');
		('CIVILIZATION_VANA_VOC',	'Yahem',				103, 27,	112, 28, 'TXT_KEY_CITY_NAME_VANA_AMBON');

--CapitalName and AltCapitalName set a custom City Name on settlement at XY/AltXY coordinates, if needed. Should be TXT_KEY that refers to a string defined elsewhere.
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_YagemRequestedResource
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Civilizations_YnAEMPRequestedResources
		(CivilizationType, 			 MapPrefix, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_VANA_VOC', MapPrefix, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_INDONESIA';
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
INSERT INTO JFD_Civilopedia_HideFromPedia
		(Type)
VALUES	

--The Civilopedia can also support Leaders be linked under a shared Civilization (e.g. Napoleon and Louis are linked to the France article).
--To do this, specify the shared Civilization as the 'DerivativeCiv' for your Civilization.
UPDATE Civilizations
SET DerivativeCiv = 'CIVILIZATION_NETHERLANDS'
WHERE Type = 'CIVILIZATION_VANA_VOC';	

--------------------------------------------------------------------------------------------------------------------------	
-- COLONIES
--------------------------------------------------------------------------------------------------------------------------	
--Colony specific city names. Only recommended for Civilizations that historically had colonies (personally, I also only do it for relevant leaders too), as CulDiv will handle the rest.
INSERT INTO Civilization_JFD_ColonialCityNames
		(CivilizationType, 				ColonyName)
VALUES	('CIVILIZATION_VANA_VOC', 	'TXT_KEY_COLONY_NAME_VANA_VOC_01'),
		('CIVILIZATION_VANA_VOC', 	'TXT_KEY_COLONY_NAME_VANA_VOC_02'),
		('CIVILIZATION_VANA_VOC', 	'TXT_KEY_COLONY_NAME_VANA_VOC_03'),
		('CIVILIZATION_VANA_VOC', 	'TXT_KEY_COLONY_NAME_VANA_VOC_04'),
		('CIVILIZATION_VANA_VOC', 	'TXT_KEY_COLONY_NAME_VANA_VOC_05');
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
VALUES	('LEADER_JAN_COEN',	'FLAVOR_JFD_DECOLONIZATION',		 5),
		('LEADER_JAN_COEN',	'FLAVOR_JFD_MERCENARY',				 9),
		('LEADER_JAN_COEN',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',	 6),
		('LEADER_JAN_COEN',	'FLAVOR_JFD_REFORM_GOVERNMENT',		 9), 
		('LEADER_JAN_COEN',	'FLAVOR_JFD_REFORM_LEGAL',			 8), 	
		('LEADER_JAN_COEN',	'FLAVOR_JFD_REFORM_CULTURE',		 10),
		('LEADER_JAN_COEN',	'FLAVOR_JFD_REFORM_ECONOMIC',		 10),
		('LEADER_JAN_COEN',	'FLAVOR_JFD_REFORM_EDUCATION',	 	 6),
		('LEADER_JAN_COEN',	'FLAVOR_JFD_REFORM_FOREIGN',		 6),
		('LEADER_JAN_COEN',	'FLAVOR_JFD_REFORM_INDUSTRY',		 5),
		('LEADER_JAN_COEN',	'FLAVOR_JFD_REFORM_MILITARY',		 4),
		('LEADER_JAN_COEN',	'FLAVOR_JFD_REFORM_RELIGION',		 5),
		('LEADER_JAN_COEN',	'FLAVOR_JFD_SLAVERY',				 9),
		('LEADER_JAN_COEN',	'FLAVOR_JFD_STATE_RELIGION',		 6);
		
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
  CULTURE_JFD_ABORIGINAL, CULTURE_JFD_ANDEAN, CULTURE_JFD_BANTU, CULTURE_JFD_BHARATA, CULTURE_JFD_CENTRAL, CULTURE_JFD_CLASSICAL, CULTURE_JFD_COLONIAL, CULTURE_JFD_EASTERN, CULTURE_JFD_EAST_INDIES, CULTURE_JFD_GREAT_PLAINS, CULTURE_JFD_HIMALAYAN, CULTURE_JFD_IRANIAN, CULTURE_JFD_ISLAMIC, CULTURE_JFD_KATUJE, CULTURE_JFD_MANDALA, CULTURE_JFD_MESOAMERICAN, CULTURE_JFD_MESOPOTAMIC, CULTURE_JFD_NORTHERN, CULTURE_JFD_OCEANIC, CULTURE_JFD_ORIENTAL, CULTURE_JFD_PACIFIC, CULTURE_JFD_POLAR, CULTURE_JFD_SAHARAN, CULTURE_JFD_SEMITIC, CULTURE_JFD_STEPPE, CULTURE_JFD_SOUTHERN, CULTURE_JFD_TOTALITARIAN, CULTURE_JFD_WEST_AFRICAN, CULTURE_JFD_WESTERN, CULTURE_JFD_WOODLANDS

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

--This is an example of support which copies all attributes from an existing civ. 
--For the most part, this is probably all you'll need; just change 'CIVILIZATION_JFD_SCOTLAND' to the tag of your custom civ. 
INSERT INTO Civilization_JFD_CultureTypes
		(CivilizationType,				ArtDefineTag, CultureType, SubCultureType, DecisionsTag, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT	'CIVILIZATION_VANA_VOC',	ArtDefineTag, CultureType, SubCultureType, DecisionsTag, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_NETHERLANDS';


UPDATE Civilizations 
SET SoundtrackTag = 'JFD_NorthernCeltic'
WHERE Type = 'CIVILIZATION_VANA_VOC'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_NorthernCeltic');
--==========================================================================================================================		
--==========================================================================================================================		