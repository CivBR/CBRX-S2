--==========================================================================================================================
-- TECHNOLOGIES
--==========================================================================================================================	
--------------------------------------------------------------------------------------------------------------------------
-- Technologies
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Technologies 
		(Type, 						Cost, 	OpenBordersTradingAllowed,	Description, 							Civilopedia,							Help, 									Era,				Trade,	GoodyTech,	GridX,	GridY,	Quote,									PortraitIndex,	IconAtlas)
VALUES	('TECH_JFD_CODE_OF_LAWS', 	105, 	0,							'TXT_KEY_TECH_JFD_CODE_OF_LAWS_TITLE',	'TXT_KEY_TECH_JFD_CODE_OF_LAWS_DESC',	'TXT_KEY_TECH_JFD_CODE_OF_LAWS_HELP',	'ERA_CLASSICAL',	1,		0,			3,		2,		'TXT_KEY_TECH_JFD_CODE_OF_LAWS_QUOTE',	0,				'JFD_SOVEREIGNTY_TECH_ATLAS'),
		('TECH_JFD_JURISPRUDENCE', 	700, 	0,							'TXT_KEY_TECH_JFD_JURISPRUDENCE_TITLE',	'TXT_KEY_TECH_JFD_JURISPRUDENCE_DESC',	'TXT_KEY_TECH_JFD_JURISPRUDENCE_HELP',	'ERA_RENAISSANCE',	1,		0,			8,		6,		'TXT_KEY_TECH_JFD_JURISPRUDENCE_QUOTE',	1,				'JFD_SOVEREIGNTY_TECH_ATLAS'),
		('TECH_JFD_NOBILITY', 		275, 	1,							'TXT_KEY_TECH_JFD_NOBILITY_TITLE',		'TXT_KEY_TECH_JFD_NOBILITY_DESC',		'TXT_KEY_TECH_JFD_NOBILITY_HELP',		'ERA_MEDIEVAL',		1,		0,			5,		5,		'TXT_KEY_TECH_JFD_NOBILITY_QUOTE',		2,				'JFD_SOVEREIGNTY_TECH_ATLAS');

UPDATE Technologies
SET OpenBordersTradingAllowed = 0
WHERE Type IN ('TECH_CIVIL_SERVICE', 'TECH_GUILDS');

UPDATE Technologies 
SET GridY = 5 
WHERE Type = 'TECH_CURRENCY';
------------------------------------------------------------------------------------------------------------------------		
-- Technology_PrereqTechs
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Technologies_JFD_MiscEffects
		(TechType,					UnlockQuery,			EffectToolTip)
VALUES	('TECH_JFD_CODE_OF_LAWS',	'AllowGovernments',		'TXT_KEY_TECH_JFD_CODE_OF_LAWS_EFFECT');	
------------------------------------------------------------------------------------------------------------------------		
-- Technology_PrereqTechs
------------------------------------------------------------------------------------------------------------------------	
DELETE FROM Technology_PrereqTechs WHERE TechType = 'TECH_PHILOSOPHY' AND PrereqTech = 'TECH_CALENDAR';
INSERT INTO Technology_PrereqTechs 
		(TechType, 					PrereqTech)
VALUES	('TECH_CHIVALRY', 			'TECH_JFD_NOBILITY'),
		('TECH_JFD_CODE_OF_LAWS', 	'TECH_WRITING'),
		('TECH_JFD_JURISPRUDENCE', 	'TECH_PRINTING_PRESS'),
		('TECH_JFD_NOBILITY', 		'TECH_CURRENCY'),
		('TECH_RIFLING', 			'TECH_JFD_JURISPRUDENCE');

UPDATE Technology_PrereqTechs
SET PrereqTech = 'TECH_JFD_CODE_OF_LAWS'
WHERE TechType = 'TECH_PHILOSOPHY' AND PrereqTech = 'TECH_WRITING';

UPDATE Technology_PrereqTechs
SET PrereqTech = 'TECH_JFD_CODE_OF_LAWS'
WHERE TechType = 'TECH_DRAMA' AND PrereqTech = 'TECH_WRITING';

DELETE FROM Technology_PrereqTechs WHERE PrereqTech = 'TECH_JFD_JURISPRUDENCE' AND EXISTS (SELECT * FROM Technologies WHERE Type = 'TECH_EE_SOVEREIGNTY');
INSERT INTO Technology_PrereqTechs 
		(TechType, 			PrereqTech)
SELECT	'TECH_ECONOMICS', 	'TECH_JFD_JURISPRUDENCE'
WHERE EXISTS (SELECT * FROM Technologies WHERE Type = 'TECH_EE_SOVEREIGNTY');	
------------------------------------------------------------------------------------------------------------------------		
-- Technology_Flavors
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Technology_Flavors 
		(TechType, 					FlavorType,						Flavor)
VALUES	('TECH_JFD_CODE_OF_LAWS', 	'FLAVOR_HAPPINESS',				2),
		('TECH_JFD_CODE_OF_LAWS', 	'FLAVOR_WONDER',				2),
		('TECH_JFD_CODE_OF_LAWS', 	'FLAVOR_CULTURE',				4),
		('TECH_JFD_CODE_OF_LAWS', 	'FLAVOR_SCIENCE',				4),
		('TECH_JFD_CODE_OF_LAWS', 	'FLAVOR_MILITARY_TRAINING',		2),
		('TECH_JFD_CODE_OF_LAWS', 	'FLAVOR_RELIGION',				2),
		('TECH_JFD_JURISPRUDENCE', 	'FLAVOR_ESPIONAGE',				10),
		('TECH_JFD_JURISPRUDENCE', 	'FLAVOR_HAPPINESS',				2),
		('TECH_JFD_JURISPRUDENCE', 	'FLAVOR_WONDER',				5),
		('TECH_JFD_JURISPRUDENCE', 	'FLAVOR_CULTURE',				2),
		('TECH_JFD_JURISPRUDENCE', 	'FLAVOR_PRODUCTION',			2),
		('TECH_JFD_NOBILITY', 		'FLAVOR_CULTURE',				1),
		('TECH_JFD_NOBILITY', 		'FLAVOR_PRODUCTION',			1),
		('TECH_JFD_NOBILITY', 		'FLAVOR_WONDER',				2),
		('TECH_JFD_NOBILITY', 		'FLAVOR_GOLD',					3),
		('TECH_JFD_NOBILITY', 		'FLAVOR_MILITARY_TRAINING',		2);
--==========================================================================================================================
--==========================================================================================================================