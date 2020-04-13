-- Namibia
-- ======================================================================================================
-- CIVILIZATIONS
-- ======================================================================================================
-- Civilizations
----------------
INSERT INTO Civilizations
       (Type,                      Description,                     ShortDescription,                   Adjective,                       Civilopedia,                        CivilopediaTag, DefaultPlayerColor,  ArtDefineTag,    ArtStyleType,  ArtStyleSuffix, ArtStylePrefix,           IconAtlas,      PortraitIndex,  AlphaIconAtlas,             SoundtrackTag,   MapImage,                   DawnOfManQuote,                   DawnOfManImage)
SELECT 'CIVILIZATION_THP_NAMIBIA', 'TXT_KEY_CIV_THP_NAMIBIA_DESC',  'TXT_KEY_CIV_THP_NAMIBIA_SHORT_DESC',   'TXT_KEY_CIV_THP_NAMIBIA_ADJECTIVE',    'TXT_KEY_PEDIA_THP_NAMIBIA_TEXT',  'TXT_KEY_PEDIA_THP_NAMIBIA', 'PLAYERCOLOR_THP_NAMIBIA',  ArtDefineTag,   ArtStyleType,   ArtStyleSuffix, ArtStylePrefix, 'THP_NAMIBIA_ATLAS',   0,             'THP_NAMIBIA_ALPHA_ATLAS',   SoundtrackTag,  'Map_Namibia.dds',  'TXT_KEY_CIV5_DAWN_THP_NAMIBIA_TEXT',   'Morenga_DOM.dds'
FROM Civilizations WHERE Type = 'CIVILIZATION_ZULU';
-------------------------
-- Civilization_CityNames
-------------------------
-- TXT_KEY_CITY_NAME_THP_NAMIBIA_3 is absent by design
-- I removed it for being a duplicate, and I didn't feel like manually renaming every subsequent city
-- since this is all just back-end stuff anyway
INSERT INTO Civilization_CityNames
(CivilizationType,             CityName)
VALUES    ('CIVILIZATION_THP_NAMIBIA',     'TXT_KEY_CITY_NAME_THP_NAMIBIA_1'),
          ('CIVILIZATION_THP_NAMIBIA',     'TXT_KEY_CITY_NAME_THP_NAMIBIA_2'),
          ('CIVILIZATION_THP_NAMIBIA',     'TXT_KEY_CITY_NAME_THP_NAMIBIA_4'),
          ('CIVILIZATION_THP_NAMIBIA',     'TXT_KEY_CITY_NAME_THP_NAMIBIA_5'),
          ('CIVILIZATION_THP_NAMIBIA',     'TXT_KEY_CITY_NAME_THP_NAMIBIA_6'),
          ('CIVILIZATION_THP_NAMIBIA',     'TXT_KEY_CITY_NAME_THP_NAMIBIA_7'),
          ('CIVILIZATION_THP_NAMIBIA',     'TXT_KEY_CITY_NAME_THP_NAMIBIA_8'),
          ('CIVILIZATION_THP_NAMIBIA',     'TXT_KEY_CITY_NAME_THP_NAMIBIA_9'),
          ('CIVILIZATION_THP_NAMIBIA',     'TXT_KEY_CITY_NAME_THP_NAMIBIA_10'),
          ('CIVILIZATION_THP_NAMIBIA',     'TXT_KEY_CITY_NAME_THP_NAMIBIA_11'),
          ('CIVILIZATION_THP_NAMIBIA',     'TXT_KEY_CITY_NAME_THP_NAMIBIA_12'),
          ('CIVILIZATION_THP_NAMIBIA',     'TXT_KEY_CITY_NAME_THP_NAMIBIA_13'),
          ('CIVILIZATION_THP_NAMIBIA',     'TXT_KEY_CITY_NAME_THP_NAMIBIA_14'),
          ('CIVILIZATION_THP_NAMIBIA',     'TXT_KEY_CITY_NAME_THP_NAMIBIA_15'),
          ('CIVILIZATION_THP_NAMIBIA',     'TXT_KEY_CITY_NAME_THP_NAMIBIA_16'),
          ('CIVILIZATION_THP_NAMIBIA',     'TXT_KEY_CITY_NAME_THP_NAMIBIA_17'),
          ('CIVILIZATION_THP_NAMIBIA',     'TXT_KEY_CITY_NAME_THP_NAMIBIA_18'),
          ('CIVILIZATION_THP_NAMIBIA',     'TXT_KEY_CITY_NAME_THP_NAMIBIA_19'),
          ('CIVILIZATION_THP_NAMIBIA',     'TXT_KEY_CITY_NAME_THP_NAMIBIA_20'),
          ('CIVILIZATION_THP_NAMIBIA',     'TXT_KEY_CITY_NAME_THP_NAMIBIA_21'),
          ('CIVILIZATION_THP_NAMIBIA',     'TXT_KEY_CITY_NAME_THP_NAMIBIA_22'),
          ('CIVILIZATION_THP_NAMIBIA',     'TXT_KEY_CITY_NAME_THP_NAMIBIA_23'),
          ('CIVILIZATION_THP_NAMIBIA',     'TXT_KEY_CITY_NAME_THP_NAMIBIA_24'),
          ('CIVILIZATION_THP_NAMIBIA',     'TXT_KEY_CITY_NAME_THP_NAMIBIA_25'),
          ('CIVILIZATION_THP_NAMIBIA',     'TXT_KEY_CITY_NAME_THP_NAMIBIA_26'),
          ('CIVILIZATION_THP_NAMIBIA',     'TXT_KEY_CITY_NAME_THP_NAMIBIA_27'),
          ('CIVILIZATION_THP_NAMIBIA',     'TXT_KEY_CITY_NAME_THP_NAMIBIA_28'),
          ('CIVILIZATION_THP_NAMIBIA',     'TXT_KEY_CITY_NAME_THP_NAMIBIA_29'),
          ('CIVILIZATION_THP_NAMIBIA',     'TXT_KEY_CITY_NAME_THP_NAMIBIA_30');
