
-- GTAS_MapManager - Part of Really Advanced Setup Mod

-------------------------------------------------
-- Map Data Manager.
-------------------------------------------------

-- print("GTAS_MapManager **************************************");

include("GTAS_Constants");
include("GTAS_TableSerialization");
include("GTAS_ResourceTypes");

-------------------------------------------------------------------------------------------------------------------
MapData = {};

-- maxWonderCopies:
-- -1 Means unlimited wonders. There are no limits other than available valid plots.
--  A number greater than zero indicates the maximum number of each wonder type allowed on the map.

-- removeOriginalWonders:
-- If this is true then all original wonders created by the game that are not listed in disabledWonders are deleted.
-- The disabled wonders are not deleted because this mod does not give the ability to replace them.

-- disabledWonders:
-- These are wonders that are disabled due to problems implementing them in the mod.
-- They only appear when created by the original game.
-- FEATURE_REEF and FEATURE_GIBRALTAR both cause graphical problems and have been disabled (at least for now).

defaultMapValues = {
	isRandomMapScript = true,
	mapScript = "",
	isRandomWorldSize = true,
	worldSize = -1,			-- -1 means no value set.
	numMinorCivs = -1,		-- -1 means no value set.
	loadWBScenario = false,
	startingVisibility = 2,	-- -1 means whole map.

	-- Attributes for natural wonders.
	maxWonderCopies = 1;
	removeOriginalWonders = false;
	disableAllNaturalWonders = false,

	mapOptions = {},
	activeCivs = {},

	-- Disabled types.
	disabledWonders = { FEATURE_REEF = true, FEATURE_GIBRALTAR = true };
	disabledResources = { RESOURCE_ARTIFACTS = true, RESOURCE_HIDDEN_ARTIFACTS = true };

	-- These hold commands for placing items randomly on the map.
	terrain = {},
	features = {},
	wonders = {},
	resources = {},

	-- This is the actual world size used when setting the PreGame values.
	-- It's value is set by the DataManager before it sets up PreGame values.
	-- If isRandomWorldSize then this value is randomly created otherwise it's set to the value of worldSize.
	_worldSize = 1,
};

function MapData:IsActiveCiv(civType)
	return self.activeCivs[civType] or false;
end

function MapData:GetCurrentWorld()
	return GameInfo.Worlds[self.worldSize];
end

function MapData:SetMapScriptValue(script)
	self.isRandomMapScript = false;
	self.mapScript = script;
end

function MapData:SetMapScriptRandom()
	self.isRandomMapScript = true;
	self.mapScript = "";
end

function MapData:SetMapSizeValue(size)
	self.isRandomWorldSize = false;

	local world = GameInfo.Worlds[size];

	if world ~= nil then
		self.worldSize = size;
	else
		if GameInfo.Worlds[self.worldSize] == nil then
			self.worldSize = defaultMapValues.worldSize;
		end
	end
end

function MapData:SetMapSizeRandom()
	self.isRandomWorldSize = true;
	self.worldSize = -1;
end

-- Load data from DB and Initialize MapData -----------------------------------------------------------------------------
function MapData:LoadData()
	-- Create database if it doesn't exist.
	for _ in g_UserData.Query('CREATE TABLE IF NOT EXISTS MapData(Data TEXT)') do end

	local loadData = {};

	for row in g_UserData.Query('SELECT Data FROM MapData') do
		LoadTable(row.Data, loadData);
		break;
	end

	self:SetDefaultValues();
	self:CopyData(loadData, self);
	self:FixValues();
end

function MapData:SaveData()
	-- Create MapData database if it doesn't exist.
	for _ in g_UserData.Query('CREATE TABLE IF NOT EXISTS MapData(Data TEXT)') do end

	-- Clear MapData.
	for _ in g_UserData.Query('DELETE FROM MapData') do end;

	-- Create save data.
	local saveData = {};
	self:CopyData(self, saveData);

	-- Convert saveData to a string.
	local data = SaveTable(saveData);

	-- Save data string.
	for _ in g_UserData.Query(string.format('INSERT INTO MapData(Data) VALUES(%q)', data)) do end
