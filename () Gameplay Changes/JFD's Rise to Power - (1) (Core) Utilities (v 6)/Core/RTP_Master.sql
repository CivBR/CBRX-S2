--==========================================================================================================================
-- CUSTOM MOD OPTIONS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- CustomModOptions
-------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CustomModOptions(Name Text, Value INTEGER, Class INTEGER, DbUpdates INTEGER);

INSERT OR REPLACE INTO CustomModOptions(Name, Value) VALUES('API_EXTENSIONS', 1);
INSERT OR REPLACE INTO CustomModOptions(Name, Value) VALUES('API_LUA_EXTENSIONS', 1);
INSERT OR REPLACE INTO CustomModOptions(Name, Value) VALUES('BALANCE_CORE_JFD', 1); 
INSERT OR REPLACE INTO CustomModOptions(Name, Value) VALUES('BALANCE_CORE_POLICIES', 1); 
INSERT OR REPLACE INTO CustomModOptions(Name, Value) VALUES('BALANCE_CORE_HAPPINESS_MODIFIERS', 1); 
INSERT OR REPLACE INTO CustomModOptions(Name, Value) VALUES('EVENTS_BARBARIANS', 1);
INSERT OR REPLACE INTO CustomModOptions(Name, Value) VALUES('EVENTS_CITY', 1);
INSERT OR REPLACE INTO CustomModOptions(Name, Value) VALUES('EVENTS_CUSTOM_MISSIONS', 1);
INSERT OR REPLACE INTO CustomModOptions(Name, Value) VALUES('EVENTS_DIPLO_MODIFIERS', 1); 
INSERT OR REPLACE INTO CustomModOptions(Name, Value) VALUES('EVENTS_GOLDEN_AGE', 1); 
INSERT OR REPLACE INTO CustomModOptions(Name, Value) VALUES('EVENTS_GREAT_PEOPLE', 1); 
INSERT OR REPLACE INTO CustomModOptions(Name, Value) VALUES('EVENTS_IDEOLOGIES', 1);
INSERT OR REPLACE INTO CustomModOptions(Name, Value) VALUES('EVENTS_TILE_IMPROVEMENTS', 1);
INSERT OR REPLACE INTO CustomModOptions(Name, Value) VALUES('EVENTS_UNIT_CREATED', 1);
--==========================================================================================================================
-- BUILDINGS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- Buildings
--------------------------------------------------------------------------------------------------------------------------	
ALTER TABLE Buildings	ADD MustBeCapital						boolean												default 0;
ALTER TABLE Buildings	ADD IsNationalWonder					boolean												default 0;
ALTER TABLE Buildings	ADD IsWorldWonder						boolean												default 0;
ALTER TABLE Buildings	ADD RequiresPantheon					boolean												default 0;
-------------------------------------------------------------------------------------------------------------------------
-- Building_JFD_HelpTexts
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS
Building_JFD_HelpTexts (
    BuildingType												text    REFERENCES Buildings(Type)					default null,
    CivilizationType											text    REFERENCES Civilizations(Type)				default null,
	PolicyType													text    REFERENCES Policies(Type)					default null,
	HelpText													text												default null,
	IsWrittenFirst												boolean												default 0,
	NotOnceBuilt												boolean												default 0);
--==========================================================================================================================
-- CIVILOPEDIA
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- JFD_Civilopedia_HideFromPedia
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS JFD_Civilopedia_HideFromPedia (Type text default null);
--==========================================================================================================================
-- POLICY BRANCHES
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- PolicyBranchTypes
--------------------------------------------------------------------------------------------------------------------------
ALTER TABLE PolicyBranchTypes	ADD IconString					text												default null;
--==========================================================================================================================
-- POLICIES
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- Policy_JFD_CivilizationNames
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS
Policy_JFD_CivilizationNames (
	PolicyType													text 	REFERENCES Policies(Type) 					default null,
	CivilizationType											text 	REFERENCES Civilizations(Type) 				default null,
	Description													text 												default null,
	ShortDescription											text 												default null,
	Adjective													text 												default null);
--------------------------------------------------------------------------------------------------------------------------
-- Policy_JFD_LeaderName
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS
Policy_JFD_LeaderName (
	PolicyType													text 	REFERENCES Policies(Type) 					default null,
	LeaderType													text 	REFERENCES Leaders(Type) 					default null,
	Description													text 												default null);
--==========================================================================================================================
-- RELIGIONS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- Religions
--------------------------------------------------------------------------------------------------------------------------
ALTER TABLE Religions	ADD Adjective							text												default null;
--==========================================================================================================================
-- TECHNOLOGIES
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- Tech_SpecialistYieldChanges
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 
Tech_SpecialistYieldChanges (
	TechType													text 	REFERENCES Technologies(Type) 				default null,	
	SpecialistType												text	REFERENCES Specialists(Type) 				default null,	
	YieldType													text	REFERENCES Units(Type) 						default null,	
	Yield														integer												default	0);
--------------------------------------------------------------------------------------------------------------------------
-- Technologies_JFD_FreeUnitTypes
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 
Technologies_JFD_FreeUnitTypes (
	TechType													text 	REFERENCES Technologies(Type) 				default null,	
	UnitClassType												text	REFERENCES UnitClasses(Type) 				default null,	
	UnitType													text	REFERENCES Units(Type) 						default null,	
	IsFirst														boolean												default	0);
--------------------------------------------------------------------------------------------------------------------------
-- Technologies_JFD_MiscEffects
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 
Technologies_JFD_MiscEffects (
	TechType													text 	REFERENCES Technologies(Type) 				default null,	
	EffectToolTip												text												default null,
	PortraitIndex												integer												default	0,
	IconAtlas													text												default 'GENERIC_FUNC_ATLAS',
	UnitAction													text												default	null);
	
ALTER TABLE Technologies_JFD_MiscEffects ADD UnlockQuery		text												default	null;
--==========================================================================================================================
-- UNITS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- Units
--------------------------------------------------------------------------------------------------------------------------
ALTER TABLE Units	ADD IsNotFreeChoice							boolean												default 0;
--==========================================================================================================================
-- UNIT PROMOTIONS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- UnitPromotions_Hide
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 
UnitPromotions_Hide (
	PromotionType 												text	REFERENCES UnitPromotions(Type) 			default null,
	EnemyUnitPanel												boolean							 					default 0,
	UnitPanel 													boolean							 					default 0);
--==========================================================================================================================
--==========================================================================================================================