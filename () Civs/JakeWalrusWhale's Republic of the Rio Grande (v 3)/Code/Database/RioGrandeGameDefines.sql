-------------------------------------------
--Building (Fortaleza Colonial)
-------------------------------------------
INSERT INTO Buildings
		(Type,								Description,								Civilopedia,											Strategy,											Help,											GoldMaintenance,	MutuallyExclusiveGroup,	NeverCapture,	Cost,	MinAreaSize,	BuildingClass,						ArtDefineTag,							PrereqTech,						PortraitIndex,	WonderSplashAnchor,	IconAtlas)
VALUES	('BUILDING_JWW_FORTALEZA_COLONIAL',	'TXT_KEY_BUILDING_JWW_FORTALEZA_COLONIAL',	'TXT_KEY_CIV5_BUILDINGS_JWW_FORTALEZA_COLONIAL_TEXT',	'TXT_KEY_BUILDING_JWW_FORTALEZA_COLONIAL_STRATEGY',	'TXT_KEY_BUILDING_JWW_FORTALEZA_COLONIAL_HELP',	1,					1,						1,				300,	-1,				'BUILDINGCLASS_MILITARY_ACADEMY',	'ART_DEF_BUILDING_MILITARY_ACADEMY',	'TECH_MILITARY_SCIENCE',		4,				'R,T',				'RIOGRANDE_COLOR_ATLAS');

INSERT INTO Building_ClassesNeededInCity
		(BuildingType,						BuildingClassType)
VALUES	('BUILDING_JWW_FORTALEZA_COLONIAL',	'BUILDINGCLASS_ARMORY');

INSERT INTO Building_DomainFreeExperiences
		(BuildingType,						DomainType,		Experience)
VALUES	('BUILDING_JWW_FORTALEZA_COLONIAL',	'DOMAIN_LAND',	15),
		('BUILDING_JWW_FORTALEZA_COLONIAL',	'DOMAIN_SEA',	15),
		('BUILDING_JWW_FORTALEZA_COLONIAL',	'DOMAIN_AIR',	15);

INSERT INTO	Building_Flavors
		(BuildingType,						FlavorType,					Flavor)
VALUES	('BUILDING_JWW_FORTALEZA_COLONIAL',	'FLAVOR_MILITARY_TRAINING',	20);

INSERT INTO BuildingClasses
		(Type, 											DefaultBuilding, 						Description)
VALUES	('BUILDINGCLASS_JWW_RG_FC_RIVER_DUMMY', 		'BUILDING_JWW_RG_FC_RIVER_DUMMY', 		'TXT_KEY_BUILDING_JWW_RG_FC_RIVER_DUMMY'),
		('BUILDINGCLASS_JWW_RG_UA_DUMMY',				'BUILDING_JWW_RG_UA_DUMMY',				'TXT_KEY_BUILDING_JWW_RG_UA_DUMMY');

INSERT INTO Buildings		
		(Type, 									BuildingClass,									PrereqTech,		Cost,	FaithCost,	GreatWorkCount,	NeverCapture,	NukeImmune,	Defense,	ExtraCityHitPoints,	PortraitIndex,	IconAtlas,		Description)
VALUES	('BUILDING_JWW_RG_FC_RIVER_DUMMY',		'BUILDINGCLASS_JWW_RG_FC_RIVER_DUMMY',			'NULL', 		-1,		-1,			-1,				1,				1,			100,		5,					19,				'BW_ATLAS_1',	'TXT_KEY_BUILDING_JWW_RG_FC_RIVER_DUMMY');

INSERT INTO Buildings      
        (TYPE,                              BuildingClass,                          Cost,  FaithCost, GreatWorkCount,   NeverCapture,  Description)
VALUES  ('BUILDING_JWW_RG_UA_DUMMY',		'BUILDINGCLASS_JWW_RG_UA_DUMMY',        -1,    -1,        -1,               1,             'TXT_KEY_BUILDING_JWW_RG_UA_DUMMY');

