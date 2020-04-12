
-- GTAS_SlotManager - Part of Really Advanced Setup Mod

-------------------------------------------------
-- Slot Data Manager.
-- Manages a list of slot instances that can be accessed using a slotID which starts with a value of zero.
-- For example: If the list contains 8 slots then they would be acced using a value from 0 to 7.
-- The list length is limited to GameDefines.MAX_MAJOR_CIVS.
-------------------------------------------------

-- print("GTAS_SlotManager **************************************");

include("GTAS_Constants");
include("GTAS_TableSerialization");
include("GTAS_StartBias");
include("GTAS_ResourceGroups");

-------------------------------------------------------------------------------------------------------------------
-- Slot instance object - handles a single slot instance.
local SlotInstance = {};

local defaultSlotValues = {
	civType = RANDOM_CIVILIZATION,
	team = -1,	-- This should set to a valid number before being used (0 -> ?).
	startGold = 0,
	startCulture = 0,
	freeTechs = 0,
	startFaith = 0,
	leaderName = "",
	civDescription = "",
	civShortDescription = "",
	civAdjective = "",
	controlInstance = nil,
	terrain = {},
	features = {},
	wonders = {},
	resources = {},
	units = {},
	startBias = DEFAULT_START_BIAS;
	startRegions = {};
};

function SlotInstance:ResetStartBias()
	self.startBias = DEFAULT_START_BIAS;
	self.startRegions = {};	
end

-- Terrain ----------------------------------------------------------------------------------------------
function SlotInstance:HasTerrain()
	return #self.terrain > 0;
end

function SlotInstance:AddTerrain(_terrainType, _count, _minDistance, _maxDistance, _placementType, _changeWaterLand, _elevation)
	table.insert(self.terrain, {
		terrainType = _terrainType,
		count = _count,
		minDistance = _minDistance,
		maxDistance = _maxDistance,
		placementType = _placementType,
		changeWaterLand = _changeWaterLand,
		elevation = _elevation,
	});
end

function SlotInstance:UpdateTerrain(index, _terrainType, _count, _minDistance, _maxDistance, _placementType, _changeWaterLand, _elevation)
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
function SlotInstance:CopyTerrain(terrain)
	table.insert(self.terrain, terrain);
end

function SlotInstance:RemoveTerrain(index)
	table.remove(self.terrain, index);
end

function SlotInstance:ResetTerrain()
	self.terrain = {};
end

function SlotInstance:TerrainTypesList()
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
function SlotInstance:TerrainList()
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
function SlotInstance:HasResources()
	return #self.resources > 0;
end

function SlotInstance:AddResource(_resourceType, _count, _minDistance, _maxDistance, _placementType, _relaxedRules)
	table.insert(self.resources, {
		resourceType = _resourceType,
		count = _count,
		minDistance = _minDistance,
		maxDistance = _maxDistance,
		placementType = _placementType,
		relaxedRules = _relaxedRules
	});
end

function SlotInstance:UpdateResource(index, _resourceType, _count, _minDistance, _maxDistance, _placementType, _relaxedRules)
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
function SlotInstance:CopyResource(resource)
	table.insert(self.resources, resource);
end

function SlotInstance:RemoveResource(index)
	table.remove(self.resources, index);
end

function SlotInstance:ResetResources()
	self.resources = {};
end

function SlotInstance:ResourceTypesList()
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
function SlotInstance:ResourceList()
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
function SlotInstance:HasFeatures()
	return #self.features > 0;
end

function SlotInstance:AddFeature(_featureType, _count, _minDistance, _maxDistance, _placementType, _replaceFeature)
	table.insert(self.features, {
		featureType = _featureType,
		count = _count,
		minDistance = _minDistance,
		maxDistance = _maxDistance,
		placementType = _placementType,
		replaceFeature = _replaceFeature,
	});
end

function SlotInstance:UpdateFeature(index, _featureType, _count, _minDistance, _maxDistance, _placementType, _replaceFeature)
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
function SlotInstance:CopyFeature(feature)
	table.insert(self.features, feature);
end

function SlotInstance:RemoveFeature(index)
	table.remove(self.features, index);
end

function SlotInstance:ResetFeatures()
	self.features = {};
end

function SlotInstance:FeatureTypesList()
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
function SlotInstance:FeatureList()
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
function SlotInstance:HasWonders()
	return #self.wonders > 0;
end

function SlotInstance:AddWonder(_featureType, _count, _minDistance, _maxDistance, _placementType, _addSprinkles)
	table.insert(self.wonders, {
		featureType = _featureType,
		count = _count,
		minDistance = _minDistance,
		maxDistance = _maxDistance,
		placementType = _placementType,
		addSprinkles = _addSprinkles,
	});
end

function SlotInstance:UpdateWonder(index, _featureType, _count, _minDistance, _maxDistance, _placementType, _addSprinkles)
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
function SlotInstance:CopyWonder(wonder)
	table.insert(self.wonders, wonder);
