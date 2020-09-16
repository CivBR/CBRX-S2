-- Neutral Nation Game Defines
-- "Tell my wife I said hello" - EW

-- Original Author: EW
-- Completed, Debugged and Assembled: Limaeus

-- Special thanks to JFD for formatting template
--==========================================================================================================================	
-- LEADERS
--==========================================================================================================================	
-- Leaders
--------------------------------
INSERT INTO Leaders
		(Type,						Description,						Civilopedia,							CivilopediaTag,									ArtDefineTag,				VictoryCompetitiveness,	WonderCompetitiveness, 	MinorCivCompetitiveness,	Boldness,	DiploBalance,	WarmongerHate,	DenounceWillingness,	DoFWillingness, Loyalty,	Neediness,	Forgiveness,	Chattiness, Meanness,	IconAtlas,			PortraitIndex)
VALUES	('LEADER_EW_TSOUHARISSEN',	'TXT_KEY_LEADER_EW_TSOUHARISSEN',	'TXT_KEY_LEADER_EW_TSOUHARISSEN_PEDIA',	'TXT_KEY_CIVILOPEDIA_LEADERS_EW_TSOUHARISSEN',	'Tsouharissen_Scene.xml',	7,						3,						3,							7,			5,				6,				5,						3,				5,			4,			2,				2,			6,			'ATLAS_RT_NEUTRAL',	5);

--------------------------------		
-- Leader_MajorCivApproachBiases
--------------------------------		
INSERT INTO Leader_MajorCivApproachBiases
		(LeaderType,				MajorCivApproachType,			Bias)
VALUES	('LEADER_EW_TSOUHARISSEN',	'MAJOR_CIV_APPROACH_WAR',		6),
		('LEADER_EW_TSOUHARISSEN',	'MAJOR_CIV_APPROACH_HOSTILE',	4),
		('LEADER_EW_TSOUHARISSEN',	'MAJOR_CIV_APPROACH_DECEPTIVE',	3),
		('LEADER_EW_TSOUHARISSEN',	'MAJOR_CIV_APPROACH_GUARDED',	5),
		('LEADER_EW_TSOUHARISSEN',	'MAJOR_CIV_APPROACH_AFRAID',	1),
		('LEADER_EW_TSOUHARISSEN',	'MAJOR_CIV_APPROACH_FRIENDLY',	3),
		('LEADER_EW_TSOUHARISSEN',	'MAJOR_CIV_APPROACH_NEUTRAL',	6);
		
--------------------------------		
-- Leader_MinorCivApproachBiases	
--------------------------------	
INSERT INTO Leader_MinorCivApproachBiases
		(LeaderType,				MinorCivApproachType,			Bias)
VALUES	('LEADER_EW_TSOUHARISSEN',	'MINOR_CIV_APPROACH_IGNORE',	5),
		('LEADER_EW_TSOUHARISSEN',	'MINOR_CIV_APPROACH_FRIENDLY',	3),
		('LEADER_EW_TSOUHARISSEN',	'MINOR_CIV_APPROACH_PROTECTIVE',2),
		('LEADER_EW_TSOUHARISSEN',	'MINOR_CIV_APPROACH_CONQUEST',	6),
		('LEADER_EW_TSOUHARISSEN',	'MINOR_CIV_APPROACH_BULLY',		2);
		
--------------------------------		
-- Leader_Flavors
--------------------------------		
INSERT INTO Leader_Flavors
		(LeaderType,				FlavorType,						Flavor)
