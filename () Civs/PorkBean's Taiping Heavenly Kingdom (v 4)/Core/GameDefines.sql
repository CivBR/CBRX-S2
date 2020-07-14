-- Game Defines for the Heavenly Kingdom, by PorkBean
-- ======================================================================================================
-- CIVILIZATIONS
-- ======================================================================================================
-- Civilizations
----------------
INSERT INTO Civilizations
       (Type,                         Description,                       ShortDescription,                          Adjective,                          Civilopedia,                         CivilopediaTag,      DefaultPlayerColor,       ArtDefineTag,   ArtStyleType,  ArtStyleSuffix, ArtStylePrefix,                  IconAtlas,        PortraitIndex,  AlphaIconAtlas,               SoundtrackTag,   MapImage,                   DawnOfManQuote,                   DawnOfManImage)
SELECT 'CIVILIZATION_PB_TAIPING', 'TXT_KEY_CIV_PB_TAIPING_DESC',  'TXT_KEY_CIV_PB_TAIPING_SHORT_DESC',   'TXT_KEY_CIV_PB_TAIPING_ADJECTIVE',    'TXT_KEY_PEDIA_PB_TAIPING_TEXT',  'TXT_KEY_PEDIA_PB_TAIPING', 'PLAYERCOLOR_PB_TAIPING',     ArtDefineTag,   ArtStyleType,  ArtStyleSuffix, ArtStylePrefix,					'TAIPING_ICON_ATLAS',   0,             'TAIPING_ALPHA_ATLAS',   SoundtrackTag,							 'Taiping_Map.dds',  'TXT_KEY_CIV5_DAWN_PB_TAIPING_TEXT',   'Taiping_DOM.dds'
FROM Civilizations WHERE Type = 'CIVILIZATION_CHINA';
-------------------------
-- Civilization_CityNames
-------------------------
INSERT INTO Civilization_CityNames
          (CivilizationType,                    CityName)
VALUES    ('CIVILIZATION_PB_TAIPING',     'TXT_KEY_CITY_NAME_PB_TAIPING_1'),
          ('CIVILIZATION_PB_TAIPING',     'TXT_KEY_CITY_NAME_PB_TAIPING_2'),
          ('CIVILIZATION_PB_TAIPING',     'TXT_KEY_CITY_NAME_PB_TAIPING_3'),
          ('CIVILIZATION_PB_TAIPING',     'TXT_KEY_CITY_NAME_PB_TAIPING_4'),
          ('CIVILIZATION_PB_TAIPING',     'TXT_KEY_CITY_NAME_PB_TAIPING_5'),
          ('CIVILIZATION_PB_TAIPING',     'TXT_KEY_CITY_NAME_PB_TAIPING_6'),
          ('CIVILIZATION_PB_TAIPING',     'TXT_KEY_CITY_NAME_PB_TAIPING_7'),
          ('CIVILIZATION_PB_TAIPING',     'TXT_KEY_CITY_NAME_PB_TAIPING_8'),
          ('CIVILIZATION_PB_TAIPING',     'TXT_KEY_CITY_NAME_PB_TAIPING_9'),
          ('CIVILIZATION_PB_TAIPING',     'TXT_KEY_CITY_NAME_PB_TAIPING_10'),
          ('CIVILIZATION_PB_TAIPING',     'TXT_KEY_CITY_NAME_PB_TAIPING_11'),
          ('CIVILIZATION_PB_TAIPING',     'TXT_KEY_CITY_NAME_PB_TAIPING_12'),
          ('CIVILIZATION_PB_TAIPING',     'TXT_KEY_CITY_NAME_PB_TAIPING_13'),
          ('CIVILIZATION_PB_TAIPING',     'TXT_KEY_CITY_NAME_PB_TAIPING_14'),
          ('CIVILIZATION_PB_TAIPING',     'TXT_KEY_CITY_NAME_PB_TAIPING_15'),
          ('CIVILIZATION_PB_TAIPING',     'TXT_KEY_CITY_NAME_PB_TAIPING_16'),
          ('CIVILIZATION_PB_TAIPING',     'TXT_KEY_CITY_NAME_PB_TAIPING_17'),
          ('CIVILIZATION_PB_TAIPING',     'TXT_KEY_CITY_NAME_PB_TAIPING_18'),
          ('CIVILIZATION_PB_TAIPING',     'TXT_KEY_CITY_NAME_PB_TAIPING_19'),
          ('CIVILIZATION_PB_TAIPING',     'TXT_KEY_CITY_NAME_PB_TAIPING_20'),
          ('CIVILIZATION_PB_TAIPING',     'TXT_KEY_CITY_NAME_PB_TAIPING_21'),
          ('CIVILIZATION_PB_TAIPING',     'TXT_KEY_CITY_NAME_PB_TAIPING_22'),
          ('CIVILIZATION_PB_TAIPING',     'TXT_KEY_CITY_NAME_PB_TAIPING_23'),
          ('CIVILIZATION_PB_TAIPING',     'TXT_KEY_CITY_NAME_PB_TAIPING_24'),
          ('CIVILIZATION_PB_TAIPING',     'TXT_KEY_CITY_NAME_PB_TAIPING_25'),
          ('CIVILIZATION_PB_TAIPING',     'TXT_KEY_CITY_NAME_PB_TAIPING_26'),
          ('CIVILIZATION_PB_TAIPING',     'TXT_KEY_CITY_NAME_PB_TAIPING_27'),
          ('CIVILIZATION_PB_TAIPING',     'TXT_KEY_CITY_NAME_PB_TAIPING_28'),
          ('CIVILIZATION_PB_TAIPING',     'TXT_KEY_CITY_NAME_PB_TAIPING_29');

