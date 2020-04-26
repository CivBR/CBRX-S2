-- Lua Script1
-- Author: pedro
-- DateCreated: 02/28/16 4:27:05 PM
--------------------------------------------------------------
include("PlotIterators.lua")
include("FLuaVector.lua")

local solanoID = GameInfoTypes.CIVILIZATION_UC_PARAGUAY
local acaVera = GameInfoTypes.UNIT_UC_ACA_VERA

--------------------------------------------------------------
-- JFD_IsCivilisationActive
--------------------------------------------------------------
function JFD_IsCivilisationActive(solanoID)
	for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local slotStatus = PreGame.GetSlotStatus(iSlot)
		if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
			if PreGame.GetCivilization(iSlot) == solanoID then
				return true
			end
		end
	end

	return false
end

local isSolanoActive = JFD_IsCivilisationActive(solanoID)

local horse = GameInfoTypes.RESOURCE_HORSE

function AcaVeraBonus(playerID, cityID, unitID)
local player = Players[playerID]
if (player:IsAlive() and player:GetCivilizationType() == solanoID) then
		local unit = player:GetUnitByID(unitID)
		local unitType = unit:GetUnitType()
			if unitType == acaVera then
			if player:GetNumResourceAvailable(GameInfoTypes.RESOURCE_HORSE) > 0 then
			local BaseXP = unit:GetExperience()
			local acaXP = BaseXP + 15
			unit:SetExperience(acaXP);
				end
			end
		end
	end
if isSolanoActive then
GameEvents.CityTrained.Add(AcaVeraBonus)
end

local iMod 						= (GameInfo.GameSpeeds[Game.GetGameSpeedType()].BuildPercent)/100

function SolanoSelling(playerID, cityID, buildingID)
local player = Players[playerID]
if (player:IsAlive() and player:GetCivilizationType() == solanoID) then
        local iCity = player:GetCityByID(cityID)
        if iCity:GetProductionUnit() ~= -1 then
		local prodCost = player:GetBuildingProductionNeeded(buildingID) * iMod
		local base = iCity:GetProduction()
            iCity:SetProduction(prodCost + base)
        end
    end
end
if isSolanoActive then
GameEvents.CitySoldBuilding.Add(SolanoSelling)
end

local oil = GameInfoTypes.RESOURCE_OIL
local aluminum = GameInfoTypes.RESOURCE_ALUMINUM
local uranium = GameInfoTypes.RESOURCE_URANIUM
local iron = GameInfoTypes.RESOURCE_IRON
local horse = GameInfoTypes.RESOURCE_HORSE
local coal = GameInfoTypes.RESOURCE_COAL

function SolanoFoundry(playerID, plotX, plotY, improvementID)
local player = Players[playerID]
        if player:IsAlive() and player:GetCivilizationType() == solanoID then
        if improvementID ~= -1 then
		local plot = Map.GetPlot(plotX, plotY)
		local resource = plot:GetResourceType()
		if (resource == oil or resource == horse or resource == coal or resource == aluminum or resource == uranium or resource == iron) then
		for city in player:Cities() do
		if city:IsHasBuilding(GameInfoTypes.BUILDING_UC_FOUNDRY) then
			local cityX = city:GetX()
			local cityY = city:GetY()
			local plotX = plot:GetX()
			local plotY = plot:GetY()
			local distance = Map.PlotDistance(plotX, plotY, cityX, cityY)
			if distance < 4 then
		local quantity = plot:GetNumResource()
		local production = math.floor((city:GetBaseYieldRate(GameInfoTypes.YIELD_PRODUCTION) * quantity) / 3)
		city:ChangeProduction(production)
		if player:IsHuman() then
		local convertTextKey 	= Locale.ConvertTextKey
		local hex = ToHexFromGrid(Vector2(plotX, plotY))
					Events.AddPopupTextEvent(HexToWorld(hex), convertTextKey("+{1_Num}[ENDCOLOR] [ICON_PRODUCTION]", production), true)
							end
						end
					end
				end
			end
		end
	end
end
if isSolanoActive then
GameEvents.BuildFinished.Add(SolanoFoundry)
end

function AcaSurrounded(playerID)
local player = Players[playerID]
local team = player:GetTeam();
if player:IsAlive() then
for unit in player:Units() do
	if unit:GetUnitType() == GameInfoTypes.UNIT_UC_ACA_VERA then
	unit:SetBaseCombatStrength(34)
	local plot = unit:GetPlot()
	for adjacentPlot in PlotAreaSweepIterator(plot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
	if adjacentPlot:IsUnit() then
	local adjUnit = adjacentPlot:GetUnit()
	if (unit:GetOwner() ~= adjUnit:GetOwner()) then
	local adjPlayer = Players[adjUnit:GetOwner()];
	local adjTeam = adjPlayer:GetTeam();
	if Teams[team]:IsAtWar(adjTeam) then
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
GameEvents.PlayerDoTurn.Add(AcaSurrounded)