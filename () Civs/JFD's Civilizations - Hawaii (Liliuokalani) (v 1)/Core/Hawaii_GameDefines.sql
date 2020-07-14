--=======================================================================================================================
-- MASTER TABLES
--=======================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CustomModOptions(Name Text, Value INTEGER, Class INTEGER, DbUpdates INTEGER);
CREATE TABLE IF NOT EXISTS JFD_GlobalUserSettings (Type text, Value integer default 1);
--=======================================================================================================================
-- GAME DEFINES
--=======================================================================================================================
------------------------------------------------------------------------------------------------------------------------
-- BuildingClasses
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO BuildingClasses
		(Type, 									DefaultBuilding, 					Description)
VALUES	('BUILDINGCLASS_JFD_HAWAII',			'BUILDING_JFD_HAWAII',				'TXT_KEY_BUILDING_JFD_HAWAII'),
		('BUILDINGCLASS_JFD_HAWAII_ARTIST',		'BUILDING_JFD_HAWAII_ARTIST',		'TXT_KEY_BUILDING_JFD_HAWAII_ARTIST'),
		('BUILDINGCLASS_JFD_HAWAII_DIRECTOR',   'BUILDING_JFD_HAWAII_DIRECTOR',		'TXT_KEY_BUILDING_JFD_HAWAII_DIRECTOR'),
		('BUILDINGCLASS_JFD_HAWAII_MUSICIAN',   'BUILDING_JFD_HAWAII_MUSICIAN',		'TXT_KEY_BUILDING_JFD_HAWAII_MUSICIAN'),
		('BUILDINGCLASS_JFD_HAWAII_WRITER',		'BUILDING_JFD_HAWAII',				'TXT_KEY_BUILDING_JFD_HAWAII_WRITER');
--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================	
--------------------------------------------------------------------------------------------------------------------------
-- Buildings
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Buildings 	
		(Type, 							BuildingClass, Cost,  Defense,  GreatPeopleRateModifier, GoldMaintenance, GreatWorkSlotType, GreatWorkCount, SpecialistCount, SpecialistType, PrereqTech, Description,								Help,											Strategy,											Civilopedia,								  ArtDefineTag, MinAreaSize, DisplayPosition, HurryCostModifier, ConquestProb, NeverCapture, FreeStartEra, IconAtlas,				PortraitIndex)
SELECT	'BUILDING_JFD_HOUSE_OF_KINGS',	BuildingClass, Cost,  0,		5,						 0,				  GreatWorkSlotType, GreatWorkCount, SpecialistCount, SpecialistType, PrereqTech, 'TXT_KEY_BUILDING_JFD_HOUSE_OF_KINGS',	'TXT_KEY_BUILDING_JFD_HOUSE_OF_KINGS_HELP', 	'TXT_KEY_BUILDING_JFD_HOUSE_OF_KINGS_STRATEGY', 	'TXT_KEY_BUILDING_JFD_HOUSE_OF_KINGS_TEXT',   ArtDefineTag, MinAreaSize, DisplayPosition, HurryCostModifier, ConquestProb, NeverCapture, FreeStartEra, 'JFD_HAWAII_ICON_ATLAS',	3
FROM Buildings WHERE Type = 'BUILDING_MUSEUM';
--------------------------------------------------------------------------------------------------------------------------
-- Building_ClassesNeededInCity
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Building_ClassesNeededInCity
		(BuildingType, 					BuildingClassType)
SELECT	'BUILDING_JFD_HOUSE_OF_KINGS',	BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_MUSEUM';
--------------------------------------------------------------------------------------------------------------------------
-- Building_YieldChanges
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Building_YieldChanges 		
		(BuildingType, 					YieldType, Yield)
SELECT	'BUILDING_JFD_HOUSE_OF_KINGS',	YieldType, Yield
FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_MUSEUM';
--------------------------------------------------------------------------------------------------------------------------
-- Building_YieldModifiers
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Building_YieldModifiers 		
		(BuildingType, 					YieldType, Yield)
