--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
include("JFD_CyclesOfPower_Utils.lua")
 --==========================================================================================================================
-- GLOBALS
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
local g_ConvertTextKey  = Locale.ConvertTextKey
local g_GetRandom		= Game.GetRandom
local g_GetRound		= Game.GetRound
local g_MapGetPlot		= Map.GetPlot
local g_MathCeil		= math.ceil
local g_MathFloor		= math.floor
local g_MathMax			= math.max
local g_MathMin			= math.min
				
local Players 			= Players
local HexToWorld 		= HexToWorld
local ToHexFromGrid 	= ToHexFromGrid
local Teams 			= Teams

local gameSpeedID		= Game.GetGameSpeedType()
local gameSpeed			= GameInfo.GameSpeeds[gameSpeedID]

local handicapID		= Game.GetHandicapType()
local handicap			= GameInfo.HandicapInfos[handicapID]
--==========================================================================================================================
 -- UI FUNCTIONS
--==========================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
local g_IsOpen = false
local g_PlayerID = -1
-------------------------------------------------------------------------------------------------------------------------
--JFD_CyclesPower_BlockEndTurnButton
local function JFD_CyclesPower_BlockEndTurnButton(isBlocks, playerID)
	g_PlayerID = playerID
	
	ContextPtr:SetHide(not isBlocks);
	g_IsOpen = isBlocks

	if isBlocks then
		Controls.EndTurnText:LocalizeAndSetText("TXT_KEY_END_TURN_JFD_CYCLE_OF_POWER")
		Controls.EndTurnButton:LocalizeAndSetToolTip("TXT_KEY_END_TURN_JFD_CYCLE_OF_POWER_TT")
	end
end
LuaEvents.JFD_CyclesPower_UI_BlockEndTurnButton.Add(JFD_CyclesPower_BlockEndTurnButton)
-------------------------------------------------------------------------------------------------------------------------
--JFD_CyclesPower_EndTurnButton
local function JFD_CyclesPower_EndTurnButton()
	LuaEvents.UI_ShowChooseCycleOfPowerPopup(g_PlayerID)
end
Controls.EndTurnButton:RegisterCallback(Mouse.eLClick, JFD_CyclesPower_EndTurnButton);
-------------------------------------------------------------------------------------------------------------------------
--JFD_CyclesPower_CivilopediaScreenOpened
local function JFD_CyclesPower_CivilopediaScreenOpened()
	if g_IsOpen then
		ContextPtr:SetHide(true);
	end
end
LuaEvents.CivilopediaScreenOpened.Add(JFD_CyclesPower_CivilopediaScreenOpened)
Events.SerialEventEnterCityScreen.Add(JFD_CyclesPower_CivilopediaScreenOpened)
-------------------------------------------------------------------------------------------------------------------------
--JFD_CyclesPower_CivilopediaScreenClosed
local function JFD_CyclesPower_CivilopediaScreenClosed()
	if g_IsOpen then
		ContextPtr:SetHide(false);
	end
end
LuaEvents.CivilopediaScreenClosed.Add(JFD_CyclesPower_CivilopediaScreenClosed)
Events.SerialEventExitCityScreen.Add(JFD_CyclesPower_CivilopediaScreenClosed)
-------------------------------------------------------------------------------------------------------------------------
ContextPtr:SetHide(true);
 --==========================================================================================================================
--==========================================================================================================================