--==========================================================================================================================	
-- Civilizations
--==========================================================================================================================				
INSERT INTO Civilizations 	
			(Type, 									Description, 								ShortDescription, 									Adjective, 											Civilopedia, 									CivilopediaTag, 						DefaultPlayerColor, 			ArtDefineTag, ArtStyleType,		ArtStyleSuffix, ArtStylePrefix, IconAtlas, 					PortraitIndex, 	AlphaIconAtlas, 					SoundtrackTag, 	MapImage, 					DawnOfManQuote, 						DawnOfManImage,		DawnOfManAudio)
SELECT		('CIVILIZATION_SENSHI_MARAJO'), 		('TXT_KEY_CIV_SENSHI_MARAJO_DESC'), 		('TXT_KEY_CIV_SENSHI_MARAJO_SHORT_DESC'),		('TXT_KEY_CIV_SENSHI_MARAJO_ADJECTIVE'), 		('TXT_KEY_CIV5_SENSHI_MARAJO_TEXT_1'), 		('TXT_KEY_CIV5_SENSHI_MARAJO'), 		('PLAYERCOLOR_SENSHI_MARAJO'), 		ArtDefineTag, ArtStyleType,		ArtStyleSuffix,	ArtStylePrefix,	('SENSHI_MARAJO_ATLAS'), 		0, 				('SENSHI_MARAJO_ALPHA_ATLAS'), 	('INCA'), 	('MarajoMap412.dds'), 	('TXT_KEY_CIV5_DOM_SENSHI_MARAJO_TEXT'), 	('MarajoDoM.dds'),	('AS2D_DOM_SPEECH_SENSHI_MARAJO')
FROM Civilizations WHERE (Type = 'CIVILIZATION_INCA');

UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_INCA' )
	THEN '_INCA'
	ELSE '_AMER' END) 
WHERE Type = 'CIVILIZATION_SENSHI_MARAJO';
--==========================================================================================================================	
-- Civilization_CityNames
--==========================================================================================================================			
INSERT INTO Civilization_CityNames 
			(CivilizationType, 			 CityName)
VALUES		('CIVILIZATION_SENSHI_MARAJO', 	'TXT_KEY_CITY_NAME_SENSHI_MARAJO_01'),
			('CIVILIZATION_SENSHI_MARAJO', 	'TXT_KEY_CITY_NAME_SENSHI_MARAJO_02'),
			('CIVILIZATION_SENSHI_MARAJO', 	'TXT_KEY_CITY_NAME_SENSHI_MARAJO_03'),
			('CIVILIZATION_SENSHI_MARAJO', 	'TXT_KEY_CITY_NAME_SENSHI_MARAJO_04'),
			('CIVILIZATION_SENSHI_MARAJO', 	'TXT_KEY_CITY_NAME_SENSHI_MARAJO_05'),
			('CIVILIZATION_SENSHI_MARAJO', 	'TXT_KEY_CITY_NAME_SENSHI_MARAJO_06'),
			('CIVILIZATION_SENSHI_MARAJO', 	'TXT_KEY_CITY_NAME_SENSHI_MARAJO_07'),
			('CIVILIZATION_SENSHI_MARAJO', 	'TXT_KEY_CITY_NAME_SENSHI_MARAJO_08'),
			('CIVILIZATION_SENSHI_MARAJO', 	'TXT_KEY_CITY_NAME_SENSHI_MARAJO_09'),
			('CIVILIZATION_SENSHI_MARAJO', 	'TXT_KEY_CITY_NAME_SENSHI_MARAJO_10'),
			('CIVILIZATION_SENSHI_MARAJO', 	'TXT_KEY_CITY_NAME_SENSHI_MARAJO_11'),
			('CIVILIZATION_SENSHI_MARAJO', 	'TXT_KEY_CITY_NAME_SENSHI_MARAJO_12'),
			('CIVILIZATION_SENSHI_MARAJO', 	'TXT_KEY_CITY_NAME_SENSHI_MARAJO_13'),
			('CIVILIZATION_SENSHI_MARAJO', 	'TXT_KEY_CITY_NAME_SENSHI_MARAJO_14'),
			('CIVILIZATION_SENSHI_MARAJO', 	'TXT_KEY_CITY_NAME_SENSHI_MARAJO_15'),
			('CIVILIZATION_SENSHI_MARAJO', 	'TXT_KEY_CITY_NAME_SENSHI_MARAJO_16'),
			('CIVILIZATION_SENSHI_MARAJO', 	'TXT_KEY_CITY_NAME_SENSHI_MARAJO_17'),
			('CIVILIZATION_SENSHI_MARAJO', 	'TXT_KEY_CITY_NAME_SENSHI_MARAJO_18'),
			('CIVILIZATION_SENSHI_MARAJO', 	'TXT_KEY_CITY_NAME_SENSHI_MARAJO_19'),
			('CIVILIZATION_SENSHI_MARAJO', 	'TXT_KEY_CITY_NAME_SENSHI_MARAJO_20'),
			('CIVILIZATION_SENSHI_MARAJO', 	'TXT_KEY_CITY_NAME_SENSHI_MARAJO_21'),
			('CIVILIZATION_SENSHI_MARAJO', 	'TXT_KEY_CITY_NAME_SENSHI_MARAJO_22'),
			('CIVILIZATION_SENSHI_MARAJO', 	'TXT_KEY_CITY_NAME_SENSHI_MARAJO_23'),
			('CIVILIZATION_SENSHI_MARAJO', 	'TXT_KEY_CITY_NAME_SENSHI_MARAJO_24'),
			('CIVILIZATION_SENSHI_MARAJO', 	'TXT_KEY_CITY_NAME_SENSHI_MARAJO_25'),
			('CIVILIZATION_SENSHI_MARAJO', 	'TXT_KEY_CITY_NAME_SENSHI_MARAJO_26'),
			('CIVILIZATION_SENSHI_MARAJO', 	'TXT_KEY_CITY_NAME_SENSHI_MARAJO_27');