end

-- This is used to determine what gets stored in Civ5 UserData.
function MapData:CopyData(from, to)
	to.mapScript = from.mapScript;
	to.isRandomMapScript = from.isRandomMapScript;
	to.worldSize = from.worldSize;
	to.isRandomWorldSize = from.isRandomWorldSize;
	to.numMinorCivs = from.numMinorCivs;
	to.loadWBScenario = from.loadWBScenario;
	to.startingVisibility = from.startingVisibility;
	to.maxWonderCopies = from.maxWonderCopies;
	to.removeOriginalWonders = from.removeOriginalWonders;
	to.disableAllNaturalWonders = from.disableAllNaturalWonders;

	to.mapOptions = {};
	for k, v in pairs(from.mapOptions or {}) do
		to.mapOptions[k] = v;
	end

	to.activeCivs = {};
	for k, v in pairs(from.activeCivs or {}) do
		to.activeCivs[k] = v;
	end

	to.terrain = {};
	for k, v in pairs(from.terrain or {}) do
		to.terrain[k] = v;
	end

	to.resources = {};
	for k, v in pairs(from.resources or {}) do
		to.resources[k] = v;
	end

	to.features = {};
	for k, v in pairs(from.features or {}) do
		to.features[k] = v;
	end

	to.wonders = {};
	for k, v in pairs(from.wonders or {}) do
		to.wonders[k] = v;
	end
end

function MapData:FixValues()
	for k, v in pairs(defaultMapValues) do
		if self[k] == nil then
			self[k] = v;
		end
	end

	self.mapScript = string.gsub(self.mapScript, "\\\\", "\\");

	-- Update activeCivs to reflect currently available civilizations ---------------------------------------------------

	-- Remove any civs that are no longer available.
	for civType, _ in pairs(self.activeCivs) do
		local civAvailable = false;

		for row in DB.Query("SELECT * FROM Civilizations WHERE Type = ? AND Playable = 1", civType) do
			civAvailable = true;
		end

		if not civAvailable then
			self.activeCivs[civType] = nil;
		end
	end

	-- Add any playable civs that are not currently in the list and make them active.
	for row in DB.Query("SELECT Type FROM Civilizations WHERE Civilizations.Playable = 1") do
		if self.activeCivs[row.Type] == nil then
			self.activeCivs[row.Type] = true;
		end
	end
end

function MapData:SetDefaultValues()
	local defaultMapScript = GameInfo.MapScripts{FileName = "Assets\\Maps\\Continents.lua"}();

	if defaultMapScript == nil then
		defaultMapScript = GameInfo.MapScripts()(); -- Get first map script found.
	end

	if defaultMapScript ~= nil then
		defaultMapValues.isRandomMapScript = false;
		defaultMapValues.mapScript = defaultMapScript.FileName;
	end

	local defaultWorldSize = GameInfo.Worlds["WORLDSIZE_STANDARD"];

	if defaultWorldSize == nil then
		defaultWorldSize = GameInfo.Worlds()(); -- Get first world size found.
	end

	if defaultWorldSize ~= nil then
		defaultMapValues.isRandomWorldSize = false;
		defaultMapValues.worldSize = defaultWorldSize.ID;
		defaultMapValues.numMinorCivs = defaultWorldSize.DefaultMinorCivs;
	end

	for k, v in pairs(defaultMapValues) do
		if type(v) == "table" then
			self[k] = {};
			for j, w in pairs(v) do
				self[k][j] = w;
			end
		else
			self[k] = v;
		end
	end

	-- self.disabledWonders = defaultMapValues.disabledWonders;
	-- self.disabledResources = defaultMapValues.disabledResources;

	for row in DB.Query("SELECT Type, Description FROM Civilizations WHERE Civilizations.Playable = 1") do
		self.activeCivs[row.Type] = true;
	end
