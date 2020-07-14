--=======================================================================================================================
-- BUILDINGCLASSES
--=======================================================================================================================
-- BuildingClasses
------------------------------	
INSERT OR REPLACE INTO BuildingClasses 
		(DefaultBuilding, 										Type, 													Description)
VALUES	('BUILDING_DMS_THE_UPRIGHT_MAN_EXTRA_PRODUCTION', 		'BUILDINGCLASS_DMS_THE_UPRIGHT_MAN_EXTRA_PRODUCTION', 	'TXT_KEY_BUILDING_DMS_THE_UPRIGHT_MAN_EXTRA_PRODUCTION'),
		('BUILDING_DMS_FREIGHT_STATION_GOLD',					'BUILDINGCLASS_DMS_FREIGHT_STATION_GOLD', 				'TXT_KEY_BUILDING_DMS_FREIGHT_STATION_GOLD'),
		('BUILDING_DMS_FREIGHT_STATION_TRADE_ROUTE',			'BUILDINGCLASS_DMS_FREIGHT_STATION_TRADE_ROUTE', 		'TXT_KEY_BUILDING_DMS_FREIGHT_STATION_TRADE_ROUTE');
--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================	
-- Buildings
------------------------------	
INSERT INTO Buildings 	
		(Type, 								BuildingClass,	Cost,	FreeStartEra,	HurryCostModifier,	GoldMaintenance,	PrereqTech,	Description, 								Civilopedia, 								Help, 											Strategy,								 			ArtDefineTag, 	MinAreaSize,	ConquestProb,	PortraitIndex, 	IconAtlas)
SELECT	('BUILDING_DMS_FREIGHT_STATION'),	BuildingClass,	Cost,	FreeStartEra,	HurryCostModifier,	GoldMaintenance,	PrereqTech,	('TXT_KEY_BUILDING_DMS_FREIGHT_STATION'),	('TXT_KEY_CIV5_DMS_FREIGHT_STATION_TEXT'),	('TXT_KEY_BUILDING_DMS_FREIGHT_STATION_HELP'),	('TXT_KEY_BUILDING_DMS_FREIGHT_STATION_STRATEGY'),	ArtDefineTag,	MinAreaSize,	0,				3, 				('DMS_BURKINA_FASO_ATLAS')
FROM Buildings WHERE (Type = 'BUILDING_SEAPORT');

INSERT INTO Buildings 
		(Type, 												BuildingClass,											BuildingProductionModifier,	NumTradeRouteBonus,	Cost, 	FaithCost,	GreatWorkSlotType,	GreatWorkCount,	GoldMaintenance,	PrereqTech, NeverCapture,	Description, 												Help)
VALUES	('BUILDING_DMS_THE_UPRIGHT_MAN_EXTRA_PRODUCTION', 	'BUILDINGCLASS_DMS_THE_UPRIGHT_MAN_EXTRA_PRODUCTION',	5,							0,					-1, 	-1,			NULL,				-1,				0,					NULL,		1,				'TXT_KEY_BUILDING_DMS_THE_UPRIGHT_MAN_EXTRA_PRODUCTION',	'TXT_KEY_BUILDING_DMS_THE_UPRIGHT_MAN_EXTRA_PRODUCTION_HELP'),
		('BUILDING_DMS_FREIGHT_STATION_GOLD', 				'BUILDINGCLASS_DMS_FREIGHT_STATION_GOLD',				0,							0,					-1, 	-1,			NULL,				-1,				0,					NULL,		1,				'TXT_KEY_BUILDING_DMS_FREIGHT_STATION_GOLD',				'TXT_KEY_BUILDING_DMS_FREIGHT_STATION_GOLD_HELP'),
		('BUILDING_DMS_FREIGHT_STATION_TRADE_ROUTE', 		'BUILDINGCLASS_DMS_FREIGHT_STATION_TRADE_ROUTE',		0,							1,					-1, 	-1,			NULL,				-1,				0,					NULL,		1,				'TXT_KEY_BUILDING_DMS_FREIGHT_STATION_TRADE_ROUTE',			'TXT_KEY_BUILDING_DMS_FREIGHT_STATION_TRADE_ROUTE_HELP');
