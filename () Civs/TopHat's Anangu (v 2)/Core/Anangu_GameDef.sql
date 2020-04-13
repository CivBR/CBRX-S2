-- Anangu
-- ======================================================================================================
-- CIVILIZATIONS
-- ======================================================================================================
-- Civilizations
----------------
INSERT INTO Civilizations
       (Type,                      Description,                     ShortDescription,                   Adjective,                       Civilopedia,                        CivilopediaTag, DefaultPlayerColor,  ArtDefineTag,    ArtStyleType,  ArtStyleSuffix, ArtStylePrefix,           IconAtlas,      PortraitIndex,  AlphaIconAtlas,             SoundtrackTag,   MapImage,                   DawnOfManQuote,                   DawnOfManImage)
SELECT 'CIVILIZATION_THP_ANANGU', 'TXT_KEY_CIV_THP_ANANGU_DESC',  'TXT_KEY_CIV_THP_ANANGU_SHORT_DESC',   'TXT_KEY_CIV_THP_ANANGU_ADJECTIVE',    'TXT_KEY_PEDIA_THP_ANANGU_TEXT',  'TXT_KEY_PEDIA_THP_ANANGU', 'PLAYERCOLOR_THP_ANANGU',  ArtDefineTag,   ArtStyleType,   ArtStyleSuffix, ArtStylePrefix, 'THP_ANANGU_ATLAS',   0,             'THP_ANANGU_ALPHA_ATLAS',   SoundtrackTag,  'Map_Anangu.dds',  'TXT_KEY_CIV5_DAWN_THP_ANANGU_TEXT',   'Tjilpi_DOM.dds'
FROM Civilizations WHERE Type = 'CIVILIZATION_SONGHAI';
-------------------------
-- Civilization_CityNames
-------------------------
INSERT INTO Civilization_CityNames
          (CivilizationType,               CityName)
VALUES    ('CIVILIZATION_THP_ANANGU',     'TXT_KEY_CITY_NAME_THP_ANANGU_1'),
          ('CIVILIZATION_THP_ANANGU',     'TXT_KEY_CITY_NAME_THP_ANANGU_2'),
          ('CIVILIZATION_THP_ANANGU',     'TXT_KEY_CITY_NAME_THP_ANANGU_3'),
          ('CIVILIZATION_THP_ANANGU',     'TXT_KEY_CITY_NAME_THP_ANANGU_4'),
          ('CIVILIZATION_THP_ANANGU',     'TXT_KEY_CITY_NAME_THP_ANANGU_5'),
          ('CIVILIZATION_THP_ANANGU',     'TXT_KEY_CITY_NAME_THP_ANANGU_6'),
          ('CIVILIZATION_THP_ANANGU',     'TXT_KEY_CITY_NAME_THP_ANANGU_7'),
          ('CIVILIZATION_THP_ANANGU',     'TXT_KEY_CITY_NAME_THP_ANANGU_8'),
          ('CIVILIZATION_THP_ANANGU',     'TXT_KEY_CITY_NAME_THP_ANANGU_9'),
          ('CIVILIZATION_THP_ANANGU',     'TXT_KEY_CITY_NAME_THP_ANANGU_10'),
          ('CIVILIZATION_THP_ANANGU',     'TXT_KEY_CITY_NAME_THP_ANANGU_11'),
          ('CIVILIZATION_THP_ANANGU',     'TXT_KEY_CITY_NAME_THP_ANANGU_12'),
          ('CIVILIZATION_THP_ANANGU',     'TXT_KEY_CITY_NAME_THP_ANANGU_13'),
          ('CIVILIZATION_THP_ANANGU',     'TXT_KEY_CITY_NAME_THP_ANANGU_14'),
          ('CIVILIZATION_THP_ANANGU',     'TXT_KEY_CITY_NAME_THP_ANANGU_15'),
          ('CIVILIZATION_THP_ANANGU',     'TXT_KEY_CITY_NAME_THP_ANANGU_16'),
          ('CIVILIZATION_THP_ANANGU',     'TXT_KEY_CITY_NAME_THP_ANANGU_17'),
          ('CIVILIZATION_THP_ANANGU',     'TXT_KEY_CITY_NAME_THP_ANANGU_18'),
          ('CIVILIZATION_THP_ANANGU',     'TXT_KEY_CITY_NAME_THP_ANANGU_19'),
          ('CIVILIZATION_THP_ANANGU',     'TXT_KEY_CITY_NAME_THP_ANANGU_20'),
          ('CIVILIZATION_THP_ANANGU',     'TXT_KEY_CITY_NAME_THP_ANANGU_21'),
          ('CIVILIZATION_THP_ANANGU',     'TXT_KEY_CITY_NAME_THP_ANANGU_22'),
          ('CIVILIZATION_THP_ANANGU',     'TXT_KEY_CITY_NAME_THP_ANANGU_23'),
          ('CIVILIZATION_THP_ANANGU',     'TXT_KEY_CITY_NAME_THP_ANANGU_24');
