--==========================================================================================================================	
-- CIVILIZATIONS
--==========================================================================================================================	
-- Civilizations
--------------------------------		
INSERT INTO Civilizations 	
		(Type, 						Description,					ShortDescription,						Adjective,								Civilopedia,					CivilopediaTag,	DefaultPlayerColor,			ArtDefineTag,	ArtStyleType,			ArtStyleSuffix, ArtStylePrefix, IconAtlas,				PortraitIndex,	AlphaIconAtlas,				SoundtrackTag,	MapImage, 			DawnOfManQuote, 					DawnOfManImage)
SELECT	'CIVILIZATION_PG_GRANCOLOMBIA',	'TXT_KEY_CIV_PG_GRANCOLOMBIA_DESC',	'TXT_KEY_CIV_PG_GRANCOLOMBIA_SHORT_DESC',	'TXT_KEY_CIV_PG_GRANCOLOMBIA_ADJECTIVE',	'TXT_KEY_CIV_PG_GRANCOLOMBIA_TEXT', CivilopediaTag, 'PLAYERCOLOR_PG_GRANCOLOMBIA',	ArtDefineTag,	'ARTSTYLE_GRECO_ROMAN',	ArtStyleSuffix, ArtStylePrefix, 'PG_GRANCOLOMBIA_ATLAS',	1,				'PG_GRANCOLOMBIA_ALPHA_ATLAS',	'Brazil',		'Map_Colombia.dds',	'TXT_KEY_CIV5_DOM_PG_BOLIVAR_TEXT',	'DOM_Bolivar.dds'
FROM Civilizations WHERE Type = 'CIVILIZATION_BRAZIL';

--------------------------------
-- Civilization_Start_Region_Priority
--------------------------------
INSERT INTO Civilization_Start_Region_Priority
		(CivilizationType,				RegionType)
VALUES	('CIVILIZATION_PG_GRANCOLOMBIA',	'REGION_PLAINS');

--------------------------------	
-- Civilization_Religions
--------------------------------			
INSERT INTO Civilization_Religions
		(CivilizationType, 			ReligionType)
VALUES	('CIVILIZATION_PG_GRANCOLOMBIA', 	'RELIGION_CHRISTIANITY');

--------------------------------
-- Civilization City Names
--------------------------------
INSERT INTO Civilization_CityNames	
                 (CivilizationType,                              CityName)	
VALUES			 ('CIVILIZATION_PG_GRANCOLOMBIA',   'TXT_KEY_CITY_NAME_PG_GRANCOLOMBIA_00'),	
                 ('CIVILIZATION_PG_GRANCOLOMBIA',   'TXT_KEY_CITY_NAME_PG_GRANCOLOMBIA_01'),	
				 ('CIVILIZATION_PG_GRANCOLOMBIA',   'TXT_KEY_CITY_NAME_PG_GRANCOLOMBIA_02'),	
                 ('CIVILIZATION_PG_GRANCOLOMBIA',   'TXT_KEY_CITY_NAME_PG_GRANCOLOMBIA_03'),	
                 ('CIVILIZATION_PG_GRANCOLOMBIA',   'TXT_KEY_CITY_NAME_PG_GRANCOLOMBIA_04'),	
                 ('CIVILIZATION_PG_GRANCOLOMBIA',   'TXT_KEY_CITY_NAME_PG_GRANCOLOMBIA_05'),	
                 ('CIVILIZATION_PG_GRANCOLOMBIA',   'TXT_KEY_CITY_NAME_PG_GRANCOLOMBIA_06'),	
                 ('CIVILIZATION_PG_GRANCOLOMBIA',   'TXT_KEY_CITY_NAME_PG_GRANCOLOMBIA_07'),	
                 ('CIVILIZATION_PG_GRANCOLOMBIA',   'TXT_KEY_CITY_NAME_PG_GRANCOLOMBIA_08'),	
                 ('CIVILIZATION_PG_GRANCOLOMBIA',   'TXT_KEY_CITY_NAME_PG_GRANCOLOMBIA_09'),	
                 ('CIVILIZATION_PG_GRANCOLOMBIA',   'TXT_KEY_CITY_NAME_PG_GRANCOLOMBIA_10'),	
                 ('CIVILIZATION_PG_GRANCOLOMBIA',   'TXT_KEY_CITY_NAME_PG_GRANCOLOMBIA_11'),	
                 ('CIVILIZATION_PG_GRANCOLOMBIA',   'TXT_KEY_CITY_NAME_PG_GRANCOLOMBIA_12'),	
                 ('CIVILIZATION_PG_GRANCOLOMBIA',   'TXT_KEY_CITY_NAME_PG_GRANCOLOMBIA_13'),	
                 ('CIVILIZATION_PG_GRANCOLOMBIA',   'TXT_KEY_CITY_NAME_PG_GRANCOLOMBIA_14'),	
                 ('CIVILIZATION_PG_GRANCOLOMBIA',   'TXT_KEY_CITY_NAME_PG_GRANCOLOMBIA_15'),	
                 ('CIVILIZATION_PG_GRANCOLOMBIA',   'TXT_KEY_CITY_NAME_PG_GRANCOLOMBIA_16'),	
                 ('CIVILIZATION_PG_GRANCOLOMBIA',   'TXT_KEY_CITY_NAME_PG_GRANCOLOMBIA_17'),	
                 ('CIVILIZATION_PG_GRANCOLOMBIA',   'TXT_KEY_CITY_NAME_PG_GRANCOLOMBIA_18'),	
                 ('CIVILIZATION_PG_GRANCOLOMBIA',   'TXT_KEY_CITY_NAME_PG_GRANCOLOMBIA_19'),	
                 ('CIVILIZATION_PG_GRANCOLOMBIA',   'TXT_KEY_CITY_NAME_PG_GRANCOLOMBIA_20'),	
                 ('CIVILIZATION_PG_GRANCOLOMBIA',   'TXT_KEY_CITY_NAME_PG_GRANCOLOMBIA_21'),	
                 ('CIVILIZATION_PG_GRANCOLOMBIA',   'TXT_KEY_CITY_NAME_PG_GRANCOLOMBIA_22'),	
                 ('CIVILIZATION_PG_GRANCOLOMBIA',   'TXT_KEY_CITY_NAME_PG_GRANCOLOMBIA_23'),	
                 ('CIVILIZATION_PG_GRANCOLOMBIA',   'TXT_KEY_CITY_NAME_PG_GRANCOLOMBIA_24'),	
                 ('CIVILIZATION_PG_GRANCOLOMBIA',   'TXT_KEY_CITY_NAME_PG_GRANCOLOMBIA_25'),	
                 ('CIVILIZATION_PG_GRANCOLOMBIA',   'TXT_KEY_CITY_NAME_PG_GRANCOLOMBIA_26'),	
                 ('CIVILIZATION_PG_GRANCOLOMBIA',   'TXT_KEY_CITY_NAME_PG_GRANCOLOMBIA_27');

