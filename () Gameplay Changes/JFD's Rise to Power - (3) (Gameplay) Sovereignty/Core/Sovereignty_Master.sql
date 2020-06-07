--==========================================================================================================================
-- CUSTOM MOD OPTIONS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- CustomModOptions
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CustomModOptions(Name Text, Value INTEGER, Class INTEGER, DbUpdates INTEGER);
--==========================================================================================================================
-- BUILDINGS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- Buildings
--------------------------------------------------------------------------------------------------------------------------
ALTER TABLE Buildings	ADD FoundsGovernment				text												default null;
ALTER TABLE Buildings	ADD GovernmentType					text												default null;
ALTER TABLE Buildings	ADD NumBonusReformCapacity			integer												default 0;
ALTER TABLE Buildings	ADD SovereigntyBonusPerTradeRoute	integer												default 0;
ALTER TABLE Buildings	ADD SovereigntyChange				integer												default 0;
ALTER TABLE Buildings	ADD SovereigntyChangeAllCities		integer												default 0;
ALTER TABLE Buildings	ADD UnlocksGovernment				boolean												default 0;
--------------------------------------------------------------------------------------------------------------------------
-- Building_JFD_SovereigntyMods
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 
Building_JFD_SovereigntyMods (
	BuildingType									text    REFERENCES Buildings(Type)					default null,
	Help											text												default null,
	ReformBranchType								text 	  											default null,
	FactionSovMod									integer												default 0,
	LegitimacySovMod								integer												default 0,
	LegitimacySovModReformType						text 	 											default null,
	RevolutionarySentimentMod						integer												default 0,
	MaxSovChange									integer												default 0,
	GovernmentCooldownMod							integer												default 0,
	GovernmentCooldownCityMod						integer												default 0,
	ReformCapacityMod								integer												default 0,
	ReformCapacitySovMod							integer												default 0,
	ReformCooldownMod								integer												default 0,
	ReformCostMod									integer												default 0,
	ReformCostModReformType							text												default 0);	
--==========================================================================================================================
-- CIVILIZATIONS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- Civilization_JFD_Governments
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Governments (
	CivilizationType  								text 	REFERENCES Civilizations(Type) 				default null,
	GovernmentType									text	REFERENCES JFD_Governments(Type) 			default	null,
	Weight											integer												default	0);
--==========================================================================================================================
-- COUNCILLORS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- JFD_Councillors
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	JFD_Councillors (
	ID  											integer 											primary key autoincrement,
	Type  											text 												default null,
	Description										text												default	null);
--------------------------------------------------------------------------------------------------------------------------
-- JFD_Councillor_GreatPeople
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	JFD_Councillor_GreatPeople (
	CouncillorType  								text 												default null,
	Help											text												default	null,
	FlavourType										text	REFERENCES Flavors(Type) 					default null,
	UnitClassType									text 	REFERENCES UnitClasses(Type) 				default null,
	PolicyType										text	REFERENCES Policies(Type) 					default null);
--==========================================================================================================================
-- FACTIONS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- JFD_Factions
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	JFD_Factions (
	ID  											integer 											primary key autoincrement,
	Type  											text 												default null,
	PrereqGovernment								text	REFERENCES JFD_Governments(Type) 			default null,
	PrereqGovernmentOR								text	REFERENCES JFD_Governments(Type) 			default null,
	PrereqGovernmentNOT								text	REFERENCES JFD_Governments(Type) 			default null,
	PrereqReform									text	REFERENCES JFD_Reforms(Type) 				default null,
	PrereqReformOR									text	REFERENCES JFD_Reforms(Type) 				default null,
	PrereqIdeology	  								text 	 											default null,
	Description										text												default	null,
	ShortDescription								text												default	null,
	Adjective										text												default	null,
	Help											text												default	null,
	HelpIdeologyPreference							text												default	null,
	IconString										text												default	null,
	MeterImage										text												default null,
	DominanceNumAnarchyTurns						integer												default 0,
	PowerDividedByX									integer												default 0,
	IsAllowsChangeGovernment						boolean												default 0,
	IsPartyFaction									boolean												default 0,
	IsPapalFollower									boolean												default 0,
	IsValidNotSpecial								boolean												default 0);
