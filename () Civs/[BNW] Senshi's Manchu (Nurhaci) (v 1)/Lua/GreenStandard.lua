function SenshiUnitReset(playerId, unitId, newDamage, oldDamage)
    if newDamage > oldDamage then
        local pPlayer = Players[playerId]
        for pUnit in pPlayer:Units() do
            if pUnit:GetID() == unitId then
                if not pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_SENSHIBANNERDO) then
                    local pPlot = pUnit:GetPlot()
                    for i = 0, 5 do
                        local pAdj = Map.PlotDirection(pPlot:GetX(), pPlot:GetY(), i);
                        if pAdj ~= nil then
                            if pAdj:GetNumUnits() > 0 then
                                for i = 0, pAdj:GetNumUnits() - 1 do
                                    local pSH = pAdj:GetUnit(i)
                                    if pSH:IsHasPromotion(GameInfoTypes.PROMOTION_SENSHIBANNERDO) then
                                        pSH:SetHasPromotion(GameInfoTypes.PROMOTION_SENSHIBANNERDO, false)
                                        pSH:SetHasPromotion(GameInfoTypes.PROMOTION_SENSHIBANNERWATCH, true)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return --this event expects a return, so it perfoms better if you give it one
end
Events.SerialEventUnitSetDamage.Add(SenshiUnitReset)
 
function GetSenshiBanner(pUnit)
    if pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_SENSHI_BANNER_1) then
        return GameInfoTypes.PROMOTION_SENSHI_BANNER_1
    elseif pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_SENSHI_BANNER_2) then
        return GameInfoTypes.PROMOTION_SENSHI_BANNER_2
    elseif pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_SENSHI_BANNER_3) then
        return GameInfoTypes.PROMOTION_SENSHI_BANNER_3
    elseif pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_SENSHI_BANNER_4) then
        return GameInfoTypes.PROMOTION_SENSHI_BANNER_4
    elseif pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_SENSHI_BANNER_5) then
        return GameInfoTypes.PROMOTION_SENSHI_BANNER_5
    elseif pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_SENSHI_BANNER_6) then
        return GameInfoTypes.PROMOTION_SENSHI_BANNER_6
    elseif pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_SENSHI_BANNER_7) then
        return GameInfoTypes.PROMOTION_SENSHI_BANNER_7
    elseif pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_SENSHI_BANNER_8) then
        return GameInfoTypes.PROMOTION_SENSHI_BANNER_8
    end
end
 
function SenshiUnitCapture(playerId) -- all else has failed, we'll do this on the next turn
    local pPlayer = Players[playerId]
    if pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_SENSHIMANCHU then
        for pUnit in pPlayer:Units() do
            if pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_SENSHIBANNERDO) then -- unit killed someone
                pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SENSHIBANNERDO, false)
                pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SENSHIBANNERWATCH, true)
                local pPlot = pUnit:GetPlot()
                local pPromotion = GetSenshiBanner(pUnit)
                if pPromotion ~= nil then
                    local result = Game.Rand(100, "Trying Necromancy")
                    if result < 16 then
                        local newUnit = pPlayer:InitUnit(unit:GetUnitType(), pPlot:GetX(),
                                pPlot:GetY(), unit:GetUnitAIType(), unit:GetFacingDirection())
                        newUnit:SetHasPromotion(pPromotion, true)
                        newUnit:JumpToNearestValidPlot()
                    end
                end
            end
        end
    end
    return --this event expects a return, so it perfoms better if you give it one
end
GameEvents.PlayerDoTurn.Add(SenshiUnitCapture)