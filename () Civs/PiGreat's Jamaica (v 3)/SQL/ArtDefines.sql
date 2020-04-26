--==========================================================================================================================
-- Maroon Rebel
--==========================================================================================================================
-- Main
--==========================================================================================================================
INSERT INTO ArtDefine_UnitInfos (TYPE,      DamageStates,       Formation)
SELECT  'ART_DEF_UNIT_PI_MAROON',               DamageStates,       ('UnFormed')
FROM ArtDefine_UnitInfos WHERE TYPE = 'ART_DEF_UNIT_GATLINGGUN';
INSERT INTO ArtDefine_UnitInfoMemberInfos VALUES    ('ART_DEF_UNIT_PI_MAROON', 'ART_DEF_UNIT_MEMBER_PI_MAROON', "7"); 
--==========================================================================================================================
-- Unit Member
--==========================================================================================================================
 
INSERT INTO ArtDefine_UnitMemberCombats (UnitMemberType,    EnableActions,  DisableActions, MoveRadius, ShortMoveRadius,    ChargeRadius,   AttackRadius,   RangedAttackRadius, MoveRate,   ShortMoveRate,  TurnRateMin,    TurnRateMax,    TurnFacingRateMin,  TurnFacingRateMax,  RollRateMin,    RollRateMax,    PitchRateMin,   PitchRateMax,   LOSRadiusScale, TargetRadius,   TargetHeight,   HasShortRangedAttack,   HasLongRangedAttack,    HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack,  HasRefaceAfterCombat,   ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking,    HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance,   OnlyTurnInMovementActions,  RushAttackFormation)
SELECT  ('ART_DEF_UNIT_MEMBER_PI_MAROON'),          EnableActions,  DisableActions, MoveRadius, ShortMoveRadius,    ChargeRadius,   AttackRadius,   RangedAttackRadius, MoveRate,   ShortMoveRate,  TurnRateMin,    TurnRateMax,    TurnFacingRateMin,  TurnFacingRateMax,  RollRateMin,    RollRateMax,    PitchRateMin,   PitchRateMax,   LOSRadiusScale, TargetRadius,   TargetHeight,   HasShortRangedAttack,   HasLongRangedAttack,    HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack,  HasRefaceAfterCombat,   ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking,    HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance,   OnlyTurnInMovementActions,  RushAttackFormation
FROM ArtDefine_UnitMemberCombats        WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_GATLINGGUN';
 
INSERT INTO ArtDefine_UnitMemberCombatWeapons ('UnitMemberType',    'Index', 'SubIndex', 'ID', 'VisKillStrengthMin', 'VisKillStrengthMax', 'ProjectileSpeed', 'ProjectileTurnRateMin', 'ProjectileTurnRateMax', 'HitEffect', 'HitEffectScale', 'HitRadius', 'ProjectileChildEffectScale', 'AreaDamageDelay', 'ContinuousFire', 'WaitForEffectCompletion', 'TargetGround', 'IsDropped', 'WeaponTypeTag', 'WeaponTypeSoundOverrideTag')
SELECT ('ART_DEF_UNIT_MEMBER_PI_MAROON'),                       "Index", "SubIndex", "ID", "VisKillStrengthMin", "VisKillStrengthMax", "ProjectileSpeed", "ProjectileTurnRateMin", "ProjectileTurnRateMax", "HitEffect", "HitEffectScale", "HitRadius", "ProjectileChildEffectScale", "AreaDamageDelay", "ContinuousFire", "WaitForEffectCompletion", "TargetGround", "IsDropped", "WeaponTypeTag", "WeaponTypeSoundOverrideTag"
FROM ArtDefine_UnitMemberCombatWeapons  WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_GATLINGGUN');
 
INSERT INTO ArtDefine_UnitMemberInfos (TYPE,        Scale,      ZOffset,        DOMAIN,     Model,                      MaterialTypeTag,     MaterialTypeSoundOverrideTag)
SELECT  ('ART_DEF_UNIT_MEMBER_PI_MAROON'),  Scale,      ZOffset,        DOMAIN,     ('cimarron.fxsxml'),            MaterialTypeTag,     MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos          WHERE TYPE = 'ART_DEF_UNIT_MEMBER_GATLINGGUN';

--==========================================================================================================================
-- ArtDefine_StrategicView
--==========================================================================================================================
INSERT INTO ArtDefine_StrategicView 
			(StrategicViewType, 					TileType,	Asset)
VALUES		('ART_DEF_UNIT_PI_MAROON', 				'Unit', 	'MaroonFlag128.dds'),
			('ART_DEF_UNIT_PI_BLACK_STAR_LINER', 			'Unit', 	'LinerFlag128.dds');