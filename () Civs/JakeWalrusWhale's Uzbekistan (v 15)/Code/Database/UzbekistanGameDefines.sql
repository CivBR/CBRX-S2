-------------------------------------------
--Building (Sug'orish Kanali)
-------------------------------------------
INSERT INTO Buildings
		(Type,								Description,							Civilopedia,										Strategy,											Help,											MutuallyExclusiveGroup,	Cost,	River,	MinAreaSize,	BuildingClass,					ArtDefineTag,							PrereqTech,				PortraitIndex,	WonderSplashAnchor,	IconAtlas)
VALUES	('BUILDING_JWW_SUGORISH_KANALI',	'TXT_KEY_BUILDING_JWW_SUGORISH_KANALI',	'TXT_KEY_CIV5_BUILDINGS_JWW_SUGORISH_KANALI_TEXT',	'TXT_KEY_BUILDING_JWW_SUGORISH_KANALI_STRATEGY',	'TXT_KEY_BUILDING_JWW_SUGORISH_KANALI_HELP',	-1,						360,	0,		-1,				'BUILDINGCLASS_HYDRO_PLANT',	'ART_DEF_BUILDING_HYDRO_PLANT',			'TECH_ELECTRICITY',		4,				'R,T',				'JWW_UZBEK_COLOR_ATLAS');

INSERT INTO	Building_Flavors
		(BuildingType,						FlavorType,				Flavor)
VALUES	('BUILDING_JWW_SUGORISH_KANALI',	'FLAVOR_GROWTH',		10),
		('BUILDING_JWW_SUGORISH_KANALI',	'FLAVOR_PRODUCTION',	70);

INSERT INTO Building_RiverPlotYieldChanges
		(BuildingType,						YieldType,			Yield)
VALUES	('BUILDING_JWW_SUGORISH_KANALI',	'YIELD_PRODUCTION',	1);

INSERT INTO BuildingClasses
		(Type, 											DefaultBuilding, 								Description)
VALUES	('BUILDINGCLASS_JWW_UZBEK_UA_DUMMY', 			'BUILDING_JWW_UZBEK_UA_DUMMY', 					'TXT_KEY_BUILDING_JWW_UZBEK_UA_DUMMY'),
		('BUILDINGCLASS_JWW_KANALI_PROD_DUMMY', 		'BUILDING_JWW_KANALI_PROD_DUMMY', 				'TXT_KEY_BUILDING_JWW_KANALI_PROD_DUMMY'),
		('BUILDINGCLASS_JWW_KANALI_FOOD_DUMMY', 		'BUILDING_JWW_KANALI_FOOD_DUMMY', 				'TXT_KEY_BUILDING_JWW_KANALI_FOOD_DUMMY');

INSERT INTO Buildings      
        (TYPE,										BuildingClass,									 Cost,  FaithCost, GreatWorkCount,   NeverCapture,  Happiness,	Description)
VALUES  ('BUILDING_JWW_UZBEK_UA_DUMMY',				'BUILDINGCLASS_JWW_UZBEK_UA_DUMMY',				 -1,    -1,        -1,               1,             1,			'TXT_KEY_BUILDING_JWW_UZBEK_UA_DUMMY'),
		('BUILDING_JWW_KANALI_PROD_DUMMY',			'BUILDINGCLASS_JWW_KANALI_PROD_DUMMY',			 -1,    -1,        -1,               1,             0,			'TXT_KEY_BUILDING_JWW_KANALI_PROD_DUMMY'),
		('BUILDING_JWW_KANALI_FOOD_DUMMY',			'BUILDINGCLASS_JWW_KANALI_FOOD_DUMMY',			 -1,    -1,        -1,               1,             0,			'TXT_KEY_BUILDING_JWW_KANALI_FOOD_DUMMY');

-------------------------------------------
--Unit (Maxsus Kuchlar)
-------------------------------------------

INSERT INTO Units
		(Type,						Description,						Civilopedia,							Strategy,									Help,									Combat,	Cost,	FaithCost,	RequiresFaithPurchaseEnabled,	Moves,	Range,	BaseSightRange,	Class,						CombatClass,			Domain,			DefaultUnitAI,		MilitarySupport,	MilitaryProduction,	Pillage,	IgnoreBuildingDefense,	PrereqTech,		ObsoleteTech,			GoodyHutUpgradeUnitClass,			AdvancedStartCost,	MinAreaSize,	NukeDamageLevel,	CombatLimit,	XPValueAttack,	XPValueDefense,	Conscription,	UnitArtInfo,							ShowInPedia,	MoveRate,		UnitFlagIconOffset,	PortraitIndex,	IconAtlas,					UnitFlagAtlas)
VALUES	('UNIT_JWW_MAXSUS_KUCHLAR',	'TXT_KEY_UNIT_JWW_MAXSUS_KUCHLAR',	'TXT_KEY_CIV5_JWW_MAXSUS_KUCHLAR_TEXT',	'TXT_KEY_UNIT_JWW_MAXSUS_KUCHLAR_STRATEGY',	'TXT_KEY_UNIT_HELP_JWW_MAXSUS_KUCHLAR',	60,		375,	750,		1,								2,		2,		2,				'UNITCLASS_INFANTRY',		'UNITCOMBAT_GUN',		'DOMAIN_LAND',	'UNITAI_DEFENSE',	1,					1,					1,			1,						'TECH_PLASTIC',	'TECH_MOBILE_TACTICS',	'UNITCLASS_MECHANIZED_INFANTRY',	35,					-1,				-1,					100,			3,				3,				6,				'ART_DEF_UNIT_JWW_MAXSUS_KUCHLAR',		1,				'BIPED',		0,					2,				'JWW_UZBEK_COLOR_ATLAS',	'JWW_UZBEK_UNIT_ALPHA_ATLAS');

INSERT INTO UnitGameplay2DScripts
		(UnitType,					SelectionSound,			FirstSelectionSound)
VALUES	('UNIT_JWW_MAXSUS_KUCHLAR',	'AS2D_SELECT_INFANTRY',	'AS2D_BIRTH_INFANTRY');

INSERT INTO Unit_AITypes
		(UnitType,					UnitAIType)
VALUES	('UNIT_JWW_MAXSUS_KUCHLAR',	'UNITAI_ATTACK'),
		('UNIT_JWW_MAXSUS_KUCHLAR',	'UNITAI_DEFENSE'),
		('UNIT_JWW_MAXSUS_KUCHLAR',	'UNITAI_EXPLORE');

INSERT INTO Unit_FreePromotions
		(UnitType,					PromotionType)
VALUES	('UNIT_JWW_MAXSUS_KUCHLAR',	'PROMOTION_BLITZ');

INSERT INTO Unit_Flavors
		(UnitType,	FlavorType,	Flavor)
VALUES	('UNIT_JWW_MAXSUS_KUCHLAR',	'FLAVOR_OFFENSE',	15),
		('UNIT_JWW_MAXSUS_KUCHLAR',	'FLAVOR_DEFENSE',	15);

INSERT INTO Unit_ClassUpgrades
		(UnitType,					UnitClassType)
VALUES	('UNIT_JWW_MAXSUS_KUCHLAR',	'UNITCLASS_MECHANIZED_INFANTRY');

-------------------------------------------
--Leader (Islam Karimov)
-------------------------------------------

INSERT INTO Leaders
		(Type,							Description,						Civilopedia,								CivilopediaTag,										ArtDefineTag,				VictoryCompetitiveness,	WonderCompetitiveness,	MinorCivCompetitiveness,	Boldness,	DiploBalance,	WarmongerHate,	WorkAgainstWillingness,	WorkWithWillingness,	DenounceWillingness,	DoFWillingness,	Loyalty,	Neediness,	Forgiveness,	Chattiness,	Meanness,	PortraitIndex,	IconAtlas)
VALUES	('LEADER_JWW_ISLAM_KARIMOV',	'TXT_KEY_LEADER_JWW_ISLAM_KARIMOV',	'TXT_KEY_LEADER_JWW_ISLAM_KARIMOV_PEDIA',	'TXT_KEY_CIVILOPEDIA_LEADERS_JWW_ISLAM_KARIMOV',	'KarimovScene.xml',		6,						5,						4,							6,			7,				4,				1,						4,						6,						4,				4,			6,			5,				5,			7,			0,				'JWW_UZBEK_COLOR_ATLAS');

INSERT INTO Leader_MajorCivApproachBiases
		(LeaderType,				MajorCivApproachType,			Bias)
VALUES	('LEADER_JWW_ISLAM_KARIMOV',	'MAJOR_CIV_APPROACH_WAR',		7),
		('LEADER_JWW_ISLAM_KARIMOV',	'MAJOR_CIV_APPROACH_HOSTILE',	6),
		('LEADER_JWW_ISLAM_KARIMOV',	'MAJOR_CIV_APPROACH_DECEPTIVE',	6),
		('LEADER_JWW_ISLAM_KARIMOV',	'MAJOR_CIV_APPROACH_GUARDED',	3),
		('LEADER_JWW_ISLAM_KARIMOV',	'MAJOR_CIV_APPROACH_AFRAID',	2),
		('LEADER_JWW_ISLAM_KARIMOV',	'MAJOR_CIV_APPROACH_FRIENDLY',	4),
		('LEADER_JWW_ISLAM_KARIMOV',	'MAJOR_CIV_APPROACH_NEUTRAL',	5);

INSERT INTO Leader_MinorCivApproachBiases
		(LeaderType,				MinorCivApproachType,				Bias)
VALUES	('LEADER_JWW_ISLAM_KARIMOV',	'MINOR_CIV_APPROACH_IGNORE',		7),
		('LEADER_JWW_ISLAM_KARIMOV',	'MINOR_CIV_APPROACH_FRIENDLY',		5),
		('LEADER_JWW_ISLAM_KARIMOV',	'MINOR_CIV_APPROACH_PROTECTIVE',	3),
		('LEADER_JWW_ISLAM_KARIMOV',	'MINOR_CIV_APPROACH_CONQUEST',		7),
		('LEADER_JWW_ISLAM_KARIMOV',	'MINOR_CIV_APPROACH_BULLY',			8);

INSERT INTO	Leader_Flavors
		(LeaderType,				FlavorType,							Flavor)
VALUES	('LEADER_JWW_ISLAM_KARIMOV',	'FLAVOR_OFFENSE',					8),
		('LEADER_JWW_ISLAM_KARIMOV',	'FLAVOR_DEFENSE',					4),
		('LEADER_JWW_ISLAM_KARIMOV',	'FLAVOR_CITY_DEFENSE',				5),
		('LEADER_JWW_ISLAM_KARIMOV',	'FLAVOR_MILITARY_TRAINING',			6),
		('LEADER_JWW_ISLAM_KARIMOV',	'FLAVOR_RECON',						7),
		('LEADER_JWW_ISLAM_KARIMOV',	'FLAVOR_RANGED',					8),
		('LEADER_JWW_ISLAM_KARIMOV',	'FLAVOR_MOBILE',					9),
		('LEADER_JWW_ISLAM_KARIMOV',	'FLAVOR_NAVAL',						1),
		('LEADER_JWW_ISLAM_KARIMOV',	'FLAVOR_NAVAL_RECON',				1),
		('LEADER_JWW_ISLAM_KARIMOV',	'FLAVOR_NAVAL_GROWTH',				1),
		('LEADER_JWW_ISLAM_KARIMOV',	'FLAVOR_NAVAL_TILE_IMPROVEMENT',	2),
		('LEADER_JWW_ISLAM_KARIMOV',	'FLAVOR_AIR',						4),
		('LEADER_JWW_ISLAM_KARIMOV',	'FLAVOR_EXPANSION',					7),
		('LEADER_JWW_ISLAM_KARIMOV',	'FLAVOR_GROWTH',					6),
		('LEADER_JWW_ISLAM_KARIMOV',	'FLAVOR_TILE_IMPROVEMENT',			5),
		('LEADER_JWW_ISLAM_KARIMOV',	'FLAVOR_INFRASTRUCTURE',			3),
		('LEADER_JWW_ISLAM_KARIMOV',	'FLAVOR_PRODUCTION',				8),
		('LEADER_JWW_ISLAM_KARIMOV',	'FLAVOR_GOLD',						6),
		('LEADER_JWW_ISLAM_KARIMOV',	'FLAVOR_SCIENCE',					5),
		('LEADER_JWW_ISLAM_KARIMOV',	'FLAVOR_CULTURE',					5),
		('LEADER_JWW_ISLAM_KARIMOV',	'FLAVOR_HAPPINESS',					2),
		('LEADER_JWW_ISLAM_KARIMOV',	'FLAVOR_GREAT_PEOPLE',				4),
		('LEADER_JWW_ISLAM_KARIMOV',	'FLAVOR_WONDER',					4),
		('LEADER_JWW_ISLAM_KARIMOV',	'FLAVOR_RELIGION',					7),
		('LEADER_JWW_ISLAM_KARIMOV',	'FLAVOR_DIPLOMACY',					5),
		('LEADER_JWW_ISLAM_KARIMOV',	'FLAVOR_SPACESHIP',					4),
		('LEADER_JWW_ISLAM_KARIMOV',	'FLAVOR_WATER_CONNECTION',			2),
		('LEADER_JWW_ISLAM_KARIMOV',	'FLAVOR_NUKE',						6),
		('LEADER_JWW_ISLAM_KARIMOV',	'FLAVOR_USE_NUKE',					5),
		('LEADER_JWW_ISLAM_KARIMOV',	'FLAVOR_ESPIONAGE',					5),
		('LEADER_JWW_ISLAM_KARIMOV',	'FLAVOR_ANTIAIR',					5),
		('LEADER_JWW_ISLAM_KARIMOV',	'FLAVOR_AIR_CARRIER',				1),
		('LEADER_JWW_ISLAM_KARIMOV',	'FLAVOR_ARCHAEOLOGY',				4),
		('LEADER_JWW_ISLAM_KARIMOV',	'FLAVOR_I_LAND_TRADE_ROUTE',		7),
		('LEADER_JWW_ISLAM_KARIMOV',	'FLAVOR_I_SEA_TRADE_ROUTE',			3),
		('LEADER_JWW_ISLAM_KARIMOV',	'FLAVOR_I_TRADE_ORIGIN',			4),
		('LEADER_JWW_ISLAM_KARIMOV',	'FLAVOR_I_TRADE_DESTINATION',		6),
		('LEADER_JWW_ISLAM_KARIMOV',	'FLAVOR_AIRLIFT',					5);

INSERT INTO Leader_Traits
		(LeaderType,					TraitType)
VALUES	('LEADER_JWW_ISLAM_KARIMOV',	'TRAIT_JWW_STRENGTH_IN_JUSTICE');

-------------------------------------------
--Trait (Strength in Justice)
-------------------------------------------

INSERT INTO Traits
		(Type,								Description,								ShortDescription)
VALUES	('TRAIT_JWW_STRENGTH_IN_JUSTICE',	'TXT_KEY_TRAIT_JWW_STRENGTH_IN_JUSTICE',	'TXT_KEY_TRAIT_JWW_STRENGTH_IN_JUSTICE_SHORT');

-------------------------------------------
--Diplomacy Responses
-------------------------------------------

INSERT INTO Diplomacy_Responses
		(LeaderType,					ResponseType,									Response,																	Bias)
VALUES	('LEADER_JWW_ISLAM_KARIMOV',	'RESPONSE_DEFEATED',							'TXT_KEY_LEADER_JWW_ISLAM_KARIMOV_DEFEATED%',								1),
		('LEADER_JWW_ISLAM_KARIMOV',	'RESPONSE_EXPANSION_SERIOUS_WARNING',			'TXT_KEY_LEADER_JWW_ISLAM_KARIMOV_EXPANSION_SERIOUS_WARNING%',				1),
		('LEADER_JWW_ISLAM_KARIMOV',	'RESPONSE_FIRST_GREETING',						'TXT_KEY_LEADER_JWW_ISLAM_KARIMOV_FIRSTGREETING%',							1),
		('LEADER_JWW_ISLAM_KARIMOV',	'RESPONSE_GREETING_HOSTILE_HELLO',				'TXT_KEY_LEADER_JWW_ISLAM_KARIMOV_GREETING_HOSTILE_HELLO%',					1),
		('LEADER_JWW_ISLAM_KARIMOV',	'RESPONSE_GREETING_NEUTRAL_HELLO',				'TXT_KEY_LEADER_JWW_ISLAM_KARIMOV_GREETING_NEUTRAL_HELLO%',					1),
		('LEADER_JWW_ISLAM_KARIMOV',	'RESPONSE_GREETING_POLITE_HELLO',				'TXT_KEY_LEADER_JWW_ISLAM_KARIMOV_GREETING_POLITE_HELLO%',					1),
		('LEADER_JWW_ISLAM_KARIMOV',	'RESPONSE_HOSTILE_AGGRESSIVE_MILITARY_WARNING',	'TXT_KEY_LEADER_JWW_ISLAM_KARIMOV_HOSTILE_AGGRESSIVE_MILITARY_WARNING%',	1),
		('LEADER_JWW_ISLAM_KARIMOV',	'RESPONSE_REQUEST',								'TXT_KEY_LEADER_JWW_ISLAM_KARIMOV_REQUEST%',								1),
		('LEADER_JWW_ISLAM_KARIMOV',	'RESPONSE_DECLAREWAR',							'TXT_KEY_LEADER_JWW_ISLAM_KARIMOV_DECLAREWAR%',								1),
		('LEADER_JWW_ISLAM_KARIMOV',	'RESPONSE_LUXURY_TRADE',						'TXT_KEY_LEADER_JWW_ISLAM_KARIMOV_LUXURY_TRADE%',							1),
		('LEADER_JWW_ISLAM_KARIMOV',	'RESPONSE_OPEN_BORDERS_EXCHANGE',				'TXT_KEY_LEADER_JWW_ISLAM_KARIMOV_OPEN_BORDERS_EXCHANGE%',					1),
		('LEADER_JWW_ISLAM_KARIMOV',	'RESPONSE_ATTACKED_BETRAYED',					'TXT_KEY_LEADER_JWW_ISLAM_KARIMOV_ATTACKED_BETRAYED%',						1),
		('LEADER_JWW_ISLAM_KARIMOV',	'RESPONSE_ATTACKED_EXCITED',					'TXT_KEY_LEADER_JWW_ISLAM_KARIMOV_ATTACKED_EXCITED%',						1),
		('LEADER_JWW_ISLAM_KARIMOV',	'RESPONSE_ATTACKED_HOSTILE',					'TXT_KEY_LEADER_JWW_ISLAM_KARIMOV_ATTACKED_HOSTILE%',						1),
		('LEADER_JWW_ISLAM_KARIMOV',	'RESPONSE_TRADE_NEEDMORE_ANGRY',				'TXT_KEY_LEADER_JWW_ISLAM_KARIMOV_TRADE_NEEDMORE_ANGRY%',					1),
		('LEADER_JWW_ISLAM_KARIMOV',	'RESPONSE_TRADE_NEEDMORE_NEUTRAL',				'TXT_KEY_LEADER_JWW_ISLAM_KARIMOV_TRADE_NEEDMORE_NEUTRAL%',					1),
		('LEADER_JWW_ISLAM_KARIMOV',	'RESPONSE_TRADE_NEEDMORE_HAPPY',				'TXT_KEY_LEADER_JWW_ISLAM_KARIMOV_TRADE_NEEDMORE_HAPPY%',					1);

-------------------------------------------
--Civilization (Uzbekistan)
-------------------------------------------

INSERT INTO Civilizations
		(Type,							Description,						Civilopedia,						CivilopediaTag,					Playable,	AIPlayable,		ShortDescription,								Adjective,								DefaultPlayerColor,				ArtDefineTag,					ArtStyleType,		ArtStyleSuffix,		ArtStylePrefix,		PortraitIndex,	IconAtlas,					AlphaIconAtlas,				MapImage,				DawnOfManQuote,								DawnOfManImage)
VALUES	('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CIV_JWW_UZBEKISTAN_DESC',	'TXT_KEY_CIV_JWW_UZBEKISTAN_PEDIA',	'TXT_KEY_CIV5_JWW_UZBEKISTAN',	1,			1,				'TXT_KEY_CIV_JWW_UZBEKISTAN_SHORT_DESC',		'TXT_KEY_CIV_JWW_UZBEKISTAN_ADJECTIVE',	'PLAYERCOLOR_JWW_UZBEKISTAN',	'ART_DEF_CIVILIZATION_RUSSIA',	'ARTSTYLE_ASIAN',	'_ASIA',			'ASIA',				1,				'JWW_UZBEK_COLOR_ATLAS',	'JWW_UZBEK_ALPHA_ATLAS',	'UzbekistanMap.dds',	'TXT_KEY_CIV5_DAWN_JWW_UZBEKISTAN_TEXT',	'KarimovDOM.dds');

INSERT INTO Civilization_Leaders
		(CivilizationType,				LeaderheadType)
VALUES	('CIVILIZATION_JWW_UZBEKISTAN',	'LEADER_JWW_ISLAM_KARIMOV');

INSERT INTO Civilization_BuildingClassOverrides
		(CivilizationType,				BuildingClassType,				BuildingType)
VALUES	('CIVILIZATION_JWW_UZBEKISTAN',	'BUILDINGCLASS_HYDRO_PLANT',	'BUILDING_JWW_SUGORISH_KANALI');

INSERT INTO Civilization_UnitClassOverrides
		(CivilizationType,				UnitClassType,			UnitType)
VALUES	('CIVILIZATION_JWW_UZBEKISTAN',	'UNITCLASS_INFANTRY',	'UNIT_JWW_MAXSUS_KUCHLAR');

INSERT INTO Civilization_FreeBuildingClasses
		(CivilizationType,				BuildingClassType)
VALUES	('CIVILIZATION_JWW_UZBEKISTAN',	'BUILDINGCLASS_PALACE');

INSERT INTO Civilization_FreeTechs
		(CivilizationType,				TechType)
VALUES	('CIVILIZATION_JWW_UZBEKISTAN',	'TECH_AGRICULTURE');

INSERT INTO Civilization_FreeUnits
		(CivilizationType,				UnitClassType,			UnitAIType,			Count)
VALUES	('CIVILIZATION_JWW_UZBEKISTAN',	'UNITCLASS_SETTLER',	'UNITAI_SETTLE',	1);

INSERT INTO Civilization_Religions
		(CivilizationType,				ReligionType)
VALUES	('CIVILIZATION_JWW_UZBEKISTAN',	'RELIGION_ISLAM');

INSERT INTO Civilization_Start_Region_Avoid
		(CivilizationType,				RegionType)
VALUES	('CIVILIZATION_JWW_UZBEKISTAN',	'REGION_TUNDRA'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'REGION_JUNGLE');

INSERT INTO	Civilization_CityNames
		(CivilizationType,			CityName)
VALUES	('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_0'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_1'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_2'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_3'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_4'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_5'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_6'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_7'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_8'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_9'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_10'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_11'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_12'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_13'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_14'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_15'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_16'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_17'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_18'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_19'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_20'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_21'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_22'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_23'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_24'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_25'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_26'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_27'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_28'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_29'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_30'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_31'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_32'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_33'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_34'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_35'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_36'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_37'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_38'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_39'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_40'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_41'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_42'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_43'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_44'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_45'),
		('CIVILIZATION_JWW_UZBEKISTAN',	'TXT_KEY_CITY_NAME_JWW_UZBEKISTAN_46');
				
INSERT INTO Civilization_SpyNames
		(CivilizationType,					SpyName)
VALUES	('CIVILIZATION_JWW_UZBEKISTAN',		'TXT_KEY_SPY_NAME_JWW_UZBEKISTAN_0'),
		('CIVILIZATION_JWW_UZBEKISTAN',		'TXT_KEY_SPY_NAME_JWW_UZBEKISTAN_1'),
		('CIVILIZATION_JWW_UZBEKISTAN',		'TXT_KEY_SPY_NAME_JWW_UZBEKISTAN_2'),
		('CIVILIZATION_JWW_UZBEKISTAN',		'TXT_KEY_SPY_NAME_JWW_UZBEKISTAN_3'),
		('CIVILIZATION_JWW_UZBEKISTAN',		'TXT_KEY_SPY_NAME_JWW_UZBEKISTAN_4'),
		('CIVILIZATION_JWW_UZBEKISTAN',		'TXT_KEY_SPY_NAME_JWW_UZBEKISTAN_5'),
		('CIVILIZATION_JWW_UZBEKISTAN',		'TXT_KEY_SPY_NAME_JWW_UZBEKISTAN_6'),
		('CIVILIZATION_JWW_UZBEKISTAN',		'TXT_KEY_SPY_NAME_JWW_UZBEKISTAN_7'),
		('CIVILIZATION_JWW_UZBEKISTAN',		'TXT_KEY_SPY_NAME_JWW_UZBEKISTAN_8'),
		('CIVILIZATION_JWW_UZBEKISTAN',		'TXT_KEY_SPY_NAME_JWW_UZBEKISTAN_9');

-------------------------------------------
--Minor Civilizations (Krygyzstan)
-------------------------------------------
UPDATE MinorCivilizations
SET Description = 'TXT_KEY_CITYSTATE_JWW_BISHKEK_DESC',
	ShortDescription = 'TXT_KEY_CITYSTATE_JWW_BISHKEK_SHORT_DESC',
	Adjective = 'TXT_KEY_CITYSTATE_JWW_BISHKEK_ADJECTIVE',
	Civilopedia = 'TXT_KEY_CIV5_JWW_BISHKEK_TEXT'
WHERE Type = 'MINOR_CIV_SAMARKAND';	

DELETE FROM MinorCivilization_CityNames WHERE MinorCivType = 'MINOR_CIV_SAMARKAND';
INSERT INTO MinorCivilization_CityNames
			(MinorCivType, 				CityName)
VALUES		('MINOR_CIV_SAMARKAND', 	'TXT_KEY_CITYSTATE_JWW_BISHKEK');
--================================================================
--================================================================