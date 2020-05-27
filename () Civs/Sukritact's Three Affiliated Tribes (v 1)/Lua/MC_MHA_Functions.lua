-- MC_MHA_Functions
-- Author: Sukritact
--=======================================================================================================================

include("PlotIterators.lua")
print("Loaded")

--=======================================================================================================================
-- Utility Functions
--=======================================================================================================================
-- JFD_IsCivilisationActive
--------------------------------------------------------------
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
--------------------------------------------------------------
-- GetNumWorkedImprovement
--------------------------------------------------------------
function GetNumWorkedImprovement(pCity, iImprovement)
	local iWorked = 0

	for pAdjacentPlot in PlotAreaSweepIterator(pCity:Plot(), 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
		if (pAdjacentPlot:GetImprovementType() == iImprovement) and (pAdjacentPlot:IsBeingWorked()) then
			iWorked = iWorked + 1
		end
	end
	
	return iWorked
end
--------------------------------------------------------------
-- GetNumTradeRoutes
--------------------------------------------------------------
function GetTradeRoutesWithCity(pCity)
	local iPlayer = pCity:GetOwner()
	local pPlayer = Players[iPlayer]

	local tTradeRoutes = {}

	tTradeRoutes = pPlayer:GetTradeRoutes()
	for i,v in ipairs(pPlayer:GetTradeRoutesToYou()) do
		table.insert(tTradeRoutes, v)
	end

	local tFinalRoute = {}

	for iKey, tRoute in ipairs(tTradeRoutes) do
		if (tRoute.ToCity == pCity) or (tRoute.FromCity == pCity) then
			table.insert(tFinalRoute, tRoute)
		end
	end	

	return tFinalRoute
end
--------------------------------------------------------------
-- GetAtWarPlayers
--------------------------------------------------------------
function GetAtWarPlayers(iPlayer)
	local tAtWar = {}
	local pPlayer = Players[iPlayer]
	local pTeam = Teams[pPlayer:GetTeam()]

	for iOtherPlayer, pOtherPlayer in pairs(Players) do
		if pOtherPlayer:IsEverAlive() then

			local iOtherTeam = pOtherPlayer:GetTeam()
			tAtWar[iOtherPlayer] = pTeam:IsAtWar(iOtherTeam)

		end
	end

	return tAtWar
end
--==========================================================================================================================
-- CORE FUNCTIONS
--==========================================================================================================================
--Globals
----------------------------------------------------------------------------------------------------------------------------
local iCiv					= GameInfoTypes.CIVILIZATION_MC_MHA
local bIsCivActive			= JFD_IsCivilisationActive(iCiv)

local iFarm					= GameInfoTypes.IMPROVEMENT_FARM
local tFarmDummies = {
	GameInfoTypes.BUILDING_MC_MHA_UA_1,
	GameInfoTypes.BUILDING_MC_MHA_UA_2,
	GameInfoTypes.BUILDING_MC_MHA_UA_3,
	GameInfoTypes.BUILDING_MC_MHA_UA_4,
	GameInfoTypes.BUILDING_MC_MHA_UA_5,
	GameInfoTypes.BUILDING_MC_MHA_UA_6,
	GameInfoTypes.BUILDING_MC_MHA_UA_7,
	GameInfoTypes.BUILDING_MC_MHA_UA_8,
	GameInfoTypes.BUILDING_MC_MHA_UA_9,
	GameInfoTypes.BUILDING_MC_MHA_UA_10,
}
----------------------------------------------------------------------------------------------------------------------------
-- BUFFALO BIRD WOMAN'S GARDEN
----------------------------------------------------------------------------------------------------------------------------
-- MHA_WorkedFarmBonus
--------------------------------------------------------------
function MHA_WorkedFarmBonus(pCity)
	local iNum = GetNumWorkedImprovement(pCity, iFarm)

	for iKey, iBuilding in ipairs(tFarmDummies) do
		if iKey > iNum then
			pCity:SetNumRealBuilding(iBuilding, 0)
		else
			pCity:SetNumRealBuilding(iBuilding, 1)
		end
	end

	LuaEvents.MHA_WorkedFarmBonus()
end
--------------------------------------------------------------
-- PlayerDoTurn_MHA_WorkedFarmBonus
--------------------------------------------------------------
function PlayerDoTurn_MHA_WorkedFarmBonus(iPlayer)
	local pPlayer = Players[iPlayer]

	if not(pPlayer:IsAlive()) then return end
	if not(pPlayer:GetCivilizationType() == iCiv) then return end
	
	for pCity in pPlayer:Cities() do
		MHA_WorkedFarmBonus(pCity)
	end
end
if bIsCivActive then GameEvents.PlayerDoTurn.Add(PlayerDoTurn_MHA_WorkedFarmBonus) end
--------------------------------------------------------------
-- SerialEventCityInfoDirty_MHA_WorkedFarmBonus
--------------------------------------------------------------
function SerialEventCityInfoDirty_MHA_WorkedFarmBonus()
	local iPlayer = Game.GetActivePlayer()
	local pPlayer = Players[iPlayer]
	if not(pPlayer:IsTurnActive()) then	return end
	if not(pPlayer:IsAlive()) then return end
	if not(pPlayer:GetCivilizationType() == iCiv) then return end
	
	for pCity in pPlayer:Cities() do
		MHA_WorkedFarmBonus(pCity)
	end
end
if bIsCivActive then Events.SerialEventCityInfoDirty.Add(SerialEventCityInfoDirty_MHA_WorkedFarmBonus) end
----------------------------------------------------------------------------------------------------------------------------
-- EARTH LODGE
----------------------------------------------------------------------------------------------------------------------------
-- Globals
----------------------------------------------------------------------------------------------------------------------------
local iEarthLodge =			GameInfoTypes.BUILDING_MC_EARTHLODGE
local iEarthLodgeDummy =	GameInfoTypes.BUILDING_MC_EARTHLODGE_EFFECT
--------------------------------------------------------------	
-- MHA_EarthLodgeBonus
--------------------------------------------------------------
function MHA_EarthLodgeBonus(pCity)
	if not pCity:IsHasBuilding(iEarthLodge) then
		pCity:SetNumRealBuilding(iEarthLodgeDummy, 0)
		return
	end

	local tTradeRoutes = GetTradeRoutesWithCity(pCity)
	pCity:SetNumRealBuilding(iEarthLodgeDummy, #tTradeRoutes)
end
--------------------------------------------------------------
-- PlayerDoTurn_MHA_EarthLodgeBonus
--------------------------------------------------------------
function PlayerDoTurn_MHA_EarthLodgeBonus(iPlayer)
	local pPlayer = Players[iPlayer]
	if ((pPlayer:CountNumBuildings(iEarthLodge) + pPlayer:CountNumBuildings(iEarthLodgeDummy)) < 1)  then return end
	
	for pCity in pPlayer:Cities() do
		MHA_EarthLodgeBonus(pCity)
	end
end
if bIsCivActive then GameEvents.PlayerDoTurn.Add(PlayerDoTurn_MHA_EarthLodgeBonus) end
----------------------------------------------------------------------------------------------------------------------------
-- BLACK MOUTH
----------------------------------------------------------------------------------------------------------------------------
local iPromotion = GameInfoTypes.PROMOTION_MC_BLACKMOUTH

function PlayerDoTurn_BlackMouth(iPlayer)
	local pPlayer = Players[iPlayer]
	if not(pPlayer:IsAlive()) then return end

	local tAtWar = GetAtWarPlayers(iPlayer)
	
	for pUnit in pPlayer:Units() do
		if pUnit:IsHasPromotion(iPromotion) then
			if pUnit:GetFortifyTurns() > 0 then

				local pPlot = pUnit:GetPlot()
				for pAdjacentPlot in PlotAreaSweepIterator(pPlot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
					if pAdjacentPlot then
						local iNumUnits = pAdjacentPlot:GetNumUnits()
						for iVal = 0,(iNumUnits - 1) do

							local pUnit = pAdjacentPlot:GetUnit(iVal)
							local iOwner = pUnit:GetOwner()

							if tAtWar[iOwner] then
								pUnit:ChangeDamage(10, iPlayer)
							end
						end
					end
				end

			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(PlayerDoTurn_BlackMouth)
--==========================================================================================================================
--==========================================================================================================================