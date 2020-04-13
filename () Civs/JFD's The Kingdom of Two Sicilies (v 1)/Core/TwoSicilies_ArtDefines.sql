--==========================================================================================================================
-- ART DEFINES
--==========================================================================================================================	
-- IconTextureAtlases
------------------------------
INSERT INTO IconTextureAtlases 
		(Atlas, 								IconSize, 	Filename, 								IconsPerRow, 	IconsPerColumn)
VALUES	('JFD_TWO_SICILIES_ATLAS', 				256, 		'JFD_TwoSiciliesAtlas_256.dds',			2, 				2),
		('JFD_TWO_SICILIES_ATLAS', 				128, 		'JFD_TwoSiciliesAtlas_128.dds',			2, 				2),
		('JFD_TWO_SICILIES_ATLAS', 				80, 		'JFD_TwoSiciliesAtlas_80.dds',			2, 				2),
		('JFD_TWO_SICILIES_ATLAS', 				64, 		'JFD_TwoSiciliesAtlas_64.dds',			2, 				2),
		('JFD_TWO_SICILIES_ATLAS', 				45, 		'JFD_TwoSiciliesAtlas_45.dds',			2, 				2),
		('JFD_TWO_SICILIES_ATLAS', 				32, 		'JFD_TwoSiciliesAtlas_32.dds',			2, 				2),
		('JFD_TWO_SICILIES_ALPHA_ATLAS', 		128, 		'JFD_TwoSiciliesAlphaAtlas_128.dds',	1,				1),
		('JFD_TWO_SICILIES_ALPHA_ATLAS', 		80, 		'JFD_TwoSiciliesAlphaAtlas_80.dds',		1, 				1),
		('JFD_TWO_SICILIES_ALPHA_ATLAS', 		64, 		'JFD_TwoSiciliesAlphaAtlas_64.dds',		1, 				1),
		('JFD_TWO_SICILIES_ALPHA_ATLAS', 		48, 		'JFD_TwoSiciliesAlphaAtlas_48.dds',		1, 				1),
		('JFD_TWO_SICILIES_ALPHA_ATLAS', 		45, 		'JFD_TwoSiciliesAlphaAtlas_45.dds',		1, 				1),
		('JFD_TWO_SICILIES_ALPHA_ATLAS', 		32, 		'JFD_TwoSiciliesAlphaAtlas_32.dds',		1, 				1),
		('JFD_TWO_SICILIES_ALPHA_ATLAS', 		24, 		'JFD_TwoSiciliesAlphaAtlas_24.dds',		1, 				1),
		('JFD_TWO_SICILIES_ALPHA_ATLAS', 		16, 		'JFD_TwoSiciliesAlphaAtlas_16.dds',		1, 				1),
		('JFD_STEAM_FRIGATE_FLAG_ART_ATLAS', 	32, 		'JFD_SteamFrigateFlag_32.dds',			1, 				1);
------------------------------
-- Colors
------------------------------		
INSERT INTO Colors 
		(Type, 											Red, 	Green, 	Blue, 	Alpha)
VALUES	('COLOR_PLAYER_JFD_TWO_SICILIES_ICON', 			0,		0.270, 	0.223, 	1),
		('COLOR_PLAYER_JFD_TWO_SICILIES_BACKGROUND',	0.686, 	0.776, 	0.717, 	1);
------------------------------
-- PlayerColors
------------------------------			
INSERT INTO PlayerColors 
		(Type, 								PrimaryColor, 							SecondaryColor, 							 TextColor)
VALUES	('PLAYERCOLOR_JFD_TWO_SICILIES',	'COLOR_PLAYER_JFD_TWO_SICILIES_ICON',	'COLOR_PLAYER_JFD_TWO_SICILIES_BACKGROUND',	 'COLOR_PLAYER_WHITE_TEXT');
--==========================================================================================================================
-- AUDIO
--==========================================================================================================================	
-- Audio_Sounds
------------------------------	
INSERT INTO Audio_Sounds 
		(SoundID, 									Filename, 				LoadType)
