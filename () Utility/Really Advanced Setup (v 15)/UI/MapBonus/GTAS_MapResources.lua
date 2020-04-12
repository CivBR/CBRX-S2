
-- GTAS_MapResources - Part of Really Advanced Setup Mod

include("IconSupport");
include("InstanceManager");
include("GTAS_Constants");
include("GTAS_Utilities");
include("GTAS_PlotPlacement");
include("GTAS_ResourceTypes");
include("GTAS_ScrollText");

local NO_RESOURCE = -1;
local MAX_COUNT = 100;

local ResourceID = NO_RESOURCE;
local ResourceGroup = RESOURCE_GROUP_ALL;
local RelaxedRules = false;
local PlotCount = 1;

local ResourceManager = InstanceManager:new("ResourceInstance", "ResourceRoot", Controls.ResourceStack)
local ResourceHelpManager = InstanceManager:new("ResourceHelpInstance", "ResourceHelpRoot", Controls.ResourceStack);

--------------------------------------------------------------------------------------------------
function BuildResources()
	local resources = {};

	for resource in GetResourceList(ResourceGroup) do
		table.insert(resources, { id = resource.ID, description = Locale.ConvertTextKey(resource.Description) });
	end

	table.sort(resources, function(a, b) return Locale.Compare(a.description, b.description) == -1; end);
	table.insert(resources, 1, { id = ResourceGroup, description = GetResourceGroupDescription(ResourceGroup) });

	if ResourceID == NO_RESOURCE then
		ResourceID = ResourceGroup;
	end

	local resourceInfo = GameInfo.Resources[ResourceID];

	-- Resource Portrait -------------------------------------------------------------------
	if resourceInfo ~= nil then
		if IconHookup(resourceInfo.PortraitIndex, 256, resourceInfo.IconAtlas, Controls.Portrait) then
			Controls.PortraitFrame:SetHide(false);
		else
			Controls.PortraitFrame:SetHide(true);
		end
	else
		IconHookup(22, 256, "LEADER_ATLAS", Controls.Portrait);
		Controls.PortraitFrame:SetHide(false);
	end

	-- Resource PullDown -------------------------------------------------------------------
	Controls.ResourcePulldown:ClearEntries();

	for resource in GetList(resources) do
		local control = {};
		Controls.ResourcePulldown:BuildEntry("InstanceOne", control);
		control.Button:SetVoid1(resource.id);
		control.Button:LocalizeAndSetText(resource.description);
	end

	function OnResource(id)
		ResourceID = id;
		PerformBuild();
	end
	Controls.ResourcePulldown:RegisterSelectionCallback(OnResource)
	Controls.ResourcePulldown:GetButton():SetText(GetResourceText(resources, ResourceID));
	Controls.ResourcePulldown:CalculateInternals();

	-- RelaxedRules CheckBox --------------------------------------------------------------
	function OnRelaxedRules(isChecked)
		RelaxedRules = isChecked;
	end
	Controls.RelaxedRules:RegisterCheckHandler(OnRelaxedRules)
	Controls.RelaxedRules:SetCheck(RelaxedRules);

	-- ResourceCount Slider ----------------------------------------------------------------
	function OnPlotCount(fValue)
		PlotCount = GetSliderValue(fValue, 1, MAX_COUNT);
		Controls.CountValue:SetText(tostring(PlotCount));
	end
	Controls.CountSlider:RegisterSliderCallback(OnPlotCount);
	SetSliderValue(Controls.CountSlider, PlotCount, 1, MAX_COUNT);
	Controls.CountValue:SetText(tostring(PlotCount));

	-- Add Resource Button -----------------------------------------------------------------------------
	function OnAddResource()
		local resourceType;
		if resourceInfo ~= nil then
			resourceType = resourceInfo.Type;
		else
			resourceType = ResourceGroup;
		end
		MapData:AddResource(resourceType, PlotCount, 0, 0, MAP_PLACEMENT, RelaxedRules);
		PerformBuild();
	end
	Controls.AddResource:RegisterCallback(Mouse.eLClick, OnAddResource);

	-- Resource Type Radio Buttons -----------------------------------------------------------
	function OnResourceGroup(id)
		ResourceGroup = id;
		ResourceID = NO_RESOURCE;
		PerformBuild();
	end

	Controls.TypeAll:RegisterCallback(Mouse.eLClick, OnResourceGroup);
	Controls.TypeAll:SetVoid1(RESOURCE_GROUP_ALL);
	Controls.TypeAll:SetCheck(ResourceGroup == RESOURCE_GROUP_ALL);

	Controls.TypeBonus:RegisterCallback(Mouse.eLClick, OnResourceGroup);
	Controls.TypeBonus:SetVoid1(RESOURCE_GROUP_BONUS);
	Controls.TypeBonus:SetCheck(ResourceGroup == RESOURCE_GROUP_BONUS);

	Controls.TypeLuxury:RegisterCallback(Mouse.eLClick, OnResourceGroup);
	Controls.TypeLuxury:SetVoid1(RESOURCE_GROUP_LUXURY);
	Controls.TypeLuxury:SetCheck(ResourceGroup == RESOURCE_GROUP_LUXURY);

	Controls.TypeStrategic:RegisterCallback(Mouse.eLClick, OnResourceGroup);
	Controls.TypeStrategic:SetVoid1(RESOURCE_GROUP_STRATEGIC);
	Controls.TypeStrategic:SetCheck(ResourceGroup == RESOURCE_GROUP_STRATEGIC);

	-- Clear List Button -----------------------------------------------------------------------------
	function OnClearList()
		MapData:ResetResources();
		PerformBuild();
	end
	Controls.ClearList:RegisterCallback(Mouse.eLClick, OnClearList);

	-- Resource ScrollPanel -------------------------------------------------------------------
	ResourceManager:ResetInstances();
	ResourceHelpManager:ResetInstances();

	if MapData:HasResources() then
		Controls.ListTitle:SetHide(false);

		for index, resource in MapData:ResourceList() do
			local instance = ResourceManager:GetInstance();
			local info = GameInfo.Resources[resource.resourceType];

			if info ~= nil then
				IconHookup(info.PortraitIndex, 64, info.IconAtlas, instance.ResourcePortrait);
				instance.ResourceName:LocalizeAndSetText(info.Description);
			else
				IconHookup(22, 64, "LEADER_ATLAS", instance.ResourcePortrait);
				instance.ResourceName:LocalizeAndSetText(GetResourceGroupDescription(resource.resourceType));
			end

			instance.ResourceCount:SetText(tostring(resource.count));
			instance.ResourceMinRad:SetText("*");
			instance.ResourceMaxRad:SetText("*");
			instance.ResourcePlacement:SetText(GetPlacementText(resource.placementType));
			instance.ResourceRelaxedRules:SetText(resource.relaxedRules and "Yes" or "No");

			function OnResourceButton()
				if info ~= nil then
					ResourceGroup = RESOURCE_GROUP_ALL;
					ResourceID = info.ID;
				else
					ResourceGroup = GetResourceGroup(resource.resourceType);
					ResourceID = ResourceGroup;
				end
				PlotCount = resource.count;
				RelaxedRules = resource.relaxedRules;
				PerformBuild();
			end
			instance.ResourceButton:RegisterCallback(Mouse.eLClick, OnResourceButton);

			function OnUpdate()
				if resourceInfo ~= nil then
					MapData:UpdateResource(index, resourceInfo.Type, PlotCount, 0, 0, MAP_PLACEMENT, RelaxedRules);
				else
					MapData:UpdateResource(index, ResourceGroup, PlotCount, 0, 0, MAP_PLACEMENT, RelaxedRules);
				end
				PerformBuild();
			end
			instance.UpdateResource:RegisterCallback(Mouse.eLClick, OnUpdate);

			function OnDelete()
				MapData:RemoveResource(index);
				PerformBuild();
			end
			instance.DeleteResource:RegisterCallback(Mouse.eLClick, OnDelete);
		end

	else
		Controls.ListTitle:SetHide(true);
		CreateScrollText(ResourceMapText, ResourceHelpManager);
	end

	Controls.ResourceStack:CalculateSize();
	Controls.ResourceStack:ReprocessAnchoring();
	Controls.ResourceScrollPanel:ReprocessAnchoring();
	Controls.ResourceScrollPanel:CalculateInternalSize();
