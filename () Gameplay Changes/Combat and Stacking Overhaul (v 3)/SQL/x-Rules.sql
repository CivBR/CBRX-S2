/*
	Combat & Stacking Overhaul
	Rules
	by Gedemon (2013)

*/

--------------------------------------------------------------------------------------------
-- DLL Stacking setup
--------------------------------------------------------------------------------------------

/* Worker as a separate stacking class, will stack with settlers, great people and military units */
UPDATE Units SET StackClass ='WORKER' WHERE Type = 'UNIT_WORKER';

/* Unlimited stacking for Great People */
UPDATE Units SET MaxStack ='-1', StackClass ='GREAT_PEOPLE' WHERE Special = 'SPECIALUNIT_PEOPLE';

/* Unlimited stacking for Missiles */
UPDATE Units SET MaxStack ='-1', StackClass ='MISSILE' WHERE Special = 'SPECIALUNIT_MISSILE';

/* Recon class */
UPDATE Units SET StackClass ='RECON' WHERE CombatClass = 'UNITCOMBAT_RECON';

/* Support class */
UPDATE Units SET StackClass ='SUPPORT' WHERE CombatClass = 'UNITCOMBAT_ARCHER';
UPDATE Units SET StackClass ='SUPPORT' WHERE Class = 'UNITCLASS_ANTI_AIRCRAFT_GUN';
UPDATE Units SET StackClass ='SUPPORT' WHERE Class = 'UNITCLASS_MOBILE_SAM';

/* Siege class */
UPDATE Units SET StackClass ='SUPPORT' WHERE CombatClass = 'UNITCOMBAT_SIEGE';
UPDATE Units SET StackClass ='SUPPORT' WHERE Type = 'UNIT_HUN_BATTERING_RAM';
UPDATE Units SET StackClass ='SUPPORT' WHERE Type = 'UNIT_ASSYRIAN_SIEGE_TOWER';

/* Helicopter class */
UPDATE Units SET StackClass ='HELICOPTER' WHERE CombatClass = 'UNITCOMBAT_HELICOPTER';

/* Sea classes */
UPDATE Units SET StackClass ='NAVAL' WHERE CombatClass = 'UNITCOMBAT_NAVALRANGED' OR  CombatClass = 'UNITCOMBAT_NAVALMELEE';
UPDATE Units SET StackClass ='SUBMARINE' WHERE CombatClass = 'UNITCOMBAT_SUBMARINE';

/* City stacking limits */
UPDATE Defines SET Value = 1		WHERE Name = 'CITY_LAND_UNIT_LIMIT';
UPDATE Defines SET Value = 1		WHERE Name = 'CITY_SEA_UNIT_LIMIT';
UPDATE Defines SET Value = 3		WHERE Name = 'CITY_AIR_UNIT_LIMIT';


--------------------------------------------------------------------------------------------
-- DLL Combat setup
--------------------------------------------------------------------------------------------

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


