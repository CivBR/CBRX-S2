--==========================================================================================================================	
-- PROMOTIONS
--==========================================================================================================================	
-- UnitPromotions
------------------------------
INSERT INTO UnitPromotions 
		(Type, 								 Description, 								Help, 											Sound, 				CannotBeChosen, PortraitIndex,  IconAtlas, 			PediaType, 			PediaEntry)
VALUES	('PROMOTION_JFD_REGAL_SHIP',		'TXT_KEY_PROMOTION_JFD_REGAL_SHIP',			'TXT_KEY_PROMOTION_JFD_REGAL_SHIP_HELP',		'AS2D_IF_LEVELUP',	1, 				32, 			'PROMOTION_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_REGAL_SHIP'),
		('PROMOTION_JFD_REGAL_SHIP_COAST',	'TXT_KEY_PROMOTION_JFD_REGAL_SHIP_COAST',	'TXT_KEY_PROMOTION_JFD_REGAL_SHIP_COAST_HELP',	'AS2D_IF_LEVELUP',	1, 				59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_REGAL_SHIP_COAST');
--------------------------------	
-- UnitPromotion_Terrains
--------------------------------	
INSERT INTO UnitPromotions_Terrains
		(PromotionType,				 TerrainType,		Attack, Defense)
VALUES	('PROMOTION_JFD_REGAL_SHIP', 'TERRAIN_COAST',	20,		20);
--==========================================================================================================================
-- UNITS
--==========================================================================================================================
-- Units
--------------------------------
INSERT INTO Units 	
		(Type, 					Class, 	PrereqTech, RangedCombat, Range, Special, Combat, Cost, FaithCost, RequiresFaithPurchaseEnabled, Moves, CombatClass, Domain, DefaultUnitAI, Description, 					Civilopedia, 						Strategy, 								 Help, 								 Pillage, MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, Mechanized, AdvancedStartCost, RangedCombatLimit, CombatLimit, XPValueDefense, UnitArtInfo, 					UnitFlagIconOffset, UnitFlagAtlas,						PortraitIndex, 	IconAtlas,					MoveRate)
SELECT	'UNIT_JFD_REGAL_SHIP',	Class,	PrereqTech, RangedCombat, Range, Special, Combat, Cost, FaithCost, RequiresFaithPurchaseEnabled, Moves, CombatClass, Domain, DefaultUnitAI, 'TXT_KEY_UNIT_JFD_REGAL_SHIP',	'TXT_KEY_CIV5_JFD_REGAL_SHIP_TEXT', 'TXT_KEY_UNIT_JFD_REGAL_SHIP_STRATEGY',  'TXT_KEY_UNIT_HELP_JFD_REGAL_SHIP', Pillage, MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, Mechanized, AdvancedStartCost, RangedCombatLimit, CombatLimit, XPValueDefense, 'ART_DEF_UNIT_JFD_REGAL_SHIP', 0,					'JFD_UNIT_FLAG_REGAL_SHIP_ATLAS',	2, 				'JFD_SWEDEN_KARL_ATLAS',	MoveRate
FROM Units WHERE Type = 'UNIT_FRIGATE';
--------------------------------	
-- UnitGameplay2DScripts
--------------------------------		
INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 				SelectionSound, FirstSelectionSound)
SELECT	'UNIT_JFD_REGAL_SHIP', 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_FRIGATE';
--------------------------------		
-- Unit_AITypes
--------------------------------		
INSERT INTO Unit_AITypes 	
		(UnitType, 				UnitAIType)
SELECT	'UNIT_JFD_REGAL_SHIP', 	UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_FRIGATE';
--------------------------------	
-- Unit_ClassUpgrades
--------------------------------	
INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 				UnitClassType)
SELECT	'UNIT_JFD_REGAL_SHIP',	UnitClassType
FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_FRIGATE';	
--------------------------------	
-- Unit_Flavors
--------------------------------		
INSERT INTO Unit_Flavors 	
		(UnitType, 				FlavorType, Flavor)
SELECT	'UNIT_JFD_REGAL_SHIP', 	FlavorType, Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_FRIGATE';
--------------------------------	
-- Unit_ResourceQuantityRequirements
--------------------------------		
INSERT INTO Unit_ResourceQuantityRequirements 	
		(UnitType, 				ResourceType, Cost)
SELECT	'UNIT_JFD_REGAL_SHIP', 	ResourceType, Cost
FROM Unit_ResourceQuantityRequirements WHERE UnitType = 'UNIT_FRIGATE';
--------------------------------	
-- Unit_FreePromotions
--------------------------------	
INSERT INTO Unit_FreePromotions 	
		(UnitType, 				PromotionType)
SELECT	'UNIT_JFD_REGAL_SHIP', 	PromotionType
FROM Unit_FreePromotions WHERE UnitType = 'UNIT_FRIGATE';	

INSERT INTO Unit_FreePromotions
		(UnitType, 				PromotionType)
