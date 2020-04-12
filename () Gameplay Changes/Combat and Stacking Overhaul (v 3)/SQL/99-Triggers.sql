/*

	Combat & Stacking Overhaul - Triggers
	http://www.sqlite.org/lang_createtrigger.html
	thanks to whoward69

	To do: find out why that ******* reference is not working between C.S.O. and R.E.D. Xtended

*/

CREATE TRIGGER UpdateUnitsTable
AFTER INSERT ON Units
BEGIN

	/* "Archer" units can't attack ships */
	UPDATE Units SET RangeAttackOnlyInDomain ='1' WHERE CombatClass ='UNITCOMBAT_ARCHER' OR CombatClass ='UNITCOMBAT_RECON';

	/* Support class */
	UPDATE Units SET StackClass ='SUPPORT' WHERE CombatClass = 'UNITCOMBAT_ARCHER';
	UPDATE Units SET StackClass ='SUPPORT' WHERE Class = 'UNITCLASS_ANTI_AIRCRAFT_GUN';
	UPDATE Units SET StackClass ='SUPPORT' WHERE Class = 'UNITCLASS_MOBILE_SAM';

	/* Siege class */
	UPDATE Units SET StackClass ='SUPPORT' WHERE CombatClass = 'UNITCOMBAT_SIEGE';
	UPDATE Units SET StackClass ='SUPPORT' WHERE Type = 'UNIT_HUN_BATTERING_RAM';
	UPDATE Units SET StackClass ='SUPPORT' WHERE Type = 'UNIT_ASSYRIAN_SIEGE_TOWER';
	
	/* Sea classes */
	UPDATE Units SET StackClass ='NAVAL' WHERE CombatClass = 'UNITCOMBAT_NAVALRANGED' OR  CombatClass = 'UNITCOMBAT_NAVALMELEE';
	UPDATE Units SET StackClass ='SUBMARINE' WHERE CombatClass = 'UNITCOMBAT_SUBMARINE';

	/* Support Fire Only classes (can't do normal ranged attack) */
	UPDATE Units SET OnlySupportFire = 1 WHERE Class = 'UNITCLASS_GATLINGGUN' OR Class = 'UNITCLASS_MACHINE_GUN' OR Class = 'UNITCLASS_BAZOOKA' OR Class = 'UNITCLASS_VOLLEY_GUN';

	/* Offensive Support Fire */
	UPDATE Units SET OffensiveSupportFire = 1 WHERE CombatClass = 'UNITCOMBAT_SIEGE' OR CombatClass = 'UNITCOMBAT_NAVALRANGED' OR Class = 'UNITCLASS_ROMAN_BALLISTA' OR Class = 'UNITCLASS_BAZOOKA';-- OR Class = 'UNITCLASS_GATLINGGUN' OR Class = 'UNITCLASS_MACHINE_GUN' OR Class = 'UNITCLASS_VOLLEY_GUN';

	/* Defensive Support Fire */
	UPDATE Units SET DefensiveSupportFire = 1 WHERE CombatClass = 'UNITCOMBAT_SIEGE' OR CombatClass = 'UNITCOMBAT_ARCHER' OR CombatClass = 'UNITCOMBAT_NAVALRANGED';

	/* Counter Fire */
	UPDATE Units SET CounterFire = 1 WHERE (CombatClass = 'UNITCOMBAT_SIEGE' OR CombatClass = 'UNITCOMBAT_NAVALRANGED' OR CombatClass = 'UNITCOMBAT_ARCHER') AND NOT (Class = 'UNITCLASS_GATLINGGUN' OR Class = 'UNITCLASS_MACHINE_GUN' OR Class = 'UNITCLASS_BAZOOKA' OR Class = 'UNITCLASS_VOLLEY_GUN');

	/* Counter Fire only against same combat class */
	UPDATE Units SET CounterFireSameCombatType = 1 WHERE CombatClass = 'UNITCOMBAT_ARCHER' AND Class <> 'UNITCLASS_ROMAN_BALLISTA';

	/* No range promotion for land/sea units */
	DELETE FROM UnitPromotions_UnitCombats WHERE (UnitCombatType ='UNITCOMBAT_ARCHER' OR UnitCombatType = 'UNITCOMBAT_NAVALRANGED' OR UnitCombatType = 'UNITCOMBAT_SIEGE') AND PromotionType = 'PROMOTION_RANGE';

END;


CREATE TRIGGER UpdateUnitsFreePromotionsTable
AFTER INSERT ON Unit_FreePromotions
BEGIN
	DELETE FROM Unit_FreePromotions WHERE UnitType = 'PROMOTION_SCENARIO_OCEAN_MOVEMENT';
	INSERT INTO Unit_FreePromotions (UnitType, PromotionType) SELECT Type, 'PROMOTION_SCENARIO_OCEAN_MOVEMENT' FROM Units WHERE Domain ='DOMAIN_SEA';
END;
