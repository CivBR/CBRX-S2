
-- GTAS_CivTerrain - Part of Really Advanced Setup Mod

include("IconSupport");
include("InstanceManager");

include("GTAS_Constants");
include("GTAS_Utilities");
include("GTAS_TerrainTypes");
include("GTAS_PlotPlacement");
include("GTAS_ScrollText");

local NO_TERRAIN = -1;
local MINIMUM_DISTANCE = 1;
local MAXIMUM_DISTANCE = 25;
local MIN_COUNT = 1;
local MAX_COUNT = 100;

local TerrainID = NO_TERRAIN;
local PlacementType = NEAR_PLACEMENT;
local MinDistance = 1;
local MaxDistance = 3;
local PlotCount = 1;
local ChangeWaterLand = false;
local Elevation = ELEVATION_NO_CHANGE;

local TerrainManager = InstanceManager:new("TerrainInstance", "TerrainRoot", Controls.TerrainStack);
local TerrainHelpManager = InstanceManager:new("TerrainHelpInstance", "TerrainHelpRoot", Controls.TerrainStack);

--------------------------------------------------------------------------------------------------
function BuildTerrain()
	local slot = SlotData:GetSlot(GlobalData.currentPlayer);

	if slot == nil then
		return
	end

	local terrains = {};

	for terrain in GetTerrainList() do
		table.insert(terrains, { id = terrain.ID, description = Locale.ConvertTextKey(terrain.Description) });
	end

	table.sort(terrains, function(a, b) return Locale.Compare(a.description, b.description) == -1; end);

	if TerrainID == NO_TERRAIN then
		TerrainID = terrains[1].id;
	end

	local terrainInfo = GameInfo.Terrains[TerrainID];

	-- Terrain Portrait -------------------------------------------------------------------
	if terrainInfo ~= nil and IconHookup(terrainInfo.PortraitIndex, 256, terrainInfo.IconAtlas, Controls.Portrait) then
		Controls.PortraitFrame:SetHide(false);
	else
		Controls.PortraitFrame:SetHide(true);
	end

	-- Terrain PullDown -------------------------------------------------------------------
	Controls.TerrainPulldown:ClearEntries();

	for terrain in GetList(terrains) do
		local control = {};
		Controls.TerrainPulldown:BuildEntry("InstanceOne", control);
		control.Button:SetVoid1(terrain.id);
		control.Button:LocalizeAndSetText(terrain.description);
	end

	function OnTerrain(id)
		TerrainID = id;
		PerformBuild();
	end
	Controls.TerrainPulldown:RegisterSelectionCallback(OnTerrain);
	
	if terrainInfo ~= nil then
		Controls.TerrainPulldown:GetButton():LocalizeAndSetText(terrainInfo.Description);
	else
		Controls.TerrainPulldown:GetButton():SetText("Terrain Error");
	end
	
	Controls.TerrainPulldown:CalculateInternals();

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

	-- PlotCount Slider ----------------------------------------------------------------
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
	function OnChangeWaterLand(isChecked)
		ChangeWaterLand = isChecked;
	end
	Controls.ChangeWaterLand:RegisterCheckHandler(OnChangeWaterLand)
	Controls.ChangeWaterLand:SetCheck(ChangeWaterLand);

	-- Elevation Radio Buttons --------------------------------------------------------------
	if terrainInfo == nil or terrainInfo.Water then
		Controls.NoElevationLabel:SetHide(false);
		Controls.ElevationLabel:SetHide(true);
		Controls.ElevationNoChange:SetHide(true);
		Controls.ElevationMountain:SetHide(true);
		Controls.ElevationHill:SetHide(true);
		Controls.ElevationFlat:SetHide(true);
		Controls.ElevationRandom:SetHide(true);

	else
		Controls.NoElevationLabel:SetHide(true);
		Controls.ElevationLabel:SetHide(false);
		Controls.ElevationNoChange:SetHide(false);
		Controls.ElevationMountain:SetHide(false);
		Controls.ElevationHill:SetHide(false);
		Controls.ElevationFlat:SetHide(false);
		Controls.ElevationRandom:SetHide(false);

		function OnButtonChanged(elevationType)
			Elevation = elevationType;
		end

		Controls.ElevationNoChange:RegisterCallback(Mouse.eLClick, OnButtonChanged);
		Controls.ElevationNoChange:SetVoid1(ELEVATION_NO_CHANGE);
		Controls.ElevationNoChange:SetCheck(Elevation == ELEVATION_NO_CHANGE);

		Controls.ElevationMountain:RegisterCallback(Mouse.eLClick, OnButtonChanged);
		Controls.ElevationMountain:SetVoid1(ELEVATION_MOUNTAIN);
		Controls.ElevationMountain:SetCheck(Elevation == ELEVATION_MOUNTAIN);

		Controls.ElevationHill:RegisterCallback(Mouse.eLClick, OnButtonChanged);
		Controls.ElevationHill:SetVoid1(ELEVATION_HILLS);
		Controls.ElevationHill:SetCheck(Elevation == ELEVATION_HILLS);

		Controls.ElevationFlat:RegisterCallback(Mouse.eLClick, OnButtonChanged);
		Controls.ElevationFlat:SetVoid1(ELEVATION_FLAT);
		Controls.ElevationFlat:SetCheck(Elevation == ELEVATION_FLAT);

		Controls.ElevationRandom:RegisterCallback(Mouse.eLClick, OnButtonChanged);
		Controls.ElevationRandom:SetVoid1(ELEVATION_RANDOM);
		Controls.ElevationRandom:SetCheck(Elevation == ELEVATION_RANDOM);
	end

	-- Add Terrain Button -----------------------------------------------------------------------------
	function OnAddTerrain()
		if terrainInfo ~= nil then
			slot:AddTerrain(terrainInfo.Type, PlotCount, MinDistance, MaxDistance, PlacementType, ChangeWaterLand, Elevation);
		end
		PerformBuild();
	end
	Controls.AddTerrain:RegisterCallback(Mouse.eLClick, OnAddTerrain);

	-- Copy List Button -----------------------------------------------------------------------------
	function OnCopyList()
		for playerID, otherSlot in SlotData:SlotList() do
			if otherSlot ~= nil and otherSlot ~= slot then
				otherSlot:ResetTerrain();
				for _, terrain in slot:TerrainList() do
					otherSlot:CopyTerrain(terrain);
				end
			end
		end
		PerformBuild();
	end
	Controls.CopyList:RegisterCallback(Mouse.eLClick, OnCopyList);

	-- Clear List Button -----------------------------------------------------------------------------
	function OnClearList()
		slot:ResetTerrain();
		PerformBuild();
	end
	Controls.ClearList:RegisterCallback(Mouse.eLClick, OnClearList);

	-- Terrain ScrollPanel -------------------------------------------------------------------
	TerrainManager:ResetInstances();
	TerrainHelpManager:ResetInstances();

	if slot:HasTerrain() then
		Controls.ListTitle:SetHide(false);

		for index, terrain in slot:TerrainList() do
			local instance = TerrainManager:GetInstance();
			local info = GameInfo.Terrains[terrain.terrainType];

			if info ~= nil then
				IconHookup(info.PortraitIndex, 64, info.IconAtlas, instance.TerrainPortrait);
				instance.TerrainName:LocalizeAndSetText(info.Description);
			else
				IconHookup(22, 64, "LEADER_ATLAS", instance.TerrainPortrait);
				instance.TerrainName:LocalizeAndSetText("Random");
			end

			if terrain.placementType ~= FILL_PLACEMENT then
				instance.TerrainCount:SetText(tostring(terrain.count));
			else
				instance.TerrainCount:SetText("*");
			end

			instance.TerrainMinRad:SetText(tostring(terrain.minDistance));
			instance.TerrainMaxRad:SetText(tostring(terrain.maxDistance));
			instance.TerrainPlacement:SetText(GetPlacementText(terrain.placementType));
			instance.TerrainElevation:SetText(GetElevationText(terrain.elevation));
			instance.TerrainWaterLand:SetText(terrain.changeWaterLand and "Yes" or "No");

			function OnTerrainButton()
				if info ~= nil then
					TerrainID = info.ID;
				end

				if terrain.placementType ~= FILL_PLACEMENT then
					PlotCount = terrain.count;
				end

				MinDistance = terrain.minDistance;
				MaxDistance = terrain.maxDistance;
				PlacementType = terrain.placementType;
				Elevation = terrain.elevation;
				ChangeWaterLand = terrain.changeWaterLand;
				PerformBuild();
			end
			instance.TerrainButton:RegisterCallback(Mouse.eLClick, OnTerrainButton);

			function OnUpdate()
				if terrainInfo ~= nil then
					slot:UpdateTerrain(index, terrainInfo.Type, PlotCount, MinDistance, MaxDistance, PlacementType, ChangeWaterLand, Elevation);
				end
				PerformBuild();
			end
			instance.UpdateTerrain:RegisterCallback(Mouse.eLClick, OnUpdate);

			function OnDelete()
				slot:RemoveTerrain(index);
				PerformBuild();
			end
			instance.DeleteTerrain:RegisterCallback(Mouse.eLClick, OnDelete);
		end

	else
		Controls.ListTitle:SetHide(true);
		CreateScrollText(TerrainCivText, TerrainHelpManager);
	end

	Controls.TerrainStack:CalculateSize();
	Controls.TerrainStack:ReprocessAnchoring();
	Controls.TerrainScrollPanel:ReprocessAnchoring();
	Controls.TerrainScrollPanel:CalculateInternalSize();
