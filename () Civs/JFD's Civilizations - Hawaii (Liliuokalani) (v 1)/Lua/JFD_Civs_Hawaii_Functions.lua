-- JFD_Civs_Hawaii_Functions
-- Author: JFD
-- DateCreated: 5/4/2014 12:54:31 AM
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
------------------------------------------------------------------------------------------------------------------------
include("FLuaVector.lua")
include("PlotIterators.lua")
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

local activePlayerID	= Game.GetActivePlayer()
local activePlayer		= Players[activePlayerID]
local activeTeamID		= activePlayer:GetTeam()
local activeTeam		= Teams[activeTeamID]
--==========================================================================================================================
-- UTILITIES
--==========================================================================================================================
-- CORE UTILITIES
----------------------------------------------------------------------------------------------------------------------------
--Game_IsCPActive
function Game_IsCPActive()
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if mod.ID == "d1b6328c-ff44-4b0d-aad7-c657f83610cd" then
			return true
		end
	end
	return false
end
local g_IsCPActive = Game_IsCPActive()
----------------------------------------------------------------------------------------------------------------------------
--HasTrait
function HasTrait(player, traitID)
	if g_IsCPActive then 
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
--Player_SendWorldEvent
local notificationWorldEventID = NotificationTypes["NOTIFICATION_DIPLOMACY_DECLARATION"]
function Player_SendWorldEvent(player, description, includeHuman)
	print("Sending World Event: ", description)
	local playerTeam = Teams[player:GetTeam()]
	if (not includeHuman) and player:IsHuman() then return end
	if (not playerTeam:IsHasMet(activeTeamID)) then return end
	activePlayer:AddNotification(notificationWorldEventID, description, "[COLOR_POSITIVE_TEXT]World Events[ENDCOLOR]", -1, -1)
end 
-------------------------------------------------------------------------------------------------------------------------
--Player_SendNotification
function Player_SendNotification(player, notificationType, description, descriptionShort, global, data1, data2, unitID, data3, metOnly, includesSerialMessage)
	local notificationID = NotificationTypes[notificationType]
	local teamID = player:GetTeam()
	local data1 = data1 or -1
	local data2 = data2 or -1
	local unitID = unitID or -1
	local data3 = data3 or -1
	if global then
		if (metOnly and activeTeam:IsHasMet(teamID) or (not metOnly)) then
			activePlayer:AddNotification(notificationID, description, descriptionShort, data1, data2, unitID, data3)
			if (includesSerialMessage and description) then Events.GameplayAlertMessage(description) end
		end
	else
		if (not player:IsHuman()) then return end
		if (metOnly and activeTeam:IsHasMet(teamID) or (not metOnly)) then
			activePlayer:AddNotification(notificationID, description, descriptionShort, data1, data2, unitID, data3)
			if (includesSerialMessage and description) then Events.GameplayAlertMessage(description) end
		end
	end
end   
-------------------------------------------------------------------------------------------------------------------------
--g_JFD_GlobalUserSettings_Table
local g_JFD_GlobalUserSettings_Table = {}
for row in DB.Query("SELECT Type, Value FROM JFD_GlobalUserSettings;") do 	
	g_JFD_GlobalUserSettings_Table[row.Type] = row.Value
end

--Game_GetUserSetting
function Game_GetUserSetting(type)
	return g_JFD_GlobalUserSettings_Table[type]
end
--=======================================================================================================================
-- MOD USE
--=======================================================================================================================
-- MODS
-------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------
-- SETTINGS
-------------------------------------------------------------------------------------------------------------------------
--==========================================================================================================================
-- GAME DEFINES
--==========================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
--==========================================================================================================================
-- UNIQUE FUNCTIONS
--==========================================================================================================================
-- GLOBALS
--------------------------------------------------------------------------------------------------------------------------
local civilizationHawaiiID = GameInfoTypes["CIVILIZATION_JFD_HAWAII"]
local traitHawaiiID = GameInfoTypes["TRAIT_JFD_HAWAII"]
local buildingHouseKingsID = GameInfoTypes["BUILDING_JFD_HOUSE_OF_KINGS"]
local unitKaimiloaID = GameInfoTypes["UNIT_JFD_KAIMILOA"]
-------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-------------------------------------------------------------------------------------------------------------------------
--g_Buildings_Table
local g_Buildings_Table = {}
local g_Buildings_Count = 1
for row in DB.Query("SELECT * FROM Buildings WHERE GreatWorkCount > 0 OR SpecialistType IN ('SPECIALIST_ARTIST', 'SPECIALIST_WRITER', 'SPECIALIST_MUSICIAN', 'SPECIALIST_JFD_DIRECTOR')") do 	
	g_Buildings_Table[g_Buildings_Count] = row
	g_Buildings_Count = g_Buildings_Count + 1
end

