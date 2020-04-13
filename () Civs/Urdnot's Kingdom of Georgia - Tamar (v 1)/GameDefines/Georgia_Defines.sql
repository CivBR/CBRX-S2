--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================	
-- Buildings
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Buildings
		(Type, 					BuildingClass,	Cost,	 FaithCost,		GreatWorkCount, GoldMaintenance,  PrereqTech,	ExtraCityHitPoints, Defense,	 ArtInfoCulturalVariation,  AllowsRangeStrike,	Description,					Help,									Strategy,								Civilopedia,					ArtDefineTag, MinAreaSize, 	HurryCostModifier, 	IconAtlas,			ConquestProb, 	NeverCapture,	PortraitIndex)
SELECT	'BUILDING_US_TSIKHE',	BuildingClass,	Cost-30, FaithCost-60,  GreatWorkCount, GoldMaintenance,  PrereqTech, 	ExtraCityHitPoints, Defense-300, ArtInfoCulturalVariation,  AllowsRangeStrike,	'TXT_KEY_BUILDING_US_TSIKHE',	'TXT_KEY_BUILDING_US_TSIKHE_HELP',		'TXT_KEY_BUILDING_US_TSIKHE_STRATEGY',	'TXT_KEY_CIV5_JFD_TSIKHE_TEXT',	ArtDefineTag, MinAreaSize, 	HurryCostModifier, 	'US_GEORGIA_ATLAS',	66, 			1,				3	
FROM Buildings WHERE Type = 'BUILDING_CASTLE';		
--------------------------------------------------------------------------------------------------------------------------		
-- Building_ClassesNeededInCity
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Building_ClassesNeededInCity
		(BuildingType, 					BuildingClassType)
SELECT	'BUILDING_US_TSIKHE',			BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_CASTLE';	
--------------------------------------------------------------------------------------------------------------------------		
-- Building_YieldChanges
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Building_YieldChanges
		(BuildingType, 					YieldType,		Yield)
VALUES	('BUILDING_US_TSIKHE',			'YIELD_FAITH', 	1);
--------------------------------------------------------------------------------------------------------------------------		
-- Building_Flavors
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Building_Flavors
		(BuildingType, 					FlavorType,		Flavor)
SELECT	'BUILDING_US_TSIKHE',			FlavorType,		Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_CASTLE';	
--==========================================================================================================================	
-- IMPROVEMENTS
--==========================================================================================================================
-- Improvements
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Improvements
		(Type,							GraphicalOnly,	UpgradeTime,	ImprovementUpgrade,		Description, Civilopedia, ArtDefineTag,	PillageGold, PortraitIndex,	IconAtlas, BuildableOnResources, DefenseModifier, OutsideBorders, DestroyedWhenPillaged)
SELECT	'IMPROVEMENT_US_GEORGIA_FORT',	1,				30,				'IMPROVEMENT_CITADEL',	Description, Civilopedia, ArtDefineTag, PillageGold, PortraitIndex,	IconAtlas, BuildableOnResources, DefenseModifier, OutsideBorders, DestroyedWhenPillaged
FROM Improvements WHERE Type = 'IMPROVEMENT_FORT';
--------------------------------------------------------------------------------------------------------------------------
-- Improvement_Yields
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Improvement_Yields
		(ImprovementType,				YieldType, 		Yield)
SELECT	'IMPROVEMENT_US_GEORGIA_FORT', 	YieldType, 		Yield
FROM Improvement_Yields WHERE ImprovementType = 'IMPROVEMENT_FORT';

INSERT INTO Improvement_Yields
		(ImprovementType,				YieldType,		Yield)
VALUES	('IMPROVEMENT_US_GEORGIA_FORT', 'YIELD_FAITH', 	4);
--------------------------------------------------------------------------------------------------------------------------
-- Improvement_ResourceTypes
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Improvement_ResourceTypes
		(ImprovementType,				ResourceType)
SELECT	'IMPROVEMENT_US_GEORGIA_FORT', 	ResourceType
FROM Improvement_ResourceTypes WHERE ImprovementType = 'IMPROVEMENT_FORT';
--------------------------------------------------------------------------------------------------------------------------
-- Improvement_ResourceType_Yields
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Improvement_ResourceType_Yields
		(ImprovementType,				ResourceType, YieldType, Yield)
