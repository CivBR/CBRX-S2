--=======================================================================================================================
-- BUILDINGCLASSES
--=======================================================================================================================
-- BuildingClasses
------------------------------	
INSERT INTO BuildingClasses 	
			(Type, 						 		 	DefaultBuilding, 			Description)
VALUES		('BUILDINGCLASS_JFD_USSR_LENIN', 		'BUILDING_JFD_LENIN_FOOD', 	'TXT_KEY_BUILDING_JFD_LENIN_FOOD');
--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================	
-- Buildings
------------------------------	
INSERT INTO Buildings 	
			(Type, 									BuildingClass, Cost, GoldMaintenance, PrereqTech, Description, 									Civilopedia, 									Help, 												Strategy,								 				ArtDefineTag, 	MinAreaSize, NeverCapture, Espionage, EspionageModifier, HurryCostModifier, PortraitIndex, 	IconAtlas)
SELECT		('BUILDING_JFD_LENIN_COMMISSARIAT'),	BuildingClass, Cost, GoldMaintenance, PrereqTech, ('TXT_KEY_BUILDING_JFD_LENIN_COMMISSARIAT'), 	('TXT_KEY_CIV5_JFD_LENIN_COMMISSARIAT_TEXT'), 	('TXT_KEY_BUILDING_JFD_LENIN_COMMISSARIAT_HELP'), 	('TXT_KEY_BUILDING_JFD_LENIN_COMMISSARIAT_STRATEGY'),	ArtDefineTag,	MinAreaSize, NeverCapture, Espionage, EspionageModifier, HurryCostModifier, 2, 				('JFD_USSR_LENIN_ATLAS')
FROM Buildings WHERE (Type = 'BUILDING_CONSTABLE');	

INSERT INTO Buildings 	
			(Type, 									EnhancedYieldTech,		TechEnhancedTourism,	BuildingClass, Cost, GoldMaintenance, PrereqTech, Description,	Civilopedia, Help,										Strategy,									ArtDefineTag, 	MinAreaSize, ConquestProb, Happiness,HurryCostModifier, PortraitIndex, 	IconAtlas)
SELECT		('BUILDING_JFD_LENIN_STONE_WORKS'),		('TECH_AGRICULTURE'),	2,						BuildingClass, Cost, GoldMaintenance, PrereqTech, Description,	Civilopedia, ('TXT_KEY_JFD_LENIN_STONE_WORKS_HELP'),	('TXT_KEY_JFD_LENIN_STONE_WORKS_STRATEGY'),	ArtDefineTag,	MinAreaSize, ConquestProb, Happiness,HurryCostModifier, PortraitIndex, 	IconAtlas
FROM Buildings WHERE (Type = 'BUILDING_STONE_WORKS');	

INSERT INTO Buildings 	
			(Type, 									EnhancedYieldTech,		TechEnhancedTourism,	BuildingClass, Cost, GoldMaintenance, PrereqTech, Description,	Civilopedia, Help,								Strategy,								ArtDefineTag, 	MinAreaSize, ConquestProb, AllowsProductionTradeRoutes, SpecialistCount, SpecialistType, HurryCostModifier, PortraitIndex, IconAtlas)
SELECT		('BUILDING_JFD_LENIN_FORGE'),			('TECH_AGRICULTURE'),	2,						BuildingClass, Cost, GoldMaintenance, PrereqTech, Description,	Civilopedia, ('TXT_KEY_JFD_LENIN_FORGE_HELP'),	('TXT_KEY_JFD_LENIN_FORGE_STRATEGY'),	ArtDefineTag,	MinAreaSize, ConquestProb, AllowsProductionTradeRoutes, SpecialistCount, SpecialistType, HurryCostModifier, PortraitIndex, IconAtlas
FROM Buildings WHERE (Type = 'BUILDING_FORGE');	

INSERT INTO Buildings 	
			(Type, 									EnhancedYieldTech,		TechEnhancedTourism,	BuildingClass, Cost, GoldMaintenance, PrereqTech, Description,	Civilopedia, Help,									Strategy,									ArtDefineTag, 	MinAreaSize, ConquestProb, BuildingProductionModifier, SpecialistCount, SpecialistType, HurryCostModifier, PortraitIndex, IconAtlas)
