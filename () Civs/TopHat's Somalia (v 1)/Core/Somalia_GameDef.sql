-- Somalia
-- ======================================================================================================
-- CIVILIZATIONS
-- ======================================================================================================
-- Civilizations
----------------
INSERT INTO Civilizations
       (Type,                         Description,                       ShortDescription,                          Adjective,                          Civilopedia,                         CivilopediaTag,      DefaultPlayerColor,       ArtDefineTag,   ArtStyleType,  ArtStyleSuffix, ArtStylePrefix,                  IconAtlas,        PortraitIndex,  AlphaIconAtlas,               SoundtrackTag,   MapImage,                   DawnOfManQuote,                   DawnOfManImage)
SELECT 'CIVILIZATION_THP_SOMALIA', 'TXT_KEY_CIV_THP_SOMALIA_DESC',  'TXT_KEY_CIV_THP_SOMALIA_SHORT_DESC',   'TXT_KEY_CIV_THP_SOMALIA_ADJECTIVE',    'TXT_KEY_PEDIA_THP_SOMALIA_TEXT',  'TXT_KEY_PEDIA_THP_SOMALIA', 'PLAYERCOLOR_THP_SOMALIA',     ArtDefineTag,   ArtStyleType,  ArtStyleSuffix, ArtStylePrefix,    'THP_SOMALIA_ATLAS',   0,             'THP_SOMALIA_ALPHA_ATLAS',   SoundtrackTag,  'Map_Somalia.dds',  'TXT_KEY_CIV5_DAWN_THP_SOMALIA_TEXT',   'SiadBarre_DOM.dds'
FROM Civilizations WHERE Type = 'CIVILIZATION_ETHIOPIA';

UPDATE MinorCivilizations
SET Description = 'TXT_KEY_CITYSTATE_THP_ADEN_DESC',
    ShortDescription = 'TXT_KEY_CITYSTATE_THP_ADEN_SHORT_DESC',
    Adjective = 'TXT_KEY_CITYSTATE_THP_ADEN_ADJECTIVE',
    Civilopedia = 'TXT_KEY_CIV5_THP_ADEN_TEXT_1'
WHERE Type = 'MINOR_CIV_MOGADISHU';
-------------------------
-- Civilization_CityNames
-------------------------
INSERT INTO Civilization_CityNames
        (CivilizationType,               CityName)
VALUES  ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_CITY_NAME_THP_SOMALIA_1'),
        ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_CITY_NAME_THP_SOMALIA_2'),
        ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_CITY_NAME_THP_SOMALIA_3'),
        ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_CITY_NAME_THP_SOMALIA_4'),
        ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_CITY_NAME_THP_SOMALIA_5'),
        ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_CITY_NAME_THP_SOMALIA_6'),
        ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_CITY_NAME_THP_SOMALIA_7'),
        ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_CITY_NAME_THP_SOMALIA_8'),
        ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_CITY_NAME_THP_SOMALIA_9'),
        ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_CITY_NAME_THP_SOMALIA_10'),
        ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_CITY_NAME_THP_SOMALIA_11'),
        ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_CITY_NAME_THP_SOMALIA_12'),
        ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_CITY_NAME_THP_SOMALIA_13'),
        ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_CITY_NAME_THP_SOMALIA_14'),
        ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_CITY_NAME_THP_SOMALIA_15'),
        ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_CITY_NAME_THP_SOMALIA_16'),
        ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_CITY_NAME_THP_SOMALIA_17'),
        ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_CITY_NAME_THP_SOMALIA_18'),
        ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_CITY_NAME_THP_SOMALIA_19'),
        ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_CITY_NAME_THP_SOMALIA_20'),
        ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_CITY_NAME_THP_SOMALIA_21'),
        ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_CITY_NAME_THP_SOMALIA_22'),
        ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_CITY_NAME_THP_SOMALIA_23'),
        ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_CITY_NAME_THP_SOMALIA_24'),
        ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_CITY_NAME_THP_SOMALIA_25'),
        ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_CITY_NAME_THP_SOMALIA_26'),
        ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_CITY_NAME_THP_SOMALIA_27'),
        ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_CITY_NAME_THP_SOMALIA_28'),
        ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_CITY_NAME_THP_SOMALIA_29'),
        ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_CITY_NAME_THP_SOMALIA_30'),
        ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_CITY_NAME_THP_SOMALIA_31'),
        ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_CITY_NAME_THP_SOMALIA_32'),
        ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_CITY_NAME_THP_SOMALIA_33');

DELETE FROM MinorCivilization_CityNames WHERE MinorCivType = 'MINOR_CIV_MOGADISHU';
INSERT INTO MinorCivilization_CityNames
              (MinorCivType,             CityName)
VALUES        ('MINOR_CIV_MOGADISHU',   'TXT_KEY_CITYSTATE_THP_ADEN');
-----------------------------------
-- Civilization_FreeBuildingClasses
-----------------------------------
INSERT INTO Civilization_FreeBuildingClasses
          (CivilizationType,           BuildingClassType)
SELECT    'CIVILIZATION_THP_SOMALIA',  BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE CivilizationType = 'CIVILIZATION_ETHIOPIA';
-------------------------
-- Civilization_FreeTechs
-------------------------
INSERT INTO Civilization_FreeTechs
          (CivilizationType,           TechType)
SELECT    'CIVILIZATION_THP_SOMALIA',  TechType
FROM Civilization_FreeTechs WHERE CivilizationType = 'CIVILIZATION_ETHIOPIA';
-------------------------
-- Civilization_FreeUnits
-------------------------
INSERT INTO Civilization_FreeUnits
          (CivilizationType,           UnitClassType, Count, UnitAIType)
SELECT    'CIVILIZATION_THP_SOMALIA',  UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE CivilizationType = 'CIVILIZATION_ETHIOPIA';
-----------------------
-- Civilization_Leaders
-----------------------
INSERT INTO Civilization_Leaders
       (CivilizationType,            LeaderheadType)