INSERT INTO Building_UnitCombatFreeExperiences  
        (BuildingType,                    UnitCombatType,							Experience)
VALUES  ('BUILDING_JWW_RG_UA_DUMMY',	 'UNITCOMBAT_MELEE',                         3),
        ('BUILDING_JWW_RG_UA_DUMMY',	 'UNITCOMBAT_RECON',                         3),
        ('BUILDING_JWW_RG_UA_DUMMY',	 'UNITCOMBAT_ARCHER',                        3),
        ('BUILDING_JWW_RG_UA_DUMMY',	 'UNITCOMBAT_MOUNTED',                       3),
        ('BUILDING_JWW_RG_UA_DUMMY',	 'UNITCOMBAT_SIEGE',                         3),
        ('BUILDING_JWW_RG_UA_DUMMY',     'UNITCOMBAT_GUN',							 3),
        ('BUILDING_JWW_RG_UA_DUMMY',     'UNITCOMBAT_ARMOR',                         3),
        ('BUILDING_JWW_RG_UA_DUMMY',     'UNITCOMBAT_HELICOPTER',                    3),
        ('BUILDING_JWW_RG_UA_DUMMY',     'UNITCOMBAT_NAVALRANGED',                   3),
        ('BUILDING_JWW_RG_UA_DUMMY',     'UNITCOMBAT_FIGHTER',                       3),
        ('BUILDING_JWW_RG_UA_DUMMY',     'UNITCOMBAT_BOMBER',                        3),
        ('BUILDING_JWW_RG_UA_DUMMY',     'UNITCOMBAT_NAVALMELEE',                    3);
-------------------------------------------
--Unit (Vaquero)
-------------------------------------------

INSERT INTO Units
		(Type,					Description,					Civilopedia,					Strategy,								Help,								Combat,	Cost,	FaithCost,	RequiresFaithPurchaseEnabled,	Moves,	BaseSightRange,	Class,					CombatClass,			Domain,			DefaultUnitAI,			MilitarySupport,	MilitaryProduction,	Pillage,	IgnoreBuildingDefense,	PrereqTech,					ObsoleteTech,		GoodyHutUpgradeUnitClass,		AdvancedStartCost,	MinAreaSize,	NukeDamageLevel,	CombatLimit,	XPValueAttack,	XPValueDefense,	Conscription,	UnitArtInfo,					ShowInPedia,	MoveRate,		UnitFlagIconOffset,	PortraitIndex,	IconAtlas,					UnitFlagAtlas)
VALUES	('UNIT_JWW_VAQUERO',	'TXT_KEY_UNIT_JWW_VAQUERO',	'TXT_KEY_CIV5_JWW_VAQUERO_TEXT',	'TXT_KEY_UNIT_JWW_VAQUERO_STRATEGY',	'TXT_KEY_UNIT_HELP_JWW_VAQUERO',	34,		225,	450,		1,								4,		2,				'UNITCLASS_CAVALRY',	'UNITCOMBAT_MOUNTED',	'DOMAIN_LAND',	'UNITAI_FAST_ATTACK',	1,					1,					1,			1,						'TECH_MILITARY_SCIENCE',	'TECH_COMBUSTION',	'UNITCLASS_WWI_TANK',			30,					-1,				-1,					100,			3,				3,				5,				'ART_DEF_UNIT_JWW_VAQUERO',		1,				'QUADRUPED',	0,					2,				'RIOGRANDE_COLOR_ATLAS',	'RIO_GRANDE_UNIT_ALPHA_ATLAS');

INSERT INTO UnitGameplay2DScripts
		(UnitType,				SelectionSound,			FirstSelectionSound)
VALUES	('UNIT_JWW_VAQUERO',	'AS2D_SELECT_CAVALRY',	'AS2D_BIRTH_CAVALRY');

