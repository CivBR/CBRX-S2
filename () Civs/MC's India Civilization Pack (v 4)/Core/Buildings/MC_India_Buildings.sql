--=======================================================================================================================
-- BuildingClasses
--=======================================================================================================================
INSERT OR REPLACE INTO BuildingClasses
			(Type, 									DefaultBuilding, 						Description)
VALUES		('BUILDINGCLASS_MC_DUMMY_COURTHOUSE',	'BUILDING_MC_DUMMY_COURTHOUSE',			'TXT_KEY_BUILDING_MC_DUMMY_COURTHOUSE');
--==========================================================================================================================	
-- Buildings
--==========================================================================================================================	
INSERT OR REPLACE INTO Buildings		
			(Type, 								BuildingClass, 							Cost, 	FaithCost,	GreatWorkCount,	GoldMaintenance,	PrereqTech, Help,											Description, 								NoOccupiedUnhappiness,	NeverCapture)
VALUES		('BUILDING_MC_DUMMY_COURTHOUSE',	'BUILDINGCLASS_MC_DUMMY_COURTHOUSE', 	-1, 	-1,			-1,				0, 					null, 		'TXT_KEY_BUILDING_MC_DUMMY_COURTHOUSE_HELP',	'TXT_KEY_BUILDING_MC_DUMMY_COURTHOUSE', 	1,						1);

INSERT OR REPLACE INTO Language_en_US
			(Tag,											Text)
VALUES		('TXT_KEY_BUILDING_MC_DUMMY_COURTHOUSE',		'MC: Dummy Courthouse'),
			('TXT_KEY_BUILDING_MC_DUMMY_COURTHOUSE_HELP',	'Dummy Courthouse effect');