--==========================================================================================================================
-- ArtDefine_StrategicView
--==========================================================================================================================
INSERT INTO ArtDefine_StrategicView
            (StrategicViewType,                     TileType,   Asset)
VALUES      ('ART_DEF_UNIT_TUAREG_IMAJAGHAN',        'Unit',     'sv_Imajaghan.dds');
--==========================================================================================================================
-- ArtDefine_UnitInfos
--==========================================================================================================================           
INSERT INTO ArtDefine_UnitInfos
            (Type,									 DamageStates,   Formation)
SELECT      ('ART_DEF_UNIT_TUAREG_IMAJAGHAN'),       DamageStates,   Formation
FROM ArtDefine_UnitInfos WHERE  (Type = 'UNIT_BERBER_CAVALRY');
--==========================================================================================================================
-- ArtDefine_UnitInfos
--==========================================================================================================================   
INSERT INTO ArtDefine_UnitInfoMemberInfos  
            (UnitInfoType,							 UnitMemberInfoType,							NumMembers)
SELECT      ('ART_DEF_UNIT_TUAREG_IMAJAGHAN'),       ('ART_DEF_UNIT_MEMBER_TUAREG_IMAJAGHAN'),		NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'UNIT_BERBER_CAVALRY');
--==========================================================================================================================
-- ArtDefine_UnitInfos
--==========================================================================================================================
INSERT INTO ArtDefine_UnitMemberCombats
            (UnitMemberType,							EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT      ('ART_DEF_UNIT_MEMBER_TUAREG_IMAJAGHAN'),   EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_U_MORROCAN_BERBER_CAVALRY');
--==========================================================================================================================
-- ArtDefine_UnitMemberCombatWeapons
--==========================================================================================================================
INSERT INTO ArtDefine_UnitMemberCombatWeapons  
            (UnitMemberType,							"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT      ('ART_DEF_UNIT_MEMBER_TUAREG_IMAJAGHAN'),   "Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_U_MORROCAN_BERBER_CAVALRY');
--==========================================================================================================================
-- ArtDefine_UnitInfos
--==========================================================================================================================   
INSERT INTO ArtDefine_UnitMemberInfos  
            (Type,                                  Scale, ZOffset, Domain, Model,                  MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT      ('ART_DEF_UNIT_MEMBER_TUAREG_IMAJAGHAN'),    Scale, ZOffset, Domain, ('u_afghanistgan_camel_gunner.fxsxml'),   MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_U_MORROCAN_BERBER_CAVALRY');
--==========================================================================================================================
--==========================================================================================================================