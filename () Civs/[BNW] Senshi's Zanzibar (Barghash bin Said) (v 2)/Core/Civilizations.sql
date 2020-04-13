--==========================================================================================================================	
-- Civilizations
--==========================================================================================================================				
INSERT INTO Civilizations 	
			(Type, 									Description, 								ShortDescription, 									Adjective, 											Civilopedia, 									CivilopediaTag, 						DefaultPlayerColor, 			ArtDefineTag, ArtStyleType,		ArtStyleSuffix, ArtStylePrefix, IconAtlas, 					PortraitIndex, 	AlphaIconAtlas, 					SoundtrackTag, 	MapImage, 					DawnOfManQuote, 						DawnOfManImage,		DawnOfManAudio)
SELECT		('CIVILIZATION_SENSHI_ZANZIBAR'), 		('TXT_KEY_CIV_SENSHI_ZANZIBAR_DESC'), 		('TXT_KEY_CIV_SENSHI_ZANZIBAR_SHORT_DESC'),		('TXT_KEY_CIV_SENSHI_ZANZIBAR_ADJECTIVE'), 		('TXT_KEY_CIV5_SENSHI_ZANZIBAR_TEXT_1'), 		('TXT_KEY_CIV5_SENSHI_ZANZIBAR'), 		('PLAYERCOLOR_SENSHI_ZANZIBAR'), 		ArtDefineTag, ArtStyleType,		ArtStyleSuffix,	('AFRICAN'),	('SENSHI_ZANZIBAR_ATLAS'), 		0, 				('SENSHI_ZANZIBAR_ALPHA_ATLAS'), 	('ARABIA'), 	('ZanziMap412.dds'), 	('TXT_KEY_CIV5_DOM_SENSHI_BARGHASH_TEXT'), 	('BarghashDOM.dds'),	('AS2D_DOM_SPEECH_SENSHI_BARGHASH')
FROM Civilizations WHERE (Type = 'CIVILIZATION_ARABIA');

UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_ARABIA' )
	THEN '_ARABIA'
	ELSE '_AFRI' END) 
WHERE Type = 'CIVILIZATION_SENSHI_ZANZIBAR';
--==========================================================================================================================	
-- Civilization_CityNames
--==========================================================================================================================			
INSERT INTO Civilization_CityNames 
			(CivilizationType, 			 CityName)
VALUES		('CIVILIZATION_SENSHI_ZANZIBAR', 	'TXT_KEY_CITY_NAME_SENSHI_ZANZIBAR_01'),
			('CIVILIZATION_SENSHI_ZANZIBAR', 	'TXT_KEY_CITY_NAME_SENSHI_ZANZIBAR_02'),
			('CIVILIZATION_SENSHI_ZANZIBAR', 	'TXT_KEY_CITY_NAME_SENSHI_ZANZIBAR_03'),
			('CIVILIZATION_SENSHI_ZANZIBAR', 	'TXT_KEY_CITY_NAME_SENSHI_ZANZIBAR_04'),
			('CIVILIZATION_SENSHI_ZANZIBAR', 	'TXT_KEY_CITY_NAME_SENSHI_ZANZIBAR_05'),
			('CIVILIZATION_SENSHI_ZANZIBAR', 	'TXT_KEY_CITY_NAME_SENSHI_ZANZIBAR_06'),
			('CIVILIZATION_SENSHI_ZANZIBAR', 	'TXT_KEY_CITY_NAME_SENSHI_ZANZIBAR_07'),
			('CIVILIZATION_SENSHI_ZANZIBAR', 	'TXT_KEY_CITY_NAME_SENSHI_ZANZIBAR_08'),
			('CIVILIZATION_SENSHI_ZANZIBAR', 	'TXT_KEY_CITY_NAME_SENSHI_ZANZIBAR_09'),
			('CIVILIZATION_SENSHI_ZANZIBAR', 	'TXT_KEY_CITY_NAME_SENSHI_ZANZIBAR_10'),
			('CIVILIZATION_SENSHI_ZANZIBAR', 	'TXT_KEY_CITY_NAME_SENSHI_ZANZIBAR_11'),
			('CIVILIZATION_SENSHI_ZANZIBAR', 	'TXT_KEY_CITY_NAME_SENSHI_ZANZIBAR_12'),
			('CIVILIZATION_SENSHI_ZANZIBAR', 	'TXT_KEY_CITY_NAME_SENSHI_ZANZIBAR_13'),
			('CIVILIZATION_SENSHI_ZANZIBAR', 	'TXT_KEY_CITY_NAME_SENSHI_ZANZIBAR_14'),
			('CIVILIZATION_SENSHI_ZANZIBAR', 	'TXT_KEY_CITY_NAME_SENSHI_ZANZIBAR_15'),
			('CIVILIZATION_SENSHI_ZANZIBAR', 	'TXT_KEY_CITY_NAME_SENSHI_ZANZIBAR_16'),
			('CIVILIZATION_SENSHI_ZANZIBAR', 	'TXT_KEY_CITY_NAME_SENSHI_ZANZIBAR_17'),
			('CIVILIZATION_SENSHI_ZANZIBAR', 	'TXT_KEY_CITY_NAME_SENSHI_ZANZIBAR_18'),
			('CIVILIZATION_SENSHI_ZANZIBAR', 	'TXT_KEY_CITY_NAME_SENSHI_ZANZIBAR_19'),
			('CIVILIZATION_SENSHI_ZANZIBAR', 	'TXT_KEY_CITY_NAME_SENSHI_ZANZIBAR_20'),
			('CIVILIZATION_SENSHI_ZANZIBAR', 	'TXT_KEY_CITY_NAME_SENSHI_ZANZIBAR_21'),
			('CIVILIZATION_SENSHI_ZANZIBAR', 	'TXT_KEY_CITY_NAME_SENSHI_ZANZIBAR_22'),
			('CIVILIZATION_SENSHI_ZANZIBAR', 	'TXT_KEY_CITY_NAME_SENSHI_ZANZIBAR_23'),
			('CIVILIZATION_SENSHI_ZANZIBAR', 	'TXT_KEY_CITY_NAME_SENSHI_ZANZIBAR_24');
