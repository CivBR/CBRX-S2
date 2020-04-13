--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================	
-- Buildings
------------------------------	
INSERT INTO Buildings 	
		(Type, 						Happiness, TradeRouteLandDistanceModifier,	TradeRouteSeaDistanceModifier,	TradeRouteLandGoldBonus, TradeRouteSeaGoldBonus, SpecialistCount, SpecialistType, BuildingClass, Cost, GoldMaintenance, PrereqTech, Description, 						Civilopedia, 							Help, 										Strategy,									 ArtDefineTag, MinAreaSize, ConquestProb, HurryCostModifier, PortraitIndex, IconAtlas)
SELECT	'BUILDING_JFD_WINE_CELLAR',	Happiness, 30,								30,								200,					 200,					 SpecialistCount, SpecialistType, BuildingClass, Cost, GoldMaintenance, PrereqTech, 'TXT_KEY_BUILDING_JFD_WINE_CELLAR', 'TXT_KEY_CIV5_JFD_WINE_CELLAR_TEXT', 	'TXT_KEY_BUILDING_JFD_WINE_CELLAR_HELP', 	'TXT_KEY_BUILDING_JFD_WINE_CELLAR_STRATEGY', ArtDefineTag, MinAreaSize, ConquestProb, HurryCostModifier, 3, 			'JFD_TWO_SICILIES_ATLAS'
FROM Buildings WHERE Type = 'BUILDING_THEATRE';	
------------------------------	
-- Building_Flavors
------------------------------		
INSERT INTO Building_Flavors 	
		(BuildingType, 				FlavorType, Flavor)
SELECT	'BUILDING_JFD_WINE_CELLAR',	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_THEATRE';
------------------------------	
-- Building_ClassesNeededInCity
------------------------------		
INSERT INTO Building_ClassesNeededInCity 	
		(BuildingType, 				BuildingClassType)
SELECT	'BUILDING_JFD_WINE_CELLAR',	BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_THEATRE';
------------------------------	
-- Building_YieldChanges
------------------------------		
INSERT INTO Building_YieldChanges 	
		(BuildingType, 				YieldType, Yield)
SELECT	'BUILDING_JFD_WINE_CELLAR',	YieldType, Yield
FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_THEATRE';
--==========================================================================================================================	
-- UNITS
--==========================================================================================================================
-- Units
--------------------------------	
INSERT INTO Units 	
		(Type, 						Class,	PrereqTech, RangedCombat, Range, Special, Combat, Cost, FaithCost, RequiresFaithPurchaseEnabled, Moves, CombatClass, Domain, DefaultUnitAI, Description, 					  Civilopedia, 								Strategy, 									Help, 									Pillage, MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, Mechanized, AdvancedStartCost, RangedCombatLimit, CombatLimit, XPValueDefense, UnitArtInfo, 						UnitFlagIconOffset,	UnitFlagAtlas,						 PortraitIndex, 	IconAtlas,					MoveRate)
SELECT	'UNIT_JFD_STEAM_FRIGATE',	Class,	PrereqTech, RangedCombat, Range, Special, Combat, Cost, FaithCost, RequiresFaithPurchaseEnabled, Moves, CombatClass, Domain, DefaultUnitAI, 'TXT_KEY_UNIT_JFD_STEAM_FRIGATE', 'TXT_KEY_CIV5_JFD_STEAM_FRIGATE_TEXT',	'TXT_KEY_UNIT_JFD_STEAM_FRIGATE_STRATEGY',  'TXT_KEY_UNIT_JFD_STEAM_FRIGATE_HELP', 	Pillage, MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, 1,			 AdvancedStartCost, RangedCombatLimit, CombatLimit, XPValueDefense, 'ART_DEF_UNIT_JFD_STEAM_FRIGATE',	0,					'JFD_STEAM_FRIGATE_FLAG_ART_ATLAS',  2, 				'JFD_TWO_SICILIES_ATLAS',	'BOAT'
FROM Units WHERE Type = 'UNIT_FRIGATE';
--------------------------------	
-- UnitGameplay2DScripts
--------------------------------		
INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 					SelectionSound,	FirstSelectionSound)
SELECT	'UNIT_JFD_STEAM_FRIGATE', 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_FRIGATE';
--------------------------------		
-- Unit_AITypes
--------------------------------		
INSERT INTO Unit_AITypes 	
		(UnitType, 					UnitAIType)
