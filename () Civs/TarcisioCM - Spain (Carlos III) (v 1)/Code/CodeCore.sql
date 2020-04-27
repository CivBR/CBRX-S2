--==========================================================================================================================		
--==========================================================================================================================
-- Civilizations
--==========================================================================================================================
INSERT INTO Civilizations 	
			(Type, 									DerivativeCiv,				Description, 								ShortDescription, 							  Adjective, 									Civilopedia, 								CivilopediaTag, 						DefaultPlayerColor,		 		   ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas,					AlphaIconAtlas, 				   PortraitIndex,	SoundtrackTag, 	MapImage, 						DawnOfManQuote, 					  		 DawnOfManImage)
SELECT		('CIVILIZATION_TCM_BOURBON_SPAIN'),		('CIVILIZATION_SPAIN'),		('TXT_KEY_CIV_TCM_BOURBON_SPAIN_DESC'), 	('TXT_KEY_CIV_TCM_BOURBON_SPAIN_SHORT_DESC'), ('TXT_KEY_CIV_TCM_BOURBON_SPAIN_ADJECTIVE'), 	('TXT_KEY_CIV5_TCM_BOURBON_SPAIN_TEXT_1'),	('TXT_KEY_CIV5_TCM_BOURBON_SPAIN'), 	('PLAYERCOLOR_TCM_BOURBON_SPAIN'), ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('TCM_BOURBON_SPAIN_ATLAS'), ('TCM_BOURBON_SPAIN_ALPHA_ATLAS'), 0, 				('SPAIN'),	 	('TCM_BOURBON_SPAIN_MAP.dds'), 	('TXT_KEY_CIV5_DOM_TCM_BOURBON_SPAIN_TEXT'), ('TCM_BOURBON_SPAIN_DOM.dds')
FROM Civilizations WHERE Type = 'CIVILIZATION_SPAIN';
--==========================================================================================================================
-- Civilization_CityNames
--==========================================================================================================================		
INSERT INTO Civilization_CityNames 
			(CivilizationType, 						CityName)
VALUES		('CIVILIZATION_TCM_BOURBON_SPAIN', 		'TXT_KEY_CITY_NAME_TCM_BOURBON_SPAIN_01'),
			('CIVILIZATION_TCM_BOURBON_SPAIN', 		'TXT_KEY_CITY_NAME_TCM_BOURBON_SPAIN_02'),
			('CIVILIZATION_TCM_BOURBON_SPAIN', 		'TXT_KEY_CITY_NAME_TCM_BOURBON_SPAIN_03'),
			('CIVILIZATION_TCM_BOURBON_SPAIN', 		'TXT_KEY_CITY_NAME_TCM_BOURBON_SPAIN_04'),
			('CIVILIZATION_TCM_BOURBON_SPAIN', 		'TXT_KEY_CITY_NAME_TCM_BOURBON_SPAIN_05'),
			('CIVILIZATION_TCM_BOURBON_SPAIN', 		'TXT_KEY_CITY_NAME_TCM_BOURBON_SPAIN_06'),
			('CIVILIZATION_TCM_BOURBON_SPAIN', 		'TXT_KEY_CITY_NAME_TCM_BOURBON_SPAIN_07'),
			('CIVILIZATION_TCM_BOURBON_SPAIN', 		'TXT_KEY_CITY_NAME_TCM_BOURBON_SPAIN_08'),
			('CIVILIZATION_TCM_BOURBON_SPAIN', 		'TXT_KEY_CITY_NAME_TCM_BOURBON_SPAIN_09'),
			('CIVILIZATION_TCM_BOURBON_SPAIN', 		'TXT_KEY_CITY_NAME_TCM_BOURBON_SPAIN_10'),
			('CIVILIZATION_TCM_BOURBON_SPAIN', 		'TXT_KEY_CITY_NAME_TCM_BOURBON_SPAIN_11'),
			('CIVILIZATION_TCM_BOURBON_SPAIN', 		'TXT_KEY_CITY_NAME_TCM_BOURBON_SPAIN_12'),
			('CIVILIZATION_TCM_BOURBON_SPAIN', 		'TXT_KEY_CITY_NAME_TCM_BOURBON_SPAIN_13'),
			('CIVILIZATION_TCM_BOURBON_SPAIN', 		'TXT_KEY_CITY_NAME_TCM_BOURBON_SPAIN_14'),
			('CIVILIZATION_TCM_BOURBON_SPAIN', 		'TXT_KEY_CITY_NAME_TCM_BOURBON_SPAIN_15'),
			('CIVILIZATION_TCM_BOURBON_SPAIN', 		'TXT_KEY_CITY_NAME_TCM_BOURBON_SPAIN_16'),
			('CIVILIZATION_TCM_BOURBON_SPAIN', 		'TXT_KEY_CITY_NAME_TCM_BOURBON_SPAIN_17'),
			('CIVILIZATION_TCM_BOURBON_SPAIN', 		'TXT_KEY_CITY_NAME_TCM_BOURBON_SPAIN_18'),
			('CIVILIZATION_TCM_BOURBON_SPAIN', 		'TXT_KEY_CITY_NAME_TCM_BOURBON_SPAIN_19'),
			('CIVILIZATION_TCM_BOURBON_SPAIN', 		'TXT_KEY_CITY_NAME_TCM_BOURBON_SPAIN_20'),
			('CIVILIZATION_TCM_BOURBON_SPAIN', 		'TXT_KEY_CITY_NAME_TCM_BOURBON_SPAIN_21'),
			('CIVILIZATION_TCM_BOURBON_SPAIN', 		'TXT_KEY_CITY_NAME_TCM_BOURBON_SPAIN_22'),
			('CIVILIZATION_TCM_BOURBON_SPAIN', 		'TXT_KEY_CITY_NAME_TCM_BOURBON_SPAIN_23'),
			('CIVILIZATION_TCM_BOURBON_SPAIN', 		'TXT_KEY_CITY_NAME_TCM_BOURBON_SPAIN_24'),
			('CIVILIZATION_TCM_BOURBON_SPAIN', 		'TXT_KEY_CITY_NAME_TCM_BOURBON_SPAIN_25'),
			('CIVILIZATION_TCM_BOURBON_SPAIN', 		'TXT_KEY_CITY_NAME_TCM_BOURBON_SPAIN_26'),
			('CIVILIZATION_TCM_BOURBON_SPAIN', 		'TXT_KEY_CITY_NAME_TCM_BOURBON_SPAIN_27'),
			('CIVILIZATION_TCM_BOURBON_SPAIN', 		'TXT_KEY_CITY_NAME_TCM_BOURBON_SPAIN_28'),
			('CIVILIZATION_TCM_BOURBON_SPAIN', 		'TXT_KEY_CITY_NAME_TCM_BOURBON_SPAIN_29'),
			('CIVILIZATION_TCM_BOURBON_SPAIN', 		'TXT_KEY_CITY_NAME_TCM_BOURBON_SPAIN_30');