--==========================================================================================================================	
-- Civilization_FreeBuildingClasses
--==========================================================================================================================			
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_SENSHI_MARAJO'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_INCA');
--==========================================================================================================================	
-- Civilization_FreeTechs
--==========================================================================================================================		
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_SENSHI_MARAJO'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_INCA');
--==========================================================================================================================	
-- Civilization_FreeUnits
--==========================================================================================================================		
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_SENSHI_MARAJO'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_INCA');
--==========================================================================================================================	
-- Civilization_Start_Along_River
--==========================================================================================================================			
INSERT INTO Civilization_Start_Along_River
			(CivilizationType, 					StartAlongRiver)
VALUES		('CIVILIZATION_SENSHI_MARAJO', 	1);	
--==========================================================================================================================	
-- Civilization_Leaders
--==========================================================================================================================			
INSERT INTO Civilization_Leaders 
			(CivilizationType, 					LeaderheadType)
VALUES		('CIVILIZATION_SENSHI_MARAJO', 	'LEADER_SENSHI_MARAJO');	
--==========================================================================================================================	
-- Civilization_UnitClassOverrides 
--==========================================================================================================================		
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 					UnitClassType, 		UnitType)
VALUES		('CIVILIZATION_SENSHI_MARAJO', 	'UNITCLASS_GALLEASS',	'UNIT_SENSHI_SNAKECANOE');
--==========================================================================================================================	
-- Civilization_BuildingClassOverrides 
--==========================================================================================================================		
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 					BuildingClassType,			BuildingType)
VALUES		('CIVILIZATION_SENSHI_MARAJO', 	'BUILDINGCLASS_SHRINE',	'BUILDING_SENSHI_TESO');
--==========================================================================================================================	
-- Civilization_SpyNames
--==========================================================================================================================		
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		('CIVILIZATION_SENSHI_MARAJO', 	'TXT_KEY_SPY_NAME_SENSHI_MARAJO_0'),	
			('CIVILIZATION_SENSHI_MARAJO', 	'TXT_KEY_SPY_NAME_SENSHI_MARAJO_1'),
			('CIVILIZATION_SENSHI_MARAJO', 	'TXT_KEY_SPY_NAME_SENSHI_MARAJO_2'),
			('CIVILIZATION_SENSHI_MARAJO', 	'TXT_KEY_SPY_NAME_SENSHI_MARAJO_3'),
			('CIVILIZATION_SENSHI_MARAJO', 	'TXT_KEY_SPY_NAME_SENSHI_MARAJO_4'),
			('CIVILIZATION_SENSHI_MARAJO', 	'TXT_KEY_SPY_NAME_SENSHI_MARAJO_5'),
			('CIVILIZATION_SENSHI_MARAJO', 	'TXT_KEY_SPY_NAME_SENSHI_MARAJO_6'),
			('CIVILIZATION_SENSHI_MARAJO', 	'TXT_KEY_SPY_NAME_SENSHI_MARAJO_7'),
			('CIVILIZATION_SENSHI_MARAJO', 	'TXT_KEY_SPY_NAME_SENSHI_MARAJO_8'),
			('CIVILIZATION_SENSHI_MARAJO', 	'TXT_KEY_SPY_NAME_SENSHI_MARAJO_9');
--==========================================================================================================================		
--==========================================================================================================================						
			
			

