--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- Buildings
--------------------------------------------------------------------------------------------------------------------------
UPDATE Buildings
SET IsNationalWonder = 1
WHERE Type IN (SELECT DefaultBuilding FROM BuildingClasses WHERE MaxPlayerInstances = 1);

UPDATE Buildings
SET IsWorldWonder = 1
WHERE Type IN (SELECT DefaultBuilding FROM BuildingClasses WHERE MaxGlobalInstances = 1);

--JFD_RTP_Buildings
CREATE TRIGGER JFD_RTP_Buildings
AFTER INSERT ON Buildings
WHEN NEW.Type IN (SELECT DefaultBuilding FROM BuildingClasses WHERE MaxPlayerInstances = 1) OR NEW.Type IN (SELECT DefaultBuilding FROM BuildingClasses WHERE MaxGlobalInstances = 1)
BEGIN
	UPDATE Buildings
	SET IsNationalWonder = 1
	WHERE Type = NEW.Type AND Type IN (SELECT DefaultBuilding FROM BuildingClasses WHERE MaxPlayerInstances = 1);
	
	UPDATE Buildings
	SET IsWorldWonder = 1
	WHERE Type = NEW.Type AND Type IN (SELECT DefaultBuilding FROM BuildingClasses WHERE MaxGlobalInstances = 1);
END;
--==========================================================================================================================
--==========================================================================================================================