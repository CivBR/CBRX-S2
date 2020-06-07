--==========================================================================================================================		
-- BELIEFS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
--JFD_Sovereignty_Beliefs
CREATE TRIGGER JFD_Sovereignty_Beliefs
AFTER INSERT ON Beliefs
WHEN NEW.Type IN ('BELIEF_JFD_DEFENDER_FAITH', 'BELIEF_JFD_GOD_KING', 'BELIEF_JFD_MOSQUES')
BEGIN
	UPDATE JFD_Government_Titles
	SET BeliefType = 'BELIEF_JFD_DEFENDER_FAITH'
	WHERE BeliefType = 'BELIEF_DEFENDER_FAITH';

	UPDATE JFD_Government_Titles
	SET BeliefType = 'BELIEF_JFD_GOD_KING'
	WHERE BeliefType = 'BELIEF_GOD_KING';

	UPDATE JFD_Government_Titles
	SET BeliefType = 'BELIEF_JFD_MOSQUES'
	WHERE BeliefType = 'BELIEF_MOSQUES';
END;
--==========================================================================================================================		
-- BUILDING CLASSES
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
--JFD_Sovereignty_BuildingClasses
CREATE TRIGGER JFD_Sovereignty_BuildingClasses
AFTER INSERT ON BuildingClasses
WHEN NEW.Type IN ('BUILDINGCLASS_DECISIONS_NATIONALCOURT', 'BUILDINGCLASS_DECISIONS_CODEOFLAWS', 'BUILDINGCLASS_EE_WEIGH_HOUSE', 'BUILDINGCLASS_EE_MENAGERIE', 'BUILDINGCLASS_JFD_CISTERN')
BEGIN
	UPDATE BuildingClasses
	SET MaxPlayerInstances = -1
	WHERE NEW.Type = Type AND Type = 'BUILDINGCLASS_DECISIONS_CODEOFLAWS';

	UPDATE Buildings
	SET Cost = -1, GreatWorkCount = -1, PrereqTech = null
	WHERE NEW.Type = BuildingClass AND BuildingClass = 'BUILDINGCLASS_DECISIONS_CODEOFLAWS';

	UPDATE BuildingClasses
	SET MaxPlayerInstances = -1
	WHERE NEW.Type = Type AND Type = 'BUILDINGCLASS_DECISIONS_NATIONALCOURT';

	UPDATE Buildings
	SET Cost = -1, GreatWorkCount = -1, PrereqTech = null
	WHERE NEW.Type = BuildingClass AND BuildingClass = 'BUILDINGCLASS_DECISIONS_NATIONALCOURT';
--------------------------------------------------------------------------------------------------------------------------
	INSERT INTO Policy_BuildingClassYieldModifiers
			(PolicyType,								BuildingClassType, 						YieldMod)
	SELECT	'POLICY_REFORM_JFD_ECONOMICS_PLANNED', 		NEW.Type,								10
	WHERE NEW.Type = 'BUILDINGCLASS_EE_WEIGH_HOUSE';
	
	INSERT INTO Policy_BuildingClassYieldModifiers
			(PolicyType,								BuildingClassType, 						YieldMod)
	SELECT	'POLICY_REFORM_JFD_ECONOMICS_MARKET', 		NEW.Type,								-10
	WHERE NEW.Type = 'BUILDINGCLASS_EE_WEIGH_HOUSE';
	
	INSERT INTO Policy_BuildingClassProductionModifiers
			(PolicyType,								BuildingClassType, 						ProductionModifier)
	SELECT	'POLICY_REFORM_JFD_ECONOMICS_PLANNED', 		NEW.Type,								25
	WHERE NEW.Type = 'BUILDINGCLASS_EE_WEIGH_HOUSE';
	
	INSERT INTO Policy_BuildingClassProductionModifiers
			(PolicyType,								BuildingClassType, 						ProductionModifier)
	SELECT	'POLICY_REFORM_JFD_ECONOMICS_MARKET', 		NEW.Type,								-25
	WHERE NEW.Type = 'BUILDINGCLASS_EE_WEIGH_HOUSE';
