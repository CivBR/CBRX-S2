-- JFD_GreatPhilosophers_Functions
-- Author: JFD
-- DateCreated: 3/17/2018 2:04:37 PM
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
------------------------------------------------------------------------------------------------------------------------
include("FLuaVector.lua")
include("JFD_GreatPhilosophers_Utils.lua")
--==========================================================================================================================
-- GLOBALS
--==========================================================================================================================
------------------------------------------------------------------------------------------------------------------------
local g_ConvertTextKey  	= Locale.ConvertTextKey
local g_GameSpeedID			= Game.GetGameSpeedType()
local g_GameSpeed			= GameInfo.GameSpeeds[g_GameSpeedID]
local g_GameSpeedMod		= g_GameSpeed.GoldenAgePercent/100
local g_GetRandom	    	= Game.GetRandom
local g_GetRound	    	= Game.GetRound
local g_GetUserSetting  	= Game.GetUserSetting
local g_MathMin				= math.min
local g_MapGetPlot			= Map.GetPlot
local g_MapPlotDistance		= Map.PlotDistance
							
local Players 				= Players
local HexToWorld 			= HexToWorld
local ToHexFromGrid 		= ToHexFromGrid
local Teams 				= Teams
							
local activePlayerID		= Game.GetActivePlayer()
local activePlayer			= Players[activePlayerID]
--=======================================================================================================================
-- CACHED TABLES
--=======================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
--g_Missions_Table
local g_Missions_Table = {}
local g_Missions_Count = 1
for row in DB.Query("SELECT ID, PolicyType, UniqueNameReq FROM Missions WHERE PolicyType IS NOT NULL;") do 	
	g_Missions_Table[g_Missions_Count] = row
	g_Missions_Count = g_Missions_Count + 1
end

--g_Policies_Table
local g_Policies_Table = {}
local g_Policies_Count = 1
for row in DB.Query("SELECT ID, Type, Description, Help, BranchPhilosophyTag FROM Policies WHERE PolicyBranchType = 'POLICY_BRANCH_JFD_PHILOSOPHY';") do 	
	g_Policies_Table[g_Policies_Count] = row
	g_Policies_Count = g_Policies_Count + 1
end
--==========================================================================================================================
-- GAME DEFINES
--==========================================================================================================================
------------------------------------------------------------------------------------------------------------------------
local CUSTOM_MISSION_NO_ACTION		 	= 0
local CUSTOM_MISSION_ACTION			 	= 1
local CUSTOM_MISSION_DONE            	= 2
local CUSTOM_MISSION_ACTION_AND_DONE 	= 3

local defineMaxMajorCivs = GameDefines["MAX_MAJOR_CIVS"]

local missionGrantSocialPolicyID  = GameInfoTypes["MISSION_JFD_GRANT_SOCIAL_POLICY"] 

local unitClassGreatPhilosopherID = GameInfoTypes["UNITCLASS_JFD_GREAT_PHILOSOPHER"]
--==========================================================================================================================
-- ACTIVE MODS
--==========================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
local g_IsCPActive = Game.IsCPActive()
--==========================================================================================================================
-- CORE FUNCTIONS
--==========================================================================================================================
------------------------------------------------------------------------------------------------------------------------
-- GREAT PEOPLE
------------------------------------------------------------------------------------------------------------------------
--JFD_GreatPhilosophers_UnitCreated
local function JFD_GreatPhilosophers_UnitCreated(playerID, unitID, unitTypeID)
	local player = Players[playerID]
	if player:IsHuman() then return end
	
	local unit = player:GetUnitByID(unitID) 
	if unit:GetUnitClassType() ~= unitClassGreatPhilosopherID then return end
	
	local capital = player:GetCapitalCity()
	if (not capital) then return end

	--g_Missions_Table
	local missionsTable = g_Missions_Table
	local numMissions = #missionsTable
	for index = 1, numMissions do
		local row = missionsTable[index]
		local uniqueName = g_ConvertTextKey(row.UniqueNameReq) .. " (" .. g_ConvertTextKey(unit:GetNameKey()) .. ")"
		if unit:GetName() == uniqueName then
			local missionID = row.ID
			JFD_GreatPhilosophers_CustomMissionStart(playerID, unitID, missionID, data1, data2, flags, turn)
		end
	end	
end
GameEvents.UnitCreated.Add(JFD_GreatPhilosophers_UnitCreated)
------------------------------------------------------------------------------------------------------------------------
-- MISSIONS
------------------------------------------------------------------------------------------------------------------------
--JFD_GreatPhilosophers_GreatPersonExpended
local function JFD_GreatPhilosophers_GreatPersonExpended(playerID, unitID, unitTypeID, plotX, plotY)
	local player = Players[playerID]
	if (not player:IsHuman()) then return end
	local unit = player:GetUnitByID(unitID) 
	if (not unit) then return end
	if unit:GetUnitClassType() ~= unitClassGreatPhilosopherID then return end
	
	local hex = ToHexFromGrid(Vector2(plotX, plotY))
	Events.GameplayFX(hex.x, hex.y, -1) 
	Events.AudioPlay2DSound("AS2D_UNIT_JFD_GREAT_PHILOSOPHER_ACTIVATE")
