---------------------------
--Buildings
---------------------------

INSERT INTO Buildings 
		(Type,											     BuildingClass,			      MaxStartEra,	Cost,	GreatWorkCount,      GoldMaintenance,               PrereqTech,										     Description,													    Civilopedia,											        Strategy,													    Help,						   ArtDefineTag,		         MinAreaSize,	ConquestProb,	NeverCapture,	HurryCostModifier,		                         IconAtlas,		PortraitIndex)
VALUES	('BUILDING_MISSISSIPPI_MOD_TOMATEKH',		'BUILDINGCLASS_TEMPLE',			'ERA_RENAISSANCE',	 100,	            -1,					   0,        'TECH_PHILOSOPHY',		'TXT_KEY_BUILDING_MISSISSIPPI_MOD_TOMATEKH_DESC',		'TXT_KEY_CIVLOPEDIA_BUILDING_MISSISSIPPI_MOD_TOMATEKH_TEXT',		'TXT_KEY_BUILDING_MISSISSIPPI_MOD_TOMATEKH_STRATEGY',			'TXT_KEY_BUILDING_MISSISSIPPI_MOD_TOMATEKH_HELP',					           'TEMPLE',		                  -1,	           0,	            1,			       25,		  'MISSISSIPPI_MOD_TOMATEKH_ATLAS',					3);

INSERT INTO Building_ClassesNeededInCity 
		(BuildingType,											             BuildingClassType)
VALUES	('BUILDING_MISSISSIPPI_MOD_TOMATEKH',				            'BUILDINGCLASS_SHRINE');

INSERT INTO Building_Flavors
		(BuildingType,															     FlavorType,						 Flavor)
Values	('BUILDING_MISSISSIPPI_MOD_TOMATEKH',								  'FLAVOR_RELIGION',							 40),
		('BUILDING_MISSISSIPPI_MOD_TOMATEKH',					               'FLAVOR_SCIENCE',						     40);

--Dummy
---------------------------

INSERT INTO Buildings 
		(Type,											              BuildingClass,			Cost,		FaithCost,		PrereqTech,	 GoldMaintenance,	       									 Description,													    Civilopedia,											        Strategy,													    Help,						   ArtDefineTag,		         MinAreaSize,	ConquestProb,	NeverCapture,	HurryCostModifier,		                         IconAtlas,		PortraitIndex)
