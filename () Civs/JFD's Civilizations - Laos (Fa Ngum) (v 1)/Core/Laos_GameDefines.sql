--=======================================================================================================================
-- MASTER TABLES
--=======================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CustomModOptions(Name Text, Value INTEGER, Class INTEGER, DbUpdates INTEGER);
CREATE TABLE IF NOT EXISTS JFD_GlobalUserSettings (Type text, Value integer default 1);

INSERT OR REPLACE INTO CustomModOptions(Name, Value) VALUES('EVENTS_UNIT_CREATED', 1);
--=======================================================================================================================
-- GAME DEFINES
--=======================================================================================================================
------------------------------------------------------------------------------------------------------------------------
-- BuildingClasses
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO BuildingClasses
		(Type, 						 DefaultBuilding, 		Description)
VALUES	('BUILDINGCLASS_JFD_LAOS',   'BUILDING_JFD_LAOS',   'TXT_KEY_BUILDING_JFD_LAOS');
--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================	
--------------------------------------------------------------------------------------------------------------------------
-- Buildings
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Buildings 	
		(Type, 						BuildingClass, Happiness, Cost, GoldMaintenance, GreatWorkSlotType, GreatWorkCount, SpecialistCount, SpecialistType, PrereqTech, Description,					Help,								Strategy,								Civilopedia,						ArtDefineTag, MinAreaSize, DisplayPosition, HurryCostModifier, ConquestProb, NeverCapture, FreeStartEra, IconAtlas,				 PortraitIndex)
SELECT	'BUILDING_JFD_THART',		BuildingClass, 1,		  Cost, GoldMaintenance, GreatWorkSlotType, GreatWorkCount, SpecialistCount, SpecialistType, PrereqTech, 'TXT_KEY_BUILDING_JFD_THART',	'TXT_KEY_BUILDING_JFD_THART_HELP', 	'TXT_KEY_BUILDING_JFD_THART_STRATEGY', 	'TXT_KEY_BUILDING_JFD_THART_TEXT', 	ArtDefineTag, MinAreaSize, DisplayPosition, HurryCostModifier, ConquestProb, NeverCapture, FreeStartEra, 'JFD_LAOS_ICON_ATLAS',	 4
FROM Buildings WHERE Type = 'BUILDING_SHRINE';
--------------------------------------------------------------------------------------------------------------------------
-- Building_YieldChanges
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Building_YieldChanges 		
		(BuildingType, 				YieldType, Yield)
SELECT	'BUILDING_JFD_THART',		YieldType, Yield
FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_SHRINE';
--------------------------------------------------------------------------------------------------------------------------
-- Building_YieldModifiers
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Building_YieldModifiers 		
		(BuildingType, 				YieldType, Yield)
SELECT	'BUILDING_JFD_THART',		YieldType, Yield
FROM Building_YieldModifiers WHERE BuildingType = 'BUILDING_SHRINE';
--------------------------------------------------------------------------------------------------------------------------
-- Building_Flavors
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Building_Flavors 		
		(BuildingType, 				FlavorType, Flavor)
SELECT	'BUILDING_JFD_THART',		FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_SHRINE';

INSERT INTO Building_Flavors 		
		(BuildingType, 			FlavorType, 		Flavor)
VALUES	('BUILDING_JFD_THART',	'FLAVOR_HAPPINESS', 20);
--==========================================================================================================================
-- UNITS
--==========================================================================================================================
------------------------------------------------------------------------------------------------------------------------
-- UnitPromotions
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO UnitPromotions 
		(Type, 								Description, 								Help, 											Sound, 				CityAttack, CannotBeChosen, LostWithUpgrade, PortraitIndex, IconAtlas, 		  PediaType, 			PediaEntry)
VALUES	('PROMOTION_JFD_UPARAJA_ELEPHANT',	'TXT_KEY_PROMOTION_JFD_UPARAJA_ELEPHANT',	'TXT_KEY_PROMOTION_JFD_UPARAJA_ELEPHANT_HELP',	'AS2D_IF_LEVELUP', 	100,		1, 				0, 				 59, 			'ABILITY_ATLAS',  'PEDIA_ATTRIBUTES',   'TXT_KEY_PROMOTION_JFD_UPARAJA_ELEPHANT');