--------------------------------------------------------------------------------------------------------------------------
	UPDATE JFD_Reforms
	SET HelpBonus = 'TXT_KEY_JFD_REFORM_GOODS_WATERWAYS_HELP_BONUS_CISTERN', FocusIconBonus = '[ICON_JFD_HEALTH]'
	WHERE NEW.Type = 'BUILDINGCLASS_JFD_CISTERN';

	UPDATE Policy_BuildingClassProductionModifiers
	SET BuildingClassType = 'BUILDINGCLASS_EE_MENAGERIE'
	WHERE NEW.Type = 'BUILDINGCLASS_EE_MENAGERIE' AND PolicyType = 'POLICY_REFORM_JFD_GOODS_ENTERTAINMENT' AND BuildingClassType = 'BUILDINGCLASS_THEATRE';
END;
--------------------------------------------------------------------------------------------------------------------------
--JFD_Sovereignty_ReligiousBuildings
CREATE TRIGGER JFD_Sovereignty_ReligiousBuildings
AFTER INSERT ON BuildingClasses
WHEN NEW.DefaultBuilding IN (SELECT Type FROM Buildings WHERE Cost = -1 AND FaithCost > 0 AND UnlockedByBelief = 1)
BEGIN
	INSERT INTO Policy_BuildingClassCultureChanges
			(PolicyType,								BuildingClassType,	CultureChange)
	VALUES	('POLICY_REFORM_JFD_CHURCH_CULTURAL',		NEW.Type,			2);

	INSERT INTO Policy_BuildingClassYieldChanges
			(PolicyType,								BuildingClassType,	YieldType,			YieldChange)
	VALUES	('POLICY_REFORM_JFD_CHURCH_CULTURAL',		NEW.Type,			'YIELD_FAITH',		-2),
			('POLICY_REFORM_JFD_CHURCH_NATIONAL',		NEW.Type,			'YIELD_FAITH',		-2);

	INSERT INTO Policy_BuildingClassHappiness
			(PolicyType,								BuildingClassType,	Happiness)
	VALUES	('POLICY_REFORM_JFD_CHURCH_NATIONAL',		NEW.Type,			1);
END;
--------------------------------------------------------------------------------------------------------------------------
--JFD_Sovereignty_NationalWonders
CREATE TRIGGER JFD_Sovereignty_NationalWonders
AFTER INSERT ON BuildingClasses
WHEN NEW.MaxPlayerInstances = 1
BEGIN
	INSERT INTO Policy_BuildingClassProductionModifiers
			(PolicyType,								BuildingClassType, 		ProductionModifier)
	VALUES	('POLICY_REFORM_JFD_WORKS_PUBLIC', 			NEW.Type,				10);
END;
--------------------------------------------------------------------------------------------------------------------------
--JFD_Sovereignty_WorldWonders
CREATE TRIGGER JFD_Sovereignty_WorldWonders
AFTER INSERT ON BuildingClasses
WHEN NEW.MaxGlobalInstances = 1
BEGIN
	INSERT INTO Policy_BuildingClassProductionModifiers
			(PolicyType,								BuildingClassType, 		ProductionModifier)
	VALUES	('POLICY_REFORM_JFD_WORKS_CEREMONIAL', 		NEW.Type,				10);
