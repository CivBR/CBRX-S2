--==========================================================================================================================
-- GEDEMON R.E.D.
--==========================================================================================================================
-- Civilizations
--------------------------------------------------------------------------------------------------------------------------	
UPDATE Civilizations 
SET ArtStyleSuffix = 'AMERICAN'
WHERE Type = 'CIVILIZATION_EW_NEUTRAL'
AND EXISTS (SELECT * FROM Civilizations WHERE ArtStyleSuffix = 'AMERICAN');
--==========================================================================================================================
-- GEDEMON YNAEMP
--==========================================================================================================================
-- Civilizations_YnAEMP
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YnAEMP(CivilizationType, MapPrefix, X, Y, CapitalName, AltX, AltY, AltCapitalName);
INSERT INTO Civilizations_YnAEMP
		(CivilizationType,			MapPrefix, 					X,		Y)
VALUES	('CIVILIZATION_EW_NEUTRAL',	'AmericasGiant',			82,		47),	 	
		('CIVILIZATION_EW_NEUTRAL',	'Americas',					48,		23),	
		('CIVILIZATION_EW_NEUTRAL',	'Cordiform',				14,		11),	 	
		('CIVILIZATION_EW_NEUTRAL',	'GreatestEarth',			24,		13),	 	
		('CIVILIZATION_EW_NEUTRAL',	'NorthAmericaGiant',		67,		70),	 	
		('CIVILIZATION_EW_NEUTRAL',	'NorthAmericaHuge',			52,		52),	 		 	
		('CIVILIZATION_EW_NEUTRAL',	'Yagem',					155,	20),	 	
		('CIVILIZATION_EW_NEUTRAL',	'Yahem',					32,		24);
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_CordiformStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'Cordiform';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_GreatestEarthStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'GreatestEarth';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_EuroLargeStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroLargeStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'EuroLarge';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_YagemStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'Yagem';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_YahemStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'Yahem';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AegeanStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AegeanStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AegeanStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'Aegean';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AfricaLargeStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AfricaLargeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AfricaLargeStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'AfricaLarge';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AmericasStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AmericasStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AmericasStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'Americas';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_ApennineStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_ApennineStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_ApennineStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'Apennine';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AsiaStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AsiaStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AsiaStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'Asia';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_CaribbeanStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CaribbeanStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CaribbeanStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'Caribbean';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_BritishIslesStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_BritishIslesStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_BritishIslesStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'BritishIsles';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_EastAsiaStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EastAsiaStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EastAsiaStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'EastAsia';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_EuroGiantStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroGiantStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'EuroGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_MediterraneanStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_MediterraneanStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_MediterraneanStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'Mediterranean';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_MesopotamiaStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_MesopotamiaStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_MesopotamiaStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'Mesopotamia';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_NileValleyStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NileValleyStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NileValleyStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'NileValley';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_NorthAtlanticStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthAtlanticStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthAtlanticStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'NorthAtlantic';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_NorthEastAsiaStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthEastAsiaStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthEastAsiaStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'NorthEastAsia';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_NorthWestEuropeStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthWestEuropeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthWestEuropeStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'NorthWestEurope';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_PacificStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_PacificStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_PacificStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'Pacific';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_SouthPacificStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_SouthPacificStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_SouthPacificStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'SouthPacific';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AdriaticStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AdriaticStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AdriaticStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'Adriatic';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AfriAsiaAustStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AfriAsiaAustStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AfriAsiaAustStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'AfriAsiaAust';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AfriGiantStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AfriGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AfriGiantStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'AfriGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AfriSouthEuroStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AfriSouthEuroStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AfriSouthEuroStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'AfriSouthEuro';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AmericasGiantStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AmericasGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AmericasGiantStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'AmericasGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AsiaSmallStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AsiaSmallStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AsiaSmallStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'AsiaSmall';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AsiaSteppeGiantStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AsiaSteppeGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AsiaSteppeGiantStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'AsiaSteppeGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AustralasiaGiantStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AustralasiaGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AustralasiaGiantStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'AustralasiaGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_CaucasusStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CaucasusStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CaucasusStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'Caucasus';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_CentralAsiaStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CentralAsiaStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CentralAsiaStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'CentralAsia';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_EuroEasternStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroEasternStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroEasternStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'EuroEastern';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_EuroLargeNewStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeNewStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroLargeNewStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'EuroLargeNew';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_IndiaGiantStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_IndiaGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_IndiaGiantStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'IndiaGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_MesopotamiaGiantStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_MesopotamiaGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_MesopotamiaGiantStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'MesopotamiaGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_NorthAmericaGiantStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthAmericaGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthAmericaGiantStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'NorthAmericaGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_NorthAmericaHugeStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthAmericaHugeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthAmericaHugeStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'NorthAmericaHuge';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_NorthSeaEuropeStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthSeaEuropeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthSeaEuropeStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'NorthSeaEurope';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_ScotlandIrelandHugeStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_ScotlandIrelandHugeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_ScotlandIrelandHugeStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'ScotlandIrelandHuge';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_SouthAmericaGiantStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_SouthAmericaGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_SouthAmericaGiantStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'SouthAmericaGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_SouthAmericaLargeStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_SouthAmericaLargeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_SouthAmericaLargeStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'SouthAmericaLarge';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_SouthAmericaCentralHugeStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_SouthAmericaCentralHugeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_SouthAmericaCentralHugeStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'SouthAmericaCentralHuge';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_SouthAmericaCentralGiantStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_SouthAmericaCentralGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_SouthAmericaCentralGiantStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'SouthAmericaCentralGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_SouthAsiaHugeStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_SouthAsiaHugeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_SouthAsiaHugeStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'SouthAsiaHuge';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_SouthPacificGiantStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_SouthPacificGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_SouthPacificGiantStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'SouthPacificGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_WestAfricaStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_WestAfricaStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_WestAfricaStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'WestAfrica';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_IndianOceanStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_IndianOceanStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_IndianOceanStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_EW_NEUTRAL',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'IndianOcean';
--------------------------------------------------------------------------------------------------------------------------	
-- Civilizations_YnAEMPRequestedResources
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YnAEMPRequestedResources(CivilizationType, MapPrefix, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4, Req5, Yield5, Req6, Yield6);
INSERT INTO Civilizations_YnAEMPRequestedResources
		(CivilizationType,						MapPrefix, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4, Req5, Yield5, Req6, Yield6)
