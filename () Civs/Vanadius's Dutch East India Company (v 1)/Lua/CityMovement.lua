-- Lua Script1
-- Author: Vanadius
-- DateCreated: 8/11/2019 12:35:46 PM
--------------------------------------------------------------

-- Disclaimer: I have a very limited knowledge of lua


include("PlotIterators")

-------------------------------------------------------------------------------------------------------------------------
-- EastIndiaman: Gold from Trade Routes
-------------------------------------------------------------------------------------------------------------------------
local iEastIndiaman = GameInfoTypes.UNIT_VANA_EASTINDIAMAN

function EastIndiamanRouteHighlight(iPlayer, iUnitID)

	Events.ClearHexHighlightStyle("GroupBorder")
	if iUnitID == -1 then return end	

	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnitID)

	if not(pUnit) then return end
	if pUnit:GetUnitType() ~= iEastIndiaman then
		return
	end

	local pPlot = pUnit:GetPlot()
	for pAdjacentPlot in PlotAreaSweepIterator(pPlot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
		
		local tTradeRoutes = pPlayer:GetInternationalTradeRoutePlotToolTip(pAdjacentPlot);
		local bIsRoute = #tTradeRoutes > 0

		if bIsRoute then
			local iX = pAdjacentPlot:GetX()
			local iY = pAdjacentPlot:GetY()	

		end
	end
end
Events.UnitSelectionChanged.Add(EastIndiamanRouteHighlight)

--=======================================================================================================================
--=======================================================================================================================

print ("Ndongo - Ndongo UU code ")

include("IconSupport.lua")
include( "FLuaVector" );

local gRiverT = {}
local gRiverC = 0;
local hRiverT = {}
local tCoast = GameInfoTypes.TERRAIN_COAST;
local activePlayer = Game.GetActivePlayer();
local activeTeam = Game.GetActiveTeam();
local shadowT = {}
local VIT = {}
local RVIT = {}
local ValidD = {}
local dLand = GameInfoTypes.DOMAIN_LAND;
local dSea = GameInfoTypes.DOMAIN_SEA;
ValidD[dLand] = true;
ValidD[dSea] = true;
FakeInterFaceOn = false;
local hTab = {GameInfoTypes.PROMOTION_VANA_EASTINDIAMAN_BONUS};
local pBase = GameInfoTypes.PROMOTION_VANA_EASTINDIAMAN;



-- River Detection

Events.SequenceGameInitComplete.Add(function()
	for i = 0, Map:GetNumPlots() - 1, 1 do
		local fPlot = Map.GetPlotByIndex( i );
		if fPlot:IsRiver() then
			MakeRiverT(fPlot)
		end
	end
	hRiverT = nil;
end) --- River stuff


function MakeRiverT(iPlot)
	if iPlot:IsNEOfRiver() then
		if not hRiverT[iPlot:GetPlotIndex() .. "x3"] then
			hRiverT[iPlot:GetPlotIndex() .. "x3"] = 1;
			gRiverC = gRiverC + 1;
			gRiverT[gRiverC] = {}
			gRiverT[gRiverC][iPlot] = 1;
			MakeRiverNE(Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), 4), Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), 3), iPlot, gRiverC)
		end
	end
	if iPlot:IsNWOfRiver() then
		if not hRiverT[iPlot:GetPlotIndex() .. "x2"] then
			hRiverT[iPlot:GetPlotIndex() .. "x2"] = 1;
			gRiverC = gRiverC + 1;
			gRiverT[gRiverC] = {}
			gRiverT[gRiverC][iPlot] = 1;
			MakeRiverNW(Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), 3), Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), 1), iPlot, gRiverC)
		end
	end
	if iPlot:IsWOfRiver() then		
		if not hRiverT[iPlot:GetPlotIndex() .. "x1"] then
			hRiverT[iPlot:GetPlotIndex() .. "x1"] = 1;
			gRiverC = gRiverC + 1;
			gRiverT[gRiverC] = {}
			gRiverT[gRiverC][iPlot] = 1;
			MakeRiverW(Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), 1), Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), 0), iPlot, gRiverC)
		end
	end
end

