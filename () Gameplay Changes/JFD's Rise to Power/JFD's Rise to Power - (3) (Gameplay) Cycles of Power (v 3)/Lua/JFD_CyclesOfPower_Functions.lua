-- JFD_CyclesOfPower_Functions
-- Author: JFD
-- DateCreated: 4/30/2019 8:35:33 AM
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
include("JFD_CyclesOfPower_Utils.lua")
--==========================================================================================================================
-- GLOBALS
--==========================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
local g_ConvertTextKey  = Locale.ConvertTextKey
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
--=======================================================================================================================
-- CACHED TABLES
--=======================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
--g_JFD_CyclePowers_Table
local g_JFD_CyclePowers_Table = {}
local g_JFD_CyclePowers_Count = 1
for row in DB.Query("SELECT * FROM JFD_CyclePowers WHERE IsAnarchy = 0;") do 	
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
local defineAnarchyTurnsTilFirstWarning = GameDefines["JFD_CYCLES_OF_POWER_ANARCHY_TURNS_TIL_FIRST_WARNING"]
local defineAnarchyTurnsTilSecondWarning = GameDefines["JFD_CYCLES_OF_POWER_ANARCHY_TURNS_TIL_SECOND_WARNING"]

local cyclePowerTheocracyID = GameInfoTypes["CYCLE_POWER_JFD_THEOCRACY"]
local governmentTheocracyID = GameInfoTypes["GOVERNMENT_JFD_THEOCRACY"]
--==========================================================================================================================
-- CORE FUNCTIONS
--==========================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
-- CYCLES OF POWERS
-------------------------------------------------------------------------------------------------------------------------
--JFD_CyclesOfPower_PlayerCityFounded
local function JFD_CyclesOfPower_PlayerCityFounded(playerID, plotX, plotY)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if player:IsBarbarian() then return end
	if player:IsMinorCiv() then return end
	
	local city = g_MapGetPlot(plotX, plotY):GetPlotCity()
	if (not city:IsCapital()) then return end
	
	player:InitiateCycleOfPowerChoice()
end
GameEvents.PlayerCityFounded.Add(JFD_CyclesOfPower_PlayerCityFounded)
-------------------------------------------------------------------------------------------------------------------------
--JFD_CyclesOfPower_PlayerCityFounded
local function JFD_CyclesOfPower_GovernmentEstablished(playerID, governmentID, oldGovernmentID)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if player:IsBarbarian() then return end
	if player:IsMinorCiv() then return end

	if governmentID ~= governmentTheocracyID then return end
	player:BeginCycleOfPower(cyclePowerTheocracyID)
end
LuaEvents.JFD_GovernmentEstablished.Add(JFD_CyclesOfPower_GovernmentEstablished)
-------------------------------------------------------------------------------------------------------------------------
--JFD_CyclesOfPower_LoadScreenClose
local function JFD_CyclesOfPower_LoadScreenClose()
	local activePlayerID = Game.GetActivePlayer()
	local activePlayer = Players[activePlayerID]
	if activePlayer:GetCyclePower() ~= -1 then 
		Events.OpenInfoCorner( InfoCornerID.Civilization );
		LuaEvents.UI_ClearNotification("CycleOfPowerChoice")
	else
		if (not activePlayer:GetCapitalCity()) then return end
		activePlayer:InitiateCycleOfPowerChoice(true)
	end
end
Events.LoadScreenClose.Add(JFD_CyclesOfPower_LoadScreenClose)
----------------------------------------------------------------------------------------------------------------------------
--JFD_CyclesOfPower_NotificationAdded
local notificationCycleOfPowerChoiceType = NotificationTypes["NOTIFICATION_JFD_CYCLE_OF_POWER_CHOICE"]
local function JFD_CyclesOfPower_NotificationAdded(notification, notificationType)
	local activePlayerID = Game.GetActivePlayer()
	local activePlayer = Players[activePlayerID]
	if notificationType == notificationCycleOfPowerChoiceType then
		if activePlayer:GetCyclePower() ~= -1 then
			LuaEvents.UI_ClearNotification("CycleOfPowerChoice")
		end
	end
