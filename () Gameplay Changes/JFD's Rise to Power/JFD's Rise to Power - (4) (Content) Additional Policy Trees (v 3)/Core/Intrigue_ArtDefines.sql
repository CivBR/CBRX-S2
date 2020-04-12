--==========================================================================================================================
-- AUDIO
--==========================================================================================================================	
--------------------------------------------------------------------------------------------------------------------------
-- Audio_Sounds
--------------------------------------------------------------------------------------------------------------------------	
INSERT OR REPLACE INTO Audio_Sounds 	
		(SoundID, 									Filename, 					LoadType)
VALUES	('SND_WONDER_SPEECH_JFD_WHITE_TOWER',		'Wonder_WhiteTower',		'DynamicResident');
--------------------------------------------------------------------------------------------------------------------------
-- Audio_2DSounds
--------------------------------------------------------------------------------------------------------------------------	
INSERT OR REPLACE INTO Audio_2DSounds 
		(ScriptID, 									SoundID, 								SoundType,   Looping,   DontTriggerDuplicates,	DontPlayMoreThan,	TaperSoundtrackVolume,	MinVolume, 	MaxVolume)
VALUES	('AS2D_WONDER_SPEECH_JFD_WHITE_TOWER',		'SND_WONDER_SPEECH_JFD_WHITE_TOWER',	'GAME_SFX',  0,			1,						1,					0.0,					75, 		75);
--==========================================================================================================================
-- ICON ATLASES
--==========================================================================================================================	
--------------------------------------------------------------------------------------------------------------------------
-- IconTextureAtlases
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO IconTextureAtlases 
		(Atlas, 							IconSize, 	Filename, 									IconsPerRow, 	IconsPerColumn)
VALUES	('JFD_INTRIGUE_BUILDING_ATLAS',		256, 		'JFD_Intrigue_BuildingAtlas_256.dds',		1, 				1),
		('JFD_INTRIGUE_BUILDING_ATLAS',		128, 		'JFD_Intrigue_BuildingAtlas_128.dds',		1, 				1),
		('JFD_INTRIGUE_BUILDING_ATLAS',		80, 		'JFD_Intrigue_BuildingAtlas_80.dds',		1, 				1),
		('JFD_INTRIGUE_BUILDING_ATLAS',		64, 		'JFD_Intrigue_BuildingAtlas_64.dds',		1, 				1),
		('JFD_INTRIGUE_BUILDING_ATLAS',		45, 		'JFD_Intrigue_BuildingAtlas_45.dds',		1, 				1),
		('JFD_INTRIGUE_BUILDING_ATLAS',		32, 		'JFD_Intrigue_BuildingAtlas_32.dds',		1, 				1),
		('JFD_INTRIGUE_POLICY_A_ATLAS',		64, 		'JFD_Intrigue_PolicyAAtlas_64.dds',			5, 				1),
		('JFD_INTRIGUE_POLICY_ATLAS', 		64, 		'JFD_Intrigue_PolicyAtlas_64.dds',			5, 				1),
		('JFD_INTRIGUE_WONDER_ATLAS',		256, 		'JFD_Intrigue_WonderAtlas_256.dds',			1, 				1),
		('JFD_INTRIGUE_WONDER_ATLAS',		128, 		'JFD_Intrigue_WonderAtlas_128.dds',			1, 				1),
		('JFD_INTRIGUE_WONDER_ATLAS',		80, 		'JFD_Intrigue_WonderAtlas_80.dds',			1, 				1),
		('JFD_INTRIGUE_WONDER_ATLAS',		64, 		'JFD_Intrigue_WonderAtlas_64.dds',			1, 				1),
		('JFD_INTRIGUE_WONDER_ATLAS',		45, 		'JFD_Intrigue_WonderAtlas_45.dds',			1, 				1),
		('JFD_INTRIGUE_WONDER_ATLAS',		32, 		'JFD_Intrigue_WonderAtlas_32.dds',			1, 				1);
--==========================================================================================================================
--==========================================================================================================================