--------------------------------------------------------------------------------------------
-- Lua Stacking setup (won't do anything without the corresponding Lua functions)
--------------------------------------------------------------------------------------------


/* Land stacking */
UPDATE Buildings SET LandStackChange = '1' WHERE BuildingClass = 'BUILDINGCLASS_BARRACKS';
UPDATE Buildings SET LandStackChange = '1' WHERE BuildingClass = 'BUILDINGCLASS_CASTLE';
UPDATE Buildings SET LandStackChange = '1' WHERE BuildingClass = 'BUILDINGCLASS_HIMEJI_CASTLE';
UPDATE Buildings SET LandStackChange = '3' WHERE BuildingClass = 'BUILDINGCLASS_MILITARY_BASE';
UPDATE Buildings SET LandStackChange = '1' WHERE BuildingClass = 'BUILDINGCLASS_RED_FORT';

/* Air stacking */
UPDATE Buildings SET AirStackChange = '5' WHERE BuildingClass = 'BUILDINGCLASS_AIRPORT';
UPDATE Buildings SET AirStackChange = '3' WHERE BuildingClass = 'BUILDINGCLASS_MILITARY_BASE';

/* Sea stacking */
UPDATE Buildings SET SeaStackChange = '1' WHERE BuildingClass = 'BUILDINGCLASS_HARBOR';
UPDATE Buildings SET SeaStackChange = '1' WHERE BuildingClass = 'BUILDINGCLASS_SEAPORT';
UPDATE Buildings SET SeaStackChange = '2' WHERE BuildingClass = 'BUILDINGCLASS_MILITARY_BASE';


--------------------------------------------------------------------------------------------
-- Units Rules
--------------------------------------------------------------------------------------------

/* We can have 4 to 6 units on each plot, so raise a bit the number of units on the map... */
UPDATE Units SET Cost = Cost/2 WHERE Domain = 'DOMAIN_LAND' AND Combat > 0;

/* Allow healing in stacks... */
UPDATE UnitPromotions SET SameTileHealChange = AdjacentTileHealChange WHERE AdjacentTileHealChange > 0; -- maybe something specific in case we want to have different promotions...

--------------------------------------------------------------------------------------------
-- Game Defines
--------------------------------------------------------------------------------------------

/* Base stack */
UPDATE Defines SET Value = 2		WHERE Name = 'PLOT_UNIT_LIMIT';

/* City Range */
UPDATE Defines SET Value = 1		WHERE Name = 'CITY_ATTACK_RANGE';

/* Units HitPoints */
--UPDATE Defines SET Value = 250		WHERE Name = 'MAX_HIT_POINTS'; -- WTF ? can't melee attack if an unit as more than 100 damage ??? where is that hardcoded ??? switch to change to damage values then...


--------------------------------------------------------------------------------------------
-- Heal & Damage
--------------------------------------------------------------------------------------------

/* Citadel's Damage */
UPDATE Improvements SET NearbyEnemyDamage = 20		WHERE Type = 'IMPROVEMENT_CITADEL';

/* Heal Rates */
UPDATE Defines SET Value = 5		WHERE Name = 'ENEMY_HEAL_RATE';		-- default = 10
UPDATE Defines SET Value = 10		WHERE Name = 'NEUTRAL_HEAL_RATE';	-- default = 10
UPDATE Defines SET Value = 15		WHERE Name = 'FRIENDLY_HEAL_RATE';	-- default = 20
UPDATE Defines SET Value = 50		WHERE Name = 'INSTA_HEAL_RATE';		-- default = 50
UPDATE Defines SET Value = 20		WHERE Name = 'CITY_HEAL_RATE';		-- default = 25

/* Combat damages */
UPDATE Defines SET Value = 10		WHERE Name = 'COMBAT_DAMAGE';											-- default = 20
UPDATE Defines SET Value = 1200		WHERE Name = 'ATTACK_SAME_STRENGTH_MIN_DAMAGE';							-- default = 2400
UPDATE Defines SET Value = 600		WHERE Name = 'ATTACK_SAME_STRENGTH_POSSIBLE_EXTRA_DAMAGE';				-- default = 1200
UPDATE Defines SET Value = 1200		WHERE Name = 'RANGE_ATTACK_SAME_STRENGTH_MIN_DAMAGE';					-- default = 2400
UPDATE Defines SET Value = 600		WHERE Name = 'RANGE_ATTACK_SAME_STRENGTH_POSSIBLE_EXTRA_DAMAGE';		-- default = 1200
UPDATE Defines SET Value = 1200		WHERE Name = 'AIR_STRIKE_SAME_STRENGTH_MIN_DEFENSE_DAMAGE';				-- default = 2400
UPDATE Defines SET Value = 600		WHERE Name = 'AIR_STRIKE_SAME_STRENGTH_POSSIBLE_EXTRA_DEFENSE_DAMAGE';	-- default = 1200
UPDATE Defines SET Value = 1200		WHERE Name = 'INTERCEPTION_SAME_STRENGTH_MIN_DAMAGE';					-- default = 2400
UPDATE Defines SET Value = 600		WHERE Name = 'INTERCEPTION_SAME_STRENGTH_POSSIBLE_EXTRA_DAMAGE';		-- default = 1200
UPDATE Defines SET Value = 50		WHERE Name = 'CITY_ATTACKING_DAMAGE_MOD';								-- default = 100
UPDATE Defines SET Value = 50		WHERE Name = 'ATTACKING_CITY_MELEE_DAMAGE_MOD';							-- default = 100