SELECT	'CIVILIZATION_EW_NEUTRAL',	MapPrefix, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4, Req5, Yield5, Req6, Yield6
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_IROQUOIS';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_CordiformRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CordiformRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_CordiformRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'Cordiform';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_GreatestEarthRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_GreatestEarthRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'GreatestEarth';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_EuroLargeRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_EuroLargeRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'EuroLarge';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_YagemRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'Yagem';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_YahemRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YahemRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'Yahem';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AegeanRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AegeanRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AegeanRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'Aegean';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AfricaLargeRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AfricaLargeRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AfricaLargeRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'AfricaLarge';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AmericasRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AmericasRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AmericasRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'Americas';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_ApennineRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_ApennineRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_ApennineRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'Apennine';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AsiaRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AsiaRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AsiaRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'Asia';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_CaribbeanRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CaribbeanRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_CaribbeanRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'Caribbean';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_BritishIslesRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_BritishIslesRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_BritishIslesRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'BritishIsles';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_EastAsiaRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EastAsiaRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_EastAsiaRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'EastAsia';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_EuroGiantRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroGiantRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_EuroGiantRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'EuroGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_MediterraneanRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_MediterraneanRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_MediterraneanRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'Mediterranean';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_MesopotamiaRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_MesopotamiaRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_MesopotamiaRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'Mesopotamia';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_NileValleyRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NileValleyRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_NileValleyRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'NileValley';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_NorthAtlanticRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthAtlanticRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_NorthAtlanticRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'NorthAtlantic';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_NorthEastAsiaRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthEastAsiaRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_NorthEastAsiaRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'NorthEastAsia';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_NorthWestEuropeRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthWestEuropeRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_NorthWestEuropeRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'NorthWestEurope';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_PacificRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_PacificRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_PacificRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'Pacific';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_SouthPacificRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_SouthPacificRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_SouthPacificRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'SouthPacific';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AdriaticRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AdriaticRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AdriaticRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'Adriatic';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AfriAsiaAustRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AfriAsiaAustRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AfriAsiaAustRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'AfriAsiaAust';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AfriGiantRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AfriGiantRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AfriGiantRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'AfriGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AfriSouthEuroRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AfriSouthEuroRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AfriSouthEuroRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'AfriSouthEuro';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AmericasGiantRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AmericasGiantRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AmericasGiantRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'AmericasGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AsiaSmallRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AsiaSmallRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AsiaSmallRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'AsiaSmall';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AsiaSteppeGiantRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AsiaSteppeGiantRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AsiaSteppeGiantRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'AsiaSteppeGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AustralasiaGiantRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AustralasiaGiantRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AustralasiaGiantRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'AustralasiaGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_CaucasusRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CaucasusRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_CaucasusRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'Caucasus';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_CentralAsiaRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CentralAsiaRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_CentralAsiaRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'CentralAsia';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_EuroEasternRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroEasternRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_EuroEasternRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'EuroEastern';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_EuroLargeNewRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeNewRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_EuroLargeNewRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'EuroLargeNew';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_IndiaGiantRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_IndiaGiantRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_IndiaGiantRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'IndiaGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_MesopotamiaGiantRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_MesopotamiaGiantRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_MesopotamiaGiantRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'MesopotamiaGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_NorthAmericaGiantRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthAmericaGiantRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_NorthAmericaGiantRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'NorthAmericaGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_NorthAmericaHugeRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthAmericaHugeRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_NorthAmericaHugeRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'NorthAmericaHuge';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_NorthSeaEuropeRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthSeaEuropeRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_NorthSeaEuropeRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'NorthSeaEurope';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_ScotlandIrelandHugeRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_ScotlandIrelandHugeRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_ScotlandIrelandHugeRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'ScotlandIrelandHuge';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_SouthAmericaGiantRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_SouthAmericaGiantRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_SouthAmericaGiantRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'SouthAmericaGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_SouthAmericaLargeRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_SouthAmericaLargeRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_SouthAmericaLargeRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'SouthAmericaLarge';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_SouthAmericaCentralHugeRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_SouthAmericaCentralHugeRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_SouthAmericaCentralHugeRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'SouthAmericaCentralHuge';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_SouthAmericaCentralGiantRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_SouthAmericaCentralGiantRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_SouthAmericaCentralGiantRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'SouthAmericaCentralGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_SouthAsiaHugeRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_SouthAsiaHugeRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_SouthAsiaHugeRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'SouthAsiaHuge';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_SouthPacificGiantRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_SouthPacificGiantRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_SouthPacificGiantRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'SouthPacificGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_WestAfricaRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_WestAfricaRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_WestAfricaRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'WestAfrica';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_IndianOceanRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_IndianOceanRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_IndianOceanRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_EW_NEUTRAL',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_EW_NEUTRAL' AND MapPrefix = 'IndianOcean';
--==========================================================================================================================
-- HAZEL MAP LABELS
--==========================================================================================================================
-- ML_CivCultures
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
		(CivType, 							CultureType, CultureEra)
