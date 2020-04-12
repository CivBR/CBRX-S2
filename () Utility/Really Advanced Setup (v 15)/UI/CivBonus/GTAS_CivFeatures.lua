
-- GTAS_CivFeatures - Part of Really Advanced Setup Mod

include("IconSupport");
include("InstanceManager");

include("GTAS_Constants");
include("GTAS_Utilities");
include("GTAS_FeatureTypes");
include("GTAS_PlotPlacement");
include("GTAS_ScrollText");

local NO_FEATURE = -1;
local MINIMUM_DISTANCE = 1;
local MAXIMUM_DISTANCE = 25;
local MIN_COUNT = 1;
local MAX_COUNT = 100;

local FeatureID = NO_FEATURE;
local PlacementType = NEAR_PLACEMENT;
local IgnoreTerrain = false;
local MinDistance = 1;
local MaxDistance = 3;
local PlotCount = 1;
local ReplaceFeature = false;

local FeatureManager = InstanceManager:new("FeatureInstance", "FeatureRoot", Controls.FeatureStack)
local FeatureHelpManager = InstanceManager:new("FeatureHelpInstance", "FeatureHelpRoot", Controls.FeatureStack);

--------------------------------------------------------------------------------------------------
function BuildFeatures()
	local slot = SlotData:GetSlot(GlobalData.currentPlayer);

	if slot == nil then
		return
	end

	local features = {};

	for feature in GetFeatureList() do
		table.insert(features, { id = feature.ID, description = Locale.ConvertTextKey(feature.Description) });
	end

	table.sort(features, function(a, b) return Locale.Compare(a.description, b.description) == -1; end);

	if FeatureID == NO_FEATURE then
		FeatureID = features[1].id;
	end

	local featureInfo = GameInfo.Features[FeatureID];

	-- Feature Portrait -------------------------------------------------------------------
	if featureInfo ~= nil and IconHookup(featureInfo.PortraitIndex, 256, featureInfo.IconAtlas, Controls.Portrait) then
		Controls.PortraitFrame:SetHide(false);
	else
		Controls.PortraitFrame:SetHide(true);
	end

	-- Feature PullDown -------------------------------------------------------------------
	Controls.FeaturePulldown:ClearEntries();

	for feature in GetList(features) do
		local control = {};
		Controls.FeaturePulldown:BuildEntry("InstanceOne", control);
		control.Button:SetVoid1(feature.id);
		control.Button:LocalizeAndSetText(feature.description);
	end

	function OnFeature(id)
		FeatureID = id;
		PerformBuild();
	end
	Controls.FeaturePulldown:RegisterSelectionCallback(OnFeature)

	if featureInfo ~= nil then
		Controls.FeaturePulldown:GetButton():LocalizeAndSetText(featureInfo.Description);
	else
		Controls.FeaturePulldown:GetButton():SetText("Feature Error");
	end

	Controls.FeaturePulldown:CalculateInternals();

	-- Placement Radio Buttons --------------------------------------------------------------
	function OnButtonChanged(placementType)
		PlacementType = placementType;
		PerformBuild();
	end

	Controls.PlacementNear:RegisterCallback(Mouse.eLClick, OnButtonChanged);
	Controls.PlacementNear:SetVoid1(NEAR_PLACEMENT);
	Controls.PlacementNear:SetCheck(PlacementType == NEAR_PLACEMENT);

	Controls.PlacementFar:RegisterCallback(Mouse.eLClick, OnButtonChanged);
	Controls.PlacementFar:SetVoid1(FAR_PLACEMENT);
	Controls.PlacementFar:SetCheck(PlacementType == FAR_PLACEMENT);

	Controls.PlacementRandom:RegisterCallback(Mouse.eLClick, OnButtonChanged);
	Controls.PlacementRandom:SetVoid1(RND_PLACEMENT);
	Controls.PlacementRandom:SetCheck(PlacementType == RND_PLACEMENT);

	Controls.PlacementFill:RegisterCallback(Mouse.eLClick, OnButtonChanged);
	Controls.PlacementFill:SetVoid1(FILL_PLACEMENT);
	Controls.PlacementFill:SetCheck(PlacementType == FILL_PLACEMENT);

	if PlacementType == FILL_PLACEMENT then
		Controls.CountControlsOff:SetHide(false);
		Controls.CountControlsOn:SetHide(true);
	else
		Controls.CountControlsOff:SetHide(true);
		Controls.CountControlsOn:SetHide(false);
	end

	-- Feature PlotCount Slider ----------------------------------------------------------------
	function OnPlotCount(fValue)
		PlotCount = GetSliderValue(fValue, MIN_COUNT, MAX_COUNT);
		Controls.CountValue:SetText(tostring(PlotCount));
	end
	Controls.CountSlider:RegisterSliderCallback(OnPlotCount);
	SetSliderValue(Controls.CountSlider, PlotCount, MIN_COUNT, MAX_COUNT);
	Controls.CountValue:SetText(tostring(PlotCount));

	-- MinDistance Slider ------------------------------------------------------------------
	function OnMinDistance(fValue)
		MinDistance = GetSliderValue(fValue, MINIMUM_DISTANCE, MAXIMUM_DISTANCE);
		Controls.MinDistanceValue:SetText(tostring(MinDistance));

		if MinDistance > MaxDistance then
			MaxDistance = MinDistance;
			PerformBuild();
		end
	end
	Controls.MinDistanceSlider:RegisterSliderCallback(OnMinDistance);
	SetSliderValue(Controls.MinDistanceSlider, MinDistance, MINIMUM_DISTANCE, MAXIMUM_DISTANCE);
	Controls.MinDistanceValue:SetText(tostring(MinDistance));

	-- MaxDistance Slider ------------------------------------------------------------------
	function OnMaxDistance(fValue)
		MaxDistance = GetSliderValue(fValue, MINIMUM_DISTANCE, MAXIMUM_DISTANCE);
		Controls.MaxDistanceValue:SetText(tostring(MaxDistance));

		if MaxDistance < MinDistance then
			MinDistance = MaxDistance;
			PerformBuild();
		end
	end
	Controls.MaxDistanceSlider:RegisterSliderCallback(OnMaxDistance);
	SetSliderValue(Controls.MaxDistanceSlider, MaxDistance, MINIMUM_DISTANCE, MAXIMUM_DISTANCE);
	Controls.MaxDistanceValue:SetText(tostring(MaxDistance));

	-- ChangeWaterLand CheckBox --------------------------------------------------------------
	function OnReplaceFeature(isChecked)
		ReplaceFeature = isChecked;
	end
	Controls.ReplaceFeature:RegisterCheckHandler(OnReplaceFeature)
	Controls.ReplaceFeature:SetCheck(ReplaceFeature);

	-- Add Feature Button -----------------------------------------------------------------------------
	function OnAddFeature()
		if featureInfo ~= nil then
			slot:AddFeature(featureInfo.Type, PlotCount, MinDistance, MaxDistance, PlacementType, ReplaceFeature);
		end
		PerformBuild();
	end
	Controls.AddFeature:RegisterCallback(Mouse.eLClick, OnAddFeature);

	-- Copy List Button -----------------------------------------------------------------------------
	function OnCopyList()
		for playerID, otherSlot in SlotData:SlotList() do
			if otherSlot ~= nil and otherSlot ~= slot then
				otherSlot:ResetFeatures();

				for _, feature in slot:FeatureList() do
					otherSlot:CopyFeature(feature);
				end
			end
		end
		PerformBuild();
	end
	Controls.CopyList:RegisterCallback(Mouse.eLClick, OnCopyList);

	-- Clear List Button -----------------------------------------------------------------------------
	function OnClearList()
		slot:ResetFeatures();
		PerformBuild();
	end
	Controls.ClearList:RegisterCallback(Mouse.eLClick, OnClearList);

	-- Feature ScrollPanel -------------------------------------------------------------------
	FeatureManager:ResetInstances();
	FeatureHelpManager:ResetInstances();

	if slot:HasFeatures() then
		Controls.ListTitle:SetHide(false);

		for index, feature in slot:FeatureList() do
			local instance = FeatureManager:GetInstance();
			local info = GameInfo.Features[feature.featureType];

			if info ~= nil then
				IconHookup(info.PortraitIndex, 64, info.IconAtlas, instance.FeaturePortrait);
				instance.FeatureName:LocalizeAndSetText(info.Description);
			else
				IconHookup(22, 64, "LEADER_ATLAS", instance.FeaturePortrait);
				instance.FeatureName:SetText("Random");
			end

			if feature.placementType ~= FILL_PLACEMENT then
				instance.FeatureCount:SetText(tostring(feature.count));
			else
				instance.FeatureCount:SetText("*");
			end

			instance.FeatureMinRad:SetText(tostring(feature.minDistance));
			instance.FeatureMaxRad:SetText(tostring(feature.maxDistance));
			instance.FeaturePlacement:SetText(GetPlacementText(feature.placementType));
			instance.FeatureReplace:SetText(feature.replaceFeature and "Yes" or "No");

			function OnFeatureButton()
				if info ~= nil then
					FeatureID = info.ID;
				end

				if feature.placementType ~= FILL_PLACEMENT then
					PlotCount = feature.count;
				end

				MinDistance = feature.minDistance;
				MaxDistance = feature.maxDistance;
				PlacementType = feature.placementType;
				ReplaceFeature = feature.replaceFeature;
				PerformBuild();
			end
			instance.FeatureButton:RegisterCallback(Mouse.eLClick, OnFeatureButton);

			function OnUpdate()
				if featureInfo ~= nil then
					slot:UpdateFeature(index, featureInfo.Type, PlotCount, MinDistance, MaxDistance, PlacementType, ReplaceFeature);
				end
				PerformBuild();
			end
			instance.UpdateFeature:RegisterCallback(Mouse.eLClick, OnUpdate);

			function OnDelete()
				slot:RemoveFeature(index);
				PerformBuild();
			end
			instance.DeleteFeature:RegisterCallback(Mouse.eLClick, OnDelete);
		end

	else
		Controls.ListTitle:SetHide(true);
		CreateScrollText(FeatureCivText, FeatureHelpManager);
	end

	Controls.FeatureStack:CalculateSize();
	Controls.FeatureStack:ReprocessAnchoring();
	Controls.FeatureScrollPanel:ReprocessAnchoring();
	Controls.FeatureScrollPanel:CalculateInternalSize();
