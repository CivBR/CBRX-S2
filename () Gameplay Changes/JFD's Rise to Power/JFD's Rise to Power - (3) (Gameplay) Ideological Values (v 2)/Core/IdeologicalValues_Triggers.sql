--==========================================================================================================================
-- BUILDINGS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER JFD_IdeologicalValues_Policy_BuildingClassYieldChanges
AFTER INSERT ON BuildingClasses
WHEN NEW.MaxPlayerInstances = 1
BEGIN
	INSERT INTO Policy_BuildingClassYieldChanges
			(PolicyType,					BuildingClassType,  YieldType,		YieldChange)
	VALUES	('POLICY_NATIONAL_HEALTHCARE',	NEW.Type,			'YIELD_FOOD',	2),
			('POLICY_PRIVATE_HEALTHCARE',	NEW.Type,			'YIELD_GOLD',	3);
END; 
--==========================================================================================================================
-- POLICIES
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER JFD_IdeologicalValues_Policy_BuildingClassHappiness
AFTER INSERT ON Policy_BuildingClassHappiness
WHEN NEW.PolicyType IN ('POLICY_UNIVERSAL_HEALTHCARE_A', 'POLICY_UNIVERSAL_HEALTHCARE_F', 'POLICY_UNIVERSAL_HEALTHCARE_O')
BEGIN
	UPDATE Policy_BuildingClassHappiness
	SET PolicyType = 'POLICY_UNIVERSAL_HEALTHCARE'
	WHERE PolicyType = NEW.PolicyType AND PolicyType = 'POLICY_UNIVERSAL_HEALTHCARE_O';

	DELETE FROM Policy_BuildingClassHappiness 
	WHERE PolicyType = NEW.PolicyType AND PolicyType IN ('POLICY_UNIVERSAL_HEALTHCARE_A', 'POLICY_UNIVERSAL_HEALTHCARE_F');
END; 
--==========================================================================================================================
--==========================================================================================================================
