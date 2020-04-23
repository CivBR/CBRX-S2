CREATE TABLE IF NOT EXISTS	Civilization_FreePolicies (
	CivilizationType  		text 		REFERENCES Civilizations(Type) 		default null,
	PolicyType				text 		REFERENCES Policies(Type) 			default null);

INSERT OR REPLACE INTO Civilization_FreePolicies
		(CivilizationType,			PolicyType)
VALUES	('CIVILIZATION_MC_MARATHA',	'POLICY_MC_CONSCRIPTION');