INSERT INTO Colors
		(Type,	Red,	Blue,	Green,	Alpha)
VALUES	('COLOR_PLAYER_EW_PARG_ICON',	0.137,	0.29,	0.137,	1),
		('COLOR_PLAYER_EW_PARG_BACKGROUND',	0.81,	0.9,	0.81,	1);

-----

INSERT INTO PlayerColors
		(Type,	PrimaryColor,	SecondaryColor,	TextColor)
VALUES	('PLAYERCOLOR_EW_PARG',	'COLOR_PLAYER_EW_PARG_ICON',	'COLOR_PLAYER_EW_PARG_BACKGROUND',	'COLOR_PLAYER_WHITE_TEXT');

-----

INSERT INTO ArtDefine_StrategicView
		(StrategicViewType,	TileType,	Asset)
VALUES	('ART_DEF_UNIT_EW_BRONEPOEZD',	'Unit',	'CSLegionSV.dds'),
		('ART_DEF_UNIT_EW_LEGIONE',	'Unit',	'HandCuffSV.dds');

-----


INSERT INTO Audio_Sounds
		(SoundID,	Filename,	LoadType)
VALUES	('SND_LEADER_MUSIC_EW_KOLCHAK_PEACE',	'PARGPeace',	'DynamicResident'),
		('SND_LEADER_MUSIC_EW_KOLCHAK_WAR',	'PARGWar',	'DynamicResident');

INSERT INTO Audio_2DSounds
		(ScriptID,	SoundID,	SoundType,	MinVolume,	MaxVolume,	IsMusic,	Looping)
VALUES	('AS2D_LEADER_MUSIC_EW_KOLCHAK_PEACE',	'SND_LEADER_MUSIC_EW_KOLCHAK_PEACE',	'GAME_MUSIC',	60,	60,	1,	0),
		('AS2D_LEADER_MUSIC_EW_KOLCHAK_WAR',	'SND_LEADER_MUSIC_EW_KOLCHAK_WAR',	'GAME_MUSIC',	60,	60,	1,	0);


-----

INSERT INTO ArtDefine_UnitInfos
		(Type,	DamageStates,	Formation)
SELECT	('ART_DEF_UNIT_EW_BRONEPOEZD'),	DamageStates,	Formation
FROM ArtDefine_UnitInfos WHERE (Type = 'ART_DEF_UNIT_WW1_TANK');

INSERT INTO ArtDefine_UnitInfoMemberInfos
		(UnitInfoType,	UnitMemberInfoType,	NumMembers)
SELECT	('ART_DEF_UNIT_EW_BRONEPOEZD'),	('ART_DEF_UNIT_MEMBER_EW_BRONEPOEZD'),	1
FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_WW1_TANK');

INSERT INTO ArtDefine_UnitMemberCombats
		(UnitMemberType,	EnableActions,	DisableActions,	MoveRadius,	ShortMoveRadius,	ChargeRadius,	AttackRadius,	RangedAttackRadius,	MoveRate,	ShortMoveRate,	TurnRateMin,	TurnRateMax,	TurnFacingRateMin,	TurnFacingRateMax,	RollRateMin,	RollRateMax,	PitchRateMin,	PitchRateMax,	LOSRadiusScale,	TargetRadius,	TargetHeight,	HasShortRangedAttack,	HasLongRangedAttack,	HasLeftRightAttack,	HasStationaryMelee,	HasStationaryRangedAttack,	HasRefaceAfterCombat,	ReformBeforeCombat,	HasIndependentWeaponFacing,	HasOpponentTracking,	HasCollisionAttack,	AttackAltitude,	AltitudeDecelerationDistance,	OnlyTurnInMovementActions,	RushAttackFormation)
SELECT	('ART_DEF_UNIT_MEMBER_EW_BRONEPOEZD'),	EnableActions,	DisableActions,	MoveRadius,	ShortMoveRadius,	ChargeRadius,	AttackRadius,	RangedAttackRadius,	MoveRate,	ShortMoveRate,	TurnRateMin,	TurnRateMax,	TurnFacingRateMin,	TurnFacingRateMax,	RollRateMin,	RollRateMax,	PitchRateMin,	PitchRateMax,	LOSRadiusScale,	TargetRadius,	TargetHeight,	HasShortRangedAttack,	HasLongRangedAttack,	HasLeftRightAttack,	HasStationaryMelee,	HasStationaryRangedAttack,	HasRefaceAfterCombat,	ReformBeforeCombat,	HasIndependentWeaponFacing,	HasOpponentTracking,	HasCollisionAttack,	AttackAltitude,	AltitudeDecelerationDistance,	OnlyTurnInMovementActions,	RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_WW1_TANK');

