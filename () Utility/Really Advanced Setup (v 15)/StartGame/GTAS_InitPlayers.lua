
-- GTAS_InitPlayers - Part of Really Advanced Setup Mod

-- This sets things up for all players when the game starts.

include("GTAS_Constants");
include("GTAS_DataManager");
include("GTAS_Utilities");
include("GTAS_RouteConnections");
include("GTAS_PlaceNonCityUnits");

-- Load Mod data from database and get data handlers.
LoadData();
local buffer = {};
LuaEvents.GetDataObjects(buffer);
local SlotData = buffer[DATA_SLOT];
local MapData = buffer[DATA_MAP];
local GameData = buffer[DATA_GAME];


-----------------------------------------------------------------------
function InitPlayers()
	print("InitPlayers --------------------------------------------------------------------");
	PlaceNonCityUnits();
	IncreaseVisibility();
end

-- Update the starting visibility for each player.
-----------------------------------------------------------------------
function IncreaseVisibility()
	local revealedTeams = { };
	for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
		local player = Players[i];		
		if player and player:IsEverAlive() and player:IsAlive() then
			local teamID = player:GetTeam();
			if MapData.startingVisibility == -1 then
				local teamRevealed = false;
				for _, id in ipairs(revealedTeams) do
					if id == teamID then
						teamRevealed = true;
						break;
					end
				end
				if not teamRevealed then
					table.insert(revealedTeams, teamID);
					for i = 0, Map.GetNumPlots() - 1, 1 do
						Map.GetPlotByIndex(i):SetRevealed(teamID, true);
					end
				end
			else
				local startPlot = player:GetStartingPlot();			
				if startPlot ~= nil then
					for plot in GTAS_PlotAreaSpiralIterator(startPlot, 2, MapData.startingVisibility, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS) do
						plot:SetRevealed(teamID, true);
					end
				end
			end
		end		
	end
	Map.UpdateDeferredFog();
end