-----------------------------------
-- Civilization_FreeBuildingClasses
-----------------------------------
INSERT INTO Civilization_FreeBuildingClasses
          (CivilizationType,             BuildingClassType)
SELECT    'CIVILIZATION_THP_ANANGU',     BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE CivilizationType = 'CIVILIZATION_SONGHAI';
-------------------------
-- Civilization_FreeTechs
-------------------------
INSERT INTO Civilization_FreeTechs
          (CivilizationType,             TechType)
SELECT    'CIVILIZATION_THP_ANANGU',     TechType
FROM Civilization_FreeTechs WHERE CivilizationType = 'CIVILIZATION_SONGHAI';
-------------------------
-- Civilization_FreeUnits
-------------------------
INSERT INTO Civilization_FreeUnits
          (CivilizationType,             UnitClassType, Count, UnitAIType)
SELECT    'CIVILIZATION_THP_ANANGU',     UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE CivilizationType = 'CIVILIZATION_SONGHAI';
-----------------------
-- Civilization_Leaders
-----------------------
INSERT INTO Civilization_Leaders
       (CivilizationType,           LeaderheadType)
VALUES ('CIVILIZATION_THP_ANANGU', 'LEADER_THP_TJILPI');
--------------------------------------
-- Civilization_BuildingClassOverrides
--------------------------------------
INSERT INTO Civilization_BuildingClassOverrides
       (CivilizationType,           BuildingClassType,      BuildingType)
VALUES ('CIVILIZATION_THP_ANANGU', 'BUILDINGCLASS_SHRINE', 'BUILDING_THP_NYINTIRINGKUPAI');
----------------------------------
-- Civilization_UnitClassOverrides
----------------------------------
INSERT INTO Civilization_UnitClassOverrides
       (CivilizationType,           UnitClassType,       UnitType)
VALUES ('CIVILIZATION_THP_ANANGU', 'UNITCLASS_SCOUT', 'UNIT_THP_WARMALA');
-------------------------
-- Civilization_Religions
-------------------------
INSERT INTO Civilization_Religions
       (CivilizationType,           ReligionType)
VALUES ('CIVILIZATION_THP_ANANGU', 'RELIGION_PROTESTANTISM');
------------------------
-- Civilization_SpyNames
------------------------
INSERT INTO Civilization_SpyNames
          (CivilizationType,               SpyName)
VALUES    ('CIVILIZATION_THP_ANANGU',     'TXT_KEY_SPY_NAME_THP_ANANGU_0'),
          ('CIVILIZATION_THP_ANANGU',     'TXT_KEY_SPY_NAME_THP_ANANGU_1'),
          ('CIVILIZATION_THP_ANANGU',     'TXT_KEY_SPY_NAME_THP_ANANGU_2'),
          ('CIVILIZATION_THP_ANANGU',     'TXT_KEY_SPY_NAME_THP_ANANGU_3'),
          ('CIVILIZATION_THP_ANANGU',     'TXT_KEY_SPY_NAME_THP_ANANGU_4'),
          ('CIVILIZATION_THP_ANANGU',     'TXT_KEY_SPY_NAME_THP_ANANGU_5'),
          ('CIVILIZATION_THP_ANANGU',     'TXT_KEY_SPY_NAME_THP_ANANGU_6'),
          ('CIVILIZATION_THP_ANANGU',     'TXT_KEY_SPY_NAME_THP_ANANGU_7'),
          ('CIVILIZATION_THP_ANANGU',     'TXT_KEY_SPY_NAME_THP_ANANGU_8'),
          ('CIVILIZATION_THP_ANANGU',     'TXT_KEY_SPY_NAME_THP_ANANGU_9');
