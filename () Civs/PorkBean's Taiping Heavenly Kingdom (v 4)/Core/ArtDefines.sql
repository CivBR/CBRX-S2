-- ======================================================================================================
-- COLORS
-- ======================================================================================================
-- Colors
---------
INSERT INTO Colors
		  (Type,                                            Red,     Green,    Blue,     Alpha)
VALUES	  ('COLOR_PLAYER_PB_TAIPING_ICON',			 0.803921568627451,   1,    0.984313725490196,    1),
		  ('COLOR_PLAYER_PB_TAIPING_BACKGROUND',       0,   0.6588235294117647,    0.3843137254901961, 1);
---------------
-- PlayerColors
---------------
INSERT INTO PlayerColors
          (Type,                              PrimaryColor,                                        SecondaryColor,                   TextColor)
VALUES    ('PLAYERCOLOR_PB_TAIPING',        'COLOR_PLAYER_PB_TAIPING_ICON',     'COLOR_PLAYER_PB_TAIPING_BACKGROUND',     'COLOR_PLAYER_WHITE_TEXT');
-- ======================================================================================================
-- ICON ATLASES
-- ======================================================================================================
-- IconTextureAtlases
---------------------
INSERT INTO IconTextureAtlases
(Atlas,                            IconSize,    Filename,                       IconsPerRow,     IconsPerColumn)
VALUES
('TAIPING_ALPHA_ATLAS',         128,        'TaipingAlpha128.dds',        1,                 1),
('TAIPING_ALPHA_ATLAS',         80,         'TaipingAlpha80.dds',         1,                 1),
('TAIPING_ALPHA_ATLAS',         64,         'TaipingAlpha64.dds',         1,                 1),
('TAIPING_ALPHA_ATLAS',         48,         'TaipingAlpha48.dds',         1,                 1),
('TAIPING_ALPHA_ATLAS',         32,         'TaipingAlpha32.dds',         1,                 1),
('TAIPING_ALPHA_ATLAS',         24,         'TaipingAlpha24.dds',         1,                 1),
('TAIPING_ALPHA_ATLAS',         16,         'TaipingAlpha16.dds',         1,                 1),

('TAIPING_ICON_ATLAS',         256,        'Taiping_Atlas256.dds',        8,                 8),
('TAIPING_ICON_ATLAS',         214,         'Taiping_Atlas214.dds',         8,                 8),
('TAIPING_ICON_ATLAS',         128,         'Taiping_Atlas128.dds',         8,                 8),
('TAIPING_ICON_ATLAS',         80,         'Taiping_Atlas80.dds',         8,                 8),
('TAIPING_ICON_ATLAS',         64,         'Taiping_Atlas64.dds',         8,                 8),
('TAIPING_ICON_ATLAS',         45,         'Taiping_Atlas45.dds',         8,                 8),
('TAIPING_ICON_ATLAS',         32,         'Taiping_Atlas32.dds',         4,                 4),

('TAIPING_RELIGION_ATLAS',         256,        'TaipingReligion_Atlas256.dds',        1,                 1),
('TAIPING_RELIGION_ATLAS',         214,        'TaipingReligion_Atlas214.dds',        1,			     1),
('TAIPING_RELIGION_ATLAS',         128,        'TaipingReligion_Atlas128.dds',        1,                 1),
('TAIPING_RELIGION_ATLAS',         80,         'TaipingReligion_Atlas80.dds',         1,                 1),
('TAIPING_RELIGION_ATLAS',         64,         'TaipingReligion_Atlas64.dds',         1,                 1),
('TAIPING_RELIGION_ATLAS',         48,         'TaipingReligion_Atlas48.dds',         1,                 1),
('TAIPING_RELIGION_ATLAS',         32,         'TaipingReligion_Atlas32.dds',         1,                 1),
('TAIPING_RELIGION_ATLAS',         24,         'TaipingReligion_Atlas24.dds',         1,                 1),
('TAIPING_RELIGION_ATLAS',         16,         'TaipingReligion_Atlas16.dds',         1,                 1),

('CHANG_MAO_FLAG',         32,         'changmao_flag.dds',         1,                 1);