VALUES	('UNIT_JFD_REGAL_SHIP', 'PROMOTION_JFD_REGAL_SHIP_COAST'),
		('UNIT_JFD_REGAL_SHIP', 'PROMOTION_JFD_REGAL_SHIP');
--==========================================================================================================================	
-- CIVILIZATIONS
--==========================================================================================================================	
-- Civilizations
--------------------------------		
INSERT INTO Civilizations 	
		(Type, 								DerivativeCiv,			Description, ShortDescription, 	Adjective, 	Civilopedia, CivilopediaTag, DefaultPlayerColor,				ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, 					PortraitIndex, 	AlphaIconAtlas, 				SoundtrackTag, 	MapImage, 					DawnOfManQuote,						DawnOfManImage,		DawnOfManAudio)
SELECT	'CIVILIZATION_JFD_SWEDEN_GUSTAV',	'CIVILIZATION_SWEDEN',	Description, ShortDescription, 	Adjective, 	Civilopedia, CivilopediaTag, 'PLAYERCOLOR_JFD_SWEDEN_GUSTAV',	ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, 'JFD_SWEDEN_KARL_ATLAS', 	0, 				'JFD_SWEDEN_KARL_ALPHA_ATLAS', 	'Sweden', 		'MapSwedenGustav512.dds',	'TXT_KEY_CIV5_DAWN_SWEDEN_TEXT',	'DOM_Gustav.dds',	'AS2D_DOM_SPEECH_SWEDEN'
FROM Civilizations WHERE Type = 'CIVILIZATION_SWEDEN';
--------------------------------	
-- Civilization_CityNames
--------------------------------	
INSERT INTO Civilization_CityNames
		(CivilizationType,					CityName)
SELECT	'CIVILIZATION_JFD_SWEDEN_GUSTAV',	CityName
FROM Civilization_CityNames WHERE CivilizationType = 'CIVILIZATION_SWEDEN';
--------------------------------	
-- Civilization_FreeBuildingClasses
--------------------------------			
INSERT INTO Civilization_FreeBuildingClasses 
		(CivilizationType, 					BuildingClassType)
SELECT	'CIVILIZATION_JFD_SWEDEN_GUSTAV',	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE CivilizationType = 'CIVILIZATION_SWEDEN';
--------------------------------		
-- Civilization_FreeTechs
--------------------------------			
INSERT INTO Civilization_FreeTechs 
		(CivilizationType, 					TechType)
SELECT	'CIVILIZATION_JFD_SWEDEN_GUSTAV', 	TechType
FROM Civilization_FreeTechs WHERE CivilizationType = 'CIVILIZATION_SWEDEN';
--------------------------------	
-- Civilization_FreeUnits
--------------------------------		
INSERT INTO Civilization_FreeUnits 
		(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT	'CIVILIZATION_JFD_SWEDEN_GUSTAV', 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE CivilizationType = 'CIVILIZATION_SWEDEN';
--------------------------------	
-- Civilization_Leaders
--------------------------------	
INSERT INTO Civilization_Leaders 
		(CivilizationType, 					LeaderheadType)
VALUES	('CIVILIZATION_JFD_SWEDEN_GUSTAV',	'LEADER_GUSTAVUS_ADOLPHUS');
--------------------------------	
-- Civilization_UnitClassOverrides 
--------------------------------		
INSERT INTO Civilization_UnitClassOverrides 
		(CivilizationType, 					UnitClassType, 			UnitType)
VALUES	('CIVILIZATION_JFD_SWEDEN_GUSTAV', 	'UNITCLASS_LANCER',		'UNIT_SWEDISH_HAKKAPELIITTA'),
		('CIVILIZATION_JFD_SWEDEN_GUSTAV', 	'UNITCLASS_FRIGATE',	'UNIT_JFD_REGAL_SHIP');
--------------------------------	
-- Civilization_Religions
--------------------------------			
INSERT INTO Civilization_Religions 
		(CivilizationType, 					ReligionType)
SELECT	'CIVILIZATION_JFD_SWEDEN_GUSTAV',	ReligionType
FROM Civilization_Religions WHERE CivilizationType = 'CIVILIZATION_SWEDEN';
--------------------------------	
-- Civilization_SpyNames
--------------------------------	
INSERT INTO Civilization_SpyNames 
		(CivilizationType, 					SpyName)
SELECT	'CIVILIZATION_JFD_SWEDEN_GUSTAV',	SpyName
FROM Civilization_SpyNames WHERE CivilizationType = 'CIVILIZATION_SWEDEN';
--------------------------------	
-- Civilization_Start_Along_Ocean 
--------------------------------		
INSERT INTO Civilization_Start_Along_Ocean
		(CivilizationType, 					StartAlongOcean)
VALUES	('CIVILIZATION_JFD_SWEDEN_GUSTAV', 	1);
--==========================================================================================================================
--==========================================================================================================================