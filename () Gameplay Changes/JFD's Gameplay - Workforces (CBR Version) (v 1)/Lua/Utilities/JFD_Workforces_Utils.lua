-- JFD_Workforces_Utils
-- Author: JFD
-- DateCreated: 11/3/2015 8:25:50 PM
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
------------------------------------------------------------------------------------------------------------------------
include("FLuaVector.lua")
--==========================================================================================================================
-- CACHING
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

local gameSpeedID		= Game.GetGameSpeedType()
local gameSpeed			= GameInfo.GameSpeeds[gameSpeedID]

local handicapID		= Game.GetHandicapType()
local handicap			= GameInfo.HandicapInfos[handicapID]
--=======================================================================================================================
-- CACHED TABLES
--=======================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
--g_Building_JFD_BuildCharges_Table
local g_Building_JFD_BuildCharges_Table = {}
local g_Building_JFD_BuildCharges_Count = 1
for row in DB.Query("SELECT * FROM Building_JFD_BuildCharges;") do 	
	g_Building_JFD_BuildCharges_Table[g_Building_JFD_BuildCharges_Count] = row
	g_Building_JFD_BuildCharges_Count = g_Building_JFD_BuildCharges_Count + 1
end

--g_Policy_JFD_BuildCharges_Table
local g_Policy_JFD_BuildCharges_Table = {}
local g_Policy_JFD_BuildCharges_Count = 1
for row in DB.Query("SELECT * FROM Policy_JFD_BuildCharges;") do 	
	g_Policy_JFD_BuildCharges_Table[g_Policy_JFD_BuildCharges_Count] = row
	g_Policy_JFD_BuildCharges_Count = g_Policy_JFD_BuildCharges_Count + 1
end

--g_Trait_JFD_BuildCharges_Table
local g_Trait_JFD_BuildCharges_Table = {}
local g_Trait_JFD_BuildCharges_Count = 1
for row in DB.Query("SELECT * FROM Trait_JFD_BuildCharges;") do 	
	g_Trait_JFD_BuildCharges_Table[g_Trait_JFD_BuildCharges_Count] = row
	g_Trait_JFD_BuildCharges_Count = g_Trait_JFD_BuildCharges_Count + 1
end

--g_UnitPromotions_IsBuildCharge_Table
local g_UnitPromotions_IsBuildCharge_Table = {}
local g_UnitPromotions_IsBuildCharges_Count = 1
for row in DB.Query("SELECT ID FROM UnitPromotions WHERE IsBuildCharge = 1;") do 
	g_UnitPromotions_IsBuildCharge_Table[g_UnitPromotions_IsBuildCharges_Count] = row
	g_UnitPromotions_IsBuildCharges_Count = g_UnitPromotions_IsBuildCharges_Count + 1
end
--==========================================================================================================================
-- GAME DEFINES
--==========================================================================================================================
local defineAIFreeBuildCharges = GameDefines["JFD_WORKFORCES_AI_FREE_BUILD_CHARGES"] or 2
--==========================================================================================================================
-- ACTIVE MODS
--==========================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
local g_IsCPActive = Game.IsCPActive()
--==========================================================================================================================
-- WORKFORCES UTILS
--==========================================================================================================================
------------------------------------------------------------------------------------------------------------------------
-- UNITS
------------------------------------------------------------------------------------------------------------------------
--g_Build_JFD_ChargeCosts_Table
local g_Build_JFD_ChargeCosts_Table = {}
local g_Build_JFD_ChargeCosts_Count = 1
for row in DB.Query("SELECT * FROM Build_JFD_ChargeCosts;") do 
	g_Build_JFD_ChargeCosts_Table[g_Build_JFD_ChargeCosts_Count] = row
	g_Build_JFD_ChargeCosts_Count = g_Build_JFD_ChargeCosts_Count + 1
end

--Player:GetUnitBuildChargeCost
function Player.GetUnitBuildChargeCost(player, buildID, unitID)
	local buildInfo = GameInfo.Builds[buildID]
	local buildType = buildInfo.Type
	local buildCost = buildInfo.ChargeCost
	local unitType = GameInfo.Units[unitID].Type
	
	--g_Build_JFD_ChargeCosts_Table
	local buildsTable = g_Build_JFD_ChargeCosts_Table
	local numBuilds = #buildsTable
	for index = 1, numBuilds do
		local row = buildsTable[index]
		local unitReq = row.UnitType
		if row.BuildType == buildType and (unitReq == unitType or (not unitReq)) then
			local policyReq = row.RequiresPolicy
			if (not policyReq) or (policyReq and player:HasPolicy(GameInfoTypes[policyReq])) then
				buildCost = buildCost + row.ChargeCost
			end
		end
	end
	
	return buildCost
