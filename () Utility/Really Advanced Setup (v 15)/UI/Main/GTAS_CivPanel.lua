
-- GTAS_CivMain - Part of Really Advanced Setup Mod


include("IconSupport");
include("InstanceManager");
include("FLuaVector");
include("GTAS_Constants");
include("GTAS_Utilities");
include("GTAS_PlotPlacement");

local SlotInstances = {};	-- Container for all player slots

-------------------------------------------------
function BuildSlots()
	for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
		SlotInstances[i].Root:SetHide(true);
	end

	for playerID, slot in SlotData:SlotList() do
		slot.controlInstance = SlotInstances[playerID];

		if slot.civManager == nil then
			slot.civManager = InstanceManager:new("CivInstance", "CivButton", slot.controlInstance.CivStack)
		end
		slot.civManager:ResetInstances();

		if slot.resourceManager == nil then
			slot.resourceManager = InstanceManager:new("IndicatorInstance", "IndicatorButton", slot.controlInstance.ResourceStack)
		end
		slot.resourceManager:ResetInstances();

		if slot.terrainManager == nil then
			slot.terrainManager = InstanceManager:new("IndicatorInstance", "IndicatorButton", slot.controlInstance.TerrainStack)
		end
		slot.terrainManager:ResetInstances();

		if slot.unitManager == nil then
			slot.unitManager = InstanceManager:new("IndicatorInstance", "IndicatorButton", slot.controlInstance.UnitStack)
		end
		slot.unitManager:ResetInstances();

		if slot.wonderManager == nil then
			slot.wonderManager = InstanceManager:new("IndicatorInstance", "IndicatorButton", slot.controlInstance.WonderStack)
		end
		slot.wonderManager:ResetInstances();
		
		slot.controlInstance.Root:SetHide(false);
		
		if playerID == 0 then
			slot.controlInstance.HumanDivider:SetHide(false);
			slot.controlInstance.AIDivider:SetHide(true);
			slot.controlInstance.PlayerGrid:SetSizeX(951);
		else
			slot.controlInstance.HumanDivider:SetHide(true);
			slot.controlInstance.AIDivider:SetHide(false);
		end
	end

	Controls.SlotStack:CalculateSize();
	Controls.SlotStack:ReprocessAnchoring();
	Controls.CivScrollPanel:CalculateInternalSize();

	if MapData.isRandomWorldSize then
		Controls.CivScrollPanel:SetHide(true);
		Controls.UnknownPlayers:SetHide(false);
	else
		Controls.CivScrollPanel:SetHide(false);
		Controls.UnknownPlayers:SetHide(true);
	end
end

-------------------------------------------------
function BuildMenus()
	function GetPlayableCivInfo()
		local civs = {};
		local sql = [[Select	Civilizations.ID as CivID,
								Civilizations.Type as CivType,
								Leaders.ID as LeaderID,
								Civilizations.Description,
								Civilizations.ShortDescription,
								Leaders.Description as LeaderDescription
								from Civilizations, Leaders, Civilization_Leaders
								where Civilizations.Playable = 1 and CivilizationType = Civilizations.Type and LeaderheadType = Leaders.Type]];

		for row in DB.Query(sql) do
			if MapData.activeCivs[row.CivType] then
				table.insert(civs, {
					CivID = row.CivID,
					CivType = row.CivType,
					LeaderID = row.LeaderID,
					LeaderDescription = Locale.Lookup(row.LeaderDescription),
					ShortDescription = Locale.Lookup(row.ShortDescription),
					Description = row.Description,
				});
			end
		end

		table.sort(civs, function(a,b) return Locale.Compare(a.ShortDescription, b.ShortDescription) == -1; end);

		return civs;
	end

	function PopulateCivPulldown(playableCivs, pullDown, playerID)
		pullDown:ClearEntries();

		-- set up the random slot
		local control = {};
		pullDown:BuildEntry("InstanceOne", control);
		control.Button:SetVoids(playerID, -1);
		control.Button:LocalizeAndSetText("TXT_KEY_RANDOM_LEADER");
		control.Button:LocalizeAndSetToolTip("TXT_KEY_RANDOM_LEADER_HELP");

		for id, civ in ipairs(playableCivs) do
			local control = {};
			pullDown:BuildEntry("InstanceOne", control);

			control.Button:SetVoids(playerID, id);
			control.Button:SetText(civ.ShortDescription);
			control.Button:LocalizeAndSetToolTip(civ.Description);
		end

		pullDown:CalculateInternals();

		function OnCivSelected(playerID, id)
			slot = SlotData:GetSlot(playerID)

			if slot ~= nil then
				if playableCivs[id] ~= nil then
					slot.civType = playableCivs[id].CivType;
				else
					slot.civType = RANDOM_CIVILIZATION;
				end
				slot:ResetStartBias();
				PerformBuild();
			end
		end
		pullDown:RegisterSelectionCallback(OnCivSelected);
	end

	local playableCivs = GetPlayableCivInfo();

	for playerID, slot in SlotData:SlotList() do
		PopulateCivPulldown(playableCivs, slot.controlInstance.CivPulldown, playerID);
	end
