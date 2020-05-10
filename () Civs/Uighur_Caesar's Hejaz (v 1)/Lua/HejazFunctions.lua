-- Lua Script1
-- Author: pedro
-- DateCreated: 12/10/16 11:27:42 PM
--------------------------------------------------------------
include("PlotIterators")
--------------------------------------------------------------------------------------------------------------------------
-- UTILS
--------------------------------------------------------------------------------------------------------------------------
-- JFD_IsDoFWithRussiaAlexanderI
local civilizationID = GameInfoTypes["CIVILIZATION_UC_HEJAZ"]

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
		if class == GameInfoTypes["UNITCLASS_GREAT_GENERAL"] then
			for otherPlayerID = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
				local otherPlayer = Players[otherPlayerID]
				if (otherPlayer:GetCivilizationType() == civilizationID and otherPlayer:IsAlive()) then
					local threshold = otherPlayer:GreatGeneralThreshold()
					otherPlayer:ChangeCombatExperience(threshold * .25)
					for unit in otherPlayer:Units() do
						local BaseXP = unit:GetExperience()
						local newXP = BaseXP + 10
						unit:SetExperience(newXP)
						if otherPlayer:IsHuman() then
							local bonus = threshold * .25
							local alertmessage = Locale.ConvertTextKey("TXT_KEY_UC_HEJAZ_UA", bonus, player:GetName())
							Events.GameplayAlertMessage(alertmessage)
						end
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
		if iUnit:GetUnitType() == GameInfoTypes.UNIT_UC_FOREIGN_OP then
			ToqT[iUnit] = iUnit:GetY();
			isToq = true;
		end
	end
	if isToq then
		for i, v in pairs(Players) do
			if v:IsDoF(iPlayer) then
				for iUnit in v:Units() do
						if iUnit:GetDomainType() == GameInfoTypes.DOMAIN_LAND then
							if IsInRange(iUnit, ToqT) then
								iUnit:SetHasPromotion(GameInfoTypes.PROMOTION_UC_FOREIGN_OP_1, true)
							elseif iUnit:IsHasPromotion(GameInfoTypes.PROMOTION_UC_FOREIGN_OP_1, true)then
								iUnit:SetHasPromotion(GameInfoTypes.PROMOTION_UC_FOREIGN_OP_1, false)
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
GameEvents.PlayerDoTurn.Add(SharifianSolo)
--------------------------------------------------------------
-- Globals
--------------------------------------------------------------
include("IconSupport")
include("FLuaVector.lua")
local hejazCiv = GameInfoTypes["CIVILIZATION_UC_HEJAZ"]
local activePlayerID = Game.GetActivePlayer()
local activePlayer = Players[activePlayerID]

function JFD_GetRandom(lower, upper)
    return Game.Rand((upper + 1) - lower, "") + lower
end

-- Hides UI for all civilizations at start
function UC_InitHejaz()
	Controls.ForeignOpButton:SetHide(true)
end
UC_InitHejaz()

-- Hides UI when deselecting/selecting another Unit
function UC_HejazUnitSelectionCleared()
	Controls.ForeignOpButton:SetHide(true)
end
Events.UnitSelectionCleared.Add(UC_HejazUnitSelectionCleared)
--------------------------------------------------------------
-- Corvina Codex Functions
--------------------------------------------------------------
function HejazForeignOpPopUp()
	local unit = UI.GetHeadSelectedUnit()
	if unit and unit:GetUnitType() == GameInfoTypes.UNIT_UC_FOREIGN_OP then
		local owner = unit:GetOwner()
		--print('being')
		ForeignOpDebuff(owner, unit)
		if unit:IsHasPromotion(GameInfoTypes.PROMOTION_UC_FOREIGN_OP_3) then
		unit:SetHasPromotion(GameInfoTypes.PROMOTION_UC_FOREIGN_OP_3, false)
		unit:SetHasPromotion(GameInfoTypes.PROMOTION_UC_FOREIGN_OP_2, true)
		unit:SetMoves(0)
		elseif unit:IsHasPromotion(GameInfoTypes.PROMOTION_UC_FOREIGN_OP_2) then
		unit:SetHasPromotion(GameInfoTypes.PROMOTION_UC_FOREIGN_OP_2, false)
		unit:SetHasPromotion(GameInfoTypes.PROMOTION_UC_FOREIGN_OP_1, true)
		unit:SetMoves(0)
		elseif unit:IsHasPromotion(GameInfoTypes.PROMOTION_UC_FOREIGN_OP_1) then
		unit:Kill()
		Controls.ForeignOpButton:SetHide(true)
				end
			end
		end
