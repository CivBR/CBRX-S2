--==========================================================================================================================		
-- POLICIES
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- Policies
--------------------------------------------------------------------------------------------------------------------------
UPDATE Policies
SET Type = 'POLICY_NATIONAL_HEALTHCARE', Description = 'TXT_KEY_POLICY_NATIONAL_HEALTHCARE', Help = 'TXT_KEY_POLICY_NATIONAL_HEALTHCARE_HELP', Civilopedia = 'TXT_KEY_POLICY_NATIONAL_HEALTHCARE_TEXT'
WHERE Type = 'POLICY_UNIVERSAL_HEALTHCARE_A';

UPDATE Policies
SET Type = 'POLICY_NATIONAL_HEALTHCARE', Description = 'TXT_KEY_POLICY_NATIONAL_HEALTHCARE', Help = 'TXT_KEY_POLICY_NATIONAL_HEALTHCARE_HELP_HEALTH', Civilopedia = 'TXT_KEY_POLICY_NATIONAL_HEALTHCARE_TEXT'
WHERE Type = 'POLICY_UNIVERSAL_HEALTHCARE_A'
AND EXISTS (SELECT IconString FROM Yields WHERE IconString = '[ICON_JFD_HEALTH]');

UPDATE Policies
SET Type = 'POLICY_PRIVATE_HEALTHCARE', Description = 'TXT_KEY_POLICY_PRIVATE_HEALTHCARE', Help = 'TXT_KEY_POLICY_PRIVATE_HEALTHCARE_HELP', Civilopedia = 'TXT_KEY_POLICY_PRIVATE_HEALTHCARE_TEXT'
WHERE Type = 'POLICY_UNIVERSAL_HEALTHCARE_F';

UPDATE Policies
SET Type = 'POLICY_UNIVERSAL_HEALTHCARE'
WHERE Type = 'POLICY_UNIVERSAL_HEALTHCARE_O';
--------------------------------------------------------------------------------------------------------------------------
-- Policy_Flavors
--------------------------------------------------------------------------------------------------------------------------
UPDATE Policy_Flavors
SET PolicyType = 'POLICY_UNIVERSAL_HEALTHCARE'
WHERE PolicyType = 'POLICY_UNIVERSAL_HEALTHCARE_O';

DELETE FROM Policy_Flavors 
WHERE PolicyType IN ('POLICY_UNIVERSAL_HEALTHCARE_A', 'POLICY_UNIVERSAL_HEALTHCARE_F');
--------------------------------------------------------------------------------------------------------------------------
-- Policy_BuildingClassHappiness
--------------------------------------------------------------------------------------------------------------------------
UPDATE Policy_BuildingClassHappiness
SET PolicyType = 'POLICY_UNIVERSAL_HEALTHCARE'
WHERE PolicyType = 'POLICY_UNIVERSAL_HEALTHCARE_O';

DELETE FROM Policy_BuildingClassHappiness 
WHERE PolicyType IN ('POLICY_UNIVERSAL_HEALTHCARE_A', 'POLICY_UNIVERSAL_HEALTHCARE_F');
--------------------------------------------------------------------------------------------------------------------------
-- Policy_BuildingClassYieldChanges
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_BuildingClassYieldChanges
		(PolicyType,					BuildingClassType,  YieldType,		YieldChange)
SELECT  'POLICY_NATIONAL_HEALTHCARE',	Type,				'YIELD_FOOD',	2
FROM BuildingClasses WHERE MaxPlayerInstances == 1;

INSERT INTO Policy_BuildingClassYieldChanges
		(PolicyType,					BuildingClassType,  YieldType,		YieldChange)
SELECT  'POLICY_PRIVATE_HEALTHCARE',	Type,				'YIELD_GOLD',	3
FROM BuildingClasses WHERE MaxPlayerInstances == 1;
--==========================================================================================================================
--==========================================================================================================================
