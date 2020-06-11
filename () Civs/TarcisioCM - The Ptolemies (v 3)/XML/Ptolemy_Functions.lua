--================================================================================================================================================================
local civilizationID = GameInfoTypes["CIVILIZATION_TCM_PTOLEMIES"]

local buildingDummyPolyreme1 = GameInfoTypes["BUILDING_TCM_DUMMY_POLYREME_1"]
local buildingDummyPolyreme2 = GameInfoTypes["BUILDING_TCM_DUMMY_POLYREME_2"]
local buildingDummyPolyreme3 = GameInfoTypes["BUILDING_TCM_DUMMY_POLYREME_3"]
local buildingDummyPolyreme4 = GameInfoTypes["BUILDING_TCM_DUMMY_POLYREME_4"]
local buildingDummyPtolemy1 = GameInfoTypes["BUILDING_TCM_DUMMY_PTOLEMIES_1"]
local buildingDummyPtolemy2 = GameInfoTypes["BUILDING_TCM_DUMMY_PTOLEMIES_2"]
local buildingDummyPtolemy3 = GameInfoTypes["BUILDING_TCM_DUMMY_PTOLEMIES_3"]
local buildingDummyPtolemy4 = GameInfoTypes["BUILDING_TCM_DUMMY_PTOLEMIES_4"]
local buildingDummyPtolemyB1 = GameInfoTypes["BUILDING_TCM_DUMMY_PTOLEMIES_B1"]
local buildingDummyPtolemyB2 = GameInfoTypes["BUILDING_TCM_DUMMY_PTOLEMIES_B2"]
local buildingDummyPtolemyB3 = GameInfoTypes["BUILDING_TCM_DUMMY_PTOLEMIES_B3"]
local buildingDummyPtolemyB4 = GameInfoTypes["BUILDING_TCM_DUMMY_PTOLEMIES_B4"]
local buildingSerapeum = GameInfoTypes["BUILDING_TCM_SERAPEUM"]
local eraMedieval = GameInfoTypes["ERA_MEDIEVAL"]
local eraModern = GameInfoTypes["ERA_MODERN"]
local unitGreatGeneral = GameInfoTypes["UNIT_GREAT_GENERAL"]
local unitPolyreme = GameInfoTypes["UNIT_TCM_POLYREME"]
local unitPtolemyGeneral = GameInfoTypes["UNIT_TCM_PTOLEMAIC_GENERAL"]

--================================================================================================================================================================
function eraChanged(eraID, playerID)
  local player = Players[playerID];
  if player:GetCivilizationType() == civilizationID then
    for city in player:Cities() do
      if eraID >= eraModern then
        city:SetNumRealBuilding(buildingDummyPtolemyB1, 0)
        city:SetNumRealBuilding(buildingDummyPtolemyB2, 0)
        city:SetNumRealBuilding(buildingDummyPtolemyB3, 0)
        city:SetNumRealBuilding(buildingDummyPtolemyB4, 1)
      elseif eraID >= 4 then
        city:SetNumRealBuilding(buildingDummyPtolemyB1, 0)
        city:SetNumRealBuilding(buildingDummyPtolemyB2, 0)
        city:SetNumRealBuilding(buildingDummyPtolemyB3, 1)
      elseif eraID >= eraMedieval then
        city:SetNumRealBuilding(buildingDummyPtolemyB1, 0)
        city:SetNumRealBuilding(buildingDummyPtolemyB2, 1)
      end
    end
  end
end
Events.SerialEventEraChanged.Add(eraChanged)