end
------------------------------------------------------------------------------------------------------------------------
--g_Technologies_JFD_MiscEffects_Table
local g_Technologies_JFD_MiscEffects_Table = {}
local g_Technologies_JFD_MiscEffects_Count = 1
for row in DB.Query("SELECT TechType FROM Technologies_JFD_MiscEffects WHERE EffectToolTip = 'TXT_KEY_JFD_1_EXTRA_WORKBOAT_CHARGES';") do 
	g_Technologies_JFD_MiscEffects_Table[g_Technologies_JFD_MiscEffects_Count] = row
	g_Technologies_JFD_MiscEffects_Count = g_Technologies_JFD_MiscEffects_Count + 1
end

--g_UnitPromotions_Table
local g_UnitPromotions_Table = {}
local g_UnitPromotions_Count = 1
for row in DB.Query("SELECT ID FROM UnitPromotions WHERE IsBuildCharge = 1;") do 
	g_UnitPromotions_Table[g_UnitPromotions_Count] = row
	g_UnitPromotions_Count = g_UnitPromotions_Count + 1
end

--g_UnitClass_JFD_BuildCharges_Table
local g_UnitClass_JFD_BuildCharges_Table = {}
local g_UnitClass_JFD_BuildCharges_Count = 1
for row in DB.Query("SELECT * FROM UnitClass_JFD_BuildCharges;") do 
	g_UnitClass_JFD_BuildCharges_Table[g_UnitClass_JFD_BuildCharges_Count] = row
	g_UnitClass_JFD_BuildCharges_Count = g_UnitClass_JFD_BuildCharges_Count + 1
end

--g_Unit_JFD_BuildCharges_Table
local g_Unit_JFD_BuildCharges_Table = {}
local g_Unit_JFD_BuildCharges_Count = 1
for row in DB.Query("SELECT * FROM Unit_JFD_BuildCharges;") do 
	g_Unit_JFD_BuildCharges_Table[g_Unit_JFD_BuildCharges_Count] = row
	g_Unit_JFD_BuildCharges_Count = g_Unit_JFD_BuildCharges_Count + 1
end

