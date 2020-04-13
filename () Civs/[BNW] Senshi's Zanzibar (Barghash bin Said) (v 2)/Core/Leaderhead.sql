--==========================================================================================================================	
-- Leaders
--==========================================================================================================================			
INSERT INTO Leaders 
			(Type, 							Description, 						Civilopedia, 									CivilopediaTag, 								ArtDefineTag, 					VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 					PortraitIndex)
VALUES		('LEADER_SENSHI_BARGHASH', 		'TXT_KEY_LEADER_SENSHI_BARGHASH', 	'TXT_KEY_CIVILOPEDIA_LEADER_SENSHI_BARGHASH', 	'TXT_KEY_CIVILOPEDIA_LEADERS_SENSHI_BARGHASH', 	'Senshi_Barghash_Scene.xml',		6, 						4, 						8, 							7, 			5, 				3, 				4, 						6, 				2, 			7, 			4, 				5, 			7, 			'SENSHI_ZANZIBAR_ATLAS',		1);
--==========================================================================================================================	
-- Leader_MajorCivApproachBiases
--==========================================================================================================================						
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 				MajorCivApproachType, 				Bias)
VALUES		('LEADER_SENSHI_BARGHASH', 		'MAJOR_CIV_APPROACH_WAR', 			6),
			('LEADER_SENSHI_BARGHASH', 		'MAJOR_CIV_APPROACH_HOSTILE', 		3),
			('LEADER_SENSHI_BARGHASH', 		'MAJOR_CIV_APPROACH_DECEPTIVE', 	8),
			('LEADER_SENSHI_BARGHASH', 		'MAJOR_CIV_APPROACH_GUARDED', 		4),
			('LEADER_SENSHI_BARGHASH', 		'MAJOR_CIV_APPROACH_AFRAID', 		6),
			('LEADER_SENSHI_BARGHASH', 		'MAJOR_CIV_APPROACH_FRIENDLY', 		7),
			('LEADER_SENSHI_BARGHASH', 		'MAJOR_CIV_APPROACH_NEUTRAL', 		3);
--==========================================================================================================================	
-- Leader_MajorCivApproachBiases
--==========================================================================================================================						
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 			MinorCivApproachType, 				Bias)
VALUES		('LEADER_SENSHI_BARGHASH', 	'MINOR_CIV_APPROACH_IGNORE', 		2),
			('LEADER_SENSHI_BARGHASH', 	'MINOR_CIV_APPROACH_FRIENDLY', 		7),
			('LEADER_SENSHI_BARGHASH', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	5),
			('LEADER_SENSHI_BARGHASH', 	'MINOR_CIV_APPROACH_CONQUEST', 		2),
			('LEADER_SENSHI_BARGHASH', 	'MINOR_CIV_APPROACH_BULLY', 		7);
--==========================================================================================================================	
-- Leader_Flavors
--==========================================================================================================================						
INSERT INTO Leader_Flavors 
			(LeaderType, 			FlavorType, 						Flavor)
VALUES		('LEADER_SENSHI_BARGHASH', 	'FLAVOR_OFFENSE', 					7),
			('LEADER_SENSHI_BARGHASH', 	'FLAVOR_DEFENSE', 					4),
			('LEADER_SENSHI_BARGHASH', 	'FLAVOR_CITY_DEFENSE', 				4),
			('LEADER_SENSHI_BARGHASH', 	'FLAVOR_MILITARY_TRAINING', 		4),
			('LEADER_SENSHI_BARGHASH', 	'FLAVOR_RECON', 					3),
			('LEADER_SENSHI_BARGHASH', 	'FLAVOR_RANGED', 					4),
			('LEADER_SENSHI_BARGHASH', 	'FLAVOR_MOBILE', 					4),
			('LEADER_SENSHI_BARGHASH', 	'FLAVOR_NAVAL', 					8),
			('LEADER_SENSHI_BARGHASH', 	'FLAVOR_NAVAL_RECON', 				7),
			('LEADER_SENSHI_BARGHASH', 	'FLAVOR_NAVAL_GROWTH', 				5),
			('LEADER_SENSHI_BARGHASH', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
			('LEADER_SENSHI_BARGHASH', 	'FLAVOR_AIR', 						6),
			('LEADER_SENSHI_BARGHASH', 	'FLAVOR_EXPANSION', 				5),
			('LEADER_SENSHI_BARGHASH', 	'FLAVOR_GROWTH', 					7),
			('LEADER_SENSHI_BARGHASH', 	'FLAVOR_TILE_IMPROVEMENT', 			7),
			('LEADER_SENSHI_BARGHASH', 	'FLAVOR_INFRASTRUCTURE', 			6),
			('LEADER_SENSHI_BARGHASH', 	'FLAVOR_PRODUCTION', 				8),
			('LEADER_SENSHI_BARGHASH', 	'FLAVOR_GOLD', 						12),
			('LEADER_SENSHI_BARGHASH', 	'FLAVOR_SCIENCE', 					8),
			('LEADER_SENSHI_BARGHASH', 	'FLAVOR_CULTURE', 					5),
			('LEADER_SENSHI_BARGHASH', 	'FLAVOR_HAPPINESS', 				4),
			('LEADER_SENSHI_BARGHASH', 	'FLAVOR_GREAT_PEOPLE', 				3),
			('LEADER_SENSHI_BARGHASH', 	'FLAVOR_WONDER', 					5),
			('LEADER_SENSHI_BARGHASH', 	'FLAVOR_RELIGION', 					2),
			('LEADER_SENSHI_BARGHASH', 	'FLAVOR_DIPLOMACY', 				8),
			('LEADER_SENSHI_BARGHASH', 	'FLAVOR_SPACESHIP', 				4),
			('LEADER_SENSHI_BARGHASH', 	'FLAVOR_WATER_CONNECTION', 			9),
			('LEADER_SENSHI_BARGHASH', 	'FLAVOR_NUKE', 						7),
			('LEADER_SENSHI_BARGHASH', 	'FLAVOR_USE_NUKE', 					4),
			('LEADER_SENSHI_BARGHASH', 	'FLAVOR_ESPIONAGE', 				9),
			('LEADER_SENSHI_BARGHASH', 	'FLAVOR_AIRLIFT', 					3),
			('LEADER_SENSHI_BARGHASH', 	'FLAVOR_I_TRADE_DESTINATION', 		9),
			('LEADER_SENSHI_BARGHASH', 	'FLAVOR_I_TRADE_ORIGIN', 			9),
			('LEADER_SENSHI_BARGHASH', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		8),
			('LEADER_SENSHI_BARGHASH', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_SENSHI_BARGHASH', 	'FLAVOR_ARCHAEOLOGY', 				3),
			('LEADER_SENSHI_BARGHASH', 	'FLAVOR_AIR_CARRIER', 				3);
--==========================================================================================================================	
-- Leader_Traits
--==========================================================================================================================						
INSERT INTO Leader_Traits 
			(LeaderType, 			TraitType)
VALUES		('LEADER_SENSHI_BARGHASH', 	'TRAIT_SENSHI_ZANZIBAR');
--==========================================================================================================================				
--==========================================================================================================================		