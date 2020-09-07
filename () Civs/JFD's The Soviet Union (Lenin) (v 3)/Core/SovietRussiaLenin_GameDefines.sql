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
		(Type, 								BuildingClass, PrereqTech, Cost, SpecialistType, SpecialistCount, FaithCost, UnlockedByBelief, GoldMaintenance, MinAreaSize, ConquestProb, NeverCapture, 	Description, 								Help, 											Strategy,											Civilopedia, 									ArtDefineTag, PortraitIndex, IconAtlas)
SELECT	'BUILDING_JFD_PIONEERS_PALACE',		BuildingClass, PrereqTech, Cost, SpecialistType, SpecialistCount, FaithCost, UnlockedByBelief, GoldMaintenance, MinAreaSize, ConquestProb, 1, 				'TXT_KEY_BUILDING_JFD_PIONEERS_PALACE', 	'TXT_KEY_BUILDING_JFD_PIONEERS_PALACE_HELP',	'TXT_KEY_BUILDING_JFD_PIONEERS_PALACE_STRATEGY',	'TXT_KEY_BUILDING_JFD_PIONEERS_PALACE_TEXT',  	ArtDefineTag, 3, 			 'JFD_SOVIET_RUSSIA_LENIN_ICON_ATLAS'
FROM Buildings WHERE Type = 'BUILDING_PUBLIC_SCHOOL';

UPDATE Buildings
SET GoldMaintenance = GoldMaintenance+1
WHERE Type = 'BUILDING_JFD_PIONEERS_PALACE';
------------------------------------------------------------------------------------------------------------------------	
-- Building_ClassesNeededInCity
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Building_ClassesNeededInCity 	
		(BuildingType, 						BuildingClassType)
SELECT	'BUILDING_JFD_PIONEERS_PALACE',		BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_PUBLIC_SCHOOL';	
------------------------------------------------------------------------------------------------------------------------	
-- Building_Flavors
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Building_Flavors 	
		(BuildingType, 						FlavorType, Flavor)
SELECT	'BUILDING_JFD_PIONEERS_PALACE',		FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_PUBLIC_SCHOOL';

INSERT INTO Building_Flavors 	
		(BuildingType, 						FlavorType,		  	 Flavor)
VALUES	('BUILDING_JFD_PIONEERS_PALACE', 	'FLAVOR_EXPANSION',  50);
------------------------------------------------------------------------------------------------------------------------	
-- Building_YieldChanges
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Building_YieldChanges 	 
		(BuildingType, 						YieldType, Yield)
SELECT	'BUILDING_JFD_PIONEERS_PALACE',	 	YieldType, Yield
FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_PUBLIC_SCHOOL';
------------------------------------------------------------------------------------------------------------------------	
-- Building_YieldChangesPerPop
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Building_YieldChangesPerPop 	
		(BuildingType, 						YieldType, Yield)
SELECT	'BUILDING_JFD_PIONEERS_PALACE', 	YieldType, Yield
FROM Building_YieldChangesPerPop WHERE BuildingType = 'BUILDING_PUBLIC_SCHOOL';	
------------------------------------------------------------------------------------------------------------------------
-- BuildingClasses
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO BuildingClasses
		(Type, 										DefaultBuilding, 					   Description)
VALUES	('BUILDINGCLASS_DUMMY_JFD_PIONEERS_PALACE', 'BUILDING_DUMMY_JFD_PIONEERS_PALACE',  'TXT_KEY_BUILDING_DUMMY_JFD_PIONEERS_PALACE');
--------------------------------------------------------------------------------------------------------------------------
-- Buildings
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Buildings 	
		(Type, 						 			BuildingClass, 								GreatWorkCount, Cost, FaithCost, PrereqTech, NeverCapture,	Description, 									 Help)
VALUES	('BUILDING_DUMMY_JFD_PIONEERS_PALACE', 	'BUILDINGCLASS_DUMMY_JFD_PIONEERS_PALACE', 	-1, 			-1,   -1, 		 null, 		 1,				'TXT_KEY_BUILDING_DUMMY_JFD_PIONEERS_PALACE',	 'TXT_KEY_BUILDING_DUMMY_JFD_PIONEERS_PALACE_HELP');
------------------------------------------------------------------------------------------------------------------------	
-- Building_YieldChanges
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Building_YieldChanges 
		(BuildingType, 							YieldType,			Yield)
