-- Northern Yuan
-- ======================================================================================================
-- CIVILIZATIONS
-- ======================================================================================================
-- Civilizations
----------------
INSERT INTO Civilizations
       (Type,                         Description,                       ShortDescription,                          Adjective,                          Civilopedia,                         CivilopediaTag,      DefaultPlayerColor,       ArtDefineTag,   ArtStyleType,  ArtStyleSuffix, ArtStylePrefix,                  IconAtlas,        PortraitIndex,  AlphaIconAtlas,               SoundtrackTag,   MapImage,                   DawnOfManQuote,                   DawnOfManImage)
SELECT 'CIVILIZATION_THP_NORTHYUAN', 'TXT_KEY_CIV_THP_NORTHYUAN_DESC',  'TXT_KEY_CIV_THP_NORTHYUAN_SHORT_DESC',   'TXT_KEY_CIV_THP_NORTHYUAN_ADJECTIVE',    'TXT_KEY_PEDIA_THP_NORTHYUAN_TEXT',  'TXT_KEY_PEDIA_THP_NORTHYUAN', 'PLAYERCOLOR_THP_NORTHYUAN',     ArtDefineTag,   ArtStyleType,  ArtStyleSuffix, ArtStylePrefix,    'THP_NORTHYUAN_ATLAS',   0,             'THP_NORTHYUAN_ALPHA_ATLAS',   SoundtrackTag,  'Map_Mandukhai.dds',  'TXT_KEY_CIV5_DAWN_THP_NORTHYUAN_TEXT',   'Mandukhai_DOM.dds'
FROM Civilizations WHERE Type = 'CIVILIZATION_MONGOL';
-------------------------
-- Civilization_CityNames
-------------------------
INSERT INTO Civilization_CityNames
        (CivilizationType,                 CityName)
VALUES  ('CIVILIZATION_THP_NORTHYUAN',     'TXT_KEY_CITY_NAME_THP_NORTHYUAN_1'),
        ('CIVILIZATION_THP_NORTHYUAN',     'TXT_KEY_CITY_NAME_THP_NORTHYUAN_2'),
        ('CIVILIZATION_THP_NORTHYUAN',     'TXT_KEY_CITY_NAME_THP_NORTHYUAN_3'),
        ('CIVILIZATION_THP_NORTHYUAN',     'TXT_KEY_CITY_NAME_THP_NORTHYUAN_4'),
        ('CIVILIZATION_THP_NORTHYUAN',     'TXT_KEY_CITY_NAME_THP_NORTHYUAN_5'),
        ('CIVILIZATION_THP_NORTHYUAN',     'TXT_KEY_CITY_NAME_THP_NORTHYUAN_6'),
        ('CIVILIZATION_THP_NORTHYUAN',     'TXT_KEY_CITY_NAME_THP_NORTHYUAN_7'),
        ('CIVILIZATION_THP_NORTHYUAN',     'TXT_KEY_CITY_NAME_THP_NORTHYUAN_8'),
        ('CIVILIZATION_THP_NORTHYUAN',     'TXT_KEY_CITY_NAME_THP_NORTHYUAN_9'),
        ('CIVILIZATION_THP_NORTHYUAN',     'TXT_KEY_CITY_NAME_THP_NORTHYUAN_10'),
        ('CIVILIZATION_THP_NORTHYUAN',     'TXT_KEY_CITY_NAME_THP_NORTHYUAN_11'),
        ('CIVILIZATION_THP_NORTHYUAN',     'TXT_KEY_CITY_NAME_THP_NORTHYUAN_12'),
        ('CIVILIZATION_THP_NORTHYUAN',     'TXT_KEY_CITY_NAME_THP_NORTHYUAN_13'),
        ('CIVILIZATION_THP_NORTHYUAN',     'TXT_KEY_CITY_NAME_THP_NORTHYUAN_14'),
        ('CIVILIZATION_THP_NORTHYUAN',     'TXT_KEY_CITY_NAME_THP_NORTHYUAN_15'),
        ('CIVILIZATION_THP_NORTHYUAN',     'TXT_KEY_CITY_NAME_THP_NORTHYUAN_16'),
        ('CIVILIZATION_THP_NORTHYUAN',     'TXT_KEY_CITY_NAME_THP_NORTHYUAN_17'),
        ('CIVILIZATION_THP_NORTHYUAN',     'TXT_KEY_CITY_NAME_THP_NORTHYUAN_18'),
        ('CIVILIZATION_THP_NORTHYUAN',     'TXT_KEY_CITY_NAME_THP_NORTHYUAN_19'),
        ('CIVILIZATION_THP_NORTHYUAN',     'TXT_KEY_CITY_NAME_THP_NORTHYUAN_20'),
        ('CIVILIZATION_THP_NORTHYUAN',     'TXT_KEY_CITY_NAME_THP_NORTHYUAN_21'),
        ('CIVILIZATION_THP_NORTHYUAN',     'TXT_KEY_CITY_NAME_THP_NORTHYUAN_22'),
        ('CIVILIZATION_THP_NORTHYUAN',     'TXT_KEY_CITY_NAME_THP_NORTHYUAN_23'),
        ('CIVILIZATION_THP_NORTHYUAN',     'TXT_KEY_CITY_NAME_THP_NORTHYUAN_24'),
        ('CIVILIZATION_THP_NORTHYUAN',     'TXT_KEY_CITY_NAME_THP_NORTHYUAN_25'),
        ('CIVILIZATION_THP_NORTHYUAN',     'TXT_KEY_CITY_NAME_THP_NORTHYUAN_26'),
        ('CIVILIZATION_THP_NORTHYUAN',     'TXT_KEY_CITY_NAME_THP_NORTHYUAN_27'),
        ('CIVILIZATION_THP_NORTHYUAN',     'TXT_KEY_CITY_NAME_THP_NORTHYUAN_28'),
        ('CIVILIZATION_THP_NORTHYUAN',     'TXT_KEY_CITY_NAME_THP_NORTHYUAN_29');
