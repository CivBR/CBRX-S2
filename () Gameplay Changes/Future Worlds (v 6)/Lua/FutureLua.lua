-- FutureLua
-- Author: user
-- DateCreated: 4/15/2015 9:16:51 AM
--------------------------------------------------------------

print("Future Worlds code loaded")

include("MischaIteratingPlotsFunctions")
include("CityNearbyMapDatasV4")

local iImprovementAcademy = GameInfoTypes.IMPROVEMENT_ACADEMY
local iImprovementHERC = GameInfoTypes.IMPROVEMENT_FW_HERC
local iImprovementPreserve = GameInfoTypes.IMPROVEMENT_FW_PRESERVE
local iImprovementBiowell = GameInfoTypes.IMPROVEMENT_FW_BIOWELL
local iImprovementGenerator = GameInfoTypes.IMPROVEMENT_FW_GENERATOR
local iImprovementCore = GameInfoTypes.IMPROVEMENT_FW_CORE
local iImprovementCommArray = GameInfoTypes.IMPROVEMENT_FW_COMM_ARRAY
local iImprovementIndustrialComplex = GameInfoTypes.IMPROVEMENT_FW_INDUSTRIAL_COMPLEX
local iImprovementDome = GameInfoTypes.IMPROVEMENT_FW_HYDROPONICS_DOME
local iImprovementArcology = GameInfoTypes.IMPROVEMENT_FW_ARCOLOGY
local iImprovementFungus = GameInfoTypes.IMPROVEMENT_FW_FUNGAL_GROWTH
local iImprovementFarm = GameInfoTypes.IMPROVEMENT_FARM
local iImprovementPasture = GameInfoTypes.IMPROVEMENT_PASTURE

local iImprovementFarm = GameInfoTypes.IMPROVEMENT_FARM
local iImprovementPlantation = GameInfoTypes.IMPROVEMENT_PLANTATION

local iOcean = GameInfoTypes.TERRAIN_OCEAN
local iCopper = GameInfoTypes.RESOURCE_COPPER
local iSilver = GameInfoTypes.RESOURCE_SILVER
local iGold = GameInfoTypes.RESOURCE_GOLD

local iMarsh = GameInfoTypes.FEATURE_MARSH
local iJungle = GameInfoTypes.FEATURE_JUNGLE
local iFloodPlains =GameInfoTypes.FEATURE_FLOOD_PLAINS
local iPlains = GameInfoTypes.TERRAIN_PLAINS
local iGrasslands = GameInfoTypes.TERRAIN_GRASS

local iArtist = GameInfo.Specialists.SPECIALIST_ARTIST.ID
local iScientist = GameInfo.Specialists.SPECIALIST_SCIENTIST.ID
local iMerchant = GameInfo.Specialists.SPECIALIST_MERCHANT.ID
local iEngineer = GameInfo.Specialists.SPECIALIST_ENGINEER.ID

local iBuildingGeneLab = GameInfoTypes.BUILDING_FW_GENE_LAB
local iBuildingCloneLab = GameInfoTypes.BUILDING_FW_CLONE_LAB
local iBuildingTGNursery = GameInfoTypes.BUILDING_FW_TG_NURSERY

local iBuildingBiofactory = GameInfoTypes.BUILDING_FW_BIOFACTORY
local iBuildingEctogenesisPod = GameInfoTypes.BUILDING_FW_ECTOGENESIS_POD
local iBuildingGeneJackFacility = GameInfoTypes.BUILDING_FW_GENEJACK_FACILITY

local iBuildingAutoplant = GameInfoTypes.BUILDING_FW_AUTOPLANT
local iBuildingDroneHive = GameInfoTypes.BUILDING_FW_DRONE_HIVE
local iBuildingUtilityFog = GameInfoTypes.BUILDING_FW_UTILITY_FOG

local iBuildingNetworkBackbone = GameInfoTypes.BUILDING_FW_NETWORK_BACKBONE
local iBuildingTelepresenceHub = GameInfoTypes.BUILDING_FW_TELEPRESENCE_HUB
local iBuildingSimulationServer = GameInfoTypes.BUILDING_FW_SIMULATION_SERVER

local iBuildingFeedsiteHub = GameInfoTypes.BUILDING_FW_FEEDSITE_HUB
local iBuildingDistributionHub = GameInfoTypes.BUILDING_FW_DISTRIBUTION_HUB
local iBuildingMetroplexHub = GameInfoTypes.BUILDING_FW_METROPLEX_HUB
local iBuildingColosseum = GameInfoTypes.BUILDING_COLOSSEUM
local iBuildingTheatre = GameInfoTypes.BUILDING_THEATRE
local iBuildingStadium = GameInfoTypes.BUILDING_STADIUM

local iBuildingVerticalFarm = GameInfoTypes.BUILDING_FW_VERTICAL_FARM
local iBuildingMycoproteinVats = GameInfoTypes.BUILDING_FW_MYCOPROTEIN_VATS
local iBuildingOrbitalHabitat = GameInfoTypes.BUILDING_FW_ORBITAL_HABITAT

local iBuildingResearchModule = GameInfoTypes.BUILDING_FW_RESEARCH_MODULE_1
local iBuildingCommModule = GameInfoTypes.BUILDING_FW_COMM_MODULE_1
local iBuildingEngineeringModule = GameInfoTypes.BUILDING_FW_ENGINEERING_MODULE_1

local iBuildingSolarPlant = GameInfoTypes.BUILDING_SOLAR_PLANT
local iBuildingSanctuary = GameInfoTypes.BUILDING_FW_SANCTUARY
local iBuildingUnderseaMining = GameInfoTypes.BUILDING_FW_UNDERSEA_MINING
local iBuildingBrainUploading = GameInfoTypes.BUILDING_FW_BRAIN_UPLOADING
local iBuildingBrainUploadingDummy = GameInfoTypes.BUILDING_FW_BRAIN_UPLOADING_DUMMY_1
local iBuildingBioModTank = GameInfoTypes.BUILDING_FW_BIOMOD_TANK
local iBuildingZoo = GameInfoTypes.BUILDING_THEATRE
local iBuildingMenagerie = GameInfoTypes.BUILDING_EE_MENAGERIE

local iBuildingServerHubClass = GameInfo.BuildingClasses.BUILDINGCLASS_FW_SERVER_HUB.ID
local iBuildingResearchServerClass = GameInfo.BuildingClasses.BUILDINGCLASS_FW_RESEARCH_SERVER.ID
local iBuildingEntertainmentServerClass = GameInfo.BuildingClasses.BUILDINGCLASS_FW_ENTERTAINMENT_SERVER.ID
local iBuildingECommerceServerClass = GameInfo.BuildingClasses.BUILDINGCLASS_FW_COMMERCE_SERVER.ID
local iBuildingCyberclinicClass = GameInfo.BuildingClasses.BUILDINGCLASS_FW_CYBERCLINIC.ID

