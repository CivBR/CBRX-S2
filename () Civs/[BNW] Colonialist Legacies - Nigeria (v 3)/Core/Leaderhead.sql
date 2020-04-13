--==========================================================================================================================	
-- Leaders
--==========================================================================================================================			
INSERT INTO Leaders 
			(Type, 							Description, 						Civilopedia, 									CivilopediaTag, 								ArtDefineTag, 						VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 					PortraitIndex)
VALUES		('LEADER_CL_AWOLOWO', 		'TXT_KEY_LEADER_CL_AWOLOWO', 	'TXT_KEY_CIVILOPEDIA_LEADER_CL_AWOLOWO', 	'TXT_KEY_CIVILOPEDIA_LEADERS_CL_AWOLOWO', 	'Awolowo_Scene.xml',								3, 						4, 						4, 							5, 			7, 				6, 				4, 						7, 				7, 			3, 			6, 				7, 			3, 			'CL_NIGERIA_ATLAS', 	1);
--==========================================================================================================================	
-- Leader_MajorCivApproachBiases
--==========================================================================================================================						
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 				MajorCivApproachType, 				Bias)
VALUES		('LEADER_CL_AWOLOWO', 		'MAJOR_CIV_APPROACH_WAR', 			2),
			('LEADER_CL_AWOLOWO', 		'MAJOR_CIV_APPROACH_HOSTILE', 		3),
			('LEADER_CL_AWOLOWO', 		'MAJOR_CIV_APPROACH_DECEPTIVE', 	4),
			('LEADER_CL_AWOLOWO', 		'MAJOR_CIV_APPROACH_GUARDED', 		3),
			('LEADER_CL_AWOLOWO', 		'MAJOR_CIV_APPROACH_AFRAID', 		5),
			('LEADER_CL_AWOLOWO', 		'MAJOR_CIV_APPROACH_FRIENDLY', 		9),
			('LEADER_CL_AWOLOWO', 		'MAJOR_CIV_APPROACH_NEUTRAL', 		4);
--==========================================================================================================================	
-- Leader_MajorCivApproachBiases
--==========================================================================================================================						
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 			MinorCivApproachType, 				Bias)
VALUES		('LEADER_CL_AWOLOWO', 	'MINOR_CIV_APPROACH_IGNORE', 		5),
			('LEADER_CL_AWOLOWO', 	'MINOR_CIV_APPROACH_FRIENDLY', 		7),
			('LEADER_CL_AWOLOWO', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	4),
			('LEADER_CL_AWOLOWO', 	'MINOR_CIV_APPROACH_CONQUEST', 		2),
			('LEADER_CL_AWOLOWO', 	'MINOR_CIV_APPROACH_BULLY', 		2);
--==========================================================================================================================	
-- Leader_Flavors
--==========================================================================================================================						
INSERT INTO Leader_Flavors 
			(LeaderType, 			FlavorType, 						Flavor)
VALUES		('LEADER_CL_AWOLOWO', 	'FLAVOR_OFFENSE', 					4),
			('LEADER_CL_AWOLOWO', 	'FLAVOR_DEFENSE', 					5),
			('LEADER_CL_AWOLOWO', 	'FLAVOR_CITY_DEFENSE', 				7),
			('LEADER_CL_AWOLOWO', 	'FLAVOR_MILITARY_TRAINING', 		5),
			('LEADER_CL_AWOLOWO', 	'FLAVOR_RECON', 					5),
			('LEADER_CL_AWOLOWO', 	'FLAVOR_RANGED', 					4),
			('LEADER_CL_AWOLOWO', 	'FLAVOR_MOBILE', 					7),
			('LEADER_CL_AWOLOWO', 	'FLAVOR_NAVAL', 					4),
			('LEADER_CL_AWOLOWO', 	'FLAVOR_NAVAL_RECON', 				4),
			('LEADER_CL_AWOLOWO', 	'FLAVOR_NAVAL_GROWTH', 				7),
			('LEADER_CL_AWOLOWO', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	4),
			('LEADER_CL_AWOLOWO', 	'FLAVOR_AIR', 						8),
			('LEADER_CL_AWOLOWO', 	'FLAVOR_EXPANSION', 				7),
			('LEADER_CL_AWOLOWO', 	'FLAVOR_GROWTH', 					10),
			('LEADER_CL_AWOLOWO', 	'FLAVOR_TILE_IMPROVEMENT', 			6),
			('LEADER_CL_AWOLOWO', 	'FLAVOR_INFRASTRUCTURE', 			8),
			('LEADER_CL_AWOLOWO', 	'FLAVOR_PRODUCTION', 				5),
			('LEADER_CL_AWOLOWO', 	'FLAVOR_GOLD', 						4),
			('LEADER_CL_AWOLOWO', 	'FLAVOR_SCIENCE', 					9),
			('LEADER_CL_AWOLOWO', 	'FLAVOR_CULTURE', 					6),
			('LEADER_CL_AWOLOWO', 	'FLAVOR_HAPPINESS', 				8),
			('LEADER_CL_AWOLOWO', 	'FLAVOR_GREAT_PEOPLE', 				7),
			('LEADER_CL_AWOLOWO', 	'FLAVOR_WONDER', 					4),
			('LEADER_CL_AWOLOWO', 	'FLAVOR_RELIGION', 					7),
			('LEADER_CL_AWOLOWO', 	'FLAVOR_DIPLOMACY', 				9),
			('LEADER_CL_AWOLOWO', 	'FLAVOR_SPACESHIP', 				8),
			('LEADER_CL_AWOLOWO', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_CL_AWOLOWO', 	'FLAVOR_NUKE', 						2),
			('LEADER_CL_AWOLOWO', 	'FLAVOR_USE_NUKE', 					2),
			('LEADER_CL_AWOLOWO', 	'FLAVOR_ESPIONAGE', 				4),
			('LEADER_CL_AWOLOWO', 	'FLAVOR_AIRLIFT', 					6),
			('LEADER_CL_AWOLOWO', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_CL_AWOLOWO', 	'FLAVOR_I_TRADE_ORIGIN', 			6),
			('LEADER_CL_AWOLOWO', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		4),
			('LEADER_CL_AWOLOWO', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		7),
			('LEADER_CL_AWOLOWO', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_CL_AWOLOWO', 	'FLAVOR_AIR_CARRIER', 				7);
--==========================================================================================================================	
-- Leader_Traits
--==========================================================================================================================						
INSERT INTO Leader_Traits 
			(LeaderType, 			TraitType)
VALUES		('LEADER_CL_AWOLOWO', 	'TRAIT_CL_NIGERIA');
--==========================================================================================================================				
--==========================================================================================================================		