VALUES	('BUILDING_MISSISSIPPI_MOD_4_0',		'BUILDINGCLASS_MISSISSIPPI_MOD_4_0',			  -1,			   -1,		      NULL,                0,		'TXT_KEY_BUILDING_MISSISSIPPI_MOD_TOMATEKH_DESC',		'TXT_KEY_CIVLOPEDIA_BUILDING_MISSISSIPPI_MOD_TOMATEKH_TEXT',		'TXT_KEY_BUILDING_MISSISSIPPI_MOD_TOMATEKH_STRATEGY',			'TXT_KEY_BUILDING_MISSISSIPPI_MOD_TOMATEKH_HELP',					           'TEMPLE',		                  -1,	           0,	            1,			       25,		  'MISSISSIPPI_MOD_TOMATEKH_ATLAS',					3),
		('BUILDING_MISSISSIPPI_MOD_3_1',		'BUILDINGCLASS_MISSISSIPPI_MOD_3_1',			  -1,			   -1,		      NULL,                0,		'TXT_KEY_BUILDING_MISSISSIPPI_MOD_TOMATEKH_DESC',		'TXT_KEY_CIVLOPEDIA_BUILDING_MISSISSIPPI_MOD_TOMATEKH_TEXT',		'TXT_KEY_BUILDING_MISSISSIPPI_MOD_TOMATEKH_STRATEGY',			'TXT_KEY_BUILDING_MISSISSIPPI_MOD_TOMATEKH_HELP',					           'TEMPLE',		                  -1,	           0,	            1,			       25,		  'MISSISSIPPI_MOD_TOMATEKH_ATLAS',					3),
		('BUILDING_MISSISSIPPI_MOD_2_2',		'BUILDINGCLASS_MISSISSIPPI_MOD_2_2',			  -1,			   -1,		      NULL,                0,		'TXT_KEY_BUILDING_MISSISSIPPI_MOD_TOMATEKH_DESC',		'TXT_KEY_CIVLOPEDIA_BUILDING_MISSISSIPPI_MOD_TOMATEKH_TEXT',		'TXT_KEY_BUILDING_MISSISSIPPI_MOD_TOMATEKH_STRATEGY',			'TXT_KEY_BUILDING_MISSISSIPPI_MOD_TOMATEKH_HELP',					           'TEMPLE',		                  -1,	           0,	            1,			       25,		  'MISSISSIPPI_MOD_TOMATEKH_ATLAS',					3),
		('BUILDING_MISSISSIPPI_MOD_1_3',		'BUILDINGCLASS_MISSISSIPPI_MOD_1_3',			  -1,			   -1,		      NULL,                0,		'TXT_KEY_BUILDING_MISSISSIPPI_MOD_TOMATEKH_DESC',		'TXT_KEY_CIVLOPEDIA_BUILDING_MISSISSIPPI_MOD_TOMATEKH_TEXT',		'TXT_KEY_BUILDING_MISSISSIPPI_MOD_TOMATEKH_STRATEGY',			'TXT_KEY_BUILDING_MISSISSIPPI_MOD_TOMATEKH_HELP',					           'TEMPLE',		                  -1,	           0,	            1,			       25,		  'MISSISSIPPI_MOD_TOMATEKH_ATLAS',					3),
		('BUILDING_MISSISSIPPI_MOD_0_4',		'BUILDINGCLASS_MISSISSIPPI_MOD_0_4',			  -1,			   -1,		      NULL,                0,		'TXT_KEY_BUILDING_MISSISSIPPI_MOD_TOMATEKH_DESC',		'TXT_KEY_CIVLOPEDIA_BUILDING_MISSISSIPPI_MOD_TOMATEKH_TEXT',		'TXT_KEY_BUILDING_MISSISSIPPI_MOD_TOMATEKH_STRATEGY',			'TXT_KEY_BUILDING_MISSISSIPPI_MOD_TOMATEKH_HELP',					           'TEMPLE',		                  -1,	           0,	            1,			       25,		  'MISSISSIPPI_MOD_TOMATEKH_ATLAS',					3);

INSERT INTO BuildingClasses
		(Type,																			   DefaultBuilding,												   Description)
Values	('BUILDINGCLASS_MISSISSIPPI_MOD_4_0',		                        'BUILDING_MISSISSIPPI_MOD_4_0',		      'TXT_KEY_BUILDING_MISSISSIPPI_MOD_TOMATEKH_DESC'),
		('BUILDINGCLASS_MISSISSIPPI_MOD_3_1',		                        'BUILDING_MISSISSIPPI_MOD_3_1',		      'TXT_KEY_BUILDING_MISSISSIPPI_MOD_TOMATEKH_DESC'),
		('BUILDINGCLASS_MISSISSIPPI_MOD_2_2',		                        'BUILDING_MISSISSIPPI_MOD_2_2',		      'TXT_KEY_BUILDING_MISSISSIPPI_MOD_TOMATEKH_DESC'),
		('BUILDINGCLASS_MISSISSIPPI_MOD_1_3',		                        'BUILDING_MISSISSIPPI_MOD_1_3',		      'TXT_KEY_BUILDING_MISSISSIPPI_MOD_TOMATEKH_DESC'),
		('BUILDINGCLASS_MISSISSIPPI_MOD_0_4',		                        'BUILDING_MISSISSIPPI_MOD_0_4',		      'TXT_KEY_BUILDING_MISSISSIPPI_MOD_TOMATEKH_DESC');

INSERT INTO Building_YieldChanges 
		(BuildingType,											                  YieldType,						  Yield)
VALUES	('BUILDING_MISSISSIPPI_MOD_4_0',				                      'YIELD_FAITH',							  4),
		('BUILDING_MISSISSIPPI_MOD_3_1',				                      'YIELD_FAITH',							  3),
		('BUILDING_MISSISSIPPI_MOD_3_1',				                    'YIELD_SCIENCE',							  1),
		('BUILDING_MISSISSIPPI_MOD_2_2',				                      'YIELD_FAITH',							  2),
		('BUILDING_MISSISSIPPI_MOD_2_2',				                    'YIELD_SCIENCE',							  2),
		('BUILDING_MISSISSIPPI_MOD_1_3',				                      'YIELD_FAITH',							  1),
		('BUILDING_MISSISSIPPI_MOD_1_3',				                    'YIELD_SCIENCE',							  3),
		('BUILDING_MISSISSIPPI_MOD_0_4',				                    'YIELD_SCIENCE',							  4);