SELECT	'IMPROVEMENT_US_GEORGIA_FORT', 	ResourceType, YieldType, Yield
FROM Improvement_ResourceType_Yields WHERE ImprovementType = 'IMPROVEMENT_FORT';
--------------------------------------------------------------------------------------------------------------------------
-- JFD_Civilopedia_HideFromPedia
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS JFD_Civilopedia_HideFromPedia (Type text default null);
INSERT INTO JFD_Civilopedia_HideFromPedia
		(Type)
VALUES	('IMPROVEMENT_US_GEORGIA_FORT');
--==========================================================================================================================	
-- PROMOTIONS
--==========================================================================================================================	
-- UnitPromotions
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO UnitPromotions 
		(Type, 								GreatGeneralModifier,	Description, 						Help, 											Sound, 				CannotBeChosen, LostWithUpgrade, PortraitIndex, 	IconAtlas, 						PediaType, 			PediaEntry)
VALUES	('PROMOTION_US_TADZREULI',			0,						'TXT_KEY_PROMOTION_US_TADZREULI', 	'TXT_KEY_PROMOTION_US_TADZREULI_HELP',			'AS2D_IF_LEVELUP', 	1, 				0, 				 59, 				'ABILITY_ATLAS', 				'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_US_TADZREULI'),
		('PROMOTION_US_TADZREULI_ACTIVE',	100,					'TXT_KEY_PROMOTION_US_TADZREULI',   'TXT_KEY_PROMOTION_US_TADZREULI_ACTIVE_HELP',	'AS2D_IF_LEVELUP', 	1, 				0, 				 0, 				'US_GEORGIA_PROMOTION_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_US_TADZREULI');
--==========================================================================================================================
-- UNITS
--==========================================================================================================================	
-- Units
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Units 	
		(Type, 						Class,	CombatClass, PrereqTech, Cost, Combat,   FaithCost, RequiresFaithPurchaseEnabled, Moves, CivilianAttackPriority, Special, Domain, DefaultUnitAI,	Description, 				 Help, 								Strategy, 								Civilopedia, 						ShowInPedia, OneShotTourism, OneShotTourismPercentOthers, AdvancedStartCost, WorkRate, CombatLimit,  GoldenAgeTurns,  XPValueAttack, XPValueDefense, Conscription, UnitArtInfo, 				 UnitFlagAtlas, 			UnitFlagIconOffset, IconAtlas,			PortraitIndex,	MoveRate)
SELECT	'UNIT_US_TADZREULI',		Class,	CombatClass, PrereqTech, Cost, Combat+3, FaithCost, RequiresFaithPurchaseEnabled, Moves, CivilianAttackPriority, Special, Domain, DefaultUnitAI,	'TXT_KEY_UNIT_US_TADZREULI', 'TXT_KEY_UNIT_US_TADZREULI_HELP',	'TXT_KEY_UNIT_US_TADZREULI_STRATEGY', 	'TXT_KEY_CIV5_JFD_TADZREULI_TEXT',  ShowInPedia, OneShotTourism, OneShotTourismPercentOthers, AdvancedStartCost, WorkRate, CombatLimit,  GoldenAgeTurns,  XPValueAttack, XPValueDefense, Conscription, 'ART_DEF_UNIT_US_TADZREULI',	 'US_GEORGIA_FLAG_ATLAS',	0,					'US_GEORGIA_ATLAS',	2,				MoveRate
FROM Units WHERE Type = 'UNIT_KNIGHT';    
--------------------------------------------------------------------------------------------------------------------------
-- UnitGameplay2DScripts
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT	'UNIT_US_TADZREULI',		SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_KNIGHT';
--------------------------------------------------------------------------------------------------------------------------
-- Unit_AITypes
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_AITypes 	
		(UnitType, 					UnitAIType)
SELECT	'UNIT_US_TADZREULI',		UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_KNIGHT';
--------------------------------------------------------------------------------------------------------------------------
-- Unit_ResourceQuantityRequirements
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_ResourceQuantityRequirements 	
		(UnitType, 					ResourceType, Cost)
SELECT	'UNIT_US_TADZREULI',		ResourceType, Cost
FROM Unit_ResourceQuantityRequirements WHERE UnitType = 'UNIT_KNIGHT';
--------------------------------------------------------------------------------------------------------------------------
-- Unit_Flavors
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_Flavors 	
		(UnitType, 					FlavorType, Flavor)