--==========================================================================================================================
-- Civilization_FreeBuildingClasses
--==========================================================================================================================		
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
VALUES		('CIVILIZATION_TCM_BOURBON_SPAIN', 	'BUILDINGCLASS_PALACE');
--==========================================================================================================================
-- Civilization_FreeTechs
--==========================================================================================================================	
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 						TechType)
SELECT		('CIVILIZATION_TCM_BOURBON_SPAIN'), 	TechType
FROM Civilization_FreeTechs WHERE CivilizationType = 'CIVILIZATION_SPAIN';
--==========================================================================================================================
-- Civilization_FreeUnits
--==========================================================================================================================	
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 						UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_TCM_BOURBON_SPAIN'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE CivilizationType = 'CIVILIZATION_SPAIN';
--==========================================================================================================================
-- Civilization_Leaders
--==========================================================================================================================		
INSERT INTO Civilization_Leaders 
			(CivilizationType, 					LeaderheadType)
VALUES		('CIVILIZATION_TCM_BOURBON_SPAIN', 	'LEADER_TCM_CHARLES_III');
--==========================================================================================================================
-- Civilization_UnitClassOverrides
--==========================================================================================================================	
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 					UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_TCM_BOURBON_SPAIN', 	'UNITCLASS_RIFLEMAN', 	'UNIT_TCM_WALLOON_GUARD'),
			('CIVILIZATION_TCM_BOURBON_SPAIN', 	'UNITCLASS_FRIGATE', 	'UNIT_TCM_SANTISIMA_TRINIDAD');
--==========================================================================================================================
-- Civilization_Religions
--==========================================================================================================================	
INSERT INTO Civilization_Religions 
			(CivilizationType, 					ReligionType)
VALUES		('CIVILIZATION_TCM_BOURBON_SPAIN', 	'RELIGION_CHRISTIANITY');
--==========================================================================================================================
-- Civilization_SpyNames
--==========================================================================================================================	
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		('CIVILIZATION_TCM_BOURBON_SPAIN', 	'TXT_KEY_SPY_NAME_TCM_BOURBON_SPAIN_0'),	
			('CIVILIZATION_TCM_BOURBON_SPAIN', 	'TXT_KEY_SPY_NAME_TCM_BOURBON_SPAIN_1'),
			('CIVILIZATION_TCM_BOURBON_SPAIN', 	'TXT_KEY_SPY_NAME_TCM_BOURBON_SPAIN_2'),
			('CIVILIZATION_TCM_BOURBON_SPAIN', 	'TXT_KEY_SPY_NAME_TCM_BOURBON_SPAIN_3'),
			('CIVILIZATION_TCM_BOURBON_SPAIN', 	'TXT_KEY_SPY_NAME_TCM_BOURBON_SPAIN_4'),
			('CIVILIZATION_TCM_BOURBON_SPAIN', 	'TXT_KEY_SPY_NAME_TCM_BOURBON_SPAIN_5'),
			('CIVILIZATION_TCM_BOURBON_SPAIN', 	'TXT_KEY_SPY_NAME_TCM_BOURBON_SPAIN_6'),
			('CIVILIZATION_TCM_BOURBON_SPAIN', 	'TXT_KEY_SPY_NAME_TCM_BOURBON_SPAIN_7'),
			('CIVILIZATION_TCM_BOURBON_SPAIN', 	'TXT_KEY_SPY_NAME_TCM_BOURBON_SPAIN_8'),
			('CIVILIZATION_TCM_BOURBON_SPAIN', 	'TXT_KEY_SPY_NAME_TCM_BOURBON_SPAIN_9');