-------------------------------------
-- Civilization_Start_Region_Priority
-------------------------------------
INSERT INTO Civilization_Start_Region_Priority
              (CivilizationType,                   RegionType)
VALUES        ('CIVILIZATION_THP_ANANGU',         'REGION_DESERT');
-- ======================================================================================================
-- LEADERS
-- ======================================================================================================
-- Leaders
----------
INSERT INTO Leaders
(Type,                                Description,                     Civilopedia,                      CivilopediaTag,                          ArtDefineTag,                VictoryCompetitiveness,     WonderCompetitiveness,     MinorCivCompetitiveness,     Boldness,     DiploBalance,     WarmongerHate,     DenounceWillingness,     DoFWillingness, Loyalty,     Neediness,    Forgiveness,     Chattiness, Meanness,     IconAtlas,             PortraitIndex)
VALUES    ('LEADER_THP_TJILPI',     'TXT_KEY_LEADER_THP_TJILPI',    'TXT_KEY_LEADER_THP_TJILPI_PEDIA_TEXT',    'TXT_KEY_LEADER_THP_TJILPI_PEDIA',    'Leaderhead_Tjilpi.xml',     3,                                    6,                         7,                           4,            4,                9,                 7,                       5,              8,           2,            4,               2,          4,             'THP_ANANGU_ATLAS',   1);
--------------------------------
-- Leader_MajorCivApproachBiases
--------------------------------
INSERT INTO Leader_MajorCivApproachBiases
          (LeaderType,                MajorCivApproachType,              Bias)
VALUES    ('LEADER_THP_TJILPI',     'MAJOR_CIV_APPROACH_WAR',           4),
          ('LEADER_THP_TJILPI',     'MAJOR_CIV_APPROACH_HOSTILE',       6),
          ('LEADER_THP_TJILPI',     'MAJOR_CIV_APPROACH_DECEPTIVE',     1),
          ('LEADER_THP_TJILPI',     'MAJOR_CIV_APPROACH_GUARDED',       8),
          ('LEADER_THP_TJILPI',     'MAJOR_CIV_APPROACH_AFRAID',        6),
          ('LEADER_THP_TJILPI',     'MAJOR_CIV_APPROACH_FRIENDLY',      4),
          ('LEADER_THP_TJILPI',     'MAJOR_CIV_APPROACH_NEUTRAL',       8);
--------------------------------
-- Leader_MinorCivApproachBiases
--------------------------------
INSERT INTO Leader_MinorCivApproachBiases
          (LeaderType,                MinorCivApproachType,              Bias)
VALUES    ('LEADER_THP_TJILPI',     'MINOR_CIV_APPROACH_IGNORE',        8),
          ('LEADER_THP_TJILPI',     'MINOR_CIV_APPROACH_FRIENDLY',      6),
          ('LEADER_THP_TJILPI',     'MINOR_CIV_APPROACH_PROTECTIVE',    9),
          ('LEADER_THP_TJILPI',     'MINOR_CIV_APPROACH_CONQUEST',      3),
          ('LEADER_THP_TJILPI',     'MINOR_CIV_APPROACH_BULLY',         4);
-----------------
-- Leader_Flavors
-----------------
INSERT INTO Leader_Flavors
          (LeaderType,               FlavorType,                        Flavor)
