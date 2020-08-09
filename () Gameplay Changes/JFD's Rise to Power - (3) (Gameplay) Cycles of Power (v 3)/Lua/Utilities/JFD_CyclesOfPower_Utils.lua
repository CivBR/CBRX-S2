-- JFD_CyclesOfPower_Utils
-- Author: JFD
-- DateCreated: 4/30/2019 8:35:10 AM
--==========================================================================================================================
-- CACHING
--==========================================================================================================================
------------------------------------------------------------------------------------------------------------------------
-- MapModData.JFD_RTP_CyclesOfPower = MapModData.JFD_RTP_CyclesOfPower or {}
-- JFD_RTP_CyclesOfPower = MapModData.JFD_RTP_CyclesOfPower

-- include("TableSaverLoader016.lua");

-- tableRoot = JFD_RTP_CyclesOfPower
-- tableName = "JFD_RTP_CyclesOfPower_SaveData"

-- include("JFD_RTP_CyclesOfPower_TSLSerializerV3.lua");
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
------------------------------------------------------------------------------------------------------------------------
include("FLuaVector.lua")
include("JFD_RTP_Utils.lua")
include("CBRX_TSL_GlobalDefines.lua")
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
local gameSpeedCulture	= gameSpeed.CulturePercent
local gameSpeedFaith	= gameSpeed.FaithPercent
local gameSpeedGold		= gameSpeed.GoldPercent
local gameSpeedScience	= gameSpeed.ResearchPercent

local handicapID		= Game.GetHandicapType()
local handicap			= GameInfo.HandicapInfos[handicapID]
--=======================================================================================================================
-- CACHED TABLES
--=======================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
--g_JFD_CyclePowers_Table
local g_JFD_CyclePowers_Table = {}
local g_JFD_CyclePowers_Count = 1
for row in DB.Query("SELECT * FROM JFD_CyclePowers;") do 	
	g_JFD_CyclePowers_Table[g_JFD_CyclePowers_Count] = row
	g_JFD_CyclePowers_Count = g_JFD_CyclePowers_Count + 1
end
--==========================================================================================================================
-- ACTIVE MODS
--==========================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
--==========================================================================================================================
-- GAME DEFINES
--==========================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
local defineCycleAnarchyTurns = GameDefines["JFD_CYCLES_OF_POWER_ANARCHY_TURNS"]
local defineVirtueDecayRate = GameDefines["JFD_CYCLES_OF_POWER_VIRTUE_DECAY_RATE"]
local defineVirtueMax = GameDefines["JFD_CYCLES_OF_POWER_VIRTUE_MAX"]
local defineVirtueStart = GameDefines["JFD_CYCLES_OF_POWER_VIRTUE_START"]

local cyclePowerAutocracyID = GameInfoTypes["CYCLE_POWER_JFD_AUTOCRACY"]
local cyclePowerTheocracyID = GameInfoTypes["CYCLE_POWER_JFD_THEOCRACY"]
--==========================================================================================================================
-- CYCLED POWERS UTILS
--==========================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
-- POWER UTILS
-------------------------------------------------------------------------------------------------------------------------
--Player:GetCyclePower
function Player.GetCyclePower(player)
	if (not GameInfo) then return -1 end

	--g_JFD_CyclePowers_Table
	local cyclePowersTable = g_JFD_CyclePowers_Table
	local numCyclePowers = #cyclePowersTable
	for index = 1, numCyclePowers do
		local row = cyclePowersTable[index]
		local policyID = GameInfo.Policies[row.PolicyType].ID
		if player:HasPolicy(policyID) then
			return row.ID
		end
	end

	return -1
end
-------------------------------------------------------------------------------------------------------------------------
--Player:GetPreviousCyclePower
function Player.GetPreviousCyclePower(player)
	return JFD_RTP_CyclesOfPower[player:GetID() .. "_PREVIOUS_CYCLE_POWER"] or -1
end
-------------------------------------------------------------------------------------------------------------------------
--Player:SetPreviousCyclePower
function Player.SetPreviousCyclePower(player, cyclePowerID)
	JFD_RTP_CyclesOfPower[player:GetID() .. "_PREVIOUS_CYCLE_POWER"] = cyclePowerID
end
-------------------------------------------------------------------------------------------------------------------------
--Player:IsHasCycleOfPowerBegun
function Player.IsHasCycleOfPowerBegun(player)
	return (player:GetCyclePower() ~= -1)
end
-------------------------------------------------------------------------------------------------------------------------
--Player:HasTheocracyCycle
function Player.HasTheocracyCycle(player)
	local cyclePowerID = player:GetCyclePower()
	return GameInfo.JFD_CyclePowers[cyclePowerID].IsTheocracy