function MakeRiverW(iPlot, sPlot, dPlot, riverID)
	if iPlot then
		gRiverT[riverID][iPlot] = 1;
		if not hRiverT[iPlot:GetPlotIndex() .. "x3"] then
			hRiverT[iPlot:GetPlotIndex() .. "x3"] = 1;
			if iPlot:IsNEOfRiver() then
				MakeRiverNE(Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), 4), Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), 3), iPlot, riverID)
			end
		end
	end
	if sPlot then
		if not (sPlot:IsNEOfRiver() or sPlot:IsNWOfRiver()) then
			if sPlot:GetTerrainType() == tCoast then
				gRiverT[riverID][sPlot] = 1;
			end
		else
			if not hRiverT[sPlot:GetPlotIndex() .. "x2"] then
				hRiverT[sPlot:GetPlotIndex() .. "x2"] = 1;
				if sPlot:IsNWOfRiver() then
					gRiverT[riverID][sPlot] = 1;
					MakeRiverNW(Map.PlotDirection(sPlot:GetX(), sPlot:GetY(), 3), Map.PlotDirection(sPlot:GetX(), sPlot:GetY(), 1), sPlot, riverID)
				end
			end
			if not hRiverT[sPlot:GetPlotIndex() .. "x3"] then
				hRiverT[sPlot:GetPlotIndex() .. "x3"] = 1;
				if sPlot:IsNEOfRiver() then
					gRiverT[riverID][sPlot] = 1;
					MakeRiverNE(Map.PlotDirection(sPlot:GetX(), sPlot:GetY(), 4), Map.PlotDirection(sPlot:GetX(), sPlot:GetY(), 3), sPlot, riverID)
				end
			end
		end
	end
	if dPlot:IsNWOfRiver() then
		if not hRiverT[dPlot:GetPlotIndex() .. "x2"] then
			hRiverT[dPlot:GetPlotIndex() .. "x2"] = 1;
			MakeRiverNW(Map.PlotDirection(dPlot:GetX(), dPlot:GetY(), 3), Map.PlotDirection(dPlot:GetX(), dPlot:GetY(), 1), dPlot, gRiverC)
		end
	end
	local lPlot = Map.PlotDirection(dPlot:GetX(), dPlot:GetY(), 2)
	if lPlot:GetTerrainType() == tCoast then
		gRiverT[riverID][lPlot] = 1;
	end
end

function MakeRiverNE(iPlot, sPlot, dPlot, riverID)
	if iPlot then
		if not (iPlot:IsWOfRiver() or iPlot:IsNWOfRiver()) then
			if iPlot:GetTerrainType() == tCoast then
				gRiverT[riverID][iPlot] = 1;
			end
		else
			if not hRiverT[iPlot:GetPlotIndex() .. "x1"] then
				hRiverT[iPlot:GetPlotIndex() .. "x1"] = 1;
				if iPlot:IsWOfRiver() then
					gRiverT[riverID][iPlot] = 1;
					MakeRiverW(Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), 1), Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), 0), iPlot, riverID)
				end
			end
			if not hRiverT[iPlot:GetPlotIndex() .. "x2"] then
				hRiverT[iPlot:GetPlotIndex() .. "x2"] = 1;
				if iPlot:IsNWOfRiver() then
					gRiverT[riverID][iPlot] = 1;
					MakeRiverNW(Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), 3), Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), 1), iPlot, riverID)
				end
			end
		end
	end
	if sPlot then
		gRiverT[riverID][sPlot] = 1;
		if not hRiverT[sPlot:GetPlotIndex() .. "x1"] then
			hRiverT[sPlot:GetPlotIndex() .. "x1"] = 1;
			if sPlot:IsWOfRiver() then
				MakeRiverW(Map.PlotDirection(sPlot:GetX(), sPlot:GetY(), 1), Map.PlotDirection(sPlot:GetX(), sPlot:GetY(), 0), sPlot, riverID)
			end
		end
	end
	if dPlot:IsNWOfRiver() then
		if not hRiverT[dPlot:GetPlotIndex() .. "x2"] then
			hRiverT[dPlot:GetPlotIndex() .. "x2"] = 1;
			MakeRiverNW(Map.PlotDirection(dPlot:GetX(), dPlot:GetY(), 3), Map.PlotDirection(dPlot:GetX(), dPlot:GetY(), 1), dPlot, gRiverC)
		end
	end
	local lPlot = Map.PlotDirection(dPlot:GetX(), dPlot:GetY(), 2)
	if lPlot:GetTerrainType() == tCoast then
		gRiverT[riverID][lPlot] = 1;
	end