VALUES	('BUILDING_DUMMY_JFD_PIONEERS_PALACE',	'YIELD_SCIENCE',  	1);
------------------------------------------------------------------------------------------------------------------------	
-- Building_CityToolTipYieldFromOther
------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Building_CityToolTipYieldFromOther(BuildingType, YieldType, Yield integer);
INSERT INTO Building_CityToolTipYieldFromOther
		(BuildingType, 							YieldType,			Yield)
VALUES	('BUILDING_DUMMY_JFD_PIONEERS_PALACE',	'YIELD_SCIENCE',  	1);
--==========================================================================================================================
-- UNITS
--==========================================================================================================================
------------------------------------------------------------------------------------------------------------------------
-- UnitPromotions
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO UnitPromotions 
		(Type, 							LostWithUpgrade, Description, 							 Help, 										 Sound, 			 CannotBeChosen, PortraitIndex, IconAtlas, 		 PediaType, 		 PediaEntry)
VALUES	('PROMOTION_JFD_POPULAR_LEVY', 	0,				 'TXT_KEY_PROMOTION_JFD_POPULAR_LEVY',	 'TXT_KEY_PROMOTION_JFD_POPULAR_LEVY_HELP',  'AS2D_IF_LEVELUP',  1, 			 59, 			'ABILITY_ATLAS', 'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_POPULAR_LEVY');

UPDATE UnitPromotions
SET EnemyRoute = 1
WHERE Type = 'PROMOTION_JFD_POPULAR_LEVY';
------------------------------------------------------------------------------------------------------------------------	
-- Units
------------------------------------------------------------------------------------------------------------------------
INSERT INTO Units 	
		(Type, 						Class, PrereqTech, Combat, Cost, FaithCost, RequiresFaithPurchaseEnabled, Moves, CombatClass, Domain, DefaultUnitAI, MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, IgnoreBuildingDefense, GoodyHutUpgradeUnitClass, AdvancedStartCost, XPValueAttack, XPValueDefense, Description, 						Help, 									 Strategy, 									Civilopedia, 							UnitArtInfo, 						UnitFlagAtlas,								UnitFlagIconOffset,	IconAtlas,								PortraitIndex)
SELECT	'UNIT_JFD_POPULAR_LEVY',	Class, PrereqTech, Combat, Cost, FaithCost, RequiresFaithPurchaseEnabled, Moves, CombatClass, Domain, DefaultUnitAI, MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, IgnoreBuildingDefense, GoodyHutUpgradeUnitClass, AdvancedStartCost, XPValueAttack, XPValueDefense, 'TXT_KEY_UNIT_JFD_POPULAR_LEVY',	'TXT_KEY_UNIT_JFD_POPULAR_LEVY_HELP', 	 'TXT_KEY_UNIT_JFD_POPULAR_LEVY_STRATEGY',  'TXT_KEY_UNIT_JFD_POPULAR_LEVY_TEXT',	'ART_DEF_UNIT_JFD_POPULAR_LEVY',	'JFD_SOVIET_RUSSIA_LENIN_UNIT_FLAG_ATLAS',  0,					'JFD_SOVIET_RUSSIA_LENIN_ICON_ATLAS',	2
FROM Units WHERE Type = 'UNIT_GREAT_WAR_INFANTRY';	

UPDATE Units
SET Combat = Combat-2, Cost = Cost-50, FaithCost = FaithCost-100
WHERE Type = 'UNIT_JFD_POPULAR_LEVY';
------------------------------------------------------------------------------------------------------------------------
-- Unit_AITypes
------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_AITypes 	
		(UnitType, 					UnitAIType)
SELECT	'UNIT_JFD_POPULAR_LEVY', 	UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_GREAT_WAR_INFANTRY';
------------------------------------------------------------------------------------------------------------------------
-- Unit_ClassUpgrades
------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 					UnitClassType)
SELECT	'UNIT_JFD_POPULAR_LEVY', 	UnitClassType
FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_GREAT_WAR_INFANTRY';
------------------------------------------------------------------------------------------------------------------------
-- Unit_Flavors
------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_Flavors 	
		(UnitType, 					FlavorType, Flavor)
