-- ======================================================================================================
-- ICON ATLASES
-- ======================================================================================================
-- IconTextureAtlases
---------------------
INSERT INTO IconTextureAtlases
(Atlas,                             IconSize,    Filename,                        IconsPerRow,       IconsPerColumn)
VALUES    ('THP_SOMALIA_ATLAS',     256,        'THP_SomaliaAtlas256.dds',        2,                 2),
('THP_SOMALIA_ATLAS',               128,        'THP_SomaliaAtlas128.dds',        2,                 2),
('THP_SOMALIA_ATLAS',               80,         'THP_SomaliaAtlas80.dds',         2,                 2),
('THP_SOMALIA_ATLAS',               64,         'THP_SomaliaAtlas64.dds',         2,                 2),
('THP_SOMALIA_ATLAS',               45,         'THP_SomaliaAtlas45.dds',         2,                 2),
('THP_SOMALIA_ATLAS',               32,         'THP_SomaliaAtlas32.dds',         2,                 2),
('THP_SOMALIA_ALPHA_ATLAS',         128,        'THP_SomaliaAlpha128.dds',        1,                 1),
('THP_SOMALIA_ALPHA_ATLAS',         64,         'THP_SomaliaAlpha64.dds',         1,                 1),
('THP_SOMALIA_ALPHA_ATLAS',         48,         'THP_SomaliaAlpha48.dds',         1,                 1),
('THP_SOMALIA_ALPHA_ATLAS',         32,         'THP_SomaliaAlpha32.dds',         1,                 1),
('THP_SOMALIA_ALPHA_ATLAS',         24,         'THP_SomaliaAlpha24.dds',         1,                 1),
('THP_SOMALIA_ALPHA_ATLAS',         16,         'THP_SomaliaAlpha16.dds',         1,                 1),
('THP_UNIT_DUUB_CAS_FLAG_ATLAS',    32,         'Unit_DuubCas_Flag_32.dds',       1,                 1),
('THP_UNIT_GABYAGA_FLAG_ATLAS',     32,         'Unit_Gabyaga_Flag_32.dds',       1,                 1);
-- ======================================================================================================
-- COLORS
-- ======================================================================================================
-- Colors
---------
INSERT INTO Colors
(Type,                                        Red,     Green,    Blue,     Alpha)
VALUES    ('COLOR_PLAYER_THP_SOMALIA_ICON',   0.749,   0.906,    1.000,    1),
('COLOR_PLAYER_THP_SOMALIA_BACKGROUND',       0.000,   0.447,    0.737,    1);
---------------
-- PlayerColors
---------------
INSERT INTO PlayerColors
          (Type,                          PrimaryColor,                    SecondaryColor,                   TextColor)
VALUES    ('PLAYERCOLOR_THP_SOMALIA',        'COLOR_PLAYER_THP_SOMALIA_ICON',     'COLOR_PLAYER_THP_SOMALIA_BACKGROUND',     'COLOR_PLAYER_WHITE_TEXT');
-- ======================================================================================================
-- UNIT ART
-- ======================================================================================================
-- ArtDefine_StrategicView
--------------------------
INSERT INTO ArtDefine_StrategicView 
		(StrategicViewType, 		         TileType,		 Asset)
VALUES	('ART_DEF_UNIT_THP_DUUB_CAS',	    'Unit', 		'sv_duubcas.dds'),
        ('ART_DEF_UNIT_THP_GABYAGA',        'Unit',         'sv_gabyaga.dds');
----------------------
-- ArtDefine_UnitInfos
----------------------
INSERT INTO ArtDefine_UnitInfos
          (Type,                               DamageStates,    Formation)
SELECT    'ART_DEF_UNIT_THP_DUUB_CAS',         DamageStates,    Formation
FROM ArtDefine_UnitInfos WHERE Type = 'ART_DEF_UNIT_MARINE';

INSERT INTO ArtDefine_UnitInfos
        (Type,                       DamageStates,  Formation)
VALUES  ('ART_DEF_UNIT_THP_GABYAGA', 1,            'EarlyGreatMerchant');
--------------------------------
-- ArtDefine_UnitInfoMemberInfos
--------------------------------
INSERT INTO ArtDefine_UnitInfoMemberInfos
          (UnitInfoType,                    UnitMemberInfoType,                    NumMembers)
SELECT    'ART_DEF_UNIT_THP_DUUB_CAS',     'ART_DEF_UNIT_MEMBER_THP_DUUB_CAS',     NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE UnitInfoType = 'ART_DEF_UNIT_MARINE';

