-- Gaul_Metalsmith
-- Author: Sukritact
--=======================================================================================================================

print("loaded")

--=======================================================================================================================
-- Initial Defines
--=======================================================================================================================
local iMetalsmith 		= GameInfoTypes.BUILDING_MC_GAUL_METALSMITH
local iMetalsmithDummy 	= GameInfoTypes.BUILDING_MC_GAUL_GOLD
local iMine 			= GameInfoTypes.IMPROVEMENT_MINE
--=======================================================================================================================
-- Core Functions: Gaul Metalsmith
--=======================================================================================================================
-- MineCheck
-------------------------------------------------------------------------------------------------------------------------
function MineCheck(pCity)

	local iNumMines = 0

	for iPlot = 0, pCity:GetNumCityPlots() - 1, 1 do
		local pAdjacentPlot = pCity:GetCityIndexPlot(iPlot)
		if (pAdjacentPlot:GetImprovementType() == iMine) and (pAdjacentPlot:IsBeingWorked()) then
			iNumMines = iNumMines + 1
		end
	end
	
	return iNumMines
end
-------------------------------------------------------------------------------------------------------------------------
-- ResetMetalsmith
-------------------------------------------------------------------------------------------------------------------------
function ResetMetalsmith(pCity)
	pCity:SetNumRealBuilding(iMetalsmithDummy, 0)
	if pCity:IsHasBuilding(iMetalsmith) then
		pCity:SetNumRealBuilding(iMetalsmithDummy, MineCheck(pCity))
	end
end
-------------------------------------------------------------------------------------------------------------------------
-- PlayerDoTurn_ResetMetalsmith
-------------------------------------------------------------------------------------------------------------------------
function PlayerDoTurn_ResetMetalsmith(iPlayer)
	local pPlayer = Players[iPlayer]
	if ((pPlayer:CountNumBuildings(iMetalsmith) + pPlayer:CountNumBuildings(iMetalsmithDummy)) < 1)  then return end
	
	for pCity in pPlayer:Cities() do
		ResetMetalsmith(pCity)
	end
end
GameEvents.PlayerDoTurn.Add(PlayerDoTurn_ResetMetalsmith)
-------------------------------------------------------------------------------------------------------------------------
-- SerialEventCityInfoDirty_ResetMetalsmith
-------------------------------------------------------------------------------------------------------------------------
function SerialEventCityInfoDirty_ResetMetalsmith()
	local iPlayer = Game.GetActivePlayer()
	local pPlayer = Players[iPlayer]
	if not(pPlayer:IsTurnActive()) then	return end
	if ((pPlayer:CountNumBuildings(iMetalsmith) + pPlayer:CountNumBuildings(iMetalsmithDummy)) < 1)  then return end
	
	for pCity in pPlayer:Cities() do
		ResetMetalsmith(pCity)
	end
end
Events.SerialEventCityInfoDirty.Add(SerialEventCityInfoDirty_ResetMetalsmith)
--=======================================================================================================================
--=======================================================================================================================