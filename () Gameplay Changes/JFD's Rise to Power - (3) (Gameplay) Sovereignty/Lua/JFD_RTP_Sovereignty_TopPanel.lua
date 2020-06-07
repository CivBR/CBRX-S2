--==========================================================================================================================
--==========================================================================================================================
if Game.IsRTPTopPanelActive("a8ac71dc-dcd9-4f87-af61-8ae7951ade57") then return end
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
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
--JFD_Sovereignty_UpdateTopPanel
local function JFD_Sovereignty_UpdateTopPanel()
	local activePlayerID = Game.GetActivePlayer()
	local activePlayer = Players[activePlayerID]
	if activePlayer:IsHasGovernment() then
		local numSovereignty = activePlayer:GetCurrentSovereignty()
		Controls.SovereigntyString:SetHide(false)
		Controls.SovereigntyString:ChangeParent(ContextPtr:LookUpControl("/InGame/TopPanel/TopPanelInfoStack"))
		Controls.SovereigntyString:LocalizeAndSetText("[COLOR_JFD_SOVEREIGNTY][ICON_JFD_SOVEREIGNTY]{1_Num}%[ENDCOLOR]", numSovereignty)
		
		local strSovTT = activePlayer:GetSovereigntyToolTip()
		Controls.SovereigntyString:SetToolTipString(strSovTT)
	else
		Controls.SovereigntyString:SetHide(true)
	end
end
LuaEvents.JFD_UpdateTopPanel.Add(JFD_Sovereignty_UpdateTopPanel)
-------------------------------------------------------------------------------------------------------------------------
--JFD_Sovereignty_SovereigntyString
local function JFD_Sovereignty_SovereigntyString()
	LuaEvents.UI_ShowGovernmentOverview()
end
Controls.SovereigntyString:RegisterCallback(Mouse.eLClick, JFD_Sovereignty_SovereigntyString);
 ----------------------------------------------------------------------------------------------------------------------------
local function Initialize()	
	Events.LoadScreenClose.Add(				  JFD_Sovereignty_UpdateTopPanel);
	Events.SerialEventGameDataDirty.Add(	  JFD_Sovereignty_UpdateTopPanel);
	Events.SerialEventTurnTimerDirty.Add(	  JFD_Sovereignty_UpdateTopPanel);
	Events.SerialEventCityInfoDirty.Add(	  JFD_Sovereignty_UpdateTopPanel);
	LuaEvents.JFD_GovernmentEstablished.Add(  JFD_Sovereignty_UpdateTopPanel);
end
Initialize();
--==========================================================================================================================
--==========================================================================================================================