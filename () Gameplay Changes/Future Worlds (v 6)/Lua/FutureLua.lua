-- FutureLua
-- Author: Bouncymischa
-- Optimization: Limaeus for the CBR
-- DateCreated: 4/15/2015 9:16:51 AM
--------------------------------------------------------------

print("Future Worlds code is loading")

include("MischaIteratingPlotsFunctions")
include("CityNearbyMapDatasV4")

----------------------------------------------------------------------------------------------------------------------------
-- GLOBAL
----------------------------------------------------------------------------------------------------------------------------

-- Improvements
local improvementAcademy = GameInfoTypes["IMPROVEMENT_ACADEMY"]
local improvementArcology = GameInfoTypes["IMPROVEMENT_FW_ARCOLOGY"]
local improvementCommArray = GameInfoTypes["IMPROVEMENT_FW_COMM_ARRAY"]
local improvementCore = GameInfoTypes["IMPROVEMENT_FW_CORE"]
local improvementDome = GameInfoTypes["IMPROVEMENT_FW_HYDROPONICS_DOME"]
local improvementFarm = GameInfoTypes["IMPROVEMENT_FARM"]
local improvementFungus = GameInfoTypes["IMPROVEMENT_FW_FUNGAL_GROWTH"]
local improvementGenerator = GameInfoTypes["IMPROVEMENT_FW_GENERATOR"]
local improvementHERC = GameInfoTypes["IMPROVEMENT_FW_HERC"]
local improvementPlantation = GameInfoTypes["IMPROVEMENT_PLANTATION"]
local improvementPreserve = GameInfoTypes["IMPROVEMENT_FW_PRESERVE"]

-- Terrain
local terrainGrasslands = GameInfoTypes["TERRAIN_GRASS"]
local terrainPlains = GameInfoTypes["TERRAIN_PLAINS"]

-- Buildings
local buildingAutoPlantDummy = GameInfoTypes["BUILDING_FW_AUTOPLANT_DUMMY"]
local buildingAutoplant = GameInfoTypes["BUILDING_FW_AUTOPLANT"]
local buildingBiofactory = GameInfoTypes["BUILDING_FW_BIOFACTORY"]
local buildingBrainUploading = GameInfoTypes["BUILDING_FW_BRAIN_UPLOADING"]
local buildingBrainUploadingDummy = GameInfoTypes["BUILDING_FW_BRAIN_UPLOADING_DUMMY_1"]
local buildingClassECommerceServer = GameInfoTypes["BUILDINGCLASS_FW_COMMERCE_SERVER"]
local buildingClassEntertainmentServer = GameInfoTypes["BUILDINGCLASS_FW_ENTERTAINMENT_SERVER"]
local buildingClassResearchServer = GameInfoTypes["BUILDINGCLASS_FW_RESEARCH_SERVER"]
local buildingClassServerHub = GameInfoTypes["BUILDINGCLASS_FW_SERVER_HUB"]
local buildingCloneLab = GameInfoTypes["BUILDING_FW_CLONE_LAB"]
local buildingColosseum = GameInfoTypes["BUILDING_COLOSSEUM"]
local buildingCommModule = GameInfoTypes["BUILDING_FW_COMM_MODULE_1"]
local buildingDistributionHub = GameInfoTypes["BUILDING_FW_DISTRIBUTION_HUB"]
local buildingDistributionHubDummy = GameInfoTypes["BUILDING_FW_DISTRIBUTION_HUB_DUMMY"]
local buildingDroneHive = GameInfoTypes["BUILDING_FW_DRONE_HIVE"]
local buildingDroneHiveDummy_1 = GameInfoTypes["BUILDING_FW_DRONE_HIVE_DUMMY_1"]
local buildingEctogenesisPod = GameInfoTypes["BUILDING_FW_ECTOGENESIS_POD"]
local buildingEngineeringModule = GameInfoTypes["BUILDING_FW_ENGINEERING_MODULE_1"]
local buildingFeedsiteHub = GameInfoTypes["BUILDING_FW_FEEDSITE_HUB"]
local buildingFeedsiteHubDummy_1 = GameInfoTypes["BUILDING_FW_FEEDSITE_HUB_DUMMY_1"]
local buildingFeedsiteHubDummy_2 = GameInfoTypes["BUILDING_FW_FEEDSITE_HUB_DUMMY_2"]
local buildingGeneJackFacility = GameInfoTypes["BUILDING_FW_GENEJACK_FACILITY"]
local buildingGeneLab = GameInfoTypes["BUILDING_FW_GENE_LAB"]
local buildingGeneLabDummy = GameInfoTypes["BUILDING_FW_GENE_LAB_DUMMY"]
local buildingMenagerie = GameInfoTypes["BUILDING_EE_MENAGERIE"]
local buildingMetroplexHub = GameInfoTypes["BUILDING_FW_METROPLEX_HUB"]
local buildingMetroplexHubDummy = GameInfoTypes["BUILDING_FW_METROPLEX_HUB_DUMMY"]
local buildingMycoproteinVats = GameInfoTypes["BUILDING_FW_MYCOPROTEIN_VATS"]
local buildingNetworkBackbone = GameInfoTypes["BUILDING_FW_NETWORK_BACKBONE"]
local buildingNetworkBackboneDummy_1 = GameInfoTypes["BUILDING_FW_NETWORK_BACKBONE_DUMMY_1"]
local buildingNetworkBackboneDummy_2 = GameInfoTypes["BUILDING_FW_NETWORK_BACKBONE_DUMMY_2"]
local buildingNetworkBackboneDummy_3 = GameInfoTypes["BUILDING_FW_NETWORK_BACKBONE_DUMMY_3"]
local buildingOrbitalHabitat = GameInfoTypes["BUILDING_FW_ORBITAL_HABITAT"]
local buildingOrbitalHabitatDummy = GameInfoTypes["BUILDING_FW_ORBITAL_HABITAT_DUMMY"]
local buildingResearchModule = GameInfoTypes["BUILDING_FW_RESEARCH_MODULE_1"]
local buildingSanctuary = GameInfoTypes["BUILDING_FW_SANCTUARY"]
local buildingSanctuaryDummy = GameInfoTypes["BUILDING_FW_SANCTUARY_DUMMY"]
local buildingSimulationServer = GameInfoTypes["BUILDING_FW_SIMULATION_SERVER"]
local buildingSimulationServerDummy_2 = GameInfoTypes["BUILDING_FW_SIMULATION_SERVER_DUMMY_2"]
local buildingSolarPlant = GameInfoTypes["BUILDING_SOLAR_PLANT"]
local buildingSpaceStation = GameInfoTypes["BUILDING_FW_SPACE_STATION"]
local buildingStadium = GameInfoTypes["BUILDING_STADIUM"]
local buildingTGNursery = GameInfoTypes["BUILDING_FW_TG_NURSERY"]
local buildingTelepresenceDummy = GameInfoTypes["BUILDING_FW_TELEPRESENCE_HUB_DUMMY"]
local buildingTelepresenceHub = GameInfoTypes["BUILDING_FW_TELEPRESENCE_HUB"]
local buildingUtilityFog = GameInfoTypes["BUILDING_FW_UTILITY_FOG"]
local buildingVerticalFarm = GameInfoTypes["BUILDING_FW_VERTICAL_FARM"]
local buildingVerticalFarmDummy = GameInfoTypes["BUILDING_FW_VERTICAL_FARM_DUMMY"]

