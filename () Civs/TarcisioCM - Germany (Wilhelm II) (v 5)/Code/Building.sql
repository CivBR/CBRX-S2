--==========================================================================================================================	
-- BuildingClasses
--==========================================================================================================================	
INSERT INTO BuildingClasses 	
			(Type, 						 				DefaultBuilding, 					Description)
VALUES		('BUILDINGCLASS_TCM_GERMAN_PRODUCTION', 	'BUILDING_TCM_GERMAN_PRODUCTION', 	'TXT_KEY_TRAIT_GE_GERMANY_SHORT');
--==========================================================================================================================	
-- Buildings
--==========================================================================================================================			
INSERT INTO Buildings 	
			(Type, 								BuildingClass,							SpecialistCount,	GreatWorkCount, Cost,		 FaithCost,		  NukeImmune,	  ConquestProb,  PrereqTech,	Description, 						Help,								PortraitIndex, 	IconAtlas)
VALUES		('BUILDING_TCM_GERMAN_PRODUCTION',	'BUILDINGCLASS_TCM_GERMAN_PRODUCTION', 	-1,					-1, 			-1,			 -1, 			  1,			  0,			NULL, 			'TXT_KEY_TRAIT_GE_GERMANY_SHORT', 	'TXT_KEY_TRAIT_GE_GERMANY_SHORT',	0, 				'MAIN_ICON_GE_GERMAN_ATLAS');
--==========================================================================================================================
-- Building_YieldChanges
--==========================================================================================================================
INSERT INTO Building_YieldChanges
			(BuildingType,						YieldType,			Yield)
VALUES		('BUILDING_TCM_GERMAN_PRODUCTION',	'YIELD_PRODUCTION',	1);
--==========================================================================================================================
-- Building_YieldModifiers
--==========================================================================================================================
INSERT INTO Building_YieldModifiers
			(BuildingType,						YieldType,			Yield)
VALUES		('BUILDING_TCM_GERMAN_PRODUCTION',	'YIELD_PRODUCTION',	5);