INSERT INTO ArtDefine_UnitMemberCombatWeapons
		(UnitMemberType,	"Index",	SubIndex,	ID,	VisKillStrengthMin,	VisKillStrengthMax,	ProjectileSpeed,	ProjectileTurnRateMin,	ProjectileTurnRateMax,	HitEffect,	HitEffectScale,	HitRadius,	ProjectileChildEffectScale,	AreaDamageDelay,	ContinuousFire,	WaitForEffectCompletion,	TargetGround,	IsDropped,	WeaponTypeTag,	WeaponTypeSoundOverrideTag)
SELECT	('ART_DEF_UNIT_MEMBER_EW_BRONEPOEZD'),	"Index",	SubIndex,	ID,	VisKillStrengthMin,	VisKillStrengthMax,	ProjectileSpeed,	ProjectileTurnRateMin,	ProjectileTurnRateMax,	HitEffect,	HitEffectScale,	HitRadius,	ProjectileChildEffectScale,	AreaDamageDelay,	ContinuousFire,	WaitForEffectCompletion,	TargetGround,	IsDropped,	WeaponTypeTag,	WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_WW1_TANK');

INSERT INTO ArtDefine_UnitMemberInfos
		(Type,	Scale,	ZOffset,	Domain,	Model,	MaterialTypeTag,	MaterialTypeSoundOverrideTag)
SELECT	('ART_DEF_UNIT_MEMBER_EW_BRONEPOEZD'),	Scale,	ZOffset,	Domain,	Model,	MaterialTypeTag,	MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_WW1_TANK');

INSERT INTO ArtDefine_UnitInfos
		(Type,	DamageStates,	Formation)
SELECT	('ART_DEF_UNIT_EW_LEGIONE'),	DamageStates,	Formation
FROM ArtDefine_UnitInfos WHERE (Type = 'ART_DEF_UNIT_WW1_INFANTRY');

INSERT INTO ArtDefine_UnitInfoMemberInfos
		(UnitInfoType,	UnitMemberInfoType,	NumMembers)
SELECT	('ART_DEF_UNIT_EW_LEGIONE'),	('ART_DEF_UNIT_MEMBER_EW_LEGIONE'),	NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_WW1_INFANTRY');

INSERT INTO ArtDefine_UnitMemberCombats
		(UnitMemberType,	EnableActions,	DisableActions,	MoveRadius,	ShortMoveRadius,	ChargeRadius,	AttackRadius,	RangedAttackRadius,	MoveRate,	ShortMoveRate,	TurnRateMin,	TurnRateMax,	TurnFacingRateMin,	TurnFacingRateMax,	RollRateMin,	RollRateMax,	PitchRateMin,	PitchRateMax,	LOSRadiusScale,	TargetRadius,	TargetHeight,	HasShortRangedAttack,	HasLongRangedAttack,	HasLeftRightAttack,	HasStationaryMelee,	HasStationaryRangedAttack,	HasRefaceAfterCombat,	ReformBeforeCombat,	HasIndependentWeaponFacing,	HasOpponentTracking,	HasCollisionAttack,	AttackAltitude,	AltitudeDecelerationDistance,	OnlyTurnInMovementActions,	RushAttackFormation)
SELECT	('ART_DEF_UNIT_MEMBER_EW_LEGIONE'),	EnableActions,	DisableActions,	MoveRadius,	ShortMoveRadius,	ChargeRadius,	AttackRadius,	RangedAttackRadius,	MoveRate,	ShortMoveRate,	TurnRateMin,	TurnRateMax,	TurnFacingRateMin,	TurnFacingRateMax,	RollRateMin,	RollRateMax,	PitchRateMin,	PitchRateMax,	LOSRadiusScale,	TargetRadius,	TargetHeight,	HasShortRangedAttack,	HasLongRangedAttack,	HasLeftRightAttack,	HasStationaryMelee,	HasStationaryRangedAttack,	HasRefaceAfterCombat,	ReformBeforeCombat,	HasIndependentWeaponFacing,	HasOpponentTracking,	HasCollisionAttack,	AttackAltitude,	AltitudeDecelerationDistance,	OnlyTurnInMovementActions,	RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_WW1_INFANTRY');