-----------------------------------
-- Civilization_FreeBuildingClasses
-----------------------------------
INSERT INTO Civilization_FreeBuildingClasses
          (CivilizationType,               BuildingClassType)
SELECT    'CIVILIZATION_THP_NORTHYUAN',    BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE CivilizationType = 'CIVILIZATION_MONGOL';
-------------------------
-- Civilization_FreeTechs
-------------------------
INSERT INTO Civilization_FreeTechs
          (CivilizationType,               TechType)
SELECT    'CIVILIZATION_THP_NORTHYUAN',    TechType
FROM Civilization_FreeTechs WHERE CivilizationType = 'CIVILIZATION_MONGOL';
-------------------------
-- Civilization_FreeUnits
-------------------------
INSERT INTO Civilization_FreeUnits
          (CivilizationType,               UnitClassType, Count, UnitAIType)
SELECT    'CIVILIZATION_THP_NORTHYUAN',    UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE CivilizationType = 'CIVILIZATION_MONGOL';
-----------------------
-- Civilization_Leaders
-----------------------
INSERT INTO Civilization_Leaders
       (CivilizationType,              LeaderheadType)
VALUES ('CIVILIZATION_THP_NORTHYUAN', 'LEADER_THP_MANDUKHAI');
----------------------------------
-- Civilization_UnitClassOverrides
----------------------------------
INSERT INTO Civilization_UnitClassOverrides
        (CivilizationType,              UnitClassType,         UnitType)
VALUES  ('CIVILIZATION_THP_NORTHYUAN', 'UNITCLASS_TREBUCHET', 'UNIT_THP_HUIHUI_PAO'),
        ('CIVILIZATION_THP_NORTHYUAN', 'UNITCLASS_LANCER',    'UNIT_THP_CHONGZU');
-------------------------
------------------------
-- Civilization_SpyNames
------------------------
INSERT INTO Civilization_SpyNames
          (CivilizationType,                 SpyName)
