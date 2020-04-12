
-- GTAS_PlaceWonders - Part of Really Advanced Setup Mod

include("MapmakerUtilities");
include("NWCustomMethods");

include("GTAS_Constants");
include("GTAS_Utilities");
include("GTAS_DataManager");
include("GTAS_PlotPlacement");
include("GTAS_Sprinkles");
include("GTAS_WonderTracker");
include("GTAS_WonderTypes");
include("GTAS_CustomNaturalWonders");

-- Load Mod data from database and get data handlers.
LoadData();
local buffer = {};
LuaEvents.GetDataObjects(buffer);
local SlotData = buffer[DATA_SLOT];
local MapData = buffer[DATA_MAP];
local GameData = buffer[DATA_GAME];
local GlobalData = buffer[DATA_GLOBAL];

local PlotIsCoastal, PlotIsNextToCoast;
local AtollFeatureID;
local MapPlots;
local AvailableWonders, AvailableMapWonders;

----------------------------------------------------------------------------------------
function PlaceWonders()
	-- print("\n");
	-- print("PlaceWonders +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");

	PlotIsCoastal, PlotIsNextToCoast = GenerateNextToCoastalLandDataTables();
	AtollFeatureID = nil;

	AvailableWonders = GetWonderTable();
	AvailableMapWonders = GetCopyOfTable(AvailableWonders);

	for feature in GameInfo.Features() do
		if feature.Type == "FEATURE_ATOLL" then
			AtollFeatureID = feature.ID;
			break;
		end
	end

	WonderTracker:ScanMap();
	WonderTracker:DisplayWonderCount();

	if not MapData.disableAllNaturalWonders then
		-- print("\n");
		-- print("PLACE PLAYER BASED NATURAL WONDERS -------------------------------------------------------------------");
		-- print("\n");
		for playerID, slot in SlotData:SlotList() do
			player = Players[playerID];
			if player and player:IsEverAlive() then
				if player:GetStartingPlot() ~= nil then
					for _, wonderSlot in slot:WonderList() do
						-- print(string.format("Place Wonder Slot (%s),  Type = (%s) -------------------", player:GetName(), wonderSlot.featureType));
						PlaceWonderSlot(player, wonderSlot);
					end
				end
			end
		end

		WonderTracker:DisplayWonderCount();
	end

	if not MapData.disableAllNaturalWonders then
		-- print("\n");
		-- print("PLACE MAP BASED NATURAL WONDERS -------------------------------------------------------------------");
		-- print("\n");
		for _, wonderSlot in MapData:WonderList() do
			-- print(string.format("Place Wonder Slot (Map Placement),  Type = (%s) -------------------", wonderSlot.featureType));
			PlaceWonderSlot(nil, wonderSlot);
		end

		WonderTracker:DisplayWonderCount();
	end
end