--------------------------------------------------------------------------------------------------------------------------
-- JFD_Faction_Criteria
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	JFD_Faction_Criteria (
	FactionType  									text 	REFERENCES JFD_Factions(Type) 				default null,
	OpposingFactionType  							text 	REFERENCES JFD_Factions(Type) 				default null,
	GovernmentType			  						text 	REFERENCES JFD_Governments(Type) 			default null,
	RandomWeight									integer												default 0,
	ReformType					  					text 	REFERENCES JFD_Reforms(Type) 				default null,
	IsNumCities										boolean												default 0,
	IsNumReligiousBuildings							boolean												default 0,
	IsNumSpecialists								boolean												default 0,
	IsNumStarvingUnemployed							boolean												default 0,
	IsNumBuildings									boolean												default 0,
	IsNumImprovements								boolean												default 0,	
	IsNumTiles										boolean												default 0,
	IsNumCapitalPopulation							boolean												default 0,
	IsNumCapitalPopulationDoubled					boolean												default 0,
	IsNumOtherCityPopulation						boolean												default 0,
	IsNumBuildingClass								text 	REFERENCES BuildingClasses(Type) 			default null,
	IsNumPolicyBranchType		  					text 	 											default null,
	IsNumCapitalStrength							boolean												default 0,
	IsNumOtherCityStrength							boolean												default 0,
	IsNumPapalFaith									boolean												default 0,
	IsNumPapalHighestFollowerFaith					text 	REFERENCES Yields(Type) 					default null,
	IsOtherFactionPower								text 	REFERENCES JFD_Factions(Type) 				default null,
	IsNumReligiousFollowers							boolean												default 0,
	IsNumOwnReligiousFollowers						boolean												default 0,
	IsNumNonReligiousFollowers						boolean												default 0,
	IsNumOtherReligiousFollowers					boolean												default 0,
	IsNumLargestAllyPopulation						text 	 											default null,
	IsNumNonCityStateTradeRoute						boolean												default 0,
	IsNumCityStateTradeRoute						text 	 											default null,
	IsNumCivilianUnits								boolean												default 0,
	IsNumReligiousUnits								boolean												default 0,
	IsNumTradeUnits									boolean												default 0,
	IsNumImprovementType							boolean												default 0,
	IsNumPuppetCities								boolean												default 0,
	IsNumPopulationNonPuppet						boolean												default 0,
	IsNumPopulationPuppet							boolean												default 0,
	IsNumNonPuppetCities							boolean												default 0,
	IsNumUnitCombatType								boolean												default 0,
	IsNumCitiesGarrisoned							boolean												default 0,
	IsNumCitiesNotGarrisoned						boolean												default 0,
	IsNumFaithFromTerrain							boolean												default 0,
	IsNumSettledCities								boolean												default 0,
	IsNumConqueredCities							boolean												default 0,
	IsNumUnitClass									text 	REFERENCES UnitClasses(Type) 				default null,
	IsNumResourceType								text 	REFERENCES Resources(Type) 					default null,
	IsNumHappiness									boolean												default 0,
	IsNumUnhappiness								boolean												default 0,
	IsNumYieldType									text 	 											default null,
	IsGoldenAge										boolean												default 0,
	IsNotGoldenAgeTotalUnhappiness					boolean												default 0,
	IsNotGoldenAgeTotalHappiness					boolean												default 0,
	IsTotalControlActiveWar							boolean												default 0,
	IsTotalControlIdeologyType						text 	 											default null,
	IsTotalControlMajorityReligion					boolean												default 0,
	IsNumActiveTradeRoutes							boolean												default 0,
	IsNumActiveWars									boolean												default 0,
	IsNumCityStateFriends							boolean												default 0,
	IsNumConnectedCities							boolean												default 0,
	IsNumRevolutionarySentiment  					boolean												default 0);