VALUES    ('CIVILIZATION_THP_NORTHYUAN',     'TXT_KEY_SPY_NAME_THP_NORTHYUAN_0'),
          ('CIVILIZATION_THP_NORTHYUAN',     'TXT_KEY_SPY_NAME_THP_NORTHYUAN_1'),
          ('CIVILIZATION_THP_NORTHYUAN',     'TXT_KEY_SPY_NAME_THP_NORTHYUAN_2'),
          ('CIVILIZATION_THP_NORTHYUAN',     'TXT_KEY_SPY_NAME_THP_NORTHYUAN_3'),
          ('CIVILIZATION_THP_NORTHYUAN',     'TXT_KEY_SPY_NAME_THP_NORTHYUAN_4'),
          ('CIVILIZATION_THP_NORTHYUAN',     'TXT_KEY_SPY_NAME_THP_NORTHYUAN_5'),
          ('CIVILIZATION_THP_NORTHYUAN',     'TXT_KEY_SPY_NAME_THP_NORTHYUAN_6'),
          ('CIVILIZATION_THP_NORTHYUAN',     'TXT_KEY_SPY_NAME_THP_NORTHYUAN_7'),
          ('CIVILIZATION_THP_NORTHYUAN',     'TXT_KEY_SPY_NAME_THP_NORTHYUAN_8'),
          ('CIVILIZATION_THP_NORTHYUAN',     'TXT_KEY_SPY_NAME_THP_NORTHYUAN_9');
-- ======================================================================================================
-- LEADERS
-- ======================================================================================================
-- Leaders
----------
INSERT INTO Leaders
(Type,                              Description,                   Civilopedia,                               CivilopediaTag,                    ArtDefineTag,             VictoryCompetitiveness,  WonderCompetitiveness,     MinorCivCompetitiveness,     Boldness,     DiploBalance,   WarmongerHate,     DenounceWillingness,     DoFWillingness, Loyalty,     Neediness,    Forgiveness,    Chattiness, Meanness,     IconAtlas,             PortraitIndex)
VALUES    ('LEADER_THP_MANDUKHAI',     'TXT_KEY_LEADER_THP_MANDUKHAI',    'TXT_KEY_LEADER_THP_MANDUKHAI_PEDIA_TEXT',  'TXT_KEY_LEADER_THP_MANDUKHAI_PEDIA', 'Leaderhead_Mandukhai.xml',    7,                          3,                         6,                   10,            6,              2,                 5,                                 4,              5,           2,            5,              4,          7,           'THP_NORTHYUAN_ATLAS',   1);
--------------------------------
-- Leader_MajorCivApproachBiases
--------------------------------
INSERT INTO Leader_MajorCivApproachBiases
          (LeaderType,                  MajorCivApproachType,              Bias)
VALUES    ('LEADER_THP_MANDUKHAI',     'MAJOR_CIV_APPROACH_WAR',           8),
          ('LEADER_THP_MANDUKHAI',     'MAJOR_CIV_APPROACH_HOSTILE',       6),
          ('LEADER_THP_MANDUKHAI',     'MAJOR_CIV_APPROACH_DECEPTIVE',     2),
          ('LEADER_THP_MANDUKHAI',     'MAJOR_CIV_APPROACH_GUARDED',       4),
          ('LEADER_THP_MANDUKHAI',     'MAJOR_CIV_APPROACH_AFRAID',        1),
          ('LEADER_THP_MANDUKHAI',     'MAJOR_CIV_APPROACH_FRIENDLY',      4),
          ('LEADER_THP_MANDUKHAI',     'MAJOR_CIV_APPROACH_NEUTRAL',       5);
--------------------------------
-- Leader_MinorCivApproachBiases
--------------------------------
INSERT INTO Leader_MinorCivApproachBiases
          (LeaderType,                  MinorCivApproachType,              Bias)
