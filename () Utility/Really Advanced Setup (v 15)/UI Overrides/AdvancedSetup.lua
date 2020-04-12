
-- AdvancedSetup - Part of Really Advanced Setup Mod
-- This is a greatly modified version of the original game file.
-- Most code has been changed and/or moved to other files.

-------------------------------------------------
-- Advanced Settings Screen
-------------------------------------------------

-- print("AdvancedSetUp *************************************************************************************************");

include("GTAS_Constants");
include("GTAS_Utilities");
include("GTAS_DataManager");

-------------------------------------------------------------------------------
-- Top Menu Bar Controls
-------------------------------------------------------------------------------

function OnCivilizations()
	GlobalData.currentMainPanel = CIV_MAIN_PANEL;

    Controls.CivsHighlight:SetHide(false);
    Controls.CivBonusHighlight:SetHide(true);
    Controls.MapBonusHighlight:SetHide(true);
    Controls.MapHighlight:SetHide(true);
    Controls.GameHighlight:SetHide(true);

    Controls.CivMainPanel:SetHide(false);
    Controls.CivBonusMainPanel:SetHide(true);
    Controls.MapBonusMainPanel:SetHide(true);
    Controls.MapMainPanel:SetHide(true);
    Controls.GameMainPanel:SetHide(true);
end
Controls.CivsButton:RegisterCallback(Mouse.eLClick, OnCivilizations);

function OnCivBonus()
	GlobalData.currentMainPanel = CIV_BONUS_MAIN_PANEL;

    Controls.CivsHighlight:SetHide(true);
    Controls.CivBonusHighlight:SetHide(false);
    Controls.MapBonusHighlight:SetHide(true);
    Controls.MapHighlight:SetHide(true);
    Controls.GameHighlight:SetHide(true);

    Controls.CivMainPanel:SetHide(true);
    Controls.CivBonusMainPanel:SetHide(false);
    Controls.MapBonusMainPanel:SetHide(true);
    Controls.MapMainPanel:SetHide(true);
    Controls.GameMainPanel:SetHide(true);
end
Controls.CivBonusButton:RegisterCallback(Mouse.eLClick, OnCivBonus);
LuaEvents.GTAS_OpenCivBonusPanel.Add(OnCivBonus);

function OnMapBonus()
	GlobalData.currentMainPanel = MAP_BONUS_MAIN_PANEL;

    Controls.CivsHighlight:SetHide(true);
    Controls.CivBonusHighlight:SetHide(true);
    Controls.MapBonusHighlight:SetHide(false);
    Controls.MapHighlight:SetHide(true);
    Controls.GameHighlight:SetHide(true);

    Controls.CivMainPanel:SetHide(true);
    Controls.CivBonusMainPanel:SetHide(true);
    Controls.MapBonusMainPanel:SetHide(false);
    Controls.MapMainPanel:SetHide(true);
    Controls.GameMainPanel:SetHide(true);
end
Controls.MapBonusButton:RegisterCallback(Mouse.eLClick, OnMapBonus);
LuaEvents.GTAS_OpenMapBonusPanel.Add(OnMapBonus);

function OnMap()
	GlobalData.currentMainPanel = MAP_MAIN_PANEL;

    Controls.CivsHighlight:SetHide(true);
    Controls.CivBonusHighlight:SetHide(true);
    Controls.MapBonusHighlight:SetHide(true);
    Controls.MapHighlight:SetHide(false);
    Controls.GameHighlight:SetHide(true);

    Controls.CivMainPanel:SetHide(true);
    Controls.CivBonusMainPanel:SetHide(true);
    Controls.MapBonusMainPanel:SetHide(true);
    Controls.MapMainPanel:SetHide(false);
    Controls.GameMainPanel:SetHide(true);
end
Controls.MapButton:RegisterCallback(Mouse.eLClick, OnMap);
LuaEvents.GTAS_OpenMapPanel.Add(OnMap);

function OnGame()
	GlobalData.currentMainPanel = GAME_MAIN_PANEL;

    Controls.CivsHighlight:SetHide(true);
    Controls.CivBonusHighlight:SetHide(true);
    Controls.MapBonusHighlight:SetHide(true);
    Controls.MapHighlight:SetHide(true);
    Controls.GameHighlight:SetHide(false);

    Controls.CivMainPanel:SetHide(true);
    Controls.CivBonusMainPanel:SetHide(true);
    Controls.MapBonusMainPanel:SetHide(true);
    Controls.MapMainPanel:SetHide(true);
    Controls.GameMainPanel:SetHide(false);
end
Controls.GameButton:RegisterCallback(Mouse.eLClick, OnGame);

-------------------------------------------------------------------------------
function OnResetAll()
	LuaEvents.GTAS_ResetCivPanel();
	LuaEvents.GTAS_ResetGamePanel();
	LuaEvents.GTAS_ResetMapBonusPanel();
	LuaEvents.GTAS_ResetMapPanel();

	if GlobalData.currentMainPanel == CIV_MAIN_PANEL then
		LuaEvents.GTAS_BuildCivPanel();
	elseif GlobalData.currentMainPanel == CIV_BONUS_MAIN_PANEL then
		LuaEvents.GTAS_BuildCivBonusPanel();
	elseif GlobalData.currentMainPanel == MAP_BONUS_MAIN_PANEL then
		LuaEvents.GTAS_BuildMapBonusPanel();
	elseif GlobalData.currentMainPanel == MAP_MAIN_PANEL then
		LuaEvents.GTAS_BuildMapPanel();
	elseif GlobalData.currentMainPanel == GAME_MAIN_PANEL then
		LuaEvents.GTAS_BuildGamePanel();
	end