VALUES    ('LEADER_THP_TJILPI',     'FLAVOR_OFFENSE',                   4),
          ('LEADER_THP_TJILPI',     'FLAVOR_DEFENSE',                   6),
          ('LEADER_THP_TJILPI',     'FLAVOR_CITY_DEFENSE',              6),
          ('LEADER_THP_TJILPI',     'FLAVOR_MILITARY_TRAINING',         4),
          ('LEADER_THP_TJILPI',     'FLAVOR_RECON',                     10),
          ('LEADER_THP_TJILPI',     'FLAVOR_RANGED',                    7),
          ('LEADER_THP_TJILPI',     'FLAVOR_MOBILE',                    8),
          ('LEADER_THP_TJILPI',     'FLAVOR_NAVAL',                     2),
          ('LEADER_THP_TJILPI',     'FLAVOR_NAVAL_RECON',               5),
          ('LEADER_THP_TJILPI',     'FLAVOR_NAVAL_GROWTH',              3),
          ('LEADER_THP_TJILPI',     'FLAVOR_NAVAL_TILE_IMPROVEMENT',    3),
          ('LEADER_THP_TJILPI',     'FLAVOR_AIR',                       8),
          ('LEADER_THP_TJILPI',     'FLAVOR_EXPANSION',                 7),
          ('LEADER_THP_TJILPI',     'FLAVOR_GROWTH',                    6),
          ('LEADER_THP_TJILPI',     'FLAVOR_TILE_IMPROVEMENT',          6),
          ('LEADER_THP_TJILPI',     'FLAVOR_INFRASTRUCTURE',            5),
          ('LEADER_THP_TJILPI',     'FLAVOR_PRODUCTION',                5),
          ('LEADER_THP_TJILPI',     'FLAVOR_GOLD',                      3),
          ('LEADER_THP_TJILPI',     'FLAVOR_SCIENCE',                   3),
          ('LEADER_THP_TJILPI',     'FLAVOR_CULTURE',                   8),
          ('LEADER_THP_TJILPI',     'FLAVOR_HAPPINESS',                 7),
          ('LEADER_THP_TJILPI',     'FLAVOR_GREAT_PEOPLE',              5),
          ('LEADER_THP_TJILPI',     'FLAVOR_WONDER',                    6),
          ('LEADER_THP_TJILPI',     'FLAVOR_RELIGION',                  9),
          ('LEADER_THP_TJILPI',     'FLAVOR_DIPLOMACY',                 3),
          ('LEADER_THP_TJILPI',     'FLAVOR_SPACESHIP',                 7),
          ('LEADER_THP_TJILPI',     'FLAVOR_WATER_CONNECTION',          2),
          ('LEADER_THP_TJILPI',     'FLAVOR_NUKE',                      3),
          ('LEADER_THP_TJILPI',     'FLAVOR_USE_NUKE',                  1),
          ('LEADER_THP_TJILPI',     'FLAVOR_ESPIONAGE',                 4),
          ('LEADER_THP_TJILPI',     'FLAVOR_AIRLIFT',                   7),
          ('LEADER_THP_TJILPI',     'FLAVOR_I_TRADE_DESTINATION',       5),
          ('LEADER_THP_TJILPI',     'FLAVOR_I_TRADE_ORIGIN',            8),
          ('LEADER_THP_TJILPI',     'FLAVOR_I_SEA_TRADE_ROUTE',         1),
          ('LEADER_THP_TJILPI',     'FLAVOR_I_LAND_TRADE_ROUTE',        8),
          ('LEADER_THP_TJILPI',     'FLAVOR_ARCHAEOLOGY',               9),
          ('LEADER_THP_TJILPI',     'FLAVOR_AIR_CARRIER',               4);
----------------
-- Leader_Traits
----------------
INSERT INTO Leader_Traits
       (LeaderType,             TraitType)
VALUES ('LEADER_THP_TJILPI',   'TRAIT_THP_ANANGU');
-- ======================================================================================================
-- TRAITS
-- ======================================================================================================
-- Traits
---------
INSERT INTO Traits
       (Type,                   Description,                   ShortDescription)
VALUES ('TRAIT_THP_ANANGU',    'TXT_KEY_TRAIT_THP_ANANGU',    'TXT_KEY_TRAIT_THP_ANANGU_SHORT');
-- ======================================================================================================
-- BUILDINGS
-- ======================================================================================================
-- BuildingClasses
------------------
INSERT INTO BuildingClasses
        (Type,                               DefaultBuilding,                    Description)
VALUES  ('BUILDINGCLASS_THP_ANANGU_DUMMY',  'BUILDING_THP_ANANGU_EXCE_DUMMY',   'TXT_KEY_BLDG_THP_ANANGU_EXCE_DUMMY'),
        ('BUILDINGCLASS_THP_ANANGU_YIELDS', 'BUILDING_THP_ANANGU_YIELDS',       'TXT_KEY_BLDG_ANANGU_YIELDS'),
        ('BUILDINGCLASS_THP_ANANGU_DREAM',  'BUILDING_THP_ANANGU_DREAM_DUMMY',  'TXT_KEY_BLDG_THP_ANANGU_DREAM_DUMMY');
