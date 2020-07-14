--==========================================================================================================================
-- GAME DEFINES
--==========================================================================================================================
--==========================================================================================================================	
-- PlayerColors
--==========================================================================================================================
INSERT INTO PlayerColors 
			(Type, 								PrimaryColor, 							SecondaryColor, 								TextColor)
VALUES		('PLAYERCOLOR_ORG_MALACCA',			'COLOR_PLAYER_ORG_MALACCA_ICON', 		'COLOR_PLAYER_ORG_MALACCA_BACKGROUND', 			'COLOR_PLAYER_WHITE_TEXT');
--==========================================================================================================================	
-- Colors
--==========================================================================================================================			
INSERT INTO Colors 
			(Type, 									Red, 	Green, 	Blue, 	Alpha)
VALUES		('COLOR_PLAYER_ORG_MALACCA_ICON',		0.753,	0.627,	0.039,	1), -- 192, 160, 10
			('COLOR_PLAYER_ORG_MALACCA_BACKGROUND',	0.051,	0.051,	0.420,	1); --  13,   13, 107
--==========================================================================================================================
-- Civilizations
--==========================================================================================================================
INSERT INTO Civilizations 	
			(Type, 							Description, 							ShortDescription, 					Adjective, 								Civilopedia, 						CivilopediaTag, 				DefaultPlayerColor,				ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas,						AlphaIconAtlas, 			PortraitIndex,	SoundtrackTag, 	MapImage, 					DawnOfManQuote, 						DawnOfManImage)
SELECT		('CIVILIZATION_ORG_MALACCA'), 	('TXT_KEY_CIV_ORG_MALACCA_DESC'), 	('TXT_KEY_CIV_ORG_MALACCA_SHORT_DESC'), ('TXT_KEY_CIV_ORG_MALACCA_ADJECTIVE'), 	('TXT_KEY_CIV_ORG_MALACCA_PEDIA'),	('TXT_KEY_CIV5_ORG_MALACCA'), 	('PLAYERCOLOR_ORG_MALACCA'), 	ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_ATLAS_ORG_MALACCA'), ('CIV_ALPHA_ATLAS_ORG_MALACCA'), 1, 			SoundtrackTag,	('ORG_MALACCA_Map.dds'), 	('TXT_KEY_CIV5_DOM_ORG_MALACCA_TEXT'), ('DOMMALACCABackground.dds')
FROM Civilizations WHERE Type = 'CIVILIZATION_SPAIN';
--==========================================================================================================================
-- Civilization_UnitClassOverrides
--==========================================================================================================================	
INSERT INTO Civilization_UnitClassOverrides 
		(CivilizationType, 			UnitClassType, 			UnitType)
VALUES	('CIVILIZATION_ORG_MALACCA', 'UNITCLASS_CARAVEL', 	'UNIT_ORG_MALACCAN_JONG'),
		('CIVILIZATION_ORG_MALACCA', 'UNITCLASS_GREAT_ADMIRAL', 	'UNIT_ORG_MALACCAN_LAKSAMANA');
--==========================================================================================================================
-- Civilization_CityNames
--==========================================================================================================================		
INSERT INTO Civilization_CityNames 
			(CivilizationType, 					CityName)
