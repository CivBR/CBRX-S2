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
local HexToWorld 			= HexToWorld
local ToHexFromGrid 		= ToHexFromGrid
local Teams 				= Teams
--=======================================================================================================================
-- MOD USE
--=======================================================================================================================
-- MODS
-------------------------------------------------------------------------------------------------------------------------
local g_IsVMCActive = Game.IsVMCActive()
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
if g_IsVMCActive then
	GameEvents.UnitCreated.Add(JFD_Workforces_UnitCreated)
end
------------------------------------------------------------------------------------------------------------------------
--JFD_Workforces_SerialEventUnitCreated
local promotionBuildCharge0ID = GameInfoTypes["PROMOTION_JFD_BUILD_CHARGE_0"]
local function JFD_Workforces_SerialEventUnitCreated(playerID, unitID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if (not unit) then return end
	local unitTypeID = unit:GetUnitType()
	local unitInfo = GameInfo.Units[unitTypeID].Type

	if unit:IsHasPromotion(promotionBuildCharge0ID) then return end
	
	local city = g_MapGetPlot(unit:GetX(), unit:GetY()):GetPlotCity()
	
	local numCharges, numChargesMax = player:GetNumUnitBuildCharges(city, unit, unitTypeID)
	if numChargesMax > 0 then
		for value = 1, numChargesMax do
			local promotionID = GameInfoTypes["PROMOTION_JFD_BUILD_CHARGE_" .. value]
			unit:SetHasPromotion(promotionID, true)
		end
		unit:SetHasPromotion(promotionBuildCharge0ID, true)
	end
end
if (not g_IsVMCActive) then
	Events.SerialEventUnitCreated.Add(JFD_Workforces_SerialEventUnitCreated)
end
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
		if player:IsHuman() then
			local unitAction = build.ActionAnimation
			SetUnitActionCodeDebug(playerID, unitID, unitAction)
			Events.AudioPlay2DSound("AS2D_UNIT_JFD_BUILD")
		end
	else
		if player:IsHuman() then
			local unitAction = build.ActionAnimation
			SetUnitActionCodeDebug(playerID, unitID, 1200)
			Events.AudioPlay2DSound("AS2D_UNIT_JFD_BUILD_FIN")
			Events.GameplayAlertMessage(g_ConvertTextKey("TXT_KEY_MESSAGE_JFD_WORKER_EXPENDED", unit:GetName()))
		end
		unit:Kill(true, -1)
		local hex = ToHexFromGrid(Vector2(plotX, plotY))
		Events.GameplayFX(hex.x, hex.y, -1)
	end
	
	LuaEvents.JFD_BuildChargeExpended(playerID, unitID, plotX, plotY)
end
if g_IsVMCActive then
	GameEvents.PlayerBuilt.Add(JFD_Workforces_PlayerBuilt)
end
------------------------------------------------------------------------------------------------------------------------
--g_Builds_Table
local g_Builds_Table = {}
local g_Builds_Count = 1
for row in DB.Query("SELECT Type, ImprovementType FROM Builds WHERE ImprovementType IS NOT NULL;") do 	
	g_Builds_Table[g_Builds_Count] = row
	g_Builds_Count = g_Builds_Count + 1
end

--JFD_Workforces_BuildFinished
local hasFired = false
local function JFD_Workforces_BuildFinished(playerID, plotX, plotY, improvementID)
	if playerID == -1 then return end
	if improvementID == -1 then return end

	hasFired = (not hasFired)
	if (not hasFired) then return end

	local player = Players[playerID]
	local plot = g_MapGetPlot(plotX, plotY)
	local unit = nil
	local unitTypeID = nil
	local numCharges = 0
	for val = 0,(plot:GetNumUnits() - 1) do
		local thisUnit = plot:GetUnit(val)
		if thisUnit then
			local thisUnitTypeID = thisUnit:GetUnitType()
			local numThisCharges = player:GetNumUnitBuildCharges(nil, thisUnit, thisUnitTypeID)
			if numThisCharges > 0 then
				unit = thisUnit
				unitTypeID = thisUnitTypeID
				numCharges = numThisCharges
				break
			end
		end
	end
		
	if (not unit) then return end
	local unitInfo = GameInfo.Units[unitTypeID]
	local improvementType = GameInfo.Improvements[improvementID].Type
	
	local buildID = nil
	--g_Builds_Table
	local buildsTable = g_Builds_Table
	local numBuilds = #buildsTable
	for index = 1, numBuilds do
		local row = buildsTable[index]
		if row.ImprovementType == improvementType then
			buildID = GameInfoTypes[row.Type]
			break
		end
	end
	if (not buildID) then return end
	local build = GameInfo.Builds[buildID]
	
	local costCharge = player:GetUnitBuildChargeCost(buildID, unitTypeID)
	if costCharge <= 0 then return end
	
	if numCharges > 1 then
		player:ChangeNumUnitBuildCharges(nil, unit, unitTypeID, -costCharge)
		if player:IsHuman() then
			local unitAction = build.ActionAnimation
			SetUnitActionCodeDebug(playerID, unitID, unitAction)
			Events.AudioPlay2DSound("AS2D_UNIT_JFD_BUILD")
		end
	else
		if player:IsHuman() then
			local unitAction = build.ActionAnimation
			SetUnitActionCodeDebug(playerID, unitID, 1200)
			Events.AudioPlay2DSound("AS2D_UNIT_JFD_BUILD_FIN")
			Events.GameplayAlertMessage(g_ConvertTextKey("TXT_KEY_MESSAGE_JFD_WORKER_EXPENDED", unit:GetName()))
			local hex = ToHexFromGrid(Vector2(plotX, plotY))
			Events.GameplayFX(hex.x, hex.y, -1)
		end
		unit:Kill(true, -1)
	end
	
	LuaEvents.JFD_BuildChargeExpended(playerID, unitID, plotX, plotY)
end
if (not g_IsVMCActive) then
	GameEvents.BuildFinished.Add(JFD_Workforces_BuildFinished)
end
--=======================================================================================================================
--=======================================================================================================================
