--==========================================================================================================================
-- POLICY BRANCHES
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
--RTP_PolicyBranches
CREATE TRIGGER RTP_PolicyBranches
AFTER INSERT ON PolicyBranchTypes
WHEN NEW.Type = 'POLICY_BRANCH_JFD_SPIRIT' 
BEGIN
	UPDATE PolicyBranchTypes
	SET IconString = '[ICON_IDEOLOGY_JFD_SPIRIT]'
	WHERE Type = NEW.Type;
END;
--==========================================================================================================================
-- RELIGIONS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
--RTP_Religions
CREATE TRIGGER RTP_Religions
AFTER INSERT ON Religions 
BEGIN
	UPDATE Religions
	SET Adjective = Description || '_ADJ'
	WHERE Type = NEW.Type;
END;
--==========================================================================================================================
-- UNITS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
--RTP_Units
CREATE TRIGGER RTP_Units
AFTER INSERT ON Units 
WHEN NEW.CombatClass IS NULL OR NEW.Class IN ('UNITCLASS_EE_GALLEON', 'UNITCLASS_EE_SKIRMISHER', 'UNITCLASS_GALLEASS') 
BEGIN
	UPDATE Units
	SET CombatClass = 'UNITCOMBAT_ARCHAEOLOGIST'
	WHERE Class = NEW.Class AND Class IN ('UNITCLASS_ARCHAEOLOGIST') AND CombatClass IS NULL;	
	
	UPDATE Units
	SET WorkRate = 100, CombatClass = 'UNITCOMBAT_GREAT_PEOPLE'
	WHERE Class = NEW.Class AND Special = 'SPECIALUNIT_PEOPLE';	
	
	UPDATE Units
	SET CombatClass = 'UNITCOMBAT_MISSILE'
	WHERE Class = NEW.Class AND Class IN ('UNITCLASS_GUIDED_MISSILE', 'UNITCLASS_NUCLEAR_MISSILE', 'UNITCLASS_ATOMIC_BOMB') AND CombatClass IS NULL;	
	
	UPDATE Units
	SET CombatClass = 'UNITCOMBAT_RELIGIOUS'
	WHERE Class = NEW.Class AND Class IN ('UNITCLASS_MISSIONARY', 'UNITCLASS_INQUISITOR') AND CombatClass IS NULL;	
	
	UPDATE Units
	SET CombatClass = 'UNITCOMBAT_TRADE'
	WHERE Class = NEW.Class AND Class IN ('UNITCLASS_CARAVAN', 'UNITCLASS_CARGO_SHIP') AND CombatClass IS NULL;	
	
	UPDATE Units
	SET CombatClass = 'UNITCOMBAT_SETTLER'
	WHERE Class = NEW.Class AND Class IN ('UNITCLASS_SETTLER', 'UNITCLASS_COLONIST', 'UNITCLASS_JFD_COLONIST') AND CombatClass IS NULL;	
	
	UPDATE Units
	SET CombatClass = 'UNITCOMBAT_SPACE_STATION'
	WHERE Class = NEW.Class AND Class IN ('UNITCLASS_SS_STASIS_CHAMBER', 'UNITCLASS_SS_ENGINE', 'UNITCLASS_SS_COCKPIT', 'UNITCLASS_SS_BOOSTER') AND CombatClass IS NULL;	
	
	UPDATE Units
	SET CombatClass = 'UNITCOMBAT_WORKER'
	WHERE Class = NEW.Class AND Class IN ('UNITCLASS_WORKER', 'UNITCLASS_JFD_WORKER', 'UNITCLASS_WORKBOAT', 'UNITCLASS_JFD_SLAVE', 'UNITCLASS_JFD_WORKFORCE') AND CombatClass IS NULL;	
--------------------------------------------------------------------------------------------------------------------------	
	UPDATE Units
	SET ObsoleteTech = 'TECH_NAVIGATION'
	WHERE Class = NEW.Class AND NEW.Class = 'UNITCLASS_EE_GALLEON'
	AND EXISTS (SELECT Type FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');
	
	UPDATE Units
	SET ObsoleteTech = 'TECH_EE_WARSHIPS'
	WHERE Class = NEW.Class AND NEW.Class = 'UNITCLASS_EE_GALLEON'
	AND EXISTS (SELECT Type FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');
	
	UPDATE Units
	SET ObsoleteTech = 'TECH_STEAM_POWER'
	WHERE Class = NEW.Class AND NEW.Class = 'UNITCLASS_EE_SKIRMISHER'
	AND EXISTS (SELECT Type FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');
END;
--==========================================================================================================================
--==========================================================================================================================