VALUES    ('LEADER_THP_MANDUKHAI',     'MINOR_CIV_APPROACH_IGNORE',        6),
          ('LEADER_THP_MANDUKHAI',     'MINOR_CIV_APPROACH_FRIENDLY',      3),
          ('LEADER_THP_MANDUKHAI',     'MINOR_CIV_APPROACH_PROTECTIVE',    2),
          ('LEADER_THP_MANDUKHAI',     'MINOR_CIV_APPROACH_CONQUEST',      8),
          ('LEADER_THP_MANDUKHAI',     'MINOR_CIV_APPROACH_BULLY',         6);
-----------------
-- Leader_Flavors
-----------------
INSERT INTO Leader_Flavors
          (LeaderType,                  FlavorType,                        Flavor)
VALUES    ('LEADER_THP_MANDUKHAI',     'FLAVOR_OFFENSE',                   9),
          ('LEADER_THP_MANDUKHAI',     'FLAVOR_DEFENSE',                   5),
          ('LEADER_THP_MANDUKHAI',     'FLAVOR_CITY_DEFENSE',              4),
          ('LEADER_THP_MANDUKHAI',     'FLAVOR_MILITARY_TRAINING',         9),
          ('LEADER_THP_MANDUKHAI',     'FLAVOR_RECON',                     6),
          ('LEADER_THP_MANDUKHAI',     'FLAVOR_RANGED',                    7),
          ('LEADER_THP_MANDUKHAI',     'FLAVOR_MOBILE',                    3),
          ('LEADER_THP_MANDUKHAI',     'FLAVOR_NAVAL',                     4),
          ('LEADER_THP_MANDUKHAI',     'FLAVOR_NAVAL_RECON',               2),
          ('LEADER_THP_MANDUKHAI',     'FLAVOR_NAVAL_GROWTH',              2),
          ('LEADER_THP_MANDUKHAI',     'FLAVOR_NAVAL_TILE_IMPROVEMENT',    2),
          ('LEADER_THP_MANDUKHAI',     'FLAVOR_AIR',                       7),
          ('LEADER_THP_MANDUKHAI',     'FLAVOR_EXPANSION',                 7),
          ('LEADER_THP_MANDUKHAI',     'FLAVOR_GROWTH',                    5),
          ('LEADER_THP_MANDUKHAI',     'FLAVOR_TILE_IMPROVEMENT',          5),
          ('LEADER_THP_MANDUKHAI',     'FLAVOR_INFRASTRUCTURE',            4),
          ('LEADER_THP_MANDUKHAI',     'FLAVOR_PRODUCTION',                5),
          ('LEADER_THP_MANDUKHAI',     'FLAVOR_GOLD',                      6),
          ('LEADER_THP_MANDUKHAI',     'FLAVOR_SCIENCE',                   6),
          ('LEADER_THP_MANDUKHAI',     'FLAVOR_CULTURE',                   2),
          ('LEADER_THP_MANDUKHAI',     'FLAVOR_HAPPINESS',                 2),
          ('LEADER_THP_MANDUKHAI',     'FLAVOR_GREAT_PEOPLE',              3),
          ('LEADER_THP_MANDUKHAI',     'FLAVOR_WONDER',                    1),
          ('LEADER_THP_MANDUKHAI',     'FLAVOR_RELIGION',                  5),
          ('LEADER_THP_MANDUKHAI',     'FLAVOR_DIPLOMACY',                 4),
          ('LEADER_THP_MANDUKHAI',     'FLAVOR_SPACESHIP',                 5),
          ('LEADER_THP_MANDUKHAI',     'FLAVOR_WATER_CONNECTION',          3),
          ('LEADER_THP_MANDUKHAI',     'FLAVOR_NUKE',                      4),
          ('LEADER_THP_MANDUKHAI',     'FLAVOR_USE_NUKE',                  7),
          ('LEADER_THP_MANDUKHAI',     'FLAVOR_ESPIONAGE',                 5),
          ('LEADER_THP_MANDUKHAI',     'FLAVOR_ANTIAIR',                   8),
          ('LEADER_THP_MANDUKHAI',     'FLAVOR_AIRLIFT',                   6),
          ('LEADER_THP_MANDUKHAI',     'FLAVOR_I_TRADE_DESTINATION',       7),
          ('LEADER_THP_MANDUKHAI',     'FLAVOR_I_TRADE_ORIGIN',            5),
          ('LEADER_THP_MANDUKHAI',     'FLAVOR_I_SEA_TRADE_ROUTE',         2),
          ('LEADER_THP_MANDUKHAI',     'FLAVOR_I_LAND_TRADE_ROUTE',        5),
          ('LEADER_THP_MANDUKHAI',     'FLAVOR_ARCHAEOLOGY',               2),
          ('LEADER_THP_MANDUKHAI',     'FLAVOR_AIR_CARRIER',               5);