-----------------------------------
-- Civilization_FreeBuildingClasses
-----------------------------------
INSERT INTO Civilization_FreeBuildingClasses
          (CivilizationType,              BuildingClassType)
SELECT    'CIVILIZATION_THP_NAMIBIA',     BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE CivilizationType = 'CIVILIZATION_ZULU';
-------------------------
-- Civilization_FreeTechs
-------------------------
INSERT INTO Civilization_FreeTechs
          (CivilizationType,              TechType)
SELECT    'CIVILIZATION_THP_NAMIBIA',     TechType
FROM Civilization_FreeTechs WHERE CivilizationType = 'CIVILIZATION_ZULU';
-------------------------
-- Civilization_FreeUnits
-------------------------
INSERT INTO Civilization_FreeUnits
          (CivilizationType,              UnitClassType, Count, UnitAIType)
SELECT    'CIVILIZATION_THP_NAMIBIA',     UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE CivilizationType = 'CIVILIZATION_ZULU';
-----------------------
-- Civilization_Leaders
-----------------------
INSERT INTO Civilization_Leaders
       (CivilizationType,            LeaderheadType)
VALUES ('CIVILIZATION_THP_NAMIBIA', 'LEADER_THP_MORENGA');
--------------------------------------
-- Civilization_BuildingClassOverrides
--------------------------------------
INSERT INTO Civilization_BuildingClassOverrides
       (CivilizationType,            BuildingClassType,      BuildingType)
VALUES ('CIVILIZATION_THP_NAMIBIA', 'BUILDINGCLASS_CASTLE', 'BUILDING_THP_KHAUXANAS');
----------------------------------
-- Civilization_UnitClassOverrides
----------------------------------
INSERT INTO Civilization_UnitClassOverrides
       (CivilizationType,            UnitClassType,       UnitType)
VALUES ('CIVILIZATION_THP_NAMIBIA', 'UNITCLASS_CAVALRY', 'UNIT_THP_OXRIDER');
-------------------------
-- Civilization_Religions
-------------------------
INSERT INTO Civilization_Religions
       (CivilizationType,            ReligionType)
VALUES ('CIVILIZATION_THP_NAMIBIA', 'RELIGION_PROTESTANTISM');
------------------------
-- Civilization_SpyNames
------------------------
INSERT INTO Civilization_SpyNames
          (CivilizationType,                SpyName)
