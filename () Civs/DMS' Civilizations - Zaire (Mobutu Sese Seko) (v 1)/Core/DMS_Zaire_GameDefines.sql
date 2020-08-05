--=======================================================================================================================
-- BUILDINGCLASSES
--=======================================================================================================================
-- BuildingClasses
------------------------------	
INSERT OR REPLACE INTO BuildingClasses 
		(DefaultBuilding, 							Type, 											Description)
VALUES	('BUILDING_DMS_GECAMINES_FACILITY_DEFENSE',	'BUILDINGCLASS_DMS_GECAMINES_FACILITY_DEFENSE', 'TXT_KEY_BUILDING_DMS_GECAMINES_FACILITY_DEFENSE');
--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================	
-- Buildings
------------------------------	
INSERT INTO Buildings 	
		(Type, 									BuildingClass,	Cost,	FreeStartEra,	HurryCostModifier,	GoldMaintenance,	PrereqTech,	Description, 								Civilopedia, 										Help, 												Strategy,												ArtDefineTag, 	MinAreaSize,	ConquestProb,	PortraitIndex, 	IconAtlas)
SELECT	('BUILDING_DMS_GECAMINES_FACILITY'),	BuildingClass,	Cost,	FreeStartEra,	HurryCostModifier,	GoldMaintenance,	PrereqTech,	('TXT_KEY_BUILDING_DMS_GECAMINES_FACILITY'),('TXT_KEY_BUILDING_DMS_GECAMINES_FACILITY_TEXT'),	('TXT_KEY_BUILDING_DMS_GECAMINES_FACILITY_HELP'),	('TXT_KEY_BUILDING_DMS_GECAMINES_FACILITY_STRATEGY'),	ArtDefineTag,	MinAreaSize,	0,				3, 				('DMS_ZAIRE_ATLAS')
FROM Buildings WHERE (Type = 'BUILDING_RECYCLING_CENTER');

INSERT INTO Buildings 
		(Type, 										BuildingClass,									Defense,	Cost, 	FaithCost,	GreatWorkSlotType,	GreatWorkCount,	GoldMaintenance,	PrereqTech, NeverCapture,	PortraitIndex, 	IconAtlas,	Description, 										Help)
VALUES	('BUILDING_DMS_GECAMINES_FACILITY_DEFENSE', 'BUILDINGCLASS_DMS_GECAMINES_FACILITY_DEFENSE',	25,			-1, 	-1,			NULL,				0,				0,					NULL,		1,				-1,				NULL,		'TXT_KEY_BUILDING_DMS_GECAMINES_FACILITY_DEFENSE',	'TXT_KEY_BUILDING_DMS_GECAMINES_FACILITY_DEFENSE_HELP');
------------------------------	
-- Building_Flavors
------------------------------		
INSERT INTO Building_Flavors 	
		(BuildingType, 							FlavorType,				Flavor)
SELECT	('BUILDING_DMS_GECAMINES_FACILITY'),	FlavorType,				Flavor
FROM Building_Flavors WHERE (BuildingType = 'BUILDING_RECYCLING_CENTER');

INSERT INTO Building_Flavors 
		(BuildingType, 							FlavorType,					Flavor)
VALUES	('BUILDING_DMS_GECAMINES_FACILITY', 	'FLAVOR_HAPPINESS', 		10),
		('BUILDING_DMS_GECAMINES_FACILITY', 	'FLAVOR_CULTURE',			10);
------------------------------	
-- Building_ResourceQuantity
------------------------------		
INSERT INTO Building_ResourceQuantity 	
		(BuildingType, 							ResourceType,				Quantity)
SELECT	('BUILDING_DMS_GECAMINES_FACILITY'),	ResourceType,				Quantity
FROM Building_ResourceQuantity WHERE (BuildingType = 'BUILDING_RECYCLING_CENTER');
--==========================================================================================================================
-- UNITS
--==========================================================================================================================
-- Units
--------------------------------
INSERT INTO Units 	
		(Type, 								Class, PrereqTech,	Combat,	RangedCombat,	Cost,	RequiresFaithPurchaseEnabled,	Moves,	Range,	CombatClass,	Domain,		DefaultUnitAI,	Description,								Civilopedia,									Strategy,											Help,											MilitarySupport,	MilitaryProduction,	Pillage,	ObsoleteTech,	IgnoreBuildingDefense,	GoodyHutUpgradeUnitClass,	AdvancedStartCost,	XPValueAttack,		XPValueDefense,		UnitArtInfo,								UnitFlagIconOffset,	UnitFlagAtlas,									PortraitIndex,	IconAtlas,				MoveRate)
