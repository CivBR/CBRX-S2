 --=======================================================================================================================
-- BUILDINGCLASSES
--=======================================================================================================================
-- BuildingClasses
------------------------------
INSERT INTO BuildingClasses
		(Type, 							DefaultBuilding, 			Description)
VALUES	('BUILDINGCLASS_CBR_POMO_1', 	'BUILDING_CBR_DANCE_CAVE', 	'TXT_KEY_BUILDING_CBR_DANCE_CAVE'),
		('BUILDINGCLASS_CBR_POMO_2', 	'BUILDING_CBR_DANCE_CAVE_2', 	'TXT_KEY_BUILDING_CBR_DANCE_CAVE');

--==========================================================================================================================
-- BUILDINGS
--==========================================================================================================================
-- Buildings
------------------------------
INSERT INTO Buildings
		(Type, 						BuildingClass, 			  	GreatWorkSlotType, 				GreatWorkCount, Cost, FaithCost, PrereqTech, GoldMaintenance, MinAreaSize, SpecialistCount, SpecialistType, MutuallyExclusiveGroup, NeverCapture, Description, 							Help, 										Strategy,									Civilopedia, 						ArtDefineTag,	PortraitIndex,	IconAtlas)
SELECT	 'BUILDING_CBR_DANCE_CAVE',	'BUILDINGCLASS_CBR_POMO_1', 'GREAT_WORK_SLOT_LITERATURE', 	1, 				Cost, FaithCost, PrereqTech, GoldMaintenance, MinAreaSize, SpecialistCount, SpecialistType, MutuallyExclusiveGroup, 1, 			  'TXT_KEY_BUILDING_CBR_DANCE_CAVE', 	'TXT_KEY_BUILDING_CBR_DANCE_CAVE_HELP',		'TXT_KEY_BUILDING_CBR_DANCE_CAVE_STRATEGY',	'TXT_KEY_CIV5_CBR_DANCE_CAVE_TEXT',	ArtDefineTag,	4, 				'CBR_POMO_ATLAS'
FROM Buildings WHERE Type = 'BUILDING_AMPHITHEATER';

INSERT INTO Buildings
		(Type, 						BuildingClass, 			  	GreatWorkSlotType, 					GreatWorkCount, Cost, FaithCost, GoldMaintenance, NeverCapture, Description, 						Help, 										Strategy,									Civilopedia, 						ArtDefineTag,	PortraitIndex,	IconAtlas)
SELECT	'BUILDING_CBR_DANCE_CAVE_2','BUILDINGCLASS_CBR_POMO_2',	'GREAT_WORK_SLOT_ART_ARTIFACT', 	1, 				-1,   -1, 		 0, 			  1, 			'TXT_KEY_BUILDING_CBR_DANCE_CAVE', 	'TXT_KEY_BUILDING_CBR_DANCE_CAVE_HELP',		'TXT_KEY_BUILDING_CBR_DANCE_CAVE_STRATEGY',	'TXT_KEY_CIV5_CBR_DANCE_CAVE_TEXT',	ArtDefineTag,	4, 				'CBR_POMO_ATLAS'
FROM Buildings WHERE Type = 'BUILDING_AMPHITHEATER';

INSERT INTO Buildings
		(Type, 								PrereqTech, 	BuildingClass, 	Description, Civilopedia, Strategy, Help, GoldMaintenance, MutuallyExclusiveGroup, Cost, 	ConquestProb, MinAreaSize, HurryCostModifier, ArtDefineTag, SpecialistType, SpecialistCount, GreatPeopleRateChange, PortraitIndex, IconAtlas)
SELECT	'BUILDING_CBR_POMO_ARTISTS_GUILD',	'TECH_POTTERY',	BuildingClass, 	Description, Civilopedia, Strategy, Help, GoldMaintenance, MutuallyExclusiveGroup, 75, 		ConquestProb, MinAreaSize, HurryCostModifier, ArtDefineTag, SpecialistType, SpecialistCount, GreatPeopleRateChange, PortraitIndex, IconAtlas
FROM Buildings WHERE Type = 'BUILDING_ARTISTS_GUILD';

