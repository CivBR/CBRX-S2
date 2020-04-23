
/*
UA: Trail 
Units may use enemy Roads, and stationing a Unit on an enemy Road will drain Production from the nearby City and generate +1 Great General Point. Great Generals generate Roads when they move into Jungle, Forest, or Mountains.
UU: Mountain Artillery
Replaces Artillery When starting their turn adjacent to a Great General, both Units Ignore Terrain Cost and may enter Mountains. +50% bonus vs Units.
UB: Karaoke Parlour
Replaces Opera House +2 Happiness, and an extra +1 if the GWM slot is filled. Yields Gold based on Local Happiness generated in the City

Launch the Tet Offensive Must have a Religion Must be at War Costs Culture (and Piety) Enemy Cities take damage and receive Happiness Penalties from Vietnamese Units in their tiles

Establish the Viet Cong Must be at War Costs a Great General Chance for Vietnamese Units to spawn in enemy Forest and Jungle when either you or they capture a City
*/

INSERT INTO IconTextureAtlases
		(Atlas,					IconSize,	FileName,				IconsPerRow,			IconsPerColumn)
VALUES	('ATLAS_C15_HO_ICON',	256,		'C15_HoAtlas_256.dds',	2,						2),
		('ATLAS_C15_HO_ICON',	128,		'C15_HoAtlas_128.dds',	2,						2),
		('ATLAS_C15_HO_ICON',	80,			'C15_HoAtlas_80.dds',	2,						2),
		('ATLAS_C15_HO_ICON',	64,			'C15_HoAtlas_64.dds',	2,						2),
		('ATLAS_C15_HO_ICON',	45,			'C15_HoAtlas_45.dds',	2,						2),
		('ATLAS_C15_HO_ICON',	32,			'C15_HoAtlas_32.dds',	2,						2),
		('ATLAS_C15_HO_ALPHA',	128,		'C15_HoAlpha_128.dds',	1,						1),
		('ATLAS_C15_HO_ALPHA',	80,			'C15_HoAlpha_80.dds',	1,						1),
		('ATLAS_C15_HO_ALPHA',	64,			'C15_HoAlpha_64.dds',	1,						1),
		('ATLAS_C15_HO_ALPHA',	48,			'C15_HoAlpha_48.dds',	1,						1),
		('ATLAS_C15_HO_ALPHA',	45,			'C15_HoAlpha_45.dds',	1,						1),
		('ATLAS_C15_HO_ALPHA',	32,			'C15_HoAlpha_32.dds',	1,						1),
		('ATLAS_C15_HO_ALPHA',	24,			'C15_HoAlpha_24.dds',	1,						1),
		('ATLAS_C15_HO_ALPHA',	16,			'C15_HoAlpha_16.dds',	1,						1),
		('ATLAS_C15_HO_FLAG',	32,			'C15_HoUnitFlag32.dds',	1,						1);


-- Promotions

INSERT INTO UnitPromotions
		(Type,										Description,										Help,													CannotBeChosen,	LostWithUpgrade,	IconAtlas,			PortraitIndex,	PediaType,			PediaEntry)
VALUES	('PROMOTION_C15_HO_MOUNT_ART_UNIT_COMBAT',	'TXT_KEY_PROMOTION_C15_HO_MOUNT_ART_UNIT_COMBAT',	'TXT_KEY_PROMOTION_C15_HO_MOUNT_ART_UNIT_COMBAT_HELP',	1,				1,					'ABILITY_ATLAS',	59,				'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_C15_HO_MOUNT_ART_UNIT_COMBAT'),
		('PROMOTION_C15_HO_MOUNT_ART_MOVEMENT',		'TXT_KEY_PROMOTION_C15_HO_MOUNT_ART_MOVEMENT',		'TXT_KEY_PROMOTION_C15_HO_MOUNT_ART_MOVEMENT_HELP',		1,				1,					'ABILITY_ATLAS',	59,				'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_C15_HO_MOUNT_ART_MOVEMENT'),
		('PROMOTION_C15_HO_ROAD_ENEMY',				'TXT_KEY_PROMOTION_C15_HO_ROAD_ENEMY',				'TXT_KEY_PROMOTION_C15_HO_ROAD_ENEMY_HELP',				1,				0,					'ABILITY_ATLAS',	59,				'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_C15_HO_ROAD_ENEMY');
		