-----------------------------------
-- Civilization_FreeBuildingClasses
-----------------------------------
INSERT INTO Civilization_FreeBuildingClasses
          (CivilizationType,                BuildingClassType)
SELECT    'CIVILIZATION_PB_TAIPING',     BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE CivilizationType = 'CIVILIZATION_CHINA';
-------------------------
-- Civilization_FreeTechs
-------------------------
INSERT INTO Civilization_FreeTechs
          (CivilizationType,                TechType)
SELECT    'CIVILIZATION_PB_TAIPING',     TechType
FROM Civilization_FreeTechs WHERE CivilizationType = 'CIVILIZATION_CHINA';
-------------------------
-- Civilization_FreeUnits
-------------------------
INSERT INTO Civilization_FreeUnits
          (CivilizationType,                UnitClassType, Count, UnitAIType)
SELECT    'CIVILIZATION_PB_TAIPING',     UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE CivilizationType = 'CIVILIZATION_CHINA';
-----------------------
-- Civilization_Leaders
-----------------------
INSERT INTO Civilization_Leaders
       (CivilizationType,              LeaderheadType)
VALUES ('CIVILIZATION_PB_TAIPING', 'LEADER_PB_HONG');
--------------------------------------
-- Civilization_BuildingClassOverrides
--------------------------------------
INSERT INTO Civilization_BuildingClassOverrides
(CivilizationType,            BuildingClassType,      BuildingType)
VALUES ('CIVILIZATION_PB_TAIPING', 'BUILDINGCLASS_OPERA_HOUSE', 'BUILDING_PB_HEAVENLY_HALL');
----------------------------------
-- Civilization_UnitClassOverrides
----------------------------------
INSERT INTO Civilization_UnitClassOverrides
       (CivilizationType,              UnitClassType,       UnitType)
VALUES ('CIVILIZATION_PB_TAIPING', 'UNITCLASS_MUSKETMAN', 'UNIT_PB_CHANG_MAO');
-------------------------
-------------------------
-- Civilization_Start_Along_River
-------------------------
INSERT INTO Civilization_Start_Along_River
       (CivilizationType,              StartAlongRiver)
VALUES ('CIVILIZATION_PB_TAIPING',					1);
------------------------
-- Civilization_SpyNames
------------------------
INSERT INTO Civilization_SpyNames
          (CivilizationType,                  SpyName)