----------------
-- Leader_Traits
----------------
INSERT INTO Leader_Traits
       (LeaderType,                TraitType)
VALUES ('LEADER_THP_MANDUKHAI',   'TRAIT_THP_NORTHYUAN');
-- ======================================================================================================
-- TRAITS
-- ======================================================================================================
-- Traits
---------
INSERT INTO Traits
       (Type,                      Description,                     ShortDescription)
VALUES ('TRAIT_THP_NORTHYUAN',    'TXT_KEY_TRAIT_THP_NORTHYUAN',   'TXT_KEY_TRAIT_THP_NORTHYUAN_SHORT');
-- ======================================================================================================
-- PROMOTIONS
-- ======================================================================================================
-- UnitPromotions
-----------------
INSERT INTO UnitPromotions
(Type,                                           Description,                                                       Help,                                          Sound,              HasPostCombatPromotions, MovesChange, ExperiencePercent,                CannotBeChosen, PortraitIndex,   IconAtlas,            PediaType,          PediaEntry)
VALUES    ('PROMOTION_THP_MANDUKHAI_MOVES',         'TXT_KEY_PROMOTION_THP_MANDUKHAI_MOVES',     'TXT_KEY_PROMOTION_THP_MANDUKHAI_MOVES_HELP',     'AS2D_IF_LEVELUP',   0,  1,        0,                                 1,              59,              'ABILITY_ATLAS',     'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_THP_MANDUKHAI_MOVES_HELP'),
('PROMOTION_THP_HUIHUI_PAO',         'TXT_KEY_PROMOTION_THP_HUIHUI_PAO',     'TXT_KEY_PROMOTION_THP_HUIHUI_PAO_HELP',     'AS2D_IF_LEVELUP',    1,  0,        0,                                  1,              59,              'ABILITY_ATLAS',     'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_THP_HUIHUI_PAO_HELP'),
('PROMOTION_THP_CHONGZU',         'TXT_KEY_PROMOTION_THP_CHONGZU',     'TXT_KEY_PROMOTION_THP_CHONGZU_HELP',     'AS2D_IF_LEVELUP', 0,  0,        100,                                 1,              59,              'ABILITY_ATLAS',     'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_THP_CHONGZU_HELP'),
('PROMOTION_THP_HHP_POSTCOMBAT',         'TXT_KEY_PROMOTION_THP_HHP_POSTCOMBAT',     'TXT_KEY_PROMOTION_THP_HHP_POSTCOMBAT_HELP',     'AS2D_IF_LEVELUP',    0,  0,        0,                                 1,              59,              'ABILITY_ATLAS',     'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_THP_HHP_POSTCOMBAT_HELP');
-------------------------------------------
-- UnitPromotions_PostCombatRandomPromotion
-------------------------------------------
INSERT INTO UnitPromotions_PostCombatRandomPromotion
          (PromotionType,                   NewPromotion)
VALUES    ('PROMOTION_THP_HUIHUI_PAO',     'PROMOTION_THP_HHP_POSTCOMBAT');
--------------------------------
-- UnitPromotions_UnitCombats
--------------------------------
INSERT INTO UnitPromotions_UnitCombats
        (PromotionType,                         UnitCombatType)
VALUES  ('PROMOTION_THP_HUIHUI_PAO',           'UNITCOMBAT_SIEGE'),
        ('PROMOTION_THP_HHP_POSTCOMBAT',       'UNITCOMBAT_SIEGE');