END;
--==========================================================================================================================		
-- BUILDINGS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
--JFD_Sovereignty_Buildings
CREATE TRIGGER JFD_Sovereignty_Buildings
AFTER INSERT ON Buildings
WHEN NEW.BuildingClass IN ('BUILDINGCLASS_JFD_PANTHEON', 'BUILDINGCLASS_JFD_NAN_MADOL', 'BUILDINGCLASS_JFD_TEMPLO_MAYOR', 'BUILDINGCLASS_JFD_CAIRO_CITADEL', 'BUILDINGCLASS_EE_VERSAILLES', 'BUILDINGCLASS_JFD_JAIL')
BEGIN
	UPDATE Buildings
	SET PrereqTech = 'TECH_JFD_JURISPRUDENCE'
	WHERE NEW.Type = Type AND NEW.BuildingClass = 'BUILDINGCLASS_CONSTABLE';

	UPDATE Buildings
	SET Cost = -1, PrereqTech = null
	WHERE NEW.Type = Type AND Type = 'BUILDING_EE_VERSAILLES';
--------------------------------------------------------------------------------------------------------------------------
	UPDATE JFD_Government_Titles
	SET BuildingType = 'BUILDING_JFD_CAIRO_CITADEL'
	WHERE NEW.Type = BuildingType AND BuildingType = 'BUILDING_JFD_CAIRO_CITADEL';

	UPDATE JFD_Government_Titles
	SET BuildingType = 'BUILDING_JFD_PANTHEON'
	WHERE NEW.Type = BuildingType AND BuildingType = 'BUILDING_JFD_PANTHEON';

	UPDATE JFD_Government_Titles
	SET BuildingType = 'BUILDING_JFD_TEMPLO_MAYOR'
	WHERE NEW.Type = BuildingType AND BuildingType = 'BUILDING_JFD_TEMPLO_MAYOR';

	UPDATE JFD_Government_Titles
	SET BuildingType = 'BUILDING_JFD_NAN_MADOL'
	WHERE NEW.Type = BuildingType AND BuildingType = 'BUILDING_JFD_NAN_MADOL';
--------------------------------------------------------------------------------------------------------------------------
	INSERT INTO Policy_BuildingClassYieldModifiers	
			(PolicyType,							BuildingClassType,	YieldType, 				YieldMod)	
	SELECT	'POLICY_REFORM_JFD_SYSTEM_COMMON', 		NEW.BuildingClass,	'YIELD_PRODUCTION', 	5
	WHERE NEW.BuildingClass = 'BUILDINGCLASS_JFD_JAIL';
--------------------------------------------------------------------------------------------------------------------------
	INSERT INTO Policy_BuildingClassProductionModifiers	
			(PolicyType,								BuildingClassType,		ProductionModifier)	
	SELECT	'POLICY_REFORM_JFD_JUSTICE_DETERRENCE',		NEW.BuildingClass,		20
	WHERE NEW.BuildingClass = 'BUILDINGCLASS_JFD_JAIL';
	
	INSERT INTO Policy_BuildingClassProductionModifiers	
			(PolicyType,								BuildingClassType,		ProductionModifier)	
	SELECT	'POLICY_REFORM_JFD_JUSTICE_REDEMPTION',		NEW.BuildingClass,		-20
	WHERE NEW.BuildingClass = 'BUILDINGCLASS_JFD_JAIL';
END;
--==========================================================================================================================
-- CIVILIZATIONS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- Civilization_JFD_Governments
--------------------------------------------------------------------------------------------------------------------------	
--JFD_Sovereignty_Civilization_JFD_Governments
CREATE TRIGGER JFD_Sovereignty_Civilization_JFD_Governments
AFTER INSERT ON Civilization_JFD_Governments
WHEN NEW.GovernmentType IN ('GOVERNMENT_JFD_THEOCRACY', 'GOVERNMENT_JFD_DICTATORSHIP', 'GOVERNMENT_JFD_HOLY_ROMAN_EMPIRE', 'GOVERNMENT_JFD_MANDATE_OF_HEAVEN')
BEGIN
	UPDATE Civilization_JFD_Governments
	SET GovernmentType = 'GOVERNMENT_JFD_THEOCRATIC'
	WHERE GovernmentType = 'GOVERNMENT_JFD_THEOCRACY';

	UPDATE Civilization_JFD_Governments
	SET GovernmentType = 'GOVERNMENT_JFD_TOTALITARIAN'
	WHERE GovernmentType = 'GOVERNMENT_JFD_DICTATORSHIP';

	UPDATE Civilization_JFD_Governments
	SET GovernmentType = 'GOVERNMENT_JFD_HOLY_ROMAN'
	WHERE GovernmentType = 'GOVERNMENT_JFD_HOLY_ROMAN_EMPIRE';

	UPDATE Civilization_JFD_Governments
	SET GovernmentType = 'GOVERNMENT_JFD_MANDATE'
	WHERE GovernmentType = 'GOVERNMENT_JFD_MANDATE_OF_HEAVEN';
