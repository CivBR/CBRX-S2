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
		(Type, 						  DefaultBuilding, 		  Description)
VALUES	('BUILDINGCLASS_JFD_PUNJAB',  'BUILDING_JFD_PUNJAB',  'TXT_KEY_BUILDING_JFD_PUNJAB');
--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================		
-- Buildings
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Buildings 																																		 																																							 
		(Type, 						BuildingClass, TrainedFreePromotion,		 ExtraCityHitPoints, Defense, Cost, FaithCost, SpecialistType, SpecialistCount, UnlockedByBelief, GoldMaintenance,  FreeStartEra, PrereqTech, Description,						 Help, 									Strategy, 									Civilopedia, 						ArtDefineTag, MinAreaSize, HurryCostModifier, IconAtlas,				ConquestProb, PortraitIndex)
SELECT	'BUILDING_JFD_PHAUNDARI',	BuildingClass, 'PROMOTION_GENERAL_STACKING', ExtraCityHitPoints, Defense, Cost, FaithCost, SpecialistType, SpecialistCount, UnlockedByBelief, GoldMaintenance,  FreeStartEra, PrereqTech, 'TXT_KEY_BUILDING_JFD_PHAUNDARI', 'TXT_KEY_BUILDING_HELP_JFD_PHAUNDARI', 'TXT_KEY_BUILDING_JFD_PHAUNDARI_STRATEGY',  'TXT_KEY_CIV5_JFD_PHAUNDARI_TEXT',  ArtDefineTag, MinAreaSize, HurryCostModifier, 'JFD_PUNJAB_ICON_ATLAS',	ConquestProb, 3
FROM Buildings WHERE Type = 'BUILDING_ARSENAL';
--------------------------------------------------------------------------------------------------------------------------		
-- Building_ClassesNeededInCity
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Building_ClassesNeededInCity
		(BuildingType, 				BuildingClassType)
SELECT	'BUILDING_JFD_PHAUNDARI',	BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_ARSENAL';		
------------------------------------------------------------------------------------------------------------------------
-- Building_YieldChanges
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Building_YieldChanges 	
		(BuildingType, 				YieldType,	Yield)
SELECT	'BUILDING_JFD_PHAUNDARI',	YieldType,	Yield
FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_ARSENAL';			
---------------------------------------------------------------------------------------------------------- --------------
-- Building_YieldModifiers
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Building_YieldModifiers
		(BuildingType, 				YieldType,	Yield)
SELECT	'BUILDING_JFD_PHAUNDARI',	YieldType,	Yield
FROM Building_YieldModifiers WHERE BuildingType = 'BUILDING_ARSENAL';	
--------------------------------------------------------------------------------------------------------------------------	
-- Building_DomainProductionModifiers
--------------------------------------------------------------------------------------------------------------------------			
INSERT INTO Building_UnitCombatProductionModifiers 
		(BuildingType, 				UnitCombatType,		 Modifier)
VALUES	('BUILDING_JFD_PHAUNDARI',	'UNITCOMBAT_SIEGE',	 15);
--------------------------------------------------------------------------------------------------------------------------	
-- Building_Flavors
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Building_Flavors 
		(BuildingType, 				FlavorType,	 Flavor)
SELECT	'BUILDING_JFD_PHAUNDARI', 	FlavorType,	 Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_ARSENAL';	

INSERT INTO Building_Flavors 
		(BuildingType, 				FlavorType, 				 Flavor)
VALUES	('BUILDING_JFD_PHAUNDARI',	'FLAVOR_MILITARY_TRAINING',	 20),
		('BUILDING_JFD_PHAUNDARI',	'FLAVOR_PRODUCTION',		 15);
--------------------------------------------------------------------------------------------------------------------------	
-- UnitPromotions_UnitCombats
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO UnitPromotions_UnitCombats 
		(PromotionType, 				UnitCombatType)