-- ======================================================================================================
-- UNITS
-- ======================================================================================================
-- Units
--------
INSERT INTO Units
(Type,                             Class,    CombatClass, WorkRate, PrereqTech, Combat, RangedCombat, Range, FaithCost, RequiresFaithPurchaseEnabled, Cost, Moves, Domain, DefaultUnitAI, CivilianAttackPriority, Special, Description,                       Help,                                                     Strategy,                                    Civilopedia,                       MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, AdvancedStartCost, MinAreaSize, GoodyHutUpgradeUnitClass, CombatLimit, XPValueAttack, XPValueDefense, Conscription,  UnitArtInfo,                           UnitFlagAtlas,                      UnitFlagIconOffset,    IconAtlas,        PortraitIndex,  MoveRate)
SELECT    'UNIT_THP_HUIHUI_PAO',   Class,    CombatClass, '300', PrereqTech, Combat, RangedCombat, Range, FaithCost, RequiresFaithPurchaseEnabled, Cost-20, Moves, Domain, DefaultUnitAI, CivilianAttackPriority, Special, 'TXT_KEY_UNIT_THP_HUIHUI_PAO',    'TXT_KEY_UNIT_THP_HUIHUI_PAO_HELP',    'TXT_KEY_UNIT_THP_HUIHUI_PAO_STRATEGY',     'TXT_KEY_UNIT_THP_HUIHUI_PAO_TEXT', MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, AdvancedStartCost, MinAreaSize, GoodyHutUpgradeUnitClass, CombatLimit, XPValueAttack, XPValueDefense, Conscription, 'ART_DEF_UNIT_THP_HUIHUI_PAO', 'THP_UNIT_HUIHUI_PAO_FLAG_ATLAS',   0,                    'THP_NORTHYUAN_ATLAS',   2,              MoveRate
FROM Units WHERE Type = 'UNIT_TREBUCHET';

INSERT INTO Units
(Class,            Type,                     PrereqTech, Combat, RangedCombat, Range, Cost, FaithCost, RequiresFaithPurchaseEnabled, Moves, CombatClass, Domain, DefaultUnitAI, Description,                 Civilopedia,                                                Strategy,                                Help,                              MilitarySupport,      MilitaryProduction, Pillage, IgnoreBuildingDefense, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, ObsoleteTech, XPValueDefense, UnitArtInfo,                       UnitFlagIconOffset,     UnitFlagAtlas,                   PortraitIndex,     IconAtlas,        MoveRate)
SELECT  Class,    'UNIT_THP_CHONGZU',    'TECH_GUNPOWDER', Combat, RangedCombat, Range, Cost, FaithCost, RequiresFaithPurchaseEnabled, Moves, CombatClass, Domain, DefaultUnitAI, 'TXT_KEY_UNIT_THP_CHONGZU',  'TXT_KEY_UNIT_THP_CHONGZU_TEXT',     'TXT_KEY_UNIT_THP_CHONGZU_STRATEGY',     'TXT_KEY_UNIT_THP_CHONGZU_HELP',     MilitarySupport, MilitaryProduction, Pillage, IgnoreBuildingDefense, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, ObsoleteTech, XPValueDefense, 'ART_DEF_UNIT_THP_CHONGZU',    0,                    'THP_UNIT_CHONGZU_FLAG_ATLAS',    3,                'THP_NORTHYUAN_ATLAS',  MoveRate
FROM Units WHERE Type = 'UNIT_LANCER';
------------------------
-- UnitGameplay2DScripts
------------------------
INSERT INTO UnitGameplay2DScripts
       (UnitType,              SelectionSound, FirstSelectionSound)
SELECT 'UNIT_THP_HUIHUI_PAO',  SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_TREBUCHET';

INSERT INTO UnitGameplay2DScripts
       (UnitType,           SelectionSound, FirstSelectionSound)
SELECT 'UNIT_THP_CHONGZU',  SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_LANCER';
---------------
-- Unit_Flavors
---------------
INSERT INTO Unit_Flavors
       (UnitType,              FlavorType, Flavor)
