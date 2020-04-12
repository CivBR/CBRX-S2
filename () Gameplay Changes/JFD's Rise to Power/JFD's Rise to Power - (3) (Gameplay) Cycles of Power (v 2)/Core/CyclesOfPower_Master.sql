--=======================================================================================================================
-- CUSTOM MOD OPTIONS
--=======================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- CustomModOptions
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CustomModOptions(Name Text, Value INTEGER, Class INTEGER, DbUpdates INTEGER);
--==========================================================================================================================
-- GOVERNMENT POWERS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- JFD_CyclePowers
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS
	JFD_CyclePowers (
	ID  								integer 						  				primary key autoincrement,
	Type 								text 											default null,
	Description							text 											default null,
	Help								text 											default null,
	Strategy							text 											default null,
	Quote								text 											default null,
	Civilopedia							text 											default null,
	FlavorType							text	REFERENCES Flavors(Type) 				default null,
	PolicyType							text	REFERENCES Policies(Type) 				default null,
	CyclePowerAudio						text 											default null,
	AnarchyCyclePower					text 											default null,
	NextCyclePower						text 											default null,
	IsAnarchy							boolean											default 0,
	IsTheocracy							boolean											default 0,
	ShowInCyclePowerChoice				boolean											default 0,
	SovModifierPerCapitalPopulation		integer											default 0,	
	SovModifierPerCity					integer											default 0,	
	SovModifierPerPopulation			integer											default 0,	
	VirtueRatePerXCapitalPopulation		integer											default 0,
	VirtueRatePerXCity					integer											default 0,
	VirtueRatePerXCityNotFollowing		integer											default 0,
	VirtueRatePerXPopulation			integer											default 0,
	VirtueFromCombat					integer											default 0,
	VirtueFromFaithPurchases			integer											default 0,
	VirtueFromGoldPurchases				integer											default 0,
	VirtueFromGreatPerson				integer											default 0,
	VirtueFromGrowth					integer											default 0,
	VirtueFromPolicyAdoptions			integer											default 0,
	VirtueFromTechUnlocks				integer											default 0,
	VirtueFromTileExpansion				integer											default 0);
--==========================================================================================================================
--==========================================================================================================================