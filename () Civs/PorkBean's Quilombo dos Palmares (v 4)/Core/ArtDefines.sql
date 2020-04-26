-- ======================================================================================================
-- COLORS
-- ======================================================================================================
-- Colors
---------
INSERT INTO Colors
		  (Type,                                            Red,     Green,    Blue,     Alpha)
VALUES	  ('COLOR_PLAYER_PB_PALMARES_ICON',			 0.07058823529411765,   0.12549019607843137,    0.13333333333333333, 1),
		  ('COLOR_PLAYER_PB_PALMARES_BACKGROUND',       0.5333333333333333,   0.6705882352941176,    0.058823529411764705,    1);
---------------
-- PlayerColors
---------------
INSERT INTO PlayerColors
          (Type,                              PrimaryColor,                                        SecondaryColor,                   TextColor)
VALUES    ('PLAYERCOLOR_PB_PALMARES',        'COLOR_PLAYER_PB_PALMARES_ICON',     'COLOR_PLAYER_PB_PALMARES_BACKGROUND',     'COLOR_PLAYER_WHITE_TEXT');
-- ======================================================================================================
-- ICON ATLASES
-- ======================================================================================================
-- IconTextureAtlases
---------------------
INSERT INTO IconTextureAtlases
(Atlas,                            IconSize,    Filename,                       IconsPerRow,     IconsPerColumn)
VALUES
('PALMARES_ALPHA_ATLAS',         128,        'PalmaresAlpha128.dds',        1,                 1),
('PALMARES_ALPHA_ATLAS',         80,         'PalmaresAlpha80.dds',         1,                 1),
('PALMARES_ALPHA_ATLAS',         64,         'PalmaresAlpha64.dds',         1,                 1),
('PALMARES_ALPHA_ATLAS',         48,         'PalmaresAlpha48.dds',         1,                 1),
('PALMARES_ALPHA_ATLAS',         32,         'PalmaresAlpha32.dds',         1,                 1),
('PALMARES_ALPHA_ATLAS',         24,         'PalmaresAlpha24.dds',         1,                 1),
('PALMARES_ALPHA_ATLAS',         16,         'PalmaresAlpha16.dds',         1,                 1),

('PALMARES_ICON_ATLAS',         256,        'Palmares_Atlas256.dds',        8,                 8),
('PALMARES_ICON_ATLAS',         214,         'Palmares_Atlas214.dds',         8,                 8),
('PALMARES_ICON_ATLAS',         128,         'Palmares_Atlas128.dds',         8,                 8),
('PALMARES_ICON_ATLAS',         80,         'Palmares_Atlas80.dds',         8,                 8),
('PALMARES_ICON_ATLAS',         64,         'Palmares_Atlas64.dds',         8,                 8),
('PALMARES_ICON_ATLAS',         45,         'Palmares_Atlas45.dds',         8,                 8),
('PALMARES_ICON_ATLAS',         32,         'Palmares_Atlas32.dds',         4,                 4),
    
('CAPOEIRISTA_FLAG',		32,			'Flag_Capoeirista.dds',			1,					1),
('ACTION_MOCAMBO',			64,			'Mocambo_Flag64.dds',			1,					1),
('ACTION_MOCAMBO',			45,			'Mocambo_Flag45.dds',			1,					1);

--==========================================================================================================================
-- UNIT GRAPHICS
--==========================================================================================================================	
-- ArtDefine_StrategicView
------------------------------
INSERT INTO ArtDefine_StrategicView 
		(StrategicViewType, 				TileType,		Asset)
VALUES	('ART_DEF_UNIT_PB_CAPO', 		'Unit', 		'capo_sv.dds');
------------------------------
-- ArtDefine_UnitInfos
------------------------------			
INSERT INTO ArtDefine_UnitInfos 
		(Type, 								DamageStates,	Formation)
SELECT	'ART_DEF_UNIT_PB_CAPO',			DamageStates, 	'UnFormed'
FROM ArtDefine_UnitInfos WHERE Type = 'ART_DEF_UNIT_SCOUT';
------------------------------
-- ArtDefine_UnitInfoMemberInfos
------------------------------
INSERT INTO ArtDefine_UnitInfoMemberInfos 	
		(UnitInfoType,						UnitMemberInfoType,					NumMembers)
SELECT	'ART_DEF_UNIT_PB_CAPO', 		'ART_DEF_UNIT_MEMBER_PB_CAPO',	4
FROM ArtDefine_UnitInfoMemberInfos WHERE UnitInfoType = 'ART_DEF_UNIT_SCOUT';
------------------------
-- ArtDefine_UnitMemberCombats
------------------------
INSERT INTO ArtDefine_UnitMemberCombats 
		(UnitMemberType,					EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT	'ART_DEF_UNIT_MEMBER_PB_CAPO',	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_SCOUT';
------------------------
-- ArtDefine_UnitMemberCombatWeapons
------------------------
INSERT INTO ArtDefine_UnitMemberCombatWeapons	
		(UnitMemberType,					"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_PB_CAPO',	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_SCOUT';
------------------------
-- ArtDefine_UnitMemberInfos
------------------------
INSERT INTO ArtDefine_UnitMemberInfos 	
		(Type, 								Scale,	ZOffset, Domain, Model, 			MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_PB_CAPO',	Scale,	ZOffset, Domain, 'Capoeirista.fxsxml',	MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE Type = 'ART_DEF_UNIT_MEMBER_SCOUT';
--==========================================================================================================================
-- AUDIO
--==========================================================================================================================	
-- Audio_Sounds
------------------------------	
INSERT INTO Audio_Sounds 
		(SoundID, 									Filename, 			LoadType)
VALUES	('SND_LEADER_MUSIC_PB_ZUMBI_PEACE', 		'ZumbiPeace',		'DynamicResident'),
		('SND_LEADER_MUSIC_PB_ZUMBI_WAR',			'ZumbiWar', 		'DynamicResident');		
------------------------------
-- Audio_2DSounds
------------------------------	
INSERT INTO Audio_2DSounds 
		(ScriptID, 									SoundID, 								SoundType, 		TaperSoundtrackVolume,	MinVolume, 	MaxVolume,  IsMusic, Looping)
VALUES	('AS2D_LEADER_MUSIC_PB_ZUMBI_PEACE', 		'SND_LEADER_MUSIC_PB_ZUMBI_PEACE', 	'GAME_MUSIC', 	-1.0,					35, 		35, 		1, 		 0),
		('AS2D_LEADER_MUSIC_PB_ZUMBI_WAR', 		'SND_LEADER_MUSIC_PB_ZUMBI_WAR', 		'GAME_MUSIC', 	-1.0,					35, 		35, 		1,		 0);