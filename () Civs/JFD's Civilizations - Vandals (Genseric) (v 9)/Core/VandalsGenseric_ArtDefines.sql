--==========================================================================================================================
-- ART DEFINES
--==========================================================================================================================	
-- ArtDefine_StrategicView
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO ArtDefine_StrategicView 
		(StrategicViewType, 				TileType,	Asset)
VALUES	('ART_DEF_UNIT_JFD_ALANI_HORSEMAN', 'Unit', 	'sv_AlaniHorseman.dds'),
		('ART_DEF_UNIT_JFD_TRIHEMIOLA', 	'Unit', 	'sv_Trihemiolia.dds');
--------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_UnitInfos
--------------------------------------------------------------------------------------------------------------------------			
INSERT INTO ArtDefine_UnitInfos 
		(Type, 									DamageStates,	Formation)
SELECT	'ART_DEF_UNIT_JFD_ALANI_HORSEMAN', 		DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE Type = 'ART_DEF_UNIT_HORSEMAN';

INSERT INTO ArtDefine_UnitInfos 
		(Type, 									DamageStates,	Formation)
SELECT	'ART_DEF_UNIT_JFD_TRIHEMIOLA',			DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE Type = 'ART_DEF_UNIT_TRIREME';
--------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_UnitInfos
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO ArtDefine_UnitInfoMemberInfos 	
		(UnitInfoType,							UnitMemberInfoType,							NumMembers)
SELECT	'ART_DEF_UNIT_JFD_ALANI_HORSEMAN', 		'ART_DEF_UNIT_MEMBER_JFD_ALANI_HORSEMAN', 	NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE UnitInfoType = 'ART_DEF_UNIT_HORSEMAN';

INSERT INTO ArtDefine_UnitInfoMemberInfos 	
		(UnitInfoType,							UnitMemberInfoType,							NumMembers)
