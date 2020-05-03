--==========================================================================================================================		
-- BUILDINGS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
--JFD_Conservation_BuildingClasses
CREATE TRIGGER JFD_Conservation_BuildingClasses
AFTER INSERT ON BuildingClasses
WHEN NEW.Type IN ('BUILDINGCLASS_JFD_WIND_FARM') OR NEW.MaxGlobalInstances = 1 OR NEW.MaxPlayerInstances = 1
BEGIN
	INSERT INTO Policy_BuildingClassProductionModifiers
			(PolicyType,					BuildingClassType,	YieldType,		YieldMod)
	SELECT	'POLICY_JFD_GREEN_ENERGY',		NEW.Type,			'YIELD_FOOD'	5
	WHERE NEW.Type = 'BUILDINGCLASS_JFD_WIND_FARM';
	
	INSERT INTO Policy_BuildingClassProductionModifiers
			(PolicyType,					BuildingClassType,	ProductionModifier)
	SELECT	'POLICY_JFD_GREEN_ENERGY',		NEW.Type,			10
	WHERE NEW.Type = 'BUILDINGCLASS_JFD_WIND_FARM';

	INSERT INTO Policy_BuildingClassCultureChanges
			(PolicyType,					BuildingClassType,	CultureChange)
	SELECT	'POLICY_JFD_NATIONAL_TRUST',	NEW.Type,			1
	WHERE NEW.MaxGlobalInstances = 1 OR NEW.MaxPlayerInstances = 1;
	
	INSERT INTO Policy_BuildingClassYieldChanges
			(PolicyType,					BuildingClassType,	YieldType,		  YieldChange)
	SELECT	'POLICY_JFD_NATIONAL_TRUST',	NEW.Type,			'YIELD_TOURISM',  1
	WHERE (NEW.MaxGlobalInstances = 1 OR NEW.MaxPlayerInstances = 1)
	AND EXISTS (SELECT Type FROM Yields WHERE Type = 'YIELD_TOURISM');
END;
--==========================================================================================================================		
-- ERAS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
--JFD_Conservation_Eras
CREATE TRIGGER JFD_Conservation_Eras
AFTER INSERT ON Eras
WHEN NEW.Type IN ('ERA_ENLIGHTENMENT') 
BEGIN
	UPDATE PolicyBranchTypes
	SET EraPrereq = 'ERA_ENLIGHTENMENT'
	WHERE Type = 'POLICY_BRANCH_JFD_CONSERVATION';
END;
--==========================================================================================================================		
-- YIELDS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
--JFD_Conservation_Yields
CREATE TRIGGER JFD_Conservation_Yields
AFTER INSERT ON Yields
WHEN NEW.Type IN ('YIELD_TOURISM') 
BEGIN
	UPDATE Policies
	SET Help = 'TXT_KEY_POLICY_JFD_NATIONAL_TRUST_HELP_CP'
	WHERE Type = 'POLICY_JFD_NATIONAL_TRUST';
END;
--==========================================================================================================================
--==========================================================================================================================