VALUES		('CIVILIZATION_ORG_MALACCA', 		'TXT_KEY_CITY_NAME_ORG_MALACCA_0'),
			('CIVILIZATION_ORG_MALACCA', 		'TXT_KEY_CITY_NAME_ORG_MALACCA_1'),
			('CIVILIZATION_ORG_MALACCA', 		'TXT_KEY_CITY_NAME_ORG_MALACCA_2'),
			('CIVILIZATION_ORG_MALACCA', 		'TXT_KEY_CITY_NAME_ORG_MALACCA_3'),
			('CIVILIZATION_ORG_MALACCA', 		'TXT_KEY_CITY_NAME_ORG_MALACCA_4'),
			('CIVILIZATION_ORG_MALACCA', 		'TXT_KEY_CITY_NAME_ORG_MALACCA_5'),
			('CIVILIZATION_ORG_MALACCA', 		'TXT_KEY_CITY_NAME_ORG_MALACCA_6'),
			('CIVILIZATION_ORG_MALACCA', 		'TXT_KEY_CITY_NAME_ORG_MALACCA_7'),
			('CIVILIZATION_ORG_MALACCA', 		'TXT_KEY_CITY_NAME_ORG_MALACCA_8'),
			('CIVILIZATION_ORG_MALACCA', 		'TXT_KEY_CITY_NAME_ORG_MALACCA_9'),
			('CIVILIZATION_ORG_MALACCA', 		'TXT_KEY_CITY_NAME_ORG_MALACCA_10'),
			('CIVILIZATION_ORG_MALACCA', 		'TXT_KEY_CITY_NAME_ORG_MALACCA_11'),
			('CIVILIZATION_ORG_MALACCA', 		'TXT_KEY_CITY_NAME_ORG_MALACCA_12'),
			('CIVILIZATION_ORG_MALACCA', 		'TXT_KEY_CITY_NAME_ORG_MALACCA_13'),
			('CIVILIZATION_ORG_MALACCA', 		'TXT_KEY_CITY_NAME_ORG_MALACCA_14'),
			('CIVILIZATION_ORG_MALACCA', 		'TXT_KEY_CITY_NAME_ORG_MALACCA_15'),
			('CIVILIZATION_ORG_MALACCA', 		'TXT_KEY_CITY_NAME_ORG_MALACCA_16'),
			('CIVILIZATION_ORG_MALACCA', 		'TXT_KEY_CITY_NAME_ORG_MALACCA_17'),
			('CIVILIZATION_ORG_MALACCA', 		'TXT_KEY_CITY_NAME_ORG_MALACCA_18'),
			('CIVILIZATION_ORG_MALACCA', 		'TXT_KEY_CITY_NAME_ORG_MALACCA_19'),
			('CIVILIZATION_ORG_MALACCA', 		'TXT_KEY_CITY_NAME_ORG_MALACCA_20'),
			('CIVILIZATION_ORG_MALACCA', 		'TXT_KEY_CITY_NAME_ORG_MALACCA_21'),
			('CIVILIZATION_ORG_MALACCA', 		'TXT_KEY_CITY_NAME_ORG_MALACCA_22'),
			('CIVILIZATION_ORG_MALACCA', 		'TXT_KEY_CITY_NAME_ORG_MALACCA_23'),
			('CIVILIZATION_ORG_MALACCA', 		'TXT_KEY_CITY_NAME_ORG_MALACCA_24'),
			('CIVILIZATION_ORG_MALACCA', 		'TXT_KEY_CITY_NAME_ORG_MALACCA_25'),
			('CIVILIZATION_ORG_MALACCA', 		'TXT_KEY_CITY_NAME_ORG_MALACCA_26'),
			('CIVILIZATION_ORG_MALACCA', 		'TXT_KEY_CITY_NAME_ORG_MALACCA_27'),
			('CIVILIZATION_ORG_MALACCA', 		'TXT_KEY_CITY_NAME_ORG_MALACCA_28'),
			('CIVILIZATION_ORG_MALACCA', 		'TXT_KEY_CITY_NAME_ORG_MALACCA_29'),
			('CIVILIZATION_ORG_MALACCA', 		'TXT_KEY_CITY_NAME_ORG_MALACCA_30');
--==========================================================================================================================
-- Civilization_FreeBuildingClasses
--==========================================================================================================================		
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 				BuildingClassType)
SELECT		('CIVILIZATION_ORG_MALACCA'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE CivilizationType = 'CIVILIZATION_SPAIN';
--==========================================================================================================================
-- Civilization_FreeTechs
--==========================================================================================================================	
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 				TechType)
SELECT		('CIVILIZATION_ORG_MALACCA'), 	TechType
FROM Civilization_FreeTechs WHERE CivilizationType = 'CIVILIZATION_SPAIN';
--==========================================================================================================================
-- Civilization_FreeUnits
--==========================================================================================================================	
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 				UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_ORG_MALACCA'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE CivilizationType = 'CIVILIZATION_SPAIN';
--==========================================================================================================================
-- Civilization_Leaders
--==========================================================================================================================		
INSERT INTO Civilization_Leaders 
			(CivilizationType, 				LeaderheadType)
