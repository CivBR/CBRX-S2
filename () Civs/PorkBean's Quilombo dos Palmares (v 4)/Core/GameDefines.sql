-- Game Defines for Palmares, by PorkBean
-- ======================================================================================================
-- CIVILIZATIONS
-- ======================================================================================================
-- Civilizations
----------------
INSERT INTO Civilizations
       (Type,                         Description,                       ShortDescription,                          Adjective,                          Civilopedia,                         CivilopediaTag,      DefaultPlayerColor,       ArtDefineTag,   ArtStyleType,  ArtStyleSuffix, ArtStylePrefix,                  IconAtlas,        PortraitIndex,  AlphaIconAtlas,               SoundtrackTag,   MapImage,                   DawnOfManQuote,                   DawnOfManImage)
SELECT 'CIVILIZATION_PB_PALMARES', 'TXT_KEY_CIV_PB_PALMARES_DESC',  'TXT_KEY_CIV_PB_PALMARES_SHORT_DESC',   'TXT_KEY_CIV_PB_PALMARES_ADJECTIVE',    'TXT_KEY_PEDIA_PB_PALMARES_TEXT',  'TXT_KEY_PEDIA_PB_PALMARES', 'PLAYERCOLOR_PB_PALMARES',     ArtDefineTag,   ArtStyleType,  ArtStyleSuffix, ArtStylePrefix,    'PALMARES_ICON_ATLAS',   0,             'PALMARES_ALPHA_ATLAS',   'Brazil',							 'Palmares_Map.dds',  'TXT_KEY_CIV5_DAWN_PB_PALMARES_TEXT',   'Palmares_DOM.dds'
FROM Civilizations WHERE Type = 'CIVILIZATION_ZULU';
-------------------------
-- Civilization_CityNames
-------------------------
INSERT INTO Civilization_CityNames
          (CivilizationType,                    CityName)
VALUES    ('CIVILIZATION_PB_PALMARES',     'TXT_KEY_CITY_NAME_PB_PALMARES_1'),
          ('CIVILIZATION_PB_PALMARES',     'TXT_KEY_CITY_NAME_PB_PALMARES_2'),
          ('CIVILIZATION_PB_PALMARES',     'TXT_KEY_CITY_NAME_PB_PALMARES_3'),
          ('CIVILIZATION_PB_PALMARES',     'TXT_KEY_CITY_NAME_PB_PALMARES_4'),
          ('CIVILIZATION_PB_PALMARES',     'TXT_KEY_CITY_NAME_PB_PALMARES_5'),
          ('CIVILIZATION_PB_PALMARES',     'TXT_KEY_CITY_NAME_PB_PALMARES_6'),
          ('CIVILIZATION_PB_PALMARES',     'TXT_KEY_CITY_NAME_PB_PALMARES_7'),
          ('CIVILIZATION_PB_PALMARES',     'TXT_KEY_CITY_NAME_PB_PALMARES_8'),
          ('CIVILIZATION_PB_PALMARES',     'TXT_KEY_CITY_NAME_PB_PALMARES_9'),
          ('CIVILIZATION_PB_PALMARES',     'TXT_KEY_CITY_NAME_PB_PALMARES_10'),
          ('CIVILIZATION_PB_PALMARES',     'TXT_KEY_CITY_NAME_PB_PALMARES_11'),
          ('CIVILIZATION_PB_PALMARES',     'TXT_KEY_CITY_NAME_PB_PALMARES_12'),
          ('CIVILIZATION_PB_PALMARES',     'TXT_KEY_CITY_NAME_PB_PALMARES_13'),
          ('CIVILIZATION_PB_PALMARES',     'TXT_KEY_CITY_NAME_PB_PALMARES_14'),
          ('CIVILIZATION_PB_PALMARES',     'TXT_KEY_CITY_NAME_PB_PALMARES_15'),
          ('CIVILIZATION_PB_PALMARES',     'TXT_KEY_CITY_NAME_PB_PALMARES_16'),
          ('CIVILIZATION_PB_PALMARES',     'TXT_KEY_CITY_NAME_PB_PALMARES_17'),
          ('CIVILIZATION_PB_PALMARES',     'TXT_KEY_CITY_NAME_PB_PALMARES_18'),
          ('CIVILIZATION_PB_PALMARES',     'TXT_KEY_CITY_NAME_PB_PALMARES_19'),
          ('CIVILIZATION_PB_PALMARES',     'TXT_KEY_CITY_NAME_PB_PALMARES_20'),
          ('CIVILIZATION_PB_PALMARES',     'TXT_KEY_CITY_NAME_PB_PALMARES_21'),
          ('CIVILIZATION_PB_PALMARES',     'TXT_KEY_CITY_NAME_PB_PALMARES_22'),
          ('CIVILIZATION_PB_PALMARES',     'TXT_KEY_CITY_NAME_PB_PALMARES_23'),
          ('CIVILIZATION_PB_PALMARES',     'TXT_KEY_CITY_NAME_PB_PALMARES_24'),
          ('CIVILIZATION_PB_PALMARES',     'TXT_KEY_CITY_NAME_PB_PALMARES_25'),
          ('CIVILIZATION_PB_PALMARES',     'TXT_KEY_CITY_NAME_PB_PALMARES_26'),
          ('CIVILIZATION_PB_PALMARES',     'TXT_KEY_CITY_NAME_PB_PALMARES_27'),
          ('CIVILIZATION_PB_PALMARES',     'TXT_KEY_CITY_NAME_PB_PALMARES_28'),
          ('CIVILIZATION_PB_PALMARES',     'TXT_KEY_CITY_NAME_PB_PALMARES_29'),
		  ('CIVILIZATION_PB_PALMARES',     'TXT_KEY_CITY_NAME_PB_PALMARES_30');
