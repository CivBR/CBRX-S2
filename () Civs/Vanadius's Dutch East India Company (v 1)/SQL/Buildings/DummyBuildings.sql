--==========================================================================================================================	
-- BuildingClasses
--==========================================================================================================================	
-- BuildingClasses
--------------------------------	
INSERT INTO BuildingClasses 	
		(Type, 						 DefaultBuilding, 		Description)
VALUES	('BUILDINGCLASS_VANA_TRANSPORT1', 	'BUILDING_VANA_TRANSPORT1', 	'TXT_KEY_BUILDING_VANA_DVOC');
--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================
--------------------------------	
-- Buildings: Invisible
--------------------------------
INSERT INTO Buildings		
		(Type, 							BuildingClass, 			  	Cost, 	FaithCost,	GreatWorkCount,	 Description, 					Help,										NeverCapture)
VALUES	('BUILDING_VANA_TRANSPORT1', 			'BUILDINGCLASS_VANA_TRANSPORT1', 	-1, 	-1,			-1,				 'TXT_KEY_BUILDING_VANA_DVOC', 	'TXT_KEY_BUILDING_VANA_DVOC_HELP',			1);NA_DVOC',			-1, 			-1,   		-1,		null,			1),