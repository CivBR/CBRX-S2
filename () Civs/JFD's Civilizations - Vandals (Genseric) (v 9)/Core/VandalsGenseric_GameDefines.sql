--=======================================================================================================================
-- MASTER TABLES
--=======================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CustomModOptions(Name Text, Value INTEGER, Class INTEGER, DbUpdates INTEGER);
CREATE TABLE IF NOT EXISTS JFD_GlobalUserSettings (Type text, Value integer default 1);
--=======================================================================================================================
-- GAME DEFINES
--=======================================================================================================================
------------------------------------------------------------------------------------------------------------------------
-- UnitClasses
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO UnitClasses
		(Type, 								DefaultUnit, 						Description)
VALUES	('UNITCLASS_JFD_VANDALS_GENSERIC', 	'UNIT_JFD_ALANI_HORSEMAN_SETTLER', 	'TXT_KEY_UNIT_JFD_ALANI_HORSEMAN_SETTLER');
--------------------------------------------------------------------------------------------------------------------------
-- Civilization_UnitClassOverrides 
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Civilization_UnitClassOverrides 
		(CivilizationType, 	UnitClassType, 						UnitType)
SELECT	Type, 				'UNITCLASS_JFD_VANDALS_GENSERIC', 	null
FROM Civilizations WHERE Type IS NOT NULL;

--JFD_VandalsGenseric_Civilization_UnitClassOverrides
CREATE TRIGGER JFD_VandalsGenseric_Civilization_UnitClassOverrides
AFTER INSERT ON Civilizations
WHEN NEW.Type != 'CIVILIZATION_JFD_VANDALS_GENSERIC'
BEGIN
	INSERT INTO Civilization_UnitClassOverrides
			(CivilizationType, 		UnitClassType, 						UnitType)
	VALUES	(NEW.Type,				'UNITCLASS_JFD_VANDALS_GENSERIC', 	null);
END;
--==========================================================================================================================	
-- UNITS
--==========================================================================================================================	
-------------------------------------------------------------------------------------------------------------------------
-- UnitPromotions
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO UnitPromotions 
		(Type, 									Description, 							Help, 												Sound, 			    CannotBeChosen, LostWithUpgrade,  PortraitIndex,  IconAtlas, 						 PediaType, 		  PediaEntry)
VALUES	('PROMOTION_JFD_TRIHEMIOLIA_ACTIVE', 	'TXT_KEY_PROMOTION_JFD_TRIHEMIOLIA',	'TXT_KEY_PROMOTION_JFD_TRIHEMIOLIA_ACTIVE_HELP',	'AS2D_IF_LEVELUP',  1, 			    1, 				  0, 			  'JFD_VANDALS_GENSERIC_PROMOTION_ATLAS',    'PEDIA_ATTRIBUTES',   'TXT_KEY_PROMOTION_JFD_TRIHEMIOLIA'),
		('PROMOTION_JFD_TRIHEMIOLIA_INACTIVE', 	'TXT_KEY_PROMOTION_JFD_TRIHEMIOLIA',	'TXT_KEY_PROMOTION_JFD_TRIHEMIOLIA_INACTIVE_HELP',	'AS2D_IF_LEVELUP',  1, 			    1, 				  59, 			  'ABILITY_ATLAS',					'PEDIA_ATTRIBUTES',   'TXT_KEY_PROMOTION_JFD_TRIHEMIOLIA');
--------------------------------------------------------------------------------------------------------------------------
-- Units
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Units 	
		(Type, 						Class, PrereqTech,				Combat,	Cost, 	FaithCost,	RequiresFaithPurchaseEnabled, Moves, CombatClass, Domain, DefaultUnitAI, Description, 						Help, 									Strategy, 									Civilopedia, 							MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, IgnoreBuildingDefense, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, ObsoleteTech, XPValueDefense, UnitArtInfo, 						UnitFlagAtlas,							UnitFlagIconOffset, 	IconAtlas,							PortraitIndex, 	MoveRate)