-----------------------------------
-- Civilization_FreeBuildingClasses
-----------------------------------
INSERT INTO Civilization_FreeBuildingClasses
          (CivilizationType,                BuildingClassType)
SELECT    'CIVILIZATION_PB_PALMARES',     BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE CivilizationType = 'CIVILIZATION_ZULU';
-------------------------
-- Civilization_FreeTechs
-------------------------
INSERT INTO Civilization_FreeTechs
          (CivilizationType,                TechType)
SELECT    'CIVILIZATION_PB_PALMARES',     TechType
FROM Civilization_FreeTechs WHERE CivilizationType = 'CIVILIZATION_ZULU';
-------------------------
-- Civilization_FreeUnits
-------------------------
INSERT INTO Civilization_FreeUnits
          (CivilizationType,                UnitClassType, Count, UnitAIType)
SELECT    'CIVILIZATION_PB_PALMARES',     UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE CivilizationType = 'CIVILIZATION_ZULU';
-----------------------
-- Civilization_Leaders
-----------------------
INSERT INTO Civilization_Leaders
       (CivilizationType,              LeaderheadType)
VALUES ('CIVILIZATION_PB_PALMARES', 'LEADER_PB_ZUMBI');
----------------------------------
-- Civilization_UnitClassOverrides
----------------------------------
INSERT INTO Civilization_UnitClassOverrides
       (CivilizationType,              UnitClassType,       UnitType)
VALUES ('CIVILIZATION_PB_PALMARES', 'UNITCLASS_WARRIOR', 'UNIT_PB_CAPOEIRISTA');
-------------------------
-------------------------
-- Civilization_Start_Region_Priority
-------------------------
INSERT INTO Civilization_Start_Region_Priority
       (CivilizationType,                RegionType)
VALUES ('CIVILIZATION_PB_PALMARES', 'REGION_JUNGLE');
------------------------
-- Civilization_SpyNames
------------------------
INSERT INTO Civilization_SpyNames
          (CivilizationType,                  SpyName)
