
-- GTAS_PlaceFeatures - Part of Really Advanced Setup Mod

include("FLuaVector") -- For debugging.

include("GTAS_Constants");
include("GTAS_Utilities");
include("GTAS_FeatureTypes");
include("GTAS_DataManager");
include("GTAS_PlotPlacement");

-- Load Mod data from database and get data handlers.
LoadData();
local buffer = {};
LuaEvents.GetDataObjects(buffer);
local SlotData = buffer[DATA_SLOT];
local MapData = buffer[DATA_MAP];
local GameData = buffer[DATA_GAME];

----------------------------------------------------------------------------------------
function PlaceFeatures()
	-- print("\n");
	-- print("PlaceFeatures +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
	
	ShowFeatureCount();
	
	-- print("\n");
	-- print("PLACE PLAYER BASED FEATURES  ---------------------------------------------------------------------------------------------------");
	for playerID, slot in SlotData:SlotList() do
		player = Players[playerID];
		if player and player:IsEverAlive() then
			if player:GetStartingPlot() ~= nil then
				for _, featureSlot in slot:FeatureList() do
					-- print(string.format("Place Features Slot (%s),  Type = (%s) -------------------", player:GetName(), featureSlot.featureType));
					PlaceFeatureSlot(player, featureSlot);
				end
			end
		end
	end

	ShowFeatureCount();

	-- print("\n");
	-- print("PLACE MAP BASED FEATURES ---------------------------------------------------------------------------------------------------");
	for _, featureSlot in MapData:FeatureList() do
		-- print(string.format("Place Features Slot (Map Placement),  Type = (%s) -------------------", featureSlot.featureType));
		PlaceFeatureSlot(nil, featureSlot);
	end

	ShowFeatureCount();
end

----------------------------------------------------------------------------------------
function PlaceFeatureSlot(player, featureSlot)
	local timer = os.clock(); -- Debug !!!!!
	local feature = GameInfo.Features[featureSlot.featureType];	

	if feature ~= nil then
		local count = featureSlot.count;

		-- Cycle thru the plots and try to place the feature.
		for plot in GetFeaturePlotList(player, featureSlot) do
			if CanPlaceFeature(plot, feature, featureSlot.replaceFeature) then
				-- -- print(string.format("(%s) Feature Placed at (%i,%i)   count = %i", feature.Type, plot:GetX(), plot:GetY(), count));
				plot:SetFeatureType(feature.ID);
				placementActive = true;

				if featureSlot.placementType ~= FILL_PLACEMENT then
					count = count - 1;
					if count < 1 then
						break; -- We are done - lets get out of here.
					end
				end
			end
		end
	end

	-- Debug !!!!!
	-- print("\n");
	-- print(string.format("(PlaceFeatureSlot)  Elapsed Time: %s ---------------------------------------------------", ElapsedTime(timer)));
	-- print("\n");
end

----------------------------------------------------------------------------------------
function GetFeaturePlotList(player, featureSlot)
	if player ~= nil then
		return GetAreaPlotList(player:GetStartingPlot(), featureSlot.minDistance, featureSlot.maxDistance, featureSlot.placementType);
	else
		return GetMapPlotList(FEATURE_BORDER_X, FEATURE_BORDER_Y);
	end
end

----------------------------------------------------------------------------------------
function CanPlaceFeature(plot, feature, replaceFeature)
	if feature == nil then
		return false;
	end

	_, height = Map.GetGridSize();
	if plot:GetY() < FEATURE_BORDER_Y or plot:GetY() >= (height - FEATURE_BORDER_Y) then
		return false;
	end

	if plot:IsStartingPlot() then
		return false;
	end

	if feature.Type == "FEATURE_FALLOUT" then
		if replaceFeature or plot:GetFeatureType() == FeatureTypes.NO_FEATURE then
			if plot:GetPlotType() ~= PlotTypes.PLOT_OCEAN then
				if not plot:IsMountain() and not plot:IsImpassable() then
					return true;
				end
			end
		end
		
		return false;
	
	elseif feature.Type == "FEATURE_ATOLL" then
		if plot:IsLake() then
			return false;
		end
		
		return plot:CanHaveFeature(feature.ID);
	
	elseif not replaceFeature then
		return plot:CanHaveFeature(feature.ID);

	else
		if plot:IsMountain() then
			return false;
		end

		local terrainNotValid = true;
		local terrain = GameInfo.Terrains[plot:GetTerrainType()];
		
		if terrain ~= nil then
			for row in GameInfo.Feature_TerrainBooleans{FeatureType = feature.Type} do
				if row.TerrainType == terrain.Type then
					terrainNotValid = false;
				end
			end
		end
	
		if terrainNotValid then
			return false;
		end

		if feature.NoCoast and plot:IsCoastalLand() then
			return false;
		end
			
		if feature.NoRiver and plot:IsRiver() then
			return false;
		end

		if feature.RequiresRiver and not plot:IsRiver() then
			return false;
		end
		
		if feature.RequiresFlatlands and plot:IsHills() then
			return false;
		end

		local plotFeature = GameInfo.Features[plot:GetFeatureType()];

		if plotFeature ~= nil then
			if plotFeature.Type == feature.Type or plotFeature.NaturalWonder then
				return false;
			end
		end

		if feature.NoAdjacent then
			for direction in GetDirectionList() do
				local adjPlot = Map.PlotDirection(plot:GetX(), plot:GetY(), direction);
				
				if adjPlot ~= nil then
					local plotFeature = GameInfo.Features[adjPlot:GetFeatureType()];
					
					if plotFeature ~= nil and plotFeature.Type == feature.Type then
						return false;
					end
				end
			end
		end

		return true;
	end
end
	
----------------------------------------------------------------------------------------
function ShowFeatureCount()
	-- print("\n");
	-- print("Map: Features -----------------------------------------------------------------------------------");

	local counts = {};

	for i = 0, Map.GetNumPlots() - 1, 1 do
		local feature = GameInfo.Features[Map.GetPlotByIndex(i):GetFeatureType()];
		
		if feature ~= nil and IsFeature(feature) then
			counts[feature.Type] = (counts[feature.Type] or 0) + 1;
		end
	end

	local totalCount = 0;

	for featureType, count in GetListByKeys(counts) do
		totalCount = totalCount + count;
		-- print(string.format("(%s)  count: %i", featureType, count));
	end

	-- print(string.format("Total Plots: (%i)", totalCount));
	-- print("\n");
end

	




	