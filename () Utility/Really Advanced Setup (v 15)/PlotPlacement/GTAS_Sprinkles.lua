
-- GTAS_Sprinkles - Part of Really Advanced Setup Mod

include("GTAS_Utilities");
include("GTAS_PlotPlacement");
include("GTAS_IDoNotKnowWhatFileNameIsSafe");
include("GTAS_ResourceTypes");

-- Index values for sprinkle data in Sprinkle.wonders.
SPRINKLE_MIN_DISTANCE = 1;
SPRINKLE_MAX_DISTANCE = 2;
SPRINKLE_MIN_RESOURCES = 3;
SPRINKLE_MAX_RESOURCES = 4;
SPRINKLE_RESOURCES = 5;

Sprinkles = { };

-- There should be an entry for any natural wonder that uses sprinkles (including GTAS custom wonders).
Sprinkles.wonders = {	-- minDistance, maxDistance, minCount, maxCount, resourceType
	FEATURE_CRATER =			{ 1, 3, 2, 5, { "RESOURCE_IRON", "RESOURCE_WHEAT", } },
	FEATURE_FUJI = 				{ 1, 3, 2, 5, { "RESOURCE_SILK", "RESOURCE_DYE", } },
	FEATURE_MESA =				{ 1, 3, 2, 5, { "RESOURCE_COPPER", "RESOURCE_SALT", } },
	FEATURE_REEF =				{ 1, 3, 2, 5, { "RESOURCE_FISH", } },
	FEATURE_VOLCANO =			{ 1, 3, 2, 5, { "RESOURCE_PEARLS", } },
	FEATURE_GIBRALTAR =			{ 1, 3, 2, 5, { "RESOURCE_WHALE", } },
	FEATURE_GEYSER =			{ 1, 3, 2, 5, { "RESOURCE_DEER", "RESOURCE_SHEEP", } },
	FEATURE_FOUNTAIN_YOUTH =	{ 1, 3, 2, 5, { "RESOURCE_SUGAR", "RESOURCE_DEER", } },
	FEATURE_POTOSI =			{ 1, 3, 2, 5, { "RESOURCE_SILVER", "RESOURCE_GEMS", } },
	FEATURE_EL_DORADO =			{ 1, 3, 2, 5, { "RESOURCE_GOLD", "RESOURCE_GEMS", } },
	FEATURE_SRI_PADA =			{ 1, 3, 2, 5, { "RESOURCE_FISH", "RESOURCE_WINE", } },
	FEATURE_MT_SINAI =			{ 1, 3, 2, 5, { "RESOURCE_OIL", "RESOURCE_STONE", } },
	FEATURE_MT_KAILASH =		{ 1, 3, 2, 5, { "RESOURCE_FUR", "RESOURCE_SHEEP", } },
	FEATURE_ULURU =				{ 1, 3, 2, 5, { "RESOURCE_WINE", "RESOURCE_URANIUM", } },
	FEATURE_LAKE_VICTORIA =		{ 1, 3, 2, 5, { "RESOURCE_IVORY", "RESOURCE_SPICES", } },
	FEATURE_KILIMANJARO =		{ 1, 3, 2, 5, { "RESOURCE_GEMS", "RESOURCE_STONE", } },
	FEATURE_SOLOMONS_MINES =	{ 1, 3, 2, 5, { "RESOURCE_SALT", "RESOURCE_GEMS", } },
};

function Sprinkles:GetResourceList(featureType)
	local i = 0;
	local resources = {};
	
	if self.wonders[featureType] ~= nil then
		resources = self.wonders[featureType][SPRINKLE_RESOURCES] or {};
	end
	
	return function()
		i = i + 1;
		return resources[i];		
	end
end

--------------------------------------------------------------------------------
-- Randomly adds resources around the wonder.
function Sprinkles:PlaceWonderSprinkles(plot, featureType)
	-- print(string.format("PlaceWonderSprinkles:  plot(%i,%i)  %s  ------------------------------------", plot:GetX(), plot:GetY(), featureType));
	local data = self.wonders[featureType];	
	if type(data) == "table" then
		if #data > 4 then
			self:PlaceSprinkleResources(plot, 	data[SPRINKLE_MIN_DISTANCE], data[SPRINKLE_MAX_DISTANCE],
												data[SPRINKLE_MIN_RESOURCES], data[SPRINKLE_MAX_RESOURCES], data[SPRINKLE_RESOURCES]);
		end
	end
end

--------------------------------------------------------------------------------
-- Randomly adds resources around a central plot.
function Sprinkles:PlaceSprinkleResources(plot, minDistance, maxDistance, minCount, maxCount, resourceTypes)
	local count = math.random(minCount, maxCount);

	for resourceType in GetList(resourceTypes) do
		local resource = GameInfo.Resources[resourceType];
		
		if resource ~= nil then
			local quantity = GetResourceQuanity(resourceType);
			
			for otherPlot in self:GetResourcePlots(plot) do
				if otherPlot:CanHaveResource(resource.ID, true) then
					-- print(string.format("Place Theme Resource (%i, %i)   Type = %s", otherPlot:GetX(), otherPlot:GetY(), resource.Type));
					otherPlot:SetResourceType(resource.ID, quantity);
					count = count - 1;				
				end
				
				if count < 1 then
					break;
				end
			end
		end
	end
	
	if count > 0 then
		-- Cycle thru a random list of luxury resources and attempt to place one of each until count is exceeded.
		local resources = GetResourceTable(RESOURCE_GROUP_LUXURY);
		ShuffleTable(resources);
		
		for resource in GetList(resources) do
			for otherPlot in self:GetResourcePlots(plot) do
				if otherPlot:CanHaveResource(resource.ID, true) then
					-- print(string.format("Place NON-Theme Resource (%i, %i)   Type = %s", otherPlot:GetX(), otherPlot:GetY(), resource.Type));
					otherPlot:SetResourceType(resource.ID, quantity);
					count = count - 1;
					break;					
				end
			end
			
			if count < 1 then
				break;
			end
		end
	end
end

function Sprinkles:GetResourcePlots(startPlot)
	local i = 0;
	local plots = {};

	for plot in GTAS_PlotAreaSpiralIterator(startPlot, 1, 2, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS) do
		table.insert(plots, plot);
	end
		
	ShuffleTable(plots);
			
	for plot in PlotRingIterator(startPlot, 3, Sectors[math.random(#Sectors)], ClockDirections[math.random(#ClockDirections)]) do
		table.insert(plots, plot);
	end

	return function()
		i = i + 1;
		return plots[i];		
	end
end




















