--==========================================================================================================================		
-- CONCEPTS
--==========================================================================================================================
-- Concepts
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Concepts	
		(Type, 							Topic,											Description,									Summary,										Advisor,	 CivilopediaHeaderType)
VALUES	('CONCEPT_JFD_SPIRIT_IDEOLOGY',	'TXT_KEY_JFD_SPIRIT_IDEOLOGY_HEADING1_TITLE',	'TXT_KEY_JFD_SPIRIT_IDEOLOGY_HEADING1_TITLE',	'TXT_KEY_JFD_SPIRIT_IDEOLOGY_HEADING1_BODY',	'ECONOMIC',	 'HEADER_JFDLC');

UPDATE Concepts
SET Summary = 'TXT_KEY_JFD_SPIRIT_IDEOLOGY_HEADING1_BODY_CP'
WHERE Type = 'CONCEPT_JFD_SPIRIT_IDEOLOGY'
AND EXISTS (SELECT Name FROM CustomModOptions WHERE Name = 'COMMUNITY_PATCH' AND Value = 1);
--==========================================================================================================================
--==========================================================================================================================