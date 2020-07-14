--==========================================================================================================================	
-- Civilizations
--==========================================================================================================================				
INSERT INTO Civilizations 	
			(Type, 							Description, 						ShortDescription, 						Adjective, 								Civilopedia, 						CivilopediaTag, 				DefaultPlayerColor, 			ArtDefineTag, ArtStyleType,	ArtStyleSuffix, ArtStylePrefix, IconAtlas, 					PortraitIndex, 	AlphaIconAtlas, 			SoundtrackTag, 	MapImage,			DawnOfManQuote,							DawnOfManImage)
SELECT		('CIVILIZATION_DJ_ICELAND'), 	('TXT_KEY_CIV_DJ_ICELAND_DESC'), 	('TXT_KEY_CIV_DJ_ICELAND_SHORT_DESC'),	('TXT_KEY_CIV_DJ_ICELAND_ADJECTIVE'),	('TXT_KEY_CIV5_DJ_ICELAND_TEXT_1'),	('TXT_KEY_CIV5_DJ_ICELAND'),	('PLAYERCOLOR_DJ_ICELAND'), 	ArtDefineTag, ArtStyleType,	ArtStyleSuffix,	ArtStylePrefix,	('DJ_ICELAND_COLOR_ATLAS'), 0,			 	('DJ_ICELAND_ALPHA_ATLAS'), SoundtrackTag, 	('EldjarnMap.dds'), ('TXT_KEY_CIV5_DOM_DJ_ELDJARN_TEXT'),	('EldjarnDoM.dds')
FROM Civilizations WHERE (Type = 'CIVILIZATION_DENMARK');

UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_DENMARK' )
	THEN '_DENMARK'
	ELSE '_EURO' END) 
WHERE Type = 'CIVILIZATION_DJ_ICELAND';
--==========================================================================================================================	
-- Civilization_CityNames
--==========================================================================================================================			
INSERT INTO Civilization_CityNames 
			(CivilizationType, 				CityName)
VALUES		('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_CITY_NAME_DJ_REYKJAVIK'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_CITY_NAME_DJ_KOPAVOGUR'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_CITY_NAME_DJ_HAFNARFJORDUR'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_CITY_NAME_DJ_AKUREYRI'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_CITY_NAME_DJ_REYKJANESBAER'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_CITY_NAME_DJ_GARDABAER'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_CITY_NAME_DJ_MOSFELLSBAER'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_CITY_NAME_DJ_SELFOSS'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_CITY_NAME_DJ_AKRANES'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_CITY_NAME_DJ_SELTJARNARNES'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_CITY_NAME_DJ_VESTMANNAEYJAR'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_CITY_NAME_DJ_GRINDAVIK'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_CITY_NAME_DJ_ISAFJORDUR'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_CITY_NAME_DJ_ALFTANES'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_CITY_NAME_DJ_SAUDARKROKUR'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_CITY_NAME_DJ_HVERAGERDI'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_CITY_NAME_DJ_EGILSSTADIR'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_CITY_NAME_DJ_HUSAVIK'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_CITY_NAME_DJ_BORGARNES'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_CITY_NAME_DJ_SANDGERDI'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_CITY_NAME_DJ_HOFN'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_CITY_NAME_DJ_THORLAKSHOFN'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_CITY_NAME_DJ_GARDUR'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_CITY_NAME_DJ_NESKAUPSTADUR'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_CITY_NAME_DJ_DALVIK'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_CITY_NAME_DJ_REYDARFJORDUR'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_CITY_NAME_DJ_SIGLUFJORDUR'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_CITY_NAME_DJ_VOGAR'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_CITY_NAME_DJ_STYKKISHOLMUR'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_CITY_NAME_DJ_ESKIFJORDUR'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_CITY_NAME_DJ_OLAFSVIK'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_CITY_NAME_DJ_HVOLSVOLLUR'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_CITY_NAME_DJ_BOLUNGARVIK'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_CITY_NAME_DJ_HELLA'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_CITY_NAME_DJ_GRUNDARFJORDUR'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_CITY_NAME_DJ_BLONDUOS');
--==========================================================================================================================	
-- Civilization_FreeBuildingClasses
--==========================================================================================================================			
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 				BuildingClassType)
SELECT		('CIVILIZATION_DJ_ICELAND'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_DENMARK');
--==========================================================================================================================	
-- Civilization_FreeTechs
--==========================================================================================================================		
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 				TechType)
SELECT		('CIVILIZATION_DJ_ICELAND'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_DENMARK');
--==========================================================================================================================	
-- Civilization_FreeUnits
--==========================================================================================================================		
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 				UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_DJ_ICELAND'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_DENMARK');
--==========================================================================================================================	
-- Civilization_Leaders
--==========================================================================================================================			
INSERT INTO Civilization_Leaders 
			(CivilizationType, 				LeaderheadType)
