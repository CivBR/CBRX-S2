--==========================================================================================================================
-- UNITS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- UnitCombatInfos
--------------------------------------------------------------------------------------------------------------------------
INSERT OR REPLACE INTO UnitCombatInfos
		(Type, 								Description)
VALUES	('UNITCOMBAT_ARCHAEOLOGIST',		'TXT_KEY_UNITCOMBAT_ARCHAEOLOGIST'),
		('UNITCOMBAT_GREAT_PEOPLE',			'TXT_KEY_UNITCOMBAT_GREAT_PEOPLE'),
		('UNITCOMBAT_MISSILE',				'TXT_KEY_UNITCOMBAT_MISSILE'),
		('UNITCOMBAT_RELIGIOUS',			'TXT_KEY_UNITCOMBAT_RELIGIOUS'),
		('UNITCOMBAT_SETTLER',				'TXT_KEY_UNITCOMBAT_SETTLER'),
		('UNITCOMBAT_SPACE_STATION',		'TXT_KEY_UNITCOMBAT_SPACE_STATION'),
		('UNITCOMBAT_TRADE',				'TXT_KEY_UNITCOMBAT_TRADE'),
		('UNITCOMBAT_WORKER',				'TXT_KEY_UNITCOMBAT_WORKER');
--------------------------------------------------------------------------------------------------------------------------
-- Units
--------------------------------------------------------------------------------------------------------------------------
UPDATE Units
SET CombatClass = 'UNITCOMBAT_ARCHAEOLOGIST'
WHERE Class IN ('UNITCLASS_ARCHAEOLOGIST') AND CombatClass IS NULL;	

UPDATE Units
SET WorkRate = 100, CombatClass = 'UNITCOMBAT_GREAT_PEOPLE'
WHERE Special = 'SPECIALUNIT_PEOPLE';	

UPDATE Units
SET CombatClass = 'UNITCOMBAT_MISSILE'
WHERE Class IN ('UNITCLASS_GUIDED_MISSILE', 'UNITCLASS_NUCLEAR_MISSILE', 'UNITCLASS_ATOMIC_BOMB') AND CombatClass IS NULL;	

UPDATE Units
SET CombatClass = 'UNITCOMBAT_RELIGIOUS'
WHERE Class IN ('UNITCLASS_MISSIONARY', 'UNITCLASS_INQUISITOR') AND CombatClass IS NULL;	

UPDATE Units
SET CombatClass = 'UNITCOMBAT_SPACE_STATION'
WHERE Class IN ('UNITCLASS_SS_STASIS_CHAMBER', 'UNITCLASS_SS_ENGINE', 'UNITCLASS_SS_COCKPIT', 'UNITCLASS_SS_BOOSTER') AND CombatClass IS NULL;	

UPDATE Units
SET CombatClass = 'UNITCOMBAT_SETTLER'
WHERE Class IN ('UNITCLASS_SETTLER', 'UNITCLASS_COLONIST', 'UNITCLASS_JFD_COLONIST', 'UNITCLASS_JFD_WORKER') AND CombatClass IS NULL;	

UPDATE Units
SET CombatClass = 'UNITCOMBAT_TRADE'
WHERE Class IN ('UNITCLASS_CARAVAN', 'UNITCLASS_CARGO_SHIP') AND CombatClass IS NULL;	

UPDATE Units
SET CombatClass = 'UNITCOMBAT_WORKER'
WHERE Class IN ('UNITCLASS_WORKER', 'UNITCLASS_JFD_WORKER', 'UNITCLASS_WORKBOAT', 'UNITCLASS_JFD_SLAVE', 'UNITCLASS_JFD_WORKFORCE') AND CombatClass IS NULL;	
---------------------------------------------------------
UPDATE Units 
SET DefaultUnitAI = 'UNITAI_ATTACK_SEA' 
WHERE Class IN ('UNITCLASS_EE_CARRACK', 'UNITCLASS_EE_SHIP_OF_THE_LINE', 'UNITCLASS_EE_GALLEON'); 
---------------------------------------------------------
UPDATE Units 
SET ObsoleteTech = 'TECH_EE_EXPLORATION' 
WHERE Type = 'UNIT_PORTUGUESE_NAU'
AND EXISTS (SELECT Type FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');

UPDATE Units 
SET ObsoleteTech = 'TECH_NAVIGATION' 
WHERE Class = 'UNITCLASS_GALLEASS'
AND EXISTS (SELECT Type FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');

UPDATE Units 
SET ObsoleteTech = 'TECH_EE_WARSHIPS' 
WHERE Class = 'UNITCLASS_EE_GALLEON'
AND EXISTS (SELECT Type FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');

UPDATE Units 
SET ObsoleteTech = 'TECH_STEAM_POWER' 
WHERE Class = 'UNITCLASS_EE_SKIRMISHER'
AND EXISTS (SELECT Type FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');
--------------------------------------------------------------------------------------------------------------------------
-- UnitGameplay2DScripts
--------------------------------------------------------------------------------------------------------------------------
UPDATE UnitGameplay2DScripts
SET FirstSelectionSound = 'AS2D_BIRTH_HORSEMAN', SelectionSound = 'AS2D_SELECT_HORSEMAN'
WHERE UnitType = 'UNIT_BARBARIAN_HORSEMAN';

UPDATE UnitGameplay2DScripts
SET FirstSelectionSound = 'AS2D_SELECT_WARRIER', SelectionSound = 'AS2D_BIRTH_WARRIER'
WHERE UnitType = 'UNIT_BARBARIAN_WARRIOR';

UPDATE UnitGameplay2DScripts
SET FirstSelectionSound = 'AS2D_SELECT_CANNON', SelectionSound = 'AS2D_BIRTH_CANNON'
WHERE UnitType = 'UNIT_GATLINGGUN';

UPDATE UnitGameplay2DScripts
SET FirstSelectionSound = 'AS2D_SELECT_FRIGATE', SelectionSound = 'AS2D_BIRTH_FRIGATE'
WHERE UnitType = 'UNIT_PRIVATEER';

UPDATE UnitGameplay2DScripts
SET FirstSelectionSound = 'AS2D_SELECT_MUSKETMAN', SelectionSound = 'AS2D_BIRTH_MUSKETMAN'
WHERE UnitType = 'UNIT_SWEDISH_CAROLEAN';
--==========================================================================================================================
--==========================================================================================================================