SELECT	'UNIT_US_TADZREULI',		FlavorType, Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_KNIGHT';
--------------------------------------------------------------------------------------------------------------------------
-- Unit_FreePromotions
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_FreePromotions 	
		(UnitType, 					PromotionType)
SELECT	'UNIT_US_TADZREULI',		PromotionType
FROM Unit_FreePromotions WHERE UnitType = 'UNIT_KNIGHT';

INSERT INTO Unit_FreePromotions
		(UnitType,					PromotionType)
VALUES	('UNIT_US_TADZREULI',		'PROMOTION_US_TADZREULI');
--------------------------------------------------------------------------------------------------------------------------
-- Unit_Builds
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_Builds 	
		(UnitType, 					BuildType)
SELECT	'UNIT_US_TADZREULI',		BuildType
FROM Unit_Builds WHERE UnitType = 'UNIT_KNIGHT';
--------------------------------------------------------------------------------------------------------------------------
-- Unit_ClassUpgrades
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 					UnitClassType)
SELECT	'UNIT_US_TADZREULI',		UnitClassType
FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_KNIGHT';
--==========================================================================================================================	
-- LEADERS
--==========================================================================================================================	
-- Leaders
--------------------------------------------------------------------------------------------------------------------------			
INSERT INTO Leaders 
		(Type, 					Description, 					Civilopedia, 						CivilopediaTag, 							ArtDefineTag, 		VictoryCompetitiveness, 	WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 				PortraitIndex)
VALUES	('LEADER_US_TAMAR', 	'TXT_KEY_LEADER_US_TAMAR',		'TXT_KEY_LEADER_US_TAMAR_PEDIA',	'TXT_KEY_CIVILOPEDIA_LEADERS_US_TAMAR', 	'Tamar_Diplo.xml',	6, 							3, 						9, 							9, 			7, 				8, 				8, 						6, 				4, 			7, 			5, 				8, 			8, 			'US_GEORGIA_ATLAS', 	1);
--------------------------------------------------------------------------------------------------------------------------		
-- Leader_MajorCivApproachBiases
--------------------------------------------------------------------------------------------------------------------------						
INSERT INTO Leader_MajorCivApproachBiases 
		(LeaderType, 			MajorCivApproachType, 				Bias)
VALUES	('LEADER_US_TAMAR', 	'MAJOR_CIV_APPROACH_WAR', 			4),
		('LEADER_US_TAMAR', 	'MAJOR_CIV_APPROACH_HOSTILE', 		4),
		('LEADER_US_TAMAR', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	6),
		('LEADER_US_TAMAR', 	'MAJOR_CIV_APPROACH_GUARDED', 		5),
		('LEADER_US_TAMAR', 	'MAJOR_CIV_APPROACH_AFRAID', 		4),
		('LEADER_US_TAMAR', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		5),
		('LEADER_US_TAMAR', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		4);
--------------------------------------------------------------------------------------------------------------------------	
-- Leader_MajorCivApproachBiases
--------------------------------------------------------------------------------------------------------------------------							
INSERT INTO Leader_MinorCivApproachBiases 
		(LeaderType, 			MinorCivApproachType, 				Bias)
VALUES	('LEADER_US_TAMAR', 	'MINOR_CIV_APPROACH_IGNORE', 		2),
		('LEADER_US_TAMAR', 	'MINOR_CIV_APPROACH_FRIENDLY', 		9),
		('LEADER_US_TAMAR', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	6),
		('LEADER_US_TAMAR', 	'MINOR_CIV_APPROACH_CONQUEST', 		1),
		('LEADER_US_TAMAR', 	'MINOR_CIV_APPROACH_BULLY', 		2);
--------------------------------------------------------------------------------------------------------------------------	
-- Leader_Flavors
--------------------------------------------------------------------------------------------------------------------------							
INSERT INTO Leader_Flavors 
		(LeaderType, 			FlavorType, 						Flavor)