SELECT	'CIVILIZATION_EW_NEUTRAL',	CultureType, CultureEra
FROM ML_CivCultures WHERE CivType = 'CIVILIZATION_IROQUOIS';
--==========================================================================================================================
-- JFDLC
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- Flavors
--------------------------------------------------------------------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_DECOLONIZATION'),
		('FLAVOR_JFD_MERCENARY'),
		('FLAVOR_JFD_REFORM_GOVERNMENT'),
		('FLAVOR_JFD_REFORM_LEGAL'),
		('FLAVOR_JFD_REFORM_CULTURE'),
		('FLAVOR_JFD_REFORM_ECONOMIC'),
		('FLAVOR_JFD_REFORM_FOREIGN'),
		('FLAVOR_JFD_REFORM_INDUSTRY'),
		('FLAVOR_JFD_REFORM_MILITARY'),
		('FLAVOR_JFD_REFORM_RELIGION'),
		('FLAVOR_JFD_RELIGIOUS_INTOLERANCE'),
		('FLAVOR_JFD_SLAVERY'),
		('FLAVOR_JFD_STATE_RELIGION');
--------------------------------------------------------------------------------------------------------------------------
-- Leader_Flavors
--------------------------------------------------------------------------------------------------------------------------	
-- INSERT INTO Leader_Flavors
		-- (LeaderType,			FlavorType,								Flavor)
