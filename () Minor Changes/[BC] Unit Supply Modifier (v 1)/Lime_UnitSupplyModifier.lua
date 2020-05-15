local productionDebuffLand = GameInfoTypes["BUILDING_LIME_PRODUCTION_DEBUFF_LAND"]
local productionDebuffSea = GameInfoTypes["BUILDING_LIME_PRODUCTION_DEBUFF_SEA"]
local unitDomainLand = GameInfoTypes["UNIT_WARRIOR"]
local unitDomainSea = GameInfoTypes["UNIT_GALLEASS"]

local min = math.min
local max = math.max

function Lime_NewUnitSupply(iPlayer)
  local player = Players[iPlayer]
  if not player then return end
  if not player:IsAlive() then return end

  local iUnitSupply = player:CalculateUnitSupply() + player:GetNumCities() * 2
  local numUnitsOver = player:GetNumMilitaryUnits() - iUnitSupply

  if numUnitsOver > 0 then
	--print("Grrr have less units, you have this many more than you should " .. tostring(numUnitsOver))
    for city in player:Cities() do
      local landUnitProductionModifier = city:GetUnitProductionModifier(unitDomainLand)
      local seaUnitProductionModifier = city:GetUnitProductionModifier(unitDomainSea)

      city:SetNumRealBuilding(productionDebuffLand, max(0, landUnitProductionModifier - min(95, numUnitsOver)))
      city:SetNumRealBuilding(productionDebuffSea, max(0, seaUnitProductionModifier - min(95, numUnitsOver)))

    end
  end
end
GameEvents.PlayerDoTurn.Add(Lime_NewUnitSupply)