----------------------------------------------------------------------------------------
function PlaceWonderSlot(player, wonderSlot)
	local timer = os.clock(); -- Debug !!!!!
	local isMultipleTypes;
	local wonders = {};
	local count = wonderSlot.count;
	local placementActive = count > 0;

	-- print("wonderSlot.featureType = ", wonderSlot.featureType);
	
	if GameInfo.Features[wonderSlot.featureType] ~= nil then
		isMultipleTypes = false;
		wonders = { GameInfo.Features[wonderSlot.featureType], };

	else
		isMultipleTypes = true;
		if wonderSlot.placementType == MAP_PLACEMENT then
			wonders = AvailableMapWonders;
			-- print("wonders = AvailableMapWonders  length = ", #wonders);
		else
			wonders = GetCopyOfTable(AvailableWonders);
			-- print("wonders = GetCopyOfTable(AvailableWonders)  length = ", #wonders);
		end
	end

	ShuffleTable(wonders);
	MapPlots = nil;

	while placementActive do
		placementActive = false; -- Placement is over by default - a wonder will need to be placed to stay active.
		
		for index = #wonders, 1, -1 do
			local featureType = wonders[index].Type;
			local placement = GetPlacement(featureType);
			
			if placement == nil then
				table.remove(wonders, index); -- Couldn't find placement data. Can't use this type - so remove it.
				UpdateAvailableMapWonders(wonderSlot, featureType);

			elseif MapData.maxWonderCopies ~= -1 and WonderTracker:GetWonderCount(featureType) >= MapData.maxWonderCopies then
				table.remove(wonders, index); -- Limit reached for this type - so remove it.
				UpdateAvailableMapWonders(wonderSlot, featureType);

			else
				local removeWonderType = true;
				local repeatCount = 0;

				-- Cycle thru the plots and try to place the current wonder type.
				for plot in GetWonderPlotList(player, wonderSlot) do
					-- print(string.format("Try to place wonder at (%i,%i)", plot:GetX(), plot:GetY()));

					if CanPlaceWonder(plot, placement, featureType) then
						-- print(string.format("(%s) Wonder Placed at (%i,%i)   count = %i", featureType, plot:GetX(), plot:GetY(), count));
						SetWonder(plot, placement, wonderSlot, featureType);
						placementActive = true;
						removeWonderType = false;

						if wonderSlot.placementType ~= FILL_PLACEMENT then
							count = count - 1;
							if count < 1 then
								placementActive = false;
								break; -- We are done - lets get out of here.
							end
						end

						if isMultipleTypes and #wonders == 1 then
							repeatCount = repeatCount + 1; -- There was a list but now we are down to one type and it's repeating.
							if repeatCount >= 3 then
								-- print(string.format("Last Wonder type has repeated: %i times. Exiting this slot!!!", repeatCount));
								placementActive = false; -- The last item in the list has repeated enough - time to leave.
								break; -- We are done - lets get out of here.
							end
						end

						if MapData.maxWonderCopies ~= -1 and WonderTracker:GetWonderCount(featureType) >= MapData.maxWonderCopies then
							removeWonderType = true; -- Limit reached for this type - so remove it.
							break; -- This type no longer available available - so skip to the next one.
						end

						if #wonders > 1 then
							break; -- More than one wonder type is available - so skip to the next one.
						end
					end
				end

				if removeWonderType then
					table.remove(wonders, index); -- Tried every plot and this type wasn't placed - remove it from the list.
					UpdateAvailableMapWonders(wonderSlot, featureType);
				end
			end

			if count < 1 then
				break; -- We are done - lets get out of here.
			end
		end

		if not isMultipleTypes then
			placementActive = false; -- Since there was only one type for this slot we only needed one pass thru the plots - so we are done.
		end
	end

	if not isMultipleTypes then
		if wonderSlot.placementType == MAP_PLACEMENT then
			AvailableMapWonders = wonders;
		end
	end

	-- Debug !!!!!
	-- print("\n");
	-- print(string.format("(PlaceWonderSlot)  Elapsed Time: %s ---------------------------------------------------", ElapsedTime(timer)));
	-- print("\n");
end

----------------------------------------------------------------------------------------
function GetWonderPlotList(player, wonderSlot)
	if player == nil then
		if MapPlots == nil then
			MapPlots = GetMapPlotTable(WONDER_BORDER_X, WONDER_BORDER_Y);
			ShuffleTable(MapPlots);
		end
		return GetList(MapPlots);
	else
		return GetAreaPlotList(player:GetStartingPlot(), wonderSlot.minDistance, wonderSlot.maxDistance, wonderSlot.placementType)
	end
end

----------------------------------------------------------------------------------------
function UpdateAvailableMapWonders(wonderSlot, featureType)
	if wonderSlot.placementType == MAP_PLACEMENT then
		for i = #AvailableMapWonders, 1 , -1 do
			if AvailableMapWonders[i].Type == featureType then
				table.remove(AvailableMapWonders, i);
				break;
			end
		end
	end
end

----------------------------------------------------------------------------------------
function GetPlacement(featureType)
	if GameInfo.Natural_Wonder_Placement ~= nil then
		for row in GameInfo.Natural_Wonder_Placement() do
			if row.NaturalWonderType == featureType then
				return GameInfo.Natural_Wonder_Placement[row.ID];
			end
		end
	end

	for row in GameInfo.GTAS_Natural_Wonder_Placement() do
		if row.NaturalWonderType == featureType then
			return GameInfo.GTAS_Natural_Wonder_Placement[row.ID];
		end
	end

	return nil;
end

----------------------------------------------------------------------------------------
-- This function assumes that plot is a valid place to put the wonder defined by featureType.
function SetWonder(plot, placement, wonderSlot, featureType)
	if CustomNaturalWonders:IsCustomWonder(featureType) then
		if CustomNaturalWonders:PlaceWonder(featureType, plot) then
			WonderTracker:AddWonder(featureType, plot);
		end

	else
		local feature = GameInfo.Features[featureType];

		if feature == nil then
			return;
		end

		if placement.ChangeCoreTileToMountain then
			if not plot:IsMountain() then
				plot:SetFeatureType(FeatureTypes.NO_FEATURE);
				plot:SetResourceType(-1);
				plot:SetPlotType(PlotTypes.PLOT_MOUNTAIN, false, true);
			end
		elseif placement.ChangeCoreTileToFlatland then
			if plot:GetPlotType() ~= PlotTypes.PLOT_LAND then
				plot:SetPlotType(PlotTypes.PLOT_LAND, false, true);
			end
		end

		if placement.ChangeCoreTileTerrainToGrass then
			if plot:GetTerrainType() ~= TerrainTypes.TERRAIN_GRASS then
				plot:SetTerrainType(TerrainTypes.TERRAIN_GRASS, false, true);
			end
		elseif placement.ChangeCoreTileTerrainToPlains then
			if plot:GetTerrainType() ~= TerrainTypes.TERRAIN_PLAINS then
				plot:SetTerrainType(TerrainTypes.TERRAIN_PLAINS, false, true);
			end
		end

		if placement.SetAdjacentTilesToShallowWater then
			for direction in GetDirectionList() do
				local adjPlot = Map.PlotDirection(plot:GetX(), plot:GetY(), direction);
				if adjPlot ~= nil and adjPlot:GetTerrainType() ~= TerrainTypes.TERRAIN_COAST then
					adjPlot:SetFeatureType(FeatureTypes.NO_FEATURE);
					adjPlot:SetResourceType(-1);
					adjPlot:SetTerrainType(TerrainTypes.TERRAIN_COAST, false, true);
				end
			end
		end

		plot:SetImprovementType(-1);
		plot:SetResourceType(-1);
		plot:SetFeatureType(feature.ID);
		WonderTracker:AddWonder(featureType, plot);
	end

	-- This handles sprinkles for both regular natural wonders and custom natural wonders.
	if wonderSlot.addSprinkles then
		Sprinkles:PlaceWonderSprinkles(plot, featureType);
	end
end

----------------------------------------------------------------------------------------
-- Returns true if it is possible to place this natural wonder on this plot.
-- Returns false if it is not possible to place this natural wonder on this plot.
-- Returns nil if this wonder type has reach the maximum number of copies available. (DISABLED?!)
function CanPlaceWonder(plot, placement, featureType)
	-- print(string.format("(%i,%i) CanPlaceWonder", plot:GetX(), plot:GetY()));

	-- Do basic checks that apply to all natural wonders --------------------------------------------------------------------------

	if plot:IsUnit() then
		return false;
	end

	-- If plot is near edge of map or near the map "seam" then do not use it.
	width, height = Map.GetGridSize();
	if plot:GetX() < WONDER_BORDER_X or plot:GetX() >= (width - WONDER_BORDER_X) then
		return false;
	end
	if plot:GetY() < WONDER_BORDER_Y or plot:GetY() >= (height - WONDER_BORDER_Y) then
		return false;
	end

	for otherPlot in GTAS_PlotAreaSpiralIterator(plot, 0, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS) do
		if otherPlot:IsStartingPlot() then
			return false;
		end

		if otherPlot:GetTerrainType() == TerrainTypes.TERRAIN_SNOW then
			return false;
		end

		local feature = GameInfo.Features[otherPlot:GetFeatureType()];	
		if feature ~= nil and feature.NaturalWonder then
			return false;
		end
	end

	-- for otherPlot in PlotRingIterator(plot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE) do
	for otherPlot in GTAS_PlotAreaSpiralIterator(plot, 2, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS) do
		local feature = GameInfo.Features[otherPlot:GetFeatureType()];
		if feature ~= nil and feature.NaturalWonder then
			return false;
		end
	end

	-- Do check for GTAS custom wonder ------------------------------------------------------------------------------------
	if CustomNaturalWonders:IsCustomWonder(featureType) then
		-- If this is a GTAS custom wonder than use its' custom function to evaluate the plot.
		return CustomNaturalWonders:CanPlaceWonder(featureType, plot);
		-- elseif
			-- Add check for "standard" Custom Natural Wonder here?
	end

	-- Do standard checks for natural wonder placement ---------------------------------------------------------------------------

	-- Fresh Water ----------
	if placement.RequireFreshWater then
		if not plot:IsFreshWater() then
			return false;
		end
	elseif placement.AvoidFreshWater then
		if plot:IsRiver() or plot:IsLake() or plot:IsFreshWater() then
			return false;
		end
	end

	-- Land or Sea ----------
	if placement.LandBased then
		if plot:IsWater() then
			if not (plot:GetTerrainType() == "TERRAIN_HILL") then
				return false;
			end
		end

		local width, _ = Map.GetGridSize();
		local plotIndex = plot:GetY() * width + plot:GetX() + 1;

		if placement.RequireLandAdjacentToOcean then
			if not PlotIsCoastal[plotIndex] then
				return false;
			end
		elseif placement.AvoidLandAdjacentToOcean then
			if PlotIsCoastal[plotIndex] then
				return false;
			end
		end
		if placement.RequireLandOnePlotInland then
			if not PlotIsNextToCoast[plotIndex] then
				return false;
			end
		elseif placement.AvoidLandOnePlotInland then
			if PlotIsNextToCoast[plotIndex] then
				return false;
			end
		end
		if placement.RequireLandTwoOrMorePlotsInland then
			if PlotIsCoastal[plotIndex] or PlotIsNextToCoast[plotIndex] then
				return false;
			end
		elseif placement.AvoidLandTwoOrMorePlotsInland then
			if not PlotIsCoastal[plotIndex] and not PlotIsNextToCoast[plotIndex] then
				return false;
			end
		end
	end

	-- Core Tile ----------
	if not placement.CoreTileCanBeAnyPlotType then
		local plotType = plot:GetPlotType()
		if plotType == PlotTypes.PLOT_LAND and placement.CoreTileCanBeFlatland then
			-- Continue
		elseif plotType == PlotTypes.PLOT_HILLS and placement.CoreTileCanBeHills then
			-- Continue
		elseif plotType == PlotTypes.PLOT_MOUNTAIN and placement.CoreTileCanBeMountain then
			-- Continue
		elseif plotType == PlotTypes.PLOT_OCEAN and placement.CoreTileCanBeOcean then
			-- Continue
		else -- Plot type does not match an eligible type, reject this plot.
			return false;
		end
	end

	if not placement.CoreTileCanBeAnyTerrainType then
		local terrainType = plot:GetTerrainType()
		if terrainType == TerrainTypes.TERRAIN_GRASS and placement.CoreTileCanBeGrass then
			-- Continue
		elseif terrainType == TerrainTypes.TERRAIN_PLAINS and placement.CoreTileCanBePlains then
			-- Continue
		elseif terrainType == TerrainTypes.TERRAIN_DESERT and placement.CoreTileCanBeDesert then
			-- Continue
		elseif terrainType == TerrainTypes.TERRAIN_TUNDRA and placement.CoreTileCanBeTundra then
			-- Continue
		elseif terrainType == TerrainTypes.TERRAIN_SNOW and placement.CoreTileCanBeSnow then
			-- Continue
		elseif terrainType == TerrainTypes.TERRAIN_COAST and placement.CoreTileCanBeShallowWater then
			-- Continue
		elseif terrainType == TerrainTypes.TERRAIN_OCEAN and placement.CoreTileCanBeDeepWater then
			-- Continue
		else -- Terrain type does not match an eligible type, reject this plot.
			return false;
		end
	end

	if not placement.CoreTileCanBeAnyFeatureType then
		local featureType = plot:GetFeatureType()
		if featureType == FeatureTypes.NO_FEATURE and placement.CoreTileCanBeNoFeature then
			-- Continue
		elseif featureType == FeatureTypes.FEATURE_FOREST and placement.CoreTileCanBeForest then
			-- Continue
		elseif featureType == FeatureTypes.FEATURE_JUNGLE and placement.CoreTileCanBeJungle then
			-- Continue
		elseif featureType == FeatureTypes.FEATURE_OASIS and placement.CoreTileCanBeOasis then
			-- Continue
		elseif featureType == FeatureTypes.FEATURE_FLOOD_PLAINS and placement.CoreTileCanBeFloodPlains then
			-- Continue
		elseif featureType == FeatureTypes.FEATURE_MARSH and placement.CoreTileCanBeMarsh then
			-- Continue
		elseif featureType == FeatureTypes.FEATURE_ICE and placement.CoreTileCanBeIce then
			-- Continue
		elseif featureType == AtollFeatureID and placement.CoreTileCanBeAtoll then
			-- Continue
		else -- Feature type does not match an eligible type, reject this plot.
			return false;
		end
	end

	-- Adjacent Tiles: Plot Types ----------
	if placement.AdjacentTilesCareAboutPlotTypes then
		local numAnyLand, numFlatland, numHills, numMountain, numHillsPlusMountains, numOcean = 0, 0, 0, 0, 0, 0;

		for direction in GetDirectionList() do
			local adjPlot = Map.PlotDirection(plot:GetX(), plot:GetY(), direction)
			if adjPlot ~= nil then
				local plotType = adjPlot:GetPlotType();

				if plotType == PlotTypes.PLOT_OCEAN then
					numOcean = numOcean + 1;
				else
					numAnyLand = numAnyLand + 1;
					if plotType == PlotTypes.PLOT_LAND then
						numFlatland = numFlatland + 1;
					else
						numHillsPlusMountains = numHillsPlusMountains + 1;
						if plotType == PlotTypes.PLOT_HILLS then
							numHills = numHills + 1;
						else
							numMountain = numMountain + 1;
						end
					end
				end
			end
		end

		if numAnyLand > 0 and placement.AdjacentTilesAvoidAnyland then
			return false;
		end

		-- Require
		if placement.AdjacentTilesRequireFlatland then
			if numFlatland < placement.RequiredNumberOfAdjacentFlatland then
				return false;
			end
		end
		if placement.AdjacentTilesRequireHills then
			if numHills < placement.RequiredNumberOfAdjacentHills then
				return false;
			end
		end
		if placement.AdjacentTilesRequireMountain then
			if numMountain < placement.RequiredNumberOfAdjacentMountain then
				return false;
			end
		end
		if placement.AdjacentTilesRequireHillsPlusMountains then
			if numHillsPlusMountains < placement.RequiredNumberOfAdjacentHillsPlusMountains then
				return false;
			end
		end
		if placement.AdjacentTilesRequireOcean then
			if numOcean < placement.RequiredNumberOfAdjacentOcean then
				return false;
			end
		end

		-- Avoid
		if placement.AdjacentTilesAvoidFlatland then
			if numFlatland > placement.MaximumAllowedAdjacentFlatland then
				return false;
			end
		end
		if placement.AdjacentTilesAvoidHills then
			if numHills > placement.MaximumAllowedAdjacentHills then
				return false;
			end
		end
		if placement.AdjacentTilesAvoidMountain then
			if numMountain > placement.MaximumAllowedAdjacentMountain then
				return false;
			end
		end
		if placement.AdjacentTilesAvoidHillsPlusMountains then
			if numHillsPlusMountains > placement.MaximumAllowedAdjacentHillsPlusMountains then
				return false;
			end
		end
		if placement.AdjacentTilesAvoidOcean then
			if numOcean > placement.MaximumAllowedAdjacentOcean then
				return false;
			end
		end
	end

	-- Adjacent Tiles: Terrain Types
	if placement.AdjacentTilesCareAboutTerrainTypes then
		local numGrass, numPlains, numDesert, numTundra, numSnow, numShallowWater, numDeepWater = 0, 0, 0, 0, 0, 0, 0;

		for direction in GetDirectionList() do
			local adjPlot = Map.PlotDirection(plot:GetX(), plot:GetY(), direction)
			if adjPlot ~= nil then
				local terrainType = adjPlot:GetTerrainType();

				if terrainType == TerrainTypes.TERRAIN_GRASS then
					numGrass = numGrass + 1;
				elseif terrainType == TerrainTypes.TERRAIN_PLAINS then
					numPlains = numPlains + 1;
				elseif terrainType == TerrainTypes.TERRAIN_DESERT then
					numDesert = numDesert + 1;
				elseif terrainType == TerrainTypes.TERRAIN_TUNDRA then
					numTundra = numTundra + 1;
				elseif terrainType == TerrainTypes.TERRAIN_SNOW then
					numSnow = numSnow + 1;
				elseif terrainType == TerrainTypes.TERRAIN_COAST then
					numShallowWater = numShallowWater + 1;
				elseif terrainType == TerrainTypes.TERRAIN_OCEAN then
					numDeepWater = numDeepWater + 1;
				end
			end
		end

		-- Require
		if placement.AdjacentTilesRequireGrass then
			if numGrass < placement.RequiredNumberOfAdjacentGrass then
				return false;
			end
		end
		if placement.AdjacentTilesRequirePlains then
			if numPlains < placement.RequiredNumberOfAdjacentPlains then
				return false;
			end
		end
		if placement.AdjacentTilesRequireDesert then
			if numDesert < placement.RequiredNumberOfAdjacentDesert then
				return false;
			end
		end
		if placement.AdjacentTilesRequireTundra then
			if numTundra < placement.RequiredNumberOfAdjacentTundra then
				return false;
			end
		end
		if placement.AdjacentTilesRequireSnow then
			if numSnow < placement.RequiredNumberOfAdjacentSnow then
				return false;
			end
		end
		if placement.AdjacentTilesRequireShallowWater then
			if numShallowWater < placement.RequiredNumberOfAdjacentShallowWater then
				return false;
			end
		end
		if placement.AdjacentTilesRequireGrass then
			if numDeepWater < placement.RequiredNumberOfAdjacentDeepWater then
				return false;
			end
		end

		-- Avoid
		if placement.AdjacentTilesAvoidGrass then
			if numGrass > placement.MaximumAllowedAdjacentGrass then
				return false;
			end
		end
		if placement.AdjacentTilesAvoidPlains then
			if numPlains > placement.MaximumAllowedAdjacentPlains then
				return false;
			end
		end
		if placement.AdjacentTilesAvoidDesert then
			if numDesert > placement.MaximumAllowedAdjacentDesert then
				return false;
			end
		end
		if placement.AdjacentTilesAvoidTundra then
			if numTundra > placement.MaximumAllowedAdjacentTundra then
				return false;
			end
		end
		if placement.AdjacentTilesAvoidSnow then
			if numSnow > placement.MaximumAllowedAdjacentSnow then
				return false;
			end
		end
		if placement.AdjacentTilesAvoidShallowWater then
			if numShallowWater > placement.MaximumAllowedAdjacentShallowWater then
				return false;
			end
		end
		if placement.AdjacentTilesAvoidDeepWater then
			if numDeepWater > placement.MaximumAllowedAdjacentDeepWater then
				return false;
			end
		end
	end

	-- Adjacent Tiles: Feature Types
	if placement.AdjacentTilesCareAboutFeatureTypes then
		local numNoFeature, numForest, numJungle, numOasis, numFloodPlains, numMarsh, numIce, numAtoll = 0, 0, 0, 0, 0, 0, 0, 0;

		for direction in GetDirectionList() do
			local adjPlot = Map.PlotDirection(plot:GetX(), plot:GetY(), direction);

			if adjPlot ~= nil then
				local featureType = adjPlot:GetFeatureType();

				if featureType == FeatureTypes.NO_FEATURE then
					numNoFeature = numNoFeature + 1;
				elseif featureType == FeatureTypes.FEATURE_FOREST then
					numForest = numForest + 1;
				elseif featureType == FeatureTypes.FEATURE_JUNGLE then
					numJungle = numJungle + 1;
				elseif featureType == FeatureTypes.FEATURE_OASIS then
					numOasis = numOasis + 1;
				elseif featureType == FeatureTypes.FEATURE_FLOOD_PLAINS then
					numFloodPlains = numFloodPlains + 1;
				elseif featureType == FeatureTypes.FEATURE_MARSH then
					numMarsh = numMarsh + 1;
				elseif featureType == FeatureTypes.FEATURE_ICE then
					numIce = numIce + 1;
				elseif featureType == AtollFeatureID then
					numAtoll = numAtoll + 1;
				end
			end
		end

		-- Require
		if placement.AdjacentTilesRequireNoFeature then
			if numNoFeature < placement.RequiredNumberOfAdjacentNoFeature then
				return false;
			end
		end
		if placement.AdjacentTilesRequireForest then
			if numForest < placement.RequiredNumberOfAdjacentForest then
				return false;
			end
		end
		if placement.AdjacentTilesRequireJungle then
			if numJungle < placement.RequiredNumberOfAdjacentJungle then
				return false;
			end
		end
		if placement.AdjacentTilesRequireOasis then
			if numOasis < placement.RequiredNumberOfAdjacentOasis then
				return false;
			end
		end
		if placement.AdjacentTilesRequireFloodPlains then
			if numFloodPlains < placement.RequiredNumberOfAdjacentFloodPlains then
				return false;
			end
		end
		if placement.AdjacentTilesRequireMarsh then
			if numMarsh < placement.RequiredNumberOfAdjacentMarsh then
				return false;
			end
		end
		if placement.AdjacentTilesRequireIce then
			if numIce < placement.RequiredNumberOfAdjacentIce then
				return false;
			end
		end
		if placement.AdjacentTilesRequireAtoll then
			if numAtoll < placement.RequiredNumberOfAdjacentAtoll then
				return false;
			end
		end

		-- Avoid
		if placement.AdjacentTilesAvoidNoFeature then
			if numNoFeature > placement.MaximumAllowedAdjacentNoFeature then
				return false;
			end
		end
		if placement.AdjacentTilesAvoidForest then
			if numForest > placement.MaximumAllowedAdjacentForest then
				return false;
			end
		end
		if placement.AdjacentTilesAvoidJungle then
			if numJungle > placement.MaximumAllowedAdjacentJungle then
				return false;
			end
		end
		if placement.AdjacentTilesAvoidOasis then
			if numOasis > placement.MaximumAllowedAdjacentOasis then
				return false;
			end
		end
		if placement.AdjacentTilesAvoidFloodPlains then
			if numFloodPlains > placement.MaximumAllowedAdjacentFloodPlains then
				return false;
			end
		end
		if placement.AdjacentTilesAvoidMarsh then
			if numMarsh > placement.MaximumAllowedAdjacentMarsh then
				return false;
			end
		end
		if placement.AdjacentTilesAvoidIce then
			if numIce > placement.MaximumAllowedAdjacentIce then
				return false;
			end
		end
		if placement.AdjacentTilesAvoidAtoll then
			if numAtoll > placement.MaximumAllowedAdjacentAtoll then
				return false;
			end
		end
	end

	-- print(string.format(" Standard Eligiblity: %s", tostring(true)));
	return true;
end




















