--==========================================================================================================================
-- USER SETTINGS (THIS IS NEEDED IN MOST CASES)
--==========================================================================================================================
-- JFD_GlobalUserSettings
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS
	JFD_GlobalUserSettings (
    Type                text            default null,
    Value               integer         default 1);
--==========================================================	
-- SOVEREIGNTY
--==========================================================
------------------------------------------------------------
-- Civilization_JFD_Politics
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Politics (
	CivilizationType  					text 		REFERENCES Civilizations(Type) 					default null,
	PoliticsType  						text 														default null,
	UniqueName							text														default	null);

INSERT INTO Civilization_JFD_Politics
		(CivilizationType,					PoliticsType, UniqueName)
SELECT	'CIVILIZATION_JWW_RIO_GRANDE',	PoliticsType, UniqueName
FROM Civilization_JFD_Politics WHERE CivilizationType = 'CIVILIZATION_SPAIN';
------------------------------------------------------------
-- Flavors
------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_REFORM_GOVERNMENT'),
		('FLAVOR_JFD_REFORM_LEGAL'),
		('FLAVOR_JFD_REFORM_CULTURE'),
		('FLAVOR_JFD_REFORM_ECONOMIC'),
		('FLAVOR_JFD_REFORM_FOREIGN'),
		('FLAVOR_JFD_REFORM_INDUSTRY'),
		('FLAVOR_JFD_REFORM_MILITARY'),
		('FLAVOR_JFD_REFORM_RELIGION');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------	
INSERT INTO Leader_Flavors
		(LeaderType,						FlavorType,							Flavor)
VALUES	('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_JFD_REFORM_GOVERNMENT',		6),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_JFD_REFORM_LEGAL',			4),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_JFD_REFORM_CULTURE',		6),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_JFD_REFORM_ECONOMIC',		3),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_JFD_REFORM_FOREIGN',		9),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_JFD_REFORM_INDUSTRY',		2),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_JFD_REFORM_MILITARY',		9),
		('LEADER_JWW_ANTONIO_CANALES',	'FLAVOR_JFD_REFORM_RELIGION',		2);

--==========================================================================================================================
-- HISTORICAL RELIGIONS
--==========================================================================================================================
