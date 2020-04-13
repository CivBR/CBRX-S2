--==========================================================================================================================
-- ARTDEFINES
--==========================================================================================================================	
-- IconTextureAtlasesa
------------------------------
INSERT INTO IconTextureAtlases 
		(Atlas, 									IconSize, 	Filename, 								IconsPerRow, 	IconsPerColumn)
VALUES	('DMS_BURKINA_FASO_ATLAS', 					256, 		'DMS_BurkinaFasoAtlas_256.dds',			2, 				2),
		('DMS_BURKINA_FASO_ATLAS', 					128, 		'DMS_BurkinaFasoAtlas_128.dds',			2, 				2),
		('DMS_BURKINA_FASO_ATLAS', 					80, 		'DMS_BurkinaFasoAtlas_80.dds',			2, 				2),
		('DMS_BURKINA_FASO_ATLAS', 					64, 		'DMS_BurkinaFasoAtlas_64.dds',			2, 				2),
		('DMS_BURKINA_FASO_ATLAS', 					45, 		'DMS_BurkinaFasoAtlas_45.dds',			2, 				2),
		('DMS_BURKINA_FASO_ATLAS', 					32, 		'DMS_BurkinaFasoAtlas_32.dds',			2, 				2),
		('DMS_BURKINA_FASO_ALPHA_ATLAS', 			128, 		'DMS_BurkinaFasoAlphaAtlas_128.dds',	1,				1),
		('DMS_BURKINA_FASO_ALPHA_ATLAS', 			80, 		'DMS_BurkinaFasoAlphaAtlas_80.dds',		1, 				1),
		('DMS_BURKINA_FASO_ALPHA_ATLAS', 			64, 		'DMS_BurkinaFasoAlphaAtlas_64.dds',		1, 				1),
		('DMS_BURKINA_FASO_ALPHA_ATLAS', 			48, 		'DMS_BurkinaFasoAlphaAtlas_48.dds',		1, 				1),
		('DMS_BURKINA_FASO_ALPHA_ATLAS', 			45, 		'DMS_BurkinaFasoAlphaAtlas_45.dds',		1, 				1),
		('DMS_BURKINA_FASO_ALPHA_ATLAS', 			32, 		'DMS_BurkinaFasoAlphaAtlas_32.dds',		1, 				1),
		('DMS_BURKINA_FASO_ALPHA_ATLAS', 			24, 		'DMS_BurkinaFasoAlphaAtlas_24.dds',		1, 				1),
		('DMS_BURKINA_FASO_ALPHA_ATLAS', 			16, 		'DMS_BurkinaFasoAlphaAtlas_16.dds',		1, 				1),
		('DMS_UNIT_FLAG_MILICE_DU_PEUPLE_ATLAS', 	32, 		'UnitFlag_MiliceDuPeuple_32.dds',		1, 				1),
		('DMS_REFOREST_ATLAS', 						256, 		'DMS_ForestAtlas_256.dds',				1, 				1),
		('DMS_REFOREST_ATLAS', 						64, 		'DMS_ForestAtlas_64.dds',				1, 				1),
		('DMS_UNIT_ACTION_REFOREST_ATLAS', 			64, 		'DMS_UnitAction64_Forest.dds',			1, 				1),
		('DMS_UNIT_ACTION_REFOREST_ATLAS', 			45, 		'DMS_UnitAction45_Forest.dds',			1, 				1);
------------------------------
-- Colors
------------------------------		
INSERT INTO Colors 
		(Type, 											Red, 	Green, 	Blue, 	Alpha)
VALUES	('COLOR_PLAYER_DMS_BURKINA_FASO_ICON', 			0.714,	0.784,	0.529,	1),
		('COLOR_PLAYER_DMS_BURKINA_FASO_BACKGROUND',	0.431,	0.094,	0.078,	1);
------------------------------
-- PlayerColors
------------------------------			
INSERT INTO PlayerColors 
		(Type, 									PrimaryColor, 							SecondaryColor, 								TextColor)
VALUES	('PLAYERCOLOR_DMS_BURKINA_FASO',		'COLOR_PLAYER_DMS_BURKINA_FASO_ICON', 	'COLOR_PLAYER_DMS_BURKINA_FASO_BACKGROUND', 	'COLOR_PLAYER_WHITE_TEXT');
--==========================================================================================================================
-- AUDIO
--==========================================================================================================================	
-- Audio_Sounds
------------------------------	
INSERT INTO Audio_Sounds 
		(SoundID, 								Filename, 				LoadType)
