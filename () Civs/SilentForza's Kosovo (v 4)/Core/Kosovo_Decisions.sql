--==========================================================================================================================
-- SUKRITACT DECISIONS
--==========================================================================================================================
-- DecisionsAddin_Support
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('Kosovo_Decisions.lua');
--==========================================================================================================================	
-- BuildingClasses
--==========================================================================================================================	
INSERT INTO BuildingClasses 	
			(Type, 						 		 				DefaultBuilding, 						Description, 										MaxGlobalInstances, MaxPlayerInstances)
VALUES		('BUILDINGCLASS_SF_KOSOVO_DELEGATES', 				'BUILDING_SF_KOSOVO_DELEGATES', 		'TXT_KEY_BUILDING_SF_KOSOVO_DELEGATES',   			-1,					-1),
			('BUILDINGCLASS_SF_KOSOVO_TOURISM', 				'BUILDING_SF_KOSOVO_DELEGATES', 		'TXT_KEY_BUILDING_SF_KOSOVO_DELEGATES',   			-1,					-1);
--==========================================================================================================================	
-- Buildings: Invisible
--==========================================================================================================================
INSERT INTO Buildings 	
			(Type, 						 				BuildingClass, 							Description,							GreatWorkCount, Cost, FaithCost, PrereqTech, 	NeverCapture, ExtraLeagueVotes)
VALUES		('BUILDING_SF_KOSOVO_DELEGATES', 			'BUILDINGCLASS_SF_KOSOVO_DELEGATES',	'TXT_KEY_BUILDING_SF_KOSOVO_DELEGATES',	-1, 			-1,   -1, 		 null,			1,			  1),
			('BUILDING_SF_KOSOVO_TOURISM', 				'BUILDINGCLASS_SF_KOSOVO_TOURISM',		'TXT_KEY_BUILDING_SF_KOSOVO_TOURISM',	-1, 			-1,   -1, 		 null,			1,			  0);
--==========================================================================================================================	
-- Policies
--==========================================================================================================================
INSERT INTO Policies 
		(Type,								Description)
VALUES	('POLICY_SF_KOSOVO_TOURISM',		'TXT_KEY_SF_KOSOVO_DECISIONS_WINEINDUSTRY');	

INSERT INTO Policy_BuildingClassTourismModifiers
		(PolicyType, 							BuildingClassType, 					TourismModifier)
VALUES	('POLICY_SF_KOSOVO_TOURISM', 	'BUILDINGCLASS_SF_KOSOVO_TOURISM',	2);