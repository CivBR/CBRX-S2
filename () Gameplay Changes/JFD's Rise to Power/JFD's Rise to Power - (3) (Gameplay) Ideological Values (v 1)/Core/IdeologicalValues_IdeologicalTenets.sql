--==========================================================================================================================
-- IDEOLOGICAL TENETS
--==========================================================================================================================	
--------------------------------------------------------------------------------------------------------------------------
UPDATE Policies
SET OriginalPolicyBranchType = PolicyBranchType
WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_FREEDOM', 'POLICY_BRANCH_ORDER');
--------------------------------------------------------------------------------------------------------------------------
-- AUTOCRACY
--------------------------------------------------------------------------------------------------------------------------
INSERT OR REPLACE INTO Policies (Type,IsDuplicateIdeologicalTenet,Description,Civilopedia,Strategy,Help,PolicyBranchType,OriginalPolicyBranchType,NumExtraBranches,CultureCost,GridX,GridY,Level,PolicyCostModifier,CulturePerCity,CulturePerWonder,CultureWonderMultiplier,CulturePerTechResearched,CultureImprovementChange,CultureFromKills,CultureFromBarbarianKills,GoldFromKills,EmbarkedExtraMoves,AttackBonusTurns,GoldenAgeTurns,GoldenAgeMeterMod,GoldenAgeDurationMod,NumFreeTechs,NumFreePolicies,NumFreeGreatPeople,MedianTechPercentChange,StrategicResourceMod,WonderProductionModifier,BuildingProductionModifier,GreatPeopleRateModifier,GreatGeneralRateModifier,GreatAdmiralRateModifier,GreatWriterRateModifier,GreatArtistRateModifier,GreatMusicianRateModifier,GreatMerchantRateModifier,GreatScientistRateModifier,DomesticGreatGeneralRateModifier,ExtraHappiness,ExtraHappinessPerCity,UnhappinessMod,CityCountUnhappinessMod,OccupiedPopulationUnhappinessMod,CapitalUnhappinessMod,FreeExperience,WorkerSpeedModifier,AllFeatureProduction,ImprovementCostModifier,ImprovementUpgradeRateModifier,SpecialistProductionModifier,SpecialistUpgradeModifier,MilitaryProductionModifier,BaseFreeUnits,BaseFreeMilitaryUnits,FreeUnitsPopulationPercent,FreeMilitaryUnitsPopulationPercent,HappinessPerGarrisonedUnit,CulturePerGarrisonedUnit,HappinessPerTradeRoute,HappinessPerXPopulation,ExtraHappinessPerLuxury,UnhappinessFromUnitsMod,NumExtraBuilders,PlotGoldCostMod,PlotCultureCostModifier,PlotCultureExponentModifier,NumCitiesPolicyCostDiscount,GarrisonedCityRangeStrikeModifier,UnitPurchaseCostModifier,BuildingPurchaseCostModifier,CityConnectionTradeRouteGoldModifier,TradeMissionGoldModifier,FaithCostModifier,CulturalPlunderMultiplier,StealTechSlowerModifier,StealTechFasterModifier,CatchSpiesModifier,GoldPerUnit,GoldPerMilitaryUnit,RouteGoldMaintenanceMod,BuildingGoldMaintenanceMod,UnitGoldMaintenanceMod,UnitSupplyMod,UnitUpgradeCostMod,CityStrengthMod,CityGrowthMod,CapitalGrowthMod,SettlerProductionModifier,CapitalSettlerProductionModifier,NewCityExtraPopulation,FreeFoodBox,HappyPerMilitaryUnit,MilitaryFoodProduction,HappinessToCulture,HappinessToScience,NumCitiesFreeCultureBuilding,NumCitiesFreeFoodBuilding,HalfSpecialistUnhappiness,HalfSpecialistFood,MaxConscript,UnitSightRangeChange,WoundedUnitDamageMod,BarbarianCombatBonus,AlwaysSeeBarbCamps,RevealAllCapitals,FreeSpecialist,ExpModifier,ExpInBorderModifier,MinorQuestFriendshipMod,MinorGoldFriendshipMod,MinorFriendshipMinimum,MinorFriendshipDecayMod,OtherPlayersMinorFriendshipDecayMod,CityStateUnitFrequencyModifier,CommonFoeTourismModifier,LessHappyTourismModifier,SharedIdeologyTourismModifier,LandTradeRouteGoldChange,SeaTradeRouteGoldChange,SharedIdeologyTradeGoldChange,RiggingElectionModifier,MilitaryUnitGiftExtraInfluence,ProtectedMinorPerTurnInfluence,AfraidMinorPerTurnInfluence,MinorBullyScoreModifier,CityStateTradeChange,ThemingBonusMultiplier,InternalTradeRouteYieldModifier,SharedReligionTourismModifier,TradeRouteTourismModifier,OpenBordersTourismModifier,MinorGreatPeopleAllies,MinorScienceAllies,MinorResourceBonus,GarrisonFreeMaintenance,GoldenAgeCultureBonusDisabled,SecondReligionPantheon,AddReformationBelief,EnablesSSPartHurry,EnablesSSPartPurchase,AbleToAnnexCityStates,OneShot,IncludesOneShotFreeUnits,WeLoveTheKing,FreeBuildingOnConquest,TechPrereq,PortraitIndex,IconAtlas,IconAtlasAchieved)
SELECT Type || '_A',1,Description,Civilopedia,Strategy,Help,'POLICY_BRANCH_AUTOCRACY',OriginalPolicyBranchType,NumExtraBranches,CultureCost,GridX,GridY,Level,PolicyCostModifier,CulturePerCity,CulturePerWonder,CultureWonderMultiplier,CulturePerTechResearched,CultureImprovementChange,CultureFromKills,CultureFromBarbarianKills,GoldFromKills,EmbarkedExtraMoves,AttackBonusTurns,GoldenAgeTurns,GoldenAgeMeterMod,GoldenAgeDurationMod,NumFreeTechs,NumFreePolicies,NumFreeGreatPeople,MedianTechPercentChange,StrategicResourceMod,WonderProductionModifier,BuildingProductionModifier,GreatPeopleRateModifier,GreatGeneralRateModifier,GreatAdmiralRateModifier,GreatWriterRateModifier,GreatArtistRateModifier,GreatMusicianRateModifier,GreatMerchantRateModifier,GreatScientistRateModifier,DomesticGreatGeneralRateModifier,ExtraHappiness,ExtraHappinessPerCity,UnhappinessMod,CityCountUnhappinessMod,OccupiedPopulationUnhappinessMod,CapitalUnhappinessMod,FreeExperience,WorkerSpeedModifier,AllFeatureProduction,ImprovementCostModifier,ImprovementUpgradeRateModifier,SpecialistProductionModifier,SpecialistUpgradeModifier,MilitaryProductionModifier,BaseFreeUnits,BaseFreeMilitaryUnits,FreeUnitsPopulationPercent,FreeMilitaryUnitsPopulationPercent,HappinessPerGarrisonedUnit,CulturePerGarrisonedUnit,HappinessPerTradeRoute,HappinessPerXPopulation,ExtraHappinessPerLuxury,UnhappinessFromUnitsMod,NumExtraBuilders,PlotGoldCostMod,PlotCultureCostModifier,PlotCultureExponentModifier,NumCitiesPolicyCostDiscount,GarrisonedCityRangeStrikeModifier,UnitPurchaseCostModifier,BuildingPurchaseCostModifier,CityConnectionTradeRouteGoldModifier,TradeMissionGoldModifier,FaithCostModifier,CulturalPlunderMultiplier,StealTechSlowerModifier,StealTechFasterModifier,CatchSpiesModifier,GoldPerUnit,GoldPerMilitaryUnit,RouteGoldMaintenanceMod,BuildingGoldMaintenanceMod,UnitGoldMaintenanceMod,UnitSupplyMod,UnitUpgradeCostMod,CityStrengthMod,CityGrowthMod,CapitalGrowthMod,SettlerProductionModifier,CapitalSettlerProductionModifier,NewCityExtraPopulation,FreeFoodBox,HappyPerMilitaryUnit,MilitaryFoodProduction,HappinessToCulture,HappinessToScience,NumCitiesFreeCultureBuilding,NumCitiesFreeFoodBuilding,HalfSpecialistUnhappiness,HalfSpecialistFood,MaxConscript,UnitSightRangeChange,WoundedUnitDamageMod,BarbarianCombatBonus,AlwaysSeeBarbCamps,RevealAllCapitals,FreeSpecialist,ExpModifier,ExpInBorderModifier,MinorQuestFriendshipMod,MinorGoldFriendshipMod,MinorFriendshipMinimum,MinorFriendshipDecayMod,OtherPlayersMinorFriendshipDecayMod,CityStateUnitFrequencyModifier,CommonFoeTourismModifier,LessHappyTourismModifier,SharedIdeologyTourismModifier,LandTradeRouteGoldChange,SeaTradeRouteGoldChange,SharedIdeologyTradeGoldChange,RiggingElectionModifier,MilitaryUnitGiftExtraInfluence,ProtectedMinorPerTurnInfluence,AfraidMinorPerTurnInfluence,MinorBullyScoreModifier,CityStateTradeChange,ThemingBonusMultiplier,InternalTradeRouteYieldModifier,SharedReligionTourismModifier,TradeRouteTourismModifier,OpenBordersTourismModifier,MinorGreatPeopleAllies,MinorScienceAllies,MinorResourceBonus,GarrisonFreeMaintenance,GoldenAgeCultureBonusDisabled,SecondReligionPantheon,AddReformationBelief,EnablesSSPartHurry,EnablesSSPartPurchase,AbleToAnnexCityStates,OneShot,IncludesOneShotFreeUnits,WeLoveTheKing,FreeBuildingOnConquest,TechPrereq,10,'POLICY_ATLAS_EXP2','POLICY_A_ATLAS_EXP2' 
FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_FREEDOM', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0;
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_Flavors (PolicyType, FlavorType, Flavor)
SELECT PolicyType || '_A', FlavorType, Flavor
FROM Policy_Flavors WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_FREEDOM', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_CityYieldChanges (PolicyType, YieldType, Yield)
SELECT PolicyType || '_A', YieldType, Yield
FROM Policy_CityYieldChanges WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_FREEDOM', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_CoastalCityYieldChanges (PolicyType, YieldType, Yield)
SELECT PolicyType || '_A', YieldType, Yield
FROM Policy_CoastalCityYieldChanges WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_FREEDOM', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_CapitalYieldChanges (PolicyType, YieldType, Yield)
SELECT PolicyType || '_A', YieldType, Yield
FROM Policy_CapitalYieldChanges WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_FREEDOM', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_CapitalYieldPerPopChanges (PolicyType, YieldType, Yield)
SELECT PolicyType || '_A', YieldType, Yield
FROM Policy_CapitalYieldPerPopChanges WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_FREEDOM', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_CapitalYieldModifiers (PolicyType, YieldType, Yield)
SELECT PolicyType || '_A', YieldType, Yield
FROM Policy_CapitalYieldModifiers WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_FREEDOM', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_GreatWorkYieldChanges (PolicyType, YieldType, Yield)
SELECT PolicyType || '_A', YieldType, Yield
FROM Policy_GreatWorkYieldChanges WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_FREEDOM', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_HurryModifiers (PolicyType, HurryType, HurryCostModifier)
SELECT PolicyType || '_A', HurryType, HurryCostModifier
FROM Policy_HurryModifiers WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_FREEDOM', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_SpecialistExtraYields (PolicyType, YieldType, Yield)
SELECT PolicyType || '_A', YieldType, Yield
FROM Policy_SpecialistExtraYields WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_FREEDOM', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_BuildingClassYieldModifiers (PolicyType, BuildingClassType, YieldType, YieldMod)
SELECT PolicyType || '_A', BuildingClassType, YieldType, YieldMod
FROM Policy_BuildingClassYieldModifiers WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_FREEDOM', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_BuildingClassYieldChanges (PolicyType, BuildingClassType, YieldType, YieldChange)
SELECT PolicyType || '_A', BuildingClassType, YieldType, YieldChange
FROM Policy_BuildingClassYieldChanges WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_FREEDOM', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_BuildingClassCultureChanges (PolicyType, BuildingClassType, CultureChange)
SELECT PolicyType || '_A', BuildingClassType, CultureChange
FROM Policy_BuildingClassCultureChanges WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_FREEDOM', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_BuildingClassProductionModifiers (PolicyType, BuildingClassType, ProductionModifier)
SELECT PolicyType || '_A', BuildingClassType, ProductionModifier
FROM Policy_BuildingClassProductionModifiers WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_FREEDOM', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_BuildingClassTourismModifiers (PolicyType, BuildingClassType, TourismModifier)
SELECT PolicyType || '_A', BuildingClassType, TourismModifier
FROM Policy_BuildingClassTourismModifiers WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_FREEDOM', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_BuildingClassHappiness (PolicyType, BuildingClassType, Happiness)
SELECT PolicyType || '_A', BuildingClassType, Happiness
FROM Policy_BuildingClassHappiness WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_FREEDOM', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_ImprovementYieldChanges (PolicyType, ImprovementType, YieldType, Yield)
SELECT PolicyType || '_A', ImprovementType, YieldType, Yield
FROM Policy_ImprovementYieldChanges WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_FREEDOM', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_ImprovementCultureChanges (PolicyType, ImprovementType, CultureChange)
SELECT PolicyType || '_A', ImprovementType, CultureChange
FROM Policy_ImprovementCultureChanges WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_FREEDOM', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_ValidSpecialists (PolicyType, SpecialistType)
SELECT PolicyType || '_A', SpecialistType
FROM Policy_ValidSpecialists WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_FREEDOM', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_YieldModifiers (PolicyType, YieldType, Yield)
SELECT PolicyType || '_A', YieldType, Yield
FROM Policy_YieldModifiers WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_FREEDOM', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_FreePromotions (PolicyType, PromotionType)
SELECT PolicyType || '_A', PromotionType
FROM Policy_FreePromotions WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_FREEDOM', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_UnitCombatFreeExperiences (PolicyType, UnitCombatType, FreeExperience)
SELECT PolicyType || '_A', UnitCombatType, FreeExperience
FROM Policy_UnitCombatFreeExperiences WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_FREEDOM', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_FreePromotionUnitCombats (PolicyType, UnitCombatType, PromotionType)
SELECT PolicyType || '_A', UnitCombatType, PromotionType 
FROM Policy_FreePromotionUnitCombats WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_FREEDOM', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_UnitCombatProductionModifiers (PolicyType, UnitCombatType, ProductionModifier)
SELECT PolicyType || '_A', UnitCombatType, ProductionModifier
FROM Policy_UnitCombatProductionModifiers WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_FREEDOM', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_FreeUnitClasses (PolicyType, UnitClassType, Count)
SELECT PolicyType || '_A', UnitClassType, Count
FROM Policy_FreeUnitClasses WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_FREEDOM', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_TourismOnUnitCreation (PolicyType, UnitClassType, Tourism)
SELECT PolicyType || '_A', UnitClassType, Tourism
FROM Policy_TourismOnUnitCreation WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_FREEDOM', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_FreeItems (PolicyType, SetType, MinItems, MaxItems)
SELECT PolicyType || '_A', SetType, MinItems, MaxItems
FROM Policy_FreeItems WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_FREEDOM', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
-- FREEDOM
--------------------------------------------------------------------------------------------------------------------------
INSERT OR REPLACE INTO Policies (Type,IsDuplicateIdeologicalTenet,Description,Civilopedia,Strategy,Help,PolicyBranchType,OriginalPolicyBranchType,NumExtraBranches,CultureCost,GridX,GridY,Level,PolicyCostModifier,CulturePerCity,CulturePerWonder,CultureWonderMultiplier,CulturePerTechResearched,CultureImprovementChange,CultureFromKills,CultureFromBarbarianKills,GoldFromKills,EmbarkedExtraMoves,AttackBonusTurns,GoldenAgeTurns,GoldenAgeMeterMod,GoldenAgeDurationMod,NumFreeTechs,NumFreePolicies,NumFreeGreatPeople,MedianTechPercentChange,StrategicResourceMod,WonderProductionModifier,BuildingProductionModifier,GreatPeopleRateModifier,GreatGeneralRateModifier,GreatAdmiralRateModifier,GreatWriterRateModifier,GreatArtistRateModifier,GreatMusicianRateModifier,GreatMerchantRateModifier,GreatScientistRateModifier,DomesticGreatGeneralRateModifier,ExtraHappiness,ExtraHappinessPerCity,UnhappinessMod,CityCountUnhappinessMod,OccupiedPopulationUnhappinessMod,CapitalUnhappinessMod,FreeExperience,WorkerSpeedModifier,AllFeatureProduction,ImprovementCostModifier,ImprovementUpgradeRateModifier,SpecialistProductionModifier,SpecialistUpgradeModifier,MilitaryProductionModifier,BaseFreeUnits,BaseFreeMilitaryUnits,FreeUnitsPopulationPercent,FreeMilitaryUnitsPopulationPercent,HappinessPerGarrisonedUnit,CulturePerGarrisonedUnit,HappinessPerTradeRoute,HappinessPerXPopulation,ExtraHappinessPerLuxury,UnhappinessFromUnitsMod,NumExtraBuilders,PlotGoldCostMod,PlotCultureCostModifier,PlotCultureExponentModifier,NumCitiesPolicyCostDiscount,GarrisonedCityRangeStrikeModifier,UnitPurchaseCostModifier,BuildingPurchaseCostModifier,CityConnectionTradeRouteGoldModifier,TradeMissionGoldModifier,FaithCostModifier,CulturalPlunderMultiplier,StealTechSlowerModifier,StealTechFasterModifier,CatchSpiesModifier,GoldPerUnit,GoldPerMilitaryUnit,RouteGoldMaintenanceMod,BuildingGoldMaintenanceMod,UnitGoldMaintenanceMod,UnitSupplyMod,UnitUpgradeCostMod,CityStrengthMod,CityGrowthMod,CapitalGrowthMod,SettlerProductionModifier,CapitalSettlerProductionModifier,NewCityExtraPopulation,FreeFoodBox,HappyPerMilitaryUnit,MilitaryFoodProduction,HappinessToCulture,HappinessToScience,NumCitiesFreeCultureBuilding,NumCitiesFreeFoodBuilding,HalfSpecialistUnhappiness,HalfSpecialistFood,MaxConscript,UnitSightRangeChange,WoundedUnitDamageMod,BarbarianCombatBonus,AlwaysSeeBarbCamps,RevealAllCapitals,FreeSpecialist,ExpModifier,ExpInBorderModifier,MinorQuestFriendshipMod,MinorGoldFriendshipMod,MinorFriendshipMinimum,MinorFriendshipDecayMod,OtherPlayersMinorFriendshipDecayMod,CityStateUnitFrequencyModifier,CommonFoeTourismModifier,LessHappyTourismModifier,SharedIdeologyTourismModifier,LandTradeRouteGoldChange,SeaTradeRouteGoldChange,SharedIdeologyTradeGoldChange,RiggingElectionModifier,MilitaryUnitGiftExtraInfluence,ProtectedMinorPerTurnInfluence,AfraidMinorPerTurnInfluence,MinorBullyScoreModifier,CityStateTradeChange,ThemingBonusMultiplier,InternalTradeRouteYieldModifier,SharedReligionTourismModifier,TradeRouteTourismModifier,OpenBordersTourismModifier,MinorGreatPeopleAllies,MinorScienceAllies,MinorResourceBonus,GarrisonFreeMaintenance,GoldenAgeCultureBonusDisabled,SecondReligionPantheon,AddReformationBelief,EnablesSSPartHurry,EnablesSSPartPurchase,AbleToAnnexCityStates,OneShot,IncludesOneShotFreeUnits,WeLoveTheKing,FreeBuildingOnConquest,TechPrereq,PortraitIndex,IconAtlas,IconAtlasAchieved)
SELECT Type || '_F',1,Description,Civilopedia,Strategy,Help,'POLICY_BRANCH_FREEDOM',OriginalPolicyBranchType,NumExtraBranches,CultureCost,GridX,GridY,Level,PolicyCostModifier,CulturePerCity,CulturePerWonder,CultureWonderMultiplier,CulturePerTechResearched,CultureImprovementChange,CultureFromKills,CultureFromBarbarianKills,GoldFromKills,EmbarkedExtraMoves,AttackBonusTurns,GoldenAgeTurns,GoldenAgeMeterMod,GoldenAgeDurationMod,NumFreeTechs,NumFreePolicies,NumFreeGreatPeople,MedianTechPercentChange,StrategicResourceMod,WonderProductionModifier,BuildingProductionModifier,GreatPeopleRateModifier,GreatGeneralRateModifier,GreatAdmiralRateModifier,GreatWriterRateModifier,GreatArtistRateModifier,GreatMusicianRateModifier,GreatMerchantRateModifier,GreatScientistRateModifier,DomesticGreatGeneralRateModifier,ExtraHappiness,ExtraHappinessPerCity,UnhappinessMod,CityCountUnhappinessMod,OccupiedPopulationUnhappinessMod,CapitalUnhappinessMod,FreeExperience,WorkerSpeedModifier,AllFeatureProduction,ImprovementCostModifier,ImprovementUpgradeRateModifier,SpecialistProductionModifier,SpecialistUpgradeModifier,MilitaryProductionModifier,BaseFreeUnits,BaseFreeMilitaryUnits,FreeUnitsPopulationPercent,FreeMilitaryUnitsPopulationPercent,HappinessPerGarrisonedUnit,CulturePerGarrisonedUnit,HappinessPerTradeRoute,HappinessPerXPopulation,ExtraHappinessPerLuxury,UnhappinessFromUnitsMod,NumExtraBuilders,PlotGoldCostMod,PlotCultureCostModifier,PlotCultureExponentModifier,NumCitiesPolicyCostDiscount,GarrisonedCityRangeStrikeModifier,UnitPurchaseCostModifier,BuildingPurchaseCostModifier,CityConnectionTradeRouteGoldModifier,TradeMissionGoldModifier,FaithCostModifier,CulturalPlunderMultiplier,StealTechSlowerModifier,StealTechFasterModifier,CatchSpiesModifier,GoldPerUnit,GoldPerMilitaryUnit,RouteGoldMaintenanceMod,BuildingGoldMaintenanceMod,UnitGoldMaintenanceMod,UnitSupplyMod,UnitUpgradeCostMod,CityStrengthMod,CityGrowthMod,CapitalGrowthMod,SettlerProductionModifier,CapitalSettlerProductionModifier,NewCityExtraPopulation,FreeFoodBox,HappyPerMilitaryUnit,MilitaryFoodProduction,HappinessToCulture,HappinessToScience,NumCitiesFreeCultureBuilding,NumCitiesFreeFoodBuilding,HalfSpecialistUnhappiness,HalfSpecialistFood,MaxConscript,UnitSightRangeChange,WoundedUnitDamageMod,BarbarianCombatBonus,AlwaysSeeBarbCamps,RevealAllCapitals,FreeSpecialist,ExpModifier,ExpInBorderModifier,MinorQuestFriendshipMod,MinorGoldFriendshipMod,MinorFriendshipMinimum,MinorFriendshipDecayMod,OtherPlayersMinorFriendshipDecayMod,CityStateUnitFrequencyModifier,CommonFoeTourismModifier,LessHappyTourismModifier,SharedIdeologyTourismModifier,LandTradeRouteGoldChange,SeaTradeRouteGoldChange,SharedIdeologyTradeGoldChange,RiggingElectionModifier,MilitaryUnitGiftExtraInfluence,ProtectedMinorPerTurnInfluence,AfraidMinorPerTurnInfluence,MinorBullyScoreModifier,CityStateTradeChange,ThemingBonusMultiplier,InternalTradeRouteYieldModifier,SharedReligionTourismModifier,TradeRouteTourismModifier,OpenBordersTourismModifier,MinorGreatPeopleAllies,MinorScienceAllies,MinorResourceBonus,GarrisonFreeMaintenance,GoldenAgeCultureBonusDisabled,SecondReligionPantheon,AddReformationBelief,EnablesSSPartHurry,EnablesSSPartPurchase,AbleToAnnexCityStates,OneShot,IncludesOneShotFreeUnits,WeLoveTheKing,FreeBuildingOnConquest,TechPrereq,25,'POLICY_ATLAS','POLICY_A_ATLAS'
FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0;
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_Flavors (PolicyType, FlavorType, Flavor)
SELECT PolicyType || '_F', FlavorType, Flavor
FROM Policy_Flavors WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_CityYieldChanges (PolicyType, YieldType, Yield)
SELECT PolicyType || '_F', YieldType, Yield
FROM Policy_CityYieldChanges WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_CoastalCityYieldChanges (PolicyType, YieldType, Yield)
SELECT PolicyType || '_F', YieldType, Yield
FROM Policy_CoastalCityYieldChanges WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_CapitalYieldChanges (PolicyType, YieldType, Yield)
SELECT PolicyType || '_F', YieldType, Yield
FROM Policy_CapitalYieldChanges WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_CapitalYieldPerPopChanges (PolicyType, YieldType, Yield)
SELECT PolicyType || '_F', YieldType, Yield
FROM Policy_CapitalYieldPerPopChanges WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_CapitalYieldModifiers (PolicyType, YieldType, Yield)
SELECT PolicyType || '_F', YieldType, Yield
FROM Policy_CapitalYieldModifiers WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_GreatWorkYieldChanges (PolicyType, YieldType, Yield)
SELECT PolicyType || '_F', YieldType, Yield
FROM Policy_GreatWorkYieldChanges WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_HurryModifiers (PolicyType, HurryType, HurryCostModifier)
SELECT PolicyType || '_F', HurryType, HurryCostModifier
FROM Policy_HurryModifiers WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_SpecialistExtraYields (PolicyType, YieldType, Yield)
SELECT PolicyType || '_F', YieldType, Yield
FROM Policy_SpecialistExtraYields WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_BuildingClassYieldModifiers (PolicyType, BuildingClassType, YieldType, YieldMod)
SELECT PolicyType || '_F', BuildingClassType, YieldType, YieldMod
FROM Policy_BuildingClassYieldModifiers WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_BuildingClassYieldChanges (PolicyType, BuildingClassType, YieldType, YieldChange)
SELECT PolicyType || '_F', BuildingClassType, YieldType, YieldChange
FROM Policy_BuildingClassYieldChanges WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_BuildingClassCultureChanges (PolicyType, BuildingClassType, CultureChange)
SELECT PolicyType || '_F', BuildingClassType, CultureChange
FROM Policy_BuildingClassCultureChanges WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_BuildingClassProductionModifiers (PolicyType, BuildingClassType, ProductionModifier)
SELECT PolicyType || '_F', BuildingClassType, ProductionModifier
FROM Policy_BuildingClassProductionModifiers WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_BuildingClassTourismModifiers (PolicyType, BuildingClassType, TourismModifier)
SELECT PolicyType || '_F', BuildingClassType, TourismModifier
FROM Policy_BuildingClassTourismModifiers WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_BuildingClassHappiness (PolicyType, BuildingClassType, Happiness)
SELECT PolicyType || '_F', BuildingClassType, Happiness
FROM Policy_BuildingClassHappiness WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_ImprovementYieldChanges (PolicyType, ImprovementType, YieldType, Yield)
SELECT PolicyType || '_F', ImprovementType, YieldType, Yield
FROM Policy_ImprovementYieldChanges WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_ImprovementCultureChanges (PolicyType, ImprovementType, CultureChange)
SELECT PolicyType || '_F', ImprovementType, CultureChange
FROM Policy_ImprovementCultureChanges WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_ValidSpecialists (PolicyType, SpecialistType)
SELECT PolicyType || '_F', SpecialistType
FROM Policy_ValidSpecialists WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_YieldModifiers (PolicyType, YieldType, Yield)
SELECT PolicyType || '_F', YieldType, Yield
FROM Policy_YieldModifiers WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_FreePromotions (PolicyType, PromotionType)
SELECT PolicyType || '_F', PromotionType
FROM Policy_FreePromotions WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_UnitCombatFreeExperiences (PolicyType, UnitCombatType, FreeExperience)
SELECT PolicyType || '_F', UnitCombatType, FreeExperience
FROM Policy_UnitCombatFreeExperiences WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_FreePromotionUnitCombats (PolicyType, UnitCombatType, PromotionType)
SELECT PolicyType || '_F', UnitCombatType, PromotionType
FROM Policy_FreePromotionUnitCombats WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_UnitCombatProductionModifiers (PolicyType, UnitCombatType, ProductionModifier)
SELECT PolicyType || '_F', UnitCombatType, ProductionModifier
FROM Policy_UnitCombatProductionModifiers WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_FreeUnitClasses (PolicyType, UnitClassType, Count)
SELECT PolicyType || '_F', UnitClassType, Count
FROM Policy_FreeUnitClasses WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_TourismOnUnitCreation (PolicyType, UnitClassType, Tourism)
SELECT PolicyType || '_F', UnitClassType, Tourism
FROM Policy_TourismOnUnitCreation WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_FreeItems (PolicyType, SetType, MinItems, MaxItems)
SELECT PolicyType || '_F', SetType, MinItems, MaxItems
FROM Policy_FreeItems WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_ORDER') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
-- ORDER
--------------------------------------------------------------------------------------------------------------------------
INSERT OR REPLACE INTO Policies (Type,IsDuplicateIdeologicalTenet,Description,Civilopedia,Strategy,Help,PolicyBranchType,OriginalPolicyBranchType,NumExtraBranches,CultureCost,GridX,GridY,Level,PolicyCostModifier,CulturePerCity,CulturePerWonder,CultureWonderMultiplier,CulturePerTechResearched,CultureImprovementChange,CultureFromKills,CultureFromBarbarianKills,GoldFromKills,EmbarkedExtraMoves,AttackBonusTurns,GoldenAgeTurns,GoldenAgeMeterMod,GoldenAgeDurationMod,NumFreeTechs,NumFreePolicies,NumFreeGreatPeople,MedianTechPercentChange,StrategicResourceMod,WonderProductionModifier,BuildingProductionModifier,GreatPeopleRateModifier,GreatGeneralRateModifier,GreatAdmiralRateModifier,GreatWriterRateModifier,GreatArtistRateModifier,GreatMusicianRateModifier,GreatMerchantRateModifier,GreatScientistRateModifier,DomesticGreatGeneralRateModifier,ExtraHappiness,ExtraHappinessPerCity,UnhappinessMod,CityCountUnhappinessMod,OccupiedPopulationUnhappinessMod,CapitalUnhappinessMod,FreeExperience,WorkerSpeedModifier,AllFeatureProduction,ImprovementCostModifier,ImprovementUpgradeRateModifier,SpecialistProductionModifier,SpecialistUpgradeModifier,MilitaryProductionModifier,BaseFreeUnits,BaseFreeMilitaryUnits,FreeUnitsPopulationPercent,FreeMilitaryUnitsPopulationPercent,HappinessPerGarrisonedUnit,CulturePerGarrisonedUnit,HappinessPerTradeRoute,HappinessPerXPopulation,ExtraHappinessPerLuxury,UnhappinessFromUnitsMod,NumExtraBuilders,PlotGoldCostMod,PlotCultureCostModifier,PlotCultureExponentModifier,NumCitiesPolicyCostDiscount,GarrisonedCityRangeStrikeModifier,UnitPurchaseCostModifier,BuildingPurchaseCostModifier,CityConnectionTradeRouteGoldModifier,TradeMissionGoldModifier,FaithCostModifier,CulturalPlunderMultiplier,StealTechSlowerModifier,StealTechFasterModifier,CatchSpiesModifier,GoldPerUnit,GoldPerMilitaryUnit,RouteGoldMaintenanceMod,BuildingGoldMaintenanceMod,UnitGoldMaintenanceMod,UnitSupplyMod,UnitUpgradeCostMod,CityStrengthMod,CityGrowthMod,CapitalGrowthMod,SettlerProductionModifier,CapitalSettlerProductionModifier,NewCityExtraPopulation,FreeFoodBox,HappyPerMilitaryUnit,MilitaryFoodProduction,HappinessToCulture,HappinessToScience,NumCitiesFreeCultureBuilding,NumCitiesFreeFoodBuilding,HalfSpecialistUnhappiness,HalfSpecialistFood,MaxConscript,UnitSightRangeChange,WoundedUnitDamageMod,BarbarianCombatBonus,AlwaysSeeBarbCamps,RevealAllCapitals,FreeSpecialist,ExpModifier,ExpInBorderModifier,MinorQuestFriendshipMod,MinorGoldFriendshipMod,MinorFriendshipMinimum,MinorFriendshipDecayMod,OtherPlayersMinorFriendshipDecayMod,CityStateUnitFrequencyModifier,CommonFoeTourismModifier,LessHappyTourismModifier,SharedIdeologyTourismModifier,LandTradeRouteGoldChange,SeaTradeRouteGoldChange,SharedIdeologyTradeGoldChange,RiggingElectionModifier,MilitaryUnitGiftExtraInfluence,ProtectedMinorPerTurnInfluence,AfraidMinorPerTurnInfluence,MinorBullyScoreModifier,CityStateTradeChange,ThemingBonusMultiplier,InternalTradeRouteYieldModifier,SharedReligionTourismModifier,TradeRouteTourismModifier,OpenBordersTourismModifier,MinorGreatPeopleAllies,MinorScienceAllies,MinorResourceBonus,GarrisonFreeMaintenance,GoldenAgeCultureBonusDisabled,SecondReligionPantheon,AddReformationBelief,EnablesSSPartHurry,EnablesSSPartPurchase,AbleToAnnexCityStates,OneShot,IncludesOneShotFreeUnits,WeLoveTheKing,FreeBuildingOnConquest,TechPrereq,PortraitIndex,IconAtlas,IconAtlasAchieved)
SELECT Type || '_O',1,Description,Civilopedia,Strategy,Help,'POLICY_BRANCH_ORDER',OriginalPolicyBranchType,NumExtraBranches,CultureCost,GridX,GridY,Level,PolicyCostModifier,CulturePerCity,CulturePerWonder,CultureWonderMultiplier,CulturePerTechResearched,CultureImprovementChange,CultureFromKills,CultureFromBarbarianKills,GoldFromKills,EmbarkedExtraMoves,AttackBonusTurns,GoldenAgeTurns,GoldenAgeMeterMod,GoldenAgeDurationMod,NumFreeTechs,NumFreePolicies,NumFreeGreatPeople,MedianTechPercentChange,StrategicResourceMod,WonderProductionModifier,BuildingProductionModifier,GreatPeopleRateModifier,GreatGeneralRateModifier,GreatAdmiralRateModifier,GreatWriterRateModifier,GreatArtistRateModifier,GreatMusicianRateModifier,GreatMerchantRateModifier,GreatScientistRateModifier,DomesticGreatGeneralRateModifier,ExtraHappiness,ExtraHappinessPerCity,UnhappinessMod,CityCountUnhappinessMod,OccupiedPopulationUnhappinessMod,CapitalUnhappinessMod,FreeExperience,WorkerSpeedModifier,AllFeatureProduction,ImprovementCostModifier,ImprovementUpgradeRateModifier,SpecialistProductionModifier,SpecialistUpgradeModifier,MilitaryProductionModifier,BaseFreeUnits,BaseFreeMilitaryUnits,FreeUnitsPopulationPercent,FreeMilitaryUnitsPopulationPercent,HappinessPerGarrisonedUnit,CulturePerGarrisonedUnit,HappinessPerTradeRoute,HappinessPerXPopulation,ExtraHappinessPerLuxury,UnhappinessFromUnitsMod,NumExtraBuilders,PlotGoldCostMod,PlotCultureCostModifier,PlotCultureExponentModifier,NumCitiesPolicyCostDiscount,GarrisonedCityRangeStrikeModifier,UnitPurchaseCostModifier,BuildingPurchaseCostModifier,CityConnectionTradeRouteGoldModifier,TradeMissionGoldModifier,FaithCostModifier,CulturalPlunderMultiplier,StealTechSlowerModifier,StealTechFasterModifier,CatchSpiesModifier,GoldPerUnit,GoldPerMilitaryUnit,RouteGoldMaintenanceMod,BuildingGoldMaintenanceMod,UnitGoldMaintenanceMod,UnitSupplyMod,UnitUpgradeCostMod,CityStrengthMod,CityGrowthMod,CapitalGrowthMod,SettlerProductionModifier,CapitalSettlerProductionModifier,NewCityExtraPopulation,FreeFoodBox,HappyPerMilitaryUnit,MilitaryFoodProduction,HappinessToCulture,HappinessToScience,NumCitiesFreeCultureBuilding,NumCitiesFreeFoodBuilding,HalfSpecialistUnhappiness,HalfSpecialistFood,MaxConscript,UnitSightRangeChange,WoundedUnitDamageMod,BarbarianCombatBonus,AlwaysSeeBarbCamps,RevealAllCapitals,FreeSpecialist,ExpModifier,ExpInBorderModifier,MinorQuestFriendshipMod,MinorGoldFriendshipMod,MinorFriendshipMinimum,MinorFriendshipDecayMod,OtherPlayersMinorFriendshipDecayMod,CityStateUnitFrequencyModifier,CommonFoeTourismModifier,LessHappyTourismModifier,SharedIdeologyTourismModifier,LandTradeRouteGoldChange,SeaTradeRouteGoldChange,SharedIdeologyTradeGoldChange,RiggingElectionModifier,MilitaryUnitGiftExtraInfluence,ProtectedMinorPerTurnInfluence,AfraidMinorPerTurnInfluence,MinorBullyScoreModifier,CityStateTradeChange,ThemingBonusMultiplier,InternalTradeRouteYieldModifier,SharedReligionTourismModifier,TradeRouteTourismModifier,OpenBordersTourismModifier,MinorGreatPeopleAllies,MinorScienceAllies,MinorResourceBonus,GarrisonFreeMaintenance,GoldenAgeCultureBonusDisabled,SecondReligionPantheon,AddReformationBelief,EnablesSSPartHurry,EnablesSSPartPurchase,AbleToAnnexCityStates,OneShot,IncludesOneShotFreeUnits,WeLoveTheKing,FreeBuildingOnConquest,TechPrereq,11,'POLICY_ATLAS_EXP2','POLICY_A_ATLAS_EXP2' 
FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_FREEDOM') AND IsDuplicateIdeologicalTenet = 0;
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_Flavors (PolicyType, FlavorType, Flavor)
SELECT PolicyType || '_O', FlavorType, Flavor
FROM Policy_Flavors WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_FREEDOM') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_CityYieldChanges (PolicyType, YieldType, Yield)
SELECT PolicyType || '_O', YieldType, Yield
FROM Policy_CityYieldChanges WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_FREEDOM') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_CoastalCityYieldChanges (PolicyType, YieldType, Yield)
SELECT PolicyType || '_O', YieldType, Yield
FROM Policy_CoastalCityYieldChanges WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_FREEDOM') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_CapitalYieldChanges (PolicyType, YieldType, Yield)
SELECT PolicyType || '_O', YieldType, Yield
FROM Policy_CapitalYieldChanges WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_FREEDOM') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_CapitalYieldPerPopChanges (PolicyType, YieldType, Yield)
SELECT PolicyType || '_O', YieldType, Yield
FROM Policy_CapitalYieldPerPopChanges WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_FREEDOM') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_CapitalYieldModifiers (PolicyType, YieldType, Yield)
SELECT PolicyType || '_O', YieldType, Yield
FROM Policy_CapitalYieldModifiers WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_FREEDOM') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_GreatWorkYieldChanges (PolicyType, YieldType, Yield)
SELECT PolicyType || '_O', YieldType, Yield
FROM Policy_GreatWorkYieldChanges WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_FREEDOM') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_HurryModifiers (PolicyType, HurryType, HurryCostModifier)
SELECT PolicyType || '_O', HurryType, HurryCostModifier
FROM Policy_HurryModifiers WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_FREEDOM') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_SpecialistExtraYields (PolicyType, YieldType, Yield)
SELECT PolicyType || '_O', YieldType, Yield
FROM Policy_SpecialistExtraYields WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_FREEDOM') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_BuildingClassYieldModifiers (PolicyType, BuildingClassType, YieldType, YieldMod)
SELECT PolicyType || '_O', BuildingClassType, YieldType, YieldMod
FROM Policy_BuildingClassYieldModifiers WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_FREEDOM') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_BuildingClassYieldChanges (PolicyType, BuildingClassType, YieldType, YieldChange)
SELECT PolicyType || '_O', BuildingClassType, YieldType, YieldChange
FROM Policy_BuildingClassYieldChanges WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_FREEDOM') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_BuildingClassCultureChanges (PolicyType, BuildingClassType, CultureChange)
SELECT PolicyType || '_O', BuildingClassType, CultureChange
FROM Policy_BuildingClassCultureChanges WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_FREEDOM') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_BuildingClassProductionModifiers (PolicyType, BuildingClassType, ProductionModifier)
SELECT PolicyType || '_O', BuildingClassType, ProductionModifier
FROM Policy_BuildingClassProductionModifiers WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_FREEDOM') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_BuildingClassTourismModifiers (PolicyType, BuildingClassType, TourismModifier)
SELECT PolicyType || '_O', BuildingClassType, TourismModifier
FROM Policy_BuildingClassTourismModifiers WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_FREEDOM') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_BuildingClassHappiness (PolicyType, BuildingClassType, Happiness)
SELECT PolicyType || '_O', BuildingClassType, Happiness
FROM Policy_BuildingClassHappiness WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_FREEDOM') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_ImprovementYieldChanges (PolicyType, ImprovementType, YieldType, Yield)
SELECT PolicyType || '_O', ImprovementType, YieldType, Yield
FROM Policy_ImprovementYieldChanges WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_FREEDOM') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_ImprovementCultureChanges (PolicyType, ImprovementType, CultureChange)
SELECT PolicyType || '_O', ImprovementType, CultureChange
FROM Policy_ImprovementCultureChanges WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_FREEDOM') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_ValidSpecialists (PolicyType, SpecialistType)
SELECT PolicyType || '_O', SpecialistType
FROM Policy_ValidSpecialists WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_FREEDOM') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_YieldModifiers (PolicyType, YieldType, Yield)
SELECT PolicyType || '_O', YieldType, Yield
FROM Policy_YieldModifiers WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_FREEDOM') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_FreePromotions (PolicyType, PromotionType)
SELECT PolicyType || '_O', PromotionType
FROM Policy_FreePromotions WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_FREEDOM') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_UnitCombatFreeExperiences (PolicyType, UnitCombatType, FreeExperience)
SELECT PolicyType || '_O', UnitCombatType, FreeExperience
FROM Policy_UnitCombatFreeExperiences WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_FREEDOM') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_FreePromotionUnitCombats (PolicyType, UnitCombatType, PromotionType)
SELECT PolicyType || '_O', UnitCombatType, PromotionType
FROM Policy_FreePromotionUnitCombats WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_FREEDOM') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_UnitCombatProductionModifiers (PolicyType, UnitCombatType, ProductionModifier)
SELECT PolicyType || '_O', UnitCombatType, ProductionModifier
FROM Policy_UnitCombatProductionModifiers WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_FREEDOM') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_FreeUnitClasses (PolicyType, UnitClassType, Count)
SELECT PolicyType || '_O', UnitClassType, Count
FROM Policy_FreeUnitClasses WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_FREEDOM') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_TourismOnUnitCreation (PolicyType, UnitClassType, Tourism)
SELECT PolicyType || '_O', UnitClassType, Tourism
FROM Policy_TourismOnUnitCreation WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_FREEDOM') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_FreeItems (PolicyType, SetType, MinItems, MaxItems)
SELECT PolicyType || '_O', SetType, MinItems, MaxItems
FROM Policy_FreeItems WHERE PolicyType IS NOT NULL
AND PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_FREEDOM') AND IsDuplicateIdeologicalTenet = 0);
--------------------------------------------------------------------------------------------------------------------------
--==========================================================================================================================
--==========================================================================================================================