--==========================================================================================================================	
-- Civilization_FreeBuildingClasses
--==========================================================================================================================			
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_SENSHI_ZANZIBAR'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_ARABIA');
--==========================================================================================================================	
-- Civilization_FreeTechs
--==========================================================================================================================		
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_SENSHI_ZANZIBAR'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_ARABIA');
--==========================================================================================================================	
-- Civilization_FreeUnits
--==========================================================================================================================		
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_SENSHI_ZANZIBAR'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_ARABIA');
--==========================================================================================================================	
-- Civilization_Start_Along_Ocean
--==========================================================================================================================			
INSERT INTO Civilization_Start_Along_Ocean 
			(CivilizationType, 					StartAlongOcean)
VALUES		('CIVILIZATION_SENSHI_ZANZIBAR', 	1);	
--==========================================================================================================================	
-- Civilization_Leaders
--==========================================================================================================================			
INSERT INTO Civilization_Leaders 
			(CivilizationType, 					LeaderheadType)
VALUES		('CIVILIZATION_SENSHI_ZANZIBAR', 	'LEADER_SENSHI_BARGHASH');	
--==========================================================================================================================	
-- Civilization_UnitClassOverrides 
--==========================================================================================================================		
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 					UnitClassType, 		UnitType)
VALUES		('CIVILIZATION_SENSHI_ZANZIBAR', 	'UNITCLASS_CARAVEL',	'UNIT_SENSHI_JAHAZI');
--==========================================================================================================================	
-- Civilization_BuildingClassOverrides 
--==========================================================================================================================		
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 					BuildingClassType,			BuildingType)
VALUES		('CIVILIZATION_SENSHI_ZANZIBAR', 	'BUILDINGCLASS_HARBOR',	'BUILDING_SENSHI_BANDARI');
--==========================================================================================================================	
-- Civilization_Religions
--==========================================================================================================================		
INSERT INTO Civilization_Religions 
			(CivilizationType, 					ReligionType)
SELECT		'CIVILIZATION_SENSHI_ZANZIBAR', 	ReligionType
FROM Civilization_Religions WHERE (CivilizationType = 'CIVILIZATION_ARABIA');
--==========================================================================================================================	
-- Civilization_SpyNames
--==========================================================================================================================		
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		('CIVILIZATION_SENSHI_ZANZIBAR', 	'TXT_KEY_SPY_NAME_SENSHI_ZANZIBAR_0'),	
			('CIVILIZATION_SENSHI_ZANZIBAR', 	'TXT_KEY_SPY_NAME_SENSHI_ZANZIBAR_1'),
			('CIVILIZATION_SENSHI_ZANZIBAR', 	'TXT_KEY_SPY_NAME_SENSHI_ZANZIBAR_2'),
			('CIVILIZATION_SENSHI_ZANZIBAR', 	'TXT_KEY_SPY_NAME_SENSHI_ZANZIBAR_3'),
			('CIVILIZATION_SENSHI_ZANZIBAR', 	'TXT_KEY_SPY_NAME_SENSHI_ZANZIBAR_4'),
			('CIVILIZATION_SENSHI_ZANZIBAR', 	'TXT_KEY_SPY_NAME_SENSHI_ZANZIBAR_5'),
			('CIVILIZATION_SENSHI_ZANZIBAR', 	'TXT_KEY_SPY_NAME_SENSHI_ZANZIBAR_6'),
			('CIVILIZATION_SENSHI_ZANZIBAR', 	'TXT_KEY_SPY_NAME_SENSHI_ZANZIBAR_7'),
			('CIVILIZATION_SENSHI_ZANZIBAR', 	'TXT_KEY_SPY_NAME_SENSHI_ZANZIBAR_8'),
			('CIVILIZATION_SENSHI_ZANZIBAR', 	'TXT_KEY_SPY_NAME_SENSHI_ZANZIBAR_9');
--==========================================================================================================================		
--==========================================================================================================================						
			
			

