--____________________________________________________________________________________________________________________________________
--Civilization Defines

INSERT INTO Civilizations 	
			(Type, 						DerivativeCiv,			 Description, 					ShortDescription, 					 Adjective, 							Civilopedia, 						CivilopediaTag, 			DefaultPlayerColor,		  IconAtlas,			AlphaIconAtlas, 			PortraitIndex,	SoundtrackTag, 	MapImage, 				DawnOfManQuote, 					DawnOfManImage,			ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix)
SELECT		('CIVILIZATION_TAR_YUAN'), 	('CIVILIZATION_CHINA'), ('TXT_KEY_CIV_TAR_YUAN_DESC'), 	('TXT_KEY_CIV_TAR_YUAN_SHORT_DESC'), ('TXT_KEY_CIV_TAR_YUAN_ADJECTIVE'), 	('TXT_KEY_CIV5_TAR_YUAN_TEXT_1'),	('TXT_KEY_CIV5_TAR_YUAN'), 	('PLAYERCOLOR_TAR_YUAN'), ('TAR_YUAN_ATLAS'), 	('TAR_YUAN_ALPHA_ATLAS'), 	0, 				('CHINA'),	 	('Tar_Yuan_Map.dds'), 	('TXT_KEY_CIV5_DOM_TAR_YUAN_TEXT'), ('Tar_Yuan_DOM.dds'), 	ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix
FROM Civilizations WHERE Type = 'CIVILIZATION_CHINA';

INSERT INTO Civilization_CityNames 
		(CivilizationType, 			CityName) 
VALUES	('CIVILIZATION_TAR_YUAN', 	'TXT_KEY_CITY_NAME_C15_CIVILIZATION_TAR_YUAN_1'),
		('CIVILIZATION_TAR_YUAN', 	'TXT_KEY_CITY_NAME_C15_CIVILIZATION_TAR_YUAN_2'),
		('CIVILIZATION_TAR_YUAN', 	'TXT_KEY_CITY_NAME_C15_CIVILIZATION_TAR_YUAN_3'),
		('CIVILIZATION_TAR_YUAN', 	'TXT_KEY_CITY_NAME_C15_CIVILIZATION_TAR_YUAN_4'),
		('CIVILIZATION_TAR_YUAN', 	'TXT_KEY_CITY_NAME_KAIFENG'),
		('CIVILIZATION_TAR_YUAN', 	'TXT_KEY_CITY_NAME_C15_CIVILIZATION_TAR_YUAN_5'),
		('CIVILIZATION_TAR_YUAN', 	'TXT_KEY_CITY_NAME_HANGZHOU'),
		('CIVILIZATION_TAR_YUAN', 	'TXT_KEY_CITY_NAME_LIAOYANG'),
		('CIVILIZATION_TAR_YUAN', 	'TXT_KEY_CITY_NAME_KARAKORUM'),
		('CIVILIZATION_TAR_YUAN', 	'TXT_KEY_CITY_NAME_XIAN'),
		('CIVILIZATION_TAR_YUAN', 	'TXT_KEY_CITY_NAME_CHENGDU'),
		('CIVILIZATION_TAR_YUAN', 	'TXT_KEY_CITY_NAME_KUNMING'),
		('CIVILIZATION_TAR_YUAN', 	'TXT_KEY_CITY_NAME_KAESONG'),
		('CIVILIZATION_TAR_YUAN', 	'TXT_KEY_CITY_NAME_GUANGZHOU'),
		('CIVILIZATION_TAR_YUAN', 	'TXT_KEY_CITY_NAME_C15_CIVILIZATION_TAR_YUAN_6'),
		('CIVILIZATION_TAR_YUAN', 	'TXT_KEY_CITY_NAME_CHONGQING'),
		('CIVILIZATION_TAR_YUAN', 	'TXT_KEY_CITY_NAME_C15_CIVILIZATION_TAR_YUAN_7'),
		('CIVILIZATION_TAR_YUAN', 	'TXT_KEY_CITY_NAME_YANGZHOU'),
		('CIVILIZATION_TAR_YUAN', 	'TXT_KEY_CITY_NAME_C15_CIVILIZATION_TAR_YUAN_8'),
		('CIVILIZATION_TAR_YUAN', 	'TXT_KEY_CITY_NAME_JINAN'),
		('CIVILIZATION_TAR_YUAN', 	'TXT_KEY_CITY_NAME_C15_CIVILIZATION_TAR_YUAN_9'),
		('CIVILIZATION_TAR_YUAN', 	'TXT_KEY_CITY_NAME_BAODING'),
		('CIVILIZATION_TAR_YUAN', 	'TXT_KEY_CITY_NAME_TAIYUAN'),
		('CIVILIZATION_TAR_YUAN', 	'TXT_KEY_CITY_NAME_BESHBALIK'),
		('CIVILIZATION_TAR_YUAN', 	'TXT_KEY_CITY_NAME_C15_CIVILIZATION_TAR_YUAN_10'),
		('CIVILIZATION_TAR_YUAN', 	'TXT_KEY_CITY_NAME_C15_CIVILIZATION_TAR_YUAN_11'),
		('CIVILIZATION_TAR_YUAN', 	'TXT_KEY_CITY_NAME_C15_CIVILIZATION_TAR_YUAN_12'),
		('CIVILIZATION_TAR_YUAN', 	'TXT_KEY_CITY_NAME_C15_CIVILIZATION_TAR_YUAN_13'),
		('CIVILIZATION_TAR_YUAN', 	'TXT_KEY_CITY_NAME_C15_CIVILIZATION_TAR_YUAN_14'),
		('CIVILIZATION_TAR_YUAN', 	'TXT_KEY_CITY_NAME_C15_CIVILIZATION_TAR_YUAN_15'),
		('CIVILIZATION_TAR_YUAN', 	'TXT_KEY_CITY_NAME_C15_CIVILIZATION_TAR_YUAN_16'),
		('CIVILIZATION_TAR_YUAN', 	'TXT_KEY_CITY_NAME_C15_CIVILIZATION_TAR_YUAN_17');
		
