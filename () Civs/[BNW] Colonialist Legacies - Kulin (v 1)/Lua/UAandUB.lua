function PossumCloakPower(player, owner, unit)
    local pPlayer = Players[player]
    if not Teams[pPlayer:GetTeam()]:IsAtWar(Players[owner]:GetTeam()) then
        unit:SetHasPromotion(GameInfoTypes.PROMOTION_CL_POSSUM_CLOAKS_POWER_POWER, true)
        return true
    else
        return false
    end
end
 
function PossumCloaks(player)
    local pPlayer = Players[player]
    if pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_CL_KULIN then
        for unit in pPlayer:Units() do
            if unit:IsHasPromotion(GameInfoTypes.PROMOTION_CL_POSSUM_CLOAKS_POWER) then
                local possum = false
                local plot = unit:GetPlot()
                local owner = plot:GetOwner()
                if owner ~= player then
                    if owner ~= nil and owner ~= -1 then
                        if PossumCloakPower(player, owner, unit) == true then
                            possum = true
                        end
                    end
                end
                if possum == false then
                    unit:SetHasPromotion(GameInfoTypes.PROMOTION_CL_POSSUM_CLOAKS_POWER_POWER, false)
                end
            end
        end
    end
end
 
function BoostDioriteProduction(player)
    local pPlayer = Players[player]
    if pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_CL_KULIN then
        for city in pPlayer:Cities() do
            local unit = city:GetProductionUnit()
            if unit ~= -1 and GameInfo.Units[unit] == GameInfo.Units['UNIT_CL_DIORITE_AXEMAN'] and city:IsHasResourceLocal(GameInfoTypes.RESOURCE_STONE) then
                city:SetNumRealBuilding(BUILDING_DIORITEBOOST, 1)
            else
                city:SetNumRealBuilding(BUILDING_DIORITEBOOST, 0)
            end
        end
    end
end
 
for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
    local pPlayer = Players[i]
    if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_CL_KULIN then
        print("Kulin lua loaded!")
        GameEvents.PlayerDoTurn.Add(PossumCloaks)
        GameEvents.PlayerDoTurn.Add(BoostDioriteProduction)
        break
    end
end