end

-------------------------------------------------
function BuildCivIcons()
	local MAX_CIV_BUTTONS = 5;

	for playerID, slot in SlotData:SlotList() do
		local control = slot.controlInstance;

		-- Build Civ Icons -------------------------------------------------
		local civ = GameInfo.Civilizations[slot.civType];

		if civ then
			control.CivNumber:LocalizeAndSetText("TXT_KEY_NUMBERING_FORMAT", playerID + 1);
			local civ_leader = GameInfo.Civilization_Leaders("CivilizationType = '" .. civ.Type .. "'")();

			if civ_leader then
				local leader = GameInfo.Leaders[civ_leader.LeaderheadType];

				if leader then
					local civName = slot.civShortDescription;
					
					if civName == "" then
						civName = Locale.ConvertTextKey(civ.ShortDescription)
					end
					control.CivPulldown:GetButton():SetText(civName);

					IconHookup(leader.PortraitIndex, 128, leader.IconAtlas, control.LeaderPortrait);
					local leaderTrait = GameInfo.Leader_Traits("LeaderType = '" .. leader.Type .. "'")();
					
					if leaderTrait then
						local trait = GameInfo.Traits[leaderTrait.TraitType];
						if trait then
							local text;
							
							if leader.Description == nil then
								text = trait.ShortDescription;
							elseif trait.ShortDescription == nil then
								text = leader.Description;
							else 
								text = Locale.ConvertTextKey(leader.Description) .. " - " .. Locale.ConvertTextKey(trait.ShortDescription);
							end
							
							SetIconHelp(control.LeaderPortrait, text, trait.Description);
						end
					else
						control.LeaderPortrait:EnableToolTip(false);
					end

					local count = 1;
					local instance = slot.civManager:GetInstance();
					IconHookup(civ.PortraitIndex, 64, civ.IconAtlas, instance.CivPortrait);
					SetIconHelp(instance.CivPortrait, civ.Description);

					for override in GameInfo.Civilization_UnitClassOverrides("CivilizationType = '" .. civ.Type .. "'") do
						if count >= MAX_CIV_BUTTONS then
							break;
						end
						local unit = GameInfo.Units[override.UnitType];
						if unit then
							count = count + 1;
							local instance = slot.civManager:GetInstance();
							IconHookup(unit.PortraitIndex, 64, unit.IconAtlas, instance.CivPortrait);
							SetIconHelp(instance.CivPortrait, unit.Description, unit.Help);
						end
					end

					for override in GameInfo.Civilization_BuildingClassOverrides("CivilizationType = '" .. civ.Type .. "'") do
						if count >= MAX_CIV_BUTTONS then
							break;
						end
						local building = GameInfo.Buildings[override.BuildingType];
						
						if building then
							count = count + 1;
							local instance = slot.civManager:GetInstance();
							IconHookup(building.PortraitIndex, 64, building.IconAtlas, instance.CivPortrait);
							SetIconHelp(instance.CivPortrait, building.Description, building.Help, building.Strategy);
						end
					end

					for improvement in GameInfo.Improvements("CivilizationType = '" .. civ.Type .. "'") do
						if count >= MAX_CIV_BUTTONS then
							break;
						end
						count = count + 1;
						local instance = slot.civManager:GetInstance();
						IconHookup(improvement.PortraitIndex, 64, improvement.IconAtlas, instance.CivPortrait);
						SetIconHelp(instance.CivPortrait, improvement.Description, improvement.Help);
					end

				end
			end

		else
			slot.civType = RANDOM_CIVILIZATION; -- Should already equal this value - but just in case...
			control.CivNumber:LocalizeAndSetText("TXT_KEY_NUMBERING_FORMAT", playerID + 1);

			if slot.leaderName ~= "" or slot.civShortDescription ~= "" then
				control.CivPulldown:GetButton():LocalizeAndSetText("TXT_KEY_RANDOM_LEADER_CIV", slot.leaderName, slot.civShortDescription);
			else
				control.CivPulldown:GetButton():LocalizeAndSetText("TXT_KEY_RANDOM_CIV");
			end

			IconHookup(22, 128, "LEADER_ATLAS", control.LeaderPortrait);
			control.LeaderPortrait:EnableToolTip(false);
			SetIconHelp(control.LeaderPortrait, "Random Leader");
			
			local instance = slot.civManager:GetInstance();
			SimpleCivIconHookup(-1, 64, instance.CivPortrait);
			SetIconHelp(instance.CivPortrait, "Random Civilization");
		end
	end

	Controls.SlotStack:CalculateSize();
	Controls.SlotStack:ReprocessAnchoring();
	Controls.CivScrollPanel:CalculateInternalSize();
