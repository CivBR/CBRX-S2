function IsCPDLL()
    for _, mod in pairs(Modding.GetActivatedMods()) do
        if mod.ID == "d1b6328c-ff44-4b0d-aad7-c657f83610cd" then
            return true
        end
    end
    return false
end
local isCPDLL = IsCPDLL()
 
function JFD_InitDummyPolicies()
    for playerID = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
        local player = Players[playerID]
        if player:IsAlive() then
            local civType = GameInfo.Civilizations[player:GetCivilizationType()].Type
            for row in GameInfo.Civilization_FreePolicies("CivilizationType = '" .. civType .. "'") do
                if isCPDLL then
                    player:GrantPolicy(GameInfoTypes[row.PolicyType], true)
                else
                    player:SetNumFreePolicies(1)
                    player:SetNumFreePolicies(0)
                    player:SetHasPolicy(GameInfoTypes[row.PolicyType], true)
                end
            end
        end
    end
end
Events.LoadScreenClose.Add(JFD_InitDummyPolicies)