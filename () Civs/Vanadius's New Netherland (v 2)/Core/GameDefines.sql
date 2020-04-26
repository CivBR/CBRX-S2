--=========================================================================================================================
-- BUILDINGCLASSES
--=========================================================================================================================
-- BuildingClasses
------------------------------
INSERT INTO BuildingClasses 	
		(Type, 						 		DefaultBuilding, 				Description)
VALUES	('BUILDINGCLASS_VANA_NEWNETHERLAND', 		'BUILDING_VANA_GPP',	'TXT_KEY_BUILDING_VANA_DNN');
--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================	
-- Buildings
------------------------------
INSERT INTO Buildings 	
		(Type, 									BuildingClass,					GreatPeopleRateModifier,	TradeRouteLandDistanceModifier, TradeRouteLandGoldBonus, PrereqTech, Cost, FaithCost, GreatWorkCount,	GoldMaintenance, MinAreaSize,	NeverCapture,	Description, 									Help, 												Strategy,										Civilopedia, 							ArtDefineTag, IconAtlas, PortraitIndex)
SELECT	'BUILDING_VANA_BEAVER_FACTORIJ',				BuildingClass,					1,	0, 0, 'TECH_ENGINEERING', Cost, -1,		  0,				GoldMaintenance, MinAreaSize,	1,				'TXT_KEY_BUILDING_VANA_BEAVER_FACTORIJ',				'TXT_KEY_BUILDING_VANA_BEAVER_FACTORIJ_HELP',				'TXT_KEY_BUILDING_VANA_BEAVER_FACTORIJ_STRATEGY',		'TXT_KEY_CIV5_VANA_BEAVER_FACTORIJ_TEXT',		ArtDefineTag, 'VANA_NEWNETHERLAND_ATLAS', 	3
FROM Buildings WHERE Type = 'BUILDING_CARAVANSARY';	

------------------------------	
-- Building_Flavors
------------------------------	
INSERT INTO Building_Flavors 	
		(BuildingType, 					FlavorType,				Flavor)
SELECT	'BUILDING_VANA_BEAVER_FACTORIJ',		FlavorType,				Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_CARAVANSARY';

--------------------------------	
-- Buildings_Invisible
--------------------------------
INSERT INTO Buildings
			(Type,						BuildingClass,					GreatPeopleRateModifier,	TradeRouteSeaDistanceModifier,	TradeRouteSeaDistanceModifier,			Cost,	FaithCost,	GreatWorkCount,	Description,					ArtDefineTag,				Defense,	NeverCapture,	ConquestProb,	NukeImmune,	HurryCostModifier,	MinAreaSize)
VALUES		('BUILDING_VANA_GPP',				'BUILDINGCLASS_VANA_NEWNETHERLAND',			5,		0,		0,		-1,		-1,			-1,				'TXT_KEY_BUILDING_VANA_DNN',	'ART_DEF_BUILDING_CARAVANSARY',	0,			1,				0,				1,			-1,					-1),
			('BUILDING_VANA_FORTS_RANGE',		'BUILDINGCLASS_VANA_NEWNETHERLAND',			0,		10,		10,		-1,		-1,			-1,				'TXT_KEY_BUILDING_VANA_DNN',	'ART_DEF_BUILDING_CARAVANSARY',	0,			1,				0,				1,			-1,					-1),
			('BUILDING_VANA_BEAVER_CULTURE',	'BUILDINGCLASS_VANA_NEWNETHERLAND',			0,		0,		0,		-1,		-1,			-1,				'TXT_KEY_BUILDING_VANA_DNN',	'ART_DEF_BUILDING_CARAVANSARY',	0,			1,				0,				1,			-1,					-1),
			('BUILDING_VANA_FUR',				'BUILDINGCLASS_VANA_NEWNETHERLAND',			0,		0,		0,		-1,		-1,			-1,				'TXT_KEY_BUILDING_VANA_DNN',	'ART_DEF_BUILDING_CARAVANSARY',	0,			1,				0,				1,			-1,					-1);

------------------------------
-- Building_YieldChanges
------------------------------	
INSERT INTO Building_YieldChanges 	
		(BuildingType, 					YieldType,			Yield)
VALUES	('BUILDING_VANA_BEAVER_CULTURE',	'YIELD_CULTURE',		1);

------------------------------
-- Building_ResourceQuantity
------------------------------
INSERT INTO Building_ResourceQuantity
		(BuildingType,				ResourceType,			Quantity)
