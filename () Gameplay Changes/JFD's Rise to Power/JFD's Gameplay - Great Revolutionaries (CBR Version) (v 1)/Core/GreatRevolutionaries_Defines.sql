--=======================================================================================================================
-- GAME DEFINES
--=======================================================================================================================
-- BuildingClasses
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO BuildingClasses
		(Type, 										 DefaultBuilding, 						 Description)
VALUES	('BUILDINGCLASS_JFD_GREAT_REVOLUTIONARIES',  'BUILDING_JFD_GREAT_REVOLUTIONARIES',   'TXT_KEY_BUILDING_JFD_GREAT_REVOLUTIONARIES');
------------------------------------------------------------------------------------------------------------------------	
-- Buildings
------------------------------------------------------------------------------------------------------------------------
INSERT INTO Buildings 		
		(Type, 									BuildingClass,								XBuiltTriggersIdeologyChoice,	GreatWorkCount,	Cost, FaithCost, PrereqTech, Description,									Help, 												 NeverCapture)
VALUES	('BUILDING_JFD_GREAT_REVOLUTIONARIES',	'BUILDINGCLASS_JFD_GREAT_REVOLUTIONARIES',	1,								-1,				-1,   -1,		 null,		 'TXT_KEY_BUILDING_JFD_GREAT_REVOLUTIONARIES',	'TXT_KEY_BUILDING_JFD_GREAT_REVOLUTIONARIES_HELP',	 1);

UPDATE Buildings
SET XBuiltTriggersIdeologyChoice = 0
WHERE BuildingClass IN ('BUILDINGCLASS_FACTORY');

--JFD_GreatRevolutionaries_Buildings
CREATE TRIGGER JFD_GreatRevolutionaries_Buildings
AFTER INSERT ON Buildings
WHEN NEW.BuildingClass = 'BUILDINGCLASS_FACTORY'
BEGIN
	UPDATE Buildings
	SET XBuiltTriggersIdeologyChoice = 0
	WHERE NEW.BuildingClass IN ('BUILDINGCLASS_FACTORY');
END;
------------------------------------------------------------------------------------------------------------------------	
-- POSTDEFINES
------------------------------------------------------------------------------------------------------------------------
UPDATE PostDefines
SET Key = 'ERA_FUTURE'
WHERE Name = 'IDEOLOGY_START_ERA';
--=======================================================================================================================
--=======================================================================================================================
