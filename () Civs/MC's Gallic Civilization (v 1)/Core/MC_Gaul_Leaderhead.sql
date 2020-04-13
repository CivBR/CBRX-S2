--==========================================================================================================================	
-- Leaders
--==========================================================================================================================			
INSERT INTO Leaders 
			(Type, 							Description, 						Civilopedia, 								CivilopediaTag, 									ArtDefineTag, 				VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 				PortraitIndex)
VALUES		('LEADER_MC_VERCINGETORIX', 	'TXT_KEY_LEADER_MC_VERCINGETORIX', 	'TXT_KEY_LEADER_MC_VERCINGETORIX', 			'TXT_KEY_CIVILOPEDIA_LEADERS_MC_VERCINGETORIX', 	'Vercingetorix_Scene.xml',	7, 						3, 						6, 							8, 			6, 				5, 				5, 						6, 				6, 			4, 			5, 				6, 			6, 			'MC_GAUL_ATLAS', 		1);
--==========================================================================================================================	
-- Leader_MajorCivApproachBiases
--==========================================================================================================================						
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 					MajorCivApproachType, 				Bias)
VALUES		('LEADER_MC_VERCINGETORIX', 	'MAJOR_CIV_APPROACH_WAR', 			6),
			('LEADER_MC_VERCINGETORIX', 	'MAJOR_CIV_APPROACH_HOSTILE', 		5),
			('LEADER_MC_VERCINGETORIX', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	7),
			('LEADER_MC_VERCINGETORIX', 	'MAJOR_CIV_APPROACH_GUARDED', 		5),
			('LEADER_MC_VERCINGETORIX', 	'MAJOR_CIV_APPROACH_AFRAID', 		3),
			('LEADER_MC_VERCINGETORIX', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		5),
			('LEADER_MC_VERCINGETORIX', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		6);
--==========================================================================================================================	
-- Leader_MajorCivApproachBiases
--==========================================================================================================================						
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 					MinorCivApproachType, 				Bias)
VALUES		('LEADER_MC_VERCINGETORIX', 	'MINOR_CIV_APPROACH_IGNORE', 		4),
			('LEADER_MC_VERCINGETORIX', 	'MINOR_CIV_APPROACH_FRIENDLY', 		6),
			('LEADER_MC_VERCINGETORIX', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	6),
			('LEADER_MC_VERCINGETORIX', 	'MINOR_CIV_APPROACH_CONQUEST', 		5),
			('LEADER_MC_VERCINGETORIX', 	'MINOR_CIV_APPROACH_BULLY', 		7);
--==========================================================================================================================	
-- Leader_Flavors
--==========================================================================================================================						
INSERT INTO Leader_Flavors 
			(LeaderType, 					FlavorType, 						Flavor)
VALUES		('LEADER_MC_VERCINGETORIX', 	'FLAVOR_OFFENSE', 					7),
			('LEADER_MC_VERCINGETORIX', 	'FLAVOR_DEFENSE', 					6),
			('LEADER_MC_VERCINGETORIX', 	'FLAVOR_CITY_DEFENSE', 				7),
			('LEADER_MC_VERCINGETORIX', 	'FLAVOR_MILITARY_TRAINING', 		7),
			('LEADER_MC_VERCINGETORIX', 	'FLAVOR_RECON', 					4),
			('LEADER_MC_VERCINGETORIX', 	'FLAVOR_RANGED', 					5),
			('LEADER_MC_VERCINGETORIX', 	'FLAVOR_MOBILE', 					6),
			('LEADER_MC_VERCINGETORIX', 	'FLAVOR_NAVAL', 					4),
			('LEADER_MC_VERCINGETORIX', 	'FLAVOR_NAVAL_RECON', 				3),
			('LEADER_MC_VERCINGETORIX', 	'FLAVOR_NAVAL_GROWTH', 				4),
			('LEADER_MC_VERCINGETORIX', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	4),
			('LEADER_MC_VERCINGETORIX', 	'FLAVOR_AIR', 						6),
			('LEADER_MC_VERCINGETORIX', 	'FLAVOR_EXPANSION', 				7),
			('LEADER_MC_VERCINGETORIX', 	'FLAVOR_GROWTH', 					6),
			('LEADER_MC_VERCINGETORIX', 	'FLAVOR_TILE_IMPROVEMENT', 			7),
			('LEADER_MC_VERCINGETORIX', 	'FLAVOR_INFRASTRUCTURE', 			7),
			('LEADER_MC_VERCINGETORIX', 	'FLAVOR_PRODUCTION', 				8),
			('LEADER_MC_VERCINGETORIX', 	'FLAVOR_GOLD', 						8),
			('LEADER_MC_VERCINGETORIX', 	'FLAVOR_SCIENCE', 					4),
			('LEADER_MC_VERCINGETORIX', 	'FLAVOR_CULTURE', 					6),
			('LEADER_MC_VERCINGETORIX', 	'FLAVOR_HAPPINESS', 				6),
			('LEADER_MC_VERCINGETORIX', 	'FLAVOR_GREAT_PEOPLE', 				7),
			('LEADER_MC_VERCINGETORIX', 	'FLAVOR_WONDER', 					3),
			('LEADER_MC_VERCINGETORIX', 	'FLAVOR_RELIGION', 					7),
			('LEADER_MC_VERCINGETORIX', 	'FLAVOR_DIPLOMACY', 				5),
			('LEADER_MC_VERCINGETORIX', 	'FLAVOR_SPACESHIP', 				5),
			('LEADER_MC_VERCINGETORIX', 	'FLAVOR_WATER_CONNECTION', 			4),
			('LEADER_MC_VERCINGETORIX', 	'FLAVOR_NUKE', 						5),
			('LEADER_MC_VERCINGETORIX', 	'FLAVOR_USE_NUKE', 					5),
			('LEADER_MC_VERCINGETORIX', 	'FLAVOR_ESPIONAGE', 				8),
			('LEADER_MC_VERCINGETORIX', 	'FLAVOR_AIRLIFT', 					4),
			('LEADER_MC_VERCINGETORIX', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_MC_VERCINGETORIX', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_MC_VERCINGETORIX', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_MC_VERCINGETORIX', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_MC_VERCINGETORIX', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_MC_VERCINGETORIX', 	'FLAVOR_AIR_CARRIER', 				5);
--------------------------------    
-- Piety and Prestige Support
--------------------------------            
INSERT OR REPLACE INTO Flavors 
            (Type)
VALUES      ('FLAVOR_JFD_RELIGIOUS_INTOLERANCE');
 
INSERT INTO Leader_Flavors
            (LeaderType,           				FlavorType,                           	Flavor)
VALUES      ('LEADER_MC_VERCINGETORIX',    		'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',     4);
--==========================================================================================================================	
-- Leader_Traits
--==========================================================================================================================						
INSERT INTO Leader_Traits 
			(LeaderType, 					TraitType)
VALUES		('LEADER_MC_VERCINGETORIX', 	'TRAIT_MC_GAUL');
--==========================================================================================================================				
--==========================================================================================================================