VALUES	('LEADER_EW_TSOUHARISSEN',	'FLAVOR_OFFENSE',				5),
		('LEADER_EW_TSOUHARISSEN',	'FLAVOR_DEFENSE',				7),
		('LEADER_EW_TSOUHARISSEN',	'FLAVOR_CITY_DEFENSE',			7),
		('LEADER_EW_TSOUHARISSEN',	'FLAVOR_MILITARY_TRAINING',		7),
		('LEADER_EW_TSOUHARISSEN',	'FLAVOR_RECON',					3),
		('LEADER_EW_TSOUHARISSEN',	'FLAVOR_RANGED',				3),
		('LEADER_EW_TSOUHARISSEN',	'FLAVOR_MOBILE',				3),
		('LEADER_EW_TSOUHARISSEN',	'FLAVOR_NAVAL',					5),
		('LEADER_EW_TSOUHARISSEN',	'FLAVOR_NAVAL_RECON',			2),
		('LEADER_EW_TSOUHARISSEN',	'FLAVOR_NAVAL_GROWTH',			3),
		('LEADER_EW_TSOUHARISSEN',	'FLAVOR_NAVAL_TILE_IMPROVEMENT',5),
		('LEADER_EW_TSOUHARISSEN',	'FLAVOR_AIR',					2),
		('LEADER_EW_TSOUHARISSEN',	'FLAVOR_EXPANSION',				7),
		('LEADER_EW_TSOUHARISSEN',	'FLAVOR_GROWTH',				6),
		('LEADER_EW_TSOUHARISSEN',	'FLAVOR_TILE_IMPROVEMENT',		5),
		('LEADER_EW_TSOUHARISSEN',	'FLAVOR_INFRASTRUCTURE',		5),
		('LEADER_EW_TSOUHARISSEN',	'FLAVOR_PRODUCTION',			8),
		('LEADER_EW_TSOUHARISSEN',	'FLAVOR_GOLD',					2),
		('LEADER_EW_TSOUHARISSEN',	'FLAVOR_SCIENCE',				7),
		('LEADER_EW_TSOUHARISSEN',	'FLAVOR_CULTURE',				6),
		('LEADER_EW_TSOUHARISSEN',	'FLAVOR_HAPPINESS',				3),
		('LEADER_EW_TSOUHARISSEN',	'FLAVOR_GREAT_PEOPLE',			4),
		('LEADER_EW_TSOUHARISSEN',	'FLAVOR_WONDER',				3),
		('LEADER_EW_TSOUHARISSEN',	'FLAVOR_RELIGION',				2),
		('LEADER_EW_TSOUHARISSEN',	'FLAVOR_DIPLOMACY',				7),
		('LEADER_EW_TSOUHARISSEN',	'FLAVOR_SPACESHIP',				5),
		('LEADER_EW_TSOUHARISSEN',	'FLAVOR_WATER_CONNECTION',		5),
		('LEADER_EW_TSOUHARISSEN',	'FLAVOR_NUKE',					5),
		('LEADER_EW_TSOUHARISSEN',	'FLAVOR_USE_NUKE',				5),
		('LEADER_EW_TSOUHARISSEN',	'FLAVOR_ESPIONAGE',				5),
		('LEADER_EW_TSOUHARISSEN',	'FLAVOR_AIRLIFT',				5),
		('LEADER_EW_TSOUHARISSEN',	'FLAVOR_I_TRADE_DESTINATION',	5),
		('LEADER_EW_TSOUHARISSEN',	'FLAVOR_I_TRADE_ORIGIN',		5),
		('LEADER_EW_TSOUHARISSEN',	'FLAVOR_I_SEA_TRADE_ROUTE',		5),
		('LEADER_EW_TSOUHARISSEN',	'FLAVOR_I_LAND_TRADE_ROUTE',	7),
		('LEADER_EW_TSOUHARISSEN',	'FLAVOR_ARCHAEOLOGY',			5),
		('LEADER_EW_TSOUHARISSEN',	'FLAVOR_AIR_CARRIER',			4);
		
--------------------------------	
-- Leader_Traits
--------------------------------
INSERT INTO Leader_Traits
		(LeaderType,				TraitType)
VALUES	('LEADER_EW_TSOUHARISSEN',	'TRAIT_EW_TSOUHARISSEN');

--==========================================================================================================================	
-- TRAITS
--==========================================================================================================================	
-- Traits
--------------------------------	
INSERT INTO Traits
		(Type,						Description,						ShortDescription)
VALUES	('TRAIT_EW_TSOUHARISSEN',	'TXT_KEY_TRAIT_EW_TSOUHARISSEN',	'TXT_KEY_TRAIT_EW_TSOUHARISSEN_SHORT');

--==========================================================================================================================	
-- CIVILIZATIONS
--==========================================================================================================================	
-- Civilizations
--------------------------------
INSERT INTO Civilizations
		(Type,						Description,						ShortDescription,							Adjective,								CivilopediaTag,				DefaultPlayerColor,			ArtDefineTag,						ArtStyleType,				ArtStyleSuffix,	ArtStylePrefix,	IconAtlas,			PortraitIndex,	AlphaIconAtlas,					MapImage,				DawnOfManQuote,						DawnOfManImage, 	DawnOfManAudio)