VALUES    ('CIVILIZATION_PB_PALMARES',     'TXT_KEY_SPY_NAME_PB_PALMARES_0'),
          ('CIVILIZATION_PB_PALMARES',     'TXT_KEY_SPY_NAME_PB_PALMARES_1'),
          ('CIVILIZATION_PB_PALMARES',     'TXT_KEY_SPY_NAME_PB_PALMARES_2'),
          ('CIVILIZATION_PB_PALMARES',     'TXT_KEY_SPY_NAME_PB_PALMARES_3'),
          ('CIVILIZATION_PB_PALMARES',     'TXT_KEY_SPY_NAME_PB_PALMARES_4'),
          ('CIVILIZATION_PB_PALMARES',     'TXT_KEY_SPY_NAME_PB_PALMARES_5'),
          ('CIVILIZATION_PB_PALMARES',     'TXT_KEY_SPY_NAME_PB_PALMARES_6'),
          ('CIVILIZATION_PB_PALMARES',     'TXT_KEY_SPY_NAME_PB_PALMARES_7'),
          ('CIVILIZATION_PB_PALMARES',     'TXT_KEY_SPY_NAME_PB_PALMARES_8'),
          ('CIVILIZATION_PB_PALMARES',     'TXT_KEY_SPY_NAME_PB_PALMARES_9');
-- ======================================================================================================
-- LEADERS
-- ======================================================================================================
-- Leaders
----------
INSERT INTO Leaders
(Type,                                     Description,                          Civilopedia,                               CivilopediaTag,                            ArtDefineTag,                 VictoryCompetitiveness,     WonderCompetitiveness,     MinorCivCompetitiveness,     Boldness,     DiploBalance,     WarmongerHate,     DenounceWillingness,     DoFWillingness, Loyalty,     Neediness,    Forgiveness,     Chattiness, Meanness,     IconAtlas,             PortraitIndex)
VALUES    ('LEADER_PB_ZUMBI',     'TXT_KEY_LEADER_PB_ZUMBI',    'TXT_KEY_LEADER_PB_ZUMBI_PEDIA_TEXT',    'TXT_KEY_LEADER_PB_ZUMBI_PEDIA',						   'Zumbi_Scene.xml',    			6,                                        4,                         6,               4,            3,                7,                 6,                       2,                    4,           6,            4,               2,          4,           'PALMARES_ICON_ATLAS',   1);
--------------------------------
-- Leader_MajorCivApproachBiases
--------------------------------
INSERT INTO Leader_MajorCivApproachBiases
          (LeaderType,                  MajorCivApproachType,              Bias)
VALUES    ('LEADER_PB_ZUMBI',     'MAJOR_CIV_APPROACH_WAR',           6),
          ('LEADER_PB_ZUMBI',     'MAJOR_CIV_APPROACH_HOSTILE',       5),
          ('LEADER_PB_ZUMBI',     'MAJOR_CIV_APPROACH_DECEPTIVE',     3),
          ('LEADER_PB_ZUMBI',     'MAJOR_CIV_APPROACH_GUARDED',       7),
          ('LEADER_PB_ZUMBI',     'MAJOR_CIV_APPROACH_AFRAID',        3),
          ('LEADER_PB_ZUMBI',     'MAJOR_CIV_APPROACH_FRIENDLY',      3),
          ('LEADER_PB_ZUMBI',     'MAJOR_CIV_APPROACH_NEUTRAL',       7);
--------------------------------
-- Leader_MinorCivApproachBiases
--------------------------------
INSERT INTO Leader_MinorCivApproachBiases
          (LeaderType,                     MinorCivApproachType,              Bias)
VALUES    ('LEADER_PB_ZUMBI',     'MINOR_CIV_APPROACH_IGNORE',        7),
          ('LEADER_PB_ZUMBI',     'MINOR_CIV_APPROACH_FRIENDLY',      3),
          ('LEADER_PB_ZUMBI',     'MINOR_CIV_APPROACH_PROTECTIVE',    6),
          ('LEADER_PB_ZUMBI',     'MINOR_CIV_APPROACH_CONQUEST',      4),
          ('LEADER_PB_ZUMBI',     'MINOR_CIV_APPROACH_BULLY',         5);
-----------------
-- Leader_Flavors
-----------------
INSERT INTO Leader_Flavors
          (LeaderType,                  FlavorType,                        Flavor)
