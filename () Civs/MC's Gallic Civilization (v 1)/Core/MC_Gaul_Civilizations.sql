--==========================================================================================================================	
-- Civilizations
--==========================================================================================================================				
INSERT INTO Civilizations 	
			(Type, 							Description, 						ShortDescription, 							Adjective, 								Civilopedia, 							CivilopediaTag, 					DefaultPlayerColor, 			ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, 			PortraitIndex, 	AlphaIconAtlas, 			SoundtrackTag, 	MapImage, 				DawnOfManQuote, 								DawnOfManAudio,								DawnOfManImage)
SELECT		('CIVILIZATION_MC_GAUL'), 		('TXT_KEY_CIV_MC_GAUL_DESC'), 		('TXT_KEY_CIV_MC_GAUL_SHORT_DESC'), 		('TXT_KEY_CIV_MC_GAUL_ADJECTIVE'), 		('TXT_KEY_CIV_MC_GAUL_DESC'), 			('TXT_KEY_CIV5PEDIA_MC_GAUL'), 		('PLAYERCOLOR_MC_GAUL'), 		ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('MC_GAUL_ATLAS'), 	0, 				('MC_GAUL_ALPHA_ATLAS'), 	('Germany'), 	('GaulMap512.dds'), 	('TXT_KEY_CIV5_DOM_MC_VERCINGETORIX_TEXT'), 	('AS2D_DOM_SPEECH_MC_VERCINGETORIX_DOM'),	('Vercingetorix_DOM.dds')
FROM Civilizations WHERE (Type = 'CIVILIZATION_GERMANY');
--------------------------------	
-- Ethnic Units Support
--------------------------------	
UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_GERMANY' )
	THEN '_GERMANY'
	ELSE '_EURO' END) 
WHERE Type = 'CIVILIZATION_MC_GAUL';
--------------------------------	
-- ExCE Support
--------------------------------
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_ColonialCityNames (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	ColonyName 									text										default null,
	LinguisticType								text										default	null,
	CultureType									text										default	null);
	
INSERT OR REPLACE INTO Civilization_JFD_ColonialCityNames
			(CivilizationType, 					ColonyName,								LinguisticType)
VALUES		('CIVILIZATION_MC_GAUL', 				null,								'JFD_Celtic');
			
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_RevolutionaryCivilizationsToSpawn (
    CivilizationType                            text    REFERENCES Civilizations(Type)      default null,
    RevolutionaryCivilizationType               text    REFERENCES Civilizations(Type)      default null);
	
INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn   	 
			(CivilizationType,    		RevolutionaryCivilizationType)
SELECT		('CIVILIZATION_ROME'),		('CIVILIZATION_MC_GAUL')
WHERE EXISTS (SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_ROME') AND EXISTS (SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_MC_GAUL');	
--==========================================================================================================================	
-- Civilization_CityNames
--==========================================================================================================================			
INSERT INTO Civilization_CityNames
			(CivilizationType, 			CityName)