VALUES	('SND_LEADER_MUSIC_DMS_SANKARA_PEACE', 	'DMS_Sankara_Peace',	'DynamicResident'),
		('SND_LEADER_MUSIC_DMS_SANKARA_WAR', 	'DMS_Sankara_War', 		'DynamicResident');		
------------------------------
-- Audio_2DSounds
------------------------------	
INSERT INTO Audio_2DSounds 
		(ScriptID, 								SoundID, 									SoundType, 		MinVolume, 	MaxVolume,  IsMusic, Looping)
VALUES	('AS2D_LEADER_MUSIC_DMS_SANKARA_PEACE', 'SND_LEADER_MUSIC_DMS_SANKARA_PEACE',		'GAME_MUSIC', 	60, 		60, 		1, 		 0),
		('AS2D_LEADER_MUSIC_DMS_SANKARA_WAR', 	'SND_LEADER_MUSIC_DMS_SANKARA_WAR', 		'GAME_MUSIC', 	60, 		60, 		1,		 0);
--==========================================================================================================================
-- UNIT GRAPHICS
--==========================================================================================================================	
-- ArtDefine_StrategicView
------------------------------
INSERT INTO ArtDefine_StrategicView 
		(StrategicViewType, 						TileType,		Asset)
VALUES	('ART_DEF_UNIT_DMS_MILICE_DU_PEUPLE', 		'Unit', 		'sv_milice_du_peuple.dds'),
		('ART_DEF_IMPROVEMENT_DMS_PLANT_FOREST', 	'Improvement', 	'sv_plant_forest.dds');
------------------------------
-- ArtDefine_LandmarkTypes
------------------------------
INSERT INTO ArtDefine_LandmarkTypes 
		(Type,										LandmarkType,		FriendlyName)
VALUES	('ART_DEF_IMPROVEMENT_DMS_PLANT_FOREST',	'Improvement',		'DMS_plant_forest');
------------------------------
-- ArtDefine_Landmarks
------------------------------
INSERT INTO ArtDefine_Landmarks 
		(Era,	State,		Scale,	ImprovementType,						LayoutHandler,	ResourceType,				Model,						TerrainContour)
SELECT 'Any',	'Any',		1.0,	'ART_DEF_IMPROVEMENT_DMS_PLANT_FOREST', 'SNAPSHOT',		'ART_DEF_RESOURCE_NONE',	'resource_timber.fxsxml',	1;
------------------------------
-- ArtDefine_UnitInfos
------------------------------	
INSERT INTO ArtDefine_UnitInfos 
		(Type, 									DamageStates,	Formation)
SELECT	('ART_DEF_UNIT_DMS_MILICE_DU_PEUPLE'),	DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE (Type = 'ART_DEF_UNIT_MARINE');
------------------------------
-- ArtDefine_UnitInfoMemberInfos
------------------------------
INSERT INTO ArtDefine_UnitInfoMemberInfos 	
		(UnitInfoType,							UnitMemberInfoType,								NumMembers)
SELECT	('ART_DEF_UNIT_DMS_MILICE_DU_PEUPLE'),	('ART_DEF_UNIT_MEMBER_DMS_MILICE_DU_PEUPLE'),	NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_MARINE');
------------------------------
-- ArtDefine_UnitMemberCombats
------------------------------
INSERT INTO ArtDefine_UnitMemberCombats 
		(UnitMemberType,								EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT	('ART_DEF_UNIT_MEMBER_DMS_MILICE_DU_PEUPLE'),	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_MARINE');
------------------------------
-- ArtDefine_UnitMemberCombatWeapons
------------------------------
INSERT INTO ArtDefine_UnitMemberCombatWeapons	
		(UnitMemberType,								"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT	('ART_DEF_UNIT_MEMBER_DMS_MILICE_DU_PEUPLE'),	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_MARINE');
------------------------------
-- ArtDefine_UnitMemberInfos
------------------------------
INSERT INTO ArtDefine_UnitMemberInfos 	
		(Type, 											Scale,  ZOffset, Domain, Model, MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT	('ART_DEF_UNIT_MEMBER_DMS_MILICE_DU_PEUPLE'),	Scale,	ZOffset, Domain, Model,	MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_MARINE');
--==========================================================================================================================	
--==========================================================================================================================