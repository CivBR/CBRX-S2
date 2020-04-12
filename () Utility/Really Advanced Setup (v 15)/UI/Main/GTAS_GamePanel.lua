
-- GTAS_GameSetup - Part of Really Advanced Setup Mod

-----------------------------------------------------------------
-- Game Panel For Advanced Settings Screen
-----------------------------------------------------------------

-- print("GTAS_GameSetup *************************************************************************************************");

include("InstanceManager");
include("GTAS_Constants");

-------------------------------------------------
-- Globals
-------------------------------------------------
VictoryCondtionsManager = InstanceManager:new("VictoryInstance", "VictoryRoot", Controls.VictoryConditionsStack);
GameOptionsManager = InstanceManager:new("AdvancedOptionInstance", "AdvancedOptionRoot", Controls.GameOptionsStack);
ReallyOptionsManager = InstanceManager:new("ReallyOptionInstance", "ReallyOptionRoot", Controls.ReallyAdvOptionsStack);


----------------------------------------------------------------------------------------------------------------------------------
-- Handicap
----------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------
function BuildHandicap()
	local pullDown = Controls.HandicapPullDown;
	pullDown:ClearEntries();

	for info in GameInfo.HandicapInfos() do
		-- print(string.format("id = %i, type = %s, description = %s", info.ID, info.Type, info.Description));
		if ( info.Type ~= "HANDICAP_AI_DEFAULT" ) then
			local instance = {};
			pullDown:BuildEntry("InstanceOne", instance);
			instance.Button:LocalizeAndSetText(info.Description);
			instance.Button:LocalizeAndSetToolTip(info.Help);
			instance.Button:SetVoid1(info.ID);
		end
	end

	pullDown:CalculateInternals();

	function OnHandicapSelected(id)
		local handicap = GameInfo.HandicapInfos[id];
		if handicap then
			GameData.handicap = handicap.ID;
			pullDown:GetButton():LocalizeAndSetText(handicap.Description);
			pullDown:GetButton():LocalizeAndSetToolTip(handicap.Help);
		end
		PerformBuild();
	end
	pullDown:RegisterSelectionCallback(OnHandicapSelected);

	local info = GameInfo.HandicapInfos[GameData.handicap];
	if info then
		Controls.HandicapPullDown:GetButton():LocalizeAndSetText(info.Description);
		Controls.HandicapPullDown:GetButton():LocalizeAndSetToolTip(info.Help);
	end
end

----------------------------------------------------------------------------------------------------------------------------------
-- Game Speed
----------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------
function BuildGameSpeed()
	local pullDown = Controls.GameSpeedPullDown;
	pullDown:ClearEntries();
	local gameSpeeds = {};

	for row in GameInfo.GameSpeeds() do
		table.insert(gameSpeeds, row);
	end
	table.sort(gameSpeeds, function(a, b) return b.VictoryDelayPercent > a.VictoryDelayPercent end);

	for _, v in ipairs(gameSpeeds) do
		local instance = {};
		pullDown:BuildEntry("InstanceOne", instance);
		instance.Button:SetText(Locale.ConvertTextKey(v.Description));
		instance.Button:SetToolTipString(Locale.ConvertTextKey(v.Help));
		instance.Button:SetVoid1(v.ID);
	end

	pullDown:CalculateInternals();

	function OnGameSpeedSelected(id)
		local gameSpeed = GameInfo.GameSpeeds[id];
		if gameSpeed then
			GameData.gameSpeed = id;
			pullDown:GetButton():LocalizeAndSetText(gameSpeed.Description);
			pullDown:GetButton():SetToolTipString(Locale.ConvertTextKey(gameSpeed.Help));
		end
	end
	pullDown:RegisterSelectionCallback(OnGameSpeedSelected);

	local info = GameInfo.GameSpeeds[GameData.gameSpeed];
	if info then
		Controls.GameSpeedPullDown:GetButton():LocalizeAndSetText(info.Description);
		Controls.GameSpeedPullDown:GetButton():SetToolTipString(Locale.ConvertTextKey(info.Help));
	end
end

----------------------------------------------------------------------------------------------------------------------------------
-- Game Era
----------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------
function BuildEra()
	local pullDown = Controls.EraPullDown;
	pullDown:ClearEntries();

	for info in GameInfo.Eras() do
		local instance = {};
		pullDown:BuildEntry("InstanceOne", instance);
		instance.Button:LocalizeAndSetText(info.Description);
		instance.Button:SetVoid1(info.ID);
	end

	pullDown:CalculateInternals();

	function OnEraSelected(id)
		local era = GameInfo.Eras[id];
		if era then
			GameData.era = id;
			pullDown:GetButton():LocalizeAndSetText(era.Description);
		end
		PerformBuild();
	end
	pullDown:RegisterSelectionCallback(OnEraSelected);

	local info = GameInfo.Eras[GameData.era];
	if info then
		Controls.EraPullDown:GetButton():LocalizeAndSetText(info.Description);
		Controls.EraPullDown:GetButton():LocalizeAndSetToolTip(info.Strategy);
	end
