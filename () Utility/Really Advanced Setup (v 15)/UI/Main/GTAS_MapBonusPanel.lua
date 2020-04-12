
-- GTAS_MapBonusMain - Part of Really Advanced Setup Mod


include("IconSupport");
include("InstanceManager");
include("GTAS_Constants");	

TerrainManager = InstanceManager:new("IndicatorInstance", "IndicatorButton", Controls.TerrainTopStack)
FeatureManager = InstanceManager:new("IndicatorInstance", "IndicatorButton", Controls.FeatureTopStack)
ResourceManager = InstanceManager:new("IndicatorInstance", "IndicatorButton", Controls.ResourceTopStack)
WonderManager = InstanceManager:new("IndicatorInstance", "IndicatorButton", Controls.WonderTopStack)

--------------------------------------------------------------------------------------------------
function BuildTopPanel()
	local INDICATORS_PER_ROW = 6;
	local INDICATOR_WIDTH = 58;
			
	local indicatorSlots = {
		{	types = MapData:TerrainTypesList(),
			button = Controls.TerrainTopButton, line = Controls.TerrainTopLine,
			manager = TerrainManager, panel = TERRAIN_LOWER_PANEL, info = GameInfo.Terrains, };
		{ 	types = MapData:FeatureTypesList(),
			button = Controls.FeatureTopButton, line = Controls.FeatureTopLine,
			manager = FeatureManager, panel = FEATURE_LOWER_PANEL, info = GameInfo.Features, };
		{	types = MapData:ResourceTypesList(), 
			button = Controls.ResourceTopButton, line = Controls.ResourceTopLine,
			manager = ResourceManager, panel = RESOURCE_LOWER_PANEL, info = GameInfo.Resources, };
		{	types = MapData:WonderTypesList(),
			button = Controls.WonderTopButton, line = Controls.WonderTopLine,
			manager = WonderManager, panel = WONDER_LOWER_PANEL, info = GameInfo.Features, };
	};		
		
	for _, indicatorSlot in ipairs(indicatorSlots) do
		indicatorSlot.manager:ResetInstances();
		local count = 0;
		local indicatorsActive = false;
		
		for indicatorType in indicatorSlot.types do
			count = count + 1;
			indicatorsActive = true;
			
			local info = indicatorSlot.info[indicatorType];				
			local instance = indicatorSlot.manager:GetInstance();

			if info == nil then
				SimpleCivIconHookup(-1, 64, instance.IndicatorPortrait);		
				instance.IndicatorPortrait:SetToolTipString("Randomly Selected");
			else
				IconHookup(info.PortraitIndex, 64, info.IconAtlas, instance.IndicatorPortrait);
				instance.IndicatorPortrait:LocalizeAndSetToolTip(info.Description);
			end
			
			function OnIndicator()
				GlobalData.currentBonusPanel = indicatorSlot.panel;
				LuaEvents.GTAS_OpenMapBonusPanel();
			end
			instance.IndicatorButton:RegisterCallback(Mouse.eLClick, OnIndicator);
			
			if count >= INDICATORS_PER_ROW then
				break;
			end
		end
		
		if indicatorsActive then
			indicatorSlot.line:SetHide(true);
		else
			indicatorSlot.line:SetHide(false);			
		end
		
		function OnButton()
			GlobalData.currentBonusPanel = indicatorSlot.panel;
			LuaEvents.GTAS_OpenMapBonusPanel();
		end
		indicatorSlot.button:RegisterCallback(Mouse.eLClick, OnButton);		
	end		
end