UPDATE UnitPromotions
SET CanMoveImpassable = 1, IgnoreTerrainCost = 1, HoveringUnit = 1
WHERE Type = 'PROMOTION_C15_HO_MOUNT_ART_MOVEMENT';

INSERT INTO UnitPromotions_UnitCombatMods
		(PromotionType,								UnitCombatType,	Modifier)
SELECT	'PROMOTION_C15_HO_MOUNT_ART_UNIT_COMBAT',	Type,			50
FROM UnitCombatInfos;

CREATE TRIGGER IF NOT EXISTS C15_Ho_MountArt_UnitCombatMod
AFTER INSERT ON UnitCombatInfos
BEGIN
	INSERT INTO UnitPromotions_UnitCombatMods
			(PromotionType,								UnitCombatType,		Modifier)
	VALUES	('PROMOTION_C15_HO_MOUNT_ART_UNIT_COMBAT',	NEW.Type,			50);
END;

UPDATE UnitPromotions
SET EnemyRoute = 1
WHERE Type = 'PROMOTION_C15_HO_ROAD_ENEMY';

-- Unit

INSERT INTO Units
		(Type,						Description,						Help,									Strategy,								Civilopedia,							Class,	Combat,		RangedCombat,		Cost,	FaithCost,	RequiresFaithPurchaseEnabled,	Moves,	Range,	Domain,	CombatClass,	DefaultUnitAI,	MilitarySupport,	MilitaryProduction,	Pillage,	PrereqTech,	GoodyHutUpgradeUnitClass,	AdvancedStartCost,	HurryCostModifier,	MinAreaSize,	UnitArtInfo,	MoveRate,	UnitFlagIconOffset,	UnitFlagAtlas,			IconAtlas,				PortraitIndex)
SELECT	'UNIT_C15_HO_MOUNT_ART',	'TXT_KEY_UNIT_C15_HO_MOUNT_ART',	'TXT_KEY_UNIT_C15_HO_MOUNT_ART_HELP',	'TXT_KEY_UNIT_C15_HO_MOUNT_ART_STRAT',	'TXT_KEY_UNIT_C15_HO_MOUNT_ART_PEDIA',	Class,	Combat,		RangedCombat,		Cost,	FaithCost,	RequiresFaithPurchaseEnabled,	Moves,	Range,	Domain,	CombatClass,	DefaultUnitAI,	MilitarySupport,	MilitaryProduction,	Pillage,	PrereqTech,	GoodyHutUpgradeUnitClass,	AdvancedStartCost,	HurryCostModifier,	MinAreaSize,	UnitArtInfo,	MoveRate,	0,					'ATLAS_C15_HO_FLAG',	'ATLAS_C15_HO_ICON',	2
FROM Units WHERE Type = 'UNIT_ARTILLERY';

INSERT INTO Unit_ClassUpgrades
		(UnitType,					UnitClassType)
SELECT	'UNIT_C15_HO_MOUNT_ART',	UnitClassType
FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_ARTILLERY';

INSERT INTO Unit_Flavors
		(UnitType,					FlavorType,		Flavor)
SELECT	'UNIT_C15_HO_MOUNT_ART',	FlavorType,		Flavor + 2
FROM Unit_Flavors WHERE UnitType = 'UNIT_ARTILLERY';

INSERT INTO Unit_FreePromotions
		(UnitType,					PromotionType)