local iBuildingAccelerator = GameInfoTypes.BUILDING_FW_ACCELERATOR
local iBuildingAcceleratorClass = GameInfo.BuildingClasses.BUILDINGCLASS_FW_ACCELERATOR.ID
local iBuildingSkynetClass = GameInfo.BuildingClasses.BUILDINGCLASS_FW_SKYNET.ID
local iBuildingPholusMutagen = GameInfoTypes.BUILDING_FW_PHOLUS_MUTAGEN
local iBuildingPholusMutagenClass = GameInfo.BuildingClasses.BUILDINGCLASS_FW_PHOLUS_MUTAGEN.ID
local iBuildingGeneVault = GameInfoTypes.BUILDING_FW_GENE_VAULT
local iBuildingGeneVaultClass = GameInfo.BuildingClasses.BUILDINGCLASS_FW_GENE_VAULT.ID
local iBuildingLaunchFacilityClass = GameInfo.BuildingClasses.BUILDINGCLASS_FW_LAUNCH_FACILITY.ID
local iBuildingNephilimGeneTemplateClass = GameInfo.BuildingClasses.BUILDINGCLASS_FW_NEPHILIM_GENE_TEMPLATE.ID
local iBuildingNephilimGeneTemplateDummy = GameInfoTypes.BUILDING_FW_NEPHILIMGENETEMPLATE_DUMMY
local iBuildingAngelnetClass = GameInfo.BuildingClasses.BUILDINGCLASS_FW_ANGELNET.ID
local iBuildingsShimizuMCP = GameInfoTypes.BUILDING_FW_SHIMIZUMCP
local iBuildingBionicTower = GameInfoTypes.BUILDING_FW_BIONICTOWER
local iBuildingBionicTowerClass = GameInfo.BuildingClasses.BUILDINGCLASS_FW_BIONICTOWER.ID
local iBuildingHeliosClass = GameInfo.BuildingClasses.BUILDINGCLASS_FW_HELIOS.ID
local iBuildingBoreholeClass = GameInfo.BuildingClasses.BUILDINGCLASS_FW_BOREHOLE.ID
local iBuildingMnemosyne = GameInfoTypes.BUILDING_FW_MNEMOSYNE
local iBuildingBuenosAiresForum = GameInfoTypes.BUILDING_FW_BUENOSAIRESFORUM
local iBuildingJurassicParkClass = GameInfo.BuildingClasses.BUILDINGCLASS_FW_JURASSIC_PARK.ID
local iBuildingPholusMutagenClass = GameInfo.BuildingClasses.BUILDINGCLASS_FW_PHOLUS_MUTAGEN.ID
local iBuildingCentralCommandClass = GameInfo.BuildingClasses.BUILDINGCLASS_FW_CENTRAL_COMMAND.ID

local iPrereq1 = GameInfo.Technologies["TECH_NEURAL_INTERFACE"].ID
local iPrereq2 = GameInfo.Technologies["TECH_GENGINEERING"].ID

local iGengineeredPromotion = GameInfoTypes.PROMOTION_FW_GENGINEERED
local iBiomodsPromotion = GameInfoTypes.PROMOTION_FW_BIOMODS
local iNodePromotion = GameInfoTypes.PROMOTION_FW_NETWORKED
local iNanohivePromotion = GameInfoTypes.PROMOTION_FW_NANOHIVE_PROMOTION
local iMutationPromotion = GameInfoTypes.PROMOTION_FW_MUTATION
local iToxinModPromotion = GameInfoTypes.PROMOTION_FW_TOXIN_MOD
local iStimModPromotion = GameInfoTypes.PROMOTION_FW_STIM_MOD
local iStimModEmptyPromotion = GameInfoTypes.PROMOTION_FW_STIM_MOD_EMPTY
local iBoostModPromotion = GameInfoTypes.PROMOTION_FW_BOOST_MOD
local iBoostModEmptyPromotion = GameInfoTypes.PROMOTION_FW_BOOST_MOD_EMPTY
local iBoostModEffect3Promotion = GameInfoTypes.PROMOTION_FW_BOOST_MOD_EFFECT_3
local iBoostModEffect2Promotion = GameInfoTypes.PROMOTION_FW_BOOST_MOD_EFFECT_2
local iBoostModEffect1Promotion = GameInfoTypes.PROMOTION_FW_BOOST_MOD_EFFECT_1
local iEmbarkationPromotion1 = GameInfoTypes.PROMOTION_EMBARKATION
local iEmbarkationPromotion2 = GameInfoTypes.PROMOTION_DEFENSIVE_EMBARKATION
local iEmbarkationPromotion3 = GameInfoTypes.PROMOTION_ALLWATER_EMBARKATION

local iHypermissile = GameInfoTypes.UNIT_FW_HYPERMISSILE
local iTRex = GameInfoTypes.UNIT_FW_TREX
local iTriceratops = GameInfoTypes.UNIT_FW_TRICERATOPS
local iRaptor = GameInfoTypes.UNIT_FW_RAPTOR
local iSwarm = GameInfoTypes.UNIT_FW_SWARM
local iRobotInfantry = GameInfoTypes.UNIT_FW_ROBOT_INFANTRY
local iAutomaton = GameInfoTypes.UNIT_FW_AUTOMATON
local tSkynetUnits = { [GameInfoTypes.UNIT_FW_ROBOT_INFANTRY] = UNITCLASS_FW_ROBOT_INFANTRY }

local tBioPromotions = { [GameInfoTypes.PROMOTION_FW_GENGINEERED] = GameInfoTypes.PROMOTION_FW_GENGINEERED, [GameInfoTypes.PROMOTION_FW_BIOMODS] = GameInfoTypes.PROMOTION_FW_BIOMODS }
local tRoboticUnits = { [GameInfoTypes.UNIT_FW_ROBOT_INFANTRY] = GameInfoTypes.UNIT_FW_ROBOT_INFANTRY, [GameInfoTypes.UNIT_FW_AUTOMATON] = GameInfoTypes.UNIT_FW_AUTOMATON}

local iChanceDinos = 7
local iChanceMissileProduction = 33
local iChanceForFungus = 1
local iAdjacentFungusModifier = 1

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
        if iBuilding == iBuildingAccelerator then
			local pPlayer = Players[iPlayer]
			for pCity in pPlayer:Cities() do
				local i;
				for i = 0, pCity:GetNumCityPlots() - 1, 1 do
					local pPlot = pCity:GetCityIndexPlot( i );
					if (pPlot ~= nil) then
						if ( pPlot:GetOwner() == pCity:GetOwner() ) then
							local ImpID = pPlot:GetImprovementType()
							if (ImpID == iImprovementAcademy) then
								pPlot:SetImprovementType(iImprovementHERC)
							end
						end
					end
				end
			end
        end
		if (iBuilding == iBuildingBrainUploading) then
			local pPlayer = Players[iPlayer];
			local pCity = pPlayer:GetCityByID(iCity)
			if pCity:GetNumRealBuilding(iBuildingBrainUploadingDummy) == 0 then
				local iCityPop = pCity:GetPopulation()
				local iUploadedCitizens = math.floor(iCityPop / 4)
				pCity:ChangePopulation((-1 * iUploadedCitizens), true);
				pCity:SetNumRealBuilding(iBuildingBrainUploadingDummy, iUploadedCitizens)
				local title = "Citizens Uploaded";
				local descr = iUploadedCitizens .. " [ICON_CITIZEN] Citizens have been digitally uploaded.";
				pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, descr, title, pCity:GetX(), pCity:GetY(), -1);	
				--print(descr)
			end
		end
end
GameEvents.CityConstructed.Add(CityBuiltTest)

function CheckUploading(iPlotX, iPlotY, iOldPop, iNewPop)
	local pCity = Map.GetPlot(iPlotX, iPlotY):GetPlotCity()
	if (pCity:GetNumRealBuilding(iBuildingBrainUploading) > 0) and (iNewPop > 3) and (iNewPop > iOldPop) then
		local randomNumber = JFD_GetRandom(1, 100)
		if (randomNumber < 25) then
			local iUploadedCitizens = pCity:GetNumRealBuilding(iBuildingBrainUploadingDummy)
			pCity:ChangePopulation(-1, true);
			iUploadedCitizens = iUploadedCitizens + 1
			pCity:SetNumRealBuilding(iBuildingBrainUploadingDummy, iUploadedCitizens)
			local pCityName = pCity:GetName()
			local iCityOwner = pCity:GetOwner()
			local pPlayer = Players[iCityOwner]
			local title = "Citizen Uploaded";
			local descr = "1 [ICON_CITIZEN] Citizen has been digitally uploaded in " .. pCityName;
			pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, descr, title, pCity:GetX(), pCity:GetY(), -1);	
			--print(descr)
		end
	end