end

-- Attempts to create tool tip help in the format of: text1 .. NEWLINE .. (text2a or text2b).
-- All items are optional. Pass nil for unused values if needed.
function SetIconHelp(control, text1, text2a, text2b)
	text = "";
	addNewLine = false;

	if text1 ~= nil then
		text = Locale.ConvertTextKey(text1);
		addNewLine = true;
	end

	if text2a ~= nil then
		if addNewLine then
			text = text .. Locale.ConvertTextKey("[NEWLINE]") .. Locale.ConvertTextKey(text2a);
		else
			text = text .. Locale.ConvertTextKey(text2a);
		end
	elseif text2b ~= nil then
		if addNewLine then
			text = text .. Locale.ConvertTextKey("[NEWLINE]") .. Locale.ConvertTextKey(text2b);
		else
			text = text .. Locale.ConvertTextKey(text2b);
		end
	end

	if text ~= "" then
		control:SetToolTipString(text);
		control:EnableToolTip(true);
	else
		control:EnableToolTip(false);
	end
end

-------------------------------------------------
function BuildButtons()
	for playerID, slot in SlotData:SlotList() do
		local control = slot.controlInstance;

		-- Build reset button --------------------------------------------
		function OnCivReset()
			slot:SetDefaultValues(playerID);
			PerformBuild();
		end
		control.ResetCivButton:RegisterCallback(Mouse.eLClick, OnCivReset)

		-- Build delete button ------------------------------------------
		if playerID > 1 then
			control.DeleteCivButton:SetHide(false);

			function OnDelete()
				SlotData:RemoveSlot(playerID);
				PerformBuild();
			end
			control.DeleteCivButton:RegisterCallback(Mouse.eLClick, OnDelete)
		else
			control.DeleteCivButton:SetHide(true);
		end

		-- Build bonus button ------------------------------------------
		function OnBonusButton()
			GlobalData.currentPlayer = playerID;
			GlobalData.currentBonusPanel = START_LOWER_PANEL;
			LuaEvents.GTAS_OpenCivBonusPanel();
		end
		control.BonusButton:RegisterCallback(Mouse.eLClick, OnBonusButton);

		function OnResourceButton()
			GlobalData.currentPlayer = playerID;
			GlobalData.currentBonusPanel = RESOURCE_LOWER_PANEL;
			LuaEvents.GTAS_OpenCivBonusPanel();
		end
		control.ResourceButton:RegisterCallback(Mouse.eLClick, OnResourceButton);

		function OnUnitsButton()
			GlobalData.currentPlayer = playerID;
			GlobalData.currentBonusPanel = UNIT_PANEL;
			LuaEvents.GTAS_OpenCivBonusPanel();
		end
		control.UnitButton:RegisterCallback(Mouse.eLClick, OnUnitsButton);

		function OnTerrainButton()
			GlobalData.currentPlayer = playerID;
			GlobalData.currentBonusPanel = TERRAIN_LOWER_PANEL;
			LuaEvents.GTAS_OpenCivBonusPanel();
		end
		control.TerrainButton:RegisterCallback(Mouse.eLClick, OnTerrainButton);

		function OnFeatureButton()
			GlobalData.currentPlayer = playerID;
			GlobalData.currentBonusPanel = FEATURE_LOWER_PANEL;
			LuaEvents.GTAS_OpenCivBonusPanel();
		end
		control.FeatureButton:RegisterCallback(Mouse.eLClick, OnFeatureButton);

		function OnWonderButton()
			GlobalData.currentPlayer = playerID;
			GlobalData.currentBonusPanel = WONDER_LOWER_PANEL;
			LuaEvents.GTAS_OpenCivBonusPanel();
		end
		control.WonderButton:RegisterCallback(Mouse.eLClick, OnWonderButton);
	end
