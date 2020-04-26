--==========================================================================================================================	
-- Leaders
--==========================================================================================================================			
INSERT INTO Leaders 
			(Type, 							Description, 						Civilopedia, 									CivilopediaTag, 								ArtDefineTag, 					VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 					PortraitIndex)
VALUES		('LEADER_SENSHI_MARAJO', 		'TXT_KEY_LEADER_SENSHI_MARAJO', 	'TXT_KEY_CIVILOPEDIA_LEADER_SENSHI_MARAJO', 	'TXT_KEY_CIVILOPEDIA_LEADERS_SENSHI_MARAJO', 	'Senshi_Marajo_Scene.xml',		4, 						6, 						3, 							7, 			6, 				4, 				6, 						6, 				5, 			8, 			6, 				4, 			6, 			'SENSHI_MARAJO_ATLAS',		1);
--==========================================================================================================================	
-- Leader_MajorCivApproachBiases
--==========================================================================================================================						
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 				MajorCivApproachType, 				Bias)
VALUES		('LEADER_SENSHI_MARAJO', 		'MAJOR_CIV_APPROACH_WAR', 			6),
			('LEADER_SENSHI_MARAJO', 		'MAJOR_CIV_APPROACH_HOSTILE', 		5),
			('LEADER_SENSHI_MARAJO', 		'MAJOR_CIV_APPROACH_DECEPTIVE', 	3),
			('LEADER_SENSHI_MARAJO', 		'MAJOR_CIV_APPROACH_GUARDED', 		6),
			('LEADER_SENSHI_MARAJO', 		'MAJOR_CIV_APPROACH_AFRAID', 		3),
			('LEADER_SENSHI_MARAJO', 		'MAJOR_CIV_APPROACH_FRIENDLY', 		5),
			('LEADER_SENSHI_MARAJO', 		'MAJOR_CIV_APPROACH_NEUTRAL', 		6);
--==========================================================================================================================	
-- Leader_MajorCivApproachBiases
--==========================================================================================================================						
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 			MinorCivApproachType, 				Bias)
VALUES		('LEADER_SENSHI_MARAJO', 	'MINOR_CIV_APPROACH_IGNORE', 		5),
			('LEADER_SENSHI_MARAJO', 	'MINOR_CIV_APPROACH_FRIENDLY', 		4),
			('LEADER_SENSHI_MARAJO', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	3),
			('LEADER_SENSHI_MARAJO', 	'MINOR_CIV_APPROACH_CONQUEST', 		7),
			('LEADER_SENSHI_MARAJO', 	'MINOR_CIV_APPROACH_BULLY', 		7);
--==========================================================================================================================	
-- Leader_Flavors
--==========================================================================================================================						
INSERT INTO Leader_Flavors 
			(LeaderType, 			FlavorType, 						Flavor)
VALUES		('LEADER_SENSHI_MARAJO', 	'FLAVOR_OFFENSE', 					6),
			('LEADER_SENSHI_MARAJO', 	'FLAVOR_DEFENSE', 					8),
			('LEADER_SENSHI_MARAJO', 	'FLAVOR_CITY_DEFENSE', 				5),
			('LEADER_SENSHI_MARAJO', 	'FLAVOR_MILITARY_TRAINING', 		5),
			('LEADER_SENSHI_MARAJO', 	'FLAVOR_RECON', 					4),
			('LEADER_SENSHI_MARAJO', 	'FLAVOR_RANGED', 					9),
			('LEADER_SENSHI_MARAJO', 	'FLAVOR_MOBILE', 					3),
			('LEADER_SENSHI_MARAJO', 	'FLAVOR_NAVAL', 					7),
			('LEADER_SENSHI_MARAJO', 	'FLAVOR_NAVAL_RECON', 				5),
			('LEADER_SENSHI_MARAJO', 	'FLAVOR_NAVAL_GROWTH', 				7),
			('LEADER_SENSHI_MARAJO', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
			('LEADER_SENSHI_MARAJO', 	'FLAVOR_AIR', 						4),
			('LEADER_SENSHI_MARAJO', 	'FLAVOR_EXPANSION', 				7),
			('LEADER_SENSHI_MARAJO', 	'FLAVOR_GROWTH', 					8),
			('LEADER_SENSHI_MARAJO', 	'FLAVOR_TILE_IMPROVEMENT', 			6),
			('LEADER_SENSHI_MARAJO', 	'FLAVOR_INFRASTRUCTURE', 			8),
			('LEADER_SENSHI_MARAJO', 	'FLAVOR_PRODUCTION', 				6),
			('LEADER_SENSHI_MARAJO', 	'FLAVOR_GOLD', 						3),
			('LEADER_SENSHI_MARAJO', 	'FLAVOR_SCIENCE', 					5),
			('LEADER_SENSHI_MARAJO', 	'FLAVOR_CULTURE', 					6),
			('LEADER_SENSHI_MARAJO', 	'FLAVOR_HAPPINESS', 				4),
			('LEADER_SENSHI_MARAJO', 	'FLAVOR_GREAT_PEOPLE', 				5),
			('LEADER_SENSHI_MARAJO', 	'FLAVOR_WONDER', 					7),
			('LEADER_SENSHI_MARAJO', 	'FLAVOR_RELIGION', 					7),
			('LEADER_SENSHI_MARAJO', 	'FLAVOR_DIPLOMACY', 				3),
			('LEADER_SENSHI_MARAJO', 	'FLAVOR_SPACESHIP', 				2),
			('LEADER_SENSHI_MARAJO', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_SENSHI_MARAJO', 	'FLAVOR_NUKE', 						3),
			('LEADER_SENSHI_MARAJO', 	'FLAVOR_USE_NUKE', 					8),
			('LEADER_SENSHI_MARAJO', 	'FLAVOR_ESPIONAGE', 				5),
			('LEADER_SENSHI_MARAJO', 	'FLAVOR_AIRLIFT', 					3),
			('LEADER_SENSHI_MARAJO', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_SENSHI_MARAJO', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_SENSHI_MARAJO', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_SENSHI_MARAJO', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_SENSHI_MARAJO', 	'FLAVOR_ARCHAEOLOGY', 				3),
			('LEADER_SENSHI_MARAJO', 	'FLAVOR_AIR_CARRIER', 				3);
--==========================================================================================================================	
-- Leader_Traits
--==========================================================================================================================						
INSERT INTO Leader_Traits 
			(LeaderType, 			TraitType)
VALUES		('LEADER_SENSHI_MARAJO', 	'TRAIT_SENSHI_MARAJO');
--==========================================================================================================================				
--==========================================================================================================================		