INSERT INTO Unit_AITypes
		(UnitType,				UnitAIType)
VALUES	('UNIT_JWW_VAQUERO',	'UNITAI_FAST_ATTACK'),
		('UNIT_JWW_VAQUERO',	'UNITAI_DEFENSE');

INSERT INTO Unit_FreePromotions
		(UnitType,				PromotionType)
VALUES	('UNIT_JWW_VAQUERO',	'PROMOTION_NO_DEFENSIVE_BONUSES'),
		('UNIT_JWW_VAQUERO',	'PROMOTION_CAN_MOVE_AFTER_ATTACKING'),
		('UNIT_JWW_VAQUERO',	'PROMOTION_CITY_PENALTY');

INSERT INTO Unit_ResourceQuantityRequirements
		(UnitType,				ResourceType,		Cost)
VALUES	('UNIT_JWW_VAQUERO',	'RESOURCE_HORSE',	1);

INSERT INTO Unit_Flavors
		(UnitType,	FlavorType,	Flavor)
VALUES	('UNIT_JWW_VAQUERO',	'FLAVOR_OFFENSE',	10),
		('UNIT_JWW_VAQUERO',	'FLAVOR_DEFENSE',	6),
		('UNIT_JWW_VAQUERO',	'FLAVOR_MOBILE',	7);

INSERT INTO Unit_ClassUpgrades
		(UnitType,				UnitClassType)
VALUES	('UNIT_JWW_VAQUERO',	'UNITCLASS_WWI_TANK');

INSERT INTO UnitPromotions
		(Type,						Description,						Help,									Sound,				CannotBeChosen,	RoughAttack,	RoughDefense,	OpenAttack,	OpenDefense,	PortraitIndex,		IconAtlas,			PediaType,		PediaEntry)
VALUES	('PROMOTION_JWW_VAQUERO',	'TXT_KEY_PROMOTION_JWW_VAQUERO',	'TXT_KEY_PROMOTION_JWW_VAQUERO_HELP',	'AS2D_IF_LEVELUP',	1,				50,				50,				50,			50,				59,					'ABILITY_ATLAS',	'PEDIA_MELEE',	'TXT_KEY_PROMOTION_JWW_VAQUERO');
-------------------------------------------
--Leader (Antonio Canales)
-------------------------------------------

INSERT INTO Leaders
		(Type,							Description,							Civilopedia,								CivilopediaTag,										ArtDefineTag,			VictoryCompetitiveness,	WonderCompetitiveness,	MinorCivCompetitiveness,	Boldness,	DiploBalance,	WarmongerHate,	WorkAgainstWillingness,	WorkWithWillingness,	DenounceWillingness,	DoFWillingness,	Loyalty,	Neediness,	Forgiveness,	Chattiness,	Meanness,	PortraitIndex,	IconAtlas)
VALUES	('LEADER_JWW_ANTONIO_CANALES',	'TXT_KEY_LEADER_JWW_ANTONIO_CANALES',	'TXT_KEY_LEADER_JWW_ANTONIO_CANALES_PEDIA',	'TXT_KEY_CIVILOPEDIA_LEADERS_JWW_ANTONIO_CANALES',	'RosilloScene.xml',		7,						3,						6,							5,			7,				4,				2,						6,						5,						8,				7,			5,			4,				7,			5,			0,				'RIOGRANDE_COLOR_ATLAS');

INSERT INTO Leader_MajorCivApproachBiases
		(LeaderType,						MajorCivApproachType,			Bias)