VALUES		('CIVILIZATION_MC_GAUL', 	'TXT_KEY_CITY_NAME_MC_GAUL_BIBRACTE'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_CITY_NAME_MC_GAUL_VIENNE'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_CITY_NAME_MC_GAUL_ALESIA'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_CITY_NAME_MC_GAUL_GERGOVIA'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_CITY_NAME_MC_GAUL_NEMOSSOS'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_CITY_NAME_MC_GAUL_LUTETIA'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_CITY_NAME_MC_GAUL_CENABUM'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_CITY_NAME_MC_GAUL_DUROCORTORUM'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_CITY_NAME_MC_GAUL_LEMONUM'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_CITY_NAME_MC_GAUL_NAMNETUM'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_CITY_NAME_MC_GAUL_CONDATE'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_CITY_NAME_MC_GAUL_BURDIGALA'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_CITY_NAME_MC_GAUL_VESONTIO'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_CITY_NAME_MC_GAUL_ROTOMAGUS'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_CITY_NAME_MC_GAUL_SAMAROBRIVA'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_CITY_NAME_MC_GAUL_DIVODURUM'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_CITY_NAME_MC_GAUL_SEGODUNUM'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_CITY_NAME_MC_GAUL_NEMETOCENNA'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_CITY_NAME_MC_GAUL_AUTRICUM'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_CITY_NAME_MC_GAUL_SUINDINUM'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_CITY_NAME_MC_GAUL_AVARICON'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_CITY_NAME_MC_GAUL_DARIORITUM'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_CITY_NAME_MC_GAUL_AGEDINCUM'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_CITY_NAME_MC_GAUL_ARGENTORATE'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_CITY_NAME_MC_GAUL_NOVIOMAGUS'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_CITY_NAME_MC_GAUL_BAGACUM'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_CITY_NAME_MC_GAUL_GESORIACUM'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_CITY_NAME_MC_GAUL_GABILLONUM'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_CITY_NAME_MC_GAUL_TOLOSA'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_CITY_NAME_MC_GAUL_LUGDUNUM'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_CITY_NAME_MC_GAUL_UXELLODUNUM'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_CITY_NAME_MC_GAUL_DUROTINCON'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_CITY_NAME_MC_GAUL_BRATUSPANTION'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_CITY_NAME_MC_GAUL_NOVIODUNUM'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_CITY_NAME_MC_GAUL_DIVONA'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_CITY_NAME_MC_GAUL_KARNAG');
--==========================================================================================================================	
-- Civilization_FreeBuildingClasses
--==========================================================================================================================			
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 				BuildingClassType)
SELECT		('CIVILIZATION_MC_GAUL'), 		BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_GERMANY');
--==========================================================================================================================	
-- Civilization_FreeTechs
--==========================================================================================================================		
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 			TechType)
SELECT		('CIVILIZATION_MC_GAUL'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_GERMANY');
--==========================================================================================================================	
-- Civilization_FreeUnits
--==========================================================================================================================		
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 			UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_MC_GAUL'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_GERMANY');
--==========================================================================================================================	
-- Civilization_Leaders
--==========================================================================================================================			
INSERT INTO Civilization_Leaders 
			(CivilizationType, 				LeaderheadType)
VALUES		('CIVILIZATION_MC_GAUL', 		'LEADER_MC_VERCINGETORIX');	
--==========================================================================================================================	
-- Civilization_UnitClassOverrides 
--==========================================================================================================================		
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 				UnitClassType, 				UnitType)
VALUES		('CIVILIZATION_MC_GAUL', 		'UNITCLASS_SWORDSMAN', 		'UNIT_MC_GAUL_OATHSWORN');
--==========================================================================================================================	
-- Civilization_BuildingClassOverrides
--==========================================================================================================================		
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 			BuildingClassType, 		BuildingType)
VALUES		('CIVILIZATION_MC_GAUL', 	'BUILDINGCLASS_MINT',	'BUILDING_MC_GAUL_METALSMITH');
--==========================================================================================================================	

--------------------------------	
-- Historical Religions Support
--------------------------------	
--==========================================================================================================================	
-- Civilization_Start_Region_Priority
--==========================================================================================================================		
INSERT INTO Civilization_Start_Region_Priority 
			(CivilizationType, 			RegionType)
VALUES		('CIVILIZATION_MC_GAUL', 	'REGION_HILLS');			
--==========================================================================================================================	
-- Civilization_SpyNames
--==========================================================================================================================		
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 			SpyName)
VALUES		('CIVILIZATION_MC_GAUL', 	'TXT_KEY_SPY_NAME_MC_GAUL_0'),	
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_SPY_NAME_MC_GAUL_1'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_SPY_NAME_MC_GAUL_2'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_SPY_NAME_MC_GAUL_3'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_SPY_NAME_MC_GAUL_4'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_SPY_NAME_MC_GAUL_5'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_SPY_NAME_MC_GAUL_6'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_SPY_NAME_MC_GAUL_7'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_SPY_NAME_MC_GAUL_8'),
			('CIVILIZATION_MC_GAUL', 	'TXT_KEY_SPY_NAME_MC_GAUL_9');
--==========================================================================================================================		
--==========================================================================================================================