END;
--==========================================================================================================================		
-- ERAS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
--JFD_Sovereignty_Eras
CREATE TRIGGER JFD_Sovereignty_Eras
AFTER INSERT ON Eras
WHEN NEW.Type = 'ERA_ENLIGHTENMENT'
BEGIN
	UPDATE JFD_Reforms
	SET PrereqEra = 'ERA_ENLIGHTENMENT'
	WHERE Type IN ('REFORM_JFD_EXECUTIVE_CONSTITUTIONAL', 'REFORM_JFD_EXECUTIVE_ABSOLUTE', 'REFORM_JFD_SUFFRAGE_LANDED', 'REFORM_JFD_SUFFRAGE_UNIVERSAL', 'REFORM_JFD_JUDICIARY_DEPENDENT', 'REFORM_JFD_JUDICIARY_INDEPENDENT', 'REFORM_JFD_REPRESENTATIVES_PERMANENT', 'REFORM_JFD_PRECEDENCE_POWER', 'REFORM_JFD_PRECEDENCE_RANK', 'REFORM_JFD_REPRESENTATIVES_TRANSIENT', 'REFORM_JFD_TRADE_FAIR', 'REFORM_JFD_TRADE_FREE', 'REFORM_JFD_SCHOOLING_MERITED', 'REFORM_JFD_SCHOOLING_UNIVERSAL', 'REFORM_JFD_MANUFACTURING_CRAFTED', 'REFORM_JFD_MANUFACTURING_MECHANICAL', 'REFORM_JFD_RECRUITMENT_PROFESSIONAL', 'REFORM_JFD_RECRUITMENT_IRREGULAR', 'REFORM_JFD_COMMAND_COMMISSION', 'REFORM_JFD_COMMAND_MERIT', 'REFORM_JFD_SEPARATION_LEGAL', 'REFORM_JFD_SEPARATION_SOCIAL', 'REFORM_JFD_PUBLICATIONS_PROPAGANDA', 'REFORM_JFD_PUBLICATIONS_FREE', 'REFORM_JFD_LANGUAGE_PURE', 'REFORM_JFD_LANGUAGE_ADAPTED', 'REFORM_JFD_EQUALITY_OUTCOMES', 'REFORM_JFD_EQUALITY_OPPORTUNITIES');

	UPDATE JFD_Governments
	SET RequiresMinEra = 'ERA_ENLIGHTENMENT'
	WHERE Type = 'GOVERNMENT_JFD_REVOLUTIONARY';
END;
--==========================================================================================================================		
-- LEADERS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
--JFD_Sovereignty_Leader_Flavors
CREATE TRIGGER JFD_Sovereignty_Leader_Flavors
AFTER INSERT ON Leader_Flavors
WHEN NEW.FlavorType IN ('FLAVOR_JFD_REFORM_FOREIGN', 'FLAVOR_JFD_REFORM_ECONOMIC', 'FLAVOR_JFD_REFORM_LEGAL', 'FLAVOR_JFD_REFORM_CULTURAL')
BEGIN
	UPDATE Leader_Flavors
	SET FlavorType = 'FLAVOR_JFD_REFORM_DIPLOMACY'
	WHERE FlavorType = 'FLAVOR_JFD_REFORM_FOREIGN';
	
	UPDATE Leader_Flavors
	SET FlavorType = 'FLAVOR_JFD_REFORM_ECONOMY'
	WHERE FlavorType = 'FLAVOR_JFD_REFORM_ECONOMIC';
	
	UPDATE Leader_Flavors
	SET FlavorType = 'FLAVOR_JFD_REFORM_LAW'
	WHERE FlavorType = 'FLAVOR_JFD_REFORM_LEGAL';
	
	UPDATE Leader_Flavors
	SET FlavorType = 'FLAVOR_JFD_REFORM_SOCIETY'
	WHERE FlavorType = 'FLAVOR_JFD_REFORM_CULTURAL';
