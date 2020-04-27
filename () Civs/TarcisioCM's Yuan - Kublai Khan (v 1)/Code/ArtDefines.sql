--=========================================================================================================================
-- IconTextureAtlases
--==========================================================================================================================
INSERT INTO IconTextureAtlases 
			(Atlas, 								IconSize, 	Filename, 						IconsPerRow, 	IconsPerColumn)
VALUES		('TAR_YUAN_ATLAS', 						256, 		'Tar_Yuan_Icons_256.dds',		2,				2),
			('TAR_YUAN_ATLAS', 						128, 		'Tar_Yuan_Icons_128.dds',		2, 				2),
			('TAR_YUAN_ATLAS', 						80, 		'Tar_Yuan_Icons_80.dds',		2, 				2),
			('TAR_YUAN_ATLAS', 						64, 		'Tar_Yuan_Icons_64.dds',		2, 				2),
			('TAR_YUAN_ATLAS', 						45, 		'Tar_Yuan_Icons_45.dds',		2, 				2),
			('TAR_YUAN_ATLAS', 						32, 		'Tar_Yuan_Icons_32.dds',		2, 				2),
			('TAR_YUAN_ALPHA_ATLAS',				128, 		'Tar_Yuan_Alpha128.dds',		1,				1),
			('TAR_YUAN_ALPHA_ATLAS',				80, 		'Tar_Yuan_Alpha80.dds',			1, 				1),
			('TAR_YUAN_ALPHA_ATLAS',				64, 		'Tar_Yuan_Alpha64.dds',			1, 				1),
			('TAR_YUAN_ALPHA_ATLAS',				48, 		'Tar_Yuan_Alpha48.dds',			1, 				1),
			('TAR_YUAN_ALPHA_ATLAS',				45, 		'Tar_Yuan_Alpha45.dds',			1, 				1),
			('TAR_YUAN_ALPHA_ATLAS',				32, 		'Tar_Yuan_Alpha32.dds',			1, 				1),
			('TAR_YUAN_ALPHA_ATLAS',				24, 		'Tar_Yuan_Alpha24.dds',			1, 				1),
			('TAR_YUAN_ALPHA_ATLAS',		 		16, 		'Tar_Yuan_Alpha16.dds',			1, 				1),
			('TAR_UNIT_FLAG_SAO_ATLAS',				32,			'Tar_Yuan_Sao_Alpha_32.dds',	1, 				1);
--==========================================================================================================================
INSERT INTO ArtDefine_UnitInfos(Type, DamageStates)
  VALUES ('ART_DEF_UNIT_TAR_SAO', 3);
INSERT INTO ArtDefine_UnitInfoMemberInfos(UnitInfoType, UnitMemberInfoType, NumMembers)
  VALUES ('ART_DEF_UNIT_TAR_SAO', 'ART_DEF_UNIT_MEMBER_TAR_SAO', 1);
INSERT INTO ArtDefine_UnitMemberInfos(Type, Scale, Domain, Model, MaterialTypeTag, MaterialTypeSoundOverrideTag)
  VALUES ('ART_DEF_UNIT_MEMBER_TAR_SAO', 0.140000000596046, 'Sea', 'WarJunk.fxsxml', 'WOOD', 'WOODLRG');
INSERT INTO ArtDefine_UnitMemberCombats(UnitMemberType, EnableActions, HasShortRangedAttack, HasLeftRightAttack, HasRefaceAfterCombat, HasIndependentWeaponFacing)
  VALUES ('ART_DEF_UNIT_MEMBER_TAR_SAO', 'Idle Attack RunCharge AttackCity Bombard Death BombardDefend Run Fortify CombatReady AttackSurfaceToAir', 1, 1, 0, 1);
INSERT INTO ArtDefine_UnitMemberCombatWeapons(UnitMemberType, "Index", SubIndex, VisKillStrengthMin, VisKillStrengthMax, HitEffect, WeaponTypeTag, WeaponTypeSoundOverrideTag)
  VALUES ('ART_DEF_UNIT_MEMBER_TAR_SAO', 0, 0, 10.0, 20.0, 'ART_DEF_VEFFECT_CANNON_IMPACT_$(TERRAIN)', 'EXPLOSIVE', 'EXPLOSION6POUND');
INSERT INTO ArtDefine_StrategicView(StrategicViewType, TileType, Asset)
  VALUES ('ART_DEF_UNIT_TAR_SAO', 'Unit', 'Tar_Yuan_Sao_Alpha_128.dds');
