-- JFD_Industry_Functions
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
--==========================================================================================================================
-- GAME DEFINES
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
local defineMaxMajorCivs = GameDefines["MAX_MAJOR_CIVS"]
local defineMaxMinorCivs = GameDefines["MAX_MINOR_CIVS"]

local buildingResourceManagementGoldID = GameInfoTypes["BUILDING_JFD_RESOURCE_MANAGEMENT_GOLD"]
local policyAppliedScienceID = GameInfoTypes["POLICY_JFD_APPLIED_SCIENCE"]
local policyResourceManagementID = GameInfoTypes["POLICY_JFD_RESOURCE_MANAGEMENT"]
--==========================================================================================================================
-- CORE FUNCTIONS
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
--JFD_Industry_PlayerDoTurn
local function JFD_Industry_PlayerDoTurn(playerID)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if player:IsMinorCiv() then return end
	if player:IsBarbarian() then return end

	if (not player:HasPolicy(buildingResourceManagementGoldID)) then return end
	
	local numCities = player:GetNumCities()

	if player:CountNumBuildings(buildingResourceManagementGoldID) < numCities then
		for city in player:Cities() do
			city:SetNumRealBuilding(buildingResourceManagementGoldID, 1, true)
		end
	end
end
if buildingResourceManagementGoldID then
	GameEvents.PlayerDoTurn.Add(JFD_Industry_PlayerDoTurn)
end
----------------------------------------------------------------------------------------------------------------------------
--JFD_Industry_PlayerAdoptPolicy
local function JFD_Industry_PlayerAdoptPolicy(playerID, policyID)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if player:IsMinorCiv() then return end
	if player:IsBarbarian() then return end

	if policyID == policyResourceManagementID then
		JFD_Industry_PlayerDoTurn(playerID)
	end
end
if buildingResourceManagementGoldID then
	GameEvents.PlayerAdoptPolicy.Add(JFD_Industry_PlayerAdoptPolicy)
end
----------------------------------------------------------------------------------------------------------------------------
--JFD_Industry_GreatPersonExpended
local function JFD_Industry_GreatPersonExpended(playerID, unitID, unitTypeID, plotX, plotY)
	local player = Players[playerID]
	if (not unitTypeID) then unitTypeID = unitID end

	if (not player:HasPolicy(policyAppliedScienceID)) then return end
	
	local unit = GameInfo.Units[unitTypeID]
	local unitClassType = unit.Class
	if unitClassType ~= "UNITCLASS_SCIENTIST" and unitClassType ~= "UNITCLASS_ENGINEER" then return end

	local numCulture = (150*gameSpeedMod)
	local eraID = player:GetCurrentEra()
	numCulture = (numCulture + GameInfo.Eras[eraID].StartPercent)

	player:ChangeJONSCulture(numCulture)
	if (player:IsHuman() and player:IsTurnActive() and plotX and plotY) then
		local hex = ToHexFromGrid(Vector2(plotX, plotY))
		Events.AddPopupTextEvent(HexToWorld(hex), g_ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num} [ICON_CULTURE]", numCulture), true)
	else
		Events.GameplayAlertMessage(g_ConvertTextKey("TXT_KEY_POLICY_JFD_APPLIED_SCIENCE_ALERT", numCulture), unit.Description)
	end
end
GameEvents.GreatPersonExpended.Add(JFD_Industry_GreatPersonExpended)
--==========================================================================================================================
--==========================================================================================================================