--------------------------------------------------------------------------------------------------------------------------
-- JFD_Faction_Names
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	JFD_Faction_Names (
	FactionType  									text 	REFERENCES JFD_Factions(Type) 				default null,
	Name			  								text 										 		default null,
	IdeologyType		  							text 	 											default null,
	GovernmentType									text 	 											default null,
	PolicyBranchType								text 	 											default null,
	PolicyType										text 	 											default null,
	ReformType										text 	REFERENCES JFD_Reforms(Type) 				default null,
	ReformTypeNOT									text 	REFERENCES JFD_Reforms(Type) 				default null,
	MinEra  										text 						 						default null,
	AlwaysUseCivDesc								boolean												default 0,
	UseCustomPlayerAdj								boolean												default 0,
	UseCustomPlayerDesc								boolean												default 0,
	UsePlayerAdj									boolean												default 0,
	UsePlayerDesc									boolean												default 0,
	UsePlayerDescInLocalization						boolean												default 0,
	ReligionType									text 						 						default null,
	IsRandom										boolean												default 0,
	IsReligious										boolean												default 0,
	ReqIdeology										boolean												default 0,
	ReqNoIdeology									boolean												default 0,
	NoGroup											boolean												default 0,
	NoPrefixOrSuffix								boolean												default 0);
--------------------------------------------------------------------------------------------------------------------------
-- JFD_Faction_FavouredReforms
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	JFD_Faction_FavouredReforms (
	FactionType  									text 	REFERENCES JFD_Factions(Type) 				default null,
	IdeologyType		  							text 	 											default null,
	MinorCivTraitType  								text 										 		default null,
	ReformBranchType  								text 	REFERENCES JFD_ReformBranches(Type) 		default null,
	ReformType  									text 	REFERENCES JFD_Reforms(Type) 				default null,
	ReformAlignment									text		 										default	null);
--------------------------------------------------------------------------------------------------------------------------
-- JFD_Faction_OpposedReforms
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	JFD_Faction_OpposedReforms (
	FactionType  									text 	REFERENCES JFD_Factions(Type) 				default null,
	IdeologyType		  							text 	 											default null,
	MinorCivTraitType  								text 										 		default null,
	ReformBranchType  								text 	REFERENCES JFD_ReformBranches(Type) 		default null,
	ReformType  									text 	REFERENCES JFD_Reforms(Type) 				default null,
	ReformAlignment									text		 										default	null);
--==========================================================================================================================
-- GOVERNMENTS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- JFD_Governments
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	JFD_Governments (
	ID  											integer 											primary key autoincrement,
	Type  											text 												default null,
	Description										text												default	null,
	Help											text												default	null,
	LegislatureHelp									text												default	null,
	Civilopedia										text												default	null,
	TitleLegislature								text												default null,
	FlavorType1										text												default null,
	FlavorType2										text												default null,
	LegitimacySovMod								integer												default 0,
	FactionSovMod									integer												default 0,
	GovernmentCooldownMod							integer												default 0,
	ReformCostMod									integer												default 0,
	BonusReformCapacityPerTradeTech					boolean												default 0,
	CouncillorReformCostMod							integer												default 0,
	MaxSovPerHolySeeFaction							integer												default 0,
	ReligiousReformCooldownMod						integer												default 0,
	ReligiousReformIsNoCapacity						boolean												default 0,
	IsAllowsChangeGovernmentNoAnarchy				boolean												default 0,
	IsLegislatureOnlyEraReset						boolean												default 0,
	IsNoRevSentiment								boolean												default 0,
	GoldenAgeSovereigntyBonus						integer												default 0,
	GovernmentCooldownCityMod						integer												default 0,
	ReliMilReformCostMod							integer												default 0,
	ReformCapacityModAtWar							integer												default 0,
	ReformCapacitySovCityGarrisonMod				integer												default 0,
	RequiresAnarchy									boolean												default 0,
	RequiresNOTAnarchy								boolean												default 0,
	RequiresActiveWar								boolean												default 0,
	RequiresBuilding								text												default null,
	RequiresBuildingOR								text												default null,
	RequiresBuildingAllCities						text												default null,
	RequiresCityStateAllies							integer												default 0,
	RequiresTradeRoutes								integer												default 0,
	RequiresConnectedCities							boolean												default 0,
	RequiresConqueredCapital						boolean												default 0,
	RequiresGarrisonCities							boolean												default 0,
	RequiresMinEra									text												default null,
	RequiresOtherReligion							boolean												default 0,
	RequiresIdeology								boolean												default 0,
	RequiresGoldenAge								boolean												default 0,
	RequiresGovernment								text												default null,
	RequiresGreatGenerals							integer												default 0,
	RequiresHorses									integer												default 0,
	RequiresReligion								boolean												default 0,
	RequiresReligionAllControl						boolean												default 0,
	RequiresReligionNotAllControl					boolean												default 0,
	RequiresPopulation								integer												default 0,
	RequiresTech									text												default null,
	IsDisabled										boolean												default 0,
	IsHidden										boolean												default 0,
	IsLegislated									boolean												default 0,
	IsSpecial										boolean												default 0,
	IsUnique										boolean												default 0,
	IsGovtOverviewShowsCivIconFirst					boolean												default 0,
	IsGovtOverviewShowsReligiousIconFirst			boolean												default 0,
	NumAnarchyTurnsFromChange						integer												default 0,
	OverviewBackground								text												default	null,
	NotificationDescription							text												default	null,
	NotificationShortDescription					text												default	null,
	NotificationWorldEvent							text												default	null,
	AudioEffect										text												default	null,
	GovernmentChoiceImage							text												default	null,
	GovernmentLegislatureImage						text												default	null,
	GovernmentNewLegislatureImage					text												default	null,
	AlphaAtlas										text												default	null,
	AlphaIndex										integer												default 0,
	IconAtlas										text												default	null,
	PortraitIndex									integer												default 0);