--------------------------------
-- Building_ClassesNeededInCity
--------------------------------
INSERT INTO Building_ClassesNeededInCity
		(BuildingType, 					BuildingClassType)
SELECT	'BUILDING_CBR_DANCE_CAVE',		BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_AMPHITHEATER';
------------------------------
-- Building_YieldChanges
------------------------------
INSERT INTO Building_YieldChanges
		(BuildingType, 					YieldType,			Yield)
SELECT	'BUILDING_CBR_DANCE_CAVE',		YieldType,			Yield
FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_AMPHITHEATER';
------------------------------
-- Building_Flavors
------------------------------
INSERT INTO Building_Flavors
		(BuildingType, 				FlavorType,			Flavor)
SELECT	'BUILDING_CBR_DANCE_CAVE',	FlavorType,			Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_AMPHITHEATER';
------------------------------
-- Building_DomainFreeExperiences
------------------------------
INSERT INTO Building_DomainFreeExperiences
		(BuildingType, 				DomainType,	Experience)
SELECT	'BUILDING_CBR_DANCE_CAVE',	DomainType,	10
FROM Building_DomainFreeExperiences WHERE BuildingType = 'BUILDING_BARRACKS';

--==========================================================================================================================
-- UNITS
--==========================================================================================================================
-- Units
--------------------------------
INSERT INTO Units
			(Type, 						Class, Cost,  Moves, CivilianAttackPriority, Special, Domain, DefaultUnitAI, WorkRate, CombatLimit, GoldenAgeTurns, MoveRate, 	Description, 						Civilopedia, 							Strategy,									Help,									AdvancedStartCost,	UnitArtInfo, 						UnitFlagIconOffset, UnitFlagAtlas,							PortraitIndex, 	IconAtlas)