INSERT INTO UnitPromotions 
		(Type, 						Description, 						Help, 									Sound, 				CannotBeChosen, LostWithUpgrade,  PortraitIndex,  IconAtlas, 		PediaType, 			 PediaEntry)
SELECT	'PROMOTION_JFD_UPARAJA',	'TXT_KEY_PROMOTION_JFD_UPARAJA',	'TXT_KEY_PROMOTION_JFD_UPARAJA_HELP',	'AS2D_IF_LEVELUP', 	1, 				0, 				  59, 			  'ABILITY_ATLAS',  'PEDIA_ATTRIBUTES',  'TXT_KEY_PROMOTION_JFD_UPARAJA'
WHERE NOT EXISTS (SELECT Name FROM CustomModOptions WHERE Name = 'COMMUNITY_PATCH' AND Value = 1);
	
INSERT INTO UnitPromotions_Features
		(PromotionType,						FeatureType,		DoubleMove)
VALUES	('PROMOTION_JFD_UPARAJA_ELEPHANT',	'FEATURE_FOREST',	1),
		('PROMOTION_JFD_UPARAJA_ELEPHANT',	'FEATURE_JUNGLE',	1);
--------------------------------------------------------------------------------------------------------------------------
-- Units
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Units 	
		(Type, 				Class, CombatClass, PrereqTech, Cost, Combat, RangedCombat, Range, FaithCost, RequiresFaithPurchaseEnabled, Moves, CivilianAttackPriority, Special, Domain, DefaultUnitAI,	Description, 				Help, 							  Strategy, 							Civilopedia, 					 ShowInPedia, OneShotTourism, OneShotTourismPercentOthers, AdvancedStartCost, WorkRate, ObsoleteTech, MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, Mechanized, CombatLimit,  GoldenAgeTurns,  XPValueAttack, XPValueDefense, Conscription, MoveRate, UnitArtInfo, 				UnitFlagAtlas, 				UnitFlagIconOffset, IconAtlas,				PortraitIndex)
SELECT	'UNIT_JFD_UPARAJA',	Class, CombatClass, PrereqTech, Cost, Combat, RangedCombat, Range, FaithCost, RequiresFaithPurchaseEnabled, Moves, CivilianAttackPriority, Special, Domain, DefaultUnitAI,	'TXT_KEY_UNIT_JFD_UPARAJA',	'TXT_KEY_UNIT_JFD_UPARAJA_HELP',  'TXT_KEY_UNIT_JFD_UPARAJA_STRATEGY',  'TXT_KEY_UNIT_JFD_UPARAJA_TEXT', ShowInPedia, OneShotTourism, OneShotTourismPercentOthers, AdvancedStartCost, WorkRate, ObsoleteTech, MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, Mechanized, CombatLimit,  GoldenAgeTurns,  XPValueAttack, XPValueDefense, Conscription, MoveRate, 'ART_DEF_UNIT_JFD_UPARAJA',	'JFD_LAOS_UNIT_FLAG_ATLAS',	0,					'JFD_LAOS_ICON_ATLAS',	3
FROM Units WHERE Type = 'UNIT_GREAT_GENERAL';      

INSERT INTO Units 	
		(Type, 							Class,	CombatClass, PrereqTech, Cost,  Combat, RangedCombat, Range, FaithCost, RequiresFaithPurchaseEnabled, Moves, CivilianAttackPriority, Special, Domain, DefaultUnitAI, Description, 							Help, 										Strategy, 										Civilopedia, 								ShowInPedia, OneShotTourism, OneShotTourismPercentOthers, AdvancedStartCost, WorkRate, ObsoleteTech, MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, Mechanized, CombatLimit,  GoldenAgeTurns,  XPValueAttack, XPValueDefense, Conscription, MoveRate, UnitArtInfo, 						UnitFlagAtlas, 				UnitFlagIconOffset, IconAtlas,				PortraitIndex)
