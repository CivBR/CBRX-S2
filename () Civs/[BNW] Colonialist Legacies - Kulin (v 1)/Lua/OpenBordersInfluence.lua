--GameDefines Constants
local iMaxCivs = GameDefines.MAX_MAJOR_CIVS
local iMaxPlayers = GameDefines.MAX_CIV_PLAYERS
 
--Other Constants
local THIS_CIV = GameInfoTypes.CIVILIZATION_CL_KULIN
local INFLUENCE_AMOUNT = 1
 
 
function OnPlayerDoTurn(iPlayer)
        if iPlayer < iMaxCivs then
                local pPlayer = Players[iPlayer]
                local iCivType = pPlayer:GetCivilizationType()
                if iCivType == THIS_CIV then
                        for iLoop = 0, iMaxCivs - 1, 1 do
                                if iLoop ~= iPlayer then
                                        local pLoop = Players[iLoop]
                                        if pLoop:IsAlive() and pLoop:IsPlayerHasOpenBorders(iPlayer) and pPlayer:IsPlayerHasOpenBorders(iLoop) then
                                                for iCS = iMaxCivs, iMaxPlayers - 1, 1 do
                                                        local pCS = Players[iCS]
                                                        if pCS:IsAlive() and pCS:GetMinorCivFriendshipLevelWithMajor(iLoop) >= 1 then
                                                                pCS:ChangeMinorCivFriendshipWithMajor(iPlayer, INFLUENCE_AMOUNT)
                                                        end
                                                end
                                        end
                                end
                        end
                end
        end
end
GameEvents.PlayerDoTurn.Add(OnPlayerDoTurn)