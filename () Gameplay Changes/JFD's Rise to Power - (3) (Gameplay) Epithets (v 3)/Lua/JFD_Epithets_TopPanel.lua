--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
include("JFD_Epithets_Utils.lua")
--==========================================================================================================================
-- GLOBALS
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
--==========================================================================================================================
-- UI FUNCTIONS
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
-- TOP PANEL
----------------------------------------------------------------------------------------------------------------------------
--JFD_Epithets_UpdateTopPanel
local function JFD_Epithets_UpdateTopPanel()
	local activePlayerID = Game.GetActivePlayer()
	local activePlayer = Players[activePlayerID]
	local epithetProgress, epithetThreshold, currentEpithetThreshold = activePlayer:GetTotalEpithetProgress()
	Controls.EpithetProgressString:SetHide(false)
	Controls.EpithetProgressString:ChangeParent(ContextPtr:LookUpControl("/InGame/TopPanel/TopPanelInfoStack"))
	Controls.EpithetProgressString:LocalizeAndSetText("[COLOR_JFD_EPITHET][ICON_JFD_EPITHET_PROGRESS] {1_Num}/{2_Num}[ENDCOLOR]", epithetProgress, currentEpithetThreshold)
end
LuaEvents.JFD_UpdateTopPanel.Add(JFD_Epithets_UpdateTopPanel)
 ----------------------------------------------------------------------------------------------------------------------------
local function Initialize()	
	Events.LoadScreenClose.Add(			  JFD_Epithets_UpdateTopPanel);
	Events.SerialEventGameDataDirty.Add(  JFD_Epithets_UpdateTopPanel);
	Events.SerialEventTurnTimerDirty.Add( JFD_Epithets_UpdateTopPanel);
	Events.SerialEventCityInfoDirty.Add(  JFD_Epithets_UpdateTopPanel);
end
Initialize();
--==========================================================================================================================
--==========================================================================================================================