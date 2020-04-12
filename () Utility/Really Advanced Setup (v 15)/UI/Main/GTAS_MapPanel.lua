
-- GTAS_MapSetup - Part of Really Advanced Setup Mod

-----------------------------------------------------------------
-- Map Panel For Advanced Settings Screen
-----------------------------------------------------------------

include("IconSupport");
include("InstanceManager");

include("GTAS_Constants");
include("GTAS_Utilities");

local MAX_MINOR_CIVS = 41;
local MIN_WONDER_COPIES = 2;
local MAX_WONDER_COPIES = 50;
local MIN_VISIBILITY = 2;
local MAX_VISIBILITY = 50;

CustomOptionsManager = InstanceManager:new("MapOptionInstance", "MapOptionRoot", Controls.CustomOptionsStack);
ActiveCivsManager = InstanceManager:new("ActiveCivInstance", "ActiveCivRoot", Controls.ActiveCivsStack);

----------------------------------------------------------------------------------------------------------------------------------
-- Minor Civs
----------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------
function BuildMinorCivs()
	local maxMinorCivs = math.min(MAX_MINOR_CIVS, #GameInfo.MinorCivilizations);

	function OnMinorCivsSlider(fValue)
		MapData.numMinorCivs = GetSliderValue(fValue, 0, maxMinorCivs);
		Controls.MinorCivsValue:SetText(MapData.numMinorCivs);
	end
	Controls.MinorCivsSlider:RegisterSliderCallback(OnMinorCivsSlider);

	if MapData.isRandomWorldSize then
		Controls.MinorCivsSlider:SetHide(true);
		Controls.MinorCivsValue:SetHide(true);

	else
		Controls.MinorCivsSlider:SetHide(false);
		Controls.MinorCivsValue:SetHide(false);

		SetSliderValue(Controls.MinorCivsSlider, MapData.numMinorCivs, 0, maxMinorCivs);
		Controls.MinorCivsValue:SetText(tostring(MapData.numMinorCivs));
	end
end

----------------------------------------------------------------------------------------------------------------------------------
-- Map Type
----------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------
function BuildMapType()
	local maps = GetMaps();
	local pullDown = Controls.MapTypePullDown;

	-- Build the Map Type menu ---------------------------------------------------------------

	pullDown:ClearEntries();

	for i, script in ipairs(maps) do
		controlTable = {};
		pullDown:BuildEntry("InstanceOne", controlTable);

		controlTable.Button:SetText(script.Name);
		controlTable.Button:SetToolTipString(script.Description);
		controlTable.Button:SetVoid1(i);
	end

	pullDown:CalculateInternals();

	-- Update the Map Type menu button ---------------------------------------------------------

	if not MapData.isRandomMapScript then
		local isFound = false;

		for row in GameInfo.MapScripts{FileName = MapData.mapScript} do
			pullDown:GetButton():LocalizeAndSetText(row.Name);
			pullDown:GetButton():LocalizeAndSetToolTip(row.Description or "");
			isFound = true;
			break;
		end

		print("BuildMapType #1........")

		if not isFound then
			print("BuildMapType #2")
			for row in GetMapSizes("FileName = '" .. MapData.mapScript .. "'") do
				print("BuildMapType #3")
				local map = GameInfo.Maps[row.MapType];
				if map ~= nil then
					pullDown:GetButton():LocalizeAndSetText(map.Name);
					pullDown:GetButton():LocalizeAndSetToolTip(map.Description or "");
					isFound = true;
					break;
				end
			end
		end

		print("BuildMapType #4")
			
		if not isFound then
			for _, map in ipairs(Modding.GetMapFiles()) do
				if map.File == MapData.mapScript then
					local mapData = UI.GetMapPreview(map.File);
					local name = "";
					local description = "";

					if not Locale.IsNilOrWhitespace(map.Name) then
						name = map.Name;
					elseif not Locale.IsNilOrWhitespace(mapData.Name) then
						name = mapData.Name;
					else
						name = Path.GetFileNameWithoutExtension(map.File);
					end

					if not Locale.IsNilOrWhitespace(map.Description) then
						description = map.Description;
					elseif mapData.Description and #mapData.Description > 0 then
						description = mapData.Description;
					end

					pullDown:GetButton():LocalizeAndSetText(name);
					pullDown:GetButton():LocalizeAndSetToolTip(description);
					isFound = true;
					break;
				end
			end
		end

		if not isFound then
			MapData:SetMapScriptRandom();
		end
	end

	if MapData.isRandomMapScript then
		pullDown:GetButton():LocalizeAndSetText("TXT_KEY_RANDOM_MAP_SCRIPT");
		pullDown:GetButton():LocalizeAndSetToolTip("TXT_KEY_RANDOM_MAP_SCRIPT_HELP");
	end

	-- Create the menu selection handler ----------------------------------------------------------

	function OnMapTypeSelected(id)
		local map = maps[id];

		-- If this is an "error" entry (invalid WB file for example), do nothing.
		if map.Error then
			return;
		end

		MapData.mapOptions = {};
		MapData.loadWBScenario = false;
		MapData.isRandomMapScript = false;

		if id == 0 or map == nil then
			MapData:SetMapScriptRandom()

		elseif map.MapType ~= nil then
			if MapData.isRandomWorldSize then
				local file = "";
				local mapCount = 0;
				local sizeType = 0;

				for row in GetMapSizes("MapType = '" .. map.MapType .. "'") do
					mapCount = mapCount + 1;
					if file == "" then
						file = row.FileName;
						sizeType = row.WorldSizeType;
					end
				end

				MapData.mapScript = file;

				-- If only one map size available for this map type then use that size and disable random size in the process.
				if mapCount < 2 then
					local world = GameInfo.Worlds[sizeType];
					
					if world ~= nil then
						MapData:SetMapSizeValue(world.ID);
						MapData.numMinorCivs = world.DefaultMinorCivs;
						SlotData:SetSlotCount(world.DefaultPlayers);
					else
						-- This should never happen. Placed here just in case......
						MapData:SetMapSizeValue(0);
					end
				end

			else
				local mapSizes = {};
				
				for row in GetMapSizes("MapType = '" .. map.MapType .. "'") do
					local world = GameInfo.Worlds[row.WorldSizeType];
					
					if world ~= nil then
						mapSizes[world.ID] = row.FileName;
					end
				end

				if mapSizes[MapData.worldSize] ~= nil then
					MapData:SetMapScriptValue(mapSizes[MapData.worldSize]);
					local world = MapData:GetCurrentWorld();
					
					if world ~= nil then
						MapData.numMinorCivs = world.DefaultMinorCivs;
						SlotData:SetSlotCount(world.DefaultPlayers);
					end
					
				else
					for world in GameInfo.Worlds("ID >= 0 ORDER BY ID") do
						local file = mapSizes[world.ID];
						
						if file ~= nil then
							MapData:SetMapScriptValue(file);
							MapData:SetMapSizeValue(world.ID);
							MapData.numMinorCivs = world.DefaultMinorCivs;
							SlotData:SetSlotCount(world.DefaultPlayers);
							break;
						end
					end
				end
			end

		else
			MapData:SetMapScriptValue(map.FileName);

			local playerCount, minorCivCount;
			local wb = map.WBMapData;

			if wb ~= nil then
				MapData:SetMapSizeValue(wb.MapSize);
				GameData.gameSpeed = wb.DefaultSpeed;
				GameData.maxTurns = wb.MaxTurns;

				if wb.StartEra ~= nil then
					GameData.startEra = wb.StartEra;
				end

				if wb.PlayerCount > 0 then
					playerCount = wb.PlayerCount;
				end

				if wb.CityStateCount > 0 then
					minorCivCount = wb.CityStateCount;
				end

				GameData.victories = {};

				for _, victoryType in ipairs(wb.VictoryTypes) do
					if GameData.victories[victoryType] == nil then
						GameData.victories[victoryType] = true;
					end
				end
			end

			local world = MapData:GetCurrentWorld();

			-- Try to find a valid value for number of minor civs if needed --------------------------------------------------------
			if minorCivCount == nil then
				minorCivCount = map.DefaultCityStates;
			end

			if minorCivCount == nil and world ~= nil then
				minorCivCount = world.DefaultMinorCivs;
			end

			-- If valid value found then set the number of minor civs.
			if minorCivCount ~= nil then
				MapData.numMinorCivs = minorCivCount;
			end

			-- Try to find a valid value for number of players if needed --------------------------------------------------------
			if playerCount == nil and world ~= nil then
				playerCount = world.DefaultPlayers;
			end

			-- If valid value found then set the number of players.
			if playerCount ~= nil then
				SlotData:SetSlotCount(playerCount);
			end
		end

		PerformBuild();
	end
	pullDown:RegisterSelectionCallback(OnMapTypeSelected);
end

----------------------------------------------------------------------------------------------------------------------------------
-- Map Size
----------------------------------------------------------------------------------------------------------------------------------

function BuildMapSize()
	local pullDown = Controls.MapSizePullDown;

	-- Build the map size menu ---------------------------------------------------------------

	pullDown:ClearEntries();

	local mapSizeType;

	if not MapData.isRandomMapScript then
		for row in GetMapSizes() do
			if Path.GetFileNameWithoutExtension(MapData.mapScript) == Path.GetFileNameWithoutExtension(row.FileName) then
				mapSizeType = row.MapType;
				break;
			end
		end
	end

	if mapSizeType ~= nil then
		local mapSizeCount = 0;
		local mapSizes = {};

		for row in GetMapSizes("MapType = '" .. mapSizeType .. "'") do
			mapSizes[row.WorldSizeType] = row.FileName;
			mapSizeCount = mapSizeCount + 1;
		end

		if mapSizeCount > 1 then
			local instance = {};
			pullDown:BuildEntry("InstanceOne", instance);
			instance.Button:LocalizeAndSetText("TXT_KEY_RANDOM_MAP_SIZE");
			instance.Button:LocalizeAndSetToolTip("TXT_KEY_RANDOM_MAP_SIZE_HELP");
			instance.Button:SetVoid1(-1);
		end

		for world in GameInfo.Worlds("ID >= 0 ORDER BY ID") do
			local sizeEntry = mapSizes[world.Type];

			if sizeEntry ~= nil then
				local instance = {};
				pullDown:BuildEntry("InstanceOne", instance);
				instance.Button:LocalizeAndSetText(world.Description);
				instance.Button:LocalizeAndSetToolTip(world.Help);
				instance.Button:SetVoid1(world.ID);
			end
		end

	else
		local instance = {};
		pullDown:BuildEntry("InstanceOne", instance);
		instance.Button:LocalizeAndSetText("TXT_KEY_RANDOM_MAP_SIZE");
		instance.Button:LocalizeAndSetToolTip("TXT_KEY_RANDOM_MAP_SIZE_HELP");
		instance.Button:SetVoid1(-1);

		for world in GameInfo.Worlds("ID >= 0 ORDER BY ID") do
			local instance = {};
			pullDown:BuildEntry("InstanceOne", instance);
			instance.Button:LocalizeAndSetText(world.Description);
			instance.Button:LocalizeAndSetToolTip(world.Help);
			instance.Button:SetVoid1(world.ID);
		end
	end

	pullDown:CalculateInternals();

	-- Update the map size menu ---------------------------------------------------------------

	local isDisabled = not (MapData.isRandomWorldSize or MapData.isRandomMapScript);

	for row in GameInfo.MapScripts{FileName = MapData.mapScript} do
		isDisabled = false;
		break;
	end

	local world = MapData:GetCurrentWorld();

	if mapSizeType ~= nil then
		if MapData.isRandomWorldSize then
			for row in GetMapSizes("MapType = '" .. mapSizeType .. "'") do
				MapData:SetMapScriptValue(row.FileName);
				break;
			end

		else
			local scripts = {};
			local mapSizeCount = 0;

			if world ~= nil then
				for row in GetMapSizes("MapType = '" .. mapSizeType .. "'") do
					mapSizeCount = mapSizeCount + 1
					scripts[row.WorldSizeType] = row.FileName;
				end

				if scripts[world.Type] ~= nil then
					MapData:SetMapScriptValue(scripts[world.Type]);
				end
			end

			if mapSizeCount > 1 then
				isDisabled = false;
			end
		end
	end

	if MapData.isRandomWorldSize then
		Controls.MapSizePullDown:GetButton():LocalizeAndSetText("TXT_KEY_RANDOM_MAP_SIZE");
		Controls.MapSizePullDown:GetButton():LocalizeAndSetToolTip("TXT_KEY_RANDOM_MAP_SIZE_HELP");

	else
		Controls.MapSizePullDown:GetButton():LocalizeAndSetText(world.Description);
		Controls.MapSizePullDown:GetButton():LocalizeAndSetToolTip(world.Help);
	end

	Controls.MapSizePullDown:GetButton():SetDisabled(isDisabled);

	-- Create the MapSize selection handler --------------------------------------------------------
	function OnMapSizeSelected(id)
		if id == -1 then
			MapData:SetMapSizeRandom();
			MapData.numMinorCivs = 0;
			SlotData:ResetAISlots();
			pullDown:GetButton():LocalizeAndSetText("TXT_KEY_RANDOM_MAP_SIZE");
			pullDown:GetButton():LocalizeAndSetToolTip("TXT_KEY_RANDOM_MAP_SIZE_HELP");

		else
			MapData:SetMapSizeValue(id);
			local filterType;

			if not MapData.isRandomMapScript then
				 for mapSize in GetMapSizes() do
					if(Path.GetFileName(MapData.mapScript) == Path.GetFileName(mapSize.FileName)) then
						filterType = mapSize.MapType;
						break;
					end
				end
			end

			local world = MapData:GetCurrentWorld();
			local playerCount, minorCivCount;

			if filterType ~= nil and world ~= nil then
				for row in GetMapSizes("MapType = '" .. filterType .. "' AND WorldSizeType = '" .. world.Type .. "'") do
					MapData:SetMapScriptValue(row.FileName);

					local wb = UI.GetMapPreview(row.FileName);

					if wb ~= nil then
						MapData:SetMapSizeValue(wb.MapSize);
						GameData.gameSpeed = wb.DefaultSpeed;
						GameData.maxTurns = wb.MaxTurns;

						if wb.StartEra ~= nil then
							GameData.startEra = wb.StartEra;
						end

						if wb.PlayerCount > 0 then
							playerCount = wb.PlayerCount;
						end

						if wb.CityStateCount > 0 then
							minorCivCount = wb.CityStateCount;
						end

						GameData.victories = {};

						for _, victoryType in ipairs(wb.VictoryTypes) do
							if GameData.victories[victoryType] == nil then
								GameData.victories[victoryType] = true;
							end
						end
					end
				end
			end

			-- Try to find a valid value for number of minor civs if needed --------------------------------------------------------
			if minorCivCount == nil then
				minorCivCount = world.DefaultMinorCivs;
			end

			-- If valid value found then set the number of minor civs.
			if minorCivCount ~= nil then
				MapData.numMinorCivs = minorCivCount;
			end

			-- Try to find a valid value for number of players if needed --------------------------------------------------------
			if playerCount == nil then
				playerCount = world.DefaultPlayers;
			end

			-- If valid value found then set the number of players.
			if playerCount ~= nil then
				SlotData:SetSlotCount(playerCount);
			end
		end

		PerformBuild();
	end
	pullDown:RegisterSelectionCallback(OnMapSizeSelected);
end

------------------------------------------------------------------------------------------------------
-- Custom Map Options
------------------------------------------------------------------------------------------------------

-------------------------------------------------
function BuildCustomOptions()
	CustomOptionsManager:ResetInstances();

	local currentMapScript = MapData.mapScript;

	if MapData.isRandomMapScript then
		currentMapScript = nil;
	end

	local options = {};

	for option in DB.Query("select * from MapScriptOptions where exists (select 1 from MapScriptOptionPossibleValues where FileName = MapScriptOptions.FileName and OptionID = MapScriptOptions.OptionID) and Hidden = 0 and FileName = ?", currentMapScript) do
		options[option.OptionID] = {
			ID = option.OptionID,
			Name = Locale.ConvertTextKey(option.Name),
			ToolTip = (option.Description) and Locale.ConvertTextKey(option.Description) or nil,
			Disabled = (option.ReadOnly == 1) and true or false,
			DefaultValue = option.DefaultValue,
			SortPriority = option.SortPriority,
			Values = {},
		};
	end

	for possibleValue in DB.Query("select * from MapScriptOptionPossibleValues where FileName = ? order by SortIndex ASC", currentMapScript) do
		if(options[possibleValue.OptionID] ~= nil) then
			table.insert(options[possibleValue.OptionID].Values, {
				Name	= Locale.ConvertTextKey(possibleValue.Name),
				ToolTip = (possibleValue.Description) and Locale.ConvertTextKey(possibleValue.Description) or nil,
				Value	= possibleValue.Value,
			});
		end
	end

	local sortedOptions = {};
	for k,v in pairs(options) do
		table.insert(sortedOptions, v);
	end

	-- Sort the options
	table.sort(sortedOptions, function(a, b)
		if(a.SortPriority == b.SortPriority) then
			return a.Name < b.Name;
		else
			return a.SortPriority < b.SortPriority;
		end
	end);

	-- Update custom map options.
	for _, option in ipairs(sortedOptions) do
		local mapOption = CustomOptionsManager:GetInstance();

		mapOption.OptionName:SetText(option.Name);

		if option.ToolTip ~= nil then
			mapOption.OptionName:SetToolTipString(option.ToolTip);
		else
			mapOption.OptionName:SetToolTipString();
		end

		mapOption.OptionDropDown:SetDisabled(option.Disabled);
		mapOption.OptionDropDown:ClearEntries();

		local dropDownButton = mapOption.OptionDropDown:GetButton();

		for _, possibleValue in ipairs(option.Values) do
			controlTable = {};
			mapOption.OptionDropDown:BuildEntry( "InstanceOne", controlTable );
			controlTable.Button:SetText(possibleValue.Name);

			function OnCustomMapOption()
				dropDownButton:SetText(possibleValue.Name);
				MapData.mapOptions[option.ID] = possibleValue.Value;
			end
			controlTable.Button:RegisterCallback(Mouse.eLClick, OnCustomMapOption);
		end

		--Assign the currently selected value.
		local savedValue = MapData.mapOptions[option.ID];
		local defaultValue;

		if savedValue ~= nil then
			defaultValue = option.Values[savedValue];
		else
			defaultValue = option.Values[option.DefaultValue];
		end

		if defaultValue ~= nil then
			MapData.mapOptions[option.ID] = defaultValue.Value;
			dropDownButton:SetText(defaultValue.Name);
		end

		if option.Disabled then
			dropDownButton:SetDisabled(true);
		end

		mapOption.OptionDropDown:CalculateInternals();
	end

	if #sortedOptions == 0 then
		Controls.CustomOptionsLabel:SetHide(true);
		Controls.CustomOptionsPanel:SetHide(true);
		Controls.CustomOptionsBar:SetHide(true);

	else
		Controls.CustomOptionsLabel:SetHide(false);
		Controls.CustomOptionsPanel:SetHide(false);
		Controls.CustomOptionsBar:SetHide(false);

		for row in GameInfo.MapScripts{FileName = MapData.mapScript} do
			Controls.CustomOptionsLabel:SetText(string.format("Options for ( %s )", Locale.ConvertTextKey(row.Name)));
			break;
		end
	end

	Controls.CustomOptionsStack:CalculateSize();
	Controls.CustomOptionsStack:ReprocessAnchoring();
	Controls.CustomOptionsPanel:CalculateInternalSize();
end


------------------------------------------------------------------------------------------------------
-- Natural Wonders
------------------------------------------------------------------------------------------------------

-------------------------------------------------
function BuildNaturalWonders()
	function OnDisableNaturalWonders(isChecked)
		MapData.disableAllNaturalWonders = isChecked;

		if MapData.disableAllNaturalWonders then
			MapData:ResetWonders();
			
			for _, slot in SlotData:SlotList() do
				slot:ResetWonders();
			end
		end
		
		PerformBuild();
	end
	Controls.DisableNaturalWonders:RegisterCheckHandler(OnDisableNaturalWonders);
	Controls.DisableNaturalWonders:SetCheck(MapData.disableAllNaturalWonders);

	if MapData.disableAllNaturalWonders then
		Controls.DisableOtherWonders:SetHide(true);
		Controls.MaxCopiesBox:SetHide(true);

	else
		Controls.DisableOtherWonders:SetHide(false);
		Controls.MaxCopiesBox:SetHide(false);

		function OnKeepOriginalWonders(isChecked)
			MapData.removeOriginalWonders = isChecked;
		end
		Controls.DisableOtherWonders:RegisterCheckHandler(OnKeepOriginalWonders)
		Controls.DisableOtherWonders:SetCheck(MapData.removeOriginalWonders);

		function OnMaxCopies(copies)
			MapData.maxWonderCopies = copies;
			PerformBuild();
		end

		Controls.OneCopy:RegisterCallback(Mouse.eLClick, OnMaxCopies);
		Controls.OneCopy:SetVoid1(1);
		Controls.OneCopy:SetCheck(MapData.maxWonderCopies == 1);

		Controls.UnlimitedCopies:RegisterCallback(Mouse.eLClick, OnMaxCopies);
		Controls.UnlimitedCopies:SetVoid1(-1);
		Controls.UnlimitedCopies:SetCheck(MapData.maxWonderCopies == -1);

		Controls.SetCopies:RegisterCallback(Mouse.eLClick, OnMaxCopies);
		Controls.SetCopies:SetVoid1(2);
		Controls.SetCopies:SetCheck(MapData.maxWonderCopies > 1);

		if MapData.maxWonderCopies < 2 then
			Controls.MaxCopiesSlider:SetHide(true);
			Controls.MaxCopiesValue:SetHide(true);
		else
			Controls.MaxCopiesSlider:SetHide(false);
			Controls.MaxCopiesValue:SetHide(false);

			function OnSetMaxCopies(fValue)
				MapData.maxWonderCopies = GetSliderValue(fValue, MIN_WONDER_COPIES, MAX_WONDER_COPIES);
				Controls.MaxCopiesValue:SetText(tostring(MapData.maxWonderCopies));
			end
			Controls.MaxCopiesSlider:RegisterSliderCallback(OnSetMaxCopies);
			
			SetSliderValue(Controls.MaxCopiesSlider, MapData.maxWonderCopies, MIN_WONDER_COPIES, MAX_WONDER_COPIES);
			Controls.MaxCopiesValue:SetText(tostring(MapData.maxWonderCopies));
		end
	end
end


------------------------------------------------------------------------------------------------------
-- Starting Visibility
------------------------------------------------------------------------------------------------------

-------------------------------------------------
function BuildStartingVisibility()
	if MapData.startingVisibility == -1 then
		Controls.VisibilitySlider:SetHide(true);
		Controls.VisibilityValue:SetHide(true);
		Controls.VisibilityLine:SetHide(false);
		Controls.VisibilityLabel:EnableToolTip(false);
		
	else
		Controls.VisibilitySlider:SetHide(false);
		Controls.VisibilityValue:SetHide(false);
		Controls.VisibilityLine:SetHide(true);
		Controls.VisibilityLabel:EnableToolTip(true);
		
		function OnStartingVisibility(fValue)
			MapData.startingVisibility = GetSliderValue(fValue, MIN_VISIBILITY, MAX_VISIBILITY);
			Controls.VisibilityValue:SetText(tostring(MapData.startingVisibility));
		end
		Controls.VisibilitySlider:RegisterSliderCallback(OnStartingVisibility);
		
		SetSliderValue(Controls.VisibilitySlider, MapData.startingVisibility, MIN_VISIBILITY, MAX_VISIBILITY);
		Controls.VisibilityValue:SetText(tostring(MapData.startingVisibility));
	end

	function OnWholeMap(isChecked)
		if isChecked then
			MapData.startingVisibility = -1;
		else
			MapData.startingVisibility = MIN_VISIBILITY;
		end
		BuildStartingVisibility();
	end
	Controls.VisibilityWholeMap:RegisterCheckHandler(OnWholeMap);
	Controls.VisibilityWholeMap:SetCheck(MapData.startingVisibility == -1);
end

------------------------------------------------------------------------------------------------------
-- Active Civs
------------------------------------------------------------------------------------------------------

-------------------------------------------------
function BuildActiveCivs()
	local civs = {};
	ActiveCivsManager:ResetInstances();

	for civType, isActive in pairs(MapData.activeCivs) do
		local civ_leader = GameInfo.Civilization_Leaders("CivilizationType = '" .. civType .. "'")();

		if civ_leader then
			local leader = GameInfo.Leaders[civ_leader.LeaderheadType];

			if leader then
				local civ = GameInfo.Civilizations[civType];
				
				if civ then
					table.insert(civs, { isActive = isActive, civType = civType, civText = civ.ShortDescription, leaderText = leader.Description });
				end
			end
		end
	end

	table.sort(civs, function(a,b) return Locale.Compare(a.civText, b.civText) == -1; end);

	for _, civData in ipairs(civs) do
		local civInstance = ActiveCivsManager:GetInstance();
		local button = civInstance.ActiveCivRoot:GetTextButton();
		button:LocalizeAndSetText("TXT_KEY_RANDOM_LEADER_CIV", civData.civText, civData.leaderText);
		civInstance.ActiveCivRoot:SetCheck(civData.isActive);

		function OnActiveCiv(isChecked)
			MapData.activeCivs[civData.civType] = isChecked;

			-- Change any player slot that contains a inactive civ to random civ. Normally this should only affect slots using this check box's civ.
			for _, slot in SlotData:SlotList() do
				if not MapData:IsActiveCiv(slot.civType) then
					slot.civType = RANDOM_CIVILIZATION;
				end
			end

			PerformBuild();
		end
		civInstance.ActiveCivRoot:RegisterCheckHandler(OnActiveCiv)
	end

	Controls.ActiveCivsStack:CalculateSize();
	Controls.ActiveCivsStack:ReprocessAnchoring();
	Controls.ActiveCivsPanel:CalculateInternalSize();
end

------------------------------------------------------------------
function ValidateControls()
	LuaEvents.GTAS_ValidateControls();
end

------------------------------------------------------------------
function PerformBuild()
	BuildMinorCivs();
	BuildMapType();
	BuildMapSize();
	BuildCustomOptions();
	BuildNaturalWonders();
	BuildStartingVisibility();
	BuildActiveCivs();
	ValidateControls(); -- This should always get called last.
end
LuaEvents.GTAS_BuildMapPanel.Add(PerformBuild);

----------------------------------------------------------------
function OnSelectAllCivs()
	for civType, _ in pairs(MapData.activeCivs) do
		MapData.activeCivs[civType] = true;
	end
	PerformBuild();
end
Controls.SelectAllCivsButton:RegisterCallback(Mouse.eLClick, OnSelectAllCivs);

----------------------------------------------------------------
function OnDeselectAllCivs()
	for civType, _ in pairs(MapData.activeCivs) do
		MapData.activeCivs[civType] = false;
	end

	PerformBuild();
end
Controls.DeselectAllCivsButton:RegisterCallback(Mouse.eLClick, OnDeselectAllCivs);

----------------------------------------------------------------
function ResetMapPanel()
	MapData:SetDefaultValues();
	if not MapData.isRandomWorldSize then
		local world = MapData:GetCurrentWorld();
		if world ~= nil then
			SlotData:SetSlotCount(world.DefaultPlayers);
		end
	end
end
LuaEvents.GTAS_ResetMapPanel.Add(ResetMapPanel)

----------------------------------------------------------------
function OnReset()
	ResetMapPanel();
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
	local CUSTOM_OPTIONS_OFFSET = 522;
	local ACTIVE_CIVS_OFFSET = 118;

    local _, screenY = UIManager:GetScreenSizeVal();
	local panelY = screenY - MAIN_PANEL_OFFSET;

	Controls.MainPanel:SetSizeY(panelY);
	Controls.VerticalDivider:SetSizeY(panelY);
	Controls.LeftPanel:SetSizeY(panelY);
	Controls.RightPanel:SetSizeY(panelY);

	Controls.CustomOptionsPanel:SetSizeY(panelY - CUSTOM_OPTIONS_OFFSET);
    Controls.CustomOptionsPanel:CalculateInternalSize();

	Controls.ActiveCivsPanel:SetSizeY(panelY - ACTIVE_CIVS_OFFSET);
    Controls.ActiveCivsPanel:CalculateInternalSize();
end

-------------------------------------------------
function OnUpdateUI( type )
    if( type == SystemUpdateUIType.ScreenResize ) then
        AdjustScreenSize();
    end
end
Events.SystemUpdateUI.Add( OnUpdateUI );

AdjustScreenSize();






