VALUES		('CIVILIZATION_DJ_ICELAND', 	'LEADER_DJ_ELDJARN');	
--==========================================================================================================================	
-- Civilization_UnitClassOverrides 
--==========================================================================================================================		
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 				UnitClassType, 			 UnitType)
VALUES		('CIVILIZATION_DJ_ICELAND', 	'UNITCLASS_BATTLESHIP',	'UNIT_DJ_AEGIR_CLASS');
--==========================================================================================================================	
--==========================================================================================================================	
-- Civilization_Start_Region_Priority
--==========================================================================================================================		
INSERT INTO Civilization_Start_Region_Priority
			(CivilizationType, 				RegionType)
VALUES		('CIVILIZATION_DJ_ICELAND', 	'REGION_TUNDRA');
--==========================================================================================================================	
-- Civilization_Start_Along_Ocean
--==========================================================================================================================		
INSERT INTO Civilization_Start_Along_Ocean 
			(CivilizationType, 				StartAlongOcean)
VALUES		('CIVILIZATION_DJ_ICELAND', 	1);
--==========================================================================================================================	
-- Civilization_SpyNames
--==========================================================================================================================		
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 				SpyName)
VALUES		('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_SPY_NAME_DJ_ICELAND_0'),	
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_SPY_NAME_DJ_ICELAND_1'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_SPY_NAME_DJ_ICELAND_2'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_SPY_NAME_DJ_ICELAND_3'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_SPY_NAME_DJ_ICELAND_4'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_SPY_NAME_DJ_ICELAND_5'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_SPY_NAME_DJ_ICELAND_6'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_SPY_NAME_DJ_ICELAND_7'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_SPY_NAME_DJ_ICELAND_8'),
			('CIVILIZATION_DJ_ICELAND', 	'TXT_KEY_SPY_NAME_DJ_ICELAND_9');
--==========================================================================================================================	
-- Colors
--==========================================================================================================================			
INSERT INTO Colors 
			(Type, 										Red, 	Green, 	Blue, 	Alpha)
VALUES		('COLOR_PLAYER_DJ_ICELAND_ICON', 			0.727,	0.727,	0.727,	1),
			('COLOR_PLAYER_DJ_ICELAND_BACKGROUND',		0.250,	0.199,	0.234,	1);
--==========================================================================================================================	
-- PlayerColors
--==========================================================================================================================				
INSERT INTO PlayerColors 
			(Type, 						PrimaryColor, 					SecondaryColor, 						TextColor)
VALUES		('PLAYERCOLOR_DJ_ICELAND',	'COLOR_PLAYER_DJ_ICELAND_ICON',	'COLOR_PLAYER_DJ_ICELAND_BACKGROUND',	'COLOR_PLAYER_WHITE_TEXT');
--==========================================================================================================================	
-- Leaders
--==========================================================================================================================			
INSERT INTO Leaders 
			(Type, 					Description, 					Civilopedia, 						CivilopediaTag, 							ArtDefineTag, 			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 					PortraitIndex)
VALUES		('LEADER_DJ_ELDJARN', 	'TXT_KEY_LEADER_DJ_ELDJARN', 	'TXT_KEY_LEADER_DJ_ELDJARN_PEDIA',	'TXT_KEY_CIVILOPEDIA_LEADERS_DJ_ELDJARN', 	'Eldjarn_Scene.xml',	7, 						3, 						4, 							7, 			6, 				7, 				5, 						7, 				7, 			5, 			7, 				5, 			2, 			'DJ_ICELAND_COLOR_ATLAS', 	1);
--==========================================================================================================================	
-- Leader_MajorCivApproachBiases
--==========================================================================================================================						
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 				MajorCivApproachType, 				Bias)
VALUES		('LEADER_DJ_ELDJARN', 		'MAJOR_CIV_APPROACH_WAR', 			4),
			('LEADER_DJ_ELDJARN', 		'MAJOR_CIV_APPROACH_HOSTILE', 		3),
			('LEADER_DJ_ELDJARN', 		'MAJOR_CIV_APPROACH_DECEPTIVE', 	3),
			('LEADER_DJ_ELDJARN', 		'MAJOR_CIV_APPROACH_GUARDED', 		5),
			('LEADER_DJ_ELDJARN', 		'MAJOR_CIV_APPROACH_AFRAID', 		4),
			('LEADER_DJ_ELDJARN', 		'MAJOR_CIV_APPROACH_FRIENDLY', 		6),
			('LEADER_DJ_ELDJARN', 		'MAJOR_CIV_APPROACH_NEUTRAL', 		7);