SELECT	'UNIT_JFD_UPARAJA_ELEPHANT',	Class,	CombatClass, PrereqTech, -1,	Combat, RangedCombat, Range, FaithCost, RequiresFaithPurchaseEnabled, Moves, CivilianAttackPriority, Special, Domain, DefaultUnitAI, 'TXT_KEY_UNIT_JFD_UPARAJA_ELEPHANT',	'TXT_KEY_UNIT_JFD_UPARAJA_ELEPHANT_HELP', 	'TXT_KEY_UNIT_JFD_UPARAJA_ELEPHANT_STRATEGY',   'TXT_KEY_UNIT_JFD_UPARAJA_ELEPHANT_TEXT',	0,			 OneShotTourism, OneShotTourismPercentOthers, AdvancedStartCost, WorkRate, ObsoleteTech, MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, Mechanized, CombatLimit,  GoldenAgeTurns,  XPValueAttack, XPValueDefense, Conscription, MoveRate, 'ART_DEF_UNIT_JFD_UPARAJA_ELEPHANT',	'JFD_LAOS_UNIT_FLAG_ATLAS',	1,					'JFD_LAOS_ICON_ATLAS',	5
FROM Units WHERE Type = 'UNIT_SIAMESE_WARELEPHANT';   
--------------------------------------------------------------------------------------------------------------------------
-- UnitGameplay2DScripts
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 				SelectionSound, FirstSelectionSound)
SELECT	'UNIT_JFD_UPARAJA',		SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_GREAT_GENERAL';

INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 						SelectionSound, FirstSelectionSound)
SELECT	'UNIT_JFD_UPARAJA_ELEPHANT',	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_SIAMESE_WARELEPHANT';
--------------------------------------------------------------------------------------------------------------------------
-- Unit_AITypes
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_AITypes 	
		(UnitType, 				UnitAIType)
SELECT	'UNIT_JFD_UPARAJA',		UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_GREAT_GENERAL';

INSERT INTO Unit_AITypes 	
		(UnitType, 						UnitAIType)
SELECT	'UNIT_JFD_UPARAJA_ELEPHANT',	UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_SIAMESE_WARELEPHANT';
--------------------------------------------------------------------------------------------------------------------------
-- Unit_Builds
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_Builds 	
		(UnitType, 				BuildType)
SELECT	'UNIT_JFD_UPARAJA', 	BuildType
FROM Unit_Builds WHERE UnitType = 'UNIT_GREAT_GENERAL';
--------------------------------------------------------------------------------------------------------------------------
-- Unit_Flavors
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_Flavors 	
		(UnitType, 				FlavorType, Flavor)
SELECT	'UNIT_JFD_UPARAJA',		FlavorType, Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_GREAT_GENERAL';

INSERT INTO Unit_Flavors 	
		(UnitType, 						FlavorType, Flavor)
SELECT	'UNIT_JFD_UPARAJA_ELEPHANT',	FlavorType, Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_SIAMESE_WARELEPHANT';
--------------------------------------------------------------------------------------------------------------------------
-- Unit_ResourceQuantityRequirements
--------------------------------------------------------------------------------------------------------------------------
--INSERT INTO Unit_ResourceQuantityRequirements
--		(UnitType, 						ResourceType, Cost)
--SELECT	'UNIT_JFD_UPARAJA_ELEPHANT',		ResourceType, Cost
--FROM Unit_ResourceQuantityRequirements WHERE UnitType = 'UNIT_SIAMESE_WARELEPHANT';
--------------------------------------------------------------------------------------------------------------------------
-- Unit_FreePromotions
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_FreePromotions 	
		(UnitType, 				PromotionType)
SELECT	'UNIT_JFD_UPARAJA',		PromotionType
FROM Unit_FreePromotions WHERE UnitType = 'UNIT_GREAT_GENERAL';

