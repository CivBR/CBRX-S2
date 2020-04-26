--==========================================================================================================================
-- ArtDefine_StrategicView
--==========================================================================================================================
INSERT INTO ArtDefine_StrategicView 
			(StrategicViewType, 				TileType,	Asset)
VALUES		('ART_DEF_UNIT_MC_CHINOOK_WHALER', 	'Unit', 	'sv_MC_Chinook_Whaler.dds');
--==========================================================================================================================
-- ArtDefine_UnitInfos
--==========================================================================================================================			
INSERT INTO ArtDefine_UnitInfos 
			(Type, 									DamageStates,	Formation)
SELECT		('ART_DEF_UNIT_MC_CHINOOK_WHALER'), 	DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE	(Type = 'ART_DEF_UNIT_CANNON');
--==========================================================================================================================
-- ArtDefine_UnitInfos
--==========================================================================================================================	
INSERT INTO ArtDefine_UnitInfoMemberInfos 	
			(UnitInfoType,							UnitMemberInfoType,							NumMembers)
SELECT		('ART_DEF_UNIT_MC_CHINOOK_WHALER'), 	('ART_DEF_UNIT_MEMBER_MC_CHINOOK_WHALER'),	3
FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_GALLEASS');
--==========================================================================================================================
-- ArtDefine_UnitInfos
--==========================================================================================================================
INSERT INTO ArtDefine_UnitMemberCombats 
			(UnitMemberType,							EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT		('ART_DEF_UNIT_MEMBER_MC_CHINOOK_WHALER'),	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_GALLEASS');
--==========================================================================================================================
-- ArtDefine_UnitMemberCombatWeapons
--==========================================================================================================================
INSERT INTO ArtDefine_UnitMemberCombatWeapons	
			(UnitMemberType,							"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT		('ART_DEF_UNIT_MEMBER_MC_CHINOOK_WHALER'),	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_GALLEASS');
--==========================================================================================================================
-- ArtDefine_UnitInfos
--==========================================================================================================================	
INSERT INTO ArtDefine_UnitMemberInfos 	
			(Type, 										Scale,		ZOffset, Domain, Model,  						MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT		('ART_DEF_UNIT_MEMBER_MC_CHINOOK_WHALER'),	Scale,		ZOffset, Domain, ('MC_Chinook_Whaler.fxsxml'),  MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_WORKBOAT');
--==========================================================================================================================
-- ArtDefine_LandmarkTypes
--==========================================================================================================================
INSERT OR REPLACE INTO ArtDefine_LandmarkTypes 
			(Type,								LandmarkType,	FriendlyName) 
VALUES		('ART_DEF_RESOURCE_MC_ORCA',		'Resource',		'Orca'),
			('ART_DEF_RESOURCE_MC_SALMON',		'Resource',		'Salmon');
--==========================================================================================================================
-- ArtDefine_Landmarks
--==========================================================================================================================
INSERT OR REPLACE INTO ArtDefine_Landmarks 
			(Era, State, Scale, ImprovementType, LayoutHandler,	ResourceType, 					Model, TerrainContour, Tech)
SELECT 		Era, State, Scale, ImprovementType, LayoutHandler,	('ART_DEF_RESOURCE_MC_ORCA'), 	Model, TerrainContour, Tech
FROM ArtDefine_Landmarks WHERE ResourceType = 'ART_DEF_RESOURCE_WHALE';

INSERT OR REPLACE INTO ArtDefine_Landmarks 
			(Era, State, Scale, ImprovementType, LayoutHandler,	ResourceType, 						Model, TerrainContour, Tech)
SELECT 		Era, State, Scale, ImprovementType, LayoutHandler,	('ART_DEF_RESOURCE_MC_SALMON'), 	Model, TerrainContour, Tech
FROM ArtDefine_Landmarks WHERE ResourceType = 'ART_DEF_RESOURCE_FISH';
--==========================================================================================================================
-- ArtDefine_LandmarkTypes
--==========================================================================================================================
INSERT OR REPLACE INTO ArtDefine_StrategicView 
			(StrategicViewType,					TileType,	Asset) 
VALUES		('ART_DEF_RESOURCE_MC_ORCA',		'Resource',	'sv_MC_Orca.dds');

INSERT OR REPLACE INTO ArtDefine_StrategicView 
			(StrategicViewType,					TileType,	Asset) 
VALUES		('ART_DEF_RESOURCE_MC_SALMON',		'Resource',	'sv_MC_Salmon.dds');
--==========================================================================================================================
-- IconFontTextures
--==========================================================================================================================
INSERT INTO IconFontTextures 
			(IconFontTexture, 					IconFontTextureFile)
VALUES		('ICON_FONT_TEXTURE_MC_ORCA',		'MC_OrcaFontIcons_22'),
			('ICON_FONT_TEXTURE_MC_SALMON',		'MC_SalmonFontIcons_22');
--==========================================================================================================================
-- IconFontMapping
--==========================================================================================================================
INSERT INTO IconFontMapping 
			(IconName, 					IconFontTexture,					IconMapping)
VALUES		('ICON_RES_MC_ORCA',		'ICON_FONT_TEXTURE_MC_ORCA',		1),
			('ICON_RES_MC_SALMON',		'ICON_FONT_TEXTURE_MC_SALMON',		1);
--==========================================================================================================================
-- IconTextureAtlases
--==========================================================================================================================
INSERT INTO IconTextureAtlases 
			(Atlas, 						IconSize, 	Filename, 								IconsPerRow, 	IconsPerColumn)
VALUES		('MC_CHINOOK_ATLAS', 			256, 		'ChinookAtlas_256.dds',					6, 				1),
			('MC_CHINOOK_ATLAS', 			128, 		'ChinookAtlas_128.dds',					6, 				1),
			('MC_CHINOOK_ATLAS', 			80, 		'ChinookAtlas_80.dds',					6, 				1),
			('MC_CHINOOK_ATLAS', 			64, 		'ChinookAtlas_64.dds',					6, 				1),
			('MC_CHINOOK_ATLAS', 			45, 		'ChinookAtlas_45.dds',					6, 				1),
			('MC_CHINOOK_ATLAS', 			32, 		'ChinookAtlas_32.dds',					6, 				1),
			('MC_CHINOOK_ALPHA_ATLAS', 		128, 		'ChinookAlpha_128.dds',					1, 				1),
			('MC_CHINOOK_ALPHA_ATLAS', 		80, 		'ChinookAlpha_80.dds',					1, 				1),
			('MC_CHINOOK_ALPHA_ATLAS', 		64, 		'ChinookAlpha_64.dds',					1, 				1),
			('MC_CHINOOK_ALPHA_ATLAS', 		48, 		'ChinookAlpha_48.dds',					1, 				1),
			('MC_CHINOOK_ALPHA_ATLAS', 		45, 		'ChinookAlpha_45.dds',					1, 				1),
			('MC_CHINOOK_ALPHA_ATLAS', 		32, 		'ChinookAlpha_32.dds',					1, 				1),
			('MC_CHINOOK_ALPHA_ATLAS', 		24, 		'ChinookAlpha_24.dds',					1, 				1),
			('MC_CHINOOK_ALPHA_ATLAS', 		16, 		'ChinookAlpha_16.dds',					1, 				1),
			('MC_CHINOOK_WHALER_FLAG', 		32, 		'Unit_MC_Chinook_Whaler_Flag_32.dds',					1, 				1);
--==========================================================================================================================
--==========================================================================================================================