VALUES    ('CIVILIZATION_PB_TAIPING',     'TXT_KEY_SPY_NAME_PB_TAIPING_0'),
          ('CIVILIZATION_PB_TAIPING',     'TXT_KEY_SPY_NAME_PB_TAIPING_1'),
          ('CIVILIZATION_PB_TAIPING',     'TXT_KEY_SPY_NAME_PB_TAIPING_2'),
          ('CIVILIZATION_PB_TAIPING',     'TXT_KEY_SPY_NAME_PB_TAIPING_3'),
          ('CIVILIZATION_PB_TAIPING',     'TXT_KEY_SPY_NAME_PB_TAIPING_4'),
          ('CIVILIZATION_PB_TAIPING',     'TXT_KEY_SPY_NAME_PB_TAIPING_5'),
          ('CIVILIZATION_PB_TAIPING',     'TXT_KEY_SPY_NAME_PB_TAIPING_6'),
          ('CIVILIZATION_PB_TAIPING',     'TXT_KEY_SPY_NAME_PB_TAIPING_7'),
          ('CIVILIZATION_PB_TAIPING',     'TXT_KEY_SPY_NAME_PB_TAIPING_8'),
          ('CIVILIZATION_PB_TAIPING',     'TXT_KEY_SPY_NAME_PB_TAIPING_9');
-- ======================================================================================================
-- LEADERS
-- ======================================================================================================
-- Leaders
----------
INSERT INTO Leaders
(Type,                                     Description,                          Civilopedia,                               CivilopediaTag,                               ArtDefineTag,                    VictoryCompetitiveness,     WonderCompetitiveness,     MinorCivCompetitiveness,     Boldness,     DiploBalance,     WarmongerHate,     DenounceWillingness,     DoFWillingness,     Loyalty,     Neediness,    Forgiveness,     Chattiness, Meanness,     IconAtlas,             PortraitIndex)
VALUES    ('LEADER_PB_HONG',     'TXT_KEY_LEADER_PB_HONG',    'TXT_KEY_LEADER_PB_HONG_PEDIA_TEXT',    'TXT_KEY_LEADER_PB_HONG_PEDIA',							'HongXiuquan_Scene.xml',									7,                         5,                           5,             7,				4,                5,                        5,                  4,           4,           7,            3,               7,          8,								'TAIPING_ICON_ATLAS',   1);
--------------------------------
-- Leader_MajorCivApproachBiases
--------------------------------
INSERT INTO Leader_MajorCivApproachBiases
          (LeaderType,                     MajorCivApproachType,              Bias)
VALUES    ('LEADER_PB_HONG',     'MAJOR_CIV_APPROACH_WAR',           8),
          ('LEADER_PB_HONG',     'MAJOR_CIV_APPROACH_HOSTILE',       6),
          ('LEADER_PB_HONG',     'MAJOR_CIV_APPROACH_DECEPTIVE',     5),
          ('LEADER_PB_HONG',     'MAJOR_CIV_APPROACH_GUARDED',       5),
          ('LEADER_PB_HONG',     'MAJOR_CIV_APPROACH_AFRAID',        2),
          ('LEADER_PB_HONG',     'MAJOR_CIV_APPROACH_FRIENDLY',      4),
          ('LEADER_PB_HONG',     'MAJOR_CIV_APPROACH_NEUTRAL',       4);
--------------------------------
-- Leader_MinorCivApproachBiases
--------------------------------
INSERT INTO Leader_MinorCivApproachBiases
          (LeaderType,                     MinorCivApproachType,              Bias)
VALUES    ('LEADER_PB_HONG',     'MINOR_CIV_APPROACH_IGNORE',        5),
          ('LEADER_PB_HONG',     'MINOR_CIV_APPROACH_FRIENDLY',      5),
          ('LEADER_PB_HONG',     'MINOR_CIV_APPROACH_PROTECTIVE',    6),
          ('LEADER_PB_HONG',     'MINOR_CIV_APPROACH_CONQUEST',      6),
          ('LEADER_PB_HONG',     'MINOR_CIV_APPROACH_BULLY',         8);
