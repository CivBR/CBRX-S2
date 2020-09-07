--=======================================================================================================================
-- ART DEFINES
--=======================================================================================================================	
------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_StrategicView
------------------------------------------------------------------------------------------------------------------------
INSERT INTO ArtDefine_StrategicView 
		(StrategicViewType, 				TileType,	Asset)
VALUES	('ART_DEF_UNIT_JFD_POPULAR_LEVY',	'Unit', 	'sv_PopularLevy.dds');
------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_UnitInfos
------------------------------------------------------------------------------------------------------------------------		
INSERT INTO ArtDefine_UnitInfos 
		(Type, 								DamageStates,	Formation)
SELECT	'ART_DEF_UNIT_JFD_POPULAR_LEVY', 	DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE Type = 'ART_DEF_UNIT_WW1_INFANTRY'; 
------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_UnitInfoMemberInfos
------------------------------------------------------------------------------------------------------------------------
INSERT INTO ArtDefine_UnitInfoMemberInfos 	
		(UnitInfoType,						UnitMemberInfoType,						NumMembers)
SELECT	'ART_DEF_UNIT_JFD_POPULAR_LEVY', 	'ART_DEF_UNIT_MEMBER_JFD_POPULAR_LEVY', NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE UnitInfoType = 'ART_DEF_UNIT_WW1_INFANTRY';
------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_UnitMemberCombats
------------------------------------------------------------------------------------------------------------------------
INSERT INTO ArtDefine_UnitMemberCombats 
		(UnitMemberType,						EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT	'ART_DEF_UNIT_MEMBER_JFD_POPULAR_LEVY',	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_WW1_INFANTRY';
------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_UnitMemberCombatWeapons
------------------------------------------------------------------------------------------------------------------------
INSERT INTO ArtDefine_UnitMemberCombatWeapons	
		(UnitMemberType,						"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_JFD_POPULAR_LEVY',	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_WW1_INFANTRY';
------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_UnitMemberInfos
------------------------------------------------------------------------------------------------------------------------
INSERT INTO ArtDefine_UnitMemberInfos 	
		(Type, 									Scale, ZOffset, Domain, Model, 							 MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_JFD_POPULAR_LEVY',	Scale, ZOffset, Domain, 'Paratrooper_Russia_MG.fxsxml',  MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE Type = 'ART_DEF_UNIT_MEMBER_WW1_INFANTRY';
--=======================================================================================================================
-- AUDIO
--=======================================================================================================================	
------------------------------------------------------------------------------------------------------------------------
-- Audio_Sounds
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Audio_Sounds 
		(SoundID, 												Filename, 							LoadType)
VALUES	('SND_LEADER_MUSIC_JFD_SOVIET_RUSSIA_LENIN_PEACE', 		'JFD_SovietRussiaLenin_Peace',		'DynamicResident'),
		('SND_LEADER_MUSIC_JFD_SOVIET_RUSSIA_LENIN_WAR', 		'JFD_SovietRussiaLenin_War', 		'DynamicResident');		
------------------------------------------------------------------------------------------------------------------------
-- Audio_2DSounds
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Audio_2DSounds 
		(ScriptID, 												SoundID, 											SoundType, 		TaperSoundtrackVolume,	MinVolume, 	MaxVolume,	IsMusic, Looping)
VALUES	('AS2D_LEADER_MUSIC_JFD_SOVIET_RUSSIA_LENIN_PEACE', 	'SND_LEADER_MUSIC_JFD_SOVIET_RUSSIA_LENIN_PEACE',	'GAME_MUSIC', 	-1.0,					50, 		50, 		1, 		 0),
		('AS2D_LEADER_MUSIC_JFD_SOVIET_RUSSIA_LENIN_WAR', 		'SND_LEADER_MUSIC_JFD_SOVIET_RUSSIA_LENIN_WAR', 	'GAME_MUSIC', 	-1.0,					50, 		50, 		1,		 0);
--=======================================================================================================================
-- COLOURS
--=======================================================================================================================	
------------------------------------------------------------------------------------------------------------------------
-- Colors
------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Colors 
		(Type, 													Red, 	Green, 	Blue,   Alpha)
VALUES	('COLOR_PLAYER_JFD_SOVIET_RUSSIA_LENIN_ICON', 			0.870, 	0.839, 	0, 		1),
		('COLOR_PLAYER_JFD_SOVIET_RUSSIA_LENIN_BACKGROUND', 	0.690,	0.113,	0.113, 	1);
------------------------------------------------------------------------------------------------------------------------
-- PlayerColors
------------------------------------------------------------------------------------------------------------------------			
INSERT INTO PlayerColors 
		(Type, 										PrimaryColor, 									SecondaryColor, 									TextColor)
VALUES	('PLAYERCOLOR_JFD_SOVIET_RUSSIA_LENIN',		'COLOR_PLAYER_JFD_SOVIET_RUSSIA_LENIN_ICON',	'COLOR_PLAYER_JFD_SOVIET_RUSSIA_LENIN_BACKGROUND',	'COLOR_PLAYER_WHITE_TEXT');
--=======================================================================================================================
-- ICON ATLASES
--=======================================================================================================================	
------------------------------------------------------------------------------------------------------------------------
-- IconTextureAtlases
------------------------------------------------------------------------------------------------------------------------
INSERT INTO IconTextureAtlases 
		(Atlas, 										IconSize, 	Filename, 										IconsPerRow, 	IconsPerColumn)
VALUES	('JFD_SOVIET_RUSSIA_LENIN_ALPHA_ATLAS',			128, 		'JFD_SovietRussiaLenin_AlphaAtlas_128.dds',		1,				1),
		('JFD_SOVIET_RUSSIA_LENIN_ALPHA_ATLAS',			80, 		'JFD_SovietRussiaLenin_AlphaAtlas_80.dds',		1, 				1),
		('JFD_SOVIET_RUSSIA_LENIN_ALPHA_ATLAS',			64, 		'JFD_SovietRussiaLenin_AlphaAtlas_64.dds',		1, 				1),
		('JFD_SOVIET_RUSSIA_LENIN_ALPHA_ATLAS',			48, 		'JFD_SovietRussiaLenin_AlphaAtlas_48.dds',		1, 				1),
		('JFD_SOVIET_RUSSIA_LENIN_ALPHA_ATLAS',			45, 		'JFD_SovietRussiaLenin_AlphaAtlas_45.dds',		1, 				1),
		('JFD_SOVIET_RUSSIA_LENIN_ALPHA_ATLAS',			32, 		'JFD_SovietRussiaLenin_AlphaAtlas_32.dds',		1, 				1),
		('JFD_SOVIET_RUSSIA_LENIN_ALPHA_ATLAS',			24, 		'JFD_SovietRussiaLenin_AlphaAtlas_24.dds',		1, 				1),
		('JFD_SOVIET_RUSSIA_LENIN_ALPHA_ATLAS',			16, 		'JFD_SovietRussiaLenin_AlphaAtlas_16.dds',		1, 				1),
		('JFD_SOVIET_RUSSIA_LENIN_ICON_ATLAS', 			256, 		'JFD_SovietRussiaLenin_IconAtlas_256.dds',		2, 				2),
		('JFD_SOVIET_RUSSIA_LENIN_ICON_ATLAS', 			128, 		'JFD_SovietRussiaLenin_IconAtlas_128.dds',		2, 				2),
		('JFD_SOVIET_RUSSIA_LENIN_ICON_ATLAS', 			80, 		'JFD_SovietRussiaLenin_IconAtlas_80.dds',		2, 				2),
		('JFD_SOVIET_RUSSIA_LENIN_ICON_ATLAS', 			64, 		'JFD_SovietRussiaLenin_IconAtlas_64.dds',		2, 				2),
		('JFD_SOVIET_RUSSIA_LENIN_ICON_ATLAS', 			45, 		'JFD_SovietRussiaLenin_IconAtlas_45.dds',		2, 				2),
		('JFD_SOVIET_RUSSIA_LENIN_ICON_ATLAS', 			32, 		'JFD_SovietRussiaLenin_IconAtlas_32.dds',		2, 				2),
		('JFD_SOVIET_RUSSIA_LENIN_UNIT_FLAG_ATLAS', 	32, 		'JFD_SovietRussiaLenin_UnitFlagAtlas_32.dds',	1, 				1);
--=======================================================================================================================	
--=======================================================================================================================	
