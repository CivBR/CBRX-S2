-- ======================================================================================================
-- ICON ATLASES
-- ======================================================================================================
-- IconTextureAtlases
---------------------
INSERT INTO IconTextureAtlases
(Atlas,                               IconSize,    Filename,                          IconsPerRow,       IconsPerColumn)
VALUES    ('THP_NORTHYUAN_ATLAS',     256,        'THP_MandukhaiAtlas256.dds',        2,                 2),
('THP_NORTHYUAN_ATLAS',               128,        'THP_MandukhaiAtlas128.dds',        2,                 2),
('THP_NORTHYUAN_ATLAS',               80,         'THP_MandukhaiAtlas80.dds',         2,                 2),
('THP_NORTHYUAN_ATLAS',               64,         'THP_MandukhaiAtlas64.dds',         2,                 2),
('THP_NORTHYUAN_ATLAS',               45,         'THP_MandukhaiAtlas45.dds',         2,                 2),
('THP_NORTHYUAN_ATLAS',               32,         'THP_MandukhaiAtlas32.dds',         2,                 2),
('THP_NORTHYUAN_ALPHA_ATLAS',         128,        'THP_MandukhaiAlpha128.dds',        1,                 1),
('THP_NORTHYUAN_ALPHA_ATLAS',         80,         'THP_MandukhaiAlpha80.dds',         1,                 1),
('THP_NORTHYUAN_ALPHA_ATLAS',         64,         'THP_MandukhaiAlpha64.dds',         1,                 1),
('THP_NORTHYUAN_ALPHA_ATLAS',         48,         'THP_MandukhaiAlpha48.dds',         1,                 1),
('THP_NORTHYUAN_ALPHA_ATLAS',         32,         'THP_MandukhaiAlpha32.dds',         1,                 1),
('THP_NORTHYUAN_ALPHA_ATLAS',         24,         'THP_MandukhaiAlpha24.dds',         1,                 1),
('THP_NORTHYUAN_ALPHA_ATLAS',         16,         'THP_MandukhaiAlpha16.dds',         1,                 1),
('THP_UNIT_HUIHUI_PAO_FLAG_ATLAS',    32,         'Unit_HuihuiPao_Flag_32.dds',       1,                 1),
('THP_UNIT_CHONGZU_FLAG_ATLAS',       32,         'Unit_Chongzu_Flag_32.dds',         1,                 1);
-- ======================================================================================================
-- COLORS
-- ======================================================================================================
-- Colors
---------
INSERT INTO Colors
(Type,                                          Red,     Green,    Blue,     Alpha)
VALUES    ('COLOR_PLAYER_THP_NORTHYUAN_ICON',   0.467,   0.702,    0.882,    1),
('COLOR_PLAYER_THP_NORTHYUAN_BACKGROUND',       0.443,   0.180,    0.278,    1);
---------------
-- PlayerColors
---------------
INSERT INTO PlayerColors
          (Type,                              PrimaryColor,                                        SecondaryColor,                   TextColor)
VALUES    ('PLAYERCOLOR_THP_NORTHYUAN',        'COLOR_PLAYER_THP_NORTHYUAN_ICON',     'COLOR_PLAYER_THP_NORTHYUAN_BACKGROUND',     'COLOR_PLAYER_WHITE_TEXT');
-- ======================================================================================================
-- UNIT ART
-- ======================================================================================================
-- ArtDefine_StrategicView
--------------------------
INSERT INTO ArtDefine_StrategicView 
		(StrategicViewType, 		        TileType,    Asset)
VALUES	('ART_DEF_UNIT_THP_HUIHUI_PAO',		'Unit', 	'sv_huihuipao.dds'),
        ('ART_DEF_UNIT_THP_CHONGZU',        'Unit',     'sv_chongzu.dds');
----------------------
-- ArtDefine_UnitInfos
----------------------
INSERT INTO ArtDefine_UnitInfos 
		(Type, 								    DamageStates,	Formation)
SELECT	'ART_DEF_UNIT_THP_HUIHUI_PAO',			DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE Type = 'ART_DEF_UNIT_TREBUCHET';

INSERT INTO ArtDefine_UnitInfos
       (Type,                       DamageStates,  Formation)
