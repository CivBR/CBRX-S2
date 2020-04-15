-- Lua Script1
-- Author: pedro
-- DateCreated: 09/17/16 9:15:35 AM
--------------------------------------------------------------
WARN_NOT_SHARED = false; include( "SaveUtils" ); MY_MOD_NAME = "TeutonFunctions";
include("IconSupport")
include("FLuaVector.lua")

local teutonID = GameInfoTypes["CIVILIZATION_UC_TEUTONS"]

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

local isTeutonCivActive	= JFD_IsCivilisationActive(teutonID)

function TeutonPolicyStart(player)
	for iPlayer=0, GameDefines.MAX_CIV_PLAYERS - 1 do
		local player = Players[iPlayer]
		if player:GetCivilizationType() == GameInfoTypes["CIVILIZATION_UC_TEUTONS"] and player:IsAlive() then
			if not player:HasPolicy(GameInfoTypes["POLICY_UC_TEUTON"]) then
				player:SetNumFreePolicies(1)
				player:SetNumFreePolicies(0)
				player:SetHasPolicy(GameInfoTypes["POLICY_UC_TEUTON"], true)	
			end
		end
	end
end
Events.SequenceGameInitComplete.Add(TeutonPolicyStart)

local tTeutonPolicies = {
	{Base = GameInfoTypes["POLICY_THEOCRACY"], Unique = GameInfoTypes["POLICY_UC_TEUTON_THEOCRACY"]},
	{Base = GameInfoTypes["POLICY_REFORMATION"], Unique = GameInfoTypes["POLICY_UC_TEUTON_FINISH"]},
	{Base = GameInfoTypes["POLICY_NEW_DEAL"], Unique = GameInfoTypes["POLICY_UC_TEUTON_NEW_DEAL"]},
	}

function TeutonPolicies(playerID, policyID)
	local player = Players[playerID]
	if (player:IsAlive() and player:GetCivilizationType() == teutonID) then
		for k, v in ipairs(tTeutonPolicies) do
			if policyID == v.Base then
				player:SetNumFreePolicies(1)
				player:SetNumFreePolicies(0)
				player:SetHasPolicy(v.Unique, true)
			end
		end
	end
end

if isTeutonCivActive then
	GameEvents.PlayerAdoptPolicy.Add(TeutonPolicies)
end

local tOrdensburgBuildings = {}
tOrdensburgBuildings[GameInfoTypes["BUILDING_UC_ORDENSBURG"]] = true
tOrdensburgBuildings[GameInfoTypes["BUILDING_ALHAMBRA"]] = true
tOrdensburgBuildings[GameInfoTypes["BUILDING_HIMEJI_CASTLE"]] = true

local iOrderMil = GameInfoTypes["BUILDING_UC_ORDER_MIL"]
local iMod = ((GameInfo.GameSpeeds[Game.GetGameSpeedType()].BuildPercent)/100)

function OrdensburgBuilt(playerID, cityID, buildingID, isGold, isFaith)
	local player = Players[playerID]
	local city = player:GetCityByID(cityID)
	if player:IsAlive() and player:GetCivilizationType() == teutonID then 
		if tOrdensburgBuildings[buildingID] then
			local religionID = player:GetReligionCreatedByPlayer() or player:GetCapitalCity():GetReligiousMajority()
			if city:GetReligiousMajority() == religionID then
				city:SetNumRealBuilding(iOrderMil, 1)
			else
				local numHeathens = 0
				for row in GameInfo.Religions("ID > '0' AND ID <> '" .. religionID .. "'") do
					if city:GetNumFollowers(row.ID) > 0 then
						numHeathens = numHeathens + city:GetNumFollowers(row.ID)
						player:ChangeFaith(numHeathens * 10)
						city:AdoptReligionFully(religionID)
					end
				end
			end
		end
		if isFaith then
			local cost = city:GetBuildingFaithPurchaseCost(buildingID)
			local engineerBoost = math.ceil(cost * .15 * iMod)
			local previousHonor = load(player, "TeutonHonor")
			if previousHonor == nil then
				previousHonor = 0
			end
			honor = (engineerBoost) + previousHonor
			save(player, "TeutonHonor", honor)
			TeutonHonorCheck(player)
		end
	end