INSERT INTO Language_en_US -- Here because Reasons
		(Tag, 												Text) 
VALUES	('TXT_KEY_CITY_NAME_C15_CIVILIZATION_TAR_YUAN_1', 	'Khanbaliq'),
		('TXT_KEY_CITY_NAME_C15_CIVILIZATION_TAR_YUAN_2', 	'Shangdu'),
		('TXT_KEY_CITY_NAME_C15_CIVILIZATION_TAR_YUAN_3', 	'Ganzhou'),
		('TXT_KEY_CITY_NAME_C15_CIVILIZATION_TAR_YUAN_4', 	'Wuchang'),
		('TXT_KEY_CITY_NAME_C15_CIVILIZATION_TAR_YUAN_5', 	'Nanchang'),
		('TXT_KEY_CITY_NAME_C15_CIVILIZATION_TAR_YUAN_6', 	'Changsha'),
		('TXT_KEY_CITY_NAME_C15_CIVILIZATION_TAR_YUAN_7', 	'Luoyang'),
		('TXT_KEY_CITY_NAME_C15_CIVILIZATION_TAR_YUAN_8', 	'Fuzhou'),
		('TXT_KEY_CITY_NAME_C15_CIVILIZATION_TAR_YUAN_9', 	'Quanzhou'),
		('TXT_KEY_CITY_NAME_C15_CIVILIZATION_TAR_YUAN_10', 	'Henan-fu'),
		('TXT_KEY_CITY_NAME_C15_CIVILIZATION_TAR_YUAN_11', 	'Xuzhou'),
		('TXT_KEY_CITY_NAME_C15_CIVILIZATION_TAR_YUAN_12', 	'Leizhou'),
		('TXT_KEY_CITY_NAME_C15_CIVILIZATION_TAR_YUAN_13', 	'Yingchang'),
		('TXT_KEY_CITY_NAME_C15_CIVILIZATION_TAR_YUAN_14', 	'Datong'),
		('TXT_KEY_CITY_NAME_C15_CIVILIZATION_TAR_YUAN_15', 	'Turpan'),
		('TXT_KEY_CITY_NAME_C15_CIVILIZATION_TAR_YUAN_16', 	'Wenzhou'),
		('TXT_KEY_CITY_NAME_C15_CIVILIZATION_TAR_YUAN_17', 	'Anfeng');

INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 			BuildingClassType)
VALUES		('CIVILIZATION_TAR_YUAN', 	'BUILDINGCLASS_PALACE');
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 			TechType)
SELECT		('CIVILIZATION_TAR_YUAN'), 	TechType
FROM Civilization_FreeTechs WHERE CivilizationType = 'CIVILIZATION_CHINA';
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 			UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_TAR_YUAN'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE CivilizationType = 'CIVILIZATION_CHINA';

INSERT INTO Civilization_Leaders 
			(CivilizationType, 			LeaderheadType)
VALUES		('CIVILIZATION_TAR_YUAN', 	'LEADER_TAR_KUBLAI_KHAN');

INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 			UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_TAR_YUAN', 	'UNITCLASS_GALLEASS', 	'UNIT_TAR_SAO');

INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 			BuildingClassType, 			BuildingType)
VALUES		('CIVILIZATION_TAR_YUAN', 	'BUILDINGCLASS_COURTHOUSE', 'BUILDING_TAR_SECRETARIAT');

INSERT INTO Civilization_Religions 
			(CivilizationType, 			ReligionType)
VALUES		('CIVILIZATION_TAR_YUAN', 	'RELIGION_BUDDHISM');

INSERT INTO Civilization_SpyNames 
			(CivilizationType, 			SpyName)
SELECT		'CIVILIZATION_TAR_YUAN',	SpyName
FROM Civilization_SpyNames WHERE CivilizationType = 'CIVILIZATION_MONGOL';

INSERT INTO Colors 
			(Type, 									Red, 	Green, 	Blue, 	Alpha)
VALUES		('COLOR_PLAYER_TAR_YUAN_ICON',			0.024,	0.294,	0.408,	1),
			('COLOR_PLAYER_TAR_YUAN_BACKGROUND',	0.627,	0.804,	0.824,	1); 
				
INSERT INTO PlayerColors 
			(Type, 						PrimaryColor, 					SecondaryColor, 					TextColor)
VALUES		('PLAYERCOLOR_TAR_YUAN',	'COLOR_PLAYER_TAR_YUAN_ICON',	'COLOR_PLAYER_TAR_YUAN_BACKGROUND', 'COLOR_PLAYER_WHITE_TEXT');

--____________________________________________________________________________________________________________________________________
--Leader Defines
INSERT INTO Leaders 
			(Type, 						Description, 						Civilopedia, 								 CivilopediaTag, 						 ArtDefineTag, 				IconAtlas, 			PortraitIndex, 	VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness)
