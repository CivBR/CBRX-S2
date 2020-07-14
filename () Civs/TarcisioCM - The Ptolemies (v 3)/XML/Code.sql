--==========================================================================================================================
-- Civilizations
--==========================================================================================================================
INSERT INTO Civilizations 	
			(Type, 								Description, 							ShortDescription, 					 		Adjective, 								Civilopedia, 							CivilopediaTag, 					DefaultPlayerColor,		  		ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas,					AlphaIconAtlas, 				PortraitIndex,	SoundtrackTag, 	MapImage, 						DawnOfManQuote, 					 	DawnOfManImage)
SELECT		('CIVILIZATION_TCM_PTOLEMIES'), 	('TXT_KEY_CIV_TCM_PTOLEMIES_DESC'), 	('TXT_KEY_CIV_TCM_PTOLEMIES_SHORT_DESC'), ('TXT_KEY_CIV_TCM_PTOLEMIES_ADJECTIVE'), 	('TXT_KEY_CIV5_TCM_PTOLEMIES_TEXT_1'),	('TXT_KEY_CIV5_TCM_PTOLEMIES'), 	('PLAYERCOLOR_TCM_PTOLEMIES'), 	ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('TCM_PTOLEMIES_ATLAS'), 	('TCM_PTOLEMIES_ALPHA_ATLAS'), 	0, 				('GREECE'),	 	('TCM_Ptolemy_Map.dds'), 	('TXT_KEY_CIV5_DOM_TCM_PTOLEMIES_TEXT'), ('TCM_Ptolemy_DOM.dds')
FROM Civilizations WHERE Type = 'CIVILIZATION_GREECE';
--==========================================================================================================================
-- Civilization_CityNames
--==========================================================================================================================		
INSERT INTO Civilization_CityNames 
			(CivilizationType, 					CityName)
VALUES		('CIVILIZATION_TCM_PTOLEMIES', 		'TXT_KEY_CITY_NAME_TCM_PTOLEMIES_01'),
			('CIVILIZATION_TCM_PTOLEMIES', 		'TXT_KEY_CITY_NAME_TCM_PTOLEMIES_02'),
			('CIVILIZATION_TCM_PTOLEMIES', 		'TXT_KEY_CITY_NAME_TCM_PTOLEMIES_03'),
			('CIVILIZATION_TCM_PTOLEMIES', 		'TXT_KEY_CITY_NAME_TCM_PTOLEMIES_04'),
			('CIVILIZATION_TCM_PTOLEMIES', 		'TXT_KEY_CITY_NAME_TCM_PTOLEMIES_05'),
			('CIVILIZATION_TCM_PTOLEMIES', 		'TXT_KEY_CITY_NAME_TCM_PTOLEMIES_06'),
			('CIVILIZATION_TCM_PTOLEMIES', 		'TXT_KEY_CITY_NAME_TCM_PTOLEMIES_07'),
			('CIVILIZATION_TCM_PTOLEMIES', 		'TXT_KEY_CITY_NAME_TCM_PTOLEMIES_08'),
			('CIVILIZATION_TCM_PTOLEMIES', 		'TXT_KEY_CITY_NAME_TCM_PTOLEMIES_09'),
			('CIVILIZATION_TCM_PTOLEMIES', 		'TXT_KEY_CITY_NAME_TCM_PTOLEMIES_10'),
			('CIVILIZATION_TCM_PTOLEMIES', 		'TXT_KEY_CITY_NAME_TCM_PTOLEMIES_11'),
			('CIVILIZATION_TCM_PTOLEMIES', 		'TXT_KEY_CITY_NAME_TCM_PTOLEMIES_12'),
			('CIVILIZATION_TCM_PTOLEMIES', 		'TXT_KEY_CITY_NAME_TCM_PTOLEMIES_13'),
			('CIVILIZATION_TCM_PTOLEMIES', 		'TXT_KEY_CITY_NAME_TCM_PTOLEMIES_14'),
			('CIVILIZATION_TCM_PTOLEMIES', 		'TXT_KEY_CITY_NAME_TCM_PTOLEMIES_15'),
			('CIVILIZATION_TCM_PTOLEMIES', 		'TXT_KEY_CITY_NAME_TCM_PTOLEMIES_16'),
			('CIVILIZATION_TCM_PTOLEMIES', 		'TXT_KEY_CITY_NAME_TCM_PTOLEMIES_17'),
			('CIVILIZATION_TCM_PTOLEMIES', 		'TXT_KEY_CITY_NAME_TCM_PTOLEMIES_18'),
			('CIVILIZATION_TCM_PTOLEMIES', 		'TXT_KEY_CITY_NAME_TCM_PTOLEMIES_19'),
			('CIVILIZATION_TCM_PTOLEMIES', 		'TXT_KEY_CITY_NAME_TCM_PTOLEMIES_20'),
			('CIVILIZATION_TCM_PTOLEMIES', 		'TXT_KEY_CITY_NAME_TCM_PTOLEMIES_21'),
			('CIVILIZATION_TCM_PTOLEMIES', 		'TXT_KEY_CITY_NAME_TCM_PTOLEMIES_22'),
			('CIVILIZATION_TCM_PTOLEMIES', 		'TXT_KEY_CITY_NAME_TCM_PTOLEMIES_23'),
			('CIVILIZATION_TCM_PTOLEMIES', 		'TXT_KEY_CITY_NAME_TCM_PTOLEMIES_24'),
			('CIVILIZATION_TCM_PTOLEMIES', 		'TXT_KEY_CITY_NAME_TCM_PTOLEMIES_25'),
			('CIVILIZATION_TCM_PTOLEMIES', 		'TXT_KEY_CITY_NAME_TCM_PTOLEMIES_26'),
			('CIVILIZATION_TCM_PTOLEMIES', 		'TXT_KEY_CITY_NAME_TCM_PTOLEMIES_27'),
			('CIVILIZATION_TCM_PTOLEMIES', 		'TXT_KEY_CITY_NAME_TCM_PTOLEMIES_28'),
			('CIVILIZATION_TCM_PTOLEMIES', 		'TXT_KEY_CITY_NAME_TCM_PTOLEMIES_29'),
			('CIVILIZATION_TCM_PTOLEMIES', 		'TXT_KEY_CITY_NAME_TCM_PTOLEMIES_30');
