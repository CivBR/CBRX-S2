--==========================================================================================================================
-- POLICY BRANCHES
--==========================================================================================================================
-- PolicyBranchTypes
--------------------------------------------------------------------------------------------------------------------------
ALTER TABLE PolicyBranchTypes ADD TitleShort text default null;
	
--Tradition
UPDATE PolicyBranchTypes
SET TitleShort = 'TXT_KEY_TRADITION_TITLE_SHORT'
WHERE Type = 'POLICY_BRANCH_TRADITION';

--Liberty
UPDATE PolicyBranchTypes
SET TitleShort = 'TXT_KEY_LIBERTY_TITLE_SHORT'
WHERE Type = 'POLICY_BRANCH_LIBERTY';

--Honor
UPDATE PolicyBranchTypes
SET TitleShort = 'TXT_KEY_HONOR_TITLE_SHORT'
WHERE Type = 'POLICY_BRANCH_HONOR';

--Piety
UPDATE PolicyBranchTypes
SET TitleShort = 'TXT_KEY_PIETY_TITLE_SHORT'
WHERE Type = 'POLICY_BRANCH_PIETY';

--Patronage
UPDATE PolicyBranchTypes
SET TitleShort = 'TXT_KEY_PATRONAGE_TITLE_SHORT'
WHERE Type = 'POLICY_BRANCH_PATRONAGE';

--Aesthetics
UPDATE PolicyBranchTypes
SET TitleShort = 'TXT_KEY_AESTHETICS_TITLE_SHORT'
WHERE Type = 'POLICY_BRANCH_AESTHETICS';

--Exploration
UPDATE PolicyBranchTypes
SET TitleShort = 'TXT_KEY_EXPLORATION_TITLE_SHORT'
WHERE Type = 'POLICY_BRANCH_EXPLORATION';

--Commerce
UPDATE PolicyBranchTypes
SET TitleShort = 'TXT_KEY_COMMERCE_TITLE_SHORT'
WHERE Type = 'POLICY_BRANCH_COMMERCE';

--Rationalism
UPDATE PolicyBranchTypes
SET TitleShort = 'TXT_KEY_RATIONALISM_TITLE_SHORT'
WHERE Type = 'POLICY_BRANCH_RATIONALISM';

--Freedom
UPDATE PolicyBranchTypes
SET TitleShort = 'TXT_KEY_FREEDOM_TITLE_SHORT'
WHERE Type = 'POLICY_BRANCH_FREEDOM';

--Order
UPDATE PolicyBranchTypes
SET TitleShort = 'TXT_KEY_ORDER_TITLE_SHORT'
WHERE Type = 'POLICY_BRANCH_ORDER';

--Autocracy
UPDATE PolicyBranchTypes
SET TitleShort = 'TXT_KEY_AUTOCRACY_TITLE_SHORT'
WHERE Type = 'POLICY_BRANCH_AUTOCRACY';
--==========================================================================================================================
--==========================================================================================================================