end

------------------------------------------------------------------
function ValidateControls()
	LuaEvents.GTAS_ValidateControls();
end

----------------------------------------------------------------
function PerformBuild()
	BuildFeatures();
	ValidateControls(); -- This should always get called last.
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
	Controls.FeaturePanel:SetSizeY(screenY - PLAYER_PANEL_HEIGHT_OFFSET);
	Controls.FeatureBorder1:SetSizeY(screenY - PLAYER_PANEL_HEIGHT_OFFSET - 4);
	Controls.FeatureBorder2:SetSizeY(screenY - PLAYER_PANEL_HEIGHT_OFFSET - 6);
	Controls.ScrollBox:SetSizeY(screenY - PLAYER_PANEL_HEIGHT_OFFSET - 275);
	Controls.ScrollBorder1:SetSizeY(screenY - PLAYER_PANEL_HEIGHT_OFFSET - 313);
	Controls.ScrollBorder2:SetSizeY(screenY - PLAYER_PANEL_HEIGHT_OFFSET - 315);
	Controls.FeatureScrollPanel:SetSizeY(screenY - PLAYER_PANEL_HEIGHT_OFFSET - 317);
	Controls.FeatureScrollPanel:CalculateInternalSize();
end

-------------------------------------------------
function OnUpdateUI( type )
    if( type == SystemUpdateUIType.ScreenResize ) then
        AdjustScreenSize();
    end
end
Events.SystemUpdateUI.Add( OnUpdateUI );

AdjustScreenSize();



