-- JFD_NeutralityIdeology_Functions
-- Author: JFD
-- DateCreated: 4/30/2019 8:35:33 AM
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
include("JFD_NeutralityIdeology_Utils.lua")
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
--==========================================================================================================================
-- ACTIVE MODS
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
local g_IsCPActive  = Game.IsCPActive()
local g_IsVMCActive = Game.IsVMCActive()
--==========================================================================================================================
-- GLOBAL DEFINES
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
local defineMaxMinorCivs = GameDefines["MAX_MINOR_CIVS"]

local ideologyNeutralityID = GameInfoTypes["POLICY_BRANCH_JFD_NEUTRALITY"]
--==========================================================================================================================
-- CORE FUNCTIONS
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
--JFD_NeutralityIdeology_PlayerCanAdopyIdeology
local function JFD_NeutralityIdeology_PlayerCanAdopyIdeology(playerID, ideologyID)
	if ideologyID == ideologyNeutralityID then
		return player:CanAdoptNeutralityIdeology()
	end
	return true
end
GameEvents.PlayerCanAdopyIdeology.Add(JFD_NeutralityIdeology_PlayerCanAdopyIdeology)
----------------------------------------------------------------------------------------------------------------------------
--JFD_NeutralityIdeology_TeamSetEra
local eraModernID = GameInfoTypes["ERA_MODERN"]
local greatPowerSmallID = GameInfoTypes["GREAT_POWER_JFD_SMALL"]
local function JFD_NeutralityIdeology_TeamSetEra(teamID, eraID)
	local team = Teams[teamID]
	local playerID = team:GetLeaderID()
	local player = Players[playerID]
	if player:IsHuman() then return end

	if player:CanAdoptNeutralityIdeology() then
		if Player.GetGreatPowerStatus then
			if player:GetGreatPowerStatus() <= greatPowerSmallID then
				player:SetPolicyBranchUnlocked(ideologyNeutralityID, true)
			end
		else
			local numFlavours = ((player:GetFlavorValue("FLAVOR_CULTURE") + player:GetFlavorValue("FLAVOR_OFFENSE") + player:GetFlavorValue("FLAVOR_SCIENCE"))/3)
			if numFlavours <= 5 then
				local numChance = g_GetRandom(1,4)
				if numChance <= 4 then
					player:SetPolicyBranchUnlocked(ideologyNeutralityID, true)
				end
			end
		end
	end
end
GameEvents.TeamSetEra.Add(JFD_NeutralityIdeology_TeamSetEra)
--==========================================================================================================================
--==========================================================================================================================