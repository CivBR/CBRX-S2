-------
--PA-RG
-------

--Leader

INSERT INTO Leaders
		(Type, 					Description, 					Civilopedia, 						CivilopediaTag, 							ArtDefineTag, 			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate,	WorkAgainstWillingness,	WorkWithWillingness,	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 		PortraitIndex)
VALUES	('LEADER_EW_KOLCHAK',	'TXT_KEY_LEADER_EW_KOLCHAK',	'TXT_KEY_LEADER_EW_KOLCHAK_PEDIA',	'TXT_KEY_CIVILOPEDIA_LEADER_EW_KOLCHAK',	'Kolchak_scene.xml',	8,	2,	3,	7,	4,	6,	4,	4,	4,	6,	4,	5,	3,	3,	4,	'ATLAS_EW_KOLCHAK',	0);

-----

INSERT INTO Leader_MajorCivApproachBiases
		(LeaderType,	MajorCivApproachType,	Bias)
VALUES	('LEADER_EW_KOLCHAK',	'MAJOR_CIV_APPROACH_WAR',	6),
		('LEADER_EW_KOLCHAK',	'MAJOR_CIV_APPROACH_HOSTILE',	4),
		('LEADER_EW_KOLCHAK',	'MAJOR_CIV_APPROACH_DECEPTIVE',	3),
		('LEADER_EW_KOLCHAK',	'MAJOR_CIV_APPROACH_GUARDED',	3),
		('LEADER_EW_KOLCHAK',	'MAJOR_CIV_APPROACH_AFRAID',	2),
		('LEADER_EW_KOLCHAK',	'MAJOR_CIV_APPROACH_FRIENDLY',	5),
		('LEADER_EW_KOLCHAK',	'MAJOR_CIV_APPROACH_NEUTRAL',	3);
		
-----

INSERT INTO Leader_MinorCivApproachBiases
		(LeaderType,	MinorCivApproachType,	Bias)
VALUES	('LEADER_EW_KOLCHAK',	'MINOR_CIV_APPROACH_IGNORE',	5),
		('LEADER_EW_KOLCHAK',	'MINOR_CIV_APPROACH_FRIENDLY',	3),
		('LEADER_EW_KOLCHAK',	'MINOR_CIV_APPROACH_PROTECTIVE',	2),
		('LEADER_EW_KOLCHAK',	'MINOR_CIV_APPROACH_CONQUEST',	6),
		('LEADER_EW_KOLCHAK',	'MINOR_CIV_APPROACH_BULLY',	4);
		
-----

INSERT INTO Leader_Flavors
		(LeaderType,	FlavorType,	Flavor)
VALUES	('LEADER_EW_KOLCHAK',	'FLAVOR_OFFENSE',	8),
		('LEADER_EW_KOLCHAK',	'FLAVOR_DEFENSE',	7),
		('LEADER_EW_KOLCHAK',	'FLAVOR_CITY_DEFENSE',	3),
		('LEADER_EW_KOLCHAK',	'FLAVOR_MILITARY_TRAINING',	7),
		('LEADER_EW_KOLCHAK',	'FLAVOR_RECON',	3),
		('LEADER_EW_KOLCHAK',	'FLAVOR_RANGED',	4),
		('LEADER_EW_KOLCHAK',	'FLAVOR_MOBILE',	4),
		('LEADER_EW_KOLCHAK',	'FLAVOR_NAVAL',	4),
		('LEADER_EW_KOLCHAK',	'FLAVOR_NAVAL_RECON',	2),
		('LEADER_EW_KOLCHAK',	'FLAVOR_NAVAL_GROWTH',	6),
		('LEADER_EW_KOLCHAK',	'FLAVOR_NAVAL_TILE_IMPROVEMENT',	5),
		('LEADER_EW_KOLCHAK',	'FLAVOR_AIR',	3),
		('LEADER_EW_KOLCHAK',	'FLAVOR_EXPANSION',	8),
		('LEADER_EW_KOLCHAK',	'FLAVOR_GROWTH',	3),
		('LEADER_EW_KOLCHAK',	'FLAVOR_TILE_IMPROVEMENT',	5),
		('LEADER_EW_KOLCHAK',	'FLAVOR_INFRASTRUCTURE',	3),
		('LEADER_EW_KOLCHAK',	'FLAVOR_PRODUCTION',	5),
		('LEADER_EW_KOLCHAK',	'FLAVOR_GOLD',	3),
		('LEADER_EW_KOLCHAK',	'FLAVOR_SCIENCE',	4),
		('LEADER_EW_KOLCHAK',	'FLAVOR_CULTURE',	3),
		('LEADER_EW_KOLCHAK',	'FLAVOR_HAPPINESS',	2),
		('LEADER_EW_KOLCHAK',	'FLAVOR_GREAT_PEOPLE',	3),
		('LEADER_EW_KOLCHAK',	'FLAVOR_WONDER',	2),
		('LEADER_EW_KOLCHAK',	'FLAVOR_RELIGION',	2),
		('LEADER_EW_KOLCHAK',	'FLAVOR_DIPLOMACY',	4),
		('LEADER_EW_KOLCHAK',	'FLAVOR_SPACESHIP',	5),
		('LEADER_EW_KOLCHAK',	'FLAVOR_WATER_CONNECTION',	5),
		('LEADER_EW_KOLCHAK',	'FLAVOR_NUKE',	5),
		('LEADER_EW_KOLCHAK',	'FLAVOR_USE_NUKE',	7),
		('LEADER_EW_KOLCHAK',	'FLAVOR_ESPIONAGE',	5),
		('LEADER_EW_KOLCHAK',	'FLAVOR_AIRLIFT',	5),
		('LEADER_EW_KOLCHAK',	'FLAVOR_I_TRADE_DESTINATION',	5),
		('LEADER_EW_KOLCHAK',	'FLAVOR_I_TRADE_ORIGIN',	5),
		('LEADER_EW_KOLCHAK',	'FLAVOR_I_SEA_TRADE_ROUTE',	5),
		('LEADER_EW_KOLCHAK',	'FLAVOR_I_LAND_TRADE_ROUTE',	5),
		('LEADER_EW_KOLCHAK',	'FLAVOR_ARCHAEOLOGY',	5),
		('LEADER_EW_KOLCHAK',	'FLAVOR_AIR_CARRIER',	4);
		
