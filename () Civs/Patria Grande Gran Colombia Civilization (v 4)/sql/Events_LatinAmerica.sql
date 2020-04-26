--==========================================================================================================================	
-- EVENTS
--==========================================================================================================================	
-- Leugi_Independence
--------------------------------

CREATE TABLE IF NOT EXISTS Leugi_Independence (
		CivilizationType				text														default null,
		LibertadorType					text														default 'UNIT_PG_LIBERTADOR',
		SupportUnit						text														default 'UNIT_RIFLEMAN');


INSERT OR REPLACE INTO Leugi_Independence
		(CivilizationType,					LibertadorType,					SupportUnit)
VALUES	('CIVILIZATION_PG_GRANCOLOMBIA',	'UNIT_PG_LIBERTADOR',			'UNIT_PG_LLANERO'),
		('CIVILIZATION_PG_RIODELAPLATA',	'UNIT_PG_LIBERTADOR',			'UNIT_PG_GRANADERO'),
		('CIVILIZATION_PG_ARGENTINA',		'UNIT_PG_LIBERTADOR',			'UNIT_PG_GAUCHO'),
		('CIVILIZATION_PG_BOLIVIA',			'UNIT_PG_LIBERTADOR',			'UNIT_PG_COLORADO'),
		('CIVILIZATION_PG_PERU',			'UNIT_PG_LIBERTADOR',			'UNIT_PG_HUSARES_DE_JUNIN'),
		('CIVILIZATION_PG_CHILE',			'UNIT_PG_LIBERTADOR',			'UNIT_RIFLEMAN'),
		('CIVILIZATION_PG_PARAGUAY',		'UNIT_PG_LIBERTADOR',			'UNIT_PG_ACA_CARAYA'),
		('CIVILIZATION_PG_CUBA',			'UNIT_PG_REVOLUCIONARIO',		'UNIT_RIFLEMAN'),
		('CIVILIZATION_PG_HAITI',			'UNIT_PG_LIBERTADOR',			'UNIT_PG_MAWON'),
		('CIVILIZATION_ARGENTINA',			'UNIT_PG_LIBERTADOR',			'UNIT_GAUCHO'),
		('CIVILIZATION_BOLIVIA',			'UNIT_PG_LIBERTADOR',			'UNIT_COLORADO'),
		('CIVILIZATION_PERU',				'UNIT_PG_LIBERTADOR',			'UNIT_HUSARES_DE_JUNIN'),
		('CIVILIZATION_CHILE',				'UNIT_PG_LIBERTADOR',			'UNIT_RIFLEMAN'),
		('CIVILIZATION_PARAGUAY',			'UNIT_PG_LIBERTADOR',			'UNIT_ACA_CARAYA'),
		('CIVILIZATION_LEUGI_CUBA',			'UNIT_CUBAN_REVOLUCIONARIO',	'UNIT_RIFLEMAN'),
		('CIVILIZATION_LEUGI_HAITI',		'UNIT_LEUGI_HOUNGAN',			'UNIT_LEUGI_MAWON');

--==========================================================================================================================
--==========================================================================================================================