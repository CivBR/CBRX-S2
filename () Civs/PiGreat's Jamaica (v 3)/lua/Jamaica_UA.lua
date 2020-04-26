local tValidBuildings = {}
for row in DB.Query("SELECT BuildingClassType, BuildingType FROM Civilization_BuildingClassOverrides WHERE CivilizationType = 'CIVILIZATION_PI_JAMAICA' AND (SELECT GreatWorkCount FROM Buildings WHERE Type = BuildingType) > -1") do
    table.insert(tValidBuildings, {["ID"] = GameInfoTypes[row.BuildingType], ["BuildingClass"] = GameInfoTypes[row.BuildingClassType]})
end

 
local tGWBuildings = {}
for row in GameInfo.Buildings("GreatWorkCount > 1") do
    table.insert(tGWBuildings, {["ID"] = row.ID, ["BuildingClass"] = GameInfoTypes[row.BuildingClass]})
end
 
local tGuilds = {
[GameInfoTypes["BUILDING_JAMAICA_WRITER_DUMMY"]] = GameInfoTypes["BUILDING_WRITERS_GUILD"],
[GameInfoTypes["BUILDING_JAMAICA_ARTIST_DUMMY"]] = GameInfoTypes["BUILDING_ARTISTS_GUILD"],
[GameInfoTypes["BUILDING_JAMAICA_MUSICIAN_DUMMY"]] = GameInfoTypes["BUILDING_MUSICIANS_GUILD"]
}
 
local civilizationID = GameInfoTypes["CIVILIZATION_PI_JAMAICA"]
local iGMPDummy = GameInfoTypes["BUILDING_PI_GMP_DUMMY"]
 
function C15_JamaicaDoTurn(playerID)
    local pPlayer = Players[playerID]
    if pPlayer:IsAlive() and pPlayer:GetCivilizationType() == civilizationID then
        for pCity in pPlayer:Cities() do
            local i = 0
            for k, v in ipairs(tValidBuildings) do
                if pCity:IsHasBuilding(v.ID) then
                    if not pCity:IsHoldingGreatWork(v.BuildingClass) then
                        i = i + 1
                    end
                end
            end
            pCity:SetNumRealBuilding(iGMPDummy, i)
        end
    end
end
 
GameEvents.PlayerDoTurn.Add(C15_JamaicaDoTurn)
 
function C15_JamaicaCanConstruct(playerID, cityID, buildingID)
    local pPlayer = Players[playerID]
    local pCity = pPlayer:GetCityByID(cityID)
    if pPlayer:IsAlive() and pPlayer:GetCivilizationType() == civilizationID then
        if tGuilds[buildingID] then
            if pCity:IsHasBuilding(tGuilds[buildingID]) then return false end
            if pCity:GetNumGreatWorkSlots() == 0 then return false end
            for k, v in ipairs(tGWBuildings) do
                if pCity:IsHasBuilding(v.ID) then
                    if not pCity:IsHoldingGreatWork(v.BuildingClass) then
                        return false
                    end
                end
            end
        end
    end
return true
end
 
GameEvents.CityCanConstruct.Add(C15_JamaicaCanConstruct)