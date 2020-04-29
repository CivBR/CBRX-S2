--==========================================================================================================================
-- IDEOLOGICAL VALUES
--==========================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
-- JFD_IdeologicalValues
-------------------------------------------------------------------------------------------------------------------------
INSERT INTO JFD_IdeologicalValues
		(Type,								Description,									IdeologyBranchType,			IconString)
VALUES	('IDEOLOGICAL_VALUE_JFD_EQUALITY',	'TXT_KEY_IDEOLOGICAL_VALUE_JFD_EQUALITY_DESC',	'POLICY_BRANCH_ORDER',		'[ICON_IDEOLOGY_ORDER]'),
		('IDEOLOGICAL_VALUE_JFD_LIBERTY',	'TXT_KEY_IDEOLOGICAL_VALUE_JFD_LIBERTY_DESC',	'POLICY_BRANCH_FREEDOM',	'[ICON_IDEOLOGY_FREEDOM]'),
		('IDEOLOGICAL_VALUE_JFD_AUTHORITY',	'TXT_KEY_IDEOLOGICAL_VALUE_JFD_AUTHORITY_DESC',	'POLICY_BRANCH_AUTOCRACY',	'[ICON_IDEOLOGY_AUTOCRACY]');
-------------------------------------------------------------------------------------------------------------------------
-- Policies
-------------------------------------------------------------------------------------------------------------------------
UPDATE Policies
SET IdeologicalValueReq = 25
WHERE Level = 1 AND PolicyBranchType != 'POLICY_BRANCH_JFD_SPIRIT';

UPDATE Policies
SET IdeologicalValueReq = 50
WHERE Level = 2 AND PolicyBranchType != 'POLICY_BRANCH_JFD_SPIRIT';

UPDATE Policies
SET IdeologicalValueReq = 75
WHERE Level = 3 AND PolicyBranchType != 'POLICY_BRANCH_JFD_SPIRIT';
-------------------------------------------------------------------------------------------------------------------------
-- Policy_JFD_IdeologicalValues
-------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_JFD_IdeologicalValues
		(PolicyType, IdeologicalValueType)
SELECT	Type,		'IDEOLOGICAL_VALUE_JFD_AUTHORITY'
FROM Policies WHERE Type IN ('POLICY_ARISTOCRACY', 'POLICY_LANDED_ELITE', 'POLICY_LEGALISM', 'POLICY_MONARCHY', 'POLICY_OLIGARCHY', 'POLICY_TRADITION', 'POLICY_DISCIPLINE', 'POLICY_HONOR', 'POLICY_MILITARY_TRADITION', 'POLICY_WARRIOR_CODE', 'POLICY_MANDATE_OF_HEAVEN', 'POLICY_PIETY', 'POLICY_THEOCRACY', 'POLICY_MERCANTILISM', 'POLICY_NAVAL_TRADITION', 'POLICY_NAVIGATION_SCHOOL', 'POLICY_SOVEREIGNTY', 'POLICY_SCHOLASTICISM');

INSERT INTO Policy_JFD_IdeologicalValues
		(PolicyType, IdeologicalValueType)
SELECT	Type,		'IDEOLOGICAL_VALUE_JFD_AUTHORITY'
FROM Policies WHERE OriginalPolicyBranchType = 'POLICY_BRANCH_AUTOCRACY';

INSERT INTO Policy_JFD_IdeologicalValues
		(PolicyType, IdeologicalValueType)
SELECT	Type,		'IDEOLOGICAL_VALUE_JFD_EQUALITY'
FROM Policies WHERE Type IN ('POLICY_CITIZENSHIP', 'POLICY_COLLECTIVE_RULE', 'POLICY_PROFESSIONAL_ARMY', 'POLICY_REPRESENTATION', 'POLICY_REPUBLIC', 'POLICY_FREE_RELIGION', 'POLICY_MERCHANT_CONFEDERACY', 'POLICY_MILITARY_CASTE', 'POLICY_CONSULATES', 'POLICY_PHILANTHROPY', 'POLICY_FLOURISHING_OF_ARTS', 'POLICY_ETHICS', 'POLICY_PROTECTIONISM', 'POLICY_TRADE_UNIONS', 'POLICY_HUMANISM', 'POLICY_SECULARISM', 'POLICY_CULTURAL_CENTERS', 'POLICY_ORGANIZED_RELIGION');

INSERT INTO Policy_JFD_IdeologicalValues
		(PolicyType, IdeologicalValueType)
SELECT	Type,		'IDEOLOGICAL_VALUE_JFD_EQUALITY'
FROM Policies WHERE OriginalPolicyBranchType = 'POLICY_BRANCH_ORDER';

INSERT INTO Policy_JFD_IdeologicalValues
		(PolicyType, IdeologicalValueType)
SELECT	Type,		'IDEOLOGICAL_VALUE_JFD_LIBERTY'
FROM Policies WHERE Type IN ('POLICY_LIBERTY', 'POLICY_MERITOCRACY', 'POLICY_REFORMATION', 'POLICY_CULTURAL_DIPLOMACY', 'POLICY_PATRONAGE', 'POLICY_AESTHETICS', 'POLICY_ARTISTIC_GENIUS', 'POLICY_FINE_ARTS', 'POLICY_CARAVANS', 'POLICY_COMMERCE', 'POLICY_ENTREPRENEURSHIP', 'POLICY_EXPLORATION', 'POLICY_TREASURE_FLEETS', 'POLICY_MERCHANT_NAVY', 'POLICY_FREE_THOUGHT', 'POLICY_RATIONALISM', 'POLICY_SCIENTIFIC_REVOLUTION', 'POLICY_MARITIME_INFRASTRUCTURE');

INSERT INTO Policy_JFD_IdeologicalValues
		(PolicyType, IdeologicalValueType)
SELECT	Type,		'IDEOLOGICAL_VALUE_JFD_LIBERTY'
FROM Policies WHERE OriginalPolicyBranchType = 'POLICY_BRANCH_FREEDOM';
--==========================================================================================================================
--==========================================================================================================================