VALUES ('CIVILIZATION_THP_SOMALIA', 'LEADER_THP_SIAD_BARRE');
----------------------------------
-- Civilization_UnitClassOverrides
----------------------------------
INSERT INTO Civilization_UnitClassOverrides
        (CivilizationType,            UnitClassType,         UnitType)
VALUES  ('CIVILIZATION_THP_SOMALIA', 'UNITCLASS_MARINE',    'UNIT_THP_DUUB_CAS'),
        ('CIVILIZATION_THP_SOMALIA', 'UNITCLASS_WRITER',    'UNIT_THP_GABYAGA');

------------------------
-- Civilization_SpyNames
------------------------
INSERT INTO Civilization_SpyNames
          (CivilizationType,                SpyName)
VALUES    ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_SPY_NAME_THP_SOMALIA_0'),
          ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_SPY_NAME_THP_SOMALIA_1'),
          ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_SPY_NAME_THP_SOMALIA_2'),
          ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_SPY_NAME_THP_SOMALIA_3'),
          ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_SPY_NAME_THP_SOMALIA_4'),
          ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_SPY_NAME_THP_SOMALIA_5'),
          ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_SPY_NAME_THP_SOMALIA_6'),
          ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_SPY_NAME_THP_SOMALIA_7'),
          ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_SPY_NAME_THP_SOMALIA_8'),
          ('CIVILIZATION_THP_SOMALIA',     'TXT_KEY_SPY_NAME_THP_SOMALIA_9');
---------------------------------
-- Civilization_Start_Along_Ocean
---------------------------------
INSERT INTO Civilization_Start_Along_Ocean
        (CivilizationType,            StartAlongOcean)
VALUES  ('CIVILIZATION_THP_SOMALIA',  1);
-- ======================================================================================================
-- LEADERS
-- ======================================================================================================
-- Leaders
----------
INSERT INTO Leaders
(Type,                              Description,                   Civilopedia,                               CivilopediaTag,                    ArtDefineTag,                      VictoryCompetitiveness,         WonderCompetitiveness,     MinorCivCompetitiveness,     Boldness,     DiploBalance,   WarmongerHate,     DenounceWillingness,     DoFWillingness, Loyalty,     Neediness,    Forgiveness,    Chattiness, Meanness,     IconAtlas,             PortraitIndex)
VALUES    ('LEADER_THP_SIAD_BARRE',     'TXT_KEY_LEADER_THP_SIAD_BARRE',    'TXT_KEY_LEADER_THP_SIAD_BARRE_PEDIA_TEXT',  'TXT_KEY_LEADER_THP_SIAD_BARRE_PEDIA', 'Leaderhead_SiadBarre.xml',    7,                                               3,                         5,                           9,            5,                4,                              9,                       6,              3,           6,            4,              6,          7,           'THP_SOMALIA_ATLAS',   1);
--------------------------------
-- Leader_MajorCivApproachBiases
--------------------------------
INSERT INTO Leader_MajorCivApproachBiases
          (LeaderType,                   MajorCivApproachType,              Bias)
VALUES    ('LEADER_THP_SIAD_BARRE',     'MAJOR_CIV_APPROACH_WAR',           6),
          ('LEADER_THP_SIAD_BARRE',     'MAJOR_CIV_APPROACH_HOSTILE',       8),
          ('LEADER_THP_SIAD_BARRE',     'MAJOR_CIV_APPROACH_DECEPTIVE',     4),
          ('LEADER_THP_SIAD_BARRE',     'MAJOR_CIV_APPROACH_GUARDED',       6),
          ('LEADER_THP_SIAD_BARRE',     'MAJOR_CIV_APPROACH_AFRAID',        5),
          ('LEADER_THP_SIAD_BARRE',     'MAJOR_CIV_APPROACH_FRIENDLY',      1),
          ('LEADER_THP_SIAD_BARRE',     'MAJOR_CIV_APPROACH_NEUTRAL',       3);
--------------------------------
-- Leader_MinorCivApproachBiases
--------------------------------
INSERT INTO Leader_MinorCivApproachBiases
          (LeaderType,                   MinorCivApproachType,              Bias)
VALUES    ('LEADER_THP_SIAD_BARRE',     'MINOR_CIV_APPROACH_IGNORE',        6),
          ('LEADER_THP_SIAD_BARRE',     'MINOR_CIV_APPROACH_FRIENDLY',      3),
          ('LEADER_THP_SIAD_BARRE',     'MINOR_CIV_APPROACH_PROTECTIVE',    5),
          ('LEADER_THP_SIAD_BARRE',     'MINOR_CIV_APPROACH_CONQUEST',      6),
          ('LEADER_THP_SIAD_BARRE',     'MINOR_CIV_APPROACH_BULLY',         8);
-----------------
-- Leader_Flavors
-----------------
INSERT INTO Leader_Flavors
          (LeaderType,                   FlavorType,                        Flavor)