--------------------------------------------------------------------------------------------------------------------------
-- JFD_Government_Names
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	JFD_Government_Names (
	GovernmentType  								text 	REFERENCES JFD_Governments(Type) 			default null,
	Name			  								text 										 		default null,
	IsAfterGovName									boolean												default 0,
	IsFullGovName									boolean												default 0,
	IsAnarchy										boolean												default 0,
	IsNoCities										boolean												default 0,
	BuildingType		  							text 	 											default null,
	EraType				  							text 	 											default null,
	FactionType										text 	 											default null,
	IdeologyType		  							text 	 											default null,
	ReligionType		  							text 	 											default null,
	PolicyType			  							text 	 											default null,
	ReformType										text 	 											default null,
	ReformTypeAND									text 	 											default null,
	ReformTypeNOT									text 	 											default null,
	UseReligionAdj									boolean												default 0);
--------------------------------------------------------------------------------------------------------------------------
-- JFD_Government_Titles
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	JFD_Government_Titles (
	GovernmentType  								text 	REFERENCES JFD_Governments(Type) 			default null,
	GovernmentTypeNOT								text 	REFERENCES JFD_Governments(Type) 			default null,
	Priority	  									integer 	 										default 0,
	TitleLeader										text												default null,
	TitleState										text												default null,
	TitleStyle										text												default null,
	MinNumCityStateAllies							integer 	 										default 0,
	UseAdjective									boolean												default 0,
	UseAdjectiveInLocalization						boolean												default 0,
	UseReligionAsAdjective							boolean												default 0,
	UseDescriptionInLocalization					boolean												default 0,
	UseCapitalInLocalization						boolean												default 0,
	UseCapital										boolean												default 0,
	UseGovernmentDescriptionInLocalization			boolean												default 0,		
	UseReligionInLocalization						boolean												default 0,
	IsLeaderTitleAfterName							boolean												default 0,
	IsStateTitleDoNotUseCiv							boolean												default 0,
	IsStateTitleReverse								boolean												default 0,
	IsStateTitleOmitOf								boolean												default 0,
	IsStyleRequiresAnd								boolean												default 0,
	IsAntiPope										boolean												default 0,
	BeliefType  									text 	 											default null,
	BuildingType									text 	 											default null,
	CyclePowerType  								text 	 											default null,
	EraType		  									text 	REFERENCES Eras(Type) 						default null,
	FactionType										text 	 											default null,
	IdeologyType  									text 	 											default null,
	PolicyBranchType								text 	REFERENCES PolicyBranchTypes(Type) 			default null,
	PolicyType  									text 	 											default null,
	PolicyTypeAND  									text 	 											default null,
	ReformType  									text 	REFERENCES JFD_Reforms(Type) 				default null,
	ReformTypeAND  									text 	REFERENCES JFD_Reforms(Type) 				default null,
	ReformTypeAND2  								text 	REFERENCES JFD_Reforms(Type) 				default null,
	ReformTypeAND3  								text 	REFERENCES JFD_Reforms(Type) 				default null,
	ReformTypeNOT									text 	REFERENCES JFD_Reforms(Type) 				default null,
	AnyReligionFoundedType							boolean												default 0,	
	ReligionFoundedType  							text 	 											default null,
	StateReligionType  								text 	 											default null,
	IsLeaderPrimeMinister							boolean												default 0,
	IsLeaderRegent									boolean												default 0,
	IsVassalOfSomeone								boolean												default 0,
	IsVassalHRE										boolean												default 0);