VALUES	('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_CIVILIZATION_EW_NEUTRAL_SHORT',	'TXT_KEY_CIVILIZATION_EW_NEUTRAL_ADJ',	'TXT_KEY_CIV5_EW_NEUTRAL',	'PLAYERCOLOR_EW_NEUTRAL',	'ART_DEF_CIVILIZATION_EW_NEUTRAL',	'ARTSTYLE_SOUTH_AMERICA',	'AMER_',		'AMERICAN',		'ATLAS_RT_NEUTRAL',	0,				'ATLAS_ALPHA_RT_NEUTRAL',		'Neutral_Map.dds',	'TXT_KEY_CIVILIZATION_EW_NEUTRAL_DOM',	'Neutral_DOM.dds', 'AS2D_DOM_SPEECH_NEUTRAL');

--------------------------------	
-- Civilization_CityNames
--------------------------------	
INSERT INTO Civilization_CityNames
		(CivilizationType,	CityName)
VALUES	('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_CIVILIZATION_EW_NEUTRAL_CITY_1'),
		('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_CIVILIZATION_EW_NEUTRAL_CITY_2'),
		('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_CIVILIZATION_EW_NEUTRAL_CITY_3'),
		('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_CIVILIZATION_EW_NEUTRAL_CITY_4'),
		('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_CIVILIZATION_EW_NEUTRAL_CITY_5'),
		('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_CIVILIZATION_EW_NEUTRAL_CITY_6'),
		('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_CIVILIZATION_EW_NEUTRAL_CITY_7'),
		('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_CIVILIZATION_EW_NEUTRAL_CITY_8'),
		('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_CIVILIZATION_EW_NEUTRAL_CITY_9'),
		('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_CIVILIZATION_EW_NEUTRAL_CITY_10'),
		('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_CIVILIZATION_EW_NEUTRAL_CITY_11'),
		('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_CIVILIZATION_EW_NEUTRAL_CITY_12'),
		('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_CIVILIZATION_EW_NEUTRAL_CITY_13'),
		('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_CIVILIZATION_EW_NEUTRAL_CITY_14'),
		('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_CIVILIZATION_EW_NEUTRAL_CITY_15'),
		('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_CIVILIZATION_EW_NEUTRAL_CITY_16'),
		('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_CIVILIZATION_EW_NEUTRAL_CITY_17'),
		('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_CIVILIZATION_EW_NEUTRAL_CITY_18'),
		('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_CIVILIZATION_EW_NEUTRAL_CITY_19'),
		('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_CIVILIZATION_EW_NEUTRAL_CITY_20'),
		('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_CIVILIZATION_EW_NEUTRAL_CITY_21'),
		('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_CIVILIZATION_EW_NEUTRAL_CITY_22'),
		('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_CIVILIZATION_EW_NEUTRAL_CITY_23'),
		('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_CIVILIZATION_EW_NEUTRAL_CITY_24'),
		('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_CIVILIZATION_EW_NEUTRAL_CITY_25'),
		('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_CIVILIZATION_EW_NEUTRAL_CITY_26'),
		('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_CIVILIZATION_EW_NEUTRAL_CITY_27'),
		('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_CIVILIZATION_EW_NEUTRAL_CITY_28'),
		('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_CIVILIZATION_EW_NEUTRAL_CITY_29'),
		('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_CIVILIZATION_EW_NEUTRAL_CITY_30'),
		('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_CIVILIZATION_EW_NEUTRAL_CITY_31'),
		('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_CIVILIZATION_EW_NEUTRAL_CITY_32'),
		('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_CIVILIZATION_EW_NEUTRAL_CITY_33');

--------------------------------	
-- Civilization_Leaders
--------------------------------	
INSERT INTO Civilization_Leaders
		(CivilizationType,			LeaderheadType)
VALUES	('CIVILIZATION_EW_NEUTRAL',	'LEADER_EW_TSOUHARISSEN');

--------------------------------	
-- Civilization_FreeBuildingClasses
--------------------------------			
INSERT INTO Civilization_FreeBuildingClasses 
		(CivilizationType, 			BuildingClassType)
SELECT	'CIVILIZATION_EW_NEUTRAL', 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE CivilizationType = 'CIVILIZATION_IROQUOIS';

--------------------------------		
-- Civilization_FreeTechs
--------------------------------			
INSERT INTO Civilization_FreeTechs 
		(CivilizationType, 			TechType)
