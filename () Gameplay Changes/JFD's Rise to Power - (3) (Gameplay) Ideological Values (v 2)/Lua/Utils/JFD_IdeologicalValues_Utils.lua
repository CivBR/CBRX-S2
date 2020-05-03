-- JFD_IdeologicalValues_Utils
-- Author: JFD
-- DateCreated: 4/30/2019 8:35:10 AM
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
------------------------------------------------------------------------------------------------------------------------
include("FLuaVector.lua")
include("JFD_RTP_Utils.lua")
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
-- CACHED TABLES
--==========================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
--g_Policy_JFD_IdeologicalValues_Table
local g_Policy_JFD_IdeologicalValues_Table = {}
local g_Policy_JFD_IdeologicalValues_Count = 1
for row in DB.Query("SELECT * FROM Policy_JFD_IdeologicalValues;") do 	
	g_Policy_JFD_IdeologicalValues_Table[g_Policy_JFD_IdeologicalValues_Count] = row
	g_Policy_JFD_IdeologicalValues_Count = g_Policy_JFD_IdeologicalValues_Count + 1
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
-- IDEOLOGICAL VALUE UTILS
--==========================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
--Player:GetPolicyIdeologicalValue
function Player.GetPolicyIdeologicalValue(player, policyID)
	--g_Policy_JFD_IdeologicalValues_Table
	local policiesTable = g_Policy_JFD_IdeologicalValues_Table
	local numPolicies = #policiesTable
	for index = 1, numPolicies do
		local row = policiesTable[index]
		local thisPolicyID = GameInfoTypes[row.PolicyType]
		if policyID == thisPolicyID then
			local ideologicalValueType = row.IdeologicalValueType
			return GameInfoTypes[ideologicalValueType]
		end
	end
end	
-------------------------------------------------------------------------------------------------------------------------
--Player:GetIdeologicalValues
function Player.GetIdeologicalValues(player)
	
	local numAuthority = 0
	local numAuthorityPercent = 0
	local numLiberty = 0
	local numLibertyPercent = 0
	local numEquality = 0
	local numEqualityPercent = 0
	local numTotal = 0

	--g_Policy_JFD_IdeologicalValues_Table
	local policiesTable = g_Policy_JFD_IdeologicalValues_Table
	local numPolicies = #policiesTable
	for index = 1, numPolicies do
		local row = policiesTable[index]
		local policyID = GameInfoTypes[row.PolicyType]
		if player:HasPolicy(policyID) then
			local ideologicalValueType = row.IdeologicalValueType
			--if row.Level == 0 then
				if ideologicalValueType == "IDEOLOGICAL_VALUE_JFD_AUTHORITY" then
					numAuthority = numAuthority + 1
				elseif ideologicalValueType == "IDEOLOGICAL_VALUE_JFD_LIBERTY" then
					numLiberty = numLiberty + 1
				elseif ideologicalValueType == "IDEOLOGICAL_VALUE_JFD_EQUALITY" then
					numEquality = numEquality + 1
				end
			--end
		end
	end
	numTotal = numAuthority + numEquality + numLiberty

	if numAuthority > 0 then
		numAuthorityPercent = g_GetRound((numAuthority/numTotal)*100)
	end
	if numLiberty > 0 then
		numLibertyPercent = g_GetRound((numLiberty/numTotal)*100)
	end
	if numEquality > 0 then
		numEqualityPercent = g_GetRound((numEquality/numTotal)*100)
	end

	return numAuthorityPercent, numLibertyPercent, numEqualityPercent
end	
-------------------------------------------------------------------------------------------------------------------------
--Player:HasIdeologicalValuesForTenet
function Player.HasIdeologicalValuesForTenet(player, policyID)
	local tenet = GameInfo.Policies[policyID]
	local ideologicalValueID = player:GetPolicyIdeologicalValue(policyID)
	if (not ideologicalValueID) then return true end

	local numAuthorityPercent, numEqualityPercent, numLibertyPercent = player:GetIdeologicalValues()
	local ideologicalValueType = GameInfo.JFD_IdeologicalValues[ideologicalValueID].Type
	local ideologicalValueReq = tenet.IdeologicalValueReq
	if ideologicalValueType == "IDEOLOGICAL_VALUE_JFD_AUTHORITY" then
		if (numAuthorityPercent >= ideologicalValueReq or tenet.PolicyBranchType == "POLICY_BRANCH_AUTOCRACY") then
			return true
		end
	elseif ideologicalValueType == "IDEOLOGICAL_VALUE_JFD_EQUALITY" then
		if (numEqualityPercent >= ideologicalValueReq or tenet.PolicyBranchType == "POLICY_BRANCH_ORDER") then
			return true
		end
	elseif ideologicalValueType == "IDEOLOGICAL_VALUE_JFD_LIBERTY" then
		if (numLibertyPercent >= ideologicalValueReq or tenet.PolicyBranchType == "POLICY_BRANCH_FREEDOM") then
			return true
		end
	end
	return false
end
--==========================================================================================================================
--==========================================================================================================================