end
GameEvents.SetPopulation.Add(CheckUploading)

function CheckImprovements (iHexX, iHexY, iContinent1, iContinent2)
	local pPlot = Map.GetPlot(ToGridFromHex(iHexX, iHexY))
	local ImpID = pPlot:GetImprovementType()
	local Owner = pPlot:GetOwner()
	local pPlayer = Players[Owner];
	if (pPlayer) then
		if (ImpID == iImprovementAcademy and (pPlayer:GetBuildingClassCount(iBuildingAcceleratorClass) > 0)) then
			pPlot:SetImprovementType(iImprovementHERC)
		end
	end
end
Events.SerialEventImprovementCreated.Add(CheckImprovements);

function FWBuildingImprovementBonuses(iPlayer)
	local pPlayer = Players[iPlayer]
	local tMyWheatPlotsThisTurn = {}
	for pCity in pPlayer:Cities() do
		local tNearbyDatas = GetCityMapDatas(pCity)
		if pCity:IsHasBuilding(iBuildingGeneLab) then
			local iNumFarms = GetNumCityWorkingImprovementPlots(tNearbyDatas, iImprovementFarm)
			--print("Num Farms: " .. iNumFarms)
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_GENE_LAB_DUMMY"], iNumFarms)
		else
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_GENE_LAB_DUMMY"], 0)
		end
		--if pCity:IsHasBuilding(iBuildingCloneLab) then
		--	local iNumPastures = GetNumCityWorkingImprovementPlots(tNearbyDatas, iImprovementPasture)
		--	pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_CLONE_LAB_DUMMY"], iNumPastures)
		--else
		--	pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_CLONE_LAB_DUMMY"], 0)
		--end
		if pCity:IsHasBuilding(iBuildingSanctuary) then
			local iNumPreserves = GetNumCityWorkingImprovementPlots(tNearbyDatas, iImprovementPreserve)
			--print("Num Preserves: " .. iNumPreserves)
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_SANCTUARY_DUMMY"], iNumPreserves)
		else
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_SANCTUARY_DUMMY"], 0)
		end
		if pCity:IsHasBuilding(iBuildingNetworkBackbone) then
			local tCommArrayPlots = GetCityImprovementPlots(tNearbyDatas, iImprovementCommArray, "Plots")
			local iNumCommArrays = #tCommArrayPlots
			--print("Num CommArrays: " .. iNumCommArrays)
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_NETWORK_BACKBONE_DUMMY_3"], iNumCommArrays)
		else
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_NETWORK_BACKBONE_DUMMY_3"], 0)
		end
		if pCity:IsHasBuilding(iBuildingDroneHive) then
			local tGeneratorPlots = GetCityImprovementPlots(tNearbyDatas, iImprovementGenerator, "Plots")
			local iNumGenerators = #tGeneratorPlots
			--print("Num Generators: " .. iNumGenerators)
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_DRONE_HIVE_DUMMY_1"], iNumGenerators)
		else
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_DRONE_HIVE_DUMMY_1"], 0)
		end
		if pCity:IsHasBuilding(iBuildingSimulationServer) then
			local tCorePlots = GetCityImprovementPlots(tNearbyDatas, iImprovementCore, "Plots")
			local iNumCores = #tCorePlots
			--print("Num Cores: " .. iNumCores)
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_SIMULATION_SERVER_DUMMY_2"], iNumCores)
		else
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_DRONE_HIVE_DUMMY_2"], 0)
		end
		if pCity:IsHasBuilding(iBuildingDistributionHub) then
			local iNumIndustrialSites = GetNumCityWorkingImprovementPlots(tNearbyDatas, iImprovementIndustrialSite)
			--if (pPlayer:GetBuildingClassCount(iBuildingCentralCommandClass) > 0) then
			--	iNumIndustrialSites = iNumIndustrialSites * 2
			--end
			--print("Num Industrial Sites: " .. iNumIndustrialSites)
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_DISTRIBUTION_HUB_DUMMY"], iNumIndustrialSites)
		else
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_DISTRIBUTION_HUB_DUMMY"], 0)
		end
		if pCity:IsHasBuilding(iBuildingMetroplexHub) then
			local iNumArcologies = GetNumCityWorkingImprovementPlots(tNearbyDatas, iImprovementArcology)
			--if (pPlayer:GetBuildingClassCount(iBuildingCentralCommandClass) > 0) then
			--	iNumArcologies = iNumArcologies * 2
			--end
			print("Num Arcologies: " .. iNumArcologies)
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_METROPLEX_HUB_DUMMY"], iNumArcologies)
		else
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_METROPLEX_HUB_DUMMY"], 0)
		end
		if pCity:IsHasBuilding(iBuildingVerticalFarm) then
			local iNumDomes = GetNumCityWorkingImprovementPlots(tNearbyDatas, iImprovementDome)
			--print("Num Domes: " .. iNumDomes)
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_VERTICAL_FARM_DUMMY"], iNumDomes)
		else
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_VERTICAL_FARM_DUMMY"], 0)
		end
	end
end
GameEvents.PlayerDoTurn.Add(FWBuildingImprovementBonuses)


function FeedsiteHubBonus(iPlayer)
	local pPlayer = Players[iPlayer];
	local pCapital = pPlayer:GetCapitalCity();
	local iNumHappiness = 0
	local iNumCulture = 0
	--print("Checking Feedsite Hub Bonus")
	for pCity in pPlayer:Cities() do
		if pCity:IsHasBuilding(iBuildingFeedsiteHub) then
			--print("Feedsite Hub found")
			iNumCulture = pCity:GetNumGreatWorks()
			if pCity:IsHasBuilding(iBuildingColosseum) then iNumHappiness = iNumHappiness + 1 end
			if (iBuildingMenagerie == nil) then
				if pCity:IsHasBuilding(iBuildingTheatre) then iNumHappiness = iNumHappiness + 1 end
			else
				if pCity:IsHasBuilding(iBuildingMenagerie) then iNumHappiness = iNumHappiness + 1 end
			end
			if pCity:IsHasBuilding(iBuildingStadium) then iNumHappiness = iNumHappiness + 1 end
			--if (pPlayer:GetBuildingClassCount(iBuildingCentralCommandClass) > 0) then
			--	iNumCulture = iNumCulture * 2
			--	iNumHappiness = iNumHappiness * 2
			--end
			--print("iNumHappiness: " .. iNumHappiness .. ", iNumCulture: " .. iNumCulture)
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_FEEDSITE_HUB_DUMMY_2"], iNumHappiness)
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_FEEDSITE_HUB_DUMMY_1"], iNumCulture)
		end
	end
end
GameEvents.PlayerDoTurn.Add(FeedsiteHubBonus)

function NephilimGeneTemplateBonus(iPlayer)
	local pPlayer = Players[iPlayer];
	for pCity in pPlayer:Cities() do
		if (pPlayer:GetBuildingClassCount(iBuildingNephilimGeneTemplateClass) > 0) then
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_NEPHILIMGENETEMPLATE_DUMMY"], 1)
		else
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_NEPHILIMGENETEMPLATE_DUMMY"], 0)
		end
	end
end
GameEvents.PlayerDoTurn.Add(NephilimGeneTemplateBonus)