SELECT	'UNIT_JFD_POPULAR_LEVY', 	FlavorType, Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_GREAT_WAR_INFANTRY';
------------------------------------------------------------------------------------------------------------------------
-- Unit_FreePromotions
------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_FreePromotions 	
		(UnitType, 					PromotionType)
SELECT	'UNIT_JFD_POPULAR_LEVY', 	PromotionType
FROM Unit_FreePromotions WHERE UnitType = 'UNIT_GREAT_WAR_INFANTRY';

INSERT INTO Unit_FreePromotions 	
		(UnitType, 					PromotionType)
VALUES	('UNIT_JFD_POPULAR_LEVY',	'PROMOTION_JFD_POPULAR_LEVY');
------------------------------------------------------------------------------------------------------------------------
-- UnitGameplay2DScripts
------------------------------------------------------------------------------------------------------------------------
INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT	'UNIT_JFD_POPULAR_LEVY', 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_GREAT_WAR_INFANTRY';			
--==========================================================================================================================	
-- LEADERS
--==========================================================================================================================	
------------------------------------------------------------------------------------------------------------------------
-- Leaders
------------------------------------------------------------------------------------------------------------------------			
INSERT INTO Leaders 
		(Type, 								Description, 								Civilopedia, 									CivilopediaTag, 										ArtDefineTag, 						IconAtlas, 								PortraitIndex)
VALUES	('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'TXT_KEY_LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'TXT_KEY_LEADER_JFD_SOVIET_RUSSIA_LENIN_PEDIA', 'TXT_KEY_CIVILOPEDIA_LEADERS_JFD_SOVIET_RUSSIA_LENIN', 	'JFD_SovietRussiaLenin_Scene.xml',	'JFD_SOVIET_RUSSIA_LENIN_ICON_ATLAS', 	1);

UPDATE Leaders
SET VictoryCompetitiveness = 4,
WonderCompetitiveness = 3,
MinorCivCompetitiveness = 6,
Boldness = 7,
DiploBalance = 5,
WarmongerHate = 8,
DenounceWillingness = 7,
DoFWillingness = 2,
Loyalty = 2,
Neediness = 6,
Forgiveness = 2,
Chattiness = 3,
Meanness = 2
WHERE Type = 'LEADER_JFD_SOVIET_RUSSIA_LENIN';	
------------------------------------------------------------------------------------------------------------------------		
-- Leader_MajorCivApproachBiases
------------------------------------------------------------------------------------------------------------------------						
INSERT INTO Leader_MajorCivApproachBiases 
		(LeaderType, 						MajorCivApproachType, 				Bias)
