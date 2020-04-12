--=======================================================================================================================
-- CUSTOM MOD OPTIONS
--=======================================================================================================================
-- CustomModOptions
-------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CustomModOptions(Name Text, Value INTEGER, Class INTEGER, DbUpdates INTEGER);

INSERT OR REPLACE INTO CustomModOptions(Name, Value) VALUES('EVENTS_CITY', 1);
INSERT OR REPLACE INTO CustomModOptions(Name, Value) VALUES('EVENTS_GOLDEN_AGE', 1);
INSERT OR REPLACE INTO CustomModOptions(Name, Value) VALUES('EVENTS_GREAT_PEOPLE', 1);
INSERT OR REPLACE INTO CustomModOptions(Name, Value) VALUES('EVENTS_UNIT_CREATED', 1);
--==========================================================================================================================
-- ERAS
--==========================================================================================================================
-- Eras
--------------------------------------------------------------------------------------------------------------------------
ALTER TABLE Eras ADD EpithetProgressThreshold		integer		default		10;
--==========================================================================================================================
-- EPITHETS
--==========================================================================================================================
-- JFD_Epithets
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
JFD_Epithets (
	ID  						integer 						  	primary key autoincrement,
	Type 						text 								default null,
	Description 				text 								default null,
	ShortDescription 			text 								default null,
	Help 						text 								default null,
	FlavourType					text 								default null,
	ProgressPerAction 			integer 							default 0,
	EndsResistance		 		boolean 							default 0,
	FreeFood			 		integer 							default 0,
	FreeGreatPeople		 		integer 							default 0,
	FreeInfluence		 		integer 							default 0,
	FreePolicies		 		integer 							default 0,
	FreePopulation		 		integer 							default 0,
	FreeProduction		 		integer 							default 0,
	FreeTechs		 			integer 							default 0,
	FreeUnitXP		 			integer 							default 0,
	GoldenAgeTurns				integer								default 0,
	WLTKDTurns					integer								default 0);
--==========================================================================================================================	
-- POLICIES
--==========================================================================================================================	
--------------------------------------------------------------------------------------------------------------------------
-- Policy_JFD_EpithetMods
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS
	Policy_JFD_EpithetMods (
    PolicyType	  						text 		REFERENCES Policies(Type)			default null,
	EpithetProgressModifier				integer											default 0);	
--==========================================================================================================================
--==========================================================================================================================