-- Wonders
local wonderAccelerator = GameInfoTypes["BUILDING_FW_ACCELERATOR"]
local wonderAngelnet = GameInfoTypes["BUILDING_FW_ANGELNET"]
local wonderAngelnetDummy = GameInfoTypes["BUILDING_FW_ANGELNET_DUMMY"]
local wonderBionicTower = GameInfoTypes["BUILDING_FW_BIONICTOWER"]
local wonderBionicTower = GameInfoTypes["BUILDING_FW_BIONICTOWER"]
local wonderBorehole = GameInfoTypes["BUILDING_FW_BOREHOLE"]
local wonderBuenosAiresForum = GameInfoTypes["BUILDING_FW_BUENOSAIRESFORUM"]
local wonderDataHaven = GameInfoTypes["BUILDING_FW_DATA_HAVEN"]
local wonderDataHavenDummy = GameInfoTypes["BUILDING_FW_DATA_HAVEN_DUMMY"]
local wonderGeneVault = GameInfoTypes["BUILDING_FW_GENE_VAULT"]
local wonderGeneVault = GameInfoTypes["BUILDING_FW_GENE_VAULT"]
local wonderHelios = GameInfoTypes["BUILDING_FW_HELIOS"]
local wonderJurassicPark = GameInfoTypes["BUILDING_FW_JURASSIC_PARK"]
local wonderMnesmosyne = GameInfoTypes["BUILDING_FW_MNEMOSYNE"]
local wonderNephilim = GameInfoTypes["BUILDING_FW_NEPHILIM_GENE_TEMPLATE"]
local wonderNephilimDummy = GameInfoTypes["BUILDING_FW_NEPHILIMGENETEMPLATE_DUMMY"]
local wonderPholusMutagen = GameInfoTypes["BUILDING_FW_PHOLUS_MUTAGEN"]
local wonderShimizu = GameInfoTypes["BUILDING_FW_SHIMIZUMCP"]
local wonderShimizuDummy = GameInfoTypes["BUILDING_FW_SHIMIZUMCP_DUMMY"]
local wonderSkynet = GameInfoTypes["BUILDING_FW_SKYNET"]

local wonderClassAccelerator = GameInfoTypes["BUILDINGCLASS_FW_ACCELERATOR"]
local wonderClassAngelnet = GameInfoTypes["BUILDINGCLASS_FW_ANGELNET"]
local wonderClassBionicTower = GameInfoTypes["BUILDINGCLASS_FW_BIONICTOWER"]
local wonderClassBorehole = GameInfoTypes["BUILDINGCLASS_FW_BOREHOLE"]
local wonderClassBuenosAiresForum = GameInfoTypes["BUILDINGCLASS_FW_BUENOSAIRESFORUM"]
local wonderClassDataHaven = GameInfoTypes["BUILDINGCLASS_FW_DATA_HAVEN"]
local wonderClassGeneVault = GameInfoTypes["BUILDINGCLASS_FW_GENE_VAULT"]
local wonderClassHelios = GameInfoTypes["BUILDINGCLASS_FW_HELIOS"]
local wonderClassJurassicPark = GameInfoTypes["BUILDINGCLASS_FW_JURASSIC_PARK"]
local wonderClassLaunchFacility = GameInfoTypes["BUILDINGCLASS_FW_LAUNCH_FACILITY"]
local wonderClassMnemosyne = GameInfoTypes["BUILDINGCLASS_FW_MNEMOSYNE"]
local wonderClassNephilim = GameInfoTypes["BUILDINGCLASS_FW_NEPHILIM_GENE_TEMPLATE"]
local wonderClassPholusMutagen = GameInfoTypes["BUILDINGCLASS_FW_PHOLUS_MUTAGEN"]
local wonderClassShimizu = GameInfoTypes["BUILDINGCLASS_FW_SHIMIZUMCP"]
local wonderClassSkynet = GameInfoTypes["BUILDINGCLASS_FW_SKYNET"]

-- PreReq Techs
local techGengineering = GameInfoTypes["TECH_GENGINEERING"]

-- Promotions
local promotionBiomods = GameInfoTypes["PROMOTION_FW_BIOMODS"]
local promotionBoostMod = GameInfoTypes["PROMOTION_FW_BOOST_MOD"]
local promotionBoostModEmpty = GameInfoTypes["PROMOTION_FW_BOOST_MOD_EMPTY"]
local promotionBoostMod_1 = GameInfoTypes["PROMOTION_FW_BOOST_MOD_EFFECT_1"]
local promotionBoostMod_2 = GameInfoTypes["PROMOTION_FW_BOOST_MOD_EFFECT_2"]
local promotionBoostMod_3 = GameInfoTypes["PROMOTION_FW_BOOST_MOD_EFFECT_3"]
local promotionEmbarkation_1 = GameInfoTypes["PROMOTION_EMBARKATION"]
local promotionEmbarkation_2 = GameInfoTypes["PROMOTION_DEFENSIVE_EMBARKATION"]
local promotionEmbarkation_3 = GameInfoTypes["PROMOTION_ALLWATER_EMBARKATION"]
local promotionGengineered = GameInfoTypes["PROMOTION_FW_GENGINEERED"]
local promotionMutation = GameInfoTypes["PROMOTION_FW_MUTATION"]
local promotionNanohive = GameInfoTypes["PROMOTION_FW_NANOHIVE_PROMOTION"]
local promotionStimMod = GameInfoTypes["PROMOTION_FW_STIM_MOD"]
local promotionStimModEmpty = GameInfoTypes["PROMOTION_FW_STIM_MOD_EMPTY"]
local promotionToxinMod = GameInfoTypes["PROMOTION_FW_TOXIN_MOD"]

-- Units
local unitAutomaton = GameInfoTypes["UNIT_FW_AUTOMATON"]
local unitCrawler = GameInfoTypes["UNIT_FW_CRAWLER"]
local unitHydra = GameInfoTypes["UNIT_FW_HYDRA"]
local unitHyperMissile = GameInfoTypes["UNIT_FW_HYPERMISSILE"]
local unitRaptor = GameInfoTypes["UNIT_FW_RAPTOR"]
local unitRobotInfantry = GameInfoTypes["UNIT_FW_ROBOT_INFANTRY"]
local unitSwarm = GameInfoTypes["UNIT_FW_SWARM"]
local unitSwarm = GameInfoTypes["UNIT_FW_SWARM"]
local unitTRex = GameInfoTypes["UNIT_FW_TREX"]
local unitTriceratops = GameInfoTypes["UNIT_FW_TRICERATOPS"]

-- Policies
local poBionicTower = GameInfoTypes["POLICY_BIONIC_TOWER"]
local poBionicTowerDummy = GameInfoTypes["POLICY_BIONIC_TOWER_DUMMY"]
local poBorehole = GameInfoTypes["POLICY_BOREHOLE"]
local poBoreholeDummy = GameInfoTypes["POLICY_BOREHOLE_DUMMY"]
local poGeneVault = GameInfoTypes["POLICY_GENE_VAULT"]
local poGeneVaultDummy = GameInfoTypes["POLICY_GENE_VAULT_DUMMY"]
local poHelios = GameInfoTypes["POLICY_HELIOS"]
local poHeliosDummy = GameInfoTypes["POLICY_HELIOS_DUMMY"]

-- Constants
local iAdjacentFungusModifier = 1
local iChanceDinos = 7
local iChanceForFungus = 1
local iChanceMissileProduction = 33

local bGeneVaultCompleted = false
local bBionicTowerCompleted = false
local bHeliosCompleted = false
local bMnemosyneCompleted = false
local bJurassicParkCompleted = false
local bPholusMutagenCompleted = false
local bNephilimCompleted = false
local bAngelnetCompleted = false
local bDataHavenCompleted = false
local bBuenosAiresForumCompleted = false

--------------------------------------------------------------------------------------------------------------------------
-- JFD_GetRandom
--------------------------------------------------------------------------------------------------------------------------
function JFD_GetRandom(lower, upper)
    return Game.Rand((upper + 1) - lower, "") + lower
end

----------------------------------------------------------------------------------------------------------------------------
-- Future Worlds Functions
----------------------------------------------------------------------------------------------------------------------------
function CityBuiltTest(iPlayer, iCity, iBuilding, bGold, bFaithOrCulture)
	if iBuilding == wonderAccelerator then
		local player = Players[iPlayer]
		for pCity in player:Cities() do
			for i = 0, pCity:GetNumCityPlots() - 1, 1 do
				local pPlot = pCity:GetCityIndexPlot( i )
				if pPlot then
					if pPlot:GetOwner() == pCity:GetOwner() then
						if pPlot:GetImprovementType() == improvementAcademy then
							pPlot:SetImprovementType(improvementHERC)
						end
					end
				end
			end
		end
	end
	if iBuilding == buildingBrainUploading then
		local player = Players[iPlayer]
		local pCity = player:GetCityByID(iCity)
		if pCity:GetNumRealBuilding(buildingBrainUploadingDummy) == 0 then
			local iCityPop = pCity:GetPopulation()
			local iUploadedCitizens = math.floor(iCityPop / 4)
			pCity:ChangePopulation((-1 * iUploadedCitizens), true)
			pCity:SetNumRealBuilding(buildingBrainUploadingDummy, iUploadedCitizens)
		end
	end
