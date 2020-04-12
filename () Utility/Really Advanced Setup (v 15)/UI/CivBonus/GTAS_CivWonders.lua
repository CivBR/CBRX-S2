
-- GTAS_CivWonders - Part of Really Advanced Setup Mod

include("IconSupport");
include("InstanceManager");

include("GTAS_Constants");
include("GTAS_Utilities");
include("GTAS_PlotPlacement");
include("GTAS_ScrollText");
include("GTAS_WonderTypes");

local NO_WONDER = -1;
local RANDOM_WONDER = -2;
local MINIMUM_DISTANCE = 2;
local MAXIMUM_DISTANCE = 25;
local MIN_COUNT = 1;
local MAX_COUNT = 50;

local WonderID = NO_WONDER;
local PlacementType = NEAR_PLACEMENT;
local MinDistance = 2;
local MaxDistance = 3;
local PlotCount = 1;
local AddSprinkles = false;

local WonderManager = InstanceManager:new("WonderInstance", "WonderRoot", Controls.WonderStack)
local WonderHelpManager = InstanceManager:new("WonderHelpInstance", "WonderHelpRoot", Controls.WonderStack)

--------------------------------------------------------------------------------------------------
function BuildWonders()
	if MapData.disableAllNaturalWonders then
		Controls.ScrollBox:SetHide(true);
		Controls.ControlBox:SetHide(true);
		Controls.DisabledLabel1:SetHide(false);
		Controls.DisabledLabel2:SetHide(false);
	else
		Controls.ScrollBox:SetHide(false);
		Controls.ControlBox:SetHide(false);
		Controls.DisabledLabel1:SetHide(true);
		Controls.DisabledLabel2:SetHide(true);
		BuildControls();
	end
end