VALUES	('PROMOTION_GENERAL_STACKING',	'UNITCOMBAT_SIEGE');
--==========================================================================================================================	
-- UNITS
--==========================================================================================================================	
--------------------------------------------------------------------------------------------------------------------------
-- Units
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Units 	
		(Type, 				Class,	PrereqTech,	Combat,	Range,	RangedCombat, FaithCost, RequiresFaithPurchaseEnabled, Cost, Moves, CombatClass, Domain, DefaultUnitAI, Description, 				 Strategy, 							 Help, 							Civilopedia, 					 MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, XPValueAttack, XPValueDefense, Conscription, UnitArtInfo, 				UnitFlagAtlas, 					UnitFlagIconOffset,		IconAtlas,					PortraitIndex)
SELECT	'UNIT_JFD_AKALI', 	Class,	PrereqTech, Combat, 1,		Combat,		  Cost,		 RequiresFaithPurchaseEnabled, Cost, Moves, CombatClass, Domain, DefaultUnitAI, 'TXT_KEY_UNIT_JFD_AKALI',	 'TXT_KEY_UNIT_JFD_AKALI_STRATEGY',  'TXT_KEY_UNIT_JFD_AKALI_HELP',	'TXT_KEY_CIV5_JFD_AKALI_TEXT',	 MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, XPValueAttack, XPValueDefense, Conscription, 'ART_DEF_UNIT_JFD_AKALI',	'JFD_PUNJAB_UNIT_FLAG_ATLAS',	0,						'JFD_PUNJAB_ICON_ATLAS',		2
FROM Units WHERE Type = 'UNIT_RIFLEMAN';
--------------------------------------------------------------------------------------------------------------------------
-- UnitGameplay2DScripts
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 			SelectionSound, FirstSelectionSound)
SELECT	'UNIT_JFD_AKALI', 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_RIFLEMAN';	
--------------------------------------------------------------------------------------------------------------------------
-- Unit_AITypes
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_AITypes 	
		(UnitType, 			UnitAIType)
SELECT	'UNIT_JFD_AKALI', 	UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_RIFLEMAN';
--------------------------------------------------------------------------------------------------------------------------
-- Unit_Flavors
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_Flavors 	
		(UnitType, 			FlavorType, Flavor)
SELECT	'UNIT_JFD_AKALI', 	FlavorType, Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_RIFLEMAN';
--------------------------------------------------------------------------------------------------------------------------
-- Unit_FreePromotions
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_FreePromotions 	
		(UnitType, 			PromotionType)
SELECT	'UNIT_JFD_AKALI', 	PromotionType
FROM Unit_FreePromotions WHERE UnitType = 'UNIT_RIFLEMAN';
--------------------------------------------------------------------------------------------------------------------------
-- Unit_ClassUpgrades
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 			UnitClassType)
SELECT	'UNIT_JFD_AKALI',	UnitClassType
FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_RIFLEMAN';
--==========================================================================================================================	
-- DIPLOMACY
--==========================================================================================================================	
------------------------------------------------------------------------------------------------------------------------
-- Diplomacy_Responses
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Diplomacy_Responses
		(LeaderType, 				  ResponseType, 									Response, 																	Bias)
