--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================
-- Buildings: Invisible
------------------------------	
INSERT INTO Buildings
			(Type, 								BuildingClass, 								Description,									GreatWorkCount,	Cost,	FaithCost,	PrereqTech, 	NeverCapture)
VALUES		('BUILDING_MC_MHA_UA_1', 			'BUILDINGCLASS_MC_MHA_UA_1',				'TXT_KEY_BUILDING_MC_MHA_UA_1',					-1, 			-1,   		-1,		null,			1),
			('BUILDING_MC_MHA_UA_2', 			'BUILDINGCLASS_MC_MHA_UA_2',				'TXT_KEY_BUILDING_MC_MHA_UA_2',					-1, 			-1,   		-1,		null,			1),
			('BUILDING_MC_MHA_UA_3', 			'BUILDINGCLASS_MC_MHA_UA_3',				'TXT_KEY_BUILDING_MC_MHA_UA_3',					-1, 			-1,   		-1,		null,			1),
			('BUILDING_MC_MHA_UA_4', 			'BUILDINGCLASS_MC_MHA_UA_4',				'TXT_KEY_BUILDING_MC_MHA_UA_4',					-1, 			-1,   		-1,		null,			1),
			('BUILDING_MC_MHA_UA_5', 			'BUILDINGCLASS_MC_MHA_UA_5',				'TXT_KEY_BUILDING_MC_MHA_UA_5',					-1, 			-1,   		-1,		null,			1),
			('BUILDING_MC_MHA_UA_6', 			'BUILDINGCLASS_MC_MHA_UA_6',				'TXT_KEY_BUILDING_MC_MHA_UA_6',					-1, 			-1,   		-1,		null,			1),
			('BUILDING_MC_MHA_UA_7', 			'BUILDINGCLASS_MC_MHA_UA_7',				'TXT_KEY_BUILDING_MC_MHA_UA_7',					-1, 			-1,   		-1,		null,			1),
			('BUILDING_MC_MHA_UA_8', 			'BUILDINGCLASS_MC_MHA_UA_8',				'TXT_KEY_BUILDING_MC_MHA_UA_8',					-1, 			-1,   		-1,		null,			1),
			('BUILDING_MC_MHA_UA_9', 			'BUILDINGCLASS_MC_MHA_UA_9',				'TXT_KEY_BUILDING_MC_MHA_UA_9',					-1, 			-1,   		-1,		null,			1),
			('BUILDING_MC_MHA_UA_10', 			'BUILDINGCLASS_MC_MHA_UA_10',				'TXT_KEY_BUILDING_MC_MHA_UA_10',				-1, 			-1,   		-1,		null,			1),
			('BUILDING_MC_EARTHLODGE_EFFECT', 	'BUILDINGCLASS_MC_EARTHLODGE_EFFECT',		'TXT_KEY_BUILDING_MC_EARTHLODGE_EFFECT',		-1, 			-1,   		-1,		null,			1);

INSERT INTO BuildingClasses 
			(Type, 			DefaultBuilding,	Description)
SELECT 		BuildingClass,	Type,				Description
FROM Buildings WHERE (Type IN ('BUILDING_MC_MHA_UA_1', 'BUILDING_MC_MHA_UA_2', 'BUILDING_MC_MHA_UA_3', 'BUILDING_MC_MHA_UA_4', 'BUILDING_MC_MHA_UA_5', 'BUILDING_MC_MHA_UA_6', 'BUILDING_MC_MHA_UA_7', 'BUILDING_MC_MHA_UA_8', 'BUILDING_MC_MHA_UA_9', 'BUILDING_MC_MHA_UA_10', 'BUILDING_MC_EARTHLODGE_EFFECT'));

UPDATE Buildings
SET	TradeRouteLandGoldBonus = 100,
	TradeRouteSeaGoldBonus	= 100,
	TradeRouteLandDistanceModifier	= 10,
	TradeRouteSeaDistanceModifier	= 10
WHERE Type IN ('BUILDING_MC_MHA_UA_1', 'BUILDING_MC_MHA_UA_2', 'BUILDING_MC_MHA_UA_3', 'BUILDING_MC_MHA_UA_4', 'BUILDING_MC_MHA_UA_5', 'BUILDING_MC_MHA_UA_6', 'BUILDING_MC_MHA_UA_7', 'BUILDING_MC_MHA_UA_8', 'BUILDING_MC_MHA_UA_9', 'BUILDING_MC_MHA_UA_10');

UPDATE Buildings
SET	FoodKept = 5
WHERE Type = 'BUILDING_MC_EARTHLODGE_EFFECT';
------------------------------
-- Buildings
------------------------------	
INSERT INTO Buildings 	
			(Type, 						BuildingClass, Cost, GoldMaintenance, 	PrereqTech, Description, 						Civilopedia, 							Help, 										Strategy,										ArtDefineTag, River,	MinAreaSize, ConquestProb, HurryCostModifier, PortraitIndex, 	IconAtlas)
SELECT		('BUILDING_MC_EARTHLODGE'),	BuildingClass, Cost, GoldMaintenance,	PrereqTech, ('TXT_KEY_BUILDING_MC_EARTHLODGE'),	('TXT_KEY_CIV5_MC_EARTHLODGE_TEXT'), 	('TXT_KEY_BUILDING_MC_EARTHLODGE_HELP'), 	('TXT_KEY_BUILDING_MC_EARTHLODGE_STRATEGY'),	ArtDefineTag, River,	MinAreaSize, ConquestProb, HurryCostModifier, 2, 				('MC_MHA_ATLAS')
FROM Buildings WHERE (Type = 'BUILDING_WATERMILL');
------------------------------------------------------------------------------------------------------------------------
-- Building_YieldChanges
------------------------------------------------------------------------------------------------------------------------
INSERT INTO Building_YieldChanges 
		(BuildingType, 						YieldType,			Yield)
SELECT	'BUILDING_MC_EARTHLODGE', 			YieldType,			Yield + 1
FROM Building_YieldChanges WHERE (BuildingType = 'BUILDING_WATERMILL');
------------------------------	
-- Building_Flavors
------------------------------		
INSERT INTO Building_Flavors 	
			(BuildingType, 			FlavorType, Flavor)
SELECT		('BUILDING_MC_EARTHLODGE'),	FlavorType, Flavor
FROM Building_Flavors WHERE (BuildingType = 'BUILDING_WATERMILL');
--==========================================================================================================================
--==========================================================================================================================