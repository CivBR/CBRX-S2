INSERT INTO ArtDefine_LandmarkTypes(Type, LandmarkType, FriendlyName)
SELECT 'ART_DEF_IMPROVEMENT_OLMEC_COLOSSAL_HEADS', 'Improvement', 'OLMEC_COLOSSAL_HEADS';

INSERT INTO ArtDefine_Landmarks(Era, State, Scale, ImprovementType, LayoutHandler, ResourceType, Model, TerrainContour)
SELECT 'Any', 'Constructed', 1.0,  'ART_DEF_IMPROVEMENT_OLMEC_COLOSSAL_HEADS', 'SNAPSHOT', 'ART_DEF_RESOURCE_ALL', 'olmec_colossalheads.fxsxml', 1 UNION ALL
SELECT 'Any', 'Pillaged', 1.0,  'ART_DEF_IMPROVEMENT_OLMEC_COLOSSAL_HEADS', 'SNAPSHOT', 'ART_DEF_RESOURCE_ALL', 'olmec_colossalheads_pl.fxsxml', 1;

INSERT INTO ArtDefine_StrategicView(StrategicViewType, TileType, Asset)
SELECT 'ART_DEF_IMPROVEMENT_OLMEC_COLOSSAL_HEADS', 'Improvement', 'sv_olmec_colossal_heads.dds';

---
---

INSERT INTO Units 	
			  (Type, 							   Class,	          PrereqTech,			 Cost,   Moves,	 CivilianAttackPriority, Special,	Domain,		DefaultUnitAI, Description,								Civilopedia, Strategy, ShowInPedia,	AdvancedStartCost,  WorkRate, CombatLimit, GoldenAgeTurns, UnitArtInfoEraVariation, UnitArtInfo, UnitFlagIconOffset,   UnitFlagAtlas, PortraitIndex, MoveRate, IconAtlas)
SELECT		  ('UNIT_OLMEC_UNIQUE_ART'),           Class,	('TECH_AGRICULTURE'),	         Cost,   Moves,	 CivilianAttackPriority, Special,	Domain,		DefaultUnitAI, Description,								Civilopedia, Strategy, 	         0, AdvancedStartCost,  WorkRate, CombatLimit, GoldenAgeTurns, UnitArtInfoEraVariation, UnitArtInfo, UnitFlagIconOffset,   UnitFlagAtlas, PortraitIndex, MoveRate, IconAtlas
FROM Units WHERE (Type = 'UNIT_ARTIST') AND EXISTS (SELECT Type FROM Buildings WHERE Type = 'BUILDING_PALACE');

INSERT INTO Unit_UniqueNames 
			(UnitType, 							                               UniqueName,							  GreatWorkType)
SELECT		('UNIT_OLMEC_UNIQUE_ART'), 	                ('TXT_KEY_UNIT_OLMEC_UNIQUE_ART'),	         ('GREAT_WORK_OLMEC_UNIQUE_ART')
WHERE EXISTS (SELECT Type FROM Buildings WHERE Type = 'BUILDING_PALACE');

INSERT INTO Civilization_UnitClassOverrides 
		(CivilizationType, 					           UnitClassType, 			                    UnitType)
SELECT	('CIVILIZATION_BARBARIAN'), 			('UNITCLASS_ARTIST'),		        ('UNIT_OLMEC_UNIQUE_ART')
WHERE EXISTS (SELECT Type FROM Buildings WHERE Type = 'BUILDING_PALACE');

INSERT INTO GreatWorks 
			(Type, 										  GreatWorkClassType,		                                     Description,						             Audio,			                 Image)
SELECT		('GREAT_WORK_OLMEC_UNIQUE_ART'), 	  ('GREAT_WORK_ART'),		                 ('TXT_KEY_GREAT_WORK_OLMEC_UNIQUE_ART'),		     ('AS2D_GREAT_ARTIST_ARTWORK'), 	('gw_olmec_unique_art.dds')
WHERE EXISTS (SELECT Type FROM Buildings WHERE Type = 'BUILDING_PALACE');

INSERT INTO Unit_AITypes
		(UnitType,																	 UnitAIType)
Values	('UNIT_OLMEC_UNIQUE_ART',												'UNITAI_ARTIST');

INSERT INTO Unit_Flavors
		(UnitType,															 FlavorType,						Flavor)
Values	('UNIT_OLMEC_UNIQUE_ART',									   'FLAVOR_CULTURE',							 1);

INSERT INTO Unit_Builds 
			(UnitType,											   BuildType)
VALUES	    ('UNIT_OLMEC_UNIQUE_ART',			'BUILD_LEUGI_COLOSSAL_HEADS');

--
--