function AngelnetBonus(iPlayer)
	local pPlayer = Players[iPlayer];
	for pCity in pPlayer:Cities() do
		if pCity:IsHasBuilding(iBuildingUtilityFog) and (pPlayer:GetBuildingClassCount(iBuildingAngelnetClass) > 0) then
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_ANGELNET_DUMMY"], 1)
		else
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_ANGELNET_DUMMY"], 0)
		end
	end
end
GameEvents.PlayerDoTurn.Add(AngelnetBonus)

function DataHavenBonus(iPlayer)
	local pPlayer = Players[iPlayer];
	for pCity in pPlayer:Cities() do
		if pCity:IsHasBuilding(iBuildingDataHaven) then
			local iNumServers = pPlayer:GetBuildingClassCount(iBuildingServerHubClass)
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_DATA_HAVEN_DUMMY_3"], iNumServers)
		else
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_DATA_HAVEN_DUMMY_1"], 0)
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_DATA_HAVEN_DUMMY_2"], 0)
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_DATA_HAVEN_DUMMY_3"], 0)
		end
	end
end
GameEvents.PlayerDoTurn.Add(DataHavenBonus)

function BuenosAiresForumBonus(iPlayer)
	local pPlayer = Players[iPlayer];
	for pCity in pPlayer:Cities() do
		if pCity:IsHasBuilding(iBuildingBuenosAiresForum) then
			local iPop = pCity:GetPopulation();
			pPlayer:ChangeGoldenAgeProgressMeter(iPop)
		end
	end
end
GameEvents.PlayerDoTurn.Add(BuenosAiresForumBonus)

function ShimizuMCPBonus(iPlayer)
	local pPlayer = Players[iPlayer];
	for pCity in pPlayer:Cities() do
		if pCity:IsHasBuilding(iBuildingShimizuMCP) then
			local iBuildingMaintenance = pCity:GetTotalBaseBuildingMaintenance();
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_SHIMIZUMCP_DUMMY"], iBuildingMaintenance)
		end
	end
end
GameEvents.PlayerDoTurn.Add(ShimizuMCPBonus)

