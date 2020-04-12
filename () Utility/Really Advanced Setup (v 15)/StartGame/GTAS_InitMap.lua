
-- GTAS_InitMap - Part of Really Advanced Setup Mod

-- This initializes map related stuff when the game starts.

include("GTAS_Constants");
include("GTAS_DataManager");
include("GTAS_PlaceTerrain");
include("GTAS_PlaceFeatures");
include("GTAS_PlaceWonders");
include("GTAS_PlaceResources");

-- Load Mod data from database and get data handlers.
LoadData();
local buffer = {};
LuaEvents.GetDataObjects(buffer);
SlotData = buffer[DATA_SLOT];
MapData = buffer[DATA_MAP];
GameData = buffer[DATA_GAME];

function InitMap()
	print("InitMap --------------------------------------------------------------------");

	DisableOtherWonders();

	PlaceTerrain();
	
	ValidateMapTerrain();

	PlaceFeatures();

	PlaceWonders();

	PlaceResources();

	ValidateMapTerrain(); -- This shouldn't be needed. But just in case something went wrong when placing the other items...
end

-------------------------------------------------
function ValidateMapTerrain()
	local timer = os.clock();

	-- If ocean type terrain is next to land then game crashes - so change it to coast type terrain.
	for i = 0, Map.GetNumPlots() - 1, 1 do
		local plot = Map.GetPlotByIndex(i);
		if plot:GetTerrainType() == TerrainTypes.TERRAIN_OCEAN then
			if plot:IsAdjacentToLand() then
				plot:SetTerrainType(TerrainTypes.TERRAIN_COAST, false, true);
			end
		end
	end

	Map.RecalculateAreas();

	-- print("\n");
	-- print(string.format("(Really Advanced Setup) - ValidateMapTerrain   Elapsed Time: %s", ElapsedTime(timer)));
	-- print("\n");
end

-- Remove Wonders created outside of this mod if they are disabled.
-------------------------------------------------
function DisableOtherWonders()
	if MapData.disableAllNaturalWonders or MapData.removeOriginalWonders then
		-- print("Disable Other Natural Wonders -----------------------------------------------------");

		for i = 0, Map.GetNumPlots() - 1, 1 do
			local plot = Map.GetPlotByIndex(i);
			local feature = GameInfo.Features[plot:GetFeatureType()];

			if feature and feature.NaturalWonder then
				-- print(string.format("%s Wonder removed at(%i, %i) ", feature.Type, plot:GetX(), plot:GetY()));
				plot:SetFeatureType(FeatureTypes.NO_FEATURE);
			end
		end
	end
end

