VALUES    ('CIVILIZATION_THP_NAMIBIA',     'TXT_KEY_SPY_NAME_THP_NAMIBIA_0'),
          ('CIVILIZATION_THP_NAMIBIA',     'TXT_KEY_SPY_NAME_THP_NAMIBIA_1'),
          ('CIVILIZATION_THP_NAMIBIA',     'TXT_KEY_SPY_NAME_THP_NAMIBIA_2'),
          ('CIVILIZATION_THP_NAMIBIA',     'TXT_KEY_SPY_NAME_THP_NAMIBIA_3'),
          ('CIVILIZATION_THP_NAMIBIA',     'TXT_KEY_SPY_NAME_THP_NAMIBIA_4'),
          ('CIVILIZATION_THP_NAMIBIA',     'TXT_KEY_SPY_NAME_THP_NAMIBIA_5'),
          ('CIVILIZATION_THP_NAMIBIA',     'TXT_KEY_SPY_NAME_THP_NAMIBIA_6'),
          ('CIVILIZATION_THP_NAMIBIA',     'TXT_KEY_SPY_NAME_THP_NAMIBIA_7'),
          ('CIVILIZATION_THP_NAMIBIA',     'TXT_KEY_SPY_NAME_THP_NAMIBIA_8'),
          ('CIVILIZATION_THP_NAMIBIA',     'TXT_KEY_SPY_NAME_THP_NAMIBIA_9'),
          ('CIVILIZATION_THP_NAMIBIA',     'TXT_KEY_SPY_NAME_THP_NAMIBIA_10');
-------------------------------------
-- Civilization_Start_Region_Priority
-------------------------------------
INSERT INTO Civilization_Start_Region_Priority
              (CivilizationType,                    RegionType)
VALUES        ('CIVILIZATION_THP_NAMIBIA',         'REGION_DESERT');
-- ======================================================================================================
-- LEADERS
-- ======================================================================================================
-- Leaders
----------
INSERT INTO Leaders
(Type,                                Description,                     Civilopedia,                      CivilopediaTag,                          ArtDefineTag,                VictoryCompetitiveness,     WonderCompetitiveness,     MinorCivCompetitiveness,     Boldness,     DiploBalance,     WarmongerHate,     DenounceWillingness,     DoFWillingness, Loyalty,     Neediness,    Forgiveness,     Chattiness, Meanness,     IconAtlas,             PortraitIndex)
VALUES    ('LEADER_THP_MORENGA',     'TXT_KEY_LEADER_THP_MORENGA',    'TXT_KEY_LEADER_THP_MORENGA_PEDIA_TEXT',    'TXT_KEY_LEADER_THP_MORENGA_PEDIA',     'Leaderhead_Morenga.xml',     8,                                   3,                         6,                           9,            6,                9,                 9,                       6,              7,           3,            3,               4,          5,             'THP_NAMIBIA_ATLAS',   1);
--------------------------------
-- Leader_MajorCivApproachBiases
--------------------------------
INSERT INTO Leader_MajorCivApproachBiases
          (LeaderType,                MajorCivApproachType,              Bias)
VALUES    ('LEADER_THP_MORENGA',     'MAJOR_CIV_APPROACH_WAR',           7),
          ('LEADER_THP_MORENGA',     'MAJOR_CIV_APPROACH_HOSTILE',       6),
          ('LEADER_THP_MORENGA',     'MAJOR_CIV_APPROACH_DECEPTIVE',     2),
          ('LEADER_THP_MORENGA',     'MAJOR_CIV_APPROACH_GUARDED',       8),
          ('LEADER_THP_MORENGA',     'MAJOR_CIV_APPROACH_AFRAID',        5),
          ('LEADER_THP_MORENGA',     'MAJOR_CIV_APPROACH_FRIENDLY',      5),
          ('LEADER_THP_MORENGA',     'MAJOR_CIV_APPROACH_NEUTRAL',       4);
--------------------------------
-- Leader_MinorCivApproachBiases
--------------------------------
INSERT INTO Leader_MinorCivApproachBiases
          (LeaderType,                MinorCivApproachType,              Bias)
VALUES    ('LEADER_THP_MORENGA',     'MINOR_CIV_APPROACH_IGNORE',        4),
          ('LEADER_THP_MORENGA',     'MINOR_CIV_APPROACH_FRIENDLY',      6),
          ('LEADER_THP_MORENGA',     'MINOR_CIV_APPROACH_PROTECTIVE',    9),
          ('LEADER_THP_MORENGA',     'MINOR_CIV_APPROACH_CONQUEST',      4),
          ('LEADER_THP_MORENGA',     'MINOR_CIV_APPROACH_BULLY',         2);
-----------------
-- Leader_Flavors
-----------------
INSERT INTO Leader_Flavors
          (LeaderType,                FlavorType,                        Flavor)
