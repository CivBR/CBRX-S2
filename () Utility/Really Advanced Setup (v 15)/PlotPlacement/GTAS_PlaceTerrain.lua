
-- GTAS_PlaceTerrain - Part of Really Advanced Setup Mod

include("FLuaVector") -- For debugging.

include("GTAS_Constants");
include("GTAS_Utilities");
include("GTAS_DataManager");
include("GTAS_TerrainTypes");
include("GTAS_PlotPlacement");

-- Load Mod data from database and get data handlers.
LoadData();
local buffer = {};
LuaEvents.GetDataObjects(buffer);
local SlotData = buffer[DATA_SLOT];
local MapData = buffer[DATA_MAP];
local GameData = buffer[DATA_GAME];
local GlobalData = buffer[DATA_GLOBAL];

local LandElevationTypes = { ELEVATION_MOUNTAIN, ELEVATION_HILLS, ELEVATION_FLAT };

----------------------------------------------------------------------------------------
function PlaceTerrain()
	-- print("\n");
	-- print("PlaceTerrain +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");

	ShowTerrainCount();

	-- print("\n");
	-- print("PLACE PLAYER BASED TERRAIN  ---------------------------------------------------------------------------------------------------");
	for playerID, slot in SlotData:SlotList() do
		player = Players[playerID];
		if player and player:IsEverAlive() then
			if player:GetStartingPlot() ~= nil then
				for _, terrainSlot in slot:TerrainList() do
					-- print(string.format("Place Terrain Slot (%s),  Type = (%s) -------------------", player:GetName(), terrainSlot.terrainType));
					PlaceTerrainSlot(player, terrainSlot);
				end
			end
		end
	end

	ShowTerrainCount();

	-- print("\n");
	-- print("PLACE MAP BASED TERRAIN ---------------------------------------------------------------------------------------------------");
	for _, terrainSlot in MapData:TerrainList() do
		-- print(string.format("Place Terrain Slot (Map Placement),  Type = (%s) -------------------", terrainSlot.terrainType));
		PlaceTerrainSlot(nil, terrainSlot);
	end

	ShowTerrainCount();
end

function PlaceTerrainSlot(player, terrainSlot)
	local timer = os.clock(); -- Debug !!!!!
	local terrain = GameInfo.Terrains[terrainSlot.terrainType];

	if terrain ~= nil then
		local count = terrainSlot.count;

		-- Cycle thru the plots and try to place the current terrain type.
		for plot in GetTerrainPlotList(player, terrainSlot) do
			if CanPlaceTerrain(plot, terrain, terrainSlot.elevation, terrainSlot.changeWaterLand) then
				-- print(string.format("(%s) Terrain Placed at (%i,%i)   count = %i", terrain.Type, plot:GetX(), plot:GetY(), count));
				SetTerrain(plot, terrain, terrainSlot.elevation)

				if terrainSlot.placementType ~= FILL_PLACEMENT then
					count = count - 1;
					if count < 1 then
						placementActive = false;
						break; -- We are done - lets get out of here.
					end
				end
			end
		end
	end

	-- Debug !!!!!
	-- print("\n");
	-- print(string.format("(PlaceTerrainSlot)  Elapsed Time: %s ---------------------------------------------------", ElapsedTime(timer)));
	-- print("\n");
end

----------------------------------------------------------------------------------------
function GetTerrainPlotList(player, terrainSlot)
	if player ~= nil then
		return GetAreaPlotList(player:GetStartingPlot(), terrainSlot.minDistance, terrainSlot.maxDistance, terrainSlot.placementType);
	else
		return GetMapPlotList(TERRAIN_BORDER_X, TERRAIN_BORDER_Y);
	end
end

----------------------------------------------------------------------------------------
function SetTerrain(plot, terrain, elevation)
	-- print(string.format("SetTerrain at (%i,%i)", plot:GetX(), plot:GetY()));
	if terrain.Water then
		if plot:GetPlotType() ~= PlotTypes.PLOT_OCEAN then
			plot:SetFeatureType(FeatureTypes.NO_FEATURE);
			plot:SetResourceType(-1);
		end

		plot:SetTerrainType(terrain.ID, false, true);
		plot:SetPlotType(PlotTypes.PLOT_OCEAN, false, true);

	else
		if plot:GetPlotType() == PlotTypes.PLOT_OCEAN then
			plot:SetFeatureType(FeatureTypes.NO_FEATURE)
			plot:SetResourceType(-1)
		end

		plot:SetTerrainType(terrain.ID, false, true);

		if plot:GetPlotType() == PlotTypes.PLOT_OCEAN then
			plot:SetPlotType(PlotTypes.PLOT_LAND, false, true);
		end

		if elevation ~= ELEVATION_NO_CHANGE then
			if elevation == ELEVATION_RANDOM then
				SetLandElevation(plot, LandElevationTypes[math.random(#LandElevationTypes)]);
			else
				SetLandElevation(plot, elevation);
			end
		end
	end
end

----------------------------------------------------------------------------------------
function CanPlaceTerrain(plot, terrain, elevation, changeWaterLand)
	if terrain == nil then
		return false;
	end

	_, height = Map.GetGridSize();
	if plot:GetY() < TERRAIN_BORDER_Y or plot:GetY() >= (height - TERRAIN_BORDER_Y) then
		return false;
	end

	if plot:IsStartingPlot() then
		return false;
	end

	local plotTerrain = GameInfo.Terrains[plot:GetTerrainType()];

	if plotTerrain ~= nil and plotTerrain.Type == terrain.Type then
		return false;
	end

	local feature = GameInfo.Features[plot:GetFeatureType()];

	if feature ~= nil and feature.NaturalWonder then
		return false;
	end

	local landWaterIsChanged = false;

	if terrain.Water then
		if plot:GetPlotType() ~= PlotTypes.PLOT_OCEAN then
			landWaterIsChanged = true;
		end
	else
		if plot:GetPlotType() == PlotTypes.PLOT_OCEAN then
			landWaterIsChanged = true;
		end
	end

	if landWaterIsChanged and not changeWaterLand then
		return false;
	end

	if plot:IsUnit() then
		if landWaterIsChanged or elevation == ELEVATION_MOUNTAIN then
			return false;
		end
	end

	return true;
end

function SetLandElevation(plot, elevation)
	if elevation == ELEVATION_MOUNTAIN then
		plot:SetFeatureType(FeatureTypes.NO_FEATURE)
		plot:SetResourceType(-1)
		plot:SetPlotType(PlotTypes.PLOT_MOUNTAIN, false, true);

	elseif elevation == ELEVATION_HILLS then
		plot:SetPlotType(PlotTypes.PLOT_HILLS, false, true);

	elseif elevation == ELEVATION_FLAT then
		plot:SetPlotType(PlotTypes.PLOT_LAND, false, true);
	end
end

----------------------------------------------------------------------------------------
function ShowTerrainCount()
	-- print("\n");
	-- print("Map: Terrain -----------------------------------------------------------------------------------");

	local counts = {};

	for i = 0, Map.GetNumPlots() - 1, 1 do
		local terrain = GameInfo.Terrains[Map.GetPlotByIndex(i):GetTerrainType()];
		
		if terrain ~= nil then
			counts[terrain.Type] = (counts[terrain.Type] or 0) + 1;
		end
	end

	local totalCount = 0;

	for terrainType, count in GetListByKeys(counts) do
		totalCount = totalCount + count;
		-- print(string.format("(%s)  count: %i", terrainType, count));
	end

	-- print(string.format("Total Plots: (%i)", totalCount));
	-- print("\n");
end