SELECT	'CIVILIZATION_EW_NEUTRAL', 	TechType
FROM Civilization_FreeTechs WHERE CivilizationType = 'CIVILIZATION_IROQUOIS';

--------------------------------	
-- Civilization_FreeUnits
--------------------------------		
INSERT INTO Civilization_FreeUnits 
		(CivilizationType, 			UnitClassType, Count, UnitAIType)
SELECT	'CIVILIZATION_EW_NEUTRAL', 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE CivilizationType = 'CIVILIZATION_IROQUOIS';

--------------------------------	
-- Civilization_UnitClassOverrides
--------------------------------	
INSERT INTO Civilization_UnitClassOverrides
		(CivilizationType,			UnitClassType, 			UnitType)
VALUES	('CIVILIZATION_EW_NEUTRAL',	'UNITCLASS_SWORDSMAN',	'UNIT_EW_CHONNONTON');

--------------------------------	
-- Civilization_BuildingClassOverrides
--------------------------------	
INSERT INTO Civilization_BuildingClassOverrides
		(CivilizationType,				BuildingClassType,		BuildingType)
VALUES	('CIVILIZATION_EW_NEUTRAL',		'BUILDINGCLASS_FORGE',	'BUILDING_EW_TATTOOIST');

--------------------------------	

--------------------------------	
-- Civilization_SpyNames
--------------------------------	
INSERT INTO Civilization_SpyNames
		(CivilizationType,			SpyName)
VALUES	('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_EW_NEUTRAL_SPY_1'),
		('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_EW_NEUTRAL_SPY_2'),
		('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_EW_NEUTRAL_SPY_3'),
		('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_EW_NEUTRAL_SPY_4'),
		('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_EW_NEUTRAL_SPY_5'),
		('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_EW_NEUTRAL_SPY_6'),
		('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_EW_NEUTRAL_SPY_7'),
		('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_EW_NEUTRAL_SPY_8'),
		('CIVILIZATION_EW_NEUTRAL',	'TXT_KEY_EW_NEUTRAL_SPY_9');
		
--==========================================================================================================================	
-- PROMOTIONS
--==========================================================================================================================	
-- UnitPromotions
------------------------------
INSERT INTO UnitPromotions
		(Type,							Description,							Help,										PortraitIndex,	IconAtlas,			Sound,				CannotBeChosen,	CityAttack,	AttackMod, 	DefenseMod, PediaType,			PediaEntry,									CombatPercent)
