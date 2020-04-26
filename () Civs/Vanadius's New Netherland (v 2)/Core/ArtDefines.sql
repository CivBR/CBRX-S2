--==========================================================================================================================
-- ART DEFINES
--==========================================================================================================================	
-- IconTextureAtlases
------------------------------
INSERT INTO IconTextureAtlases 
		(Atlas, 									IconSize, 	Filename, 								IconsPerRow, 	IconsPerColumn)
VALUES	('VANA_NEWNETHERLAND_ATLAS', 						256, 		'NNAtlas256.dds',			2, 				2),
		('VANA_NEWNETHERLAND_ATLAS', 						128, 		'NNAtlas128.dds',			2, 				2),
		('VANA_NEWNETHERLAND_ATLAS', 						80, 		'NNAtlas80.dds',				2, 				2),
		('VANA_NEWNETHERLAND_ATLAS', 						64, 		'NNAtlas64.dds',				2, 				2),
		('VANA_NEWNETHERLAND_ATLAS', 						45, 		'NNAtlas45.dds',				2, 				2),
		('VANA_NEWNETHERLAND_ATLAS', 						32, 		'NNAtlas32.dds',				2, 				2),
		('VANA_NEWNETHERLAND_ALPHA_ATLAS', 				64, 		'NNAlpha64.dds',		1, 				1),
		('VANA_NEWNETHERLAND_ALPHA_ATLAS', 				48, 		'NNAlpha48.dds',		1, 				1),
		('VANA_NEWNETHERLAND_ALPHA_ATLAS', 				45, 		'NNAlpha45.dds',		1, 				1),
		('VANA_NEWNETHERLAND_ALPHA_ATLAS', 				32, 		'NNAlpha32.dds',		1, 				1),
		('VANA_NEWNETHERLAND_ALPHA_ATLAS', 				24, 		'NNAlpha24.dds',		1, 				1),
		('VANA_SCHUTTERIJ_FLAG', 				32, 		'SchutterijAlpha.dds',		1, 				1);
------------------------------
-- Colours
------------------------------		
INSERT INTO Colors 
		(Type, 											Red, 	Green, 	Blue, 	Alpha)
VALUES	('COLOR_PLAYER_VANA_NEWNETHERLAND_ICON', 		0.839,	0.494,	0.118,	1),
		('COLOR_PLAYER_VANA_NEWNETHERLAND_BACKGROUND',	0.09,	0.016,	0.15,	1);
------------------------------
-- PlayerColors
------------------------------			
INSERT INTO PlayerColors 
		(Type, 										PrimaryColor, 								SecondaryColor, 						TextColor)
VALUES	('PLAYERCOLOR_VANA_NEWNETHERLAND',				'COLOR_PLAYER_VANA_NEWNETHERLAND_ICON', 			'COLOR_PLAYER_VANA_NEWNETHERLAND_BACKGROUND',	'COLOR_PLAYER_WHITE_TEXT');
--==========================================================================================================================
-- AUDIO
--==========================================================================================================================	
-- Audio_Sounds
------------------------------	

------------------------------
-- Audio_2DSounds
------------------------------	

--==========================================================================================================================
-- UNIT GRAPHICS
--==========================================================================================================================	
-- ArtDefine_StrategicView
------------------------------

------------------------------
-- ArtDefine_UnitInfos
------------------------------		
INSERT INTO ArtDefine_UnitInfos 
		(Type, 								DamageStates,	Formation)
SELECT	'ART_DEF_UNIT_VANA_SCHUTTERIJ', 			DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE Type = 'ART_DEF_UNIT_U_FRENCH_MUSKETEER';
------------------------------
-- ArtDefine_UnitInfoMemberInfos
------------------------------
INSERT INTO ArtDefine_UnitInfoMemberInfos 	
		(UnitInfoType,						UnitMemberInfoType,							NumMembers)
SELECT	'ART_DEF_UNIT_VANA_SCHUTTERIJ', 			'ART_DEF_UNIT_MEMBER_VANA_SCHUTTERIJ', 			NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE UnitInfoType = 'ART_DEF_UNIT_U_FRENCH_MUSKETEER';
------------------------------
-- ArtDefine_UnitMemberCombats
------------------------------
INSERT INTO ArtDefine_UnitMemberCombats 
		(UnitMemberType,					EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT	'ART_DEF_UNIT_MEMBER_VANA_SCHUTTERIJ',	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_U_FRENCH_MUSKETEER';
------------------------------
-- ArtDefine_UnitMemberCombatWeapons
------------------------------
INSERT INTO ArtDefine_UnitMemberCombatWeapons	
		(UnitMemberType,					"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_VANA_SCHUTTERIJ',	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_U_FRENCH_MUSKETEER';
------------------------------
-- ArtDefine_UnitMemberInfos
------------------------------
INSERT INTO ArtDefine_UnitMemberInfos 	
		(Type, 								Scale, ZOffset, Domain, Model, 			 MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_VANA_SCHUTTERIJ',	Scale, ZOffset, Domain, 'landsknecht_musket_a.fxsxml', MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE Type = 'ART_DEF_UNIT_MEMBER_U_FRENCH_MUSKETEER';
--==========================================================================================================================	
--==========================================================================================================================	
