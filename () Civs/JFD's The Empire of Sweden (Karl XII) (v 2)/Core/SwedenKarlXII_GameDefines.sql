--=======================================================================================================================
-- MASTER TABLES
--=======================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CustomModOptions(Name Text, Value INTEGER, Class INTEGER, DbUpdates INTEGER);
--=======================================================================================================================	
-- BUILDINGS
--=======================================================================================================================		
------------------------------------------------------------------------------------------------------------------------	
-- Buildings
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Buildings 	
		(Type, 						BuildingClass, PrereqTech, Cost, SpecialistType, SpecialistCount, FaithCost, GoldMaintenance, MinAreaSize, ConquestProb, NeverCapture, Description, 								Help, 												Strategy,												Civilopedia, 									  ArtDefineTag, PortraitIndex, IconAtlas)
SELECT	'BUILDING_JFD_WAR_ACADEMY',	BuildingClass, PrereqTech, Cost, SpecialistType, SpecialistCount, FaithCost, GoldMaintenance, MinAreaSize, ConquestProb, 1, 			'TXT_KEY_BUILDING_JFD_WAR_ACADEMY', 'TXT_KEY_BUILDING_JFD_WAR_ACADEMY_HELP',	'TXT_KEY_BUILDING_JFD_WAR_ACADEMY_STRATEGY',	'TXT_KEY_BUILDING_JFD_WAR_ACADEMY_TEXT',  ArtDefineTag, 3, 			   'JFD_SWEDEN_KARL_XII_ICON_ATLAS'
FROM Buildings WHERE Type = 'BUILDING_MILITARY_ACADEMY';

UPDATE Buildings
SET PrereqTech = 'TECH_METALLURGY'
WHERE Type = 'BUILDING_JFD_WAR_ACADEMY';
------------------------------------------------------------------------------------------------------------------------	
-- Building_ClassesNeededInCity
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Building_ClassesNeededInCity 	
		(BuildingType, 					BuildingClassType)
SELECT	'BUILDING_JFD_WAR_ACADEMY',		BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_MILITARY_ACADEMY';	
------------------------------------------------------------------------------------------------------------------------	
-- Building_DomainFreeExperiences
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Building_DomainFreeExperiences 	
		(BuildingType, 					DomainType, Experience)
SELECT	'BUILDING_JFD_WAR_ACADEMY',		DomainType, Experience+5
FROM Building_DomainFreeExperiences WHERE BuildingType = 'BUILDING_MILITARY_ACADEMY';	
------------------------------------------------------------------------------------------------------------------------	
-- Building_Flavors
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Building_Flavors 	
		(BuildingType, 					FlavorType, Flavor)
SELECT	'BUILDING_JFD_WAR_ACADEMY',		FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_MILITARY_ACADEMY';

INSERT INTO Building_Flavors 	
		(BuildingType, 					FlavorType,			 Flavor)
VALUES	('BUILDING_JFD_WAR_ACADEMY',	'FLAVOR_EXPANSION',  50);
--==========================================================================================================================
-- UNITS
--==========================================================================================================================
------------------------------------------------------------------------------------------------------------------------
-- UnitPromotions
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO UnitPromotions 
		(Type, 							LostWithUpgrade, Description, 							Help, 										Sound, 				CannotBeChosen, PortraitIndex,  IconAtlas, 			PediaType, 			PediaEntry)
