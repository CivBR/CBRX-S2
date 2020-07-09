-- JFD_Workforces_Functions
-- Author: JFD
-- DateCreated: 12/29/2015 9:45:58 PM
--=======================================================================================================================
-- INCLUDES
--=======================================================================================================================
------------------------------------------------------------------------------------------------------------------------
include("JFD_Workforces_Utils.lua")
--=======================================================================================================================
-- GLOBALS
--=======================================================================================================================
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
-------------------------------------------------------------------------------------------------------------------------
--=======================================================================================================================
-- CORE FUNCTIONS
--=======================================================================================================================
------------------------------------------------------------------------------------------------------------------------
-- WORKFORCES
------------------------------------------------------------------------------------------------------------------------
--JFD_Workforces_UnitCreated
local function JFD_Workforces_UnitCreated(playerID, unitID, unitTypeID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	local unitInfo = GameInfo.Units[unitTypeID].Type
	
	local city = g_MapGetPlot(unit:GetX(), unit:GetY()):GetPlotCity()
	
	local numCharges, numChargesMax = player:GetNumUnitBuildCharges(city, unit, unitTypeID)
	if numChargesMax > 0 then
		for value = 1, numChargesMax do
			local promotionID = GameInfoTypes["PROMOTION_JFD_BUILD_CHARGE_" .. value]
			unit:SetHasPromotion(promotionID, true)
		end
	end
end
GameEvents.UnitCreated.Add(JFD_Workforces_UnitCreated)
------------------------------------------------------------------------------------------------------------------------
--JFD_Workforces_UnitUpgraded
local function JFD_Workforces_UnitUpgraded(playerID, unitID, newUnitID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(newUnitID)
	local unitTypeID = unit:GetUnitType()
	
	local numCharges, numChargesMax = player:GetNumUnitBuildCharges(nil, unit, unitTypeID)
	if (numChargesMax > 0 and numCharges <= numChargesMax) then
		local newUnit = player:InitUnit(unitTypeID, unit:GetX(), unit:GetY())
		newUnit:FinishMoves()
		newUnit:Convert(unit)
	end	
end
GameEvents.UnitUpgraded.Add(JFD_Workforces_UnitUpgraded)
------------------------------------------------------------------------------------------------------------------------
--g_Build_JFD_ChargeExcludes_Table
local g_Build_JFD_ChargeExcludes_Table = {}
local g_Build_JFD_ChargeExcludes_Count = 1
for row in DB.Query("SELECT * FROM Build_JFD_ChargeExcludes;") do 	
	g_Build_JFD_ChargeExcludes_Table[g_Build_JFD_ChargeExcludes_Count] = row
	g_Build_JFD_ChargeExcludes_Count = g_Build_JFD_ChargeExcludes_Count + 1
end

--JFD_Workforces_PlayerBuilt
local function JFD_Workforces_PlayerBuilt(playerID, unitID, plotX, plotY, buildID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	local unitTypeID = unit:GetUnitType()
	local unitInfo = GameInfo.Units[unitTypeID]
	local build = GameInfo.Builds[buildID]
	local buildType = build.Type
	
	--Build_JFD_ChargeExcludes
	local buildsTable = g_Build_JFD_ChargeExcludes_Table
	local numBuilds = #buildsTable
	for index = 1, numBuilds do
		local row = buildsTable[index]
		if row.BuildType == buildType then
			local policyReq = row.RequiresPolicy
			if (not policyReq) or (policyReq and player:HasPolicy(GameInfoTypes[policyReq])) then
				return
			end
		end
	end
	
	local costCharge = player:GetUnitBuildChargeCost(buildID, unitTypeID)
	if costCharge <= 0 then return end
	
	local numCharges = player:GetNumUnitBuildCharges(nil, unit, unitTypeID)
	if numCharges > 1 then
		player:ChangeNumUnitBuildCharges(nil, unit, unitTypeID, -costCharge)
	else
		unit:Kill(true, -1)
		
	end
	
	--LuaEvents.JFD_BuildChargeExpended(playerID, unitID, plotX, plotY)
end
GameEvents.PlayerBuilt.Add(JFD_Workforces_PlayerBuilt)
------------------------------------------------------------------------------------------------------------------------
--g_Builds_Table
local g_Builds_Table = {}
local g_Builds_Count = 1
for row in DB.Query("SELECT Type, ImprovementType FROM Builds WHERE ImprovementType IS NOT NULL;") do 	
	g_Builds_Table[g_Builds_Count] = row
	g_Builds_Count = g_Builds_Count + 1
end
--=======================================================================================================================
--=======================================================================================================================
