-- JFD_Civs_Punjab_Functions
-- Author: JFD
-- DateCreated: 5/4/2014 12:54:31 AM
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
------------------------------------------------------------------------------------------------------------------------
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
local buildingPhaundriID = GameInfoTypes["BUILDING_JFD_PHAUNDARI"]
local civilizationPunjabID = GameInfoTypes["CIVILIZATION_JFD_PUNJAB"]
local traitPunjabID = GameInfoTypes["TRAIT_JFD_PUNJAB"]
local unitAkaliID = GameInfoTypes["UNIT_JFD_AKALI"]
-------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-------------------------------------------------------------------------------------------------------------------------
--g_Belief_BuildingClassFaithPurchase_Table
local g_Belief_BuildingClassFaithPurchase_Table = {}
local g_Belief_BuildingClassFaithPurchase_Count = 1
for row in DB.Query("SELECT * FROM Belief_BuildingClassFaithPurchase") do 	
	g_Belief_BuildingClassFaithPurchase_Table[g_Belief_BuildingClassFaithPurchase_Count] = row
	g_Belief_BuildingClassFaithPurchase_Count = g_Belief_BuildingClassFaithPurchase_Count + 1
end

--JFD_Punjab_CityCaptureComplete
local buildingMonasteryID = GameInfoTypes["BUILDING_MONASTERY"]
local function JFD_Punjab_CityCaptureComplete(oldPlayerID, isCapital, plotX, plotY, newPlayerID)
	local player = Players[newPlayerID]
	local playerTeam = Teams[player:GetTeam()]
	if (not player:IsAlive()) then return end
			
	--SARKAR-I KHALSA
	if (not HasTrait(player, traitPunjabID)) then return end
	
	local plot = g_MapGetPlot(plotX, plotY)
	local city = plot:GetPlotCity()

	local religionID = player:GetReligionCreatedByPlayer()
	if city:GetNumFollowers(religionID) > 0 then
		local numTurns = city:GetResistanceTurns()
		city:ChangeResistanceTurns(-numTurns)
		city:ChangeWeLoveTheKingDayCounter(numTurns)
	end
	
	if religionID > 0 then
		for _, beliefID in ipairs(Game.GetBeliefsInReligion(religionID)) do
			
			--g_Belief_BuildingClassFaithPurchase_Table
			local beliefsTable = g_Belief_BuildingClassFaithPurchase_Table
			local numBeliefs = #beliefsTable
			for index = 1, numBeliefs do
				local row = beliefsTable[index]
				if GameInfoTypes[row.BeliefType] == beliefID then
					local buildingType = GameInfo.BuildingClasses[row.BuildingClassType].DefaultBuilding
					local buildingID = GameInfoTypes[buildingType]
					if (not city:IsHasBuilding(buildingID)) then
						city:SetNumRealBuilding(buildingID, 1)
					else
						city:SetNumRealBuilding(buildingMonasteryID, 1)
					end
					break
				end
			end
			break

		end	
	else	
		city:SetNumRealBuilding(buildingMonasteryID, 1)
	end
end
GameEvents.CityCaptureComplete.Add(JFD_Punjab_CityCaptureComplete)
-------------------------------------------------------------------------------------------------------------------------
--JFD_Punjab_CityTrained
local function JFD_Punjab_CityTrained(playerID, cityID, unitID)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end

	--AKALI
	local unit = player:GetUnitByID(unitID)
	if unit:GetUnitType() ~= unitAkaliID then return end
	if (not HasTrait(player, traitPunjabID)) then return end

	local city = player:GetCityByID(cityID)
	if city:IsHolyCityAnyReligion() then
		unit:ChangeExperience(unit:ExperienceNeeded())
	end
end
GameEvents.CityTrained.Add(JFD_Punjab_CityTrained)
--=======================================================================================================================
--=======================================================================================================================
