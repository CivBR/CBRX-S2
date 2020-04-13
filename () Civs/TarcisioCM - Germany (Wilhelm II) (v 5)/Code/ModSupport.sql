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
     
INSERT OR REPLACE INTO Leader_SharedTraits
            (LeaderType,			 TraitOne,               TraitTwo)
VALUES      ('LEADER_GE_WILHELMII',	 'POLICY_AGGRESSIVE_X',	 'POLICY_EXPANSIVE_X');
------------------------------	
-- Leaders
------------------------------	
UPDATE Leaders 
SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X' )
	THEN 'Wilhelm II [ICON_WAR][ICON_CITY_STATE]'
	ELSE 'TXT_KEY_LEADER_GE_WILHELMII' END) 
WHERE Type = 'LEADER_GE_WILHELMII';

CREATE TRIGGER CivIVTraitsParthia
AFTER INSERT ON Leaders WHEN 'LEADER_GE_WILHELMII' = NEW.Type
BEGIN
	UPDATE Leaders 
	SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X' )
		THEN 'Wilhelm II [ICON_WAR][ICON_CITY_STATE]'
		ELSE 'TXT_KEY_LEADER_GE_WILHELMII' END) 
	WHERE Type = 'LEADER_GE_WILHELMII';
END;
--==========================================================================================================================
-- BrutalSamurai's Ethnic Units/Gedemon's R.E.D.
--==========================================================================================================================
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_GERMANY' )
	THEN '_GERMANY'
	ELSE '_EURO' END) 
WHERE Type = 'CIVILIZATION_GREATEREUROPE_GERMANY';
--==========================================================================================================================
-- Hazel's Map Labels
--==========================================================================================================================
-- ML_CivCultures
------------------------------	
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
			(CivType,									CultureType,	CultureEra)
VALUES		('CIVILIZATION_GREATEREUROPE_GERMANY',		'GERMANIC ',		'ANY');
--==========================================================================================================================
-- JFD's Cultural Diversity
--==========================================================================================================================
-- Civilization_JFD_CultureTypes
------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes(
    CivilizationType                            text    REFERENCES Civilizations(Type)          default null,
    CultureType                                 text                                            default null,
    ArtDefineTag                                text                                            default null,
    SplashScreenTag                             text                                            default null,
    SoundtrackTag                               text                                            default null,
    UnitDialogueTag                             text                                            default null);

INSERT INTO Civilization_JFD_CultureTypes
        (CivilizationType,              ArtDefineTag, CultureType, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT  ('CIVILIZATION_GREATEREUROPE_GERMANY'),    ArtDefineTag, CultureType, SplashScreenTag, SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_GERMANY';
 
UPDATE Civilizations 
SET SoundtrackTag = 'JFD_Central'
WHERE Type = 'CIVILIZATION_GREATEREUROPE_GERMANY'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Central');
--==========================================================================================================================
-- JFD's Exploration Continued Expanded
--==========================================================================================================================
-- Civilization_JFD_ColonialCityNames
------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_ColonialCityNames (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	ColonyName 									text										default null,
	LinguisticType								text										default	null,
	CultureType									text										default	null);

INSERT OR REPLACE INTO Civilization_JFD_ColonialCityNames
			(CivilizationType, 						LinguisticType)
VALUES		('CIVILIZATION_GREATEREUROPE_GERMANY',	'JFD_Germanic');
------------------------------		
-- Civilization_JFD_RevolutionaryCivilizationsToSpawn
------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_RevolutionaryCivilizationsToSpawn (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	RevolutionaryCivilizationType 				text 	REFERENCES Civilizations(Type) 		default null);
	
INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,						RevolutionaryCivilizationType)
VALUES		('CIVILIZATION_GREATEREUROPE_GERMANY','CIVILIZATION_GERMANY'),
			('CIVILIZATION_GERMANY',			  'CIVILIZATION_GREATEREUROPE_GERMANY');

INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,						RevolutionaryCivilizationType)
SELECT		('CIVILIZATION_GREATEREUROPE_GERMANY'),	('CIVILIZATION_JFD_NAZI_GERMANY')
WHERE EXISTS (SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_JFD_NAZI_GERMANY');
--==========================================================================================================================
-- DecisionsAddin_Support
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('ge_WilhelmIIDecisions.lua');
--==========================================================================================================================
-- EventsAddin_Support
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS EventsAddin_Support(FileName);
INSERT INTO EventsAddin_Support (FileName) VALUES ('ge_WilhelmIIEvents.lua');
--==========================================================================================================================
-- Gedemon's YnAEMP
--==========================================================================================================================
-- Civilizations_YagemStartPosition (Earth Giant)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
			(Type,														X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_GREATEREUROPE_GERMANY',						22,		69,		null,	null);
--==========================================================================================================================
-- Civilizations_YahemStartPosition (Earth Huge)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
			(Type,														X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_GREATEREUROPE_GERMANY',						64,		61,		null,	null);
--==========================================================================================================================
-- Civilizations_CordiformStartPosition (Earth Standard)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
			(Type,														X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_GREATEREUROPE_GERMANY',						39,		32,		null,	null);
--==========================================================================================================================
-- Civilizations_EuroLargeStartPosition (Europe Large)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroLargeStartPosition
			(Type,														X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_GREATEREUROPE_GERMANY',						36,		49,		null,	null);
--==========================================================================================================================
-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
			(Type,														X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_GREATEREUROPE_GERMANY',						51,		53,		null,	null);
--==========================================================================================================================
-- Civilizations_NorthAtlanticStartPosition 
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_NorthAtlanticStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthAtlanticStartPosition
			(Type,														X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_GREATEREUROPE_GERMANY',						92,		37,		null,	null);
--==========================================================================================================================
-- Civilizations_NorthWestEuropeStartPosition 
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_NorthWestEuropeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthWestEuropeStartPosition
			(Type,														X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_GREATEREUROPE_GERMANY',						41,		19,		null,	null);
--==========================================================================================================================
-- Civilizations_YagemRequestedResource (Earth Giant)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource
			(Type, 														Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_GREATEREUROPE_GERMANY'),						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE Type = 'CIVILIZATION_GERMANY';
--==========================================================================================================================
-- Civilizations_YahemRequestedResource (Earth Huge)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_YahemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YahemRequestedResource
			(Type, 														Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_GREATEREUROPE_GERMANY'),						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE Type = 'CIVILIZATION_GERMANY';
--==========================================================================================================================
-- Civilizations_EuroLargeRequestedResource (Europe Large)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_EuroLargeRequestedResource
			(Type, 														Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_GREATEREUROPE_GERMANY'),						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_EuroLargeRequestedResource WHERE Type = 'CIVILIZATION_GERMANY';
--==========================================================================================================================
-- Civilizations_GreatestEarthRequestedResource (Earth Greatest)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_GreatestEarthRequestedResource
			(Type, 														Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_GREATEREUROPE_GERMANY'),						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_GreatestEarthRequestedResource WHERE Type = 'CIVILIZATION_GERMANY';
--==========================================================================================================================
--==========================================================================================================================
--==========================================================================================================================    
-- JFD's and Pouakai's MERCENARIES
--==========================================================================================================================
-- Flavors
------------------------------------------------------------    
INSERT OR REPLACE INTO Flavors 
        (Type)
VALUES  ('FLAVOR_JFD_MERCENARY');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------    
--A value of 0-10 may be set. This value determines the likelihood that a leader will take out Mercenary Contracts (provided they have the funds).
--A value of 10 means this civilization will always take a Contract if available. A value of 0 means this civilization will never take out a contract.
INSERT INTO Leader_Flavors
        (LeaderType,                FlavorType,                 Flavor)
VALUES  ('LEADER_GE_WILHELMII',    'FLAVOR_JFD_MERCENARY',     2);
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