VALUES		('CIVILIZATION_ORG_MALACCA', 	'LEADER_ORG_MANSUR');
--==========================================================================================================================

--==========================================================================================================================
-- Civilization_Start_Along_Ocean 
--==========================================================================================================================
INSERT INTO Civilization_Start_Along_Ocean 
		(CivilizationType, 					StartAlongOcean)
VALUES	('CIVILIZATION_ORG_MALACCA', 		1);
--==========================================================================================================================
-- Civilization_Start_Place_First_Along_Ocean
--==========================================================================================================================
INSERT INTO Civilization_Start_Place_First_Along_Ocean 
		(CivilizationType, 					PlaceFirst)
VALUES	('CIVILIZATION_ORG_MALACCA', 		1);
--==========================================================================================================================
-- Civilization_SpyNames
--==========================================================================================================================	
INSERT INTO Civilization_SpyNames 
		(CivilizationType, 				SpyName)
VALUES	('CIVILIZATION_ORG_MALACCA', 	'TXT_KEY_SPY_NAME_ORG_MALACCA_0'),	
		('CIVILIZATION_ORG_MALACCA', 	'TXT_KEY_SPY_NAME_ORG_MALACCA_1'),
		('CIVILIZATION_ORG_MALACCA', 	'TXT_KEY_SPY_NAME_ORG_MALACCA_2'),
		('CIVILIZATION_ORG_MALACCA', 	'TXT_KEY_SPY_NAME_ORG_MALACCA_3'),
		('CIVILIZATION_ORG_MALACCA', 	'TXT_KEY_SPY_NAME_ORG_MALACCA_4'),
		('CIVILIZATION_ORG_MALACCA', 	'TXT_KEY_SPY_NAME_ORG_MALACCA_5'),
		('CIVILIZATION_ORG_MALACCA', 	'TXT_KEY_SPY_NAME_ORG_MALACCA_6'),
		('CIVILIZATION_ORG_MALACCA', 	'TXT_KEY_SPY_NAME_ORG_MALACCA_7'),
		('CIVILIZATION_ORG_MALACCA', 	'TXT_KEY_SPY_NAME_ORG_MALACCA_8'),
		('CIVILIZATION_ORG_MALACCA', 	'TXT_KEY_SPY_NAME_ORG_MALACCA_9');
--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================	
--==========================================================================================================================	
-- BuildingClasses
--==========================================================================================================================
INSERT INTO BuildingClasses
		(Type, 								DefaultBuilding, 			  Description, 				NoLimit)
VALUES	('BUILDINGCLASS_ORG_NAVAL_PROD',   'BUILDING_ORG_NAVAL_PROD',   'TXT_KEY_ORG_NAVAL_PROD',	1),
		('BUILDINGCLASS_ORG_LAKSAMANA_TRADE',   'BUILDING_ORG_LAKSAMANA_TRADE',   'TXT_KEY_ORG_LAKSAMANA_TRADE',	-1);
--==========================================================================================================================	
-- Buildings
--==========================================================================================================================
INSERT INTO Buildings 		
		(Type, 							BuildingClass,						GreatWorkCount,	Cost, FaithCost, PrereqTech, Description,				NeverCapture, PortraitIndex, IconAtlas)
VALUES	('BUILDING_ORG_NAVAL_PROD',		'BUILDINGCLASS_ORG_NAVAL_PROD',		-1,				-1,   -1,		 null,		 'TXT_KEY_ORG_NAVAL_PROD',	1,				19,	'BW_ATLAS_1'),
		('BUILDING_ORG_LAKSAMANA_TRADE',		'BUILDINGCLASS_ORG_LAKSAMANA_TRADE',		-1,				-1,   -1,		 null,		 'TXT_KEY_ORG_LAKSAMANA_TRADE',	-1,				19,	'BW_ATLAS_1');