VALUES	('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'MAJOR_CIV_APPROACH_WAR', 			3),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'MAJOR_CIV_APPROACH_HOSTILE', 		4),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	8),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'MAJOR_CIV_APPROACH_GUARDED', 		8),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'MAJOR_CIV_APPROACH_AFRAID', 		4),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		4),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		3);
------------------------------------------------------------------------------------------------------------------------	
-- Leader_MajorCivApproachBiases
------------------------------------------------------------------------------------------------------------------------							
INSERT INTO Leader_MinorCivApproachBiases 
		(LeaderType, 						MinorCivApproachType, 				Bias)
VALUES	('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'MINOR_CIV_APPROACH_IGNORE', 		3),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'MINOR_CIV_APPROACH_FRIENDLY', 		4),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	8),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'MINOR_CIV_APPROACH_CONQUEST', 		3),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'MINOR_CIV_APPROACH_BULLY', 		4);
------------------------------------------------------------------------------------------------------------------------	
-- Leader_Flavors
------------------------------------------------------------------------------------------------------------------------						
INSERT INTO Leader_Flavors 
		(LeaderType, 						FlavorType, 						Flavor)
VALUES	('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'FLAVOR_OFFENSE', 					5),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'FLAVOR_DEFENSE', 					5),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'FLAVOR_CITY_DEFENSE', 				4),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'FLAVOR_MILITARY_TRAINING', 		5),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'FLAVOR_RECON', 					4),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'FLAVOR_RANGED', 					4),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'FLAVOR_MOBILE', 					3),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'FLAVOR_NAVAL', 					3),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'FLAVOR_NAVAL_RECON', 				2),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'FLAVOR_NAVAL_GROWTH', 				2),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	2),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'FLAVOR_AIR', 						4),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'FLAVOR_EXPANSION', 				4),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'FLAVOR_GROWTH', 					8),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'FLAVOR_TILE_IMPROVEMENT', 			7),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'FLAVOR_INFRASTRUCTURE', 			7),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'FLAVOR_PRODUCTION', 				7),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'FLAVOR_GOLD', 						3),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'FLAVOR_SCIENCE', 					3),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'FLAVOR_CULTURE', 					4),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'FLAVOR_HAPPINESS', 				6),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'FLAVOR_GREAT_PEOPLE', 				2),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'FLAVOR_WONDER', 					2),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'FLAVOR_RELIGION', 					0),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'FLAVOR_DIPLOMACY', 				2),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'FLAVOR_SPACESHIP', 				4),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'FLAVOR_WATER_CONNECTION', 			3),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'FLAVOR_NUKE', 						2),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'FLAVOR_USE_NUKE', 					2),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'FLAVOR_ESPIONAGE', 				6),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'FLAVOR_AIRLIFT', 					1),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'FLAVOR_ARCHAEOLOGY', 				5),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'FLAVOR_AIR_CARRIER', 				5);
--------------------------------------------------------------------------------------------------------------------------
-- Diplomacy_Responses
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Diplomacy_Responses
		(LeaderType, 						ResponseType, 							 			Response, 																	 	Bias)
VALUES 	('LEADER_JFD_SOVIET_RUSSIA_LENIN',	'RESPONSE_AI_DOF_BACKSTAB', 			 			'TXT_KEY_LEADER_JFD_SOVIET_RUSSIA_LENIN_DENOUNCE_FRIEND%', 			 			500),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN',	'RESPONSE_ATTACKED_HOSTILE', 			 			'TXT_KEY_LEADER_JFD_SOVIET_RUSSIA_LENIN_ATTACKED_HOSTILE%', 			 		500),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN',	'RESPONSE_DEFEATED', 					 			'TXT_KEY_LEADER_JFD_SOVIET_RUSSIA_LENIN_DEFEATED%', 					 		500),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN',	'RESPONSE_DOW_GENERIC', 				 			'TXT_KEY_LEADER_JFD_SOVIET_RUSSIA_LENIN_DOW_GENERIC%', 				 			500),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN',	'RESPONSE_EXPANSION_SERIOUS_WARNING', 				'TXT_KEY_LEADER_JFD_SOVIET_RUSSIA_LENIN_EXPANSION_SERIOUS_WARNING%', 	 		500),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN',	'RESPONSE_FIRST_GREETING', 				 			'TXT_KEY_LEADER_JFD_SOVIET_RUSSIA_LENIN_FIRSTGREETING%', 				 		500),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN',	'RESPONSE_GREETING_HOSTILE_HELLO', 					'TXT_KEY_LEADER_JFD_SOVIET_RUSSIA_LENIN_GREETING_HOSTILE_HELLO%', 		 		500),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN',	'RESPONSE_GREETING_NEUTRAL_HELLO', 					'TXT_KEY_LEADER_JFD_SOVIET_RUSSIA_LENIN_GREETING_NEUTRAL_HELLO%', 		 		500),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN',	'RESPONSE_GREETING_POLITE_HELLO', 					'TXT_KEY_LEADER_JFD_SOVIET_RUSSIA_LENIN_GREETING_POLITE_HELLO%', 		 		500),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN',	'RESPONSE_HOSTILE_AGGRESSIVE_MILITARY_WARNING', 	'TXT_KEY_LEADER_JFD_SOVIET_RUSSIA_LENIN_HOSTILE_AGGRESSIVE_MILITARY_WARNING%', 	500),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN',	'RESPONSE_LUXURY_TRADE', 							'TXT_KEY_LEADER_JFD_SOVIET_RUSSIA_LENIN_LUXURY_TRADE%', 		  				500),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN',	'RESPONSE_OPEN_BORDERS_EXCHANGE', 					'TXT_KEY_LEADER_JFD_SOVIET_RUSSIA_LENIN_OPEN_BORDERS_EXCHANGE%', 		  		500),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN',	'RESPONSE_REQUEST', 								'TXT_KEY_LEADER_JFD_SOVIET_RUSSIA_LENIN_REQUEST%', 		  						500),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN',	'RESPONSE_TOO_SOON_NO_PEACE', 			 			'TXT_KEY_LEADER_JFD_SOVIET_RUSSIA_LENIN_TOO_SOON_NO_PEACE%', 			  		500),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN',	'RESPONSE_RESPONSE_TO_BEING_DENOUNCED',  			'TXT_KEY_LEADER_JFD_SOVIET_RUSSIA_LENIN_RESPONSE_TO_BEING_DENOUNCED%',   		500),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN',	'RESPONSE_WINWAR', 		 							'TXT_KEY_LEADER_JFD_SOVIET_RUSSIA_LENIN_WINWAR%', 					  			500),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN',	'RESPONSE_WORK_AGAINST_SOMEONE', 		 			'TXT_KEY_LEADER_JFD_SOVIET_RUSSIA_LENIN_DENOUNCE%', 					  		500),
		('LEADER_JFD_SOVIET_RUSSIA_LENIN',	'RESPONSE_WORK_WITH_US', 				 			'TXT_KEY_LEADER_JFD_SOVIET_RUSSIA_LENIN_DEC_FRIENDSHIP%', 			  	  		500);
