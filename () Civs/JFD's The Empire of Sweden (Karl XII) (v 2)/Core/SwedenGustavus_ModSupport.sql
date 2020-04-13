--==========================================================================================================================
-- GEDEMON R.E.D.
--==========================================================================================================================
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_SWEDEN' )
	THEN '_SWEDEN'
	ELSE '_EURO' END) 
WHERE Type = 'CIVILIZATION_JFD_SWEDEN_GUSTAV';
--==========================================================================================================================
-- GEDEMON YNAEMP
--==========================================================================================================================
-- Civilizations_YagemStartPosition (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
		(Type,								X,	Y)
SELECT	'CIVILIZATION_JFD_SWEDEN_GUSTAV',	X,	Y
FROM Civilizations_YagemStartPosition WHERE Type = 'CIVILIZATION_SWEDEN';
------------------------------------------------------------	
-- Civilizations_YahemStartPosition (Earth Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
		(Type,								X,	Y)
SELECT	'CIVILIZATION_JFD_SWEDEN_GUSTAV',	X,	Y
FROM Civilizations_YahemStartPosition WHERE Type = 'CIVILIZATION_SWEDEN';
------------------------------------------------------------	
-- Civilizations_CordiformStartPosition (Earth Standard)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
		(Type,								X,	Y)
SELECT	'CIVILIZATION_JFD_SWEDEN_GUSTAV',	X,	Y
FROM Civilizations_CordiformStartPosition WHERE Type = 'CIVILIZATION_SWEDEN';
------------------------------------------------------------	
-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
		(Type,								X,	Y)
SELECT	'CIVILIZATION_JFD_SWEDEN_GUSTAV',	X,	Y
FROM Civilizations_GreatestEarthStartPosition WHERE Type = 'CIVILIZATION_SWEDEN';
------------------------------------------------------------	
-- Civilizations_EuroGiantStartPosition (Europe Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroGiantStartPosition
		(Type,								X,	Y)
SELECT	'CIVILIZATION_JFD_SWEDEN_GUSTAV',	X,	Y
FROM Civilizations_EuroGiantStartPosition WHERE Type = 'CIVILIZATION_SWEDEN';
------------------------------------------------------------	
-- Civilizations_EuroLargeStartPosition (Europe Large)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroLargeStartPosition
		(Type,								X,	Y)
SELECT	'CIVILIZATION_JFD_SWEDEN_GUSTAV',	X,	Y
FROM Civilizations_EuroLargeStartPosition WHERE Type = 'CIVILIZATION_SWEDEN';
------------------------------------------------------------	
-- Civilizations_NorthAtlanticStartPosition (North Atlantic)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthAtlanticStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthAtlanticStartPosition
		(Type,								X,	Y)
SELECT	'CIVILIZATION_JFD_SWEDEN_GUSTAV',	X,	Y
FROM Civilizations_NorthAtlanticStartPosition WHERE Type = 'CIVILIZATION_SWEDEN';
------------------------------------------------------------	
-- Civilizations_AmericasStartPosition (Americas)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AmericasStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AmericasStartPosition
		(Type,								X,	Y)
SELECT	'CIVILIZATION_JFD_SWEDEN_GUSTAV',	X,	Y
FROM Civilizations_AmericasStartPosition WHERE Type = 'CIVILIZATION_SWEDEN';
------------------------------------------------------------	
-- Civilizations_NorthWestEuropeStartPosition (North-West Europe)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthWestEuropeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthWestEuropeStartPosition
		(Type,								X,	Y)
SELECT	'CIVILIZATION_JFD_SWEDEN_GUSTAV',	X,	Y
FROM Civilizations_NorthWestEuropeStartPosition WHERE Type = 'CIVILIZATION_SWEDEN';
------------------------------------------------------------	
-- Civilizations_YagemRequestedResource (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_SWEDEN_GUSTAV',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE Type = 'CIVILIZATION_SWEDEN';
------------------------------------------------------------	
-- Civilizations_YahemRequestedResource (Earth Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YahemRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_SWEDEN_GUSTAV',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE Type = 'CIVILIZATION_SWEDEN';
------------------------------------------------------------	
-- Civilizations_GreatestEarthRequestedResource (Earth Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_GreatestEarthRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_SWEDEN_GUSTAV',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_GreatestEarthRequestedResource WHERE Type = 'CIVILIZATION_SWEDEN';
------------------------------------------------------------	
-- Civilizations_EuroLargeRequestedResource (Europe Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroGiantRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_EuroGiantRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_SWEDEN_GUSTAV',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_EuroGiantRequestedResource WHERE Type = 'CIVILIZATION_SWEDEN';
------------------------------------------------------------	
-- Civilizations_EuroLargeRequestedResource (Europe Large)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_EuroLargeRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_SWEDEN_GUSTAV',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_EuroLargeRequestedResource WHERE Type = 'CIVILIZATION_SWEDEN';
------------------------------------------------------------	
-- Civilizations_AmericasRequestedResource (Americas)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AmericasRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AmericasRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_SWEDEN_GUSTAV',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AmericasRequestedResource WHERE Type = 'CIVILIZATION_SWEDEN';
------------------------------------------------------------	
-- Civilizations_NorthAtlanticRequestedResource (North Atlantic)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthAtlanticRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_NorthAtlanticRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_SWEDEN_GUSTAV',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_NorthAtlanticRequestedResource WHERE Type = 'CIVILIZATION_SWEDEN';
------------------------------------------------------------	
-- Civilizations_NorthWestEuropeRequestedResource (North-West Europe)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthWestEuropeRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_NorthWestEuropeRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_SWEDEN_GUSTAV',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_NorthWestEuropeRequestedResource WHERE Type = 'CIVILIZATION_SWEDEN';
--==========================================================================================================================
-- Hazel's Map Labels
--==========================================================================================================================
-- ML_CivCultures
------------------------------	
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
		(CivType,							CultureType,	CultureEra)
VALUES	('CIVILIZATION_JFD_SWEDEN_GUSTAV',	'GERMANIC',		'ANY');
--==========================================================================================================================
-- JFD CULTURAL DIVERSITY
--==========================================================================================================================
-- Civilization_JFD_CultureTypes
------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes(
	CivilizationType 							text 	REFERENCES Civilizations(Type) 			default null,
	CultureType 								text											default null,
	ArtDefineTag								text											default	null,
	IdealsTag									text											default	null,
	SplashScreenTag								text											default	null,
	SoundtrackTag								text											default	null,
	UnitDialogueTag								text											default null);

INSERT INTO Civilization_JFD_CultureTypes
		(CivilizationType,					ArtDefineTag, CultureType, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT	'CIVILIZATION_JFD_SWEDEN_GUSTAV',	ArtDefineTag, CultureType, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_SWEDEN';
------------------------------	
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET SoundtrackTag = 'JFD_Western'
WHERE Type = 'CIVILIZATION_JFD_SWEDEN_GUSTAV'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Western')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CULDIV_SOUNDTRACK_ADDON' AND Value = 1);
--==========================================================================================================================
-- JFD COLONIES
--==========================================================================================================================
-- Civilization_JFD_ColonialCityNames
------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_ColonialCityNames (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	ColonyName 									text										default null,
	LinguisticType								text										default	null,
	CultureType									text										default	null);

INSERT INTO Civilization_JFD_ColonialCityNames
		(CivilizationType,					ColonyName,	 LinguisticType)
SELECT	'CIVILIZATION_JFD_SWEDEN_GUSTAV',	ColonyName,	 LinguisticType
FROM Civilization_JFD_ColonialCityNames WHERE CivilizationType = 'CIVILIZATION_SWEDEN';
--==========================================================================================================================
-- JFD PROSPERITY
--==========================================================================================================================
-- Civilization_JFD_Currencies
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Currencies (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 	default null,
	CurrencyType	  				text 		  								default null);

INSERT INTO Civilization_JFD_Currencies
		(CivilizationType,					CurrencyType)
SELECT	'CIVILIZATION_JFD_SWEDEN_GUSTAV',	CurrencyType
FROM Civilization_JFD_Currencies WHERE CivilizationType = 'CIVILIZATION_SWEDEN';
--==========================================================================================================================	
-- JFD SOVEREIGNTY
--==========================================================================================================================
-- Civilization_JFD_Governments
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Governments (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 			default null,
	CultureType	  					text 		 										default null,
	LegislatureName					text												default	null,
	OfficeTitle						text												default	null,
	GovernmentType					text												default	null,
	Weight							integer												default	0);
	
INSERT INTO Civilization_JFD_Governments
		(CivilizationType,					LegislatureName, OfficeTitle, GovernmentType, Weight)
SELECT	'CIVILIZATION_JFD_SWEDEN_GUSTAV',	LegislatureName, OfficeTitle, GovernmentType, Weight
FROM Civilization_JFD_Governments WHERE CivilizationType = 'CIVILIZATION_SWEDEN';
------------------------------------------------------------	
-- Civilization_JFD_HeadsOfGovernment	
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 	
	Civilization_JFD_HeadsOfGovernment (	
	CivilizationType  				text 		REFERENCES Civilizations(Type) 					default null,
	CultureType						text 		 												default null,
	HeadOfGovernmentName			text 		 												default null);

INSERT INTO Civilization_JFD_HeadsOfGovernment
        (CivilizationType,      			HeadOfGovernmentName)
SELECT  'CIVILIZATION_JFD_SWEDEN_GUSTAV',	HeadOfGovernmentName
FROM Civilization_JFD_HeadsOfGovernment WHERE CivilizationType = 'CIVILIZATION_SWEDEN';
------------------------------------------------------------
-- Civilization_JFD_Titles
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Titles (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 					default null,
	CultureType						text 		 												default null,
	ReligionType					text 		REFERENCES Religions(Type) 						default null,
	DefaultTitle					text 		 												default null,
	UniqueTitle						text 		 												default null,
	UseAdjective					boolean														default 0);	
	
INSERT INTO Civilization_JFD_Titles
		(CivilizationType,						DefaultTitle,	UniqueTitle,	UseAdjective)
SELECT	'CIVILIZATION_JFD_SWEDEN_GUSTAV',		DefaultTitle,	UniqueTitle,	UseAdjective
FROM Civilization_JFD_Titles WHERE CivilizationType = 'CIVILIZATION_SWEDEN';
------------------------------------------------------------
-- Civilization_JFD_Politics
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Politics (
	CivilizationType  					text 		REFERENCES Civilizations(Type) 					default null,
	PoliticsType  						text 														default null,
	UniqueName							text														default	null);

INSERT INTO Civilization_JFD_Politics
		(CivilizationType,					PoliticsType, UniqueName)
SELECT	'CIVILIZATION_JFD_SWEDEN_GUSTAV',	PoliticsType, UniqueName
FROM Civilization_JFD_Politics WHERE CivilizationType = 'CIVILIZATION_SWEDEN';
--==========================================================================================================================
-- POUAKAI ENLIGHTENMENT ERA
--==========================================================================================================================
-- Units
------------------------------
DELETE FROM Units WHERE Type = 'UNIT_JFD_REGAL_SHIP'
AND EXISTS (SELECT * FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');
INSERT INTO Units 	
		(Type, 					Class, 	PrereqTech, RangedCombat, Range, Special, Combat, Cost, FaithCost, RequiresFaithPurchaseEnabled, Moves, CombatClass, Domain, DefaultUnitAI, Description, 					Civilopedia, 						Strategy, 									Help, 								Pillage, MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, Mechanized, AdvancedStartCost, RangedCombatLimit, CombatLimit, XPValueDefense, UnitArtInfo, 					UnitFlagIconOffset, UnitFlagAtlas,						PortraitIndex, 	IconAtlas,					MoveRate)
SELECT	'UNIT_JFD_REGAL_SHIP',	Class,	PrereqTech, RangedCombat, Range, Special, Combat, Cost, FaithCost, RequiresFaithPurchaseEnabled, Moves, CombatClass, Domain, DefaultUnitAI, 'TXT_KEY_UNIT_JFD_REGAL_SHIP',	'TXT_KEY_CIV5_JFD_REGAL_SHIP_TEXT', 'TXT_KEY_UNIT_JFD_REGAL_SHIP_STRATEGY_EE',  'TXT_KEY_UNIT_HELP_JFD_REGAL_SHIP', Pillage, MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, Mechanized, AdvancedStartCost, RangedCombatLimit, CombatLimit, XPValueDefense, 'ART_DEF_UNIT_JFD_REGAL_SHIP', 0,					'JFD_UNIT_FLAG_REGAL_SHIP_ATLAS',	2, 				'JFD_SWEDEN_KARL_ATLAS',	MoveRate
FROM Units WHERE Type = 'UNIT_EE_GALLEON'
AND EXISTS (SELECT * FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');
------------------------------	
-- Unit_ClassUpgrades
------------------------------	
DELETE FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_JFD_REGAL_SHIP'
AND EXISTS (SELECT * FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');
INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 				UnitClassType)
SELECT	'UNIT_JFD_REGAL_SHIP',	UnitClassType
FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_EE_GALLEON'
AND EXISTS (SELECT * FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');
--------------------------------
-- Unit_FreePromotions
--------------------------------
DELETE FROM Unit_FreePromotions WHERE UnitType = 'UNIT_JFD_REGAL_SHIP'
AND EXISTS (SELECT * FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');
INSERT INTO Unit_FreePromotions 	
		(UnitType, 				PromotionType)
SELECT	'UNIT_JFD_REGAL_SHIP', 	PromotionType
FROM Unit_FreePromotions WHERE UnitType = 'UNIT_EE_GALLEON'
AND EXISTS (SELECT * FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');

INSERT INTO Unit_FreePromotions 	
		(UnitType, 				PromotionType)
SELECT	'UNIT_JFD_REGAL_SHIP',  Type
FROM UnitPromotions WHERE Type IN ('PROMOTION_JFD_REGAL_SHIP_COAST', 'PROMOTION_JFD_REGAL_SHIP')
AND EXISTS (SELECT * FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');
--------------------------------	
-- Unit_ResourceQuantityRequirements
--------------------------------	
DELETE FROM Unit_ResourceQuantityRequirements WHERE UnitType = 'UNIT_JFD_REGAL_SHIP'
AND EXISTS (SELECT * FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');
INSERT INTO Unit_ResourceQuantityRequirements 	
		(UnitType, 				ResourceType, Cost)
SELECT	'UNIT_JFD_REGAL_SHIP', 	ResourceType, Cost
FROM Unit_ResourceQuantityRequirements WHERE UnitType = 'UNIT_EE_GALLEON'
AND EXISTS (SELECT * FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');
------------------------------	
-- Civilization_UnitClassOverrides
------------------------------
UPDATE Civilization_UnitClassOverrides
SET UnitClassType = 'UNITCLASS_EE_GALLEON'
WHERE CivilizationType = 'CIVILIZATION_JFD_SWEDEN_GUSTAV' AND UnitType = 'UNIT_JFD_REGAL_SHIP'
AND EXISTS (SELECT * FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');
--==========================================================================================================================
-- SUKRITACT DECISIONS
--==========================================================================================================================
-- DecisionsAddin_Support
------------------------------
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('JFD_SwedenGustavus_Decisions.lua');
------------------------------
-- Policies
------------------------------
INSERT INTO Policies
		(Type,											Description)
VALUES	('POLICY_DECISIONS_JFD_SWEDEN_ORDINANCE_ALSNO',	'TXT_KEY_DECISIONS_SWEDENINDELNINGSVERKET');
------------------------------
-- Policy_UnitCombatProductionModifiers
------------------------------
INSERT INTO Policy_UnitCombatProductionModifiers
		(PolicyType,									UnitCombatType,			ProductionModifier)
VALUES	('POLICY_DECISIONS_JFD_SWEDEN_ORDINANCE_ALSNO', 'UNITCOMBAT_MOUNTED',	15);
--==========================================================================================================================
--==========================================================================================================================