end

----------------------------------------------------------------------------------------------------------------------------------
-- Victory Conditions
----------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------
function BuildVictoryConditions()
	VictoryCondtionsManager:ResetInstances();

	for victory in GameInfo.Victories() do
		local victoryCondition = VictoryCondtionsManager:GetInstance();

		local victoryConditionTextButton = victoryCondition.VictoryRoot:GetTextButton();
		victoryConditionTextButton:LocalizeAndSetText(victory.Description);
		victoryCondition.VictoryRoot:SetCheck(GameData.victories[victory.Type]);

		function OnVictoryCondition(isChecked)
			GameData.victories[victory.Type] = isChecked;
		end
		victoryCondition.VictoryRoot:RegisterCheckHandler(OnVictoryCondition)
	end

	Controls.VictoryConditionsStack:CalculateSize();
	Controls.VictoryConditionsStack:ReprocessAnchoring();
end

----------------------------------------------------------------------------------------------------------------------------------
-- Advanced Game Options
----------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------
function BuildReallyAdvancedOptions()
	ReallyOptionsManager:ResetInstances();

	-- Create Really Advanced Game Options
	for _, optionType in ipairs(GameData.reallyAdvancedGameOptions) do
		local option = GameInfo.GameOptions[optionType];

		if option and not option.Visible then
			local reallyOption = ReallyOptionsManager:GetInstance();

			reallyOption.ReallyOptionRoot:GetTextButton():SetText(Locale.ConvertTextKey(option.Description));
			reallyOption.ReallyOptionRoot:SetCheck(GameData.gameOptions[option.Type]);

			local toolTip = (option.Help) and Locale.ConvertTextKey(option.Help) or nil;

			if toolTip ~= nil then
				reallyOption.ReallyOptionRoot:SetToolTipString(toolTip);
			end

			if GameData.gameOptions[option.Type] == nil then
				GameData.gameOptions[option.Type] = false;
			end

			---------------------------------------------------------------------
			function OnReallyOption(isChecked)
				GameData.gameOptions[option.Type] = isChecked;
			end
			reallyOption.ReallyOptionRoot:RegisterCheckHandler(OnReallyOption)
		end
	end

	-- Create Disable Nukes
	function OnDisableNukes(isChecked)
		GameData.disableNukes = isChecked;
		PerformBuild();
	end
	Controls.DisableNukes:RegisterCheckHandler(OnDisableNukes)
	Controls.DisableNukes:SetCheck(GameData.disableNukes);

	Controls.ReallyAdvOptionsStack:CalculateSize();
	Controls.ReallyAdvOptionsStack:ReprocessAnchoring();
	Controls.ReallyAdvOptionsPanel:CalculateInternalSize();
end

----------------------------------------------------------------------------------------------------------------------------------
-- Max Turns
----------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------
function BuildMaxTurns()
	function OnMaxTurns(isChecked)
		if isChecked then
			Controls.MaxTurnsEditbox:SetHide(false);
		else
			Controls.MaxTurnsEditbox:SetHide(true);
			GameData.maxTurns = 0;
		end

		GameData.maxTurnsActive = isChecked;
		PerformBuild();
	end
	Controls.MaxTurnsCheck:RegisterCheckHandler(OnMaxTurns)

	function OnMaxTurnsEdit()
		GameData.maxTurns = tonumber(Controls.MaxTurnsEdit:GetText());
	end
	-- Controls.MaxTurnsEdit:RegisterCallback(Mouse.eLClick, OnMaxTurnsEdit)
	Controls.MaxTurnsEdit:RegisterCallback(OnMaxTurnsEdit)

	if GameData.maxTurnsActive then
		Controls.MaxTurnsCheck:SetCheck(true);
	else
		Controls.MaxTurnsCheck:SetCheck(false);
	end

	Controls.MaxTurnsEditbox:SetHide(not GameData.maxTurnsActive);
	Controls.MaxTurnsEdit:SetText(GameData.maxTurns);
end

