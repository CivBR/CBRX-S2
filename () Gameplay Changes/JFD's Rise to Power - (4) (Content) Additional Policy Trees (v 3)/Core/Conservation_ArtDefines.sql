--==========================================================================================================================
-- AUDIO
--==========================================================================================================================	
--------------------------------------------------------------------------------------------------------------------------
-- Audio_Sounds
--------------------------------------------------------------------------------------------------------------------------	
INSERT OR REPLACE INTO Audio_Sounds 	
		(SoundID, 									Filename, 					LoadType)
VALUES	('SND_WONDER_SPEECH_JFD_MT_RUSHMORE',		'Wonder_MtRushmore',		'DynamicResident');
--------------------------------------------------------------------------------------------------------------------------
-- Audio_2DSounds
--------------------------------------------------------------------------------------------------------------------------	
INSERT OR REPLACE INTO Audio_2DSounds 
		(ScriptID, 									SoundID, 									SoundType,   Looping,   DontTriggerDuplicates,	DontPlayMoreThan,	TaperSoundtrackVolume,	MinVolume, 	MaxVolume)
VALUES	('AS2D_WONDER_SPEECH_JFD_MT_RUSHMORE',		'SND_WONDER_SPEECH_JFD_MT_RUSHMORE',		'GAME_SFX',  0,			1,						1,					0.0,					75, 		75);
--==========================================================================================================================
-- ICON ATLASES
--==========================================================================================================================	
--------------------------------------------------------------------------------------------------------------------------
-- IconTextureAtlases
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO IconTextureAtlases 
		(Atlas, 							IconSize, 	Filename, 									IconsPerRow, 	IconsPerColumn)
VALUES	('JFD_CONSERVATION_POLICY_A_ATLAS', 64, 		'JFD_Conservation_PolicyAAtlas_64.dds',		5, 				1),
		('JFD_CONSERVATION_POLICY_ATLAS', 	64, 		'JFD_Conservation_PolicyAtlas_64.dds',		5, 				1),
		('JFD_CONSERVATION_WONDER_ATLAS',	256, 		'JFD_Conservation_WonderAtlas_256.dds',		1, 				1),
		('JFD_CONSERVATION_WONDER_ATLAS',	128, 		'JFD_Conservation_WonderAtlas_128.dds',		1, 				1),
		('JFD_CONSERVATION_WONDER_ATLAS',	80, 		'JFD_Conservation_WonderAtlas_80.dds',		1, 				1),
		('JFD_CONSERVATION_WONDER_ATLAS',	64, 		'JFD_Conservation_WonderAtlas_64.dds',		1, 				1),
		('JFD_CONSERVATION_WONDER_ATLAS',	45, 		'JFD_Conservation_WonderAtlas_45.dds',		1, 				1),
		('JFD_CONSERVATION_WONDER_ATLAS',	32, 		'JFD_Conservation_WonderAtlas_32.dds',		1, 				1);
--==========================================================================================================================
--==========================================================================================================================