--==========================================================================================================================	
-- Colors
--==========================================================================================================================			
INSERT INTO Colors 
			(Type, 											Red, 	Green, 	Blue, 	Alpha)
VALUES		('COLOR_PLAYER_TCM_BOURBON_SPAIN_ICON',			0.259,	0.031,	0,		1),
			('COLOR_PLAYER_TCM_BOURBON_SPAIN_BACKGROUND',	0.769,	0.729,	0.588,	1); 
--==========================================================================================================================	
-- PlayerColors
--==========================================================================================================================				
INSERT INTO PlayerColors 
			(Type, 								PrimaryColor, 							SecondaryColor, 								TextColor)
VALUES		('PLAYERCOLOR_TCM_BOURBON_SPAIN',	'COLOR_PLAYER_TCM_BOURBON_SPAIN_ICON', 	'COLOR_PLAYER_TCM_BOURBON_SPAIN_BACKGROUND', 	'COLOR_PLAYER_WHITE_TEXT');
--==========================================================================================================================	
--==========================================================================================================================	
--==========================================================================================================================	
-- Leaders
--==========================================================================================================================			
INSERT INTO Leaders 
			(Type, 						Description, 						Civilopedia, 								 CivilopediaTag, 						 ArtDefineTag, 					VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 					PortraitIndex)
VALUES		('LEADER_TCM_CHARLES_III', 	'TXT_KEY_LEADER_TCM_CHARLES_III', 	'TXT_KEY_LEADER_TCM_CHARLES_III_PEDIA_TEXT', 'TXT_KEY_LEADER_TCM_CHARLES_III_PEDIA', 'CarlosIII_Leaderhead.xml',	3, 						5, 						3, 							4, 			7, 				6, 				5, 					 7, 			 7, 		5, 			4, 				5, 			3, 			'TCM_BOURBON_SPAIN_ATLAS', 	1);
--==========================================================================================================================	
-- Leader_MajorCivApproachBiases
--==========================================================================================================================						
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 			MajorCivApproachType, 				Bias)
VALUES		('LEADER_TCM_CHARLES_III', 	'MAJOR_CIV_APPROACH_WAR', 		3),
			('LEADER_TCM_CHARLES_III', 	'MAJOR_CIV_APPROACH_HOSTILE', 	2),
			('LEADER_TCM_CHARLES_III', 	'MAJOR_CIV_APPROACH_GUARDED', 	6),
			('LEADER_TCM_CHARLES_III', 	'MAJOR_CIV_APPROACH_AFRAID', 	3),
			('LEADER_TCM_CHARLES_III', 	'MAJOR_CIV_APPROACH_FRIENDLY', 	7),
			('LEADER_TCM_CHARLES_III', 	'MAJOR_CIV_APPROACH_NEUTRAL', 	5);
--==========================================================================================================================	
-- Leader_MajorCivApproachBiases
--==========================================================================================================================						
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 			MinorCivApproachType, 					Bias)
VALUES		('LEADER_TCM_CHARLES_III', 	'MINOR_CIV_APPROACH_IGNORE', 		3),
			('LEADER_TCM_CHARLES_III', 	'MINOR_CIV_APPROACH_FRIENDLY', 		6),
			('LEADER_TCM_CHARLES_III', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	5),
			('LEADER_TCM_CHARLES_III', 	'MINOR_CIV_APPROACH_CONQUEST', 		2),
			('LEADER_TCM_CHARLES_III', 	'MINOR_CIV_APPROACH_BULLY', 		3);
--==========================================================================================================================	
-- Leader_Flavors
--==========================================================================================================================						
INSERT INTO Leader_Flavors 
			(LeaderType, 			FlavorType, 							Flavor)
