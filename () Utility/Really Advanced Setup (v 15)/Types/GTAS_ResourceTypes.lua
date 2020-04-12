
-- GTAS_ResourceTypes - Part of Really Advanced Setup Mod

-- The negative id values are used so that a single variable can contain a resource id, or no resource(-1) or one of these.
RESOURCE_GROUP_ALL = -2;
RESOURCE_GROUP_BONUS = -3;
RESOURCE_GROUP_LUXURY = -4;
RESOURCE_GROUP_STRATEGIC = -5;

local Groups = {
	[RESOURCE_GROUP_ALL] = true, 
	[RESOURCE_GROUP_BONUS] = true, 
	[RESOURCE_GROUP_LUXURY] = true, 
	[RESOURCE_GROUP_STRATEGIC] = true,
};

local Descriptions = {
	[RESOURCE_GROUP_ALL] = "Random (All)",
	[RESOURCE_GROUP_BONUS] = "Random (Bonus)",
	[RESOURCE_GROUP_LUXURY] = "Random (Luxury)",
	[RESOURCE_GROUP_STRATEGIC] = "Random (Strategic)",
};


--------------------------------------------------------------------------------
-- This should be the only code used by this mod to determine what is a valid resource.
function ResourceInGroup(resource, group)
	if not resource.OnlyMinorCivs and resource.CivilizationType == nil and MapData.disabledResources[resource.Type] == nil then
		if group == RESOURCE_GROUP_ALL then
			return true;
		elseif GameInfo.ResourceClasses["RESOURCECLASS_LUXURY"] and resource.ResourceClassType == GameInfo.ResourceClasses["RESOURCECLASS_LUXURY"].Type then
			if group == RESOURCE_GROUP_LUXURY then
				return true;
			end
		elseif GameInfo.ResourceClasses["RESOURCECLASS_BONUS"] and resource.ResourceClassType == GameInfo.ResourceClasses["RESOURCECLASS_BONUS"].Type then
			if group == RESOURCE_GROUP_BONUS then
				return true;
			end
		elseif group == RESOURCE_GROUP_STRATEGIC then
			return true;
		end
	end
	
	return false;
end

--------------------------------------------------------------------------------
function GetResourceGroupDescription(group)
	return Descriptions[group] or "Resource Group?";
end

--------------------------------------------------------------------------------
function IsResourceGroup(group)
	if Groups[group] then
		return true;
	end
	
	return false;
end

--------------------------------------------------------------------------------
-- Guaranteed to return a group.
function GetResourceGroup(group)
	if group == RESOURCE_GROUP_BONUS then
		return RESOURCE_GROUP_BONUS;
	elseif group == RESOURCE_GROUP_LUXURY then
		return RESOURCE_GROUP_LUXURY;
	elseif group == RESOURCE_GROUP_STRATEGIC then
		return RESOURCE_GROUP_STRATEGIC;
	end
	
	return RESOURCE_GROUP_ALL;
end

--------------------------------------------------------------------------------
-- Returns a table of the resource object included in the group.
function GetResourceTable(group)
	local resources = {};
	
	for resource in GameInfo.Resources() do
		if ResourceInGroup(resource, group) then
			table.insert(resources, resource);
		end
	end
	
	return resources;
end	

--------------------------------------------------------------------------------
function GetResourceList(group)
	local resources = GetResourceTable(group);
	local i = 0;
	
	return function()
		i = i + 1;
		return resources[i];		
	end
end

--------------------------------------------------------------------------------
-- This currently just returns the maximum quanity for the resource.
-- Add a check for the map option that controls resource quanity? (Sparse, Standard(sp?), Heavy(sp?))
function GetResourceQuanity(resourceType)
	local quantity = 1;
	for row in GameInfo.Resource_QuantityTypes{ResourceType = resourceType} do
		if row.Quantity > quantity then
			quantity = row.Quantity;
		end
	end
	return quantity;
end






















