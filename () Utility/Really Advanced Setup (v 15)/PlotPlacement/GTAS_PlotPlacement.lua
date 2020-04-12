
-- GTAS_PlotPlacement - Part of Really Advanced Setup Mod

include("GTAS_Constants");
include("GTAS_Utilities");
include("GTAS_IDoNotKnowWhatFileNameIsSafe");

ELEVATION_NO_CHANGE = 1;
ELEVATION_MOUNTAIN = 2;
ELEVATION_HILLS = 3;
ELEVATION_FLAT = 4;
ELEVATION_RANDOM = 5;

ElevationText = {
	[ELEVATION_NO_CHANGE] = "*",
	[ELEVATION_MOUNTAIN] = "Mountain",
	[ELEVATION_HILLS] = "Hill",
	[ELEVATION_FLAT] = "Flat",
	[ELEVATION_RANDOM] = "Random",
};

NEAR_PLACEMENT = 1;		-- Spiral out from a central plot.
FAR_PLACEMENT = 2;		-- Spiral in towards a central plot.
RND_PLACEMENT = 3;		-- Place randomly around a central plot.
FILL_PLACEMENT = 4;		-- Fill the area around a cental plot.
MAP_PLACEMENT = 5;		-- Place randomly on entire map.

PlacementText = { 
	[NEAR_PLACEMENT] = "Near", 
	[FAR_PLACEMENT] = "Far", 
	[RND_PLACEMENT] = "Random",
	[FILL_PLACEMENT] = "Fill",
	[MAP_PLACEMENT] = "Map",
};

TERRAIN_BORDER_X = 0;
TERRAIN_BORDER_Y = 0;

FEATURE_BORDER_X = 0;
FEATURE_BORDER_Y = 0;

RESOURCE_BORDER_X = 0;
RESOURCE_BORDER_Y = 2;

WONDER_BORDER_X = 2;
WONDER_BORDER_Y = 3;

Sectors = { SECTOR_NORTH, SECTOR_NORTHEAST, SECTOR_SOUTHEAST, SECTOR_SOUTH, SECTOR_SOUTHWEST, SECTOR_NORTHWEST };
ClockDirections = { DIRECTION_CLOCKWISE, DIRECTION_ANTICLOCKWISE }

---------------------------------------------------------------------------------------
-- Every unit type capable of being placed by this mod should return a true value from one (but not both) of these functions.
function IsCityPlacementUnit(unitType)
	if GameInfo.Units[unitType] ~= nil then
		return GameInfo.Units[unitType].Immobile
	end
	return false;
end

function IsNonCityPlacementUnit(unitType)
	if GameInfo.Units[unitType] ~= nil then
		return not GameInfo.Units[unitType].Immobile
	end
	return false;
end
---------------------------------------------------------------------------------------

-------------------------------------------------------------------------------
function GetElevationText(elevationType)
	return ElevationText[elevationType] or "";
end

-------------------------------------------------------------------------------
function GetPlacementText(placementType)
	return PlacementText[placementType] or "";
end

--	Returns a randomly shuffled table of plots by scaning the map.
--	Edge plots in the border region defined by borderX and borderY are ignored.
--------------------------------------------------------------------------------------------------------------------------------------
function GetMapPlotTable(borderX, borderY)
	local plots = {};
		
	local width, height = Map.GetGridSize();
	local startX = LimitValue(borderX, 0, width - 1);
	local endX = LimitValue(width - borderX, 0, width - 1);
	local startY = LimitValue(borderY, 0, height - 1);
	local endY = LimitValue(height - borderY, 0, height - 1);
	
	for y = startY, endY, 1 do
		for x = startX, endX, 1 do
			local plot = Map.GetPlot(x, y);
			if plot ~= nil then
				table.insert(plots, plot);
			end
		end
	end

	return plots;
end

--	Returns a iterator for a randomly shuffled lists of plots that are obtained by scanning the map.
--	Edge plots in the border region defined by borderX and borderY are ignored.
--------------------------------------------------------------------------------------------------------------------------------------
function GetMapPlotList(borderX, borderY)
	local i = 0;
	local plots = GetMapPlotTable(borderX, borderY);			
	ShuffleTable(plots);
		
	return function()
		i = i + 1;
		return plots[i];		
	end
end

--------------------------------------------------------------------------------------------------------------------------------------
-- This function returns a iterator for a table of plots.
-- A new table of plots is created every time this function is called.
-- If placementType is MAP_PLACEMENT then returns a empty list (nil).
-- Otherwise the list consists of all plots that are located between minDistance and maxDistance from centerPlot.	
function GetAreaPlotList(centerPlot, minDistance, maxDistance, placementType)
	local i = 0;
	local plots = {};

	if placementType ~= MAP_PLACEMENT then
		local sector = Sectors[math.random(#Sectors)];
		local clockDirection = ClockDirections[math.random(#ClockDirections)];
		local relativeDirection = DIRECTION_OUTWARDS;

		if placementType == FAR_PLACEMENT then
			relativeDirection = DIRECTION_INWARDS;
		end
		
		for plot in GTAS_PlotAreaSpiralIterator(centerPlot, minDistance, maxDistance, sector, clockDirection, relativeDirection) do
			table.insert(plots, plot);
		end
		
		if placementType == RND_PLACEMENT then
			ShuffleTable(plots);
		end
	end
	
	return function()
		i = i + 1;
		return plots[i];		
	end
end




