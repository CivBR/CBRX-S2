--==========================================================================================================================	
-- UNITS
--==========================================================================================================================	
-- UnitClasses
--------------------------------------------------------------------------------------------------------------------------	
INSERT OR REPLACE INTO UnitClasses 	
		(Type, 									Description, 							 DefaultUnit)
VALUES	('UNITCLASS_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_UNIT_JFD_GREAT_REVOLUTIONARY',  'UNIT_JFD_GREAT_REVOLUTIONARY');
--------------------------------------------------------------------------------------------------------------------------	
-- UNITS
--------------------------------------------------------------------------------------------------------------------------
INSERT OR REPLACE INTO Units 	
		(Type, 							Class,								 IsNotFreeChoice,	CultureBombRadius, WorkRate,	DontShowYields, Cost, Moves, FaithCost, CivilianAttackPriority, Special, MoveAfterPurchase, Domain, DefaultUnitAI, Description, 								Civilopedia, 								  Strategy,											UnitArtInfoEraVariation,	AdvancedStartCost,	CombatLimit, UnitArtInfo, 								UnitFlagIconOffset,	UnitFlagAtlas,									MoveRate, PortraitIndex, 	IconAtlas)
SELECT	'UNIT_JFD_GREAT_REVOLUTIONARY',	'UNITCLASS_JFD_GREAT_REVOLUTIONARY', 1,					2,					0,			DontShowYields, Cost, Moves, FaithCost, CivilianAttackPriority, Special, MoveAfterPurchase, Domain, DefaultUnitAI, 'TXT_KEY_UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_CIV5_JFD_GREAT_REVOLUTIONARY_TEXT',  'TXT_KEY_UNIT_JFD_GREAT_REVOLUTIONARY_STRATEGY',	1,							AdvancedStartCost,  CombatLimit, 'ART_DEF_UNIT_JFD_GREAT_REVOLUTIONARY',	0,					'JFD_GREAT_REVOLUTIONARIES_UNIT_FLAG_ATLAS',	MoveRate, 0, 				'JFD_GREAT_REVOLUTIONARIES_ICON_ATLAS'
FROM Units WHERE Type = 'UNIT_ARTIST';
--------------------------------------------------------------------------------------------------------------------------	
-- UnitGameplay2DScripts
--------------------------------------------------------------------------------------------------------------------------	
INSERT OR REPLACE INTO UnitGameplay2DScripts 	
		(UnitType, 							SelectionSound,	FirstSelectionSound)
SELECT	'UNIT_JFD_GREAT_REVOLUTIONARY', 	SelectionSound,	FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_ARTIST';	
--------------------------------------------------------------------------------------------------------------------------		
-- Unit_AITypes
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_AITypes 	
		(UnitType, 						UnitAIType)
SELECT	'UNIT_JFD_GREAT_REVOLUTIONARY',	UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_ARTIST';	
--------------------------------------------------------------------------------------------------------------------------	
-- Unit_Flavors
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_Flavors 	
		(UnitType, 							FlavorType,	 Flavor)
SELECT	'UNIT_JFD_GREAT_REVOLUTIONARY', 	FlavorType,	 Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_ARTIST';
--------------------------------------------------------------------------------------------------------------------------
-- Unit_UniqueNames
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_UniqueNames 	
		(UnitType, 							UniqueName)
VALUES	('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_01'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_02'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_03'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_04'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_05'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_06'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_07'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_08'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_09'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_10'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_11'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_12'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_13'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_14'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_15'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_16'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_17'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_18'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_19'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_20'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_22'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_23'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_24'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_25'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_26'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_27'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_28'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_29'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_30'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_31'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_32'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_33'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_34'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_35'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_36'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_37'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_38'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_39'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_40'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_41'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_42'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_43'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_44'),
		('UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_GREAT_PERSON_JFD_GREAT_REVOLUTIONARY_45');
--==========================================================================================================================
--==========================================================================================================================