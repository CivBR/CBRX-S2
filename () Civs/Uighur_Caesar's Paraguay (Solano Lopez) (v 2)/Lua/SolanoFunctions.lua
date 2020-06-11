-- Lua Script1
-- Author: pedro
-- DateCreated: 02/28/16 4:27:05 PM
--------------------------------------------------------------
include("PlotIterators.lua")
include("FLuaVector.lua")

local solanoID = GameInfoTypes["CIVILIZATION_UC_PARAGUAY"]
local acaVera = GameInfoTypes["UNIT_UC_ACA_VERA"]

local horse = GameInfoTypes["RESOURCE_HORSE"]

function AcaVeraBonus(playerID, cityID, unitID)
	local player = Players[playerID]
	if (player:IsAlive() and player:GetCivilizationType() == solanoID) then
		local unit = player:GetUnitByID(unitID)
		local unitType = unit:GetUnitType()
		if unitType == acaVera then
			if player:GetNumResourceAvailable(horse) > 0 then
				local BaseXP = unit:GetExperience()
				local acaXP = BaseXP + 15
				unit:SetExperience(acaXP);
			end
		end
	end
end
GameEvents.CityTrained.Add(AcaVeraBonus)

local iMod = (GameInfo.GameSpeeds[Game.GetGameSpeedType()].BuildPercent)/100

function SolanoSelling(playerID, cityID, buildingID)
	local player = Players[playerID]
	if (player:IsAlive() and player:GetCivilizationType() == solanoID) then
        	local pCity = player:GetCityByID(cityID)
	        if pCity:GetProductionUnit() ~= -1 then
			local prodCost = player:GetBuildingProductionNeeded(buildingID) * iMod
			local base = pCity:GetProduction()
			pCity:SetProduction(prodCost + base)
		end
	end
end
GameEvents.CitySoldBuilding.Add(SolanoSelling)

local tStratRes = {}
for row in DB.Query("SELECT * FROM Resources WHERE (ResourceClassType = 'RESOURCECLASS_RUSH') OR (ResourceClassType = 'RESOURCECLASS_MODERN')") do
	tStratRes[row.ID] = true
end

local iFoundry = GameInfoTypes["BUILDING_UC_FOUNDRY"]
local iYieldProd = GameInfoTypes["YIELD_PRODUCTION"]

function SolanoFoundry(playerID, plotX, plotY, improvementID)
	local player = Players[playerID]
        if player:IsAlive() and player:GetCivilizationType() == solanoID then
        	if improvementID ~= -1 then
			local plot = Map.GetPlot(plotX, plotY)
			local resource = plot:GetResourceType()
			if tStratRes[resource] then
				for city in player:Cities() do
					if city:IsHasBuilding(iFoundry) then
						local cityX = city:GetX()
						local cityY = city:GetY()
						local distance = Map.PlotDistance(plotX, plotY, cityX, cityY)
						if distance < 4 then
							local quantity = plot:GetNumResource()
							local production = math.floor((city:GetBaseYieldRate(iYieldProd) * quantity) / 3)
							city:ChangeProduction(production)
						end
					end
				end
			end
		end
	end
end
GameEvents.BuildFinished.Add(SolanoFoundry)

local iCavalryClass = GameInfoTypes["UNITCLASS_CAVALRY"]

function AcaSurrounded(playerID)
	local player = Players[playerID]
	local team = Teams[player:GetTeam()]
	if player:IsAlive() and player:HasUnitOfClassType(iCavalryClass) then
		for unit in player:Units() do
			if unit:GetUnitType() == acaVera then
				unit:SetBaseCombatStrength(34)
				local plot = unit:GetPlot()
				for adjacentPlot in PlotAreaSweepIterator(plot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
					if adjacentPlot:IsUnit() then
						local adjUnit = adjacentPlot:GetUnit()
						if adjUnit then
							local adjOwner = adjUnit:GetOwner()
							if (adjOwner ~= playerID) then
								local adjTeam = Players[adjOwner]:GetTeam()
								if team:IsAtWar(adjTeam) then
									local strength = unit:GetBaseCombatStrength() + 3
									unit:SetBaseCombatStrength(strength)
								end
							end
						end
					end
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(AcaSurrounded)