-----------------
-- Leader_Flavors
-----------------
INSERT INTO Leader_Flavors
          (LeaderType,                     FlavorType,                        Flavor)
VALUES    ('LEADER_PB_HONG',     'FLAVOR_OFFENSE',                   8),
          ('LEADER_PB_HONG',     'FLAVOR_DEFENSE',                   5),
          ('LEADER_PB_HONG',     'FLAVOR_CITY_DEFENSE',              6),
          ('LEADER_PB_HONG',     'FLAVOR_MILITARY_TRAINING',         5),
          ('LEADER_PB_HONG',     'FLAVOR_RECON',                     5),
          ('LEADER_PB_HONG',     'FLAVOR_RANGED',                    6),
          ('LEADER_PB_HONG',     'FLAVOR_MOBILE',                    5),
          ('LEADER_PB_HONG',     'FLAVOR_NAVAL',                     6),
          ('LEADER_PB_HONG',     'FLAVOR_NAVAL_RECON',               5),
          ('LEADER_PB_HONG',     'FLAVOR_NAVAL_GROWTH',              5),
          ('LEADER_PB_HONG',     'FLAVOR_NAVAL_TILE_IMPROVEMENT',    5),
          ('LEADER_PB_HONG',     'FLAVOR_AIR',                       7),
          ('LEADER_PB_HONG',     'FLAVOR_EXPANSION',                 8),
          ('LEADER_PB_HONG',     'FLAVOR_GROWTH',                    5),
          ('LEADER_PB_HONG',     'FLAVOR_TILE_IMPROVEMENT',          6),
          ('LEADER_PB_HONG',     'FLAVOR_INFRASTRUCTURE',            5),
          ('LEADER_PB_HONG',     'FLAVOR_PRODUCTION',                6),
          ('LEADER_PB_HONG',     'FLAVOR_GOLD',                      6),
          ('LEADER_PB_HONG',     'FLAVOR_SCIENCE',                   6),
          ('LEADER_PB_HONG',     'FLAVOR_CULTURE',                   5),
          ('LEADER_PB_HONG',     'FLAVOR_HAPPINESS',                 3),
          ('LEADER_PB_HONG',     'FLAVOR_GREAT_PEOPLE',              5),
          ('LEADER_PB_HONG',     'FLAVOR_WONDER',                    4),
          ('LEADER_PB_HONG',     'FLAVOR_RELIGION',                  8),
          ('LEADER_PB_HONG',     'FLAVOR_DIPLOMACY',                 4),
          ('LEADER_PB_HONG',     'FLAVOR_SPACESHIP',                 7),
          ('LEADER_PB_HONG',     'FLAVOR_WATER_CONNECTION',          5),
          ('LEADER_PB_HONG',     'FLAVOR_NUKE',                      8),
          ('LEADER_PB_HONG',     'FLAVOR_USE_NUKE',                  9),
          ('LEADER_PB_HONG',     'FLAVOR_ESPIONAGE',                 6),
          ('LEADER_PB_HONG',     'FLAVOR_AIRLIFT',                   5),
          ('LEADER_PB_HONG',     'FLAVOR_I_TRADE_DESTINATION',       5),
          ('LEADER_PB_HONG',     'FLAVOR_I_TRADE_ORIGIN',            5),
          ('LEADER_PB_HONG',     'FLAVOR_I_SEA_TRADE_ROUTE',         5),
          ('LEADER_PB_HONG',     'FLAVOR_I_LAND_TRADE_ROUTE',        5),
          ('LEADER_PB_HONG',     'FLAVOR_ARCHAEOLOGY',               2),
          ('LEADER_PB_HONG',     'FLAVOR_AIR_CARRIER',               3);
----------------
-- Leader_Traits
----------------
INSERT INTO Leader_Traits
       (LeaderType,              TraitType)
