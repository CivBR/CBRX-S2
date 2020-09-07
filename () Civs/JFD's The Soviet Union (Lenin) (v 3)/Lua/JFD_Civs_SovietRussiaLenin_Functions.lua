-- JFD_Civs_SovietRussiaLenin_Functions
-- Author: JFD
-- DateCreated: 2/15/2014 6:33:36 PM
--=======================================================================================================================
-- INCLUDES
--=======================================================================================================================
------------------------------------------------------------------------------------------------------------------------
include("FLuaVector.lua")
include("PlotIterators.lua")
--=======================================================================================================================
-- GLOBALS
--=======================================================================================================================
------------------------------------------------------------------------------------------------------------------------
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
--=======================================================================================================================
-- UTILITIES
--=======================================================================================================================
------------------------------------------------------------------------------------------------------------------------
-- CORE UTILITIES
------------------------------------------------------------------------------------------------------------------------
--HasTrait
function HasTrait(player, traitID)
	if Player.HasTrait then 
		return player:HasTrait(traitID)
	else
		local leaderType = GameInfo.Leaders[player:GetLeaderType()].Type
		local traitType  = GameInfo.Traits[traitID].Type
		for row in GameInfo.Leader_Traits("LeaderType = '" .. leaderType .. "' AND TraitType = '" .. traitType .. "'") do
			return true
		end
	end
	return false
end
------------------------------------------------------------------------------------------------------------------------
-- MOD UTILITIES
------------------------------------------------------------------------------------------------------------------------
--Game_IsCPActive
function Game_IsCPActive()
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if mod.ID == "d1b6328c-ff44-4b0d-aad7-c657f83610cd" then
			return true
		end
	end
	return false
end
local g_IsCPActive = (Game_IsCPActive() and Player.HasStateReligion)
------------------------------------------------------------------------------------------------------------------------
--Game_IsVMCActive
function Game_IsVMCActive()
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if mod.ID == "d1b6328c-ff44-4b0d-aad7-c657f83610cd" then
			return true
		end
	end
	return false
end
local g_IsVMCActive = Game_IsVMCActive()
------------------------------------------------------------------------------------------------------------------------
--g_Tenets_Table
local g_Tenets_Table = {}
local g_Tenets_Count = 1
for row in DB.Query("SELECT * FROM Policies WHERE PolicyBranchType IS NOT NULL AND Level > 0;") do 	
	g_Tenets_Table[g_Tenets_Count] = row
	g_Tenets_Count = g_Tenets_Count + 1
end

--Player_GetNumIdeologicalTenets
function Player_GetNumIdeologicalTenets(player)
	local numTenets = 0
	
	--g_Tenets_Table
	local policiesTable = g_Tenets_Table
	local numPolicies = #policiesTable
	for index = 1, numPolicies do
		local row = policiesTable[index]
		local policyID = row.ID
		if player:HasPolicy(policyID) then
			numTenets = numTenets + 1
		end
	end
 
	return numTenets
end
--=======================================================================================================================
-- GAME DEFINES
--=======================================================================================================================
------------------------------------------------------------------------------------------------------------------------
local defineMaxMajorCivs = GameDefines["MAX_MAJOR_CIVS"]
--=======================================================================================================================
-- UNIQUE FUNCTIONS
--=======================================================================================================================
------------------------------------------------------------------------------------------------------------------------
-- GLOBALS
------------------------------------------------------------------------------------------------------------------------
local buildingPioneersPalaceID = GameInfoTypes["BUILDING_JFD_PIONEERS_PALACE"]

local traitSovietRussiaLeninID = GameInfoTypes["TRAIT_JFD_SOVIET_RUSSIA_LENIN"]

local unitPopularLevyID = GameInfoTypes["UNIT_JFD_POPULAR_LEVY"]
------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
------------------------------------------------------------------------------------------------------------------------
--JFD_SovietRussiaLenin_PlayerDoTurn
local buildingDummyPioneersPalaceD = GameInfoTypes["BUILDING_DUMMY_JFD_PIONEERS_PALACE"]
local function JFD_SovietRussiaLenin_PlayerDoTurn(playerID)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if player:IsBarbarian() then return end
	if player:IsMinorCiv() then return end
	
	--UNIQUE BUILDING
	if player:CountNumBuildings(buildingPioneersPalaceID) == 0 then return end
	for city in player:Cities() do
		city:SetNumRealBuilding(buildingDummyPioneersPalaceD, 0)
		if city:IsHasBuilding(buildingPioneersPalaceID) then
			local numTenets = g_MathFloor(Player_GetNumIdeologicalTenets(player)/2)
			city:SetNumRealBuilding(buildingDummyPioneersPalaceD, numTenets)
		end
	end
