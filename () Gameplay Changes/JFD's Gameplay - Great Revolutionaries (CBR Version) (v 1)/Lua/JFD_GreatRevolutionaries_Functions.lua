-- JFD_GreatRevolutionaries_Functions
-- Author: JFD
-- DateCreated: 3/17/2018 2:04:37 PM
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
------------------------------------------------------------------------------------------------------------------------
include("JFD_GreatRevolutionaries_Utils.lua")
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
--==========================================================================================================================
-- GAME DEFINES
--==========================================================================================================================
------------------------------------------------------------------------------------------------------------------------
local CUSTOM_MISSION_NO_ACTION		 	= 0
local CUSTOM_MISSION_ACTION			 	= 1
local CUSTOM_MISSION_DONE            	= 2
local CUSTOM_MISSION_ACTION_AND_DONE 	= 3

local defineMaxMajorCivs = GameDefines["MAX_MAJOR_CIVS"]

local buildingIdeologyID			= GameInfoTypes["BUILDING_JFD_GREAT_REVOLUTIONARIES"]
local eraIndustrialID				= GameInfoTypes["ERA_INDUSTRIAL"]
local missionFoundIdeologyID		= GameInfoTypes["MISSION_JFD_FOUND_IDEOLOGY"] 
local unitClassGreatRevolutionaryID = GameInfoTypes["UNITCLASS_JFD_GREAT_REVOLUTIONARY"]
--==========================================================================================================================
-- ACTIVE MODS
--==========================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
-- local g_IsCPActive = Game.IsCPActive()
local g_IsCPActive = true
--==========================================================================================================================
-- CORE FUNCTIONS
--==========================================================================================================================
------------------------------------------------------------------------------------------------------------------------
-- IDEOLOGY
------------------------------------------------------------------------------------------------------------------------
--JFD_GreatRevolutionaries_IdeologyAdopted
local ideologyAutocracyID = GameInfoTypes["POLICY_BRANCH_AUTOCRACY"]
local ideologyFreedomID   = GameInfoTypes["POLICY_BRANCH_FREEDOM"]
local ideologyOrderID     = GameInfoTypes["POLICY_BRANCH_ORDER"]
local function JFD_GreatRevolutionaries_IdeologyAdopted(playerID, ideologyID)
	if Game.AnyoneHasIdeology(ideologyAutocracyID) and Game.AnyoneHasIdeology(ideologyFreedomID) and Game.AnyoneHasIdeology(ideologyOrderID) then
		for otherPlayerID = 0, defineMaxMajorCivs - 1 do
			local otherPlayer = Players[otherPlayerID]
			if otherPlayer:IsAlive() then
				if otherPlayer:GetLateGamePolicyTree() == -1 then
					otherPlayer:GetCapitalCity():SetNumRealBuilding(buildingIdeologyID, 1)
				else
					otherPlayer:GetCapitalCity():SetNumRealBuilding(buildingIdeologyID, 0)
				end
			end
		end
	end
end
if g_IsCPActive then
	GameEvents.IdeologyAdopted.Add(JFD_GreatRevolutionaries_IdeologyAdopted)
end
------------------------------------------------------------------------------------------------------------------------
-- GREAT PEOPLE
------------------------------------------------------------------------------------------------------------------------
--JFD_GreatRevolutionaries_UnitCreated
local function JFD_GreatRevolutionaries_UnitCreated(playerID, unitID, unitTypeID)
	local player = Players[playerID]
	if player:IsHuman() then return end
	
	local unit = player:GetUnitByID(unitID) 
	if unit:GetUnitClassType() ~= unitClassGreatRevolutionaryID then return end
	
	if player:GetLateGamePolicyTree() ~= -1 then return end
	if player:GetCurrentEra() < eraIndustrialID then return end
	
	local capital = player:GetCapitalCity()
	if (not capital) then return end

	player:GetCapitalCity():SetNumRealBuilding(buildingIdeologyID, 1)
	unit:greatperson()
	player:SendWorldEvent(g_ConvertTextKey("TXT_KEY_WORLD_EVENT_JFD_GREAT_REVOLUTIONARY_DESC", player:GetCivilizationShortDescription(), false))
end
if g_IsCPActive then
	GameEvents.UnitCreated.Add(JFD_GreatRevolutionaries_UnitCreated)