end
GameEvents.GreatPersonExpended.Add(JFD_GreatPhilosophers_GreatPersonExpended)
------------------------------------------------------------------------------------------------------------------------
--JFD_GreatPhilosophers_CustomMissionStart
local function JFD_GreatPhilosophers_CustomMissionStart(playerID, unitID, missionID, data1, data2, flags, turn)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	local plot = unit:GetPlot()

	--g_Missions_Table
	local missionsTable = g_Missions_Table
	local numMissions = #missionsTable
	for index = 1, numMissions do
		local row = missionsTable[index]
		if (missionID == row.ID) then
			local policyID = GameInfoTypes[row.PolicyType]
			local policy = GameInfo.Policies[policyID]

			--g_Policies_Table
			local policiesTable = g_Policies_Table
			local numPolicies = #policiesTable
			for index = 1, numPolicies do
				local row = policiesTable[index]
				if row.BranchPhilosophyTag == policy.BranchPhilosophyTag then
					local thisPolicyID = row.ID
					if player:HasPolicy(thisPolicyID) then
						player:RevokePolicy(thisPolicyID, true)
					end
				end
			end
			player:GrantPolicy(policyID, true)

			unit:greatperson()
			LuaEvents.GreatPhilosopherExpended(playerID, unitID, policyID)
			return CUSTOM_MISSION_ACTION
		end
	end

	if missionID == missionGrantSocialPolicyID then
		player:ChangeNumFreePolicies(1)
		unit:greatperson()
		return CUSTOM_MISSION_ACTION
	end

	return CUSTOM_MISSION_NO_ACTION
end
GameEvents.CustomMissionStart.Add(JFD_GreatPhilosophers_CustomMissionStart)
------------------------------------------------------------------------------------------------------------------------
--JFD_GreatPhilosophers_CustomMissionCompleted
local function JFD_GreatPhilosophers_CustomMissionCompleted(playerID, unitID, missionID, data1, data2, flags, turn)

	--g_Missions_Table
	local missionsTable = g_Missions_Table
	local numMissions = #missionsTable
	for index = 1, numMissions do
		local row = missionsTable[index]
		if (missionID == row.ID) then
			return true
		end
	end

	if missionID == missionGrantSocialPolicyID then
		return true
	end
end
GameEvents.CustomMissionCompleted.Add(JFD_GreatPhilosophers_CustomMissionCompleted)
------------------------------------------------------------------------------------------------------------------------
--JFD_GreatPhilosophers_CustomMissionPossible
local function JFD_GreatPhilosophers_CustomMissionPossible(playerID, unitID, missionID, data1, data2, _, _, plotX, plotY, bTestVisible)
	if ((not playerID) or (not unitID) or (not missionID)) then return end
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	
	--g_Missions_Table
	local missionsTable = g_Missions_Table
	local numMissions = #missionsTable
	for index = 1, numMissions do
		local row = missionsTable[index]
		if (missionID == row.ID) then
			if unit:GetUnitClassType() == unitClassGreatPhilosopherID then
				local uniqueName = g_ConvertTextKey(row.UniqueNameReq) .. " (" .. g_ConvertTextKey(unit:GetNameKey()) .. ")"
				if unit:GetName() == uniqueName then
					if unit:GetDamage() == 0 then
						return true
					else
						return bTestVisible
					end
				end
			end
		end
	end	

	if missionID == missionGrantSocialPolicyID then
		if unit:GetUnitClassType() == unitClassGreatPhilosopherID then
			if unit:GetDamage() == 0 then
				return true
			else
				return bTestVisible
			end
		end
	end
	
	return false
end
GameEvents.CustomMissionPossible.Add(JFD_GreatPhilosophers_CustomMissionPossible)
------------------------------------------------------------------------------------------------------------------------
-- POLICIES
------------------------------------------------------------------------------------------------------------------------
--JFD_GreatPhilosophers_PlayerCanAdoptPolicy
local function JFD_GreatPhilosophers_PlayerCanAdoptPolicy(playerID, policyID)
local player = Players[playerID]
	if (not player:IsHuman()) then
		local policy = GameInfo.Policies[policyID]
		if policy.PolicyBranchType == "POLICY_BRANCH_JFD_PHILOSOPHY" then
			return false
		end
	end
	return true
end
GameEvents.PlayerCanAdoptPolicy.Add(JFD_IdeologicalValues_PlayerCanAdoptPolicy)
--==========================================================================================================================
--==========================================================================================================================
