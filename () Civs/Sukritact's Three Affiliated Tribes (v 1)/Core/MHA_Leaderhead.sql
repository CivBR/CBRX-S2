--==========================================================================================================================	
-- Leaders
--==========================================================================================================================			
INSERT INTO Leaders 
			(Type, 							Description, 							Civilopedia, 								CivilopediaTag, 									ArtDefineTag, 				VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 			PortraitIndex)
VALUES		('LEADER_MC_FOURBEARS', 		'TXT_KEY_LEADER_MC_FOURBEARS', 		'TXT_KEY_LEADER_MC_FOURBEARS_PEDIA', 		'TXT_KEY_CIVILOPEDIA_LEADERS_MC_FOURBEARS', 			'MC_FourBears_Scene.xml',	4, 						9, 						3, 							5, 			8, 				5, 				4, 						7, 				9, 			5, 			6, 				4, 			4, 				'MC_MHA_ATLAS', 	1);
--==========================================================================================================================	
-- Leader_MajorCivApproachBiases
--==========================================================================================================================						
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 					MajorCivApproachType, 				Bias)
VALUES		('LEADER_MC_FOURBEARS', 		'MAJOR_CIV_APPROACH_WAR', 			3),
			('LEADER_MC_FOURBEARS', 		'MAJOR_CIV_APPROACH_HOSTILE', 		3),
			('LEADER_MC_FOURBEARS', 		'MAJOR_CIV_APPROACH_DECEPTIVE', 	1),
			('LEADER_MC_FOURBEARS', 		'MAJOR_CIV_APPROACH_GUARDED', 		7),
			('LEADER_MC_FOURBEARS', 		'MAJOR_CIV_APPROACH_AFRAID', 		3),
			('LEADER_MC_FOURBEARS', 		'MAJOR_CIV_APPROACH_FRIENDLY', 		7),
			('LEADER_MC_FOURBEARS', 		'MAJOR_CIV_APPROACH_NEUTRAL', 		5);
--==========================================================================================================================	
-- Leader_MajorCivApproachBiases
--==========================================================================================================================						
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 					MinorCivApproachType, 				Bias)
VALUES		('LEADER_MC_FOURBEARS', 		'MINOR_CIV_APPROACH_IGNORE', 		3),
			('LEADER_MC_FOURBEARS', 		'MINOR_CIV_APPROACH_FRIENDLY', 		6),
			('LEADER_MC_FOURBEARS', 		'MINOR_CIV_APPROACH_PROTECTIVE', 	6),
			('LEADER_MC_FOURBEARS', 		'MINOR_CIV_APPROACH_CONQUEST', 		3),
			('LEADER_MC_FOURBEARS', 		'MINOR_CIV_APPROACH_BULLY', 		3);
--==========================================================================================================================	
-- Leader_Flavors
--==========================================================================================================================						
INSERT INTO Leader_Flavors 
			(LeaderType, 					FlavorType, 						Flavor)
VALUES		('LEADER_MC_FOURBEARS', 		'FLAVOR_OFFENSE', 					4),
			('LEADER_MC_FOURBEARS', 		'FLAVOR_DEFENSE', 					4),
			('LEADER_MC_FOURBEARS', 		'FLAVOR_CITY_DEFENSE', 				5),
			('LEADER_MC_FOURBEARS', 		'FLAVOR_MILITARY_TRAINING', 		4),
			('LEADER_MC_FOURBEARS', 		'FLAVOR_RECON', 					4),
			('LEADER_MC_FOURBEARS', 		'FLAVOR_RANGED', 					4),
			('LEADER_MC_FOURBEARS', 		'FLAVOR_MOBILE', 					4),
			('LEADER_MC_FOURBEARS', 		'FLAVOR_NAVAL', 					4),
			('LEADER_MC_FOURBEARS', 		'FLAVOR_NAVAL_RECON', 				4),
			('LEADER_MC_FOURBEARS', 		'FLAVOR_NAVAL_GROWTH', 				4),
			('LEADER_MC_FOURBEARS', 		'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
			('LEADER_MC_FOURBEARS', 		'FLAVOR_AIR', 						4),
			('LEADER_MC_FOURBEARS', 		'FLAVOR_EXPANSION', 				6),
			('LEADER_MC_FOURBEARS', 		'FLAVOR_GROWTH', 					9),
			('LEADER_MC_FOURBEARS', 		'FLAVOR_TILE_IMPROVEMENT', 			9),
			('LEADER_MC_FOURBEARS', 		'FLAVOR_INFRASTRUCTURE', 			5),
			('LEADER_MC_FOURBEARS', 		'FLAVOR_PRODUCTION', 				5),
			('LEADER_MC_FOURBEARS', 		'FLAVOR_GOLD', 						7),
			('LEADER_MC_FOURBEARS', 		'FLAVOR_SCIENCE', 					5),
			('LEADER_MC_FOURBEARS', 		'FLAVOR_CULTURE', 					6),
			('LEADER_MC_FOURBEARS', 		'FLAVOR_HAPPINESS', 				7),
			('LEADER_MC_FOURBEARS', 		'FLAVOR_GREAT_PEOPLE', 				6),
			('LEADER_MC_FOURBEARS', 		'FLAVOR_WONDER', 					6),
			('LEADER_MC_FOURBEARS', 		'FLAVOR_RELIGION', 					7),
			('LEADER_MC_FOURBEARS', 		'FLAVOR_DIPLOMACY', 				5),
			('LEADER_MC_FOURBEARS', 		'FLAVOR_SPACESHIP', 				5),
			('LEADER_MC_FOURBEARS', 		'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_MC_FOURBEARS', 		'FLAVOR_NUKE', 						2),
			('LEADER_MC_FOURBEARS', 		'FLAVOR_USE_NUKE', 					2),
			('LEADER_MC_FOURBEARS', 		'FLAVOR_ESPIONAGE', 				3),
			('LEADER_MC_FOURBEARS', 		'FLAVOR_AIRLIFT', 					2),
			('LEADER_MC_FOURBEARS', 		'FLAVOR_I_TRADE_DESTINATION', 		7),
			('LEADER_MC_FOURBEARS', 		'FLAVOR_I_TRADE_ORIGIN', 			7),
			('LEADER_MC_FOURBEARS', 		'FLAVOR_I_SEA_TRADE_ROUTE', 		7),
			('LEADER_MC_FOURBEARS', 		'FLAVOR_I_LAND_TRADE_ROUTE', 		7),
			('LEADER_MC_FOURBEARS', 		'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_MC_FOURBEARS', 		'FLAVOR_AIR_CARRIER', 				5);
--==========================================================================================================================	
-- Leader_Traits
--==========================================================================================================================	
INSERT INTO Leader_Traits 
			(LeaderType, 					TraitType)
VALUES		('LEADER_MC_FOURBEARS', 		'TRAIT_BUFFALO_BIRD_WOMANS_GARDEN');
--==========================================================================================================================	
-- Traits
--==========================================================================================================================	
INSERT INTO Traits 
			(Type, 									Description, 									ShortDescription)
VALUES		('TRAIT_BUFFALO_BIRD_WOMANS_GARDEN', 	'TXT_KEY_TRAIT_BUFFALO_BIRD_WOMANS_GARDEN', 	'TXT_KEY_TRAIT_BUFFALO_BIRD_WOMANS_GARDEN_SHORT');
--==========================================================================================================================	
--==========================================================================================================================	