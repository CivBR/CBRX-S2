--==========================================================================================================================
-- DecisionsAddin_Support
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('MC_Gaul_Decisions.lua');
--==========================================================================================================================
-- EventsAddin_Support
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS EventsAddin_Support(FileName);
INSERT INTO EventsAddin_Support (FileName) VALUES ('MC_Gaul_Events.lua');
--==========================================================================================================================
-- Policies
--==========================================================================================================================
INSERT INTO Policies 
			(Type, 										Description) 
VALUES		('POLICY_DECISION_GAULTORC',	 	    	'TXT_KEY_DECISION_GAULTORC');
--==========================================================================================================================
-- Policy_BuildingClassYieldChanges
--==========================================================================================================================
INSERT INTO Policy_BuildingClassYieldChanges 
			(PolicyType, 							BuildingClassType,			YieldType, 				YieldChange)
VALUES 		('POLICY_DECISION_GAULTORC', 			'BUILDINGCLASS_MINT',		'YIELD_GOLD', 			2);
--==========================================================================================================================
--==========================================================================================================================