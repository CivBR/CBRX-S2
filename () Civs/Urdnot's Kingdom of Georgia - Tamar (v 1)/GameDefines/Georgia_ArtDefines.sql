--==========================================================================================================================
-- ART DEFINES
--==========================================================================================================================	
-- ArtDefine_StrategicView
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO ArtDefine_StrategicView 
		(StrategicViewType, 					TileType,		Asset)
VALUES	('ART_DEF_UNIT_US_TADZREULI',			'Unit', 		'sv_Tadzreuli.dds');
--------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_UnitInfos
--------------------------------------------------------------------------------------------------------------------------			
INSERT INTO ArtDefine_UnitInfos 
		(Type, 									DamageStates,	Formation)
SELECT	'ART_DEF_UNIT_US_TADZREULI',			DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE Type = 'ART_DEF_UNIT_KNIGHT';	
--------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_UnitInfoMemberInfos
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO ArtDefine_UnitInfoMemberInfos 	
		(UnitInfoType,							UnitMemberInfoType,							NumMembers)
SELECT	'ART_DEF_UNIT_US_TADZREULI', 			'ART_DEF_UNIT_MEMBER_JFD_TADZREULI',		NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE UnitInfoType = 'ART_DEF_UNIT_KNIGHT';
--------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_UnitMemberCombats
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO ArtDefine_UnitMemberCombats 
		(UnitMemberType,						EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT	'ART_DEF_UNIT_MEMBER_JFD_TADZREULI',	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_KNIGHT';
--------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_UnitMemberCombatWeapons
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO ArtDefine_UnitMemberCombatWeapons	
		(UnitMemberType,						"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_JFD_TADZREULI',	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_KNIGHT';
--------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_UnitMemberInfos
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO ArtDefine_UnitMemberInfos 	
		(Type, 									Scale,	ZOffset, Domain, Model, 			MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_JFD_TADZREULI',	Scale,	ZOffset, Domain, 'knight.fxsxml',	MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE Type = 'ART_DEF_UNIT_MEMBER_KNIGHT';
--==========================================================================================================================
-- AUDIO
--==========================================================================================================================	
-- Audio_Sounds
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Audio_Sounds 
		(SoundID, 										Filename, 									LoadType)
VALUES	('SND_LEADER_MUSIC_US_TAMAR_PEACE', 			'Tamar_Peace',								'DynamicResident'),
		('SND_LEADER_MUSIC_US_TAMAR_WAR', 				'Tamar_War', 								'DynamicResident');		
--------------------------------------------------------------------------------------------------------------------------
-- Audio_2DSounds
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Audio_2DSounds 
		(ScriptID, 										SoundID, 									SoundType, 		TaperSoundtrackVolume,	MinVolume, 	MaxVolume,  IsMusic, Looping)
VALUES	('AS2D_AMBIENCE_LEADER_US_TAMAR_AMBIENCE',		'SND_AMBIENCE_HARUN_AL_RASHID_AMBIENCE', 	'GAME_SFX', 	0.0,					50, 		50, 		0, 		 1),
		('AS2D_LEADER_MUSIC_US_TAMAR_PEACE', 			'SND_LEADER_MUSIC_US_TAMAR_PEACE', 			'GAME_MUSIC', 	-1.0,					45, 		45, 		1, 		 0),
		('AS2D_LEADER_MUSIC_US_TAMAR_WAR', 				'SND_LEADER_MUSIC_US_TAMAR_WAR', 			'GAME_MUSIC', 	-1.0,					45, 		45, 		1,		 0);
--==========================================================================================================================
-- COLOURS
--==========================================================================================================================	
-- Colors
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Colors 
		(Type, 									Red, 	Green, 	Blue, 	Alpha)
VALUES	('COLOR_PLAYER_US_GEORGIA_ICON', 		0.607,	0.266,	0.137,	1),
		('COLOR_PLAYER_US_GEORGIA_BACKGROUND',	0.627,	0.729,	0.717,	1);
--------------------------------------------------------------------------------------------------------------------------
-- PlayerColors
--------------------------------------------------------------------------------------------------------------------------			
INSERT INTO PlayerColors 
		(Type, 							PrimaryColor, 						SecondaryColor, 						TextColor)
VALUES	('PLAYERCOLOR_US_GEORGIA',		'COLOR_PLAYER_US_GEORGIA_ICON',		'COLOR_PLAYER_US_GEORGIA_BACKGROUND',	'COLOR_PLAYER_WHITE_TEXT');
--==========================================================================================================================
-- ICON ATLASES
--==========================================================================================================================	
-- IconTextureAtlases
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO IconTextureAtlases 
		(Atlas, 						IconSize, 	Filename, 							IconsPerRow, 	IconsPerColumn)
VALUES	('US_GEORGIA_ATLAS', 			256, 		'georgia_alpha_256.dds',			2, 				2),
		('US_GEORGIA_ATLAS', 			128, 		'georgia_alpha_128.dds',			2, 				2),
		('US_GEORGIA_ATLAS', 			80, 		'georgia_alpha_80.dds',				2, 				2),
		('US_GEORGIA_ATLAS', 			64, 		'georgia_alpha_64.dds',				2, 				2),
		('US_GEORGIA_ATLAS', 			45, 		'georgia_alpha_45.dds',				2, 				2),
		('US_GEORGIA_ATLAS', 			32, 		'georgia_alpha_32.dds',				2, 				2),
		('US_GEORGIA_ALPHA_ATLAS', 		128, 		'georgia_alpha_icon_128.dds',		1,				1),
		('US_GEORGIA_ALPHA_ATLAS', 		80, 		'georgia_alpha_icon_80.dds',		1, 				1),
		('US_GEORGIA_ALPHA_ATLAS', 		64, 		'georgia_alpha_icon_64.dds',		1, 				1),
		('US_GEORGIA_ALPHA_ATLAS', 		48, 		'georgia_alpha_icon_48.dds',		1, 				1),
		('US_GEORGIA_ALPHA_ATLAS', 		45, 		'georgia_alpha_icon_45.dds',		1, 				1),
		('US_GEORGIA_ALPHA_ATLAS', 		32, 		'georgia_alpha_icon_32.dds',		1, 				1),
		('US_GEORGIA_ALPHA_ATLAS', 		24, 		'georgia_alpha_icon_24.dds',		1, 				1),
		('US_GEORGIA_ALPHA_ATLAS', 		16, 		'georgia_alpha_icon_16.dds',		1, 				1),
		('US_GEORGIA_PROMOTION_ATLAS',	256, 	    'Tomatekh_PromotionAtlas_256.dds',	2, 				1),
		('US_GEORGIA_PROMOTION_ATLAS',	64, 	    'Tomatekh_PromotionAtlas_64.dds',	2, 				1),
		('US_GEORGIA_PROMOTION_ATLAS',	45, 	    'Tomatekh_PromotionAtlas_45.dds',	2, 				1),
		('US_GEORGIA_PROMOTION_ATLAS',	32, 	    'Tomatekh_PromotionAtlas_32.dds',	2, 				1),
		('US_GEORGIA_FLAG_ATLAS',		32, 		'TadzreuliFlag.dds',				1, 				1);
--==========================================================================================================================	
--==========================================================================================================================	