end
-------------------------------------------------------------------------------------------------------------------------
--Player:SetHasTheocracyCycle
function Player.SetHasTheocracyCycle(player)
	player:BeginCycleOfPower(cyclePowerTheocracyID)
end
-------------------------------------------------------------------------------------------------------------------------
--Player:InitiateCycleOfPowerChoice
function Player.InitiateCycleOfPowerChoice(player, isReloading)
	local playerID = player:GetID()
	local playerIsHuman = (player:IsHuman() and player:IsTurnActive())
	if playerIsHuman then
		if (not isReloading) then
			player:SendNotification("NOTIFICATION_JFD_CYCLE_OF_POWER_CHOICE", g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_CYCLE_OF_POWER_CHOICE_DESC"), g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_CYCLE_OF_POWER_CHOICE_SHORT_DESC"), false, nil, nil, -1)
			Events.AudioPlay2DSound("AS2D_EVENT_NOTIFICATION_VERY_GOOD");	
		end
		LuaEvents.JFD_CyclesPower_UI_BlockEndTurnButton(true, playerID)
	else
		
		local cyclePowerPrefID = cyclePowerAutocracyID
		local cyclePowerPrefVal = 0

		--g_JFD_CyclePowers_Table
		local cyclePowersTable = g_JFD_CyclePowers_Table
		local numCyclePowers = #cyclePowersTable
		for index = 1, numCyclePowers do
			local row = cyclePowersTable[index]
			local flavourType = row.FlavorType
			local flavour = player:GetFlavorValue(flavourType) + (Game.GetRandom(-2,2))
			if (not row.IsAnarchy) and (not row.IsTheocracy) and flavour > cyclePowerPrefVal then
				cyclePowerPrefID = row.ID
				cyclePowerPrefVal = flavour
			end
		end
		player:BeginCycleOfPower(cyclePowerPrefID)
	end
end
-------------------------------------------------------------------------------------------------------------------------
--Player:BeginCycleOfPower
function Player.BeginCycleOfPower(player, cyclePowerID)

	local prevCyclePowerID = player:GetCyclePower()
	if prevCyclePowerID ~= cyclePowerTheocracyID then
		player:SetPreviousCyclePower(prevCyclePowerID)
	end	
	
	local cyclePower = GameInfo.JFD_CyclePowers[cyclePowerID]
	local cyclePowerPolicyID = GameInfoTypes[cyclePower.PolicyType]
	local isTheocracy = cyclePower.IsTheocracy

	if Player.GrantPolicy then
		player:GrantPolicy(cyclePowerPolicyID, true)
	else
		player:SetNumFreePolicies(1)
		player:SetNumFreePolicies(0)
		player:SetHasPolicy(cyclePowerPolicyID, true)
	end

	--g_JFD_CyclePowers_Table
	local cyclePowersTable = g_JFD_CyclePowers_Table
	local numCyclePowers = #cyclePowersTable
	for index = 1, numCyclePowers do
		local row = cyclePowersTable[index]
		local policyID = GameInfoTypes["POLICY_" .. row.Type]
		if policyID ~= cyclePowerPolicyID then
			if player:HasPolicy(policyID) then
				if Player.RevokePolicy then
					player:RevokePolicy(policyID)
				else
					player:SetHasPolicy(policyID, false)
				end
			end
		end
	end

	local currentValStart = player:GetStartingVirtue()
	player:ChangeVirtue(currentValStart)

	local playerIsHuman = (player:IsHuman() and player:IsTurnActive())
	if playerIsHuman then
		LuaEvents.UI_ShowCyclePowerPopup(player:GetID(), cyclePowerID, true, false)
		if isTheocracy then
			player:SendNotification("NOTIFICATION_JFD_CYCLE_OF_POWER", g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_CYCLE_OF_POWER_THEOCRACY_BEGINS_DESC"), g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_CYCLE_OF_POWER_THEOCRACY_BEGINS_SHORT_DESC"), false, nil, nil, -1)
		else
			player:SendNotification("NOTIFICATION_JFD_CYCLE_OF_POWER", g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_CYCLE_OF_POWER_BEGINS_DESC", cyclePower.Description), g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_CYCLE_OF_POWER_BEGINS_SHORT_DESC"), false, nil, nil, -1)
		end
		Events.AudioPlay2DSound("AS2D_EVENT_NOTIFICATION_GOOD");	
		LuaEvents.UI_ClearNotification("CycleOfPowerChoice")
		LuaEvents.JFD_CyclesPower_UI_BlockEndTurnButton(false, playerID)
		Events.OpenInfoCorner( InfoCornerID.Civilization );
	else
		if isTheocracy then
			player:SendWorldEvent(g_ConvertTextKey("TXT_KEY_WORLD_EVENT_JFD_CYCLE_OF_POWER_THEOCRACY_BEGINS_DESC", player:GetCivilizationShortDescriptionKey(), cyclePower.Description), true)
		else
			player:SendWorldEvent(g_ConvertTextKey("TXT_KEY_WORLD_EVENT_JFD_CYCLE_OF_POWER_BEGINS_DESC", player:GetCivilizationShortDescriptionKey(), cyclePower.Description), true)
		end	
	end
	
	LuaEvents.JFD_CycleOfPowerBegins(player:GetID(), cyclePowerID, numAnarchyTurns)