------------
-- Buildings
------------
INSERT INTO Buildings
(Type,                                 BuildingClass,        TrainedFreePromotion,      Cost, Espionage, EspionageModifier, SpecialistType, SpecialistCount, GoldMaintenance, PrereqTech,    Description,                                              Help,                                     Civilopedia,                                              Strategy,                                 ArtDefineTag, MinAreaSize, NeverCapture, Espionage, EspionageModifier, HurryCostModifier, PortraitIndex, IconAtlas)
SELECT    'BUILDING_THP_NYINTIRINGKUPAI',    BuildingClass, 'PROMOTION_SURVIVALISM_1',  Cost, Espionage, EspionageModifier, SpecialistType, SpecialistCount, GoldMaintenance,  PrereqTech,   'TXT_KEY_BLDG_THP_NYINTIRINGKUPAI',    'TXT_KEY_BLDG_THP_NYINTIRINGKUPAI_HELP',    'TXT_KEY_BLDG_THP_NYINTIRINGKUPAI_TEXT',    'TXT_KEY_BLDG_THP_NYINTIRINGKUPAI_STRATEGY',    ArtDefineTag, MinAreaSize, NeverCapture, Espionage, EspionageModifier, HurryCostModifier, 3,            'THP_ANANGU_ATLAS'
FROM Buildings WHERE Type = 'BUILDING_SHRINE';

INSERT INTO Buildings
(Type,                                   BuildingClass,                        TrainedFreePromotion,    SpecialistCount, GreatWorkCount, Cost, FaithCost,         Description,                         Help,                                  NeverCapture)
VALUES    ('BUILDING_THP_ANANGU_EXCE_DUMMY', 'BUILDINGCLASS_THP_ANANGU_DUMMY', 'PROMOTION_JFD_DESERT_IMMUNITY',        0,               -1,             -1,   -1,               'TXT_KEY_BLDG_THP_ANANGU_EXCE_DUMMY',    'TXT_KEY_BLDG_THP_ANANGU_EXCE_DUMMY',   1);

INSERT INTO Buildings
(Type,                                         BuildingClass,                           Happiness,                            SpecialistCount, GreatWorkCount, Cost, FaithCost,         Description,                         Help,                                  NeverCapture)
VALUES    ('BUILDING_THP_ANANGU_DREAM_DUMMY', 'BUILDINGCLASS_THP_ANANGU_DREAM',        2,                               0,               -1,             -1,   -1,               'TXT_KEY_BLDG_THP_ANANGU_DREAM_DUMMY',    'TXT_KEY_BLDG_THP_ANANGU_DREAM_DUMMY',   1);

INSERT INTO Buildings
(Type,                                         BuildingClass,               SpecialistCount, GreatWorkCount, Cost, FaithCost,         Description,                          Help,                              NeverCapture)
VALUES    ('BUILDING_THP_ANANGU_YIELDS', 'BUILDINGCLASS_THP_ANANGU_YIELDS', 0,               -1,             -1,   -1,               'TXT_KEY_BLDG_THP_ANANGU_YIELDS',    'TXT_KEY_BLDG_THP_ANANGU_YIELDS',   1);
-------------------------------
-- Building_ClassesNeededInCity
-------------------------------
INSERT INTO Building_ClassesNeededInCity
       (BuildingType,                  BuildingClassType)
SELECT 'BUILDING_THP_NYINTIRINGKUPAI', BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_SHRINE';
-------------------
-- Building_Flavors
-------------------
INSERT INTO Building_Flavors
          (BuildingType,                     FlavorType,    Flavor)
SELECT    'BUILDING_THP_NYINTIRINGKUPAI',    FlavorType,    Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_SHRINE';

INSERT INTO Building_Flavors
        (BuildingType,                       FlavorType,                Flavor)
VALUES  ('BUILDING_THP_NYINTIRINGKUPAI',    'FLAVOR_CULTURE',           15),
        ('BUILDING_THP_NYINTIRINGKUPAI',    'FLAVOR_MILITARY_TRAINING', 5);
------------------------
-- Building_YieldChanges
------------------------
INSERT INTO Building_YieldChanges
          (BuildingType,                     YieldType,    Yield)
SELECT    'BUILDING_THP_NYINTIRINGKUPAI',    YieldType,    Yield
FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_SHRINE';

INSERT INTO Building_YieldChanges
        (BuildingType,                       YieldType,         Yield)
VALUES  ('BUILDING_THP_ANANGU_DREAM_DUMMY', 'YIELD_FAITH',      2),
        ('BUILDING_THP_ANANGU_YIELDS',      'YIELD_FAITH',      1),
        ('BUILDING_THP_ANANGU_YIELDS',      'YIELD_CULTURE',    1);
