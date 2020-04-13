-- JFD_TwoSicilies_Functions
-- Author: JFD
-- DateCreated: 5/4/2014 12:54:31 AM
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
-- MOD CHECKS
--------------------------------------------------------------------------------------------------------------------------
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
--------------------------------------------------------------------------------------------------------------------------
-- UTILS
--------------------------------------------------------------------------------------------------------------------------
-- GetStrongestMilitaryUnit (Sukritact)
function GetStrongestMilitaryUnit(pPlayer, bIgnoreResources, ...)
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
--==========================================================================================================================
-- UNIQUE FUNCTIONS
--==========================================================================================================================
-- GLOBALS
----------------------------------------------------------------------------------------------------------------------------
local civilizationID 		  = GameInfoTypes["CIVILIZATION_JFD_TWO_SICILIES"]
local isTwoSiciliesCivActive  = JFD_IsCivilisationActive(civilizationID)
local mathCeil 				  = math.ceil
local mathFloor 			  = math.floor
if isTwoSiciliesCivActive then
	print("King Ferdinand I is in this game")
end
--------------------------------------------------------------------------------------------------------------------------
-- PRIDE OF BOURBON SICILY
--------------------------------------------------------------------------------------------------------------------------
-- JFD_TwoSicilies_CargoPurchases
local unitCargoShipID = GameInfoTypes["UNIT_CARGO_SHIP"]
function JFD_TwoSicilies_CargoPurchases(playerID, cityID, unitID, isGold, isFaith)
	local player = Players[playerID]
	if (player:IsAlive() and player:GetCivilizationType() == civilizationID) then
		local unit = player:GetUnitByID(unitID)
		if unit:GetUnitType() == unitCargoShipID then
			local navalUnitID = GetStrongestMilitaryUnit(player, false, "UNITCOMBAT_NAVALMELEE", "UNITCOMBAT_NAVALRANGED")
			if navalUnitID then
				local city = player:GetCityByID(cityID)
				player:InitUnit(navalUnitID, city:GetX(), city:GetY())
			end
		end
	end
end
if isTwoSiciliesCivActive then
	GameEvents.CityTrained.Add(JFD_TwoSicilies_CargoPurchases)
end

-- JFD_TwoSicilies_FreeUpgrades
local domainSeaID = GameInfoTypes["DOMAIN_SEA"]
function JFD_TwoSicilies_FreeUpgrades(teamID, techID)
	local playerID = Teams[teamID]:GetLeaderID()
	local player = Players[playerID]
	if (player:IsAlive() and player:GetCivilizationType() == civilizationID) then
		for unit in player:Units() do
			if unit:GetDomainType() == domainSeaID then 
				local unitUpgradeID = unit:GetUpgradeUnitType()
				if unitUpgradeID then
					if player:CanTrain(unitUpgradeID, true) then
						if isUsingCPDLL then
							unit:Upgrade(unit, true)
						else
							local newUnit = player:InitUnit(unitUpgradeID, unit:GetX(), unit:GetY())
							newUnit:Convert(unit)
						end
					end
				end
			end
		end
	end
end
if isTwoSiciliesCivActive then
	GameEvents.TeamTechResearched.Add(JFD_TwoSicilies_FreeUpgrades)
end
--=======================================================================================================================
--=======================================================================================================================