VALUES    ('LEADER_PB_ZUMBI',     'FLAVOR_OFFENSE',                   6),
          ('LEADER_PB_ZUMBI',     'FLAVOR_DEFENSE',                   8),
          ('LEADER_PB_ZUMBI',     'FLAVOR_CITY_DEFENSE',              5),
          ('LEADER_PB_ZUMBI',     'FLAVOR_MILITARY_TRAINING',         7),
          ('LEADER_PB_ZUMBI',     'FLAVOR_RECON',                     5),
          ('LEADER_PB_ZUMBI',     'FLAVOR_RANGED',                    6),
          ('LEADER_PB_ZUMBI',     'FLAVOR_MOBILE',                    5),
          ('LEADER_PB_ZUMBI',     'FLAVOR_NAVAL',                     5),
          ('LEADER_PB_ZUMBI',     'FLAVOR_NAVAL_RECON',               3),
          ('LEADER_PB_ZUMBI',     'FLAVOR_NAVAL_GROWTH',              4),
          ('LEADER_PB_ZUMBI',     'FLAVOR_NAVAL_TILE_IMPROVEMENT',    5),
          ('LEADER_PB_ZUMBI',     'FLAVOR_AIR',                       7),
          ('LEADER_PB_ZUMBI',     'FLAVOR_EXPANSION',                 7),
          ('LEADER_PB_ZUMBI',     'FLAVOR_GROWTH',                    6),
          ('LEADER_PB_ZUMBI',     'FLAVOR_TILE_IMPROVEMENT',          6),
          ('LEADER_PB_ZUMBI',     'FLAVOR_INFRASTRUCTURE',            5),
          ('LEADER_PB_ZUMBI',     'FLAVOR_PRODUCTION',                7),
          ('LEADER_PB_ZUMBI',     'FLAVOR_GOLD',                      5),
          ('LEADER_PB_ZUMBI',     'FLAVOR_SCIENCE',                   5),
          ('LEADER_PB_ZUMBI',     'FLAVOR_CULTURE',                   7),
          ('LEADER_PB_ZUMBI',     'FLAVOR_HAPPINESS',                 6),
          ('LEADER_PB_ZUMBI',     'FLAVOR_GREAT_PEOPLE',              4),
          ('LEADER_PB_ZUMBI',     'FLAVOR_WONDER',                    4),
          ('LEADER_PB_ZUMBI',     'FLAVOR_RELIGION',                  3),
          ('LEADER_PB_ZUMBI',     'FLAVOR_DIPLOMACY',                 3),
          ('LEADER_PB_ZUMBI',     'FLAVOR_SPACESHIP',                 3),
          ('LEADER_PB_ZUMBI',     'FLAVOR_WATER_CONNECTION',          5),
          ('LEADER_PB_ZUMBI',     'FLAVOR_NUKE',                      5),
          ('LEADER_PB_ZUMBI',     'FLAVOR_USE_NUKE',                  4),
          ('LEADER_PB_ZUMBI',     'FLAVOR_ESPIONAGE',                 6),
          ('LEADER_PB_ZUMBI',     'FLAVOR_ANTIAIR',                   7),
          ('LEADER_PB_ZUMBI',     'FLAVOR_AIRLIFT',                   6),
          ('LEADER_PB_ZUMBI',     'FLAVOR_I_TRADE_DESTINATION',       5),
          ('LEADER_PB_ZUMBI',     'FLAVOR_I_TRADE_ORIGIN',            5),
          ('LEADER_PB_ZUMBI',     'FLAVOR_I_SEA_TRADE_ROUTE',         5),
          ('LEADER_PB_ZUMBI',     'FLAVOR_I_LAND_TRADE_ROUTE',        5),
          ('LEADER_PB_ZUMBI',     'FLAVOR_ARCHAEOLOGY',               5),
          ('LEADER_PB_ZUMBI',     'FLAVOR_AIR_CARRIER',               2);
----------------
-- Leader_Traits
----------------
INSERT INTO Leader_Traits
       (LeaderType,              TraitType)
VALUES ('LEADER_PB_ZUMBI',   'TRAIT_PB_ANGOLA_JANGA');
-- ======================================================================================================
-- TRAITS
-- ======================================================================================================
-- Traits
---------
INSERT INTO Traits
       (Type,                   Description,                  ShortDescription)
