--==========================================================================================================================
-- ART DEFINES
--==========================================================================================================================	
-- IconTextureAtlases
------------------------------
INSERT INTO IconTextureAtlases 
		(Atlas, 									IconSize, 	Filename, 					IconsPerRow, 	IconsPerColumn)
VALUES	('PG_GRANCOLOMBIA_ATLAS', 							256, 		'GranColombiaIcons256.dds',			3, 				2),
		('PG_GRANCOLOMBIA_ATLAS', 							128, 		'GranColombiaIcons128.dds',			3, 				2),
		('PG_GRANCOLOMBIA_ATLAS', 							80, 		'GranColombiaIcons80.dds',			3, 				2),
		('PG_GRANCOLOMBIA_ATLAS', 							64, 		'GranColombiaIcons64.dds',			3, 				2),
		('PG_GRANCOLOMBIA_ATLAS', 							45, 		'GranColombiaIcons45.dds',			3, 				2),
		('PG_GRANCOLOMBIA_ATLAS', 							32, 		'GranColombiaIcons32.dds',			3, 				2),
		('PG_GRANCOLOMBIA_ALPHA_ATLAS', 					128, 		'GranColombiaIcons128.dds',			1,				2),
		('PG_GRANCOLOMBIA_ALPHA_ATLAS', 					80, 		'GranColombiaIcons80.dds',			1, 				2),
		('PG_GRANCOLOMBIA_ALPHA_ATLAS', 					64, 		'GranColombiaIcons64.dds',			1, 				2),
		('PG_GRANCOLOMBIA_ALPHA_ATLAS', 					48, 		'GranColombiaIcons48.dds',			1, 				2),
		('PG_GRANCOLOMBIA_ALPHA_ATLAS', 					45, 		'GranColombiaIcons45.dds',			1, 				2),
		('PG_GRANCOLOMBIA_ALPHA_ATLAS', 					32, 		'GranColombiaIcons32.dds',			1, 				2),
		('PG_GRANCOLOMBIA_ALPHA_ATLAS', 					24, 		'GranColombiaIcons24.dds',			1, 				2),
		('PG_GRANCOLOMBIA_ALPHA_ATLAS', 					16, 		'GranColombiaIcons16.dds',			1, 				2),
		('PG_GRANCOLOMBIA_LLANERO_FLAG_ATLAS',				32, 		'flag_llanero.dds',					1, 				1),
		('PG_GRANCOLOMBIA_LIBERTADOR_FLAG_ATLAS',			32, 		'flag_libertador.dds',				1, 				1),
		('LIBERTADOR_ACTION_ATLAS',						64,			'LibertadorAction_64.dds',			1,				1),
		('LIBERTADOR_ACTION_ATLAS',						45,			'LibertadorAction_45.dds',			1,				1);
		
------------------------------
-- Colors
------------------------------		
INSERT INTO Colors 
		(Type, 										Red, 	Green, 	Blue, 	Alpha)
VALUES	('COLOR_PLAYER_PG_GRANCOLOMBIA_BACKGROUND',		0.101,	0.109,	0.249,	1),
		('COLOR_PLAYER_PG_GRANCOLOMBIA_ICON',			0.925,	0.886,	0.309,	1);
------------------------------
-- PlayerColors
------------------------------			
INSERT INTO PlayerColors 
		(Type, 						PrimaryColor, 						SecondaryColor, 						TextColor)
VALUES	('PLAYERCOLOR_PG_GRANCOLOMBIA',	'COLOR_PLAYER_PG_GRANCOLOMBIA_ICON', 	'COLOR_PLAYER_PG_GRANCOLOMBIA_BACKGROUND', 	'COLOR_PLAYER_WHITE_TEXT');

--==========================================================================================================================
-- AUDIO
--==========================================================================================================================	
-- Audio_Sounds
------------------------------	
INSERT INTO Audio_Sounds 
		(SoundID, 								Filename,			LoadType)
VALUES	('SND_LEADER_MUSIC_PG_BOLIVAR_PEACE', 	'BolivarPeace',		'DynamicResident'),
		('SND_LEADER_MUSIC_PG_BOLIVAR_WAR', 	'BolivarWar', 		'DynamicResident');		
------------------------------
-- Audio_2DSounds
------------------------------	
INSERT INTO Audio_2DSounds 
		(ScriptID, 										SoundID, 									SoundType, 		TaperSoundtrackVolume,	MinVolume, 	MaxVolume,  IsMusic, Looping)