--==========================================================================================================================	
-- Building_YieldChanges
--==========================================================================================================================
/*
--==========================================================================================================================	
-- Building_YieldModifiers
--==========================================================================================================================	
INSERT INTO Building_YieldModifiers
		(BuildingType, 			YieldType,			Yield)
VALUES	('BUILDING_ORG_',	'YIELD_',	10);
*/
--==========================================================================================================================	
-- Building_DomainProductionModifiers
--==========================================================================================================================
INSERT INTO Building_DomainProductionModifiers
		(BuildingType, 					DomainType, 	Modifier)
VALUES	('BUILDING_ORG_NAVAL_PROD', 	'DOMAIN_SEA', 	10);
--==========================================================================================================================	
-- Building_FeatureYieldChanges
--==========================================================================================================================
--==========================================================================================================================	
-- Building_Flavors
--==========================================================================================================================

--==========================================================================================================================	
-- UNITS
--==========================================================================================================================	
-- Units
------------------------------------------------------------------------------------------------------------------------
INSERT INTO Units 	
		(Type, 								Class, Cost, Moves, FaithCost, RequiresFaithPurchaseEnabled, GoodyHutUpgradeUnitClass, PrereqTech, Combat, Range, RangedCombat, CombatClass, Domain, DefaultUnitAI, ObsoleteTech, Description, 					   				Help, 							  			   Strategy,											Civilopedia, 						  			 						MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, Pillage, HurryCostModifier, AdvancedStartCost, CombatLimit, UnitArtInfo,								XPValueAttack, XPValueDefense,  MoveRate, UnitFlagAtlas,					UnitFlagIconOffset,  IconAtlas,				 	 PortraitIndex)
SELECT	'UNIT_ORG_MALACCAN_JONG',	Class, Cost-20, Moves, FaithCost, RequiresFaithPurchaseEnabled, GoodyHutUpgradeUnitClass, PrereqTech, Combat+5, Range, RangedCombat, CombatClass, Domain, DefaultUnitAI, ObsoleteTech, 'TXT_KEY_UNIT_ORG_MALACCAN_JONG',  'TXT_KEY_UNIT_HELP_ORG_MALACCAN_JONG',  'TXT_KEY_UNIT_ORG_MALACCAN_JONG_STRATEGY',	'TXT_KEY_CIVILOPEDIA_UNITS_RENAISSANCE_ORG_MALACCAN_JONG_TEXT',  	MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, Pillage, HurryCostModifier, AdvancedStartCost, CombatLimit, 'ART_DEF_UNIT_ORG_MALACCAN_JONG',	XPValueAttack, XPValueDefense,  MoveRate, 'CIV_ATLAS_ORG_MALACCA_JONG', 0,					 'CIV_ATLAS_ORG_MALACCA',		2
FROM Units WHERE Type = 'UNIT_CARAVEL';

INSERT INTO Units 	
			(Class, 	Type, 					Cost, Moves, Domain, DefaultUnitAI, ProhibitsSpread, Description, 					Civilopedia, 												Strategy, 								Help, 							AdvancedStartCost,	CombatLimit, DontShowYields, UnitArtInfoEraVariation, UnitArtInfo, 					UnitFlagIconOffset,	UnitFlagAtlas,					  PortraitIndex, 	IconAtlas,			  MoveRate)
SELECT		Class,		('UNIT_ORG_MALACCAN_LAKSAMANA'), Cost, Moves, Domain, DefaultUnitAI, ProhibitsSpread, ('TXT_KEY_UNIT_ORG_MALACCAN_LAKSAMANA'), ('TXT_KEY_CIVILOPEDIA_UNITS_ORG_MALACCAN_LAKSAMANA_TEXT'), ('TXT_KEY_UNIT_ORG_MALACCAN_LAKSAMANA_STRATEGY'), 	('TXT_KEY_UNIT_HELP_ORG_MALACCAN_LAKSAMANA'), AdvancedStartCost,	CombatLimit, DontShowYields, -1,					  ('ART_DEF_UNIT_ORG_MALACCAN_LAKSAMANA'),	0,					('CIV_ATLAS_ORG_MALACCA_LAKSAMANA'), 4, 				('CIV_ATLAS_ORG_MALACCA'), MoveRate
FROM Units WHERE (Type = 'UNIT_GREAT_ADMIRAL');
------------------------------------------------------------------------------------------------------------------------
-- UnitGameplay2DScripts
------------------------------------------------------------------------------------------------------------------------
INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 							SelectionSound, FirstSelectionSound)
SELECT	'UNIT_ORG_MALACCAN_JONG', 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_CARAVEL';

INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 							SelectionSound, FirstSelectionSound)
SELECT	'UNIT_ORG_MALACCAN_LAKSAMANA', 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_GREAT_ADMIRAL';
------------------------------------------------------------------------------------------------------------------------
-- Unit_AITypes
------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_AITypes 	
		(UnitType, 							UnitAIType)
SELECT	'UNIT_ORG_MALACCAN_JONG', 	UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_CARAVEL';

INSERT INTO Unit_AITypes 	
		(UnitType, 							UnitAIType)
SELECT	'UNIT_ORG_MALACCAN_LAKSAMANA', 	UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_GREAT_ADMIRAL';
------------------------------------------------------------------------------------------------------------------------
-- Unit_ClassUpgrades
------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 							UnitClassType)
SELECT	'UNIT_ORG_MALACCAN_JONG', 	UnitClassType
FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_CARAVEL';

INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 							UnitClassType)
SELECT	'UNIT_ORG_MALACCAN_LAKSAMANA', 	UnitClassType
FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_CARAVEL';
------------------------------------------------------------------------------------------------------------------------
-- Unit_Flavors
------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_Flavors 	
		(UnitType, 							FlavorType,	Flavor)
SELECT	'UNIT_ORG_MALACCAN_JONG', 	FlavorType,	Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_CARAVEL';

INSERT INTO Unit_Flavors 	
		(UnitType, 							FlavorType,				Flavor)
VALUES	('UNIT_ORG_MALACCAN_JONG', 'FLAVOR_GOLD',  		15); 

UPDATE Unit_Flavors
SET Flavor = 25 WHERE UnitType = 'UNIT_ORG_MALACCAN_JONG' AND FlavorType = 'FLAVOR_NAVAL';

UPDATE Unit_Flavors
SET Flavor = 10 WHERE UnitType = 'UNIT_ORG_MALACCAN_JONG' AND FlavorType = 'FLAVOR_NAVAL_RECON';

INSERT INTO Unit_Flavors 	
		(UnitType, 							FlavorType,	Flavor)
SELECT	'UNIT_ORG_MALACCAN_LAKSAMANA', 	FlavorType,	Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_GREAT_ADMIRAL';

INSERT INTO Unit_Flavors 	
		(UnitType, 							FlavorType,				Flavor)
VALUES	('UNIT_ORG_MALACCAN_LAKSAMANA', 'FLAVOR_GOLD',  		10),
		('UNIT_ORG_MALACCAN_LAKSAMANA', 'FLAVOR_NAVAL_TILE_IMPROVEMENT',  		20),
		('UNIT_ORG_MALACCAN_LAKSAMANA', 'FLAVOR_I_SEA_TRADE_ROUTE',  		10);
------------------------------------------------------------------------------------------------------------------------
-- Unit_ResourceQuantityRequirements
------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_ResourceQuantityRequirements 	
		(UnitType, 							ResourceType, Cost)
SELECT	'UNIT_ORG_MALACCAN_JONG', 	ResourceType, Cost
FROM Unit_ResourceQuantityRequirements WHERE UnitType = 'UNIT_CARAVEL';

INSERT INTO Unit_ResourceQuantityRequirements 	
		(UnitType, 							ResourceType, Cost)
SELECT	'UNIT_ORG_MALACCAN_LAKSAMANA', 	ResourceType, Cost
FROM Unit_ResourceQuantityRequirements WHERE UnitType = 'UNIT_GREAT_ADMIRAL';
------------------------------------------------------------------------------------------------------------------------
-- Unit_FreePromotions
------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_FreePromotions 	
		(UnitType, 							PromotionType)
SELECT	'UNIT_ORG_MALACCAN_JONG', 	PromotionType
FROM Unit_FreePromotions WHERE UnitType = 'UNIT_CARAVEL';

INSERT INTO Unit_FreePromotions
		(UnitType, 								PromotionType)