INSERT INTO ArtDefine_UnitMemberCombatWeapons
		(UnitMemberType,	"Index",	SubIndex,	ID,	VisKillStrengthMin,	VisKillStrengthMax,	ProjectileSpeed,	ProjectileTurnRateMin,	ProjectileTurnRateMax,	HitEffect,	HitEffectScale,	HitRadius,	ProjectileChildEffectScale,	AreaDamageDelay,	ContinuousFire,	WaitForEffectCompletion,	TargetGround,	IsDropped,	WeaponTypeTag,	WeaponTypeSoundOverrideTag)
SELECT	('ART_DEF_UNIT_MEMBER_EW_LEGIONE'),	"Index",	SubIndex,	ID,	VisKillStrengthMin,	VisKillStrengthMax,	ProjectileSpeed,	ProjectileTurnRateMin,	ProjectileTurnRateMax,	HitEffect,	HitEffectScale,	HitRadius,	ProjectileChildEffectScale,	AreaDamageDelay,	ContinuousFire,	WaitForEffectCompletion,	TargetGround,	IsDropped,	WeaponTypeTag,	WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_WW1_INFANTRY');

INSERT INTO ArtDefine_UnitMemberInfos
		(Type,	Scale,	ZOffset,	Domain,	Model,	MaterialTypeTag,	MaterialTypeSoundOverrideTag)
SELECT	('ART_DEF_UNIT_MEMBER_EW_LEGIONE'),	Scale,	ZOffset,	Domain,	Model,	MaterialTypeTag,	MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_WW1_INFANTRY');

-----

INSERT INTO IconTextureAtlases
		(Atlas,	IconSize,	Filename,	IconsPerRow,	IconsPerColumn)
VALUES	('EW_PARG_ALPHA',	256,	'KolchakAlpha256.dds',	1,	1),
		('EW_PARG_ALPHA',	128,	'KolchakAlpha128.dds',	1,	1),	
		('EW_PARG_ALPHA',	80,	'KolchakAlpha80.dds',	1,	1),
		('EW_PARG_ALPHA',	64,	'KolchakAlpha64.dds',	1,	1),
		('EW_PARG_ALPHA',	45,	'KolchakAlpha45.dds',	1,	1),
		('EW_PARG_ALPHA',	32,	'KolchakAlpha32.dds',	1,	1),
		('EW_PARG_ALPHA',	24,	'KolchakAlpha24.dds',	1,	1),
		('EW_PARG_ALPHA',	16,	'KolchakAlpha16.dds',	1,	1),
		('EW_BRONEPOEZD_ALPHA',	32,	'CSLegionAlpha32.dds',	1,	1),
		('EW_PARG_ATLAS',	256,	'PARGIcon256.dds',	1,	1),
		('EW_PARG_ATLAS',	128,	'PARGIcon128.dds',	1,	1),
		('EW_PARG_ATLAS',	80,	'PARGIcon80.dds',	1,	1),
		('EW_PARG_ATLAS',	64,	'PARGIcon64.dds',	1,	1),
		('EW_PARG_ATLAS',	45,	'PARGIcon45.dds',	1,	1),
		('EW_PARG_ATLAS',	32,	'PARGIcon32.dds',	1,	1),
		('ATLAS_EW_KOLCHAK',	256,	'KolchakAtlas256.dds',	3,	1),
		('ATLAS_EW_KOLCHAK',	128,	'KolchakAtlas128.dds',	3,	1),
		('ATLAS_EW_KOLCHAK',	80,	'KolchakAtlas80.dds',	3,	1),
		('ATLAS_EW_KOLCHAK',	64,	'KolchakAtlas64.dds',	3,	1),
		('ATLAS_EW_KOLCHAK',	45,	'KolchakAtlas45.dds',	3,	1),
		('ATLAS_EW_KOLCHAK',	32,	'KolchakAtlas32.dds',	3,	1),
		('ALPHA_EW_LEGIONE',	256,	'HandCuff256.dds',	1,	1),
		('ALPHA_EW_LEGIONE',	32,	'HandCuff32.dds',	1,	1);