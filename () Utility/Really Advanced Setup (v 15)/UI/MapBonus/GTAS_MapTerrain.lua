
-- GTAS_MapTerrain - Part of Really Advanced Setup Mod

include("IconSupport");
include("InstanceManager");

include("GTAS_Constants");
include("GTAS_Utilities");
include("GTAS_TerrainTypes");
include("GTAS_PlotPlacement");
include("GTAS_ScrollText");

local NO_TERRAIN = -1;
local MAX_COUNT = 100;

local TerrainID = NO_TERRAIN;
local PlotCount = 1;
local ChangeWaterLand = false;
local Elevation = ELEVATION_NO_CHANGE;

local TerrainManager = InstanceManager:new("TerrainInstance", "TerrainRoot", Controls.TerrainStack);
local TerrainHelpManager = InstanceManager:new("TerrainHelpInstance", "TerrainHelpRoot", Controls.TerrainStack);

--------------------------------------------------------------------------------------------------
function BuildTerrain()
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

	-- PlotCount Slider ----------------------------------------------------------------
	function OnPlotCount(fValue)
		PlotCount = GetSliderValue(fValue, 1, MAX_COUNT);
		Controls.CountValue:SetText(tostring(PlotCount));
	end
	Controls.CountSlider:RegisterSliderCallback(OnPlotCount);
	SetSliderValue(Controls.CountSlider, PlotCount, 1, MAX_COUNT);
	Controls.CountValue:SetText(tostring(PlotCount));

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
			MapData:AddTerrain(terrainInfo.Type, PlotCount, 0, 0, MAP_PLACEMENT, ChangeWaterLand, Elevation);
		end
		PerformBuild();
	end
	Controls.AddTerrain:RegisterCallback(Mouse.eLClick, OnAddTerrain);

	-- Clear List Button -----------------------------------------------------------------------------
	function OnClearList()
		MapData:ResetTerrain();
		PerformBuild();
	end
	Controls.ClearList:RegisterCallback(Mouse.eLClick, OnClearList);

	-- Terrain ScrollPanel -------------------------------------------------------------------
	TerrainManager:ResetInstances();
	TerrainHelpManager:ResetInstances();

	if MapData:HasTerrain() then
		Controls.ListTitle:SetHide(false);

		for index, terrain in MapData:TerrainList() do
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

			instance.TerrainMinRad:SetText("*");
			instance.TerrainMaxRad:SetText("*");
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

				Elevation = terrain.elevation;
				ChangeWaterLand = terrain.changeWaterLand;
				PerformBuild();
			end
			instance.TerrainButton:RegisterCallback(Mouse.eLClick, OnTerrainButton);

			function OnUpdate()
				if terrainInfo ~= nil then
					MapData:UpdateTerrain(index, terrainInfo.Type, PlotCount, 0, 0, MAP_PLACEMENT, ChangeWaterLand, Elevation);
				end
				PerformBuild();
			end
			instance.UpdateTerrain:RegisterCallback(Mouse.eLClick, OnUpdate);

			function OnDelete()
				MapData:RemoveTerrain(index);
				PerformBuild();
			end
			instance.DeleteTerrain:RegisterCallback(Mouse.eLClick, OnDelete);
		end

	else
		Controls.ListTitle:SetHide(true);
		CreateScrollText(TerrainMapText, TerrainHelpManager);
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