SELECT		('BUILDING_JFD_LENIN_WINDMILL'),		('TECH_AGRICULTURE'),	2,						BuildingClass, Cost, GoldMaintenance, PrereqTech, Description,	Civilopedia, ('TXT_KEY_JFD_LENIN_WINDMILL_HELP'),	('TXT_KEY_JFD_LENIN_WINDMILL_STRATEGY'),	ArtDefineTag,	MinAreaSize, ConquestProb, BuildingProductionModifier, SpecialistCount, SpecialistType, HurryCostModifier, PortraitIndex, IconAtlas
FROM Buildings WHERE (Type = 'BUILDING_WINDMILL');	

INSERT INTO Buildings 	
			(Type, 									EnhancedYieldTech,		TechEnhancedTourism,	BuildingClass, Cost, GoldMaintenance, PrereqTech, Description,	Civilopedia, Strategy,									ArtDefineTag, 	MinAreaSize, ConquestProb, XBuiltTriggersIdeologyChoice, SpecialistCount, SpecialistType, HurryCostModifier, PortraitIndex, IconAtlas)
SELECT		('BUILDING_JFD_LENIN_FACTORY'),			('TECH_AGRICULTURE'),	2,						BuildingClass, Cost, GoldMaintenance, PrereqTech, Description,	Civilopedia, ('TXT_KEY_JFD_LENIN_FACTORY_STRATEGY'),	ArtDefineTag,	MinAreaSize, ConquestProb, XBuiltTriggersIdeologyChoice, SpecialistCount, SpecialistType, HurryCostModifier, PortraitIndex, IconAtlas
FROM Buildings WHERE (Type = 'BUILDING_FACTORY');	

INSERT INTO Buildings 	
			(Type, 						BuildingClass, 					FoodKept,	GreatWorkCount, Cost, FaithCost, PrereqTech, Description, 						Help)
VALUES		('BUILDING_JFD_LENIN_FOOD', 'BUILDINGCLASS_JFD_USSR_LENIN', 1,			-1, 			-1,   -1, 		 null, 		 'TXT_KEY_BUILDING_JFD_LENIN_FOOD', 'TXT_KEY_BUILDING_JFD_LENIN_FOOD_HELP');
------------------------------	
-- Building_ClassesNeededInCity
------------------------------		
INSERT INTO Building_ClassesNeededInCity 	
			(BuildingType, 					BuildingClassType)
SELECT		('BUILDING_JFD_LENIN_FACTORY'),	BuildingClassType
FROM Building_ClassesNeededInCity WHERE (BuildingType = 'BUILDING_FACTORY');	
------------------------------	
-- Building_Flavors
------------------------------		
INSERT INTO Building_Flavors 	
			(BuildingType, 							FlavorType, Flavor)
SELECT		('BUILDING_JFD_LENIN_COMMISSARIAT'),	FlavorType, Flavor
FROM Building_Flavors WHERE (BuildingType = 'BUILDING_CONSTABLE');	
		
INSERT INTO Building_Flavors 	
			(BuildingType, 							FlavorType, Flavor)
SELECT		('BUILDING_JFD_LENIN_STONE_WORKS'),		FlavorType, Flavor
FROM Building_Flavors WHERE (BuildingType = 'BUILDING_STONE_WORKS');	

INSERT INTO Building_Flavors 	
			(BuildingType, 							FlavorType, Flavor)
SELECT		('BUILDING_JFD_LENIN_FORGE'),			FlavorType, Flavor
FROM Building_Flavors WHERE (BuildingType = 'BUILDING_FORGE');	

INSERT INTO Building_Flavors 	
			(BuildingType, 							FlavorType, Flavor)
SELECT		('BUILDING_JFD_LENIN_FACTORY'),			FlavorType, Flavor
FROM Building_Flavors WHERE (BuildingType = 'BUILDING_FACTORY');	

