--Cahokia to Chaco Canyon
UPDATE MinorCivilizations
SET Description = 'TXT_KEY_CITYSTATE_MOD_PUEBLO',
	ShortDescription = 'TXT_KEY_CITYSTATE_MOD_PUEBLO',
	Adjective = 'TXT_KEY_CITYSTATE_MOD_PUEBLO_ADJ',
	Civilopedia = 'TXT_KEY_CITYSTATE_MOD_PUEBLO_PEDIA'
WHERE Type = 'MINOR_CIV_CAHOKIA';

DELETE FROM MinorCivilization_CityNames WHERE MinorCivType IN ('MINOR_CIV_CAHOKIA');
INSERT INTO MinorCivilization_CityNames
			(MinorCivType,						                          CityName)
SELECT		('MINOR_CIV_CAHOKIA'),				   ('TXT_KEY_CITYSTATE_MOD_PUEBLO')
WHERE EXISTS (SELECT Type FROM MinorCivilizations WHERE Type = 'MINOR_CIV_CAHOKIA');

-- Civilizations_YagemStartPosition (Earth Giant)
CREATE TABLE IF NOT EXISTS MinorCiv_YagemStartPosition(Type, X, Y, AltX, AltY);	
DELETE FROM MinorCiv_YagemStartPosition WHERE Type IN ('MINOR_CIV_CAHOKIA');

INSERT INTO MinorCiv_YagemStartPosition
			(Type,										X,		Y,		AltX,	AltY)
VALUES		('MINOR_CIV_CAHOKIA',				  135,	   63,		null,	null);

-- Civilizations_YahemStartPosition (Earth Huge)
CREATE TABLE IF NOT EXISTS MinorCiv_YahemStartPosition(Type, X, Y, AltX, AltY);
DELETE FROM MinorCiv_YahemStartPosition WHERE Type IN ('MINOR_CIV_CAHOKIA');	
	
INSERT INTO MinorCiv_YahemStartPosition
			(Type,										X,		Y,		AltX,	AltY)
VALUES		('MINOR_CIV_CAHOKIA',				   17,	   53,		null,	null);

-- Civilizations_CordiformStartPosition (Earth Standard)
CREATE TABLE IF NOT EXISTS MinorCiv_CordiformStartPosition(Type, X, Y, AltX, AltY);
DELETE FROM MinorCiv_CordiformStartPosition WHERE Type IN ('MINOR_CIV_CAHOKIA');	
	
INSERT INTO MinorCiv_CordiformStartPosition
			(Type,										X,		Y,		AltX,	AltY)
VALUES		('MINOR_CIV_CAHOKIA',				    8,	   35,		null,	null);

-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
CREATE TABLE IF NOT EXISTS MinorCiv_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
DELETE FROM MinorCiv_GreatestEarthStartPosition WHERE Type IN ('MINOR_CIV_CAHOKIA');	
	
INSERT INTO MinorCiv_GreatestEarthStartPosition
			(Type,										X,		Y,		AltX,	AltY)
VALUES		('MINOR_CIV_CAHOKIA',				    7,	   44,		null,	null);

-- Civilizations_EuroLargeStartPosition (Europe Large)
CREATE TABLE IF NOT EXISTS MinorCiv_EuroLargeStartPosition(Type, X, Y, AltX, AltY);		
DELETE FROM MinorCiv_EuroLargeStartPosition WHERE Type IN ('MINOR_CIV_CAHOKIA');	

-- Civilizations_EuroLargeStartPosition (Europe Giant)
CREATE TABLE IF NOT EXISTS MinorCiv_EuroGiantStartPosition(Type, X, Y, AltX, AltY);
DELETE FROM MinorCiv_EuroGiantStartPosition WHERE Type IN ('MINOR_CIV_CAHOKIA');	

-- Civilizations_MesopotamiaStartPosition (Mesopotamia)
CREATE TABLE IF NOT EXISTS MinorCiv_MesopotamiaStartPosition(Type, X, Y, AltX, AltY);
DELETE FROM MinorCiv_MesopotamiaStartPosition WHERE Type IN ('MINOR_CIV_CAHOKIA');

-- Civilizations_NorthWestEuropeStartPosition (NW Europe)
CREATE TABLE IF NOT EXISTS MinorCiv_NorthWestEuropeStartPosition(Type, X, Y, AltX, AltY);
DELETE FROM MinorCiv_NorthWestEuropeStartPosition WHERE Type IN ('MINOR_CIV_CAHOKIA');

-- Civilizations_MediterraneanStartPosition (Mediterranaean)
CREATE TABLE IF NOT EXISTS MinorCiv_MediterraneanStartPosition(Type, X, Y, AltX, AltY);
DELETE FROM MinorCiv_MediterraneanStartPosition WHERE Type IN ('MINOR_CIV_CAHOKIA');

