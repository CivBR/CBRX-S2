-- JFD_GreatBritain_Functions
-- Author: JFD
-- DateCreated: 6/23/2014 2:36:23 PM
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
include("FLuaVector.lua")
include("PlotIterators.lua")
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
-- MOD CHECKS
--------------------------------------------------------------------------------------------------------------------------
-- JFD_GetRandom
function JFD_GetRandom(lower, upper)
    return Game.Rand((upper + 1) - lower, "") + lower
end

-- JFD_IsCivilisationActive
function JFD_IsCivilisationActive(civilizationID)
	for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local slotStatus = PreGame.GetSlotStatus(iSlot)
		if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
			if PreGame.GetCivilization(iSlot) == civilizationID then
				return true
			end
		end
	end
	return false
end

-- JFD_IsUsingCPDLL
function JFD_IsUsingCPDLL()
	local cPDLLID = "d1b6328c-ff44-4b0d-aad7-c657f83610cd"
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if (mod.ID == cPDLLID) then
			return true
		end
	end
	return false
end
local isUsingCPDLL = JFD_IsUsingCPDLL()
--------------------------------------------------------------------------------------------------------------------------
-- UTILS
--------------------------------------------------------------------------------------------------------------------------
-- JFD_CountNumDOFs
function JFD_CountNumDOFS(playerID)
	local player = Players[playerID]
	local playerTeam = Teams[player:GetTeam()]
	local numDOFs = 0
	for otherPlayerID = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local otherPlayer = Players[otherPlayerID]
		if (otherPlayerID ~= playerID and otherPlayer:IsAlive()) then
			if (playerTeam:IsHasMet(otherPlayer:GetTeam()) and otherPlayer:IsDoF(playerID)) then
				numDOFs = numDOFs + 1
			end
		end
	end
	return numDOFs
end
--==========================================================================================================================
-- GLOBALS
--==========================================================================================================================
-- GLOBALS
----------------------------------------------------------------------------------------------------------------------------
local activePlayerID		= Game.GetActivePlayer()
local activePlayer			= Players[activePlayerID]
local civilizationID 		= GameInfoTypes["CIVILIZATION_CL_NIGERIA"]
local isNigeriaCivActive = JFD_IsCivilisationActive(civilizationID)
local mathCeil 				= math.ceil
--==========================================================================================================================
-- UNIQUE FUNCTIONS
--==========================================================================================================================
-- GIANT OF AFRICA
--------------------------------------------------------------------------------------------------------------------------
-- CL_Nigeria_GiantOfAfrica
function CL_Nigeria_GiantOfAfrica(plotX, plotY, oldPop, newPop)
	if newPop > oldPop then
		local city = Map.GetPlot(plotX, plotY):GetPlotCity()
		if not city then return end
		local player = Players[city:GetOwner()]
		if (player:IsAlive() and player:GetCivilizationType() == civilizationID) then
			local reward = newPop
			player:ChangeFaith(newPop)
			city:ChangeFood(newPop)
			if player:IsHuman() then
				local hex = ToHexFromGrid(Vector2(plotX, plotY))
				Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR] [ICON_FOOD] [COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR] [ICON_PEACE]", newPop), true)
			end
		end		
	end 	
end
if isNigeriaCivActive then
	GameEvents.SetPopulation.Add(CL_Nigeria_GiantOfAfrica)
end

