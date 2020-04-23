--==========================================================================================================================
-- MASTER TABLES
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS COMMUNITY (Type TEXT, Value INTEGER);
CREATE TABLE IF NOT EXISTS Civilization_JFD_ColonialCityNames(CivilizationType text, ColonyName text, LinguisticType text);
CREATE TABLE IF NOT EXISTS Civilization_JFD_Governments(CivilizationType text, CultureType text, LegislatureName text, OfficeTitle text, GovernmentType text, Weight integer);
CREATE TABLE IF NOT EXISTS Civilizations_YnAEMP(CivilizationType, MapPrefix, X, Y, CapitalName, AltX, AltY, AltCapitalName);
CREATE TABLE IF NOT EXISTS Civilizations_YnAEMPRequestedResources(CivilizationType, MapPrefix, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4, Req5, Yield5, Req6, Yield6);
CREATE TABLE IF NOT EXISTS JFD_Civilopedia_HideFromPedia(Type text);
CREATE TABLE IF NOT EXISTS JFD_GlobalUserSettings(Type text, Value integer default 1);
CREATE TABLE IF NOT EXISTS MinorCivilizations_YnAEMP(MinorCivType, MapPrefix, X, Y, CapitalName, AltX, AltY, AltCapitalName);
--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================		
-- Buildings
--------------------------------------------------------------------------------------------------------------------------	
INSERT OR REPLACE INTO Buildings 																																		 																																							 
		(Type, 						TrainedFreePromotion,		 BuildingClass, Cost, FaithCost, SpecialistType, SpecialistCount, UnlockedByBelief, GoldMaintenance,  FreeStartEra, PrereqTech, Description,						 Help, 										Strategy, 										Civilopedia, 						ArtDefineTag, MinAreaSize, HurryCostModifier, IconAtlas,				ConquestProb, PortraitIndex)
SELECT	'BUILDING_JFD_PHAUNDARI',	'PROMOTION_GENERAL_STACKING', BuildingClass, Cost, FaithCost, SpecialistType, SpecialistCount, UnlockedByBelief, GoldMaintenance,  FreeStartEra, PrereqTech, 'TXT_KEY_BUILDING_JFD_PHAUNDARI', 'TXT_KEY_BUILDING_HELP_JFD_PHAUNDARI_EE',	'TXT_KEY_BUILDING_JFD_PHAUNDARI_STRATEGY_EE',	'TXT_KEY_CIV5_JFD_PHAUNDARI_TEXT',  ArtDefineTag, MinAreaSize, HurryCostModifier, 'JFD_PUNJAB_ICON_ATLAS',	ConquestProb, 3
FROM Buildings WHERE Type = 'BUILDING_EE_GUNSMITH'
AND EXISTS (SELECT Type FROM Buildings WHERE Type = 'BUILDING_EE_GUNSMITH');
--------------------------------------------------------------------------------------------------------------------------		
-- Building_ClassesNeededInCity
--------------------------------------------------------------------------------------------------------------------------
DELETE FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_JFD_PHAUNDARI'
AND EXISTS (SELECT Type FROM Buildings WHERE Type = 'BUILDING_EE_GUNSMITH');
INSERT INTO Building_ClassesNeededInCity
		(BuildingType, 				BuildingClassType)
SELECT	'BUILDING_JFD_PHAUNDARI',	BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_ARSENAL'
AND EXISTS (SELECT Type FROM Buildings WHERE Type = 'BUILDING_EE_GUNSMITH');
--------------------------------------------------------------------------------------------------------------------------	
-- Building_DomainProductionModifiers
--------------------------------------------------------------------------------------------------------------------------			
INSERT INTO Building_UnitCombatProductionModifiers 
		(BuildingType, 				UnitCombatType,	 Modifier)