------------------------------	
-- Building_Flavors
------------------------------		
INSERT INTO Building_Flavors 	
		(BuildingType, 						FlavorType,				Flavor)
SELECT	('BUILDING_DMS_FREIGHT_STATION'),	FlavorType,				Flavor
FROM Building_Flavors WHERE (BuildingType = 'BUILDING_SEAPORT');
------------------------------	
-- Building_YieldChanges
------------------------------		
INSERT INTO Building_YieldChanges 	
		(BuildingType, 							YieldType,			Yield)
SELECT	('BUILDING_DMS_FREIGHT_STATION'),		YieldType,			Yield
FROM Building_YieldChanges WHERE (BuildingType = 'BUILDING_SEAPORT');

INSERT INTO Building_YieldChanges 	
		(BuildingType, 							YieldType,			Yield)
VALUES	('BUILDING_DMS_FREIGHT_STATION_GOLD',	'YIELD_PRODUCTION',	2); -- changed from GOLD to PRODUCTION
------------------------------	
-- Building_YieldModifiers
------------------------------		
INSERT INTO Building_YieldModifiers 	
		(BuildingType, 						YieldType,				Yield)
SELECT	('BUILDING_DMS_FREIGHT_STATION'),	YieldType,				Yield
FROM Building_YieldModifiers WHERE (BuildingType = 'BUILDING_SEAPORT');
--==========================================================================================================================
-- IMPROVEMENTS
--==========================================================================================================================
-- Improvements
--------------------------------
INSERT INTO Improvements 
		(Type,								DestroyedWhenPillaged,	Description,							Help,												Civilopedia,										ArtDefineTag,								IconAtlas,				PortraitIndex)
VALUES	('IMPROVEMENT_DMS_PLANT_FOREST',	0,						'TXT_KEY_IMPROVEMENT_DMS_PLANT_FOREST',	'TXT_KEY_CIV5_IMPROVEMENTS_DMS_PLANT_FOREST_HELP',	'TXT_KEY_CIV5_IMPROVEMENTS_DMS_PLANT_FOREST_TEXT',	'ART_DEF_IMPROVEMENT_DMS_PLANT_FOREST',		'DMS_REFOREST_ATLAS',	0);
--------------------------------
--Improvement Yields
--------------------------------
INSERT INTO Improvement_Yields 
		(ImprovementType,					YieldType,				Yield)
VALUES 	('IMPROVEMENT_DMS_PLANT_FOREST',	'YIELD_PRODUCTION',		1);
--------------------------------
--Improvement Terrains
--------------------------------
INSERT INTO Improvement_ValidTerrains 
		(ImprovementType,								TerrainType)
SELECT	'IMPROVEMENT_DMS_PLANT_FOREST',					'TERRAIN_PLAINS'	UNION ALL
SELECT	'IMPROVEMENT_DMS_PLANT_FOREST',					'TERRAIN_GRASS'		UNION ALL
SELECT	'IMPROVEMENT_DMS_PLANT_FOREST',					'TERRAIN_TUNDRA'	UNION ALL
SELECT	'IMPROVEMENT_DMS_PLANT_FOREST',					'TERRAIN_SNOW';
--------------------------------
--Improvement Features
--------------------------------
INSERT INTO Improvement_ValidFeatures
		(ImprovementType,								FeatureType)
SELECT	'IMPROVEMENT_DMS_PLANT_FOREST',					'FEATURE_FOREST'	UNION ALL
SELECT	'IMPROVEMENT_DMS_PLANT_FOREST',					'FEATURE_MARSH';
--------------------------------
--Improvement Features
--------------------------------
INSERT INTO Improvement_Flavors 
		(ImprovementType,								FlavorType,				Flavor)
