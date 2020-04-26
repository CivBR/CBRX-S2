--==========================================================================================================================	
-- Leaders
--==========================================================================================================================			
INSERT INTO Leaders 
			(Type, 							Description, 						Civilopedia, 									CivilopediaTag, 								ArtDefineTag, 					VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 					PortraitIndex)
VALUES		('LEADER_SENSHI_SANTACRUZ', 		'TXT_KEY_LEADER_SENSHI_SANTACRUZ', 	'TXT_KEY_CIVILOPEDIA_LEADER_SENSHI_SANTACRUZ', 	'TXT_KEY_CIVILOPEDIA_LEADERS_SENSHI_SANTACRUZ', 	'Senshi_SantaCruz_Scene.xml',		7, 						3, 						7, 							8, 			7, 				4, 				6, 						7, 				4, 			5, 			3, 				5, 			5, 			'SENSHI_PERUBOLIVIA_ATLAS',		1);
--==========================================================================================================================	
-- Leader_MajorCivApproachBiases
--==========================================================================================================================						
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 				MajorCivApproachType, 				Bias)
VALUES		('LEADER_SENSHI_SANTACRUZ', 		'MAJOR_CIV_APPROACH_WAR', 			6),
			('LEADER_SENSHI_SANTACRUZ', 		'MAJOR_CIV_APPROACH_HOSTILE', 		4),
			('LEADER_SENSHI_SANTACRUZ', 		'MAJOR_CIV_APPROACH_DECEPTIVE', 	7),
			('LEADER_SENSHI_SANTACRUZ', 		'MAJOR_CIV_APPROACH_GUARDED', 		9),
			('LEADER_SENSHI_SANTACRUZ', 		'MAJOR_CIV_APPROACH_AFRAID', 		4),
			('LEADER_SENSHI_SANTACRUZ', 		'MAJOR_CIV_APPROACH_FRIENDLY', 		6),
			('LEADER_SENSHI_SANTACRUZ', 		'MAJOR_CIV_APPROACH_NEUTRAL', 		6);
--==========================================================================================================================	
-- Leader_MajorCivApproachBiases
--==========================================================================================================================						
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 			MinorCivApproachType, 				Bias)
VALUES		('LEADER_SENSHI_SANTACRUZ', 	'MINOR_CIV_APPROACH_IGNORE', 		3),
			('LEADER_SENSHI_SANTACRUZ', 	'MINOR_CIV_APPROACH_FRIENDLY', 		8),
			('LEADER_SENSHI_SANTACRUZ', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	8),
			('LEADER_SENSHI_SANTACRUZ', 	'MINOR_CIV_APPROACH_CONQUEST', 		2),
			('LEADER_SENSHI_SANTACRUZ', 	'MINOR_CIV_APPROACH_BULLY', 		6);
--==========================================================================================================================	
-- Leader_Flavors
--==========================================================================================================================						
INSERT INTO Leader_Flavors 
			(LeaderType, 			FlavorType, 						Flavor)
VALUES		('LEADER_SENSHI_SANTACRUZ', 	'FLAVOR_OFFENSE', 					8),
			('LEADER_SENSHI_SANTACRUZ', 	'FLAVOR_DEFENSE', 					6),
			('LEADER_SENSHI_SANTACRUZ', 	'FLAVOR_CITY_DEFENSE', 				4),
			('LEADER_SENSHI_SANTACRUZ', 	'FLAVOR_MILITARY_TRAINING', 		6),
			('LEADER_SENSHI_SANTACRUZ', 	'FLAVOR_RECON', 					4),
			('LEADER_SENSHI_SANTACRUZ', 	'FLAVOR_RANGED', 					7),
			('LEADER_SENSHI_SANTACRUZ', 	'FLAVOR_MOBILE', 					6),
			('LEADER_SENSHI_SANTACRUZ', 	'FLAVOR_NAVAL', 					7),
			('LEADER_SENSHI_SANTACRUZ', 	'FLAVOR_NAVAL_RECON', 				4),
			('LEADER_SENSHI_SANTACRUZ', 	'FLAVOR_NAVAL_GROWTH', 				9),
			('LEADER_SENSHI_SANTACRUZ', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	4),
			('LEADER_SENSHI_SANTACRUZ', 	'FLAVOR_AIR', 						7),
			('LEADER_SENSHI_SANTACRUZ', 	'FLAVOR_EXPANSION', 				8),
			('LEADER_SENSHI_SANTACRUZ', 	'FLAVOR_GROWTH', 					5),
			('LEADER_SENSHI_SANTACRUZ', 	'FLAVOR_TILE_IMPROVEMENT', 			6),
			('LEADER_SENSHI_SANTACRUZ', 	'FLAVOR_INFRASTRUCTURE', 			6),
			('LEADER_SENSHI_SANTACRUZ', 	'FLAVOR_PRODUCTION', 				8),
			('LEADER_SENSHI_SANTACRUZ', 	'FLAVOR_GOLD', 						6),
			('LEADER_SENSHI_SANTACRUZ', 	'FLAVOR_SCIENCE', 					7),
			('LEADER_SENSHI_SANTACRUZ', 	'FLAVOR_CULTURE', 					4),
			('LEADER_SENSHI_SANTACRUZ', 	'FLAVOR_HAPPINESS', 				4),
			('LEADER_SENSHI_SANTACRUZ', 	'FLAVOR_GREAT_PEOPLE', 				4),
			('LEADER_SENSHI_SANTACRUZ', 	'FLAVOR_WONDER', 					4),
			('LEADER_SENSHI_SANTACRUZ', 	'FLAVOR_RELIGION', 					3),
			('LEADER_SENSHI_SANTACRUZ', 	'FLAVOR_DIPLOMACY', 				5),
			('LEADER_SENSHI_SANTACRUZ', 	'FLAVOR_SPACESHIP', 				4),
			('LEADER_SENSHI_SANTACRUZ', 	'FLAVOR_WATER_CONNECTION', 			9),
			('LEADER_SENSHI_SANTACRUZ', 	'FLAVOR_NUKE', 						5),
			('LEADER_SENSHI_SANTACRUZ', 	'FLAVOR_USE_NUKE', 					8),
			('LEADER_SENSHI_SANTACRUZ', 	'FLAVOR_ESPIONAGE', 				8),
			('LEADER_SENSHI_SANTACRUZ', 	'FLAVOR_AIRLIFT', 					6),
			('LEADER_SENSHI_SANTACRUZ', 	'FLAVOR_I_TRADE_DESTINATION', 		8),
			('LEADER_SENSHI_SANTACRUZ', 	'FLAVOR_I_TRADE_ORIGIN', 			8),
			('LEADER_SENSHI_SANTACRUZ', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		8),
			('LEADER_SENSHI_SANTACRUZ', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		8),
			('LEADER_SENSHI_SANTACRUZ', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_SENSHI_SANTACRUZ', 	'FLAVOR_AIR_CARRIER', 				3);
--==========================================================================================================================	
-- Leader_Traits
--==========================================================================================================================						
INSERT INTO Leader_Traits 
			(LeaderType, 			TraitType)
VALUES		('LEADER_SENSHI_SANTACRUZ', 	'TRAIT_SENSHI_PERUBOLIVIA');
--==========================================================================================================================				
--==========================================================================================================================		