end

function SlotInstance:RemoveWonder(index)
	table.remove(self.wonders, index);
end

function SlotInstance:ResetWonders()
	self.wonders = {};
end

function SlotInstance:WonderTypesList()
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
function SlotInstance:WonderList()
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

-- Units ----------------------------------------------------------------------------------------------
function SlotInstance:HasUnits()
	return #self.units > 0;
end

function SlotInstance:AddUnit(_unitType, _count, _experience)
	table.insert(self.units, {
		unitType = _unitType,
		count = _count,
		experience = _experience,
	});
end

function SlotInstance:UpdateUnit(index, _unitType, _count, _experience)
	local update = self.units[index];
	if update ~= nil then
		update.unitType = _unitType;
		update.count = _count;
		update.experience = _experience;
	end
end

-- The passed variable "unit" should be a table created by SlotData:AddUnit.
function SlotInstance:CopyUnit(unit)
	table.insert(self.units, unit);
end

function SlotInstance:RemoveUnit(index)
	table.remove(self.units, index);
end

function SlotInstance:ResetUnits()
	self.units = {};
end

function SlotInstance:UnitTypesList()
	local i = 0;
	local types = {};

	for _, unit in self:UnitList() do
		local notFound = true;
		for _, unitType in ipairs(types) do
			if unitType == unit.unitType then
				notFound = false;
				break;
			end
		end
		if notFound then
			table.insert(types, unit.unitType);
		end
	end
	
	return function()
		i = i + 1;
		return types[i];
	end
end

-- Unit iterator. Cycles thru units.
-- Returns index, unit.
function SlotInstance:UnitList()
	local i = 0;
		
	return function()
		i = i + 1;
		
		if self.units[i] ~= nil then
			return i, self.units[i];		
		else
			return nil;
		end
	end
end

-- Reverse unit iterator. Cycles thru units backwards.
-- Returns Unit Index, { Unit ID, Count, experience }.
function SlotInstance:ReverseUnitList()
	local i = #self.units + 1;
		
	return function()
		i = i - 1;
		
		if self.units[i] ~= nil then
			return i, self.units[i];
			
		else
			return nil;
		end
	end
end

-- This determines what gets stored in Civ5 UserData.
function SlotInstance:CopyData(from, to)
	to.civType = from.civType;
	to.team = from.team;
	to.startGold = from.startGold;
	to.startCulture = from.startCulture;
	to.freeTechs = from.freeTechs;
	to.startFaith = from.startFaith;
	to.leaderName = from.leaderName;
	to.civDescription = from.civDescription;
	to.civShortDescription = from.civShortDescription;
	to.civAdjective = from.civAdjective;
	to.startBias = from.startBias;
	
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
	
	to.units = {};
	for k, v in pairs(from.units or {}) do
		to.units[k] = v;
	end
	
	to.startRegions = {};
	for k, v in pairs(from.startRegions or {}) do
		to.startRegions[k] = v;
	end
end
		
-- This will attempt to fix any incorrect values in a slot that has already been properly initialized.
function SlotInstance:FixValues(slotID)
	for k, v in pairs(defaultSlotValues) do
		if self[k] == nil then
			self[k] = v;
		end
	end
	
	-- Default team value is the the same as the slotID. (Starts at 0)
	if self.team == -1 then
		self.team = slotID;
	end
	
	-- If civ not found then use random civ. 
	if GameInfo.Civilizations[self.civType] == nil then
		self.civType = RANDOM_CIVILIZATION;
	end
end

function SlotInstance:SetDefaultValues(slotID)
	for k, v in pairs(SlotInstance) do
		self[k] = v;
	end
	
	for k, v in pairs(defaultSlotValues) do
		if type(v) == "table" then
			self[k] = {};
		else
			self[k] = v;
		end
	end
	
	-- Default team value is the the same as the player ID which is the same as the slot ID.
	self.team = slotID;

	-- If civ not found then use random civ. 
	if GameInfo.Civilizations[self.civType] == nil then
		self.civType = RANDOM_CIVILIZATION;
	end
	
	self:ResetStartBias();
end


-------------------------------------------------------------------------------------------------------------------------------------------------
-- Slot data object - handles a list of slot instances.
-- This object is currently set up to only save and load the data contained within each slot (located in slotInstances).
-- It will not save any data located within the SlotData object itself.
SlotData = {
	slotInstances = {};
};

function SlotData:ResetSlots()
	self.slotInstances = {};
end

function SlotData:ResetAISlots()
	while #self.slotInstances > 1 do
		table.remove(self.slotInstances);
	end
end

function SlotData:SlotExists(slotID)
	return self.slotInstances[slotID + 1] ~= nil;
end

