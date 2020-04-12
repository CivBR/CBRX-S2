
-- GTAS_MapWonders - Part of Really Advanced Setup Mod

include("IconSupport");
include("InstanceManager");

include("GTAS_Constants");
include("GTAS_Utilities");
include("GTAS_PlotPlacement");
include("GTAS_ScrollText");
include("GTAS_WonderTypes");

local NO_WONDER = -1;
local RANDOM_WONDER = -2;
local MAX_COUNT = 50;

local WonderID = NO_WONDER;
local PlacementType = NEAR_PLACEMENT;
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
	-- Init WonderID and create a list of wonders if needed ----------------------------------
	local wonders = {};
	for feature in GetWonderList() do
		table.insert(wonders, { id = feature.ID, description = Locale.ConvertTextKey(feature.Description) });
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
	Controls.WonderPulldown:RegisterSelectionCallback(OnWonder)

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

	-- Wonder PlotCount Slider ----------------------------------------------------------------
	function OnPlotCount(fValue)
		PlotCount = GetSliderValue(fValue, 1, MAX_COUNT);
		Controls.CountValue:SetText(tostring(PlotCount));
	end
	Controls.CountSlider:RegisterSliderCallback(OnPlotCount);
	SetSliderValue(Controls.CountSlider, PlotCount, 1, MAX_COUNT);
	Controls.CountValue:SetText(tostring(PlotCount));

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

		MapData:AddWonder(wonderType, PlotCount, 0, 0, PlacementType, AddSprinkles);
		PerformBuild();
	end
	Controls.AddWonder:RegisterCallback(Mouse.eLClick, OnAddWonder);

	-- Clear List Button -----------------------------------------------------------------------------
	function OnClearList()
		MapData:ResetWonders();
		PerformBuild();
	end
	Controls.ClearList:RegisterCallback(Mouse.eLClick, OnClearList);

	-- Wonder ScrollPanel -------------------------------------------------------------------
	WonderManager:ResetInstances();
	WonderHelpManager:ResetInstances();

	if MapData:HasWonders() then
		Controls.ListTitle:SetHide(false);

		for index, wonder in MapData:WonderList() do
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

			instance.WonderMinRad:SetText("*");
			instance.WonderMaxRad:SetText("*");
			instance.WonderPlacement:SetText(GetPlacementText(wonder.placementType));
			instance.WonderSprinkle:SetText(wonder.addSprinkles and "Yes" or "No");

			function OnWonderButton()
				if info ~= nil then
					WonderID = info.ID;
				else
					WonderID = RANDOM_WONDER;
				end

				PlotCount = wonder.count;
				PlacementType = wonder.placementType;
				AddSprinkles = wonder.addSprinkles;
				PerformBuild();
			end
			instance.WonderButton:RegisterCallback(Mouse.eLClick, OnWonderButton);

			function OnUpdate()
				if wonderInfo ~= nil then
					MapData:UpdateWonder(index, wonderInfo.Type, PlotCount, 0, 0, MAP_PLACEMENT, AddSprinkles);
				else
					MapData:UpdateWonder(index, RANDOM_WONDER, PlotCount, 0, 0, MAP_PLACEMENT, AddSprinkles);
				end
				PerformBuild();
			end
			instance.UpdateWonder:RegisterCallback(Mouse.eLClick, OnUpdate);

			function OnDelete()
				MapData:RemoveWonder(index);
				PerformBuild();
			end
			instance.DeleteWonder:RegisterCallback(Mouse.eLClick, OnDelete);
		end

	else
		Controls.ListTitle:SetHide(true);
		CreateScrollText(NaturalWonderMapText, WonderHelpManager);
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