INSERT INTO Unit_FreePromotions 	
		(UnitType, 						PromotionType)
SELECT	'UNIT_JFD_UPARAJA_ELEPHANT',	PromotionType
FROM Unit_FreePromotions WHERE UnitType = 'UNIT_SIAMESE_WARELEPHANT';

INSERT INTO Unit_FreePromotions
		(UnitType,						PromotionType)
VALUES	('UNIT_JFD_UPARAJA_ELEPHANT',	'PROMOTION_JFD_UPARAJA_ELEPHANT');
--------------------------------------------------------------------------------------------------------------------------
-- Unit_ClassUpgrades
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 				UnitClassType)
SELECT	'UNIT_JFD_UPARAJA',		UnitClassType
FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_GREAT_GENERAL';

INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 						UnitClassType)
SELECT	'UNIT_JFD_UPARAJA_ELEPHANT',	UnitClassType
FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_SIAMESE_WARELEPHANT';
--------------------------------------------------------------------------------------------------------------------------
-- Unit_UniqueNames
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_UniqueNames 
		(UnitType, 				UniqueName)
VALUES	('UNIT_JFD_UPARAJA', 	'TXT_KEY_GREAT_PERSON_JFD_UPARAJA_1'),
		('UNIT_JFD_UPARAJA', 	'TXT_KEY_GREAT_PERSON_JFD_UPARAJA_2'),
		('UNIT_JFD_UPARAJA', 	'TXT_KEY_GREAT_PERSON_JFD_UPARAJA_3'),
		('UNIT_JFD_UPARAJA', 	'TXT_KEY_GREAT_PERSON_JFD_UPARAJA_4'),
		('UNIT_JFD_UPARAJA', 	'TXT_KEY_GREAT_PERSON_JFD_UPARAJA_5'),
		('UNIT_JFD_UPARAJA', 	'TXT_KEY_GREAT_PERSON_JFD_UPARAJA_6'),
		('UNIT_JFD_UPARAJA', 	'TXT_KEY_GREAT_PERSON_JFD_UPARAJA_7'),
		('UNIT_JFD_UPARAJA', 	'TXT_KEY_GREAT_PERSON_JFD_UPARAJA_8'),
		('UNIT_JFD_UPARAJA', 	'TXT_KEY_GREAT_PERSON_JFD_UPARAJA_9'),
		('UNIT_JFD_UPARAJA', 	'TXT_KEY_GREAT_PERSON_JFD_UPARAJA_10'),
		('UNIT_JFD_UPARAJA', 	'TXT_KEY_GREAT_PERSON_JFD_UPARAJA_11'),
		('UNIT_JFD_UPARAJA', 	'TXT_KEY_GREAT_PERSON_JFD_UPARAJA_12'),
		('UNIT_JFD_UPARAJA', 	'TXT_KEY_GREAT_PERSON_JFD_UPARAJA_13'),
		('UNIT_JFD_UPARAJA', 	'TXT_KEY_GREAT_PERSON_JFD_UPARAJA_14'),
		('UNIT_JFD_UPARAJA', 	'TXT_KEY_GREAT_PERSON_JFD_UPARAJA_15'),
		('UNIT_JFD_UPARAJA', 	'TXT_KEY_GREAT_PERSON_JFD_UPARAJA_16'),
		('UNIT_JFD_UPARAJA', 	'TXT_KEY_GREAT_PERSON_JFD_UPARAJA_17'),
		('UNIT_JFD_UPARAJA', 	'TXT_KEY_GREAT_PERSON_JFD_UPARAJA_18'),
		('UNIT_JFD_UPARAJA', 	'TXT_KEY_GREAT_PERSON_JFD_UPARAJA_19'),
		('UNIT_JFD_UPARAJA', 	'TXT_KEY_GREAT_PERSON_JFD_UPARAJA_20');
