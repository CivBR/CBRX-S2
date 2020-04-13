--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================	
-- Buildings
------------------------------	
INSERT INTO Buildings 	
		(Type, 								BuildingClass,	FreeStartEra,	Cost,	GoldMaintenance,	PrereqTech,	Description,								Civilopedia,								Help,											Strategy,							ArtDefineTag,	SpecialistType,	SpecialistCount,	MinAreaSize,	ConquestProb,	HurryCostModifier,	Water,	AllowsWaterRoutes, TradeRouteSeaDistanceModifier, TradeRouteSeaGoldBonus, IconAtlas,				PortraitIndex)
SELECT	('BUILDING_SENSHI_BANDARI'),		BuildingClass,	FreeStartEra,	Cost,	GoldMaintenance,	PrereqTech,	('TXT_KEY_BUILDING_SENSHI_BANDARI'),	('TXT_KEY_CIV5_BUILDING_SENSHI_BANDARI_TEXT'),	('TXT_KEY_BUILDING_SENSHI_BANDARI_HELP'),	('TXT_KEY_BUILDING_SENSHI_BANDARI_STRATEGY'),	ArtDefineTag,	SpecialistType,	SpecialistCount,	MinAreaSize,	0,				HurryCostModifier,	Water,	AllowsWaterRoutes, TradeRouteSeaDistanceModifier, TradeRouteSeaGoldBonus,	'SENSHI_ZANZIBAR_ATLAS',	3
FROM Buildings WHERE (Type = 'BUILDING_HARBOR');
------------------------------	
-- Building_Flavors
------------------------------		
INSERT INTO Building_Flavors 	
		(BuildingType, 					FlavorType,			Flavor)
SELECT	('BUILDING_SENSHI_BANDARI'),	FlavorType,			Flavor
FROM Building_Flavors WHERE (BuildingType = 'BUILDING_HARBOR');
------------------------------	
-- Building_YieldChanges
------------------------------		
INSERT INTO Building_YieldChanges 	
		(BuildingType, 					YieldType,		Yield)
SELECT	('BUILDING_SENSHI_BANDARI'),	YieldType,		Yield
FROM Building_YieldChanges WHERE (BuildingType = 'BUILDING_HARBOR');
------------------------------	
-- Building_YieldModifiers
------------------------------		
INSERT INTO Building_YieldModifiers 	
		(BuildingType, 					YieldType,		Yield)
SELECT	('BUILDING_SENSHI_BANDARI'),	YieldType,		Yield
FROM Building_YieldModifiers WHERE (BuildingType = 'BUILDING_HARBOR');