end

-------------------------------------------------
function BuildTeams()
	function PopulateTeamPulldown(pullDown, playerID)
		pullDown:ClearEntries();

		for i = 1, SlotData:GetSlotCount(), 1 do
			local control = {};
			pullDown:BuildEntry("InstanceOne", control);
			control.Button:LocalizeAndSetText("TXT_KEY_MULTIPLAYER_DEFAULT_TEAM_NAME", i);
			control.Button:SetVoids(playerID, i - 1);
		end

		pullDown:CalculateInternals();

		function OnTeamSelected(playerID, playerChoiceID)
			slot = SlotData:GetSlot(playerID);

			if slot ~= nil then
				slot.team = playerChoiceID;
				pullDown:GetButton():LocalizeAndSetText("TXT_KEY_MULTIPLAYER_DEFAULT_TEAM_NAME", slot.team + 1);
			end

			PerformBuild();
		end
		pullDown:RegisterSelectionCallback(OnTeamSelected);

		slot = SlotData:GetSlot(playerID);
		if slot ~= nil then
			pullDown:GetButton():LocalizeAndSetText("TXT_KEY_MULTIPLAYER_DEFAULT_TEAM_NAME", slot.team + 1);
		end
	end

	for playerID, slot in SlotData:SlotList() do
		PopulateTeamPulldown(slot.controlInstance.TeamPullDown, playerID);
	end
end

----------------------------------------------------------------
function BuildBonuses()
	for _, slot in SlotData:SlotList() do
		local control = slot.controlInstance;
		control.GoldValue:SetText(slot.startGold);
		control.CultureValue:SetText(slot.startCulture);
		control.FaithValue:SetText(slot.startFaith);
		control.FreeTechValue:SetText(slot.freeTechs);
	end
end

----------------------------------------------------------------
function CreateIndicatorsForType(playerID, manager, types, gameInfo, panel, maxCount)
	if maxCount < 1 then
		return 0;
	end

	local count = 0;
	local indicatorsActive = false;

	for indicatorType in types do
		count = count + 1;
		indicatorsActive = true;

		local info = gameInfo[indicatorType];
		local instance = manager:GetInstance();

		if info == nil then
			SimpleCivIconHookup(-1, 64, instance.IndicatorPortrait);
			instance.IndicatorPortrait:SetToolTipString("Random");
		else
			IconHookup(info.PortraitIndex, 64, info.IconAtlas, instance.IndicatorPortrait);
			instance.IndicatorPortrait:LocalizeAndSetToolTip(info.Description);
		end

		function OnIndicator()
			GlobalData.currentPlayer = playerID;
			GlobalData.currentBonusPanel = panel;
			LuaEvents.GTAS_OpenCivBonusPanel();
		end
		instance.IndicatorButton:RegisterCallback(Mouse.eLClick, OnIndicator);

		if count >= maxCount then
			break;
		end
	end

	return count;
end

