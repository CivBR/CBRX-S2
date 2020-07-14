--==========================================================================================================================	
-- Civilizations
--==========================================================================================================================				
INSERT INTO Civilizations 	
			(Type, 									Description, 								ShortDescription, 									Adjective, 											Civilopedia, 									CivilopediaTag, 						DefaultPlayerColor, 					ArtDefineTag, ArtStyleType,		ArtStyleSuffix, ArtStylePrefix, IconAtlas, 					PortraitIndex, 	AlphaIconAtlas, 					SoundtrackTag, 	MapImage, 					DawnOfManQuote, 						DawnOfManImage,		DawnOfManAudio)
SELECT		('CIVILIZATION_SENSHI_PERUBOLIVIA'), 		('TXT_KEY_CIV_SENSHI_PERUBOLIVIA_DESC'), 		('TXT_KEY_CIV_SENSHI_PERUBOLIVIA_SHORT_DESC'),		('TXT_KEY_CIV_SENSHI_PERUBOLIVIA_ADJECTIVE'), 		('TXT_KEY_CIV5_SENSHI_PERUBOLIVIA_TEXT_1'), 		('TXT_KEY_CIV5_SENSHI_PERUBOLIVIA'), 		('PLAYERCOLOR_SENSHI_PERUBOLIVIA'), 		ArtDefineTag, ('ARTSTYLE_GRECO_ROMAN'),		ArtStyleSuffix,	ArtStylePrefix,	('SENSHI_PERUBOLIVIA_ATLAS'), 		0, 				('SENSHI_PERUBOLIVIA_ALPHA_ATLAS'), 	('BRAZIL'), 	('PeruBoliviaMap412.dds'), 	('TXT_KEY_CIV5_DOM_SENSHI_SANTACRUZ_TEXT'), 	('SantaCruzDoM.dds'),	('AS2D_DOM_SPEECH_SENSHI_SANTACRUZ')
FROM Civilizations WHERE (Type = 'CIVILIZATION_BRAZIL');

UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_BRAZIL' )
	THEN '_BRAZIL'
	ELSE '_AMER' END) 
WHERE Type = 'CIVILIZATION_SENSHI_PERUBOLIVIA';
--==========================================================================================================================	
-- Civilization_CityNames
--==========================================================================================================================			
INSERT INTO Civilization_CityNames 
			(CivilizationType, 			 CityName)
VALUES		('CIVILIZATION_SENSHI_PERUBOLIVIA', 	'TXT_KEY_CITY_NAME_SENSHI_PERUBOLIVIA_01'),
			('CIVILIZATION_SENSHI_PERUBOLIVIA', 	'TXT_KEY_CITY_NAME_SENSHI_PERUBOLIVIA_02'),
			('CIVILIZATION_SENSHI_PERUBOLIVIA', 	'TXT_KEY_CITY_NAME_SENSHI_PERUBOLIVIA_03'),
			('CIVILIZATION_SENSHI_PERUBOLIVIA', 	'TXT_KEY_CITY_NAME_SENSHI_PERUBOLIVIA_04'),
			('CIVILIZATION_SENSHI_PERUBOLIVIA', 	'TXT_KEY_CITY_NAME_SENSHI_PERUBOLIVIA_05'),
			('CIVILIZATION_SENSHI_PERUBOLIVIA', 	'TXT_KEY_CITY_NAME_SENSHI_PERUBOLIVIA_06'),
			('CIVILIZATION_SENSHI_PERUBOLIVIA', 	'TXT_KEY_CITY_NAME_SENSHI_PERUBOLIVIA_07'),
			('CIVILIZATION_SENSHI_PERUBOLIVIA', 	'TXT_KEY_CITY_NAME_SENSHI_PERUBOLIVIA_08'),
			('CIVILIZATION_SENSHI_PERUBOLIVIA', 	'TXT_KEY_CITY_NAME_SENSHI_PERUBOLIVIA_09'),
			('CIVILIZATION_SENSHI_PERUBOLIVIA', 	'TXT_KEY_CITY_NAME_SENSHI_PERUBOLIVIA_10'),
			('CIVILIZATION_SENSHI_PERUBOLIVIA', 	'TXT_KEY_CITY_NAME_SENSHI_PERUBOLIVIA_11'),
			('CIVILIZATION_SENSHI_PERUBOLIVIA', 	'TXT_KEY_CITY_NAME_SENSHI_PERUBOLIVIA_12'),
			('CIVILIZATION_SENSHI_PERUBOLIVIA', 	'TXT_KEY_CITY_NAME_SENSHI_PERUBOLIVIA_13'),
			('CIVILIZATION_SENSHI_PERUBOLIVIA', 	'TXT_KEY_CITY_NAME_SENSHI_PERUBOLIVIA_14'),
			('CIVILIZATION_SENSHI_PERUBOLIVIA', 	'TXT_KEY_CITY_NAME_SENSHI_PERUBOLIVIA_15'),
			('CIVILIZATION_SENSHI_PERUBOLIVIA', 	'TXT_KEY_CITY_NAME_SENSHI_PERUBOLIVIA_16'),
			('CIVILIZATION_SENSHI_PERUBOLIVIA', 	'TXT_KEY_CITY_NAME_SENSHI_PERUBOLIVIA_17'),
			('CIVILIZATION_SENSHI_PERUBOLIVIA', 	'TXT_KEY_CITY_NAME_SENSHI_PERUBOLIVIA_18'),
			('CIVILIZATION_SENSHI_PERUBOLIVIA', 	'TXT_KEY_CITY_NAME_SENSHI_PERUBOLIVIA_19'),
			('CIVILIZATION_SENSHI_PERUBOLIVIA', 	'TXT_KEY_CITY_NAME_SENSHI_PERUBOLIVIA_20'),
			('CIVILIZATION_SENSHI_PERUBOLIVIA', 	'TXT_KEY_CITY_NAME_SENSHI_PERUBOLIVIA_21'),
			('CIVILIZATION_SENSHI_PERUBOLIVIA', 	'TXT_KEY_CITY_NAME_SENSHI_PERUBOLIVIA_22'),
			('CIVILIZATION_SENSHI_PERUBOLIVIA', 	'TXT_KEY_CITY_NAME_SENSHI_PERUBOLIVIA_23'),
			('CIVILIZATION_SENSHI_PERUBOLIVIA', 	'TXT_KEY_CITY_NAME_SENSHI_PERUBOLIVIA_24'),
			('CIVILIZATION_SENSHI_PERUBOLIVIA', 	'TXT_KEY_CITY_NAME_SENSHI_PERUBOLIVIA_25'),
			('CIVILIZATION_SENSHI_PERUBOLIVIA', 	'TXT_KEY_CITY_NAME_SENSHI_PERUBOLIVIA_26'),
			('CIVILIZATION_SENSHI_PERUBOLIVIA', 	'TXT_KEY_CITY_NAME_SENSHI_PERUBOLIVIA_27'),
			('CIVILIZATION_SENSHI_PERUBOLIVIA', 	'TXT_KEY_CITY_NAME_SENSHI_PERUBOLIVIA_28');