VALUES		('LEADER_TCM_CHARLES_III', 	'FLAVOR_OFFENSE', 					5),
			('LEADER_TCM_CHARLES_III', 	'FLAVOR_DEFENSE', 					5),
			('LEADER_TCM_CHARLES_III', 	'FLAVOR_CITY_DEFENSE', 				5),
			('LEADER_TCM_CHARLES_III', 	'FLAVOR_MILITARY_TRAINING', 		6),
			('LEADER_TCM_CHARLES_III', 	'FLAVOR_RECON', 					5),
			('LEADER_TCM_CHARLES_III', 	'FLAVOR_RANGED', 					5),
			('LEADER_TCM_CHARLES_III', 	'FLAVOR_MOBILE', 					5),
			('LEADER_TCM_CHARLES_III', 	'FLAVOR_NAVAL', 					8),
			('LEADER_TCM_CHARLES_III', 	'FLAVOR_NAVAL_RECON', 				5),
			('LEADER_TCM_CHARLES_III', 	'FLAVOR_NAVAL_GROWTH', 				7),
			('LEADER_TCM_CHARLES_III', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	6),
			('LEADER_TCM_CHARLES_III', 	'FLAVOR_AIR', 						5),
			('LEADER_TCM_CHARLES_III', 	'FLAVOR_EXPANSION', 				7),
			('LEADER_TCM_CHARLES_III', 	'FLAVOR_GROWTH', 					5),
			('LEADER_TCM_CHARLES_III', 	'FLAVOR_TILE_IMPROVEMENT', 			6),
			('LEADER_TCM_CHARLES_III', 	'FLAVOR_INFRASTRUCTURE', 			5),
			('LEADER_TCM_CHARLES_III', 	'FLAVOR_PRODUCTION', 				5),
			('LEADER_TCM_CHARLES_III', 	'FLAVOR_GOLD', 						6),
			('LEADER_TCM_CHARLES_III', 	'FLAVOR_SCIENCE', 					6),
			('LEADER_TCM_CHARLES_III', 	'FLAVOR_CULTURE', 					7),
			('LEADER_TCM_CHARLES_III', 	'FLAVOR_HAPPINESS', 				8),
			('LEADER_TCM_CHARLES_III', 	'FLAVOR_GREAT_PEOPLE', 				7),
			('LEADER_TCM_CHARLES_III', 	'FLAVOR_WONDER', 					7),
			('LEADER_TCM_CHARLES_III', 	'FLAVOR_RELIGION', 					6),
			('LEADER_TCM_CHARLES_III', 	'FLAVOR_DIPLOMACY', 				8),
			('LEADER_TCM_CHARLES_III', 	'FLAVOR_SPACESHIP', 				7),
			('LEADER_TCM_CHARLES_III', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_TCM_CHARLES_III', 	'FLAVOR_NUKE', 						4),
			('LEADER_TCM_CHARLES_III', 	'FLAVOR_USE_NUKE', 					2),
			('LEADER_TCM_CHARLES_III', 	'FLAVOR_ESPIONAGE', 				6),
			('LEADER_TCM_CHARLES_III', 	'FLAVOR_AIRLIFT', 					5),
			('LEADER_TCM_CHARLES_III', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_TCM_CHARLES_III', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_TCM_CHARLES_III', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		7),
			('LEADER_TCM_CHARLES_III', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_TCM_CHARLES_III', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_TCM_CHARLES_III', 	'FLAVOR_AIR_CARRIER', 				5);
--==========================================================================================================================	
-- Leader_Traits
--==========================================================================================================================	
INSERT INTO Leader_Traits 
			(LeaderType, 				TraitType)
VALUES		('LEADER_TCM_CHARLES_III', 	'TRAIT_TCM_CHARLES_III_BOURBON_SPAIN');
--==========================================================================================================================	
-- Traits
--==========================================================================================================================	
INSERT INTO Traits 
			(Type, 										Description, 									ShortDescription)
VALUES		('TRAIT_TCM_CHARLES_III_BOURBON_SPAIN', 	'TXT_KEY_TRAIT_TCM_CHARLES_III_BOURBON_SPAIN', 	'TXT_KEY_TRAIT_TCM_CHARLES_III_BOURBON_SPAIN_SHORT');
--==========================================================================================================================
-- AUDIO
--==========================================================================================================================	
-- Audio_Sounds
------------------------------	
INSERT INTO Audio_Sounds 
			(SoundID, 									Filename, 					LoadType)
VALUES		('SND_LEADER_MUSIC_TCM_CHARLES_III_PEACE', 	'TCM_BOURBON_SPAIN_PEACE', 	'DynamicResident'),
			('SND_LEADER_MUSIC_TCM_CHARLES_III_WAR',	'TCM_BOURBON_SPAIN_WAR', 	'DynamicResident');
------------------------------
-- Audio_2DSounds
------------------------------	
INSERT INTO Audio_2DSounds 
			(ScriptID, 										SoundID, 									SoundType, 		MinVolume, 	MaxVolume,	IsMusic,	Looping)
VALUES		('AS2D_LEADER_MUSIC_TCM_CHARLES_III_PEACE', 	'SND_LEADER_MUSIC_TCM_CHARLES_III_PEACE', 	'GAME_MUSIC', 	90, 		90, 		1, 			0),
			('AS2D_LEADER_MUSIC_TCM_CHARLES_III_WAR', 		'SND_LEADER_MUSIC_TCM_CHARLES_III_WAR', 	'GAME_MUSIC', 	75, 		75, 		1,			0);
--==========================================================================================================================	
-- BuildingClasses
--==========================================================================================================================	
INSERT INTO BuildingClasses 	
			(Type, 						 				DefaultBuilding, 							Description)
VALUES		('BUILDINGCLASS_TCM_BOURBON_SPAIN_DUMMY', 	'BUILDING_TCM_BOURBON_SPAIN_GOLD_DUMMY', 	'TXT_KEY_TRAIT_TCM_CHARLES_III_BOURBON_SPAIN_SHORT');
--==========================================================================================================================	
-- Buildings
--==========================================================================================================================			
INSERT INTO Buildings 	
			(Type, 										BuildingClass, 								SpecialistType,					SpecialistCount,	GreatWorkCount, Cost,		 FaithCost,		  NukeImmune,	  ConquestProb,  PrereqTech,	Description, 											Help,													PortraitIndex, 	IconAtlas)
VALUES		('BUILDING_TCM_BOURBON_SPAIN_GOLD_DUMMY',	'BUILDINGCLASS_TCM_BOURBON_SPAIN_DUMMY', 	-1,								-1,					-1, 			-1,			 -1, 			  1,			  0,			NULL, 			'TXT_KEY_TRAIT_TCM_CHARLES_III_BOURBON_SPAIN_SHORT', 	'TXT_KEY_TRAIT_TCM_CHARLES_III_BOURBON_SPAIN_SHORT',	0, 				'TCM_BOURBON_SPAIN_ATLAS'),
			('BUILDING_TCM_BOURBON_SPAIN_ENGINEER',		'BUILDINGCLASS_TCM_BOURBON_SPAIN_DUMMY',	'SPECIALIST_ENGINEER',			1,					-1,				-1,			 -1, 			  1,			  0,			NULL, 			'TXT_KEY_CIV_TCM_BOURBON_SPAIN_ENGINEER', 				-1,														0, 				'TCM_BOURBON_SPAIN_ATLAS'),
			('BUILDING_TCM_BOURBON_SPAIN_SCIENTIST',	'BUILDINGCLASS_TCM_BOURBON_SPAIN_DUMMY',	'SPECIALIST_SCIENTIST',			1,					-1,				-1,			 -1, 			  1,			  0,			NULL, 			'TXT_KEY_CIV_TCM_BOURBON_SPAIN_SCIENTIST',				-1,														0, 				'TCM_BOURBON_SPAIN_ATLAS'),
			('BUILDING_TCM_BOURBON_SPAIN_MERCHANT',		'BUILDINGCLASS_TCM_BOURBON_SPAIN_DUMMY',	'SPECIALIST_MERCHANT',			1,					-1,				-1,			 -1, 			  1,			  0,			NULL, 			'TXT_KEY_CIV_TCM_BOURBON_SPAIN_MERCHANT', 				-1,														0, 				'TCM_BOURBON_SPAIN_ATLAS'),
			('BUILDING_TCM_BOURBON_SPAIN_WRITER',		'BUILDINGCLASS_TCM_BOURBON_SPAIN_DUMMY',	'SPECIALIST_WRITER',			1,			 		-1,				-1,			 -1, 			  1,			  0,			NULL, 			'TXT_KEY_CIV_TCM_BOURBON_SPAIN_WRITER', 				-1,														0, 				'TCM_BOURBON_SPAIN_ATLAS'),
			('BUILDING_TCM_BOURBON_SPAIN_ARTIST',		'BUILDINGCLASS_TCM_BOURBON_SPAIN_DUMMY',	'SPECIALIST_ARTIST',			1,				 	-1,				-1,			 -1, 			  1,			  0,			NULL, 			'TXT_KEY_CIV_TCM_BOURBON_SPAIN_ARTIST',					-1,														0, 				'TCM_BOURBON_SPAIN_ATLAS'),
			('BUILDING_TCM_BOURBON_SPAIN_MUSICIAN',		'BUILDINGCLASS_TCM_BOURBON_SPAIN_DUMMY',	'SPECIALIST_MUSICIAN',			1,					-1,				-1,			 -1, 			  1,			  0,			NULL, 			'TXT_KEY_CIV_TCM_BOURBON_SPAIN_MUSICIAN',				-1,														0, 				'TCM_BOURBON_SPAIN_ATLAS');
--==========================================================================================================================
-- Building_YieldChanges
--==========================================================================================================================
INSERT INTO Building_YieldChanges
			(BuildingType,								YieldType,		Yield)
VALUES		('BUILDING_TCM_BOURBON_SPAIN_GOLD_DUMMY',	'YIELD_GOLD',	1);
--==========================================================================================================================
--==========================================================================================================================	
-- UnitClasses 
--==========================================================================================================================		
INSERT INTO UnitClasses 
		(Type, 											 Description, 							DefaultUnit)
VALUES	('UNITCLASS_TCM_SANTISIMA_TRINIDAD_HUGE_COST_1', 'TXT_KEY_UNIT_TCM_SANTISIMA_TRINIDAD', 'UNIT_TCM_SANTISIMA_TRINIDAD_HUGE_COST_1');
--==========================================================================================================================	
-- Units 
--==========================================================================================================================		
INSERT INTO Units 	
			(Class, 	Type, 						PrereqTech, Combat, Cost, ObsoleteTech, FaithCost, RequiresFaithPurchaseEnabled, Moves, GoodyHutUpgradeUnitClass, CombatClass, Domain, DefaultUnitAI, Description, 						 Civilopedia, 										 	Strategy, 									Help, 									 MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, AdvancedStartCost, Mechanized, CombatLimit, MinAreaSize, Pillage, XPValueAttack, XPValueDefense, Conscription, UnitArtInfo, 						UnitFlagIconOffset,	UnitFlagAtlas,					  		PortraitIndex,  IconAtlas,					 MoveRate)
SELECT		 Class,		('UNIT_TCM_WALLOON_GUARD'), PrereqTech, Combat, Cost, ObsoleteTech, FaithCost, RequiresFaithPurchaseEnabled, Moves, GoodyHutUpgradeUnitClass, CombatClass, Domain, DefaultUnitAI, ('TXT_KEY_UNIT_TCM_WALLOON_GUARD'), ('TXT_KEY_CIVILOPEDIA_UNITS_TCM_WALLOON_GUARD_TEXT'), ('TXT_KEY_UNIT_TCM_WALLOON_GUARD_STRATEGY'), ('TXT_KEY_UNIT_HELP_TCM_WALLOON_GUARD'),  MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, AdvancedStartCost, Mechanized, CombatLimit, MinAreaSize, Pillage, XPValueAttack, XPValueDefense, Conscription, ('ART_DEF_UNIT_TCM_WALLOON_GUARD'),	0,					('TCM_UNIT_FLAG_WALLOON_GUARD_ATLAS'),  2, 			 	('TCM_BOURBON_SPAIN_ATLAS'), MoveRate
FROM Units WHERE (Type = 'UNIT_RIFLEMAN');

INSERT INTO Units 	
			(Class, 	Type, 							 ExtraMaintenanceCost,  PrereqTech, Range, Combat,   RangedCombat,    Cost,    ObsoleteTech, FaithCost, RequiresFaithPurchaseEnabled, Moves, 	CombatClass, Domain, DefaultUnitAI, Description, 						 	  Civilopedia, 										 		 Strategy, 										Help, 										    MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, AdvancedStartCost, Mechanized, CombatLimit, MinAreaSize, Pillage, XPValueAttack, XPValueDefense, Conscription, UnitArtInfo, 							UnitFlagIconOffset,	UnitFlagAtlas,					  			PortraitIndex,  IconAtlas,					 MoveRate)
SELECT		 Class,		('UNIT_TCM_SANTISIMA_TRINIDAD'), 1,						PrereqTech, Range, Combat+6, RangedCombat+11, Cost+35, ObsoleteTech, FaithCost, RequiresFaithPurchaseEnabled, Moves-1,  CombatClass, Domain, DefaultUnitAI, ('TXT_KEY_UNIT_TCM_SANTISIMA_TRINIDAD'), ('TXT_KEY_CIVILOPEDIA_UNITS_TCM_SANTISIMA_TRINIDAD_TEXT'), ('TXT_KEY_UNIT_TCM_SANTISIMA_TRINIDAD_STRATEGY'), ('TXT_KEY_UNIT_HELP_TCM_SANTISIMA_TRINIDAD'), MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, AdvancedStartCost, Mechanized, CombatLimit, MinAreaSize, Pillage, XPValueAttack, XPValueDefense, Conscription, ('ART_DEF_UNIT_TCM_SANTISIMA_TRINIDAD'),	0,					('TCM_UNIT_FLAG_SANTISIMA_TRINIDAD_ATLAS'),  3, 			 ('TCM_BOURBON_SPAIN_ATLAS'), MoveRate
FROM Units WHERE (Type = 'UNIT_FRIGATE');
INSERT INTO Units 	
			(Class, 										Type, 									      FaithCost, ShowInPedia, ExtraMaintenanceCost,	Range, Combat,   RangedCombat,   Cost, ObsoleteTech, Moves,   CombatClass, Domain, DefaultUnitAI, Description, 						 	  Civilopedia, 										 		 Strategy, 										Help, 										    MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, AdvancedStartCost, Mechanized, CombatLimit, MinAreaSize, Pillage, XPValueAttack, XPValueDefense, Conscription, UnitArtInfo,								UnitFlagIconOffset,	UnitFlagAtlas,					  			PortraitIndex,  IconAtlas,					 MoveRate)
SELECT		('UNITCLASS_TCM_SANTISIMA_TRINIDAD_HUGE_COST_1'),('UNIT_TCM_SANTISIMA_TRINIDAD_HUGE_COST_1'), -1,		 0,			1,						Range, Combat+8, RangedCombat+7, 400,  ObsoleteTech, Moves-1, CombatClass, Domain, DefaultUnitAI, ('TXT_KEY_UNIT_TCM_SANTISIMA_TRINIDAD'), ('TXT_KEY_CIVILOPEDIA_UNITS_TCM_SANTISIMA_TRINIDAD_TEXT'), ('TXT_KEY_UNIT_TCM_SANTISIMA_TRINIDAD_STRATEGY'), ('TXT_KEY_UNIT_HELP_TCM_SANTISIMA_TRINIDAD'), MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, AdvancedStartCost, Mechanized, CombatLimit, MinAreaSize, Pillage, XPValueAttack, XPValueDefense, Conscription, ('ART_DEF_UNIT_TCM_SANTISIMA_TRINIDAD'),	0,					('TCM_UNIT_FLAG_SANTISIMA_TRINIDAD_ATLAS'),  3, 			 ('TCM_BOURBON_SPAIN_ATLAS'), MoveRate
FROM Units WHERE (Type = 'UNIT_FRIGATE');
INSERT INTO Units 
			(Class, 	Type, 										 ExtraMaintenanceCost,  FaithCost,  ShowInPedia,  PrereqTech, Range, Combat,   RangedCombat,   Cost, ObsoleteTech, Moves, 	 CombatClass, Domain, DefaultUnitAI, Description, 						 	  Civilopedia, 										 		 Strategy, 										Help, 										      MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, AdvancedStartCost, Mechanized, CombatLimit, MinAreaSize, Pillage, XPValueAttack, XPValueDefense, Conscription, UnitArtInfo, 								UnitFlagIconOffset,	UnitFlagAtlas,					  			PortraitIndex,  IconAtlas,					 MoveRate)
SELECT		 Class,		('UNIT_TCM_SANTISIMA_TRINIDAD_UPGRADEABLE'), 1,						-1,			0,			  PrereqTech, Range, Combat+8, RangedCombat+12, -1,	 ObsoleteTech, Moves-1,  CombatClass, Domain, DefaultUnitAI, ('TXT_KEY_UNIT_TCM_SANTISIMA_TRINIDAD'), ('TXT_KEY_CIVILOPEDIA_UNITS_TCM_SANTISIMA_TRINIDAD_TEXT'), ('TXT_KEY_UNIT_TCM_SANTISIMA_TRINIDAD_STRATEGY'), ('TXT_KEY_UNIT_HELP_TCM_SANTISIMA_TRINIDAD'), MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, AdvancedStartCost, Mechanized, CombatLimit, MinAreaSize, Pillage, XPValueAttack, XPValueDefense, Conscription, ('ART_DEF_UNIT_TCM_SANTISIMA_TRINIDAD'),	0,					('TCM_UNIT_FLAG_SANTISIMA_TRINIDAD_ATLAS'),  3, 			 ('TCM_BOURBON_SPAIN_ATLAS'), MoveRate
FROM Units WHERE (Type = 'UNIT_FRIGATE');
--==========================================================================================================================	
-- UnitGameplay2DScripts
--==========================================================================================================================		
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT		('UNIT_TCM_WALLOON_GUARD'), SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_RIFLEMAN');		

INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 						 SelectionSound, FirstSelectionSound)
SELECT		('UNIT_TCM_SANTISIMA_TRINIDAD'), SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_FRIGATE');
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 						 SelectionSound, FirstSelectionSound)
SELECT		('UNIT_TCM_SANTISIMA_TRINIDAD_HUGE_COST_1'), SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_FRIGATE');	
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 						 SelectionSound, FirstSelectionSound)
SELECT		('UNIT_TCM_SANTISIMA_TRINIDAD_UPGRADEABLE'), SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_FRIGATE');		
--==========================================================================================================================	
-- Unit_AITypes
--==========================================================================================================================		
INSERT INTO Unit_AITypes 	
			(UnitType, 					UnitAIType)
