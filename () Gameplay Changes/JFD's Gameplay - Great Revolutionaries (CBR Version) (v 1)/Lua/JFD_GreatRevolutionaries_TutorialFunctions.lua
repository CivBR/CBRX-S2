-- JFD_GreatRevolutionaries_Functions
-- Author: JFD
-- DateCreated: 5/3/2019 2:09:14 AM
--=======================================================================================================================
-- INCLUDES
--=======================================================================================================================
include("CommonBehaviors")
include("IconSupport.lua")
--=======================================================================================================================
-- GLOBALS
--=======================================================================================================================
------------------------------------------------------------------------------------------------------------------------
local g_ConvertTextKey  = Locale.ConvertTextKey
local g_GetUserSetting  = Game.GetUserSetting
local g_IsModActive  	= Game.IsModActive
						
local Players 			= Players
						
local activePlayerID	= Game.GetActivePlayer()
local activePlayer		= Players[activePlayerID]
local activeTeamID		= Game.GetActiveTeam()
local activeTeam		= Teams[activeTeamID]
--=======================================================================================================================
-- UI FUNCTIONS
--=======================================================================================================================
------------------------------------------------------------------------------------------------------------------------
-- STARTUP POPUP
------------------------------------------------------------------------------------------------------------------------
--JFD_GreatRevolutionaries_LoadScreenClose
local function JFD_GreatRevolutionaries_LoadScreenClose()
	if activePlayer:GetCapitalCity() then return end
	ContextPtr:SetHide(false)
end
Events.LoadScreenClose.Add(JFD_GreatRevolutionaries_LoadScreenClose)
------------------------------------------------------------------------------------------------------------------------
--UI_InitGreatRevolutionariesPopup()
local function UI_InitGreatRevolutionariesPopup()
	Controls.ButtonStack:CalculateSize()
	Controls.MainUI:DoAutoSize()
end
------------------------------------------------------------------------------------------------------------------------
--UI_CloseStartupPopup
local function UI_CloseStartupPopup()
	ContextPtr:SetHide(true)
end
Controls.CloseButton:RegisterCallback(Mouse.eLClick, UI_CloseStartupPopup)
------------------------------------------------------------------------------------------------------------------------
local function InputHandler(uiMsg, wParam, lParam)
	if (uiMsg == KeyEvents.KeyDown) then
		if (wParam == Keys.VK_ESCAPE) then
			UI_InitGreatRevolutionariesPopup()
			return true
		end
	end
end
ContextPtr:SetInputHandler(InputHandler)
------------------------------------------------------------------------------------------------------------------------
local function ShowHideHandler(bIsHide, bInitState)
	if (not bInitState and not bIsHide) then
		UI_InitGreatRevolutionariesPopup()
	end
end
ContextPtr:SetShowHideHandler(ShowHideHandler)
ContextPtr:SetHide(true)
--==========================================================================================================================
--==========================================================================================================================