VALUES	('LEADER_US_TAMAR', 	'FLAVOR_OFFENSE', 					6),
		('LEADER_US_TAMAR', 	'FLAVOR_DEFENSE', 					5),
		('LEADER_US_TAMAR', 	'FLAVOR_CITY_DEFENSE', 				5),
		('LEADER_US_TAMAR', 	'FLAVOR_MILITARY_TRAINING', 		5),
		('LEADER_US_TAMAR', 	'FLAVOR_RECON', 					4),
		('LEADER_US_TAMAR', 	'FLAVOR_RANGED', 					4),
		('LEADER_US_TAMAR', 	'FLAVOR_MOBILE', 					7),
		('LEADER_US_TAMAR', 	'FLAVOR_NAVAL', 					4),
		('LEADER_US_TAMAR', 	'FLAVOR_NAVAL_RECON', 				4),
		('LEADER_US_TAMAR', 	'FLAVOR_NAVAL_GROWTH', 				4),
		('LEADER_US_TAMAR', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	4),
		('LEADER_US_TAMAR', 	'FLAVOR_AIR', 						3),
		('LEADER_US_TAMAR', 	'FLAVOR_EXPANSION', 				4),
		('LEADER_US_TAMAR', 	'FLAVOR_GROWTH', 					6),
		('LEADER_US_TAMAR', 	'FLAVOR_TILE_IMPROVEMENT', 			5),
		('LEADER_US_TAMAR', 	'FLAVOR_INFRASTRUCTURE', 			5),
		('LEADER_US_TAMAR', 	'FLAVOR_PRODUCTION', 				5),
		('LEADER_US_TAMAR', 	'FLAVOR_GOLD', 						7),
		('LEADER_US_TAMAR', 	'FLAVOR_SCIENCE', 					5),
		('LEADER_US_TAMAR', 	'FLAVOR_CULTURE', 					7),
		('LEADER_US_TAMAR', 	'FLAVOR_HAPPINESS', 				6),
		('LEADER_US_TAMAR', 	'FLAVOR_GREAT_PEOPLE', 				9),
		('LEADER_US_TAMAR', 	'FLAVOR_WONDER', 					3),
		('LEADER_US_TAMAR', 	'FLAVOR_RELIGION', 					5),
		('LEADER_US_TAMAR', 	'FLAVOR_DIPLOMACY', 				8),
		('LEADER_US_TAMAR', 	'FLAVOR_SPACESHIP', 				4),
		('LEADER_US_TAMAR', 	'FLAVOR_WATER_CONNECTION', 			5),
		('LEADER_US_TAMAR', 	'FLAVOR_NUKE', 						2),
		('LEADER_US_TAMAR', 	'FLAVOR_USE_NUKE', 					2),
		('LEADER_US_TAMAR', 	'FLAVOR_ESPIONAGE', 				7),
		('LEADER_US_TAMAR', 	'FLAVOR_AIRLIFT', 					2),
		('LEADER_US_TAMAR', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
		('LEADER_US_TAMAR', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
		('LEADER_US_TAMAR', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
		('LEADER_US_TAMAR', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
		('LEADER_US_TAMAR', 	'FLAVOR_ARCHAEOLOGY', 				5),
		('LEADER_US_TAMAR', 	'FLAVOR_AIR_CARRIER', 				5);
--------------------------------------------------------------------------------------------------------------------------	
-- Leader_Traits
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Leader_Traits 
		(LeaderType, 			TraitType)
VALUES	('LEADER_US_TAMAR', 	'TRAIT_US_GEORGIA');
--==========================================================================================================================	
-- TRAITS
--==========================================================================================================================	
-- Traits
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Traits 
		(Type, 					Description, 					ShortDescription)
VALUES	('TRAIT_US_GEORGIA', 	'TXT_KEY_TRAIT_US_GEORGIA',		'TXT_KEY_TRAIT_US_GEORGIA_SHORT');
--==========================================================================================================================	
-- DIPLOMACY
--==========================================================================================================================	
-- Diplomacy_Responses
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Diplomacy_Responses
		(LeaderType, 			ResponseType, 					Response, 									Bias)
VALUES 	('LEADER_US_TAMAR', 	'RESPONSE_DEFEATED', 			'TXT_KEY_LEADER_US_TAMAR_DEFEATED%', 		500),
		('LEADER_US_TAMAR', 	'RESPONSE_FIRST_GREETING', 		'TXT_KEY_LEADER_US_TAMAR_FIRSTGREETING%', 	500);
--==========================================================================================================================	
-- CIVILIZATIONS
--==========================================================================================================================	
-- Civilizations
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilizations 	
		(Type, 							Description,					 ShortDescription,						Adjective,							Civilopedia, 						CivilopediaTag, 			DefaultPlayerColor,		  ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas,			PortraitIndex,	AlphaIconAtlas,				SoundtrackTag,  MapImage, 		DawnOfManQuote, 						DawnOfManImage)
SELECT	'CIVILIZATION_US_GEORGIA',		'TXT_KEY_CIV_US_GEORGIA_DESC',	 'TXT_KEY_CIV_US_GEORGIA_SHORT_DESC',	'TXT_KEY_CIV_US_GEORGIA_ADJECTIVE',	'TXT_KEY_CIV5_US_GEORGIA_TEXT_1',   'TXT_KEY_CIV5_US_GEORGIA',	'PLAYERCOLOR_US_GEORGIA', ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, 'US_GEORGIA_ATLAS',	0,				'US_GEORGIA_ALPHA_ATLAS',	'Byzantium', 	'Groggo.dds',	'TXT_KEY_CIV5_DAWN_US_GEORGIA_TEXT',	'Georgia_DoM.dds'
FROM Civilizations WHERE Type = 'CIVILIZATION_BYZANTIUM';
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_CityNames
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Civilization_CityNames 
		(CivilizationType, 				CityName)
VALUES	('CIVILIZATION_US_GEORGIA', 	'TXT_KEY_CITY_NAME_US_GEORGIA_01'),
		('CIVILIZATION_US_GEORGIA', 	'TXT_KEY_CITY_NAME_US_GEORGIA_02'),
		('CIVILIZATION_US_GEORGIA', 	'TXT_KEY_CITY_NAME_US_GEORGIA_03'),
		('CIVILIZATION_US_GEORGIA', 	'TXT_KEY_CITY_NAME_US_GEORGIA_04'),
		('CIVILIZATION_US_GEORGIA', 	'TXT_KEY_CITY_NAME_US_GEORGIA_05'),
		('CIVILIZATION_US_GEORGIA', 	'TXT_KEY_CITY_NAME_US_GEORGIA_06'),
		('CIVILIZATION_US_GEORGIA', 	'TXT_KEY_CITY_NAME_US_GEORGIA_07'),
		('CIVILIZATION_US_GEORGIA', 	'TXT_KEY_CITY_NAME_US_GEORGIA_08'),
		('CIVILIZATION_US_GEORGIA', 	'TXT_KEY_CITY_NAME_US_GEORGIA_09'),
		('CIVILIZATION_US_GEORGIA', 	'TXT_KEY_CITY_NAME_US_GEORGIA_10'),
		('CIVILIZATION_US_GEORGIA', 	'TXT_KEY_CITY_NAME_US_GEORGIA_11'),
		('CIVILIZATION_US_GEORGIA', 	'TXT_KEY_CITY_NAME_US_GEORGIA_12'),
		('CIVILIZATION_US_GEORGIA', 	'TXT_KEY_CITY_NAME_US_GEORGIA_13'),
		('CIVILIZATION_US_GEORGIA', 	'TXT_KEY_CITY_NAME_US_GEORGIA_14'),
		('CIVILIZATION_US_GEORGIA', 	'TXT_KEY_CITY_NAME_US_GEORGIA_15'),
		('CIVILIZATION_US_GEORGIA', 	'TXT_KEY_CITY_NAME_US_GEORGIA_16'),
		('CIVILIZATION_US_GEORGIA', 	'TXT_KEY_CITY_NAME_US_GEORGIA_17'),
		('CIVILIZATION_US_GEORGIA', 	'TXT_KEY_CITY_NAME_US_GEORGIA_18'),
		('CIVILIZATION_US_GEORGIA', 	'TXT_KEY_CITY_NAME_US_GEORGIA_19'),
		('CIVILIZATION_US_GEORGIA', 	'TXT_KEY_CITY_NAME_US_GEORGIA_20'),
		('CIVILIZATION_US_GEORGIA', 	'TXT_KEY_CITY_NAME_US_GEORGIA_21'),
		('CIVILIZATION_US_GEORGIA', 	'TXT_KEY_CITY_NAME_US_GEORGIA_22'),
		('CIVILIZATION_US_GEORGIA', 	'TXT_KEY_CITY_NAME_US_GEORGIA_23'),
		('CIVILIZATION_US_GEORGIA', 	'TXT_KEY_CITY_NAME_US_GEORGIA_24'),
		('CIVILIZATION_US_GEORGIA', 	'TXT_KEY_CITY_NAME_US_GEORGIA_25'),
		('CIVILIZATION_US_GEORGIA', 	'TXT_KEY_CITY_NAME_US_GEORGIA_26'),
		('CIVILIZATION_US_GEORGIA', 	'TXT_KEY_CITY_NAME_US_GEORGIA_27'),
		('CIVILIZATION_US_GEORGIA', 	'TXT_KEY_CITY_NAME_US_GEORGIA_28');
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_FreeBuildingClasses
--------------------------------------------------------------------------------------------------------------------------			
INSERT INTO Civilization_FreeBuildingClasses 
		(CivilizationType, 				BuildingClassType)
SELECT	'CIVILIZATION_US_GEORGIA',	 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE CivilizationType = 'CIVILIZATION_BYZANTIUM';
--------------------------------------------------------------------------------------------------------------------------		
-- Civilization_FreeTechs
--------------------------------------------------------------------------------------------------------------------------			
INSERT INTO Civilization_FreeTechs 
		(CivilizationType, 				TechType)
SELECT	'CIVILIZATION_US_GEORGIA', 		TechType
FROM Civilization_FreeTechs WHERE CivilizationType = 'CIVILIZATION_BYZANTIUM';
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_FreeUnits
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_FreeUnits 
		(CivilizationType, 				UnitClassType, Count, UnitAIType)
SELECT	'CIVILIZATION_US_GEORGIA',		UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE CivilizationType = 'CIVILIZATION_BYZANTIUM';
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_Leaders
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_Leaders 
		(CivilizationType, 				LeaderheadType)
VALUES	('CIVILIZATION_US_GEORGIA',		'LEADER_US_TAMAR');
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_UnitClassOverrides 
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_UnitClassOverrides 
		(CivilizationType, 				UnitClassType, 				UnitType)
VALUES	('CIVILIZATION_US_GEORGIA', 	'UNITCLASS_KNIGHT',			'UNIT_US_TADZREULI');
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_BuildingClassOverrides 
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 				BuildingClassType, 			BuildingType)
VALUES	('CIVILIZATION_US_GEORGIA', 	'BUILDINGCLASS_CASTLE',		'BUILDING_US_TSIKHE');
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_Religions
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_Religions 
		(CivilizationType, 				ReligionType)
VALUES	('CIVILIZATION_US_GEORGIA',		'RELIGION_CHRISTIANITY');	
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_SpyNames
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_SpyNames 
		(CivilizationType, 				SpyName)
VALUES	('CIVILIZATION_US_GEORGIA', 	'TXT_KEY_SPY_NAME_US_GEORGIA_0'),	
		('CIVILIZATION_US_GEORGIA', 	'TXT_KEY_SPY_NAME_US_GEORGIA_1'),
		('CIVILIZATION_US_GEORGIA', 	'TXT_KEY_SPY_NAME_US_GEORGIA_2'),
		('CIVILIZATION_US_GEORGIA', 	'TXT_KEY_SPY_NAME_US_GEORGIA_3'),
		('CIVILIZATION_US_GEORGIA', 	'TXT_KEY_SPY_NAME_US_GEORGIA_4'),
		('CIVILIZATION_US_GEORGIA', 	'TXT_KEY_SPY_NAME_US_GEORGIA_5'),
		('CIVILIZATION_US_GEORGIA', 	'TXT_KEY_SPY_NAME_US_GEORGIA_6'),
		('CIVILIZATION_US_GEORGIA', 	'TXT_KEY_SPY_NAME_US_GEORGIA_7'),
		('CIVILIZATION_US_GEORGIA', 	'TXT_KEY_SPY_NAME_US_GEORGIA_8'),
		('CIVILIZATION_US_GEORGIA', 	'TXT_KEY_SPY_NAME_US_GEORGIA_9'),
		('CIVILIZATION_US_GEORGIA', 	'TXT_KEY_SPY_NAME_US_GEORGIA_10'),
		('CIVILIZATION_US_GEORGIA', 	'TXT_KEY_SPY_NAME_US_GEORGIA_11');
--==========================================================================================================================
--==========================================================================================================================