--Trait

INSERT INTO Traits
		(Type,	Description,	ShortDescription)
VALUES	('TRAIT_EW_TSRR',	'TXT_KEY_TRAIT_EW_TSRR',	'TXT_KEY_TRAIT_EW_TSRR_SHORT');

-----

INSERT INTO Leader_Traits
		(LeaderType,	TraitType)
VALUES	('LEADER_EW_KOLCHAK',	'TRAIT_EW_TSRR');

--Civilization

INSERT INTO Civilizations
		(Type,						Description,						ShortDescription,							Adjective,	CivilopediaTag,							DefaultPlayerColor,			ArtDefineTag,						ArtStyleType,		ArtStyleSuffix,	ArtStylePrefix,	IconAtlas,					PortraitIndex,	AlphaIconAtlas,				MapImage,					DawnOfManQuote,					DawnOfManImage)
VALUES	('CIVILIZATION_EW_PARG',	'TXT_KEY_CIVILIZATION_EW_PARG',	'TXT_KEY_CIVILIZATION_EW_PARG_SHORT',		'TXT_KEY_CIVILIZATION_EW_PARG_ADJ',		'TXT_KEY_CIVILIZATION_EW_PARG_PEDIA',	'PLAYERCOLOR_EW_PARG',	'ART_DEF_CIVILIZATION_EW_PARG',	'ARTSTYLE_EUROPEAN',	'_EURO',			'EUROPEAN',		'EW_PARG_ATLAS',	0,				'EW_PARG_ALPHA',	'kolchakMap.dds',	'TXT_KEY_CIVILIZATION_EW_PARG_DOM',	'KolchakDOM.dds');

-----

INSERT INTO Civilization_CityNames
		(CivilizationType,			CityName)
