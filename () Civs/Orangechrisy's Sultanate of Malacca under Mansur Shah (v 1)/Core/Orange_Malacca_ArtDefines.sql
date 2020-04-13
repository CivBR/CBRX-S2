--==========================================================================================================================
-- ART DEFINES
--==========================================================================================================================	
-- IconTextureAtlases
------------------------------
INSERT INTO IconTextureAtlases 
		(Atlas, 									IconSize, 	Filename, 						IconsPerRow, 	IconsPerColumn)
VALUES	('CIV_ATLAS_ORG_MALACCA', 				256, 		'MalaccaIconAtlas256.dds',			3, 				2),
		('CIV_ATLAS_ORG_MALACCA', 				128, 		'MalaccaIconAtlas128.dds',			3, 				2),
		('CIV_ATLAS_ORG_MALACCA', 				80, 		'MalaccaIconAtlas80.dds',				3, 				2),
		('CIV_ATLAS_ORG_MALACCA', 				64, 		'MalaccaIconAtlas64.dds',				3, 				2),
		('CIV_ATLAS_ORG_MALACCA', 				48, 		'MalaccaIconAtlas48.dds',				3, 				2),
		('CIV_ATLAS_ORG_MALACCA', 				45, 		'MalaccaIconAtlas45.dds',				3, 				2),
		('CIV_ATLAS_ORG_MALACCA', 				32, 		'MalaccaIconAtlas32.dds',				3, 				2),
		('CIV_ATLAS_ORG_MALACCA', 				24, 		'MalaccaIconAtlas24.dds',				3, 				2),
		('CIV_ATLAS_ORG_MALACCA', 				16, 		'MalaccaIconAtlas16.dds',				3, 				2),
		('CIV_ALPHA_ATLAS_ORG_MALACCA', 				128, 		'MalaccaIconAtlas128.dds',		1,				2),
		('CIV_ALPHA_ATLAS_ORG_MALACCA', 				80, 		'MalaccaIconAtlas80.dds',		1, 				2),
		('CIV_ALPHA_ATLAS_ORG_MALACCA', 				64, 		'MalaccaIconAtlas64.dds',		1, 				2),
		('CIV_ALPHA_ATLAS_ORG_MALACCA', 				48, 		'MalaccaIconAtlas48.dds',		1, 				2),
		('CIV_ALPHA_ATLAS_ORG_MALACCA', 				45, 		'MalaccaIconAtlas45.dds',		1, 				2),
		('CIV_ALPHA_ATLAS_ORG_MALACCA', 				32, 		'MalaccaIconAtlas32.dds',		1, 				2),
		('CIV_ALPHA_ATLAS_ORG_MALACCA', 				24, 		'MalaccaIconAtlas24.dds',		1, 				2),
		('CIV_ALPHA_ATLAS_ORG_MALACCA', 				16, 		'MalaccaIconAtlas16.dds',		1, 				2),
		('CIV_ATLAS_ORG_MALACCA_JONG',			32, 		'JongIcon32.dds',		1, 				1),
		('CIV_ATLAS_ORG_MALACCA_LAKSAMANA',			32, 		'LaksamanaIcon32.dds',		1, 				1);
/*
--==========================================================================================================================
-- AUDIO
--==========================================================================================================================	
-- Audio_Sounds
------------------------------	
INSERT INTO Audio_Sounds 
		(SoundID, 									Filename,	 		LoadType)
VALUES	('SND_LEADER_MUSIC_ORG_MALACCA_PEACE', 		'Malacca_Peace',		'DynamicResident'),
		('SND_LEADER_MUSIC_ORG_MALACCA_WAR', 		'Malacca_War', 		'DynamicResident');		
------------------------------
-- Audio_2DSounds
------------------------------	
INSERT INTO Audio_2DSounds 
		(ScriptID, 									SoundID, 								SoundType, 		DontTriggerDuplicates,	DontPlayMoreThan,	TaperSoundtrackVolume,	MinVolume, 	MaxVolume,  IsMusic, Looping)
VALUES	('AS2D_LEADER_MUSIC_ORG_MALACCA_PEACE',		'SND_LEADER_MUSIC_ORG_MALACCA_PEACE', 	'GAME_MUSIC', 						0,					0,					-1.0,			60, 		60, 		1, 		 0),
		('AS2D_LEADER_MUSIC_ORG_MALACCA_WAR', 		'SND_LEADER_MUSIC_ORG_MALACCA_WAR', 		'GAME_MUSIC', 						0,					0,					-1.0,			60, 		60, 		1,		 0);
		*/
--==========================================================================================================================
-- UNIT GRAPHICS
--==========================================================================================================================
-- ArtDefine_StrategicView
------------------------------
INSERT INTO ArtDefine_StrategicView 
		(StrategicViewType, 						TileType,	Asset)
VALUES	('ART_DEF_UNIT_ORG_MALACCAN_JONG',	'Unit', 	'JongIcon128.dds'),
		('ART_DEF_UNIT_ORG_MALACCAN_LAKSAMANA',	'Unit', 	'LaksamanaIcon128.dds');
------------------------------					
-- ArtDefine_UnitInfos
------------------------------			
--INSERT INTO ArtDefine_UnitInfos 
--		(Type, 										DamageStates,	Formation)
--SELECT	'ART_DEF_UNIT_ORG_MALACCAN_JONG',	DamageStates, 	Formation
--FROM ArtDefine_UnitInfos WHERE Type = 'ART_DEF_UNIT_CARAVEL';

