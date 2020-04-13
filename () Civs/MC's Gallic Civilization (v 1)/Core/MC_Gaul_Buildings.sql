--==========================================================================================================================	
-- BuildingClasses
--==========================================================================================================================	
INSERT INTO BuildingClasses 	
			(Type, 						 		 		DefaultBuilding, 						Description)
VALUES		('BUILDINGCLASS_MC_GAUL_GOLD', 				'BUILDING_MC_GAUL_GOLD', 				'TXT_KEY_BUILDING_MC_GAUL_GOLD');
--==========================================================================================================================	
-- Buildings
--==========================================================================================================================	
INSERT INTO Buildings 	
			(Type, 								BuildingClass, PrereqTech, Cost, GoldMaintenance, MinAreaSize,  Description, 								Civilopedia, 								Help, 											Strategy,											ArtDefineTag, ConquestProb, HurryCostModifier, PortraitIndex, 	IconAtlas)
SELECT		('BUILDING_MC_GAUL_METALSMITH'), 	BuildingClass, PrereqTech, Cost, GoldMaintenance, MinAreaSize, 	('TXT_KEY_BUILDING_MC_GAUL_METALSMITH'), 	('TXT_KEY_CIV5_MC_GAUL_METALSMITH_TEXT'),   ('TXT_KEY_BUILDING_MC_GAUL_METALSMITH_HELP'), 	('TXT_KEY_BUILDING_MC_GAUL_METALSMITH_STRATEGY'),	ArtDefineTag, ConquestProb, HurryCostModifier, 3, 				('MC_GAUL_ATLAS')
FROM Buildings WHERE Type = 'BUILDING_MINT';		

INSERT INTO Buildings 	
			(Type, 						 BuildingClass, 					Description,						Help,									GreatWorkCount, Cost, FaithCost, PrereqTech, 	NeverCapture)
VALUES		('BUILDING_MC_GAUL_GOLD', 	'BUILDINGCLASS_MC_GAUL_GOLD',		'TXT_KEY_BUILDING_MC_GAUL_GOLD',	'TXT_KEY_BUILDING_MC_GAUL_GOLD_HELP',	-1, 			-1,   -1, 		 null,			1);
--==========================================================================================================================	
-- Building_LocalResourceOrs
--==========================================================================================================================
INSERT INTO Building_LocalResourceOrs 	
			(BuildingType, 						ResourceType)
SELECT		('BUILDING_MC_GAUL_METALSMITH'), 	ResourceType
FROM Building_LocalResourceOrs WHERE BuildingType = 'BUILDING_MINT';

INSERT INTO Building_LocalResourceOrs
			(BuildingType, 						ResourceType)
VALUES		('BUILDING_MC_GAUL_METALSMITH', 	'RESOURCE_IRON'),
			('BUILDING_MC_GAUL_METALSMITH', 	'RESOURCE_ALUMINUM'),
			('BUILDING_MC_GAUL_METALSMITH', 	'RESOURCE_COPPER');
--==========================================================================================================================	
-- Building_ResourceYieldChanges
--==========================================================================================================================
INSERT INTO Building_ResourceYieldChanges 	
			(BuildingType, 						ResourceType, YieldType, Yield)
SELECT		('BUILDING_MC_GAUL_METALSMITH'), 	ResourceType, YieldType, Yield
FROM Building_ResourceYieldChanges WHERE BuildingType = 'BUILDING_MINT';

/*
INSERT INTO Building_ResourceYieldChanges 	
			(BuildingType, 						ResourceType, 			YieldType, 		Yield)
VALUES		('BUILDING_MC_GAUL_METALSMITH', 	'RESOURCE_IRON',		'YIELD_GOLD', 	2),
			('BUILDING_MC_GAUL_METALSMITH', 	'RESOURCE_ALUMINUM',	'YIELD_GOLD', 	2),
			('BUILDING_MC_GAUL_METALSMITH', 	'RESOURCE_COPPER',		'YIELD_GOLD', 	2);
*/
--==========================================================================================================================	
-- Building_Flavors
--==========================================================================================================================	
INSERT INTO Building_Flavors 	
			(BuildingType, 						FlavorType, Flavor)
SELECT		('BUILDING_MC_GAUL_METALSMITH'),	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_MINT';
--==========================================================================================================================	
-- Building_YieldModifiers
--==========================================================================================================================		
INSERT INTO Building_YieldModifiers 	
			(BuildingType, 									YieldType, 		Yield)
VALUES		('BUILDING_MC_GAUL_GOLD', 						'YIELD_GOLD', 	2);
--==========================================================================================================================	
--==========================================================================================================================	