--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================	
-- Buildings
------------------------------	
INSERT INTO Buildings 	
		(Type, 								BuildingClass,	FreeStartEra,	Cost,	GoldMaintenance,	PrereqTech,	Description,								Civilopedia,								Help,											Strategy,							ArtDefineTag,	SpecialistType,	SpecialistCount,	MinAreaSize,	ConquestProb,	HurryCostModifier,	AllowsProductionTradeRoutes,	IconAtlas,				PortraitIndex)
SELECT	('BUILDING_SENSHI_YARANGA'),		BuildingClass,	FreeStartEra,	Cost,	GoldMaintenance,	PrereqTech,	('TXT_KEY_BUILDING_SENSHI_YARANGA'),	('TXT_KEY_CIV5_BUILDING_SENSHI_YARANGA_TEXT'),	('TXT_KEY_BUILDING_SENSHI_YARANGA_HELP'),	('TXT_KEY_BUILDING_SENSHI_YARANGA_STRATEGY'),	ArtDefineTag,	SpecialistType,	SpecialistCount,	MinAreaSize,	0,				HurryCostModifier,	AllowsProductionTradeRoutes,	'SENSHI_CHUKCHI_ATLAS',	3
FROM Buildings WHERE (Type = 'BUILDING_BARRACKS');
------------------------------	
-- Building_Flavors
------------------------------		
INSERT INTO Building_Flavors 	
		(BuildingType, 					FlavorType,			Flavor)
SELECT	('BUILDING_SENSHI_YARANGA'),	FlavorType,			Flavor
FROM Building_Flavors WHERE (BuildingType = 'BUILDING_BARRACKS');
------------------------------	
-- Building_DomainFreeExperiences
------------------------------		
INSERT INTO Building_DomainFreeExperiences 	
		(BuildingType, 					DomainType,		Experience)
SELECT	('BUILDING_SENSHI_YARANGA'),	DomainType,		Experience
FROM Building_DomainFreeExperiences WHERE (BuildingType = 'BUILDING_BARRACKS');

INSERT INTO BuildingClasses 	
		(Type, 						 		DefaultBuilding, 				Description)
VALUES	('BUILDINGCLASS_SENSHI_CHUKCHI', 		'BUILDING_SENSHI_YARANGA_XP',	'TXT_KEY_TRAIT_SENSHI_GUEGUENSE_SHORT');

INSERT INTO Buildings 		
		(Type, 						 			BuildingClass, 					SpecialistCount, SpecialistType,		PrereqTech, Cost, FaithCost, GreatWorkCount,	GoldMaintenance, MinAreaSize,	NeverCapture,	Description, 									Help, 												Strategy,										Civilopedia, 							ArtDefineTag, PortraitIndex, IconAtlas)
VALUES	('BUILDING_SENSHI_YARANGA_XP', 			'BUILDINGCLASS_SENSHI_CHUKCHI',	0,				 null,					null,		 -1,   -1,		  -1,				0,				 0,				1,				'TXT_KEY_TRAIT_SENSHI_GUEGUENSE_SHORT',			'TXT_KEY_TRAIT_SENSHI_GUEGUENSE',			null,											null,									null,		  0, 			 'SENSHI_CHUKCHI_ATLAS');

INSERT INTO Building_DomainFreeExperiences 	
		(BuildingType, 						 	DomainType, 	Experience)
VALUES	('BUILDING_SENSHI_YARANGA_XP', 		'DOMAIN_LAND',	1),
		('BUILDING_SENSHI_YARANGA_XP', 		'DOMAIN_SEA',	1),
		('BUILDING_SENSHI_YARANGA_XP', 		'DOMAIN_AIR',	1);