VALUES	('UNIT_ORG_MALACCAN_JONG', 	'PROMOTION_ORG_JONG_GOLD');
--==========================================================================================================================	
-- UnitPromotions
--==========================================================================================================================	
INSERT INTO UnitPromotions 
			(Type, 							 Description, 							 Help, 											Sound, 			LostWithUpgrade, OrderPriority, CannotBeChosen,	PortraitIndex, 	IconAtlas,						PediaType, 			PediaEntry)
VALUES		('PROMOTION_ORG_JONG_GOLD',	 'TXT_KEY_PROMOTION_ORG_JONG_GOLD',	 'TXT_KEY_PROMOTION_ORG_JONG_GOLD_HELP',	'AS2D_IF_LEVELUP',	0,				 0, 	 				 1,				4, 'EXPANSION_PROMOTION_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PEDIA_PROMOTION_ORG_JONG_GOLD');

INSERT INTO Unit_FreePromotions
        (UnitType,                                 PromotionType)
VALUES    ('UNIT_ORG_MALACCAN_LAKSAMANA',     'PROMOTION_GREAT_ADMIRAL');
--==========================================================================================================================	
-- LEADERS
--==========================================================================================================================	
------------------------------------------------------------------------------------------------------------------------
-- Leaders
------------------------------------------------------------------------------------------------------------------------			
INSERT INTO Leaders 
		(Type, 					Description, 					Civilopedia, 						CivilopediaTag, 							ArtDefineTag, 				VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness,  DoFWillingness,  Loyalty,  Neediness,  Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 						PortraitIndex)
VALUES	('LEADER_ORG_MANSUR', 	'TXT_KEY_LEADER_ORG_MANSUR',	'TXT_KEY_LEADER_ORG_MANSUR_PEDIA',  'TXT_KEY_CIVILOPEDIA_LEADERS_ORG_MANSUR',	'Mansur_Scene.xml',		8, 						6, 						6, 							8, 			5, 				3, 				4, 					  6, 			   6, 		 4, 		 6, 			7, 			4, 			'CIV_ATLAS_ORG_MALACCA',	0);
------------------------------------------------------------------------------------------------------------------------	
-- Leader_MajorCivApproachBiases
------------------------------------------------------------------------------------------------------------------------						
INSERT INTO Leader_MajorCivApproachBiases 
		(LeaderType, 			MajorCivApproachType, 				Bias)
VALUES	('LEADER_ORG_MANSUR', 	'MAJOR_CIV_APPROACH_WAR', 			8),
		('LEADER_ORG_MANSUR', 	'MAJOR_CIV_APPROACH_HOSTILE', 		6),
		('LEADER_ORG_MANSUR', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	4),
		('LEADER_ORG_MANSUR', 	'MAJOR_CIV_APPROACH_GUARDED', 		5),
		('LEADER_ORG_MANSUR', 	'MAJOR_CIV_APPROACH_AFRAID', 		3),
		('LEADER_ORG_MANSUR', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		6),
		('LEADER_ORG_MANSUR', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		4);
------------------------------------------------------------------------------------------------------------------------	
-- Leader_MajorCivApproachBiases
------------------------------------------------------------------------------------------------------------------------						
INSERT INTO Leader_MinorCivApproachBiases 
		(LeaderType, 			MinorCivApproachType, 				Bias)
VALUES	('LEADER_ORG_MANSUR', 	'MINOR_CIV_APPROACH_IGNORE', 		3),
		('LEADER_ORG_MANSUR', 	'MINOR_CIV_APPROACH_FRIENDLY', 		7),
		('LEADER_ORG_MANSUR', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	8),
		('LEADER_ORG_MANSUR', 	'MINOR_CIV_APPROACH_CONQUEST', 		6),
		('LEADER_ORG_MANSUR', 	'MINOR_CIV_APPROACH_BULLY', 		3);
------------------------------------------------------------------------------------------------------------------------	
-- Leader_Flavors
------------------------------------------------------------------------------------------------------------------------						
INSERT INTO Leader_Flavors 
		(LeaderType, 			FlavorType, 						Flavor)