SELECT	'BUILDING_JFD_PHAUNDARI',	UnitCombatType,	 Modifier
FROM Building_UnitCombatProductionModifiers WHERE BuildingType = 'BUILDING_EE_GUNSMITH'
AND EXISTS (SELECT Type FROM Buildings WHERE Type = 'BUILDING_EE_GUNSMITH');
--------------------------------------------------------------------------------------------------------------------------		
-- Civilization_BuildingClassOverrides
--------------------------------------------------------------------------------------------------------------------------
DELETE FROM Civilization_BuildingClassOverrides WHERE BuildingType = 'BUILDING_JFD_PHAUNDARI'
AND EXISTS (SELECT Type FROM Buildings WHERE Type = 'BUILDING_EE_GUNSMITH');
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 			BuildingClassType, 			  BuildingType)
SELECT	'CIVILIZATION_JFD_PUNJAB', 'BUILDINGCLASS_EE_GUNSMITH',  'BUILDING_JFD_PHAUNDARI'
WHERE EXISTS (SELECT Type FROM Buildings WHERE Type = 'BUILDING_EE_GUNSMITH');
--==========================================================================================================================
-- LEADERS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- Flavors
--------------------------------------------------------------------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_DECOLONIZATION'),
		('FLAVOR_JFD_MERCENARY'),
		('FLAVOR_JFD_REFORM_GOVERNMENT'),
		('FLAVOR_JFD_REFORM_LAW'),
		('FLAVOR_JFD_REFORM_CULTURE'),
		('FLAVOR_JFD_REFORM_ECONOMY'),
		('FLAVOR_JFD_REFORM_EDUCATION'),
		('FLAVOR_JFD_REFORM_FOREIGN'),
		('FLAVOR_JFD_REFORM_INDUSTRY'),
		('FLAVOR_JFD_REFORM_MILITARY'),
		('FLAVOR_JFD_REFORM_RELIGION'),
		('FLAVOR_JFD_RELIGIOUS_INTOLERANCE'),
		('FLAVOR_JFD_SLAVERY'),
		('FLAVOR_JFD_STATE_RELIGION');
--------------------------------------------------------------------------------------------------------------------------
-- Leader_Flavors
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Leader_Flavors
		(LeaderType,				FlavorType,							 Flavor)
