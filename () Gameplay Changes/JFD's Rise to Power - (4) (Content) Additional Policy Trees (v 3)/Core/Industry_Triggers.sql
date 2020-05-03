--==========================================================================================================================		
-- BUILDINGS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
--JFD_Industry_Building_ResourceQuantityRequirements
CREATE TRIGGER JFD_Industry_Building_ResourceQuantityRequirements
AFTER INSERT ON Building_ResourceQuantityRequirements
BEGIN
	INSERT INTO Policy_BuildingClassProductionModifiers
			(PolicyType,			BuildingClassType,	ProductionModifier)
	SELECT	'POLICY_JFD_INDUSTRY',	Type,				10
	FROM BuildingClasses WHERE DefaultBuilding = NEW.BuildingType AND DefaultBuilding IN (SELECT BuildingType FROM Building_ResourceQuantityRequirements WHERE Cost > 0);
END;
--==========================================================================================================================		
-- ERAS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
--JFD_Industry_Eras
CREATE TRIGGER JFD_Industry_Eras
AFTER INSERT ON Eras
WHEN NEW.Type IN ('ERA_ENLIGHTENMENT') 
BEGIN
	UPDATE PolicyBranchTypes
	SET EraPrereq = 'ERA_ENLIGHTENMENT'
	WHERE Type = 'POLICY_BRANCH_JFD_INDUSTRY';
END;
--==========================================================================================================================		
-- RESOURCES
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
--JFD_Industry_Resources
CREATE TRIGGER JFD_Industry_Resources
AFTER INSERT ON Resources
WHEN NEW.ResourceClassType IN ('RESOURCECLASS_MODERN', 'RESOURCECLASS_RUSH')
BEGIN
	INSERT INTO Policy_ResourceYieldChanges
			(PolicyType,						ResourceType,	YieldType,		Yield)
	SELECT	'POLICY_JFD_RESOURCE_MANAGEMENT',	NEW.Type,		'YIELD_GOLD',	1;

	INSERT INTO Building_ResourceYieldChanges 
			(BuildingType, 								ResourceType,	YieldType,		Yield)
	SELECT	'BUILDING_JFD_RESOURCE_MANAGEMENT_GOLD',	NEW.Type,		'YIELD_GOLD',   1
	WHERE NOT EXISTS (SELECT Name FROM CustomModOptions WHERE Name = 'API_UNIFIED_YIELDS' AND Value = 1);
END;
--==========================================================================================================================		
-- UNITS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
--JFD_Industry_Unit_ResourceQuantityRequirements
CREATE TRIGGER JFD_Industry_Unit_ResourceQuantityRequirements
AFTER INSERT ON Unit_ResourceQuantityRequirements
BEGIN
	INSERT INTO Policy_UnitClassProductionModifiers
			(PolicyType,			UnitClassType,		ProductionModifier)
	SELECT	'POLICY_JFD_INDUSTRY',	Type,				10
	FROM UnitClasses WHERE DefaultUnit = NEW.UnitType AND DefaultUnit IN (SELECT UnitType FROM Unit_ResourceQuantityRequirements WHERE Cost > 0);
END;
--==========================================================================================================================
--==========================================================================================================================