-- JFD_SPS_Utils
-- Author: JFD
-- DateCreated: 8/21/2019 2:17:31 AM
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
------------------------------------------------------------------------------------------------------------------------
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

local activePlayerID	= Game.GetActivePlayer()
local activePlayer		= Players[activePlayerID]
local activeTeamID		= activePlayer:GetTeam()
local activeTeam		= Teams[activeTeamID]
--=======================================================================================================================
-- CACHED TABLES
--=======================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
--g_PolicyBranch_EraSplashBackgrounds_Table
local g_PolicyBranch_EraSplashBackgrounds_Table = {}
local g_PolicyBranch_EraSplashBackgrounds_Count = 1
for row in DB.Query("SELECT * FROM PolicyBranch_EraSplashBackgrounds WHERE Texture IS NOT NULL;") do 	
	g_PolicyBranch_EraSplashBackgrounds_Table[g_PolicyBranch_EraSplashBackgrounds_Count] = row
	g_PolicyBranch_EraSplashBackgrounds_Count = g_PolicyBranch_EraSplashBackgrounds_Count + 1
end
--==========================================================================================================================
-- ACTIVE MODS
--==========================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
--==========================================================================================================================
-- GAME DEFINES
--==========================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
--==========================================================================================================================
-- SOCIAL POLICY SCREEN UTILS
--==========================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
--Game_GetPolicyBranchEraSplashBackground
function Game_GetPolicyBranchEraSplashBackground(policyBranchType)
	local eraType = GameInfo.Eras[activePlayer:GetCurrentEra()].Type

	local eraSplashBackground = nil

	--g_PolicyBranch_EraSplashBackgrounds_Table
	local policiesTable = g_PolicyBranch_EraSplashBackgrounds_Table
	local numPolicies = #policiesTable
	for index = 1, numPolicies do
		local row = policiesTable[index]
		if row.PolicyBranchType == policyBranchType and row.EraType == eraType then
			eraSplashBackground = row.Texture
			break
		end
	end
	
	return eraSplashBackground
end	
--==========================================================================================================================
--==========================================================================================================================