end

------------------------------------------------------------------
function ValidateControls()
	LuaEvents.GTAS_ValidateControls();
end

----------------------------------------------------------------
function PerformBuild()
	BuildTerrain();
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
	Controls.TerrainPanel:SetSizeY(screenY - PLAYER_PANEL_HEIGHT_OFFSET);
	Controls.TerrainBorder1:SetSizeY(screenY - PLAYER_PANEL_HEIGHT_OFFSET - 4);
	Controls.TerrainBorder2:SetSizeY(screenY - PLAYER_PANEL_HEIGHT_OFFSET - 6);
	Controls.ScrollBox:SetSizeY(screenY - PLAYER_PANEL_HEIGHT_OFFSET - 275);
	Controls.ScrollBorder1:SetSizeY(screenY - PLAYER_PANEL_HEIGHT_OFFSET - 313);
	Controls.ScrollBorder2:SetSizeY(screenY - PLAYER_PANEL_HEIGHT_OFFSET - 315);
	Controls.TerrainScrollPanel:SetSizeY(screenY - PLAYER_PANEL_HEIGHT_OFFSET - 317);
	Controls.TerrainScrollPanel:CalculateInternalSize();
end

-------------------------------------------------
function OnUpdateUI( type )
    if( type == SystemUpdateUIType.ScreenResize ) then
        AdjustScreenSize();
    end
end
Events.SystemUpdateUI.Add( OnUpdateUI );

AdjustScreenSize();



