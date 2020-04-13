--=======================================================================================================================
-- Bingle's Civ IV Traits
--=======================================================================================================================
-- Leader_SharedTraits
------------------------------	
CREATE TABLE IF NOT EXISTS 
    Leader_SharedTraits (
    LeaderType          text    REFERENCES Leaders(Type)        default null,
    TraitOne            text    REFERENCES Policies(Type)       default null,
    TraitTwo            text    REFERENCES Policies(Type)       default null);

INSERT INTO Leader_SharedTraits
        (LeaderType,			TraitOne,				TraitTwo)
VALUES  ('LEADER_JFD_KARL_XII',	'POLICY_AGGRESSIVE_X',	'POLICY_EXPANSIVE_X');
------------------------------	
-- Leaders
------------------------------	
UPDATE Leaders 
SET Description = 'Karl XII [ICON_WAR][ICON_FOOD]'
WHERE Type = 'LEADER_JFD_KARL_XII'
AND EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');
--==========================================================================================================================
-- GAZEBO COMMUNITY BALANCE PATCH
--==========================================================================================================================
-- COMMUNITY
------------------------------	
CREATE TABLE IF NOT EXISTS COMMUNITY (Type text, Value variant default 0);
------------------------------
-- Buildings
------------------------------	
UPDATE Buildings
SET Help = 'TXT_KEY_BUILDING_JFD_WAR_ACADEMY_HELP_CBP'
WHERE Type = 'BUILDING_JFD_WAR_ACADEMY' 
AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );
--==========================================================================================================================	
-- JFD AND POUAKAI MERCENARIES
--==========================================================================================================================
-- Flavors
------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_MERCENARY');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------	
INSERT INTO Leader_Flavors
		(LeaderType,			FlavorType,				 Flavor)
VALUES	('LEADER_JFD_KARL_XII',	'FLAVOR_JFD_MERCENARY',	 0);
--==========================================================================================================================	
-- JFD PIETY
--==========================================================================================================================			
-- Flavors
------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_RELIGIOUS_INTOLERANCE');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------
INSERT INTO Leader_Flavors
		(LeaderType,				FlavorType,							 Flavor)
VALUES	('LEADER_JFD_KARL_XII',		'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',	 3);
--==========================================================================================================================	
-- JFD SOVEREIGNTY
--==========================================================================================================================			
-- Flavors
------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_REFORM_GOVERNMENT'),
		('FLAVOR_JFD_REFORM_CULTURE'),
		('FLAVOR_JFD_REFORM_ECONOMIC'),
		('FLAVOR_JFD_REFORM_FOREIGN'),
		('FLAVOR_JFD_REFORM_INDUSTRY'),
		('FLAVOR_JFD_REFORM_MILITARY'),
		('FLAVOR_JFD_REFORM_RELIGION');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------
INSERT INTO Leader_Flavors
		(LeaderType,				FlavorType,							 Flavor)
VALUES	('LEADER_JFD_KARL_XII',		'FLAVOR_JFD_REFORM_GOVERNMENT',		 9),
		('LEADER_JFD_KARL_XII',		'FLAVOR_JFD_REFORM_CULTURE',		 7),
		('LEADER_JFD_KARL_XII',		'FLAVOR_JFD_REFORM_ECONOMIC',		 3),
		('LEADER_JFD_KARL_XII',		'FLAVOR_JFD_REFORM_FOREIGN',		 7),
		('LEADER_JFD_KARL_XII',		'FLAVOR_JFD_REFORM_INDUSTRY',		 5),
		('LEADER_JFD_KARL_XII',		'FLAVOR_JFD_REFORM_MILITARY',		 5),
		('LEADER_JFD_KARL_XII',		'FLAVOR_JFD_REFORM_RELIGION',		 3);
--==========================================================================================================================
-- POUAKAI ENLIGHTENMENT ERA
--==========================================================================================================================
-- Buildings
------------------------------
UPDATE Buildings
SET PrereqTech = 'TECH_EE_FORTIFICATION'
WHERE Type = 'BUILDING_JFD_WAR_ACADEMY' 
AND EXISTS (SELECT * FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');
------------------------------
-- Buildings
------------------------------
UPDATE Civilization_UnitClassOverrides
SET UnitClassType = 'UNITCLASS_EE_LINE_INFANTRY'
WHERE UnitType = 'UNIT_SWEDISH_CAROLEAN' 
AND EXISTS (SELECT * FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');
--==========================================================================================================================
-- SUKRITACT DECISIONS
--==========================================================================================================================
-- DecisionsAddin_Support
------------------------------
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('JFD_SwedenKarlXII_Decisions.lua');
------------------------------
-- Policies
------------------------------
INSERT INTO Policies
		(Type,												Description,												UnitSupplyMod,	BaseFreeUnits)
VALUES	('POLICY_DECISIONS_JFD_SWEDEN_MILITARY_SCIENCE',	'TXT_KEY_DECISIONS_JFD_SWEDEN_KARL_MILITARY_SCIENCE',		0,				0),
		('POLICY_DECISIONS_JFD_SWEDEN_OCTAL_SYSTEM',		'TXT_KEY_DECISIONS_JFD_SWEDEN_KARL_OCTAL_SYSTEM',			25,				5);
------------------------------
-- Policy_BuildingClassYieldChanges
------------------------------
INSERT INTO Policy_BuildingClassYieldChanges
		(PolicyType,										BuildingClassType,					YieldType,			YieldChange)
VALUES	('POLICY_DECISIONS_JFD_SWEDEN_MILITARY_SCIENCE',	'BUILDINGCLASS_BARRACKS',			'YIELD_SCIENCE',	2),
		('POLICY_DECISIONS_JFD_SWEDEN_MILITARY_SCIENCE',	'BUILDINGCLASS_ARMORY',				'YIELD_SCIENCE',	2),
		('POLICY_DECISIONS_JFD_SWEDEN_MILITARY_SCIENCE',	'BUILDINGCLASS_MILITARY_ACADEMY',	'YIELD_SCIENCE',	2);
--==========================================================================================================================
-- SUKRITACT EVENTS
--==========================================================================================================================
-- EventsAddin_Support
------------------------------
CREATE TABLE IF NOT EXISTS EventsAddin_Support(FileName);
INSERT INTO EventsAddin_Support (FileName) VALUES ('JFD_SwedenKarlXII_Events.lua');
--==========================================================================================================================
--==========================================================================================================================