------------------------------
-- Policies
------------------------------
INSERT INTO Policies 
		(Type,									Description) 
VALUES	('POLICY_SENSHI_MANCHU_QUEUE',			'TXT_KEY_DECISIONS_SENSHI_MANCHU_QUEUE'),
		('POLICY_DECISIONS_SENSHI_MANCHU_QING',	'TXT_KEY_DECISIONS_SENSHI_MANCHU_QING');
------------------------------------------------------------
-- Policy_JFD_CivilizationNames
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS
	Policy_JFD_CivilizationNames (
	PolicyType								text 	REFERENCES Policies(Type) 				default null,
	CivilizationType						text 	REFERENCES Civilizations(Type) 			default null,
	Description								text 											default null,
	ShortDescription						text 											default null,
	Adjective								text 											default null);
	
INSERT INTO Policy_JFD_CivilizationNames 	
		(PolicyType, 					CivilizationType,			Adjective,						Description,				ShortDescription)
VALUES	('POLICY_DECISIONS_SENSHI_MANCHU_QING',	'CIVILIZATION_SENSHI_MANCHU',	'TXT_KEY_CIV_SENSHI_QING_ADJECTIVE',	'TXT_KEY_CIV_SENSHI_QING_DESC',	'TXT_KEY_CIV_SENSHI_QING_SHORT_DESC');

INSERT INTO Policy_BuildingClassProductionModifiers
			(PolicyType, BuildingClassType, ProductionModifier)
VALUES		('POLICY_SENSHI_MANCHU_QUEUE', 'BUILDINGCLASS_COURTHOUSE', 100);

INSERT INTO Policy_BuildingClassCultureChanges
			(PolicyType, BuildingClassType, CultureChange)
VALUES		('POLICY_SENSHI_MANCHU_QUEUE', 'BUILDINGCLASS_COURTHOUSE', 2);