end

-- Terrain ----------------------------------------------------------------------------------------------
function MapData:HasTerrain()
	return #self.terrain > 0;
end

function MapData:AddTerrain(_terrainType, _count, _minDistance, _maxDistance, _placementType, _changeWaterLand, _elevation)
	table.insert(self.terrain, {
		terrainType = _terrainType;
		count = _count;
		minDistance = _minDistance;
		maxDistance = _maxDistance;
		placementType = _placementType;
		changeWaterLand = _changeWaterLand;
		elevation = _elevation;
	});
end

function MapData:UpdateTerrain(index, _terrainType, _count, _minDistance, _maxDistance, _placementType, _changeWaterLand, _elevation)
	local update = self.terrain[index];

	if update ~= nil then
		update.terrainType = _terrainType;
		update.count = _count;
		update.minDistance = _minDistance;
		update.maxDistance = _maxDistance;
		update.placementType = _placementType;
		update.changeWaterLand = _changeWaterLand;
		update.elevation = _elevation;
	end
end

-- The passed variable "terrain" should be a table created by SlotData:AddTerrain.
function MapData:CopyTerrain(terrain)
	table.insert(self.terrain, terrain);
end

function MapData:RemoveTerrain(index)
	table.remove(self.terrain, index);
end

function MapData:ResetTerrain()
	self.terrain = {};
end

function MapData:TerrainTypesList()
	local i = 0;
	local types = {};
	
	for _, terrain in self:TerrainList() do
		local notFound = true;
		for _, terrainType in ipairs(types) do
			if terrainType == terrain.terrainType then
				notFound = false;
				break;
			end
		end
		if notFound then
			table.insert(types, terrain.terrainType);
		end
	end
	
	return function()
		i = i + 1;
		return types[i];
	end
end

-- Terrain iterator. Cycles thru terrain.
-- Returns index, terrain. (See AddTerrain for a description of terrain.)
function MapData:TerrainList()
	local i = 0;

	return function()
		i = i + 1;

		if self.terrain[i] ~= nil then
			return i, self.terrain[i];
		else
			return nil;
		end
	end
end

-- Resources ----------------------------------------------------------------------------------------------
function MapData:HasResources()
	return #self.resources > 0;
end

function MapData:AddResource(_resourceType, _count, _minDistance, _maxDistance, _placementType, _relaxedRules)
	table.insert(self.resources, {
		resourceType = _resourceType;
		count = _count;
		minDistance = _minDistance;
		maxDistance = _maxDistance;
		placementType = _placementType;
		relaxedRules = _relaxedRules;
	});
end

function MapData:UpdateResource(index, _resourceType, _count, _minDistance, _maxDistance, _placementType, _relaxedRules)
	local update = self.resources[index];

	if update ~= nil then
		update.resourceType = _resourceType;
		update.count = _count;
		update.minDistance = _minDistance;
		update.maxDistance = _maxDistance;
		update.placementType = _placementType;
		update.relaxedRules = _relaxedRules;
	end
end

-- The passed variable "resource" should be a table created by SlotData:AddResource.
function MapData:CopyResource(resource)
	table.insert(self.resources, resource);
end

function MapData:RemoveResource(index)
	table.remove(self.resources, index);
end

function MapData:ResetResources()
	self.resources = {};
end

function MapData:ResourceTypesList()
	local i = 0;
	local types = {};
	
	for _, resource in self:ResourceList() do
		local notFound = true;
		for _, currentType in ipairs(types) do
			if currentType == resource.resourceType then
				notFound = false;
				break;
			elseif IsResourceGroup(currentType) and IsResourceGroup(resource.resourceType) then
				notFound = false;
				break;
			end
		end
		if notFound then
			table.insert(types, resource.resourceType);
		end
	end
	
	return function()
		i = i + 1;
		return types[i];
	end
end