SELECT	'UNIT_JFD_ALANI_HORSEMAN',	Class, 'TECH_ANIMAL_HUSBANDRY',	Combat, Cost, 	FaithCost,	RequiresFaithPurchaseEnabled, Moves, CombatClass, Domain, DefaultUnitAI, 'TXT_KEY_UNIT_JFD_ALANI_HORSEMAN', 'TXT_KEY_UNIT_HELP_JFD_ALANI_HORSEMAN',	'TXT_KEY_UNIT_JFD_ALANI_HORSEMAN_STRATEGY',	'TXT_KEY_UNIT_JFD_ALANI_HORSEMAN_TEXT',	MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, IgnoreBuildingDefense, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, ObsoleteTech, XPValueDefense, 'ART_DEF_UNIT_JFD_ALANI_HORSEMAN',	'JFD_VANDALS_GENSERIC_UNIT_FLAG_ATLAS',	0,						'JFD_VANDALS_GENSERIC_ICON_ATLAS',	2, 				MoveRate
FROM Units WHERE Type = 'UNIT_HORSEMAN';	

INSERT INTO Units 	
		(Type, 								Found, Food, ShowInPedia, Class,							PrereqTech,	Combat, Cost,   FaithCost,   RequiresFaithPurchaseEnabled, Moves, CombatClass, Domain, DefaultUnitAI,	 Description, 								 Help, 										Strategy, 									Civilopedia, 							MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, IgnoreBuildingDefense, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, ObsoleteTech, XPValueDefense, UnitArtInfo, 						UnitFlagAtlas,							UnitFlagIconOffset, 	IconAtlas,							PortraitIndex, 	MoveRate)
SELECT	'UNIT_JFD_ALANI_HORSEMAN_SETTLER',	1,	   1,	 0,			  'UNITCLASS_JFD_VANDALS_GENSERIC', null,		Combat, Cost/2, FaithCost/2, RequiresFaithPurchaseEnabled, Moves, CombatClass, Domain, 'UNITAI_SETTLE', 'TXT_KEY_UNIT_JFD_ALANI_HORSEMAN_SETTLER',  'TXT_KEY_UNIT_HELP_JFD_ALANI_HORSEMAN',		'TXT_KEY_UNIT_JFD_ALANI_HORSEMAN_STRATEGY',	'TXT_KEY_UNIT_JFD_ALANI_HORSEMAN_TEXT',	MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, IgnoreBuildingDefense, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, ObsoleteTech, XPValueDefense, 'ART_DEF_UNIT_JFD_ALANI_HORSEMAN',	'JFD_VANDALS_GENSERIC_UNIT_FLAG_ATLAS',	0,						'JFD_VANDALS_GENSERIC_ICON_ATLAS',	2, 				MoveRate
FROM Units WHERE Type = 'UNIT_HORSEMAN';																	  
																												  
INSERT INTO Units 																								  
		(Type, 						Class, PrereqTech,	  Combat, Cost, FaithCost,	RequiresFaithPurchaseEnabled, Moves, CombatClass, Domain, DefaultUnitAI, Description, 						Help, 									Strategy, 									Civilopedia, 											MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, IgnoreBuildingDefense, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, XPValueAttack, XPValueDefense, Conscription, UnitArtInfo,					 UnitFlagAtlas,								UnitFlagIconOffset,  IconAtlas, 						PortraitIndex,  MoveRate)
SELECT	'UNIT_JFD_TRIHEMIOLIA',		Class, 'TECH_OPTICS', Combat, Cost, FaithCost,	RequiresFaithPurchaseEnabled, Moves, CombatClass, Domain, DefaultUnitAI, 'TXT_KEY_UNIT_JFD_TRIHEMIOLIA', 	'TXT_KEY_UNIT_HELP_JFD_TRIHEMIOLIA', 	'TXT_KEY_UNIT_JFD_TRIHEMIOLIA_STRATEGY', 	'TXT_KEY_CIVILOPEDIA_UNITS_VANDAL_TRIHEMIOLLA_TEXT', 	MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, IgnoreBuildingDefense, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, XPValueAttack, XPValueDefense, Conscription, 'ART_DEF_UNIT_JFD_TRIHEMIOLA', 'JFD_VANDALS_GENSERIC_UNIT_FLAG_ATLAS',	0,					 'JFD_VANDALS_GENSERIC_ICON_ATLAS',	3,				MoveRate
FROM Units WHERE Type = 'UNIT_TRIREME';
--------------------------------------------------------------------------------------------------------------------------
-- UnitGameplay2DScripts
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 							SelectionSound, FirstSelectionSound)
SELECT	'UNIT_JFD_ALANI_HORSEMAN',			SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_HORSEMAN';

INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 							SelectionSound, FirstSelectionSound)
SELECT	'UNIT_JFD_ALANI_HORSEMAN_SETTLER', 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_HORSEMAN';

INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 							SelectionSound, FirstSelectionSound)
SELECT	'UNIT_JFD_TRIHEMIOLIA', 			SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_TRIREME';
--------------------------------------------------------------------------------------------------------------------------
-- Unit_AITypes
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Unit_AITypes 	
		(UnitType, 							UnitAIType)
SELECT	'UNIT_JFD_ALANI_HORSEMAN',			UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_HORSEMAN';

INSERT INTO Unit_AITypes 	
		(UnitType, 							UnitAIType)
SELECT	'UNIT_JFD_ALANI_HORSEMAN_SETTLER', 	UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_HORSEMAN';

INSERT INTO Unit_AITypes 	
		(UnitType, 							UnitAIType)
SELECT	'UNIT_JFD_ALANI_HORSEMAN_SETTLER', 	UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_SETTLER';

INSERT INTO Unit_AITypes 	
		(UnitType, 							UnitAIType)
SELECT	'UNIT_JFD_TRIHEMIOLIA', 			UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_TRIREME';
--------------------------------------------------------------------------------------------------------------------------
-- Unit_ResourceQuantityRequirements
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Unit_ResourceQuantityRequirements 	
		(UnitType, 							ResourceType)
SELECT	'UNIT_JFD_ALANI_HORSEMAN',			ResourceType
FROM Unit_ResourceQuantityRequirements WHERE UnitType = 'UNIT_HORSEMAN';	

INSERT INTO Unit_ResourceQuantityRequirements 	
		(UnitType, 							ResourceType)
SELECT	'UNIT_JFD_ALANI_HORSEMAN_SETTLER', 	ResourceType
FROM Unit_ResourceQuantityRequirements WHERE UnitType = 'UNIT_SETTLER';	
--------------------------------------------------------------------------------------------------------------------------
-- Unit_Flavors
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Unit_Flavors 	
		(UnitType, 							FlavorType, Flavor)
SELECT	'UNIT_JFD_ALANI_HORSEMAN',			FlavorType, Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_HORSEMAN';

INSERT INTO Unit_Flavors 	
		(UnitType, 							FlavorType, Flavor)
SELECT	'UNIT_JFD_ALANI_HORSEMAN_SETTLER', 	FlavorType, Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_SETTLER';

INSERT INTO Unit_Flavors 	
		(UnitType, 							FlavorType, Flavor)
SELECT	'UNIT_JFD_ALANI_HORSEMAN_SETTLER', 	FlavorType, Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_SETTLER';

INSERT INTO Unit_Flavors 	
		(UnitType, 							FlavorType, Flavor)
SELECT	'UNIT_JFD_TRIHEMIOLIA', 			FlavorType, Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_TRIREME';
--------------------------------------------------------------------------------------------------------------------------
-- Unit_FreePromotions
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Unit_FreePromotions 	
		(UnitType, 							PromotionType)
SELECT	'UNIT_JFD_ALANI_HORSEMAN',			PromotionType
FROM Unit_FreePromotions WHERE UnitType = 'UNIT_HORSEMAN' AND NOT PromotionType= 'PROMOTION_CITY_PENALTY';

INSERT INTO Unit_FreePromotions 	
		(UnitType, 							PromotionType)