SELECT	'UNIT_JFD_STEAM_FRIGATE', 	UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_FRIGATE';
--------------------------------	
-- Unit_ClassUpgrades
--------------------------------	
INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 					UnitClassType)
SELECT	'UNIT_JFD_STEAM_FRIGATE',	UnitClassType
FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_FRIGATE';	
--------------------------------	
-- Unit_Flavors
--------------------------------		
INSERT INTO Unit_Flavors 	
		(UnitType, 					FlavorType, Flavor)
SELECT	'UNIT_JFD_STEAM_FRIGATE', 	FlavorType, Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_FRIGATE';
--------------------------------	
-- Unit_ResourceQuantityRequirements
--------------------------------	
INSERT INTO Unit_ResourceQuantityRequirements 	
		(UnitType, 					ResourceType, Cost)
SELECT	'UNIT_JFD_STEAM_FRIGATE', 	ResourceType, Cost
FROM Unit_ResourceQuantityRequirements WHERE UnitType = 'UNIT_FRIGATE';
--------------------------------	
-- Unit_FreePromotions
--------------------------------	
INSERT INTO Unit_FreePromotions 	
		(UnitType, 					PromotionType)
SELECT	'UNIT_JFD_STEAM_FRIGATE', 	PromotionType
FROM Unit_FreePromotions WHERE UnitType = 'UNIT_FRIGATE';	

INSERT INTO Unit_FreePromotions
		(UnitType, 					PromotionType)
VALUES	('UNIT_JFD_STEAM_FRIGATE',  'PROMOTION_EXTRA_MOVES_I'),
		('UNIT_JFD_STEAM_FRIGATE',  'PROMOTION_STEAM_POWERED');	
--==========================================================================================================================	
-- LEADERS
--==========================================================================================================================	
-- Leaders
--------------------------------			
INSERT INTO Leaders 
		(Type, 						Description, 						Civilopedia, 							CivilopediaTag, 								ArtDefineTag, 			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 				PortraitIndex)
VALUES	('LEADER_JFD_FERDINAND_I', 'TXT_KEY_LEADER_JFD_FERDINAND_I',	'TXT_KEY_LEADER_JFD_FERDINAND_I_PEDIA', 'TXT_KEY_CIVILOPEDIA_LEADERS_JFD_FERDINAND_I',	'FerdinandI_Scene.xml',	6, 						5, 						4, 							3, 			3, 				5, 				5, 						5, 				6, 			6, 			7, 				4, 			3, 			'JFD_TWO_SICILIES_ATLAS', 	1);
--------------------------------		
-- Leader_MajorCivApproachBiases
--------------------------------						
INSERT INTO Leader_MajorCivApproachBiases 
		(LeaderType, 				MajorCivApproachType, 				Bias)
VALUES	('LEADER_JFD_FERDINAND_I', 'MAJOR_CIV_APPROACH_WAR', 			3),
		('LEADER_JFD_FERDINAND_I', 'MAJOR_CIV_APPROACH_HOSTILE', 		3),
		('LEADER_JFD_FERDINAND_I', 'MAJOR_CIV_APPROACH_DECEPTIVE',		4),
		('LEADER_JFD_FERDINAND_I', 'MAJOR_CIV_APPROACH_GUARDED', 		6),
		('LEADER_JFD_FERDINAND_I', 'MAJOR_CIV_APPROACH_AFRAID', 		5),
		('LEADER_JFD_FERDINAND_I', 'MAJOR_CIV_APPROACH_FRIENDLY', 		6),
		('LEADER_JFD_FERDINAND_I', 'MAJOR_CIV_APPROACH_NEUTRAL', 		3);
--------------------------------	
-- Leader_MajorCivApproachBiases
--------------------------------							
INSERT INTO Leader_MinorCivApproachBiases 
		(LeaderType, 				MinorCivApproachType, 				Bias)
