--==========================================================================================================================
-- Leaders
--==========================================================================================================================		
INSERT INTO Leaders 
			(Type, 					Description, 					Civilopedia, 							CivilopediaTag, 							ArtDefineTag, 			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 				PortraitIndex)
VALUES		('LEADER_MC_COMCOMLY', 	'TXT_KEY_LEADER_MC_COMCOMLY', 	'TXT_KEY_LEADER_MC_COMCOMLY_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_MC_COMCOMLY', 	'Comcomly_Scene.xml',	6, 						3, 						4, 							7, 			5, 				2, 				3, 						4, 				4, 			3, 			5, 				2, 			4, 			'MC_CHINOOK_ATLAS',		1);
--==========================================================================================================================
-- Leader_MajorCivApproachBiases
--==========================================================================================================================					
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 			MajorCivApproachType, 				Bias)
VALUES		('LEADER_MC_COMCOMLY', 	'MAJOR_CIV_APPROACH_WAR', 			6),
			('LEADER_MC_COMCOMLY', 	'MAJOR_CIV_APPROACH_HOSTILE', 		6),
			('LEADER_MC_COMCOMLY', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	5),
			('LEADER_MC_COMCOMLY', 	'MAJOR_CIV_APPROACH_GUARDED', 		5),
			('LEADER_MC_COMCOMLY', 	'MAJOR_CIV_APPROACH_AFRAID', 		3),
			('LEADER_MC_COMCOMLY', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		4),
			('LEADER_MC_COMCOMLY', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		4);
--==========================================================================================================================
-- Leader_MajorCivApproachBiases
--==========================================================================================================================					
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 			MinorCivApproachType, 				Bias)
VALUES		('LEADER_MC_COMCOMLY', 	'MINOR_CIV_APPROACH_IGNORE', 		3),
			('LEADER_MC_COMCOMLY', 	'MINOR_CIV_APPROACH_FRIENDLY', 		4),
			('LEADER_MC_COMCOMLY', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	4),
			('LEADER_MC_COMCOMLY', 	'MINOR_CIV_APPROACH_CONQUEST', 		4),
			('LEADER_MC_COMCOMLY', 	'MINOR_CIV_APPROACH_BULLY', 		6);
--==========================================================================================================================
-- Leader_Flavors
--==========================================================================================================================					
INSERT INTO Leader_Flavors 
			(LeaderType, 			FlavorType, 						Flavor)
VALUES		('LEADER_MC_COMCOMLY', 	'FLAVOR_OFFENSE', 					6),
			('LEADER_MC_COMCOMLY', 	'FLAVOR_DEFENSE', 					3),
			('LEADER_MC_COMCOMLY', 	'FLAVOR_CITY_DEFENSE', 				4),
			('LEADER_MC_COMCOMLY', 	'FLAVOR_MILITARY_TRAINING', 		5),
			('LEADER_MC_COMCOMLY', 	'FLAVOR_RECON', 					6),
			('LEADER_MC_COMCOMLY', 	'FLAVOR_RANGED', 					5),
			('LEADER_MC_COMCOMLY', 	'FLAVOR_MOBILE', 					4),
			('LEADER_MC_COMCOMLY', 	'FLAVOR_NAVAL', 					6),
			('LEADER_MC_COMCOMLY', 	'FLAVOR_NAVAL_RECON', 				7),
			('LEADER_MC_COMCOMLY', 	'FLAVOR_NAVAL_GROWTH', 				4),
			('LEADER_MC_COMCOMLY', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	3),
			('LEADER_MC_COMCOMLY', 	'FLAVOR_AIR', 						2),
			('LEADER_MC_COMCOMLY', 	'FLAVOR_EXPANSION', 				8),
			('LEADER_MC_COMCOMLY', 	'FLAVOR_GROWTH', 					6),
			('LEADER_MC_COMCOMLY', 	'FLAVOR_TILE_IMPROVEMENT', 			4),
			('LEADER_MC_COMCOMLY', 	'FLAVOR_INFRASTRUCTURE', 			4),
			('LEADER_MC_COMCOMLY', 	'FLAVOR_PRODUCTION', 				4),
			('LEADER_MC_COMCOMLY', 	'FLAVOR_GOLD', 						5),
			('LEADER_MC_COMCOMLY', 	'FLAVOR_SCIENCE', 					5),
			('LEADER_MC_COMCOMLY', 	'FLAVOR_CULTURE', 					7),
			('LEADER_MC_COMCOMLY', 	'FLAVOR_HAPPINESS', 				7),
			('LEADER_MC_COMCOMLY', 	'FLAVOR_GREAT_PEOPLE', 				7),
			('LEADER_MC_COMCOMLY', 	'FLAVOR_WONDER', 					3),
			('LEADER_MC_COMCOMLY', 	'FLAVOR_RELIGION', 					3),
			('LEADER_MC_COMCOMLY', 	'FLAVOR_DIPLOMACY', 				3),
			('LEADER_MC_COMCOMLY', 	'FLAVOR_SPACESHIP', 				5),
			('LEADER_MC_COMCOMLY', 	'FLAVOR_WATER_CONNECTION', 			6),
			('LEADER_MC_COMCOMLY', 	'FLAVOR_NUKE', 						5),
			('LEADER_MC_COMCOMLY', 	'FLAVOR_USE_NUKE', 					2),
			('LEADER_MC_COMCOMLY', 	'FLAVOR_ESPIONAGE', 				3),
			('LEADER_MC_COMCOMLY', 	'FLAVOR_AIRLIFT', 					5),
			('LEADER_MC_COMCOMLY', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_MC_COMCOMLY', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_MC_COMCOMLY', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_MC_COMCOMLY', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_MC_COMCOMLY', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_MC_COMCOMLY', 	'FLAVOR_AIR_CARRIER', 				5);
--==========================================================================================================================	
-- Flavors
--==========================================================================================================================			
INSERT OR REPLACE INTO Flavors 
			(Type)
VALUES		('FLAVOR_JFD_RELIGIOUS_INTOLERANCE');

INSERT INTO Leader_Flavors
			(LeaderType,			FlavorType,								Flavor)
VALUES		('LEADER_MC_COMCOMLY',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',		4);
--==========================================================================================================================
-- Leader_Traits
--==========================================================================================================================					
INSERT INTO Leader_Traits 
			(LeaderType, 			TraitType)
VALUES		('LEADER_MC_COMCOMLY', 	'TRAIT_MC_CHINOOK');
--==========================================================================================================================			
--==========================================================================================================================	