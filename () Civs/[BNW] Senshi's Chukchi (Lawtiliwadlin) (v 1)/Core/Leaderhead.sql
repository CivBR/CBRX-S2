--==========================================================================================================================	
-- Leaders
--==========================================================================================================================			
INSERT INTO Leaders 
			(Type, 							Description, 						Civilopedia, 									CivilopediaTag, 								ArtDefineTag, 											VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 					PortraitIndex)
VALUES		('LEADER_SENSHI_LAWTILIWADLIN', 		'TXT_KEY_LEADER_SENSHI_LAWTILIWADLIN', 	'TXT_KEY_CIVILOPEDIA_LEADER_SENSHI_LAWTILIWADLIN', 	'TXT_KEY_CIVILOPEDIA_LEADERS_SENSHI_LAWTILIWADLIN', 	'Senshi_Lawtiliwadlin_Scene.xml',		6, 						2, 						2, 							8, 			3, 				3, 				7, 						4, 				4, 			2, 			2, 				7, 			8, 			'SENSHI_CHUKCHI_ATLAS',		1);
--==========================================================================================================================	
-- Leader_MajorCivApproachBiases
--==========================================================================================================================						
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 				MajorCivApproachType, 				Bias)
VALUES		('LEADER_SENSHI_LAWTILIWADLIN', 		'MAJOR_CIV_APPROACH_WAR', 			8),
			('LEADER_SENSHI_LAWTILIWADLIN', 		'MAJOR_CIV_APPROACH_HOSTILE', 		7),
			('LEADER_SENSHI_LAWTILIWADLIN', 		'MAJOR_CIV_APPROACH_DECEPTIVE', 	2),
			('LEADER_SENSHI_LAWTILIWADLIN', 		'MAJOR_CIV_APPROACH_GUARDED', 		7),
			('LEADER_SENSHI_LAWTILIWADLIN', 		'MAJOR_CIV_APPROACH_AFRAID', 		2),
			('LEADER_SENSHI_LAWTILIWADLIN', 		'MAJOR_CIV_APPROACH_FRIENDLY', 		4),
			('LEADER_SENSHI_LAWTILIWADLIN', 		'MAJOR_CIV_APPROACH_NEUTRAL', 		5);
--==========================================================================================================================	
-- Leader_MajorCivApproachBiases
--==========================================================================================================================						
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 			MinorCivApproachType, 				Bias)
VALUES		('LEADER_SENSHI_LAWTILIWADLIN', 	'MINOR_CIV_APPROACH_IGNORE', 		6),
			('LEADER_SENSHI_LAWTILIWADLIN', 	'MINOR_CIV_APPROACH_FRIENDLY', 		6),
			('LEADER_SENSHI_LAWTILIWADLIN', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	2),
			('LEADER_SENSHI_LAWTILIWADLIN', 	'MINOR_CIV_APPROACH_CONQUEST', 		5),
			('LEADER_SENSHI_LAWTILIWADLIN', 	'MINOR_CIV_APPROACH_BULLY', 		8);
--==========================================================================================================================	
-- Leader_Flavors
--==========================================================================================================================						
INSERT INTO Leader_Flavors 
			(LeaderType, 			FlavorType, 						Flavor)
