--================================================================
-- Audio
--================================================================

INSERT INTO Audio_Sounds
		(SoundID,										Filename,			LoadType)
VALUES	('SND_LEADER_MUSIC_JWW_ANTONIO_CANALES_PEACE',	'RioGrande_Peace',	'DynamicResident'),
		('SND_LEADER_MUSIC_JWW_ANTONIO_CANALES_WAR',	'RioGrande_War',	'DynamicResident');

INSERT INTO Audio_2DSounds
		(ScriptID,												SoundID,										SoundType,		TaperSoundtrackVolume,	MinVolume,	MaxVolume,	IsMusic,	Looping)
VALUES	('AS2D_LEADER_MUSIC_JWW_ANTONIO_CANALES_PEACE',			'SND_LEADER_MUSIC_JWW_ANTONIO_CANALES_PEACE',	'GAME_MUSIC',	-1.0,					60,			60,			1,			0),
		('AS2D_LEADER_MUSIC_JWW_ANTONIO_CANALES_WAR',			'SND_LEADER_MUSIC_JWW_ANTONIO_CANALES_WAR',		'GAME_MUSIC',	-1.0,					90,			90,			1,			0);

--================================================================
-- Colors
--================================================================

INSERT INTO PlayerColors
		(Type,							PrimaryColor,							SecondaryColor,								TextColor)
VALUES	('PLAYERCOLOR_JWW_RIO_GRANDE',	'COLOR_PLAYER_JWW_RIO_GRANDE_ICON',		'COLOR_PLAYER_JWW_RIO_GRANDE_BACKGROUND',	'COLOR_PLAYER_WHITE_TEXT');

INSERT INTO Colors
		(Type,										Red,		Green,		Blue,		Alpha)
VALUES	('COLOR_PLAYER_JWW_RIO_GRANDE_ICON',		0.506,		0.071,		0.125,		1.0),
		('COLOR_PLAYER_JWW_RIO_GRANDE_BACKGROUND',	0.871,		0.600,		0.600,		1.0);

--================================================================
-- Atlases
--================================================================

INSERT INTO IconTextureAtlases
		(Atlas,							IconSize,		Filename,						IconsPerRow,	IconsPerColumn)
VALUES	('RIOGRANDE_COLOR_ATLAS',		'256',			'RioGrandeIconAtlas256.dds',	3,				2),
		('RIOGRANDE_COLOR_ATLAS',		'128',			'RioGrandeIconAtlas128.dds',	3,				2),
		('RIOGRANDE_COLOR_ATLAS',		'80',			'RioGrandeIconAtlas80.dds',		3,				2),
		('RIOGRANDE_COLOR_ATLAS',		'64',			'RioGrandeIconAtlas64.dds',		3,				2),
		('RIOGRANDE_COLOR_ATLAS',		'48',			'RioGrandeIconAtlas48.dds',		3,				2),
		('RIOGRANDE_COLOR_ATLAS',		'45',			'RioGrandeIconAtlas45.dds',		3,				2),
		('RIOGRANDE_COLOR_ATLAS',		'32',			'RioGrandeIconAtlas32.dds',		3,				2),
		('RIOGRANDE_COLOR_ATLAS',		'24',			'RioGrandeIconAtlas24.dds',		3,				2),
		('RIOGRANDE_COLOR_ATLAS',		'16',			'RioGrandeIconAtlas16.dds',		3,				2),
		('RIOGRANDE_ALPHA_ATLAS',		'256',			'RioGrandeIconAtlas256.dds',	1,				2),
		('RIOGRANDE_ALPHA_ATLAS',		'128',			'RioGrandeIconAtlas128.dds',	1,				2),
		('RIOGRANDE_ALPHA_ATLAS',		'80',			'RioGrandeIconAtlas80.dds',		1,				2),
		('RIOGRANDE_ALPHA_ATLAS',		'64',			'RioGrandeIconAtlas64.dds',		1,				2),
		('RIOGRANDE_ALPHA_ATLAS',		'48',			'RioGrandeIconAtlas48.dds',		1,				2),
		('RIOGRANDE_ALPHA_ATLAS',		'45',			'RioGrandeIconAtlas45.dds',		1,				2),
		('RIOGRANDE_ALPHA_ATLAS',		'32',			'RioGrandeIconAtlas32.dds',		1,				2),
		('RIOGRANDE_ALPHA_ATLAS',		'24',			'RioGrandeIconAtlas24.dds',		1,				2),
		('RIOGRANDE_ALPHA_ATLAS',		'16',			'RioGrandeIconAtlas16.dds',		1,				2),
		('RIO_GRANDE_UNIT_ALPHA_ATLAS',	'256',			'VaqueroAlpha256.dds',			1,				1),
		('RIO_GRANDE_UNIT_ALPHA_ATLAS',	'32',			'VaqueroAlpha32.dds',			1,				1);

--================================================================
-- Art Defines
--================================================================
 
INSERT INTO ArtDefine_UnitInfos
        (TYPE,                      DamageStates,   Formation)
SELECT  'ART_DEF_UNIT_JWW_VAQUERO', DamageStates,   Formation
FROM ArtDefine_UnitInfos WHERE (TYPE = 'ART_DEF_UNIT_CAVALRY');
 
INSERT INTO ArtDefine_UnitInfoMemberInfos
        (UnitInfoType,                  UnitMemberInfoType,                 NumMembers)
SELECT  'ART_DEF_UNIT_JWW_VAQUERO', 'ART_DEF_UNIT_MEMBER_JWW_VAQUERO',  NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_CAVALRY');
 
INSERT INTO ArtDefine_UnitMemberCombats
        (UnitMemberType,                    EnableActions,  DisableActions, MoveRadius, ShortMoveRadius,    ChargeRadius,   AttackRadius,   RangedAttackRadius, MoveRate,   ShortMoveRate,  TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT  'ART_DEF_UNIT_MEMBER_JWW_VAQUERO',  EnableActions,  DisableActions, MoveRadius, ShortMoveRadius,    ChargeRadius,   AttackRadius,   RangedAttackRadius, MoveRate,   ShortMoveRate,  TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_CAVALRY');
 
INSERT INTO ArtDefine_UnitMemberCombatWeapons
        (UnitMemberType,                        "Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT  'ART_DEF_UNIT_MEMBER_JWW_VAQUERO',  "Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_CAVALRY');
 
INSERT INTO ArtDefine_UnitMemberInfos
        (TYPE,                                  Scale,  ZOffset, DOMAIN, Model,             MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT  'ART_DEF_UNIT_MEMBER_JWW_VAQUERO',  Scale,  ZOffset, DOMAIN, 'vaquero.fxsxml',  MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE (TYPE = 'ART_DEF_UNIT_MEMBER_CAVALRY');
 
INSERT INTO ArtDefine_StrategicView
        (StrategicViewType,             TileType,   Asset)
VALUES  ('ART_DEF_UNIT_JWW_VAQUERO',        'Unit',     'Vaquero_sv.dds');
 
--================================================================
--================================================================