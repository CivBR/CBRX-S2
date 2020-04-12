
-- GTAS_PlaceResources - Part of Really Advanced Setup Mod

include("FLuaVector") -- For debugging.

include("GTAS_Constants");
include("GTAS_Utilities");
include("GTAS_DataManager");
include("GTAS_PlotPlacement");
include("GTAS_ResourceTypes");

LoadData();
local buffer = {};
LuaEvents.GetDataObjects(buffer);
local SlotData = buffer[DATA_SLOT];
local MapData = buffer[DATA_MAP];
local GameData = buffer[DATA_GAME];

local MapPlots;

----------------------------------------------------------------------------------------
function PlaceResources()
	-- print("\n");
	-- print("PlaceResources +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");

	ShowResourceCount();

	-- print("\n");
	-- print("PLACE PLAYER BASED RESOURCES ------------------------------------------------------------------------");
	for playerID, slot in SlotData:SlotList() do
		player = Players[playerID];
		if player and player:IsEverAlive() then
			if player:GetStartingPlot() ~= nil then
				for _, resourceSlot in slot:ResourceList() do
					-- print(string.format("Place Resource Slot (%s),  Type = (%s) -------------------", player:GetName(), resourceSlot.resourceType));
					PlaceResourceSlot(player, resourceSlot);
				end
			end
		end
	end

	ShowResourceCount();

	-- print("\n");
	-- print("PLACE MAP BASED RESOURCES ---------------------------------------------------------------------------");
	for _, resourceSlot in MapData:ResourceList() do
		-- print(string.format("Place Resource Slot (Map Placement),  Type = (%s) -------------------", resourceSlot.resourceType));
		PlaceResourceSlot(nil, resourceSlot);
	end

	ShowResourceCount();
end

