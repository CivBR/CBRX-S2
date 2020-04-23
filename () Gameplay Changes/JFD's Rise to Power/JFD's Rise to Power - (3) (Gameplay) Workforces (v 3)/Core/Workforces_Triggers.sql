--==========================================================================================================================
-- BUILDS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
--JFD_Workforces_Builds
CREATE TRIGGER JFD_Workforces_Unit_Builds_Builds
AFTER INSERT ON Unit_Builds 
WHEN NEW.UnitType = 'UNIT_WORKER'
BEGIN
	UPDATE Builds
	SET Time = null, ChargeCost = 1
	WHERE Type = NEW.BuildType;
END;
--------------------------------------------------------------------------------------------------------------------------
--JFD_Workforces_Builds
CREATE TRIGGER JFD_Workforces_Builds
AFTER INSERT ON Builds 
WHEN NEW.EntityEvent IN ('ENTITY_EVENT_MINE', 'ENTITY_EVENT_IRRIGATE')
BEGIN
	UPDATE Builds
	SET ActionAnimation = 1920
	WHERE EntityEvent = 'ENTITY_EVENT_IRRIGATE';
	
	UPDATE Builds
	SET ActionAnimation = 1940
	WHERE EntityEvent = 'ENTITY_EVENT_MINE';
END;
--==========================================================================================================================
-- UNITS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
--JFD_Workforces_Units
CREATE TRIGGER JFD_Workforces_Units
AFTER INSERT ON Units
WHEN NEW.Class = 'UNITCLASS_WORKER'
BEGIN
	UPDATE Units
	SET Cost = 50, UnitArtInfoEraVariation = 1, ExtraMaintenanceCost = 0, ObsoleteTech = 'TECH_INDUSTRIALIZATION', PrereqTech = 'TECH_AGRICULTURE', WorkRate = 75
	WHERE NEW.Type = 'UNIT_WORKER';
--------------------------------------------------------------------------------------------------------------------------
	INSERT INTO Unit_ClassUpgrades
			(UnitType, 	 UnitClassType)
	VALUES	(NEW.Type,	 'UNITCLASS_JFD_WORKFORCE');
--------------------------------------------------------------------------------------------------------------------------
	INSERT INTO Unit_FreePromotions 	
			(UnitType, 	  PromotionType)
	VALUES	(NEW.Type,	  'PROMOTION_JFD_WORKFORCE_UPGRADE_DISCOUNT');
--------------------------------------------------------------------------------------------------------------------------
	DELETE FROM Unit_Builds 
	WHERE UnitType = NEW.Type AND BuildType = 'BUILD_RAILROAD';
END;
--------------------------------------------------------------------------------------------------------------------------
--JFD_Workforces_Unit_Builds
CREATE TRIGGER JFD_Workforces_Unit_Builds
AFTER INSERT ON Builds 
BEGIN
	INSERT INTO Unit_Builds 
			(UnitType,				BuildType)
	SELECT	'UNIT_JFD_WORKFORCE',	BuildType
	FROM Unit_Builds WHERE BuildType = NEW.Type AND UnitType = 'UNIT_WORKER';
END;
--==========================================================================================================================
--==========================================================================================================================