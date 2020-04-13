--================================================================================================================================================================
local civilizationID = GameInfoTypes["CIVILIZATION_TCM_PTOLEMIES"]
--================================================================================================================================================================
function eraChanged(eraID, playerID)
	local player = Players[playerID];
	if player:GetCivilizationType() == civilizationID then
		for city in player:Cities() do
			if eraID >= GameInfoTypes.ERA_MODERN then
				city:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_DUMMY_PTOLEMIES_B1"], 0)
				city:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_DUMMY_PTOLEMIES_B2"], 0)
				city:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_DUMMY_PTOLEMIES_B3"], 0)
				city:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_DUMMY_PTOLEMIES_B4"], 1)
	    	elseif eraID >= 4 then
	    		city:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_DUMMY_PTOLEMIES_B1"], 0)
	    		city:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_DUMMY_PTOLEMIES_B2"], 0)
	    		city:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_DUMMY_PTOLEMIES_B3"], 1)
	    	elseif eraID >= GameInfoTypes.ERA_MEDIEVAL then
	    		city:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_DUMMY_PTOLEMIES_B1"], 0)
	    		city:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_DUMMY_PTOLEMIES_B2"], 1)
	    	end
		end
	end
end
Events.SerialEventEraChanged.Add(eraChanged)

function onTurn(playerID)
	local player = Players[playerID]
	if player:GetCivilizationType() == civilizationID then
		for city in player:Cities() do
			if player:GetCurrentEra() >= GameInfoTypes.ERA_MODERN then
				city:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_DUMMY_PTOLEMIES_B4"], 1)
			elseif player:GetCurrentEra() >= 4 then
				city:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_DUMMY_PTOLEMIES_B3"], 1)
			elseif player:GetCurrentEra() >= GameInfoTypes.ERA_MEDIEVAL then
				city:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_DUMMY_PTOLEMIES_B2"], 1)
			else
				city:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_DUMMY_PTOLEMIES_B1"], 1)
			end
			city:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_DUMMY_PTOLEMIES_2"], 0)
			local building = city:GetProductionBuilding()
			local production
			if building and building == GameInfoTypes["BUILDING_TCM_DUMMY_POLYREME_1"] then
				if city:IsHasBuilding(GameInfoTypes["BUILDING_TCM_SERAPEUM"]) then
					city:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_DUMMY_PTOLEMIES_2"], 1)
				end
			end
			if building and building == GameInfoTypes["BUILDING_TCM_DUMMY_POLYREME_2"] then
				if city:IsHasBuilding(GameInfoTypes["BUILDING_TCM_SERAPEUM"]) then
					city:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_DUMMY_PTOLEMIES_2"], 1)
				end
				production = city:GetBuildingProduction(GameInfoTypes["BUILDING_TCM_DUMMY_POLYREME_1"])
				city:ChangeBuildingProduction(GameInfoTypes["BUILDING_TCM_DUMMY_POLYREME_2"], production)
				city:SetBuildingProduction(GameInfoTypes["BUILDING_TCM_DUMMY_POLYREME_1"], 0)
	    	end
	    	if building and building == GameInfoTypes["BUILDING_TCM_DUMMY_POLYREME_3"] then
	    		if city:IsHasBuilding(GameInfoTypes["BUILDING_TCM_SERAPEUM"]) then
					city:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_DUMMY_PTOLEMIES_2"], 1)
				end
				production = city:GetBuildingProduction(GameInfoTypes["BUILDING_TCM_DUMMY_POLYREME_2"])
				city:ChangeBuildingProduction(GameInfoTypes["BUILDING_TCM_DUMMY_POLYREME_3"], production)
				city:SetBuildingProduction(GameInfoTypes["BUILDING_TCM_DUMMY_POLYREME_2"], 0)
			end
			if building and building == GameInfoTypes["BUILDING_TCM_DUMMY_POLYREME_4"] then
				if city:IsHasBuilding(GameInfoTypes["BUILDING_TCM_SERAPEUM"]) then
					city:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_DUMMY_PTOLEMIES_2"], 1)
				end
				production = city:GetBuildingProduction(GameInfoTypes["BUILDING_TCM_DUMMY_POLYREME_3"])
				city:ChangeBuildingProduction(GameInfoTypes["BUILDING_TCM_DUMMY_POLYREME_4"], production)
				city:SetBuildingProduction(GameInfoTypes["BUILDING_TCM_DUMMY_POLYREME_3"], 0)
			end

			if city:IsHasBuilding(GameInfoTypes["BUILDING_TCM_SERAPEUM"]) then
				local unit = city:GetProductionUnit()
				if unit ~= nil then
					if GameInfo.Units[unit].Domain == "DOMAIN_SEA" then
						city:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_DUMMY_PTOLEMIES_2"], 1)
					end
				end
				local happiness = 0
				happiness = happiness + city:GetNumGreatPeople() + city:GetNumBuilding(GameInfoTypes["BUILDING_TCM_DUMMY_PTOLEMIES_3"])
				city:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_DUMMY_PTOLEMIES_1"], happiness)
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(onTurn)

function PolyremeBuilt(ownerId, cityId, buildingType, bGold, bFaithOrCulture)
	local player = Players[ownerId]
	if player:GetCivilizationType() == civilizationID then
		if GameInfo.Buildings[buildingType].Type == "BUILDING_TCM_DUMMY_POLYREME_1" or GameInfo.Buildings[buildingType].Type == "BUILDING_TCM_DUMMY_POLYREME_2" or GameInfo.Buildings[buildingType].Type == "BUILDING_TCM_DUMMY_POLYREME_3" or GameInfo.Buildings[buildingType].Type == "BUILDING_TCM_DUMMY_POLYREME_4" then
			local city = player:GetCityByID(cityId)
			local previousNum = city:GetNumBuilding(GameInfoTypes["BUILDING_TCM_DUMMY_PTOLEMIES_3"]) + 1
			player:InitUnit(GameInfoTypes["UNIT_TCM_POLYREME"], city:GetX(), city:GetY())
			city:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_DUMMY_PTOLEMIES_3"], previousNum)
			city:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_DUMMY_POLYREME_1"], 0)
			city:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_DUMMY_POLYREME_2"], 0)
			city:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_DUMMY_POLYREME_3"], 0)
			city:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_DUMMY_POLYREME_4"], 0)
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
            if unit:GetUnitType() == GameInfoTypes["UNIT_GREAT_GENERAL"] then
				Events.SerialEventUnitCreated.Remove(GGOverride)
				newUnit = player:InitUnit(GameInfoTypes["UNIT_TCM_PTOLEMAIC_GENERAL"], unit:GetX(), unit:GetY())
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