---------------------------
--Units
---------------------------

INSERT INTO Units 
		(Class,									Type,	Combat,		Cost,	FaithCost,	RequiresFaithPurchaseEnabled,	Moves,			CombatClass,				Domain,				DefaultUnitAI,							Description,								Civilopedia,										Strategy,										Help,		NoBadGoodies,		Pillage,	MilitarySupport,	MilitaryProduction,						ObsoleteTech,		GoodyHutUpgradeUnitClass,		FoundAbroad,		AdvancedStartCost,		XPValueAttack,		XPValueDefense,											UnitArtInfo,						UnitFlagAtlas,		UnitFlagIconOffset,					IconAtlas,		PortraitIndex)
VALUES	('UNITCLASS_SCOUT',  'UNIT_SAS_TIAT',        5,       45,          90,                             1,       2,   'UNITCOMBAT_RECON',         'DOMAIN_LAND',          'UNITAI_EXPLORE',      'TXT_KEY_UNIT_SAS_TIAT',       'TXT_KEY_CIVILOPEDIA_SAS_TIAT_TEXT',        'TXT_KEY_UNIT_SAS_TIAT_STRATEGY',       'TXT_KEY_UNIT_SAS_TIAT_HELP',                  1,             1,                  1,                     1,         'TECH_SCIENTIFIC_THEORY',		      'UNITCLASS_ARCHER',                   1,                     10,                  3,                   3,         'ART_DEF_UNIT_SAS_TIAT',     'SAS_TIAT_FLAG',                       0,		'CIV_COLOR_ATLAS_SAS_TONGVA',                  2);

INSERT INTO Unit_AITypes 
		(UnitType,							UnitAIType)
VALUES	('UNIT_SAS_TIAT',     'UNITAI_EXPLORE');

INSERT INTO Unit_Flavors 
		(UnitType,							FlavorType,				Flavor)
VALUES	('UNIT_SAS_TIAT',       'FLAVOR_RECON',                  8);

INSERT INTO Unit_FreePromotions 
		(UnitType,											PromotionType)
VALUES	('UNIT_SAS_TIAT',         'PROMOTION_IGNORE_TERRAIN_COST'), 
		('UNIT_SAS_TIAT',                'PROMOTION_EMBARKED_SIGHT'),
		('UNIT_SAS_TIAT',        'PROMOTION_DEFENSIVE_EMBARKATION');

---------------------------
--Buildings
---------------------------

INSERT INTO BuildingClasses
        (Type,                                         DefaultBuilding,                         Description)
VALUES    ('BUILDINGCLASS_SAS_TONGVA_SCIENCE',        'BUILDING_SAS_TONGVA_SCIENCE',            'TXT_KEY_BUILDING_SAS_TONGVA_SCIENCE');

INSERT INTO Buildings      
        (TYPE,                                        BuildingClass,                                     Cost,  FaithCost, GreatWorkCount,   NeverCapture,  Description)
VALUES  ('BUILDING_SAS_TONGVA_SCIENCE',                'BUILDINGCLASS_SAS_TONGVA_SCIENCE',                 -1,    -1,        -1,               1,             'TXT_KEY_BUILDING_SAS_TONGVA_SCIENCE');

INSERT INTO Building_YieldChanges
        (BuildingType,                    YieldType,            Yield)
VALUES    ('BUILDING_SAS_TONGVA_SCIENCE',    'YIELD_SCIENCE',    1);

--==========================================================================================================================	
-- Buildings
--==========================================================================================================================	
INSERT INTO Buildings 	
			(Type, 						 HurryCostModifier, FreeStartEra, BuildingClass, PrereqTech, Cost, FaithCost, ConquestProb, SpecialistType, SpecialistCount, MinAreaSize, GoldMaintenance, Description, 							Civilopedia, 							Help, 										Strategy,										ArtDefineTag, PortraitIndex,	IconAtlas)
SELECT		('BUILDING_SAS_KIHAY'),	HurryCostModifier, FreeStartEra, BuildingClass, PrereqTech, Cost, FaithCost, ConquestProb, SpecialistType, SpecialistCount, MinAreaSize, 0, ('TXT_KEY_BUILDING_SAS_KIHAY'),	('TXT_KEY_BUILDING_SAS_KIHAY_PEDIA'),	('TXT_KEY_BUILDING_SAS_KIHAY_HELP'),	('TXT_KEY_BUILDING_SAS_KIHAY_STRATEGY'),	ArtDefineTag, 3, 				('CIV_COLOR_ATLAS_SAS_TONGVA')
FROM Buildings WHERE Type = 'BUILDING_LIGHTHOUSE';

UPDATE Buildings
SET	
	PrereqTech	= 	(SELECT PrereqTech FROM Buildings WHERE Type = 'BUILDING_LIGHTHOUSE'), 
	Cost 		= 	(SELECT Cost FROM Buildings WHERE Type = 'BUILDING_LIGHTHOUSE'), 
	FaithCost 	= 	(SELECT FaithCost FROM Buildings WHERE Type = 'BUILDING_LIGHTHOUSE')
WHERE Type = 'BUILDING_SAS_KIHAY';
--==========================================================================================================================	
-- Building_ClassesNeededInCity
--==========================================================================================================================	
INSERT INTO Building_ClassesNeededInCity 	
			(BuildingType, 				BuildingClassType)
SELECT		('BUILDING_SAS_KIHAY'),	BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_LIGHTHOUSE';	
--==========================================================================================================================	
-- Building_YieldChanges
--==========================================================================================================================	
INSERT INTO Building_YieldChanges
			(BuildingType, 				YieldType, Yield)
SELECT		('BUILDING_SAS_KIHAY'),	YieldType, Yield
FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_LIGHTHOUSE';	
--==========================================================================================================================	
-- Building_SeaPlotYieldChanges
--==========================================================================================================================	
INSERT INTO Building_SeaPlotYieldChanges
			(BuildingType, 				YieldType, Yield)
SELECT		('BUILDING_SAS_KIHAY'),	YieldType, Yield
FROM Building_SeaPlotYieldChanges WHERE BuildingType = 'BUILDING_LIGHTHOUSE';
--==========================================================================================================================	
-- Building_SeaResourceYieldChanges
--==========================================================================================================================	
INSERT INTO Building_SeaResourceYieldChanges
			(BuildingType, 				YieldType, Yield)
SELECT		('BUILDING_SAS_KIHAY'),	YieldType, Yield
FROM Building_SeaResourceYieldChanges WHERE BuildingType = 'BUILDING_LIGHTHOUSE';
--==========================================================================================================================	
-- Building_ResourceYieldChanges
--==========================================================================================================================	
INSERT INTO Building_ResourceYieldChanges
			(BuildingType, 				ResourceType, YieldType, Yield)
SELECT		('BUILDING_SAS_KIHAY'),	ResourceType, YieldType, Yield
FROM Building_ResourceYieldChanges WHERE BuildingType = 'BUILDING_LIGHTHOUSE';	
--==========================================================================================================================	
-- Building_Flavors
--==========================================================================================================================	
INSERT INTO Building_Flavors 	
			(BuildingType, 				FlavorType, Flavor)
SELECT		('BUILDING_SAS_KIHAY'),	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_LIGHTHOUSE';

INSERT OR REPLACE INTO Building_Flavors 	
			(BuildingType, 				FlavorType, Flavor)
SELECT		('BUILDING_SAS_KIHAY'),	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_CARAVANSARY';

INSERT OR REPLACE INTO Building_Flavors 	
			(BuildingType, 				FlavorType, Flavor)
SELECT		('BUILDING_SAS_KIHAY'),	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_HARBOR';