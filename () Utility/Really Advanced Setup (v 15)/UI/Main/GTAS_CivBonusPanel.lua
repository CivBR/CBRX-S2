
-- GTAS_CivBonusMain - Part of Really Advanced Setup Mod

-----------------------------------------------------------------
-- Edit Player Panel For Advanced Settings Screen
-----------------------------------------------------------------

include("IconSupport");
include("GTAS_Constants");	

--------------------------------------------------------------------------------------------------
function BuildTopPanel()
	local slot = SlotData:GetSlot(GlobalData.currentPlayer);
		
	if slot ~= nil then
		local civNameNotChanged = true;
		
		for _, slot in SlotData:SlotList() do
			if slot.leaderName ~= "" or slot.civDescription ~= "" or slot.civShortDescription ~= "" or slot.civAdjective ~= "" then
				civNameNotChanged = false;
				break;
			end
		end
	
		Controls.ResetAllNames:SetDisabled(civNameNotChanged);
		
		local civ = GameInfo.Civilizations[slot.civType];
					
		if civ ~= nil then
			Controls.CurrentCivIndex:LocalizeAndSetText("TXT_KEY_NUMBERING_FORMAT", GlobalData.currentPlayer + 1);
			local civ_leader = GameInfo.Civilization_Leaders("CivilizationType = '" .. civ.Type .. "'")();
			
			if civ_leader ~= nil then
				local leader = GameInfo.Leaders[civ_leader.LeaderheadType];
				
				if leader ~= nil then
					local leaderName, civDescription = slot.leaderName, slot.civShortDescription;
					
					if leaderName == "" then
						leaderName = Locale.ConvertTextKey(leader.Description)
					end
					
					if civDescription == "" then
						civDescription = Locale.ConvertTextKey(civ.ShortDescription)
					end
										
					Controls.CurrentCiv:LocalizeAndSetText("TXT_KEY_RANDOM_LEADER_CIV", civDescription, leaderName);
					IconHookup(leader.PortraitIndex, 128, leader.IconAtlas, Controls.Portrait);
				end
			end

		else
			Controls.CurrentCivIndex:LocalizeAndSetText("TXT_KEY_NUMBERING_FORMAT", GlobalData.currentPlayer + 1);
			
			if slot.leaderName ~= "" or slot.civShortDescription ~= "" then
				Controls.CurrentCiv:LocalizeAndSetText("TXT_KEY_RANDOM_LEADER_CIV", slot.civShortDescription, slot.leaderName);

			else
				Controls.CurrentCiv:LocalizeAndSetText("TXT_KEY_RANDOM_CIV");
			end
			
			IconHookup(22, 128, "LEADER_ATLAS", Controls.Portrait);
		end
	end
end