INSERT INTO Building_Flavors 
			(BuildingType, 							FlavorType, 		Flavor)
VALUES		('BUILDING_JFD_LENIN_COMMISSARIAT', 	'FLAVOR_GROWTH', 	50);	
------------------------------	
-- Building_ResourceYieldChanges
------------------------------		
INSERT INTO Building_ResourceYieldChanges 	
			(BuildingType, 						ResourceType,	YieldType, Yield)
SELECT		('BUILDING_JFD_LENIN_STONE_WORKS'),	ResourceType,	YieldType, Yield
FROM Building_ResourceYieldChanges WHERE (BuildingType = 'BUILDING_STONE_WORKS');	

INSERT INTO Building_ResourceYieldChanges 	
			(BuildingType, 						ResourceType,	YieldType, Yield)
SELECT		('BUILDING_JFD_LENIN_FORGE'),		ResourceType,	YieldType, Yield
FROM Building_ResourceYieldChanges WHERE (BuildingType = 'BUILDING_FORGE');	
------------------------------	
-- Building_YieldChanges
------------------------------		
INSERT INTO Building_YieldChanges 	
			(BuildingType, 						YieldType, Yield)
SELECT		('BUILDING_JFD_LENIN_STONE_WORKS'),	YieldType, Yield
FROM Building_YieldChanges WHERE (BuildingType = 'BUILDING_STONE_WORKS');	

INSERT INTO Building_YieldChanges 	
			(BuildingType, 						YieldType, Yield)
SELECT		('BUILDING_JFD_LENIN_WINDMILL'),	YieldType, Yield
FROM Building_YieldChanges WHERE (BuildingType = 'BUILDING_WINDMILL');	

INSERT INTO Building_YieldChanges 	
			(BuildingType, 						YieldType, Yield)
SELECT		('BUILDING_JFD_LENIN_FACTORY'),		YieldType, Yield
FROM Building_YieldChanges WHERE (BuildingType = 'BUILDING_FACTORY');	
------------------------------	
-- Building_YieldModifiers
------------------------------		
INSERT INTO Building_YieldModifiers 	
			(BuildingType, 						YieldType, Yield)
SELECT		('BUILDING_JFD_LENIN_FACTORY'),		YieldType, Yield
FROM Building_YieldModifiers WHERE (BuildingType = 'BUILDING_FACTORY');	
------------------------------	
-- Building_DomainProductionModifiers
------------------------------		
INSERT INTO Building_DomainProductionModifiers 	
			(BuildingType, 						DomainType, Modifier)
SELECT		('BUILDING_JFD_LENIN_FORGE'),		DomainType, Modifier
FROM Building_DomainProductionModifiers WHERE (BuildingType = 'BUILDING_FORGE');		
--==========================================================================================================================	
-- LEADERS
--==========================================================================================================================	
-- Leaders
--------------------------------			
INSERT INTO Leaders 
			(Type, 					Description, 					Civilopedia, 						CivilopediaTag, 							ArtDefineTag, 		VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 				PortraitIndex)
VALUES		('LEADER_JFD_LENIN', 	'TXT_KEY_LEADER_JFD_LENIN', 	'TXT_KEY_LEADER_JFD_LENIN_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_JFD_LENIN', 	'Lenin_Scene.xml',	4, 						3, 						6, 							7, 			5, 				8, 				7, 						2, 				2, 			6, 			2, 				3, 			2, 			'JFD_USSR_LENIN_ATLAS', 1);
--------------------------------		
-- Leader_MajorCivApproachBiases
--------------------------------						
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 			MajorCivApproachType, 				Bias)
VALUES		('LEADER_JFD_LENIN', 	'MAJOR_CIV_APPROACH_WAR', 			3),
			('LEADER_JFD_LENIN', 	'MAJOR_CIV_APPROACH_HOSTILE', 		4),
			('LEADER_JFD_LENIN', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	8),
			('LEADER_JFD_LENIN', 	'MAJOR_CIV_APPROACH_GUARDED', 		8),
			('LEADER_JFD_LENIN', 	'MAJOR_CIV_APPROACH_AFRAID', 		4),
			('LEADER_JFD_LENIN', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		4),
			('LEADER_JFD_LENIN', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		3);