end

function MakeRiverNW(iPlot, sPlot, dPlot, riverID)
	if iPlot then
		if not hRiverT[iPlot:GetPlotIndex() .. "x1"] then
			hRiverT[iPlot:GetPlotIndex() .. "x1"] = 1;
			if iPlot:IsWOfRiver() then
				gRiverT[riverID][iPlot] = 1;
				MakeRiverW(Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), 1), Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), 0), iPlot, riverID)
			end
		end
		if iPlot:GetTerrainType() == tCoast then
			gRiverT[riverID][iPlot] = 1;
		end
	end
	if sPlot then
		if not hRiverT[sPlot:GetPlotIndex() .. "x3"] then
			hRiverT[sPlot:GetPlotIndex() .. "x3"] = 3;
			if sPlot:IsNEOfRiver() then
				gRiverT[riverID][sPlot] = 1;
				MakeRiverNE(Map.PlotDirection(sPlot:GetX(), sPlot:GetY(), 4), Map.PlotDirection(sPlot:GetX(), sPlot:GetY(), 3), sPlot, riverID)
			end
		end
		if sPlot:GetTerrainType() == tCoast then
			gRiverT[riverID][sPlot] = 1;
		end
	end
	if dPlot:IsNEOfRiver() then
		if not hRiverT[dPlot:GetPlotIndex() .. "x3"] then
			hRiverT[dPlot:GetPlotIndex() .. "x3"] = 1;
			MakeRiverNE(Map.PlotDirection(dPlot:GetX(), dPlot:GetY(), 4), Map.PlotDirection(dPlot:GetX(), dPlot:GetY(), 3), dPlot, gRiverC)
		end
	end
	if dPlot:IsWOfRiver() then
		if not hRiverT[dPlot:GetPlotIndex() .. "x1"] then
			hRiverT[dPlot:GetPlotIndex() .. "x1"] = 1;
			MakeRiverW(Map.PlotDirection(dPlot:GetX(), dPlot:GetY(), 1), Map.PlotDirection(dPlot:GetX(), dPlot:GetY(), 0), dPlot, gRiverC)
		end
	end
	local lPlot = Map.PlotDirection(dPlot:GetX(), dPlot:GetY(), 2);
	if lPlot then
		gRiverT[riverID][lPlot] = 1;
	end
end

function GetRiverT(i)
	return gRiverT[i];
end

-- Is the Plot a River




--Unit

function GetValidProm(iUnit)
	for i, prom in pairs(hTab) do
		if iUnit:IsHasPromotion(prom) then
			return math.min(i + 1, 2);
		end
	end
	return 1;
end

--Events.AIProcessingEndedForPlayer.Add(function(iPlayer)
GameEvents.PlayerDoTurn.Add(function(iPlayer)
	for iUnit in Players[iPlayer]:Units() do
		if iUnit:IsHasPromotion(pBase) then
			local type = GetValidProm(iUnit);
			for i, prom in pairs(hTab) do
				iUnit:SetHasPromotion(prom, i == type);
			end
		end
	end
end)

GameEvents.PlayerDoTurn.Add(ButtonStuffDoTurn)
Events.UnitSelectionChanged.Add( Selection )
GameEvents.UnitSetXY.Add(WalkingHet)
MyB:RegisterCallback(Mouse.eLClick, MyButtonFunction )
IconHookup(0, 45, "NDONGO_LS_ACTION_ATLAS", Controls.MyImage45 )
IconHookup(0, 64, "NDONGO_LS_ACTION_ATLAS", Controls.MyImage64 )
ContextPtr:SetInputHandler( InputHandler );
MyB:LocalizeAndSetToolTip("[COLOR_POSITIVE_TEXT]Rivercraft[ENDCOLOR][NEWLINE][NEWLINE]Can use Rivers to quick-travel.[NEWLINE][NEWLINE]This action costs 1 movement point.")