------------------------------------------------------------------------ 
function BuildBottomPanel()
	function OnTerrain()
		GlobalData.currentBonusPanel = TERRAIN_LOWER_PANEL;
		
		Controls.BonusHighlight:SetHide(true);
		Controls.TerrainHighlight:SetHide(false);
		Controls.ResourcesHighlight:SetHide(true);
		Controls.FeaturesHighlight:SetHide(true);
		Controls.WondersHighlight:SetHide(true);
		Controls.UnitsHighlight:SetHide(true);
		
		Controls.CivStartBonus:SetHide(true);
		Controls.CivTerrain:SetHide(false);
		Controls.CivResources:SetHide(true);
		Controls.CivFeatures:SetHide(true);
		Controls.CivWonders:SetHide(true);
		Controls.CivUnits:SetHide(true);
	end
	Controls.TerrainButton:RegisterCallback(Mouse.eLClick, OnTerrain);

	function OnResources()
		GlobalData.currentBonusPanel = RESOURCE_LOWER_PANEL;
		
		Controls.BonusHighlight:SetHide(true);
		Controls.TerrainHighlight:SetHide(true);
		Controls.ResourcesHighlight:SetHide(false);
		Controls.FeaturesHighlight:SetHide(true);
		Controls.WondersHighlight:SetHide(true);
		Controls.UnitsHighlight:SetHide(true);
		
		Controls.CivStartBonus:SetHide(true);
		Controls.CivTerrain:SetHide(true);
		Controls.CivResources:SetHide(false);
		Controls.CivFeatures:SetHide(true);
		Controls.CivWonders:SetHide(true);
		Controls.CivUnits:SetHide(true);
	end
	Controls.ResourcesButton:RegisterCallback(Mouse.eLClick, OnResources);

	function OnFeatures()
		GlobalData.currentBonusPanel = FEATURE_LOWER_PANEL;
		
		Controls.BonusHighlight:SetHide(true);
		Controls.TerrainHighlight:SetHide(true);
		Controls.ResourcesHighlight:SetHide(true);
		Controls.FeaturesHighlight:SetHide(false);
		Controls.WondersHighlight:SetHide(true);
		Controls.UnitsHighlight:SetHide(true);
		
		Controls.CivStartBonus:SetHide(true);
		Controls.CivTerrain:SetHide(true);
		Controls.CivResources:SetHide(true);
		Controls.CivFeatures:SetHide(false);
		Controls.CivWonders:SetHide(true);
		Controls.CivUnits:SetHide(true);
	end
	Controls.FeaturesButton:RegisterCallback(Mouse.eLClick, OnFeatures);

	function OnWonders()
		GlobalData.currentBonusPanel = WONDER_LOWER_PANEL;
		
		Controls.BonusHighlight:SetHide(true);
		Controls.TerrainHighlight:SetHide(true);
		Controls.ResourcesHighlight:SetHide(true);
		Controls.FeaturesHighlight:SetHide(true);
		Controls.WondersHighlight:SetHide(false);
		Controls.UnitsHighlight:SetHide(true);
		
		Controls.CivStartBonus:SetHide(true);
		Controls.CivTerrain:SetHide(true);
		Controls.CivResources:SetHide(true);
		Controls.CivFeatures:SetHide(true);
		Controls.CivWonders:SetHide(false);
		Controls.CivUnits:SetHide(true);
	end
	Controls.WondersButton:RegisterCallback(Mouse.eLClick, OnWonders);

	function OnBonus()
		GlobalData.currentBonusPanel = START_LOWER_PANEL;
		
		Controls.BonusHighlight:SetHide(false);
		Controls.TerrainHighlight:SetHide(true);
		Controls.ResourcesHighlight:SetHide(true);
		Controls.FeaturesHighlight:SetHide(true);
		Controls.WondersHighlight:SetHide(true);
		Controls.UnitsHighlight:SetHide(true);
		
		Controls.CivStartBonus:SetHide(false);
		Controls.CivTerrain:SetHide(true);
		Controls.CivResources:SetHide(true);
		Controls.CivFeatures:SetHide(true);
		Controls.CivWonders:SetHide(true);
		Controls.CivUnits:SetHide(true);
	end
	Controls.BonusButton:RegisterCallback(Mouse.eLClick, OnBonus);

	function OnUnits()
		GlobalData.currentBonusPanel = UNIT_PANEL;

		Controls.BonusHighlight:SetHide(true);
		Controls.TerrainHighlight:SetHide(true);
		Controls.ResourcesHighlight:SetHide(true);
		Controls.FeaturesHighlight:SetHide(true);
		Controls.WondersHighlight:SetHide(true);
		Controls.UnitsHighlight:SetHide(false);
		
		Controls.CivStartBonus:SetHide(true);
		Controls.CivTerrain:SetHide(true);
		Controls.CivResources:SetHide(true);
		Controls.CivFeatures:SetHide(true);
		Controls.CivWonders:SetHide(true);
		Controls.CivUnits:SetHide(false);
	end
	Controls.UnitsButton:RegisterCallback(Mouse.eLClick, OnUnits);

	panels = { 
		[START_LOWER_PANEL] = OnBonus, 
		[TERRAIN_LOWER_PANEL] = OnTerrain, 
		[RESOURCE_LOWER_PANEL] = OnResources, 
		[FEATURE_LOWER_PANEL] = OnFeatures, 
		[WONDER_LOWER_PANEL] = OnWonders, 
		[UNIT_PANEL] = OnUnits, 
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
		if GlobalData.currentPlayer >= SlotData:GetSlotCount() then
			GlobalData.currentPlayer = 0;
		end
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
LuaEvents.GTAS_BuildCivBonusPanel.Add(PerformBuild);

------------------------------------------------------------------
function OnPreviousPlayer()
	GlobalData.currentPlayer = GlobalData.currentPlayer - 1;	
	if GlobalData.currentPlayer < 0 then
		GlobalData.currentPlayer = SlotData:GetSlotCount() - 1;
	end	
	PerformBuild();
end
Controls.PreviousPlayer:RegisterCallback(Mouse.eLClick, OnPreviousPlayer);

------------------------------------------------------------------
function OnNextPlayer()
	GlobalData.currentPlayer = GlobalData.currentPlayer + 1;	
	if GlobalData.currentPlayer >= SlotData:GetSlotCount() then
		GlobalData.currentPlayer = 0;
	end	
	PerformBuild();
end
Controls.NextPlayer:RegisterCallback(Mouse.eLClick, OnNextPlayer);

------------------------------------------------------------------
function OnEditCivName()
	LuaEvents.SetCivNameEditSlot(GlobalData.currentPlayer);
	UIManager:PushModal(Controls.SetCivNames);
end
Controls.EditCivName:RegisterCallback(Mouse.eLClick, OnEditCivName);

------------------------------------------------------------------
function OnResetAllNames()
	for _, slot in SlotData:SlotList() do
		slot.leaderName, slot.civDescription, slot.civShortDescription, slot.civAdjective = "", "", "", "";
	end
	
	PerformBuild();
end
Controls.ResetAllNames:RegisterCallback(Mouse.eLClick, OnResetAllNames);

------------------------------------------------------------------ 
-- function OnReset()
	-- local slot = SlotData:GetSlot(GlobalData.currentPlayer);
	-- if slot ~= nil then
		-- slot:SetDefaultValues(GlobalData.currentPlayer);
	-- end	
	-- PerformBuild();
-- end
-- Controls.ResetButton:RegisterCallback(Mouse.eLClick, OnReset);

------------------------------------------------------------------
function InputHandler(uiMsg, wParam, lParam)
	if uiMsg == KeyEvents.KeyDown then
		if wParam == Keys.VK_LEFT then
			OnPreviousPlayer();
        	return true;
		elseif wParam == Keys.VK_RIGHT then
			OnNextPlayer();
        	return true;
		end
	end
	
	return false;
end
ContextPtr:SetInputHandler(InputHandler);

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












     