-------------------------------------------------------------------------------
function BuildControls()
	local slot = SlotData:GetSlot(GlobalData.currentPlayer);

	if slot == nil then
		return
	end

	local wonders = {};
	for feature in GetWonderList() do
		table.insert(wonders, { id = feature.ID, description = feature.Description });
	end

	table.sort(wonders, function(a, b) return Locale.Compare(a.description, b.description) == -1; end);
	table.insert(wonders, 1, { id = RANDOM_WONDER, description = "Random" });

	if WonderID == NO_WONDER then
		WonderID = wonders[1].id;
	end

	local wonderInfo = GameInfo.Features[WonderID];

	-- Wonder Portrait -------------------------------------------------------------------
	if wonderInfo ~= nil then
		if IconHookup(wonderInfo.PortraitIndex, 256, wonderInfo.IconAtlas, Controls.Portrait) then
			Controls.PortraitFrame:SetHide(false);
			-- Controls.PortraitFrame:SetToolTipString(GetWonderText(wonderInfo));
		else
			Controls.PortraitFrame:SetHide(true);
			Controls.PortraitFrame:SetToolTipString();
		end
	else
		IconHookup(22, 256, "LEADER_ATLAS", Controls.Portrait);
		Controls.PortraitFrame:SetHide(false);
		-- Controls.PortraitFrame:SetToolTipString("Natural Wonders will be randomly selected.");
	end
	
	Controls.PortraitFrame:SetToolTipString(GetWonderText(wonderInfo));

	-- Wonder PullDown -------------------------------------------------------------------
	Controls.WonderPulldown:ClearEntries();

	for wonder in GetList(wonders) do
		local control = {};
		Controls.WonderPulldown:BuildEntry("InstanceOne", control);
		control.Button:SetVoid1(wonder.id);
		control.Button:LocalizeAndSetText(wonder.description);
	end

	function OnWonder(id)
		WonderID = id;
		PerformBuild();
	end
	Controls.WonderPulldown:RegisterSelectionCallback(OnWonder);
	
	if wonderInfo ~= nil then
		Controls.WonderPulldown:GetButton():LocalizeAndSetText(wonderInfo.Description);
	elseif WonderID == RANDOM_WONDER then
		Controls.WonderPulldown:GetButton():SetText("Random");
	else
		Controls.WonderPulldown:GetButton():SetText("Wonder Error");
	end
	
	Controls.WonderPulldown:CalculateInternals();

	-- Add Sprinkles CheckBox --------------------------------------------------------------
	function OnAddSprinkles(isChecked)
		AddSprinkles = isChecked;
	end
	Controls.AddSprinkles:RegisterCheckHandler(OnAddSprinkles)
	Controls.AddSprinkles:SetCheck(AddSprinkles);

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

	-- Wonder PlotCount Slider ----------------------------------------------------------------
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

	-- Display Max Copies ----------------------------------------------------------------------
	if MapData.maxWonderCopies < 0 then
		Controls.MaxCopiesValue:SetText("Unlimited");
	elseif MapData.maxWonderCopies == 1 then
		Controls.MaxCopiesValue:SetText("Single (Default)");
	else
		Controls.MaxCopiesValue:SetText(tostring(MapData.maxWonderCopies));
	end

	-- Add Wonder Button -----------------------------------------------------------------------------
	function OnAddWonder()
		local wonderType;

		if wonderInfo ~= nil then
			wonderType = wonderInfo.Type;
		else
			wonderType = RANDOM_WONDER;
		end

		slot:AddWonder(wonderType, PlotCount, MinDistance, MaxDistance, PlacementType, AddSprinkles);
		PerformBuild();
	end
	Controls.AddWonder:RegisterCallback(Mouse.eLClick, OnAddWonder);

	-- Copy List Button -----------------------------------------------------------------------------
	function OnCopyList()
		for playerID, otherSlot in SlotData:SlotList() do
			if otherSlot ~= nil and otherSlot ~= slot then
				otherSlot:ResetWonders();
				for _, wonder in slot:WonderList() do
					otherSlot:CopyWonder(wonder);
				end
			end
		end
		PerformBuild();
	end
	Controls.CopyList:RegisterCallback(Mouse.eLClick, OnCopyList);

	-- Clear List Button -----------------------------------------------------------------------------
	function OnClearList()
		slot:ResetWonders();
		PerformBuild();
	end
	Controls.ClearList:RegisterCallback(Mouse.eLClick, OnClearList);

	-- Wonder ScrollPanel -------------------------------------------------------------------
	WonderManager:ResetInstances();
	WonderHelpManager:ResetInstances();

	if slot:HasWonders() then
		Controls.ListTitle:SetHide(false);

		for index, wonder in slot:WonderList() do
			local instance = WonderManager:GetInstance();
			local info = GameInfo.Features[wonder.featureType];

			if info ~= nil then
				IconHookup(info.PortraitIndex, 64, info.IconAtlas, instance.WonderPortrait);
				instance.WonderName:LocalizeAndSetText(info.Description);
			else
				IconHookup(22, 64, "LEADER_ATLAS", instance.WonderPortrait);
				instance.WonderName:LocalizeAndSetText("Random");
			end

			if wonder.placementType ~= FILL_PLACEMENT then
				instance.WonderCount:SetText(tostring(wonder.count));
			else
				instance.WonderCount:SetText("*");
			end

			instance.WonderMinRad:SetText(tostring(wonder.minDistance));
			instance.WonderMaxRad:SetText(tostring(wonder.maxDistance));
			instance.WonderPlacement:SetText(GetPlacementText(wonder.placementType));
			instance.WonderSprinkle:SetText(wonder.addSprinkles and "Yes" or "No");

			function OnWonderButton()
				if info ~= nil then
					WonderID = info.ID;
				else
					WonderID = RANDOM_WONDER;
				end

				if wonder.placementType ~= FILL_PLACEMENT then
					PlotCount = wonder.count;
				end

				MinDistance = wonder.minDistance;
				MaxDistance = wonder.maxDistance;
				PlacementType = wonder.placementType;
				AddSprinkles = wonder.addSprinkles;
				PerformBuild();
			end
			instance.WonderButton:RegisterCallback(Mouse.eLClick, OnWonderButton);

			function OnUpdate()
				if wonderInfo ~= nil then
					slot:UpdateWonder(index, wonderInfo.Type, PlotCount, MinDistance, MaxDistance, PlacementType, AddSprinkles);
				else
					slot:UpdateWonder(index, RANDOM_WONDER, PlotCount, MinDistance, MaxDistance, PlacementType, AddSprinkles);
				end
				PerformBuild();
			end
			instance.UpdateWonder:RegisterCallback(Mouse.eLClick, OnUpdate);

			function OnDelete()
				slot:RemoveWonder(index);
				PerformBuild();
			end
			instance.DeleteWonder:RegisterCallback(Mouse.eLClick, OnDelete);
		end

	else
		Controls.ListTitle:SetHide(true);
		CreateScrollText(NaturalWonderCivText, WonderHelpManager);
	end

	Controls.WonderStack:CalculateSize();
	Controls.WonderStack:ReprocessAnchoring();
	Controls.WonderScrollPanel:ReprocessAnchoring();
	Controls.WonderScrollPanel:CalculateInternalSize();
end

------------------------------------------------------------------
function ValidateControls()
	LuaEvents.GTAS_ValidateControls();
end

----------------------------------------------------------------
function PerformBuild()
	BuildWonders();
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
	Controls.WonderPanel:SetSizeY(screenY - PLAYER_PANEL_HEIGHT_OFFSET);
	Controls.WonderBorder1:SetSizeY(screenY - PLAYER_PANEL_HEIGHT_OFFSET - 4);
	Controls.WonderBorder2:SetSizeY(screenY - PLAYER_PANEL_HEIGHT_OFFSET - 6);
	Controls.ScrollBox:SetSizeY(screenY - PLAYER_PANEL_HEIGHT_OFFSET - 275);
	Controls.ScrollBorder1:SetSizeY(screenY - PLAYER_PANEL_HEIGHT_OFFSET - 313);
	Controls.ScrollBorder2:SetSizeY(screenY - PLAYER_PANEL_HEIGHT_OFFSET - 315);
	Controls.WonderScrollPanel:SetSizeY(screenY - PLAYER_PANEL_HEIGHT_OFFSET - 317);
	Controls.WonderScrollPanel:CalculateInternalSize();
end

-------------------------------------------------
function OnUpdateUI( type )
    if( type == SystemUpdateUIType.ScreenResize ) then
        AdjustScreenSize();
    end
end
Events.SystemUpdateUI.Add( OnUpdateUI );

AdjustScreenSize();