SELECT	'UNIT_C15_HO_MOUNT_ART',	PromotionType
FROM Unit_FreePromotions WHERE UnitType = 'UNIT_ARTILLERY';

INSERT INTO Unit_FreePromotions
		(UnitType,					PromotionType)
VALUES	('UNIT_C15_HO_MOUNT_ART',	'PROMOTION_C15_HO_MOUNT_ART_UNIT_COMBAT');

-- Building

INSERT INTO Buildings
		(Type,						Description,							Help,									Strategy,									Civilopedia,								BuildingClass,	Cost,	Happiness,	GoldMaintenance,	FaithCost,	ConquestProb,	HurryCostModifier,	ArtDefineTag,	PrereqTech,	GreatWorkSlotType,	GreatWorkCount,	PortraitIndex,	IconAtlas)
SELECT	'BUILDING_C15_HO_KARAOKE',	'TXT_KEY_BUILDING_C15_HO_KARAOKE',		'TXT_KEY_BUILDING_C15_HO_KARAOKE_HELP',	'TXT_KEY_BUILDING_C15_HO_KARAOKE_STRAT',	'TXT_KEY_BUILDING_C15_HO_KARAOKE_PEDIA',	BuildingClass,	Cost,	2,			GoldMaintenance,	FaithCost,	ConquestProb,	HurryCostModifier,	ArtDefineTag,	PrereqTech,	GreatWorkSlotType,	GreatWorkCount,	3,	'ATLAS_C15_HO_ICON'
FROM Buildings WHERE Type = 'BUILDING_OPERA_HOUSE';

INSERT INTO Building_Flavors
		(BuildingType,				FlavorType,				Flavor)
SELECT	'BUILDING_C15_HO_KARAOKE',	FlavorType,				Flavor + 2
FROM Building_Flavors WHERE BuildingType = 'BUILDING_OPERA_HOUSE';

INSERT INTO Building_Flavors
		(BuildingType,				FlavorType,				Flavor)
VALUES	('BUILDING_C15_HO_KARAOKE',	'FLAVOR_GOLD',			15);

INSERT INTO Building_YieldChanges
		(BuildingType,				YieldType,	Yield)
SELECT	'BUILDING_C15_HO_KARAOKE',	YieldType,	Yield
FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_OPERA_HOUSE';

INSERT INTO Building_ClassesNeededInCity
		(BuildingType,				BuildingClassType)
SELECT	'BUILDING_C15_HO_KARAOKE',	BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_OPERA_HOUSE';

INSERT INTO BuildingClasses
		(Type,										Description,							DefaultBuilding)
VALUES	('BUILDINGCLASS_C15_HO_KARAOKE_HAPP_DUMMY',	'TXT_KEY_BUILDING_C15_HO_KARAOKE',		'BUILDING_C15_HO_KARAOKE_HAPP_DUMMY'),
		('BUILDINGCLASS_C15_HO_KARAOKE_GOLD_DUMMY',	'TXT_KEY_BUILDING_C15_HO_KARAOKE',		'BUILDING_C15_HO_KARAOKE_GOLD_DUMMY'),
		('BUILDINGCLASS_C15_HO_DECISION_TET_DUMMY',	'TXT_KEY_DECISIONS_C15_NVIET_TET',		'BUILDING_C15_HO_DECISION_TET_DUMMY');

INSERT INTO Buildings
		(Type,									Description,							Cost,	FaithCost,	GreatWorkCount,	PrereqTech,	IconAtlas,		PortraitIndex,	NeverCapture,	NukeImmune,	Happiness,	BuildingClass)