end
Controls.ResetAllButton:RegisterCallback(Mouse.eLClick, OnResetAll);

-------------------------------------------------------------------------------
function OnBack()
	print("OnBack --------------------");
	SaveData();
    UIManager:DequeuePopup(ContextPtr);
end
Controls.BackButton:RegisterCallback(Mouse.eLClick, OnBack);

-------------------------------------------------------------------------------
function OnStart()
	print("OnStart --------------------");
    SaveData();
	SetPreGameValues();
	Events.SerialEventStartGame();
	UIManager:SetUICursor(1);
end
Controls.StartButton:RegisterCallback(Mouse.eLClick, OnStart);


----------------------------------------------------------------
function ValidateControls()
	isValid, isWarning, helpText = ValidateStart();
	Controls.StartButton:SetDisabled(not isValid);
	Controls.StartButton:LocalizeAndSetToolTip(helpText);

	if isValid then
		if isWarning then
			Controls.StartLabel:SetText("[COLOR0:195:180:60:255]Start Game[ENDCOLOR]");
		else
			Controls.StartLabel:SetText("[COLOR_BEIGE]Start Game[ENDCOLOR]");
		end
	else
		Controls.StartLabel:SetText("[COLOR0:210:70:70:255]Start Game[ENDCOLOR]");
	end

	if MapData.isRandomWorldSize then
		Controls.CivsButton:SetText("?  Players");
	else
		Controls.CivsButton:SetText(string.format("%d  Players", SlotData:GetSlotCount()));
	end
end
LuaEvents.GTAS_ValidateControls.Add(ValidateControls)

-------------------------------------------------------------------------------------------------------
function ValidateStart()
	local isValid = true;
	local isWarning = false;
	local helpText = "";
	local newline = "";

	function AddHelpText(text)
		helpText = helpText .. newline .. text;
		newline = "[NEWLINE]";
	end

	-- Hard warnings located here. -----------------------------------------------------------------
	-- Game will not be allowed to start if one of these are triggered.

	local humanSlot = SlotData:GetSlot(0);

	if humanSlot ~= nil and not MapData.isRandomWorldSize then
		isValid = false;

		-- Check if there is two or more teams.
		for _, slot in SlotData:AISlotList() do
			if slot.team ~= humanSlot.team then
				isValid = true;
				break;
			end
		end

		if not isValid then
			AddHelpText(Locale.ConvertTextKey("You must have at least 2 teams!"));
		end
	end

	-- Count active civs.
	local activeCivs = 0;
	for civType, _ in pairs(MapData.activeCivs) do
		if MapData.activeCivs[civType] then
			activeCivs = activeCivs + 1;
		end
	end

	-- Check for at least one active civ.
	if activeCivs == 0 then
		isValid = false;
		AddHelpText("At least one Civilization must be active!");
	end

	-- Soft warnings located here. ---------------------------------------------------------------------
	-- Game can be allowed to start even if one of these are triggered. (These only happen if start is valid.)

	-- Are there enough active civs?
	if isValid then
		if activeCivs == 1 then
			isWarning = true;
			AddHelpText("There is only one active Civ. This will cause duplicate Civs to appear in the Game!");
		elseif not MapData.isRandomWorldSize and activeCivs < SlotData:GetSlotCount() then
			isWarning = true;
			AddHelpText("There are less active Civs than players. This will cause duplicate Civs to appear in the Game!");
		end

		if MapData.disableAllNaturalWonders then
			isWarning = true;
			AddHelpText("All Natural Wonders are disabled!");
		end
		
		if GameData.disableNukes then
			isWarning = true;
			AddHelpText("All Nuclear weapons are disabled!");
		end
	end

	-- If no warnings then let the player know that it's OK to start the game.
	if helpText == "" then
		helpText = "Start the game using the current settings.";
	end

	return isValid, isWarning, helpText;
end

----------------------------------------------------------------
function InputHandler(uiMsg, wParam, lParam)
	if uiMsg == KeyEvents.KeyDown then
		if wParam == Keys.VK_ESCAPE then
		    OnBack();
        	return true;
		elseif wParam == Keys.C then
			UIManager:QueuePopup(Controls.Civilopedia, PopupPriority.HallOfFame);
        	return true;
		end
	end

	return false;
end
ContextPtr:SetInputHandler(InputHandler);

----------------------------------------------------------------
function StartMod()
	local version = Modding.GetActivatedModVersion(MOD_ID) or "Unknown";
	
	print(string.format("(Really Advanced Setup)  Version: %s  -------------------------------------------------------------------------------", version));

	Controls.MainTitle:SetToolTipString(string.format("Really Advanced Setup Mod by General Tso. Version: %s", version));

	-- Load data into DataManager.
	LoadData();
	
	if GlobalData.currentMainPanel == CIV_BONUS_MAIN_PANEL then
		OnCivBonus();
	elseif GlobalData.currentMainPanel == MAP_BONUS_MAIN_PANEL then
		OnMapBonus();
	elseif GlobalData.currentMainPanel == MAP_MAIN_PANEL then
		OnMap();
	elseif GlobalData.currentMainPanel == GAME_MAIN_PANEL then
		OnGame();
	else
		OnCivilizations();
	end
end


-- Start The Mod -------------------------------------------------------------------------------------------------------------------------------
StartMod();