VALUES 	('LEADER_JFD_RANJIT_SINGH',   'RESPONSE_AI_DOF_BACKSTAB', 						'TXT_KEY_LEADER_JFD_RANJIT_SINGH_DENOUNCE%', 								500),
		('LEADER_JFD_RANJIT_SINGH',   'RESPONSE_ATTACKED_EXCITED', 						'TXT_KEY_LEADER_JFD_RANJIT_SINGH_ATTACKED_EXCITED%', 						500),
		('LEADER_JFD_RANJIT_SINGH',   'RESPONSE_ATTACKED_HOSTILE', 						'TXT_KEY_LEADER_JFD_RANJIT_SINGH_ATTACKED_HOSTILE%', 						500),
		('LEADER_JFD_RANJIT_SINGH',   'RESPONSE_ATTACKED_SAD', 							'TXT_KEY_LEADER_JFD_RANJIT_SINGH_ATTACKED_SAD%', 							500),
		('LEADER_JFD_RANJIT_SINGH',   'RESPONSE_ATTACKED_STRONG_HOSTILE', 				'TXT_KEY_LEADER_JFD_RANJIT_SINGH_ATTACKED_HOSTILE%', 						500),
		('LEADER_JFD_RANJIT_SINGH',   'RESPONSE_ATTACKED_WEAK_HOSTILE', 				'TXT_KEY_LEADER_JFD_RANJIT_SINGH_ATTACKED_HOSTILE%', 						500),
		('LEADER_JFD_RANJIT_SINGH',   'RESPONSE_DEFEATED', 								'TXT_KEY_LEADER_JFD_RANJIT_SINGH_DEFEATED%', 								500),
		('LEADER_JFD_RANJIT_SINGH',   'RESPONSE_DONT_SETTLE_NO', 						'TXT_KEY_LEADER_JFD_RANJIT_SINGH_DONT_SETTLE_NO%', 							500),
		('LEADER_JFD_RANJIT_SINGH',   'RESPONSE_DONT_SETTLE_YES', 						'TXT_KEY_LEADER_JFD_RANJIT_SINGH_DONT_SETTLE_YES%', 						500),
		('LEADER_JFD_RANJIT_SINGH',   'RESPONSE_DOW_GENERIC', 							'TXT_KEY_LEADER_JFD_RANJIT_SINGH_DOW_GENERIC%', 							500),
		('LEADER_JFD_RANJIT_SINGH',   'RESPONSE_DOW_LAND', 								'TXT_KEY_LEADER_JFD_RANJIT_SINGH_DOW_LAND%', 								500),
		('LEADER_JFD_RANJIT_SINGH',   'RESPONSE_DOW_WORLD_CONQUEST', 					'TXT_KEY_LEADER_JFD_RANJIT_SINGH_DOW_WORLD_CONQUEST%', 						500),
		('LEADER_JFD_RANJIT_SINGH',   'RESPONSE_EMBASSY_EXCHANGE', 						'TXT_KEY_LEADER_JFD_RANJIT_SINGH_EMBASSY_EXCHANGE%', 						500),
		('LEADER_JFD_RANJIT_SINGH',   'RESPONSE_EXPANSION_SERIOUS_WARNING', 			'TXT_KEY_LEADER_JFD_RANJIT_SINGH_EXPANSION_SERIOUS_WARNING%', 				500),
		('LEADER_JFD_RANJIT_SINGH',   'RESPONSE_FIRST_GREETING', 						'TXT_KEY_LEADER_JFD_RANJIT_SINGH_FIRSTGREETING%', 							500),
		('LEADER_JFD_RANJIT_SINGH',   'RESPONSE_GREETING_AT_WAR_HOSTILE', 				'TXT_KEY_LEADER_JFD_RANJIT_SINGH_GREETING_AT_WAR_HOSTILE%', 				500),
		('LEADER_JFD_RANJIT_SINGH',   'RESPONSE_GREETING_POLITE_HELLO', 				'TXT_KEY_LEADER_JFD_RANJIT_SINGH_GREETING_POLITE_HELLO%', 					500),
		('LEADER_JFD_RANJIT_SINGH',   'RESPONSE_GREETING_NEUTRAL_HELLO', 				'TXT_KEY_LEADER_JFD_RANJIT_SINGH_GREETING_NEUTRAL_HELLO%', 					500),
		('LEADER_JFD_RANJIT_SINGH',   'RESPONSE_GREETING_HOSTILE_HELLO', 				'TXT_KEY_LEADER_JFD_RANJIT_SINGH_GREETING_HOSTILE_HELLO%', 					500),
		('LEADER_JFD_RANJIT_SINGH',   'RESPONSE_HOSTILE_AGGRESSIVE_MILITARY_WARNING',	'TXT_KEY_LEADER_JFD_RANJIT_SINGH_HOSTILE_AGGRESSIVE_MILITARY_WARNING%',		500),
		('LEADER_JFD_RANJIT_SINGH',   'RESPONSE_INFLUENTIAL_ON_AI', 					'TXT_KEY_LEADER_JFD_RANJIT_SINGH_INFLUENTIAL_ON_AI%', 						500),
		('LEADER_JFD_RANJIT_SINGH',   'RESPONSE_INFLUENTIAL_ON_HUMAN', 					'TXT_KEY_LEADER_JFD_RANJIT_SINGH_INFLUENTIAL_ON_HUMAN%', 					500),
		('LEADER_JFD_RANJIT_SINGH',   'RESPONSE_LETS_HEAR_IT', 							'TXT_KEY_LEADER_JFD_RANJIT_SINGH_LETS_HEAR_IT%', 							500),
		('LEADER_JFD_RANJIT_SINGH',   'RESPONSE_LUXURY_TRADE', 							'TXT_KEY_LEADER_JFD_RANJIT_SINGH_LUXURY_TRADE%', 							500),
		('LEADER_JFD_RANJIT_SINGH',   'RESPONSE_NO_PEACE', 								'TXT_KEY_LEADER_JFD_RANJIT_SINGH_NO_PEACE%', 								500),
		('LEADER_JFD_RANJIT_SINGH',   'RESPONSE_OPEN_BORDERS_EXCHANGE', 				'TXT_KEY_LEADER_JFD_RANJIT_SINGH_OPEN_BORDERS_EXCHANGE%', 					500),
		('LEADER_JFD_RANJIT_SINGH',   'RESPONSE_PEACE_OFFER', 							'TXT_KEY_LEADER_JFD_RANJIT_SINGH_PEACE_OFFER%', 							500),
		('LEADER_JFD_RANJIT_SINGH',   'RESPONSE_REPEAT_NO', 							'TXT_KEY_LEADER_JFD_RANJIT_SINGH_REPEAT_NO%', 								500),
		('LEADER_JFD_RANJIT_SINGH',   'RESPONSE_REPEAT_TRADE', 							'TXT_KEY_LEADER_JFD_RANJIT_SINGH_REPEAT_TRADE%', 							500),
		('LEADER_JFD_RANJIT_SINGH',   'RESPONSE_REQUEST', 								'TXT_KEY_LEADER_JFD_RANJIT_SINGH_RESPONSE_REQUEST%', 						500),
		('LEADER_JFD_RANJIT_SINGH',   'RESPONSE_RESPONSE_TO_BEING_DENOUNCED', 			'TXT_KEY_LEADER_JFD_RANJIT_SINGH_RESPONSE_TO_BEING_DENOUNCED%', 			500),
		('LEADER_JFD_RANJIT_SINGH',   'RESPONSE_TOO_SOON_FOR_DOF', 						'TXT_KEY_LEADER_JFD_RANJIT_SINGH_TOO_SOON_FOR_DOF%', 						500),
		('LEADER_JFD_RANJIT_SINGH',   'RESPONSE_TOO_SOON_NO_PEACE', 					'TXT_KEY_LEADER_JFD_RANJIT_SINGH_TOO_SOON_NO_PEACE%', 						500),
		('LEADER_JFD_RANJIT_SINGH',   'RESPONSE_WARMONGER', 							'TXT_KEY_LEADER_JFD_RANJIT_SINGH_WARMONGER%', 								500),
		('LEADER_JFD_RANJIT_SINGH',   'RESPONSE_WINNER_PEACE_OFFER', 					'TXT_KEY_LEADER_JFD_RANJIT_SINGH_WINWAR%', 									500),
		('LEADER_JFD_RANJIT_SINGH',   'RESPONSE_WORK_AGAINST_SOMEONE', 					'TXT_KEY_LEADER_JFD_RANJIT_SINGH_DENOUNCE%', 								500),
		('LEADER_JFD_RANJIT_SINGH',   'RESPONSE_WORK_WITH_US', 							'TXT_KEY_LEADER_JFD_RANJIT_SINGH_DEC_FRIENDSHIP%', 							500);