SELECT		('UNIT_TCM_WALLOON_GUARD'), UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_RIFLEMAN');	

INSERT INTO Unit_AITypes 	
			(UnitType, 						 UnitAIType)
SELECT		('UNIT_TCM_SANTISIMA_TRINIDAD'), UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_FRIGATE');	
INSERT INTO Unit_AITypes 	
			(UnitType, 						 			UnitAIType)
SELECT		('UNIT_TCM_SANTISIMA_TRINIDAD_HUGE_COST_1'),  UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_FRIGATE');
INSERT INTO Unit_AITypes 	
			(UnitType, 									 UnitAIType)
SELECT		('UNIT_TCM_SANTISIMA_TRINIDAD_UPGRADEABLE'), UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_FRIGATE');	
--==========================================================================================================================	
-- Unit_ClassUpgrades
--==========================================================================================================================		
INSERT INTO Unit_ClassUpgrades 	
			(UnitType, 									UnitClassType)
VALUES		('UNIT_TCM_SANTISIMA_TRINIDAD', 		 	'UNITCLASS_TCM_SANTISIMA_TRINIDAD_HUGE_COST_1'),
			('UNIT_TCM_SANTISIMA_TRINIDAD_UPGRADEABLE', 'UNITCLASS_BATTLESHIP'),
			('UNIT_TCM_WALLOON_GUARD', 					'UNITCLASS_GREAT_WAR_INFANTRY');