end
GameEvents.CityConstructed.Add(CityBuiltTest)

function CheckUploading(iPlotX, iPlotY, iOldPop, iNewPop)
	local pCity = Map.GetPlot(iPlotX, iPlotY):GetPlotCity()
	if (pCity:GetNumRealBuilding(buildingBrainUploading) > 0) and (iNewPop > 3) and (iNewPop > iOldPop) then
		if (JFD_GetRandom(1, 100) < 25) then
			local iUploadedCitizens = pCity:GetNumRealBuilding(buildingBrainUploadingDummy)
			pCity:ChangePopulation(-1, true)
			iUploadedCitizens = iUploadedCitizens + 1
			pCity:SetNumRealBuilding(buildingBrainUploadingDummy, iUploadedCitizens)
		end
	end
end
GameEvents.SetPopulation.Add(CheckUploading)

function CheckImprovements (iHexX, iHexY, iContinent1, iContinent2)
	local pPlot = Map.GetPlot(ToGridFromHex(iHexX, iHexY))
	local ImpID = pPlot:GetImprovementType()
	local Owner = pPlot:GetOwner()
	local player = Players[Owner]
	if player then
		if (ImpID == improvementAcademy and (player:GetBuildingClassCount(wonderClassAccelerator) > 0)) then
			pPlot:SetImprovementType(improvementHERC)
		end
	end
end
Events.SerialEventImprovementCreated.Add(CheckImprovements)

function FWBuildingImprovementBonuses(iPlayer)
	local player = Players[iPlayer]
	if (not player:IsAlive()) then return end
	if not (player:GetCurrentEra() > 5) then return end
	local tMyWheatPlotsThisTurn = {}
	for pCity in player:Cities() do
		local tNearbyDatas = GetCityMapDatas(pCity)
		if pCity:IsHasBuilding(buildingGeneLab) then
			local iNumFarms = GetNumCityWorkingImprovementPlots(tNearbyDatas, improvementFarm)
			
			pCity:SetNumRealBuilding(buildingGeneLabDummy, iNumFarms)
		else
			pCity:SetNumRealBuilding(buildingGeneLabDummy, 0)
		end
		if pCity:IsHasBuilding(buildingSanctuary) then
			local iNumPreserves = GetNumCityWorkingImprovementPlots(tNearbyDatas, improvementPreserve)
			
			pCity:SetNumRealBuilding(buildingSanctuaryDummy, iNumPreserves)
		else
			pCity:SetNumRealBuilding(buildingSanctuaryDummy, 0)
		end
		if pCity:IsHasBuilding(buildingNetworkBackbone) then
			local tCommArrayPlots = GetCityImprovementPlots(tNearbyDatas, improvementCommArray, "Plots")
			local iNumCommArrays = #tCommArrayPlots
			
			pCity:SetNumRealBuilding(buildingNetworkBackboneDummy_3, iNumCommArrays)
		else
			pCity:SetNumRealBuilding(buildingNetworkBackboneDummy_3, 0)
		end
		if pCity:IsHasBuilding(buildingDroneHive) then
			local tGeneratorPlots = GetCityImprovementPlots(tNearbyDatas, improvementGenerator, "Plots")
			local iNumGenerators = #tGeneratorPlots
			
			pCity:SetNumRealBuilding(buildingDroneHiveDummy_1, iNumGenerators)
		else
			pCity:SetNumRealBuilding(buildingDroneHiveDummy_1, 0)
		end
		if pCity:IsHasBuilding(buildingSimulationServer) then
			local tCorePlots = GetCityImprovementPlots(tNearbyDatas, improvementCore, "Plots")
			local iNumCores = #tCorePlots
			
			pCity:SetNumRealBuilding(buildingSimulationServerDummy_2, iNumCores)
		else
			pCity:SetNumRealBuilding(buildingSimulationServerDummy_2, 0)
		end
		if pCity:IsHasBuilding(buildingDistributionHub) then
			local iNumIndustrialSites = GetNumCityWorkingImprovementPlots(tNearbyDatas, iImprovementIndustrialSite)
			pCity:SetNumRealBuilding(buildingDistributionHubDummy, iNumIndustrialSites)
		else
			pCity:SetNumRealBuilding(buildingDistributionHubDummy, 0)
		end
		if pCity:IsHasBuilding(buildingMetroplexHub) then
			local iNumArcologies = GetNumCityWorkingImprovementPlots(tNearbyDatas, improvementArcology)
			pCity:SetNumRealBuilding(buildingMetroplexHubDummy, iNumArcologies)
		else
			pCity:SetNumRealBuilding(buildingMetroplexHubDummy, 0)
		end
		if pCity:IsHasBuilding(buildingVerticalFarm) then
			local iNumDomes = GetNumCityWorkingImprovementPlots(tNearbyDatas, improvementDome)
			
			pCity:SetNumRealBuilding(buildingVerticalFarmDummy, iNumDomes)
		else
			pCity:SetNumRealBuilding(buildingVerticalFarmDummy, 0)
		end
	end
end
GameEvents.PlayerDoTurn.Add(FWBuildingImprovementBonuses)

function FutureTurnBonuses(iPlayer)
	local player = Players[iPlayer]
	if (not player:IsAlive()) then return end
	if not (player:GetCurrentEra() > 5) then return end

	for pCity in player:Cities() do
		-- Feedsite or Information Hub Building
		if pCity:IsHasBuilding(buildingFeedsiteHub) then
			local iNumHappiness = 0
			if pCity:IsHasBuilding(buildingColosseum) then iNumHappiness = iNumHappiness + 1 end
			if pCity:IsHasBuilding(buildingMenagerie) then iNumHappiness = iNumHappiness + 1 end
			if pCity:IsHasBuilding(buildingStadium) then iNumHappiness = iNumHappiness + 1 end
			pCity:SetNumRealBuilding(buildingFeedsiteHubDummy_2, iNumHappiness)
			pCity:SetNumRealBuilding(buildingFeedsiteHubDummy_1, pCity:GetNumGreatWorks())
		end

		-- Network Backbone Building
		if pCity:IsHasBuilding(buildingNetworkBackbone) then
			local iNumResearchServers = player:GetBuildingClassCount(buildingClassResearchServer)
			if iNumResearchServers > 10 then iNumResearchServers = 10 end
			local iNumEntertainmentServers = player:GetBuildingClassCount(buildingClassEntertainmentServer)
			if iNumEntertainmentServers > 10 then iNumEntertainmentServers = 10 end
			pCity:SetNumRealBuilding(buildingNetworkBackboneDummy_1, iNumResearchServers)
			pCity:SetNumRealBuilding(buildingNetworkBackboneDummy_2, iNumEntertainmentServers)
		else
			pCity:SetNumRealBuilding(buildingNetworkBackboneDummy_1, 0)
			pCity:SetNumRealBuilding(buildingNetworkBackboneDummy_2, 0)
		end
		
		-- Autoplant Building
		if pCity:IsHasBuilding(buildingAutoplant) then
			local iNumECommerceServers = math.min(10, player:GetBuildingClassCount(buildingClassECommerceServer))
			pCity:SetNumRealBuilding(buildingAutoPlantDummy, iNumECommerceServers)
		else
			pCity:SetNumRealBuilding(buildingAutoPlantDummy, 0)
		end
		
		-- Telepresence Hub Building
		if pCity:IsHasBuilding(buildingTelepresenceHub) then
			local iNumCyberclincs = math.min(10, player:GetBuildingClassCount(iBuildingCyberclincClass))
			pCity:SetNumRealBuilding(buildingTelepresenceDummy, iNumCyberclincs)
		else
			pCity:SetNumRealBuilding(buildingTelepresenceDummy, 0)
		end
		
		-- Orbital Habitat building
		if pCity:IsHasBuilding(buildingOrbitalHabitat) then
			local iNumScientists = pCity:GetNumSpecialistsInBuilding(buildingResearchModule)
			local iNumMerchants = pCity:GetNumSpecialistsInBuilding(buildingCommModule)
			local iNumEngineers = pCity:GetNumSpecialistsInBuilding(buildingEngineeringModule)
			local iNumSpecialists = iNumScientists + iNumMerchants + iNumEngineers

			pCity:SetNumRealBuilding(buildingOrbitalHabitatDummy, iNumSpecialists)
		else
			pCity:SetNumRealBuilding(buildingOrbitalHabitatDummy, 0)
		end
	end
