-- JFD_SwedenKarlXII_Functions
-- Author: JFD
-- DateCreated: 4/13/2014 4:19:30 PM
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
include("IconSupport")
include("UniqueDiplomacyUtils.lua")

include("JFD_SwedenKarlXII_GlobalDefines.lua");
include("TableSaverLoader016.lua");

tableRoot = JFD_SwedenKarlXII
tableName = "JFD_SwedenKarlXII"

include("JFD_SwedenKarlXII_TSLSerializerV3.lua");

TableLoad(tableRoot, tableName)
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
-- MOD CHECKS
--------------------------------------------------------------------------------------------------------------------------
-- JFD_IsCivilisationActive
function JFD_IsCivilisationActive(civilizationID)
	for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local slotStatus = PreGame.GetSlotStatus(iSlot)
		if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
			if PreGame.GetCivilization(iSlot) == civilizationID then
				return true
			end
		end
	end

	return false
end
--------------------------------------------------------------------------------------------------------------------------
-- USER SETTINGS
--------------------------------------------------------------------------------------------------------------------------
-- JFD_GetUserSetting
function JFD_GetUserSetting(type)
	for row in GameInfo.JFD_GlobalUserSettings("Type = '" .. type .. "'") do
		return row.Value
	end
end
--==========================================================================================================================
-- GLOBALS
--==========================================================================================================================
-- Globals
----------------------------------------------------------------------------------------------------------------------------
local activePlayerID				= Game.GetActivePlayer()
local activePlayer					= Players[activePlayerID]
local civilizationID 				= GameInfoTypes["CIVILIZATION_SWEDEN"]
local isSwedenKarlXIICivActive		= JFD_IsCivilisationActive(civilizationID)
local isSwedenKarlXIIActivePlayer	= activePlayer:GetCivilizationType() == civilizationID
local mathCeil 						= math.ceil
local mathMax						= math.max
local userSettingSwedenUA			= JFD_GetUserSetting("JFD_CIVILIZATIONS_SWEDEN_KARL_XII_UA") == 1
if isSwedenKarlXIICivActive then
	print("King Karl XII is in this game")
end
--==========================================================================================================================
-- DIPLOMACY FUNCTIONS
--==========================================================================================================================
-- DIPLOMACY
----------------------------------------------------------------------------------------------------------------------------
local civilizationSaxonyID 	= GameInfoTypes["CIVILIZATION_JFD_SAXONY"]
local leaderPeterID 		= GameInfoTypes["LEADER_JFD_PETER"]
function JFD_SwedenKarlXIIUniqueResponses()
	for playerID = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
        local player = Players[playerID]
        if (player and player:IsAlive() and player:IsHuman()) then
			-- If the player is Peter the Great
			if (leaderPeterID and player:GetLeaderType() == leaderPeterID) then
				ChangeDiplomacyResponse("TXT_KEY_LEADER_JFD_KARL_XII_FIRSTGREETING%", "TXT_KEY_LEADER_JFD_KARL_XII_PETER_FIRSTGREETING_1")
				break
			-- If the player is Augustus the Strong
			elseif (civilizationSaxonyID and player:GetCivilizationType() == civilizationSaxonyID) then
				ChangeDiplomacyResponse("TXT_KEY_LEADER_JFD_KARL_XII_FIRSTGREETING%", "TXT_KEY_LEADER_JFD_KARL_XII_SAXONY_FIRSTGREETING_1")
				break
			end
		end
	end
end

for playerID = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
	local player = Players[playerID]
	if (player and player:IsAlive() and (not player:IsHuman()) and (player:GetCivilizationType() == civilizationID)) then
		Events.SequenceGameInitComplete.Add(JFD_SwedenKarlXIIUniqueResponses)
		break
	end
end
--==========================================================================================================================
-- UNIQUE FUNCTIONS
--==========================================================================================================================
-- INDELNINGSVERK
----------------------------------------------------------------------------------------------------------------------------
-- JFD_SwedenKarlXII_FoodStorage
local yieldFoodID = YieldTypes["YIELD_FOOD"]
function JFD_SwedenKarlXII_FoodStorage(plotX, plotY, oldPop, newPop)
	if oldPop < newPop then
		local city = Map.GetPlot(plotX, plotY):GetPlotCity()
		local player = Players[city:GetOwner()]
		if (player:IsAlive() and player:GetCivilizationType() == civilizationID) then
			local cityID = city:GetID()
			local currentStorage = FoodStorage[cityID] or 0
			local newStorage = mathCeil((city:GetBaseYieldRate(yieldFoodID)*50)/100)
			if player:IsHuman() then
				FoodStorage[cityID] = currentStorage + newStorage
			else
				city:ChangeProduction(newStorage*2)
			end
		end
	end