VALUES	('BUILDING_C15_HO_KARAOKE_HAPP_DUMMY',	'TXT_KEY_BUILDING_C15_HO_KARAOKE',		-1,		-1,			-1,				NULL,		'BW_ATLAS_1',	13,				1,				1,			1,			'BUILDINGCLASS_C15_HO_KARAOKE_HAPP_DUMMY'),
		('BUILDING_C15_HO_KARAOKE_GOLD_DUMMY',	'TXT_KEY_BUILDING_C15_HO_KARAOKE',		-1,		-1,			-1,				NULL,		'BW_ATLAS_1',	13,				1,				1,			0,			'BUILDINGCLASS_C15_HO_KARAOKE_GOLD_DUMMY'),
		('BUILDING_C15_HO_DECISION_TET_DUMMY',	'TXT_KEY_DECISIONS_C15_NVIET_TET',		-1,		-1,			-1,				NULL,		'BW_ATLAS_1',	13,				1,				1,			0,			'BUILDINGCLASS_C15_HO_DECISION_TET_DUMMY');

UPDATE Buildings
SET UnhappinessModifier = 1
WHERE Type = 'BUILDING_C15_HO_DECISION_TET_DUMMY';

INSERT INTO Building_YieldChanges
		(BuildingType,							YieldType,		Yield)
VALUES	('BUILDING_C15_HO_KARAOKE_GOLD_DUMMY',	'YIELD_GOLD',	1);	

-- Trait
INSERT INTO Traits
		(Type,						Description,						ShortDescription)
VALUES	('TRAIT_C15_HO',			'TXT_KEY_TRAIT_C15_HO',				'TXT_KEY_TRAIT_C15_HO_SHORT');

-- Leader

INSERT INTO Leaders
		(Type, 						Description, 						Civilopedia, 							CivilopediaTag, 							ArtDefineTag, 									VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 						PortraitIndex)
VALUES	('LEADER_C15_HO',			'TXT_KEY_LEADER_C15_HO',			'TXT_KEY_LEADER_C15_HO_PEDIA',			'TXT_KEY_CIVILOPEDIA_LEADERS_C15_HO',		'C15_UncleHo_LS.xml',							8,						3,						3,							8,			6,				7,				7,						6,				3,			7,			2,				3,			5,			'ATLAS_C15_HO_ICON',			1);

INSERT INTO Leader_MajorCivApproachBiases 
		(LeaderType, 		MajorCivApproachType, 				Bias)
VALUES	('LEADER_C15_HO', 	'MAJOR_CIV_APPROACH_WAR', 			8),
		('LEADER_C15_HO', 	'MAJOR_CIV_APPROACH_HOSTILE', 		4),
		('LEADER_C15_HO', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	7),
		('LEADER_C15_HO', 	'MAJOR_CIV_APPROACH_GUARDED', 		7),
		('LEADER_C15_HO', 	'MAJOR_CIV_APPROACH_AFRAID', 		2),
		('LEADER_C15_HO', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		4),
		('LEADER_C15_HO', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		5);
		
INSERT INTO Leader_MinorCivApproachBiases 
		(LeaderType, 		MinorCivApproachType, 				Bias)
VALUES	('LEADER_C15_HO', 	'MINOR_CIV_APPROACH_IGNORE', 		2),
		('LEADER_C15_HO', 	'MINOR_CIV_APPROACH_FRIENDLY', 		4),
		('LEADER_C15_HO', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	3),
		('LEADER_C15_HO', 	'MINOR_CIV_APPROACH_CONQUEST', 		5),
		('LEADER_C15_HO', 	'MINOR_CIV_APPROACH_BULLY', 		7);
		
INSERT INTO Leader_Flavors 
		(LeaderType, 		FlavorType, 						Flavor)