INSERT INTO ArtDefine_UnitInfoMemberInfos
        (UnitInfoType,                UnitMemberInfoType,                       NumMembers)
VALUES  ('ART_DEF_UNIT_THP_GABYAGA', 'ART_DEF_UNIT_MEMBER_THP_GABYAGA_WRITER',  1),
        ('ART_DEF_UNIT_THP_GABYAGA', 'ART_DEF_UNIT_MEMBER_THP_GABYAGA_CAMEL',   1);
------------------------------
-- ArtDefine_UnitMemberCombats
------------------------------
INSERT INTO ArtDefine_UnitMemberCombats
(UnitMemberType,                                 EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT    'ART_DEF_UNIT_MEMBER_THP_DUUB_CAS',    EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax,   LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack,    HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat,  ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack,      AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_MARINE';

INSERT INTO ArtDefine_UnitMemberCombats
       (UnitMemberType,                            EnableActions,                 HasRefaceAfterCombat)
VALUES ('ART_DEF_UNIT_MEMBER_THP_GABYAGA_WRITER', 'Idle Death BombardDefend Run', 1);

INSERT INTO ArtDefine_UnitMemberCombats
       (UnitMemberType,                           EnableActions,                 HasRefaceAfterCombat)
VALUES ('ART_DEF_UNIT_MEMBER_THP_GABYAGA_CAMEL', 'Idle Death BombardDefend Run', 1);
------------------------------------
-- ArtDefine_UnitMemberCombatWeapons
------------------------------------
INSERT INTO ArtDefine_UnitMemberCombatWeapons
(UnitMemberType,                                 "Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT    'ART_DEF_UNIT_MEMBER_THP_DUUB_CAS',    "Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_MARINE';
----------------------------
-- ArtDefine_UnitMemberInfos
----------------------------
INSERT INTO ArtDefine_UnitMemberInfos
(Type,                                           Scale,   ZOffset, Domain, Model,               MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT    'ART_DEF_UNIT_MEMBER_THP_DUUB_CAS',    Scale,   ZOffset, Domain, 'redberet.fxsxml',   MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE Type = 'ART_DEF_UNIT_MEMBER_MARINE';

INSERT INTO ArtDefine_UnitMemberInfos
(Type,                                                 Scale,   ZOffset, Domain, Model,    MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT    'ART_DEF_UNIT_MEMBER_THP_GABYAGA_WRITER',    Scale,   ZOffset, Domain, Model,    MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE Type = 'ART_DEF_UNIT_MEMBER_AFRIMALE2';

INSERT INTO ArtDefine_UnitMemberInfos
(Type, Scale, Model, MaterialTypeTag, MaterialTypeSoundOverrideTag)
VALUES ('ART_DEF_UNIT_MEMBER_THP_GABYAGA_CAMEL', 0.119999997317791, 'Assets/Units/GreatPeople/Merchant/Early/GreatMerchant_Early_Camel_V1.fxsxml', 'CLOTH', 'FLESH');
-- ======================================================================================================
-- AUDIO
-- ======================================================================================================
-- Audio_Sounds
---------------
INSERT INTO Audio_Sounds 
		(SoundID, 							          Filename, 		 LoadType)
VALUES	('SND_LEADER_MUSIC_THP_SIAD_BARRE_PEACE',    'Somalia_Peace',   'DynamicResident'),
		('SND_LEADER_MUSIC_THP_SIAD_BARRE_WAR',      'Somalia_War', 	'DynamicResident');
-----------------
-- Audio_2DSounds
-----------------
INSERT INTO Audio_2DSounds 
		(ScriptID, 										SoundID, 									SoundType, 		TaperSoundtrackVolume,	MinVolume, 	MaxVolume,  IsMusic, Looping)
VALUES	('AS2D_LEADER_MUSIC_THP_SIAD_BARRE_PEACE', 		'SND_LEADER_MUSIC_THP_SIAD_BARRE_PEACE', 		'GAME_MUSIC', 	-1.0,					100, 		100, 		1, 		 0),
		('AS2D_LEADER_MUSIC_THP_SIAD_BARRE_WAR', 			'SND_LEADER_MUSIC_THP_SIAD_BARRE_WAR', 		'GAME_MUSIC', 	-1.0,					100, 		100, 		1,		 0);
-- ======================================================================================================
-- ======================================================================================================