end
GameEvents.PlayerDoTurn.Add(FutureTurnBonuses)

-- CoreHealing, NanohiveEffects, CrawlerEffects, HydraEffects, BioModEffects

function FutureTurnUnitEffects(iPlayer)
	local player = Players[iPlayer]
	if not (player:GetCurrentEra() > 5) then return end
	local bIsAlive = player:IsAlive()
	for pUnit in player:Units() do
		local iType = pUnit:GetUnitType()
		
		-- Crawler effects
		if iType == unitCrawler then
			local iCheckForMissileProduction = JFD_GetRandom(1, 100)
			if (iCheckForMissileProduction < iChanceMissileProduction) then
				local pPlot = pUnit:GetPlot()
				if pPlot then
					local iNumMissiles = 0
					for iVal = 0,(pPlot:GetNumUnits() - 1) do
						local loopUnit = pPlot:GetUnit(iVal)
						if loopUnit:GetUnitType() == unitHyperMissile then
							iNumMissiles = iNumMissiles + 1
						end
					end
					if iNumMissiles < 3 then
						player:InitUnit(unitHyperMissile, pPlot:GetX(), pPlot:GetY())
					end
				end
			end
		end		

		-- Hydra effects
		if iType == unitHydra then
			local pPlot = pUnit:GetPlot()
			local bEnemyPresent = false
			for pAdjacentPlot in PlotAreaSpiralIterator(pPlot, 2, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
				if pAdjacentPlot and not pAdjacentPlot:IsWater() then
					for iVal = 0, (pAdjacentPlot:GetNumUnits() - 1) do
						local loopUnit = pAdjacentPlot:GetUnit(iVal)
						if loopUnit:GetOwner() ~= iPlayer then
							local otherTeamID = Players[loopUnit:GetOwner()]:GetTeam()
							if pPlayerTeam:IsAtWar(otherTeamID) then
								bEnemyPresent = true
							end
						end
					end
				end
			end
			if bEnemyPresent and not pPlot:IsWater() then
				local tPlots = {}
				local pPlot = pUnit:GetPlot()
				if pPlot then
					for loopPlot in PlotAreaSweepIterator(pPlot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
						if loopPlot then
							if loopPlot:GetNumUnits() < 1 and not loopPlot:IsWater() and not loopPlot:IsMountain() and not loopPlot:IsCity() then
								table.insert(tPlots, loopPlot)
							end
						end
					end
					local bShouldContinue = true
					if #tPlots > 0 then
						local randomNumber = JFD_GetRandom(1, #tPlots)
						local tPlot = tPlots[randomNumber]
						player:InitUnit(unitSwarm, tPlot:GetX(), tPlot:GetY())
						table.remove(tPlots, randomNumber)
						if #tPlots > 0 then
							local randomNumber2 = JFD_GetRandom(1, #tPlots)
							local tPlot2 = tPlots[randomNumber2]
							player:InitUnit(unitSwarm, tPlot2:GetX(), tPlot2:GetY())
							bShouldContinue = false
						end
					end
					if bShouldContinue then
						for pAdjacentPlot in PlotAreaSweepIterator(pPlot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
							if pAdjacentPlot then
								for iVal = 0,(pAdjacentPlot:GetNumUnits() - 1) do
									local loopUnit = pAdjacentPlot:GetUnit(iVal)
									if loopUnit:GetOwner() ~= iPlayer then
										local otherTeamID = Players[loopUnit:GetOwner()]:GetTeam()
										if pPlayerTeam:IsAtWar(otherTeamID) then
											loopUnit:ChangeDamage(10)
										end
									end
								end
							end
						end
					end
				end
			end
		end
		
		if bIsAlive then
			-- Healing adjacent to core
			local pPlot = pUnit:GetPlot()
			local bCorePresent = false
			for pAdjacentPlot in PlotAreaSpiralIterator(pPlot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
				local iImprovement = pAdjacentPlot:GetImprovementType()
				local iOwner = pAdjacentPlot:GetOwner()
				if (iImprovement == improvementCore) and (iOwner == iPlayer) then
					bCorePresent = true
				end			
			end
			if bCorePresent and (pUnit:GetDamage() > 0) then
				pUnit:ChangeDamage(-10)
			end
			
			-- Nanohive effects
			if pUnit:IsHasPromotion(promotionNanohive) then
				local pPlot = pUnit:GetPlot()
				if pPlot then
					for loopPlot in PlotAreaSweepIterator(pPlot, 2, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
						if loopPlot then
							for iVal = 0,(loopPlot:GetNumUnits() - 1) do
								local loopUnit = loopPlot:GetUnit(iVal)
								if loopUnit:GetOwner() == iPlayer then
									if (loopUnit:GetDamage() > 0) then
										loopUnit:ChangeDamage(-10)
									end
								else 
									local otherPlayer = Players[loopUnit:GetOwner()]
									local otherTeamID = otherPlayer:GetTeam()
									if pPlayerTeam:IsAtWar(otherTeamID) then
										loopUnit:ChangeDamage(10)
									end
								end
							end
						end
					end	
				end
			end
			
			-- Bio Mod effects
			if pUnit:IsHasPromotion(promotionBoostMod_1) then
				pUnit:SetHasPromotion(promotionBoostMod_1, false)
			end
			if pUnit:IsHasPromotion(promotionBoostMod_2) then
				pUnit:SetHasPromotion(promotionBoostMod_2, false)
				pUnit:SetHasPromotion(promotionBoostMod_1, true)
			end
			if pUnit:IsHasPromotion(promotionBoostMod_3) then
				pUnit:SetHasPromotion(promotionBoostMod_3, false)
				pUnit:SetHasPromotion(promotionBoostMod_2, true)
			end
			if pUnit:IsHasPromotion(promotionBoostMod) then
				if (pUnit:GetDamage() > 50) then
					pUnit:SetHasPromotion(promotionBoostMod_1, false)
					pUnit:SetHasPromotion(promotionBoostMod_2, false)
					pUnit:SetHasPromotion(promotionBoostMod_3, true)
					pUnit:SetHasPromotion(promotionBoostMod, false)
					pUnit:SetHasPromotion(promotionBoostModEmpty, true)
				end
			end
			if pUnit:IsHasPromotion(promotionStimMod) then
				if (pUnit:GetDamage() > 50) then
					pUnit:ChangeDamage(-25)
					pUnit:SetHasPromotion(promotionStimMod, false)
					pUnit:SetHasPromotion(promotionStimModEmpty, true)
				end
			end
			if (pUnit:IsHasPromotion(promotionStimModEmpty) or pUnit:IsHasPromotion(promotionBoostModEmpty)) then
				local pPlot = pUnit:GetPlot()
				if pPlot:IsCity() then
					local pCity = pPlot:GetWorkingCity()
					if pCity:IsHasBuilding(iBioModTank) then
						if pUnit:IsHasPromotion(promotionStimModEmpty) then
							pUnit:SetHasPromotion(promotionStimModEmpty, false)
							pUnit:SetHasPromotion(promotionStimMod, true)
						end
						if pUnit:IsHasPromotion(promotionBoostModEmpty) then
							pUnit:SetHasPromotion(promotionBoostModEmpty, false)
							pUnit:SetHasPromotion(promotionBoostMod, true)
						end
					end
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(FutureTurnUnitEffects)

function SwarmEffects()
	local iPlayer = Game.GetActivePlayer()
	local player = Players[iPlayer]
	if not (player:GetCurrentEra() > 5) then return end
	local teamID = player:GetTeam()
	local pPlayerTeam = Teams[teamID]
	for pUnit in player:Units() do
		if pUnit:GetUnitType() == unitSwarm then
			local pPlot = pUnit:GetPlot()	
			for pAdjacentPlot in PlotAreaSweepIterator(pPlot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
				if pAdjacentPlot then
					for iVal = 0,(pAdjacentPlot:GetNumUnits() - 1) do
						local loopUnit = pAdjacentPlot:GetUnit(iVal)
						if loopUnit:GetOwner() ~= iPlayer then
							local otherTeamID = Players[loopUnit:GetOwner()]:GetTeam()
							if pPlayerTeam:IsAtWar(otherTeamID) then
								loopUnit:ChangeDamage(10)
							end
						end
					end
				end
				
			end
			pUnit:Kill()
		end
	end
end
Events.ActivePlayerTurnEnd.Add(SwarmEffects)

function BioModReload(iPlayer, iUnit, ePromotion)
	local player = Players[iPlayer]
	if not (player:GetCurrentEra() > 5) then return end
	local pUnit = player:GetUnitByID(iUnit)
	if pUnit:IsHasPromotion(promotionStimMod) then
		pUnit:SetHasPromotion(promotionStimModEmpty, false)
	end
	if pUnit:IsHasPromotion(promotionBoostMod) then
		pUnit:SetHasPromotion(promotionBoostModEmpty, false)
	end
end
GameEvents.UnitPromoted.Add(BioModReload)

function FWUnitDestroyed(iPlayer, iUnit, iUnitType, iX, iY, bDelay, iByPlayer)
	local player = Players[iPlayer]
	if not player:IsAlive() then return end
	if not (player:GetCurrentEra() > 5) then return end
	local teamID = player:GetTeam()
	local pPlayerTeam = Teams[teamID]
	local pUnit = player:GetUnitByID(iUnit)

	-- Must have been killed by another Player
	if iPlayer == iByPlayer then return end
	if iByPlayer == -1 then return end
	
	-- Must have the Mutation Promotion
	bMutant = pUnit:IsHasPromotion(promotionMutation)
	bToxin = pUnit:IsHasPromotion(promotionToxinMod)
	if not(bMutant or bToxin) then return end

	local pPlot = pUnit:GetPlot()	
	for pAdjacentPlot in PlotAreaSweepIterator(pPlot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
		if pAdjacentPlot then
			for iVal = 0,(pAdjacentPlot:GetNumUnits() - 1) do
				local loopUnit = pAdjacentPlot:GetUnit(iVal)
				if loopUnit:GetOwner() ~= iPlayer then
					local otherTeamID = Players[loopUnit:GetOwner()]:GetTeam()
					if pPlayerTeam:IsAtWar(otherTeamID) then
						if bToxin then
							loopUnit:ChangeDamage(10)
						end
						if bMutant then
							local randomNumber = JFD_GetRandom(1, 100)
							local loopDMG = loopUnit:GetDamage()
							if (loopDMG > 50) and (randomNumber < loopDMG) and not (pAdjacentPlot:IsCity()) then
								local loopType = loopUnit:GetUnitType()
								loopUnit:Kill()
								local nUnit = Players[63]:InitUnit(loopType, pAdjacentPlot:GetX(), pAdjacentPlot:GetY())
								nUnit:SetDamage(loopDMG)
							end
						end
					end
				end
			end
		end
		
	end	
end
GameEvents.UnitPrekill.Add(FWUnitDestroyed)

--==========================================================================================================================
-- WONDERS
--==========================================================================================================================
-- Utility Functions
----------------------------------------------------------------------------------------------------------------------------

function WonderPolicyUtility(playerID, buildingClass, policy, policyDummy)
	local player = Players[playerID]
	if not player:IsAlive() then return end
	
	if player:GetBuildingClassCount(buildingClass) > 0 and not player:HasPolicy(policy) then
		if not player:HasPolicy(policyDummy) then
			player:SetNumFreePolicies(1)
			player:SetNumFreePolicies(0)
		else
			player:SetHasPolicy(policyDummy, false)
		end	
		player:SetHasPolicy(policy, true)	
	end
	if player:GetBuildingClassCount(buildingClass) == 0 and player:HasPolicy(policy) then
		player:SetHasPolicy(policy, false)
		player:SetHasPolicy(policyDummy, true)	
	end
end

----------------------------------------------------------------------------------------------------------------------------
-- City Trained Events
----------------------------------------------------------------------------------------------------------------------------
function MnemosyneCityTrained(iPlayer, iCity, iUnitID)
	local player = Players[iPlayer]
	local pUnit = player:GetUnitByID(iUnitID)
	local pCity = player:GetCityByID(iCity)
	if pCity:IsHasBuilding(wonderMnesmosyne) then
		if pUnit:IsCombatUnit() then
			local iHighestUnitLevel = player:GetHighestUnitLevel()
			local iNewXP = math.min(60, iHighestUnitLevel * 10)
			pUnit:ChangeExperience(iNewXP)
		end
	end
end

----------------------------------------------------------------------------------------------------------------------------
-- City Captured Events 
----------------------------------------------------------------------------------------------------------------------------
function GeneVaultCityCaptured(iOldOwner, bIsCapital, iX, iY, iNewOwner, iPop, bConquest)
	local pCity = Map.GetPlot(iX, iY):GetPlotCity()
	if pCity:IsHasBuilding(wonderGeneVault) then
		WonderPolicyUtility(iOldOwner, wonderClassGeneVault, poGeneVault, poGeneVaultDummy)
		WonderPolicyUtility(iNewOwner, wonderClassGeneVault, poGeneVault, poGeneVaultDummy)
	end
end

function BionicTowerCityCaptured(iOldOwner, bIsCapital, iX, iY, iNewOwner, iPop, bConquest)
	local pCity = Map.GetPlot(iX, iY):GetPlotCity()
	if pCity:IsHasBuilding(wonderBionicTower) then
		WonderPolicyUtility(iOldOwner, wonderClassBionicTower, poBionicTower, poBionicTowerDummy)
		WonderPolicyUtility(iNewOwner, wonderClassBionicTower, poBionicTower, poBionicTowerDummy)
	end
end

function HeliosCityCaptured(iOldOwner, bIsCapital, iX, iY, iNewOwner, iPop, bConquest)
	local pCity = Map.GetPlot(iX, iY):GetPlotCity()
	if pCity:IsHasBuilding(wonderHelios) then
		WonderPolicyUtility(iOldOwner, wonderClassHelios, poHelios, poHeliosDummy)
		WonderPolicyUtility(iNewOwner, wonderClassHelios, poHelios, poHeliosDummy)
	end
end

function BoreholeCityCaptured(iOldOwner, bIsCapital, iX, iY, iNewOwner, iPop, bConquest)
	local pCity = Map.GetPlot(iX, iY):GetPlotCity()
	if pCity:IsHasBuilding(wonderBorehole) then
		WonderPolicyUtility(iOldOwner, wonderClassBorehole, poBorehole, poBoreholeDummy)
		-- don't do the new owner because this is a national wonder
	end
end

function NephilimCityCaptured(iOldOwner, bIsCapital, iX, iY, iNewOwner, iPop, bConquest)
	local pCity = Map.GetPlot(iX, iY):GetPlotCity()
	if pCity:IsHasBuilding(wonderNephilim) then
		local oldOwner = Players[iOldOwner]
		for city in oldOwner:Cities() do
			city:SetNumRealBuilding(wonderNephilimDummy, 0)
		end
		local newOwner = Players[iNewOwner]
		for city in newOwner:Cities() do
			city:SetNumRealBuilding(wonderNephilimDummy, 1)
		end
	end
end

function AngelnetCityCaptured(iOldOwner, bIsCapital, iX, iY, iNewOwner, iPop, bConquest)
	local pCity = Map.GetPlot(iX, iY):GetPlotCity()
	if pCity:IsHasBuilding(wonderAngelnet) then
		local oldOwner = Players[iOldOwner]
		for city in oldOwner:Cities() do
			city:SetNumRealBuilding(wonderAngelnetDummy, 0)
		end
		local newOwner = Players[iNewOwner]
		for city in newOwner:Cities() do
			if city:IsHasBuilding(buildingUtilityFog) then
				city:SetNumRealBuilding(wonderAngelnetDummy, 1)
			else
				city:SetNumRealBuilding(wonderAngelnetDummy, 0)
			end
		end
	end
end

function DataHavenCityCaptured(iOldOwner, bIsCapital, iX, iY, iNewOwner, iPop, bConquest)
	local pCity = Map.GetPlot(iX, iY):GetPlotCity()
	if pCity:IsHasBuilding(wonderDataHaven) then
		local oldOwner = Players[iOldOwner]
		for city in oldOwner:Cities() do
			city:SetNumRealBuilding(wonderDataHavenDummy, 0)
		end
		local newOwner = Players[iNewOwner]
		for city in newOwner:Cities() do
			if city:IsHasBuilding(wonderDataHaven) then
				local iNumServers = player:GetBuildingClassCount(buildingClassServerHub)
				city:SetNumRealBuilding(wonderDataHavenDummy, iNumServers)
			else
				city:SetNumRealBuilding(wonderDataHavenDummy, 0)
			end
		end
	end
end

function ShimizuCityCaptured(iOldOwner, bIsCapital, iX, iY, iNewOwner, iPop, bConquest)
	local pCity = Map.GetPlot(iX, iY):GetPlotCity()
	if pCity:IsHasBuilding(wonderShimizu) then
		local iBuildingMaintenance = pCity:GetTotalBaseBuildingMaintenance()
		pCity:SetNumRealBuilding(wonderShimizuDummy, iBuildingMaintenance)
	end
end

function SkynetCityCaptured(iOldOwner, bIsCapital, iX, iY, iNewOwner, iPop, bConquest)
	local pCity = Map.GetPlot(iX, iY):GetPlotCity()
	if pCity:IsHasBuilding(wonderSkynet) then
		local oldOwner = Players[iOldOwner]
		local newOwner = Players[iNewOwner]
		for pUnit in oldOwner:Units() do
			if pUnit:GetUnitType() == unitRobotInfantry then
				local iDMG = pUnit:GetDamage()
				local iX = pUnit:GetX()
				local iY = pUnit:GetY()
				pUnit:Kill()
				local nUnit = newOwner:InitUnit(unitRobotInfantry, iX, iY)
				nUnit:SetDamage(iDMG)
			end
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- Player Do Turn Events
----------------------------------------------------------------------------------------------------------------------------
function JurassicParkDoTurn(iPlayer)
	local player = Players[iPlayer]
	if (player:GetBuildingClassCount(wonderClassJurassicPark) > 0) then
		local iCheckForDinos = JFD_GetRandom(1, 100)
		if (iCheckForDinos < iChanceDinos) then
			local tPlots = {}
			for pCity in player:Cities() do
				if pCity:IsHasBuilding(buildingMenagerie) then
					local pCentralPlot = pCity:Plot()
					for pPlot in PlotAreaSpiralIterator(pCentralPlot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
						local iTerrain = pPlot:GetTerrainType()
						local iOwner = pPlot:GetOwner()
						if (((iTerrain == terrainPlains) or (iTerrain == terrainGrasslands)) and (iOwner == iPlayer) and (pPlot:GetNumUnits() == 0) and not (pPlot:IsMountain())) then
							table.insert(tPlots, pPlot)
						end
					end
				end
			end
			if #tPlots > 0 then
				local randomNumber = JFD_GetRandom(1, #tPlots)
				local tPlot = tPlots[randomNumber]
				local iDinoNumber = JFD_GetRandom(1, 6)
				
				local iDinoType = unitTRex
				if (iDinoNumber > 3) then 
					iDinoType = unitRaptor
				else
					if (iDinoNumber > 1) then
						iDinoType = unitTriceratops
					end
				end
				local teamID = player:GetTeam()
				local pTeam = Teams[teamID]
				if not (pTeam:IsHasTech(techGengineering)) then
					local nUnit = Players[63]:InitUnit(iDinoType, tPlot:GetX(), tPlot:GetY())
				end
			end
		end
	end
end

function PholusMutagenDoTurn(iPlayer)
	local player = Players[iPlayer]
	if player:GetBuildingClassCount(wonderClassPholusMutagen) > 0 then
		for pCity in player:Cities() do
			local iNumDomes = 0
			for i = 0, pCity:GetNumCityPlots() - 1, 1 do
				local pPlot = pCity:GetCityIndexPlot( i )
				if pPlot then
					if pPlot:GetOwner() == pCity:GetOwner() then
						local iImprovement = pPlot:GetImprovementType()
						local iTerrain = pPlot:GetTerrainType()
						if ((iImprovement == improvementFarm) or (iImprovement == improvementPlantation) or (iImprovement == improvementPreserve) or (iImprovement == -1)) and (((iTerrain == terrainPlains) or (iTerrain == terrainGrasslands)) and not (pPlot:IsMountain()) and not (pPlot:IsCity())) then
							local iCheckForFungus = JFD_GetRandom(1, 100)
							local iAdjacentFungusBonus = 0

							for loopPlot in PlotAreaSweepIterator(pPlot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
								if loopPlot then
									if loopPlot:GetImprovementType() == improvementFungus then
										iAdjacentFungusBonus = iAdjacentFungusBonus + iAdjacentFungusModifier
									end
								end
								
							end

							if iAdjacentFungusBonus > 3 then iAdjacentFungusBonus = 3 end
							iChanceForFungus = iChanceForFungus + iAdjacentFungusBonus

							if (iCheckForFungus < iChanceForFungus) then
								pPlot:SetImprovementType(improvementFungus)
							end
						end
					end
				end
			end
		end
	end
end

function HeliosDoTurn(iPlayer)
	local player = Players[iPlayer]
	if player:GetBuildingClassCount(wonderClassHelios) > 0 then
		local teamID = player:GetTeam()
		local pPlayerTeam = Teams[teamID]
		for pCity in player:Cities() do
			if pCity:GetNumRealBuilding(buildingSolarPlant) > 0 then
				local plot = Map.GetPlot(pCity:GetX(), pCity:GetY())
				for loopPlot in PlotAreaSweepIterator(plot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
					if loopPlot then
						for iVal = 0, (loopPlot:GetNumUnits() - 1) do
							local loopUnit = loopPlot:GetUnit(iVal)
							if loopUnit:GetOwner() ~= iPlayer then
								local otherTeamID = Players[loopUnit:GetOwner()]:GetTeam()
								if pPlayerTeam:IsAtWar(otherTeamID) then
									loopUnit:ChangeDamage(20)
								end
							end
						end
					end
					
				end
			end
		end
	end
end

function DataHavenDoTurn(playerID)
	local player = Players[playerID]
	if not player:IsAlive() then return end
	
	for city in player:Cities() do
		if city:IsHasBuilding(wonderDataHaven) then
			local iNumServers = player:GetBuildingClassCount(buildingClassServerHub)
			city:SetNumRealBuilding(wonderDataHavenDummy, iNumServers)
		else
			city:SetNumRealBuilding(wonderDataHavenDummy, 0)
		end
	end
end

function BuenosAiresForumDoTurn(playerID)
	local player = Players[playerID]
	if not player:IsAlive() then return end
	if player:GetBuildingClassCount(wonderClassBuenosAiresForum) == 0 then return end
	
	for city in player:Cities() do
		if city:IsHasBuilding(wonderBuenosAiresForum) then
			player:ChangeGoldenAgeProgressMeter(city:GetPopulation())
		end
	end
end

function ShimizuDoTurn(playerID)
	local player = Players[playerID]
	if not player:IsAlive() then return end
	if player:GetBuildingClassCount(wonderClassShimizu) == 0 then return end
	
	for city in player:Cities() do
		if city:IsHasBuilding(wonderShimizu) then
			local iBuildingMaintenance = city:GetTotalBaseBuildingMaintenance()
			city:SetNumRealBuilding(wonderShimizuDummy, iBuildingMaintenance)
		end
	end
end

----------------------------------------------------------------------------------------------------------------------------
-- Construction Completion Events
----------------------------------------------------------------------------------------------------------------------------
function GeneVaultCompleted(ownerId, cityId, buildingType, bGold, bFaithOrCulture)
	if buildingType == wonderGeneVault then
		WonderPolicyUtility(ownerId, wonderClassGeneVault, poGeneVault, poGeneVaultDummy)
		GameEvents.CityCaptureComplete.Add(GeneVaultCityCaptured)
	end
end

function BionicTowerCompleted(ownerId, cityId, buildingType, bGold, bFaithOrCulture)
	if buildingType == wonderBionicTower then
		WonderPolicyUtility(ownerId, wonderClassBionicTower, poBionicTower, poBionicTowerDummy)
		GameEvents.CityCaptureComplete.Add(BionicTowerCityCaptured)
	end
end

function HeliosCompleted(ownerId, cityId, buildingType, bGold, bFaithOrCulture)
	if buildingType == wonderHelios then
		WonderPolicyUtility(ownerId, wonderClassHelios, poHelios, poHeliosDummy)
		GameEvents.CityCaptureComplete.Add(HeliosCityCaptured)
		GameEvents.PlayerDoTurn.Add(HeliosDoTurn)
	end
end

function BoreholeCompleted(ownerId, cityId, buildingType, bGold, bFaithOrCulture)
	if buildingType == wonderBorehole then
		WonderPolicyUtility(ownerId, wonderClassBorehole, poBorehole, poBoreholeDummy)
		GameEvents.CityCaptureComplete.Add(BoreholeCityCaptured)
	end
end
GameEvents.CityConstructed.Add(BoreholeCompleted) -- national wonder, so need for special world checking

function MnemosyneCompleted(ownerId, cityId, buildingType, bGold, bFaithOrCulture)
	if buildingType == wonderMnesmosyne then
		GameEvents.CityTrained.Add(MnemosyneCityTrained)
	end
end

function JurassicParkCompleted(ownerId, cityId, buildingType, bGold, bFaithOrCulture)
	if buildingType == wonderJurassicPark then
		GameEvents.PlayerDoTurn.Add(JurassicParkDoTurn)
	end
end

function PholusMutagenCompleted(ownerId, cityId, buildingType, bGold, bFaithOrCulture)
	if buildingType == wonderPholusMutagen then
		GameEvents.PlayerDoTurn.Add(PholusMutagenDoTurn)
	end
end

function NephilimCompleted(ownerId, cityId, buildingType, bGold, bFaithOrCulture)
	if buildingType == wonderNephilim then
		local owner = Players[ownerId]
		for city in owner:Cities() do
			city:SetNumRealBuilding(wonderNephilimDummy, 1)
		end
		GameEvents.CityCaptureComplete.Add(NephilimCityCaptured)
	end
end

function AngelnetCompleted(ownerId, cityId, buildingType, bGold, bFaithOrCulture)
	if buildingType == wonderAngelnet then
		local owner = Players[ownerId]
		for city in owner:Cities() do
			if city:IsHasBuilding(buildingUtilityFog) then
				city:SetNumRealBuilding(wonderAngelnetDummy, 1)
			end
		end
		GameEvents.CityCaptureComplete.Add(AngelnetCityCaptured)
	elseif buildingType == buildingUtilityFog then
		local owner = Players[ownerId]
		if owner:GetBuildingClassCount(wonderClassAngelnet) == 0 then return end
		local city = player:GetCityByID(cityId)
		city:SetNumRealBuilding(wonderAngelnetDummy, 1)
	end
end

function DataHavenCompleted(ownerId, cityId, buildingType, bGold, bFaithOrCulture)
	if buildingType == wonderDataHaven then
		local owner = Players[ownerId]
		for city in owner:Cities() do
			if city:IsHasBuilding(wonderDataHaven) then
				local iNumServers = player:GetBuildingClassCount(buildingClassServerHub)
				city:SetNumRealBuilding(wonderDataHavenDummy, iNumServers)
			else
				city:SetNumRealBuilding(wonderDataHavenDummy, 0)
			end
		end
		GameEvents.CityCaptureComplete.Add(DataHavenCityCaptured)
		GameEvents.PlayerDoTurn.Add(DataHavenDoTurn)
	end
end

function BuenosAiresForumCompleted(ownerId, cityId, buildingType, bGold, bFaithOrCulture)
	if buildingType == wonderBuenosAiresForum then
		local player = Players[ownerId]
		local city = player:GetCityByID(cityId)
		player:ChangeGoldenAgeProgressMeter(city:GetPopulation())
		GameEvents.PlayerDoTurn.Add(BuenosAiresForumDoTurn)
	end
end

function ShimizuCompleted(ownerId, cityId, buildingType, bGold, bFaithOrCulture)
	if buildingType == wonderShimizu then
		local owner = Players[ownerId]
		for city in owner:Cities() do
			if city:IsHasBuilding(wonderShimizu) then
				local iNumServers = player:GetBuildingClassCount(buildingClassServerHub)
				city:SetNumRealBuilding(wonderDataHavenDummy, iNumServers)
			else
				city:SetNumRealBuilding(wonderDataHavenDummy, 0)
			end
		end
		GameEvents.CityCaptureComplete.Add(ShimizuCityCaptured)
		GameEvents.PlayerDoTurn.Add(ShimizuDoTurn)
	end
end

function SkynetCompleted(ownerId, cityId, buildingType, bGold, bFaithOrCulture)
	if buildingType == wonderSkynet then
		GameEvents.CityCaptureComplete.Add(SkynetCityCaptured)
	end
end

----------------------------------------------------------------------------------------------------------------------------
-- Smart Event Hooks
----------------------------------------------------------------------------------------------------------------------------
for iPlayer = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
	local player = Players[iPlayer]
	if player:IsAlive() then
		if player:GetBuildingClassCount(wonderClassGeneVault) > 0 then
			GameEvents.CityCaptureComplete.Add(GeneVaultCityCaptured)
			bGeneVaultCompleted = true
		end
		if player:GetBuildingClassCount(wonderClassBionicTower) > 0 then
			GameEvents.CityCaptureComplete.Add(BionicTowerCityCaptured)
			bBionicTowerCompleted = true
		end
		if player:GetBuildingClassCount(wonderClassHelios) > 0 then
			GameEvents.CityCaptureComplete.Add(HeliosCityCaptured)
			GameEvents.PlayerDoTurn.Add(HeliosDoTurn)
			bHeliosCompleted = true
		end
		if player:GetBuildingClassCount(wonderClassMnemosyne) > 0 then
			GameEvents.CityTrained.Add(MnemosyneCityTrained)
			bMnemosyneCompleted = true
		end
		if player:GetBuildingClassCount(wonderClassJurassicPark) > 0 then
			GameEvents.PlayerDoTurn.Add(JurassicParkDoTurn)
			bJurassicParkCompleted = true
		end
		if player:GetBuildingClassCount(wonderClassPholusMutagen) > 0 then
			GameEvents.PlayerDoTurn.Add(PholusMutagenDoTurn)
			bPholusMutagenCompleted = true
		end
		if player:GetBuildingClassCount(wonderClassNephilim) > 0 then
			GameEvents.CityCaptureComplete.Add(NephilimCityCaptured)
			bNephilimCompleted = true
		end
		if player:GetBuildingClassCount(wonderClassAngelnet) > 0 then
			GameEvents.CityCaptureComplete.Add(AngelnetCityCaptured)
			bAngelnetCompleted = true
		end
		if player:GetBuildingClassCount(wonderClassDataHaven) > 0 then
			GameEvents.CityCaptureComplete.Add(DataHavenCityCaptured)
			GameEvents.PlayerDoTurn.Add(DataHavenDoTurn)
			bDataHavenCompleted = true
		end
		if player:GetBuildingClassCount(wonderClassBuenosAiresForum) > 0 then
			GameEvents.PlayerDoTurn.Add(BuenosAiresForumDoTurn)
			bBuenosAiresForumCompleted = true
		end
		if player:GetBuildingClassCount(wonderClassShimizu) > 0 then
			GameEvents.PlayerDoTurn.Add(ShimizuDoTurn)
			bShimizuCompleted = true
		end
		if player:GetBuildingClassCount(wonderClassSkynet) > 0 then
			GameEvents.CityCaptureComplete.Add(SkynetCityCapture)
			bSkynetCompleted = true
		end
	end
end

if not bGeneVaultCompleted then
	GameEvents.CityConstructed.Add(GeneVaultCompleted)
end
if not bBionicTowerCompleted then
	GameEvents.CityConstructed.Add(BionicTowerCompleted)
end
if not bHeliosCompleted then
	GameEvents.CityConstructed.Add(HeliosCompleted)
end
if not bMnemosyneCompleted then
	GameEvents.CityConstructed.Add(MnemosyneCompleted)
end
if not bJurassicParkCompleted then
	GameEvents.CityConstructed.Add(JurassicParkCompleted)
end
if not bPholusMutagenCompleted then
	GameEvents.CityConstructed.Add(PholusMutagenCompleted)
end
if not bNephilimCompleted then
	GameEvents.CityConstructed.Add(NephilimCompleted)
end
if not bAngelnetCompleted then
	GameEvents.CityConstructed.Add(AngelnetCompleted)
end
if not bDataHavenCompleted then
	GameEvents.CityConstructed.Add(DataHavenCompleted)
end
if not bBuenosAiresForumCompleted then
	GameEvents.CityConstructed.Add(BuenosAiresForumCompleted)
end
if not bShimizuCompleted then
	GameEvents.CityConstructed.Add(ShimizuCompleted)
end
if not bSkynetCompleted then
	GameEvents.CityConstructed.Add(SkynetCompleted)
end

--==========================================================================================================================
-- MISC
--==========================================================================================================================
-- Requirements and Restrictions
----------------------------------------------------------------------------------------------------------------------------

function FWUnitUpgradeRestrictions(iPlayer, iUnit)
	local player = Players[iPlayer]
	if (not player:IsAlive()) then return end
	local pUnit = player:GetUnitByID(iUnit)
	if pUnit:GetUnitType() == unitAutomaton then
		if player:GetBuildingClassCount(wonderClassSkynet) < 1 then
			return false
		end
	end
	return true
end
GameEvents.CanHaveAnyUpgrade.Add(FWUnitUpgradeRestrictions)

function FWUnitRestrictions(iPlayer, iCity, iUnit)
	local player = Players[iPlayer]
	if (not player:IsAlive()) then return end
	if iUnit == unitRobotInfantry then
		if player:GetBuildingClassCount(wonderClassSkynet) < 1 then
			return false
		end
	elseif (iUnit == unitTRex) or (iUnit == unitTriceratops) or (iUnit == unitRaptor) then
		if player:GetBuildingClassCount(wonderClassJurassicPark) > 0 then
			local pTeam = Teams[player:GetTeam()]
			if pTeam:IsHasTech(techGengineering) then return true end
		end
		return false
	end

	return true
end
GameEvents.CityCanTrain.Add(FWUnitRestrictions)

function SpaceStationRequirement(playerID, buildingType)
  local player = Players[playerID]
  if (not player:IsAlive()) then return false end

  if buildingType ~= buildingSpaceStation then return true end
  if player:GetBuildingClassCount(wonderClassLaunchFacility) > 0 then return true end
  
  return false
end
GameEvents.PlayerCanConstruct.Add(SpaceStationRequirement)

function AffinityRestrictedBuildings(iPlayer, iCity, iBuilding)
  local player = Players[iPlayer]
  local pCity = player:GetCityByID(iCity)

	if (iBuilding == buildingGeneLab) or (iBuilding == buildingCloneLab) or (iBuilding == buildingTGNursery) then
		if pCity:IsHasBuilding(buildingVerticalFarm) or pCity:IsHasBuilding(buildingMycoproteinVats) or pCity:IsHasBuilding(buildingOrbitalHabitat) then
			return false
		end
	end

	if (iBuilding == buildingBiofactory) or (iBuilding == buildingEctogenesisPod) or (iBuilding == buildingGeneJackFacility) then
		if pCity:IsHasBuilding(buildingAutoplant) or pCity:IsHasBuilding(buildingDroneHive) or pCity:IsHasBuilding(buildingUtilityFog) then
			return false
		end
	end

    if (iBuilding == buildingAutoplant) or (iBuilding == buildingDroneHive) or (iBuilding == buildingUtilityFog) then
		if pCity:IsHasBuilding(buildingBiofactory) or pCity:IsHasBuilding(buildingEctogenesisPod) or pCity:IsHasBuilding(buildingGeneJackFacility) then
			return false
		end
	end

    if (iBuilding == buildingNetworkBackbone) or (iBuilding == buildingTelepresenceHub) or (iBuilding == buildingSimulationServer) then
		if pCity:IsHasBuilding(buildingFeedsiteHub) or pCity:IsHasBuilding(buildingDistributionHub) or pCity:IsHasBuilding(buildingMetroplexHub) then
			return false
		end
	end

    if (iBuilding == buildingFeedsiteHub) or (iBuilding == buildingDistributionHub) or (iBuilding == buildingMetroplexHub) then
		if pCity:IsHasBuilding(buildingNetworkBackbone) or pCity:IsHasBuilding(buildingTelepresenceHub) or pCity:IsHasBuilding(buildingSimulationServer) then
			return false
		end
	end

    if (iBuilding == buildingVerticalFarm) or (iBuilding == buildingMycoproteinVats) or (iBuilding == buildingOrbitalHabitat) then
		if pCity:IsHasBuilding(buildingGeneLab) or pCity:IsHasBuilding(buildingCloneLab) or pCity:IsHasBuilding(buildingTGNursery) then
			return false
		end
	end

  return true
end
GameEvents.CityCanConstruct.Add(AffinityRestrictedBuildings)

----------------------------------------------------------------------------------------------------------------------------
-- Removing Extra Promotions for Nexus, Automaton and Robot Infantry
----------------------------------------------------------------------------------------------------------------------------

local uNexus = GameInfoTypes.UNIT_FW_NEXUS

function RemoveUnwantedPromotions(iPlayer, iUnit)
    local player = Players[iPlayer]
	if player:GetUnitByID(iUnit) then
		local pUnit = player:GetUnitByID(iUnit)
		local iUnitType = pUnit:GetUnitType()
		if (iUnitType == uNexus) then
			pUnit:SetHasPromotion(promotionEmbarkation_1, false)
			pUnit:SetHasPromotion(promotionEmbarkation_2, false)
			pUnit:SetHasPromotion(promotionEmbarkation_3, false)
		elseif ((iUnitType == unitAutomaton) or (iUnitType == unitRobotInfantry)) then
			pUnit:SetHasPromotion(promotionGengineered, false)
			pUnit:SetHasPromotion(promotionBiomods, false)
		end
    end
end
Events.SerialEventUnitCreated.Add(RemoveUnwantedPromotions)

function RemoveUnwantedPromotions2(iPlayer, iUnit, iX, iY)
	if Map.GetPlot(iX,iY) then
		local player = Players[iPlayer]
		local pUnit = player:GetUnitByID(iUnit)
		local iUnitType = pUnit:GetUnitType()
		if iUnitType == uNexus then
			pUnit:SetHasPromotion(promotionEmbarkation_1, false)
			pUnit:SetHasPromotion(promotionEmbarkation_2, false)
			pUnit:SetHasPromotion(promotionEmbarkation_3, false)
		elseif ((iUnitType == unitAutomaton) or (iUnitType == unitRobotInfantry)) then
			pUnit:SetHasPromotion(promotionGengineered, false)
			pUnit:SetHasPromotion(promotionBiomods, false)
		end
	end
end
GameEvents.UnitSetXY.Add(RemoveUnwantedPromotions2)

print("Future Worlds code loaded successfully")
