--==========================================================================================================================
-- Civilizations
--==========================================================================================================================			
INSERT INTO Civilizations 	
			(Type, 							Description, 						ShortDescription, 							Adjective, 								Civilopedia, 						CivilopediaTag, 					DefaultPlayerColor, 			ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, 				AlphaIconAtlas, 			PortraitIndex,		SoundtrackTag, 	MapImage, 				DawnOfManQuote, 						DawnOfManAudio,						DawnOfManImage)
SELECT		('CIVILIZATION_MC_CHINOOK'), 	('TXT_KEY_CIV_MC_CHINOOK_DESC'), 	('TXT_KEY_CIV_MC_CHINOOK_SHORT_DESC'), 		('TXT_KEY_CIV_MC_CHINOOK_ADJECTIVE'), 	('TXT_KEY_CIV_MC_CHINOOK_DESC'),	('TXT_KEY_CIV5_MC_CHINOOK'), 		('PLAYERCOLOR_MC_CHINOOK'),		ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('MC_CHINOOK_ATLAS'),  ('MC_CHINOOK_ALPHA_ATLAS'),	0, 					('Iroquois'), 	('ChinookMap512.dds'), 	('TXT_KEY_CIV5_DOM_MC_COMCOMLY_TEXT'), 	('AS2D_DOM_SPEECH_MC_CHINOOK'), 	('Comcomly_DOM.dds')
FROM Civilizations WHERE (Type = 'CIVILIZATION_IROQUOIS');
--------------------------------	
-- Ethnic Units Support
--------------------------------	
UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_IROQUOIS' )
	THEN '_IROQUOIS'
	ELSE '_AMER' END) 
WHERE Type = 'CIVILIZATION_MC_CHINOOK';
--==========================================================================================================================
-- Civilization_JFD_CultureTypes
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	CultureType 								text										default null,
	SplashScreenTag								text										default	null,
	SoundtrackTag								text										default	null);
	
INSERT INTO Civilization_JFD_CultureTypes
			(CivilizationType,					CultureType,			SplashScreenTag,			SoundtrackTag)
VALUES		('CIVILIZATION_MC_CHINOOK',			'JFD_TribalAmerican',	'JFD_TribalAmerican',		'JFD_TribalAmerican');

UPDATE Civilizations 
SET SoundtrackTag = (CASE WHEN EXISTS(SELECT SoundtrackTag FROM Civilizations WHERE SoundtrackTag = 'JFD_TribalAmerican' )
	THEN 'JFD_TribalAmerican'
	ELSE 'Iroquois' END) 
WHERE Type = 'CIVILIZATION_MC_CHINOOK';
--==========================================================================================================================
-- Civilization_CityNames
--==========================================================================================================================		
INSERT INTO Civilization_CityNames
			(CivilizationType, 				CityName)
VALUES		('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_CHINOOK_1'),
			('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_CHINOOK_2'),
			('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_CHINOOK_3'),
			('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_CHINOOK_4'),
			('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_CHINOOK_5'),
			('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_CHINOOK_6'),
			('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_CHINOOK_7'),
			('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_CHINOOK_8'),
			('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_CHINOOK_9'),
			('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_CHINOOK_10'),
			('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_CHINOOK_11'),
			('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_CHINOOK_12'),
			('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_CHINOOK_13'),
			('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_CHINOOK_14'),
			('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_CHINOOK_15'),
			('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_CHINOOK_16'),
			('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_CHINOOK_17'),
			('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_CHINOOK_18'),
			('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_CHINOOK_19'),
			('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_CHINOOK_20'),
			('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_CHINOOK_21'),
			('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_CHINOOK_22'),
			('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_CHINOOK_23'),
			('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_CHINOOK_24'),
			('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_CHINOOK_25'),
			('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_CHINOOK_26'),
			('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_CHINOOK_27'),
			('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_CHINOOK_28'),
			('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_CHINOOK_29'),
			('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_CHINOOK_30'),
			('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_CHINOOK_31'),
			('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_CHINOOK_32');
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
			(CivilizationType, 						ColonyName,								LinguisticType)
VALUES		('CIVILIZATION_MC_CHINOOK', 			null,									'JFD_NorthAmerican');
--==========================================================================================================================
-- Civilization_FreeBuildingClasses
--==========================================================================================================================		
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 				BuildingClassType)
SELECT		('CIVILIZATION_MC_CHINOOK'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_IROQUOIS');
--==========================================================================================================================
-- Civilization_FreeTechs
--==========================================================================================================================	
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 				TechType)
SELECT		('CIVILIZATION_MC_CHINOOK'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_IROQUOIS');
--==========================================================================================================================
-- Civilization_FreeUnits
--==========================================================================================================================	
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 				UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_MC_CHINOOK'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_IROQUOIS');
--==========================================================================================================================
-- Civilization_Leaders
--==========================================================================================================================		
INSERT INTO Civilization_Leaders 
			(CivilizationType, 				LeaderheadType)
VALUES		('CIVILIZATION_MC_CHINOOK', 	'LEADER_MC_COMCOMLY');
--==========================================================================================================================
-- Civilization_UnitClassOverrides 
--==========================================================================================================================	
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 				UnitClassType, 				UnitType)
VALUES		('CIVILIZATION_MC_CHINOOK', 	'UNITCLASS_WORKBOAT', 		'UNIT_MC_CHINOOK_WHALER');
--==========================================================================================================================
-- Civilization_BuildingClassOverrides 
--==========================================================================================================================	
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 				BuildingClassType, 				BuildingType)
VALUES		('CIVILIZATION_MC_CHINOOK', 	'BUILDINGCLASS_LIGHTHOUSE', 	'BUILDING_MC_PLANKHOUSE');
--==========================================================================================================================
--==========================================================================================================================
-- Civilization_SpyNames
--==========================================================================================================================	
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 				SpyName)
VALUES		('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_SPY_NAME_MC_CHINOOK_0'),	
			('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_SPY_NAME_MC_CHINOOK_1'),
			('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_SPY_NAME_MC_CHINOOK_2'),
			('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_SPY_NAME_MC_CHINOOK_3'),
			('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_SPY_NAME_MC_CHINOOK_4'),
			('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_SPY_NAME_MC_CHINOOK_5'),
			('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_SPY_NAME_MC_CHINOOK_6'),
			('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_SPY_NAME_MC_CHINOOK_7'),
			('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_SPY_NAME_MC_CHINOOK_8'),
			('CIVILIZATION_MC_CHINOOK', 	'TXT_KEY_SPY_NAME_MC_CHINOOK_9');
--==========================================================================================================================
-- Civilization_Start_Along_Ocean
--==========================================================================================================================	
INSERT INTO Civilization_Start_Along_Ocean 
			(CivilizationType, 				StartAlongOcean)
VALUES		('CIVILIZATION_MC_CHINOOK', 	1);
--==========================================================================================================================
-- Civilization_Start_Region_Priority
--==========================================================================================================================	
INSERT INTO Civilization_Start_Region_Priority 
			(CivilizationType, 				RegionType)
VALUES		('CIVILIZATION_MC_CHINOOK', 	'REGION_TUNDRA');
--==========================================================================================================================	
--==========================================================================================================================					
	
