--================================================================
-- Audio
--================================================================

INSERT INTO Audio_Sounds
		(SoundID,										Filename,			LoadType)
VALUES	('SND_LEADER_MUSIC_JWW_ISLAM_KARIMOV_PEACE',	'Uzbekistan_Peace',	'DynamicResident'),
		('SND_LEADER_MUSIC_JWW_ISLAM_KARIMOV_WAR',		'Uzbekistan_War',		'DynamicResident');

INSERT INTO Audio_2DSounds
		(ScriptID,											SoundID,									SoundType,		TaperSoundtrackVolume,	MinVolume,	MaxVolume,	IsMusic,	Looping)
VALUES	('AS2D_LEADER_MUSIC_JWW_ISLAM_KARIMOV_PEACE',		'SND_LEADER_MUSIC_JWW_ISLAM_KARIMOV_PEACE',	'GAME_MUSIC',	-1.0,					60,			60,			1,			0),
		('AS2D_LEADER_MUSIC_JWW_ISLAM_KARIMOV_WAR',			'SND_LEADER_MUSIC_JWW_ISLAM_KARIMOV_WAR',	'GAME_MUSIC',	-1.0,					90,			90,			1,			0);

--================================================================
-- Colors
--================================================================

INSERT INTO PlayerColors
		(Type,							PrimaryColor,							SecondaryColor,								TextColor)
VALUES	('PLAYERCOLOR_JWW_UZBEKISTAN',	'COLOR_PLAYER_JWW_UZBEKISTAN_ICON',		'COLOR_PLAYER_JWW_UZBEKISTAN_BACKGROUND',	'COLOR_PLAYER_WHITE_TEXT');

INSERT INTO Colors
		(Type,										Red,		Green,		Blue,		Alpha)
VALUES	('COLOR_PLAYER_JWW_UZBEKISTAN_ICON',		0.012,		0.141,		0.235,		1.0),
		('COLOR_PLAYER_JWW_UZBEKISTAN_BACKGROUND',	0.563,		0.741,		0.533,		1.0);

--================================================================
-- Atlases
--================================================================

INSERT INTO IconTextureAtlases
		(Atlas,							IconSize,		Filename,						IconsPerRow,	IconsPerColumn)
VALUES	('JWW_UZBEK_COLOR_ATLAS',		'256',			'UzbekIconAtlas256.dds',		3,				2),
		('JWW_UZBEK_COLOR_ATLAS',		'128',			'UzbekIconAtlas128.dds',		3,				2),
		('JWW_UZBEK_COLOR_ATLAS',		'80',			'UzbekIconAtlas80.dds',			3,				2),
		('JWW_UZBEK_COLOR_ATLAS',		'64',			'UzbekIconAtlas64.dds',			3,				2),
		('JWW_UZBEK_COLOR_ATLAS',		'48',			'UzbekIconAtlas48.dds',			3,				2),
		('JWW_UZBEK_COLOR_ATLAS',		'45',			'UzbekIconAtlas45.dds',			3,				2),
		('JWW_UZBEK_COLOR_ATLAS',		'32',			'UzbekIconAtlas32.dds',			3,				2),
		('JWW_UZBEK_COLOR_ATLAS',		'24',			'UzbekIconAtlas24.dds',			3,				2),
		('JWW_UZBEK_COLOR_ATLAS',		'16',			'UzbekIconAtlas16.dds',			3,				2),
		('JWW_UZBEK_ALPHA_ATLAS',		'256',			'UzbekIconAtlas256.dds',		1,				2),
		('JWW_UZBEK_ALPHA_ATLAS',		'128',			'UzbekIconAtlas128.dds',		1,				2),
		('JWW_UZBEK_ALPHA_ATLAS',		'80',			'UzbekIconAtlas80.dds',			1,				2),
		('JWW_UZBEK_ALPHA_ATLAS',		'64',			'UzbekIconAtlas64.dds',			1,				2),
		('JWW_UZBEK_ALPHA_ATLAS',		'48',			'UzbekIconAtlas48.dds',			1,				2),
		('JWW_UZBEK_ALPHA_ATLAS',		'45',			'UzbekIconAtlas45.dds',			1,				2),
		('JWW_UZBEK_ALPHA_ATLAS',		'32',			'UzbekIconAtlas32.dds',			1,				2),
		('JWW_UZBEK_ALPHA_ATLAS',		'24',			'UzbekIconAtlas24.dds',			1,				2),
		('JWW_UZBEK_ALPHA_ATLAS',		'16',			'UzbekIconAtlas16.dds',			1,				2),
		('JWW_UZBEK_UNIT_ALPHA_ATLAS',	'256',			'MaxsusIcon256.dds',			1,				1),
		('JWW_UZBEK_UNIT_ALPHA_ATLAS',	'32',			'MaxsusIcon32.dds',			1,				1);

--================================================================
-- Art Defines
--================================================================
 
INSERT INTO ArtDefine_UnitInfos
        (TYPE,                      DamageStates,   Formation)
SELECT  'ART_DEF_UNIT_JWW_MAXSUS_KUCHLAR', DamageStates,   Formation
FROM ArtDefine_UnitInfos WHERE (TYPE = 'ART_DEF_UNIT_CANNON');
 
INSERT INTO ArtDefine_UnitInfoMemberInfos
        (UnitInfoType,                  UnitMemberInfoType,                 NumMembers)
SELECT  'ART_DEF_UNIT_JWW_MAXSUS_KUCHLAR', 'ART_DEF_UNIT_MEMBER_JWW_MAXSUS_KUCHLAR',  NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_CANNON');
 
INSERT INTO ArtDefine_UnitMemberCombats
        (UnitMemberType,                    EnableActions,  DisableActions, MoveRadius, ShortMoveRadius,    ChargeRadius,   AttackRadius,   RangedAttackRadius, MoveRate,   ShortMoveRate,  TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT  'ART_DEF_UNIT_MEMBER_JWW_MAXSUS_KUCHLAR',  EnableActions,  DisableActions, MoveRadius, ShortMoveRadius,    ChargeRadius,   AttackRadius,   RangedAttackRadius, MoveRate,   ShortMoveRate,  TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_CANNON');
 
INSERT INTO ArtDefine_UnitMemberCombatWeapons
        (UnitMemberType,                        "Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT  'ART_DEF_UNIT_MEMBER_JWW_MAXSUS_KUCHLAR',  "Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_CANNON');
 
INSERT INTO ArtDefine_UnitMemberInfos
        (TYPE,                                  Scale,  ZOffset, DOMAIN, Model,             MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT  'ART_DEF_UNIT_MEMBER_JWW_MAXSUS_KUCHLAR',  Scale,  ZOffset, DOMAIN, 'Infantry_Russia.fxsxml',  MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE (TYPE = 'ART_DEF_UNIT_MEMBER_CANNON');
 
INSERT INTO ArtDefine_StrategicView
        (StrategicViewType,						TileType,   Asset)
VALUES  ('ART_DEF_UNIT_JWW_MAXSUS_KUCHLAR',     'Unit',     'sv_Maxsus.dds');
 
--================================================================
--================================================================