--------------------------------	
-- Leader_MajorCivApproachBiases
--------------------------------							
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 			MinorCivApproachType, 				Bias)
VALUES		('LEADER_JFD_LENIN', 	'MINOR_CIV_APPROACH_IGNORE', 		3),
			('LEADER_JFD_LENIN', 	'MINOR_CIV_APPROACH_FRIENDLY', 		4),
			('LEADER_JFD_LENIN', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	8),
			('LEADER_JFD_LENIN', 	'MINOR_CIV_APPROACH_CONQUEST', 		3),
			('LEADER_JFD_LENIN', 	'MINOR_CIV_APPROACH_BULLY', 		4);
--------------------------------	
-- Leader_Flavors
--------------------------------							
INSERT INTO Leader_Flavors 
			(LeaderType, 			FlavorType, 						Flavor)
VALUES		('LEADER_JFD_LENIN', 	'FLAVOR_OFFENSE', 					5),
			('LEADER_JFD_LENIN', 	'FLAVOR_DEFENSE', 					5),
			('LEADER_JFD_LENIN', 	'FLAVOR_CITY_DEFENSE', 				4),
			('LEADER_JFD_LENIN', 	'FLAVOR_MILITARY_TRAINING', 		5),
			('LEADER_JFD_LENIN', 	'FLAVOR_RECON', 					4),
			('LEADER_JFD_LENIN', 	'FLAVOR_RANGED', 					4),
			('LEADER_JFD_LENIN', 	'FLAVOR_MOBILE', 					3),
			('LEADER_JFD_LENIN', 	'FLAVOR_NAVAL', 					3),
			('LEADER_JFD_LENIN', 	'FLAVOR_NAVAL_RECON', 				2),
			('LEADER_JFD_LENIN', 	'FLAVOR_NAVAL_GROWTH', 				2),
			('LEADER_JFD_LENIN', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	2),
			('LEADER_JFD_LENIN', 	'FLAVOR_AIR', 						4),
			('LEADER_JFD_LENIN', 	'FLAVOR_EXPANSION', 				4),
			('LEADER_JFD_LENIN', 	'FLAVOR_GROWTH', 					8),
			('LEADER_JFD_LENIN', 	'FLAVOR_TILE_IMPROVEMENT', 			7),
			('LEADER_JFD_LENIN', 	'FLAVOR_INFRASTRUCTURE', 			7),
			('LEADER_JFD_LENIN', 	'FLAVOR_PRODUCTION', 				7),
			('LEADER_JFD_LENIN', 	'FLAVOR_GOLD', 						3),
			('LEADER_JFD_LENIN', 	'FLAVOR_SCIENCE', 					3),
			('LEADER_JFD_LENIN', 	'FLAVOR_CULTURE', 					4),
			('LEADER_JFD_LENIN', 	'FLAVOR_HAPPINESS', 				6),
			('LEADER_JFD_LENIN', 	'FLAVOR_GREAT_PEOPLE', 				2),
			('LEADER_JFD_LENIN', 	'FLAVOR_WONDER', 					2),
			('LEADER_JFD_LENIN', 	'FLAVOR_RELIGION', 					0),
			('LEADER_JFD_LENIN', 	'FLAVOR_DIPLOMACY', 				2),
			('LEADER_JFD_LENIN', 	'FLAVOR_SPACESHIP', 				4),
			('LEADER_JFD_LENIN', 	'FLAVOR_WATER_CONNECTION', 			3),
			('LEADER_JFD_LENIN', 	'FLAVOR_NUKE', 						2),
			('LEADER_JFD_LENIN', 	'FLAVOR_USE_NUKE', 					2),
			('LEADER_JFD_LENIN', 	'FLAVOR_ESPIONAGE', 				6),
			('LEADER_JFD_LENIN', 	'FLAVOR_AIRLIFT', 					1),
			('LEADER_JFD_LENIN', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_JFD_LENIN', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_JFD_LENIN', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_JFD_LENIN', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_JFD_LENIN', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_JFD_LENIN', 	'FLAVOR_AIR_CARRIER', 				5);
--------------------------------	
-- Leader_Traits
--------------------------------	
INSERT INTO Leader_Traits 
			(LeaderType, 			TraitType)
VALUES		('LEADER_JFD_LENIN', 	'TRAIT_JFD_USSR_LENIN');
--==========================================================================================================================	
-- TRAITS
--==========================================================================================================================	
-- Traits
--------------------------------	
INSERT INTO Traits 
			(Type, 							Description, 						ShortDescription,						WorkerSpeedModifier)
VALUES		('TRAIT_JFD_USSR_LENIN', 		'TXT_KEY_TRAIT_JFD_USSR_LENIN', 	'TXT_KEY_TRAIT_JFD_USSR_LENIN_SHORT',	20);
--==========================================================================================================================	
-- PROMOTIONS
--==========================================================================================================================	
-- UnitPromotions
------------------------------
INSERT INTO UnitPromotions 
			(Type, 							EnemyRoute, Description, 								Help, 											Sound, 				CannotBeChosen, PortraitIndex, 	IconAtlas, 			PediaType, 			PediaEntry)
VALUES		('PROMOTION_JFD_LENIN_LEVY', 	1,			'TXT_KEY_PROMOTION_JFD_LENIN_LEVY', 		'TXT_KEY_PROMOTION_JFD_LENIN_LEVY_HELP',		'AS2D_IF_LEVELUP', 	1, 				59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_LENIN_LEVY');
--==========================================================================================================================	
-- UNITS
--==========================================================================================================================
-- Units
--------------------------------	
INSERT INTO Units 	
			(Class, 	Type, 						PrereqTech, Combat,		Cost,		FaithCost, RequiresFaithPurchaseEnabled, Moves, CombatClass, Domain, DefaultUnitAI, Description, 						Civilopedia, 							Strategy, 									Help, 									Pillage, MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, AdvancedStartCost, CombatLimit, XPValueDefense, UnitArtInfoEraVariation, UnitArtInfo, 						UnitFlagIconOffset, UnitFlagAtlas,						PortraitIndex, 	IconAtlas)
SELECT		Class,		('UNIT_JFD_LENIN_LEVY'), 	PrereqTech, Combat-2,	Cost-50,	FaithCost, RequiresFaithPurchaseEnabled, Moves, CombatClass, Domain, DefaultUnitAI, ('TXT_KEY_UNIT_JFD_LENIN_LEVY'), 	('TXT_KEY_CIV5_JFD_LENIN_LEVY_TEXT'), 	('TXT_KEY_UNIT_JFD_LENIN_LEVY_STRATEGY'), 	('TXT_KEY_UNIT_HELP_JFD_LENIN_LEVY'), 	Pillage, MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, AdvancedStartCost, CombatLimit, XPValueDefense, UnitArtInfoEraVariation, ('ART_DEF_UNIT_JFD_LENIN_LEVY'), 	0,					('JFD_LENIN_LEVY_FLAG_ART_ATLAS'),	3, 				('JFD_USSR_LENIN_ATLAS')
FROM Units WHERE (Type = 'UNIT_GREAT_WAR_INFANTRY');
--------------------------------	
-- UnitGameplay2DScripts
--------------------------------		
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT		('UNIT_JFD_LENIN_LEVY'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_GREAT_WAR_INFANTRY');	
--------------------------------		
-- Unit_AITypes
--------------------------------		
INSERT INTO Unit_AITypes 	
			(UnitType, 					UnitAIType)
SELECT		('UNIT_JFD_LENIN_LEVY'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_GREAT_WAR_INFANTRY');	
--------------------------------	
-- Unit_ClassUpgrades
--------------------------------	
INSERT INTO Unit_ClassUpgrades 	
			(UnitType, 					UnitClassType)
SELECT		('UNIT_JFD_LENIN_LEVY'), 	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_GREAT_WAR_INFANTRY');		
--------------------------------	
-- Unit_Flavors
--------------------------------		
INSERT INTO Unit_Flavors 	
			(UnitType, 					FlavorType, Flavor)
SELECT		('UNIT_JFD_LENIN_LEVY'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_GREAT_WAR_INFANTRY');	
--------------------------------	
-- Unit_FreePromotions
--------------------------------	
INSERT INTO Unit_FreePromotions
			(UnitType, 					PromotionType)
VALUES		('UNIT_JFD_LENIN_LEVY', 	'PROMOTION_JFD_LENIN_LEVY');
--==========================================================================================================================	
-- CIVILIZATIONS
--==========================================================================================================================	
-- Civilizations
--------------------------------		
INSERT INTO Civilizations
			(Type, 								Description, 							ShortDescription, 							Adjective, 									Civilopedia, CivilopediaTag, DefaultPlayerColor, 			 ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, 				PortraitIndex, 	AlphaIconAtlas, 				SoundtrackTag, 	MapImage, 					DawnOfManQuote, 						DawnOfManImage)
SELECT		('CIVILIZATION_JFD_USSR_LENIN'), 	('TXT_KEY_CIV_JFD_USSR_LENIN_DESC'), 	('TXT_KEY_CIV_JFD_USSR_LENIN_SHORT_DESC'), 	('TXT_KEY_CIV_JFD_USSR_LENIN_ADJECTIVE'),	Civilopedia, CivilopediaTag, ('PLAYERCOLOR_JFD_USSR_LENIN'), ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('JFD_USSR_LENIN_ATLAS'), 	0, 				('JFD_USSR_LENIN_ALPHA_ATLAS'), ('Russia'), 	('LeninUSSRMap512.dds'), 	('TXT_KEY_CIV_JFD_LENIN_USSR_DAWN'), 	('Lenin_DOM.dds')
FROM Civilizations WHERE (Type = 'CIVILIZATION_RUSSIA');
--------------------------------	
-- Civilization_CityNames
--------------------------------	
INSERT INTO Civilization_CityNames
			(CivilizationType, 					CityName)
VALUES		('CIVILIZATION_JFD_USSR_LENIN', 	'TXT_KEY_CITY_NAME_MOSCOW'),
			('CIVILIZATION_JFD_USSR_LENIN', 	'TXT_KEY_CITY_NAME_JFD_LENIN_PETROGRAD'),
			('CIVILIZATION_JFD_USSR_LENIN', 	'TXT_KEY_CITY_NAME_JFD_LENIN_KHARKOV'),
			('CIVILIZATION_JFD_USSR_LENIN', 	'TXT_KEY_CITY_NAME_JFD_LENIN_MINSK'),
			('CIVILIZATION_JFD_USSR_LENIN', 	'TXT_KEY_CITY_NAME_JFD_LENIN_KIEV'),
			('CIVILIZATION_JFD_USSR_LENIN', 	'TXT_KEY_CITY_NAME_JFD_LENIN_SIMBIRSK'),
			('CIVILIZATION_JFD_USSR_LENIN', 	'TXT_KEY_CITY_NAME_JFD_LENIN_SIMFEROPOL'),
			('CIVILIZATION_JFD_USSR_LENIN', 	'TXT_KEY_CITY_NAME_JFD_LENIN_ODESSA'),
			('CIVILIZATION_JFD_USSR_LENIN', 	'TXT_KEY_CITY_NAME_JFD_LENIN_BAKU'),
			('CIVILIZATION_JFD_USSR_LENIN', 	'TXT_KEY_CITY_NAME_JFD_LENIN_OMSK'),
			('CIVILIZATION_JFD_USSR_LENIN', 	'TXT_KEY_CITY_NAME_JFD_LENIN_UFA'),
			('CIVILIZATION_JFD_USSR_LENIN', 	'TXT_KEY_CITY_NAME_JFD_LENIN_YEKATERINBURG'),
			('CIVILIZATION_JFD_USSR_LENIN', 	'TXT_KEY_CITY_NAME_JFD_LENIN_KALUGA'),
			('CIVILIZATION_JFD_USSR_LENIN', 	'TXT_KEY_CITY_NAME_JFD_LENIN_SMOLENSK'),
			('CIVILIZATION_JFD_USSR_LENIN', 	'TXT_KEY_CITY_NAME_JFD_LENIN_ROSTOV_ON_DON'),
			('CIVILIZATION_JFD_USSR_LENIN', 	'TXT_KEY_CITY_NAME_JFD_LENIN_KRASNODAR'),
			('CIVILIZATION_JFD_USSR_LENIN', 	'TXT_KEY_CITY_NAME_JFD_LENIN_VLADIVOSTOK'),
			('CIVILIZATION_JFD_USSR_LENIN', 	'TXT_KEY_CITY_NAME_JFD_LENIN_NOVOSIBIRSK'),
			('CIVILIZATION_JFD_USSR_LENIN', 	'TXT_KEY_CITY_NAME_JFD_LENIN_KRASNOYARSK'),
			('CIVILIZATION_JFD_USSR_LENIN', 	'TXT_KEY_CITY_NAME_JFD_LENIN_CHELYABINSK'),
			('CIVILIZATION_JFD_USSR_LENIN', 	'TXT_KEY_CITY_NAME_JFD_LENIN_YEREVAN'),
			('CIVILIZATION_JFD_USSR_LENIN', 	'TXT_KEY_CITY_NAME_JFD_LENIN_SAMARA'),
			('CIVILIZATION_JFD_USSR_LENIN', 	'TXT_KEY_CITY_NAME_JFD_LENIN_TSARITSYN'),
			('CIVILIZATION_JFD_USSR_LENIN', 	'TXT_KEY_CITY_NAME_JFD_LENIN_YUZOVKA'),
			('CIVILIZATION_JFD_USSR_LENIN', 	'TXT_KEY_CITY_NAME_JFD_LENIN_IVANOVO'),
			('CIVILIZATION_JFD_USSR_LENIN', 	'TXT_KEY_CITY_NAME_JFD_LENIN_ALMA_ATA'),
			('CIVILIZATION_JFD_USSR_LENIN', 	'TXT_KEY_CITY_NAME_JFD_LENIN_FRUNZE'),
			('CIVILIZATION_JFD_USSR_LENIN', 	'TXT_KEY_CITY_NAME_JFD_LENIN_KHABAROVSK'),
			('CIVILIZATION_JFD_USSR_LENIN', 	'TXT_KEY_CITY_NAME_JFD_LENIN_AKMOLINSK'),
			('CIVILIZATION_JFD_USSR_LENIN', 	'TXT_KEY_CITY_NAME_JFD_LENIN_SEMIPALATINSK'),
			('CIVILIZATION_JFD_USSR_LENIN', 	'TXT_KEY_CITY_NAME_JFD_LENIN_ASHGABAT'),
			('CIVILIZATION_JFD_USSR_LENIN', 	'TXT_KEY_CITY_NAME_JFD_LENIN_DUSHANBE'),
			('CIVILIZATION_JFD_USSR_LENIN', 	'TXT_KEY_CITY_NAME_JFD_LENIN_NIKOLAYEVSK_ON_AMUR'),
			('CIVILIZATION_JFD_USSR_LENIN', 	'TXT_KEY_CITY_NAME_JFD_LENIN_ELEKTROSTAL'),
			('CIVILIZATION_JFD_USSR_LENIN', 	'TXT_KEY_CITY_NAME_JFD_LENIN_DETSKOE_SELO'),
			('CIVILIZATION_JFD_USSR_LENIN', 	'TXT_KEY_CITY_NAME_JFD_LENIN_LENINO'),
			('CIVILIZATION_JFD_USSR_LENIN', 	'TXT_KEY_CITY_NAME_JFD_LENIN_LENINABAD'),
			('CIVILIZATION_JFD_USSR_LENIN', 	'TXT_KEY_CITY_NAME_JFD_LENIN_ARZAMAS_16');
--------------------------------	
-- Civilization_FreeBuildingClasses
--------------------------------			
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 						BuildingClassType)
SELECT		('CIVILIZATION_JFD_USSR_LENIN'), 		BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_RUSSIA');
--------------------------------		
-- Civilization_FreeTechs
--------------------------------			
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 						TechType)
SELECT		('CIVILIZATION_JFD_USSR_LENIN'), 		TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_RUSSIA');
--------------------------------	
-- Civilization_FreeUnits
--------------------------------		
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 						UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_JFD_USSR_LENIN'),		UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_RUSSIA');
--------------------------------	
-- Civilization_Leaders
--------------------------------		
INSERT INTO Civilization_Leaders 
			(CivilizationType, 						LeaderheadType)
VALUES		('CIVILIZATION_JFD_USSR_LENIN', 		'LEADER_JFD_LENIN');
--------------------------------	
-- Civilization_UnitClassOverrides 
--------------------------------		
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 						UnitClassType, 						UnitType)
VALUES		('CIVILIZATION_JFD_USSR_LENIN', 		'UNITCLASS_GREAT_WAR_INFANTRY',		'UNIT_JFD_LENIN_LEVY');
--------------------------------	
-- Civilization_BuildingClassOverrides 
--------------------------------		
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 						BuildingClassType, 					BuildingType)
VALUES		('CIVILIZATION_JFD_USSR_LENIN', 		'BUILDINGCLASS_CONSTABLE',			'BUILDING_JFD_LENIN_COMMISSARIAT'),
			('CIVILIZATION_JFD_USSR_LENIN', 		'BUILDINGCLASS_STONE_WORKS',		'BUILDING_JFD_LENIN_STONE_WORKS'),
			('CIVILIZATION_JFD_USSR_LENIN', 		'BUILDINGCLASS_FORGE',				'BUILDING_JFD_LENIN_FORGE'),
			('CIVILIZATION_JFD_USSR_LENIN', 		'BUILDINGCLASS_WINDMILL',			'BUILDING_JFD_LENIN_WINDMILL'),
			('CIVILIZATION_JFD_USSR_LENIN', 		'BUILDINGCLASS_FACTORY',			'BUILDING_JFD_LENIN_FACTORY');
