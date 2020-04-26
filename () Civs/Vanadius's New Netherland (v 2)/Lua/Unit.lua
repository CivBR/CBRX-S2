-- Lua Script2
-- Author: Vanadius
-- DateCreated: 12/28/2019 12:40:51 PM
--------------------------------------------------------------

local iCiv = GameInfoTypes["CIVILIZATION_VANA_NEWNETHERLAND"]
local iDutchMilita = GameInfoTypes["UNIT_VANA_SCHUTTERIJ"]
local iDutchMilitaClass = GameInfoTypes[GameInfo.Units[iDutchMilita].Class]
local iArtistSpecialist = GameInfoTypes["SPECIALIST_ARTIST"]
local iPromotion = GameInfoTypes.PROMOTION_SCHUTTERIJDEFENSE
local iImprovement = GameInfoTypes.IMPROVEMENT_FORT



function NNUnit(iPlayer, iUnitID)
	if iPlayer < GameDefines.MAX_MAJOR_CIVS then
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnitID)
		if pUnit:GetUnitType() == iDutchMilita then
		local pPlot = pUnit:GetPlot()
			if pPlot:GetImprovementType() == iImprovement or pPlot:GetPlotCity() then
			pUnit:SetHasPromotion(iPromotion, true)
			return
		end
	end
	pUnit:SetHasPromotion(iPromotion, false)
	end
end



GameEvents.UnitSetXY.Add(NNUnit)


----------------------------------------------------------------------------------------------------------------------------
-- DMS_GetNearestCity
----------------------------------------------------------------------------------------------------------------------------
function DMS_GetNearestCity(pPlayer, plotX, plotY)
	local iDistance = nil
	local pTargetCity = pPlayer:GetCapitalCity()
	for pCity in pPlayer:Cities() do
		if not(iDistance) or iDistance > Map.PlotDistance(plotX, plotY, pCity:GetX(), pCity:GetY()) then
			pTargetCity = pCity
			iDistance = Map.PlotDistance(plotX, plotY, pCity:GetX(), pCity:GetY())
		end
	end
	return(pTargetCity)
end


-- All of this wrong?? 

local iArtistPointModUnit = 1

function Vana_GiveArtistPoints(pPlayer, iLocalMod, sText, iMult)
	if not iMult then iMult = 1 end
	local pCity = DMS_GetNearestCity(pPlayer)
	local iPointsToGive = 1
	pCity:ChangeSpecialistGreatPersonProgressTimes100(iArtistSpecialist, iPointsToGive * 100)
end


function Vana_NewN_DoTurn(playerID)
	local pPlayer = Players[playerID]
	if pPlayer:IsAlive() then
		if pPlayer:GetUnitClassCount(iDutchMilitaClass) > 0 then
			for pUnit in pPlayer:Units() do
				if pUnit:GetUnitType() == iDutchMilita then
					local pPlot = pUnit:GetPlot()
					if pPlot:GetImprovementType() == iImprovement or pPlot:GetPlotCity() then
						Vana_GiveArtistPoints(pPlayer, iArtistPointModUnit)
					end
				end
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(Vana_NewN_DoTurn)