------------------------------------------------------------------------------------------------------------------------	
-- Leader_Traits
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Leader_Traits 
		(LeaderType, 						TraitType)
VALUES	('LEADER_JFD_SOVIET_RUSSIA_LENIN', 	'TRAIT_JFD_SOVIET_RUSSIA_LENIN');
------------------------------------------------------------------------------------------------------------------------
-- Traits
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Traits 
		(Type, 								Description, 								ShortDescription)
VALUES	('TRAIT_JFD_SOVIET_RUSSIA_LENIN',	'TXT_KEY_TRAIT_JFD_SOVIET_RUSSIA_LENIN',	'TXT_KEY_TRAIT_JFD_SOVIET_RUSSIA_LENIN_SHORT');	
------------------------------------------------------------------------------------------------------------------------
-- Buildings
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Buildings 	
		(Type, 											BuildingClass, Cost, Flat, XBuiltTriggersIdeologyChoice, Happiness, BuildingProductionModifier, GoldMaintenance, PrereqTech, SpecialistCount, SpecialistType, Description,	Help, Strategy, Civilopedia, ArtDefineTag, MinAreaSize, ConquestProb, FreeStartEra, HurryCostModifier, PortraitIndex, IconAtlas)
SELECT	'BUILDING_JFD_SOVIET_RUSSIA_LENIN_' || Type,	BuildingClass, Cost, Flat, XBuiltTriggersIdeologyChoice, Happiness, BuildingProductionModifier, GoldMaintenance, PrereqTech, SpecialistCount, SpecialistType, Description,	Help, Strategy, Civilopedia, ArtDefineTag, MinAreaSize, ConquestProb, FreeStartEra, HurryCostModifier, PortraitIndex, IconAtlas
FROM Buildings WHERE Type IN ('BUILDING_STONE_WORKS', 'BUILDING_FORGE', 'BUILDING_WINDMILL', 'BUILDING_FACTORY');	
------------------------------------------------------------------------------------------------------------------------	
-- Building_ClassesNeededInCity
------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Building_ClassesNeededInCity 	
		(BuildingType, 											BuildingClassType)
SELECT	'BUILDING_JFD_SOVIET_RUSSIA_LENIN_' || BuildingType,	BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType IN ('BUILDING_STONE_WORKS', 'BUILDING_FORGE', 'BUILDING_WINDMILL', 'BUILDING_FACTORY');	
------------------------------------------------------------------------------------------------------------------------	
-- Building_DomainProductionModifiers
------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Building_DomainProductionModifiers 	
		(BuildingType, 											DomainType, Modifier)
SELECT	'BUILDING_JFD_SOVIET_RUSSIA_LENIN_' || BuildingType,	DomainType, Modifier
FROM Building_DomainProductionModifiers WHERE BuildingType IN ('BUILDING_STONE_WORKS', 'BUILDING_FORGE', 'BUILDING_WINDMILL', 'BUILDING_FACTORY');	
------------------------------------------------------------------------------------------------------------------------	
-- Building_Flavors
------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Building_Flavors 	
		(BuildingType, 											FlavorType, Flavor)