VALUES	('IMPROVEMENT_DMS_PLANT_FOREST',				'FLAVOR_PRODUCTION',	5);
--==========================================================================================================================
-- BUILDS
--==========================================================================================================================
-- Builds
--------------------------------
INSERT INTO Builds 
		(Type,					PrereqTech,			Time,	ImprovementType,				Description,				Help,								Recommendation,					EntityEvent,				HotKey,		OrderPriority,	IconAtlas,							IconIndex)
VALUES	('BUILD_DMS_FOREST',	'TECH_PENICILIN',	900,	'IMPROVEMENT_DMS_PLANT_FOREST',	'TXT_KEY_BUILD_DMS_FOREST',	'TXT_KEY_BUILD_DMS_FOREST_HELP',	'TXT_KEY_BUILD_DMS_FOREST_REC',	'ENTITY_EVENT_IRRIGATE',	'KB_F',		37,				'DMS_UNIT_ACTION_REFOREST_ATLAS',	0);
--------------------------------
--Build Features 
--------------------------------
INSERT INTO BuildFeatures 
		(BuildType,				FeatureType,		PrereqTech,				Time,   Production,	Remove)
SELECT	'BUILD_DMS_FOREST',		'FEATURE_FOREST',	'TECH_PENICILIN',		900,	40,			1		UNION ALL
SELECT	'BUILD_DMS_FOREST',		'FEATURE_MARSH',	'TECH_PENICILIN',		900,	0,			1;
--==========================================================================================================================
-- UNITS
--==========================================================================================================================
-- Units
--------------------------------
INSERT INTO Units 	
		(Type, 							Class, PrereqTech,	Combat,	Cost,	WorkRate,	RequiresFaithPurchaseEnabled,	Moves,	CombatClass,	Domain,		DefaultUnitAI,	Description,							Civilopedia,								Strategy,										Help,										MilitarySupport,	MilitaryProduction,	Pillage,	ObsoleteTech,	IgnoreBuildingDefense,	GoodyHutUpgradeUnitClass,	AdvancedStartCost,	XPValueAttack,		XPValueDefense,		UnitArtInfo,							UnitFlagIconOffset,	UnitFlagAtlas,								PortraitIndex,	IconAtlas,					MoveRate)