VALUES    ('LEADER_THP_SIAD_BARRE',     'FLAVOR_OFFENSE',                   7),
          ('LEADER_THP_SIAD_BARRE',     'FLAVOR_DEFENSE',                   3),
          ('LEADER_THP_SIAD_BARRE',     'FLAVOR_CITY_DEFENSE',              2),
          ('LEADER_THP_SIAD_BARRE',     'FLAVOR_MILITARY_TRAINING',         5),
          ('LEADER_THP_SIAD_BARRE',     'FLAVOR_RECON',                     4),
          ('LEADER_THP_SIAD_BARRE',     'FLAVOR_RANGED',                    4),
          ('LEADER_THP_SIAD_BARRE',     'FLAVOR_MOBILE',                    7),
          ('LEADER_THP_SIAD_BARRE',     'FLAVOR_NAVAL',                     10),
          ('LEADER_THP_SIAD_BARRE',     'FLAVOR_NAVAL_RECON',               6),
          ('LEADER_THP_SIAD_BARRE',     'FLAVOR_NAVAL_GROWTH',              7),
          ('LEADER_THP_SIAD_BARRE',     'FLAVOR_NAVAL_TILE_IMPROVEMENT',    5),
          ('LEADER_THP_SIAD_BARRE',     'FLAVOR_AIR',                       8),
          ('LEADER_THP_SIAD_BARRE',     'FLAVOR_EXPANSION',                 6),
          ('LEADER_THP_SIAD_BARRE',     'FLAVOR_GROWTH',                    2),
          ('LEADER_THP_SIAD_BARRE',     'FLAVOR_TILE_IMPROVEMENT',          6),
          ('LEADER_THP_SIAD_BARRE',     'FLAVOR_INFRASTRUCTURE',            6),
          ('LEADER_THP_SIAD_BARRE',     'FLAVOR_PRODUCTION',                6),
          ('LEADER_THP_SIAD_BARRE',     'FLAVOR_GOLD',                      2),
          ('LEADER_THP_SIAD_BARRE',     'FLAVOR_SCIENCE',                   8),
          ('LEADER_THP_SIAD_BARRE',     'FLAVOR_CULTURE',                   8),
          ('LEADER_THP_SIAD_BARRE',     'FLAVOR_HAPPINESS',                 1),
          ('LEADER_THP_SIAD_BARRE',     'FLAVOR_GREAT_PEOPLE',              8),
          ('LEADER_THP_SIAD_BARRE',     'FLAVOR_WONDER',                    1),
          ('LEADER_THP_SIAD_BARRE',     'FLAVOR_RELIGION',                  5),
          ('LEADER_THP_SIAD_BARRE',     'FLAVOR_DIPLOMACY',                 4),
          ('LEADER_THP_SIAD_BARRE',     'FLAVOR_SPACESHIP',                 3),
          ('LEADER_THP_SIAD_BARRE',     'FLAVOR_WATER_CONNECTION',          6),
          ('LEADER_THP_SIAD_BARRE',     'FLAVOR_NUKE',                      4),
          ('LEADER_THP_SIAD_BARRE',     'FLAVOR_USE_NUKE',                  7),
          ('LEADER_THP_SIAD_BARRE',     'FLAVOR_ESPIONAGE',                 5),
          ('LEADER_THP_SIAD_BARRE',     'FLAVOR_ANTIAIR',                   7),
          ('LEADER_THP_SIAD_BARRE',     'FLAVOR_AIRLIFT',                   4),
          ('LEADER_THP_SIAD_BARRE',     'FLAVOR_I_TRADE_DESTINATION',       7),
          ('LEADER_THP_SIAD_BARRE',     'FLAVOR_I_TRADE_ORIGIN',            10),
          ('LEADER_THP_SIAD_BARRE',     'FLAVOR_I_SEA_TRADE_ROUTE',         10),
          ('LEADER_THP_SIAD_BARRE',     'FLAVOR_I_LAND_TRADE_ROUTE',        6),
          ('LEADER_THP_SIAD_BARRE',     'FLAVOR_ARCHAEOLOGY',               4),
          ('LEADER_THP_SIAD_BARRE',     'FLAVOR_AIR_CARRIER',               4);
----------------
-- Leader_Traits
----------------
INSERT INTO Leader_Traits
       (LeaderType,                 TraitType)
VALUES ('LEADER_THP_SIAD_BARRE',   'TRAIT_THP_SOMALIA');
-- ======================================================================================================
-- TRAITS
-- ======================================================================================================
-- Traits
---------
INSERT INTO Traits
       (Type,                    Description,                   ShortDescription)