VALUES ('LEADER_PB_HONG',   'TRAIT_PB_BROTHER_OF_CHRIST');
-- ======================================================================================================
-- TRAITS
-- ======================================================================================================
-- Traits
---------
INSERT INTO Traits
       (Type,                   Description,                  ShortDescription)
VALUES ('TRAIT_PB_BROTHER_OF_CHRIST',    'TXT_KEY_TRAIT_PB_BROTHER_OF_CHRIST',   'TXT_KEY_TRAIT_PB_BROTHER_OF_CHRIST_SHORT');
-- ======================================================================================================
-- UNITS
-- ======================================================================================================
-- Units
--------
INSERT INTO Units
(Type,                           Class,    CombatClass, WorkRate, PrereqTech, CanBuyCityState, Combat, RangedCombat, Range, BaseSightRange, FaithCost, RequiresFaithPurchaseEnabled, Cost, Moves, CombatClass, Domain, DefaultUnitAI, CivilianAttackPriority, Special, Description,                   Help,                                             Strategy,                                 Civilopedia,          		MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, XPValueAttack, XPValueDefense, Conscription, UnitArtInfo, UnitFlagAtlas, UnitFlagIconOffset, IconAtlas, PortraitIndex, MoveRate)
SELECT    'UNIT_PB_CHANG_MAO',  Class,    CombatClass, WorkRate, PrereqTech, CanBuyCityState, Combat, RangedCombat, Range, BaseSightRange, FaithCost, RequiresFaithPurchaseEnabled, Cost, Moves, CombatClass, Domain, DefaultUnitAI, CivilianAttackPriority, Special, 'TXT_KEY_UNIT_PB_CHANG_MAO',    'TXT_KEY_UNIT_PB_CHANG_MAO_HELP',    'TXT_KEY_UNIT_PB_CHANG_MAO_STRATEGY',      'TXT_KEY_UNIT_PB_CHANG_MAO_TEXT',    MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, XPValueAttack, XPValueDefense, Conscription, 'ART_DEF_UNIT_PB_CHANG_MAO', 'CHANG_MAO_FLAG', 0, 'TAIPING_ICON_ATLAS', 2, MoveRate
FROM Units WHERE Type = 'UNIT_MUSKETMAN';
------------------------
-- UnitGameplay2DScripts
------------------------
INSERT INTO UnitGameplay2DScripts
       (UnitType,               SelectionSound, FirstSelectionSound)
SELECT 'UNIT_PB_CHANG_MAO',  SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_MUSKETMAN';
---------------
-- Unit_AITypes
---------------
INSERT INTO Unit_AITypes
       (UnitType,               UnitAIType)
SELECT 'UNIT_PB_CHANG_MAO',  UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_MUSKETMAN';
---------------
-- Unit_Flavors
---------------
INSERT INTO Unit_Flavors
       (UnitType,               FlavorType, Flavor)
SELECT 'UNIT_PB_CHANG_MAO',  FlavorType, Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_MUSKETMAN';
----------------------
-- Unit_FreePromotions
----------------------
INSERT INTO Unit_FreePromotions
       (UnitType, PromotionType)
SELECT 'UNIT_PB_CHANG_MAO',  PromotionType
FROM Unit_FreePromotions WHERE UnitType = 'UNIT_MUSKETMAN';

INSERT INTO Unit_FreePromotions
		(UnitType, PromotionType)