VALUES	('LEADER_JFD_RANJIT_SINGH',	'FLAVOR_JFD_DECOLONIZATION',		 5),
		('LEADER_JFD_RANJIT_SINGH',	'FLAVOR_JFD_MERCENARY',				 8),
		('LEADER_JFD_RANJIT_SINGH',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',	 3),
		('LEADER_JFD_RANJIT_SINGH',	'FLAVOR_JFD_REFORM_GOVERNMENT',		 6),
		('LEADER_JFD_RANJIT_SINGH',	'FLAVOR_JFD_REFORM_LAW',			 5),
		('LEADER_JFD_RANJIT_SINGH',	'FLAVOR_JFD_REFORM_CULTURE',		 4),
		('LEADER_JFD_RANJIT_SINGH',	'FLAVOR_JFD_REFORM_ECONOMY',		 5),
		('LEADER_JFD_RANJIT_SINGH',	'FLAVOR_JFD_REFORM_EDUCATION',		 5),
		('LEADER_JFD_RANJIT_SINGH',	'FLAVOR_JFD_REFORM_FOREIGN',		 7),
		('LEADER_JFD_RANJIT_SINGH',	'FLAVOR_JFD_REFORM_INDUSTRY',		 7),
		('LEADER_JFD_RANJIT_SINGH',	'FLAVOR_JFD_REFORM_MILITARY',		 7),
		('LEADER_JFD_RANJIT_SINGH',	'FLAVOR_JFD_REFORM_RELIGION',		 6),
		('LEADER_JFD_RANJIT_SINGH',	'FLAVOR_JFD_SLAVERY',				 4),
		('LEADER_JFD_RANJIT_SINGH',	'FLAVOR_JFD_STATE_RELIGION',		 8);
--==========================================================================================================================
-- CIVILIZATIONS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_JFD_Governments
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Civilization_JFD_Governments
		(CivilizationType,			GovernmentType,				Weight)
VALUES  ('CIVILIZATION_JFD_PUNJAB',	'GOVERNMENT_JFD_THEOCRACY',	60);
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_YnAEMP
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Civilizations_YnAEMP
		(CivilizationType,			MapPrefix,			X,		Y,		AltX,	AltY,	AltCapitalName)
VALUES	('CIVILIZATION_JFD_PUNJAB',	'AfriAsiaAust',		72,		65,		null,	null,	null),
		('CIVILIZATION_JFD_PUNJAB',	'Asia',				23,		37,		null,	null,	null),
		('CIVILIZATION_JFD_PUNJAB',	'Cordiform',		56,		22,		null,	null,	null),
		('CIVILIZATION_JFD_PUNJAB',	'GreatestEarth',	74,		39,		null,	null,	null),
		('CIVILIZATION_JFD_PUNJAB',	'EastAsia',			75,		62,		null,	null,	null),
		('CIVILIZATION_JFD_PUNJAB',	'India',			30,		53,		null,	null,	null),
		('CIVILIZATION_JFD_PUNJAB',	'IndiaGiant',		22,		108,	null,	null,	null),
		('CIVILIZATION_JFD_PUNJAB',	'IndianOcean',		44,		70,		null,	null,	null),
		('CIVILIZATION_JFD_PUNJAB',	'Orient',			98,		45,		null,	null,	null),
		('CIVILIZATION_JFD_PUNJAB',	'Pacific',			4,		52,		null,	null,	null),
		('CIVILIZATION_JFD_PUNJAB',	'SouthAsiaHuge',	22,		58,		null,	null,	null),
		('CIVILIZATION_JFD_PUNJAB',	'Yagem',			58,		49,		null,	null,	null),
		('CIVILIZATION_JFD_PUNJAB',	'Yahem',			87,		48,		null,	null,	null);
--------------------------------------------------------------------------------------------------------------------------	
-- Civilizations_YnAEMPRequestedResources
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Civilizations_YnAEMPRequestedResources
		(CivilizationType,			MapPrefix, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4, Req5, Yield5, Req6, Yield6)
SELECT	'CIVILIZATION_JFD_PUNJAB',	MapPrefix, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4, Req5, Yield5, Req6, Yield6
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_INDIA';
--------------------------------------------------------------------------------------------------------------------------
-- Civilization_JFD_CultureTypes
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_CultureTypes(
	CivilizationType 					text 		REFERENCES Civilizations(Type) 		default null,
	CultureType 						text											default null,
	SubCultureType 						text											default null,
	ArtDefineTag						text											default	null,
	DecisionsTag						text											default	null,
	DefeatScreenEarlyTag				text											default	null,
	DefeatScreenMidTag					text											default	null,
	DefeatScreenLateTag					text											default	null,
	IdealsTag							text											default	null,
	SplashScreenTag						text											default	null,
	SoundtrackTag						text											default	null,
	UnitDialogueTag						text											default null);

INSERT INTO Civilization_JFD_CultureTypes
		(CivilizationType,			ArtDefineTag, CultureType, SubCultureType, DecisionsTag, DefeatScreenEarlyTag, DefeatScreenMidTag, DefeatScreenLateTag, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT	'CIVILIZATION_JFD_PUNJAB',	ArtDefineTag, CultureType, SubCultureType, DecisionsTag, DefeatScreenEarlyTag, DefeatScreenMidTag, DefeatScreenLateTag, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_INDIA';

UPDATE Civilizations 
SET SoundtrackTag = 'JFD_Bharata'
WHERE Type = 'CIVILIZATION_JFD_PUNJAB'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Bharata')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CULDIV_SOUNDTRACK_ADDON' AND Value = 1);
--==========================================================================================================================
--==========================================================================================================================

