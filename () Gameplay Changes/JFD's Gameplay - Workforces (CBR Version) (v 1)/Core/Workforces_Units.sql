--==========================================================================================================================
-- UNITS
--==========================================================================================================================
-- UnitPromotions
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO UnitPromotions	
		(Type, 											UpgradeDiscount,	IsBuildCharge,	Description, 										Help, 														Sound, 				CannotBeChosen, PortraitIndex,	IconAtlas, 			PediaType, 			PediaEntry)
VALUES	('PROMOTION_JFD_BUILD_CHARGE_0', 				0,					0,				'TXT_KEY_PROMOTION_JFD_BUILD_CHARGE',				'TXT_KEY_PROMOTION_JFD_BUILD_CHARGE_HELP',					'AS2D_IF_LEVELUP',	1, 				57, 			'ABILITY_ATLAS',	'PEDIA_SHARED',		'TXT_KEY_PROMOTION_JFD_BUILD_CHARGE'),
		('PROMOTION_JFD_BUILD_CHARGE_1', 				0,					1,				'TXT_KEY_PROMOTION_JFD_BUILD_CHARGE',				'TXT_KEY_PROMOTION_JFD_BUILD_CHARGE_HELP',					'AS2D_IF_LEVELUP',	1, 				57, 			'ABILITY_ATLAS',	'PEDIA_SHARED',		'TXT_KEY_PROMOTION_JFD_BUILD_CHARGE'),
		('PROMOTION_JFD_BUILD_CHARGE_2', 				0,					1,				'TXT_KEY_PROMOTION_JFD_BUILD_CHARGE',				'TXT_KEY_PROMOTION_JFD_BUILD_CHARGE_HELP',					'AS2D_IF_LEVELUP',	1, 				57, 			'ABILITY_ATLAS',	'PEDIA_SHARED',		'TXT_KEY_PROMOTION_JFD_BUILD_CHARGE'),
		('PROMOTION_JFD_BUILD_CHARGE_3', 				0,					1,				'TXT_KEY_PROMOTION_JFD_BUILD_CHARGE',				'TXT_KEY_PROMOTION_JFD_BUILD_CHARGE_HELP',					'AS2D_IF_LEVELUP',	1, 				57, 			'ABILITY_ATLAS',	'PEDIA_SHARED',		'TXT_KEY_PROMOTION_JFD_BUILD_CHARGE'),
		('PROMOTION_JFD_BUILD_CHARGE_4', 				0,					1,				'TXT_KEY_PROMOTION_JFD_BUILD_CHARGE',				'TXT_KEY_PROMOTION_JFD_BUILD_CHARGE_HELP',					'AS2D_IF_LEVELUP',	1, 				57, 			'ABILITY_ATLAS',	'PEDIA_SHARED',		'TXT_KEY_PROMOTION_JFD_BUILD_CHARGE'),
		('PROMOTION_JFD_BUILD_CHARGE_5', 				0,					1,				'TXT_KEY_PROMOTION_JFD_BUILD_CHARGE',				'TXT_KEY_PROMOTION_JFD_BUILD_CHARGE_HELP',					'AS2D_IF_LEVELUP',	1, 				57, 			'ABILITY_ATLAS',	'PEDIA_SHARED',		'TXT_KEY_PROMOTION_JFD_BUILD_CHARGE'),
		('PROMOTION_JFD_BUILD_CHARGE_6', 				0,					1,				'TXT_KEY_PROMOTION_JFD_BUILD_CHARGE',				'TXT_KEY_PROMOTION_JFD_BUILD_CHARGE_HELP',					'AS2D_IF_LEVELUP',	1, 				57, 			'ABILITY_ATLAS',	'PEDIA_SHARED',		'TXT_KEY_PROMOTION_JFD_BUILD_CHARGE'),
		('PROMOTION_JFD_BUILD_CHARGE_7', 				0,					1,				'TXT_KEY_PROMOTION_JFD_BUILD_CHARGE',				'TXT_KEY_PROMOTION_JFD_BUILD_CHARGE_HELP',					'AS2D_IF_LEVELUP',	1, 				57, 			'ABILITY_ATLAS',	'PEDIA_SHARED',		'TXT_KEY_PROMOTION_JFD_BUILD_CHARGE'),
		('PROMOTION_JFD_BUILD_CHARGE_8', 				0,					1,				'TXT_KEY_PROMOTION_JFD_BUILD_CHARGE',				'TXT_KEY_PROMOTION_JFD_BUILD_CHARGE_HELP',					'AS2D_IF_LEVELUP',	1, 				57, 			'ABILITY_ATLAS',	'PEDIA_SHARED',		'TXT_KEY_PROMOTION_JFD_BUILD_CHARGE'),
		('PROMOTION_JFD_BUILD_CHARGE_9', 				0,					1,				'TXT_KEY_PROMOTION_JFD_BUILD_CHARGE',				'TXT_KEY_PROMOTION_JFD_BUILD_CHARGE_HELP',					'AS2D_IF_LEVELUP',	1, 				57, 			'ABILITY_ATLAS',	'PEDIA_SHARED',		'TXT_KEY_PROMOTION_JFD_BUILD_CHARGE'),
		('PROMOTION_JFD_BUILD_CHARGE_10', 				0,					1,				'TXT_KEY_PROMOTION_JFD_BUILD_CHARGE',				'TXT_KEY_PROMOTION_JFD_BUILD_CHARGE_HELP',					'AS2D_IF_LEVELUP',	1, 				57, 			'ABILITY_ATLAS',	'PEDIA_SHARED',		'TXT_KEY_PROMOTION_JFD_BUILD_CHARGE'),
		('PROMOTION_JFD_BUILD_CHARGE_11', 				0,					1,				'TXT_KEY_PROMOTION_JFD_BUILD_CHARGE',				'TXT_KEY_PROMOTION_JFD_BUILD_CHARGE_HELP',					'AS2D_IF_LEVELUP',	1, 				57, 			'ABILITY_ATLAS',	'PEDIA_SHARED',		'TXT_KEY_PROMOTION_JFD_BUILD_CHARGE'),
		('PROMOTION_JFD_BUILD_CHARGE_12', 				0,					1,				'TXT_KEY_PROMOTION_JFD_BUILD_CHARGE',				'TXT_KEY_PROMOTION_JFD_BUILD_CHARGE_HELP',					'AS2D_IF_LEVELUP',	1, 				57, 			'ABILITY_ATLAS',	'PEDIA_SHARED',		'TXT_KEY_PROMOTION_JFD_BUILD_CHARGE'),
		('PROMOTION_JFD_WORKFORCE_UPGRADE_DISCOUNT', 	50,					0,				'TXT_KEY_PROMOTION_JFD_WORKFORCE_UPGRADE_DISCOUNT',	'TXT_KEY_PROMOTION_JFD_WORKFORCE_UPGRADE_DISCOUNT_HELP',	'AS2D_IF_LEVELUP',	1, 				59, 			'ABILITY_ATLAS',	'PEDIA_SHARED',		'TXT_KEY_PROMOTION_JFD_WORKFORCE_UPGRADE_DISCOUNT');