--==========================================================================================================================
-- Civilization_FreeBuildingClasses
--==========================================================================================================================		
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 				BuildingClassType)
VALUES		('CIVILIZATION_TCM_PTOLEMIES', 	'BUILDINGCLASS_PALACE'),
			('CIVILIZATION_TCM_PTOLEMIES', 	'BUILDINGCLASS_TCM_PTOLEMIES_DUMMY_1');
--==========================================================================================================================
-- Civilization_FreeTechs
--==========================================================================================================================	
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 				TechType)
SELECT		('CIVILIZATION_TCM_PTOLEMIES'), 	TechType
FROM Civilization_FreeTechs WHERE CivilizationType = 'CIVILIZATION_GREECE';
--==========================================================================================================================
-- Civilization_FreeUnits
--==========================================================================================================================	
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 				UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_TCM_PTOLEMIES'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE CivilizationType = 'CIVILIZATION_GREECE';
--==========================================================================================================================
-- Civilization_Leaders
--==========================================================================================================================		
INSERT INTO Civilization_Leaders 
			(CivilizationType, 				LeaderheadType)
VALUES		('CIVILIZATION_TCM_PTOLEMIES', 	'LEADER_TCM_PTOLEMY');
--==========================================================================================================================
-- Civilization_UnitClassOverrides
--==========================================================================================================================	
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 				UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_TCM_PTOLEMIES', 	'UNITCLASS_GREAT_ADMIRAL', 	'UNIT_TCM_POLYREME');
--==========================================================================================================================
-- Civilization_BuildingClassOverrides
--==========================================================================================================================	
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 				BuildingClassType, 			BuildingType)
VALUES		('CIVILIZATION_TCM_PTOLEMIES', 	'BUILDINGCLASS_TEMPLE', 	'BUILDING_TCM_SERAPEUM');
--==========================================================================================================================

--==========================================================================================================================
-- Civilization_SpyNames
--==========================================================================================================================	
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 			SpyName)
VALUES		('CIVILIZATION_TCM_PTOLEMIES', 	'TXT_KEY_SPY_NAME_TCM_PTOLEMIES_0'),	
			('CIVILIZATION_TCM_PTOLEMIES', 	'TXT_KEY_SPY_NAME_TCM_PTOLEMIES_1'),
			('CIVILIZATION_TCM_PTOLEMIES', 	'TXT_KEY_SPY_NAME_TCM_PTOLEMIES_2'),
			('CIVILIZATION_TCM_PTOLEMIES', 	'TXT_KEY_SPY_NAME_TCM_PTOLEMIES_3'),
			('CIVILIZATION_TCM_PTOLEMIES', 	'TXT_KEY_SPY_NAME_TCM_PTOLEMIES_4'),
			('CIVILIZATION_TCM_PTOLEMIES', 	'TXT_KEY_SPY_NAME_TCM_PTOLEMIES_5'),
			('CIVILIZATION_TCM_PTOLEMIES', 	'TXT_KEY_SPY_NAME_TCM_PTOLEMIES_6'),
			('CIVILIZATION_TCM_PTOLEMIES', 	'TXT_KEY_SPY_NAME_TCM_PTOLEMIES_7'),
			('CIVILIZATION_TCM_PTOLEMIES', 	'TXT_KEY_SPY_NAME_TCM_PTOLEMIES_8'),
			('CIVILIZATION_TCM_PTOLEMIES', 	'TXT_KEY_SPY_NAME_TCM_PTOLEMIES_9');