-- VALUES	('LEADER_SENSHI_SANTACRUZ',	'FLAVOR_JFD_DECOLONIZATION',			3),
		-- ('LEADER_SENSHI_SANTACRUZ',	'FLAVOR_JFD_MERCENARY',					6),
		-- ('LEADER_SENSHI_SANTACRUZ',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',		2),
		-- ('LEADER_SENSHI_SANTACRUZ',	'FLAVOR_JFD_REFORM_GOVERNMENT',			8),
		-- ('LEADER_SENSHI_SANTACRUZ',	'FLAVOR_JFD_REFORM_LEGAL',				6),
		-- ('LEADER_SENSHI_SANTACRUZ',	'FLAVOR_JFD_REFORM_CULTURE',			2),
		-- ('LEADER_SENSHI_SANTACRUZ',	'FLAVOR_JFD_REFORM_ECONOMIC',			9),
		-- ('LEADER_SENSHI_SANTACRUZ',	'FLAVOR_JFD_REFORM_FOREIGN',			6),
		-- ('LEADER_SENSHI_SANTACRUZ',	'FLAVOR_JFD_REFORM_INDUSTRY',			5),
		-- ('LEADER_SENSHI_SANTACRUZ',	'FLAVOR_JFD_REFORM_MILITARY',			8),
		-- ('LEADER_SENSHI_SANTACRUZ',	'FLAVOR_JFD_REFORM_RELIGION',			3),
		-- ('LEADER_SENSHI_SANTACRUZ',	'FLAVOR_JFD_SLAVERY',					0),
		-- ('LEADER_SENSHI_SANTACRUZ',	'FLAVOR_JFD_STATE_RELIGION',			0);
--==========================================================
-- JFD CIVILOPEDIA
--==========================================================
-- JFD_Civilopedia_HideFromPedia
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
JFD_Civilopedia_HideFromPedia (Type text default null);
--==========================================================	
-- JFD INVENTIONS 
--==========================================================	
-- Civilization_JFD_Inventions
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Inventions (
	CivilizationType  				text 	REFERENCES Civilizations(Type) 						default null,
	InventionType  					text 		 												default null,
	InventionPreference				text 		 												default null);
	
INSERT INTO Civilization_JFD_Inventions
		(CivilizationType,			InventionType, InventionPreference)
SELECT	'CIVILIZATION_EW_NEUTRAL',	InventionType, InventionPreference
FROM Civilization_JFD_Inventions WHERE CivilizationType = 'CIVILIZATION_IROQUOIS';
--==========================================================================================================================
-- JFD CITIES IN DEVELOPMENT
--==========================================================================================================================
--====================================	
-- JFD COLONIES
--====================================	
--------------------------------------------------------------------------------------------------------------------------
-- Civilization_JFD_ColonialCityNames
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_ColonialCityNames (
	CivilizationType 				text 	REFERENCES Civilizations(Type) 						default null,
	ColonyName 						text														default null,
	LinguisticType					text														default	null);

INSERT INTO Civilization_JFD_ColonialCityNames
		(CivilizationType,			LinguisticType)
SELECT	'CIVILIZATION_EW_NEUTRAL',	LinguisticType
FROM Civilization_JFD_ColonialCityNames WHERE CivilizationType = 'CIVILIZATION_IROQUOIS';
--==========================================================================================================================
-- JFD CULTURAL DIVERSITY
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- Civilization_JFD_CultureTypes
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes(
	CivilizationType 				text 		REFERENCES Civilizations(Type) 					default null,
	CultureType 					text														default null,
	SubCultureType 					text														default null,
	ArtDefineTag					text														default	null,
	DecisionsTag					text														default	null,
	DefeatScreenEarlyTag			text														default	null,
	DefeatScreenMidTag				text														default	null,
	DefeatScreenLateTag				text														default	null,
	IdealsTag						text														default	null,
	SplashScreenTag					text														default	null,
	SoundtrackTag					text														default	null,
	UnitDialogueTag					text														default null);

INSERT INTO Civilization_JFD_CultureTypes
		(CivilizationType,			ArtDefineTag, CultureType, SubCultureType,DecisionsTag, DefeatScreenEarlyTag, DefeatScreenMidTag, DefeatScreenLateTag, IdealsTag, SplashScreenTag, SoundtrackTag,	UnitDialogueTag)
SELECT	'CIVILIZATION_EW_NEUTRAL',	ArtDefineTag, CultureType, SubCultureType,DecisionsTag, DefeatScreenEarlyTag, DefeatScreenMidTag, DefeatScreenLateTag, IdealsTag, SplashScreenTag, SoundtrackTag, 	UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_IROQUOIS';
--------------------------------------------------------------------------------------------------------------------------	
-- Civilizations
--------------------------------------------------------------------------------------------------------------------------	
UPDATE Civilizations 
SET SoundtrackTag = 'JFD_ColonialLatin'
WHERE Type = 'CIVILIZATION_EW_NEUTRAL'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_ColonialLatin')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CULDIV_SOUNDTRACK_ADDON' AND Value = 1);