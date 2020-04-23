--==========================================================================================================================	
-- Civilizations
--==========================================================================================================================				
INSERT INTO Civilizations 	
			(Type, 								Description, 							ShortDescription, 							Adjective, 									Civilopedia, 								CivilopediaTag, 					DefaultPlayerColor, 				ArtDefineTag, ArtStyleType,			ArtStyleSuffix, ArtStylePrefix, DerivativeCiv,			IconAtlas, 					PortraitIndex, 	AlphaIconAtlas, 					SoundtrackTag, 	MapImage, 					DawnOfManQuote, 						DawnOfManImage,		DawnOfManAudio)
SELECT		('CIVILIZATION_SENSHI_MANCHU'), 		('TXT_KEY_CIV_SENSHI_MANCHU_DESC'), 		('TXT_KEY_CIV_SENSHI_MANCHU_SHORT_DESC'),		('TXT_KEY_CIV_SENSHI_MANCHU_ADJECTIVE'), 		('TXT_KEY_CIV5_SENSHI_MANCHU_TEXT_1'), 		('TXT_KEY_CIV5_SENSHI_MANCHU'), 		('PLAYERCOLOR_SENSHI_MANCHU'), 		ArtDefineTag, ArtStyleType,			ArtStyleSuffix,	ArtStylePrefix,	('CIVILIZATION_CHINA'),	('SENSHI_MANCHU_ATLAS'), 		0, 				('SENSHI_MANCHU_ALPHA_ATLAS'), 	('MONGOL'), 	('ManchuMap.dds'), 	('TXT_KEY_CIV5_DOM_SENSHI_NURHACI_TEXT'), 	('NurhaciDOM.dds'),	('AS2D_DOM_SPEECH_SENSHI_NURHACI')
FROM Civilizations WHERE (Type = 'CIVILIZATION_MONGOL');

UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_MONGOL' )
	THEN '_MONGOL'
	ELSE '_ASIA' END) 
WHERE Type = 'CIVILIZATION_SENSHI_MANCHU';
--==========================================================================================================================	
-- Civilization_CityNames
--==========================================================================================================================			
INSERT INTO Civilization_CityNames 
			(CivilizationType, 			 CityName)
VALUES		('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_CITY_NAME_SENSHI_MANCHU_01'),
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_CITY_NAME_SENSHI_MANCHU_02'),
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_CITY_NAME_SENSHI_MANCHU_03'),
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_CITY_NAME_SENSHI_MANCHU_04'),
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_CITY_NAME_SENSHI_MANCHU_05'),
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_CITY_NAME_SENSHI_MANCHU_06'),
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_CITY_NAME_SENSHI_MANCHU_07'),
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_CITY_NAME_SENSHI_MANCHU_08'),
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_CITY_NAME_SENSHI_MANCHU_09'),
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_CITY_NAME_SENSHI_MANCHU_10'),
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_CITY_NAME_SENSHI_MANCHU_11'),
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_CITY_NAME_SENSHI_MANCHU_12'),
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_CITY_NAME_SENSHI_MANCHU_13'),
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_CITY_NAME_SENSHI_MANCHU_14'),
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_CITY_NAME_SENSHI_MANCHU_15'),
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_CITY_NAME_SENSHI_MANCHU_16'),
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_CITY_NAME_SENSHI_MANCHU_17'),
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_CITY_NAME_SENSHI_MANCHU_18'),
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_CITY_NAME_SENSHI_MANCHU_19'),
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_CITY_NAME_SENSHI_MANCHU_20'),
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_CITY_NAME_SENSHI_MANCHU_21'),
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_CITY_NAME_SENSHI_MANCHU_22'),
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_CITY_NAME_SENSHI_MANCHU_23'),
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_CITY_NAME_SENSHI_MANCHU_24'),
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_CITY_NAME_SENSHI_MANCHU_25'),
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_CITY_NAME_SENSHI_MANCHU_26'),
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_CITY_NAME_SENSHI_MANCHU_27'),
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_CITY_NAME_SENSHI_MANCHU_28'),
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_CITY_NAME_SENSHI_MANCHU_29'),
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_CITY_NAME_SENSHI_MANCHU_30'),
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_CITY_NAME_SENSHI_MANCHU_31'),
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_CITY_NAME_SENSHI_MANCHU_32'),
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_CITY_NAME_SENSHI_MANCHU_33'),
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_CITY_NAME_SENSHI_MANCHU_34');
--==========================================================================================================================	
-- Civilization_FreeBuildingClasses
--==========================================================================================================================			
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_SENSHI_MANCHU'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_MONGOL');
--==========================================================================================================================	
-- Civilization_FreeTechs
--==========================================================================================================================		
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_SENSHI_MANCHU'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_MONGOL');
--==========================================================================================================================	
-- Civilization_FreeUnits
--==========================================================================================================================		
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_SENSHI_MANCHU'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_MONGOL');
--==========================================================================================================================	
-- Civilization_Start_Region_Priority
--==========================================================================================================================			
INSERT INTO Civilization_Start_Region_Priority 
			(CivilizationType, 					RegionType)
VALUES		('CIVILIZATION_SENSHI_MANCHU', 		'REGION_PLAINS');	
--==========================================================================================================================	
-- Civilization_Leaders
--==========================================================================================================================			
INSERT INTO Civilization_Leaders 
			(CivilizationType, 					LeaderheadType)
VALUES		('CIVILIZATION_SENSHI_MANCHU', 	'LEADER_SENSHI_NURHACI');	
--==========================================================================================================================	
-- Civilization_UnitClassOverrides 
--==========================================================================================================================		
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 					UnitClassType, 			 UnitType)
VALUES		('CIVILIZATION_SENSHI_MANCHU', 	'UNITCLASS_LANCER',		'UNIT_SENSHI_BANNERMAN'),
			('CIVILIZATION_SENSHI_MANCHU', 	'UNITCLASS_MUSKETMAN',	'UNIT_SENSHI_GREEN_STANDARD');
--==========================================================================================================================	
-- Civilization_Religions
--==========================================================================================================================		
INSERT INTO Civilization_Religions 
			(CivilizationType, 					ReligionType)
SELECT		'CIVILIZATION_SENSHI_MANCHU', 	ReligionType
FROM Civilization_Religions WHERE (CivilizationType = 'CIVILIZATION_SIAM');
--==========================================================================================================================	
-- Civilization_SpyNames
--==========================================================================================================================		
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_SPY_NAME_SENSHI_MANCHU_0'),	
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_SPY_NAME_SENSHI_MANCHU_1'),
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_SPY_NAME_SENSHI_MANCHU_2'),
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_SPY_NAME_SENSHI_MANCHU_3'),
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_SPY_NAME_SENSHI_MANCHU_4'),
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_SPY_NAME_SENSHI_MANCHU_5'),
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_SPY_NAME_SENSHI_MANCHU_6'),
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_SPY_NAME_SENSHI_MANCHU_7'),
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_SPY_NAME_SENSHI_MANCHU_8'),
			('CIVILIZATION_SENSHI_MANCHU', 	'TXT_KEY_SPY_NAME_SENSHI_MANCHU_9');
--==========================================================================================================================		
--==========================================================================================================================						
			
			

