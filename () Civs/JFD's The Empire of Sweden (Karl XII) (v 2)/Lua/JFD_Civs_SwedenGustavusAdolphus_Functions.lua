-- JFD_Civs_SwedenGustavusAdolphus_Functions
-- Author: JFD
-- DateCreated: 2/15/2014 6:33:36 PM
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
------------------------------------------------------------------------------------------------------------------------
include("FLuaVector.lua")
include("PlotIterators.lua")
--==========================================================================================================================
-- GLOBALS
--==========================================================================================================================
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
--==========================================================================================================================
-- UTILITIES
--==========================================================================================================================
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
------------------------------------------------------------------------------------------------------------------------
--Game_IsSwedenGustavusAdolphusActive
function Game_IsSwedenGustavusAdolphusActive()
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if mod.ID == "75896769-83cd-4769-9d39-72229eb422e6" then
			return true
		end
	end
	return false
end
local g_IsSwedenGustavusAdolphusActive = Game_IsSwedenGustavusAdolphusActive()
if g_IsSwedenGustavusAdolphusActive then return end
------------------------------------------------------------------------------------------------------------------------
--Player_GetStrongestMilitaryUnit (Sukritact)
function Player_GetStrongestMilitaryUnit(pPlayer, bIgnoreResources, ...)
	local tUnit = {["ID"] = GameInfoTypes.UNIT_WARRIOR, ["Combat"] = 0}
	for iKey, sCombatType in pairs(arg) do
		for row in GameInfo.Units("CombatClass = \'" .. sCombatType .. "\'") do
			if pPlayer:CanTrain(row.ID, bIgnoreResources) and row.Combat > tUnit.Combat then
				tUnit = row
			end
		end
	end
	return tUnit.ID
end
--==========================================================================================================================
-- GAME DEFINES
--==========================================================================================================================
------------------------------------------------------------------------------------------------------------------------
local defineMaxMajorCivs = GameDefines["MAX_MAJOR_CIVS"]
--==========================================================================================================================
-- UNIQUE FUNCTIONS
--==========================================================================================================================
------------------------------------------------------------------------------------------------------------------------
-- GLOBALS
------------------------------------------------------------------------------------------------------------------------
local unitRegalShipID = GameInfoTypes["UNIT_JFD_REGAL_SHIP"]
------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
------------------------------------------------------------------------------------------------------------------------
--JFD_SwedenGustavusAdolphus_PlayerDoTurn
local domainLandID = GameInfoTypes["DOMAIN_LAND"]
local promotionRegalShipID = GameInfoTypes["PROMOTION_JFD_REGAL_SHIP_1"]
local function JFD_SwedenGustavusAdolphus_PlayerDoTurn(playerID)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if player:IsMinorCiv() then return end
	if player:IsBarbarian() then return end

	--UNIQUE UNIT
	for unit in player:Units() do
		if (unit:GetDamage() > 0 and unit:GetDomainType() == domainLandID) then
			local isRegalShipNearby = false
			if g_IsCPActive then
				if unit:IsWithinDistanceOfUnitPromotion(unitPromotionRegalShipID, 2, true, false) then
					unit:ChangeDamage(-10)	
				end
			else
				local unitPlot = unit:GetPlot()
				if unitPlot then
					for loopPlot in PlotAreaSpiralIterator(unitPlot, 2, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
						local loopUnit = player:GetUnitByID(loopPlot:GetUnit())
						if loopUnit then
							if (loopUnit:GetOwner() == playerID and loopUnit:IsHasPromotion(unitPromotionRegalShipID)) then
								unit:ChangeDamage(-10)	
								break
							end
						end
					end
				end 
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(JFD_SwedenGustavusAdolphus_PlayerDoTurn)
--=======================================================================================================================
--=======================================================================================================================
