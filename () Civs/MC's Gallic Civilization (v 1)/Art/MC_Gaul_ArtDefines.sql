--==========================================================================================================================
-- ArtDefine_StrategicView
--==========================================================================================================================	
INSERT INTO ArtDefine_StrategicView 
			(StrategicViewType, 				TileType,	Asset)
VALUES		('ART_DEF_UNIT_MC_GAUL_OATHSWORN', 	'Unit', 	'sv_Oathsworn.dds');
--==========================================================================================================================
-- ArtDefine_UnitInfos
--==========================================================================================================================			
INSERT INTO ArtDefine_UnitInfos 
			(Type, 									DamageStates,	Formation)
SELECT		('ART_DEF_UNIT_MC_GAUL_OATHSWORN'), 	DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE (Type = 'ART_DEF_UNIT_U_ROMAN_LEGION');
--==========================================================================================================================
-- ArtDefine_UnitInfoMemberInfos
--==========================================================================================================================
INSERT INTO ArtDefine_UnitInfoMemberInfos 	
			(UnitInfoType,							UnitMemberInfoType,							NumMembers)
SELECT		('ART_DEF_UNIT_MC_GAUL_OATHSWORN'), 	('ART_DEF_UNIT_MEMBER_MC_GAUL_OATHSWORN'), 	12
FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_U_ROMAN_LEGION');
--==========================================================================================================================
-- ArtDefine_UnitMemberCombats
--==========================================================================================================================
INSERT INTO ArtDefine_UnitMemberCombats 
			(UnitMemberType,						EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT		('ART_DEF_UNIT_MEMBER_MC_GAUL_OATHSWORN'),	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_U_ROMAN_LEGION');
--==========================================================================================================================
-- ArtDefine_UnitMemberCombatWeapons
--==========================================================================================================================
INSERT INTO ArtDefine_UnitMemberCombatWeapons	
			(UnitMemberType,						"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT		('ART_DEF_UNIT_MEMBER_MC_GAUL_OATHSWORN'),	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_U_ROMAN_LEGION');
--==========================================================================================================================
-- ArtDefine_UnitMemberInfos
--==========================================================================================================================
INSERT INTO ArtDefine_UnitMemberInfos 	
			(Type, 									Scale,  ZOffset, Domain, Model, 					MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT		('ART_DEF_UNIT_MEMBER_MC_GAUL_OATHSWORN'),	Scale,	ZOffset, Domain, ('FrankMilnaht.fxsxml'),		MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_U_ROMAN_LEGION');
--==========================================================================================================================
-- IconTextureAtlases
--==========================================================================================================================
INSERT INTO IconTextureAtlases 
			(Atlas, 								IconSize, 	Filename, 								IconsPerRow, 	IconsPerColumn)
VALUES		('MC_GAUL_PROMOTION_ATLAS', 			256, 		'MC_GaulPromotions256.dds',				1, 				1),
			('MC_GAUL_PROMOTION_ATLAS', 			64, 		'MC_GaulPromotions64.dds',				1, 				1),
			('MC_GAUL_PROMOTION_ATLAS', 			45, 		'MC_GaulPromotions45.dds',				1, 				1),
			('MC_GAUL_PROMOTION_ATLAS', 			32, 		'MC_GaulPromotions32.dds',				1, 				1),
			('MC_GAUL_ATLAS', 						256, 		'MC_GaulAtlas_256.dds',					4, 				1),
			('MC_GAUL_ATLAS', 						128, 		'MC_GaulAtlas_128.dds',					4, 				1),
			('MC_GAUL_ATLAS', 						80, 		'MC_GaulAtlas_80.dds',					4, 				1),
			('MC_GAUL_ATLAS', 						64, 		'MC_GaulAtlas_64.dds',					4, 				1),
			('MC_GAUL_ATLAS', 						45, 		'MC_GaulAtlas_45.dds',					4, 				1),
			('MC_GAUL_ATLAS', 						32, 		'MC_GaulAtlas_32.dds',					4, 				1),
			('MC_GAUL_ALPHA_ATLAS', 				128, 		'MC_GaulAlphaAtlas_128.dds',			1, 				1),
			('MC_GAUL_ALPHA_ATLAS', 				80, 		'MC_GaulAlphaAtlas_80.dds',				1, 				1),
			('MC_GAUL_ALPHA_ATLAS', 				64, 		'MC_GaulAlphaAtlas_64.dds',				1, 				1),
			('MC_GAUL_ALPHA_ATLAS', 				48, 		'MC_GaulAlphaAtlas_48.dds',				1, 				1),
			('MC_GAUL_ALPHA_ATLAS', 				45, 		'MC_GaulAlphaAtlas_45.dds',				1, 				1),
			('MC_GAUL_ALPHA_ATLAS', 				32, 		'MC_GaulAlphaAtlas_32.dds',				1, 				1),
			('MC_GAUL_ALPHA_ATLAS', 				24, 		'MC_GaulAlphaAtlas_24.dds',				1, 				1),
			('MC_GAUL_ALPHA_ATLAS', 				16, 		'MC_GaulAlphaAtlas_16.dds',				1, 				1),
			('UNIT_FLAG_MC_GAUL_OATHSWORN_ATLAS', 	32, 		'Unit_MC_Oathsworn_Flag_32.dds',			1, 				1);
--==========================================================================================================================
--==========================================================================================================================