--==========================================================================================================================	
-- TRAITS
--==========================================================================================================================	
------------------------------------------------------------------------------------------------------------------------
-- Traits
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Traits 
		(Type, 				  Description, 					ShortDescription)
VALUES	('TRAIT_JFD_PUNJAB',  'TXT_KEY_TRAIT_JFD_PUNJAB',	'TXT_KEY_TRAIT_JFD_PUNJAB_SHORT');	
--==========================================================================================================================	
-- LEADERS
--==========================================================================================================================	
-- Leaders
------------------------------------------------------------------------------------------------------------------------			
INSERT INTO Leaders 
		(Type, 						Description, 						Civilopedia, 							 CivilopediaTag, 								 ArtDefineTag, 					VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 					PortraitIndex)
VALUES	('LEADER_JFD_RANJIT_SINGH', 'TXT_KEY_LEADER_JFD_RANJIT_SINGH',	'TXT_KEY_LEADER_JFD_RANJIT_SINGH_PEDIA', 'TXT_KEY_CIVILOPEDIA_LEADERS_JFD_RANJIT_SINGH', 'JFD_RanjitSingh_Scene.xml',	8, 						4, 						6, 							7, 			5, 				4, 				6, 						5, 				5, 			5, 			6, 				5, 			5, 			'JFD_PUNJAB_ICON_ATLAS', 	1);
------------------------------------------------------------------------------------------------------------------------		
-- Leader_MajorCivApproachBiases
------------------------------------------------------------------------------------------------------------------------						
INSERT INTO Leader_MajorCivApproachBiases 
		(LeaderType, 				MajorCivApproachType, 				Bias)