VALUES ('UNIT_PB_CHANG_MAO', 'PROMOTION_PB_CHM_CITY_CAPTURE');
-----------------------
-- Unit_ClassUpgrades
-----------------------
INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 					UnitClassType)
SELECT	'UNIT_PB_CHANG_MAO',		UnitClassType
FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_MUSKETMAN';
-----------------
-- UnitPromotions
-----------------
INSERT INTO UnitPromotions
(Type,                                   Description,										Help,                     							Sound,			CannotBeChosen, LostWithUpgrade, CityAttack,	FreePillageMoves,      PortraitIndex,    IconAtlas,                         PediaType,             PediaEntry)
VALUES    ('PROMOTION_PB_CHM_CITY_COMBAT', 'TXT_KEY_PROMOTION_PB_CHM_CITY_COMBAT',     'TXT_KEY_PROMOTION_PB_CHM_CITY_COMBAT_HELP',		'AS2D_IF_LEVELUP',    1,					0,				50,                0,			     42,            'PROMOTION_ATLAS',     		'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_PB_CHM_CITY_COMBAT'),
		  ('PROMOTION_PB_CHM_CITY_CAPTURE', 'TXT_KEY_PROMOTION_PB_CHM_CITY_CAPTURE',	'TXT_KEY_PROMOTION_PB_CHM_CITY_CAPTURE_HELP', 		'AS2D_IF_LEVELUP',    1,					0,				0,                0,			     41,            'PROMOTION_ATLAS',     		'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_PB_CHM_CITY_CAPTURE'),
		  ('PROMOTION_PB_HH_PILLAGE',			'TXT_KEY_PROMOTION_PB_HH_PILLAGE',			 'TXT_KEY_PROMOTION_PB_HH_PILLAGE_HELP',    			'AS2D_IF_LEVELUP',    1,					0,				0,                1,			     3,            'EXPANSION_PROMOTION_ATLAS',     		'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_PB_HH_PILLAGE');
-----------------
-- UnitPromotions_UnitCombats
-----------------
INSERT INTO UnitPromotions_UnitCombats
(PromotionType,		UnitCombatType)
VALUES		('PROMOTION_PB_HH_PILLAGE', 'UNITCOMBAT_RECON'),
			('PROMOTION_PB_HH_PILLAGE', 'UNITCOMBAT_ARCHER'),
			('PROMOTION_PB_HH_PILLAGE', 'UNITCOMBAT_MOUNTED'),
			('PROMOTION_PB_HH_PILLAGE', 'UNITCOMBAT_MELEE'),
			('PROMOTION_PB_HH_PILLAGE', 'UNITCOMBAT_SIEGE'),
			('PROMOTION_PB_HH_PILLAGE', 'UNITCOMBAT_GUN'),
			('PROMOTION_PB_HH_PILLAGE', 'UNITCOMBAT_ARMOR'),
			('PROMOTION_PB_HH_PILLAGE', 'UNITCOMBAT_HELICOPTER');


--==========================================================================================================================
-- BUILDINGS
--==========================================================================================================================
--------------------	
-- BuildingClasses
--------------------	
INSERT INTO BuildingClasses
		(Type, 								DefaultBuilding, 					Description)
VALUES	('BUILDINGCLASS_PB_TAIPING_FAITH_DUMMY', 	'BUILDING_PB_TAIPING_FAITH_DUMMY', 	'TXT_KEY_BUILDING_PB_TAIPING_FAITH_DUMMY'),
		('BUILDINGCLASS_PB_TAIPING_PROM_DUMMY',	'BUILDING_PB_TAIPING_PROM_DUMMY',		'TXT_KEY_BUILDING_PB_TAIPING_PROM_DUMMY');

------------------------------
-- Buildings
------------------------------	
INSERT INTO Buildings 	
		(Type, 											MutuallyExclusiveGroup,			BuildingClass,	 Cost, FaithCost, PrereqTech, HurryCostModifier, GoldMaintenance, Water, ArtDefineTag, ArtInfoEraVariation, DisplayPosition, AllowsWaterRoutes, TradeRouteSeaDistanceModifier,	Defense, TradeRouteSeaGoldBonus, MinAreaSize, GreatWorkSlotType,	GreatWorkCount,		NeverCapture, 	Description, 								Help, 											Strategy,											Civilopedia, 									ArtDefineTag,	PortraitIndex,	IconAtlas)
