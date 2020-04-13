local iThisCiv = GameInfoTypes.CIVILIZATION_CL_KULIN;
local iSettleGoldEquivalent = 1000;
 
function CL_CityBurst(pPlayer, pCity)
        for i, Other in pairs(Players) do
                if Other:IsAlive() and Other:IsMinorCiv() then
                        for i = 0, pCity:GetNumCityPlots() - 1, 1 do
                                local pOtherPlot = pCity:GetCityIndexPlot(i);
                                if pOtherPlot ~= nil then
                                        if pPlot:IsCity() then 
                                                local iOtherPlayer = pOtherPlot:GetOwner();
                                                local pOtherPlayer = Players[iOtherPlayer];
                                                Other:ChangeMinorCivFriendshipWithMajor(pPlayer, 50);
                                                return
                                        end
                end
            end
        end
        end
end
 
function CL_IncreaseNearbyInfluenceAtNewCity(iPlayer, iCityX, iCityY)
    local pPlayer = Players[iPlayer];
    if pPlayer:IsAlive() and pPlayer:GetCivilizationType() == iThisCiv then
       local pPlot = Map.GetPlot(iCityX, iCityY);
       local pCity = pPlot:GetPlotCity();
       CL_CityBurst(pPlayer, pCity)
    end
end
 
GameEvents.PlayerCityFounded.Add(CL_IncreaseNearbyInfluenceAtNewCity);