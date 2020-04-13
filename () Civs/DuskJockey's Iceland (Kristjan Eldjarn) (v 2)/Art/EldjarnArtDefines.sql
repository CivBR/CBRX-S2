--==========================================================================================================================	
-- ArtDefine_LandmarkTypes
--==========================================================================================================================
INSERT INTO ArtDefine_LandmarkTypes(Type, LandmarkType, FriendlyName)
SELECT 'ART_DEF_IMPROVEMENT_DJ_TORFBAER', 'Improvement', 'TORFBAER';
--==========================================================================================================================	
-- ArtDefine_Landmarks
--==========================================================================================================================
INSERT INTO ArtDefine_Landmarks(Era, State, Scale, ImprovementType, LayoutHandler, ResourceType, Model, TerrainContour)
SELECT 'Any', 'UnderConstruction',  1.0, 'ART_DEF_IMPROVEMENT_DJ_TORFBAER', 'SNAPSHOT', 'ART_DEF_RESOURCE_ALL', 'Torfbaer_b_build.fxsxml', 1 UNION ALL
SELECT 'Any', 'Constructed', 		1.0, 'ART_DEF_IMPROVEMENT_DJ_TORFBAER', 'SNAPSHOT', 'ART_DEF_RESOURCE_ALL', 'Torfbaer_b.fxsxml', 1 UNION ALL
SELECT 'Any', 'Pillaged', 			1.0, 'ART_DEF_IMPROVEMENT_DJ_TORFBAER', 'SNAPSHOT', 'ART_DEF_RESOURCE_ALL', 'Torfbaer_b_pl.fxsxml', 1;
--==========================================================================================================================	
-- ArtDefine_StrategicView
--==========================================================================================================================
INSERT INTO ArtDefine_StrategicView(StrategicViewType, TileType, Asset)
SELECT 'ART_DEF_IMPROVEMENT_DJ_TORFBAER', 'Improvement', 'Torfbaer_sv.dds';	
--==========================================================================================================================
-- ArtDefine_UnitInfos
--==========================================================================================================================			
INSERT INTO ArtDefine_UnitInfos 
			(Type, 								DamageStates,	Formation)
SELECT		('ART_DEF_UNIT_DJ_AEGIR_CLASS'),	DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE (Type = 'ART_DEF_UNIT_BATTLESHIP');
--==========================================================================================================================
-- ArtDefine_UnitInfoMemberInfos
--==========================================================================================================================
INSERT INTO ArtDefine_UnitInfoMemberInfos 	
			(UnitInfoType,						UnitMemberInfoType,						NumMembers)
SELECT		('ART_DEF_UNIT_DJ_AEGIR_CLASS'),	('ART_DEF_UNIT_MEMBER_DJ_AEGIR_CLASS'),	NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_BATTLESHIP');
--==========================================================================================================================
-- ArtDefine_UnitMemberCombats
--==========================================================================================================================
INSERT INTO ArtDefine_UnitMemberCombats 
			(UnitMemberType,						EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT		('ART_DEF_UNIT_MEMBER_DJ_AEGIR_CLASS'),	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_BATTLESHIP');
--==========================================================================================================================
-- ArtDefine_UnitMemberCombatWeapons
--==========================================================================================================================
INSERT INTO ArtDefine_UnitMemberCombatWeapons	
			(UnitMemberType,						"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT		('ART_DEF_UNIT_MEMBER_DJ_AEGIR_CLASS'),	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_BATTLESHIP');
--==========================================================================================================================
-- ArtDefine_UnitMemberInfos
--==========================================================================================================================
INSERT INTO ArtDefine_UnitMemberInfos 	
			(Type, 									Scale,  ZOffset, Domain, Model, 				MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT		('ART_DEF_UNIT_MEMBER_DJ_AEGIR_CLASS'),	Scale,	ZOffset, Domain, ('corvette.fxsxml'),	MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_BATTLESHIP');
--==========================================================================================================================
-- IconTextureAtlases
--==========================================================================================================================
INSERT INTO IconTextureAtlases 
		(Atlas, 							IconSize, 	Filename, 						IconsPerRow, 	IconsPerColumn)
VALUES	('DJ_ICELAND_COLOR_ATLAS',			256,		'EldjarnColorAtlas256.dds',		2,				2),
		('DJ_ICELAND_COLOR_ATLAS',			128,		'EldjarnColorAtlas128.dds',		2,				2),
		('DJ_ICELAND_COLOR_ATLAS',			80,			'EldjarnColorAtlas80.dds',		2,				2),
		('DJ_ICELAND_COLOR_ATLAS',			64,			'EldjarnColorAtlas64.dds',		2,				2),
		('DJ_ICELAND_COLOR_ATLAS',			45,			'EldjarnColorAtlas45.dds',		2,				2),
		('DJ_ICELAND_COLOR_ATLAS',			32,			'EldjarnColorAtlas32.dds',		2,				2),
		('DJ_ICELAND_ALPHA_ATLAS',			64,			'EldjarnAlphaAtlas64.dds',		1,				1),
		('DJ_ICELAND_ALPHA_ATLAS',			48,			'EldjarnAlphaAtlas48.dds',		1,				1),
		('DJ_ICELAND_ALPHA_ATLAS',			32,			'EldjarnAlphaAtlas32.dds',		1,				1),
		('DJ_ICELAND_ALPHA_ATLAS',			24,			'EldjarnAlphaAtlas24.dds',		1,				1),
		('UNIT_FLAG_DJ_AEGIR_CLASS_ATLAS', 	32, 		'DJ_AEGIR_CLASS_FLAG_32.dds',	1, 				1),
		('DJ_TORFBAER_BUILD_ATLAS',			64,			'TorfbaerBuild64.dds',			1,				1),
		('DJ_TORFBAER_BUILD_ATLAS',			45,			'TorfbaerBuild45.dds',			1,				1);