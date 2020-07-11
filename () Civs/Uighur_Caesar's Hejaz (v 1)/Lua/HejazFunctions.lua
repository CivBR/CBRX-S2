-- Lua Script1
-- Author: pedro
-- DateCreated: 12/10/16 11:27:42 PM
--------------------------------------------------------------
include("PlotIterators")
--------------------------------------------------------------------------------------------------------------------------
-- UTILS
--------------------------------------------------------------------------------------------------------------------------
local civilizationID = GameInfoTypes["CIVILIZATION_UC_HEJAZ"]
local iGenClass = GameInfoTypes["UNITCLASS_GREAT_GENERAL"]
local iForeignOp = GameInfoTypes["UNIT_UC_FOREIGN_OP"]
local iDomainLand = GameInfoTypes["DOMAIN_LAND"]

local iOpPromo1 = GameInfoTypes["PROMOTION_UC_FOREIGN_OP_1"]
local iOpPromo2 = GameInfoTypes["PROMOTION_UC_FOREIGN_OP_2"]
local iOpPromo3 = GameInfoTypes["PROMOTION_UC_FOREIGN_OP_3"]

-- JFD_IsCivilisationActive
----------------------------------------------------------------------------------------------------------------------------
function JFD_IsCivilisationActive(civilisationID)
	for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local slotStatus = PreGame.GetSlotStatus(iSlot)
		if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
			if PreGame.GetCivilization(iSlot) == civilisationID then
				return true
			end
		end
	end

	return false
end

local isHejazActive = JFD_IsCivilisationActive(civilizationID)

function JFD_IsDoFWithRussiaAlexanderI(playerID)
	local player = Players[playerID]
	for otherPlayerID = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		if otherPlayerID ~= playerID then
			local otherPlayer = Players[otherPlayerID]
			if (otherPlayer:IsAlive() and otherPlayer:GetCivilizationType() == civilizationID and otherPlayer:IsDoF(playerID)) then
				return true
			end
		end
	end
	return false
end


function HejazGGBirth(playerID, unitID)
	local player = Players[playerID]
	if player:GetCivilizationType() ~= civilizationID and JFD_IsDoFWithRussiaAlexanderI(playerID) then
		local unit = player:GetUnitByID(unitID)
		local class = unit:GetUnitClassType()
		if class == iGenClass then
			for otherPlayerID = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
				local otherPlayer = Players[otherPlayerID]
				if (otherPlayer:GetCivilizationType() == civilizationID and otherPlayer:IsAlive()) then
					local threshold = otherPlayer:GreatGeneralThreshold()
					otherPlayer:ChangeCombatExperience(threshold * .25)
					for unit in otherPlayer:Units() do
						local newXP = unit:GetExperience() + 10
						unit:SetExperience(newXP)
					end
				end
			end
		end
	end
end
if isHejazActive then
	Events.SerialEventUnitCreated.Add(HejazGGBirth)
end

function IsInRange(iUnit, hT)
	for jUnit, jY in pairs(hT) do
		if Map.PlotDistance(iUnit:GetX(), iUnit:GetY(), jUnit:GetX(), jY) < 3 then
			return true;
		end
	end
	return false;
end

function ForeignOpSupport(iPlayer)
	local isToq = false
	local ToqT = {}
	for iUnit in Players[iPlayer]:Units() do
		if iUnit:GetUnitType() == iForeignOp then
			ToqT[iUnit] = iUnit:GetY();
			isToq = true;
		end
	end
	if isToq then
		for i, v in pairs(Players) do
			if v:IsDoF(iPlayer) then
				for iUnit in v:Units() do
						if iUnit:GetDomainType() == iDomainLand then
							if IsInRange(iUnit, ToqT) then
								iUnit:SetHasPromotion(iOpPromo1, true)
							elseif iUnit:IsHasPromotion(iOpPromo1, true)then
								iUnit:SetHasPromotion(iOpPromo1, false)
						end
					end
				end
			end
		end
	end
end
Events.AIProcessingEndedForPlayer.Add(ForeignOpSupport)

