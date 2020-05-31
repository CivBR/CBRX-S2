-- Author: Limaeus/Limerickarcher
-- Date: 5/30/2020
------------------------------------------------------------------------------------------------------------------------
-- BuildingClasses
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO BuildingClasses
		(Type, 											DefaultBuilding, 						Description)
VALUES	('BUILDINGCLASS_CBRX_FOUNDER',					'BUILDING_CBRX_FOUNDER',				'TXT_KEY_BUILDING_CBRX_FOUNDER'),
		('BUILDINGCLASS_CBRX_FOLLOWER_ALTARS',			'BUILDING_CBRX_FOLLOWER_ALTARS',		'TXT_KEY_BUILDING_CBRX_FOLLOWER_ALTARS'),
		('BUILDINGCLASS_CBRX_FOLLOWER_TORII_GATES',		'BUILDING_CBRX_FOLLOWER_TORII_GATES',	'TXT_KEY_BUILDING_CBRX_FOLLOWER_TORII_GATES');

------------------------------------------------------------------------------------------------------------------------	
-- Buildings
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Buildings 		
		(Type, 										BuildingClass,								Defense, 	GlobalPlotBuyCostModifier, 	GlobalPlotCultureCostModifier, SpecialistType, 		GreatPeopleRateChange, Cost, FaithCost, PrereqTech, Description,										NeverCapture)
VALUES	('BUILDING_CBRX_FOUNDER_GUARDIAN_SPIRITS',	'BUILDINGCLASS_CBRX_FOUNDER',				100, 		0, 							0, 								null, 				0, 						-1,   -1,		 null,		 'TXT_KEY_BUILDING_CBRX_FOUNDER_GUARDIAN_SPIRITS',	1),
		('BUILDING_CBRX_FOUNDER_CHARITY',			'BUILDINGCLASS_CBRX_FOUNDER',				0, 			-20, 						0, 								null, 				0, 						-1,   -1,		 null,		 'TXT_KEY_BUILDING_CBRX_FOUNDER_CHARITY',			1),
		('BUILDING_CBRX_FOUNDER_ASTRAL_PROTECTION',	'BUILDINGCLASS_CBRX_FOUNDER',				0, 			0, 							-20, 							null, 				0, 						-1,   -1,		 null,		 'TXT_KEY_BUILDING_CBRX_FOUNDER_ASTRAL_PROJECTION',	1),
		('BUILDING_CBRX_FOUNDER_TUTELARY_DEITIES',	'BUILDINGCLASS_CBRX_FOUNDER',				0, 			0, 							0, 								'SPECIALIST_ARTIST',1, 						-1,   -1,		 null,		 'TXT_KEY_BUILDING_CBRX_FOUNDER_TUTELARY_DEITIES',	1),
		('BUILDING_CBRX_FOLLOWER_ALTARS',			'BUILDINGCLASS_CBRX_FOLLOWER_ALTARS',		0, 			0, 							0, 								null,				0, 						-1,   225,		 null,		 'TXT_KEY_BUILDING_CBRX_FOLLOWER_ALTARS',			1),
		('BUILDING_CBRX_FOLLOWER_TORII_GATES',		'BUILDINGCLASS_CBRX_FOLLOWER_TORII_GATES',	0, 			0, 							0, 								null,				0, 						-1,   225,		 null,		 'TXT_KEY_BUILDING_CBRX_FOLLOWER_TORII_GATES',		1);