SELECT	'BUILDING_JFD_HOUSE_OF_KINGS',	YieldType, Yield
FROM Building_YieldModifiers WHERE BuildingType = 'BUILDING_MUSEUM';
--------------------------------------------------------------------------------------------------------------------------
-- Building_ResourceYieldChanges
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Building_ResourceYieldChanges 		
		(BuildingType, 					ResourceType, YieldType, Yield)
SELECT	'BUILDING_JFD_HOUSE_OF_KINGS',	ResourceType, YieldType, Yield
FROM Building_ResourceYieldChanges WHERE BuildingType = 'BUILDING_MUSEUM';
--------------------------------------------------------------------------------------------------------------------------
-- Building_Flavors
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Building_Flavors 		
		(BuildingType, 					FlavorType, Flavor)
SELECT	'BUILDING_JFD_HOUSE_OF_KINGS',	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_MUSEUM';

 INSERT INTO Building_Flavors 		
		(BuildingType, 					FlavorType, 		 Flavor)
 VALUES	('BUILDING_JFD_HOUSE_OF_KINGS',	'FLAVOR_HAPPINESS',  20);
 ------------------------------------------------------------------------------------------------------------------------	
-- Buildings
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Buildings 		
		(Type, 											BuildingClass,				GreatPeopleRateModifier,  GreatWorkCount,	Cost, FaithCost, PrereqTech, Description,											Help, 														NeverCapture)
VALUES	('BUILDING_JFD_HOUSE_OF_KINGS_GREAT_PEOPLE',	'BUILDINGCLASS_JFD_HAWAII',	5,						  -1,				-1,   -1,		 null,		 'TXT_KEY_BUILDING_JFD_HOUSE_OF_KINGS_GREAT_PEOPLE',	'TXT_KEY_BUILDING_JFD_HOUSE_OF_KINGS_GREAT_PEOPLE_HELP',	1);
--==========================================================================================================================
-- UNITS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- Units
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Units 	
		(Type, 					Class,	CombatClass, PrereqTech, Cost, Combat,   RangedCombat, Range, FaithCost, RequiresFaithPurchaseEnabled, Moves, CivilianAttackPriority, Special, Domain, DefaultUnitAI,	Description, 				 Help, 								Strategy, 								Civilopedia, 						ShowInPedia, OneShotTourism, OneShotTourismPercentOthers, AdvancedStartCost, WorkRate, ObsoleteTech, MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, Mechanized, CombatLimit,  GoldenAgeTurns,  XPValueAttack, XPValueDefense, Conscription, MoveRate, UnitArtInfo, 				UnitFlagAtlas, 				   UnitFlagIconOffset,  IconAtlas,					PortraitIndex)
SELECT	'UNIT_JFD_KAIMILOA',	Class,	CombatClass, PrereqTech, Cost, Combat-5, RangedCombat, Range, FaithCost, RequiresFaithPurchaseEnabled, Moves, CivilianAttackPriority, Special, Domain, DefaultUnitAI,	'TXT_KEY_UNIT_JFD_KAIMILOA', 'TXT_KEY_UNIT_JFD_KAIMILOA_HELP', 	'TXT_KEY_UNIT_JFD_KAIMILOA_STRATEGY',   'TXT_KEY_UNIT_JFD_KAIMILOA_TEXT',	ShowInPedia, OneShotTourism, OneShotTourismPercentOthers, AdvancedStartCost, WorkRate, ObsoleteTech, MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, Mechanized, CombatLimit,  GoldenAgeTurns,  XPValueAttack, XPValueDefense, Conscription, MoveRate, 'ART_DEF_UNIT_JFD_KAIMILOA',	'JFD_HAWAII_UNIT_FLAG_ATLAS',  0,					'JFD_HAWAII_ICON_ATLAS',	2
FROM Units WHERE Type = 'UNIT_IRONCLAD';  
--------------------------------------------------------------------------------------------------------------------------
-- UnitGameplay2DScripts
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 				SelectionSound, FirstSelectionSound)
SELECT	'UNIT_JFD_KAIMILOA',	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_IRONCLAD';
--------------------------------------------------------------------------------------------------------------------------
-- Unit_AITypes
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_AITypes 	
		(UnitType, 				UnitAIType)
