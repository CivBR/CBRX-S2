/*

	Combat & Stacking Overhaul
	Units
	by Gedemon (2013)


*/


-----------------------------------------------
-- Unit
-----------------------------------------------

/* Range = 1 for all Ranged Land/Sea unit */
UPDATE Units SET Range ='1' WHERE RangedCombat > 0 AND (Domain = 'DOMAIN_LAND' OR Domain = 'DOMAIN_SEA');
UPDATE Units SET Range ='1' WHERE Class = 'UNITCLASS_ANTI_AIRCRAFT_GUN';

/* Range = 2 for some units */
UPDATE Units SET Range ='2' WHERE Class = 'UNITCLASS_MISSILE_DESTROYER' OR Class = 'UNITCLASS_MISSILE_CRUISER' OR Class = 'UNITCLASS_MOBILE_SAM'; -- to do: try to set missile attack animation only for the Missile Cruiser
UPDATE Units SET Range ='2' WHERE Class = 'UNITCLASS_ROCKET_ARTILLERY';

/* "Archer" units can't attack ships */
UPDATE Units SET RangeAttackOnlyInDomain ='1' WHERE CombatClass ='UNITCOMBAT_ARCHER' OR CombatClass ='UNITCOMBAT_RECON';


-----------------------------------------------
-- Unit Promotions
-----------------------------------------------

/* Ocean double move */
INSERT INTO Unit_FreePromotions (UnitType, PromotionType) SELECT Type, 'PROMOTION_SCENARIO_OCEAN_MOVEMENT' FROM Units WHERE Domain ='DOMAIN_SEA';
INSERT INTO UnitPromotions_Terrains (PromotionType, TerrainType, DoubleMove) SELECT Type, 'TERRAIN_OCEAN', 1 FROM UnitPromotions WHERE Type LIKE '%_EMBARKATION';

/* No range promotion for land/sea units */
DELETE FROM UnitPromotions_UnitCombats WHERE (UnitCombatType ='UNITCOMBAT_ARCHER' OR UnitCombatType = 'UNITCOMBAT_NAVALRANGED' OR UnitCombatType = 'UNITCOMBAT_SIEGE') AND PromotionType = 'PROMOTION_RANGE';

/* AA defensive only */
INSERT INTO Unit_FreePromotions (UnitType, PromotionType) SELECT 'UNIT_ANTI_AIRCRAFT_GUN', 'PROMOTION_ONLY_DEFENSIVE'  WHERE NOT EXISTS(SELECT value FROM Defines WHERE Name ='RED_XTENDED'); -- If R.E.D. Xtended is loaded, this is already set, don't add it again...
INSERT INTO Unit_FreePromotions (UnitType, PromotionType) SELECT 'UNIT_MOBILE_SAM', 'PROMOTION_ONLY_DEFENSIVE'  WHERE NOT EXISTS(SELECT value FROM Defines WHERE Name ='RED_XTENDED'); -- If R.E.D. Xtended is loaded, this is already set, don't add it again...

/* Submarines can move after attack */
INSERT INTO Unit_FreePromotions (UnitType, PromotionType) SELECT Type, 'PROMOTION_CAN_MOVE_AFTER_ATTACKING' FROM Units WHERE Type LIKE '%SUBMARINE%' AND NOT EXISTS(SELECT value FROM Defines WHERE Name ='RED_XTENDED'); -- If R.E.D. Xtended is loaded, this is already set, don't add it again...