end
if (isSwedenKarlXIICivActive and (not userSettingSwedenUA)) then
	GameEvents.SetPopulation.Add(JFD_SwedenKarlXII_FoodStorage)
end

-- JFD_SwedenKarlXII_FoodStorageAlt
function JFD_SwedenKarlXII_FoodStorageAlt(playerID)
	local player = Players[playerID]
    if (player:IsAlive() and player:GetCivilizationType() == civilizationID) then 
		for city in player:Cities() do
			local newStorage = mathCeil((city:GetBaseYieldRate(yieldFoodID)*25)/100)
			if city:GetProductionUnit() > -1 then
				city:ChangeProduction(newStorage)
			end
		end
	end
end
if (isSwedenKarlXIICivActive and (not userSettingSwedenUA)) then
	GameEvents.PlayerDoTurn.Add(JFD_SwedenKarlXII_FoodStorageAlt)
end

-- JFD_SwedenKarlXIIOnCitadelOnTundraConstructed
local improvementCitadelID = GameInfoTypes["IMPROVEMENT_CITADEL"]
local improvementSwedishCitadelID = GameInfoTypes["IMPROVEMENT_JFD_SWEDISH_CITADEL"]
local terrainTundraID = GameInfoTypes["TERRAIN_TUNDRA"]
local terrainSnowID	= GameInfoTypes["TERRAIN_SNOW"]
function JFD_SwedenKarlXII_CitadelFood(playerID, plotX, plotY, improvementID)
    local player = Players[playerID]
    if (player:IsAlive() and player:GetCivilizationType() == civilizationID) then 
		if improvementID == improvementCitadelID then
       		local plot = Map.GetPlot(plotX, plotY)
			local terrainType = plot:GetTerrainType()
			if (terrainType == terrainSnowID or terrainType == terrainTundraID) then
				plot:SetImprovementType(improvementSwedishCitadelID)
			end
		end
    end
end
if isSwedenKarlXIICivActive then
	GameEvents.BuildFinished.Add(JFD_SwedenKarlXII_CitadelFood)
end
----------
-- UI 
----------
local isCityViewOpen = false
-- JFD_SwedenKarlXII_UpdateFoodStorage
function JFD_SwedenKarlXII_UpdateFoodStorage()
	Controls.MilitaryReserveBox:SetHide(true)
	Controls.MilitaryReserveImage:SetHide(true)
	Controls.MilitaryReserveButton:SetDisabled(true)
	Controls.MilitaryReserveButton:LocalizeAndSetToolTip(nil)
	local city = UI.GetHeadSelectedCity()
	if city then
		local cityID = city:GetID()
		local currentStorage = FoodStorage[cityID] or 0
		local currentProduction = city:GetProductionUnit()
		local currentProductionNeeded = city:GetProductionNeeded()
		local currentProductionTurnsLeft = city:GetProductionTurnsLeft()
		local militaryReserveButtonText = Locale.ConvertTextKey("TXT_KEY_JFD_SWEDEN_KARL_XII_FOOD_STORAGE", currentStorage)
		local militaryReserveButtonTT = Locale.ConvertTextKey("TXT_KEY_JFD_SWEDEN_KARL_XII_FOOD_STORAGE_DISABLED_TT")
		local militaryReservePromoteButtonTT = Locale.ConvertTextKey("TXT_KEY_JFD_SWEDEN_KARL_XII_FOOD_STORAGE_DISABLED_TT")
		if (currentProduction == -1 or city:IsResistance() or currentStorage <= 0 or currentProductionTurnsLeft <= 1) then
			Controls.MilitaryReserveButton:SetDisabled(true)
		else
			local currentProductionUnitCombat = GameInfo.Units[currentProduction].Combat
			if currentProductionUnitCombat == 0 then
				Controls.MilitaryReserveButton:SetDisabled(true)
			else
				militaryReserveButtonTT = Locale.ConvertTextKey("TXT_KEY_JFD_SWEDEN_KARL_XII_FOOD_STORAGE_TT_HURRY", currentStorage)
				if currentStorage > currentProductionNeeded then
					militaryReserveButtonTT = Locale.ConvertTextKey("TXT_KEY_JFD_SWEDEN_KARL_XII_FOOD_STORAGE_TT_HURRY", currentProductionNeeded)
				end
				Controls.MilitaryReserveButton:LocalizeAndSetToolTip(militaryReserveButtonTT)
				Controls.MilitaryReserveButton:SetDisabled(false)
			end
		end
		IconHookup(0, 64, "JFD_SWEDEN_KARL_RESERVE_ATLAS", Controls.MilitaryReserveImage)
		Controls.MilitaryReserveBox:SetHide(false)
		Controls.MilitaryReserveImage:SetHide(false)
		Controls.MilitaryReserveButton:SetText(militaryReserveButtonText)
		Controls.MilitaryReserveButton:LocalizeAndSetToolTip(militaryReserveButtonTT)
	end
