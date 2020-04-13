-- All credit goes to Jarcast for making this work!
-- What a gd boi

curlyDummy = GameInfoTypes["BUILDING_CSLESOTHODEFENSEPACTTRAITBUILDING"]
civID       = GameInfoTypes["CIVILIZATION_CSLESOTHO"]

function LesothoDelegatesFromDP(playerID)
    local pPlayer = Players[playerID]
    local pTeam   = Teams[pPlayer:GetTeam()]
    local pCapital = pPlayer:GetCapitalCity()
    if pPlayer:GetCivilizationType() == civID and pPlayer:IsAlive() and pCapital ~= nil then
        local count = 0
        for otherplayerID = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
            local pOtherPlayer = Players[otherplayerID]
            local pOtherTeamID = pOtherPlayer:GetTeam()
            local pOtherCapital = pOtherPlayer:GetCapitalCity()
            if otherplayerID ~= playerID and pOtherCapital ~= nil then
                if pTeam:IsDefensivePact( pOtherTeamID ) then
                    pOtherCapital:SetNumRealBuilding(curlyDummy, 1)
                    count = count +1
                else
                    pOtherCapital:SetNumRealBuilding(curlyDummy, 0)
                end
            end
        end
        pCapital:SetNumRealBuilding(curlyDummy, count)
    end
end

GameEvents.PlayerDoTurn.Add(LesothoDelegatesFromDP)