end
------------------------------------------------------------------------------------------------------------------------
--JFD_GreatRevolutionaries_SerialEventUnitCreated
local function JFD_GreatRevolutionaries_SerialEventUnitCreated(playerID, unitID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if (not unit) then return end
	if unit:GetUnitClassType() ~= unitClassGreatRevolutionaryID then return end
	
	if player:GetLateGamePolicyTree() ~= -1 then return end
	if player:GetCurrentEra() < eraIndustrialID then return end
	
	local capital = player:GetCapitalCity()
	if (not capital) then return end

	player:GetCapitalCity():SetNumRealBuilding(buildingIdeologyID, 1)
	unit:Kill(-1)

	if player:IsHuman() then
		local hex = ToHexFromGrid(Vector2(unit:GetX(), unit:GetY()))
		Events.GameplayFX(hex.x, hex.y, -1) 
		--Events.AudioPlay2DSound("AS2D_UNIT_JFD_GREAT_REVOLUTIONARY_ACTIVATE")
		player:SendNotification("NOTIFICATION_GENERIC", g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_GREAT_REVOLUTIONARY_DESC"), g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_GREAT_REVOLUTIONARY_SHORT_DESC"), false, nil, nil, -1)
	else
		player:SendWorldEvent(g_ConvertTextKey("TXT_KEY_WORLD_EVENT_JFD_GREAT_REVOLUTIONARY_DESC", player:GetCivilizationShortDescription()), false)
	end
end
if (not g_IsCPActive) then
	Events.SerialEventUnitCreated.Add(JFD_GreatRevolutionaries_SerialEventUnitCreated)
end
------------------------------------------------------------------------------------------------------------------------
-- MISSIONS
------------------------------------------------------------------------------------------------------------------------
--JFD_GreatRevolutionaries_GreatPersonExpended
local function JFD_GreatRevolutionaries_GreatPersonExpended(playerID, unitID, unitTypeID, plotX, plotY)
	local player = Players[playerID]
	if (not player:IsHuman()) then return end
	local unit = player:GetUnitByID(unitID) 
	if (not unit) then return end
	if unit:GetUnitClassType() ~= unitClassGreatRevolutionaryID then return end
	
	local hex = ToHexFromGrid(Vector2(plotX, plotY))
	Events.GameplayFX(hex.x, hex.y, -1) 
	--Events.AudioPlay2DSound("AS2D_UNIT_JFD_GREAT_REVOLUTIONARY_ACTIVATE")
end
if g_IsCPActive then
	GameEvents.GreatPersonExpended.Add(JFD_GreatRevolutionaries_GreatPersonExpended)
end
------------------------------------------------------------------------------------------------------------------------
--JFD_GreatRevolutionaries_CustomMissionStart
local function JFD_GreatRevolutionaries_CustomMissionStart(playerID, unitID, missionID, data1, data2, flags, turn)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	local plot = unit:GetPlot()
	local city = plot:GetPlotCity()
	if (not city) then return end
	if missionID == missionFoundIdeologyID then
		player:GetCapitalCity():SetNumRealBuilding(buildingIdeologyID, 1)
		unit:greatperson()
		return CUSTOM_MISSION_ACTION
	end
	return CUSTOM_MISSION_NO_ACTION
end
if g_IsCPActive then
	GameEvents.CustomMissionStart.Add(JFD_GreatRevolutionaries_CustomMissionStart)
end
------------------------------------------------------------------------------------------------------------------------
--JFD_GreatRevolutionaries_CustomMissionCompleted
local function JFD_GreatRevolutionaries_CustomMissionCompleted(playerID, unitID, missionID, data1, data2, flags, turn)
	return (missionID == missionFoundIdeologyID)
end
if g_IsCPActive then
	GameEvents.CustomMissionCompleted.Add(JFD_GreatRevolutionaries_CustomMissionCompleted)
end
------------------------------------------------------------------------------------------------------------------------
--JFD_GreatRevolutionaries_CustomMissionPossible
local function JFD_GreatRevolutionaries_CustomMissionPossible(playerID, unitID, missionID, data1, data2, _, _, plotX, plotY, bTestVisible)
	if ((not playerID) or (not unitID) or (not missionID)) then return end
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	
	if missionID == missionFoundIdeologyID then
		if unit:GetUnitClassType() == unitClassGreatRevolutionaryID then
			if unit:GetDamage() == 0 and unit:GetPlot():GetPlotCity() then
				if player:GetLateGamePolicyTree() ~= -1 then
					return false
				end
				if player:GetCurrentEra() >= eraIndustrialID then
					return true
				else
					return bTestVisible
				end
			else
				return bTestVisible
			end
		end
	end	
	
	return false
end
if g_IsCPActive then
	GameEvents.CustomMissionPossible.Add(JFD_GreatRevolutionaries_CustomMissionPossible)
end
--==========================================================================================================================
--==========================================================================================================================