Controls.ForeignOpButton:RegisterCallback(Mouse.eLClick, HejazForeignOpPopUp)

-- Shows Black Army Button ('Specialize') if Black Army is selected
function HejazForeignOpSelect(playerID, unitID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if unit and unit:GetUnitType() == GameInfoTypes.UNIT_UC_FOREIGN_OP then
		if unit:CanMove() then
			Controls.ForeignOpButton:SetHide(false)
		else
			Controls.ForeignOpButton:SetHide(true)
		end
	else
		Controls.ForeignOpButton:SetHide(true)
	end
end
Events.UnitSelectionChanged.Add(HejazForeignOpSelect)

-- JFD_GetRandom
function JFD_GetRandom(lower, upper)
    return Game.Rand((upper + 1) - lower, "") + lower
end

function ForeignOpDebuff(playerID, unit)
	local player = Players[playerID]
	local team = player:GetTeam();
	local plot = unit:GetPlot()
	for loopPlot in PlotAreaSpiralIterator(plot, 2, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
		--print('loop')
		if loopPlot:IsUnit() then
			--print('unit')
			local loopUnit = loopPlot:GetUnit()
			local loopPlayer = Players[loopUnit:GetOwner()]
			local loopTeam = loopPlayer:GetTeam();
			if Teams[team]:IsAtWar(loopTeam) then
				--print('poop')
				if loopUnit:IsCombatUnit() and loopUnit:GetDomainType() == GameInfoTypes.DOMAIN_LAND and not (loopUnit:IsHasPromotion(GameInfoTypes.PROMOTION_UC_HEJAZ_MOVEMENT_DEBUFF) or loopUnit:IsHasPromotion(GameInfoTypes.PROMOTION_UC_HEJAZ_STRENGTH_DEBUFF) or loopUnit:IsHasPromotion(GameInfoTypes.PROMOTION_UC_HEJAZ_SIEGE_DEBUFF) or loopUnit:IsHasPromotion(GameInfoTypes.PROMOTION_UC_HEJAZ_RANGE_DEBUFF) or loopUnit:IsHasPromotion(GameInfoTypes.PROMOTION_UC_HEJAZ_HEAL_DEBUFF)) then
				--print('check')
				local hex = ToHexFromGrid(Vector2(loopUnit:GetX(), loopUnit:GetY()))
				local type = loopUnit:GetUnitCombatType()
					if type == GameInfoTypes.UNITCOMBAT_MOUNTED or type == GameInfoTypes.UNITCOMBAT_ARMOR or type == GameInfoTypes.UNITCOMBAT_HELICOPTER then
					--print('first set')
					local chance = JFD_GetRandom(1, 3)
						if chance == 1 then
						loopUnit:SetHasPromotion(GameInfoTypes.PROMOTION_UC_HEJAZ_MOVEMENT_DEBUFF, true)
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[ENDCOLOR] [ICON_DENOUNCE]"), true)
						else
						if chance == 2 then
						loopUnit:SetHasPromotion(GameInfoTypes.PROMOTION_UC_HEJAZ_STRENGTH_DEBUFF, true)
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[ENDCOLOR] [ICON_DENOUNCE]"), true)
						else
						if chance == 3 then
						loopUnit:SetHasPromotion(GameInfoTypes.PROMOTION_UC_HEJAZ_HEAL_DEBUFF, true)
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[ENDCOLOR] [ICON_DENOUNCE]"), true)
						end
					end
				end
					else
					if type == GameInfoTypes.UNITCOMBAT_SIEGE then
					--print('second')
						local chance = JFD_GetRandom(1, 4)
						if chance == 1 then
						loopUnit:SetHasPromotion(GameInfoTypes.PROMOTION_UC_HEJAZ_SIEGE_DEBUFF, true)
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[ENDCOLOR] [ICON_DENOUNCE]"), true)
						else
						if chance == 2 then
						loopUnit:SetHasPromotion(GameInfoTypes.PROMOTION_UC_HEJAZ_RANGE_DEBUFF, true)
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[ENDCOLOR] [ICON_DENOUNCE]"), true)
						else
						if chance == 3 then
						loopUnit:SetHasPromotion(GameInfoTypes.PROMOTION_UC_HEJAZ_STRENGTH_DEBUFF, true)
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[ENDCOLOR] [ICON_DENOUNCE]"), true)
						else
						if chance == 4 then
						loopUnit:SetHasPromotion(GameInfoTypes.PROMOTION_UC_HEJAZ_HEAL_DEBUFF, true)
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[ENDCOLOR] [ICON_DENOUNCE]"), true)
						end
					end
				end
			end
					else
					if type == GameInfoTypes.UNITCOMBAT_ARCHER then
					--print('third')
						local chance = JFD_GetRandom(1, 3)
						if chance == 1 then
						loopUnit:SetHasPromotion(GameInfoTypes.PROMOTION_UC_HEJAZ_RANGE_DEBUFF, true)
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[ENDCOLOR] [ICON_DENOUNCE]"), true)
						else
						if chance == 2 then
						loopUnit:SetHasPromotion(GameInfoTypes.PROMOTION_UC_HEJAZ_STRENGTH_DEBUFF, true)
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[ENDCOLOR] [ICON_DENOUNCE]"), true)
						else
						if chance == 3 then
						loopUnit:SetHasPromotion(GameInfoTypes.PROMOTION_UC_HEJAZ_HEAL_DEBUFF, true)
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[ENDCOLOR] [ICON_DENOUNCE]"), true)
						end
					end
				end
					else
					if type == GameInfoTypes.UNITCOMBAT_MELEE or type == GameInfoTypes.UNITCOMBAT_GUN or type == GameInfoTypes.UNITCOMBAT_RECON then
					--print('fourth')
						local chance = JFD_GetRandom(1, 2)
						if chance == 1 then
						--print('1')
						loopUnit:SetHasPromotion(GameInfoTypes.PROMOTION_UC_HEJAZ_HEAL_DEBUFF, true)
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[ENDCOLOR] [ICON_DENOUNCE]"), true)
						elseif chance == 2 then
						--print('2')
						loopUnit:SetHasPromotion(GameInfoTypes.PROMOTION_UC_HEJAZ_STRENGTH_DEBUFF, true)
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[ENDCOLOR] [ICON_DENOUNCE]"), true)
										end
									end
								end
							end
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
			if unit:IsCombatUnit() and unit:GetDomainType() == GameInfoTypes.DOMAIN_LAND and (unit:IsHasPromotion(GameInfoTypes.PROMOTION_UC_HEJAZ_MOVEMENT_DEBUFF) or unit:IsHasPromotion(GameInfoTypes.PROMOTION_UC_HEJAZ_STRENGTH_DEBUFF) or unit:IsHasPromotion(GameInfoTypes.PROMOTION_UC_HEJAZ_SIEGE_DEBUFF) or unit:IsHasPromotion(GameInfoTypes.PROMOTION_UC_HEJAZ_RANGE_DEBUFF) or unit:IsHasPromotion(GameInfoTypes.PROMOTION_UC_HEJAZ_HEAL_DEBUFF)) then
				unit:SetHasPromotion(GameInfoTypes.PROMOTION_UC_HEJAZ_MOVEMENT_DEBUFF, false)
				unit:SetHasPromotion(GameInfoTypes.PROMOTION_UC_HEJAZ_HEAL_DEBUFF, false)
				unit:SetHasPromotion(GameInfoTypes.PROMOTION_UC_HEJAZ_RANGE_DEBUFF, false)
				unit:SetHasPromotion(GameInfoTypes.PROMOTION_UC_HEJAZ_SIEGE_DEBUFF, false)
				unit:SetHasPromotion(GameInfoTypes.PROMOTION_UC_HEJAZ_STRENGTH_DEBUFF, false)
			end
		end
	end
end
GameEvents.MakePeace.Add(HejazClear)