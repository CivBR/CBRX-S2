--==========================================================================================================================
-- ART DEFINES
--==========================================================================================================================	
-- ArtDefine_StrategicView
------------------------------------------------------------------------------------------------------------------------
INSERT INTO ArtDefine_StrategicView 
		(StrategicViewType, 						TileType,	 Asset)
VALUES	('ART_DEF_UNIT_JFD_GREAT_REVOLUTIONARY', 	'Unit', 	 'sv_GreatRevolutionary.dds');
------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_UnitInfos
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO ArtDefine_UnitInfos 
		(Type, 										DamageStates,	Formation)
SELECT	'ART_DEF_UNIT_JFD_GREAT_REVOLUTIONARY', 	DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE Type = 'ART_DEF_UNIT_ARTIST';	
------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_UnitInfoMemberInfos
------------------------------------------------------------------------------------------------------------------------
INSERT INTO ArtDefine_UnitInfoMemberInfos 		
		(UnitInfoType,								UnitMemberInfoType,									NumMembers)
SELECT	'ART_DEF_UNIT_JFD_GREAT_REVOLUTIONARY', 	'ART_DEF_UNIT_MEMBER_JFD_GREAT_REVOLUTIONARY',		NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE UnitInfoType = 'ART_DEF_UNIT_ARTIST_LATE';	
------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_UnitMemberInfos
------------------------------------------------------------------------------------------------------------------------
INSERT INTO ArtDefine_UnitMemberInfos 		
		(Type,												Scale,	Model,							MaterialTypeTag,	MaterialTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_JFD_GREAT_REVOLUTIONARY', 		Scale,	'GreatRevolutionary.fxsxml',	'CLOTH',			'FLESH'
FROM ArtDefine_UnitMemberInfos WHERE Type = 'ART_DEF_UNIT_MEMBER_GREAT_ARTIST';	
------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_UnitMemberCombats
------------------------------------------------------------------------------------------------------------------------
INSERT INTO ArtDefine_UnitMemberCombats 		
		(UnitMemberType,									EnableActions,	HasRefaceAfterCombat)
SELECT	'ART_DEF_UNIT_MEMBER_JFD_GREAT_REVOLUTIONARY', 		EnableActions,	HasRefaceAfterCombat
FROM ArtDefine_UnitMemberCombats WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_GREAT_ARTIST';	
--==========================================================================================================================
-- ICON ATLASES
--==========================================================================================================================	
-- IconTextureAtlases
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO IconTextureAtlases 
		(Atlas, 											IconSize, 	Filename, 											IconsPerRow, 	IconsPerColumn)
VALUES	('JFD_GREAT_REVOLUTIONARIES_ICON_ATLAS', 			256, 		'JFD_GreatRevolutionaries_IconAtlas_256.dds',		3, 				1),
		('JFD_GREAT_REVOLUTIONARIES_ICON_ATLAS', 			128, 		'JFD_GreatRevolutionaries_IconAtlas_128.dds',		3, 				1),
		('JFD_GREAT_REVOLUTIONARIES_ICON_ATLAS', 			80, 		'JFD_GreatRevolutionaries_IconAtlas_80.dds',		3, 				1),
		('JFD_GREAT_REVOLUTIONARIES_ICON_ATLAS', 			64, 		'JFD_GreatRevolutionaries_IconAtlas_64.dds',		3, 				1),
		('JFD_GREAT_REVOLUTIONARIES_ICON_ATLAS', 			45, 		'JFD_GreatRevolutionaries_IconAtlas_45.dds',		3, 				1),
		('JFD_GREAT_REVOLUTIONARIES_ICON_ATLAS', 			32, 		'JFD_GreatRevolutionaries_IconAtlas_32.dds',		3, 				1),
		('JFD_GREAT_REVOLUTIONARIES_UNIT_FLAG_ATLAS',		32, 		'JFD_GreatRevolutionaries_UnitFlagAtlas_32.dds',	1, 				1);
--==========================================================================================================================
--==========================================================================================================================