-- Civilizations_BritishIslesStartPosition (British Isles)
CREATE TABLE IF NOT EXISTS MinorCiv_BritishIslesStartPosition(Type, X, Y, AltX, AltY);
DELETE FROM MinorCiv_BritishIslesStartPosition WHERE Type IN ('MINOR_CIV_CAHOKIA');

-- Civilizations_AmericaStandardStartPosition
CREATE TABLE IF NOT EXISTS MinorCiv_AmericaStandardStartPosition(Type, X, Y, AltX, AltY);	
DELETE FROM MinorCiv_AmericaStandardStartPosition WHERE Type IN ('MINOR_CIV_CAHOKIA');

-- Civilizations_NorthEastAsiaStartPosition
CREATE TABLE IF NOT EXISTS MinorCiv_NorthEastAsiaStartPosition(Type, X, Y, AltX, AltY);	
DELETE FROM MinorCiv_NorthEastAsiaStartPosition WHERE Type IN ('MINOR_CIV_CAHOKIA');

-- Civilizations_PacificStartPosition
CREATE TABLE IF NOT EXISTS MinorCiv_PacificStartPosition(Type, X, Y, AltX, AltY);	
DELETE FROM MinorCiv_PacificStartPosition WHERE Type IN ('MINOR_CIV_CAHOKIA');

-- Civilizations_EastAsiaStartPosition
CREATE TABLE IF NOT EXISTS MinorCiv_EastAsiaStartPosition(Type, X, Y, AltX, AltY);	
DELETE FROM MinorCiv_EastAsiaStartPosition WHERE Type IN ('MINOR_CIV_CAHOKIA');

-- Civilizations_SouthPacificStartPosition
CREATE TABLE IF NOT EXISTS MinorCiv_SouthPacificStartPosition(Type, X, Y, AltX, AltY);	
DELETE FROM MinorCiv_SouthPacificStartPosition WHERE Type IN ('MINOR_CIV_CAHOKIA');

-- Civilizations_AegeanStartPosition
CREATE TABLE IF NOT EXISTS MinorCiv_AegeanStartPosition(Type, X, Y, AltX, AltY);	
DELETE FROM MinorCiv_AegeanStartPosition WHERE Type IN ('MINOR_CIV_CAHOKIA');

-- Civilizations_AfricaLargeStartPosition
CREATE TABLE IF NOT EXISTS MinorCiv_AfricaLargeStartPosition(Type, X, Y, AltX, AltY);	
DELETE FROM MinorCiv_AfricaLargeStartPosition WHERE Type IN ('MINOR_CIV_CAHOKIA');

-- Civilizations_AmericasStartPosition
CREATE TABLE IF NOT EXISTS MinorCiv_AmericasStartPosition(Type, X, Y, AltX, AltY);	
DELETE FROM MinorCiv_AmericasStartPosition WHERE Type IN ('MINOR_CIV_CAHOKIA');

INSERT INTO MinorCiv_AmericasStartPosition
			(Type,										X,		Y,		AltX,	AltY)
VALUES		('MINOR_CIV_CAHOKIA',				   34,	   53,		null,	null);

-- Civilizations_ApennineStartPosition
CREATE TABLE IF NOT EXISTS MinorCiv_ApennineStartPosition(Type, X, Y, AltX, AltY);	
DELETE FROM MinorCiv_ApennineStartPosition WHERE Type IN ('MINOR_CIV_CAHOKIA');

-- Civilizations_AsiaStartPosition
CREATE TABLE IF NOT EXISTS MinorCiv_AsiaStartPosition(Type, X, Y, AltX, AltY);	
DELETE FROM MinorCiv_AsiaStartPosition WHERE Type IN ('MINOR_CIV_CAHOKIA');

-- Civilizations_CaribbeanStartPosition
CREATE TABLE IF NOT EXISTS MinorCiv_CaribbeanStartPosition(Type, X, Y, AltX, AltY);	
DELETE FROM MinorCiv_CaribbeanStartPosition WHERE Type IN ('MINOR_CIV_CAHOKIA');

INSERT INTO MinorCiv_CaribbeanStartPosition
			(Type,										X,		Y,		AltX,	AltY)
VALUES		('MINOR_CIV_CAHOKIA',				    0,	   69,		null,	null);

-- Civilizations_NileValleyStartPosition
CREATE TABLE IF NOT EXISTS MinorCiv_NileValleyStartPosition(Type, X, Y, AltX, AltY);	
DELETE FROM MinorCiv_NileValleyStartPosition WHERE Type IN ('MINOR_CIV_CAHOKIA');

-- Civilizations_NorthAtlanticStartPosition
CREATE TABLE IF NOT EXISTS MinorCiv_NorthAtlanticStartPosition(Type, X, Y, AltX, AltY);	
DELETE FROM MinorCiv_NorthAtlanticStartPosition WHERE Type IN ('MINOR_CIV_CAHOKIA');
