WARN_NOT_SHARED = true; include( "SaveUtils" ); MY_MOD_NAME = "CBRX_Wonders_Paro";
include("PlotIterators.lua")

local yFaith = GameInfoTypes.YIELD_FAITH;
local yCulture = GameInfoTypes.YIELD_CULTURE;
local wonder = GameInfoTypes.BUILDING_TAKTSANG

function findOwner(ownerId, cityId, buildingType, bGold, bFaithOrCulture)
	local player 
	print(buildingType)
	if (wonder == buildingType) then
		save("ParoTaktsang_owner", ownerId)
		save("ParoTaktsang_Plot", Players[ownerId]:GetCityByID(cityId):Plot())
		print("Saved owner of Paro Taktsang wonder, it's: " .. ownerId)
	end
end
GameEvents.CityConstructed.Add(findOwner)

function updateOwner(iOldOwner, bIsCapital, iX, iY, iNewOwner, iPop, bConquest)
	if Map.GetPlot(iX, iY) == load("ParoTaktsang_Plot") then
		
	end
end
GameEvents.CityCaptureComplete.Add(updateOwner)


function isUpdateNeeded(iPlayer)
	if not iPlayer == load("ParoTaktsang_owner") then return end
	local player = Players[iPlayer]
	local numPlotsLastTurn = load("ParoTaktsang_plots") or 0
	if player:GetNumPlots() ~= numPlotsLastTurn then
		print("Found some new plots, time to run an update")
		for city in player:Cities() do
			for loopPlot in PlotAreaSpiralIterator(city:Plot(), 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
				if loopPlot:IsMountain() then
					Game.SetPlotExtraYield(loopPlot:GetX(), loopPlot:GetY(), yFaith, 1)
					Game.SetPlotExtraYield(loopPlot:GetX(), loopPlot:GetY(), yCulture, 1)
				end
			end
		end
	end
	save("ParoTaktsang_plots", player:GetNumPlots())
end
GameEvents.PlayerDoTurn.Add(isUpdateNeeded)

print("Paro Taktsang Mountain Code (+1 culture and +1 faith on mountains) - CBRX Wonder Pack")