end
Events.NotificationAdded.Add(JFD_CyclesOfPower_NotificationAdded)
-------------------------------------------------------------------------------------------------------------------------
-- VIRTUE
-------------------------------------------------------------------------------------------------------------------------
--JFD_CyclesOfPower_PlayerDoTurn 
function JFD_CyclesOfPower_PlayerDoTurn(playerID)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if player:IsMinorCiv() then return end
	if player:IsBarbarian() then return end

	if player:IsAnarchy() then return end

	local cyclePowerID = player:GetCyclePower()
	if cyclePowerID == -1 then return end
	local cyclePower = GameInfo.JFD_CyclePowers[cyclePowerID]
	if cyclePower.IsAnarchy then
		player:RestoreCyclePower(cyclePowerID)
	end

	local numVirtueRate = player:GetVirtueRate(cyclePowerID)
	player:ChangeVirtue(numVirtueRate)

	local playerIsHuman = (player:IsHuman() and player:IsTurnActive())
	if playerIsHuman then
		local numTurnsTilAnarchy = player:GetTurnsTilCycleAnarchy(cyclePowerID)
		if numTurnsTilAnarchy == defineAnarchyTurnsTilFirstWarning or numTurnsTilAnarchy == defineAnarchyTurnsTilSecondWarning then
			player:SendNotification("NOTIFICATION_JFD_GOVERNMENT_POWER_ANARCHY", g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_CYCLE_OF_POWER_ANARCHY_WARNING_DESC", numTurnsTilAnarchy), g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_CYCLE_OF_POWER_ANARCHY_WARNING_SHORT_DESC"), false, nil, nil, -1)
			Events.AudioPlay2DSound("AS2D_EVENT_NOTIFICATION_VERY_BAD");	
		end
	end
end
GameEvents.PlayerDoTurn.Add(JFD_CyclesOfPower_PlayerDoTurn)
-------------------------------------------------------------------------------------------------------------------------
--JFD_CyclesOfPower_UnitPrekill
local function JFD_CyclesOfPower_UnitPrekill(unitOwnerID, unitID, unitType, plotX, plotY, isDelay, playerID)
	if playerID == -1 then return end
	if unitOwnerID == -1 then return end
	if unitOwnerID == playerID then return end
	if (not isDelay) then return end
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if player:IsAnarchy() then return end

	local cyclePowerID = player:GetCyclePower()
	if cyclePowerID == -1 then return end
	local cyclePower = GameInfo.JFD_CyclePowers[cyclePowerID]
	local numVirtue = cyclePower.VirtueFromCombat
	if numVirtue > 0 then
		local numVirtueMod = Player_GetVirtueModifier(player, cyclePowerID)
		if numVirtueMod ~= 0 then
			numVirtue = numVirtue + (numVirtue*numVirtueMod)/100
			numVirtue = g_GetRound(numVirtue)
		end
		player:ChangeVirtue(numVirtue)
		local playerIsHuman = (player:IsHuman() and player:IsTurnActive())
		if playerIsHuman then
			local hex = ToHexFromGrid(Vector2(plotX, plotY))
			Events.AddPopupTextEvent(HexToWorld(hex), g_ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR] [ICON_JFD_VIRTUE]", numVirtue), true)
		end
	end
end
--GameEvents.UnitPrekill.Add(JFD_CyclesOfPower_UnitPrekill)
-------------------------------------------------------------------------------------------------------------------------
--JFD_CyclesOfPower_GreatPersonExpended
local function JFD_CyclesOfPower_GreatPersonExpended(playerID, unitID, unitTypeID, plotX, plotY)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if player:IsAnarchy() then return end

	local cyclePowerID = player:GetCyclePower()
	if cyclePowerID == -1 then return end
	local cyclePower = GameInfo.JFD_CyclePowers[cyclePowerID]
	local numVirtue = cyclePower.VirtueFromGreatPerson
	if numVirtue > 0 then
		local numVirtueMod = Player_GetVirtueModifier(player, cyclePowerID)
		if numVirtueMod ~= 0 then
			numVirtue = numVirtue + (numVirtue*numVirtueMod)/100
			numVirtue = g_GetRound(numVirtue)
		end
		player:ChangeVirtue(numVirtue)
		local playerIsHuman = (player:IsHuman() and player:IsTurnActive())
		if playerIsHuman then
			local hex = ToHexFromGrid(Vector2(plotX, plotY))
			Events.AddPopupTextEvent(HexToWorld(hex), g_ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR] [ICON_JFD_VIRTUE]", numVirtue), true)
		end
	end