VALUES	('CIVILIZATION_EW_PARG', 'TXT_KEY_EW_PARG_CITY_1'),
		('CIVILIZATION_EW_PARG', 'TXT_KEY_EW_PARG_CITY_2'),
		('CIVILIZATION_EW_PARG', 'TXT_KEY_EW_PARG_CITY_3'),
		('CIVILIZATION_EW_PARG', 'TXT_KEY_EW_PARG_CITY_4'),
		('CIVILIZATION_EW_PARG', 'TXT_KEY_EW_PARG_CITY_5'),
		('CIVILIZATION_EW_PARG', 'TXT_KEY_EW_PARG_CITY_6'),
		('CIVILIZATION_EW_PARG', 'TXT_KEY_EW_PARG_CITY_7'),
		('CIVILIZATION_EW_PARG', 'TXT_KEY_EW_PARG_CITY_8'),
		('CIVILIZATION_EW_PARG', 'TXT_KEY_EW_PARG_CITY_9'),
		('CIVILIZATION_EW_PARG', 'TXT_KEY_EW_PARG_CITY_10'),
		('CIVILIZATION_EW_PARG', 'TXT_KEY_EW_PARG_CITY_11'),
		('CIVILIZATION_EW_PARG', 'TXT_KEY_EW_PARG_CITY_12'),
		('CIVILIZATION_EW_PARG', 'TXT_KEY_EW_PARG_CITY_13'),
		('CIVILIZATION_EW_PARG', 'TXT_KEY_EW_PARG_CITY_14'),
		('CIVILIZATION_EW_PARG', 'TXT_KEY_EW_PARG_CITY_15'),
		('CIVILIZATION_EW_PARG', 'TXT_KEY_EW_PARG_CITY_16'),
		('CIVILIZATION_EW_PARG', 'TXT_KEY_EW_PARG_CITY_17'),
		('CIVILIZATION_EW_PARG', 'TXT_KEY_EW_PARG_CITY_18'),
		('CIVILIZATION_EW_PARG', 'TXT_KEY_EW_PARG_CITY_19'),
		('CIVILIZATION_EW_PARG', 'TXT_KEY_EW_PARG_CITY_20'),
		('CIVILIZATION_EW_PARG', 'TXT_KEY_EW_PARG_CITY_21'),
		('CIVILIZATION_EW_PARG', 'TXT_KEY_EW_PARG_CITY_22'),
		('CIVILIZATION_EW_PARG', 'TXT_KEY_EW_PARG_CITY_23'),
		('CIVILIZATION_EW_PARG', 'TXT_KEY_EW_PARG_CITY_24'),
		('CIVILIZATION_EW_PARG', 'TXT_KEY_EW_PARG_CITY_25'),
		('CIVILIZATION_EW_PARG', 'TXT_KEY_EW_PARG_CITY_26'),
		('CIVILIZATION_EW_PARG', 'TXT_KEY_EW_PARG_CITY_27'),
		('CIVILIZATION_EW_PARG', 'TXT_KEY_EW_PARG_CITY_28'),
		('CIVILIZATION_EW_PARG', 'TXT_KEY_EW_PARG_CITY_29'),
		('CIVILIZATION_EW_PARG', 'TXT_KEY_EW_PARG_CITY_30'),
		('CIVILIZATION_EW_PARG', 'TXT_KEY_EW_PARG_CITY_31'),
		('CIVILIZATION_EW_PARG', 'TXT_KEY_EW_PARG_CITY_32');
		
--Bronepoezd
INSERT INTO Units 
		(Type,					Description,					Civilopedia,						Strategy,								Help,								Combat,	Cost,	FaithCost,	RequiresFaithPurchaseEnabled,	Moves,	BaseSightRange,	Class,	Special,	Domain,	CivilianAttackPriority,	DefaultUnitAI,	AdvancedStartCost,	WorkRate,	BaseGold,	NumGoldPerEra,	UnitArtInfo,					ShowInPedia,	MoveRate,	UnitFlagIconOffset,	PortraitIndex,	IconAtlas,			UnitFlagAtlas,			PrereqTech,	ObsoleteTech,	Trade,	Immobile,	NoMaintenance,	RangedCombat,	Range,	CombatClass)
SELECT	'UNIT_EW_BRONEPOEZD',	'TXT_KEY_UNIT_EW_BRONEPOEZD',	'TXT_KEY_UNIT_EW_BRONEPOEZD_PEDIA',	'TXT_KEY_UNIT_EW_BRONEPOEZD_STRATEGY',	'TXT_KEY_UNIT_EW_BRONEPOEZD_HELP',	Combat,	Cost,	FaithCost,	RequiresFaithPurchaseEnabled,	1,		BaseSightRange,	Class,	Special,	Domain,	CivilianAttackPriority, DefaultUnitAI,	AdvancedStartCost,	100,		BaseGold,	NumGoldPerEra,	'ART_DEF_UNIT_EW_BRONEPOEZD',	ShowInPedia,	MoveRate,	0,					2,				'ATLAS_EW_KOLCHAK',	'EW_BRONEPOEZD_ALPHA',	PrereqTech,	ObsoleteTech,	Trade,	Immobile,	NoMaintenance, 	50,				2,		'UNITCOMBAT_ARCHER'
FROM Units WHERE (Type = 'UNIT_WWI_TANK');
		
-----
INSERT INTO Unit_Flavors
		(UnitType,	FlavorType,	Flavor)