SELECT 'UNIT_THP_HUIHUI_PAO',  FlavorType, Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_TREBUCHET';

INSERT INTO Unit_Flavors
       (UnitType,           FlavorType, Flavor)
SELECT 'UNIT_THP_CHONGZU',  FlavorType, Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_LANCER';
----------------------
-- Unit_FreePromotions
----------------------
INSERT INTO Unit_FreePromotions
        (UnitType,              PromotionType)
SELECT  'UNIT_THP_HUIHUI_PAO',  PromotionType
FROM Unit_FreePromotions WHERE UnitType = 'UNIT_TREBUCHET';

INSERT INTO Unit_FreePromotions
        (UnitType,           PromotionType)
SELECT  'UNIT_THP_CHONGZU',  PromotionType
FROM Unit_FreePromotions WHERE UnitType = 'UNIT_LANCER';

DELETE FROM Unit_FreePromotions
WHERE UnitType = 'UNIT_THP_CHONGZU' AND PromotionType = 'PROMOTION_CITY_PENALTY';

INSERT INTO Unit_FreePromotions
        (UnitType,                   PromotionType)
VALUES  ('UNIT_THP_HUIHUI_PAO',     'PROMOTION_THP_HUIHUI_PAO'),
        ('UNIT_THP_CHONGZU',        'PROMOTION_THP_CHONGZU');
---------------------
-- Unit_ClassUpgrades
---------------------
INSERT INTO Unit_ClassUpgrades
        (UnitType,              UnitClassType)
SELECT  'UNIT_THP_HUIHUI_PAO',  UnitClassType
FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_TREBUCHET';

INSERT INTO Unit_ClassUpgrades
        (UnitType,           UnitClassType)
SELECT  'UNIT_THP_CHONGZU',  UnitClassType
FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_LANCER';
------------------------------------
-- Unit_ResourceQuantityRequirements
------------------------------------
INSERT INTO Unit_ResourceQuantityRequirements
        (UnitType,           ResourceType)
SELECT  'UNIT_THP_CHONGZU',  ResourceType
FROM Unit_ResourceQuantityRequirements WHERE UnitType = 'UNIT_LANCER';
--------------
-- Unit_Builds
--------------
INSERT INTO Unit_Builds
        (UnitType,               BuildType)