------------------------------------------------------------------------------------------------------------------------
-- UnitPromotions_Hide
------------------------------------------------------------------------------------------------------------------------
INSERT INTO UnitPromotions_Hide
		(PromotionType,		EnemyUnitPanel,	UnitPanel)
SELECT   Type,				1,				1
FROM UnitPromotions WHERE IsBuildCharge = 1;

INSERT INTO UnitPromotions_Hide
		(PromotionType,									UnitPanel,	EnemyUnitPanel)
VALUES	('PROMOTION_JFD_BUILD_CHARGE_0',				1,			1),
		('PROMOTION_JFD_WORKFORCE_UPGRADE_DISCOUNT',	1,			1);
------------------------------------------------------------------------------------------------------------------------
-- JFD_Civilopedia_HideFromPedia
------------------------------------------------------------------------------------------------------------------------
INSERT INTO JFD_Civilopedia_HideFromPedia
		(Type)
SELECT   Type
FROM UnitPromotions WHERE IsBuildCharge = 1;

INSERT INTO JFD_Civilopedia_HideFromPedia
		(Type)
VALUES	('PROMOTION_JFD_BUILD_CHARGE_0'),
		('PROMOTION_JFD_WORKFORCE_UPGRADE_DISCOUNT');
--------------------------------------------------------------------------------------------------------------------------
-- UnitClasses
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO UnitClasses 
		(Type,						Description,				 DefaultUnit)
VALUES	('UNITCLASS_JFD_WORKFORCE',	'TXT_KEY_UNIT_JFD_WORKFORCE', 	 'UNIT_JFD_WORKFORCE');	
--------------------------------------------------------------------------------------------------------------------------
-- UnitClass_JFD_BuildCharges
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO UnitClass_JFD_BuildCharges
		(UnitClassType,				NumCharges)
VALUES	('UNITCLASS_WORKER',		6),
		('UNITCLASS_JFD_WORKFORCE',	9),
		('UNITCLASS_WORKBOAT',		1);
--------------------------------------------------------------------------------------------------------------------------
-- Units
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Units 
		(Type,					Class,						WorkRate,	CivilianAttackPriority, 		 Cost,	FaithCost,	PrereqTech,					ExtraMaintenanceCost,	Moves,	Capture, 					 Domain,		DefaultUnitAI,		Description,					Strategy,								Help,								Civilopedia,						UnitArtInfo,					IconAtlas,			AdvancedStartCost, 		PortraitIndex,	UnitFlagAtlas,		UnitFlagIconOffset,	MoveRate)