end
--GameEvents.GreatPersonExpended.Add(JFD_CyclesOfPower_GreatPersonExpended)
-------------------------------------------------------------------------------------------------------------------------
--JFD_CyclesOfPower_SetPopulation
local function JFD_CyclesOfPower_SetPopulation(plotX, plotY, oldPopulation, newPopulation)
	if newPopulation < oldPopulation then return end
	local city = g_MapGetPlot(plotX, plotY):GetPlotCity()
	if (not city) then return end
	local playerID = city:GetOwner()
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if player:IsAnarchy() then return end

	local cyclePowerID = player:GetCyclePower()
	if cyclePowerID == -1 then return end
	local cyclePower = GameInfo.JFD_CyclePowers[cyclePowerID]
	local numVirtue = cyclePower.VirtueFromGrowth
	if numVirtue > 0 then
		local numVirtueMod = Player_GetVirtueModifier(player, cyclePowerID)
		if numVirtueMod ~= 0 then
			numVirtue = numVirtue + (numVirtue*numVirtueMod)/100
			numVirtue = g_GetRound(numVirtue)
		end
		player:ChangeVirtue(numVirtue)
		local playerIsHuman = (player:IsHuman() and player:IsTurnActive())
		if playerIsHuman then
			local hex = ToHexFromGrid(Vector2(plotX, plotY))
			Events.AddPopupTextEvent(HexToWorld(hex), g_ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR] [ICON_JFD_VIRTUE]", numVirtue), true)
		end
	end
end
--GameEvents.SetPopulation.Add(JFD_CyclesOfPower_SetPopulation)
-------------------------------------------------------------------------------------------------------------------------
--JFD_CyclesOfPower_CityTrained
local function JFD_CyclesOfPower_CityTrained(playerID, cityID, unitID, isGold, isFaith)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if player:IsAnarchy() then return end

	local cyclePowerID = player:GetCyclePower()
	if cyclePowerID == -1 then return end
	local cyclePower = GameInfo.JFD_CyclePowers[cyclePowerID]
	
	if isFaith then
		local numVirtue = cyclePower.VirtueFromFaithPurchases
		if numVirtue > 0 then
			local numVirtueMod = Player_GetVirtueModifier(player, cyclePowerID)
			if numVirtueMod ~= 0 then
				numVirtue = numVirtue + (numVirtue*numVirtueMod)/100
				numVirtue = g_GetRound(numVirtue)
			end
			player:ChangeVirtue(numVirtue)
			local playerIsHuman = (player:IsHuman() and player:IsTurnActive())
			if playerIsHuman then
				local city = player:GetCityByID(cityID)
				local hex = ToHexFromGrid(Vector2(city:GetX(), city:GetY()))
				Events.AddPopupTextEvent(HexToWorld(hex), g_ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR] [ICON_JFD_VIRTUE]", numVirtue), true)
			end
		end
	end

	--if isGold then
	--	local numVirtue = cyclePower.VirtueFromGoldPurchases
	--	if numVirtue > 0 then
	--		local numVirtueMod = Player_GetVirtueModifier(player, cyclePowerID)
	--		if numVirtueMod ~= 0 then
	--			numVirtue = numVirtue + (numVirtue*numVirtueMod)/100
	--			numVirtue = g_GetRound(numVirtue)
	--		end
	--		player:ChangeVirtue(numVirtue)
	--		local playerIsHuman = (player:IsHuman() and player:IsTurnActive())
	--		if playerIsHuman then
	--			local city = player:GetCityByID(cityID)
	--			local hex = ToHexFromGrid(Vector2(city:GetX(), city:GetY()))
	--			Events.AddPopupTextEvent(HexToWorld(hex), g_ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR] [ICON_JFD_VIRTUE]", numVirtue), true)
	--		end
	--	end
	--end

	--if (not player:IsHuman()) then
	--	local numVirtue = g_GetRound(cyclePower.VirtueFromGoldPurchases/2)
	--	if numVirtue > 0 then
	--		local numVirtueMod = Player_GetVirtueModifier(player, cyclePowerID)
	--		if numVirtueMod ~= 0 then
	--			numVirtue = numVirtue + (numVirtue*numVirtueMod)/100
	--			numVirtue = g_GetRound(numVirtue)
	--		end
	--		player:ChangeVirtue(numVirtue)
	--	end
	--end