--==========================================================================================================================
-- POLICIES
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- Policies
--------------------------------------------------------------------------------------------------------------------------
ALTER TABLE Policies	ADD BonusInquisitorMoves	integer												default 0;
ALTER TABLE Policies	ADD BonusMissDomesticMoves	integer												default 0;
ALTER TABLE Policies	ADD BonusMissForeignMoves	integer												default 0;
ALTER TABLE Policies	ADD BonusUnitTrainedMoves	integer												default 0;
ALTER TABLE Policies	ADD BonusUnitHPPerTurn		integer												default 0;
ALTER TABLE Policies	ADD RouteMovementBonus		integer												default 0;
--------------------------------------------------------------------------------------------------------------------------
-- Policy_JFD_SovereigntyMods
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 
Policy_JFD_SovereigntyMods (
	PolicyType  									text 		REFERENCES Policies(Type) 				default null,
	ReformBranchType								text 	 											default null,
	FactionSovMod									integer												default 0,
	LegitimacySovMod								integer												default 0,
	LegitimacySovModReformType						text 	 											default null,
	RevolutionarySentimentMod						integer												default 0,
	MaxSovChange									integer												default 0,
	GovernmentCooldownMod							integer												default 0,
	ReformCapacityMod								integer												default 0,
	ReformCapacitySovMod							integer												default 0,
	ReformCooldownMod								integer												default 0,
	ReformCostMod									integer												default 0,
	ReformCostModReformType							text												default 0,
	IsCouncillorBonus								boolean												default 0); 
--==========================================================================================================================
-- REFORM BRANCHES
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- JFD_ReformBranches
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	JFD_ReformBranches (
	ID  											integer 											primary key autoincrement,
	Type  											text 												default null,
	ShortDescription								text												default	null,
	Description										text												default	null,
	Adjective										text												default	null,
	Help											text												default null,
	FlavourType										text	REFERENCES Flavors(Type) 					default null,
	AltFlavourType									text	REFERENCES Flavors(Type) 					default null,
	ButtonTexture									text												default null);
--==========================================================================================================================
-- REFORM SUBBRANCHES
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- JFD_ReformSubBranches
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	JFD_ReformSubBranches (
	ID  											integer 											primary key autoincrement,
	Type  											text 												default null,
	Description										text												default	null,
	Help											text												default	null,
	ReformBranchType								text	REFERENCES JFD_ReformBranches(Type) 		default null);
--------------------------------------------------------------------------------------------------------------------------
-- JFD_ReformSubBranch_Flavours
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	JFD_ReformSubBranch_Flavours (
	ReformSubBranchType  							text 												default null,
	RightFlavourType								text	REFERENCES Flavors(Type) 					default	null,
	CentreFlavourType								text	REFERENCES Flavors(Type) 					default	null,
	LeftFlavourType									text	REFERENCES Flavors(Type) 					default	null);
