-- Neutral Nation Art Defines
-- Original Author: EW
-- Completed, Debugged and Assembled: Limaeus

-- Special thanks to JFD for formatting template
--==========================================================================================================================
-- ART DEFINES
--==========================================================================================================================
-- IconTextureAtlases
------------------------------
INSERT INTO IconTextureAtlases
		(Atlas, 							IconSize, 	Filename, 							IconsPerRow, 			IconsPerColumn)
VALUES	('ATLAS_RT_NEUTRAL', 				256, 		'RT_NeutralAtlas_256.dds',			3, 						2),
		('ATLAS_RT_NEUTRAL', 				128, 		'RT_NeutralAtlas_128.dds',			3, 						2),
		('ATLAS_RT_NEUTRAL', 				80, 		'RT_NeutralAtlas_80.dds',			3, 						2),
		('ATLAS_RT_NEUTRAL', 				64, 		'RT_NeutralAtlas_64.dds',			3, 						2),
		('ATLAS_RT_NEUTRAL', 				45, 		'RT_NeutralAtlas_45.dds',			3, 						2),
		('ATLAS_RT_NEUTRAL', 				32, 		'RT_NeutralAtlas_32.dds',			3, 						2),
		('ATLAS_ALPHA_RT_NEUTRAL', 			128, 		'RT_NeutralAlphaAtlas_128.dds',		1,						1),
		('ATLAS_ALPHA_RT_NEUTRAL', 			80, 		'RT_NeutralAlphaAtlas_80.dds',		1, 						1),
		('ATLAS_ALPHA_RT_NEUTRAL', 			64, 		'RT_NeutralAlphaAtlas_64.dds',		1, 						1),
		('ATLAS_ALPHA_RT_NEUTRAL', 			48, 		'RT_NeutralAlphaAtlas_48.dds',		1, 						1),
		('ATLAS_ALPHA_RT_NEUTRAL', 			45, 		'RT_NeutralAlphaAtlas_45.dds',		1, 						1),
		('ATLAS_ALPHA_RT_NEUTRAL', 			32, 		'RT_NeutralAlphaAtlas_32.dds',		1, 						1),
		('ATLAS_ALPHA_RT_NEUTRAL', 			24, 		'RT_NeutralAlphaAtlas_24.dds',		1, 						1),
		('ATLAS_ALPHA_RT_NEUTRAL', 			16, 		'RT_NeutralAlphaAtlas_16.dds',		1, 						1),
		('RT_UNIT_FLAG_CHONNONTON_ATLAS',	32, 		'Unit_Chonnonton_Flag_32.dds',		1, 						1);
		
------------------------------
-- Colors
------------------------------
INSERT INTO Colors
		(Type,	Red,	Green,	Blue,	Alpha)
VALUES	('COLOR_EW_NEUTRAL_PRIMARY',	0.95,	0.62,	0.26,	1),
		('COLOR_EW_NEUTRAL_SECONDARY',	0.32,	0.31,	0.28,	1);
		--('COLOR_EW_NEUTRAL_PRIMARY',	0.89,	0.41,	0.01,	1);

------------------------------
-- PlayerColors
------------------------------
INSERT INTO PlayerColors
		(Type,	PrimaryColor,	SecondaryColor,	TextColor)
VALUES	('PLAYERCOLOR_EW_NEUTRAL',	'COLOR_EW_NEUTRAL_PRIMARY',	'COLOR_EW_NEUTRAL_SECONDARY',	'COLOR_PLAYER_WHITE_TEXT');

------------------------------
-- IconFontTextures
------------------------------
-- INSERT INTO IconFontTextures 
		-- (IconFontTexture, 						IconFontTextureFile)
-- VALUES	('ICON_FONT_TEXTURE_LIME_FLINT',		'Lime_FlintFontIcon_22');
------------------------------
-- IconFontMapping
------------------------------
-- INSERT INTO IconFontMapping 
		-- (IconName, 					IconFontTexture,				IconMapping)
-- VALUES	('ICON_RES_LIME_FLINT', 	'ICON_FONT_TEXTURE_LIME_FLINT',	1);

--==========================================================================================================================
-- AUDIO
--==========================================================================================================================
-- Audio_Sounds
------------------------------
INSERT INTO Audio_Sounds
		(SoundID, 					Filename, 		LoadType)
VALUES 	('SND_DOM_SPEECH_NEUTRAL', 'Neutral_DOM', 	'DynamicResident');

------------------------------
-- Audio_2DSounds
------------------------------
INSERT INTO Audio_2DSounds
		(ScriptID, 					SoundID, 					SoundType, 		MinVolume, 	MaxVolume)
VALUES 	('AS2D_DOM_SPEECH_NEUTRAL','SND_DOM_SPEECH_NEUTRAL', 	'GAME_SPEECH', 	70, 		70);

--==========================================================================================================================
-- UNIT GRAPHICS
--==========================================================================================================================
-- ArtDefine_LandmarkTypes
------------------------------
INSERT INTO ArtDefine_LandmarkTypes 
		(Type,							LandmarkType,	FriendlyName) 
VALUES	('ART_DEF_RESOURCE_LIME_FLINT',	'Resource',		'Flint');