----------------------------------------------------------------------------------------------------------------------------------
-- Advanced Game Options
----------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------
function BuildAdvancedOptions()
	GameOptionsManager:ResetInstances();

	---------------------------------
	-- General Game Options
	local options = {};

	-- First, Gather a list of all options
	for option in GameInfo.GameOptions{Visible = 1} do
		local option = {
			Type = option.Type,
			Name = Locale.ConvertTextKey(option.Description),
			ToolTip = (option.Help) and Locale.ConvertTextKey(option.Help) or nil,
			Checked = (option.Default == 1) and true or false,
			Disabled = false,
			GameOption = true,
			SortPriority = 0,
		};

		if(GameData.gameOptions[option.Type] ~= nil) then
			option.Checked = GameData.gameOptions[option.Type];
		end

		table.insert(options, option);
	end

	for option in DB.Query("select * from MapScriptOptions where not exists (select 1 from MapScriptOptionPossibleValues where FileName = MapScriptOptions.FileName and OptionID = MapScriptOptions.OptionID) and Hidden = 0 and FileName = ?", MapData.mapScript) do
		local option = {
			ID = option.OptionID,
			Name = Locale.ConvertTextKey(option.Name),
			ToolTip = (option.Description) and Locale.ConvertTextKey(option.Description) or nil,
			Checked = (option.DefaultValue == 1) and true or false,
			Disabled = (option.ReadOnly == 1) and true or false,
			GameOption = false,
			SortPriority = option.SortPriority,
		};

		if(MapData.mapOptions[option.ID] ~= nil) then
			option.Checked = MapData.mapOptions[option.ID] == 1;
		end

		table.insert(options, option);
	end

	-- Sort the options alphabetically
	table.sort(options, function(a, b)
		if(a.SortPriority == b.SortPriority) then
			return a.Name < b.Name;
		else
			return a.SortPriority < b.SortPriority;
		end
	end);

	-- Build game options display.
	for _, option in ipairs(options) do
		local gameOption = GameOptionsManager:GetInstance();

		local gameOptionTextButton = gameOption.AdvancedOptionRoot:GetTextButton();
		gameOptionTextButton:SetText(option.Name);

		if(option.ToolTip ~= nil) then
			gameOption.AdvancedOptionRoot:SetToolTipString(option.ToolTip);
		end

		gameOption.AdvancedOptionRoot:SetDisabled(option.Disabled);
		gameOption.AdvancedOptionRoot:SetCheck(option.Checked);

		if option.GameOption == true then
			if GameData.gameOptions[option.Type] == nil then
				GameData.gameOptions[option.Type] = false;
			end

			function OnGameOption(isChecked)
				GameData.gameOptions[option.Type] = isChecked;
			end
			gameOption.AdvancedOptionRoot:RegisterCheckHandler(OnGameOption)
		else
			if MapData.mapOptions[option.ID] == nil then
				MapData.mapOptions[option.ID] = false;
			end

			function OnMapOption(isChecked)
				MapData.mapOptions[option.ID] = isChecked;
			end
			gameOption.AdvancedOptionRoot:RegisterCheckHandler(OnMapOption)
		end
	end

	Controls.MaxTurnStack:CalculateSize();
	Controls.MaxTurnStack:ReprocessAnchoring();
	Controls.GameOptionsStack:CalculateSize();
	Controls.GameOptionsStack:ReprocessAnchoring();
	Controls.AdvancedOptionsPanel:CalculateInternalSize();
end

------------------------------------------------------------------
function ValidateControls()
	LuaEvents.GTAS_ValidateControls();
end

------------------------------------------------------------------
function PerformBuild()
	BuildHandicap();
	BuildGameSpeed();
	BuildEra();
	BuildVictoryConditions();
	BuildReallyAdvancedOptions();
	BuildMaxTurns();
	BuildAdvancedOptions();
	ValidateControls(); -- This should always get called last.
end
LuaEvents.GTAS_BuildGamePanel.Add(PerformBuild);

----------------------------------------------------------------
function ResetGamePanel()
	GameData:SetDefaultValues();
end
LuaEvents.GTAS_ResetGamePanel.Add(ResetGamePanel)

----------------------------------------------------------------
function OnReset()
	ResetGamePanel();
	PerformBuild();
end
Controls.ResetButton:RegisterCallback(Mouse.eLClick, OnReset);

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
----------------------------------------------------------------

-----------------------------------------------------------------
function AdjustScreenSize()
	local MAIN_PANEL_OFFSET = 176;
	local ADVANCED_OPTIONS_OFFSET = 62;
	local REALLY_ADVANCED_OPTIONS_OFFSET = 470;

    local _, screenY = UIManager:GetScreenSizeVal();
	local panelY = screenY - MAIN_PANEL_OFFSET;

	Controls.MainPanel:SetSizeY(panelY);
	Controls.VerticalDivider:SetSizeY(panelY);
	Controls.LeftPanel:SetSizeY(panelY);
	Controls.RightPanel:SetSizeY(panelY);

	Controls.ReallyAdvOptionsPanel:SetSizeY(panelY - REALLY_ADVANCED_OPTIONS_OFFSET);
    Controls.ReallyAdvOptionsPanel:CalculateInternalSize();

	Controls.AdvancedOptionsPanel:SetSizeY(panelY - ADVANCED_OPTIONS_OFFSET);
    Controls.AdvancedOptionsPanel:CalculateInternalSize();
end

-------------------------------------------------
function OnUpdateUI( type )
    if( type == SystemUpdateUIType.ScreenResize ) then
        AdjustScreenSize();
    end
end
Events.SystemUpdateUI.Add( OnUpdateUI );

AdjustScreenSize();