VALUES	('LEADER_JFD_FERDINAND_I', 'MINOR_CIV_APPROACH_IGNORE', 		4),
		('LEADER_JFD_FERDINAND_I', 'MINOR_CIV_APPROACH_FRIENDLY', 		6),
		('LEADER_JFD_FERDINAND_I', 'MINOR_CIV_APPROACH_PROTECTIVE', 	5),
		('LEADER_JFD_FERDINAND_I', 'MINOR_CIV_APPROACH_CONQUEST', 		2),
		('LEADER_JFD_FERDINAND_I', 'MINOR_CIV_APPROACH_BULLY', 			3);
--------------------------------	
-- Leader_Flavors
--------------------------------							
INSERT INTO Leader_Flavors 
		(LeaderType, 				FlavorType, 						Flavor)
VALUES	('LEADER_JFD_FERDINAND_I', 'FLAVOR_OFFENSE', 					3),
		('LEADER_JFD_FERDINAND_I', 'FLAVOR_DEFENSE', 					6),
		('LEADER_JFD_FERDINAND_I', 'FLAVOR_CITY_DEFENSE', 				6),
		('LEADER_JFD_FERDINAND_I', 'FLAVOR_MILITARY_TRAINING', 			5),
		('LEADER_JFD_FERDINAND_I', 'FLAVOR_RECON', 						3),
		('LEADER_JFD_FERDINAND_I', 'FLAVOR_RANGED', 					3),
		('LEADER_JFD_FERDINAND_I', 'FLAVOR_MOBILE', 					4),
		('LEADER_JFD_FERDINAND_I', 'FLAVOR_NAVAL', 						8),
		('LEADER_JFD_FERDINAND_I', 'FLAVOR_NAVAL_RECON', 				7),
		('LEADER_JFD_FERDINAND_I', 'FLAVOR_NAVAL_GROWTH', 				5),
		('LEADER_JFD_FERDINAND_I', 'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	3),
		('LEADER_JFD_FERDINAND_I', 'FLAVOR_AIR', 						2),
		('LEADER_JFD_FERDINAND_I', 'FLAVOR_EXPANSION', 					5),
		('LEADER_JFD_FERDINAND_I', 'FLAVOR_GROWTH', 					4),
		('LEADER_JFD_FERDINAND_I', 'FLAVOR_TILE_IMPROVEMENT', 			4),
		('LEADER_JFD_FERDINAND_I', 'FLAVOR_INFRASTRUCTURE', 			5),
		('LEADER_JFD_FERDINAND_I', 'FLAVOR_PRODUCTION', 				4),
		('LEADER_JFD_FERDINAND_I', 'FLAVOR_GOLD', 						7),
		('LEADER_JFD_FERDINAND_I', 'FLAVOR_SCIENCE', 					4),
		('LEADER_JFD_FERDINAND_I', 'FLAVOR_CULTURE', 					5),
		('LEADER_JFD_FERDINAND_I', 'FLAVOR_HAPPINESS', 					3),
		('LEADER_JFD_FERDINAND_I', 'FLAVOR_GREAT_PEOPLE', 				3),
		('LEADER_JFD_FERDINAND_I', 'FLAVOR_WONDER', 					4),
		('LEADER_JFD_FERDINAND_I', 'FLAVOR_RELIGION', 					3),
		('LEADER_JFD_FERDINAND_I', 'FLAVOR_DIPLOMACY', 					3),
		('LEADER_JFD_FERDINAND_I', 'FLAVOR_SPACESHIP', 					2),
		('LEADER_JFD_FERDINAND_I', 'FLAVOR_WATER_CONNECTION', 			6),
		('LEADER_JFD_FERDINAND_I', 'FLAVOR_NUKE', 						3),
		('LEADER_JFD_FERDINAND_I', 'FLAVOR_USE_NUKE', 					2),
		('LEADER_JFD_FERDINAND_I', 'FLAVOR_ESPIONAGE', 					2),
		('LEADER_JFD_FERDINAND_I', 'FLAVOR_AIRLIFT', 					2),
		('LEADER_JFD_FERDINAND_I', 'FLAVOR_I_TRADE_DESTINATION', 		5),
		('LEADER_JFD_FERDINAND_I', 'FLAVOR_I_TRADE_ORIGIN', 			5),
		('LEADER_JFD_FERDINAND_I', 'FLAVOR_I_SEA_TRADE_ROUTE', 			8),
		('LEADER_JFD_FERDINAND_I', 'FLAVOR_I_LAND_TRADE_ROUTE', 		4),
		('LEADER_JFD_FERDINAND_I', 'FLAVOR_ARCHAEOLOGY', 				5),
		('LEADER_JFD_FERDINAND_I', 'FLAVOR_AIR_CARRIER', 				5);
--------------------------------	
-- Leader_Traits
--------------------------------	
INSERT INTO Leader_Traits 
		(LeaderType, 				TraitType)
VALUES	('LEADER_JFD_FERDINAND_I', 'TRAIT_JFD_TWO_SICILIES');
--==========================================================================================================================	
-- TRAITS
--==========================================================================================================================	
-- Traits
--------------------------------	
INSERT INTO Traits 
		(Type, 						Description, 						ShortDescription)
VALUES	('TRAIT_JFD_TWO_SICILIES', 	'TXT_KEY_TRAIT_JFD_TWO_SICILIES',	'TXT_KEY_TRAIT_JFD_TWO_SICILIES_SHORT');
--==========================================================================================================================	
-- CIVILIZATIONS
--==========================================================================================================================	
-- Civilizations
--------------------------------		
INSERT INTO Civilizations 	
		(Type, 								DerivativeCiv,						Description,							ShortDescription,							Adjective,									Civilopedia,							CivilopediaTag,						DefaultPlayerColor,				ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas,					PortraitIndex,	AlphaIconAtlas,					SoundtrackTag,  MapImage, 					DawnOfManQuote, 						DawnOfManImage)
SELECT	'CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_JFD_TAL_ITALIAN_STATES',	'TXT_KEY_CIV_JFD_TWO_SICILIES_DESC', 	'TXT_KEY_CIV_JFD_TWO_SICILIES_SHORT_DESC',	'TXT_KEY_CIV_JFD_TWO_SICILIES_ADJECTIVE',	'TXT_KEY_CIV5_JFD_TWO_SICILIES_TEXT_1', 'TXT_KEY_CIV5_JFD_TWO_SICILIES',	'PLAYERCOLOR_JFD_TWO_SICILIES',	ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, 'JFD_TWO_SICILIES_ATLAS',	0,				'JFD_TWO_SICILIES_ALPHA_ATLAS',	'Venice', 		'MapTwoSicilies512.dds',	'TXT_KEY_CIV5_DAWN_TWO_SICILIES_TEXT',	'DOM_FerdinandI.dds'
FROM Civilizations WHERE Type = 'CIVILIZATION_VENICE';

UPDATE Civilizations
SET DerivativeCiv = 'TXT_KEY_JFD_TAL_ITALIAN_STATES'
WHERE Type = 'CIVILIZATION_VENICE';
--------------------------------	
-- Civilization_CityNames
--------------------------------	
INSERT INTO Civilization_CityNames 
		(CivilizationType, 					CityName)
VALUES	('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_CITY_NAME_JFD_TWO_SICILIES_01'),
		('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_CITY_NAME_JFD_TWO_SICILIES_02'),
		('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_CITY_NAME_JFD_TWO_SICILIES_03'),
		('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_CITY_NAME_JFD_TWO_SICILIES_04'),
		('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_CITY_NAME_JFD_TWO_SICILIES_05'),
		('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_CITY_NAME_JFD_TWO_SICILIES_06'),
		('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_CITY_NAME_JFD_TWO_SICILIES_07'),
		('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_CITY_NAME_JFD_TWO_SICILIES_08'),
		('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_CITY_NAME_JFD_TWO_SICILIES_09'),
		('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_CITY_NAME_JFD_TWO_SICILIES_10'),
		('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_CITY_NAME_JFD_TWO_SICILIES_11'),
		('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_CITY_NAME_JFD_TWO_SICILIES_12'),
		('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_CITY_NAME_JFD_TWO_SICILIES_13'),
		('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_CITY_NAME_JFD_TWO_SICILIES_14'),
		('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_CITY_NAME_JFD_TWO_SICILIES_15'),
		('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_CITY_NAME_JFD_TWO_SICILIES_16'),
		('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_CITY_NAME_JFD_TWO_SICILIES_17'),
		('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_CITY_NAME_JFD_TWO_SICILIES_18'),
		('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_CITY_NAME_JFD_TWO_SICILIES_19'),
		('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_CITY_NAME_JFD_TWO_SICILIES_20'),
		('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_CITY_NAME_JFD_TWO_SICILIES_21'),
		('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_CITY_NAME_JFD_TWO_SICILIES_22'),
		('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_CITY_NAME_JFD_TWO_SICILIES_23');
--------------------------------	
-- Civilization_FreeBuildingClasses
--------------------------------			
INSERT INTO Civilization_FreeBuildingClasses 
		(CivilizationType, 					BuildingClassType)
SELECT	'CIVILIZATION_JFD_TWO_SICILIES', 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE CivilizationType = 'CIVILIZATION_VENICE';
--------------------------------		
-- Civilization_FreeTechs
--------------------------------			
INSERT INTO Civilization_FreeTechs 
		(CivilizationType, 					TechType)
SELECT	'CIVILIZATION_JFD_TWO_SICILIES', 	TechType
FROM Civilization_FreeTechs WHERE CivilizationType = 'CIVILIZATION_VENICE';
--------------------------------	
-- Civilization_FreeUnits
--------------------------------		
INSERT INTO Civilization_FreeUnits 
		(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT	'CIVILIZATION_JFD_TWO_SICILIES', 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE CivilizationType = 'CIVILIZATION_VENICE';
--------------------------------	
-- Civilization_Leaders
--------------------------------		
INSERT INTO Civilization_Leaders 
		(CivilizationType, 					LeaderheadType)
VALUES	('CIVILIZATION_JFD_TWO_SICILIES',	'LEADER_JFD_FERDINAND_I');
--------------------------------	
-- Civilization_BuildingClassOverrides 
--------------------------------		
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 					BuildingClassType, 			BuildingType)
VALUES	('CIVILIZATION_JFD_TWO_SICILIES',	'BUILDINGCLASS_THEATRE',	'BUILDING_JFD_WINE_CELLAR');
--------------------------------	
-- Civilization_UnitClassOverrides 
--------------------------------		
INSERT INTO Civilization_UnitClassOverrides 
		(CivilizationType, 					UnitClassType, 			UnitType)
VALUES	('CIVILIZATION_JFD_TWO_SICILIES',	'UNITCLASS_FRIGATE',	'UNIT_JFD_STEAM_FRIGATE');
--------------------------------	
-- Civilization_Religions
--------------------------------			
INSERT INTO Civilization_Religions 
		(CivilizationType, 					ReligionType)
VALUES	('CIVILIZATION_JFD_TWO_SICILIES',	'RELIGION_CHRISTIANITY');
--------------------------------	
-- Civilization_SpyNames
--------------------------------	
INSERT INTO Civilization_SpyNames 
		(CivilizationType, 					SpyName)
VALUES	('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_SPY_NAME_JFD_TWO_SICILIES_00'),
		('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_SPY_NAME_JFD_TWO_SICILIES_01'),
		('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_SPY_NAME_JFD_TWO_SICILIES_02'),
		('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_SPY_NAME_JFD_TWO_SICILIES_03'),
		('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_SPY_NAME_JFD_TWO_SICILIES_04'),
		('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_SPY_NAME_JFD_TWO_SICILIES_05'),
		('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_SPY_NAME_JFD_TWO_SICILIES_06'),
		('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_SPY_NAME_JFD_TWO_SICILIES_07'),
		('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_SPY_NAME_JFD_TWO_SICILIES_08'),
		('CIVILIZATION_JFD_TWO_SICILIES',	'TXT_KEY_SPY_NAME_JFD_TWO_SICILIES_09');
--------------------------------	
-- Civilization_Start_Along_Ocean 
--------------------------------		
INSERT INTO Civilization_Start_Along_Ocean 
		(CivilizationType, 					StartAlongOcean)
VALUES	('CIVILIZATION_JFD_TWO_SICILIES',	1);
--==========================================================================================================================
--==========================================================================================================================