INSERT INTO Buildings 
		(Type,																				        BuildingClass,	  Cost,		FaithCost,		PrereqTech,		GreatWorkCount,															 Help,										                Description,	                                                        Civilopedia,													        Strategy,				    ArtDefineTag,		 MinAreaSize,	HurryCostModifier,		        IconAtlas,		     PortraitIndex,		     NeverCapture,		NukeImmune)
VALUES	('BUILDING_MISSISSIPPI_FOOD_DUMMY',						           'BUILDINGCLASS_MISSISSIPPI_FOOD_DUMMY',		-1,			   -1,		     NULL,			        -1,			       'TXT_KEY_BUILDING_MISSISSIPPI_FOOD_DUMMY_HELP',                   'TXT_KEY_BUILDING_MISSISSIPPI_FOOD_DUMMY_DESC',					     'TXT_KEY_BUILDING_MISSISSIPPI_FOOD_DUMMY_TEXT',			      'TXT_KEY_BUILDING_MISSISSIPPI_FOOD_DUMMY_STRATEGY',	  'ART_DEF_BUILDING_GRANARY',				  -1,			       25,		     'BW_ATLAS_1',                       0,                     1,               1),
		('BUILDING_MISSISSIPPI_MAINT_DUMMY',						      'BUILDINGCLASS_MISSISSIPPI_MAINT_DUMMY',		-1,			   -1,		     NULL,			        -1,			      'TXT_KEY_BUILDING_MISSISSIPPI_MAINT_DUMMY_HELP',                  'TXT_KEY_BUILDING_MISSISSIPPI_MAINT_DUMMY_DESC',					     'TXT_KEY_BUILDING_MISSISSIPPI_FOOD_DUMMY_TEXT',			      'TXT_KEY_BUILDING_MISSISSIPPI_FOOD_DUMMY_STRATEGY',	                'COURTHOUSE',				  -1,			       25,		     'BW_ATLAS_1',                      63,                     1,               1),
		('BUILDING_MISSISSIPPI_PROD_DUMMY',						           'BUILDINGCLASS_MISSISSIPPI_PROD_DUMMY',		-1,			   -1,		     NULL,			        -1,			       'TXT_KEY_BUILDING_MISSISSIPPI_PROD_DUMMY_HELP',                   'TXT_KEY_BUILDING_MISSISSIPPI_PROD_DUMMY_DESC',					     'TXT_KEY_BUILDING_MISSISSIPPI_FOOD_DUMMY_TEXT',			      'TXT_KEY_BUILDING_MISSISSIPPI_FOOD_DUMMY_STRATEGY',	    'ART_DEF_BUILDING_FORGE',				  -1,			       25,		     'BW_ATLAS_1',                       2,                     1,               1);

INSERT INTO BuildingClasses
		(Type,																					  DefaultBuilding,												 Description)
Values	('BUILDINGCLASS_MISSISSIPPI_FOOD_DUMMY',		                        'BUILDING_MISSISSIPPI_FOOD_DUMMY',		      'TXT_KEY_BUILDING_MISSISSIPPI_FOOD_DUMMY_DESC'),
	    ('BUILDINGCLASS_MISSISSIPPI_MAINT_DUMMY',		                       'BUILDING_MISSISSIPPI_MAINT_DUMMY',		     'TXT_KEY_BUILDING_MISSISSIPPI_MAINT_DUMMY_DESC'),
		('BUILDINGCLASS_MISSISSIPPI_PROD_DUMMY',		                        'BUILDING_MISSISSIPPI_PROD_DUMMY',		      'TXT_KEY_BUILDING_MISSISSIPPI_PROD_DUMMY_DESC');

INSERT INTO Building_YieldModifiers
		(BuildingType,												       YieldType,		  Yield)
Values	('BUILDING_MISSISSIPPI_FOOD_DUMMY',		                        'YIELD_FOOD',		      1);

INSERT INTO Building_DomainProductionModifiers
		(BuildingType,												       DomainType,	   Modifier)
Values	('BUILDING_MISSISSIPPI_PROD_DUMMY',		                        'DOMAIN_LAND',		     50);

---------------------------
--Units
---------------------------