--==========================================================================================================================	
-- Leader_MajorCivApproachBiases
--==========================================================================================================================						
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 			MinorCivApproachType, 				Bias)
VALUES		('LEADER_DJ_ELDJARN', 	'MINOR_CIV_APPROACH_IGNORE', 		5),
			('LEADER_DJ_ELDJARN', 	'MINOR_CIV_APPROACH_FRIENDLY', 		6),
			('LEADER_DJ_ELDJARN', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	5),
			('LEADER_DJ_ELDJARN', 	'MINOR_CIV_APPROACH_CONQUEST', 		2),
			('LEADER_DJ_ELDJARN', 	'MINOR_CIV_APPROACH_BULLY', 		4);
--==========================================================================================================================	
-- Leader_Flavors
--==========================================================================================================================						
INSERT INTO Leader_Flavors 
			(LeaderType, 			FlavorType, 						Flavor)
VALUES		('LEADER_DJ_ELDJARN', 	'FLAVOR_OFFENSE', 					4),
			('LEADER_DJ_ELDJARN', 	'FLAVOR_DEFENSE', 					7),
			('LEADER_DJ_ELDJARN', 	'FLAVOR_CITY_DEFENSE', 				6),
			('LEADER_DJ_ELDJARN', 	'FLAVOR_MILITARY_TRAINING', 		5),
			('LEADER_DJ_ELDJARN', 	'FLAVOR_RECON', 					7),
			('LEADER_DJ_ELDJARN', 	'FLAVOR_RANGED', 					3),
			('LEADER_DJ_ELDJARN', 	'FLAVOR_MOBILE', 					5),
			('LEADER_DJ_ELDJARN', 	'FLAVOR_NAVAL', 					7),
			('LEADER_DJ_ELDJARN', 	'FLAVOR_NAVAL_RECON', 				7),
			('LEADER_DJ_ELDJARN', 	'FLAVOR_NAVAL_GROWTH', 				5),
			('LEADER_DJ_ELDJARN', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	8),
			('LEADER_DJ_ELDJARN', 	'FLAVOR_AIR', 						5),
			('LEADER_DJ_ELDJARN', 	'FLAVOR_EXPANSION', 				7),
			('LEADER_DJ_ELDJARN', 	'FLAVOR_GROWTH', 					5),
			('LEADER_DJ_ELDJARN', 	'FLAVOR_TILE_IMPROVEMENT', 			7),
			('LEADER_DJ_ELDJARN', 	'FLAVOR_INFRASTRUCTURE', 			4),
			('LEADER_DJ_ELDJARN', 	'FLAVOR_PRODUCTION', 				4),
			('LEADER_DJ_ELDJARN', 	'FLAVOR_GOLD', 						6),
			('LEADER_DJ_ELDJARN', 	'FLAVOR_SCIENCE', 					4),
			('LEADER_DJ_ELDJARN', 	'FLAVOR_CULTURE', 					8),
			('LEADER_DJ_ELDJARN', 	'FLAVOR_HAPPINESS', 				6),
			('LEADER_DJ_ELDJARN', 	'FLAVOR_GREAT_PEOPLE', 				4),
			('LEADER_DJ_ELDJARN', 	'FLAVOR_WONDER', 					4),
			('LEADER_DJ_ELDJARN', 	'FLAVOR_RELIGION', 					5),
			('LEADER_DJ_ELDJARN', 	'FLAVOR_DIPLOMACY', 				7),
			('LEADER_DJ_ELDJARN', 	'FLAVOR_SPACESHIP', 				5),
			('LEADER_DJ_ELDJARN', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_DJ_ELDJARN', 	'FLAVOR_NUKE', 						2),
			('LEADER_DJ_ELDJARN', 	'FLAVOR_USE_NUKE', 					3),
			('LEADER_DJ_ELDJARN', 	'FLAVOR_ESPIONAGE', 				6),
			('LEADER_DJ_ELDJARN', 	'FLAVOR_AIRLIFT', 					5),
			('LEADER_DJ_ELDJARN', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_DJ_ELDJARN', 	'FLAVOR_I_TRADE_ORIGIN', 			6),
			('LEADER_DJ_ELDJARN', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		7),
			('LEADER_DJ_ELDJARN', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_DJ_ELDJARN', 	'FLAVOR_ARCHAEOLOGY', 				8),
			('LEADER_DJ_ELDJARN', 	'FLAVOR_AIR_CARRIER', 				5);
--==========================================================================================================================	
-- Leader_Traits
--==========================================================================================================================						
INSERT INTO Leader_Traits 
			(LeaderType, 			TraitType)
VALUES		('LEADER_DJ_ELDJARN',	'TRAIT_DJ_COD_WARS');
--==========================================================================================================================	
-- Traits
--==========================================================================================================================						
INSERT INTO Traits
			(Type,					Description,					ShortDescription,					FreeBuilding)
VALUES		('TRAIT_DJ_COD_WARS',	'TXT_KEY_TRAIT_DJ_COD_WARS',	'TXT_KEY_TRAIT_DJ_COD_WARS_SHORT',	'BUILDING_DJ_ICELAND_CULTURE');
--==========================================================================================================================	
-- BuildingClasses
--==========================================================================================================================						
INSERT INTO BuildingClasses
		(Type,									DefaultBuilding,				Description)
VALUES	('BUILDINGCLASS_DJ_ICELAND_CULTURE',	'BUILDING_DJ_ICELAND_CULTURE',	'TXT_KEY_TRAIT_DJ_COD_WARS_SHORT');
--==========================================================================================================================	
-- Buildings
--==========================================================================================================================						
INSERT INTO Buildings
		(Type,							BuildingClass,						Cost,	PrereqTech,	FaithCost,	GreatWorkCount,	MinAreaSize,	NeverCapture,	NukeImmune,	PortraitIndex,	IconAtlas,		Description)
VALUES	('BUILDING_DJ_ICELAND_CULTURE',	'BUILDINGCLASS_DJ_ICELAND_CULTURE',	-1,		NULL,		-1,			-1,				-1,				1,				1,			19,				'BW_ATLAS_1',	'TXT_KEY_TRAIT_DJ_COD_WARS_SHORT');
--==========================================================================================================================	
-- Building_SeaResourceYieldChanges
--==========================================================================================================================						
INSERT INTO Building_SeaResourceYieldChanges
		(BuildingType,					YieldType,			Yield)
VALUES	('BUILDING_DJ_ICELAND_CULTURE',	'YIELD_CULTURE',	1);
--==========================================================================================================================	
-- Improvements
--==========================================================================================================================
INSERT INTO Improvements
		(Type,						Description,						Civilopedia,							Help,									ArtDefineTag,						PillageGold,	PortraitIndex,	IconAtlas,					CivilizationType,			SpecificCivRequired,	NoTwoAdjacent)
VALUES	('IMPROVEMENT_DJ_TORFBAER',	'TXT_KEY_IMPROVEMENT_DJ_TORFBAER',	'TXT_KEY_IMPROVEMENT_DJ_TORFBAER_TEXT',	'TXT_KEY_IMPROVEMENT_DJ_TORFBAER_HELP',	'ART_DEF_IMPROVEMENT_DJ_TORFBAER',	30,				3,				'DJ_ICELAND_COLOR_ATLAS',	'CIVILIZATION_DJ_ICELAND',	1,						1);

INSERT INTO Improvements
		(Type,									OutsideBorders, GraphicalOnly,	Description, Civilopedia, ArtDefineTag,	PillageGold, Water,	DestroyedWhenPillaged,	PortraitIndex,	IconAtlas)
SELECT	'IMPROVEMENT_DJ_ICELAND_FISHING_BOATS',	1,				1,				Description, Civilopedia, ArtDefineTag, PillageGold, Water,	DestroyedWhenPillaged,	PortraitIndex,	IconAtlas
FROM Improvements WHERE Type = 'IMPROVEMENT_FISHING_BOATS';

INSERT INTO Improvements
		(Type,										OutsideBorders, GraphicalOnly,	Description, Civilopedia, ArtDefineTag, Water,	DestroyedWhenPillaged,	PillageGold, PortraitIndex,	IconAtlas)
SELECT	'IMPROVEMENT_DJ_ICELAND_OFFSHORE_PLATFORM',	1,				1,				Description, Civilopedia, ArtDefineTag, Water,	DestroyedWhenPillaged,	PillageGold, PortraitIndex,	IconAtlas
FROM Improvements WHERE Type = 'IMPROVEMENT_OFFSHORE_PLATFORM';
--==========================================================================================================================	
-- Improvement_AdjacentMountainYieldChanges
--==========================================================================================================================
INSERT INTO Improvement_AdjacentMountainYieldChanges
		(ImprovementType,			YieldType,			Yield)
VALUES	('IMPROVEMENT_DJ_TORFBAER',	'YIELD_CULTURE',	1);
--==========================================================================================================================	
-- Improvement_AdjacentFeatureYieldChanges
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Improvement_AdjacentFeatureYieldChanges(ImprovementType, FeatureType, YieldType, Yield);
INSERT INTO Improvement_AdjacentFeatureYieldChanges
		(ImprovementType,			FeatureType,	YieldType,		Yield)
SELECT	'IMPROVEMENT_DJ_TORFBAER',	Type,			'YIELD_CULTURE',	1
FROM Features WHERE NaturalWonder = 1;
--==========================================================================================================================	
-- Improvement_Yields
--==========================================================================================================================
INSERT INTO Improvement_Yields
		(ImprovementType,			YieldType,			Yield)
VALUES	('IMPROVEMENT_DJ_TORFBAER',	'YIELD_FOOD',		2),
		('IMPROVEMENT_DJ_TORFBAER',	'YIELD_CULTURE',	1);
--==========================================================================================================================	
-- Improvement_ResourceTypes
--==========================================================================================================================
INSERT INTO Improvement_ResourceTypes
		(ImprovementType,						ResourceType)
SELECT	'IMPROVEMENT_DJ_ICELAND_FISHING_BOATS', ResourceType
FROM Improvement_ResourceTypes WHERE ImprovementType = 'IMPROVEMENT_FISHING_BOATS';

INSERT INTO Improvement_ResourceTypes
		(ImprovementType,							ResourceType)
SELECT	'IMPROVEMENT_DJ_ICELAND_OFFSHORE_PLATFORM', ResourceType
FROM Improvement_ResourceTypes WHERE ImprovementType = 'IMPROVEMENT_OFFSHORE_PLATFORM';
--==========================================================================================================================	
-- Improvement_ResourceType_Yields
--==========================================================================================================================	
INSERT INTO Improvement_ResourceType_Yields
		(ImprovementType,						ResourceType, YieldType, Yield)
SELECT	'IMPROVEMENT_DJ_ICELAND_FISHING_BOATS', 	ResourceType, YieldType, Yield
FROM Improvement_ResourceType_Yields WHERE ImprovementType = 'IMPROVEMENT_FISHING_BOATS';
	
INSERT INTO Improvement_ResourceType_Yields
		(ImprovementType,						ResourceType, YieldType, Yield)
SELECT	'IMPROVEMENT_DJ_ICELAND_OFFSHORE_PLATFORM', 	ResourceType, YieldType, Yield
FROM Improvement_ResourceType_Yields WHERE ImprovementType = 'IMPROVEMENT_OFFSHORE_PLATFORM';
--==========================================================================================================================	
-- Improvement_TechYieldChanges
--==========================================================================================================================	
INSERT INTO Improvement_TechYieldChanges
		(ImprovementType,						TechType, YieldType, Yield)
SELECT	'IMPROVEMENT_DJ_ICELAND_FISHING_BOATS', 	TechType, YieldType, Yield
FROM Improvement_TechYieldChanges WHERE ImprovementType = 'IMPROVEMENT_FISHING_BOATS';

INSERT INTO Improvement_TechYieldChanges
		(ImprovementType,						TechType, YieldType, Yield)
SELECT	'IMPROVEMENT_DJ_ICELAND_OFFSHORE_PLATFORM', 	TechType, YieldType, Yield
FROM Improvement_TechYieldChanges WHERE ImprovementType = 'IMPROVEMENT_OFFSHORE_PLATFORM';
--==========================================================================================================================	
-- Belief_ImprovementYieldChanges
--==========================================================================================================================	
INSERT INTO Belief_ImprovementYieldChanges
		(BeliefType,	ImprovementType,						YieldType, Yield)
SELECT	BeliefType,		'IMPROVEMENT_DJ_ICELAND_FISHING_BOATS',	YieldType, Yield
FROM Belief_ImprovementYieldChanges WHERE ImprovementType = 'IMPROVEMENT_FISHING_BOATS';

INSERT INTO Belief_ImprovementYieldChanges
		(BeliefType,	ImprovementType,						YieldType, Yield)
SELECT	BeliefType,		'IMPROVEMENT_DJ_ICELAND_OFFSHORE_PLATFORM',	YieldType, Yield
FROM Belief_ImprovementYieldChanges WHERE ImprovementType = 'IMPROVEMENT_OFFSHORE_PLATFORM';
--==========================================================================================================================	
-- Improvement_ValidTerrains
--==========================================================================================================================
INSERT INTO Improvement_ValidTerrains
		(ImprovementType,	TerrainType)
VALUES	('IMPROVEMENT_DJ_TORFBAER',	'TERRAIN_GRASS'),
		('IMPROVEMENT_DJ_TORFBAER',	'TERRAIN_PLAINS'),
		('IMPROVEMENT_DJ_TORFBAER',	'TERRAIN_TUNDRA');
--==========================================================================================================================	
-- Builds
--==========================================================================================================================
INSERT INTO Builds
		(Type,					PrereqTech,				Time,	ImprovementType,			Description,					Help,								Recommendation,						EntityEvent,			HotKey,	OrderPriority,	IconIndex,	IconAtlas)
VALUES	('BUILD_DJ_TORFBAER',	'TECH_CIVIL_SERVICE',	600,	'IMPROVEMENT_DJ_TORFBAER',	'TXT_KEY_BUILD_DJ_TORFBAER',	'TXT_KEY_BUILD_DJ_TORFBAER_HELP',	'TXT_KEY_BUILD_DJ_TORFBAER_REC',	'ENTITY_EVENT_BUILD',	'KB_Z',	'9R',			0,			'DJ_TORFBAER_BUILD_ATLAS');

INSERT INTO Builds
		(Type,								PrereqTech, ImprovementType, 						ShowInTechTree,	Time, Recommendation, Description,	Help, Kill, CtrlDown, OrderPriority, IconIndex, IconAtlas,	HotKey, EntityEvent)
SELECT	'BUILD_DJ_ICELAND_FISHING_BOATS',	PrereqTech,	'IMPROVEMENT_DJ_ICELAND_FISHING_BOATS',	0,				Time, Recommendation, Description,	Help, Kill, CtrlDown, OrderPriority, IconIndex, IconAtlas,	HotKey,	EntityEvent
FROM Builds WHERE Type = 'BUILD_FISHING_BOATS';

INSERT INTO Builds
		(Type,									PrereqTech, ImprovementType, 							ShowInTechTree,	Time, Recommendation, Description,	Help, Kill, CtrlDown, OrderPriority, IconIndex, IconAtlas,	HotKey, EntityEvent)
SELECT	'BUILD_DJ_ICELAND_OFFSHORE_PLATFORM',	PrereqTech, 'IMPROVEMENT_DJ_ICELAND_OFFSHORE_PLATFORM',	0,				Time, Recommendation, Description,	Help, Kill, CtrlDown, OrderPriority, IconIndex, IconAtlas,	HotKey,	EntityEvent
FROM Builds WHERE Type = 'BUILD_OFFSHORE_PLATFORM';
--==========================================================================================================================	
-- BuildFeatures
--==========================================================================================================================
INSERT INTO BuildFeatures
		(BuildType,				FeatureType,		PrereqTech,		Time,	Production,	Remove)
VALUES	('BUILD_DJ_TORFBAER',	'FEATURE_FOREST',	'TECH_MINING',	600,	20,			1),
		('BUILD_DJ_TORFBAER',	'FEATURE_JUNGLE',	'TECH_MINING',	600,	20,			1),
		('BUILD_DJ_TORFBAER',	'FEATURE_MARSH',	'TECH_MASONRY',	600,	0,			1);
--==========================================================================================================================
-- UnitPromotions
--==========================================================================================================================
INSERT INTO UnitPromotions 
		(Type, 							Description, 						Help, 										Sound, 				CannotBeChosen, PortraitIndex,  IconAtlas, 			PediaType, 			PediaEntry,							AttackMod,	DefenseMod)
VALUES	('PROMOTION_DJ_AEGIR_CLASS',	'TXT_KEY_PROMOTION_DJ_AEGIR_CLASS',	'TXT_KEY_PROMOTION_DJ_AEGIR_CLASS_HELP',	'AS2D_IF_LEVELUP',	1, 				59, 			'PROMOTION_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_DJ_AEGIR_CLASS',	25,			25);
--==========================================================================================================================
-- Units
--==========================================================================================================================
INSERT INTO Units
			(Type, 					 Class, Cost, PrereqTech,	Combat, RangedCombat,	Range,	Moves, FaithCost,	RequiresFaithPurchaseEnabled, CombatClass, MilitarySupport, MilitaryProduction, Domain, Pillage, IgnoreBuildingDefense, ObsoleteTech, GoodyHutUpgradeUnitClass, XPValueAttack, XPValueDefense, Conscription,  Mechanized,	IgnoreBuildingDefense,	DefaultUnitAI, Description, 					Civilopedia, 							Help, 									Strategy,									AdvancedStartCost,	UnitArtInfo, 						UnitFlagIconOffset,	UnitFlagAtlas,						PortraitIndex, 	IconAtlas)
SELECT		('UNIT_DJ_AEGIR_CLASS'), Class, Cost, PrereqTech,	Combat, 55,				Range,	Moves, FaithCost,	RequiresFaithPurchaseEnabled, CombatClass, MilitarySupport, MilitaryProduction,	Domain, Pillage, IgnoreBuildingDefense, ObsoleteTech, GoodyHutUpgradeUnitClass, XPValueAttack, XPValueDefense, Conscription,  Mechanized,	IgnoreBuildingDefense,	DefaultUnitAI, ('TXT_KEY_UNIT_DJ_AEGIR_CLASS'),	('TXT_KEY_CIV5_DJ_AEGIR_CLASS_TEXT'), 	('TXT_KEY_UNIT_DJ_AEGIR_CLASS_HELP'), 	('TXT_KEY_UNIT_DJ_AEGIR_CLASS_STRATEGY'),	AdvancedStartCost, 	('ART_DEF_UNIT_DJ_AEGIR_CLASS'),	0,					('UNIT_FLAG_DJ_AEGIR_CLASS_ATLAS'),	2,				('DJ_ICELAND_COLOR_ATLAS')
FROM Units WHERE (Type = 'UNIT_BATTLESHIP');

INSERT INTO Units 	
		(Type, 							PrereqTech, Class, Capture, Cost, Moves, CivilianAttackPriority, Domain, ShowInPedia, 	DefaultUnitAI,	Description, Civilopedia, Help, Strategy, AdvancedStartCost, WorkRate, 	CombatLimit,	MilitarySupport,	MilitaryProduction,	PrereqResources,	Mechanized,	XPValueDefense, UnitArtInfo, UnitArtInfoEraVariation, UnitFlagIconOffset, PortraitIndex, IconAtlas)
SELECT	'UNIT_DJ_ICELAND_WORKBOAT',		PrereqTech, Class, Capture, Cost, Moves, CivilianAttackPriority, Domain, 0,				DefaultUnitAI,	Description, Civilopedia, Help, Strategy, AdvancedStartCost, WorkRate,	CombatLimit,	MilitarySupport,	MilitaryProduction,	PrereqResources,	Mechanized, XPValueDefense,	UnitArtInfo, UnitArtInfoEraVariation, UnitFlagIconOffset, PortraitIndex, IconAtlas
FROM Units WHERE Type = 'UNIT_WORKBOAT';	
--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================
INSERT INTO UnitGameplay2DScripts
			(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT		('UNIT_DJ_AEGIR_CLASS'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_BATTLESHIP');

INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 						SelectionSound, FirstSelectionSound)
SELECT	'UNIT_DJ_ICELAND_WORKBOAT',		SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_WORKBOAT';
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes
			(UnitType, 					UnitAIType)
SELECT		('UNIT_DJ_AEGIR_CLASS'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_BATTLESHIP');

INSERT INTO Unit_AITypes 	
		(UnitType, 						UnitAIType)
SELECT	'UNIT_DJ_ICELAND_WORKBOAT',		UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_WORKBOAT';
--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================
INSERT INTO Unit_ClassUpgrades
			(UnitType, 					UnitClassType)
SELECT		('UNIT_DJ_AEGIR_CLASS'), 	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_BATTLESHIP');
--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
		(UnitType, 				PromotionType)
SELECT	'UNIT_DJ_AEGIR_CLASS',	PromotionType
FROM Unit_FreePromotions WHERE UnitType = 'UNIT_BATTLESHIP';
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors
			(UnitType,					FlavorType, Flavor)
SELECT		('UNIT_DJ_AEGIR_CLASS'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_BATTLESHIP');

INSERT INTO Unit_Flavors 	
		(UnitType, 						FlavorType, Flavor)
SELECT	'UNIT_DJ_ICELAND_WORKBOAT',		FlavorType, Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_WORKBOAT';
--==========================================================================================================================	
-- Unit_Builds
--==========================================================================================================================
INSERT INTO Unit_Builds
		(UnitType,		BuildType)
VALUES	('UNIT_WORKER',	'BUILD_DJ_TORFBAER');

INSERT INTO Unit_Builds 	
		(UnitType, 						BuildType)
SELECT	'UNIT_DJ_ICELAND_WORKBOAT',		BuildType
FROM Unit_Builds WHERE UnitType = 'UNIT_WORKBOAT';

DELETE FROM Unit_Builds WHERE UnitType = 'UNIT_DJ_ICELAND_WORKBOAT' AND BuildType = 'BUILD_FISHING_BOATS';
DELETE FROM Unit_Builds WHERE UnitType = 'UNIT_DJ_ICELAND_WORKBOAT' AND BuildType = 'BUILD_OFFSHORE_PLATFORM';

INSERT INTO Unit_Builds 	
		(UnitType, 						BuildType)
VALUES	('UNIT_DJ_ICELAND_WORKBOAT', 	'BUILD_DJ_ICELAND_FISHING_BOATS'),
		('UNIT_DJ_ICELAND_WORKBOAT',	'BUILD_DJ_ICELAND_OFFSHORE_PLATFORM');
--==========================================================================================================================	
-- Diplomacy_Responses
--==========================================================================================================================	
INSERT INTO Diplomacy_Responses
		(LeaderType,			ResponseType,							Response,													Bias)
VALUES  ('LEADER_DJ_ELDJARN',	'RESPONSE_AI_DOF_BACKSTAB',				'TXT_KEY_LEADER_DJ_ELDJARN_DENOUNCE_FRIEND%',				500),
        ('LEADER_DJ_ELDJARN',	'RESPONSE_ATTACKED_HOSTILE',			'TXT_KEY_LEADER_DJ_ELDJARN_ATTACKED_HOSTILE%',				500),
        ('LEADER_DJ_ELDJARN',	'RESPONSE_DEFEATED',					'TXT_KEY_LEADER_DJ_ELDJARN_DEFEATED%',						500),
        ('LEADER_DJ_ELDJARN',	'RESPONSE_DOW_GENERIC',					'TXT_KEY_LEADER_DJ_ELDJARN_DOW_GENERIC%',					500),
        ('LEADER_DJ_ELDJARN',	'RESPONSE_FIRST_GREETING',				'TXT_KEY_LEADER_DJ_ELDJARN_FIRSTGREETING%',					500),
        ('LEADER_DJ_ELDJARN',	'RESPONSE_RESPONSE_TO_BEING_DENOUNCED',	'TXT_KEY_LEADER_DJ_ELDJARN_RESPONSE_TO_BEING_DENOUNCED%',	500),
        ('LEADER_DJ_ELDJARN',	'RESPONSE_WORK_AGAINST_SOMEONE',		'TXT_KEY_LEADER_DJ_ELDJARN_DENOUNCE%',						500),
        ('LEADER_DJ_ELDJARN',	'RESPONSE_WORK_WITH_US',				'TXT_KEY_LEADER_DJ_ELDJARN_DEC_FRIENDSHIP%',				500);