VALUES	('PROMOTION_JFD_CAROLEAN_1',	0,				 'TXT_KEY_PROMOTION_JFD_CAROLEAN_1',	'TXT_KEY_PROMOTION_JFD_CAROLEAN_1_HELP',	'AS2D_IF_LEVELUP',	1, 				57, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_CAROLEAN_1'),
		('PROMOTION_JFD_CAROLEAN_2',	0,				 'TXT_KEY_PROMOTION_JFD_CAROLEAN_2',	'TXT_KEY_PROMOTION_JFD_CAROLEAN_2_HELP',	'AS2D_IF_LEVELUP',	1, 				59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_CAROLEAN_2');
------------------------------------------------------------------------------------------------------------------------	
-- UnitPromotion_Terrains
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO UnitPromotions_Terrains
		(PromotionType,					TerrainType,		Attack, Defense)
VALUES	('PROMOTION_JFD_CAROLEAN_1',	'TERRAIN_SNOW',		0,		-10),
		('PROMOTION_JFD_CAROLEAN_2',	'TERRAIN_TUNDRA',	15,		0);
------------------------------------------------------------------------------------------------------------------------	
-- Units
------------------------------------------------------------------------------------------------------------------------
UPDATE Units
SET Help = 'TXT_KEY_UNIT_JFD_CAROLEAN_HELP_SWEDEN_KARL_XII', Strategy = 'TXT_KEY_UNIT_JFD_CAROLEAN_STRATEGY_SWEDEN_KARL_XII'
WHERE Type = 'UNIT_SWEDISH_CAROLEAN';
------------------------------------------------------------------------------------------------------------------------
-- Unit_FreePromotions
------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_FreePromotions
		(UnitType, 					PromotionType)
VALUES	('UNIT_SWEDISH_CAROLEAN', 	'PROMOTION_JFD_CAROLEAN_1'),
		('UNIT_SWEDISH_CAROLEAN', 	'PROMOTION_JFD_CAROLEAN_2');	
--==========================================================================================================================	
-- LEADERS
--==========================================================================================================================	
------------------------------------------------------------------------------------------------------------------------
-- Leaders
------------------------------------------------------------------------------------------------------------------------			
INSERT INTO Leaders 
		(Type, 							Description, 							Civilopedia, 									CivilopediaTag, 									ArtDefineTag, 					IconAtlas, 							PortraitIndex)
VALUES	('LEADER_JFD_SWEDEN_KARL_XII', 	'TXT_KEY_LEADER_JFD_SWEDEN_KARL_XII', 	'TXT_KEY_LEADER_JFD_SWEDEN_KARL_XII_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_JFD_SWEDEN_KARL_XII', 	'JFD_SwedenKarlXII_Scene.xml',	'JFD_SWEDEN_KARL_XII_ICON_ATLAS', 	1);

UPDATE Leaders
SET VictoryCompetitiveness = 8,
WonderCompetitiveness = 3,
MinorCivCompetitiveness = 3,
Boldness = 8,
DiploBalance = 6,
WarmongerHate = 6,
DenounceWillingness = 5,
DoFWillingness = 5,
Loyalty = 6,
Neediness = 6,
Forgiveness = 4,
Chattiness = 4,
Meanness = 4
WHERE Type = 'LEADER_JFD_SWEDEN_KARL_XII';	
------------------------------------------------------------------------------------------------------------------------	
-- Leader_MajorCivApproachBiases
------------------------------------------------------------------------------------------------------------------------						
INSERT INTO Leader_MajorCivApproachBiases 
		(LeaderType, 					MajorCivApproachType, 				Bias)
VALUES	('LEADER_JFD_SWEDEN_KARL_XII', 	'MAJOR_CIV_APPROACH_WAR', 			7),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'MAJOR_CIV_APPROACH_HOSTILE', 		3),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	4),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'MAJOR_CIV_APPROACH_GUARDED', 		4),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'MAJOR_CIV_APPROACH_AFRAID', 		3),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		6),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		6);
------------------------------------------------------------------------------------------------------------------------	
-- Leader_MajorCivApproachBiases
------------------------------------------------------------------------------------------------------------------------						
INSERT INTO Leader_MinorCivApproachBiases 
		(LeaderType, 					MinorCivApproachType, 				Bias)
VALUES	('LEADER_JFD_SWEDEN_KARL_XII', 	'MINOR_CIV_APPROACH_IGNORE', 		3),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'MINOR_CIV_APPROACH_FRIENDLY', 		4),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	3),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'MINOR_CIV_APPROACH_CONQUEST', 		7),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'MINOR_CIV_APPROACH_BULLY', 		4);
------------------------------------------------------------------------------------------------------------------------	
-- Leader_Flavors
------------------------------------------------------------------------------------------------------------------------						
INSERT INTO Leader_Flavors 
		(LeaderType, 					FlavorType, 						Flavor)
