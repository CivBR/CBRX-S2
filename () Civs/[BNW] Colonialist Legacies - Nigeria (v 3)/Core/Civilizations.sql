--==========================================================================================================================	
-- Civilizations
--==========================================================================================================================				
INSERT INTO Civilizations 	
			(Type, 								Description, 							ShortDescription, 							Adjective, 									Civilopedia, 								CivilopediaTag, 					DefaultPlayerColor, 				ArtDefineTag, ArtStyleType,			ArtStyleSuffix, ArtStylePrefix, IconAtlas, 					PortraitIndex, 	AlphaIconAtlas, 					SoundtrackTag, 	MapImage, 					DawnOfManQuote, 						DawnOfManImage,		DawnOfManAudio)
SELECT		('CIVILIZATION_CL_NIGERIA'), 		('TXT_KEY_CIV_CL_NIGERIA_DESC'), 		('TXT_KEY_CIV_CL_NIGERIA_SHORT_DESC'),		('TXT_KEY_CIV_CL_NIGERIA_ADJECTIVE'), 		('TXT_KEY_CIV5_CL_NIGERIA_TEXT_1'), 		('TXT_KEY_CIV5_CL_NIGERIA'), 		('PLAYERCOLOR_CL_NIGERIA'), 		ArtDefineTag, ArtStyleType,			ArtStyleSuffix,	ArtStylePrefix,	('CL_NIGERIA_ATLAS'), 		0, 				('CL_NIGERIA_ALPHA_ATLAS'), 	('ETHIOPIA'), 	('MapNigeria512.dds'), 	('TXT_KEY_CIV5_DOM_CL_AWOLOWO_TEXT'), 	('DOM_Awolowo.dds'),	('AS2D_DOM_SPEECH_CL_AWOLOWO')
FROM Civilizations WHERE (Type = 'CIVILIZATION_ETHIOPIA');

UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_ETHIOPIA' )
	THEN '_ETHIOPIA'
	ELSE '_AFRI' END) 
WHERE Type = 'CIVILIZATION_CL_NIGERIA';
--==========================================================================================================================	
-- Civilization_CityNames
--==========================================================================================================================			
INSERT INTO Civilization_CityNames 
			(CivilizationType, 			 CityName)
VALUES		('CIVILIZATION_CL_NIGERIA', 	'TXT_KEY_CITY_NAME_CL_NIGERIA_01'),
			('CIVILIZATION_CL_NIGERIA', 	'TXT_KEY_CITY_NAME_CL_NIGERIA_02'),
			('CIVILIZATION_CL_NIGERIA', 	'TXT_KEY_CITY_NAME_CL_NIGERIA_03'),
			('CIVILIZATION_CL_NIGERIA', 	'TXT_KEY_CITY_NAME_CL_NIGERIA_04'),
			('CIVILIZATION_CL_NIGERIA', 	'TXT_KEY_CITY_NAME_CL_NIGERIA_05'),
			('CIVILIZATION_CL_NIGERIA', 	'TXT_KEY_CITY_NAME_CL_NIGERIA_06'),
			('CIVILIZATION_CL_NIGERIA', 	'TXT_KEY_CITY_NAME_CL_NIGERIA_07'),
			('CIVILIZATION_CL_NIGERIA', 	'TXT_KEY_CITY_NAME_CL_NIGERIA_08'),
			('CIVILIZATION_CL_NIGERIA', 	'TXT_KEY_CITY_NAME_CL_NIGERIA_09'),
			('CIVILIZATION_CL_NIGERIA', 	'TXT_KEY_CITY_NAME_CL_NIGERIA_10'),
			('CIVILIZATION_CL_NIGERIA', 	'TXT_KEY_CITY_NAME_CL_NIGERIA_11'),
			('CIVILIZATION_CL_NIGERIA', 	'TXT_KEY_CITY_NAME_CL_NIGERIA_12'),
			('CIVILIZATION_CL_NIGERIA', 	'TXT_KEY_CITY_NAME_CL_NIGERIA_13'),
			('CIVILIZATION_CL_NIGERIA', 	'TXT_KEY_CITY_NAME_CL_NIGERIA_14'),
			('CIVILIZATION_CL_NIGERIA', 	'TXT_KEY_CITY_NAME_CL_NIGERIA_15'),
			('CIVILIZATION_CL_NIGERIA', 	'TXT_KEY_CITY_NAME_CL_NIGERIA_16'),
			('CIVILIZATION_CL_NIGERIA', 	'TXT_KEY_CITY_NAME_CL_NIGERIA_17'),
			('CIVILIZATION_CL_NIGERIA', 	'TXT_KEY_CITY_NAME_CL_NIGERIA_18'),
			('CIVILIZATION_CL_NIGERIA', 	'TXT_KEY_CITY_NAME_CL_NIGERIA_19'),
			('CIVILIZATION_CL_NIGERIA', 	'TXT_KEY_CITY_NAME_CL_NIGERIA_20'),
			('CIVILIZATION_CL_NIGERIA', 	'TXT_KEY_CITY_NAME_CL_NIGERIA_21'),
			('CIVILIZATION_CL_NIGERIA', 	'TXT_KEY_CITY_NAME_CL_NIGERIA_22'),
			('CIVILIZATION_CL_NIGERIA', 	'TXT_KEY_CITY_NAME_CL_NIGERIA_23'),
			('CIVILIZATION_CL_NIGERIA', 	'TXT_KEY_CITY_NAME_CL_NIGERIA_24'),
			('CIVILIZATION_CL_NIGERIA', 	'TXT_KEY_CITY_NAME_CL_NIGERIA_25'),
			('CIVILIZATION_CL_NIGERIA', 	'TXT_KEY_CITY_NAME_CL_NIGERIA_26'),
			('CIVILIZATION_CL_NIGERIA', 	'TXT_KEY_CITY_NAME_CL_NIGERIA_27'),
			('CIVILIZATION_CL_NIGERIA', 	'TXT_KEY_CITY_NAME_CL_NIGERIA_28'),
			('CIVILIZATION_CL_NIGERIA', 	'TXT_KEY_CITY_NAME_CL_NIGERIA_29'),
			('CIVILIZATION_CL_NIGERIA', 	'TXT_KEY_CITY_NAME_CL_NIGERIA_30'),
			('CIVILIZATION_CL_NIGERIA', 	'TXT_KEY_CITY_NAME_CL_NIGERIA_31');