VALUES	('SND_BUILDING_JFD_WINE_CELLAR', 			'WineCellar',			'DynamicResident'),
		('SND_LEADER_MUSIC_JFD_FERDINAND_I_PEACE', 	'FerdinandI_Peace',		'DynamicResident'),
		('SND_LEADER_MUSIC_JFD_FERDINAND_I_WAR', 	'FerdinandI_War', 		'DynamicResident');
------------------------------
-- Audio_2DSounds
------------------------------	
INSERT INTO Audio_2DSounds 
		(ScriptID, 									SoundID, 									SoundType, 		TaperSoundtrackVolume,	MinVolume, 	MaxVolume,  IsMusic, Looping)
VALUES	('AS2D_BUILDING_JFD_WINE_CELLAR',			'SND_BUILDING_JFD_WINE_CELLAR',				'GAME_SFX', 	-1.0,					100, 		100, 		0, 		 0),
		('AS2D_LEADER_MUSIC_JFD_FERDINAND_I_PEACE', 'SND_LEADER_MUSIC_JFD_FERDINAND_I_PEACE',	'GAME_MUSIC', 	-1.0,					60, 		60, 		1, 		 0),
		('AS2D_LEADER_MUSIC_JFD_FERDINAND_I_WAR', 	'SND_LEADER_MUSIC_JFD_FERDINAND_I_WAR', 	'GAME_MUSIC', 	-1.0,					60, 		60, 		1,		 0);
--==========================================================================================================================
-- UNIT/RESOURCE GRAPHICS
--==========================================================================================================================	
-- ArtDefine_StrategicView
------------------------------
INSERT INTO ArtDefine_StrategicView 
		(StrategicViewType, 				TileType,	Asset)
VALUES	('ART_DEF_UNIT_JFD_STEAM_FRIGATE', 	'Unit', 	'sv_SteamFrigate.dds');
------------------------------
-- ArtDefine_UnitInfos
------------------------------			
INSERT INTO ArtDefine_UnitInfos 
		(Type, 								DamageStates,	Formation)
SELECT	'ART_DEF_UNIT_JFD_STEAM_FRIGATE',	DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE Type = 'ART_DEF_UNIT_FRIGATE';
------------------------------
-- ArtDefine_UnitInfoMemberInfos
------------------------------
INSERT INTO ArtDefine_UnitInfoMemberInfos 	
		(UnitInfoType,						UnitMemberInfoType,							NumMembers)
SELECT	'ART_DEF_UNIT_JFD_STEAM_FRIGATE', 	'ART_DEF_UNIT_MEMBER_JFD_STEAM_FRIGATE',	NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE UnitInfoType = 'ART_DEF_UNIT_FRIGATE';
------------------------
-- ArtDefine_UnitMemberCombats
------------------------
INSERT INTO ArtDefine_UnitMemberCombats 
		(UnitMemberType,						 EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT	'ART_DEF_UNIT_MEMBER_JFD_STEAM_FRIGATE', EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_FRIGATE';
------------------------
-- ArtDefine_UnitMemberCombatWeapons
------------------------
INSERT INTO ArtDefine_UnitMemberCombatWeapons	
		(UnitMemberType,						 "Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_JFD_STEAM_FRIGATE', "Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_FRIGATE';
------------------------
-- ArtDefine_UnitMemberInfos
------------------------
INSERT INTO ArtDefine_UnitMemberInfos 	
		(Type, 										Scale,	ZOffset, Domain, Model, 				 MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_JFD_STEAM_FRIGATE',	Scale,	ZOffset, Domain, 'SteamFrigate.fxsxml',	 MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE Type = 'ART_DEF_UNIT_MEMBER_FRIGATE';
--==========================================================================================================================	
--==========================================================================================================================	
