-- JFD_Civs_PortugalManuelI_Functions
-- Author: JFD
-- DateCreated: 2/15/2014 6:33:36 PM
--=======================================================================================================================
-- INCLUDES
--=======================================================================================================================
------------------------------------------------------------------------------------------------------------------------
include("FLuaVector.lua")
include("PlotIterators.lua")
--=======================================================================================================================
-- GLOBALS
--=======================================================================================================================
------------------------------------------------------------------------------------------------------------------------
local g_ConvertTextKey  = Locale.ConvertTextKey
local g_MapGetPlot		= Map.GetPlot
local g_MathCeil		= math.ceil
local g_MathFloor		= math.floor
local g_MathMax			= math.max
local g_MathMin			= math.min
				
local Players 			= Players
local HexToWorld 		= HexToWorld
local ToHexFromGrid 	= ToHexFromGrid
local Teams 			= Teams
--=======================================================================================================================
-- UTILITIES
--=======================================================================================================================
------------------------------------------------------------------------------------------------------------------------
-- CORE UTILITIES
------------------------------------------------------------------------------------------------------------------------
--HasTrait
function HasTrait(player, traitID)
	if Player.HasTrait then 
		return player:HasTrait(traitID)
	else
		local leaderType = GameInfo.Leaders[player:GetLeaderType()].Type
		local traitType  = GameInfo.Traits[traitID].Type
		for row in GameInfo.Leader_Traits("LeaderType = '" .. leaderType .. "' AND TraitType = '" .. traitType .. "'") do
			return true
		end
	end
	return false
end
------------------------------------------------------------------------------------------------------------------------
-- MOD UTILITIES
------------------------------------------------------------------------------------------------------------------------
--Game_IsCPActive
function Game_IsCPActive()
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if mod.ID == "d1b6328c-ff44-4b0d-aad7-c657f83610cd" then
			return true
		end
	end
	return false
end
local g_IsCPActive = (Game_IsCPActive() and Player.HasStateReligion)
------------------------------------------------------------------------------------------------------------------------
--Game_IsVMCActive
function Game_IsVMCActive()
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if mod.ID == "d1b6328c-ff44-4b0d-aad7-c657f83610cd" then
			return true
		end
	end
	return false
end
local g_IsVMCActive = Game_IsVMCActive()
--=======================================================================================================================
-- GAME DEFINES
--=======================================================================================================================
------------------------------------------------------------------------------------------------------------------------
local defineMaxMajorCivs = GameDefines["MAX_MAJOR_CIVS"]
--=======================================================================================================================
-- UNIQUE FUNCTIONS
--=======================================================================================================================
------------------------------------------------------------------------------------------------------------------------
-- GLOBALS
------------------------------------------------------------------------------------------------------------------------
local buildingWarAcademyID = GameInfoTypes["BUILDING_JFD_WAR_ACADEMY"]

local traitSwedenKarlXIIID = GameInfoTypes["TRAIT_JFD_SWEDEN_KARL_XII"]

local unitCaroleanID = GameInfoTypes["UNIT_SWEDISH_CAROLEAN"]
------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
------------------------------------------------------------------------------------------------------------------------
--JFD_SwedenKarlXII_PlayerDoTurn
local buildingDummySwedenKarlXIIID = GameInfoTypes["BUILDING_DUMMY_JFD_SWEDEN_KARL_XII"]
local improvementCitadelID = GameInfoTypes["IMPROVEMENT_CITADEL"]
local function JFD_SwedenKarlXII_PlayerDoTurn(playerID)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if player:IsBarbarian() then return end
	if player:IsMinorCiv() then return end
	
	--UNIQUE TRAIT
	if (not HasTrait(player, traitSwedenKarlXIIID)) then return end
	for city in player:Cities() do
		local plot = g_MapGetPlot(city:GetX(), city:GetY())

		local numFoodKept = 0
		for adjacentPlot in PlotAreaSweepIterator(plot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
			if adjacentPlot:GetWorkingCity() == city and adjacentPlot:GetImprovementType() == improvementCitadelID then
				numFoodKept = numFoodKept + 1
				if numFoodKept >= 5 then break end
			end
		end
		city:SetNumRealBuilding(buildingDummySwedenKarlXIIID, numFoodKept)
	end
end
GameEvents.PlayerDoTurn.Add(JFD_SwedenKarlXII_PlayerDoTurn)
------------------------------------------------------------------------------------------------------------------------
--JFD_SwedenKarlXII_SetPopulation
local function JFD_SwedenKarlXII_SetPopulation(plotX, plotY, oldPopulation, newPopulation)
	if newPopulation < oldPopulation then return end
	local city = g_MapGetPlot(plotX, plotY):GetPlotCity()
	if (not city) then return end
	local playerID = city:GetOwner()
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if player:IsMinorCiv() then return end
	
	--UNIQUE TRAIT
	if (not HasTrait(player, traitSwedenKarlXIIID)) then return end
	local playerIsHuman = (player:IsHuman() and player:IsTurnActive())
	local numProduction = g_MathFloor(city:GetFood())
	for unit in GameInfo.Units("CombatClass = 'UNITCOMBAT_MELEE' OR CombatClass = 'UNITCOMBAT_GUN'") do
		local unitID = unit.ID
		if (player:CanTrain(unitID) and city:GetUnitProductionTurnsLeft(unit.ID) > 1) then
			city:ChangeUnitProduction(unitID, numProduction)
			if playerIsHuman then
				local hex = ToHexFromGrid(Vector2(plotX, plotY))
				Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR][ICON_PRODUCTION]", numProduction), true)
			end
		end
	end	
end
GameEvents.SetPopulation.Add(JFD_SwedenKarlXII_SetPopulation)
------------------------------------------------------------------------------------------------------------------------
--JFD_SwedenKarlXII_CityTrained
local buildingWarAcademyID = GameInfoTypes["BUILDING_JFD_WAR_ACADEMY"]
local domainLandID = GameInfoTypes["DOMAIN_LAND"]
local function JFD_SwedenKarlXII_CityTrained(playerID, cityID, unitID, isGold, isFaith)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end

	--UNIQUE BUILDING
	if (not isGold) and (not isFaith) then 
		local city = player:GetCityByID(cityID)
		if city:IsHasBuilding(buildingWarAcademyID) then
			local unit = player:GetUnitByID(unitID)
			if (unit:IsCombatUnit() and unit:GetDomainType() == domainLandID) then
				player:ChangeCombatExperience(20)
			end
		end
	end
end
GameEvents.CityTrained.Add(JFD_SwedenKarlXII_CityTrained)
--=======================================================================================================================
--=======================================================================================================================