--------------------------
-- Building_YieldModifiers
--------------------------
INSERT INTO Building_YieldModifiers
          (BuildingType,                     YieldType,    Yield)
SELECT    'BUILDING_THP_NYINTIRINGKUPAI',    YieldType,    Yield
FROM Building_YieldModifiers WHERE BuildingType = 'BUILDING_SHRINE';
-- ======================================================================================================
-- UNITS
-- ======================================================================================================
-- UnitPromotions
-----------------
INSERT INTO UnitPromotions
(Type,                                               Description,                                             Help,                                              Sound,                CannotBeChosen, PortraitIndex,     IconAtlas,            PediaType,          PediaEntry)
VALUES    ('PROMOTION_THP_ANANGU_DESERT_SPEED',         'TXT_KEY_PROMOTION_THP_ANANGU_DESERT_SPEED',     'TXT_KEY_PROMOTION_THP_ANANGU_DESERT_SPEED_HELP',     'AS2D_IF_LEVELUP',     1,              59,             'ABILITY_ATLAS',     'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_THP_ANANGU_DESERT_SPEED'),
('PROMOTION_THP_WARMALA',         'TXT_KEY_PROMOTION_THP_WARMALA',     'TXT_KEY_PROMOTION_THP_WARMALA_HELP',     'AS2D_IF_LEVELUP',     1,              59,             'ABILITY_ATLAS',     'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_THP_WARMALA');
--------------------------
-- UnitPromotions_Terrains
--------------------------
INSERT INTO UnitPromotions_Terrains
        (PromotionType,                          TerrainType,       DoubleMove)
VALUES  ('PROMOTION_THP_ANANGU_DESERT_SPEED',   'TERRAIN_DESERT',   1);
--------
-- Units
--------
INSERT INTO Units
(Type,                           Class,    CombatClass, WorkRate, PrereqTech, CanBuyCityState, Combat, RangedCombat,    Range, FaithCost, RequiresFaithPurchaseEnabled, Cost, Moves, Domain, DefaultUnitAI, CivilianAttackPriority, Special, Description,                   Help,                                             Strategy,                                 Civilopedia,          MilitarySupport,             MilitaryProduction, Pillage, ObsoleteTech, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, XPValueAttack, XPValueDefense, Conscription, UnitArtInfo,                UnitFlagAtlas,                                 UnitFlagIconOffset,    IconAtlas,            PortraitIndex,    MoveRate)
SELECT    'UNIT_THP_WARMALA',    Class,    CombatClass, WorkRate, 'TECH_AGRICULTURE', CanBuyCityState, Combat, 4,    2,     FaithCost, RequiresFaithPurchaseEnabled, Cost,  Moves, Domain, DefaultUnitAI, CivilianAttackPriority, Special, 'TXT_KEY_UNIT_THP_WARMALA',    'TXT_KEY_UNIT_THP_WARMALA_HELP',    'TXT_KEY_UNIT_THP_WARMALA_STRATEGY',      'TXT_KEY_UNIT_THP_WARMALA_TEXT',    MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, XPValueAttack, XPValueDefense, Conscription, 'ART_DEF_UNIT_THP_WARMALA', 'THP_UNIT_WARMALA_FLAG_ATLAS',    0,                    'THP_ANANGU_ATLAS',   2,                MoveRate
FROM Units WHERE Type = 'UNIT_SCOUT';
------------------------
-- UnitGameplay2DScripts
------------------------
INSERT INTO UnitGameplay2DScripts
       (UnitType,           SelectionSound, FirstSelectionSound)
SELECT 'UNIT_THP_WARMALA',  SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_SCOUT';
---------------
-- Unit_Flavors
---------------
INSERT INTO Unit_Flavors
       (UnitType,           FlavorType, Flavor)
SELECT 'UNIT_THP_WARMALA',  FlavorType, Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_SCOUT';
----------------------
-- Unit_FreePromotions
----------------------
INSERT INTO Unit_FreePromotions
       (UnitType,           PromotionType)
SELECT 'UNIT_THP_WARMALA',  PromotionType
FROM Unit_FreePromotions WHERE UnitType = 'UNIT_SCOUT';

INSERT INTO Unit_FreePromotions
        (UnitType,               PromotionType)