VALUES	('BUILDING_VANA_FUR',		'RESOURCE_FUR',		1);

--=========================================================================================================================	
-- LEADERS
--=========================================================================================================================	
-- Leaders
--------------------------------			
INSERT INTO Leaders 
		(Type, 							Description, 						Civilopedia, 							CivilopediaTag, 								ArtDefineTag, 						VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 				PortraitIndex)
VALUES	('LEADER_VANA_STUYVESANT', 		'TXT_KEY_LEADER_VANA_STUYVESANT', 	'TXT_KEY_LEADER_VANA_STUYVESANT_PEDIA',	'TXT_KEY_CIVILOPEDIA_LEADERS_VANA_STUYVESANT', 	'Stuyvesant_Scene.xml',	5, 						7, 						8, 							4, 			6, 				5, 				4, 					 6, 			 7, 		5, 			6, 				5, 			3, 			'VANA_NEWNETHERLAND_ATLAS', 	1);
--------------------------------		
-- Leader_MajorCivApproachBiases
--------------------------------						
INSERT INTO Leader_MajorCivApproachBiases 
		(LeaderType, 					MajorCivApproachType, 				Bias)
VALUES	('LEADER_VANA_STUYVESANT', 		'MAJOR_CIV_APPROACH_WAR', 			3),
		('LEADER_VANA_STUYVESANT', 		'MAJOR_CIV_APPROACH_HOSTILE', 		3),
		('LEADER_VANA_STUYVESANT', 		'MAJOR_CIV_APPROACH_DECEPTIVE', 	5),
		('LEADER_VANA_STUYVESANT', 		'MAJOR_CIV_APPROACH_GUARDED', 		7),
		('LEADER_VANA_STUYVESANT', 		'MAJOR_CIV_APPROACH_AFRAID', 		5),
		('LEADER_VANA_STUYVESANT', 		'MAJOR_CIV_APPROACH_FRIENDLY', 		6),
		('LEADER_VANA_STUYVESANT', 		'MAJOR_CIV_APPROACH_NEUTRAL', 		5);
--------------------------------	
-- Leader_MajorCivApproachBiases
--------------------------------							
INSERT INTO Leader_MinorCivApproachBiases 
		(LeaderType, 					MinorCivApproachType, 				Bias)
VALUES	('LEADER_VANA_STUYVESANT',		'MINOR_CIV_APPROACH_IGNORE', 		4),
		('LEADER_VANA_STUYVESANT',		'MINOR_CIV_APPROACH_FRIENDLY', 		7),
		('LEADER_VANA_STUYVESANT',		'MINOR_CIV_APPROACH_PROTECTIVE', 	7),
		('LEADER_VANA_STUYVESANT',		'MINOR_CIV_APPROACH_CONQUEST', 		2),
		('LEADER_VANA_STUYVESANT',		'MINOR_CIV_APPROACH_BULLY', 		3);
--------------------------------		
-- Leader_Flavors
--------------------------------								
INSERT INTO Leader_Flavors 
		(LeaderType, 					FlavorType, 						Flavor)