SELECT	('UNIT_DMS_MILICE_DU_PEUPLE'),	Class, PrereqTech,	Combat,	Cost,	100,		RequiresFaithPurchaseEnabled,	Moves,	CombatClass,	Domain,		DefaultUnitAI,	('TXT_KEY_UNIT_DMS_MILICE_DU_PEUPLE'),	('TXT_KEY_UNIT_DMS_MILICE_DU_PEUPLE_TEXT'),	('TXT_KEY_UNIT_DMS_MILICE_DU_PEUPLE_STRATEGY'),	('TXT_KEY_UNIT_DMS_MILICE_DU_PEUPLE_HELP'),	MilitarySupport,	MilitaryProduction,	Pillage,	ObsoleteTech,	IgnoreBuildingDefense,	GoodyHutUpgradeUnitClass,	AdvancedStartCost,	XPValueAttack,		XPValueDefense,		('ART_DEF_UNIT_DMS_MILICE_DU_PEUPLE'),	0,					('DMS_UNIT_FLAG_MILICE_DU_PEUPLE_ATLAS'),	2,				('DMS_BURKINA_FASO_ATLAS'),	MoveRate
FROM Units WHERE (Type = 'UNIT_MARINE');
--------------------------------
-- UnitGameplay2DScripts
--------------------------------	
INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 						SelectionSound, FirstSelectionSound)
SELECT	('UNIT_DMS_MILICE_DU_PEUPLE'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_MARINE');	
--------------------------------
-- Unit_AITypes
--------------------------------	
INSERT INTO Unit_AITypes 	
		(UnitType, 						UnitAIType)
SELECT	('UNIT_DMS_MILICE_DU_PEUPLE'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_MARINE');
--------------------------------
-- Unit_Builds
--------------------------------	
INSERT INTO Unit_Builds
		(UnitType,						BuildType)
VALUES	('UNIT_DMS_MILICE_DU_PEUPLE',	'BUILD_REPAIR'),
		('UNIT_DMS_MILICE_DU_PEUPLE',	'BUILD_DMS_FOREST');
--------------------------------
-- Unit_Flavors
--------------------------------	
INSERT INTO Unit_Flavors 	
		(UnitType, 						FlavorType,			Flavor)
SELECT	('UNIT_DMS_MILICE_DU_PEUPLE'), 	FlavorType,			Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_MARINE');

INSERT INTO Unit_Flavors 
		(UnitType, 							FlavorType,					Flavor)
VALUES	('UNIT_DMS_MILICE_DU_PEUPLE', 		'FLAVOR_INFRASTRUCTURE', 	10),
		('UNIT_DMS_MILICE_DU_PEUPLE', 		'FLAVOR_CULTURE',			5);
--------------------------------
-- Unit_FreePromotions
--------------------------------	
INSERT INTO Unit_FreePromotions 	
		(UnitType, 						PromotionType)
SELECT	('UNIT_DMS_MILICE_DU_PEUPLE'), 	PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_MARINE');
--------------------------------
-- Unit_ClassUpgrades
--------------------------------	
INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 						UnitClassType)
SELECT	('UNIT_DMS_MILICE_DU_PEUPLE'),	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_MARINE');
--==========================================================================================================================	
-- PROMOTIONS
--==========================================================================================================================	
-- UnitPromotions
------------------------------
------------------------------
-- UnitPromotions_UnitCombats
------------------------------
--==========================================================================================================================	
-- LEADERS
--==========================================================================================================================	
-- Leaders
--------------------------------			
INSERT INTO Leaders 
		(Type, 							Description, 							Civilopedia, 								CivilopediaTag, 									ArtDefineTag, 				VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 					PortraitIndex)
VALUES	('LEADER_DMS_THOMAS_SANKARA', 	'TXT_KEY_LEADER_DMS_THOMAS_SANKARA', 	'TXT_KEY_LEADER_DMS_THOMAS_SANKARA_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_DMS_THOMAS_SANKARA', 	'DMS_Sankara_Diplo.xml',	7, 						3, 						7, 							7, 			7, 				4, 				5, 						4, 				8, 			5, 			4, 				7, 			4, 			'DMS_BURKINA_FASO_ATLAS', 	1);
--------------------------------		
-- Leader_MajorCivApproachBiases
--------------------------------						
INSERT INTO Leader_MajorCivApproachBiases 
		(LeaderType, 						MajorCivApproachType, 				Bias)
VALUES	('LEADER_DMS_THOMAS_SANKARA', 		'MAJOR_CIV_APPROACH_WAR', 			4),
		('LEADER_DMS_THOMAS_SANKARA', 		'MAJOR_CIV_APPROACH_HOSTILE', 		4),
		('LEADER_DMS_THOMAS_SANKARA', 		'MAJOR_CIV_APPROACH_DECEPTIVE', 	3),
		('LEADER_DMS_THOMAS_SANKARA', 		'MAJOR_CIV_APPROACH_GUARDED', 		8),
		('LEADER_DMS_THOMAS_SANKARA', 		'MAJOR_CIV_APPROACH_AFRAID', 		5),
		('LEADER_DMS_THOMAS_SANKARA', 		'MAJOR_CIV_APPROACH_FRIENDLY', 		6),
		('LEADER_DMS_THOMAS_SANKARA', 		'MAJOR_CIV_APPROACH_NEUTRAL', 		5);
--------------------------------	
-- Leader_MajorCivApproachBiases
--------------------------------							
INSERT INTO Leader_MinorCivApproachBiases 
		(LeaderType, 						MinorCivApproachType, 				Bias)
VALUES	('LEADER_DMS_THOMAS_SANKARA', 		'MINOR_CIV_APPROACH_IGNORE', 		3),
		('LEADER_DMS_THOMAS_SANKARA', 		'MINOR_CIV_APPROACH_FRIENDLY', 		7),
		('LEADER_DMS_THOMAS_SANKARA', 		'MINOR_CIV_APPROACH_PROTECTIVE', 	4),
		('LEADER_DMS_THOMAS_SANKARA', 		'MINOR_CIV_APPROACH_CONQUEST', 		4),
		('LEADER_DMS_THOMAS_SANKARA', 		'MINOR_CIV_APPROACH_BULLY', 		3);
--------------------------------	
-- Leader_Flavors
--------------------------------							
INSERT INTO Leader_Flavors 
		(LeaderType, 						FlavorType, 						Flavor)
VALUES	('LEADER_DMS_THOMAS_SANKARA', 		'FLAVOR_OFFENSE', 					6),
		('LEADER_DMS_THOMAS_SANKARA', 		'FLAVOR_DEFENSE', 					7),
		('LEADER_DMS_THOMAS_SANKARA', 		'FLAVOR_CITY_DEFENSE', 				5),
		('LEADER_DMS_THOMAS_SANKARA', 		'FLAVOR_MILITARY_TRAINING', 		7),
		('LEADER_DMS_THOMAS_SANKARA', 		'FLAVOR_RECON', 					5),
		('LEADER_DMS_THOMAS_SANKARA', 		'FLAVOR_RANGED', 					5),
		('LEADER_DMS_THOMAS_SANKARA', 		'FLAVOR_MOBILE', 					5),
		('LEADER_DMS_THOMAS_SANKARA', 		'FLAVOR_NAVAL', 					4),
		('LEADER_DMS_THOMAS_SANKARA', 		'FLAVOR_NAVAL_RECON', 				4),
		('LEADER_DMS_THOMAS_SANKARA', 		'FLAVOR_NAVAL_GROWTH', 				4),
		('LEADER_DMS_THOMAS_SANKARA', 		'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	4),
		('LEADER_DMS_THOMAS_SANKARA', 		'FLAVOR_AIR', 						6),
		('LEADER_DMS_THOMAS_SANKARA', 		'FLAVOR_EXPANSION', 				4),
		('LEADER_DMS_THOMAS_SANKARA', 		'FLAVOR_GROWTH', 					7),
		('LEADER_DMS_THOMAS_SANKARA', 		'FLAVOR_TILE_IMPROVEMENT', 			8),
		('LEADER_DMS_THOMAS_SANKARA', 		'FLAVOR_INFRASTRUCTURE', 			9),
		('LEADER_DMS_THOMAS_SANKARA', 		'FLAVOR_PRODUCTION', 				8),
		('LEADER_DMS_THOMAS_SANKARA', 		'FLAVOR_GOLD', 						5),
		('LEADER_DMS_THOMAS_SANKARA', 		'FLAVOR_SCIENCE', 					7),
		('LEADER_DMS_THOMAS_SANKARA', 		'FLAVOR_CULTURE', 					7),
		('LEADER_DMS_THOMAS_SANKARA', 		'FLAVOR_HAPPINESS', 				5),
		('LEADER_DMS_THOMAS_SANKARA', 		'FLAVOR_GREAT_PEOPLE', 				4),
		('LEADER_DMS_THOMAS_SANKARA', 		'FLAVOR_WONDER', 					4),
		('LEADER_DMS_THOMAS_SANKARA', 		'FLAVOR_RELIGION', 					3),
		('LEADER_DMS_THOMAS_SANKARA', 		'FLAVOR_DIPLOMACY', 				8),
		('LEADER_DMS_THOMAS_SANKARA', 		'FLAVOR_SPACESHIP', 				6),
		('LEADER_DMS_THOMAS_SANKARA', 		'FLAVOR_WATER_CONNECTION', 			4),
		('LEADER_DMS_THOMAS_SANKARA', 		'FLAVOR_NUKE', 						3),
		('LEADER_DMS_THOMAS_SANKARA', 		'FLAVOR_USE_NUKE', 					5),
		('LEADER_DMS_THOMAS_SANKARA', 		'FLAVOR_ESPIONAGE', 				6),
		('LEADER_DMS_THOMAS_SANKARA', 		'FLAVOR_AIRLIFT', 					5),
		('LEADER_DMS_THOMAS_SANKARA', 		'FLAVOR_I_TRADE_DESTINATION', 		5),
		('LEADER_DMS_THOMAS_SANKARA', 		'FLAVOR_I_TRADE_ORIGIN', 			5),
		('LEADER_DMS_THOMAS_SANKARA', 		'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
		('LEADER_DMS_THOMAS_SANKARA', 		'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
		('LEADER_DMS_THOMAS_SANKARA', 		'FLAVOR_ARCHAEOLOGY', 				5),
		('LEADER_DMS_THOMAS_SANKARA', 		'FLAVOR_AIR_CARRIER', 				5);
--------------------------------	
-- Leader_Traits
--------------------------------	
INSERT INTO Leader_Traits 
		(LeaderType, 						TraitType)
VALUES	('LEADER_DMS_THOMAS_SANKARA', 		'TRAIT_DMS_THE_UPRIGHT_MAN');
--==========================================================================================================================	
-- TRAITS
--==========================================================================================================================	
-- Traits
--------------------------------	
INSERT INTO Traits 
		(Type, 							Description, 							ShortDescription)
VALUES	('TRAIT_DMS_THE_UPRIGHT_MAN', 	'TXT_KEY_TRAIT_DMS_THE_UPRIGHT_MAN', 	'TXT_KEY_TRAIT_DMS_THE_UPRIGHT_MAN_SHORT');	
--==========================================================================================================================	
-- CIVILIZATIONS
--==========================================================================================================================	
-- Civilizations
--------------------------------		
INSERT INTO Civilizations
		(Type, 								Description, 								ShortDescription,									Adjective,												CivilopediaTag,											DefaultPlayerColor,					ArtDefineTag,	ArtStyleType,	ArtStyleSuffix, ArtStylePrefix, PortraitIndex,	IconAtlas,					AlphaIconAtlas,						SoundtrackTag,	MapImage,						DawnOfManQuote,									DawnOfManImage)
SELECT	('CIVILIZATION_DMS_BURKINA_FASO'), 	('TXT_KEY_CIVILIZATION_DMS_BURKINA_FASO'), 	('TXT_KEY_CIVILIZATION_DMS_BURKINA_FASO_SHORT'),	('TXT_KEY_CIVILIZATION_DMS_BURKINA_FASO_ADJECTIVE'),	('TXT_KEY_CIVILOPEDIA_CIVILIZATIONS_DMS_BURKINA_FASO'),	('PLAYERCOLOR_DMS_BURKINA_FASO'),	ArtDefineTag,	ArtStyleType,	ArtStyleSuffix, ArtStylePrefix, 0,				('DMS_BURKINA_FASO_ATLAS'),	('DMS_BURKINA_FASO_ALPHA_ATLAS'),	('Songhai'),	('DMS_BurkinaFaso_Map512.dds'), ('TXT_KEY_CIV5_DAWN_DMS_BURKINA_FASO_TEXT'), 	('DMS_Sankara_DOM.dds')
FROM Civilizations WHERE (Type = 'CIVILIZATION_SONGHAI');
--------------------------------	
-- Civilization_CityNames
--------------------------------	
INSERT INTO Civilization_CityNames
        (CivilizationType,						CityName)
VALUES	('CIVILIZATION_DMS_BURKINA_FASO', 	 	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_BURKINA_FASO_1'),
        ('CIVILIZATION_DMS_BURKINA_FASO',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_BURKINA_FASO_2'),
        ('CIVILIZATION_DMS_BURKINA_FASO',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_BURKINA_FASO_3'),
        ('CIVILIZATION_DMS_BURKINA_FASO',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_BURKINA_FASO_4'),
        ('CIVILIZATION_DMS_BURKINA_FASO',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_BURKINA_FASO_5'),
        ('CIVILIZATION_DMS_BURKINA_FASO',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_BURKINA_FASO_6'),
        ('CIVILIZATION_DMS_BURKINA_FASO',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_BURKINA_FASO_7'),
        ('CIVILIZATION_DMS_BURKINA_FASO',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_BURKINA_FASO_8'),
        ('CIVILIZATION_DMS_BURKINA_FASO',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_BURKINA_FASO_9'),
        ('CIVILIZATION_DMS_BURKINA_FASO',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_BURKINA_FASO_10'),
        ('CIVILIZATION_DMS_BURKINA_FASO',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_BURKINA_FASO_11'),
        ('CIVILIZATION_DMS_BURKINA_FASO',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_BURKINA_FASO_12'),
        ('CIVILIZATION_DMS_BURKINA_FASO',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_BURKINA_FASO_13'),
        ('CIVILIZATION_DMS_BURKINA_FASO',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_BURKINA_FASO_14'),
        ('CIVILIZATION_DMS_BURKINA_FASO',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_BURKINA_FASO_15'),
        ('CIVILIZATION_DMS_BURKINA_FASO',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_BURKINA_FASO_16'),
        ('CIVILIZATION_DMS_BURKINA_FASO',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_BURKINA_FASO_17'),
        ('CIVILIZATION_DMS_BURKINA_FASO',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_BURKINA_FASO_18'),
        ('CIVILIZATION_DMS_BURKINA_FASO',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_BURKINA_FASO_19'),
        ('CIVILIZATION_DMS_BURKINA_FASO',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_BURKINA_FASO_20'),
        ('CIVILIZATION_DMS_BURKINA_FASO',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_BURKINA_FASO_21'),
        ('CIVILIZATION_DMS_BURKINA_FASO',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_BURKINA_FASO_22'),
        ('CIVILIZATION_DMS_BURKINA_FASO',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_BURKINA_FASO_23'),
        ('CIVILIZATION_DMS_BURKINA_FASO',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_BURKINA_FASO_24'),
        ('CIVILIZATION_DMS_BURKINA_FASO',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_BURKINA_FASO_25'),
        ('CIVILIZATION_DMS_BURKINA_FASO',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_BURKINA_FASO_26'),
        ('CIVILIZATION_DMS_BURKINA_FASO',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_BURKINA_FASO_27'),
        ('CIVILIZATION_DMS_BURKINA_FASO',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_BURKINA_FASO_28'),
        ('CIVILIZATION_DMS_BURKINA_FASO',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_BURKINA_FASO_29'),
        ('CIVILIZATION_DMS_BURKINA_FASO',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_BURKINA_FASO_30'),
        ('CIVILIZATION_DMS_BURKINA_FASO',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_BURKINA_FASO_31'),
        ('CIVILIZATION_DMS_BURKINA_FASO',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_BURKINA_FASO_32'),
        ('CIVILIZATION_DMS_BURKINA_FASO',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_BURKINA_FASO_33'),
        ('CIVILIZATION_DMS_BURKINA_FASO',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_BURKINA_FASO_34'),
        ('CIVILIZATION_DMS_BURKINA_FASO',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_BURKINA_FASO_35'),
        ('CIVILIZATION_DMS_BURKINA_FASO',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_BURKINA_FASO_36'),
        ('CIVILIZATION_DMS_BURKINA_FASO',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_BURKINA_FASO_37'),
        ('CIVILIZATION_DMS_BURKINA_FASO',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_BURKINA_FASO_38'),
        ('CIVILIZATION_DMS_BURKINA_FASO',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_BURKINA_FASO_39'),
        ('CIVILIZATION_DMS_BURKINA_FASO',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_BURKINA_FASO_40');			
--------------------------------		
-- Civilization_FreeBuildingClasses
--------------------------------			
INSERT INTO Civilization_FreeBuildingClasses 
		(CivilizationType, 					BuildingClassType)
SELECT	('CIVILIZATION_DMS_BURKINA_FASO'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_SONGHAI');
--------------------------------	
-- Civilization_FreeTechs
--------------------------------		
INSERT INTO Civilization_FreeTechs 
		(CivilizationType, 					TechType)
SELECT	('CIVILIZATION_DMS_BURKINA_FASO'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_SONGHAI');
--------------------------------	
-- Civilization_FreeUnits
--------------------------------		
INSERT INTO Civilization_FreeUnits 
		(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT	('CIVILIZATION_DMS_BURKINA_FASO'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_SONGHAI');
--------------------------------	
-- Civilization_Leaders
--------------------------------
INSERT INTO Civilization_Leaders 
		(CivilizationType, 					LeaderheadType)
VALUES	('CIVILIZATION_DMS_BURKINA_FASO',	'LEADER_DMS_THOMAS_SANKARA');
--------------------------------	
-- Civilization_UnitClassOverrides 
--------------------------------
INSERT INTO Civilization_UnitClassOverrides 
		(CivilizationType, 					UnitClassType, 				UnitType)
VALUES	('CIVILIZATION_DMS_BURKINA_FASO', 	'UNITCLASS_MARINE',			'UNIT_DMS_MILICE_DU_PEUPLE');
--------------------------------	
-- Civilization_BuildingClassOverrides 
--------------------------------
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 					BuildingClassType, 			BuildingType)
VALUES	('CIVILIZATION_DMS_BURKINA_FASO', 	'BUILDINGCLASS_SEAPORT', 	'BUILDING_DMS_FREIGHT_STATION');
--------------------------------	
--------------------------------	
-- Civilization_SpyNames
--------------------------------
INSERT INTO Civilization_SpyNames 
		(CivilizationType, 					SpyName)
VALUES	('CIVILIZATION_DMS_BURKINA_FASO', 	'TXT_KEY_SPY_NAME_DMS_BURKINA_FASO_0'),	
		('CIVILIZATION_DMS_BURKINA_FASO', 	'TXT_KEY_SPY_NAME_DMS_BURKINA_FASO_1'),
		('CIVILIZATION_DMS_BURKINA_FASO', 	'TXT_KEY_SPY_NAME_DMS_BURKINA_FASO_2'),
		('CIVILIZATION_DMS_BURKINA_FASO', 	'TXT_KEY_SPY_NAME_DMS_BURKINA_FASO_3'),
		('CIVILIZATION_DMS_BURKINA_FASO', 	'TXT_KEY_SPY_NAME_DMS_BURKINA_FASO_4'),
		('CIVILIZATION_DMS_BURKINA_FASO', 	'TXT_KEY_SPY_NAME_DMS_BURKINA_FASO_5'),
		('CIVILIZATION_DMS_BURKINA_FASO', 	'TXT_KEY_SPY_NAME_DMS_BURKINA_FASO_6'),
		('CIVILIZATION_DMS_BURKINA_FASO', 	'TXT_KEY_SPY_NAME_DMS_BURKINA_FASO_7'),
		('CIVILIZATION_DMS_BURKINA_FASO', 	'TXT_KEY_SPY_NAME_DMS_BURKINA_FASO_8'),
		('CIVILIZATION_DMS_BURKINA_FASO', 	'TXT_KEY_SPY_NAME_DMS_BURKINA_FASO_9');
--------------------------------	
-- Civilization_Start_Region_Priority 
--------------------------------		
INSERT INTO Civilization_Start_Region_Priority 
		(CivilizationType, 					RegionType)
VALUES	('CIVILIZATION_DMS_BURKINA_FASO', 	'REGION_HILLS');
--==========================================================================================================================
--==========================================================================================================================