--==========================================================================================================================	
-- Civilization_Start_Along_Ocean
--==========================================================================================================================			
INSERT INTO Civilization_Start_Along_Ocean 
			(CivilizationType, 				StartAlongOcean)
VALUES		('CIVILIZATION_TCM_PTOLEMIES',	1); 
--==========================================================================================================================	
-- Colors
--==========================================================================================================================			
INSERT INTO Colors 
			(Type, 										Red, 	Green, 	Blue, 	Alpha)
VALUES		('COLOR_PLAYER_TCM_PTOLEMIES_ICON',			0.882,	0.761,	0.247,	1),
			('COLOR_PLAYER_TCM_PTOLEMIES_BACKGROUND',	0.294,	0.29,	0.514,	1); 
--==========================================================================================================================	
-- PlayerColors
--==========================================================================================================================				
INSERT INTO PlayerColors 
			(Type, 								PrimaryColor, 							SecondaryColor, 								TextColor)
VALUES		('PLAYERCOLOR_TCM_PTOLEMIES',		'COLOR_PLAYER_TCM_PTOLEMIES_ICON', 		'COLOR_PLAYER_TCM_PTOLEMIES_BACKGROUND', 			'COLOR_PLAYER_WHITE_TEXT');
--==========================================================================================================================	
--==========================================================================================================================	
--==========================================================================================================================	
-- Leaders
--==========================================================================================================================			
INSERT INTO Leaders 
			(Type, 					Description, 					Civilopedia, 								CivilopediaTag, 						ArtDefineTag, 			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, Chattiness, Meanness, 	IconAtlas, 			PortraitIndex)
VALUES		('LEADER_TCM_PTOLEMY', 	'TXT_KEY_LEADER_TCM_PTOLEMY', 	'TXT_KEY_LEADER_TCM_PTOLEMY_PEDIA_TEXT', 	'TXT_KEY_LEADER_TCM_PTOLEMY_PEDIA', 	'Ptolemy_Scene.xml',	6, 						9, 						8, 							6, 			5, 				7, 				5, 					 4, 			 2, 		6, 			4, 			 4, 		 6, 		'TCM_PTOLEMIES_ATLAS', 	1);
--==========================================================================================================================	
-- Leader_MajorCivApproachBiases
--==========================================================================================================================						
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 			MajorCivApproachType, 				Bias)
VALUES		('LEADER_TCM_PTOLEMY', 	'MAJOR_CIV_APPROACH_WAR', 			4),
			('LEADER_TCM_PTOLEMY', 	'MAJOR_CIV_APPROACH_HOSTILE', 		3),
			('LEADER_TCM_PTOLEMY', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	8),
			('LEADER_TCM_PTOLEMY', 	'MAJOR_CIV_APPROACH_GUARDED', 		7),
			('LEADER_TCM_PTOLEMY', 	'MAJOR_CIV_APPROACH_AFRAID', 		5),
			('LEADER_TCM_PTOLEMY', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		3),
			('LEADER_TCM_PTOLEMY', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		4);
--==========================================================================================================================	
-- Leader_MajorCivApproachBiases
--==========================================================================================================================						
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 			MinorCivApproachType, 				Bias)
VALUES		('LEADER_TCM_PTOLEMY', 	'MINOR_CIV_APPROACH_IGNORE', 		2),
			('LEADER_TCM_PTOLEMY', 	'MINOR_CIV_APPROACH_FRIENDLY', 		4),
			('LEADER_TCM_PTOLEMY', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	7),
			('LEADER_TCM_PTOLEMY', 	'MINOR_CIV_APPROACH_CONQUEST', 		7),
			('LEADER_TCM_PTOLEMY', 	'MINOR_CIV_APPROACH_BULLY', 		3);
--==========================================================================================================================	
-- Leader_Flavors
--==========================================================================================================================						
INSERT INTO Leader_Flavors 
			(LeaderType, 			FlavorType, 						Flavor)