-- Resource iterator. Cycles thru resources.
-- Returns index, resource.
function MapData:ResourceList()
	local i = 0;

	return function()
		i = i + 1;

		if self.resources[i] ~= nil then
			return i, self.resources[i];
		else
			return nil;
		end
	end
end

-- Features ----------------------------------------------------------------------------------------------
function MapData:HasFeatures()
	return #self.features > 0;
end

function MapData:AddFeature(_featureType, _count, _minDistance, _maxDistance, _placementType, _replaceFeature)
	table.insert(self.features, {
		featureType = _featureType;
		count = _count;
		minDistance = _minDistance;
		maxDistance = _maxDistance;
		placementType = _placementType;
		replaceFeature = _replaceFeature;
	});
end

function MapData:UpdateFeature(index, _featureType, _count, _minDistance, _maxDistance, _placementType, _replaceFeature)
	local update = self.features[index];

	if update ~= nil then
		update.featureType = _featureType;
		update.count = _count;
		update.minDistance = _minDistance;
		update.maxDistance = _maxDistance;
		update.placementType = _placementType;
		update.replaceFeature = _replaceFeature;
	end
end

-- The passed variable "feature" should be a table created by SlotData:AddFeature.
function MapData:CopyFeature(feature)
	table.insert(self.features, feature);
end

function MapData:RemoveFeature(index)
	table.remove(self.features, index);
end

function MapData:ResetFeatures()
	self.features = {};
end

function MapData:FeatureTypesList()
	local i = 0;
	local types = {};

	for _, feature in self:FeatureList() do
		local notFound = true;
		for _, featureType in ipairs(types) do
			if featureType == feature.featureType then
				notFound = false;
				break;
			end
		end
		if notFound then
			table.insert(types, feature.featureType);
		end
	end
	
	return function()
		i = i + 1;
		return types[i];
	end
end

-- Feature iterator. Cycles thru features.
-- Returns index, feature.
function MapData:FeatureList()
	local i = 0;

	return function()
		i = i + 1;

		if self.features[i] ~= nil then
			return i, self.features[i];
		else
			return nil;
		end
	end
end

-- NaturalWonders ----------------------------------------------------------------------------------------------
function MapData:HasWonders()
	return #self.wonders > 0;
end

function MapData:AddWonder(_featureType, _count, _minDistance, _maxDistance, _placementType, _addSprinkles)
	table.insert(self.wonders, {
		featureType = _featureType,
		count = _count,
		minDistance = _minDistance,
		maxDistance = _maxDistance,
		placementType = _placementType,
		addSprinkles = _addSprinkles,
	});
end

function MapData:UpdateWonder(index, _featureType, _count, _minDistance, _maxDistance, _placementType, _addSprinkles)
	local update = self.wonders[index];

	if update ~= nil then
		update.featureType = _featureType;
		update.count = _count;
		update.minDistance = _minDistance;
		update.maxDistance = _maxDistance;
		update.placementType = _placementType;
		update.addSprinkles = _addSprinkles;
	end
end

-- The passed variable "wonder" should be a table created by SlotData:Addwonder.
function MapData:CopyWonder(wonder)
	table.insert(self.wonders, wonder);
end

function MapData:RemoveWonder(index)
	table.remove(self.wonders, index);
end

function MapData:ResetWonders()
	self.wonders = {};
end

function MapData:WonderTypesList()
	local i = 0;
	local types = {};

	for _, wonder in self:WonderList() do
		local notFound = true;
		for _, featureType in ipairs(types) do
			if featureType == wonder.featureType then
				notFound = false;
				break;
			end
		end
		if notFound then
			table.insert(types, wonder.featureType);
		end
	end
	
	return function()
		i = i + 1;
		return types[i];
	end
end

-- Wonder iterator. Cycles thru wonders.
-- Returns index, wonder.
function MapData:WonderList()
	local i = 0;

	return function()
		i = i + 1;

		if self.wonders[i] ~= nil then
			return i, self.wonders[i];
		else
			return nil;
		end
	end
end