end

-- JFD_SwedenKarlXII_FoodStorageSpent
local hurryGoldID = GameInfoTypes["HURRY_GOLD"]
function JFD_SwedenKarlXII_FoodStorageSpent()
	local city = UI.GetHeadSelectedCity()
	if city then
		local cityID = city:GetID()
		local currentStorage = FoodStorage[cityID] or 0
		local currentProductionNeeded = city:GetProductionNeeded()
		local productionBoost = currentStorage
		if currentStorage > currentProductionNeeded then
			productionBoost = currentProductionNeeded
		end
		local newStorage = currentStorage-productionBoost
		FoodStorage[cityID] = mathMax(0, newStorage)
		city:ChangeProduction(productionBoost)
		Events.AudioPlay2DSound("AS2D_SELECT_MUSKETMAN")
		JFD_OnEnterCityScreen()
	end
end
if (isSwedenKarlXIICivActive and isSwedenKarlXIIActivePlayer and (not userSettingSwedenUA)) then
	Controls.MilitaryReserveButton:RegisterCallback(Mouse.eLClick, JFD_SwedenKarlXII_FoodStorageSpent)
end

-- JFD_OnEnterCityScreen
function JFD_OnEnterCityScreen()
	isCityViewOpen = true
	JFD_SwedenKarlXII_UpdateFoodStorage()
end

-- JFD_OnExitCityScreen
function JFD_OnExitCityScreen()
	isCityViewOpen = false
	JFD_SwedenKarlXII_UpdateFoodStorage()
end

-- JFD_OnNextCityScreen
function JFD_OnNextCityScreen()
	if isCityViewOpen then
		JFD_SwedenKarlXII_UpdateFoodStorage()
	end
end
if (isSwedenKarlXIICivActive and isSwedenKarlXIIActivePlayer and (not userSettingSwedenUA)) then
	Events.SerialEventEnterCityScreen.Add(JFD_OnEnterCityScreen)
	Events.SerialEventExitCityScreen.Add(JFD_OnExitCityScreen)
	Events.SerialEventCityScreenDirty.Add(JFD_OnNextCityScreen)
	Events.SerialEventCityInfoDirty.Add(JFD_OnEnterCityScreen)
end
--==========================================================================================================================
-- UB FUNCTIONS
--==========================================================================================================================
-- ALOTTMENT HOUSE
----------------------------------------------------------------------------------------------------------------------------
-- JFD_SwedenKarlXII_WarAcademy
local buildingWarAcademyID = GameInfoTypes["BUILDING_JFD_WAR_ACADEMY"]
local domainLandID = GameInfoTypes["DOMAIN_LAND"]
function JFD_SwedenKarlXII_WarAcademy(playerID, cityID, unitID, isGold, isFaith)
	local player = Players[playerID]
    if ((not isGold) and (not isFaith)) then
		if (player:IsAlive() and player:GetCivilizationType() == civilizationID) then 
			local unit = player:GetUnitByID(unitID)
			if (unit:GetDomainType() == domainLandID and unit:IsCombatUnit()) then
				local city = player:GetCityByID(cityID)
				if city:IsHasBuilding(buildingWarAcademyID) then
					player:ChangeCombatExperience(20)
				end
			end
		end
	end
end
if isSwedenKarlXIICivActive then
	GameEvents.CityTrained.Add(JFD_SwedenKarlXII_WarAcademy)
end
--=======================================================================================================================
-- TSL UTILITIES	
--=======================================================================================================================
-- OnModLoaded
function OnModLoaded() 
	local bNewGame = not TableLoad(tableRoot, tableName)
	TableSave(tableRoot, tableName)
end
OnModLoaded()
--==========================================================================================================================
--==========================================================================================================================