------------------------------------------------------------------------ 
function BuildBottomPanel()
	function OnTerrain()
		GlobalData.currentBonusPanel = TERRAIN_LOWER_PANEL;
		
		Controls.TerrainHighlight:SetHide(false);
		Controls.ResourcesHighlight:SetHide(true);
		Controls.FeaturesHighlight:SetHide(true);
		Controls.WondersHighlight:SetHide(true);
		
		Controls.MapTerrain:SetHide(false);
		Controls.MapResources:SetHide(true);
		Controls.MapFeatures:SetHide(true);
		Controls.MapWonders:SetHide(true);
	end
	Controls.TerrainButton:RegisterCallback(Mouse.eLClick, OnTerrain);

	function OnResources()
		GlobalData.currentBonusPanel = RESOURCE_LOWER_PANEL;
		
		Controls.TerrainHighlight:SetHide(true);
		Controls.ResourcesHighlight:SetHide(false);
		Controls.FeaturesHighlight:SetHide(true);
		Controls.WondersHighlight:SetHide(true);
		
		Controls.MapTerrain:SetHide(true);
		Controls.MapResources:SetHide(false);
		Controls.MapFeatures:SetHide(true);
		Controls.MapWonders:SetHide(true);
	end
	Controls.ResourcesButton:RegisterCallback(Mouse.eLClick, OnResources);

	function OnFeatures()
		GlobalData.currentBonusPanel = FEATURE_LOWER_PANEL;
		
		Controls.TerrainHighlight:SetHide(true);
		Controls.ResourcesHighlight:SetHide(true);
		Controls.FeaturesHighlight:SetHide(false);
		Controls.WondersHighlight:SetHide(true);
		
		Controls.MapTerrain:SetHide(true);
		Controls.MapResources:SetHide(true);
		Controls.MapFeatures:SetHide(false);
		Controls.MapWonders:SetHide(true);
	end
	Controls.FeaturesButton:RegisterCallback(Mouse.eLClick, OnFeatures);

	function OnWonders()
		GlobalData.currentBonusPanel = WONDER_LOWER_PANEL;
		
		Controls.TerrainHighlight:SetHide(true);
		Controls.ResourcesHighlight:SetHide(true);
		Controls.FeaturesHighlight:SetHide(true);
		Controls.WondersHighlight:SetHide(false);
		
		Controls.MapTerrain:SetHide(true);
		Controls.MapResources:SetHide(true);
		Controls.MapFeatures:SetHide(true);
		Controls.MapWonders:SetHide(false);
	end
	Controls.WondersButton:RegisterCallback(Mouse.eLClick, OnWonders);

	panels = { 
		[START_LOWER_PANEL] = OnTerrain,
		[TERRAIN_LOWER_PANEL] = OnTerrain, 
		[RESOURCE_LOWER_PANEL] = OnResources, 
		[FEATURE_LOWER_PANEL] = OnFeatures, 
		[WONDER_LOWER_PANEL] = OnWonders, 
		[UNIT_PANEL] = OnWonders, 
	};
	
	buildPanel = panels[GlobalData.currentBonusPanel];
	
	if buildPanel ~= nil then
		buildPanel();
	end
end

------------------------------------------------------------------ 
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

------------------------------------------------------------------
function ValidateControls()
	LuaEvents.GTAS_ValidateControls();
end

------------------------------------------------------------------
function PerformBuild()
	BuildTopPanel();
	BuildBottomPanel();	
	ValidateControls(); -- This should always get called last.
end
LuaEvents.GTAS_BuildMapBonusPanel.Add(PerformBuild);

------------------------------------------------------------------ 
function ResetMapBonusPanel()
	MapData:ResetTerrain();
	MapData:ResetFeatures();
	MapData:ResetResources();
	MapData:ResetWonders();
end
LuaEvents.GTAS_ResetMapBonusPanel.Add(ResetMapBonusPanel)

------------------------------------------------------------------ 
function OnReset()
	ResetMapBonusPanel();
	PerformBuild();
end
Controls.ResetButton:RegisterCallback(Mouse.eLClick, OnReset);

------------------------------------------------------------------ 
function UpdateMapBonusTopPanel()
	BuildTopPanel();
end
LuaEvents.GTAS_UpdateMapBonusTopPanel.Add(UpdateMapBonusTopPanel);

------------------------------------------------------------------
function AdjustScreenSize()	
	local MAIN_PANEL_OFFSET = 176;
	
    local _, screenY = UIManager:GetScreenSizeVal();	
	Controls.MainPanel:SetSizeY(screenY - MAIN_PANEL_OFFSET);
end
 
------------------------------------------------------------------
function OnUpdateUI(updateType)
    if updateType == SystemUpdateUIType.ScreenResize then
        AdjustScreenSize();
    end
end
Events.SystemUpdateUI.Add(OnUpdateUI);

AdjustScreenSize();












     