SELECT	'UNIT_JFD_ALANI_HORSEMAN_SETTLER', 	PromotionType
FROM Unit_FreePromotions WHERE UnitType = 'UNIT_HORSEMAN' AND NOT PromotionType= 'PROMOTION_CITY_PENALTY';

INSERT INTO Unit_FreePromotions 	
		(UnitType, 							PromotionType)
SELECT	'UNIT_JFD_TRIHEMIOLIA', 			PromotionType
FROM Unit_FreePromotions WHERE UnitType = 'UNIT_TRIREME';

INSERT INTO Unit_FreePromotions 
		(UnitType, 							PromotionType)
VALUES	('UNIT_JFD_TRIHEMIOLIA', 			'PROMOTION_JFD_TRIHEMIOLIA_INACTIVE'),
		('UNIT_JFD_TRIHEMIOLIA', 			'PROMOTION_COASTAL_RAIDER_1');
--------------------------------------------------------------------------------------------------------------------------
-- Unit_ClassUpgrades
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 					UnitClassType)
SELECT	'UNIT_JFD_ALANI_HORSEMAN', 	UnitClassType
FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_HORSEMAN';

INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 					UnitClassType)
SELECT	'UNIT_JFD_TRIHEMIOLIA', 	UnitClassType
FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_TRIREME';
--==========================================================================================================================	
-- LEADERS
--==========================================================================================================================	
-------------------------------------------------------------------------------------------------------------------------
-- Leaders
--------------------------------------------------------------------------------------------------------------------------			
INSERT INTO Leaders 
		(Type, 								Description, 							Civilopedia, 									CivilopediaTag, 								ArtDefineTag, 						VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 							PortraitIndex)
VALUES	('LEADER_JFD_VANDALS_GENSERIC', 	'TXT_KEY_LEADER_JFD_VANDALS_GENSERIC', 	'TXT_KEY_LEADER_JFD_VANDALS_GENSERIC_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_JFD_VANDALS_GENSERIC',		'JFD_VandalsGenseric_Scene.xml',	6, 						3, 						2, 							7, 			5, 				4, 				7, 						4, 				3, 			4, 			4, 				4, 			8, 			'JFD_VANDALS_GENSERIC_ICON_ATLAS',	1);
--------------------------------------------------------------------------------------------------------------------------
-- Leader_MajorCivApproachBiases
--------------------------------------------------------------------------------------------------------------------------					
INSERT INTO Leader_MajorCivApproachBiases 
		(LeaderType, 						MajorCivApproachType, 				Bias)
VALUES	('LEADER_JFD_VANDALS_GENSERIC', 	'MAJOR_CIV_APPROACH_WAR', 			8),
		('LEADER_JFD_VANDALS_GENSERIC', 	'MAJOR_CIV_APPROACH_HOSTILE', 		9),
		('LEADER_JFD_VANDALS_GENSERIC', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	4),
		('LEADER_JFD_VANDALS_GENSERIC', 	'MAJOR_CIV_APPROACH_GUARDED', 		4),
		('LEADER_JFD_VANDALS_GENSERIC', 	'MAJOR_CIV_APPROACH_AFRAID', 		3),
		('LEADER_JFD_VANDALS_GENSERIC', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		4),
		('LEADER_JFD_VANDALS_GENSERIC', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		6);
--------------------------------------------------------------------------------------------------------------------------
-- Leader_MajorCivApproachBiases
--------------------------------------------------------------------------------------------------------------------------					
INSERT INTO Leader_MinorCivApproachBiases 
		(LeaderType, 						MinorCivApproachType, 				Bias)
VALUES	('LEADER_JFD_VANDALS_GENSERIC', 	'MINOR_CIV_APPROACH_IGNORE', 		5),
		('LEADER_JFD_VANDALS_GENSERIC', 	'MINOR_CIV_APPROACH_FRIENDLY', 		4),
		('LEADER_JFD_VANDALS_GENSERIC', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	4),
		('LEADER_JFD_VANDALS_GENSERIC', 	'MINOR_CIV_APPROACH_CONQUEST', 		6),
		('LEADER_JFD_VANDALS_GENSERIC', 	'MINOR_CIV_APPROACH_BULLY', 		8);
