--==========================================================================================================================
-- POLICIES
--==========================================================================================================================	
-- Policies
--------------------------------------------------------------------------------------------------------------------------
UPDATE Policies
SET Help = 'TXT_KEY_POLICY_CITIZENSHIP_HELP_JFD_WORKFORCES', WorkerSpeedModifier = 25
WHERE Type IN ('POLICY_CITIZENSHIP', 'POLICY_CITIZENSHIP_NATIONALISM');
------------------------------------------------------------------------------------------------------------------------
-- Policy_JFD_BuildCharges
------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_JFD_BuildCharges
		(PolicyType,			UnitClassType,				NumCharges)
VALUES	('POLICY_CITIZENSHIP',	'UNITCLASS_JFD_WORKFORCE',	1),
		('POLICY_CITIZENSHIP',	'UNITCLASS_WORKER',			1);

INSERT INTO Policy_JFD_BuildCharges
		(PolicyType,						UnitClassType,	NumCharges)
SELECT	'POLICY_CITIZENSHIP_NATIONALISM',	UnitClassType,	NumCharges
FROM Policy_JFD_BuildCharges WHERE PolicyType = 'POLICY_CITIZENSHIP'
AND EXISTS (SELECT Type FROM Policies WHERE Type = 'POLICY_CITIZENSHIP_NATIONALISM');
--==========================================================================================================================
--==========================================================================================================================