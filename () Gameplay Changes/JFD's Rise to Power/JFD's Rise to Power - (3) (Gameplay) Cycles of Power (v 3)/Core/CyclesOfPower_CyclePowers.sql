--==========================================================================================================================
-- CYCLED POWERS
--==========================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
-- JFD_CyclePowers
-------------------------------------------------------------------------------------------------------------------------
INSERT INTO JFD_CyclePowers
		(Type,								IsTheocracy,	AnarchyCyclePower,					NextCyclePower,						SovModifierPerCapitalPopulation,	SovModifierPerCity,		SovModifierPerCityFollowing,	SovModifierPerPopulation,	VirtueRatePerXCapitalPopulation,	VirtueRatePerXCity,	 VirtueRatePerXCityNotFollowing,	 VirtueRatePerXPopulation,	VirtueFromGoldPurchases,	VirtueFromFaithPurchases,	VirtueFromBuildingConstructions,	VirtueFromPolicyAdoptions,	VirtueFromTechUnlocks,   IsAnarchy,  ShowInCyclePowerChoice,	Description,									Help,											Strategy,											Quote,											FlavorType,			PolicyType,								CyclePowerAudio)
VALUES	('CYCLE_POWER_JFD_ANARCHY_O',		0,				'CYCLE_POWER_JFD_OLIGARCHY',		'CYCLE_POWER_JFD_DEMOCRACY',		0,									0,						0,								0,							0,									0,					 0,									 0,							0,							0,							0,									0,							0,						 1,			 0,							'TXT_KEY_CYCLE_POWER_JFD_ANARCHY_DESC',			'TXT_KEY_CYCLE_POWER_JFD_ANARCHY_HELP',			'TXT_KEY_CYCLE_POWER_JFD_ANARCHY_STRATEGY',			'TXT_KEY_CYCLE_POWER_JFD_ANARCHY_QUOTE',		null,				'POLICY_CYCLE_POWER_JFD_ANARCHY_O',		'AS2D_SOUND_JFD_ANARCHY'),
		('CYCLE_POWER_JFD_ANARCHY_A',		0,				'CYCLE_POWER_JFD_AUTOCRACY',		'CYCLE_POWER_JFD_OLIGARCHY',		0,									0,						0,								0,							0,									0,					 0,									 0,							0,							0,							0,									0,							0,						 1,			 0,							'TXT_KEY_CYCLE_POWER_JFD_ANARCHY_DESC',			'TXT_KEY_CYCLE_POWER_JFD_ANARCHY_HELP',			'TXT_KEY_CYCLE_POWER_JFD_ANARCHY_STRATEGY',			'TXT_KEY_CYCLE_POWER_JFD_ANARCHY_QUOTE',		null,				'POLICY_CYCLE_POWER_JFD_ANARCHY_A',		'AS2D_SOUND_JFD_ANARCHY'),
		('CYCLE_POWER_JFD_ANARCHY_D',		0,				'CYCLE_POWER_JFD_DEMOCRACY',		'CYCLE_POWER_JFD_AUTOCRACY',		0,									0,						0,								0,							0,									0,					 0,									 0,							0,							0,							0,									0,							0,						 1,			 0,							'TXT_KEY_CYCLE_POWER_JFD_ANARCHY_DESC',			'TXT_KEY_CYCLE_POWER_JFD_ANARCHY_HELP',			'TXT_KEY_CYCLE_POWER_JFD_ANARCHY_STRATEGY',			'TXT_KEY_CYCLE_POWER_JFD_ANARCHY_QUOTE',		null,				'POLICY_CYCLE_POWER_JFD_ANARCHY_D',		'AS2D_SOUND_JFD_ANARCHY'),
		('CYCLE_POWER_JFD_ANARCHY_T',		0,				'CYCLE_POWER_JFD_THEOCRACY',		null,								0,									0,						0,								0,							0,									0,					 0,									 0,							0,							0,							0,									0,							0,						 1,			 0,							'TXT_KEY_CYCLE_POWER_JFD_ANARCHY_DESC',			'TXT_KEY_CYCLE_POWER_JFD_ANARCHY_HELP',			'TXT_KEY_CYCLE_POWER_JFD_ANARCHY_STRATEGY',			'TXT_KEY_CYCLE_POWER_JFD_ANARCHY_QUOTE',		null,				'POLICY_CYCLE_POWER_JFD_ANARCHY_T',		'AS2D_SOUND_JFD_ANARCHY'),
		('CYCLE_POWER_JFD_AUTOCRACY',		0,				'CYCLE_POWER_JFD_ANARCHY_A',		null,								1,									0,						0,								0,							2,									0,					 0,									 0,							0,							0,							0,									0,							25,						 0,			 1,							'TXT_KEY_CYCLE_POWER_JFD_AUTOCRACY_DESC',		'TXT_KEY_CYCLE_POWER_JFD_AUTOCRACY_HELP',		'TXT_KEY_CYCLE_POWER_JFD_AUTOCRACY_STRATEGY',		'TXT_KEY_CYCLE_POWER_JFD_AUTOCRACY_QUOTE',		'FLAVOR_SCIENCE',	'POLICY_CYCLE_POWER_JFD_AUTOCRACY',		'AS2D_SOUND_JFD_CYCLE_OF_POWER'),
		('CYCLE_POWER_JFD_OLIGARCHY',		0,				'CYCLE_POWER_JFD_ANARCHY_O',		null,								0,									5,						0.50,							0,							0,									0,					 0,									 10,						0,							0,							10,									0,							0,						 0,			 1,							'TXT_KEY_CYCLE_POWER_JFD_OLIGARCHY_DESC',		'TXT_KEY_CYCLE_POWER_JFD_OLIGARCHY_HELP',		'TXT_KEY_CYCLE_POWER_JFD_OLIGARCHY_STRATEGY',		'TXT_KEY_CYCLE_POWER_JFD_OLIGARCHY_QUOTE',		'FLAVOR_GOLD',		'POLICY_CYCLE_POWER_JFD_OLIGARCHY',		'AS2D_SOUND_JFD_CYCLE_OF_POWER'),
		('CYCLE_POWER_JFD_DEMOCRACY',		0,				'CYCLE_POWER_JFD_ANARCHY_D',		null,								0,									0,						0,								0.25,						0,									1,					 0,									 0,							0,							0,							0,									25,							0,						 0,			 1,							'TXT_KEY_CYCLE_POWER_JFD_DEMOCRACY_DESC',		'TXT_KEY_CYCLE_POWER_JFD_DEMOCRACY_HELP',		'TXT_KEY_CYCLE_POWER_JFD_DEMOCRACY_STRATEGY',		'TXT_KEY_CYCLE_POWER_JFD_DEMOCRACY_QUOTE',		'FLAVOR_CULTURE',	'POLICY_CYCLE_POWER_JFD_DEMOCRACY',		'AS2D_SOUND_JFD_CYCLE_OF_POWER'),
		('CYCLE_POWER_JFD_THEOCRACY',		1,				'CYCLE_POWER_JFD_ANARCHY_T',		null,								0,									0,						0,								0,							0,									0,					 1,									 0,							0,							10,							0,									0,							0,						 0,			 1,							'TXT_KEY_CYCLE_POWER_JFD_THEOCRACY_DESC',		'TXT_KEY_CYCLE_POWER_JFD_THEOCRACY_HELP',		'TXT_KEY_CYCLE_POWER_JFD_THEOCRACY_STRATEGY',		'TXT_KEY_CYCLE_POWER_JFD_THEOCRACY_QUOTE',		null,				'POLICY_CYCLE_POWER_JFD_THEOCRACY',		'AS2D_SOUND_JFD_CYCLE_OF_POWER');

