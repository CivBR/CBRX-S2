--==========================================================================================================================
-- JFD's Piety & Prestige
--==========================================================================================================================
-- Flavors
------------------------------
INSERT OR REPLACE INTO Flavors
			(Type)
VALUES		('FLAVOR_JFD_RELIGIOUS_INTOLERANCE');
------------------------------
-- Leader_Flavors
------------------------------
INSERT INTO Leader_Flavors
			(LeaderType,			FlavorType,							Flavor)
VALUES		('LEADER_GE_WILHELMII',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',	0);
--==========================================================================================================================
-- Policies
--==========================================================================================================================
INSERT INTO Policies
                (Type,               Description,                          IncludesOneShotFreeUnits)
VALUES          ('POLICY_GE_FLEET',  'TXT_KEY_DECISIONS_GE_GERMANY_FLEET', 1),
		        ('POLICY_GE_KWS',	 'TXT_KEY_DECISIONS_GE_GERMANY_KWS',   null);

INSERT INTO Policy_FreeUnitClasses
                (PolicyType,           UnitClassType,    	 		 Count)
VALUES          ('POLICY_GE_FLEET',   'UNITCLASS_GREAT_ADMIRAL',     1);

INSERT INTO Policy_UnitCombatProductionModifiers
                (PolicyType,           UnitCombatType,    	 	 ProductionModifier)
VALUES          ('POLICY_GE_FLEET',   'UNITCOMBAT_NAVALMELEE',   33),
				('POLICY_GE_FLEET',   'UNITCOMBAT_NAVALRANGED',  33),
				('POLICY_GE_FLEET',   'UNITCOMBAT_SUBMARINE',    33),
				('POLICY_GE_FLEET',   'UNITCOMBAT_CARRIER',    	 33);

INSERT INTO Policy_BuildingClassProductionModifiers
                (PolicyType,           BuildingClassType,    	 ProductionModifier)
VALUES          ('POLICY_GE_FLEET',   'BUILDINGCLASS_HARBOR',    50),
				('POLICY_GE_FLEET',   'BUILDINGCLASS_SEAPORT',   50);

INSERT INTO Policy_BuildingClassYieldChanges
                (PolicyType,          BuildingClassType,				  YieldType,   			 YieldChange)
VALUES          ('POLICY_GE_FLEET',   'BUILDINGCLASS_HARBOR',			  'YIELD_PRODUCTION',    1),
				('POLICY_GE_FLEET',   'BUILDINGCLASS_SEAPORT',			  'YIELD_PRODUCTION',    1),
				('POLICY_GE_KWS',	  'BUILDINGCLASS_NATIONAL_COLLEGE',	  'YIELD_SCIENCE',		 2),
				('POLICY_GE_KWS',	  'BUILDINGCLASS_UNIVERSITY',		  'YIELD_SCIENCE',		 1);
--==========================================================================================================================
-- JFD's SOVEREIGNTY
--==========================================================================================================================
-- Civilization_JFD_Governments
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS
    Civilization_JFD_Governments (
    CivilizationType                text        REFERENCES Civilizations(Type)                  default null,
    CultureType                     text                                                        default null,
    LegislatureName                 text                                                        default null,
    OfficeTitle                     text                                                        default null,
    GovernmentType                  text                                                        default null,
    Weight                          integer                                                     default 0);

--This table determines a variety of things relating to your Government.
--The LegislatureName refers to the name of your Legislature (e.g. the Imperial Diet).
--The OfficeTitle refers to the title of your Head of Government (if a Const. Monarchy) (e.g. Vizier. Default is Prime Minister)
--GovernmentType and Weight prefer to a Government preference (GOVERNMENT_JFD_MONARCHY or GOVERNMENT_JFD_REPUBLIC) and how strong that preference is.
INSERT INTO Civilization_JFD_Governments
        (CivilizationType,						 LegislatureName,									  OfficeTitle,                                    GovernmentType,             Weight)
VALUES  ('CIVILIZATION_GREATEREUROPE_GERMANY',   'TXT_KEY_TCM_LEGISLATURE_IMPERIAL_DIET_GE_GERMANY',  'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_GE_GERMANY',  'GOVERNMENT_JFD_MONARCHY',  100);
------------------------------------------------------------
-- Civilization_JFD_HeadsOfGovernment
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS
    Civilization_JFD_HeadsOfGovernment (
    CivilizationType                text        REFERENCES Civilizations(Type)                  default null,
    CultureType                     text                                                        default null,
    HeadOfGovernmentName            text                                                        default null);

--These are the Heads of your Government, which are randomly chosen when a new Legislature is formed.
--The standard number for each civ is 25. However, you may leave this table empty and your civ will call
--from a cultural list (so long as you have Cultural Diversity support).
INSERT INTO Civilization_JFD_HeadsOfGovernment
        (CivilizationType,							HeadOfGovernmentName)
VALUES  ('CIVILIZATION_GREATEREUROPE_GERMANY',       'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_GREATEREUROPE_GERMANY_1'),
		('CIVILIZATION_GREATEREUROPE_GERMANY',       'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_GREATEREUROPE_GERMANY_2'),
		('CIVILIZATION_GREATEREUROPE_GERMANY',       'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_GREATEREUROPE_GERMANY_3'),
		('CIVILIZATION_GREATEREUROPE_GERMANY',       'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_GREATEREUROPE_GERMANY_4'),
		('CIVILIZATION_GREATEREUROPE_GERMANY',       'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_GREATEREUROPE_GERMANY_5'),
		('CIVILIZATION_GREATEREUROPE_GERMANY',       'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_GREATEREUROPE_GERMANY_6'),
		('CIVILIZATION_GREATEREUROPE_GERMANY',       'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_GREATEREUROPE_GERMANY_7'),
		('CIVILIZATION_GREATEREUROPE_GERMANY',       'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_GREATEREUROPE_GERMANY_8'),
		('CIVILIZATION_GREATEREUROPE_GERMANY',       'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_GREATEREUROPE_GERMANY_9'),
		('CIVILIZATION_GREATEREUROPE_GERMANY',       'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_GREATEREUROPE_GERMANY_10'),
		('CIVILIZATION_GREATEREUROPE_GERMANY',       'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_GREATEREUROPE_GERMANY_11'),
		('CIVILIZATION_GREATEREUROPE_GERMANY',       'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_GREATEREUROPE_GERMANY_12'),
		('CIVILIZATION_GREATEREUROPE_GERMANY',       'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_GREATEREUROPE_GERMANY_13'),
		('CIVILIZATION_GREATEREUROPE_GERMANY',       'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_GREATEREUROPE_GERMANY_14'),
		('CIVILIZATION_GREATEREUROPE_GERMANY',       'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_GREATEREUROPE_GERMANY_15'),
		('CIVILIZATION_GREATEREUROPE_GERMANY',       'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_GREATEREUROPE_GERMANY_16'),
		('CIVILIZATION_GREATEREUROPE_GERMANY',       'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_GREATEREUROPE_GERMANY_17'),
		('CIVILIZATION_GREATEREUROPE_GERMANY',       'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_GREATEREUROPE_GERMANY_18'),
		('CIVILIZATION_GREATEREUROPE_GERMANY',       'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_GREATEREUROPE_GERMANY_19'),
		('CIVILIZATION_GREATEREUROPE_GERMANY',       'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_GREATEREUROPE_GERMANY_20'),
		('CIVILIZATION_GREATEREUROPE_GERMANY',       'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_GREATEREUROPE_GERMANY_21'),
		('CIVILIZATION_GREATEREUROPE_GERMANY',       'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_GREATEREUROPE_GERMANY_22'),
		('CIVILIZATION_GREATEREUROPE_GERMANY',       'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_GREATEREUROPE_GERMANY_23'),
		('CIVILIZATION_GREATEREUROPE_GERMANY',       'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_GREATEREUROPE_GERMANY_24'),
		('CIVILIZATION_GREATEREUROPE_GERMANY',       'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_GREATEREUROPE_GERMANY_25');
------------------------------------------------------------
-- Civilization_JFD_Titles
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS
    Civilization_JFD_Titles (
    CivilizationType                text        REFERENCES Civilizations(Type)                  default null,
    CultureType                     text                                                        default null,
    ReligionType                    text        REFERENCES Religions(Type)                      default null,
    DefaultTitle                    text                                                        default null,
    UniqueTitle                     text                                                        default null,
    UseAdjective                    boolean                                                     default 0);

--This lists all the unique titles that a civilization should use instead of a standard one. If left blank, a culture-specific title will be used instead (if CulDiv support).
--The default titles are as follows:
----TXT_KEY_GOVERNMENT_JFD_TRIBE_TITLE_GOVERNMENT (Tribe)
----TXT_KEY_GOVERNMENT_JFD_TRIBE_TITLE_LEADER (Chief/Chieftess)
----TXT_KEY_GOVERNMENT_JFD_PRINCIPALITY_TITLE_LEADER (Grand Prince)
----TXT_KEY_GOVERNMENT_JFD_PRINCIPALITY_TITLE_GOVERNMENT (Grand Principality)
----TXT_KEY_GOVERNMENT_JFD_MONARCHY_TITLE_LEADER (King/Queen)
----TXT_KEY_GOVERNMENT_JFD_MONARCHY_TITLE_GOVERNMENT (Kingdom)
----TXT_KEY_GOVERNMENT_JFD_EMPIRE_TITLE_LEADER (Emperor/Empress)
----TXT_KEY_GOVERNMENT_JFD_EMPIRE_TITLE_GOVERNMENT (Empire)
----TXT_KEY_GOVERNMENT_JFD_COMMONWEALTH_TITLE_GOVERNMENT (Commonwealth)
----TXT_KEY_GOVERNMENT_JFD_REPUBLIC_TITLE_LEADER (Consul)
----TXT_KEY_GOVERNMENT_JFD_REPUBLIC_TITLE_LEADER_LATE (President)
----TXT_KEY_GOVERNMENT_JFD_REPUBLIC_TITLE_GOVERNMENT (Republic)
----TXT_KEY_GOVERNMENT_JFD_DICTATORSHIP_TITLE_LEADER (Dictator)
----TXT_KEY_GOVERNMENT_JFD_FEDERATION_TITLE_GOVERNMENT (Federation)

--For 'LEADER' titles, just include the title in the text, e.g. "Pharoah."
--For 'GOVERNMENT' titles, include a placeholder for your civ's short description, e.g. "Kingdom of {1_CivName}"
--Use 'UseAdjective' when you want the 'GOVERNMENT' title to read (e.g.): "{1_CivAdj} Kingdom" instead of "Kingdom of {1_CivName}"
INSERT INTO Civilization_JFD_Titles
        (CivilizationType,						DefaultTitle,									 UniqueTitle)
VALUES  ('CIVILIZATION_GREATEREUROPE_GERMANY',   'TXT_KEY_GOVERNMENT_JFD_EMPIRE_TITLE_LEADER',    'TXT_KEY_GOVERNMENT_TCM_EMPIRE_TITLE_LEADER_WW1_GERMANY');
------------------------------------------------------------
-- Civilization_JFD_Politics
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS
    Civilization_JFD_Politics (
    CivilizationType                    text        REFERENCES Civilizations(Type)                  default null,
    PoliticsType                        text                                                        default null,
    UniqueName                          text                                                        default null);

--This lists all the unique names for a civ's political parties.
--Political Parties are as follows:
----PARTY_JFD_CLERGY
----PARTY_JFD_NOBILITY
----PARTY_JFD_REVOLUTIONARY
----PARTY_JFD_CONSERVATIVE
----PARTY_JFD_LIBERAL
----PARTY_JFD_REACTIONARY
----PARTY_JFD_SOCIALIST
----PARTY_JFD_COMMUNIST
----PARTY_JFD_FASCIST
----PARTY_JFD_LIBERTARIAN
INSERT INTO Civilization_JFD_Politics
        (CivilizationType,						 PoliticsType,               UniqueName)
VALUES  ('CIVILIZATION_GREATEREUROPE_GERMANY',   'PARTY_JFD_CLERGY',		'TXT_KEY_JFD_PARTY_TCM_WW1_GERMANY_1'),
		('CIVILIZATION_GREATEREUROPE_GERMANY',   'PARTY_JFD_CONSERVATIVE',  'TXT_KEY_JFD_PARTY_TCM_WW1_GERMANY_4'),
		('CIVILIZATION_GREATEREUROPE_GERMANY',   'PARTY_JFD_LIBERAL',		'TXT_KEY_JFD_PARTY_TCM_WW1_GERMANY_5'),
		('CIVILIZATION_GREATEREUROPE_GERMANY',   'PARTY_JFD_SOCIALIST',		'TXT_KEY_JFD_PARTY_TCM_WW1_GERMANY_7'),
		('CIVILIZATION_GREATEREUROPE_GERMANY',   'PARTY_JFD_FASCIST',		'TXT_KEY_JFD_PARTY_TCM_WW1_GERMANY_9');
------------------------------------------------------------
-- Flavors
------------------------------------------------------------
INSERT OR REPLACE INTO Flavors 
        (Type)
VALUES  ('FLAVOR_JFD_REFORM_GOVERNMENT'),
        ('FLAVOR_JFD_REFORM_CULTURE'),
        ('FLAVOR_JFD_REFORM_ECONOMIC'),
        ('FLAVOR_JFD_REFORM_FOREIGN'),
        ('FLAVOR_JFD_REFORM_INDUSTRY'),
        ('FLAVOR_JFD_REFORM_MILITARY'),
        ('FLAVOR_JFD_REFORM_RELIGION');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------
--Each flavour corresponds to one of the seven Reform Categories, and how likely a civ is to take a reform in either the Right, Centre, or Left column.
--A value of 1-3 will favour Left Reforms. A value of 4-6 will value Centre Reforms. A value of 7-10 will value Right Reforms. The strength of the value will determine how soon a Leader will implement that Reform.
INSERT INTO Leader_Flavors
        (LeaderType,			   FlavorType,                         Flavor)
VALUES  ('LEADER_GE_WILHELMII',    'FLAVOR_JFD_REFORM_GOVERNMENT',     7),
        ('LEADER_GE_WILHELMII',    'FLAVOR_JFD_REFORM_CULTURE',        3),
        ('LEADER_GE_WILHELMII',    'FLAVOR_JFD_REFORM_ECONOMIC',       6),
        ('LEADER_GE_WILHELMII',    'FLAVOR_JFD_REFORM_FOREIGN',        7),
        ('LEADER_GE_WILHELMII',    'FLAVOR_JFD_REFORM_INDUSTRY',       6),
        ('LEADER_GE_WILHELMII',    'FLAVOR_JFD_REFORM_RELIGION',       4);
--==========================================================================================================================
--==========================================================================================================================