end
-------------------------------------------------------------------------------------------------------------------------
--Player:BeginCycleAnarchy
function Player.BeginCycleAnarchy(player)

	local numAnarchyTurns = defineCycleAnarchyTurns
	player:ChangeAnarchyNumTurns(numAnarchyTurns)
	local cyclePowerID = player:GetCyclePower()
	local cyclePower = GameInfo.JFD_CyclePowers[cyclePowerID]
	player:SuspendCycleOfPower(cyclePowerID)

	local playerIsHuman = (player:IsHuman() and player:IsTurnActive())
	if playerIsHuman then
		Events.AudioPlay2DSound("AS2D_SOUND_JFD_ANARCHY");	
		player:SendNotification("NOTIFICATION_JFD_CYCLE_OF_POWER_ANARCHY", g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_CYCLE_OF_POWER_ANARCHY_BEGINS_DESC"), g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_CYCLE_OF_POWER_ANARCHY_BEGINS_SHORT_DESC"), false, nil, nil, -1)
		local newCyclePowerID = player:GetCyclePower()
		LuaEvents.UI_ShowCyclePowerPopup(player:GetID(), newCyclePowerID, false, true)
	end
	LuaEvents.JFD_CycleAnarchyBegins(player:GetID(), cyclePowerID, numAnarchyTurns)
end
-------------------------------------------------------------------------------------------------------------------------
--Player:RestoreCyclePower
function Player.RestoreCyclePower(player, cyclePowerID)
	local anarchyCyclePower = GameInfo.JFD_CyclePowers[cyclePowerID]
	local anarchyCyclePowerPolicyID = GameInfoTypes["POLICY_" .. anarchyCyclePower.Type]
	local newCyclePower = GameInfo.JFD_CyclePowers[cyclePowerID].NextCyclePower
	if (not newCyclePower) then
		local previousCyclePowerID = player:GetPreviousCyclePower()
		newCyclePower = GameInfo.JFD_CyclePowers[previousCyclePowerID].Type
	end
	local newCyclePowerPolicyID = GameInfoTypes["POLICY_" .. newCyclePower]	
	
	if Player.SwapPolicy then
		player:SwapPolicy(newCyclePowerPolicyID, anarchyCyclePowerPolicyID)
	else
		player:SetHasPolicy(anarchyCyclePowerPolicyID, false)
		player:SetNumFreePolicies(1)
		player:SetNumFreePolicies(0)
		player:SetHasPolicy(newCyclePowerPolicyID, true)
	end

	local currentValStart = player:GetStartingVirtue()
	player:SetVirtue(currentValStart)

	local playerIsHuman = (player:IsHuman() and player:IsTurnActive())
	if playerIsHuman then
		local newCyclePowerID = player:GetCyclePower()
		local newCyclePower = GameInfo.JFD_CyclePowers[newCyclePowerID]
		Events.AudioPlay2DSound("AS2D_SOUND_JFD_CYCLE_OF_POWER");	
		player:SendNotification("NOTIFICATION_JFD_CYCLE_OF_POWER", g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_CYCLE_OF_POWER_NEW_CYCLE_BEGINS_DESC", newCyclePower.Description), g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_CYCLE_OF_POWER_NEW_CYCLE_BEGINS_SHORT_DESC"), false, nil, nil, -1)
		LuaEvents.UI_ShowCyclePowerPopup(player:GetID(), newCyclePowerID, false, false)
		Events.OpenInfoCorner( InfoCornerID.Civilization );
	else
		local newCyclePowerID = player:GetCyclePower()
		local newCyclePower = GameInfo.JFD_CyclePowers[newCyclePowerID]
		player:SendWorldEvent(g_ConvertTextKey("TXT_KEY_WORLD_EVENT_JFD_CYCLE_OF_POWER_NEW_CYCLE_BEGINS_DESC", player:GetCivilizationShortDescriptionKey(), newCyclePower.Description), true)
	end