-- CL_Nigeria_MarshOil
local featureMarshID = GameInfoTypes["FEATURE_MARSH"]
local techBiologyID = GameInfoTypes["TECH_BIOLOGY"]
local resourceOils = GameInfoTypes["RESOURCE_OIL"]
function CL_Nigeria_MarshOil(teamID, techID)
	local playerID = Teams[teamID]:GetLeaderID()
	local player = Players[playerID]
	if techID == techBiologyID then
		if (player:IsAlive() and player:GetCivilizationType() == civilizationID) then
			for city in player:Cities() do
				for adjacentPlot in PlotAreaSweepIterator(city:Plot(), 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
					if adjacentPlot:GetOwner() == playerID then
						if (adjacentPlot:GetFeatureType() == featureMarshID and adjacentPlot:GetResourceType() == -1 and JFD_GetRandom(1,10) >= 5) then
							adjacentPlot:SetResourceType(resourceOils, JFD_GetRandom(1,5))
						end
					end
				end						
			end
		end
	end
end

-- CL_Nigeria_MarshOilTurn
function CL_Nigeria_MarshOilTurn(playerID)
	local player = Players[playerID]
	if Teams[player:GetTeam()]:IsHasTech(techBiologyID) then
		if (player:IsAlive() and player:GetCivilizationType() == civilizationID) then
			for city in player:Cities() do
				for adjacentPlot in PlotAreaSweepIterator(city:Plot(), 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
					if adjacentPlot:GetOwner() == playerID then
						if (adjacentPlot:GetFeatureType() == featureMarshID and adjacentPlot:GetResourceType() == -1 and JFD_GetRandom(1,10) >= 5) then
							adjacentPlot:SetResourceType(resourceOils, JFD_GetRandom(1,5))
						end
					end
				end						
			end
		end
	end
end
if isNigeriaCivActive then
	GameEvents.TeamTechResearched.Add(CL_Nigeria_MarshOil)
	GameEvents.PlayerDoTurn.Add(CL_Nigeria_MarshOilTurn)
end
--------------------------------------------------------------------------------------------------------------------------
-- UGBOELU
--------------------------------------------------------------------------------------------------------------------------
-- CL_Nigeria_Ugboelu
local promotionUgboelu1ID = GameInfoTypes["PROMOTION_CL_UGBOELU_STRENGTH_1"]
local promotionUgboelu2ID = GameInfoTypes["PROMOTION_CL_UGBOELU_STRENGTH_2"]
local promotionUgboelu3ID = GameInfoTypes["PROMOTION_CL_UGBOELU_STRENGTH_3"]
local promotionUgboelu4ID = GameInfoTypes["PROMOTION_CL_UGBOELU_STRENGTH_4"]
local promotionUgboelu5ID = GameInfoTypes["PROMOTION_CL_UGBOELU_STRENGTH_5"]
local ugboeluPromotions = {promotionUgboelu1ID, promotionUgboelu2ID, promotionUgboelu3ID, promotionUgboelu4ID, promotionUgboelu5ID}
local unitUgboeluID = GameInfoTypes["UNIT_CL_UGBOELU"]
function CL_Nigeria_Ugboelu(playerID)
	local player = Players[playerID]
	if (player:IsAlive() and (not player:IsMinorCiv()) and (not player:IsBarbarian())) then
		for unit in player:Units() do
			if unit:GetUnitType() == unitUgboeluID then
				local numDOFs = JFD_CountNumDOFS(playerID)
				local promotionToGiveID = GameInfoTypes["PROMOTION_CL_UGBOELU_STRENGTH_" .. numDOFs]
				if (not unit:IsHasPromotion(promotionToGiveID)) then
					unit:SetHasPromotion(promotionToGiveID, true)
				end
				for _, promotionID in pairs(ugboeluPromotions) do
					if (promotionID ~= promotionToGiveID and unit:IsHasPromotion(promotionID)) then
						unit:SetHasPromotion(promotionID, false)
					end
				end
			end
		end
	end
end
if isNigeriaCivActive then
	GameEvents.PlayerDoTurn.Add(CL_Nigeria_Ugboelu)
end
--------------------------------------------------------------------------------------------------------------------------
-- UGBOELU
--------------------------------------------------------------------------------------------------------------------------
-- CL_Nigeria_Ugboelu
local buildingYanLifidaID = GameInfoTypes["BUILDING_CL_YAN_LIFIDA"]
local promotionKanajejiID = GameInfoTypes["PROMOTION_CL_KANAJEJI"]
function CL_Nigeria_YanLifida(playerID)
	local player = Players[playerID]
	if (player:IsAlive() and (not player:IsMinorCiv()) and (not player:IsBarbarian())) then
		for city in player:Cities() do
			local cityGarrison = city:GetGarrisonedUnit()
			if cityGarrison then
				if cityGarrison:IsHasPromotion(promotionKanajejiID) then
					local numLevels = cityGarrison:GetLevel()
					city:SetNumRealBuilding(buildingYanLifidaID, numLevels)
				else
					if city:IsHasBuilding(buildingYanLifidaID) then
						city:SetNumRealBuilding(buildingYanLifidaID, 0)
					end
				end
			end
		end
	end
end
if isNigeriaCivActive then
	GameEvents.PlayerDoTurn.Add(CL_Nigeria_YanLifida)
end
--==========================================================================================================================
--==========================================================================================================================