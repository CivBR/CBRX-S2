 --==========================================================================================================================	
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================		
INSERT INTO Unit_ResourceQuantityRequirements 	
			(UnitType, 						ResourceType)
SELECT		('UNIT_UC_TEUTON'), 	ResourceType
FROM Unit_ResourceQuantityRequirements WHERE (UnitType = 'UNIT_KNIGHT');	
--==========================================================================================================================
-- ArtDefine_StrategicView
--==========================================================================================================================	
INSERT INTO ArtDefine_StrategicView 
			(StrategicViewType, 							TileType,	Asset)
VALUES		('ART_DEF_UNIT_UC_TEUTON', 			'Unit', 	'sv_TOKnight.dds');
--==========================================================================================================================
-- ArtDefine_UnitInfos
--==========================================================================================================================			
INSERT INTO ArtDefine_UnitInfos 
			(Type, 											DamageStates,	Formation)
SELECT		('ART_DEF_UNIT_UC_TEUTON'),			DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE (Type = 'ART_DEF_UNIT_KNIGHT');
--==========================================================================================================================
-- ArtDefine_UnitInfoMemberInfos
--==========================================================================================================================
INSERT INTO ArtDefine_UnitInfoMemberInfos 	
			(UnitInfoType,									UnitMemberInfoType,								NumMembers)
SELECT		('ART_DEF_UNIT_UC_TEUTON'),			('ART_DEF_UNIT_MEMBER_UC_TEUTON'),		NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_KNIGHT');
--==========================================================================================================================
-- ArtDefine_UnitMemberCombats
--==========================================================================================================================
INSERT INTO ArtDefine_UnitMemberCombats 
			(UnitMemberType,								EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT		('ART_DEF_UNIT_MEMBER_UC_TEUTON'),		EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_KNIGHT');
--==========================================================================================================================
-- ArtDefine_UnitMemberCombatWeapons
--==========================================================================================================================
INSERT INTO ArtDefine_UnitMemberCombatWeapons	
			(UnitMemberType,								"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT		('ART_DEF_UNIT_MEMBER_UC_TEUTON'),		"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_KNIGHT');
--==========================================================================================================================
-- ArtDefine_UnitMemberInfos
--==========================================================================================================================
INSERT INTO ArtDefine_UnitMemberInfos 	
			(Type, 											Scale,  ZOffset, Domain, Model, 					MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT		('ART_DEF_UNIT_MEMBER_UC_TEUTON'),		Scale,	ZOffset, Domain, ('Ritterbruder.fxsxml'),	MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_KNIGHT');
--==========================================================================================================================
-- IconTextureAtlases
--==========================================================================================================================
INSERT INTO IconTextureAtlases 
			(Atlas, 										IconSize, 	Filename, 									IconsPerRow, 	IconsPerColumn)
VALUES		('UC_TEUTON_ATLAS', 						256, 		'UC_TOAtlas_256.dds',				2,				2),
			('UC_TEUTON_ATLAS', 						128, 		'UC_TOAtlas_128.dds',				2, 				2),
			('UC_TEUTON_ATLAS', 						80, 		'UC_TOAtlas_80.dds',					2, 				2),
			('UC_TEUTON_ATLAS', 						64, 		'UC_TOAtlas_64.dds',					2, 				2),
			('UC_TEUTON_ATLAS', 						45, 		'UC_TOAtlas_45.dds',					2, 				2),
			('UC_TEUTON_ATLAS', 						32, 		'UC_TOAtlas_32.dds',					2, 				2),
			('UC_TEUTON_ALPHA_ATLAS',					128, 		'UC_TOAlphaAtlas_128.dds',			1,				1),
			('UC_TEUTON_ALPHA_ATLAS',					80, 		'UC_TOAlphaAtlas_80.dds',			1, 				1),
			('UC_TEUTON_ALPHA_ATLAS',					64, 		'UC_TOAlphaAtlas_64.dds',			1, 				1),
			('UC_TEUTON_ALPHA_ATLAS',					48, 		'UC_TOAlphaAtlas_48.dds',			1, 				1),
			('UC_TEUTON_ALPHA_ATLAS',					32, 		'UC_TOAlphaAtlas_32.dds',			1, 				1),
			('UC_TEUTON_ALPHA_ATLAS',					24, 		'UC_TOAlphaAtlas_24.dds',			1, 				1),
			('UC_TEUTON_ALPHA_ATLAS',	 				16, 		'UC_TOAlphaAtlas_16.dds',			1, 				1),
			('UC_TO_FLAG_ATLAS',				32,			'UC_TOKnightFlag.dds',			1, 				1);
--==========================================================================================================================
-- AUDIO
--==========================================================================================================================	
-- Audio_Sounds
------------------------------	
INSERT INTO Audio_Sounds 
			(SoundID, 									Filename, 					LoadType)
VALUES		('SND_LEADER_MUSIC_UC_HERMANN_PEACE', 	'TeutonPeace', 	'DynamicResident'),
			('SND_LEADER_MUSIC_UC_HERMANN_WAR',		'TeutonNWar', 		'DynamicResident');		
------------------------------
-- Audio_2DSounds
------------------------------	
INSERT INTO Audio_2DSounds 
			(ScriptID, 									SoundID, 								SoundType, 		MinVolume, 	MaxVolume,	IsMusic,	Looping)
VALUES		('AS2D_LEADER_MUSIC_UC_HERMANN_PEACE', 	'SND_LEADER_MUSIC_UC_HERMANN_PEACE', 	'GAME_MUSIC', 	80, 		80, 		1, 			0),
			('AS2D_LEADER_MUSIC_UC_HERMANN_WAR', 		'SND_LEADER_MUSIC_UC_HERMANN_WAR', 	'GAME_MUSIC', 	80, 		80, 		1,			0);
