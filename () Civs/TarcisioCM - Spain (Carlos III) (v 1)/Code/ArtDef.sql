--=========================================================================================================================
-- IconTextureAtlases
--==========================================================================================================================
INSERT INTO IconTextureAtlases 
			(Atlas, 										IconSize, 	Filename, 									IconsPerRow, 	IconsPerColumn)
VALUES		('TCM_BOURBON_SPAIN_ATLAS', 					256, 		'TCM_SpainCarlosIIIAtlas_256.dds',			2,				2),
			('TCM_BOURBON_SPAIN_ATLAS', 					128, 		'TCM_SpainCarlosIIIAtlas_128.dds',			2, 				2),
			('TCM_BOURBON_SPAIN_ATLAS', 					80, 		'TCM_SpainCarlosIIIAtlas_80.dds',			2, 				2),
			('TCM_BOURBON_SPAIN_ATLAS', 					64, 		'TCM_SpainCarlosIIIAtlas_64.dds',			2, 				2),
			('TCM_BOURBON_SPAIN_ATLAS', 					45, 		'TCM_SpainCarlosIIIAtlas_45.dds',			2, 				2),
			('TCM_BOURBON_SPAIN_ATLAS', 					32, 		'TCM_SpainCarlosIIIAtlas_32.dds',			2, 				2),
			('TCM_BOURBON_SPAIN_ALPHA_ATLAS',				128, 		'TCM_SpainCarlosIIIAlphaAtlas_128.dds',		1,				1),
			('TCM_BOURBON_SPAIN_ALPHA_ATLAS',				80, 		'TCM_SpainCarlosIIIAlphaAtlas_80.dds',		1, 				1),
			('TCM_BOURBON_SPAIN_ALPHA_ATLAS',				64, 		'TCM_SpainCarlosIIIAlphaAtlas_64.dds',		1, 				1),
			('TCM_BOURBON_SPAIN_ALPHA_ATLAS',				48, 		'TCM_SpainCarlosIIIAlphaAtlas_48.dds',		1, 				1),
			('TCM_BOURBON_SPAIN_ALPHA_ATLAS',				32, 		'TCM_SpainCarlosIIIAlphaAtlas_32.dds',		1, 				1),
			('TCM_BOURBON_SPAIN_ALPHA_ATLAS',				24, 		'TCM_SpainCarlosIIIAlphaAtlas_24.dds',		1, 				1),
			('TCM_BOURBON_SPAIN_ALPHA_ATLAS',				16, 		'TCM_SpainCarlosIIIAlphaAtlas_16.dds',		1, 				1),
			('TCM_UNIT_FLAG_SANTISIMA_TRINIDAD_ATLAS',		32,			'tcm_SpainSantisimaTrinidadFlag_32.dds',	1, 				1),
			('TCM_UNIT_FLAG_WALLOON_GUARD_ATLAS',			32,			'tcm_SpainWalloonGuardFlag_32.dds',			1, 				1);
--==========================================================================================================================
--==========================================================================================================================
INSERT INTO ArtDefine_UnitInfos(Type, DamageStates, Formation)
  VALUES ('ART_DEF_UNIT_TCM_WALLOON_GUARD', 1, 'HonorableGunpowder');
INSERT INTO ArtDefine_UnitInfoMemberInfos(UnitInfoType, UnitMemberInfoType, NumMembers)
  VALUES ('ART_DEF_UNIT_TCM_WALLOON_GUARD', 'ART_DEF_UNIT_MEMBER_TCM_WALLOON_GUARD', 14);
INSERT INTO ArtDefine_UnitMemberInfos(Type, Scale, Model, MaterialTypeTag, MaterialTypeSoundOverrideTag)
  VALUES ('ART_DEF_UNIT_MEMBER_TCM_WALLOON_GUARD', 0.142000000596046, 'spain_walloonguard.fxsxml', 'CLOTH', 'FLESH');
INSERT INTO ArtDefine_UnitMemberCombats(UnitMemberType, EnableActions, ShortMoveRadius, ShortMoveRate, TargetHeight, HasShortRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat)
  VALUES ('ART_DEF_UNIT_MEMBER_TCM_WALLOON_GUARD', 'Idle Attack RunCharge AttackCity Bombard Death BombardDefend Run Fortify CombatReady Walk AttackCharge', 12.0, 0.349999994039536, 8.0, 1, 1, 1);
INSERT INTO ArtDefine_UnitMemberCombatWeapons(UnitMemberType, "Index", SubIndex, WeaponTypeTag, WeaponTypeSoundOverrideTag)
  VALUES ('ART_DEF_UNIT_MEMBER_TCM_WALLOON_GUARD', 0, 0, 'BULLET', 'BULLET');
INSERT INTO ArtDefine_StrategicView(StrategicViewType, TileType, Asset)
  VALUES ('ART_DEF_UNIT_TCM_WALLOON_GUARD', 'Unit', 'sv_WalloonGuard.dds');

INSERT INTO ArtDefine_UnitInfos(Type, DamageStates)
  VALUES ('ART_DEF_UNIT_TCM_SANTISIMA_TRINIDAD', 3);
INSERT INTO ArtDefine_UnitInfoMemberInfos(UnitInfoType, UnitMemberInfoType, NumMembers)
  VALUES ('ART_DEF_UNIT_TCM_SANTISIMA_TRINIDAD', 'ART_DEF_UNIT_MEMBER_TCM_SANTISIMA_TRINIDAD', 1);
INSERT INTO ArtDefine_UnitMemberInfos(Type, Scale, Domain, Model, MaterialTypeTag, MaterialTypeSoundOverrideTag)
  VALUES ('ART_DEF_UNIT_MEMBER_TCM_SANTISIMA_TRINIDAD', 0.150000000596046, 'Sea', 'spain_santisimatrinidad.fxsxml', 'WOOD', 'WOODLRG');
INSERT INTO ArtDefine_UnitMemberCombats(UnitMemberType, EnableActions, HasShortRangedAttack, HasLeftRightAttack, HasRefaceAfterCombat, HasIndependentWeaponFacing)
  VALUES ('ART_DEF_UNIT_MEMBER_TCM_SANTISIMA_TRINIDAD', 'Idle Attack RunCharge AttackCity Bombard Death BombardDefend Run Fortify CombatReady AttackSurfaceToAir', 1, 1, 0, 1);
INSERT INTO ArtDefine_UnitMemberCombatWeapons(UnitMemberType, "Index", SubIndex, VisKillStrengthMin, VisKillStrengthMax, HitEffect, WeaponTypeTag, WeaponTypeSoundOverrideTag)
  VALUES ('ART_DEF_UNIT_MEMBER_TCM_SANTISIMA_TRINIDAD', 0, 0, 0.0, 0.0, 'ART_DEF_VEFFECT_CANNON_IMPACT_$(TERRAIN)', 'EXPLOSIVE', 'EXPLOSION20POUND');
INSERT INTO ArtDefine_StrategicView(StrategicViewType, TileType, Asset)
  VALUES ('ART_DEF_UNIT_TCM_SANTISIMA_TRINIDAD', 'Unit', 'sv_SantisimaTrinidad.dds');