--==========================================================================================================================
-- REFORMS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- JFD_Reforms
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
JFD_Reforms (
	ID  											integer 											primary key autoincrement,
	Type  											text 												default null,
	Cost  											integer 											default 0,
	ReformBranchType								text	REFERENCES JFD_ReformBranches(Type) 		default null,
	ReformSubBranchType								text	REFERENCES JFD_ReformSubBranches(Type) 		default null,
	ReformSubBranchDescription						text												default null,
	ReformSubBranchHelp								text												default null,
	ShortDescription								text												default	null,
	Description										text												default null,
	Help											text												default	null,
	HelpBonus										text												default	null,
	HelpPenalty										text												default	null,
	FocusIconBonus									text												default	null,
	FocusIconPenalty								text												default	null,
	Pedia											text												default	null,
	DefaultActive									boolean												default	0,
	ShowInGovernment								boolean												default	1,
	IsLegislature									boolean												default	0,
	Alignment										text												default	null,
	PrereqGovernment								text	REFERENCES JFD_Governments(Type) 			default	null,
	PrereqEra										text 	REFERENCES Eras(Type) 						default null,
	PolicyType										text 	REFERENCES Policies(Type) 					default null,
	FactionSovMod									integer												default	0,		
	FactionOppositionSovMod							integer												default	0,		
	FactionSupportSovMod							integer												default	0,		
	LegitimacySovMod								integer												default 0,
	MaxSovChange									integer												default	0,		
	RevolutionaryFactionPowerMod					integer												default	0,	
	RevolutionarySentimentPerReform					integer												default	0,	
	RevolutionarySentimentMod						integer												default	0,		
	NumAnarchyTurns									integer												default	0,		
	PietyMod										integer												default	0,		
	GovernmentCooldownMod							integer												default 0,
	ReformCapacityMod								integer												default	0,
	ReformCapacitySovMod							integer												default 0,
	ReformCooldownMod								integer												default 0,
	ReformCostMod									integer												default	0,
	ReformCostModPerCity							integer												default	0,
	ReformCostModPerCityReformCategoryType			text												default	null,
	ReformCostModPerPop								integer												default	0,
	ReformCostModPerPopReformCategoryType			text												default	null,
	ReformCostModPerPuppet							integer												default	0,
	ResetsLegislature								boolean												default 0,
	SovereigntyWhenBuildingClass					integer												default 0,
	SovereigntyWhenBuildingClassType				text 	REFERENCES BuildingClasses(Type) 			default null,
	SovereigntyWhenNumCitiesOrLess					integer												default 0,
	SovereigntyWhenNumCitiesOrLessReq				integer												default 0,
	SovereigntyWhenNumCitiesOrMore					integer												default 0,
	SovereigntyWhenNumCitiesOrMoreReq				integer												default 0);
--------------------------------------------------------------------------------------------------------------------------
-- JFD_Reform_DummyBuildings
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
JFD_Reform_DummyBuildings (
	ReformType  									text 	REFERENCES JFD_Reforms(Type) 				default null,
	BuildingType									text 	REFERENCES Buildings(Type) 					default null,
	IsOnlyCapital									boolean												default 0);
--------------------------------------------------------------------------------------------------------------------------
-- JFD_Reform_FreePromotions
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
JFD_Reform_FreePromotions (
	ReformType  									text 	REFERENCES JFD_Reforms(Type) 				default null,
	PromotionType									text 	REFERENCES UnitPromotions(Type) 			default null,
	UnitClassType									text 	REFERENCES UnitClasses(Type) 				default null,
	AddOnPass										boolean												default 0,
	AddOnFaithPurchase								boolean												default 0,
	AddOnUnitCreate									boolean												default 0,
	AddOnUnitTrain									boolean												default 0,
	RemoveOnRevoke									boolean												default 0);
--------------------------------------------------------------------------------------------------------------------------
-- JFD_Reform_Negates
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
JFD_Reform_Negates (
	ReformType  									text 	REFERENCES JFD_Reforms(Type) 				default null,
	ReformNegateType								text	REFERENCES JFD_Reforms(Type) 				default null);
--==========================================================================================================================
-- TRAITS
--==========================================================================================================================	
--------------------------------------------------------------------------------------------------------------------------
-- Trait_JFD_SovereigntyMods
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 
Trait_JFD_SovereigntyMods (
	TraitType 										text 		REFERENCES Traits(Type)					default null,
	ReformBranchType								text 	 											default null,
	FactionSovMod									integer												default 0,
	LegitimacySovMod								integer												default 0,
	LegitimacySovModReformType						text 	 											default null,
	RevolutionarySentimentMod						integer												default 0,
	MaxSovChange									integer												default 0,
	GovernmentCooldownMod							integer												default 0,
	ReformCapacityMod								integer												default 0,
	ReformCapacitySovMod							integer												default 0,
	ReformCooldownMod								integer												default 0,
	ReformCostMod									integer												default 0,
	ReformCostModReformType							text												default 0); 
--==========================================================================================================================
--==========================================================================================================================