VALUES	('LEADER_JFD_RANJIT_SINGH', 'MAJOR_CIV_APPROACH_WAR', 			7),
		('LEADER_JFD_RANJIT_SINGH', 'MAJOR_CIV_APPROACH_HOSTILE', 		4),
		('LEADER_JFD_RANJIT_SINGH', 'MAJOR_CIV_APPROACH_DECEPTIVE', 	6),
		('LEADER_JFD_RANJIT_SINGH', 'MAJOR_CIV_APPROACH_GUARDED', 		6),
		('LEADER_JFD_RANJIT_SINGH', 'MAJOR_CIV_APPROACH_AFRAID', 		4),
		('LEADER_JFD_RANJIT_SINGH', 'MAJOR_CIV_APPROACH_FRIENDLY', 		5),
		('LEADER_JFD_RANJIT_SINGH', 'MAJOR_CIV_APPROACH_NEUTRAL', 		5);
------------------------------------------------------------------------------------------------------------------------	
-- Leader_MajorCivApproachBiases
------------------------------------------------------------------------------------------------------------------------							
INSERT INTO Leader_MinorCivApproachBiases 
		(LeaderType, 				MinorCivApproachType, 				Bias)
VALUES	('LEADER_JFD_RANJIT_SINGH', 'MINOR_CIV_APPROACH_IGNORE', 		4),
		('LEADER_JFD_RANJIT_SINGH', 'MINOR_CIV_APPROACH_FRIENDLY', 		4),
		('LEADER_JFD_RANJIT_SINGH', 'MINOR_CIV_APPROACH_PROTECTIVE', 	7),
		('LEADER_JFD_RANJIT_SINGH', 'MINOR_CIV_APPROACH_CONQUEST', 		6),
		('LEADER_JFD_RANJIT_SINGH', 'MINOR_CIV_APPROACH_BULLY', 		2);
------------------------------------------------------------------------------------------------------------------------	
-- Leader_Flavors
------------------------------------------------------------------------------------------------------------------------							
INSERT INTO Leader_Flavors 
		(LeaderType, 				FlavorType, 						Flavor)