local sharifianID = GameInfoTypes["PROMOTION_UC_SHARIF"]
local sharifianSoloID = GameInfoTypes["PROMOTION_UC_SHARIF_SOLO"]
function SharifianSolo(playerID, unitID, plotX, plotY)
    local player = Players[playerID]
    if (player:IsAlive() and player:GetCivilizationType() == civilizationID) then
		for unit in player:Units() do
			if unit == nil then return end
			if (unit:GetPlot() and (unit:IsHasPromotion(sharifianID))) then
				local plot = unit:GetPlot()
				local adjOther = false
				for loopPlot in PlotAreaSpiralIterator(plot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
					if loopPlot:IsUnit() then
						local team = player:GetTeam();
						local adjUnit = loopPlot:GetUnit()
						if (unit:GetOwner() ~= adjUnit:GetOwner()) then
							local adjPlayer = Players[adjUnit:GetOwner()];
							local adjTeam = adjPlayer:GetTeam();
								if Teams[team]:IsAtWar(adjTeam) then
									adjOther = true
									break
								end
						end
					end

					if adjOther then
						if (unit:IsHasPromotion(sharifianSoloID)) then
							unit:SetHasPromotion(sharifianSoloID, false)
						end
					else
						if not unit:IsHasPromotion(sharifianSoloID) then
							unit:SetHasPromotion(sharifianSoloID, true)
						end
					end
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(SharifianSolo)
--------------------------------------------------------------
-- Globals
--------------------------------------------------------------
include("IconSupport")
include("FLuaVector.lua")

local activePlayerID = Game.GetActivePlayer()
local activePlayer = Players[activePlayerID]
--------------------------------------------------------------
-- Corvina Codex Functions
--------------------------------------------------------------
function Hejaz_ResolveOpPromo(pUnit)
	if unit:IsHasPromotion(iOpPromo3) then
		unit:SetHasPromotion(iOpPromo3, false)
		unit:SetHasPromotion(iOpPromo2, true)
		unit:SetMoves(0)
	elseif unit:IsHasPromotion(iOpPromo2) then
		unit:SetHasPromotion(iOpPromo2, false)
		unit:SetHasPromotion(iOpPromo1, true)
		unit:SetMoves(0)
	elseif unit:IsHasPromotion(iOpPromo1) then
		unit:Kill()
	end
end

-- JFD_GetRandom
function JFD_GetRandom(lower, upper)
    return Game.Rand((upper + 1) - lower, "") + lower
end

local tDebuffs = {
	GameInfoTypes["PROMOTION_UC_HEJAZ_MOVEMENT_DEBUFF"],
	GameInfoTypes["PROMOTION_UC_HEJAZ_STRENGTH_DEBUFF"],
	GameInfoTypes["PROMOTION_UC_HEJAZ_HEAL_DEBUFF"],
	GameInfoTypes["PROMOTION_UC_HEJAZ_RANGE_DEBUFF"],
	GameInfoTypes["PROMOTION_UC_HEJAZ_SIEGE_DEBUFF"]
	}

function Hejaz_HasAnyDebuff(pUnit)
	for k, v in ipairs(tDebuffs) do
		if pUnit:IsHasPromotion(v) then return true end
	end
	return false
end

local iArmor = GameInfoTypes["UNITCOMBAT_ARMOR"]
local iArcher = GameInfoTypes["UNITCOMBAT_ARCHER"]
local iCopter = GameInfoTypes["UNITCOMBAT_HELICOPTER"]
local iGun = GameInfoTypes["UNITCOMBAT_GUN"]
local iMelee = GameInfoTypes["UNITCOMBAT_MELEE"]
local iMounted = GameInfoTypes["UNITCOMBAT_MOUNTED"]
local iRecon = GameInfoTypes["UNITCOMBAT_RECON"]
local iSiege = GameInfoTypes["UNITCOMBAT_SIEGE"]

function ForeignOpDebuff(playerID, unit)
	local player = Players[playerID]
	local team = player:GetTeam();
	local plot = unit:GetPlot()
	for loopPlot in PlotAreaSpiralIterator(plot, 2, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
		if loopPlot:IsUnit() then
			local loopUnit = loopPlot:GetUnit(0)
			local loopPlayer = Players[loopUnit:GetOwner()]
			local loopTeam = loopPlayer:GetTeam();
			if Teams[team]:IsAtWar(loopTeam) then
				if loopUnit:IsCombatUnit() and loopUnit:GetDomainType() == iDomainLand and not Hejaz_HasAnyDebuff(loopUnit) then
					local hex = ToHexFromGrid(Vector2(loopUnit:GetX(), loopUnit:GetY()))
					local type = loopUnit:GetUnitCombatType()
					if (type == iMounted) or (type == iArmor) or (type == iCopter) then
						local chance = JFD_GetRandom(1, 3)
						loopUnit:SetHasPromotion(tDebuffs[chance], true)
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[ENDCOLOR] [ICON_DENOUNCE]"), true)
					elseif (type == iSiege) then
						local chance = JFD_GetRandom(2, 5)
						loopUnit:SetHasPromotion(tDebuffs[chance], true)
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[ENDCOLOR] [ICON_DENOUNCE]"), true)
					elseif (type == iArcher) then
						local chance = JFD_GetRandom(2, 4)
						loopUnit:SetHasPromotion(tDebuffs[chance], true)
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[ENDCOLOR] [ICON_DENOUNCE]"), true)
					elseif (type == iMelee) or (type == iGun) or (type == iRecon) then
						local chance = JFD_GetRandom(2, 3)
						loopUnit:SetHasPromotion(tDebuffs[chance], true)
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[ENDCOLOR] [ICON_DENOUNCE]"), true)
					end
				end
			end
		end
	end
end

function HejazClear(teamID, otherTeamID)
	local team = Teams[teamID]
	local playerID = team:GetLeaderID()
	local player = Players[playerID]
	if (player:GetCivilizationType() == civilizationID) then
		local otherTeam = Teams[otherTeamID]
		local otherPlayerID = otherTeam:GetLeaderID()
		local otherPlayer = Players[otherPlayerID]
		for unit in otherPlayer:Units() do
			if unit:IsCombatUnit() and (unit:GetDomainType() == iDomainLand) and Hejaz_HasAnyDebuff(unit) then
				for k, v in ipairs(tDebuffs) do
					unit:SetHasPromotion(v, false)
				end
			end
		end
	end
end
GameEvents.MakePeace.Add(HejazClear)

function Hejaz_ForeignOpAI(playerID)
	local pPlayer = Players[playerID]
	if pPlayer:HasUnitOfClassType(iGenClass) and (pPlayer:GetCivilizationType() == civilizationID) then
		local pTeam = Teams[pPlayer:GetTeam()]
		if (pTeam:GetAtWarCount(true) < 1) then return end
		for pUnit in pPlayer:Units() do
			if pUnit:GetUnitType() == iForeignOp then
				local pPlot = pUnit:GetPlot()
				local iNearbyFoes = 0
				for loopPlot in PlotRingIterator(pPlot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE) do
					local pAdjUnit = loopPlot:GetUnit(0)
					if pAdjUnit and (pAdjUnit:GetDomainType() == iDomainLand) then
						local iOwningTeam = Players[pUnit:GetOwner()]:GetTeam()
						if pTeam:IsAtWar(iOwningTeam) then
							iNearbyFoes = iNearbyFoes + 1
							if (iNearbyFoes >= 3) then break end
						end
					end
				end
				if (iNearbyFoes > 0) and (iNearbyFoes < 3) then
					-- only do this second iteration if there are 1-2 enemies in first loop
					for loopPlot in PlotRingIterator(pPlot, 2, SECTOR_NORTH, DIRECTION_CLOCKWISE) do
						local pAdjUnit = loopPlot:GetUnit(0)
						if pAdjUnit then
							local iOwningTeam = Players[pUnit:GetOwner()]:GetTeam()
							if pTeam:IsAtWar(iOwningTeam) then
								iNearbyFoes = iNearbyFoes + 1
								if (iNearbyFoes >= 3) then break end
							end
						end
					end
				end
				if (iNearbyFoes >= 3) then
					ForeignOpDebuff(playerID, pUnit)
					Hejaz_ResolveOpPromo(pUnit)
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(Hejaz_ForeignOpAI)