end

-------------------------------------------------------------------------------
function GetResourceText(resources, id)
	for _, resource in ipairs(resources) do
		if resource.id == id then
			return resource.description;
		end
	end

	return "Resource Error";
end

------------------------------------------------------------------
function ValidateControls()
	LuaEvents.GTAS_ValidateControls();
end

----------------------------------------------------------------
function PerformBuild()
	BuildResources();
	ValidateControls(); -- This should always get called last.
	LuaEvents.GTAS_UpdateMapBonusTopPanel();
end

----------------------------------------------------------------
function ShowHideHandler(isHide, isInit)
	local buffer = {};
	LuaEvents.GetDataObjects(buffer);
	SlotData = buffer[DATA_SLOT];
	MapData = buffer[DATA_MAP];
	GameData = buffer[DATA_GAME];
	GlobalData = buffer[DATA_GLOBAL];

	if not isHide and not isInit then
		PerformBuild();
	end
end
ContextPtr:SetShowHideHandler(ShowHideHandler);

-----------------------------------------------------------------
function AdjustScreenSize()
    local _, screenY = UIManager:GetScreenSizeVal();
	Controls.ResourcePanel:SetSizeY(screenY - PLAYER_PANEL_HEIGHT_OFFSET);
	Controls.ResourceBorder1:SetSizeY(screenY - PLAYER_PANEL_HEIGHT_OFFSET - 4);
	Controls.ResourceBorder2:SetSizeY(screenY - PLAYER_PANEL_HEIGHT_OFFSET - 6);
	Controls.ScrollBox:SetSizeY(screenY - PLAYER_PANEL_HEIGHT_OFFSET - 275);
	Controls.ScrollBorder1:SetSizeY(screenY - PLAYER_PANEL_HEIGHT_OFFSET - 313);
	Controls.ScrollBorder2:SetSizeY(screenY - PLAYER_PANEL_HEIGHT_OFFSET - 315);
	Controls.ResourceScrollPanel:SetSizeY(screenY - PLAYER_PANEL_HEIGHT_OFFSET - 317);
	Controls.ResourceScrollPanel:CalculateInternalSize();
end

-------------------------------------------------
function OnUpdateUI( type )
    if( type == SystemUpdateUIType.ScreenResize ) then
        AdjustScreenSize();
    end
end
Events.SystemUpdateUI.Add( OnUpdateUI );

AdjustScreenSize();


