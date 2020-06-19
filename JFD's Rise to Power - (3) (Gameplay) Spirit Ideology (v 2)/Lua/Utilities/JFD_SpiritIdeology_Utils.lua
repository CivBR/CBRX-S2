-- JFD_SpiritIdeology_Utils
-- Author: JFD
-- DateCreated: 6/4/2019 2:55:32 PM
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
------------------------------------------------------------------------------------------------------------------------
--==========================================================================================================================
-- CACHING
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

local gameSpeedID		= Game.GetGameSpeedType()
local gameSpeed			= GameInfo.GameSpeeds[gameSpeedID]

local handicapID		= Game.GetHandicapType()
local handicap			= GameInfo.HandicapInfos[handicapID]
--=======================================================================================================================
-- CACHED TABLES
--=======================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
--==========================================================================================================================
-- GAME DEFINES
--==========================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
local ideologySpiritID = GameInfoTypes["POLICY_BRANCH_JFD_SPIRIT"]
--==========================================================================================================================
-- ACTIVE MODS
--==========================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
local g_IsCPActive			= Game.IsCPActive()
local g_IsNationalismActive = Game.IsNationalismActive()
local g_IsVMCActive			= Game.IsVMCActive()
--==========================================================================================================================
-- SPIRIT UTILS
--==========================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
-- REFORM IDEOLOGY
-------------------------------------------------------------------------------------------------------------------------
--Player:GetReformIdeologyCost
function Player.GetReformIdeologyCost(player)
	if g_IsNationalismActive then
		return player:GetNationalismPolicyCost()
	else
		return player:GetNextPolicyCost()
	end
end	
-------------------------------------------------------------------------------------------------------------------------
--Player:CanReformIdeology
function Player.CanReformIdeology(player)
	local ideologyID = player:GetLateGamePolicyTree()
	if ideologyID == ideologySpiritID or ideologyID == -1 then
		return false, g_ConvertTextKey("TXT_KEY_POLICYSCREEN_JFD_REFORM_IDEOLOGY_DISABLED_TT")
	end

	if player:IsHuman() then
		if (not g_IsVMCActive) then 
			local cost = player:GetReformIdeologyCost()
			if g_IsNationalismActive then
				if player:GetNationalism() < cost then
					return false, g_ConvertTextKey("TXT_KEY_POLICYSCREEN_JFD_REFORM_IDEOLOGY_DISABLED_NATIONALISM_COST_TT", cost)
				else
					return true, g_ConvertTextKey("TXT_KEY_POLICYSCREEN_JFD_REFORM_IDEOLOGY_NATIONALISM_COST_TT", cost)
				end
			else
				if player:GetJONSCulture() < cost then
					return false, g_ConvertTextKey("TXT_KEY_POLICYSCREEN_JFD_REFORM_IDEOLOGY_DISABLED_CULTURE_COST_TT", cost)
				else
					return true, g_ConvertTextKey("TXT_KEY_POLICYSCREEN_JFD_REFORM_IDEOLOGY_CULTURE_COST_TT", cost)
				end
			end
		else
			local cost = player:GetReformIdeologyCost()
			if g_IsNationalismActive then
				if player:GetNationalism() < cost then
					return false, g_ConvertTextKey("TXT_KEY_POLICYSCREEN_JFD_REFORM_IDEOLOGY_DISABLED_NATIONALISM_COST_TT_CP", cost)
				else
					return true, g_ConvertTextKey("TXT_KEY_POLICYSCREEN_JFD_REFORM_IDEOLOGY_NATIONALISM_COST_TT_CP", cost)
				end
			else
				if player:GetJONSCulture() < cost then
					return false, g_ConvertTextKey("TXT_KEY_POLICYSCREEN_JFD_REFORM_IDEOLOGY_DISABLED_CULTURE_COST_TT_CP", cost)
				else
					return true, g_ConvertTextKey("TXT_KEY_POLICYSCREEN_JFD_REFORM_IDEOLOGY_CULTURE_COST_TT_CP", cost)
				end
			end
		end
	else
		return true
	end
end	
-------------------------------------------------------------------------------------------------------------------------
-- SPIRIT
-------------------------------------------------------------------------------------------------------------------------
--g_Policies_Table
local g_Policies_Table = {}
local g_Policies_Count = 1
for row in DB.Query("SELECT Type FROM Policies WHERE Level = 1 OR Level = 2 OR Level = 3;") do 	
	g_Policies_Table[g_Policies_Count] = row
	g_Policies_Count = g_Policies_Count + 1
end

