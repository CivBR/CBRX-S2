local iMaroonDefenceBonus = GameInfoTypes["PROMOTION_PI_JAMAICA_DEFENSEMOD"] -- Defence bonus
local iNoDefensive = GameInfoTypes["PROMOTION_PI_JAMAICA_NODEFENSEMOD"] -- New promotion that removes terrain bonuses
local iMaroon = GameInfoTypes["UNIT_PI_JAMAICA_MAROON_REBEL"] -- Maroon
local iJungle = GameInfoTypes["FEATURE_JUNGLE"]

function C15_Maroon_SetXY(playerID, unitID, iX, iY)
    local pPlayer = Players[playerID]
    local iTeam = pPlayer:GetTeam()
    local pUnit = pPlayer:GetUnitByID(unitID)
    local pPlot = Map.GetPlot(iX, iY)
    if pUnit:GetUnitType() == iMaroon then
        if pPlot:GetFeatureType() == iJungle or pPlot:IsHills() then
            pUnit:SetHasPromotion(iMaroonDefenceBonus, true)
        else
            pUnit:SetHasPromotion(iMaroonDefenceBonus, false)
        end
    else
        local bIsNearMaroon = false
        for i = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do
            --print("Iterating directions")
            local pAdjPlot = Map.PlotDirection(iX, iY, i)
            if pAdjPlot then
                if pAdjPlot:IsUnit() then
                    --print("pAdjPlot has a unit")
                    for j = 0, pAdjPlot:GetNumUnits() - 1 do
                        local pOtherUnit = pAdjPlot:GetUnit(j)
                        --print("pOtherUnit = ", pOtherUnit:GetUnitType())
                        if Teams[Players[pOtherUnit:GetOwner()]:GetTeam()]:IsAtWar(iTeam) and pOtherUnit:GetUnitType() == iMaroon then
                            bIsNearMaroon = true
                            --print("bIsNearMaroon = ", bIsNearMaroon)
                            break
                        end
                    end
                end
            end
            --print("bIsNearMaroon = ", bIsNearMaroon)
            if bIsNearMaroon then break end
            --print("if bIsNearMaroon = true then this should've broken")
        end
        --print("bIsNearMaroon = ", bIsNearMaroon)
        pUnit:SetHasPromotion(iNoDefensive, bIsNearMaroon)
        --print("Does the unit have the promotion?", pUnit:IsHasPromotion(iNoDefensive))
    end
end

GameEvents.UnitSetXY.Add(C15_Maroon_SetXY)