VALUES ('TRAIT_PB_ANGOLA_JANGA',    'TXT_KEY_TRAIT_PB_ANGOLA_JANGA',   'TXT_KEY_TRAIT_PB_ANGOLA_JANGA_SHORT');
--==========================================================================================================================
-- UNITS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- Units
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Units 	
		(Type, 						Class, CombatClass, PrereqTech, Cost, Combat, FaithCost, RequiresFaithPurchaseEnabled, Moves, CivilianAttackPriority, Special, Domain, DefaultUnitAI,	Description, 					Help, 								Strategy, 								 Civilopedia, 							ShowInPedia,	OneShotTourism, OneShotTourismPercentOthers, AdvancedStartCost, WorkRate, CombatLimit,  GoldenAgeTurns,  XPValueAttack, XPValueDefense, Conscription, UnitArtInfo, 					UnitFlagAtlas, 						UnitFlagIconOffset, IconAtlas,			PortraitIndex,	MoveRate)
SELECT	'UNIT_PB_CAPOEIRISTA',		Class, CombatClass, PrereqTech, Cost, Combat, FaithCost, RequiresFaithPurchaseEnabled, Moves, CivilianAttackPriority, Special, Domain, DefaultUnitAI,	'TXT_KEY_UNIT_PB_CAPOEIRISTA',	'TXT_KEY_UNIT_PB_CAPOEIRISTA_HELP',	'TXT_KEY_UNIT_PB_CAPOEIRISTA_STRATEGY', 	 'TXT_KEY_UNIT_PB_CAPOEIRISTA_TEXT',		ShowInPedia,	OneShotTourism, OneShotTourismPercentOthers, AdvancedStartCost, WorkRate, CombatLimit,  GoldenAgeTurns,  XPValueAttack, XPValueDefense, Conscription, 'ART_DEF_UNIT_PB_CAPO',	'CAPOEIRISTA_FLAG',	0,					'PALMARES_ICON_ATLAS',	2,				MoveRate
FROM Units WHERE Type = 'UNIT_WARRIOR';    
--------------------------------------------------------------------------------------------------------------------------
-- UnitGameplay2DScripts
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT	'UNIT_PB_CAPOEIRISTA',		SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_WARRIOR';
--------------------------------------------------------------------------------------------------------------------------
-- Unit_AITypes
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_AITypes 	
		(UnitType, 					UnitAIType)
SELECT	'UNIT_PB_CAPOEIRISTA',		UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_WARRIOR';
--------------------------------------------------------------------------------------------------------------------------
-- Unit_Flavors
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_Flavors 	
		(UnitType, 					FlavorType, Flavor)
SELECT	'UNIT_PB_CAPOEIRISTA',		FlavorType, Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_WARRIOR';
--------------------------------------------------------------------------------------------------------------------------
-- Unit_FreePromotions
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_FreePromotions 	
		(UnitType, 					PromotionType)
SELECT	'UNIT_PB_CAPOEIRISTA',		PromotionType
FROM Unit_FreePromotions WHERE UnitType = 'UNIT_WARRIOR';

INSERT INTO Unit_FreePromotions
		(UnitType, PromotionType)
VALUES	('UNIT_PB_CAPOEIRISTA', 'PROMOTION_PB_DOUBLE_MOVES');
--------------------------------------------------------------------------------------------------------------------------
-- Unit_ClassUpgrades
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 					UnitClassType)
SELECT	'UNIT_PB_CAPOEIRISTA',		UnitClassType
FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_WARRIOR';
-----------------
-- UnitPromotions
-----------------
INSERT INTO UnitPromotions
(Type,                                   Description,                             Help,                     Sound,													CannotBeChosen, LostWithUpgrade, CaptureDefeatedEnemy,		IgnoreZOC,		DefenseMod,		MovesChange,    PortraitIndex,    IconAtlas,                         PediaType,             PediaEntry)
VALUES    ('PROMOTION_PB_DOUBLE_MOVES', 'TXT_KEY_PROMOTION_PB_DOUBLE_MOVES',     'TXT_KEY_PROMOTION_PB_DOUBLE_MOVES_HELP',    'AS2D_IF_LEVELUP',    				1,					0,				0,							 0,					 0,				0,					56,            'PROMOTION_ATLAS',     'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_PB_DOUBLE_MOVES'),
		  ('PROMOTION_PB_ESCAPE_ZOC', 'TXT_KEY_PROMOTION_PB_ESCAPE_ZOC',     'TXT_KEY_PROMOTION_PB_ESCAPE_ZOC_HELP',    'AS2D_IF_LEVELUP',    					1,					0,				0,						     1,					 0,				1,					33,            'PROMOTION_ATLAS',     'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_PB_ESCAPE_ZOC'),
		  ('PROMOTION_PB_MOCAMBO_CAPTURE', 'TXT_KEY_PROMOTION_PB_MOCAMBO_CAPTURE',     'TXT_KEY_PROMOTION_PB_MOCAMBO_CAPTURE_HELP',    'AS2D_IF_LEVELUP',    	1,					0,				1,						     0,					50,				0,					9,            'EXPANSION2_PROMOTION_ATLAS',     'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_PB_MOCAMBO_CAPTURE');