VALUES    ('LEADER_THP_MORENGA',     'FLAVOR_OFFENSE',                   6),
          ('LEADER_THP_MORENGA',     'FLAVOR_DEFENSE',                   9),
          ('LEADER_THP_MORENGA',     'FLAVOR_CITY_DEFENSE',              9),
          ('LEADER_THP_MORENGA',     'FLAVOR_MILITARY_TRAINING',         8),
          ('LEADER_THP_MORENGA',     'FLAVOR_RECON',                     4),
          ('LEADER_THP_MORENGA',     'FLAVOR_RANGED',                    6),
          ('LEADER_THP_MORENGA',     'FLAVOR_MOBILE',                    6),
          ('LEADER_THP_MORENGA',     'FLAVOR_NAVAL',                     4),
          ('LEADER_THP_MORENGA',     'FLAVOR_NAVAL_RECON',               3),
          ('LEADER_THP_MORENGA',     'FLAVOR_NAVAL_GROWTH',              4),
          ('LEADER_THP_MORENGA',     'FLAVOR_NAVAL_TILE_IMPROVEMENT',    5),
          ('LEADER_THP_MORENGA',     'FLAVOR_AIR',                       7),
          ('LEADER_THP_MORENGA',     'FLAVOR_EXPANSION',                 5),
          ('LEADER_THP_MORENGA',     'FLAVOR_GROWTH',                    5),
          ('LEADER_THP_MORENGA',     'FLAVOR_TILE_IMPROVEMENT',          8),
          ('LEADER_THP_MORENGA',     'FLAVOR_INFRASTRUCTURE',            6),
          ('LEADER_THP_MORENGA',     'FLAVOR_PRODUCTION',                8),
          ('LEADER_THP_MORENGA',     'FLAVOR_GOLD',                      4),
          ('LEADER_THP_MORENGA',     'FLAVOR_SCIENCE',                   5),
          ('LEADER_THP_MORENGA',     'FLAVOR_CULTURE',                   5),
          ('LEADER_THP_MORENGA',     'FLAVOR_HAPPINESS',                 4),
          ('LEADER_THP_MORENGA',     'FLAVOR_GREAT_PEOPLE',              2),
          ('LEADER_THP_MORENGA',     'FLAVOR_WONDER',                    2),
          ('LEADER_THP_MORENGA',     'FLAVOR_RELIGION',                  4),
          ('LEADER_THP_MORENGA',     'FLAVOR_DIPLOMACY',                 3),
          ('LEADER_THP_MORENGA',     'FLAVOR_SPACESHIP',                 2),
          ('LEADER_THP_MORENGA',     'FLAVOR_WATER_CONNECTION',          2),
          ('LEADER_THP_MORENGA',     'FLAVOR_NUKE',                      6),
          ('LEADER_THP_MORENGA',     'FLAVOR_USE_NUKE',                  4),
          ('LEADER_THP_MORENGA',     'FLAVOR_ESPIONAGE',                 9),
          ('LEADER_THP_MORENGA',     'FLAVOR_AIRLIFT',                   7),
          ('LEADER_THP_MORENGA',     'FLAVOR_I_TRADE_DESTINATION',       6),
          ('LEADER_THP_MORENGA',     'FLAVOR_I_TRADE_ORIGIN',            4),
          ('LEADER_THP_MORENGA',     'FLAVOR_I_SEA_TRADE_ROUTE',         3),
          ('LEADER_THP_MORENGA',     'FLAVOR_I_LAND_TRADE_ROUTE',        6),
          ('LEADER_THP_MORENGA',     'FLAVOR_ARCHAEOLOGY',               6),
          ('LEADER_THP_MORENGA',     'FLAVOR_AIR_CARRIER',               3);
----------------
-- Leader_Traits
----------------
INSERT INTO Leader_Traits
       (LeaderType,              TraitType)
VALUES ('LEADER_THP_MORENGA',   'TRAIT_THP_NAMIBIA');
-- ======================================================================================================
-- TRAITS
-- ======================================================================================================
-- Traits
---------
INSERT INTO Traits
       (Type,                    Description,                    ShortDescription)