UPDATE JFD_CyclePowers
SET Help = 'TXT_KEY_CYCLE_POWER_JFD_DEMOCRACY_HELP_SOVEREIGNTY', Strategy = 'TXT_KEY_CYCLE_POWER_JFD_DEMOCRACY_STRATEGY_SOVEREIGNTY'
WHERE Type = 'CYCLE_POWER_JFD_DEMOCRACY'
AND EXISTS (SELECT Type FROM Concepts WHERE Type = 'CONCEPT_JFD_SOVEREIGNTY');

UPDATE JFD_CyclePowers
SET Help = 'TXT_KEY_CYCLE_POWER_JFD_AUTOCRACY_HELP_SOVEREIGNTY', Strategy = 'TXT_KEY_CYCLE_POWER_JFD_AUTOCRACY_STRATEGY_SOVEREIGNTY'
WHERE Type = 'CYCLE_POWER_JFD_AUTOCRACY'
AND EXISTS (SELECT Type FROM Concepts WHERE Type = 'CONCEPT_JFD_SOVEREIGNTY');

UPDATE JFD_CyclePowers
SET Help = 'TXT_KEY_CYCLE_POWER_JFD_OLIGARCHY_HELP_SOVEREIGNTY', Strategy = 'TXT_KEY_CYCLE_POWER_JFD_OLIGARCHY_STRATEGY_SOVEREIGNTY'
WHERE Type = 'CYCLE_POWER_JFD_OLIGARCHY'
AND EXISTS (SELECT Type FROM Concepts WHERE Type = 'CONCEPT_JFD_SOVEREIGNTY');

UPDATE JFD_CyclePowers
SET Help = 'TXT_KEY_CYCLE_POWER_JFD_THEOCRACY_HELP_SOVEREIGNTY', Strategy = 'TXT_KEY_CYCLE_POWER_JFD_THEOCRACY_STRATEGY_SOVEREIGNTY'
WHERE Type = 'CYCLE_POWER_JFD_THEOCRACY'
AND EXISTS (SELECT Type FROM Concepts WHERE Type = 'CONCEPT_JFD_SOVEREIGNTY');
-------------------------------------------------------------------------------------------------------------------------
-- Policies
-------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policies
		(Type,		Description)
SELECT  PolicyType,	Description
FROM JFD_CyclePowers;
-------------------------------------------------------------------------------------------------------------------------
-- Policy_YieldModifiers
-------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_YieldModifiers
		(PolicyType,							YieldType,			Yield)
VALUES	('POLICY_CYCLE_POWER_JFD_AUTOCRACY',	'YIELD_SCIENCE',	25),
		('POLICY_CYCLE_POWER_JFD_AUTOCRACY',	'YIELD_CULTURE',	-25),
		('POLICY_CYCLE_POWER_JFD_OLIGARCHY',	'YIELD_GOLD',		25),
		('POLICY_CYCLE_POWER_JFD_OLIGARCHY',	'YIELD_SCIENCE',	-25),
		('POLICY_CYCLE_POWER_JFD_DEMOCRACY',	'YIELD_CULTURE',	25),
		('POLICY_CYCLE_POWER_JFD_DEMOCRACY',	'YIELD_GOLD',		-25),
		('POLICY_CYCLE_POWER_JFD_THEOCRACY',	'YIELD_FAITH',		25);
--==========================================================================================================================
--==========================================================================================================================