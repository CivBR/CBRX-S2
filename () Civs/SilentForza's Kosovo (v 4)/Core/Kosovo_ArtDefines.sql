--==========================================================================================================================
-- ART DEFINES
--==========================================================================================================================
INSERT INTO ArtDefine_UnitInfos(Type, DamageStates, Formation)
  VALUES ('ART_DEF_UNIT_SF_KOSOVAR_UCK', 1, 'UnFormed');
INSERT INTO ArtDefine_UnitInfoMemberInfos(UnitInfoType, UnitMemberInfoType, NumMembers)
  VALUES ('ART_DEF_UNIT_SF_KOSOVAR_UCK', 'ART_DEF_UNIT_MEMBER_SF_KOSOVAR_UCK', 10);
INSERT INTO ArtDefine_UnitMemberInfos(Type, Scale, Model, MaterialTypeTag, MaterialTypeSoundOverrideTag)
  VALUES ('ART_DEF_UNIT_MEMBER_SF_KOSOVAR_UCK', 0.140000000596046, 'Paratrooper_UK.fxsxml', 'CLOTH', 'FLESH');
INSERT INTO ArtDefine_UnitMemberCombats(UnitMemberType, EnableActions, ShortMoveRadius, ShortMoveRate, TargetHeight, HasShortRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat)
  VALUES ('ART_DEF_UNIT_MEMBER_SF_KOSOVAR_UCK', 'Idle Attack RunCharge AttackCity Bombard Death BombardDefend Run Fortify CombatReady Walk AttackCharge', 12.0, 0.349999994039536, 8.0, 1, 1, 1);
INSERT INTO ArtDefine_UnitMemberCombatWeapons(UnitMemberType, "Index", SubIndex, WeaponTypeTag, WeaponTypeSoundOverrideTag)
  VALUES ('ART_DEF_UNIT_MEMBER_SF_KOSOVAR_UCK', 0, 0, 'BULLET', 'BULLET');	
--------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_LandmarkTypes
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO ArtDefine_LandmarkTypes(Type, LandmarkType, FriendlyName)
SELECT 'ART_DEF_IMPROVEMENT_SF_KULLA', 'Improvement', 'KULLA';
--------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_Landmarks
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO ArtDefine_Landmarks(Era, State, Scale, ImprovementType, LayoutHandler, ResourceType, Model, TerrainContour)
SELECT 'Any', 'UnderConstruction', 0.8, 'ART_DEF_IMPROVEMENT_SF_KULLA', 'SNAPSHOT', 'ART_DEF_RESOURCE_ALL', 'Kulla_B.fxsxml', 1 UNION ALL
SELECT 'Any', 'Constructed', 0.8, 'ART_DEF_IMPROVEMENT_SF_KULLA', 'SNAPSHOT', 'ART_DEF_RESOURCE_ALL', 'Kulla_HB.fxsxml', 1 UNION ALL
SELECT 'Any', 'Pillaged', 0.8, 'ART_DEF_IMPROVEMENT_SF_KULLA', 'SNAPSHOT', 'ART_DEF_RESOURCE_ALL', 'Kulla_PL.fxsxml', 1;
--------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_StrategicView
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO ArtDefine_StrategicView 
		(StrategicViewType, 								TileType,		Asset)
VALUES	('ART_DEF_UNIT_SF_KOSOVAR_UCK',			'Unit', 		'sv_uck.dds'),
		('ART_DEF_IMPROVEMENT_SF_KULLA',		'Improvement',	'Kulla_SV.dds');

--==========================================================================================================================
-- AUDIO
--==========================================================================================================================	
-- Audio_Sounds
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Audio_Sounds 
		(SoundID, 										Filename, 									LoadType)
VALUES	('SND_LEADER_MUSIC_SF_IBRAHIM_RUGOVA_PEACE', 			'Kosovo_Peace',						'DynamicResident'),
		('SND_LEADER_MUSIC_SF_IBRAHIM_RUGOVA_WAR', 			'Kosovo_War', 							'DynamicResident');		
--------------------------------------------------------------------------------------------------------------------------
-- Audio_2DSounds
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Audio_2DSounds 
		(ScriptID, 										SoundID, 									SoundType, 		TaperSoundtrackVolume,	MinVolume, 	MaxVolume,  IsMusic, Looping)
VALUES	('AS2D_LEADER_MUSIC_SF_IBRAHIM_RUGOVA_PEACE', 		'SND_LEADER_MUSIC_SF_IBRAHIM_RUGOVA_PEACE', 		'GAME_MUSIC', 	-1.0,					45, 		45, 		1, 		 0),
		('AS2D_LEADER_MUSIC_SF_IBRAHIM_RUGOVA_WAR', 			'SND_LEADER_MUSIC_SF_IBRAHIM_RUGOVA_WAR', 		'GAME_MUSIC', 	-1.0,					45, 		45, 		1,		 0);
--==========================================================================================================================
-- ICON ATLASES
--==========================================================================================================================	
-- IconTextureAtlases
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO IconTextureAtlases 
		(Atlas, 						IconSize, 	Filename, 							IconsPerRow, 	IconsPerColumn)
VALUES	('SF_KOSOVO_ATLAS', 				256, 		'SF_KosovoAtlas256.dds',		3, 				2),
		('SF_KOSOVO_ATLAS', 				128, 		'SF_KosovoAtlas128.dds',		3, 				2),
		('SF_KOSOVO_ATLAS', 				80, 		'SF_KosovoAtlas80.dds',			3, 				2),
		('SF_KOSOVO_ATLAS', 				64, 		'SF_KosovoAtlas64.dds',			3, 				2),
		('SF_KOSOVO_ATLAS', 				45, 		'SF_KosovoAtlas45.dds',			3, 				2),
		('SF_KOSOVO_ATLAS', 				32, 		'SF_KosovoAtlas32.dds',			3, 				2),
		('SF_KOSOVO_ALPHA_ATLAS', 		128, 		'SF_KosovoAlpha128.dds',		1,				1),
		('SF_KOSOVO_ALPHA_ATLAS', 		80, 		'SF_KosovoAlpha80.dds',		1, 				1),
		('SF_KOSOVO_ALPHA_ATLAS', 		64, 		'SF_KosovoAlpha64.dds',		1, 				1),
		('SF_KOSOVO_ALPHA_ATLAS', 		48, 		'SF_KosovoAlpha48.dds',		1, 				1),
		('SF_KOSOVO_ALPHA_ATLAS', 		45, 		'SF_KosovoAlpha45.dds',		1, 				1),
		('SF_KOSOVO_ALPHA_ATLAS', 		32, 		'SF_KosovoAlpha32.dds',		1, 				1),
		('SF_KOSOVO_ALPHA_ATLAS', 		24, 		'SF_KosovoAlpha24.dds',		1, 				1),
		('SF_KOSOVO_ALPHA_ATLAS', 		16, 		'SF_KosovoAlpha16.dds',		1, 				1),
		('SF_KOSOVO_FLAG_ATLAS', 		32, 		'Unit_UCK_Flag_32.dds',		1, 				1),
		('SF_KOSOVO_IMPROVEMENT_ATLAS', 256,        'Kulla256.dds',				1,				1),
		('SF_KOSOVO_IMPROVEMENT_ATLAS', 64,        'Kulla64.dds',				1,				1);				