END;
--==========================================================================================================================		
-- POLICY BRANCHES
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
--JFD_Sovereignty_PolicyBranchTypes
CREATE TRIGGER JFD_Sovereignty_PolicyBranchTypes
AFTER INSERT ON PolicyBranchTypes
WHEN NEW.Type IN ('POLICY_BRANCH_JFD_INDUSTRY', 'POLICY_BRANCH_JFD_SPIRIT', 'POLICY_BRANCH_JFD_NEUTRALITY')
BEGIN
	UPDATE JFD_Factions
	SET Help = 'TXT_KEY_JFD_FACTION_JFD_INDEPENDENT_HELP_NEUTRALITY'
	WHERE Type = 'FACTION_JFD_INDEPENDENT'
	AND EXISTS (SELECT Type FROM PolicyBranchTypes WHERE Type = 'POLICY_BRANCH_JFD_NEUTRALITY');
	
	UPDATE JFD_Factions
	SET Help = 'TXT_KEY_JFD_FACTION_JFD_NATIONAL_HELP_SPIRIT'
	WHERE Type = 'FACTION_JFD_NATIONAL'
	AND EXISTS (SELECT Type FROM PolicyBranchTypes WHERE Type = 'POLICY_BRANCH_JFD_SPIRIT');
	
	UPDATE JFD_Factions
	SET Help = 'TXT_KEY_JFD_FACTION_JFD_NATIONAL_HELP_ADDITIONAL'
	WHERE Type = 'FACTION_JFD_NATIONAL'
	AND EXISTS (SELECT Type FROM PolicyBranchTypes WHERE Type = 'POLICY_BRANCH_JFD_INDUSTRY');
	
	UPDATE JFD_Factions
	SET Help = 'TXT_KEY_JFD_FACTION_JFD_NATIONAL_HELP_ADDITIONAL_SPIRIT'
	WHERE Type = 'FACTION_JFD_NATIONAL'
	AND EXISTS (SELECT Type FROM PolicyBranchTypes WHERE Type = 'POLICY_BRANCH_JFD_INDUSTRY')
	AND EXISTS (SELECT Type FROM PolicyBranchTypes WHERE Type = 'POLICY_BRANCH_JFD_SPIRIT');
	
	UPDATE JFD_Factions
	SET Help = 'TXT_KEY_JFD_FACTION_JFD_PROGRESSIVE_HELP_ADDITIONAL'
	WHERE Type = 'FACTION_JFD_PROGRESSIVE'
	AND EXISTS (SELECT Type FROM PolicyBranchTypes WHERE Type = 'POLICY_BRANCH_JFD_INDUSTRY');
END;
--==========================================================================================================================		
-- SPECIALISTS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
--JFD_Sovereignty_Specialists
CREATE TRIGGER JFD_Sovereignty_Specialists
AFTER INSERT ON Specialists
WHEN NEW.Type = 'SPECIALIST_JFD_MAGISTRATE'
BEGIN
	UPDATE JFD_Reforms
	SET HelpBonus = 'TXT_KEY_JFD_REFORM_HONOURS_HUMANITIES_HELP_BONUS_MAGISTRATE'
	WHERE Type = 'REFORM_JFD_HONOURS_HUMANITIES'
	AND EXISTS (SELECT Name FROM CustomModOptions WHERE Name = 'COMMUNITY_PATCH' AND Value = 1);
	
	UPDATE JFD_Reforms
	SET HelpPenalty = 'TXT_KEY_JFD_REFORM_HONOURS_SCIENCES_HELP_PENALTY_MAGISTRATE'
	WHERE Type = 'REFORM_JFD_HONOURS_SCIENCES'
	AND EXISTS (SELECT Name FROM CustomModOptions WHERE Name = 'COMMUNITY_PATCH' AND Value = 1);