SELECT	('UNIT_EW_BRONEPOEZD'),	FlavorType,	Flavor + 5
FROM Unit_Flavors WHERE (UnitType = 'UNIT_WWI_TANK');

-----
INSERT INTO UnitGameplay2DScripts
		(UnitType,	SelectionSound,	FirstSelectionSound)
SELECT	('UNIT_EW_BRONEPOEZD'),	SelectionSound,	FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_WWI_TANK');

-----
INSERT INTO Unit_ClassUpgrades
		(UnitType,	UnitClassType)
SELECT	('UNIT_EW_BRONEPOEZD'),	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_WWI_TANK');

-----
INSERT INTO Unit_Builds
		(UnitType,	BuildType)
VALUES	('UNIT_EW_BRONEPOEZD',	'BUILD_RAILROAD');
-----
INSERT INTO Unit_FreePromotions
		(UnitType,						PromotionType)
VALUES	('UNIT_EW_BRONEPOEZD',			'PROMOTION_ONLY_DEFENSIVE');		
-----
INSERT INTO Unit_AITypes
		(UnitType,				UnitAIType)
VALUES	('UNIT_EW_BRONEPOEZD',	'UNITAI_FAST_ATTACK'),
		('UNIT_EW_BRONEPOEZD',	'UNITAI_RANGED'),
		('UNIT_EW_BRONEPOEZD',	'UNITAI_DEFENSE');

--Legione Redenta

INSERT INTO UnitClasses
		(Type,	Description,	DefaultUnit)
VALUES	('UNITCLASS_EW_LEGIONE',	'TXT_KEY_UNIT_EW_LEGIONE',	'UNIT_GREAT_WAR_INFANTRY');

-----

INSERT INTO Units
		(Type,	Description,	Civilopedia,	Strategy,	Help,	Combat,	Cost,	FaithCost,	RequiresFaithPurchaseEnabled,	Moves,	BaseSightRange,	Class,	Special,	Domain,	CivilianAttackPriority,	DefaultUnitAI,	AdvancedStartCost,	WorkRate,	BaseGold,	NumGoldPerEra,	UnitArtInfo,	ShowInPedia,	MoveRate,	UnitFlagIconOffset,	PortraitIndex,	IconAtlas,	UnitFlagAtlas,	PrereqTech,	ObsoleteTech,	Trade,	Immobile,	NoMaintenance)
SELECT	'UNIT_EW_LEGIONE',	'TXT_KEY_UNIT_EW_LEGIONE',	'PEDIA_EW_LEGIONE',	'TXT_KEY_UNIT_EW_LEGIONE_STRATEGY',	'TXT_KEY_UNIT_EW_LEGIONE_HELP',	Combat + 5,	Cost - 40,	FaithCost,	RequiresFaithPurchaseEnabled,	Moves,	BaseSightRange,	'UNITCLASS_EW_LEGIONE',	Special,	Domain,	CivilianAttackPriority,	DefaultUnitAI,	AdvancedStartCost,	WorkRate,	BaseGold,	NumGoldPerEra,	'ART_DEF_UNIT_EW_LEGIONE',	ShowInPedia,	MoveRate,	0,	1,	('ATLAS_EW_KOLCHAK'),	('ALPHA_EW_LEGIONE'),	PrereqTech,	ObsoleteTech,	Trade,	Immobile,	NoMaintenance
FROM Units WHERE (Type = 'UNIT_GREAT_WAR_INFANTRY');

-----

INSERT INTO Unit_Flavors
		(UnitType,	FlavorType,	Flavor)
SELECT	('UNIT_EW_LEGIONE'),	FlavorType,	Flavor + 5
FROM Unit_Flavors WHERE (UnitType = 'UNIT_GREAT_WAR_INFANTRY');

-----

INSERT INTO UnitGameplay2DScripts
		(UnitType,	SelectionSound,	FirstSelectionSound)
SELECT	('UNIT_EW_LEGIONE'),	SelectionSound,	FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_GREAT_WAR_INFANTRY');

-----

INSERT INTO Unit_ClassUpgrades
		(UnitType,	UnitClassType)
SELECT	('UNIT_EW_LEGIONE'),	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_GREAT_WAR_INFANTRY');

-----

INSERT INTO Unit_FreePromotions
		(UnitType,	PromotionType)
SELECT	('UNIT_EW_LEGIONE'),	PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_FRENCH_FOREIGNLEGION');

INSERT INTO Unit_FreePromotions
		(UnitType,	PromotionType)
VALUES	('UNIT_EW_LEGIONE',	'PROMOTION_SAPPER');