VALUES	('LEADER_C15_HO', 	'FLAVOR_OFFENSE', 					8),
		('LEADER_C15_HO', 	'FLAVOR_DEFENSE', 					8),
		('LEADER_C15_HO', 	'FLAVOR_CITY_DEFENSE', 				8),
		('LEADER_C15_HO', 	'FLAVOR_MILITARY_TRAINING', 		7),
		('LEADER_C15_HO', 	'FLAVOR_RECON', 					7),
		('LEADER_C15_HO', 	'FLAVOR_RANGED', 					8),
		('LEADER_C15_HO', 	'FLAVOR_MOBILE', 					2),
		('LEADER_C15_HO', 	'FLAVOR_NAVAL', 					3),
		('LEADER_C15_HO', 	'FLAVOR_NAVAL_RECON', 				3),
		('LEADER_C15_HO', 	'FLAVOR_NAVAL_GROWTH', 				8),
		('LEADER_C15_HO', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	8),
		('LEADER_C15_HO', 	'FLAVOR_AIR', 						2),
		('LEADER_C15_HO', 	'FLAVOR_EXPANSION', 				6),
		('LEADER_C15_HO', 	'FLAVOR_GROWTH', 					6),
		('LEADER_C15_HO', 	'FLAVOR_TILE_IMPROVEMENT', 			4),
		('LEADER_C15_HO', 	'FLAVOR_INFRASTRUCTURE', 			10),
		('LEADER_C15_HO', 	'FLAVOR_PRODUCTION', 				9),
		('LEADER_C15_HO', 	'FLAVOR_GOLD', 						6),
		('LEADER_C15_HO', 	'FLAVOR_SCIENCE', 					5),
		('LEADER_C15_HO', 	'FLAVOR_CULTURE', 					7),
		('LEADER_C15_HO', 	'FLAVOR_HAPPINESS', 				7),
		('LEADER_C15_HO', 	'FLAVOR_GREAT_PEOPLE', 				3),
		('LEADER_C15_HO', 	'FLAVOR_WONDER', 					2),
		('LEADER_C15_HO', 	'FLAVOR_RELIGION', 					2),
		('LEADER_C15_HO', 	'FLAVOR_DIPLOMACY', 				5),
		('LEADER_C15_HO', 	'FLAVOR_SPACESHIP', 				2),
		('LEADER_C15_HO', 	'FLAVOR_WATER_CONNECTION', 			4),
		('LEADER_C15_HO', 	'FLAVOR_NUKE', 						2),
		('LEADER_C15_HO', 	'FLAVOR_USE_NUKE', 					2),
		('LEADER_C15_HO', 	'FLAVOR_ESPIONAGE', 				8),
		('LEADER_C15_HO', 	'FLAVOR_AIRLIFT', 					2),
		('LEADER_C15_HO', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
		('LEADER_C15_HO', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
		('LEADER_C15_HO', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
		('LEADER_C15_HO', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
		('LEADER_C15_HO', 	'FLAVOR_ARCHAEOLOGY', 				5),
		('LEADER_C15_HO', 	'FLAVOR_AIR_CARRIER', 				5);
		
INSERT INTO Leader_Traits
		(LeaderType,		TraitType)
VALUES	('LEADER_C15_HO',	'TRAIT_C15_HO');

-- Civ

INSERT INTO Civilizations
		(Type,							Description,				ShortDescription,				Adjective,						CivilopediaTag,					DefaultPlayerColor,			ArtDefineTag,	ArtStyleType,			ArtStyleSuffix,	ArtStylePrefix,	PortraitIndex,	IconAtlas,						AlphaIconAtlas,					MapImage,			DawnOfManQuote,					DawnOfManImage)
SELECT	'CIVILIZATION_C15_NVIET',		'TXT_KEY_CIV_C15_NVIET',	'TXT_KEY_CIV_C15_NVIET_SHORT',	'TXT_KEY_CIV_C15_NVIET_ADJ',	'TXT_KEY_CIV_C15_NVIET_PEDIA',	'PLAYERCOLOR_C15_NVIET',	ArtDefineTag,	ArtStyleType,			ArtStyleSuffix,	ArtStylePrefix,	0,				'ATLAS_C15_HO_ICON',			'ATLAS_C15_HO_ALPHA',			'HoChiMinhMap.dds',	'TXT_KEY_DOM_C15_HCM',			'C15_DOM_VietnamHo.dds'
FROM Civilizations WHERE Type = 'CIVILIZATION_SIAM';

INSERT INTO Civilization_FreeBuildingClasses
		(CivilizationType,				BuildingClassType)
SELECT	'CIVILIZATION_C15_NVIET',		BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE CivilizationType = 'CIVILIZATION_SIAM';

INSERT INTO Civilization_FreeTechs
		(CivilizationType,				TechType)
SELECT	'CIVILIZATION_C15_NVIET',		TechType
FROM Civilization_FreeTechs WHERE CivilizationType = 'CIVILIZATION_SIAM';

INSERT INTO Civilization_FreeUnits
		(CivilizationType,				UnitClassType,	Count,	UnitAIType)
SELECT	'CIVILIZATION_C15_NVIET',		UnitClassType,	Count,	UnitAIType
FROM Civilization_FreeUnits WHERE CivilizationType = 'CIVILIZATION_SIAM';

INSERT INTO Civilization_Leaders
		(CivilizationType,			LeaderheadType)
VALUES	('CIVILIZATION_C15_NVIET',	'LEADER_C15_HO');

INSERT INTO Civilization_Religions
		(CivilizationType,				ReligionType)
SELECT	'CIVILIZATION_C15_NVIET',		ReligionType
FROM Civilization_Religions WHERE CivilizationType = 'CIVILIZATION_SIAM';

INSERT INTO Civilization_SpyNames
		(CivilizationType,				SpyName)
VALUES	('CIVILIZATION_C15_NVIET',		'TXT_KEY_SPY_NAME_C15_NVIET_0'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_SPY_NAME_C15_NVIET_1'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_SPY_NAME_C15_NVIET_2'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_SPY_NAME_C15_NVIET_3'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_SPY_NAME_C15_NVIET_4'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_SPY_NAME_C15_NVIET_5'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_SPY_NAME_C15_NVIET_6'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_SPY_NAME_C15_NVIET_7'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_SPY_NAME_C15_NVIET_8'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_SPY_NAME_C15_NVIET_9');
		
INSERT INTO Civilization_Start_Region_Priority
		(CivilizationType,			RegionType)
VALUES	('CIVILIZATION_C15_NVIET',	'REGION_JUNGLE');

INSERT INTO Colors
			(Type, 											Red, 	Green, 	Blue, 	Alpha)
VALUES		('COLOR_PLAYER_C15_NVIET_ICON', 					0.949,	0.663,	0.255,		1),
			('COLOR_PLAYER_C15_NVIET_BACKGROUND', 				0.498,	0.11,	0.153,		1);

INSERT INTO PlayerColors
			(Type, 							PrimaryColor, 						SecondaryColor, 							TextColor)
VALUES		('PLAYERCOLOR_C15_NVIET',			'COLOR_PLAYER_C15_NVIET_ICON', 			'COLOR_PLAYER_C15_NVIET_BACKGROUND', 		'COLOR_PLAYER_WHITE_TEXT');

INSERT INTO Civilization_UnitClassOverrides
		(CivilizationType,				UnitClassType,	UnitType)
SELECT	'CIVILIZATION_C15_NVIET',		Class,			Type
FROM Units WHERE Type = 'UNIT_C15_HO_MOUNT_ART';

INSERT INTO Civilization_BuildingClassOverrides
		(CivilizationType,				BuildingClassType,	BuildingType)
SELECT	'CIVILIZATION_C15_NVIET',		BuildingClass,		Type
FROM Buildings WHERE Type = 'BUILDING_C15_HO_KARAOKE';

INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_C15_HO','RESPONSE_FIRST_GREETING',	'TXT_KEY_LEADER_C15_HO_FIRSTGREETING%','500');
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_C15_HO','RESPONSE_DEFEATED',	'TXT_KEY_LEADER_C15_HO_DEFEATED%','500');


UPDATE MinorCivilizations
SET Description = 'TXT_KEY_CITYSTATE_C15_PHNOM_PENH', ShortDescription = 'TXT_KEY_CITYSTATE_C15_PHNOM_PENH_SHORTDESC', Civilopedia = 'TXT_KEY_CITYSTATE_C15_PHNOM_PENH_TEXT', Adjective = 'TXT_KEY_CITYSTATE_C15_PHNOM_PENH_ADJ'
WHERE Type = 'MINOR_CIV_HANOI';

INSERT INTO Civilization_CityNames
		(CivilizationType,				CityName)
VALUES	('CIVILIZATION_C15_NVIET',		'TXT_KEY_CITY_NAME_HANOI'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_CITY_C15_NVIET_SAIGON'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_CITY_C15_NVIET_HAI_PHONG'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_CITY_C15_NVIET_DA_NANG'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_CITY_C15_NVIET_CAN_THO'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_CITY_C15_NVIET_BIEN_HOA'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_CITY_C15_NVIET_NHA_TRANG'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_CITY_C15_NVIET_VINH'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_CITY_C15_NVIET_HAI_DUONG'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_CITY_C15_NVIET_HUE'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_CITY_C15_NVIET_DA_LAT'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_CITY_C15_NVIET_BUON_MA_THUOT'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_CITY_C15_NVIET_THAI_NGUYEN'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_CITY_C15_NVIET_VUNG_TAU'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_CITY_C15_NVIET_QUY_NHON'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_CITY_C15_NVIET_LONG_XUYEN'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_CITY_C15_NVIET_VIET_TRI'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_CITY_C15_NVIET_BAC_NING'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_CITY_C15_NVIET_THU_DAU_MOT'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_CITY_C15_NVIET_THAI_BINH'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_CITY_C15_NVIET_PHAN_THIET'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_CITY_C15_NVIET_RACH_GIA'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_CITY_C15_NVIET_TAM_KY'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_CITY_C15_NVIET_MY_THO'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_CITY_C15_NVIET_CA_MAU'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_CITY_C15_NVIET_HA_LONG'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_CITY_C15_NVIET_THANH_HOA'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_CITY_C15_NVIET_CAM_PHA'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_CITY_C15_NVIET_NAM_DINH'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_CITY_C15_NVIET_BAC_LIUE'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_CITY_C15_NVIET_PLEIKU'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_CITY_C15_NVIET_SOC_TRANG'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_CITY_C15_NVIET_TUY_HOA'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_CITY_C15_NVIET_TAN_AN'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_CITY_C15_NVIET_DONG_HOI'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_CITY_C15_NVIET_SAM_SON'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_CITY_C15_NVIET_LANG_SON'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_CITY_C15_NVIET_VINH_LONG'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_CITY_C15_NVIET_HOI_AN'),
		('CIVILIZATION_C15_NVIET',		'TXT_KEY_CITY_C15_NVIET_SON_LA');

/* CITY LIST
1. Hanoi
2. Saigon
3. Hai Phong
4. Da Nang
5. Can Tho
6. Bien Hoa
7. Nha Trang
8. Vinh
9. Hai Duong
10. Hue
11. Da Lat
12. Buon Ma Thuot
13. Thai Nguyen
14. Vung Tau
15. Quy Nhon
16. Long Xuyen
17. Viet Tri
18. Bac Ning
19. Thu Dau Mot
20. Thai Binh
21. Phan Thiet
22. Rach Gia
23. Tam Ky
24. My Tho
25. Ca Mau
26. Ha Long
27. Thanh Hoa
28. Cam Pha
29. Nam Dinh
30. Bac Liue
31. Pleiku
32. Soc Trang
33. Tuy Hoa
34. Tan An
35. Dong Hoi
36. Sam Son
37. Lang Son
38. Vinh Long
39. Hoi An
40. Son La*/