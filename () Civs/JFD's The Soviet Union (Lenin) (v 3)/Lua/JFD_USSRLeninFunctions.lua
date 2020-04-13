-- Leninist Russia Functions
-- Author: JFD
-- DateCreated: 4/19/2014 1:40:04 PM
--=======================================================================================================================
-- UTILITY FUNCTIONS
--=======================================================================================================================
-- JFD_IsCivilisationActive
------------------------------------------------------------------------------------------------------------------------
function JFD_IsCivilisationActive(civilisationID)
	for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local slotStatus = PreGame.GetSlotStatus(iSlot)
		if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
			if PreGame.GetCivilization(iSlot) == civilisationID then
				return true
			end
		end
	end

	return false
end
--==========================================================================================================================
-- CORE FUNCTIONS
--==========================================================================================================================
-- Globals
--------------------------------------------------------------------------------------------------------------------------
local civilisationID		= GameInfoTypes["CIVILIZATION_JFD_USSR_LENIN"]
local isUSSRLeninCivActive	= JFD_IsCivilisationActive(civilisationID)
local mathFloor				= math.floor
local mathMin				= math.min

if isUSSRLeninCivActive then
	print("Lenin guy is in this game sadly. Hide your children")
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_LeninCommissariatSocialism
--------------------------------------------------------------------------------------------------------------------------
local buildingCommissariatID		= GameInfoTypes["BUILDING_JFD_LENIN_COMMISSARIAT"]
local buildingCommissariatStorageID	= GameInfoTypes["BUILDING_JFD_LENIN_FOOD"]
local yieldProductionID				= GameInfoTypes["YIELD_PRODUCTION"]

function JFD_LeninCommissariatSocialism(playerID)
	local player = Players[playerID]
    if (player:IsAlive() and player:GetCivilizationType() == civilisationID) then 
		for city in player:Cities() do
			if city:IsHasBuilding(buildingCommissariatID) then
				local cityProduction = mathFloor(city:GetYieldRate(yieldProductionID) / 2)
				city:SetNumRealBuilding(buildingCommissariatStorageID, mathMin(15, cityProduction))
			else
				if city:IsHasBuilding(buildingCommissariatStorageID) then
					city:SetNumRealBuilding(buildingCommissariatStorageID, 0)
				end
			end
		end
	end
end

if isUSSRLeninCivActive then
	GameEvents.PlayerDoTurn.Add(JFD_LeninCommissariatSocialism)
end
--==========================================================================================================================
--==========================================================================================================================