-----------------
-- UnitPromotions_Features
-----------------
INSERT INTO UnitPromotions_Features
(PromotionType,                                   FeatureType,       DoubleMove)
VALUES    ('PROMOTION_PB_DOUBLE_MOVES', 		'FEATURE_JUNGLE',    1);
--------------
-- Unit_Builds
--------------
INSERT INTO Unit_Builds
        (UnitType,           BuildType)
VALUES  ('UNIT_WORKER',     'BUILD_PB_MOCAMBO');
--=======================================================================================================
-- BUILDS
--=======================================================================================================
-- Builds
---------
INSERT INTO Builds
(Type,                                 PrereqTech,         ImprovementType,            Time,  Recommendation,                    Description,            Help,                              CtrlDown,    OrderPriority,    IconIndex, IconAtlas,              HotKey,    EntityEvent)
VALUES        ('BUILD_PB_MOCAMBO',    'TECH_GUILDS',    'IMPROVEMENT_PB_MOCAMBO',    700, 'TXT_KEY_BUILD_PB_MOCAMBO_REC', 'TXT_KEY_BUILD_PB_MOCAMBO',  'TXT_KEY_BUILD_PB_MOCAMBO_HELP',    0,           98,               0,        'ACTION_MOCAMBO',    'KB_F',    'ENTITY_EVENT_BUILD');
--=======================================================================================================
-- IMPROVEMENTS
--=======================================================================================================
-- Improvements
---------------
INSERT INTO Improvements
(Type,                                      SpecificCivRequired, CivilizationType,                 GoldMaintenance,        Description,                       Civilopedia,										Help,                                    		ArtDefineTag,                    BuildableOnResources,    DestroyedWhenPillaged,    PillageGold,    DefenseModifier,	RequiresFeature,		OutsideBorders,    PortraitIndex,    IconAtlas)
VALUES        ('IMPROVEMENT_PB_MOCAMBO',    1,                  'CIVILIZATION_PB_PALMARES',   				0,              'TXT_KEY_IMPROVEMENT_PB_MOCAMBO',  'TXT_KEY_CIV5_IMPROVEMENTS_PB_MOCAMBO_TEXT',    'TXT_KEY_CIV5_IMPROVEMENTS_PB_MOCAMBO_HELP', 'ART_DEF_IMPROVEMENT_MOCAMBO',    0,                       0,                        10,             0,								1, 						1,                 3,        'PALMARES_ICON_ATLAS');
----------------------------
-- Improvement_Yields
----------------------------
INSERT INTO Improvement_Yields
              (ImprovementType,                YieldType, 			Yield)
VALUES        ('IMPROVEMENT_PB_MOCAMBO',      'YIELD_CULTURE', 		1),
			  ('IMPROVEMENT_PB_MOCAMBO',      'YIELD_PRODUCTION', 		1);
----------------------------
-- Improvement_ValidFeatures
----------------------------
INSERT INTO Improvement_ValidFeatures
              (ImprovementType,                FeatureType)
VALUES        ('IMPROVEMENT_PB_MOCAMBO',      'FEATURE_FOREST'),
			  ('IMPROVEMENT_PB_MOCAMBO',      'FEATURE_JUNGLE');