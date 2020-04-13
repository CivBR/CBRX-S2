-- If you're wondering why there's two dummy buildings files basically XML is a pain
--=========================================================================================================================
-- BUILDINGCLASSES
--=========================================================================================================================
-- BuildingClasses
------------------------------
INSERT INTO BuildingClasses 	
		(Type, 						 		DefaultBuilding, 				Description)
VALUES	('BUILDINGCLASS_VANA_VOC', 		'BUILDING_VANA_TRADE_GOLD',	'TXT_KEY_BUILDING_VANA_DVOC');
--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================	
--------------------------------	
-- Buildings_Invisible
--------------------------------
INSERT INTO Buildings
			(Type,						BuildingClass,					GreatPeopleRateModifier,	TradeRouteLandDistanceModifier,			Cost,	FaithCost,	GreatWorkCount,	Description,					ArtDefineTag,				Defense,	NeverCapture,	ConquestProb,	NukeImmune,	HurryCostModifier,	MinAreaSize)
VALUES		('BUILDING_VANA_GM_BUILDING',		'BUILDINGCLASS_VANA_VOC',			0,		0,		-1,		-1,			-1,				'TXT_KEY_BUILDING_VANA_DVOC',	'ART_DEF_BUILDING_CARAVANSARY',	0,			1,				0,				1,			-1,					-1),
			('BUILDING_VANA_TRADE_GOLD',		'BUILDINGCLASS_VANA_VOC',			0,		0,		-1,		-1,			-1,				'TXT_KEY_BUILDING_VANA_DVOC',	'ART_DEF_BUILDING_CARAVANSARY',	0,			1,				0,				1,			-1,					-1);

------------------------------
-- Building_YieldChanges
------------------------------	
INSERT INTO Building_YieldChanges 	
		(BuildingType, 					YieldType,			Yield)
VALUES	('BUILDING_VANA_TRADE_GOLD',	'YIELD_GOLD',		1);
------------------------------	
-- Building_YieldModifiers
------------------------------		
INSERT INTO Building_YieldModifiers 	
		(BuildingType, 				YieldType,		Yield)
VALUES	('BUILDING_VANA_GM_BUILDING',	'YIELD_GOLD',		10);

--==========================================================================================================================
--==========================================================================================================================