VALUES	('LEADER_JFD_SWEDEN_KARL_XII', 	'FLAVOR_OFFENSE', 					7),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'FLAVOR_DEFENSE', 					7),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'FLAVOR_CITY_DEFENSE', 				4),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'FLAVOR_MILITARY_TRAINING', 		8),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'FLAVOR_RECON', 					4),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'FLAVOR_RANGED', 					7),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'FLAVOR_MOBILE', 					8),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'FLAVOR_NAVAL', 					4),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'FLAVOR_NAVAL_RECON', 				4),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'FLAVOR_NAVAL_GROWTH', 				3),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	3),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'FLAVOR_AIR', 						4),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'FLAVOR_EXPANSION', 				7),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'FLAVOR_GROWTH', 					7),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'FLAVOR_TILE_IMPROVEMENT', 			8),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'FLAVOR_INFRASTRUCTURE', 			5),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'FLAVOR_PRODUCTION', 				4),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'FLAVOR_GOLD', 						6),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'FLAVOR_SCIENCE', 					3),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'FLAVOR_CULTURE', 					4),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'FLAVOR_HAPPINESS', 				6),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'FLAVOR_GREAT_PEOPLE', 				6),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'FLAVOR_WONDER', 					4),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'FLAVOR_RELIGION', 					3),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'FLAVOR_DIPLOMACY', 				2),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'FLAVOR_SPACESHIP', 				2),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'FLAVOR_WATER_CONNECTION', 			2),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'FLAVOR_NUKE', 						2),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'FLAVOR_USE_NUKE', 					2),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'FLAVOR_ESPIONAGE', 				4),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'FLAVOR_AIRLIFT', 					2),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'FLAVOR_ARCHAEOLOGY', 				5),
		('LEADER_JFD_SWEDEN_KARL_XII', 	'FLAVOR_AIR_CARRIER', 				5);
--------------------------------------------------------------------------------------------------------------------------
-- Diplomacy_Responses
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Diplomacy_Responses
		(LeaderType, 					ResponseType, 							 			Response, 																	 	Bias)
VALUES 	('LEADER_JFD_SWEDEN_KARL_XII',	'RESPONSE_AI_DOF_BACKSTAB', 			 			'TXT_KEY_LEADER_JFD_SWEDEN_KARL_XII_DENOUNCE_FRIEND%', 			 				500),
		('LEADER_JFD_SWEDEN_KARL_XII',	'RESPONSE_ATTACKED_HOSTILE', 			 			'TXT_KEY_LEADER_JFD_SWEDEN_KARL_XII_ATTACKED_HOSTILE%', 			 			500),
		('LEADER_JFD_SWEDEN_KARL_XII',	'RESPONSE_DEFEATED', 					 			'TXT_KEY_LEADER_JFD_SWEDEN_KARL_XII_DEFEATED%', 					 			500),
		('LEADER_JFD_SWEDEN_KARL_XII',	'RESPONSE_DOW_GENERIC', 				 			'TXT_KEY_LEADER_JFD_SWEDEN_KARL_XII_DOW_GENERIC%', 				 				500),
		('LEADER_JFD_SWEDEN_KARL_XII',	'RESPONSE_EXPANSION_SERIOUS_WARNING', 				'TXT_KEY_LEADER_JFD_SWEDEN_KARL_XII_EXPANSION_SERIOUS_WARNING%', 	 			500),
		('LEADER_JFD_SWEDEN_KARL_XII',	'RESPONSE_FIRST_GREETING', 				 			'TXT_KEY_LEADER_JFD_SWEDEN_KARL_XII_FIRSTGREETING%', 				 			500),
		('LEADER_JFD_SWEDEN_KARL_XII',	'RESPONSE_GREETING_HOSTILE_HELLO', 					'TXT_KEY_LEADER_JFD_SWEDEN_KARL_XII_GREETING_HOSTILE_HELLO%', 		 			500),
		('LEADER_JFD_SWEDEN_KARL_XII',	'RESPONSE_GREETING_NEUTRAL_HELLO', 					'TXT_KEY_LEADER_JFD_SWEDEN_KARL_XII_GREETING_NEUTRAL_HELLO%', 		 			500),
		('LEADER_JFD_SWEDEN_KARL_XII',	'RESPONSE_GREETING_POLITE_HELLO', 					'TXT_KEY_LEADER_JFD_SWEDEN_KARL_XII_GREETING_POLITE_HELLO%', 		 			500),
		('LEADER_JFD_SWEDEN_KARL_XII',	'RESPONSE_HOSTILE_AGGRESSIVE_MILITARY_WARNING', 	'TXT_KEY_LEADER_JFD_SWEDEN_KARL_XII_HOSTILE_AGGRESSIVE_MILITARY_WARNING%', 		500),
		('LEADER_JFD_SWEDEN_KARL_XII',	'RESPONSE_LUXURY_TRADE', 							'TXT_KEY_LEADER_JFD_SWEDEN_KARL_XII_LUXURY_TRADE%', 		  					500),
		('LEADER_JFD_SWEDEN_KARL_XII',	'RESPONSE_OPEN_BORDERS_EXCHANGE', 					'TXT_KEY_LEADER_JFD_SWEDEN_KARL_XII_OPEN_BORDERS_EXCHANGE%', 		  			500),
		('LEADER_JFD_SWEDEN_KARL_XII',	'RESPONSE_REQUEST', 								'TXT_KEY_LEADER_JFD_SWEDEN_KARL_XII_REQUEST%', 		  							500),
		('LEADER_JFD_SWEDEN_KARL_XII',	'RESPONSE_TOO_SOON_NO_PEACE', 			 			'TXT_KEY_LEADER_JFD_SWEDEN_KARL_XII_TOO_SOON_NO_PEACE%', 			  			500),
		('LEADER_JFD_SWEDEN_KARL_XII',	'RESPONSE_RESPONSE_TO_BEING_DENOUNCED',  			'TXT_KEY_LEADER_JFD_SWEDEN_KARL_XII_RESPONSE_TO_BEING_DENOUNCED%',   			500),
		('LEADER_JFD_SWEDEN_KARL_XII',	'RESPONSE_WINWAR', 		 							'TXT_KEY_LEADER_JFD_SWEDEN_KARL_XII_WINWAR%', 					  				500),
		('LEADER_JFD_SWEDEN_KARL_XII',	'RESPONSE_WORK_AGAINST_SOMEONE', 		 			'TXT_KEY_LEADER_JFD_SWEDEN_KARL_XII_DENOUNCE%', 					  			500),
		('LEADER_JFD_SWEDEN_KARL_XII',	'RESPONSE_WORK_WITH_US', 				 			'TXT_KEY_LEADER_JFD_SWEDEN_KARL_XII_DEC_FRIENDSHIP%', 			  	  			500);
