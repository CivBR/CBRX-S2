INSERT INTO ArtDefine_UnitInfos (Type,DamageStates,Formation)
	SELECT	('ART_DEF_UNIT_TEUTONIC'), DamageStates, Formation
	FROM ArtDefine_UnitInfos WHERE (Type = 'ART_DEF_UNIT_KNIGHT');

INSERT INTO ArtDefine_UnitInfoMemberInfos (UnitInfoType,UnitMemberInfoType,NumMembers)
	SELECT	('ART_DEF_UNIT_TEUTONIC'), ('ART_DEF_UNIT_MEMBER_TEUTONIC'), NumMembers
	FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_KNIGHT');

INSERT INTO ArtDefine_UnitMemberCombats (UnitMemberType, EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
	SELECT	('ART_DEF_UNIT_MEMBER_TEUTONIC'), EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
	FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_KNIGHT');

INSERT INTO ArtDefine_UnitMemberCombatWeapons (UnitMemberType, "Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
	SELECT ('ART_DEF_UNIT_MEMBER_TEUTONIC'), "Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
	FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_KNIGHT');

INSERT INTO ArtDefine_UnitMemberInfos (Type, Scale, ZOffset, Domain, Model, MaterialTypeTag, MaterialTypeSoundOverrideTag)
	SELECT	('ART_DEF_UNIT_MEMBER_TEUTONIC'), Scale, ZOffset, Domain, ('knightofteutons.fxsxml'), MaterialTypeTag, MaterialTypeSoundOverrideTag
	FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_KNIGHT');

INSERT INTO ArtDefine_StrategicView (StrategicViewType, TileType, Asset )
	VALUES	('ART_DEF_UNIT_TEUTONIC', 'Unit', 'hwicon.dds');

INSERT INTO ArtDefine_UnitInfos 
		(Type, 			DamageStates, 		Formation)
VALUES		('ART_DEF_UNIT_HOLY_WARRIOR', 	'1', 	'Samurai');
INSERT INTO ArtDefine_UnitInfos 
		(Type, 			DamageStates, 		Formation)
VALUES		('ART_DEF_UNIT_PREMED_HOLY_WARRIOR', 	'1', 	'Samurai');

INSERT INTO ArtDefine_UnitInfoMemberInfos 
		(UnitInfoType, 			UnitMemberInfoType, 		NumMembers)
VALUES		('ART_DEF_UNIT_HOLY_WARRIOR', 	'ART_DEF_UNIT_MEMBER_HOLY_WARRIOR', 	'12');
INSERT INTO ArtDefine_UnitInfoMemberInfos 
		(UnitInfoType, 			UnitMemberInfoType, 		NumMembers)
VALUES		('ART_DEF_UNIT_PREMED_HOLY_WARRIOR', 	'ART_DEF_UNIT_MEMBER_PREMED_HOLY_WARRIOR', 	'12');

INSERT INTO ArtDefine_UnitMemberInfos 
		(Type, 			Scale, 		Model,	MaterialTypeTag,	MaterialTypeSoundOverrideTag)
VALUES		('ART_DEF_UNIT_MEMBER_HOLY_WARRIOR', 	'0.15', 	'Longswordsman_Templar.fxsxml',	'CLOTH',	'FLESH');
INSERT INTO ArtDefine_UnitMemberInfos 
		(Type, 			Scale, 		Model,	MaterialTypeTag,	MaterialTypeSoundOverrideTag)
VALUES		('ART_DEF_UNIT_MEMBER_PREMED_HOLY_WARRIOR', 	'0.15', 	'Oceanic_warrior.fxsxml',	'CLOTH',	'FLESH');

INSERT INTO ArtDefine_StrategicView 
		(StrategicViewType, 			TileType, 		Asset)
VALUES		('ART_DEF_UNIT_HOLY_WARRIOR', 	'Unit', 	'hwicon.dds');
INSERT INTO ArtDefine_StrategicView 
		(StrategicViewType, 			TileType, 		Asset)
VALUES		('ART_DEF_UNIT_MEMBER_PREMED_HOLY_WARRIOR', 	'Unit', 	'hwicon.dds');

INSERT INTO IconTextureAtlases 
		(Atlas, 			IconSize, 		Filename,	IconsPerRow,	IconsPerColumn)
VALUES	('HOLY_WARRIOR_ICON', 	'32', 	'hwicon.dds',	'1',	'1');
INSERT INTO IconTextureAtlases 
		(Atlas, 			IconSize, 		Filename,	IconsPerRow,	IconsPerColumn)
VALUES	('HWIconAtlas', 	'256', 	'hwunitatlas256.dds',	'3',	'1');
INSERT INTO IconTextureAtlases 
		(Atlas, 			IconSize, 		Filename,	IconsPerRow,	IconsPerColumn)
VALUES	('HWIconAtlas', 	'128', 	'hwunitatlas128.dds',	'3',	'1');
INSERT INTO IconTextureAtlases 
		(Atlas, 			IconSize, 		Filename,	IconsPerRow,	IconsPerColumn)
VALUES	('HWIconAtlas', 	'80', 	'hwunitatlas80.dds',	'3',	'1');
INSERT INTO IconTextureAtlases 
		(Atlas, 			IconSize, 		Filename,	IconsPerRow,	IconsPerColumn)
VALUES	('HWIconAtlas', 	'64', 	'hwunitatlas64.dds',	'3',	'1');
INSERT INTO IconTextureAtlases 
		(Atlas, 			IconSize, 		Filename,	IconsPerRow,	IconsPerColumn)
VALUES	('HWIconAtlas', 	'45', 	'hwunitatlas45.dds',	'3',	'1');

--------------------------------	
-- Units
--------------------------------
INSERT INTO Units 	
		(Type, 						Class,	PrereqTech, ShowInPedia, RangedCombat, Range, Special, Combat, Cost, ObsoleteTech, GoodyHutUpgradeUnitClass, FaithCost, RequiresFaithPurchaseEnabled, Moves, CombatClass, Domain, DefaultUnitAI,  Description, 					  Civilopedia, 								Strategy, 		 									Pillage, MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, Mechanized, AdvancedStartCost, RangedCombatLimit, CombatLimit, XPValueDefense, UnitArtInfo, 						UnitFlagIconOffset,	UnitFlagAtlas,						 PortraitIndex, 	IconAtlas,			 MoveRate)
SELECT	'UNIT_ISKA_HW_WARRIOR',	Class,	PrereqTech, 'false', RangedCombat, Range, Special, Combat + 2, Cost, ObsoleteTech, GoodyHutUpgradeUnitClass, FaithCost, RequiresFaithPurchaseEnabled, Moves, CombatClass, Domain, DefaultUnitAI, 'TXT_KEY_UNIT_HOLY_WARRIOR', 'TXT_KEY_HOLY_WARRIOR_CIVILOPEDIA_TEXT',	'TXT_KEY_UNIT_HOLY_WARRIOR_STRATEGY',  	Pillage, MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, Mechanized, AdvancedStartCost, RangedCombatLimit, CombatLimit, XPValueDefense, 'ART_DEF_UNIT_PREMED_HOLY_WARRIOR',	0,					'HOLY_WARRIOR_ICON',					  0, 				'HWIconAtlas',	 MoveRate
FROM Units WHERE Type = 'UNIT_WARRIOR';
INSERT INTO Units 	
		(Type, 						Class,	PrereqTech, ShowInPedia, RangedCombat, Range, Special, Combat, Cost, ObsoleteTech, GoodyHutUpgradeUnitClass, FaithCost, RequiresFaithPurchaseEnabled, Moves, CombatClass, Domain, DefaultUnitAI,  Description, 					  Civilopedia, 								Strategy, 		 									Pillage, MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, Mechanized, AdvancedStartCost, RangedCombatLimit, CombatLimit, XPValueDefense, UnitArtInfo, 						UnitFlagIconOffset,	UnitFlagAtlas,						 PortraitIndex, 	IconAtlas,			 MoveRate)
SELECT	'UNIT_ISKA_HW_SWORDSMAN',	Class,	PrereqTech, 'false', RangedCombat, Range, Special, Combat + 3, Cost, ObsoleteTech, GoodyHutUpgradeUnitClass, FaithCost, RequiresFaithPurchaseEnabled, Moves, CombatClass, Domain, DefaultUnitAI, 'TXT_KEY_UNIT_HOLY_WARRIOR', 'TXT_KEY_HOLY_WARRIOR_CIVILOPEDIA_TEXT',	'TXT_KEY_UNIT_HOLY_WARRIOR_STRATEGY',  	Pillage, MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, Mechanized, AdvancedStartCost, RangedCombatLimit, CombatLimit, XPValueDefense, 'ART_DEF_UNIT_HOLY_WARRIOR',	0,					'HOLY_WARRIOR_ICON',					  1, 				'HWIconAtlas',	 MoveRate
FROM Units WHERE Type = 'UNIT_SWORDSMAN';
INSERT INTO Units 	
		(Type, 						Class,	PrereqTech, ShowInPedia, RangedCombat, Range, Special, Combat, Cost, ObsoleteTech, GoodyHutUpgradeUnitClass, FaithCost, RequiresFaithPurchaseEnabled, Moves, CombatClass, Domain, DefaultUnitAI,  Description, 					  Civilopedia, 								Strategy, 		 									Pillage, MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, Mechanized, AdvancedStartCost, RangedCombatLimit, CombatLimit, XPValueDefense, UnitArtInfo, 						UnitFlagIconOffset,	UnitFlagAtlas,						 PortraitIndex, 	IconAtlas,			 MoveRate)
SELECT	'UNIT_ISKA_HW_KNIGHT',	Class,	PrereqTech, 'false', RangedCombat, Range, Special, Combat + 4, Cost, ObsoleteTech, GoodyHutUpgradeUnitClass, FaithCost, RequiresFaithPurchaseEnabled, Moves, CombatClass, Domain, DefaultUnitAI, 'TXT_KEY_UNIT_HOLY_WARRIOR', 'TXT_KEY_HOLY_WARRIOR_CIVILOPEDIA_TEXT',	'TXT_KEY_UNIT_HOLY_WARRIOR_STRATEGY',  	Pillage, MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, Mechanized, AdvancedStartCost, RangedCombatLimit, CombatLimit, XPValueDefense, 'ART_DEF_UNIT_TEUTONIC',	0,					'HOLY_WARRIOR_ICON',					  2, 				'HWIconAtlas',	 MoveRate
FROM Units WHERE Type = 'UNIT_KNIGHT';
--------------------------------	
-- UnitGameplay2DScripts
--------------------------------		
INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT	'UNIT_ISKA_HW_WARRIOR', 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_WARRIOR';
INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT	'UNIT_ISKA_HW_SWORDSMAN', 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_SWORDSMAN';
INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT	'UNIT_ISKA_HW_KNIGHT', 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_KNIGHT';
--------------------------------		
-- Unit_AITypes
--------------------------------		
INSERT INTO Unit_AITypes 	
		(UnitType, 					UnitAIType)
SELECT	'UNIT_ISKA_HW_WARRIOR', 	UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_WARRIOR';
INSERT INTO Unit_AITypes 	
		(UnitType, 					UnitAIType)
SELECT	'UNIT_ISKA_HW_SWORDSMAN', 	UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_SWORDSMAN';
INSERT INTO Unit_AITypes 	
		(UnitType, 					UnitAIType)
SELECT	'UNIT_ISKA_HW_KNIGHT', 	UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_KNIGHT';

--------------------------------	
-- Unit_Flavors
--------------------------------		
INSERT INTO Unit_Flavors 	
		(UnitType, 					FlavorType, Flavor)
SELECT	'UNIT_ISKA_HW_WARRIOR', 	FlavorType, Flavor
FROM Unit_Flavors  WHERE UnitType = 'UNIT_WARRIOR';
INSERT INTO Unit_Flavors 	
		(UnitType, 					FlavorType, Flavor)
SELECT	'UNIT_ISKA_HW_SWORDSMAN', 	FlavorType, Flavor
FROM Unit_Flavors  WHERE UnitType = 'UNIT_SWORDSMAN';
INSERT INTO Unit_Flavors 	
		(UnitType, 					FlavorType, Flavor)
SELECT	'UNIT_ISKA_HW_KNIGHT', 	FlavorType, Flavor
FROM Unit_Flavors  WHERE UnitType = 'UNIT_KNIGHT';

--------------------------------	
-- Unit_ResourceQuantityRequirements
--------------------------------	
INSERT INTO Unit_ResourceQuantityRequirements 	
		(UnitType, 					ResourceType, Cost)
SELECT	'UNIT_ISKA_HW_KNIGHT', 	ResourceType, Cost
FROM Unit_ResourceQuantityRequirements WHERE UnitType = 'UNIT_KNIGHT';

--------------------------------	
-- Unit_FreePromotions
--------------------------------	
INSERT INTO Unit_FreePromotions 	
		(UnitType, 					PromotionType)
SELECT	'UNIT_ISKA_HW_KNIGHT', 	PromotionType
FROM Unit_FreePromotions WHERE UnitType = 'UNIT_KNIGHT';


--------------------------------	
-- Unit_ClassUpgrades
--------------------------------
INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 					UnitClassType)
SELECT	'UNIT_ISKA_HW_WARRIOR', 	UnitClassType
FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_WARRIOR';
INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 					UnitClassType)
SELECT	'UNIT_ISKA_HW_SWORDSMAN', 	UnitClassType
FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_SWORDSMAN';	
INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 					UnitClassType)
SELECT	'UNIT_ISKA_HW_KNIGHT', 	UnitClassType
FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_KNIGHT';