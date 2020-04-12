--==========================================================================================================================
-- ART DEFINES
--==========================================================================================================================
-- IconTextureAtlases
------------------------------
INSERT INTO IconTextureAtlases
		(Atlas, 								IconSize, 	Filename, 						IconsPerRow, 			IconsPerColumn)
VALUES	('CBR_POMO_ATLAS', 						256, 		'Lime_PomoAtlas_256.dds',		3, 						2),
		('CBR_POMO_ATLAS', 						128, 		'Lime_PomoAtlas_128.dds',		3, 						2),
		('CBR_POMO_ATLAS', 						80, 		'Lime_PomoAtlas_80.dds',		3, 						2),
		('CBR_POMO_ATLAS', 						64, 		'Lime_PomoAtlas_64.dds',		3, 						2),
		('CBR_POMO_ATLAS', 						45, 		'Lime_PomoAtlas_45.dds',		3, 						2),
		('CBR_POMO_ATLAS', 						32, 		'Lime_PomoAtlas_32.dds',		3, 						2),
		('CBR_POMO_ALPHA_ATLAS', 				128, 		'Lime_PomoAlphaAtlas_128.dds',		1,						1),
		('CBR_POMO_ALPHA_ATLAS', 				80, 		'Lime_PomoAlphaAtlas_80.dds',		1, 						1),
		('CBR_POMO_ALPHA_ATLAS', 				64, 		'Lime_PomoAlphaAtlas_64.dds',		1, 						1),
		('CBR_POMO_ALPHA_ATLAS', 				48, 		'Lime_PomoAlphaAtlas_48.dds',		1, 						1),
		('CBR_POMO_ALPHA_ATLAS', 				45, 		'Lime_PomoAlphaAtlas_45.dds',		1, 						1),
		('CBR_POMO_ALPHA_ATLAS', 				32, 		'Lime_PomoAlphaAtlas_32.dds',		1, 						1),
		('CBR_POMO_ALPHA_ATLAS', 				24, 		'Lime_PomoAlphaAtlas_24.dds',		1, 						1),
		('CBR_POMO_ALPHA_ATLAS', 				16, 		'Lime_PomoAlphaAtlas_16.dds',		1, 						1),
		('CBR_UNIT_FLAG_BASKET_WEAVER_ATLAS',	32, 		'Unit_BasketWeaver_Flag_32.dds',1, 						1);
------------------------------
-- Colors
------------------------------
INSERT INTO Colors
		(Type, 									Red, 		Green, 		Blue,		Alpha)
VALUES	('COLOR_PLAYER_CBR_POMO_ICON', 			0,			0,			0,			1),
		('COLOR_PLAYER_CBR_POMO_BACKGROUND',	0.839216,	0.407843,	0.247059,	1);
------------------------------
-- PlayerColors
------------------------------
INSERT INTO PlayerColors
		(Type, 					PrimaryColor, 					SecondaryColor, 					TextColor)
VALUES	('PLAYERCOLOR_CBR_POMO','COLOR_PLAYER_CBR_POMO_ICON', 	'COLOR_PLAYER_CBR_POMO_BACKGROUND', 'COLOR_PLAYER_WHITE_TEXT');
--==========================================================================================================================
-- UNIT GRAPHICS
--==========================================================================================================================
-- ArtDefine_StrategicView
------------------------------
INSERT INTO ArtDefine_StrategicView
		(StrategicViewType, 					TileType,		Asset)
VALUES	('ART_DEF_UNIT_CBR_BASKET_WEAVER', 		'Unit', 		'sv_BasketWeaver.dds');
------------------------------
-- ArtDefine_UnitInfos
------------------------------
INSERT INTO ArtDefine_UnitInfos
		(Type, 									DamageStates,	Formation)
SELECT	'ART_DEF_UNIT_CBR_BASKET_WEAVER',		DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE Type = 'ART_DEF_UNIT_GREAT_ARTIST';
------------------------------
-- ArtDefine_UnitInfoMemberInfos
------------------------------
INSERT INTO ArtDefine_UnitInfoMemberInfos
		(UnitInfoType,						UnitMemberInfoType,							NumMembers)
SELECT	'ART_DEF_UNIT_CBR_BASKET_WEAVER', 'ART_DEF_UNIT_MEMBER_CBR_BASKET_WEAVER',		1
FROM ArtDefine_UnitInfoMemberInfos WHERE UnitInfoType = 'ART_DEF_UNIT_GREAT_ARTIST';
------------------------
-- ArtDefine_UnitMemberCombats
------------------------
INSERT INTO ArtDefine_UnitMemberCombats
		(UnitMemberType,							EnableActions, HasRefaceAfterCombat)
SELECT	'ART_DEF_UNIT_MEMBER_CBR_BASKET_WEAVER',	EnableActions, HasRefaceAfterCombat
FROM ArtDefine_UnitMemberCombats WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_GREATARTIST_EARLY_DRUMMER';
------------------------
-- ArtDefine_UnitMemberInfos
------------------------
INSERT INTO ArtDefine_UnitMemberInfos
		(Type, 										Scale, Domain, Model,	MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_CBR_BASKET_WEAVER',	Scale, Domain, Model,	MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE Type = 'ART_DEF_UNIT_MEMBER_GREATARTIST_EARLY_DRUMMER';
--==========================================================================================================================
--==========================================================================================================================