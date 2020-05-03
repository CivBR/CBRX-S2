--==========================================================================================================================		
-- IDEOLOGICAL TENETS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
--JFD_Neutrality_Policy_BuildingClassHappiness
CREATE TRIGGER JFD_Neutrality_Policy_BuildingClassHappiness
AFTER INSERT ON Policy_BuildingClassHappiness
WHEN NEW.PolicyType IN ('POLICY_JFD_UNIVERSAL_HEALTHCARE_F')
BEGIN
	INSERT INTO Policy_BuildingClassHappiness
			(PolicyType,							BuildingClassType,		Happiness)
	VALUES	('POLICY_JFD_UNIVERSAL_HEALTHCARE_N',	NEW.BuildingClassType,	NEW.Happiness);
END;
--==========================================================================================================================
--==========================================================================================================================