------------------------------------------------------------------------------------------------------------------------	
-- Leader_Traits
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Leader_Traits 
		(LeaderType, 					TraitType)
VALUES	('LEADER_JFD_SWEDEN_KARL_XII', 	'TRAIT_JFD_SWEDEN_KARL_XII');
------------------------------------------------------------------------------------------------------------------------
-- Traits
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Traits 
		(Type, 							Description, 							ShortDescription)
VALUES	('TRAIT_JFD_SWEDEN_KARL_XII',	'TXT_KEY_TRAIT_JFD_SWEDEN_KARL_XII',	'TXT_KEY_TRAIT_JFD_SWEDEN_KARL_XII_SHORT');	
------------------------------------------------------------------------------------------------------------------------
-- BuildingClasses
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO BuildingClasses
		(Type, 										 DefaultBuilding, 						Description)
VALUES	('BUILDINGCLASS_DUMMY_JFD_SWEDEN_KARL_XII',  'BUILDING_DUMMY_JFD_SWEDEN_KARL_XII',  'TXT_KEY_BUILDING_DUMMY_JFD_SWEDEN_KARL_XII');
------------------------------------------------------------------------------------------------------------------------	
-- Buildings
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Buildings 		
		(Type, 									BuildingClass,								FoodKept,	GreatWorkCount,	Cost, FaithCost, PrereqTech, Description,									Help, 												NeverCapture)
VALUES	('BUILDING_DUMMY_JFD_SWEDEN_KARL_XII',	'BUILDINGCLASS_DUMMY_JFD_SWEDEN_KARL_XII',	10,			-1,				-1,   -1,		 null,		 'TXT_KEY_BUILDING_DUMMY_JFD_SWEDEN_KARL_XII',	'TXT_KEY_BUILDING_DUMMY_JFD_SWEDEN_KARL_XII_HELP',	1);
--==========================================================================================================================	
-- CIVILIZATIONS
--==========================================================================================================================	
------------------------------------------------------------------------------------------------------------------------
-- Civilizations
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Civilizations 	
		(Type, 									DerivativeCiv,			SoundtrackTag,  MapImage, 						DawnOfManQuote, 								DawnOfManImage,					Description,								ShortDescription,								Adjective,										Civilopedia, CivilopediaTag, DefaultPlayerColor,				ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas,						PortraitIndex,	AlphaIconAtlas)