--==========================================================================================================================	
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================		
INSERT INTO Unit_ResourceQuantityRequirements 	
			(UnitType, 									ResourceType)
VALUES		('UNIT_TCM_SANTISIMA_TRINIDAD', 		 	'RESOURCE_IRON');
--==========================================================================================================================	
-- Unit_Flavors
--==========================================================================================================================		
INSERT INTO Unit_Flavors 	
			(UnitType, 							FlavorType,			Flavor)
VALUES		('UNIT_TCM_SANTISIMA_TRINIDAD', 	'FLAVOR_NAVAL',		17),
			('UNIT_TCM_WALLOON_GUARD', 			'FLAVOR_OFFENSE',	15),
			('UNIT_TCM_WALLOON_GUARD', 			'FLAVOR_DEFENSE',	15);
--==========================================================================================================================	
-- Unit_FreePromotions
--==========================================================================================================================		
INSERT INTO Unit_FreePromotions 	
			(UnitType, 										PromotionType)
VALUES		('UNIT_TCM_SANTISIMA_TRINIDAD', 				'PROMOTION_ONLY_DEFENSIVE'),
			('UNIT_TCM_SANTISIMA_TRINIDAD_HUGE_COST_1', 	'PROMOTION_ONLY_DEFENSIVE'),
			('UNIT_TCM_SANTISIMA_TRINIDAD_UPGRADEABLE', 	'PROMOTION_ONLY_DEFENSIVE'),
			('UNIT_TCM_WALLOON_GUARD', 						'PROMOTION_TCM_SPANISH_WALLOON_GUARD');