VALUES ('TRAIT_THP_SOMALIA',    'TXT_KEY_TRAIT_THP_SOMALIA',   'TXT_KEY_TRAIT_THP_SOMALIA_SHORT');
-- ======================================================================================================
-- BUILDINGS
-- ======================================================================================================
-- BuildingClasses
------------------
INSERT INTO BuildingClasses
(Type,                               DefaultBuilding,                Description)
VALUES  ('BUILDINGCLASS_THP_SOMALIA_TRADE_MARKER',  'BUILDING_THP_SOMALIA_TRADE_MARKER',    'TXT_KEY_BLDG_THP_SOMALIA_TRADE_MARKER'),
('BUILDINGCLASS_THP_SOMALIA_ROUTE_SLOT', 'BUILDING_THP_SOMALIA_ROUTE_SLOT',   'TXT_KEY_BLDG_THP_SOMALIA_ROUTE_SLOT');
------------
-- Buildings
------------
INSERT INTO Buildings
(Type,                                   BuildingClass,                        NumTradeRouteBonus,  SpecialistCount, GreatWorkCount, Cost, FaithCost,             Description,                         Help,                                  NeverCapture)
VALUES    ('BUILDING_THP_SOMALIA_TRADE_MARKER', 'BUILDINGCLASS_THP_SOMALIA_TRADE_MARKER',     0,                0,               -1,             -1,   -1,               'TXT_KEY_BLDG_THP_SOMALIA_TRADE_MARKER',    'TXT_KEY_BLDG_THP_SOMALIA_TRADE_MARKER_HELP',   1),
('BUILDING_THP_SOMALIA_ROUTE_SLOT', 'BUILDINGCLASS_THP_SOMALIA_ROUTE_SLOT',     1,                              0,               -1,             -1,   -1,               'TXT_KEY_BLDG_THP_SOMALIA_ROUTE_SLOT',    'TXT_KEY_BLDG_THP_SOMALIA_ROUTE_SLOT_HELP',   1);
-- ======================================================================================================
-- PROMOTIONS
-- ======================================================================================================
-- UnitPromotions
-----------------
INSERT INTO UnitPromotions
(Type,                                           Description,                                               Help,                                          Sound,              CombatPercent,  MovesChange,                CannotBeChosen, PortraitIndex,     IconAtlas,            PediaType,          PediaEntry)
VALUES    ('PROMOTION_THP_DUUB_CAS_ON_ROUTE',         'TXT_KEY_PROMOTION_THP_DUUB_CAS_ON_ROUTE',     'TXT_KEY_PROMOTION_THP_DUUB_CAS_ON_ROUTE_HELP',     'AS2D_IF_LEVELUP',   15,    0,                                      1,              59,             'ABILITY_ATLAS',     'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_THP_DUUB_CAS_ON_ROUTE_HELP'),
('PROMOTION_THP_FRIENDLY_DUUB_CAS',         'TXT_KEY_PROMOTION_THP_FRIENDLY_DUUB_CAS',     'TXT_KEY_PROMOTION_THP_FRIENDLY_DUUB_CAS_HELP',     'AS2D_IF_LEVELUP',   0,  2,                                      1,              59,             'ABILITY_ATLAS',     'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_THP_FRIENDLY_DUUB_CAS_HELP'),
('PROMOTION_THP_GABYAGA',                   'TXT_KEY_PROMOTION_THP_GABYAGA',     'TXT_KEY_PROMOTION_THP_GABYAGA_HELP',     'AS2D_IF_LEVELUP',   0,  0,                                        1,              59,             'ABILITY_ATLAS',     'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_THP_GABYAGA_HELP');
-- ======================================================================================================
-- UNITS
-- ======================================================================================================
-- Units
--------
INSERT INTO Units
(Type,                             Class,    CombatClass, WorkRate, PrereqTech, Combat, RangedCombat, Range, FaithCost, RequiresFaithPurchaseEnabled, Cost, Moves, Domain, DefaultUnitAI, CivilianAttackPriority, Special, Description,                       Help,                                                     Strategy,                                    Civilopedia,                       MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, AdvancedStartCost, MinAreaSize, GoodyHutUpgradeUnitClass, CombatLimit, XPValueAttack, XPValueDefense, Conscription,  UnitArtInfo,                           UnitFlagAtlas,                      UnitFlagIconOffset,    IconAtlas,        PortraitIndex,  MoveRate)
SELECT    'UNIT_THP_DUUB_CAS',   Class,    CombatClass, WorkRate, PrereqTech, Combat, RangedCombat, Range, FaithCost, RequiresFaithPurchaseEnabled, Cost, Moves, Domain, DefaultUnitAI, CivilianAttackPriority, Special, 'TXT_KEY_UNIT_THP_DUUB_CAS',    'TXT_KEY_UNIT_THP_DUUB_CAS_HELP',    'TXT_KEY_UNIT_THP_DUUB_CAS_STRATEGY',     'TXT_KEY_UNIT_THP_DUUB_CAS_TEXT', MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, AdvancedStartCost, MinAreaSize, GoodyHutUpgradeUnitClass, CombatLimit, XPValueAttack, XPValueDefense, Conscription, 'ART_DEF_UNIT_THP_DUUB_CAS', 'THP_UNIT_DUUB_CAS_FLAG_ATLAS',   0,                    'THP_SOMALIA_ATLAS',   2,              MoveRate
FROM Units WHERE Type = 'UNIT_MARINE';

INSERT INTO Units
(Class,            Type,                 PrereqTech, Combat, Cost, FaithCost, Moves, CombatClass, Domain, DefaultUnitAI, Description,                 Civilopedia,                                                Strategy,                                Help,                              MilitarySupport, MilitaryProduction, Pillage, IgnoreBuildingDefense, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, ObsoleteTech, XPValueDefense, UnitArtInfo,                  UnitFlagIconOffset,     UnitFlagAtlas,                   PortraitIndex,     IconAtlas,        MoveRate,    UnitArtInfoEraVariation,    Special, BaseCultureTurnsToCount,    WorkRate,   CombatLimit)
SELECT  Class,    'UNIT_THP_GABYAGA',    PrereqTech, Combat, Cost, FaithCost, Moves, CombatClass, Domain, DefaultUnitAI, 'TXT_KEY_UNIT_THP_GABYAGA',  'TXT_KEY_UNIT_THP_GABYAGA_TEXT',     'TXT_KEY_UNIT_THP_GABYAGA_STRATEGY',     'TXT_KEY_UNIT_THP_GABYAGA_HELP',     MilitarySupport, MilitaryProduction, Pillage, IgnoreBuildingDefense, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, ObsoleteTech, XPValueDefense, 'ART_DEF_UNIT_THP_GABYAGA',    0,                    'THP_UNIT_GABYAGA_FLAG_ATLAS',    3,                'THP_SOMALIA_ATLAS',  MoveRate,    0, Special, BaseCultureTurnsToCount,    WorkRate,   CombatLimit
FROM Units WHERE Type = 'UNIT_WRITER';
------------------------
-- UnitGameplay2DScripts
------------------------
INSERT INTO UnitGameplay2DScripts
       (UnitType,            SelectionSound, FirstSelectionSound)
SELECT 'UNIT_THP_DUUB_CAS',  SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_MARINE';

INSERT INTO UnitGameplay2DScripts
       (UnitType,           SelectionSound, FirstSelectionSound)
SELECT 'UNIT_THP_GABYAGA',  SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_WRITER';
---------------
-- Unit_AITypes
---------------
INSERT INTO Unit_AITypes
          (UnitType,              UnitAIType)
SELECT    'UNIT_THP_DUUB_CAS',    UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_MARINE';

INSERT INTO Unit_AITypes
          (UnitType,             UnitAIType)
SELECT    'UNIT_THP_GABYAGA',    UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_WRITER';
---------------
-- Unit_Flavors
---------------
INSERT INTO Unit_Flavors
       (UnitType,            FlavorType, Flavor)
SELECT 'UNIT_THP_DUUB_CAS',  FlavorType, Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_MARINE';

INSERT INTO Unit_Flavors
       (UnitType,           FlavorType, Flavor)
SELECT 'UNIT_THP_GABYAGA',  FlavorType, Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_WRITER';

INSERT INTO Unit_Flavors
        (UnitType,               FlavorType,                Flavor)
VALUES  ('UNIT_THP_GABYAGA',    'FLAVOR_I_TRADE_ORIGIN',    2),
        ('UNIT_THP_DUUB_CAS',   'FLAVOR_MOBILE',            10);
