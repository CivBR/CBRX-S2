--=======================================================================================================================
-- AUDIO
--=======================================================================================================================	
------------------------------------------------------------------------------------------------------------------------
-- Audio_Sounds
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Audio_Sounds 
		(SoundID, 											Filename, 						LoadType)
VALUES	('SND_LEADER_MUSIC_JFD_SWEDEN_KARL_XII_PEACE', 		'JFD_SwedenKarlXII_Peace', 		'DynamicResident'),
		('SND_LEADER_MUSIC_JFD_SWEDEN_KARL_XII_WAR', 		'JFD_SwedenKarlXII_War', 		'DynamicResident');		
------------------------------------------------------------------------------------------------------------------------
-- Audio_2DSounds
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Audio_2DSounds 
		(ScriptID, 											SoundID, 											SoundType, 		TaperSoundtrackVolume,	MinVolume, 	MaxVolume,	IsMusic, Looping)
VALUES	('AS2D_LEADER_MUSIC_JFD_SWEDEN_KARL_XII_PEACE', 	'SND_LEADER_MUSIC_JFD_SWEDEN_KARL_XII_PEACE',		'GAME_MUSIC', 	-1.0,					50, 		50, 		1, 		 0),
		('AS2D_LEADER_MUSIC_JFD_SWEDEN_KARL_XII_WAR', 		'SND_LEADER_MUSIC_JFD_SWEDEN_KARL_XII_WAR', 		'GAME_MUSIC', 	-1.0,					50, 		50, 		1,		 0);
--=======================================================================================================================
-- COLOURS
--=======================================================================================================================	
------------------------------------------------------------------------------------------------------------------------
-- Colors
------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Colors 
		(Type, 												Red, 	Green, 	Blue,   Alpha)
VALUES	('COLOR_PLAYER_JFD_SWEDEN_KARL_XII_ICON', 			0.9764, 0.9686, 0.0117, 1),
		('COLOR_PLAYER_JFD_SWEDEN_KARL_XII_BACKGROUND', 	0.0313, 0.0313, 0.6509,	1);
------------------------------------------------------------------------------------------------------------------------
-- PlayerColors
------------------------------------------------------------------------------------------------------------------------			
INSERT INTO PlayerColors 
		(Type, 									PrimaryColor, 								SecondaryColor, 									TextColor)
VALUES	('PLAYERCOLOR_JFD_SWEDEN_KARL_XII',		'COLOR_PLAYER_JFD_SWEDEN_KARL_XII_ICON',	'COLOR_PLAYER_JFD_SWEDEN_KARL_XII_BACKGROUND',		'COLOR_PLAYER_WHITE_TEXT');
--=======================================================================================================================
-- ICON ATLASES
--=======================================================================================================================	
------------------------------------------------------------------------------------------------------------------------
-- IconTextureAtlases
------------------------------------------------------------------------------------------------------------------------
INSERT INTO IconTextureAtlases 
		(Atlas, 									IconSize, 	Filename, 										IconsPerRow, 	IconsPerColumn)
VALUES	('JFD_SWEDEN_KARL_XII_ALPHA_ATLAS',			128, 		'JFD_SwedenKarlXII_AlphaAtlas_128.dds',			1,				1),
		('JFD_SWEDEN_KARL_XII_ALPHA_ATLAS',			80, 		'JFD_SwedenKarlXII_AlphaAtlas_80.dds',			1, 				1),
		('JFD_SWEDEN_KARL_XII_ALPHA_ATLAS',			64, 		'JFD_SwedenKarlXII_AlphaAtlas_64.dds',			1, 				1),
		('JFD_SWEDEN_KARL_XII_ALPHA_ATLAS',			48, 		'JFD_SwedenKarlXII_AlphaAtlas_48.dds',			1, 				1),
		('JFD_SWEDEN_KARL_XII_ALPHA_ATLAS',			45, 		'JFD_SwedenKarlXII_AlphaAtlas_45.dds',			1, 				1),
		('JFD_SWEDEN_KARL_XII_ALPHA_ATLAS',			32, 		'JFD_SwedenKarlXII_AlphaAtlas_32.dds',			1, 				1),
		('JFD_SWEDEN_KARL_XII_ALPHA_ATLAS',			24, 		'JFD_SwedenKarlXII_AlphaAtlas_24.dds',			1, 				1),
		('JFD_SWEDEN_KARL_XII_ALPHA_ATLAS',			16, 		'JFD_SwedenKarlXII_AlphaAtlas_16.dds',			1, 				1),
		('JFD_SWEDEN_KARL_XII_ICON_ATLAS', 			256, 		'JFD_SwedenKarlXII_IconAtlas_256.dds',			2, 				2),
		('JFD_SWEDEN_KARL_XII_ICON_ATLAS', 			128, 		'JFD_SwedenKarlXII_IconAtlas_128.dds',			2, 				2),
		('JFD_SWEDEN_KARL_XII_ICON_ATLAS', 			80, 		'JFD_SwedenKarlXII_IconAtlas_80.dds',			2, 				2),
		('JFD_SWEDEN_KARL_XII_ICON_ATLAS', 			64, 		'JFD_SwedenKarlXII_IconAtlas_64.dds',			2, 				2),
		('JFD_SWEDEN_KARL_XII_ICON_ATLAS', 			45, 		'JFD_SwedenKarlXII_IconAtlas_45.dds',			2, 				2),
		('JFD_SWEDEN_KARL_XII_ICON_ATLAS', 			32, 		'JFD_SwedenKarlXII_IconAtlas_32.dds',			2, 				2);
--=======================================================================================================================	
--=======================================================================================================================	