SELECT	'CIVILIZATION_JFD_SWEDEN_KARL_XII',		'CIVILIZATION_SWEDEN',	'Sweden', 		'JFD_MapSwedenKarlXII512.dds',	'TXT_KEY_CIV_DAWN_JFD_SWEDEN_KARL_XII_TEXT',	'JFD_DOM_SwedenKarlXII.dds',	'TXT_KEY_CIV_JFD_SWEDEN_KARL_XII_DESC', 	'TXT_KEY_CIV_JFD_SWEDEN_KARL_XII_SHORT_DESC',	'TXT_KEY_CIV_JFD_SWEDEN_KARL_XII_ADJECTIVE',	Civilopedia, CivilopediaTag, 'PLAYERCOLOR_JFD_SWEDEN_KARL_XII',	ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, 'EXPANSION_CIV_COLOR_ATLAS',	8,				'EXPANSION_CIV_ALPHA_ATLAS'
FROM Civilizations WHERE Type = 'CIVILIZATION_SWEDEN';

UPDATE Civilizations
SET DerivativeCiv = 'CIVILIZATION_JFD_SWEDEN_KARL_XII'
WHERE DerivativeCiv = 'CIVILIZATION_SWEDEN';

CREATE TRIGGER JFD_SwedenKarlXII_Civilizations
AFTER INSERT ON Civilizations
WHEN NEW.DerivativeCiv = 'CIVILIZATION_SWEDEN'
BEGIN
	UPDATE Civilizations
	SET DerivativeCiv = 'CIVILIZATION_JFD_SWEDEN_KARL_XII'
	WHERE NEW.Type;
END;
------------------------------------------------------------------------------------------------------------------------	
-- Civilization_CityNames
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Civilization_CityNames 
		(CivilizationType, 						CityName)