end
if isTeutonCivActive then
	GameEvents.CityConstructed.Add(OrdensburgBuilt)
end

local iKnightClass = GameInfoTypes["UNITCLASS_KNIGHT"]
local iPromo1 = GameInfoTypes["PROMOTION_UC_TEUTON_1"]
local iPromo2 = GameInfoTypes["PROMOTION_UC_TEUTON_2"]

-- CBR edit: added additional if checks to ensure the player is the Teutons and has a Knight-class unit before iterating
function RitterbruderPromotion(playerID)
	local player = Players[playerID]
	if (player:IsAlive() and (player:GetCivilizationType() == teutonID) and player:HasUnitOfClassType(iKnightClass)) then
		for unit in player:Units() do
			if unit:IsHasPromotion(iPromo1) then
				local plot = unit:GetPlot()
				if plot then
					local ownerID = plot:GetOwner()
					if ownerID > - 1 then
						local owner = Players[ownerID]
						local religionID = player:GetReligionCreatedByPlayer() or player:GetCapitalCity():GetReligiousMajority()
						local otherID = owner:GetReligionCreatedByPlayer() or owner:GetCapitalCity():GetReligiousMajority()
						if (ownerID ~= playerID) and (otherID ~= religionID) then
							if not unit:IsHasPromotion(iPromo2) then
								unit:SetHasPromotion(iPromo2, true)
							else
								unit:SetHasPromotion(iPromo2, false)
							end
						elseif unit:IsHasPromotion(iPromo2) then
							unit:SetHasPromotion(iPromo2, false)
						end
					elseif unit:IsHasPromotion(iPromo2) then
						unit:SetHasPromotion(iPromo2, false)
					end
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(RitterbruderPromotion)

function TeutonPurchaseUnit(playerID, cityID, unitID, isGold, isFaith)
	if isFaith then
		local player = Players[playerID]
		if player:IsAlive() and player:GetCivilizationType() == teutonID then 
			local city = player:GetCityByID(cityID)
			local cost = GameInfo.Units[unitID].FaithCost
			local previousHonor = load(player, "TeutonHonor")
			if (not previousHonor) then
				previousHonor = 0
			end
			honor = (math.ceil(cost * .15 * iMod)) + previousHonor
			save(player, "TeutonHonor", honor)
			TeutonHonorCheck(player)		
		end
	end	
end
if isTeutonCivActive then
	GameEvents.CityTrained.Add(TeutonPurchaseUnit)
end

local iOrder = GameInfoTypes["BUILDING_UC_ORDER"]

local tHonorPolicies = {
	{Policy = GameInfoTypes["POLICY_PROFESSIONAL_ARMY"], Cost = 300},
	{Policy = GameInfoTypes["POLICY_MILITARY_CASTE"], Cost = 250},
	{Policy = GameInfoTypes["POLICY_MILITARY_TRADITION"], Cost = 200},
	{Policy = GameInfoTypes["POLICY_DISCIPLINE"], Cost = 150},
	{Policy = GameInfoTypes["POLICY_WARRIOR_CODE"], Cost = 100},
	{Policy = GameInfoTypes["POLICY_BRANCH_HONOR"], Cost = 50},
	}

function TeutonHonorCheck(player)
	local honor = load(player, "TeutonHonor")
	local capital = player:GetCapitalCity()
	if not capital:IsHasBuilding(iOrder) then
		capital:SetNumRealBuilding(iOrder, 1)
	end
	
	for k, v in ipairs(tHonorPolicies) do
		if (honor >= v.Cost) and (not player:HasPolicy(v.Policy) then
			player:SetNumFreePolicies(1)
			player:SetNumFreePolicies(0)
			player:SetHasPolicy(v.Policy, true)
			return
		end
	end
end
	
-- entire city screen bit has been axed