SELECT		'UNIT_CBR_BASKET_WEAVER',	Class, Cost,  Moves, CivilianAttackPriority, Special, Domain, DefaultUnitAI, WorkRate, CombatLimit, 0, 				MoveRate,	'TXT_KEY_UNIT_CBR_BASKET_WEAVER', 	'TXT_KEY_CIV5_UNIT_CBR_BASKET_WEAVER',	'TXT_KEY_UNIT_CBR_BASKET_WEAVER_STRATEGY', 'TXT_KEY_UNIT_CBR_BASKET_WEAVER_HELP',  	AdvancedStartCost, 	'ART_DEF_UNIT_CBR_BASKET_WEAVER', 	0, 					'CBR_UNIT_FLAG_BASKET_WEAVER_ATLAS',	2, 				'CBR_POMO_ATLAS'
FROM Units WHERE Type = 'UNIT_ARTIST';
--------------------------------
-- UnitGameplay2DScripts
--------------------------------
INSERT INTO UnitGameplay2DScripts
		(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT	'UNIT_CBR_BASKET_WEAVER', 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_ARTIST';
--------------------------------
-- Unit_AITypes
--------------------------------
INSERT INTO Unit_AITypes
		(UnitType, 					UnitAIType)
VALUES	('UNIT_CBR_BASKET_WEAVER', 	'UNITAI_ARTIST'),
		('UNIT_CBR_BASKET_WEAVER', 	'UNITAI_MERCHANT');
--------------------------------
-- Unit_ClassUpgrades
--------------------------------
INSERT INTO Unit_ClassUpgrades
		(UnitType, 					UnitClassType)
SELECT	'UNIT_CBR_BASKET_WEAVER', 	UnitClassType
FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_ARTIST';
--------------------------------
-- Unit_Flavors
--------------------------------
INSERT INTO Unit_Flavors
		(UnitType, 					FlavorType,	 Flavor)
SELECT	'UNIT_CBR_BASKET_WEAVER', 	FlavorType,	 Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_ARTIST';
--------------------------------
-- Unit_UniqueNames
--------------------------------
INSERT INTO Unit_UniqueNames
		(UnitType, 					UniqueName, 					GreatWorkType)
VALUES	('UNIT_CBR_BASKET_WEAVER',	'TXT_KEY_POMO_BASKET_WEAVER_1', 'GREAT_WORK_WATER_LILIES'),
		('UNIT_CBR_BASKET_WEAVER',	'TXT_KEY_POMO_BASKET_WEAVER_2', 'GREAT_WORK_WATER_LILIES'),
		('UNIT_CBR_BASKET_WEAVER',	'TXT_KEY_POMO_BASKET_WEAVER_3', 'GREAT_WORK_WATER_LILIES'),
		('UNIT_CBR_BASKET_WEAVER',	'TXT_KEY_POMO_BASKET_WEAVER_4', 'GREAT_WORK_WATER_LILIES'),
		('UNIT_CBR_BASKET_WEAVER',	'TXT_KEY_POMO_BASKET_WEAVER_5', 'GREAT_WORK_WATER_LILIES'),
		('UNIT_CBR_BASKET_WEAVER',	'TXT_KEY_POMO_BASKET_WEAVER_6', 'GREAT_WORK_WATER_LILIES'),
		('UNIT_CBR_BASKET_WEAVER',	'TXT_KEY_POMO_BASKET_WEAVER_7', 'GREAT_WORK_WATER_LILIES'),
		('UNIT_CBR_BASKET_WEAVER',	'TXT_KEY_POMO_BASKET_WEAVER_8', 'GREAT_WORK_WATER_LILIES'),
		('UNIT_CBR_BASKET_WEAVER',	'TXT_KEY_POMO_BASKET_WEAVER_9', 'GREAT_WORK_WATER_LILIES'),
		('UNIT_CBR_BASKET_WEAVER',	'TXT_KEY_POMO_BASKET_WEAVER_10', 'GREAT_WORK_WATER_LILIES');

--------------------------------
-- Unit_Builds
--------------------------------
INSERT INTO Unit_Builds
		(UnitType, 						BuildType)
SELECT	'UNIT_CBR_BASKET_WEAVER',		BuildType
FROM Unit_Builds WHERE UnitType = 'UNIT_ARTIST';

--==========================================================================================================================
-- PROMOTIONS
--==========================================================================================================================
-- UnitPromotions
--------------------------------
INSERT INTO UnitPromotions
		(Type, 							CombatPercent, CannotBeChosen,	Description, 						Help, 									Sound, 	IconAtlas, 	PortraitIndex, 	PediaType, 	PediaEntry)
SELECT	'PROMOTION_CBR_POMO_EAST',		-10, 			1, 				'TXT_KEY_PROMOTION_CBR_POMO_EAST', 	'TXT_KEY_PROMOTION_CBR_POMO_EAST_HELP', Sound, 	IconAtlas, 	PortraitIndex, 	PediaType, 'TXT_KEY_PROMOTION_CBR_POMO_EAST_PEDIA'
FROM UnitPromotions Where Type = 'PROMOTION_MORALE';

INSERT INTO UnitPromotions
		(Type, 							CombatPercent, CannotBeChosen,	Description, 						Help, 									Sound, 	IconAtlas, 	PortraitIndex, 	PediaType, 	PediaEntry)
SELECT	 'PROMOTION_CBR_POMO_NORTH',	10, 			1, 				'TXT_KEY_PROMOTION_CBR_POMO_NORTH', 'TXT_KEY_PROMOTION_CBR_POMO_NORTH_HELP',Sound, 	IconAtlas, 	PortraitIndex, 	PediaType, 'TXT_KEY_PROMOTION_CBR_POMO_NORTH_PEDIA'
FROM UnitPromotions Where Type = 'PROMOTION_MORALE';

--==========================================================================================================================
-- LEADERS
--==========================================================================================================================
-- Leaders
--------------------------------
INSERT INTO Leaders
		(Type, 					Description, 				Civilopedia, 						CivilopediaTag, 							ArtDefineTag, 	VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 			PortraitIndex)
SELECT	'LEADER_CBR_ESSIE', 	'TXT_KEY_LEADER_CBR_ESSIE', 'TXT_KEY_LEADER_CBR_ESSIE_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_CBR_ESSIE', 	ArtDefineTag,	7, 						3, 						5, 							5, 			7, 				9, 				8, 						4, 				5, 			4, 			2, 				6, 			5, 			'CBR_POMO_ATLAS', 	1
FROM Leaders Where Type = 'LEADER_HIAWATHA';
--------------------------------
-- Leader_MajorCivApproachBiases
--------------------------------
INSERT INTO Leader_MajorCivApproachBiases
		(LeaderType, 			MajorCivApproachType, 				Bias)
VALUES	('LEADER_CBR_ESSIE', 	'MAJOR_CIV_APPROACH_WAR', 			4),
		('LEADER_CBR_ESSIE', 	'MAJOR_CIV_APPROACH_HOSTILE', 		4),
		('LEADER_CBR_ESSIE', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	8),
		('LEADER_CBR_ESSIE', 	'MAJOR_CIV_APPROACH_GUARDED', 		7),
		('LEADER_CBR_ESSIE', 	'MAJOR_CIV_APPROACH_AFRAID', 		6),
		('LEADER_CBR_ESSIE', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		8),
		('LEADER_CBR_ESSIE', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		5);
--------------------------------
-- Leader_MajorCivApproachBiases
--------------------------------
INSERT INTO Leader_MinorCivApproachBiases
		(LeaderType, 			MinorCivApproachType, 				Bias)
VALUES	('LEADER_CBR_ESSIE', 	'MINOR_CIV_APPROACH_IGNORE', 		2),
		('LEADER_CBR_ESSIE', 	'MINOR_CIV_APPROACH_FRIENDLY', 		6),
		('LEADER_CBR_ESSIE', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	5),
		('LEADER_CBR_ESSIE', 	'MINOR_CIV_APPROACH_CONQUEST', 		4),
		('LEADER_CBR_ESSIE', 	'MINOR_CIV_APPROACH_BULLY', 		3);
--------------------------------
-- Leader_Flavors
--------------------------------
INSERT INTO Leader_Flavors
		(LeaderType, 			FlavorType, 						Flavor)
VALUES	('LEADER_CBR_ESSIE', 	'FLAVOR_OFFENSE', 					6),
		('LEADER_CBR_ESSIE', 	'FLAVOR_DEFENSE', 					7),
		('LEADER_CBR_ESSIE', 	'FLAVOR_CITY_DEFENSE', 				5),
		('LEADER_CBR_ESSIE', 	'FLAVOR_MILITARY_TRAINING', 		5),
		('LEADER_CBR_ESSIE', 	'FLAVOR_RECON', 					4),
		('LEADER_CBR_ESSIE', 	'FLAVOR_RANGED', 					4),
		('LEADER_CBR_ESSIE', 	'FLAVOR_MOBILE', 					5),
		('LEADER_CBR_ESSIE', 	'FLAVOR_NAVAL', 					5),
		('LEADER_CBR_ESSIE', 	'FLAVOR_NAVAL_RECON', 				5),
		('LEADER_CBR_ESSIE', 	'FLAVOR_NAVAL_GROWTH', 				5),
		('LEADER_CBR_ESSIE', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
		('LEADER_CBR_ESSIE', 	'FLAVOR_AIR', 						3),
		('LEADER_CBR_ESSIE', 	'FLAVOR_EXPANSION', 				7),
		('LEADER_CBR_ESSIE', 	'FLAVOR_GROWTH', 					5),
		('LEADER_CBR_ESSIE', 	'FLAVOR_TILE_IMPROVEMENT', 			5),
		('LEADER_CBR_ESSIE', 	'FLAVOR_INFRASTRUCTURE', 			5),
		('LEADER_CBR_ESSIE', 	'FLAVOR_PRODUCTION', 				5),
		('LEADER_CBR_ESSIE', 	'FLAVOR_GOLD', 						7),
		('LEADER_CBR_ESSIE', 	'FLAVOR_SCIENCE', 					5),
		('LEADER_CBR_ESSIE', 	'FLAVOR_CULTURE', 					8),
		('LEADER_CBR_ESSIE', 	'FLAVOR_HAPPINESS', 				6),
		('LEADER_CBR_ESSIE', 	'FLAVOR_GREAT_PEOPLE', 				8),
		('LEADER_CBR_ESSIE', 	'FLAVOR_WONDER', 					5),
		('LEADER_CBR_ESSIE', 	'FLAVOR_RELIGION', 					6),
		('LEADER_CBR_ESSIE', 	'FLAVOR_DIPLOMACY', 				9),
		('LEADER_CBR_ESSIE', 	'FLAVOR_SPACESHIP', 				4),
		('LEADER_CBR_ESSIE', 	'FLAVOR_WATER_CONNECTION', 			4),
		('LEADER_CBR_ESSIE', 	'FLAVOR_NUKE', 						2),
		('LEADER_CBR_ESSIE', 	'FLAVOR_USE_NUKE', 					2),
		('LEADER_CBR_ESSIE', 	'FLAVOR_ESPIONAGE', 				4),
		('LEADER_CBR_ESSIE', 	'FLAVOR_AIRLIFT', 					3),
		('LEADER_CBR_ESSIE', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
		('LEADER_CBR_ESSIE', 	'FLAVOR_I_TRADE_ORIGIN', 			7),
		('LEADER_CBR_ESSIE', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		4),
		('LEADER_CBR_ESSIE', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		7),
		('LEADER_CBR_ESSIE', 	'FLAVOR_ARCHAEOLOGY', 				5),
		('LEADER_CBR_ESSIE', 	'FLAVOR_AIR_CARRIER', 				5);
--------------------------------
-- Leader_Traits
--------------------------------
INSERT INTO Leader_Traits
		(LeaderType, 			TraitType)
VALUES	('LEADER_CBR_ESSIE',	'TRAIT_CBR_POMO');
--==========================================================================================================================
-- TRAITS
--==========================================================================================================================
-- Traits
--------------------------------
INSERT INTO Traits
		(Type, 					Description, 				ShortDescription)
VALUES	('TRAIT_CBR_POMO',		'TXT_KEY_TRAIT_CBR_POMO', 	'TXT_KEY_TRAIT_CBR_POMO_SHORT');

--==========================================================================================================================
-- CIVILIZATIONS
--==========================================================================================================================
-- Civilizations
--------------------------------
INSERT INTO Civilizations
		(Type, 						DerivativeCiv,	Description, 					ShortDescription, 					Adjective, 							Civilopedia, 						CivilopediaTag, 			DefaultPlayerColor, 		ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, 		  PortraitIndex, 	AlphaIconAtlas, 			SoundtrackTag, 	MapImage, 			DawnOfManQuote, 				  DawnOfManImage)
SELECT	'CIVILIZATION_CBR_POMO',	DerivativeCiv,	'TXT_KEY_CIV_CBR_POMO_DESC',	'TXT_KEY_CIV_CBR_POMO_SHORT_DESC', 	'TXT_KEY_CIV_CBR_POMO_ADJECTIVE',	'TXT_KEY_CIV5_CBR_POMO_TEXT_1', 	'TXT_KEY_CIV5_CBR_POMO',	'PLAYERCOLOR_CBR_POMO', 	ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, 'CBR_POMO_ATLAS', 0, 				'CBR_POMO_ALPHA_ATLAS', 	SoundtrackTag, 	'Pomo_Map.dds', 	'TXT_KEY_CIV5_DOM_CBR_POMO_TEXT', DawnOfManImage
FROM Civilizations WHERE Type = 'CIVILIZATION_IROQUOIS';
--------------------------------
-- Civilization_CityNames
--------------------------------
INSERT INTO Civilization_CityNames
		(CivilizationType, 			CityName)
VALUES	('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_01'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_02'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_03'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_04'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_05'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_06'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_07'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_08'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_09'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_10'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_11'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_12'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_13'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_14'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_15'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_16'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_17'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_18'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_19'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_20'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_21'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_22'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_23'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_24'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_25'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_26'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_27'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_28'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_29'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_30'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_31'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_32'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_33'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_34'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_35'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_36'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_37'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_38'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_39'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_40'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_41'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_42'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_43'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_44'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_CITY_NAME_CBR_POMO_45');


CREATE TABLE IF NOT EXISTS Lime_Pomo_Capitals (CityName TEXT NOT NULL, PRIMARY KEY (CityName));

INSERT INTO Lime_Pomo_Capitals
		(CityName)
VALUES	('TXT_KEY_LIME_CAPITAL_1'),
		('TXT_KEY_LIME_CAPITAL_2'),
		('TXT_KEY_LIME_CAPITAL_3'),
		('TXT_KEY_LIME_CAPITAL_4'),
		('TXT_KEY_LIME_CAPITAL_5'),
		('TXT_KEY_LIME_CAPITAL_6');
--------------------------------
-- Civilization_FreeBuildingClasses
--------------------------------
INSERT INTO Civilization_FreeBuildingClasses
		(CivilizationType, 			BuildingClassType)
SELECT	'CIVILIZATION_CBR_POMO',	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE CivilizationType = 'CIVILIZATION_IROQUOIS';
--------------------------------
-- Civilization_FreeTechs
--------------------------------
INSERT INTO Civilization_FreeTechs
		(CivilizationType, 			TechType)
SELECT	'CIVILIZATION_CBR_POMO',	TechType
FROM Civilization_FreeTechs WHERE CivilizationType = 'CIVILIZATION_IROQUOIS';
--------------------------------
-- Civilization_FreeUnits
--------------------------------
INSERT INTO Civilization_FreeUnits
		(CivilizationType, 						UnitClassType, Count, UnitAIType)
SELECT	'CIVILIZATION_CBR_POMO',	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE CivilizationType = 'CIVILIZATION_IROQUOIS';
--------------------------------
-- Civilization_Leaders
--------------------------------
INSERT INTO Civilization_Leaders
		(CivilizationType, 			LeaderheadType)
VALUES	('CIVILIZATION_CBR_POMO', 	'LEADER_CBR_ESSIE');
--------------------------------
-- Civilization_UnitClassOverrides
--------------------------------
INSERT INTO Civilization_UnitClassOverrides
		(CivilizationType, 			UnitClassType, 			UnitType)
VALUES	('CIVILIZATION_CBR_POMO', 	'UNITCLASS_ARTIST', 	'UNIT_CBR_BASKET_WEAVER');
--------------------------------
-- Civilization_BuildingClassOverrides
--------------------------------
INSERT INTO Civilization_BuildingClassOverrides
		(CivilizationType, 			BuildingClassType, 				BuildingType)
VALUES	('CIVILIZATION_CBR_POMO', 	'BUILDINGCLASS_AMPHITHEATER',	'BUILDING_CBR_DANCE_CAVE'),
		('CIVILIZATION_CBR_POMO', 	'BUILDINGCLASS_AMPHITHEATER',	'BUILDING_CBR_DANCE_CAVE_2'),
		('CIVILIZATION_CBR_POMO', 	'BUILDINGCLASS_ARTISTS_GUILD',	'BUILDING_CBR_POMO_ARTISTS_GUILD');

--------------------------------
-- Civilization_Religions
--------------------------------
INSERT INTO Civilization_Religions
		(CivilizationType, 			ReligionType)
VALUES	('CIVILIZATION_CBR_POMO',	'RELIGION_CONFUCIANISM');
--------------------------------
-- Civilization_SpyNames
--------------------------------
INSERT INTO Civilization_SpyNames
		(CivilizationType, 			SpyName)
VALUES	('CIVILIZATION_CBR_POMO', 	'TXT_KEY_SPY_NAME_CBR_POMO_0'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_SPY_NAME_CBR_POMO_1'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_SPY_NAME_CBR_POMO_2'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_SPY_NAME_CBR_POMO_3'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_SPY_NAME_CBR_POMO_4'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_SPY_NAME_CBR_POMO_5'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_SPY_NAME_CBR_POMO_6'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_SPY_NAME_CBR_POMO_7'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_SPY_NAME_CBR_POMO_8'),
		('CIVILIZATION_CBR_POMO', 	'TXT_KEY_SPY_NAME_CBR_POMO_9');
--==========================================================================================================================
--==========================================================================================================================