VALUES		('LEADER_TCM_PTOLEMY', 	'FLAVOR_OFFENSE', 					6),
			('LEADER_TCM_PTOLEMY', 	'FLAVOR_DEFENSE', 					8),
			('LEADER_TCM_PTOLEMY', 	'FLAVOR_CITY_DEFENSE', 				6),
			('LEADER_TCM_PTOLEMY', 	'FLAVOR_MILITARY_TRAINING', 		5),
			('LEADER_TCM_PTOLEMY', 	'FLAVOR_RECON', 					5),
			('LEADER_TCM_PTOLEMY', 	'FLAVOR_RANGED', 					6),
			('LEADER_TCM_PTOLEMY', 	'FLAVOR_MOBILE', 					4),
			('LEADER_TCM_PTOLEMY', 	'FLAVOR_NAVAL', 					10),
			('LEADER_TCM_PTOLEMY', 	'FLAVOR_NAVAL_RECON', 				5),
			('LEADER_TCM_PTOLEMY', 	'FLAVOR_NAVAL_GROWTH', 				5),
			('LEADER_TCM_PTOLEMY', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
			('LEADER_TCM_PTOLEMY', 	'FLAVOR_AIR', 						5),
			('LEADER_TCM_PTOLEMY', 	'FLAVOR_EXPANSION', 				6),
			('LEADER_TCM_PTOLEMY', 	'FLAVOR_GROWTH', 					10),
			('LEADER_TCM_PTOLEMY', 	'FLAVOR_TILE_IMPROVEMENT', 			8),
			('LEADER_TCM_PTOLEMY', 	'FLAVOR_INFRASTRUCTURE', 			6),
			('LEADER_TCM_PTOLEMY', 	'FLAVOR_PRODUCTION', 				5),
			('LEADER_TCM_PTOLEMY', 	'FLAVOR_GOLD', 						8),
			('LEADER_TCM_PTOLEMY', 	'FLAVOR_SCIENCE', 					7),
			('LEADER_TCM_PTOLEMY', 	'FLAVOR_CULTURE', 					6),
			('LEADER_TCM_PTOLEMY', 	'FLAVOR_HAPPINESS', 				9),
			('LEADER_TCM_PTOLEMY', 	'FLAVOR_GREAT_PEOPLE', 				9),
			('LEADER_TCM_PTOLEMY', 	'FLAVOR_WONDER', 					9),
			('LEADER_TCM_PTOLEMY', 	'FLAVOR_RELIGION', 					9),
			('LEADER_TCM_PTOLEMY', 	'FLAVOR_DIPLOMACY', 				8),
			('LEADER_TCM_PTOLEMY', 	'FLAVOR_SPACESHIP', 				8),
			('LEADER_TCM_PTOLEMY', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_TCM_PTOLEMY', 	'FLAVOR_NUKE', 						5),
			('LEADER_TCM_PTOLEMY', 	'FLAVOR_USE_NUKE', 					1),
			('LEADER_TCM_PTOLEMY', 	'FLAVOR_ESPIONAGE', 				6),
			('LEADER_TCM_PTOLEMY', 	'FLAVOR_AIRLIFT', 					5),
			('LEADER_TCM_PTOLEMY', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_TCM_PTOLEMY', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_TCM_PTOLEMY', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_TCM_PTOLEMY', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_TCM_PTOLEMY', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_TCM_PTOLEMY', 	'FLAVOR_AIR_CARRIER', 				5);
--==========================================================================================================================	
-- Leader_Traits
--==========================================================================================================================	
INSERT INTO Leader_Traits 
			(LeaderType, 			TraitType)
VALUES		('LEADER_TCM_PTOLEMY', 	'TRAIT_TCM_PTOLEMY_PTOLEMIES');
--==========================================================================================================================	
-- Traits
--==========================================================================================================================	
INSERT INTO Traits 
			(Type, 								Description, 							ShortDescription)
VALUES		('TRAIT_TCM_PTOLEMY_PTOLEMIES', 	'TXT_KEY_TRAIT_TCM_PTOLEMY_PTOLEMIES', 	'TXT_KEY_TRAIT_TCM_PTOLEMY_PTOLEMIES_SHORT');
--==========================================================================================================================
-- AUDIO
--==========================================================================================================================	
-- Audio_Sounds
------------------------------	
INSERT INTO Audio_Sounds 
			(SoundID, 								Filename, 				LoadType)
VALUES		('SND_LEADER_MUSIC_TCM_PTOLEMY_PEACE', 	'ptolemypeace', 	'DynamicResident'),
			('SND_LEADER_MUSIC_TCM_PTOLEMY_WAR',	'ptolemywar', 	'DynamicResident');		
------------------------------
-- Audio_2DSounds
------------------------------	
INSERT INTO Audio_2DSounds 
			(ScriptID, 									SoundID, 								SoundType, 		MinVolume, 	MaxVolume,	IsMusic,	Looping)
VALUES		('AS2D_LEADER_MUSIC_TCM_PTOLEMY_PEACE', 	'SND_LEADER_MUSIC_TCM_PTOLEMY_PEACE', 	'GAME_MUSIC', 	80, 		80, 		1, 			0),
			('AS2D_LEADER_MUSIC_TCM_PTOLEMY_WAR', 		'SND_LEADER_MUSIC_TCM_PTOLEMY_WAR', 	'GAME_MUSIC', 	80, 		80, 		1,			0);
--==========================================================================================================================	
-- BuildingClasses
--==========================================================================================================================	
INSERT INTO BuildingClasses 	
			(Type, 						 				DefaultBuilding, 					Description									)
VALUES		('BUILDINGCLASS_TCM_PTOLEMIES_DUMMY', 		'BUILDING_TCM_DUMMY_PTOLEMIES', 	'TXT_KEY_TRAIT_TCM_PTOLEMY_PTOLEMIES_SHORT'),
			('BUILDINGCLASS_TCM_PTOLEMIES_DUMMY_1', 	'BUILDING_TCM_DUMMY_PTOLEMIES_B1',	'TXT_KEY_TRAIT_TCM_PTOLEMY_PTOLEMIES_SHORT'),
			('BUILDINGCLASS_TCM_PTOLEMIES_DUMMY_2', 	'BUILDING_TCM_DUMMY_PTOLEMIES_B2',	'TXT_KEY_TRAIT_TCM_PTOLEMY_PTOLEMIES_SHORT'),
			('BUILDINGCLASS_TCM_PTOLEMIES_DUMMY_3', 	'BUILDING_TCM_DUMMY_PTOLEMIES_B3',	'TXT_KEY_TRAIT_TCM_PTOLEMY_PTOLEMIES_SHORT'),
			('BUILDINGCLASS_TCM_PTOLEMIES_DUMMY_4', 	'BUILDING_TCM_DUMMY_PTOLEMIES_B4',	'TXT_KEY_TRAIT_TCM_PTOLEMY_PTOLEMIES_SHORT'),
			('BUILDINGCLASS_TCM_POLYREME_1', 			'BUILDING_TCM_DUMMY_POLYREME_1', 	'TXT_KEY_TRAIT_TCM_PTOLEMY_PTOLEMIES_SHORT'),
			('BUILDINGCLASS_TCM_POLYREME_2', 			'BUILDING_TCM_DUMMY_POLYREME_2', 	'TXT_KEY_TRAIT_TCM_PTOLEMY_PTOLEMIES_SHORT'),
			('BUILDINGCLASS_TCM_POLYREME_3', 			'BUILDING_TCM_DUMMY_POLYREME_3', 	'TXT_KEY_TRAIT_TCM_PTOLEMY_PTOLEMIES_SHORT'),
			('BUILDINGCLASS_TCM_POLYREME_4', 			'BUILDING_TCM_DUMMY_POLYREME_4', 	'TXT_KEY_TRAIT_TCM_PTOLEMY_PTOLEMIES_SHORT');
--==========================================================================================================================	
-- Buildings
--==========================================================================================================================			
INSERT INTO Buildings
			(Type, 						BuildingClass, Cost, GoldMaintenance, PrereqTech, NeverCapture,	ConquestProb, Description,							Help,									Civilopedia,						Strategy,									ArtDefineTag, MinAreaSize, 	HurryCostModifier, IconAtlas,					PortraitIndex)
SELECT		('BUILDING_TCM_SERAPEUM'),	BuildingClass, Cost, GoldMaintenance, PrereqTech, NeverCapture,	ConquestProb, ('TXT_KEY_BUILDING_TCM_SERAPEUM'),	('TXT_KEY_BUILDING_TCM_SERAPEUM_HELP'),	('TXT_KEY_CIV5_TCM_SERAPEUM_TEXT'),	('TXT_KEY_BUILDING_TCM_SERAPEUM_STRATEGY'),	ArtDefineTag, MinAreaSize, 	HurryCostModifier, ('TCM_PTOLEMIES_ATLAS'), 	3
FROM Buildings WHERE Type = 'BUILDING_TEMPLE';

INSERT INTO Buildings 	
			(Type, 								BuildingClass, 							Happiness,	GreatWorkCount, Cost, FaithCost, NukeImmune, ConquestProb,  PrereqTech,	Description, 									Help,											PortraitIndex, 	IconAtlas)
VALUES		('BUILDING_TCM_DUMMY_PTOLEMIES_1',	'BUILDINGCLASS_TCM_PTOLEMIES_DUMMY', 	1,			-1, 			-1,   -1, 		 1,		 	 0,				NULL, 		'TXT_KEY_TRAIT_TCM_PTOLEMY_PTOLEMIES_SHORT', 	'TXT_KEY_TRAIT_TCM_PTOLEMY_PTOLEMIES_SHORT',	0, 				'TCM_PTOLEMIES_ATLAS'),
			('BUILDING_TCM_DUMMY_PTOLEMIES_2',	'BUILDINGCLASS_TCM_PTOLEMIES_DUMMY', 	0,			-1, 			-1,   -1, 		 1,		 	 0,				NULL, 		'TXT_KEY_TRAIT_TCM_PTOLEMY_PTOLEMIES_SHORT', 	'TXT_KEY_TRAIT_TCM_PTOLEMY_PTOLEMIES_SHORT',	0, 				'TCM_PTOLEMIES_ATLAS'),
			('BUILDING_TCM_DUMMY_PTOLEMIES_3',	'BUILDINGCLASS_TCM_PTOLEMIES_DUMMY', 	0,			-1, 			-1,   -1, 		 1,		 	 0,				NULL, 		'TXT_KEY_TRAIT_TCM_PTOLEMY_PTOLEMIES_SHORT', 	'TXT_KEY_TRAIT_TCM_PTOLEMY_PTOLEMIES_SHORT',	0, 				'TCM_PTOLEMIES_ATLAS'),
			('BUILDING_TCM_DUMMY_PTOLEMIES_B1',	'BUILDINGCLASS_TCM_PTOLEMIES_DUMMY_1', 	0,			-1, 			-1,   -1, 		 1,		 	 0,				NULL, 		'TXT_KEY_TRAIT_TCM_PTOLEMY_PTOLEMIES_SHORT', 	'TXT_KEY_TRAIT_TCM_PTOLEMY_PTOLEMIES_SHORT',	0, 				'TCM_PTOLEMIES_ATLAS'),
			('BUILDING_TCM_DUMMY_PTOLEMIES_B2',	'BUILDINGCLASS_TCM_PTOLEMIES_DUMMY_2', 	0,			-1, 			-1,   -1, 		 1,		 	 0,				NULL, 		'TXT_KEY_TRAIT_TCM_PTOLEMY_PTOLEMIES_SHORT', 	'TXT_KEY_TRAIT_TCM_PTOLEMY_PTOLEMIES_SHORT',	0, 				'TCM_PTOLEMIES_ATLAS'),
			('BUILDING_TCM_DUMMY_PTOLEMIES_B3',	'BUILDINGCLASS_TCM_PTOLEMIES_DUMMY_3', 	0,			-1, 			-1,   -1, 		 1,		 	 0,				NULL, 		'TXT_KEY_TRAIT_TCM_PTOLEMY_PTOLEMIES_SHORT', 	'TXT_KEY_TRAIT_TCM_PTOLEMY_PTOLEMIES_SHORT',	0, 				'TCM_PTOLEMIES_ATLAS'),
			('BUILDING_TCM_DUMMY_PTOLEMIES_B4',	'BUILDINGCLASS_TCM_PTOLEMIES_DUMMY_4', 	0,			-1, 			-1,   -1, 		 1,		 	 0,				NULL, 		'TXT_KEY_TRAIT_TCM_PTOLEMY_PTOLEMIES_SHORT', 	'TXT_KEY_TRAIT_TCM_PTOLEMY_PTOLEMIES_SHORT',	0, 				'TCM_PTOLEMIES_ATLAS');

INSERT INTO Building_YieldChanges 	
			(BuildingType, 						YieldType, 		Yield)
VALUES		('BUILDING_TCM_DUMMY_PTOLEMIES_2',	'YIELD_FAITH', 	2),
			('BUILDING_TCM_SERAPEUM',			'YIELD_FAITH', 	2);

INSERT INTO Building_ClassesNeededInCity 	
			(BuildingType, 				BuildingClassType)
VALUES		('BUILDING_TCM_SERAPEUM',	'BUILDINGCLASS_SHRINE');
--==========================================================================================================================	
-- Building_Flavors
--==========================================================================================================================					
INSERT INTO Building_Flavors 
			(BuildingType, 				FlavorType,				Flavor)
VALUES		('BUILDING_TCM_SERAPEUM', 	'FLAVOR_RELIGION',		50),
			('BUILDING_TCM_SERAPEUM', 	'FLAVOR_HAPPINESS',		10);
--==========================================================================================================================
--==========================================================================================================================	
-- Units
--==========================================================================================================================		
INSERT INTO Units 	
			(Class, Type, 			 		Cost, 	ObsoleteTech, FaithCost, Capture,	CivilianAttackPriority, Special, RequiresFaithPurchaseEnabled, Moves, Domain, DefaultUnitAI, Description, 				 	Civilopedia, 										Strategy, 							 	Help, 							  	AdvancedStartCost, WorkRate, Mechanized, CombatLimit, FoundReligion, SpreadReligion, ReligionSpreads, ReligiousStrength, MinAreaSize, UnitArtInfo, 									UnitFlagIconOffset,	UnitFlagAtlas,						PortraitIndex, 	IconAtlas,				 	MoveRate)
SELECT		Class,	('UNIT_TCM_POLYREME'),  -1,   	ObsoleteTech, FaithCost, Capture,	CivilianAttackPriority, Special, RequiresFaithPurchaseEnabled, Moves, Domain, DefaultUnitAI, ('TXT_KEY_UNIT_TCM_POLYREME'), ('TXT_KEY_CIVILOPEDIA_UNITS_TCM_POLYREME_TEXT'), 	('TXT_KEY_UNIT_TCM_POLYREME_STRATEGY'), ('TXT_KEY_UNIT_HELP_TCM_POLYREME'), AdvancedStartCost, WorkRate, Mechanized, CombatLimit, FoundReligion, SpreadReligion, ReligionSpreads, ReligiousStrength, MinAreaSize, ('ART_DEF_UNIT_U_TCM_PTOLEMAIC_POLYREME'),	0,					('TCM_UNIT_FLAG_POLYREME_ATLAS'),	2, 				('TCM_PTOLEMIES_ATLAS'),  	MoveRate
FROM Units WHERE (Type = 'UNIT_GREAT_ADMIRAL');

INSERT INTO Units 	
			(Class, Type, 			 				Cost, BaseHurry, HurryMultiplier, 	ObsoleteTech, FaithCost, Capture, CivilianAttackPriority, Special, RequiresFaithPurchaseEnabled, Moves, Domain, DefaultUnitAI, Description, Civilopedia, Strategy, Help, AdvancedStartCost, WorkRate, Mechanized, CombatLimit, FoundReligion, SpreadReligion, ReligionSpreads, ReligiousStrength, MinAreaSize, UnitArtInfo, UnitFlagIconOffset,	UnitFlagAtlas,	PortraitIndex, IconAtlas, MoveRate)
SELECT		Class,	('UNIT_TCM_PTOLEMAIC_GENERAL'), Cost, 300,		 30,				ObsoleteTech, FaithCost, Capture, CivilianAttackPriority, Special, RequiresFaithPurchaseEnabled, Moves, Domain, DefaultUnitAI, Description, Civilopedia, Strategy, Help, AdvancedStartCost, WorkRate, Mechanized, CombatLimit, FoundReligion, SpreadReligion, ReligionSpreads, ReligiousStrength, MinAreaSize, UnitArtInfo,	UnitFlagIconOffset,	UnitFlagAtlas,	PortraitIndex, IconAtlas, MoveRate
FROM Units WHERE (Type = 'UNIT_GREAT_GENERAL');

INSERT INTO Buildings 	
			(Type, 								BuildingClass, 						WonderSplashImage,		Water,	GreatWorkCount, Cost, FaithCost, NukeImmune, ConquestProb,  PrereqTech,	Description, 					Help,								PortraitIndex, 	IconAtlas)
VALUES		('BUILDING_TCM_DUMMY_POLYREME_1',	'BUILDINGCLASS_TCM_POLYREME_1', 	'PolyremeSplash.dds',	1,		-1, 			200,   -1, 		 1,		 	 0,				NULL, 		'TXT_KEY_UNIT_TCM_POLYREME', 	'TXT_KEY_UNIT_HELP_TCM_POLYREME',	2, 				'TCM_PTOLEMIES_ATLAS'),
			('BUILDING_TCM_DUMMY_POLYREME_2',	'BUILDINGCLASS_TCM_POLYREME_2', 	'PolyremeSplash.dds',	1,		-1, 			375,   -1, 		 1,		 	 0,				NULL, 		'TXT_KEY_UNIT_TCM_POLYREME', 	'TXT_KEY_UNIT_HELP_TCM_POLYREME',	2, 				'TCM_PTOLEMIES_ATLAS'),
			('BUILDING_TCM_DUMMY_POLYREME_3',	'BUILDINGCLASS_TCM_POLYREME_3', 	'PolyremeSplash.dds',	1,		-1, 			725,   -1, 		 1,		 	 0,				NULL, 		'TXT_KEY_UNIT_TCM_POLYREME', 	'TXT_KEY_UNIT_HELP_TCM_POLYREME',	2, 				'TCM_PTOLEMIES_ATLAS'),
			('BUILDING_TCM_DUMMY_POLYREME_4',	'BUILDINGCLASS_TCM_POLYREME_4', 	'PolyremeSplash.dds',	1,		-1, 			1200,  -1, 		 1,		 	 0,				NULL, 		'TXT_KEY_UNIT_TCM_POLYREME', 	'TXT_KEY_UNIT_HELP_TCM_POLYREME',	2, 				'TCM_PTOLEMIES_ATLAS');

INSERT INTO Building_ClassesNeededInCity 	
			(BuildingType, 						BuildingClassType)
VALUES		('BUILDING_TCM_DUMMY_POLYREME_1',	'BUILDINGCLASS_TCM_PTOLEMIES_DUMMY_1'),
			('BUILDING_TCM_DUMMY_POLYREME_2',	'BUILDINGCLASS_TCM_PTOLEMIES_DUMMY_2'),
			('BUILDING_TCM_DUMMY_POLYREME_3',	'BUILDINGCLASS_TCM_PTOLEMIES_DUMMY_3'),
			('BUILDING_TCM_DUMMY_POLYREME_4',	'BUILDINGCLASS_TCM_PTOLEMIES_DUMMY_4');
--==========================================================================================================================	
-- UnitGameplay2DScripts
--==========================================================================================================================		
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 				SelectionSound, FirstSelectionSound)
SELECT		('UNIT_TCM_POLYREME'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_GREAT_ADMIRAL');		

INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 							SelectionSound, FirstSelectionSound)
SELECT		('UNIT_TCM_PTOLEMAIC_GENERAL'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_GREAT_GENERAL');		
--==========================================================================================================================	
-- Unit_AITypes
--==========================================================================================================================		
INSERT INTO Unit_AITypes 	
			(UnitType, 				UnitAIType)
SELECT		('UNIT_TCM_POLYREME'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_GREAT_ADMIRAL');

INSERT INTO Unit_AITypes 	
			(UnitType, 							UnitAIType)
SELECT		('UNIT_TCM_PTOLEMAIC_GENERAL'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_ENGINEER');
--==========================================================================================================================	
-- Unit_Builds
--==========================================================================================================================		
INSERT INTO Unit_Builds 	
			(UnitType, 							BuildType)
SELECT		('UNIT_TCM_PTOLEMAIC_GENERAL'), 	BuildType
FROM Unit_Builds WHERE (UnitType = 'UNIT_GREAT_GENERAL');
--==========================================================================================================================	
-- Unit_FreePromotions
--==========================================================================================================================		
INSERT INTO Unit_FreePromotions 	
			(UnitType, 						PromotionType)
VALUES		('UNIT_TCM_POLYREME', 			'PROMOTION_GREAT_ADMIRAL'),
			('UNIT_TCM_PTOLEMAIC_GENERAL', 	'PROMOTION_GREAT_GENERAL');
--==========================================================================================================================
INSERT INTO Unit_UniqueNames
		(UnitType,						UniqueName)
SELECT	'UNIT_TCM_PTOLEMAIC_GENERAL',	UniqueName
FROM Unit_UniqueNames WHERE UnitType = 'UNIT_GREAT_GENERAL';
--==========================================================================================================================	
-- Unit_Flavors
--==========================================================================================================================					
INSERT INTO Unit_Flavors 
			(UnitType, 				FlavorType,				Flavor)
VALUES		('UNIT_TCM_POLYREME', 	'FLAVOR_GROWTH',		10);
--==========================================================================================================================	
--==========================================================================================================================
--==========================================================================================================================	
-- Diplomacy_Responses
--==========================================================================================================================	
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_TCM_PTOLEMY','RESPONSE_FIRST_GREETING',	'TXT_KEY_LEADER_TCM_PTOLEMY_FIRSTGREETING%','1');
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_TCM_PTOLEMY','RESPONSE_DEFEATED',		'TXT_KEY_LEADER_TCM_PTOLEMY_DEFEATED%','1');
--==========================================================================================================================	
--==========================================================================================================================	
INSERT INTO Policies 
			(Type, 							Description)
VALUES		('POLICY_TCM_SERAPIS_POLICY', 	'TXT_KEY_DECISIONS_TCM_PTOLEMIES_SERAPIS');

INSERT INTO Policy_BuildingClassProductionModifiers 
			(PolicyType, 					BuildingClassType,		ProductionModifier)
VALUES		('POLICY_TCM_SERAPIS_POLICY', 	'BUILDINGCLASS_TEMPLE', 20);

INSERT INTO Policy_BuildingClassHappiness 
			(PolicyType, 					BuildingClassType,		Happiness)
VALUES		('POLICY_TCM_SERAPIS_POLICY', 	'BUILDINGCLASS_TEMPLE', 1);