VALUES	('CIVILIZATION_JFD_SWEDEN_KARL_XII', 	'TXT_KEY_CITY_NAME_JFD_SWEDEN_KARL_XII_1'),
		('CIVILIZATION_JFD_SWEDEN_KARL_XII', 	'TXT_KEY_CITY_NAME_JFD_SWEDEN_KARL_XII_2'),
		('CIVILIZATION_JFD_SWEDEN_KARL_XII', 	'TXT_KEY_CITY_NAME_JFD_SWEDEN_KARL_XII_3'),
		('CIVILIZATION_JFD_SWEDEN_KARL_XII', 	'TXT_KEY_CITY_NAME_JFD_SWEDEN_KARL_XII_4'),
		('CIVILIZATION_JFD_SWEDEN_KARL_XII', 	'TXT_KEY_CITY_NAME_JFD_SWEDEN_KARL_XII_5'),
		('CIVILIZATION_JFD_SWEDEN_KARL_XII', 	'TXT_KEY_CITY_NAME_JFD_SWEDEN_KARL_XII_6'),
		('CIVILIZATION_JFD_SWEDEN_KARL_XII', 	'TXT_KEY_CITY_NAME_JFD_SWEDEN_KARL_XII_7'),
		('CIVILIZATION_JFD_SWEDEN_KARL_XII', 	'TXT_KEY_CITY_NAME_JFD_SWEDEN_KARL_XII_8'),
		('CIVILIZATION_JFD_SWEDEN_KARL_XII', 	'TXT_KEY_CITY_NAME_JFD_SWEDEN_KARL_XII_9'),
		('CIVILIZATION_JFD_SWEDEN_KARL_XII', 	'TXT_KEY_CITY_NAME_JFD_SWEDEN_KARL_XII_10'),
		('CIVILIZATION_JFD_SWEDEN_KARL_XII', 	'TXT_KEY_CITY_NAME_JFD_SWEDEN_KARL_XII_11'),
		('CIVILIZATION_JFD_SWEDEN_KARL_XII', 	'TXT_KEY_CITY_NAME_JFD_SWEDEN_KARL_XII_12'),
		('CIVILIZATION_JFD_SWEDEN_KARL_XII', 	'TXT_KEY_CITY_NAME_JFD_SWEDEN_KARL_XII_13'),
		('CIVILIZATION_JFD_SWEDEN_KARL_XII', 	'TXT_KEY_CITY_NAME_JFD_SWEDEN_KARL_XII_14'),
		('CIVILIZATION_JFD_SWEDEN_KARL_XII', 	'TXT_KEY_CITY_NAME_JFD_SWEDEN_KARL_XII_15'),
		('CIVILIZATION_JFD_SWEDEN_KARL_XII', 	'TXT_KEY_CITY_NAME_JFD_SWEDEN_KARL_XII_16'),
		('CIVILIZATION_JFD_SWEDEN_KARL_XII', 	'TXT_KEY_CITY_NAME_JFD_SWEDEN_KARL_XII_17'),
		('CIVILIZATION_JFD_SWEDEN_KARL_XII', 	'TXT_KEY_CITY_NAME_JFD_SWEDEN_KARL_XII_18'),
		('CIVILIZATION_JFD_SWEDEN_KARL_XII', 	'TXT_KEY_CITY_NAME_JFD_SWEDEN_KARL_XII_19'),
		('CIVILIZATION_JFD_SWEDEN_KARL_XII', 	'TXT_KEY_CITY_NAME_JFD_SWEDEN_KARL_XII_20'),
		('CIVILIZATION_JFD_SWEDEN_KARL_XII', 	'TXT_KEY_CITY_NAME_JFD_SWEDEN_KARL_XII_21'),
		('CIVILIZATION_JFD_SWEDEN_KARL_XII', 	'TXT_KEY_CITY_NAME_JFD_SWEDEN_KARL_XII_22'),
		('CIVILIZATION_JFD_SWEDEN_KARL_XII', 	'TXT_KEY_CITY_NAME_JFD_SWEDEN_KARL_XII_23'),
		('CIVILIZATION_JFD_SWEDEN_KARL_XII', 	'TXT_KEY_CITY_NAME_JFD_SWEDEN_KARL_XII_24'),
		('CIVILIZATION_JFD_SWEDEN_KARL_XII', 	'TXT_KEY_CITY_NAME_JFD_SWEDEN_KARL_XII_25'),
		('CIVILIZATION_JFD_SWEDEN_KARL_XII', 	'TXT_KEY_CITY_NAME_JFD_SWEDEN_KARL_XII_26'),
		('CIVILIZATION_JFD_SWEDEN_KARL_XII', 	'TXT_KEY_CITY_NAME_JFD_SWEDEN_KARL_XII_27'),
		('CIVILIZATION_JFD_SWEDEN_KARL_XII', 	'TXT_KEY_CITY_NAME_JFD_SWEDEN_KARL_XII_28'),
		('CIVILIZATION_JFD_SWEDEN_KARL_XII', 	'TXT_KEY_CITY_NAME_JFD_SWEDEN_KARL_XII_29'),
		('CIVILIZATION_JFD_SWEDEN_KARL_XII', 	'TXT_KEY_CITY_NAME_JFD_SWEDEN_KARL_XII_30'),
		('CIVILIZATION_JFD_SWEDEN_KARL_XII', 	'TXT_KEY_CITY_NAME_JFD_SWEDEN_KARL_XII_31'),
		('CIVILIZATION_JFD_SWEDEN_KARL_XII', 	'TXT_KEY_CITY_NAME_JFD_SWEDEN_KARL_XII_32'),
		('CIVILIZATION_JFD_SWEDEN_KARL_XII', 	'TXT_KEY_CITY_NAME_JFD_SWEDEN_KARL_XII_33');
------------------------------------------------------------------------------------------------------------------------	
-- Civilization_FreeBuildingClasses
------------------------------------------------------------------------------------------------------------------------			
INSERT INTO Civilization_FreeBuildingClasses 
		(CivilizationType, 						BuildingClassType)
SELECT	'CIVILIZATION_JFD_SWEDEN_KARL_XII',		BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE CivilizationType = 'CIVILIZATION_SWEDEN';
------------------------------------------------------------------------------------------------------------------------	
-- Civilization_FreeTechs
------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_FreeTechs 
		(CivilizationType, 						TechType)
