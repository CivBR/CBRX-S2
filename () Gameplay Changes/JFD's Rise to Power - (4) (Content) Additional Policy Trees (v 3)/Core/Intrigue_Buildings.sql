--==========================================================================================================================
-- BUILDINGS
--==========================================================================================================================
------------------------------------------------------------------------------------------------------------------------
-- BuildingClasses
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO BuildingClasses 
		(Type,						DefaultBuilding,		Description,					MaxPlayerInstances,		MaxGlobalInstances)
VALUES	('BUILDINGCLASS_JFD_JAIL',	'BUILDING_JFD_JAIL',	'TXT_KEY_BUILDING_JFD_JAIL',	-1,						-1);
--------------------------------------------------------------------------------------------------------------------------
-- Buildings
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Buildings
		(Type, 					Cost, 	FaithCost, 	GoldMaintenance,	Espionage,	EspionageModifier,	PrereqTech,				BuildingClass, 				Description, 					Help,								Strategy,								Civilopedia,						MinAreaSize,	HurryCostModifier,	NumCityCostMod,	ConquestProb,	NukeImmune, NeverCapture,	IconAtlas,						PortraitIndex)
VALUES	('BUILDING_JFD_JAIL',	60,		-1,			0,					0,			0,					'TECH_MATHEMATICS',		'BUILDINGCLASS_JFD_JAIL',	'TXT_KEY_BUILDING_JFD_JAIL',	'TXT_KEY_BUILDING_JFD_JAIL_HELP',	'TXT_KEY_BUILDING_JFD_JAIL_STRATEGY',	'TXT_KEY_BUILDING_JFD_JAIL_TEXT',	-1,				25,					0,				30,				0,			0,				'JFD_INTRIGUE_BUILDING_ATLAS',	0);

UPDATE Buildings
SET PrereqTech = 'TECH_JFD_CODE_OF_LAWS'
WHERE BuildingClass = 'BUILDINGCLASS_JFD_JAIL'
AND EXISTS (SELECT Type FROM Technologies WHERE Type = 'TECH_JFD_CODE_OF_LAWS');
------------------------------------------------------------------------------------------------------------------------
-- Building_ClassesNeededInCity
------------------------------------------------------------------------------------------------------------------------
INSERT INTO Building_ClassesNeededInCity
		(BuildingType, 	BuildingClassType)
SELECT	Type,			'BUILDINGCLASS_JFD_JAIL'
FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_CONSTABLE';
------------------------------------------------------------------------------------------------------------------------
-- Building_Flavors
------------------------------------------------------------------------------------------------------------------------
INSERT INTO Building_Flavors 
		(BuildingType, 						FlavorType,						Flavor)
VALUES	('BUILDING_JFD_JAIL',				'FLAVOR_ESPIONAGE',				15);
--==========================================================================================================================
--==========================================================================================================================