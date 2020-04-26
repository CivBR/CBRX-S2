--==========================================================================================================================	
-- LEADER
--==========================================================================================================================	

--------------------------------	
-- Civilization_Leaders
--------------------------------		
INSERT INTO Civilization_Leaders 
		(CivilizationType, 				LeaderheadType)
VALUES	('CIVILIZATION_PG_GRANCOLOMBIA',	'LEADER_PG_BOLIVAR');

--------------------------------
-- Leaders
--------------------------------			
INSERT INTO Leaders 
		(Type, 					Description, 					Civilopedia, 						CivilopediaTag, 							ArtDefineTag, 				VictoryCompetitiveness,		WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness,		DiploBalance, 	WarmongerHate, 		DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 			PortraitIndex)
VALUES	('LEADER_PG_BOLIVAR', 	'TXT_KEY_LEADER_PG_BOLIVAR',	'TXT_KEY_LEADER_PG_BOLIVAR_PEDIA',	'TXT_KEY_CIVILOPEDIA_LEADERS_PG_BOLIVAR', 	'Bolivar_Scene.xml',		10, 						2, 						10, 						10, 			5,				10, 				8, 						5, 				10, 		1, 			1, 				10,			7, 			'PG_GRANCOLOMBIA_ATLAS', 	0);
--------------------------------		
-- Leader_MajorCivApproachBiases
--------------------------------						
INSERT INTO Leader_MajorCivApproachBiases 
		(LeaderType, 			MajorCivApproachType, 				Bias)
VALUES	('LEADER_PG_BOLIVAR', 	'MAJOR_CIV_APPROACH_WAR', 			9),
		('LEADER_PG_BOLIVAR', 	'MAJOR_CIV_APPROACH_HOSTILE', 		9),
		('LEADER_PG_BOLIVAR', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	1),
		('LEADER_PG_BOLIVAR', 	'MAJOR_CIV_APPROACH_GUARDED', 		7),
		('LEADER_PG_BOLIVAR', 	'MAJOR_CIV_APPROACH_AFRAID', 		1),
		('LEADER_PG_BOLIVAR', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		6),
		('LEADER_PG_BOLIVAR', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		6);
--------------------------------	
-- Leader_MajorCivApproachBiases
--------------------------------							
INSERT INTO Leader_MinorCivApproachBiases 
		(LeaderType, 			MinorCivApproachType, 				Bias)
VALUES	('LEADER_PG_BOLIVAR', 	'MINOR_CIV_APPROACH_IGNORE', 		0),
		('LEADER_PG_BOLIVAR', 	'MINOR_CIV_APPROACH_FRIENDLY', 		10),
		('LEADER_PG_BOLIVAR', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	10),
		('LEADER_PG_BOLIVAR', 	'MINOR_CIV_APPROACH_CONQUEST', 		0),
		('LEADER_PG_BOLIVAR', 	'MINOR_CIV_APPROACH_BULLY', 		4);
--------------------------------	
-- Leader_Flavors
--------------------------------							
INSERT INTO Leader_Flavors 
		(LeaderType, 			FlavorType, 						Flavor)
VALUES	('LEADER_PG_BOLIVAR', 	'FLAVOR_OFFENSE', 					9),
		('LEADER_PG_BOLIVAR', 	'FLAVOR_DEFENSE', 					5),
		('LEADER_PG_BOLIVAR', 	'FLAVOR_CITY_DEFENSE', 				5),
		('LEADER_PG_BOLIVAR', 	'FLAVOR_MILITARY_TRAINING', 		9),
		('LEADER_PG_BOLIVAR', 	'FLAVOR_RECON', 					5),
		('LEADER_PG_BOLIVAR', 	'FLAVOR_RANGED', 					5),
		('LEADER_PG_BOLIVAR', 	'FLAVOR_MOBILE', 					9),
		('LEADER_PG_BOLIVAR', 	'FLAVOR_NAVAL', 					7),
		('LEADER_PG_BOLIVAR', 	'FLAVOR_NAVAL_RECON', 				6),
		('LEADER_PG_BOLIVAR', 	'FLAVOR_NAVAL_GROWTH', 				6),
		('LEADER_PG_BOLIVAR', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
		('LEADER_PG_BOLIVAR', 	'FLAVOR_AIR', 						5),
		('LEADER_PG_BOLIVAR', 	'FLAVOR_EXPANSION', 				10),
		('LEADER_PG_BOLIVAR', 	'FLAVOR_GROWTH', 					7),
		('LEADER_PG_BOLIVAR', 	'FLAVOR_TILE_IMPROVEMENT', 			8),
		('LEADER_PG_BOLIVAR', 	'FLAVOR_INFRASTRUCTURE', 			5),
		('LEADER_PG_BOLIVAR', 	'FLAVOR_PRODUCTION', 				6),
		('LEADER_PG_BOLIVAR', 	'FLAVOR_GOLD', 						5),
		('LEADER_PG_BOLIVAR', 	'FLAVOR_SCIENCE', 					5),
		('LEADER_PG_BOLIVAR', 	'FLAVOR_CULTURE', 					9),
		('LEADER_PG_BOLIVAR', 	'FLAVOR_HAPPINESS', 				5),
		('LEADER_PG_BOLIVAR', 	'FLAVOR_GREAT_PEOPLE', 				9),
		('LEADER_PG_BOLIVAR', 	'FLAVOR_WONDER', 					4),
		('LEADER_PG_BOLIVAR', 	'FLAVOR_RELIGION', 					0),
		('LEADER_PG_BOLIVAR', 	'FLAVOR_DIPLOMACY', 				9),
		('LEADER_PG_BOLIVAR', 	'FLAVOR_SPACESHIP', 				0),
		('LEADER_PG_BOLIVAR', 	'FLAVOR_WATER_CONNECTION', 			5),
		('LEADER_PG_BOLIVAR', 	'FLAVOR_NUKE', 						8),
		('LEADER_PG_BOLIVAR', 	'FLAVOR_USE_NUKE', 					8),
		('LEADER_PG_BOLIVAR', 	'FLAVOR_ESPIONAGE', 				10),
		('LEADER_PG_BOLIVAR', 	'FLAVOR_AIRLIFT', 					5),
		('LEADER_PG_BOLIVAR', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
		('LEADER_PG_BOLIVAR', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
		('LEADER_PG_BOLIVAR', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
		('LEADER_PG_BOLIVAR', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
		('LEADER_PG_BOLIVAR', 	'FLAVOR_ARCHAEOLOGY', 				5),
		('LEADER_PG_BOLIVAR', 	'FLAVOR_AIR_CARRIER', 				5);

		
--==========================================================================================================================
--==========================================================================================================================