----------------------------------------------------------------------------------------
function PlaceResourceSlot(player, resourceSlot)
	local timer = os.clock(); -- Debug !!!!!
	local isMultipleTypes;
	local resources = {};
	local count = resourceSlot.count;
	local placementActive = count > 0;

	if GameInfo.Resources[resourceSlot.resourceType] ~= nil then
		isMultipleTypes = false;
		resources = { GameInfo.Resources[resourceSlot.resourceType], };
	else
		isMultipleTypes = true;
		resources = GetResourceTable(resourceSlot.resourceType);
	end

	ShuffleTable(resources);
	-- print("Shuffle resources:  length = ", #resources);
	MapPlots = nil;
	
	while placementActive do
		placementActive = false; -- Placement is over by default - a resource will need to be placed to stay active.

		for index = #resources, 1, -1 do
			local resource = resources[index];
			local removeResource = true;
			local repeatCount = 0;

			-- Cycle thru the plots and try to place the current resource type.
			for plot in GetResourcePlotList(player, resourceSlot) do
				if CanPlaceResource(plot, resource, resourceSlot.relaxedRules) then
					-- print(string.format("(%s) Resource Placed at (%i,%i)   count = %i", resource.Type, plot:GetX(), plot:GetY(), count));
					plot:SetResourceType(resource.ID, GetResourceQuanity(resourceSlot.resourceType));
					placementActive = true;
					removeResource = false;

					if resourceSlot.placementType ~= FILL_PLACEMENT then
						count = count - 1;
						if count < 1 then
							placementActive = false; -- Maximum count reached - time to leave.
							break; -- We are done - lets get out of here.
						end
					end

					if isMultipleTypes and #resources == 1 then
						repeatCount = repeatCount + 1; -- There was a list but now we are down to one type and it's repeating.
						if repeatCount >= 3 then
							-- print(string.format("Last Resource type has repeated: %i times. Exiting this slot!!!", repeatCount));
							placementActive = false; -- The last item in the list has repeated enough - time to leave.
							break; -- We are done - lets get out of here.
						end
					end

					if #resources > 1 then
						break; -- More than one resource type available - skip to the next one.
					end
				end
			end

			if removeResource then
				-- print("Resource removed from list:  ", resource.Type);
				table.remove(resources, index); -- Tried every plot and this type wasn't placed - remove it from the list.
			end

			if count < 1 then
				break; -- We are done - lets get out of here.
			end
		end

		if not isMultipleTypes then
			placementActive = false; -- Since there is only one type for this slot we only need one pass thru the plots - so we are done.
		end
	end

	-- Debug !!!!!
	-- print("\n");
	-- print(string.format("(PlaceResourceSlot)  Elapsed Time: %s ---------------------------------------------------", ElapsedTime(timer)));
	-- print("\n");
end

----------------------------------------------------------------------------------------
function GetResourcePlotList(player, resourceSlot)
	if player == nil then
		if MapPlots == nil then
			MapPlots = GetMapPlotTable(RESOURCE_BORDER_X, RESOURCE_BORDER_Y);
			ShuffleTable(MapPlots);
		end
		return GetList(MapPlots);
	else
		return GetAreaPlotList(player:GetStartingPlot(), resourceSlot.minDistance, resourceSlot.maxDistance, resourceSlot.placementType)
	end
end

----------------------------------------------------------------------------------------
function CanPlaceResource(plot, resource, relaxedRules)
	if resource == nil then
		return false;
	end

	_, height = Map.GetGridSize();
	if plot:GetY() < RESOURCE_BORDER_Y or plot:GetY() >= (height - RESOURCE_BORDER_Y) then
		return false;
	end

	if plot:IsStartingPlot() then
		return false;
	end

	if not relaxedRules then
		return plot:CanHaveResource(resource.ID, false);

	else
		if plot:GetResourceType() ~= -1 then
			return false;
		end

		if plot:IsMountain() then
			return false;
		end

		if plot:GetTerrainType() == TerrainTypes.TERRAIN_SNOW then
			return false;
		end

		local feature = GameInfo.Features[plot:GetFeatureType()];

		if feature ~= nil and feature.NaturalWonder then
			return false;
		end

		local latitude = plot:GetLatitude();
		
		if latitude > resource.MaxLatitude then
			return false;
		end
		
		if latitude < resource.MinLatitude then
			return false;
		end
		
		-- Check if target resource and the plot are both the same (either land or water) ----------------------------------------
		local noTerrainBooleans = true;

		for row in GameInfo.Resource_TerrainBooleans{ResourceType = resource.Type} do
			noTerrainBooleans = false;

			if row.TerrainType == "TERRAIN_HILL" then
				if not plot:IsWater() then
					return true; -- The target resource needs a hill (i.e. land) and the plot is not water - good enough for relaxed rules.
				end

			else
				local terrain = GameInfo.Terrains[row.TerrainType];
				
				if terrain ~= nil and terrain.Water == plot:IsWater() then
					return true; -- The target resource and the plot are both the same - good enough for relaxed rules.
				end
			end

			break;
		end

		if noTerrainBooleans and not plot:IsWater() then
			return true; -- The plot is land and there are no terrain booleans - good enough for relaxed rules.
		end
	end

	return false;
end

----------------------------------------------------------------------------------------
function ShowResourceCount()
	-- print("\n");
	-- print("Map: Resources -----------------------------------------------------------------------------------");

	local counts = {};

	for i = 0, Map.GetNumPlots() - 1, 1 do
		local resource = GameInfo.Resources[Map.GetPlotByIndex(i):GetResourceType()];
		
		if resource ~= nil then
			counts[resource.Type] = (counts[resource.Type] or 0) + 1;
		end
	end

	local totalCount = 0;

	for resourceType, count in GetListByKeys(counts) do
		totalCount = totalCount + count;
		-- print(string.format("(%s)  count: %i", resourceType, count));
	end

	-- print(string.format("Total Resources: (%i)", totalCount));
	-- print("\n");
end





