VALUES	('PROMOTION_EW_WAR_TATTOO',		'TXT_KEY_PROMOTION_EW_WAR_TATTOO',		'TXT_KEY_PROMOTION_EW_WAR_TATTOO_HELP',		40,				'PROMOTION_ATLAS',	'AS2D_IF_LEVELUP',	1,				10,			0, 			0, 			'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_EW_WAR_TATTOO_HELP',		0),
		('PROMOTION_EW_NEUTRALITY',		'TXT_KEY_PROMOTION_EW_NEUTRALITY',		'TXT_KEY_PROMOTION_EW_NEUTRALITY_HELP',		57,				'ABILITY_ATLAS',	'AS2D_IF_LEVELUP',	1,				0,			0, 			0, 			'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_EW_NEUTRALITY_HELP',		0),
		('PROMOTION_EW_ATTACK_DEFENSE',	'TXT_KEY_PROMOTION_EW_ATTACK_DEFENSE',	'TXT_KEY_PROMOTION_EW_ATTACK_DEFENSE_HELP',	57,				'ABILITY_ATLAS',	'AS2D_IF_LEVELUP',	1,				0,			25, 		-10, 		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_EW_NEUTRALITY_HELP',		0);

		
--==========================================================================================================================
-- UNITS
--==========================================================================================================================
-- Units
--------------------------------
INSERT INTO Units
		(Type,					Description,					Civilopedia,						Help,								Strategy,								Combat,		Cost,		CombatClass, CivilianAttackPriority, Moves,	BaseSightRange,	Class,	Domain,	DefaultUnitAI,	MilitarySupport,	MilitaryProduction,	Pillage,	IgnoreBuildingDefense,	PrereqTech,	ObsoleteTech,		GoodyHutUpgradeUnitClass,	AdvancedStartCost,	MinAreaSize,	NukeDamageLevel,	CombatLimit,	XPValueAttack,	XPValueDefense,	UnitArtInfo,					ShowInPedia,	MoveRate,	UnitFlagIconOffset,	PortraitIndex,	IconAtlas,			UnitFlagAtlas)
SELECT	'UNIT_EW_CHONNONTON',	'TXT_KEY_UNIT_EW_CHONNONTON',	'TXT_KEY_UNIT_EW_CHONNONTON_PEDIA',	'TXT_KEY_UNIT_EW_CHONNONTON_HELP',	'TXT_KEY_UNIT_EW_CHONNONTON_STRATEGY',	Combat+3,	Cost+25,	CombatClass, CivilianAttackPriority, Moves,	BaseSightRange,	Class,	Domain,	DefaultUnitAI,	MilitarySupport,	MilitaryProduction,	Pillage,	IgnoreBuildingDefense,	PrereqTech,	'TECH_GUNPOWDER',	GoodyHutUpgradeUnitClass,	AdvancedStartCost,	MinAreaSize,	NukeDamageLevel,	CombatLimit,	XPValueAttack,	XPValueDefense,	'ART_DEF_UNIT_EW_CHONNONTON',	ShowInPedia,	MoveRate,	0,					4,				'ATLAS_RT_NEUTRAL',	'RT_UNIT_FLAG_CHONNONTON_ATLAS'
FROM Units WHERE Type = 'UNIT_SWORDSMAN';

--------------------------------	
-- Unit_Flavors
--------------------------------	
INSERT INTO Unit_Flavors
		(UnitType,				FlavorType,	Flavor)
SELECT	'UNIT_EW_CHONNONTON',	FlavorType,	Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_SWORDSMAN';

--------------------------------	
-- UnitGameplay2DScripts
--------------------------------	
INSERT INTO UnitGameplay2DScripts
		(UnitType,				SelectionSound,				FirstSelectionSound)
VALUES	('UNIT_EW_CHONNONTON',	'AS2D_SELECT_SWORDSMAN',	'AS2D_BIRTH_SWORDSMAN');

--------------------------------	
-- Unit_AITypes
--------------------------------	
INSERT INTO Unit_AITypes
		(UnitType,				UnitAIType)
SELECT	'UNIT_EW_CHONNONTON',	UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_SWORDSMAN';

--------------------------------	
-- Unit_FreePromotions
--------------------------------	
INSERT INTO Unit_FreePromotions 	
		(UnitType, 				PromotionType)
VALUES	('UNIT_EW_CHONNONTON', 	'PROMOTION_EW_ATTACK_DEFENSE');

--=======================================================================================================================
-- BUILDINGCLASSES
--=======================================================================================================================
-- BuildingClasses
------------------------------	
INSERT INTO BuildingClasses
		(Type, 								DefaultBuilding, 								Description)
VALUES	('BUILDINGCLASS_LIME_NEUTRAL_1', 	'BUILDING_NEUTRAL_MILITARY_PRODUCTION_DUMMY', 	'TXT_KEY_BUILDINGCLASS_LIME_NEUTRAL_1_DESC');

--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================	
-- Buildings
------------------------------	
INSERT INTO Buildings
		(Type,						Description,						Civilopedia,							Help,									Strategy,									BuildingClass,	Cost,	GoldMaintenance,	PrereqTech,		ArtDefineTag,	MinAreaSize,	NeverCapture,	HurryCostModifier,	PortraitIndex,	IconAtlas)
SELECT	'BUILDING_EW_TATTOOIST',	'TXT_KEY_BUILDING_EW_TATTOOIST',	'TXT_KEY_BUILDING_EW_TATTOOIST_PEDIA',	'TXT_KEY_BUILDING_EW_TATTOOIST_HELP',	'TXT_KEY_BUILDING_EW_TATTOOIST_STRATEGY', 	BuildingClass, 	Cost, 	GoldMaintenance, 	PrereqTech, 	ArtDefineTag, 	MinAreaSize, 	1, 				HurryCostModifier, 	3, 				'ATLAS_RT_NEUTRAL'
FROM Buildings WHERE Type = 'BUILDING_FORGE';

INSERT INTO Buildings	
		(Type, 											BuildingClass, 			  				Cost, 	FaithCost,	ConquestProb,	Description, 								Help,											NeverCapture)
VALUES 	('BUILDING_NEUTRAL_MILITARY_PRODUCTION_DUMMY', 'BUILDINGCLASS_LIME_NEUTRAL_1', 			-1, 	-1, 		0, 				'TXT_KEY_BUILDING_LIME_NEUTRAL_1_DESC', 	'TXT_KEY_BUILDING_LIME_NEUTRAL_1_HELP', 		1);

------------------------------
-- Building_Flavors
------------------------------
INSERT INTO Building_Flavors
		(BuildingType,				FlavorType,					Flavor)
VALUES	('BUILDING_EW_TATTOOIST',	'FLAVOR_PRODUCTION',		40),
		('BUILDING_EW_TATTOOIST',	'FLAVOR_MILITARY_TRAINING',	40);
		
------------------------------
-- Building_DomainProductionModifiers
------------------------------
INSERT INTO Building_DomainProductionModifiers
		(BuildingType,									DomainType,			Modifier)
VALUES	('BUILDING_EW_TATTOOIST',						'DOMAIN_LAND',		5),
		('BUILDING_NEUTRAL_MILITARY_PRODUCTION_DUMMY',	'DOMAIN_LAND',		10),
		('BUILDING_NEUTRAL_MILITARY_PRODUCTION_DUMMY',	'DOMAIN_SEA',		10),
		('BUILDING_NEUTRAL_MILITARY_PRODUCTION_DUMMY',	'DOMAIN_AIR',		10),
		('BUILDING_NEUTRAL_MILITARY_PRODUCTION_DUMMY',	'DOMAIN_IMMOBILE',	10),
		('BUILDING_NEUTRAL_MILITARY_PRODUCTION_DUMMY',	'DOMAIN_HOVER',		10);
		
------------------------------
-- Building_ResourceQuantity
------------------------------
INSERT INTO Building_ResourceQuantity
		(BuildingType, 									ResourceType, 	Quantity)
VALUES	('BUILDING_NEUTRAL_MILITARY_PRODUCTION_DUMMY', 'RESOURCE_IRON', 3);

--==========================================================================================================================	
-- RESOURCES
--==========================================================================================================================	
-- Resources
------------------------------	
INSERT INTO Resources
		(Type,					Description,					Civilopedia,						ResourceClassType,		ArtDefineTag,					TechCityTrade,	Happiness,	MinAreaSize,	IconString,					PortraitIndex,	IconAtlas)
VALUES	('RESOURCE_EW_FLINT',	'TXT_KEY_RESOURCE_EW_FLINT',	'TXT_KEY_RESOURCE_EW_FLINT_PEDIA',	'RESOURCECLASS_LUXURY',	'ART_DEF_RESOURCE_LIME_FLINT',	'TECH_MINING',	4,			3,				'[ICON_RESOURCE_EW_FLINT]',	1,				'ATLAS_RT_NEUTRAL');

------------------------------
-- Resource_YieldChanges
------------------------------
INSERT INTO Resource_YieldChanges
		(ResourceType,			YieldType,			Yield)
VALUES	('RESOURCE_EW_FLINT',	'YIELD_PRODUCTION',	1),
		('RESOURCE_EW_FLINT',	'YIELD_GOLD',		1);
		
------------------------------
-- Resource_Flavors
------------------------------
INSERT INTO Resource_Flavors
		(ResourceType,			FlavorType,					Flavor)
VALUES	('RESOURCE_EW_FLINT',	'FLAVOR_MILITARY_TRAINING',	15),
		('RESOURCE_EW_FLINT',	'FLAVOR_HAPPINESS',			15);

------------------------------
-- Improvement_ResourceTypes
------------------------------
INSERT INTO Improvement_ResourceTypes
		(ImprovementType,		ResourceType,			ResourceMakesValid,	ResourceTrade)
VALUES	('IMPROVEMENT_MINE',	'RESOURCE_EW_FLINT',	1,					1);

------------------------------
-- Improvement_ResourceType_Yields
------------------------------
INSERT INTO Improvement_ResourceType_Yields
		(ImprovementType,		ResourceType,			YieldType,			Yield)
VALUES	('IMPROVEMENT_MINE',	'RESOURCE_EW_FLINT',	'YIELD_PRODUCTION',	1);

------------------------------
-- Building_ResourceYieldChanges
------------------------------
INSERT INTO Building_ResourceYieldChanges
		(BuildingType,				ResourceType,		YieldType,			Yield)
VALUES	('BUILDING_EW_TATTOOIST', 	'RESOURCE_IRON', 	'YIELD_PRODUCTION', 1),
		('BUILDING_EW_TATTOOIST', 	'RESOURCE_EW_FLINT','YIELD_PRODUCTION', 1);