end
GameEvents.CityTrained.Add(JFD_CyclesOfPower_CityTrained)
-------------------------------------------------------------------------------------------------------------------------
--JFD_CyclesOfPower_CityConstructed
local function JFD_CyclesOfPower_CityConstructed(playerID, cityID, buildingID, isGold, isFaith)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if player:IsAnarchy() then return end

	local cyclePowerID = player:GetCyclePower()
	if cyclePowerID == -1 then return end
	local cyclePower = GameInfo.JFD_CyclePowers[cyclePowerID]
	
	if isFaith then
		local numVirtue = cyclePower.VirtueFromFaithPurchases
		if numVirtue > 0 then
			local numVirtueMod = Player_GetVirtueModifier(player, cyclePowerID)
			if numVirtueMod ~= 0 then
				numVirtue = numVirtue + (numVirtue*numVirtueMod)/100
			end
			player:ChangeVirtue(numVirtue)
			local playerIsHuman = (player:IsHuman() and player:IsTurnActive())
			if playerIsHuman then
				local city = player:GetCityByID(cityID)
				local hex = ToHexFromGrid(Vector2(city:GetX(), city:GetY()))
				Events.AddPopupTextEvent(HexToWorld(hex), g_ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR] [ICON_JFD_VIRTUE]", numVirtue), true)
			end
		end
	end
	
	--if isGold then
	--	local numVirtue = cyclePower.VirtueFromGoldPurchases
	--	if numVirtue > 0 then
	--		local numVirtueMod = Player_GetVirtueModifier(player, cyclePowerID)
	--		if numVirtueMod ~= 0 then
	--			numVirtue = numVirtue + (numVirtue*numVirtueMod)/100
	--			numVirtue = g_GetRound(numVirtue)
	--		end
	--		player:ChangeVirtue(numVirtue)
	--		local playerIsHuman = (player:IsHuman() and player:IsTurnActive())
	--		if playerIsHuman then
	--			local city = player:GetCityByID(cityID)
	--			local hex = ToHexFromGrid(Vector2(city:GetX(), city:GetY()))
	--			Events.AddPopupTextEvent(HexToWorld(hex), g_ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR] [ICON_JFD_VIRTUE]", numVirtue), true)
	--		end
	--	end
	--end
	--
	--if (not player:IsHuman()) then
	--	local numVirtue = g_GetRound(cyclePower.VirtueFromGoldPurchases/2)
	--	if numVirtue > 0 then
	--		local numVirtueMod = Player_GetVirtueModifier(player, cyclePowerID)
	--		if numVirtueMod ~= 0 then
	--			numVirtue = numVirtue + (numVirtue*numVirtueMod)/100
	--			numVirtue = g_GetRound(numVirtue)
	--		end
	--		player:ChangeVirtue(numVirtue)
	--	end
	--end

	local numVirtue = cyclePower.VirtueFromBuildingConstructions
	if numVirtue > 0 then
		local numVirtueMod = Player_GetVirtueModifier(player, cyclePowerID)
		if numVirtueMod ~= 0 then
			numVirtue = numVirtue + (numVirtue*numVirtueMod)/100
			numVirtue = g_GetRound(numVirtue)
		end
		player:ChangeVirtue(numVirtue)
		local playerIsHuman = (player:IsHuman() and player:IsTurnActive())
		if playerIsHuman then
			local city = player:GetCityByID(cityID)
			local hex = ToHexFromGrid(Vector2(city:GetX(), city:GetY()))
			Events.AddPopupTextEvent(HexToWorld(hex), g_ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR] [ICON_JFD_VIRTUE]", numVirtue), true)
		end
	end
