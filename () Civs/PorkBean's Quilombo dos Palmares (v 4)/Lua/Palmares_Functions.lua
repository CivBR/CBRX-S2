--========================================================================================================================
-- PorkBean's Quilombo dos Palmares
-- v4 functions
--========================================================================================================================
include("PlotIterators")

local iPalmaresCiv = GameInfoTypes.CIVILIZATION_PB_PALMARES;
local iCapoPromotion = GameInfoTypes.PROMOTION_PB_DOUBLE_MOVES;
local iEscapePromotion = GameInfoTypes.PROMOTION_PB_ESCAPE_ZOC;
local iMocambo = GameInfoTypes.IMPROVEMENT_PB_MOCAMBO;
local iMocamboPromotion = GameInfoTypes.PROMOTION_PB_MOCAMBO_CAPTURE;

local unitsTable = {}

for row in GameInfo.Units() do
	if (not row.Capture) and (not row.CombatClass) and (not row.Trade) and (row.CivilianAttackPriority) then
		unitsTable[row.ID] = true;
	end
end

--print("unitsTable", #unitsTable);
------------------------------------------------------------------------------------------------------------------------
-- JFD_IsCivilisationActive
------------------------------------------------------------------------------------------------------------------------
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

local isPalmaresCivActive = JFD_IsCivilisationActive(iPalmaresCiv);

------------------------------------------------------------------------------------------------------------------------
-- GetPlayerByCivilization
------------------------------------------------------------------------------------------------------------------------
function GetPlayerByCivilization(civilizationType)
	for _, pPlayer in pairs(Players) do
		if pPlayer:GetCivilizationType() == civilizationType then 
			return pPlayer
		end
	end
end

--========================================================================================================================
-- UNIQUE ABILITY: Angola Janga
--========================================================================================================================
------------------------------------------------------------------------------------------------------------------------
-- CaptureCivilians
------------------------------------------------------------------------------------------------------------------------
function CaptureCivilians(iPlayer, iUnit, iUnitType, iX, iY, bDelay, iByPlayer)

	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	
	local palPlayer = GetPlayerByCivilization(iPalmaresCiv)
    local palID = palPlayer:GetID()

	-- Must have been killed by another Player
	if iPlayer == iByPlayer then return end
	if iByPlayer == -1 then return end
	
	local pPlot = pUnit:GetPlot()
	
	if unitsTable[pUnit:GetUnitType()] then
		if iByPlayer == palID then
			--print("non-worker civilian unit has been killed by palmares")
			local pNewUnitType = pUnit:GetUnitType();
			local pNewUnit = palPlayer:InitUnit(pNewUnitType, iX, iY);
			pNewUnit:SetMoves(0);
		end
	end
end

if isPalmaresCivActive then
	GameEvents.UnitPrekill.Add(CaptureCivilians);
end

------------------------------------------------------------------------------------------------------------------------
-- DamageNearbyUnits
------------------------------------------------------------------------------------------------------------------------
function DamageNearbyUnits(playerID)
    local player = Players[playerID];
    local playerTeam = Teams[player:GetTeam()];
    local palmaresPlayer = GetPlayerByCivilization(iPalmaresCiv)
    local palmaresID = palmaresPlayer:GetID()
    if playerTeam:IsAtWar(palmaresID) then
        --print(player, "is at war with palmares")
        for unit in player:Units() do
            if unit:IsCombatUnit() then
				local adjacentCount = 0;
				local unitPlot = unit:GetPlot()
				if (not unitPlot) then return end
				for adjacentPlot in PlotAreaSweepIterator(unitPlot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
					local adjacentUnit = adjacentPlot:GetUnit()
					if adjacentUnit then
						local adjUnitOwner = adjacentUnit:GetOwner()
						--print("adjUnitOwner", adjUnitOwner, "palmaresID", palmaresID)
						if adjUnitOwner == palmaresID then
							if adjacentUnit:IsCombatUnit() == false then		
								adjacentCount = adjacentCount+1;
							else 
								for i = 0, adjacentPlot:GetNumUnits() do
									local pOtherUnit = adjacentPlot:GetUnit(i)
									if pOtherUnit and pOtherUnit ~= adjacentUnit then
										if pOtherUnit:IsCombatUnit() == false then
											adjacentCount = adjacentCount+1;
										end
									end
								end
							end
						end
					end
				end
				if adjacentCount > 0 then
					--print(unit, "is adjacent to", adjacentCount, "enemy palmares civilians, damaging", adjacentCount*5)
					unit:ChangeDamage(adjacentCount*5)
				end
			end
        end
    end
end

if isPalmaresCivActive then
	GameEvents.PlayerDoTurn.Add(DamageNearbyUnits);
end

--========================================================================================================================
-- UNIQUE UNIT: Capoeirista
--========================================================================================================================
local moveDenominator = GameDefines.MOVE_DENOMINATOR;

function CapoEscapePromotion(iPlayer)
	local pPlayer = Players[iPlayer];
	local playerTeam = Teams[pPlayer:GetTeam()];
	if (not pPlayer:IsAlive()) then return end
	for unit in pPlayer:Units() do
		local adjacentCount = 0;
		if unit:IsHasPromotion(iCapoPromotion) then
			local unitPlot = unit:GetPlot()
			if (not unitPlot) then return end
			for adjacentPlot in PlotAreaSweepIterator(unitPlot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
				local adjacentUnit = adjacentPlot:GetUnit()
				if adjacentUnit then
					if adjacentUnit:IsCombatUnit() then
						if playerTeam:IsAtWar(adjacentUnit:GetOwner()) then
							adjacentCount = adjacentCount+1;
						end
					end
				end
			end
		end
		if adjacentCount >= 2 then
			unit:SetHasPromotion(iEscapePromotion, true);
			unit:ChangeMoves(1*moveDenominator);
		else
			unit:SetHasPromotion(iEscapePromotion, false);
		end
	end
end


GameEvents.PlayerDoTurn.Add(CapoEscapePromotion);
--========================================================================================================================
-- UNIQUE IMPROVEMENT: Mocambo
--========================================================================================================================

function MocamboPromotion (playerID, unitID, unitX, unitY)
	local player = Players[playerID]
	if player:IsAlive() then
		if player:GetCivilizationType() == iPalmaresCiv then
			local unit = player:GetUnitByID(unitID)
			local unitPlot = Map.GetPlot(unitX, unitY);
			if unitPlot then
				if unitPlot:GetImprovementType() == iMocambo then
					unit:SetHasPromotion(iMocamboPromotion,true)
				else
					unit:SetHasPromotion(iMocamboPromotion,false)
				end
			end
		end
	end
end

if isPalmaresCivActive then
	GameEvents.UnitSetXY.Add(MocamboPromotion);
end