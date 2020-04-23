--==========================================================================================================================	
-- Leaders
--==========================================================================================================================			
INSERT INTO Leaders 
			(Type, 							Description, 						Civilopedia, 									CivilopediaTag, 								ArtDefineTag, 					VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 					PortraitIndex)
VALUES		('LEADER_SENSHI_NURHACI', 		'TXT_KEY_LEADER_SENSHI_NURHACI', 	'TXT_KEY_CIVILOPEDIA_LEADER_SENSHI_NURHACI', 	'TXT_KEY_CIVILOPEDIA_LEADERS_SENSHI_NURHACI', 					'Nurhaci_Scene.xml',		7, 						4, 						5, 							7, 			6, 				4, 				6, 						6, 				4, 			4, 			4, 				6, 			6, 			'SENSHI_MANCHU_ATLAS', 	1);
--==========================================================================================================================	
-- Leader_MajorCivApproachBiases
--==========================================================================================================================						
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 				MajorCivApproachType, 				Bias)
VALUES		('LEADER_SENSHI_NURHACI', 		'MAJOR_CIV_APPROACH_WAR', 			8),
			('LEADER_SENSHI_NURHACI', 		'MAJOR_CIV_APPROACH_HOSTILE', 		6),
			('LEADER_SENSHI_NURHACI', 		'MAJOR_CIV_APPROACH_DECEPTIVE', 	6),
			('LEADER_SENSHI_NURHACI', 		'MAJOR_CIV_APPROACH_GUARDED', 		6),
			('LEADER_SENSHI_NURHACI', 		'MAJOR_CIV_APPROACH_AFRAID', 		4),
			('LEADER_SENSHI_NURHACI', 		'MAJOR_CIV_APPROACH_FRIENDLY', 		6),
			('LEADER_SENSHI_NURHACI', 		'MAJOR_CIV_APPROACH_NEUTRAL', 		5);
--==========================================================================================================================	
-- Leader_MajorCivApproachBiases
--==========================================================================================================================						
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 			MinorCivApproachType, 				Bias)
VALUES		('LEADER_SENSHI_NURHACI', 	'MINOR_CIV_APPROACH_IGNORE', 		5),
			('LEADER_SENSHI_NURHACI', 	'MINOR_CIV_APPROACH_FRIENDLY', 		7),
			('LEADER_SENSHI_NURHACI', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	5),
			('LEADER_SENSHI_NURHACI', 	'MINOR_CIV_APPROACH_CONQUEST', 		6),
			('LEADER_SENSHI_NURHACI', 	'MINOR_CIV_APPROACH_BULLY', 		7);
--==========================================================================================================================	
-- Leader_Flavors
--==========================================================================================================================						
INSERT INTO Leader_Flavors 
			(LeaderType, 			FlavorType, 						Flavor)
VALUES		('LEADER_SENSHI_NURHACI', 	'FLAVOR_OFFENSE', 					8),
			('LEADER_SENSHI_NURHACI', 	'FLAVOR_DEFENSE', 					7),
			('LEADER_SENSHI_NURHACI', 	'FLAVOR_CITY_DEFENSE', 				6),
			('LEADER_SENSHI_NURHACI', 	'FLAVOR_MILITARY_TRAINING', 		8),
			('LEADER_SENSHI_NURHACI', 	'FLAVOR_RECON', 					5),
			('LEADER_SENSHI_NURHACI', 	'FLAVOR_RANGED', 					6),
			('LEADER_SENSHI_NURHACI', 	'FLAVOR_MOBILE', 					6),
			('LEADER_SENSHI_NURHACI', 	'FLAVOR_NAVAL', 					4),
			('LEADER_SENSHI_NURHACI', 	'FLAVOR_NAVAL_RECON', 				4),
			('LEADER_SENSHI_NURHACI', 	'FLAVOR_NAVAL_GROWTH', 				6),
			('LEADER_SENSHI_NURHACI', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
			('LEADER_SENSHI_NURHACI', 	'FLAVOR_AIR', 						7),
			('LEADER_SENSHI_NURHACI', 	'FLAVOR_EXPANSION', 				8),
			('LEADER_SENSHI_NURHACI', 	'FLAVOR_GROWTH', 					6),
			('LEADER_SENSHI_NURHACI', 	'FLAVOR_TILE_IMPROVEMENT', 			6),
			('LEADER_SENSHI_NURHACI', 	'FLAVOR_INFRASTRUCTURE', 			6),
			('LEADER_SENSHI_NURHACI', 	'FLAVOR_PRODUCTION', 				8),
			('LEADER_SENSHI_NURHACI', 	'FLAVOR_GOLD', 						7),
			('LEADER_SENSHI_NURHACI', 	'FLAVOR_SCIENCE', 					6),
			('LEADER_SENSHI_NURHACI', 	'FLAVOR_CULTURE', 					7),
			('LEADER_SENSHI_NURHACI', 	'FLAVOR_HAPPINESS', 				6),
			('LEADER_SENSHI_NURHACI', 	'FLAVOR_GREAT_PEOPLE', 				5),
			('LEADER_SENSHI_NURHACI', 	'FLAVOR_WONDER', 					4),
			('LEADER_SENSHI_NURHACI', 	'FLAVOR_RELIGION', 					4),
			('LEADER_SENSHI_NURHACI', 	'FLAVOR_DIPLOMACY', 				4),
			('LEADER_SENSHI_NURHACI', 	'FLAVOR_SPACESHIP', 				5),
			('LEADER_SENSHI_NURHACI', 	'FLAVOR_WATER_CONNECTION', 			4),
			('LEADER_SENSHI_NURHACI', 	'FLAVOR_NUKE', 						4),
			('LEADER_SENSHI_NURHACI', 	'FLAVOR_USE_NUKE', 					4),
			('LEADER_SENSHI_NURHACI', 	'FLAVOR_ESPIONAGE', 				6),
			('LEADER_SENSHI_NURHACI', 	'FLAVOR_AIRLIFT', 					5),
			('LEADER_SENSHI_NURHACI', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_SENSHI_NURHACI', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_SENSHI_NURHACI', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_SENSHI_NURHACI', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_SENSHI_NURHACI', 	'FLAVOR_ARCHAEOLOGY', 				6),
			('LEADER_SENSHI_NURHACI', 	'FLAVOR_AIR_CARRIER', 				4);
--==========================================================================================================================	
-- Leader_Traits
--==========================================================================================================================						
INSERT INTO Leader_Traits 
			(LeaderType, 			TraitType)
VALUES		('LEADER_SENSHI_NURHACI', 	'TRAIT_SENSHI_MANCHU');
--==========================================================================================================================				
--==========================================================================================================================		