VALUES ('TRAIT_THP_NAMIBIA',    'TXT_KEY_TRAIT_THP_NAMIBIA',    'TXT_KEY_TRAIT_THP_NAMIBIA_SHORT');
-- ======================================================================================================
-- BUILDINGS
-- ======================================================================================================
-- Buildings
------------
INSERT INTO Buildings
(Type,                                 BuildingClass,    Cost, Espionage, EspionageModifier, SpecialistType, SpecialistCount, GoldMaintenance, PrereqTech,    Description,                                              Help,                                     Civilopedia,                                              Strategy,                                 ArtDefineTag, MinAreaSize, NeverCapture, Espionage, EspionageModifier, HurryCostModifier, PortraitIndex, IconAtlas)
SELECT    'BUILDING_THP_KHAUXANAS',    BuildingClass,    Cost, Espionage, EspionageModifier, SpecialistType, SpecialistCount, GoldMaintenance,  PrereqTech,   'TXT_KEY_BLDG_THP_KHAUXANAS',    'TXT_KEY_BLDG_THP_KHAUXANAS_HELP',    'TXT_KEY_BLDG_THP_KHAUXANAS_TEXT',    'TXT_KEY_BLDG_THP_KHAUXANAS_STRATEGY',    ArtDefineTag, MinAreaSize, NeverCapture, Espionage, EspionageModifier, HurryCostModifier, 3,            'THP_NAMIBIA_ATLAS'
FROM Buildings WHERE Type = 'BUILDING_CASTLE';
-------------------------------
-- Building_ClassesNeededInCity
-------------------------------
INSERT INTO Building_ClassesNeededInCity
       (BuildingType,            BuildingClassType)
SELECT 'BUILDING_THP_KHAUXANAS', BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_CASTLE';
-------------------
-- Building_Flavors
-------------------
INSERT INTO Building_Flavors
          (BuildingType,               FlavorType,    Flavor)
SELECT    'BUILDING_THP_KHAUXANAS',    FlavorType,    Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_CASTLE';
------------------------
-- Building_YieldChanges
------------------------
INSERT INTO Building_YieldChanges
          (BuildingType,               YieldType,    Yield)
SELECT    'BUILDING_THP_KHAUXANAS',    YieldType,    Yield
FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_CASTLE';
--------------------------
-- Building_YieldModifiers
--------------------------
INSERT INTO Building_YieldModifiers
          (BuildingType,               YieldType,    Yield)
SELECT    'BUILDING_THP_KHAUXANAS',    YieldType,    Yield
FROM Building_YieldModifiers WHERE BuildingType = 'BUILDING_CASTLE';
-- ======================================================================================================
-- UNITS
-- ======================================================================================================
-- UnitClasses
--------------
INSERT INTO UnitClasses
       (Type,                            DefaultUnit)
VALUES ('UNITCLASS_THP_NAMIBIA_DUMMY',  'UNIT_THP_NAMIBIA_DUMMY');
--------
-- Units
--------
INSERT INTO Units
(Type,                           Class,    CombatClass, WorkRate, PrereqTech, CanBuyCityState, Combat,     FaithCost, RequiresFaithPurchaseEnabled, Cost, Moves, CombatClass, Domain, DefaultUnitAI, CivilianAttackPriority, Special, Description,                   Help,                                             Strategy,                                 Civilopedia,          MilitarySupport,             MilitaryProduction, Pillage, ObsoleteTech, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, XPValueAttack, XPValueDefense, Conscription, UnitArtInfo,                UnitFlagAtlas,                                 UnitFlagIconOffset,    IconAtlas,            PortraitIndex,    MoveRate)
SELECT    'UNIT_THP_OXRIDER',    Class,    CombatClass, WorkRate, PrereqTech, CanBuyCityState, Combat, FaithCost, RequiresFaithPurchaseEnabled, 185,  Moves, CombatClass, Domain, DefaultUnitAI, CivilianAttackPriority, Special, 'TXT_KEY_UNIT_THP_OXRIDER',    'TXT_KEY_UNIT_THP_OXRIDER_HELP',    'TXT_KEY_UNIT_THP_OXRIDER_STRATEGY',      'TXT_KEY_UNIT_THP_OXRIDER_TEXT',    MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, XPValueAttack, XPValueDefense, Conscription, 'ART_DEF_UNIT_THP_OXRIDER', 'THP_UNIT_OXRIDER_FLAG_ATLAS',    0,                    'THP_NAMIBIA_ATLAS',   2,                MoveRate
FROM Units WHERE Type = 'UNIT_CAVALRY';