VALUES  ('UNIT_THP_HUIHUI_PAO', 'BUILD_REMOVE_FOREST');
-- ======================================================================================================
-- DIPLOMACY
-- ======================================================================================================
INSERT INTO Diplomacy_Responses
(LeaderType,             ResponseType,                                     Response,                                                             Bias)
VALUES     ('LEADER_THP_MANDUKHAI',     'RESPONSE_ATTACKED_HOSTILE',                     'TXT_KEY_LEADER_THP_MANDUKHAI_ATTACKED_GENERIC%',                     500),
('LEADER_THP_MANDUKHAI',     'RESPONSE_DEFEATED',                             'TXT_KEY_LEADER_THP_MANDUKHAI_DEFEATED%',                             500),
('LEADER_THP_MANDUKHAI',     'RESPONSE_DOW_GENERIC',                         'TXT_KEY_LEADER_THP_MANDUKHAI_DOW_GENERIC%',                             500),
('LEADER_THP_MANDUKHAI',     'RESPONSE_EXPANSION_SERIOUS_WARNING',             'TXT_KEY_LEADER_THP_MANDUKHAI_EXPANSION_SERIOUS_WARNING%',             500),
('LEADER_THP_MANDUKHAI',     'RESPONSE_FIRST_GREETING',                         'TXT_KEY_LEADER_THP_MANDUKHAI_FIRSTGREETING%',                         500),
('LEADER_THP_MANDUKHAI',     'RESPONSE_GREETING_AT_WAR_HOSTILE',             'TXT_KEY_LEADER_THP_MANDUKHAI_GREETING_AT_WAR_HOSTILE%',                 500),
('LEADER_THP_MANDUKHAI',     'RESPONSE_GREETING_POLITE_HELLO',                 'TXT_KEY_LEADER_THP_MANDUKHAI_GREETING_POLITE_HELLO%',                 500),
('LEADER_THP_MANDUKHAI',     'RESPONSE_GREETING_NEUTRAL_HELLO',                 'TXT_KEY_LEADER_THP_MANDUKHAI_GREETING_NEUTRAL_HELLO%',                 500),
('LEADER_THP_MANDUKHAI',     'RESPONSE_GREETING_HOSTILE_HELLO',                 'TXT_KEY_LEADER_THP_MANDUKHAI_GREETING_HOSTILE_HELLO%',                 500),
('LEADER_THP_MANDUKHAI',     'RESPONSE_HOSTILE_AGGRESSIVE_MILITARY_WARNING', 'TXT_KEY_LEADER_THP_MANDUKHAI_HOSTILE_AGGRESSIVE_MILITARY_WARNING%',     500),
('LEADER_THP_MANDUKHAI',     'RESPONSE_INFLUENTIAL_ON_AI',                     'TXT_KEY_LEADER_THP_MANDUKHAI_INFLUENTIAL_ON_AI%',                     500),
('LEADER_THP_MANDUKHAI',     'RESPONSE_INFLUENTIAL_ON_HUMAN',                 'TXT_KEY_LEADER_THP_MANDUKHAI_INFLUENTIAL_ON_HUMAN%',                 500),
('LEADER_THP_MANDUKHAI',     'RESPONSE_LETS_HEAR_IT',                         'TXT_KEY_LEADER_THP_MANDUKHAI_LETS_HEAR_IT%',                         500),
('LEADER_THP_MANDUKHAI',     'RESPONSE_LUXURY_TRADE',                         'TXT_KEY_LEADER_THP_MANDUKHAI_LUXURY_TRADE%',                         500),
('LEADER_THP_MANDUKHAI',     'RESPONSE_NO_PEACE',                             'TXT_KEY_LEADER_THP_MANDUKHAI_NO_PEACE%',                             500),
('LEADER_THP_MANDUKHAI',     'RESPONSE_OPEN_BORDERS_EXCHANGE',                 'TXT_KEY_LEADER_THP_MANDUKHAI_OPEN_BORDERS_EXCHANGE%',                 500),
('LEADER_THP_MANDUKHAI',     'RESPONSE_PEACE_MADE_BY_HUMAN_GRACIOUS',         'TXT_KEY_LEADER_THP_MANDUKHAI_LOSEWAR%',                                 500),
('LEADER_THP_MANDUKHAI',     'RESPONSE_REPEAT_NO',                             'TXT_KEY_LEADER_THP_MANDUKHAI_REPEAT_NO%',                             500),
('LEADER_THP_MANDUKHAI',     'RESPONSE_RESPONSE_REQUEST',                     'TXT_KEY_LEADER_THP_MANDUKHAI_RESPONSE_REQUEST%',                     500),
('LEADER_THP_MANDUKHAI',     'RESPONSE_RESPONSE_TO_BEING_DENOUNCED',         'TXT_KEY_LEADER_THP_MANDUKHAI_RESPONSE_TO_BEING_DENOUNCED%',             500),
('LEADER_THP_MANDUKHAI',     'RESPONSE_TOO_SOON_NO_PEACE',                     'TXT_KEY_LEADER_THP_MANDUKHAI_TOO_SOON_NO_PEACE_1%',                     500),
('LEADER_THP_MANDUKHAI',     'RESPONSE_WINNER_PEACE_OFFER',                     'TXT_KEY_LEADER_THP_MANDUKHAI_WINWAR%',                                 500),
('LEADER_THP_MANDUKHAI',     'RESPONSE_WORK_AGAINST_SOMEONE',                 'TXT_KEY_LEADER_THP_MANDUKHAI_DENOUNCE%',                             500),
('LEADER_THP_MANDUKHAI',     'RESPONSE_WORK_WITH_US',                         'TXT_KEY_LEADER_THP_MANDUKHAI_DEC_FRIENDSHIP%',                         500);
-- ======================================================================================================
-- ======================================================================================================
