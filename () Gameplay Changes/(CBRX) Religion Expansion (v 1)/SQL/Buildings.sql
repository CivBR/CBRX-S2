-- Author: Limaeus/Limerickarcher
-- Date: 5/30/2020
------------------------------------------------------------------------------------------------------------------------
-- BuildingClasses
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO BuildingClasses
		(Type, 											DefaultBuilding, 						Description)
VALUES	('BUILDINGCLASS_CBRX_FOUNDER',					'BUILDING_CBRX_FOUNDER',				'TXT_KEY_BUILDING_CLASS_CBRX_FOUNDER'),
		('BUILDINGCLASS_CBRX_FOLLOWER_ALTARS',			'BUILDING_CBRX_FOLLOWER_ALTARS',		'TXT_KEY_BUILDING_CLASS_CBRX_FOLLOWER_ALTARS'),
		('BUILDINGCLASS_CBRX_PANTHEON_AXIS_MUNDI',		'BUILDING_CBRX_PANTHEON_AXIS_MUNDI',	'TXT_KEY_BUILDING_CLASS_CBRX_PANTHEON_AXIS_MUNDI'),
		('BUILDINGCLASS_CBRX_FOLLOWER_TORII_GATES',		'BUILDING_CBRX_FOLLOWER_TORII_GATES',	'TXT_KEY_BUILDING_CLASS_CBRX_FOLLOWER_TORII_GATES');

------------------------------------------------------------------------------------------------------------------------	
-- Buildings
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Buildings 		
		(Type, 										BuildingClass,								Defense, 	GlobalPlotBuyCostModifier, 	GlobalPlotCultureCostModifier, SpecialistType, 		GreatPeopleRateChange, 	UnlockedByBelief, 	Cost, FaithCost, PrereqTech, Description, 										Help,													NeverCapture)
VALUES	('BUILDING_CBRX_FOUNDER_GUARDIAN_SPIRITS',	'BUILDINGCLASS_CBRX_FOUNDER',				100, 		0, 							0, 								null, 				0, 						0, 					-1,   -1,		 null,		'TXT_KEY_BUILDING_CBRX_FOUNDER_GUARDIAN_SPIRITS', 	'TXT_KEY_BUILDING_CBRX_FOUNDER_GUARDIAN_SPIRITS_HELP',	1),
		('BUILDING_CBRX_FOUNDER_CHARITY',			'BUILDINGCLASS_CBRX_FOUNDER',				0, 			-20, 						0, 								null, 				0, 						0,					-1,   -1,		 null,		'TXT_KEY_BUILDING_CBRX_FOUNDER_CHARITY', 			'TXT_KEY_BUILDING_CBRX_FOUNDER_CHARITY_HELP',			1),
		('BUILDING_CBRX_FOUNDER_ASTRAL_PROJECTION',	'BUILDINGCLASS_CBRX_FOUNDER',				0, 			0, 							-20, 							null, 				0, 						0,					-1,   -1,		 null,		'TXT_KEY_BUILDING_CBRX_FOUNDER_ASTRAL_PROJECTION',	'TXT_KEY_BUILDING_CBRX_FOUNDER_ASTRAL_PROJECTION_HELP',	1),
		('BUILDING_CBRX_FOUNDER_TUTELARY_DEITIES',	'BUILDINGCLASS_CBRX_FOUNDER',				0, 			0, 							0, 								'SPECIALIST_ARTIST',1, 						0,					-1,   -1,		 null,		'TXT_KEY_BUILDING_CBRX_FOUNDER_TUTELARY_DEITIES',	'TXT_KEY_BUILDING_CBRX_FOUNDER_TUTELARY_DEITIES_HELP',	1),
		('BUILDING_CBRX_FOLLOWER_ALTARS',			'BUILDINGCLASS_CBRX_FOLLOWER_ALTARS',		0, 			0, 							0, 								null,				0, 						1,					-1,   225,		 null,		'TXT_KEY_BUILDING_CBRX_FOLLOWER_ALTARS',			'TXT_KEY_BUILDING_CBRX_FOLLOWER_ALTARS_HELP',			1),
		('BUILDING_CBRX_FOLLOWER_TORII_GATES',		'BUILDINGCLASS_CBRX_FOLLOWER_TORII_GATES',	0, 			0, 							0, 								null,				0, 						1,					-1,   225,		 null,		'TXT_KEY_BUILDING_CBRX_FOLLOWER_TORII_GATES',		'TXT_KEY_BUILDING_CBRX_FOLLOWER_TORII_GATES_HELP',		1);