--JFD_Hawaii_PlayerDoTurn
local buildingHawaiiCultureID = GameInfoTypes["BUILDING_JFD_HAWAII_CULTURE"]
local buildingHawaiiArtistID = GameInfoTypes["BUILDING_JFD_HAWAII_ARTIST"]
local buildingHawaiiDirectorID = GameInfoTypes["BUILDING_JFD_HAWAII_DIRECTOR"]
local buildingHawaiiMusicianID = GameInfoTypes["BUILDING_JFD_HAWAII_MUSICIAN"]
local buildingHawaiiWriterID = GameInfoTypes["BUILDING_JFD_HAWAII_WRITER"]
local buildingHouseKingsGPID = GameInfoTypes["BUILDING_JFD_HOUSE_OF_KINGS_GREAT_PEOPLE"]
local function JFD_Hawaii_PlayerDoTurn(playerID)
	local player = Players[playerID]
	local playerTeamID = player:GetTeam()
	local playerTeam = Teams[player:GetTeam()]
	if (not player:IsAlive()) then return end
	if player:IsMinorCiv() then return end
	if player:IsBarbarian() then return end
	
	local playerIsHuman = player:IsHuman()

	local numPolBranches = player:GetNumPolicyBranchesFinished()
	--ALOHA OE
	if HasTrait(player, traitHawaiiID) then
		for city in player:Cities() do
			local numCGPPs = 0
			local numGPP = 0
			
			local numGPPChange = 0

			--g_Buildings_Table
			local buildingsTable = g_Buildings_Table
			local numBuildings = #buildingsTable
			for index = 1, numBuildings do
				local building = buildingsTable[index]
				local buildingID = building.ID
				if (city:IsHasBuilding(buildingID)) then
					if building.SpecialistType then
						numGPPChange = numGPPChange + (building.GreatPeopleRateChange*city:GetNumRealBuilding(buildingID))*100;
					end

					if building.GreatWorkCount > 0 then
						if GameInfo.BuildingClasses[building.BuildingClass].MaxPlayerInstances == 1 then
							local buildingClassID = GameInfoTypes[building.BuildingClass]
							if city:IsHoldingGreatWork(buildingClassID) then
								numGPP = numGPP + 1
							end
						end
					end
				end
			end
			
			if numGPPChange > 0 then
				local modPlayer = player:GetGreatPeopleRateModifier()
				local modCity = city:GetGreatPeopleRateModifier()
				numGPPChange = (numGPPChange * (100 + (modPlayer+modCity))) / 100
				numCGPPs = g_MathFloor(numGPPChange/100)
			end
			city:SetNumRealBuilding(buildingHawaiiCultureID, numCGPPs)
			city:SetNumRealBuilding(buildingHawaiiArtistID, numGPP)
			if buildingHawaiiDirectorID then
				city:SetNumRealBuilding(buildingHawaiiDirectorID, numGPP)
			end
			city:SetNumRealBuilding(buildingHawaiiMusicianID, numGPP)
			city:SetNumRealBuilding(buildingHawaiiWriterID, numGPP)

			--HOUSE OF KINGS
			if (not city:IsHasBuilding(buildingHouseKingsID)) then
				numPolBranches = 0
			end
			city:SetNumRealBuilding(buildingHouseKingsGPID, numPolBranches)
		end
	end
end
GameEvents.PlayerDoTurn.Add(JFD_Hawaii_PlayerDoTurn)
-------------------------------------------------------------------------------------------------------------------------
--JFD_Hawaii_PlayerAdoptPolicy
local function JFD_Hawaii_PlayerAdoptPolicy(playerID)
	local player = Players[playerID]
	local playerTeamID = player:GetTeam()
	if (not player:IsAlive()) then return end
	if player:IsMinorCiv() then return end
	if player:IsBarbarian() then return end
	
	local numPolBranches = player:GetNumPolicyBranchesFinished()
	if HasTrait(player, traitHawaiiID) then
		for city in player:Cities() do
			--HOUSE OF KINGS
			if (not city:IsHasBuilding(buildingHouseKingsID)) then
				numPolBranches = 0
			end
			city:SetNumRealBuilding(buildingHouseKingsID, numPolBranches)
		end
	end
end
GameEvents.PlayerAdoptPolicy.Add(JFD_Hawaii_PlayerAdoptPolicy)
-------------------------------------------------------------------------------------------------------------------------
--JFD_Hawaii_CityTrained
local yieldCultureID = GameInfoTypes["YIELD_CULTURE"]
local function JFD_Hawaii_CityTrained(playerID, cityID, unitID, isGold, isFaith)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end

	local city = player:GetCityByID(cityID)
	local unit = player:GetUnitByID(unitID)

	--KAIMILOA
	if unit:GetUnitType() == unitKaimiloaID then
		local numCulture = city:GetYieldRate(yieldCultureID)
		unit:ChangeMoves(numCulture*60)
	end
end
GameEvents.CityTrained.Add(JFD_Hawaii_CityTrained)
--=======================================================================================================================
--=======================================================================================================================