VALUES  ('UNIT_THP_WARMALA',    'PROMOTION_ONLY_DEFENSIVE'),
        ('UNIT_THP_WARMALA',    'PROMOTION_THP_ANANGU_DESERT_SPEED'),
        ('UNIT_THP_WARMALA',    'PROMOTION_THP_WARMALA');
---------------------
-- Unit_ClassUpgrades
---------------------
INSERT INTO Unit_ClassUpgrades
       (UnitType,           UnitClassType)
SELECT 'UNIT_THP_WARMALA',  UnitClassType
FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_SCOUT';
-- ======================================================================================================
-- DREAMTIME POLICIES
-- ======================================================================================================
-- Policies
-----------
INSERT INTO Policies
        (Type,                           Description,                        Help)
VALUES  ('POLICY_THP_ANANGU_DREAM_1',   'TXT_KEY_THP_ANANGU_DREAM_NAME_1',  'TXT_KEY_THP_ANANGU_NOTIFICATION_1'),
        ('POLICY_THP_ANANGU_DREAM_2',   'TXT_KEY_THP_ANANGU_DREAM_NAME_2',  'TXT_KEY_THP_ANANGU_NOTIFICATION_2'),
        ('POLICY_THP_ANANGU_DREAM_3',   'TXT_KEY_THP_ANANGU_DREAM_NAME_3',  'TXT_KEY_THP_ANANGU_NOTIFICATION_3'),
        ('POLICY_THP_ANANGU_DREAM_4',   'TXT_KEY_THP_ANANGU_DREAM_NAME_4',  'TXT_KEY_THP_ANANGU_NOTIFICATION_4'),
        ('POLICY_THP_ANANGU_DREAM_5',   'TXT_KEY_THP_ANANGU_DREAM_NAME_5',  'TXT_KEY_THP_ANANGU_NOTIFICATION_5'),
        ('POLICY_THP_ANANGU_DREAM_6',   'TXT_KEY_THP_ANANGU_DREAM_NAME_6',  'TXT_KEY_THP_ANANGU_NOTIFICATION_6'),
        ('POLICY_THP_ANANGU_DREAM_7',   'TXT_KEY_THP_ANANGU_DREAM_NAME_7',  'TXT_KEY_THP_ANANGU_NOTIFICATION_7'),
        ('POLICY_THP_ANANGU_DREAM_8',   'TXT_KEY_THP_ANANGU_DREAM_NAME_8',  'TXT_KEY_THP_ANANGU_NOTIFICATION_8'),
        ('POLICY_THP_ANANGU_DREAM_9',   'TXT_KEY_THP_ANANGU_DREAM_NAME_9',  'TXT_KEY_THP_ANANGU_NOTIFICATION_9'),
        ('POLICY_THP_ANANGU_DREAM_10',   'TXT_KEY_THP_ANANGU_DREAM_NAME_10',  'TXT_KEY_THP_ANANGU_NOTIFICATION_10');
-----------------------------------
-- Policy_BuildingClassYieldChanges
-----------------------------------
INSERT INTO Policy_BuildingClassYieldChanges
        (PolicyType,                    BuildingClassType,      YieldType,      YieldChange)
VALUES  ('POLICY_THP_ANANGU_DREAM_5',   'BUILDINGCLASS_SHRINE', 'YIELD_FOOD',   1),
        ('POLICY_THP_ANANGU_DREAM_5',   'BUILDINGCLASS_TEMPLE', 'YIELD_FOOD',   1);
