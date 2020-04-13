-- JFD_Georgia_Functions
-- Author: JFD
-- DateCreated: 1/5/2018 10:43:02 AM
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
include("FLuaVector.lua")
include("PlotIterators")
--=======================================================================================================================
-- GLOBALS
--=======================================================================================================================
------------------------------------------------------------------------------------------------------------------------
local g_ActiveMods			  = Modding.GetActivatedMods()
local g_ConvertTextKey  	  = Locale.ConvertTextKey
local g_GetRandom	    	  = Game.GetRandom
local g_GetUserSetting  	  = Game.GetUserSetting
local g_MapGetPlot			  = Map.GetPlot
				              
local Players 				  = Players
local HexToWorld 			  = HexToWorld
local ToHexFromGrid 		  = ToHexFromGrid
local Teams 				  = Teams
--=======================================================================================================================
-- ACTIVE MODS
--=======================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
--Game_IsCPActive
function Game_IsCPActive()
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if mod.ID == "d1b6328c-ff44-4b0d-aad7-c657f83610cd" then
			return true
		end
	end
	return false
end
local isCPActive = Game_IsCPActive()
-------------------------------------------------------------------------------------------------------------------------
--Player_HasTrait
function Player_HasTrait(player, traitID)
	if isCPActive then 
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
-------------------------------------------------------------------------------------------------------------------------
--Plot_IsWithinDistanceOfImprovement
function Plot_IsWithinDistanceOfImprovement(plot, improvementID, distance)
	for adjacentPlot in PlotAreaSweepIterator(plot, distance, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
		if adjacentPlot:GetImprovementType() == improvementID  then
			return true
		end
	end
	return false
end
-------------------------------------------------------------------------------------------------------------------------
--Plot_IsWithinDistanceOfMountains
function Plot_IsWithinDistanceOfMountains(plot, distance)
	for adjacentPlot in PlotAreaSweepIterator(plot, distance, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
		if adjacentPlot:IsMountain() then
			return true
		end
	end
	return false
end
-------------------------------------------------------------------------------------------------------------------------
--Unit_IsWithinDistanceOfUnit
function Unit_IsWithinDistanceOfUnit(plot, unitID, distance)
	for adjacentPlot in PlotAreaSweepIterator(plot, distance, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
		for val = 0,(plot:GetNumUnits() - 1) do
			local unit = plot:GetUnit(val)
			if unit:GetUnitType() == unitID then
				return true
			end
		end
	end
	return false
end
--==========================================================================================================================
-- UNIQUE FUNCTIONS
--==========================================================================================================================
local buildingTsikheID = GameInfoTypes["BUILDING_US_TSIKHE"]
local improvementCitadelID = GameInfoTypes["IMPROVEMENT_CITADEL"]
local improvementFortID = GameInfoTypes["IMPROVEMENT_FORT"]
local improvementGeorgiaFortID = GameInfoTypes["IMPROVEMENT_US_GEORGIA_FORT"]
local improvementHolySiteID = GameInfoTypes["IMPROVEMENT_HOLY_SITE"]
local traitGeorgiaID = GameInfoTypes["TRAIT_US_GEORGIA"]
local plotMountainsID = GameInfoTypes["PLOT_MOUNTAIN"]
local promotionTadzeuliID = GameInfoTypes["PROMOTION_US_TADZREULI"]
local promotionTadzeuliActiveID = GameInfoTypes["PROMOTION_US_TADZREULI_ACTIVE"]
local unitInquisitorID = GameInfoTypes["UNIT_INQUISITOR"]
local unitMissionaryID = GameInfoTypes["UNIT_MISSIONARY"]
local unitTadzeuliID = GameInfoTypes["UNIT_US_TADZREULI"]
--------------------------------------------------------------------------------------------------------------------------
-- GEORGIA (TAMAR)
--------------------------------------------------------------------------------------------------------------------------
--JFD_Georgia_PlayerDoTurn
local buildingGeorgia2ID = GameInfoTypes["BUILDING_US_GEORGIA_2"]
local buildingClassCourthouseID = GameInfoTypes["BUILDINGCLASS_COURTHOUSE"]
local policyDecisions1ID = GameInfoTypes["POLICY_DECISIONS_US_GEORGIA_1"]
local policyDecisions2ID = GameInfoTypes["POLICY_DECISIONS_US_GEORGIA_2"]
function JFD_Georgia_PlayerDoTurn(playerID)
	local player = Players[playerID]
	if (not Player_HasTrait(player, traitGeorgiaID)) then return end
	if (not player:IsAlive()) then return end
	
	for unit in player:Units() do
		local plot = unit:GetPlot()
		
		if Plot_IsWithinDistanceOfImprovement(plot, improvementCitadelID, 3)  then
			unit:ChangeMoves(60)
		end

		if (unit:GetUnitType() == unitMissionaryID or unit:GetUnitType() == unitInquisitorID) then
			if Unit_IsWithinDistanceOfUnit(plot, unitTadzeuliID, 3) then
				unit:ChangeMoves(60)
			end
		end

		if unit:GetUnitType() == unitTadzeuliID then
			if Unit_IsWithinDistanceOfUnit(plot, unitInquisitorID, 1) or Unit_IsWithinDistanceOfUnit(plot, unitMissionaryID, 1) then
				unit:SetHasPromotion(promotionTadzeuliActiveID, true)
				unit:SetHasPromotion(promotionTadzeuliID, false)
			else
				unit:SetHasPromotion(promotionTadzeuliActiveID, false)
				unit:SetHasPromotion(promotionTadzeuliID, true)
			end	
		end
	end

	for city in player:Cities() do
		local plot = Map.GetPlot(city:GetX(), city:GetY())
		if city:IsHasBuilding(buildingTsikheID) then
			if Plot_IsWithinDistanceOfImprovement(plot, improvementHolySiteID, 3) or Plot_IsWithinDistanceOfImprovement(plot, improvementCitadelID, 3) or Plot_IsWithinDistanceOfMountains(plot, 3) then
				player:ChangeCombatExperience(1)
			end
		end

		if player:HasPolicy(policyDecisions2ID) then
			local plot = Map.GetPlot(city:GetX(), city:GetY())
			if Plot_IsWithinDistanceOfMountains(plot, 2) then
				city:SetNumRealBuilding(buildingGeorgia2ID, 1)
			end
		end
				
		if player:HasPolicy(policyDecisions1ID) and (not isCPActive) then
			local numCourthouses = player:GetBuildingClassCount(buildingClassCourthouseID)
			player:ChangeCombatExperience(numCourthouses)
		end
	end
end
GameEvents.PlayerDoTurn.Add(JFD_Georgia_PlayerDoTurn)
--------------------------------------------------------------------------------------------------------------------------
--JFD_Georgia_BuildFinished
function JFD_Georgia_BuildFinished(playerID, plotX, plotY, improvementID)
	local player = Players[playerID]
	if (not Player_HasTrait(player, traitGeorgiaID)) then return end
	if (not player:IsAlive()) then return end
	if improvementID ~= improvementFortID then return end
	
	local isAdjacentCondition = false
	local plot = Map.GetPlot(plotX, plotY)
	if plot then
		if Plot_IsWithinDistanceOfImprovement(plot, improvementHolySiteID, 1) or Plot_IsWithinDistanceOfImprovement(plot, improvementCitadelID, 1) or Plot_IsWithinDistanceOfMountains(plot, 1) then
			plot:SetImprovementType(improvementGeorgiaFortID)
		end
	end
end
GameEvents.BuildFinished.Add(JFD_Georgia_BuildFinished)
--------------------------------------------------------------------------------------------------------------------------
-- TADZREULI
--------------------------------------------------------------------------------------------------------------------------
function C15_FloatingTextOnPlot(iX, iY, sString) -- Code's basically Suk's fwiw or maybe Jifford's like who fuckin nose by this point
    local pHexPos = ToHexFromGrid{x=iX, y=iY}
    local pWorldPos = HexToWorld(pHexPos)
    Events.AddPopupTextEvent(pWorldPos, sString)
end

local iUU = GameInfoTypes["UNIT_US_TADZREULI"]

function C15_FaithOnPromotion(playerID, unitID, promotionID)
	local pPlayer = Players[playerID]
	local pUnit = pPlayer:GetUnitByID(unitID)
	if pUnit:GetUnitType() == iUU then
		local iFaith = pUnit:GetLevel() * math.max(pPlayer:GetTotalFaithPerTurn(), 1)
		pPlayer:ChangeFaith(iFaith)
		if pPlayer:IsHuman() then
			C15_FloatingTextOnPlot(pUnit:GetX(), pUnit:GetY(), Locale.ConvertTextKey("[COLOR_WHITE]+{1_Faith} [ICON_Peace][ENDCOLOR]", iFaith))
		end
	end
end

GameEvents.UnitPromoted.Add(C15_FaithOnPromotion)
--------------------------------------------------------------------------------------------------------------------------
-- TSIKHE
--------------------------------------------------------------------------------------------------------------------------
--JFD_Georgia_CityConstructed
function JFD_Georgia_CityConstructed(playerID, cityID, buildingID)
	local player = Players[playerID]
	if buildingID ~= buildingTsikheID then return end

	local city = player:GetCityByID(cityID)
	local plot = Map.GetPlot(city:GetX(), city:GetY())

	plot:SetImprovementType(improvementCitadelID)
end
GameEvents.CityConstructed.Add(JFD_Georgia_CityConstructed)
--==========================================================================================================================
--==========================================================================================================================