VALUES	('LEADER_JWW_ANTONIO_CANALES',	'MAJOR_CIV_APPROACH_WAR',		6),
		('LEADER_JWW_ANTONIO_CANALES',	'MAJOR_CIV_APPROACH_HOSTILE',	3),
		('LEADER_JWW_ANTONIO_CANALES',	'MAJOR_CIV_APPROACH_DECEPTIVE',	6),
		('LEADER_JWW_ANTONIO_CANALES',	'MAJOR_CIV_APPROACH_GUARDED',	8),
		('LEADER_JWW_ANTONIO_CANALES',	'MAJOR_CIV_APPROACH_AFRAID',	7),
		('LEADER_JWW_ANTONIO_CANALES',	'MAJOR_CIV_APPROACH_FRIENDLY',	5),
		('LEADER_JWW_ANTONIO_CANALES',	'MAJOR_CIV_APPROACH_NEUTRAL',	9);

INSERT INTO Leader_MinorCivApproachBiases
		(LeaderType,						MinorCivApproachType,				Bias)
VALUES	('LEADER_JWW_ANTONIO_CANALES',	'MINOR_CIV_APPROACH_IGNORE',		3),
		('LEADER_JWW_ANTONIO_CANALES',	'MINOR_CIV_APPROACH_FRIENDLY',		8),
		('LEADER_JWW_ANTONIO_CANALES',	'MINOR_CIV_APPROACH_PROTECTIVE',	6),
		('LEADER_JWW_ANTONIO_CANALES',	'MINOR_CIV_APPROACH_CONQUEST',		2),
		('LEADER_JWW_ANTONIO_CANALES',	'MINOR_CIV_APPROACH_BULLY',			1);

INSERT INTO	Leader_Flavors
		(LeaderType,						FlavorType,							Flavor)
VALUES	('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_OFFENSE',					8),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_DEFENSE',					4),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_CITY_DEFENSE',				5),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_MILITARY_TRAINING',			4),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_RECON',						7),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_RANGED',					9),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_MOBILE',					8),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_NAVAL',						3),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_NAVAL_RECON',				4),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_NAVAL_GROWTH',				4),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_NAVAL_TILE_IMPROVEMENT',	2),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_AIR',						1),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_EXPANSION',					7),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_GROWTH',					5),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_TILE_IMPROVEMENT',			7),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_INFRASTRUCTURE',			4),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_PRODUCTION',				6),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_GOLD',						4),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_SCIENCE',					3),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_CULTURE',					6),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_HAPPINESS',					7),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_GREAT_PEOPLE',				3),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_WONDER',					4),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_RELIGION',					3),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_DIPLOMACY',					6),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_SPACESHIP',					2),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_WATER_CONNECTION',			5),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_NUKE',						3),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_USE_NUKE',					3),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_ESPIONAGE',					4),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_ANTIAIR',					4),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_AIR_CARRIER',				4),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_ARCHAEOLOGY',				5),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_I_LAND_TRADE_ROUTE',		8),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_I_SEA_TRADE_ROUTE',			5),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_I_TRADE_ORIGIN',			6),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_I_TRADE_DESTINATION',		8),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_AIRLIFT',					4);

INSERT INTO Leader_Traits
		(LeaderType,					TraitType)
VALUES	('LEADER_JWW_ANTONIO_CANALES',	'TRAIT_JWW_DIOS_LIBERTAD_CONVENCION');

-------------------------------------------
--Trait (Dios, Lidertad y Convencion)
-------------------------------------------

INSERT INTO Traits
		(Type,					Description,					ShortDescription)
VALUES	('TRAIT_JWW_DIOS_LIBERTAD_CONVENCION',	'TXT_KEY_TRAIT_JWW_DIOS_LIBERTAD_CONVENCION',	'TXT_KEY_TRAIT_JWW_DIOS_LIBERTAD_CONVENCION_SHORT');

-------------------------------------------
--Diplomacy Responses
-------------------------------------------

INSERT INTO Diplomacy_Responses
		(LeaderType,					ResponseType,									Response,																	Bias)
