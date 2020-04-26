--==========================================================================================================================
-- IconTextureAtlases
--==========================================================================================================================
INSERT INTO IconTextureAtlases 
			(Atlas, 									IconSize, 	Filename, 									IconsPerRow, 	IconsPerColumn)
VALUES		('MC_MHA_ATLAS', 							256, 		'MC_MHA_256.dds',							4, 				1),
			('MC_MHA_ATLAS', 							128, 		'MC_MHA_128.dds',							4, 				1),
			('MC_MHA_ATLAS', 							80, 		'MC_MHA_80.dds',							4, 				1),
			('MC_MHA_ATLAS', 							64, 		'MC_MHA_64.dds',							4, 				1),
			('MC_MHA_ATLAS', 							45, 		'MC_MHA_45.dds',							4, 				1),
			('MC_MHA_ATLAS', 							32, 		'MC_MHA_32.dds',							4, 				1),
			('MC_MHA_ALPHA_ATLAS', 						128, 		'MC_MHA_Alpha_128.dds',						1, 				1),
			('MC_MHA_ALPHA_ATLAS', 						80, 		'MC_MHA_Alpha_80.dds',						1, 				1),
			('MC_MHA_ALPHA_ATLAS', 						64, 		'MC_MHA_Alpha_64.dds',						1, 				1),
			('MC_MHA_ALPHA_ATLAS', 						48, 		'MC_MHA_Alpha_48.dds',						1, 				1),
			('MC_MHA_ALPHA_ATLAS', 						45, 		'MC_MHA_Alpha_45.dds',						1, 				1),
			('MC_MHA_ALPHA_ATLAS', 						32, 		'MC_MHA_Alpha_32.dds',						1, 				1),
			('MC_MHA_ALPHA_ATLAS', 						24, 		'MC_MHA_Alpha_24.dds',						1, 				1),
			('MC_MHA_ALPHA_ATLAS', 						16, 		'MC_MHA_Alpha_16.dds',						1, 				1),
			('MC_BLACKMOUTH_FLAG', 						32, 		'MC_BlackMouth_32.dds',						1, 				1);
--==========================================================================================================================
-- ArtDefine_StrategicView
--==========================================================================================================================	
INSERT INTO ArtDefine_StrategicView 
			(StrategicViewType, 				TileType,	Asset)
VALUES		('ART_DEF_UNIT_MC_BLACKMOUTH', 	'Unit', 	'sv_MC_BlackMouth.dds');
--==========================================================================================================================
-- ArtDefine_UnitInfos
--==========================================================================================================================			
INSERT INTO ArtDefine_UnitInfos 
			(Type, 								DamageStates,	Formation)
SELECT		('ART_DEF_UNIT_MC_BLACKMOUTH'),	DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE (Type = 'ART_DEF_UNIT_PIKEMAN');
--==========================================================================================================================
-- ArtDefine_UnitInfoMemberInfos
--==========================================================================================================================
INSERT INTO ArtDefine_UnitInfoMemberInfos 	
			(UnitInfoType,						UnitMemberInfoType,						NumMembers)
SELECT		('ART_DEF_UNIT_MC_BLACKMOUTH'),	('ART_DEF_UNIT_MEMBER_MC_BLACKMOUTH'),	NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_PIKEMAN');
--==========================================================================================================================
-- ArtDefine_UnitMemberCombats
--==========================================================================================================================
INSERT INTO ArtDefine_UnitMemberCombats 
			(UnitMemberType,						EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT		('ART_DEF_UNIT_MEMBER_MC_BLACKMOUTH'),	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_PIKEMAN');
--==========================================================================================================================
-- ArtDefine_UnitMemberCombatWeapons
--==========================================================================================================================
INSERT INTO ArtDefine_UnitMemberCombatWeapons	
			(UnitMemberType,						"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT		('ART_DEF_UNIT_MEMBER_MC_BLACKMOUTH'),	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_PIKEMAN');
--==========================================================================================================================
-- ArtDefine_UnitMemberInfos
--==========================================================================================================================
INSERT INTO ArtDefine_UnitMemberInfos 	
			(Type, 									Scale,  ZOffset, Domain, Model, 					MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT		('ART_DEF_UNIT_MEMBER_MC_BLACKMOUTH'),	Scale,	ZOffset, Domain, ('MC_BlackMouth.fxsxml'),	MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_PIKEMAN');
--==========================================================================================================================	
-- Audio_Sounds
--==========================================================================================================================		
INSERT INTO Audio_Sounds 
			(SoundID, 									Filename, 			LoadType)
VALUES		('SND_LEADER_MUSIC_MC_FOURBEARS_PEACE', 	'MHA_Peace',		'DynamicResident'),
			('SND_LEADER_MUSIC_MC_FOURBEARS_WAR', 		'MHA_War',			'DynamicResident');
--==========================================================================================================================	
-- Audio_2DSounds
--==========================================================================================================================		
INSERT INTO Audio_2DSounds 
			(ScriptID, 									SoundID, 									SoundType, 			MinVolume, 	MaxVolume,  IsMusic, Looping)
VALUES		('AS2D_LEADER_MUSIC_MC_FOURBEARS_PEACE', 	'SND_LEADER_MUSIC_MC_FOURBEARS_PEACE', 		'GAME_MUSIC', 		100, 		100, 		1, 		 0),
			('AS2D_LEADER_MUSIC_MC_FOURBEARS_WAR', 		'SND_LEADER_MUSIC_MC_FOURBEARS_WAR', 		'GAME_MUSIC', 		100, 		100, 		1, 		 0);
--==========================================================================================================================		
--==========================================================================================================================		