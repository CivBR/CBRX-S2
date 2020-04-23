-- JFD_Civs_Laos_Functions
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
local civilizationLaosID = GameInfoTypes["CIVILIZATION_JFD_LAOS"]
local traitLaosID = GameInfoTypes["TRAIT_JFD_LAOS"]
local buildingThartID = GameInfoTypes["BUILDING_JFD_THART"]
local unitUparajaID = GameInfoTypes["UNIT_JFD_UPARAJA"]
local unitUparajaElephantID = GameInfoTypes["UNIT_JFD_UPARAJA_ELEPHANT"]

local promotionLaosID = GameInfoTypes["PROMOTION_JFD_LAOS"]
-------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-------------------------------------------------------------------------------------------------------------------------
--JFD_Laos_PlayerDoTurn
local buildingLaosGrowthID = GameInfoTypes["BUILDING_JFD_LAOS_GROWTH"]
local function JFD_Laos_PlayerDoTurn(playerID)
	local player = Players[playerID]
	local playerTeamID = player:GetTeam()
	if (not player:IsAlive()) then return end
	if player:IsMinorCiv() then return end
	if player:IsBarbarian() then return end
	
	local playerIsHuman = player:IsHuman()
	local capital = player:GetCapitalCity()
	if (not capital) then return end

	--ONE MILLION ELEPHANTS AND A WHITE PARASOL
	if HasTrait(player, traitLaosID) then
		local religionID = -1
		if g_IsCPActive then
			if religionID <= 0 then
				religionID = player:GetStateReligion()
			end
		end
		if religionID <= 0 then
			religionID = player:GetReligionCreatedByPlayer()
		end
		if religionID <= 0 then
			religionID = capital:GetReligiousMajority()
		end

		local numFollowers = 0
		for city in player:Cities() do
			numFollowers = numFollowers + city:GetNumFollowers(religionID)
		end
		
		capital:SetNumRealBuilding(buildingLaosGrowthID, numFollowers)

		--THART
		for city in player:Cities() do
			if city:IsHasBuilding(buildingThartID) then
				for city2 in player:Cities() do
					if city2:GetOriginalOwner() == city:GetOriginalOwner() then
						if city2:GetResistanceTurns() > 0 then
							city2:ChangeResistanceTurns(-1)
						end
					end
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(JFD_Laos_PlayerDoTurn)
--------------------------------------------------------------------------------------------------------------------------
--g_Religions_Table
local g_Religions_Table = {}
local g_Religions_Count = 1
for row in DB.Query("SELECT ID FROM Religions WHERE Type != 'RELIGION_PANTHEON';") do 	
	g_Religions_Table[g_Religions_Count] = row
	g_Religions_Count = g_Religions_Count + 1
end

--JFD_Laos_CityCaptureComplete
local function JFD_Laos_CityCaptureComplete(oldPlayerID, isCapital, plotX, plotY, newPlayerID)
	local player = Players[newPlayerID]
	local playerTeam = Teams[player:GetTeam()]
	if (not player:IsAlive()) then return end
			
	--ONE MILLION ELEPHANTS AND A WHITE PARASOL
	if (not HasTrait(player, traitLaosID)) then return end
	local otherPlayer = Players[oldPlayerID]
	if (not otherPlayer:IsMinorCiv()) and (not otherPlayer:IsHolyCityAnyReligion()) then return end

	player:InitUnit(unitUparajaID, plotX, plotY)
	
	local city = g_MapGetPlot(plotX, plotY):GetPlotCity()
	
	local religionToConvertID = -1
	if g_IsCPActive then
		if religionToConvertID == -1 then
			religionToConvertID = player:GetStateReligion()
		end
	end
	if religionToConvertID == -1 then
		religionToConvertID = player:GetReligionCreatedByPlayer()
	end
	if religionToConvertID == -1 then
		religionToConvertID = player:GetCapitalCity():GetReligiousMajority()
	end
	
	--g_Religions_Table
	local religionsTable = g_Religions_Table
	local numReligions = #religionsTable
	for index = 1, numReligions do
		local row = religionsTable[index]
		local religionID = row.ID
		city:ConvertPercentFollowers(religionToConvertID, religionID, 100) 
	end
	city:AdoptReligionFully(religionToConvertID) 
	city:ConvertPercentFollowers(religionToConvertID, -1, 100) 
end
GameEvents.CityCaptureComplete.Add(JFD_Laos_CityCaptureComplete)
--------------------------------------------------------------------------------------------------------------------------
--JFD_Laos_SerialEventUnitCreated
local promotionUparajaID = GameInfoTypes["PROMOTION_JFD_UPARAJA"]
local function JFD_Laos_SerialEventUnitCreated(playerID, unitID)
    local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if (not unit) then return end
	
	--UPARAJA
	if unit:GetUnitType() ~= unitUparajaID then return end
    if unit:IsHasPromotion(promotionUparajaID) then return end
	
	local numStrength = (player:GetCurrentEra()+1)*6
	local unitWarElephant1 = player:InitUnit(unitUparajaElephantID, unit:GetX(), unit:GetY())
	unitWarElephant1:JumpToNearestValidPlot()
	unitWarElephant1:SetBaseCombatStrength(numStrength)
	local unitWarElephant2 = player:InitUnit(unitUparajaElephantID, unit:GetX(), unit:GetY())
	unitWarElephant2:JumpToNearestValidPlot()
	unitWarElephant2:SetBaseCombatStrength(numStrength)

	unit:SetHasPromotion(promotionUparajaID, true)
end
if (not g_IsCPActive) then
	Events.SerialEventUnitCreated.Add(JFD_Laos_SerialEventUnitCreated)
end
--------------------------------------------------------------------------------------------------------------------------
--JFD_Laos_UnitCreated
local function JFD_Laos_UnitCreated(playerID, unitID, unitType, plotX, plotY)
    local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if (not unit) then return end
	
	--UPARAJA
	if unit:GetUnitType() ~= unitUparajaID then return end
	
	local numStrength = (player:GetCurrentEra()+1)*6
	local unitWarElephant1 = player:InitUnit(unitUparajaElephantID, unit:GetX(), unit:GetY())
	unitWarElephant1:JumpToNearestValidPlot()
	unitWarElephant1:SetBaseCombatStrength(numStrength)
	local unitWarElephant2 = player:InitUnit(unitUparajaElephantID, unit:GetX(), unit:GetY())
	unitWarElephant2:JumpToNearestValidPlot()
	unitWarElephant2:SetBaseCombatStrength(numStrength)
end
if g_IsCPActive then
	GameEvents.UnitCreated.Add(JFD_Laos_UnitCreated)
end
--=======================================================================================================================
--=======================================================================================================================