SELECT	'BUILDING_JFD_SOVIET_RUSSIA_LENIN_' || BuildingType,	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType IN ('BUILDING_STONE_WORKS', 'BUILDING_FORGE', 'BUILDING_WINDMILL', 'BUILDING_FACTORY');	
------------------------------------------------------------------------------------------------------------------------	
-- Building_ResourceYieldChanges
------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Building_ResourceYieldChanges 	
		(BuildingType, 											ResourceType, YieldType, Yield)
SELECT	'BUILDING_JFD_SOVIET_RUSSIA_LENIN_' || BuildingType,	ResourceType, YieldType, Yield
FROM Building_ResourceYieldChanges WHERE BuildingType IN ('BUILDING_STONE_WORKS', 'BUILDING_FORGE', 'BUILDING_WINDMILL', 'BUILDING_FACTORY');	
------------------------------------------------------------------------------------------------------------------------	
-- Building_YieldChanges
------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Building_YieldChanges 	
		(BuildingType, 											YieldType, Yield)
SELECT	'BUILDING_JFD_SOVIET_RUSSIA_LENIN_' || BuildingType,	YieldType, Yield
FROM Building_YieldChanges WHERE BuildingType IN ('BUILDING_STONE_WORKS', 'BUILDING_FORGE', 'BUILDING_WINDMILL', 'BUILDING_FACTORY');	
------------------------------------------------------------------------------------------------------------------------	
-- Building_YieldModifiers
------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Building_YieldModifiers 	
		(BuildingType, 											YieldType, Yield)
SELECT	'BUILDING_JFD_SOVIET_RUSSIA_LENIN_' || BuildingType,	YieldType, Yield
FROM Building_YieldModifiers WHERE BuildingType IN ('BUILDING_STONE_WORKS', 'BUILDING_FORGE', 'BUILDING_WINDMILL', 'BUILDING_FACTORY');	
------------------------------------------------------------------------------------------------------------------------
-- JFD_Civilopedia_HideFromPedia
------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS JFD_Civilopedia_HideFromPedia(Type text);
INSERT INTO JFD_Civilopedia_HideFromPedia
		(Type)
VALUES	('BUILDING_JFD_SOVIET_RUSSIA_LENIN_BUILDING_FACTORY'),
		('BUILDING_JFD_SOVIET_RUSSIA_LENIN_BUILDING_FORGE'),
		('BUILDING_JFD_SOVIET_RUSSIA_LENIN_BUILDING_STONE_WORKS'),
		('BUILDING_JFD_SOVIET_RUSSIA_LENIN_BUILDING_WINDMILL');
--==========================================================================================================================	
-- CIVILIZATIONS
--==========================================================================================================================	
------------------------------------------------------------------------------------------------------------------------
-- Civilizations
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Civilizations 	
		(Type, 										DerivativeCiv,					SoundtrackTag,  MapImage, 							DawnOfManQuote, 									DawnOfManImage,						Description,									ShortDescription,									Adjective,											Civilopedia,									CivilopediaTag,							DefaultPlayerColor,						ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas,								PortraitIndex,	AlphaIconAtlas)
SELECT	'CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN',		'TXT_KEY_JFD_TAL_SOVIET_UNION',	'Russia', 		'JFD_MapSovietRussiaLenin512.dds',	'TXT_KEY_CIV_DAWN_JFD_SOVIET_RUSSIA_LENIN_TEXT',	'JFD_DOM_SovietRussiaLenin.dds',	'TXT_KEY_CIV_JFD_SOVIET_RUSSIA_LENIN_DESC',		'TXT_KEY_CIV_JFD_SOVIET_RUSSIA_LENIN_SHORT_DESC',	'TXT_KEY_CIV_JFD_SOVIET_RUSSIA_LENIN_ADJECTIVE',	'TXT_KEY_CIV_JFD_SOVIET_RUSSIA_LENIN_TEXT_1',	'TXT_KEY_CIV_JFD_SOVIET_RUSSIA_LENIN',	'PLAYERCOLOR_JFD_SOVIET_RUSSIA_LENIN',	ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, 'JFD_SOVIET_RUSSIA_LENIN_ICON_ATLAS',	0,				'JFD_SOVIET_RUSSIA_LENIN_ALPHA_ATLAS'
FROM Civilizations WHERE Type = 'CIVILIZATION_RUSSIA';
------------------------------------------------------------------------------------------------------------------------	
-- Civilization_CityNames
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Civilization_CityNames
		(CivilizationType, 							CityName)