end
GameEvents.PlayerDoTurn.Add(JFD_SovietRussiaLenin_PlayerDoTurn)
------------------------------------------------------------------------------------------------------------------------
--JFD_SovietRussiaLenin_CityConstructed
local buildingFactoryID = GameInfoTypes["BUILDING_JFD_SOVIET_RUSSIA_LENIN_BUILDING_FACTORY"]
local buildingForgeID = GameInfoTypes["BUILDING_JFD_SOVIET_RUSSIA_LENIN_BUILDING_FORGE"]
local buildingStoneWorksID = GameInfoTypes["BUILDING_JFD_SOVIET_RUSSIA_LENIN_BUILDING_STONE_WORKS"]
local buildingWindmillID = GameInfoTypes["BUILDING_JFD_SOVIET_RUSSIA_LENIN_BUILDING_WINDMILL"] 
local function JFD_SovietRussiaLenin_CityConstructed(playerID, cityID, buildingID, isGold, isFaith)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if player:IsMinorCiv() then return end
	
	--UNIQUE TRAIT
	if (not HasTrait(player, traitSovietRussiaLeninID)) then return end
	
	if buildingID == buildingFactoryID or
	buildingID == buildingForgeID or 
	buildingID == buildingStoneWorksID or
	buildingID == buildingWindmillID then
		local city = player:GetCityByID(cityID)
		local numCulture = (player:GetTotalJONSCulturePerTurn()*city:GetPopulation())
		player:ChangeJONSCulture(numCulture)
		if (player:IsHuman() and player:IsTurnActive()) then
			local hex = ToHexFromGrid(Vector2(city:GetX(), city:GetY()))
			Events.AddPopupTextEvent(HexToWorld(hex), g_ConvertTextKey("[COLOR_MAGENTA]+{1_Num}[ENDCOLOR] [ICON_CULTURE]", numCulture), true)
		end
	end
end
GameEvents.CityConstructed.Add(JFD_SovietRussiaLenin_CityConstructed)
------------------------------------------------------------------------------------------------------------------------
--JFD_SovietRussiaLenin_DeclareWar
local function JFD_SovietRussiaLenin_DeclareWar(teamID, otherTeamID)
	local playerID = Teams[otherTeamID]:GetLeaderID()
	local player = Players[playerID]
	local playerTeamID = player:GetTeam()
	local playerTeam = Teams[playerTeamID]
	if (not player:IsAlive()) then return end
	if (player:IsBarbarian()) then return end
	if (player:IsMinorCiv()) then return end
	
	local otherPlayerID = Teams[otherTeamID]:GetLeaderID()
	local otherPlayer = Players[otherPlayerID]
	local otherPlayerTeamID = otherPlayer:GetTeam()
	local otherPlayerTeam = Teams[otherPlayerTeamID]
	if (not otherPlayer:IsAlive()) then return end
	if (otherPlayer:IsBarbarian()) then return end
	if (otherPlayer:IsMinorCiv()) then return end
	
	--UNIQUE UNIT
	local playerIdeologyID = player:GetLateGamePolicyTree()
	local otherPlayerIdeologyID = otherPlayer:GetLateGamePolicyTree()
	if Player.GetIdeology then
		playerIdeologyID = player:GetIdeology()
		otherPlayerIdeologyID = otherPlayer:GetIdeology()
	end
	if ((playerIdeologyID > -1 and otherPlayerIdeologyID > -1) and (playerIdeologyID ~= otherPlayerIdeologyID)) then
		if HasTrait(player, traitSovietRussiaLeninID) then 
			if player:CanTrain(unitPopularLevyID, true) then
				if playerTeam:GetAtWarCount(false) ~= 1 then 
					for city in player:Cities() do
						local numProd = (city:GetCurrentProductionDifference()*city:GetPopulation())
						city:ChangeUnitProduction(unitPopularLevyID, numProd)
						if player:IsHuman() and player:IsTurnActive() then
							local hex = ToHexFromGrid(Vector2(city:GetX(), city:GetY()))
							if numProd > 0 then
								Events.AddPopupTextEvent(HexToWorld(hex), g_ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num} [ICON_PRODUCTION][ENDCOLOR]", numProd))
							end
						end
					end
				end
			end
		elseif HasTrait(otherPlayer, traitSovietRussiaLeninID) then 
			if otherPlayer:CanTrain(unitPopularLevyID, true) then
				if otherPlayerTeam:GetAtWarCount(false) ~= 1 then 
					for city in otherPlayer:Cities() do
						local numProd = (city:GetCurrentProductionDifference()*city:GetPopulation())
						city:ChangeUnitProduction(unitPopularLevyID, numProd)
						if otherPlayer:IsHuman() and otherPlayer:IsTurnActive() then
							local hex = ToHexFromGrid(Vector2(city:GetX(), city:GetY()))
							if numProd > 0 then
								Events.AddPopupTextEvent(HexToWorld(hex), g_ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num} [ICON_PRODUCTION][ENDCOLOR]", numProd))
							end
						end
					end
				end
			end
		end
	end
end
GameEvents.DeclareWar.Add(JFD_SovietRussiaLenin_DeclareWar)
--=======================================================================================================================
--=======================================================================================================================