-- If slotID = nil then return last slot.
function SlotData:GetSlot(slotID)
	if slotID == nil then
		return self.slotInstances[#self.slotInstances];
	else
		return self.slotInstances[slotID + 1];
	end
end

function SlotData:CanAddSlot()
	if self:GetSlotCount() < GameDefines.MAX_MAJOR_CIVS then
		return true;
	end
	
	return false;
end

-- Returns (new slotID, New Slot Instance) if there is room. Otherwise returns (-1, nil).
function SlotData:AddSlot()
	if self:GetSlotCount() >= GameDefines.MAX_MAJOR_CIVS then
		return -1, nil;
	else
		local slot = {};

		for k, v in pairs(SlotInstance) do
			if type(v) == "table" then
				slot[k] = {};
			else
				slot[k] = v;
			end
		end

		table.insert(self.slotInstances, slot);
		
		-- Set default values.
		slot:SetDefaultValues(self:GetSlotCount() - 1);

		return self:GetSlotCount() - 1, slot;
	end
end

-- If slotID is passed then the given slot is removed if it exists.
-- If slotID is not passed then removes the last slot in the list.
function SlotData:RemoveSlot(slotID)
	for _, slot in self:SlotList() do		
		if slot.civManager ~= nil then
			slot.civManager:ResetInstances();
		end
		
		if slot.resourceManager ~= nil then
			slot.resourceManager:ResetInstances();
		end
		
		if slot.terrainManager ~= nil then
			slot.terrainManager:ResetInstances();
		end
		
		if slot.wonderManager ~= nil then
			slot.wonderManager:ResetInstances();
		end
		
		if slot.unitManager ~= nil then
			slot.unitManager:ResetInstances();
		end
		
		slot.civManager = nil;
		slot.resourceManager = nil;
		slot.terrainManager = nil;
		slot.wonderManager = nil;
		slot.unitManager = nil;
	end
	
	if slotID ~= nil then
		table.remove(self.slotInstances, slotID + 1);
	else
		table.remove(self.slotInstances);
	end
end

function SlotData:GetSlotCount()
	return #self.slotInstances;
end

-- Shortens or lengthens the list of slots.
function SlotData:SetSlotCount(newSize)
	for i = 1, GameDefines.MAX_MAJOR_CIVS, 1 do
		if newSize < self:GetSlotCount() then
			self:RemoveSlot();
		elseif newSize > self:GetSlotCount() then
			self:AddSlot();
		else
			break;
		end
	end
end

function SlotData:GetCiv(slotID)
	local slot = self:GetSlot(slotID);
	
    if slot ~= nil then
		return GameInfo.Civilizations[slot.civType];
	end
	
	return nil;
end

-- Slot iterator. Cycles thru all Slots in order of slotID.
-- Returns (slotID, Slot Instance).
function SlotData:SlotList()
	local i = -1;
	return function()
		i = i + 1;

		if self.slotInstances[i + 1] ~= nil then
			return i, self.slotInstances[i + 1];
		else
			return nil;
		end
	end
end

-- Slot iterator. Cycles thru AI Slots in order of slotID.
-- Returns (slotID, Slot Instance).
function SlotData:AISlotList()
	local i = 0;
	return function()
		i = i + 1;

		if self.slotInstances[i + 1] ~= nil then
			return i, self.slotInstances[i + 1];
		else
			return nil;
		end
	end
end

-- Load slot data from DB and build slots.
function SlotData:LoadData()
	-- Create database if it doesn't exist.
	for _ in g_UserData.Query('CREATE TABLE IF NOT EXISTS SlotData(Data TEXT)') do end

	local slotData = {};
	
	-- Retrieve slot data from database.
	for row in g_UserData.Query('SELECT Data FROM SlotData') do	
		LoadTable(row.Data, slotData);
		break;
	end

	-- Build slots -----------------------------------------------------------------------
	
	self:ResetSlots();

	-- Load data into slots.
	-- If no slots are created then DataManager will take care of adding them as needed.
	for i, data in ipairs(slotData) do
		slotID, slot = self:AddSlot();
		
		if slot ~= nil then
			slot:CopyData(data, slot);
		end
	end
			
	for slotID, slot in self:SlotList() do
		slot:FixValues(slotID);
	end
end

function SlotData:SaveData()
	-- Create SlotData database if it doesn't exist.
	for _ in g_UserData.Query('CREATE TABLE IF NOT EXISTS SlotData(Data TEXT)') do end

	-- Clear SlotData.
	for _ in g_UserData.Query('DELETE FROM SlotData') do end;

	-- Create save data.
	local saveData = {};

	for slotID, slot in self:SlotList() do
		table.insert(saveData, slotID + 1, {});
		data = saveData[slotID + 1];
		slot:CopyData(slot, data);
	end
	
	-- Convert saveData to a string.
	local data = SaveTable(saveData);

	-- Save data string.
	for _ in g_UserData.Query(string.format('INSERT INTO SlotData(Data) VALUES(%q)', data)) do end
end

-- Returns true if at least one slot has it's civType set to the passed value.
function SlotData:IsCivSelected(civType)
	for slotID, slot in self:SlotList() do
		if slot.civType == civType then
			return true;
		end
	end
	
	return false;
end



