VALUES	('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'TXT_KEY_CITY_NAME_JFD_SOVIET_RUSSIA_LENIN_1'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'TXT_KEY_CITY_NAME_MOSCOW'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'TXT_KEY_CITY_NAME_JFD_SOVIET_RUSSIA_LENIN_2'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'TXT_KEY_CITY_NAME_JFD_SOVIET_RUSSIA_LENIN_3'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'TXT_KEY_CITY_NAME_JFD_SOVIET_RUSSIA_LENIN_4'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'TXT_KEY_CITY_NAME_JFD_SOVIET_RUSSIA_LENIN_5'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'TXT_KEY_CITY_NAME_JFD_SOVIET_RUSSIA_LENIN_6'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'TXT_KEY_CITY_NAME_JFD_SOVIET_RUSSIA_LENIN_7'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'TXT_KEY_CITY_NAME_JFD_SOVIET_RUSSIA_LENIN_8'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'TXT_KEY_CITY_NAME_JFD_SOVIET_RUSSIA_LENIN_9'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'TXT_KEY_CITY_NAME_JFD_SOVIET_RUSSIA_LENIN_10'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'TXT_KEY_CITY_NAME_JFD_SOVIET_RUSSIA_LENIN_11'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'TXT_KEY_CITY_NAME_JFD_SOVIET_RUSSIA_LENIN_12'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'TXT_KEY_CITY_NAME_JFD_SOVIET_RUSSIA_LENIN_13'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'TXT_KEY_CITY_NAME_JFD_SOVIET_RUSSIA_LENIN_14'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'TXT_KEY_CITY_NAME_JFD_SOVIET_RUSSIA_LENIN_15'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'TXT_KEY_CITY_NAME_JFD_SOVIET_RUSSIA_LENIN_16'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'TXT_KEY_CITY_NAME_JFD_SOVIET_RUSSIA_LENIN_17'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'TXT_KEY_CITY_NAME_JFD_SOVIET_RUSSIA_LENIN_18'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'TXT_KEY_CITY_NAME_JFD_SOVIET_RUSSIA_LENIN_19'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'TXT_KEY_CITY_NAME_JFD_SOVIET_RUSSIA_LENIN_20'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'TXT_KEY_CITY_NAME_JFD_SOVIET_RUSSIA_LENIN_21'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'TXT_KEY_CITY_NAME_JFD_SOVIET_RUSSIA_LENIN_22'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'TXT_KEY_CITY_NAME_JFD_SOVIET_RUSSIA_LENIN_23'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'TXT_KEY_CITY_NAME_JFD_SOVIET_RUSSIA_LENIN_24'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'TXT_KEY_CITY_NAME_JFD_SOVIET_RUSSIA_LENIN_25'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'TXT_KEY_CITY_NAME_JFD_SOVIET_RUSSIA_LENIN_26'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'TXT_KEY_CITY_NAME_JFD_SOVIET_RUSSIA_LENIN_27'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'TXT_KEY_CITY_NAME_JFD_SOVIET_RUSSIA_LENIN_28'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'TXT_KEY_CITY_NAME_JFD_SOVIET_RUSSIA_LENIN_29'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'TXT_KEY_CITY_NAME_JFD_SOVIET_RUSSIA_LENIN_30'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'TXT_KEY_CITY_NAME_JFD_SOVIET_RUSSIA_LENIN_31'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'TXT_KEY_CITY_NAME_JFD_SOVIET_RUSSIA_LENIN_32'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'TXT_KEY_CITY_NAME_JFD_SOVIET_RUSSIA_LENIN_33'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'TXT_KEY_CITY_NAME_JFD_SOVIET_RUSSIA_LENIN_34'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'TXT_KEY_CITY_NAME_JFD_SOVIET_RUSSIA_LENIN_35'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'TXT_KEY_CITY_NAME_JFD_SOVIET_RUSSIA_LENIN_36'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'TXT_KEY_CITY_NAME_JFD_SOVIET_RUSSIA_LENIN_37'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'TXT_KEY_CITY_NAME_JFD_SOVIET_RUSSIA_LENIN_38');
------------------------------------------------------------------------------------------------------------------------	
-- Civilization_FreeBuildingClasses
------------------------------------------------------------------------------------------------------------------------			
INSERT INTO Civilization_FreeBuildingClasses 
		(CivilizationType, 							BuildingClassType)
SELECT	'CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN',		BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE CivilizationType = 'CIVILIZATION_RUSSIA';
------------------------------------------------------------------------------------------------------------------------	
-- Civilization_FreeTechs
------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_FreeTechs 
		(CivilizationType, 							TechType)
SELECT	'CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN',		TechType
FROM Civilization_FreeTechs WHERE CivilizationType = 'CIVILIZATION_RUSSIA';
------------------------------------------------------------------------------------------------------------------------	
-- Civilization_FreeUnits
------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_FreeUnits	
		(CivilizationType, 							UnitClassType, Count, UnitAIType)
SELECT	'CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN',		UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE CivilizationType = 'CIVILIZATION_RUSSIA';
------------------------------------------------------------------------------------------------------------------------	
-- Civilization_Leaders
------------------------------------------------------------------------------------------------------------------------			
INSERT INTO Civilization_Leaders 
		(CivilizationType, 							LeaderheadType)
VALUES	('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN',	'LEADER_JFD_SOVIET_RUSSIA_LENIN');
------------------------------------------------------------------------------------------------------------------------	
-- Civilization_UnitClassOverrides 
------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_UnitClassOverrides 
		(CivilizationType, 							UnitClassType, 						UnitType)
VALUES	('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN',	'UNITCLASS_GREAT_WAR_INFANTRY',		'UNIT_JFD_POPULAR_LEVY');
------------------------------------------------------------------------------------------------------------------------	
-- Civilization_BuildingClassOverrides
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 							BuildingClassType, 					BuildingType)
VALUES	('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN',	'BUILDINGCLASS_PUBLIC_SCHOOL',		'BUILDING_JFD_PIONEERS_PALACE');

INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 							BuildingClassType, 					BuildingType)
VALUES	('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'BUILDINGCLASS_FACTORY',			'BUILDING_JFD_SOVIET_RUSSIA_LENIN_BUILDING_FACTORY'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'BUILDINGCLASS_FORGE',				'BUILDING_JFD_SOVIET_RUSSIA_LENIN_BUILDING_FORGE'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'BUILDINGCLASS_STONE_WORKS',		'BUILDING_JFD_SOVIET_RUSSIA_LENIN_BUILDING_STONE_WORKS'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'BUILDINGCLASS_WINDMILL',			'BUILDING_JFD_SOVIET_RUSSIA_LENIN_BUILDING_WINDMILL');
--------------------------------------------------------------------------------------------------------------------------
-- Civilization_Religions
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Civilization_Religions 
		(CivilizationType, 							ReligionType)
VALUES	('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN', 	'RELIGION_ORTHODOXY');
------------------------------------------------------------------------------------------------------------------------	
-- Civilization_SpyNames
------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_SpyNames 
		(CivilizationType, 							SpyName)
VALUES	('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN',	'TXT_KEY_SPY_NAME_JFD_SOVIET_RUSSIA_LENIN_0'),	
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN',	'TXT_KEY_SPY_NAME_JFD_SOVIET_RUSSIA_LENIN_1'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN',	'TXT_KEY_SPY_NAME_JFD_SOVIET_RUSSIA_LENIN_2'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN',	'TXT_KEY_SPY_NAME_JFD_SOVIET_RUSSIA_LENIN_3'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN',	'TXT_KEY_SPY_NAME_JFD_SOVIET_RUSSIA_LENIN_4'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN',	'TXT_KEY_SPY_NAME_JFD_SOVIET_RUSSIA_LENIN_5'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN',	'TXT_KEY_SPY_NAME_JFD_SOVIET_RUSSIA_LENIN_6'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN',	'TXT_KEY_SPY_NAME_JFD_SOVIET_RUSSIA_LENIN_7'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN',	'TXT_KEY_SPY_NAME_JFD_SOVIET_RUSSIA_LENIN_8'),
		('CIVILIZATION_JFD_SOVIET_RUSSIA_LENIN',	'TXT_KEY_SPY_NAME_JFD_SOVIET_RUSSIA_LENIN_9');
--==========================================================================================================================
--==========================================================================================================================