----------------------
-- Unit_FreePromotions
----------------------
INSERT INTO Unit_FreePromotions
        (UnitType,            PromotionType)
SELECT  'UNIT_THP_DUUB_CAS',  PromotionType
FROM Unit_FreePromotions WHERE UnitType = 'UNIT_MARINE';

INSERT INTO Unit_FreePromotions
        (UnitType,             PromotionType)
VALUES  ('UNIT_THP_DUUB_CAS', 'PROMOTION_THP_FRIENDLY_DUUB_CAS'),
        ('UNIT_THP_GABYAGA',  'PROMOTION_THP_GABYAGA');
---------------------
-- Unit_ClassUpgrades
---------------------
INSERT INTO Unit_ClassUpgrades
        (UnitType,            UnitClassType)
SELECT  'UNIT_THP_DUUB_CAS',  UnitClassType
FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_MARINE';
-------------------
-- Unit_UniqueNames
-------------------
INSERT INTO Unit_UniqueNames
        (UnitType,               UniqueName,                     GreatWorkType)
VALUES  ('UNIT_THP_GABYAGA',    'TXT_KEY_THP_GABYAGA_NAME_01',  'GREAT_WORK_GABYAGA_01'),
        ('UNIT_THP_GABYAGA',    'TXT_KEY_THP_GABYAGA_NAME_02',  'GREAT_WORK_GABYAGA_02'),
        ('UNIT_THP_GABYAGA',    'TXT_KEY_THP_GABYAGA_NAME_03',  'GREAT_WORK_GABYAGA_03'),
        ('UNIT_THP_GABYAGA',    'TXT_KEY_THP_GABYAGA_NAME_04',  'GREAT_WORK_GABYAGA_04'),
        ('UNIT_THP_GABYAGA',    'TXT_KEY_THP_GABYAGA_NAME_05',  'GREAT_WORK_GABYAGA_05'),
        ('UNIT_THP_GABYAGA',    'TXT_KEY_THP_GABYAGA_NAME_06',  'GREAT_WORK_GABYAGA_06'),
        ('UNIT_THP_GABYAGA',    'TXT_KEY_THP_GABYAGA_NAME_07',  'GREAT_WORK_GABYAGA_07'),
        ('UNIT_THP_GABYAGA',    'TXT_KEY_THP_GABYAGA_NAME_08',  'GREAT_WORK_GABYAGA_08'),
        ('UNIT_THP_GABYAGA',    'TXT_KEY_THP_GABYAGA_NAME_09',  'GREAT_WORK_GABYAGA_09'),
        ('UNIT_THP_GABYAGA',    'TXT_KEY_THP_GABYAGA_NAME_10',  'GREAT_WORK_GABYAGA_10'),
        ('UNIT_THP_GABYAGA',    'TXT_KEY_THP_GABYAGA_NAME_11',  'GREAT_WORK_GABYAGA_11'),
        ('UNIT_THP_GABYAGA',    'TXT_KEY_THP_GABYAGA_NAME_12',  'GREAT_WORK_GABYAGA_12'),
        ('UNIT_THP_GABYAGA',    'TXT_KEY_THP_GABYAGA_NAME_13',  'GREAT_WORK_GABYAGA_13'),
        ('UNIT_THP_GABYAGA',    'TXT_KEY_THP_GABYAGA_NAME_14',  'GREAT_WORK_GABYAGA_14'),
        ('UNIT_THP_GABYAGA',    'TXT_KEY_THP_GABYAGA_NAME_15',  'GREAT_WORK_GABYAGA_15'),
        ('UNIT_THP_GABYAGA',    'TXT_KEY_THP_GABYAGA_NAME_16',  'GREAT_WORK_GABYAGA_16'),
        ('UNIT_THP_GABYAGA',    'TXT_KEY_THP_GABYAGA_NAME_17',  'GREAT_WORK_GABYAGA_17'),
        ('UNIT_THP_GABYAGA',    'TXT_KEY_THP_GABYAGA_NAME_18',  'GREAT_WORK_GABYAGA_18'),
        ('UNIT_THP_GABYAGA',    'TXT_KEY_THP_GABYAGA_NAME_19',  'GREAT_WORK_GABYAGA_19'),
        ('UNIT_THP_GABYAGA',    'TXT_KEY_THP_GABYAGA_NAME_20',  'GREAT_WORK_GABYAGA_20'),
        ('UNIT_THP_GABYAGA',    'TXT_KEY_THP_GABYAGA_NAME_21',  'GREAT_WORK_GABYAGA_21'),
        ('UNIT_THP_GABYAGA',    'TXT_KEY_THP_GABYAGA_NAME_22',  'GREAT_WORK_GABYAGA_22'),
        ('UNIT_THP_GABYAGA',    'TXT_KEY_THP_GABYAGA_NAME_23',  'GREAT_WORK_GABYAGA_23'),
        ('UNIT_THP_GABYAGA',    'TXT_KEY_THP_GABYAGA_NAME_24',  'GREAT_WORK_GABYAGA_24'),
        ('UNIT_THP_GABYAGA',    'TXT_KEY_THP_GABYAGA_NAME_25',  'GREAT_WORK_GABYAGA_25'),
        ('UNIT_THP_GABYAGA',    'TXT_KEY_THP_GABYAGA_NAME_26',  'GREAT_WORK_GABYAGA_26'),
        ('UNIT_THP_GABYAGA',    'TXT_KEY_THP_GABYAGA_NAME_27',  'GREAT_WORK_GABYAGA_27'),
        ('UNIT_THP_GABYAGA',    'TXT_KEY_THP_GABYAGA_NAME_28',  'GREAT_WORK_GABYAGA_28'),
        ('UNIT_THP_GABYAGA',    'TXT_KEY_THP_GABYAGA_NAME_29',  'GREAT_WORK_GABYAGA_29'),
        ('UNIT_THP_GABYAGA',    'TXT_KEY_THP_GABYAGA_NAME_30',  'GREAT_WORK_GABYAGA_30');