VALUES	('LEADER_JFD_RANJIT_SINGH', 'FLAVOR_OFFENSE', 					6),
		('LEADER_JFD_RANJIT_SINGH', 'FLAVOR_DEFENSE', 					6),
		('LEADER_JFD_RANJIT_SINGH', 'FLAVOR_CITY_DEFENSE', 				4),
		('LEADER_JFD_RANJIT_SINGH', 'FLAVOR_MILITARY_TRAINING', 		7),
		('LEADER_JFD_RANJIT_SINGH', 'FLAVOR_RECON', 					3),
		('LEADER_JFD_RANJIT_SINGH', 'FLAVOR_RANGED', 					6),
		('LEADER_JFD_RANJIT_SINGH', 'FLAVOR_MOBILE', 					3),
		('LEADER_JFD_RANJIT_SINGH', 'FLAVOR_NAVAL', 					2),
		('LEADER_JFD_RANJIT_SINGH', 'FLAVOR_NAVAL_RECON', 				2),
		('LEADER_JFD_RANJIT_SINGH', 'FLAVOR_NAVAL_GROWTH', 				2),
		('LEADER_JFD_RANJIT_SINGH', 'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	2),
		('LEADER_JFD_RANJIT_SINGH', 'FLAVOR_AIR', 						2),
		('LEADER_JFD_RANJIT_SINGH', 'FLAVOR_EXPANSION', 				8),
		('LEADER_JFD_RANJIT_SINGH', 'FLAVOR_GROWTH', 					5),
		('LEADER_JFD_RANJIT_SINGH', 'FLAVOR_TILE_IMPROVEMENT', 			4),
		('LEADER_JFD_RANJIT_SINGH', 'FLAVOR_INFRASTRUCTURE', 			4),
		('LEADER_JFD_RANJIT_SINGH', 'FLAVOR_PRODUCTION', 				6),
		('LEADER_JFD_RANJIT_SINGH', 'FLAVOR_GOLD', 						5),
		('LEADER_JFD_RANJIT_SINGH', 'FLAVOR_SCIENCE', 					4),
		('LEADER_JFD_RANJIT_SINGH', 'FLAVOR_CULTURE', 					6),
		('LEADER_JFD_RANJIT_SINGH', 'FLAVOR_HAPPINESS', 				6),
		('LEADER_JFD_RANJIT_SINGH', 'FLAVOR_GREAT_PEOPLE', 				4),
		('LEADER_JFD_RANJIT_SINGH', 'FLAVOR_WONDER', 					4),
		('LEADER_JFD_RANJIT_SINGH', 'FLAVOR_RELIGION', 					8),
		('LEADER_JFD_RANJIT_SINGH', 'FLAVOR_DIPLOMACY', 				2),
		('LEADER_JFD_RANJIT_SINGH', 'FLAVOR_SPACESHIP', 				2),
		('LEADER_JFD_RANJIT_SINGH', 'FLAVOR_WATER_CONNECTION', 			5),
		('LEADER_JFD_RANJIT_SINGH', 'FLAVOR_NUKE', 						3),
		('LEADER_JFD_RANJIT_SINGH', 'FLAVOR_USE_NUKE', 					2),
		('LEADER_JFD_RANJIT_SINGH', 'FLAVOR_ESPIONAGE', 				2),
		('LEADER_JFD_RANJIT_SINGH', 'FLAVOR_AIRLIFT', 					2),
		('LEADER_JFD_RANJIT_SINGH', 'FLAVOR_I_TRADE_DESTINATION', 		5),
		('LEADER_JFD_RANJIT_SINGH', 'FLAVOR_I_TRADE_ORIGIN', 			5),
		('LEADER_JFD_RANJIT_SINGH', 'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
		('LEADER_JFD_RANJIT_SINGH', 'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
		('LEADER_JFD_RANJIT_SINGH', 'FLAVOR_ARCHAEOLOGY', 				5),
		('LEADER_JFD_RANJIT_SINGH', 'FLAVOR_AIR_CARRIER', 				5);
------------------------------------------------------------------------------------------------------------------------	
-- Leader_Traits
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Leader_Traits 
		(LeaderType, 				TraitType)
VALUES	('LEADER_JFD_RANJIT_SINGH', 'TRAIT_JFD_PUNJAB');
--==========================================================================================================================
-- CIVILIZATIONS
--==========================================================================================================================	
-- Civilizations
------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilizations 	
		(Type, 						DerivativeCiv,	Description,					ShortDescription,						Adjective,								Civilopedia, 						CivilopediaTag, 			DefaultPlayerColor,			ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas,					 PortraitIndex,	AlphaIconAtlas,				SoundtrackTag,  MapImage, 				DawnOfManQuote, 					 DawnOfManImage)
SELECT	'CIVILIZATION_JFD_PUNJAB',	null,			'TXT_KEY_CIV_JFD_PUNJAB_DESC',	'TXT_KEY_CIV_JFD_PUNJAB_SHORT_DESC',	'TXT_KEY_CIV_JFD_PUNJAB_ADJECTIVE',		'TXT_KEY_CIV5_JFD_PUNJAB_TEXT_1', 	'TXT_KEY_CIV5_JFD_PUNJAB',	'PLAYERCOLOR_JFD_PUNJAB',	ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, 'JFD_PUNJAB_ICON_ATLAS',	 0,				'JFD_PUNJAB_ALPHA_ATLAS',	'India', 		'JFD_MapPunjab512.dds',	'TXT_KEY_CIV5_DOM_JFD_PUNJAB_TEXT',  'JFD_DOM_RanjitSingh.dds'
FROM Civilizations WHERE Type = 'CIVILIZATION_INDIA';
------------------------------------------------------------------------------------------------------------------------	
-- Civilization_CityNames
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Civilization_CityNames 
		(CivilizationType, 			CityName)
VALUES	('CIVILIZATION_JFD_PUNJAB', 'TXT_KEY_CITY_NAME_JFD_PUNJAB_01'),
		('CIVILIZATION_JFD_PUNJAB', 'TXT_KEY_CITY_NAME_JFD_PUNJAB_02'),
		('CIVILIZATION_JFD_PUNJAB', 'TXT_KEY_CITY_NAME_JFD_PUNJAB_03'),
		('CIVILIZATION_JFD_PUNJAB', 'TXT_KEY_CITY_NAME_JFD_PUNJAB_04'),
		('CIVILIZATION_JFD_PUNJAB', 'TXT_KEY_CITY_NAME_JFD_PUNJAB_05'),
		('CIVILIZATION_JFD_PUNJAB', 'TXT_KEY_CITY_NAME_JFD_PUNJAB_06'),
		('CIVILIZATION_JFD_PUNJAB', 'TXT_KEY_CITY_NAME_JFD_PUNJAB_07'),
		('CIVILIZATION_JFD_PUNJAB', 'TXT_KEY_CITY_NAME_JFD_PUNJAB_08'),
		('CIVILIZATION_JFD_PUNJAB', 'TXT_KEY_CITY_NAME_JFD_PUNJAB_09'),
		('CIVILIZATION_JFD_PUNJAB', 'TXT_KEY_CITY_NAME_JFD_PUNJAB_10'),
		('CIVILIZATION_JFD_PUNJAB', 'TXT_KEY_CITY_NAME_JFD_PUNJAB_11'),
		('CIVILIZATION_JFD_PUNJAB', 'TXT_KEY_CITY_NAME_JFD_PUNJAB_12'),
		('CIVILIZATION_JFD_PUNJAB', 'TXT_KEY_CITY_NAME_JFD_PUNJAB_13'),
		('CIVILIZATION_JFD_PUNJAB', 'TXT_KEY_CITY_NAME_JFD_PUNJAB_14'),
		('CIVILIZATION_JFD_PUNJAB', 'TXT_KEY_CITY_NAME_JFD_PUNJAB_15'),
		('CIVILIZATION_JFD_PUNJAB', 'TXT_KEY_CITY_NAME_JFD_PUNJAB_16'),
		('CIVILIZATION_JFD_PUNJAB', 'TXT_KEY_CITY_NAME_JFD_PUNJAB_17'),
		('CIVILIZATION_JFD_PUNJAB', 'TXT_KEY_CITY_NAME_JFD_PUNJAB_18'),
		('CIVILIZATION_JFD_PUNJAB', 'TXT_KEY_CITY_NAME_JFD_PUNJAB_19'),
		('CIVILIZATION_JFD_PUNJAB', 'TXT_KEY_CITY_NAME_JFD_PUNJAB_20'),
		('CIVILIZATION_JFD_PUNJAB', 'TXT_KEY_CITY_NAME_JFD_PUNJAB_21'),
		('CIVILIZATION_JFD_PUNJAB', 'TXT_KEY_CITY_NAME_JFD_PUNJAB_22'),
		('CIVILIZATION_JFD_PUNJAB', 'TXT_KEY_CITY_NAME_JFD_PUNJAB_23'),
		('CIVILIZATION_JFD_PUNJAB', 'TXT_KEY_CITY_NAME_JFD_PUNJAB_24'),
		('CIVILIZATION_JFD_PUNJAB', 'TXT_KEY_CITY_NAME_JFD_PUNJAB_25'),
		('CIVILIZATION_JFD_PUNJAB', 'TXT_KEY_CITY_NAME_JFD_PUNJAB_26'),
		('CIVILIZATION_JFD_PUNJAB', 'TXT_KEY_CITY_NAME_JFD_PUNJAB_27'),
		('CIVILIZATION_JFD_PUNJAB', 'TXT_KEY_CITY_NAME_JFD_PUNJAB_28'),
		('CIVILIZATION_JFD_PUNJAB', 'TXT_KEY_CITY_NAME_JFD_PUNJAB_29'),
		('CIVILIZATION_JFD_PUNJAB', 'TXT_KEY_CITY_NAME_JFD_PUNJAB_30');
------------------------------------------------------------------------------------------------------------------------	
-- Civilization_FreeBuildingClasses
------------------------------------------------------------------------------------------------------------------------			
INSERT INTO Civilization_FreeBuildingClasses 
		(CivilizationType, 			BuildingClassType)
SELECT	'CIVILIZATION_JFD_PUNJAB', 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE CivilizationType = 'CIVILIZATION_INDIA';
------------------------------------------------------------------------------------------------------------------------		
-- Civilization_FreeTechs
------------------------------------------------------------------------------------------------------------------------			
INSERT INTO Civilization_FreeTechs 
		(CivilizationType, 			TechType)
SELECT	'CIVILIZATION_JFD_PUNJAB', 	TechType
FROM Civilization_FreeTechs WHERE CivilizationType = 'CIVILIZATION_INDIA';
------------------------------------------------------------------------------------------------------------------------	
-- Civilization_FreeUnits
------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_FreeUnits 
		(CivilizationType, 			UnitClassType, Count, UnitAIType)
SELECT	'CIVILIZATION_JFD_PUNJAB', 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE CivilizationType = 'CIVILIZATION_INDIA';
------------------------------------------------------------------------------------------------------------------------	
-- Civilization_Leaders
------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_Leaders 
		(CivilizationType, 			LeaderheadType)
VALUES	('CIVILIZATION_JFD_PUNJAB',	'LEADER_JFD_RANJIT_SINGH');
------------------------------------------------------------------------------------------------------------------------	
-- Civilization_BuildingClassOverrides 
------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 			BuildingClassType, 		 BuildingType)
VALUES	('CIVILIZATION_JFD_PUNJAB', 'BUILDINGCLASS_ARSENAL', 'BUILDING_JFD_PHAUNDARI');
------------------------------------------------------------------------------------------------------------------------	
-- Civilization_UnitClassOverrides 
------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_UnitClassOverrides 
		(CivilizationType, 			UnitClassType, 		  UnitType)
VALUES	('CIVILIZATION_JFD_PUNJAB', 'UNITCLASS_RIFLEMAN', 'UNIT_JFD_AKALI');
------------------------------------------------------------------------------------------------------------------------	
------------------------------------------------------------------------------------------------------------------------	
-- Civilization_SpyNames
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Civilization_SpyNames 
		(CivilizationType, 			SpyName)
VALUES	('CIVILIZATION_JFD_PUNJAB', 'TXT_KEY_SPY_NAME_JFD_PUNJAB_0'),	
		('CIVILIZATION_JFD_PUNJAB', 'TXT_KEY_SPY_NAME_JFD_PUNJAB_1'),
		('CIVILIZATION_JFD_PUNJAB', 'TXT_KEY_SPY_NAME_JFD_PUNJAB_2'),
		('CIVILIZATION_JFD_PUNJAB', 'TXT_KEY_SPY_NAME_JFD_PUNJAB_3'),
		('CIVILIZATION_JFD_PUNJAB', 'TXT_KEY_SPY_NAME_JFD_PUNJAB_4'),
		('CIVILIZATION_JFD_PUNJAB', 'TXT_KEY_SPY_NAME_JFD_PUNJAB_5'),
		('CIVILIZATION_JFD_PUNJAB', 'TXT_KEY_SPY_NAME_JFD_PUNJAB_6'),
		('CIVILIZATION_JFD_PUNJAB', 'TXT_KEY_SPY_NAME_JFD_PUNJAB_7'),
		('CIVILIZATION_JFD_PUNJAB', 'TXT_KEY_SPY_NAME_JFD_PUNJAB_8'),
		('CIVILIZATION_JFD_PUNJAB', 'TXT_KEY_SPY_NAME_JFD_PUNJAB_9');
--==========================================================================================================================
--==========================================================================================================================