--Player_GetSpiritAdoptionChance
function Player_GetSpiritAdoptionChance(player)
	local flavourCulture = player:GetFlavorValue("FLAVOR_CULTURE")
	local flavourReligion = player:GetFlavorValue("FLAVOR_RELIGION")
	if flavourCulture <= 8 and flavourReligion <= 7 then 
		return 0 
	end

	if flavourReligion <= 7 then 
		return 0 
	end

	local numTenets = player:GetNumIdeologicalTenets()
	return (flavourCulture+flavourReligion)*numTenets
end
-------------------------------------------------------------------------------------------------------------------------
--g_Policy_PolicyBranchType_Table
local g_Policy_PolicyBranchType_Table = {}
local g_Policy_PolicyBranchType_Count = 1
for row in DB.Query("SELECT ID, Type, PolicyBranchType FROM Policies WHERE PolicyBranchType IN ('POLICY_BRANCH_AUTOCRACY', 'POLICY_BRANCH_FREEDOM', 'POLICY_BRANCH_ORDER');") do 	
	g_Policy_PolicyBranchType_Table[g_Policy_PolicyBranchType_Count] = row
	g_Policy_PolicyBranchType_Count = g_Policy_PolicyBranchType_Count + 1
end

--g_Policy_OriginalPolicyBranchType_Table
local g_Policy_OriginalPolicyBranchType_Table = {}
local g_Policy_OriginalPolicyBranchType_Count = 1
for row in DB.Query("SELECT ID, OriginalPolicyType, OriginalPolicyBranchType FROM Policies WHERE OriginalPolicyBranchType IS NOT NULL;") do 	
	g_Policy_OriginalPolicyBranchType_Table[g_Policy_OriginalPolicyBranchType_Count] = row
	g_Policy_OriginalPolicyBranchType_Count = g_Policy_OriginalPolicyBranchType_Count + 1
end

--Player:DoAdoptSpiritIdeology
function Player.DoAdoptSpiritIdeology(player)
	local originalIdeologyID = player:GetLateGamePolicyTree()
	local originalIdeologyType = GameInfo.PolicyBranchTypes[originalIdeologyID].Type

	player:SetPolicyBranchUnlocked(originalIdeologyID, false)
	player:SetPolicyBranchUnlocked(ideologySpiritID, true)
	player:SetNumFreeTenets(0)

	local cost = player:GetReformIdeologyCost()
	if g_IsNationalismActive then
		player:ChangeNationalism(-cost)
	else
		player:ChangeJONSCulture(-cost)
	end

	if Player.SwapPolicy then
		--g_Policy_OriginalPolicyBranchType_Table
		local policiesTable = g_Policy_OriginalPolicyBranchType_Table
		local numPolicies = #policiesTable
		for index = 1, numPolicies do
			local row = policiesTable[index]
			local policyID = row.ID
			local originalPolicyID = GameInfoTypes[row.OriginalPolicyType]
			if row.OriginalPolicyBranchType == originalIdeologyType and player:HasPolicy(originalPolicyID) then
				player:SwapPolicy(policyID, originalPolicyID, true)
			end
		end
	else
		--g_Policy_PolicyBranchType_Table
		local policiesTable = g_Policy_PolicyBranchType_Table
		local numPolicies = #policiesTable
		for index = 1, numPolicies do
			local row = policiesTable[index]
			local policyID = row.ID
			if row.PolicyBranchType == originalIdeologyType and player:HasPolicy(policyID) then
				player:ChangeNumFreeTenets(1)
				player:SetHasPolicy(policyID, false)
			end
		end
	end

	if player:IsHuman() then
		player:SendNotification("NOTIFICATION_JFD_SPIRIT_IDEOLOGY", g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_SPIRIT_IDEOLOGY_DESC"), g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_SPIRIT_IDEOLOGY_SHORT_DESC"), false, nil, nil, -1)
	else
		--if playerTeam:IsHasMet(player:GetTeam()) then
		--	player:SendNotification("NOTIFICATION_JFD_SPIRIT_IDEOLOGY", g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_SPIRIT_IDEOLOGY_OTHER_DESC", player:GetCivilizationShortDescription()), g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_SPIRIT_IDEOLOGY_OTHER_SHORT_DESC"), false, nil, nil, -1)
		--else
		--	player:SendNotification("NOTIFICATION_JFD_SPIRIT_IDEOLOGY", g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_SPIRIT_IDEOLOGY_OTHER_UNMET_DESC", player:GetCivilizationShortDescription()), g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_SPIRIT_IDEOLOGY_OTHER_SHORT_DESC"), false, nil, nil, -1)
		--end
	end

	LuaEvents.JFD_SpiritIdeologyAdopted(playerID)
end
--==========================================================================================================================
--==========================================================================================================================