-- The RangedCombat of 20 makes the dummy unit slightly stronger than a Crossbowman, which feels appropriate given that the dummy unit will begin coming online in the Medieval Era.
INSERT INTO Units
       (Type,                       Class,                          Cost,   RangedCombat,   Moves,  Range,  Immobile,   NoMaintenance,  CombatClass,           Domain,        DefaultUnitAI,            Description,      Civilopedia,                           Strategy,                                  Help,                 UnitArtInfo,           UnitFlagIconOffset, IconAtlas,      PortraitIndex,  ShowInPedia)
VALUES ('UNIT_THP_NAMIBIA_DUMMY',   'UNITCLASS_THP_NAMIBIA_DUMMY',  -1,     20,              2,      100,           1,                 1,              'UNITCOMBAT_ARCHER',  'DOMAIN_LAND',  'UNITAI_COUNTER',   'TXT_KEY_UNIT_ARCHER',  'TXT_KEY_CIV5_ANTIQUITY_ARCHER_TEXT',   'TXT_KEY_UNIT_ARCHER_STRATEGY', 'TXT_KEY_UNIT_HELP_ARCHER', 'ART_DEF_UNIT_ARCHER',  9,                  'UNIT_ATLAS_1', 9,                    0);
------------------------
-- UnitGameplay2DScripts
------------------------
INSERT INTO UnitGameplay2DScripts
       (UnitType,           SelectionSound, FirstSelectionSound)
SELECT 'UNIT_THP_OXRIDER',  SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_CAVALRY';
---------------
-- Unit_Flavors
---------------
INSERT INTO Unit_Flavors
       (UnitType,           FlavorType, Flavor)
SELECT 'UNIT_THP_OXRIDER',  FlavorType, Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_CAVALRY';
----------------------
-- Unit_FreePromotions
----------------------
INSERT INTO Unit_FreePromotions
       (UnitType,           PromotionType)
SELECT 'UNIT_THP_OXRIDER',  PromotionType
FROM Unit_FreePromotions WHERE UnitType = 'UNIT_CAVALRY';

INSERT INTO Unit_FreePromotions
       (UnitType,            PromotionType)
VALUES ('UNIT_THP_OXRIDER',  'PROMOTION_HEAVY_CHARGE');

INSERT INTO Unit_FreePromotions
       (UnitType,                    PromotionType)
VALUES ('UNIT_THP_NAMIBIA_DUMMY',   'PROMOTION_INDIRECT_FIRE');
---------------------
-- Unit_ClassUpgrades
---------------------
INSERT INTO Unit_ClassUpgrades
       (UnitType,           UnitClassType)