--------------------------------	

--------------------------------	
-- Civilization_SpyNames
--------------------------------	
INSERT INTO Civilization_SpyNames
			(CivilizationType, 						SpyName)
VALUES		('CIVILIZATION_JFD_USSR_LENIN', 		'TXT_KEY_SPY_NAME_JFD_LENIN_SOVIET_0'),
			('CIVILIZATION_JFD_USSR_LENIN', 		'TXT_KEY_SPY_NAME_JFD_LENIN_SOVIET_1'),
			('CIVILIZATION_JFD_USSR_LENIN', 		'TXT_KEY_SPY_NAME_JFD_LENIN_SOVIET_2'),
			('CIVILIZATION_JFD_USSR_LENIN', 		'TXT_KEY_SPY_NAME_JFD_LENIN_SOVIET_3'),
			('CIVILIZATION_JFD_USSR_LENIN', 		'TXT_KEY_SPY_NAME_JFD_LENIN_SOVIET_4'),
			('CIVILIZATION_JFD_USSR_LENIN', 		'TXT_KEY_SPY_NAME_JFD_LENIN_SOVIET_5'),
			('CIVILIZATION_JFD_USSR_LENIN', 		'TXT_KEY_SPY_NAME_JFD_LENIN_SOVIET_6'),
			('CIVILIZATION_JFD_USSR_LENIN', 		'TXT_KEY_SPY_NAME_JFD_LENIN_SOVIET_7'),
			('CIVILIZATION_JFD_USSR_LENIN', 		'TXT_KEY_SPY_NAME_JFD_LENIN_SOVIET_8'),
			('CIVILIZATION_JFD_USSR_LENIN', 		'TXT_KEY_SPY_NAME_JFD_LENIN_SOVIET_9');
--==========================================================================================================================
--==========================================================================================================================