VALUES	('LEADER_JWW_ANTONIO_CANALES',	'RESPONSE_DEFEATED',							'TXT_KEY_LEADER_JWW_ANTONIO_CANALES_DEFEATED%',								1),
		('LEADER_JWW_ANTONIO_CANALES',	'RESPONSE_EXPANSION_SERIOUS_WARNING',			'TXT_KEY_LEADER_JWW_ANTONIO_CANALES_EXPANSION_SERIOUS_WARNING%',			1),
		('LEADER_JWW_ANTONIO_CANALES',	'RESPONSE_FIRST_GREETING',						'TXT_KEY_LEADER_JWW_ANTONIO_CANALES_FIRSTGREETING%',						1),
		('LEADER_JWW_ANTONIO_CANALES',	'RESPONSE_GREETING_HOSTILE_HELLO',				'TXT_KEY_LEADER_JWW_ANTONIO_CANALES_GREETING_HOSTILE_HELLO%',				1),
		('LEADER_JWW_ANTONIO_CANALES',	'RESPONSE_GREETING_NEUTRAL_HELLO',				'TXT_KEY_LEADER_JWW_ANTONIO_CANALES_GREETING_NEUTRAL_HELLO%',				1),
		('LEADER_JWW_ANTONIO_CANALES',	'RESPONSE_GREETING_POLITE_HELLO',				'TXT_KEY_LEADER_JWW_ANTONIO_CANALES_GREETING_POLITE_HELLO%',				1),
		('LEADER_JWW_ANTONIO_CANALES',	'RESPONSE_HOSTILE_AGGRESSIVE_MILITARY_WARNING',	'TXT_KEY_LEADER_JWW_ANTONIO_CANALES_HOSTILE_AGGRESSIVE_MILITARY_WARNING%',	1),
		('LEADER_JWW_ANTONIO_CANALES',	'RESPONSE_REQUEST',								'TXT_KEY_LEADER_JWW_ANTONIO_CANALES_REQUEST%',								1),
		('LEADER_JWW_ANTONIO_CANALES',	'RESPONSE_DECLAREWAR',							'TXT_KEY_LEADER_JWW_ANTONIO_CANALES_DECLAREWAR%',							1);

-------------------------------------------
--Civilization (Rio Grande)
-------------------------------------------

INSERT INTO Civilizations
		(Type,							Description,						Civilopedia,						CivilopediaTag,					Playable,	AIPlayable,		ShortDescription,							Adjective,								DefaultPlayerColor,				ArtDefineTag,					ArtStyleType,			ArtStyleSuffix,		ArtStylePrefix,		PortraitIndex,	IconAtlas,					AlphaIconAtlas,				MapImage,			DawnOfManQuote,								DawnOfManImage,			SoundtrackTag)
VALUES	('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CIV_JWW_RIO_GRANDE_DESC',	'TXT_KEY_CIV_JWW_RIO_GRANDE_PEDIA',	'TXT_KEY_CIV5_JWW_RIO_GRANDE',	1,			1,			'TXT_KEY_CIV_JWW_RIO_GRANDE_SHORT_DESC',		'TXT_KEY_CIV_JWW_RIO_GRANDE_ADJECTIVE',	'PLAYERCOLOR_JWW_RIO_GRANDE',	'ART_DEF_CIVILIZATION_SPAIN',	'ARTSTYLE_EUROPEAN',	'_EURO',			'EUROPEAN',			1,				'RIOGRANDE_COLOR_ATLAS',	'RIOGRANDE_ALPHA_ATLAS',	'RGMap.dds',		'TXT_KEY_CIV5_DAWN_JWW_RIO_GRANDE_TEXT',	'RosilloDOM.dds',		'Spain');

INSERT INTO Civilization_Leaders
		(CivilizationType,				LeaderheadType)
VALUES	('CIVILIZATION_JWW_RIO_GRANDE',	'LEADER_JWW_ANTONIO_CANALES');

INSERT INTO Civilization_BuildingClassOverrides
		(CivilizationType,				BuildingClassType,		BuildingType)