--Player:GetNumUnitBuildCharges
local unitClassWorkboatID = GameInfoTypes["UNITCLASS_WORKBOAT"]
function Player.GetNumUnitBuildCharges(player, city, unit, unitTypeID, skipMaxCharges)
	local team = Teams[player:GetTeam()]
	local teamTechs = team:GetTeamTechs()
	local unitInfo = GameInfo.Units[unitTypeID]
	local unitClass = unitInfo.Class
	local unitClassID = GameInfoTypes[unitClass]
	local unitType = unitInfo.Type

	local numCharges = 0
	local numChargesMax = 0
	
	--g_UnitClass_JFD_BuildCharges_Table
	local unitClassesTable = g_UnitClass_JFD_BuildCharges_Table
	local numUnitClasses = #unitClassesTable
	for index = 1, numUnitClasses do
		local row = unitClassesTable[index]
		if row.UnitClassType == unitClass then
			numChargesMax = row.NumCharges
		end
	end
	
	--g_Unit_JFD_BuildCharges_Table
	local unitsTable = g_Unit_JFD_BuildCharges_Table
	local numUnits = #unitsTable
	for index = 1, numUnits do
		local row = unitsTable[index]
		if row.UnitType == unitType then
			numChargesMax = row.NumCharges
		end
	end
	
	if unitClassID == unitClassWorkboatID then
		--g_Technologies_JFD_MiscEffects_Table
		local techsTable = g_Technologies_JFD_MiscEffects_Table
		local numTechs = #techsTable
		for index = 1, numTechs do
			local row = techsTable[index]
			local ID = GameInfoTypes[row.TechType]
			if g_IsCPActive and player:HasTech(ID) then
				numChargesMax = numChargesMax + 1
			elseif teamTechs:HasTech(ID) then
				numChargesMax = numChargesMax + 1
			end
		end
	end
		
	if (not player:IsHuman()) then
		if numChargesMax > 0 then 
			numChargesMax = numChargesMax + defineAIFreeBuildCharges 
		end
	end
	
	if numChargesMax > 0 then
	
		if unit then
			--g_UnitPromotions_IsBuildCharge_Table
			local promotionsTable = g_UnitPromotions_IsBuildCharge_Table
			local numPromotions = #promotionsTable
			for index = 1, numPromotions do
				local row = promotionsTable[index]
				local ID = row.ID
				if unit:IsHasPromotion(ID) then
					numCharges = numCharges + 1
				end
			end
		end
	
		if (not skipMaxCharges) then
			--g_Building_JFD_BuildCharges_Table
			local buildingsTable = g_Building_JFD_BuildCharges_Table
			local numBuildings = #buildingsTable
			for index = 1, numBuildings do
				local row = buildingsTable[index]
				local ID = GameInfoTypes[row.BuildingType]
				local reqUnitClass = row.UnitClassType
				if (reqUnitClass == unitClass or (not reqUnitClass)) then
					if g_IsCPActive then
						if ((player:HasBuilding(ID) and (not row.IsLocal)) or (city and city:IsHasBuilding(ID))) then
							local numBuildings = 1
							if city then
								numBuildings = city:GetNumRealBuilding(ID)
							end
							numChargesMax = numChargesMax + (row.NumCharges*numBuildings)
						end
					else
						if ((player:CountNumBuildings(ID) > 0 and (not row.IsLocal)) or (city and city:IsHasBuilding(ID))) then
							local numBuildings = 1
							if city then
								numBuildings = city:GetNumRealBuilding(ID)
							end
							numChargesMax = numChargesMax + (row.NumCharges*numBuildings)
						end
					end
				end
			end
			--g_Policy_JFD_BuildCharges_Table
			local policiesTable = g_Policy_JFD_BuildCharges_Table
			local numPolicies = #policiesTable
			for index = 1, numPolicies do
				local row = policiesTable[index]
				local ID = GameInfoTypes[row.PolicyType]
				local reqUnitClass = row.UnitClassType
				if (reqUnitClass == unitClass or (not reqUnitClass)) then
					if player:HasPolicy(ID) then
						numChargesMax = numChargesMax + row.NumCharges
					end
				end
			end
			if g_IsCPActive then
				--g_Trait_JFD_BuildCharges_Table
				local traitsTable = g_Trait_JFD_BuildCharges_Table
				local numTraits = #traitsTable
				for index = 1, numTraits do
					local row = traitsTable[index]
					local ID = GameInfoTypes[row.TraitType]
					local reqUnitClass = row.UnitClassType
					if (reqUnitClass == unitClass or (not reqUnitClass)) then
						if player:HasTrait(ID) then
							numChargesMax = numChargesMax + row.NumCharges
						end
					end
				end
			end
		end
	end
		
	return numCharges, numChargesMax
end
------------------------------------------------------------------------------------------------------------------------
--Player:ChangeNumUnitBuildCharges
function Player.ChangeNumUnitBuildCharges(player, city, unit, unitTypeID, numChargesChange)
	local numCharges, numChargesMax = player:GetNumUnitBuildCharges(city, unit, unitTypeID, false)
	player:SetNumUnitBuildCharges(city, unit, unitTypeID, numCharges+numChargesChange, numChargesMax)
end
------------------------------------------------------------------------------------------------------------------------
--Player:SetNumUnitBuildCharges
function Player.SetNumUnitBuildCharges(player, city, unit, unitTypeID, numCharges, numChargesMax)
	local unitInfo = GameInfo.Units[unitTypeID]
	
	--g_UnitPromotions_IsBuildCharge_Table
	local promotionsTable = g_UnitPromotions_IsBuildCharge_Table
	local numPromotions = #promotionsTable
	for index = 1, numPromotions do
		local row = promotionsTable[index]
		local ID = row.ID
		if unit:IsHasPromotion(ID) then
			unit:SetHasPromotion(ID, false)
		end
	end
	
	for value = 1, numCharges do
		local promotionID = GameInfoTypes["PROMOTION_JFD_BUILD_CHARGE_" .. value]
		unit:SetHasPromotion(promotionID, true)
	end

	--if player:IsHuman() and (not unit:IsCombatUnit()) then
	--	local numDamage = g_GetRound((numCharges/numChargesMax)*100)
	--	local numMaxHP = unit:GetMaxHitPoints()
	--	numDamage = (numDamage - numMaxHP)*-1
	--	unit:SetDamage(numDamage)
	--end
end
--=======================================================================================================================
--=======================================================================================================================
