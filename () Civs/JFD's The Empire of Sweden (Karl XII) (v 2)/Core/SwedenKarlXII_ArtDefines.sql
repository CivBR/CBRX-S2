--==========================================================================================================================
-- ARTDEFINES
--==========================================================================================================================	
-- IconTextureAtlasesa
------------------------------
INSERT INTO IconTextureAtlases 
		(Atlas, 							IconSize, 	Filename, 								IconsPerRow, 	IconsPerColumn)
VALUES	('JFD_SWEDEN_KARL_ATLAS', 			256, 		'JFD_SwedenKarlAtlas_256.dds',			2, 				2),
		('JFD_SWEDEN_KARL_ATLAS', 			128, 		'JFD_SwedenKarlAtlas_128.dds',			2, 				2),
		('JFD_SWEDEN_KARL_ATLAS', 			80, 		'JFD_SwedenKarlAtlas_80.dds',			2, 				2),
		('JFD_SWEDEN_KARL_ATLAS', 			64, 		'JFD_SwedenKarlAtlas_64.dds',			2, 				2),
		('JFD_SWEDEN_KARL_ATLAS', 			45, 		'JFD_SwedenKarlAtlas_45.dds',			2, 				2),
		('JFD_SWEDEN_KARL_ATLAS', 			32, 		'JFD_SwedenKarlAtlas_32.dds',			2, 				2),
		('JFD_SWEDEN_KARL_ALPHA_ATLAS', 	128, 		'JFD_SwedenKarlAlphaAtlas_128.dds',		1,				1),
		('JFD_SWEDEN_KARL_ALPHA_ATLAS', 	80, 		'JFD_SwedenKarlAlphaAtlas_80.dds',		1, 				1),
		('JFD_SWEDEN_KARL_ALPHA_ATLAS', 	64, 		'JFD_SwedenKarlAlphaAtlas_64.dds',		1, 				1),
		('JFD_SWEDEN_KARL_ALPHA_ATLAS', 	48, 		'JFD_SwedenKarlAlphaAtlas_48.dds',		1, 				1),
		('JFD_SWEDEN_KARL_ALPHA_ATLAS', 	45, 		'JFD_SwedenKarlAlphaAtlas_45.dds',		1, 				1),
		('JFD_SWEDEN_KARL_ALPHA_ATLAS', 	32, 		'JFD_SwedenKarlAlphaAtlas_32.dds',		1, 				1),
		('JFD_SWEDEN_KARL_ALPHA_ATLAS', 	24, 		'JFD_SwedenKarlAlphaAtlas_24.dds',		1, 				1),
		('JFD_SWEDEN_KARL_ALPHA_ATLAS', 	16, 		'JFD_SwedenKarlAlphaAtlas_16.dds',		1, 				1),
		('JFD_SWEDEN_KARL_RESERVE_ATLAS', 	64, 		'JFD_SwedenKarlReserveAtlas_64.dds',	1, 				1),
		('JFD_UNIT_FLAG_REGAL_SHIP_ATLAS', 	32, 		'UnitFlag_Regalskapp_32.dds',			1, 				1);
--==========================================================================================================================
-- AUDIO
--==========================================================================================================================	
-- Audio_Sounds
------------------------------	
INSERT INTO Audio_Sounds 
		(SoundID, 									Filename, 			LoadType)
VALUES	('SND_LEADER_MUSIC_JFD_KARL_XII_PEACE', 	'KarlXII_Peace',	'DynamicResident'),
		('SND_LEADER_MUSIC_JFD_KARL_XII_WAR', 		'KarlXII_War', 		'DynamicResident');		
------------------------------
-- Audio_2DSounds
------------------------------	
INSERT INTO Audio_2DSounds 
		(ScriptID, 									SoundID, 									SoundType, 		MinVolume, 	MaxVolume,  IsMusic, Looping)
VALUES	('AS2D_LEADER_MUSIC_JFD_KARL_XII_PEACE', 	'SND_LEADER_MUSIC_JFD_KARL_XII_PEACE',		'GAME_MUSIC', 	60, 		60, 		1, 		 0),
		('AS2D_LEADER_MUSIC_JFD_KARL_XII_WAR', 		'SND_LEADER_MUSIC_JFD_KARL_XII_WAR', 		'GAME_MUSIC', 	60, 		60, 		1,		 0);
--==========================================================================================================================	
--==========================================================================================================================	
