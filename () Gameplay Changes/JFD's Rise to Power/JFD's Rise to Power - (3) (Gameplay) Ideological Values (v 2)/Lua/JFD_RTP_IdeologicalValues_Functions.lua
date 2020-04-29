-- JFD_CycledGovts_Functions
-- Author: JFD
-- DateCreated: 4/30/2019 8:35:33 AM
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
------------------------------------------------------------------------------------------------------------------------
include("JFD_IdeologicalValues_Utils.lua")
--==========================================================================================================================
-- GLOBALS
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
local g_ConvertTextKey  = Locale.ConvertTextKey
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
-- CACHED TABLES
--==========================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
--g_Tenets_Table
local g_Tenets_Table = {}
local g_Tenets_Count = 1
for row in DB.Query("SELECT ID, Level FROM Policies WHERE Level > 0;") do 	
	g_Tenets_Table[g_Tenets_Count] = row
	g_Tenets_Count = g_Tenets_Count + 1
end
--==========================================================================================================================
-- ACTIVE MODS
--==========================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
local g_IsVMCActive = Game.IsCPActive()
--==========================================================================================================================
-- CORE FUNCTIONS
--==========================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
--JFD_IdeologicalValues_PlayerCanAdoptPolicy
local function JFD_IdeologicalValues_PlayerCanAdoptPolicy(playerID, policyID)
	local player = Players[playerID]
	if (not player:IsHuman()) then
		local policy = GameInfo.Policies[policyID]
		local ideologicalValueType = player:GetPolicyIdeologicalValue(policyID)
		local ideologicalValueReq = policy.IdeologicalValueReq
		if ideologicalValueType and ideologicalValueReq > 0 then
			return player:HasIdeologicalValuesForTenet(policy.ID)
		end
	end
	return true
end
GameEvents.PlayerCanAdoptPolicy.Add(JFD_IdeologicalValues_PlayerCanAdoptPolicy)
-------------------------------------------------------------------------------------------------------------------------
--JFD_IdeologicalValues_GetDiploModifier
local diploModSharedIdeologicalTenetsID = GameInfoTypes["DIPLOMODIFIER_JFD_SHARED_IDEOLOGICAL_VALUES"]
local function JFD_RTP_Sovereignty_DiploModifiers(diploModifierID, fromPlayerID, toPlayerID)
	local diploModifier = 0
	local fromPlayer = Players[fromPlayerID]
	local toPlayer = Players[toPlayerID]
	if diploModifierID == diploModSharedIdeologicalTenetsID then
		--g_Tenets_Table
		local tenetsTable = g_Tenets_Table
		local numTenets = #tenetsTable
		for index = 1, numTenets do
			local row = tenetsTable[index]
			if fromPlayer:HasPolicy(row.ID) and toPlayer:HasPolicy(row.ID) then
				diploModifier = diploModifier + (1*row.Level)
			end
		end
		diploModifier = (diploModifier*-1)
	end

	return diploModifier
end
if g_IsVMCActive then
	--GameEvents.GetDiploModifier.Add(JFD_IdeologicalValues_GetDiploModifier)
end
--==========================================================================================================================
-- UI FUNCTIONS
--==========================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
--==========================================================================================================================
--==========================================================================================================================