------------------------------
-- ArtDefine_Landmarks
------------------------------
INSERT INTO ArtDefine_Landmarks 
		(Era,				State,					Scale,	ImprovementType,			LayoutHandler,	ResourceType,					Model,																								TerrainContour)
VALUES	('Any',				'Any',					1,		'ART_DEF_IMPROVEMENT_NONE',	'SNAPSHOT',		'ART_DEF_RESOURCE_LIME_FLINT',	'Flint.fxsxml',																					1),
		('Ancient',			'Constructed',			1,		'ART_DEF_IMPROVEMENT_MINE',	'SNAPSHOT',		'ART_DEF_RESOURCE_LIME_FLINT',	'Assets/Buildings/Improvements/Mine/Medieval/Hill/Mine_Med_hill_iron/MED_Mine_Iron.fxsxml',			1),
		('Ancient',			'UnderConstruction',	1,		'ART_DEF_IMPROVEMENT_MINE',	'SNAPSHOT',		'ART_DEF_RESOURCE_LIME_FLINT',	'Assets/Buildings/Improvements/Mine/Medieval/Hill/Mine_Med_hill_iron/HB_MED_Mine_Iron.fxsxml',		1),
		('Ancient',			'Pillaged',				1,		'ART_DEF_IMPROVEMENT_MINE',	'SNAPSHOT',		'ART_DEF_RESOURCE_LIME_FLINT',	'Assets/Buildings/Improvements/Mine/Medieval/Hill/Mine_Med_hill_iron/PL_MED_Mine_Iron.fxsxml',		1),
		('Industrial',		'Constructed',			1,		'ART_DEF_IMPROVEMENT_MINE',	'SNAPSHOT',		'ART_DEF_RESOURCE_LIME_FLINT',	'Assets/Buildings/Improvements/Mine/Modern/Hill/Mine_Mod_hill_iron/IND_Mine_Iron.fxsxml',			1),
		('Industrial',		'UnderConstruction',	1,		'ART_DEF_IMPROVEMENT_MINE',	'SNAPSHOT',		'ART_DEF_RESOURCE_LIME_FLINT',	'Assets/Buildings/Improvements/Mine/Modern/Hill/Mine_Mod_hill_iron/HB_IND_Mine_Iron.fxsxml',		1),
		('Industrial',		'Pillaged',				1,		'ART_DEF_IMPROVEMENT_MINE',	'SNAPSHOT',		'ART_DEF_RESOURCE_LIME_FLINT',	'Assets/Buildings/Improvements/Mine/Modern/Hill/Mine_Mod_hill_iron/PL_IND_Mine_Iron.fxsxml',		1);	

------------------------------
-- ArtDefine_StrategicView
------------------------------
INSERT INTO ArtDefine_StrategicView 
		(StrategicViewType, 				TileType,		Asset)
VALUES	('ART_DEF_UNIT_EW_CHONNONTON', 		'Unit', 		'SV_Chonnonton.dds'),
		('ART_DEF_RESOURCE_LIME_FLINT', 	'Resource', 	'sv_Flint.dds');

------------------------------
-- ArtDefine_UnitInfos
------------------------------
INSERT INTO ArtDefine_UnitInfos
		(Type, 							DamageStates,	Formation)
SELECT	'ART_DEF_UNIT_EW_CHONNONTON',	DamageStates,	Formation
FROM ArtDefine_UnitInfos WHERE (Type = 'ART_DEF_UNIT_U_IROQUOIAN_MOHAWKWARRIOR');

------------------------------
-- ArtDefine_UnitMemberInfos
------------------------------
INSERT INTO ArtDefine_UnitMemberInfos 	
			(Type, 										Scale,  ZOffset, Domain, Model, 				MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT		'ART_DEF_UNIT_MEMBER_EW_CHONNONTON',		Scale,	ZOffset, Domain, 'Chonnonton.fxsxml',	MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE Type = 'ART_DEF_UNIT_MEMBER_U_IROQUOIAN_MOHAWKWARRIOR';

------------------------------
-- ArtDefine_UnitInfoMemberInfos
------------------------------
INSERT INTO ArtDefine_UnitInfoMemberInfos
		(UnitInfoType,					UnitMemberInfoType,					NumMembers)
SELECT	'ART_DEF_UNIT_EW_CHONNONTON', 'ART_DEF_UNIT_MEMBER_EW_CHONNONTON', 	NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE UnitInfoType = 'ART_DEF_UNIT_U_IROQUOIAN_MOHAWKWARRIOR';

------------------------------
-- ArtDefine_UnitMemberCombats
------------------------------
INSERT INTO ArtDefine_UnitMemberCombats 
			(UnitMemberType,						EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT		'ART_DEF_UNIT_MEMBER_EW_CHONNONTON',	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_U_IROQUOIAN_MOHAWKWARRIOR';

------------------------------
-- ArtDefine_UnitMemberCombatWeapons
------------------------------
INSERT INTO ArtDefine_UnitMemberCombatWeapons	
			(UnitMemberType,						"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT		'ART_DEF_UNIT_MEMBER_EW_CHONNONTON',	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_U_IROQUOIAN_MOHAWKWARRIOR';
