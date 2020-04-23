--==========================================================================================================================
-- ART DEFINES
--==========================================================================================================================	
--------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_StrategicView
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO ArtDefine_StrategicView 
		(StrategicViewType, 					TileType,	Asset)
VALUES	('ART_DEF_UNIT_JFD_UPARAJA',			'Unit', 	'sv_Uparaja.dds'),
		('ART_DEF_UNIT_JFD_UPARAJA_ELEPHANT',	'Unit', 	'sv_UparajaElephant.dds');
--------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_UnitInfos
--------------------------------------------------------------------------------------------------------------------------			
INSERT INTO ArtDefine_UnitInfos 
		(Type, 						 DamageStates,	Formation)
SELECT	'ART_DEF_UNIT_JFD_UPARAJA',	 DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE Type = 'ART_DEF_UNIT_U_SIAMESE_WARELEPHANT';	

INSERT INTO ArtDefine_UnitInfos 
		(Type, 									DamageStates, Formation)
SELECT	'ART_DEF_UNIT_JFD_UPARAJA_ELEPHANT',	DamageStates, Formation
FROM ArtDefine_UnitInfos WHERE Type = 'ART_DEF_UNIT_U_SIAMESE_WARELEPHANT';
--------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_UnitInfoMemberInfos
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO ArtDefine_UnitInfoMemberInfos 	
		(UnitInfoType,					UnitMemberInfoType,						NumMembers)
SELECT	'ART_DEF_UNIT_JFD_UPARAJA', 	'ART_DEF_UNIT_MEMBER_JFD_UPARAJA',		1
FROM ArtDefine_UnitInfoMemberInfos WHERE UnitInfoType = 'ART_DEF_UNIT_U_SIAMESE_WARELEPHANT';

INSERT INTO ArtDefine_UnitInfoMemberInfos 	
		(UnitInfoType,					UnitMemberInfoType,						NumMembers)