--==========================================================================================================================	
-- LEADERS
--==========================================================================================================================	
------------------------------------------------------------------------------------------------------------------------
-- Leaders
--------------------------------------------------------------------------------------------------------------------------			
INSERT INTO Leaders 
		(Type, 					Description, 					Civilopedia, 					CivilopediaTag, 						 ArtDefineTag, 			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 				PortraitIndex)
VALUES	('LEADER_JFD_LAOS', 	'TXT_KEY_LEADER_JFD_LAOS',	'TXT_KEY_LEADER_JFD_LAOS_PEDIA',	'TXT_KEY_CIVILOPEDIA_LEADERS_JFD_LAOS',  'JFD_Laos_Scene.xml',  7, 						6, 						4, 							6, 			5, 				5, 				5, 						6, 				6, 			4, 			5, 				5, 			4, 			'JFD_LAOS_ICON_ATLAS', 	1);
--------------------------------------------------------------------------------------------------------------------------		
-- Leader_MajorCivApproachBiases
--------------------------------------------------------------------------------------------------------------------------						
INSERT INTO Leader_MajorCivApproachBiases 
		(LeaderType, 			MajorCivApproachType, 				Bias)
VALUES	('LEADER_JFD_LAOS', 	'MAJOR_CIV_APPROACH_WAR', 			8),
		('LEADER_JFD_LAOS', 	'MAJOR_CIV_APPROACH_HOSTILE', 		6),
		('LEADER_JFD_LAOS', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	2),
		('LEADER_JFD_LAOS', 	'MAJOR_CIV_APPROACH_GUARDED', 		3),
		('LEADER_JFD_LAOS', 	'MAJOR_CIV_APPROACH_AFRAID', 		4),
		('LEADER_JFD_LAOS', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		5),
		('LEADER_JFD_LAOS', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		5);
--------------------------------------------------------------------------------------------------------------------------	
-- Leader_MajorCivApproachBiases
--------------------------------------------------------------------------------------------------------------------------							
INSERT INTO Leader_MinorCivApproachBiases 
		(LeaderType, 			MinorCivApproachType, 				Bias)
VALUES	('LEADER_JFD_LAOS', 	'MINOR_CIV_APPROACH_IGNORE', 		4),
		('LEADER_JFD_LAOS', 	'MINOR_CIV_APPROACH_FRIENDLY', 		5),
		('LEADER_JFD_LAOS', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	5),
		('LEADER_JFD_LAOS', 	'MINOR_CIV_APPROACH_CONQUEST', 		9),
		('LEADER_JFD_LAOS', 	'MINOR_CIV_APPROACH_BULLY', 		5);
--------------------------------------------------------------------------------------------------------------------------	
-- Leader_Flavors
--------------------------------------------------------------------------------------------------------------------------							
INSERT INTO Leader_Flavors 
		(LeaderType, 			FlavorType, 						Flavor)
