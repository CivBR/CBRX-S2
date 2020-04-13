--==========================================================================================================================
-- IMPROVEMENTS
--==========================================================================================================================
-- Builds
------------------------------------------------------------------------------------------------------------------------	
--Fishing Boats
UPDATE Builds
SET Kill = 0, ChargeCost = 1
WHERE Type = 'BUILD_FISHING_BOATS';

--Builder Charges
UPDATE Builds
SET Time = null, ChargeCost = 1
WHERE Type IN (SELECT BuildType FROM Unit_Builds WHERE UnitType = 'UNIT_WORKER' AND BuildType NOT IN ('BUILD_ROAD', 'BUILD_RAILROAD', 'BUILD_REMOVE_ROUTE', 'BUILD_REPAIR', 'BUILD_ARCHAEOLOGY_DIG', 'BUILD_LANDMARK'));

UPDATE Builds
SET Time = null, ChargeCost = 1
WHERE Type IN (SELECT BuildType FROM Unit_Builds WHERE UnitType = 'UNIT_WORKER' AND BuildType NOT IN ('BUILD_ROAD', 'BUILD_RAILROAD', 'BUILD_REMOVE_ROUTE', 'BUILD_REPAIR', 'BUILD_REMOVE_JUNGLE', 'BUILD_REMOVE_FOREST', 'BUILD_REMOVE_MARSH', 'BUILD_SCRUB_FALLOUT', 'BUILD_ARCHAEOLOGY_DIG', 'BUILD_LANDMARK'));

--JFD_Builders_Builds
CREATE TRIGGER JFD_Builders_Unit_Builds_Builds
AFTER INSERT ON Unit_Builds 
WHEN NEW.UnitType = 'UNIT_WORKER'
BEGIN
	UPDATE Builds
	SET Time = null, ChargeCost = 1
	WHERE Type = NEW.BuildType;
END;

UPDATE Builds
SET ActionAnimation = 1920
WHERE EntityEvent = 'ENTITY_EVENT_IRRIGATE';

UPDATE Builds
SET ActionAnimation = 1940
WHERE EntityEvent = 'ENTITY_EVENT_MINE';

--JFD_Builders_Builds
CREATE TRIGGER JFD_Builders_Builds
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
------------------------------------------------------------------------------------------------------------------------
-- Build_JFD_ChargeExcludes
------------------------------------------------------------------------------------------------------------------------
INSERT INTO Build_JFD_ChargeExcludes
		(BuildType)
SELECT	Type
FROM Builds WHERE Type IN ('BUILD_ROAD', 'BUILD_REPAIR', 'BUILD_REMOVE_ROUTE', 'BUILD_RAILROAD');

INSERT INTO Build_JFD_ChargeExcludes
		(BuildType)
SELECT	Type
FROM Builds WHERE Type IN ('BUILD_REMOVE_JUNGLE', 'BUILD_REMOVE_FOREST', 'BUILD_REMOVE_MARSH', 'BUILD_SCRUB_FALLOUT');
--==========================================================================================================================
--==========================================================================================================================