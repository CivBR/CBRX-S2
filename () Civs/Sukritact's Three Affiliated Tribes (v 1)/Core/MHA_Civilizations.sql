--==========================================================================================================================	
-- Civilizations
--==========================================================================================================================		
INSERT INTO Civilizations 	
			(Type, 							Description,						ShortDescription, 					Adjective, 						Civilopedia, 								CivilopediaTag, 				DefaultPlayerColor, 				ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, 				PortraitIndex, 	AlphaIconAtlas, 					SoundtrackTag, 		MapImage, 				DawnOfManQuote, 							DawnOfManAudio,				DawnOfManImage)
SELECT		('CIVILIZATION_MC_MHA'), 		('TXT_KEY_MC_MHA_DESC'),			('TXT_KEY_MC_MHA_SHORT_DESC'), 		('TXT_KEY_MC_MHA_ADJ'),			('TXT_KEY_CIV5_MC_MHA_TEXT_1'), 			('TXT_KEY_CIV5_MC_MHA'), 		('PLAYERCOLOR_MC_MHA'), 			ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('MC_MHA_ATLAS'), 		0, 				('MC_MHA_ALPHA_ATLAS'), 			('Iroquois'), 		('MHAMap512.dds'),		('TXT_KEY_CIV5_DOM_MC_FOURBEARS_TEXT'), 	('AS2D_DOM_SPEECH_MC_MHA'),	('MC_FourBears_DOM.dds')
FROM Civilizations WHERE (Type = 'CIVILIZATION_IROQUOIS');
--==========================================================================================================================	
-- Civilization_CityNames
--==========================================================================================================================	
INSERT INTO Civilization_CityNames
			(CivilizationType, 				CityName)
VALUES		('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_1'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_2'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_3'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_4'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_5'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_6'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_7'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_8'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_9'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_10'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_11'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_12'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_13'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_14'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_15'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_16'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_17'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_18'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_19'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_20'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_21'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_22'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_23'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_24'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_25'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_26'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_27'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_28'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_29'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_30'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_31'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_32'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_33'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_34'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_35'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_36'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_37'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_38'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_39'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_40'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_41'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_42'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_43'),
			('CIVILIZATION_MC_MHA', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_MHA_44');
--==========================================================================================================================	
-- Civilization_FreeBuildingClasses
--==========================================================================================================================			
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 				BuildingClassType)
SELECT		('CIVILIZATION_MC_MHA'), 		BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_IROQUOIS');
--==========================================================================================================================	
-- Civilization_FreeTechs
--==========================================================================================================================		
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 				TechType)
SELECT		('CIVILIZATION_MC_MHA'), 		TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_IROQUOIS');
--==========================================================================================================================	
-- Civilization_FreeUnits
--==========================================================================================================================		
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 				UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_MC_MHA'), 		UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_IROQUOIS');
--==========================================================================================================================	
-- Civilization_Leaders
--==========================================================================================================================		
INSERT INTO Civilization_Leaders 
			(CivilizationType, 			LeaderheadType)
VALUES		('CIVILIZATION_MC_MHA', 	'LEADER_MC_FOURBEARS');
--==========================================================================================================================	
-- Civilization_UnitClassOverrides 
--==========================================================================================================================		
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 			UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_MC_MHA', 	'UNITCLASS_LANCER', 	'UNIT_MC_BLACKMOUTH');
--==========================================================================================================================	
-- Civilization_BuildingClassOverrides 
--==========================================================================================================================	
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 			BuildingClassType, 			BuildingType)
VALUES		('CIVILIZATION_MC_MHA', 	'BUILDINGCLASS_WATERMILL', 	'BUILDING_MC_EARTHLODGE');
--==========================================================================================================================	
-- Civilization_Religions
--==========================================================================================================================		
INSERT INTO Civilization_Religions 
			(CivilizationType, 			ReligionType)
VALUES		('CIVILIZATION_MC_MHA', 	'RELIGION_PROTESTANTISM');
--==========================================================================================================================	
-- Civilization_SpyNames
--==========================================================================================================================	
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 				SpyName)
VALUES		('CIVILIZATION_MC_MHA', 		'TXT_KEY_SPY_NAME_MC_MHA_0'),
			('CIVILIZATION_MC_MHA', 		'TXT_KEY_SPY_NAME_MC_MHA_1'),
			('CIVILIZATION_MC_MHA', 		'TXT_KEY_SPY_NAME_MC_MHA_2'),
			('CIVILIZATION_MC_MHA', 		'TXT_KEY_SPY_NAME_MC_MHA_3'),
			('CIVILIZATION_MC_MHA', 		'TXT_KEY_SPY_NAME_MC_MHA_4'),
			('CIVILIZATION_MC_MHA', 		'TXT_KEY_SPY_NAME_MC_MHA_5'),
			('CIVILIZATION_MC_MHA', 		'TXT_KEY_SPY_NAME_MC_MHA_6'),
			('CIVILIZATION_MC_MHA', 		'TXT_KEY_SPY_NAME_MC_MHA_7'),
			('CIVILIZATION_MC_MHA', 		'TXT_KEY_SPY_NAME_MC_MHA_8'),
			('CIVILIZATION_MC_MHA', 		'TXT_KEY_SPY_NAME_MC_MHA_9');
--------------------------------	
-- Civilization_Start_Along_Ocean
--------------------------------			
INSERT INTO Civilization_Start_Along_River
		(CivilizationType, 			StartAlongRiver)
VALUES	('CIVILIZATION_MC_MHA', 	1);
--==========================================================================================================================
--==========================================================================================================================