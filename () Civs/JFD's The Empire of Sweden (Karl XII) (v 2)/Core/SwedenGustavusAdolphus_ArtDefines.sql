--=======================================================================================================================
-- ART DEFINES
--=======================================================================================================================	
------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_StrategicView
------------------------------------------------------------------------------------------------------------------------
INSERT OR REPLACE INTO ArtDefine_StrategicView 
		(StrategicViewType, 			TileType,	Asset)
VALUES	('ART_DEF_UNIT_JFD_REGAL_SHIP',	'Unit', 	'sv_RegalShip.dds');
------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_UnitInfos
------------------------------------------------------------------------------------------------------------------------		
INSERT OR REPLACE INTO ArtDefine_UnitInfos 
		(Type, 							DamageStates,	Formation)
SELECT	'ART_DEF_UNIT_JFD_REGAL_SHIP', 	DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE Type = 'ART_DEF_UNIT_FRIGATE'; 
------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_UnitInfoMemberInfos
------------------------------------------------------------------------------------------------------------------------
INSERT OR REPLACE INTO ArtDefine_UnitInfoMemberInfos 	
		(UnitInfoType,					UnitMemberInfoType,						NumMembers)
SELECT	'ART_DEF_UNIT_JFD_REGAL_SHIP', 	'ART_DEF_UNIT_MEMBER_JFD_REGAL_SHIP',	NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE UnitInfoType = 'ART_DEF_UNIT_FRIGATE';
------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_UnitMemberCombats
------------------------------------------------------------------------------------------------------------------------
INSERT OR REPLACE INTO ArtDefine_UnitMemberCombats 
		(UnitMemberType,						EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT	'ART_DEF_UNIT_MEMBER_JFD_REGAL_SHIP',	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_FRIGATE';
------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_UnitMemberCombatWeapons
------------------------------------------------------------------------------------------------------------------------
INSERT OR REPLACE INTO ArtDefine_UnitMemberCombatWeapons	
		(UnitMemberType,						"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_JFD_REGAL_SHIP',	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_FRIGATE';
------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_UnitMemberInfos
------------------------------------------------------------------------------------------------------------------------
INSERT OR REPLACE INTO ArtDefine_UnitMemberInfos 	
		(Type, 									Scale, ZOffset, Domain, Model, 					   MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_JFD_REGAL_SHIP',	Scale, ZOffset, Domain, 'swedish_galleon.fxsxml',  MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE Type = 'ART_DEF_UNIT_MEMBER_FRIGATE';
--=======================================================================================================================
-- COLOURS
--=======================================================================================================================	
------------------------------------------------------------------------------------------------------------------------
-- Colors
------------------------------------------------------------------------------------------------------------------------		
UPDATE Colors
SET Red = 0.078, Green = 0.129, Blue = 0.364
WHERE Type = 'COLOR_PLAYER_SWEDEN_ICON';

UPDATE Colors
SET Red = 0.784, Green = 0.713, Blue = 0.235
WHERE Type = 'COLOR_PLAYER_SWEDEN_BACKGROUND';
--=======================================================================================================================
-- ICON ATLASES
--=======================================================================================================================	
------------------------------------------------------------------------------------------------------------------------
-- IconTextureAtlases
------------------------------------------------------------------------------------------------------------------------
INSERT OR REPLACE INTO IconTextureAtlases 
		(Atlas, 											IconSize, 	Filename, 											IconsPerRow, 	IconsPerColumn)
VALUES	('JFD_SWEDEN_GUSTAVUS_ADOLPHUS_ICON_ATLAS', 		256, 		'JFD_SwedenGustavusAdolphus_IconAtlas_256.dds',		1, 				1),
		('JFD_SWEDEN_GUSTAVUS_ADOLPHUS_ICON_ATLAS', 		128, 		'JFD_SwedenGustavusAdolphus_IconAtlas_128.dds',		1, 				1),
		('JFD_SWEDEN_GUSTAVUS_ADOLPHUS_ICON_ATLAS', 		80, 		'JFD_SwedenGustavusAdolphus_IconAtlas_80.dds',		1, 				1),
		('JFD_SWEDEN_GUSTAVUS_ADOLPHUS_ICON_ATLAS', 		64, 		'JFD_SwedenGustavusAdolphus_IconAtlas_64.dds',		1, 				1),
		('JFD_SWEDEN_GUSTAVUS_ADOLPHUS_ICON_ATLAS', 		45, 		'JFD_SwedenGustavusAdolphus_IconAtlas_45.dds',		1, 				1),
		('JFD_SWEDEN_GUSTAVUS_ADOLPHUS_ICON_ATLAS', 		32, 		'JFD_SwedenGustavusAdolphus_IconAtlas_32.dds',		1, 				1),
		('JFD_SWEDEN_GUSTAVUS_ADOLPHUS_UNIT_FLAG_ATLAS', 	32, 		'JFD_SwedenGustavusAdolphus_UnitFlagAtlas_32.dds',	1, 				1);
--=======================================================================================================================	
--=======================================================================================================================	