end
GameEvents.CityConstructed.Add(JFD_CyclesOfPower_CityConstructed)
-------------------------------------------------------------------------------------------------------------------------
--JFD_CyclesOfPower_CityBoughtPlot
local function JFD_CyclesOfPower_CityBoughtPlot(playerID, cityID, plotX, plotY, isGold, isCulture)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if player:IsAnarchy() then return end

	local cyclePowerID = player:GetCyclePower()
	if cyclePowerID == -1 then return end
	local cyclePower = GameInfo.JFD_CyclePowers[cyclePowerID]
	
	if isGold then
		local numVirtue = cyclePower.VirtueFromGoldPurchases
		if numVirtue > 0 then
			local numVirtueMod = Player_GetVirtueModifier(player, cyclePowerID)
			if numVirtueMod ~= 0 then
				numVirtue = numVirtue + (numVirtue*numVirtueMod)/100
				numVirtue = g_GetRound(numVirtue)
			end
			player:ChangeVirtue(numVirtue)
			local playerIsHuman = (player:IsHuman() and player:IsTurnActive())
			if playerIsHuman then
				local hex = ToHexFromGrid(Vector2(plotX, plotY))
				Events.AddPopupTextEvent(HexToWorld(hex), g_ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR] [ICON_JFD_VIRTUE]", numVirtue), true)
			end
		end
	end
end
--GameEvents.CityBoughtPlot.Add(JFD_CyclesOfPower_CityBoughtPlot)
-------------------------------------------------------------------------------------------------------------------------
--JFD_CyclesOfPower_PlayerAdoptPolicy
local function JFD_CyclesOfPower_PlayerAdoptPolicy(playerID, policyID)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if player:IsAnarchy() then return end

	local cyclePowerID = player:GetCyclePower()
	if cyclePowerID == -1 then return end
	local cyclePower = GameInfo.JFD_CyclePowers[cyclePowerID]
	
	local numVirtue = cyclePower.VirtueFromPolicyAdoptions
	if numVirtue > 0 then
		local numVirtueMod = Player_GetVirtueModifier(player, cyclePowerID)
		if numVirtueMod ~= 0 then
			numVirtue = numVirtue + (numVirtue*numVirtueMod)/100
			numVirtue = g_GetRound(numVirtue)
		end
		player:ChangeVirtue(numVirtue)
		local playerIsHuman = (player:IsHuman() and player:IsTurnActive())
		if playerIsHuman then
			local city = player:GetCapitalCity()
			local hex = ToHexFromGrid(Vector2(city:GetX(), city:GetY()))
			Events.AddPopupTextEvent(HexToWorld(hex), g_ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR] [ICON_JFD_VIRTUE]", numVirtue), true)
		end
	end
end
GameEvents.PlayerAdoptPolicy.Add(JFD_CyclesOfPower_PlayerAdoptPolicy)
GameEvents.PlayerAdoptPolicyBranch.Add(JFD_CyclesOfPower_PlayerAdoptPolicy)
-------------------------------------------------------------------------------------------------------------------------
--JFD_CyclesOfPower_TeamTechResearched
local function JFD_CyclesOfPower_TeamTechResearched(teamID, techID)
	local team = Teams[teamID]
	local playerID = team:GetLeaderID()
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if player:IsAnarchy() then return end

	local cyclePowerID = player:GetCyclePower()
	if cyclePowerID == -1 then return end
	local cyclePower = GameInfo.JFD_CyclePowers[cyclePowerID]
	
	local numVirtue = cyclePower.VirtueFromTechUnlocks
	if numVirtue > 0 then
		local numVirtueMod = Player_GetVirtueModifier(player, cyclePowerID)
		if numVirtueMod ~= 0 then
			numVirtue = numVirtue + (numVirtue*numVirtueMod)/100
			numVirtue = g_GetRound(numVirtue)
		end
		player:ChangeVirtue(numVirtue)
		local playerIsHuman = (player:IsHuman() and player:IsTurnActive())
		if playerIsHuman then
			local city = player:GetCapitalCity()
			local hex = ToHexFromGrid(Vector2(city:GetX(), city:GetY()))
			Events.AddPopupTextEvent(HexToWorld(hex), g_ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR] [ICON_JFD_VIRTUE]", numVirtue), true)
		end
	end
end
GameEvents.TeamTechResearched.Add(JFD_CyclesOfPower_TeamTechResearched)
--==========================================================================================================================
--==========================================================================================================================