VALUES		('LEADER_TAR_KUBLAI_KHAN', 	'TXT_KEY_LEADER_TAR_KUBLAI_KHAN', 	'TXT_KEY_LEADER_TAR_KUBLAI_KHAN_PEDIA_TEXT', 'TXT_KEY_LEADER_TAR_KUBLAI_KHAN_PEDIA', 'YuanLeaderscreen.xml',	'TAR_YUAN_ATLAS', 	1,				9, 						5, 						6, 							10, 		5, 				3, 				6, 					 4, 			 6, 		9, 			0,				10, 		 10);
					
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 				MajorCivApproachType, 				Bias)
VALUES		('LEADER_TAR_KUBLAI_KHAN', 	'MAJOR_CIV_APPROACH_WAR', 			10),
			('LEADER_TAR_KUBLAI_KHAN', 	'MAJOR_CIV_APPROACH_HOSTILE', 		8),
			('LEADER_TAR_KUBLAI_KHAN', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	0),
			('LEADER_TAR_KUBLAI_KHAN', 	'MAJOR_CIV_APPROACH_GUARDED', 		0),
			('LEADER_TAR_KUBLAI_KHAN', 	'MAJOR_CIV_APPROACH_AFRAID', 		0),
			('LEADER_TAR_KUBLAI_KHAN', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		6),
			('LEADER_TAR_KUBLAI_KHAN', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		5);
					
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 				MinorCivApproachType, 				Bias)
VALUES		('LEADER_TAR_KUBLAI_KHAN', 	'MINOR_CIV_APPROACH_IGNORE', 		0),
			('LEADER_TAR_KUBLAI_KHAN', 	'MINOR_CIV_APPROACH_FRIENDLY', 		4),
			('LEADER_TAR_KUBLAI_KHAN', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	6),
			('LEADER_TAR_KUBLAI_KHAN', 	'MINOR_CIV_APPROACH_CONQUEST', 		10),
			('LEADER_TAR_KUBLAI_KHAN', 	'MINOR_CIV_APPROACH_BULLY', 		7);

INSERT INTO Leader_Flavors 
			(LeaderType, 				FlavorType, 						Flavor)