SELECT	('UNIT_DMS_PRESIDENTAL_DIVISION'),	Class, PrereqTech,	Combat,	RangedCombat,	Cost,	RequiresFaithPurchaseEnabled,	Moves,	Range,	CombatClass,	Domain,		DefaultUnitAI,	('TXT_KEY_UNIT_DMS_PRESIDENTAL_DIVISION'),	('TXT_KEY_UNIT_DMS_PRESIDENTAL_DIVISION_TEXT'),	('TXT_KEY_UNIT_DMS_PRESIDENTAL_DIVISION_STRATEGY'),	('TXT_KEY_UNIT_DMS_PRESIDENTAL_DIVISION_HELP'),	MilitarySupport,	MilitaryProduction,	Pillage,	ObsoleteTech,	IgnoreBuildingDefense,	GoodyHutUpgradeUnitClass,	AdvancedStartCost,	XPValueAttack,		XPValueDefense,		('ART_DEF_UNIT_DMS_PRESIDENTAL_DIVISION'),	0,					('DMS_UNIT_FLAG_PRESIDENTAL_DIVISION_ATLAS'),	2,				('DMS_ZAIRE_ATLAS'),	MoveRate
FROM Units WHERE (Type = 'UNIT_MACHINE_GUN');
--------------------------------
-- UnitGameplay2DScripts
--------------------------------	
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 							SelectionSound, FirstSelectionSound)
SELECT		('UNIT_DMS_PRESIDENTAL_DIVISION'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_MACHINE_GUN');	
--------------------------------
-- Unit_AITypes
--------------------------------	
INSERT INTO Unit_AITypes 	
			(UnitType, 							UnitAIType)
SELECT		('UNIT_DMS_PRESIDENTAL_DIVISION'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_MACHINE_GUN');
--------------------------------
-- Unit_Flavors
--------------------------------	
INSERT INTO Unit_Flavors 	
			(UnitType, 							FlavorType,			Flavor)
SELECT		('UNIT_DMS_PRESIDENTAL_DIVISION'), 	FlavorType,			Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_MACHINE_GUN');

INSERT INTO Unit_Flavors 
		(UnitType, 								FlavorType,					Flavor)
VALUES	('UNIT_DMS_PRESIDENTAL_DIVISION', 		'FLAVOR_PRODUCTION', 		10),
		('UNIT_DMS_PRESIDENTAL_DIVISION', 		'FLAVOR_CULTURE',			10);
--------------------------------
-- Unit_FreePromotions
--------------------------------	
INSERT INTO Unit_FreePromotions 	
		(UnitType, 							PromotionType)
SELECT	('UNIT_DMS_PRESIDENTAL_DIVISION'), 	PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_MACHINE_GUN');

INSERT INTO Unit_FreePromotions 
		(UnitType, 								PromotionType)
VALUES	('UNIT_DMS_PRESIDENTAL_DIVISION', 		'PROMOTION_DMS_NEITHER_LEFT_NOR_RIGHT');
--------------------------------
-- Unit_ClassUpgrades
--------------------------------	
INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 							UnitClassType)
SELECT	('UNIT_DMS_PRESIDENTAL_DIVISION'),	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_MACHINE_GUN');
--==========================================================================================================================	
-- PROMOTIONS
--==========================================================================================================================	
-- UnitPromotions
------------------------------ 
INSERT INTO UnitPromotions 
		(Type, 										CapitalDefenseModifier,	CapitalDefenseFalloff,	Description, 									Help, 													Sound, 				CannotBeChosen, PortraitIndex,  IconAtlas, 			PediaType, 			PediaEntry)
VALUES	('PROMOTION_DMS_NEITHER_LEFT_NOR_RIGHT',	25,						-5,						'TXT_KEY_PROMOTION_DMS_NEITHER_LEFT_NOR_RIGHT',	'TXT_KEY_PROMOTION_DMS_NEITHER_LEFT_NOR_RIGHT_HELP',	'AS2D_IF_LEVELUP', 	1, 				59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_DMS_NEITHER_LEFT_NOR_RIGHT_HELP');
------------------------------
-- UnitPromotions_UnitCombats
------------------------------
INSERT INTO UnitPromotions_UnitCombats 
		(PromotionType, 							UnitCombatType)
VALUES	('PROMOTION_DMS_NEITHER_LEFT_NOR_RIGHT',	'UNITCOMBAT_ARCHER');
--==========================================================================================================================	
-- LEADERS
--==========================================================================================================================	
-- Leaders
--------------------------------			
INSERT INTO Leaders 
		(Type, 					Description, 					Civilopedia, 						CivilopediaTag, 							ArtDefineTag, 		VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 				PortraitIndex)
VALUES	('LEADER_DMS_MOBUTU', 	'TXT_KEY_LEADER_DMS_MOBUTU', 	'TXT_KEY_LEADER_DMS_MOBUTU_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_DMS_MOBUTU', 	'DMS_Mobutu.xml',	9, 						5, 						8, 							7, 			4, 				2, 				6, 						6, 				4, 			2, 			4, 				4, 			6, 			'DMS_ZAIRE_ATLAS',		1);
--------------------------------		
-- Leader_MajorCivApproachBiases
--------------------------------						
INSERT INTO Leader_MajorCivApproachBiases 
		(LeaderType, 				MajorCivApproachType, 				Bias)
VALUES	('LEADER_DMS_MOBUTU', 		'MAJOR_CIV_APPROACH_WAR', 			3),
		('LEADER_DMS_MOBUTU', 		'MAJOR_CIV_APPROACH_HOSTILE', 		6),
		('LEADER_DMS_MOBUTU', 		'MAJOR_CIV_APPROACH_DECEPTIVE', 	4),
		('LEADER_DMS_MOBUTU', 		'MAJOR_CIV_APPROACH_GUARDED', 		6),
		('LEADER_DMS_MOBUTU', 		'MAJOR_CIV_APPROACH_AFRAID', 		6),
		('LEADER_DMS_MOBUTU', 		'MAJOR_CIV_APPROACH_FRIENDLY', 		5),
		('LEADER_DMS_MOBUTU', 		'MAJOR_CIV_APPROACH_NEUTRAL', 		6);
--------------------------------	
-- Leader_MajorCivApproachBiases
--------------------------------							
INSERT INTO Leader_MinorCivApproachBiases 
		(LeaderType, 				MinorCivApproachType, 				Bias)
VALUES	('LEADER_DMS_MOBUTU', 		'MINOR_CIV_APPROACH_IGNORE', 		3),
		('LEADER_DMS_MOBUTU', 		'MINOR_CIV_APPROACH_FRIENDLY', 		6),
		('LEADER_DMS_MOBUTU', 		'MINOR_CIV_APPROACH_PROTECTIVE', 	6),
		('LEADER_DMS_MOBUTU', 		'MINOR_CIV_APPROACH_CONQUEST', 		5),
		('LEADER_DMS_MOBUTU', 		'MINOR_CIV_APPROACH_BULLY', 		4);
--------------------------------	
-- Leader_Flavors
--------------------------------							
INSERT INTO Leader_Flavors 
		(LeaderType, 				FlavorType, 						Flavor)
VALUES	('LEADER_DMS_MOBUTU', 		'FLAVOR_OFFENSE', 					4),
		('LEADER_DMS_MOBUTU', 		'FLAVOR_DEFENSE', 					6),
		('LEADER_DMS_MOBUTU', 		'FLAVOR_CITY_DEFENSE', 				7),
		('LEADER_DMS_MOBUTU', 		'FLAVOR_MILITARY_TRAINING', 		5),
		('LEADER_DMS_MOBUTU', 		'FLAVOR_RECON', 					7),
		('LEADER_DMS_MOBUTU', 		'FLAVOR_RANGED', 					6),
		('LEADER_DMS_MOBUTU', 		'FLAVOR_MOBILE', 					5),
		('LEADER_DMS_MOBUTU', 		'FLAVOR_NAVAL', 					5),
		('LEADER_DMS_MOBUTU', 		'FLAVOR_NAVAL_RECON', 				6),
		('LEADER_DMS_MOBUTU', 		'FLAVOR_NAVAL_GROWTH', 				4),
		('LEADER_DMS_MOBUTU', 		'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	4),
		('LEADER_DMS_MOBUTU', 		'FLAVOR_AIR', 						7),
		('LEADER_DMS_MOBUTU', 		'FLAVOR_EXPANSION', 				5),
		('LEADER_DMS_MOBUTU', 		'FLAVOR_GROWTH', 					6),
		('LEADER_DMS_MOBUTU', 		'FLAVOR_TILE_IMPROVEMENT', 			8),
		('LEADER_DMS_MOBUTU', 		'FLAVOR_INFRASTRUCTURE', 			6),
		('LEADER_DMS_MOBUTU', 		'FLAVOR_PRODUCTION', 				7),
		('LEADER_DMS_MOBUTU', 		'FLAVOR_GOLD', 						5),
		('LEADER_DMS_MOBUTU', 		'FLAVOR_SCIENCE', 					5),
		('LEADER_DMS_MOBUTU', 		'FLAVOR_CULTURE', 					7),
		('LEADER_DMS_MOBUTU', 		'FLAVOR_HAPPINESS', 				7),
		('LEADER_DMS_MOBUTU', 		'FLAVOR_GREAT_PEOPLE', 				4),
		('LEADER_DMS_MOBUTU', 		'FLAVOR_WONDER', 					4),
		('LEADER_DMS_MOBUTU', 		'FLAVOR_RELIGION', 					3),
		('LEADER_DMS_MOBUTU', 		'FLAVOR_DIPLOMACY', 				9),
		('LEADER_DMS_MOBUTU', 		'FLAVOR_SPACESHIP', 				6),
		('LEADER_DMS_MOBUTU', 		'FLAVOR_WATER_CONNECTION', 			3),
		('LEADER_DMS_MOBUTU', 		'FLAVOR_NUKE', 						2),
		('LEADER_DMS_MOBUTU', 		'FLAVOR_USE_NUKE', 					7),
		('LEADER_DMS_MOBUTU', 		'FLAVOR_ESPIONAGE', 				7),
		('LEADER_DMS_MOBUTU', 		'FLAVOR_AIRLIFT', 					5),
		('LEADER_DMS_MOBUTU', 		'FLAVOR_I_TRADE_DESTINATION', 		5),
		('LEADER_DMS_MOBUTU', 		'FLAVOR_I_TRADE_ORIGIN', 			5),
		('LEADER_DMS_MOBUTU', 		'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
		('LEADER_DMS_MOBUTU', 		'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
		('LEADER_DMS_MOBUTU', 		'FLAVOR_ARCHAEOLOGY', 				5),
		('LEADER_DMS_MOBUTU', 		'FLAVOR_AIR_CARRIER', 				5);
--------------------------------	
-- Leader_Traits
--------------------------------	
INSERT INTO Leader_Traits 
		(LeaderType, 				TraitType)
VALUES	('LEADER_DMS_MOBUTU', 		'TRAIT_DMS_AUTHENTICITE');
--==========================================================================================================================	
-- TRAITS
--==========================================================================================================================	
-- Traits
--------------------------------	
INSERT INTO Traits 
		(Type, 							Description, 						ShortDescription)
VALUES	('TRAIT_DMS_AUTHENTICITE', 		'TXT_KEY_TRAIT_DMS_AUTHENTICITE', 	'TXT_KEY_TRAIT_DMS_AUTHENTICITE_SHORT');	
--==========================================================================================================================	
-- CIVILIZATIONS
--==========================================================================================================================	
-- Civilizations
--------------------------------		
INSERT INTO Civilizations
		(Type, 						Description, 						ShortDescription,							Adjective,										CivilopediaTag,									DefaultPlayerColor,			ArtDefineTag,	ArtStyleType,	ArtStyleSuffix, ArtStylePrefix, PortraitIndex,	IconAtlas,				AlphaIconAtlas,				SoundtrackTag,	MapImage,					DawnOfManQuote,							DawnOfManImage)
SELECT	('CIVILIZATION_DMS_ZAIRE'),	('TXT_KEY_CIVILIZATION_DMS_ZAIRE'),	('TXT_KEY_CIVILIZATION_DMS_ZAIRE_SHORT'),	('TXT_KEY_CIVILIZATION_DMS_ZAIRE_ADJECTIVE'),	('TXT_KEY_CIVILOPEDIA_CIVILIZATIONS_DMS_ZAIRE'),('PLAYERCOLOR_DMS_ZAIRE'),	ArtDefineTag,	ArtStyleType,	ArtStyleSuffix, ArtStylePrefix, 0,				('DMS_ZAIRE_ATLAS'),	('DMS_ZAIRE_ALPHA_ATLAS'),	('Zulu'),		('DMS_Zaire_Map512.dds'), 	('TXT_KEY_CIV5_DAWN_DMS_ZAIRE_TEXT'), 	('DMS_Mobutu_DOM.dds')
FROM Civilizations WHERE (Type = 'CIVILIZATION_ZULU');
--------------------------------	
-- Civilization_CityNames
--------------------------------	
INSERT INTO Civilization_CityNames
        (CivilizationType,				CityName)
VALUES	('CIVILIZATION_DMS_ZAIRE', 	 	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_ZAIRE_1'),
        ('CIVILIZATION_DMS_ZAIRE',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_ZAIRE_2'),
        ('CIVILIZATION_DMS_ZAIRE',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_ZAIRE_3'),
        ('CIVILIZATION_DMS_ZAIRE',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_ZAIRE_4'),
        ('CIVILIZATION_DMS_ZAIRE',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_ZAIRE_5'),
        ('CIVILIZATION_DMS_ZAIRE',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_ZAIRE_6'),
        ('CIVILIZATION_DMS_ZAIRE',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_ZAIRE_7'),
        ('CIVILIZATION_DMS_ZAIRE',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_ZAIRE_8'),
        ('CIVILIZATION_DMS_ZAIRE',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_ZAIRE_9'),
        ('CIVILIZATION_DMS_ZAIRE',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_ZAIRE_10'),
        ('CIVILIZATION_DMS_ZAIRE',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_ZAIRE_11'),
        ('CIVILIZATION_DMS_ZAIRE',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_ZAIRE_12'),
        ('CIVILIZATION_DMS_ZAIRE',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_ZAIRE_13'),
        ('CIVILIZATION_DMS_ZAIRE',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_ZAIRE_14'),
        ('CIVILIZATION_DMS_ZAIRE',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_ZAIRE_15'),
        ('CIVILIZATION_DMS_ZAIRE',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_ZAIRE_16'),
        ('CIVILIZATION_DMS_ZAIRE',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_ZAIRE_17'),
        ('CIVILIZATION_DMS_ZAIRE',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_ZAIRE_18'),
        ('CIVILIZATION_DMS_ZAIRE',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_ZAIRE_19'),
        ('CIVILIZATION_DMS_ZAIRE',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_ZAIRE_20'),
        ('CIVILIZATION_DMS_ZAIRE',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_ZAIRE_21'),
        ('CIVILIZATION_DMS_ZAIRE',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_ZAIRE_22'),
        ('CIVILIZATION_DMS_ZAIRE',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_ZAIRE_23'),
        ('CIVILIZATION_DMS_ZAIRE',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_ZAIRE_24'),
        ('CIVILIZATION_DMS_ZAIRE',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_ZAIRE_25'),
        ('CIVILIZATION_DMS_ZAIRE',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_ZAIRE_26'),
        ('CIVILIZATION_DMS_ZAIRE',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_ZAIRE_27'),
        ('CIVILIZATION_DMS_ZAIRE',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_ZAIRE_28'),
        ('CIVILIZATION_DMS_ZAIRE',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_ZAIRE_29'),
        ('CIVILIZATION_DMS_ZAIRE',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_ZAIRE_30'),
        ('CIVILIZATION_DMS_ZAIRE',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_ZAIRE_31'),
        ('CIVILIZATION_DMS_ZAIRE',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_ZAIRE_32'),
        ('CIVILIZATION_DMS_ZAIRE',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_ZAIRE_33'),
        ('CIVILIZATION_DMS_ZAIRE',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_ZAIRE_34'),
        ('CIVILIZATION_DMS_ZAIRE',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_ZAIRE_35'),
        ('CIVILIZATION_DMS_ZAIRE',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_ZAIRE_36'),
        ('CIVILIZATION_DMS_ZAIRE',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_ZAIRE_37'),
        ('CIVILIZATION_DMS_ZAIRE',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_ZAIRE_38'),
        ('CIVILIZATION_DMS_ZAIRE',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_ZAIRE_39'),
        ('CIVILIZATION_DMS_ZAIRE',   	'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_ZAIRE_40');			
--------------------------------		
-- Civilization_FreeBuildingClasses
--------------------------------			
INSERT INTO Civilization_FreeBuildingClasses 
		(CivilizationType, 					BuildingClassType)
SELECT	('CIVILIZATION_DMS_ZAIRE'), 		BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_ZULU');
--------------------------------	
-- Civilization_FreeTechs
--------------------------------		
INSERT INTO Civilization_FreeTechs 
		(CivilizationType, 					TechType)
SELECT	('CIVILIZATION_DMS_ZAIRE'), 		TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_ZULU');
--------------------------------	
-- Civilization_FreeUnits
--------------------------------		
INSERT INTO Civilization_FreeUnits 
		(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT	('CIVILIZATION_DMS_ZAIRE'), 		UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_ZULU');
--------------------------------	
-- Civilization_Leaders
--------------------------------
INSERT INTO Civilization_Leaders 
		(CivilizationType, 				LeaderheadType)
VALUES	('CIVILIZATION_DMS_ZAIRE',		'LEADER_DMS_MOBUTU');
--------------------------------	
-- Civilization_UnitClassOverrides 
--------------------------------
INSERT INTO Civilization_UnitClassOverrides 
		(CivilizationType, 				UnitClassType, 						UnitType)
VALUES	('CIVILIZATION_DMS_ZAIRE', 		'UNITCLASS_MACHINE_GUN',			'UNIT_DMS_PRESIDENTAL_DIVISION');
--------------------------------	
-- Civilization_BuildingClassOverrides 
--------------------------------
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 				BuildingClassType, 					BuildingType)
VALUES	('CIVILIZATION_DMS_ZAIRE', 		'BUILDINGCLASS_RECYCLING_CENTER', 	'BUILDING_DMS_GECAMINES_FACILITY');
--------------------------------	
--------------------------------	
-- Civilization_SpyNames
--------------------------------
INSERT INTO Civilization_SpyNames 
		(CivilizationType, 			SpyName)
VALUES	('CIVILIZATION_DMS_ZAIRE', 	'TXT_KEY_SPY_NAME_DMS_ZAIRE_0'),	
		('CIVILIZATION_DMS_ZAIRE', 	'TXT_KEY_SPY_NAME_DMS_ZAIRE_1'),
		('CIVILIZATION_DMS_ZAIRE', 	'TXT_KEY_SPY_NAME_DMS_ZAIRE_2'),
		('CIVILIZATION_DMS_ZAIRE', 	'TXT_KEY_SPY_NAME_DMS_ZAIRE_3'),
		('CIVILIZATION_DMS_ZAIRE', 	'TXT_KEY_SPY_NAME_DMS_ZAIRE_4'),
		('CIVILIZATION_DMS_ZAIRE', 	'TXT_KEY_SPY_NAME_DMS_ZAIRE_5'),
		('CIVILIZATION_DMS_ZAIRE', 	'TXT_KEY_SPY_NAME_DMS_ZAIRE_6'),
		('CIVILIZATION_DMS_ZAIRE', 	'TXT_KEY_SPY_NAME_DMS_ZAIRE_7'),
		('CIVILIZATION_DMS_ZAIRE', 	'TXT_KEY_SPY_NAME_DMS_ZAIRE_8'),
		('CIVILIZATION_DMS_ZAIRE', 	'TXT_KEY_SPY_NAME_DMS_ZAIRE_9');
--------------------------------	
-- Civilization_Start_Region_Priority 
--------------------------------		
INSERT INTO Civilization_Start_Region_Priority 
		(CivilizationType, 			RegionType)
VALUES	('CIVILIZATION_DMS_ZAIRE', 	'REGION_HILLS');
--==========================================================================================================================
--==========================================================================================================================