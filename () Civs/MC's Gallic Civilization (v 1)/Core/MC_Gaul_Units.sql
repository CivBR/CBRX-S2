--==========================================================================================================================	
-- Units
--==========================================================================================================================
INSERT INTO Units 	
			(Class, 	Type, 						PrereqTech, Combat, 	Cost, 	FaithCost,	RequiresFaithPurchaseEnabled,	Moves, 	CombatClass, Domain, DefaultUnitAI, Description, 							Civilopedia, 								Strategy, 										Help, 										MilitarySupport, MilitaryProduction, Pillage, IgnoreBuildingDefense, AdvancedStartCost, CombatLimit, ObsoleteTech, 	XPValueAttack, XPValueDefense, GoodyHutUpgradeUnitClass, UnitArtInfo, 								UnitFlagIconOffset, 					UnitFlagAtlas,								PortraitIndex, 	IconAtlas,			MoveRate)
SELECT		Class, 		('UNIT_MC_GAUL_OATHSWORN'), PrereqTech, Combat+1,	Cost, 	FaithCost,	RequiresFaithPurchaseEnabled,	Moves, 	CombatClass, Domain, DefaultUnitAI, ('TXT_KEY_UNIT_MC_GAUL_OATHSWORN'), 	('TXT_KEY_CIV5_MC_GAUL_OATHSWORN_TEXT'), 	('TXT_KEY_UNIT_MC_GAUL_OATHSWORN_STRATEGY'), 	('TXT_KEY_UNIT_HELP_MC_GAUL_OATHSWORN'),  	MilitarySupport, MilitaryProduction, Pillage, IgnoreBuildingDefense, AdvancedStartCost, CombatLimit, ObsoleteTech,	XPValueAttack, XPValueDefense, GoodyHutUpgradeUnitClass, ('ART_DEF_UNIT_MC_GAUL_OATHSWORN'),		0,										('UNIT_FLAG_MC_GAUL_OATHSWORN_ATLAS'),		2, 				('MC_GAUL_ATLAS'),	MoveRate
FROM Units WHERE (Type = 'UNIT_SWORDSMAN');
--==========================================================================================================================	
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================		
INSERT INTO Unit_ResourceQuantityRequirements 	
			(UnitType, 						ResourceType)
SELECT		('UNIT_MC_GAUL_OATHSWORN'), 	ResourceType
FROM Unit_ResourceQuantityRequirements WHERE (UnitType = 'UNIT_SWORDSMAN');	
--==========================================================================================================================	
-- UnitGameplay2DScripts
--==========================================================================================================================		
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 						SelectionSound, FirstSelectionSound)
SELECT		('UNIT_MC_GAUL_OATHSWORN'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_SWORDSMAN');
--==========================================================================================================================	
-- Unit_AITypes
--==========================================================================================================================		
INSERT INTO Unit_AITypes 	
			(UnitType, 						UnitAIType)
SELECT		('UNIT_MC_GAUL_OATHSWORN'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_SWORDSMAN');	
--==========================================================================================================================	
-- Unit_ClassUpgrades
--==========================================================================================================================	
INSERT INTO Unit_ClassUpgrades 	
			(UnitType, 					UnitClassType)
SELECT		('UNIT_MC_GAUL_OATHSWORN'),	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_SWORDSMAN');	
--==========================================================================================================================	
-- Unit_Flavors
--==========================================================================================================================		
INSERT INTO Unit_Flavors 	
			(UnitType, 						FlavorType, Flavor)
SELECT		('UNIT_MC_GAUL_OATHSWORN'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_SWORDSMAN');	
--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 							PromotionType)
SELECT		('UNIT_MC_GAUL_OATHSWORN'), 		PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_SWORDSMAN');

INSERT INTO Unit_FreePromotions
			(UnitType, 					PromotionType)
VALUES		('UNIT_MC_GAUL_OATHSWORN', 	'PROMOTION_MC_GAUL_OATHSWORN');
--==========================================================================================================================		
--==========================================================================================================================