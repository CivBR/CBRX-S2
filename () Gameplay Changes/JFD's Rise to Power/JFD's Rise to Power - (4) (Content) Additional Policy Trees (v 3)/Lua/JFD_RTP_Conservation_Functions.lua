-- JFD_Conservation_Functions
-- Author: JFD
-- DateCreated: 1/25/2020 9:23:03 PM
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
include("FLuaVector.lua")
--==========================================================================================================================
-- GLOBALS
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
local g_ConvertTextKey  = Locale.ConvertTextKey
local g_GetRandom		= Game.GetRandom
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
local gameSpeedMod		= (gameSpeed.BuildPercent/100) 
--=======================================================================================================================
-- CACHED TABLES
--=======================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
--==========================================================================================================================
-- ACTIVE MODS
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
local g_IsCPActive = Game.IsCPActive()
local g_IsVMCActive = Game.IsVMCActive()
--==========================================================================================================================
-- GAME DEFINES
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
local defineMaxMajorCivs = GameDefines["MAX_MAJOR_CIVS"]
local defineMaxMinorCivs = GameDefines["MAX_MINOR_CIVS"]

local buildingNationalTrustCultureID = GameInfoTypes["BUILDING_JFD_NATIONAL_TRUST_CULTURE"]
local buildingSustainabilityYieldsID = GameInfoTypes["BUILDING_JFD_SUSTAINABILITY_YIELDS"]
local policyGreenEnergyID = GameInfoTypes["POLICY_JFD_GREEN_ENERGY"]
local policyNationalTrustID = GameInfoTypes["POLICY_JFD_NATIONAL_TRUST"]
local policySustainabilityID = GameInfoTypes["POLICY_JFD_SUSTAINABILITY"]
--==========================================================================================================================
-- CORE FUNCTIONS
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
--JFD_Conservation_PlayerDoTurn
local function JFD_Conservation_PlayerDoTurn(playerID)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if player:IsMinorCiv() then return end
	if player:IsBarbarian() then return end

	local numCities = player:GetNumCities()

	if player:CountNumBuildings(buildingSustainabilityYieldsID) < numCities then
		if player:HasPolicy(policySustainabilityID) then 
			for city in player:Cities() do
				city:SetNumRealBuilding(buildingSustainabilityYieldsID, 1, true)
			end
		end
	end

	if player:CountNumBuildings(buildingNationalTrustCultureID) < numCities then
		if player:HasPolicy(policyNationalTrustID) then 
			for city in player:Cities() do
				city:SetNumRealBuilding(buildingNationalTrustCultureID, 1, true)
			end
		end
	end
end
if buildingSustainabilityYieldsID then
	GameEvents.PlayerDoTurn.Add(JFD_Conservation_PlayerDoTurn)
end
----------------------------------------------------------------------------------------------------------------------------
--JFD_Conservation_PlayerAdoptPolicy
local function JFD_Conservation_PlayerAdoptPolicy(playerID, policyID)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if player:IsMinorCiv() then return end
	if player:IsBarbarian() then return end

	local numCities = player:GetNumCities()

	if buildingNationalTrustCultureID then
		if policyID == policyNationalTrustID then
			JFD_Conservation_PlayerDoTurn(playerID)
		end
	end

	if buildingSustainabilityYieldsID then
		if policyID == policySustainabilityID then
			JFD_Conservation_PlayerDoTurn(playerID)
		end
	end

	if (not g_IsCPActive) then
		local policyBranch = GameInfo.Policies[policyID].PolicyBranchType
		if policyBranch == "POLICY_BRANCH_JFD_CONSERVATION" then
			if (policyID == policyNationalTrustID and player:HasPolicy(policyGreenEnergyID)) 
			or (policyID == policyGreenEnergyID and player:HasPolicy(policyNationalTrustID)) then
				local buildingRecyclingCentreID = GameInfoTypes[player:GetUniqueBuilding("BUILDINGCLASS_RECYCLING_CENTER")]
				if g_IsVMCActive then
					local numGranted = 0
					for city in player:Cities() do
						city:SetNumFreeBuilding(buildingRecyclingCentreID, 1, true)
						numGranted = numGranted + 1 
						if numGranted == 2 then 
							break
						end
					end
				else
					local numGranted = 0
					for city in player:Cities() do
						if (not city:IsHasBuilding(buildingRecyclingCentreID)) then
							city:SetNumRealBuilding(buildingRecyclingCentreID, 1, true)
							numGranted = numGranted + 1 
							if numGranted == 2 then 
								break
							end
						end
					end
				end
			end
		end
	end
end
GameEvents.PlayerAdoptPolicy.Add(JFD_Conservation_PlayerAdoptPolicy)
--==========================================================================================================================
--==========================================================================================================================