VALUES	('LEADER_JFD_LAOS', 	'FLAVOR_OFFENSE', 					7),
		('LEADER_JFD_LAOS', 	'FLAVOR_DEFENSE', 					5),
		('LEADER_JFD_LAOS', 	'FLAVOR_CITY_DEFENSE', 				5),
		('LEADER_JFD_LAOS', 	'FLAVOR_MILITARY_TRAINING', 		7),
		('LEADER_JFD_LAOS', 	'FLAVOR_RECON', 					5),
		('LEADER_JFD_LAOS', 	'FLAVOR_RANGED', 					4),
		('LEADER_JFD_LAOS', 	'FLAVOR_MOBILE', 					5),
		('LEADER_JFD_LAOS', 	'FLAVOR_NAVAL', 					5),
		('LEADER_JFD_LAOS', 	'FLAVOR_NAVAL_RECON', 				5),
		('LEADER_JFD_LAOS', 	'FLAVOR_NAVAL_GROWTH', 				5),
		('LEADER_JFD_LAOS', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
		('LEADER_JFD_LAOS', 	'FLAVOR_AIR', 						5),
		('LEADER_JFD_LAOS', 	'FLAVOR_EXPANSION', 				8),
		('LEADER_JFD_LAOS', 	'FLAVOR_GROWTH', 					8),
		('LEADER_JFD_LAOS', 	'FLAVOR_TILE_IMPROVEMENT', 			5),
		('LEADER_JFD_LAOS', 	'FLAVOR_INFRASTRUCTURE', 			5),
		('LEADER_JFD_LAOS', 	'FLAVOR_PRODUCTION', 				5),
		('LEADER_JFD_LAOS', 	'FLAVOR_GOLD', 						5),
		('LEADER_JFD_LAOS', 	'FLAVOR_SCIENCE', 					5),
		('LEADER_JFD_LAOS', 	'FLAVOR_CULTURE', 					5),
		('LEADER_JFD_LAOS', 	'FLAVOR_HAPPINESS', 				8),
		('LEADER_JFD_LAOS', 	'FLAVOR_GREAT_PEOPLE', 				6),
		('LEADER_JFD_LAOS', 	'FLAVOR_WONDER', 					5),
		('LEADER_JFD_LAOS', 	'FLAVOR_RELIGION', 					7),
		('LEADER_JFD_LAOS', 	'FLAVOR_DIPLOMACY', 				4),
		('LEADER_JFD_LAOS', 	'FLAVOR_SPACESHIP', 				2),
		('LEADER_JFD_LAOS', 	'FLAVOR_WATER_CONNECTION', 			5),
		('LEADER_JFD_LAOS', 	'FLAVOR_NUKE', 						2),
		('LEADER_JFD_LAOS', 	'FLAVOR_USE_NUKE', 					2),
		('LEADER_JFD_LAOS', 	'FLAVOR_ESPIONAGE', 				5),
		('LEADER_JFD_LAOS', 	'FLAVOR_AIRLIFT', 					5),
		('LEADER_JFD_LAOS', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
		('LEADER_JFD_LAOS', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
		('LEADER_JFD_LAOS', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
		('LEADER_JFD_LAOS', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
		('LEADER_JFD_LAOS', 	'FLAVOR_ARCHAEOLOGY', 				5),
		('LEADER_JFD_LAOS', 	'FLAVOR_AIR_CARRIER', 				5);
--------------------------------------------------------------------------------------------------------------------------	
-- Leader_Traits
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Leader_Traits 
		(LeaderType, 			TraitType)
VALUES	('LEADER_JFD_LAOS', 	'TRAIT_JFD_LAOS');
--==========================================================================================================================	
-- TRAITS
--==========================================================================================================================	
------------------------------------------------------------------------------------------------------------------------
-- Traits
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Traits 
		(Type, 				Description, 				ShortDescription)
VALUES	('TRAIT_JFD_LAOS', 	'TXT_KEY_TRAIT_JFD_LAOS',	'TXT_KEY_TRAIT_JFD_LAOS_SHORT');
------------------------------------------------------------------------------------------------------------------------	
-- Buildings
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Buildings 		
		(Type, 							BuildingClass,				GreatWorkCount,	Cost, FaithCost, PrereqTech, Description,							Help, 										NeverCapture)
VALUES	('BUILDING_JFD_LAOS_GROWTH',	'BUILDINGCLASS_JFD_LAOS',	-1,				-1,   -1,		 null,		 'TXT_KEY_BUILDING_JFD_LAOS_GROWTH',	'TXT_KEY_BUILDING_JFD_LAOS_GROWTH_HELP',	1);
--------------------------------------------------------------------------------------------------------------------------
-- Building_YieldModifiers
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Building_YieldModifiers 		
		(BuildingType, 					YieldType,		Yield)
VALUES	('BUILDING_JFD_LAOS_GROWTH',	'YIELD_FOOD',	1);
--==========================================================================================================================	
-- DIPLOMACY
--==========================================================================================================================	
------------------------------------------------------------------------------------------------------------------------
-- Diplomacy_Responses
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Diplomacy_Responses																												 
		(LeaderType, 			ResponseType, 								Response, 												 Bias)
VALUES 	('LEADER_JFD_LAOS', 	'RESPONSE_AI_DOF_BACKSTAB', 				'TXT_KEY_LEADER_JFD_LAOS_DENOUNCE_FRIEND%', 			 500),
		('LEADER_JFD_LAOS', 	'RESPONSE_ATTACKED_HOSTILE', 				'TXT_KEY_LEADER_JFD_LAOS_ATTACKED_HOSTILE%', 			 500),
		('LEADER_JFD_LAOS', 	'RESPONSE_DEFEATED', 						'TXT_KEY_LEADER_JFD_LAOS_DEFEATED%', 					 500),
		('LEADER_JFD_LAOS', 	'RESPONSE_DOW_GENERIC', 					'TXT_KEY_LEADER_JFD_LAOS_DOW_GENERIC%', 				 500),
		('LEADER_JFD_LAOS', 	'RESPONSE_FIRST_GREETING', 					'TXT_KEY_LEADER_JFD_LAOS_FIRSTGREETING%', 				 500),
		('LEADER_JFD_LAOS', 	'RESPONSE_RESPONSE_TO_BEING_DENOUNCED', 	'TXT_KEY_LEADER_JFD_LAOS_RESPONSE_TO_BEING_DENOUNCED%',  500),
		('LEADER_JFD_LAOS', 	'RESPONSE_WORK_AGAINST_SOMEONE', 			'TXT_KEY_LEADER_JFD_LAOS_DENOUNCE%', 					 500),
		('LEADER_JFD_LAOS', 	'RESPONSE_WORK_WITH_US', 					'TXT_KEY_LEADER_JFD_LAOS_DEC_FRIENDSHIP%', 				 500);
--==========================================================================================================================	
-- CIVILIZATIONS
--==========================================================================================================================	
------------------------------------------------------------------------------------------------------------------------
-- Civilizations
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilizations 	
		(Type, 						Description,					ShortDescription,					Adjective,							Civilopedia, 					 CivilopediaTag, 			DefaultPlayerColor,		 ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas,				PortraitIndex,	AlphaIconAtlas,			SoundtrackTag,  MapImage, 				 DawnOfManQuote, 					DawnOfManImage)
SELECT	'CIVILIZATION_JFD_LAOS',	'TXT_KEY_CIV_JFD_LAOS_DESC',	'TXT_KEY_CIV_JFD_LAOS_SHORT_DESC',	'TXT_KEY_CIV_JFD_LAOS_ADJECTIVE',	'TXT_KEY_CIV5_JFD_LAOS_TEXT_1',  'TXT_KEY_CIV5_JFD_LAOS',	'PLAYERCOLOR_JFD_LAOS',	 ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, 'JFD_LAOS_ICON_ATLAS',	0,				'JFD_LAOS_ALPHA_ATLAS',	'Siam', 		'JFD_MapLaos512.dds',	 'TXT_KEY_CIV5_DAWN_JFD_LAOS_TEXT',	'JFD_DOM_Laos.dds'
FROM Civilizations WHERE Type = 'CIVILIZATION_SIAM';
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_CityNames
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Civilization_CityNames 
		(CivilizationType, 			CityName)
VALUES	('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_CITY_NAME_JFD_LAOS_01'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_CITY_NAME_JFD_LAOS_02'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_CITY_NAME_JFD_LAOS_03'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_CITY_NAME_JFD_LAOS_04'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_CITY_NAME_JFD_LAOS_05'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_CITY_NAME_JFD_LAOS_06'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_CITY_NAME_JFD_LAOS_07'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_CITY_NAME_JFD_LAOS_08'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_CITY_NAME_JFD_LAOS_09'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_CITY_NAME_JFD_LAOS_10'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_CITY_NAME_JFD_LAOS_11'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_CITY_NAME_JFD_LAOS_12'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_CITY_NAME_JFD_LAOS_13'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_CITY_NAME_JFD_LAOS_14'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_CITY_NAME_JFD_LAOS_15'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_CITY_NAME_JFD_LAOS_16'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_CITY_NAME_JFD_LAOS_17'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_CITY_NAME_JFD_LAOS_18'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_CITY_NAME_JFD_LAOS_19'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_CITY_NAME_JFD_LAOS_20'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_CITY_NAME_JFD_LAOS_21'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_CITY_NAME_JFD_LAOS_22'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_CITY_NAME_JFD_LAOS_23'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_CITY_NAME_JFD_LAOS_24'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_CITY_NAME_JFD_LAOS_25'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_CITY_NAME_JFD_LAOS_26'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_CITY_NAME_JFD_LAOS_27'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_CITY_NAME_JFD_LAOS_28'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_CITY_NAME_JFD_LAOS_29'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_CITY_NAME_JFD_LAOS_30'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_CITY_NAME_JFD_LAOS_31'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_CITY_NAME_JFD_LAOS_32'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_CITY_NAME_JFD_LAOS_33'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_CITY_NAME_JFD_LAOS_34'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_CITY_NAME_JFD_LAOS_35');
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_FreeBuildingClasses
--------------------------------------------------------------------------------------------------------------------------			
INSERT INTO Civilization_FreeBuildingClasses 
		(CivilizationType, 			BuildingClassType)
SELECT	'CIVILIZATION_JFD_LAOS', 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE CivilizationType = 'CIVILIZATION_RUSSIA';
--------------------------------------------------------------------------------------------------------------------------		
-- Civilization_FreeTechs
--------------------------------------------------------------------------------------------------------------------------			
INSERT INTO Civilization_FreeTechs 
		(CivilizationType, 			TechType)
SELECT	'CIVILIZATION_JFD_LAOS', 	TechType
FROM Civilization_FreeTechs WHERE CivilizationType = 'CIVILIZATION_RUSSIA';
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_FreeUnits
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_FreeUnits 
		(CivilizationType, 			UnitClassType, Count, UnitAIType)
SELECT	'CIVILIZATION_JFD_LAOS', 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE CivilizationType = 'CIVILIZATION_RUSSIA';
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_Leaders
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_Leaders 
		(CivilizationType, 			LeaderheadType)
VALUES	('CIVILIZATION_JFD_LAOS',	'LEADER_JFD_LAOS');
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_BuildingClassOverrides 
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 			BuildingClassType, 		 BuildingType)
VALUES	('CIVILIZATION_JFD_LAOS', 	'BUILDINGCLASS_SHRINE',	 'BUILDING_JFD_THART');
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_UnitClassOverrides 
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_UnitClassOverrides 
		(CivilizationType, 			UnitClassType, 				 UnitType)
VALUES  ('CIVILIZATION_JFD_LAOS', 	'UNITCLASS_GREAT_GENERAL',	 'UNIT_JFD_UPARAJA');
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_Religions
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_Religions 
		(CivilizationType, 			ReligionType)
VALUES	('CIVILIZATION_JFD_LAOS',	'RELIGION_BUDDHISM');	
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_SpyNames
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_SpyNames 
		(CivilizationType, 			SpyName)
VALUES	('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_SPY_NAME_JFD_LAOS_0'),	
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_SPY_NAME_JFD_LAOS_1'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_SPY_NAME_JFD_LAOS_2'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_SPY_NAME_JFD_LAOS_3'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_SPY_NAME_JFD_LAOS_4'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_SPY_NAME_JFD_LAOS_5'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_SPY_NAME_JFD_LAOS_6'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_SPY_NAME_JFD_LAOS_7'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_SPY_NAME_JFD_LAOS_8'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_SPY_NAME_JFD_LAOS_9'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_SPY_NAME_JFD_LAOS_10'),
		('CIVILIZATION_JFD_LAOS', 	'TXT_KEY_SPY_NAME_JFD_LAOS_11');
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_Start_Region_Priority
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_Start_Region_Priority 
		(CivilizationType, 			RegionType)
VALUES	('CIVILIZATION_JFD_LAOS',	'REGION_JUNGLE');	
--==========================================================================================================================
--==========================================================================================================================