SELECT	'ART_DEF_UNIT_JFD_TRIHEMIOLA', 			'ART_DEF_UNIT_MEMBER_JFD_TRIHEMIOLA',		NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE UnitInfoType = 'ART_DEF_UNIT_TRIREME';
--------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_UnitInfos
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO ArtDefine_UnitMemberCombats 
		(UnitMemberType,							EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT	'ART_DEF_UNIT_MEMBER_JFD_ALANI_HORSEMAN',	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_HORSEMAN';

INSERT INTO ArtDefine_UnitMemberCombats 
		(UnitMemberType,							EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT	'ART_DEF_UNIT_MEMBER_JFD_TRIHEMIOLA',		EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_TRIREME';
--------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_UnitMemberCombatWeapons
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO ArtDefine_UnitMemberCombatWeapons	
		(UnitMemberType,							"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_JFD_ALANI_HORSEMAN',	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_HORSEMAN';

INSERT INTO ArtDefine_UnitMemberCombatWeapons	
		(UnitMemberType,							"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_JFD_TRIHEMIOLA',		"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_TRIREME';
--------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_UnitInfos
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO ArtDefine_UnitMemberInfos 	
		(Type, 										Scale,		ZOffset, Domain, Model, 					MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_JFD_ALANI_HORSEMAN',	Scale,		ZOffset, Domain, 'Horseman_Turkey.fxsxml',	MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE Type = 'ART_DEF_UNIT_MEMBER_HORSEMAN';

INSERT INTO ArtDefine_UnitMemberInfos 	
		(Type, 										Scale,		ZOffset, Domain, Model,								MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_JFD_TRIHEMIOLA',		Scale+0.01,	ZOffset, Domain, 'U_Carthage_Quinquereme.fxsxml',	MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE Type = 'ART_DEF_UNIT_MEMBER_TRIREME';
--==========================================================================================================================
-- AUDIO
--==========================================================================================================================	
--------------------------------------------------------------------------------------------------------------------------
-- Audio_Sounds
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Audio_Sounds 
		(SoundID, 										Filename, 						LoadType)
VALUES	('SND_LEADER_MUSIC_JFD_VANDALS_GENSERIC_PEACE',	 'JFD_VandalsGenseric_Peace', 	'DynamicResident'),
		('SND_LEADER_MUSIC_JFD_VANDALS_GENSERIC_WAR', 	 'JFD_VandalsGenseric_War', 	'DynamicResident');			
--------------------------------------------------------------------------------------------------------------------------
-- Audio_2DSounds
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Audio_2DSounds 
		(ScriptID, 												SoundID, 										SoundType, 		TaperSoundtrackVolume,	MinVolume, 	MaxVolume,  IsMusic, Looping)
VALUES	('AS2D_AMBIENCE_LEADER_JFD_VANDALS_GENSERIC_AMBIENCE',	'SND_AMBIENCE_COAST_BED', 						'GAME_SFX', 	0.0,					15, 		15, 		0, 		 1),
		('AS2D_LEADER_MUSIC_JFD_VANDALS_GENSERIC_PEACE',		'SND_LEADER_MUSIC_JFD_VANDALS_GENSERIC_PEACE', 	'GAME_MUSIC',	-1.0,					45, 		45, 		1, 		 0),
		('AS2D_LEADER_MUSIC_JFD_VANDALS_GENSERIC_WAR', 			'SND_LEADER_MUSIC_JFD_VANDALS_GENSERIC_WAR', 	'GAME_MUSIC',	-1.0,					45, 		45, 		1,		 0);
--==========================================================================================================================
-- COLOURS
--==========================================================================================================================	
--------------------------------------------------------------------------------------------------------------------------
-- Colors
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Colors 
		(Type, 												Red, 	Green, 	Blue, 	Alpha)
VALUES	('COLOR_PLAYER_JFD_VANDALS_GENSERIC_ICON', 			0.341, 	0.066,	0, 		1),
		('COLOR_PLAYER_JFD_VANDALS_GENSERIC_BACKGROUND',	0.85,	0.61,	0.42, 	1);
--------------------------------------------------------------------------------------------------------------------------
-- PlayerColors
--------------------------------------------------------------------------------------------------------------------------				
INSERT INTO PlayerColors 
		(Type, 									PrimaryColor, 								SecondaryColor, 									TextColor)
VALUES	('PLAYERCOLOR_JFD_VANDALS_GENSERIC',	'COLOR_PLAYER_JFD_VANDALS_GENSERIC_ICON', 	'COLOR_PLAYER_JFD_VANDALS_GENSERIC_BACKGROUND', 	'COLOR_PLAYER_WHITE_TEXT');
--==========================================================================================================================
-- ICON ATLASES
--==========================================================================================================================	
--------------------------------------------------------------------------------------------------------------------------
-- IconTextureAtlases
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO IconTextureAtlases 
		(Atlas, 									IconSize, 	Filename, 									IconsPerRow, 	IconsPerColumn)
VALUES	('JFD_VANDALS_GENSERIC_ALPHA_ATLAS', 		128, 		'JFD_VandalsGenseric_AlphaAtlas_128.dds',	2, 				2),
		('JFD_VANDALS_GENSERIC_ALPHA_ATLAS', 		80, 		'JFD_VandalsGenseric_AlphaAtlas_80.dds',	1, 				1),
		('JFD_VANDALS_GENSERIC_ALPHA_ATLAS', 		64, 		'JFD_VandalsGenseric_AlphaAtlas_64.dds',	1, 				1),
		('JFD_VANDALS_GENSERIC_ALPHA_ATLAS', 		48, 		'JFD_VandalsGenseric_AlphaAtlas_48.dds',	1, 				1),
		('JFD_VANDALS_GENSERIC_ALPHA_ATLAS', 		45, 		'JFD_VandalsGenseric_AlphaAtlas_45.dds',	1, 				1),
		('JFD_VANDALS_GENSERIC_ALPHA_ATLAS', 		32, 		'JFD_VandalsGenseric_AlphaAtlas_32.dds',	1, 				1),
		('JFD_VANDALS_GENSERIC_ALPHA_ATLAS', 		24, 		'JFD_VandalsGenseric_AlphaAtlas_24.dds',	1, 				1),
		('JFD_VANDALS_GENSERIC_ALPHA_ATLAS', 		16, 		'JFD_VandalsGenseric_AlphaAtlas_16.dds',	1, 				1),
		('JFD_VANDALS_GENSERIC_ICON_ATLAS', 		256, 		'JFD_VandalsGenseric_IconAtlas_256.dds',	4, 				1),
		('JFD_VANDALS_GENSERIC_ICON_ATLAS', 		128, 		'JFD_VandalsGenseric_IconAtlas_128.dds',	4, 				1),
		('JFD_VANDALS_GENSERIC_ICON_ATLAS', 		80, 		'JFD_VandalsGenseric_IconAtlas_80.dds',		4, 				1),
		('JFD_VANDALS_GENSERIC_ICON_ATLAS', 		64, 		'JFD_VandalsGenseric_IconAtlas_64.dds',		4, 				1),
		('JFD_VANDALS_GENSERIC_ICON_ATLAS', 		45, 		'JFD_VandalsGenseric_IconAtlas_45.dds',		4, 				1),
		('JFD_VANDALS_GENSERIC_ICON_ATLAS', 		32, 		'JFD_VandalsGenseric_IconAtlas_32.dds',		4, 				1),
		('JFD_VANDALS_GENSERIC_PROMOTION_ATLAS',	256, 	    'Tomatekh_PromotionAtlas_256.dds',			2, 				1),
		('JFD_VANDALS_GENSERIC_PROMOTION_ATLAS',	64, 	    'Tomatekh_PromotionAtlas_64.dds',			2, 				1),
		('JFD_VANDALS_GENSERIC_PROMOTION_ATLAS',	45, 	    'Tomatekh_PromotionAtlas_45.dds',			2, 				1),
		('JFD_VANDALS_GENSERIC_PROMOTION_ATLAS',	32, 	    'Tomatekh_PromotionAtlas_32.dds',			2, 				1),
		('JFD_VANDALS_GENSERIC_UNIT_FLAG_ATLAS',	32, 		'JFD_VandalsGenseric_UnitFlagAtlas_32.dds',	1, 				1);
--==========================================================================================================================	
--==========================================================================================================================	
