							INSERT INTO ArtDefine_UnitInfos (Type,												DamageStates,	Formation) VALUES
								('ART_DEF_UNIT_UC_SHARIF',				1,				'UnFormed');						
INSERT INTO ArtDefine_UnitMemberInfos (Type,												Scale,					Model,									MaterialTypeTag,	MaterialTypeSoundOverrideTag) VALUES
									  ('ART_DEF_UNIT_MEMBER_UC_SHARIF',			0.14000000059604645,	'aragw1.fxsxml',			'CLOTH',			'FLESH');									
INSERT INTO ArtDefine_UnitInfoMemberInfos (UnitInfoType,									UnitMemberInfoType,									NumMembers) VALUES
										  ('ART_DEF_UNIT_UC_SHARIF',				'ART_DEF_UNIT_MEMBER_UC_SHARIF',			14);									  
INSERT INTO ArtDefine_UnitMemberCombats (UnitMemberType,									EnableActions,																								ShortMoveRadius,	ShortMoveRate,		TargetHeight,	HasShortRangedAttack,	HasRefaceAfterCombat,	ReformBeforeCombat) VALUES
										('ART_DEF_UNIT_MEMBER_UC_SHARIF',			'Idle Attack RunCharge AttackCity Bombard Death BombardDefend Run Fortify CombatReady Walk AttackCharge',	12,					0.3499999940395355,	8,				1,						1,						1);									
INSERT INTO ArtDefine_UnitMemberCombatWeapons (UnitMemberType,								"Index",	SubIndex,	WeaponTypeTag,	WeaponTypeSoundOverrideTag) VALUES
											  ('ART_DEF_UNIT_MEMBER_UC_SHARIF',	0,			0,			'BULLET',		'BULLET');
INSERT INTO ArtDefine_StrategicView (StrategicViewType,									TileType,	Asset) VALUES
									('ART_DEF_UNIT_MEMBER_UC_SHARIF',			'Unit',		'aragw1.dds');
--==========================================================================================================================
-- ART_DEF_UNIT_FOREIGN_OP
--==========================================================================================================================
INSERT INTO ArtDefine_UnitInfos(Type, DamageStates, Formation)
  VALUES ('ART_DEF_UNIT_FOREIGN_OP', 1, 'EarlyGreatArtist');
INSERT INTO ArtDefine_UnitInfoMemberInfos(UnitInfoType, UnitMemberInfoType, NumMembers)
  VALUES ('ART_DEF_UNIT_FOREIGN_OP', 'ART_DEF_UNIT_MEMBER_TCM_MILITARY_ADVISER_1', 1);
INSERT INTO ArtDefine_UnitInfoMemberInfos(UnitInfoType, UnitMemberInfoType, NumMembers)
  VALUES ('ART_DEF_UNIT_FOREIGN_OP', 'ART_DEF_UNIT_MEMBER_TCM_MILITARY_ADVISER_BODYGUARD', 2);

  INSERT INTO ArtDefine_UnitMemberInfos(Type, Scale, Model, MaterialTypeTag, MaterialTypeSoundOverrideTag)
  VALUES ('ART_DEF_UNIT_MEMBER_TCM_MILITARY_ADVISER_1', 0.140000000596046, 'tcm_modern_Adviser.fxsxml', 'CLOTH', 'FLESH');
INSERT INTO ArtDefine_UnitMemberCombats(UnitMemberType, EnableActions, ShortMoveRadius, ShortMoveRate, TargetHeight, HasShortRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat)
  VALUES ('ART_DEF_UNIT_MEMBER_TCM_MILITARY_ADVISER_1', 'Idle Attack RunCharge AttackCity Bombard Death BombardDefend Run Fortify CombatReady Walk AttackCharge', 12.0, 0.349999994039536, 8.0, 1, 1, 1);
INSERT INTO ArtDefine_UnitMemberCombatWeapons(UnitMemberType, "Index", SubIndex, WeaponTypeTag, WeaponTypeSoundOverrideTag)
  VALUES ('ART_DEF_UNIT_MEMBER_TCM_MILITARY_ADVISER_1', 0, 0, 'BULLET', 'BULLET');
--==========================================================================================================================
-- IconTextureAtlases
--==========================================================================================================================
INSERT INTO IconTextureAtlases 
			(Atlas, 										IconSize, 	Filename, 									IconsPerRow, 	IconsPerColumn)
VALUES		('UC_HEJAZ_ATLAS', 						256, 		'Hejaz256.dds',				2,				2),
			('UC_HEJAZ_ATLAS', 						128, 		'Hejaz128.dds',				2, 				2),
			('UC_HEJAZ_ATLAS', 						80, 		'Hejaz80.dds',					2, 				2),
			('UC_HEJAZ_ATLAS', 						64, 		'Hejaz64.dds',					2, 				2),
			('UC_HEJAZ_ATLAS', 						45, 		'Hejaz45.dds',					2, 				2),
			('UC_HEJAZ_ATLAS', 						32, 		'Hejaz32.dds',					2, 				2),
			('UC_HEJAZ_ALPHA_ATLAS',					128, 		'HejazAlpha128.dds',			1,				1),
			('UC_HEJAZ_ALPHA_ATLAS',					80, 		'HejazAlpha80.dds',			1, 				1),
			('UC_HEJAZ_ALPHA_ATLAS',					64, 		'HejazAlpha64.dds',			1, 				1),
			('UC_HEJAZ_ALPHA_ATLAS',					48, 		'HejazAlpha48.dds',			1, 				1),
			('UC_HEJAZ_ALPHA_ATLAS',					32, 		'HejazAlpha32.dds',			1, 				1),
			('UC_HEJAZ_ALPHA_ATLAS',					24, 		'HejazAlpha24.dds',			1, 				1),
			('UC_HEJAZ_ALPHA_ATLAS',	 				16, 		'HejazAlpha16.dds',			1, 				1),
			('UC_SHARIF_FLAG_ATLAS',				32,			'SharifianFlag.dds',			1, 				1),
			('UC_OP_FLAG_ATLAS',				32,			'flag.dds',			1, 				1);
--==========================================================================================================================
--==========================================================================================================================
									