SELECT	'CIVILIZATION_JFD_SWEDEN_KARL_XII',		TechType
FROM Civilization_FreeTechs WHERE CivilizationType = 'CIVILIZATION_SWEDEN';
------------------------------------------------------------------------------------------------------------------------	
-- Civilization_FreeUnits
------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_FreeUnits	
		(CivilizationType, 						UnitClassType, Count, UnitAIType)
SELECT	'CIVILIZATION_JFD_SWEDEN_KARL_XII',		UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE CivilizationType = 'CIVILIZATION_SWEDEN';
------------------------------------------------------------------------------------------------------------------------	
-- Civilization_Leaders
------------------------------------------------------------------------------------------------------------------------			
INSERT INTO Civilization_Leaders 
		(CivilizationType, 						LeaderheadType)
VALUES	('CIVILIZATION_JFD_SWEDEN_KARL_XII',	'LEADER_JFD_SWEDEN_KARL_XII');
------------------------------------------------------------------------------------------------------------------------	
-- Civilization_UnitClassOverrides 
------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_UnitClassOverrides 
		(CivilizationType, 						UnitClassType, 						UnitType)
VALUES	('CIVILIZATION_JFD_SWEDEN_KARL_XII',	'UNITCLASS_RIFLEMAN',				'UNIT_SWEDISH_CAROLEAN');
------------------------------------------------------------------------------------------------------------------------	
-- Civilization_BuildingClassOverrides
------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 						BuildingClassType, 					BuildingType)
VALUES	('CIVILIZATION_JFD_SWEDEN_KARL_XII',	'BUILDINGCLASS_MILITARY_ACADEMY',	'BUILDING_JFD_WAR_ACADEMY');
--------------------------------------------------------------------------------------------------------------------------
-- Civilization_Religions
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Civilization_Religions 
		(CivilizationType, 						ReligionType)
VALUES	('CIVILIZATION_JFD_SWEDEN_KARL_XII', 	'RELIGION_PROTESTANTISM');
------------------------------------------------------------------------------------------------------------------------	
-- Civilization_SpyNames
------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_SpyNames 
		(CivilizationType, 						SpyName)
VALUES	('CIVILIZATION_JFD_SWEDEN_KARL_XII',	'TXT_KEY_SPY_NAME_JFD_SWEDEN_KARL_XII_0'),	
		('CIVILIZATION_JFD_SWEDEN_KARL_XII',	'TXT_KEY_SPY_NAME_JFD_SWEDEN_KARL_XII_1'),
		('CIVILIZATION_JFD_SWEDEN_KARL_XII',	'TXT_KEY_SPY_NAME_JFD_SWEDEN_KARL_XII_2'),
		('CIVILIZATION_JFD_SWEDEN_KARL_XII',	'TXT_KEY_SPY_NAME_JFD_SWEDEN_KARL_XII_3'),
		('CIVILIZATION_JFD_SWEDEN_KARL_XII',	'TXT_KEY_SPY_NAME_JFD_SWEDEN_KARL_XII_4'),
		('CIVILIZATION_JFD_SWEDEN_KARL_XII',	'TXT_KEY_SPY_NAME_JFD_SWEDEN_KARL_XII_5'),
		('CIVILIZATION_JFD_SWEDEN_KARL_XII',	'TXT_KEY_SPY_NAME_JFD_SWEDEN_KARL_XII_6'),
		('CIVILIZATION_JFD_SWEDEN_KARL_XII',	'TXT_KEY_SPY_NAME_JFD_SWEDEN_KARL_XII_7'),
		('CIVILIZATION_JFD_SWEDEN_KARL_XII',	'TXT_KEY_SPY_NAME_JFD_SWEDEN_KARL_XII_8'),
		('CIVILIZATION_JFD_SWEDEN_KARL_XII',	'TXT_KEY_SPY_NAME_JFD_SWEDEN_KARL_XII_9');
--------------------------------------------------------------------------------------------------------------------------
-- Civilization_Start_Region_Avoid
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Civilization_Start_Region_Avoid 
		(CivilizationType, 						RegionType)
VALUES	('CIVILIZATION_JFD_SWEDEN_KARL_XII', 	'REGION_HILLS');
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_Start_Region_Priority 
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_Start_Region_Priority 
		(CivilizationType, 						RegionType)
VALUES	('CIVILIZATION_JFD_SWEDEN_KARL_XII', 	'REGION_TUNDRA');
--==========================================================================================================================
--==========================================================================================================================