SELECT	'UNIT_JFD_KAIMILOA',	UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_IRONCLAD';
--------------------------------------------------------------------------------------------------------------------------
-- Unit_Flavors
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_Flavors 	
		(UnitType, 				FlavorType, Flavor)
SELECT	'UNIT_JFD_KAIMILOA',	FlavorType, Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_IRONCLAD';
------------------------------------------------------------------------------------------------------------------------
-- Unit_ClassUpgrades
------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 				UnitClassType)
SELECT	'UNIT_JFD_KAIMILOA',	UnitClassType
FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_IRONCLAD';
--------------------------------------------------------------------------------------------------------------------------
-- Unit_ResourceQuantityRequirements
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_ResourceQuantityRequirements
		(UnitType, 				ResourceType, Cost)
SELECT	'UNIT_JFD_KAIMILOA',	ResourceType, Cost
FROM Unit_ResourceQuantityRequirements WHERE UnitType = 'UNIT_IRONCLAD';
--------------------------------------------------------------------------------------------------------------------------
-- Unit_FreePromotions
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_FreePromotions 		
		(UnitType, 				PromotionType)
SELECT	'UNIT_JFD_KAIMILOA',	PromotionType
FROM Unit_FreePromotions WHERE UnitType = 'UNIT_IRONCLAD';

INSERT INTO Unit_FreePromotions 		
		(UnitType, 				PromotionType)
VALUES	('UNIT_JFD_KAIMILOA',	'PROMOTION_RIVAL_TERRITORY');
--==========================================================================================================================	
-- LEADERS
--==========================================================================================================================	
------------------------------------------------------------------------------------------------------------------------
-- Leaders
--------------------------------------------------------------------------------------------------------------------------			
INSERT INTO Leaders 
		(Type, 					Description, 					Civilopedia, 						CivilopediaTag, 							ArtDefineTag, 			 VictoryCompetitiveness, WonderCompetitiveness,  MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 					PortraitIndex)
VALUES	('LEADER_JFD_HAWAII', 	'TXT_KEY_LEADER_JFD_HAWAII',	'TXT_KEY_LEADER_JFD_HAWAII_PEDIA',	'TXT_KEY_CIVILOPEDIA_LEADERS_JFD_HAWAII',   'JFD_Hawaii_Scene.xml',  4, 					 4, 					 2, 						2, 			5, 				9, 				9, 						7, 				6, 			6, 			7, 				6, 			5, 			'JFD_HAWAII_ICON_ATLAS', 	1);
--------------------------------------------------------------------------------------------------------------------------		
-- Leader_MajorCivApproachBiases
--------------------------------------------------------------------------------------------------------------------------						
INSERT INTO Leader_MajorCivApproachBiases 
		(LeaderType, 			MajorCivApproachType, 				Bias)
VALUES	('LEADER_JFD_HAWAII', 	'MAJOR_CIV_APPROACH_WAR', 			2),
		('LEADER_JFD_HAWAII', 	'MAJOR_CIV_APPROACH_HOSTILE', 		5),
		('LEADER_JFD_HAWAII', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	5),
		('LEADER_JFD_HAWAII', 	'MAJOR_CIV_APPROACH_GUARDED', 		9),
		('LEADER_JFD_HAWAII', 	'MAJOR_CIV_APPROACH_AFRAID', 		8),
		('LEADER_JFD_HAWAII', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		5),
		('LEADER_JFD_HAWAII', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		5);
--------------------------------------------------------------------------------------------------------------------------	
-- Leader_MajorCivApproachBiases
--------------------------------------------------------------------------------------------------------------------------							
INSERT INTO Leader_MinorCivApproachBiases 
		(LeaderType, 			MinorCivApproachType, 				Bias)
VALUES	('LEADER_JFD_HAWAII', 	'MINOR_CIV_APPROACH_IGNORE', 		4),
		('LEADER_JFD_HAWAII', 	'MINOR_CIV_APPROACH_FRIENDLY', 		5),
		('LEADER_JFD_HAWAII', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	3),
		('LEADER_JFD_HAWAII', 	'MINOR_CIV_APPROACH_CONQUEST', 		2),
		('LEADER_JFD_HAWAII', 	'MINOR_CIV_APPROACH_BULLY', 		1);