--------------------------------------------------------------------------------------------------------------------------
	INSERT INTO Policy_GoldenAgeGreatPersonRateModifier
			(PolicyType, 								GreatPersonType, 				Modifier)
	VALUES	('POLICY_REFORM_JFD_HONOURS_HUMANITIES',	'GREATPERSON_JFD_MAGISTRATE', 	15),
			('POLICY_REFORM_JFD_HONOURS_SCIENCES', 		'GREATPERSON_JFD_MAGISTRATE', 	-15);
END;
--==========================================================================================================================		
-- TECHS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
--JFD_Sovereignty_Technologies
CREATE TRIGGER JFD_Sovereignty_Technologies
AFTER INSERT ON Technologies
WHEN NEW.Type = 'TECH_EE_SOVEREIGNTY'
BEGIN
	UPDATE Buildings
	SET PrereqTech = 'TECH_EE_SOVEREIGNTY'
	WHERE Type = 'BUILDING_JFD_VERSAILLES';
--------------------------------------------------------------------------------------------------------------------------
	DELETE FROM Technology_PrereqTechs WHERE PrereqTech = 'TECH_JFD_JURISPRUDENCE';
	INSERT INTO Technology_PrereqTechs 
			(TechType, 			PrereqTech)
	VALUES	('TECH_ECONOMICS', 	'TECH_JFD_JURISPRUDENCE');
END;
--==========================================================================================================================		
-- UNIT CLASSES
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
--JFD_Sovereignty_UnitClasses
CREATE TRIGGER JFD_Sovereignty_UnitClasses
AFTER INSERT ON UnitClasses
WHEN NEW.Type IN ('UNITCLASS_JFD_GREAT_DIGNITARY', 'UNITCLASS_JFD_WORKFORCE')
BEGIN
	UPDATE JFD_Reforms
	SET HelpPenalty = 'TXT_KEY_JFD_REFORM_LABOUR_EMANCIPATED_HELP_PENALTY_WORKFORCES'
	WHERE Type = 'REFORM_JFD_LABOUR_EMANCIPATED'
	AND NEW.Type = 'UNITCLASS_JFD_WORKFORCE';

	UPDATE JFD_Reforms
	SET HelpBonus = 'TXT_KEY_JFD_REFORM_LABOUR_BONDED_HELP_BONUS_WORKFORCES'
	WHERE Type = 'REFORM_JFD_LABOUR_BONDED'
	AND NEW.Type = 'UNITCLASS_JFD_WORKFORCE';
--------------------------------------------------------------------------------------------------------------------------
	UPDATE JFD_Reform_FreePromotions
	SET UnitClassType = 'UNITCLASS_JFD_GREAT_DIGNITARY'
	WHERE ReformType = 'REFORM_JFD_ALLIANCES_MARRIAGE'
	AND NEW.Type = 'UNITCLASS_JFD_GREAT_DIGNITARY';
--------------------------------------------------------------------------------------------------------------------------
	UPDATE Policies
	SET WorkerSpeedModifier = 0
	WHERE Type IN ('POLICY_REFORM_JFD_LABOUR_BONDED', 'POLICY_REFORM_JFD_LABOUR_EMANCIPATED')
	AND NEW.Type = 'UNITCLASS_JFD_WORKFORCE';
END;
--==========================================================================================================================
--==========================================================================================================================