SELECT	'BUILDING_PB_HEAVENLY_HALL',					MutuallyExclusiveGroup,			BuildingClass,	 Cost, FaithCost, PrereqTech, HurryCostModifier, GoldMaintenance, Water, ArtDefineTag, ArtInfoEraVariation, DisplayPosition, AllowsWaterRoutes, TradeRouteSeaDistanceModifier,	    400, TradeRouteSeaGoldBonus, MinAreaSize,	GreatWorkSlotType,	GreatWorkCount,		1, 				'TXT_KEY_BUILDING_PB_HEAVENLY_HALL', 	'TXT_KEY_BUILDING_PB_HEAVENLY_HALL_HELP',	'TXT_KEY_BUILDING_PB_HEAVENLY_HALL_STRATEGY',	'TXT_KEY_BUILDING_PB_HEAVENLY_HALL_TEXT',					ArtDefineTag,	3, 				'TAIPING_ICON_ATLAS'
FROM Buildings WHERE Type = 'BUILDING_OPERA_HOUSE';

INSERT INTO Buildings		
		(Type, 								BuildingClass, 			  				Cost,  FaithCost, GreatWorkCount,	NeverCapture,	TrainedFreePromotion,	ReligiousPressureModifier,  Description, 								 Help)
VALUES	('BUILDING_PB_TAIPING_FAITH_DUMMY', 'BUILDINGCLASS_PB_TAIPING_FAITH_DUMMY',					-1,    -1,		  -1,				1,								null,							25, 'TXT_KEY_BUILDING_PB_TAIPING_FAITH_DUMMY',	 'TXT_KEY_BUILDING_PB_TAIPING_FAITH_DUMMY_HELP'),
		('BUILDING_PB_TAIPING_PROM_DUMMY', 'BUILDINGCLASS_PB_TAIPING_PROM_DUMMY',						-1,    -1,		  -1,				1,			'PROMOTION_PB_HH_PILLAGE',						0, 'TXT_KEY_BUILDING_PB_TAIPING_PROM_DUMMY',	 'TXT_KEY_BUILDING_PB_TAIPING_PROM_DUMMY_HELP');

--------------------------------------------------------------------------------------------------------------------------
-- Building_Flavors
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Building_Flavors 	
		(BuildingType, 					FlavorType, Flavor)
SELECT	'BUILDING_PB_HEAVENLY_HALL',	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_OPERA_HOUSE';
		
INSERT INTO Building_Flavors 	
		(BuildingType, 							     FlavorType, 	     			Flavor)
VALUES	('BUILDING_PB_HEAVENLY_HALL',		'FLAVOR_RELIGION', 							20),
		('BUILDING_PB_HEAVENLY_HALL',		'FLAVOR_CITY_DEFENSE', 						15),
		('BUILDING_PB_HEAVENLY_HALL',		'FLAVOR_MILITARY_TRAINING', 				20);

--------------------------------------------------------------------------------------------------------------------------
-- Building_ClassesNeededInCity
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Building_ClassesNeededInCity 	
		(BuildingType, 							     BuildingClassType)
VALUES	('BUILDING_PB_HEAVENLY_HALL',			'BUILDINGCLASS_TEMPLE');

--------------------------------------------------------------------------------------------------------------------------
-- Building_YieldChanges
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Building_YieldChanges 	
		(BuildingType, 					YieldType, Yield)
SELECT	'BUILDING_PB_HEAVENLY_HALL',	YieldType, Yield
FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_OPERA_HOUSE';

INSERT INTO Building_YieldChanges 	
		(BuildingType, 							     YieldType, 	     			Yield)
VALUES	('BUILDING_PB_HEAVENLY_HALL',		'YIELD_FAITH', 							2);

--==========================================================================================================================
-- Religions
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- Religions
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Religions 	
		(Type, 									Description, 	     						Civilopedia,									IconAtlas,				PortraitIndex,	IconString)
VALUES	('RELIGION_PB_GOD_WORSHIPPING',		'TXT_KEY_RELIGION_PB_GOD_WORSHIPPING', 	'TXT_KEY_RELIGION_PB_GOD_WORSHIPPING_HELP', 'TAIPING_RELIGION_ATLAS',	 0, 			'[ICON_RELIGION_PB_GOD_WORSHIPPING]');