INSERT INTO ArtDefine_UnitInfos(Type, DamageStates)
  VALUES ('ART_DEF_UNIT_ORG_MALACCAN_JONG', 3);

INSERT INTO ArtDefine_UnitInfos 
		(Type, 										DamageStates,	Formation)
SELECT	'ART_DEF_UNIT_ORG_MALACCAN_LAKSAMANA',	DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE Type = 'ART_DEF_UNIT_GREAT_ADMIRAL';
------------------------------
-- ArtDefine_UnitInfoMemberInfos
------------------------------
--INSERT INTO ArtDefine_UnitInfoMemberInfos
--          (UnitInfoType,                    UnitMemberInfoType,                    NumMembers)
--SELECT    'ART_DEF_UNIT_ORG_MALACCAN_JONG',     'ART_DEF_UNIT_MEMBER_ORG_MALACCAN_JONG',     NumMembers
--FROM ArtDefine_UnitInfoMemberInfos WHERE UnitInfoType = 'ART_DEF_UNIT_CARAVEL';

--INSERT INTO ArtDefine_UnitMemberCombats
--(UnitMemberType,                                 EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
--SELECT    'ART_DEF_UNIT_MEMBER_ORG_MALACCAN_JONG',    EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax,   LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack,    HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat,  ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack,      AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
--FROM ArtDefine_UnitMemberCombats WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_CARAVEL';

--INSERT INTO ArtDefine_UnitMemberCombatWeapons
--(UnitMemberType,                                 "Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
--SELECT    'ART_DEF_UNIT_MEMBER_ORG_MALACCAN_JONG',    "Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
--FROM ArtDefine_UnitMemberCombatWeapons WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_CARAVEL';

--INSERT INTO ArtDefine_UnitMemberInfos
--(Type,                                           Scale,   ZOffset, Domain, Model, MaterialTypeTag, MaterialTypeSoundOverrideTag)
--SELECT    'ART_DEF_UNIT_MEMBER_ORG_MALACCAN_JONG',    Scale,   ZOffset, Domain, Model, MaterialTypeTag, MaterialTypeSoundOverrideTag
--FROM ArtDefine_UnitMemberInfos WHERE Type = 'ART_DEF_UNIT_MEMBER_CARAVEL';




INSERT INTO ArtDefine_UnitInfoMemberInfos(UnitInfoType, UnitMemberInfoType, NumMembers)
  VALUES ('ART_DEF_UNIT_ORG_MALACCAN_JONG', 'ART_DEF_UNIT_MEMBER_ORG_MALACCAN_JONG', 1);

INSERT INTO ArtDefine_UnitMemberInfos(Type, Scale, Domain, Model, MaterialTypeTag, MaterialTypeSoundOverrideTag)
  VALUES ('ART_DEF_UNIT_MEMBER_ORG_MALACCAN_JONG', 0.140000000596046, 'Sea', 'WarJunk.fxsxml', 'WOOD', 'WOODLRG');

INSERT INTO ArtDefine_UnitMemberCombats(UnitMemberType, EnableActions, HasShortRangedAttack, HasLeftRightAttack, HasRefaceAfterCombat, HasIndependentWeaponFacing)
  VALUES ('ART_DEF_UNIT_MEMBER_ORG_MALACCAN_JONG', 'Idle Attack RunCharge AttackCity Bombard Death BombardDefend Run Fortify CombatReady AttackSurfaceToAir', 1, 1, 0, 1);

INSERT INTO ArtDefine_UnitMemberCombatWeapons(UnitMemberType, "Index", SubIndex, VisKillStrengthMin, VisKillStrengthMax, HitEffect, WeaponTypeTag, WeaponTypeSoundOverrideTag)
  VALUES ('ART_DEF_UNIT_MEMBER_ORG_MALACCAN_JONG', 0, 0, 10.0, 20.0, 'ART_DEF_VEFFECT_CANNON_IMPACT_$(TERRAIN)', 'EXPLOSIVE', 'EXPLOSION6POUND');


INSERT INTO ArtDefine_UnitInfoMemberInfos
          (UnitInfoType,                    UnitMemberInfoType,                    NumMembers)
SELECT    'ART_DEF_UNIT_ORG_MALACCAN_LAKSAMANA',     'ART_DEF_UNIT_MEMBER_ORG_MALACCAN_LAKSAMANA',     NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE UnitInfoType = 'ART_DEF_UNIT_GREAT_ADMIRAL';

INSERT INTO ArtDefine_UnitMemberCombats
(UnitMemberType,                                 EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT    'ART_DEF_UNIT_MEMBER_ORG_MALACCAN_LAKSAMANA',    EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax,   LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack,    HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat,  ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack,      AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_GREAT_ADMIRAL';

INSERT INTO ArtDefine_UnitMemberCombatWeapons
(UnitMemberType,                                 "Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT    'ART_DEF_UNIT_MEMBER_ORG_MALACCAN_LAKSAMANA',    "Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_GREAT_ADMIRAL';

INSERT INTO ArtDefine_UnitMemberInfos
(Type,                                           Scale,   ZOffset, Domain, Model, MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT    'ART_DEF_UNIT_MEMBER_ORG_MALACCAN_LAKSAMANA',    Scale,   ZOffset, Domain, Model, MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE Type = 'ART_DEF_UNIT_MEMBER_GREAT_ADMIRAL';

--==========================================================================================================================	
--==========================================================================================================================	