----------------------------------------------------------------
function BuildIndicators()
	local INDICATORS_PER_ROW = 3;
	local INDICATOR_WIDTH = 58;

	for playerID, slot in SlotData:SlotList() do
		-- Resources ---------------------------------------------------------------------------
		slot.resourceManager:ResetInstances();

		local resourceCount = CreateIndicatorsForType(playerID, slot.resourceManager, slot:ResourceTypesList(), GameInfo.Resources,
													  RESOURCE_LOWER_PANEL, INDICATORS_PER_ROW);

		if resourceCount == 0 then
			slot.controlInstance.ResourceLine:SetHide(false);
		else
			slot.controlInstance.ResourceLine:SetHide(true);
		end

		-- Units ---------------------------------------------------------------------------
		slot.unitManager:ResetInstances();

		local unitCount = CreateIndicatorsForType(playerID, slot.unitManager, slot:UnitTypesList(), GameInfo.Units,
												  UNIT_LOWER_PANEL, INDICATORS_PER_ROW);

		if unitCount == 0 then
			slot.controlInstance.UnitLine:SetHide(false);
		else
			slot.controlInstance.UnitLine:SetHide(true);
		end

		-- Terrain and Features ---------------------------------------------------------------------------
		slot.terrainManager:ResetInstances();

		local maxTerrainCount = INDICATORS_PER_ROW;

		if slot:HasFeatures() then
			maxTerrainCount = INDICATORS_PER_ROW - 1;
		end

		local terrainCount = CreateIndicatorsForType(playerID, slot.terrainManager, slot:TerrainTypesList(), GameInfo.Terrains,
													 TERRAIN_LOWER_PANEL, maxTerrainCount);
		local featureCount = CreateIndicatorsForType(playerID, slot.terrainManager, slot:FeatureTypesList(), GameInfo.Features,
													 FEATURE_LOWER_PANEL, INDICATORS_PER_ROW - terrainCount);

		if (terrainCount + featureCount) == 0 then
			slot.controlInstance.TerrainLine:SetHide(false);
		else
			slot.controlInstance.TerrainLine:SetHide(true);
		end

		-- Wonders ---------------------------------------------------------------------------
		slot.wonderManager:ResetInstances();

		local wonderCount = CreateIndicatorsForType(playerID, slot.wonderManager, slot:WonderTypesList(), GameInfo.Features,
													WONDER_LOWER_PANEL, INDICATORS_PER_ROW);

		if wonderCount == 0 then
			slot.controlInstance.WonderLine:SetHide(false);
		else
			slot.controlInstance.WonderLine:SetHide(true);
		end

	end
end

------------------------------------------------------------------
function ValidateControls()
	if MapData.isRandomWorldSize or not SlotData:CanAddSlot()then
		Controls.AddAIButton:SetDisabled(true);
	else
		Controls.AddAIButton:SetDisabled(false);
	end

	LuaEvents.GTAS_ValidateControls();
end

------------------------------------------------------------------
function PerformBuild()
	-- print("Civ Setup PerformBuild ###########################################################################");
	BuildSlots()
	BuildMenus();
	BuildTeams();
	BuildCivIcons();
	BuildButtons();
	BuildBonuses();
	BuildIndicators();
	ValidateControls(); -- This should always get called last.
end
LuaEvents.GTAS_BuildCivPanel.Add(PerformBuild);

----------------------------------------------------------------
function ResetCivPanel()
	for playerID, slot in SlotData:SlotList() do
		slot:SetDefaultValues(playerID);
	end
end
LuaEvents.GTAS_ResetCivPanel.Add(ResetCivPanel);

----------------------------------------------------------------
function OnReset()
	ResetCivPanel();
	PerformBuild();
end
Controls.ResetButton:RegisterCallback(Mouse.eLClick, OnReset);

----------------------------------------------------------------
function OnAddAI()
	SlotData:AddSlot();
	PerformBuild();
end
Controls.AddAIButton:RegisterCallback(Mouse.eLClick, OnAddAI);

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
	local MAIN_PANEL_OFFSET = 176;
	local CIV_LIST_OFFSET = 140;
    local _, screenY = UIManager:GetScreenSizeVal();
	local panelY = screenY - MAIN_PANEL_OFFSET;
	Controls.MainPanel:SetSizeY(panelY);
	Controls.CivScrollPanel:SetSizeY(panelY - CIV_LIST_OFFSET);
    Controls.CivScrollPanel:CalculateInternalSize();
end

-------------------------------------------------
function OnUpdateUI( type )
    if( type == SystemUpdateUIType.ScreenResize ) then
        AdjustScreenSize();
    end
end
Events.SystemUpdateUI.Add( OnUpdateUI );

-- This is a one time initialization function for UI elements.
-- It should NEVER be called more than once.
function CreateSlotInstances()
	SlotInstances[0] = {};
	ContextPtr:BuildInstanceForControl("PlayerSlot", SlotInstances[0], Controls.MainPanel);
	SlotInstances[0].Root:SetHide(true);

	for i = 1, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
		SlotInstances[i] = {};
		ContextPtr:BuildInstanceForControl("PlayerSlot", SlotInstances[i], Controls.SlotStack);
		SlotInstances[i].Root:SetHide(true);
	end
end

CreateSlotInstances();
AdjustScreenSize();





