end
-------------------------------------------------------------------------------------------------------------------------
--Player:SuspendCycleOfPower
function Player.SuspendCycleOfPower(player, cyclePowerID)
	
	local anarchyCyclePower = GameInfo.JFD_CyclePowers[cyclePowerID].AnarchyCyclePower
	local anarchyCyclePowerPolicy = GameInfo.JFD_CyclePowers[anarchyCyclePower].PolicyType
	local anarchyCyclePowerPolicyID = GameInfoTypes[anarchyCyclePowerPolicy]
	local oldCyclePower = GameInfo.JFD_CyclePowers[cyclePowerID]
	local oldCyclePowerPolicy = oldCyclePower.PolicyType
	local oldCyclePowerPolicyID = GameInfoTypes[oldCyclePowerPolicy]

	if cyclePowerID ~= cyclePowerTheocracyID then
		player:SetPreviousCyclePower(cyclePowerID)
	end

	if Player.SwapPolicy then
		player:SwapPolicy(anarchyCyclePowerPolicyID, oldCyclePowerPolicyID)
	else
		player:SetHasPolicy(oldCyclePowerPolicyID, false)
		player:SetNumFreePolicies(1)
		player:SetNumFreePolicies(0)
		player:SetHasPolicy(anarchyCyclePowerPolicyID, true)
	end
end
-------------------------------------------------------------------------------------------------------------------------
--Player:GetTurnsTilCycleAnarchy
function Player.GetTurnsTilCycleAnarchy(player, cyclePowerID)	
	local currentVal = player:GetVirtue()
	local currentValRate = player:GetVirtueRate(cyclePowerID)

	return g_MathFloor((currentVal-0)/currentValRate)*-1
end
-------------------------------------------------------------------------------------------------------------------------
--Player:GetCyclePowerToolTip
function Player.GetCyclePowerToolTip(player, cyclePowerID)
	local cyclePower = GameInfo.JFD_CyclePowers[cyclePowerID]
	if cyclePower.IsAnarchy then
		return g_ConvertTextKey("TXT_KEY_INFO_PANEL_JFD_CYCLE_OF_POWER_TT_ANARCHY", player:GetAnarchyNumTurns())
	else
		if player:HasTheocracyCycle() then
			return g_ConvertTextKey("TXT_KEY_INFO_PANEL_JFD_CYCLE_OF_POWER_TT", cyclePower.Description, "TXT_KEY_CYCLE_POWER_JFD_THEOCRACY_STRATEGY_SHORT")
		else
			return g_ConvertTextKey("TXT_KEY_INFO_PANEL_JFD_CYCLE_OF_POWER_TT", cyclePower.Description, cyclePower.Strategy)
		end
	end
end
-------------------------------------------------------------------------------------------------------------------------
-- VIRTUE UTILS
-------------------------------------------------------------------------------------------------------------------------
--Player:GetVirtue
function Player.GetVirtue(player)	
	local playerID = player:GetID()
	return JFD_RTP_CyclesOfPower[playerID .. "_VIRTUE_BALANCE"] or 0
end
-------------------------------------------------------------------------------------------------------------------------
--Player:ChangeVirtue
function Player.ChangeVirtue(player, changeVal)	
	local currentVal = player:GetVirtue()
	local newVal = g_MathMax(changeVal+currentVal, 0)
	newVal = g_MathMin(newVal, 100)
	newVal = g_GetRound(newVal)

	player:SetVirtue(newVal)
	if newVal == 0 then
		player:BeginCycleAnarchy()
	end
end
-------------------------------------------------------------------------------------------------------------------------
--Player:SetVirtue
function Player.SetVirtue(player, setVal)	
	local playerID = player:GetID()
	JFD_RTP_CyclesOfPower[playerID .. "_VIRTUE_BALANCE"] = setVal