VALUES	('CIVILIZATION_JWW_RIO_GRANDE',	'BUILDINGCLASS_MILITARY_ACADEMY',	'BUILDING_JWW_FORTALEZA_COLONIAL');

INSERT INTO Civilization_UnitClassOverrides
		(CivilizationType,				UnitClassType,			UnitType)
VALUES	('CIVILIZATION_JWW_RIO_GRANDE',	'UNITCLASS_CAVALRY',	'UNIT_JWW_VAQUERO');

INSERT INTO Civilization_FreeBuildingClasses
		(CivilizationType,				BuildingClassType)
VALUES	('CIVILIZATION_JWW_RIO_GRANDE',	'BUILDINGCLASS_PALACE');

INSERT INTO Civilization_FreeTechs
		(CivilizationType,				TechType)
VALUES	('CIVILIZATION_JWW_RIO_GRANDE',	'TECH_AGRICULTURE');

INSERT INTO Civilization_FreeUnits
		(CivilizationType,				UnitClassType,			UnitAIType,			Count)
VALUES	('CIVILIZATION_JWW_RIO_GRANDE',	'UNITCLASS_SETTLER',	'UNITAI_SETTLE',	1);

INSERT INTO Civilization_Religions
		(CivilizationType,				ReligionType)
VALUES	('CIVILIZATION_JWW_RIO_GRANDE',	'RELIGION_CHRISTIANITY');

INSERT INTO Civilization_Start_Along_River
		(CivilizationType,				StartAlongRiver)
VALUES	('CIVILIZATION_JWW_RIO_GRANDE',	1);

INSERT INTO	Civilization_CityNames
		(CivilizationType,				CityName)
VALUES	('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_0'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_1'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_2'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_3'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_4'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_5'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_6'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_7'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_8'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_9'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_10'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_11'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_12'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_13'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_14'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_15'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_16'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_17'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_18'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_19'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_20'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_21'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_22'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_23'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_24'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_25'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_26'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_27'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_28'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_29'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_30'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_31'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_32'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_33'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_34'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_35'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_36'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_37'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_38'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_39'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_40'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_41'),
		('CIVILIZATION_JWW_RIO_GRANDE',	'TXT_KEY_CITY_NAME_JWW_RIO_GRANDE_42');
				
INSERT INTO Civilization_SpyNames
		(CivilizationType,					SpyName)
VALUES	('CIVILIZATION_JWW_RIO_GRANDE',		'TXT_KEY_SPY_NAME_JWW_RIO_GRANDE_0'),
		('CIVILIZATION_JWW_RIO_GRANDE',		'TXT_KEY_SPY_NAME_JWW_RIO_GRANDE_1'),
		('CIVILIZATION_JWW_RIO_GRANDE',		'TXT_KEY_SPY_NAME_JWW_RIO_GRANDE_2'),
		('CIVILIZATION_JWW_RIO_GRANDE',		'TXT_KEY_SPY_NAME_JWW_RIO_GRANDE_3'),
		('CIVILIZATION_JWW_RIO_GRANDE',		'TXT_KEY_SPY_NAME_JWW_RIO_GRANDE_4'),
		('CIVILIZATION_JWW_RIO_GRANDE',		'TXT_KEY_SPY_NAME_JWW_RIO_GRANDE_5'),
		('CIVILIZATION_JWW_RIO_GRANDE',		'TXT_KEY_SPY_NAME_JWW_RIO_GRANDE_6'),
		('CIVILIZATION_JWW_RIO_GRANDE',		'TXT_KEY_SPY_NAME_JWW_RIO_GRANDE_7'),
		('CIVILIZATION_JWW_RIO_GRANDE',		'TXT_KEY_SPY_NAME_JWW_RIO_GRANDE_8'),
		('CIVILIZATION_JWW_RIO_GRANDE',		'TXT_KEY_SPY_NAME_JWW_RIO_GRANDE_9');

--================================================================
--================================================================