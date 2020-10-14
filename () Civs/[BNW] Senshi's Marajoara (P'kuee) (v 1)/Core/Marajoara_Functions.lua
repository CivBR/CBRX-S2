-- ========= --
-- UTILITIES --
-- ========= --

local iPracticalNumCivs = (GameDefines.MAX_MAJOR_CIVS - 1)

function JFD_IsCivilisationActive(civilizationID)
	for iSlot = 0, iPracticalNumCivs, 1 do
		local slotStatus = PreGame.GetSlotStatus(iSlot)
		if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
			if PreGame.GetCivilization(iSlot) == civilizationID then
				return true
			end
		end
	end
	return false
end

-- ======= --
-- DEFINES --
-- ======= --

include("FLuaVector.lua")

local iCiv = GameInfoTypes["CIVILIZATION_SENSHI_MARAJO"]
local bIsActive = JFD_IsCivilisationActive(iCiv)

-- =============================================== --
-- UA: CITIES & GP IMPROVEMENTS SPREAD FRESH WATER --
--           ALSO,  FREE TESO IN CAPITAL           --
-- =============================================== --

local iMarajoWater = GameInfoTypes["FEATURE_SENSHI_MARAJO_FRESHWATER"]
local iTesoInfinite = GameInfoTypes["BUILDING_SENSHI_TESO_INFINITE"]

local tGPImprovements = {}
for row in DB.Query("SELECT * FROM Improvements WHERE CreatedByGreatPerson = 1") do
	tGPImprovements[row.ID] = true
end

function Marajo_CityFounded_FreshWater(playerID, iX, iY)
	local pPlayer = Players[playerID]
	if pPlayer:GetCivilizationType() == iCiv then
		local pPlot = Map.GetPlot(iX, iY)
		if pPlot:IsFreshWater() then
			pPlot:SetFeatureType(iMarajoWater)

			-- Free Teso in capital
			local pCap = pPlayer:GetCapitalCity()
			pCap:SetNumRealBuilding(iTesoInfinite, 1)
		end
	end
end

function Marajo_CityCaptured_FreshWater(oldPlayerID, bCapital, iX, iY, cityID)
	local pPlot = Map.GetPlot(iX, iY)
	local pCapturedCity = pPlot:GetPlotCity()
	local pOwner = Players[pCapturedCity:GetOwner()]
	if pOwner:GetCivilizationType() == iCiv then
		if pPlot:IsFreshWater() then
			pPlot:SetFeatureType(iMarajoWater)
		end
	elseif pPlot:GetFeatureType() == iMarajoWater then
		pPlot:SetFeatureType(-1)
	end

	-- update free Teso if needed
	if bCapital then
		local pOldOwner = Players[oldPlayerID]
		local tRelevantPlayers = {pOwner, pOldOwner}
		for k, vPlayer in pairs(tRelevantPlayers) do
			if vPlayer:GetCivilizationType() == iCiv then
				local pCap = vPlayer:GetCapitalCity()
				if pCap and not pCap:IsHasBuilding(iTesoInfinite) then
					pCap:SetNumRealBuilding(iTesoInfinite, 1)
				end
				if vPlayer:CountNumBuildings(iTesoInfinite) > 1 then
					for pCity in vPlayer:Cities() do
						if pCity:IsHasBuilding(iTesoInfinite) and (pCity ~= pCap) then
							pCity:SetNumRealBuilding(iTesoInfinite, 0)
							break
						end
					end
				end
			end
		end
	end
end

function Marajo_BuildFinished_FreshWater(playerID, iX, iY, improvementType)
	local pPlot = Map.GetPlot(iX, iY)
	if tGPImprovements[improvementType] and pPlot:IsFreshWater() then
		local pPlayer = Players[playerID]
		if pPlayer:GetCivilizationType() == iCiv then
			pPlot:SetFeatureType(iMarajoWater)
			return
		end
	end
	if pPlot:GetFeatureType() == iMarajoWater then
		pPlot:SetFeatureType(-1)
	end
end

if bIsActive then
	GameEvents.PlayerCityFounded.Add(Marajo_CityFounded_FreshWater)
	GameEvents.CityCaptureComplete.Add(Marajo_CityCaptured_FreshWater)
	GameEvents.BuildFinished.Add(Marajo_BuildFinished_FreshWater)
end

-- ================================ --
-- UU: DRAINS HP FROM ADJACENT FOES --
-- ================================ --

local iNumDirections = DirectionTypes.NUM_DIRECTION_TYPES - 1

local iCanoe = GameInfoTypes["UNIT_SENSHI_SNAKECANOE"]
local iGalleassClass = GameInfoTypes["UNITCLASS_GALLEASS"]

function SnakeCanoe_HealthDrain(playerID)
	local pPlayer = Players[playerID]
	if pPlayer:HasUnitOfClassType(iGalleassClass) then
		local pTeam = Teams[pPlayer:GetTeam()]
		for pUnit in pPlayer:Units() do
			if pUnit:GetUnitType() == iCanoe then
				local pPlot = pUnit:GetPlot()
				local iDrainQty = 0
				for iDirection = 0, iNumDirections, 1 do
					local pAdjPlot = Map.PlotDirection(pPlot:GetX(), pPlot:GetY(), iDirection)
					local pAdjUnit = pAdjPlot:GetUnit(0)
					if pAdjUnit then
						local adjUnitTeamID = Players[pAdjUnit:GetOwner()]:GetTeam()
						if pTeam:IsAtWar(adjUnitTeamID) then
							pAdjUnit:ChangeDamage(5)
							iDrainQty = (iDrainQty - 5) --we want this quantity to be negative
						end
					end
				end
				pUnit:ChangeDamage(iDrainQty)
				if pPlayer:IsHuman() then
					local sMessage = "Drain: +" .. (iDrainQty * -1) .. " HP"
					Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(pPlot:GetX(), pPlot:GetY()))), sMessage, 0)
				end
			end
		end
	end
end

if bIsActive then
	GameEvents.PlayerDoTurn.Add(SnakeCanoe_HealthDrain)
end

-- ================================= --
-- UB: NEW TESO CAN BE BUILT PER ERA --
-- ================================= --

local iAncientEra = GameInfoTypes["ERA_ANCIENT"]

local tTesoEras = {}
tTesoEras[GameInfoTypes["BUILDING_SENSHI_TESO"]] = iAncientEra
for row in DB.Query("SELECT * FROM Eras") do
	if row.ID ~= iAncientEra then
		local iEraBuild = GameInfoTypes["BUILDING_SENSHI_TESO_" .. row.Type]
		if iEraBuild then
			tTesoEras[iEraBuild] = row.ID
		end
	end
end

function Teso_WhatCanBeBuilt(playerID, cityID, buildingType)
	if tTesoEras[buildingType] then
		local pPlayer = Players[playerID]
		if (pPlayer:GetCivilizationType() ~= iCiv) then return false end
		return (tTesoEras[buildingType] == pPlayer:GetCurrentEra())
	end
	return true
end

if bIsActive then
	GameEvents.CityCanConstruct.Add(Teso_WhatCanBeBuilt)
end