SELECT	'ART_DEF_UNIT_JFD_UPARAJA_ELEPHANT', 	'ART_DEF_UNIT_MEMBER_JFD_UPARAJA_ELEPHANT',	NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE UnitInfoType = 'ART_DEF_UNIT_U_SIAMESE_WARELEPHANT';
--------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_UnitMemberCombats
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO ArtDefine_UnitMemberCombats 
		(UnitMemberType,					EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT	'ART_DEF_UNIT_MEMBER_JFD_UPARAJA',	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_U_SIAMESE_WARELEPHANT';

INSERT INTO ArtDefine_UnitMemberCombats 
		(UnitMemberType,					EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT	'ART_DEF_UNIT_MEMBER_JFD_UPARAJA_ELEPHANT',EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_U_SIAMESE_WARELEPHANT';
--------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_UnitMemberCombatWeapons
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO ArtDefine_UnitMemberCombatWeapons	
		(UnitMemberType,					"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_JFD_UPARAJA',	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_U_SIAMESE_WARELEPHANT';

INSERT INTO ArtDefine_UnitMemberCombatWeapons	
		(UnitMemberType,							"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_JFD_UPARAJA_ELEPHANT',	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_U_SIAMESE_WARELEPHANT';
--------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_UnitMemberInfos
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO ArtDefine_UnitMemberInfos 	
		(Type, 								Scale,	ZOffset, Domain, Model, 			MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_JFD_UPARAJA',	Scale,	ZOffset, Domain, 'Uparaja.fxsxml',  MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE Type = 'ART_DEF_UNIT_MEMBER_U_SIAMESE_WARELEPHANT';	

INSERT INTO ArtDefine_UnitMemberInfos 	
		(Type, 										Scale,	ZOffset, Domain, Model, MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_JFD_UPARAJA_ELEPHANT',	Scale,	ZOffset, Domain, Model,	MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE Type = 'ART_DEF_UNIT_MEMBER_U_SIAMESE_WARELEPHANT';	
--==========================================================================================================================
-- AUDIO
--==========================================================================================================================	
--------------------------------------------------------------------------------------------------------------------------
-- Audio_Sounds
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Audio_Sounds 
		(SoundID, 								Filename, 			LoadType)
VALUES	('SND_LEADER_MUSIC_JFD_LAOS_PEACE',		'JFD_Laos_Peace',	'DynamicResident'),
		('SND_LEADER_MUSIC_JFD_LAOS_WAR', 		'JFD_Laos_War', 	'DynamicResident');		
--------------------------------------------------------------------------------------------------------------------------
-- Audio_2DSounds
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Audio_2DSounds 
		(ScriptID, 								SoundID, 							SoundType, 		TaperSoundtrackVolume,	MinVolume, 	MaxVolume,  IsMusic, Looping)
VALUES	('AS2D_LEADER_MUSIC_JFD_LAOS_PEACE',	'SND_LEADER_MUSIC_JFD_LAOS_PEACE', 	'GAME_MUSIC', 	-1.0,					45, 		45, 		1, 		 0),
		('AS2D_LEADER_MUSIC_JFD_LAOS_WAR', 		'SND_LEADER_MUSIC_JFD_LAOS_WAR', 	'GAME_MUSIC', 	-1.0,					45, 		45, 		1,		 0);
--==========================================================================================================================
-- COLOURS
--==========================================================================================================================	
--------------------------------------------------------------------------------------------------------------------------
-- Colors
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Colors 
		(Type, 									Red, 	Green, 	Blue, 	Alpha)
VALUES	('COLOR_PLAYER_JFD_LAOS_ICON', 			0.901,	0.811,	0.725,	1),
		('COLOR_PLAYER_JFD_LAOS_BACKGROUND',	0.505,	0.105,	0.105,	1);
--------------------------------------------------------------------------------------------------------------------------
-- PlayerColors
--------------------------------------------------------------------------------------------------------------------------			
INSERT INTO PlayerColors 
		(Type, 						PrimaryColor, 					SecondaryColor, 						TextColor)
VALUES	('PLAYERCOLOR_JFD_LAOS',	'COLOR_PLAYER_JFD_LAOS_ICON',	'COLOR_PLAYER_JFD_LAOS_BACKGROUND',		'COLOR_PLAYER_WHITE_TEXT');
--==========================================================================================================================
-- ICON ATLASES
--==========================================================================================================================	
--------------------------------------------------------------------------------------------------------------------------
-- IconTextureAtlases
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO IconTextureAtlases 
		(Atlas, 							IconSize, 	Filename, 								IconsPerRow, 	IconsPerColumn)
VALUES	('JFD_LAOS_ALPHA_ATLAS', 			128, 		'JFD_Laos_AlphaAtlas_128.dds',			1,				1),
		('JFD_LAOS_ALPHA_ATLAS', 			80, 		'JFD_Laos_AlphaAtlas_80.dds',			1, 				1),
		('JFD_LAOS_ALPHA_ATLAS', 			64, 		'JFD_Laos_AlphaAtlas_64.dds',			1, 				1),
		('JFD_LAOS_ALPHA_ATLAS', 			48, 		'JFD_Laos_AlphaAtlas_48.dds',			1, 				1),
		('JFD_LAOS_ALPHA_ATLAS', 			45, 		'JFD_Laos_AlphaAtlas_45.dds',			1, 				1),
		('JFD_LAOS_ALPHA_ATLAS', 			32, 		'JFD_Laos_AlphaAtlas_32.dds',			1, 				1),
		('JFD_LAOS_ALPHA_ATLAS', 			24, 		'JFD_Laos_AlphaAtlas_24.dds',			1, 				1),
		('JFD_LAOS_ALPHA_ATLAS', 			16, 		'JFD_Laos_AlphaAtlas_16.dds',			1, 				1),
		('JFD_LAOS_ICON_ATLAS', 			256, 		'JFD_Laos_IconAtlas_256.dds',			3, 				2),
		('JFD_LAOS_ICON_ATLAS', 			128, 		'JFD_Laos_IconAtlas_128.dds',			3, 				2),
		('JFD_LAOS_ICON_ATLAS', 			80, 		'JFD_Laos_IconAtlas_80.dds',			3, 				2),
		('JFD_LAOS_ICON_ATLAS', 			64, 		'JFD_Laos_IconAtlas_64.dds',			3, 				2),
		('JFD_LAOS_ICON_ATLAS', 			45, 		'JFD_Laos_IconAtlas_45.dds',			3, 				2),
		('JFD_LAOS_ICON_ATLAS', 			32, 		'JFD_Laos_IconAtlas_32.dds',			3, 				2),
		('JFD_LAOS_PROMOTION_ATLAS',		256, 	    'Tomatekh_PromotionAtlas_256.dds',		2, 				1),
		('JFD_LAOS_PROMOTION_ATLAS',		64, 	    'Tomatekh_PromotionAtlas_64.dds',		2, 				1),
		('JFD_LAOS_PROMOTION_ATLAS',		45, 	    'Tomatekh_PromotionAtlas_45.dds',		2, 				1),
		('JFD_LAOS_PROMOTION_ATLAS',		32, 	    'Tomatekh_PromotionAtlas_32.dds',		2, 				1),
		('JFD_LAOS_UNIT_FLAG_ATLAS',		32, 		'JFD_Laos_UnitFlagAtlas_32.dds',		2, 				1);
--==========================================================================================================================	
--==========================================================================================================================	