--------------------------------------------------------------------------------------------------------------------------
-- Leader_Flavors
--------------------------------------------------------------------------------------------------------------------------					
INSERT INTO Leader_Flavors 
		(LeaderType, 						FlavorType, 						Flavor)
VALUES	('LEADER_JFD_VANDALS_GENSERIC', 	'FLAVOR_OFFENSE', 					7),
		('LEADER_JFD_VANDALS_GENSERIC', 	'FLAVOR_DEFENSE', 					3),
		('LEADER_JFD_VANDALS_GENSERIC', 	'FLAVOR_CITY_DEFENSE', 				3),
		('LEADER_JFD_VANDALS_GENSERIC', 	'FLAVOR_MILITARY_TRAINING', 		7),
		('LEADER_JFD_VANDALS_GENSERIC', 	'FLAVOR_RECON', 					5),
		('LEADER_JFD_VANDALS_GENSERIC', 	'FLAVOR_RANGED', 					3),
		('LEADER_JFD_VANDALS_GENSERIC', 	'FLAVOR_MOBILE', 					4),
		('LEADER_JFD_VANDALS_GENSERIC', 	'FLAVOR_NAVAL', 					8),
		('LEADER_JFD_VANDALS_GENSERIC', 	'FLAVOR_NAVAL_RECON', 				6),
		('LEADER_JFD_VANDALS_GENSERIC', 	'FLAVOR_NAVAL_GROWTH', 				6),
		('LEADER_JFD_VANDALS_GENSERIC', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	7),
		('LEADER_JFD_VANDALS_GENSERIC', 	'FLAVOR_AIR', 						3),
		('LEADER_JFD_VANDALS_GENSERIC', 	'FLAVOR_EXPANSION', 				9),
		('LEADER_JFD_VANDALS_GENSERIC', 	'FLAVOR_GROWTH', 					6),
		('LEADER_JFD_VANDALS_GENSERIC', 	'FLAVOR_TILE_IMPROVEMENT', 			5),
		('LEADER_JFD_VANDALS_GENSERIC', 	'FLAVOR_INFRASTRUCTURE', 			5),
		('LEADER_JFD_VANDALS_GENSERIC', 	'FLAVOR_PRODUCTION', 				6),
		('LEADER_JFD_VANDALS_GENSERIC', 	'FLAVOR_GOLD', 						8),
		('LEADER_JFD_VANDALS_GENSERIC', 	'FLAVOR_SCIENCE', 					5),
		('LEADER_JFD_VANDALS_GENSERIC', 	'FLAVOR_CULTURE', 					3),
		('LEADER_JFD_VANDALS_GENSERIC', 	'FLAVOR_HAPPINESS', 				3),
		('LEADER_JFD_VANDALS_GENSERIC', 	'FLAVOR_GREAT_PEOPLE', 				4),
		('LEADER_JFD_VANDALS_GENSERIC', 	'FLAVOR_WONDER', 					3),
		('LEADER_JFD_VANDALS_GENSERIC', 	'FLAVOR_RELIGION', 					2),
		('LEADER_JFD_VANDALS_GENSERIC', 	'FLAVOR_DIPLOMACY', 				4),
		('LEADER_JFD_VANDALS_GENSERIC', 	'FLAVOR_SPACESHIP', 				3),
		('LEADER_JFD_VANDALS_GENSERIC', 	'FLAVOR_WATER_CONNECTION', 			4),
		('LEADER_JFD_VANDALS_GENSERIC', 	'FLAVOR_NUKE', 						2),
		('LEADER_JFD_VANDALS_GENSERIC', 	'FLAVOR_USE_NUKE', 					2),
		('LEADER_JFD_VANDALS_GENSERIC', 	'FLAVOR_ESPIONAGE', 				5),
		('LEADER_JFD_VANDALS_GENSERIC', 	'FLAVOR_AIRLIFT', 					4),
		('LEADER_JFD_VANDALS_GENSERIC', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
		('LEADER_JFD_VANDALS_GENSERIC', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
		('LEADER_JFD_VANDALS_GENSERIC', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		8),
		('LEADER_JFD_VANDALS_GENSERIC', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
		('LEADER_JFD_VANDALS_GENSERIC', 	'FLAVOR_ARCHAEOLOGY', 				5),
		('LEADER_JFD_VANDALS_GENSERIC', 	'FLAVOR_AIR_CARRIER', 				5);
--------------------------------------------------------------------------------------------------------------------------
-- Leader_Traits
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Leader_Traits 
		(LeaderType, 						TraitType)
VALUES	('LEADER_JFD_VANDALS_GENSERIC',		'TRAIT_JFD_VANDALS_GENSERIC');
--==========================================================================================================================	
-- TRAITS
--==========================================================================================================================	
-------------------------------------------------------------------------------------------------------------------------
-- UnitPromotions
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO UnitPromotions 
		(Type, 								RivalTerritory, Description, 								Help, 											Sound, 			    CannotBeChosen, LostWithUpgrade,  PortraitIndex,  IconAtlas, 		 PediaType, 		  PediaEntry)
VALUES	('PROMOTION_JFD_VANDALS_GENSERIC', 	1,				'TXT_KEY_PROMOTION_JFD_VANDALS_GENSERIC',	'TXT_KEY_PROMOTION_JFD_VANDALS_GENSERIC_HELP',	'AS2D_IF_LEVELUP',  1, 			    1, 				  59, 			  'ABILITY_ATLAS',   'PEDIA_ATTRIBUTES',  'TXT_KEY_PROMOTION_JFD_VANDALS_GENSERIC');
--------------------------------------------------------------------------------------------------------------------------
-- Traits
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Traits 
		(Type, 							Description, 							ShortDescription)
VALUES	('TRAIT_JFD_VANDALS_GENSERIC', 	'TXT_KEY_TRAIT_JFD_VANDALS_GENSERIC',  'TXT_KEY_TRAIT_JFD_VANDALS_GENSERIC_SHORT');
--==========================================================================================================================	
-- DIPLOMACY
--==========================================================================================================================	
--------------------------------------------------------------------------------------------------------------------------
-- Diplomacy_Responses
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Diplomacy_Responses
		(LeaderType, 					ResponseType, 							Response, 															Bias)
VALUES 	('LEADER_JFD_VANDALS_GENSERIC', 'RESPONSE_AI_DOF_BACKSTAB', 			'TXT_KEY_LEADER_JFD_VANDALS_GENSERIC_DENOUNCE_FRIEND%', 			500),
		('LEADER_JFD_VANDALS_GENSERIC', 'RESPONSE_ATTACKED_HOSTILE', 			'TXT_KEY_LEADER_JFD_VANDALS_GENSERIC_ATTACKED_HOSTILE%', 			500),
		('LEADER_JFD_VANDALS_GENSERIC', 'RESPONSE_DEFEATED', 					'TXT_KEY_LEADER_JFD_VANDALS_GENSERIC_DEFEATED%', 					500),
		('LEADER_JFD_VANDALS_GENSERIC', 'RESPONSE_DOW_GENERIC', 				'TXT_KEY_LEADER_JFD_VANDALS_GENSERIC_DOW_GENERIC%', 				500),
		('LEADER_JFD_VANDALS_GENSERIC', 'RESPONSE_FIRST_GREETING', 				'TXT_KEY_LEADER_JFD_VANDALS_GENSERIC_FIRSTGREETING%', 				500),
		('LEADER_JFD_VANDALS_GENSERIC', 'RESPONSE_RESPONSE_TO_BEING_DENOUNCED', 'TXT_KEY_LEADER_JFD_VANDALS_GENSERIC_RESPONSE_TO_BEING_DENOUNCED%', 500),
		('LEADER_JFD_VANDALS_GENSERIC', 'RESPONSE_WORK_AGAINST_SOMEONE', 		'TXT_KEY_LEADER_JFD_VANDALS_GENSERIC_DENOUNCE%', 					500),
		('LEADER_JFD_VANDALS_GENSERIC', 'RESPONSE_WORK_WITH_US', 				'TXT_KEY_LEADER_JFD_VANDALS_GENSERIC_DEC_FRIENDSHIP%', 				500);
--==========================================================================================================================	
-- CIVILIZATIONS
--==========================================================================================================================	
-------------------------------------------------------------------------------------------------------------------------
-- Civilizations
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilizations 	
		(Type, 									DerivativeCiv,							Description, 								ShortDescription, 								Adjective, 										Civilopedia, 								CivilopediaTag, 						DefaultPlayerColor, 				ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, 							AlphaIconAtlas, 					PortraitIndex,   SoundtrackTag,  MapImage, 							DawnOfManQuote, 								DawnOfManImage)
SELECT	'CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_CIV_TAL_JFD_VANDALS_DESC',		'TXT_KEY_CIV_JFD_VANDALS_GENSERIC_DESC', 	'TXT_KEY_CIV_JFD_VANDALS_GENSERIC_SHORT_DESC',	'TXT_KEY_CIV_JFD_VANDALS_GENSERIC_ADJECTIVE', 	'TXT_KEY_CIV5_JFD_VANDALS_GENSERIC_TEXT_1',	'TXT_KEY_CIV5_JFD_VANDALS_GENSERIC',	'PLAYERCOLOR_JFD_VANDALS_GENSERIC',	ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, 'JFD_VANDALS_GENSERIC_ICON_ATLAS',	'JFD_VANDALS_GENSERIC_ALPHA_ATLAS',  0, 			 'Germany', 	 'JFD_MapVandalsGenseric512.dds', 	'TXT_KEY_CIV5_DAWN_JFD_VANDALS_GENSERIC_TEXT',	'JFD_DOM_VandalsGenseric.dds'
FROM Civilizations WHERE Type = 'CIVILIZATION_GERMANY';
--------------------------------------------------------------------------------------------------------------------------
-- Civilization_CityNames
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_CityNames 
		(CivilizationType, 						CityName)
VALUES	('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_CITY_NAME_JFD_VANDALS_GENSERIC_01'),
		('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_CITY_NAME_JFD_VANDALS_GENSERIC_02'),
		('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_CITY_NAME_JFD_VANDALS_GENSERIC_03'),
		('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_CITY_NAME_JFD_VANDALS_GENSERIC_04'),
		('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_CITY_NAME_JFD_VANDALS_GENSERIC_05'),
		('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_CITY_NAME_JFD_VANDALS_GENSERIC_06'),
		('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_CITY_NAME_JFD_VANDALS_GENSERIC_07'),
		('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_CITY_NAME_JFD_VANDALS_GENSERIC_08'),
		('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_CITY_NAME_JFD_VANDALS_GENSERIC_09'),
		('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_CITY_NAME_JFD_VANDALS_GENSERIC_10'),
		('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_CITY_NAME_JFD_VANDALS_GENSERIC_11'),
		('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_CITY_NAME_JFD_VANDALS_GENSERIC_12'),
		('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_CITY_NAME_JFD_VANDALS_GENSERIC_13'),
		('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_CITY_NAME_JFD_VANDALS_GENSERIC_14'),
		('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_CITY_NAME_JFD_VANDALS_GENSERIC_15'),
		('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_CITY_NAME_JFD_VANDALS_GENSERIC_16'),
		('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_CITY_NAME_JFD_VANDALS_GENSERIC_17'),
		('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_CITY_NAME_JFD_VANDALS_GENSERIC_18'),
		('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_CITY_NAME_JFD_VANDALS_GENSERIC_19'),
		('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_CITY_NAME_JFD_VANDALS_GENSERIC_20'),
		('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_CITY_NAME_JFD_VANDALS_GENSERIC_21'),
		('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_CITY_NAME_JFD_VANDALS_GENSERIC_22'),
		('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_CITY_NAME_JFD_VANDALS_GENSERIC_23'),
		('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_CITY_NAME_JFD_VANDALS_GENSERIC_24'),
		('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_CITY_NAME_JFD_VANDALS_GENSERIC_25'),
		('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_CITY_NAME_JFD_VANDALS_GENSERIC_26'),
		('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_CITY_NAME_JFD_VANDALS_GENSERIC_27'),
		('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_CITY_NAME_JFD_VANDALS_GENSERIC_28'),
		('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_CITY_NAME_JFD_VANDALS_GENSERIC_29'),
		('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_CITY_NAME_JFD_VANDALS_GENSERIC_30'),
		('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_CITY_NAME_JFD_VANDALS_GENSERIC_31'),
		('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_CITY_NAME_JFD_VANDALS_GENSERIC_32');
--------------------------------------------------------------------------------------------------------------------------
-- Civilization_FreeBuildingClasses
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_FreeBuildingClasses 
		(CivilizationType, 						BuildingClassType)
SELECT	'CIVILIZATION_JFD_VANDALS_GENSERIC', 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE CivilizationType = 'CIVILIZATION_GERMANY';
--------------------------------------------------------------------------------------------------------------------------
-- Civilization_FreeTechs
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Civilization_FreeTechs 
		(CivilizationType, 						TechType)
SELECT	'CIVILIZATION_JFD_VANDALS_GENSERIC', 	TechType
FROM Civilization_FreeTechs WHERE CivilizationType = 'CIVILIZATION_GERMANY';
--------------------------------------------------------------------------------------------------------------------------
-- Civilization_FreeUnits
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Civilization_FreeUnits 
		(CivilizationType, 						UnitClassType, Count, UnitAIType)
SELECT	'CIVILIZATION_JFD_VANDALS_GENSERIC', 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE CivilizationType = 'CIVILIZATION_GERMANY';
--------------------------------------------------------------------------------------------------------------------------
-- Civilization_Leaders
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_Leaders 
		(CivilizationType, 						LeaderheadType)
VALUES	('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'LEADER_JFD_VANDALS_GENSERIC');
--------------------------------------------------------------------------------------------------------------------------
-- Civilization_UnitClassOverrides 
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Civilization_UnitClassOverrides 
		(CivilizationType, 						UnitClassType, 			UnitType)
VALUES	('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'UNITCLASS_HORSEMAN', 	'UNIT_JFD_ALANI_HORSEMAN'),
		('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'UNITCLASS_TRIREME', 	'UNIT_JFD_TRIHEMIOLIA');
--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
-- Civilization_SpyNames
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Civilization_SpyNames 
		(CivilizationType, 						SpyName)
VALUES	('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_SPY_NAME_JFD_VANDALS_GENSERIC_0'),	
		('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_SPY_NAME_JFD_VANDALS_GENSERIC_1'),
		('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_SPY_NAME_JFD_VANDALS_GENSERIC_2'),
		('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_SPY_NAME_JFD_VANDALS_GENSERIC_3'),
		('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_SPY_NAME_JFD_VANDALS_GENSERIC_4'),
		('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_SPY_NAME_JFD_VANDALS_GENSERIC_5'),
		('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_SPY_NAME_JFD_VANDALS_GENSERIC_6'),
		('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_SPY_NAME_JFD_VANDALS_GENSERIC_7'),
		('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_SPY_NAME_JFD_VANDALS_GENSERIC_8'),
		('CIVILIZATION_JFD_VANDALS_GENSERIC', 	'TXT_KEY_SPY_NAME_JFD_VANDALS_GENSERIC_9');
--------------------------------------------------------------------------------------------------------------------------
-- Civilization_Start_Along_Ocean
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Civilization_Start_Along_Ocean 
		(CivilizationType, 						StartAlongOcean)
VALUES	('CIVILIZATION_JFD_VANDALS_GENSERIC', 	1);
--==========================================================================================================================
--==========================================================================================================================