local civilizationMarathaID = GameInfoTypes["CIVILIZATION_MC_MARATHA"]
local techGunpowderID = GameInfoTypes["TECH_GUNPOWDER"]
local unitSepoyID = GameInfoTypes["UNIT_MC_MARATHAN_SEPOY"]
 
function MC_Maratha_GunpowderSepoys(teamID, techID)
    local playerID = Teams[teamID]:GetLeaderID()
    local player = Players[playerID]
    if player:GetCivilizationType() ~= civilizationMarathaID then return end
    if techID == techGunpowderID then
        local capital = player:GetCapitalCity()
        player:InitUnit(unitSepoyID, capital:GetX(), capital:GetY())
        player:InitUnit(unitSepoyID, capital:GetX(), capital:GetY())
    end
end
GameEvents.TeamTechResearched.Add(MC_Maratha_GunpowderSepoys)
 
function MC_Maratha_GunpowderSepoys_AdvancedStart()
    for playerID = 0, GameDefines.MAX_MAJOR_CIVS-1 do
        local player = Players[playerID];
        if player:GetCivilizationType() ~= civilizationMarathaID then return end
        if player:IsAlive() then
            if player:GetNumCities() < 1 then
                if Teams[player:GetTeam()]:HasTech(techGunpowderID) then
                    local capital = player:GetCapitalCity()
                    player:InitUnit(unitSepoyID, capital:GetX(), capital:GetY())
                    player:InitUnit(unitSepoyID, capital:GetX(), capital:GetY())
                end
            end
        end
    end
end
Events.LoadScreenClose.Add(MC_Maratha_GunpowderSepoys_AdvancedStart)