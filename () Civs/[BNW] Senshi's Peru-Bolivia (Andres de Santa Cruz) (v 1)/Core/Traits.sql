--==========================================================================================================================	
-- Traits
--==========================================================================================================================	
INSERT INTO Traits 
			(Type, 						Description, 						ShortDescription)					
VALUES		('TRAIT_SENSHI_PERUBOLIVIA', 	'TXT_KEY_TRAIT_SENSHI_PERUBOLIVIA', 	'TXT_KEY_TRAIT_SENSHI_PERUBOLIVIA_SHORT');

INSERT INTO BuildingClasses 	
		(Type, 						 		DefaultBuilding, 				Description)
VALUES	('BUILDINGCLASS_SENSHI_PERUBOLIVIA', 		'BUILDING_SENSHI_PB_UNHAPPINESS_FIX',	'TXT_KEY_TRAIT_SENSHI_PERUBOLIVIA_SHORT');

INSERT INTO Buildings 		
		(Type, 						 			BuildingClass, 					SpecialistCount, SpecialistType,		NoOccupiedUnhappiness,	NumTradeRouteBonus, PrereqTech, Cost, FaithCost, GreatWorkCount,	GoldMaintenance, MinAreaSize,	NeverCapture,	Description, 									Help, 												Strategy,										Civilopedia, 							ArtDefineTag, PortraitIndex, IconAtlas)
VALUES	('BUILDING_SENSHI_PB_UNHAPPINESS_FIX', 			'BUILDINGCLASS_SENSHI_PERUBOLIVIA',	0,				 null,		1,			0,						null,		 -1,   -1,		  -1,				0,				 0,				1,				'TXT_KEY_TRAIT_SENSHI_GUEGUENSE_SHORT',			'TXT_KEY_TRAIT_SENSHI_GUEGUENSE',			null,											null,									null,		  0, 			 'SENSHI_PERUBOLIVIA_ATLAS'),
		('BUILDING_SENSHI_PB_EXTRA_ROUTE', 			'BUILDINGCLASS_SENSHI_PERUBOLIVIA',	0,				 null,			0,		1,						null,		 -1,   -1,		  -1,				0,				 0,				1,				'TXT_KEY_TRAIT_SENSHI_GUEGUENSE_SHORT',			'TXT_KEY_TRAIT_SENSHI_GUEGUENSE',			null,											null,									null,		  0, 			 'SENSHI_PERUBOLIVIA_ATLAS');