VALUES	('LEADER_VANA_STUYVESANT', 		'FLAVOR_OFFENSE', 					3),
		('LEADER_VANA_STUYVESANT', 		'FLAVOR_DEFENSE', 					5),
		('LEADER_VANA_STUYVESANT', 		'FLAVOR_CITY_DEFENSE', 				5),
		('LEADER_VANA_STUYVESANT', 		'FLAVOR_MILITARY_TRAINING', 		4),
		('LEADER_VANA_STUYVESANT', 		'FLAVOR_RECON', 					3),
		('LEADER_VANA_STUYVESANT', 		'FLAVOR_RANGED', 					4),
		('LEADER_VANA_STUYVESANT', 		'FLAVOR_MOBILE', 					3),
		('LEADER_VANA_STUYVESANT', 		'FLAVOR_NAVAL', 					3),
		('LEADER_VANA_STUYVESANT', 		'FLAVOR_NAVAL_RECON', 				3),
		('LEADER_VANA_STUYVESANT', 		'FLAVOR_NAVAL_GROWTH', 				3),
		('LEADER_VANA_STUYVESANT', 		'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	3),
		('LEADER_VANA_STUYVESANT', 		'FLAVOR_AIR', 						3),
		('LEADER_VANA_STUYVESANT', 		'FLAVOR_EXPANSION', 				4),
		('LEADER_VANA_STUYVESANT', 		'FLAVOR_GROWTH', 					5),
		('LEADER_VANA_STUYVESANT', 		'FLAVOR_TILE_IMPROVEMENT', 			4),
		('LEADER_VANA_STUYVESANT', 		'FLAVOR_INFRASTRUCTURE', 			5),
		('LEADER_VANA_STUYVESANT', 		'FLAVOR_PRODUCTION', 				3),
		('LEADER_VANA_STUYVESANT', 		'FLAVOR_GOLD', 						7),
		('LEADER_VANA_STUYVESANT', 		'FLAVOR_SCIENCE', 					5),
		('LEADER_VANA_STUYVESANT', 		'FLAVOR_CULTURE', 					8),
		('LEADER_VANA_STUYVESANT', 		'FLAVOR_HAPPINESS', 				5),
		('LEADER_VANA_STUYVESANT', 		'FLAVOR_GREAT_PEOPLE', 				7),
		('LEADER_VANA_STUYVESANT', 		'FLAVOR_WONDER', 					7),
		('LEADER_VANA_STUYVESANT', 		'FLAVOR_RELIGION', 					4),
		('LEADER_VANA_STUYVESANT', 		'FLAVOR_DIPLOMACY', 				4),
		('LEADER_VANA_STUYVESANT', 		'FLAVOR_SPACESHIP', 				2),
		('LEADER_VANA_STUYVESANT', 		'FLAVOR_WATER_CONNECTION', 			6),
		('LEADER_VANA_STUYVESANT', 		'FLAVOR_NUKE', 						2),
		('LEADER_VANA_STUYVESANT', 		'FLAVOR_USE_NUKE', 					2),
		('LEADER_VANA_STUYVESANT', 		'FLAVOR_ESPIONAGE', 				3),
		('LEADER_VANA_STUYVESANT', 		'FLAVOR_AIRLIFT', 					2),
		('LEADER_VANA_STUYVESANT', 		'FLAVOR_I_TRADE_DESTINATION', 		8),
		('LEADER_VANA_STUYVESANT', 		'FLAVOR_I_TRADE_ORIGIN', 			8),
		('LEADER_VANA_STUYVESANT', 		'FLAVOR_I_SEA_TRADE_ROUTE', 		8),
		('LEADER_VANA_STUYVESANT', 		'FLAVOR_I_LAND_TRADE_ROUTE', 		8),
		('LEADER_VANA_STUYVESANT', 		'FLAVOR_ARCHAEOLOGY', 				5),
		('LEADER_VANA_STUYVESANT', 		'FLAVOR_AIR_CARRIER', 				5);
--------------------------------		
-- Leader_Traits
--------------------------------		
INSERT INTO Leader_Traits 
		(LeaderType, 					TraitType)
VALUES	('LEADER_VANA_STUYVESANT', 		'TRAIT_VANA_NEWNETHERLAND');
--==========================================================================================================================	
-- TRAITS
--==========================================================================================================================	
-- Traits
--------------------------------	
INSERT INTO Traits 
		(Type, 							Description, 						ShortDescription)
VALUES	('TRAIT_VANA_NEWNETHERLAND',			'TXT_KEY_TRAIT_VANA_NEWNETHERLAND',		'TXT_KEY_TRAIT_VANA_NEWNETHERLAND_SHORT');	
--==========================================================================================================================	
-- CIVILIZATIONS
--==========================================================================================================================	
-- Civilizations
--------------------------------		
INSERT INTO Civilizations 	
		(Type, 							Description,						ShortDescription, 						Adjective, 								Civilopedia, 							CivilopediaTag, 				DefaultPlayerColor,				ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, 				PortraitIndex, 	AlphaIconAtlas, 			SoundtrackTag, 	MapImage, 							DawnOfManQuote, 					DawnOfManImage)
SELECT	'CIVILIZATION_VANA_NEWNETHERLAND',	'TXT_KEY_CIV_VANA_NEWNETHERLAND_DESC',	'TXT_KEY_CIV_VANA_NEWNETHERLAND_SHORT_DESC',	'TXT_KEY_CIV_VANA_NEWNETHERLAND_ADJECTIVE',	'TXT_KEY_CIV5_VANA_NEWNETHERLAND_TEXT_1',		'TXT_KEY_CIV5_VANA_NEWNETHERLAND', 	'PLAYERCOLOR_VANA_NEWNETHERLAND',		ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, 'VANA_NEWNETHERLAND_ATLAS',	0, 				'VANA_NEWNETHERLAND_ALPHA_ATLAS',	SoundtrackTag, 		'NNMapSmall.dds',		DawnOfManQuote,	'NNDOM.dds'
FROM Civilizations WHERE Type = 'CIVILIZATION_NETHERLANDS';
--------------------------------	
-- Civilization_CityNames
--------------------------------	
INSERT INTO Civilization_CityNames
		(CivilizationType, 				CityName)
VALUES	('CIVILIZATION_VANA_NEWNETHERLAND',   'TXT_KEY_CITY_NAME_VANA_NIEUW_AMSTERDAM'),
		('CIVILIZATION_VANA_NEWNETHERLAND',   'TXT_KEY_CITY_NAME_VANA_BEVERWYCK'),
		('CIVILIZATION_VANA_NEWNETHERLAND',   'TXT_KEY_CITY_NAME_VANA_BEVERSREDE'),
		('CIVILIZATION_VANA_NEWNETHERLAND',   'TXT_KEY_CITY_NAME_VANA_NIEUW_AMSTEL'),
		('CIVILIZATION_VANA_NEWNETHERLAND',   'TXT_KEY_CITY_NAME_VANA_WILTWYCK'),
		('CIVILIZATION_VANA_NEWNETHERLAND',   'TXT_KEY_CITY_NAME_VANA_SLAPERSHAVEN'),
		('CIVILIZATION_VANA_NEWNETHERLAND',   'TXT_KEY_CITY_NAME_VANA_KINDERHOEK'),
		('CIVILIZATION_VANA_NEWNETHERLAND',   'TXT_KEY_CITY_NAME_VANA_SWAANENDAEL'),
		('CIVILIZATION_VANA_NEWNETHERLAND',   'TXT_KEY_CITY_NAME_VANA_HEENSTEDE'),
		('CIVILIZATION_VANA_NEWNETHERLAND',   'TXT_KEY_CITY_NAME_VANA_KIEVTIS_HOEK'),
		('CIVILIZATION_VANA_NEWNETHERLAND',   'TXT_KEY_CITY_NAME_VANA_HUYS_DE_GOEDE_HOOP'),
		('CIVILIZATION_VANA_NEWNETHERLAND',   'TXT_KEY_CITY_NAME_VANA_BARNDE_GAT'),
		('CIVILIZATION_VANA_NEWNETHERLAND',   'TXT_KEY_CITY_NAME_VANA_ALTENA'),
		('CIVILIZATION_VANA_NEWNETHERLAND',   'TXT_KEY_CITY_NAME_VANA_RENSSELAERWYCK'),
		('CIVILIZATION_VANA_NEWNETHERLAND',   'TXT_KEY_CITY_NAME_VANA_HAVERSTROO'),
		('CIVILIZATION_VANA_NEWNETHERLAND',   'TXT_KEY_CITY_NAME_VANA_TERWE_DORP'),
		('CIVILIZATION_VANA_NEWNETHERLAND',   'TXT_KEY_CITY_NAME_VANA_RODENBERG'),
		('CIVILIZATION_VANA_NEWNETHERLAND',   'TXT_KEY_CITY_NAME_VANA_SCHENECTADY'),
		('CIVILIZATION_VANA_NEWNETHERLAND',   'TXT_KEY_CITY_NAME_VANA_NOORTWYCK'),
		('CIVILIZATION_VANA_NEWNETHERLAND',   'TXT_KEY_CITY_NAME_VANA_NIEUW_HAARLEM'),
		('CIVILIZATION_VANA_NEWNETHERLAND',   'TXT_KEY_CITY_NAME_VANA_BRONCKS'),
		('CIVILIZATION_VANA_NEWNETHERLAND',   'TXT_KEY_CITY_NAME_VANA_VRIESSENDAEL'),
		('CIVILIZATION_VANA_NEWNETHERLAND',   'TXT_KEY_CITY_NAME_VANA_BREUCKELEN'),
		('CIVILIZATION_VANA_NEWNETHERLAND',   'TXT_KEY_CITY_NAME_VANA_MASPAT'),
		('CIVILIZATION_VANA_NEWNETHERLAND',   'TXT_KEY_CITY_NAME_VANA_BOSWYCK'),
		('CIVILIZATION_VANA_NEWNETHERLAND',   'TXT_KEY_CITY_NAME_VANA_ROODE_HOEK'),
		('CIVILIZATION_VANA_NEWNETHERLAND',   'TXT_KEY_CITY_NAME_VANA_NIEUW_UTRECHT'),
		('CIVILIZATION_VANA_NEWNETHERLAND',   'TXT_KEY_CITY_NAME_VANA_OUDE_DORP'),
		('CIVILIZATION_VANA_NEWNETHERLAND',   'TXT_KEY_CITY_NAME_VANA_NIEUW_DORP'),
		('CIVILIZATION_VANA_NEWNETHERLAND',   'TXT_KEY_CITY_NAME_VANA_RYCKENS_EYLANDT'),
		('CIVILIZATION_VANA_NEWNETHERLAND',   'TXT_KEY_CITY_NAME_VANA_MIDWOUT'),
		('CIVILIZATION_VANA_NEWNETHERLAND',   'TXT_KEY_CITY_NAME_VANA_GRAVESEND'),
		('CIVILIZATION_VANA_NEWNETHERLAND',   'TXT_KEY_CITY_NAME_VANA_AMERSFOORT'),
		('CIVILIZATION_VANA_NEWNETHERLAND',   'TXT_KEY_CITY_NAME_VANA_RUSTDORP'),
		('CIVILIZATION_VANA_NEWNETHERLAND',   'TXT_KEY_CITY_NAME_VANA_JONKHEER'),
		('CIVILIZATION_VANA_NEWNETHERLAND',   'TXT_KEY_CITY_NAME_VANA_OESTER_BAAI'),
		('CIVILIZATION_VANA_NEWNETHERLAND',   'TXT_KEY_CITY_NAME_VANA_NEWNETHERLAND_37');

--------------------------------	
-- Civilization_FreeBuildingClasses
--------------------------------			
INSERT INTO Civilization_FreeBuildingClasses 
		(CivilizationType, 				BuildingClassType)
SELECT	'CIVILIZATION_VANA_NEWNETHERLAND', 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE CivilizationType = 'CIVILIZATION_NETHERLANDS';
--------------------------------		
-- Civilization_FreeTechs
--------------------------------			
INSERT INTO Civilization_FreeTechs 
		(CivilizationType, 				TechType)
SELECT	'CIVILIZATION_VANA_NEWNETHERLAND',	TechType
FROM Civilization_FreeTechs WHERE CivilizationType = 'CIVILIZATION_NETHERLANDS';
--------------------------------	
-- Civilization_FreeUnits
--------------------------------		
INSERT INTO Civilization_FreeUnits 
		(CivilizationType, 				UnitClassType, Count, UnitAIType)
SELECT	'CIVILIZATION_VANA_NEWNETHERLAND', 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE CivilizationType = 'CIVILIZATION_NETHERLANDS';
--------------------------------	
-- Civilization_Leaders
--------------------------------		
INSERT INTO Civilization_Leaders 
		(CivilizationType, 				LeaderheadType)
VALUES	('CIVILIZATION_VANA_NEWNETHERLAND', 	'LEADER_VANA_STUYVESANT');
--------------------------------	
-- Civilization_BuildingClassOverrides 
--------------------------------		
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 				BuildingClassType, 				BuildingType)
VALUES	('CIVILIZATION_VANA_NEWNETHERLAND',	'BUILDINGCLASS_CARAVANSARY',	'BUILDING_VANA_BEAVER_FACTORIJ');
--------------------------------	
-- Civilization_UnitClassOverrides 
--------------------------------		
INSERT INTO Civilization_UnitClassOverrides 
		(CivilizationType, 				UnitClassType, 			UnitType)