VALUES ('ART_DEF_UNIT_THP_CHONGZU', 1,            'HonorableGunpowder');
--------------------------------
-- ArtDefine_UnitInfoMemberInfos
--------------------------------
INSERT INTO ArtDefine_UnitInfoMemberInfos 	
		(UnitInfoType,			         UnitMemberInfoType,				     NumMembers)
SELECT	'ART_DEF_UNIT_THP_HUIHUI_PAO', 	'ART_DEF_UNIT_MEMBER_THP_HUIHUI_PAO',	 NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE UnitInfoType = 'ART_DEF_UNIT_TREBUCHET';

INSERT INTO ArtDefine_UnitInfoMemberInfos
       (UnitInfoType,                UnitMemberInfoType,               NumMembers)
VALUES ('ART_DEF_UNIT_THP_CHONGZU', 'ART_DEF_UNIT_MEMBER_THP_CHONGZU', 14);
------------------------------
-- ArtDefine_UnitMemberCombats
------------------------------
INSERT INTO ArtDefine_UnitMemberCombats 
    (UnitMemberType,					EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT	'ART_DEF_UNIT_MEMBER_THP_HUIHUI_PAO',	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax,   LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack,    HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat,  ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack,      AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_TREBUCHET';

INSERT INTO ArtDefine_UnitMemberCombats
(UnitMemberType,                            EnableActions, ShortMoveRadius, ShortMoveRate, TargetHeight, HasShortRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat)
VALUES ('ART_DEF_UNIT_MEMBER_THP_CHONGZU', 'Idle Attack RunCharge AttackCity Bombard Death BombardDefend Run Fortify CombatReady Walk AttackCharge', 12.0, 0.349999994039536, 8.0, 1, 1, 1);
------------------------------------
-- ArtDefine_UnitMemberCombatWeapons
------------------------------------
INSERT INTO ArtDefine_UnitMemberCombatWeapons	
		(UnitMemberType,					"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_THP_HUIHUI_PAO',	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_TREBUCHET';

INSERT INTO ArtDefine_UnitMemberCombatWeapons
       (UnitMemberType,                    "Index", SubIndex,  WeaponTypeTag,  WeaponTypeSoundOverrideTag)
VALUES ('ART_DEF_UNIT_MEMBER_THP_CHONGZU',  0,      0,        'BULLET',       'BULLET');
----------------------------
-- ArtDefine_UnitMemberInfos
----------------------------
INSERT INTO ArtDefine_UnitMemberInfos
(Type,                                             Scale,    ZOffset, Domain, Model,    MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT    'ART_DEF_UNIT_MEMBER_THP_HUIHUI_PAO',    Scale,    ZOffset, Domain, Model,    MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE Type = 'ART_DEF_UNIT_MEMBER_TREBUCHET';

INSERT INTO ArtDefine_UnitMemberInfos
       (Type,                              Scale,              Model,                  MaterialTypeTag, MaterialTypeSoundOverrideTag)
VALUES ('ART_DEF_UNIT_MEMBER_THP_CHONGZU', 0.140000000596046, 'tcmFireLancer.fxsxml', 'CLOTH', 'FLESH');
-- ======================================================================================================
-- AUDIO
-- ======================================================================================================
-- Audio_Sounds
---------------
INSERT INTO Audio_Sounds 
		(SoundID, 									 Filename, 		      LoadType)
VALUES	('SND_LEADER_MUSIC_THP_NORTHYUAN_PEACE', 	'Mandukhai_Peace',   'DynamicResident'),
		('SND_LEADER_MUSIC_THP_NORTHYUAN_WAR', 		'Mandukhai_War', 	 'DynamicResident');
-----------------
-- Audio_2DSounds
-----------------
INSERT INTO Audio_2DSounds 
		(ScriptID, 										SoundID, 									SoundType, 		TaperSoundtrackVolume,	MinVolume, 	MaxVolume,  IsMusic, Looping)
VALUES	('AS2D_LEADER_MUSIC_THP_NORTHYUAN_PEACE', 		'SND_LEADER_MUSIC_THP_NORTHYUAN_PEACE', 		'GAME_MUSIC', 	-1.0,					100, 		100, 		1, 		 0),
		('AS2D_LEADER_MUSIC_THP_NORTHYUAN_WAR', 			'SND_LEADER_MUSIC_THP_NORTHYUAN_WAR', 		'GAME_MUSIC', 	-1.0,					100, 		100, 		1,		 0);
-- ======================================================================================================
-- ======================================================================================================