SELECT 'UNIT_THP_OXRIDER',  UnitClassType
FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_CAVALRY';
-- ======================================================================================================
-- DIPLOMACY
-- ======================================================================================================
INSERT INTO Diplomacy_Responses
(LeaderType,             ResponseType,                                     Response,                                                             Bias)
VALUES     ('LEADER_THP_MORENGA',     'RESPONSE_ATTACKED_HOSTILE',                     'TXT_KEY_LEADER_THP_MORENGA_ATTACKED_GENERIC%',                     500),
('LEADER_THP_MORENGA',     'RESPONSE_DEFEATED',                             'TXT_KEY_LEADER_THP_MORENGA_DEFEATED%',                             500),
('LEADER_THP_MORENGA',     'RESPONSE_DOW_GENERIC',                         'TXT_KEY_LEADER_THP_MORENGA_DOW_GENERIC%',                             500),
('LEADER_THP_MORENGA',     'RESPONSE_EXPANSION_SERIOUS_WARNING',             'TXT_KEY_LEADER_THP_MORENGA_EXPANSION_SERIOUS_WARNING%',             500),
('LEADER_THP_MORENGA',     'RESPONSE_FIRST_GREETING',                         'TXT_KEY_LEADER_THP_MORENGA_FIRSTGREETING%',                         500),
('LEADER_THP_MORENGA',     'RESPONSE_GREETING_AT_WAR_HOSTILE',             'TXT_KEY_LEADER_THP_MORENGA_GREETING_AT_WAR_HOSTILE%',                 500),
('LEADER_THP_MORENGA',     'RESPONSE_GREETING_POLITE_HELLO',                 'TXT_KEY_LEADER_THP_MORENGA_GREETING_POLITE_HELLO%',                 500),
('LEADER_THP_MORENGA',     'RESPONSE_GREETING_NEUTRAL_HELLO',                 'TXT_KEY_LEADER_THP_MORENGA_GREETING_NEUTRAL_HELLO%',                 500),
('LEADER_THP_MORENGA',     'RESPONSE_GREETING_HOSTILE_HELLO',                 'TXT_KEY_LEADER_THP_MORENGA_GREETING_HOSTILE_HELLO%',                 500),
('LEADER_THP_MORENGA',     'RESPONSE_HOSTILE_AGGRESSIVE_MILITARY_WARNING', 'TXT_KEY_LEADER_THP_MORENGA_HOSTILE_AGGRESSIVE_MILITARY_WARNING%',     500),
('LEADER_THP_MORENGA',     'RESPONSE_INFLUENTIAL_ON_AI',                     'TXT_KEY_LEADER_THP_MORENGA_INFLUENTIAL_ON_AI%',                     500),
('LEADER_THP_MORENGA',     'RESPONSE_INFLUENTIAL_ON_HUMAN',                 'TXT_KEY_LEADER_THP_MORENGA_INFLUENTIAL_ON_HUMAN%',                 500),
('LEADER_THP_MORENGA',     'RESPONSE_LETS_HEAR_IT',                         'TXT_KEY_LEADER_THP_MORENGA_LETS_HEAR_IT%',                         500),
('LEADER_THP_MORENGA',     'RESPONSE_LUXURY_TRADE',                         'TXT_KEY_LEADER_THP_MORENGA_LUXURY_TRADE%',                         500),
('LEADER_THP_MORENGA',     'RESPONSE_NO_PEACE',                             'TXT_KEY_LEADER_THP_MORENGA_NO_PEACE%',                             500),
('LEADER_THP_MORENGA',     'RESPONSE_OPEN_BORDERS_EXCHANGE',                 'TXT_KEY_LEADER_THP_MORENGA_OPEN_BORDERS_EXCHANGE%',                 500),
('LEADER_THP_MORENGA',     'RESPONSE_PEACE_MADE_BY_HUMAN_GRACIOUS',         'TXT_KEY_LEADER_THP_MORENGA_LOSEWAR%',                                 500),
('LEADER_THP_MORENGA',     'RESPONSE_REPEAT_NO',                             'TXT_KEY_LEADER_THP_MORENGA_REPEAT_NO%',                             500),
('LEADER_THP_MORENGA',     'RESPONSE_RESPONSE_REQUEST',                     'TXT_KEY_LEADER_THP_MORENGA_RESPONSE_REQUEST%',                     500),
('LEADER_THP_MORENGA',     'RESPONSE_RESPONSE_TO_BEING_DENOUNCED',         'TXT_KEY_LEADER_THP_MORENGA_RESPONSE_TO_BEING_DENOUNCED%',             500),
('LEADER_THP_MORENGA',     'RESPONSE_TOO_SOON_NO_PEACE',                     'TXT_KEY_LEADER_THP_MORENGA_TOO_SOON_NO_PEACE_1%',                     500),
('LEADER_THP_MORENGA',     'RESPONSE_WINNER_PEACE_OFFER',                     'TXT_KEY_LEADER_THP_MORENGA_WINWAR%',                                 500),
('LEADER_THP_MORENGA',     'RESPONSE_WORK_AGAINST_SOMEONE',                 'TXT_KEY_LEADER_THP_MORENGA_DENOUNCE%',                             500),
('LEADER_THP_MORENGA',     'RESPONSE_WORK_WITH_US',                         'TXT_KEY_LEADER_THP_MORENGA_DEC_FRIENDSHIP%',                         500);
-- ======================================================================================================
-- FEATURES
-- ======================================================================================================
INSERT INTO Features
       (Type,                        Description,                     Civilopedia,                                Help,                      ArtDefineTag,              Movement,   AddsFreshWater, WorldSoundscapeAudioScript, EffectTypeTag,  PortraitIndex,  IconAtlas)
VALUES ('FEATURE_THP_FORTWATER',    'TXT_KEY_FEATURE_THP_FORTWATER', 'TXT_KEY_PEDIA_THP_FORTWATER',  'TXT_KEY_FEATURE_THP_FORTWATER', 'ART_DEF_IMPROVEMENT_FORT', 1,          1,                  'ASSS_AMBIENCE_JUNGLE',           'WATER',         24,            'TERRAIN_ATLAS');
-- ======================================================================================================
-- ======================================================================================================