VALUES	('CIVILIZATION_VANA_NEWNETHERLAND', 	'UNITCLASS_MUSKETMAN', 	'UNIT_VANA_SCHUTTERIJ');
--------------------------------	
-- Civilization_Religions
--------------------------------			
INSERT INTO Civilization_Religions 
		(CivilizationType, 				ReligionType)
VALUES	('CIVILIZATION_VANA_NEWNETHERLAND', 	'RELIGION_PROTESTANTISM');
--------------------------------	
-- Civilization_SpyNames
--------------------------------	
INSERT INTO Civilization_SpyNames
		(CivilizationType, 				SpyName)
VALUES	('CIVILIZATION_VANA_NEWNETHERLAND', 	'TXT_KEY_SPY_NAME_VANA_NEWNETHERLAND_0'),
		('CIVILIZATION_VANA_NEWNETHERLAND', 	'TXT_KEY_SPY_NAME_VANA_NEWNETHERLAND_1'),
		('CIVILIZATION_VANA_NEWNETHERLAND', 	'TXT_KEY_SPY_NAME_VANA_NEWNETHERLAND_2'),
		('CIVILIZATION_VANA_NEWNETHERLAND', 	'TXT_KEY_SPY_NAME_VANA_NEWNETHERLAND_3'),
		('CIVILIZATION_VANA_NEWNETHERLAND', 	'TXT_KEY_SPY_NAME_VANA_NEWNETHERLAND_4'),
		('CIVILIZATION_VANA_NEWNETHERLAND', 	'TXT_KEY_SPY_NAME_VANA_NEWNETHERLAND_5'),
		('CIVILIZATION_VANA_NEWNETHERLAND', 	'TXT_KEY_SPY_NAME_VANA_NEWNETHERLAND_6'),
		('CIVILIZATION_VANA_NEWNETHERLAND', 	'TXT_KEY_SPY_NAME_VANA_NEWNETHERLAND_7'),
		('CIVILIZATION_VANA_NEWNETHERLAND', 	'TXT_KEY_SPY_NAME_VANA_NEWNETHERLAND_8'),
		('CIVILIZATION_VANA_NEWNETHERLAND', 	'TXT_KEY_SPY_NAME_VANA_NEWNETHERLAND_9');