--==========================================================================================================================	
-- UnitPromotions
--==========================================================================================================================
INSERT INTO UnitPromotions 
			(Type, 									Description, 									Help, 												 Sound, 			FriendlyLandsModifier,  AttackMod, DefenseMod,  RangedAttackModifier, CannotBeChosen,	PortraitIndex, 	IconAtlas, 			PediaType, 			PediaEntry)
VALUES		('PROMOTION_TCM_SPANISH_SHIP_1',		'TXT_KEY_PROMOTION_TCM_SPANISH_SHIP_1',			'TXT_KEY_PROMOTION_TCM_SPANISH_SHIP_1_HELP',		 'AS2D_IF_LEVELUP',	0,						15,		   15,		    15,					  1,				59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_TCM_SPANISH_SHIP_1'),
			('PROMOTION_TCM_SPANISH_SHIP_2',		'TXT_KEY_PROMOTION_TCM_SPANISH_SHIP_2',			'TXT_KEY_PROMOTION_TCM_SPANISH_SHIP_2_HELP',		 'AS2D_IF_LEVELUP', 0,						25,		   25,			25,					  1,				59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_TCM_SPANISH_SHIP_2'),
			('PROMOTION_TCM_SPANISH_SHIP_3',		'TXT_KEY_PROMOTION_TCM_SPANISH_SHIP_3',			'TXT_KEY_PROMOTION_TCM_SPANISH_SHIP_3_HELP',		 'AS2D_IF_LEVELUP', 0,						35,		   35,			35,					  1,				59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_TCM_SPANISH_SHIP_3'),
			('PROMOTION_TCM_SPANISH_WALLOON_GUARD',	'TXT_KEY_PROMOTION_TCM_SPANISH_WALLOON_GUARD',	'TXT_KEY_PROMOTION_TCM_SPANISH_WALLOON_GUARD_HELP',  'AS2D_IF_LEVELUP', 15,						0,		   0,			0,					  1,				59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_TCM_SPANISH_WALLOON_GUARD'),
			('PROMOTION_TCM_BOURBON_PACT',			'TXT_KEY_PROMOTION_TCM_SPANISH_PACTE',			'TXT_KEY_PROMOTION_TCM_SPANISH_PACTE_HELP',			 'AS2D_IF_LEVELUP', 20,						0,		   0,			0,					  1,				59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_TCM_SPANISH_PACTE');
--==========================================================================================================================	
-- Diplomacy_Responses
--==========================================================================================================================	
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_TCM_CHARLES_III','RESPONSE_FIRST_GREETING','TXT_KEY_LEADER_TCM_CHARLES_III_FIRSTGREETING%','1');
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_TCM_CHARLES_III','RESPONSE_DEFEATED',	  'TXT_KEY_LEADER_TCM_CHARLES_III_DEFEATED%','1');
--==========================================================================================================================	
--==========================================================================================================================	