VALUES		('LEADER_TAR_KUBLAI_KHAN', 	'FLAVOR_OFFENSE', 					10),
			('LEADER_TAR_KUBLAI_KHAN', 	'FLAVOR_DEFENSE', 					3),
			('LEADER_TAR_KUBLAI_KHAN', 	'FLAVOR_CITY_DEFENSE', 				3),
			('LEADER_TAR_KUBLAI_KHAN', 	'FLAVOR_MILITARY_TRAINING', 		8),
			('LEADER_TAR_KUBLAI_KHAN', 	'FLAVOR_RECON', 					6),
			('LEADER_TAR_KUBLAI_KHAN', 	'FLAVOR_RANGED', 					8),
			('LEADER_TAR_KUBLAI_KHAN', 	'FLAVOR_MOBILE', 					7),
			('LEADER_TAR_KUBLAI_KHAN', 	'FLAVOR_NAVAL', 					8),
			('LEADER_TAR_KUBLAI_KHAN', 	'FLAVOR_NAVAL_RECON', 				5),
			('LEADER_TAR_KUBLAI_KHAN', 	'FLAVOR_NAVAL_GROWTH', 				5),
			('LEADER_TAR_KUBLAI_KHAN', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
			('LEADER_TAR_KUBLAI_KHAN', 	'FLAVOR_AIR', 						5),
			('LEADER_TAR_KUBLAI_KHAN', 	'FLAVOR_EXPANSION', 				9),
			('LEADER_TAR_KUBLAI_KHAN', 	'FLAVOR_GROWTH', 					2),
			('LEADER_TAR_KUBLAI_KHAN', 	'FLAVOR_TILE_IMPROVEMENT', 			7),
			('LEADER_TAR_KUBLAI_KHAN', 	'FLAVOR_INFRASTRUCTURE', 			6),
			('LEADER_TAR_KUBLAI_KHAN', 	'FLAVOR_PRODUCTION', 				5),
			('LEADER_TAR_KUBLAI_KHAN', 	'FLAVOR_GOLD', 						8),
			('LEADER_TAR_KUBLAI_KHAN', 	'FLAVOR_SCIENCE', 					7),
			('LEADER_TAR_KUBLAI_KHAN', 	'FLAVOR_CULTURE', 					3),
			('LEADER_TAR_KUBLAI_KHAN', 	'FLAVOR_HAPPINESS', 				5),
			('LEADER_TAR_KUBLAI_KHAN', 	'FLAVOR_GREAT_PEOPLE', 				2),
			('LEADER_TAR_KUBLAI_KHAN', 	'FLAVOR_WONDER', 					3),
			('LEADER_TAR_KUBLAI_KHAN', 	'FLAVOR_RELIGION', 					3),
			('LEADER_TAR_KUBLAI_KHAN', 	'FLAVOR_DIPLOMACY', 				1),
			('LEADER_TAR_KUBLAI_KHAN', 	'FLAVOR_SPACESHIP', 				5),
			('LEADER_TAR_KUBLAI_KHAN', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_TAR_KUBLAI_KHAN', 	'FLAVOR_NUKE', 						10),
			('LEADER_TAR_KUBLAI_KHAN', 	'FLAVOR_USE_NUKE', 					5),
			('LEADER_TAR_KUBLAI_KHAN', 	'FLAVOR_ESPIONAGE', 				8),
			('LEADER_TAR_KUBLAI_KHAN', 	'FLAVOR_AIRLIFT', 					5),
			('LEADER_TAR_KUBLAI_KHAN', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_TAR_KUBLAI_KHAN', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_TAR_KUBLAI_KHAN', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_TAR_KUBLAI_KHAN', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_TAR_KUBLAI_KHAN', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_TAR_KUBLAI_KHAN', 	'FLAVOR_AIR_CARRIER', 				5);

INSERT INTO Leader_Traits 
			(LeaderType, 				TraitType)
VALUES		('LEADER_TAR_KUBLAI_KHAN', 	'TRAIT_TAR_YUAN_KUBLAI_KHAN');

INSERT INTO Traits 
			(Type, 							Description, 							ShortDescription)
VALUES		('TRAIT_TAR_YUAN_KUBLAI_KHAN', 	'TXT_KEY_TRAIT_TAR_YUAN_KUBLAI_KHAN', 	'TXT_KEY_TRAIT_TAR_YUAN_KUBLAI_KHAN_SHORT');

INSERT INTO Audio_Sounds 
			(SoundID, 									Filename, 					LoadType) -- It's both lazy *and* symbolic
VALUES		('SND_LEADER_MUSIC_TAR_KUBLAI_KHAN_PEACE', 	'Empress_Wu_Zetian_Peace', 	'DynamicResident'),
			('SND_LEADER_MUSIC_TAR_KUBLAI_KHAN_WAR',	'Genghis_Khan_War', 		'DynamicResident');		

INSERT INTO Audio_2DSounds 
			(ScriptID, 										SoundID, 									SoundType, 		MinVolume, 	MaxVolume,	IsMusic,	Looping)
VALUES		('AS2D_LEADER_MUSIC_TAR_KUBLAI_KHAN_PEACE', 	'SND_LEADER_MUSIC_TAR_KUBLAI_KHAN_PEACE', 	'GAME_MUSIC', 	80, 		80, 		1, 			0),
			('AS2D_LEADER_MUSIC_TAR_KUBLAI_KHAN_WAR', 		'SND_LEADER_MUSIC_TAR_KUBLAI_KHAN_WAR', 	'GAME_MUSIC', 	80, 		80, 		1,			0);

INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_TAR_KUBLAI_KHAN','RESPONSE_FIRST_GREETING',	'TXT_KEY_LEADER_TAR_KUBLAI_KHAN_FIRSTGREETING%','1');
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_TAR_KUBLAI_KHAN','RESPONSE_DEFEATED',		'TXT_KEY_LEADER_TAR_KUBLAI_KHAN_DEFEATED%','1');
--____________________________________________________________________________________________________________________________________
--Unit Defines
INSERT INTO Units 	
			(Class, 	Type, 				PrereqTech, Combat,	RangedCombat, Cost, Range, ObsoleteTech, FaithCost, RequiresFaithPurchaseEnabled, Moves, CombatClass, Domain, DefaultUnitAI, Description, 				Civilopedia, 								Strategy, 							Help, 							UnitArtInfo, 				UnitFlagIconOffset,	UnitFlagAtlas,				PortraitIndex, 	IconAtlas,			 MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, AdvancedStartCost, Mechanized, CombatLimit, MinAreaSize, Pillage, XPValueAttack, XPValueDefense, Conscription,  MoveRate)
SELECT		Class,		('UNIT_TAR_SAO'),	PrereqTech, Combat,	RangedCombat, Cost, Range, ObsoleteTech, FaithCost, RequiresFaithPurchaseEnabled, Moves, CombatClass, Domain, DefaultUnitAI, ('TXT_KEY_UNIT_TAR_SAO'),  ('TXT_KEY_CIVILOPEDIA_UNITS_TAR_SAO_TEXT'), ('TXT_KEY_UNIT_TAR_SAO_STRATEGY'), 	('TXT_KEY_UNIT_HELP_TAR_SAO'),  ('ART_DEF_UNIT_TAR_SAO'),	0,					('TAR_UNIT_FLAG_SAO_ATLAS'), 2, 			('TAR_YUAN_ATLAS'),  MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, AdvancedStartCost, Mechanized, CombatLimit, MinAreaSize, Pillage, XPValueAttack, XPValueDefense, Conscription,  MoveRate
FROM Units WHERE (Type = 'UNIT_GALLEASS');

INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 			SelectionSound, FirstSelectionSound)
SELECT		('UNIT_TAR_SAO'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_GALLEASS');

INSERT INTO Unit_AITypes 	
			(UnitType, 			UnitAIType)
SELECT		('UNIT_TAR_SAO'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_GALLEASS');	

INSERT INTO Unit_ClassUpgrades 	
			(UnitType, 			UnitClassType)
VALUES		('UNIT_TAR_SAO', 	'UNITCLASS_FRIGATE');

INSERT INTO Unit_Flavors 	
			(UnitType, 			FlavorType,					Flavor)
VALUES		('UNIT_TAR_SAO', 	'FLAVOR_NAVAL',				20),
			('UNIT_TAR_SAO', 	'FLAVOR_NAVAL_RECON',		2);

INSERT INTO Unit_FreePromotions 	
			(UnitType, 			PromotionType)
VALUES		('UNIT_TAR_SAO', 	'PROMOTION_OCEAN_IMPASSABLE'),
			('UNIT_TAR_SAO', 	'PROMOTION_ONLY_DEFENSIVE');
--____________________________________________________________________________________________________________________________________
--Building Defines
INSERT INTO Buildings
			(Type, 					   		BuildingClass, Cost, GoldMaintenance, PrereqTech, ConquestProb, NoOccupiedUnhappiness,	Description,							Help,										Civilopedia,							Strategy,										ArtDefineTag, MinAreaSize, 	HurryCostModifier, IconAtlas,			PortraitIndex)
SELECT		('BUILDING_TAR_SECRETARIAT'),	BuildingClass, Cost, GoldMaintenance, PrereqTech, ConquestProb, NoOccupiedUnhappiness,	('TXT_KEY_BUILDING_TAR_SECRETARIAT'),	('TXT_KEY_BUILDING_TAR_SECRETARIAT_HELP'),	('TXT_KEY_CIV5_TAR_SECRETARIAT_TEXT'),	('TXT_KEY_BUILDING_TAR_SECRETARIAT_STRATEGY'),	ArtDefineTag, MinAreaSize, 	HurryCostModifier, ('TAR_YUAN_ATLAS'), 	3
FROM Buildings WHERE Type = 'BUILDING_COURTHOUSE';		
	
INSERT INTO Building_Flavors 
			(BuildingType, 					FlavorType,						Flavor)
VALUES		('BUILDING_TAR_SECRETARIAT', 	'FLAVOR_HAPPINESS',				150),
			('BUILDING_TAR_SECRETARIAT', 	'FLAVOR_MILITARY_TRAINING',		150),
			('BUILDING_TAR_SECRETARIAT', 	'FLAVOR_PRODUCTION',			150);