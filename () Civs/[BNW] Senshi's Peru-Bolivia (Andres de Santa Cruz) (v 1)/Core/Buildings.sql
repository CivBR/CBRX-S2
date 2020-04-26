--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================	
-- Buildings
------------------------------	
INSERT INTO Buildings 	
		(Type, 								BuildingClass,	FreeStartEra,	Cost,	GoldMaintenance,	PrereqTech,	Description,								Civilopedia,								Help,											Strategy,							ArtDefineTag,	SpecialistType,	SpecialistCount,	MinAreaSize,	ConquestProb,	HurryCostModifier,	Water,	AllowsWaterRoutes,	TradeRouteSeaDistanceModifier,	TradeRouteSeaGoldBonus,	AllowsFoodTradeRoutes,	AllowsProductionTradeRoutes,	TrainedFreePromotion,	CapturePlunderModifier,	IconAtlas,				PortraitIndex)
SELECT	('BUILDING_SENSHI_PUERTOLIBRE'),		BuildingClass,	FreeStartEra,	Cost,	GoldMaintenance,	PrereqTech,	('TXT_KEY_BUILDING_SENSHI_PUERTOLIBRE'),	('TXT_KEY_CIV5_BUILDING_SENSHI_PUERTOLIBRE_TEXT'),	('TXT_KEY_BUILDING_SENSHI_PUERTOLIBRE_HELP'),	('TXT_KEY_BUILDING_SENSHI_PUERTOLIBRE_STRATEGY'),	ArtDefineTag,	SpecialistType,	SpecialistCount,	MinAreaSize,	0,	HurryCostModifier, Water, AllowsWaterRoutes,	TradeRouteSeaDistanceModifier,	TradeRouteSeaGoldBonus,	1,	1,	('PROMOTION_COASTAL_RAIDER_1'),	100,	('SENSHI_PERUBOLIVIA_ATLAS'),	3
FROM Buildings WHERE (Type = 'BUILDING_HARBOR');
------------------------------	
-- Building_Flavors
------------------------------		
INSERT INTO Building_Flavors 	
		(BuildingType, 					FlavorType,			Flavor)
SELECT	('BUILDING_SENSHI_PUERTOLIBRE'),	FlavorType,			Flavor
FROM Building_Flavors WHERE (BuildingType = 'BUILDING_HARBOR');
------------------------------	
-- Building_YieldChanges
------------------------------		
INSERT INTO Building_YieldChanges 	
		(BuildingType, 					YieldType,		Yield)
SELECT	('BUILDING_SENSHI_PUERTOLIBRE'),	YieldType,		Yield
FROM Building_YieldChanges WHERE (BuildingType = 'BUILDING_HARBOR');
------------------------------	
-- Building_YieldModifiers
------------------------------		
INSERT INTO Building_YieldModifiers 	
		(BuildingType, 					YieldType,		Yield)
SELECT	('BUILDING_SENSHI_PUERTOLIBRE'),	YieldType,		Yield
FROM Building_YieldModifiers WHERE (BuildingType = 'BUILDING_HARBOR');