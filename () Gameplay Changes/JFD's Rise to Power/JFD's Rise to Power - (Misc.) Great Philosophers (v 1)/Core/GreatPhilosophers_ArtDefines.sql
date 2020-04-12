--==========================================================================================================================
-- ART DEFINES
--==========================================================================================================================	
------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_StrategicView
------------------------------------------------------------------------------------------------------------------------
INSERT INTO ArtDefine_StrategicView 
		(StrategicViewType, 						TileType,	 Asset)
VALUES	('ART_DEF_UNIT_JFD_GREAT_PHILOSOPHER', 		'Unit', 	 'sv_GreatPhilosopher.dds'),
		('ART_DEF_UNIT_JFD_GREAT_PHILOSOPHER_RENAISSANCE', 	'Unit', 	 'sv_GreatPhilosopher.dds');
------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_UnitInfos
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO ArtDefine_UnitInfos 
		(Type, 										DamageStates,	Formation,	IconAtlas,								PortraitIndex)
VALUES	('ART_DEF_UNIT_JFD_GREAT_PHILOSOPHER',		null, 			null,		'JFD_GREAT_PHILOSOPHERS_ICON_ATLAS',	0),
		('ART_DEF_UNIT_JFD_GREAT_PHILOSOPHER_RENAISSANCE',  null, 			null,		'JFD_GREAT_PHILOSOPHERS_ICON_ATLAS',	1);
------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_UnitInfoMemberInfos
------------------------------------------------------------------------------------------------------------------------
INSERT INTO ArtDefine_UnitInfoMemberInfos 		
		(UnitInfoType,								UnitMemberInfoType,									NumMembers)
VALUES	('ART_DEF_UNIT_JFD_GREAT_PHILOSOPHER',		'ART_DEF_UNIT_MEMBER_JFD_GREAT_PHILOSOPHER',		1),
		('ART_DEF_UNIT_JFD_GREAT_PHILOSOPHER_RENAISSANCE', 	'ART_DEF_UNIT_MEMBER_JFD_GREAT_PHILOSOPHER_RENAISSANCE',	1);
------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_UnitMemberInfos
------------------------------------------------------------------------------------------------------------------------
INSERT INTO ArtDefine_UnitMemberInfos 		
		(Type,											Scale,	Model,								MaterialTypeTag,	MaterialTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_JFD_GREAT_PHILOSOPHER',	Scale,	'GreatPhilosopher_Early.fxsxml',	'CLOTH',			'FLESH'
FROM ArtDefine_UnitMemberInfos WHERE Type = 'ART_DEF_UNIT_MEMBER_GREAT_ARTIST';	

INSERT INTO ArtDefine_UnitMemberInfos 		
		(Type,												Scale,	Model,							MaterialTypeTag,	MaterialTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_JFD_GREAT_PHILOSOPHER_RENAISSANCE',	Scale,	'GreatPhilosopher_Late.fxsxml',	'CLOTH',			'FLESH'
FROM ArtDefine_UnitMemberInfos WHERE Type = 'ART_DEF_UNIT_MEMBER_GREAT_ARTIST';	
------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_UnitMemberCombats
------------------------------------------------------------------------------------------------------------------------
INSERT INTO ArtDefine_UnitMemberCombats 		
		(UnitMemberType,							  EnableActions, HasRefaceAfterCombat)
SELECT	'ART_DEF_UNIT_MEMBER_JFD_GREAT_PHILOSOPHER',  EnableActions, HasRefaceAfterCombat
FROM ArtDefine_UnitMemberCombats WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_GREAT_ARTIST';	

INSERT INTO ArtDefine_UnitMemberCombats 		
		(UnitMemberType,								 EnableActions,	HasRefaceAfterCombat)
SELECT	'ART_DEF_UNIT_MEMBER_JFD_GREAT_PHILOSOPHER_RENAISSANCE', EnableActions,	HasRefaceAfterCombat
FROM ArtDefine_UnitMemberCombats WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_GREAT_ARTIST';	
--==========================================================================================================================
-- AUDIO
--==========================================================================================================================	
--------------------------------------------------------------------------------------------------------------------------
-- Audio_Sounds
------------------------------------------------------------------------------------------------------------------------	
INSERT OR REPLACE INTO Audio_Sounds 	
		(SoundID, 										Filename, 					 LoadType)
VALUES	('SND_UNIT_JFD_JFD_GREAT_PHILOSOPHER_ACTIVATE', 'GreatPhilosopherActivate',	 'DynamicResident');
------------------------------------------------------------------------------------------------------------------------
-- Audio_2DSounds
------------------------------------------------------------------------------------------------------------------------	
INSERT OR REPLACE INTO Audio_2DSounds 
		(ScriptID, 										SoundID, 										SoundType,   Looping,  DontTriggerDuplicates,	DontPlayMoreThan,	TaperSoundtrackVolume,	MinVolume, 	MaxVolume)
VALUES	('AS2D_UNIT_JFD_GREAT_PHILOSOPHER_ACTIVATE',	'SND_UNIT_JFD_JFD_GREAT_PHILOSOPHER_ACTIVATE',	'GAME_SFX',  0,		   1,						1,					-1.0,					100, 		100);
--==========================================================================================================================
-- ICON ATLASES
--==========================================================================================================================	
--------------------------------------------------------------------------------------------------------------------------
-- IconTextureAtlases
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO IconTextureAtlases 
		(Atlas, 										IconSize, 	Filename, 										IconsPerRow, 	IconsPerColumn)
VALUES	('JFD_GREAT_PHILOSOPHERS_ICON_ATLAS', 			256, 		'JFD_GreatPhilosophers_IconAtlas_256.dds',		3, 				1),
		('JFD_GREAT_PHILOSOPHERS_ICON_ATLAS', 			128, 		'JFD_GreatPhilosophers_IconAtlas_128.dds',		3, 				1),
		('JFD_GREAT_PHILOSOPHERS_ICON_ATLAS', 			80, 		'JFD_GreatPhilosophers_IconAtlas_80.dds',		3, 				1),
		('JFD_GREAT_PHILOSOPHERS_ICON_ATLAS', 			64, 		'JFD_GreatPhilosophers_IconAtlas_64.dds',		3, 				1),
		('JFD_GREAT_PHILOSOPHERS_ICON_ATLAS', 			45, 		'JFD_GreatPhilosophers_IconAtlas_45.dds',		3, 				1),
		('JFD_GREAT_PHILOSOPHERS_ICON_ATLAS', 			32, 		'JFD_GreatPhilosophers_IconAtlas_32.dds',		3, 				1),
		('JFD_GREAT_PHILOSOPHERS_MISSION_ATLAS', 		64, 		'JFD_GreatPhilosophers_MissionAtlas_64.dds',	2, 				1),
		('JFD_GREAT_PHILOSOPHERS_MISSION_ATLAS', 		45, 		'JFD_GreatPhilosophers_MissionAtlas_45.dds',	2, 				1),
		('JFD_GREAT_PHILOSOPHERS_POLICY_ATLAS', 		64, 		'JFD_GreatPhilosophers_PolicyAtlas_64.dds',		1, 				1),
		('JFD_GREAT_PHILOSOPHERS_UNIT_FLAG_ATLAS',		32, 		'JFD_GreatPhilosophers_UnitFlagAtlas_32.dds',	1, 				1);
--==========================================================================================================================
--==========================================================================================================================