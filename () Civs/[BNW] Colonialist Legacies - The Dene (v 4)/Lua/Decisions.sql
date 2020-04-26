-- Insert SQL Rules Here 
--==========================================================================================================================
-- DecisionsAddin_Support
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('DeneDecisions.lua');
--==========================================================================================================================
-- Policies
--==========================================================================================================================
INSERT INTO Policies		
			(Type,					Description)
VALUES		('POLICY_CLDENEDOGS',	'TXT_KEY_DECISIONS_CLDENEDOGS'),
			('POLICY_CLELDERS',		'TXT_KEY_DECISIONS_CLELDERS');

insert into Policy_ImprovementYieldChanges (PolicyType, ImprovementType, YieldType, Yield)
Values ('POLICY_CLDENEDOGS', 'IMPROVEMENT_CAMP', 'YIELD_FOOD', 1),
       ('POLICY_CLDENEDOGS', 'IMPROVEMENT_CAMP', 'YIELD_CULTURE', 1),
	   ('POLICY_CLDENEDOGS', 'IMPROVEMENT_YELLOWKNIFE', 'YIELD_FOOD', 1),
	   ('POLICY_CLDENEDOGS', 'IMPROVEMENT_YELLOWKNIFE', 'YIELD_CULTURE', 1);