--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
include("JFD_CyclesOfPower_Utils.lua")
--==========================================================================================================================
-- GLOBALS
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
local activePlayerID	= Game.GetActivePlayer()
local activePlayer		= Players[activePlayerID]
--==========================================================================================================================
-- UI FUNCTIONS
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
-- TOP PANEL
----------------------------------------------------------------------------------------------------------------------------
--JFD_Virtue_UpdateTopPanel
local function JFD_Virtue_UpdateTopPanel()
	if activePlayer:IsHasCycleOfPowerBegun() then
		local cyclePowerID = activePlayer:GetCyclePower()
		local numVirtue = activePlayer:GetVirtue()
		local numVirtueRate = activePlayer:GetVirtueRate(cyclePowerID)
		Controls.VirtueString:SetHide(false)
		Controls.VirtueString:ChangeParent(ContextPtr:LookUpControl("/InGame/TopPanel/TopPanelInfoStack"))
		Controls.VirtueString:LocalizeAndSetText("[COLOR_JFD_VIRTUE][ICON_JFD_VIRTUE]{1_Num} ({2_Num})[ENDCOLOR]", numVirtue, numVirtueRate)
		
		local strCyclePowerTT = activePlayer:GetCyclePowerToolTip(cyclePowerID)
		local strVirtueTT = activePlayer:GetVirtueToolTip(cyclePowerID)
		if strVirtueTT then
			Controls.VirtueString:SetToolTipString(strCyclePowerTT .. "[NEWLINE][NEWLINE]" .. strVirtueTT)
		else
			Controls.VirtueString:SetToolTipString(strCyclePowerTT)
		end
	else
		Controls.VirtueString:SetHide(true)
	end
end
LuaEvents.JFD_UpdateTopPanel.Add(JFD_Virtue_UpdateTopPanel)
-------------------------------------------------------------------------------------------------------------------------
--JFD_Virtue_VirtueString
local function JFD_Virtue_VirtueString()
	local cyclePowerID = activePlayer:GetCyclePower()
	if (not activePlayer:IsAnarchy()) then
		LuaEvents.UI_ShowCyclePowerPopup(activePlayerID, cyclePowerID, false, false, true)
	end
end
Controls.VirtueString:RegisterCallback(Mouse.eLClick, JFD_Virtue_VirtueString);
 ----------------------------------------------------------------------------------------------------------------------------
local function Initialize()	
	Events.LoadScreenClose.Add(				  JFD_Virtue_UpdateTopPanel);
	Events.SerialEventGameDataDirty.Add(	  JFD_Virtue_UpdateTopPanel);
	Events.SerialEventTurnTimerDirty.Add(	  JFD_Virtue_UpdateTopPanel);
	Events.SerialEventCityInfoDirty.Add(	  JFD_Virtue_UpdateTopPanel);
end
Initialize();
--==========================================================================================================================
--==========================================================================================================================