VALUES	('UNIT_JFD_WORKFORCE',	'UNITCLASS_JFD_WORKFORCE',	150,		'CIVILIAN_ATTACK_PRIORITY_LOW',	 300,	0,			'TECH_INDUSTRIALIZATION',	1,						2,		'UNITCLASS_JFD_WORKFORCE',	 'DOMAIN_LAND',	'UNITAI_WORKER',	'TXT_KEY_UNIT_JFD_WORKFORCE',	'TXT_KEY_UNIT_JFD_WORKFORCE_STRATEGY',	'TXT_KEY_UNIT_HELP_JFD_WORKFORCE', 	'TXT_KEY_CIV5_JFD_WORKFORCE_TEXT',	'ART_DEF_UNIT_JFD_WORKFORCE',	'UNIT_ATLAS_2',		35,						43,				'UNIT_FLAG_ATLAS',	1,					'BIPED');

--Peasant
UPDATE Units
SET Help = 'TXT_KEY_UNIT_WORKER_HELP_JFD_WORKFORCES', Strategy = 'TXT_KEY_UNIT_WORKER_STRATEGY_JFD_WORKFORCES', Capture = 'UNITCLASS_WORKER'
WHERE Type = 'UNIT_WORKER';

--Worker
UPDATE Units
SET Cost = 50, UnitArtInfoEraVariation = 1, ExtraMaintenanceCost = 0, ObsoleteTech = 'TECH_INDUSTRIALIZATION', PrereqTech = 'TECH_AGRICULTURE', WorkRate = 75
WHERE Class = 'UNITCLASS_WORKER';

--JFD_Builders_Units
CREATE TRIGGER JFD_Builders_Units
AFTER INSERT ON Units
WHEN NEW.Class = 'UNITCLASS_WORKER'
BEGIN
	UPDATE Units
	SET Cost = 50, UnitArtInfoEraVariation = 1, ExtraMaintenanceCost = 0, ObsoleteTech = 'TECH_INDUSTRIALIZATION', PrereqTech = 'TECH_AGRICULTURE', WorkRate = 75
	WHERE NEW.Class = 'UNITCLASS_WORKER';
END;
--------------------------------------------------------------------------------------------------------------------------
-- Unit_JFD_BuildCharges
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_JFD_BuildCharges
		(UnitType,				NumCharges)
VALUES	('UNIT_ROMAN_LEGION',	3);
--------------------------------------------------------------------------------------------------------------------------
-- UnitGameplay2DScripts
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 				SelectionSound,	FirstSelectionSound)
SELECT	'UNIT_JFD_WORKFORCE',	SelectionSound,	FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_WORKER';
--------------------------------------------------------------------------------------------------------------------------
-- Unit_ClassUpgrades
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_ClassUpgrades
		(UnitType, 			UnitClassType)
VALUES	('UNIT_WORKER',		'UNITCLASS_JFD_WORKFORCE');
--------------------------------------------------------------------------------------------------------------------------
-- Unit_AITypes
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_AITypes 
		(UnitType,				UnitAIType)
SELECT	'UNIT_JFD_WORKFORCE',	UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_WORKER';
--------------------------------------------------------------------------------------------------------------------------
-- Unit_Flavors
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_Flavors 
		(UnitType,				FlavorType,	 Flavor)
SELECT	'UNIT_JFD_WORKFORCE',	FlavorType,	 Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_WORKER';
--------------------------------------------------------------------------------------------------------------------------
-- Unit_FreePromotions
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_FreePromotions 	
		(UnitType, 		 PromotionType)
VALUES	('UNIT_WORKER',	 'PROMOTION_JFD_WORKFORCE_UPGRADE_DISCOUNT');
--------------------------------------------------------------------------------------------------------------------------
-- Unit_Builds
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_Builds 
		(UnitType,				BuildType)
SELECT	'UNIT_JFD_WORKFORCE',	BuildType
FROM Unit_Builds WHERE UnitType = 'UNIT_WORKER';

--JFD_Builders_Unit_Builds
CREATE TRIGGER JFD_Builders_Unit_Builds
AFTER INSERT ON Builds 
BEGIN
	INSERT INTO Unit_Builds 
			(UnitType,				BuildType)
	SELECT	'UNIT_JFD_WORKFORCE',	BuildType
	FROM Unit_Builds WHERE BuildType = NEW.Type AND UnitType = 'UNIT_WORKER';
END;

DELETE FROM Unit_Builds 
WHERE UnitType = 'UNIT_WORKER' AND BuildType = 'BUILD_RAILROAD';
--==========================================================================================================================
--==========================================================================================================================