INSERT INTO Units 
		(Class,												           Type,	  PrereqTech,		Combat,		Cost,	FaithCost,	RequiresFaithPurchaseEnabled,	Moves,         CombatClass,            Domain,        DefaultUnitAI,                                Description,                                               Civilopedia,                                             Strategy,                                               Help,	MilitarySupport,	 MilitaryProduction,	Pillage,         ObsoleteTech,   GoodyHutUpgradeUnitClass,	 AdvancedStartCost,		XPValueAttack,		XPValueDefense,		Conscription,                                   UnitArtInfo,                                      UnitFlagAtlas,	UnitFlagIconOffset,                                IconAtlas,	   PortraitIndex)
VALUES	('UNITCLASS_LONGSWORDSMAN',			'UNIT_MISSISSIPPI_MOD_TOMATEKH',	'TECH_STEEL',			21,      120,	      240,	                           1,       2,	'UNITCOMBAT_MELEE',		'DOMAIN_LAND',		'UNITAI_ATTACK',	'TXT_KEY_UNIT_MISSISSIPPI_MOD_TOMATEKH',		'TXT_KEY_CIVLOPEDIA_MISSISSIPPI_MOD_TOMATEKH_TEXT',		'TXT_KEY_UNIT_MISSISSIPPI_MOD_TOMATEKH_STRATEGY',		'TXT_KEY_UNIT_MISSISSIPPI_MOD_TOMATEKH_HELP',		          1,                      1,          1,	'TECH_METALLURGY',		'UNITCLASS_MUSKETMAN',	                25,                 3,                   3,                3,		  'ART_DEF_UNIT_MISSISSIPPI_MOD_FALCON',		'MISSISSIPPI_MOD_TOMATEKH_UNIT_ALPHA_ATLAS',				     0,			'MISSISSIPPI_MOD_TOMATEKH_ATLAS',                  2);

INSERT INTO Unit_AITypes
		(UnitType,															     UnitAIType)
Values	('UNIT_MISSISSIPPI_MOD_TOMATEKH',									'UNITAI_ATTACK'),
		('UNIT_MISSISSIPPI_MOD_TOMATEKH',					               'UNITAI_DEFENSE');

INSERT INTO Unit_ClassUpgrades
		(UnitType,														      UnitClassType)
Values	('UNIT_MISSISSIPPI_MOD_TOMATEKH',							  'UNITCLASS_MUSKETMAN');

INSERT INTO Unit_Flavors
		(UnitType,															     FlavorType,						Flavor)
Values	('UNIT_MISSISSIPPI_MOD_TOMATEKH',					               'FLAVOR_OFFENSE',						     9),
		('UNIT_MISSISSIPPI_MOD_TOMATEKH',					               'FLAVOR_DEFENSE',							 7);

---------------------------
--Improvements
---------------------------

INSERT INTO Improvements 
		(Type,														                      Description,                                            Civilopedia,									                     Help,			                                ArtDefineTag,		RequiresFlatlands,		Permanent,			GraphicalOnly,		PortraitIndex,			               IconAtlas)
VALUES	('IMPROVEMENT_MISSISSIPPIAN_PLATFORM_MOD',   'TXT_KEY_IMPROVEMENT_MISSISSIPPIAN_PLATFORM_MOD',	'TXT_KEY_IMPROVEMENT_MISSISSIPPIAN_PLATFORM_MOD_TEXT',		'TXT_KEY_IMPROVEMENT_MISSISSIPPIAN_PLATFORM_MOD_HELP',		'ART_DEF_IMPROVEMENT_MISSISSIPPIAN_PLATFORM_MOD',                       1,	             1,						 1,			        4,	'MISSISSIPPI_MOD_TOMATEKH_ATLAS');

INSERT INTO Improvement_ValidTerrains 
		(ImprovementType,							        TerrainType)
VALUES	('IMPROVEMENT_MISSISSIPPIAN_PLATFORM_MOD',      'TERRAIN_GRASS'),
		('IMPROVEMENT_MISSISSIPPIAN_PLATFORM_MOD',     'TERRAIN_PLAINS'),
		('IMPROVEMENT_MISSISSIPPIAN_PLATFORM_MOD',     'TERRAIN_DESERT'),
		('IMPROVEMENT_MISSISSIPPIAN_PLATFORM_MOD',     'TERRAIN_TUNDRA'),
		('IMPROVEMENT_MISSISSIPPIAN_PLATFORM_MOD',       'TERRAIN_SNOW');