INSERT INTO IconFontTextures
(IconFontTexture,                            IconFontTextureFile)
VALUES
('ICON_FONT_TEXTURE_PB_GOD_WORSHIPPING', 'TaipingFontIcons_22');

INSERT INTO IconFontMapping
(IconName,                            IconMapping,	IconFontTexture)
VALUES
('ICON_RELIGION_PB_GOD_WORSHIPPING', 1, 'ICON_FONT_TEXTURE_PB_GOD_WORSHIPPING');

--==========================================================================================================================
-- AUDIO
--==========================================================================================================================	
-- Audio_Sounds
------------------------------	
INSERT INTO Audio_Sounds 
		(SoundID, 									Filename, 			LoadType)
VALUES	('SND_LEADER_MUSIC_PB_HONG_PEACE', 		'HongPeace',		'DynamicResident'),
		('SND_LEADER_MUSIC_PB_HONG_WAR',			'HongWar', 		'DynamicResident');		
------------------------------
-- Audio_2DSounds
------------------------------	
INSERT INTO Audio_2DSounds 
		(ScriptID, 									SoundID, 								SoundType, 		TaperSoundtrackVolume,	MinVolume, 	MaxVolume,  IsMusic, Looping)
VALUES	('AS2D_LEADER_MUSIC_PB_HONG_PEACE', 		'SND_LEADER_MUSIC_PB_HONG_PEACE', 	'GAME_MUSIC', 	-1.0,					60, 		60, 		1, 		 0),
		('AS2D_LEADER_MUSIC_PB_HONG_WAR', 			'SND_LEADER_MUSIC_PB_HONG_WAR', 		'GAME_MUSIC', 	-1.0,					60, 		60, 		1,		 0);
--==========================================================================================================================
-- UNIT GRAPHICS
--==========================================================================================================================	
-- ArtDefine_StrategicView
------------------------------
INSERT INTO ArtDefine_StrategicView 
		(StrategicViewType, 					TileType,		Asset)
VALUES	('ART_DEF_UNIT_PB_CHANG_MAO', 			'Unit', 		'sv_changmao.dds');
------------------------------
-- ArtDefine_UnitInfos
------------------------------		
INSERT INTO ArtDefine_UnitInfos 
		(Type, 									DamageStates,	Formation)
SELECT	'ART_DEF_UNIT_PB_CHANG_MAO', 			DamageStates, 	'UnFormed'
FROM ArtDefine_UnitInfos WHERE	Type = 'ART_DEF_UNIT_RIFLEMAN';
------------------------------
-- ArtDefine_UnitInfoMemberInfos
------------------------------
INSERT INTO ArtDefine_UnitInfoMemberInfos 	
		(UnitInfoType,							UnitMemberInfoType,						NumMembers)
SELECT	'ART_DEF_UNIT_PB_CHANG_MAO', 			'ART_DEF_UNIT_MEMBER_PB_CHANG_MAO_1', 	14
FROM ArtDefine_UnitInfoMemberInfos WHERE UnitInfoType = 'ART_DEF_UNIT_RIFLEMAN';
------------------------------
-- ArtDefine_UnitMemberCombats
------------------------------
INSERT INTO ArtDefine_UnitMemberCombats 
		(UnitMemberType,						EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT	'ART_DEF_UNIT_MEMBER_PB_CHANG_MAO_1',		EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_RIFLEMAN';
------------------------------
-- ArtDefine_UnitMemberCombatWeapons
------------------------------
INSERT INTO ArtDefine_UnitMemberCombatWeapons	
		(UnitMemberType,						"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_PB_CHANG_MAO_1',		"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_RIFLEMAN';
------------------------------
-- ArtDefine_UnitMemberInfos
------------------------------
INSERT INTO ArtDefine_UnitMemberInfos 	
		(Type, 									Scale, ZOffset, Domain, Model, 					MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_PB_CHANG_MAO_1',		Scale, ZOffset, Domain, 'civ5_chirm1.fxsxml',	MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE Type = 'ART_DEF_UNIT_MEMBER_RIFLEMAN';
--==========================================================================================================================	
--==========================================================================================================================	
