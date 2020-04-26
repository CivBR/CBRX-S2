-- Lua Script1
-- Author: Pi
-- DateCreated: 1/24/2017 7:21:55 PM
--------------------------------------------------------------
local iCivilization = GameInfoTypes["CIVILIZATION_PI_JAMAICA"]
local iDummy = GameInfoTypes["BUILDING_PI_BSL_DUMMY"] -- Yield 1 GM point, and 1 Culture
local iMod = 5 -- Points given = iMod * num resources around city
local iSea = DomainTypes.DOMAIN_SEA

function C15_BlackStar(playerID)
    local pPlayer = Players[playerID]
    if pPlayer:IsAlive() and pPlayer:GetCivilizationType() == iCivilization then
        local tCities = {}
        for k, v in ipairs(pPlayer:GetTradeRoutes()) do
            if (Players[v.ToID]:IsMinorCiv()) and v.Domain == iSea then
                local pCity = v.FromCity
                if tCities[pCity] == nil then tCities[pCity] = 0 end
                for i = 0, pCity:GetNumCityPlots() - 1 do
                    if (pPlot) and (pPlot:GetResourceType() ~= -1) then
                        if pPlot:GetWorkingCity() == pCity then
                            tCities[pCity] = tCities[pCity] + 1
                        end
                    end
                end
            end
        end
        for pCity in pPlayer:Cities() do
            if tCities[pCity] then
                pCity:SetNumRealBuilding(iDummy, tCities[pCity] * iMod)
            else
                pCity:SetNumRealBuilding(iDummy, 0)
            end
        end
    end
end

GameEvents.PlayerDoTurn.Add(C15_BlackStar)