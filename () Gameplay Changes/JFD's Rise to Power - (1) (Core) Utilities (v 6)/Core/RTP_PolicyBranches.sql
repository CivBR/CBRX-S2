--==========================================================================================================================
-- POLICY BRANCHES
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- PolicyBranchTypes
--------------------------------------------------------------------------------------------------------------------------
UPDATE PolicyBranchTypes
SET IconString = '[ICON_IDEOLOGY_FREEDOM]'
WHERE Type = 'POLICY_BRANCH_FREEDOM';

UPDATE PolicyBranchTypes
SET IconString = '[ICON_IDEOLOGY_AUTOCRACY]'
WHERE Type = 'POLICY_BRANCH_AUTOCRACY';

UPDATE PolicyBranchTypes
SET IconString = '[ICON_IDEOLOGY_ORDER]'
WHERE Type = 'POLICY_BRANCH_ORDER';

UPDATE PolicyBranchTypes
SET IconString = '[ICON_IDEOLOGY_JFD_SPIRIT]'
WHERE Type = 'POLICY_BRANCH_JFD_SPIRIT';
--==========================================================================================================================
--==========================================================================================================================