--INSERT INTO ArtDefine_LandmarkTypes(Type, 			         LandmarkType, 	            FriendlyName)
--SELECT 'ART_DEF_IMPROVEMENT_MISSISSIPPIAN_PLATFORM_MOD', 	'Improvement', 	'TOMATEKH_MISSISSIPPIAN';
--	
--INSERT INTO ArtDefine_Landmarks
--        (Era, 	                   State, 		   Scale,	                                   ImprovementType, 	LayoutHandler, 		            ResourceType, 	Model, 	TerrainContour)
--SELECT   Era,                      State,          Scale,   ('ART_DEF_IMPROVEMENT_MISSISSIPPIAN_PLATFORM_MOD'),		LayoutHandler,		            ResourceType,	Model,	TerrainContour
--FROM ArtDefine_Landmarks WHERE ImprovementType = 'ART_DEF_IMPROVEMENT_CITADEL' AND State = 'Constructed';
--
--INSERT INTO ArtDefine_StrategicView(StrategicViewType, TileType, Asset)
--  VALUES ('ART_DEF_IMPROVEMENT_MISSISSIPPIAN_PLATFORM_MOD', 'Improvement', 'sv_MississippianPlatform.dds');

INSERT INTO ArtDefine_LandmarkTypes(Type, 			         LandmarkType, 	            FriendlyName)
SELECT 'ART_DEF_IMPROVEMENT_MISSISSIPPIAN_PLATFORM_MOD', 	'Improvement', 	'TOMATEKH_MISSISSIPPIAN';
	
INSERT INTO ArtDefine_Landmarks
        (Era, 	                   State, 		   Scale,	                                   ImprovementType, 	LayoutHandler, 		            ResourceType, 	                   Model, 	TerrainContour)
SELECT  'Any',	           'Constructed',	       0.725,	  'ART_DEF_IMPROVEMENT_MISSISSIPPIAN_PLATFORM_MOD',		   'SNAPSHOT',		  'ART_DEF_RESOURCE_ALL',		'Tribe_Huron.fxsxml',		         1;

INSERT INTO ArtDefine_StrategicView(StrategicViewType, TileType, Asset)
  VALUES ('ART_DEF_IMPROVEMENT_MISSISSIPPIAN_PLATFORM_MOD', 'Improvement', 'sv_MississippianPlatform.dds');

----
----
----

INSERT INTO ArtDefine_UnitInfos(Type, DamageStates, Formation)
  VALUES ('ART_DEF_UNIT_MISSISSIPPI_MOD_FALCON', 1, 'UnFormed');

INSERT INTO ArtDefine_UnitInfoMemberInfos(UnitInfoType, UnitMemberInfoType, NumMembers)
  VALUES ('ART_DEF_UNIT_MISSISSIPPI_MOD_FALCON', 'ART_DEF_UNIT_MISSISSIPPI_MOD_FALCON_MEMBER', 12);

INSERT INTO ArtDefine_UnitMemberInfos(Type, Scale, Model, MaterialTypeTag, MaterialTypeSoundOverrideTag)
  VALUES ('ART_DEF_UNIT_MISSISSIPPI_MOD_FALCON_MEMBER', 0.140000000596046, 'AztecEagleWarrior.fxsxml', 'CLOTH', 'FLESH');

INSERT INTO ArtDefine_UnitMemberCombats(UnitMemberType, EnableActions, ShortMoveRadius, ShortMoveRate, TargetHeight, HasRefaceAfterCombat)
  VALUES ('ART_DEF_UNIT_MISSISSIPPI_MOD_FALCON_MEMBER', 'Idle Attack RunCharge AttackCity Bombard Death BombardDefend Run Fortify CombatReady Walk AttackCharge', 12.0, 0.349999994039536, 8.0, 1);

INSERT INTO ArtDefine_UnitMemberCombatWeapons(UnitMemberType, "Index", SubIndex, WeaponTypeTag, WeaponTypeSoundOverrideTag)
  VALUES ('ART_DEF_UNIT_MISSISSIPPI_MOD_FALCON_MEMBER', 0, 0, 'BLUNT', 'BLUNT');
INSERT INTO ArtDefine_UnitMemberCombatWeapons(UnitMemberType, "Index", SubIndex, VisKillStrengthMin, VisKillStrengthMax, WeaponTypeTag, MissTargetSlopRadius)
  VALUES ('ART_DEF_UNIT_MISSISSIPPI_MOD_FALCON_MEMBER', 1, 0, 10.0, 20.0, 'FLAMING_ARROW', 10.0);

INSERT INTO ArtDefine_StrategicView(StrategicViewType, TileType, Asset)
  VALUES ('ART_DEF_UNIT_MISSISSIPPI_MOD_FALCON', 'Unit', 'sv_Mississippian_Unit.dds');