VALUES		('LEADER_SENSHI_LAWTILIWADLIN', 	'FLAVOR_OFFENSE', 					8),
			('LEADER_SENSHI_LAWTILIWADLIN', 	'FLAVOR_DEFENSE', 					7),
			('LEADER_SENSHI_LAWTILIWADLIN', 	'FLAVOR_CITY_DEFENSE', 				4),
			('LEADER_SENSHI_LAWTILIWADLIN', 	'FLAVOR_MILITARY_TRAINING', 		8),
			('LEADER_SENSHI_LAWTILIWADLIN', 	'FLAVOR_RECON', 					5),
			('LEADER_SENSHI_LAWTILIWADLIN', 	'FLAVOR_RANGED', 					7),
			('LEADER_SENSHI_LAWTILIWADLIN', 	'FLAVOR_MOBILE', 					6),
			('LEADER_SENSHI_LAWTILIWADLIN', 	'FLAVOR_NAVAL', 					6),
			('LEADER_SENSHI_LAWTILIWADLIN', 	'FLAVOR_NAVAL_RECON', 				5),
			('LEADER_SENSHI_LAWTILIWADLIN', 	'FLAVOR_NAVAL_GROWTH', 				7),
			('LEADER_SENSHI_LAWTILIWADLIN', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	6),
			('LEADER_SENSHI_LAWTILIWADLIN', 	'FLAVOR_AIR', 						6),
			('LEADER_SENSHI_LAWTILIWADLIN', 	'FLAVOR_EXPANSION', 				7),
			('LEADER_SENSHI_LAWTILIWADLIN', 	'FLAVOR_GROWTH', 					5),
			('LEADER_SENSHI_LAWTILIWADLIN', 	'FLAVOR_TILE_IMPROVEMENT', 			3),
			('LEADER_SENSHI_LAWTILIWADLIN', 	'FLAVOR_INFRASTRUCTURE', 			3),
			('LEADER_SENSHI_LAWTILIWADLIN', 	'FLAVOR_PRODUCTION', 				7),
			('LEADER_SENSHI_LAWTILIWADLIN', 	'FLAVOR_GOLD', 						2),
			('LEADER_SENSHI_LAWTILIWADLIN', 	'FLAVOR_SCIENCE', 					4),
			('LEADER_SENSHI_LAWTILIWADLIN', 	'FLAVOR_CULTURE', 					3),
			('LEADER_SENSHI_LAWTILIWADLIN', 	'FLAVOR_HAPPINESS', 				5),
			('LEADER_SENSHI_LAWTILIWADLIN', 	'FLAVOR_GREAT_PEOPLE', 				4),
			('LEADER_SENSHI_LAWTILIWADLIN', 	'FLAVOR_WONDER', 					4),
			('LEADER_SENSHI_LAWTILIWADLIN', 	'FLAVOR_RELIGION', 					6),
			('LEADER_SENSHI_LAWTILIWADLIN', 	'FLAVOR_DIPLOMACY', 				2),
			('LEADER_SENSHI_LAWTILIWADLIN', 	'FLAVOR_SPACESHIP', 				3),
			('LEADER_SENSHI_LAWTILIWADLIN', 	'FLAVOR_WATER_CONNECTION', 			6),
			('LEADER_SENSHI_LAWTILIWADLIN', 	'FLAVOR_NUKE', 						6),
			('LEADER_SENSHI_LAWTILIWADLIN', 	'FLAVOR_USE_NUKE', 					5),
			('LEADER_SENSHI_LAWTILIWADLIN', 	'FLAVOR_ESPIONAGE', 				3),
			('LEADER_SENSHI_LAWTILIWADLIN', 	'FLAVOR_AIRLIFT', 					5),
			('LEADER_SENSHI_LAWTILIWADLIN', 	'FLAVOR_I_TRADE_DESTINATION', 		4),
			('LEADER_SENSHI_LAWTILIWADLIN', 	'FLAVOR_I_TRADE_ORIGIN', 			4),
			('LEADER_SENSHI_LAWTILIWADLIN', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		4),
			('LEADER_SENSHI_LAWTILIWADLIN', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		4),
			('LEADER_SENSHI_LAWTILIWADLIN', 	'FLAVOR_ARCHAEOLOGY', 				2),
			('LEADER_SENSHI_LAWTILIWADLIN', 	'FLAVOR_AIR_CARRIER', 				3);
--==========================================================================================================================	
-- Leader_Traits
--==========================================================================================================================						
INSERT INTO Leader_Traits 
			(LeaderType, 			TraitType)
VALUES		('LEADER_SENSHI_LAWTILIWADLIN', 	'TRAIT_SENSHI_CHUKCHI');
--==========================================================================================================================				
--==========================================================================================================================		