--==========================================================================================================================	
-- Civilization_FreeBuildingClasses
--==========================================================================================================================			
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_SENSHI_PERUBOLIVIA'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_BRAZIL');
--==========================================================================================================================	
-- Civilization_FreeTechs
--==========================================================================================================================		
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_SENSHI_PERUBOLIVIA'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_BRAZIL');
--==========================================================================================================================	
-- Civilization_FreeUnits
--==========================================================================================================================		
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_SENSHI_PERUBOLIVIA'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_BRAZIL');
--==========================================================================================================================	
-- Civilization_Start_Along_Ocean
--==========================================================================================================================			
INSERT INTO Civilization_Start_Along_Ocean 
			(CivilizationType, 					StartAlongOcean)
VALUES		('CIVILIZATION_SENSHI_PERUBOLIVIA', 	1);	
--==========================================================================================================================	
-- Civilization_Leaders
--==========================================================================================================================			
INSERT INTO Civilization_Leaders 
			(CivilizationType, 					LeaderheadType)
VALUES		('CIVILIZATION_SENSHI_PERUBOLIVIA', 	'LEADER_SENSHI_SANTACRUZ');	
--==========================================================================================================================	
-- Civilization_UnitClassOverrides 
--==========================================================================================================================		
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 					UnitClassType, 		UnitType)
VALUES		('CIVILIZATION_SENSHI_PERUBOLIVIA', 	'UNITCLASS_GATLINGGUN',	'UNIT_SENSHI_RABONA');
--==========================================================================================================================	
-- Civilization_BuildingClassOverrides 
--==========================================================================================================================		
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 					BuildingClassType,			BuildingType)
VALUES		('CIVILIZATION_SENSHI_PERUBOLIVIA', 	'BUILDINGCLASS_HARBOR',	'BUILDING_SENSHI_PUERTOLIBRE');
--==========================================================================================================================	
--==========================================================================================================================	
-- Civilization_SpyNames
--==========================================================================================================================		
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		('CIVILIZATION_SENSHI_PERUBOLIVIA', 	'TXT_KEY_SPY_NAME_SENSHI_PERUBOLIVIA_0'),	
			('CIVILIZATION_SENSHI_PERUBOLIVIA', 	'TXT_KEY_SPY_NAME_SENSHI_PERUBOLIVIA_1'),
			('CIVILIZATION_SENSHI_PERUBOLIVIA', 	'TXT_KEY_SPY_NAME_SENSHI_PERUBOLIVIA_2'),
			('CIVILIZATION_SENSHI_PERUBOLIVIA', 	'TXT_KEY_SPY_NAME_SENSHI_PERUBOLIVIA_3'),
			('CIVILIZATION_SENSHI_PERUBOLIVIA', 	'TXT_KEY_SPY_NAME_SENSHI_PERUBOLIVIA_4'),
			('CIVILIZATION_SENSHI_PERUBOLIVIA', 	'TXT_KEY_SPY_NAME_SENSHI_PERUBOLIVIA_5'),
			('CIVILIZATION_SENSHI_PERUBOLIVIA', 	'TXT_KEY_SPY_NAME_SENSHI_PERUBOLIVIA_6'),
			('CIVILIZATION_SENSHI_PERUBOLIVIA', 	'TXT_KEY_SPY_NAME_SENSHI_PERUBOLIVIA_7'),
			('CIVILIZATION_SENSHI_PERUBOLIVIA', 	'TXT_KEY_SPY_NAME_SENSHI_PERUBOLIVIA_8'),
			('CIVILIZATION_SENSHI_PERUBOLIVIA', 	'TXT_KEY_SPY_NAME_SENSHI_PERUBOLIVIA_9');
--==========================================================================================================================		
--==========================================================================================================================						
			
			