VALUES	('LEADER_ORG_MANSUR', 	'FLAVOR_OFFENSE', 					8),
		('LEADER_ORG_MANSUR', 	'FLAVOR_DEFENSE', 					5),
		('LEADER_ORG_MANSUR', 	'FLAVOR_CITY_DEFENSE', 				4),
		('LEADER_ORG_MANSUR', 	'FLAVOR_MILITARY_TRAINING', 		6),
		('LEADER_ORG_MANSUR', 	'FLAVOR_RECON', 					4),
		('LEADER_ORG_MANSUR', 	'FLAVOR_RANGED', 					5),
		('LEADER_ORG_MANSUR', 	'FLAVOR_MOBILE', 					4),
		('LEADER_ORG_MANSUR', 	'FLAVOR_NAVAL', 					11),
		('LEADER_ORG_MANSUR', 	'FLAVOR_NAVAL_RECON', 				5),
		('LEADER_ORG_MANSUR', 	'FLAVOR_NAVAL_GROWTH', 				7),
		('LEADER_ORG_MANSUR', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	8),
		('LEADER_ORG_MANSUR', 	'FLAVOR_AIR', 						4),
		('LEADER_ORG_MANSUR', 	'FLAVOR_EXPANSION', 				8),
		('LEADER_ORG_MANSUR', 	'FLAVOR_GROWTH', 					7),
		('LEADER_ORG_MANSUR', 	'FLAVOR_TILE_IMPROVEMENT', 			6),
		('LEADER_ORG_MANSUR', 	'FLAVOR_INFRASTRUCTURE', 			7),
		('LEADER_ORG_MANSUR', 	'FLAVOR_PRODUCTION', 				5),
		('LEADER_ORG_MANSUR', 	'FLAVOR_GOLD', 						7),
		('LEADER_ORG_MANSUR', 	'FLAVOR_SCIENCE', 					5),
		('LEADER_ORG_MANSUR', 	'FLAVOR_CULTURE', 					6),
		('LEADER_ORG_MANSUR', 	'FLAVOR_HAPPINESS', 				6),
		('LEADER_ORG_MANSUR', 	'FLAVOR_GREAT_PEOPLE', 				4),
		('LEADER_ORG_MANSUR', 	'FLAVOR_WONDER', 					5),
		('LEADER_ORG_MANSUR', 	'FLAVOR_RELIGION', 					6),
		('LEADER_ORG_MANSUR', 	'FLAVOR_DIPLOMACY', 				5),
		('LEADER_ORG_MANSUR', 	'FLAVOR_SPACESHIP', 				4),
		('LEADER_ORG_MANSUR', 	'FLAVOR_WATER_CONNECTION', 			7),
		('LEADER_ORG_MANSUR', 	'FLAVOR_NUKE', 						5),
		('LEADER_ORG_MANSUR', 	'FLAVOR_USE_NUKE', 					4),
		('LEADER_ORG_MANSUR', 	'FLAVOR_ESPIONAGE', 				5),
		('LEADER_ORG_MANSUR', 	'FLAVOR_AIRLIFT', 					3),
		('LEADER_ORG_MANSUR', 	'FLAVOR_I_TRADE_DESTINATION', 		9),
		('LEADER_ORG_MANSUR', 	'FLAVOR_I_TRADE_ORIGIN', 			7),
		('LEADER_ORG_MANSUR', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		9),
		('LEADER_ORG_MANSUR', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
		('LEADER_ORG_MANSUR', 	'FLAVOR_ARCHAEOLOGY', 				3),
		('LEADER_ORG_MANSUR', 	'FLAVOR_AIR_CARRIER', 				3);
------------------------------------------------------------------------------------------------------------------------	
-- Leader_Traits
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Leader_Traits
		(LeaderType, 			TraitType)
VALUES	('LEADER_ORG_MANSUR',	'TRAIT_ORG_MARITIME_LAW');
--==========================================================================================================================	
-- TRAITS
--==========================================================================================================================	
-- Traits
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Traits 
		(Type, 						Description, 					ShortDescription)
VALUES	('TRAIT_ORG_MARITIME_LAW',	'TXT_KEY_TRAIT_ORG_MARITIME_LAW',	'TXT_KEY_TRAIT_ORG_MARITIME_LAW_SHORT');
--==========================================================================================================================
--==========================================================================================================================