--------------------------------------------------------------------------------------------------------------------------	
-- Leader_Flavors
--------------------------------------------------------------------------------------------------------------------------							
INSERT INTO Leader_Flavors 
		(LeaderType, 			FlavorType, 						Flavor)
VALUES	('LEADER_JFD_HAWAII', 	'FLAVOR_OFFENSE', 					4),
		('LEADER_JFD_HAWAII', 	'FLAVOR_DEFENSE', 					6),
		('LEADER_JFD_HAWAII', 	'FLAVOR_CITY_DEFENSE', 				6),
		('LEADER_JFD_HAWAII', 	'FLAVOR_MILITARY_TRAINING', 		4),
		('LEADER_JFD_HAWAII', 	'FLAVOR_RECON', 					4),
		('LEADER_JFD_HAWAII', 	'FLAVOR_RANGED', 					4),
		('LEADER_JFD_HAWAII', 	'FLAVOR_MOBILE', 					5),
		('LEADER_JFD_HAWAII', 	'FLAVOR_NAVAL', 					7),
		('LEADER_JFD_HAWAII', 	'FLAVOR_NAVAL_RECON', 				6),
		('LEADER_JFD_HAWAII', 	'FLAVOR_NAVAL_GROWTH', 				6),
		('LEADER_JFD_HAWAII', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	7),
		('LEADER_JFD_HAWAII', 	'FLAVOR_AIR', 						2),
		('LEADER_JFD_HAWAII', 	'FLAVOR_EXPANSION', 				2),
		('LEADER_JFD_HAWAII', 	'FLAVOR_GROWTH', 					8),
		('LEADER_JFD_HAWAII', 	'FLAVOR_TILE_IMPROVEMENT', 			6),
		('LEADER_JFD_HAWAII', 	'FLAVOR_INFRASTRUCTURE', 			5),
		('LEADER_JFD_HAWAII', 	'FLAVOR_PRODUCTION', 				5),
		('LEADER_JFD_HAWAII', 	'FLAVOR_GOLD', 						5),
		('LEADER_JFD_HAWAII', 	'FLAVOR_SCIENCE', 					5),
		('LEADER_JFD_HAWAII', 	'FLAVOR_CULTURE', 					9),
		('LEADER_JFD_HAWAII', 	'FLAVOR_HAPPINESS', 				6),
		('LEADER_JFD_HAWAII', 	'FLAVOR_GREAT_PEOPLE', 				7),
		('LEADER_JFD_HAWAII', 	'FLAVOR_WONDER', 					5),
		('LEADER_JFD_HAWAII', 	'FLAVOR_RELIGION', 					5),
		('LEADER_JFD_HAWAII', 	'FLAVOR_DIPLOMACY', 				5),
		('LEADER_JFD_HAWAII', 	'FLAVOR_SPACESHIP', 				2),
		('LEADER_JFD_HAWAII', 	'FLAVOR_WATER_CONNECTION', 			5),
		('LEADER_JFD_HAWAII', 	'FLAVOR_NUKE', 						2),
		('LEADER_JFD_HAWAII', 	'FLAVOR_USE_NUKE', 					2),
		('LEADER_JFD_HAWAII', 	'FLAVOR_ESPIONAGE', 				5),
		('LEADER_JFD_HAWAII', 	'FLAVOR_AIRLIFT', 					5),
		('LEADER_JFD_HAWAII', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
		('LEADER_JFD_HAWAII', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
		('LEADER_JFD_HAWAII', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
		('LEADER_JFD_HAWAII', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
		('LEADER_JFD_HAWAII', 	'FLAVOR_ARCHAEOLOGY', 				5),
		('LEADER_JFD_HAWAII', 	'FLAVOR_AIR_CARRIER', 				5);
--------------------------------------------------------------------------------------------------------------------------	
-- Leader_Traits
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Leader_Traits 
		(LeaderType, 			TraitType)
VALUES	('LEADER_JFD_HAWAII', 	'TRAIT_JFD_HAWAII');
--==========================================================================================================================	
-- TRAITS
--==========================================================================================================================	
------------------------------------------------------------------------------------------------------------------------
-- Traits
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Traits 
		(Type, 					Description, 				 ShortDescription)
VALUES	('TRAIT_JFD_HAWAII', 	'TXT_KEY_TRAIT_JFD_HAWAII',	 'TXT_KEY_TRAIT_JFD_HAWAII_SHORT');
------------------------------------------------------------------------------------------------------------------------	
-- Buildings
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Buildings 		
		(Type, 								BuildingClass,							SpecialistType,			GreatPeopleRateChange,  GreatWorkCount,	Cost, FaithCost, PrereqTech, Description,							 Help, 											NeverCapture)
VALUES	('BUILDING_JFD_HAWAII_CULTURE',		'BUILDINGCLASS_JFD_HAWAII',				null,					0,						-1,				-1,   -1,		 null,		 'TXT_KEY_BUILDING_JFD_HAWAII_CULTURE',	 'TXT_KEY_BUILDING_JFD_HAWAII_CULTURE_HELP',	1),
		('BUILDING_JFD_HAWAII_ARTIST',		'BUILDINGCLASS_JFD_HAWAII_ARTIST',		'SPECIALIST_ARTIST',	1,						-1,				-1,   -1,		 null,		 'TXT_KEY_BUILDING_JFD_HAWAII_ARTIST',	 'TXT_KEY_BUILDING_JFD_HAWAII_ARTIST_HELP',		1),
		('BUILDING_JFD_HAWAII_MUSICIAN',	'BUILDINGCLASS_JFD_HAWAII_MUSICIAN',	'SPECIALIST_MUSICIAN',	1,						-1,				-1,   -1,		 null,		 'TXT_KEY_BUILDING_JFD_HAWAII_MUSICIAN', 'TXT_KEY_BUILDING_JFD_HAWAII_MUSICIAN_HELP',	1),
		('BUILDING_JFD_HAWAII_WRITER',		'BUILDINGCLASS_JFD_HAWAII_WRITER',		'SPECIALIST_WRITER',	1,						-1,				-1,   -1,		 null,		 'TXT_KEY_BUILDING_JFD_HAWAII_WRITER',	 'TXT_KEY_BUILDING_JFD_HAWAII_WRITER_HELP',		1);

INSERT INTO Buildings 		
		(Type, 								BuildingClass,							SpecialistType,				GreatPeopleRateChange, GreatWorkCount,	Cost, FaithCost, PrereqTech, Description,							 Help, 											NeverCapture)
SELECT  'BUILDING_JFD_HAWAII_DIRECTOR',		'BUILDINGCLASS_JFD_HAWAII_DIRECTOR',	'SPECIALIST_JFD_DIRECTOR',	1,						-1,				-1,   -1,		 null,		 'TXT_KEY_BUILDING_JFD_HAWAII_DIRECTOR', 'TXT_KEY_BUILDING_JFD_HAWAII_DIRECTOR_HELP',	1
WHERE EXISTS (SELECT Type FROM Specialists WHERE Type = 'SPECIALIST_JFD_DIRECTOR');
------------------------------------------------------------------------------------------------------------------------
-- Building_YieldChanges
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Building_YieldChanges 	
		(BuildingType, 					YieldType,			Yield)
VALUES	('BUILDING_JFD_HAWAII_CULTURE',	'YIELD_CULTURE',	1);	
------------------------------------------------------------------------------------------------------------------------	
-- Building_CityToolTipYieldFromOther
------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Building_CityToolTipYieldFromOther(BuildingType, YieldType, Yield integer);
INSERT INTO Building_CityToolTipYieldFromOther
		(BuildingType, 					YieldType,			Yield)
VALUES	('BUILDING_JFD_HAWAII_CULTURE',	'YIELD_CULTURE',	1);
--==========================================================================================================================	
-- DIPLOMACY
--==========================================================================================================================	
------------------------------------------------------------------------------------------------------------------------
-- Diplomacy_Responses
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Diplomacy_Responses																												 
		(LeaderType, 			ResponseType, 								Response, 												   Bias)
VALUES 	('LEADER_JFD_HAWAII', 	'RESPONSE_AI_DOF_BACKSTAB', 				'TXT_KEY_LEADER_JFD_HAWAII_DENOUNCE_FRIEND%', 			   500),
		('LEADER_JFD_HAWAII', 	'RESPONSE_ATTACKED_HOSTILE', 				'TXT_KEY_LEADER_JFD_HAWAII_ATTACKED_HOSTILE%', 			   500),
		('LEADER_JFD_HAWAII', 	'RESPONSE_DEFEATED', 						'TXT_KEY_LEADER_JFD_HAWAII_DEFEATED%', 					   500),
		('LEADER_JFD_HAWAII', 	'RESPONSE_DOW_GENERIC', 					'TXT_KEY_LEADER_JFD_HAWAII_DOW_GENERIC%', 				   500),
		('LEADER_JFD_HAWAII', 	'RESPONSE_FIRST_GREETING', 					'TXT_KEY_LEADER_JFD_HAWAII_FIRSTGREETING%', 			   500),
		('LEADER_JFD_HAWAII', 	'RESPONSE_RESPONSE_TO_BEING_DENOUNCED', 	'TXT_KEY_LEADER_JFD_HAWAII_RESPONSE_TO_BEING_DENOUNCED%',  500),
		('LEADER_JFD_HAWAII', 	'RESPONSE_WORK_AGAINST_SOMEONE', 			'TXT_KEY_LEADER_JFD_HAWAII_DENOUNCE%', 					   500),
		('LEADER_JFD_HAWAII', 	'RESPONSE_WORK_WITH_US', 					'TXT_KEY_LEADER_JFD_HAWAII_DEC_FRIENDSHIP%', 			   500);
--==========================================================================================================================	
-- CIVILIZATIONS
--==========================================================================================================================	
------------------------------------------------------------------------------------------------------------------------
-- Civilizations
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilizations 	
		(Type, 						DerivativeCiv,				Description,					ShortDescription,						Adjective,							  Civilopedia, 						 CivilopediaTag, 			DefaultPlayerColor,			ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas,					PortraitIndex,	AlphaIconAtlas,				SoundtrackTag,  MapImage, 				 DawnOfManQuote, 						DawnOfManImage)
SELECT	'CIVILIZATION_JFD_HAWAII',	'CIVILIZATION_POLYNESIA',	'TXT_KEY_CIV_JFD_HAWAII_DESC',  'TXT_KEY_CIV_JFD_HAWAII_SHORT_DESC',	'TXT_KEY_CIV_JFD_HAWAII_ADJECTIVE',	  'TXT_KEY_CIV5_JFD_HAWAII_TEXT_1',  'TXT_KEY_CIV5_JFD_HAWAII',	'PLAYERCOLOR_JFD_HAWAII',	ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, 'JFD_HAWAII_ICON_ATLAS',	0,				'JFD_HAWAII_ALPHA_ATLAS',	'Polynesia', 	'JFD_MapHawaii512.dds',	 'TXT_KEY_CIV5_DAWN_JFD_HAWAII_TEXT',	'JFD_DOM_Hawaii.dds'
FROM Civilizations WHERE Type = 'CIVILIZATION_POLYNESIA';
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_CityNames
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Civilization_CityNames 
		(CivilizationType, 			CityName)
VALUES	('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_CITY_NAME_JFD_HAWAII_01'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_CITY_NAME_JFD_HAWAII_02'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_CITY_NAME_JFD_HAWAII_03'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_CITY_NAME_JFD_HAWAII_04'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_CITY_NAME_JFD_HAWAII_05'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_CITY_NAME_JFD_HAWAII_06'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_CITY_NAME_JFD_HAWAII_07'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_CITY_NAME_JFD_HAWAII_08'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_CITY_NAME_JFD_HAWAII_09'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_CITY_NAME_JFD_HAWAII_10'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_CITY_NAME_JFD_HAWAII_11'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_CITY_NAME_JFD_HAWAII_12'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_CITY_NAME_JFD_HAWAII_13'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_CITY_NAME_JFD_HAWAII_14'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_CITY_NAME_JFD_HAWAII_15'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_CITY_NAME_JFD_HAWAII_16'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_CITY_NAME_JFD_HAWAII_17'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_CITY_NAME_JFD_HAWAII_18'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_CITY_NAME_JFD_HAWAII_19'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_CITY_NAME_JFD_HAWAII_20'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_CITY_NAME_JFD_HAWAII_21'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_CITY_NAME_JFD_HAWAII_22'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_CITY_NAME_JFD_HAWAII_23'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_CITY_NAME_JFD_HAWAII_24'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_CITY_NAME_JFD_HAWAII_25'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_CITY_NAME_JFD_HAWAII_26'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_CITY_NAME_JFD_HAWAII_27'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_CITY_NAME_JFD_HAWAII_28'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_CITY_NAME_JFD_HAWAII_29'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_CITY_NAME_JFD_HAWAII_30'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_CITY_NAME_JFD_HAWAII_31'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_CITY_NAME_JFD_HAWAII_32'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_CITY_NAME_JFD_HAWAII_33'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_CITY_NAME_JFD_HAWAII_34'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_CITY_NAME_JFD_HAWAII_35');
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_FreeBuildingClasses
--------------------------------------------------------------------------------------------------------------------------			
INSERT INTO Civilization_FreeBuildingClasses 
		(CivilizationType, 			BuildingClassType)
SELECT	'CIVILIZATION_JFD_HAWAII', 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE CivilizationType = 'CIVILIZATION_POLYNESIA';
--------------------------------------------------------------------------------------------------------------------------		
-- Civilization_FreeTechs
--------------------------------------------------------------------------------------------------------------------------			
INSERT INTO Civilization_FreeTechs 
		(CivilizationType, 			TechType)
SELECT	'CIVILIZATION_JFD_HAWAII', 	TechType
FROM Civilization_FreeTechs WHERE CivilizationType = 'CIVILIZATION_POLYNESIA';
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_FreeUnits
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_FreeUnits 
		(CivilizationType, 			UnitClassType, Count, UnitAIType)
SELECT	'CIVILIZATION_JFD_HAWAII', 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE CivilizationType = 'CIVILIZATION_POLYNESIA';
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_Leaders
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_Leaders 
		(CivilizationType, 			LeaderheadType)
VALUES	('CIVILIZATION_JFD_HAWAII',	'LEADER_JFD_HAWAII');
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_UnitClassOverrides 
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_UnitClassOverrides 
		(CivilizationType, 			UnitClassType, 			 UnitType)
VALUES	('CIVILIZATION_JFD_HAWAII', 'UNITCLASS_IRONCLAD',	 'UNIT_JFD_KAIMILOA');
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_BuildingClassOverrides 
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 			BuildingClassType, 		 BuildingType)
VALUES	('CIVILIZATION_JFD_HAWAII', 'BUILDINGCLASS_MUSEUM',	 'BUILDING_JFD_HOUSE_OF_KINGS');
--------------------------------------------------------------------------------------------------------------------------	
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_SpyNames
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_SpyNames 
		(CivilizationType, 			SpyName)
VALUES	('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_SPY_NAME_JFD_HAWAII_0'),	
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_SPY_NAME_JFD_HAWAII_1'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_SPY_NAME_JFD_HAWAII_2'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_SPY_NAME_JFD_HAWAII_3'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_SPY_NAME_JFD_HAWAII_4'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_SPY_NAME_JFD_HAWAII_5'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_SPY_NAME_JFD_HAWAII_6'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_SPY_NAME_JFD_HAWAII_7'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_SPY_NAME_JFD_HAWAII_8'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_SPY_NAME_JFD_HAWAII_9'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_SPY_NAME_JFD_HAWAII_10'),
		('CIVILIZATION_JFD_HAWAII', 'TXT_KEY_SPY_NAME_JFD_HAWAII_11');
--==========================================================================================================================
--==========================================================================================================================