--==========================================================================================================================	
-- Civilization_FreeBuildingClasses
--==========================================================================================================================			
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_CL_NIGERIA'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_ETHIOPIA');
--==========================================================================================================================	
-- Civilization_FreeTechs
--==========================================================================================================================		
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_CL_NIGERIA'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_ETHIOPIA');
--==========================================================================================================================	
-- Civilization_FreeUnits
--==========================================================================================================================		
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_CL_NIGERIA'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_ETHIOPIA');
--==========================================================================================================================	
-- Civilization_Start_Region_Priority
--==========================================================================================================================			
INSERT INTO Civilization_Start_Region_Priority
			(CivilizationType, 					RegionType)
VALUES		('CIVILIZATION_CL_NIGERIA', 		'REGION_GRASS');	
--==========================================================================================================================	
-- Civilization_Leaders
--==========================================================================================================================			
INSERT INTO Civilization_Leaders 
			(CivilizationType, 					LeaderheadType)
VALUES		('CIVILIZATION_CL_NIGERIA', 	'LEADER_CL_AWOLOWO');	
--==========================================================================================================================	
-- Civilization_UnitClassOverrides 
--==========================================================================================================================		
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 					UnitClassType, 			 UnitType)
VALUES		('CIVILIZATION_CL_NIGERIA', 	'UNITCLASS_KNIGHT',			'UNIT_CL_YAN_LIFIDA'),
			('CIVILIZATION_CL_NIGERIA', 	'UNITCLASS_FIGHTER',		'UNIT_CL_UGBOELU');
--==========================================================================================================================	
-- Civilization_SpyNames
--==========================================================================================================================		
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		('CIVILIZATION_CL_NIGERIA', 	'TXT_KEY_SPY_NAME_CL_NIGERIA_0'),	
			('CIVILIZATION_CL_NIGERIA', 	'TXT_KEY_SPY_NAME_CL_NIGERIA_1'),
			('CIVILIZATION_CL_NIGERIA', 	'TXT_KEY_SPY_NAME_CL_NIGERIA_2'),
			('CIVILIZATION_CL_NIGERIA', 	'TXT_KEY_SPY_NAME_CL_NIGERIA_3'),
			('CIVILIZATION_CL_NIGERIA', 	'TXT_KEY_SPY_NAME_CL_NIGERIA_4'),
			('CIVILIZATION_CL_NIGERIA', 	'TXT_KEY_SPY_NAME_CL_NIGERIA_5'),
			('CIVILIZATION_CL_NIGERIA', 	'TXT_KEY_SPY_NAME_CL_NIGERIA_6'),
			('CIVILIZATION_CL_NIGERIA', 	'TXT_KEY_SPY_NAME_CL_NIGERIA_7'),
			('CIVILIZATION_CL_NIGERIA', 	'TXT_KEY_SPY_NAME_CL_NIGERIA_8'),
			('CIVILIZATION_CL_NIGERIA', 	'TXT_KEY_SPY_NAME_CL_NIGERIA_9');
--==========================================================================================================================		
--==========================================================================================================================						
			
			

