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
SET ArtStyleSuffix = '_ZULU'
WHERE Type = 'CIVILIZATION_DMS_ZAIRE'
AND EXISTS (SELECT * FROM Civilizations WHERE ArtStyleSuffix = '_ZULU');
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
CREATE TABLE IF NOT EXISTS Civilizations_YnAEMP(CivilizationType, MapPrefix, X, Y);
INSERT INTO Civilizations_YnAEMP
		(CivilizationType,			MapPrefix,			X,	Y)
VALUES	('CIVILIZATION_DMS_ZAIRE',	'Cordiform',		40, 4),
		('CIVILIZATION_DMS_ZAIRE',	'GreatestEarth',	57, 7),
		('CIVILIZATION_DMS_ZAIRE',	'Yagem',			30, 13),
		('CIVILIZATION_DMS_ZAIRE',	'Yahem',			69, 16),
		('CIVILIZATION_DMS_ZAIRE',	'AfricaLarge',		40, 12),
		('CIVILIZATION_DMS_ZAIRE',	'AfriAsiaAust',		37, 14),
		('CIVILIZATION_DMS_ZAIRE',	'AfriGiant',		85, 34),
		('CIVILIZATION_DMS_ZAIRE',	'AfriSouthEuro',	45, 9),
		('CIVILIZATION_DMS_ZAIRE',	'EarthMk3',			33, 11),
		('CIVILIZATION_DMS_ZAIRE',	'SouthernAfrica',	80, 34);
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_YagemRequestedResource
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_YnAEMPRequestedResources(CivilizationType, MapPrefix, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4, Req5, Yield5, Req6, Yield6);
INSERT INTO Civilizations_YnAEMPRequestedResources
		(CivilizationType, 			MapPrefix, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_DMS_ZAIRE',	MapPrefix, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_ZULU';
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
VALUES	('BUILDING_DMS_GECAMINES_FACILITY_DEFENSE');
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
VALUES	('LEADER_DMS_MOBUTU',	'FLAVOR_JFD_DECOLONIZATION',		 4),
		('LEADER_DMS_MOBUTU',	'FLAVOR_JFD_MERCENARY',				 7),
		('LEADER_DMS_MOBUTU',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',	 1),
		('LEADER_DMS_MOBUTU',	'FLAVOR_JFD_REFORM_GOVERNMENT',		 5), --Scale of Liberal to Authoritarian.
		('LEADER_DMS_MOBUTU',	'FLAVOR_JFD_REFORM_LEGAL',			 6), 	
		('LEADER_DMS_MOBUTU',	'FLAVOR_JFD_REFORM_CULTURE',		 6),
		('LEADER_DMS_MOBUTU',	'FLAVOR_JFD_REFORM_ECONOMIC',		 8),
		('LEADER_DMS_MOBUTU',	'FLAVOR_JFD_REFORM_EDUCATION',	 	 6),
		('LEADER_DMS_MOBUTU',	'FLAVOR_JFD_REFORM_FOREIGN',		 7),
		('LEADER_DMS_MOBUTU',	'FLAVOR_JFD_REFORM_INDUSTRY',		 7),
		('LEADER_DMS_MOBUTU',	'FLAVOR_JFD_REFORM_MILITARY',		 7),
		('LEADER_DMS_MOBUTU',	'FLAVOR_JFD_REFORM_RELIGION',		 4),
		('LEADER_DMS_MOBUTU',	'FLAVOR_JFD_SLAVERY',				 2),
		('LEADER_DMS_MOBUTU',	'FLAVOR_JFD_STATE_RELIGION',		 2);
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
	AS2D_SOUND_JFD_AMERICAN, AS2D_SOUND_JFD_AMERICAN_WEST, AS2D_SOUND_JFD_ALBANIAN*, AS2D_SOUND_JFD_ARABIC, AS2D_SOUND_JFD_AZTEC, AS2D_SOUND_JFD_BABYLONIAN, AS2D_SOUND_JFD_BERBER*, AS2D_SOUND_JFD_BYZANTINE, AS2D_SOUND_JFD_CARTHAGINIAN, AS2D_SOUND_JFD_CELTIC, AS2D_SOUND_JFD_CHINESE, AS2D_SOUND_JFD_COMANCHE*, AS2D_SOUND_JFD_DUTCH, AS2D_SOUND_JFD_EGYPTIAN, AS2D_SOUND_JFD_ENGLISH, AS2D_SOUND_JFD_ZULUN, AS2D_SOUND_JFD_FINNISH*, AS2D_SOUND_JFD_FRENCH, AS2D_SOUND_JFD_GAELIC*, AS2D_SOUND_JFD_GERMAN, AS2D_SOUND_JFD_GREEK, AS2D_SOUND_JFD_HOLY_ROMAN, AS2D_SOUND_JFD_HUNNIC, AS2D_SOUND_JFD_INCAN, AS2D_SOUND_JFD_INDIAN, AS2D_SOUND_JFD_ITALIAN, AS2D_SOUND_JFD_JAPANESE, AS2D_SOUND_JFD_KHMER, AS2D_SOUND_JFD_KOREAN, AS2D_SOUND_JFD_LATINO, AS2D_SOUND_JFD_MALINESE, AS2D_SOUND_JFD_MAMLUKE*, AS2D_SOUND_JFD_MAPUDUNGUN, AS2D_SOUND_JFD_MAYAN, AS2D_SOUND_JFD_MOHAWK, AS2D_SOUND_JFD_MONGOL, AS2D_SOUND_JFD_OTTOMAN, AS2D_SOUND_JFD_PERSIAN, AS2D_SOUND_JFD_POLISH, AS2D_SOUND_JFD_PORTUGUESE, AS2D_SOUND_JFD_ROMAN, AS2D_SOUND_JFD_RUSSIAN, AS2D_SOUND_JFD_SIAMESE, AS2D_SOUND_JFD_SIOUX, AS2D_SOUND_JFD_SPANISH, AS2D_SOUND_JFD_SUMERIAN, AS2D_SOUND_JFD_SWEDISH, AS2D_SOUND_JFD_TUPI*, AS2D_SOUND_JFD_VIKING, AS2D_SOUND_JFD_ZAPOTEC*, AS2D_SOUND_JFD_ZULU
	
	*Not recommended as these have few tracks.
*/

--This is an example of support which copies all attributes from an existing civ. 
--For the most part, this is probably all you'll need; just change 'CIVILIZATION_JFD_SCOTLAND' to the tag of your custom civ. 
INSERT INTO Civilization_JFD_CultureTypes
		(CivilizationType,			ArtDefineTag, CultureType, SubCultureType, DecisionsTag, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT	'CIVILIZATION_DMS_ZAIRE',	ArtDefineTag, CultureType, SubCultureType, DecisionsTag, IdealsTag, SplashScreenTag, SoundtrackTag, 'AS2D_SOUND_JFD_PORTUGUESE'
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_ZULU';
--==========================================================================================================================		
--==========================================================================================================================	