function JurassicParkBonus(iPlayer)
	local pPlayer = Players[iPlayer];
	--print("Checking for Jurassic Park")
	if (pPlayer:GetBuildingClassCount(iBuildingJurassicParkClass) > 0) then
		--print("Jurassic Park found.")
		local iCheckForDinos = JFD_GetRandom(1, 100)
		--print("Dino number is " .. iCheckForDinos)
		if (iCheckForDinos < iChanceDinos) then
			local tPlots ={}
			for pCity in pPlayer:Cities() do
				if (iBuildingMenagerie == nil) then
					if pCity:IsHasBuilding(iBuildingZoo) then
						--print("Zoo found")
						local pCentralPlot = pCity:Plot()
						for pPlot in PlotAreaSpiralIterator(pCentralPlot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
							local iImprovement = pPlot:GetImprovementType()
							local iTerrain = pPlot:GetTerrainType()
							local iOwner = pPlot:GetOwner()
							if (((iTerrain == iPlains) or (iTerrain == iGrasslands)) and (iOwner == iPlayer) and (pPlot:GetNumUnits() == 0) and not (pPlot:IsMountain())) then
								table.insert(tPlots, pPlot)
								--print("Inserted plot")
							end
						end
					end
				else
					if pCity:IsHasBuilding(iBuildingMenagerie) then
						--print("Menagerie found")
						local pCentralPlot = pCity:Plot()
						for pPlot in PlotAreaSpiralIterator(pCentralPlot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
							local iImprovement = pPlot:GetImprovementType()
							local iTerrain = pPlot:GetTerrainType()
							local iOwner = pPlot:GetOwner()
							if (((iTerrain == iPlains) or (iTerrain == iGrasslands)) and (iOwner == iPlayer) and (pPlot:GetNumUnits() == 0) and not (pPlot:IsMountain())) then
								table.insert(tPlots, pPlot)
								--print("Inserted plot")
							end
						end
					end
				end
			end
			if #tPlots > 0 then
				local randomNumber = JFD_GetRandom(1, #tPlots)
				local tPlot = tPlots[randomNumber]
				local iDinoNumber = JFD_GetRandom(1, 6)
				--print("Dino Type is " .. iDinoNumber)
				local iDinoType = iTRex
				if (iDinoNumber > 3) then 
					iDinoType = iRaptor
				else
					if (iDinoNumber > 1) then
						iDinoType = iTriceratops
					end
				end
				local teamID = pPlayer:GetTeam();
				local pTeam = Teams[teamID];
				if not (pTeam:IsHasTech(iPrereq2)) then
					local nUnit = Players[63]:InitUnit(iDinoType, tPlot:GetX(), tPlot:GetY())
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(JurassicParkBonus)

function PholusMutagenBonus(iPlayer)
	local pPlayer = Players[iPlayer];
	--print("Checking for Pholus Mutagen")
	if (pPlayer:GetBuildingClassCount(iBuildingPholusMutagenClass) > 0) then
		--print("Mutagen found")
		for pCity in pPlayer:Cities() do
			--print("Checking city")
			local iNumDomes = 0
			local i;
			for i = 0, pCity:GetNumCityPlots() - 1, 1 do
				local pPlot = pCity:GetCityIndexPlot( i );
				if (pPlot ~= nil) then
					--print("Checking plot")
					if (pPlot:GetOwner() == pCity:GetOwner()) then
						local iImprovement = pPlot:GetImprovementType()
						local iTerrain = pPlot:GetTerrainType()
						--print("Improvement is type " .. iImprovement)
						if ((iImprovement == iImprovementFarm) or (iImprovement == iImprovementPlantation) or (iImprovement == iImprovementPreserve) or (iImprovement == -1)) and (((iTerrain == iPlains) or (iTerrain == iGrasslands)) and not (pPlot:IsMountain()) and not (pPlot:IsCity())) then
							local iCheckForFungus = JFD_GetRandom(1, 100)
							local iChanceFungusGrowth = iChanceForFungus
							local iAdjacentFungusBonus = 0

							for loopPlot in PlotAreaSweepIterator(pPlot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
								local iLoopImprovement = loopPlot:GetImprovementType()
								if (iLoopImprovement == iImprovementFungus) then
									--print("Adjacent fungus found")
									iAdjacentFungusBonus = iAdjacentFungusBonus + iAdjacentFungusModifier
								end
							end

							if iAdjacentFungusBonus > 3 then iAdjacentFungusBonus = 3 end
							iChanceFungusGrowth = iChanceFungusGrowth + iAdjacentFungusBonus
							--print("Chance for fungus: " .. iChanceFungusGrowth)
							--print("Rolled: " .. iCheckForFungus)

							if (iCheckForFungus < iChanceFungusGrowth) then
								pPlot:SetImprovementType(iImprovementFungus)
							end
						end
					end
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(PholusMutagenBonus)

function NetworkBackboneBonus(iPlayer)
	local pPlayer = Players[iPlayer];
	for pCity in pPlayer:Cities() do
		if pCity:IsHasBuilding(iBuildingNetworkBackbone) then
			local iNumResearchServers = pPlayer:GetBuildingClassCount(iBuildingResearchServerClass)
			if iNumResearchServers > 10 then iNumResearchServers = 10 end
			local iNumEntertainmentServers = pPlayer:GetBuildingClassCount(iBuildingEntertainmentServerClass)
			if iNumEntertainmentServers > 10 then iNumEntertainmentServers = 10 end
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_NETWORK_BACKBONE_DUMMY_1"], iNumResearchServers)
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_NETWORK_BACKBONE_DUMMY_2"], iNumEntertainmentServers)
		else
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_NETWORK_BACKBONE_DUMMY_1"], 0)
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_NETWORK_BACKBONE_DUMMY_2"], 0)
		end
	end
end
GameEvents.PlayerDoTurn.Add(NetworkBackboneBonus)

function AutoplantBonus(iPlayer)
	local pPlayer = Players[iPlayer];
	for pCity in pPlayer:Cities() do
		if pCity:IsHasBuilding(iBuildingAutoplant) then
			local iNumECommerceServers = pPlayer:GetBuildingClassCount(iBuildingECommerceServerClass)
			if iNumECommerceServers > 10 then iNumECommerceServers = 10 end
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_AUTOPLANT_DUMMY"], iNumECommerceServers)
		else
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_AUTOPLANT_DUMMY"], 0)
		end
	end
end
GameEvents.PlayerDoTurn.Add(AutoplantBonus)

function TelepresenceHubBonus(iPlayer)
	local pPlayer = Players[iPlayer];
	for pCity in pPlayer:Cities() do
		if pCity:IsHasBuilding(iBuildingTelepresenceHub) then
			local iNumCyberclincs = pPlayer:GetBuildingClassCount(iBuildingCyberclincClass)
			if iNumCyberclnics > 10 then iNumCyberclinics = 10 end
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_TELEPRESENCE_HUB_DUMMY"], iNumCyberclincs)
		else
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_TELEPRESENCE_HUB_DUMMY"], 0)
		end
	end
end
GameEvents.PlayerDoTurn.Add(TelepresenceHubBonus)

function OrbitalHabitatBonus(iPlayer)
	local pPlayer = Players[iPlayer];
	for pCity in pPlayer:Cities() do
		if pCity:IsHasBuilding(iBuildingOrbitalHabitat) then
			local iNumScientists = pCity:GetNumSpecialistsInBuilding(iBuildingResearchModule)
			local iNumMerchants = pCity:GetNumSpecialistsInBuilding(iBuildingCommModule)
			local iNumEngineers = pCity:GetNumSpecialistsInBuilding(iBuildingEngineeringModule)
			local iNumSpecialists = iNumScientists + iNumMerchants + iNumEngineers

			print("Scientists: " .. iNumScientists .. ", iNumMerchants: " .. iNumMerchants .. ", Engineers: " .. iNumEngineers)
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_ORBITAL_HABITAT_DUMMY"], iNumSpecialists)
		else
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_ORBITAL_HABITAT_DUMMY"], 0)
		end
	end
end
GameEvents.PlayerDoTurn.Add(OrbitalHabitatBonus)

function CityScreenBuildingBonuses()
	local iPlayer = Game.GetActivePlayer()
	FWBuildingImprovementBonuses(iPlayer)
	FeedsiteHubBonus(iPlayer)
	NephilimGeneTemplateBonus(iPlayer)
	ShimizuMCPBonus(iPlayer)
	NetworkBackboneBonus(iPlayer)
	AutoplantBonus(iPlayer)
	TelepresenceHubBonus(iPlayer)
	OrbitalHabitatBonus(iPlayer)
end
Events.SerialEventExitCityScreen.Add(CityScreenBuildingBonuses)

function HeliosDamage(iPlayer)
	local pPlayer = Players[iPlayer]
	local teamID = pPlayer:GetTeam()
	local pPlayerTeam = Teams[teamID]
	if pPlayer:GetBuildingClassCount(iBuildingHeliosClass) > 0 then
		for pCity in pPlayer:Cities() do
			if pCity:GetNumRealBuilding(iBuildingSolarPlant) > 0 then
				local pCityX = pCity:GetX()
				local pCityY = pCity:GetY()
				local plot = Map.GetPlot(pCityX, pCityY)
				for loopPlot in PlotAreaSweepIterator(plot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
					for iVal = 0,(loopPlot:GetNumUnits() - 1) do
						local loopUnit = loopPlot:GetUnit(iVal)
						if loopUnit:GetOwner() ~= iPlayer then
							local loopUnitOwner = loopUnit:GetOwner()
							local otherPlayer = Players[loopUnitOwner]
							local otherTeamID = otherPlayer:GetTeam()
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
GameEvents.PlayerDoTurn.Add(HeliosDamage)

function SkynetRobots(iPlayer)
	local pPlayer = Players[iPlayer]
	if pPlayer:IsAlive() then
		for pUnit in pPlayer:Units() do
			if (pUnit:GetUnitType() == GameInfoTypes["UNIT_FW_ROBOT_INFANTRY"]) and (pPlayer:GetBuildingClassCount(iBuildingSkynetClass) == 0) then
				for iCheckID, pOtherPlayer in pairs(Players) do
					if (pPlayer ~= pOtherPlayer) and (pOtherPlayer:GetBuildingClassCount(iBuildingSkynetClass) > 0) then
						local iDMG = loopUnit:GetDamage()
						local UnitType = loopUnit:GetUnitType()
						local iX = pUnit:GetX()
						local iY = pUnit:GetY()
						pUnit:Kill()
						local nUnit = pOtherPlayer:InitUnit(UnitType, iX, iY)
						nUnit:SetDamage(iDMG)
					end
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(SkynetRobots)

function CoreHealing(iPlayer)
	local pPlayer = Players[iPlayer]
	if pPlayer:IsAlive() then
		for pUnit in pPlayer:Units() do
			local pPlot = pUnit:GetPlot()
			local iRadius = 1
			local bCorePresent = false
			for pAdjacentPlot in PlotAreaSpiralIterator(pPlot, iRadius, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
				local iImprovement = pAdjacentPlot:GetImprovementType()
				local iOwner = pAdjacentPlot:GetOwner()
				if (iImprovement == iImprovementCore) and (iOwner == iPlayer) then
					bCorePresent = true
				end			
			end
			if bCorePresent and (pUnit:GetDamage() > 0) then
				pUnit:ChangeDamage(-10)
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(CoreHealing)

function NanohiveEffects(iPlayer)
	local pPlayer = Players[iPlayer]
	local teamID = pPlayer:GetTeam()
	local pPlayerTeam = Teams[teamID]
	--print("Checking for Nanohives")
	for pUnit in pPlayer:Units() do
		if pUnit:IsHasPromotion(iNanohivePromotion) then
			print("Nanohive found")
			local pPlot = pUnit:GetPlot()
			if (pPlot ~= nil) then
				for loopPlot in PlotAreaSweepIterator(pPlot, 2, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
					for iVal = 0,(loopPlot:GetNumUnits() - 1) do
						local loopUnit = loopPlot:GetUnit(iVal)
						if loopUnit:GetOwner() == iPlayer then
							if (loopUnit:GetDamage() > 0) then
								print("Healing damaged unit")
								loopUnit:ChangeDamage(-10)
							end
						else 
							local loopUnitOwner = loopUnit:GetOwner()
							local otherPlayer = Players[loopUnitOwner]
							local otherTeamID = otherPlayer:GetTeam()
							if pPlayerTeam:IsAtWar(otherTeamID) then
								print("Damaging enemy unit")
								loopUnit:ChangeDamage(10)
							end
						end
					end
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(NanohiveEffects)

function CrawlerEffects(iPlayer)
	local pPlayer = Players[iPlayer]
	for pUnit in pPlayer:Units() do
		if (pUnit:GetUnitType() == GameInfoTypes["UNIT_FW_CRAWLER"]) then
			--print("Crawler found")
			local iCheckForMissileProduction = JFD_GetRandom(1, 100)
			if (iCheckForMissileProduction < iChanceMissileProduction) then
				local pPlot = pUnit:GetPlot()
				if (pPlot ~= nil) then
					local iNumMissiles = 0
					for iVal = 0,(pPlot:GetNumUnits() - 1) do
						local loopUnit = pPlot:GetUnit(iVal)
						if (loopUnit:GetUnitType() == GameInfoTypes["UNIT_FW_HYPERMISSILE"]) then
							--print("Missile found")
							iNumMissiles = iNumMissiles + 1
						end
					end
					--print("Total missiles: " .. iNumMissiles)
					if (iNumMissiles < 3) then
						local pNewUnit = pPlayer:InitUnit(iHypermissile, pPlot:GetX(), pPlot:GetY())
					end
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(CrawlerEffects)

function HydraEffects(iPlayer)
	local pPlayer = Players[iPlayer]
	local teamID = pPlayer:GetTeam()
	local pPlayerTeam = Teams[teamID]
	for pUnit in pPlayer:Units() do
		if (pUnit:GetUnitType() == GameInfoTypes["UNIT_FW_HYDRA"]) then
			--print("Hydra found")
			local pPlot = pUnit:GetPlot()
			local bEnemyPresent = false
			local iRadius = 2
			--print("Entering loop")
			for pAdjacentPlot in PlotAreaSpiralIterator(pPlot, iRadius, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
				--print("Checking for enemy units")
				if pAdjacentPlot and not (pAdjacentPlot:IsWater()) then
					for iVal = 0,(pAdjacentPlot:GetNumUnits() - 1) do
						--print("Unit found")
						local loopUnit = pAdjacentPlot:GetUnit(iVal)
						if loopUnit:GetOwner() ~= iPlayer then
							--print("Isn't player")
							local loopUnitOwner = loopUnit:GetOwner()
							local otherPlayer = Players[loopUnitOwner]
							local otherTeamID = otherPlayer:GetTeam()
							if pPlayerTeam:IsAtWar(otherTeamID) then
								--print("Enemy unit found")
								bEnemyPresent = true
							end
						end
					end
				end
			end
			if bEnemyPresent and not (pPlot:IsWater()) then
				local tPlots ={}
				local pPlot = pUnit:GetPlot()
				if (pPlot ~= nil) then
					for loopPlot in PlotAreaSweepIterator(pPlot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
						if (loopPlot ~= nil) then
							if loopPlot:GetNumUnits() < 1 and not (loopPlot:IsWater()) and not (loopPlot:IsMountain()) and not (loopPlot:IsCity()) then
								table.insert(tPlots, loopPlot)
							end
						end
					end
					if #tPlots > 0 then
						local randomNumber = JFD_GetRandom(1, #tPlots)
						local tPlot = tPlots[randomNumber]
						local pNewUnit1 = pPlayer:InitUnit(iSwarm, tPlot:GetX(), tPlot:GetY())
						table.remove(tPlots, randomNumber)
						if #tPlots > 0 then
							local randomNumber2 = JFD_GetRandom(1, #tPlots)
							local tPlot2 = tPlots[randomNumber2]
							local pNewUnit2 = pPlayer:InitUnit(iSwarm, tPlot2:GetX(), tPlot2:GetY())
						else	
							for pAdjacentPlot in PlotAreaSweepIterator(pPlot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
								for iVal = 0,(pAdjacentPlot:GetNumUnits() - 1) do
									local loopUnit = pAdjacentPlot:GetUnit(iVal)
									if loopUnit:GetOwner() ~= iPlayer then
										local loopUnitOwner = loopUnit:GetOwner()
										local otherPlayer = Players[loopUnitOwner]
										local otherTeamID = otherPlayer:GetTeam()
										if pPlayerTeam:IsAtWar(otherTeamID) then
											loopUnit:ChangeDamage(10)
										end
									end
								end
							end
						end
					else
						for pAdjacentPlot in PlotAreaSweepIterator(pPlot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
							for iVal = 0,(pAdjacentPlot:GetNumUnits() - 1) do
								local loopUnit = pAdjacentPlot:GetUnit(iVal)
								if loopUnit:GetOwner() ~= iPlayer then
									local loopUnitOwner = loopUnit:GetOwner()
									local otherPlayer = Players[loopUnitOwner]
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
		end
	end
end
GameEvents.PlayerDoTurn.Add(HydraEffects)

function SwarmEffects()
	local iPlayer = Game.GetActivePlayer()
	local pPlayer = Players[iPlayer]
	local teamID = pPlayer:GetTeam()
	local pPlayerTeam = Teams[teamID]
	for pUnit in pPlayer:Units() do
		if (pUnit:GetUnitType() == GameInfoTypes["UNIT_FW_SWARM"]) then
			--print("Swarm found")
			local pPlot = pUnit:GetPlot()	
			for pAdjacentPlot in PlotAreaSweepIterator(pPlot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
				for iVal = 0,(pAdjacentPlot:GetNumUnits() - 1) do
					local loopUnit = pAdjacentPlot:GetUnit(iVal)
					if loopUnit:GetOwner() ~= iPlayer then
						local loopUnitOwner = loopUnit:GetOwner()
						local otherPlayer = Players[loopUnitOwner]
						local otherTeamID = otherPlayer:GetTeam()
						if pPlayerTeam:IsAtWar(otherTeamID) then
							loopUnit:ChangeDamage(10)
						end
					end
				end
			end
			pUnit:Kill()
		end
	end
end
Events.ActivePlayerTurnEnd.Add(SwarmEffects)

function BioModEffects(iPlayer)
	local pPlayer = Players[iPlayer]
	for pUnit in pPlayer:Units() do
		if (pUnit:IsHasPromotion(iBoostModEffect1Promotion)) then
			pUnit:SetHasPromotion(iBoostModEffect1Promotion, false)
		end
		if (pUnit:IsHasPromotion(iBoostModEffect2Promotion)) then
			pUnit:SetHasPromotion(iBoostModEffect2Promotion, false)
			pUnit:SetHasPromotion(iBoostModEffect1Promotion, true)
		end
		if (pUnit:IsHasPromotion(iBoostModEffect3Promotion)) then
			pUnit:SetHasPromotion(iBoostModEffect3Promotion, false)
			pUnit:SetHasPromotion(iBoostModEffect2Promotion, true)
		end
		if (pUnit:IsHasPromotion(iBoostModPromotion)) then
			if (pUnit:GetDamage() > 50) then
				pUnit:SetHasPromotion(iBoostModEffect1Promotion, false)
				pUnit:SetHasPromotion(iBoostModEffect2Promotion, false)
				pUnit:SetHasPromotion(iBoostModEffect3Promotion, true)
				pUnit:SetHasPromotion(iBoostModPromotion, false)
				pUnit:SetHasPromotion(iBoostModEmptyPromotion, true)
			end
		end
		if (pUnit:IsHasPromotion(iStimModPromotion)) then
			if (pUnit:GetDamage() > 50) then
				pUnit:ChangeDamage(-25)
				pUnit:SetHasPromotion(iStimModPromotion, false)
				pUnit:SetHasPromotion(iStimModEmptyPromotion, true)
			end
		end
		if (pUnit:IsHasPromotion(iStimModEmptyPromotion) or pUnit:IsHasPromotion(iBoostModEmptyPromotion)) then
			local iX = pUnit:GetX()
			local iY = pUnit:GetY()
			for pCity in pPlayer:Cities() do
				local iCityX = pCity:GetX()
				local iCityY = pCity:GetY()
				if (iX == iCityX and iY == iCityY) then
					if pCity:IsHasBuilding(iBioModTank) then
						if pUnit:IsHasPromotion(iStimModEmptyPromotion) then
							pUnit:SetHasPromotion(iStimModEmptyPromotion, false)
							pUnit:SetHasPromotion(iStimModPromotion, true)
						end
						if pUnit:IsHasPromotion(iBoostModEmptyPromotion) then
							pUnit:SetHasPromotion(iBoostModEmptyPromotion, false)
							pUnit:SetHasPromotion(iBoostModPromotion, true)
						end
					end
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(BioModEffects)

function BioModReload(iPlayer, iUnit, ePromotion)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	if pUnit:IsHasPromotion(iStimModPromotion) then
		pUnit:SetHasPromotion(iStimModEmptyPromotion, false)
	end
	if pUnit:IsHasPromotion(iBoostModPromotion) then
		pUnit:SetHasPromotion(iBoostModEmptyPromotion, false)
	end
end
GameEvents.UnitPromoted.Add(BioModReload)

function FWUnitDestroyed(iPlayer, iUnit, iUnitType, iX, iY, bDelay, iByPlayer)

	local pPlayer = Players[iPlayer]
	local teamID = pPlayer:GetTeam()
	local pPlayerTeam = Teams[teamID]
	local pUnit = pPlayer:GetUnitByID(iUnit)

	--print("Unit destroyed")

	--print("iPlayer = " .. iPlayer)
	--print("iByPlayer = " .. iByPlayer)
	
	-- Must have been killed by another Player
	if iPlayer == iByPlayer then return end
	if iByPlayer == -1 then return end
	
	-- Must have the Mutation Promotion
	bMutant = pUnit:IsHasPromotion(iMutationPromotion)
	bToxin = pUnit:IsHasPromotion(iToxinModPromotion)
	if not(bMutant or bToxin) then return end
	print("Has Mutation or Toxin")

	local pPlot = pUnit:GetPlot()	
	for pAdjacentPlot in PlotAreaSweepIterator(pPlot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
		print("Checking plot")
		for iVal = 0,(pAdjacentPlot:GetNumUnits() - 1) do
			print("Checking unit")
			local loopUnit = pAdjacentPlot:GetUnit(iVal)
			if loopUnit:GetOwner() ~= iPlayer then
				print("Not same owner")
				local loopUnitOwner = loopUnit:GetOwner()
				local otherPlayer = Players[loopUnitOwner]
				local otherTeamID = otherPlayer:GetTeam()
				if pPlayerTeam:IsAtWar(otherTeamID) then
					if (bToxin) then
						loopUnit:ChangeDamage(10)
					end
					if (bMutant) then
						print("Mutation found")
						local randomNumber = JFD_GetRandom(1, 100)
						local loopDMG = loopUnit:GetDamage()
						print("DMG is " .. loopDMG .. ", random number is " .. randomNumber)
						if (loopDMG > 50) and (randomNumber < loopDMG) and not (pAdjacentPlot:IsCity()) then
							print("Target affected")
							local loopType = loopUnit:GetUnitType()
							loopUnit:Kill()
							print("Target killed")
							local nUnit = Players[63]:InitUnit(loopType, pAdjacentPlot:GetX(), pAdjacentPlot:GetY())
							nUnit:SetDamage(loopDMG)
							print("Barbarian spawned")
						end
					end
				end
			end
		end
	end	
end
GameEvents.UnitPrekill.Add(FWUnitDestroyed)

function WonderPoliciesCheck(playerID)
	local player = Players[playerID]
	if player:IsAlive() and (player:GetBuildingClassCount(iBuildingGeneVaultClass) > 0) and not player:HasPolicy(GameInfoTypes["POLICY_GENE_VAULT"]) then
		if not (player:HasPolicy(GameInfoTypes["POLICY_GENE_VAULT_DUMMY"])) then
			player:SetNumFreePolicies(1)
			player:SetNumFreePolicies(0)
		else
			player:SetHasPolicy(GameInfoTypes["POLICY_GENE_VAULT_DUMMY"], false)
		end	
		player:SetHasPolicy(GameInfoTypes["POLICY_GENE_VAULT"], true)	
	end
	if player:IsAlive() and (player:GetBuildingClassCount(iBuildingGeneVaultClass) == 0) and player:HasPolicy(GameInfoTypes["POLICY_GENE_VAULT"]) then
		player:SetHasPolicy(GameInfoTypes["POLICY_GENE_VAULT"], false)
		player:SetHasPolicy(GameInfoTypes["POLICY_GENE_VAULT_DUMMY"], true)	
	end

	if player:IsAlive() and (player:GetBuildingClassCount(iBuildingBionicTowerClass) > 0) and not player:HasPolicy(GameInfoTypes["POLICY_BIONIC_TOWER"]) then
		if not (player:HasPolicy(GameInfoTypes["POLICY_BIONIC_TOWER_DUMMY"])) then
			player:SetNumFreePolicies(1)
			player:SetNumFreePolicies(0)
		else
			player:SetHasPolicy(GameInfoTypes["POLICY_BIONIC_TOWER_DUMMY"], false)
		end	
		player:SetHasPolicy(GameInfoTypes["POLICY_BIONIC_TOWER"], true)	
	end
	if player:IsAlive() and (player:GetBuildingClassCount(iBuildingBionicTowerClass) == 0) and player:HasPolicy(GameInfoTypes["POLICY_BIONIC_TOWER"]) then
		player:SetHasPolicy(GameInfoTypes["POLICY_BIONIC_TOWER"], false)
		player:SetHasPolicy(GameInfoTypes["POLICY_BIONIC_TOWER_DUMMY"], true)	
	end

	if player:IsAlive() and (player:GetBuildingClassCount(iBuildingHeliosClass) > 0) and not player:HasPolicy(GameInfoTypes["POLICY_HELIOS"]) then
		if not (player:HasPolicy(GameInfoTypes["POLICY_HELIOS_DUMMY"])) then
			player:SetNumFreePolicies(1)
			player:SetNumFreePolicies(0)
		else
			player:SetHasPolicy(GameInfoTypes["POLICY_HELIOS_DUMMY"], false)
		end	
		player:SetHasPolicy(GameInfoTypes["POLICY_HELIOS"], true)	
	end
	if player:IsAlive() and (player:GetBuildingClassCount(iBuildingHeliosClass) == 0) and player:HasPolicy(GameInfoTypes["POLICY_HELIOS"]) then
		player:SetHasPolicy(GameInfoTypes["POLICY_HELIOS"], false)
		player:SetHasPolicy(GameInfoTypes["POLICY_HELIOS_DUMMY"], true)	
	end

	if player:IsAlive() and (player:GetBuildingClassCount(iBuildingBoreholeClass) > 0) and not player:HasPolicy(GameInfoTypes["POLICY_BOREHOLE"]) then
		if not (player:HasPolicy(GameInfoTypes["POLICY_BOREHOLE_DUMMY"])) then
			player:SetNumFreePolicies(1)
			player:SetNumFreePolicies(0)
		else
			player:SetHasPolicy(GameInfoTypes["POLICY_BOREHOLE_DUMMY"], false)
		end	
		player:SetHasPolicy(GameInfoTypes["POLICY_BOREHOLE"], true)	
	end
	if player:IsAlive() and (player:GetBuildingClassCount(iBuildingBoreholeClass) == 0) and player:HasPolicy(GameInfoTypes["POLICY_BOREHOLE"]) then
		player:SetHasPolicy(GameInfoTypes["POLICY_BOREHOLE"], false)
		player:SetHasPolicy(GameInfoTypes["POLICY_BOREHOLE_DUMMY"], true)	
	end
end
GameEvents.PlayerDoTurn.Add(WonderPoliciesCheck)

function ConstructionCompleted(ownerId, cityId, buildingType, bGold, bFaithOrCulture)
	if buildingType == GameInfoTypes["BUILDING_FW_GENE_VAULT"] then
		local pPlayer = Players[ownerId]
		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(GameInfoTypes["POLICY_GENE_VAULT"], true)
	end
	if buildingType == GameInfoTypes["BUILDING_FW_BIONICTOWER"] then
		local pPlayer = Players[ownerId]
		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(GameInfoTypes["POLICY_BIONIC_TOWER"], true)
	end
	if buildingType == GameInfoTypes["BUILDING_FW_HELIOS"] then
		local pPlayer = Players[ownerId]
		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(GameInfoTypes["POLICY_HELIOS"], true)
	end
	if buildingType == GameInfoTypes["BUILDING_FW_BOREHOLE"] then
		local pPlayer = Players[ownerId]
		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(GameInfoTypes["POLICY_BOREHOLE"], true)
	end
end
GameEvents.CityConstructed.Add(ConstructionCompleted)

function MnemosyneBonus(iPlayer, iCity, iUnitID, bGold, bFaithOrCulture)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnitID)
	local pCity = pPlayer:GetCityByID(iCity)
	if pCity:IsHasBuilding(iBuildingMnemosyne) then
		local iHighestUnitLevel = pPlayer:GetHighestUnitLevel()
		local iNewXP = iHighestUnitLevel * 10
		if iNewXP > 60 then
			iNewXP = 60
		end
		if pUnit:IsCombatUnit() then
			pUnit:ChangeExperience(iNewXP)
		end
	end
end
GameEvents.CityTrained.Add(MnemosyneBonus)

function FWUnitUpgradeRestrictions(iPlayer, iUnit)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	if (pUnit:GetUnitType() == iAutomaton) then
		if (pPlayer:GetBuildingClassCount(iBuildingSkynetClass) < 1) then
			return false;
		end
	end

  return true;
end
GameEvents.CanHaveAnyUpgrade.Add(FWUnitUpgradeRestrictions);


function FWUnitRestrictions(iPlayer, iCity, iUnit)
	local pPlayer = Players[iPlayer]
	if (iUnit == iRobotInfantry) then
		if (pPlayer:GetBuildingClassCount(iBuildingSkynetClass) < 1) then
			return false;
		end
	end
	if (iUnit == iTRex) or (iUnit == iTriceratops) or (iUnit == iRaptor) then
		if (pPlayer:GetBuildingClassCount(iBuildingJurassicParkClass) > 0) then
			local pTeam = pPlayer:GetTeam();
			if (pTeam:IsHasTech(iPrereq2)) then
				return true;
			else
				return false;
			end
		else
			return false;
		end
	end

  return true;
end
GameEvents.CityCanTrain.Add(FWUnitRestrictions);

function SpaceStationRequirement(playerID, buildingType)
  local player = Players[playerID];

  if(buildingType ~= GameInfoTypes["BUILDING_FW_SPACE_STATION"]) then
    return true;
  end

  if(player:GetBuildingClassCount(iBuildingLaunchFacilityClass) > 0) then
    return true;
  end

  return false;
end
GameEvents.PlayerCanConstruct.Add(SpaceStationRequirement);

function AffinityRestrictedBuildings(iPlayer, iCity, iBuilding)
  local pPlayer = Players[iPlayer];
  local pCity = pPlayer:GetCityByID(iCity);

	if (iBuilding == iBuildingGeneLab) or (iBuilding == iBuildingCloneLab) or (iBuilding == iBuildingTGNursery) then
		if pCity:IsHasBuilding(iBuildingVerticalFarm) or pCity:IsHasBuilding(iBuildingMycoproteinVats) or pCity:IsHasBuilding(iBuildingOrbitalHabitat) then
			return false;
		end
	  end

	if (iBuilding == iBuildingBiofactory) or (iBuilding == iBuildingEctogenesisPod) or (iBuilding == iBuildingGeneJackFacility) then
		if pCity:IsHasBuilding(iBuildingAutoplant) or pCity:IsHasBuilding(iBuildingDroneHive) or pCity:IsHasBuilding(iBuildingUtilityFog) then
			return false;
		end
	end

    if (iBuilding == iBuildingAutoplant) or (iBuilding == iBuildingDroneHive) or (iBuilding == iBuildingUtilityFog) then
		if pCity:IsHasBuilding(iBuildingBiofactory) or pCity:IsHasBuilding(iBuildingEctogenesisPod) or pCity:IsHasBuilding(iBuildingGeneJackFacility) then
			return false;
		end
	end

    if (iBuilding == iBuildingNetworkBackbone) or (iBuilding == iBuildingTelepresenceHub) or (iBuilding == iBuildingSimulationServer) then
		if pCity:IsHasBuilding(iBuildingFeedsiteHub) or pCity:IsHasBuilding(iBuildingDistributionHub) or pCity:IsHasBuilding(iBuildingMetroplexHub) then
			return false;
		end
	end

    if (iBuilding == iBuildingFeedsiteHub) or (iBuilding == iBuildingDistributionHub) or (iBuilding == iBuildingMetroplexHub) then
		if pCity:IsHasBuilding(iBuildingNetworkBackbone) or pCity:IsHasBuilding(iBuildingTelepresenceHub) or pCity:IsHasBuilding(iBuildingSimulationServer) then
			return false;
		end
	end

    if (iBuilding == iBuildingVerticalFarm) or (iBuilding == iBuildingMycoproteinVats) or (iBuilding == iBuildingOrbitalHabitat) then
		if pCity:IsHasBuilding(iBuildingGeneLab) or pCity:IsHasBuilding(iBuildingCloneLab) or pCity:IsHasBuilding(iBuildingTGNursery) then
			return false;
		end
	end

  return true;
end
GameEvents.CityCanConstruct.Add(AffinityRestrictedBuildings);

function RemoveUnwantedPromotions(iPlayer, iUnit)
    local pPlayer = Players[iPlayer];
	if pPlayer:GetUnitByID(iUnit) ~= nil then
		pUnit = pPlayer:GetUnitByID(iUnit);
		local iUnitType = pUnit:GetUnitType()
		if (iUnitType == GameInfoTypes.UNIT_FW_NEXUS) then
			pUnit:SetHasPromotion(iEmbarkationPromotion1, false)
			pUnit:SetHasPromotion(iEmbarkationPromotion2, false)
			pUnit:SetHasPromotion(iEmbarkationPromotion3, false)
		end
		if (iUnitType == GameInfoTypes.UNIT_FW_AUTOMATON) or (iUnitType == GameInfoTypes.UNIT_FW_ROBOT_INFANTRY) then
			pUnit:SetHasPromotion(iGengineeredPromotion, false)
			pUnit:SetHasPromotion(iBiomodsPromotion, false)
		end
    end
end
Events.SerialEventUnitCreated.Add(RemoveUnwantedPromotions)

function RemoveUnwantedPromotions2(iPlayer, iUnit, iX, iY)
	if Map.GetPlot(iX,iY) ~= nil then
		local pPlayer = Players[iPlayer];
		local pUnit = pPlayer:GetUnitByID(iUnit);
		local iUnitType = pUnit:GetUnitType()
		if (iUnitType == GameInfoTypes.UNIT_FW_NEXUS) then
			pUnit:SetHasPromotion(iEmbarkationPromotion1, false)
			pUnit:SetHasPromotion(iEmbarkationPromotion2, false)
			pUnit:SetHasPromotion(iEmbarkationPromotion3, false)
		end
		if (iUnitType == GameInfoTypes.UNIT_FW_AUTOMATON) or (iUnitType == GameInfoTypes.UNIT_FW_ROBOT_INFANTRY) then
			pUnit:SetHasPromotion(iGengineeredPromotion, false)
			pUnit:SetHasPromotion(iBiomodsPromotion, false)
		end
	end
end
GameEvents.UnitSetXY.Add(RemoveUnwantedPromotions2)