-- ======================================================================================================
-- GREAT WORKS
-- ======================================================================================================
INSERT INTO GreatWorks
(Type,                         GreatWorkClassType,            Description,                                Quote,                                                Audio,                            Image)
VALUES        ('GREAT_WORK_GABYAGA_01',     'GREAT_WORK_LITERATURE',    'TXT_KEY_GREAT_WORK_GABYAGA_GREAT_WORK_01',    'TXT_KEY_GREAT_WORK_QUOTE_GABYAGA_GREAT_WORK_01',        'AS2D_GREAT_ARTIST_ARTWORK',    'GreatWriter_Background.dds'),
('GREAT_WORK_GABYAGA_02',     'GREAT_WORK_LITERATURE',    'TXT_KEY_GREAT_WORK_GABYAGA_GREAT_WORK_02',    'TXT_KEY_GREAT_WORK_QUOTE_GABYAGA_GREAT_WORK_02',        'AS2D_GREAT_ARTIST_ARTWORK',    'GreatWriter_Background.dds'),
('GREAT_WORK_GABYAGA_03',     'GREAT_WORK_LITERATURE',    'TXT_KEY_GREAT_WORK_GABYAGA_GREAT_WORK_03',    'TXT_KEY_GREAT_WORK_QUOTE_GABYAGA_GREAT_WORK_03',        'AS2D_GREAT_ARTIST_ARTWORK',    'GreatWriter_Background.dds'),
('GREAT_WORK_GABYAGA_04',     'GREAT_WORK_LITERATURE',    'TXT_KEY_GREAT_WORK_GABYAGA_GREAT_WORK_04',    'TXT_KEY_GREAT_WORK_QUOTE_GABYAGA_GREAT_WORK_04',        'AS2D_GREAT_ARTIST_ARTWORK',    'GreatWriter_Background.dds'),
('GREAT_WORK_GABYAGA_05',     'GREAT_WORK_LITERATURE',    'TXT_KEY_GREAT_WORK_GABYAGA_GREAT_WORK_05',    'TXT_KEY_GREAT_WORK_QUOTE_GABYAGA_GREAT_WORK_05',        'AS2D_GREAT_ARTIST_ARTWORK',    'GreatWriter_Background.dds'),
('GREAT_WORK_GABYAGA_06',     'GREAT_WORK_LITERATURE',    'TXT_KEY_GREAT_WORK_GABYAGA_GREAT_WORK_06',    'TXT_KEY_GREAT_WORK_QUOTE_GABYAGA_GREAT_WORK_06',        'AS2D_GREAT_ARTIST_ARTWORK',    'GreatWriter_Background.dds'),
('GREAT_WORK_GABYAGA_07',     'GREAT_WORK_LITERATURE',    'TXT_KEY_GREAT_WORK_GABYAGA_GREAT_WORK_07',    'TXT_KEY_GREAT_WORK_QUOTE_GABYAGA_GREAT_WORK_07',        'AS2D_GREAT_ARTIST_ARTWORK',    'GreatWriter_Background.dds'),
('GREAT_WORK_GABYAGA_08',     'GREAT_WORK_LITERATURE',    'TXT_KEY_GREAT_WORK_GABYAGA_GREAT_WORK_08',    'TXT_KEY_GREAT_WORK_QUOTE_GABYAGA_GREAT_WORK_08',        'AS2D_GREAT_ARTIST_ARTWORK',    'GreatWriter_Background.dds'),
('GREAT_WORK_GABYAGA_09',     'GREAT_WORK_LITERATURE',    'TXT_KEY_GREAT_WORK_GABYAGA_GREAT_WORK_09',    'TXT_KEY_GREAT_WORK_QUOTE_GABYAGA_GREAT_WORK_09',        'AS2D_GREAT_ARTIST_ARTWORK',    'GreatWriter_Background.dds'),
('GREAT_WORK_GABYAGA_10',     'GREAT_WORK_LITERATURE',    'TXT_KEY_GREAT_WORK_GABYAGA_GREAT_WORK_10',    'TXT_KEY_GREAT_WORK_QUOTE_GABYAGA_GREAT_WORK_10',        'AS2D_GREAT_ARTIST_ARTWORK',    'GreatWriter_Background.dds'),
('GREAT_WORK_GABYAGA_11',     'GREAT_WORK_LITERATURE',    'TXT_KEY_GREAT_WORK_GABYAGA_GREAT_WORK_11',    'TXT_KEY_GREAT_WORK_QUOTE_GABYAGA_GREAT_WORK_11',        'AS2D_GREAT_ARTIST_ARTWORK',    'GreatWriter_Background.dds'),
('GREAT_WORK_GABYAGA_12',     'GREAT_WORK_LITERATURE',    'TXT_KEY_GREAT_WORK_GABYAGA_GREAT_WORK_12',    'TXT_KEY_GREAT_WORK_QUOTE_GABYAGA_GREAT_WORK_12',        'AS2D_GREAT_ARTIST_ARTWORK',    'GreatWriter_Background.dds'),
('GREAT_WORK_GABYAGA_13',     'GREAT_WORK_LITERATURE',    'TXT_KEY_GREAT_WORK_GABYAGA_GREAT_WORK_13',    'TXT_KEY_GREAT_WORK_QUOTE_GABYAGA_GREAT_WORK_13',        'AS2D_GREAT_ARTIST_ARTWORK',    'GreatWriter_Background.dds'),
('GREAT_WORK_GABYAGA_14',     'GREAT_WORK_LITERATURE',    'TXT_KEY_GREAT_WORK_GABYAGA_GREAT_WORK_14',    'TXT_KEY_GREAT_WORK_QUOTE_GABYAGA_GREAT_WORK_14',        'AS2D_GREAT_ARTIST_ARTWORK',    'GreatWriter_Background.dds'),
('GREAT_WORK_GABYAGA_15',     'GREAT_WORK_LITERATURE',    'TXT_KEY_GREAT_WORK_GABYAGA_GREAT_WORK_15',    'TXT_KEY_GREAT_WORK_QUOTE_GABYAGA_GREAT_WORK_15',        'AS2D_GREAT_ARTIST_ARTWORK',    'GreatWriter_Background.dds'),
('GREAT_WORK_GABYAGA_16',     'GREAT_WORK_LITERATURE',    'TXT_KEY_GREAT_WORK_GABYAGA_GREAT_WORK_16',    'TXT_KEY_GREAT_WORK_QUOTE_GABYAGA_GREAT_WORK_16',        'AS2D_GREAT_ARTIST_ARTWORK',    'GreatWriter_Background.dds'),
('GREAT_WORK_GABYAGA_17',     'GREAT_WORK_LITERATURE',    'TXT_KEY_GREAT_WORK_GABYAGA_GREAT_WORK_17',    'TXT_KEY_GREAT_WORK_QUOTE_GABYAGA_GREAT_WORK_17',        'AS2D_GREAT_ARTIST_ARTWORK',    'GreatWriter_Background.dds'),
('GREAT_WORK_GABYAGA_18',     'GREAT_WORK_LITERATURE',    'TXT_KEY_GREAT_WORK_GABYAGA_GREAT_WORK_18',    'TXT_KEY_GREAT_WORK_QUOTE_GABYAGA_GREAT_WORK_18',        'AS2D_GREAT_ARTIST_ARTWORK',    'GreatWriter_Background.dds'),
('GREAT_WORK_GABYAGA_19',     'GREAT_WORK_LITERATURE',    'TXT_KEY_GREAT_WORK_GABYAGA_GREAT_WORK_19',    'TXT_KEY_GREAT_WORK_QUOTE_GABYAGA_GREAT_WORK_19',        'AS2D_GREAT_ARTIST_ARTWORK',    'GreatWriter_Background.dds'),
('GREAT_WORK_GABYAGA_20',     'GREAT_WORK_LITERATURE',    'TXT_KEY_GREAT_WORK_GABYAGA_GREAT_WORK_20',    'TXT_KEY_GREAT_WORK_QUOTE_GABYAGA_GREAT_WORK_20',        'AS2D_GREAT_ARTIST_ARTWORK',    'GreatWriter_Background.dds'),
('GREAT_WORK_GABYAGA_21',     'GREAT_WORK_LITERATURE',    'TXT_KEY_GREAT_WORK_GABYAGA_GREAT_WORK_21',    'TXT_KEY_GREAT_WORK_QUOTE_GABYAGA_GREAT_WORK_21',        'AS2D_GREAT_ARTIST_ARTWORK',    'GreatWriter_Background.dds'),
('GREAT_WORK_GABYAGA_22',     'GREAT_WORK_LITERATURE',    'TXT_KEY_GREAT_WORK_GABYAGA_GREAT_WORK_22',    'TXT_KEY_GREAT_WORK_QUOTE_GABYAGA_GREAT_WORK_22',        'AS2D_GREAT_ARTIST_ARTWORK',    'GreatWriter_Background.dds'),
('GREAT_WORK_GABYAGA_23',     'GREAT_WORK_LITERATURE',    'TXT_KEY_GREAT_WORK_GABYAGA_GREAT_WORK_23',    'TXT_KEY_GREAT_WORK_QUOTE_GABYAGA_GREAT_WORK_23',        'AS2D_GREAT_ARTIST_ARTWORK',    'GreatWriter_Background.dds'),
('GREAT_WORK_GABYAGA_24',     'GREAT_WORK_LITERATURE',    'TXT_KEY_GREAT_WORK_GABYAGA_GREAT_WORK_24',    'TXT_KEY_GREAT_WORK_QUOTE_GABYAGA_GREAT_WORK_24',        'AS2D_GREAT_ARTIST_ARTWORK',    'GreatWriter_Background.dds'),
('GREAT_WORK_GABYAGA_25',     'GREAT_WORK_LITERATURE',    'TXT_KEY_GREAT_WORK_GABYAGA_GREAT_WORK_25',    'TXT_KEY_GREAT_WORK_QUOTE_GABYAGA_GREAT_WORK_25',        'AS2D_GREAT_ARTIST_ARTWORK',    'GreatWriter_Background.dds'),
('GREAT_WORK_GABYAGA_26',     'GREAT_WORK_LITERATURE',    'TXT_KEY_GREAT_WORK_GABYAGA_GREAT_WORK_26',    'TXT_KEY_GREAT_WORK_QUOTE_GABYAGA_GREAT_WORK_26',        'AS2D_GREAT_ARTIST_ARTWORK',    'GreatWriter_Background.dds'),
('GREAT_WORK_GABYAGA_27',     'GREAT_WORK_LITERATURE',    'TXT_KEY_GREAT_WORK_GABYAGA_GREAT_WORK_27',    'TXT_KEY_GREAT_WORK_QUOTE_GABYAGA_GREAT_WORK_27',        'AS2D_GREAT_ARTIST_ARTWORK',    'GreatWriter_Background.dds'),
('GREAT_WORK_GABYAGA_28',     'GREAT_WORK_LITERATURE',    'TXT_KEY_GREAT_WORK_GABYAGA_GREAT_WORK_28',    'TXT_KEY_GREAT_WORK_QUOTE_GABYAGA_GREAT_WORK_28',        'AS2D_GREAT_ARTIST_ARTWORK',    'GreatWriter_Background.dds'),
('GREAT_WORK_GABYAGA_29',     'GREAT_WORK_LITERATURE',    'TXT_KEY_GREAT_WORK_GABYAGA_GREAT_WORK_29',    'TXT_KEY_GREAT_WORK_QUOTE_GABYAGA_GREAT_WORK_29',        'AS2D_GREAT_ARTIST_ARTWORK',    'GreatWriter_Background.dds'),
('GREAT_WORK_GABYAGA_30',     'GREAT_WORK_LITERATURE',    'TXT_KEY_GREAT_WORK_GABYAGA_GREAT_WORK_30',    'TXT_KEY_GREAT_WORK_QUOTE_GABYAGA_GREAT_WORK_30',        'AS2D_GREAT_ARTIST_ARTWORK',    'GreatWriter_Background.dds');
-- ======================================================================================================
-- DIPLOMACY
-- ======================================================================================================
INSERT INTO Diplomacy_Responses
(LeaderType,             ResponseType,                                     Response,                                                             Bias)
VALUES     ('LEADER_THP_SIAD_BARRE',     'RESPONSE_ATTACKED_HOSTILE',                     'TXT_KEY_LEADER_THP_SIAD_BARRE_ATTACKED_GENERIC%',                     500),
('LEADER_THP_SIAD_BARRE',     'RESPONSE_DEFEATED',                             'TXT_KEY_LEADER_THP_SIAD_BARRE_DEFEATED%',                             500),
('LEADER_THP_SIAD_BARRE',     'RESPONSE_DOW_GENERIC',                         'TXT_KEY_LEADER_THP_SIAD_BARRE_DOW_GENERIC%',                             500),
('LEADER_THP_SIAD_BARRE',     'RESPONSE_EXPANSION_SERIOUS_WARNING',             'TXT_KEY_LEADER_THP_SIAD_BARRE_EXPANSION_SERIOUS_WARNING%',             500),
('LEADER_THP_SIAD_BARRE',     'RESPONSE_FIRST_GREETING',                         'TXT_KEY_LEADER_THP_SIAD_BARRE_FIRSTGREETING%',                         500),
('LEADER_THP_SIAD_BARRE',     'RESPONSE_GREETING_AT_WAR_HOSTILE',             'TXT_KEY_LEADER_THP_SIAD_BARRE_GREETING_AT_WAR_HOSTILE%',                 500),
('LEADER_THP_SIAD_BARRE',     'RESPONSE_GREETING_POLITE_HELLO',                 'TXT_KEY_LEADER_THP_SIAD_BARRE_GREETING_POLITE_HELLO%',                 500),
('LEADER_THP_SIAD_BARRE',     'RESPONSE_GREETING_NEUTRAL_HELLO',                 'TXT_KEY_LEADER_THP_SIAD_BARRE_GREETING_NEUTRAL_HELLO%',                 500),
('LEADER_THP_SIAD_BARRE',     'RESPONSE_GREETING_HOSTILE_HELLO',                 'TXT_KEY_LEADER_THP_SIAD_BARRE_GREETING_HOSTILE_HELLO%',                 500),
('LEADER_THP_SIAD_BARRE',     'RESPONSE_HOSTILE_AGGRESSIVE_MILITARY_WARNING', 'TXT_KEY_LEADER_THP_SIAD_BARRE_HOSTILE_AGGRESSIVE_MILITARY_WARNING%',     500),
('LEADER_THP_SIAD_BARRE',     'RESPONSE_INFLUENTIAL_ON_AI',                     'TXT_KEY_LEADER_THP_SIAD_BARRE_INFLUENTIAL_ON_AI%',                     500),
('LEADER_THP_SIAD_BARRE',     'RESPONSE_INFLUENTIAL_ON_HUMAN',                 'TXT_KEY_LEADER_THP_SIAD_BARRE_INFLUENTIAL_ON_HUMAN%',                 500),
('LEADER_THP_SIAD_BARRE',     'RESPONSE_LETS_HEAR_IT',                         'TXT_KEY_LEADER_THP_SIAD_BARRE_LETS_HEAR_IT%',                         500),
('LEADER_THP_SIAD_BARRE',     'RESPONSE_LUXURY_TRADE',                         'TXT_KEY_LEADER_THP_SIAD_BARRE_LUXURY_TRADE%',                         500),
('LEADER_THP_SIAD_BARRE',     'RESPONSE_NO_PEACE',                             'TXT_KEY_LEADER_THP_SIAD_BARRE_NO_PEACE%',                             500),
('LEADER_THP_SIAD_BARRE',     'RESPONSE_OPEN_BORDERS_EXCHANGE',                 'TXT_KEY_LEADER_THP_SIAD_BARRE_OPEN_BORDERS_EXCHANGE%',                 500),
('LEADER_THP_SIAD_BARRE',     'RESPONSE_PEACE_MADE_BY_HUMAN_GRACIOUS',         'TXT_KEY_LEADER_THP_SIAD_BARRE_LOSEWAR%',                                 500),
('LEADER_THP_SIAD_BARRE',     'RESPONSE_REPEAT_NO',                             'TXT_KEY_LEADER_THP_SIAD_BARRE_REPEAT_NO%',                             500),
('LEADER_THP_SIAD_BARRE',     'RESPONSE_RESPONSE_REQUEST',                     'TXT_KEY_LEADER_THP_SIAD_BARRE_RESPONSE_REQUEST%',                     500),
('LEADER_THP_SIAD_BARRE',     'RESPONSE_RESPONSE_TO_BEING_DENOUNCED',         'TXT_KEY_LEADER_THP_SIAD_BARRE_RESPONSE_TO_BEING_DENOUNCED%',             500),
('LEADER_THP_SIAD_BARRE',     'RESPONSE_TOO_SOON_NO_PEACE',                     'TXT_KEY_LEADER_THP_SIAD_BARRE_TOO_SOON_NO_PEACE_1%',                     500),
('LEADER_THP_SIAD_BARRE',     'RESPONSE_WINNER_PEACE_OFFER',                     'TXT_KEY_LEADER_THP_SIAD_BARRE_WINWAR%',                                 500),
('LEADER_THP_SIAD_BARRE',     'RESPONSE_WORK_AGAINST_SOMEONE',                 'TXT_KEY_LEADER_THP_SIAD_BARRE_DENOUNCE%',                             500),
('LEADER_THP_SIAD_BARRE',     'RESPONSE_WORK_WITH_US',                         'TXT_KEY_LEADER_THP_SIAD_BARRE_DEC_FRIENDSHIP%',                         500);
-- ======================================================================================================
-- ======================================================================================================