--------------------------------	
-- Civilization_SpyNames
--------------------------------	
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 			SpyName)
VALUES		('CIVILIZATION_PG_GRANCOLOMBIA', 	'TXT_KEY_SPY_NAME_PG_GRANCOLOMBIA_0'),	
			('CIVILIZATION_PG_GRANCOLOMBIA', 	'TXT_KEY_SPY_NAME_PG_GRANCOLOMBIA_1'),
			('CIVILIZATION_PG_GRANCOLOMBIA', 	'TXT_KEY_SPY_NAME_PG_GRANCOLOMBIA_2'),
			('CIVILIZATION_PG_GRANCOLOMBIA', 	'TXT_KEY_SPY_NAME_PG_GRANCOLOMBIA_3'),
			('CIVILIZATION_PG_GRANCOLOMBIA', 	'TXT_KEY_SPY_NAME_PG_GRANCOLOMBIA_4'),
			('CIVILIZATION_PG_GRANCOLOMBIA', 	'TXT_KEY_SPY_NAME_PG_GRANCOLOMBIA_5'),
			('CIVILIZATION_PG_GRANCOLOMBIA', 	'TXT_KEY_SPY_NAME_PG_GRANCOLOMBIA_6'),
			('CIVILIZATION_PG_GRANCOLOMBIA', 	'TXT_KEY_SPY_NAME_PG_GRANCOLOMBIA_7'),
			('CIVILIZATION_PG_GRANCOLOMBIA', 	'TXT_KEY_SPY_NAME_PG_GRANCOLOMBIA_8'),
			('CIVILIZATION_PG_GRANCOLOMBIA', 	'TXT_KEY_SPY_NAME_PG_GRANCOLOMBIA_9');


--------------------------------	
-- DEFAULTS
--------------------------------			
INSERT INTO Civilization_FreeBuildingClasses
		(CivilizationType, 						BuildingClassType)
SELECT	'CIVILIZATION_PG_GRANCOLOMBIA', 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE CivilizationType = 'CIVILIZATION_GREECE';
		
INSERT INTO Civilization_FreeTechs 
		(CivilizationType, 						TechType)
SELECT	'CIVILIZATION_PG_GRANCOLOMBIA', 	TechType
FROM Civilization_FreeTechs WHERE CivilizationType = 'CIVILIZATION_GREECE';
	
INSERT INTO Civilization_FreeUnits 
		(CivilizationType, 						UnitClassType, Count, UnitAIType)
SELECT	'CIVILIZATION_PG_GRANCOLOMBIA', 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE CivilizationType = 'CIVILIZATION_GREECE';

--==========================================================================================================================
--==========================================================================================================================