VALUES	('AS2D_LEADER_MUSIC_PG_BOLIVAR_PEACE', 			'SND_LEADER_MUSIC_PG_BOLIVAR_PEACE',		'GAME_MUSIC', 	-1.0,					45, 		45, 		1, 		 0),
		('AS2D_LEADER_MUSIC_PG_BOLIVAR_WAR',			'SND_LEADER_MUSIC_PG_BOLIVAR_WAR',			'GAME_MUSIC', 	-1.0,					35, 		35, 		1,		 0),
		('AS2D_AMBIENCE_LEADER_PG_BOLIVAR_AMBIENCE',	'SND_AMBIENCE_NAPOLEON_AMBIENCE',			'GAME_SFX',		-1.0,					85,			85,			0,		 1);

--==========================================================================================================================
-- UNIT/RESOURCE GRAPHICS
--==========================================================================================================================	
-- ArtDefine_StrategicView
------------------------------
INSERT INTO ArtDefine_StrategicView 
		(StrategicViewType, 					TileType,		Asset)
VALUES	('ART_DEF_UNIT_PG_LLANERO',				'Unit', 		'sv_llanero.dds'),
		('ART_DEF_UNIT_PG_LIBERTADOR',			'Unit', 		'sv_libertador.dds');


------------------------------
-- ArtDefine_UnitInfos
------------------------------			

INSERT INTO ArtDefine_UnitInfos (Type,DamageStates,Formation)
	SELECT	('ART_DEF_UNIT_PG_LLANERO'), DamageStates, Formation
	FROM ArtDefine_UnitInfos WHERE (Type = 'ART_DEF_UNIT_LANCER');

INSERT INTO ArtDefine_UnitInfoMemberInfos (UnitInfoType,UnitMemberInfoType,NumMembers)
	SELECT	('ART_DEF_UNIT_PG_LLANERO'), ('ART_DEF_UNIT_MEMBER_GRANCOLOMBIA_LLANERO'), NumMembers
	FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_LANCER');

INSERT INTO ArtDefine_UnitMemberCombats (UnitMemberType, EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
	SELECT	('ART_DEF_UNIT_MEMBER_GRANCOLOMBIA_LLANERO'), EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
	FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_LANCER');

INSERT INTO ArtDefine_UnitMemberCombatWeapons (UnitMemberType, "Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
	SELECT ('ART_DEF_UNIT_MEMBER_GRANCOLOMBIA_LLANERO'), "Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
	FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_LANCER');

INSERT INTO ArtDefine_UnitMemberInfos (Type, Scale, ZOffset, Domain, Model, MaterialTypeTag, MaterialTypeSoundOverrideTag)
	SELECT	('ART_DEF_UNIT_MEMBER_GRANCOLOMBIA_LLANERO'), Scale, ZOffset, Domain, ('Llanero.fxsxml'), MaterialTypeTag, MaterialTypeSoundOverrideTag
	FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_LANCER');

INSERT INTO ArtDefine_UnitInfos (Type,DamageStates,Formation)
	SELECT	('ART_DEF_UNIT_PG_LIBERTADOR'), DamageStates, Formation
	FROM ArtDefine_UnitInfos WHERE (Type = 'ART_DEF_UNIT_GENERAL');

INSERT INTO ArtDefine_UnitInfoMemberInfos (UnitInfoType,UnitMemberInfoType,NumMembers)
	SELECT	('ART_DEF_UNIT_PG_LIBERTADOR'), ('ART_DEF_UNIT_MEMBER_GRANCOLOMBIA_INDEPENDIST'), NumMembers
	FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_GENERAL');

INSERT INTO ArtDefine_UnitMemberCombats (UnitMemberType, EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
	SELECT	('ART_DEF_UNIT_MEMBER_GRANCOLOMBIA_INDEPENDIST'), EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
	FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_GREATGENERAL_EARLY');

INSERT INTO ArtDefine_UnitMemberCombatWeapons (UnitMemberType, "Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
	SELECT ('ART_DEF_UNIT_MEMBER_GRANCOLOMBIA_INDEPENDIST'), "Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
	FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_GREATGENERAL_EARLY');

INSERT INTO ArtDefine_UnitMemberInfos (Type, Scale, ZOffset, Domain, Model, MaterialTypeTag, MaterialTypeSoundOverrideTag)
	SELECT	('ART_DEF_UNIT_MEMBER_GRANCOLOMBIA_INDEPENDIST'), Scale, ZOffset, Domain, ('independist.fxsxml'), MaterialTypeTag, MaterialTypeSoundOverrideTag
	FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_GREATGENERAL_EARLY');
		
--==========================================================================================================================	
--==========================================================================================================================	