-- ======================================================================================================
-- DIPLOMACY
-- ======================================================================================================
INSERT INTO Diplomacy_Responses
(LeaderType,             ResponseType,                                     Response,                                                             Bias)
VALUES     ('LEADER_THP_TJILPI',     'RESPONSE_ATTACKED_HOSTILE',                     'TXT_KEY_LEADER_THP_TJILPI_ATTACKED_GENERIC%',                     500),
('LEADER_THP_TJILPI',     'RESPONSE_DEFEATED',                             'TXT_KEY_LEADER_THP_TJILPI_DEFEATED%',                             500),
('LEADER_THP_TJILPI',     'RESPONSE_DOW_GENERIC',                         'TXT_KEY_LEADER_THP_TJILPI_DOW_GENERIC%',                             500),
('LEADER_THP_TJILPI',     'RESPONSE_EXPANSION_SERIOUS_WARNING',             'TXT_KEY_LEADER_THP_TJILPI_EXPANSION_SERIOUS_WARNING%',             500),
('LEADER_THP_TJILPI',     'RESPONSE_FIRST_GREETING',                         'TXT_KEY_LEADER_THP_TJILPI_FIRSTGREETING%',                         500),
('LEADER_THP_TJILPI',     'RESPONSE_GREETING_AT_WAR_HOSTILE',             'TXT_KEY_LEADER_THP_TJILPI_GREETING_AT_WAR_HOSTILE%',                 500),
('LEADER_THP_TJILPI',     'RESPONSE_GREETING_POLITE_HELLO',                 'TXT_KEY_LEADER_THP_TJILPI_GREETING_POLITE_HELLO%',                 500),
('LEADER_THP_TJILPI',     'RESPONSE_GREETING_NEUTRAL_HELLO',                 'TXT_KEY_LEADER_THP_TJILPI_GREETING_NEUTRAL_HELLO%',                 500),
('LEADER_THP_TJILPI',     'RESPONSE_GREETING_HOSTILE_HELLO',                 'TXT_KEY_LEADER_THP_TJILPI_GREETING_HOSTILE_HELLO%',                 500),
('LEADER_THP_TJILPI',     'RESPONSE_HOSTILE_AGGRESSIVE_MILITARY_WARNING', 'TXT_KEY_LEADER_THP_TJILPI_HOSTILE_AGGRESSIVE_MILITARY_WARNING%',     500),
('LEADER_THP_TJILPI',     'RESPONSE_INFLUENTIAL_ON_AI',                     'TXT_KEY_LEADER_THP_TJILPI_INFLUENTIAL_ON_AI%',                     500),
('LEADER_THP_TJILPI',     'RESPONSE_INFLUENTIAL_ON_HUMAN',                 'TXT_KEY_LEADER_THP_TJILPI_INFLUENTIAL_ON_HUMAN%',                 500),
('LEADER_THP_TJILPI',     'RESPONSE_LETS_HEAR_IT',                         'TXT_KEY_LEADER_THP_TJILPI_LETS_HEAR_IT%',                         500),
('LEADER_THP_TJILPI',     'RESPONSE_LUXURY_TRADE',                         'TXT_KEY_LEADER_THP_TJILPI_LUXURY_TRADE%',                         500),
('LEADER_THP_TJILPI',     'RESPONSE_NO_PEACE',                             'TXT_KEY_LEADER_THP_TJILPI_NO_PEACE%',                             500),
('LEADER_THP_TJILPI',     'RESPONSE_OPEN_BORDERS_EXCHANGE',                 'TXT_KEY_LEADER_THP_TJILPI_OPEN_BORDERS_EXCHANGE%',                 500),
('LEADER_THP_TJILPI',     'RESPONSE_PEACE_MADE_BY_HUMAN_GRACIOUS',         'TXT_KEY_LEADER_THP_TJILPI_LOSEWAR%',                                 500),
('LEADER_THP_TJILPI',     'RESPONSE_REPEAT_NO',                             'TXT_KEY_LEADER_THP_TJILPI_REPEAT_NO%',                             500),
('LEADER_THP_TJILPI',     'RESPONSE_RESPONSE_REQUEST',                     'TXT_KEY_LEADER_THP_TJILPI_RESPONSE_REQUEST%',                     500),
('LEADER_THP_TJILPI',     'RESPONSE_RESPONSE_TO_BEING_DENOUNCED',         'TXT_KEY_LEADER_THP_TJILPI_RESPONSE_TO_BEING_DENOUNCED%',             500),
('LEADER_THP_TJILPI',     'RESPONSE_TOO_SOON_NO_PEACE',                     'TXT_KEY_LEADER_THP_TJILPI_TOO_SOON_NO_PEACE_1%',                     500),
('LEADER_THP_TJILPI',     'RESPONSE_WINNER_PEACE_OFFER',                     'TXT_KEY_LEADER_THP_TJILPI_WINWAR%',                                 500),
('LEADER_THP_TJILPI',     'RESPONSE_WORK_AGAINST_SOMEONE',                 'TXT_KEY_LEADER_THP_TJILPI_DENOUNCE%',                             500),
('LEADER_THP_TJILPI',     'RESPONSE_WORK_WITH_US',                         'TXT_KEY_LEADER_THP_TJILPI_DEC_FRIENDSHIP%',                         500);
-- ======================================================================================================
-- ======================================================================================================




