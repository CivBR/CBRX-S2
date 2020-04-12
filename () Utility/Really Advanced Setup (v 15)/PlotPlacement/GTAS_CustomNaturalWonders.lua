
-- GTAS_CustomNaturalWonders - Part of Really Advanced Setup Mod

-- Custom wonder functions.
-- This module contains function used for GTAS custom natural wonders.
-- This has nothing to do with generating normal natural wonders when the map is being created by the game.

include("GTAS_Utilities");
include("GTAS_PlotPlacement");

-- Load Mod data from database and get data handlers.
LoadData();
local buffer = {};
LuaEvents.GetDataObjects(buffer);
local SlotData = buffer[DATA_SLOT];
local MapData = buffer[DATA_MAP];
local GameData = buffer[DATA_GAME];
local GlobalData = buffer[DATA_GLOBAL];
	
CustomNaturalWonders = {};

function CustomNaturalWonders:IsCustomWonder(featureType)
	return self.wonders[featureType] ~= nil;
end

-- Returns nil if natural wonder isn't a custom wonder.
-- Otherwise returns true if natural wonder was placed on plot or false if it wasn't.
function CustomNaturalWonders:PlaceWonder(featureType, plot)
	if self.wonders[featureType] ~= nil then
		return self.wonders[featureType].Place(featureType, plot);
	end
end

-- Returns nil if natural wonder isn't a custom wonder.
-- Otherwise returns true if natural wonder can be placed on plot or false if it can't.
function CustomNaturalWonders:CanPlaceWonder(featureType, plot)
	if self.wonders[featureType] == nil then
		return nil;
	else
		return self.wonders[featureType].CanPlace(plot);
	end
end

-- "Place" functions ---------------------------------------------------------------------------------------

-- This wonder is current disabled do to problems with corrupted graphics.
function PlaceGibraltar(featureType, plot)
	return false;
end

-- This wonder is current disabled do to problems with corrupted graphics.
function PlaceReef(featureType, plot)
	return false;
end

function PlaceVolcano(featureType, plot)
	-- print(string.format("(%i,%i) PlaceVolcano", plot:GetX(), plot:GetY()));
	local feature = GameInfo.Features[featureType];
		
	if feature ~= nil then	
		for direction in GetDirectionList() do
			local adjPlot = Map.PlotDirection(plot:GetX(), plot:GetY(), direction);
			if adjPlot ~= nil and adjPlot:GetPlotType() == PlotTypes.PLOT_OCEAN then
				if adjPlot:GetTerrainType() ~= TerrainTypes.TERRAIN_COAST then
					adjPlot:SetTerrainType(TerrainTypes.TERRAIN_COAST, false, true);
				end
			end
		end
		
		plot:SetImprovementType(-1);
		plot:SetResourceType(-1);
		plot:SetTerrainType(TerrainTypes.TERRAIN_GRASS, false, true);
		plot:SetPlotType(PlotTypes.PLOT_MOUNTAIN, false, true);
		plot:SetFeatureType(feature.ID);
		return true;
	end

	return false;
end

function PlaceSriPada(featureType, plot)
	-- print(string.format("(%i,%i) PlaceSriPada", plot:GetX(), plot:GetY()));
	local feature = GameInfo.Features[featureType];
		
	if feature ~= nil then	
		plot:SetImprovementType(-1);
		plot:SetResourceType(-1);
		plot:SetPlotType(PlotTypes.PLOT_MOUNTAIN, false, true);
		plot:SetFeatureType(feature.ID);
		return true;
	end

	return false;
end

-- "CanPlace" functions ---------------------------------------------------------------------------------------
 
-- This wonder is current disabled do to problems with corrupted graphics.
function CanPlaceGibraltar(plot)
	return false;
end

-- This wonder is current disabled do to problems with corrupted graphics.
function CanPlaceReef(plot)
	return false;
end

function CanPlaceVolcano(plot)
	local _, height = Map.GetGridSize();
	
	if not plot:IsWater() then
		return false;
	end
	
	if plot:IsLake() then
		return false;
	end
	
	if plot:IsAdjacentToLand() then
		return false;
	end
		
	if plot:GetY() < (height * .25) then
		return false;
	end
	
	if plot:GetY() > (height * .75) then
		return false;
	end
	
	local bigLand, smallLand = 0, 0;
		
	local hasLand = false;
		
	for otherPlot in GetAreaPlotList(plot, 2, 2, NEAR_PLACEMENT) do
		if otherPlot:GetPlotType() ~= PlotTypes.PLOT_OCEAN then
			if otherPlot:Area():GetNumTiles() > height / 2 then
				return false;  
			end
			if otherPlot:GetPlotType() ~= PlotTypes.PLOT_MOUNTAIN then
				hasLand = true;
			end
		end
	end
	
	if not hasLand then
		return false;
	end

	-- print(string.format("(%i,%i) return true!", plot:GetX(), plot:GetY()));
	return true;
end

function CanPlaceSriPada(plot)
	if plot:GetTerrainType() ~= TerrainTypes.TERRAIN_GRASS and plot:GetTerrainType() ~= TerrainTypes.TERRAIN_PLAINS then
		return false;
	end
		
	for direction in GetDirectionList() do
		local adjPlot = Map.PlotDirection(plot:GetX(), plot:GetY(), direction);	
		if adjPlot ~= nil then
			if adjPlot:GetTerrainType() == TerrainTypes.TERRAIN_DESERT or adjPlot:GetTerrainType() == TerrainTypes.TERRAIN_TUNDRA then
				return false;
			end
			if adjPlot:GetFeatureType() == FeatureTypes.FEATURE_MARSH then
				return false;
			end
		end
	end
	
	if plot:GetY() < (height * .25) then
		return false;
	end
	
	if plot:GetY() > (height * .75) then
		return false;
	end
	
	local hasLand = false;
		
	for otherPlot in GetAreaPlotList(plot, 1, 2, NEAR_PLACEMENT) do
		if otherPlot:GetPlotType() ~= PlotTypes.PLOT_OCEAN and otherPlot:GetPlotType() ~= PlotTypes.PLOT_MOUNTAIN then
			hasLand = true;
			break;
		end
	end
	
	if not hasLand then
		return false;
	end

	-- print(string.format("(%i,%i) return true!", plot:GetX(), plot:GetY()));
	return true;
end

CustomNaturalWonders.wonders = {
	FEATURE_GIBRALTAR = { CanPlace = CanPlaceGibraltar, Place = PlaceGibraltar },
	FEATURE_REEF = { CanPlace = CanPlaceReef, Place = PlaceReef },
	FEATURE_VOLCANO = { CanPlace = CanPlaceVolcano, Place = PlaceVolcano },
	FEATURE_SRI_PADA = { CanPlace = CanPlaceSriPada, Place = PlaceSriPada },
};






























