-- Chinook_CoreFunctions
-- Author: Sukritact
--=======================================================================================================================

include("PlotIterators.lua")
print("Loaded")

--=======================================================================================================================
-- UTILITY FUNCTIONS
--=======================================================================================================================
-- JFD_IsCivilisationActive
-------------------------------------------------------------------------------------------------------------------------
function JFD_IsCivilisationActive(civilisationID)
	for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local slotStatus = PreGame.GetSlotStatus(iSlot)
		if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
			if PreGame.GetCivilization(iSlot) == civilisationID then
				return true
			end
		end
	end

	return false
end
--------------------------------------------------------------
-- Abort if Chinook not in Game
--------------------------------------------------------------
local iCiv = GameInfoTypes.CIVILIZATION_MC_CHINOOK
if not(JFD_IsCivilisationActive(iCiv)) then
	print("Chinook not active, aborting")
	return
end
--------------------------------------------------------------
-- Sukritact_PlaceResource
--------------------------------------------------------------
function Sukritact_PlaceResource(pCity, iResource)
	local pPlot = pCity:Plot()
    local tPlots = {}
	local iPlayer = pCity:GetOwner()
    local iNumtoPlace = 1
    for pLoopPlot in PlotAreaSpiralIterator(pPlot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
        table.insert(tPlots, pLoopPlot)
		if pLoopPlot:GetOwner() == iPlayer then
			table.insert(tPlots, pLoopPlot)
			table.insert(tPlots, pLoopPlot)
		end
    end

	local pTargetPlot = nil

    for iVal = 1, iNumtoPlace do
		local bPlaced = false
		while (not(bPlaced)) and #tPlots > 0 do
			local iRandom = GetRandom(1, #tPlots)
			local pPlot = tPlots[iRandom]
			if (pPlot:GetTerrainType() == GameInfoTypes["TERRAIN_COAST"]) and (pPlot:GetFeatureType() ~= GameInfoTypes["FEATURE_ATOLL"]) and (not(pPlot:IsLake())) and (pPlot:GetResourceType() == -1) and ((pPlot:GetOwner() == -1) or (pPlot:GetOwner() == iPlayer)) then
				pPlot:SetResourceType(iResource, 1)
				pPlot:SetOwner(-1)
				pPlot:SetOwner(iPlayer, pCity:GetID())
				pTargetPlot = pPlot
				bPlaced = true
			end

			table.remove(tPlots, iRandom)
		end
	end

	return pTargetPlot
end
-------------------------------------------------------------------------------------------------------------------------
-- GetRiverCities
-------------------------------------------------------------------------------------------------------------------------
function GetRiverCities(pPlayer)
	local tCities = {}
	for pCity in pPlayer:Cities() do
		local pPlot = pCity:Plot()
		if pPlot:IsRiver() then table.insert(tCities, pCity) end
	end
	return tCities
end
-------------------------------------------------------------------------------------------------------------------------
-- GetCoastalCities
-------------------------------------------------------------------------------------------------------------------------
function GetCoastalCities(pPlayer)
	local tCities = {}
	for pCity in pPlayer:Cities() do
		local pPlot = pCity:Plot()
		if pPlot:IsCoastalLand() then table.insert(tCities, pCity) end
	end
	return tCities
end
-------------------------------------------------------------------------------------------------------------------------
-- GetRandom
-------------------------------------------------------------------------------------------------------------------------
function GetRandom(lower, upper)
    return (Game.Rand((upper + 1) - lower, "")) + lower
end
--=======================================================================================================================
-- Chinook UB: Plankhouse
--=======================================================================================================================
-- Globals
-------------------------------------------------------------------------------------------------------------------------
local iPlankhouse = GameInfoTypes.BUILDING_MC_PLANKHOUSE
local iPlankhouseDummy = GameInfoTypes.BUILDING_MC_PLANKHOUSE_DUMMY

function Plankhouse_RiverCheck(iPlayer, iCity, iType)
	if iType ~= CityUpdateTypes.CITY_UPDATE_TYPE_PRODUCTION then return end

	local pPlayer = Players[iPlayer]
	local pCity = pPlayer:GetCityByID(iCity)
	if (not pCity) then return end
	local pPlot = pCity:Plot()

	if pCity:IsHasBuilding(iPlankhouse) and pPlot:IsRiver() then
		pCity:SetNumRealBuilding(iPlankhouseDummy, 1)
	else
		pCity:SetNumRealBuilding(iPlankhouseDummy, 0)
	end
end
Events.SpecificCityInfoDirty.Add(Plankhouse_RiverCheck)

function Plankhouse_CanBuild(iPlayer, iCity, iBuilding)

	if iBuilding ~= iPlankhouse then return true end

	local pPlayer = Players[iPlayer]
	local pCity = pPlayer:GetCityByID(iCity)
	local pPlot = pCity:Plot()

	if (pPlot:IsFreshWater() or pPlot:IsCoastalLand() or pPlot:IsRiver()) then return true end
	return
end
GameEvents.CityCanConstruct.Add(Plankhouse_CanBuild)
--=======================================================================================================================
-- Chinook UA: Salmon Migration
--=======================================================================================================================
-- Globals
-------------------------------------------------------------------------------------------------------------------------
local iCanoe = GameInfoTypes.PROMOTION_MC_CHINOOK_WHALER
local iPlatform = GameInfoTypes.IMPROVEMENT_OFFSHORE_PLATFORM
local iFishingBoat = GameInfoTypes.IMPROVEMENT_FISHING_BOATS
local iTech = GameInfoTypes[GameInfo.Resources["RESOURCE_OIL"].TechReveal]

-- Retrieve all Maritime Resources
local tValidResources = {}
for tRow in GameInfo.Improvement_ResourceTypes() do
	if (tRow.ImprovementType == "IMPROVEMENT_FISHING_BOATS") or (tRow.ImprovementType == "IMPROVEMENT_OFFSHORE_PLATFORM") then
		tValidResources[GameInfoTypes[tRow.ResourceType]] = GameInfoTypes[tRow.ImprovementType]
	end
end

local iSalmon = GameInfoTypes.RESOURCE_MC_SALMON
local iOrca = GameInfoTypes.RESOURCE_MC_ORCA
-------------------------------------------------------------------------------------------------------------------------
-- Salmon Migration: Automatic Fishing Boats
-------------------------------------------------------------------------------------------------------------------------
tPlots = {}
tOil = {}
for iPlot = 0, Map.GetNumPlots() - 1, 1 do
    local pPlot = Map.GetPlotByIndex(iPlot)
	local iPlayer = pPlot:GetOwner()
	local pPlayer = Players[iPlayer]
	if pPlayer then
		if (pPlayer:GetCivilizationType() == iCiv) and (tValidResources[pPlot:GetResourceType()]) then
			local iImprovement = tValidResources[pPlot:GetResourceType()]
			if (iImprovement == iPlatform) and (pPlot:IsWater()) then
				tOil[pPlot] = true
			elseif pPlot:CanHaveImprovement(iImprovement) then
				tPlots[pPlot] = true
			end
		end
	end
end

function AutomaticFishingBoats(iX, iY)
	local pPlot = Map.GetPlot(ToGridFromHex(iX, iY))

	local iPlayer = pPlot:GetOwner()
	if iPlayer == -1 then return end

	local pPlayer = Players[iPlayer]

	if (pPlayer:GetCivilizationType() == iCiv) and (tValidResources[pPlot:GetResourceType()]) then
		local iImprovement = tValidResources[pPlot:GetResourceType()]

		if (iImprovement == iPlatform) and (pPlot:IsWater()) then
			tOil[pPlot] = true
			if Teams[pPlayer:GetTeam()]:IsHasTech(iTech) then
				pPlot:SetImprovementType(iImprovement)
			end
			return
		end

		if not(pPlot:CanHaveImprovement(iImprovement)) then return end
		tPlots[pPlot] = true
		pPlot:SetImprovementType(iImprovement)
	else
		if tPlots[pPlot] or tOil[pPlot] then
			tPlots[pPlot] = nil
			tOil[pPlot] = nil

			local iResource = pPlot:GetResourceType()
			if (iResource == iSalmon) or (iResource == iOrca) then
				pPlot:SetImprovementType(-1)
				pPlot:SetResourceType(-1)
			end

		end
	end
end
Events.SerialEventHexCultureChanged.Add(AutomaticFishingBoats)

function Tech_AutomaticFishingBoats(iTeam, iNewTech, iChange)
	if iNewTech == iTech then
		for pPlot, _ in pairs(tOil) do
			local iPlayer = pPlot:GetOwner()
			pPlot:SetOwner(-1)
			pPlot:SetOwner(iPlayer)
		end
	end
end
GameEvents.TeamSetHasTech.Add(Tech_AutomaticFishingBoats)
-------------------------------------------------------------------------------------------------------------------------
-- Salmon Migration: Push Notification
-------------------------------------------------------------------------------------------------------------------------
local tText = {}
	tText[iSalmon] 	= "[ICON_RES_MC_SALMON] " .. Locale.ConvertTextKey("TXT_KEY_RESOURCE_MC_SALMON")
	tText[iOrca] 		= "[ICON_RES_MC_ORCA]" .. Locale.ConvertTextKey("TXT_KEY_RESOURCE_MC_ORCA")

function PushNotification(pCity, pPlot, iResource, bTowards)

	local pPlayer = Players[pCity:GetOwner()]
	if not(pPlayer:IsHuman()) then return end

	local sDirection = Locale.ConvertTextKey("TXT_KEY_TRAIT_MC_CHINOOK_TO")
	if not(bTowards) then
		sDirection = Locale.ConvertTextKey("TXT_KEY_TRAIT_MC_CHINOOK_AWAY")
	end

	local sCity = pCity:GetName()
	local sTooltip = Locale.ConvertTextKey("TXT_KEY_TRAIT_MC_CHINOOK_NOTIFICATION", tText[iResource], sDirection, sCity)

	if pPlayer:HasPolicy(GameInfoTypes.POLICY_DECISIONS_CHINOOKSALMONRITES) then
		sTooltip = sTooltip .. " " .. Locale.ConvertTextKey("TXT_KEY_DECISIONS_CHINOOKSALMONRITES_NOTIFICATION", math.ceil(40 * ((GameInfo.GameSpeeds[Game.GetGameSpeedType()].BuildPercent)/100)))
	end

	pPlayer:AddNotification(NotificationTypes.NOTIFICATION_DISCOVERED_BONUS_RESOURCE, sTooltip, Locale.ConvertTextKey("TXT_KEY_TRAIT_MC_CHINOOK_SHORT"), pPlot:GetX(), pPlot:GetY(), iResource, -1)
end
-------------------------------------------------------------------------------------------------------------------------
-- Salmon Migration: Assign Salmon Plots
-------------------------------------------------------------------------------------------------------------------------
tRandom = {iOrca, iSalmon, iSalmon, iSalmon}
tSalmon = {}
for iPlot = 0, Map.GetNumPlots() - 1, 1 do
    local pPlot = Map.GetPlotByIndex(iPlot)
	local iPlayer = pPlot:GetOwner()
	local pPlayer = Players[iPlayer]
	if pPlayer then
		local iResource = pPlot:GetResourceType()
		if (iResource == iSalmon) or (iResource == iOrca) then

			--Find nearest unassigned city
			local iDistance = nil
			local pTargetCity = nil
			for pCity in pPlayer:Cities() do
				if (not(iDistance) or iDistance > Map.PlotDistance(iX, iY, pCity:GetX(), pCity:GetY())) and not(tSalmon[pCity]) then
					pTargetCity = pCity
					iDistance = Map.PlotDistance(iX, iY, pCity:GetX(), pCity:GetY())
				end
			end

			tSalmon[pTargetCity] = pPlot
		end
	end
end
-------------------------------------------------------------------------------------------------------------------------
-- Salmon Migration: Place Salmon
-------------------------------------------------------------------------------------------------------------------------
function PlaceSalmon(iPlayer, iX, iY)
	local pPlayer = Players[iPlayer]
	if (pPlayer:GetCivilizationType() == iCiv) then
		local pPlot = Map.GetPlot(iX, iY)
		local pCity = pPlot:GetPlotCity()

		if pCity:IsCapital() then
			tSalmon[pCity] = Sukritact_PlaceResource(pCity, tRandom[GetRandom(1, 2)])
			return tSalmon[pCity]
		end

		local iUpper = 7

		local iNum = pPlayer:GetNumCities()
		local iDivisor = 2
		if pPlot:IsRiver() then iDivisor = 4 end
		local iMod = math.floor((iNum/iDivisor) + 0.5)

		iUpper = iUpper + iMod
		if pCity:IsHasBuilding(iPlankhouse) then iUpper = iUpper - 2 end
		if pPlot:IsRiver() then iUpper = iUpper - 1 end

		if iUpper < 2 then iUpper = 2 end

		local iResource = tRandom[GetRandom(1, iUpper)]
		if not(iResource) then
			tSalmon[pCity] = nil
			return
		end

		tSalmon[pCity] = Sukritact_PlaceResource(pCity, iResource)
		return tSalmon[pCity]
	end
end

function CityFounded_PlaceSalmon(iPlayer, iX, iY)
	local pPlayer = Players[iPlayer]
	if (pPlayer:GetCivilizationType() ~= iCiv) then return end
	local pPlaced = PlaceSalmon(iPlayer, iX, iY)

	if pPlaced then
		local pCity = Map.GetPlot(iX, iY):GetPlotCity()
		PushNotification(pCity, pPlaced, pPlaced:GetResourceType(), pPlaced)
		LuaEvents.MC_Chinook_SalmonMigration(pCity, pPlaced)
	end
end

GameEvents.PlayerCityFounded.Add(CityFounded_PlaceSalmon)
-------------------------------------------------------------------------------------------------------------------------
-- Salmon Migration: Migrate Salmon
-------------------------------------------------------------------------------------------------------------------------
local iInterval = math.ceil(40 * ((GameInfo.GameSpeeds[Game.GetGameSpeedType()].GoldenAgePercent)/100))

function MigrateSalmon(iPlayer)
    local pPlayer = Players[iPlayer]
	if pPlayer:GetCivilizationType() ~= iCiv then return end
	local iCurrentTurn = Game.GetGameTurn()
	if (iCurrentTurn % iInterval ) == 0 then
		for pCity in pPlayer:Cities() do
			local pOldPlot = tSalmon[pCity]

			local bLocked = false
			if pOldPlot then

				-- Find Canoe
				local iNumUnits = pOldPlot:GetNumUnits()
				for iVal = 0,(iNumUnits - 1) do
					local pUnit = pOldPlot:GetUnit(iVal)
					if pUnit:IsHasPromotion(iCanoe) then
						bLocked = true
						print("Locked")
						break
					end
				end

			end

			local pPlaced = nil

			if not bLocked then
				pPlaced = PlaceSalmon(iPlayer, pCity:GetX(), pCity:GetY())
				if pOldPlot then

					local iOldRes = pOldPlot:GetResourceType()

					pOldPlot:SetImprovementType(-1)
					pOldPlot:SetResourceType(-1)
				end
			end


			if pPlaced then
				LuaEvents.MC_Chinook_SalmonMigration(pCity, pPlaced)
				PushNotification(pCity, pPlaced, pPlaced:GetResourceType(), pPlaced)
			elseif pOldPlot then
				PushNotification(pCity, pOldPlot, iOldRes)
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(MigrateSalmon)
LuaEvents.MC_Chinook_PushSalmonMigration.Add(MigrateSalmon)
--=======================================================================================================================
--=======================================================================================================================