function onTurn(playerID)
  local player = Players[playerID]
  if player:GetCivilizationType() == civilizationID then
    for city in player:Cities() do
      if player:GetCurrentEra() >= eraModern then
        city:SetNumRealBuilding(buildingDummyPtolemyB4, 1)
      elseif player:GetCurrentEra() >= 4 then
        city:SetNumRealBuilding(buildingDummyPtolemyB3, 1)
      elseif player:GetCurrentEra() >= eraMedieval then
        city:SetNumRealBuilding(buildingDummyPtolemyB2, 1)
      else
        city:SetNumRealBuilding(buildingDummyPtolemyB1, 1)
      end
      city:SetNumRealBuilding(buildingDummyPtolemy2, 0)
      local building = city:GetProductionBuilding()
      local production
      if building and building == buildingDummyPolyreme1 then
        if city:IsHasBuilding(buildingSerapeum) then
          city:SetNumRealBuilding(buildingDummyPtolemy2, 1)
        end
      end
      if building and building == buildingDummyPolyreme2 then
        if city:IsHasBuilding(buildingSerapeum) then
          city:SetNumRealBuilding(buildingDummyPtolemy2, 1)
        end
        production = city:GetBuildingProduction(buildingDummyPolyreme1)
        city:ChangeBuildingProduction(buildingDummyPolyreme2, production)
        city:SetBuildingProduction(buildingDummyPolyreme1, 0)
      end
      if building and building == buildingDummyPolyreme3 then
        if city:IsHasBuilding(buildingSerapeum) then
          city:SetNumRealBuilding(buildingDummyPtolemy2, 1)
        end
        production = city:GetBuildingProduction(buildingDummyPolyreme2)
        city:ChangeBuildingProduction(buildingDummyPolyreme3, production)
        city:SetBuildingProduction(buildingDummyPolyreme2, 0)
      end
      if building and building == buildingDummyPolyreme4 then
        if city:IsHasBuilding(buildingSerapeum) then
          city:SetNumRealBuilding(buildingDummyPtolemy2, 1)
        end
        production = city:GetBuildingProduction(buildingDummyPolyreme3)
        city:ChangeBuildingProduction(buildingDummyPolyreme4, production)
        city:SetBuildingProduction(buildingDummyPolyreme3, 0)
      end

      if city:IsHasBuilding(buildingSerapeum) then
        local unit = city:GetProductionUnit()
        if unit then
          if GameInfo.Units[unit].Domain == "DOMAIN_SEA" then
            city:SetNumRealBuilding(buildingDummyPtolemy2, 1)
          end
        end
        local happiness = 0
        happiness = happiness + city:GetNumGreatPeople() + city:GetNumBuilding(buildingDummyPtolemy3)
        city:SetNumRealBuilding(buildingDummyPtolemy1, happiness)
      end
    end
  end
end
GameEvents.PlayerDoTurn.Add(onTurn)

function PolyremeBuilt(ownerId, cityId, buildingType, bGold, bFaithOrCulture)
  local player = Players[ownerId]
  if player:GetCivilizationType() == civilizationID then
    if buildingType == buildingDummyPolyreme1 or buildingType == buildingDummyPolyreme2 or buildingType == buildingDummyPolyreme3 or buildingType == buildingDummyPolyreme4 then
      local city = player:GetCityByID(cityId)
      local previousNum = city:GetNumBuilding(buildingDummyPtolemy3) + 1
      player:InitUnit(unitPolyreme, city:GetX(), city:GetY())
      city:SetNumRealBuilding(buildingDummyPtolemy3, previousNum)
      city:SetNumRealBuilding(buildingDummyPolyreme1, 0)
      city:SetNumRealBuilding(buildingDummyPolyreme2, 0)
      city:SetNumRealBuilding(buildingDummyPolyreme3, 0)
      city:SetNumRealBuilding(buildingDummyPolyreme4, 0)
    end
  end
end
GameEvents.CityConstructed.Add(PolyremeBuilt)
--================================================================================================================================================================
--UA
--================================================================================================================================================================
function GGOverride(iPlayer, iUnit)
  local player = Players[iPlayer]
  if player:GetCivilizationType() == civilizationID then
    if player:GetUnitByID(iUnit) then
      local unit = player:GetUnitByID(iUnit);
      if unit:GetUnitType() == unitGreatGeneral then
        Events.SerialEventUnitCreated.Remove(GGOverride)
        newUnit = player:InitUnit(unitPtolemyGeneral, unit:GetX(), unit:GetY())
        newUnit:Convert(unit);
        Events.SerialEventUnitCreated.Add(GGOverride)
      end
    end
  end
end
Events.SerialEventUnitCreated.Add(GGOverride)

function WonderBuilt(ownerId, cityId, buildingType, bGold, bFaithOrCulture)
  local player = Players[ownerId]
  if player:GetCivilizationType() == civilizationID then
    if GameInfo.Buildings[buildingType].WonderSplashImage ~= nil then
      local city = player:GetCityByID(cityId)
      city:ChangePopulation(1, true)
    end
  end
end
GameEvents.CityConstructed.Add(WonderBuilt)
--================================================================================================================================================================