end
-------------------------------------------------------------------------------------------------------------------------
--Player:GetVirtueRate
function Player.GetVirtueRate(player, cyclePowerID)	
	local currentValRate = defineVirtueDecayRate
	--local numHappiness = player:GetHappiness()
	--local numUnhappiness = player:GetUnhappiness()
	--local numExcessUnhappiness = 0
	--if numUnhappiness > numHappiness then
	--	numExcessUnhappiness = (numUnhappiness-numHappiness)
	--end
	local numTotalVirtueRate = 0
	--local numTotalVirtueRate = currentValRate + numExcessUnhappiness

	local capital = player:GetCapitalCity()
	if capital then
		local cyclePower = GameInfo.JFD_CyclePowers[cyclePowerID]

		local currentValRatePerCity = cyclePower.VirtueRatePerXCity
		if currentValRatePerCity > 0 then
			currentValRatePerCity = g_MathFloor(player:GetNumCities()/currentValRatePerCity) * -1
		end

		local currentValRatePerXPopulation = cyclePower.VirtueRatePerXPopulation
		if currentValRatePerXPopulation > 0 then
			currentValRatePerXPopulation = g_MathFloor(player:GetTotalPopulation()/currentValRatePerXPopulation) * -1
		end

		local currentValRatePerXCapitalPopulation = cyclePower.VirtueRatePerXCapitalPopulation
		if currentValRatePerXCapitalPopulation > 0 then
			currentValRatePerXCapitalPopulation = g_MathFloor(capital:GetPopulation()/currentValRatePerXCapitalPopulation) * -1
		end

		local currentValRatePerCityNotFollowing = 0
		if player:HasTheocracyCycle() then
			currentValRatePerCityNotFollowing = GameInfo.JFD_CyclePowers[cyclePowerID].VirtueRatePerXCityNotFollowing
			if currentValRatePerCityNotFollowing > 0 then
				local religionID = player:GetMainReligion()
				if religionID > 0 then
					local numCitiesNotFollowing = 0
					for city in player:Cities() do
						if city:GetReligiousMajority() ~= religionID then
							numCitiesNotFollowing = numCitiesNotFollowing + 1
						end
					end
					if numCitiesNotFollowing > 0 then
						currentValRatePerCityNotFollowing = g_GetRound(numCitiesNotFollowing/currentValRatePerCityNotFollowing) * -1
					end
				else
					currentValRatePerCityNotFollowing = 0
				end
			end
		end
		numTotalVirtueRate = currentValRate + currentValRatePerCity + currentValRatePerCityNotFollowing + currentValRatePerXPopulation + currentValRatePerXCapitalPopulation

		return numTotalVirtueRate, currentValRate, numExcessUnhappiness
	else
		return 0, 0, 0
	end
end
-------------------------------------------------------------------------------------------------------------------------
--Player:GetMaxVirtue
function Player.GetMaxVirtue(player)	
	local currentValMax = defineVirtueMax

	return currentValMax
end
-------------------------------------------------------------------------------------------------------------------------
--Player:GetStartingVirtue
function Player.GetStartingVirtue(player)	
	local currentValStart = defineVirtueStart

	return currentValStart
end
-------------------------------------------------------------------------------------------------------------------------
--Player:GetVirtueToolTip
function Player.GetVirtueToolTip(player, cyclePowerID)
	if GameInfo.JFD_CyclePowers[cyclePowerID].IsAnarchy then
		return
	else
		local numTotalVirtueRate, currentValRate, numExcessUnhappiness = player:GetVirtueRate(cyclePowerID)
		local strTT = "TXT_KEY_INFO_PANEL_JFD_VIRTUE_TT_" .. GameInfo.JFD_CyclePowers[cyclePowerID].Type
		return g_ConvertTextKey(strTT, currentValRate)
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- VIRTUE MODIFIER UTILS
----------------------------------------------------------------------------------------------------------------------------
--Player_GetVirtueModifier
function Player_GetVirtueModifier(player, cyclePowerID)	
	local currentValMod = 0
	local cyclePower = GameInfo.JFD_CyclePowers[cyclePowerID] 
	
	if cyclePower.VirtueFromGoldPurchases then
		currentValMod = (gameSpeedGold-100)
	elseif cyclePower.VirtueFromFaithPurchases then
		currentValMod = (gameSpeedFaith-100)
	elseif cyclePower.VirtueFromPolicyAdoptions then
		currentValMod = (gameSpeedCulture-100)
	elseif cyclePower.VirtueFromTechUnlocks then
		currentValMod = (gameSpeedScience-100)
	end

	if (not player:IsHuman()) then
		currentValMod = (currentValMod*2)
	end
	
	currentValMod = currentValMod + GameInfo.Eras[player:GetCurrentEra()].WarmongerPercent

	return currentValMod
end
--==========================================================================================================================
--=======================================================================================================================
-- CACHING
--=======================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
--OnModLoaded
-- function OnModLoaded() 
	-- local bNewGame = not TableLoad(tableRoot, tableName)

	-- if bNewGame then
		-- print("New Game")
	-- else 
		-- print("Cycles of Power Loaded from Saved Game")
	-- end

	-- TableSave(tableRoot, tableName)
-- end
-- OnModLoaded()
--==========================================================================================================================
--==========================================================================================================================
--==========================================================================================================================