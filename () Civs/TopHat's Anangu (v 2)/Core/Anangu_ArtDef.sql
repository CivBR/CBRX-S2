-- ======================================================================================================
-- ICON ATLASES
-- ======================================================================================================
-- IconTextureAtlases
---------------------
INSERT INTO IconTextureAtlases
(Atlas,                            IconSize,    Filename,                       IconsPerRow,     IconsPerColumn)
VALUES    ('THP_ANANGU_ATLAS',     256,        'THP_AnanguAtlas256.dds',        2,                 2),
('THP_ANANGU_ATLAS',               128,        'THP_AnanguAtlas128.dds',        2,                 2),
('THP_ANANGU_ATLAS',               80,         'THP_AnanguAtlas80.dds',         2,                 2),
('THP_ANANGU_ATLAS',               64,         'THP_AnanguAtlas64.dds',         2,                 2),
('THP_ANANGU_ATLAS',               45,         'THP_AnanguAtlas45.dds',         2,                 2),
('THP_ANANGU_ATLAS',               32,         'THP_AnanguAtlas32.dds',         2,                 2),
('THP_ANANGU_ALPHA_ATLAS',         128,        'THP_AnanguAlpha128.dds',        1,                 1),
('THP_ANANGU_ALPHA_ATLAS',         64,         'THP_AnanguAlpha64.dds',         1,                 1),
('THP_ANANGU_ALPHA_ATLAS',         48,         'THP_AnanguAlpha48.dds',         1,                 1),
('THP_ANANGU_ALPHA_ATLAS',         32,         'THP_AnanguAlpha32.dds',         1,                 1),
('THP_ANANGU_ALPHA_ATLAS',         24,         'THP_AnanguAlpha24.dds',         1,                 1),
('THP_ANANGU_ALPHA_ATLAS',         16,         'THP_AnanguAlpha16.dds',         1,                 1),
('THP_UNIT_WARMALA_FLAG_ATLAS',    32,         'Unit_Warmala_Flag_32.dds',      1,                 1);
-- ======================================================================================================
-- COLORS
-- ======================================================================================================
-- Colors
---------
INSERT INTO Colors
(Type,                                       Red,     Green,    Blue,     Alpha)
VALUES    ('COLOR_PLAYER_THP_ANANGU_ICON',   0.867,   0.576,    0.110,    1),
('COLOR_PLAYER_THP_ANANGU_BACKGROUND',       0.478,   0.173,    0.090,    1);
---------------
-- PlayerColors
---------------
INSERT INTO PlayerColors
          (Type,                              PrimaryColor,                                        SecondaryColor,                   TextColor)
VALUES    ('PLAYERCOLOR_THP_ANANGU',        'COLOR_PLAYER_THP_ANANGU_ICON',     'COLOR_PLAYER_THP_ANANGU_BACKGROUND',     'COLOR_PLAYER_WHITE_TEXT');
-- ======================================================================================================
-- UNIT ART
-- ======================================================================================================
-- ArtDefine_StrategicView
--------------------------
INSERT INTO ArtDefine_StrategicView 
		(StrategicViewType, 		    	 TileType,		 Asset)
VALUES	('ART_DEF_UNIT_THP_WARMALA',		'Unit', 		'sv_warmala.dds');
----------------------
-- ArtDefine_UnitInfos
----------------------
INSERT INTO ArtDefine_UnitInfos 
		(Type, 								DamageStates,	Formation)
SELECT	'ART_DEF_UNIT_THP_WARMALA',			DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE Type = 'ART_DEF_UNIT_SCOUT';
--------------------------------
-- ArtDefine_UnitInfoMemberInfos
--------------------------------
INSERT INTO ArtDefine_UnitInfoMemberInfos 	
		(UnitInfoType,					 UnitMemberInfoType,				     NumMembers)
SELECT	'ART_DEF_UNIT_THP_WARMALA', 	'ART_DEF_UNIT_MEMBER_THP_WARMALA',	 NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE UnitInfoType = 'ART_DEF_UNIT_SCOUT';
------------------------------
-- ArtDefine_UnitMemberCombats
------------------------------
INSERT INTO ArtDefine_UnitMemberCombats 
    (UnitMemberType,					    EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT	'ART_DEF_UNIT_MEMBER_THP_WARMALA',	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax,   LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack,    HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat,  ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack,      AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_SCOUT';
------------------------------------
-- ArtDefine_UnitMemberCombatWeapons
------------------------------------
INSERT INTO ArtDefine_UnitMemberCombatWeapons	
		(UnitMemberType,					"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_THP_WARMALA',	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_SCOUT';
----------------------------
-- ArtDefine_UnitMemberInfos
----------------------------
INSERT INTO ArtDefine_UnitMemberInfos
(Type,                                          Scale,    ZOffset, Domain, Model,                      MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT    'ART_DEF_UNIT_MEMBER_THP_WARMALA',    Scale,    ZOffset, Domain, 'EthiopianScout.fxsxml',    MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE Type = 'ART_DEF_UNIT_MEMBER_SCOUT';
-- ======================================================================================================
-- AUDIO
-- ======================================================================================================
-- Audio_Sounds
---------------
INSERT INTO Audio_Sounds 
		(SoundID, 									 Filename, 		    LoadType)
VALUES	('SND_LEADER_MUSIC_THP_TJILPI_PEACE', 		'Anangu_Peace',    'DynamicResident'),
		('SND_LEADER_MUSIC_THP_TJILPI_WAR', 		'Anangu_War', 	   'DynamicResident');
-----------------
-- Audio_2DSounds
-----------------
INSERT INTO Audio_2DSounds 
		(ScriptID, 										SoundID, 									SoundType, 		TaperSoundtrackVolume,	MinVolume, 	MaxVolume,  IsMusic, Looping)
VALUES	('AS2D_LEADER_MUSIC_THP_TJILPI_PEACE', 		'SND_LEADER_MUSIC_THP_TJILPI_PEACE', 		'GAME_MUSIC', 	-1.0,					65, 		65, 		1, 		 0),
		('AS2D_LEADER_MUSIC_THP_TJILPI_WAR', 			'SND_LEADER_MUSIC_THP_TJILPI_WAR', 		'GAME_MUSIC', 	-1.0,					85, 		85, 		1,		 0);


-- ======================================================================================================
-- ======================================================================================================
