--==========================================================================================================================	
-- Civilizations
--==========================================================================================================================				
INSERT INTO Civilizations 	
			(Type, 									Description, 								ShortDescription, 									Adjective, 											Civilopedia, 									CivilopediaTag, 						DefaultPlayerColor, 					ArtDefineTag, ArtStyleType,		ArtStyleSuffix, ArtStylePrefix, IconAtlas, 					PortraitIndex, 	AlphaIconAtlas, 					SoundtrackTag, 	MapImage, 					DawnOfManQuote, 						DawnOfManImage,		DawnOfManAudio)
SELECT		('CIVILIZATION_SENSHI_CHUKCHI'), 		('TXT_KEY_CIV_SENSHI_CHUKCHI_DESC'), 		('TXT_KEY_CIV_SENSHI_CHUKCHI_SHORT_DESC'),		('TXT_KEY_CIV_SENSHI_CHUKCHI_ADJECTIVE'), 		('TXT_KEY_CIV5_SENSHI_CHUKCHI_TEXT_1'), 		('TXT_KEY_CIV5_SENSHI_CHUKCHI'), 		('PLAYERCOLOR_SENSHI_CHUKCHI'), 		ArtDefineTag, ('ARTSTYLE_EUROPEAN'),		ArtStyleSuffix,	ArtStylePrefix,	('SENSHI_CHUKCHI_ATLAS'), 		0, 				('SENSHI_CHUKCHI_ALPHA_ATLAS'), 	('MONGOL'), 	('ChukchiMap412.dds'), 	('TXT_KEY_CIV5_DOM_SENSHI_LAWTILIWADLIN_TEXT'), 	('LawtiliwadlinDOM.dds'),	('AS2D_DOM_SPEECH_SENSHI_LAWTILIWADLIN')
FROM Civilizations WHERE (Type = 'CIVILIZATION_MONGOL');

UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_MONGOL' )
	THEN '_MONGOL'
	ELSE '_MED' END) 
WHERE Type = 'CIVILIZATION_SENSHI_CHUKCHI';
--==========================================================================================================================	
-- Civilization_CityNames
--==========================================================================================================================			
INSERT INTO Civilization_CityNames 
			(CivilizationType, 			 CityName)
VALUES		('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_CITY_NAME_SENSHI_CHUKCHI_01'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_CITY_NAME_SENSHI_CHUKCHI_02'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_CITY_NAME_SENSHI_CHUKCHI_03'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_CITY_NAME_SENSHI_CHUKCHI_04'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_CITY_NAME_SENSHI_CHUKCHI_05'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_CITY_NAME_SENSHI_CHUKCHI_06'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_CITY_NAME_SENSHI_CHUKCHI_07'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_CITY_NAME_SENSHI_CHUKCHI_08'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_CITY_NAME_SENSHI_CHUKCHI_09'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_CITY_NAME_SENSHI_CHUKCHI_10'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_CITY_NAME_SENSHI_CHUKCHI_11'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_CITY_NAME_SENSHI_CHUKCHI_12'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_CITY_NAME_SENSHI_CHUKCHI_13'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_CITY_NAME_SENSHI_CHUKCHI_14'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_CITY_NAME_SENSHI_CHUKCHI_15'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_CITY_NAME_SENSHI_CHUKCHI_16'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_CITY_NAME_SENSHI_CHUKCHI_17'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_CITY_NAME_SENSHI_CHUKCHI_18'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_CITY_NAME_SENSHI_CHUKCHI_19'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_CITY_NAME_SENSHI_CHUKCHI_20'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_CITY_NAME_SENSHI_CHUKCHI_21'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_CITY_NAME_SENSHI_CHUKCHI_22'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_CITY_NAME_SENSHI_CHUKCHI_23'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_CITY_NAME_SENSHI_CHUKCHI_24'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_CITY_NAME_SENSHI_CHUKCHI_25'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_CITY_NAME_SENSHI_CHUKCHI_26'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_CITY_NAME_SENSHI_CHUKCHI_27'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_CITY_NAME_SENSHI_CHUKCHI_28'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_CITY_NAME_SENSHI_CHUKCHI_29'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_CITY_NAME_SENSHI_CHUKCHI_30'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_CITY_NAME_SENSHI_CHUKCHI_31'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_CITY_NAME_SENSHI_CHUKCHI_32'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_CITY_NAME_SENSHI_CHUKCHI_33'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_CITY_NAME_SENSHI_CHUKCHI_34'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_CITY_NAME_SENSHI_CHUKCHI_35'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_CITY_NAME_SENSHI_CHUKCHI_36'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_CITY_NAME_SENSHI_CHUKCHI_37'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_CITY_NAME_SENSHI_CHUKCHI_38');
--==========================================================================================================================	
-- Civilization_FreeBuildingClasses
--==========================================================================================================================			
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_SENSHI_CHUKCHI'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_MONGOL');
--==========================================================================================================================	
-- Civilization_FreeTechs
--==========================================================================================================================		
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_SENSHI_CHUKCHI'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_MONGOL');
--==========================================================================================================================	
-- Civilization_FreeUnits
--==========================================================================================================================		
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_SENSHI_CHUKCHI'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_MONGOL');
--==========================================================================================================================	
-- Civilization_Start_Region_Priority
--==========================================================================================================================			
INSERT INTO Civilization_Start_Region_Priority 
			(CivilizationType, 					RegionType)
VALUES		('CIVILIZATION_SENSHI_CHUKCHI', 		'REGION_TUNDRA');
--==========================================================================================================================	
-- Civilization_Leaders
--==========================================================================================================================			
INSERT INTO Civilization_Leaders 
			(CivilizationType, 					LeaderheadType)
VALUES		('CIVILIZATION_SENSHI_CHUKCHI', 	'LEADER_SENSHI_LAWTILIWADLIN');	
--==========================================================================================================================	
-- Civilization_UnitClassOverrides 
--==========================================================================================================================		
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 					UnitClassType, 		UnitType)
VALUES		('CIVILIZATION_SENSHI_CHUKCHI', 	'UNITCLASS_COMPOSITE_BOWMAN',	'UNIT_SENSHI_CHULTENNIN');
--==========================================================================================================================	
-- Civilization_BuildingClassOverrides 
--==========================================================================================================================		
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 					BuildingClassType,			BuildingType)
VALUES		('CIVILIZATION_SENSHI_CHUKCHI', 	'BUILDINGCLASS_BARRACKS',	'BUILDING_SENSHI_YARANGA');
--==========================================================================================================================	
--==========================================================================================================================	
-- Civilization_SpyNames
--==========================================================================================================================		
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_SPY_NAME_SENSHI_CHUKCHI_0'),	
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_SPY_NAME_SENSHI_CHUKCHI_1'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_SPY_NAME_SENSHI_CHUKCHI_2'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_SPY_NAME_SENSHI_CHUKCHI_3'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_SPY_NAME_SENSHI_CHUKCHI_4'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_SPY_NAME_SENSHI_CHUKCHI_5'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_SPY_NAME_SENSHI_CHUKCHI_6'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_SPY_NAME_SENSHI_CHUKCHI_7'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_SPY_NAME_SENSHI_CHUKCHI_8'),
			('CIVILIZATION_SENSHI_CHUKCHI', 	'TXT_KEY_SPY_NAME_SENSHI_CHUKCHI_9');
--==========================================================================================================================		
--==========================================================================================================================						
			
			