--==========================================================================================================================	
-- UNITS
--==========================================================================================================================
-- Units
--------------------------------	
INSERT INTO Units 	
			(Class, Type, 						PrereqTech, Combat, Cost, 	FaithCost, 	RequiresFaithPurchaseEnabled, Moves, HurryCostModifier,	CombatClass, Domain, DefaultUnitAI, Description, 					Civilopedia, 					Strategy, 							Help, 							MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, XPValueAttack, XPValueDefense, Conscription, UnitArtInfo, 					UnitFlagAtlas, 							UnitFlagIconOffset, PortraitIndex, 	IconAtlas, 						MoveRate)
SELECT		Class, 	('UNIT_VANA_SCHUTTERIJ'), PrereqTech, 20, 175, 	FaithCost, 	RequiresFaithPurchaseEnabled, Moves, HurryCostModifier,	CombatClass, Domain, DefaultUnitAI, ('TXT_KEY_UNIT_VANA_SCHUTTERIJ'), ('TXT_KEY_CIV5_UNIT_VANA_SCHUTTERIJ_TEXT'), ('TXT_KEY_UNIT_VANA_SCHUTTERIJ_STRATEGY'), ('TXT_KEY_UNIT_VANA_SCHUTTERIJ_HELP'),	MilitarySupport, MilitaryProduction, Pillage, ('TECH_RIFLING'), AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, XPValueAttack, XPValueDefense, Conscription, ('ART_DEF_UNIT_VANA_SCHUTTERIJ'), ('VANA_SCHUTTERIJ_FLAG'), 	0,					2, 				('VANA_NEWNETHERLAND_ATLAS'), 	MoveRate
FROM Units WHERE (Type = 'UNIT_MUSKETMAN');
--------------------------------
-- UnitGameplay2DScripts
--------------------------------	
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT		('UNIT_VANA_SCHUTTERIJ'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_MUSKETMAN');	
--------------------------------
-- Unit_AITypes
--------------------------------	
INSERT INTO Unit_AITypes 	
			(UnitType, 				UnitAIType)
SELECT		('UNIT_VANA_SCHUTTERIJ'), UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_MUSKETMAN');
--------------------------------
-- Unit_Flavors
--------------------------------	
INSERT INTO Unit_Flavors 	
			(UnitType, 				FlavorType,	Flavor)
SELECT		('UNIT_VANA_SCHUTTERIJ'), FlavorType,	Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_MUSKETMAN');
--------------------------------
-- Unit_ClassUpgrades
--------------------------------	
INSERT OR REPLACE INTO Unit_ClassUpgrades 	
			(UnitType, 					UnitClassType)
VALUES		('UNIT_VANA_SCHUTTERIJ', 'UNITCLASS_RIFLEMAN');
--==========================================================================================================================
--==========================================================================================================================