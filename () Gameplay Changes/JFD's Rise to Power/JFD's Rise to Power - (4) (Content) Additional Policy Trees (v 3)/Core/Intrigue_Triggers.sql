--==========================================================================================================================		
-- BUILDINGS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
--JFD_Intrigue_Buildings
CREATE TRIGGER JFD_Intrigue_Buildings
AFTER INSERT ON Buildings
WHEN NEW.BuildingClass IN ('BUILDINGCLASS_CONSTABLE')
BEGIN
	INSERT INTO Building_ClassesNeededInCity
			(BuildingType, 		BuildingClassType)
	SELECT	NEW.Type,			'BUILDINGCLASS_JFD_JAIL'
	FROM Buildings WHERE Type = NEW.Type AND NEW.BuildingClass = 'BUILDINGCLASS_CONSTABLE';
END;
--==========================================================================================================================		
-- TECHS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
--JFD_Intrigue_Technologies
CREATE TRIGGER JFD_Intrigue_Technologies
AFTER INSERT ON Technologies
WHEN NEW.Type = 'TECH_JFD_CODE_OF_LAWS'
BEGIN
	UPDATE Buildings
	SET PrereqTech = 'TECH_JFD_CODE_OF_LAWS'
	WHERE BuildingClass = 'BUILDINGCLASS_JFD_JAIL'
	AND EXISTS (SELECT Type FROM Technologies WHERE Type = 'TECH_JFD_CODE_OF_LAWS');
END;
--==========================================================================================================================
--==========================================================================================================================