--Defines

INSERT INTO Civilization_FreeBuildingClasses
		(CivilizationType,			BuildingClassType)
VALUES	('CIVILIZATION_EW_PARG',	'BUILDINGCLASS_PALACE');

-----

INSERT INTO Civilization_FreeTechs
		(CivilizationType,			TechType)
VALUES	('CIVILIZATION_EW_PARG',	'TECH_AGRICULTURE');

-----

INSERT INTO	Civilization_FreeUnits
		(CivilizationType,			UnitClassType,			UnitAIType,	Count)
VALUES	('CIVILIZATION_EW_PARG',	'UNITCLASS_SETTLER',	'UNITAI_SETTLE',	1);

-----

INSERT INTO Civilization_Leaders
		(CivilizationType, 			LeaderheadType)
VALUES	('CIVILIZATION_EW_PARG',	'LEADER_EW_KOLCHAK');
	
-----
		
INSERT INTO Civilization_UnitClassOverrides
		(CivilizationType,			UnitClassType, 		UnitType)
VALUES	('CIVILIZATION_EW_PARG',	'UNITCLASS_WWI_TANK',	'UNIT_EW_BRONEPOEZD'),
		('CIVILIZATION_EW_PARG',	'UNITCLASS_EW_LEGIONE',	'UNIT_EW_LEGIONE');

-----
-----

INSERT INTO Civilization_SpyNames
		(CivilizationType,			SpyName)
VALUES	('CIVILIZATION_EW_PARG',	'TXT_KEY_EW_PARG_SPY_1'),
		('CIVILIZATION_EW_PARG',	'TXT_KEY_EW_PARG_SPY_2'),
		('CIVILIZATION_EW_PARG',	'TXT_KEY_EW_PARG_SPY_3'),
		('CIVILIZATION_EW_PARG',	'TXT_KEY_EW_PARG_SPY_4'),
		('CIVILIZATION_EW_PARG',	'TXT_KEY_EW_PARG_SPY_5'),
		('CIVILIZATION_EW_PARG',	'TXT_KEY_EW_PARG_SPY_6'),
		('CIVILIZATION_EW_PARG',	'TXT_KEY_EW_PARG_SPY_7'),
		('CIVILIZATION_EW_PARG',	'TXT_KEY_EW_PARG_SPY_8'),
		('CIVILIZATION_EW_PARG',	'TXT_KEY_EW_PARG_SPY_9');

-----

INSERT INTO Civilization_Start_Region_Priority
		(CivilizationType,	RegionType)
VALUES	('CIVILIZATION_EW_PARG',	'REGION_TUNDRA');

-----

INSERT INTO UnitPromotions
		(Type,							Description,						Help,										IconAtlas,			CannotBeChosen, PortraitIndex,	Sound,				PediaType,			PediaEntry)
VALUES	('PROMOTION_EW_PARGFOREIGN',	'TXT_KEY_PROMOTION_EW_PARGFOREIGN',	'TXT_KEY_PROMOTION_EW_PARGFOREIGN_HELP',	'ABILITY_ATLAS',	1, 				58,				'AS2D_IF_LEVELUP',	'PEDIA_ATTRIBUTES',	'TXT_KEY_EW_PARGFOREIGN_HELP');

INSERT INTO UnitPromotions
		(Type, 							Description,						Help,										IconAtlas, 			PortraitIndex, 	Sound, 				RangeChange, 	CannotBeChosen)
VALUES 	('PROMOTION_LIME_DUMMY_MELEE', 'TXT_KEY_PROMOTION_LIME_PARG_MELEE',	'TXT_KEY_PROMOTION_LIME_PARG_MELEE_HELP',	'ABILITY_ATLAS',	58,				'AS2D_IF_LEVELUP',	-2, 					1),
		('PROMOTION_LIME_DUMMY_STOP', 	'TXT_KEY_PROMOTION_LIME_PARG_STOP',	'TXT_KEY_PROMOTION_LIME_PARG_STOP_HELP',	'ABILITY_ATLAS',	58,				'AS2D_IF_LEVELUP',	0, 						1);

INSERT INTO UnitPromotions_Terrains
		(PromotionType, 				TerrainType, 	Impassable)
SELECT 	'PROMOTION_LIME_DUMMY_STOP', 	t.Type, 		1
FROM Terrains t;

INSERT INTO UnitPromotions_Features
		(PromotionType, 				FeatureType, 	Impassable)
SELECT 	'PROMOTION_LIME_DUMMY_STOP', f.Type, 			1
FROM Features f;