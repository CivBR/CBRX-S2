--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
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
--JFD_Sovereignty_BlockEndTurnButton
local function JFD_Sovereignty_BlockEndTurnButton(isBlocks, playerID)
	g_PlayerID = playerID
	
	ContextPtr:SetHide(not isBlocks);
	g_IsOpen = isBlocks

	if isBlocks then
		Controls.EndTurnText:LocalizeAndSetText("TXT_KEY_END_TURN_JFD_CHOOSE_GOVERNMENT")
		Controls.EndTurnButton:LocalizeAndSetToolTip("TXT_KEY_END_TURN_JFD_CHOOSE_GOVERNMENT_TT")
	end
end
LuaEvents.JFD_Sovereignty_UI_BlockEndTurnButton.Add(JFD_Sovereignty_BlockEndTurnButton)
-------------------------------------------------------------------------------------------------------------------------
--JFD_Sovereignty_EndTurnButton
local function JFD_Sovereignty_EndTurnButton()
	LuaEvents.UI_ShowChooseGovernmentPopup(false, g_PlayerID)
end
Controls.EndTurnButton:RegisterCallback(Mouse.eLClick, JFD_Sovereignty_EndTurnButton);
-------------------------------------------------------------------------------------------------------------------------
--JFD_Sovereignty_CivilopediaScreenOpened
local function JFD_Sovereignty_CivilopediaScreenOpened()
	if g_IsOpen then
		ContextPtr:SetHide(true);
	end
end
LuaEvents.CivilopediaScreenOpened.Add(JFD_Sovereignty_CivilopediaScreenOpened)
Events.SerialEventEnterCityScreen.Add(JFD_Sovereignty_CivilopediaScreenOpened)
-------------------------------------------------------------------------------------------------------------------------
--JFD_Sovereignty_CivilopediaScreenClosed
local function JFD_Sovereignty_CivilopediaScreenClosed()
	if g_IsOpen then
		ContextPtr:SetHide(false);
	end
end
LuaEvents.CivilopediaScreenClosed.Add(JFD_Sovereignty_CivilopediaScreenClosed)
Events.SerialEventExitCityScreen.Add(JFD_Sovereignty_CivilopediaScreenClosed)
-------------------------------------------------------------------------------------------------------------------------
ContextPtr:SetHide(true);
 --==========================================================================================================================
--==========================================================================================================================